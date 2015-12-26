LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := cocosbuilder_static

LOCAL_MODULE_FILENAME := libcocosbuilder

LOCAL_SRC_FILES := ../../../../prebuilt/android/$(TARGET_ARCH_ABI)/libcocosbuilder.a

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../..


LOCAL_WHOLE_STATIC_LIBRARIES := cocos_extension_static

include $(PREBUILT_STATIC_LIBRARY)
