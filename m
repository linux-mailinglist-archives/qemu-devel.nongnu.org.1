Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E31AD714CB2
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 17:08:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3eTj-0002XQ-Mw; Mon, 29 May 2023 11:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3eTN-0002QP-I4
 for qemu-devel@nongnu.org; Mon, 29 May 2023 11:08:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3eTJ-0001Eg-HX
 for qemu-devel@nongnu.org; Mon, 29 May 2023 11:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685372864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W0SSoXJfHc3zCajscmFmonAtVa7bHg5OAFGHQGK/ozg=;
 b=E3t0qBt0D6B3ZI0QxJWZWeRKgs29cQ45qR42CmaQwxXKQJ6R0l9533jB1CYz811aVBx15V
 FZ/nrtexne6w53FELrj+yCNm8ozser8Un0VeaOp9xc7VygXPPKisuGuYnTGWKHIVXIeiiX
 29s7IYRjIuWZ2iFukrhcYhJjThnXDLc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-J7X8gCVUPRmaMC99i2Jpbg-1; Mon, 29 May 2023 11:07:43 -0400
X-MC-Unique: J7X8gCVUPRmaMC99i2Jpbg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6260cd5068cso15584266d6.2
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 08:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685372862; x=1687964862;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W0SSoXJfHc3zCajscmFmonAtVa7bHg5OAFGHQGK/ozg=;
 b=FXozGL/kx2pGx3alhxVQ49sEqMwThtcgpEYk2XSUW9SQXWwBJIbohYqKD9paswl2Ps
 RD71rEWrjToNHmsYfn3UEMG1tmbO+rR1JvH9M6F/Xx8uxKDTJ09iltMtbh7RA/k0MKXG
 hRM0DsC1r/cp3fWWYENhRO9dw7jkSG5ED3JmKiR83Xc+1factXu4r7L3NOg3UtEEQKa6
 Da9J0XFJ8g2igOr5QEVtxjs956ECjQkoA6wqyP1se/L+TgJSk3+kHPU4woTxr7wX3mxC
 x+wIczj2XcHOES003gWaGyvxI3Uz/qZ4cPrhng+CvI47M1qJ/GcQI5+qsVLGE2IuDCjn
 MvVA==
X-Gm-Message-State: AC+VfDzxIECA+kfv7o8QBKzaca7EylxzV4c8REspqaGgLDflRf4hwHxW
 XVw4qLRnKZhARb0kwh83JPC7T0bYMssaJTHTH/sQ94WfMkJrG+jOQ5RjbaDpRexUu/1d3SyuB9A
 I5J0vL+hqipltsoc=
X-Received: by 2002:a05:6214:529c:b0:5ef:6839:9775 with SMTP id
 kj28-20020a056214529c00b005ef68399775mr10797760qvb.49.1685372862536; 
 Mon, 29 May 2023 08:07:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FgtXMSaAVzmIJl0mpGu+8ll/aCLIdktMTV2NZEBZEbegRyK5dCxbAgvN6xoWVlDuNqYvjKQ==
X-Received: by 2002:a05:6214:529c:b0:5ef:6839:9775 with SMTP id
 kj28-20020a056214529c00b005ef68399775mr10797727qvb.49.1685372862302; 
 Mon, 29 May 2023 08:07:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0?
 ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a05621415c200b0061b58b07130sm564308qvz.137.2023.05.29.08.07.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 May 2023 08:07:41 -0700 (PDT)
