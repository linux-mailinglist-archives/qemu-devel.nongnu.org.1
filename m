Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE94826F83
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 14:18:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMpWZ-00075v-7m; Mon, 08 Jan 2024 08:18:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMpVp-0006VZ-OK
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 08:18:08 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMpVj-0001LE-1Q
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 08:17:48 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50e67e37661so2084201e87.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 05:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704719865; x=1705324665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l+HzOLPe/bJdcMkKNcP7ZFMA6ixqTYCa9hVoD70O+9Q=;
 b=BcYOrgmIlKmE6OmhSZA7fkknWy+wO/KGw89U/XJtozhNDnMxImgGbKkfzre+tby1NJ
 5OVU/R6wjjZ6x8Aos1z01sdpLS9GO+ztxjGCHAjKIFAHwwORQv0MkBl1sCAHgQTwpimS
 QsMHjjrVl2I7ypQcSCWOs2N7kX01tshRlN3j1yEWaHYa+0HhLChjWWwH1bNWhGuopD5l
 ssmHNiZSlGdB17qofrDDyChRnKn/7LQG1/K0J3eO+fsgsy6yPSVXJdRFptyalZRgtooC
 WQ+Zkps6M8teMonRyr1+o1Fn8lUrgdrh8OUc0gP9ZEO+Qv1mUM+ytuunYuzGTDvc3zu/
 fnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704719865; x=1705324665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l+HzOLPe/bJdcMkKNcP7ZFMA6ixqTYCa9hVoD70O+9Q=;
 b=DBFC17EArIdCtsPUXxLsCqnOPh7onSyh5unqNZD/6QEWYeXiGPzyFKFKdNg8ODyJmb
 O8PgZMfY6wl4J5lGIoA56svcYpGBFqVlYafShs32tLyHcaWmg3L9e8WKBlrXI1xdhWPE
 Gcy/94Ycf3BBjFpYfsddhNwuYQpy75NX3uAUfjUsFpSj7B7T9ShL8kUJoQbkW7mPAUxz
 4c1Ffixts8aUQAVUaqOz8hKH5S1asVjlpyYD0o6sdrobRqWF1Zo6yk0RrZWhMGr/4Vis
 d0oX0Z8bPw2AQCSbDkkNmKthFOBL53JvW2WmtMxYkzA9n2qGJmMZ9BUtFRB+Ti0lF0kG
 0JTw==
X-Gm-Message-State: AOJu0YwMw4n+ocGGbHpyyAFTFpjqHjitfiC7dBC6RwSZiJ9fcaNRZlmA
 bcskv063g8vBVMUU9K1+j5C9mAs9L4hiEKxInHkAKGuidb0=
X-Google-Smtp-Source: AGHT+IH101V+QHJvjf8tkSyxX5PYVsc25vnANFL4w81GHptmYTZb0+aGrqcFs5dFfg0tTPHClqJ8xQ==
X-Received: by 2002:a19:2d4f:0:b0:50e:6990:a344 with SMTP id
 t15-20020a192d4f000000b0050e6990a344mr1399201lft.39.1704719865021; 
 Mon, 08 Jan 2024 05:17:45 -0800 (PST)
Received: from [192.168.1.102] ([176.176.175.62])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a05600c138700b0040d62f97e3csm10952503wmf.10.2024.01.08.05.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 05:17:44 -0800 (PST)
Message-ID: <0400b289-e751-4f97-ac96-5da1282aad30@linaro.org>
Date: Mon, 8 Jan 2024 14:17:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nubus-device: round Declaration ROM memory region
 address to qemu_target_page_size()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
Cc: laurent@vivier.eu, elliotnunn@fastmail.com, qemu-devel@nongnu.org
References: <20240107212538.227627-1-mark.cave-ayland@ilande.co.uk>
 <20240107212538.227627-2-mark.cave-ayland@ilande.co.uk>
 <685bc632-4cdb-499e-a23a-584578792681@linaro.org>
 <776688ad-92a4-404e-9b3c-216b0da7bfc8@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <776688ad-92a4-404e-9b3c-216b0da7bfc8@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

On 8/1/24 13:46, Mark Cave-Ayland wrote:
> On 08/01/2024 12:01, Philippe Mathieu-Daudé wrote:
> 
>> On 7/1/24 22:25, Mark Cave-Ayland wrote:
>>> Declaration ROM binary images can be any arbitrary size, however if a 
>>> host ROM
>>> memory region is not aligned to qemu_target_page_size() then we fail the
>>> "assert(!(iotlb & ~TARGET_PAGE_MASK))" check in tlb_set_page_full().
>>
>> IIUC this isn't specific to NuBus but to any ROM used to execute code
>> in place.
>>
>> Shouldn't this be handled in memory_region_init_rom()?
> 
> There were some previous discussion in the threads here:
> 
> https://lore.kernel.org/all/b68ab7d3-d3d3-9f81-569d-454ae9c11b16@linaro.org/T/
> https://patchew.org/QEMU/20231208020619.117-1-zhiwei._5Fliu@linux.alibaba.com/
> 
> My impression from Richard's last reply in the second thread is that 
> this should be fixed in nubus-device instead?

Hmm OK. And you need the offset to call load_image_size() at the
proper offset anyway.

Can you add that <...

> The Nubus declaration ROMs 
> are different in that they are aligned to the end of the memory region 
> rather than the beginning, which is probably quite an unusual use-case.

...> info to the description?


> 
>>> Ensure that the host ROM memory region is aligned to 
>>> qemu_target_page_size()
>>> and adjust the offset at which the Declaration ROM image is loaded so 
>>> that the
>>> image is still aligned to the end of the Nubus slot.

 >> should it be that the ROM memory region must be aligned to 
TARGET_PAGE_MASK?

This seems to make sense to me, but I'm out of my comfort zone.

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


