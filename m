Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6E178E9EF
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:10:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbed2-0005yr-W3; Thu, 31 Aug 2023 06:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qbed0-0005yO-Va
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:10:18 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qbecy-0004fA-B9
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:10:18 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-565403bda57so474791a12.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693476615; x=1694081415;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7xV5TKTZLN/3JXan3YO54ft5hHcTRYD0N+F4yuMnyUc=;
 b=X5dWVh8Js1NAVqVkfkzZ+CigdF4UoPcsg27F2azITT/bnwH5q0cNSBEVMm1z8Sn3VV
 lOLD2J5mRpn5LgYxk0eZ82s3OUHfPcWWZ9yhlWfxAepujs5whkV7S1p4bmvJ5ZEuD/Dk
 09NTIkoMwmKKWm/RjfCX+JZAgu37NU923TXdzkgUgslNKiuISgXMwiMhAKxE4Toq+FkZ
 CjEqB4fg+/gedixC0XeQpCj7AhozWTJg9aTc45htg/yuhg2XAjiPRlJKo0DvVE2MREPj
 wko4XiAbrTNQkxrceEHRLTMn2+jw+ZhWC1zwAE9Fp/HDHRxDkK4oJ6UOSz8/CtHWQ70d
 9gTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693476615; x=1694081415;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7xV5TKTZLN/3JXan3YO54ft5hHcTRYD0N+F4yuMnyUc=;
 b=EobbPyTCaHpYXYFQ5E5qSkojqQtxxFQSgUEk4MavglP1LNx/uI6PMmSORCClp3/NdT
 grK2YPAImHxUTbe5tfPZeD1kViAAf5gfGyzDt+0b9QY4KUw4LTctx8TVRk7m+lN9rt9K
 W29e5BEDuEM1mkdC/6xJauBy7x8PFTLeUJPeokp5kycm/lBodJHDKqclLmnDhXepphZo
 Dfk8M6yhLehIqJIJgXPsE0N6HZ/6n4XbWdZ+WeP37isx8HedpLqyq+X8E7se5bvj7529
 RHhq6E97CtPvIgBslHKh3FUkCWSxP/uHsZ+fckZc0w8aL2MUHgYS85mZxuzM8fe3KOfa
 06ng==
X-Gm-Message-State: AOJu0Yw6QmwWMjZVlzVBEZn1QZPrFXcq0p4sJyyRgyKgILZJWaetfxub
 kI1cJwTjP5Qy+FSfgO1iVJNrmw==
X-Google-Smtp-Source: AGHT+IEzCPAVkZ+OTDDrjqC043m/jBaZip82pDddNT2h8xBjnKXA9BSp1Xd1jvkLzRYYNTay05mZbA==
X-Received: by 2002:a05:6a20:c901:b0:130:835b:e6b7 with SMTP id
 gx1-20020a056a20c90100b00130835be6b7mr4181294pzb.47.1693476614617; 
 Thu, 31 Aug 2023 03:10:14 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 ff16-20020a056a002f5000b0068991abe1desm1026798pfb.176.2023.08.31.03.10.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 03:10:14 -0700 (PDT)
Message-ID: <b988f9d4-69d7-4cc4-b13e-3e697acf9fe9@daynix.com>
Date: Thu, 31 Aug 2023 19:10:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v4 07/13] softmmu/memory: enable automatic
 deallocation of memory regions
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
 <20230831093252.2461282-8-ray.huang@amd.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230831093252.2461282-8-ray.huang@amd.com>
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

On 2023/08/31 18:32, Huang Rui wrote:
> From: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
> 
> When the memory region has a different life-cycle from that of her parent,
> could be automatically released, once has been unparent and once all of her
> references have gone away, via the object's free callback.
> 
> However, currently, references to the memory region are held by its owner
> without first incrementing the memory region object's reference count.
> As a result, the automatic deallocation of the object, not taking into
> account those references, results in use-after-free memory corruption.
> 
> This patch increases the reference count of the memory region object on
> each memory_region_ref() and decreases it on each memory_region_unref().
> 
> Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
> 
> New patch
> 
>   softmmu/memory.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 7d9494ce70..0fdd5eebf9 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -1797,6 +1797,15 @@ Object *memory_region_owner(MemoryRegion *mr)
>   
>   void memory_region_ref(MemoryRegion *mr)
>   {
> +    if (!mr) {
> +        return;
> +    }
> +
> +    /* Obtain a reference to prevent the memory region object
> +     * from being released under our feet.
> +     */
> +    object_ref(OBJECT(mr));
> +
>       /* MMIO callbacks most likely will access data that belongs
>        * to the owner, hence the need to ref/unref the owner whenever
>        * the memory region is in use.
> @@ -1807,16 +1816,22 @@ void memory_region_ref(MemoryRegion *mr)
>        * Memory regions without an owner are supposed to never go away;
>        * we do not ref/unref them because it slows down DMA sensibly.
>        */

The collapsed comment says:
 > The memory region is a child of its owner.  As long as the
 > owner doesn't call unparent itself on the memory region,
 > ref-ing the owner will also keep the memory region alive.
 > Memory regions without an owner are supposed to never go away;
 > we do not ref/unref them because it slows down DMA sensibly.

It contradicts with this patch.

> -    if (mr && mr->owner) {
> +    if (mr->owner) {
>           object_ref(mr->owner);
>       }
>   }
>   
>   void memory_region_unref(MemoryRegion *mr)
>   {
> -    if (mr && mr->owner) {
> +    if (!mr) {
> +        return;
> +    }
> +
> +    if (mr->owner) {
>           object_unref(mr->owner);
>       }
> +
> +    object_unref(OBJECT(mr));
>   }
>   
>   uint64_t memory_region_size(MemoryRegion *mr)

