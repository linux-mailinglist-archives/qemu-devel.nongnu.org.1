Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0567EE0CC
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 13:40:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3beD-0004Wx-ES; Thu, 16 Nov 2023 07:39:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r3be3-0004WY-FO; Thu, 16 Nov 2023 07:38:55 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r3be0-00041c-Tt; Thu, 16 Nov 2023 07:38:55 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 32208756094;
 Thu, 16 Nov 2023 13:39:18 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 26C8275607B; Thu, 16 Nov 2023 13:39:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 23C94756078;
 Thu, 16 Nov 2023 13:39:18 +0100 (CET)
Date: Thu, 16 Nov 2023 13:39:18 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, philmd@linaro.org, shentey@gmail.com
Subject: Re: [PATCH v3 4/4] hw/ide/via: implement legacy/native mode switching
In-Reply-To: <20231116103355.588580-5-mark.cave-ayland@ilande.co.uk>
Message-ID: <47c5b753-cd57-adda-e40a-f28a1c721aef@eik.bme.hu>
References: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
 <20231116103355.588580-5-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Thu, 16 Nov 2023, Mark Cave-Ayland wrote:
> Allow the VIA IDE controller to switch between both legacy and native modes by
> calling pci_ide_update_mode() to reconfigure the device whenever PCI_CLASS_PROG
> is updated.
>
> This patch moves the initial setting of PCI_CLASS_PROG from via_ide_realize() to
> via_ide_reset(), and removes the direct setting of PCI_INTERRUPT_PIN during PCI
> bus reset since this is now managed by pci_ide_update_mode(). This ensures that
> the device configuration is always consistent with respect to the currently
> selected mode.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
> hw/ide/via.c | 39 +++++++++++++++++++++++++++++++++++++--
> 1 file changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ide/via.c b/hw/ide/via.c
> index 87b134083a..47223b1268 100644
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
> @@ -128,11 +129,14 @@ static void via_ide_reset(DeviceState *dev)
>         ide_bus_reset(&d->bus[i]);
>     }
>
> +    pci_config_set_prog_interface(pci_conf, 0x8a); /* legacy mode */
> +    pci_ide_update_mode(d);
> +
>     pci_set_word(pci_conf + PCI_COMMAND, PCI_COMMAND_IO | PCI_COMMAND_WAIT);
>     pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_FAST_BACK |
>                  PCI_STATUS_DEVSEL_MEDIUM);
>
> -    pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
> +    pci_set_byte(pci_conf + PCI_INTERRUPT_LINE, 0xe);
>
>     /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configuration*/
>     pci_set_long(pci_conf + 0x40, 0x0a090600);
> @@ -154,6 +158,36 @@ static void via_ide_reset(DeviceState *dev)
>     pci_set_long(pci_conf + 0xc0, 0x00020001);
> }
>
> +static uint32_t via_ide_cfg_read(PCIDevice *pd, uint32_t addr, int len)
> +{
> +    uint32_t val = pci_default_read_config(pd, addr, len);
> +    uint8_t mode = pd->config[PCI_CLASS_PROG];
> +
> +    if ((mode & 0xf) == 0xa && ranges_overlap(addr, len,
> +                                              PCI_BASE_ADDRESS_0, 24)) {

You could break the line after && which is more readable. I don't get what 
the below calculation does. Does it really have to be so complicated? It's 
not likely BARs will be accesssed unaligned or did you find something that 
does that? I think it would be insane for a guest to do a 4 bytes read at 
PCI_BASE_ADDRESS_0 - 2 and expect to get something useful so don't think 
we need to handle that case. So maybe just care about
addr >= PCI_BASE_ADDRESS_0 %% addr + len < PCI_BASE_ADDRESS_0 + 24 and 
return 0 without fancy calculation that's likely never needed.

> +        /* BARs always read back zero in legacy mode */
> +        for (int i = addr; i < addr + len; i++) {
> +            if (i >= PCI_BASE_ADDRESS_0 && i < PCI_BASE_ADDRESS_0 + 24) {
> +                val &= ~(0xffULL << ((i - addr) << 3));
> +            }
> +        }
> +    }
> +
> +    return val;
> +}
> +
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

Have you missed this reply to your previous version or just ignored it?

https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg03180.html

You'd need to set BAR4 to the default value when switching to legacy mode 
(you could check if it's already set and only reset when unset if you're 
concerned with that but I think it would not matter in practice) otherwise 
UDMA does not work in AmigaOS.

Other than that I'd still like to keep potio_list arrays static somehow 
but that may need changes to isa_register_portio_list() so this could be 
addressed later but you could still consider moving the portio stuff from 
patch 2 into a function operating on IDEBus which can be in core.c next to 
the arrays as this could be reused by ide-isa later. Or is that just the 
same as ide_init_ioport without the ISADevice *dev argument and 
isa_register_portio_list inlined. The only thing isa_register_portio_list 
has is an additional call to isa_init_ioport but maybe that could be done 
separately then ide_init_ioport is not dependent on ISA any more so can be 
moved back to core.c?

Regards,
BALATON Zoltan

> +}
> +
> static void via_ide_realize(PCIDevice *dev, Error **errp)
> {
>     PCIIDEState *d = PCI_IDE(dev);
> @@ -161,7 +195,6 @@ static void via_ide_realize(PCIDevice *dev, Error **errp)
>     uint8_t *pci_conf = dev->config;
>     int i;
>
> -    pci_config_set_prog_interface(pci_conf, 0x8a); /* legacy mode */
>     pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
>     dev->wmask[PCI_INTERRUPT_LINE] = 0;
>     dev->wmask[PCI_CLASS_PROG] = 5;
> @@ -216,6 +249,8 @@ static void via_ide_class_init(ObjectClass *klass, void *data)
>     /* Reason: only works as function of VIA southbridge */
>     dc->user_creatable = false;
>
> +    k->config_read = via_ide_cfg_read;
> +    k->config_write = via_ide_cfg_write;
>     k->realize = via_ide_realize;
>     k->exit = via_ide_exitfn;
>     k->vendor_id = PCI_VENDOR_ID_VIA;
>

