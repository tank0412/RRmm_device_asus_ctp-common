LOCAL_PATH:= $(call my-dir)

ifeq ($(USE_MDS_LEGACY),true)

include $(CLEAR_VARS)

LOCAL_COPY_HEADERS_TO := display

LOCAL_COPY_HEADERS := \
    include/IExtendDisplayListener.h \
    include/IMultiDisplayComposer.h \
    include/MultiDisplayClient.h \
    include/MultiDisplayComposer.h \
    include/MultiDisplayType.h \
    include/MultiDisplayService.h

include $(BUILD_COPY_HEADERS)

# ========================================================= #

include $(CLEAR_VARS)
LOCAL_SRC_FILES:= \
    MultiDisplayService.cpp \
    MultiDisplayClient.cpp \
    IMultiDisplayComposer.cpp \
    MultiDisplayComposer.cpp \
    IExtendDisplayListener.cpp

LOCAL_MODULE:= libmultidisplay
LOCAL_MODULE_TAGS := optional
LOCAL_SHARED_LIBRARIES := libui libcutils libutils libbinder
LOCAL_CFLAGS := -DLOG_TAG=\"MultiDisplay\"

ifeq ($(ENABLE_IMG_GRAPHICS),true)
    LOCAL_SRC_FILES += drm_hdmi.cpp

    LOCAL_C_INCLUDES = \
        $(TARGET_OUT_HEADERS)/libdrm \
        $(TARGET_OUT_HEADERS)/pvr/pvr2d \
        $(TARGET_OUT_HEADERS)/libttm

    LOCAL_SHARED_LIBRARIES += libdrm

    LOCAL_CFLAGS += -DENABLE_DRM
    LOCAL_CFLAGS += -DDVI_SUPPORTED
    LOCAL_SHARED_LIBRARIES += libdl
endif

LOCAL_C_INCLUDES += $(call include-path-for, frameworks-av)
include $(BUILD_SHARED_LIBRARY)

endif