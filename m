Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7058816C06
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:17:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBbD-00072r-CC; Mon, 18 Dec 2023 06:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1rFBb4-00071J-LP; Mon, 18 Dec 2023 06:15:42 -0500
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1rFBb2-0008IU-Oo; Mon, 18 Dec 2023 06:15:42 -0500
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 6881F11F00F;
 Mon, 18 Dec 2023 11:15:39 +0000 (UTC)
From: ~inesvarhol <inesvarhol@git.sr.ht>
Date: Sun, 10 Dec 2023 19:06:50 +0100
Subject: [PATCH qemu v2 3/3] hw/arm: Connect STM32L4x5 SYSCFG to STM32L4x5 SoC
MIME-Version: 1.0
Message-ID: <170289813862.19159.2545029501234884208-3@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <170289813862.19159.2545029501234884208-0@git.sr.ht>
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

The SYSCFG input GPIOs aren't connected yet. When the STM32L4x5 GPIO
device will be implemented, its output GPIOs will be connected to the
SYSCFG input GPIOs.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/arm/Kconfig                 |  1 +
 hw/arm/stm32l4x5_soc.c         | 23 ++++++++++++++++++++++-
 include/hw/arm/stm32l4x5_soc.h |  2 ++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 9c9d5bb541..e7c9470d59 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -458,6 +458,7 @@ config STM32L4X5_SOC
     bool
     select ARM_V7M
     select OR_IRQ
+    select STM32L4X5_SYSCFG
     select STM32L4X5_EXTI
=20
 config XLNX_ZYNQMP_ARM
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index b07593730f..45f5c2156c 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -46,6 +46,7 @@
 #define SRAM2_SIZE (32 * KiB)
=20
 #define EXTI_ADDR 0x40010400
+#define SYSCFG_ADDR 0x40010000
=20
 #define NUM_EXTI_IRQ 40
 /* Match exti line connections with their CPU IRQ number */
@@ -90,6 +91,8 @@ static void stm32l4x5_soc_initfn(Object *obj)
=20
     object_initialize_child(obj, "exti", &s->exti, TYPE_STM32L4X5_EXTI);
=20
+    object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32L4X5_SYSCFG=
);
+
     s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
     s->refclk =3D qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
 }
@@ -167,6 +170,20 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, =
Error **errp)
         return;
     }
=20
+    /* System configuration controller */
+    dev =3D DEVICE(&s->syscfg);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), errp)) {
+        return;
+    }
+    busdev =3D SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, SYSCFG_ADDR);
+    /*
+     * TODO: when the GPIO device is implemented, connect it
+     * to SYCFG using `qdev_connect_gpio_out`, NUM_GPIOS and
+     * GPIO_NUM_PINS.
+     */
+
+    /* EXTI device */
     dev =3D DEVICE(&s->exti);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->exti), errp)) {
         return;
@@ -177,6 +194,11 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, =
Error **errp)
         sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[i]));
     }
=20
+    for (i =3D 0; i < 16; i++) {
+        qdev_connect_gpio_out(DEVICE(&s->syscfg), i,
+                              qdev_get_gpio_in(dev, i));
+    }
+
     /* APB1 BUS */
     create_unimplemented_device("TIM2",      0x40000000, 0x400);
     create_unimplemented_device("TIM3",      0x40000400, 0x400);
@@ -214,7 +236,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, E=
rror **errp)
     /* RESERVED:    0x40009800, 0x6800 */
=20
     /* APB2 BUS */
-    create_unimplemented_device("SYSCFG",    0x40010000, 0x30);
     create_unimplemented_device("VREFBUF",   0x40010030, 0x1D0);
     create_unimplemented_device("COMP",      0x40010200, 0x200);
     /* RESERVED:    0x40010800, 0x1400 */
diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_soc.h
index ac47158596..230348f847 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -37,6 +37,7 @@
 #include "qemu/units.h"
 #include "hw/qdev-core.h"
 #include "hw/arm/armv7m.h"
+#include "hw/misc/stm32l4x5_syscfg.h"
 #include "hw/misc/stm32l4x5_exti.h"
 #include "qom/object.h"
=20
@@ -52,6 +53,7 @@ struct Stm32l4x5SocState {
     ARMv7MState armv7m;
=20
     Stm32l4x5ExtiState exti;
+    Stm32l4x5SyscfgState syscfg;
=20
     MemoryRegion sram1;
     MemoryRegion sram2;
--=20
2.38.5

