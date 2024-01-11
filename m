Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD6C82A780
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 07:23:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNoT1-0007Er-Qs; Thu, 11 Jan 2024 01:23:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNoSz-0007E4-NF
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 01:23:01 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNoSx-0005HG-CZ
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 01:23:01 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e60e1373eso411585e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 22:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704954177; x=1705558977; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FkqT7sOC6Gxi7fgkUyNuqtrbt8msCaC9vuthx3NJRqA=;
 b=C30DPDIcEYRt2ICx3qiR1KGuMU1eWH0OPsp08oqjFS505XJorzqsCw46NoGrYEM3eK
 PgKYhzs6tvnLddmhEbcQslfZLGwIDFnb+/rVgpOs2tkrIPd0BykAA2OwIC8nCGjjaG/C
 iPrgTBcZhBxNvfmishZKVbcNu3QZvEYQLA0UZa61DkG1jQF4J/dmOAKPCD8pBXfJOPgt
 8jPyPNbzUkSYIWC/fQYF6Ydmb/xDDIawXmciYNhepKLwc8VC4KCH4J3zfsEQXSUN/+mx
 VMuoq187x6AJ80XDA467N9dueGq2NjMmn19ZLYjRYPVNT0O3sQ+93i03tIc6ytxG7KG/
 jDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704954177; x=1705558977;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FkqT7sOC6Gxi7fgkUyNuqtrbt8msCaC9vuthx3NJRqA=;
 b=ejbVzoZVZfYFGUUu6+6RlLeCk5FpK5pZ4rhTmMkMOgNSggK40k3/jo4yOLTCpwZ8nc
 uzyxSVRIw/2nAgPcjD1YHR3+XMKDBuHtUwf+51M7hr8WYBXXfV5NOU1Hqa0llRNl2BEK
 nOBX8uX5yOSJuAEn6FOwwxZ8c2+AZqIL3BEv/fIg1LVRucOlvKNj07HsiLObkT//pA7h
 ABXpjFMUpZJMErh+5gMbM2AYDHOrciRWhHvcLDhsKf2y/Cc5LQ4oEDugK/KzoGNyLmym
 jF0mtt9HBPhdNRGF9rf/qzuQXDWxLzYozoLhoU4Rx7yeyRKOeU4mQHWMwD/13ILHCygb
 acrw==
X-Gm-Message-State: AOJu0YziF/7ksKvmSgxYQbsJjp0wePnLe/F8/0oQhCsbIzqPYyg6pD8J
 UU7I/PsF2LPUCIVZet1XMlj+vHSzwLFfCg==
X-Google-Smtp-Source: AGHT+IEADBZqr1j+kmaFUPZsm55/Qwa41OSqLn3Dycv2Y6LRALvVKo/j2Zq61WaAHE9PM1kdLghdQA==
X-Received: by 2002:a05:600c:458c:b0:40d:5ce8:d3e0 with SMTP id
 r12-20020a05600c458c00b0040d5ce8d3e0mr79311wmo.11.1704954177406; 
 Wed, 10 Jan 2024 22:22:57 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 r1-20020adfce81000000b0033667867a66sm311971wrn.101.2024.01.10.22.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 22:22:57 -0800 (PST)
Message-ID: <20357abb-90e1-47d7-8af0-738eb77528fc@linaro.org>
Date: Thu, 11 Jan 2024 07:22:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nubus-device: round Declaration ROM memory region
 address to qemu_target_page_size()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org, elliotnunn@fastmail.com
References: <20240108192013.272112-1-mark.cave-ayland@ilande.co.uk>
 <20240108192013.272112-2-mark.cave-ayland@ilande.co.uk>
 <cc1c2370-e516-478b-abfa-620cc8542118@linaro.org>
 <0c609e08-9f03-4dbb-a667-611b4ded7fb4@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0c609e08-9f03-4dbb-a667-611b4ded7fb4@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 9/1/24 22:53, Mark Cave-Ayland wrote:
