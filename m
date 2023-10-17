Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8F47CCF73
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 23:42:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsroO-0002Cl-Sa; Tue, 17 Oct 2023 17:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qsroL-00028H-8f; Tue, 17 Oct 2023 17:41:09 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qsroG-0005SN-6F; Tue, 17 Oct 2023 17:41:08 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 4C39474632B;
 Tue, 17 Oct 2023 23:39:49 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AEA347456AC; Tue, 17 Oct 2023 23:39:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id ABBF47456AA;
 Tue, 17 Oct 2023 23:39:48 +0200 (CEST)
Date: Tue, 17 Oct 2023 23:39:48 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org, 
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>, 
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Subject: Re: [PATCH v2 1/3] via-ide: Fix legacy mode emulation
In-Reply-To: <d4e3412c-e6aa-467b-b570-352b5ad0bafa@ilande.co.uk>
Message-ID: <e4cd3401-6073-d29e-1288-3de4597423f5@eik.bme.hu>
References: <cover.1696880742.git.balaton@eik.bme.hu>
 <f27e2af1a17e62ead8eda1e9e417f0f87f9c65f5.1696880742.git.balaton@eik.bme.hu>
 <af270749-a36f-4803-9d40-ad24521c4ea4@ilande.co.uk>
 <alpine.LMD.2.03.2310141748380.3555@eik.bme.hu>
 <3db1683e-45ef-4125-ac98-2fb63df3951f@ilande.co.uk>
 <1cb88a08-f27a-2795-9bd2-ee1e49d7e0ab@eik.bme.hu>
 <d4e3412c-e6aa-467b-b570-352b5ad0bafa@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1928978844-1697578788=:50058"
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

--3866299591-1928978844-1697578788=:50058
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 17 Oct 2023, Mark Cave-Ayland wrote:
> On 16/10/2023 23:16, BALATON Zoltan wrote:
>> On Sun, 15 Oct 2023, Mark Cave-Ayland wrote:
>>> On 14/10/2023 17:13, BALATON Zoltan wrote:
>>>> On Sat, 14 Oct 2023, Mark Cave-Ayland wrote:
>>>>> Using the portio_list*() APIs really is the right way to implement this 
>>>>> to avoid being affected by such issues.
>>>> 
>>>> Can you provide an alternative patch using portio_list? I don't know how 
>>>> to do that and have no example to follow either so it would be hard for 
>>>> me to figure out. Or give some pointers on how to do this if I missed 
>>>> something.
>>> 
>>> Here's a hacked up version based upon various bits and pieces from my WIP 
>>> IDE mode switching branch. It's briefly compile tested, and checked with 
>>> "info mtree" and a couple of test boots:
>> 
>> 
>> I gave this a try and while it works with the guests I've tried I'm still 
>> not convinced. See comments below.
>
> Okay, that's good news and proves the basic concept works as expected.

Well it works but seems much more hacky and complex at the moment than my 
patch which also not perfect but works as well and solves the problem with 
much less change so I still don't like this patch of yours too much. But 
if you can clean it in time before the freeze so this won't cause my other 
patches depending on this missing the release I'm OK with this alternative 
approach even if I think it's not necessary and could be done any time 
later. My patch does not prevent you to take this futther and do this 
later, but you not allowing my patch and then not providing alternative in 
time for the series to be merged would make me not able to progress with 
this machine model and prevent users start using it.

