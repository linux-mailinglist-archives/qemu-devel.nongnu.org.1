Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A44A76C53A
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 08:23:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR5GG-0002nZ-L6; Wed, 02 Aug 2023 02:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qR5GB-0002ja-4l
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 02:23:03 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qR5G8-0000XB-T7
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 02:23:02 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-686e0213c0bso4519882b3a.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 23:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690957378; x=1691562178;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7phbwwJn9aoTimBAG9+94/myjuwngER5D/HwPtxhGqI=;
 b=WlJ1qHoCsPKpyxct3g9bC4SqV7XONdw33BQ5k6Cy69aLpvIQImltygoIxchazT+ICx
 dX+QVl9OS0ZlyJviDfnTHA+CaBia6HXhb1Oqc1UW+HA+VSkXKSNeg48MUDh6xdbDZkxJ
 d+zEwnqmLWy7pDebruANpiK/QclIDrUtReN7dM9Yj5YeX65YyE/9mYxuyAwZPx9emcx0
 43+FLxF7NmGuqfeEtnUZ20uh5xWpfMH2A8K/84pRB2kBshcIMdpOppT4j0wFFwCpr0Id
 MKYJtaFCzIrPSZKNZtN6dLhf/lCAnJZFrvLArcC330VvanpJtEIVPLrq9szVYp8RyjcV
 sW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690957378; x=1691562178;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7phbwwJn9aoTimBAG9+94/myjuwngER5D/HwPtxhGqI=;
 b=T0jqPpB1IUcHBbU4YOtXFXQvXnXlpeCzIKLpS+0T+u6kxCBmr7sPy14QlBPI9znSly
 IfxZau853RTlzYeqB8qyhIN50AoEoi08UwUgv2AvGq9up3IuKHCPErlGVwmvwPFcxTrR
 WBQPwYkAIE6TLiwj7+CtmILs6l1P8tAvXa5SPIQQMFnDV8Kze60+mEc7IEb//bPrzpPR
 YwZTXuC5oqOATCp6Pw3QvtJNoSRE6ejz0faAmcYs9mf30W9e7+iHEbhTvoYpuiawwaKA
 80CuasZuKmw3bu0AaM9DDfCD6k9nMl89BZRO+gjl6LEWxH3h89D7KS6kFn14VTf0X7KR
 xgyQ==
X-Gm-Message-State: ABy/qLaBqbPfmVBB5cK7Ie8PAy/9azQFkybK5OnlhHH4Qt8Y6R38McA0
 m1lvKlOE9CsAR1aqZbj7FGA=
X-Google-Smtp-Source: APBJJlE06FCPyseTYNY4dbAaxwKRYjKuprJ+4/l9aVXo/1tI/gwqzmdEUfalADwZNYIPa2r5I/3UQg==
X-Received: by 2002:a05:6a21:3b48:b0:122:8096:7012 with SMTP id
 zy8-20020a056a213b4800b0012280967012mr12532485pzb.3.1690957378222; 
 Tue, 01 Aug 2023 23:22:58 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 a18-20020aa780d2000000b0068746ab9aebsm3856869pfn.14.2023.08.01.23.22.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 23:22:57 -0700 (PDT)
Message-ID: <1090da5f-7eb9-11f4-b448-c5103048a89a@gmail.com>
Date: Wed, 2 Aug 2023 15:22:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] gfxstream + rutabaga: enable rutabaga
Content-Language: en-US
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, hi@alyssa.is
References: <20230801011723.627-1-gurchetansingh@chromium.org>
 <20230801011723.627-9-gurchetansingh@chromium.org>
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20230801011723.627-9-gurchetansingh@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/08/01 10:17, Gurchetan Singh wrote:
> This change enables rutabaga to receive virtio-gpu-3d hypercalls
> when it is active.
> 
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> ---
>   hw/display/virtio-gpu-base.c | 3 ++-
>   hw/display/virtio-gpu.c      | 5 +++--
>   softmmu/qdev-monitor.c       | 3 +++
>   softmmu/vl.c                 | 1 +
>   4 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index 9628e03f93..3e822fc514 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -223,7 +223,8 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
>   {
>       VirtIOGPUBase *g = VIRTIO_GPU_BASE(vdev);
>   
> -    if (virtio_gpu_virgl_enabled(g->conf)) {
> +    if (virtio_gpu_virgl_enabled(g->conf) ||
> +        virtio_gpu_rutabaga_enabled(g->conf)) {
>           features |= (1 << VIRTIO_GPU_F_VIRGL);
>       }
>       if (virtio_gpu_edid_enabled(g->conf)) {
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 6d19205e00..138a01d00e 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1358,8 +1358,9 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>       VirtIOGPU *g = VIRTIO_GPU(qdev);
>   
>       if (virtio_gpu_blob_enabled(g->parent_obj.conf)) {
> -        if (!virtio_gpu_have_udmabuf()) {
> -            error_setg(errp, "cannot enable blob resources without udmabuf");
> +        if (!virtio_gpu_have_udmabuf() &&
> +            !virtio_gpu_rutabaga_enabled(g->parent_obj.conf)) {
> +            error_setg(errp, "need udmabuf or rutabaga for blob resources");
>               return;
>           }
>   
> diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
> index 74f4e41338..246f0b051d 100644
> --- a/softmmu/qdev-monitor.c
> +++ b/softmmu/qdev-monitor.c
> @@ -86,6 +86,9 @@ static const QDevAlias qdev_alias_table[] = {
>       { "virtio-gpu-pci", "virtio-gpu", QEMU_ARCH_VIRTIO_PCI },
>       { "virtio-gpu-gl-device", "virtio-gpu-gl", QEMU_ARCH_VIRTIO_MMIO },
>       { "virtio-gpu-gl-pci", "virtio-gpu-gl", QEMU_ARCH_VIRTIO_PCI },
> +    { "virtio-gpu-rutabaga-device", "virtio-gpu-rutabaga",
> +       QEMU_ARCH_VIRTIO_MMIO },

Nitpick: remove one whitespace before QEMU_ARCH_VIRTIO_MMIO.

> +    { "virtio-gpu-rutabaga-pci", "virtio-gpu-rutabaga", QEMU_ARCH_VIRTIO_PCI },
>       { "virtio-input-host-device", "virtio-input-host", QEMU_ARCH_VIRTIO_MMIO },
>       { "virtio-input-host-ccw", "virtio-input-host", QEMU_ARCH_VIRTIO_CCW },
>       { "virtio-input-host-pci", "virtio-input-host", QEMU_ARCH_VIRTIO_PCI },
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index b0b96f67fa..2f98eefdf3 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -216,6 +216,7 @@ static struct {
>       { .driver = "ati-vga",              .flag = &default_vga       },
>       { .driver = "vhost-user-vga",       .flag = &default_vga       },
>       { .driver = "virtio-vga-gl",        .flag = &default_vga       },
> +    { .driver = "virtio-vga-rutabaga",  .flag = &default_vga       },
>   };
>   
>   static QemuOptsList qemu_rtc_opts = {

