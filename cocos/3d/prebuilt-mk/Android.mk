LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := cocos3d_static

LOCAL_MODULE_FILENAME := libcocos3d

LOCAL_SRC_FILES := ../../../prebuilt/android/$(TARGET_ARCH_ABI)/libcocos3d.a

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../..


LOCAL_WHOLE_STATIC_LIBRARIES := cocos2dx_internal_static

include $(PREBUILT_STATIC_LIBRARY)
