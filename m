Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5C5792165
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 11:21:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdSEz-0006Rz-2g; Tue, 05 Sep 2023 05:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qdSEw-0006Qd-MF
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:20:54 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qdSEs-0005zp-R6
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:20:54 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c336f5b1ffso14102305ad.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 02:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693905649; x=1694510449;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=noZcTROyvKGLT7OS+tdoVzmRn0DMVveNoAJHiI7S8hA=;
 b=Bozs96pOQSVaz5Ys030KV6V1L1zv4TUgvz4iww8eJsqXMd43ssuONcHOACJ76Xn/KY
 nNDOeptkXlvCu62a+LnwZPqTIDEfSp2wMafGAk0Lf2mL99w09Hk1PUYjyRMRx0tFS4zG
 z1S23hLAjq4QLOYpQhiXvqULZl4jsHc80xbuHVk+4Pl3MwEHqwqaIupOIfhcAL2F+AO+
 A0SCvWcceH9Qie3XeRDLX5hrCPkC5vYqWUUIXfWLehG1qe/p2P1x0z2H+DtMDgkLzVO/
 QY1BWDg+li/V51il8cBYmM+s9LUSqqW7EgHZhLq1ki2Rp2ISQAfInxu7da5grz8J2PMw
 qZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693905649; x=1694510449;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=noZcTROyvKGLT7OS+tdoVzmRn0DMVveNoAJHiI7S8hA=;
 b=RTFtrg2bXXb3yqORh3bCxwEF/j9W7/+ZdEcmb3TCW0Kof8JqCK22wNzc4MVxnE53JC
 6JIpgG+yKqrB89bpI0Vn2RRv1Y7mfdLjf/Licb8YvSPjj8Azce+5cwdpLHzLD3dGAdsp
 Qg58fn9pRsrDdGMPfMW33VNENCNAn2wtBxCrrSli4tjirims9ewt5JdW/2X/3J96gRRx
 q/cUyo22xaOSjYbpdn9jWlMC4zcVrgrskHcnsDpphjr7XW1pheUaP/GcE7C8qmq76chL
 EsTK2y3T9FEdsoXA5PReVLc/7aRMn9KWoNVTkX/5Brj7BUc3vusGEnCKCaW9D17Zz3C4
 N4YA==
X-Gm-Message-State: AOJu0YxNn9QLOdEg5aytHz0bdsRQfKp2FEjqRuTl6BefJd7nn8F0ZG/l
 JtOnELSCdkziERT8R1xwI0E+JA==
X-Google-Smtp-Source: AGHT+IFen8AN/Q9ef6hgMdPtr3VaUTRz2tC5gD2pyhrsBICbeDQj1dG7i6bKZTSjkHSDp79ReDyy8g==
X-Received: by 2002:a17:902:e84e:b0:1c3:4565:225 with SMTP id
 t14-20020a170902e84e00b001c345650225mr3760241plg.10.1693905649240; 
 Tue, 05 Sep 2023 02:20:49 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 ju20-20020a170903429400b001b672af624esm8931499plb.164.2023.09.05.02.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 02:20:48 -0700 (PDT)
Message-ID: <053ecca7-f76d-4289-9189-0c3600d4804b@daynix.com>
Date: Tue, 5 Sep 2023 18:20:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v4 09/13] virtio-gpu: Handle resource blob commands
Content-Language: en-US
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
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZPbwGA3apjQTtCeu@amd.com>
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

