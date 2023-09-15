Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C107A23E5
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:49:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBzj-0000H2-Ka; Fri, 15 Sep 2023 12:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhBzW-0000FV-Q0
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:48:29 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhBzT-0005rc-Kt
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:48:26 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-564b6276941so1862816a12.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694796501; x=1695401301;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ABFv1pK71RPcXpZmYjUJAjE3pR/vvyihnbU3LDvHYM=;
 b=NwMpVf5G0z/8+9I5IfJrbAA0WBdYx281E8PbGbR6NJk/B5NbEYgeSe/DkU4zbScTzk
 VkfUL40FP/3FqUgPYi2hHU/uiXPtmOZKkVbiSGeSmmrV9jKXmy9duyrLmEtRkF2Qq4Lv
 g3tRcpk9DH5ySJqeo+75iceBwBN8HdAHvy2yjJyTCx6FFB7BqSdK0v+yP+3u1GIoP2G4
 erW0eCeGskfPUtbdXhRdUUmSE73ztpbEGQzmWtkJlATL02igstvUFfcsZQdfjq80gEZ0
 L2isUL0ZkIXx/3DeAh5Ix3rFxzECTmzfGaBVMwNheDdkpIvGV6pXB8oHIl8kH4iBU2fF
 GpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796501; x=1695401301;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1ABFv1pK71RPcXpZmYjUJAjE3pR/vvyihnbU3LDvHYM=;
 b=Du9aDfe6qWUeLUdi+LzHxLO03FlAGUQAB0uuIoJalwHQmuWL1GkduCWIh8EqWJrr6Z
 wi+5jgXbbP+gSKshLJ+bvxA4LA+Bzqw5QqQGJ5JE3ByOLvRJA3E8rgLT2A410FoJpCFR
 qoUoNS0BmgtcPaUVtr7/1k+Rt1yarmxsLsAeCV8/yus1mJI//InH4po7eGx4maIrpam3
 BIdXRChYHJi5cXqvOA66StbG6nNkK1qkWxaxvETNcs/7VJ5pqsS0ehk7wglM+VWoJA0l
 WSMi+4bD5lCU4r9hhpT1rLwbg8DcX5daGfuWKtqIOQvylAeu2jIgkBkLJcz5epojA2Sv
 lYeg==
X-Gm-Message-State: AOJu0YyuU6D+l7cAwVroP9f8RQdfx+ZJ05tyZi8BJQYW7ZvQOTABcYrB
 2WM9bhhtRhlDecOTozoePbbvKQ==
X-Google-Smtp-Source: AGHT+IHli99nSnZrzIK9dwMuLFLoTLYUlA60VSGUBhns+P/ipbmvVaqxTm9+cI83BiSH03TdQVZIsA==
X-Received: by 2002:a17:90a:fb92:b0:274:6a79:17c1 with SMTP id
 cp18-20020a17090afb9200b002746a7917c1mr2090131pjb.15.1694796500796; 
 Fri, 15 Sep 2023 09:48:20 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a17090ab79100b00262eccfa29fsm4990545pjr.33.2023.09.15.09.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 09:48:20 -0700 (PDT)
Message-ID: <a3a46b78-9feb-47f3-bd3e-519ebe899737@daynix.com>
Date: Sat, 16 Sep 2023 01:48:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v5 10/13] virtio-gpu: Resource UUID
Content-Language: en-US
To: Huang Rui <ray.huang@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Albert Esteve <aesteve@redhat.com>, ernunes@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>
References: <20230915111130.24064-1-ray.huang@amd.com>
 <20230915111130.24064-11-ray.huang@amd.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230915111130.24064-11-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
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

On 2023/09/15 20:11, Huang Rui wrote:
> From: Antonio Caggiano <antonio.caggiano@collabora.com>
> 
> Enable resource UUID feature and implement command resource assign UUID.
> This is done by introducing a hash table to map resource IDs to their
> UUIDs.
> 
> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
> 
> V4 -> V5:
>      - Add virtio migration handling for uuid (Akihiko)
>      - Adjust sequence to allocate gpu resource before virglrender resource
>        creation (Akihiko)
>      - Clean up (Akihiko)
> 
>   hw/display/trace-events        |  1 +
>   hw/display/virtio-gpu-base.c   |  2 ++
>   hw/display/virtio-gpu-virgl.c  | 21 ++++++++++++
>   hw/display/virtio-gpu.c        | 58 ++++++++++++++++++++++++++++++++++
>   include/hw/virtio/virtio-gpu.h |  6 ++++
>   5 files changed, 88 insertions(+)
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
> index 563a6f2f58..8a017dbeb4 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -36,11 +36,20 @@ static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
>   {
>       struct virtio_gpu_resource_create_2d c2d;
>       struct virgl_renderer_resource_create_args args;
> +    struct virtio_gpu_simple_resource *res;
>   
>       VIRTIO_GPU_FILL_CMD(c2d);
>       trace_virtio_gpu_cmd_res_create_2d(c2d.resource_id, c2d.format,
>                                          c2d.width, c2d.height);
>   
> +    res = g_new0(struct virtio_gpu_simple_resource, 1);
> +    if (!res) {
> +        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> +        return;
> +    }
> +    res->resource_id = c2d.resource_id;
> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
> +

The struct virtio_gpu_simple_resource for a resource created with 
virgl_cmd_create_resource_2d() and virgl_resource_attach_backing() will 
not have iov and iov_cnt set, which is inconsistent with 
virgl_cmd_resource_create_blob().

>       args.handle = c2d.resource_id;
>       args.target = 2;
>       args.format = c2d.format;
> @@ -60,11 +69,20 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
>   {
>       struct virtio_gpu_resource_create_3d c3d;
>       struct virgl_renderer_resource_create_args args;
> +    struct virtio_gpu_simple_resource *res;
>   
>       VIRTIO_GPU_FILL_CMD(c3d);
>       trace_virtio_gpu_cmd_res_create_3d(c3d.resource_id, c3d.format,
>                                          c3d.width, c3d.height, c3d.depth);
>   
> +    res = g_new0(struct virtio_gpu_simple_resource, 1);
> +    if (!res) {
> +        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> +        return;
> +    }
> +    res->resource_id = c3d.resource_id;
> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
> +
>       args.handle = c3d.resource_id;
>       args.target = c3d.target;
>       args.format = c3d.format;
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
> index cc4c1f81bb..44414c1c5e 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -966,6 +966,38 @@ virtio_gpu_resource_detach_backing(VirtIOGPU *g,
>       virtio_gpu_cleanup_mapping(g, res);
>   }
>   
> +void virtio_gpu_resource_assign_uuid(VirtIOGPU *g,
> +                                     struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_assign_uuid assign;
> +    struct virtio_gpu_resp_resource_uuid resp;
> +    QemuUUID *uuid;
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
> +        res->has_uuid = true;
> +    }

What about embedding uuid into struct virtio_gpu_simple_resource? You 
will not need to maintain another table in this way.

