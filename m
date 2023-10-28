Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E047DA849
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 19:48:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwnP4-0005Us-Vr; Sat, 28 Oct 2023 13:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qwnP2-0005U2-TK
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 13:47:16 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qwnP1-0002l4-2T
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 13:47:16 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C0CC3756082;
 Sat, 28 Oct 2023 19:47:15 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 74DED756078; Sat, 28 Oct 2023 19:47:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 72F47745681;
 Sat, 28 Oct 2023 19:47:15 +0200 (CEST)
Date: Sat, 28 Oct 2023 19:47:15 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 0/5] VIA PM: Implement basic ACPI support
In-Reply-To: <FE0C5B55-83DE-466F-B555-124B3936E3DE@gmail.com>
Message-ID: <56ec4e09-9c81-7d9c-69bf-16a23a0969bd@eik.bme.hu>
References: <20231028091606.23700-1-shentey@gmail.com>
 <999122a1-7790-f77c-8826-cd143191f6fb@eik.bme.hu>
 <FE0C5B55-83DE-466F-B555-124B3936E3DE@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-817208961-1698515235=:97732"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-817208961-1698515235=:97732
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 28 Oct 2023, Bernhard Beschow wrote:
> Am 28. Oktober 2023 12:58:32 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> Hello,
>>
>> On Sat, 28 Oct 2023, Bernhard Beschow wrote:
>>> This series is part of my work to bring the VIA south bridges to the PC machine
>>> [1]. It implements missing ACPI functionality which ACPI-aware x86 guests
>>> expect for a smooth experience. The implementation is heavily inspired by PIIX4.
>>
>> I think first the interrupt routing should be fixed because that may change a few things in this series so that should be the next step and then rebase this series on top of that.
>>
>> What I mean by fixing interrupt routing? You may remember this discussion:
>>
>> https://patchew.org/QEMU/cover.1677004414.git.balaton@eik.bme.hu/
>>
>> With pegasos2 your (over)simplification worked only because the firmware of that machine maps everythnig to one ISA IRQ and guests were happy with that. I told you that back then but could not convince you and Mark about that. Now with the amigaone machine the firmware maps VIA devices and PCI interuupt pins to different ISA IRQs so we need to go back either to my otiginal implementation or something else you come up with. You can test this trying to use USB devices with amigaone machine which only works after reverting 4e5a20b6da9b1 and 422a6e8075752. So please either propose something to fix that first or wait with this series until I can update my pathches to solve interrupt routing. I think this series should wait until after that because it adds more interrupt handling which should follow whatever way we come up with for that so it's too early fir this series yet. (If you want to try fixing it keep in mind that in both amigaone and pegasos2 the PCI buses are in the north brid
 ge not in the VIA south bridge so don't try to force the IRQ mapping into the PCI bus. All the VIA chip needs to do is mapping its PIRQ/PINT pins to ISA IRQs as the VIA is only handling ISA IRQs and all other pci stuff is handled in the north bridge. So I think we need a via_set_isa_irq function but we could change it according to Mark's idea to pass the PCI device and use its function number to select itq source instead of the enum I had in my original series.)
>>
>> I have some other comments that I'll add in reply to individual patches for the future/
>
> Hi Zoltan,
>
> The interrupt handling introduced in this series is not related to PCI interrupt routing: The SMI is a dedicated pin on the device and the SCI is mapped internally to an ISA interrupt (note how the power management function lacks the registers for PCI interrupt information). Hence, PCI interrupt routing isn't changed in this series and therefore seems off-topic to me.
>
> Moreover, the SMI is a new interrupt which is therefore not used in any machine yet. The SCI is deactivated if set to IRQ 0 which is the default even. If a guest configures it, it shall be aware to receive an *ISA* interrupt.
>
> So I think this series shouldn't conflict with any previous work and should not be blocked by the PCI IRQ routing topic.

The topic I've raised is not about routing PCI interrupts but routing 
different IRQ sources in VIA chip (such as different functions plus the 
PIRQ/PINT pins) to ISA interrupts so that would conflict with how the PM 
func interrupts are routed. I think only the isa function should have 
qemu_irqs and it should handle mapping of the different sources to the 
appropriate ISA IRQ so the different sources (functions) should not have 
their own qemu_irqs or gpios but they would just call via_isa_set_irq with 
their PCIDevice, pun and level and then the isa model would do the 
routing. I plan to do this eventually but it you're adding more things 
that would need to be reverted then it becomes more difficult.

Regards,
BALATON Zoltan
--3866299591-817208961-1698515235=:97732--

