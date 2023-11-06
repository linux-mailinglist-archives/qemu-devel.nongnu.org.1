Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9F87E2FF7
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 23:42:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r08Hh-0001Ea-Uc; Mon, 06 Nov 2023 17:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r08Hg-0001E8-IV; Mon, 06 Nov 2023 17:41:28 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r08He-0004b6-IO; Mon, 06 Nov 2023 17:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jgB/uZ6rE9hzgK6rrFFiq8ZY9z2SBgN8VS+VeIDnsl0=; b=dsT7GB3dlb8a4w4VYlbZ69PCDE
 KeYKb96qd6HNxPE/lG+kZOEK5F5S9uhgbMVQfE8TG4EPhpPGIt47RH5d7BRYWlcbzHHNGLumFWJvI
 5F1Ud5X7CX1Ox2yEX9OQl+s4Q4qYWzuEqEGLoBHz1k+vBk67Bi+953iqL5vgHKOpJJPSHstWG2ccs
 kVvj6d+2kxXjyqaHmeYcFY0ubYelnB3cqzc8jcGK7sPErFOv8eqIjP3MQ1TALRjMs8oSNWzlad2/y
 IWFHyPMd4XUpICv8WPHVNYOv1Eh+ulBlDjNNhladghQfjeeB0qEmfoBMTIT2yIsBFpIuE+2uJbOEL
 SovstCnRIQh9sjrNfi8Cd7OsRAK9q0W3ai5rxDhF9Vu1wFNT+og5yuLZo/1r0J+sYgWckov6kJxjg
 CQBX4rCt4trnBDL1Y0hBVug/1iaADg5Ykkk3GHrbTQ8yJ4aM+nlEQ7bEKpek6XR88U5nPZSANjIJK
 qjopHkYgVQjKADHVkoXP5Zpnbnu00FgAP7BD4XNyV5yDykomhxLDyIiglliwYQllB3D1FJhRZ44xZ
 urvoQKhpdmv2PDRn+kx2WMV6nsEM6ZqRIxFLr0l8WObeFOwbU+F9pp3ejXkY3ytatRVzI1gFRtzdy
 coxjLTa9+w0QuGnbl7SWfTkUkkICE0ZNJRhZJIGZI=;
Received: from [2a00:23c4:8bb0:5400:786d:754a:beab:3c15]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r08HN-0007VT-Cv; Mon, 06 Nov 2023 22:41:13 +0000
Message-ID: <9d3142cf-fb35-499a-bd2f-b799bfbfd2c1@ilande.co.uk>
Date: Mon, 6 Nov 2023 22:41:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>
Cc: jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 balaton@eik.bme.hu, philmd@linaro.org, shentey@gmail.com
References: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
 <20231024224056.842607-2-mark.cave-ayland@ilande.co.uk>
 <ZUj0S6GqGhZ6kOp9@redhat.com>
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
In-Reply-To: <ZUj0S6GqGhZ6kOp9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:5400:786d:754a:beab:3c15
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

On 06/11/2023 14:12, Kevin Wolf wrote:

Hi Kevin,

Thanks for taking the time to review this. I'll reply inline below.

