Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 890B470FFB2
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:12:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vm2-0001mB-CE; Wed, 24 May 2023 17:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlz-0001fu-9u
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:11:56 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlw-00024H-Ld
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ybnhHBt7nAOxT+qTBxIJyjzbTLkpWAmJkwqDVnfZvOo=; b=LxklmB2cuYcplHSY/cneM0nh7v
 Y+PIHVH8bafHLXVpCLDgA0NMw6X8mvXQPWIA+rFc1niPDsy4nO5NEwXegnpA7D45CL/hQeUHoatAL
 NHX24gJVsBlwHKAmF96QmPFD0t3/shOzs6Cpg8s66+QGQp0lnOvpAKc0CYuxMUhLe1o1UScWcqa9g
 fsIeUbvcs2dfKeraAH1JMng3B2aldg97/jXaLkhiiaoh0jaqQBN9ItrLWYzEsrTZDCeLQTDWZ/5ND
 kH+iKJeUnILvlNb4Ucll5ySGnmW5xlZDtMvMhGy01Qf1OnpNCUhTn+kP1E8OcY4c7VvFH8+CXFhQ9
 5l/cyZKGexR1zxEsYvID+5z8jrU6s0mbA6vRCMVZR4ejFqAoHTdCc9v5fTwsfDAJArBKG3p2NDxG+
 /Aq5/qCaLDtYmNhtCact556Urs+8ybWcsfYIJhz6tGStGneIJ8i7EAOJUZoPxqZAwFTlF5FmiZpjI
 MGYn4IsYrfe/9O3nXRDFmaYzI/6tkMoknIHRHFyfGaA6X+Yzqn+VVc30hTNqwXSQGyjP1jUheHDFo
 /eDLxXOPinFXra4A/FsBBbs92RUWle6YzY5NX2zmrg80o0QFi63Ef79bqOeBWI9mvMStQ67uB23Qk
 keEn7akZ8tmghe+aCxJfaouCaYUkDwZ1H7A1qrCEk=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlo-0005XR-6x; Wed, 24 May 2023 22:11:48 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:10:43 +0100
Message-Id: <20230524211104.686087-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 09/30] q800: add djMEMC memory controller
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The djMEMC controller is used to store information related to the physical memory
configuration.

Co-developed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 MAINTAINERS              |   2 +
 hw/m68k/Kconfig          |   1 +
 hw/m68k/q800.c           |   9 +++
 hw/misc/Kconfig          |   3 +
 hw/misc/djmemc.c         | 154 +++++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build      |   1 +
 hw/misc/trace-events     |   4 +
 include/hw/m68k/q800.h   |   2 +
 include/hw/misc/djmemc.h |  46 ++++++++++++
 9 files changed, 222 insertions(+)
 create mode 100644 hw/misc/djmemc.c
 create mode 100644 include/hw/misc/djmemc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 86a1b88863..21ec70d00a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1227,6 +1227,7 @@ F: hw/misc/mac_via.c
 F: hw/nubus/*
 F: hw/display/macfb.c
 F: hw/block/swim.c
+F: hw/misc/djmemc.c
 F: hw/m68k/bootinfo.h
 F: include/standard-headers/asm-m68k/bootinfo.h
 F: include/standard-headers/asm-m68k/bootinfo-mac.h
@@ -1235,6 +1236,7 @@ F: include/hw/nubus/*
 F: include/hw/display/macfb.h
 F: include/hw/block/swim.h
 F: include/hw/m68k/q800.h
+F: include/hw/misc/djmemc.c
 
 virt
 M: Laurent Vivier <laurent@vivier.eu>
diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
index f839f8a030..330cfdfa2d 100644
--- a/hw/m68k/Kconfig
+++ b/hw/m68k/Kconfig
@@ -23,6 +23,7 @@ config Q800
     select ESP
     select DP8393X
     select OR_IRQ
+    select DJMEMC
 
 config M68K_VIRT
     bool
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index f15f1eaff9..456407898e 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -40,6 +40,7 @@
 #include "bootinfo.h"
 #include "hw/m68k/q800.h"
 #include "hw/misc/mac_via.h"
+#include "hw/misc/djmemc.h"
 #include "hw/input/adb.h"
 #include "hw/nubus/mac-nubus-bridge.h"
 #include "hw/display/macfb.h"
@@ -66,6 +67,7 @@
 #define SONIC_PROM_BASE       (IO_BASE + 0x08000)
 #define SONIC_BASE            (IO_BASE + 0x0a000)
 #define SCC_BASE              (IO_BASE + 0x0c020)
+#define DJMEMC_BASE           (IO_BASE + 0x0e000)
 #define ESP_BASE              (IO_BASE + 0x10000)
 #define ESP_PDMA              (IO_BASE + 0x10100)
 #define ASC_BASE              (IO_BASE + 0x14000)
@@ -492,6 +494,13 @@ static void q800_machine_init(MachineState *machine)
                              &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(m->glue), &error_fatal);
 
+    /* djMEMC memory controller */
+    m->djmemc = qdev_new(TYPE_DJMEMC);
+    sysbus = SYS_BUS_DEVICE(m->djmemc);
+    sysbus_realize_and_unref(sysbus, &error_fatal);
+    memory_region_add_subregion(&m->macio, DJMEMC_BASE - IO_BASE,
+                                sysbus_mmio_get_region(sysbus, 0));
+
     /* VIA 1 */
     via1_dev = qdev_new(TYPE_MOS6522_Q800_VIA1);
     dinfo = drive_get(IF_MTD, 0, 0);
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 2ef5781ef8..7eaf955f88 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -180,4 +180,7 @@ config AXP209_PMU
     bool
     depends on I2C
 
