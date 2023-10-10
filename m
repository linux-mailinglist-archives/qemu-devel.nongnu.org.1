Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E127BEF6E
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 02:02:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq0Bq-00052K-TT; Mon, 09 Oct 2023 20:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qq0Bp-00050Y-2m; Mon, 09 Oct 2023 20:01:33 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qq0Bl-00005s-0E; Mon, 09 Oct 2023 20:01:32 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 1810874632B;
 Tue, 10 Oct 2023 02:00:32 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A4D1A7456A7; Tue, 10 Oct 2023 02:00:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A1FDA745681;
 Tue, 10 Oct 2023 02:00:31 +0200 (CEST)
Date: Tue, 10 Oct 2023 02:00:31 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org, 
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>, 
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Subject: Re: [PATCH 1/3] via-ide: Fix legacy mode emulation
In-Reply-To: <caa800b6-3937-4f2c-a2ba-770b18bfbe82@ilande.co.uk>
Message-ID: <6717780c-b572-0c60-8a54-f145da9b3cda@eik.bme.hu>
References: <cover.1696542537.git.balaton@eik.bme.hu>
 <12ce9caa682545cd43318c4679530202140117c0.1696542537.git.balaton@eik.bme.hu>
 <33347356-be91-4dde-8535-5a59ee1c80f1@ilande.co.uk>
 <a7821bf0-5d1f-ddda-f408-f4cd0432ddbf@eik.bme.hu>
 <881c3003-9e20-4f35-961e-976134b1afc7@ilande.co.uk>
 <72722073-0dc5-9936-1dcb-0d39760c5918@eik.bme.hu>
 <caa800b6-3937-4f2c-a2ba-770b18bfbe82@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1347571116-1696896031=:30885"
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

--3866299591-1347571116-1696896031=:30885
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 9 Oct 2023, Mark Cave-Ayland wrote:
> On 09/10/2023 23:23, BALATON Zoltan wrote:
>> On Mon, 9 Oct 2023, Mark Cave-Ayland wrote:
>>> On 08/10/2023 12:08, BALATON Zoltan wrote:
>>> 
>>>> On Sun, 8 Oct 2023, Mark Cave-Ayland wrote:
>>>>> On 05/10/2023 23:13, BALATON Zoltan wrote:
>>>>> 
>>>>>> The initial value for BARs were set in reset method for emulating
>>>>>> legacy mode at start but this does not work because PCI code resets
>>>>>> BARs after calling device reset method.
>>>>> 
>>>>> This is certainly something I've noticed when testing previous versions 
>>>>> of the VIA patches. Perhaps it's worth a separate thread to the PCI 
>>>>> devs?
>>>> 
>>>> I think I brought up this back then but was told current PCI code won't 
>>>> change and since that could break everything else that makes sense so 
>>>> this is something that we should take as given and accomodate that.
>>> 
>>> I don't remember the details of that thread, but that's not too much of an 
>>> issue here as the values won't be used.
>>> 
>>>>>> Additionally the values
>>>>>> written to BARs were also wrong.
>>>>> 
>>>>> I don't believe this is correct: according to the datasheet the values 
>>>>> on reset are the ones given in the current reset code, so even if the 
>>>>> reset function is overridden at a later data during PCI bus reset, I 
>>>>> would leave these for now since it is a different issue.
>>>> 
>>>> Those values are missing the IO space bit for one so they can't be 
>>>> correct as a BAR value no matter what the datasheet says. And since they 
>>>> are ineffective now I think it's best to remove them to avoid confusion.
>>> 
>>> Maybe, or perhaps just fix up the missing IO space bit and add a comment 
>>> pointing out these are the defaults, but currently they are erased on PCI 
>>> bus reset? I have found it useful to have the values around to save having 
>>> to reference the datasheet.
>> 
>> The data sheet does not list the io space bits so fixing that would lead to 
>> values not matching data sheet any more. Also the defaults in the data 
>> sheet don't make much sense even with io space but as some of them match 
>> legacy ports while others don't. I can either drop this hunk leaving the 
>> current values there or add a FIXME comment saying they are ineffective but 
>> because they are overwritten (either by PCI code now or firmware/guest 
>> later) I think it's best to remove them any maybe only bring them back if 
>> we find they would be needed for any guest and what would be the correct 
>> default valuss here. I don't trust the data sheet on that and getting it 
>> from real hardware is also not really possible because the firmware could 
>> have overwritten them by the time you can get them. So I don't think 
>> keeping these here would help anybody, just cause confusion.
>
> We can check the values on real hardware given the Forth in my previous reply 
> which will then tell us the correct values for once and for all. My guess is 
> that since the address is a separate field to the BAR type in the datasheet, 
> the IO bit was simply missed.

