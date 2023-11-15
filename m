Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E007EBEB1
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 09:40:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3BQX-0004ad-V4; Wed, 15 Nov 2023 03:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1r3BDb-00060L-Cf
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 03:25:52 -0500
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1r3BDK-00088z-Ig
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 03:25:51 -0500
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 162FF11F015;
 Wed, 15 Nov 2023 08:25:33 +0000 (UTC)
From: ~inesvarhol <inesvarhol@git.sr.ht>
Date: Wed, 15 Nov 2023 08:59:28 +0100
Subject: [PATCH RFC 1/2] hw/arm: Add minimal support for the STM32L475VG SoC
MIME-Version: 1.0
Message-ID: <170003673257.14701.8139061802716120109-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <170003673257.14701.8139061802716120109-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 15 Nov 2023 03:39:09 -0500
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

This patch adds a new STM32L475VG SoC, it is necessary to add support for
the B-L475E-IOT01A board.
The implementation is derived from the STM32F405 SoC.
The implementation contains no peripherals, only memory regions are
implemented.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/arm/Kconfig                   |   5 +
 hw/arm/meson.build               |   1 +
 hw/arm/stm32l475vg_soc.c         | 241 +++++++++++++++++++++++++++++++
 include/hw/arm/stm32l475vg_soc.h |  60 ++++++++
 4 files changed, 307 insertions(+)
 create mode 100644 hw/arm/stm32l475vg_soc.c
 create mode 100644 include/hw/arm/stm32l475vg_soc.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3ada335a24..763510afeb 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -448,6 +448,11 @@ config STM32F405_SOC
     select STM32F4XX_SYSCFG
     select STM32F4XX_EXTI
=20
+config STM32L475VG_SOC
+    bool
+    select ARM_V7M
+    select OR_IRQ
+
 config XLNX_ZYNQMP_ARM
     bool
     default y if PIXMAN
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 68245d3ad1..6b2e1228e5 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -42,6 +42,7 @@ arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c'=
, 'raspi.c'))
 arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
