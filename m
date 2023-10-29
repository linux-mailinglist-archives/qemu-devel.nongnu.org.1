Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 445137DAC7C
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 13:45:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx598-0001GW-Ik; Sun, 29 Oct 2023 08:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qx595-0001G1-V3
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 08:44:00 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qx594-0003Hh-3o
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 08:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RL3LPmfde4RruY2Gy+cHATarxPM1hGW3WFgNxSPYI28=; b=ODBvBuLq5wn6PFDaiuXuKosP7D
 aakJssUbLzwHQXCpVAa6wKeqVoj50+HomleENFtTPGmaog3ZlfcCbWHbR8baG2R46Kw4EMtsBzF+g
 qD1yOjy9iCXFRvbUhBiDg6d0e8L2io/ZMYpcG9DRUMznwwKb/5TQGhHMvwW+6BXZBE6xnKVKyVB8m
 9m1X+VkeZOAKKhvT7f1tTxTOXNJweD4eir6/JgmOm8hu0lh8tmWO0B8p1Lr5THSNorfcZMdMa8Kv+
 t6K7sBFL7gfp/6p89C5UiQaYrJkwqtKnYJy7udcg6LbYO+VXEIGv2Lo/82UUasYjhR3biWvJoiD2m
 QeC+6BO8hfLxWdHcZ6QABkS1xJmKqOYLtykYokxVfN3kDcAkfGEiyeWcL201VVZ8Bed24EKqsYkZC
 B1zs4kLgRFRqdCK2qeHOeeSxgrbr7LA8BF+oN/0p03OaywlDYyWlU+tOFgTJPCpvWbNDwrdzVuj4r
 wL6jO4zt6zhTsAcjt+TccSbvE+B5psBn97jNVM/iigNXH747JzO9FAvdrrom95r+Qc9cSJSffVnWf
 nJiJG21/1avE3MEgFlhuWAuAuWbqOuYGg9dQ9H2Ht/+yGoHt1TX5T45LOsWk0JgEcQDLC+qRWqnNK
 mZMDxTYQtwkoHZcpbHlMQ1CuA5nDIGMnF/+ZsZUdw=;
Received: from [2a00:23c4:8bb0:5400:ad26:a874:94a:370e]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qx58o-0001Mt-5D; Sun, 29 Oct 2023 12:43:45 +0000
Message-ID: <03f52ea1-7436-4129-bd53-e14104a9e74e@ilande.co.uk>
Date: Sun, 29 Oct 2023 12:43:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, vr_qemu@t-online.de
References: <cover.1698536342.git.balaton@eik.bme.hu>
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
In-Reply-To: <cover.1698536342.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:5400:ad26:a874:94a:370e
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/4] Fix IRQ routing in via south bridge
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

On 29/10/2023 00:56, BALATON Zoltan wrote:

> This is going back to my otiginal proposal in
> https://patchew.org/QEMU/cover.1677004414.git.balaton@eik.bme.hu/
> implementing routing of interrupts from device functions and PCI
> devices to ISA interrupts. On pegasos2 the firmware sets evertyhing to
> share IRQ 9 so the current simpified version worked for taht but with
> the amigaone machine its firmware makes use of this feature and
> assigns different interrupts to functions and PCI devices so we need
> to properly impelent this.

<quote>
> Since any ISA interrupt can be controlled
> by any interrupt source (different functions of the multifunction
> device plus the 4 input pins from PCI devices) there are more than 4
> possible sources so this can't be handled by just the 4 PCI interrupt
> lines. We need to keep track of the state of each interrupt source to
> be able to determine the level of the ISA interrupt and avoid one
> device clearing it while other still has an interrupt.
</quote>

This here is the important bit, since what you're describing here is exactly how PCI 
interrupts in QEMU work, and so is already handled by the existing PCI IRQ routing 
code. It seems to me that what you're doing here is creating an incomplete 
re-implementation of part of the PCI interrupt logic in isa_irq_state, which is a 
strong hint that this is the wrong approach and that you should be making use of PCI 
IRQ routing.

> This fixes USB on amigaone and maybe other bugs not discovered yet.

Given that the AmigaOne machine is new, can you explain in a bit more detail what the 
difference is between the Pegasos2 and AmigaOne machines, particularly with respect 
to where the existing IRQ routing logic is getting this wrong?


ATB,

Mark.


