Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A6D826ECB
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 13:48:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMp1q-0006nJ-7p; Mon, 08 Jan 2024 07:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMp1f-0006mv-Ae
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:46:44 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMp1b-0001QM-8D
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B/+Kz2efQuCbMhNobP728ro7nmOhqFd9qu8B+eFwpac=; b=fFn7MhErqYKd7E6/D6qOYuYhVV
 zktsnPlPlhosI8N54pZAylW+r/MDzSEp1tPkIaLJRfOmLHPPVpLYsKV3arXy0HdsN+wZJEfDZltir
 Gau30ZwshdPOcvx34Iz+9A3nlo4Y+KUGR41M963U3TiPhqb8L3IFWpOmY/0/NOAnpQmO8B69M+9Q2
 1IyJae/alKVdmgUrRFd+FYvET6SG4V5UfiMKByPi2a8cWO4rTa7wJEduxfCrc9nypnm6X8Okh56nL
 qClPeWRzIcNcc70bSBT5bCycAGNc9+K09rlvpfBNLLEhgy26uselYjniKy4O7ZDW2Lr3IGg2Y2jTF
 MeRs9FLjNTVkZvjFTwFQG+JOO7HXbJF/DGZq4tbLNk8qwHtxKCZXASMNkJKRHDsf1giWaW3EBNoKU
 b4RQgSiQXA2izi7ZH7GktJBwylqTiXbel7pzvyszliKD5NvaSwqAkI2n5hVNuj1uWBei/LyLqiLuS
 7pS+Hj+gGelmmMiE5htiqWG9aGIY6P+0V/yYHk4kcE0jAaPeWaWiMyU0SezQecsmKxGyg0JjxBpd9
 5MvY9UfnBqyUZQRq1UUFEq7S+t+NS4KTgMTRAIHnq78oyqUgIEgo+zd3aPL+QiQT+jATiytyz+Jry
 8MLs7MK4sGcNXfVygQ8Er8nIJypayEFz5UwPHLwMQ=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMp0w-000B8I-U8; Mon, 08 Jan 2024 12:46:02 +0000
Message-ID: <776688ad-92a4-404e-9b3c-216b0da7bfc8@ilande.co.uk>
Date: Mon, 8 Jan 2024 12:46:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
Cc: laurent@vivier.eu, elliotnunn@fastmail.com, qemu-devel@nongnu.org
References: <20240107212538.227627-1-mark.cave-ayland@ilande.co.uk>
 <20240107212538.227627-2-mark.cave-ayland@ilande.co.uk>
 <685bc632-4cdb-499e-a23a-584578792681@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <685bc632-4cdb-499e-a23a-584578792681@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 1/2] nubus-device: round Declaration ROM memory region
 address to qemu_target_page_size()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 08/01/2024 12:01, Philippe Mathieu-Daudé wrote:

> On 7/1/24 22:25, Mark Cave-Ayland wrote:
>> Declaration ROM binary images can be any arbitrary size, however if a host ROM
>> memory region is not aligned to qemu_target_page_size() then we fail the
>> "assert(!(iotlb & ~TARGET_PAGE_MASK))" check in tlb_set_page_full().
> 
> IIUC this isn't specific to NuBus but to any ROM used to execute code
> in place.
> 
> Shouldn't this be handled in memory_region_init_rom()?

There were some previous discussion in the threads here:

https://lore.kernel.org/all/b68ab7d3-d3d3-9f81-569d-454ae9c11b16@linaro.org/T/
https://patchew.org/QEMU/20231208020619.117-1-zhiwei._5Fliu@linux.alibaba.com/

My impression from Richard's last reply in the second thread is that this should be 
fixed in nubus-device instead? The Nubus declaration ROMs are different in that they 
are aligned to the end of the memory region rather than the beginning, which is 
probably quite an unusual use-case.

>> Ensure that the host ROM memory region is aligned to qemu_target_page_size()
>> and adjust the offset at which the Declaration ROM image is loaded so that the
>> image is still aligned to the end of the Nubus slot.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/nubus/nubus-device.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
>> index 49008e4938..e4f824d58b 100644
>> --- a/hw/nubus/nubus-device.c
>> +++ b/hw/nubus/nubus-device.c
>> @@ -10,6 +10,7 @@
>>   #include "qemu/osdep.h"
>>   #include "qemu/datadir.h"
>> +#include "exec/target_page.h"
>>   #include "hw/irq.h"
>>   #include "hw/loader.h"
>>   #include "hw/nubus/nubus.h"
>> @@ -30,7 +31,7 @@ static void nubus_device_realize(DeviceState *dev, Error **errp)
>>       NubusDevice *nd = NUBUS_DEVICE(dev);
>>       char *name, *path;
>>       hwaddr slot_offset;
>> -    int64_t size;
>> +    int64_t size, align_size;
>>       int ret;
>>       /* Super */
>> @@ -76,16 +77,23 @@ static void nubus_device_realize(DeviceState *dev, Error **errp)
>>           }
>>           name = g_strdup_printf("nubus-slot-%x-declaration-rom", nd->slot);
>> -        memory_region_init_rom(&nd->decl_rom, OBJECT(dev), name, size,
>> +
>> +        /*
>> +         * Ensure ROM memory region is aligned to target page size regardless
>> +         * of the size of the Declaration ROM image
>> +         */
>> +        align_size = ROUND_UP(size, qemu_target_page_size());
>> +        memory_region_init_rom(&nd->decl_rom, OBJECT(dev), name, align_size,
>>                                  &error_abort);
>> -        ret = load_image_mr(path, &nd->decl_rom);
>> +        ret = load_image_size(path, memory_region_get_ram_ptr(&nd->decl_rom) +
>> +                                    (uintptr_t)align_size - size, size);
>>           g_free(path);
>>           g_free(name);
>>           if (ret < 0) {
>>               error_setg(errp, "could not load romfile \"%s\"", nd->romfile);
>>               return;
>>           }
>> -        memory_region_add_subregion(&nd->slot_mem, NUBUS_SLOT_SIZE - size,
>> +        memory_region_add_subregion(&nd->slot_mem, NUBUS_SLOT_SIZE - align_size,
>>                                       &nd->decl_rom);
>>       }
>>   }


ATB,

Mark.


