Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 650757EA574
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 22:25:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2eQH-0001rs-Ed; Mon, 13 Nov 2023 16:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r2eQE-0001r5-2X; Mon, 13 Nov 2023 16:24:42 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r2eQ1-0007UD-I9; Mon, 13 Nov 2023 16:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yS+fmkTGCzsICEXPamtlbCXZzFbxp2CVhtYw40hczC4=; b=X3ilshTFTtEwwIJx2j9UKdPIQ+
 sYM0B7ioTUyruorDsPfZMNdUQbe0y/c8DNzeWw7pjOMsqJmoW2qNmz+JlkRBDWtSK0GznynLZ5Tly
 p2dm6D377SGNUvWvXCtQdnWF8zJ2QJ3ifi4iN1hpqVvDMA4mWKu2o34NZACp7V2EFZZQmh+7JMZ0b
 ZXVhr+ScsBKng+uSiWAI2ZN3rGk9CHAL5NDj7S13mWNw6cN2PV41NnWQSOHFzMsV66FRDFzoTRZxg
 J9JAfeXo+Q/kYwj0gcnVrGfv5Z+e2x2OVRMBbmyGL2IrgRepeVqL7ivHdaWfaUS+OwReFFyQnEC9p
 Sig/qG9jaYo2QwESAwe0vHASmEIncBNI3dNoeYsWIDR6+sxiknUgDHrIphPGDLSMAogO0MY4erga5
 z0jL/tLk+hYEEAzi+Zox16KE1VIoSI9oGfnctlslvLJMBdjof53kMqijVrZjCDcYTSuPq7kx+fQvE
 VuzGJCzhuUnNANZey+/sCJEuqdYdF7XeSpYYBSouFdBl5P+/+XozvzW+O2lURzZuETqMygGhshxpq
 F/CI+T4zQhHjQpMPLZzs1B5TYdfOne1ZXN3OPUDAqsIoAhIj2doPbQrI6yU9JEooKjrZ0CBgDCyGY
 vJbGdl8PFJT+lvJK9m7dl3p8K4BAnA1G2I6pG8Afg=;
Received: from [2a00:23c4:8bb0:5400:961f:a486:b7:ef79]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r2ePh-0004f3-Nk; Mon, 13 Nov 2023 21:24:13 +0000
Message-ID: <41a91dda-8bac-4b7f-9655-2b09e074d808@ilande.co.uk>
Date: Mon, 13 Nov 2023 21:24:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>
Cc: jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 balaton@eik.bme.hu, philmd@linaro.org, shentey@gmail.com
References: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
 <20231024224056.842607-2-mark.cave-ayland@ilande.co.uk>
 <ZUj0S6GqGhZ6kOp9@redhat.com>
 <9d3142cf-fb35-499a-bd2f-b799bfbfd2c1@ilande.co.uk>
 <ZUobajEv5cZsXa6g@redhat.com>
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
In-Reply-To: <ZUobajEv5cZsXa6g@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:5400:961f:a486:b7:ef79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 1/3] ide/pci.c: introduce pci_ide_update_mode() function
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 07/11/2023 11:11, Kevin Wolf wrote:

> Am 06.11.2023 um 23:41 hat Mark Cave-Ayland geschrieben:
>> On 06/11/2023 14:12, Kevin Wolf wrote:
>>
>> Hi Kevin,
>>
>> Thanks for taking the time to review this. I'll reply inline below.
>>
>>> Am 25.10.2023 um 00:40 hat Mark Cave-Ayland geschrieben:
>>>> This function reads the value of the PCI_CLASS_PROG register for PCI IDE
>>>> controllers and configures the PCI BARs and/or IDE ioports accordingly.
>>>>
>>>> In the case where we switch to legacy mode, the PCI BARs are set to return zero
>>>> (as suggested in the "PCI IDE Controller" specification), the legacy IDE ioports
>>>> are enabled, and the PCI interrupt pin cleared to indicate legacy IRQ routing.
>>>>
>>>> Conversely when we switch to native mode, the legacy IDE ioports are disabled
>>>> and the PCI interrupt pin set to indicate native IRQ routing. The contents of
>>>> the PCI BARs are unspecified, but this is not an issue since if a PCI IDE
>>>> controller has been switched to native mode then its BARs will need to be
>>>> programmed.
>>>>
>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> Tested-by: Bernhard Beschow <shentey@gmail.com>
>>>> ---
>>>>    hw/ide/pci.c         | 90 ++++++++++++++++++++++++++++++++++++++++++++
>>>>    include/hw/ide/pci.h |  1 +
>>>>    2 files changed, 91 insertions(+)
>>>>
>>>> diff --git a/hw/ide/pci.c b/hw/ide/pci.c
>>>> index a25b352537..5be643b460 100644
>>>> --- a/hw/ide/pci.c
>>>> +++ b/hw/ide/pci.c
>>>> @@ -104,6 +104,96 @@ const MemoryRegionOps pci_ide_data_le_ops = {
>>>>        .endianness = DEVICE_LITTLE_ENDIAN,
>>>>    };
>>>> +static const MemoryRegionPortio ide_portio_list[] = {
>>>> +    { 0, 8, 1, .read = ide_ioport_read, .write = ide_ioport_write },
>>>> +    { 0, 1, 2, .read = ide_data_readw, .write = ide_data_writew },
>>>> +    { 0, 1, 4, .read = ide_data_readl, .write = ide_data_writel },
>>>> +    PORTIO_END_OF_LIST(),
>>>> +};
>>>> +
>>>> +static const MemoryRegionPortio ide_portio2_list[] = {
>>>> +    { 0, 1, 1, .read = ide_status_read, .write = ide_ctrl_write },
>>>> +    PORTIO_END_OF_LIST(),
>>>> +};
>>>
>>> This is duplicated from hw/ide/ioport.c. I think it would be better to
>>> use the arrays already defined there, ideally by calling ioport.c
>>> functions to setup and release the I/O ports.
>>
>> The tricky part here is that hw/ide/ioport.c is defined for CONFIG_ISA, and
>> so if we did that then all PCI IDE controllers would become dependent upon
>> ISA too, regardless of whether they implement compatibility mode or not.
>> What do you think is the best solution here? Perhaps moving
>> ide_init_ioport() to a more ISA-specific place? I know that both myself and
>> Phil have considered whether ide_init_ioport() should be replaced by
>> something else further down the line.
> 
> Hm, yes, I didn't think about this.
> 
> Splitting ioport.c is one option, but even the port lists are really
> made for ISA, so the whole file is really ISA related.
> 
> On the other hand, pci_ide_update_mode() isn't really a pure PCI
> function, it's at the intersection of PCI and ISA. Can we just #ifdef it
> out if ISA isn't built? Devices that don't support compatibility mode
> should never try to call pci_ide_update_mode().

In terms of the QEMU modelling, the PCI IDE controllers are modelled as a PCIDevice 
rather than an ISADevice and that's why ide_init_ioport() doesn't really make sense 
in PCI IDE controllers. Currently its only PCIDevice user is hw/ide/piix.c and that 
passes ISADevice as NULL, because there is no underlying ISADevice.

The only ISADevice user is in hw/ide/isa.c so I think a better solution here would be 
to inline ide_init_ioport() into isa_ide_realizefn() and then add a separate function 
for PCI IDE controllers which is what I've attempted to do here.

How about moving ide_portio_list[] and ide_portio_list2[] to hw/ide/core.c instead? 
The definitions in include/hw/ide/internal.h already have a dependency on PortioList 
so there should be no issue, and it allows them to be shared between both PCI and ISA 
devices.

>>>> +void pci_ide_update_mode(PCIIDEState *s)
>>>> +{
>>>> +    PCIDevice *d = PCI_DEVICE(s);
>>>> +    uint8_t mode = d->config[PCI_CLASS_PROG];
>>>> +
>>>> +    switch (mode & 0xf) {
>>>> +    case 0xa:
>>>> +        /* Both channels legacy mode */
>>>
>>> Why is it ok to handle only the case where both channels are set to the
>>> same mode? The spec describes mixed-mode setups, too, and doesn't seem
>>> to allow ignoring a mode change if it's only for one of the channels.
>>
>> Certainly that can be done: only both channels were implemented initially
>> because that was the test case immediately available using the VIA. I can
>> have a look at implementing both channels separately in v2.
> 
> I don't think it would make the code more complicated, so it feels like
> implementing it right away would be nice.
> 
> On the other hand, if you want to see this in 8.2, I'm happy to merge
> this part as it is and then we can improve it on top.

I think this helps Zoltan boot AmigaOS on the new AmigaOne machine, and I am 
certainly planning more work in this area during the 9.0 cycle.

>>>> +
>>>> +        /* Zero BARs */
>>>> +        pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x0);
>>>> +        pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x0);
>>>> +        pci_set_long(d->config + PCI_BASE_ADDRESS_2, 0x0);
>>>> +        pci_set_long(d->config + PCI_BASE_ADDRESS_3, 0x0);
>>>
>>> Here I'm not sure what the spec really implies. Disabling the BAR (i.e.
>>> making it read-only and returning 0) while in compatibility mode doesn't
>>> necessarily mean that the value of the register is lost. In other words,
>>> are we sure that a driver can't expect that the old value is still there
>>> when it re-enables native mode?
>>
>> The specification is definitely a bit vague on the details here. In the
>> testing I've done with the VIA, there is only ever a switch from native to
>> legacy mode, and not the other way around. I can see the logic that once
>> you've gone from the native to legacy mode, the memory allocated for the
>> BARs is already reserved by the OS so in theory it could be possible to
>> switch back to native mode again... and that would work if the BARs are
>> preserved.
>>
>> Would it happen in practice? I'm not really sure, but I can try to implement
>> this if you think it makes sense to take a safer approach.
> 
> I'm not sure if any driver tries to do something like this. Maybe a
> situation where BIOS switches to compatibility mode and then the OS to
> native again? But it does feel safer.
> 
> The other option would be to not zero out the BAR at all. Doing that is
> optional according to the spec. But then we need to make sure that we
> ignore any access to the memory region behind the BAR even though its
> address is still there.
> 
> Come to think of it, don't we need to somehow disable the memory regions
> described by the BARs even when we zero them out? I think updating the
> config space without calling pci_update_mappings() doesn't actually stop
> QEMU from reacting to reads and writes there, does it?
> 
> Otherwise, the guest doesn't see the memory region in the BAR any more,
> but it would still be active (which is almost the opposite of what we're
> supposed to do).

