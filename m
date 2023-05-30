Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D03E715360
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 04:04:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ogq-0002sz-TU; Mon, 29 May 2023 22:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q3ogn-0002sW-CR
 for qemu-devel@nongnu.org; Mon, 29 May 2023 22:02:22 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q3ogl-0004cV-Df
 for qemu-devel@nongnu.org; Mon, 29 May 2023 22:02:21 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5343c3daff0so2425634a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 19:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1685412138; x=1688004138;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FOEZEL42QoC30coAhKp1zkmMk0GhXymsmav6zWfQuG0=;
 b=LBrYHpnW2a5EON5WJl9IkqyxxYD9/RA3DT1jAwuoNTd1T0VIxXvjxsaqQPjLcXcS0i
 qI0XOOtY/TMYDpcGSg9iDZn8MkkimLJ6OzsvwIN+O0DMCBI/CSedtrr0yV7A3DcCdt8G
 0DXuU7piBKcr0XU9uF6tNd4Hzg/ysjIxoScX4KXCtHlPhVIFQY9zR6dRkdB8acTqhtXq
 rHtVtcfD/n5yuPnCzsc3a8sLrEs05ks7xkAFkZh3aZ8unmFZJTwrov9VqGDlvObkSRXb
 WvLgeIi0I8gu2wdT42R94x8EoKaRieqBr4QnpMxwca19DKCTYX3n4SiSiT0fztSfwKN2
 reTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685412138; x=1688004138;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FOEZEL42QoC30coAhKp1zkmMk0GhXymsmav6zWfQuG0=;
 b=bXH5SGc+Bbev+NmN871A4YOVKnLWlfwrYkY4Gh4mWyCHsaT+8bRSlOnDXt2OuOihPS
 Rrf8ob9TsrS0+oQJ+rzm/YpIkJQ7VcEcaZUOZPhx9rhrrcnoHupWmrs7oeofUCLe5LAN
 WJSM7AjoWVXnPory9ymDRb35fFabOGqkmapoL1z+tzFjbo03O+7Nqg7nmf03uvY0Hr3b
 qs3JeF1tNM1/CrkpnCjmQFOsbu+l51pIz7jFa9kPsrH2UHfjkOoXf5i6Sh5eNtrlBhFZ
 gD4PMXvm+Cm+tYzfte+MzkQiK8EADMvzMV+up5JCHxEshhkt6ekBpXS68zAaQ+QuKaBH
 Rhew==
X-Gm-Message-State: AC+VfDzhCUSwQ61WpzgCfORBN8vI5YzohvaGA50gbCU5i1j0qGI+lB0p
 zotssvMlzIcC9bLUrdPdoDy/aA==
X-Google-Smtp-Source: ACHHUZ7sJnd5l+xyDssgwnZhzsetLbHDYJsRUZhW9Inq0dasXtSmjBHzkAYJyJlHaeLKfe/vjuDAng==
X-Received: by 2002:a17:902:c78c:b0:1b0:4baa:ba92 with SMTP id
 w12-20020a170902c78c00b001b04baaba92mr868628pla.1.1685412137823; 
 Mon, 29 May 2023 19:02:17 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 jf11-20020a170903268b00b001b03f89daffsm3145369plb.110.2023.05.29.19.02.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 May 2023 19:02:17 -0700 (PDT)
Message-ID: <5a69feb7-0dcb-6620-536a-e6778f79ccde@daynix.com>
Date: Tue, 30 May 2023 11:02:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] igb: Add Function Level Reset to PF and VF
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Jason Wang <jasowang@redhat.com>
References: <20230526173035.69055-1-clg@redhat.com>
 <DBBP189MB143330236AFF956285CD74F295459@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
 <e2bed67c-23ea-6364-bd5a-f7b330346302@daynix.com>
 <8fb19b45-0dc3-a3d6-fcf9-5fc8728edf4d@redhat.com>
 <5ab583be-8e7a-5636-d14c-f04ecd670894@daynix.com>
 <d5c359c5-79fa-dffc-101b-08c0f08f7071@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <d5c359c5-79fa-dffc-101b-08c0f08f7071@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::534;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/05/30 0:07, Cédric Le Goater wrote:
> On 5/29/23 09:45, Akihiko Odaki wrote:
>> On 2023/05/29 16:01, Cédric Le Goater wrote:
>>> On 5/29/23 04:45, Akihiko Odaki wrote:
>>>> On 2023/05/28 19:50, Sriram Yagnaraman wrote:
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Cédric Le Goater <clg@redhat.com>
>>>>>> Sent: Friday, 26 May 2023 19:31
>>>>>> To: qemu-devel@nongnu.org
>>>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>; Sriram Yagnaraman
>>>>>> <sriram.yagnaraman@est.tech>; Jason Wang <jasowang@redhat.com>; 
>>>>>> Cédric
>>>>>> Le Goater <clg@redhat.com>
>>>>>> Subject: [PATCH] igb: Add Function Level Reset to PF and VF
>>>>>>
>>>>>> The Intel 82576EB GbE Controller say that the Physical and Virtual 
>>>>>> Functions
>>>>>> support Function Level Reset. Add the capability to each device 
>>>>>> model.
>>>>>>
>>>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>> Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
>>>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>>>> ---
>>>>>>   hw/net/igb.c   | 3 +++
>>>>>>   hw/net/igbvf.c | 3 +++
>>>>>>   2 files changed, 6 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/net/igb.c b/hw/net/igb.c index 
>>>>>> 1c989d767725..08e389338dca
>>>>>> 100644
>>>>>> --- a/hw/net/igb.c
>>>>>> +++ b/hw/net/igb.c
>>>>>> @@ -101,6 +101,7 @@ static void igb_write_config(PCIDevice *dev, 
>>>>>> uint32_t
>>>>>> addr,
>>>>>>
>>>>>>       trace_igb_write_config(addr, val, len);
>>>>>>       pci_default_write_config(dev, addr, val, len);
>>>>>> +    pcie_cap_flr_write_config(dev, addr, val, len);
>>>>>>
>>>>>>       if (range_covers_byte(addr, len, PCI_COMMAND) &&
>>>>>>           (dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) { @@ 
>>>>>> -427,6
>>>>>> +428,8 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error 
>>>>>> **errp)
>>>>>>       }
>>>>>>
>>>>>>       /* PCIe extended capabilities (in order) */
>>>>>> +    pcie_cap_flr_init(pci_dev);
>>>>>> +
>>>>>>       if (pcie_aer_init(pci_dev, 1, 0x100, 0x40, errp) < 0) {
>>>>>>           hw_error("Failed to initialize AER capability");
>>>>>>       }
>>>>>> diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c index
>>>>>> 284ea611848b..0a58dad06802 100644
>>>>>> --- a/hw/net/igbvf.c
>>>>>> +++ b/hw/net/igbvf.c
>>>>>> @@ -204,6 +204,7 @@ static void igbvf_write_config(PCIDevice *dev,
>>>>>> uint32_t addr, uint32_t val,  {
>>>>>>       trace_igbvf_write_config(addr, val, len);
>>>>>>       pci_default_write_config(dev, addr, val, len);
>>>>>> +    pcie_cap_flr_write_config(dev, addr, val, len);
>>>>>>   }
>>>>>>
>>>>>>   static uint64_t igbvf_mmio_read(void *opaque, hwaddr addr, 
>>>>>> unsigned size)
>>>>>> @@ -266,6 +267,8 @@ static void igbvf_pci_realize(PCIDevice *dev, 
>>>>>> Error
>>>>>> **errp)
>>>>>>           hw_error("Failed to initialize PCIe capability");
>>>>>>       }
>>>>>>
>>>>>> +    pcie_cap_flr_init(dev);
>>>>>
>>>>> Sorry for my naive question, and perhaps not related to your patch, 
>>>>> IGBVF device class doesn't seem to have any reset functions 
>>>>> registered via igbvf_class_init(). So, I am guessing an FLR will 
>>>>> not trigger igb_vf_reset(), which is probably what we want.
>>>
>>> It does through the VTCTRL registers.
>>>
>>>> You're right. Advertising FLR capability without implementing it can 
>>>> confuse the guest though such probability is quite a low in 
>>>> practice. The reset should be implemented first.
>>>
>>>
>>> I was looking at an issue from a VFIO perspective which does a FLR
>>> on a device when pass through. Software and FLR are equivalent for
>>> a VF.
>>
>> They should be equivalent according to the datasheet, but 
>> unfortunately current igbvf implementation does nothing when reset. 
>> What Sriram proposes is to add code to actually write VTCTRL when FLR 
>> occurred and make FLR and software reset equivalent. And I think that 
>> should be done before this change; you should advertise FLR capability 
>> after the reset is actually implemented.
> 
> 
> AFAICT, the VFs are reset correctly by the OS when created or probed and
> by QEMU when they are passthrough in a nested guest OS (with this patch).
> igb_vf_reset() is clearly called in QEMU, see routine e1000_reset_hw_vf()
> in Linux.

I don't think this patch makes difference for e1000_reset_hw_vf() as it 
does not rely on FLR.

> 
> I don't think a reset op is necessary because VFs are software constructs
> but I don't mind really. If so, then, I wouldn't mimic what the OS does
> by writing the RST bit in the CTRL register of the VF, I would simply
> install igb_vf_reset() as a reset handler.

Thinking about the reason why VFIO performs FLR, probably VFIO expects 
the FLR clears all of states the kernel set to prevent the VF from 
leaking kernel addresses or addresses of other user space which the VF 
was assigned to in the past, for example.

Implementing the reset operation is not necessary to make it function 
but to make it secure, particularly we promise the guest that we clear 
the VF state by advertising FLR.

Regards,
Akihiko Odaki

> 
> Thanks,
> 
> C.
> 
> 
> 
>>
>> Regards,
>> Akihiko Odaki
>>
>>>
>>> I am not sure a VF needs more really, since it is all controlled
>>> by the PF. >
>>> C.
>>>
>>>>
>>>>>
>>>>>> +
>>>>>>       if (pcie_aer_init(dev, 1, 0x100, 0x40, errp) < 0) {
>>>>>>           hw_error("Failed to initialize AER capability");
>>>>>>       }
>>>>>> -- 
>>>>>> 2.40.1
>>>>>
>>>>
>>>
>>
> 

