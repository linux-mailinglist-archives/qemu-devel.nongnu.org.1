Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F4377ED2A
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 00:33:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWP3f-0006fy-GO; Wed, 16 Aug 2023 18:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWP3d-0006fS-FC
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 18:32:05 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWP3a-0000Zt-Vh
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 18:32:05 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99c1f6f3884so959129966b.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 15:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692225121; x=1692829921;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KL12LAYcPkYB25UgT+FQUYoTuRSMerKQFJBdVFlAZpU=;
 b=e8vjDN8hwX1JbsD29bSyrTcZQQYGdfQ3jnoCKzZ6MTQe7JAfTNzZFIrKWEbtc+1Nvv
 ICTPt2z64GO8Q6+y8SzM4qGjV7GrpUL4l23hlNQnyMuSf8o2g4tj6HQhvpuBhJHDOWvP
 nK93qaDNafaDwvACSpEFIRYu15kPG0Y9JLQogTwrXsDGDxaq2OcSurlON1kQBgKAmlj0
 m3j5/EGqIO08EQOUX6rEMUyzgm/YDTe4UaL2wCO7Y7VVN1Qyd9JE+ph1ocrLp6Lwj6BL
 cxt3xu6xuGgFH0EfNf288rzoe5Err474bAhxLqdS7h+hDK9phUnFsQPwdkAfa9L4uBhQ
 Jrwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692225121; x=1692829921;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KL12LAYcPkYB25UgT+FQUYoTuRSMerKQFJBdVFlAZpU=;
 b=IrZiNu4hmxBqj5B6Fr5DF1/8Rh+c5KxlIyLeb+cjneSgoRV0QduAzqQK1QW82NsqRL
 MLxK5zLde1UKLrIDi4AuOvaCal2uUhS0nthabCvx5HCKoLFdh50gB4jnbmuBqi2oQKmt
 z44hpUGzfuP9RM4g8jLHRbVx3hFP6kM7SzE6wrkgeMHnCNYD0NJW8peky7tOIeOOhzww
 gXz6cqkFk5qtd/aD41MN/jyEZPeyEYu3TzRbNTFE/xD9YjwkWmd1ujFHcrPrTt3WwT+f
 2AFA0QNnD2Z+HVWEgvF7ufBx8QhSLXVir1+ZExOX7E106Wz1mZwCKeDo5ShI8PLpA1oh
 BY5A==
X-Gm-Message-State: AOJu0YzPFHxnsieH5fqvNwvTjRM0G5MS04VIL3wlfqOKap/mZ3sVq7q7
 O5carmpBZWEg9MV3Z3XOWDzIdw==
X-Google-Smtp-Source: AGHT+IGsIQMLH4io+JjD7x8SBMjpc/8RJ3in8ks/nuZybzSscea5spkngr5NhZHbhe+0vKamkBqLoA==
X-Received: by 2002:a17:906:20d7:b0:99d:ffdf:ecd4 with SMTP id
 c23-20020a17090620d700b0099dffdfecd4mr699879ejc.55.1692225121376; 
 Wed, 16 Aug 2023 15:32:01 -0700 (PDT)
Received: from [192.168.69.115] (mna75-h02-176-184-40-35.dsl.sta.abo.bbox.fr.
 [176.184.40.35]) by smtp.gmail.com with ESMTPSA id
 qh28-20020a170906ecbc00b0099ce188be7fsm9137050ejb.3.2023.08.16.15.32.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 15:32:00 -0700 (PDT)
Message-ID: <a3a6f8ec-ca61-4472-45b4-1077dd27bb52@linaro.org>
Date: Thu, 17 Aug 2023 00:31:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH for-8.1] vfio/display: Fix missing update to set backing
 fields
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: marcandre.lureau@redhat.com, dongwon.kim@intel.com, kraxel@redhat.com
References: <20230816215550.1723696-1-alex.williamson@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230816215550.1723696-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

On 16/8/23 23:55, Alex Williamson wrote:
> The below referenced commit renames scanout_width/height to
> backing_width/height, but also promotes these fields in various portions
> of the egl interface.  Meanwhile vfio dmabuf support has never used the
> previous scanout fields and is therefore missed in the update.  This
> results in a black screen when transitioning from ramfb to dmabuf display
> when using Intel vGPU with these features.

Referenced commit isn't trivial. Maybe because it is too late here.
I'd have tried to split it. Anyhow, too late (again).

Is vhost-user-gpu also affected? (see VHOST_USER_GPU_DMABUF_SCANOUT
in vhost_user_gpu_handle_display()).

> Link: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg02726.html
> Fixes: 9ac06df8b684 ("virtio-gpu-udmabuf: correct naming of QemuDmaBuf size properties")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> 
> This fixes a regression in dmabuf/EGL support for Intel GVT-g and
> potentially the mbochs mdev driver as well.  Once validated by those
> that understand dmabuf/EGL integration, I'd welcome QEMU maintainers to
> take this directly for v8.1 or queue it as soon as possible for v8.1.1.
> 
>   hw/vfio/display.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index bec864f482f4..837d9e6a309e 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -243,6 +243,8 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
>       dmabuf->dmabuf_id  = plane.dmabuf_id;
>       dmabuf->buf.width  = plane.width;
>       dmabuf->buf.height = plane.height;
> +    dmabuf->buf.backing_width = plane.width;
> +    dmabuf->buf.backing_height = plane.height;
>       dmabuf->buf.stride = plane.stride;
>       dmabuf->buf.fourcc = plane.drm_format;
>       dmabuf->buf.modifier = plane.drm_format_mod;


