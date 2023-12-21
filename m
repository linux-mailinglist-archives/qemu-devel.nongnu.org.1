Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 156B481AEC0
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 07:27:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGCUy-0002FR-A6; Thu, 21 Dec 2023 01:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rGCUw-0002F6-LP
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 01:25:34 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rGCUu-0006mL-6A
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 01:25:34 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3ba2e4ff6e1so321802b6e.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 22:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1703139920; x=1703744720;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rlXQG44kOZf5fxV0IWo0D6JubD275DwoDFlEWXxwk6A=;
 b=gcpfKKKlLlKjAK7mrcbv8BlONbPZxrsTVBmuLDLSvZyH8OOTNXLzTghbIWnGSPBr6h
 yCCO2NWpN6FI3LkIPO+1SKiQmgBFp7sl9he6Lw6ib2lHg9DVhzsg8F3CUE4Odvq3jdz8
 kXu7x3TKCRn0by0DfdTnTl8GZcEdlUd0AdW4VDin6MADNdDopMjr6QR8gnYE2cbm+pqw
 Ibi90gmIKhoIIjpfUziB6d/I2bE9q3E7a62VZY1lceNBFvHhdKIBbJJEnb7yonW4a6A/
 4HqnrZAoTtQa2lZ+bM4Pqmi0T/fy478q/oPxWNvWPZZA6dFpXMhGI3mI3xTC2dYXWCY8
 TIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703139920; x=1703744720;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rlXQG44kOZf5fxV0IWo0D6JubD275DwoDFlEWXxwk6A=;
 b=mfbGCyR3WcKSovOW04czJWO9Y0DafT1PmVDre7G7xnnHLcS3XPOaw6dnt1KLQtj1xc
 hvw0GRGz5kRGaO4e5pjArbBltXp4Nb5iETChisyM1zE03Inu9MvMmv/lwGSTBGNHvvAx
 8Vep7lGMCd9eqg1GZXA25Keq78SyTQp7uvQmMBE80fCOw8awEuOa3VfBwU9MkAg0JPiP
 EO2a4n1F1Fqamq3eRfS+QELmCdSLn6G1DON+izr0PBPf7kSInKh5iYLvdkUDedJSUYvg
 wDzxcBQPUmTXO23K1eTscBJG0+1lCUpeaLoNsbfeKo5OyiC9LaVRMk5cTnJe1SD8w0tJ
 EH8g==
X-Gm-Message-State: AOJu0YyPR877twP88QVzQUzZDAttSxpNNYeFtJjFTO4fcPKoFDOinoXU
 bRLd5ywKd9jB2lVE/dr5Dx/4Ng==
X-Google-Smtp-Source: AGHT+IGBOK5Z6bL4kJ96WrkRiA+TDKPx53V4PTejOTpRGBANRttKRRPr7/BlKjQTL23MCOHoE+sW2A==
X-Received: by 2002:a05:6808:219c:b0:3b8:b1bd:b36a with SMTP id
 be28-20020a056808219c00b003b8b1bdb36amr30330444oib.49.1703139920252; 
 Wed, 20 Dec 2023 22:25:20 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a056a00008700b006cd88728572sm758504pfj.211.2023.12.20.22.25.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 22:25:19 -0800 (PST)
