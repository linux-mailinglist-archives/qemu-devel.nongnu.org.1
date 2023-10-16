Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C017CB674
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 00:19:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsVuE-0003Gs-OG; Mon, 16 Oct 2023 18:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qsVuC-0003Dy-Kc; Mon, 16 Oct 2023 18:17:44 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qsVu9-0001vf-6I; Mon, 16 Oct 2023 18:17:44 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id EF11F7456AC;
 Tue, 17 Oct 2023 00:16:27 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7D7207456A7; Tue, 17 Oct 2023 00:16:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 78A37745681;
 Tue, 17 Oct 2023 00:16:27 +0200 (CEST)
Date: Tue, 17 Oct 2023 00:16:27 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org, 
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>, 
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Subject: Re: [PATCH v2 1/3] via-ide: Fix legacy mode emulation
In-Reply-To: <3db1683e-45ef-4125-ac98-2fb63df3951f@ilande.co.uk>
Message-ID: <1cb88a08-f27a-2795-9bd2-ee1e49d7e0ab@eik.bme.hu>
References: <cover.1696880742.git.balaton@eik.bme.hu>
 <f27e2af1a17e62ead8eda1e9e417f0f87f9c65f5.1696880742.git.balaton@eik.bme.hu>
 <af270749-a36f-4803-9d40-ad24521c4ea4@ilande.co.uk>
 <alpine.LMD.2.03.2310141748380.3555@eik.bme.hu>
 <3db1683e-45ef-4125-ac98-2fb63df3951f@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-949917567-1697494587=:7980"
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

