Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5977CCCBA
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 21:58:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqBs-0006Ig-MB; Tue, 17 Oct 2023 15:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qsqBq-0006I9-Ju; Tue, 17 Oct 2023 15:57:18 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qsqBn-0003P2-JW; Tue, 17 Oct 2023 15:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:References:Cc:To:From:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nyCHZqxKisAG2XYAAavGLbqteg4g4AfIVCMXlGPRmvM=; b=1WFW8i/4NamJZJ73os3iQ9dr8n
 2lyqXYqBG7LKR+Ny6MbYYzWeML7eqqZzWdTx5RSe5EAaEQGQL/VgB+Uezlyy7er1TzdTePMJODCjf
 pO3KYol7Um71Ik9jCkc1Rk9YAGedSzR7qa1a3l/htESabercP1o1a93nPVX3nh46BlOvrdHYo3tkY
 0Ay3Y6yhd1jPtHPKYEv7XmrCoKtGYPwV+a2DauW7fXSbIVbhzd02t/Oh0p9RVg3MasvLTGUvDI1uG
 ixPZtDljyMycw6IqHlZHXTvYjPmEu2QBiIgOj5T5HVuE0wBHRx8NkdDgfXR/rYk+uGAfo3Mdvci9r
 Wng1SRI4pRXweHHfnNjXA4iYcpfHF8Mu67ppdqFhRkZIPtO3jfu+BMC2sud806ZJ5zkTzArbet96I
 wMg8X2tLH5p+BLUxEjj98E/bLZI9fENUEdF/iio1eKPPKQFGm3I0nVyx9vst2U1gS3bY7+5GLotfH
 pZwV9470ibZ6OywfK25qF1sUCjRxVBePRVNFbBVOqxX3X/y5F7XjO8z0KT/w2O2b0s+KA084wvS+y
 Cm5S80A9AmWYUz0KWCLTY8Hv05ZcCvan39SfnEcLx2riw+RcG/8oPzdV5UJcvuHZVxPS96Z269Ex+
 jnnwdvMiHcqs3SUTBZs+vlgAxBIj3n7zGNz12bx1k=;
Received: from [2a00:23c4:8bb0:3200:407d:a65c:9fb4:b9b4]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qsqBX-0001RZ-20; Tue, 17 Oct 2023 20:57:03 +0100
Message-ID: <d4e3412c-e6aa-467b-b570-352b5ad0bafa@ilande.co.uk>
Date: Tue, 17 Oct 2023 20:56:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
References: <cover.1696880742.git.balaton@eik.bme.hu>
 <f27e2af1a17e62ead8eda1e9e417f0f87f9c65f5.1696880742.git.balaton@eik.bme.hu>
 <af270749-a36f-4803-9d40-ad24521c4ea4@ilande.co.uk>
 <alpine.LMD.2.03.2310141748380.3555@eik.bme.hu>
 <3db1683e-45ef-4125-ac98-2fb63df3951f@ilande.co.uk>
 <1cb88a08-f27a-2795-9bd2-ee1e49d7e0ab@eik.bme.hu>
Content-Language: en-US
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
In-Reply-To: <1cb88a08-f27a-2795-9bd2-ee1e49d7e0ab@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:3200:407d:a65c:9fb4:b9b4
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 1/3] via-ide: Fix legacy mode emulation
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

On 16/10/2023 23:16, BALATON Zoltan wrote:

