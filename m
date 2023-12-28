Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F58A81FA86
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 19:44:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIvLq-0007Xi-1Z; Thu, 28 Dec 2023 13:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rIvLg-0007XQ-Ec
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 13:43:17 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rIvLe-00022G-36
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 13:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pqbXWMuSIpP8kFL/dvwOcCHA5a23SyRraorZl8jfzt0=; b=fpwh8QPmTadn0Ml8OcOy3qcWsV
 r0XZdwqQe73rSmvZdG+BDlcdrXhTLChAryO2L97B2AkRWoNCNO+jkmSgUyS7ww5PufzvOYPx2JAPH
 ExALKMaKK30ik9y0fZhp7DoXvj72GKdp+AyZuooF0QSfhiMU19/sCWkpmPn3TCp9y/OYlef/PThan
 ivSTk2Nna2Cm38r/WqYoM63DFEmFwj79B6oh1cVsfEYoRXohIi2ww1Ckay8nIPgp2yeShy7uSEjwY
 BJeVM8qPpzcoeY+cZj3LISvo2UR9JFmy7WlEvqUrINlhzCRG1YNoRwd1PHkINPrtzgmQFV5XfqGwi
 Pgs2qbollESNlIU4KXJZ7rCdAZiWRrtjKIyV1lzwZBIkpynhSfjD8s/utTcJIjq/ZTmtajhh1t9XO
 Rc+23u8q/AhK/vLypRH9pzpF0Mjl1cHLiyXKfpgH7GGBo30eB0F9ul9XBacpvNyxFre7ZlOPdbuFM
 ZFgJy0XAm/0BtqdtJO0U/CzQHNz+V39TEPIcuQFEBFzTybeyxVATI9XLg8YDgcVG2eKdCH+/g/W6x
 oz+3nYwPQsXJsVwfs7O8N9+Dl8zPkQhOxKhZxvYLF7GXmuwdEMEOYYuxMvkZ/XuTl7bpQD52cuvOm
 mMjW8I0TV5Pn+ACH5Mk6M6PtpMLmXSqEAxH2ElFM4=;
Received: from [2a00:23c4:8bb0:f100:50bd:52e3:a1af:1994]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rIvL7-00088k-2V; Thu, 28 Dec 2023 18:42:45 +0000
Message-ID: <de94c822-c40d-430f-8b3a-8856031e5470@ilande.co.uk>
Date: Thu, 28 Dec 2023 18:43:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 laurent@vivier.eu, huth@tuxfamily.org, qemu-devel@nongnu.org
References: <20231227210212.245106-1-mark.cave-ayland@ilande.co.uk>
 <42274b2d-5917-4add-a610-c1973bc1697d@linaro.org>
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
In-Reply-To: <42274b2d-5917-4add-a610-c1973bc1697d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:f100:50bd:52e3:a1af:1994
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] q800: move dp8393x_prom memory region to Q800MachineState
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

On 28/12/2023 09:46, Philippe Mathieu-Daudé wrote:

> On 27/12/23 22:02, Mark Cave-Ayland wrote:
>> There is no need to dynamically allocate the memory region from the heap.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/m68k/q800.c         | 7 +++----
>>   include/hw/m68k/q800.h | 1 +
>>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> 
>> @@ -406,13 +405,13 @@ static void q800_machine_init(MachineState *machine)
>>       sysbus_connect_irq(sysbus, 0,
>>                          qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_SONIC));
>> -    memory_region_init_rom(dp8393x_prom, NULL, "dp8393x-q800.prom",
>> +    memory_region_init_rom(&m->dp8393x_prom, NULL, "dp8393x-q800.prom",
>>                              SONIC_PROM_SIZE, &error_fatal);
>>       memory_region_add_subregion(get_system_memory(), SONIC_PROM_BASE,
>> -                                dp8393x_prom);
>> +                                &m->dp8393x_prom);
>>       /* Add MAC address with valid checksum to PROM */
>> -    prom = memory_region_get_ram_ptr(dp8393x_prom);
>> +    prom = memory_region_get_ram_ptr(&m->dp8393x_prom);
>>       checksum = 0;
>>       for (i = 0; i < 6; i++) {
>>           prom[i] = revbit8(nd_table[0].macaddr.a[i]);
> 
> Similar pattern in mips_jazz_init(). I wonder if we can extract the
> PROM checksums in a common helper declared in "hw/net/dp8393x.h".

That used to be the case before I added the support for the q800 machine, however the 
encoding of the MAC address and checksum are completely different between the jazz 
and q800 machines. The misleading part is the memory regions have been created with a 
_prom suffix and AFAICT the SONIC doesn't have any on-board NVRAM at all, so my guess 
is that the MAC address is stored in per-machine non-volatile memory.

> Anyhow for this patch:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!


ATB,

Mark.


