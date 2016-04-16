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

$(call inherit-product-if-exists, frameworks/native/build/phone-xxhdpi-2048-dalvik-heap.mk)
$(call inherit-product-if-exists, frameworks/native/build/phone-xxhdpi-2048-hwui-memory.mk)

DEVICE_PACKAGE_OVERLAYS := \
	device/asus/ctp-common/overlay

# ART
PRODUCT_PROPERTY_OVERRIDES += \
	dalvik.vm.dex2oat-swap=false

# ASUS properties
PRODUCT_PROPERTY_OVERRIDES += \
	ro.build.asus.sku=WW

# PC Link Manager
PRODUCT_PACKAGES += \
	PCLinkManager

# Audio
PRODUCT_PACKAGES += \
	audio.a2dp.default \
	audio.r_submix.default \
	audio.usb.default \
	audio.primary.redhookbay \
	libatv_audio \
	libaudiopolicymanager

PRODUCT_COPY_FILES += \
	device/asus/ctp-common/audio/asound.conf:system/etc/asound.conf \
	device/asus/ctp-common/audio/audio_policy.conf:system/etc/audio_policy.conf \
	device/asus/ctp-common/audio/route_criteria.conf:system/etc/route_criteria.conf

# Bluetooth
PRODUCT_COPY_FILES += \
	device/asus/ctp-common/bluetooth/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf

# Camera
PRODUCT_PACKAGES += \
	Snap \
	bspcapability

# Health Deamon
PRODUCT_PACKAGES += \
	libhealthd.clovertrail

# Dalvik
PRODUCT_PROPERTY_OVERRIDES += \
	ro.dalvik.vm.isa.arm=x86 \
	dalvik.vm.implicit_checks=none

PRODUCT_COPY_FILES += \
	device/asus/ctp-common/powervr.ini:system/etc/powervr.ini

# Houdini (arm native bridge)
PRODUCT_PROPERTY_OVERRIDES += \
	ro.enable.native.bridge.exec=1 \
	ro.dalvik.vm.native.bridge=libhoudini.so

# Frameworks
PRODUCT_PACKAGES += \
	com.asus.fm \
	com.asus.fm.xml \
	com.broadcom.bt \
	com.broadcom.bt.xml \
	com.intel.config \
	com.intel.config.xml \
	com.intel.widi.sink \
	com.intel.widi.sink.xml

# MmgrClient, OemTelephonyApp and SARManager
PRODUCT_PACKAGES += \
	com.intel.internal.telephony.MmgrClient.xml \
	com.intel.internal.telephony.MmgrClient

# Keystore
PRODUCT_PACKAGES += \
	keystore.clovertrail

# Media
PRODUCT_PROPERTY_OVERRIDES += \
	drm.service.enabled=true \
	ro.com.widevine.cachesize=16777216 \
	media.stagefright.cache-params=10240/20480/15 \
	media.aac_51_output_enabled=true

PRODUCT_COPY_FILES += \
	device/asus/ctp-common/media/media_codecs.xml:system/etc/media_codecs.xml \
	device/asus/ctp-common/media/media_profiles.xml:system/etc/media_profiles.xml \
	device/asus/ctp-common/media/wrs_omxil_components.list:system/etc/wrs_omxil_components.list \
	frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
	frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml

# Media: SDK and OMX IL components
PRODUCT_PACKAGES += \
	msvdx_bin \
	topaz_bin

# PowerHAL
PRODUCT_PACKAGES += \
	power.clovertrail

# RIL
PRODUCT_PROPERTY_OVERRIDES += \
	ro.ril.status.polling.enable=0 \
	rild.libpath=/system/lib/librapid-ril-core.so \
	ro.ril.telephony.mqanelements=5 \
	ro.telephony.ril.config=simactivation,sim2gsmonly \
	ro.telephony.default_network=0,0

PRODUCT_PACKAGES += \
	radiooptions \
	libril \
	libreference-ril

PRODUCT_COPY_FILES += \
	device/asus/ctp-common/configs/sensor_hal_config_default.xml:system/etc/sensor_hal_config_default.xml

# DRM Library
PRODUCT_PACKAGES += \
	libdrm \
	liblog \
	dristat \
	drmstat

# Marshmallow Compatibility Library
PRODUCT_PACKAGES += \
	libmmcompat

# MultiDisplay
PRODUCT_PACKAGES += \
	com.intel.multidisplay \
	com.intel.multidisplay.xml \
	libmultidisplay \
	libmultidisplayjni

# Permissions
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
	frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
	frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
	frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
	frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
	frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
	frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml

# Wi-Fi
PRODUCT_PACKAGES += \
	libwpa_client \
	lib_driver_cmd_bcmdhd \
	hostapd \
	dhcpcd.conf \
	wpa_supplicant \
	wpa_supplicant.conf

# TinyAlsa Binaries
PRODUCT_PACKAGES += \
	tinycap \
	tinymix \
	tinyplay

# Video Acceleration API for Video Encoding and Decoding
PRODUCT_PACKAGES += \
	libva \
	libva-android \
	libva-tpi \
	libva_videoencoder \
	libva_videodecoder

# Window Space Buffer Manager Library
PRODUCT_PACKAGES += \
	libwsbm

# OpenMAX Video Encoders/Decoders
PRODUCT_PACKAGES += \
	libOMXVideoDecoderAVC \
	libOMXVideoDecoderAVCSecure \
	libOMXVideoDecoderH263 \
	libOMXVideoDecoderMPEG4 \
	libOMXVideoDecoderWMV \
	libOMXVideoEncoderAVC \
	libOMXVideoEncoderH263 \
	libOMXVideoEncoderMPEG4

# OpenMAX Interaction Layer Implementation for Intel VA API
PRODUCT_PACKAGES += \
	wrs_omxil_core \
	libwrs_omxil_core \
	libwrs_omxil_core_pvwrapped

# StageFright Hardware Decoding
PRODUCT_PACKAGES += \
	libstagefrighthw

PRODUCT_COPY_FILES += \
	device/asus/ctp-common/configs/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf

# stlport required for our LP blobs
PRODUCT_PACKAGES += \
	libstlport

# Features removed from "user" builds
PRODUCT_PACKAGES += \
	su \
	screencap \
	procmem \
	procrank

$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4339/device-bcm.mk)
$(call inherit-product-if-exists, vendor/asus/ctp-common/ctp-common-vendor.mk)
