Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8C18CC7C7
	for <lists+qemu-devel@lfdr.de>; Wed, 22 May 2024 22:42:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9slO-0005Gx-5G; Wed, 22 May 2024 16:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s9slI-0005DE-RO; Wed, 22 May 2024 16:40:37 -0400
Received: from zproxy4.enst.fr ([137.194.2.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s9slG-0003CK-OT; Wed, 22 May 2024 16:40:36 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 69C1420636;
 Wed, 22 May 2024 22:40:30 +0200 (CEST)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id 8C8cAXd4xaTx; Wed, 22 May 2024 22:40:29 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id D662B2051F;
 Wed, 22 May 2024 22:40:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr D662B2051F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1716410429;
 bh=Hf+j5l5Um/1eDJkNGHCyRdqMWpG6lfb1t4t+e09R38g=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=4vxD+AiSuYEQvBRu0CY6MH6oWKGiGxTJb2cNEfowCtKDcj2jhtUAQ63BfJwX4Jre4
 1tiXTXfDajzpllfFROqek0DsWHOuESpBsDkGEoiPNMjRslu2et+tVuROO21mE6z0vn
 mNS/gs1LWUtbSx5Q2KRhYIBlWOGd/GSgqNvsfw18=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id td9S-ob-MxTV; Wed, 22 May 2024 22:40:29 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy4.enst.fr (Postfix) with ESMTPSA id CF6F420553;
 Wed, 22 May 2024 22:40:28 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 1/3] hw/misc: In STM32L4x5 EXTI, consolidate 2 constants
Date: Wed, 22 May 2024 22:39:38 +0200
Message-ID: <20240522204020.203905-2-ines.varhol@telecom-paris.fr>
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

Up until now, the EXTI implementation had 16 inbound GPIOs connected to
the 16 outbound GPIOs of STM32L4x5 SYSCFG.
The EXTI actually handles 40 lines (namely 5 from STM32L4x5 USART
devices which are already implemented in QEMU).
In order to connect USART devices to EXTI, this commit consolidates
constants `EXTI_NUM_INTERRUPT_OUT_LINES` (40) and
`EXTI_NUM_GPIO_EVENT_IN_LINES` (16) into `EXTI_NUM_LINES` (40).

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/stm32l4x5_exti.h | 4 ++--
 hw/misc/stm32l4x5_exti.c         | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/hw/misc/stm32l4x5_exti.h b/include/hw/misc/stm32l4x5=
_exti.h
index be961d2f01..82f75a2417 100644
--- a/include/hw/misc/stm32l4x5_exti.h
+++ b/include/hw/misc/stm32l4x5_exti.h
@@ -30,7 +30,7 @@
 #define TYPE_STM32L4X5_EXTI "stm32l4x5-exti"
 OBJECT_DECLARE_SIMPLE_TYPE(Stm32l4x5ExtiState, STM32L4X5_EXTI)
=20
-#define EXTI_NUM_INTERRUPT_OUT_LINES 40
+#define EXTI_NUM_LINES 40
 #define EXTI_NUM_REGISTER 2
=20
 struct Stm32l4x5ExtiState {
@@ -45,7 +45,7 @@ struct Stm32l4x5ExtiState {
     uint32_t swier[EXTI_NUM_REGISTER];
     uint32_t pr[EXTI_NUM_REGISTER];
=20
-    qemu_irq irq[EXTI_NUM_INTERRUPT_OUT_LINES];
+    qemu_irq irq[EXTI_NUM_LINES];
 };
=20
 #endif
diff --git a/hw/misc/stm32l4x5_exti.c b/hw/misc/stm32l4x5_exti.c
index 495a0004ab..eebefc6cd3 100644
--- a/hw/misc/stm32l4x5_exti.c
+++ b/hw/misc/stm32l4x5_exti.c
@@ -42,7 +42,6 @@
 #define EXTI_SWIER2 0x30
 #define EXTI_PR2    0x34
=20
-#define EXTI_NUM_GPIO_EVENT_IN_LINES 16
 #define EXTI_MAX_IRQ_PER_BANK 32
 #define EXTI_IRQS_BANK0  32
 #define EXTI_IRQS_BANK1  8
@@ -241,7 +240,7 @@ static void stm32l4x5_exti_init(Object *obj)
 {
     Stm32l4x5ExtiState *s =3D STM32L4X5_EXTI(obj);
=20
-    for (size_t i =3D 0; i < EXTI_NUM_INTERRUPT_OUT_LINES; i++) {
+    for (size_t i =3D 0; i < EXTI_NUM_LINES; i++) {
         sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[i]);
     }
=20
@@ -249,8 +248,7 @@ static void stm32l4x5_exti_init(Object *obj)
                           TYPE_STM32L4X5_EXTI, 0x400);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
=20
-    qdev_init_gpio_in(DEVICE(obj), stm32l4x5_exti_set_irq,
-                      EXTI_NUM_GPIO_EVENT_IN_LINES);
+    qdev_init_gpio_in(DEVICE(obj), stm32l4x5_exti_set_irq, EXTI_NUM_LINE=
S);
 }
=20
 static const VMStateDescription vmstate_stm32l4x5_exti =3D {
--=20
2.43.2


