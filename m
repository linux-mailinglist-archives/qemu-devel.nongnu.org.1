Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 138169132EC
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jun 2024 11:45:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKxIX-00029o-Uc; Sat, 22 Jun 2024 05:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1sKxIV-00027a-IL; Sat, 22 Jun 2024 05:44:39 -0400
Received: from zproxy2.enst.fr ([137.194.2.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1sKxIS-00011K-4D; Sat, 22 Jun 2024 05:44:39 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id A83D080832;
 Sat, 22 Jun 2024 11:44:34 +0200 (CEST)
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id QgvR6AZFBnLQ; Sat, 22 Jun 2024 11:44:34 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 13E6180767;
 Sat, 22 Jun 2024 11:44:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy2.enst.fr 13E6180767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1719049474;
 bh=nolDPs4/mJZyGtMc4P7VYywEmjvd5pQJLLW0y0ZEHZU=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=UkW2Sd0JlmY0ioLHn5ZlUXmmEhyG8yAKu0rWp0J6LrUb8uR0yLgNb4RuXCSkNx/33
 tlJZN4t1n2MQ9UckxksC+QRcavH5T+WJN6OAOR5SFtvNijp/6iI8qRsp3uWN86a1S8
 B002v0mv+xzAYgAxwv6GQIVZK0QwHqw7AcuP2quk=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id fqXnLdwKN0tY; Sat, 22 Jun 2024 11:44:33 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy2.enst.fr (Postfix) with ESMTPSA id 91BD980822;
 Sat, 22 Jun 2024 11:44:32 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Damien Hedde <damien.hedde@dahe.fr>
Subject: [PATCH v4 3/3] tests/qtest: Check STM32L4x5 clock connections
Date: Sat, 22 Jun 2024 11:43:55 +0200
Message-ID: <20240622094402.244604-4-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240622094402.244604-1-ines.varhol@telecom-paris.fr>
References: <20240622094402.244604-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.221;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy2.enst.fr
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

For USART, GPIO and SYSCFG devices, check that clock frequency before
and after enabling the peripheral clock in RCC is correct.

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/stm32l4x5.h             | 42 +++++++++++++++++++++++++++++
 tests/qtest/stm32l4x5_gpio-test.c   | 23 ++++++++++++++++
 tests/qtest/stm32l4x5_syscfg-test.c | 20 ++++++++++++--
 tests/qtest/stm32l4x5_usart-test.c  | 26 ++++++++++++++++++
 4 files changed, 109 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/stm32l4x5.h

diff --git a/tests/qtest/stm32l4x5.h b/tests/qtest/stm32l4x5.h
new file mode 100644
index 0000000000..2d21cc666c
--- /dev/null
+++ b/tests/qtest/stm32l4x5.h
@@ -0,0 +1,42 @@
+/*
+ * QTest testcase header for STM32L4X5 :
+ * used for consolidating common objects in stm32l4x5_*-test.c
+ *
+ * Copyright (c) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2024 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "libqtest.h"
+
+/* copied from clock.h */
+#define CLOCK_PERIOD_1SEC (1000000000llu << 32)
+#define CLOCK_PERIOD_FROM_HZ(hz) (((hz) !=3D 0) ? CLOCK_PERIOD_1SEC / (h=
z) : 0u)
+/*
+ * MSI (4 MHz) is used as system clock source after startup
+ * from Reset.
+ * AHB, APB1 and APB2 prescalers are set to 1 at reset.
+ */
+#define SYSCLK_PERIOD CLOCK_PERIOD_FROM_HZ(4000000)
+#define RCC_AHB2ENR 0x4002104C
+#define RCC_APB1ENR1 0x40021058
+#define RCC_APB1ENR2 0x4002105C
+#define RCC_APB2ENR 0x40021060
+
+
+static inline uint64_t get_clock_period(QTestState *qts, const char *pat=
h)
+{
+    uint64_t clock_period =3D 0;
+    QDict *r;
+
+    r =3D qtest_qmp(qts, "{ 'execute': 'qom-get', 'arguments':"
+        " { 'path': %s, 'property': 'qtest-clock-period'} }", path);
+    g_assert_false(qdict_haskey(r, "error"));
+    clock_period =3D qdict_get_int(r, "return");
+    qobject_unref(r);
+    return clock_period;
+}
+
+
diff --git a/tests/qtest/stm32l4x5_gpio-test.c b/tests/qtest/stm32l4x5_gp=
io-test.c
index 72a7823406..c0686c7b30 100644
--- a/tests/qtest/stm32l4x5_gpio-test.c
+++ b/tests/qtest/stm32l4x5_gpio-test.c
@@ -10,6 +10,7 @@
=20
 #include "qemu/osdep.h"
 #include "libqtest-single.h"
+#include "stm32l4x5.h"
=20
 #define GPIO_BASE_ADDR 0x48000000
 #define GPIO_SIZE      0x400
@@ -505,6 +506,26 @@ static void test_bsrr_brr(const void *data)
     gpio_writel(gpio, ODR, reset(gpio, ODR));
 }
