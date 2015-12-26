LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := cocos_network_static

LOCAL_MODULE_FILENAME := libnetwork

LOCAL_SRC_FILES := ../../../prebuilt/android/$(TARGET_ARCH_ABI)/libnetwork.a

LOCAL_EXPORT_C_INCLUDES :=


LOCAL_WHOLE_STATIC_LIBRARIES := cocos2dx_internal_static
LOCAL_WHOLE_STATIC_LIBRARIES += cocos_curl_static
LOCAL_WHOLE_STATIC_LIBRARIES += libwebsockets_static

include $(PREBUILT_STATIC_LIBRARY)
