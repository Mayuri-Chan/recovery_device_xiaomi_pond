#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common twrp stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from lake device
$(call inherit-product, device/xiaomi/lake/device.mk)

PRODUCT_DEVICE := lake
PRODUCT_NAME := twrp_lake
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := lake
PRODUCT_MANUFACTURER := xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="vnd_lake-user 12 SP1A.210812.016 V816.0.11.0.UGTMIXM release-keys"

BUILD_FINGERPRINT := alps/vnd_lake/lake:12/SP1A.210812.016/V816.0.11.0.UGTMIXM:user/release-keys