On 2023/09/05 18:08, Huang Rui wrote:
> On Thu, Aug 31, 2023 at 06:24:32PM +0800, Akihiko Odaki wrote:
>> On 2023/08/31 18:32, Huang Rui wrote:
>>> From: Antonio Caggiano <antonio.caggiano@collabora.com>
>>>
>>> Support BLOB resources creation, mapping and unmapping by calling the
>>> new stable virglrenderer 0.10 interface. Only enabled when available and
>>> via the blob config. E.g. -device virtio-vga-gl,blob=true
>>>
>>> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>>> ---
>>>
>>> v1->v2:
>>>       - Remove unused #include "hw/virtio/virtio-iommu.h"
>>>
>>>       - Add a local function, called virgl_resource_destroy(), that is used
>>>         to release a vgpu resource on error paths and in resource_unref.
>>>
>>>       - Remove virtio_gpu_virgl_resource_unmap from virtio_gpu_cleanup_mapping(),
>>>         since this function won't be called on blob resources and also because
>>>         blob resources are unmapped via virgl_cmd_resource_unmap_blob().
>>>
>>>       - In virgl_cmd_resource_create_blob(), do proper cleanup in error paths
>>>         and move QTAILQ_INSERT_HEAD(&g->reslist, res, next) after the resource
>>>         has been fully initialized.
>>>
>>>       - Memory region has a different life-cycle from virtio gpu resources
>>>         i.e. cannot be released synchronously along with the vgpu resource.
>>>         So, here the field "region" was changed to a pointer that will be
>>>         released automatically once the memory region is unparented and all
>>>         of its references have been released.
>>>         Also, since the pointer can be used to indicate whether the blob
>>>         is mapped, the explicit field "mapped" was removed.
>>>
>>>       - In virgl_cmd_resource_map_blob(), add check on the value of
>>>         res->region, to prevent beeing called twice on the same resource.
>>>
>>>       - Remove direct references to parent_obj.
>>>
>>>       - Separate declarations from code.
>>>
>>>    hw/display/virtio-gpu-virgl.c  | 213 +++++++++++++++++++++++++++++++++
>>>    hw/display/virtio-gpu.c        |   4 +-
>>>    include/hw/virtio/virtio-gpu.h |   5 +
>>>    meson.build                    |   4 +
>>>    4 files changed, 225 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>>> index 312953ec16..17b634d4ee 100644
>>> --- a/hw/display/virtio-gpu-virgl.c
>>> +++ b/hw/display/virtio-gpu-virgl.c
>>> @@ -17,6 +17,7 @@
>>>    #include "trace.h"
>>>    #include "hw/virtio/virtio.h"
>>>    #include "hw/virtio/virtio-gpu.h"
>>> +#include "hw/virtio/virtio-gpu-bswap.h"
>>>    
>>>    #include "ui/egl-helpers.h"
>>>    
>>> @@ -78,9 +79,24 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
>>>        virgl_renderer_resource_create(&args, NULL, 0);
>>>    }
>>>    
>>> +static void virgl_resource_destroy(VirtIOGPU *g,
>>> +                                   struct virtio_gpu_simple_resource *res)
>>> +{
>>> +    if (!res)
>>> +        return;
>>> +
>>> +    QTAILQ_REMOVE(&g->reslist, res, next);
>>> +
>>> +    virtio_gpu_cleanup_mapping_iov(g, res->iov, res->iov_cnt);
>>> +    g_free(res->addrs);
>>> +
>>> +    g_free(res);
>>> +}
>>> +
>>>    static void virgl_cmd_resource_unref(VirtIOGPU *g,
>>>                                         struct virtio_gpu_ctrl_command *cmd)
>>>    {
>>> +    struct virtio_gpu_simple_resource *res;
>>>        struct virtio_gpu_resource_unref unref;
>>>        struct iovec *res_iovs = NULL;
>>>        int num_iovs = 0;
>>> @@ -88,13 +104,22 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
>>>        VIRTIO_GPU_FILL_CMD(unref);
>>>        trace_virtio_gpu_cmd_res_unref(unref.resource_id);
>>>    
>>> +    res = virtio_gpu_find_resource(g, unref.resource_id);
>>> +
>>>        virgl_renderer_resource_detach_iov(unref.resource_id,
>>>                                           &res_iovs,
>>>                                           &num_iovs);
>>>        if (res_iovs != NULL && num_iovs != 0) {
>>>            virtio_gpu_cleanup_mapping_iov(g, res_iovs, num_iovs);
>>> +        if (res) {
>>> +            res->iov = NULL;
>>> +            res->iov_cnt = 0;
>>> +        }
>>>        }
>>> +
>>>        virgl_renderer_resource_unref(unref.resource_id);
>>> +
>>> +    virgl_resource_destroy(g, res);
>>>    }
>>>    
>>>    static void virgl_cmd_context_create(VirtIOGPU *g,
>>> @@ -426,6 +451,183 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
>>>        g_free(resp);
>>>    }
>>>    
>>> +#ifdef HAVE_VIRGL_RESOURCE_BLOB
>>> +
>>> +static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
>>> +                                           struct virtio_gpu_ctrl_command *cmd)
>>> +{
>>> +    struct virtio_gpu_simple_resource *res;
>>> +    struct virtio_gpu_resource_create_blob cblob;
>>> +    struct virgl_renderer_resource_create_blob_args virgl_args = { 0 };
>>> +    int ret;
>>> +
>>> +    VIRTIO_GPU_FILL_CMD(cblob);
>>> +    virtio_gpu_create_blob_bswap(&cblob);
>>> +    trace_virtio_gpu_cmd_res_create_blob(cblob.resource_id, cblob.size);
>>> +
>>> +    if (cblob.resource_id == 0) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed\n",
>>> +                      __func__);
>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>>> +        return;
>>> +    }
>>> +
>>> +    res = virtio_gpu_find_resource(g, cblob.resource_id);
>>> +    if (res) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
>>> +                      __func__, cblob.resource_id);
>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>>> +        return;
>>> +    }
>>> +
>>> +    res = g_new0(struct virtio_gpu_simple_resource, 1);
>>> +    if (!res) {
>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
>>> +        return;
>>> +    }
>>> +
>>> +    res->resource_id = cblob.resource_id;
>>> +    res->blob_size = cblob.size;
>>> +
>>> +    if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
>>> +        ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
>>> +                                            cmd, &res->addrs, &res->iov,
>>> +                                            &res->iov_cnt);
>>> +        if (!ret) {
>>> +            g_free(res);
>>> +            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>> +            return;
>>> +        }
>>> +    }
>>> +
>>> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>>> +
>>> +    virgl_args.res_handle = cblob.resource_id;
>>> +    virgl_args.ctx_id = cblob.hdr.ctx_id;
>>> +    virgl_args.blob_mem = cblob.blob_mem;
>>> +    virgl_args.blob_id = cblob.blob_id;
>>> +    virgl_args.blob_flags = cblob.blob_flags;
>>> +    virgl_args.size = cblob.size;
>>> +    virgl_args.iovecs = res->iov;
>>> +    virgl_args.num_iovs = res->iov_cnt;
>>> +
>>> +    ret = virgl_renderer_resource_create_blob(&virgl_args);
>>> +    if (ret) {
>>> +        virgl_resource_destroy(g, res);
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: virgl blob create error: %s\n",
>>> +                      __func__, strerror(-ret));
>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>> +    }
>>> +}
>>> +
>>> +static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
>>> +                                        struct virtio_gpu_ctrl_command *cmd)
>>> +{
>>> +    struct virtio_gpu_simple_resource *res;
>>> +    struct virtio_gpu_resource_map_blob mblob;
>>> +    int ret;
>>> +    void *data;
>>> +    uint64_t size;
>>> +    struct virtio_gpu_resp_map_info resp;
>>> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
>>> +
>>> +    VIRTIO_GPU_FILL_CMD(mblob);
>>> +    virtio_gpu_map_blob_bswap(&mblob);
>>> +
>>> +    if (mblob.resource_id == 0) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed\n",
>>> +                      __func__);
>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>>> +        return;
>>> +    }
>>> +
>>> +    res = virtio_gpu_find_resource(g, mblob.resource_id);
>>> +    if (!res) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist %d\n",
>>> +                      __func__, mblob.resource_id);
>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>>> +        return;
>>> +    }
>>> +    if (res->region) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already mapped %d\n",
>>> +		      __func__, mblob.resource_id);
>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>>> +        return;
>>> +    }
>>> +
>>> +    ret = virgl_renderer_resource_map(res->resource_id, &data, &size);
>>> +    if (ret) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource map error: %s\n",
>>> +                      __func__, strerror(-ret));
>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>>> +        return;
>>> +    }
>>> +
>>> +    res->region = g_new0(MemoryRegion, 1);
>>> +    if (!res->region) {
>>> +        virgl_renderer_resource_unmap(res->resource_id);
>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
>>> +        return;
>>> +    }
>>> +    memory_region_init_ram_device_ptr(res->region, OBJECT(g), NULL, size, data);
>>
>> I think memory_region_init_ram_ptr() should be used instead.
> 
> Would you mind to explain the reason?

The documentation comment of memory_region_init_ram_device_ptr() says:
 > A RAM device represents a mapping to a physical device, such as to a
 > PCI MMIO BAR of an vfio-pci assigned device.  The memory region may be
 > mapped into the VM address space and access to the region will modify
 > memory directly.  However, the memory region should not be included in
 > a memory dump (device may not be enabled/mapped at the time of the
 > dump), and operations incompatible with manipulating MMIO should be
 > avoided.  Replaces skip_dump flag.

In my understanding it's not MMIO so memory_region_init_ram_ptr() should 
be used instead.

Regards,
Akihiko Odaki

