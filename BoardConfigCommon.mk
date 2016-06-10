#
# Copyright 2016 The Android Open-Source Project
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

TARGET_NO_BOOTLOADER := true
TARGET_NO_RECOVERY := false
TARGET_PROVIDES_INIT_RC := false

TARGET_ARCH := x86
TARGET_ARCH_VARIANT := atom
TARGET_CPU_ABI := x86
TARGET_CPU_ABI2 := armeabi-v7a
TARGET_CPU_ABI_LIST := x86,armeabi-v7a,armeabi
TARGET_CPU_ABI_LIST_32_BIT := x86,armeabi-v7a,armeabi
KERNEL_TOOLCHAIN := $(ANDROID_BUILD_TOP)/prebuilts/gcc/linux-x86/x86/x86_64-linux-android-4.9/bin
TARGET_KERNEL_CROSS_COMPILE_PREFIX := x86_64-linux-android-
TARGET_BOARD_PLATFORM := clovertrail
TARGET_BOOTLOADER_BOARD_NAME := clovertrail
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Specific headers
TARGET_BOARD_KERNEL_HEADERS := device/asus/ctp-common/kernel-headers
TARGET_SPECIFIC_HEADER_PATH := device/asus/ctp-common/include

# ADB
BOARD_FUNCTIONFS_HAS_SS_COUNT := true

# NFC
BOARD_HAVE_NFC := false

# Audio
BOARD_USES_ALSA_AUDIO := true
BOARD_USES_TINY_ALSA_AUDIO := true
TARGET_TINY_ALSA_IGNORE_SILENCE_SIZE := true

# ALAC CODEC
USE_FEATURE_ALAC := true

# Binder API version
TARGET_USES_64_BIT_BINDER := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/asus/ctp-common/bluetooth

# Skip some proccess to speed up build
BOARD_SKIP_ANDROID_DOC_BUILD := true
BUILD_EMULATOR := false

#Touchcreen
BOARD_TOUCHSCREEN_DRIVER := synaptics_dsx

# Charger
BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_CHARGER_SHOW_PERCENTAGE := true
BOARD_HEALTHD_CUSTOM_CHARGER_RES := device/asus/ctp-common/charger/images

# Dex-preoptimization: Speeds up initial boot
WITH_DEXPREOPT := true

# Hardware
BOARD_HARDWARE_CLASS := \
	device/asus/ctp-common/cmhw \
	hardware/cyanogen/cmhw

# Healthd
BOARD_HAL_STATIC_LIBRARIES := libhealthd.clovertrail

# Houdini: enable ARM codegen for x86
BUILD_ARM_FOR_X86 := true

# IMG graphics
COMMON_GLOBAL_CFLAGS += -DASUS_ZENFONE2_LP_BLOBS
ENABLE_IMG_GRAPHICS := true
HWUI_IMG_FBO_CACHE_OPTIM := true
TARGET_INTEL_HWCOMPOSER_FORCE_ONLY_ONE_RGB_LAYER := true

# IMG Graphics: System's VSYNC phase offsets in nanoseconds
VSYNC_EVENT_PHASE_OFFSET_NS := 7500000
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 5000000

# Opengles
COMMON_GLOBAL_CFLAGS += -DFORCE_SCREENSHOT_CPU_PATH -DWORKAROUND_BUG_10194508
BOARD_EGL_CFG := device/asus/ctp-common/configs/egl.cfg

ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.opengles.version = 131072

MAX_EGL_CACHE_ENTRY_SIZE := 65536
MAX_EGL_CACHE_SIZE := 1048576
COMMON_GLOBAL_CFLAGS += -DGFX_BUF_EXT

# enabled to carry out all drawing operations performed on a View's canvas with GPU for 2D rendering pipeline.
USE_OPENGL_RENDERER := true

# Disable an optimization that causes rendering issues for us
TARGET_REQUIRES_SYNCHRONOUS_SETSURFACE := true

# Init
TARGET_INIT_VENDOR_LIB := libinit_ctp
TARGET_LIBINIT_DEFINES_FILE := device/asus/ctp-common/init/init_ctp.cpp
TARGET_INIT_UMOUNT_AND_FSCK_IS_UNSAFE := true

# Partitions
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1363148800
BOARD_FLASH_BLOCK_SIZE := 131072

# PowerHAL
TARGET_POWERHAL_VARIANT := clovertrail

# Radio
BOARD_PROVIDES_LIBRIL := true

# MultiDisplay
TARGET_USE_DUMMY_MULTIPLE_DISPLAY := false
TARGET_HAS_MULTIPLE_DISPLAY := true
USE_MDS_LEGACY := true

# Font
EXTENDED_FONT_FOOTPRINT := true

# Double-Tap-To-Wake
TARGET_TAP_TO_WAKE_NODE := "/sys/devices/pci0000:00/0000:00:00.3/i2c-0/0-0020/input/input1/dclick_mode"

# StageFright
BUILD_WITH_FULL_STAGEFRIGHT := true
ENABLE_IMG_GRAPHICS := true

# Media
TARGET_NUPLAYER_CANNOT_SET_SURFACE_WITHOUT_A_FLUSH := true
BOARD_USES_WRS_OMXIL_CORE := true
BOARD_USES_MRST_OMX := true

# Video Acceleration API for Video Encoding and Decoding
INTEL_VA := true
BOARD_USE_LIBVA := true
BOARD_USE_LIBVA_INTEL_DRIVER := true
USE_INTEL_SECURE_AVC := true

