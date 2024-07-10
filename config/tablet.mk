#
# Copyright (C) 2022 The exTHmUI Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit common exTHmUI stuff
$(call inherit-product, vendor/exthm/config/tablet-wifi.mk)

# Telephony packages
PRODUCT_PACKAGES += \
    messaging \
    Stk \
    YellowPage