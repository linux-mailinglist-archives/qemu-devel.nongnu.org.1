Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A70819275
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 22:42:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFhpg-0007XG-Mi; Tue, 19 Dec 2023 16:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFhpX-0007Vm-Vs
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 16:40:48 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFhpV-0006uJ-Jh
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 16:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OSPNM977gvGXUy+xVdjzJ+rfzwRPvMdhabAiWq66Lq0=; b=RVJ+kthLfJ84Ww1YhBQf9BYyyl
 T9Z53wTm46paApb950RnJuhoUlzOjuJ/wVLb+6j/3WFfVb8WgGi/ER48esD78dFas3ea+6fxK9uWo
 cMchqTabnRhkpA347iI23LeD6zOfzHrQH+uYlcQOYCiTo0j3A+DCqunllkJibKNRmWvVSv/qZ/9Eq
 z2U5UEMn0hCTjm60eUUFQpCU+jYF9pwnezOLlKEq8OxHb5J8piOnL7T9Uaqok7cn4929Y/bxdk3OF
 wX9+qzbRpeVSRYh/a9t2gD43+ZJJbYuoW/OUgJ9pl7twrwTaQ0XcYOqEHLFcCZbVNbvIfON4M4Yci
 OkGatnNgxrT9qAf8F/JrOnrdR9k5Zw/KhWs7j4SNJ0M1PgVEDXviYHG+k2G+DViJ5DCcCGS3TpQBa
 idWVYe5UvOpfVRroG9gbj8SzT3l0mxQhUi4m2hXflR2s7xzz+g4c0uZ2CHp/Vg48eOZ0Ah8ZgwqhV
 COwfdr533aPck89ldry8ByRF64FF4KIWLpm3Udw+D4As9VE1XXAv8lt1GpFLJfhuVILoE+cB6Ypxn
 GzDjHBp3KXwQTVELVGpTxTBlMY6VjiuFL7CTERK2xoOUJ8Eiq4wGis9t/RIT27MbwMRhKrt7uG+15
 W6qi1xLZ6j/X3POQAcoUnZgyeA7+agJ8dS7pSeSZ0=;
Received: from [2a00:23c4:8bb0:f100:795a:8119:c46d:d080]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFhp0-0008V5-PE; Tue, 19 Dec 2023 21:40:18 +0000
Message-ID: <7f262038-d0cb-4496-802d-3cf238c0ea03@ilande.co.uk>
Date: Tue, 19 Dec 2023 21:40:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
 <20231215200009.346212-9-mark.cave-ayland@ilande.co.uk>
 <20231216211334.633f7684@fedora>
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
In-Reply-To: <20231216211334.633f7684@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:f100:795a:8119:c46d:d080
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 08/12] next-cube.c: move LED logic to new
 next_scr2_led_update() function
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

On 16/12/2023 20:13, Thomas Huth wrote:

> Am Fri, 15 Dec 2023 20:00:05 +0000
> schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
> 
>> Ensure that the LED status is updated by calling next_scr2_led_update() whenever
>> the SC2 register is written.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/m68k/next-cube.c | 22 +++++++++++++---------
>>   1 file changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
>> index f2222554fa..7ffd1c412e 100644
>> --- a/hw/m68k/next-cube.c
>> +++ b/hw/m68k/next-cube.c
>> @@ -123,6 +123,18 @@ static const uint8_t rtc_ram2[32] = {
>>   #define SCR2_RTDATA 0x4
>>   #define SCR2_TOBCD(x) (((x / 10) << 4) + (x % 10))
>>   
>> +static void next_scr2_led_update(NeXTPC *s)
>> +{
>> +    if (s->scr2 & 0x1) {
>> +        DPRINTF("fault!\n");
>> +        s->led++;
>> +        if (s->led == 10) {
>> +            DPRINTF("LED flashing, possible fault!\n");
>> +            s->led = 0;
>> +        }
>> +    }
>> +}
> 
> This will now operate on the old value of scr2 ...
> 
>>   static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
>>   {
>>       static uint8_t old_scr2;
>> @@ -135,15 +147,6 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
>>           scr2_2 = val & 0xFF;
>>       }
>>   
>> -    if (val & 0x1) {
>> -        DPRINTF("fault!\n");
>> -        s->led++;
>> -        if (s->led == 10) {
>> -            DPRINTF("LED flashing, possible fault!\n");
>> -            s->led = 0;
>> -        }
>> -    }
> 
> .. while this was using the new value that was just written.
> So this looks wrong to me ... or do I miss something?

Oops no, I think you're right and it's an unintended change. I'll fix this before 
sending a v2 series.

>   Thomas
> 
> 
>>       if (scr2_2 & 0x1) {
>>           /* DPRINTF("RTC %x phase %i\n", scr2_2, rtc->phase); */
>>           if (rtc->phase == -1) {
>> @@ -318,6 +321,7 @@ static void next_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>>           break;
>>   
>>       case 0xd000 ... 0xd003:
>> +        next_scr2_led_update(s);
>>           nextscr2_write(s, val, size);
>>           break;


ATB,

Mark.


