#
# Copyright (C) 2016 The CyanogenMod Project
#               2017-2019 The LineageOS Project
#               2020 The exTHmUI Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

TARGET_GENERATED_BOOTANIMATION := $(TARGET_OUT_INTERMEDIATES)/BOOTANIMATION/bootanimation.zip
TARGET_GENERATED_BOOTANIMATION_DARK := $(TARGET_OUT_INTERMEDIATES)/BOOTANIMATION_DARK/bootanimation-dark.zip
$(TARGET_GENERATED_BOOTANIMATION): INTERMEDIATES := $(TARGET_OUT_INTERMEDIATES)/BOOTANIMATION
$(TARGET_GENERATED_BOOTANIMATION_DARK): INTERMEDIATES_DARK := $(TARGET_OUT_INTERMEDIATES)/BOOTANIMATION_DARK

$(TARGET_GENERATED_BOOTANIMATION): $(SOONG_ZIP)
	@echo "Building bootanimation.zip"
	@rm -rf $(dir $@)
	@mkdir -p $(dir $@)
	$(hide) tar xfp vendor/exthm/bootanimation/bootanimation.tar -C $(INTERMEDIATES)
	$(hide) if [ $(TARGET_SCREEN_HEIGHT) -lt $(TARGET_SCREEN_WIDTH) ]; then \
	    IMAGEWIDTH=$(TARGET_SCREEN_HEIGHT); \
	else \
	    IMAGEWIDTH=$(TARGET_SCREEN_WIDTH); \
	fi; \
	IMAGESCALEWIDTH=$$IMAGEWIDTH; \
	IMAGESCALEHEIGHT=$$(expr $$IMAGESCALEWIDTH / 3); \
	if [ "$(TARGET_BOOTANIMATION_HALF_RES)" = "true" ]; then \
	    IMAGEWIDTH="$$(expr "$$IMAGEWIDTH" / 2)"; \
	fi; \
	IMAGEHEIGHT=$$(expr $$IMAGEWIDTH / 3); \
	RESOLUTION="$$IMAGEWIDTH"x"$$IMAGEHEIGHT"; \
	for part_cnt in 0 1 2 3 4; do \
	    mkdir -p $(INTERMEDIATES)/part$$part_cnt; \
	done; \
	vendor/exthm/prebuilt/bin/mogrify -resize $$RESOLUTION -colors 250 $(INTERMEDIATES)/part0/*.png; \
	vendor/exthm/prebuilt/bin/mogrify -resize $$RESOLUTION -colors 250 $(INTERMEDIATES)/part1/*.png; \
	vendor/exthm/prebuilt/bin/mogrify -resize $$RESOLUTION -colors 250 $(INTERMEDIATES)/part2/*.png; \
	vendor/exthm/prebuilt/bin/mogrify -resize $$RESOLUTION -colors 250 $(INTERMEDIATES)/part3/*.png; \
	vendor/exthm/prebuilt/bin/mogrify -resize $$RESOLUTION -colors 250 $(INTERMEDIATES)/part4/*.png; \
	echo "$$IMAGESCALEWIDTH $$IMAGESCALEHEIGHT 60" > $(INTERMEDIATES)/desc.txt; \
	cat vendor/exthm/bootanimation/desc.txt >> $(INTERMEDIATES)/desc.txt
	$(hide) $(SOONG_ZIP) -L 0 -o $(TARGET_GENERATED_BOOTANIMATION) -C $(INTERMEDIATES) -D $(INTERMEDIATES)

$(TARGET_GENERATED_BOOTANIMATION_DARK): $(SOONG_ZIP)
	@echo "Building bootanimation-dark.zip"
	@rm -rf $(dir $@)
	@mkdir -p $(dir $@)
	$(hide) tar xfp vendor/exthm/bootanimation/bootanimation-dark.tar -C $(INTERMEDIATES_DARK)
	$(hide) if [ $(TARGET_SCREEN_HEIGHT) -lt $(TARGET_SCREEN_WIDTH) ]; then \
	    IMAGEWIDTH=$(TARGET_SCREEN_HEIGHT); \
	else \
	    IMAGEWIDTH=$(TARGET_SCREEN_WIDTH); \
	fi; \
	IMAGESCALEWIDTH=$$IMAGEWIDTH; \
	IMAGESCALEHEIGHT=$$(expr $$IMAGESCALEWIDTH / 3); \
	if [ "$(TARGET_BOOTANIMATION_HALF_RES)" = "true" ]; then \
	    IMAGEWIDTH="$$(expr "$$IMAGEWIDTH" / 2)"; \
	fi; \
	IMAGEHEIGHT=$$(expr $$IMAGEWIDTH / 3); \
	RESOLUTION="$$IMAGEWIDTH"x"$$IMAGEHEIGHT"; \
	for part_cnt in 0 1 2 3 4; do \
	    mkdir -p $(INTERMEDIATES_DARK)/part$$part_cnt; \
	done; \
	vendor/exthm/prebuilt/bin/mogrify -resize $$RESOLUTION -colors 250 $(INTERMEDIATES_DARK)/part0/*.png; \
	vendor/exthm/prebuilt/bin/mogrify -resize $$RESOLUTION -colors 250 $(INTERMEDIATES_DARK)/part1/*.png; \
	vendor/exthm/prebuilt/bin/mogrify -resize $$RESOLUTION -colors 250 $(INTERMEDIATES_DARK)/part2/*.png; \
	vendor/exthm/prebuilt/bin/mogrify -resize $$RESOLUTION -colors 250 $(INTERMEDIATES_DARK)/part3/*.png; \
	echo "$$IMAGESCALEWIDTH $$IMAGESCALEHEIGHT 60" > $(INTERMEDIATES_DARK)/desc.txt; \
	cat vendor/exthm/bootanimation/desc_dark.txt >> $(INTERMEDIATES_DARK)/desc.txt
	$(hide) $(SOONG_ZIP) -L 0 -o $(TARGET_GENERATED_BOOTANIMATION_DARK) -C $(INTERMEDIATES_DARK) -D $(INTERMEDIATES_DARK)

ifeq ($(TARGET_BOOTANIMATION),)
    TARGET_BOOTANIMATION := $(TARGET_GENERATED_BOOTANIMATION)
endif

ifeq ($(TARGET_BOOTANIMATION_DARK),)
    TARGET_BOOTANIMATION_DARK := $(TARGET_GENERATED_BOOTANIMATION_DARK)
endif

include $(CLEAR_VARS)
LOCAL_MODULE := bootanimation.zip
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_PRODUCT)/media

include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): $(TARGET_BOOTANIMATION)
	@cp $(TARGET_BOOTANIMATION) $@

include $(CLEAR_VARS)
LOCAL_MODULE := bootanimation-dark.zip
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_PRODUCT)/media

include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): $(TARGET_BOOTANIMATION_DARK)
	@cp $(TARGET_BOOTANIMATION_DARK) $@