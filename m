Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB24771655E
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:57:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40m8-0005C2-Dw; Tue, 30 May 2023 10:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q40m6-0005Be-Bo
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:56:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q40m4-0001av-CC
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685458595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ikhBoEAwseFcLWUcO87KpycNxWpBF1pkGGaNXXxdXeQ=;
 b=AagickM39Ehq7+ymDD/0l4xPmJBzvrnYitBKib86trHcmUEl0Zy7bLX0mpF0bMlHJMgx2G
 uUKnF7avlbySFJr3XzPCRUe+3mP1J5banwsEhxDgUL5mC5lXkAyLF2T3zTBGu16+EeIapB
 Xum8Lf3e9pnRAFn/ieUrsFmo46uPgmg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-aWeatal2PR--faPikIdQZg-1; Tue, 30 May 2023 10:56:33 -0400
X-MC-Unique: aWeatal2PR--faPikIdQZg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-626195b48c8so18157336d6.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 07:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685458593; x=1688050593;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ikhBoEAwseFcLWUcO87KpycNxWpBF1pkGGaNXXxdXeQ=;
 b=HJUgzfosw8SUitLqiUIKIEksTmufbEhSl9fqFb7eDybfRE9WxuyCeKTrFo6t5Cqv5k
 2EFv+6NKamxA5DDhOT9Wahvrq3px+C4qN/T255IhDH89PoOTYEWQteGn40wjaWrq3Qkt
 w4zjfswb32T1tUamnQCgA+7z4ga6fxtPWEsnC/uKszve8ju++3CNVYr1OyONM05S+/hh
 0LQpLRYik3zFOWpuPMtX/bLJ0c+HQjX2wcYF9Uz2ejIF5yodhhOHFiLX+1t6++/AekgQ
 LSLc+QkMHcCzYRz2iYX2EfjBHGN6uajCN4JRYXgx3eQrXOyJc8M1glj9Efzw5dBgpFTr
 q3Pw==
X-Gm-Message-State: AC+VfDxCpf0SzbBcnG/F1uQ6EPyhyOibSzlxAKGeQjFBwoJbm5vT3wHy
 yeRbicRtNPp1DN2b6Uw6syGPo1prEESSvHhSEJopRsgirFtw79j1oDOYj8Otnh448kfGtrPXZwy
 yjb/ucZ1U50jliYyHibmLEoI=
X-Received: by 2002:a05:620a:618d:b0:75b:23a1:8e7b with SMTP id
 or13-20020a05620a618d00b0075b23a18e7bmr2328998qkn.76.1685458593191; 
 Tue, 30 May 2023 07:56:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Nin5/Lf6Ay6vYy28KB6ATC0KwfUR8WK+4WSnVgYitgD9eYUg47Jy24Vq8xQ1b6D8OrxGPtA==
X-Received: by 2002:a05:620a:618d:b0:75b:23a1:8e7b with SMTP id
 or13-20020a05620a618d00b0075b23a18e7bmr2328975qkn.76.1685458592873; 
 Tue, 30 May 2023 07:56:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0?
 ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a05620a100200b0075cc95eb30asm2695814qkj.8.2023.05.30.07.56.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 07:56:32 -0700 (PDT)
Message-ID: <f476c3c7-9336-0e3a-146e-73b80f6f712a@redhat.com>
Date: Tue, 30 May 2023 16:56:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] igb: Add Function Level Reset to PF and VF
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Jason Wang <jasowang@redhat.com>
References: <20230526173035.69055-1-clg@redhat.com>
 <DBBP189MB143330236AFF956285CD74F295459@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
 <e2bed67c-23ea-6364-bd5a-f7b330346302@daynix.com>
 <8fb19b45-0dc3-a3d6-fcf9-5fc8728edf4d@redhat.com>
 <5ab583be-8e7a-5636-d14c-f04ecd670894@daynix.com>
 <d5c359c5-79fa-dffc-101b-08c0f08f7071@redhat.com>
 <5a69feb7-0dcb-6620-536a-e6778f79ccde@daynix.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <5a69feb7-0dcb-6620-536a-e6778f79ccde@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/30/23 04:02, Akihiko Odaki wrote:
