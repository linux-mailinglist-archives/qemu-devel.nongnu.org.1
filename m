Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C5B8CC7C8
	for <lists+qemu-devel@lfdr.de>; Wed, 22 May 2024 22:42:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9slO-0005KK-Ki; Wed, 22 May 2024 16:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s9slL-0005Fb-2r; Wed, 22 May 2024 16:40:39 -0400
Received: from zproxy4.enst.fr ([137.194.2.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s9slG-0003CY-OJ; Wed, 22 May 2024 16:40:38 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 1551820553;
 Wed, 22 May 2024 22:40:32 +0200 (CEST)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id RrRCABmcakHB; Wed, 22 May 2024 22:40:31 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 7D1852051F;
 Wed, 22 May 2024 22:40:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr 7D1852051F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1716410431;
 bh=c8ENjiff4Xy7HERVz3+urS3GGp04uSfEuEG00VB4S7E=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=mAho2SuT654iFGfGBaIKQlsQ81GVvnXlzw5nbk8ylcsDuuRjvdX8fd6o4C1StV4qe
 ExHGfCbCEywuP4XfcwJyoyVISzyLndlTLstADxqH6J2x3s7jDHJMc0nunTgTkCW22W
 yqrUGH6ra7D1H/BFABZetfMs1S/JWDdR48Pss3t8=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id K1QUHp3Hz5WC; Wed, 22 May 2024 22:40:31 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy4.enst.fr (Postfix) with ESMTPSA id 9B65720528;
 Wed, 22 May 2024 22:40:30 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 3/3] hw/arm: In STM32L4x5 SOC, connect USART devices to EXTI
Date: Wed, 22 May 2024 22:39:40 +0200
Message-ID: <20240522204020.203905-4-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240522204020.203905-1-ines.varhol@telecom-paris.fr>
References: <20240522204020.203905-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.223;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy4.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The USART devices were previously connecting their outbound IRQs
directly to the CPU because the EXTI wasn't handling direct lines
interrupts.
Now the USART connects to the EXTI inbound GPIOs, and the EXTI connects
its IRQs to the CPU.
The existing QTest for the USART (tests/qtest/stm32l4x5_usart-test.c)
checks that USART1_IRQ in the CPU is pending when expected so it
confirms that the connection through the EXTI still works.

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stm32l4x5_soc.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index 38f7a2d5d9..fac83d349c 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -81,6 +81,10 @@ static const int exti_irq[NUM_EXTI_IRQ] =3D {
 #define RCC_BASE_ADDRESS 0x40021000
 #define RCC_IRQ 5
=20
+#define EXTI_USART1_IRQ 26
+#define EXTI_UART4_IRQ 29
+#define EXTI_LPUART1_IRQ 31
+
 static const int exti_or_gates_out[NUM_EXTI_OR_GATES] =3D {
     23, 40, 63, 1,
 };
@@ -129,10 +133,6 @@ static const hwaddr uart_addr[] =3D {
=20
 #define LPUART_BASE_ADDRESS 0x40008000
=20
-static const int usart_irq[] =3D { 37, 38, 39 };
-static const int uart_irq[] =3D { 52, 53 };
-#define LPUART_IRQ 70
-
 static void stm32l4x5_soc_initfn(Object *obj)
 {
     Stm32l4x5SocState *s =3D STM32L4X5_SOC(obj);
@@ -297,6 +297,7 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
c, Error **errp)
         }
     }
=20
+    /* Connect SYSCFG to EXTI */
     for (unsigned i =3D 0; i < GPIO_NUM_PINS; i++) {
         qdev_connect_gpio_out(DEVICE(&s->syscfg), i,
                               qdev_get_gpio_in(DEVICE(&s->exti), i));
@@ -322,15 +323,10 @@ static void stm32l4x5_soc_realize(DeviceState *dev_=
soc, Error **errp)
             return;
         }
         sysbus_mmio_map(busdev, 0, usart_addr[i]);
-        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, usart_irq=
[i]));
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DEVICE(&s->exti),
+                                                       EXTI_USART1_IRQ +=
 i));
     }
=20
-    /*
-     * TODO: Connect the USARTs, UARTs and LPUART to the EXTI once the E=
XTI
-     * can handle other gpio-in than the gpios. (e.g. Direct Lines for t=
he
-     * usarts)
-     */
-
     /* UART devices */
     for (int i =3D 0; i < STM_NUM_UARTS; i++) {
         g_autofree char *name =3D g_strdup_printf("uart%d-out", STM_NUM_=
USARTS + i + 1);
@@ -343,7 +339,8 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
c, Error **errp)
             return;
         }
         sysbus_mmio_map(busdev, 0, uart_addr[i]);
-        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, uart_irq[=
i]));
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DEVICE(&s->exti),
+                                                       EXTI_UART4_IRQ + =
i));
     }
=20
     /* LPUART device*/
@@ -356,7 +353,8 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
c, Error **errp)
         return;
     }
     sysbus_mmio_map(busdev, 0, LPUART_BASE_ADDRESS);
-    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, LPUART_IRQ));
+    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DEVICE(&s->exti),
+                                                   EXTI_LPUART1_IRQ));
=20
     /* APB1 BUS */
     create_unimplemented_device("TIM2",      0x40000000, 0x400);
--=20
2.43.2


