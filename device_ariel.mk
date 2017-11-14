

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/amazon/ariel/ariel-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/amazon/ariel/overlay

LOCAL_PATH := device/amazon/ariel
ifeq ($(TARGET_PREBUILT_KERNEL),)
    LOCAL_KERNEL := $(LOCAL_PATH)/kernel
else
    LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

ifneq ($(BOARD_CUSTOM_BOOTIMG_MK),)
    include $(BOARD_CUSTOM_BOOTIMG_MK)
endif

# This is a tablet
PRODUCT_CHARACTERISTICS := tablet

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# Build is dumb and requires recovery.img and fstab even if we specify no recovery
PRODUCT_COPY_FILES += $(LOCAL_PATH)/fstab.mt8135:recovery/root/etc/recovery.fstab
PRODUCT_COPY_FILES += $(LOCAL_PATH)/prebuilt/453_twrp_tested.img:$(PRODUCT_OUT)/recovery.img

# Same for boot.img and ramdisk.img
PRODUCT_COPY_FILES += $(LOCAL_PATH)/prebuilt/boot-stock-4.5.5.img:$(PRODUCT_OUT)/boot.img
PRODUCT_COPY_FILES += $(LOCAL_PATH)/prebuilt/ramdisk-stub.img:$(PRODUCT_OUT)/ramdisk.img


$(call inherit-product, build/target/product/aosp_base.mk)

LOCAL_PROPRIETARY_SYSTEM := $(LOCAL_PATH)/proprietary/system-4.5.5

PRODUCT_PACKAGES += \
	libdpframework \
    audio_policy.stub \
    audio.r_submix.default \
    audio.a2dp.default \
    libaudio-resampler \
    libcameraanalyzer \
    ext4_resize \
    libtinyalsa \
    libvorbisidec \
    hostapd \
    hostapd_cli \
    libdashplayer \
    lib_driver_cmd_mtk \
    libvideoeditor_jni \
    libvideoeditor_osal \
    libvideoeditorplayer \
    libvideoeditor_videofilters \
    libstagefrighthw \
    libstagefright \
    libm4u \
    libion \
    lib_driver_cmd_mt66xx
    #libmllite \
	#libinvensense_hal \