> Am 25.10.2023 um 00:40 hat Mark Cave-Ayland geschrieben:
>> This function reads the value of the PCI_CLASS_PROG register for PCI IDE
>> controllers and configures the PCI BARs and/or IDE ioports accordingly.
>>
>> In the case where we switch to legacy mode, the PCI BARs are set to return zero
>> (as suggested in the "PCI IDE Controller" specification), the legacy IDE ioports
>> are enabled, and the PCI interrupt pin cleared to indicate legacy IRQ routing.
>>
>> Conversely when we switch to native mode, the legacy IDE ioports are disabled
>> and the PCI interrupt pin set to indicate native IRQ routing. The contents of
>> the PCI BARs are unspecified, but this is not an issue since if a PCI IDE
>> controller has been switched to native mode then its BARs will need to be
>> programmed.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Tested-by: Bernhard Beschow <shentey@gmail.com>
>> ---
>>   hw/ide/pci.c         | 90 ++++++++++++++++++++++++++++++++++++++++++++
>>   include/hw/ide/pci.h |  1 +
>>   2 files changed, 91 insertions(+)
>>
>> diff --git a/hw/ide/pci.c b/hw/ide/pci.c
>> index a25b352537..5be643b460 100644
>> --- a/hw/ide/pci.c
>> +++ b/hw/ide/pci.c
>> @@ -104,6 +104,96 @@ const MemoryRegionOps pci_ide_data_le_ops = {
>>       .endianness = DEVICE_LITTLE_ENDIAN,
>>   };
>>   
>> +static const MemoryRegionPortio ide_portio_list[] = {
>> +    { 0, 8, 1, .read = ide_ioport_read, .write = ide_ioport_write },
>> +    { 0, 1, 2, .read = ide_data_readw, .write = ide_data_writew },
>> +    { 0, 1, 4, .read = ide_data_readl, .write = ide_data_writel },
>> +    PORTIO_END_OF_LIST(),
>> +};
>> +
>> +static const MemoryRegionPortio ide_portio2_list[] = {
>> +    { 0, 1, 1, .read = ide_status_read, .write = ide_ctrl_write },
>> +    PORTIO_END_OF_LIST(),
>> +};
> 
> This is duplicated from hw/ide/ioport.c. I think it would be better to
> use the arrays already defined there, ideally by calling ioport.c
> functions to setup and release the I/O ports.

The tricky part here is that hw/ide/ioport.c is defined for CONFIG_ISA, and so if we 
did that then all PCI IDE controllers would become dependent upon ISA too, regardless 
of whether they implement compatibility mode or not. What do you think is the best 
solution here? Perhaps moving ide_init_ioport() to a more ISA-specific place? I know 
that both myself and Phil have considered whether ide_init_ioport() should be 
replaced by something else further down the line.

>> +void pci_ide_update_mode(PCIIDEState *s)
>> +{
>> +    PCIDevice *d = PCI_DEVICE(s);
>> +    uint8_t mode = d->config[PCI_CLASS_PROG];
>> +
>> +    switch (mode & 0xf) {
>> +    case 0xa:
>> +        /* Both channels legacy mode */
> 
> Why is it ok to handle only the case where both channels are set to the
> same mode? The spec describes mixed-mode setups, too, and doesn't seem
> to allow ignoring a mode change if it's only for one of the channels.

Certainly that can be done: only both channels were implemented initially because 
that was the test case immediately available using the VIA. I can have a look at 
implementing both channels separately in v2.

>> +
>> +        /* Zero BARs */
>> +        pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x0);
>> +        pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x0);
>> +        pci_set_long(d->config + PCI_BASE_ADDRESS_2, 0x0);
>> +        pci_set_long(d->config + PCI_BASE_ADDRESS_3, 0x0);
> 
> Here I'm not sure what the spec really implies. Disabling the BAR (i.e.
> making it read-only and returning 0) while in compatibility mode doesn't
> necessarily mean that the value of the register is lost. In other words,
> are we sure that a driver can't expect that the old value is still there
> when it re-enables native mode?

The specification is definitely a bit vague on the details here. In the testing I've 
done with the VIA, there is only ever a switch from native to legacy mode, and not 
the other way around. I can see the logic that once you've gone from the native to 
legacy mode, the memory allocated for the BARs is already reserved by the OS so in 
theory it could be possible to switch back to native mode again... and that would 
work if the BARs are preserved.

Would it happen in practice? I'm not really sure, but I can try to implement this if 
you think it makes sense to take a safer approach.

>> +        /* Clear interrupt pin */
>> +        pci_config_set_interrupt_pin(d->config, 0);
> 
> Unlike for the BARs, I don't see anything in the spec that allows
> disabling this byte. I doubt it hurts in practice, but did you see any
> drivers requiring this? According to the spec, we just must not use the
> PCI interrupt in compatbility mode, but the registers stay accessible.

