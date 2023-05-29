Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7409C714524
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 09:02:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3WtS-0002LP-7m; Mon, 29 May 2023 03:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3WtH-0002Jz-9U
 for qemu-devel@nongnu.org; Mon, 29 May 2023 03:02:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3WtE-0008Lv-ML
 for qemu-devel@nongnu.org; Mon, 29 May 2023 03:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685343719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9JncihyN2OxoZf05eVIMyZuXAUCNzbDoX/v+nIZfkHE=;
 b=V7IwTAn35HJUxLJt0bZNqAFF//SjZVrf0a+S44XJ7ljADnwkydikh8YuTaSbgX/9g4cOR2
 kyeylGeFQEmIlcKc2SKN69RY3WI49e4k0UXvikiDb235WRdOUbtSOIF0E/r4A7Zf9mSduA
 kbtwxYYJ9968Ul7VUFUp3D+zgdVaWgM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-ZQw-D135PbmhGL83VEDpCQ-1; Mon, 29 May 2023 03:01:57 -0400
X-MC-Unique: ZQw-D135PbmhGL83VEDpCQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f5fb41bc42so12395995e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 00:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685343716; x=1687935716;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9JncihyN2OxoZf05eVIMyZuXAUCNzbDoX/v+nIZfkHE=;
 b=PnAnloKRVc4EWoOpD2ex/D+GIzKcMy2aKskWbHMFQMFxe3HKEc5dYYUu5Jm4slMPWS
 D/OeMMfRch+thGxh8LfotQXAfs86SE1AVPpRTh0oqSvLIKsRmYoL1p/Boq6UuotecN6f
 1qk7cW15dLHYDFK1dbz/DNkDro+koPjtSoFl/lFKY2raxYxT5gNfrN079LsMWAjzflge
 2dQvIlHI42uuFV//yRCHHtbMMqY5muIf1kiMUm9hO0N7rWnqu+L4QfHp1lmRgjd5xOQd
 gfjFxLsaEBZqezwrRBUPe/Vxnl35FsJGtDkwVbEXT7uILnGkqvdxPc0ikXOETgkXlKwv
 o6HQ==
X-Gm-Message-State: AC+VfDzq2bvqm6dhqgG2SBJ91clgJwghxRj7HL9RjCY3NH48P5DDQlFG
 TMG+1YgWkycL7GnBc3tb9Pd3mQCbTIw/LaxAdYP3DH9RBF5u28MNXEAlrdYcpuTwvvr8DFyRHK7
 q85nBDVL8rKlqiBY=
X-Received: by 2002:a7b:ce19:0:b0:3f4:2267:10cf with SMTP id
 m25-20020a7bce19000000b003f4226710cfmr8853150wmc.32.1685343716258; 
 Mon, 29 May 2023 00:01:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ568Wt7QPgkFQt1xvPrw4kpzBJYulRWOKFgOGViudxCSyPcNkqjsa2zlGr07H36vM0l1buYpA==
X-Received: by 2002:a7b:ce19:0:b0:3f4:2267:10cf with SMTP id
 m25-20020a7bce19000000b003f4226710cfmr8853129wmc.32.1685343715971; 
 Mon, 29 May 2023 00:01:55 -0700 (PDT)
Received: from [192.168.43.219] ([88.174.74.114])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a7bce8d000000b003f43f82001asm16818788wmj.31.2023.05.29.00.01.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 May 2023 00:01:55 -0700 (PDT)
Message-ID: <8fb19b45-0dc3-a3d6-fcf9-5fc8728edf4d@redhat.com>
Date: Mon, 29 May 2023 09:01:53 +0200
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
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <e2bed67c-23ea-6364-bd5a-f7b330346302@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/29/23 04:45, Akihiko Odaki wrote:
> On 2023/05/28 19:50, Sriram Yagnaraman wrote:
>>
>>> -----Original Message-----
>>> From: Cédric Le Goater <clg@redhat.com>
>>> Sent: Friday, 26 May 2023 19:31
>>> To: qemu-devel@nongnu.org
>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>; Sriram Yagnaraman
>>> <sriram.yagnaraman@est.tech>; Jason Wang <jasowang@redhat.com>; Cédric
>>> Le Goater <clg@redhat.com>
>>> Subject: [PATCH] igb: Add Function Level Reset to PF and VF
>>>
>>> The Intel 82576EB GbE Controller say that the Physical and Virtual Functions
>>> support Function Level Reset. Add the capability to each device model.
>>>
>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   hw/net/igb.c   | 3 +++
>>>   hw/net/igbvf.c | 3 +++
>>>   2 files changed, 6 insertions(+)
>>>
>>> diff --git a/hw/net/igb.c b/hw/net/igb.c index 1c989d767725..08e389338dca
>>> 100644
>>> --- a/hw/net/igb.c
>>> +++ b/hw/net/igb.c
>>> @@ -101,6 +101,7 @@ static void igb_write_config(PCIDevice *dev, uint32_t
>>> addr,
>>>
>>>       trace_igb_write_config(addr, val, len);
>>>       pci_default_write_config(dev, addr, val, len);
>>> +    pcie_cap_flr_write_config(dev, addr, val, len);
>>>
>>>       if (range_covers_byte(addr, len, PCI_COMMAND) &&
>>>           (dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) { @@ -427,6
>>> +428,8 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
>>>       }
>>>
>>>       /* PCIe extended capabilities (in order) */
>>> +    pcie_cap_flr_init(pci_dev);
>>> +
>>>       if (pcie_aer_init(pci_dev, 1, 0x100, 0x40, errp) < 0) {
>>>           hw_error("Failed to initialize AER capability");
>>>       }
>>> diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c index
>>> 284ea611848b..0a58dad06802 100644
>>> --- a/hw/net/igbvf.c
>>> +++ b/hw/net/igbvf.c
>>> @@ -204,6 +204,7 @@ static void igbvf_write_config(PCIDevice *dev,
>>> uint32_t addr, uint32_t val,  {
>>>       trace_igbvf_write_config(addr, val, len);
>>>       pci_default_write_config(dev, addr, val, len);
>>> +    pcie_cap_flr_write_config(dev, addr, val, len);
>>>   }
>>>
>>>   static uint64_t igbvf_mmio_read(void *opaque, hwaddr addr, unsigned size)
>>> @@ -266,6 +267,8 @@ static void igbvf_pci_realize(PCIDevice *dev, Error
>>> **errp)
>>>           hw_error("Failed to initialize PCIe capability");
>>>       }
>>>
>>> +    pcie_cap_flr_init(dev);
>>
>> Sorry for my naive question, and perhaps not related to your patch, IGBVF device class doesn't seem to have any reset functions registered via igbvf_class_init(). So, I am guessing an FLR will not trigger igb_vf_reset(), which is probably what we want.

It does through the VTCTRL registers.

> You're right. Advertising FLR capability without implementing it can confuse the guest though such probability is quite a low in practice. The reset should be implemented first.


I was looking at an issue from a VFIO perspective which does a FLR
on a device when pass through. Software and FLR are equivalent for
a VF.

I am not sure a VF needs more really, since it is all controlled
by the PF.

C.

> 
>>
>>> +
>>>       if (pcie_aer_init(dev, 1, 0x100, 0x40, errp) < 0) {
>>>           hw_error("Failed to initialize AER capability");
>>>       }
>>> -- 
>>> 2.40.1
>>
> 


