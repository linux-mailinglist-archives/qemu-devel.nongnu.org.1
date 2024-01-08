Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C2B82770C
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:12:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMu5v-00053C-3w; Mon, 08 Jan 2024 13:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rMu5k-0004wP-Pf; Mon, 08 Jan 2024 13:11:16 -0500
Received: from zproxy1.enst.fr ([137.194.2.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rMu5h-0003Eu-PQ; Mon, 08 Jan 2024 13:11:16 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 5FB62C0738;
 Mon,  8 Jan 2024 19:11:11 +0100 (CET)
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id 0coPSbjJ32Mx; Mon,  8 Jan 2024 19:11:10 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id DBADFC0C9E;
 Mon,  8 Jan 2024 19:11:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy1.enst.fr DBADFC0C9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1704737470;
 bh=Ca6hmgpPbhemvhYSfPCbopjCGJJMtOpR4HF5RyCauW4=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=0koDAMT3we7Q5awTLb5xR7VkaqsNZuW+t0C83WOiJCPC6KAv1QeDrwKKVO0upZPr2
 XP0I6iBwVHIoJlp9LDjtgyBOT6EX2E+m73/RXIYxmyO0voQq8ob/hP8ihcPykK9Nj4
 e+4nR7kr5IsR+qFQgsRFvOkusuFPvHIdU6Li+qwc=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id v6dZl3IwogHH; Mon,  8 Jan 2024 19:11:10 +0100 (CET)
Received: from localhost.localdomain (74.0.125.80.rev.sfr.net [80.125.0.74])
 by zproxy1.enst.fr (Postfix) with ESMTPSA id 868FAC0655;
 Mon,  8 Jan 2024 19:11:10 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-arm@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 2/3] hw/arm: Connect STM32L4x5 EXTI to STM32L4x5 SoC
Date: Mon,  8 Jan 2024 19:03:05 +0100
Message-ID: <20240108181104.46880-3-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108181104.46880-1-ines.varhol@telecom-paris.fr>
References: <20240108181104.46880-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.220;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy1.enst.fr
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

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/arm/Kconfig                 |  1 +
 hw/arm/stm32l4x5_soc.c         | 52 +++++++++++++++++++++++++++++++++-
 include/hw/arm/stm32l4x5_soc.h |  3 ++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4ae2073a1d..8c8488a70a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -459,6 +459,7 @@ config STM32L4X5_SOC
     bool
     select ARM_V7M
     select OR_IRQ
+    select STM32L4X5_EXTI
=20
 config XLNX_ZYNQMP_ARM
     bool
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index 70609a6dac..fe46b7c6c0 100644
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
@@ -51,6 +92,7 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc,=
 Error **errp)
     const Stm32l4x5SocClass *sc =3D STM32L4X5_SOC_GET_CLASS(dev_soc);
     MemoryRegion *system_memory =3D get_system_memory();
     DeviceState *armv7m;
+    SysBusDevice *busdev;
=20
     /*
      * We use s->refclk internally and only define it with qdev_init_clo=
ck_in()
@@ -112,6 +154,15 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
         return;
     }
=20
+    busdev =3D SYS_BUS_DEVICE(&s->exti);
+    if (!sysbus_realize(busdev, errp)) {
+        return;
+    }
+    sysbus_mmio_map(busdev, 0, EXTI_ADDR);
+    for (unsigned i =3D 0; i < NUM_EXTI_IRQ; i++) {
+        sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[=
i]));
+    }
+
     /* APB1 BUS */
     create_unimplemented_device("TIM2",      0x40000000, 0x400);
     create_unimplemented_device("TIM3",      0x40000400, 0x400);
@@ -152,7 +203,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
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
index 2fd44a36a9..f7305568dc 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -26,6 +26,7 @@
=20
 #include "exec/memory.h"
 #include "hw/arm/armv7m.h"
+#include "hw/misc/stm32l4x5_exti.h"
 #include "qom/object.h"
=20
 #define TYPE_STM32L4X5_SOC "stm32l4x5-soc"
@@ -39,6 +40,8 @@ struct Stm32l4x5SocState {
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


