Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A13A381AE93
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 06:59:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGC41-0004Fa-OJ; Thu, 21 Dec 2023 00:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rGC3z-0004FA-9d
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 00:57:43 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rGC3w-0003sB-QZ
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 00:57:43 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d3f2985425so2155745ad.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 21:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1703138259; x=1703743059;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7Rcc45KsdcmjGxxLc8UIdrrEhZeaVWgm/MkKyVTozcM=;
 b=mxPapRtTmGe03fkIlKhlj0mGsijZ1O/p9nKW5yeYcFb2qMuVB7c2vcaMaoO47sl3CQ
 09/hnyaqYCtw+Pc8CE/rUWX5bO78Xy3NoP446WtSqmmzF2YzXB+qkKHHoMtqJFl7VL+s
 uCMnBQTdwzL2oIYHRAi1OJl0Ox5xJxbtoFgDpCwCGxwpoFLanztvCGDRHiQ6R8YRr4xu
 OiLdAbufHD9xPB/FdrhDUgsuU+CVSUeh2OZWyobeV5dC7GYu4TKPFH3H9JIQC3p1n81R
 lQ60M9skP8kbCGU7WLa06NHyTahQ3/bNEcPT5hTmYuDDqM4QFiigkYd3AQ7wuL9+POmd
 GNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703138259; x=1703743059;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Rcc45KsdcmjGxxLc8UIdrrEhZeaVWgm/MkKyVTozcM=;
 b=e/wyFOTaivLxgSaGeoRBParAN+Ru+Mi2ufpwTBV6fnOs32yzdK6mCiLpAoib8I0FDZ
 SclcL6fIExsj/TlY38phd24rRReFt4AtO5AgLVfXSXvGA85q13S3bEgX9SAdYb+O6fr+
 MdoznadlyeMwKRZh85wFIVIbhY1HG/HjHcKQGEgbSD6LzyK2zS9tPJRZHCa5aoQIUXGD
 dYs+lTcOgNhmD40b1U1oNAc/6X3CaJZjTEKx/dF57NIMfTwTMhSSWDaeHg6CJFDmyugo
 SFPaow+5deUiHkhiEqtDs0l3EvFt4oo5jrAWbZa1c5Y69fY8FLG72oUnyB6XCrT8WZal
 pwIw==
X-Gm-Message-State: AOJu0Yx+orYqe6cddYutsiAovfQwW3ltp2dVFj78XPC2+BacuUhEQthE
 ZG127+UncvTOz7BvgaEyPIOsvA==
X-Google-Smtp-Source: AGHT+IHGw0/xJGMfpNai3w9B7992IeeEENPNFYUbvUzBvYTZo9zWw6/R2YYwCA50v8JBAqb4YhbKsw==
X-Received: by 2002:a17:902:c451:b0:1d3:e9f5:d3aa with SMTP id
 m17-20020a170902c45100b001d3e9f5d3aamr1549392plm.45.1703138259056; 
 Wed, 20 Dec 2023 21:57:39 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a170902c18b00b001d3f056bd65sm706571pld.191.2023.12.20.21.57.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 21:57:38 -0800 (PST)
Message-ID: <9ee393a7-283c-41b2-a7bb-5e3306c0257e@daynix.com>
Date: Thu, 21 Dec 2023 14:57:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/11] virtio-gpu: Handle resource blob commands
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
 Chen Jiqian <Jiqian.Chen@amd.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-8-ray.huang@amd.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231219075320.165227-8-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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
