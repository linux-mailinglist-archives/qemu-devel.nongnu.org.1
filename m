Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 241387145BA
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 09:47:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3XZo-00026k-Gu; Mon, 29 May 2023 03:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q3XZQ-00026b-3w
 for qemu-devel@nongnu.org; Mon, 29 May 2023 03:45:36 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q3XZO-0004Mf-6V
 for qemu-devel@nongnu.org; Mon, 29 May 2023 03:45:35 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b011cffef2so26733045ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 00:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1685346333; x=1687938333;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fYO2NIF47+lf5ysspbUCys6n4eRuCHhRDyf1O89qDwk=;
 b=n+Dong42eC0RgW5BPIqw93aAOyV2pn5T4M9YcfhI1VLIGaf4+CTEaQeMQ5tgALxO2I
 jidfs1LVnazQpYG+KhJjPoBFm6DWHpIJMjuOIR+ett2YJmXt+jplroLVbIfLeVOBQ29Z
 fZnOAL+ABbTiPawDS9wRvX13q+BBlum6yZN4dqpud6mV9rDHSo8121KyNVK1sQPppqlj
 LarX7SPTYd0TUWAhAS5PEfmPpdhZS9hWrdIy3kyMuJ5Q/kjn/X97GehO3A6pTq3ndtj/
 C47un9kXdhEBO3+RKrCGOTGN8Ro3+MswF9QSpDe7Qvl0GAK+2EfqlBTaFHjwzJ9Dp/zg
 azig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685346333; x=1687938333;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fYO2NIF47+lf5ysspbUCys6n4eRuCHhRDyf1O89qDwk=;
 b=bJ8noGsIO5KbVUxbpNxQFATatDWVEEpzzRIl4sWveczZxBX7I9vaFvOK7EEfJOK6mm
 8wesk/OS/Qq+p56HJHq/3t8e7bHAE+cRMn/WupV0HNOcigPMe1flwUUX+a1Qdxi4PSi5
 d9Pp1aSnQtGeZnsLP4HxvqwQS/SgX6YwCPLQTBkhAMW0DarHuDSvF/D4+gl05FZWChOp
 zTY2tvaMlmaUgbFo0C8Vepo1WJRU8hnUuKAdJAzv+6bJvBOa8Ci/O0zzNjvAol7xVzCx
 MIc1fRJisKZejxoI7EN4w27MxniVS29oBpTjNQ29zvI9PtXtoxwyfyx00HsG0hvG9cvG
 P/5Q==
X-Gm-Message-State: AC+VfDx5djT6ffcG9OfSuDs7kqo3p8bIgQ6yHTzixAIiL5voxb/4yEn5
 nZwrR9JWWvb9FxhuhH3pjrVtJQ==
X-Google-Smtp-Source: ACHHUZ4XVwvX31GzybbKWUYpVBe8m53/M6RiCdm4IyxEI+OjvYqD+Wd1hDhnoAX/VuT4bkVBVUa/dA==
X-Received: by 2002:a17:902:da90:b0:1ae:5f7e:c117 with SMTP id
 j16-20020a170902da9000b001ae5f7ec117mr13199655plx.60.1685346332816; 
 Mon, 29 May 2023 00:45:32 -0700 (PDT)
Received: from [157.82.203.253] ([157.82.203.253])
 by smtp.gmail.com with ESMTPSA id
 jh6-20020a170903328600b001ae0152d280sm1406954plb.193.2023.05.29.00.45.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 May 2023 00:45:32 -0700 (PDT)
Message-ID: <5ab583be-8e7a-5636-d14c-f04ecd670894@daynix.com>
Date: Mon, 29 May 2023 16:45:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] igb: Add Function Level Reset to PF and VF
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Jason Wang <jasowang@redhat.com>
References: <20230526173035.69055-1-clg@redhat.com>
 <DBBP189MB143330236AFF956285CD74F295459@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
 <e2bed67c-23ea-6364-bd5a-f7b330346302@daynix.com>
 <8fb19b45-0dc3-a3d6-fcf9-5fc8728edf4d@redhat.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <8fb19b45-0dc3-a3d6-fcf9-5fc8728edf4d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 2023/05/29 16:01, Cédric Le Goater wrote:
