Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF7E817E4B
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 00:59:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFNVb-0001LK-9t; Mon, 18 Dec 2023 18:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rFNVY-0001Km-Bv; Mon, 18 Dec 2023 18:58:48 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rFNVV-0006M5-Ra; Mon, 18 Dec 2023 18:58:47 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0481875A4C2;
 Tue, 19 Dec 2023 00:58:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id cvNvI9QiM3Rk; Tue, 19 Dec 2023 00:58:42 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1548175A406; Tue, 19 Dec 2023 00:58:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 13682756094;
 Tue, 19 Dec 2023 00:58:42 +0100 (CET)
Date: Tue, 19 Dec 2023 00:58:42 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 03/12] hw/char/serial: Free struct SerialState from
 MemoryRegion
In-Reply-To: <20231218185114.119736-4-shentey@gmail.com>
Message-ID: <97d32fb0-a36d-fe2b-c6bf-c774d82d142c@eik.bme.hu>
References: <20231218185114.119736-1-shentey@gmail.com>
 <20231218185114.119736-4-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Mon, 18 Dec 2023, Bernhard Beschow wrote:
> SerialState::io isn't used within TYPE_SERIAL directly. Push it to its users to
> make them the owner of the MemoryRegion.

I'm not sure this patch is needed. The users already own the SerialState 
so can use its memory region so they don't need their own. Since all of 
these need this io region putting it in SerialState saves some 
duplication. Unless I've missed some reason this might be needed.

Regards,
BALATON Zoltan

> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> include/hw/char/serial.h   | 2 +-
> hw/char/serial-isa.c       | 7 +++++--
> hw/char/serial-pci-multi.c | 7 ++++---
> hw/char/serial-pci.c       | 7 +++++--
> hw/char/serial.c           | 4 ++--
> 5 files changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index 8ba7eca3d6..eb4254edde 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -77,7 +77,6 @@ struct SerialState {
>     int poll_msl;
>
>     QEMUTimer *modem_status_poll;
> -    MemoryRegion io;
> };
> typedef struct SerialState SerialState;
>
> @@ -85,6 +84,7 @@ struct SerialMM {
>     SysBusDevice parent;
>
>     SerialState serial;
> +    MemoryRegion io;
>
>     uint8_t regshift;
>     uint8_t endianness;
> diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
> index 141a6cb168..2be8be980b 100644
> --- a/hw/char/serial-isa.c
> +++ b/hw/char/serial-isa.c
> @@ -26,6 +26,7 @@
> #include "qemu/osdep.h"
> #include "qapi/error.h"
> #include "qemu/module.h"
> +#include "exec/memory.h"
> #include "sysemu/sysemu.h"
> #include "hw/acpi/acpi_aml_interface.h"
> #include "hw/char/serial.h"
> @@ -43,6 +44,7 @@ struct ISASerialState {
>     uint32_t iobase;
>     uint32_t isairq;
>     SerialState state;
> +    MemoryRegion io;
> };
>
> static const int isa_serial_io[MAX_ISA_SERIAL_PORTS] = {
> @@ -79,8 +81,9 @@ static void serial_isa_realizefn(DeviceState *dev, Error **errp)
>     qdev_realize(DEVICE(s), NULL, errp);
>     qdev_set_legacy_instance_id(dev, isa->iobase, 3);
>
> -    memory_region_init_io(&s->io, OBJECT(isa), &serial_io_ops, s, "serial", 8);
> -    isa_register_ioport(isadev, &s->io, isa->iobase);
> +    memory_region_init_io(&isa->io, OBJECT(isa), &serial_io_ops, s, "serial",
> +                          8);
> +    isa_register_ioport(isadev, &isa->io, isa->iobase);
> }
>
> static void serial_isa_build_aml(AcpiDevAmlIf *adev, Aml *scope)
> diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
> index 5d65c534cb..16cb2faad7 100644
> --- a/hw/char/serial-pci-multi.c
> +++ b/hw/char/serial-pci-multi.c
> @@ -44,6 +44,7 @@ typedef struct PCIMultiSerialState {
>     uint32_t     ports;
>     char         *name[PCI_SERIAL_MAX_PORTS];
>     SerialState  state[PCI_SERIAL_MAX_PORTS];
> +    MemoryRegion io[PCI_SERIAL_MAX_PORTS];
>     uint32_t     level[PCI_SERIAL_MAX_PORTS];
>     qemu_irq     *irqs;
>     uint8_t      prog_if;
> @@ -58,7 +59,7 @@ static void multi_serial_pci_exit(PCIDevice *dev)
>     for (i = 0; i < pci->ports; i++) {
>         s = pci->state + i;
>         qdev_unrealize(DEVICE(s));
> -        memory_region_del_subregion(&pci->iobar, &s->io);
> +        memory_region_del_subregion(&pci->iobar, &pci->io[i]);
>         g_free(pci->name[i]);
>     }
>     qemu_free_irqs(pci->irqs, pci->ports);
> @@ -112,9 +113,9 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
>         }
>         s->irq = pci->irqs[i];
>         pci->name[i] = g_strdup_printf("uart #%zu", i + 1);
> -        memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s,
> +        memory_region_init_io(&pci->io[i], OBJECT(pci), &serial_io_ops, s,
>                               pci->name[i], 8);
> -        memory_region_add_subregion(&pci->iobar, 8 * i, &s->io);
> +        memory_region_add_subregion(&pci->iobar, 8 * i, &pci->io[i]);
>         pci->ports++;
>     }
> }
> diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
> index 087da3059a..ab3d0e56b5 100644
> --- a/hw/char/serial-pci.c
> +++ b/hw/char/serial-pci.c
> @@ -28,6 +28,7 @@
> #include "qemu/osdep.h"
> #include "qapi/error.h"
> #include "qemu/module.h"
> +#include "exec/memory.h"
> #include "hw/char/serial.h"
> #include "hw/irq.h"
> #include "hw/pci/pci_device.h"
> @@ -38,6 +39,7 @@
> struct PCISerialState {
>     PCIDevice dev;
>     SerialState state;
> +    MemoryRegion io;
>     uint8_t prog_if;
> };
>
> @@ -57,8 +59,9 @@ static void serial_pci_realize(PCIDevice *dev, Error **errp)
>     pci->dev.config[PCI_INTERRUPT_PIN] = 0x01;
>     s->irq = pci_allocate_irq(&pci->dev);
>
> -    memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s, "serial", 8);
> -    pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
> +    memory_region_init_io(&pci->io, OBJECT(pci), &serial_io_ops, s, "serial",
> +                          8);
> +    pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &pci->io);
> }
>
> static void serial_pci_exit(PCIDevice *dev)
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index a32eb25f58..83b642aec3 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -1045,10 +1045,10 @@ static void serial_mm_realize(DeviceState *dev, Error **errp)
>         return;
>     }
>
> -    memory_region_init_io(&s->io, OBJECT(dev),
> +    memory_region_init_io(&smm->io, OBJECT(dev),
>                           &serial_mm_ops[smm->endianness], smm, "serial",
>                           8 << smm->regshift);
> -    sysbus_init_mmio(SYS_BUS_DEVICE(smm), &s->io);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(smm), &smm->io);
>     sysbus_init_irq(SYS_BUS_DEVICE(smm), &smm->serial.irq);
> }
>
>

