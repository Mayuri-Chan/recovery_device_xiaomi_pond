#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

sudo apt install ccache -y
export USE_CCACHE=1
export CCACHE_EXEC=$(command -v ccache)
ccache -M 5G 