--3866299591-949917567-1697494587=:7980
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 15 Oct 2023, Mark Cave-Ayland wrote:
> On 14/10/2023 17:13, BALATON Zoltan wrote:
>> On Sat, 14 Oct 2023, Mark Cave-Ayland wrote:
>>> On 09/10/2023 20:54, BALATON Zoltan wrote:
>>>> The initial value for BARs were set in reset method for emulating
>>>> legacy mode at start but this does not work because PCI code resets
>>>> BARs after calling device reset method. Remove this ineffective
>>>> default to avoid confusion.
>>>> 
>>>> Instead move setting the BARs to a callback on writing the PCI config
>>>> regsiter that sets legacy mode (which firmwares needing this mode seem
>>>> to do) and fix their values to program it to use legacy port numbers
>>>> in this case. This does not fully emulate what the data sheet says
>>>> (which is not very clear on this) but it implements enogh to allow
>>>> both modes as used by firmwares of machines we emulate.
>>>> 
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>>   hw/ide/via.c | 41 ++++++++++++++++++++++++++++++++++++-----
>>>>   1 file changed, 36 insertions(+), 5 deletions(-)
>>>> 
>>>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>>>> index fff23803a6..43e8af8d69 100644
>>>> --- a/hw/ide/via.c
>>>> +++ b/hw/ide/via.c
>>>> @@ -132,11 +132,6 @@ static void via_ide_reset(DeviceState *dev)
>>>>       pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_FAST_BACK |
>>>>                    PCI_STATUS_DEVSEL_MEDIUM);
>>>>   -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_0, 0x000001f0);
>>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_1, 0x000003f4);
>>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
>>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
>>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 
>>>> 20-23h */
>>>>       pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
>>>>         /* IDE chip enable, IDE configuration 1/2, IDE FIFO 
>>>> Configuration*/
>>>> @@ -159,6 +154,41 @@ static void via_ide_reset(DeviceState *dev)
>>>>       pci_set_long(pci_conf + 0xc0, 0x00020001);
>>>>   }
>>>>   +static void via_ide_cfg_write(PCIDevice *pd, uint32_t addr,
>>>> +                              uint32_t val, int len)
>>>> +{
>>>> +    pci_default_write_config(pd, addr, val, len);
>>>> +    /*
>>>> +     * Bits 0 and 2 of the PCI programming interface register select 
>>>> between
>>>> +     * legacy and native mode for the two IDE channels. We don't emulate 
>>>> this
>>>> +     * because we cannot easily switch between ISA and PCI in QEMU so 
>>>> instead
>>> 
>>> As per my previous email, this statement is demonstrably false: this is 
>>> now achievable using the portio_list*() APIs.
>>> 
>>>> +     * when guest selects legacy mode we set the PCI BARs to legacy 
>>>> ports which
>>>> +     * works the same. We also don't care about setting each channel 
>>>> separately
>>>> +     * as no guest is known to do or need that. We only do this when 
>>>> BARs are
>>>> +     * unset when writing this register as logs from real hardware show 
>>>> that
>>>> +     * setting legacy mode after BARs were set it will still use ports 
>>>> set by
>>>> +     * BARs not ISA ports (e.g. pegasos2 Linux does this after firmware 
>>>> set
>>>> +     * native mode and programmed BARs and calls it non-100% native 
>>>> mode).
>>>> +     * But if 0x8a is written righr after reset without setting BARs 
>>>> then we
>>>> +     * want legacy ports (this is done by the AmigaOne firmware).
>>>> +     */
>>>> +    if (addr == PCI_CLASS_PROG && val == 0x8a &&
>>>> +        pci_get_long(pd->config + PCI_BASE_ADDRESS_0) ==
>>>> +        PCI_BASE_ADDRESS_SPACE_IO) {
>>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_0, 0x1f0
>>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_1, 0x3f6
>>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_2, 0x170
>>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_3, 0x376
>>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>>> +        /* BMIBA: 20-23h */
>>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_4, 0xcc00
>>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>>> +    }
>>>> +}
>>> 
>>> Another hint that this is not the right way to be doing this: the values 
>>> you are placing in BARS 1 and 3 are illegal. PCI IO BARs have bit 1 forced 
>>> to 0 and bit 0 set to 1 which forces a minimum alignment of 4, so either 
>>> the addresses 0x3f6/0x376 are being rounded internally to 0x3f4/0x374 
>>> and/or you're lucky that this just happens to work on QEMU.
>> 
>> The data sheet lists these values for legacy mode bur it seems that bit 1 
>> is ignored for BAR here and it ends up set to 0x3x4 with the actual reg 
>> mapped to 0x3x7 for both values ending in 4 or 6 here and both works the 
>> same with AmigaOS even if I change the values here to 0x3[7f]4 so I can do 
>> that and that should then match the default values for these regs but not 
>> match the values listed for legacy mode so the data sheet is wrong either 
>> way. It still does not make sense to set these in reset method which will 
>> be overwritten so only works if I set them here.
>> 
>>> Using the portio_list*() APIs really is the right way to implement this to 
>>> avoid being affected by such issues.
>> 
>> Can you provide an alternative patch using portio_list? I don't know how to 
>> do that and have no example to follow either so it would be hard for me to 
>> figure out. Or give some pointers on how to do this if I missed something.
>
> Here's a hacked up version based upon various bits and pieces from my WIP IDE 
> mode switching branch. It's briefly compile tested, and checked with "info 
> mtree" and a couple of test boots:


I gave this a try and while it works with the guests I've tried I'm still 
not convinced. See comments below.


> diff --git a/hw/ide/via.c b/hw/ide/via.c
> index fff23803a6..82f2af1c78 100644
> --- a/hw/ide/via.c
> +++ b/hw/ide/via.c
> @@ -28,12 +28,27 @@
> #include "hw/pci/pci.h"
> #include "migration/vmstate.h"
> #include "qemu/module.h"
> +#include "qemu/range.h"
> #include "sysemu/dma.h"
> #include "hw/isa/vt82c686.h"
> #include "hw/ide/pci.h"
> #include "hw/irq.h"
> #include "trace.h"
>
> +
> +/* FIXME: export these from hw/ide/ioport.c */
> +static const MemoryRegionPortio ide_portio_list[] = {
> +    { 0, 8, 1, .read = ide_ioport_read, .write = ide_ioport_write },
> +    { 0, 1, 2, .read = ide_data_readw, .write = ide_data_writew },
> +    { 0, 1, 4, .read = ide_data_readl, .write = ide_data_writel },
> +    PORTIO_END_OF_LIST(),
> +};
> +
> +static const MemoryRegionPortio ide_portio2_list[] = {
> +    { 0, 1, 1, .read = ide_status_read, .write = ide_ctrl_write },
> +    PORTIO_END_OF_LIST(),
> +};
> +
> static uint64_t bmdma_read(void *opaque, hwaddr addr,
>                            unsigned size)
> {
> @@ -137,7 +152,10 @@ static void via_ide_reset(DeviceState *dev)
>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 
> 20-23h */
> -    pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
> +    pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000000e);

