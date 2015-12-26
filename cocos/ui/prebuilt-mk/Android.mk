LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := cocos_ui_static

LOCAL_MODULE_FILENAME := libui

ifeq ($(USE_ARM_MODE),1)
LOCAL_ARM_MODE := arm
endif

LOCAL_SRC_FILES := ../../../prebuilt/android/$(TARGET_ARCH_ABI)/libui.a
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../editor-support


LOCAL_WHOLE_STATIC_LIBRARIES := cocos_extension_static

include $(PREBUILT_STATIC_LIBRARY)
