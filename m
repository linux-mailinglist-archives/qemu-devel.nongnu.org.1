Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B428828E0C
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 20:46:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNI1v-00014y-Fi; Tue, 09 Jan 2024 14:44:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rNI1t-00014P-49; Tue, 09 Jan 2024 14:44:53 -0500
Received: from zproxy1.enst.fr ([2001:660:330f:2::dc])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rNI1q-0005cw-Qi; Tue, 09 Jan 2024 14:44:52 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 1583CC0CBA;
 Tue,  9 Jan 2024 20:44:48 +0100 (CET)
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id mdXwjDboYyFK; Tue,  9 Jan 2024 20:44:47 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 676B5C0D00;
 Tue,  9 Jan 2024 20:44:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy1.enst.fr 676B5C0D00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1704829487;
 bh=yMzvz6qwSFKC5OyF4+vSQks97LFNIui3nYOUYqwTsWM=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=sVWtYUpFj/kXdZ9AUdv/mKyKOpX1xlrluICBfgoYOTEbTd3Ibxe0KwzkNwCd9At4T
 wdxebBCvLKUborvfbwu1lCjA89sLAV+fXJEMwco6vXVQl5r9uCe0DNrEyw35KR9YSZ
 jNHCSl0KStr9wlVUhhurz/+rAK3F+/pU2oEUPldk=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id 9AXEEhrzrCvf; Tue,  9 Jan 2024 20:44:47 +0100 (CET)
Received: from localhost.localdomain (74.0.125.80.rev.sfr.net [80.125.0.74])
 by zproxy1.enst.fr (Postfix) with ESMTPSA id EAD1FC0CF2;
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
 Laurent Vivier <lvivier@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 3/3] tests/qtest: Add STM32L4x5 SYSCFG QTest testcase
Date: Tue,  9 Jan 2024 20:41:59 +0100
Message-ID: <20240109194438.70934-4-ines.varhol@telecom-paris.fr>
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

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 tests/qtest/meson.build             |   3 +-
 tests/qtest/stm32l4x5_syscfg-test.c | 331 ++++++++++++++++++++++++++++
 2 files changed, 333 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/stm32l4x5_syscfg-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index d890b6f333..a926af92f6 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -196,7 +196,8 @@ qtests_aspeed =3D \
    'aspeed_gpio-test']
=20
 qtests_stm32l4x5 =3D \
-  ['stm32l4x5_exti-test']
+  ['stm32l4x5_exti-test',
+   'stm32l4x5_syscfg-test']
=20
 qtests_arm =3D \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) =
