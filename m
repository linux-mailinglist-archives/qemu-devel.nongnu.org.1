Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4179770D9EA
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:06:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Otw-0004yl-HO; Tue, 23 May 2023 06:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qianfanguijin@163.com>)
 id 1q1Otq-0004vH-M9; Tue, 23 May 2023 06:05:50 -0400
Received: from m12.mail.163.com ([220.181.12.215])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qianfanguijin@163.com>)
 id 1q1Otl-00077H-QJ; Tue, 23 May 2023 06:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PBKIb
 MyUYpHRbQoVT1GY7VDbWnJBs+0fqSRjR7QVXjI=; b=U9nYJbuLlR/xL9Du3Dp3h
 wFY4+KoHoAxnusf7gWlc+cR1p+ZtV8Q2y75YRtv5NVFkKuS2r5gEgwNEFQHTD6vB
 tioMPMwBLf9abXbRA2TJ2q8kmJyNgUV/MPVBMdzku83keVzBFejSY/3CJnaEmZIq
 qAA/fju9xwI43JWCPbMC1Q=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.19])
 by zwqz-smtp-mta-g0-3 (Coremail) with SMTP id _____wAnDC3Wj2xkMfafAQ--.65319S4;
 Tue, 23 May 2023 18:05:16 +0800 (CST)
From: qianfanguijin@163.com
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH v5 02/11] hw/arm/allwinner-r40: add Clock Control Unit
Date: Tue, 23 May 2023 18:04:59 +0800
Message-Id: <20230523100508.32564-3-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230523100508.32564-1-qianfanguijin@163.com>
References: <20230523100508.32564-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnDC3Wj2xkMfafAQ--.65319S4
X-Coremail-Antispam: 1Uf129KBjvAXoW3Zw43AFyfXr13GF1xKF4rXwb_yoW8JF17Ko
 WSqF4rXw4Ik3s3Jr1xC342yr17WFnY93yUJw4ayFWfC3WUJr4DK395tw1fXr4Sgw4FkF4k
 Jay3ZryfZFW8X3Z5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RBa0mUUUUU
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiGh147VaEFUv5TgAAsp
Received-SPF: pass client-ip=220.181.12.215;
 envelope-from=qianfanguijin@163.com; helo=m12.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

From: qianfan Zhao <qianfanguijin@163.com>

The CCU provides the registers to program the PLLs and the controls
most of the clock generation, division, distribution, synchronization
and gating.

This commit adds support for the Clock Control Unit which emulates
a simple read/write register interface.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 hw/arm/allwinner-r40.c              |   8 +-
 hw/misc/allwinner-r40-ccu.c         | 209 ++++++++++++++++++++++++++++
 hw/misc/meson.build                 |   1 +
 include/hw/arm/allwinner-r40.h      |   2 +
 include/hw/misc/allwinner-r40-ccu.h |  65 +++++++++
 5 files changed, 284 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/allwinner-r40-ccu.c
 create mode 100644 include/hw/misc/allwinner-r40-ccu.h

diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 97f2aa92fd..72973f69ff 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -42,6 +42,7 @@ const hwaddr allwinner_r40_memmap[] = {
     [AW_R40_DEV_MMC1]       = 0x01c10000,
     [AW_R40_DEV_MMC2]       = 0x01c11000,
     [AW_R40_DEV_MMC3]       = 0x01c12000,
+    [AW_R40_DEV_CCU]        = 0x01c20000,
     [AW_R40_DEV_PIT]        = 0x01c20c00,
     [AW_R40_DEV_UART0]      = 0x01c28000,
     [AW_R40_DEV_GIC_DIST]   = 0x01c81000,
@@ -80,7 +81,6 @@ static struct AwR40Unimplemented r40_unimplemented[] = {
     { "usb2-host",  0x01c1c000, 4 * KiB },
     { "cs1",        0x01c1d000, 4 * KiB },
     { "spi3",       0x01c1f000, 4 * KiB },
-    { "ccu",        0x01c20000, 1 * KiB },
     { "rtc",        0x01c20400, 1 * KiB },
     { "pio",        0x01c20800, 1 * KiB },
     { "owa",        0x01c21000, 1 * KiB },
@@ -250,6 +250,8 @@ static void allwinner_r40_init(Object *obj)
     object_property_add_alias(obj, "clk1-freq", OBJECT(&s->timer),
                               "clk1-freq");
 
+    object_initialize_child(obj, "ccu", &s->ccu, TYPE_AW_R40_CCU);
+
     for (int i = 0; i < AW_R40_NUM_MMCS; i++) {
         object_initialize_child(obj, mmc_names[i], &s->mmc[i],
                                 TYPE_AW_SDHOST_SUN5I);
@@ -364,6 +366,10 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(),
                                 s->memmap[AW_R40_DEV_SRAM_A4], &s->sram_a4);
 
+    /* Clock Control Unit */
+    sysbus_realize(SYS_BUS_DEVICE(&s->ccu), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_R40_DEV_CCU]);
+
     /* SD/MMC */
     for (int i = 0; i < AW_R40_NUM_MMCS; i++) {
         qemu_irq irq = qdev_get_gpio_in(DEVICE(&s->gic),
diff --git a/hw/misc/allwinner-r40-ccu.c b/hw/misc/allwinner-r40-ccu.c
new file mode 100644
index 0000000000..d82fee12db
--- /dev/null
+++ b/hw/misc/allwinner-r40-ccu.c
@@ -0,0 +1,209 @@
+/*
+ * Allwinner R40 Clock Control Unit emulation
+ *
+ * Copyright (C) 2023 qianfan Zhao <qianfanguijin@163.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/misc/allwinner-r40-ccu.h"
+
+/* CCU register offsets */
+enum {
+    REG_PLL_CPUX_CTRL           = 0x0000,
+    REG_PLL_AUDIO_CTRL          = 0x0008,
+    REG_PLL_VIDEO0_CTRL         = 0x0010,
+    REG_PLL_VE_CTRL             = 0x0018,
+    REG_PLL_DDR0_CTRL           = 0x0020,
+    REG_PLL_PERIPH0_CTRL        = 0x0028,
+    REG_PLL_PERIPH1_CTRL        = 0x002c,
+    REG_PLL_VIDEO1_CTRL         = 0x0030,
+    REG_PLL_SATA_CTRL           = 0x0034,
+    REG_PLL_GPU_CTRL            = 0x0038,
+    REG_PLL_MIPI_CTRL           = 0x0040,
+    REG_PLL_DE_CTRL             = 0x0048,
+    REG_PLL_DDR1_CTRL           = 0x004c,
+    REG_AHB1_APB1_CFG           = 0x0054,
+    REG_APB2_CFG                = 0x0058,
+    REG_MMC0_CLK                = 0x0088,
+    REG_MMC1_CLK                = 0x008c,
+    REG_MMC2_CLK                = 0x0090,
+    REG_MMC3_CLK                = 0x0094,
+    REG_USBPHY_CFG              = 0x00cc,
+    REG_PLL_DDR_AUX             = 0x00f0,
+    REG_DRAM_CFG                = 0x00f4,
+    REG_PLL_DDR1_CFG            = 0x00f8,
+    REG_DRAM_CLK_GATING         = 0x0100,
+    REG_GMAC_CLK                = 0x0164,
+    REG_SYS_32K_CLK             = 0x0310,
+    REG_PLL_LOCK_CTRL           = 0x0320,
+};
+
+#define REG_INDEX(offset)    (offset / sizeof(uint32_t))
+
+/* CCU register flags */
+enum {
+    REG_PLL_ENABLE           = (1 << 31),
+    REG_PLL_LOCK             = (1 << 28),
+};
+
+static uint64_t allwinner_r40_ccu_read(void *opaque, hwaddr offset,
+                                       unsigned size)
+{
+    const AwR40ClockCtlState *s = AW_R40_CCU(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    switch (offset) {
+    case 0x324 ... AW_R40_CCU_IOSIZE:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    }
+
+    return s->regs[idx];
+}
+
+static void allwinner_r40_ccu_write(void *opaque, hwaddr offset,
+                                    uint64_t val, unsigned size)
+{
+    AwR40ClockCtlState *s = AW_R40_CCU(opaque);
+
+    switch (offset) {
+    case REG_DRAM_CFG:    /* DRAM Configuration(for DDR0) */
+        /* bit16: SDRCLK_UPD (SDRCLK configuration 0 update) */
+        val &= ~(1 << 16);
+        break;
+    case REG_PLL_DDR1_CTRL: /* DDR1 Control register */
+        /* bit30: SDRPLL_UPD */
+        val &= ~(1 << 30);
+        if (val & REG_PLL_ENABLE) {
+            val |= REG_PLL_LOCK;
+        }
+        break;
+    case REG_PLL_CPUX_CTRL:
+    case REG_PLL_AUDIO_CTRL:
+    case REG_PLL_VE_CTRL:
+    case REG_PLL_VIDEO0_CTRL:
+    case REG_PLL_DDR0_CTRL:
+    case REG_PLL_PERIPH0_CTRL:
+    case REG_PLL_PERIPH1_CTRL:
+    case REG_PLL_VIDEO1_CTRL:
+    case REG_PLL_SATA_CTRL:
+    case REG_PLL_GPU_CTRL:
+    case REG_PLL_MIPI_CTRL:
+    case REG_PLL_DE_CTRL:
+        if (val & REG_PLL_ENABLE) {
+            val |= REG_PLL_LOCK;
+        }
+        break;
+    case 0x324 ... AW_R40_CCU_IOSIZE:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented write offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        break;
+    }
+
+    s->regs[REG_INDEX(offset)] = (uint32_t) val;
+}
+
+static const MemoryRegionOps allwinner_r40_ccu_ops = {
+    .read = allwinner_r40_ccu_read,
+    .write = allwinner_r40_ccu_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 4,
+};
+
+static void allwinner_r40_ccu_reset(DeviceState *dev)
+{
+    AwR40ClockCtlState *s = AW_R40_CCU(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    /* Set default values for registers */
+    s->regs[REG_INDEX(REG_PLL_CPUX_CTRL)]       = 0x00001000;
+    s->regs[REG_INDEX(REG_PLL_AUDIO_CTRL)]      = 0x00035514;
+    s->regs[REG_INDEX(REG_PLL_VIDEO0_CTRL)]     = 0x03006207;
+    s->regs[REG_INDEX(REG_PLL_VE_CTRL)]         = 0x03006207;
+    s->regs[REG_INDEX(REG_PLL_DDR0_CTRL)]       = 0x00001000,
+    s->regs[REG_INDEX(REG_PLL_PERIPH0_CTRL)]    = 0x00041811;
+    s->regs[REG_INDEX(REG_PLL_PERIPH1_CTRL)]    = 0x00041811;
+    s->regs[REG_INDEX(REG_PLL_VIDEO1_CTRL)]     = 0x03006207;
+    s->regs[REG_INDEX(REG_PLL_SATA_CTRL)]       = 0x00001811;
+    s->regs[REG_INDEX(REG_PLL_GPU_CTRL)]        = 0x03006207;
+    s->regs[REG_INDEX(REG_PLL_MIPI_CTRL)]       = 0x00000515;
+    s->regs[REG_INDEX(REG_PLL_DE_CTRL)]         = 0x03006207;
+    s->regs[REG_INDEX(REG_PLL_DDR1_CTRL)]       = 0x00001800;
+    s->regs[REG_INDEX(REG_AHB1_APB1_CFG)]       = 0x00001010;
+    s->regs[REG_INDEX(REG_APB2_CFG)]            = 0x01000000;
+    s->regs[REG_INDEX(REG_PLL_DDR_AUX)]         = 0x00000001;
+    s->regs[REG_INDEX(REG_PLL_DDR1_CFG)]        = 0x0ccca000;
+    s->regs[REG_INDEX(REG_SYS_32K_CLK)]         = 0x0000000f;
+}
+
+static void allwinner_r40_ccu_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    AwR40ClockCtlState *s = AW_R40_CCU(obj);
+
+    /* Memory mapping */
+    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_r40_ccu_ops, s,
+                          TYPE_AW_R40_CCU, AW_R40_CCU_IOSIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription allwinner_r40_ccu_vmstate = {
+    .name = "allwinner-r40-ccu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AwR40ClockCtlState, AW_R40_CCU_REGS_NUM),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_r40_ccu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = allwinner_r40_ccu_reset;
+    dc->vmsd = &allwinner_r40_ccu_vmstate;
+}
+
+static const TypeInfo allwinner_r40_ccu_info = {
+    .name          = TYPE_AW_R40_CCU,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_r40_ccu_init,
+    .instance_size = sizeof(AwR40ClockCtlState),
+    .class_init    = allwinner_r40_ccu_class_init,
+};
+
+static void allwinner_r40_ccu_register(void)
+{
+    type_register_static(&allwinner_r40_ccu_info);
+}
+
+type_init(allwinner_r40_ccu_register)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index a40245ad44..96e35f1cdb 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -44,6 +44,7 @@ specific_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-cpucfg.c'
 softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-dramc.c'))
 softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-sysctrl.c'))
 softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sid.c'))
+softmmu_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40-ccu.c'))
 softmmu_ss.add(when: 'CONFIG_AXP209_PMU', if_true: files('axp209.c'))
 softmmu_ss.add(when: 'CONFIG_REALVIEW', if_true: files('arm_sysctl.c'))
 softmmu_ss.add(when: 'CONFIG_NSERIES', if_true: files('cbus.c'))
diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index 348bf25d6b..3be9dc962b 100644
--- a/include/hw/arm/allwinner-r40.h
+++ b/include/hw/arm/allwinner-r40.h
@@ -25,6 +25,7 @@
 #include "hw/timer/allwinner-a10-pit.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/sd/allwinner-sdhost.h"
+#include "hw/misc/allwinner-r40-ccu.h"
 #include "target/arm/cpu.h"
 #include "sysemu/block-backend.h"
 
@@ -79,6 +80,7 @@ struct AwR40State {
     const hwaddr *memmap;
     AwA10PITState timer;
     AwSdHostState mmc[AW_R40_NUM_MMCS];
+    AwR40ClockCtlState ccu;
     GICState gic;
     MemoryRegion sram_a1;
     MemoryRegion sram_a2;
diff --git a/include/hw/misc/allwinner-r40-ccu.h b/include/hw/misc/allwinner-r40-ccu.h
new file mode 100644
index 0000000000..ceb74eff92
--- /dev/null
+++ b/include/hw/misc/allwinner-r40-ccu.h
@@ -0,0 +1,65 @@
+/*
+ * Allwinner R40 Clock Control Unit emulation
+ *
+ * Copyright (C) 2023 qianfan Zhao <qianfanguijin@163.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_MISC_ALLWINNER_R40_CCU_H
+#define HW_MISC_ALLWINNER_R40_CCU_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+
+/**
+ * @name Constants
+ * @{
+ */
+
+/** Size of register I/O address space used by CCU device */
+#define AW_R40_CCU_IOSIZE        (0x400)
+
+/** Total number of known registers */
+#define AW_R40_CCU_REGS_NUM      (AW_R40_CCU_IOSIZE / sizeof(uint32_t))
+
+/** @} */
+
+/**
+ * @name Object model
+ * @{
+ */
+
+#define TYPE_AW_R40_CCU    "allwinner-r40-ccu"
+OBJECT_DECLARE_SIMPLE_TYPE(AwR40ClockCtlState, AW_R40_CCU)
+
+/** @} */
+
+/**
+ * Allwinner R40 CCU object instance state.
+ */
+struct AwR40ClockCtlState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    /** Maps I/O registers in physical memory */
+    MemoryRegion iomem;
+
+    /** Array of hardware registers */
+    uint32_t regs[AW_R40_CCU_REGS_NUM];
+
+};
+
+#endif /* HW_MISC_ALLWINNER_R40_CCU_H */
-- 
2.25.1


