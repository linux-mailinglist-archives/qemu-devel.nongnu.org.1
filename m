Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0797DC136
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 21:31:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxYuB-0005Xx-JX; Mon, 30 Oct 2023 16:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qxYu3-0005XG-0p
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 16:30:28 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qxYu0-00068b-Vz
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 16:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lrhvQydU4gI1WI2CFHVpegGwGYJ0vV/OL1fr0ofwbNU=; b=Hv0vK/3OuUh+Q9NxwmGMHBxyO5
 JSr+onpYHYCf+t3fr5T2kRm6O7QyRCfEBIqs+6/nXEHE2qNs2Bzp1KQzCDde5ia54ZJvYO681+oSV
 3I5IErICn+Koo4X6t44kUwZ4AwXY4+X4xVUciK7RVtSsd7Hsurkfi6eo6VGDu+C7IeveG5VMRZycs
 WSyhpPVbK7jIWtzZn4eMTUGydjXvQohUcAHIM0eW80TAsb2XVL2zWTmIkTOzSpYcCOIw6zrTcT+EA
 iytLz9TUuuc+bnmzWSMlvDP2g9xvZ+eS/mt+Sj9C1iJMw8oi0aNsyYFT6XU0uLUWc9P/5Zwny+lGA
 Tz0hN31wuYXkFHhRiMMdgLigG+3MRvZ17IuZtDqDfEgUTPMYSYyNvNs73wmBULnG74fAfnEu/XS8L
 Nlh/HPiSUUMlzB2+udoIP/r1kdZbbmZsWeQZ2ILB+uJfizfJhiFQ9Dses9CAvvhSDkg6PtYSyCjpb
 S2PfV9S7cvUp3WeyPOV7Xi2cZIIb6w9BVJfNtNh4tb5pYxlxfGqoQcXAEhrExmwVz9tDzTK6luhFG
 IjN/Jzw+UyLme3jAQ4b2kqtAGKJ7QeM9c9c8oFEU8AkV8jb/O7A62jaHzt/ClzZRAcEpEWUe/dZ1y
 t5/mGkidjA5q91hNaEYXbrcc7DVNyaNNK0WWkUghE=;
Received: from [2a00:23c4:8bb0:5400:5ff2:9176:6cc5:bf69]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qxYtk-000Cjk-O6; Mon, 30 Oct 2023 20:30:12 +0000
Message-ID: <e8a8425a-d824-44da-a2b1-3187f01d59cd@ilande.co.uk>
Date: Mon, 30 Oct 2023 20:30:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Bernhard Beschow <shentey@gmail.com>,
 vr_qemu@t-online.de
References: <cover.1698536342.git.balaton@eik.bme.hu>
 <03f52ea1-7436-4129-bd53-e14104a9e74e@ilande.co.uk>
 <0f4b0c4b-9229-dcc5-d12a-3f423c316f80@eik.bme.hu>
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
In-Reply-To: <0f4b0c4b-9229-dcc5-d12a-3f423c316f80@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:5400:5ff2:9176:6cc5:bf69
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

On 29/10/2023 13:45, BALATON Zoltan wrote:

> On Sun, 29 Oct 2023, Mark Cave-Ayland wrote:
>> On 29/10/2023 00:56, BALATON Zoltan wrote:
>>
>>> This is going back to my otiginal proposal in
>>> https://patchew.org/QEMU/cover.1677004414.git.balaton@eik.bme.hu/
>>> implementing routing of interrupts from device functions and PCI
>>> devices to ISA interrupts. On pegasos2 the firmware sets evertyhing to
>>> share IRQ 9 so the current simpified version worked for taht but with
>>> the amigaone machine its firmware makes use of this feature and
>>> assigns different interrupts to functions and PCI devices so we need
>>> to properly impelent this.
>>
>> <quote>
>>> Since any ISA interrupt can be controlled
>>> by any interrupt source (different functions of the multifunction
>>> device plus the 4 input pins from PCI devices) there are more than 4
>>> possible sources so this can't be handled by just the 4 PCI interrupt
>>> lines. We need to keep track of the state of each interrupt source to
>>> be able to determine the level of the ISA interrupt and avoid one
>>> device clearing it while other still has an interrupt.
>> </quote>
>>
>> This here is the important bit, since what you're describing here is exactly how 
>> PCI interrupts in QEMU work, and so is already handled by the existing PCI IRQ 
>> routing code. It seems to me that what you're doing here is creating an incomplete 
>> re-implementation of part of the PCI interrupt logic in isa_irq_state, which is a 
>> strong hint that this is the wrong approach and that you should be making use of 
>> PCI IRQ routing.
> 
> I don't see how this can be handled by the PCI interrupt routing which only considers 
> 4 lines while in VIA we have more sources than that which are the chip functions 
> (some even with more than one IRQ like IDE) and the 4 PCI interrupt inputs and these 
> can be routed to any of the ISA IRQs independently (there's a register for each of 
> them, the funcs use thi interrupt line config reg and the PCI pins the regs in the 
> ISA func). So how would PCI handle this when it only sees the 4 PCI interrupt lines 
> but not the chip functions as separate sources? You've assumed that those functions 
> must be PCI devices too but their interrupts are routable separately from the PCI 
> interrupts so you can have PCI INTA-D mapped to IRQ 7,8,9,10 and USB func mapped to 
> IRQ 5 (like amigaone does) so you can't use PCI interrupt for the USB too but have to 
> consider all of these separately and route them in the ISA bridge.

Ah so the restriction here is the number of PCI interrupt lines? That can be done by 
increasing the number of PCI bus IRQs to 4 + N, where 0-3 represent INTA-D and the N 
others represent individual functions on the in-built devices. You can then determine 
the slot/function in the PCI map IRQ function to route to the appropriate N IRQ.

>>> This fixes USB on amigaone and maybe other bugs not discovered yet.
>>
>> Given that the AmigaOne machine is new, can you explain in a bit more detail what 
>> the difference is between the Pegasos2 and AmigaOne machines, particularly with 
>> respect to where the existing IRQ routing logic is getting this wrong?
> 
> The pegasos2 firmware sets all chip functions and PCI devices (except IDE which is 
> hard coded to legacy interrupts) to IRQ 9 so it worked with mixing PCI interrupts 
> with chip functions but the amigaone does not do that and sets different ISA 
> interrupts to chip functions and PCI interrupts so the current simplified version 
> cannot work with that any more and we need to allow separate routing of all the 
> interrupt sources. (Additionally we need to keep interrupt state for each source to 
> allow multiple sources to control the same ISA interrupt.) I could not think of any 
> simpler way than my patch to correctly implement this.

The key point of interest is that we have PIIX that basically already works using the 
existing PCI IRQ routing APIs: the aim is to do something similar with VIA, or to 
tweak the existing APIs if needed to make it possible. Otherwise you end up with the 
situation in this series in which you're effectively inventing a parallel form of PCI 
IRQ routing just for the VIA ISA bridge and hardcoding it into the in-built VIA devices.

The benefit of using the PCI IRQ routing APIs is that it is also possible to plug in 
the individual PCI device/functions using -device into any PCI bus for testing, which 
is something that is already done with PIIX-IDE.


ATB,

Mark.


