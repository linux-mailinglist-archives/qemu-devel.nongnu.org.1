Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4CD8ABF82
	for <lists+qemu-devel@lfdr.de>; Sun, 21 Apr 2024 16:08:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryXq8-0001YP-Ig; Sun, 21 Apr 2024 10:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1ryXpo-0001Px-GJ; Sun, 21 Apr 2024 10:06:25 -0400
Received: from zproxy4.enst.fr ([2001:660:330f:2::df])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1ryXpk-0008MF-Py; Sun, 21 Apr 2024 10:06:24 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 4BFC520673;
 Sun, 21 Apr 2024 16:06:19 +0200 (CEST)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id moy2jUn4VZqn; Sun, 21 Apr 2024 16:06:18 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id A7CD42066D;
 Sun, 21 Apr 2024 16:06:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr A7CD42066D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1713708378;
 bh=3R1cZFMNLQryBlDCNdtrSHptL+Xd0cZLTSuX/37F5Jo=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=4SIe3hjqPG/yyyb8LjM+1lfvuh/QKFwlCB8FFvEWrdP74rb/29QTNwlXcc0wVuexP
 0ZIRreIpTSCRUeyVE+nOU5rR7dquMKITGIxqio2tXhRkVYo1cyXF7EJXAccPoQiaoM
 Ppk1MQBZVi8EXbPlsKlkqWp2TQ3H8/btwUKLkB2M=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id GVCGSWROdDdi; Sun, 21 Apr 2024 16:06:18 +0200 (CEST)
Received: from inesv-Inspiron-3501.. (unknown
 [IPv6:2a02:1808:204:e56c:d081:2a7:415b:bbbd])
 by zproxy4.enst.fr (Postfix) with ESMTPSA id F03FE2061F;
 Sun, 21 Apr 2024 16:06:16 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Samuel Tardieu <sam@rfc1149.net>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 5/5] tests/qtest : Add testcase for DM163
Date: Sun, 21 Apr 2024 16:02:48 +0200
Message-ID: <20240421140604.111262-6-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240421140604.111262-1-ines.varhol@telecom-paris.fr>
References: <20240421140604.111262-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::df;
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

`test_dm163_bank()`
Checks that the pin "sout" of the DM163 led driver outputs the values
received on pin "sin" with the expected latency (depending on the bank).

`test_dm163_gpio_connection()`
Check that changes to relevant STM32L4x5 GPIO pins are propagated to the
DM163 device.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
---
 tests/qtest/dm163-test.c | 194 +++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build  |   2 +
 2 files changed, 196 insertions(+)
 create mode 100644 tests/qtest/dm163-test.c