>>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>>> index fff23803a6..82f2af1c78 100644
>>> --- a/hw/ide/via.c
>>> +++ b/hw/ide/via.c
>>> @@ -28,12 +28,27 @@
>>> #include "hw/pci/pci.h"
>>> #include "migration/vmstate.h"
>>> #include "qemu/module.h"
>>> +#include "qemu/range.h"
>>> #include "sysemu/dma.h"
>>> #include "hw/isa/vt82c686.h"
>>> #include "hw/ide/pci.h"
>>> #include "hw/irq.h"
>>> #include "trace.h"
>>> 
>>> +
>>> +/* FIXME: export these from hw/ide/ioport.c */
>>> +static const MemoryRegionPortio ide_portio_list[] = {
>>> +    { 0, 8, 1, .read = ide_ioport_read, .write = ide_ioport_write },
>>> +    { 0, 1, 2, .read = ide_data_readw, .write = ide_data_writew },
>>> +    { 0, 1, 4, .read = ide_data_readl, .write = ide_data_writel },
>>> +    PORTIO_END_OF_LIST(),
>>> +};
>>> +
>>> +static const MemoryRegionPortio ide_portio2_list[] = {
>>> +    { 0, 1, 1, .read = ide_status_read, .write = ide_ctrl_write },
>>> +    PORTIO_END_OF_LIST(),
>>> +};
>>> +
>>> static uint64_t bmdma_read(void *opaque, hwaddr addr,
>>>                            unsigned size)
>>> {
>>> @@ -137,7 +152,10 @@ static void via_ide_reset(DeviceState *dev)
>>>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
>>>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
>>>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 
>>> 20-23h */
>>> -    pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
>>> +    pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000000e);
>> 
>> The vt8231 data sheet says the interrupt pin should always be 1 while 
>> according to the vt82c686b data sheet this means legacy or native interrupt 
>> routing and defaults to 0. We probably don't do anything with it so no 
>> matter what we have here and we can change it to 0 but maybe there's 
>> someting off here in any case.
>
> According to the VT8231 datasheet I have here, the interrupt pin register is 
> read-only but defaults to zero. But then that's fine because that is the 
> expected value in legacy mode which is what you would expect with a default 
> PCI_CLASS_PROG set to 0x8a.

According to the data sheet I have (VT8231 South Bridge Revision 2.32, 
September 1, 2004) IDE func config reg 0x3d Interrupt Pin defaults to 01. 
Maybe you're looking at an even more buggy preliminary data sheet that I 
think Bernhard had before too. But it probably does not matter what's in 
this reg anyway so this is a small detail.

>>> +
>>> +    /* Clear subsystem to match real hardware */
>>> +    pci_set_long(pci_conf + 0x2c, 0x0);
>>> 
>>>     /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configuration*/
>>>     pci_set_long(pci_conf + 0x40, 0x0a090600);
>>> @@ -159,6 +177,89 @@ static void via_ide_reset(DeviceState *dev)
>>>     pci_set_long(pci_conf + 0xc0, 0x00020001);
>>> }
>>> 
>>> +static void via_ide_cfg_write(PCIDevice *pd, uint32_t addr,
>>> +                              uint32_t val, int len)
>>> +{
>>> +    uint8_t *pci_conf = pd->config;
>>> +    PCIIDEState *d = PCI_IDE(pd);
>>> +
>>> +    pci_default_write_config(pd, addr, val, len);
>>> +
>>> +    if (range_covers_byte(addr, len, PCI_CLASS_PROG)) {
>>> +        if (pci_conf[PCI_CLASS_PROG] == 0x8a) {
>>> +            /* FIXME: don't disable BARs
>>> +            pci_default_write_config(pd, PCI_BASE_ADDRESS_0, 0x1, 4);
>>> +            pci_default_write_config(pd, PCI_BASE_ADDRESS_1, 0x1, 4);
>>> +            pci_default_write_config(pd, PCI_BASE_ADDRESS_2, 0x1, 4);
>>> +            pci_default_write_config(pd, PCI_BASE_ADDRESS_3, 0x1, 4);
>>> +            */
>>> +
>>> +            pci_set_long(pci_conf + PCI_BASE_ADDRESS_0, 0x0);
>>> +            pci_set_long(pci_conf + PCI_BASE_ADDRESS_1, 0x0);
>>> +            pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x0);
>>> +            pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x0);
>> 
>> This is the part why I think this is not ready for merge yet. It seems to 
>> leave BARs enabled but 0 their regs so now we have ide ports *both* at the 
>> previous BAR values and at legacy ports while BAR values are 0. This does 
>> not look right and seems much more hacky than my patch that changes BARs to 
>> legacy ports to emulate legacy mode. You probably need this becuase of what 
>> Linux does on pegasos2 which I think is proving real chip is also using 
>> BARs as my patch.
>
> Well we both agree there are some quirks with this chip, but the reason for 
> pursuing this approach is for 2 reasons: i) it matches the dumps you provided 
> from real hardware (unlike your existing patch) and ii) it proves the basic