+ \
diff --git a/tests/qtest/stm32l4x5_syscfg-test.c b/tests/qtest/stm32l4x5_=
syscfg-test.c
new file mode 100644
index 0000000000..ed4801798d
--- /dev/null
+++ b/tests/qtest/stm32l4x5_syscfg-test.c
@@ -0,0 +1,331 @@
+/*
+ * QTest testcase for STM32L4x5_SYSCFG
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+#define SYSCFG_BASE_ADDR 0x40010000
+#define SYSCFG_MEMRMP 0x00
+#define SYSCFG_CFGR1 0x04
+#define SYSCFG_EXTICR1 0x08
+#define SYSCFG_EXTICR2 0x0C
+#define SYSCFG_EXTICR3 0x10
+#define SYSCFG_EXTICR4 0x14
+#define SYSCFG_SCSR 0x18
+#define SYSCFG_CFGR2 0x1C
+#define SYSCFG_SWPR 0x20
+#define SYSCFG_SKR 0x24
+#define SYSCFG_SWPR2 0x28
+#define INVALID_ADDR 0x2C
+
+static void syscfg_writel(unsigned int offset, uint32_t value)
+{
+    writel(SYSCFG_BASE_ADDR + offset, value);
+}
+
+static uint32_t syscfg_readl(unsigned int offset)
+{
+    return readl(SYSCFG_BASE_ADDR + offset);
+}
+
+static void syscfg_set_irq(int num, int level)
+{
+   qtest_set_irq_in(global_qtest, "/machine/soc/syscfg",
+                    NULL, num, level);
+}
+
+static void system_reset(void)
+{
+    QDict *response;
+    response =3D qtest_qmp(global_qtest, "{'execute': 'system_reset'}");
+    g_assert(qdict_haskey(response, "return"));
+    qobject_unref(response);
+}
+
+static void test_reset(void)
+{
+    /*
+     * Test that registers are initialized at the correct values
+     */
+    g_assert_cmpuint(syscfg_readl(SYSCFG_MEMRMP), =3D=3D, 0x00000000);
+
+    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0x7C000001);
+
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR1), =3D=3D, 0x00000000);
+
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR2), =3D=3D, 0x00000000);
+
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR3), =3D=3D, 0x00000000);
+
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR4), =3D=3D, 0x00000000);
+
+    g_assert_cmpuint(syscfg_readl(SYSCFG_SCSR), =3D=3D, 0x00000000);
+
+    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR2), =3D=3D, 0x00000000);
+
+    g_assert_cmpuint(syscfg_readl(SYSCFG_SWPR), =3D=3D, 0x00000000);
+
+    g_assert_cmpuint(syscfg_readl(SYSCFG_SKR), =3D=3D, 0x00000000);
+
+    g_assert_cmpuint(syscfg_readl(SYSCFG_SWPR2), =3D=3D, 0x00000000);
+}
+
+static void test_reserved_bits(void)
+{
+    /*
+     * Test that reserved bits stay at reset value
+     * (which is 0 for all of them) by writing '1'
+     * in all reserved bits (keeping reset value for
+     * other bits) and checking that the
+     * register is still at reset value
+     */
+    syscfg_writel(SYSCFG_MEMRMP, 0xFFFFFEF8);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_MEMRMP), =3D=3D, 0x00000000);
+
+    syscfg_writel(SYSCFG_CFGR1, 0x7F00FEFF);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0x7C000001);
+
+    syscfg_writel(SYSCFG_EXTICR1, 0xFFFF0000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR1), =3D=3D, 0x00000000);
+
+    syscfg_writel(SYSCFG_EXTICR2, 0xFFFF0000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR2), =3D=3D, 0x00000000);
+
+    syscfg_writel(SYSCFG_EXTICR3, 0xFFFF0000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR3), =3D=3D, 0x00000000);
+
+    syscfg_writel(SYSCFG_EXTICR4, 0xFFFF0000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR4), =3D=3D, 0x00000000);
+
+    syscfg_writel(SYSCFG_SKR, 0xFFFFFF00);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_SKR), =3D=3D, 0x00000000);
+}
+
+static void test_set_and_clear(void)
+{
+    /*
+     * Test that regular bits can be set and cleared
+     */
+    syscfg_writel(SYSCFG_MEMRMP, 0x00000107);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_MEMRMP), =3D=3D, 0x00000107);
+    syscfg_writel(SYSCFG_MEMRMP, 0x00000000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_MEMRMP), =3D=3D, 0x00000000);
+
+    /* cfgr1 bit 0 is clear only so we keep it set */
+    syscfg_writel(SYSCFG_CFGR1, 0xFCFF0101);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0xFCFF0101);
+    syscfg_writel(SYSCFG_CFGR1, 0x00000001);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0x00000001);
+
+    syscfg_writel(SYSCFG_EXTICR1, 0x0000FFFF);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR1), =3D=3D, 0x0000FFFF);
+    syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR1), =3D=3D, 0x00000000);
+
+    syscfg_writel(SYSCFG_EXTICR2, 0x0000FFFF);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR2), =3D=3D, 0x0000FFFF);
+    syscfg_writel(SYSCFG_EXTICR2, 0x00000000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR2), =3D=3D, 0x00000000);
+
+    syscfg_writel(SYSCFG_EXTICR3, 0x0000FFFF);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR3), =3D=3D, 0x0000FFFF);
+    syscfg_writel(SYSCFG_EXTICR3, 0x00000000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR3), =3D=3D, 0x00000000);
+
+    syscfg_writel(SYSCFG_EXTICR4, 0x0000FFFF);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR4), =3D=3D, 0x0000FFFF);
+    syscfg_writel(SYSCFG_EXTICR4, 0x00000000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR4), =3D=3D, 0x00000000);
+
+    syscfg_writel(SYSCFG_SKR, 0x000000FF);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_SKR), =3D=3D, 0x000000FF);
+    syscfg_writel(SYSCFG_SKR, 0x00000000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_SKR), =3D=3D, 0x00000000);
+}
+
+static void test_clear_by_writing_1(void)
+{
+    /*
+     * Test that writing '1' doesn't set the bit
+     */
+    syscfg_writel(SYSCFG_CFGR2, 0x00000100);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR2), =3D=3D, 0x00000000);
+}
+
+static void test_set_only_bits(void)
+{
+    /*
+     * Test that set only bits stay can't be cleared
+     */
+    syscfg_writel(SYSCFG_CFGR2, 0x0000000F);
+    syscfg_writel(SYSCFG_CFGR2, 0x00000000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR2), =3D=3D, 0x0000000F);
+
+    syscfg_writel(SYSCFG_SWPR, 0xFFFFFFFF);
+    syscfg_writel(SYSCFG_SWPR, 0x00000000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_SWPR), =3D=3D, 0xFFFFFFFF);
+
+    syscfg_writel(SYSCFG_SWPR2, 0xFFFFFFFF);
+    syscfg_writel(SYSCFG_SWPR2, 0x00000000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_SWPR2), =3D=3D, 0xFFFFFFFF);
+
+    system_reset();
+}
+
+static void test_clear_only_bits(void)
+{
+    /*
+     * Test that clear only bits stay can't be set
+     */
+    syscfg_writel(SYSCFG_CFGR1, 0x00000000);
+    syscfg_writel(SYSCFG_CFGR1, 0x00000001);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0x00000000);
+
+    system_reset();
+}
+
+static void test_interrupt(void)
+{
+    /*
+     * Test that GPIO rising lines result in an irq
+     * with the right configuration
+     */
+    qtest_irq_intercept_in(global_qtest, "/machine/soc/exti");
+
+    /* GPIOA is the default source for EXTI lines 0 to 15 */
+
+    syscfg_set_irq(0, 1);
+
+    g_assert_true(get_irq(0));
+
+
+    syscfg_set_irq(15, 1);
+
+    g_assert_true(get_irq(15));
+
+    /* Configure GPIOB[1] as the source input for EXTI1 */
+    syscfg_writel(SYSCFG_EXTICR1, 0x00000010);
+
+    syscfg_set_irq(17, 1);
+
+    g_assert_true(get_irq(1));
+
+    /* Clean the test */
+    syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
+    syscfg_set_irq(0, 0);
+    syscfg_set_irq(15, 0);
+    syscfg_set_irq(17, 0);
+}
+
+static void test_irq_pin_multiplexer(void)
+{
+    /*
+     * Test that syscfg irq sets the right exti irq
+     */
+
+    qtest_irq_intercept_in(global_qtest, "/machine/soc/exti");
+
+    syscfg_set_irq(0, 1);
+
+    /* Check that irq 0 was set and irq 15 wasn't */
+    g_assert_true(get_irq(0));
+    g_assert_false(get_irq(15));
+
+    /* Clean the test */
+    syscfg_set_irq(0, 0);
+
+    syscfg_set_irq(15, 1);
+
+    /* Check that irq 15 was set and irq 0 wasn't */
+    g_assert_true(get_irq(15));
+    g_assert_false(get_irq(0));
+
+    /* Clean the test */
+    syscfg_set_irq(15, 0);
+}
+
+static void test_irq_gpio_multiplexer(void)
+{
+    /*
+     * Test that an irq is generated only by the right GPIO
+     */
+
+    qtest_irq_intercept_in(global_qtest, "/machine/soc/exti");
+
+    /* GPIOA is the default source for EXTI lines 0 to 15 */
+
+    /* Check that setting rising pin GPIOA[0] generates an irq */
+    syscfg_set_irq(0, 1);
+
+    g_assert_true(get_irq(0));
+
+    /* Clean the test */
+    syscfg_set_irq(0, 0);
+
+    /* Check that setting rising pin GPIOB[0] doesn't generate an irq */
+    syscfg_set_irq(16, 1);
+
+    g_assert_false(get_irq(0));
+
+    /* Clean the test */
+    syscfg_set_irq(16, 0);
+
+    /* Configure GPIOB[0] as the source input for EXTI0 */
+    syscfg_writel(SYSCFG_EXTICR1, 0x00000001);
+
+    /* Check that setting rising pin GPIOA[0] doesn't generate an irq */
+    syscfg_set_irq(0, 1);
+
+    g_assert_false(get_irq(0));
+
+    /* Clean the test */
+    syscfg_set_irq(0, 0);
+
+    /* Check that setting rising pin GPIOB[0] generates an irq */
+    syscfg_set_irq(16, 1);
+
+    g_assert_true(get_irq(0));
+
+    /* Clean the test */
+    syscfg_set_irq(16, 0);
+    syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+    g_test_set_nonfatal_assertions();
+
+    qtest_add_func("stm32l4x5/syscfg/test_reset", test_reset);
+    qtest_add_func("stm32l4x5/syscfg/test_reserved_bits",
+                   test_reserved_bits);
+    qtest_add_func("stm32l4x5/syscfg/test_set_and_clear",
+                   test_set_and_clear);
+    qtest_add_func("stm32l4x5/syscfg/test_clear_by_writing_1",
+                   test_clear_by_writing_1);
+    qtest_add_func("stm32l4x5/syscfg/test_set_only_bits",
+                   test_set_only_bits);
+    qtest_add_func("stm32l4x5/syscfg/test_clear_only_bits",
+                   test_clear_only_bits);
+    qtest_add_func("stm32l4x5/syscfg/test_interrupt",
+                   test_interrupt);
+    qtest_add_func("stm32l4x5/syscfg/test_irq_pin_multiplexer",
+                   test_irq_pin_multiplexer);
+    qtest_add_func("stm32l4x5/syscfg/test_irq_gpio_multiplexer",
+                   test_irq_gpio_multiplexer);
+
+    qtest_start("-machine b-l475e-iot01a");
+    ret =3D g_test_run();
+    qtest_end();
+
+    return ret;
+}
--=20
2.43.0


