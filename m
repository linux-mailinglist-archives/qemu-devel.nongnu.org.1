Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B54E793E8D
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:17:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtKu-0000fe-B3; Wed, 06 Sep 2023 10:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qdtKm-0000cL-C6
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:16:44 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qdtKi-0002Kk-Pw
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:16:44 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c35ee3b0d2so6568855ad.2
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 07:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694009799; x=1694614599;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oPhfXB0+xtVI5sfW6SQMWjPWh0SJW5yl2FvAZ8mTD4c=;
 b=sBhIRulbJMCdQaOd84FgOLrOBAToe5L/Ee9C3iNrT9aODqHba+DX3tmz3PGAy5IVY3
 6it0jxK4tAWwy0cGvAbnPw5FbvXkahnQpy87YYDHjUpanXt+5aGKDau4BzeqTyPxWpKv
 Yd/423RxQ99cPm+Dyj1dT4DiFVzfjIpDz1t+Ka+fMNJQNj8puaEHRtQ+qeHBxYqHEQKt
 WzSaGUsSDoPESvQRNDj9JbZaBqxGUMXODLL+o+piwUj/dPHFeqs0KpiDNJZDdUz+cVx/
 LQsFjyXYawl++M3/8e3fuvACeYk4Pu1WFf+EuixsQ1Ni8WD37oPXXB4vqebEUd/IG3ds
 r64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694009799; x=1694614599;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oPhfXB0+xtVI5sfW6SQMWjPWh0SJW5yl2FvAZ8mTD4c=;
 b=D0pZ9CKu/KEVrle+krha53vf1VIQuZvTeJdfapzag1hNJGwiD523XcKJuME6btfY6P
 b3iu/PzsVj7stcOLSZWCSdY5DWeT0evxBR4SiAvYu/7EYI8YbJZXADkxFNTgs7I/16eJ
 s+QFzgJThHSRvpxecT5/0OHQNhtrk8mF54szBkzrTWbwjO5ibnfDgvjBKowtWfbUNPlJ
 1J9IZx/33+sbzPng1A1fCILdk0fEcZcIi/NUd+Evma3Rd313+BCsD4NfDiQ8jS7J5k00
 NwcX0EN4pn1ka1mofC9f+TbkNoZiWv3YVwYR9FOjn+Inomyth4ec7GotqR62I+/OTiEp
 L9KA==
X-Gm-Message-State: AOJu0YzSzjHdtspyJkn1QlebiE694u0PKB6y/D+2+aWP9AUt6ng5DR5s
 S8f2MUm4/K8piASfUt07ECOVsQ==
X-Google-Smtp-Source: AGHT+IFSwfDanQxY4jQ5BvI9U/JVyRy1EbjHe/TlH/Qvmyt/YqomZzQpH00GcypBSN5fy4Z5/J3Tsg==
X-Received: by 2002:a17:902:930a:b0:1bd:e5e7:4845 with SMTP id
 bc10-20020a170902930a00b001bde5e74845mr11723462plb.26.1694009798952; 
 Wed, 06 Sep 2023 07:16:38 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 jo6-20020a170903054600b001c1f0b3e900sm11149485plb.229.2023.09.06.07.16.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 07:16:38 -0700 (PDT)
Message-ID: <9d25f151-9b02-4332-8664-ba3cf81412f3@daynix.com>
Date: Wed, 6 Sep 2023 23:16:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v4 09/13] virtio-gpu: Handle resource blob commands
To: Huang Rui <ray.huang@amd.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 "ernunes@redhat.com" <ernunes@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Huang, Honglei1" <Honglei1.Huang@amd.com>,
 "Zhang, Julia" <Julia.Zhang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
References: <20230831093252.2461282-1-ray.huang@amd.com>
 <20230831093252.2461282-10-ray.huang@amd.com>
 <ba478789-5db0-4011-bed1-7dd6901eccd6@daynix.com> <ZPbwGA3apjQTtCeu@amd.com>
 <053ecca7-f76d-4289-9189-0c3600d4804b@daynix.com> <ZPftWfuwLKafLPah@amd.com>
 <9d883490-3c82-4016-a290-6570f682908a@daynix.com> <ZPgwnMR5YM9rFLtK@amd.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZPgwnMR5YM9rFLtK@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 2023/09/06 16:56, Huang Rui wrote:
