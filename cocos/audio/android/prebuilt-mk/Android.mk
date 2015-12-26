LOCAL_PATH := $(call my-dir)

#New AudioEngine
include $(CLEAR_VARS)

LOCAL_MODULE := audioengine_static

LOCAL_MODULE_FILENAME := libaudioengine

LOCAL_SRC_FILES := ../../../../prebuilt/android/$(TARGET_ARCH_ABI)/libaudioengine.a

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../include

LOCAL_EXPORT_LDLIBS := -lOpenSLES


include $(PREBUILT_STATIC_LIBRARY)

#SimpleAudioEngine
include $(CLEAR_VARS)

LOCAL_MODULE := cocosdenshion_static

LOCAL_MODULE_FILENAME := libcocosdenshion

LOCAL_SRC_FILES := ../../../../prebuilt/android/$(TARGET_ARCH_ABI)/libcocosdenshion.a

LOCAL_WHOLE_STATIC_LIBRARIES := audioengine_static
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../include


include $(PREBUILT_STATIC_LIBRARY)
