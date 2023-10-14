Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDD07C961E
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 21:46:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrkZN-0000sC-GA; Sat, 14 Oct 2023 15:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qrkZK-0000rN-E0; Sat, 14 Oct 2023 15:45:02 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qrkZH-0002Jp-LB; Sat, 14 Oct 2023 15:45:02 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 520E9757202;
 Sat, 14 Oct 2023 21:43:54 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 064047456A7; Sat, 14 Oct 2023 21:43:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 029E2745681;
 Sat, 14 Oct 2023 21:43:54 +0200 (CEST)
Date: Sat, 14 Oct 2023 21:43:53 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org, 
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>, 
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Subject: Re: [PATCH v2 1/3] via-ide: Fix legacy mode emulation
In-Reply-To: <af270749-a36f-4803-9d40-ad24521c4ea4@ilande.co.uk>
Message-ID: <339df528-073f-cbd2-ceef-71868c89929c@eik.bme.hu>
References: <cover.1696880742.git.balaton@eik.bme.hu>
 <f27e2af1a17e62ead8eda1e9e417f0f87f9c65f5.1696880742.git.balaton@eik.bme.hu>
 <af270749-a36f-4803-9d40-ad24521c4ea4@ilande.co.uk>
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

On Sat, 14 Oct 2023, Mark Cave-Ayland wrote:
> On 09/10/2023 20:54, BALATON Zoltan wrote:
>> The initial value for BARs were set in reset method for emulating
>> legacy mode at start but this does not work because PCI code resets
>> BARs after calling device reset method. Remove this ineffective
>> default to avoid confusion.
>> 
>> Instead move setting the BARs to a callback on writing the PCI config
>> regsiter that sets legacy mode (which firmwares needing this mode seem
>> to do) and fix their values to program it to use legacy port numbers
>> in this case. This does not fully emulate what the data sheet says
>> (which is not very clear on this) but it implements enogh to allow
>> both modes as used by firmwares of machines we emulate.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/ide/via.c | 41 ++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 36 insertions(+), 5 deletions(-)
>> 
>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>> index fff23803a6..43e8af8d69 100644
>> --- a/hw/ide/via.c
>> +++ b/hw/ide/via.c
>> @@ -132,11 +132,6 @@ static void via_ide_reset(DeviceState *dev)
>>       pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_FAST_BACK |
>>                    PCI_STATUS_DEVSEL_MEDIUM);
>>   -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_0, 0x000001f0);
>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_1, 0x000003f4);
>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 
>> 20-23h */
>>       pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
>>         /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configuration*/
>> @@ -159,6 +154,41 @@ static void via_ide_reset(DeviceState *dev)
>>       pci_set_long(pci_conf + 0xc0, 0x00020001);
>>   }
>>   +static void via_ide_cfg_write(PCIDevice *pd, uint32_t addr,
>> +                              uint32_t val, int len)
>> +{
>> +    pci_default_write_config(pd, addr, val, len);
>> +    /*
>> +     * Bits 0 and 2 of the PCI programming interface register select 
>> between
>> +     * legacy and native mode for the two IDE channels. We don't emulate 
>> this
>> +     * because we cannot easily switch between ISA and PCI in QEMU so 
>> instead
>
> As per my previous email, this statement is demonstrably false: this is now 
> achievable using the portio_list*() APIs.
>
>> +     * when guest selects legacy mode we set the PCI BARs to legacy ports 
>> which
>> +     * works the same. We also don't care about setting each channel 
>> separately
>> +     * as no guest is known to do or need that. We only do this when BARs 
>> are
>> +     * unset when writing this register as logs from real hardware show 
>> that
>> +     * setting legacy mode after BARs were set it will still use ports set 
>> by
>> +     * BARs not ISA ports (e.g. pegasos2 Linux does this after firmware 
>> set
>> +     * native mode and programmed BARs and calls it non-100% native mode).
>> +     * But if 0x8a is written righr after reset without setting BARs then 
>> we
>> +     * want legacy ports (this is done by the AmigaOne firmware).
>> +     */
>> +    if (addr == PCI_CLASS_PROG && val == 0x8a &&
>> +        pci_get_long(pd->config + PCI_BASE_ADDRESS_0) ==
>> +        PCI_BASE_ADDRESS_SPACE_IO) {
>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_0, 0x1f0
>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_1, 0x3f6
>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_2, 0x170
>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_3, 0x376
>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>> +        /* BMIBA: 20-23h */
>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_4, 0xcc00
>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>> +    }
>> +}
>
> Another hint that this is not the right way to be doing this: the values you 
> are placing in BARS 1 and 3 are illegal. PCI IO BARs have bit 1 forced to 0 
> and bit 0 set to 1 which forces a minimum alignment of 4, so either the 
> addresses 0x3f6/0x376 are being rounded internally to 0x3f4/0x374 and/or 
> you're lucky that this just happens to work on QEMU.
>
> Using the portio_list*() APIs really is the right way to implement this to 
> avoid being affected by such issues.

On second thought I don't think that would work as pegaos2 Linux writes 
0x8a to prog_if but then keeps using the ports as set by BARs so if you 
use ISA ports in this case this will break. I think that proves that real 
chip also uses BARs to emulate legacy mode similar to this approach so 
what we have in this patch is close enough and works well. Your proposed 
alternative is more complex, would not work any better and probably even 
does not work for all cases this works for so I think this is the better 
way now. I've sent a v3 with values changed to match BAR default values 
with 0x3x4 and updating comment and commit message.

Regards,
BALATON Zoltan

>>   static void via_ide_realize(PCIDevice *dev, Error **errp)
>>   {
>>       PCIIDEState *d = PCI_IDE(dev);
>> @@ -221,6 +251,7 @@ static void via_ide_class_init(ObjectClass *klass, void 
>> *data)
>>       /* Reason: only works as function of VIA southbridge */
>>       dc->user_creatable = false;
>>   +    k->config_write = via_ide_cfg_write;
>>       k->realize = via_ide_realize;
>>       k->exit = via_ide_exitfn;
>>       k->vendor_id = PCI_VENDOR_ID_VIA;
>
>
> ATB,
>
> Mark.
>
>
>

