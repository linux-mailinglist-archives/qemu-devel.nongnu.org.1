Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C47AF7D421B
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 23:57:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv2uF-0002tq-TF; Mon, 23 Oct 2023 17:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qv2uD-0002tb-QO; Mon, 23 Oct 2023 17:56:13 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qv2uB-0007SA-B9; Mon, 23 Oct 2023 17:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wSrOO1dvbvhZ4eZ8z7gRIFv+9aVYCbPb47P1HnMun9w=; b=TmFT+4Z1H0nDv3lR3H3Z+ngmZO
 E/5l1LBsQhqpACL8G8+pv3BXtWxim4TviX7PVq+DC9Q6+361K+qEzDlUqBKQ2NvtkqAxZackWkyY/
 Q6mYlJtHoYyKixd9+qjwqUUt2DnuB7FgZFuTRMUMtuYaizMrvjXI/bNKCpS249F2PMUv9p1RNmany
 jfBlHZCfn0qKqqPhTBaXGIcQgqWvHeBBltt94a0/vfuVEVv+9TpWDz/a7HKY41Y7wEoHGIaK7s+47
 sSsmO82iW68daYMqqyGcfDp/RJM5X/LVFgvK+K9di6atj3PtLoTxt7WZ9Qqc4uh++UH4oBpA5wePA
 CkOyjt+0MuoL9RXIlhgPjjzfn+0VsqAL17jQE54ojrk3rSEgHbOcXjUF3PZoIIawkPIuqrR6BBEke
 XMqn8a9fuWtF1j+Yql7vlidz7w94H7aLTIs63u1EZdQT9VdQWoNqbewKuYAVCWy+Gwhox75blSkOT
 mROauuyDQXIOxUaV9GwqYbfTs6vfiV7ySEazEGCHKz2IWHB5T3ZJ2IIpa3f841b0PHF6UruhUeM/9
 wyJ1Tn90AoSg3+KCDyuYGbaVCwsptvzz7YrqFZzQ6NwotoxgQAWZB0niq13pXR3CeehM+uUqJ0phJ
 peN/7PgFr4kzZkce84HEQ+rgGE5HkSqeHY93GQ8gQ=;
Received: from [2a00:23c4:8bb0:3200:776d:f8ec:db63:d979]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qv2tx-00072t-4M; Mon, 23 Oct 2023 22:56:01 +0100
Message-ID: <03dc6815-92e9-4439-b25f-372d3984df49@ilande.co.uk>
Date: Mon, 23 Oct 2023 22:56:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 philmd@linaro.org, shentey@gmail.com
References: <20231019130452.508426-1-mark.cave-ayland@ilande.co.uk>
 <20231019130452.508426-3-mark.cave-ayland@ilande.co.uk>
 <74b653a6-e883-4149-4f53-521761a52db5@eik.bme.hu>
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
In-Reply-To: <74b653a6-e883-4149-4f53-521761a52db5@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:3200:776d:f8ec:db63:d979
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/2] hw/ide/via: implement legacy/native mode switching
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

On 20/10/2023 00:09, BALATON Zoltan wrote:

> On Thu, 19 Oct 2023, Mark Cave-Ayland wrote:
>> Allow the VIA IDE controller to switch between both legacy and native modes by
>> calling pci_ide_update_mode() to reconfigure the device whenever PCI_CLASS_PROG
>> is updated.
>>
>> This patch also moves the setting of PCI_CLASS_PROG from via_ide_realize() to
>> via_ide_reset() and clears PCI_INTERRUPT_PIN to ensure that if a PCI device
>> reset occurs then the device configuration is always consistent.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>> hw/ide/via.c | 20 ++++++++++++++++++--
>> 1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>> index fff23803a6..e6278dd419 100644
>> --- a/hw/ide/via.c
>> +++ b/hw/ide/via.c
>> @@ -28,6 +28,7 @@
>> #include "hw/pci/pci.h"
>> #include "migration/vmstate.h"
>> #include "qemu/module.h"
>> +#include "qemu/range.h"
>> #include "sysemu/dma.h"
>> #include "hw/isa/vt82c686.h"
>> #include "hw/ide/pci.h"
>> @@ -128,6 +129,9 @@ static void via_ide_reset(DeviceState *dev)
>>         ide_bus_reset(&d->bus[i]);
>>     }
>>
>> +    pci_config_set_prog_interface(pci_conf, 0x8a); /* legacy mode */
>> +    pci_ide_update_mode(d);
>> +
>>     pci_set_word(pci_conf + PCI_COMMAND, PCI_COMMAND_IO | PCI_COMMAND_WAIT);
>>     pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_FAST_BACK |
>>                  PCI_STATUS_DEVSEL_MEDIUM);
>> @@ -137,7 +141,7 @@ static void via_ide_reset(DeviceState *dev)
>>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
>>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
>>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 20-23h */
> 
> I'd remove these BAR defaults as they are not effective and aren't valid BAR values 
> (missing IO bit) so likely would not work even if they weren't cleared but if you 
> want to keep them maybe add a comment about that they will be zeroed by PCI reset 
> anyway so only here for reference.

I've had a look again at the other PCI IDE controllers and none of the others attempt 
to set default BAR addresses except for PIIX-IDE, and that is simply to indicate the 
BMDMA BAR is an I/O BAR. So in retrospect, I'll add a commit to remove these BAR 
addresses as you've suggested above.

>> -    pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
>> +    pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000000e);
> 
> I did not get the commit message why it needs to 0 the intrerrupt pin because 
> pci_ide_update_mode will set it above so I think this line could just use 
> pci_set_byte() to set the PCI_INTERRUPT_LINE only now. (Although it still contradicts 
> the VT8231 data sheet about the interrupt pin default value but I don't care as long 
> as it works.)

If you're happy then I'll make the change to use pci_set_byte().

> Regards,
> BALATON Zoltan
> 
>>
>>     /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configuration*/
>>     pci_set_long(pci_conf + 0x40, 0x0a090600);
>> @@ -159,6 +163,18 @@ static void via_ide_reset(DeviceState *dev)
>>     pci_set_long(pci_conf + 0xc0, 0x00020001);
>> }
>>
>> +static void via_ide_cfg_write(PCIDevice *pd, uint32_t addr,
>> +                              uint32_t val, int len)
>> +{
>> +    PCIIDEState *d = PCI_IDE(pd);
>> +
>> +    pci_default_write_config(pd, addr, val, len);
>> +
>> +    if (range_covers_byte(addr, len, PCI_CLASS_PROG)) {
>> +        pci_ide_update_mode(d);
>> +    }
>> +}
>> +
>> static void via_ide_realize(PCIDevice *dev, Error **errp)
>> {
>>     PCIIDEState *d = PCI_IDE(dev);
>> @@ -166,7 +182,6 @@ static void via_ide_realize(PCIDevice *dev, Error **errp)
>>     uint8_t *pci_conf = dev->config;
>>     int i;
>>
>> -    pci_config_set_prog_interface(pci_conf, 0x8a); /* legacy mode */
>>     pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
>>     dev->wmask[PCI_INTERRUPT_LINE] = 0;
>>     dev->wmask[PCI_CLASS_PROG] = 5;
>> @@ -221,6 +236,7 @@ static void via_ide_class_init(ObjectClass *klass, void *data)
>>     /* Reason: only works as function of VIA southbridge */
>>     dc->user_creatable = false;
>>
>> +    k->config_write = via_ide_cfg_write;
>>     k->realize = via_ide_realize;
>>     k->exit = via_ide_exitfn;
>>     k->vendor_id = PCI_VENDOR_ID_VIA;


ATB,

Mark.


