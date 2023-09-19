Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 960AA7A6E90
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 00:19:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qij3G-00059L-9d; Tue, 19 Sep 2023 18:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qij3D-00058y-Ld
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 18:18:35 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qij3B-0003NW-Oo
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 18:18:35 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-690d9cda925so267797b3a.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 15:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695161911; x=1695766711;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3/WBAKiVVTIZTUnUZcCI6R2zaD2HeHs6ef/lTYwk9Cs=;
 b=D7NokWK8mtvXXrshDwYmeDPv1yvzEP/Xj29Qep0hVPT5b9lg08G82w5zFtqPqtjduD
 qu5X44t+NdD3h1/ilEOKX2D0oxThxxzUPe0ebwma9Hba9ySOQBuHZz6kvYtlD7udLecy
 hQBaULTzQboA/YvbRzHKEn0VI8v6dk36VD/m7h/H5uX258iOaFLqDWAh905NwB9pDy3T
 R3oPH6HzyovWx+6vmt6zii6ByXd9pWxpdXAaShepVUXWxxd3dOK5wpa4a5XYY0jrhoMy
 kGni2fClBrpclFsE6bK5Ybu2WRrhdK8EqBRttbe9fxWzJU7DFBGp+ncL4nOIWDMnUABW
 B5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695161911; x=1695766711;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3/WBAKiVVTIZTUnUZcCI6R2zaD2HeHs6ef/lTYwk9Cs=;
 b=pmKs5OUAr8soXQSUtiOsLoEAq6+0ePj0xaXneBatkQjJOJ0qdx7xN3VY4vhwtkwwEY
 3LGkZKdSRnAEkwYKNpgMuOp4sGHOsZx4PK5xrN+4fMgC92+MLD4P9+PGGBidgEeyRVSS
 Aiq9q0pnzvIq+5wG4QiG/Ijfbpzuf9UX3JA8aG3XcnkhotWN27Oe6C3ta1eZoK4QPUcN
 sfUOczf3FNeO9BpwKF5udICI8mAcTq8FcmRcnX/aGj4mlir8tOwelILHJRG4kZP6uKa4
 YCSJRxBin9e9OhBy6rBcR8WehMYLO4RFF+ZyTc6i4uFU1Uc+FcD9GXZUmGZ4sg//DmG8
 kysQ==
X-Gm-Message-State: AOJu0YzfOT2Uxzu7pYD12OHrYk35qCd0GznKdTtO3rDcioYQkGCm0XAo
 JzkIEdOjZoPt0jAOfAEwl/AWSw==
X-Google-Smtp-Source: AGHT+IGCTM5ajgY5J1AFb3CtixVMVLw6zdcujmSjeiV0hK1rQ20clhkJcshSrSIKpJN+HiDrOS5rdw==
X-Received: by 2002:a05:6a00:1950:b0:68e:4955:c405 with SMTP id
 s16-20020a056a00195000b0068e4955c405mr910424pfk.27.1695161910722; 
 Tue, 19 Sep 2023 15:18:30 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 v3-20020a62a503000000b00682bec0b680sm9034527pfm.89.2023.09.19.15.18.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 15:18:30 -0700 (PDT)
Message-ID: <73a35fbb-c9a4-41dc-a6c7-26037b0e412f@daynix.com>
Date: Wed, 20 Sep 2023 07:18:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v5 07/13] softmmu/memory: enable automatic
 deallocation of memory regions
Content-Language: en-US
To: Xenia Ragiadakou <xenia.ragiadakou@amd.com>, Huang Rui
 <ray.huang@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
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
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>
References: <20230915111130.24064-1-ray.huang@amd.com>
 <20230915111130.24064-8-ray.huang@amd.com>
 <99fb4575-9f8d-4ab6-bc22-911bbaa7ca55@daynix.com>
 <c0370b6e-c17e-2400-ef8a-7a759d2fc2d7@amd.com>
 <75698621-d210-40eb-872d-f3cfc6e4dbff@daynix.com>
 <32a68715-201b-9923-9600-fe5ae49e4b7b@amd.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <32a68715-201b-9923-9600-fe5ae49e4b7b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
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

