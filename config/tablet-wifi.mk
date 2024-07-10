#
# Copyright (C) 2022 The exTHmUI Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit common exTHmUI stuff
$(call inherit-product, vendor/exthm/config/common.mk)

# Inherit Window Extensions
$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Telephony packages
PRODUCT_PACKAGES += \
    Updater
