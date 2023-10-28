Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E5D7DA70A
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 15:00:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwitq-0001IB-Po; Sat, 28 Oct 2023 08:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qwitm-0001Hg-22
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 08:58:42 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qwitj-0004iI-2U
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 08:58:41 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id D441A756082;
 Sat, 28 Oct 2023 14:58:32 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 947637456A7; Sat, 28 Oct 2023 14:58:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 91BE3745681;
 Sat, 28 Oct 2023 14:58:32 +0200 (CEST)
Date: Sat, 28 Oct 2023 14:58:32 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 0/5] VIA PM: Implement basic ACPI support
In-Reply-To: <20231028091606.23700-1-shentey@gmail.com>
Message-ID: <999122a1-7790-f77c-8826-cd143191f6fb@eik.bme.hu>
References: <20231028091606.23700-1-shentey@gmail.com>
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

Hello,

On Sat, 28 Oct 2023, Bernhard Beschow wrote:
> This series is part of my work to bring the VIA south bridges to the PC machine
> [1]. It implements missing ACPI functionality which ACPI-aware x86 guests
> expect for a smooth experience. The implementation is heavily inspired by PIIX4.

I think first the interrupt routing should be fixed because that may 
change a few things in this series so that should be the next step and 
then rebase this series on top of that.

What I mean by fixing interrupt routing? You may remember this discussion:

https://patchew.org/QEMU/cover.1677004414.git.balaton@eik.bme.hu/

With pegasos2 your (over)simplification worked only because the firmware 
of that machine maps everythnig to one ISA IRQ and guests were happy with 
that. I told you that back then but could not convince you and Mark about 
that. Now with the amigaone machine the firmware maps VIA devices and PCI 
interuupt pins to different ISA IRQs so we need to go back either to my 
otiginal implementation or something else you come up with. You can test 
this trying to use USB devices with amigaone machine which only works 
after reverting 4e5a20b6da9b1 and 422a6e8075752. So please either propose 
something to fix that first or wait with this series until I can update my 
pathches to solve interrupt routing. I think this series should wait until 
after that because it adds more interrupt handling which should follow 
whatever way we come up with for that so it's too early fir this series 
yet. (If you want to try fixing it keep in mind that in both amigaone and 
pegasos2 the PCI buses are in the north bridge not in the VIA south bridge 
so don't try to force the IRQ mapping into the PCI bus. All the VIA chip 
needs to do is mapping its PIRQ/PINT pins to ISA IRQs as the VIA is only 
handling ISA IRQs and all other pci stuff is handled in the north bridge. 
So I think we need a via_set_isa_irq function but we could change it 
according to Mark's idea to pass the PCI device and use its function 
number to select itq source instead of the enum I had in my original 
series.)

I have some other comments that I'll add in reply to individual patches 
for the future/

Regards,
BALATON Zoltan

> Further quirks are needed in order to use the VIA south bridges in the PC
> machine. These were deliberately left out for a future series. The idea for now
> is to get the device model in shape for adding support for it in SeaBIOS.
>
> The series is structured as follows: The first patch fixes ACPI events to be
> signalled by SCI interrupts. The next three patches implement typical ACPI
> event handling. The last patch adds software-based SMI triggering which is the
> mechanism used in ACPI to transition the system into ACPI mode.
>
> Testing done:
> * `make check`
> * `make check-avocado`
> * `qemu-system-ppc -M pegasos2 \
>                   -device ati-vga,romfile="" \
>                   -cdrom morphos-3.18.iso \
>                   -bios pegasos2.rom`
>
> [1] https://github.com/shentok/qemu/tree/pc-via
>
> v5:
> * Implement software-based SMI triggering and handling of ACPI events based on
>  v3
>
> v4:
> * Alternative proposal (Zoltan)
>
> v3: https://patchew.org/QEMU/20231005115159.81202-1-shentey@gmail.com/
> * Rename SCI irq attribute to sci_irq (Zoltan)
> * Fix confusion about location of ACPI interrupt select register (Zoltan)
> * Model SCI as named GPIO (Bernhard)
> * Perform upcast via macro rather than sub structure selection (Bernhard)
>
> v2:
> * Introduce named constants for the ACPI interrupt select register at offset
>  0x42 (Phil)
>
> Bernhard Beschow (5):
>  hw/isa/vt82c686: Respect SCI interrupt assignment
>  hw/isa/vt82c686: Add missing initialization of ACPI general purpose
>    event registers
>  hw/isa/vt82c686: Reuse acpi_update_sci()
>  hw/isa/vt82c686: Implement ACPI powerdown
>  hw/isa/vt82c686: Implement software-based SMI triggering
>
> hw/isa/vt82c686.c | 179 ++++++++++++++++++++++++++++++++++++----------
> 1 file changed, 142 insertions(+), 37 deletions(-)
>
> --
> 2.42.0
>
>
>