> On 2023/05/30 0:07, Cédric Le Goater wrote:
>> On 5/29/23 09:45, Akihiko Odaki wrote:
>>> On 2023/05/29 16:01, Cédric Le Goater wrote:
>>>> On 5/29/23 04:45, Akihiko Odaki wrote:
>>>>> On 2023/05/28 19:50, Sriram Yagnaraman wrote:
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Cédric Le Goater <clg@redhat.com>
>>>>>>> Sent: Friday, 26 May 2023 19:31
>>>>>>> To: qemu-devel@nongnu.org
>>>>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>; Sriram Yagnaraman
>>>>>>> <sriram.yagnaraman@est.tech>; Jason Wang <jasowang@redhat.com>; Cédric
>>>>>>> Le Goater <clg@redhat.com>
>>>>>>> Subject: [PATCH] igb: Add Function Level Reset to PF and VF
>>>>>>>
>>>>>>> The Intel 82576EB GbE Controller say that the Physical and Virtual Functions
>>>>>>> support Function Level Reset. Add the capability to each device model.
>>>>>>>
>>>>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>> Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
>>>>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>>>>> ---
>>>>>>>   hw/net/igb.c   | 3 +++
>>>>>>>   hw/net/igbvf.c | 3 +++
>>>>>>>   2 files changed, 6 insertions(+)
>>>>>>>
>>>>>>> diff --git a/hw/net/igb.c b/hw/net/igb.c index 1c989d767725..08e389338dca
>>>>>>> 100644
>>>>>>> --- a/hw/net/igb.c
>>>>>>> +++ b/hw/net/igb.c
>>>>>>> @@ -101,6 +101,7 @@ static void igb_write_config(PCIDevice *dev, uint32_t
>>>>>>> addr,
>>>>>>>
>>>>>>>       trace_igb_write_config(addr, val, len);
>>>>>>>       pci_default_write_config(dev, addr, val, len);
>>>>>>> +    pcie_cap_flr_write_config(dev, addr, val, len);
>>>>>>>
>>>>>>>       if (range_covers_byte(addr, len, PCI_COMMAND) &&
>>>>>>>           (dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) { @@ -427,6
>>>>>>> +428,8 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
>>>>>>>       }
>>>>>>>
>>>>>>>       /* PCIe extended capabilities (in order) */
>>>>>>> +    pcie_cap_flr_init(pci_dev);
>>>>>>> +
>>>>>>>       if (pcie_aer_init(pci_dev, 1, 0x100, 0x40, errp) < 0) {
>>>>>>>           hw_error("Failed to initialize AER capability");
>>>>>>>       }
>>>>>>> diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c index
>>>>>>> 284ea611848b..0a58dad06802 100644
>>>>>>> --- a/hw/net/igbvf.c
>>>>>>> +++ b/hw/net/igbvf.c
>>>>>>> @@ -204,6 +204,7 @@ static void igbvf_write_config(PCIDevice *dev,
>>>>>>> uint32_t addr, uint32_t val,  {
>>>>>>>       trace_igbvf_write_config(addr, val, len);
>>>>>>>       pci_default_write_config(dev, addr, val, len);
>>>>>>> +    pcie_cap_flr_write_config(dev, addr, val, len);
>>>>>>>   }
>>>>>>>
>>>>>>>   static uint64_t igbvf_mmio_read(void *opaque, hwaddr addr, unsigned size)
>>>>>>> @@ -266,6 +267,8 @@ static void igbvf_pci_realize(PCIDevice *dev, Error
>>>>>>> **errp)
>>>>>>>           hw_error("Failed to initialize PCIe capability");
>>>>>>>       }
>>>>>>>
>>>>>>> +    pcie_cap_flr_init(dev);
>>>>>>
>>>>>> Sorry for my naive question, and perhaps not related to your patch, IGBVF device class doesn't seem to have any reset functions registered via igbvf_class_init(). So, I am guessing an FLR will not trigger igb_vf_reset(), which is probably what we want.
>>>>
>>>> It does through the VTCTRL registers.
>>>>
>>>>> You're right. Advertising FLR capability without implementing it can confuse the guest though such probability is quite a low in practice. The reset should be implemented first.
>>>>
>>>>
>>>> I was looking at an issue from a VFIO perspective which does a FLR
>>>> on a device when pass through. Software and FLR are equivalent for
>>>> a VF.
>>>
>>> They should be equivalent according to the datasheet, but unfortunately current igbvf implementation does nothing when reset. What Sriram proposes is to add code to actually write VTCTRL when FLR occurred and make FLR and software reset equivalent. And I think that should be done before this change; you should advertise FLR capability after the reset is actually implemented.
>>
>>
>> AFAICT, the VFs are reset correctly by the OS when created or probed and
>> by QEMU when they are passthrough in a nested guest OS (with this patch).
>> igb_vf_reset() is clearly called in QEMU, see routine e1000_reset_hw_vf()
>> in Linux.
> 
> I don't think this patch makes difference for e1000_reset_hw_vf() as it does not rely on FLR.
> 
>>
>> I don't think a reset op is necessary because VFs are software constructs
>> but I don't mind really. If so, then, I wouldn't mimic what the OS does
>> by writing the RST bit in the CTRL register of the VF, I would simply
>> install igb_vf_reset() as a reset handler.
> 
> Thinking about the reason why VFIO performs FLR, probably VFIO expects the FLR clears all of states the kernel set to prevent the VF from leaking kernel addresses or addresses of other user space which the VF was assigned to in the past, for example.

yes and if the FLR cap is not present, VFIO tries to do a custom bus reset
which fails in an ugly way since the PF can not be reset.

Thanks

C.


> 
> Implementing the reset operation is not necessary to make it function but to make it secure, particularly we promise the guest that we clear the VF state by advertising FLR.
> 
> Regards,
> Akihiko Odaki
> 
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>>
>>> Regards,
>>> Akihiko Odaki
>>>
>>>>
>>>> I am not sure a VF needs more really, since it is all controlled
>>>> by the PF. >
>>>> C.
>>>>
>>>>>
>>>>>>
>>>>>>> +
>>>>>>>       if (pcie_aer_init(dev, 1, 0x100, 0x40, errp) < 0) {
>>>>>>>           hw_error("Failed to initialize AER capability");
>>>>>>>       }
>>>>>>> -- 
>>>>>>> 2.40.1
>>>>>>
>>>>>
>>>>
>>>
>>
> 


