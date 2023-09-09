Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C581379972F
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 11:51:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeuaL-0005hx-JQ; Sat, 09 Sep 2023 05:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuaJ-0005hW-Gw
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:48:59 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuaG-0005Gs-TQ
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F/HSNB/ziKxJ40/KIQw5cj88nQ/Ew5ju7hfQLf/eAIs=; b=dGL7suUNu7byYFrmgYEhlvmXYk
 PkK8DSZ9L83cXRNkLU03YvjgzNKqe3jEm/JA/wt8x/EEEScH+to4C7ziTT1SeWqpVBvkwSikwnRpk
 2hesAfAxE0g+Lg3UV0cOg6neHHX37DNYFyoslL2eRUx8w1ue/MzVfWlM/OCHnB5OGX1oTPtlYp/Hv
 J5H6Dceb9rwKycYscS7sSCpNpSL4spmyDT+S+IKQFggX5OhCtqXKj7jFufKQdYOE8/jf4rXPedZR6
 BpkhWTe23yOTloEwcXcKquRd4xUgZx4htm23TH+7loeoEbmuiNZR1bGHg8EEQsYhEfXtRctk1SNlb
 9pz+lRSs/V0lBMrl785zkjKmpGgbO16i+5/c55tgc+zD3LQ9+70gy8d0HMLubB3ng5GvAgrbntu3A
 01wlKzkHHsVm1WTclYo2a/tHxvg+mLlXPftoqncF6/a1wjIRJP4RezQRtMllbKiKMdPqwtz9gwvYi
 re12eBCP/YsuHgxNh6Vn905wv1dKffod+yznmNOjb4nNrNInMoZKwLdmHLW5CR3VCozTIzc8R+F6a
 0ls7CTyyWhsPLLGj95sxMEKvtb7Ge1JMCVIwkNiCqlb7hP1GTklLfPbtkwMsnj4+WhJdF6xY7js4r
 0DTT8qJ7BX2c3awV8Se6JnQi+Rnm8+TjVyDEFBWG4=;
Received: from [2a00:23c4:8baf:5f00:e007:7058:31bc:5be9]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuaA-0000uO-LG; Sat, 09 Sep 2023 10:48:54 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sat,  9 Sep 2023 10:48:12 +0100
Message-Id: <20230909094827.33871-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:e007:7058:31bc:5be9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 05/20] q800: add IOSB subsystem
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

It is needed because it defines the BIOSConfig area.

Co-developed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 MAINTAINERS            |   2 +
 hw/m68k/Kconfig        |   1 +
 hw/m68k/q800.c         |   9 +++
 hw/misc/Kconfig        |   3 +
 hw/misc/iosb.c         | 133 +++++++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build    |   1 +
 hw/misc/trace-events   |   4 ++
 include/hw/m68k/q800.h |   2 +
 include/hw/misc/iosb.h |  25 ++++++++
 9 files changed, 180 insertions(+)
 create mode 100644 hw/misc/iosb.c
 create mode 100644 include/hw/misc/iosb.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3ed6d42d77..e02c0073af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1222,6 +1222,7 @@ F: hw/nubus/*
 F: hw/display/macfb.c
 F: hw/block/swim.c
 F: hw/misc/djmemc.c
+F: hw/misc/iosb.c
 F: hw/m68k/bootinfo.h
 F: include/standard-headers/asm-m68k/bootinfo.h
 F: include/standard-headers/asm-m68k/bootinfo-mac.h
@@ -1232,6 +1233,7 @@ F: include/hw/block/swim.h
 F: include/hw/m68k/q800.h
 F: include/hw/m68k/q800-glue.h
 F: include/hw/misc/djmemc.h
+F: include/hw/misc/iosb.h
 
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
index ac8509ba6f..081b95e9cf 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -41,6 +41,7 @@
 #include "hw/m68k/q800-glue.h"
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
@@ -296,6 +298,13 @@ static void q800_machine_init(MachineState *machine)
     memory_region_add_subregion(&m->macio, DJMEMC_BASE - IO_BASE,
                                 sysbus_mmio_get_region(sysbus, 0));
 
+    /* IOSB subsystem */
+    object_initialize_child(OBJECT(machine), "iosb", &m->iosb, TYPE_IOSB);
+    sysbus = SYS_BUS_DEVICE(&m->iosb);
+    sysbus_realize_and_unref(sysbus, &error_fatal);
+    memory_region_add_subregion(&m->macio, IOSB_BASE - IO_BASE,
+                                sysbus_mmio_get_region(sysbus, 0));
+
     /* VIA 1 */
     object_initialize_child(OBJECT(machine), "via1", &m->via1,
                             TYPE_MOS6522_Q800_VIA1);
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index cb7857e3ed..858277bb60 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -189,4 +189,7 @@ config AXP2XX_PMU
 config DJMEMC
     bool
 
