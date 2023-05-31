Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF340718076
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:55:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LLs-0007Gk-4P; Wed, 31 May 2023 08:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLo-0007Fn-Jt
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:54:52 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLm-0006oH-50
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p8OMh53Zg6SUw7tmMBbk9hIjJp5aLvo5HSaO04Gpqes=; b=cmdmvIkuVyhojIjURDA3DPdZ41
 zAqeFxKnxHV5AqMfy/535IBbMGDIZMNEndHvIiNLrPW4Ylj8sOfeXuYduyItQHEuEnG/7kdOO7PMP
 eBE76CwDzgElu6wrxkowRhTE453QuUWuwZ/45ZPvsLeYizb3MgEIebRP5qiVMaqo1xs0CYjJI1aFh
 oSE5Lo0GPHmoIh84IQBC21BxxFERUfYboXgdd8rvwrJTBWmLdBh7KhNWroWrSy1Si5Fe5SCTlrwc/
 WoVmUBABn4tMCgJe5Mgm/pCw5XKUOhrXHB+v35PKIH1jj/iKYOJrXw+LH8jaOZdEe3zwIH8Krurr0
 m4f7cJVwO2ULUkxoB0OzUCrI94SG68+4z5biNq294X0CrxA4Fqs5If/7zq5Tvdh070BKu05JpfC6D
 yuRHS1ARndOdvODkW8t324Z6n5AJLEEuDd4kgO7cxJpLdYKefhRxS3NKwJH1PcrbbIdPj6m2bHiEu
 x/9LihDWBSH5sekKKyx89NaCLkP829baNZtRwVRxreVkRJrd1mPVeQc0pJfPzxVPxjH+lW9UBDnkO
 n0XCaAN0QOD6IJVhWEZfISebu3fJn2AV9tteyPxeOdNgDhwiBiQ+Ug1k0pvgdkMIZI9IV5+p+xKk4
 2DHTmZRBI+o1ZYGrzM+z+8U8l/OcASJvpIhFiM8h8=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLc-0008vd-6l; Wed, 31 May 2023 13:54:44 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 31 May 2023 13:53:44 +0100
Message-Id: <20230531125400.288917-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 07/23] q800: move GLUE device into separate q800-glue.c file
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

This will allow the q800-glue.h header to be included separately so that the
GLUE device can be referenced externally.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 MAINTAINERS                 |   2 +
 hw/m68k/meson.build         |   2 +-
 hw/m68k/q800-glue.c         | 252 ++++++++++++++++++++++++++++++++++++
 hw/m68k/q800.c              | 238 +---------------------------------
 include/hw/m68k/q800-glue.h |  50 +++++++
 5 files changed, 306 insertions(+), 238 deletions(-)
 create mode 100644 hw/m68k/q800-glue.c
 create mode 100644 include/hw/m68k/q800-glue.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 51e62efe1b..802fb1c2a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1223,6 +1223,7 @@ q800
 M: Laurent Vivier <laurent@vivier.eu>
 S: Maintained
 F: hw/m68k/q800.c
