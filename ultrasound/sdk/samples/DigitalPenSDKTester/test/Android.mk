LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := tests
LOCAL_CERTIFICATE := platform
LOCAL_PROGUARD_ENABLED := disabled

LOCAL_STATIC_JAVA_LIBRARIES := DigitalPenSDK
LOCAL_JAVA_LIBRARIES := android.test.runner

LOCAL_SRC_FILES := $(call all-java-files-under, src)

LOCAL_PACKAGE_NAME := DigitalPenSDKTesterTest

LOCAL_INSTRUMENTATION_FOR := DigitalPenSDKTester

include $(BUILD_PACKAGE)
