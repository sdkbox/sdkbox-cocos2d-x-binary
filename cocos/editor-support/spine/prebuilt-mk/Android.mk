LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := spine_static

LOCAL_MODULE_FILENAME := libspine

LOCAL_SRC_FILES := ../../../../prebuilt/android/$(TARGET_ARCH_ABI)/libspine.a

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../..


LOCAL_WHOLE_STATIC_LIBRARIES := cocos2dx_internal_static

include $(PREBUILT_STATIC_LIBRARY)
