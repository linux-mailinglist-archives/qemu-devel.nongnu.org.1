Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC7178EA4D
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:38:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbf33-0002VM-EH; Thu, 31 Aug 2023 06:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qbf2y-0002GM-43
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:37:10 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qbf2u-0002bz-Rg
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:37:07 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68a3ced3ec6so539629b3a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693478223; x=1694083023;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x1CBF2DbVWJ7MmkNFKmcN6oQhqjuvRQMB9TRzzaFFGM=;
 b=QDSRqvYmxVhOJVyvta/2zBL682XOuFu0uzXKLLFZVcC7gOzTOwFF0dKT5qzerDtJJA
 eHiF+n04RgMGU1wh//h3KNW3uGAUl2jmfJXfptre1BScvOvtlE54CkbqaXqXXhzycJeB
 Tev9Do+6JbMNSp8G0dQPp64xwkOFtzmEqqVG/T4qvFqAN9O2qbpgLUwEMJZmf+03bz5A
 DZ8SemuvodmXyFk8OtQhHKUAsB1tfU2gucBwRdAFo7L8mcZ4W6mGsj45nz6JV/S5e6Ep
 Ny6d1Wvg7V53vd/iHumhBT6fidsqWWz3e0gzcZ6CaWISh4MTXYL12LkBVSQh0sy4nV7T
 tjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478223; x=1694083023;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x1CBF2DbVWJ7MmkNFKmcN6oQhqjuvRQMB9TRzzaFFGM=;
 b=lZAR9mRk/fMXhPEUTCqXnQYmeEZV9vwPqz9hE2Ifwem9C9xjPaEngF9ggBckzUfCRT
 9P8RjIWsAvofFaE1CcoEAOCtRdcFjHjipBFDZ5siJgQSlKWKXiAfs8o7OguqE0TqhXY3
 oBvJKNLwe7FYGrjTJLZjukKEOEgcTnynSM2bvOj5eGR1f0HwlUhlif1KC81hS7Mkn1qV
 cO+fO3FqBgGl3kx4CRdM5N2miqvCOYzaADbotzKTW1fFS50iEck02SPhizkcMp60oFip
 iBQTF3aqWAIerVcKBzrZIeVpvnEl4JLR/nwZsvdB8Dy8mDlurYaayGUTVkQnVb3MM3HG
 pDcQ==
X-Gm-Message-State: AOJu0YzqjJKl0Z0H+xqwJt4DNQZJo1y+lzBLw75cFTTPULA7Xrjco8E3
 HhtaR+sjMSFEi+psjhiJOZQcng==
X-Google-Smtp-Source: AGHT+IEF3CYXtyDqMtjxE7/P7YvpXlrVr0cGJBsDe1GvSRkqCUzQ5Xu2dJo9nxBb6UC77ADxyrv+xw==
X-Received: by 2002:a05:6a00:22cb:b0:68a:6833:d936 with SMTP id
 f11-20020a056a0022cb00b0068a6833d936mr5816737pfj.15.1693478223275; 
 Thu, 31 Aug 2023 03:37:03 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 j15-20020aa78d0f000000b00686ec858fb0sm1051735pfe.190.2023.08.31.03.36.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 03:37:02 -0700 (PDT)
Message-ID: <58a4e81f-b0ce-49db-8a6a-f6b5bdc3d2d6@daynix.com>
Date: Thu, 31 Aug 2023 19:36:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v4 10/13] virtio-gpu: Resource UUID
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
 <20230831093252.2461282-11-ray.huang@amd.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230831093252.2461282-11-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
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
> Enable resource UUID feature and implement command resource assign UUID.
> This is done by introducing a hash table to map resource IDs to their
> UUIDs.

The hash table does not seem to be stored during migration.

