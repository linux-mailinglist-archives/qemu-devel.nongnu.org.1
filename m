Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E359F20DE
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Dec 2024 22:01:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMZEm-0002rV-3s; Sat, 14 Dec 2024 15:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tMZEj-0002qz-PN
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 15:59:41 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tMZEf-0002ay-Iw
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 15:59:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Zqt8crQgIcZTWZRqVqnhQzBa0zPymKNTfWbIpyqR1K8=; b=ZX8kcA4NXgA0jzkGlywaMp5aPX
 tKY1CCCiNPQc8fcUGIUFNx+69QAd7bnueiz4hHcTLiJqwsCONcx2z63exfa85cHYVRuLTE/Fikwxm
 2ImH24T7CuIZ21rkO6Z8CJGieifHDFZFjR5kr9GjDhn4ASQ75WHFERYGCP0E2z5zi7V312L/SIMM5
 hOopK3cJsxG+V1oocdkk7pD7/FncLy54NMMRvLf/PTiYKLUTZo8iOs4MTKELw9BbWFYqLLobT9RTa
 y2EeJuM/kQOi1mHzYfvAGXDL2b3rRgDTUNe51CJ0tZVA64D7syF4QxipcZJRTPjXiKFY1PSfSmJjG
 tbUWwnJaeIYA75gjloOfUM3E9Mv6KKPB+F6MhFB5YF/Vdl4Fe26On4BJ+upOSeHvkUlBs3mprSdoo
 NVIzuP+QLKDJR3A122+D+EdXTDeF8SA8ieVwUnHlId8/AvG1RZSSRaDu3I0IgNvPrnwhB7xl0hjmv
 P41q2o6+c+MPGN6VfC98nI9oDwO95wN7cbw6UvmEs6MAVLdOj+sjCXWSYgflaILPm4/IBAp6ufamC
 I9Cji9pzfkqPVafWsH+gmF1F2Vz2xNuaulQ9k2+A6EwaCdBc8oJa+fi4nN+KU69h21oUjIJ6DP+sQ
 bgJESUnFuhT4IrAtz0OZbVk8oKOTndqp3ZFv1KLis=;
Received: from [2a02:8012:2f01:0:839f:b883:9bde:613a]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tMZE3-00065L-Q6; Sat, 14 Dec 2024 20:59:03 +0000
Message-ID: <f5eb4ef4-3563-4792-911c-767118e1c5e9@ilande.co.uk>
Date: Sat, 14 Dec 2024 20:59:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-3-mark.cave-ayland@ilande.co.uk>
 <20241213203722.62490442@tpx1>
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
In-Reply-To: <20241213203722.62490442@tpx1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:839f:b883:9bde:613a
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 02/34] next-cube: remove overlap between next.dma and
 next.mmio memory regions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13/12/2024 19:37, Thomas Huth wrote:

>   Hi Mark!
> 
> Am Thu, 12 Dec 2024 11:45:48 +0000
> schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
> 
>> Change the start of the next.mmio memory region so that it follows on directly
>> after the next.dma memory region. Increase the address offsets in
>> next_mmio_read() and next_mmio_write(), and reduce the size of the next.mmio
>> memory region accordingly.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/m68k/next-cube.c | 28 ++++++++++++++--------------
>>   1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
>> index 0418fbc8aa..550e7f0b0a 100644
>> --- a/hw/m68k/next-cube.c
>> +++ b/hw/m68k/next-cube.c
>> @@ -266,23 +266,23 @@ static uint64_t next_mmio_read(void *opaque, hwaddr addr, unsigned size)
>>       uint64_t val;
>>   
>>       switch (addr) {
>> -    case 0x7000:
>> +    case 0x2000:    /* 0x2005000 */
>>           /* DPRINTF("Read INT status: %x\n", s->int_status); */
>>           val = s->int_status;
>>           break;
>>   
>> -    case 0x7800:
>> +    case 0x2800:    /* 0x2007800 */
>>           DPRINTF("MMIO Read INT mask: %x\n", s->int_mask);
>>           val = s->int_mask;
>>           break;
>>   
>> -    case 0xc000 ... 0xc003:
>> -        val = extract32(s->scr1, (4 - (addr - 0xc000) - size) << 3,
>> +    case 0x7000 ... 0x7003:    /* 0x200c000 */
>> +        val = extract32(s->scr1, (4 - (addr - 0x7000) - size) << 3,
>>                           size << 3);
>>           break;
>>   
>> -    case 0xd000 ... 0xd003:
>> -        val = extract32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
>> +    case 0x8000 ... 0x8003:    /* 0x200d000 */
>> +        val = extract32(s->scr2, (4 - (addr - 0x8000) - size) << 3,
>>                           size << 3);
>>           break;
>>   
>> @@ -301,25 +301,25 @@ static void next_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>>       NeXTPC *s = NEXT_PC(opaque);
>>   
>>       switch (addr) {
>> -    case 0x7000:
>> +    case 0x2000:    /* 0x2005000 */
> 
> Comment should be /* 0x2007000 */ instead.
> 
> With that fixed:
> 
> Reviewed-by: Thomas Huth <huth@tuxfamily.org>

Ooops yes, thanks for spotting this. I'll fix it in v3.


ATB,

Mark.


