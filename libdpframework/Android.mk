#
# Copyright (C) 2008 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# from: http://forum.xda-developers.com/showpost.php?p=63840429&postcount=11
LOCAL_PATH := $(call my-dir)

########################

include $(CLEAR_VARS)
LOCAL_MODULE := libdpframework
LOCAL_SRC_FILES := libdpframework.so
LOCAL_SHARED_LIBRARIES := \
    libdpframework_os \
    libdpframework_plat
LOCAL_EXPORT_C_INCLUDES := include
$(info Build libdpframework...)
include $(PREBUILT_SHARED_LIBRARY)

########################


# libdpframework_os.so
include $(CLEAR_VARS)

LOCAL_MODULE:= libdpframework_os
LOCAL_SRC_FILES:= libdpframework_os.so
#~ LOCAL_EXPORT_C_INCLUDES:= $(LOCAL_PATH)/inc
LOCAL_MODULE_SUFFIX:= .so
LOCAL_MODULE_TAGS := optional

$(info Build libdpframework_os...)

include $(PREBUILT_SHARED_LIBRARY)


# libdpframework_plat.so
include $(CLEAR_VARS)

LOCAL_MODULE:= libdpframework_plat
LOCAL_SRC_FILES:= libdpframework_plat.so
#~ LOCAL_EXPORT_C_INCLUDES:= $(LOCAL_PATH)/inc
LOCAL_MODULE_SUFFIX:= .so
LOCAL_MODULE_TAGS := optional

$(info Build libdpframework_plat...)

include $(PREBUILT_SHARED_LIBRARY)
