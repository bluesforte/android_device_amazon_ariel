#ifndef OMX_NODE_INSTANCE_BUFFER_HANDLER_H_
#define OMX_NODE_INSTANCE_BUFFER_HANDLER_H_

#include "OMX.h"
#include <OMXNodeInstance.h>

#include <utils/RefBase.h>
#include <utils/threads.h>



namespace android {

struct OMXNodeInstanceBufferHandler {
    OMXNodeInstanceBufferHandler (OmxNodeInstance *owner);

    status_t useBuffer(
            OMX_U32 portIndex, unsigned char* virAddr, size_t size,
            OMX::buffer_id *buffer);

    status_t useBuffer(
            OMX_U32 portIndex, unsigned char* virAddr, size_t size, OMX_U32 offset,
            OMX::buffer_id *buffer);

    status_t registerBuffer(
            OMX_U32 portIndex, const sp<IMemoryHeap> &heap);

    status_t registerBuffer2(
            OMX_U32 portIndex, const sp<IMemoryHeap> &HeapBase);

    status_t useIonBuffer(
            OMX_U32 port_index, unsigned char* virAddr, OMX_S32 fd, size_t size, OMX::buffer_id *buffer);

private:
    OmxNodeInstance *mOwner;
    sp<IMemoryHeap> mHeap;
};

#endif
