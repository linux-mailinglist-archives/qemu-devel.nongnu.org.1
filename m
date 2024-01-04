Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BB782417F
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 13:18:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLMev-0003M9-Iq; Thu, 04 Jan 2024 07:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rLMeQ-0003KS-QD
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 07:16:45 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rLMeO-0002gc-1f
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 07:16:41 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d3f8af8297so2291925ad.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 04:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1704370598; x=1704975398;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EYyEGe5ydr4mM6eWvaqTfQv1BLtvmj92kc4KF6KDejI=;
 b=ip+fT31KCtodxMoDrmTO61XtcxkcMgrMXbOnOPleNNVHbOh/FCdqs1dwxZbTo2WZNf
 nhZU79VPafiIVVn7dr3nIWBeX0DrMM3qf4F76fQvEieFs4KmHajnvtTIlM560rAPxZYE
 wPvNUorPO5FcoWU/ieqKVjjH/Kwz26NDocqIFowyfuGixfBpA/3mqg8Fvo6mT9HEfFfj
 GgykEhxwtcBzgMmm5GcRqhVPhPg801YhnSAWrSn3+yMzFYIrKEn+jaSIVk9HDcCq/oR2
 o+aV7sfj6ZDmd3F+qzLLW3Q+KzF+37h/SASIbwqx6o2jJH+HrzN0lIxDBY8YpOp/T1Qh
 U89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704370598; x=1704975398;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EYyEGe5ydr4mM6eWvaqTfQv1BLtvmj92kc4KF6KDejI=;
 b=q9TebFRZtYkCKLbpAGLe7i+A7jsilafr8vXyAYF4/UmWRRtL6Qd/P9+NjB/O/zuGKW
 DmqsahL7Am/F9SZnzKbLXNOJhMlkY/uFrGkzdY/SSP3TBepj34bBlkCHjAUJvdTD8PaU
 8BATq6l+7jKsVmgAqAxSRdw1n48MAju3uPfk9nmA++Ef2OXkBlkapvOUMQ690DyTnTsw
 nFokt3uw+rlXErYpuVCBJAYDtDesxuyb7ZOv5pVNqSdL+yq85UpsgNKeT36NDlcTqJGv
 Sz6TZ2k8kxcy6+R6QjPnpICdzscY0a38ugOuf/R+hvIlyRVpiMr6lQY8Jt1migqiW32V
 o1iQ==
X-Gm-Message-State: AOJu0YyUzHcQfZkb0X4ggv28GZpN+k7v5viQmIqNM89skt4l6bEmAUg5
 lkFzk5qtrch5mhdsEU2v1yJOdZYMNzVT6w==
X-Google-Smtp-Source: AGHT+IEeXiQT8qwQqiGs7lXDTBoTsxUSIfBM7UACGvrgKBmcagbrJKZAJ638hD8/dLLbDq855NNbyw==
X-Received: by 2002:a17:902:6b42:b0:1d4:60b2:b1b1 with SMTP id
 g2-20020a1709026b4200b001d460b2b1b1mr388277plt.6.1704370598276; 
 Thu, 04 Jan 2024 04:16:38 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a1709028bc100b001d4be72802esm6337823plo.150.2024.01.04.04.16.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 04:16:37 -0800 (PST)
Message-ID: <bde05200-a450-470e-8a62-feb0235ac56f@daynix.com>
Date: Thu, 4 Jan 2024 21:16:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/11] virtio-gpu: Support context init feature with
 virglrenderer
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
 <20231219075320.165227-4-ray.huang@amd.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231219075320.165227-4-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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
> Patch "virtio-gpu: CONTEXT_INIT feature" has added the context_init
> feature flags.
> We would like to enable the feature with virglrenderer, so add to create
> virgl renderer context with flags using context_id when valid.
> 
> Originally-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
> 
> Changes in v6:
> - Handle the case while context_init is disabled.
> - Enable context_init by default.
> 
>   hw/display/virtio-gpu-virgl.c | 13 +++++++++++--
>   hw/display/virtio-gpu.c       |  4 ++++
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 8bb7a2c21f..5bbc8071b2 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -106,8 +106,17 @@ static void virgl_cmd_context_create(VirtIOGPU *g,
>       trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,
>                                       cc.debug_name);
>   
> -    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen,
> -                                  cc.debug_name);
> +#ifdef HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS
> +    if (cc.context_init && virtio_gpu_context_init_enabled(g->parent_obj.conf)) {
> +        virgl_renderer_context_create_with_flags(cc.hdr.ctx_id,
> +                                                 cc.context_init,
> +                                                 cc.nlen,
> +                                                 cc.debug_name);
> +        return;
> +    }
> +#endif
> +
> +    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen, cc.debug_name);
>   }
>   
>   static void virgl_cmd_context_destroy(VirtIOGPU *g,
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index b016d3bac8..8b2f4c6be3 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1619,6 +1619,10 @@ static Property virtio_gpu_properties[] = {
>       DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
>                       VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
>       DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
> +#ifdef HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS
> +    DEFINE_PROP_BIT("context_init", VirtIOGPU, parent_obj.conf.flags,

The convention is to use "-" instead of "_" as delimiters. See comments 
for object_property_add() in: include/qom/object.h

Regards,
Akihiko Odaki

