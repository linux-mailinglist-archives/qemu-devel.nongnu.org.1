Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A09AF828E16
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 20:46:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNI1x-000177-C8; Tue, 09 Jan 2024 14:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rNI1s-00013k-Jv; Tue, 09 Jan 2024 14:44:52 -0500
Received: from zproxy1.enst.fr ([2001:660:330f:2::dc])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rNI1q-0005cW-Rl; Tue, 09 Jan 2024 14:44:52 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 66503C0CFD;
 Tue,  9 Jan 2024 20:44:47 +0100 (CET)
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id 81Cf4C__5-gE; Tue,  9 Jan 2024 20:44:46 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id E3F4EC0CD2;
 Tue,  9 Jan 2024 20:44:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy1.enst.fr E3F4EC0CD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1704829486;
 bh=B65dkOf/+kXOox5G20nemGGXcnc+XKTCWEO5UiPJr8Y=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=04ZsbUpqDnCka6nyZHidLYJ42xgUOP+T7KrvRJJV8/JJyfVAOBf/A/YYB5nDJ/M8/
 FWZF0Eqy8ZaGhCO3jaakK1ri63aw0MS+mME0BavtAxH4Mo2lcu7GLWQ+r30ZYb8oyH
 2bUZGMapk7s/fM/DnL3zV7pbCDcb0cps2QiHP5TA=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id yhLcuAl0Teee; Tue,  9 Jan 2024 20:44:46 +0100 (CET)
Received: from localhost.localdomain (74.0.125.80.rev.sfr.net [80.125.0.74])
 by zproxy1.enst.fr (Postfix) with ESMTPSA id 549C8C0643;
 Tue,  9 Jan 2024 20:44:46 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v4 2/3] hw/arm: Connect STM32L4x5 SYSCFG to STM32L4x5 SoC
Date: Tue,  9 Jan 2024 20:41:58 +0100
Message-ID: <20240109194438.70934-3-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109194438.70934-1-ines.varhol@telecom-paris.fr>
References: <20240109194438.70934-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::dc;
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

The SYSCFG input GPIOs aren't connected yet. When the STM32L4x5 GPIO
device will be implemented, its output GPIOs will be connected to the
SYSCFG input GPIOs.

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/arm/Kconfig                 |  1 +
 hw/arm/stm32l4x5_soc.c         | 21 ++++++++++++++++++++-
 include/hw/arm/stm32l4x5_soc.h |  2 ++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 8c8488a70a..bb4693bfbb 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -459,6 +459,7 @@ config STM32L4X5_SOC
     bool
     select ARM_V7M
     select OR_IRQ
+    select STM32L4X5_SYSCFG
     select STM32L4X5_EXTI
=20
 config XLNX_ZYNQMP_ARM
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index fe46b7c6c0..431f982caf 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -37,6 +37,7 @@
 #define SRAM2_SIZE (32 * KiB)
=20
 #define EXTI_ADDR 0x40010400
+#define SYSCFG_ADDR 0x40010000
=20
 #define NUM_EXTI_IRQ 40
 /* Match exti line connections with their CPU IRQ number */
@@ -80,6 +81,7 @@ static void stm32l4x5_soc_initfn(Object *obj)
     Stm32l4x5SocState *s =3D STM32L4X5_SOC(obj);
=20
     object_initialize_child(obj, "exti", &s->exti, TYPE_STM32L4X5_EXTI);
+    object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32L4X5_SY=
SCFG);
=20
     s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0)=
;
     s->refclk =3D qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0)=
;
@@ -154,6 +156,19 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
         return;
     }
=20
+    /* System configuration controller */
+    busdev =3D SYS_BUS_DEVICE(&s->syscfg);
+    if (!sysbus_realize(busdev, errp)) {
+        return;
+    }
+    sysbus_mmio_map(busdev, 0, SYSCFG_ADDR);
+    /*
+     * TODO: when the GPIO device is implemented, connect it
+     * to SYCFG using `qdev_connect_gpio_out`, NUM_GPIOS and
+     * GPIO_NUM_PINS.
+     */
+
+    /* EXTI device */
     busdev =3D SYS_BUS_DEVICE(&s->exti);
     if (!sysbus_realize(busdev, errp)) {
         return;
@@ -163,6 +178,11 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
         sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[=
i]));
     }
=20
+    for (unsigned i =3D 0; i < 16; i++) {
+        qdev_connect_gpio_out(DEVICE(&s->syscfg), i,
+                              qdev_get_gpio_in(DEVICE(&s->exti), i));
+    }
+
     /* APB1 BUS */
     create_unimplemented_device("TIM2",      0x40000000, 0x400);
     create_unimplemented_device("TIM3",      0x40000400, 0x400);
@@ -200,7 +220,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
c, Error **errp)
     /* RESERVED:    0x40009800, 0x6800 */
=20
     /* APB2 BUS */
-    create_unimplemented_device("SYSCFG",    0x40010000, 0x30);
     create_unimplemented_device("VREFBUF",   0x40010030, 0x1D0);
     create_unimplemented_device("COMP",      0x40010200, 0x200);
     /* RESERVED:    0x40010800, 0x1400 */
diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_so=
c.h
index f7305568dc..baf70410b5 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -26,6 +26,7 @@
=20
 #include "exec/memory.h"
 #include "hw/arm/armv7m.h"
+#include "hw/misc/stm32l4x5_syscfg.h"
 #include "hw/misc/stm32l4x5_exti.h"
 #include "qom/object.h"
=20
@@ -41,6 +42,7 @@ struct Stm32l4x5SocState {
     ARMv7MState armv7m;
=20
     Stm32l4x5ExtiState exti;
+    Stm32l4x5SyscfgState syscfg;
=20
     MemoryRegion sram1;
     MemoryRegion sram2;
--=20
2.43.0


