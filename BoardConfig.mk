# Copyright (C) 2017-2023 The Android Open Source Project
# Copyright (C) 2014-2023 The Team Win LLC
# SPDX-License-Identifier: Apache-2.0

# Device Path
DEVICE_PATH := device/xiaomi/pond

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# Build Hack
BUILD_BROKEN_DUP_RULES := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := $(TARGET_ARCH_VARIANT)
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := $(TARGET_CPU_VARIANT)
TARGET_2ND_CPU_VARIANT_RUNTIME := $(TARGET_CPU_VARIANT)

# Assertation
TARGET_OTA_ASSERT_DEVICE := lake,lake_p,pond,pond_p

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := lake
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# Platform
TARGET_BOARD_PLATFORM := mt6768

# Kernel
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64

BOARD_VENDOR_CMDLINE      := bootopt=64S3,32N2,64N2
BOARD_PAGE_SIZE           := 4096
BOARD_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_BASE         := 0x40078000
BOARD_KERNEL_OFFSET       := 0x00008000
BOARD_RAMDISK_OFFSET      := 0x07c08000
BOARD_TAGS_OFFSET         := 0x0bc08000
BOARD_DTB_OFFSET          := 0x0bc08000

TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel

BOARD_MKBOOTIMG_ARGS += \
	--dtb $(TARGET_PREBUILT_DTB) \
	--vendor_cmdline $(BOARD_VENDOR_CMDLINE) \
	--pagesize $(BOARD_PAGE_SIZE) --board "" \
	--kernel_offset $(BOARD_KERNEL_OFFSET) \
	--ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
	--tags_offset $(BOARD_TAGS_OFFSET) \
	--header_version $(BOARD_BOOT_HEADER_VERSION) \
	--dtb_offset $(BOARD_DTB_OFFSET)

BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_RAMDISK_USE_LZ4 := true

# VNDK
BOARD_VNDK_VERSION := current

# AVB
BOARD_AVB_ENABLE := true

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864

# Dynamic Partition
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := main
BOARD_MAIN_SIZE := 9122611200 # (BOARD_SUPER_PARTITION_SIZE - 4194304) 4MiB
BOARD_MAIN_PARTITION_LIST := system system_ext product vendor

TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM := system
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor

BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_ROOT_EXTRA_FOLDERS += metadata cust
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# System as root
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false

# Init
TARGET_INIT_VENDOR_LIB := //$(DEVICE_PATH):libinit_pond
TARGET_RECOVERY_DEVICE_MODULES := libinit_pond

# Recovery
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_SUPPRESS_SECURE_ERASE := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab

# vendor_boot recovery ramdisk
TARGET_NO_RECOVERY := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE :=
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT :=

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_METADATA_PARTITION := true
TW_USE_FSCRYPT_POLICY := 2

# Encryption
PLATFORM_VERSION := 99
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# TWRP Configuration
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TW_MAX_BRIGHTNESS := 255
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_CUSTOM_CPU_TEMP_PATH := "/sys/class/thermal/thermal_zone28/temp"
TW_EXCLUDE_APEX := true
TW_EXCLUDE_TWRPAPP := true
TW_BACKUP_EXCLUSIONS := /data/fonts/files
TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true
TW_HAS_MTP := true

# For USB OTG
TW_EXCLUDE_DEFAULT_USB_INIT := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.usb0/lun.%d/file

# Filesystem tools
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_FUSE_EXFAT := true
TW_INCLUDE_FUSE_NTFS := true
TARGET_USES_MKE2FS := true

# Haptic
TW_SUPPORT_INPUT_AIDL_HAPTICS := true
TW_SUPPORT_INPUT_AIDL_HAPTICS_FQNAME := "IVibrator/default"

# Display
TW_NO_SCREEN_BLANK := true

# UI
TW_THEME := portrait_hdpi
TW_FRAMERATE := 60
TW_STATUS_ICONS_ALIGN := center
TW_CUSTOM_CPU_POS := 50
TW_CUSTOM_CLOCK_POS := 300
TW_CUSTOM_BATTERY_POS := 800

# Handle /data/media
RECOVERY_SDCARD_ON_DATA := true

# TWRP binaries tools
TW_EXCLUDE_NANO := true
TW_INCLUDE_LPDUMP := true
TW_INCLUDE_LPTOOLS := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP := true
TW_INCLUDE_REPACKTOOLS := true

# Debug
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true

TW_LOAD_VENDOR_BOOT_MODULES := true
TW_LOAD_VENDOR_MODULES_EXCLUDE_GKI := true
TW_LOAD_VENDOR_MODULES := "mt6358-accdet.ko xiaomi_touch.ko lct_tp.ko nt36528_spi.ko nt36528_spi.ko ft8057m_spi.ko ft8057p_spi.ko icnl9916_spi.ko"

# Maintainer
TW_DEVICE_VERSION := wulan17
