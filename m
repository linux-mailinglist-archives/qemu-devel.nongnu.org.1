Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C66FBA87A5
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Sep 2025 10:57:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v39ev-0000hn-Lm; Mon, 29 Sep 2025 04:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v39ek-0000bF-AC
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 04:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v39eS-0001Yo-Ec
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 04:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759136067;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FvuMMIh36T7bEzJy9lL6n0zyQNEqJT4rXRP+Yb82gMw=;
 b=g02Ow3azlkZaeayLeX+aJpQit1bjmy/Ek6uzUQf3Yn08VEyZmnPsD0bQeYV80N3p4qMxX+
 lIeZ/IlYj/Y8nq/YwFVXQunQ9V2gzAocTPtQYvH0Nd7x0EzsxYd9ZbeaoQAdAmQZLDF9Tn
 r7/qwhdBYSrGIwDTHak05p/cqxtKM1Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-t_pOdSqSMseihSOaRKyEPg-1; Mon, 29 Sep 2025 04:54:25 -0400
X-MC-Unique: t_pOdSqSMseihSOaRKyEPg-1
X-Mimecast-MFC-AGG-ID: t_pOdSqSMseihSOaRKyEPg_1759136064
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3f7b5c27d41so2290546f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 01:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759136064; x=1759740864;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FvuMMIh36T7bEzJy9lL6n0zyQNEqJT4rXRP+Yb82gMw=;
 b=aSQ5aLeQmxxS+DUo7YGn0qG16qnzlhSgzrB1+S2mcY04/0RA+y3sP58hnXFmvJBErr
 U/Wh6hMrUi8LwDf15By8g0vBTcAkVpvJ2leLDjs1D6Nf3T9FsiSeU/PBr6cAhHZYKBi7
 xZEk6VgtYP825sTv1fLrw/+z5USVqhdwZjly2ca3aLPOuakdpAayFmdC/mTezFhfjTIA
 7iuO61RFkYa7APf4OBH/AANi1XWiLyEetNvREoUijn5e0b6UmyG2ooTcc8QrMsW3uwG1
 VbygRyWz/0gA8fI5Ewe44R4S6AGLwLvZu3qrWJuN39aIpZEidXMGGuv2mwfzWKuYpMnR
 Jn9g==
X-Gm-Message-State: AOJu0YzVPyV4t1crnQBVIDIoRrnJHM91C5IPErw1w4ZkiyNchZhQzhmz
 hQ1kpFuSZSWhQRfNoNs/pCl7kfMsvUbkWiPxZsV6Fy3jv+bzqmnchJChTYtOv3LliZk1m+qB3mn
 U6aPL/fNQnh1K1OJjBE4hPlsBZlU3gdaT2qxAPzRzJNSxjumCNSWKy8zd2zSTeTQM
X-Gm-Gg: ASbGncvTSUJISGOmnYFftqVUjc+3coliAukfYtFBOGQLAQfxjHNLNOSwub6xwRESs+D
 0h4Ljer0P90Qj1Dsicyymg9V66xZykH+vREagMw9zWdXfP4AIGINmfwhv1YLN0BDBYjkNV10qLl
 5Lbd+YwntQwswCgncKYSl2GtFIhsbG1rKNQ/KeLCPMRoyDyBNjqxWTGJMbB0U8qsMg10LijCgy+
 0i6CD5r/oNBIWBum9k8v9ZZCWe9wWcJvhWOW5cwhIMlwctTISZr0+0FJ+xQb43leoUppRrACvax
 tvmXzJEkVX9mwYLGtQJpyNUt9S0aQnwRtrDH1ztX2HCFJhke+wk7LhJF028jKqUoub5tawaXaff
 7Rf5QdydjNi4=
X-Received: by 2002:a05:6000:40c8:b0:3ec:db88:bf1 with SMTP id
 ffacd0b85a97d-418005f50dfmr6507931f8f.12.1759136063792; 
 Mon, 29 Sep 2025 01:54:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAGRvZYpbjm87rfeEdUBoudfHp6cVVWo00yxaK8XmEUz+ARXg+T2j7VJ/6/1Zs7yL5MH5pxg==
X-Received: by 2002:a05:6000:40c8:b0:3ec:db88:bf1 with SMTP id
 ffacd0b85a97d-418005f50dfmr6507904f8f.12.1759136063293; 
 Mon, 29 Sep 2025 01:54:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f77956sm3853495e9.20.2025.09.29.01.54.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 01:54:22 -0700 (PDT)
Message-ID: <aaee9930-69c5-4ed1-8bc0-7ad20e084440@redhat.com>
Date: Mon, 29 Sep 2025 10:54:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] hw/arm/smmuv3: Add separate address space for
 secure SMMU accesses
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250925162618.191242-7-tangtao1634@phytium.com.cn>
 <9ea1fc2a-8280-4a31-92b9-4870bf2bf940@redhat.com>
 <fcf54e8a-d4c6-49ea-b31a-35e2f5df1222@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <fcf54e8a-d4c6-49ea-b31a-35e2f5df1222@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.539,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 9/29/25 10:33 AM, Tao Tang wrote:
> Hi Eric,
>
> On 2025/9/29 15:44, Eric Auger wrote:
>> Hi Tao,
>>
>> On 9/25/25 6:26 PM, Tao Tang wrote:
>>> According to the Arm architecture, SMMU-originated memory accesses,
>>> such as fetching commands or writing events for a secure stream, must
>>> target the Secure Physical Address (PA) space. The existing model sends
>>> all DMA to the global address_space_memory.
>>>
>>> This patch introduces the infrastructure to differentiate between
>>> secure
>>> and non-secure memory accesses. A weak global symbol,
>>> arm_secure_address_space, is added, which can be provided by the
>>> machine model to represent the Secure PA space.
>>>
>>> A new helper, smmu_get_address_space(), selects the target address
>>> space based on the is_secure context. All internal DMA calls
>>> (dma_memory_read/write) are updated to use this helper. Additionally,
>>> the attrs.secure bit is set on transactions targeting the secure
>>> address space.
>> The last sentence does not seem to be implemented in that patch?
>
>
> You are right to point this out, and my apologies for the confusion.
> As I was preparing the series, the patches were intertwined, and I
> didn't manage their boundaries clearly. This led me to mistakenly
> describe a feature in this commit message that is only implemented in
> a subsequent patch #07.
>
> I'm very sorry for the confusion and the unnecessary time this has
> cost you. In all future community interactions, I will pay special
> attention to ensuring each patch and its description are atomic and
> self-contained to reduce the review burden for everyone. Thank you for
> your guidance on this.

No problem. Your commit messages are pretty well written and we all do
such kind of oversights - at least I do ;-) -

Eric
>
>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>> ---
>>>   hw/arm/smmu-common.c         |  8 ++++++++
>>>   hw/arm/virt.c                |  5 +++++
>>>   include/hw/arm/smmu-common.h | 20 ++++++++++++++++++++
>>>   3 files changed, 33 insertions(+)
>>>
>>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>>> index 62a7612184..24db448683 100644
>>> --- a/hw/arm/smmu-common.c
>>> +++ b/hw/arm/smmu-common.c
>>> @@ -30,6 +30,14 @@
>>>   #include "hw/arm/smmu-common.h"
>>>   #include "smmu-internal.h"
>>>   +/* Global state for secure address space availability */
>>> +bool arm_secure_as_available;
>>> +
>>> +void smmu_enable_secure_address_space(void)
>>> +{
>>> +    arm_secure_as_available = true;
>>> +}
>>> +
>>>   /* IOTLB Management */
>>>     static guint smmu_iotlb_key_hash(gconstpointer v)
>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>> index 02209fadcf..805d9aadb7 100644
>>> --- a/hw/arm/virt.c
>>> +++ b/hw/arm/virt.c
>>> @@ -92,6 +92,8 @@
>>>   #include "hw/cxl/cxl_host.h"
>>>   #include "qemu/guest-random.h"
>>>   +AddressSpace arm_secure_address_space;
>>> +
>>>   static GlobalProperty arm_virt_compat[] = {
>>>       { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
>>>   };
>>> @@ -2243,6 +2245,9 @@ static void machvirt_init(MachineState *machine)
>>>           memory_region_init(secure_sysmem, OBJECT(machine),
>>> "secure-memory",
>>>                              UINT64_MAX);
>>>           memory_region_add_subregion_overlap(secure_sysmem, 0,
>>> sysmem, -1);
>>> +        address_space_init(&arm_secure_address_space, secure_sysmem,
>>> +                           "secure-memory-space");
>>> +        smmu_enable_secure_address_space();
>>>       }
>>>         firmware_loaded = virt_firmware_init(vms, sysmem,
>>> diff --git a/include/hw/arm/smmu-common.h
>>> b/include/hw/arm/smmu-common.h
>>> index 3df82b83eb..cd61c5e126 100644
>>> --- a/include/hw/arm/smmu-common.h
>>> +++ b/include/hw/arm/smmu-common.h
>>> @@ -53,6 +53,26 @@ typedef enum SMMUSecurityIndex {
>>>       SMMU_SEC_IDX_NUM,
>>>   } SMMUSecurityIndex;
>>>   +extern AddressSpace __attribute__((weak)) arm_secure_address_space;
>>> +extern bool arm_secure_as_available;
>>> +void smmu_enable_secure_address_space(void);
>>> +
>>> +static inline AddressSpace
>>> *smmu_get_address_space(SMMUSecurityIndex sec_sid)
>>> +{
>>> +    switch (sec_sid) {
>>> +    case SMMU_SEC_IDX_S:
>>> +    {
>>> +        if (arm_secure_as_available) {
>>> +            return &arm_secure_address_space;
>>> +        }
>> don't you want to return NULL or at least emit an error in case
>> !arm_secure_as_available. When adding Realm support this will avoid to
>> return NS AS.
>
>
> That's a great point. Silently falling back to the non-secure address
> space is indeed dangerous. I will update the logic to return NULL and
> emit an error if the secure address space is requested but not available.
>
>>> +    }
>>> +    QEMU_FALLTHROUGH;
>>> +    case SMMU_SEC_IDX_NS:
>>> +    default:
>> Maybe return an error here in case of other value than NS
>
> Also I will change the default case to handle unexpected values by
> returning NULL, which will make the code safer for future extensions
> like Realm.  Then a check for the NULL return value at the call sites
> of smmu_get_address_space will be applied to handle the error
> appropriately in v3 series.
>
>
> Thanks again for your helpful feedback.
>
>
> Best,
>
> Tao
>
>
>>> +        return &address_space_memory;
>>> +    }
>>> +}
>>> +
>>>   /*
>>>    * Page table walk error types
>>>    */
>> Thanks
>>
>> Eric
>