# MTK packages
#~ PRODUCT_PACKAGES += \
#~     libI420colorconvert \
#~     libvcodec_utility \
#~     libvcodec_oal \
#~     libh264dec_xa.ca7 \
#~     libh264dec_xb.ca7 \
#~     libmp4dec_sa.ca7 \
#~     libmp4dec_sb.ca7 \
#~     libvp8dec_xa.ca7 \
#~     libmp4enc_xa.ca7 \
#~     libmp4enc_xb.ca7 \
#~     libh264enc_sa.ca7 \
#~     libvp8dec_sa.ca7 \
#~     libvp9dec_sa.ca7 \
#~     libmp4enc_sa.ca7 \
#~     libh264enc_sb.ca7 \
#~     libvc1dec_sa.ca7 \
#~     libvideoeditorplayer \
#~     libvideoeditor_osal \
#~     libvideoeditor_3gpwriter \
#~     libvideoeditor_mcs \
#~     libvideoeditor_core \
#~     libvideoeditor_stagefrightshells \
#~     libvideoeditor_videofilters \
#~     libvideoeditor_jni \
#~     audio.primary.default \
#~     audio_policy.stub \
#~     local_time.default \
#~     libaudiocustparam \
#~     libh264dec_xa.ca9 \
#~     libh264dec_xb.ca9 \
#~     libh264dec_customize \
#~     libmp4dec_sa.ca9 \
#~     libmp4dec_sb.ca9 \
#~     libmp4dec_customize \
#~     libvp8dec_xa.ca9 \
#~     libmp4enc_xa.ca9 \
#~     libmp4enc_xb.ca9 \
#~     libh264enc_sa.ca9 \
#~     libh264enc_sb.ca9 \
#~     libvcodec_oal \
#~     libvc1dec_sa.ca9 \
#~     init.factory.rc \
#~     libaudio.primary.default \
#~     audio_policy.default \
#~     libaudio.a2dp.default \
#~     libMtkVideoTranscoder \
#~     libMtkOmxCore \
#~     libMtkOmxOsalUtils \
#~     libMtkOmxVdec \
#~     libMtkOmxVenc \
#~     libaudiodcrflt \
#~     libaudiosetting \
#~     librtp_jni \
#~     mfv_ut \
#~     libstagefright_memutil \
#~     factory.ini \
#~     factory \
#~     libaudio.usb.default \
#~     ccci_mdinit \
#~     ccci_fsd \
#~     eemcs_mdinit \
#~     eemcs_fsd \
#~     eemcs_fsvc \
#~     emcs_va \
#~     permission_check \
#~     thermal_manager \
#~     thermald \
#~     thermal \
#~     memsicd \
#~     msensord \
#~     libhwm \
#~     lights.default \
#~     libft \
#~     libblisrc \
#~     libbluetoothdrv \
#~     libbluetooth_mtk \
#~     libbluetoothem_mtk \
#~     libbluetooth_relayer \
#~     libmeta_bluetooth \
#~     libaudio.r_submix.default \
#~     libaudio.usb.default \
#~     libnbaio \
#~     libmeta_audio \
#~     sysctl \
#~     sysctld \
#~     mmp \
#~     libmmprofile \
#~     libmmprofile_jni \
#~     rtt \
#~     liblog \
#~     shutdown \
#~     muxreport \
#~     libIMGegl.so \
#~     libMtkOmxAudioEncBase \
#~     libMtkOmxAmrEnc \
#~     libMtkOmxAwbEnc \
#~     libMtkOmxAacEnc \
#~     libMtkOmxVorbisEnc \
#~     libMtkOmxAdpcmEnc \
#~     libMtkOmxMp3Dec \
#~     libMtkOmxGsmDec \
#~     libMtkOmxAacDec \
#~     libMtkOmxG711Dec \
#~     libMtkOmxVorbisDec \
#~     libMtkOmxAudioDecBase \
#~     libMtkOmxAdpcmDec \
#~     libMtkOmxWmaDec \
#~     libMtkOmxRawDec \
#~     libMtkOmxAMRNBDec \
#~     libMtkOmxAMRWBDec \
#~     audio.primary.default \
#~     audio_policy.stub \
#~     audio_policy.default \
#~     libaudio.primary.default \
#~     libaudio.a2dp.default \
#~     libaudio-resampler \
#~     libaudiocustparam \
#~     libaudiodcrflt \
#~     libaudiosetting \
#~     librtp_jni \
#~     libmatv_cust \
#~     matv \
#~     libMtkOmxApeDec \
#~     libMtkOmxFlacDec \
#~     ppp_dt \
#~     tc \
#~     libext2_profile \
#~     e2fsck \
#~     libext2_blkid \
#~     libext2_e2p \
#~     libext2_com_err \
#~     libext2fs \
#~     libext2_uuid \
#~     mke2fs \
#~     tune2fs \
#~     badblocks \
#~     chattr \
#~     lsattr \
#~     resize2fs \
#~     libnvram \
#~     libnvram_daemon_callback \
#~     libcustom_nvram \
#~     nvram_agent_binder \
#~     nvram_daemon \
#~     make_ext4fs \
#~     sdcard \
#~     libext \
#~     libext \
#~     libext4 \
#~     libext6 \
#~     libxtables \
#~     libip4tc \
#~     libip6tc \
#~     libsched \
#~     fsck_msdos_mtk \
#~     libc_malloc_debug_mtk \
#~     dpfd \
#~     libaal \
#~     libaal_cust \
#~     aal \
#~     pq \
#~     wlan_loader \
#~     wpa_supplicant \
#~     wpa_cli \
#~     wpa_supplicant.conf \
#~     wpa_supplicant_overlay.conf \
#~     p2p_supplicant_overlay.conf \
#~     hostapd \
#~     hostapd_cli \
#~     lib_driver_cmd_mt66xx.a \
#~     showmap \
#~     ext4_resize \
#~     mtop \
#~     libnvram_platform \
#~     libextalloc.so \
#~     libbrctrler \
#~     audiocmdservice_atci \
#~     atcid \
#~     libcam_platform \
#~     libBnMtkCodec \
#~     MtkCodecService \
#~     clatd \
#~     clatd.conf \
#~     init.aee.customer.rc \
#~     init.aee.mtk.rc

# MTK Bluetooth support
ifeq ($(strip $(MTK_BT_SUPPORT)), yes)
  PRODUCT_PROPERTY_OVERRIDES += \
        ro.btstack=blueangel

  PRODUCT_PACKAGES += MtkBt \
        btconfig.xml \
        auto_pair_blacklist.conf \
        libbtcusttable \
        libbtcust \
        libmtkbtextadp \
        libextpbap \
        libextavrcp \
        libextopp \
        libextsys \
        libextftp \
        libmtkbtextadpa2dp \
        libmtka2dp \
        libextbip \
        libextbpp \
        libexthid \
        libextsimap \
        libextjsr82 \
        libbtsession \
        libmtkbtextpan \
        libextmap \
        libmtkbtextspp \
        libexttestmode \
        libpppbtdun \
        libextopp_jni \
        libexthid_jni \
        libextpan_jni \
        libextftp_jni \
        libextbpp_jni \
        libextbip_jni \
        libextpbap_jni \
        libextavrcp_jni \
        libextsimap_jni \
        libextdun_jni \
        libextmap_jni \
        libextsys_jni \
        libextadvanced_jni \
        btlogmask \
        btconfig \
        libbtpcm \
        libbtsniff \
        mtkbt \
        bluetooth.blueangel \
        audio.a2dp.blueangel
