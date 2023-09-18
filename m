Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FB07A44ED
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:40:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi9n2-000488-2q; Mon, 18 Sep 2023 04:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qi9ml-00041C-I2
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:39:15 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qi9mg-0005RU-21
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:39:15 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c453379020so10257565ad.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 01:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695026348; x=1695631148;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=86S1E2SVzAB27OLsEt+LUsAzMa8JftTI6gWOZFMAcyA=;
 b=D3lS9rbQvENBDOxLiTxtC8N4e781zFoS6aKjukm4xFp7PKzCetisrhO0p2EFGL5/77
 GTVp1uXJ9BwJMFj3Q5gZS46FPfl1PM/6CCww+xuHVsPBBw9+zWq08x4+3AO1OOaF09kd
 CrKwcT9HFm7G5X+dE7m1ltt1OGEX0xqoLdJ3UdT2Xn1QgKs3Dv0RWWtlgDRX+953rhxi
 OapgiPb8tVQqJPmUKebwflj6bT3JNGnpRGXZZllo/970pjOG/LRLLILusgeVmnetAWEK
 YZZeZUDX+UNMMsncsYatj7X1Vv9fiN0GzpfM28QiuETKIMLi4kjUB0dyoI4wrrLjN2yB
 xOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695026348; x=1695631148;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=86S1E2SVzAB27OLsEt+LUsAzMa8JftTI6gWOZFMAcyA=;
 b=WRoOdpv1VEyFFj4llCS7BzqwKLWdGQscfV+ENG7NdPAkoYxdbbI6jQqlMGhNalfO3A
 Y4k1ZagEyWDmuH55olxE5l12RlPiYAkUone+XPQ0CCzl7jO15gXAgFBs/k1c/sblXVTa
 bbwzzJPrs3YeFWIMhaYGsh8XkkVadWOII0DjXqK5ll2BhwugsMZemgYBHJRd+qpk3Qzy
 mx3LWrxPOOeyuEd7CoVNfGQ7Ha2RkR+OdDSxC8sc1IEm5ee/Gcr0fDnnreVCIMnF7Gbd
 y+gbB/w/a8wI9nOzG/v+HwsfPwx+h01triD0OzhN7/AELN1F7IvOKApf+Y7g0Ym8kZjl
 /ehw==
X-Gm-Message-State: AOJu0YyezcHjR9HnlCFBkg2jX+20gewvfxFGo2b0E9dCeHjveogPqx6s
 2W8n2SjB38Bc9OZl7jac4mKQhA==
X-Google-Smtp-Source: AGHT+IFnG4h21bBJscaRI9/WbdBI/7X4MedLqwJ3DeBs2xacVGWKVRE5g8uqOclAUe6SrodK0GpB4g==
X-Received: by 2002:a17:902:e852:b0:1b9:e937:9763 with SMTP id
 t18-20020a170902e85200b001b9e9379763mr8449574plg.12.1695026348445; 
 Mon, 18 Sep 2023 01:39:08 -0700 (PDT)
Received: from [157.82.205.33] ([157.82.205.33])
 by smtp.gmail.com with ESMTPSA id
 jc12-20020a17090325cc00b001bf574dd1fesm4492656plb.141.2023.09.18.01.39.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 01:39:08 -0700 (PDT)
Message-ID: <b37f1c2d-1655-45b5-a2fb-bd9f3fbabd36@daynix.com>
Date: Mon, 18 Sep 2023 17:39:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v5 09/13] virtio-gpu: Handle resource blob commands
Content-Language: en-US
To: Huang Rui <ray.huang@amd.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Albert Esteve <aesteve@redhat.com>, "ernunes@redhat.com"
 <ernunes@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Huang, Honglei1" <Honglei1.Huang@amd.com>,
 "Zhang, Julia" <Julia.Zhang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>
References: <20230915111130.24064-1-ray.huang@amd.com>
 <20230915111130.24064-10-ray.huang@amd.com>
 <a14b26dc-c804-4be8-83d5-088e71d37a7b@daynix.com> <ZQgL89xUESe5JZ0o@amd.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZQgL89xUESe5JZ0o@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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