+config DJMEMC
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/djmemc.c b/hw/misc/djmemc.c
new file mode 100644
index 0000000000..597e0d446c
--- /dev/null
+++ b/hw/misc/djmemc.c
@@ -0,0 +1,154 @@
+/*
+ * djMEMC, macintosh memory and interrupt controller
+ * (Quadra 610/650/800 & Centris 610/650)
+ *
+ *    https://mac68k.info/wiki/display/mac68k/djMEMC+Information
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "migration/vmstate.h"
+#include "hw/misc/djmemc.h"
+#include "hw/qdev-properties.h"
+#include "trace.h"
+
+
+#define DJMEMC_INTERLEAVECONF   0x0
+#define DJMEMC_BANK0CONF        0x4
+#define DJMEMC_BANK1CONF        0x8
+#define DJMEMC_BANK2CONF        0xc
+#define DJMEMC_BANK3CONF        0x10
+#define DJMEMC_BANK4CONF        0x14
+#define DJMEMC_BANK5CONF        0x18
+#define DJMEMC_BANK6CONF        0x1c
+#define DJMEMC_BANK7CONF        0x20
+#define DJMEMC_BANK8CONF        0x24
+#define DJMEMC_BANK9CONF        0x28
+#define DJMEMC_MEMTOP           0x2c
+#define DJMEMC_CONFIG           0x30
+#define DJMEMC_REFRESH          0x34
+
+
+static uint64_t djmemc_read(void *opaque, hwaddr addr, unsigned size)
+{
+    DJMEMCState *s = opaque;
+    uint64_t val = 0;
+
+    switch (addr) {
+    case DJMEMC_INTERLEAVECONF:
+    case DJMEMC_BANK0CONF ... DJMEMC_BANK9CONF:
+    case DJMEMC_MEMTOP:
+    case DJMEMC_CONFIG:
+    case DJMEMC_REFRESH:
+        val = s->regs[addr >> 2];
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "djMEMC: unimplemented read addr=0x%"PRIx64
+                                 " val=0x%"PRIx64 " size=%d\n",
+                                 addr, val, size);
+    }
+
+    trace_djmemc_read(addr, size, val);
+    return val;
+}
+
+static void djmemc_write(void *opaque, hwaddr addr, uint64_t val,
+                         unsigned size)
+{
+    DJMEMCState *s = opaque;
+
+    trace_djmemc_write(addr, size, val);
+
+    switch (addr) {
+    case DJMEMC_INTERLEAVECONF:
+    case DJMEMC_BANK0CONF ... DJMEMC_BANK9CONF:
+    case DJMEMC_MEMTOP:
+    case DJMEMC_CONFIG:
+    case DJMEMC_REFRESH:
+        s->regs[addr >> 2] = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "djMEMC: unimplemented write addr=0x%"PRIx64
+                                 " val=0x%"PRIx64 " size=%d\n",
+                                 addr, val, size);
+    }
+}
+
+static const MemoryRegionOps djmemc_mmio_ops = {
+    .read = djmemc_read,
+    .write = djmemc_write,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void djmemc_init(Object *obj)
+{
+    DJMEMCState *s = DJMEMC(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->mem_regs, obj, &djmemc_mmio_ops, s, "djMEMC",
+                          DJMEMC_SIZE);
+    sysbus_init_mmio(sbd, &s->mem_regs);
+}
+
+static void djmemc_reset_hold(Object *obj)
+{
+    DJMEMCState *s = DJMEMC(obj);
+
+    memset(s->regs, 0, sizeof(s->regs));
+}
+
+static const VMStateDescription vmstate_djmemc = {
+    .name = "djMEMC",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, DJMEMCState, DJMEMC_NUM_REGS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void djmemc_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+
+    rc->phases.hold = djmemc_reset_hold;
+    dc->vmsd = &vmstate_djmemc;
+}
+
+static const TypeInfo djmemc_info = {
+    .name          = TYPE_DJMEMC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(DJMEMCState),
+    .instance_init = djmemc_init,
+    .class_init    = djmemc_class_init,
+};
+
+static void djmemc_register_types(void)
+{
+    type_register_static(&djmemc_info);
+}
+
+type_init(djmemc_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index a40245ad44..a2b5ca6fbc 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -20,6 +20,7 @@ softmmu_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_ras.c'))
 
 # Mac devices
 softmmu_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
+softmmu_ss.add(when: 'CONFIG_DJMEMC', if_true: files('djmemc.c'))
 
 # virt devices
 softmmu_ss.add(when: 'CONFIG_VIRT_CTRL', if_true: files('virt_ctrl.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index c47876a902..bed14bd559 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -279,3 +279,7 @@ virt_ctrl_instance_init(void *dev) "ctrl: %p"
 lasi_chip_mem_valid(uint64_t addr, uint32_t val) "access to addr 0x%"PRIx64" is %d"
 lasi_chip_read(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
 lasi_chip_write(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
+
+# djmemc.c
+djmemc_read(int reg, unsigned size, uint64_t value) "reg=0x%x size=%u value=0x%"PRIx64
+djmemc_write(int reg, unsigned size, uint64_t value) "reg=0x%x size=%u value=0x%"PRIx64
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 8d788a7072..d0e37cc665 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -33,6 +33,8 @@ struct Q800MachineState {
     M68kCPU *cpu;
     MemoryRegion rom;
     DeviceState *glue;
+    DeviceState *djmemc;
+
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
diff --git a/include/hw/misc/djmemc.h b/include/hw/misc/djmemc.h
new file mode 100644
index 0000000000..77776b0736
--- /dev/null
+++ b/include/hw/misc/djmemc.h
@@ -0,0 +1,46 @@
+/*
+ * djMEMC, macintosh memory and interrupt controller
+ * (Quadra 610/650/800 & Centris 610/650)
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_MISC_DJMEMC_H
+#define HW_MISC_DJMEMC_H
+
+#include "hw/sysbus.h"
+
+#define DJMEMC_SIZE        0x2000
+#define DJMEMC_NUM_REGS    (0x38 / sizeof(uint32_t))
+
+#define DJMEMC_MAXBANKS    10
+
+struct DJMEMCState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mem_regs;
+
+    /* Memory controller */
+    uint32_t regs[DJMEMC_NUM_REGS];
+};
+
+#define TYPE_DJMEMC "djMEMC"
+OBJECT_DECLARE_SIMPLE_TYPE(DJMEMCState, DJMEMC);
+
+#endif
-- 
2.30.2