The PCI config dumps taken from a real VIA indicate that this byte is cleared in 
legacy mode, and that appears to make sense here. If you imagine an early PCI IDE 
controller, it will always start up in legacy mode and so you don't want to indicate 
to the guest OS that PCI IRQ routing is required unless it has been switched to 
native mode first.

> As far as I can see, the whole PCI interrupt configuration is currently
> unused anyway, and nothing in this series seems to change it. So won't
> we incorrectly continue to use the legacy interrupt even in native mode?
> (Actually, cmd646 seems to get it wrong the other way around and uses
> the PCI interrupt even in compatibility mode.)
> 
> I think this means that BMDMAState needs to have two irq lines (a legacy
> and a PCI one) and select the right one in bmdma_irq() depending on
> which mode we're in currently.

I need to flesh out the details a bit more (in particular testing with more than just 
the VIA PCI IDE controller), but yes the eventual aim is to consolidate the majority 
of the BMDMA and mode switching code into hw/ide/pci.c so the individual controllers 
don't need to worry about this, and everything "just works".

>> +        /* Add legacy IDE ports */
>> +        if (!s->bus[0].portio_list.owner) {
>> +            portio_list_init(&s->bus[0].portio_list, OBJECT(d),
>> +                             ide_portio_list, &s->bus[0], "ide");
>> +            portio_list_add(&s->bus[0].portio_list,
>> +                            pci_address_space_io(d), 0x1f0);
>> +        }
>> +
>> +        if (!s->bus[0].portio2_list.owner) {
>> +            portio_list_init(&s->bus[0].portio2_list, OBJECT(d),
>> +                             ide_portio2_list, &s->bus[0], "ide");
>> +            portio_list_add(&s->bus[0].portio2_list,
>> +                            pci_address_space_io(d), 0x3f6);
>> +        }
>> +
>> +        if (!s->bus[1].portio_list.owner) {
>> +            portio_list_init(&s->bus[1].portio_list, OBJECT(d),
>> +                                ide_portio_list, &s->bus[1], "ide");
>> +            portio_list_add(&s->bus[1].portio_list,
>> +                            pci_address_space_io(d), 0x170);
>> +        }
>> +
>> +        if (!s->bus[1].portio2_list.owner) {
>> +            portio_list_init(&s->bus[1].portio2_list, OBJECT(d),
>> +                             ide_portio2_list, &s->bus[1], "ide");
>> +            portio_list_add(&s->bus[1].portio2_list,
>> +                            pci_address_space_io(d), 0x376);
>> +        }
>> +        break;
> 
> This is essentially ide_init_ioport(), except that it handles the case
> where it is already initialised. Let's reuse it.

This still has the dependency issue with CONFIG_ISA, but I'm happy to implement what 
you think is the best solution (as discussed above).

>> +    case 0xf:
>> +        /* Both channels native mode */
>> +
>> +        /* Set interrupt pin */
>> +        pci_config_set_interrupt_pin(d->config, 1);
>> +
>> +        /* Remove legacy IDE ports */
>> +        if (s->bus[0].portio_list.owner) {
>> +            portio_list_del(&s->bus[0].portio_list);
>> +            portio_list_destroy(&s->bus[0].portio_list);
>> +        }
>> +
>> +        if (s->bus[0].portio2_list.owner) {
>> +            portio_list_del(&s->bus[0].portio2_list);
>> +            portio_list_destroy(&s->bus[0].portio2_list);
>> +        }
>> +
>> +        if (s->bus[1].portio_list.owner) {
>> +            portio_list_del(&s->bus[1].portio_list);
>> +            portio_list_destroy(&s->bus[1].portio_list);
>> +        }
>> +
>> +        if (s->bus[1].portio2_list.owner) {
>> +            portio_list_del(&s->bus[1].portio2_list);
>> +            portio_list_destroy(&s->bus[1].portio2_list);
>> +        }
>> +        break;
> 
> And this part could be an ioport.c function as well.
> 
>> +    }
>> +}
> 
> Kevin


ATB,

Mark.


