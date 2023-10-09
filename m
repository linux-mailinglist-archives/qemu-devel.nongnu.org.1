Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D28EB7BDD0F
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 15:03:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qppui-0006zw-BQ; Mon, 09 Oct 2023 09:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qppuc-0006zS-PG; Mon, 09 Oct 2023 09:03:06 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qppuW-0002Od-Bg; Mon, 09 Oct 2023 09:03:06 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 77DD27456AC;
 Mon,  9 Oct 2023 15:02:04 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 117DA7456A7; Mon,  9 Oct 2023 15:02:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0FDB6745681;
 Mon,  9 Oct 2023 15:02:04 +0200 (CEST)
Date: Mon, 9 Oct 2023 15:02:04 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org, 
 philmd@linaro.org, Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Subject: Re: [PATCH 1/3] via-ide: Fix legacy mode emulation
In-Reply-To: <4F17AF6B-22A5-4574-A3C0-40538F298CD5@gmail.com>
Message-ID: <1616da62-b55e-2bb1-2d1c-02adbcd1c0c0@eik.bme.hu>
References: <cover.1696542537.git.balaton@eik.bme.hu>
 <12ce9caa682545cd43318c4679530202140117c0.1696542537.git.balaton@eik.bme.hu>
 <33347356-be91-4dde-8535-5a59ee1c80f1@ilande.co.uk>
 <a7821bf0-5d1f-ddda-f408-f4cd0432ddbf@eik.bme.hu>
 <4F17AF6B-22A5-4574-A3C0-40538F298CD5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-863251880-1696856524=:71180"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-863251880-1696856524=:71180
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 9 Oct 2023, Bernhard Beschow wrote:
> Am 8. Oktober 2023 11:08:58 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> On Sun, 8 Oct 2023, Mark Cave-Ayland wrote:
>>> On 05/10/2023 23:13, BALATON Zoltan wrote:
>>>
>>>> The initial value for BARs were set in reset method for emulating
>>>> legacy mode at start but this does not work because PCI code resets
>>>> BARs after calling device reset method.
>>>
>>> This is certainly something I've noticed when testing previous versions of the VIA patches. Perhaps it's worth a separate thread to the PCI devs?
>>
>> I think I brought up this back then but was told current PCI code won't change and since that could break everything else that makes sense so this is something that we should take as given and accomodate that.
>>
>>>> Additionally the values
>>>> written to BARs were also wrong.
>>>
>>> I don't believe this is correct: according to the datasheet the values on reset are the ones given in the current reset code, so even if the reset function is overridden at a later data during PCI bus reset, I would leave these for now since it is a different issue.
>>
>> Those values are missing the IO space bit for one so they can't be correct as a BAR value no matter what the datasheet says. And since they are ineffective now I think it's best to remove them to avoid confusion.
>>
>>>> Move setting the BARs to a callback on writing the PCI config regsiter
>>>> that sets the compatibility mode (which firmwares needing this mode
>>>> seem to do) and fix their values to program it to use legacy port
>>>> numbers. As noted in a comment, we only do this when the BARs were
>>>> unset before, because logs from real machine show this is how real
>>>> chip works, even if it contradicts the data sheet which is not very
>>>> clear about this.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>>   hw/ide/via.c | 35 ++++++++++++++++++++++++++++++-----
>>>>   1 file changed, 30 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>>>> index fff23803a6..8186190207 100644
>>>> --- a/hw/ide/via.c
>>>> +++ b/hw/ide/via.c
>>>> @@ -132,11 +132,6 @@ static void via_ide_reset(DeviceState *dev)
>>>>       pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_FAST_BACK |
>>>>                    PCI_STATUS_DEVSEL_MEDIUM);
>>>>   -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_0, 0x000001f0);
>>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_1, 0x000003f4);
>>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
>>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
>>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 20-23h */
>>>>       pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
>>>>         /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configuration*/
>>>> @@ -159,6 +154,35 @@ static void via_ide_reset(DeviceState *dev)
>>>>       pci_set_long(pci_conf + 0xc0, 0x00020001);
>>>>   }
>>>>   +static void via_ide_cfg_write(PCIDevice *pd, uint32_t addr,
>>>> +                              uint32_t val, int len)
>>>> +{
>>>> +    pci_default_write_config(pd, addr, val, len);
>>>> +    /*
>>>> +     * Only set BARs if they are unset. Logs from real hardware show that
>>>> +     * writing class_prog to enable compatibility mode after BARs were set
>>>> +     * (possibly by firmware) it will use ports set by BARs not ISA ports
>>>> +     * (e.g. pegasos2 Linux does this and calls it non-100% native mode).
>>>
>>> Can you remind me again where the references are to non-100% native mode? The only thing I can find in Linux is https://github.com/torvalds/linux/blob/master/arch/powerpc/platforms/chrp/pci.c#L360 but that simply forces a switch to legacy mode, with no mention of "non-100% native mode".
>>
>> It was discussed somewhere in the via-ide thread we had when this was last touched for pegasos2 in March 2020. Basically the non-100% native mode is when ports are set by BARs but IRQs are still hard coded to 14-15. Linux can work with all 3 possible modes: legacy (both ports and IRQs are hard coded to ISA values), native (using BARs and PCI config 0x3c for a single interrupt for both channels, vt82c686 data sheet does not document this but vt8231 has a comment saying native mode only) and non-100% native mode where BARs are effective to set port addresses but IRQs don't respect 0x3c but use 14-15 as in legacy mode. Some machines only work in non-100% native mode such as pegasos2 and Linux has some quirks for this. Other OSes running on this machine work with what the firmware has set up and can't work with anything else so we need to emulate what those OSes want (which matches real hardware) because Linux can usually cope anyway. On pegasso2 MorphOS uses BARs but expects IRQ 14-1
 5 which is what the firmware also sets up by setting mode to native in the PCI config of the IDE func yet IRQs are fixed at 14-15. Linux forces its driver to use legacy interrupts by setting mode back to legacy but it still uses BARs and this is what it calls non-100% native mode. On amigaone firmware sets legacy mode and AmigaOS does not change this but uses it with legacy ports and IRQs. Linux finds the same and uses legacy mode on amigaone.
>>
>>>> +     * But if 0x8a is written after reset without setting BARs then we want
>>>> +     * legacy ports (this is done by AmigaOne firmware for example).
>>>> +     */
>>>
>>> What should happen here is that writing 0x8a should *always* switch to legacy mode, so the BARs are unused...
>>
>> Yes, but as we've found before that can't be emulated in QEMU due to ISA emulation being static and only allows adding ports but not removing them later so we can't switch between legacy ISA and PCI here so we use the BARs for legacy ports as well to emulate that. The reason we only do this if BARs are not yet set is because Linux changes this back to legacy mode on pegasos2 but still uses BARs
>
> Just curious: How can you tell the difference in real hardware whether 
> "raw" IO ports vs. BARs mapped to IO space are used?

Not sure what you mean but if you see ports not matching legacy ports then 
you can be fairly sure they are BARs. The chip may internally implement 
legacy mode by just fixing BARs at legacy values (the same as this patch 
does) but the data sheet does not tell how it works so we don't know that.

>> as shown in boot logs from real hardware
>
> Could you provide links to such logs? That would be very helpful to have 
> -- even in the code -- for documentation.

I think if you don't believe me you can just try the emulated pegasos2 
with its original firmware and see how it configures the IDE device then 
boot Linux with that and see how it detects that. The relevant lines in 
the Linux dmesg are:

[    0.066337] pci 0000:00:0c.1: Fixing VIA IDE, force legacy mode on

[    0.514351] pata_via 0000:00:0c.1: version 0.3.4
[    0.536431] scsi0 : pata_via
[    0.557917] scsi1 : pata_via
[    0.558249] ata1: PATA max UDMA/100 cmd 0x1000 ctl 0x100c bmdma 0x1020 irq 14
[    0.558272] ata2: PATA max UDMA/100 cmd 0x1010 ctl 0x101c bmdma 0x1028 irq 15

These are from real machine but emulated one shold do the same with 
original firmware. The comments near the IDE fixup in Linux source is 
misleading as it says the controller only works in legacy mode but what it 
should say is that it uses legacy interrupts even in native mode as seen 
from the above logs. The ports are still as mapped by BARs but IRQs aren't 
the 9 that the firmware writes to 0x3c PCI config reg for all devices but 
14-15 as in legacy mode. This is the non-100% native mode that I think 
older Linux versions printed in this case and what's MorphOS and AmigaOS 
expect so happen on pegasos2 irrespective of what's in the device tree. 
Also the forcing legacy mode quirk in Linux may only edit the device tree 
so the driver uses legacy interrupts, I'm not sure, it's been a while I've 
looked at this and it was already discussed to death back when I've added 
the pegasos2 machine so I don't want to get back to that again. This patch 
is tested to allow amigaone to work while not breaking pegasos2 so I'd go 
with this for now.

Regards,
BALATON Zoltan
--3866299591-863251880-1696856524=:71180--

