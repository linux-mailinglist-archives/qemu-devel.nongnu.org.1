Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 094007BEEA6
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 01:00:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpzDx-00055d-Jg; Mon, 09 Oct 2023 18:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpzDv-00054z-8s; Mon, 09 Oct 2023 18:59:39 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpzDs-0003iK-FO; Mon, 09 Oct 2023 18:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q+p4Bp4Q08FyOzJ8d3fVZADC8bDZQwgxpawaTd39aGI=; b=Gll/0PHALEOxLrnGF5oMZTrdXn
 ++MKAAeCZA1kwWRq8d8LhIng9/Dd0+fohBrrluTsGuQnSVnpth9jY/eLd4kAgwE6GU1yi5hpoQwQT
 t2Ha2U6fMhQuLOE58Fb8brOyJdKb4OJNmttSof2Isnst+dBBD0ZK8+nBiquYFUlZljNHi7tWBbjLn
 5xydK/dvZuNbJQDvMfrJXwtb8QFfucgmMp4PJyX2qBpwXl0sauSbpxNSISyoWGqk6XTOLCiSLA1n5
 j9teCG82tL+kzFvcDF/5AXrlCbUzOD9QOF3Y/b09ytpbbzBYyTeQ4ihypnnbm1oIAnhv00sZnMxD8
 zh9KKpM53A8uLdTp+8mkp5ryeGi1upZMxmQqnaqnnWcWXx/PtiU/v2IK7DCdcDJlhOF3P6oewE3TD
 zoZhyUlpGKeNeA/a/wQ1ahB7PlANtGNkLgXB4/fsf1XeD4Mt0BWwcQYIXpw3QSzTJd74MJPNHOqHJ
 eadrUTd43Xw3IRvHlE3o59f17YQZqH6ilF67fo9OEWeC04GGtGJVSRMX3U5Yhoxk5E/wmIvlyWR1G
 JK6aJAOc19pwG+qapaSq2kRiiWwT0CjglUBinx0SFCHTs4ACxtGrbDYM8o49dsNvbhFQIdWT9CoDI
 YZ5fcrPBZ2VA/BY5TzWsBW97XJGeP7PCI56CNlKio=;
Received: from [2a00:23c4:8baf:fd00:bd92:8220:89aa:44b7]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpzDk-0006Mz-7n; Mon, 09 Oct 2023 23:59:32 +0100
Message-ID: <caa800b6-3937-4f2c-a2ba-770b18bfbe82@ilande.co.uk>
Date: Mon, 9 Oct 2023 23:59:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
References: <cover.1696542537.git.balaton@eik.bme.hu>
 <12ce9caa682545cd43318c4679530202140117c0.1696542537.git.balaton@eik.bme.hu>
 <33347356-be91-4dde-8535-5a59ee1c80f1@ilande.co.uk>
 <a7821bf0-5d1f-ddda-f408-f4cd0432ddbf@eik.bme.hu>
 <881c3003-9e20-4f35-961e-976134b1afc7@ilande.co.uk>
 <72722073-0dc5-9936-1dcb-0d39760c5918@eik.bme.hu>
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
In-Reply-To: <72722073-0dc5-9936-1dcb-0d39760c5918@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:fd00:bd92:8220:89aa:44b7
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 1/3] via-ide: Fix legacy mode emulation
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

On 09/10/2023 23:23, BALATON Zoltan wrote:

