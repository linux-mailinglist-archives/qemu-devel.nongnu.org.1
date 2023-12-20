Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0907B81A752
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 20:37:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG2N4-0006RG-FE; Wed, 20 Dec 2023 14:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rG2Mz-0006Qv-E8
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 14:36:41 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rG2Mw-0001Ts-SI
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 14:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gS7Qa7U7BIHgMzueSA/FZ5ZYpQMKx2yrfbMlNjMUEjw=; b=tzBRlaAhqmxg/MVgFSMZfOGucC
 oVDHjaWSI7xHAvdw0bZobn0kW3pHJTuH21SZDNFE6C5d1xVzldN7PbuY5QPlcy3QCvFXdPnODCqxF
 sLCW+sSpVkp5CYOfM924x1azglLJuAqmR2ELp3IGTNFTOF0eT0QN1q/jId9Iy4Dfo7+gcCalj1HWT
 n5yzxcvesUkMSS5Z4fXOjDZDxG2k93apcF8ZDnW5Lvs8+5s1VspAteDdC4TGLeL02ti0FMD6Ocpbt
 dckr6EpUIRIZwhTVnnSqqz1PHhMsI+CQkn3RmYx6Xx7yVBnFyG7rhr8yQse4j7i5I6cC8LD5XOmgc
 gp29HdyVm0Off9x1QrwXx+Pq1ETzSDLe0fOnkepscZPZlnd3ZoE81XpFwCMsIon7Xfd7HB2afvxQo
 TPJoChzbSsEmfdcnKO9+n0AquFDpEZFvF0uMb4LjYQ/GAgJxAVgI7qOiB6JfBzGZCOtuYAhj6JHsH
 Jy8gZUy7+PTT5AqMv/tZ51w0KWt6snei9Uxm8Sa1otTSuYnzqV53JTZcGKxaw7/6dgyL2H3sq0pGK
 PHXP6HyCmT234FQS+UtAvPrylW8ythVIpH70Wgh61aJ5QQI8Y1o4aJvAMWU1uPC5WKnrAEd5eFcPu
 otyp5BW6pDKljXXraKBn5J1I3EIYhlj2KSquVLpy8=;
Received: from [2a00:23c4:8bb0:f100:5056:7a9a:2d6c:4a1d]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rG2MS-0004RD-9U; Wed, 20 Dec 2023 19:36:12 +0000
Message-ID: <843e4a2f-ebf6-4d4f-857e-1ecfe82625ce@ilande.co.uk>
Date: Wed, 20 Dec 2023 19:36:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org
References: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
 <20231220131641.592826-9-mark.cave-ayland@ilande.co.uk>
 <20231220202012.34ce2b0a@fedora>
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
In-Reply-To: <20231220202012.34ce2b0a@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:f100:5056:7a9a:2d6c:4a1d
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 08/11] next-cube.c: move static old_scr2 variable to
 NeXTPC
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

On 20/12/2023 19:20, Thomas Huth wrote:

> Am Wed, 20 Dec 2023 13:16:38 +0000
> schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
> 
>> Move the old_scr2 variable to NeXTPC so that the old SCR2 register state is
>> stored along with the current SCR2 state.
>>
>> Since the SCR2 register is 32-bits wide, convert old_scr2 to uint32_t and
>> update the SCR2 register access code to allow unaligned writes.
>>
>> Note that this is a migration break, but as nothing will currently boot then
>> we do not need to worry about this now.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/m68k/next-cube.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
>> index f2222554fa..d53f73fb8b 100644
>> --- a/hw/m68k/next-cube.c
>> +++ b/hw/m68k/next-cube.c
>> @@ -91,6 +91,7 @@ struct NeXTPC {
>>   
>>       uint32_t scr1;
>>       uint32_t scr2;
>> +    uint32_t old_scr2;
>>       uint32_t int_mask;
>>       uint32_t int_status;
>>       uint32_t led;
>> @@ -125,8 +126,7 @@ static const uint8_t rtc_ram2[32] = {
>>   
>>   static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
>>   {
>> -    static uint8_t old_scr2;
>> -    uint8_t scr2_2;
>> +    uint8_t old_scr2, scr2_2;
>>       NextRtc *rtc = &s->rtc;
>>   
>>       if (size == 4) {
>> @@ -144,6 +144,8 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
>>           }
>>       }
>>   
>> +    old_scr2 = (s->old_scr2 >> 8) & 0xff;
>> +
>>       if (scr2_2 & 0x1) {
>>           /* DPRINTF("RTC %x phase %i\n", scr2_2, rtc->phase); */
>>           if (rtc->phase == -1) {
>> @@ -252,7 +254,6 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
>>       }
>>       s->scr2 = val & 0xFFFF00FF;
>>       s->scr2 |= scr2_2 << 8;
> 
> So s->scr2 is updated with the "val" at the end of nextscr2_write() ...
> 
>> -    old_scr2 = scr2_2;
>>   }
>>   
>>   static uint64_t next_mmio_read(void *opaque, hwaddr addr, unsigned size)
>> @@ -318,7 +319,10 @@ static void next_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>>           break;
>>   
>>       case 0xd000 ... 0xd003:
>> +        s->scr2 = deposit32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
>> +                            size << 3, val);
> 
> ... but here it is also updated before nextscr2_write() ? Looks somewhat
> strange. Though I have to admit that I don't fully understand the logic
> here anyway... Maybe we could peek at Previous to see how this register is
> supposed to behave?

I'm fairly sure what's supposed to happen is that bits 8-15 of SCR2 are used to 
bit-bang the RTC and all the other values are preserved, hence the logic at the end 
of nextscr2_write(). What makes it slightly more confusing is that scr2_2 and 
old_scr2 in the current version of nextscr2_write() represent just bits 8-15 of SCR2 
and not the entire register.

This is something I tried to improve in the following 2 commits by splitting out the 
LED logic into its own function, and then finally updating old_scr2 to a 32-bit value 
to match scr2 and using extract32()/deposit32() in next_scr2_rtc_update() to make 
this process clearer.


ATB,

Mark.


