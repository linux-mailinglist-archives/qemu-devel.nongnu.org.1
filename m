Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A187A2411
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:59:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhC9U-0000Un-VB; Fri, 15 Sep 2023 12:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhC9T-0000U9-2P
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:58:43 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhC9P-0007uF-QQ
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:58:42 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6903a452dfaso1473568b3a.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694797118; x=1695401918;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SuhfdU4PspnFHfisOXH5BuuofTvFKNo2MDW2PD1bi8M=;
 b=B/pLXaGIBjCTG73xEJos09yUV6XE+/6nxY/WalxIcRIn/i93Mzu6BelxFcBVbWv1L4
 SwRa1eASLF3hptnCqRyxThbh/E8Z2NmoaUPUnVhIoxB5OgV2RHFwF47ZgKaWBQJakqQf
 2gw3mTuVfYzilcRZjxn6OIIeBWogy+Ij/X44Ad3G4ac+LtWzOUCuUf+FsTzFqD7NXFiZ
 eU6/1ThSa5DwVm2SQ0rLHpj7RCNl++BjbDIQDtuDb5HSFHBIghgdxEqPyTxJBIFkjJHm
 Os5hSrtf+0MInyE82FdIffAogmLr1clBTJ49SBJfFc7EMVI+K8Vvcbjty44ldJTTTx1K
 gm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694797118; x=1695401918;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SuhfdU4PspnFHfisOXH5BuuofTvFKNo2MDW2PD1bi8M=;
 b=Q2Qd/o2/1vQzdtqRtfe1jyhecmj2ye+Cw4Tbxu5owrFPEYi3OtOEAlZx7eW9kebAEZ
 /xHpWy8I4L9NVb5tiLcro+byKQo8ou0qiqoOHMhr2ffFqK94IGrr4y5bcyW6lu7XD0M5
 55c7cmGX2nJKb+eQ3ibNy+HddT6OFbv8DqyH8pYuhneKrxecanMk5gjPhTpF9oZ/cSWP
 1/YP6c7cZgNt7nUJcB7WfHCFQpwgUUrvShPCBwEvdJNHYEs+Flp9eyk/ivUtOXdIcRyv
 FpMFx6lch57mkHp5K+DvgRBPpazGP1+H3wAKuYb8JH+hg5a8/QVxFjnUK6pnuRczK4pl
 ZovQ==
X-Gm-Message-State: AOJu0Yw757AiHy3LOqAAamHkHa3AwPrYNl4SmSY/FBWUDRJHKHBwx+5/
 43lwESzRT4hLB1FODDE3vzFQ1w==
X-Google-Smtp-Source: AGHT+IFdIGM6BidTwVLg4yqxDpSenVicZi7FNFdLCOeFim7bvnHJNiyUoQPR1KebsFw6KPvuwdbZBA==
X-Received: by 2002:a05:6a20:3d83:b0:13d:bf07:7444 with SMTP id
 s3-20020a056a203d8300b0013dbf077444mr2649176pzi.0.1694797117959; 
 Fri, 15 Sep 2023 09:58:37 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 fm25-20020a056a002f9900b0068782960099sm3185450pfb.22.2023.09.15.09.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 09:58:37 -0700 (PDT)
Message-ID: <37ed7472-428f-4a5a-8ac9-fd2a7ab05691@daynix.com>
Date: Sat, 16 Sep 2023 01:58:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v5 06/13] virtio-gpu: Support context init feature
 with virglrenderer
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
 <20230915111130.24064-7-ray.huang@amd.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230915111130.24064-7-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
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
> Patch "virtio-gpu: CONTEXT_INIT feature" has added the context_init
> feature flags.
> We would like to enable the feature with virglrenderer, so add to create
> virgl renderer context with flags using context_id when valid.
> 
> Originally-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
> 
> V4 -> V5:
>      - Inverted patch 5 and 6 because we should configure
>        HAVE_VIRGL_CONTEXT_INIT firstly. (Philippe)
> 
>   hw/display/virtio-gpu-virgl.c | 13 +++++++++++--
>   hw/display/virtio-gpu.c       |  2 ++
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 8bb7a2c21f..312953ec16 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -106,8 +106,17 @@ static void virgl_cmd_context_create(VirtIOGPU *g,
>       trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,
>                                       cc.debug_name);
>   
> -    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen,
> -                                  cc.debug_name);
> +    if (cc.context_init) {
> +#ifdef HAVE_VIRGL_CONTEXT_INIT
> +        virgl_renderer_context_create_with_flags(cc.hdr.ctx_id,
> +                                                 cc.context_init,
> +                                                 cc.nlen,
> +                                                 cc.debug_name);
> +        return;
> +#endif
> +    }
> +
> +    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen, cc.debug_name);
>   }
>   
>   static void virgl_cmd_context_destroy(VirtIOGPU *g,
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 3e658f1fef..a66cbd9930 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1506,6 +1506,8 @@ static Property virtio_gpu_properties[] = {
>       DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
>                       VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
>       DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
> +    DEFINE_PROP_BIT("context_init", VirtIOGPU, parent_obj.conf.flags,
> +                    VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED, false),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   

I think it's more convenient if this feature is enabled by default.

