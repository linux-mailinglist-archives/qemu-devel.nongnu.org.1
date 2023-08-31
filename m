Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2674678EA24
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:26:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbeqy-0008Ot-57; Thu, 31 Aug 2023 06:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qbeqw-0008Oc-9I
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:24:42 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qbeqt-0007ZZ-DU
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:24:42 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-564af0ac494so549638a12.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693477478; x=1694082278;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GT2ML8crheS73wRMI+Sy5kWTw+VLsH9mZg25anukBf4=;
 b=ZfzM++ZrInZGpqsW6WnhBnof+Tq0YioXHpswxQPimt2x2MOyy4ATmIi6uBwZqaZmYY
 LMiv8nVPxqV35zSj8/BJVQffOj5BOlo45an6+HCzTCC/HJo/MXDXLqgeXGHydhxRNg3q
 OLb4D9gQxUw9sBSaMK8Ruo8leC2WcrIojBvmVBU4owGI18cW0L4G403KMVA+3Gmo1haO
 MuDt9A9/H4lcY1d1ennyE+U4tSdlWlusUARBuwI0qGoJxr9bRvvmKyhAtYzQQO67zJxZ
 PF7P6HQk3NRj1LMPDVb419glal8utjyqOpl32Fgvr3UtaIx8GSUwG7ctQmG7wxty8fXq
 DaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693477478; x=1694082278;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GT2ML8crheS73wRMI+Sy5kWTw+VLsH9mZg25anukBf4=;
 b=Ryvfq9sq6yDF3tPCCx4v5RXzGtFkdO+vGTFES2sBk5nYIkB5XUCRLdZaAZK/F6bmT0
 B17/4JXPZTB33ZTY0K6iyNi1T9NeaV3WZoNsEhIrbK+HV6v8b/0+Uv5O+b9j+A3dav4/
 qIQ7wTS2z0kMCAL7ld/6MWjnuqLXy0PBB3zEK8qC8Pq3guS4y9DRyO3ZRPkQ2Ma47Pku
 46+yIwkL+x2JvvHa8YcZ9kM5SKCVggMdEhWDSWe+eb+5c8ENOB8SoaEoq/NxrJ5kfAOv
 oRrW/nazpT5VoUiiphTFciEwiZMVb0Dmm/K2L26pe4Z1cXru6M7Cod446eb8e6WYU5eZ
 9n9g==
X-Gm-Message-State: AOJu0YxHXuGLTJoxhKRq3iMlGhxSA5gvb7wAUQtqoKgIXB67ZqRDHsLp
 tsiJndkTEko82qF6pD/vx8LjVA==
X-Google-Smtp-Source: AGHT+IGcYJn+WIPGNSXx7TlUjrHKHWIGou0hXGU08zidD9LgTAkPoArZK+Pr9SfwLNBJi8oHxsJTEA==
X-Received: by 2002:a05:6a20:2444:b0:14e:3ba7:2933 with SMTP id
 t4-20020a056a20244400b0014e3ba72933mr5415271pzc.54.1693477478052; 
 Thu, 31 Aug 2023 03:24:38 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 4-20020a170902e9c400b001b86dd825e7sm956213plk.108.2023.08.31.03.24.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 03:24:37 -0700 (PDT)
Message-ID: <ba478789-5db0-4011-bed1-7dd6901eccd6@daynix.com>
Date: Thu, 31 Aug 2023 19:24:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v4 09/13] virtio-gpu: Handle resource blob commands
Content-Language: en-US
To: Huang Rui <ray.huang@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>
References: <20230831093252.2461282-1-ray.huang@amd.com>
 <20230831093252.2461282-10-ray.huang@amd.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230831093252.2461282-10-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
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

