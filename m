Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A0C82C442
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 18:08:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOKze-0005KE-Nq; Fri, 12 Jan 2024 12:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rOKzc-0005IV-4U; Fri, 12 Jan 2024 12:06:52 -0500
Received: from zproxy2.enst.fr ([2001:660:330f:2::dd])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rOKzY-000502-4G; Fri, 12 Jan 2024 12:06:51 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 04B5880671;
 Fri, 12 Jan 2024 18:06:42 +0100 (CET)
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id LmHRbGSOLoUQ; Fri, 12 Jan 2024 18:06:41 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 66D758068A;
 Fri, 12 Jan 2024 18:06:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy2.enst.fr 66D758068A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1705079201;
 bh=cn7ApSHhwczTz1se066/yK/Z00PDt222NUbyzKhmpJw=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=gLXSl3OdGGgOfxW/CYqSHdUb0GWdXBY+G32xgAGyGeh8jKUBkshdf0mAXnO3onsT8
 TGtWlskt7Nko7HjYAh2birWrbEnVJUxtox9eqMedWU4bWm/zvsA1ZzhEVlxJKY6ULz
 QSi2jyy5ZAUNpDCbTZA522YPowhKu3KkoY3pNp6Q=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id CSsiRtljtgRT; Fri, 12 Jan 2024 18:06:41 +0100 (CET)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:240:fa97:9da:79c1:e167])
 by zproxy2.enst.fr (Postfix) with ESMTPSA id 30A7A806B7;
 Fri, 12 Jan 2024 18:06:41 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [RFC 2/3] hw/arm: Connect STM32L4x5 GPIO to STM32L4x5 SoC
Date: Fri, 12 Jan 2024 18:05:39 +0100
Message-ID: <20240112170635.303226-3-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112170635.303226-1-ines.varhol@telecom-paris.fr>
References: <20240112170635.303226-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::dd;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy2.enst.fr
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
 hw/arm/Kconfig                 |  3 +-
 hw/arm/stm32l4x5_soc.c         | 62 +++++++++++++++++++++++++++-------
 include/hw/arm/stm32l4x5_soc.h |  9 +++++
 3 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index bb4693bfbb..cb05147b64 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -459,8 +459,9 @@ config STM32L4X5_SOC
     bool
     select ARM_V7M
     select OR_IRQ
-    select STM32L4X5_SYSCFG
     select STM32L4X5_EXTI
+    select STM32L4X5_SYSCFG
+    select STM32L4X5_GPIO
=20
 config XLNX_ZYNQMP_ARM
     bool
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index 431f982caf..56a9a6affb 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -76,6 +76,17 @@ static const int exti_irq[NUM_EXTI_IRQ] =3D {
     78                      /* LCD wakeup, Direct      */
 };
=20
+static const uint32_t gpio_addr[] =3D {
+    0x48000000,
+    0x48000400,
+    0x48000800,
+    0x48000C00,
+    0x48001000,
+    0x48001400,
+    0x48001800,
+    0x48001C00,
+};
+
 static void stm32l4x5_soc_initfn(Object *obj)
 {
     Stm32l4x5SocState *s =3D STM32L4X5_SOC(obj);
@@ -83,6 +94,15 @@ static void stm32l4x5_soc_initfn(Object *obj)
     object_initialize_child(obj, "exti", &s->exti, TYPE_STM32L4X5_EXTI);
     object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32L4X5_SY=
SCFG);
=20
+    object_initialize_child(obj, "gpioa", &s->gpioa, TYPE_STM32L4X5_GPIO=
_A);
+    object_initialize_child(obj, "gpiob", &s->gpiob, TYPE_STM32L4X5_GPIO=
_B);
+    object_initialize_child(obj, "gpioc", &s->gpioc, TYPE_STM32L4X5_GPIO=
_C);
+    object_initialize_child(obj, "gpiod", &s->gpiod, TYPE_STM32L4X5_GPIO=
_D);
+    object_initialize_child(obj, "gpioe", &s->gpioe, TYPE_STM32L4X5_GPIO=
_E);
+    object_initialize_child(obj, "gpiof", &s->gpiof, TYPE_STM32L4X5_GPIO=
_F);
+    object_initialize_child(obj, "gpiog", &s->gpiog, TYPE_STM32L4X5_GPIO=
_G);
+    object_initialize_child(obj, "gpioh", &s->gpioh, TYPE_STM32L4X5_GPIO=
_H);
+
     s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0)=
