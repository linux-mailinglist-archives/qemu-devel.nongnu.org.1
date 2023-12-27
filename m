Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE2581F1BD
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 21:04:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIa7K-00044b-Mn; Wed, 27 Dec 2023 15:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rIa7I-00040d-BP
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 15:03:00 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rIa7G-00015h-NB
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 15:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z2SPXUVBOZw2vV+4t9hmVcQQQ9+NF8WftV6kjwQyzIc=; b=kfDsskehbtGcxKsHE2j/ca+FQz
 NgSozyJChcyP8c/OT6oWEhTaLuNsp7Tnge3sZ5FjLjzJVM7xTlhj8m+6JbANQnCsptgTARz//Pel/
 z6Tt2sfOhf89u7mYdWGkoB2lY+PwhCN3jIuREn6gVkPFmSpGU4+HRyfoliLfO9NiVzgwN2IuHIe2U
 sYlNX/82aamyXrOBSLOZyfjDiiszXMD+qkXc+LIhW60ryurHX4jNmHC7v86r7Al7GGBOqx7AVafCd
 yDWoy0sNVCCTDcy5xR+TAT/4wtBKJMMwYa1BkYXeFJdZdjGuVeyT6wW/1oFQ4e1YmRtixWfTXE8nr
 +q251ro+vGxe9qc8ovSV9QESjVkmAEJxTc2zYgAwyRidunHp7q8EfhLJ7StpWG5Ay6705DRhypXrx
 /fMJPZJ6O64suFkeToZYr43xYOBcuwp5kLH8y8q6DVfyMtDFRUwJOEN27ojXP2m2xXCGSN6Hvh1aj
 StnjWf8zoquabLGK5HFqQWn4/GmUlS5p2hvB8NtGD6++oahnFWiAtclS2I1H+nH8glcFc+KRLxHRo
 DONDHn1L+HVnFyMNjjOntMI622zfkFIS0tVSnAmaUy+bHj9G8qjWmIo3R8UkGJEriN/zB2t0X/0VA
 QcIyTq2QKhkaq742opA5ZXPLOI2Jr6njawNad4gbk=;
Received: from [2a00:23c4:8bb0:f100:68ed:6797:e32e:ab13]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rIa6Z-0000T6-Io; Wed, 27 Dec 2023 20:02:19 +0000
Message-ID: <a5dd59b0-1b49-4a96-8c82-8383412afdc3@ilande.co.uk>
Date: Wed, 27 Dec 2023 20:02:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandra Diupina <adiupina@astralinux.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
References: <20231218150213.27253-1-adiupina@astralinux.ru>
 <e05e239f-2d1d-4d9b-86bb-a1e9d9b98550@linaro.org>
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
In-Reply-To: <e05e239f-2d1d-4d9b-86bb-a1e9d9b98550@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:f100:68ed:6797:e32e:ab13
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] esp: process the result of scsi_device_find()
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

On 26/12/2023 12:08, Philippe Mathieu-Daudé wrote:

> Cc'ing Mark for the logical change (should we rather assert?).
> 
> On 18/12/23 16:02, Alexandra Diupina wrote:
>> Add a 'current_lun' check for a null value
>> to avoid null pointer dereferencing
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: 4eb8606560 (esp: store lun coming from the MESSAGE OUT phase)
>> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
>> ---
>>   hw/scsi/esp.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>> index 9b11d8c573..3a2ec35f9b 100644
>> --- a/hw/scsi/esp.c
>> +++ b/hw/scsi/esp.c
>> @@ -292,6 +292,11 @@ static void do_command_phase(ESPState *s)
>>       esp_fifo_pop_buf(&s->cmdfifo, buf, cmdlen);
>>       current_lun = scsi_device_find(&s->bus, 0, s->current_dev->id, s->lun);
>> +
>> +    if (!current_lun) {
>> +        return;
>> +    }
>> +
>>       s->current_req = scsi_req_new(current_lun, 0, s->lun, buf, cmdlen, s);
>>       datalen = scsi_req_enqueue(s->current_req);
>>       s->ti_size = datalen;

Checking for the NULL return from scsi_device_find() looks correct to me, but I don't 
think that a simple return will allow the host to recover. I suspect the right thing 
to do here is to duplicate the scsi_device_find() logic just above i.e. set the 
INTR_DC bit and then raise the IRQ if NULL is returned.


ATB,

Mark.