> On 08/01/2024 23:06, Philippe Mathieu-Daudé wrote:
> 
>> On 8/1/24 20:20, Mark Cave-Ayland wrote:
>>> Declaration ROM binary images can be any arbitrary size, however if a 
>>> host ROM
>>> memory region is not aligned to qemu_target_page_size() then we fail the
>>> "assert(!(iotlb & ~TARGET_PAGE_MASK))" check in tlb_set_page_full().
>>>
>>> Ensure that the host ROM memory region is aligned to 
>>> qemu_target_page_size()
>>> and adjust the offset at which the Declaration ROM image is loaded, 
>>> since Nubus
>>> ROM images are unusual in that they are aligned to the end of the 
>>> slot address
>>> space.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>   hw/nubus/nubus-device.c | 16 ++++++++++++----
>>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
>>> index 49008e4938..e4f824d58b 100644
>>> --- a/hw/nubus/nubus-device.c
>>> +++ b/hw/nubus/nubus-device.c
>>> @@ -10,6 +10,7 @@
>>>   #include "qemu/osdep.h"
>>>   #include "qemu/datadir.h"
>>> +#include "exec/target_page.h"
>>>   #include "hw/irq.h"
>>>   #include "hw/loader.h"
>>>   #include "hw/nubus/nubus.h"
>>> @@ -30,7 +31,7 @@ static void nubus_device_realize(DeviceState *dev, 
>>> Error **errp)
>>>       NubusDevice *nd = NUBUS_DEVICE(dev);
>>>       char *name, *path;
>>>       hwaddr slot_offset;
>>> -    int64_t size;
>>> +    int64_t size, align_size;
>>
>> Both are 'size_t'.
> 
> I had a look at include/hw/loader.h, and the function signature for 
> get_image_size() returns int64_t. Does it not make sense to keep int64_t 
> here and use uintptr_t for the pointer arithmetic as below so that 
> everything matches?

Oh you are right:

$ git grep -E '(get_image_size|qemu_target_page_size|load_image_size)\(' 
include
include/exec/target_page.h:17:size_t qemu_target_page_size(void);
include/hw/loader.h:13:int64_t get_image_size(const char *filename);
include/hw/loader.h:30:ssize_t load_image_size(const char *filename, 
void *addr, size_t size);

So I guess int64_t is safer.

>>>       int ret;
>>>       /* Super */
>>> @@ -76,16 +77,23 @@ static void nubus_device_realize(DeviceState 
>>> *dev, Error **errp)
>>>           }
>>>           name = g_strdup_printf("nubus-slot-%x-declaration-rom", 
>>> nd->slot);
>>> -        memory_region_init_rom(&nd->decl_rom, OBJECT(dev), name, size,
>>> +
>>> +        /*
>>> +         * Ensure ROM memory region is aligned to target page size 
>>> regardless
>>> +         * of the size of the Declaration ROM image
>>> +         */
>>> +        align_size = ROUND_UP(size, qemu_target_page_size());
>>> +        memory_region_init_rom(&nd->decl_rom, OBJECT(dev), name, 
>>> align_size,
>>>                                  &error_abort);
>>> -        ret = load_image_mr(path, &nd->decl_rom);
>>> +        ret = load_image_size(path, 
>>> memory_region_get_ram_ptr(&nd->decl_rom) +
>>> +                                    (uintptr_t)align_size - size, 
>>> size);
>>
>> memory_region_get_ram_ptr() returns a 'void *' so this looks dubious.
>> Maybe use a local variable to ease offset calculation?
>>
>>    char *rombase = memory_region_get_ram_ptr(&nd->decl_rom);
>>    ret = load_image_size(path, rombase + align_size - size, size);
>>
>> Otherwise KISS but ugly:
>>
>>    ret = load_image_size(path,
>>              (void *)((uintptr_t)memory_region_get_ram_ptr(&nd->decl_rom)
>>                       + align_size - size), size);
> 
> I prefer the first approach, but with uint8_t instead of char since it 
> clarifies that it is a pointer to an arbitrary set of bytes as opposed 
> to a string. Does that seem reasonable?

Sure! Then with that:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
>>>           g_free(path);
>>>           g_free(name);
>>>           if (ret < 0) {
>>>               error_setg(errp, "could not load romfile \"%s\"", 
>>> nd->romfile);
>>>               return;
>>>           }
>>> -        memory_region_add_subregion(&nd->slot_mem, NUBUS_SLOT_SIZE - 
>>> size,
>>> +        memory_region_add_subregion(&nd->slot_mem, NUBUS_SLOT_SIZE - 
>>> align_size,
>>>                                       &nd->decl_rom);
>>>       }
>>>   }
> 
> 
> ATB,
> 
> Mark.
> 