+config IOSB
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/iosb.c b/hw/misc/iosb.c
new file mode 100644
index 0000000000..e7e9dcca47
--- /dev/null
+++ b/hw/misc/iosb.c
@@ -0,0 +1,133 @@
+/*
+ * QEMU IOSB emulation
+ *
+ * Copyright (c) 2019 Laurent Vivier
+ * Copyright (c) 2022 Mark Cave-Ayland
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
+    trace_iosb_read(addr, val, size);
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
+    trace_iosb_write(addr, val, size);
+}
+
+static const MemoryRegionOps iosb_mmio_ops = {
+    .read = iosb_read,
+    .write = iosb_write,
+    .endianness = DEVICE_BIG_ENDIAN,
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
+    dc->vmsd = &vmstate_iosb;
+    rc->phases.hold = iosb_reset_hold;
+}
+
+static const TypeInfo iosb_info_types[] = {
+    {
+        .name          = TYPE_IOSB,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(IOSBState),
+        .instance_init = iosb_init,
+        .class_init    = iosb_class_init,
+    },
+};
+
+DEFINE_TYPES(iosb_info_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 86f23f267f..ea7e1beace 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -21,6 +21,7 @@ system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_ras.c'))
 # Mac devices
 system_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
 system_ss.add(when: 'CONFIG_DJMEMC', if_true: files('djmemc.c'))
+system_ss.add(when: 'CONFIG_IOSB', if_true: files('iosb.c'))
 
 # virt devices
 system_ss.add(when: 'CONFIG_VIRT_CTRL', if_true: files('virt_ctrl.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index be383fe956..c9bdb0d30e 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -305,3 +305,7 @@ lasi_chip_write(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
 # djmemc.c
 djmemc_read(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
 djmemc_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
+
+# iosb.c
+iosb_read(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
+iosb_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index dd7d7a6f2c..98097165d9 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -37,6 +37,7 @@
 #include "hw/nubus/mac-nubus-bridge.h"
 #include "hw/display/macfb.h"
 #include "hw/misc/djmemc.h"
+#include "hw/misc/iosb.h"
 
 /*
  * The main Q800 machine
@@ -58,6 +59,7 @@ struct Q800MachineState {
     MacNubusBridge mac_nubus_bridge;
     MacfbNubusState macfb;
     DJMEMCState djmemc;
+    IOSBState iosb;
     MemoryRegion macio;
     MemoryRegion macio_alias;
     MemoryRegion machine_id;
diff --git a/include/hw/misc/iosb.h b/include/hw/misc/iosb.h
new file mode 100644
index 0000000000..377f8ca7e2
--- /dev/null
+++ b/include/hw/misc/iosb.h
@@ -0,0 +1,25 @@
+/*
+ * QEMU IOSB emulation
+ *
+ * Copyright (c) 2019 Laurent Vivier
+ * Copyright (c) 2022 Mark Cave-Ayland
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
2.39.2