endif

# MTK bwc support
ifeq ($(strip $(MTK_BWC_SUPPORT)), yes)
    PRODUCT_PACKAGES += libbwc
endif

# MTK Widevine DRM support
#~ ifeq ($(strip $(MTK_WVDRM_SUPPORT)),yes)
#~   PRODUCT_PROPERTY_OVERRIDES += \
#~     drm.service.enabled=true
#~   PRODUCT_PACKAGES += \
#~     com.google.widevine.software.drm.xml \
#~     com.google.widevine.software.drm \
#~     libdrmwvmplugin \
#~     libwvm \
#~     libdrmdecrypt
#~     ifeq ($(strip $(MTK_WVDRM_L1_SUPPORT)),yes)
#~         PRODUCT_PACKAGES +=  \
#~           libWVStreamControlAPI_L1 \
#~           libwvdrm_L1
#~     else
#~         PRODUCT_PACKAGES +=  \
#~           libWVStreamControlAPI_L3 \
#~           libwvdrm_L3
#~     endif
#~ else
#~   PRODUCT_PROPERTY_OVERRIDES += \
#~     drm.service.enabled=false
#~ endif

# MTK TEE Support
#~ ifeq ($(strip $(MTK_IN_HOUSE_TEE_SUPPORT)),yes)
#~ ifeq ($(strip $(MTK_DRM_KEY_MNG_SUPPORT)), yes)
#~   PRODUCT_PACKAGES += kisd
#~ endif
#~ endif

# MTK Modular drm
#~ PRODUCT_PACKAGES += lib_uree_mtk_modular_drm
#~ PRODUCT_PACKAGES += libwvdrmengine
#~ PRODUCT_PACKAGES += liboemcrypto

# Open Camera
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/apk/OpenCamera.apk:system/app/OpenCamera.apk \

# Graphics-related
PRODUCT_COPY_FILES += \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/mediaserver:system/bin/mediaserver \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/egl/egl.cfg:system/lib/egl/egl.cfg \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/egl/libEGL_POWERVR_ROGUE.so:system/vendor/lib/egl/libEGL_POWERVR_ROGUE.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/egl/libGLESv1_CM_POWERVR_ROGUE.so:system/vendor/lib/egl/libGLESv1_CM_POWERVR_ROGUE.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/egl/libGLESv2_POWERVR_ROGUE.so:system/vendor/lib/egl/libGLESv2_POWERVR_ROGUE.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libion_mtk.so:system/lib/libion_mtk.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libm4u.so:system/lib/libm4u.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libtz_uree.so:system/lib/libtz_uree.so \
	$(LOCAL_PROPRIETARY_SYSTEM)/lib/libdpframework.so:system/lib/libdpframework.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libdpframework_os.so:system/lib/libdpframework_os.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libdpframework_plat.so:system/lib/libdpframework_plat.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libbwc.so:system/lib/libbwc.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/libIMGegl.so:system/vendor/lib/libIMGegl.so \
    #$(LOCAL_PROPRIETARY_SYSTEM)/bin/HDCPRepeaterMode:system/bin/HDCPRepeaterMode \

# Kernel modules
PRODUCT_COPY_FILES += \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/modules/register_access.ko:system/lib/modules/register_access.ko \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/modules/cyttsp4_debug.ko:system/lib/modules/cyttsp4_debug.ko \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/modules/dc_fbdev.ko:system/lib/modules/dc_fbdev.ko \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/modules/dumpEfuseInfo.ko:system/lib/modules/dumpEfuseInfo.ko \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/modules/mtk_hif_sdio.ko:system/lib/modules/mtk_hif_sdio.ko \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/modules/mtk_stp_bt.ko:system/lib/modules/mtk_stp_bt.ko \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/modules/mtk_stp_gps.ko:system/lib/modules/mtk_stp_gps.ko \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/modules/mtk_stp_sdio.ko:system/lib/modules/mtk_stp_sdio.ko \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/modules/mtk_stp_uart.ko:system/lib/modules/mtk_stp_uart.ko \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/modules/mtk_stp_wmt.ko:system/lib/modules/mtk_stp_wmt.ko \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/modules/mtk_wifi_loopback.ko:system/lib/modules/mtk_wifi_loopback.ko \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/modules/mtk_wmt_detect.ko:system/lib/modules/mtk_wmt_detect.ko \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/modules/mtk_wmt_wifi.ko:system/lib/modules/mtk_wmt_wifi.ko \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/modules/pvrsrvkm.ko:system/lib/modules/pvrsrvkm.ko \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/modules/scsi_tgt.ko:system/lib/modules/scsi_tgt.ko \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/modules/vcodec_kernel_driver.ko:system/lib/modules/vcodec_kernel_driver.ko \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/modules/wlan_mt6628.ko:system/lib/modules/wlan_mt6628.ko

