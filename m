Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4236E7BC102
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 23:14:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qos8q-0008Ng-St; Fri, 06 Oct 2023 17:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qos8o-0008Mv-9n; Fri, 06 Oct 2023 17:13:46 -0400
Received: from mailout05.t-online.de ([194.25.134.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qos8l-0001TU-M1; Fri, 06 Oct 2023 17:13:46 -0400
Received: from fwd74.aul.t-online.de (fwd74.aul.t-online.de [10.223.144.100])
 by mailout05.t-online.de (Postfix) with SMTP id A1CF323014;
 Fri,  6 Oct 2023 23:13:37 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.31.195]) by fwd74.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qos8d-2U43tZ0; Fri, 6 Oct 2023 23:13:35 +0200
Message-ID: <424b4b93-3cf8-4119-b34f-288bff8a6764@t-online.de>
Date: Fri, 6 Oct 2023 23:13:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/pci-host: Add emulation of Mai Logic Articia S
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>,
 Rene Engel <ReneEngel80@emailn.de>
References: <cover.1696542537.git.balaton@eik.bme.hu>
 <90adfa92df7bf760059924a92deebcd6b32e7f37.1696542537.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <90adfa92df7bf760059924a92deebcd6b32e7f37.1696542537.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1696626815-3E7FBD65-56033A2F/0/0 CLEAN NORMAL
X-TOI-MSGID: 4703e284-0d01-407a-9294-41ac315e99ec
Received-SPF: none client-ip=194.25.134.82; envelope-from=vr_qemu@t-online.de;
 helo=mailout05.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Am 06.10.23 um 00:13 schrieb BALATON Zoltan:
> The Articia S is a generic chipset supporting several different CPUs
> that were used on some PPC boards. This is a minimal emulation of the
> parts needed for emulating the AmigaOne board.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/pci-host/Kconfig           |   5 +
>  hw/pci-host/articia.c         | 266 ++++++++++++++++++++++++++++++++++
>  hw/pci-host/meson.build       |   2 +
>  include/hw/pci-host/articia.h |  17 +++
>  4 files changed, 290 insertions(+)
>  create mode 100644 hw/pci-host/articia.c
>  create mode 100644 include/hw/pci-host/articia.h
> diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
> new file mode 100644
> index 0000000000..80558e1c47
> --- /dev/null
> +++ b/hw/pci-host/articia.c
> @@ -0,0 +1,266 @@
> +/*
> + * Mai Logic Articia S emulation
> + *
> + * Copyright (c) 2023 BALATON Zoltan
> + *
> + * This work is licensed under the GNU GPL license version 2 or later.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "hw/pci/pci_device.h"
> +#include "hw/pci/pci_host.h"
> +#include "hw/irq.h"
> +#include "hw/i2c/bitbang_i2c.h"
> +#include "hw/intc/i8259.h"
> +#include "hw/pci-host/articia.h"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(ArticiaState, ARTICIA)
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(ArticiaHostState, ARTICIA_PCI_HOST)
> +struct ArticiaHostState {
> +    PCIDevice parent_obj;
> +
> +    ArticiaState *as;
> +};
> +
> +/* TYPE_ARTICIA */
> +
> +struct ArticiaState {
> +    PCIHostState parent_obj;
> +
> +    qemu_irq irq[PCI_NUM_PINS];
> +    MemoryRegion io;
> +    MemoryRegion mem;
> +    MemoryRegion reg;
> +
> +    bitbang_i2c_interface smbus;
> +    uint32_t gpio; /* bits 0-7 in, 8-15 out, 16-23 direction (0 in, 1 out) */
> +    hwaddr gpio_base;
> +    MemoryRegion gpio_reg;
> +};
> +
> +static uint64_t articia_gpio_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    ArticiaState *s = opaque;
> +
> +    return (s->gpio >> (addr * 8)) & 0xff;
> +}
> +
> +static void articia_gpio_write(void *opaque, hwaddr addr, uint64_t val,
> +                               unsigned int size)
> +{
> +    ArticiaState *s = opaque;
> +    uint32_t sh = addr * 8;
> +
> +    if (addr == 0) {
> +        /* in bits read only? */
> +        return;
> +    }
> +
> +    if ((s->gpio & (0xff << sh)) != (val & 0xff) << sh) {
> +        s->gpio &= ~(0xff << sh | 0xff);
> +        s->gpio |= (val & 0xff) << sh;
> +        s->gpio |= bitbang_i2c_set(&s->smbus, BITBANG_I2C_SDA,
> +                                   s->gpio & BIT(16) ?
> +                                   !!(s->gpio & BIT(8)) : 1);
> +        if ((s->gpio & BIT(17))) {
> +            s->gpio &= ~BIT(0);
> +            s->gpio |= bitbang_i2c_set(&s->smbus, BITBANG_I2C_SCL,
> +                                       !!(s->gpio & BIT(9)));
> +        }
> +    }
> +}
> +
> +static const MemoryRegionOps articia_gpio_ops = {
> +    .read = articia_gpio_read,
> +    .write = articia_gpio_write,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 1,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static uint64_t articia_reg_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    ArticiaState *s = opaque;
> +    uint64_t ret = UINT_MAX;
> +
> +    switch (addr) {
> +    case 0xc00cf8:
> +        ret = pci_host_conf_le_ops.read(PCI_HOST_BRIDGE(s), 0, size);
> +        break;
> +    case 0xe00cfc ... 0xe00cff:
> +        ret = pci_host_data_le_ops.read(PCI_HOST_BRIDGE(s), addr - 0xe00cfc, size);
> +        break;
> +    case 0xf00000:
> +        ret = pic_read_irq(isa_pic);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: Unimplemented register read 0x%"
> +                      HWADDR_PRIx " %d\n", __func__, addr, size);
> +        break;
> +    }
> +    return ret;
> +}
> +
> +static void articia_reg_write(void *opaque, hwaddr addr, uint64_t val,
> +                              unsigned int size)
> +{
> +    ArticiaState *s = opaque;
> +
> +    switch (addr) {
> +    case 0xc00cf8:
> +        pci_host_conf_le_ops.write(PCI_HOST_BRIDGE(s), 0, val, size);
> +        break;
> +    case 0xe00cfc ... 0xe00cff:
> +        pci_host_data_le_ops.write(PCI_HOST_BRIDGE(s), addr, val, size);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: Unimplemented register write 0x%"
> +                      HWADDR_PRIx " %d <- %"PRIx64"\n", __func__, addr, size, val);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps articia_reg_ops = {
> +    .read = articia_reg_read,
> +    .write = articia_reg_write,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 4,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static void articia_pcihost_set_irq(void *opaque, int n, int level)
> +{
> +    ArticiaState *s = opaque;
> +    qemu_set_irq(s->irq[n], level);
> +}
> +
> +static void articia_realize(DeviceState *dev, Error **errp)
> +{
> +    ArticiaState *s = ARTICIA(dev);
> +    PCIHostState *h = PCI_HOST_BRIDGE(dev);
> +    PCIDevice *pdev;
> +
> +    bitbang_i2c_init(&s->smbus, i2c_init_bus(dev, "smbus"));
> +    memory_region_init_io(&s->gpio_reg, OBJECT(s), &articia_gpio_ops, s,
> +                          TYPE_ARTICIA, 4);
> +
> +    memory_region_init(&s->mem, OBJECT(dev), "pci-mem", UINT64_MAX);
> +    memory_region_init(&s->io, OBJECT(dev), "pci-io", 0xc00000);
> +    memory_region_init_io(&s->reg, OBJECT(s), &articia_reg_ops, s,
> +                          TYPE_ARTICIA, 0x1000000);
> +    memory_region_add_subregion_overlap(&s->reg, 0, &s->io, 1);
> +
> +    /* devfn_min is 8 that matches first PCI slot in AmigaOne */
> +    h->bus = pci_register_root_bus(dev, NULL, articia_pcihost_set_irq,
> +                                   pci_swizzle_map_irq_fn, dev, &s->mem,
> +                                   &s->io, PCI_DEVFN(8, 0), 4, TYPE_PCI_BUS);

Hi,

pci_swizzle_map_irq_fn() doesn't correctly map all AmigaOne PCI
interrupt pin on device to interrupt pin on connector connections.

I found this mapping and I think it's correct. For the VIA Southbridge
at 00:07.0 it's the only possible correct mapping. All PCI functions
interrupts are connected internally.

diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
index d9f052e3f0..2ad011af9c 100644
--- a/hw/pci-host/articia.c
+++ b/hw/pci-host/articia.c
@@ -138,6 +138,29 @@ static void articia_pcihost_set_irq(void *opaque,
int n, int level)
     qemu_set_irq(s->irq[n], level);
 }
 
+/*
+ * AmigaOne SE PCI slot to IRQ routing
+ *
+ * repository: https://source.denx.de/u-boot/custodians/u-boot-avr32.git
+ * refspec: v2010.06
+ * file: board/MAI/AmigaOneG3SE/articiaS_pci.c
+ */
+static int amigaone_pcihost_bus0_map_irq(PCIDevice *pdev, int pin)
+{
+    switch(PCI_SLOT(pdev->devfn))
+    {
+    case 6:     /* On board ethernet */
+        return 3;
+    case 7:     /* Southbridge */
+        return pin;
+    default:
+        break;
+    }
+
+    /* Slot 1 Device 8, Slot 2 Device 9, Slot 3 Device 10 */
+    return pci_swizzle(PCI_SLOT(pdev->devfn), pin);
+}
+
 static void articia_realize(DeviceState *dev, Error **errp)
 {
     ArticiaState *s = ARTICIA(dev);
@@ -155,7 +178,7 @@ static void articia_realize(DeviceState *dev, Error
**errp)
     memory_region_add_subregion_overlap(&s->reg, 0, &s->io, 1);
 
     h->bus = pci_register_root_bus(dev, NULL, articia_pcihost_set_irq,
-                                   pci_swizzle_map_irq_fn, dev,
+                                   amigaone_pcihost_bus0_map_irq, dev,
                                    &s->mem, &s->io, 0, 4, TYPE_PCI_BUS);
     pdev = pci_create_simple_multifunction(h->bus, PCI_DEVFN(0, 0),
                                            TYPE_ARTICIA_PCI_HOST);

With best regards,
Volker


> +    pdev = pci_create_simple_multifunction(h->bus, PCI_DEVFN(0, 0),
> +                                           TYPE_ARTICIA_PCI_HOST);
> +    ARTICIA_PCI_HOST(pdev)->as = s;
> +    pci_create_simple(h->bus, PCI_DEVFN(0, 1), TYPE_ARTICIA_PCI_BRIDGE);
> +
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->reg);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mem);
> +    qdev_init_gpio_out(dev, s->irq, ARRAY_SIZE(s->irq));
> +}
> +
> +static void articia_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = articia_realize;
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +}
> +
> +/* TYPE_ARTICIA_PCI_HOST */
> +
> +static void articia_pci_host_cfg_write(PCIDevice *d, uint32_t addr,
> +                                       uint32_t val, int len)
> +{
> +    ArticiaState *s = ARTICIA_PCI_HOST(d)->as;
> +
> +    pci_default_write_config(d, addr, val, len);
> +    switch (addr) {
> +    case 0x40:
> +        s->gpio_base = val;
> +        break;
> +    case 0x44:
> +        if (val != 0x11) {
> +            /* FIXME what do the bits actually mean? */
> +            break;
> +        }
> +        if (memory_region_is_mapped(&s->gpio_reg)) {
> +            memory_region_del_subregion(&s->io, &s->gpio_reg);
> +        }
> +        memory_region_add_subregion(&s->io, s->gpio_base + 0x38, &s->gpio_reg);
> +        break;
> +    }
> +}
> +
> +static void articia_pci_host_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +
> +    k->config_write = articia_pci_host_cfg_write;
> +    k->vendor_id = 0x10cc;
> +    k->device_id = 0x0660;
> +    k->class_id = PCI_CLASS_BRIDGE_HOST;
> +    /*
> +     * PCI-facing part of the host bridge,
> +     * not usable without the host-facing part
> +     */
> +    dc->user_creatable = false;
> +}
> +
> +/* TYPE_ARTICIA_PCI_BRIDGE */
> +
> +static void articia_pci_bridge_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +
> +    k->vendor_id = 0x10cc;
> +    k->device_id = 0x0661;
> +    k->class_id = PCI_CLASS_BRIDGE_HOST;
> +    /*
> +     * PCI-facing part of the host bridge,
> +     * not usable without the host-facing part
> +     */
> +    dc->user_creatable = false;
> +}
> +
> +static const TypeInfo articia_types[] = {
> +    {
> +        .name          = TYPE_ARTICIA,
> +        .parent        = TYPE_PCI_HOST_BRIDGE,
> +        .instance_size = sizeof(ArticiaState),
> +        .class_init    = articia_class_init,
> +    },
> +    {
> +        .name          = TYPE_ARTICIA_PCI_HOST,
> +        .parent        = TYPE_PCI_DEVICE,
> +        .instance_size = sizeof(ArticiaHostState),
> +        .class_init    = articia_pci_host_class_init,
> +        .interfaces = (InterfaceInfo[]) {
> +              { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +              { },
> +        },
> +    },
> +    {
> +        .name          = TYPE_ARTICIA_PCI_BRIDGE,
> +        .parent        = TYPE_PCI_DEVICE,
> +        .instance_size = sizeof(PCIDevice),
> +        .class_init    = articia_pci_bridge_class_init,
> +        .interfaces = (InterfaceInfo[]) {
> +              { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +              { },
> +        },
> +    },
> +};
> +
> +DEFINE_TYPES(articia_types)
>

