IMX214_CHROMATIX_SNAPSHOT_PATH := $(call my-dir)

# ---------------------------------------------------------------------------
#                      Make the shared library (libchromatix_imx214_video_hdr)
# ---------------------------------------------------------------------------

include $(CLEAR_VARS)
LOCAL_PATH := $(IMX214_CHROMATIX_SNAPSHOT_PATH)
LOCAL_MODULE_TAGS := optional

LOCAL_CFLAGS:= -DAMSS_VERSION=$(AMSS_VERSION) \
        $(mmcamera_debug_defines) \
        $(mmcamera_debug_cflags) \
        -include camera_defs_i.h

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../../
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../../module/
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../../../../../../common/
LOCAL_C_INCLUDES += chromatix_imx214_snapshot_hdr.h

LOCAL_SRC_FILES:= chromatix_imx214_snapshot_hdr.c

LOCAL_MODULE           := libchromatix_imx214_snapshot_hdr
LOCAL_SHARED_LIBRARIES := libcutils
include $(LOCAL_PATH)/../../../../../../../../../local_additional_dependency.mk

ifeq ($(MM_DEBUG),true)
LOCAL_SHARED_LIBRARIES += liblog
endif

LOCAL_MODULE_OWNER := qcom
LOCAL_PROPRIETARY_MODULE := true

include $(BUILD_SHARED_LIBRARY)