# Teleservice apk to try stopping a lot of logcat errors
#PRODUCT_COPY_FILES += \
#	$(LOCAL_PROPRIETARY_SYSTEM)/priv-app/TeleService.apk:system/priv-app/TeleService.apk \
#	$(LOCAL_PROPRIETARY_SYSTEM)/priv-app/TeleService.odex:system/priv-app/TeleService.odex \

# Sensor related
PRODUCT_COPY_FILES += \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libinvensense_hal.so:system/lib/libinvensense_hal.so \
	$(LOCAL_PROPRIETARY_SYSTEM)/lib/libmplmpu.so:system/lib/libmplmpu.so \
	$(LOCAL_PROPRIETARY_SYSTEM)/lib/libmllite.so:system/lib/libmllite.so \


# Audio related
PRODUCT_COPY_FILES += \
	$(LOCAL_PROPRIETARY_SYSTEM)/lib/libaudiosetting.so:system/lib/libaudiosetting.so \
	$(LOCAL_PROPRIETARY_SYSTEM)/lib/libaudiocustparam.so:system/lib/libaudiocustparam.so \
	$(LOCAL_PROPRIETARY_SYSTEM)/lib/libblisrc.so:system/lib/libblisrc.so \
	$(LOCAL_PROPRIETARY_SYSTEM)/lib/libcustom_nvram.so:system/lib/libcustom_nvram.so \
	$(LOCAL_PROPRIETARY_SYSTEM)/lib/libspeech_enh_lib.so:system/lib/libspeech_enh_lib.so \
	$(LOCAL_PROPRIETARY_SYSTEM)/lib/libaudiocompensationfilter.so:system/lib/libaudiocompensationfilter.so \
	$(LOCAL_PROPRIETARY_SYSTEM)/lib/libaudio_customization.so:system/lib/libaudio_customization.so \
	$(LOCAL_PROPRIETARY_SYSTEM)/lib/libbessound_mtk.so:system/lib/libbessound_mtk.so \
	$(LOCAL_PROPRIETARY_SYSTEM)/lib/hw/audio_policy.stub.so:system/lib/hw/audio_policy.stub.so \

# Power related
PRODUCT_COPY_FILES += \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/libwvm.so:system/vendor/lib/libwvm.so \

# Wifi related
PRODUCT_COPY_FILES += \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/wifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
    #$(LOCAL_PROPRIETARY_SYSTEM)/bin/wpa_supplicant:system/bin/wpa_supplicant \

# Bluetooth related
PRODUCT_COPY_FILES += \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libbluetooth_jni.so:system/lib/libbluetooth_jni.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libbluetoothdrv.so:system/lib/libbluetoothdrv.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libbluetoothem_mtk.so:system/lib/libbluetoothem_mtk.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libbluetooth_mtk.so:system/lib/libbluetooth_mtk.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libbluetooth_relayer.so:system/lib/libbluetooth_relayer.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libbtsession.so:system/lib/libbtsession.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libbtsniff.so:system/lib/libbtsniff.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libbtcust.so:system/lib/libbtcust.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libbtcusttable.so:system/lib/libbtcusttable.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libextbpp.so:system/lib/libextbpp.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libextem.so:system/lib/libextem.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libextftp.so:system/lib/libextftp.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libextmap.so:system/lib/libextmap.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libextsimap.so:system/lib/libextsimap.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libextsys.so:system/lib/libextsys.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libexttestmode.so:system/lib/libexttestmode.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libbtem.so:system/lib/libbtem.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libbtpcm.so:system/lib/libbtpcm.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libpppbtdun.so:system/lib/libpppbtdun.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/btconfig:system/bin/btconfig \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/btlogmask:system/bin/btlogmask \
#    $(LOCAL_PROPRIETARY_SYSTEM)/app/Bluetooth.apk:system/app/Bluetooth.apk \

