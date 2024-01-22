Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3D2835CD2
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 09:39:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRpoY-0005Lt-VT; Mon, 22 Jan 2024 03:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rRpoV-0005Hf-9P
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 03:37:51 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rRpoS-0004vn-Om
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 03:37:50 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-337d6d7fbd5so2138607f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 00:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705912667; x=1706517467; darn=nongnu.org;
 h=content-transfer-encoding:from:in-reply-to:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BABMo+tBFElBwdd4D/pEXRYsj9g/W9bB2fYSZqQAhgI=;
 b=RwMVF+iFbALw0GJqzk64iM7mxG+mQO4EfwZAZhRxNqTqM2DHvUJivgZmicQxwlXa6v
 MJfs6ZppKHFdAZonlGE5LRnzZYVk7Tzf2sK7ig8jIhaKVaTs2q0Z+ILi2T41wq6uUqsc
 orZAsZs7daqlQOApQEuvs+s5gn4CuCz4c+pi9GLMAkCD8GsZGuSqOZ4gD+K+OFX7PYyt
 o+szmW1WIuNIL/qu9ewdWrg/9kB0c2nyiDtLFNKgYoP7MhkhVu7qydpQPYtTxR3Te8uY
 5qVdoHcFEed8TCacXCh7AHvQ8+jcNR30tgJ1TpuegTw9I+3pG5oXDzLI2w78a3qfZZOe
 WZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705912667; x=1706517467;
 h=content-transfer-encoding:from:in-reply-to:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BABMo+tBFElBwdd4D/pEXRYsj9g/W9bB2fYSZqQAhgI=;
 b=wsdjfF0dSw+y8W9p2x8y/ix7BttqpdZJeWYW53VJnkv0F8Ftd0XdwNeOGi0zh4hkIC
 bA/s4+wNgy7mcUrxFzJM/01q4C4lx0QhlQlixQumkqzGtOvLEHLa6HgdqoPbbXTqrW/Z
 6LjvGIQOaGQ6P9rNCDW/I62I2ceYgeKvi05d6gn7hfaQwvGVOBnQaZH+zeCeUvNWb1X5
 SNLd3mnpxfWthhaoJFfjBnA+nM3LMIZRI/lBLZQbqiUhNdhVyVo57VUaRcKTPvG7YJsb
 Y3Kq+uJJ2Gh2HsqsfEAaQwzdceNaCkIYFIBcG01nHSBU55v5ATSadKsThfRfI4iwhFST
 3bSg==
X-Gm-Message-State: AOJu0Yzj6utZJiwZTBxYsl9a7195Lyl2SRlqgM8PgMDZi6Fxk6QbCGOz
 T6oz+IjlT0eU/fFSxaq9vveNPsYhtyFQQUjfiGgcMwiHPYYsvlmy
X-Google-Smtp-Source: AGHT+IHJFp7dgmyQHda3nZeIPYHhx4lSyCqE4p+hsRgluW2L6q+OTGZJnD6LtnggW/Lreo9GjhSRfA==
X-Received: by 2002:adf:f3c6:0:b0:337:c29a:ba40 with SMTP id
 g6-20020adff3c6000000b00337c29aba40mr2352114wrp.31.1705912666820; 
 Mon, 22 Jan 2024 00:37:46 -0800 (PST)
Received: from [192.168.1.131] ([87.68.195.83])
 by smtp.gmail.com with ESMTPSA id
 q5-20020adff505000000b00339214d70b5sm8056910wro.85.2024.01.22.00.37.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 00:37:46 -0800 (PST)
Message-ID: <a85c387c-76a5-c86d-1523-592ff910c31e@gmail.com>
Date: Mon, 22 Jan 2024 10:37:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3] Handle wrap around in limit calculation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: andrew.sminov@gmail.com, peter.maydell@linaro.com, shlomop@pliops.com,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240121164754.47367-1-shlomop@pliops.com>
 <98ede7dd-b254-43aa-bf7d-f5d90494b8c9@linaro.org>
In-Reply-To: <98ede7dd-b254-43aa-bf7d-f5d90494b8c9@linaro.org>
From: Shlomo Pongratz <shlomopongratz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=shlomopongratz@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.72, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Please see inline