+F: hw/m68k/q800-glue.c
 F: hw/misc/mac_via.c
 F: hw/nubus/*
 F: hw/display/macfb.c
@@ -1235,6 +1236,7 @@ F: include/hw/nubus/*
 F: include/hw/display/macfb.h
 F: include/hw/block/swim.h
 F: include/hw/m68k/q800.h
+F: include/hw/m68k/q800-glue.h
 
 virt
 M: Laurent Vivier <laurent@vivier.eu>
diff --git a/hw/m68k/meson.build b/hw/m68k/meson.build
index 31248641d3..84bc68fa4e 100644
--- a/hw/m68k/meson.build
+++ b/hw/m68k/meson.build
@@ -2,7 +2,7 @@ m68k_ss = ss.source_set()
 m68k_ss.add(when: 'CONFIG_AN5206', if_true: files('an5206.c', 'mcf5206.c'))
 m68k_ss.add(when: 'CONFIG_MCF5208', if_true: files('mcf5208.c', 'mcf_intc.c'))
 m68k_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('next-kbd.c', 'next-cube.c'))
-m68k_ss.add(when: 'CONFIG_Q800', if_true: files('q800.c'))
+m68k_ss.add(when: 'CONFIG_Q800', if_true: files('q800.c', 'q800-glue.c'))
 m68k_ss.add(when: 'CONFIG_M68K_VIRT', if_true: files('virt.c'))
 
 hw_arch += {'m68k': m68k_ss}
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
new file mode 100644
index 0000000000..793bdb110c
--- /dev/null
+++ b/hw/m68k/q800-glue.c
@@ -0,0 +1,252 @@
+/*
+ * QEMU q800 logic glue
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
+#include "cpu.h"
+#include "hw/m68k/q800-glue.h"
+#include "hw/boards.h"
+#include "hw/irq.h"
+#include "hw/nmi.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+
+/*
+ * The GLUE (General Logic Unit) is an Apple custom integrated circuit chip
+ * that performs a variety of functions (RAM management, clock generation, ...).
+ * The GLUE chip receives interrupt requests from various devices,
+ * assign priority to each, and asserts one or more interrupt line to the
+ * CPU.
+ */
+
+/*
+ * The GLUE logic on the Quadra 800 supports 2 different IRQ routing modes
+ * controlled from the VIA1 auxmode GPIO (port B bit 6) which are documented
+ * in NetBSD as follows:
+ *
+ * A/UX mode (Linux, NetBSD, auxmode GPIO low)
+ *
+ *   Level 0:        Spurious: ignored
+ *   Level 1:        Software
+ *   Level 2:        VIA2 (except ethernet, sound)
+ *   Level 3:        Ethernet
+ *   Level 4:        Serial (SCC)
+ *   Level 5:        Sound
+ *   Level 6:        VIA1
+ *   Level 7:        NMIs: parity errors, RESET button, YANCC error
+ *
+ * Classic mode (default: used by MacOS, A/UX 3.0.1, auxmode GPIO high)
+ *
+ *   Level 0:        Spurious: ignored
+ *   Level 1:        VIA1 (clock, ADB)
+ *   Level 2:        VIA2 (NuBus, SCSI)
+ *   Level 3:
+ *   Level 4:        Serial (SCC)
+ *   Level 5:
+ *   Level 6:
+ *   Level 7:        Non-maskable: parity errors, RESET button
+ *
+ * Note that despite references to A/UX mode in Linux and NetBSD, at least
+ * A/UX 3.0.1 still uses Classic mode.
+ */
+
+static void GLUE_set_irq(void *opaque, int irq, int level)
+{
+    GLUEState *s = opaque;
+    int i;
+
+    if (s->auxmode) {
+        /* Classic mode */
+        switch (irq) {
+        case GLUE_IRQ_IN_VIA1:
+            irq = 0;
+            break;
+
+        case GLUE_IRQ_IN_VIA2:
+            irq = 1;
+            break;
+
+        case GLUE_IRQ_IN_SONIC:
+            /* Route to VIA2 instead */
+            qemu_set_irq(s->irqs[GLUE_IRQ_NUBUS_9], level);
+            return;
+
+        case GLUE_IRQ_IN_ESCC:
+            irq = 3;
+            break;
+
+        case GLUE_IRQ_IN_NMI:
+            irq = 6;
+            break;
+
+        default:
+            g_assert_not_reached();
+        }
+    } else {
+        /* A/UX mode */
+        switch (irq) {
+        case GLUE_IRQ_IN_VIA1:
+            irq = 5;
+            break;
+
+        case GLUE_IRQ_IN_VIA2:
+            irq = 1;
+            break;
+
+        case GLUE_IRQ_IN_SONIC:
+            irq = 2;
+            break;
+
+        case GLUE_IRQ_IN_ESCC:
+            irq = 3;
+            break;
+
+        case GLUE_IRQ_IN_NMI:
+            irq = 6;
+            break;
+
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    if (level) {
+        s->ipr |= 1 << irq;
+    } else {
+        s->ipr &= ~(1 << irq);
+    }
+
+    for (i = 7; i >= 0; i--) {
+        if ((s->ipr >> i) & 1) {
+            m68k_set_irq_level(s->cpu, i + 1, i + 25);
+            return;
+        }
+    }
+    m68k_set_irq_level(s->cpu, 0, 0);
+}
+
+static void glue_auxmode_set_irq(void *opaque, int irq, int level)
+{
+    GLUEState *s = GLUE(opaque);
+
+    s->auxmode = level;
+}
+
+static void glue_nmi(NMIState *n, int cpu_index, Error **errp)
+{
+    GLUEState *s = GLUE(n);
+
+    /* Hold NMI active for 100ms */
+    GLUE_set_irq(s, GLUE_IRQ_IN_NMI, 1);
+    timer_mod(s->nmi_release, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 100);
+}
+
+static void glue_nmi_release(void *opaque)
+{
+    GLUEState *s = GLUE(opaque);
+
+    GLUE_set_irq(s, GLUE_IRQ_IN_NMI, 0);
+}
+
+static void glue_reset(DeviceState *dev)
+{
+    GLUEState *s = GLUE(dev);
+
+    s->ipr = 0;
+    s->auxmode = 0;
+
+    timer_del(s->nmi_release);
+}
+
+static const VMStateDescription vmstate_glue = {
+    .name = "q800-glue",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(ipr, GLUEState),
+        VMSTATE_UINT8(auxmode, GLUEState),
+        VMSTATE_TIMER_PTR(nmi_release, GLUEState),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+/*
+ * If the m68k CPU implemented its inbound irq lines as GPIO lines
+ * rather than via the m68k_set_irq_level() function we would not need
+ * this cpu link property and could instead provide outbound IRQ lines
+ * that the board could wire up to the CPU.
+ */
+static Property glue_properties[] = {
+    DEFINE_PROP_LINK("cpu", GLUEState, cpu, TYPE_M68K_CPU, M68kCPU *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void glue_finalize(Object *obj)
+{
+    GLUEState *s = GLUE(obj);
+
+    timer_free(s->nmi_release);
+}
+
+static void glue_init(Object *obj)
+{
+    DeviceState *dev = DEVICE(obj);
+    GLUEState *s = GLUE(dev);
+
+    qdev_init_gpio_in(dev, GLUE_set_irq, 8);
+    qdev_init_gpio_in_named(dev, glue_auxmode_set_irq, "auxmode", 1);
+
+    qdev_init_gpio_out(dev, s->irqs, 1);
+
+    /* NMI release timer */
+    s->nmi_release = timer_new_ms(QEMU_CLOCK_VIRTUAL, glue_nmi_release, s);
+}
+
+static void glue_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    NMIClass *nc = NMI_CLASS(klass);
+
+    dc->vmsd = &vmstate_glue;
+    dc->reset = glue_reset;
+    device_class_set_props(dc, glue_properties);
+    nc->nmi_monitor_handler = glue_nmi;
+}
+
+static const TypeInfo glue_info = {
+    .name = TYPE_GLUE,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(GLUEState),
+    .instance_init = glue_init,
+    .instance_finalize = glue_finalize,
+    .class_init = glue_class_init,
+    .interfaces = (InterfaceInfo[]) {
+         { TYPE_NMI },
+         { }
+    },
+};
+
+static void glue_register_types(void)
+{
+    type_register_static(&glue_info);
+}
+
+type_init(glue_register_types)
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 3d0a56d9f3..1d9dad60b3 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -28,7 +28,6 @@
 #include "cpu.h"
 #include "hw/boards.h"
 #include "hw/or-irq.h"
-#include "hw/nmi.h"
 #include "elf.h"
 #include "hw/loader.h"
 #include "ui/console.h"
@@ -39,6 +38,7 @@
 #include "standard-headers/asm-m68k/bootinfo-mac.h"
 #include "bootinfo.h"
 #include "hw/m68k/q800.h"
+#include "hw/m68k/q800-glue.h"
 #include "hw/misc/mac_via.h"
 #include "hw/input/adb.h"
 #include "hw/nubus/mac-nubus-bridge.h"
@@ -88,241 +88,6 @@
 #define Q800_NUBUS_SLOTS_AVAILABLE    (BIT(0x9) | BIT(0xc) | BIT(0xd) | \
                                        BIT(0xe))
 
-/*
- * The GLUE (General Logic Unit) is an Apple custom integrated circuit chip
- * that performs a variety of functions (RAM management, clock generation, ...).
- * The GLUE chip receives interrupt requests from various devices,
- * assign priority to each, and asserts one or more interrupt line to the
- * CPU.
- */
-
-#define TYPE_GLUE "q800-glue"
-OBJECT_DECLARE_SIMPLE_TYPE(GLUEState, GLUE)
-
-struct GLUEState {
-    SysBusDevice parent_obj;
-
-    M68kCPU *cpu;
-    uint8_t ipr;
-    uint8_t auxmode;
-    qemu_irq irqs[1];
-    QEMUTimer *nmi_release;
-};
-
-#define GLUE_IRQ_IN_VIA1       0
-#define GLUE_IRQ_IN_VIA2       1
-#define GLUE_IRQ_IN_SONIC      2
-#define GLUE_IRQ_IN_ESCC       3
-#define GLUE_IRQ_IN_NMI        4
-
-#define GLUE_IRQ_NUBUS_9       0
-
-/*
- * The GLUE logic on the Quadra 800 supports 2 different IRQ routing modes
- * controlled from the VIA1 auxmode GPIO (port B bit 6) which are documented
- * in NetBSD as follows:
- *
- * A/UX mode (Linux, NetBSD, auxmode GPIO low)
- *
- *   Level 0:        Spurious: ignored
- *   Level 1:        Software
- *   Level 2:        VIA2 (except ethernet, sound)
- *   Level 3:        Ethernet
- *   Level 4:        Serial (SCC)
- *   Level 5:        Sound
- *   Level 6:        VIA1
- *   Level 7:        NMIs: parity errors, RESET button, YANCC error
- *
- * Classic mode (default: used by MacOS, A/UX 3.0.1, auxmode GPIO high)
- *
- *   Level 0:        Spurious: ignored
- *   Level 1:        VIA1 (clock, ADB)
- *   Level 2:        VIA2 (NuBus, SCSI)
- *   Level 3:
- *   Level 4:        Serial (SCC)
- *   Level 5:
- *   Level 6:
- *   Level 7:        Non-maskable: parity errors, RESET button
- *
- * Note that despite references to A/UX mode in Linux and NetBSD, at least
- * A/UX 3.0.1 still uses Classic mode.
- */
-
-static void GLUE_set_irq(void *opaque, int irq, int level)
-{
-    GLUEState *s = opaque;
-    int i;
-
-    if (s->auxmode) {
-        /* Classic mode */
-        switch (irq) {
-        case GLUE_IRQ_IN_VIA1:
-            irq = 0;
-            break;
-
-        case GLUE_IRQ_IN_VIA2:
-            irq = 1;
-            break;
-
-        case GLUE_IRQ_IN_SONIC:
-            /* Route to VIA2 instead */
-            qemu_set_irq(s->irqs[GLUE_IRQ_NUBUS_9], level);
-            return;
-
-        case GLUE_IRQ_IN_ESCC:
-            irq = 3;
-            break;
-
-        case GLUE_IRQ_IN_NMI:
-            irq = 6;
-            break;
-
-        default:
-            g_assert_not_reached();
-        }
-    } else {
-        /* A/UX mode */
-        switch (irq) {
-        case GLUE_IRQ_IN_VIA1:
-            irq = 5;
-            break;
-
-        case GLUE_IRQ_IN_VIA2:
-            irq = 1;
-            break;
-
-        case GLUE_IRQ_IN_SONIC:
-            irq = 2;
-            break;
-
-        case GLUE_IRQ_IN_ESCC:
-            irq = 3;
-            break;
-
-        case GLUE_IRQ_IN_NMI:
-            irq = 6;
-            break;
-
-        default:
-            g_assert_not_reached();
-        }
-    }
-
-    if (level) {
-        s->ipr |= 1 << irq;
-    } else {
-        s->ipr &= ~(1 << irq);
-    }
-
-    for (i = 7; i >= 0; i--) {
-        if ((s->ipr >> i) & 1) {
-            m68k_set_irq_level(s->cpu, i + 1, i + 25);
-            return;
-        }
-    }
-    m68k_set_irq_level(s->cpu, 0, 0);
-}
-
-static void glue_auxmode_set_irq(void *opaque, int irq, int level)
-{
-    GLUEState *s = GLUE(opaque);
-
-    s->auxmode = level;
-}
-
-static void glue_nmi(NMIState *n, int cpu_index, Error **errp)
-{
-    GLUEState *s = GLUE(n);
-
-    /* Hold NMI active for 100ms */
-    GLUE_set_irq(s, GLUE_IRQ_IN_NMI, 1);
-    timer_mod(s->nmi_release, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 100);
-}
-
-static void glue_nmi_release(void *opaque)
-{
-    GLUEState *s = GLUE(opaque);
-
-    GLUE_set_irq(s, GLUE_IRQ_IN_NMI, 0);
-}
-
-static void glue_reset(DeviceState *dev)
-{
-    GLUEState *s = GLUE(dev);
-
-    s->ipr = 0;
-    s->auxmode = 0;
-
-    timer_del(s->nmi_release);
-}
-
-static const VMStateDescription vmstate_glue = {
-    .name = "q800-glue",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
-        VMSTATE_UINT8(ipr, GLUEState),
-        VMSTATE_UINT8(auxmode, GLUEState),
-        VMSTATE_TIMER_PTR(nmi_release, GLUEState),
-        VMSTATE_END_OF_LIST(),
-    },
-};
-
-/*
- * If the m68k CPU implemented its inbound irq lines as GPIO lines
- * rather than via the m68k_set_irq_level() function we would not need
- * this cpu link property and could instead provide outbound IRQ lines
- * that the board could wire up to the CPU.
- */
-static Property glue_properties[] = {
-    DEFINE_PROP_LINK("cpu", GLUEState, cpu, TYPE_M68K_CPU, M68kCPU *),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void glue_finalize(Object *obj)
-{
-    GLUEState *s = GLUE(obj);
-
-    timer_free(s->nmi_release);
-}
-
-static void glue_init(Object *obj)
-{
-    DeviceState *dev = DEVICE(obj);
-    GLUEState *s = GLUE(dev);
-
-    qdev_init_gpio_in(dev, GLUE_set_irq, 8);
-    qdev_init_gpio_in_named(dev, glue_auxmode_set_irq, "auxmode", 1);
-
-    qdev_init_gpio_out(dev, s->irqs, 1);
-
-    /* NMI release timer */
-    s->nmi_release = timer_new_ms(QEMU_CLOCK_VIRTUAL, glue_nmi_release, s);
-}
-
-static void glue_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    NMIClass *nc = NMI_CLASS(klass);
-
-    dc->vmsd = &vmstate_glue;
-    dc->reset = glue_reset;
-    device_class_set_props(dc, glue_properties);
-    nc->nmi_monitor_handler = glue_nmi;
-}
-
-static const TypeInfo glue_info = {
-    .name = TYPE_GLUE,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(GLUEState),
-    .instance_init = glue_init,
-    .instance_finalize = glue_finalize,
-    .class_init = glue_class_init,
-    .interfaces = (InterfaceInfo[]) {
-         { TYPE_NMI },
-         { }
-    },
-};
 
 static void main_cpu_reset(void *opaque)
 {
@@ -758,7 +523,6 @@ static const TypeInfo q800_machine_typeinfo = {
 static void q800_machine_register_types(void)
 {
     type_register_static(&q800_machine_typeinfo);
-    type_register_static(&glue_info);
 }
 
 type_init(q800_machine_register_types)
diff --git a/include/hw/m68k/q800-glue.h b/include/hw/m68k/q800-glue.h
new file mode 100644
index 0000000000..c1817b01a5
--- /dev/null
+++ b/include/hw/m68k/q800-glue.h
@@ -0,0 +1,50 @@
+/*
+ * QEMU q800 logic glue
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
+#ifndef HW_Q800_GLUE_H
+#define HW_Q800_GLUE_H
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+
+#define TYPE_GLUE "q800-glue"
+OBJECT_DECLARE_SIMPLE_TYPE(GLUEState, GLUE)
+
+struct GLUEState {
+    SysBusDevice parent_obj;
+
+    M68kCPU *cpu;
+    uint8_t ipr;
+    uint8_t auxmode;
+    qemu_irq irqs[1];
+    QEMUTimer *nmi_release;
+};
+
+#define GLUE_IRQ_IN_VIA1       0
+#define GLUE_IRQ_IN_VIA2       1
+#define GLUE_IRQ_IN_SONIC      2
+#define GLUE_IRQ_IN_ESCC       3
+#define GLUE_IRQ_IN_NMI        4
+
+#define GLUE_IRQ_NUBUS_9       0
+
+#endif
-- 
2.30.2