=20
+static void test_clock_enable(void)
+{
+    /*
+     * For each GPIO, enable its clock in RCC
+     * and check that its clock period changes to SYSCLK_PERIOD
+     */
+    unsigned int gpio_id;
+
+    for (uint32_t gpio =3D GPIO_A; gpio <=3D GPIO_H; gpio +=3D GPIO_B - =
GPIO_A) {
+        gpio_id =3D get_gpio_id(gpio);
+        g_autofree char *path =3D g_strdup_printf("/machine/soc/gpio%c/c=
lk",
+                                                gpio_id + 'a');
+        g_assert_cmpuint(get_clock_period(global_qtest, path), =3D=3D, 0=
);
+        /* Enable the gpio clock */
+        writel(RCC_AHB2ENR, readl(RCC_AHB2ENR) | (0x1 << gpio_id));
+        g_assert_cmpuint(get_clock_period(global_qtest, path), =3D=3D,
+                         SYSCLK_PERIOD);
+    }
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -556,6 +577,8 @@ int main(int argc, char **argv)
     qtest_add_data_func("stm32l4x5/gpio/test_bsrr_brr2",
                         test_data(GPIO_D, 0),
                         test_bsrr_brr);
+    qtest_add_func("stm32l4x5/gpio/test_clock_enable",
+                   test_clock_enable);
=20
     qtest_start("-machine b-l475e-iot01a");
     ret =3D g_test_run();
diff --git a/tests/qtest/stm32l4x5_syscfg-test.c b/tests/qtest/stm32l4x5_=
syscfg-test.c
index 506ca08bc2..8eaffe43ea 100644
--- a/tests/qtest/stm32l4x5_syscfg-test.c
+++ b/tests/qtest/stm32l4x5_syscfg-test.c
@@ -10,6 +10,7 @@
=20
 #include "qemu/osdep.h"
 #include "libqtest-single.h"
+#include "stm32l4x5.h"
=20
 #define SYSCFG_BASE_ADDR 0x40010000
 #define SYSCFG_MEMRMP 0x00
@@ -26,7 +27,9 @@
 #define INVALID_ADDR 0x2C
=20
 /* SoC forwards GPIOs to SysCfg */
-#define SYSCFG "/machine/soc"
+#define SOC "/machine/soc"
+#define SYSCFG "/machine/soc/syscfg"
+#define SYSCFG_CLK "/machine/soc/syscfg/clk"
 #define EXTI "/machine/soc/exti"
=20
 static void syscfg_writel(unsigned int offset, uint32_t value)
@@ -41,7 +44,7 @@ static uint32_t syscfg_readl(unsigned int offset)
=20
 static void syscfg_set_irq(int num, int level)
 {
-   qtest_set_irq_in(global_qtest, SYSCFG, NULL, num, level);
+   qtest_set_irq_in(global_qtest, SOC, NULL, num, level);
 }
=20
 static void system_reset(void)
@@ -301,6 +304,17 @@ static void test_irq_gpio_multiplexer(void)
     syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
 }
=20
+static void test_clock_enable(void)
+{
+    g_assert_cmpuint(get_clock_period(global_qtest, SYSCFG_CLK), =3D=3D,=
 0);
+
+    /* Enable SYSCFG clock */
+    writel(RCC_APB2ENR, readl(RCC_APB2ENR) | (0x1 << 0));
+
+    g_assert_cmpuint(get_clock_period(global_qtest, SYSCFG_CLK), =3D=3D,
+                                       SYSCLK_PERIOD);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -325,6 +339,8 @@ int main(int argc, char **argv)
                    test_irq_pin_multiplexer);
     qtest_add_func("stm32l4x5/syscfg/test_irq_gpio_multiplexer",
                    test_irq_gpio_multiplexer);
+    qtest_add_func("stm32l4x5/syscfg/test_clock_enable",
+                   test_clock_enable);
=20
     qtest_start("-machine b-l475e-iot01a");
     ret =3D g_test_run();
diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_u=
sart-test.c
index 8902518233..4bad3603e8 100644
--- a/tests/qtest/stm32l4x5_usart-test.c
+++ b/tests/qtest/stm32l4x5_usart-test.c
@@ -12,6 +12,7 @@
 #include "libqtest.h"
 #include "hw/misc/stm32l4x5_rcc_internals.h"
 #include "hw/registerfields.h"
+#include "stm32l4x5.h"
=20
 #define RCC_BASE_ADDR 0x40021000
 /* Use USART 1 ADDR, assume the others work the same */
@@ -296,6 +297,30 @@ static void test_send_str(void)
     qtest_quit(qts);
 }
=20
+static void check_clock(QTestState *qts, const char *path, uint32_t rcc_=
reg,
+                        uint32_t reg_offset)
+{
+    g_assert_cmpuint(get_clock_period(qts, path), =3D=3D, 0);
+    qtest_writel(qts, rcc_reg, qtest_readl(qts, rcc_reg) | (0x1 << reg_o=
ffset));
+    g_assert_cmpuint(get_clock_period(qts, path), =3D=3D, SYSCLK_PERIOD)=
;
+}
+
+static void test_clock_enable(void)
+{
+    /*
+     * For each USART device, enable its clock in RCC
+     * and check that its clock frequency is SYSCLK_PERIOD
+     */
+    QTestState *qts =3D qtest_init("-M b-l475e-iot01a");
+
+    check_clock(qts, "machine/soc/usart[0]/clk", RCC_APB2ENR, 14);
+    check_clock(qts, "machine/soc/usart[1]/clk", RCC_APB1ENR1, 17);
+    check_clock(qts, "machine/soc/usart[2]/clk", RCC_APB1ENR1, 18);
+    check_clock(qts, "machine/soc/uart[0]/clk", RCC_APB1ENR1, 19);
+    check_clock(qts, "machine/soc/uart[1]/clk", RCC_APB1ENR1, 20);
+    check_clock(qts, "machine/soc/lpuart1/clk", RCC_APB1ENR2, 0);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -308,6 +333,7 @@ int main(int argc, char **argv)
     qtest_add_func("stm32l4x5/usart/send_char", test_send_char);
     qtest_add_func("stm32l4x5/usart/receive_str", test_receive_str);
     qtest_add_func("stm32l4x5/usart/send_str", test_send_str);
+    qtest_add_func("stm32l4x5/usart/clock_enable", test_clock_enable);
     ret =3D g_test_run();
=20
     return ret;
--=20
2.43.2


