Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1A2780D6A
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:05:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX05z-00054S-1J; Fri, 18 Aug 2023 10:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qWy7t-0005s1-05
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 07:58:49 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qWy7q-0004ol-R1
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 07:58:48 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68872cadc7cso699123b3a.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 04:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692359925; x=1692964725;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GJMMzd0+oamKx1879FeRk6NEti0uzzF+rU82hMlYGsw=;
 b=IqzvyyCws6y30ri7DtC/iTes/buTtn85lS/zoQEBE1INnPPgycNxHefCxwuQ9xFJyN
 ymF+aUULS/t1+1UwbbhgFMgGhvzGFZ+6e+pSbnEtvopVosmCVTypmAcQaCOY76RrWWvR
 oYZkj+PuWAJaQz9qOxix7G7qdL78EjjciEt23PWc/vaQ4J4tI6f0pLcWMSyPcpVgVQkW
 hVRYdbUDxFNtBxzlue54xXoPVee9cy8BYiQend5CY70nFB0QFgX96FF75TDABUYF0/om
 zptQPQ9uu24fA359iie2Y+dyeWzzIpgLBTzooaHbcZVdngRWCrsRMIuupGmOlr3jPslK
 DIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692359925; x=1692964725;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GJMMzd0+oamKx1879FeRk6NEti0uzzF+rU82hMlYGsw=;
 b=gDdtDfIgRBDTK/q0dhCGKNHBWSLDQ+JSVqKyj05gboDj0hJ793CwNBjYDUCdfVT23X
 tq8gZMr1s3+1+B2vyGTr32Ur/LwNdCYuEu9E8qwS222zvkUWw8d+BsOxesxG53VH/hJh
 3yUJMqhA6L6evSW+UAWkPXjmDgU3xoCpl05CjE+515IxlS+WVyBOF7XP5RVSBzv23tPq
 xxdQtnms61jBmzo1jTsKeHG24FdV7Hru2kgo5uRNQvVXio6KFzsXnh+3H8fVK7xYNw9C
 UWY84L4e/Jl1gTvo6rh6Ey/dfsUYNO10Ma9JULrKIHAG9BRyhL78AsNVgYu70OJOu8sx
 WpxQ==
X-Gm-Message-State: AOJu0YwlHWsSgIE4EsoIKs1Z6QsKlNQwqU27nYFYjP8wj4Zz9fVT/I1v
 q+ebYrQYhAI7jwcJGZrhBkI=
X-Google-Smtp-Source: AGHT+IH85iTlYWTAsIVdn02rNuWMUnr1hQVP8m5SbMb/FPpW7wmLEAdvUYe+ug/tz/A4OPfyFeW19A==
X-Received: by 2002:a05:6a20:970f:b0:13e:a442:c895 with SMTP id
 hr15-20020a056a20970f00b0013ea442c895mr2222589pzc.48.1692359925309; 
 Fri, 18 Aug 2023 04:58:45 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c187-20020a6335c4000000b00563deb296bbsm1363035pga.22.2023.08.18.04.58.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 04:58:44 -0700 (PDT)
Message-ID: <91b1ced0-4a41-4878-af35-18895927eabc@gmail.com>
Date: Fri, 18 Aug 2023 20:58:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/9] gfxstream + rutabaga: enable rutabaga
Content-Language: en-US
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is, ernunes@redhat.com,
 manos.pitsidianakis@linaro.org
References: <20230817022322.466-1-gurchetansingh@google.com>
 <20230817022322.466-9-gurchetansingh@google.com>
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20230817022322.466-9-gurchetansingh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2023/08/17 11:23, Gurchetan Singh wrote:
> From: Gurchetan Singh <gurchetansingh@chromium.org>
> 
> This change enables rutabaga to receive virtio-gpu-3d hypercalls
> when it is active.
> 
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Tested-by: Alyssa Ross <hi@alyssa.is>
> Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> v3: Whitespace fix (Akihiko)
> 
>   hw/display/virtio-gpu-base.c | 3 ++-
>   hw/display/virtio-gpu.c      | 5 +++--
>   softmmu/qdev-monitor.c       | 3 +++
>   softmmu/vl.c                 | 1 +
>   4 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index 4f2b0ba1f3..50c5373b65 100644
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
> index 3e658f1fef..08e170e029 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1361,8 +1361,9 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>       VirtIOGPU *g = VIRTIO_GPU(qdev);
>   
>       if (virtio_gpu_blob_enabled(g->parent_obj.conf)) {
> -        if (!virtio_gpu_have_udmabuf()) {
> -            error_setg(errp, "cannot enable blob resources without udmabuf");
> +        if (!virtio_gpu_have_udmabuf() &&

virtio_gpu_have_udmabuf() emits a warning if udmabuf is not available, 
which is spurious when using Rutabaga.

I think virtio_gpu_have_udmabuf() should be renamed to 
virtio_gpu_init_udmabuf() or something, let it set errp instead of 
emitting a warning, and call it only when Rutabaga is not in use. That 
clarifies the timing when an error message will be shown.

