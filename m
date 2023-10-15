Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE7E7C9935
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 15:45:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1PZ-0004wE-Dw; Sun, 15 Oct 2023 09:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qs1PY-0004vw-32; Sun, 15 Oct 2023 09:44:04 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qs1PW-00049j-37; Sun, 15 Oct 2023 09:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8a8U4r6tImxJUzQDjLJgoDh1THXCS05GIftPmGb2pWY=; b=QKoaj7hTbOiEjrJ23eXvV+uNH/
 H8M//o35eMvoSmmeMBtShtC87dmdLGINS0eBxXOMI8C8+CEy2SXlQxyLapp9ka7GnLrXREfOjXBm9
 HCXpy0ZyrW2PfOic324Ci+BtZS79+dQ9DXYL0+gWnmDeofU5PDnrffTqOv+p/yFHYkAG7jSYjg7IB
 ay9b1A1YPKjrPgSkPVP9gFFZ+cMBhAwEAavud7ebAohRAgsUj1k6yfptc8AN1pe1pJguxb7HANH18
 UXyZyarsYMKrj8wuXTXcehYUT2gLBuVNa18MbnVgv9VZNAXqDOb1J9WN0c29GjwBuNlyghtWvG5wr
 OcWtSV2ZmcsT904zEUj0vSopnQiGk8yz1W66KeJtZSqyoZEI0BAYSA9K2w+TNa7E+Q+YL3wYjNkcJ
 QKfA4qJ7CvRAqYGR+4/BDXGIk1t5q6SfCK7Hz1nh3IaG3hu6OzWO9KyFv3QoYIzcsJkVS/QH70Htg
 REHgS6IdhAwreHY7EA+BfjPBuIni5GFmkMI13T0bIniu68bNQDmAGtiWJKarFjdi8TxuVOvofeGlI
 NUsAEkWNTmjS+4v7JqznCA21Jg8PCSoitj3q9Jvn8LF+rxmEBUja4OAD1rnS6OXAA6u919/8R7NPp
 ChkylNnZlf4B6zDMQg+ZLOW9nRN0veByAGIOyt5yE=;
Received: from [2a00:23c4:8baf:fd00:5a49:1ad5:2df1:f854]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qs1PK-0005rH-T0; Sun, 15 Oct 2023 14:43:55 +0100
Message-ID: <cbae376c-a12e-4fc9-8a2a-9109e7476315@ilande.co.uk>
Date: Sun, 15 Oct 2023 14:43:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
References: <cover.1696880742.git.balaton@eik.bme.hu>
 <f27e2af1a17e62ead8eda1e9e417f0f87f9c65f5.1696880742.git.balaton@eik.bme.hu>
 <af270749-a36f-4803-9d40-ad24521c4ea4@ilande.co.uk>
 <339df528-073f-cbd2-ceef-71868c89929c@eik.bme.hu>
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
In-Reply-To: <339df528-073f-cbd2-ceef-71868c89929c@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:fd00:5a49:1ad5:2df1:f854
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

On 14/10/2023 20:43, BALATON Zoltan wrote:

