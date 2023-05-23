Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A62470D9E7
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:06:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Otl-0004uW-2I; Tue, 23 May 2023 06:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qianfanguijin@163.com>)
 id 1q1Oti-0004tP-EX; Tue, 23 May 2023 06:05:42 -0400
Received: from m12.mail.163.com ([220.181.12.217])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qianfanguijin@163.com>)
 id 1q1Otf-00075c-LR; Tue, 23 May 2023 06:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mOXE2
 uaIcrp25NSnK4PI8/ZCZ1s0FQlugq54PpKya5Y=; b=E4bhy7y9a/y4VFGsrDVC6
 ae2arNj9SmS6r88Ewor+WzhUPQXDusFPdHv+LMG5ht3r3yxyugf9+BtkeXNwtsBY
 9F1KftP52LcHhLvJMVtsIgcg9ywSID0ybIAdTKGShJBrOSQBEr93a/bZB9Cfyqbc
 UOPEThRjAJx34C+vGEpp7g=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.19])
 by zwqz-smtp-mta-g0-3 (Coremail) with SMTP id
 _____wAnDC3Wj2xkMfafAQ--.65319S11; 
 Tue, 23 May 2023 18:05:30 +0800 (CST)
From: qianfanguijin@163.com
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH v5 09/11] hw: arm: allwinner-sramc: Add SRAM Controller
 support for R40
Date: Tue, 23 May 2023 18:05:06 +0800
Message-Id: <20230523100508.32564-10-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230523100508.32564-1-qianfanguijin@163.com>
References: <20230523100508.32564-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnDC3Wj2xkMfafAQ--.65319S11
X-Coremail-Antispam: 1Uf129KBjvAXoWfJFWDtr18GFyrAry3Wr17Jrb_yoW8JF43Zo
 WIgF45XrWIg3s7ZrnYkw1ayr17WrnxKr4xAw4YkF4aka45Awsrt348t3s3Ja1fWr4FyF1x
 Ja4SgryfC3ykG3s5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4R1xRQUUUUU
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiXAt47VXl6riL5QAAsO
Received-SPF: pass client-ip=220.181.12.217;
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

Only a few important registers are added, especially the SRAM_VER
register.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 hw/arm/Kconfig                    |   1 +
 hw/arm/allwinner-r40.c            |   7 +-
 hw/misc/Kconfig                   |   3 +
 hw/misc/allwinner-sramc.c         | 184 ++++++++++++++++++++++++++++++
 hw/misc/meson.build               |   1 +
 hw/misc/trace-events              |   4 +
 include/hw/arm/allwinner-r40.h    |   3 +
 include/hw/misc/allwinner-sramc.h |  69 +++++++++++
 8 files changed, 271 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/allwinner-sramc.c
 create mode 100644 include/hw/misc/allwinner-sramc.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index aacfbe17ad..c64b6ea211 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -377,6 +377,7 @@ config ALLWINNER_H3
 config ALLWINNER_R40
     bool
     default y if TCG && ARM
+    select ALLWINNER_SRAMC
     select ALLWINNER_A10_PIT
     select AXP2XX_PMU
     select SERIAL
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index c018ad231a..7d29eb224f 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -39,6 +39,7 @@ const hwaddr allwinner_r40_memmap[] = {
     [AW_R40_DEV_SRAM_A2]    = 0x00004000,
     [AW_R40_DEV_SRAM_A3]    = 0x00008000,
     [AW_R40_DEV_SRAM_A4]    = 0x0000b400,
+    [AW_R40_DEV_SRAMC]      = 0x01c00000,
     [AW_R40_DEV_EMAC]       = 0x01c0b000,
     [AW_R40_DEV_MMC0]       = 0x01c0f000,
     [AW_R40_DEV_MMC1]       = 0x01c10000,
@@ -76,7 +77,6 @@ struct AwR40Unimplemented {
 static struct AwR40Unimplemented r40_unimplemented[] = {
     { "d-engine",   0x01000000, 4 * MiB },
     { "d-inter",    0x01400000, 128 * KiB },
-    { "sram-c",     0x01c00000, 4 * KiB },
     { "dma",        0x01c02000, 4 * KiB },
     { "nfdc",       0x01c03000, 4 * KiB },
     { "ts",         0x01c04000, 4 * KiB },
@@ -288,6 +288,8 @@ static void allwinner_r40_init(Object *obj)
                              "ram-addr");
     object_property_add_alias(obj, "ram-size", OBJECT(&s->dramc),
                               "ram-size");
+
+    object_initialize_child(obj, "sramc", &s->sramc, TYPE_AW_SRAMC_SUN8I_R40);
 }
 
 static void allwinner_r40_realize(DeviceState *dev, Error **errp)
@@ -382,6 +384,9 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
                        AW_R40_GIC_SPI_TIMER1));
 
     /* SRAM */
