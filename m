Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 198837A7902
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 12:20:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiuI8-0004gi-0B; Wed, 20 Sep 2023 06:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qiuI1-0004gX-HD
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 06:18:37 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qiuHz-00070G-CQ
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 06:18:37 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1c50438636fso3931295fac.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 03:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695205114; x=1695809914;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wGNXVPxGii/1OrruCGR9o+G35rIoyKM+zE3Q4kluY2o=;
 b=fu+QSJYmjBcAyhrAH+K+e115dbslnYzDsAdLiCOpR4EIHiWM8OkYxbAXxj5yrDTG7+
 4OtfjQMsSy0pGEJvlb15DuXAV/GJ6Pw6/CK0xZJSoILM2UiyqjvhXlDTtPfz3SpfBwDX
 Yh31ZduHlxV7L4BkWnl1M1OAtxSI21mUN+i9hX2/lDszInjtLm7C7E6C9Z7viv4tBnEC
 MJdrHnN9qo/OnCLCWg/6UO/H/xYooG+MXuHHcsx8+o7TTV5s6PHTsJRGTQoy8tZcQRC8
 2DPnU8nf94UXpUfF3STwJ589CPhKlXdwdeBV5m+eWmhgJOeivcGasbTr10U08PCv/FJL
 +71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695205114; x=1695809914;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wGNXVPxGii/1OrruCGR9o+G35rIoyKM+zE3Q4kluY2o=;
 b=b4r/qQGrStwXObMGn/sVAYYqnlsYiMOwR04gqVHTiFyifWvuiypKjXoGYYeJHwP6og
 nlxcUQJYsnQ3lwIR6F+XpUGdts3W8J/uZuln7oHf7Kggi2XDpKqlS0a5etSCo0uwkMKw
 wyzieYPxSV7TboGJd+zt3xX+rpd2hATb+TGEq2xgWIS4RPU/WBTalr1ORIKN1XIvzLkH
 IWEYobCKMWsbPZUnov1+vRQbf0HN6iuagc8FSmh8CEahIr1YAcBCqyn6uKZgkgRro9MG
 yiEBlADtcftEjpoIWt6kk5lO+Dq5Qbwu+bqVcyIYI9rE3r+dGL6WsEzHjWvB6/WIveKy
 qUrg==
X-Gm-Message-State: AOJu0YzBnq70pmQKnwtBy0+VcbGW1OK+Na8ji+o0Pv/LV9Kxf5c0pGLr
 7LBjWXY1SkubNLHLRAmZzSYBLQ==
X-Google-Smtp-Source: AGHT+IETjZDCEEs66uqF++esmIHFfY2g6LKNY3dRSbU1y5F6WeIuUIjbS0tRfk5rD7INdlVSaQGKgg==
X-Received: by 2002:a05:6870:8a29:b0:1bb:753d:e6db with SMTP id
 p41-20020a0568708a2900b001bb753de6dbmr2230286oaq.3.1695205114050; 
 Wed, 20 Sep 2023 03:18:34 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 v17-20020aa78091000000b00687fcb1e609sm9900008pff.116.2023.09.20.03.18.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Sep 2023 03:18:33 -0700 (PDT)
Message-ID: <610ae949-89e7-4722-951d-ba0e8427919d@daynix.com>
Date: Wed, 20 Sep 2023 19:18:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v5 07/13] softmmu/memory: enable automatic
 deallocation of memory regions
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
 <73a35fbb-c9a4-41dc-a6c7-26037b0e412f@daynix.com>
 <1f8863da-fad1-f983-8ed0-d6bf8d9544b8@amd.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <1f8863da-fad1-f983-8ed0-d6bf8d9544b8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::33;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x33.google.com
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

