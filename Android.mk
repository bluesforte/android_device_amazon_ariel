#ifneq ($(filter ariel, $(TARGET_PRODUCT)),)

LOCAL_PATH := $(call my-dir)

$(info Compiling ariel modules...)

include $(call all-makefiles-under,$(LOCAL_PATH))

#endif