I only have device tree dump from real pegasos2 but it has BARs so you 
can see here:

package 0xFC5CE70 /pci/ide:
     parent=0xFC58E08
     children=0xFC5D418
     link=0xFC5D948
     dict=0xFC5CEA0:
         open                  func[0x11F4]
         close                 func[0x11F5]
         dma-alloc             func[0x11F6]
         dma-free              func[0x11F7]
         decode-unit           func[0x11F8]
         encode-unit           func[0x11F9]
         selftest              func[0x11FA]
     props=0xFC5CEB8:
         vendor-id             0x1106 (4358)
         device-id             0x571 (1393)
         revision-id           0x6 (6)
         class-code            0x1018F (65935)
         subsystem-id          0x0 (0)
         subsystem-vendor-id   0x0 (0)
         .vendor-name          "VIA"
         .part-number          "VT82C586/596/686"
         .description          "PCI IDE Controller"
         interrupts            0x1 (1)
         devsel-speed          0x1 (1)
         fast-back-to-back
         min-grant             0x0 (0)
         max-latency           0x0 (0)
         name                  "ide"
         reg                   C,1:0
                               iC,1,10,0:8
                               iC,1,14,0:4
                               iC,1,18,0:8
                               iC,1,1C,0:4
                               iC,1,20,0:10
         device_type           "spi"
         assigned-addresses    iC,1,10,FE001000:8
                               iC,1,14,FE00100C:4
                               iC,1,18,FE001010:8
                               iC,1,1C,FE00101C:4
                               iC,1,20,FE001020:10

That means by the time you could run your Forth the firmware already set 
the IDE device up se we get the same values as in Linux. If you want to 
see how the firmware progrems it you can find out with the emulated 
pegasos2 using -bios pegasos2.rom and enabling pci traces, but we can't 
find out what are the default values on real machine before this without 
replacing firmware that likely nobody dares to try. So just let it go and 
accept that whatever defaults are there, they don't matter because the 
firmware on pegasos2 overwrites them and the firmware on amigaone sets 
legacy mode so it should use legacy ports there and if anything switches 
to native mode later then it will also program BARs so it really does not 
matter what the data sheet says, what real hardware does and weather we 
put any default valiues there in QEMU or not (especially with PCI code 
resetting it to 0 now anyway). So I think the way to go is to get rid of 
these lines and don't bother with it until we find something that depends 
on defaults but that's very unlilkely as even in PCs the BIOS would 
program it or if you boot an OS then that will either use legacy mode or 
it programs the device as a PCI deviec and sets BARs. I can't imagine 
anything just setting native mode and then not change BARs and on real 
hardware it can't do that before firmware that most likely has already 
overwritten defaults according to BIOS setup where you can usually select 
native or legacy mode so what we need to match here is how it is after 
firmware.

