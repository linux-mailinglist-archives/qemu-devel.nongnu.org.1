Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C55C7DACAD
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 14:47:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx675-0002ay-8x; Sun, 29 Oct 2023 09:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qx66p-0002Zm-3B
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 09:45:43 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qx66m-0002ZK-FG
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 09:45:42 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 7AC097560A3;
 Sun, 29 Oct 2023 14:45:37 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F121D756088; Sun, 29 Oct 2023 14:45:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EF7D9756078;
 Sun, 29 Oct 2023 14:45:36 +0100 (CET)
Date: Sun, 29 Oct 2023 14:45:36 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Bernhard Beschow <shentey@gmail.com>, vr_qemu@t-online.de
Subject: Re: [PATCH 0/4] Fix IRQ routing in via south bridge
In-Reply-To: <03f52ea1-7436-4129-bd53-e14104a9e74e@ilande.co.uk>
Message-ID: <0f4b0c4b-9229-dcc5-d12a-3f423c316f80@eik.bme.hu>
References: <cover.1698536342.git.balaton@eik.bme.hu>
 <03f52ea1-7436-4129-bd53-e14104a9e74e@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Sun, 29 Oct 2023, Mark Cave-Ayland wrote:
> On 29/10/2023 00:56, BALATON Zoltan wrote:
>
>> This is going back to my otiginal proposal in
>> https://patchew.org/QEMU/cover.1677004414.git.balaton@eik.bme.hu/
>> implementing routing of interrupts from device functions and PCI
>> devices to ISA interrupts. On pegasos2 the firmware sets evertyhing to
>> share IRQ 9 so the current simpified version worked for taht but with
>> the amigaone machine its firmware makes use of this feature and
>> assigns different interrupts to functions and PCI devices so we need
>> to properly impelent this.
>
> <quote>
>> Since any ISA interrupt can be controlled
>> by any interrupt source (different functions of the multifunction
>> device plus the 4 input pins from PCI devices) there are more than 4
>> possible sources so this can't be handled by just the 4 PCI interrupt
>> lines. We need to keep track of the state of each interrupt source to
>> be able to determine the level of the ISA interrupt and avoid one
>> device clearing it while other still has an interrupt.
> </quote>
>
> This here is the important bit, since what you're describing here is exactly 
> how PCI interrupts in QEMU work, and so is already handled by the existing 
> PCI IRQ routing code. It seems to me that what you're doing here is creating 
> an incomplete re-implementation of part of the PCI interrupt logic in 
> isa_irq_state, which is a strong hint that this is the wrong approach and 
> that you should be making use of PCI IRQ routing.

I don't see how this can be handled by the PCI interrupt routing which 
only considers 4 lines while in VIA we have more sources than that which 
are the chip functions (some even with more than one IRQ like IDE) and the 
4 PCI interrupt inputs and these can be routed to any of the ISA IRQs 
independently (there's a register for each of them, the funcs use thi 
interrupt line config reg and the PCI pins the regs in the ISA func). So 
how would PCI handle this when it only sees the 4 PCI interrupt lines but 
not the chip functions as separate sources? You've assumed that those 
functions must be PCI devices too but their interrupts are routable 
separately from the PCI interrupts so you can have PCI INTA-D mapped to 
IRQ 7,8,9,10 and USB func mapped to IRQ 5 (like amigaone does) so you 
can't use PCI interrupt for the USB too but have to consider all of these 
separately and route them in the ISA bridge.

>> This fixes USB on amigaone and maybe other bugs not discovered yet.
>
> Given that the AmigaOne machine is new, can you explain in a bit more detail 
> what the difference is between the Pegasos2 and AmigaOne machines, 
> particularly with respect to where the existing IRQ routing logic is getting 
> this wrong?

The pegasos2 firmware sets all chip functions and PCI devices (except IDE 
which is hard coded to legacy interrupts) to IRQ 9 so it worked with 
mixing PCI interrupts with chip functions but the amigaone does not do 
that and sets different ISA interrupts to chip functions and PCI 
interrupts so the current simplified version cannot work with that any 
more and we need to allow separate routing of all the interrupt sources. 
(Additionally we need to keep interrupt state for each source to allow 
multiple sources to control the same ISA interrupt.) I could not think of 
any simpler way than my patch to correctly implement this.

Regards,
BALATON Zoltan