Message-ID: <a2c0a1f1-45a2-4957-9919-0d0cb19cd285@daynix.com>
Date: Thu, 21 Dec 2023 15:25:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/11] virtio-gpu: make blob scanout use dmabuf fd
Content-Language: en-US
To: Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-12-ray.huang@amd.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231219075320.165227-12-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::233;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/12/19 16:53, Huang Rui wrote:
> From: Robert Beckett <bob.beckett@collabora.com>
> 
> This relies on a virglrenderer change to include the dmabuf fd when
> returning resource info.
> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
> 
> Changes in v6:
> - Add scanout_blob function for virtio-gpu-virgl.
> - Update for new virgl_gpu_resource.
> 
>   hw/display/virtio-gpu-virgl.c  | 104 +++++++++++++++++++++++++++++++++
>   hw/display/virtio-gpu.c        |   4 +-
>   include/hw/virtio/virtio-gpu.h |   6 ++
>   3 files changed, 112 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index c523a6717a..c384225a98 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -18,6 +18,7 @@
>   #include "hw/virtio/virtio.h"
>   #include "hw/virtio/virtio-gpu.h"
>   #include "hw/virtio/virtio-gpu-bswap.h"
> +#include "hw/virtio/virtio-gpu-pixman.h"
>   
>   #include "ui/egl-helpers.h"
>   
> @@ -726,6 +727,106 @@ static void virgl_cmd_resource_unmap_blob(VirtIOGPU *g,
>       object_unparent(OBJECT(mr));
>   }
>   
> +static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
> +                                       struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virgl_gpu_resource *vres;
> +    struct virtio_gpu_framebuffer fb = { 0 };
> +    struct virtio_gpu_set_scanout_blob ss;
> +    struct virgl_renderer_resource_info info;
> +    uint64_t fbend;
> +
> +    VIRTIO_GPU_FILL_CMD(ss);
> +    virtio_gpu_scanout_blob_bswap(&ss);
> +    trace_virtio_gpu_cmd_set_scanout_blob(ss.scanout_id, ss.resource_id,
> +                                          ss.r.width, ss.r.height, ss.r.x,
> +                                          ss.r.y);
> +
> +    if (ss.scanout_id >= g->parent_obj.conf.max_outputs) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout id specified %d",
> +                      __func__, ss.scanout_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID;
> +        return;
> +    }
> +
> +    if (ss.resource_id == 0) {
> +        virtio_gpu_disable_scanout(g, ss.scanout_id);
> +        return;
> +    }
> +
> +    if (ss.width < 16 ||
> +        ss.height < 16 ||
> +        ss.r.x + ss.r.width > ss.width ||
> +        ss.r.y + ss.r.height > ss.height) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d bounds for"
> +                      " resource %d, rect (%d,%d)+%d,%d, fb %d %d\n",
> +                      __func__, ss.scanout_id, ss.resource_id,
> +                      ss.r.x, ss.r.y, ss.r.width, ss.r.height,
> +                      ss.width, ss.height);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;
> +    }
> +
> +    if (!console_has_gl(g->parent_obj.scanout[ss.scanout_id].con)) {

Shouldn't OpenGL always be available for virgl?

> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: unable to scanout blot without GL!\n", __func__);
> +        return;
> +    }
> +
> +    vres = virgl_gpu_find_resource(g, ss.resource_id);
> +    if (!vres) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: illegal resource specified %d\n",
> +                      __func__, ss.resource_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +    if (virgl_renderer_resource_get_info(ss.resource_id, &info)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: illegal virgl resource specified %d\n",
> +                      __func__, ss.resource_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +    if (!vres->res.dmabuf_fd && info.fd)
> +        vres->res.dmabuf_fd = info.fd;
> +
> +    fb.format = virtio_gpu_get_pixman_format(ss.format);
> +    if (!fb.format) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: host couldn't handle guest format %d\n",
> +                      __func__, ss.format);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;
> +    }
> +
> +    fb.bytes_pp = DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb.format), 8);
> +    fb.width = ss.width;
> +    fb.height = ss.height;
> +    fb.stride = ss.strides[0];
> +    fb.offset = ss.offsets[0] + ss.r.x * fb.bytes_pp + ss.r.y * fb.stride;
> +
> +    fbend = fb.offset;
> +    fbend += fb.stride * (ss.r.height - 1);
> +    fbend += fb.bytes_pp * ss.r.width;
> +    if (fbend > vres->res.blob_size) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: fb end out of range\n",
> +                      __func__);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;
> +    }
> +
> +    g->parent_obj.enable = 1;
> +    if (virtio_gpu_update_dmabuf(g, ss.scanout_id, &vres->res,
> +                                 &fb, &ss.r)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: failed to update dmabuf\n", __func__);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;
> +    }
> +    virtio_gpu_update_scanout(g, ss.scanout_id, &vres->res, &ss.r);
> +}
> +
>   #endif /* HAVE_VIRGL_RESOURCE_BLOB */
>   
>   void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
> @@ -807,6 +908,9 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>       case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:
>           virgl_cmd_resource_unmap_blob(g, cmd);
>           break;
> +    case VIRTIO_GPU_CMD_SET_SCANOUT_BLOB:

VIRTIO_GPU_CMD_SET_SCANOUT_BLOB support should be added before allowing 
the user to enable the resource blob support.

You should also check if virtio_vdev_has_feature(VIRTIO_DEVICE(g), 
VIRTIO_GPU_F_RESOURCE_BLOB). It also applies to other resource blob 
commands though I failed to note that for the earlier patch.