On 2023/09/20 17:57, Xenia Ragiadakou wrote:
> 
> On 20/9/23 01:18, Akihiko Odaki wrote:
>> On 2023/09/19 23:21, Xenia Ragiadakou wrote:
>>>
>>> On 19/9/23 13:44, Akihiko Odaki wrote:
>>>> On 2023/09/19 19:28, Xenia Ragiadakou wrote:
>>>>>
>>>>> On 15/9/23 18:11, Akihiko Odaki wrote:
>>>>>> On 2023/09/15 20:11, Huang Rui wrote:
>>>>>>> From: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
>>>>>>>
>>>>>>> When the memory region has a different life-cycle from that of 
>>>>>>> her parent,
>>>>>>> could be automatically released, once has been unparent and once 
>>>>>>> all of her
>>>>>>> references have gone away, via the object's free callback.
>>>>>>>
>>>>>>> However, currently, references to the memory region are held by 
>>>>>>> its owner
>>>>>>> without first incrementing the memory region object's reference 
>>>>>>> count.
>>>>>>> As a result, the automatic deallocation of the object, not taking 
>>>>>>> into
>>>>>>> account those references, results in use-after-free memory 
>>>>>>> corruption.
>>>>>>>
>>>>>>> This patch increases the reference count of an owned memory 
>>>>>>> region object
>>>>>>> on each memory_region_ref() and decreases it on each 
>>>>>>> memory_region_unref().
>>>>>>>
>>>>>>> Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
>>>>>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>>>>>>> ---
>>>>>>>
>>>>>>> V4 -> V5:
>>>>>>>      - ref/unref only owned memory regions (Akihiko)
>>>>>>>
>>>>>>>   softmmu/memory.c | 5 +++++
>>>>>>>   1 file changed, 5 insertions(+)
>>>>>>>
>>>>>>> diff --git a/softmmu/memory.c b/softmmu/memory.c
>>>>>>> index 7d9494ce70..15e1699750 100644
>>>>>>> --- a/softmmu/memory.c
>>>>>>> +++ b/softmmu/memory.c
>>>>>>> @@ -1800,6 +1800,9 @@ void memory_region_ref(MemoryRegion *mr)
>>>>>>>       /* MMIO callbacks most likely will access data that belongs
>>>>>>>        * to the owner, hence the need to ref/unref the owner 
>>>>>>> whenever
>>>>>>>        * the memory region is in use.
>>>>>>> +     * Likewise, the owner keeps references to the memory region,
>>>>>>> +     * hence the need to ref/unref the memory region object to 
>>>>>>> prevent
>>>>>>> +     * its automatic deallocation while still referenced by its 
>>>>>>> owner.
>>>>>>
>>>>>> This comment does not make sense. Traditionally no such automatic 
>>>>>> deallocation happens so the owner has been always required to free 
>>>>>> the memory region when it gets finalized.
>>>>>>
>>>>>> "[QEMU PATCH v5 09/13] virtio-gpu: Handle resource blob commands" 
>>>>>> introduces a different kind of memory region, which can be freed 
>>>>>> anytime before the device gets finalized. Even in this case, the 
>>>>>> owner removes the reference to the memory owner by doing 
>>>>>> res->region = NULL;
>>>>>
>>>>> Hi Akihiko,
>>>>>
>>>>> You are right, the word "owner" is not correct. The issue observed 
>>>>> was due to the references kept in flatview ranges and the fact that 
>>>>> flatview_destroy() is asynchronous and was called after memory 
>>>>> region's destruction.
>>>>>
>>>>> If I replace the word "owner" with "memory subsystem" in the commit 
>>>>> message and drop the comment, would that be ok with you? or do want 
>>>>> to suggest something else?
>>>>
>>>> This will extend the lifetime of the memory region, but the 
>>>> underlying memory is still synchronously freed. Can you show that 
>>>> the flatview range will not be used to read the freed memory?
>>>
>>> Yes, the intention of this patch is to delay the mr object 
>>> finalization until all memory_region_unref() on this mr have been 
>>> taken place.
>>>
>>> What do you mean by "the underlying memory is still synchronously 
>>> freed"?
>>>
>>
>> A pointer is passed to memory_region_init_ram_ptr() with the ptr 
>> parameter when initializing the memory region and the memory region 
>> keeps the pointer.
>>
>> In virtio_gpu_virgl_resource_unmap(), the memory pointed with the 
>> pointer is unmapped with virgl_renderer_resource_unmap() and makes the 
>> pointer kept by the memory region dangling though the lifetime of the 
>> memory region is extended with this patch. Can you show that the 
>> dangling pointer the memory region has will never be referenced?
> 
> I see your point but I think it is not directly related to this patch. 
> IMHO, it is related to the implementation of 
> virtio_gpu_virgl_resource_unmap(). Maybe the unmapping should be done in 
> the free callback. However, I would expect the pointer to a disabled 
> memory region to not be used, not sure though.

Unmapping in the free callback sounds good.