> 
> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
> 
> v1->v2:
>     - Separate declarations from code.
> 
>   hw/display/trace-events        |  1 +
>   hw/display/virtio-gpu-base.c   |  2 ++
>   hw/display/virtio-gpu-virgl.c  | 21 +++++++++++++++++
>   hw/display/virtio-gpu.c        | 41 ++++++++++++++++++++++++++++++++++
>   include/hw/virtio/virtio-gpu.h |  4 ++++
>   5 files changed, 69 insertions(+)
> 
> diff --git a/hw/display/trace-events b/hw/display/trace-events
> index 2336a0ca15..54d6894c59 100644
> --- a/hw/display/trace-events
> +++ b/hw/display/trace-events
> @@ -41,6 +41,7 @@ virtio_gpu_cmd_res_create_blob(uint32_t res, uint64_t size) "res 0x%x, size %" P
>   virtio_gpu_cmd_res_unref(uint32_t res) "res 0x%x"
>   virtio_gpu_cmd_res_back_attach(uint32_t res) "res 0x%x"
>   virtio_gpu_cmd_res_back_detach(uint32_t res) "res 0x%x"
> +virtio_gpu_cmd_res_assign_uuid(uint32_t res) "res 0x%x"
>   virtio_gpu_cmd_res_xfer_toh_2d(uint32_t res) "res 0x%x"
>   virtio_gpu_cmd_res_xfer_toh_3d(uint32_t res) "res 0x%x"
>   virtio_gpu_cmd_res_xfer_fromh_3d(uint32_t res) "res 0x%x"
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index 4f2b0ba1f3..f44388715c 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -236,6 +236,8 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
>           features |= (1 << VIRTIO_GPU_F_CONTEXT_INIT);
>       }
>   
> +    features |= (1 << VIRTIO_GPU_F_RESOURCE_UUID);
> +
>       return features;
>   }
>   
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 17b634d4ee..1a996a08fc 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -36,6 +36,7 @@ static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
>   {
>       struct virtio_gpu_resource_create_2d c2d;
>       struct virgl_renderer_resource_create_args args;
> +    struct virtio_gpu_simple_resource *res;
>   
>       VIRTIO_GPU_FILL_CMD(c2d);
>       trace_virtio_gpu_cmd_res_create_2d(c2d.resource_id, c2d.format,
> @@ -53,6 +54,14 @@ static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
>       args.nr_samples = 0;
>       args.flags = VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
>       virgl_renderer_resource_create(&args, NULL, 0);
> +
> +    res = g_new0(struct virtio_gpu_simple_resource, 1);
> +    if (!res) {
> +        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> +        return;

virglrenderer thinks the resource is alive in such a situation.

> +    }
> +    res->resource_id = c2d.resource_id;
> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>   }
>   
>   static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
> @@ -60,6 +69,7 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
>   {
>       struct virtio_gpu_resource_create_3d c3d;
>       struct virgl_renderer_resource_create_args args;
> +    struct virtio_gpu_simple_resource *res;
>   
>       VIRTIO_GPU_FILL_CMD(c3d);
>       trace_virtio_gpu_cmd_res_create_3d(c3d.resource_id, c3d.format,
> @@ -77,6 +87,14 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
>       args.nr_samples = c3d.nr_samples;
>       args.flags = c3d.flags;
>       virgl_renderer_resource_create(&args, NULL, 0);
> +
> +    res = g_new0(struct virtio_gpu_simple_resource, 1);
> +    if (!res) {
> +        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> +        return;
> +    }
> +    res->resource_id = c3d.resource_id;
> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>   }
>   
>   static void virgl_resource_destroy(VirtIOGPU *g,
> @@ -682,6 +700,9 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>           /* TODO add security */
>           virgl_cmd_ctx_detach_resource(g, cmd);
>           break;
> +    case VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID:
> +        virtio_gpu_resource_assign_uuid(g, cmd);
> +        break;
>       case VIRTIO_GPU_CMD_GET_CAPSET_INFO:
>           virgl_cmd_get_capset_info(g, cmd);
>           break;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index cc4c1f81bb..770e4747e3 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -966,6 +966,37 @@ virtio_gpu_resource_detach_backing(VirtIOGPU *g,
>       virtio_gpu_cleanup_mapping(g, res);
>   }
>   
> +void virtio_gpu_resource_assign_uuid(VirtIOGPU *g,
> +                                     struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_assign_uuid assign;
> +    struct virtio_gpu_resp_resource_uuid resp;
> +    QemuUUID *uuid = NULL;

This initialization is unnecessary.

> +
> +    VIRTIO_GPU_FILL_CMD(assign);
> +    virtio_gpu_bswap_32(&assign, sizeof(assign));
> +    trace_virtio_gpu_cmd_res_assign_uuid(assign.resource_id);
> +
> +    res = virtio_gpu_find_check_resource(g, assign.resource_id, false, __func__, &cmd->error);
> +    if (!res) {
> +        return;
> +    }
> +
> +    memset(&resp, 0, sizeof(resp));
> +    resp.hdr.type = VIRTIO_GPU_RESP_OK_RESOURCE_UUID;
> +
> +    uuid = g_hash_table_lookup(g->resource_uuids, GUINT_TO_POINTER(assign.resource_id));
> +    if (!uuid) {
> +        uuid = g_new(QemuUUID, 1);
> +        qemu_uuid_generate(uuid);
> +        g_hash_table_insert(g->resource_uuids, GUINT_TO_POINTER(assign.resource_id), uuid);
> +    }
> +
> +    memcpy(resp.uuid, uuid, sizeof(QemuUUID));
> +    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
> +}
> +
>   void virtio_gpu_simple_process_cmd(VirtIOGPU *g,
>                                      struct virtio_gpu_ctrl_command *cmd)
>   {
> @@ -1014,6 +1045,9 @@ void virtio_gpu_simple_process_cmd(VirtIOGPU *g,
>       case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:
>           virtio_gpu_resource_detach_backing(g, cmd);
>           break;
> +    case VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID:
> +        virtio_gpu_resource_assign_uuid(g, cmd);
> +        break;
>       default:
>           cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>           break;
> @@ -1393,12 +1427,15 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>       QTAILQ_INIT(&g->reslist);
>       QTAILQ_INIT(&g->cmdq);
>       QTAILQ_INIT(&g->fenceq);
> +
> +    g->resource_uuids = g_hash_table_new_full(NULL, NULL, NULL, g_free);
>   }
>   
>   static void virtio_gpu_device_unrealize(DeviceState *qdev)
>   {
>       VirtIOGPU *g = VIRTIO_GPU(qdev);
>   
> +    g_hash_table_destroy(g->resource_uuids);
>       g_clear_pointer(&g->ctrl_bh, qemu_bh_delete);
>       g_clear_pointer(&g->cursor_bh, qemu_bh_delete);
>       g_clear_pointer(&g->reset_bh, qemu_bh_delete);
> @@ -1452,6 +1489,10 @@ void virtio_gpu_reset(VirtIODevice *vdev)
>           g_free(cmd);
>       }
>   
> +    if (g->resource_uuids) {

Isn't g->resource_uuids always non-NULL?

> +        g_hash_table_remove_all(g->resource_uuids);
> +    }
> +
>       virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
>   }
>   
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index b9adc28071..aa94b1b697 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -208,6 +208,8 @@ struct VirtIOGPU {
>           QTAILQ_HEAD(, VGPUDMABuf) bufs;
>           VGPUDMABuf *primary[VIRTIO_GPU_MAX_SCANOUTS];
>       } dmabuf;
> +
> +    GHashTable *resource_uuids;
>   };
>   
>   struct VirtIOGPUClass {
> @@ -285,6 +287,8 @@ void virtio_gpu_cleanup_mapping_iov(VirtIOGPU *g,
>                                       struct iovec *iov, uint32_t count);
>   void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
>                                   struct virtio_gpu_simple_resource *res);
> +void virtio_gpu_resource_assign_uuid(VirtIOGPU *g,
> +                                     struct virtio_gpu_ctrl_command *cmd);
>   void virtio_gpu_process_cmdq(VirtIOGPU *g);
>   void virtio_gpu_device_realize(DeviceState *qdev, Error **errp);
>   void virtio_gpu_reset(VirtIODevice *vdev);