Matching the dumps does not matter as long as guests work. All of QEMU is 
aiming to model devices enough to allow guests to run but does not care to 
faithfully emulate every detail unless that's needed for guest. It seems 
guests don't care about this so not absolutely needed to be modeled. It 
may be nice to do but should not be a requirement.

> concept and allows us to move forward with the consolidation work done by 
> myself, Phil and Bernhard. Here's what I have in my tests here:

As I said above taking my patch now does not prevent that and then you're 
free to submit these consolidation patches any time later when they are 
ready. There's not urgent need to do them now and hold back this very 
simple series by that and threaten with missing the release because of 
this.

> lspci output from real hardware (provided by you)
> =================================================
>
> 0000:00:0c.1 IDE interface: VIA Technologies, Inc. 
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a 
> [Master SecP PriP])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin ? routed to IRQ 14
>         Region 0: [virtual] I/O ports at 1000 [size=8]
>         Region 1: [virtual] I/O ports at 100c [size=4]
>         Region 2: [virtual] I/O ports at 1010 [size=8]
>         Region 3: [virtual] I/O ports at 101c [size=4]
>         Region 4: I/O ports at 1020 [size=16]
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Kernel driver in use: pata_via
>
> 0000:00:0c.1 IDE interface: VIA Technologies, Inc. 
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> 00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 61 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 c0 00 00 00 00 00 00 00 0e 00 00 00
> 40: 0b f2 09 35 18 1c c0 00 99 20 20 20 02 00 20 20
> 50: 17 f4 f0 f0 14 00 00 00 a8 a8 a8 a8 00 00 00 00
> 60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
> 70: 02 01 00 00 00 00 00 00 02 01 00 00 00 00 00 00
> 80: 00 e0 b0 2f 00 00 00 00 00 f0 b0 2f 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 06 00 71 05 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> Note that BARS 0-3 are all zeroed, the IDE controller reports legacy mode 
> (0x8a) and the interrupt pin is set to 0x0.
>
>
> lsipci output from your proposed patch
> ======================================
>
> 0000:00:0c.1 IDE interface: VIA Technologies, Inc. 
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a 
> [Master SecP PriP])
>        Subsystem: Red Hat, Inc Device 1100
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping+ SERR- FastB2B- DisINTx-
>        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0
>        Interrupt: pin A routed to IRQ 14
>        Region 0: I/O ports at 1000 [size=8]
>        Region 1: I/O ports at 100c [size=4]
>        Region 2: I/O ports at 1010 [size=8]
>        Region 3: I/O ports at 101c [size=4]
>        Region 4: I/O ports at 1020 [size=16]
>        Kernel driver in use: pata_via
> 00: 06 11 71 05 87 00 80 02 06 8a 01 01 00 00 00 00
> 10: 01 10 00 00 0d 10 00 00 11 10 00 00 1d 10 00 00
> 20: 21 10 00 00 00 00 00 00 00 00 00 00 f4 1a 00 11
> 30: 00 00 00 00 c0 00 00 00 00 00 00 00 0e 01 00 00
> 40: 0b f2 09 35 18 1c c0 00 99 31 99 99 a2 00 31 a8
> 50: 17 f0 17 17 14 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> Note that BARS 0-3 have values (incorrect), the IDE controller reports legacy 
> mode (0x8a) and the interrupt pin is set to 0x1 (incorrect).
>
>
> lsipci output from my proposed patch
> ====================================
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
> 00: 06 11 71 05 87 00 80 02 06 8a 01 01 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 21 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 c0 00 00 00 00 00 00 00 0e 00 00 00
> 40: 0b f2 09 35 18 1c c0 00 99 31 99 99 a2 00 31 a8
> 50: 17 f0 17 17 14 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> Note that BARS 0-3 are all zeroed (correct), the IDE controller reports 
> legacy mode (0x8a) and the interrupt pin is set to 0x0 (correct).

But these differences aren't solving any issues with guests that I know of 
just makes the patch more complex for no good reason. So I don't see why 
these should matter now or be modelled unless we know this make a 
difference. We have other differences in other regs too that we don't care 
about. Why these should be important to match?

