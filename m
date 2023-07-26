Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D37CC763BA9
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:54:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOghZ-0006BH-O1; Wed, 26 Jul 2023 11:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1qOgfr-00043R-7K; Wed, 26 Jul 2023 11:43:40 -0400
Received: from relay3-d.mail.gandi.net ([2001:4b98:dc4:8::223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1qOgfo-0006Ir-UC; Wed, 26 Jul 2023 11:43:38 -0400
Received: by mail.gandi.net (Postfix) with ESMTPA id D21076000B;
 Wed, 26 Jul 2023 15:43:33 +0000 (UTC)
From: Jean-Christophe Dubois <jcd@tribudubois.net>
To: qemu-arm@nongnu.org
Cc: jcdubois <jcd@tribudubois.net>,
	qemu-devel@nongnu.org
Subject: [PATCH 3/3] Add i.MX7 SRC device implementation
Date: Wed, 26 Jul 2023 17:43:08 +0200
Message-Id: <d620c9fcf72507db73a3f31df9065bd417f72704.1690385928.git.jcd@tribudubois.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690385928.git.jcd@tribudubois.net>
References: <cover.1690385928.git.jcd@tribudubois.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jcd@tribudubois.net
Received-SPF: pass client-ip=2001:4b98:dc4:8::223;
 envelope-from=jcd@tribudubois.net; helo=relay3-d.mail.gandi.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: jcdubois <jcd@tribudubois.net>

The SRC device is normaly used to start the secondary CPU.

When running Linux directly, Qemu is emulating a PSCI interface that UBOOT
is installing at boot time and therefore the fact that the SRC device is
unimplemented is hidden as Qemu respond directly to PSCI requets without
using the SRC device.

But if you try to run a more bare metal application (maybe uboot itself),
then it is not possible to start the secondary CPU as the SRC is an
unimplemented device.

This patch adds the ability to start the secondary CPU through the SRC
device so that you can use this feature in bare metal application.

Signed-off-by: jcdubois <jcd@tribudubois.net>
---
 hw/arm/fsl-imx7.c          |   9 +-
 hw/misc/imx7_src.c         | 289 +++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build        |   1 +
 include/hw/arm/fsl-imx7.h  |   2 +
 include/hw/misc/imx7_src.h |  68 +++++++++
 5 files changed, 368 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/imx7_src.c
 create mode 100644 include/hw/misc/imx7_src.h

diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 05cdd4831e..db103069e1 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -82,6 +82,11 @@ static void fsl_imx7_init(Object *obj)
      */
     object_initialize_child(obj, "gpcv2", &s->gpcv2, TYPE_IMX_GPCV2);
 
+    /*
+     * SRC
+     */
+    object_initialize_child(obj, "src", &s->src, TYPE_IMX7_SRC);
+
     /*
      * ECSPIs
      */
@@ -90,6 +95,7 @@ static void fsl_imx7_init(Object *obj)
         object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
     }
 
+
     /*
      * I2Cs
      */
@@ -490,7 +496,8 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     /*
      * SRC
      */
-    create_unimplemented_device("src", FSL_IMX7_SRC_ADDR, FSL_IMX7_SRC_SIZE);
+    sysbus_realize(SYS_BUS_DEVICE(&s->src), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->src), 0, FSL_IMX7_SRC_ADDR);
 
     /*
      * Watchdogs
diff --git a/hw/misc/imx7_src.c b/hw/misc/imx7_src.c
new file mode 100644
index 0000000000..b1b7d11e8f
--- /dev/null
+++ b/hw/misc/imx7_src.c
@@ -0,0 +1,289 @@
+/*
+ * IMX7 System Reset Controller
+ *
+ * Copyright (c) 2023 Jean-Christophe Dubois <jcd@tribudubois.net>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/imx7_src.h"
+#include "migration/vmstate.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/main-loop.h"
+#include "qemu/module.h"
+#include "target/arm/arm-powerctl.h"
+#include "hw/core/cpu.h"
+
+#define DEBUG_IMX7_SRC 1
+#ifndef DEBUG_IMX7_SRC
+#define DEBUG_IMX7_SRC 0
+#endif
+
+#define DPRINTF(fmt, args...) \
+    do { \
+        if (DEBUG_IMX7_SRC) { \
+            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX7_SRC, \
+                                             __func__, ##args); \
+        } \
+    } while (0)
+
+static const char *imx7_src_reg_name(uint32_t reg)
+{
+    static char unknown[20];
+
+    switch (reg) {
+    case SRC_SCR:
+        return "SRC_SCR";
+    case SRC_A7RCR0:
+        return "SRC_A7RCR0";
+    case SRC_A7RCR1:
+        return "SRC_A7RCR1";
+    case SRC_M4RCR:
+        return "SRC_M4RCR";
+    case SRC_ERCR:
+        return "SRC_ERCR";
+    case SRC_HSICPHY_RCR:
+        return "SRC_HSICPHY_RCR";
+    case SRC_USBOPHY1_RCR:
+        return "SRC_USBOPHY1_RCR";
+    case SRC_USBOPHY2_RCR:
+        return "SRC_USBOPHY2_RCR";
+    case SRC_PCIEPHY_RCR:
+        return "SRC_PCIEPHY_RCR";
+    case SRC_SBMR1:
+        return "SRC_SBMR1";
+    case SRC_SRSR:
+        return "SRC_SRSR";
+    case SRC_SISR:
+        return "SRC_SISR";
+    case SRC_SIMR:
+        return "SRC_SIMR";
+    case SRC_SBMR2:
+        return "SRC_SBMR2";
+    case SRC_GPR1:
+        return "SRC_GPR1";
+    case SRC_GPR2:
+        return "SRC_GPR2";
+    case SRC_GPR3:
+        return "SRC_GPR3";
+    case SRC_GPR4:
+        return "SRC_GPR4";
+    case SRC_GPR5:
+        return "SRC_GPR5";
+    case SRC_GPR6:
+        return "SRC_GPR6";
+    case SRC_GPR7:
+        return "SRC_GPR7";
+    case SRC_GPR8:
+        return "SRC_GPR8";
+    case SRC_GPR9:
+        return "SRC_GPR9";
+    case SRC_GPR10:
+        return "SRC_GPR10";
+    default:
+        sprintf(unknown, "%u ?", reg);
+        return unknown;
+    }
+}
+
+static const VMStateDescription vmstate_imx7_src = {
+    .name = TYPE_IMX7_SRC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, IMX7SRCState, SRC_MAX),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx7_src_reset(DeviceState *dev)
+{
+    IMX7SRCState *s = IMX7_SRC(dev);
+
+    DPRINTF("\n");
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    /* Set reset values */
+    s->regs[SRC_SCR] = 0xA0;
+    s->regs[SRC_SRSR] = 0x1;
+    s->regs[SRC_SIMR] = 0x1F;
+}
+
+static uint64_t imx7_src_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint32_t value = 0;
+    IMX7SRCState *s = (IMX7SRCState *)opaque;
+    uint32_t index = offset >> 2;
+
+    if (index < SRC_MAX) {
+        value = s->regs[index];
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0x%"
+                      HWADDR_PRIx "\n", TYPE_IMX7_SRC, __func__, offset);
+    }
+
+    DPRINTF("reg[%s] => 0x%" PRIx32 "\n", imx7_src_reg_name(index), value);
+
+    return value;
+}
+
+
+/*
+ * The reset is asynchronous so we need to defer clearing the reset
+ * bit until the work is completed.
+ */
+
+struct SRCSCRResetInfo {
+    IMX7SRCState *s;
+    uint32_t reset_bit;
+};
+
+static void imx7_clear_reset_bit(CPUState *cpu, run_on_cpu_data data)
+{
+    struct SRCSCRResetInfo *ri = data.host_ptr;
+    IMX7SRCState *s = ri->s;
+
+    assert(qemu_mutex_iothread_locked());
+
+    s->regs[SRC_A7RCR0] = deposit32(s->regs[SRC_A7RCR0], ri->reset_bit, 1, 0);
+    DPRINTF("reg[%s] <= 0x%" PRIx32 "\n",
+            imx7_src_reg_name(SRC_A7RCR0), s->regs[SRC_A7RCR0]);
+
+    g_free(ri);
+}
+
+static void imx7_defer_clear_reset_bit(uint32_t cpuid,
+                                       IMX7SRCState *s,
+                                       uint32_t reset_shift)
+{
+    struct SRCSCRResetInfo *ri;
+    CPUState *cpu = arm_get_cpu_by_id(cpuid);
+
+    if (!cpu) {
+        return;
+    }
+
+    ri = g_new(struct SRCSCRResetInfo, 1);
+    ri->s = s;
+    ri->reset_bit = reset_shift;
+
+    async_run_on_cpu(cpu, imx7_clear_reset_bit, RUN_ON_CPU_HOST_PTR(ri));
+}
+
+
+static void imx7_src_write(void *opaque, hwaddr offset, uint64_t value,
+                           unsigned size)
+{
+    IMX7SRCState *s = (IMX7SRCState *)opaque;
+    uint32_t index = offset >> 2;
+    long unsigned int change_mask;
+    uint32_t current_value = value;
+
+    if (index >= SRC_MAX) {
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0x%"
+                      HWADDR_PRIx "\n", TYPE_IMX7_SRC, __func__, offset);
+        return;
+    }
+
+    DPRINTF("reg[%s] <= 0x%" PRIx32 "\n", imx7_src_reg_name(index),
+            (uint32_t)current_value);
+
+    change_mask = s->regs[index] ^ (uint32_t)current_value;
+
+    switch (index) {
+    case SRC_A7RCR0:
+        if (EXTRACT(change_mask, CORE0_RST)) {
+            arm_reset_cpu(0);
+            imx7_defer_clear_reset_bit(0, s, CORE0_RST_SHIFT);
+        }
+        if (EXTRACT(change_mask, CORE1_RST)) {
+            arm_reset_cpu(1);
+            imx7_defer_clear_reset_bit(1, s, CORE1_RST_SHIFT);
+        }
+        s->regs[index] = current_value;
+        break;
+    case SRC_A7RCR1:
+        /*
+         * On real hardware when the system reset controller starts a
+         * secondary CPU it runs through some boot ROM code which reads
+         * the SRC_GPRX registers controlling the start address and branches
+         * to it.
+         * Here we are taking a short cut and branching directly to the
+         * requested address (we don't want to run the boot ROM code inside
+         * QEMU)
+         */
+        if (EXTRACT(change_mask, CORE1_ENABLE)) {
+            if (EXTRACT(current_value, CORE1_ENABLE)) {
+                /* CORE 1 is brought up */
+                arm_set_cpu_on(1, s->regs[SRC_GPR3], s->regs[SRC_GPR4],
+                               3, false);
+            } else {
+                /* CORE 1 is shut down */
+                arm_set_cpu_off(1);
+            }
+            /* We clear the reset bits as the processor changed state */
+            imx7_defer_clear_reset_bit(1, s, CORE1_RST_SHIFT);
+            clear_bit(CORE1_RST_SHIFT, &change_mask);
+        }
+        s->regs[index] = current_value;
+        break;
+    default:
+        s->regs[index] = current_value;
+        break;
+    }
+}
+
+static const struct MemoryRegionOps imx7_src_ops = {
+    .read = imx7_src_read,
+    .write = imx7_src_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        /*
+         * Our device would not work correctly if the guest was doing
+         * unaligned access. This might not be a limitation on the real
+         * device but in practice there is no reason for a guest to access
+         * this device unaligned.
+         */
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void imx7_src_realize(DeviceState *dev, Error **errp)
+{
+    IMX7SRCState *s = IMX7_SRC(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(dev), &imx7_src_ops, s,
+                          TYPE_IMX7_SRC, 0x1000);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
+}
+
+static void imx7_src_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = imx7_src_realize;
+    dc->reset = imx7_src_reset;
+    dc->vmsd = &vmstate_imx7_src;
+    dc->desc = "i.MX6 System Reset Controller";
+}
+
+static const TypeInfo imx7_src_info = {
+    .name          = TYPE_IMX7_SRC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IMX7SRCState),
+    .class_init    = imx7_src_class_init,
+};
+
+static void imx7_src_register_types(void)
+{
+    type_register_static(&imx7_src_info);
+}
+
+type_init(imx7_src_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 892f8b91c5..d9a370c1de 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -60,6 +60,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx6_src.c',
   'imx6ul_ccm.c',
   'imx7_ccm.c',
+  'imx7_src.c',
   'imx7_gpr.c',
   'imx7_snvs.c',
   'imx_ccm.c',
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 6138221350..1ae92b2feb 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -25,6 +25,7 @@
 #include "hw/misc/imx7_ccm.h"
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx7_gpr.h"
+#include "hw/misc/imx7_src.h"
 #include "hw/watchdog/wdt_imx2.h"
 #include "hw/gpio/imx_gpio.h"
 #include "hw/char/imx_serial.h"
@@ -73,6 +74,7 @@ struct FslIMX7State {
     IMX7CCMState       ccm;
     IMX7AnalogState    analog;
     IMX7SNVSState      snvs;
+    IMX7SRCState       src;
     IMXGPCv2State      gpcv2;
     IMXSPIState        spi[FSL_IMX7_NUM_ECSPIS];
     IMXI2CState        i2c[FSL_IMX7_NUM_I2CS];
diff --git a/include/hw/misc/imx7_src.h b/include/hw/misc/imx7_src.h
new file mode 100644
index 0000000000..bfd0b81fec
--- /dev/null
+++ b/include/hw/misc/imx7_src.h
@@ -0,0 +1,68 @@
+/*
+ * IMX7 System Reset Controller
+ *
+ * Copyright (C) 2023 Jean-Christophe Dubois <jcd@tribudubois.net>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef IMX7_SRC_H
+#define IMX7_SRC_H
+
+#include "hw/sysbus.h"
+#include "qemu/bitops.h"
+#include "qom/object.h"
+
+#define SRC_SCR 0
+#define SRC_A7RCR0 1
+#define SRC_A7RCR1 2
+#define SRC_M4RCR 3
+#define SRC_ERCR 5
+#define SRC_HSICPHY_RCR 7
+#define SRC_USBOPHY1_RCR 8
+#define SRC_USBOPHY2_RCR 9
+#define SRC_MPIPHY_RCR 10
+#define SRC_PCIEPHY_RCR 11
+#define SRC_SBMR1 22
+#define SRC_SRSR 23
+#define SRC_SISR 26
+#define SRC_SIMR 27
+#define SRC_SBMR2 28
+#define SRC_GPR1 29
+#define SRC_GPR2 30
+#define SRC_GPR3 31
+#define SRC_GPR4 32
+#define SRC_GPR5 33
+#define SRC_GPR6 34
+#define SRC_GPR7 35
+#define SRC_GPR8 36
+#define SRC_GPR9 37
+#define SRC_GPR10 38
+#define SRC_MAX 39
+
+/* SRC_A7SCR1 */
+#define CORE1_ENABLE_SHIFT     1
+#define CORE1_ENABLE_LENGTH    1
+/* SRC_A7SCR0 */
+#define CORE1_RST_SHIFT        5
+#define CORE1_RST_LENGTH       1
+#define CORE0_RST_SHIFT        4
+#define CORE0_RST_LENGTH       1
+
+#define EXTRACT(value, name) extract32(value, name##_SHIFT, name##_LENGTH)
+
+#define TYPE_IMX7_SRC "imx7.src"
+OBJECT_DECLARE_SIMPLE_TYPE(IMX7SRCState, IMX7_SRC)
+
+struct IMX7SRCState {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion iomem;
+
+    uint32_t regs[SRC_MAX];
+};
+
+#endif /* IMX7_SRC_H */
-- 
2.34.1