On 2023/08/31 18:32, Huang Rui wrote:
> From: Antonio Caggiano <antonio.caggiano@collabora.com>
> 
> Support BLOB resources creation, mapping and unmapping by calling the
> new stable virglrenderer 0.10 interface. Only enabled when available and
> via the blob config. E.g. -device virtio-vga-gl,blob=true
> 
> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
> 
> v1->v2:
>      - Remove unused #include "hw/virtio/virtio-iommu.h"
> 
>      - Add a local function, called virgl_resource_destroy(), that is used
>        to release a vgpu resource on error paths and in resource_unref.
> 
>      - Remove virtio_gpu_virgl_resource_unmap from virtio_gpu_cleanup_mapping(),
>        since this function won't be called on blob resources and also because
>        blob resources are unmapped via virgl_cmd_resource_unmap_blob().
> 
>      - In virgl_cmd_resource_create_blob(), do proper cleanup in error paths
>        and move QTAILQ_INSERT_HEAD(&g->reslist, res, next) after the resource
>        has been fully initialized.
> 
>      - Memory region has a different life-cycle from virtio gpu resources
>        i.e. cannot be released synchronously along with the vgpu resource.
>        So, here the field "region" was changed to a pointer that will be
>        released automatically once the memory region is unparented and all
>        of its references have been released.
>        Also, since the pointer can be used to indicate whether the blob
>        is mapped, the explicit field "mapped" was removed.
> 
>      - In virgl_cmd_resource_map_blob(), add check on the value of
>        res->region, to prevent beeing called twice on the same resource.
> 
>      - Remove direct references to parent_obj.
> 
>      - Separate declarations from code.
> 
>   hw/display/virtio-gpu-virgl.c  | 213 +++++++++++++++++++++++++++++++++
>   hw/display/virtio-gpu.c        |   4 +-
>   include/hw/virtio/virtio-gpu.h |   5 +
>   meson.build                    |   4 +
>   4 files changed, 225 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 312953ec16..17b634d4ee 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -17,6 +17,7 @@
>   #include "trace.h"
>   #include "hw/virtio/virtio.h"
>   #include "hw/virtio/virtio-gpu.h"
> +#include "hw/virtio/virtio-gpu-bswap.h"
>   
>   #include "ui/egl-helpers.h"
>   
> @@ -78,9 +79,24 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
>       virgl_renderer_resource_create(&args, NULL, 0);
>   }
>   
> +static void virgl_resource_destroy(VirtIOGPU *g,
> +                                   struct virtio_gpu_simple_resource *res)
> +{
> +    if (!res)
> +        return;
> +
> +    QTAILQ_REMOVE(&g->reslist, res, next);
> +
> +    virtio_gpu_cleanup_mapping_iov(g, res->iov, res->iov_cnt);
> +    g_free(res->addrs);
> +
> +    g_free(res);
> +}
> +
>   static void virgl_cmd_resource_unref(VirtIOGPU *g,
>                                        struct virtio_gpu_ctrl_command *cmd)
>   {
> +    struct virtio_gpu_simple_resource *res;
>       struct virtio_gpu_resource_unref unref;
>       struct iovec *res_iovs = NULL;
>       int num_iovs = 0;
> @@ -88,13 +104,22 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
>       VIRTIO_GPU_FILL_CMD(unref);
>       trace_virtio_gpu_cmd_res_unref(unref.resource_id);
>   
> +    res = virtio_gpu_find_resource(g, unref.resource_id);
> +
>       virgl_renderer_resource_detach_iov(unref.resource_id,
>                                          &res_iovs,
>                                          &num_iovs);
>       if (res_iovs != NULL && num_iovs != 0) {
>           virtio_gpu_cleanup_mapping_iov(g, res_iovs, num_iovs);
> +        if (res) {
> +            res->iov = NULL;
> +            res->iov_cnt = 0;
> +        }
>       }
> +
>       virgl_renderer_resource_unref(unref.resource_id);
> +
> +    virgl_resource_destroy(g, res);
>   }
>   
>   static void virgl_cmd_context_create(VirtIOGPU *g,
> @@ -426,6 +451,183 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
>       g_free(resp);
>   }
>   
> +#ifdef HAVE_VIRGL_RESOURCE_BLOB
> +
> +static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
> +                                           struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_create_blob cblob;
> +    struct virgl_renderer_resource_create_blob_args virgl_args = { 0 };
> +    int ret;
> +
> +    VIRTIO_GPU_FILL_CMD(cblob);
> +    virtio_gpu_create_blob_bswap(&cblob);
> +    trace_virtio_gpu_cmd_res_create_blob(cblob.resource_id, cblob.size);
> +
> +    if (cblob.resource_id == 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed\n",
> +                      __func__);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    res = virtio_gpu_find_resource(g, cblob.resource_id);
> +    if (res) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
> +                      __func__, cblob.resource_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    res = g_new0(struct virtio_gpu_simple_resource, 1);
> +    if (!res) {
> +        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> +        return;
> +    }
> +
> +    res->resource_id = cblob.resource_id;
> +    res->blob_size = cblob.size;
> +
> +    if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
> +        ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
> +                                            cmd, &res->addrs, &res->iov,
> +                                            &res->iov_cnt);
> +        if (!ret) {
> +            g_free(res);
> +            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
> +            return;
> +        }
> +    }
> +
> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
> +
> +    virgl_args.res_handle = cblob.resource_id;
> +    virgl_args.ctx_id = cblob.hdr.ctx_id;
> +    virgl_args.blob_mem = cblob.blob_mem;
> +    virgl_args.blob_id = cblob.blob_id;
> +    virgl_args.blob_flags = cblob.blob_flags;
> +    virgl_args.size = cblob.size;
> +    virgl_args.iovecs = res->iov;
> +    virgl_args.num_iovs = res->iov_cnt;
> +
> +    ret = virgl_renderer_resource_create_blob(&virgl_args);
> +    if (ret) {
> +        virgl_resource_destroy(g, res);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: virgl blob create error: %s\n",
> +                      __func__, strerror(-ret));
> +        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
> +    }
> +}
> +
> +static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
> +                                        struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_map_blob mblob;
> +    int ret;
> +    void *data;
> +    uint64_t size;
> +    struct virtio_gpu_resp_map_info resp;
> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
> +
> +    VIRTIO_GPU_FILL_CMD(mblob);
> +    virtio_gpu_map_blob_bswap(&mblob);
> +
> +    if (mblob.resource_id == 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed\n",
> +                      __func__);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    res = virtio_gpu_find_resource(g, mblob.resource_id);
> +    if (!res) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist %d\n",
> +                      __func__, mblob.resource_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +    if (res->region) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already mapped %d\n",
> +		      __func__, mblob.resource_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    ret = virgl_renderer_resource_map(res->resource_id, &data, &size);
> +    if (ret) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource map error: %s\n",
> +                      __func__, strerror(-ret));
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    res->region = g_new0(MemoryRegion, 1);
> +    if (!res->region) {
> +        virgl_renderer_resource_unmap(res->resource_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> +        return;
> +    }
> +    memory_region_init_ram_device_ptr(res->region, OBJECT(g), NULL, size, data);

I think memory_region_init_ram_ptr() should be used instead.