> Changes in v6:
> - Use new struct virgl_gpu_resource.
> - Unmap, unref and destroy the resource only after the memory region
>    has been completely removed.
> - In unref check whether the resource is still mapped.
> - In unmap_blob check whether the resource has been already unmapped.
> - Fix coding style
> 
>   hw/display/virtio-gpu-virgl.c | 274 +++++++++++++++++++++++++++++++++-
>   hw/display/virtio-gpu.c       |   4 +-
>   meson.build                   |   4 +
>   3 files changed, 276 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index faab374336..5a3a292f79 100644
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
> @@ -24,8 +25,62 @@
>   
>   struct virgl_gpu_resource {
>       struct virtio_gpu_simple_resource res;
> +    uint32_t ref;
> +    VirtIOGPU *g;
> +
> +#ifdef HAVE_VIRGL_RESOURCE_BLOB
> +    /* only blob resource needs this region to be mapped as guest mmio */
> +    MemoryRegion *region;

Why not just embed MemoryRegion into struct virgl_gpu_resource instead 
of having a pointer?

> +#endif
>   };
>   
> +static void vres_get_ref(struct virgl_gpu_resource *vres)
> +{
> +    uint32_t ref;
> +
> +    ref = qatomic_fetch_inc(&vres->ref);
> +    g_assert(ref < INT_MAX);
> +}
> +
> +static void virgl_resource_destroy(struct virgl_gpu_resource *vres)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +    VirtIOGPU *g;
> +
> +    if (!vres) {
> +        return;
> +    }
> +
> +    g = vres->g;
> +    res = &vres->res;
> +    QTAILQ_REMOVE(&g->reslist, res, next);
> +    virtio_gpu_cleanup_mapping(g, res);
> +    g_free(vres);
> +}
> +
> +static void virgl_resource_unref(struct virgl_gpu_resource *vres)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +
> +    if (!vres) {
> +        return;
> +    }
> +
> +    res = &vres->res;
> +    virgl_renderer_resource_detach_iov(res->resource_id, NULL, NULL);
> +    virgl_renderer_resource_unref(res->resource_id);
> +}
> +
> +static void vres_put_ref(struct virgl_gpu_resource *vres)
> +{
> +    g_assert(vres->ref > 0);
> +
> +    if (qatomic_fetch_dec(&vres->ref) == 1) {
> +        virgl_resource_unref(vres);
> +        virgl_resource_destroy(vres);
> +    }
> +}
> +
>   static struct virgl_gpu_resource *
>   virgl_gpu_find_resource(VirtIOGPU *g, uint32_t resource_id)
>   {
> @@ -59,6 +114,8 @@ static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
>                                          c2d.width, c2d.height);
>   
>       vres = g_new0(struct virgl_gpu_resource, 1);
> +    vres_get_ref(vres);
> +    vres->g = g;
>       vres->res.width = c2d.width;
>       vres->res.height = c2d.height;
>       vres->res.format = c2d.format;
> @@ -91,6 +148,8 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
>                                          c3d.width, c3d.height, c3d.depth);
>   
>       vres = g_new0(struct virgl_gpu_resource, 1);
> +    vres_get_ref(vres);
> +    vres->g = g;
>       vres->res.width = c3d.width;
>       vres->res.height = c3d.height;
>       vres->res.format = c3d.format;
> @@ -126,12 +185,21 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
>           return;
>       }
>   
> -    virgl_renderer_resource_detach_iov(unref.resource_id, NULL, NULL);
> -    virgl_renderer_resource_unref(unref.resource_id);
> +#ifdef HAVE_VIRGL_RESOURCE_BLOB
> +    if (vres->region) {
> +        VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
> +        MemoryRegion *mr = vres->region;
> +
> +        warn_report("%s: blob resource %d not unmapped",
> +                    __func__, unref.resource_id);
> +        vres->region = NULL;
> +        memory_region_set_enabled(mr, false);
> +        memory_region_del_subregion(&b->hostmem, mr);
> +        object_unparent(OBJECT(mr));
> +    }
> +#endif /* HAVE_VIRGL_RESOURCE_BLOB */
>   
> -    QTAILQ_REMOVE(&g->reslist, &vres->res, next);
> -    virtio_gpu_cleanup_mapping(g, &vres->res);
> -    g_free(vres);
> +    vres_put_ref(vres);

What will happen if the guest consecutively requests 
VIRTIO_GPU_CMD_RESOURCE_UNREF twice for a mapped resource?

