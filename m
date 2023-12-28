Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 557AF81F9E3
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 17:21:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIt7J-0006EJ-BA; Thu, 28 Dec 2023 11:20:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rIt7G-0006DX-Tb; Thu, 28 Dec 2023 11:20:14 -0500
Received: from zproxy3.enst.fr ([2001:660:330f:2::de])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rIt7C-0001zz-WF; Thu, 28 Dec 2023 11:20:14 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 17B99A064D;
 Thu, 28 Dec 2023 17:20:08 +0100 (CET)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id 3eT6bGbqhKi7; Thu, 28 Dec 2023 17:20:07 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id BA6FFA0587;
 Thu, 28 Dec 2023 17:20:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr BA6FFA0587
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1703780407;
 bh=XvTjD0GhPhtqUzN/jUsJejFiQl5qsoGcE2fMfXRqCzM=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=6qkAjf6Xvbv6fCmrI/hxg5FRxY29W1tHvBqsXNJKCYz3mdyj2VwHd1kMBkGGdutgl
 0YM1L5AE8GRypFFKgD0rbGBOCa39mMquNsKaFuHr2lL8grpzBzkHxcaBxxOz0gVnqY
 Z3nS8OoCuED871e8blAmua1Mp/LcHyT/rN06820E=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id TetmnZo-olaj; Thu, 28 Dec 2023 17:20:07 +0100 (CET)
Received: from inesv-Inspiron-3501.lan (unknown
 [IPv6:2001:861:4680:b1b0:3937:c54c:5417:70d4])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id 7BB5EA060A;
 Thu, 28 Dec 2023 17:20:07 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org
Subject: [PATCH v5 3/3] hw/arm: Connect STM32L4x5 EXTI to STM32L4x5 SoC
Date: Thu, 28 Dec 2023 17:19:21 +0100
Message-ID: <20231228161944.303768-4-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231228161944.303768-1-ines.varhol@telecom-paris.fr>
References: <20231228161944.303768-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::de;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy3.enst.fr
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

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/arm/Kconfig                 |  1 +
 hw/arm/stm32l4x5_soc.c         | 56 ++++++++++++++++++++++++++++++++--
 include/hw/arm/stm32l4x5_soc.h |  3 ++
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7520dc5cc0..9c9d5bb541 100644
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
index 7513db0d6a..08b8a4c2ed 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -36,10 +36,51 @@
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
     s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0)=
;
     s->refclk =3D qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0)=
;
 }
@@ -50,7 +91,9 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc,=
 Error **errp)
     Stm32l4x5SocState *s =3D STM32L4X5_SOC(dev_soc);
     const Stm32l4x5SocClass *sc =3D STM32L4X5_SOC_GET_CLASS(dev_soc);
     MemoryRegion *system_memory =3D get_system_memory();
-    DeviceState *armv7m;
+    DeviceState *dev, *armv7m;
+    SysBusDevice *busdev;
+    int i;
=20
     /*
      * We use s->refclk internally and only define it with qdev_init_clo=
ck_in()
@@ -115,6 +158,16 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
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
+        sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[=
i]));
+    }
+
     /* APB1 BUS */
     create_unimplemented_device("TIM2",      0x40000000, 0x400);
     create_unimplemented_device("TIM3",      0x40000400, 0x400);
@@ -155,7 +208,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
c, Error **errp)
     create_unimplemented_device("SYSCFG",    0x40010000, 0x30);
     create_unimplemented_device("VREFBUF",   0x40010030, 0x1D0);
     create_unimplemented_device("COMP",      0x40010200, 0x200);
-    create_unimplemented_device("EXTI",      0x40010400, 0x400);
     /* RESERVED:    0x40010800, 0x1400 */
     create_unimplemented_device("FIREWALL",  0x40011C00, 0x400);
     /* RESERVED:    0x40012000, 0x800 */
diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_so=
c.h
index dce13a023d..6cba566a31 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -28,6 +28,7 @@
 #include "qemu/units.h"
 #include "hw/qdev-core.h"
 #include "hw/arm/armv7m.h"
+#include "hw/misc/stm32l4x5_exti.h"
 #include "qom/object.h"
=20
 #define TYPE_STM32L4X5_SOC "stm32l4x5-soc"
@@ -41,6 +42,8 @@ struct Stm32l4x5SocState {
=20
     ARMv7MState armv7m;
=20
+    Stm32l4x5ExtiState exti;
+
     MemoryRegion sram1;
     MemoryRegion sram2;
     MemoryRegion flash;
--=20
2.43.0