At least the VIA appears to still respond to the BAR addresses even when switched 
back to compatibility mode (bug?), but without more testing after making the 
functionality more generic it's difficult to say. Should the BARs be disabled when 
switched to legacy mode? According to the spec that should be the case, but then a 
switch from native -> legacy mode doesn't matter because the BAR addresses are 
already reserved, and a switch from legacy -> native mode would require the BARs to 
be (re)programmed anyway. I will definitely do some testing with the functionality 
enabled for all PCI IDE controllers in future, however I'm minded to keep it as 
simple as possible.

>>>> +        /* Clear interrupt pin */
>>>> +        pci_config_set_interrupt_pin(d->config, 0);
>>>
>>> Unlike for the BARs, I don't see anything in the spec that allows
>>> disabling this byte. I doubt it hurts in practice, but did you see any
>>> drivers requiring this? According to the spec, we just must not use the
>>> PCI interrupt in compatbility mode, but the registers stay accessible.
>>
>> The PCI config dumps taken from a real VIA indicate that this byte is
>> cleared in legacy mode, and that appears to make sense here. If you imagine
>> an early PCI IDE controller, it will always start up in legacy mode and so
>> you don't want to indicate to the guest OS that PCI IRQ routing is required
>> unless it has been switched to native mode first.
> 
> Ok. I assume that with a per-channel control, you would clear it only if
> both channels are in compatibility mode, and set it as soon as one
> channel is in native mode?

Yes, I believe that's correct.

>>> As far as I can see, the whole PCI interrupt configuration is currently
>>> unused anyway, and nothing in this series seems to change it. So won't
>>> we incorrectly continue to use the legacy interrupt even in native mode?
>>> (Actually, cmd646 seems to get it wrong the other way around and uses
>>> the PCI interrupt even in compatibility mode.)
>>>
>>> I think this means that BMDMAState needs to have two irq lines (a legacy
>>> and a PCI one) and select the right one in bmdma_irq() depending on
>>> which mode we're in currently.
>>
>> I need to flesh out the details a bit more (in particular testing with more
>> than just the VIA PCI IDE controller), but yes the eventual aim is to
>> consolidate the majority of the BMDMA and mode switching code into
>> hw/ide/pci.c so the individual controllers don't need to worry about this,
>> and everything "just works".
> 
> Zoltan's reply for patch 3 actuallys say that it's correct like this for
> the VIA controller, in conflict with what the spec says. So it seems
> that we can't make it "just work" for everyone, but we still need to
> allow devices to intercept it at least.

I've replied separately to this, and as mentioned that's something that will likely 
require some future updates to the PCI IRQ routing code.

> As I said there, adding a comment in the via emulation should be enough
> for now, and we can leave proper generic interrupt handling for another
> day (when we want to add switching to a model that's actually consistent
> with the spec).

Agreed.

> Maybe also leave a TODO comment at the top of this function to remind
> other users that interrupt handling needs to be covered by individual
> devices for now.

Yes I can definitely add a comment with a TODO. For now in terms of 8.2 would you be 
happy with:

- Moving ide_portio_list[] and ide_portio_list2[] to hw/ide/core.c

- Change the configuration space access to read all zeros for BARs in compatibility
   mode instead of zeroing the BARs

- Leave it so that both channels are switched at the same time

- Add a TODO comment to pci_ide_update_mode() indicating that individual PCI IDE
   controllers are responsible for their own IRQ routing


ATB,

Mark.


