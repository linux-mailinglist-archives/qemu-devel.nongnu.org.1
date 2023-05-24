Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E59070FFDE
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:15:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vmI-0002gO-Fk; Wed, 24 May 2023 17:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmB-0002Sd-5v
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:12:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vm9-00026I-0b
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=62FC76QptiCbwxg2J+eqp9rZfvowmFqf4yMKVoifQjw=; b=Nlhao42SfotoM2R+giURil+2nj
 k7A6oK+2TprXzSIxwz6DIK7jMCEBaXeVBBFtC2en4E9UItLQNrWHYTplgPxYsUBPuCBjXyiikDSAB
 QDzjR1G5cydySgLxsGwgLMnG3LYUOuyThgzmtiARhnDEvV2D8V7PrBzZXY25xrJcbE4dT7CYUuW/H
 JCOaSPtdAFMyy51t74k3hfPdDAhfaWIzq2XiGn70hOy6s4Qhbik5wV0D33r7bwKhZIh2TVtZp7hzr
 F5KjxM+1JeAirYi2AHP8Hh1pVSoRRHUzsN4P+gySRznTTIsrmdZ3VACKb+7XcgMk24PxGya2EUUQs
 jtE+otqrLtLMM9lxmporPtSf39saWxR+vfMCiPRw6Rz3Jfpf1pMoXpVXt3qvdRoDiZ2ss58EaOh27
 iHN1wjnOUfDCXZ1kr5uGSMTQ4XVTMINIvaglIDrTVduy/BWxjZwnSRJP2o+5ppnX7QLeUc+/RKann
 UX3kARM/r7NZPa/uWgji4iHMIjOurjY9o6FiBabWQv0u0ijtNExKhGEGQkyZMWcBlVR5cuQYvQDVE
 lBDhEXCysny8WmSsMVB0Vkcx7HLh6oEDYPS1adl0pEa4/Zel5qR9eqlRKecSgI8ehtY6anzxJvWdx
 AiqF1YOe5Fy907bUSHMR6znEZLsFPdgEyP7I9kZoM=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vm0-0005XR-AQ; Wed, 24 May 2023 22:12:00 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:10:46 +0100
Message-Id: <20230524211104.686087-13-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 12/30] q800: add IOSB subsystem
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

It is needed because it defines the BIOSConfig area.

Co-developed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 MAINTAINERS            |   2 +
 hw/m68k/Kconfig        |   1 +
 hw/m68k/q800.c         |  10 +++
 hw/misc/Kconfig        |   3 +
 hw/misc/iosb.c         | 156 +++++++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build    |   1 +
 hw/misc/trace-events   |   4 ++
 include/hw/misc/iosb.h |  41 +++++++++++
 8 files changed, 218 insertions(+)
 create mode 100644 hw/misc/iosb.c
 create mode 100644 include/hw/misc/iosb.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 21ec70d00a..f151aaf99f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1228,6 +1228,7 @@ F: hw/nubus/*
 F: hw/display/macfb.c
 F: hw/block/swim.c
 F: hw/misc/djmemc.c
+F: hw/misc/iosb.c
 F: hw/m68k/bootinfo.h
 F: include/standard-headers/asm-m68k/bootinfo.h
 F: include/standard-headers/asm-m68k/bootinfo-mac.h
@@ -1237,6 +1238,7 @@ F: include/hw/display/macfb.h
 F: include/hw/block/swim.h
 F: include/hw/m68k/q800.h
 F: include/hw/misc/djmemc.c
+F: include/hw/misc/iosb.c
 
 virt
 M: Laurent Vivier <laurent@vivier.eu>
diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
index 330cfdfa2d..64fa70a0db 100644
--- a/hw/m68k/Kconfig
+++ b/hw/m68k/Kconfig
@@ -24,6 +24,7 @@ config Q800
     select DP8393X
     select OR_IRQ
     select DJMEMC
+    select IOSB
 
 config M68K_VIRT
     bool
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index c1d4b98cc0..8310670ec2 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -41,6 +41,7 @@
 #include "hw/m68k/q800.h"
 #include "hw/misc/mac_via.h"
 #include "hw/misc/djmemc.h"
+#include "hw/misc/iosb.h"
 #include "hw/input/adb.h"
 #include "hw/nubus/mac-nubus-bridge.h"
 #include "hw/display/macfb.h"
@@ -71,6 +72,7 @@
 #define ESP_BASE              (IO_BASE + 0x10000)
 #define ESP_PDMA              (IO_BASE + 0x10100)
 #define ASC_BASE              (IO_BASE + 0x14000)
+#define IOSB_BASE             (IO_BASE + 0x18000)
 #define SWIM_BASE             (IO_BASE + 0x1E000)
 
 #define SONIC_PROM_SIZE       0x1000
@@ -530,6 +532,14 @@ static void q800_machine_init(MachineState *machine)
     memory_region_add_subregion(&m->macio, DJMEMC_BASE - IO_BASE,
                                 sysbus_mmio_get_region(sysbus, 0));
 
+    /* IOSB subsystem */
+
+    dev = qdev_new(TYPE_IOSB);
+    sysbus = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sysbus, &error_fatal);
+    memory_region_add_subregion(&m->macio, IOSB_BASE - IO_BASE,
+                                sysbus_mmio_get_region(sysbus, 0));
+
     /* VIA 1 */
     via1_dev = qdev_new(TYPE_MOS6522_Q800_VIA1);
     dinfo = drive_get(IF_MTD, 0, 0);
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 7eaf955f88..c6c38102b1 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -183,4 +183,7 @@ config AXP209_PMU
 config DJMEMC
     bool
 
