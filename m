Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CAE79215F
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 11:18:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdSC9-0004KZ-HN; Tue, 05 Sep 2023 05:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qdSBs-0004IT-TK
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:17:46 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qdSBp-0004vh-1I
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:17:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c34c9cc9b9so4390655ad.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 02:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693905458; x=1694510258;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XO2+yXar5HP/Nvv10RVpzWvUXgBqEg4olN/cjiB+X1I=;
 b=J72OxGy2NdrX7LgUQerfgxvEz3IN/TiLqWoQWhm0Fz0xhRyREeqOo1Rbjwgk7ZzWPi
 CxcqK5ghbFOY8g4V0XLdh9vLPyATXnQGPbzBuEmtJFWrofrsdMJiIbUf2n+VKt7CdPqA
 bNol81nGFI7p1Z/RO7IYbfxf9JPeWH+A+KttkusSXKKu++sigjDH3QlU9AClLpITzJbt
 WBNBBdqIqc9f5HwftSoywUg2xoxwNUUJqea63hxYGmpTptKi3ViQzrb0vjJe57jqL8hu
 3yoKgA+qCUcEY3aMBA2fC6Gaah5va5D1DrezwOQnm7vBp4KhXsJLrE+7a0pj9LN4s7+D
 7nwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693905458; x=1694510258;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XO2+yXar5HP/Nvv10RVpzWvUXgBqEg4olN/cjiB+X1I=;
 b=BEZtx/aFejSGjf5uJboc1z5gdBkHz2ijJ9RsXH/Y01j8ytsPduAvUj2Jo2teVmcP6y
 +HbI3KfLm1bEDeng2hGN2Y/Q5r6D3CeG3i+TtSfFTzndO/1SZd4aHmCZFsbZOlL4Jmt0
 8hUh4Db8/styQuFyLqa+EH7tsipHYlD80QDAW1pbpy3JRFuCmnWw3zNCuqg8E4rUIo0p
 Z+sphP6YjwnKRRbNH9FTvqqZ1e2ZVXqZx+AHDq/3n+u53DAHRhdPk6Kvnr+GHWdpR32G
 3t18s1xECLwgi1WcLVUtaxmiUB0kz7cDkonaB/5+JEnYebA1mjpnvss2uTt4COEznbWx
 lWkQ==
X-Gm-Message-State: AOJu0Yyhp9qlrdalKQ3TmbdF085ciLK/K3GEnQpcZQckRWk8Xsxy3noE
 i5e2mO2ZIimaOz6nhYj3Agbjtg==
X-Google-Smtp-Source: AGHT+IHmdsTj3NWf+kJXTqNa0KpZXSsejtq0BJ85YRdCU9SkqxFyfpvDRx0WQ9z097JuwTP/N0j0PA==
X-Received: by 2002:a17:903:228a:b0:1bd:a22a:d40a with SMTP id
 b10-20020a170903228a00b001bda22ad40amr12216472plh.2.1693905458526; 
 Tue, 05 Sep 2023 02:17:38 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a170902654a00b001bde877a7casm8982684pln.264.2023.09.05.02.17.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 02:17:38 -0700 (PDT)
Message-ID: <2ec5929b-eb79-4848-8ab4-517c89f6b476@daynix.com>
Date: Tue, 5 Sep 2023 18:17:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v4 07/13] softmmu/memory: enable automatic
 deallocation of memory regions
Content-Language: en-US
To: Huang Rui <ray.huang@amd.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 "ernunes@redhat.com" <ernunes@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Huang, Honglei1" <Honglei1.Huang@amd.com>,
 "Zhang, Julia" <Julia.Zhang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
References: <20230831093252.2461282-1-ray.huang@amd.com>
 <20230831093252.2461282-8-ray.huang@amd.com>
 <b988f9d4-69d7-4cc4-b13e-3e697acf9fe9@daynix.com> <ZPbvyDsikvvzierv@amd.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZPbvyDsikvvzierv@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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

On 2023/09/05 18:07, Huang Rui wrote:
> On Thu, Aug 31, 2023 at 06:10:08PM +0800, Akihiko Odaki wrote:
>> On 2023/08/31 18:32, Huang Rui wrote:
>>> From: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
>>>
>>> When the memory region has a different life-cycle from that of her parent,
>>> could be automatically released, once has been unparent and once all of her
>>> references have gone away, via the object's free callback.
>>>
>>> However, currently, references to the memory region are held by its owner
>>> without first incrementing the memory region object's reference count.
>>> As a result, the automatic deallocation of the object, not taking into
>>> account those references, results in use-after-free memory corruption.
>>>
>>> This patch increases the reference count of the memory region object on
>>> each memory_region_ref() and decreases it on each memory_region_unref().
>>>
>>> Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>>> ---
>>>
>>> New patch
>>>
>>>    softmmu/memory.c | 19 +++++++++++++++++--
>>>    1 file changed, 17 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/softmmu/memory.c b/softmmu/memory.c
>>> index 7d9494ce70..0fdd5eebf9 100644
>>> --- a/softmmu/memory.c
>>> +++ b/softmmu/memory.c
>>> @@ -1797,6 +1797,15 @@ Object *memory_region_owner(MemoryRegion *mr)
>>>    
>>>    void memory_region_ref(MemoryRegion *mr)
>>>    {
>>> +    if (!mr) {
>>> +        return;
>>> +    }
>>> +
>>> +    /* Obtain a reference to prevent the memory region object
>>> +     * from being released under our feet.
>>> +     */
>>> +    object_ref(OBJECT(mr));
>>> +
>>>        /* MMIO callbacks most likely will access data that belongs
>>>         * to the owner, hence the need to ref/unref the owner whenever
>>>         * the memory region is in use.
>>> @@ -1807,16 +1816,22 @@ void memory_region_ref(MemoryRegion *mr)
>>>         * Memory regions without an owner are supposed to never go away;
>>>         * we do not ref/unref them because it slows down DMA sensibly.
>>>         */
>>
>> The collapsed comment says:
>>   > The memory region is a child of its owner.  As long as the
>>   > owner doesn't call unparent itself on the memory region,
>>   > ref-ing the owner will also keep the memory region alive.
>>   > Memory regions without an owner are supposed to never go away;
>>   > we do not ref/unref them because it slows down DMA sensibly.
>>
>> It contradicts with this patch.
> 
> The reason that we modify it is because we would like to address the memory
> leak issue in the original codes. Please see below, we find the memory
> region will be crashed once we free(unref) the simple resource, because the
> region will be freed in object_finalize() after unparent and the ref count
> is to 0. Then the VM will be crashed with this.
> 
> In virgl_cmd_resource_map_blob():
>      memory_region_init_ram_device_ptr(res->region, OBJECT(g), NULL, size, data);
>      OBJECT(res->region)->free = g_free;
>      memory_region_add_subregion(&b->hostmem, mblob.offset, res->region);
>      memory_region_set_enabled(res->region, true);
> 
> In virtio_gpu_virgl_resource_unmap():
>      memory_region_set_enabled(res->region, false);
>      memory_region_del_subregion(&b->hostmem, res->region);
>      object_unparent(OBJECT(res->region));
>      res->region = NULL;
> 
> I spent a bit more time to understand your point, do you want me to update
> corresponding comments or you have some concern about this change?

As the comment says ref-ing memory regions without an owner will slow 
down DMA, you should avoid that. More concretely, you should check 
mr->owner before doing object_ref(OBJECT(mr)).

Regards,
Akihiko Odaki