> On Sat, 14 Oct 2023, Mark Cave-Ayland wrote:
>> On 09/10/2023 20:54, BALATON Zoltan wrote:
>>> The initial value for BARs were set in reset method for emulating
>>> legacy mode at start but this does not work because PCI code resets
>>> BARs after calling device reset method. Remove this ineffective
>>> default to avoid confusion.
>>>
>>> Instead move setting the BARs to a callback on writing the PCI config
>>> regsiter that sets legacy mode (which firmwares needing this mode seem
>>> to do) and fix their values to program it to use legacy port numbers
>>> in this case. This does not fully emulate what the data sheet says
>>> (which is not very clear on this) but it implements enogh to allow
>>> both modes as used by firmwares of machines we emulate.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>   hw/ide/via.c | 41 ++++++++++++++++++++++++++++++++++++-----
>>>   1 file changed, 36 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>>> index fff23803a6..43e8af8d69 100644
>>> --- a/hw/ide/via.c
>>> +++ b/hw/ide/via.c
>>> @@ -132,11 +132,6 @@ static void via_ide_reset(DeviceState *dev)
>>>       pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_FAST_BACK |
>>>                    PCI_STATUS_DEVSEL_MEDIUM);
>>>   -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_0, 0x000001f0);
>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_1, 0x000003f4);
>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 20-23h */
>>>       pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
>>>         /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configuration*/
>>> @@ -159,6 +154,41 @@ static void via_ide_reset(DeviceState *dev)
>>>       pci_set_long(pci_conf + 0xc0, 0x00020001);
>>>   }
>>>   +static void via_ide_cfg_write(PCIDevice *pd, uint32_t addr,
>>> +                              uint32_t val, int len)
>>> +{
>>> +    pci_default_write_config(pd, addr, val, len);
>>> +    /*
>>> +     * Bits 0 and 2 of the PCI programming interface register select between
>>> +     * legacy and native mode for the two IDE channels. We don't emulate this
>>> +     * because we cannot easily switch between ISA and PCI in QEMU so instead
>>
>> As per my previous email, this statement is demonstrably false: this is now 
>> achievable using the portio_list*() APIs.
>>
>>> +     * when guest selects legacy mode we set the PCI BARs to legacy ports which
>>> +     * works the same. We also don't care about setting each channel separately
>>> +     * as no guest is known to do or need that. We only do this when BARs are
>>> +     * unset when writing this register as logs from real hardware show that
>>> +     * setting legacy mode after BARs were set it will still use ports set by
>>> +     * BARs not ISA ports (e.g. pegasos2 Linux does this after firmware set
>>> +     * native mode and programmed BARs and calls it non-100% native mode).
>>> +     * But if 0x8a is written righr after reset without setting BARs then we
>>> +     * want legacy ports (this is done by the AmigaOne firmware).
>>> +     */
>>> +    if (addr == PCI_CLASS_PROG && val == 0x8a &&
>>> +        pci_get_long(pd->config + PCI_BASE_ADDRESS_0) ==
>>> +        PCI_BASE_ADDRESS_SPACE_IO) {
>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_0, 0x1f0
>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_1, 0x3f6
>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_2, 0x170
>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_3, 0x376
>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>> +        /* BMIBA: 20-23h */
>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_4, 0xcc00
>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>> +    }
>>> +}
>>
>> Another hint that this is not the right way to be doing this: the values you are 
>> placing in BARS 1 and 3 are illegal. PCI IO BARs have bit 1 forced to 0 and bit 0 
>> set to 1 which forces a minimum alignment of 4, so either the addresses 0x3f6/0x376 
>> are being rounded internally to 0x3f4/0x374 and/or you're lucky that this just 
>> happens to work on QEMU.
>>
>> Using the portio_list*() APIs really is the right way to implement this to avoid 
>> being affected by such issues.
> 
> On second thought I don't think that would work as pegaos2 Linux writes 0x8a to 
> prog_if but then keeps using the ports as set by BARs so if you use ISA ports in this 
> case this will break. I think that proves that real chip also uses BARs to emulate 
> legacy mode similar to this approach so what we have in this patch is close enough 
> and works well. Your proposed alternative is more complex, would not work any better 
> and probably even does not work for all cases this works for so I think this is the 
> better way now. I've sent a v3 with values changed to match BAR default values with 
> 0x3x4 and updating comment and commit message.

I've posted a hacked up (hopefully working) example from my IDE switching branch to 
demonstrate the concept, plus also confirms that BARs aren't being used on real 
hardware because they cannot be set to zero whilst legacy mode is enabled.

Another point to bear in mind is that with Bernhard's series and few extra patches 
from my series, using this approach it becomes possible to move all of this logic 
from the VIA device (and indeed all PCI IDE controllers, including the common BMDMA 
code) into PCIIDEState so the final result will end up much simpler. Obviously there 
is a need to allow behaviourable quirks for things such as VIA, but that can be 
solved easily enough with properties.


ATB,

Mark.