# Camera related
PRODUCT_COPY_FILES += \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libft.so:system/lib/libft.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/lib3a.so:system/lib/lib3a.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libcam.camadapter.so:system/lib/libcam.camadapter.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libcam.campipe.so:system/lib/libcam.campipe.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libcam.camshot.so:system/lib/libcam.camshot.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libcam.client.so:system/lib/libcam.client.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libcam.device1.so:system/lib/libcam.device1.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libcam.exif.so:system/lib/libcam.exif.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libcam.paramsmgr.so:system/lib/libcam.paramsmgr.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libcam.utils.so:system/lib/libcam.utils.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libcamalgo.so:system/lib/libcamalgo.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libcamdrv.so:system/lib/libcamdrv.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libcameracustom.so:system/lib/libcameracustom.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libcam_mmp.so:system/lib/libcam_mmp.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libcam_platform.so:system/lib/libcam_platform.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libcam_utils.so:system/lib/libcam_utils.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libimageio.so:system/lib/libimageio.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/framework/EnhancedCameraAPI.jar:system/framework/EnhancedCameraAPI.jar \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libcameraservice.so:system/lib/libcameraservice.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/hw/camera.default.so:system/lib/hw/camera.default.so \

PRODUCT_COPY_FILES += \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/bin/pvrdebug:system/vendor/bin/pvrdebug \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/bin/pvrsrvctl:system/vendor/bin/pvrsrvctl \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/firmware/maxtouch.20.cfg:system/vendor/firmware/maxtouch.20.cfg \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/firmware/maxtouch.20.fw:system/vendor/firmware/maxtouch.20.fw \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/hw/audio.a2dp.mt8135.so:system/vendor/lib/hw/audio.a2dp.mt8135.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/hw/bluetooth.mt8135.so:system/vendor/lib/hw/bluetooth.mt8135.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/hw/gralloc.mt8135.so:system/vendor/lib/hw/gralloc.mt8135.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/libpvrANDROID_WSEGL.so:system/vendor/lib/libpvrANDROID_WSEGL.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/libPVRScopeServices.so:system/vendor/lib/libPVRScopeServices.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/libsrv_init.so:system/vendor/lib/libsrv_init.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/libsrv_um.so:system/vendor/lib/libsrv_um.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/libusc.so:system/vendor/lib/libusc.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/libglslcompiler.so:system/vendor/lib/libglslcompiler.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/hw/audio.primary.mt8135.so:system/lib/hw/audio.primary.mt8135.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/hw/audio_policy.mt8135.so:system/lib/hw/audio_policy.mt8135.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/hw/gps.mt8135.so:system/lib/hw/gps.mt8135.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/hw/hwcomposer.mt8135.so:system/lib/hw/hwcomposer.mt8135.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/hw/keystore.amzn.mt8135.so:system/lib/hw/keystore.amzn.mt8135.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/hw/lights.mt8135.so:system/lib/hw/lights.mt8135.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/hw/perfboost.mt8135.so:system/lib/hw/perfboost.mt8135.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/hw/sensors.mt8135.so:system/lib/hw/sensors.mt8135.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libjni_pq.so:system/lib/libjni_pq.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libJpgDecPipe.so:system/lib/libJpgDecPipe.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libJpgEncPipe.so:system/lib/libJpgEncPipe.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libPQjni.so:system/lib/libPQjni.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libaal.so:system/lib/libaal.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libaal_cust.so:system/lib/libaal_cust.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/libbltsville_gc2d.2.2.2.0.so:system/vendor/lib/libbltsville_gc2d.2.2.2.0.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/libbltsville_ticpu.2.1.0.0.so:system/vendor/lib/libbltsville_ticpu.2.1.0.0.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/libbltsville_ticpu_license.txt:system/vendor/lib/libbltsville_ticpu_license.txt \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/liboemcrypto.so:system/vendor/lib/liboemcrypto.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/soundfx/libswdap.so:system/vendor/lib/soundfx/libswdap.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/oprofile/oprofile-boot:system/vendor/oprofile/oprofile-boot \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/smartvolume/ariel/anlg_dock_headset.csv:system/vendor/smartvolume/ariel/anlg_dock_headset.csv \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/smartvolume/ariel/aux_digital.csv:system/vendor/smartvolume/ariel/aux_digital.csv \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/smartvolume/ariel/bt_a2dp.csv:system/vendor/smartvolume/ariel/bt_a2dp.csv \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/smartvolume/ariel/bt_a2dp_headphones.csv:system/vendor/smartvolume/ariel/bt_a2dp_headphones.csv \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/smartvolume/ariel/bt_a2dp_speaker.csv:system/vendor/smartvolume/ariel/bt_a2dp_speaker.csv \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/smartvolume/ariel/bt_sco.csv:system/vendor/smartvolume/ariel/bt_sco.csv \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/smartvolume/ariel/bt_sco_carkit.csv:system/vendor/smartvolume/ariel/bt_sco_carkit.csv \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/smartvolume/ariel/bt_sco_headset.csv:system/vendor/smartvolume/ariel/bt_sco_headset.csv \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/smartvolume/ariel/default.csv:system/vendor/smartvolume/ariel/default.csv \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/smartvolume/ariel/dgtl_dock_headeset.csv:system/vendor/smartvolume/ariel/dgtl_dock_headeset.csv \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/smartvolume/ariel/earpiece.csv:system/vendor/smartvolume/ariel/earpiece.csv \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/smartvolume/ariel/fm_radio_tx.csv:system/vendor/smartvolume/ariel/fm_radio_tx.csv \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/smartvolume/ariel/speaker.csv:system/vendor/smartvolume/ariel/speaker.csv \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/smartvolume/ariel/wired_headphone.csv:system/vendor/smartvolume/ariel/wired_headphone.csv \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/smartvolume/ariel/wired_headset.csv:system/vendor/smartvolume/ariel/wired_headset.csv \
    $(LOCAL_PROPRIETARY_SYSTEM)/vendor/data/amz.rsa:system/vendor/data/amz.rsa \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/hw/perfboost.default.so:system/lib/hw/perfboost.default.so \