On 2023/09/19 23:21, Xenia Ragiadakou wrote:
> 
> On 19/9/23 13:44, Akihiko Odaki wrote:
>> On 2023/09/19 19:28, Xenia Ragiadakou wrote:
>>>
>>> On 15/9/23 18:11, Akihiko Odaki wrote:
>>>> On 2023/09/15 20:11, Huang Rui wrote:
>>>>> From: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
>>>>>
>>>>> When the memory region has a different life-cycle from that of her 
>>>>> parent,
>>>>> could be automatically released, once has been unparent and once 
>>>>> all of her
>>>>> references have gone away, via the object's free callback.
>>>>>
>>>>> However, currently, references to the memory region are held by its 
>>>>> owner
>>>>> without first incrementing the memory region object's reference count.
>>>>> As a result, the automatic deallocation of the object, not taking into
>>>>> account those references, results in use-after-free memory corruption.
>>>>>
>>>>> This patch increases the reference count of an owned memory region 
>>>>> object
>>>>> on each memory_region_ref() and decreases it on each 
>>>>> memory_region_unref().
>>>>>
>>>>> Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
>>>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>>>>> ---
>>>>>
>>>>> V4 -> V5:
>>>>>      - ref/unref only owned memory regions (Akihiko)
>>>>>
>>>>>   softmmu/memory.c | 5 +++++
>>>>>   1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/softmmu/memory.c b/softmmu/memory.c
>>>>> index 7d9494ce70..15e1699750 100644
>>>>> --- a/softmmu/memory.c
>>>>> +++ b/softmmu/memory.c
>>>>> @@ -1800,6 +1800,9 @@ void memory_region_ref(MemoryRegion *mr)
>>>>>       /* MMIO callbacks most likely will access data that belongs
>>>>>        * to the owner, hence the need to ref/unref the owner whenever
>>>>>        * the memory region is in use.
>>>>> +     * Likewise, the owner keeps references to the memory region,
>>>>> +     * hence the need to ref/unref the memory region object to 
>>>>> prevent
>>>>> +     * its automatic deallocation while still referenced by its 
>>>>> owner.
>>>>
>>>> This comment does not make sense. Traditionally no such automatic 
>>>> deallocation happens so the owner has been always required to free 
>>>> the memory region when it gets finalized.
>>>>
>>>> "[QEMU PATCH v5 09/13] virtio-gpu: Handle resource blob commands" 
>>>> introduces a different kind of memory region, which can be freed 
>>>> anytime before the device gets finalized. Even in this case, the 
>>>> owner removes the reference to the memory owner by doing res->region 
>>>> = NULL;
>>>
>>> Hi Akihiko,
>>>
>>> You are right, the word "owner" is not correct. The issue observed 
>>> was due to the references kept in flatview ranges and the fact that 
>>> flatview_destroy() is asynchronous and was called after memory 
>>> region's destruction.
>>>
>>> If I replace the word "owner" with "memory subsystem" in the commit 
>>> message and drop the comment, would that be ok with you? or do want 
>>> to suggest something else?
>>
>> This will extend the lifetime of the memory region, but the underlying 
>> memory is still synchronously freed. Can you show that the flatview 
>> range will not be used to read the freed memory?
> 
> Yes, the intention of this patch is to delay the mr object finalization 
> until all memory_region_unref() on this mr have been taken place.
> 
> What do you mean by "the underlying memory is still synchronously freed"?
> 

A pointer is passed to memory_region_init_ram_ptr() with the ptr 
parameter when initializing the memory region and the memory region 
keeps the pointer.

In virtio_gpu_virgl_resource_unmap(), the memory pointed with the 
pointer is unmapped with virgl_renderer_resource_unmap() and makes the 
pointer kept by the memory region dangling though the lifetime of the 
memory region is extended with this patch. Can you show that the 
dangling pointer the memory region has will never be referenced?