> On the legacy ports being present on Linux, that is to be expected when 
> setting the hardware to legacy mode which Linux does by writing 0x8a to 
> PCI_CLASS_PROG. Why the BARs are still active in legacy mode is the better 
> question to ask, but we won't know for sure unless someone can give me access 
> to real hardware. The fact the legacy ports are there isn't an issue even if 
> BARs are active as firmware avoids assigning PCI IO memory below 0x400 to 
> avoid clashes with legacy and/or buggy hardware.

Exactly because we can't answer these questions is why I think we should 
postpone this debate to when we have more information and answers as the 
change I proposed does not prevent this to be done later. Unless we find 
issue with my patch that cause a problem in a guest I don't see a need to 
make it more complex now. Your patch adds dependeny on portio that's not 
yet cleanly separated from ISA, dependency on ISA_IDE not marked in 
Kconfig (although likely satisfied by VT82C686) and causes two mappings of 
IDE ports in legacy mode which we are not sure matches real hardware so 
I'd argue my patch is a smaller change that's good enough to make some 
progress now and all these can be sorted out any time later without doing 
it all now.

>> Therefore I think we should go with my patch for now to not hold up adding 
>> amigaone machine and allow progress with it and then when you have more 
>> time to elaborate this idea of using portio_list to remove the FIXME 
>> comments from this PoC patch we can revisit this any time later. There's no 
>> reason to hold other's work back to get this sorted out now and solving a 
>> problem with my patch now does not mean we cannot improve this device model 
>> further in the future. So if you can't make this a clean patch now that can 
>> replace my patch please let my patch accepted until you can make this a 
>> viable alternative. For now this just seems like an idea that needs more 
>> work but not ready yet.
>
> How is this holding your work back? I've pointed out the issues with your

I think I answered that above but the point is that my goal is to add 
amigaone machine and this is a prerequisite for that. The patch I proposed 
is a simple fix allowing that while yours is more complex and not yet 
completely elaborated so I don't want this to hold back progress with 
amigaone, especially because my patch would not hold back your 
consolidation of this any time later.

> patch and provided you a near complete solution that i) you have confirmed 
> working with your guests, ii) allows further work from myself and others in 
> this area and iii) matches the information in the hardware dumps you provided 
> from real hardware. I think it's fair to say that both ii) and iii) are 
> notable improvements on your existing patch.

I don't say my patch is perfect and cannot be improved. What I say is that 
my patch solves the problem for now, does not make the model worse than it 
is and does not prevent your work in this area as it's easy to later 
replace that with your way when the still open questions about that are 
resolved. You blocking my patch to do all that now howaver would block my 
work on amigaone machine therefore I'd like to get a solution to this 
that's acceptable as soon as possible.

> The FIXMEs are there because this patch comes from a branch with further work 
> in this area: the only thing that remains are to split out the 
> ide_portio_list[] and ide_portio2_list[] arrays so they can be reused from 
> hw/ide/ioport.c and delete the second FIXME comment.
>
> I'm sure you're more than capable of making these changes, and I'd appreciate 
> that given my current time constraints. If not, then I can do this but it 
> won't be for a few days - fortunately freeze is still a few weeks away, so 
> there is no need for immediate urgency.

I also have time constraints and plan to furhtet improve amigaone machine 
rather than spending more time with this vie-ide model now that my simple 
patch already makes it suitable for amigaone without breaking what already 
works. Also I don't see your future plans with these and don't see where 
these are going so to me this looks just unnecessary compication that I'm 
not keen on working when I don't see why this would be necessary. So I 
think it would be best if we could agree on some solution that's 
acceptable for now and I don't mind getting back to it later and further 
improve it when it's found necessary or you finish these patches but I 
don't see this as something that needs to be done now or blocking the 
series. You were just reminded about it by this change and want to solve 
it now in a much more elaborate way than probably necessary.

Because of that if you can finish it at least 2 weeks before the freeze 
(that means practically this week or by next Monday latest) to make sure 
they don't miss the next release I'm OK with your proposed patch too but I 
don't have time and interest to realise your plans that you don't have 
time now (but that's also not needed as if you can't do it now I already 
have a working patch and that does not mean it can't be done later). I 
hope we can agree on that and you understand my point of view as well.

Regards,
BALATON Zoltan
--3866299591-1928978844-1697578788=:50058--

