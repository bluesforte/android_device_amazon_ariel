
#include <OMX_Component.h>
#include "OMXNodeInstanceBufferHandler.h"
#include <OMXNodeInstance.h>
#include <utils/threads.h>

namespace android {

struct OMXNodeInstanceBufferHandler {
    OMXNodeInstanceBufferHandler (OmxNodeInstance *owner)
        : mOwner(owner) {
        mHeap = NULL;
    }

    status_t useBuffer(
            OMX_U32 portIndex, unsigned char* virAddr, size_t size,
            OMX::buffer_id *buffer) {
        Mutex::Autolock autoLock(mOwner->mLock);

        BufferMeta *buffer_meta = new BufferMeta(NULL);

        OMX_BUFFERHEADERTYPE *header;

        //ALOGE ("@@ OMX_UseBuffer2 virAddr=0x%x", virAddr);

        OMX_ERRORTYPE err = OMX_UseBuffer(
                mOwner->mHandle, &header, portIndex, buffer_meta,
                size, static_cast<OMX_U8 *>(virAddr));

        if (err != OMX_ErrorNone) {
            ALOGE("OMX_UseBuffer failed with error %d (0x%08x)", err, err);

            delete buffer_meta;
            buffer_meta = NULL;

            *buffer = 0;

            return UNKNOWN_ERROR;
        }

        *buffer = header;

        mOwner->addActiveBuffer(portIndex, *buffer);

        return OK;
    }

    status_t useBuffer(
            OMX_U32 portIndex, unsigned char* virAddr, size_t size, OMX_U32 offset,
            OMX::buffer_id *buffer) {
        Mutex::Autolock autoLock(mOwner->mLock);
        unsigned char *vAddr = virAddr;

        if (mHeap == NULL)
            return UNKNOWN_ERROR;

        BufferMeta *buffer_meta = new BufferMeta(NULL);

        OMX_BUFFERHEADERTYPE *header;

        void *base = mHeap->getBase();
        vAddr = (unsigned char *)base + offset;

        ALOGD ("@@ useBuffer[OUT] ptr(0x%08X), pBuffer(0x%08X), vAddr(0x%08X)", ptr, pBuffer, vAddr);

        OMX_ERRORTYPE err = OMX_UseBuffer(
                mHandle, &header, portIndex, buffer_meta,
                size, static_cast<OMX_U8 *>(vAddr));

        if (err != OMX_ErrorNone) {
            ALOGE("OMX_UseBuffer failed with error %d (0x%08x)", err, err);

            delete buffer_meta;
            buffer_meta = NULL;

            *buffer = 0;

            return UNKNOWN_ERROR;
        }

        *buffer = header;

        mOwner->addActiveBuffer(portIndex, *buffer);

        return OK;
    }

    status_t registerBuffer(
            OMX_U32 portIndex, const sp<IMemoryHeap> &heap) {
        Mutex::Autolock autoLock(mOwner->mLock);

        // Unregister pmem
        if (mHeap != NULL)
        {
            ExPmemInfo rInfo;
            rInfo.base = mHeap->getBase();
            rInfo.size = mHeap->getSize();
            rInfo.shared_fd = mHeap->getHeapID();
            rInfo.offset = 0;

            if (!sf_pmem_unregister(&rInfo)) {
                ALOGE("pmem unregister err: 0x%X, offset: 0x%X !", (unsigned)rInfo.base, rInfo.offset);
            }
            mHeap = NULL;
        }

        mHeap = heap;

        // Register pmem
        ExPmemInfo rInfo;
        rInfo.base = mHeap->getBase();
        rInfo.size = mHeap->getSize();
        rInfo.shared_fd = mHeap->getHeapID();
        rInfo.offset = 0;
        if (!sf_pmem_register(&rInfo)) {
            ALOGE("pmem register err: 0x%X, offset: 0x%X !", (unsigned)rInfo.base, rInfo.offset);
        }

        return OK;
    }

    status_t registerBuffer2(
            OMX_U32 portIndex, const sp<IMemoryHeap> &HeapBase) {
        Mutex::Autolock autoLock(mOwner->mLock);

        MemHeapInfo memheapinfo;

        mHeap = HeapBase;
        memheapinfo.base = (unsigned char*) mHeap->getBase();
        memheapinfo.mMemHeapBase = (int) mHeap.get();
        memheapinfo.size = mHeap->getSize();
        ALOGD("registerBuffer2: base = 0x%08X, mMemHeapBase = 0x%08X, size = %d", (unsigned int)memheapinfo.base, (unsigned int)memheapinfo.mMemHeapBase, (unsigned int)memheapinfo.size);
        sf_memheap_set_info(&memheapinfo);

        return OK;
    }

    status_t useIonBuffer(
            OMX_U32 port_index, unsigned char* virAddr, OMX_S32 fd, size_t size, OMX::buffer_id *buffer) {
        Mutex::Autolock autoLock(mOwner->mLock);

        OMX_INDEXTYPE index;
        OMX_ERRORTYPE err = OMX_GetExtensionIndex(
              mOwner->mHandle,
              const_cast<OMX_STRING>("OMX.MTK.VIDEO.index.useIonBuffer"),
              &index);

        if (err != OMX_ErrorNone) {
          ALOGE("OMX_GetExtensionIndex failed");

          return StatusFromOMXError(err);
        }

        BufferMeta *bufferMeta = new BufferMeta(NULL);

        OMX_BUFFERHEADERTYPE *header;

        OMX_VERSIONTYPE ver;
        ver.s.nVersionMajor = 1;
        ver.s.nVersionMinor = 0;
        ver.s.nRevision = 0;
        ver.s.nStep = 0;

        UseIonBufferParams params = {
          sizeof(UseIonBufferParams), ver, portIndex, bufferMeta,
          virAddr, fd, size, &header
        };

        err = OMX_SetParameter(mOwner->mHandle, index, &params);

        if (err != OMX_ErrorNone) {
          ALOGE("OMX_UseAndroidNativeBuffer failed with error %d (0x%08x)", err,
                  err);

          delete bufferMeta;
          bufferMeta = NULL;

          *buffer = 0;

          return UNKNOWN_ERROR;
        }

        CHECK_EQ(header->pAppPrivate, bufferMeta);

        *buffer = header;

        mOwner->addActiveBuffer(portIndex, *buffer);

        return OK;
    }


};