> On Sun, 15 Oct 2023, Mark Cave-Ayland wrote:
>> On 14/10/2023 17:13, BALATON Zoltan wrote:
>>> On Sat, 14 Oct 2023, Mark Cave-Ayland wrote:
>>>> On 09/10/2023 20:54, BALATON Zoltan wrote:
>>>>> The initial value for BARs were set in reset method for emulating
>>>>> legacy mode at start but this does not work because PCI code resets
>>>>> BARs after calling device reset method. Remove this ineffective
>>>>> default to avoid confusion.
>>>>>
>>>>> Instead move setting the BARs to a callback on writing the PCI config
>>>>> regsiter that sets legacy mode (which firmwares needing this mode seem
>>>>> to do) and fix their values to program it to use legacy port numbers
>>>>> in this case. This does not fully emulate what the data sheet says
>>>>> (which is not very clear on this) but it implements enogh to allow
>>>>> both modes as used by firmwares of machines we emulate.
>>>>>
>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>> ---
>>>>>   hw/ide/via.c | 41 ++++++++++++++++++++++++++++++++++++-----
>>>>>   1 file changed, 36 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>>>>> index fff23803a6..43e8af8d69 100644
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
>>>>> @@ -159,6 +154,41 @@ static void via_ide_reset(DeviceState *dev)
>>>>>       pci_set_long(pci_conf + 0xc0, 0x00020001);
>>>>>   }
>>>>>   +static void via_ide_cfg_write(PCIDevice *pd, uint32_t addr,
>>>>> +                              uint32_t val, int len)
>>>>> +{
>>>>> +    pci_default_write_config(pd, addr, val, len);
>>>>> +    /*
>>>>> +     * Bits 0 and 2 of the PCI programming interface register select between
>>>>> +     * legacy and native mode for the two IDE channels. We don't emulate this
>>>>> +     * because we cannot easily switch between ISA and PCI in QEMU so instead
>>>>
>>>> As per my previous email, this statement is demonstrably false: this is now 
>>>> achievable using the portio_list*() APIs.
>>>>
>>>>> +     * when guest selects legacy mode we set the PCI BARs to legacy ports which
>>>>> +     * works the same. We also don't care about setting each channel separately
>>>>> +     * as no guest is known to do or need that. We only do this when BARs are
>>>>> +     * unset when writing this register as logs from real hardware show that
>>>>> +     * setting legacy mode after BARs were set it will still use ports set by
>>>>> +     * BARs not ISA ports (e.g. pegasos2 Linux does this after firmware set
>>>>> +     * native mode and programmed BARs and calls it non-100% native mode).
>>>>> +     * But if 0x8a is written righr after reset without setting BARs then we
>>>>> +     * want legacy ports (this is done by the AmigaOne firmware).
>>>>> +     */
>>>>> +    if (addr == PCI_CLASS_PROG && val == 0x8a &&
>>>>> +        pci_get_long(pd->config + PCI_BASE_ADDRESS_0) ==
>>>>> +        PCI_BASE_ADDRESS_SPACE_IO) {
>>>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_0, 0x1f0
>>>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_1, 0x3f6
>>>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_2, 0x170
>>>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_3, 0x376
>>>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>>>> +        /* BMIBA: 20-23h */
>>>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_4, 0xcc00
>>>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>>>> +    }
>>>>> +}
>>>>
>>>> Another hint that this is not the right way to be doing this: the values you are 
>>>> placing in BARS 1 and 3 are illegal. PCI IO BARs have bit 1 forced to 0 and bit 0 
>>>> set to 1 which forces a minimum alignment of 4, so either the addresses 
>>>> 0x3f6/0x376 are being rounded internally to 0x3f4/0x374 and/or you're lucky that 
>>>> this just happens to work on QEMU.
>>>
>>> The data sheet lists these values for legacy mode bur it seems that bit 1 is 
>>> ignored for BAR here and it ends up set to 0x3x4 with the actual reg mapped to 
>>> 0x3x7 for both values ending in 4 or 6 here and both works the same with AmigaOS 
>>> even if I change the values here to 0x3[7f]4 so I can do that and that should then 
>>> match the default values for these regs but not match the values listed for legacy 
>>> mode so the data sheet is wrong either way. It still does not make sense to set 
>>> these in reset method which will be overwritten so only works if I set them here.
>>>
>>>> Using the portio_list*() APIs really is the right way to implement this to avoid 
>>>> being affected by such issues.
>>>
>>> Can you provide an alternative patch using portio_list? I don't know how to do 
>>> that and have no example to follow either so it would be hard for me to figure 
>>> out. Or give some pointers on how to do this if I missed something.
>>
>> Here's a hacked up version based upon various bits and pieces from my WIP IDE mode 
>> switching branch. It's briefly compile tested, and checked with "info mtree" and a 
>> couple of test boots:
> 
> 
> I gave this a try and while it works with the guests I've tried I'm still not 
> convinced. See comments below.

Okay, that's good news and proves the basic concept works as expected.