;
     s->refclk =3D qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0)=
;
 }
@@ -95,6 +115,7 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc=
, Error **errp)
     MemoryRegion *system_memory =3D get_system_memory();
     DeviceState *armv7m;
     SysBusDevice *busdev;
+    uint32_t pin_index;
=20
     /*
      * We use s->refclk internally and only define it with qdev_init_clo=
ck_in()
@@ -156,17 +177,40 @@ static void stm32l4x5_soc_realize(DeviceState *dev_=
soc, Error **errp)
         return;
     }
=20
+    /* GPIOs */
+   const Stm32l4x5GpioState *gpios[] =3D {
+        &s->gpioa,
+        &s->gpiob,
+        &s->gpioc,
+        &s->gpiod,
+        &s->gpioe,
+        &s->gpiof,
+        &s->gpiog,
+        &s->gpioh,
+    };
+    for (unsigned i =3D 0; i < NUM_GPIOS; i++) {
+        busdev =3D SYS_BUS_DEVICE(gpios[i]);
+        if (!sysbus_realize(busdev, errp)) {
+            return;
+        }
+        sysbus_mmio_map(busdev, 0, gpio_addr[i]);
+    }
+
     /* System configuration controller */
     busdev =3D SYS_BUS_DEVICE(&s->syscfg);
     if (!sysbus_realize(busdev, errp)) {
         return;
     }
     sysbus_mmio_map(busdev, 0, SYSCFG_ADDR);
-    /*
-     * TODO: when the GPIO device is implemented, connect it
-     * to SYCFG using `qdev_connect_gpio_out`, NUM_GPIOS and
-     * GPIO_NUM_PINS.
-     */
+
+    for (unsigned i =3D 0; i < NUM_GPIOS; i++) {
+        for (unsigned j =3D 0; j < GPIO_NUM_PINS; j++) {
+            pin_index =3D GPIO_NUM_PINS * i + j;
+            qdev_connect_gpio_out(DEVICE(gpios[i]), j,
+                                  qdev_get_gpio_in(DEVICE(&s->syscfg),
+                                  pin_index));
+        }
+    }
=20
     /* EXTI device */
     busdev =3D SYS_BUS_DEVICE(&s->exti);
@@ -256,14 +300,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
     /* RESERVED:    0x40024400, 0x7FDBC00 */
=20
     /* AHB2 BUS */
-    create_unimplemented_device("GPIOA",     0x48000000, 0x400);
-    create_unimplemented_device("GPIOB",     0x48000400, 0x400);
-    create_unimplemented_device("GPIOC",     0x48000800, 0x400);
-    create_unimplemented_device("GPIOD",     0x48000C00, 0x400);
-    create_unimplemented_device("GPIOE",     0x48001000, 0x400);
-    create_unimplemented_device("GPIOF",     0x48001400, 0x400);
-    create_unimplemented_device("GPIOG",     0x48001800, 0x400);
-    create_unimplemented_device("GPIOH",     0x48001C00, 0x400);
     /* RESERVED:    0x48002000, 0x7FDBC00 */
     create_unimplemented_device("OTG_FS",    0x50000000, 0x40000);
     create_unimplemented_device("ADC",       0x50040000, 0x400);
diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_so=
c.h
index baf70410b5..c8aff07b6d 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -28,6 +28,7 @@
 #include "hw/arm/armv7m.h"
 #include "hw/misc/stm32l4x5_syscfg.h"
 #include "hw/misc/stm32l4x5_exti.h"
+#include "hw/gpio/stm32l4x5_gpio.h"
 #include "qom/object.h"
=20
 #define TYPE_STM32L4X5_SOC "stm32l4x5-soc"
@@ -43,6 +44,14 @@ struct Stm32l4x5SocState {
=20
     Stm32l4x5ExtiState exti;
     Stm32l4x5SyscfgState syscfg;
+    Stm32l4x5GpioState gpioa;
+    Stm32l4x5GpioState gpiob;
+    Stm32l4x5GpioState gpioc;
+    Stm32l4x5GpioState gpiod;
+    Stm32l4x5GpioState gpioe;
+    Stm32l4x5GpioState gpiof;
+    Stm32l4x5GpioState gpiog;
+    Stm32l4x5GpioState gpioh;
=20
     MemoryRegion sram1;
     MemoryRegion sram2;
--=20
2.43.0


