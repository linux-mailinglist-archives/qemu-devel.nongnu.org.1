Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA68773989F
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:57:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFBE-0004Ht-JH; Thu, 22 Jun 2023 03:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAg-000438-Or
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:02 -0400
Received: from mout.kundenserver.de ([212.227.126.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAY-0002sV-8u
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:02 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MWixU-1qaJVl2a40-00X7Mc; Thu, 22
 Jun 2023 09:55:50 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/24] q800: move GLUE device into separate q800-glue.c file
Date: Thu, 22 Jun 2023 09:55:27 +0200
Message-Id: <20230622075544.210899-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:F07EPQdHAK5INksPuITxFBfSCTGC8Gg0Dwam2ZT7pSGaEK8pN76
 8Gpy00lGW3ENr5Wi8KGVjAV4F9ZypMKS2XC2DRUYrHM51C4GwOxZuagg4DUykFY33sYkafP
 CtBTZpjbhZa5Nd3trjwn183CKjYS3h6yspCW8asC4ammfY1Kw7/25XwuyoqVH2mDP+Io7Aw
 ddbe8WPC/0NkzaHQIN+Ug==
UI-OutboundReport: notjunk:1;M01:P0:HCfMPhW76DU=;Uckrqntzm/DGoUcr64taoqG3w/r
 KXb/wxkYPZ+l/YArjBFAxefivfInmNdrseUYE6OobpIxrg+qKMq5h2mVPZYVWY+ZWqA3zKDDd
 J2Uk7SXLVyFapxRzzbC/bAgdMurF2EBvPBwkbrTveyyjsQ8B8tQWhwjlG8LUldPpUx269JT9U
 YNAI/7wGnsZ29MBwzLES5jYz/g65rzoYi5+ujwJ8OQnG7OUwzj35ri4sbsz+hdCICZ/1EQe/A
 0nGDIlDH77EQJ5rz+KhDd0VXCm53MdAb4Q5JfzB9f1Zh85/+MI3O+AcOcolsEadtRCHzTWQ2A
 avLLTwtHbAug/TTCcGPG+NKoqed+YviDI8uhm2BQt1qifNJZof9C7XfZYM/qvsbE1CACsVtDr
 kXlVwMOZt01tYgiE6HSAQCsUtaADLtApmNeA/0Kxbe7eyJHup/f97tPfuvy2Pe9+hYnHStzY+
 7FMXcTZ3WZQAtLBNVAP0SK7ZMxZFhjnWYtu6iRlKhWCmfY5KB/9EOGSF/EEubknrXtN4cF4wQ
 eFqWMjmfOgYexZN+yHwHxPnK1WHv5847uUOD9Xae5NQxls2yAqY43cOoQ0UkTCYOupu6JH/EM
 kDpxwOHIHAA7z2O2QH7k+8jntUZUty06szPCKGOfTG3Ybv2ZcsAtkpwwQR0Dx9Ph8HUtHgvU0
 bqPnydlvWPJeSurNbj4fB8HrOq7UYCPAWvijgqKTlw==
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This will allow the q800-glue.h header to be included separately so that the
GLUE device can be referenced externally.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230621085353.113233-8-mark.cave-ayland@ilande.co.uk>
[lv: update comment]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS                 |   2 +
 include/hw/m68k/q800-glue.h |  50 +++++++
 hw/m68k/q800-glue.c         | 252 ++++++++++++++++++++++++++++++++++++
 hw/m68k/q800.c              | 238 +---------------------------------
 hw/m68k/meson.build         |   2 +-
 5 files changed, 306 insertions(+), 238 deletions(-)
 create mode 100644 include/hw/m68k/q800-glue.h
 create mode 100644 hw/m68k/q800-glue.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 748a66fbaa30..7f323cd2ebd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1225,6 +1225,7 @@ q800
 M: Laurent Vivier <laurent@vivier.eu>
 S: Maintained
 F: hw/m68k/q800.c
+F: hw/m68k/q800-glue.c
 F: hw/misc/mac_via.c
 F: hw/nubus/*
 F: hw/display/macfb.c
@@ -1237,6 +1238,7 @@ F: include/hw/nubus/*
 F: include/hw/display/macfb.h
 F: include/hw/block/swim.h
 F: include/hw/m68k/q800.h
+F: include/hw/m68k/q800-glue.h
 
 virt
 M: Laurent Vivier <laurent@vivier.eu>
diff --git a/include/hw/m68k/q800-glue.h b/include/hw/m68k/q800-glue.h
new file mode 100644
index 000000000000..a35efc1c534d
--- /dev/null
+++ b/include/hw/m68k/q800-glue.h
@@ -0,0 +1,50 @@
+/*
+ * QEMU q800 logic GLUE (General Logic Unit)
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
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
new file mode 100644
index 000000000000..e81f9438f116
--- /dev/null
+++ b/hw/m68k/q800-glue.c
@@ -0,0 +1,252 @@
+/*
+ * QEMU q800 logic GLUE (General Logic Unit)
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
index 9f9668c2b4b3..9f9de2ebafb7 100644
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
@@ -763,7 +528,6 @@ static const TypeInfo q800_machine_typeinfo = {
 static void q800_machine_register_types(void)
 {
     type_register_static(&q800_machine_typeinfo);
-    type_register_static(&glue_info);
 }
 
 type_init(q800_machine_register_types)
diff --git a/hw/m68k/meson.build b/hw/m68k/meson.build
index 31248641d301..84bc68fa4ee4 100644
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
-- 
2.40.1


