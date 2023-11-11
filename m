Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F20E57F4769
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 14:12:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5n0r-0006tG-FU; Wed, 22 Nov 2023 08:11:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1r5n0p-0006sW-9C; Wed, 22 Nov 2023 08:11:27 -0500
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1r5n0m-0001vh-2b; Wed, 22 Nov 2023 08:11:26 -0500
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 12A8F11EF31;
 Wed, 22 Nov 2023 13:11:20 +0000 (UTC)
From: ~aminier <aminier@git.sr.ht>
Date: Sat, 11 Nov 2023 15:33:33 +0100
Subject: [PATCH qemu v2 1/1] Implement STM32L4x5 EXTI
MIME-Version: 1.0
Message-ID: <170065867969.8823.8108107963720785285-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <170065867969.8823.8108107963720785285-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alistair@alistair23.me, philmd@linaro.org,
 peter.maydell@linaro.org, ines.varhol@telecom-paris.fr,
 arnaud.minier@telecom-paris.fr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: ~aminier <arnaud.minier@telecom-paris.fr>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Arnaud Minier <arnaud.minier@telecom-paris.fr>

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/arm/Kconfig                    |   1 +
 hw/arm/stm32l4x5_soc.c            |  65 ++++++-
 hw/misc/Kconfig                   |   3 +
 hw/misc/meson.build               |   1 +
 hw/misc/stm32l4x5_exti.c          | 303 ++++++++++++++++++++++++++++++
 hw/misc/trace-events              |   5 +
 include/hw/arm/stm32l4x5_soc.h    |   3 +
 include/hw/misc/stm32l4x5_exti.h  |  58 ++++++
 tests/qtest/meson.build           |   5 +
 tests/qtest/stm32l4x5_exti-test.c | 104 ++++++++++
 10 files changed, 546 insertions(+), 2 deletions(-)
 create mode 100644 hw/misc/stm32l4x5_exti.c
 create mode 100644 include/hw/misc/stm32l4x5_exti.h
 create mode 100644 tests/qtest/stm32l4x5_exti-test.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index b95576fb0c..28d378ed83 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -458,6 +458,7 @@ config STM32L4X5_SOC
     bool
     select ARM_V7M
     select OR_IRQ
+    select STM32L4X5_EXTI
=20
 config XLNX_ZYNQMP_ARM
     bool
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index 198d3f6d3e..8065050907 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -43,10 +43,51 @@
 #define SRAM2_BASE_ADDRESS 0x10000000
 #define SRAM2_SIZE (32 * KiB)
=20
+#define EXTI_ADDR 0x40010400
+
+#define NUM_EXTI_IRQ 40
+/* Match exti line connections with their CPU IRQ number */
+/* See Vector Table (Reference Manual p.396) */
+static const int exti_irq[NUM_EXTI_IRQ] =3D {
+    6,                      /* GPIO[0]                 */
+    7,                      /* GPIO[1]                 */
+    8,                      /* GPIO[2]                 */
+    9,                      /* GPIO[3]                 */
+    10,                     /* GPIO[4]                 */
+    23, 23, 23, 23, 23,     /* GPIO[5..9]              */
+    40, 40, 40, 40, 40, 40, /* GPIO[10..15]            */
+    1,                      /* PVD                     */
+    67,                     /* OTG_FS_WKUP, Direct     */
+    41,                     /* RTC_ALARM               */
+    2,                      /* RTC_TAMP_STAMP2/CSS_LSE */
+    3,                      /* RTC wakeup timer        */
+    63,                     /* COMP1                   */
+    63,                     /* COMP2                   */
+    31,                     /* I2C1 wakeup, Direct     */
+    33,                     /* I2C2 wakeup, Direct     */
+    72,                     /* I2C3 wakeup, Direct     */
+    37,                     /* USART1 wakeup, Direct   */
+    38,                     /* USART2 wakeup, Direct   */
+    39,                     /* USART3 wakeup, Direct   */
+    52,                     /* UART4 wakeup, Direct    */
+    53,                     /* UART4 wakeup, Direct    */
+    70,                     /* LPUART1 wakeup, Direct  */
+    65,                     /* LPTIM1, Direct          */
+    66,                     /* LPTIM2, Direct          */
+    76,                     /* SWPMI1 wakeup, Direct   */
+    1,                      /* PVM1 wakeup             */
+    1,                      /* PVM2 wakeup             */
+    1,                      /* PVM3 wakeup             */
+    1,                      /* PVM4 wakeup             */
+    78                      /* LCD wakeup, Direct      */
+};
+
 static void stm32l4x5_soc_initfn(Object *obj)
 {
     Stm32l4x5SocState *s =3D STM32L4X5_SOC(obj);
=20
+    object_initialize_child(obj, "exti", &s->exti, TYPE_STM32L4X5_EXTI);
+
     s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
     s->refclk =3D qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
 }