> On Wed, Sep 06, 2023 at 11:39:09AM +0800, Akihiko Odaki wrote:
>> On 2023/09/06 12:09, Huang Rui wrote:
>>> On Tue, Sep 05, 2023 at 05:20:43PM +0800, Akihiko Odaki wrote:
>>>> On 2023/09/05 18:08, Huang Rui wrote:
>>>>> On Thu, Aug 31, 2023 at 06:24:32PM +0800, Akihiko Odaki wrote:
>>>>>> On 2023/08/31 18:32, Huang Rui wrote:
>>>>>>> From: Antonio Caggiano <antonio.caggiano@collabora.com>
>>>>>>>
>>>>>>> Support BLOB resources creation, mapping and unmapping by calling the
>>>>>>> new stable virglrenderer 0.10 interface. Only enabled when available and
>>>>>>> via the blob config. E.g. -device virtio-vga-gl,blob=true
>>>>>>>
>>>>>>> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
>>>>>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>>>>> Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
>>>>>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>>>>>>> ---
>>>>>>>
>>>>>>> v1->v2:
>>>>>>>         - Remove unused #include "hw/virtio/virtio-iommu.h"
>>>>>>>
>>>>>>>         - Add a local function, called virgl_resource_destroy(), that is used
>>>>>>>           to release a vgpu resource on error paths and in resource_unref.
>>>>>>>
>>>>>>>         - Remove virtio_gpu_virgl_resource_unmap from virtio_gpu_cleanup_mapping(),
>>>>>>>           since this function won't be called on blob resources and also because
>>>>>>>           blob resources are unmapped via virgl_cmd_resource_unmap_blob().
>>>>>>>
>>>>>>>         - In virgl_cmd_resource_create_blob(), do proper cleanup in error paths
>>>>>>>           and move QTAILQ_INSERT_HEAD(&g->reslist, res, next) after the resource
>>>>>>>           has been fully initialized.
>>>>>>>
>>>>>>>         - Memory region has a different life-cycle from virtio gpu resources
>>>>>>>           i.e. cannot be released synchronously along with the vgpu resource.
>>>>>>>           So, here the field "region" was changed to a pointer that will be
>>>>>>>           released automatically once the memory region is unparented and all
>>>>>>>           of its references have been released.
>>>>>>>           Also, since the pointer can be used to indicate whether the blob
>>>>>>>           is mapped, the explicit field "mapped" was removed.
>>>>>>>
>>>>>>>         - In virgl_cmd_resource_map_blob(), add check on the value of
>>>>>>>           res->region, to prevent beeing called twice on the same resource.
>>>>>>>
>>>>>>>         - Remove direct references to parent_obj.
>>>>>>>
>>>>>>>         - Separate declarations from code.
>>>>>>>
>>>>>>>      hw/display/virtio-gpu-virgl.c  | 213 +++++++++++++++++++++++++++++++++
>>>>>>>      hw/display/virtio-gpu.c        |   4 +-
>>>>>>>      include/hw/virtio/virtio-gpu.h |   5 +
>>>>>>>      meson.build                    |   4 +
>>>>>>>      4 files changed, 225 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>>>>>>> index 312953ec16..17b634d4ee 100644
>>>>>>> --- a/hw/display/virtio-gpu-virgl.c
>>>>>>> +++ b/hw/display/virtio-gpu-virgl.c
>>>>>>> @@ -17,6 +17,7 @@
>>>>>>>      #include "trace.h"
>>>>>>>      #include "hw/virtio/virtio.h"
>>>>>>>      #include "hw/virtio/virtio-gpu.h"
>>>>>>> +#include "hw/virtio/virtio-gpu-bswap.h"
>>>>>>>      
>>>>>>>      #include "ui/egl-helpers.h"
>>>>>>>      
>>>>>>> @@ -78,9 +79,24 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
>>>>>>>          virgl_renderer_resource_create(&args, NULL, 0);
>>>>>>>      }
>>>>>>>      
>>>>>>> +static void virgl_resource_destroy(VirtIOGPU *g,
>>>>>>> +                                   struct virtio_gpu_simple_resource *res)
>>>>>>> +{
>>>>>>> +    if (!res)
>>>>>>> +        return;
>>>>>>> +
>>>>>>> +    QTAILQ_REMOVE(&g->reslist, res, next);
>>>>>>> +
>>>>>>> +    virtio_gpu_cleanup_mapping_iov(g, res->iov, res->iov_cnt);
>>>>>>> +    g_free(res->addrs);
>>>>>>> +
>>>>>>> +    g_free(res);
>>>>>>> +}
>>>>>>> +
>>>>>>>      static void virgl_cmd_resource_unref(VirtIOGPU *g,
>>>>>>>                                           struct virtio_gpu_ctrl_command *cmd)
>>>>>>>      {
>>>>>>> +    struct virtio_gpu_simple_resource *res;
>>>>>>>          struct virtio_gpu_resource_unref unref;
>>>>>>>          struct iovec *res_iovs = NULL;
>>>>>>>          int num_iovs = 0;
>>>>>>> @@ -88,13 +104,22 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
>>>>>>>          VIRTIO_GPU_FILL_CMD(unref);
>>>>>>>          trace_virtio_gpu_cmd_res_unref(unref.resource_id);
>>>>>>>      
>>>>>>> +    res = virtio_gpu_find_resource(g, unref.resource_id);
>>>>>>> +
>>>>>>>          virgl_renderer_resource_detach_iov(unref.resource_id,
>>>>>>>                                             &res_iovs,
>>>>>>>                                             &num_iovs);
>>>>>>>          if (res_iovs != NULL && num_iovs != 0) {
>>>>>>>              virtio_gpu_cleanup_mapping_iov(g, res_iovs, num_iovs);
>>>>>>> +        if (res) {
>>>>>>> +            res->iov = NULL;
>>>>>>> +            res->iov_cnt = 0;
>>>>>>> +        }
>>>>>>>          }
>>>>>>> +
>>>>>>>          virgl_renderer_resource_unref(unref.resource_id);
>>>>>>> +
>>>>>>> +    virgl_resource_destroy(g, res);
>>>>>>>      }
>>>>>>>      
>>>>>>>      static void virgl_cmd_context_create(VirtIOGPU *g,
>>>>>>> @@ -426,6 +451,183 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
>>>>>>>          g_free(resp);
>>>>>>>      }
>>>>>>>      
>>>>>>> +#ifdef HAVE_VIRGL_RESOURCE_BLOB
>>>>>>> +
>>>>>>> +static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
>>>>>>> +                                           struct virtio_gpu_ctrl_command *cmd)
>>>>>>> +{
>>>>>>> +    struct virtio_gpu_simple_resource *res;
>>>>>>> +    struct virtio_gpu_resource_create_blob cblob;
>>>>>>> +    struct virgl_renderer_resource_create_blob_args virgl_args = { 0 };
>>>>>>> +    int ret;
>>>>>>> +
>>>>>>> +    VIRTIO_GPU_FILL_CMD(cblob);
>>>>>>> +    virtio_gpu_create_blob_bswap(&cblob);
>>>>>>> +    trace_virtio_gpu_cmd_res_create_blob(cblob.resource_id, cblob.size);
>>>>>>> +
>>>>>>> +    if (cblob.resource_id == 0) {
>>>>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed\n",
>>>>>>> +                      __func__);
>>>>>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    res = virtio_gpu_find_resource(g, cblob.resource_id);
>>>>>>> +    if (res) {
>>>>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
>>>>>>> +                      __func__, cblob.resource_id);
>>>>>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    res = g_new0(struct virtio_gpu_simple_resource, 1);
>>>>>>> +    if (!res) {
>>>>>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    res->resource_id = cblob.resource_id;
>>>>>>> +    res->blob_size = cblob.size;
>>>>>>> +
>>>>>>> +    if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
>>>>>>> +        ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
>>>>>>> +                                            cmd, &res->addrs, &res->iov,
>>>>>>> +                                            &res->iov_cnt);
>>>>>>> +        if (!ret) {
>>>>>>> +            g_free(res);
>>>>>>> +            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>>>>>> +            return;
>>>>>>> +        }
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>>>>>>> +
>>>>>>> +    virgl_args.res_handle = cblob.resource_id;
>>>>>>> +    virgl_args.ctx_id = cblob.hdr.ctx_id;
>>>>>>> +    virgl_args.blob_mem = cblob.blob_mem;
>>>>>>> +    virgl_args.blob_id = cblob.blob_id;
>>>>>>> +    virgl_args.blob_flags = cblob.blob_flags;
>>>>>>> +    virgl_args.size = cblob.size;
>>>>>>> +    virgl_args.iovecs = res->iov;
>>>>>>> +    virgl_args.num_iovs = res->iov_cnt;
>>>>>>> +
>>>>>>> +    ret = virgl_renderer_resource_create_blob(&virgl_args);
>>>>>>> +    if (ret) {
>>>>>>> +        virgl_resource_destroy(g, res);
>>>>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: virgl blob create error: %s\n",
>>>>>>> +                      __func__, strerror(-ret));
>>>>>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>>>>>> +    }
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
>>>>>>> +                                        struct virtio_gpu_ctrl_command *cmd)
>>>>>>> +{
>>>>>>> +    struct virtio_gpu_simple_resource *res;
>>>>>>> +    struct virtio_gpu_resource_map_blob mblob;
>>>>>>> +    int ret;
>>>>>>> +    void *data;
>>>>>>> +    uint64_t size;
>>>>>>> +    struct virtio_gpu_resp_map_info resp;
>>>>>>> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
>>>>>>> +
>>>>>>> +    VIRTIO_GPU_FILL_CMD(mblob);
>>>>>>> +    virtio_gpu_map_blob_bswap(&mblob);
>>>>>>> +
>>>>>>> +    if (mblob.resource_id == 0) {
>>>>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed\n",
>>>>>>> +                      __func__);
>>>>>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    res = virtio_gpu_find_resource(g, mblob.resource_id);
>>>>>>> +    if (!res) {
>>>>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist %d\n",
>>>>>>> +                      __func__, mblob.resource_id);
>>>>>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>> +    if (res->region) {
>>>>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already mapped %d\n",
>>>>>>> +		      __func__, mblob.resource_id);
>>>>>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    ret = virgl_renderer_resource_map(res->resource_id, &data, &size);
>>>>>>> +    if (ret) {
>>>>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource map error: %s\n",
>>>>>>> +                      __func__, strerror(-ret));
>>>>>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    res->region = g_new0(MemoryRegion, 1);
>>>>>>> +    if (!res->region) {
>>>>>>> +        virgl_renderer_resource_unmap(res->resource_id);
>>>>>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>> +    memory_region_init_ram_device_ptr(res->region, OBJECT(g), NULL, size, data);
>>>>>>
>>>>>> I think memory_region_init_ram_ptr() should be used instead.
>>>>>
>>>>> Would you mind to explain the reason?
>>>>
>>>> The documentation comment of memory_region_init_ram_device_ptr() says:
>>>>    > A RAM device represents a mapping to a physical device, such as to a
>>>>    > PCI MMIO BAR of an vfio-pci assigned device.  The memory region may be
>>>>    > mapped into the VM address space and access to the region will modify
>>>>    > memory directly.  However, the memory region should not be included in
>>>>    > a memory dump (device may not be enabled/mapped at the time of the
>>>>    > dump), and operations incompatible with manipulating MMIO should be
>>>>    > avoided.  Replaces skip_dump flag.
>>>>
>>>> In my understanding it's not MMIO so memory_region_init_ram_ptr() should
>>>> be used instead.
>>>>
>>>
>>> It actually maybe the video memory (mmio) or system memory here. :-)
>>>
>>> We will get the host memory for blob from host with
>>> virgl_renderer_resource_map() in virglrenderer. In virglrenderer, there are two
>>> types of VIRGL_RESOURCE_FD_DMABUF and VIRGL_RESOURCE_FD_SHM to indicate the
>>> memory types. The shmem is the system memory that won't need GPU
>>> accessible, and dmabuf is the memory that required GPU accessible. Host
>>> kernel amdgpu driver will register dma-buf to export the resource buffer
>>> for sharing, and here, it may have video memory that exposed by amdgpu pcie
>>> bar0 in the dma-buf buffers. And we also have system memory(gtt) that can
>>> be mapped as gpu page tables for gpu accessible.
>>>
>>> 07:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Renoir (rev c1) (prog-if 00 [VGA controller])
>>>           Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Renoir
>>>           Flags: bus master, fast devsel, latency 0, IRQ 56
>>>           Memory at fcc0000000 (64-bit, prefetchable) [size=256M]
>>>           Memory at fcd0000000 (64-bit, prefetchable) [size=2M]
>>>           I/O ports at 1000 [size=256]
>>>           Memory at d0400000 (32-bit, non-prefetchable) [size=512K]
>>>           Capabilities: <access denied>
>>>           Kernel driver in use: amdgpu
>>>           Kernel modules: amdgpu
>>
>> In my understanding it is not relevant if the memory is backed by device
>> or not. Here MMIO means memory-mapping I/O registers that has
>> side-effects during accesses. Reading such a register may acknowledge an
>> interrupt for example and the unit of writes may also matter.
>> memory_region_init_ram_device_ptr() ensures no supurious memory read
>> will not happen and word accesses are preserved.
>>
>> They do not matter for video memory even if it lies in a separate device
>> memory. In this sense the name "memory_region_init_ram_device_ptr" is
>> somewhat misnomer.
>>
> 
> OK. Thanks for the clarification.
> 
> After traced the code, if memory_region_init_ram_device_ptr(), it will use
> memory_region_dispatch_write() to call into memory_region_ram_device_write()
> which registered as ram_device_mem_ops to write ram_block->host with offset
> dword by dword. And if we use memory_region_init_ram_ptr(), the
> flatview_write_continue() will use memmove() to write buf into ramblock while
> we write the blob memory. May I know whether you mean the "memmove" may have an
> interrupt or supurious memory access?

memmove can split one word write into smaller writes and that is 
implementation dependent.

git blame is your friend if you want to know more. Particularly commits 
21e00fa55f ("memory: Replace skip_dump flag with "ram_device"") and 
4a2e242bbb ("memory: Don't use memcpy for ram_device regions" [the 
memmove call was used to be memcpy) may interest you.

Regards,
Akihiko Odaki