#~     $(LOCAL_PROPRIETARY_SYSTEM)/lib/libffmpeg.so:system/lib/libffmpeg.so \
#~     $(LOCAL_PROPRIETARY_SYSTEM)/lib/libvcodecdrv.so:system/lib/libvcodecdrv.so \
#~     $(LOCAL_PROPRIETARY_SYSTEM)/lib/libvcodec_utility.so:system/lib/libvcodec_utility.so \
#~     $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/libstagefright_soft_ddpdec.so:system/vendor/lib/libstagefright_soft_ddpdec.so \
#~     $(LOCAL_PROPRIETARY_SYSTEM)/lib/drm/libdrmplayreadyplugin.so:system/lib/drm/libdrmplayreadyplugin.so \
#~     $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/drm/libdrmwvmplugin.so:system/vendor/lib/drm/libdrmwvmplugin.so \ 
#~     $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/libwvdrm_L1.so:system/vendor/lib/libwvdrm_L1.so \
#~     $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/libWVStreamControlAPI_L1.so:system/vendor/lib/libWVStreamControlAPI_L1.so \
#~     $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/mediadrm/libplayreadydrmplugin.so:system/vendor/lib/mediadrm/libplayreadydrmplugin.so \
#~     $(LOCAL_PROPRIETARY_SYSTEM)/vendor/lib/mediadrm/libwvdrmengine.so:system/vendor/lib/mediadrm/libwvdrmengine.so \


# Proprietary libs
PRODUCT_COPY_FILES += \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/lib_uree_mtk_crypto.so:system/lib/lib_uree_mtk_crypto.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/lib_uree_mtk_modular_drm.so:system/lib/lib_uree_mtk_modular_drm.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/lib_uree_mtk_video_secure_al.so:system/lib/lib_uree_mtk_video_secure_al.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/liburee_meta_drmkeyinstall_v2.so:system/lib/liburee_meta_drmkeyinstall_v2.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libstagefright_memutil.so:system/lib/libstagefright_memutil.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libnvram.so:system/lib/libnvram.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libnvramagentclient.so:system/lib/libnvramagentclient.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libnvram_daemon_callback.so:system/lib/libnvram_daemon_callback.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libnvram_platform.so:system/lib/libnvram_platform.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libnvram_sec.so:system/lib/libnvram_sec.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libhwm.so:system/lib/libhwm.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libmtkbtextspp.so:system/lib/libmtkbtextspp.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libMtkOmxAacDec.so:system/lib/libMtkOmxAacDec.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libMtkOmxAacEnc.so:system/lib/libMtkOmxAacEnc.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libMtkOmxAIVPlayer.so:system/lib/libMtkOmxAIVPlayer.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libMtkOmxAmrEnc.so:system/lib/libMtkOmxAmrEnc.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libMtkOmxAMRNBDec.so:system/lib/libMtkOmxAMRNBDec.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libMtkOmxAMRWBDec.so:system/lib/libMtkOmxAMRWBDec.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libMtkOmxAwbEnc.so:system/lib/libMtkOmxAwbEnc.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libMtkOmxCore.so:system/lib/libMtkOmxCore.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libMtkOmxFlacDec.so:system/lib/libMtkOmxFlacDec.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libMtkOmxG711Dec.so:system/lib/libMtkOmxG711Dec.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libMtkOmxMp3Dec.so:system/lib/libMtkOmxMp3Dec.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libMtkOmxVdec.so:system/lib/libMtkOmxVdec.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libMtkOmxVenc.so:system/lib/libMtkOmxVenc.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libMtkOmxVorbisDec.so:system/lib/libMtkOmxVorbisDec.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libamr_wrap.so:system/lib/libamr_wrap.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libawb_wrap.so:system/lib/libawb_wrap.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libmtk_drvb.so:system/lib/libmtk_drvb.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libaudio.primary.mt8135.so:system/lib/libaudio.primary.mt8135.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libGdmaScalerPipe.so:system/lib/libGdmaScalerPipe.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libcrypto.so:system/lib/libcrypto.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libsmartvolume.so:system/lib/libsmartvolume.so \