# Intel Moorestown Mix Library
BOARD_USE_LIBMIX := true

# Minikin Text Layout Engine
USE_MINIKIN := true

# HWcomposer
BOARD_USES_HWCOMPOSER := true
INTEL_HWC := true
TARGET_SUPPORT_HWC_SYS_LAYER := true

# Wi-Fi
BOARD_WLAN_DEVICE           := bcmdhd
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WPA_SUPPLICANT_VERSION      := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_HOSTAPD_DRIVER        := NL80211
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/bcm43362/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_AP      := "/system/etc/firmware/fw_bcmdhd_43362_apsta.bin"
WIFI_DRIVER_FW_PATH_STA     := "/system/etc/firmware/fw_bcmdhd_43362.bin"
WIFI_DRIVER_MODULE_ARG      := "iface_name=wlan0 firmware_path=/system/etc/firmware/fw_bcmdhd_43362.bin"

# Use the non-open-source parts, if they're present
-include vendor/asus/ctp-common/BoardConfigVendor.mk

# GPS
BOARD_HAS_GPS_HARDWARE := true
GPS_CHIP_VENDOR := bcm
GPS_CHIP := 2076

#
#ReleaseTools
#
TARGET_RECOVERY_UPDATER_LIBS += libintel_updater
TARGET_OTA_ASSERT_DEVICE := a500cg,a501cg,aicp_a500cg,aicp_a501cg,ASUS_T00F,ASUS_T00J,a600cg,aicp_a600cg,ASUS_T00G,T00F,T00F1,T00G,T00J,T00J1
USE_OSIP := true
REF_PRODUCT_NAME := redhookbay

TARGET_RECOVERY_FSTAB := device/asus/ctp-common/recovery.fstab

#TWRP
# Recovery global
#TARGET_RECOVERY_INITRC := device/asus/ctp-common/ramdisk/recovery.init.redhookbay.rc
BOARD_RECOVERY_SWIPE := true
BOARD_UMS_LUNFILE := "/sys/devices/virtual/android_usb/android0/f_mass_storage/lun/file"
#TARGET_RECOVERY_PREBUILT_KERNEL := $(PRODUCT_OUT)/kernel
# Recovery options TWRP
DEVICE_RESOLUTION := 720x1280
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_L_CRYPTO := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true
BOARD_USE_CUSTOM_RECOVERY_FONT := \"roboto_15x24.h\"
TARGET_RECOVERY_SCREEN_WIDTH := 720
TARGET_RECOVERY_SCREEN_HEIGHT := 1280
BOARD_HAS_NO_SELECT_BUTTON := true
RECOVERY_SDCARD_ON_DATA := true
TW_INTERNAL_STORAGE_PATH := "/data/media/0"
TW_INTERNAL_STORAGE_MOUNT_POINT := "/emmc"
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "/external_sd"
TW_DEFAULT_EXTERNAL_STORAGE := true
TW_EXCLUDE_SUPERSU := false
BOARD_UMS_LUNFILE := "/sys/devices/virtual/android_usb/android0/f_mass_storage/lun/file"
BOARD_SUPPRESS_EMMC_WIPE := true

# Inline kernel building
TARGET_KERNEL_BUILT_FROM_SOURCE := true
TARGET_KERNEL_SOURCE := kernel/asus/$(TARGET_DEVICE)
TARGET_KERNEL_ARCH := x86
BOARD_KERNEL_IMAGE_NAME := bzImage
TARGET_KERNEL_CONFIG := cyanogenmod_$(TARGET_DEVICE)_defconfig
KERNEL_EXTRA_FLAGS := ANDROID_TOOLCHAIN_FLAGS=-mno-android
KERNEL_SOC := ctp

# OTA Packaging / Bootimg creation
BOARD_CUSTOM_BOOTIMG := true
BOARD_CUSTOM_MKBOOTIMG := pack_intel
BOARD_CUSTOM_BOOTIMG_MK := device/asus/ctp-common/mkbootimg.mk
NEED_KERNEL_MODULE_ROOT := true
DEVICE_BASE_BOOT_IMAGE := device/asus/ctp-common/blobs/boot.img
DEVICE_BASE_RECOVERY_IMAGE := device/asus/ctp-common/blobs/recovery.img
BOARD_KERNEL_CMDLINE := init=/init pci=noearly loglevel=0 vmalloc=256M androidboot.hardware=redhookbay
BOARD_KERNEL_CMDLINE += watchdog.watchdog_thresh=60 androidboot.spid=xxxx:xxxx:xxxx:xxxx:xxxx:xxxx
BOARD_KERNEL_CMDLINE += androidboot.serialno=012345678901234567890123456789
BOARD_KERNEL_CMDLINE += snd_pcm.maximum_substreams=8 ip=50.0.0.2:50.0.0.1::255.255.255.0::usb0:on
BOARD_KERNEL_CMDLINE += debug_locks=0
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048

TARGET_RECOVERY_UPDATER_LIBS += libintel_updater
TARGET_RECOVERY_UPDATER_EXTRA_LIBS += liboempartitioning_static

# Partitions
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5277466624 ##5277483008 - 16384 // 5033MB
BOARD_CACHEIMAGE_PARTITION_SIZE := 519045120 # // 495MB
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1320157184 # // 1259MB
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE     := 17825792
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 17825792

#ALAC CODEC
USE_FEATURE_ALAC := true

#CPU-sets
ENABLE_CPUSETS := true

# Turn on genarate changelog om repo
MAKE_CHANGELOG := true
