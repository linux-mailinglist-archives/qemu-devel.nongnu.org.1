Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDB67A5FF0
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:45:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiYDx-0007hb-Ad; Tue, 19 Sep 2023 06:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qiYDu-0007hM-Tr
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:44:55 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qiYDs-0005ME-VB
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:44:54 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c3cbfa40d6so49362045ad.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 03:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695120291; x=1695725091;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=smljqgzosS5OJqCedcK9N/6xUm9qe80j7oWlUug+4Jw=;
 b=yAqZz4iUFjOZvoys1t5YMPE0RGGCU3twkpUNuw053l+4sSLmmji4Q9bImH5vFqeooi
 aTUuL+glB8m9XeMy+35A3Ca7YYvM89TquLOZSMLBzwuzriQEBn9iWq6aa3ACizWJ147y
 FRaay2R9TUNss45JxdP5hSsonfA78Lk6fIm/4I2L3+NrjbkaT5VOKZKKf3oxnzFl0kRO
 tjzc310p1gZM6ZYUD0VePiZET+8zkVvEzdWAPJxTht6Zn8ZrLOrXFwl3ey7GtT1BwpC1
 lIwmzTprVfXj8AN5biwR/lhBp+N9Iqov1MtLFbXtZ1eDkqndmsww0TbsFEckscsBBsgP
 l7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695120291; x=1695725091;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=smljqgzosS5OJqCedcK9N/6xUm9qe80j7oWlUug+4Jw=;
 b=UlGGqBGW6sqt+n0jWmTSrb8Pjdn070b1OmPRwI93YIVCCksVEZZPht/CgH8lkMt39e
 nUPjtEA9zE1hkb4zFsQm0eucpJiKm1Ysi1vICxi7+LPkThPvVaVxKy0bvIICOp0GkyUM
 +4hcIV6xndO4kX6vxH0R14zw2hJjN/QSqlXehb7STBZMC9QgbXsCo0ROtBh6yiGBk8Jh
 zdDNmAMBynYsVcKdfUzUvgtQXcwonOFDZEPW3mBJipFfWh8Xn5XeXDrD8snrSVDz69YT
 ZP2jHTb/6G7f1Q3Go6urbpanA6laHzzB+tE+rpQMtt6xWYX1EHirwzwLDwA1CGTFJp93
 EBNg==
X-Gm-Message-State: AOJu0Yw5QH9m/dCTzd2E6uG4SvQrpxumLkiLvGRGuXYIOnLjNWYdaWj0
 KH1MRsxWgArbKULJY0H4xfQmJQ==
X-Google-Smtp-Source: AGHT+IE1rvQgqf2KfT7I++lA0G6ulx4YIhz3L5ez9EyE2wjGmry5CNVl3i/34lsTkQNO0gf+B6/CXg==
X-Received: by 2002:a17:903:507:b0:1b8:4f93:b210 with SMTP id
 jn7-20020a170903050700b001b84f93b210mr9965606plb.45.1695120291167; 
 Tue, 19 Sep 2023 03:44:51 -0700 (PDT)
Received: from [157.82.206.151] ([157.82.206.151])
 by smtp.gmail.com with ESMTPSA id
 17-20020a170902ee5100b001bb7a736b4csm3409972plo.77.2023.09.19.03.44.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 03:44:50 -0700 (PDT)
Message-ID: <75698621-d210-40eb-872d-f3cfc6e4dbff@daynix.com>
Date: Tue, 19 Sep 2023 19:44:45 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <c0370b6e-c17e-2400-ef8a-7a759d2fc2d7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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

On 2023/09/19 19:28, Xenia Ragiadakou wrote:
> 
> On 15/9/23 18:11, Akihiko Odaki wrote:
>> On 2023/09/15 20:11, Huang Rui wrote:
>>> From: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
>>>
>>> When the memory region has a different life-cycle from that of her 
>>> parent,
>>> could be automatically released, once has been unparent and once all 
>>> of her
>>> references have gone away, via the object's free callback.
>>>
>>> However, currently, references to the memory region are held by its 
>>> owner
>>> without first incrementing the memory region object's reference count.
>>> As a result, the automatic deallocation of the object, not taking into
>>> account those references, results in use-after-free memory corruption.
>>>
>>> This patch increases the reference count of an owned memory region 
>>> object
>>> on each memory_region_ref() and decreases it on each 
>>> memory_region_unref().
>>>
>>> Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>>> ---
>>>
>>> V4 -> V5:
>>>      - ref/unref only owned memory regions (Akihiko)
>>>
>>>   softmmu/memory.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/softmmu/memory.c b/softmmu/memory.c
>>> index 7d9494ce70..15e1699750 100644
>>> --- a/softmmu/memory.c
>>> +++ b/softmmu/memory.c
>>> @@ -1800,6 +1800,9 @@ void memory_region_ref(MemoryRegion *mr)
>>>       /* MMIO callbacks most likely will access data that belongs
>>>        * to the owner, hence the need to ref/unref the owner whenever
>>>        * the memory region is in use.
>>> +     * Likewise, the owner keeps references to the memory region,
>>> +     * hence the need to ref/unref the memory region object to prevent
>>> +     * its automatic deallocation while still referenced by its owner.
>>
>> This comment does not make sense. Traditionally no such automatic 
>> deallocation happens so the owner has been always required to free the 
>> memory region when it gets finalized.
>>
>> "[QEMU PATCH v5 09/13] virtio-gpu: Handle resource blob commands" 
>> introduces a different kind of memory region, which can be freed 
>> anytime before the device gets finalized. Even in this case, the owner 
>> removes the reference to the memory owner by doing res->region = NULL;
> 
> Hi Akihiko,
> 
> You are right, the word "owner" is not correct. The issue observed was 
> due to the references kept in flatview ranges and the fact that 
> flatview_destroy() is asynchronous and was called after memory region's 
> destruction.
> 
> If I replace the word "owner" with "memory subsystem" in the commit 
> message and drop the comment, would that be ok with you? or do want to 
> suggest something else?

This will extend the lifetime of the memory region, but the underlying 
memory is still synchronously freed. Can you show that the flatview 
range will not be used to read the freed memory?

Regards,
Akihiko Odaki