# Firmware files
PRODUCT_COPY_FILES += \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/firmware/mt6628_ant_m1.cfg:system/etc/firmware/mt6628_ant_m1.cfg \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/firmware/mt6628_patch_e1_hdr.bin:system/etc/firmware/mt6628_patch_e1_hdr.bin \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/firmware/mt6628_patch_e2_0_hdr.bin:system/etc/firmware/mt6628_patch_e2_0_hdr.bin \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/firmware/mt6628_patch_e2_1_hdr.bin:system/etc/firmware/mt6628_patch_e2_1_hdr.bin \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/firmware/WIFI_RAM_CODE:system/etc/firmware/WIFI_RAM_CODE \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/firmware/WIFI_RAM_CODE_E6:system/etc/firmware/WIFI_RAM_CODE_E6 \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/firmware/WIFI_RAM_CODE_MT6628:system/etc/firmware/WIFI_RAM_CODE_MT6628 \

# Permissions files
PRODUCT_COPY_FILES += \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/EnhancedCameraAPI.xml:system/etc/permissions/EnhancedCameraAPI.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/eaclibrary.xml:system/etc/permissions/eaclibrary.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/kcpsdk-auth.xml:system/etc/permissions/kcpsdk-auth.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/kerberos-java-gssapi.xml:system/etc/permissions/kerberos-java-gssapi.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/model.kfarwi.xml:system/etc/permissions/model.kfarwi.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/model.kfaswi.xml:system/etc/permissions/model.kfaswi.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/org.json.simple.xml:system/etc/permissions/org.json.simple.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/retaildemoapi.xml:system/etc/permissions/retaildemoapi.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/rtmpclient.xml:system/etc/permissions/rtmpclient.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/platform.xml:system/etc/permissions/platform.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/com.amazon.cardlib.xml:system/etc/permissions/com.amazon.cardlib.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/com.amazon.device.context.xml:system/etc/permissions/com.amazon.device.context.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/com.amazon.device.print.xml:system/etc/permissions/com.amazon.device.print.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/com.amazon.identity.auth.device.xml:system/etc/permissions/com.amazon.identity.auth.device.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/com.amazon.kindle.cms.xml:system/etc/permissions/com.amazon.kindle.cms.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/com.amazon.sharingservice.android.client.xml:system/etc/permissions/com.amazon.sharingservice.android.client.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/com.amazon.sics.xml:system/etc/permissions/com.amazon.sics.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/android.amazon.res.xml:system/etc/permissions/android.amazon.res.xml \
#~     $(LOCAL_PROPRIETARY_SYSTEM)/etc/permissions/com.google.widevine.software.drm.xml:system/etc/permissions/com.google.widevine.software.drm.xml \

# Config files
#PRODUCT_COPY_FILES += \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/display_conf:system/etc/display_conf \

# Libraries
PRODUCT_COPY_FILES += \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libstlport_shared.so:system/lib/libstlport_shared.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libextbip.so:system/lib/libextbip.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libmhalImageCodec.so:system/lib/libmhalImageCodec.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libsched.so:system/lib/libsched.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libserver.so:system/lib/libserver.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libsmartsuspendmanagerservice.so:system/lib/libsmartsuspendmanagerservice.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libplayready.so:system/lib/libplayready.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libmmprofile.so:system/lib/libmmprofile.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libmpo.so:system/lib/libmpo.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libmpoencoder.so:system/lib/libmpoencoder.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libmrec.so:system/lib/libmrec.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/liblogmanager.so:system/lib/liblogmanager.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libmatv_cust.so:system/lib/libmatv_cust.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libfeatureio.so:system/lib/libfeatureio.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libfile_op.so:system/lib/libfile_op.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libdrmdecrypt.so:system/lib/libdrmdecrypt.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libdrmmtkutil.so:system/lib/libdrmmtkutil.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libdrmplayreadydecryptor.so:system/lib/libdrmplayreadydecryptor.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libblueshift-audioprocessing.so:system/lib/libblueshift-audioprocessing.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libblueshift-opus.so:system/lib/libblueshift-opus.so \
    $(LOCAL_PROPRIETARY_SYSTEM)/lib/libbrctrler.so:system/lib/libbrctrler.so \
    #$(LOCAL_PROPRIETARY_SYSTEM)/lib/libstagefrighthw.so:system/lib/libstagefrighthw.so \

