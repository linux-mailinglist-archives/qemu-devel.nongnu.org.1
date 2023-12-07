Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CEF8169B2
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 10:19:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF9lg-0003Ij-Gf; Mon, 18 Dec 2023 04:18:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1rF9lQ-0003AV-Aq; Mon, 18 Dec 2023 04:18:21 -0500
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1rF9lN-00005T-LZ; Mon, 18 Dec 2023 04:18:15 -0500
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 8E09311EFBF;
 Mon, 18 Dec 2023 09:18:10 +0000 (UTC)
From: ~inesvarhol <inesvarhol@git.sr.ht>
Date: Thu, 07 Dec 2023 20:56:51 +0100
Subject: [PATCH qemu v3 1/3] hw/misc: Implement STM32L4x5 EXTI
MIME-Version: 1.0
Message-ID: <170289109015.23396.9428181315206234398-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <170289109015.23396.9428181315206234398-0@git.sr.ht>
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
Reply-To: ~inesvarhol <inesvarhol@proton.me>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

Although very similar to the STM32F4xx EXTI, STM32L4x5 EXTI generates
more than 32 event/interrupt requests and thus uses more registers
than STM32F4xx EXTI which generates 23 event/interrupt requests.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/misc/Kconfig                  |   3 +
 hw/misc/meson.build              |   1 +
 hw/misc/stm32l4x5_exti.c         | 289 +++++++++++++++++++++++++++++++
 hw/misc/trace-events             |   5 +
 include/hw/misc/stm32l4x5_exti.h |  51 ++++++
 5 files changed, 349 insertions(+)
 create mode 100644 hw/misc/stm32l4x5_exti.c
 create mode 100644 include/hw/misc/stm32l4x5_exti.h

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
index 0000000000..9037740161
--- /dev/null
+++ b/hw/misc/stm32l4x5_exti.c
@@ -0,0 +1,289 @@
+/*
+ * STM32L4x5 EXTI (Extended interrupts and events controller)
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
+ * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * This work is based on the stm32f4xx_exti by Alistair Francis.
+ * Original code is licensed under the MIT License:
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
+ */
+
+/*
+ * The reference used is the STMicroElectronics RM0351 Reference manual
+ * for STM32L4x5 and STM32L4x6 advanced Arm =C2=AE -based 32-bit MCUs.
+ * https://www.st.com/en/microcontrollers-microprocessors/stm32l4x5/document=
ation.html
+ */
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
+#define RESERVED_BITS_MASK2 0xFFFFFF00
+
+/* 0b00000000_00000000_00000000_01111000 */
+#define ACTIVABLE_MASK2 (~DIRECT_LINE_MASK2 & ~RESERVED_BITS_MASK2)
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
+    /* If the interrupt is masked, pr won't be raised */
+    if (!((1 << irq) & s->imr[n])) {
+        return;
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
+        const uint32_t set1 =3D value & ~DIRECT_LINE_MASK1;
+        const uint32_t pend1 =3D set1 & ~s->swier[0] & s->imr[0] & ~s->pr[0];
+        s->swier[0] =3D set1;
+        s->pr[0] |=3D pend1;
+        for (int i =3D 0; i < 32; i++) {
+            if (pend1 & (1 << i)) {
+                qemu_irq_pulse(s->irq[i]);
+            }
+        }
+        return;
+    case EXTI_PR1:
+        const uint32_t cleared1 =3D s->pr[0] & value & ~DIRECT_LINE_MASK1;
+        /* This bit is cleared by writing a 1 to it */
+        s->pr[0] &=3D ~cleared1;
+        /* Software triggered interrupts are cleared as well */
+        s->swier[0] &=3D ~cleared1;
+        return;
+    case EXTI_IMR2:
+        s->imr[1] =3D value & ~RESERVED_BITS_MASK2;
+        return;
+    case EXTI_EMR2:
+        s->emr[1] =3D value & ~RESERVED_BITS_MASK2;
+        return;
+    case EXTI_RTSR2:
+        s->rtsr[1] =3D value & ACTIVABLE_MASK2;
+        return;
+    case EXTI_FTSR2:
+        s->ftsr[1] =3D value & ACTIVABLE_MASK2;
+        return;
+    case EXTI_SWIER2:
+        const uint32_t set2 =3D value & ACTIVABLE_MASK2;
+        const uint32_t pend2 =3D set2 & ~s->swier[1] & s->imr[1] & ~s->pr[1];
+        s->swier[1] =3D set2;
+        s->pr[1] |=3D pend2;
+        for (int i =3D 0; i < 8; i++) {
+            if (pend2 & (1 << i)) {
+                qemu_irq_pulse(s->irq[32 + i]);
+            }
+        }
+        return;
+    case EXTI_PR2:
+        const uint32_t cleared =3D s->pr[1] & value & ACTIVABLE_MASK2;
+        /* This bit is cleared by writing a 1 to it */
+        s->pr[1] &=3D ~cleared;
+        /* Software triggered interrupts are cleared as well */
+        s->swier[1] &=3D ~cleared;
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
diff --git a/include/hw/misc/stm32l4x5_exti.h b/include/hw/misc/stm32l4x5_ext=
i.h
new file mode 100644
index 0000000000..be961d2f01
--- /dev/null
+++ b/include/hw/misc/stm32l4x5_exti.h
@@ -0,0 +1,51 @@
+/*
+ * STM32L4x5 EXTI (Extended interrupts and events controller)
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * This work is based on the stm32f4xx_exti by Alistair Francis.
+ * Original code is licensed under the MIT License:
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
+ */
+
+/*
+ * The reference used is the STMicroElectronics RM0351 Reference manual
+ * for STM32L4x5 and STM32L4x6 advanced Arm =C2=AE -based 32-bit MCUs.
+ * https://www.st.com/en/microcontrollers-microprocessors/stm32l4x5/document=
ation.html
+ */
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
--=20
2.38.5