> On 5/29/23 04:45, Akihiko Odaki wrote:
>> On 2023/05/28 19:50, Sriram Yagnaraman wrote:
>>>
>>>> -----Original Message-----
>>>> From: Cédric Le Goater <clg@redhat.com>
>>>> Sent: Friday, 26 May 2023 19:31
>>>> To: qemu-devel@nongnu.org
>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>; Sriram Yagnaraman
>>>> <sriram.yagnaraman@est.tech>; Jason Wang <jasowang@redhat.com>; Cédric
>>>> Le Goater <clg@redhat.com>
>>>> Subject: [PATCH] igb: Add Function Level Reset to PF and VF
>>>>
>>>> The Intel 82576EB GbE Controller say that the Physical and Virtual 
>>>> Functions
>>>> support Function Level Reset. Add the capability to each device model.
>>>>
>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>> ---
>>>>   hw/net/igb.c   | 3 +++
>>>>   hw/net/igbvf.c | 3 +++
>>>>   2 files changed, 6 insertions(+)
>>>>
>>>> diff --git a/hw/net/igb.c b/hw/net/igb.c index 
>>>> 1c989d767725..08e389338dca
>>>> 100644
>>>> --- a/hw/net/igb.c
>>>> +++ b/hw/net/igb.c
>>>> @@ -101,6 +101,7 @@ static void igb_write_config(PCIDevice *dev, 
>>>> uint32_t
>>>> addr,
>>>>
>>>>       trace_igb_write_config(addr, val, len);
>>>>       pci_default_write_config(dev, addr, val, len);
>>>> +    pcie_cap_flr_write_config(dev, addr, val, len);
>>>>
>>>>       if (range_covers_byte(addr, len, PCI_COMMAND) &&
>>>>           (dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) { @@ -427,6
>>>> +428,8 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
>>>>       }
>>>>
>>>>       /* PCIe extended capabilities (in order) */
>>>> +    pcie_cap_flr_init(pci_dev);
>>>> +
>>>>       if (pcie_aer_init(pci_dev, 1, 0x100, 0x40, errp) < 0) {
>>>>           hw_error("Failed to initialize AER capability");
>>>>       }
>>>> diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c index
>>>> 284ea611848b..0a58dad06802 100644
>>>> --- a/hw/net/igbvf.c
>>>> +++ b/hw/net/igbvf.c
>>>> @@ -204,6 +204,7 @@ static void igbvf_write_config(PCIDevice *dev,
>>>> uint32_t addr, uint32_t val,  {
>>>>       trace_igbvf_write_config(addr, val, len);
>>>>       pci_default_write_config(dev, addr, val, len);
>>>> +    pcie_cap_flr_write_config(dev, addr, val, len);
>>>>   }
>>>>
>>>>   static uint64_t igbvf_mmio_read(void *opaque, hwaddr addr, 
>>>> unsigned size)
>>>> @@ -266,6 +267,8 @@ static void igbvf_pci_realize(PCIDevice *dev, Error
>>>> **errp)
>>>>           hw_error("Failed to initialize PCIe capability");
>>>>       }
>>>>
>>>> +    pcie_cap_flr_init(dev);
>>>
>>> Sorry for my naive question, and perhaps not related to your patch, 
>>> IGBVF device class doesn't seem to have any reset functions 
>>> registered via igbvf_class_init(). So, I am guessing an FLR will not 
>>> trigger igb_vf_reset(), which is probably what we want.
> 
> It does through the VTCTRL registers.
> 
>> You're right. Advertising FLR capability without implementing it can 
>> confuse the guest though such probability is quite a low in practice. 
>> The reset should be implemented first.
> 
> 
> I was looking at an issue from a VFIO perspective which does a FLR
> on a device when pass through. Software and FLR are equivalent for
> a VF.

They should be equivalent according to the datasheet, but unfortunately 
current igbvf implementation does nothing when reset. What Sriram 
proposes is to add code to actually write VTCTRL when FLR occurred and 
make FLR and software reset equivalent. And I think that should be done 
before this change; you should advertise FLR capability after the reset 
is actually implemented.

Regards,
Akihiko Odaki

> 
> I am not sure a VF needs more really, since it is all controlled
> by the PF. >
> C.
> 
>>
>>>
>>>> +
>>>>       if (pcie_aer_init(dev, 1, 0x100, 0x40, errp) < 0) {
>>>>           hw_error("Failed to initialize AER capability");
>>>>       }
>>>> -- 
>>>> 2.40.1
>>>
>>
> 

