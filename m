Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 641A87A220B
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:12:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhAU5-0000d6-S1; Fri, 15 Sep 2023 11:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhATr-0000T2-Ky
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:11:39 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhATn-0002h6-1o
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:11:37 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c3cbfa40d6so20149465ad.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694790693; x=1695395493;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KCQqoZ18jpGX1KCrU7S3I3Im0sSOsGzv0y0heQncKU4=;
 b=yOoviG0ITZXUPTmQyEB0g/8Aavw8teR7pxiRETr1yXJZnMsiV5Kkf39yw7i1RoKocN
 ZqfNTlVKGF8gTxMNRST8AynJxLya3UAniWtKwzWDbndcVI34dtZIdQe8HiH4ZYVOTSfz
 Y5QJU5KUUAbaq+1BTOKL1xYpdJXZE2FmxNavQBzJXxpQWOm5xMBXZPa88Rw2vQC39E59
 Nkr1uyQGJjZQ9VM+fJhuEq6zwEwuwEF9yNaOQeYVSUuxS0+vWrhJBkHsMIe6ztbj7QYV
 z8rXgkEU1eM6nK84dwT9GPd9pqExbDGBhbJU93c61ieHkP7UIjjPCzL4PuUgiyhOtbr3
 jYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694790693; x=1695395493;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KCQqoZ18jpGX1KCrU7S3I3Im0sSOsGzv0y0heQncKU4=;
 b=eqFiOqMrDx8UMQTmzWTqoxHaH63e2y65affMC1PWGTXt2BwwpWLvqR/JhCyuT0trJM
 U3LqSgt7+2H/dmQ59zoqmGaDR8HZh/b3yPozNaJO45/Y9FltbyOTqTwXo3ex8kxird6c
 1vLZwcP4oSUNWjlcmAoXQhibzF6lZJZonEYK8/ytBnOb+thul3sEV9uKLfTlWEJs8jVP
 eRC03T/NguiVwy2XGLA17/3rXBumnx0g+7LrkNL1ObRkVM3P0pfDrREe+O8TTlun3TZ1
 6fVFtBP8QtbeeDkY2N2H0ZEfsJtp/sSybdf1NWXRLCKvKD9GVHQ7+lNEnhKiFA6XDHyf
 A9qw==
X-Gm-Message-State: AOJu0Yy/BF7KWrXYY5GOQppE9w4nNUoEkcOpE0X/kp3vSsgG+giVabf9
 mmhKQ7qBeORE7TYebsr2335C/g==
X-Google-Smtp-Source: AGHT+IFeBqAAw/xZfJOIrv+PMMlVSoIDSLdN/PSNRJYjvS4mbp4KtNnaSSjCRhmZFu3zOoD/wmVTFw==
X-Received: by 2002:a17:902:e552:b0:1c3:3682:f83f with SMTP id
 n18-20020a170902e55200b001c33682f83fmr2476230plf.30.1694790693438; 
 Fri, 15 Sep 2023 08:11:33 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a17090341c600b001c3f7fd1ef7sm3623245ple.12.2023.09.15.08.11.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 08:11:32 -0700 (PDT)
Message-ID: <99fb4575-9f8d-4ab6-bc22-911bbaa7ca55@daynix.com>
Date: Sat, 16 Sep 2023 00:11:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v5 07/13] softmmu/memory: enable automatic
 deallocation of memory regions
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
 Chen Jiqian <Jiqian.Chen@amd.com>
References: <20230915111130.24064-1-ray.huang@amd.com>
 <20230915111130.24064-8-ray.huang@amd.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230915111130.24064-8-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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
> This patch increases the reference count of an owned memory region object
> on each memory_region_ref() and decreases it on each memory_region_unref().
> 
> Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
> 
> V4 -> V5:
>      - ref/unref only owned memory regions (Akihiko)
> 
>   softmmu/memory.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 7d9494ce70..15e1699750 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -1800,6 +1800,9 @@ void memory_region_ref(MemoryRegion *mr)
>       /* MMIO callbacks most likely will access data that belongs
>        * to the owner, hence the need to ref/unref the owner whenever
>        * the memory region is in use.
> +     * Likewise, the owner keeps references to the memory region,
> +     * hence the need to ref/unref the memory region object to prevent
> +     * its automatic deallocation while still referenced by its owner.

This comment does not make sense. Traditionally no such automatic 
deallocation happens so the owner has been always required to free the 
memory region when it gets finalized.

"[QEMU PATCH v5 09/13] virtio-gpu: Handle resource blob commands" 
introduces a different kind of memory region, which can be freed anytime 
before the device gets finalized. Even in this case, the owner removes 
the reference to the memory owner by doing res->region = NULL;

Regards,
Akihiko Odaki