On 22/01/2024 01:17, Philippe Mathieu-Daudé wrote:
> Hi Shlomo,
>
> On 21/1/24 17:47, Shlomo Pongratz wrote:
>> From: Shlomo Pongratz <shlomopongratz@gmail.com>
>>
>>      Hanlde wrap around when calculating the viewport size
>>      caused by the fact that perior to version 460A the limit variable
>>      was 32bit quantity and not 64 bits quantity.
>>      In the i.MX 6Dual/6Quad Applications Processor Reference Manual
>>      document on which the original code was based upon in the
>>      description of the iATU Region Upper Base Address Register it is
>>      written:
>>      Forms bits [63:32] of the start (and end) address of the address 
>> region to be
>>      translated.
>>      That is in this register is the upper of both base and the limit.
>>      In the current implementation this value was ignored for the limit
>>      which caused a wrap around of the size calculaiton.
>>      Using the documnet example:
>>      Base HI: 0x80000000 Base LO: 0xd0000000 Limit LO: 0xd000ffff
>>      The correct size is 0x80000000d000ffff - 0x80000000d0000000 + 1 =
>> 0x010000
>>      The wrong result is 0xd000ffff - 0x80000000d0000000 + 1 = 
>> 0x8000000000010000
>>
>>      Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
>>
>>      ----
>>
>>      Changes since v2:
>>       * Don't try to fix the calculation.
>>       * Change the limit variable from 32bit to 64 bit
>>       * Set the limit bits [63:32] same as the base according to
>>         the specification on which the original code was base upon.
>>
>>      Changes since v1:
>>       * Seperate subject and description
>> ---
>>   hw/pci-host/designware.c         | 19 ++++++++++++++-----
>>   include/hw/pci-host/designware.h |  2 +-
>>   2 files changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
>> index dd9e389c07..43cba9432f 100644
>> --- a/hw/pci-host/designware.c
>> +++ b/hw/pci-host/designware.c
>> @@ -269,7 +269,7 @@ static void 
>> designware_pcie_update_viewport(DesignwarePCIERoot *root,
>>   {
>>       const uint64_t target = viewport->target;
>>       const uint64_t base   = viewport->base;
>> -    const uint64_t size   = (uint64_t)viewport->limit - base + 1;
>> +    const uint64_t size   = viewport->limit - base + 1;
>>       const bool enabled    = viewport->cr[1] & 
>> DESIGNWARE_PCIE_ATU_ENABLE;
>>         MemoryRegion *current, *other;
>> @@ -351,6 +351,14 @@ static void 
>> designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
>>       case DESIGNWARE_PCIE_ATU_UPPER_BASE:
>>           viewport->base &= 0x00000000FFFFFFFFULL;
>>           viewport->base |= (uint64_t)val << 32;
>> +        /* The documentatoin states that the value of this register
>> +         * "Forms bits [63:32] of the start (and end) address
>> +         * of the address region to be translated.
>> +         * Note that from version 406A there is a sperate
>> +         * register fot the upper end address
>> +         */
>> +        viewport->limit &= 0x00000000FFFFFFFFULL;
>> +        viewport->limit |= (uint64_t)val << 32;
>
> This code is easier to review using:
>
>           viewport->limit = deposit64(viewport->limit, 32, 32, val);
>
It will be strange to have
viewport->base &= 0x00000000FFFFFFFFULL;
     viewport->base |= (uint64_t)val << 32;
and then
viewport->limit = deposit64(viewport->limit, 32, 32, val);
I think that the code for base and limit should be the same.
And I don't think the original for base should be change to
viewport->base = deposit64(viewport->base, 32, 32, val);
SO everything will look the same.
>>           break;
>>         case DESIGNWARE_PCIE_ATU_LOWER_TARGET:
>> @@ -364,7 +372,8 @@ static void 
>> designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
>>           break;
>>         case DESIGNWARE_PCIE_ATU_LIMIT:
>> -        viewport->limit = val;
>> +        viewport->limit &= 0xFFFFFFFF00000000ULL;
>> +        viewport->limit |= val;
>
> Here:
>
>           viewport->limit = deposit64(viewport->limit, 0, 32, val);
My opinion is that the code should be identical to
case DESIGNWARE_PCIE_ATU_LOWER_BASE:
         viewport->base &= 0xFFFFFFFF00000000ULL;
         viewport->base |= val;
         break;
I don't think it is good to mix two styles.
>>           break;
>>         case DESIGNWARE_PCIE_ATU_CR1:
>> @@ -429,7 +438,7 @@ static void 
>> designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>>           viewport->inbound = true;
>>           viewport->base    = 0x0000000000000000ULL;
>>           viewport->target  = 0x0000000000000000ULL;
>> -        viewport->limit   = UINT32_MAX;
>> +        viewport->limit   = 0x00000000FFFFFFFFULL;
>
> Previous code is easier to review IMHO.
Just want to make it clear that this is 64 bit values and that the
upper value is the same as the base's upper value, and according to spec.
>>           viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
>>             source      = &host->pci.address_space_root;
>> @@ -453,7 +462,7 @@ static void 
>> designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>>           viewport->inbound = false;
>>           viewport->base    = 0x0000000000000000ULL;
>>           viewport->target  = 0x0000000000000000ULL;
>> -        viewport->limit   = UINT32_MAX;
>> +        viewport->limit   = 0x00000000FFFFFFFFULL;
>
> Ditto.
Ditto.
>
>>           viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
>>             destination = &host->pci.memory;
>> @@ -560,7 +569,7 @@ static const VMStateDescription 
>> vmstate_designware_pcie_viewport = {
>>       .fields = (const VMStateField[]) {
>>           VMSTATE_UINT64(base, DesignwarePCIEViewport),
>>           VMSTATE_UINT64(target, DesignwarePCIEViewport),
>> -        VMSTATE_UINT32(limit, DesignwarePCIEViewport),
>> +        VMSTATE_UINT64(limit, DesignwarePCIEViewport),
>
> Unfortunately this breaks the migration stream. I'm not sure
> what is the best way to deal with it (Cc'ing migration
> maintainers).
My bad forgot to update version_id and minimum_version_id.
I'll consult Peter Xu's document.
>
>>           VMSTATE_UINT32_ARRAY(cr, DesignwarePCIEViewport, 2),
>>           VMSTATE_END_OF_LIST()
>>       }
> Regards,
>
> Phil.


------------------------------------------------------------------------
*From:* Philippe Mathieu-Daudé [mailto:philmd@linaro.org]
*Sent:* Monday, January 22, 2024, 1:17 AM
*To:* Shlomo Pongratz; qemu-devel@nongnu.org
*Cc:* andrew.sminov@gmail.com, peter.maydell@linaro.com, 
shlomop@pliops.com, Peter Xu; Fabiano Rosas
*Subject:* [PATCH v3] Handle wrap around in limit calculation

> Hi Shlomo,
>
> On 21/1/24 17:47, Shlomo Pongratz wrote:
>> From: Shlomo Pongratz <shlomopongratz@gmail.com>
>>
>>      Hanlde wrap around when calculating the viewport size
>>      caused by the fact that perior to version 460A the limit variable
>>      was 32bit quantity and not 64 bits quantity.
>>      In the i.MX 6Dual/6Quad Applications Processor Reference Manual
>>      document on which the original code was based upon in the
>>      description of the iATU Region Upper Base Address Register it is
>>      written:
>>      Forms bits [63:32] of the start (and end) address of the address 
>> region to be
>>      translated.
>>      That is in this register is the upper of both base and the limit.
>>      In the current implementation this value was ignored for the limit
>>      which caused a wrap around of the size calculaiton.
>>      Using the documnet example:
>>      Base HI: 0x80000000 Base LO: 0xd0000000 Limit LO: 0xd000ffff
>>      The correct size is 0x80000000d000ffff - 0x80000000d0000000 + 1 =
>> 0x010000
>>      The wrong result is 0xd000ffff - 0x80000000d0000000 + 1 = 
>> 0x8000000000010000
>>
>>      Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
>>
>>      ----
>>
>>      Changes since v2:
>>       * Don't try to fix the calculation.
>>       * Change the limit variable from 32bit to 64 bit
>>       * Set the limit bits [63:32] same as the base according to
>>         the specification on which the original code was base upon.
>>
>>      Changes since v1:
>>       * Seperate subject and description
>> ---
>>   hw/pci-host/designware.c         | 19 ++++++++++++++-----
>>   include/hw/pci-host/designware.h |  2 +-
>>   2 files changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
>> index dd9e389c07..43cba9432f 100644
>> --- a/hw/pci-host/designware.c
>> +++ b/hw/pci-host/designware.c
>> @@ -269,7 +269,7 @@ static void 
>> designware_pcie_update_viewport(DesignwarePCIERoot *root,
>>   {
>>       const uint64_t target = viewport->target;
>>       const uint64_t base   = viewport->base;
>> -    const uint64_t size   = (uint64_t)viewport->limit - base + 1;
>> +    const uint64_t size   = viewport->limit - base + 1;
>>       const bool enabled    = viewport->cr[1] & 
>> DESIGNWARE_PCIE_ATU_ENABLE;
>>         MemoryRegion *current, *other;
>> @@ -351,6 +351,14 @@ static void 
>> designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
>>       case DESIGNWARE_PCIE_ATU_UPPER_BASE:
>>           viewport->base &= 0x00000000FFFFFFFFULL;
>>           viewport->base |= (uint64_t)val << 32;
>> +        /* The documentatoin states that the value of this register
>> +         * "Forms bits [63:32] of the start (and end) address
>> +         * of the address region to be translated.
>> +         * Note that from version 406A there is a sperate
>> +         * register fot the upper end address
>> +         */
>> +        viewport->limit &= 0x00000000FFFFFFFFULL;
>> +        viewport->limit |= (uint64_t)val << 32;
>
> This code is easier to review using:
>
>           viewport->limit = deposit64(viewport->limit, 32, 32, val);
>
>>           break;
>>         case DESIGNWARE_PCIE_ATU_LOWER_TARGET:
>> @@ -364,7 +372,8 @@ static void 
>> designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
>>           break;
>>         case DESIGNWARE_PCIE_ATU_LIMIT:
>> -        viewport->limit = val;
>> +        viewport->limit &= 0xFFFFFFFF00000000ULL;
>> +        viewport->limit |= val;
>
> Here:
>
>           viewport->limit = deposit64(viewport->limit, 0, 32, val);
>
>>           break;
>>         case DESIGNWARE_PCIE_ATU_CR1:
>> @@ -429,7 +438,7 @@ static void 
>> designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>>           viewport->inbound = true;
>>           viewport->base    = 0x0000000000000000ULL;
>>           viewport->target  = 0x0000000000000000ULL;
>> -        viewport->limit   = UINT32_MAX;
>> +        viewport->limit   = 0x00000000FFFFFFFFULL;
>
> Previous code is easier to review IMHO.
>
>>           viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
>>             source      = &host->pci.address_space_root;
>> @@ -453,7 +462,7 @@ static void 
>> designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>>           viewport->inbound = false;
>>           viewport->base    = 0x0000000000000000ULL;
>>           viewport->target  = 0x0000000000000000ULL;
>> -        viewport->limit   = UINT32_MAX;
>> +        viewport->limit   = 0x00000000FFFFFFFFULL;
>
> Ditto.
>
>>           viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
>>             destination = &host->pci.memory;
>> @@ -560,7 +569,7 @@ static const VMStateDescription 
>> vmstate_designware_pcie_viewport = {
>>       .fields = (const VMStateField[]) {
>>           VMSTATE_UINT64(base, DesignwarePCIEViewport),
>>           VMSTATE_UINT64(target, DesignwarePCIEViewport),
>> -        VMSTATE_UINT32(limit, DesignwarePCIEViewport),
>> +        VMSTATE_UINT64(limit, DesignwarePCIEViewport),
>
> Unfortunately this breaks the migration stream. I'm not sure
> what is the best way to deal with it (Cc'ing migration
> maintainers).
>
>>           VMSTATE_UINT32_ARRAY(cr, DesignwarePCIEViewport, 2),
>>           VMSTATE_END_OF_LIST()
>>       }
> Regards,
>
> Phil.

