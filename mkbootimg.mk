# uses the stock boot image for ariel

LOCAL_PATH := $(call my-dir)

$(INSTALLED_BOOTIMAGE_TARGET):

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/boot-stock-4.5.3.img:$(PRODUCT_OUT)/boot.img

# copy kernel modules into system
#PRODUCT_COPY_FILES += \
#    $(LOCAL_PATH)/proprietary/system/lib/modules/cyttsp4_debug.ko:system/lib/modules/cyttsp4_debug.ko \
#    $(LOCAL_PATH)/proprietary/system/lib/modules/dc_fbdev.ko:system/lib/modules/dc_fbdev.ko \
#    $(LOCAL_PATH)/proprietary/system/lib/modules/dumpEfuseInfo.ko:system/lib/modules/dumpEfuseInfo.ko \
#    $(LOCAL_PATH)/proprietary/system/lib/modules/mtk_hif_sdio.ko:system/lib/modules/mtk_hif_sdio.ko \
#    $(LOCAL_PATH)/proprietary/system/lib/modules/mtk_stp_bt.ko:system/lib/modules/mtk_stp_bt.ko \
#    $(LOCAL_PATH)/proprietary/system/lib/modules/mtk_stp_gps.ko:system/lib/modules/mtk_stp_gps.ko \
#    $(LOCAL_PATH)/proprietary/system/lib/modules/mtk_stp_sdio.ko:system/lib/modules/mtk_stp_sdio.ko \
#    $(LOCAL_PATH)/proprietary/system/lib/modules/mtk_stp_uart.ko:system/lib/modules/mtk_stp_uart.ko \
#    $(LOCAL_PATH)/proprietary/system/lib/modules/mtk_stp_wmt.ko:system/lib/modules/mtk_stp_wmt.ko \
#    $(LOCAL_PATH)/proprietary/system/lib/modules/mtk_wifi_loopback.ko:system/lib/modules/mtk_wifi_loopback.ko \
#    $(LOCAL_PATH)/proprietary/system/lib/modules/mtk_wmt_detect.ko:system/lib/modules/mtk_wmt_detect.ko \
#    $(LOCAL_PATH)/proprietary/system/lib/modules/mtk_wmt_wifi.ko:system/lib/modules/mtk_wmt_wifi.ko \
#    $(LOCAL_PATH)/proprietary/system/lib/modules/pvrsrvkm.ko:system/lib/modules/pvrsrvkm.ko \
#    $(LOCAL_PATH)/proprietary/system/lib/modules/register_access.ko:system/lib/modules/register_access.ko \
#    $(LOCAL_PATH)/proprietary/system/lib/modules/scsi_tgt.ko:system/lib/modules/scsi_tgt.ko \
#    $(LOCAL_PATH)/proprietary/system/lib/modules/vcodec_kernel_driver.ko:system/lib/modules/vcodec_kernel_driver.ko \
#    $(LOCAL_PATH)/proprietary/system/lib/modules/wlan_mt6628.ko:system/lib/modules/wlan_mt6628.ko