+config IOSB
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/iosb.c b/hw/misc/iosb.c
new file mode 100644
index 0000000000..f4f9b22d89
--- /dev/null
+++ b/hw/misc/iosb.c
@@ -0,0 +1,156 @@
+/*
+ * QEMU IOSB emulation
+ *
+ * Copyright (c) 2019 Laurent Vivier
+ * Copyright (c) 2022 Mark Cave-Ayland
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
+#include "hw/sysbus.h"
+#include "hw/misc/iosb.h"
+#include "trace.h"
+
+#define IOSB_SIZE          0x2000
+
+#define IOSB_CONFIG        0x0
+#define IOSB_CONFIG2       0x100
+#define IOSB_SONIC_SCSI    0x200
+#define IOSB_REVISION      0x300
+#define IOSB_SCSI_RESID    0x400
+#define IOSB_BRIGHTNESS    0x500
+#define IOSB_TIMEOUT       0x600
+
+
+static uint64_t iosb_read(void *opaque, hwaddr addr,
+                          unsigned size)
+{
+    IOSBState *s = IOSB(opaque);
+    uint64_t val = 0;
+
+    switch (addr) {
+    case IOSB_CONFIG:
+    case IOSB_CONFIG2:
+    case IOSB_SONIC_SCSI:
+    case IOSB_REVISION:
+    case IOSB_SCSI_RESID:
+    case IOSB_BRIGHTNESS:
+    case IOSB_TIMEOUT:
+        val = s->regs[addr >> 8];
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "IOSB: unimplemented read addr=0x%"PRIx64
+                                 " val=0x%"PRIx64 " size=%d\n",
+                                 addr, val, size);
+    }
+
+    trace_iosb_read(addr, size, val);
+    return val;
+}
+
+static void iosb_write(void *opaque, hwaddr addr, uint64_t val,
+                       unsigned size)
+{
+    IOSBState *s = IOSB(opaque);
+
+    switch (addr) {
+    case IOSB_CONFIG:
+    case IOSB_CONFIG2:
+    case IOSB_SONIC_SCSI:
+    case IOSB_REVISION:
+    case IOSB_SCSI_RESID:
+    case IOSB_BRIGHTNESS:
+    case IOSB_TIMEOUT:
+        s->regs[addr >> 8] = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "IOSB: unimplemented write addr=0x%"PRIx64
+                                 " val=0x%"PRIx64 " size=%d\n",
+                                 addr, val, size);
+    }
+
+    trace_iosb_write(addr, size, val);
+}
+
+static const MemoryRegionOps iosb_mmio_ops = {
+    .read = iosb_read,
+    .write = iosb_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void iosb_reset_hold(Object *obj)
+{
+    IOSBState *s = IOSB(obj);
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    /* BCLK 33 MHz */
+    s->regs[IOSB_CONFIG >> 8] = 1;
+}
+
+static void iosb_init(Object *obj)
+{
+    IOSBState *s = IOSB(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->mem_regs, obj, &iosb_mmio_ops, s, "IOSB",
+                          IOSB_SIZE);
+    sysbus_init_mmio(sbd, &s->mem_regs);
+}
+
+static const VMStateDescription vmstate_iosb = {
+    .name = "IOSB",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, IOSBState, IOSB_REGS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void iosb_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+
+    rc->phases.hold = iosb_reset_hold;
+    dc->vmsd = &vmstate_iosb;
+}
+
+static const TypeInfo iosb_info = {
+    .name          = TYPE_IOSB,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IOSBState),
+    .instance_init = iosb_init,
+    .class_init    = iosb_class_init,
+};
+
+static void iosb_register_types(void)
+{
+    type_register_static(&iosb_info);
+}
+
+type_init(iosb_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index a2b5ca6fbc..fee56a2a9e 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -21,6 +21,7 @@ softmmu_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_ras.c'))
 # Mac devices
 softmmu_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
 softmmu_ss.add(when: 'CONFIG_DJMEMC', if_true: files('djmemc.c'))
+softmmu_ss.add(when: 'CONFIG_IOSB', if_true: files('iosb.c'))
 
 # virt devices
 softmmu_ss.add(when: 'CONFIG_VIRT_CTRL', if_true: files('virt_ctrl.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index bed14bd559..85d2601de9 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -283,3 +283,7 @@ lasi_chip_write(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
 # djmemc.c
 djmemc_read(int reg, unsigned size, uint64_t value) "reg=0x%x size=%u value=0x%"PRIx64
 djmemc_write(int reg, unsigned size, uint64_t value) "reg=0x%x size=%u value=0x%"PRIx64
+
+# iosb.c
+iosb_read(int reg, unsigned size, uint64_t value) "reg=%d size=%u value=0x%"PRIx64
+iosb_write(int reg, unsigned size, uint64_t value) "reg=%d size=%u value=0x%"PRIx64
diff --git a/include/hw/misc/iosb.h b/include/hw/misc/iosb.h
new file mode 100644
index 0000000000..09d9f3a32b
--- /dev/null
+++ b/include/hw/misc/iosb.h
@@ -0,0 +1,41 @@
+/*
+ * QEMU IOSB emulation
+ *
+ * Copyright (c) 2019 Laurent Vivier
+ * Copyright (c) 2022 Mark Cave-Ayland
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
+#ifndef HW_MEM_IOSB_H
+#define HW_MEM_IOSB_H
+
+#define IOSB_REGS 7
+
+struct IOSBState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mem_regs;
+    uint32_t regs[IOSB_REGS];
+};
+
+#define TYPE_IOSB "IOSB"
+OBJECT_DECLARE_SIMPLE_TYPE(IOSBState, IOSB);
+
+#endif
-- 
2.30.2


