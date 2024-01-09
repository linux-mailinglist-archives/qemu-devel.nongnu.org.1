Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 993BD828F4C
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 22:54:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNK2f-0007L1-NR; Tue, 09 Jan 2024 16:53:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNK2d-0007Kb-Dr
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:53:48 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNK2Z-0005k4-G6
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6Gp2sGV1o/qqM9GlxWOdN9EuqntXEM7LNT1DOO+qMXg=; b=SHlbvU13R4wG0Su+p0CtLxe+YS
 NIgDibvirVzGPN5WENQ11sMbZG8U/pxYF2tWWGLkS3AtEeqDKNTS9B38q7uTmTvQWEP0be4WQXkZ6
 dtsfd8HEHtlWZK8qSL2J+mCyX74x3Rw+nMCnlZja/c5p89NkVNZICizBqaHi8V6TmRmezO+IFSpta
 Tjt6TrTubtHsol7cFNGb49VJV1RHrx2z5d4SNCSzTzXbwkl6Iy2coJmfG9fFbg/cjyb0byIMGxawN
 wQVyouQZVWihzQLBYOhtOjAVMNUMH1zkb4UDvKSH03SbCG+D3vW4aJhsfSgO7RfTITOnp7VuQOQLE
 hnNDE/iKByrV337G0xSWdtTllCVEdxYzzQ/R7NdO7Zf4FN3whNthb6bcYq2gs2BlIbhisYD7JgRYT
 MnRqXjSjrrw6vPDMfsHRRSCpD//onn/dc3nV9YmMBVyGUSLZ52nlg9CMjd+isIWUDKcFrRa1ZpYvc
 tzOBbnyGLVQcE1H+IOZyWvn/9+X18rzOsHZkZlJOjM8IF0mPpKF/dadEtZl7EbAJFb1sX5XlCpYea
 oan3m7W8am2pOQO7i7BCGeB+rGtTkKEUQDQf+gpI6FjKhBvax6Z12IBe4ChJI7+pSyyhVanlc5jkt
 hNmBMKxDKj8vZdvcwBnvJjffnPxAuziA2wXg/VNFA=;
Received: from [2a00:23c4:8bb1:9800:b804:1635:e423:adbd]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNK1n-000BFT-0U; Tue, 09 Jan 2024 21:52:59 +0000
Message-ID: <0c609e08-9f03-4dbb-a667-611b4ded7fb4@ilande.co.uk>
Date: Tue, 9 Jan 2024 21:53:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 laurent@vivier.eu, qemu-devel@nongnu.org, elliotnunn@fastmail.com
References: <20240108192013.272112-1-mark.cave-ayland@ilande.co.uk>
 <20240108192013.272112-2-mark.cave-ayland@ilande.co.uk>
 <cc1c2370-e516-478b-abfa-620cc8542118@linaro.org>
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
In-Reply-To: <cc1c2370-e516-478b-abfa-620cc8542118@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb1:9800:b804:1635:e423:adbd
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 1/2] nubus-device: round Declaration ROM memory region
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

On 08/01/2024 23:06, Philippe Mathieu-Daudé wrote:

> On 8/1/24 20:20, Mark Cave-Ayland wrote:
>> Declaration ROM binary images can be any arbitrary size, however if a host ROM
>> memory region is not aligned to qemu_target_page_size() then we fail the
>> "assert(!(iotlb & ~TARGET_PAGE_MASK))" check in tlb_set_page_full().
>>
>> Ensure that the host ROM memory region is aligned to qemu_target_page_size()
>> and adjust the offset at which the Declaration ROM image is loaded, since Nubus
>> ROM images are unusual in that they are aligned to the end of the slot address
>> space.
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
> 
> Both are 'size_t'.

I had a look at include/hw/loader.h, and the function signature for get_image_size() 
returns int64_t. Does it not make sense to keep int64_t here and use uintptr_t for 
the pointer arithmetic as below so that everything matches?

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
> 
> memory_region_get_ram_ptr() returns a 'void *' so this looks dubious.
> Maybe use a local variable to ease offset calculation?
> 
>    char *rombase = memory_region_get_ram_ptr(&nd->decl_rom);
>    ret = load_image_size(path, rombase + align_size - size, size);
> 
> Otherwise KISS but ugly:
> 
>    ret = load_image_size(path,
>              (void *)((uintptr_t)memory_region_get_ram_ptr(&nd->decl_rom)
>                       + align_size - size), size);

I prefer the first approach, but with uint8_t instead of char since it clarifies that 
it is a pointer to an arbitrary set of bytes as opposed to a string. Does that seem 
reasonable?

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