>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>> index fff23803a6..82f2af1c78 100644
>> --- a/hw/ide/via.c
>> +++ b/hw/ide/via.c
>> @@ -28,12 +28,27 @@
>> #include "hw/pci/pci.h"
>> #include "migration/vmstate.h"
>> #include "qemu/module.h"
>> +#include "qemu/range.h"
>> #include "sysemu/dma.h"
>> #include "hw/isa/vt82c686.h"
>> #include "hw/ide/pci.h"
>> #include "hw/irq.h"
>> #include "trace.h"
>>
>> +
>> +/* FIXME: export these from hw/ide/ioport.c */
>> +static const MemoryRegionPortio ide_portio_list[] = {
>> +    { 0, 8, 1, .read = ide_ioport_read, .write = ide_ioport_write },
>> +    { 0, 1, 2, .read = ide_data_readw, .write = ide_data_writew },
>> +    { 0, 1, 4, .read = ide_data_readl, .write = ide_data_writel },
>> +    PORTIO_END_OF_LIST(),
>> +};
>> +
>> +static const MemoryRegionPortio ide_portio2_list[] = {
>> +    { 0, 1, 1, .read = ide_status_read, .write = ide_ctrl_write },
>> +    PORTIO_END_OF_LIST(),
>> +};
>> +
>> static uint64_t bmdma_read(void *opaque, hwaddr addr,
>>                            unsigned size)
>> {
>> @@ -137,7 +152,10 @@ static void via_ide_reset(DeviceState *dev)
>>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
>>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
>>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 20-23h */
>> -    pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
>> +    pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000000e);
> 
> The vt8231 data sheet says the interrupt pin should always be 1 while according to 
> the vt82c686b data sheet this means legacy or native interrupt routing and defaults 
> to 0. We probably don't do anything with it so no matter what we have here and we can 
> change it to 0 but maybe there's someting off here in any case.

According to the VT8231 datasheet I have here, the interrupt pin register is 
read-only but defaults to zero. But then that's fine because that is the expected 
value in legacy mode which is what you would expect with a default PCI_CLASS_PROG set 
to 0x8a.

>> +
>> +    /* Clear subsystem to match real hardware */
>> +    pci_set_long(pci_conf + 0x2c, 0x0);
>>
>>     /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configuration*/
>>     pci_set_long(pci_conf + 0x40, 0x0a090600);
>> @@ -159,6 +177,89 @@ static void via_ide_reset(DeviceState *dev)
>>     pci_set_long(pci_conf + 0xc0, 0x00020001);
>> }
>>
>> +static void via_ide_cfg_write(PCIDevice *pd, uint32_t addr,
>> +                              uint32_t val, int len)
>> +{
>> +    uint8_t *pci_conf = pd->config;
>> +    PCIIDEState *d = PCI_IDE(pd);
>> +
>> +    pci_default_write_config(pd, addr, val, len);
>> +
>> +    if (range_covers_byte(addr, len, PCI_CLASS_PROG)) {
>> +        if (pci_conf[PCI_CLASS_PROG] == 0x8a) {
>> +            /* FIXME: don't disable BARs
>> +            pci_default_write_config(pd, PCI_BASE_ADDRESS_0, 0x1, 4);
>> +            pci_default_write_config(pd, PCI_BASE_ADDRESS_1, 0x1, 4);
>> +            pci_default_write_config(pd, PCI_BASE_ADDRESS_2, 0x1, 4);
>> +            pci_default_write_config(pd, PCI_BASE_ADDRESS_3, 0x1, 4);
>> +            */
>> +
>> +            pci_set_long(pci_conf + PCI_BASE_ADDRESS_0, 0x0);
>> +            pci_set_long(pci_conf + PCI_BASE_ADDRESS_1, 0x0);
>> +            pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x0);
>> +            pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x0);
> 
> This is the part why I think this is not ready for merge yet. It seems to leave BARs 
> enabled but 0 their regs so now we have ide ports *both* at the previous BAR values 
> and at legacy ports while BAR values are 0. This does not look right and seems much 
> more hacky than my patch that changes BARs to legacy ports to emulate legacy mode. 
> You probably need this becuase of what Linux does on pegasos2 which I think is 
> proving real chip is also using BARs as my patch.

Well we both agree there are some quirks with this chip, but the reason for pursuing 
this approach is for 2 reasons: i) it matches the dumps you provided from real 
hardware (unlike your existing patch) and ii) it proves the basic concept and allows 
us to move forward with the consolidation work done by myself, Phil and Bernhard. 
Here's what I have in my tests here:


lspci output from real hardware (provided by you)
=================================================

0000:00:0c.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master 
SecP PriP])
          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
          Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
          Latency: 0
          Interrupt: pin ? routed to IRQ 14
          Region 0: [virtual] I/O ports at 1000 [size=8]
          Region 1: [virtual] I/O ports at 100c [size=4]
          Region 2: [virtual] I/O ports at 1010 [size=8]
          Region 3: [virtual] I/O ports at 101c [size=4]
          Region 4: I/O ports at 1020 [size=16]
          Capabilities: [c0] Power Management version 2
                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                  Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
          Kernel driver in use: pata_via

