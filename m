Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 464957CE941
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 22:43:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtDNo-00056A-HI; Wed, 18 Oct 2023 16:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qtDNQ-0004gg-Cc; Wed, 18 Oct 2023 16:42:50 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qtDNL-0001C9-Bz; Wed, 18 Oct 2023 16:42:47 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 169DB756082;
 Wed, 18 Oct 2023 22:42:41 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AA9F0756078; Wed, 18 Oct 2023 22:42:40 +0200 (CEST)
Message-Id: <5101a4007b773b2969e2c3356f16de69fc3d064a.1697661160.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1697661160.git.balaton@eik.bme.hu>
References: <cover.1697661160.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 2/4] hw/pci-host: Add emulation of Mai Logic Articia S
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Date: Wed, 18 Oct 2023 22:42:40 +0200 (CEST)
X-Spam-Probability: 8%
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

The Articia S is a generic chipset supporting several different CPUs
that were among others used on some PPC boards. This is a minimal
emulation of the parts needed for emulating the AmigaOne board.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/Kconfig           |   5 +
 hw/pci-host/articia.c         | 293 ++++++++++++++++++++++++++++++++++
 hw/pci-host/meson.build       |   2 +
 include/hw/pci-host/articia.h |  17 ++
 4 files changed, 317 insertions(+)
 create mode 100644 hw/pci-host/articia.c
 create mode 100644 include/hw/pci-host/articia.h

diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index a07070eddf..33014c80a4 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -73,6 +73,11 @@ config SH_PCI
     bool
     select PCI
 
+config ARTICIA
+    bool
+    select PCI
+    select I8259
+
 config MV64361
     bool
     select PCI
diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
new file mode 100644
index 0000000000..f3fcc49f81
--- /dev/null
+++ b/hw/pci-host/articia.c
@@ -0,0 +1,293 @@
+/*
+ * Mai Logic Articia S emulation
+ *
+ * Copyright (c) 2023 BALATON Zoltan
+ *
+ * This work is licensed under the GNU GPL license version 2 or later.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/pci/pci_device.h"
+#include "hw/pci/pci_host.h"
+#include "hw/irq.h"
+#include "hw/i2c/bitbang_i2c.h"
+#include "hw/intc/i8259.h"
+#include "hw/pci-host/articia.h"
+
+/*
+ * This is a minimal emulation of this chip as used in AmigaOne board.
+ * Most features are missing but those are not needed by firmware and guests.
+ */
+
+OBJECT_DECLARE_SIMPLE_TYPE(ArticiaState, ARTICIA)
+
+OBJECT_DECLARE_SIMPLE_TYPE(ArticiaHostState, ARTICIA_PCI_HOST)
+struct ArticiaHostState {
+    PCIDevice parent_obj;
+
+    ArticiaState *as;
+};
+
+/* TYPE_ARTICIA */
+
+struct ArticiaState {
+    PCIHostState parent_obj;
+
+    qemu_irq irq[PCI_NUM_PINS];
+    MemoryRegion io;
+    MemoryRegion mem;
+    MemoryRegion reg;
+
+    bitbang_i2c_interface smbus;
+    uint32_t gpio; /* bits 0-7 in, 8-15 out, 16-23 direction (0 in, 1 out) */
+    hwaddr gpio_base;
+    MemoryRegion gpio_reg;
+};
+
+static uint64_t articia_gpio_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    ArticiaState *s = opaque;
+
+    return (s->gpio >> (addr * 8)) & 0xff;
+}
+
+static void articia_gpio_write(void *opaque, hwaddr addr, uint64_t val,
+                               unsigned int size)
+{
+    ArticiaState *s = opaque;
+    uint32_t sh = addr * 8;
+
+    if (addr == 0) {
+        /* in bits read only? */
+        return;
+    }
+
+    if ((s->gpio & (0xff << sh)) != (val & 0xff) << sh) {
+        s->gpio &= ~(0xff << sh | 0xff);
+        s->gpio |= (val & 0xff) << sh;
+        s->gpio |= bitbang_i2c_set(&s->smbus, BITBANG_I2C_SDA,
+                                   s->gpio & BIT(16) ?
+                                   !!(s->gpio & BIT(8)) : 1);
+        if ((s->gpio & BIT(17))) {
+            s->gpio &= ~BIT(0);
+            s->gpio |= bitbang_i2c_set(&s->smbus, BITBANG_I2C_SCL,
+                                       !!(s->gpio & BIT(9)));
+        }
+    }
+}
+
+static const MemoryRegionOps articia_gpio_ops = {
+    .read = articia_gpio_read,
+    .write = articia_gpio_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 1,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static uint64_t articia_reg_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    ArticiaState *s = opaque;
+    uint64_t ret = UINT_MAX;
+
+    switch (addr) {
+    case 0xc00cf8:
+        ret = pci_host_conf_le_ops.read(PCI_HOST_BRIDGE(s), 0, size);
+        break;
+    case 0xe00cfc ... 0xe00cff:
+        ret = pci_host_data_le_ops.read(PCI_HOST_BRIDGE(s), addr - 0xe00cfc, size);
+        break;
+    case 0xf00000:
+        ret = pic_read_irq(isa_pic);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Unimplemented register read 0x%"
+                      HWADDR_PRIx " %d\n", __func__, addr, size);
+        break;
+    }
+    return ret;
+}
+
+static void articia_reg_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned int size)
+{
+    ArticiaState *s = opaque;
+
+    switch (addr) {
+    case 0xc00cf8:
+        pci_host_conf_le_ops.write(PCI_HOST_BRIDGE(s), 0, val, size);
+        break;
+    case 0xe00cfc ... 0xe00cff:
+        pci_host_data_le_ops.write(PCI_HOST_BRIDGE(s), addr, val, size);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Unimplemented register write 0x%"
+                      HWADDR_PRIx " %d <- %"PRIx64"\n", __func__, addr, size, val);
+        break;
+    }
+}
+
+static const MemoryRegionOps articia_reg_ops = {
+    .read = articia_reg_read,
+    .write = articia_reg_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void articia_pcihost_set_irq(void *opaque, int n, int level)
+{
+    ArticiaState *s = opaque;
+    qemu_set_irq(s->irq[n], level);
+}
+
+/*
+ * AmigaOne SE PCI slot to IRQ routing
+ *
+ * repository: https://source.denx.de/u-boot/custodians/u-boot-avr32.git
+ * refspec: v2010.06
+ * file: board/MAI/AmigaOneG3SE/articiaS_pci.c
+ */
+static int amigaone_pcihost_bus0_map_irq(PCIDevice *pdev, int pin)
+{
+    int devfn_slot = PCI_SLOT(pdev->devfn);
+
+    switch (devfn_slot) {
+    case 6:  /* On board ethernet */
+        return 3;
+    case 7:  /* South bridge */
+        return pin;
+    default: /* PCI Slot 1 Devfn slot 8, Slot 2 Devfn 9, Slot 3 Devfn 10 */
+        return pci_swizzle(devfn_slot, pin);
+    }
+
+}
+
+static void articia_realize(DeviceState *dev, Error **errp)
+{
+    ArticiaState *s = ARTICIA(dev);
+    PCIHostState *h = PCI_HOST_BRIDGE(dev);
+    PCIDevice *pdev;
+
+    bitbang_i2c_init(&s->smbus, i2c_init_bus(dev, "smbus"));
+    memory_region_init_io(&s->gpio_reg, OBJECT(s), &articia_gpio_ops, s,
+                          TYPE_ARTICIA, 4);
+
+    memory_region_init(&s->mem, OBJECT(dev), "pci-mem", UINT64_MAX);
+    memory_region_init(&s->io, OBJECT(dev), "pci-io", 0xc00000);
+    memory_region_init_io(&s->reg, OBJECT(s), &articia_reg_ops, s,
+                          TYPE_ARTICIA, 0x1000000);
+    memory_region_add_subregion_overlap(&s->reg, 0, &s->io, 1);
+
+    /* devfn_min is 8 that matches first PCI slot in AmigaOne */
+    h->bus = pci_register_root_bus(dev, NULL, articia_pcihost_set_irq,
+                                   amigaone_pcihost_bus0_map_irq, dev, &s->mem,
+                                   &s->io, PCI_DEVFN(8, 0), 4, TYPE_PCI_BUS);
+    pdev = pci_create_simple_multifunction(h->bus, PCI_DEVFN(0, 0),
+                                           TYPE_ARTICIA_PCI_HOST);
+    ARTICIA_PCI_HOST(pdev)->as = s;
+    pci_create_simple(h->bus, PCI_DEVFN(0, 1), TYPE_ARTICIA_PCI_BRIDGE);
+
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->reg);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mem);
+    qdev_init_gpio_out(dev, s->irq, ARRAY_SIZE(s->irq));
+}
+
+static void articia_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = articia_realize;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+}
+
+/* TYPE_ARTICIA_PCI_HOST */
+
+static void articia_pci_host_cfg_write(PCIDevice *d, uint32_t addr,
+                                       uint32_t val, int len)
+{
+    ArticiaState *s = ARTICIA_PCI_HOST(d)->as;
+
+    pci_default_write_config(d, addr, val, len);
+    switch (addr) {
+    case 0x40:
+        s->gpio_base = val;
+        break;
+    case 0x44:
+        if (val != 0x11) {
+            /* FIXME what do the bits actually mean? */
+            break;
+        }
+        if (memory_region_is_mapped(&s->gpio_reg)) {
+            memory_region_del_subregion(&s->io, &s->gpio_reg);
+        }
+        memory_region_add_subregion(&s->io, s->gpio_base + 0x38, &s->gpio_reg);
+        break;
+    }
+}
+
+static void articia_pci_host_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->config_write = articia_pci_host_cfg_write;
+    k->vendor_id = 0x10cc;
+    k->device_id = 0x0660;
+    k->class_id = PCI_CLASS_BRIDGE_HOST;
+    /*
+     * PCI-facing part of the host bridge,
+     * not usable without the host-facing part
+     */
+    dc->user_creatable = false;
+}
+
+/* TYPE_ARTICIA_PCI_BRIDGE */
+
+static void articia_pci_bridge_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->vendor_id = 0x10cc;
+    k->device_id = 0x0661;
+    k->class_id = PCI_CLASS_BRIDGE_HOST;
+    /*
+     * PCI-facing part of the host bridge,
+     * not usable without the host-facing part
+     */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo articia_types[] = {
+    {
+        .name          = TYPE_ARTICIA,
+        .parent        = TYPE_PCI_HOST_BRIDGE,
+        .instance_size = sizeof(ArticiaState),
+        .class_init    = articia_class_init,
+    },
+    {
+        .name          = TYPE_ARTICIA_PCI_HOST,
+        .parent        = TYPE_PCI_DEVICE,
+        .instance_size = sizeof(ArticiaHostState),
+        .class_init    = articia_pci_host_class_init,
+        .interfaces = (InterfaceInfo[]) {
+              { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+              { },
+        },
+    },
+    {
+        .name          = TYPE_ARTICIA_PCI_BRIDGE,
+        .parent        = TYPE_PCI_DEVICE,
+        .instance_size = sizeof(PCIDevice),
+        .class_init    = articia_pci_bridge_class_init,
+        .interfaces = (InterfaceInfo[]) {
+              { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+              { },
+        },
+    },
+};
+
+DEFINE_TYPES(articia_types)
diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
index 64eada76fe..40de48eb7f 100644
--- a/hw/pci-host/meson.build
+++ b/hw/pci-host/meson.build
@@ -20,6 +20,8 @@ pci_ss.add(when: 'CONFIG_GRACKLE_PCI', if_true: files('grackle.c'))
 pci_ss.add(when: 'CONFIG_UNIN_PCI', if_true: files('uninorth.c'))
 # PowerPC E500 boards
 pci_ss.add(when: 'CONFIG_PPCE500_PCI', if_true: files('ppce500.c'))
+# AmigaOne
+pci_ss.add(when: 'CONFIG_ARTICIA', if_true: files('articia.c'))
 # Pegasos2
 pci_ss.add(when: 'CONFIG_MV64361', if_true: files('mv64361.c'))
 
diff --git a/include/hw/pci-host/articia.h b/include/hw/pci-host/articia.h
new file mode 100644
index 0000000000..529c240274
--- /dev/null
+++ b/include/hw/pci-host/articia.h
@@ -0,0 +1,17 @@
+/*
+ * Mai Logic Articia S emulation
+ *
+ * Copyright (c) 2023 BALATON Zoltan
+ *
+ * This work is licensed under the GNU GPL license version 2 or later.
+ *
+ */
+
+#ifndef ARTICIA_H
+#define ARTICIA_H
+
+#define TYPE_ARTICIA "articia"
+#define TYPE_ARTICIA_PCI_HOST "articia-pci-host"
+#define TYPE_ARTICIA_PCI_BRIDGE "articia-pci-bridge"
+
+#endif
-- 
2.30.9