# Binaries
PRODUCT_COPY_FILES += \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/6620_launcher:system/bin/6620_launcher \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/6620_wmt_concurrency:system/bin/6620_wmt_concurrency \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/6620_wmt_lpbk:system/bin/6620_wmt_lpbk \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/aal:system/bin/aal \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/atcid:system/bin/atcid \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/audiocli:system/bin/audiocli \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/battery_lifetime_data:system/bin/battery_lifetime_data \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/battery_log.sh:system/bin/battery_log.sh \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/devicetype_service:system/bin/devicetype_service \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/dmesg_log.sh:system/bin/dmesg_log.sh \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/drvbd:system/bin/drvbd \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/force_provisioning.sh:system/bin/force_provisioning.sh \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/hotplug:system/bin/hotplug \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/idme:system/bin/idme \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/kdestroy:system/bin/kdestroy \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/kpoc_charger:system/bin/kpoc_charger \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/lock_emmc.sh:system/bin/lock_emmc.sh \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/logcat_log.sh:system/bin/logcat_log.sh \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/mtkbt:system/bin/mtkbt \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/nvram_agent_binder:system/bin/nvram_agent_binder \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/nvram_daemon:system/bin/nvram_daemon \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/PrintBootInfo:system/bin/PrintBootInfo \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/pq:system/bin/pq \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/sensorcal.sh:system/bin/sensorcal.sh \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/shipclean:system/bin/shipclean \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/ThermalBenchmarkAutomation.sh:system/bin/ThermalBenchmarkAutomation.sh \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/thermal_log.sh:system/bin/thermal_log.sh \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/thermal_manager:system/bin/thermal_manager \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/thermal.virtual.sensor:system/bin/thermal.virtual.sensor \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/wlan_loader:system/bin/wlan_loader \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/wmt_loader:system/bin/wmt_loader \
    $(LOCAL_PROPRIETARY_SYSTEM)/xbin/vitals_collection_agent:system/xbin/vitals_collection_agent \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/kinit:system/bin/kinit \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/klist:system/bin/klist \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/kswitch:system/bin/kswitch \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/kisd:system/bin/kisd \
    $(LOCAL_PROPRIETARY_SYSTEM)/bin/ffu:system/bin/ffu \


# Configs
PRODUCT_COPY_FILES += \
	$(LOCAL_PROPRIETARY_SYSTEM)/etc/kisd_starter.sh:system/etc/kisd_starter.sh \
	$(LOCAL_PROPRIETARY_SYSTEM)/etc/mtk_omx_core.cfg:system/etc/mtk_omx_core.cfg \
	$(LOCAL_PROPRIETARY_SYSTEM)/etc/bluetooth/btconfig.xml:system/etc/bluetooth/btconfig.xml \
	$(LOCAL_PROPRIETARY_SYSTEM)/etc/media_codecs.xml:system/etc/media_codecs.xml \
	$(LOCAL_PROPRIETARY_SYSTEM)/etc/media_profiles.xml:system/etc/media_profiles.xml \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/.tp/aston-thermal-virtual-sensor.conf:system/etc/.tp/aston-thermal-virtual-sensor.conf \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/.tp/aston-tmp103-thermal.conf:system/etc/.tp/aston-tmp103-thermal.conf \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/.tp/thermal-virtual-sensor.conf:system/etc/.tp/thermal-virtual-sensor.conf \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/.tp/thermal.conf:system/etc/.tp/thermal.conf \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/.tp/thermal.encrypt.conf:system/etc/.tp/thermal.encrypt.conf \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/.tp/thermal.off.conf:system/etc/.tp/thermal.off.conf \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/.tp/tmp103-thermal.conf:system/etc/.tp/tmp103-thermal.conf \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/monitoring.conf:system/etc/monitoring.conf \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/shipcleanmode.conf:system/etc/shipcleanmode.conf \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/vold.fstab:system/etc/vold.fstab \
    $(LOCAL_PROPRIETARY_SYSTEM)/etc/vendor_service.conf:system/etc/vendor_service.conf
	#$(LOCAL_PROPRIETARY_SYSTEM)/etc/.tp/.ht120.mtc:system/etc/.tp/.ht120.mtc \


PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := full_ariel
PRODUCT_DEVICE := ariel