+    sysbus_realize(SYS_BUS_DEVICE(&s->sramc), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sramc), 0, s->memmap[AW_R40_DEV_SRAMC]);
+
     memory_region_init_ram(&s->sram_a1, OBJECT(dev), "sram A1",
                             16 * KiB, &error_abort);
     memory_region_init_ram(&s->sram_a2, OBJECT(dev), "sram A2",
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index efeb430a6c..e4c2149175 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -170,6 +170,9 @@ config VIRT_CTRL
 config LASI
     bool
 
+config ALLWINNER_SRAMC
+    bool
+
 config ALLWINNER_A10_CCM
     bool
 
diff --git a/hw/misc/allwinner-sramc.c b/hw/misc/allwinner-sramc.c
new file mode 100644
index 0000000000..a8b731f8f2
--- /dev/null
+++ b/hw/misc/allwinner-sramc.c
@@ -0,0 +1,184 @@
+/*
+ * Allwinner R40 SRAM controller emulation
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
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "hw/misc/allwinner-sramc.h"
+#include "trace.h"
+
+/*
+ * register offsets
+ * https://linux-sunxi.org/SRAM_Controller_Register_Guide
+ */
+enum {
+    REG_SRAM_CTL1_CFG               = 0x04, /* SRAM Control register 1 */
+    REG_SRAM_VER                    = 0x24, /* SRAM Version register */
+    REG_SRAM_R40_SOFT_ENTRY_REG0    = 0xbc,
+};
+
+/* REG_SRAMC_VERSION bit defines */
+#define SRAM_VER_READ_ENABLE            (1 << 15)
+#define SRAM_VER_VERSION_SHIFT          16
+#define SRAM_VERSION_SUN8I_R40          0x1701
+
+static uint64_t allwinner_sramc_read(void *opaque, hwaddr offset,
+                                     unsigned size)
+{
+    AwSRAMCState *s = AW_SRAMC(opaque);
+    AwSRAMCClass *sc = AW_SRAMC_GET_CLASS(s);
+    uint64_t val = 0;
+
+    switch (offset) {
+    case REG_SRAM_CTL1_CFG:
+        val = s->sram_ctl1;
+        break;
+    case REG_SRAM_VER:
+        /* bit15: lock bit, set this bit before reading this register */
+        if (s->sram_ver & SRAM_VER_READ_ENABLE) {
+            val = SRAM_VER_READ_ENABLE |
+                    (sc->sram_version_code << SRAM_VER_VERSION_SHIFT);
+        }
+        break;
+    case REG_SRAM_R40_SOFT_ENTRY_REG0:
+        val = s->sram_soft_entry_reg0;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    }
+
+    trace_allwinner_sramc_read(offset, val);
+
+    return val;
+}
+
+static void allwinner_sramc_write(void *opaque, hwaddr offset,
+                                  uint64_t val, unsigned size)
+{
+    AwSRAMCState *s = AW_SRAMC(opaque);
+
+    trace_allwinner_sramc_write(offset, val);
+
+    switch (offset) {
+    case REG_SRAM_CTL1_CFG:
+        s->sram_ctl1 = val;
+        break;
+    case REG_SRAM_VER:
+        /* Only the READ_ENABLE bit is writeable */
+        s->sram_ver = val & SRAM_VER_READ_ENABLE;
+        break;
+    case REG_SRAM_R40_SOFT_ENTRY_REG0:
+        s->sram_soft_entry_reg0 = val;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps allwinner_sramc_ops = {
+    .read = allwinner_sramc_read,
+    .write = allwinner_sramc_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 4,
+};
+
+static const VMStateDescription allwinner_sramc_vmstate = {
+    .name = "allwinner-sramc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(sram_ver, AwSRAMCState),
+        VMSTATE_UINT32(sram_soft_entry_reg0, AwSRAMCState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_sramc_reset(DeviceState *dev)
+{
+    AwSRAMCState *s = AW_SRAMC(dev);
+    AwSRAMCClass *sc = AW_SRAMC_GET_CLASS(s);
+
+    switch (sc->sram_version_code) {
+    case SRAM_VERSION_SUN8I_R40:
+        s->sram_ctl1 = 0x1300;
+        break;
+    }
+}
+
+static void allwinner_sramc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = allwinner_sramc_reset;
+    dc->vmsd = &allwinner_sramc_vmstate;
+}
+
+static void allwinner_sramc_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    AwSRAMCState *s = AW_SRAMC(obj);
+
+    /* Memory mapping */
+    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_sramc_ops, s,
+                           TYPE_AW_SRAMC, 1 * KiB);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const TypeInfo allwinner_sramc_info = {
+    .name          = TYPE_AW_SRAMC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_sramc_init,
+    .instance_size = sizeof(AwSRAMCState),
+    .class_init    = allwinner_sramc_class_init,
+};
+
+static void allwinner_r40_sramc_class_init(ObjectClass *klass, void *data)
+{
+    AwSRAMCClass *sc = AW_SRAMC_CLASS(klass);
+
+    sc->sram_version_code = SRAM_VERSION_SUN8I_R40;
+}
+
+static const TypeInfo allwinner_r40_sramc_info = {
+    .name          = TYPE_AW_SRAMC_SUN8I_R40,
+    .parent        = TYPE_AW_SRAMC,
+    .class_init    = allwinner_r40_sramc_class_init,
+};
+
+static void allwinner_sramc_register(void)
+{
+    type_register_static(&allwinner_sramc_info);
+    type_register_static(&allwinner_r40_sramc_info);
+}
+
+type_init(allwinner_sramc_register)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b04d43e05a..78ca857c9d 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -37,6 +37,7 @@ subdir('macio')
 
 softmmu_ss.add(when: 'CONFIG_IVSHMEM_DEVICE', if_true: files('ivshmem.c'))
 
+softmmu_ss.add(when: 'CONFIG_ALLWINNER_SRAMC', if_true: files('allwinner-sramc.c'))
 softmmu_ss.add(when: 'CONFIG_ALLWINNER_A10_CCM', if_true: files('allwinner-a10-ccm.c'))
 softmmu_ss.add(when: 'CONFIG_ALLWINNER_A10_DRAMC', if_true: files('allwinner-a10-dramc.c'))
 softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-ccu.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 8b68f07765..4d1a0e17af 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -33,6 +33,10 @@ allwinner_r40_dramphy_write(uint64_t offset, uint64_t data, unsigned size) "writ
 allwinner_sid_read(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
 allwinner_sid_write(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
 
+# allwinner-sramc.c
+allwinner_sramc_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
+allwinner_sramc_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
+
 # avr_power.c
 avr_power_read(uint8_t value) "power_reduc read value:%u"
 avr_power_write(uint8_t value) "power_reduc write value:%u"
diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index 5f2d08489e..72710d3edc 100644
--- a/include/hw/arm/allwinner-r40.h
+++ b/include/hw/arm/allwinner-r40.h
@@ -27,6 +27,7 @@
 #include "hw/sd/allwinner-sdhost.h"
 #include "hw/misc/allwinner-r40-ccu.h"
 #include "hw/misc/allwinner-r40-dramc.h"
+#include "hw/misc/allwinner-sramc.h"
 #include "hw/i2c/allwinner-i2c.h"
 #include "hw/net/allwinner_emac.h"
 #include "hw/net/allwinner-sun8i-emac.h"
@@ -38,6 +39,7 @@ enum {
     AW_R40_DEV_SRAM_A2,
     AW_R40_DEV_SRAM_A3,
     AW_R40_DEV_SRAM_A4,
+    AW_R40_DEV_SRAMC,
     AW_R40_DEV_EMAC,
     AW_R40_DEV_MMC0,
     AW_R40_DEV_MMC1,
@@ -102,6 +104,7 @@ struct AwR40State {
 
     ARMCPU cpus[AW_R40_NUM_CPUS];
     const hwaddr *memmap;
+    AwSRAMCState sramc;
     AwA10PITState timer;
     AwSdHostState mmc[AW_R40_NUM_MMCS];
     AwR40ClockCtlState ccu;
diff --git a/include/hw/misc/allwinner-sramc.h b/include/hw/misc/allwinner-sramc.h
new file mode 100644
index 0000000000..66b01b8d04
--- /dev/null
+++ b/include/hw/misc/allwinner-sramc.h
@@ -0,0 +1,69 @@
+/*
+ * Allwinner SRAM controller emulation
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
+#ifndef HW_MISC_ALLWINNER_SRAMC_H
+#define HW_MISC_ALLWINNER_SRAMC_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+#include "qemu/uuid.h"
+
+/**
+ * Object model
+ * @{
+ */
+#define TYPE_AW_SRAMC               "allwinner-sramc"
+#define TYPE_AW_SRAMC_SUN8I_R40     TYPE_AW_SRAMC "-sun8i-r40"
+OBJECT_DECLARE_TYPE(AwSRAMCState, AwSRAMCClass, AW_SRAMC)
+
+/** @} */
+
+/**
+ * Allwinner SRAMC object instance state
+ */
+struct AwSRAMCState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    /** Maps I/O registers in physical memory */
+    MemoryRegion iomem;
+
+    /* registers */
+    uint32_t sram_ctl1;
+    uint32_t sram_ver;
+    uint32_t sram_soft_entry_reg0;
+};
+
+/**
+ * Allwinner SRAM Controller class-level struct.
+ *
+ * This struct is filled by each sunxi device specific code
+ * such that the generic code can use this struct to support
+ * all devices.
+ */
+struct AwSRAMCClass {
+    /*< private >*/
+    SysBusDeviceClass parent_class;
+    /*< public >*/
+
+    uint32_t sram_version_code;
+};
+
+#endif /* HW_MISC_ALLWINNER_SRAMC_H */
-- 
2.25.1


