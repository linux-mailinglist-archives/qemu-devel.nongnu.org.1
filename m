Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 445DC754564
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 01:29:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKSCk-0000sc-6J; Fri, 14 Jul 2023 19:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qKSCi-0000rw-6K
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 19:28:04 -0400
Received: from mail-4018.proton.ch ([185.70.40.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qKSCg-00043S-Al
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 19:28:03 -0400
Date: Fri, 14 Jul 2023 23:27:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laplante.io;
 s=protonmail3; t=1689377279; x=1689636479;
 bh=PQsO06m872ZPS3ye7JAZN9jPnnRrY+OuHRHTzT8HnJI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=aeUhYacEYXMWkLo4pVxVmuaZVAcmPok43vO8RmvXsh9+qOriHeGzzkBm8DCmAiE83
 6D99qREbzKNYZZ5Y2QQWsmhaJDeTsSutNEwY54eTjMT/t+sJX79ZjRvEWAOCaVuSqo
 b6RfMxXkGnyH2cfwg+ZhgecHZWyuyEm+Pc1/K9U9syAID3SdgFe6Fueg3SEiflzFgU
 VJdGCY+7rpQky2rYUZVcHu8kyUwNvdmE6Zw4ysbkLkkQLNq1tXxAeulGULGmlVlo5C
 fOQXSZa98xR8Q/nQY44Rk++g4/9U80pi0uhDGFsmzAL6ClsylrBidEsWLfwM469hdy
 9G2O9mjkvAwlQ==
To: qemu-devel@nongnu.org
From: Chris Laplante <chris@laplante.io>
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Chris Laplante <chris@laplante.io>
Subject: [PATCH 6/6] qtest: microbit-test: add tests for nRF51 DETECT
Message-ID: <20230714232659.76434-7-chris@laplante.io>
In-Reply-To: <20230714232659.76434-1-chris@laplante.io>
References: <20230714232659.76434-1-chris@laplante.io>
Feedback-ID: 43500449:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.18; envelope-from=chris@laplante.io;
 helo=mail-4018.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Exercise the DETECT mechanism of the GPIO peripheral.

Signed-off-by: Chris Laplante <chris@laplante.io>
---
 tests/qtest/microbit-test.c | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tests/qtest/microbit-test.c b/tests/qtest/microbit-test.c
index 6022a92b6a..3c85adba37 100644
--- a/tests/qtest/microbit-test.c
+++ b/tests/qtest/microbit-test.c
@@ -393,6 +393,47 @@ static void test_nrf51_gpio(void)
     qtest_quit(qts);
 }
=20
+static void test_nrf51_gpio_detect(void) {
+    QTestState *qts =3D qtest_init("-M microbit");
+    int i;
+
+    // Connect input buffer on pins 1-7, configure SENSE for high level
+    for (i =3D 1; i <=3D 7; i++) {
+        qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START + i *=
 4, deposit32(0, 16, 2, 2));
+    }
+
+    qtest_irq_intercept_out_named(qts, "/machine/nrf51", "detect");
+
+    for (i =3D 1; i <=3D 7; i++) {
+        // Set pin high
+        qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", i, 1);
+        uint32_t actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_=
REG_IN);
+        g_assert_cmpuint(actual, =3D=3D, 1 << i);
+
+        // Check that DETECT is high
+        g_assert_true(qtest_get_irq(qts, 0));
+
+        // Set pin low, check that DETECT goes low.
+        qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", i, 0);
+        actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN);
+        g_assert_cmpuint(actual, =3D=3D, 0x0);
+        g_assert_false(qtest_get_irq(qts, 0));
+    }
+
+    // Set pin 0 high, check that DETECT doesn't fire
+    qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, 1);
+    g_assert_false(qtest_get_irq(qts, 0));
+    qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, 0);
+
+    // Set pins 1, 2, and 3 high, then set 3 low. Check that DETECT is sti=
ll high.
+    for (i =3D 1; i <=3D 3; i++) {
+        qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", i, 1);
+    }
+    g_assert_true(qtest_get_irq(qts, 0));
+    qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 3, 0);
+    g_assert_true(qtest_get_irq(qts, 0));
+}
+
 static void timer_task(QTestState *qts, hwaddr task)
 {
     qtest_writel(qts, NRF51_TIMER_BASE + task, NRF51_TRIGGER_TASK);
@@ -499,6 +540,7 @@ int main(int argc, char **argv)
=20
     qtest_add_func("/microbit/nrf51/uart", test_nrf51_uart);
     qtest_add_func("/microbit/nrf51/gpio", test_nrf51_gpio);
+    qtest_add_func("/microbit/nrf51/gpio_detect", test_nrf51_gpio_detect);
     qtest_add_func("/microbit/nrf51/nvmc", test_nrf51_nvmc);
     qtest_add_func("/microbit/nrf51/timer", test_nrf51_timer);
     qtest_add_func("/microbit/microbit/i2c", test_microbit_i2c);
--=20
2.39.2



