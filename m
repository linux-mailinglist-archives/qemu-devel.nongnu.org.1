Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22305744E63
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 17:50:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFzJr-0004MK-MK; Sun, 02 Jul 2023 11:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzJp-0004Kg-Tp
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:48:57 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzJn-0007Nr-PH
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NT5euwqYLhsbubwgXdt51juQd1CKloTJmrl1GOIkVMg=; b=S4ogDnP/9VTvWJLfJmo3HseQ9y
 hXCnETxTdUxp+yjUD1yNE6oKGNUMYj0D7BPn7fdMvi0QpzDKFuqJizVtL+aZsEHQi4mOzyOgDkC8h
 PZmQkgz/cjRkBIBdw7THZMucGXrHcIhjNMkpeRui0V1Mg+DfumZrG1EDzS3AswrYW2k8I1w20qr1N
 dTdHTJeFRdnW5fHCmaKKN7FG+iFIhzOsGWhWCdWK3dsKrdJtrmDMg2WBGwsLeUNDWUUOS99YGRJbt
 Jk6Nw+0ikdXV2gNPmwCC+ZEKeDLKH1ZOUoAkiD8FxTZcD1sauhstSqKoLYIzYDs0is8gWbJB39nNh
 F6Cr5geB69XubfVdjh2OFZAna6hwyrlW4qgj/ExqsyUxDFReN6m+k0SScT5BS0APTp/q+40BsZNbR
 nAT6gE0iOj9/eV7L5UriNpJNpGQyZfJxyMx8OA7KG2uJ/emoXO125aQfvENx+XaQTSBPGwe1pRDSJ
 arpWIWxhrcdSgzWqKFGDTzqbS8z3HVNN8RXtg6fUDT072o47SYXFsUT+PrtcTadaVJ5kpuW8GNzay
 aSySU3bq+lbpdeNFJps4pX0ouxMuHp6Zd6Ex+y6Tupp2DLdNzeLQknWpkqOKoOgIm6Uc32A+xTvn5
 0Nj4o4vSgoCyznckzOFqa8D2bzzfMNYEuTEUjtZJQ=;
Received: from [2a00:23c4:8bad:df00:f732:dd76:7417:d15b] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzJY-0001Ji-Fa; Sun, 02 Jul 2023 16:48:44 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  2 Jul 2023 16:48:19 +0100
Message-Id: <20230702154838.722809-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bad:df00:f732:dd76:7417:d15b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 02/21] q800: add djMEMC memory controller
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
 hw/m68k/q800.c           |  10 +++
 hw/misc/Kconfig          |   3 +
 hw/misc/djmemc.c         | 135 +++++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build      |   1 +
 hw/misc/trace-events     |   4 ++
 include/hw/m68k/q800.h   |   2 +
 include/hw/misc/djmemc.h |  30 +++++++++
 9 files changed, 188 insertions(+)
 create mode 100644 hw/misc/djmemc.c
 create mode 100644 include/hw/misc/djmemc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4feea49a6e..2d85e8c28c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1231,6 +1231,7 @@ F: hw/misc/mac_via.c
 F: hw/nubus/*
 F: hw/display/macfb.c
 F: hw/block/swim.c
+F: hw/misc/djmemc.c
 F: hw/m68k/bootinfo.h
 F: include/standard-headers/asm-m68k/bootinfo.h
 F: include/standard-headers/asm-m68k/bootinfo-mac.h
@@ -1240,6 +1241,7 @@ F: include/hw/display/macfb.h
 F: include/hw/block/swim.h
 F: include/hw/m68k/q800.h
 F: include/hw/m68k/q800-glue.h
+F: include/hw/misc/djmemc.h
 
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
index b770b71d54..f9ecc1fbb0 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -40,6 +40,7 @@
 #include "hw/m68k/q800.h"
 #include "hw/m68k/q800-glue.h"
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
@@ -257,6 +259,14 @@ static void q800_machine_init(MachineState *machine)
                              &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&m->glue), &error_fatal);
 
+    /* djMEMC memory controller */
+    object_initialize_child(OBJECT(machine), "djmemc", &m->djmemc,
+                            TYPE_DJMEMC);
+    sysbus = SYS_BUS_DEVICE(&m->djmemc);
+    sysbus_realize_and_unref(sysbus, &error_fatal);
+    memory_region_add_subregion(&m->macio, DJMEMC_BASE - IO_BASE,
+                                sysbus_mmio_get_region(sysbus, 0));
+
     /* VIA 1 */
     object_initialize_child(OBJECT(machine), "via1", &m->via1,
                             TYPE_MOS6522_Q800_VIA1);
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index e4c2149175..9576debc70 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -183,4 +183,7 @@ config AXP2XX_PMU
     bool
     depends on I2C
 
+config DJMEMC
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/djmemc.c b/hw/misc/djmemc.c
new file mode 100644
index 0000000000..fd02640838
--- /dev/null
+++ b/hw/misc/djmemc.c
@@ -0,0 +1,135 @@
+/*
+ * djMEMC, macintosh memory and interrupt controller
+ * (Quadra 610/650/800 & Centris 610/650)
+ *
+ *    https://mac68k.info/wiki/display/mac68k/djMEMC+Information
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
+    trace_djmemc_read(addr, val, size);
+    return val;
+}
+
+static void djmemc_write(void *opaque, hwaddr addr, uint64_t val,
+                         unsigned size)
+{
+    DJMEMCState *s = opaque;
+
+    trace_djmemc_write(addr, val, size);
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
+    dc->vmsd = &vmstate_djmemc;
+    rc->phases.hold = djmemc_reset_hold;
+}
+
+static const TypeInfo djmemc_info_types[] = {
+    {
+        .name          = TYPE_DJMEMC,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(DJMEMCState),
+        .instance_init = djmemc_init,
+        .class_init    = djmemc_class_init,
+    },
+};
+
+DEFINE_TYPES(djmemc_info_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 05877f61cc..c68f30e630 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -20,6 +20,7 @@ system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_ras.c'))
 
 # Mac devices
 system_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
+system_ss.add(when: 'CONFIG_DJMEMC', if_true: files('djmemc.c'))
 
 # virt devices
 system_ss.add(when: 'CONFIG_VIRT_CTRL', if_true: files('virt_ctrl.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 4d1a0e17af..341adbf24c 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -297,3 +297,7 @@ virt_ctrl_instance_init(void *dev) "ctrl: %p"
 lasi_chip_mem_valid(uint64_t addr, uint32_t val) "access to addr 0x%"PRIx64" is %d"
 lasi_chip_read(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
 lasi_chip_write(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
+
+# djmemc.c
+djmemc_read(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
+djmemc_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index b3d77f1cba..f6ae4c1c4f 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -36,6 +36,7 @@
 #include "hw/block/swim.h"
 #include "hw/nubus/mac-nubus-bridge.h"
 #include "hw/display/macfb.h"
+#include "hw/misc/djmemc.h"
 
 /*
  * The main Q800 machine
@@ -56,6 +57,7 @@ struct Q800MachineState {
     Swim swim;
     MacNubusBridge mac_nubus_bridge;
     MacfbNubusState macfb;
+    DJMEMCState djmemc;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
diff --git a/include/hw/misc/djmemc.h b/include/hw/misc/djmemc.h
new file mode 100644
index 0000000000..82d4e4a2fe
--- /dev/null
+++ b/include/hw/misc/djmemc.h
@@ -0,0 +1,30 @@
+/*
+ * djMEMC, macintosh memory and interrupt controller
+ * (Quadra 610/650/800 & Centris 610/650)
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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


