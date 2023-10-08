Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D177BCC96
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:25:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpNCp-00083p-QN; Sun, 08 Oct 2023 02:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCn-00082o-7Z
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:23:57 -0400
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCl-0007jv-1y
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:23:56 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M4aEC-1qpvR82X6U-001jQs; Sun, 08
 Oct 2023 08:23:52 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/20] q800: add djMEMC memory controller
Date: Sun,  8 Oct 2023 08:23:31 +0200
Message-ID: <20231008062349.2733552-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008062349.2733552-1-laurent@vivier.eu>
References: <20231008062349.2733552-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:V9XnxqbUOTs9WRHhz9b5KSERGBklgU8iuIw0a6DD3gs7/VCw46w
 g+ewzIANybcPqnaPQFCMkmOStaTHreLMIv0aQDBPYxAoLdIER7WvMU6xYoJ6KruTZV/IoEf
 D+daK01+obO3+c8BEA24XSPlMvjtVHS5y3xAd8JmiGphJhOtHVqOfq0xNXUQLj1ClkYxEQQ
 rfwSbfI/zg/EjX9y05f8g==
UI-OutboundReport: notjunk:1;M01:P0:aXKmiEmrYuM=;KHsaXgb9lOJBxo7eKWdtcn5SARd
 1meW/cFWZn47Dp63Qhp0rnX1fufmABgktKWxLEFRJyTumYeU4WjzMpxNtxGuB/RM9U52JayEf
 dJBnKnrJJ6imJC+AzmFM/WHaaN1uVEXozIsITgRUVmKoMorJP3MLijtNiLwZxPhFcPp2MnIps
 f/Yf9LEDkPVteKH2lbxMQcMY+oG1tNwQDJ2QlHp0tihFDkvM+7cBkI1MkPJGrscqA7gb7Bugu
 prtTCOId0bsXyOf5Wwrbb5ZhnnwWFfh/sjIgNQgNfDn28834/FimWk6OOfMlhzeXtYfHF19+j
 gPm9R+JFcPzz6S009EMUr815iKRxmCSG5bHTGBdkBXR2NGrGhYQRHM7WwjLBl6+aqcLGMRap5
 B4XWuN5wRRofzQ+auqa+vqYIpp7jow0idj+04wbrBgiIVptAdy+M0kttcDyYkjnREA1sTYiOl
 7B28JcEkNUQILGsMYJ7wvyQQPChBwDubX0xj2KNP0DFxe9jYVHIPAzYTaOJkeIC7rA+aJN/dq
 tfGtv+3eSys6Rr3uQZKah2FzV28Tu40thREiOv883BpUGAR8YBcc5x+L4pQSy82kLBxaXiU3b
 TDL97pNnubohMQP1/bQLW5shxt+T7ISSLU6gGHtGJpWhJxMc3cyUsy1s2erK3EK6CM1BuAicK
 JIoEdIBlcDp1ktLN/L0SWE/8fSkVMLn/rPVNEd84RP5DR7qF5bluyKlFJadSmtnQVMne6uMDt
 ZFEvCed58gBbc/wm8q9ajypieJ+pDK1WiMZXakCS+0Z/cwnukI71rWLmwhrgEsm+RJVY913n1
 /BRtgcd3zXabgbZ5imlZVsAQdY4cHYiOaAVmG9dR/Pcbgj/MYHcq0f2L537Jd9mngcTFT8TAC
 AZnDzxhJfCNXxTw==
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.376, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The djMEMC controller is used to store information related to the physical memory
configuration.

Co-developed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004083806.757242-3-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS              |   2 +
 include/hw/m68k/q800.h   |   2 +
 include/hw/misc/djmemc.h |  30 +++++++++
 hw/m68k/q800.c           |  10 +++
 hw/misc/djmemc.c         | 135 +++++++++++++++++++++++++++++++++++++++
 hw/m68k/Kconfig          |   1 +
 hw/misc/Kconfig          |   3 +
 hw/misc/meson.build      |   1 +
 hw/misc/trace-events     |   4 ++
 9 files changed, 188 insertions(+)
 create mode 100644 include/hw/misc/djmemc.h
 create mode 100644 hw/misc/djmemc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ea91f9e80481..dead0d4a47e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1229,6 +1229,7 @@ F: hw/misc/mac_via.c
 F: hw/nubus/*
 F: hw/display/macfb.c
 F: hw/block/swim.c
+F: hw/misc/djmemc.c
 F: hw/m68k/bootinfo.h
 F: include/standard-headers/asm-m68k/bootinfo.h
 F: include/standard-headers/asm-m68k/bootinfo-mac.h
@@ -1238,6 +1239,7 @@ F: include/hw/display/macfb.h
 F: include/hw/block/swim.h
 F: include/hw/m68k/q800.h
 F: include/hw/m68k/q800-glue.h
+F: include/hw/misc/djmemc.h
 
 virt
 M: Laurent Vivier <laurent@vivier.eu>
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index b3d77f1cba6e..f6ae4c1c4fd5 100644
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
index 000000000000..82d4e4a2fee2
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
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index b770b71d5475..f9ecc1fbb094 100644
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
diff --git a/hw/misc/djmemc.c b/hw/misc/djmemc.c
new file mode 100644
index 000000000000..fd02640838b8
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
diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
index f839f8a03064..330cfdfa2d6f 100644
--- a/hw/m68k/Kconfig
+++ b/hw/m68k/Kconfig
@@ -23,6 +23,7 @@ config Q800
     select ESP
     select DP8393X
     select OR_IRQ
+    select DJMEMC
 
 config M68K_VIRT
     bool
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 6996d265e4c5..cb7857e3ed9e 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -186,4 +186,7 @@ config AXP2XX_PMU
     bool
     depends on I2C
 
+config DJMEMC
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 88ecab839237..ee5ee376487c 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -20,6 +20,7 @@ system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_ras.c'))
 
 # Mac devices
 system_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
+system_ss.add(when: 'CONFIG_DJMEMC', if_true: files('djmemc.c'))
 
 # virt devices
 system_ss.add(when: 'CONFIG_VIRT_CTRL', if_true: files('virt_ctrl.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index bc87cd367070..c71a47d28880 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -301,3 +301,7 @@ virt_ctrl_instance_init(void *dev) "ctrl: %p"
 lasi_chip_mem_valid(uint64_t addr, uint32_t val) "access to addr 0x%"PRIx64" is %d"
 lasi_chip_read(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
 lasi_chip_write(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
+
+# djmemc.c
+djmemc_read(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
+djmemc_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
-- 
2.41.0


