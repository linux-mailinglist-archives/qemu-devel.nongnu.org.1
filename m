Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1507778EA7B
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:43:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbf98-0002LC-8e; Thu, 31 Aug 2023 06:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qbf95-0002L4-MW
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:43:27 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qbf93-0003hX-7M
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:43:27 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bee82fad0fso4703975ad.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693478603; x=1694083403;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pthxO9otZ5F1W93I4fM7b6t8TGyUaxxABGXbq13EuGw=;
 b=2MBGQRcr6Xd7XIGkm63xujqBzeXqPo6abLAN8JWwFIz5yj8zfvcU5i3xX7hTegg7F3
 ndDyuMJamiq5KxYcoI5KJFfTxWBssfWRtxfYIWepL5A0FwGRh/TC7tugwGazG9ZhrB2F
 smJkCYL7GVzCSbq/WcisoCNwXD9dNvbu8Oo2+GSDZ9TQ/JcfLnYmJui22qZSY0qESbMJ
 blgWiAO2Z2+Gub/WbrctuuHeMuZQbVKU8r/Q6gTBEYoJwFo/2IHgBJzm/2us93hd0z+k
 Cbk3YX9WRSU+yTKMSyapot1HqM/DUuVnr6w0+OkSlbLFUyxzBXF0Mmb1crxnrkrZTJ70
 vQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478603; x=1694083403;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pthxO9otZ5F1W93I4fM7b6t8TGyUaxxABGXbq13EuGw=;
 b=cTMKw9oYohlXetG//BPP+a0tgWMfg7tE+4eeUjWJwOhzNDqfjDPW4CPsc6QmqRXFDU
 Fjsc1xi6HcuEOstPeCRouwYT8Bxf9fq1e1mjQA9OiLmluPFhDvUKAZpIMQ7FHj85gm9u
 5vgHm2cWJqNHbuw4KQeId03RexDDsvRxVG+jrIB0U/d9dS3OuBbi8acQUw3T3HdstnCE
 FMGLVLZwLgmxjajOHZtN/Ff3yozOKivjN6+Bh2K/KiBcxzGq4OAXXm2TGpMlrWtLInEF
 CXmKrEeITNftjrqCVvH4if02ETQgx4bgF7Gij+3bCX5Kj795YK5k10690EJwFa4Vf9si
 7IRw==
X-Gm-Message-State: AOJu0YzybFXbRn3Nvk2gTHj+0dPDjZQ8hRG0cxBHECV+1rWzom6irND3
 QTVF1Kz6fsYrwCGaL/lHT0g8NQ==
X-Google-Smtp-Source: AGHT+IF61CnqGDOu6EZq+ZgIaumeod7KOlm7Ef1ZjxoEiKfNUFtI0udiwYapvHIpTz8Oekph4Jtnfg==
X-Received: by 2002:a17:902:c086:b0:1c0:6e92:8cc5 with SMTP id
 j6-20020a170902c08600b001c06e928cc5mr3604644pld.17.1693478603280; 
 Thu, 31 Aug 2023 03:43:23 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a170902740c00b001bbdd44bbb6sm984888pll.136.2023.08.31.03.43.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 03:43:22 -0700 (PDT)
Message-ID: <fe36e4e1-1198-4da4-b6ee-a6a00a44298a@daynix.com>
Date: Thu, 31 Aug 2023 19:43:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v4 11/13] virtio-gpu: Support Venus capset
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
 <20230831093252.2461282-12-ray.huang@amd.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230831093252.2461282-12-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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
> Add support for the Venus capset, which enables Vulkan support through
> the Venus Vulkan driver for virtio-gpu.
> 
> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   hw/display/virtio-gpu-virgl.c               | 21 +++++++++++++++++----
>   include/standard-headers/linux/virtio_gpu.h |  2 ++
>   2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 1a996a08fc..83cd8c8fd0 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -437,6 +437,11 @@ static void virgl_cmd_get_capset_info(VirtIOGPU *g,
>           virgl_renderer_get_cap_set(resp.capset_id,
>                                      &resp.capset_max_version,
>                                      &resp.capset_max_size);
> +    } else if (info.capset_index == 2) {
> +        resp.capset_id = VIRTIO_GPU_CAPSET_VENUS;
> +        virgl_renderer_get_cap_set(resp.capset_id,
> +                                   &resp.capset_max_version,
> +                                   &resp.capset_max_size);
>       } else {
>           resp.capset_max_version = 0;
>           resp.capset_max_size = 0;
> @@ -901,10 +906,18 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>   
>   int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>   {
> -    uint32_t capset2_max_ver, capset2_max_size;
> +    uint32_t capset2_max_ver, capset2_max_size, num_capsets;
> +    num_capsets = 1;
> +
>       virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
> -                              &capset2_max_ver,
> -                              &capset2_max_size);
> +                               &capset2_max_ver,
> +                               &capset2_max_size);
> +    num_capsets += capset2_max_ver ? 1 : 0;
> +
> +    virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VENUS,
> +                               &capset2_max_ver,
> +                               &capset2_max_size);
> +    num_capsets += capset2_max_size ? 1 : 0;
>   
> -    return capset2_max_ver ? 2 : 1;
> +    return num_capsets;
>   }
> diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
> index 2da48d3d4c..2db643ed8f 100644
> --- a/include/standard-headers/linux/virtio_gpu.h
> +++ b/include/standard-headers/linux/virtio_gpu.h
> @@ -309,6 +309,8 @@ struct virtio_gpu_cmd_submit {
>   
>   #define VIRTIO_GPU_CAPSET_VIRGL 1
>   #define VIRTIO_GPU_CAPSET_VIRGL2 2
> +/* 3 is reserved for gfxstream */
> +#define VIRTIO_GPU_CAPSET_VENUS 4

This file is synced with scripts/update-linux-headers.sh and should not 
be modified.

>   
>   /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>   struct virtio_gpu_get_capset_info {

