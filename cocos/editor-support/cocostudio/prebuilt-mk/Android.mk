LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := cocostudio_static

LOCAL_MODULE_FILENAME := libcocostudio

LOCAL_SRC_FILES := ../../../../prebuilt/android/$(TARGET_ARCH_ABI)/libcocostudio.a


LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../..


LOCAL_CFLAGS += -fexceptions

LOCAL_WHOLE_STATIC_LIBRARIES := cocos_ui_static
LOCAL_WHOLE_STATIC_LIBRARIES += cocosdenshion_static
LOCAL_WHOLE_STATIC_LIBRARIES += cocos_flatbuffers_static

include $(PREBUILT_STATIC_LIBRARY)