0000:00:0c.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 61 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0e 00 00 00
40: 0b f2 09 35 18 1c c0 00 99 20 20 20 02 00 20 20
50: 17 f4 f0 f0 14 00 00 00 a8 a8 a8 a8 00 00 00 00
60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
70: 02 01 00 00 00 00 00 00 02 01 00 00 00 00 00 00
80: 00 e0 b0 2f 00 00 00 00 00 f0 b0 2f 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 06 00 71 05 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Note that BARS 0-3 are all zeroed, the IDE controller reports legacy mode (0x8a) and 
the interrupt pin is set to 0x0.


lsipci output from your proposed patch
======================================

0000:00:0c.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master 
SecP PriP])
         Subsystem: Red Hat, Inc Device 1100
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 14
         Region 0: I/O ports at 1000 [size=8]
         Region 1: I/O ports at 100c [size=4]
         Region 2: I/O ports at 1010 [size=8]
         Region 3: I/O ports at 101c [size=4]
         Region 4: I/O ports at 1020 [size=16]
         Kernel driver in use: pata_via
00: 06 11 71 05 87 00 80 02 06 8a 01 01 00 00 00 00
10: 01 10 00 00 0d 10 00 00 11 10 00 00 1d 10 00 00
20: 21 10 00 00 00 00 00 00 00 00 00 00 f4 1a 00 11
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0e 01 00 00
40: 0b f2 09 35 18 1c c0 00 99 31 99 99 a2 00 31 a8
50: 17 f0 17 17 14 00 00 00 00 00 00 00 00 00 00 00
60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Note that BARS 0-3 have values (incorrect), the IDE controller reports legacy mode 
(0x8a) and the interrupt pin is set to 0x1 (incorrect).


lsipci output from my proposed patch
====================================

0000:00:0c.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master 
SecP PriP])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin ? routed to IRQ 14
         Region 0: [virtual] I/O ports at 1000 [size=8]
         Region 1: [virtual] I/O ports at 100c [size=4]
         Region 2: [virtual] I/O ports at 1010 [size=8]
         Region 3: [virtual] I/O ports at 101c [size=4]
         Region 4: I/O ports at 1020 [size=16]
         Kernel driver in use: pata_via
00: 06 11 71 05 87 00 80 02 06 8a 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0e 00 00 00
40: 0b f2 09 35 18 1c c0 00 99 31 99 99 a2 00 31 a8
50: 17 f0 17 17 14 00 00 00 00 00 00 00 00 00 00 00
60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Note that BARS 0-3 are all zeroed (correct), the IDE controller reports legacy mode 
(0x8a) and the interrupt pin is set to 0x0 (correct).


On the legacy ports being present on Linux, that is to be expected when setting the 
hardware to legacy mode which Linux does by writing 0x8a to PCI_CLASS_PROG. Why the 
BARs are still active in legacy mode is the better question to ask, but we won't know 
for sure unless someone can give me access to real hardware. The fact the legacy 
ports are there isn't an issue even if BARs are active as firmware avoids assigning 
PCI IO memory below 0x400 to avoid clashes with legacy and/or buggy hardware.

> Therefore I think we should go with my patch for now to not hold up adding amigaone 
> machine and allow progress with it and then when you have more time to elaborate this 
> idea of using portio_list to remove the FIXME comments from this PoC patch we can 
> revisit this any time later. There's no reason to hold other's work back to get this 
> sorted out now and solving a problem with my patch now does not mean we cannot 
> improve this device model further in the future. So if you can't make this a clean 
> patch now that can replace my patch please let my patch accepted until you can make 
> this a viable alternative. For now this just seems like an idea that needs more work 
> but not ready yet.

How is this holding your work back? I've pointed out the issues with your patch and 
provided you a near complete solution that i) you have confirmed working with your 
guests, ii) allows further work from myself and others in this area and iii) matches 
the information in the hardware dumps you provided from real hardware. I think it's 
fair to say that both ii) and iii) are notable improvements on your existing patch.

The FIXMEs are there because this patch comes from a branch with further work in this 
area: the only thing that remains are to split out the ide_portio_list[] and 
ide_portio2_list[] arrays so they can be reused from hw/ide/ioport.c and delete the 
second FIXME comment.

I'm sure you're more than capable of making these changes, and I'd appreciate that 
given my current time constraints. If not, then I can do this but it won't be for a 
few days - fortunately freeze is still a few weeks away, so there is no need for 
immediate urgency.


ATB,

Mark.