diff --git a/tests/qtest/dm163-test.c b/tests/qtest/dm163-test.c
new file mode 100644
index 0000000000..3161c9208d
--- /dev/null
+++ b/tests/qtest/dm163-test.c
@@ -0,0 +1,194 @@
+/*
+ * QTest testcase for DM163
+ *
+ * Copyright (C) 2024 Samuel Tardieu <sam@rfc1149.net>
+ * Copyright (C) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (C) 2024 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+enum DM163_INPUTS {
+    SIN =3D 8,
+    DCK =3D 9,
+    RST_B =3D 10,
+    LAT_B =3D 11,
+    SELBK =3D 12,
+    EN_B =3D 13
+};
+
+#define DEVICE_NAME "/machine/dm163"
+#define GPIO_OUT(name, value) qtest_set_irq_in(qts, DEVICE_NAME, NULL, n=
ame,   \
+                                               value)
+#define GPIO_PULSE(name)                                                =
       \
+  do {                                                                  =
       \
+    GPIO_OUT(name, 1);                                                  =
       \
+    GPIO_OUT(name, 0);                                                  =
       \
+  } while (0)
+
+
+static void rise_gpio_pin_dck(QTestState *qts)
+{
+    /* Configure output mode for pin PB1 */
+    qtest_writel(qts, 0x48000400, 0xFFFFFEB7);
+    /* Write 1 in ODR for PB1 */
+    qtest_writel(qts, 0x48000414, 0x00000002);
+}
+
+static void lower_gpio_pin_dck(QTestState *qts)
+{
+    /* Configure output mode for pin PB1 */
+    qtest_writel(qts, 0x48000400, 0xFFFFFEB7);
+    /* Write 0 in ODR for PB1 */
+    qtest_writel(qts, 0x48000414, 0x00000000);
+}
+
+static void rise_gpio_pin_selbk(QTestState *qts)
+{
+    /* Configure output mode for pin PC5 */
+    qtest_writel(qts, 0x48000800, 0xFFFFF7FF);
+    /* Write 1 in ODR for PC5 */
+    qtest_writel(qts, 0x48000814, 0x00000020);
+}
+
+static void lower_gpio_pin_selbk(QTestState *qts)
+{
+    /* Configure output mode for pin PC5 */
+    qtest_writel(qts, 0x48000800, 0xFFFFF7FF);
+    /* Write 0 in ODR for PC5 */
+    qtest_writel(qts, 0x48000814, 0x00000000);
+}
+
+static void rise_gpio_pin_lat_b(QTestState *qts)
+{
+    /* Configure output mode for pin PC4 */
+    qtest_writel(qts, 0x48000800, 0xFFFFFDFF);
+    /* Write 1 in ODR for PC4 */
+    qtest_writel(qts, 0x48000814, 0x00000010);
+}
+
+static void lower_gpio_pin_lat_b(QTestState *qts)
+{
+    /* Configure output mode for pin PC4 */
+    qtest_writel(qts, 0x48000800, 0xFFFFFDFF);
+    /* Write 0 in ODR for PC4 */
+    qtest_writel(qts, 0x48000814, 0x00000000);
+}
+
+static void rise_gpio_pin_rst_b(QTestState *qts)
+{
+    /* Configure output mode for pin PC3 */
+    qtest_writel(qts, 0x48000800, 0xFFFFFF7F);
+    /* Write 1 in ODR for PC3 */
+    qtest_writel(qts, 0x48000814, 0x00000008);
+}
+
+static void lower_gpio_pin_rst_b(QTestState *qts)
+{
+    /* Configure output mode for pin PC3 */
+    qtest_writel(qts, 0x48000800, 0xFFFFFF7F);
+    /* Write 0 in ODR for PC3 */
+    qtest_writel(qts, 0x48000814, 0x00000000);
+}
+
+static void rise_gpio_pin_sin(QTestState *qts)
+{
+    /* Configure output mode for pin PA4 */
+    qtest_writel(qts, 0x48000000, 0xFFFFFDFF);
+    /* Write 1 in ODR for PA4 */
+    qtest_writel(qts, 0x48000014, 0x00000010);
+}
+
+static void lower_gpio_pin_sin(QTestState *qts)
+{
+    /* Configure output mode for pin PA4 */
+    qtest_writel(qts, 0x48000000, 0xFFFFFDFF);
+    /* Write 0 in ODR for PA4 */
+    qtest_writel(qts, 0x48000014, 0x00000000);
+}
+
+static void test_dm163_bank(const void *opaque)
+{
+    const unsigned bank =3D (uintptr_t) opaque;
+    const int width =3D bank ? 192 : 144;
+
+    QTestState *qts =3D qtest_initf("-M b-l475e-iot01a");
+    qtest_irq_intercept_out_named(qts, DEVICE_NAME, "sout");
+    GPIO_OUT(RST_B, 1);
+    GPIO_OUT(EN_B, 0);
+    GPIO_OUT(DCK, 0);
+    GPIO_OUT(SELBK, bank);
+    GPIO_OUT(LAT_B, 1);
+
+    /* Fill bank with zeroes */
+    GPIO_OUT(SIN, 0);
+    for (int i =3D 0; i < width; i++) {
+        GPIO_PULSE(DCK);
+    }
+    /* Fill bank with ones, check that we get the previous zeroes */
+    GPIO_OUT(SIN, 1);
+    for (int i =3D 0; i < width; i++) {
+        GPIO_PULSE(DCK);
+        g_assert(!qtest_get_irq(qts, 0));
+    }
+
+    /* Pulse one more bit in the bank, check that we get a one */
+    GPIO_PULSE(DCK);
+    g_assert(qtest_get_irq(qts, 0));
+
+    qtest_quit(qts);
+}
+
+static void test_dm163_gpio_connection(void)
+{
+    QTestState *qts =3D qtest_init("-M b-l475e-iot01a");
+    qtest_irq_intercept_in(qts, DEVICE_NAME);
+
+    g_assert_false(qtest_get_irq(qts, SIN));
+    g_assert_false(qtest_get_irq(qts, DCK));
+    g_assert_false(qtest_get_irq(qts, RST_B));
+    g_assert_false(qtest_get_irq(qts, LAT_B));
+    g_assert_false(qtest_get_irq(qts, SELBK));
+
+    rise_gpio_pin_dck(qts);
+    g_assert_true(qtest_get_irq(qts, DCK));
+    lower_gpio_pin_dck(qts);
+    g_assert_false(qtest_get_irq(qts, DCK));
+
+    rise_gpio_pin_lat_b(qts);
+    g_assert_true(qtest_get_irq(qts, LAT_B));
+    lower_gpio_pin_lat_b(qts);
+    g_assert_false(qtest_get_irq(qts, LAT_B));
+
+    rise_gpio_pin_selbk(qts);
+    g_assert_true(qtest_get_irq(qts, SELBK));
+    lower_gpio_pin_selbk(qts);
+    g_assert_false(qtest_get_irq(qts, SELBK));
+
+    rise_gpio_pin_rst_b(qts);
+    g_assert_true(qtest_get_irq(qts, RST_B));
+    lower_gpio_pin_rst_b(qts);
+    g_assert_false(qtest_get_irq(qts, RST_B));
+
+    rise_gpio_pin_sin(qts);
+    g_assert_true(qtest_get_irq(qts, SIN));
+    lower_gpio_pin_sin(qts);
+    g_assert_false(qtest_get_irq(qts, SIN));
+
+    g_assert_false(qtest_get_irq(qts, DCK));
+    g_assert_false(qtest_get_irq(qts, LAT_B));
+    g_assert_false(qtest_get_irq(qts, SELBK));
+    g_assert_false(qtest_get_irq(qts, RST_B));
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_data_func("/dm163/bank0", (void *)0, test_dm163_bank);
+    qtest_add_data_func("/dm163/bank1", (void *)1, test_dm163_bank);
+    qtest_add_func("/dm163/gpio_connection", test_dm163_gpio_connection)=
;
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 36c5c13a7b..59bd89c438 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -222,6 +222,8 @@ qtests_arm =3D \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : [=
]) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5=
 : []) + \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fs=
i-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
+   config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
   ['arm-cpu-features',
    'boot-serial-test']
=20
--=20
2.43.2