+arm_ss.add(when: 'CONFIG_STM32L475VG_SOC', if_true: files('stm32l475vg_soc.c=
'))
 arm_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp.c', '=
xlnx-zcu102.c'))
 arm_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', 'xlnx=
-versal-virt.c'))
 arm_ss.add(when: 'CONFIG_FSL_IMX25', if_true: files('fsl-imx25.c', 'imx25_pd=
k.c'))
diff --git a/hw/arm/stm32l475vg_soc.c b/hw/arm/stm32l475vg_soc.c
new file mode 100644
index 0000000000..7dd5d70eb3
--- /dev/null
+++ b/hw/arm/stm32l475vg_soc.c
@@ -0,0 +1,241 @@
+/*
+ * STM32L475VG SoC
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
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
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
+#include "hw/arm/stm32l475vg_soc.h"
+#include "hw/qdev-clock.h"
+#include "hw/misc/unimp.h"
+
+/* stm32l475vg_soc implementation is derived from stm32f405_soc */
+
+static void stm32l475vg_soc_initfn(Object *obj)
+{
+    STM32L475VGState *s =3D STM32L475VG_SOC(obj);
+
+    object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
+
+    s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
+    s->refclk =3D qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
+}
+
+static void stm32l475vg_soc_realize(DeviceState *dev_soc, Error **errp)
+{
+    STM32L475VGState *s =3D STM32L475VG_SOC(dev_soc);
+    MemoryRegion *system_memory =3D get_system_memory();
+    DeviceState *armv7m;
+    Error *err =3D NULL;
+
+    /*
+     * We use s->refclk internally and only define it with qdev_init_clock_i=
n()
+     * so it is correctly parented and not leaked on an init/deinit; it is n=
ot
+     * intended as an externally exposed clock.
+     */
+    if (clock_has_source(s->refclk)) {
+        error_setg(errp, "refclk clock must not be wired up by the board cod=
e");
+        return;
+    }
+
+    if (!clock_has_source(s->sysclk)) {
+        error_setg(errp, "sysclk clock must be wired up by the board code");
+        return;
+    }
+
+    /*
+     * TODO: ideally we should model the SoC RCC and its ability to
+     * change the sysclk frequency and define different sysclk sources.
+     */
+
+    /* The refclk always runs at frequency HCLK / 8 */
+    clock_set_mul_div(s->refclk, 8, 1);
+    clock_set_source(s->refclk, s->sysclk);
+
+    memory_region_init_rom(&s->flash, OBJECT(dev_soc), "STM32L475VG.flash",
+                           FLASH_SIZE, &err);
+    if (err !=3D NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_init_alias(&s->flash_alias, OBJECT(dev_soc),
+                             "STM32L475VG.flash.alias", &s->flash, 0,
+                             FLASH_SIZE);
+
+    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash=
);
+    memory_region_add_subregion(system_memory, 0, &s->flash_alias);
+
+    memory_region_init_ram(&s->sram1, NULL, "STM32L475VG.sram1", SRAM1_SIZE,
+                           &err);
+    if (err !=3D NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_add_subregion(system_memory, SRAM1_BASE_ADDRESS, &s->sram1=
);
+
+    memory_region_init_ram(&s->sram2, NULL, "STM32L475VG.sram2", SRAM2_SIZE,
+                           &err);
+    if (err !=3D NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_add_subregion(system_memory, SRAM2_BASE_ADDRESS, &s->sram2=
);
+
+    armv7m =3D DEVICE(&s->armv7m);
+    qdev_prop_set_uint32(armv7m, "num-irq", 96);
+    qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
+    qdev_prop_set_bit(armv7m, "enable-bitband", true);
+    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
+    qdev_connect_clock_in(armv7m, "refclk", s->refclk);
+    object_property_set_link(OBJECT(&s->armv7m), "memory",
+                             OBJECT(system_memory), &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
+        return;
+    }
+
+    /* APB1 BUS */
+    create_unimplemented_device("TIM2",      0x40000000, 0x400);
+    create_unimplemented_device("TIM3",      0x40000400, 0x400);
+    create_unimplemented_device("TIM4",      0x40000800, 0x400);
+    create_unimplemented_device("TIM5",      0x40000C00, 0x400);
+    create_unimplemented_device("TIM6",      0x40001000, 0x400);
+    create_unimplemented_device("TIM7",      0x40001400, 0x400);
+    /* RESERVED:    0x40001800, 0x1000 */
+    create_unimplemented_device("RTC",       0x40002800, 0x400);
+    create_unimplemented_device("WWDG",      0x40002C00, 0x400);
+    create_unimplemented_device("IWDG",      0x40003000, 0x400);
+    /* RESERVED:    0x40001800, 0x400 */
+    create_unimplemented_device("SPI2",      0x40003800, 0x400);
+    create_unimplemented_device("SPI3",      0x40003C00, 0x400);
+    /* RESERVED:    0x40004000, 0x400 */
+    create_unimplemented_device("USART2",    0x40004400, 0x400);
+    create_unimplemented_device("USART3",    0x40004800, 0x400);
+    create_unimplemented_device("UART4",     0x40004C00, 0x400);
+    create_unimplemented_device("UART5",     0x40005000, 0x400);
+    create_unimplemented_device("I2C1",      0x40005400, 0x400);
+    create_unimplemented_device("I2C2",      0x40005800, 0x400);
+    create_unimplemented_device("I2C3",      0x40005C00, 0x400);
+    /* RESERVED:    0x40006000, 0x400 */
+    create_unimplemented_device("CAN1",      0x40006400, 0x400);
+    /* RESERVED:    0x40006800, 0x400 */
+    create_unimplemented_device("PWR",       0x40007000, 0x400);
+    create_unimplemented_device("DAC1",      0x40007400, 0x400);
+    create_unimplemented_device("OPAMP",     0x40007800, 0x400);
+    create_unimplemented_device("LPTIM1",    0x40007C00, 0x400);
+    create_unimplemented_device("LPUART1",   0x40008000, 0x400);
+    /* RESERVED:    0x40008400, 0x400 */
+    create_unimplemented_device("SWPMI1",    0x40008800, 0x400);
+    /* RESERVED:    0x40008C00, 0x800 */
+    create_unimplemented_device("LPTIM2",    0x40009400, 0x400);
+    /* RESERVED:    0x40009800, 0x6800 */
+
+    /* APB2 BUS */
+    create_unimplemented_device("SYSCFG",    0x40010000, 0x30);
+    create_unimplemented_device("VREFBUF",   0x40010030, 0x1D0);
+    create_unimplemented_device("COMP",      0x40010200, 0x200);
+    create_unimplemented_device("EXTI",      0x40010400, 0x400);
+    /* RESERVED:    0x40010800, 0x1400 */
+    create_unimplemented_device("FIREWALL",  0x40011C00, 0x400);
+    /* RESERVED:    0x40012000, 0x800 */
+    create_unimplemented_device("SDMMC1",    0x40012800, 0x400);
+    create_unimplemented_device("TIM1",      0x40012C00, 0x400);
+    create_unimplemented_device("SPI1",      0x40013000, 0x400);
+    create_unimplemented_device("TIM8",      0x40013400, 0x400);
+    create_unimplemented_device("USART1",    0x40013800, 0x400);
+    /* RESERVED:    0x40013C00, 0x400 */
+    create_unimplemented_device("TIM15",     0x40014000, 0x400);
+    create_unimplemented_device("TIM16",     0x40014400, 0x400);
+    create_unimplemented_device("TIM17",     0x40014800, 0x400);
+    /* RESERVED:    0x40014C00, 0x800 */
+    create_unimplemented_device("SAI1",      0x40015400, 0x400);
+    create_unimplemented_device("SAI2",      0x40015800, 0x400);
+    /* RESERVED:    0x40015C00, 0x400 */
+    create_unimplemented_device("DFSDM1",    0x40016000, 0x400);
+    /* RESERVED:    0x40016400, 0x9C00 */
+
+    /* AHB1 BUS */
+    create_unimplemented_device("DMA1",      0x40020000, 0x400);
+    create_unimplemented_device("DMA2",      0x40020400, 0x400);
+    /* RESERVED:    0x40020800, 0x800 */
+    create_unimplemented_device("RCC",       0x40021000, 0x400);
+    /* RESERVED:    0x40021400, 0xC00 */
+    create_unimplemented_device("FLASH",     0x40022000, 0x400);
+    /* RESERVED:    0x40022400, 0xC00 */
+    create_unimplemented_device("CRC",       0x40023000, 0x400);
+    /* RESERVED:    0x40023400, 0x400 */
+    create_unimplemented_device("TSC",       0x40024000, 0x400);
+
+    /* RESERVED:    0x40024400, 0x7FDBC00 */
+
+    /* AHB2 BUS */
+    create_unimplemented_device("GPIOA",     0x48000000, 0x400);
+    create_unimplemented_device("GPIOB",     0x48000400, 0x400);
+    create_unimplemented_device("GPIOC",     0x48000800, 0x400);
+    create_unimplemented_device("GPIOD",     0x48000C00, 0x400);
+    create_unimplemented_device("GPIOE",     0x48001000, 0x400);
+    create_unimplemented_device("GPIOF",     0x48001400, 0x400);
+    create_unimplemented_device("GPIOG",     0x48001800, 0x400);
+    create_unimplemented_device("GPIOH",     0x48001C00, 0x400);
+    /* RESERVED:    0x48002000, 0x7FDBC00 */
+    create_unimplemented_device("OTG_FS",    0x50000000, 0x40000);
+    create_unimplemented_device("ADC",       0x50040000, 0x400);
+    /* RESERVED:    0x50040400, 0x20400 */
+    create_unimplemented_device("RNG",       0x50060800, 0x400);
+
+    /* AHB3 BUS */
+    create_unimplemented_device("FMC",       0xA0000000, 0x1000);
+    create_unimplemented_device("QUADSPI",   0xA0001000, 0x400);
+}
+
+static Property stm32l475vg_soc_properties[] =3D {
+    DEFINE_PROP_STRING("cpu-type", STM32L475VGState, cpu_type),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void stm32l475vg_soc_class_init(ObjectClass *klass, void *data)
+{
+
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D stm32l475vg_soc_realize;
+    device_class_set_props(dc, stm32l475vg_soc_properties);
+    /* No vmstate or reset required: device has no internal state */
+}
+
+static const TypeInfo stm32l475vg_soc_info =3D {
+    .name          =3D TYPE_STM32L475VG_SOC,
+    .parent        =3D TYPE_DEVICE,
+    .instance_size =3D sizeof(STM32L475VGState),
+    .instance_init =3D stm32l475vg_soc_initfn,
+    .class_init    =3D stm32l475vg_soc_class_init,
+};
+
+static void stm32l475vg_soc_register_types(void)
+{
+    type_register_static(&stm32l475vg_soc_info);
+}
+
+type_init(stm32l475vg_soc_register_types)
diff --git a/include/hw/arm/stm32l475vg_soc.h b/include/hw/arm/stm32l475vg_so=
c.h
new file mode 100644
index 0000000000..a224cb6384
--- /dev/null
+++ b/include/hw/arm/stm32l475vg_soc.h
@@ -0,0 +1,60 @@
+/*
+ * STM32L475VG SoC
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
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
+#ifndef HW_ARM_STM32L475VG_SOC_H
+#define HW_ARM_STM32L475VG_SOC_H
+
+#include "hw/arm/armv7m.h"
+#include "qom/object.h"
+
+#define TYPE_STM32L475VG_SOC "stm32l475vg-soc"
+OBJECT_DECLARE_SIMPLE_TYPE(STM32L475VGState, STM32L475VG_SOC)
+
+#define FLASH_BASE_ADDRESS 0x08000000
+#define FLASH_SIZE (1024 * 1024)
+#define SRAM1_BASE_ADDRESS 0x20000000
+#define SRAM1_SIZE (96 * 1024)
+#define SRAM2_BASE_ADDRESS 0x10000000
+#define SRAM2_SIZE (32 * 1024)
+
+struct STM32L475VGState {
+    /*< private >*/
+    DeviceState parent_obj;
+    /*< public >*/
+
+    char *cpu_type;
+
+    ARMv7MState armv7m;
+
+    MemoryRegion sram1;
+    MemoryRegion sram2;
+    MemoryRegion flash;
+    MemoryRegion flash_alias;
+
+    Clock *sysclk;
+    Clock *refclk;
+};
+
+#endif
--=20
2.38.5


