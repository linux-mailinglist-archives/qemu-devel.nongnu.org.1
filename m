Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8177EA507
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 21:47:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2dp0-0008Kc-Aa; Mon, 13 Nov 2023 15:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r2dog-0008GU-4c; Mon, 13 Nov 2023 15:46:06 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r2dod-0000qt-N4; Mon, 13 Nov 2023 15:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b02Ys35bWVqBae8XkHFzWwCmv2gK/zDwbyvoFWFLwnc=; b=Vu01Gx7NBO6LA7xN0WVvmQGty4
 Sb42+7IPnaRDrCOi85L783ZDmnKsZxu7zuIpXhu61gFzLOk0s5BrG8KhV9YLcpg33292aaL2iplRd
 Pr3hILWVfX4F6Iegae7IgaU23psWKSZak5m2mmkBgBk1/Grs/uf+FSa7CoExui7EeaFT6Beq18Uyp
 AgKcpn72wZCBaGYRPaCOS7eoCn7NjbgWm+FlS6M3SAHzdV0C5ciPG53gAcc+zzmPVm8/HpRatV7cr
 pUoqI4DfxVAfOcJBfwu/KuK7o50fjAscatf09//zSQCp6lMnM2XZo06VLCYR5lzp6VzNUAYRcj+Yp
 SFFVVEVMd9BKKNBsffFFUFwATPpFzWNHJiHcUEXXu+Zuhqqp9T5jvGYGMCV5czybS/c50hUTbGsg2
 MlmHP3+1HVL18JJc9PpH2ghpOsB9ApOW16bIMYzMC/9RUepNfdMCfvCKXE4zUnWP0/+BPpQjRImFl
 YmPG/Rxe/CpMB1tdsdaWzf2F7E6JMh5uDbVV1/CG76ooGw74rp7vuRLeT9hDg/fTED/Am7OHu8ySm
 el/53tO25SL83Vn+WHbR+TjSXdJgZ/m4+2PzvEzi7OkEagSHVo2QneKMFza/bet0xTECTn0++/XgT
 003kQAVLQOLrnK8HBAwNOg5IRBEXEJi2/n2vj/pxk=;
Received: from [2a00:23c4:8bb0:5400:961f:a486:b7:ef79]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r2doF-0004Hj-PM; Mon, 13 Nov 2023 20:45:31 +0000
Message-ID: <c7f90ce2-7f9d-4219-be11-04c98dddc6cf@ilande.co.uk>
Date: Mon, 13 Nov 2023 20:45:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kevin Wolf <kwolf@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 philmd@linaro.org, shentey@gmail.com
References: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
 <20231024224056.842607-4-mark.cave-ayland@ilande.co.uk>
 <ZUj5yTKBkJ99Dbxf@redhat.com>
 <509075f4-38d2-578b-b4f4-770c3b000ae8@eik.bme.hu>
 <ZUoU4FltYjFXdWZm@redhat.com>
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
In-Reply-To: <ZUoU4FltYjFXdWZm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:5400:961f:a486:b7:ef79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 3/3] hw/ide/via: implement legacy/native mode switching
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

On 07/11/2023 10:43, Kevin Wolf wrote:

> Am 06.11.2023 um 17:13 hat BALATON Zoltan geschrieben:
>> On Mon, 6 Nov 2023, Kevin Wolf wrote:
>>> Am 25.10.2023 um 00:40 hat Mark Cave-Ayland geschrieben:
>>>> Allow the VIA IDE controller to switch between both legacy and native modes by
>>>> calling pci_ide_update_mode() to reconfigure the device whenever PCI_CLASS_PROG
>>>> is updated.
>>>>
>>>> This patch moves the initial setting of PCI_CLASS_PROG from via_ide_realize() to
>>>> via_ide_reset(), and removes the direct setting of PCI_INTERRUPT_PIN during PCI
>>>> bus reset since this is now managed by pci_ide_update_mode(). This ensures that
>>>> the device configuration is always consistent with respect to the currently
>>>> selected mode.
>>>>
>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> Tested-by: Bernhard Beschow <shentey@gmail.com>
>>>
>>> As I already noted in patch 1, the interrupt handling seems to be wrong
>>> here, it continues to use the ISA IRQ in via_ide_set_irq() even after
>>> switching to native mode.
>>
>> That's a peculiarity of this via-ide device. It always uses 14/15 legacy
>> interrupts even in native mode and guests expect that so using native
>> interrupts would break pegasos2 guests. This was discussed and tested
>> extensively before.
> 
> This definitely needs a comment to explain the situation then because
> this is in violation of the spec. If real hardware behaves like this,
> it's what we should do, of course, but it's certainly unexpected and we
> should explicitly document it to avoid breaking it later when someone
> touches the code who doesn't know about this peculiarity.

It's a little bit more complicated than this: in native mode it is possible to route 
the IRQs for each individual channel to a small select number of IRQs by configuring 
special registers on the VIA.

The complication here is that it isn't immediately obvious how the QEMU PCI routing 
code can do this - I did post about this at 
https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg10552.html asking the best 
way to resolve this, but haven't had any replies yet.

Fortunately it seems that all the guests tested so far stick with the IRQ 14/15 
defaults which is why this happens to work, so short-term this is a lower priority 
when looking at consolidating the switching logic.


ATB,

Mark.


