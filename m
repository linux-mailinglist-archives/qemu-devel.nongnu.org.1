Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7718A7D0549
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 01:10:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtc8x-0005NR-7T; Thu, 19 Oct 2023 19:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qtc8u-0005M5-PW; Thu, 19 Oct 2023 19:09:28 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qtc8s-0000fr-5W; Thu, 19 Oct 2023 19:09:28 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9F994756078;
 Fri, 20 Oct 2023 01:09:20 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 600F274705E; Fri, 20 Oct 2023 01:09:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5BA15745681;
 Fri, 20 Oct 2023 01:09:20 +0200 (CEST)
Date: Fri, 20 Oct 2023 01:09:20 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 philmd@linaro.org, shentey@gmail.com
Subject: Re: [PATCH 2/2] hw/ide/via: implement legacy/native mode switching
In-Reply-To: <20231019130452.508426-3-mark.cave-ayland@ilande.co.uk>
Message-ID: <74b653a6-e883-4149-4f53-521761a52db5@eik.bme.hu>
References: <20231019130452.508426-1-mark.cave-ayland@ilande.co.uk>
 <20231019130452.508426-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Thu, 19 Oct 2023, Mark Cave-Ayland wrote:
> Allow the VIA IDE controller to switch between both legacy and native modes by
> calling pci_ide_update_mode() to reconfigure the device whenever PCI_CLASS_PROG
> is updated.
>
> This patch also moves the setting of PCI_CLASS_PROG from via_ide_realize() to
> via_ide_reset() and clears PCI_INTERRUPT_PIN to ensure that if a PCI device
> reset occurs then the device configuration is always consistent.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
> hw/ide/via.c | 20 ++++++++++++++++++--
> 1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ide/via.c b/hw/ide/via.c
> index fff23803a6..e6278dd419 100644
> --- a/hw/ide/via.c
> +++ b/hw/ide/via.c
> @@ -28,6 +28,7 @@
> #include "hw/pci/pci.h"
> #include "migration/vmstate.h"
> #include "qemu/module.h"
> +#include "qemu/range.h"
> #include "sysemu/dma.h"
> #include "hw/isa/vt82c686.h"
> #include "hw/ide/pci.h"
> @@ -128,6 +129,9 @@ static void via_ide_reset(DeviceState *dev)
>         ide_bus_reset(&d->bus[i]);
>     }
>
> +    pci_config_set_prog_interface(pci_conf, 0x8a); /* legacy mode */
> +    pci_ide_update_mode(d);
> +
>     pci_set_word(pci_conf + PCI_COMMAND, PCI_COMMAND_IO | PCI_COMMAND_WAIT);
>     pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_FAST_BACK |
>                  PCI_STATUS_DEVSEL_MEDIUM);
> @@ -137,7 +141,7 @@ static void via_ide_reset(DeviceState *dev)
>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 20-23h */

I'd remove these BAR defaults as they are not effective and aren't valid 
BAR values (missing IO bit) so likely would not work even if they weren't 
cleared but if you want to keep them maybe add a comment about that they 
will be zeroed by PCI reset anyway so only here for reference.

> -    pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
> +    pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000000e);

I did not get the commit message why it needs to 0 the intrerrupt pin 
because pci_ide_update_mode will set it above so I think this line could 
just use pci_set_byte() to set the PCI_INTERRUPT_LINE only now. (Although 
it still contradicts the VT8231 data sheet about the interrupt pin default 
value but I don't care as long as it works.)

Regards,
BALATON Zoltan

>
>     /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configuration*/
>     pci_set_long(pci_conf + 0x40, 0x0a090600);
> @@ -159,6 +163,18 @@ static void via_ide_reset(DeviceState *dev)
>     pci_set_long(pci_conf + 0xc0, 0x00020001);
> }
>
> +static void via_ide_cfg_write(PCIDevice *pd, uint32_t addr,
> +                              uint32_t val, int len)
> +{
> +    PCIIDEState *d = PCI_IDE(pd);
> +
> +    pci_default_write_config(pd, addr, val, len);
> +
> +    if (range_covers_byte(addr, len, PCI_CLASS_PROG)) {
> +        pci_ide_update_mode(d);
> +    }
> +}
> +
> static void via_ide_realize(PCIDevice *dev, Error **errp)
> {
>     PCIIDEState *d = PCI_IDE(dev);
> @@ -166,7 +182,6 @@ static void via_ide_realize(PCIDevice *dev, Error **errp)
>     uint8_t *pci_conf = dev->config;
>     int i;
>
> -    pci_config_set_prog_interface(pci_conf, 0x8a); /* legacy mode */
>     pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
>     dev->wmask[PCI_INTERRUPT_LINE] = 0;
>     dev->wmask[PCI_CLASS_PROG] = 5;
> @@ -221,6 +236,7 @@ static void via_ide_class_init(ObjectClass *klass, void *data)
>     /* Reason: only works as function of VIA southbridge */
>     dc->user_creatable = false;
>
> +    k->config_write = via_ide_cfg_write;
>     k->realize = via_ide_realize;
>     k->exit = via_ide_exitfn;
>     k->vendor_id = PCI_VENDOR_ID_VIA;
>

