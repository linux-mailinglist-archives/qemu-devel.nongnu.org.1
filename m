Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A337476720D
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 18:41:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPPxj-0004sn-1w; Fri, 28 Jul 2023 12:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qPPxh-0004sA-7b
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 12:05:05 -0400
Received: from mail-4317.proton.ch ([185.70.43.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qPPxe-0004NM-VA
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 12:05:04 -0400
Date: Fri, 28 Jul 2023 16:04:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laplante.io;
 s=protonmail3; t=1690560300; x=1690819500;
 bh=zTjLq+zc91w1jiR1LPwIgyvKj+dT7Pr54R8PgUtkI0A=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=kD3/sLgeNbtK+qZ7wfsRkxWl6CK9ROeLmmOU37tRXlztnFTgfFxi/bzgnSxfWLoIM
 U7KgNXa/zq+uzPb0Est8/LLWylJ5FLe/b6h/r3h/dl/L1i2Q0nMd0GjFTPYLzwcrXc
 O1ShU+QHpumMGYKJ2Vab8uxT2y5GqQ3oN4KWNtPWSzW9CL+sVASMyLuuQSlsZSyxk5
 nswFQbQrSacArTpab/coLAditxadWEDvWXve0g1SvMgLm3mw7jG8o7fMsG9vSsQKYC
 elrjD9lhoJUeWDbI7Ow9i1IK6VcS1hH7L59zQHkSyZNYvRKWxtiN5LKgV4k8g6f/ZI
 B/A2kiC5r9SmA==
To: qemu-devel@nongnu.org
From: Chris Laplante <chris@laplante.io>
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Chris Laplante <chris@laplante.io>
Subject: [PATCH v3 1/6] hw/gpio/nrf51: implement DETECT signal
Message-ID: <20230728160324.1159090-2-chris@laplante.io>
In-Reply-To: <20230728160324.1159090-1-chris@laplante.io>
References: <20230728160324.1159090-1-chris@laplante.io>
Feedback-ID: 43500449:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.17; envelope-from=chris@laplante.io;
 helo=mail-4317.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

Implement nRF51 DETECT signal in the GPIO peripheral.

The reference manual makes mention of a per-pin DETECT signal, but these
are not exposed to the user. See https://devzone.nordicsemi.com/f/nordic-q-=
a/39858/gpio-per-pin-detect-signal-available
for more information. Currently, I don't see a reason to model these.

Signed-off-by: Chris Laplante <chris@laplante.io>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/gpio/nrf51_gpio.c         | 14 +++++++++++++-
 include/hw/gpio/nrf51_gpio.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/gpio/nrf51_gpio.c b/hw/gpio/nrf51_gpio.c
index b47fddf4ed..08396c69a4 100644
--- a/hw/gpio/nrf51_gpio.c
+++ b/hw/gpio/nrf51_gpio.c
@@ -78,6 +78,7 @@ static void update_state(NRF51GPIOState *s)
     int pull;
     size_t i;
     bool connected_out, dir, connected_in, out, in, input;
+    bool assert_detect =3D false;
=20
     for (i =3D 0; i < NRF51_GPIO_PINS; i++) {
         pull =3D pull_value(s->cnf[i]);
@@ -99,7 +100,15 @@ static void update_state(NRF51GPIOState *s)
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "GPIO pin %zu short circuited\n", i);
             }
-            if (!connected_in) {
+            if (connected_in) {
+                uint32_t detect_config =3D extract32(s->cnf[i], 16, 2);
+                if ((detect_config =3D=3D 2) && (in =3D=3D 1)) {
+                    assert_detect =3D true;
+                }
+                if ((detect_config =3D=3D 3) && (in =3D=3D 0)) {
+                    assert_detect =3D true;
+                }
+            } else {
                 /*
                  * Floating input: the output stimulates IN if connected,
                  * otherwise pull-up/pull-down resistors put a value on bo=
th
@@ -116,6 +125,8 @@ static void update_state(NRF51GPIOState *s)
         }
         update_output_irq(s, i, connected_out, out);
     }
+
+    qemu_set_irq(s->detect, assert_detect);
 }
=20
 /*
@@ -291,6 +302,7 @@ static void nrf51_gpio_init(Object *obj)
=20
     qdev_init_gpio_in(DEVICE(s), nrf51_gpio_set, NRF51_GPIO_PINS);
     qdev_init_gpio_out(DEVICE(s), s->output, NRF51_GPIO_PINS);
+    qdev_init_gpio_out_named(DEVICE(s), &s->detect, "detect", 1);
 }
=20
 static void nrf51_gpio_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/gpio/nrf51_gpio.h b/include/hw/gpio/nrf51_gpio.h
index 8f9c2f86da..fcfa2bac17 100644
--- a/include/hw/gpio/nrf51_gpio.h
+++ b/include/hw/gpio/nrf51_gpio.h
@@ -64,6 +64,7 @@ struct NRF51GPIOState {
     uint32_t old_out_connected;
=20
     qemu_irq output[NRF51_GPIO_PINS];
+    qemu_irq detect;
 };
=20
=20
--=20
2.41.0



