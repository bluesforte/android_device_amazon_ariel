#~ LOCAL_PATH:= $(call my-dir)
#~ include $(CLEAR_VARS)

#~ LOCAL_SRC_FILES:=                     \
#~         OMXNodeInstanceBufferHandler.cpp \
#~ 	OMXNodeInstanceBufferHandler.h

#~ LOCAL_C_INCLUDES:= \
#~         $(TOP)/frameworks/av/include/media/stagefright/timedtext \
#~ 	$(TOP)/frameworks/av/media/libstagefright/include \
#~ 	$(TOP)/frameworks/native/include/media/openmax \
#~         $(TOP)/frameworks/native/include/media/hardware \
#~         $(TOP)/frameworks/native/services/connectivitymanager \
#~         $(TOP)/external/flac/include \
#~         $(TOP)/external/tremolo \
#~         $(TOP)/external/openssl/include \

#~ LOCAL_MODULE:= libstagefright_bufferallocator

#~ $(info Build libstagefright_bufferallocator...)
#~ include $(BUILD_STATIC_LIBRARY)

#~ ################################################################################

#~ include $(call all-makefiles-under,$(LOCAL_PATH))
