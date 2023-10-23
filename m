Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 921A97D42B0
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 00:33:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv3SJ-0007LI-QN; Mon, 23 Oct 2023 18:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qv3SG-0007KS-Kx; Mon, 23 Oct 2023 18:31:24 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qv3SE-0006mt-2E; Mon, 23 Oct 2023 18:31:24 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 4337B756072;
 Tue, 24 Oct 2023 00:31:17 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 00EA575606C; Tue, 24 Oct 2023 00:31:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F37A57456A7;
 Tue, 24 Oct 2023 00:31:16 +0200 (CEST)
Date: Tue, 24 Oct 2023 00:31:16 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 philmd@linaro.org, shentey@gmail.com
Subject: Re: [PATCH 2/2] hw/ide/via: implement legacy/native mode switching
In-Reply-To: <03dc6815-92e9-4439-b25f-372d3984df49@ilande.co.uk>
Message-ID: <a6d1cfdc-4c93-9808-d449-a8b77424d691@eik.bme.hu>
References: <20231019130452.508426-1-mark.cave-ayland@ilande.co.uk>
 <20231019130452.508426-3-mark.cave-ayland@ilande.co.uk>
 <74b653a6-e883-4149-4f53-521761a52db5@eik.bme.hu>
 <03dc6815-92e9-4439-b25f-372d3984df49@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1199838565-1698100276=:41731"
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

--3866299591-1199838565-1698100276=:41731
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 23 Oct 2023, Mark Cave-Ayland wrote:
> On 20/10/2023 00:09, BALATON Zoltan wrote:
>> On Thu, 19 Oct 2023, Mark Cave-Ayland wrote:
>>> Allow the VIA IDE controller to switch between both legacy and native 
>>> modes by
>>> calling pci_ide_update_mode() to reconfigure the device whenever 
>>> PCI_CLASS_PROG
>>> is updated.
>>> 
>>> This patch also moves the setting of PCI_CLASS_PROG from via_ide_realize() 
>>> to
>>> via_ide_reset() and clears PCI_INTERRUPT_PIN to ensure that if a PCI 
>>> device
>>> reset occurs then the device configuration is always consistent.
>>> 
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>> hw/ide/via.c | 20 ++++++++++++++++++--
>>> 1 file changed, 18 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>>> index fff23803a6..e6278dd419 100644
>>> --- a/hw/ide/via.c
>>> +++ b/hw/ide/via.c
>>> @@ -28,6 +28,7 @@
>>> #include "hw/pci/pci.h"
>>> #include "migration/vmstate.h"
>>> #include "qemu/module.h"
>>> +#include "qemu/range.h"
>>> #include "sysemu/dma.h"
>>> #include "hw/isa/vt82c686.h"
>>> #include "hw/ide/pci.h"
>>> @@ -128,6 +129,9 @@ static void via_ide_reset(DeviceState *dev)
>>>         ide_bus_reset(&d->bus[i]);
>>>     }
>>> 
>>> +    pci_config_set_prog_interface(pci_conf, 0x8a); /* legacy mode */
>>> +    pci_ide_update_mode(d);
>>> +
>>>     pci_set_word(pci_conf + PCI_COMMAND, PCI_COMMAND_IO | 
>>> PCI_COMMAND_WAIT);
>>>     pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_FAST_BACK |
>>>                  PCI_STATUS_DEVSEL_MEDIUM);
>>> @@ -137,7 +141,7 @@ static void via_ide_reset(DeviceState *dev)
>>>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
>>>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
>>>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 
>>> 20-23h */
>> 
>> I'd remove these BAR defaults as they are not effective and aren't valid 
>> BAR values (missing IO bit) so likely would not work even if they weren't 
>> cleared but if you want to keep them maybe add a comment about that they 
>> will be zeroed by PCI reset anyway so only here for reference.
>
> I've had a look again at the other PCI IDE controllers and none of the others 
> attempt to set default BAR addresses except for PIIX-IDE, and that is simply 
> to indicate the BMDMA BAR is an I/O BAR. So in retrospect, I'll add a commit 
> to remove these BAR addresses as you've suggested above.
>
>>> -    pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
>>> +    pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000000e);
>> 
>> I did not get the commit message why it needs to 0 the intrerrupt pin 
>> because pci_ide_update_mode will set it above so I think this line could 
>> just use pci_set_byte() to set the PCI_INTERRUPT_LINE only now. (Although 
>> it still contradicts the VT8231 data sheet about the interrupt pin default 
>> value but I don't care as long as it works.)
>
> If you're happy then I'll make the change to use pci_set_byte().

I think only setting the interrupt line here is enough but as I said I 
don't care that much as long as it works. Although the vt8231 data sheet 
says interrupt pin should be 1 the vt82c686b data sheet is not clear about 
that and your new mode setting func will override it anyway so maybe it's 
not needed to touch other values than the interuupt line here.

Regards,
BALATON Zoltan
--3866299591-1199838565-1698100276=:41731--