Message-ID: <d5c359c5-79fa-dffc-101b-08c0f08f7071@redhat.com>
Date: Mon, 29 May 2023 17:07:39 +0200
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
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <5ab583be-8e7a-5636-d14c-f04ecd670894@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/29/23 09:45, Akihiko Odaki wrote:
> On 2023/05/29 16:01, Cédric Le Goater wrote:
>> On 5/29/23 04:45, Akihiko Odaki wrote:
>>> On 2023/05/28 19:50, Sriram Yagnaraman wrote:
>>>>
>>>>> -----Original Message-----
>>>>> From: Cédric Le Goater <clg@redhat.com>
>>>>> Sent: Friday, 26 May 2023 19:31
>>>>> To: qemu-devel@nongnu.org
>>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>; Sriram Yagnaraman
>>>>> <sriram.yagnaraman@est.tech>; Jason Wang <jasowang@redhat.com>; Cédric
>>>>> Le Goater <clg@redhat.com>
>>>>> Subject: [PATCH] igb: Add Function Level Reset to PF and VF
>>>>>
>>>>> The Intel 82576EB GbE Controller say that the Physical and Virtual Functions
>>>>> support Function Level Reset. Add the capability to each device model.
>>>>>
>>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>> Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
>>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>>> ---
>>>>>   hw/net/igb.c   | 3 +++
>>>>>   hw/net/igbvf.c | 3 +++
>>>>>   2 files changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/hw/net/igb.c b/hw/net/igb.c index 1c989d767725..08e389338dca
>>>>> 100644
>>>>> --- a/hw/net/igb.c
>>>>> +++ b/hw/net/igb.c
>>>>> @@ -101,6 +101,7 @@ static void igb_write_config(PCIDevice *dev, uint32_t
>>>>> addr,
>>>>>
>>>>>       trace_igb_write_config(addr, val, len);
>>>>>       pci_default_write_config(dev, addr, val, len);
>>>>> +    pcie_cap_flr_write_config(dev, addr, val, len);
>>>>>
>>>>>       if (range_covers_byte(addr, len, PCI_COMMAND) &&
>>>>>           (dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) { @@ -427,6
>>>>> +428,8 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
>>>>>       }
>>>>>
>>>>>       /* PCIe extended capabilities (in order) */
>>>>> +    pcie_cap_flr_init(pci_dev);
>>>>> +
>>>>>       if (pcie_aer_init(pci_dev, 1, 0x100, 0x40, errp) < 0) {
>>>>>           hw_error("Failed to initialize AER capability");
>>>>>       }
>>>>> diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c index
>>>>> 284ea611848b..0a58dad06802 100644
>>>>> --- a/hw/net/igbvf.c
>>>>> +++ b/hw/net/igbvf.c
>>>>> @@ -204,6 +204,7 @@ static void igbvf_write_config(PCIDevice *dev,
>>>>> uint32_t addr, uint32_t val,  {
>>>>>       trace_igbvf_write_config(addr, val, len);
>>>>>       pci_default_write_config(dev, addr, val, len);
>>>>> +    pcie_cap_flr_write_config(dev, addr, val, len);
>>>>>   }
>>>>>
>>>>>   static uint64_t igbvf_mmio_read(void *opaque, hwaddr addr, unsigned size)
>>>>> @@ -266,6 +267,8 @@ static void igbvf_pci_realize(PCIDevice *dev, Error
>>>>> **errp)
>>>>>           hw_error("Failed to initialize PCIe capability");
>>>>>       }
>>>>>
>>>>> +    pcie_cap_flr_init(dev);
>>>>
>>>> Sorry for my naive question, and perhaps not related to your patch, IGBVF device class doesn't seem to have any reset functions registered via igbvf_class_init(). So, I am guessing an FLR will not trigger igb_vf_reset(), which is probably what we want.
>>
>> It does through the VTCTRL registers.
>>
>>> You're right. Advertising FLR capability without implementing it can confuse the guest though such probability is quite a low in practice. The reset should be implemented first.
>>
>>
>> I was looking at an issue from a VFIO perspective which does a FLR
>> on a device when pass through. Software and FLR are equivalent for
>> a VF.
> 
> They should be equivalent according to the datasheet, but unfortunately current igbvf implementation does nothing when reset. What Sriram proposes is to add code to actually write VTCTRL when FLR occurred and make FLR and software reset equivalent. 
> And I think that should be done before this change; you should advertise FLR capability after the reset is actually implemented.


AFAICT, the VFs are reset correctly by the OS when created or probed and
by QEMU when they are passthrough in a nested guest OS (with this patch).
igb_vf_reset() is clearly called in QEMU, see routine e1000_reset_hw_vf()
in Linux.

I don't think a reset op is necessary because VFs are software constructs
but I don't mind really. If so, then, I wouldn't mimic what the OS does
by writing the RST bit in the CTRL register of the VF, I would simply
install igb_vf_reset() as a reset handler.

Thanks,

C.



> 
> Regards,
> Akihiko Odaki
> 
>>
>> I am not sure a VF needs more really, since it is all controlled
>> by the PF. >
>> C.
>>
>>>
>>>>
>>>>> +
>>>>>       if (pcie_aer_init(dev, 1, 0x100, 0x40, errp) < 0) {
>>>>>           hw_error("Failed to initialize AER capability");
>>>>>       }
>>>>> -- 
>>>>> 2.40.1
>>>>
>>>
>>
> 


