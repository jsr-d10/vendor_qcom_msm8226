# ---------------------------------------------------------------------------
#                  Make the shared library (libmmcamera_cpp)
# ---------------------------------------------------------------------------

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := optional

PPROC_MODULE_PATH := $(LOCAL_PATH)/../../pproc-new
MM_CAMERA_PATH := $(LOCAL_PATH)/../../../../../mm-camera2
HAL_PATH := $(LOCAL_PATH)/../../../../../../../../../hardware/qcom/camera


LOCAL_C_INCLUDES += $(LOCAL_PATH)
LOCAL_C_INCLUDES += $(PPROC_MODULE_PATH)
LOCAL_C_INCLUDES += $(MM_CAMERA_PATH)/includes
LOCAL_C_INCLUDES += $(MM_CAMERA_PATH)/server-tuning/tuning/
LOCAL_C_INCLUDES += $(MM_CAMERA_PATH)/media-controller/includes
LOCAL_C_INCLUDES += $(MM_CAMERA_PATH)/media-controller/mct/tools
LOCAL_C_INCLUDES += $(MM_CAMERA_PATH)/media-controller/mct/port
LOCAL_C_INCLUDES += $(MM_CAMERA_PATH)/media-controller/mct/object
LOCAL_C_INCLUDES += $(MM_CAMERA_PATH)/media-controller/mct/event
LOCAL_C_INCLUDES += $(MM_CAMERA_PATH)/media-controller/mct/bus
LOCAL_C_INCLUDES += $(MM_CAMERA_PATH)/media-controller/mct/module
LOCAL_C_INCLUDES += $(MM_CAMERA_PATH)/media-controller/mct/stream
LOCAL_C_INCLUDES += $(MM_CAMERA_PATH)/media-controller/mct/pipeline
LOCAL_C_INCLUDES += $(MM_CAMERA_PATH)/media-controller/modules/includes
LOCAL_C_INCLUDES += $(MM_CAMERA_PATH)/media-controller/modules/sensors/chromatix/$(CHROMATIX_VERSION)
LOCAL_C_INCLUDES += $(HAL_PATH)/QCamera2/stack/common
LOCAL_C_INCLUDES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include

LOCAL_CFLAGS:= -DAMSS_VERSION=$(AMSS_VERSION) \
				$(mmcamera_debug_defines) \
				$(mmcamera_debug_cflags)

ifeq ($(call is-board-platform-in-list,msm8226 msm8610),true)
  LOCAL_CFLAGS += -DCAMERA_FEATURE_WNR_SW
endif

ifeq ($(MM_CAMERA_JB), true)
  LOCAL_CFLAGS += -DMM_CAMERA_JB
endif

LOCAL_SRC_FILES := cpp_module.c
LOCAL_SRC_FILES += cpp_module_events.c
LOCAL_SRC_FILES += cpp_module_util.c
LOCAL_SRC_FILES += cpp_port.c
LOCAL_SRC_FILES += cpp_thread.c
LOCAL_SRC_FILES += cpp_hardware.c
LOCAL_SRC_FILES += cpp_hw_params.c

LOCAL_MODULE           := libmmcamera2_cpp_module
LOCAL_SHARED_LIBRARIES := libcutils liboemcamera

ifeq ($(MM_DEBUG),true)
LOCAL_SHARED_LIBRARIES += liblog
endif
LOCAL_MODULE_TAGS      := optional eng
LOCAL_ADDITIONAL_DEPENDENCIES  := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
LOCAL_MODULE_OWNER := qcom
LOCAL_PROPRIETARY_MODULE := true

include $(BUILD_SHARED_LIBRARY)

# -------- for firmware ---------- #
LOCAL_PATH:= $(LOCAL_DIR_PATH)
include $(PPROC_MODULE_PATH)/cpp/firmware/Android.mk
include $(call all-subdir-makefiles)