The vt8231 data sheet says the interrupt pin should always be 1 while 
according to the vt82c686b data sheet this means legacy or native 
interrupt routing and defaults to 0. We probably don't do anything with it 
so no matter what we have here and we can change it to 0 but maybe there's 
someting off here in any case.

> +
> +    /* Clear subsystem to match real hardware */
> +    pci_set_long(pci_conf + 0x2c, 0x0);
>
>     /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configuration*/
>     pci_set_long(pci_conf + 0x40, 0x0a090600);
> @@ -159,6 +177,89 @@ static void via_ide_reset(DeviceState *dev)
>     pci_set_long(pci_conf + 0xc0, 0x00020001);
> }
>
> +static void via_ide_cfg_write(PCIDevice *pd, uint32_t addr,
> +                              uint32_t val, int len)
> +{
> +    uint8_t *pci_conf = pd->config;
> +    PCIIDEState *d = PCI_IDE(pd);
> +
> +    pci_default_write_config(pd, addr, val, len);
> +
> +    if (range_covers_byte(addr, len, PCI_CLASS_PROG)) {
> +        if (pci_conf[PCI_CLASS_PROG] == 0x8a) {
> +            /* FIXME: don't disable BARs
> +            pci_default_write_config(pd, PCI_BASE_ADDRESS_0, 0x1, 4);
> +            pci_default_write_config(pd, PCI_BASE_ADDRESS_1, 0x1, 4);
> +            pci_default_write_config(pd, PCI_BASE_ADDRESS_2, 0x1, 4);
> +            pci_default_write_config(pd, PCI_BASE_ADDRESS_3, 0x1, 4);
> +            */
> +
> +            pci_set_long(pci_conf + PCI_BASE_ADDRESS_0, 0x0);
> +            pci_set_long(pci_conf + PCI_BASE_ADDRESS_1, 0x0);
> +            pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x0);
> +            pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x0);

This is the part why I think this is not ready for merge yet. It seems to 
leave BARs enabled but 0 their regs so now we have ide ports *both* at the 
previous BAR values and at legacy ports while BAR values are 0. This does 
not look right and seems much more hacky than my patch that changes BARs 
to legacy ports to emulate legacy mode. You probably need this becuase of 
what Linux does on pegasos2 which I think is proving real chip is also 
using BARs as my patch.

Therefore I think we should go with my patch for now to not hold up adding 
amigaone machine and allow progress with it and then when you have more 
time to elaborate this idea of using portio_list to remove the FIXME 
comments from this PoC patch we can revisit this any time later. There's 
no reason to hold other's work back to get this sorted out now and solving 
a problem with my patch now does not mean we cannot improve this device 
model further in the future. So if you can't make this a clean patch now 
that can replace my patch please let my patch accepted until you can make 
this a viable alternative. For now this just seems like an idea that needs 
more work but not ready yet.

Regards,
BALATON Zoltan

> +
> +            /* Clear interrupt pin */
> +            pci_config_set_interrupt_pin(pci_conf, 0);
> +
> +            /* Add legacy IDE ports */
> +            if (!d->bus[0].portio_list.owner) {
> +                portio_list_init(&d->bus[0].portio_list, OBJECT(pd),
> +                                 ide_portio_list, &d->bus[0], "ide");
> +                portio_list_add(&d->bus[0].portio_list,
> +                                pci_address_space_io(pd), 0x1f0);
> +            }
> +
> +            if (!d->bus[0].portio2_list.owner) {
> +                portio_list_init(&d->bus[0].portio2_list, OBJECT(pd),
> +                                 ide_portio2_list, &d->bus[0], "ide");
> +                portio_list_add(&d->bus[0].portio2_list,
> +                                pci_address_space_io(pd), 0x3f6);
> +            }
> +
> +            if (!d->bus[1].portio_list.owner) {
> +                portio_list_init(&d->bus[1].portio_list, OBJECT(pd),
> +                                 ide_portio_list, &d->bus[1], "ide");
> +                portio_list_add(&d->bus[1].portio_list,
> +                                pci_address_space_io(pd), 0x170);
> +            }
> +
> +            if (!d->bus[1].portio2_list.owner) {
> +                portio_list_init(&d->bus[1].portio2_list, OBJECT(pd),
> +                                 ide_portio2_list, &d->bus[1], "ide");
> +                portio_list_add(&d->bus[1].portio2_list,
> +                                pci_address_space_io(pd), 0x376);
> +            }
> +        }
> +
> +        if (pci_conf[PCI_CLASS_PROG] == 0x8f) {
> +            /* Set interrupt pin */
> +            pci_config_set_interrupt_pin(pci_conf, 1);
> +
> +            /* Remove legacy IDE ports */
> +            if (d->bus[0].portio_list.owner) {
> +                portio_list_del(&d->bus[0].portio_list);
> +                portio_list_destroy(&d->bus[0].portio_list);
> +            }
> +
> +            if (d->bus[0].portio2_list.owner) {
> +                portio_list_del(&d->bus[0].portio2_list);
> +                portio_list_destroy(&d->bus[0].portio2_list);
> +            }
> +
> +            if (d->bus[1].portio_list.owner) {
> +                portio_list_del(&d->bus[1].portio_list);
> +                portio_list_destroy(&d->bus[1].portio_list);
> +            }
> +
> +            if (d->bus[1].portio2_list.owner) {
> +                portio_list_del(&d->bus[1].portio2_list);
> +                portio_list_destroy(&d->bus[1].portio2_list);
> +            }
> +        }
> +    }
> +}
> +
> static void via_ide_realize(PCIDevice *dev, Error **errp)
> {
>     PCIIDEState *d = PCI_IDE(dev);
> @@ -221,6 +322,7 @@ static void via_ide_class_init(ObjectClass *klass, void 
> *data)
>     /* Reason: only works as function of VIA southbridge */
>     dc->user_creatable = false;
>
> +    k->config_write = via_ide_cfg_write;
>     k->realize = via_ide_realize;
>     k->exit = via_ide_exitfn;
>     k->vendor_id = PCI_VENDOR_ID_VIA;
>
>
> Note that this also fixes the output of "lspci -vv" on Linux:
>
> 0000:00:0c.1 IDE interface: VIA Technologies, Inc. 
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a 
> [Master SecP PriP])
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping+ SERR- FastB2B- DisINTx-
>        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0
>        Interrupt: pin ? routed to IRQ 14
>        Region 0: [virtual] I/O ports at 1000 [size=8]
>        Region 1: [virtual] I/O ports at 100c [size=4]
>        Region 2: [virtual] I/O ports at 1010 [size=8]
>        Region 3: [virtual] I/O ports at 101c [size=4]
>        Region 4: I/O ports at 1020 [size=16]
>        Kernel driver in use: pata_via
>
>
> Currently the "[virtual]" prefix is missing in QEMU when compared with your 
> lspci output from real hardware: this patch fixes it, because it allows the 
> legacy IDE ioports to exist whilst having the BARs set to zero which isn't 
> possible with your current patch.
>
>
> ATB,
>
> Mark.
>
>
>
--3866299591-949917567-1697494587=:7980--

