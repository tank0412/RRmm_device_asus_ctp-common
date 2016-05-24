# Copyright (C) 2016 The CyanogenMod Project
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

# This is a custom bootimage target file to be used on CM
# Set these variables on your BoardConfig.mk
#
# DEVICE_BASE_BOOT_IMAGE := path/to/stuff/existingboot.img
# DEVICE_BASE_RECOVERY_IMAGE := path/to/stuff/existingrecovery.img
# BOARD_CUSTOM_BOOTIMG_MK := path/to/intel-boot-tools/boot.mk
#

BASE_BOOT_IMAGE := $(DEVICE_BASE_BOOT_IMAGE)
BASE_RECOVERY_IMAGE := $(DEVICE_BASE_RECOVERY_IMAGE)

cmdline := $(PRODUCT_OUT)/cmdline

$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) \
		$(recovery_kernel) \
		$(recovery_ramdisk)
	$(call pretty,"Target recovery image: $@")
	@echo -e ${CL_CYN}"----- Making recovery osimage ------"${CL_RST}
	@echo -e ${CL_CYN}"----- checking cmdline ------"${CL_RST}
	@echo $(BOARD_KERNEL_CMDLINE) > $(PRODUCT_OUT)/cmdline
	$(MKBOOTIMG) $(BASE_RECOVERY_IMAGE) $(recovery_kernel) $(recovery_ramdisk) $(cmdline) $@
	@echo -e ${CL_CYN}"Made recovery image: $@"${CL_RST}
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE))

$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) \
		$(INSTALLED_KERNEL_TARGET) \
		$(INSTALLED_RAMDISK_TARGET)
	$(call pretty,"Target boot image: $@")
	@echo -e ${CL_CYN}"----- Making boot ramdisk ------"${CL_RST}
	$(MKBOOTFS) $(TARGET_ROOT_OUT) | $(MINIGZIP) > $(INSTALLED_RAMDISK_TARGET)
	@echo -e ${CL_CYN}"----- checking cmdline ------"${CL_RST}
	@echo $(BOARD_KERNEL_CMDLINE) > $(PRODUCT_OUT)/cmdline
	@echo -e ${CL_CYN}"----- Making boot osimage ------"${CL_RST}
	$(MKBOOTIMG) $(BASE_BOOT_IMAGE) $(INSTALLED_KERNEL_TARGET) $(INSTALLED_RAMDISK_TARGET) $(cmdline) $@
	@echo -e ${CL_CYN}"Made boot image: $@"${CL_RST}
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE))