>>>>>> Move setting the BARs to a callback on writing the PCI config regsiter
>>>>>> that sets the compatibility mode (which firmwares needing this mode
>>>>>> seem to do) and fix their values to program it to use legacy port
>>>>>> numbers. As noted in a comment, we only do this when the BARs were
>>>>>> unset before, because logs from real machine show this is how real
>>>>>> chip works, even if it contradicts the data sheet which is not very
>>>>>> clear about this.
>>>>>> 
>>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>>> ---
>>>>>>   hw/ide/via.c | 35 ++++++++++++++++++++++++++++++-----
>>>>>>   1 file changed, 30 insertions(+), 5 deletions(-)
>>>>>> 
>>>>>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>>>>>> index fff23803a6..8186190207 100644
>>>>>> --- a/hw/ide/via.c
>>>>>> +++ b/hw/ide/via.c
>>>>>> @@ -132,11 +132,6 @@ static void via_ide_reset(DeviceState *dev)
>>>>>>       pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_FAST_BACK |
>>>>>>                    PCI_STATUS_DEVSEL_MEDIUM);
>>>>>>   -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_0, 0x000001f0);
>>>>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_1, 0x000003f4);
>>>>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
>>>>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
>>>>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 
>>>>>> 20-23h */
>>>>>>       pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
>>>>>>         /* IDE chip enable, IDE configuration 1/2, IDE FIFO 
>>>>>> Configuration*/
>>>>>> @@ -159,6 +154,35 @@ static void via_ide_reset(DeviceState *dev)
>>>>>>       pci_set_long(pci_conf + 0xc0, 0x00020001);
>>>>>>   }
>>>>>>   +static void via_ide_cfg_write(PCIDevice *pd, uint32_t addr,
>>>>>> +                              uint32_t val, int len)
>>>>>> +{
>>>>>> +    pci_default_write_config(pd, addr, val, len);
>>>>>> +    /*
>>>>>> +     * Only set BARs if they are unset. Logs from real hardware show 
>>>>>> that
>>>>>> +     * writing class_prog to enable compatibility mode after BARs were 
>>>>>> set
>>>>>> +     * (possibly by firmware) it will use ports set by BARs not ISA 
>>>>>> ports
>>>>>> +     * (e.g. pegasos2 Linux does this and calls it non-100% native 
>>>>>> mode).
>>>>> 
>>>>> Can you remind me again where the references are to non-100% native 
>>>>> mode? The only thing I can find in Linux is 
>>>>> https://github.com/torvalds/linux/blob/master/arch/powerpc/platforms/chrp/pci.c#L360 
>>>>> but that simply forces a switch to legacy mode, with no mention of 
>>>>> "non-100% native mode".
>>>> 
>>>> It was discussed somewhere in the via-ide thread we had when this was 
>>>> last touched for pegasos2 in March 2020. Basically the non-100% native 
>>>> mode is when ports are set by BARs but IRQs are still hard coded to 
>>>> 14-15. Linux can work with all 3 possible modes: legacy (both ports and 
>>>> IRQs are hard coded to ISA values), native (using BARs and PCI config 
>>>> 0x3c for a single interrupt for both channels, vt82c686 data sheet does 
>>>> not document this but vt8231 has a comment saying native mode only) and 
>>>> non-100% native mode where BARs are effective to set port addresses but 
>>>> IRQs don't respect 0x3c but use 14-15 as in legacy mode. Some machines 
>>>> only work in non-100% native mode such as pegasos2 and Linux has some 
>>>> quirks for this. Other OSes running on this machine work with what the 
>>>> firmware has set up and can't work with anything else so we need to 
>>>> emulate what those OSes want (which matches real hardware) because Linux 
>>>> can usually cope anyway. On pegasso2 MorphOS uses BARs but expects IRQ 
>>>> 14-15 which is what the firmware also sets up by setting mode to native 
>>>> in the PCI config of the IDE func yet IRQs are fixed at 14-15. Linux 
>>>> forces its driver to use legacy interrupts by setting mode back to legacy 
>>>> but it still uses BARs and this is what it calls non-100% native mode. On 
>>>> amigaone firmware sets legacy mode and AmigaOS does not change this but 
>>>> uses it with legacy ports and IRQs. Linux finds the same and uses legacy 
>>>> mode on amigaone.
>>> 
>>> Thanks for summarising: there have been a number of threads and changes 
>>> over the years, so it is easy to lose track of where things are. From the 
>>> above then everything except MorphOS that explicitly sets legacy/native 
>>> mode should just work?
>> 
>> No, everything but Linux (i.e. MorphOS and AmigaOS) only work with 
>> behaviour matching real hardware which is BARs + legacy interrupts. Linux 
>> may work with other settings but it also has fix ups to detect and work 
>> with the non-100% native mode as on real hardware. (I think this non-100% 
>> native mode was used hy the older Linus via ata driver before it was ported 
>> to libata and became pata_via as I remember seeing these in older logs but 
>> not in newer ones any more which just list IRQs and port numbers from which 
>> you can tell it's neither the legacy nor the native mode described in the 
>> data sheet but a mix between the two.)
>> 
>>> Just to double check I don't think we ever managed to get the PCI 
>>> configuration information from real hardware to confirm how the hardware 
>>> thinks it is set? Is it possible to dump the PCI config space of the 
>>> PCI-ISA bridge and the VIA IDE from a real Pegasos2 booted into Smart 
>>> Firmware? You can get the information using the Forth below:
>>> 
>>> 
>>> : dump-single-config ( addr )
>>>  dup 100 + swap do i u. " : " type i " config-b@" $call-parent u. cr loop
>>> ;
>>> 
>>> " /pci@80000000/isa@C" open-dev to my-self
>>> 800 c * 100 0 * + dump-single-config cr cr
>>> 800 c * 100 1 * + dump-single-config cr cr
>> 
>> I don't have dumps from firmware but got an lspci output from Linux from 
>> real pegasos2 which says:
>
> Ah no that won't work because Linux has already made changes to PCI 
> configuration space. What we need is the value from the firmware to confirm 
> exactly how the hardware has been configured before the kernel has loaded (as 
> you mentioned above). Who can we ask to get this information?
>
>> 0000:00:0c.1 IDE interface: VIA Technologies, Inc. 
>> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 
>> 8a [Master SecP PriP])
>>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>          Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>          Latency: 0
>>          Interrupt: pin ? routed to IRQ 14
>
> Now this is interesting - I wonder what "?" means here? Perhaps the switch to 
> compatibility mode has set the PCI interrupt pin to 0? Oh and what kernel 
> version is this?

I think:

[    0.000000] Linux version 3.16.0-6-powerpc (debian-kernel@lists.debian.org) (gcc version 4.8.4 (Debian 4.8.4-1) ) #1 Debian 3.16.56-1+deb8u1 (2018-05-08)

but I got logs in different files so not entirely sure.

>>          Region 0: [virtual] I/O ports at 1000 [size=8]
>>          Region 1: [virtual] I/O ports at 100c [size=4]
>>          Region 2: [virtual] I/O ports at 1010 [size=8]
>>          Region 3: [virtual] I/O ports at 101c [size=4]
>>          Region 4: I/O ports at 1020 [size=16]
>>          Capabilities: [c0] Power Management version 2
>>                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                  Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>          Kernel driver in use: pata_via
>> 
>> This says prog_if is 0x8a (probably set by Linux fixup as firmware sets it 
>> to native) but still uses BARs for ports and legacy interrupts although 
>> only says 14 above but in dmesg it listed interruts for the channels as 
>> quoted in reply to Bernhard. Also got /proc infos from same machine that 
>> says:
>> 
>> /proc/ioports:   00001000-00001007 : 0000:00:0c.1
>> /proc/ioports:     00001000-00001007 : pata_via
>> /proc/ioports:   0000100c-0000100f : 0000:00:0c.1
>> /proc/ioports:     0000100c-0000100f : pata_via
>> /proc/ioports:   00001010-00001017 : 0000:00:0c.1
>> /proc/ioports:     00001010-00001017 : pata_via
>> /proc/ioports:   0000101c-0000101f : 0000:00:0c.1
>> /proc/ioports:     0000101c-0000101f : pata_via
>> /proc/ioports:   00001020-0000102f : 0000:00:0c.1
>> /proc/ioports:     00001020-0000102f : pata_via
>
> Interesting. The PCI-IDE specification states that the BAR values are ignored 
> in compatibility mode, so it could be that they contain values left over from 
> the firmware they are not being actively decoded on the bus. They certainly 
> look similar to the values set by the firmware.

These are the values set by the firmware as you can see from the device 
tree dump above.

> In fact it would be possible to write some Forth to switch to compatibility 
> mode in the firmware and then try and access the BARs to confirm whether or 
> not the BARs are really being decoded.

So Linux does that on boot by writing 0x8a to prog_if when forcing legacy 
mode in fix up and then still uses BARs so I think that confirms it works 
like that even in legacy mode unless the BARs are unset which is what 
happens on the amigaone that only writes 0x8a even though that should be 
the default (again you can check this with the emulated machine).

>> /proc/interrupts:  14:       1847     i8259  14 Level     pata_via
>> /proc/interrupts:  15:       1210     i8259  15 Level     pata_via
>> 
>> So what other proof you still need to believe this is how it works on real 
>> machine?
>
> Again this would have been overwritten by the switch to compatibility mode.

But I think AmigaOS and MorphOS do not switch to legacy mode and still use 
BARs and legacy IRQs as set by the firmware. These now boot so our device 
model is matching real hardware well enough.

>>> With the corresponding MorphOS debug log that will help to confirm the 
>>> routing being used. Also it would be useful to get the output of any 
>>> MorphOS program that can dump the current kernel IRQ routing 
>>> configuration.
>> 
>> MorphOS does not give much debug logs but it works currenntly as well as 
>> AmigaOS and Linux so what we have now is good enough and this patch does 
>> not break that.
>
> It looks like you can get PCI debug logs, at least that seems work here on 
> QEMU. They would be very useful to understand the exact behaviour.
>
>>> The reason for wanting to double-check this now is because my work with 
>>> the Mac q800 machine showed that both legacy and modern IRQ routing 
>>> worked, so it would be good to confirm exactly what IRQ is currently 
>>> active on real hardware.
>> 
>> What does q800 has to do with VT8231 and pegaos2? These are totally 
>> different hardware and software designed by separate people so other than 
>> you were looking at both there's no connection to consider between these.
>
> The point I was making was that there may be multiple IRQ routing 
> possibilities for the IDE controller, in which case it makes sense to be 
> absolutely sure which one is being used on real hardware.
>
>>>>>> +     * But if 0x8a is written after reset without setting BARs then we 
>>>>>> want
>>>>>> +     * legacy ports (this is done by AmigaOne firmware for example).
>>>>>> +     */
>>>>> 
>>>>> What should happen here is that writing 0x8a should *always* switch to 
>>>>> legacy mode, so the BARs are unused...
>>>> 
>>>> Yes, but as we've found before that can't be emulated in QEMU due to ISA 
>>>> emulation being static and only allows adding ports but not removing them 
>>>> later
>>> 
>>> Fortunately this bug has been fixed, so it should now be possible using 
>>> portio_list_*() functions: see 
>>> https://gitlab.com/qemu-project/qemu/-/commit/690705ca0b0f1ed24a34ccd14c9866fbe47c69a6. 
>>> With that (and a bit of refactoring to allow the sharing of the IDE ioport 
>>> list) I was able to switch between compatibility and native modes at will 
>>> in my PoC. Once that is working then it doesn't matter if the default BARs 
>>> aren't set correctly.
>> 
>> Great but maybe that's not needed because firmware and guests usually 
>> configure this once at boot then use it with that setting without ever 
>> switching it again so this simple patch allows that to work without 
>> breaking what's there and tested already so I'd like this to be merged 
>> first with the amigaone machine then if you want to rewrite it later to 
>> emulate the chip more closely then we have at least two test cases with 
>> pegasos2 and amigaone to verify evertyhing still works correctly. But since 
>> this patch allows all guests to boot it may be a waste of time to try to 
>> patch this emulation further to add functionality that won't be used by 
>> anything. But if it keeps working like this patch does and still boots the 
>> guests this one allows I don't care that much about that.
>
> The ultimate aim is to combine mine and Bernhard's work so that the 
> compatibility mode/PCI native mode switch is handle automatically by the PCI 
> IDE core, so it's something that would not just be restricted to the VIA.

OK but that should be done separately and not intermixed/blocking this 
series as this model can later be changed but I'd like to get amigaone 
working now so a later goal should not prevent that now.

I'm not sure your goal can be achieved though because these different 
south bridges may have some differences so not sure they can be handled 
the same way. I'd expect Intel PIIX models to be similar and VIA chips be 
similar so these can share code within the same family but just as Intel 
ac97 is different than VIA ac97 their IDE parts may also not behave the 
same so these may need to be modelled separately. We can try to find that 
out as long as it does not block people using these machines now.

Regards,
BALATON Zoltan

> ATB,
>
> Mark.
--3866299591-1347571116-1696896031=:30885--