> On Mon, 9 Oct 2023, Mark Cave-Ayland wrote:
>> On 08/10/2023 12:08, BALATON Zoltan wrote:
>>
>>> On Sun, 8 Oct 2023, Mark Cave-Ayland wrote:
>>>> On 05/10/2023 23:13, BALATON Zoltan wrote:
>>>>
>>>>> The initial value for BARs were set in reset method for emulating
>>>>> legacy mode at start but this does not work because PCI code resets
>>>>> BARs after calling device reset method.
>>>>
>>>> This is certainly something I've noticed when testing previous versions of the 
>>>> VIA patches. Perhaps it's worth a separate thread to the PCI devs?
>>>
>>> I think I brought up this back then but was told current PCI code won't change and 
>>> since that could break everything else that makes sense so this is something that 
>>> we should take as given and accomodate that.
>>
>> I don't remember the details of that thread, but that's not too much of an issue 
>> here as the values won't be used.
>>
>>>>> Additionally the values
>>>>> written to BARs were also wrong.
>>>>
>>>> I don't believe this is correct: according to the datasheet the values on reset 
>>>> are the ones given in the current reset code, so even if the reset function is 
>>>> overridden at a later data during PCI bus reset, I would leave these for now 
>>>> since it is a different issue.
>>>
>>> Those values are missing the IO space bit for one so they can't be correct as a 
>>> BAR value no matter what the datasheet says. And since they are ineffective now I 
>>> think it's best to remove them to avoid confusion.
>>
>> Maybe, or perhaps just fix up the missing IO space bit and add a comment pointing 
>> out these are the defaults, but currently they are erased on PCI bus reset? I have 
>> found it useful to have the values around to save having to reference the datasheet.
> 
> The data sheet does not list the io space bits so fixing that would lead to values 
> not matching data sheet any more. Also the defaults in the data sheet don't make much 
> sense even with io space but as some of them match legacy ports while others don't. I 
> can either drop this hunk leaving the current values there or add a FIXME comment 
> saying they are ineffective but because they are overwritten (either by PCI code now 
> or firmware/guest later) I think it's best to remove them any maybe only bring them 
> back if we find they would be needed for any guest and what would be the correct 
> default valuss here. I don't trust the data sheet on that and getting it from real 
> hardware is also not really possible because the firmware could have overwritten them 
> by the time you can get them. So I don't think keeping these here would help anybody, 
> just cause confusion.

We can check the values on real hardware given the Forth in my previous reply which 
will then tell us the correct values for once and for all. My guess is that since the 
address is a separate field to the BAR type in the datasheet, the IO bit was simply 
missed.

