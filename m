Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1427D5CA3
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 22:54:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvOOD-0006hd-CP; Tue, 24 Oct 2023 16:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvOOA-0006gr-LV; Tue, 24 Oct 2023 16:52:34 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvOO8-0000z5-LX; Tue, 24 Oct 2023 16:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R+ViDjjCHIJIlUeAsCHUrk69nRs9uHHFRlO3igFVhl0=; b=g5RNudJPtgQikPjWYLzl0UgDFw
 GrHf7P15DekOhr16D1ySZ+O5/VSTbhXXXKx3yg5c/YRUAzEucjWdAjqaUAzJlbzjHMLWQ6ZLhBhJ2
 2N+bW2uTi8qrABEnmiRtiao/a5n77Qw4BRwTLtu8M8+HSetoje/Sf101FEAjLtmA2JibLMmngodRr
 ieZ2uKgNOLdVHWcusU7YY7zKyV3an4MWG0ZVFYK1Np8HN0cuBD4YN2tCrUF7gdIPntKRUSuBsyHx2
 hzVJCpJdP//lqmjnpKYQ24P1kcyJnY6R5wiI3VwjddJzq9T5C/BOgfI3yTRrhnpyqxI/4Y8zL0awB
 O2aaq+lvl80QlFB2GH7hAz8wkPUp1rl9Z7dJIrZpW4ZM3kKuwViTSN+/4pnJC8Bu7SVzKVUTykW/N
 lV4J+K1asKXmgPvcfM/fV1jIwvvgzGtUWa9uNttRMRb9kaRCGRMSrpmLF79HAbtiBoLX7F1TwlzUd
 lRdytuBjkflISi7EcGenNsDkSP0tlsSga9keaKjkHWSVfFUmHzO9FZ9M68syoSLO6plLTDogXWoRx
 JmlmHigVNxZiN4Rhneq1VH22fVm/e+aoN88sbOPY7BUYPqzBTtVo7tEKENCiIsGn7AF/VVrX4jwKe
 AzDs8/Rbc+icqjaFvQ1YqNOHui4hlehpZi++M34N4=;
Received: from [2a00:23c4:8bb0:5400:d6f1:6571:2310:5e57]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvONs-0002OU-1f; Tue, 24 Oct 2023 21:52:20 +0100
Message-ID: <b22ea5e4-d3d1-4b20-b0d7-566158944181@ilande.co.uk>
Date: Tue, 24 Oct 2023 21:52:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bernhard Beschow <shentey@gmail.com>, jsnow@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, balaton@eik.bme.hu,
 philmd@linaro.org
References: <20231019130452.508426-1-mark.cave-ayland@ilande.co.uk>
 <20231019130452.508426-2-mark.cave-ayland@ilande.co.uk>
 <B2C0A4CE-0382-48F0-A513-8AD69960F2BF@gmail.com>
 <4C3F58DB-2AAA-43CA-8576-07CFBB66066D@gmail.com>
 <2601c66e-bd00-4df6-8a74-c8b2f81b052d@ilande.co.uk>
 <15CDD7B3-CDCC-4E41-B35C-4EC510CFBA0D@gmail.com>
Content-Language: en-US
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
In-Reply-To: <15CDD7B3-CDCC-4E41-B35C-4EC510CFBA0D@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:5400:d6f1:6571:2310:5e57
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 1/2] ide/pci.c: introduce pci_ide_update_mode() function
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

On 24/10/2023 08:08, Bernhard Beschow wrote:

> Am 23. Oktober 2023 21:06:11 UTC schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
>> On 23/10/2023 18:19, Bernhard Beschow wrote:
>>
>>> Am 22. Oktober 2023 22:06:30 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
>>>>
>>>>
>>>> Am 19. Oktober 2023 13:04:51 UTC schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
>>>>> This function reads the value of the PCI_CLASS_PROG register for PCI IDE
>>>>> controllers and configures the PCI BARs and/or IDE ioports accordingly.
>>>>>
>>>>> In the case where we switch to legacy mode, the PCI BARs are set to return zero
>>>>> (as suggested in the "PCI IDE Controller" specification), the legacy IDE ioports
>>>>> are enabled, and the PCI interrupt pin cleared to indicate legacy IRQ routing.
>>>>>
>>>>> Conversely when we switch to native mode, the legacy IDE ioports are disabled
>>>>> and the PCI interrupt pin set to indicate native IRQ routing. The contents of
>>>>> the PCI BARs are unspecified, but this is not an issue since if a PCI IDE
>>>>> controller has been switched to native mode then its BARs will need to be
>>>>> programmed.
>>>>>
>>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>> ---
>>>>> hw/ide/pci.c         | 90 ++++++++++++++++++++++++++++++++++++++++++++
>>>>> include/hw/ide/pci.h |  1 +
>>>>> 2 files changed, 91 insertions(+)
>>>>>
>>>>> diff --git a/hw/ide/pci.c b/hw/ide/pci.c
>>>>> index a25b352537..9eb30af632 100644
>>>>> --- a/hw/ide/pci.c
>>>>> +++ b/hw/ide/pci.c
>>>>> @@ -104,6 +104,96 @@ const MemoryRegionOps pci_ide_data_le_ops = {
>>>>>       .endianness = DEVICE_LITTLE_ENDIAN,
>>>>> };
>>>>>
>>>>> +static const MemoryRegionPortio ide_portio_list[] = {
>>>>> +    { 0, 8, 1, .read = ide_ioport_read, .write = ide_ioport_write },
>>>>> +    { 0, 1, 2, .read = ide_data_readw, .write = ide_data_writew },
>>>>> +    { 0, 1, 4, .read = ide_data_readl, .write = ide_data_writel },
>>>>> +    PORTIO_END_OF_LIST(),
>>>>> +};
>>>>> +
>>>>> +static const MemoryRegionPortio ide_portio2_list[] = {
>>>
>>> Although the naming seems familiar: What about renaming both lists to something like ide_portio_primary_list resp. ide_portio_secondary_list? Having one list carrying a number in its name while omitting it for the other I find rather confusing.
>>
>> The two different portio_lists don't represent the primary and secondary interfaces though: they represent the command and data ports for a single interface.
> 
> Ah, right.
> 
>> I've left the naming as-is (at least for now) so that all of the IDEBus fields, ISA IDE ioports and PCI IDE ioports all share the same naming convention.
> 
> Okay. At some point we should really harmonize the names to avoid above confusion. The PCI IDE BAR code does a much better job at naming and could serve as a template. Then all IDE code would clearly communicate that these are all the same concepts. I could send a patch for it once this series is in.

I agree that would be useful: and also same for the memory region names which could 
be updated so it's possible to tell the difference between the command and data ports 
(or indeed base/control as indicated in other online references).

>>
>>>>> +    { 0, 1, 1, .read = ide_status_read, .write = ide_ctrl_write },
>>>>> +    PORTIO_END_OF_LIST(),
>>>>> +};
>>>>> +
>>>>> +void pci_ide_update_mode(PCIIDEState *s)
>>>>> +{
>>>>> +    PCIDevice *d = PCI_DEVICE(s);
>>>>> +    uint8_t mode = d->config[PCI_CLASS_PROG];
>>>>> +
>>>>> +    switch (mode) {
>>>>
>>>> Maybe
>>>>
>>>>    switch (mode & 0xf) {
>>>>
>>>> here such that only the bits relevant to the PCI IDE controller specification are analyzed?
> 
> Due to the above conversation I realize that s->bus[] could be iterated over such that only the two bits of each bus could be switch()ed over. This would avoid some duplicate code, model the specification closer and allow for catching illegal states. Illegal states could be logged as guest errors. But it would also complicate dealing with the interrupt pin. So this might be a future extension.

Agreed. That particular logic will also change as a result of adding support for 
switching individual buses on the PCI IDE controller: not that I've seen anything do 
this to date, but it makes sense to implement what the documentation says where possible.

I didn't manage to send out the v2 yesterday evening, but I'll do so now.

> Best regards,
> Bernhard
> 
>>>> Then we can omit the high '8' nibble in the case labels which indicate bus master capability which is obviously out of scope of the switch statement (since you're not touching the BM DMA BAR).
>>>>
>>>>> +    case 0x8a:
>>>>
>>>> Perhaps we could add a
>>>>
>>>>    case 0x0:
>>>>
>>>> in front of the above label for compatibility with PIIX-IDE? That way, this function could be reused in the future for resetting PIIX-IDE.
>>>>
>>>>> +        /* Both channels legacy mode */
>>>>> +
>>>>> +        /* Zero BARs */
>>>>> +        pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x0);
>>>>> +        pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x0);
>>>>> +        pci_set_long(d->config + PCI_BASE_ADDRESS_2, 0x0);
>>>>> +        pci_set_long(d->config + PCI_BASE_ADDRESS_3, 0x0);
>>>>> +
>>>>> +        /* Clear interrupt pin */
>>>>> +        pci_config_set_interrupt_pin(d->config, 0);
>>>>
>>>> Do we really need to toggle the interrupt pin in this function? Or is this VIA-specific? This byte isn't even defined for PIIX-IDE.
>>>>
>>>> Best regards,
>>>> Bernhard
>>>>
>>>>> +
>>>>> +        /* Add legacy IDE ports */
>>>>> +        if (!s->bus[0].portio_list.owner) {
>>>>> +            portio_list_init(&s->bus[0].portio_list, OBJECT(d),
>>>>> +                             ide_portio_list, &s->bus[0], "ide");
>>>>> +            portio_list_add(&s->bus[0].portio_list,
>>>>> +                            pci_address_space_io(d), 0x1f0);
>>>>> +        }
>>>>> +
>>>>> +        if (!s->bus[0].portio2_list.owner) {
>>>>> +            portio_list_init(&s->bus[0].portio2_list, OBJECT(d),
>>>>> +                             ide_portio2_list, &s->bus[0], "ide");
>>>>> +            portio_list_add(&s->bus[0].portio2_list,
>>>>> +                            pci_address_space_io(d), 0x3f6);
>>>>> +        }
>>>>> +
>>>>> +        if (!s->bus[1].portio_list.owner) {
>>>>> +            portio_list_init(&s->bus[1].portio_list, OBJECT(d),
>>>>> +                                ide_portio_list, &s->bus[1], "ide");
>>>>> +            portio_list_add(&s->bus[1].portio_list,
>>>>> +                            pci_address_space_io(d), 0x170);
>>>>> +        }
>>>>> +
>>>>> +        if (!s->bus[1].portio2_list.owner) {
>>>>> +            portio_list_init(&s->bus[1].portio2_list, OBJECT(d),
>>>>> +                             ide_portio2_list, &s->bus[1], "ide");
>>>>> +            portio_list_add(&s->bus[1].portio2_list,
>>>>> +                            pci_address_space_io(d), 0x376);
>>>>> +        }
>>>>> +        break;
>>>>> +
>>>>> +    case 0x8f:
>>>>> +        /* Both channels native mode */
>>>>> +
>>>>> +        /* Set interrupt pin */
>>>>> +        pci_config_set_interrupt_pin(d->config, 1);
>>>>> +
>>>>> +        /* Remove legacy IDE ports */
>>>>> +        if (s->bus[0].portio_list.owner) {
>>>>> +            portio_list_del(&s->bus[0].portio_list);
>>>>> +            portio_list_destroy(&s->bus[0].portio_list);
>>>>> +        }
>>>>> +
>>>>> +        if (s->bus[0].portio2_list.owner) {
>>>>> +            portio_list_del(&s->bus[0].portio2_list);
>>>>> +            portio_list_destroy(&s->bus[0].portio2_list);
>>>>> +        }
>>>>> +
>>>>> +        if (s->bus[1].portio_list.owner) {
>>>>> +            portio_list_del(&s->bus[1].portio_list);
>>>>> +            portio_list_destroy(&s->bus[1].portio_list);
>>>>> +        }
>>>>> +
>>>>> +        if (s->bus[1].portio2_list.owner) {
>>>>> +            portio_list_del(&s->bus[1].portio2_list);
>>>>> +            portio_list_destroy(&s->bus[1].portio2_list);
>>>>> +        }
>>>>> +        break;
>>>>> +    }
>>>>> +}
>>>>> +
>>>>> static IDEState *bmdma_active_if(BMDMAState *bmdma)
>>>>> {
>>>>>       assert(bmdma->bus->retry_unit != (uint8_t)-1);
>>>>> diff --git a/include/hw/ide/pci.h b/include/hw/ide/pci.h
>>>>> index 1ff469de87..a814a0a7c3 100644
>>>>> --- a/include/hw/ide/pci.h
>>>>> +++ b/include/hw/ide/pci.h
>>>>> @@ -61,6 +61,7 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val);
>>>>> void bmdma_status_writeb(BMDMAState *bm, uint32_t val);
>>>>> extern MemoryRegionOps bmdma_addr_ioport_ops;
>>>>> void pci_ide_create_devs(PCIDevice *dev);
>>>>> +void pci_ide_update_mode(PCIIDEState *s);
>>>>>
>>>>> extern const VMStateDescription vmstate_ide_pci;
>>>>> extern const MemoryRegionOps pci_ide_cmd_le_ops;


ATB,

Mark.


