Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D51F743D62
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 16:23:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFF1K-0003rf-Dr; Fri, 30 Jun 2023 10:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFF1I-0003rF-4n; Fri, 30 Jun 2023 10:22:44 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFF1G-0003vC-98; Fri, 30 Jun 2023 10:22:43 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1b00b0ab0daso1766479fac.0; 
 Fri, 30 Jun 2023 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688134960; x=1690726960;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=La/Hu8v9SOP+hWvzqFWdorYvPzm9UfHh7aPIc+CA53c=;
 b=RV5A4Ukq5+d/6yaNVRNXRWzJHYX0s+jGwcO0w7Zcau01x2idYwdv1lVdyiOr78YP1A
 kvKBpXLK+1ic0BkeQlAhCYiHK2FNGNoxr9pN0hT2AOPl84f6K97kukoIcwlpLoOIYnPb
 dtA/RejPINZRRi4+2b3MHQ1SdFwahdP9aRijz5tHpgXTKGnSYkcwz/dFw0p+HAS+70Gv
 YIX74iWmLmC1OTalscCOxlqf8Blj0wosNLTAPLbdfKjwjgM4wy/LiiAytQGwN962joRf
 zkY0zp+iV4JgpbjSHT4yCRliGxHytQeovlTISdol4EN5yRcxhFiUk0GLkRnNHoj/vkyJ
 Eeaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688134960; x=1690726960;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=La/Hu8v9SOP+hWvzqFWdorYvPzm9UfHh7aPIc+CA53c=;
 b=WQdXe+2kS2YleN5zrKxkuBSlTDlglPjACtj+invK6UHPVYuCAyEhYuiP6W3szTyWRV
 wXzeWT9VbnEx8sT37hzcsbX2PTJZvBIl+7b9M0I0y6T/yN1W35uaZjlImFoZFHldhr5b
 yYgc3ATsodIHc/pxd9mJm5K6rQBlBEinafS04u6vfAZq4jJS954nnILXXncRmRNvy3YG
 xaPM9DTl1VV568CfdL0M6rRPoESElJbyqPZx9y0gqytburB4Tji0L1T2v0XFKqyoG8/t
 qgFSCvX843VmyOUtnbmvD0cfxlPOo3qakpUMM3nNHPPJREQI2pISB51FL3bUdJ2RlSAB
 VQqg==
X-Gm-Message-State: AC+VfDx0XAeIRDa4eL/HEillW0QVdC9YnT1jqjzOPmol9tEIQ8vybqpT
 3MsX73qsVp/QMp/9nNhJN1A=
X-Google-Smtp-Source: ACHHUZ4GtAH2w4VUguyUwldOWq4Gccu+dD9j8qYchniGcEd+GXSz+FAzI7bcgrv8yjXBmxNV+EWOAw==
X-Received: by 2002:a05:6870:cd0d:b0:1a6:c3d3:969c with SMTP id
 qk13-20020a056870cd0d00b001a6c3d3969cmr3602163oab.45.1688134959953; 
 Fri, 30 Jun 2023 07:22:39 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 cv13-20020a056870c68d00b001aaa093932bsm8894112oab.11.2023.06.30.07.22.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 07:22:39 -0700 (PDT)
Message-ID: <4f8847ca-a25b-e84b-30e6-025bb1687161@gmail.com>
Date: Fri, 30 Jun 2023 11:22:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mv64361: Add dummy gigabit ethernet PHY access registers
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20230605215145.29458746335@zero.eik.bme.hu>
 <a56d91b8-696f-a56e-904d-cda8a2ec3a16@eik.bme.hu>
 <c1bcb719-bede-45d0-c8ca-7362be78bce6@eik.bme.hu>
 <2182bdfb-785d-88c0-51ff-e4c0a9eb4de6@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <2182bdfb-785d-88c0-51ff-e4c0a9eb4de6@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.095,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 6/29/23 05:36, BALATON Zoltan wrote:
> On Wed, 21 Jun 2023, BALATON Zoltan wrote:
>> On Wed, 14 Jun 2023, BALATON Zoltan wrote:
>>> On Mon, 5 Jun 2023, BALATON Zoltan wrote:
>>>> We don't emulate the gigabit ethernet part of the chip but the MorphOS
>>>> driver accesses these and expects to get some valid looking result
>>>> otherwise it hangs. Add some minimal dummy implementation to avoid rhis.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>> This is only used by MorphOS on pegasos2 so most likely could go via
>>>> the ppc queue.
>>>
>>> Ping?
>>
>> Ping?
> 
> Ping?
> https://patchew.org/QEMU/20230605215145.29458746335@zero.eik.bme.hu/
> It's unlikely this will get a review so can you please just merge it? It's my code so if I break it I'll fix it but this was tested a bit and no problem reported so far.
>

Don't worry about it. I'll queue this up.


Daniel

  
> Regards,
> BALATON Zoltan
> 
>>>> hw/pci-host/mv64361.c | 6 ++++++
>>>> hw/pci-host/mv643xx.h | 3 +++
>>>> 2 files changed, 9 insertions(+)
>>>>
>>>> diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
>>>> index 19e8031a3f..01bd8c887f 100644
>>>> --- a/hw/pci-host/mv64361.c
>>>> +++ b/hw/pci-host/mv64361.c
>>>> @@ -541,6 +541,12 @@ static uint64_t mv64361_read(void *opaque, hwaddr addr, unsigned int size)
>>>>             }
>>>>         }
>>>>         break;
>>>> +    case MV64340_ETH_PHY_ADDR:
>>>> +        ret = 0x98;
>>>> +        break;
>>>> +    case MV64340_ETH_SMI:
>>>> +        ret = BIT(27);
>>>> +        break;
>>>>     case MV64340_CUNIT_ARBITER_CONTROL_REG:
>>>>         ret = 0x11ff0000 | (s->gpp_int_level << 10);
>>>>         break;
>>>> diff --git a/hw/pci-host/mv643xx.h b/hw/pci-host/mv643xx.h
>>>> index cd26a43f18..f2e1baea88 100644
>>>> --- a/hw/pci-host/mv643xx.h
>>>> +++ b/hw/pci-host/mv643xx.h
>>>> @@ -656,6 +656,9 @@
>>>> /*        Ethernet Unit Registers       */
>>>> /****************************************/
>>>>
>>>> +#define MV64340_ETH_PHY_ADDR 0x2000
>>>> +#define MV64340_ETH_SMI 0x2004
>>>> +
>>>> /*******************************************/
>>>> /*          CUNIT  Registers               */
>>>> /*******************************************/
>>>>
>>>
>>>
>>
>>