@@ -57,7 +98,9 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Err=
or **errp)
     Stm32l4x5SocState *s =3D STM32L4X5_SOC(dev_soc);
     const Stm32l4x5SocClass *sc =3D STM32L4X5_SOC_GET_CLASS(dev_soc);
     MemoryRegion *system_memory =3D get_system_memory();
-    DeviceState *armv7m;
+    DeviceState *dev, *armv7m;
+    SysBusDevice *busdev;
+    int i;
=20
     /*
      * We use s->refclk internally and only define it with qdev_init_clock_i=
n()
@@ -122,6 +165,25 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, =
Error **errp)
         return;
     }
=20
+    dev =3D DEVICE(&s->exti);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->exti), errp)) {
+        return;
+    }
+    busdev =3D SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, EXTI_ADDR);
+    for (i =3D 0; i < NUM_EXTI_IRQ; i++) {
+        /* IRQ seems not to be connected ? */
+        sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[i]));
+    }
+
+    /*
+     * Uncomment when Syscfg is implemented
+     * for (i =3D 0; i < 16; i++) {
+     *     qdev_connect_gpio_out(DEVICE(&s->syscfg), i,
+     *                           qdev_get_gpio_in(dev, i));
+     * }
+     */
+
     /* APB1 BUS */
     create_unimplemented_device("TIM2",      0x40000000, 0x400);
     create_unimplemented_device("TIM3",      0x40000400, 0x400);
@@ -162,7 +224,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, E=
rror **errp)
     create_unimplemented_device("SYSCFG",    0x40010000, 0x30);
     create_unimplemented_device("VREFBUF",   0x40010030, 0x1D0);
     create_unimplemented_device("COMP",      0x40010200, 0x200);
-    create_unimplemented_device("EXTI",      0x40010400, 0x400);
     /* RESERVED:    0x40010800, 0x1400 */
     create_unimplemented_device("FIREWALL",  0x40011C00, 0x400);
     /* RESERVED:    0x40012000, 0x800 */
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index cc8a8c1418..3efe3dc2cc 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -87,6 +87,9 @@ config STM32F4XX_SYSCFG
 config STM32F4XX_EXTI
     bool
=20
+config STM32L4X5_EXTI
+    bool
+
 config MIPS_ITU
     bool
