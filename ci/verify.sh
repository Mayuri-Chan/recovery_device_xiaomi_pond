#!/usr/bin/env bash
set -euo pipefail

DEVICE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AOSP_ROOT="${AOSP_ROOT:-$(cd "$DEVICE_DIR/../../.." && pwd)}"
OUT_DIR="$AOSP_ROOT/out/target/product/pond"
IMAGE="$OUT_DIR/vendor_boot.img"
UNPACKER="$AOSP_ROOT/system/tools/mkbootimg/unpack_bootimg.py"
EXPECTED_VERMAGIC='6.6.118-android15-8-gcfd5fd50b0bc-4k'
PARTITION_MAX=$((64 * 1024 * 1024))

[[ -f "$IMAGE" ]] || { echo "Missing image: $IMAGE" >&2; exit 1; }
[[ -f "$UNPACKER" ]] || { echo "Missing unpack_bootimg.py: $UNPACKER" >&2; exit 1; }

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT
python3 "$UNPACKER" --boot_img "$IMAGE" --out "$TMP_DIR/unpacked" | tee "$TMP_DIR/bootimg-info.txt"

INFO="$TMP_DIR/bootimg-info.txt"
grep -Eq 'vendor boot image header version: 4([[:space:]]|$)' "$INFO"
grep -Eq 'page size: 0x0*1000([[:space:]]|$)' "$INFO"
python3 - "$INFO" <<'PY'
import re
import sys

text = open(sys.argv[1], encoding="utf-8").read()
entry = re.search(
    r"vendor_ramdisk\d+:\s*\{(?:(?!^\s*\}).)*?type:\s*0x0*2\s*\n\s*name:\s*recovery\b",
    text,
    re.MULTILINE | re.DOTALL,
)
if not entry:
    raise SystemExit("No vendor ramdisk entry named recovery with type RECOVERY (2)")
print("Verified vendor ramdisk fragment: recovery, type RECOVERY (2)")
PY

DTB="$TMP_DIR/unpacked/dtb"
[[ -f "$DTB" ]] || { echo "Unpacked vendor_boot has no DTB" >&2; exit 1; }
cmp "$DTB" "$DEVICE_DIR/prebuilt/dtb.img"
echo "Verified built DTB matches device-tree prebuilt/dtb.img"

mapfile -d '' MODULES < <(find \
    "$DEVICE_DIR/recovery/root/lib/modules" \
    "$DEVICE_DIR/recovery/root/vendor/lib/modules" \
    -type f -name '*.ko' -print0)
((${#MODULES[@]} > 0)) || { echo "No bundled kernel modules found" >&2; exit 1; }

bad_count=0
for module in "${MODULES[@]}"; do
    vermagic="$(strings -a "$module" | sed -n 's/^vermagic=//p' | tail -n 1)"
    if [[ "$vermagic" != "$EXPECTED_VERMAGIC"* ]]; then
        if ((bad_count == 0)); then
            echo "Kernel module vermagic mismatch (expected prefix: $EXPECTED_VERMAGIC):" >&2
        fi
        printf '  %s: %s\n' "${module#"$DEVICE_DIR"/}" "${vermagic:-<missing>}" >&2
        ((bad_count += 1))
    fi
done
((bad_count == 0)) || { echo "$bad_count of ${#MODULES[@]} modules do not match the target kernel" >&2; exit 1; }
echo "Verified vermagic for ${#MODULES[@]} kernel modules"

image_size="$(stat -c '%s' "$IMAGE")"
((image_size <= PARTITION_MAX)) || { echo "vendor_boot.img is $image_size bytes; partition limit is $PARTITION_MAX" >&2; exit 1; }
echo "OK: vendor_boot.img is $image_size bytes (limit: $PARTITION_MAX) and all recovery, DTB, and module checks passed"