>>>>> Move setting the BARs to a callback on writing the PCI config regsiter
>>>>> that sets the compatibility mode (which firmwares needing this mode
>>>>> seem to do) and fix their values to program it to use legacy port
>>>>> numbers. As noted in a comment, we only do this when the BARs were
>>>>> unset before, because logs from real machine show this is how real
>>>>> chip works, even if it contradicts the data sheet which is not very
>>>>> clear about this.
>>>>>
>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>> ---
>>>>>   hw/ide/via.c | 35 ++++++++++++++++++++++++++++++-----
>>>>>   1 file changed, 30 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>>>>> index fff23803a6..8186190207 100644
>>>>> --- a/hw/ide/via.c
>>>>> +++ b/hw/ide/via.c
>>>>> @@ -132,11 +132,6 @@ static void via_ide_reset(DeviceState *dev)
>>>>>       pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_FAST_BACK |
>>>>>                    PCI_STATUS_DEVSEL_MEDIUM);
>>>>>   -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_0, 0x000001f0);
>>>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_1, 0x000003f4);
>>>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
>>>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
>>>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 20-23h */
>>>>>       pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
>>>>>         /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configuration*/
>>>>> @@ -159,6 +154,35 @@ static void via_ide_reset(DeviceState *dev)
>>>>>       pci_set_long(pci_conf + 0xc0, 0x00020001);
>>>>>   }
>>>>>   +static void via_ide_cfg_write(PCIDevice *pd, uint32_t addr,
>>>>> +                              uint32_t val, int len)
>>>>> +{
>>>>> +    pci_default_write_config(pd, addr, val, len);
>>>>> +    /*
>>>>> +     * Only set BARs if they are unset. Logs from real hardware show that
>>>>> +     * writing class_prog to enable compatibility mode after BARs were set
>>>>> +     * (possibly by firmware) it will use ports set by BARs not ISA ports
>>>>> +     * (e.g. pegasos2 Linux does this and calls it non-100% native mode).
>>>>
>>>> Can you remind me again where the references are to non-100% native mode? The 
>>>> only thing I can find in Linux is 
>>>> https://github.com/torvalds/linux/blob/master/arch/powerpc/platforms/chrp/pci.c#L360 but that simply forces a switch to legacy mode, with no mention of "non-100% native mode".
>>>
>>> It was discussed somewhere in the via-ide thread we had when this was last touched 
>>> for pegasos2 in March 2020. Basically the non-100% native mode is when ports are 
>>> set by BARs but IRQs are still hard coded to 14-15. Linux can work with all 3 
>>> possible modes: legacy (both ports and IRQs are hard coded to ISA values), native 
>>> (using BARs and PCI config 0x3c for a single interrupt for both channels, vt82c686 
>>> data sheet does not document this but vt8231 has a comment saying native mode 
>>> only) and non-100% native mode where BARs are effective to set port addresses but 
>>> IRQs don't respect 0x3c but use 14-15 as in legacy mode. Some machines only work 
>>> in non-100% native mode such as pegasos2 and Linux has some quirks for this. Other 
>>> OSes running on this machine work with what the firmware has set up and can't work 
>>> with anything else so we need to emulate what those OSes want (which matches real 
>>> hardware) because Linux can usually cope anyway. On pegasso2 MorphOS uses BARs but 
>>> expects IRQ 14-15 which is what the firmware also sets up by setting mode to 
>>> native in the PCI config of the IDE func yet IRQs are fixed at 14-15. Linux forces 
>>> its driver to use legacy interrupts by setting mode back to legacy but it still 
>>> uses BARs and this is what it calls non-100% native mode. On amigaone firmware 
>>> sets legacy mode and AmigaOS does not change this but uses it with legacy ports 
>>> and IRQs. Linux finds the same and uses legacy mode on amigaone.
>>
>> Thanks for summarising: there have been a number of threads and changes over the 
>> years, so it is easy to lose track of where things are. From the above then 
>> everything except MorphOS that explicitly sets legacy/native mode should just work?
> 
> No, everything but Linux (i.e. MorphOS and AmigaOS) only work with behaviour matching 
> real hardware which is BARs + legacy interrupts. Linux may work with other settings 
> but it also has fix ups to detect and work with the non-100% native mode as on real 
> hardware. (I think this non-100% native mode was used hy the older Linus via ata 
> driver before it was ported to libata and became pata_via as I remember seeing these 
> in older logs but not in newer ones any more which just list IRQs and port numbers 
> from which you can tell it's neither the legacy nor the native mode described in the 
> data sheet but a mix between the two.)
> 
>> Just to double check I don't think we ever managed to get the PCI configuration 
>> information from real hardware to confirm how the hardware thinks it is set? Is it 
>> possible to dump the PCI config space of the PCI-ISA bridge and the VIA IDE from a 
>> real Pegasos2 booted into Smart Firmware? You can get the information using the 
>> Forth below:
>>
>>
>> : dump-single-config ( addr )
>>  dup 100 + swap do i u. " : " type i " config-b@" $call-parent u. cr loop
>> ;
>>
>> " /pci@80000000/isa@C" open-dev to my-self
>> 800 c * 100 0 * + dump-single-config cr cr
>> 800 c * 100 1 * + dump-single-config cr cr
> 
> I don't have dumps from firmware but got an lspci output from Linux from real 
> pegasos2 which says:

Ah no that won't work because Linux has already made changes to PCI configuration 
space. What we need is the value from the firmware to confirm exactly how the 
hardware has been configured before the kernel has loaded (as you mentioned above). 
Who can we ask to get this information?

> 0000:00:0c.1 IDE interface: VIA Technologies, Inc. 
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master 
> SecP PriP])
>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx-
>          Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
> <MAbort- >SERR- <PERR- INTx-
>          Latency: 0
>          Interrupt: pin ? routed to IRQ 14

Now this is interesting - I wonder what "?" means here? Perhaps the switch to 
compatibility mode has set the PCI interrupt pin to 0? Oh and what kernel version is 
this?

>          Region 0: [virtual] I/O ports at 1000 [size=8]
>          Region 1: [virtual] I/O ports at 100c [size=4]
>          Region 2: [virtual] I/O ports at 1010 [size=8]
>          Region 3: [virtual] I/O ports at 101c [size=4]
>          Region 4: I/O ports at 1020 [size=16]
>          Capabilities: [c0] Power Management version 2
>                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                  Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>          Kernel driver in use: pata_via
> 
> This says prog_if is 0x8a (probably set by Linux fixup as firmware sets it to native) 
> but still uses BARs for ports and legacy interrupts although only says 14 above but 
> in dmesg it listed interruts for the channels as quoted in reply to Bernhard. Also 
> got /proc infos from same machine that says:
> 
> /proc/ioports:   00001000-00001007 : 0000:00:0c.1
> /proc/ioports:     00001000-00001007 : pata_via
> /proc/ioports:   0000100c-0000100f : 0000:00:0c.1
> /proc/ioports:     0000100c-0000100f : pata_via
> /proc/ioports:   00001010-00001017 : 0000:00:0c.1
> /proc/ioports:     00001010-00001017 : pata_via
> /proc/ioports:   0000101c-0000101f : 0000:00:0c.1
> /proc/ioports:     0000101c-0000101f : pata_via
> /proc/ioports:   00001020-0000102f : 0000:00:0c.1
> /proc/ioports:     00001020-0000102f : pata_via

Interesting. The PCI-IDE specification states that the BAR values are ignored in 
compatibility mode, so it could be that they contain values left over from the 
firmware they are not being actively decoded on the bus. They certainly look similar 
to the values set by the firmware.

In fact it would be possible to write some Forth to switch to compatibility mode in 
the firmware and then try and access the BARs to confirm whether or not the BARs are 
really being decoded.

> /proc/interrupts:  14:       1847     i8259  14 Level     pata_via
> /proc/interrupts:  15:       1210     i8259  15 Level     pata_via
> 
> So what other proof you still need to believe this is how it works on real machine?

Again this would have been overwritten by the switch to compatibility mode.

>> With the corresponding MorphOS debug log that will help to confirm the routing 
>> being used. Also it would be useful to get the output of any MorphOS program that 
>> can dump the current kernel IRQ routing configuration.
> 
> MorphOS does not give much debug logs but it works currenntly as well as AmigaOS and 
> Linux so what we have now is good enough and this patch does not break that.

It looks like you can get PCI debug logs, at least that seems work here on QEMU. They 
would be very useful to understand the exact behaviour.

>> The reason for wanting to double-check this now is because my work with the Mac 
>> q800 machine showed that both legacy and modern IRQ routing worked, so it would be 
>> good to confirm exactly what IRQ is currently active on real hardware.
> 
> What does q800 has to do with VT8231 and pegaos2? These are totally different 
> hardware and software designed by separate people so other than you were looking at 
> both there's no connection to consider between these.

The point I was making was that there may be multiple IRQ routing possibilities for 
the IDE controller, in which case it makes sense to be absolutely sure which one is 
being used on real hardware.

>>>>> +     * But if 0x8a is written after reset without setting BARs then we want
>>>>> +     * legacy ports (this is done by AmigaOne firmware for example).
>>>>> +     */
>>>>
>>>> What should happen here is that writing 0x8a should *always* switch to legacy 
>>>> mode, so the BARs are unused...
>>>
>>> Yes, but as we've found before that can't be emulated in QEMU due to ISA emulation 
>>> being static and only allows adding ports but not removing them later
>>
>> Fortunately this bug has been fixed, so it should now be possible using 
>> portio_list_*() functions: see 
>> https://gitlab.com/qemu-project/qemu/-/commit/690705ca0b0f1ed24a34ccd14c9866fbe47c69a6. With that (and a bit of refactoring to allow the sharing of the IDE ioport list) I was able to switch between compatibility and native modes at will in my PoC. Once that is working then it doesn't matter if the default BARs aren't set correctly.
> 
> Great but maybe that's not needed because firmware and guests usually configure this 
> once at boot then use it with that setting without ever switching it again so this 
> simple patch allows that to work without breaking what's there and tested already so 
> I'd like this to be merged first with the amigaone machine then if you want to 
> rewrite it later to emulate the chip more closely then we have at least two test 
> cases with pegasos2 and amigaone to verify evertyhing still works correctly. But 
> since this patch allows all guests to boot it may be a waste of time to try to patch 
> this emulation further to add functionality that won't be used by anything. But if it 
> keeps working like this patch does and still boots the guests this one allows I don't 
> care that much about that.

The ultimate aim is to combine mine and Bernhard's work so that the compatibility 
mode/PCI native mode switch is handle automatically by the PCI IDE core, so it's 
something that would not just be restricted to the VIA.


ATB,

Mark.