=20
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 36c20d5637..16db6e228d 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -110,6 +110,7 @@ system_ss.add(when: 'CONFIG_XLNX_VERSAL_TRNG', if_true: f=
iles(
 system_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true: files('stm32f2xx_sys=
cfg.c'))
 system_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_true: files('stm32f4xx_sys=
cfg.c'))
 system_ss.add(when: 'CONFIG_STM32F4XX_EXTI', if_true: files('stm32f4xx_exti.=
c'))
+system_ss.add(when: 'CONFIG_STM32L4X5_EXTI', if_true: files('stm32l4x5_exti.=
c'))
 system_ss.add(when: 'CONFIG_MPS2_FPGAIO', if_true: files('mps2-fpgaio.c'))
 system_ss.add(when: 'CONFIG_MPS2_SCC', if_true: files('mps2-scc.c'))
=20
diff --git a/hw/misc/stm32l4x5_exti.c b/hw/misc/stm32l4x5_exti.c
new file mode 100644
index 0000000000..117a1a31b4
--- /dev/null
+++ b/hw/misc/stm32l4x5_exti.c
@@ -0,0 +1,303 @@
+/*
+ * STM32L4x5 EXTI (Extended interrupts and events controller)
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: MIT
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a c=
opy
+ * of this software and associated documentation files (the "Software"), to =
deal
+ * in the Software without restriction, including without limitation the rig=
hts
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
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING F=
ROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+/* stm32l4x5_exti implementation is derived from stm32f4xx_exti */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "trace.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "hw/misc/stm32l4x5_exti.h"
+
+#define EXTI_IMR1   0x00
+#define EXTI_EMR1   0x04
+#define EXTI_RTSR1  0x08
+#define EXTI_FTSR1  0x0C
+#define EXTI_SWIER1 0x10
+#define EXTI_PR1    0x14
+#define EXTI_IMR2   0x20
+#define EXTI_EMR2   0x24
+#define EXTI_RTSR2  0x28
+#define EXTI_FTSR2  0x2C
+#define EXTI_SWIER2 0x30
+#define EXTI_PR2    0x34
+
+#define EXTI_NUM_GPIO_EVENT_IN_LINES 16
+
+/* 0b11111111_10000010_00000000_00000000 */
+#define DIRECT_LINE_MASK1 0xFF820000
+/* 0b00000000_00000000_00000000_10000111 */
+#define DIRECT_LINE_MASK2 0x00000087
+/* 0b11111111_11111111_11111111_00000000 */
+#define RESERVED_BITS_MASK_EXTI_xMR2 0xFFFFFF00
+
+/* 0b00000000_00000000_00000000_01111000 */
+#define ACTIVABLE_xR2 (~DIRECT_LINE_MASK2 & ~RESERVED_BITS_MASK_EXTI_xMR2)
+
+static void stm32l4x5_exti_reset_hold(Object *obj)
+{
+    Stm32l4x5ExtiState *s =3D STM32L4X5_EXTI(obj);
+
+    s->imr[0] =3D DIRECT_LINE_MASK1;
+    s->emr[0] =3D 0x00000000;
+    s->rtsr[0] =3D 0x00000000;
+    s->ftsr[0] =3D 0x00000000;
+    s->swier[0] =3D 0x00000000;
+    s->pr[0] =3D 0x00000000;
+
+    s->imr[1] =3D DIRECT_LINE_MASK2;
+    s->emr[1] =3D 0x00000000;
+    s->rtsr[1] =3D 0x00000000;
+    s->ftsr[1] =3D 0x00000000;
+    s->swier[1] =3D 0x00000000;
+    s->pr[1] =3D 0x00000000;
+}
+
+static void stm32l4x5_exti_set_irq(void *opaque, int irq, int level)
+{
+    Stm32l4x5ExtiState *s =3D opaque;
+    const unsigned n =3D irq >=3D 32;
+    const int oirq =3D irq;
+
+    trace_stm32l4x5_exti_set_irq(irq, level);
+
+    if (irq >=3D 32) {
+        /* Shift the value to enable access in x2 registers. */
+        irq -=3D 32;
+    }
+
+    if (((1 << irq) & s->rtsr[n]) && level) {
+        /* Rising Edge */
+        s->pr[n] |=3D 1 << irq;
+    }
+
+    if (((1 << irq) & s->ftsr[n]) && !level) {
+        /* Falling Edge */
+        s->pr[n] |=3D 1 << irq;
+    }
+
+    if (!((1 << irq) & s->imr[n])) {
+        /* Interrupt is masked */
+        return;
+    }
+
+    qemu_irq_pulse(s->irq[oirq]);
+}
+
+static uint64_t stm32l4x5_exti_read(void *opaque, hwaddr addr,
+                                    unsigned int size)
+{
+    Stm32l4x5ExtiState *s =3D opaque;
+    uint32_t r =3D 0;
+    const unsigned n =3D addr >=3D EXTI_IMR2;
+
+    switch (addr) {
+    case EXTI_IMR1:
+    case EXTI_IMR2:
+        r =3D s->imr[n];
+        break;
+    case EXTI_EMR1:
+    case EXTI_EMR2:
+        r =3D s->emr[n];
+        break;
+    case EXTI_RTSR1:
+    case EXTI_RTSR2:
+        r =3D s->rtsr[n];
+        break;
+    case EXTI_FTSR1:
+    case EXTI_FTSR2:
+        r =3D s->ftsr[n];
+        break;
+    case EXTI_SWIER1:
+    case EXTI_SWIER2:
+        r =3D s->swier[n];
+        break;
+    case EXTI_PR1:
+    case EXTI_PR2:
+        r =3D s->pr[n];
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "STM32L4X5_exti_read: Bad offset 0x%x\n", (int)addr);
+        break;
+    }
+
+    trace_stm32l4x5_exti_read(addr, r);
+
+    return r;
+}
+
+static void stm32l4x5_exti_write(void *opaque, hwaddr addr,
+                                 uint64_t val64, unsigned int size)
+{
+    Stm32l4x5ExtiState *s =3D opaque;
+    const uint32_t value =3D (uint32_t)val64;
+
+    trace_stm32l4x5_exti_write(addr, value);
+
+    switch (addr) {
+    case EXTI_IMR1:
+        s->imr[0] =3D value;
+        return;
+    case EXTI_EMR1:
+        s->emr[0] =3D value;
+        return;
+    case EXTI_RTSR1:
+        s->rtsr[0] =3D value & ~DIRECT_LINE_MASK1;
+        return;
+    case EXTI_FTSR1:
+        s->ftsr[0] =3D value & ~DIRECT_LINE_MASK1;
+        return;
+    case EXTI_SWIER1:
+        s->swier[0] =3D value & ~DIRECT_LINE_MASK1;
+        for (int i =3D 0; i < 32; i++) {
+            const uint32_t mask =3D 1 << i;
+            if (s->swier[0] & s->imr[0] & mask) {
+                s->pr[0] |=3D mask;
+                qemu_irq_pulse(s->irq[i]);
+            }
+        }
+        return;
+    case EXTI_PR1:
+        /* This bit is cleared by writing a 1 to it */
+        s->pr[0] &=3D ~(value & ~DIRECT_LINE_MASK1);
+        /* Don't forget to clean software interrupts */
+        s->swier[0] &=3D ~(value & ~DIRECT_LINE_MASK1);
+        for (int i =3D 0; i < 32; i++) {
+            const uint32_t mask =3D 1 << i;
+            if (!(s->pr[0] & mask)) {
+                qemu_irq_lower(s->irq[i]);
+            }
+        }
+        return;
+    case EXTI_IMR2:
+        s->imr[1] =3D value & ~RESERVED_BITS_MASK_EXTI_xMR2;
+        return;
+    case EXTI_EMR2:
+        s->emr[1] =3D value & ~RESERVED_BITS_MASK_EXTI_xMR2;
+        return;
+    case EXTI_RTSR2:
+        s->rtsr[1] =3D value & ACTIVABLE_xR2;
+        return;
+    case EXTI_FTSR2:
+        s->ftsr[1] =3D value & ACTIVABLE_xR2;
+        return;
+    case EXTI_SWIER2:
+        s->swier[1] =3D value & ACTIVABLE_xR2;
+        for (int i =3D 0; i < 8; i++) {
+            const uint32_t mask =3D 1 << i;
+            if (s->swier[1] & s->imr[1] & mask) {
+                s->pr[1] |=3D mask;
+                qemu_irq_raise(s->irq[32 + i]);
+            }
+        }
+        return;
+    case EXTI_PR2:
+        /* This bit is cleared by writing a 1 to it */
+        s->pr[1] &=3D ~value | ~ACTIVABLE_xR2;
+        /* Don't forget to clean software interrupts */
+        s->swier[1] &=3D ~value | ~ACTIVABLE_xR2;
+        for (int i =3D 0; i < 8; i++) {
+            const uint32_t mask =3D 1 << i;
+            if (!(s->pr[1] & mask)) {
+                qemu_irq_lower(s->irq[32 + i]);
+            }
+        }
+        return;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "STM32L4X5_exti_write: Bad offset 0x%x\n", (int)addr);
+    }
+}
+
+static const MemoryRegionOps stm32l4x5_exti_ops =3D {
+    .read =3D stm32l4x5_exti_read,
+    .write =3D stm32l4x5_exti_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl.min_access_size =3D 4,
+    .impl.max_access_size =3D 4,
+    .impl.unaligned =3D false,
+    .valid.min_access_size =3D 4,
+    .valid.max_access_size =3D 4,
+    .valid.unaligned =3D false,
+};
+
+static void stm32l4x5_exti_init(Object *obj)
+{
+    Stm32l4x5ExtiState *s =3D STM32L4X5_EXTI(obj);
+    int i;
+
+    for (i =3D 0; i < EXTI_NUM_INTERRUPT_OUT_LINES; i++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[i]);
+    }
+
+    memory_region_init_io(&s->mmio, obj, &stm32l4x5_exti_ops, s,
+                          TYPE_STM32L4X5_EXTI, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+    qdev_init_gpio_in(DEVICE(obj), stm32l4x5_exti_set_irq,
+                      EXTI_NUM_GPIO_EVENT_IN_LINES);
+}
+
+static const VMStateDescription vmstate_stm32l4x5_exti =3D {
+    .name =3D TYPE_STM32L4X5_EXTI,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(imr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
+        VMSTATE_UINT32_ARRAY(emr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
+        VMSTATE_UINT32_ARRAY(rtsr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
+        VMSTATE_UINT32_ARRAY(ftsr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
+        VMSTATE_UINT32_ARRAY(swier, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
+        VMSTATE_UINT32_ARRAY(pr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void stm32l4x5_exti_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+
+    dc->vmsd =3D &vmstate_stm32l4x5_exti;
+    rc->phases.hold =3D stm32l4x5_exti_reset_hold;
+}
+
+static const TypeInfo stm32l4x5_exti_types[] =3D {
+    {
+        .name          =3D TYPE_STM32L4X5_EXTI,
+        .parent        =3D TYPE_SYS_BUS_DEVICE,
+        .instance_size =3D sizeof(Stm32l4x5ExtiState),
+        .instance_init =3D stm32l4x5_exti_init,
+        .class_init    =3D stm32l4x5_exti_class_init,
+    }
+};
+
+DEFINE_TYPES(stm32l4x5_exti_types)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 05ff692441..2f01c62c0e 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -163,6 +163,11 @@ stm32f4xx_exti_set_irq(int irq, int level) "Set EXTI: %d=
 to %d"
 stm32f4xx_exti_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
 stm32f4xx_exti_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PR=
Ix64 " val: 0x%" PRIx64 ""
=20
+# stm32l4x5_exti.c
+stm32l4x5_exti_set_irq(int irq, int level) "Set EXTI: %d to %d"
+stm32l4x5_exti_read(uint64_t addr, uint64_t data) "reg read: addr: 0x%" PRIx=
64 " val: 0x%" PRIx64 ""
+stm32l4x5_exti_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PR=
Ix64 " val: 0x%" PRIx64 ""
+
 # tz-mpc.c
 tz_mpc_reg_read(uint32_t offset, uint64_t data, unsigned size) "TZ MPC regs =
read: offset 0x%x data 0x%" PRIx64 " size %u"
 tz_mpc_reg_write(uint32_t offset, uint64_t data, unsigned size) "TZ MPC regs=
 write: offset 0x%x data 0x%" PRIx64 " size %u"
diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_soc.h
index ab61c4b8a1..940941598e 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -32,6 +32,7 @@
 #include "qemu/units.h"
 #include "hw/qdev-core.h"
 #include "hw/arm/armv7m.h"
+#include "hw/misc/stm32l4x5_exti.h"
 #include "qom/object.h"
=20
 #define TYPE_STM32L4X5_SOC "stm32l4x5-soc"
@@ -45,6 +46,8 @@ struct Stm32l4x5SocState {
=20
     ARMv7MState armv7m;
=20
+    Stm32l4x5ExtiState exti;
+
     MemoryRegion sram1;
     MemoryRegion sram2;
     MemoryRegion flash;
diff --git a/include/hw/misc/stm32l4x5_exti.h b/include/hw/misc/stm32l4x5_ext=
i.h
new file mode 100644
index 0000000000..89b3e33b6b
--- /dev/null
+++ b/include/hw/misc/stm32l4x5_exti.h
@@ -0,0 +1,58 @@
+/*
+ * STM32L4x5 EXTI (Extended interrupts and events controller)
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: MIT
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a c=
opy
+ * of this software and associated documentation files (the "Software"), to =
deal
+ * in the Software without restriction, including without limitation the rig=
hts
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
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING F=
ROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+/* stm32l4x5_exti implementation is derived from stm32f4xx_exti */
+
+#ifndef HW_STM32L4X5_EXTI_H
+#define HW_STM32L4X5_EXTI_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_STM32L4X5_EXTI "stm32l4x5-exti"
+OBJECT_DECLARE_SIMPLE_TYPE(Stm32l4x5ExtiState, STM32L4X5_EXTI)
+
+#define EXTI_NUM_INTERRUPT_OUT_LINES 40
+#define EXTI_NUM_REGISTER 2
+
+struct Stm32l4x5ExtiState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t imr[EXTI_NUM_REGISTER];
+    uint32_t emr[EXTI_NUM_REGISTER];
+    uint32_t rtsr[EXTI_NUM_REGISTER];
+    uint32_t ftsr[EXTI_NUM_REGISTER];
+    uint32_t swier[EXTI_NUM_REGISTER];
+    uint32_t pr[EXTI_NUM_REGISTER];
+
+    qemu_irq irq[EXTI_NUM_INTERRUPT_OUT_LINES];
+};
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c9945e69b1..bc62f201a8 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -194,6 +194,10 @@ qtests_aspeed =3D \
   ['aspeed_hace-test',
    'aspeed_smc-test',
    'aspeed_gpio-test']
+
+qtests_stm32l4x5 =3D \
+  ['stm32l4x5_exti-test']
+
 qtests_arm =3D \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-du=
altimer-test'] : []) + \
@@ -207,6 +211,7 @@ qtests_arm =3D \
   (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] :=
 []) + \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []=
) + \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) +=
 \
+  (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : [=
]) + \
   ['arm-cpu-features',
    'boot-serial-test']
=20
diff --git a/tests/qtest/stm32l4x5_exti-test.c b/tests/qtest/stm32l4x5_exti-t=
est.c
new file mode 100644
index 0000000000..b165111579
--- /dev/null
+++ b/tests/qtest/stm32l4x5_exti-test.c
@@ -0,0 +1,104 @@
+/*
+ * QTest testcase for STML4XX_EXTI
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+#define EXTI_BASE_ADDR 0x40010400
+#define EXTI_IMR1 0x00
+#define EXTI_EMR1 0x04
+#define EXTI_RTSR1 0x08
+#define EXTI_FTSR1 0x0C
+#define EXTI_SWIER1 0x10
+#define EXTI_PR1 0x14
+#define EXTI_IMR2 0x20
+#define EXTI_EMR2 0x24
+#define EXTI_RTSR2 0x28
+#define EXTI_FTSR2 0x2C
+#define EXTI_SWIER2 0x30
+#define EXTI_PR2 0x34
+
+#define GPIO_0_IRQ 6
+
+static void exti_writel(unsigned int offset, uint32_t value)
+{
+    writel(EXTI_BASE_ADDR + offset, value);
+}
+
+static uint32_t exti_readl(unsigned int offset)
+{
+    return readl(EXTI_BASE_ADDR + offset);
+}
+
+static void test_write_read(void)
+{
+    /* Test that we can write and retrieve a value from the device */
+    exti_writel(EXTI_IMR1, 0xFFFFFFFF);
+    const uint32_t imr1 =3D exti_readl(EXTI_IMR1);
+    g_assert_cmpuint(imr1, =3D=3D, 0xFFFFFFFF);
+
+    /* Test that reserved address are not written to */
+    exti_writel(EXTI_IMR2, 0xFFFFFFFF);
+    const uint32_t imr2 =3D exti_readl(EXTI_IMR2);
+    g_assert_cmpuint(imr2, =3D=3D, 0x000000FF);
+}
+
+static void test_direct_lines_write(void)
+{
+    /* Test that Direct Lines are not written to */
+    exti_writel(EXTI_RTSR2, 0xFFFFFFFF);
+    const uint32_t rtsr2 =3D exti_readl(EXTI_RTSR2);
+    g_assert_cmpuint(rtsr2, =3D=3D, 0x00000078);
+}
+
+static void test_software_interrupt(void)
+{
+    /* Test that we can launch irq using software in*/
+
+    g_assert_false(get_irq(GPIO_0_IRQ));
+    /* Bit 0 corresponds to GPIO Px_0 */
+    exti_writel(EXTI_IMR1, 0x00000001);
+    exti_writel(EXTI_SWIER1, 0x00000001);
+    uint32_t swier1 =3D exti_readl(EXTI_SWIER1);
+    uint32_t pr1 =3D exti_readl(EXTI_PR1);
+
+    g_assert_cmpuint(swier1, =3D=3D, 0x00000001);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000001);
+
+    g_assert_true(get_irq(GPIO_0_IRQ));
+
+    /* Reset the irq and check the registers state */
+    exti_writel(EXTI_PR1, 0x00000001);
+    swier1 =3D exti_readl(EXTI_SWIER1);
+    pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(swier1, =3D=3D, 0x00000000);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+    g_test_set_nonfatal_assertions();
+
+    qtest_add_func("stm32l4x5/exti/write_read", test_write_read);
+    qtest_add_func("stm32l4x5/exti/direct_lines_write", test_direct_lines_wr=
ite);
+    /* Fails for now, not implemented */
+    qtest_add_func("stm32l4x5/exti/software_interrupt", test_software_interr=
upt);
+
+    qtest_start("-machine b-l475e-iot01a");
+    /* The qom path is correct but does it do anything ?*/
+    qtest_irq_intercept_in(global_qtest, "/machine/unattached/device[0]/exti=
");
+    ret =3D g_test_run();
+    qtest_end();
+
+    return ret;
+}
--=20
2.38.5