On 2023/09/18 17:36, Huang Rui wrote:
> On Sat, Sep 16, 2023 at 12:04:17AM +0800, Akihiko Odaki wrote:
>> On 2023/09/15 20:11, Huang Rui wrote:
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
>>> V4 -> V5:
>>>       - Use memory_region_init_ram_ptr() instead of
>>>         memory_region_init_ram_device_ptr() (Akihiko)
>>>
>>>    hw/display/virtio-gpu-virgl.c  | 213 +++++++++++++++++++++++++++++++++
>>>    hw/display/virtio-gpu.c        |   4 +-
>>>    include/hw/virtio/virtio-gpu.h |   5 +
>>>    meson.build                    |   4 +
>>>    4 files changed, 225 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>>> index 312953ec16..563a6f2f58 100644
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
>>> +    memory_region_init_ram_ptr(res->region, OBJECT(g), NULL, size, data);
>>> +    OBJECT(res->region)->free = g_free;
>>> +    memory_region_add_subregion(&b->hostmem, mblob.offset, res->region);
>>> +    memory_region_set_enabled(res->region, true);
>>> +
>>> +    memset(&resp, 0, sizeof(resp));
>>> +    resp.hdr.type = VIRTIO_GPU_RESP_OK_MAP_INFO;
>>> +    virgl_renderer_resource_get_map_info(mblob.resource_id, &resp.map_info);
>>> +    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
>>> +}
>>> +
>>> +static int virtio_gpu_virgl_resource_unmap(VirtIOGPU *g,
>>> +                                           struct virtio_gpu_simple_resource
>>> +                                           *res)
>>> +{
>>> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
>>> +
>>> +    if (!res) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already unmapped %d\n",
>>> +                      __func__, res->resource_id);
>>> +        return VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>>
>> This returns enum virtio_gpu_ctrl_type while
>> virgl_renderer_resource_unmap() returns -errno and the returned error
>> code is ignored.
>>
>> I think you can just inline this function into
>> virgl_cmd_resource_unmap_blob(). It will be more concise and consistent
>> with virgl_cmd_resource_map_blob().
> 
> OK, will update in V2.
> 
>>
>>> +    }
>>> +
>>> +    memory_region_set_enabled(res->region, false);
>>> +    memory_region_del_subregion(&b->hostmem, res->region);
>>> +    object_unparent(OBJECT(res->region));
>>> +    res->region = NULL;
>>> +
>>> +    return virgl_renderer_resource_unmap(res->resource_id);
>>> +}
>>> +
>>> +static void virgl_cmd_resource_unmap_blob(VirtIOGPU *g,
>>> +                                          struct virtio_gpu_ctrl_command *cmd)
>>> +{
>>> +    struct virtio_gpu_simple_resource *res;
>>> +    struct virtio_gpu_resource_unmap_blob ublob;
>>> +    VIRTIO_GPU_FILL_CMD(ublob);
>>> +    virtio_gpu_unmap_blob_bswap(&ublob);
>>> +
>>> +    if (ublob.resource_id == 0) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed\n",
>>> +                      __func__);
>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>>> +        return;
>>> +    }
>>> +
>>> +    res = virtio_gpu_find_resource(g, ublob.resource_id);
>>> +    if (!res) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist %d\n",
>>> +                      __func__, ublob.resource_id);
>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>>> +        return;
>>> +    }
>>> +
>>> +    virtio_gpu_virgl_resource_unmap(g, res);
>>> +}
>>> +
>>> +#endif /* HAVE_VIRGL_RESOURCE_BLOB */
>>> +
>>>    void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>>>                                          struct virtio_gpu_ctrl_command *cmd)
>>>    {
>>> @@ -492,6 +694,17 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>>>        case VIRTIO_GPU_CMD_GET_EDID:
>>>            virtio_gpu_get_edid(g, cmd);
>>>            break;
>>> +#ifdef HAVE_VIRGL_RESOURCE_BLOB
>>> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB:
>>> +        virgl_cmd_resource_create_blob(g, cmd);
>>> +        break;
>>> +    case VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB:
>>> +        virgl_cmd_resource_map_blob(g, cmd);
>>> +        break;
>>> +    case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:
>>> +        virgl_cmd_resource_unmap_blob(g, cmd);
>>> +        break;
>>> +#endif /* HAVE_VIRGL_RESOURCE_BLOB */
>>>        default:
>>>            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>>            break;
>>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>>> index 5b7a7eab4f..cc4c1f81bb 100644
>>> --- a/hw/display/virtio-gpu.c
>>> +++ b/hw/display/virtio-gpu.c
>>> @@ -1367,10 +1367,12 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>>>                return;
>>>            }
>>>    
>>> +#ifndef HAVE_VIRGL_RESOURCE_BLOB
>>>            if (virtio_gpu_virgl_enabled(g->parent_obj.conf)) {
>>> -            error_setg(errp, "blobs and virgl are not compatible (yet)");
>>> +            error_setg(errp, "Linked virglrenderer does not support blob resources");
>>>                return;
>>>            }
>>> +#endif
>>>        }
>>>    
>>>        if (!virtio_gpu_base_device_realize(qdev,
>>> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
>>> index 55973e112f..b9adc28071 100644
>>> --- a/include/hw/virtio/virtio-gpu.h
>>> +++ b/include/hw/virtio/virtio-gpu.h
>>> @@ -58,6 +58,11 @@ struct virtio_gpu_simple_resource {
>>>        int dmabuf_fd;
>>>        uint8_t *remapped;
>>>    
>>> +#ifdef HAVE_VIRGL_RESOURCE_BLOB
>>> +    /* only blob resource needs this region to be mapped as guest mmio */
>>> +    MemoryRegion *region;
>>> +#endif
>>> +
>>
>> Since this is specific to virgl, let's create a struct that embeds
>> virtio_gpu_simple_resource and use it to avoid modifying virtio-gpu
>> common code.
> 
> I am thinking should I modify the whole virtio-gpu-virgl.c to use the new
> struct like virgl_gpu_resource which has virtio_gpu_simple_resource
> embedded? Then in virgl, we can use this structure to indicate the resource
> for virglrenderer.

Yes, that's what I suggest.

