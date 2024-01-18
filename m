Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18225831AD3
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 14:52:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQSn4-0002lS-1b; Thu, 18 Jan 2024 08:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rQSmr-0002kB-LN; Thu, 18 Jan 2024 08:50:30 -0500
Received: from zproxy2.enst.fr ([137.194.2.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rQSmo-0007Vp-Ec; Thu, 18 Jan 2024 08:50:29 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id C7B5C80592;
 Thu, 18 Jan 2024 14:50:22 +0100 (CET)
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id MsSipxYCxbUm; Thu, 18 Jan 2024 14:50:21 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id A538680718;
 Thu, 18 Jan 2024 14:50:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy2.enst.fr A538680718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1705585821;
 bh=Bmhqq6mPQuOgHdgKyuGFW7QpqcPFu/FOg7fmIOcGm1Q=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=0EHo8K5wM+klv1H/gTMBPT254kzqsbVdXIBfVmfvVOLAZgYBW8MZSFcgPhDK8OO6F
 +pHF3VY6i4sVTktJnAPEuEZyuAyHmk8GiCAJslDTGjMsKCJsGHd47UAxEwnTzqHvLm
 DhlgCNM4yCmEmeXavpJ+uYuFMp2alESQfl1uh1yQ=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id 4Lyjk3IlD3al; Thu, 18 Jan 2024 14:50:21 +0100 (CET)
Received: from AM-Inspiron-3585.enst.fr (unknown
 [IPv6:2a04:8ec0:0:144:3854:ba9b:1f5c:cca3])
 by zproxy2.enst.fr (Postfix) with ESMTPSA id 3C89880592;
 Thu, 18 Jan 2024 14:50:21 +0100 (CET)
From: Arnaud Minier <arnaud.minier@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philipe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org
Subject: [PATCH v2 7/7] Add tests for the STM32L4x5_RCC
Date: Thu, 18 Jan 2024 14:50:15 +0100
Message-Id: <20240118135015.8600-1-arnaud.minier@telecom-paris.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118091107.87831-1-arnaud.minier@telecom-paris.fr>
References: <20240118091107.87831-1-arnaud.minier@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.221;
 envelope-from=arnaud.minier@telecom-paris.fr; helo=zproxy2.enst.fr
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

Thanks Thomas for the reply.
I resend this patch as is because it was not properly linked with the pat=
ch note due to a mistake on my part.
Will definitely change qts_wait_for_flag() function in the next version !

These tests test:
- the ability to set the sysclk of the device
- the ability to enable and disable the PLLs
- if the clock multiplexers work
- the register flags and the generation of irqs

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 tests/qtest/meson.build          |   3 +-
 tests/qtest/stm32l4x5_rcc-test.c | 210 +++++++++++++++++++++++++++++++
 2 files changed, 212 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/stm32l4x5_rcc-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index a926af92f6..b0d9a8c2de 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -197,7 +197,8 @@ qtests_aspeed =3D \
=20
 qtests_stm32l4x5 =3D \
   ['stm32l4x5_exti-test',
-   'stm32l4x5_syscfg-test']
+   'stm32l4x5_syscfg-test',
+   'stm32l4x5_rcc-test']
=20
 qtests_arm =3D \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) =
+ \
diff --git a/tests/qtest/stm32l4x5_rcc-test.c b/tests/qtest/stm32l4x5_rcc=
-test.c
new file mode 100644
index 0000000000..dc2e1fcb26
--- /dev/null
+++ b/tests/qtest/stm32l4x5_rcc-test.c
@@ -0,0 +1,210 @@
+/*
+ * QTest testcase for STM32L4x5_RCC
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/registerfields.h"
+#include "libqtest-single.h"
+#include "hw/misc/stm32l4x5_rcc_internals.h"
+
+#define RCC_BASE_ADDR 0x40021000
+#define NVIC_ISER 0xE000E100
+#define NVIC_ISPR 0xE000E200
+#define NVIC_ICPR 0xE000E280
+#define RCC_IRQ 5
+
+static void enable_nvic_irq(unsigned int n)
+{
+    writel(NVIC_ISER, 1 << n);
+}
+
+static void unpend_nvic_irq(unsigned int n)
+{
+    writel(NVIC_ICPR, 1 << n);
+}
+
+static bool check_nvic_pending(unsigned int n)
+{
+    return readl(NVIC_ISPR) & (1 << n);
+}
+
+static bool qts_wait_for_flag(QTestState *qts, uint32_t event_addr,
+                              uint32_t flag, uint32_t value)
+{
+    time_t now, start =3D time(NULL);
+
+    while (true) {
+        if ((qtest_readl(qts, event_addr) & flag) =3D=3D value) {
+            return true;
+        }
+
+        /* Wait at most 5 seconds */
+        now =3D time(NULL);
+        if (now - start > 5) {
+            break;
+        }
+        g_usleep(1000);
+    }
+
+    return false;
+}
+
+static bool rcc_wait_for_flag(uint32_t event_addr, uint32_t flag,
+                              uint32_t value)
+{
+    return qts_wait_for_flag(global_qtest, RCC_BASE_ADDR + event_addr, f=
lag, value);
+}
+
+static void rcc_writel(unsigned int offset, uint32_t value)
+{
+    writel(RCC_BASE_ADDR + offset, value);
+}
+
+static uint32_t rcc_readl(unsigned int offset)
+{
+    return readl(RCC_BASE_ADDR + offset);
+}
+
+static void test_init_msi(void)
+{
+    /* MSIRANGE can be set only when MSI is OFF or READY */
+    rcc_writel(A_CR, R_CR_MSION_MASK);
+    /* Wait until MSI is stable */
+    g_assert_true(rcc_wait_for_flag(A_CR, R_CR_MSIRDY_MASK, R_CR_MSIRDY_=
MASK));
+    /* TODO find a way to test MSI value */
+}
+
+static void test_set_msi_as_sysclk(void)
+{
+    /* Clocking from MSI, in case MSI was not the default source */
+    rcc_writel(A_CFGR, 0);
+    /* Wait until MSI is selected and stable */
+    g_assert_true(rcc_wait_for_flag(A_CFGR, R_CFGR_SWS_MASK, 0));
+}
+
+static void test_init_pll(void)
+{
+    uint32_t value;
+
+    /*
+     * Update PLL and set MSI as the source clock.
+     * PLLM =3D 1 --> 000
+     * PLLN =3D 40 --> 40
+     * PPLLR =3D 2 --> 00
+     * PLLDIV =3D unused, PLLP =3D unused (SAI3), PLLQ =3D unused (48M1)
+     * SRC =3D MSI --> 01
+     */
+    rcc_writel(A_PLLCFGR, R_PLLCFGR_PLLREN_MASK |
+            (40 << R_PLLCFGR_PLLN_SHIFT) |
+            (0b01 << R_PLLCFGR_PLLSRC_SHIFT));
+
+    /* PLL activation */
+    value =3D rcc_readl(A_CR);
+    rcc_writel(A_CR, value | R_CR_PLLON_MASK);
+
+    /* Waiting for PLL lock. */
+    g_assert_true(rcc_wait_for_flag(A_CR, R_CR_PLLRDY_MASK, R_CR_PLLRDY_=
MASK));
+
+    /* Switches on the PLL clock source */
+    value =3D rcc_readl(A_CFGR);
+    rcc_writel(A_CFGR, (value & ~R_CFGR_SW_MASK) |
+        (0b11 << R_CFGR_SW_SHIFT));
+
+    /* Wait until SYSCLK is stable. */
+    g_assert_true(rcc_wait_for_flag(A_CFGR, R_CFGR_SWS_MASK,
+        (0b11 << R_CFGR_SWS_SHIFT)));
+}
+
+static void test_activate_lse(void)
+{
+    /* LSE activation, no LSE Bypass */
+    rcc_writel(A_BDCR, R_BDCR_LSEDRV_MASK | R_BDCR_LSEON_MASK);
+    g_assert_true(rcc_wait_for_flag(A_BDCR, R_BDCR_LSERDY_MASK, R_BDCR_L=
SERDY_MASK));
+}
+
+static void test_irq(void)
+{
+    enable_nvic_irq(RCC_IRQ);
+
+    rcc_writel(A_CIER, R_CIER_LSIRDYIE_MASK);
+    rcc_writel(A_CSR, R_CSR_LSION_MASK);
+    g_assert_true(check_nvic_pending(RCC_IRQ));
+    rcc_writel(A_CICR, R_CICR_LSIRDYC_MASK);
+    unpend_nvic_irq(RCC_IRQ);
+
+    rcc_writel(A_CIER, R_CIER_LSERDYIE_MASK);
+    rcc_writel(A_BDCR, R_BDCR_LSEON_MASK);
+    g_assert_true(check_nvic_pending(RCC_IRQ));
+    rcc_writel(A_CICR, R_CICR_LSERDYC_MASK);
+    unpend_nvic_irq(RCC_IRQ);
+
+    rcc_writel(A_CIER, R_CIER_MSIRDYIE_MASK);
+    rcc_writel(A_CR, R_CR_MSION_MASK);
+    g_assert_true(check_nvic_pending(RCC_IRQ));
+    rcc_writel(A_CICR, R_CICR_MSIRDYC_MASK);
+    unpend_nvic_irq(RCC_IRQ);
+
+    rcc_writel(A_CIER, R_CIER_HSIRDYIE_MASK);
+    rcc_writel(A_CR, R_CR_HSION_MASK);
+    g_assert_true(check_nvic_pending(RCC_IRQ));
+    rcc_writel(A_CICR, R_CICR_HSIRDYC_MASK);
+    unpend_nvic_irq(RCC_IRQ);
+
+    rcc_writel(A_CIER, R_CIER_HSERDYIE_MASK);
+    rcc_writel(A_CR, R_CR_HSEON_MASK);
+    g_assert_true(check_nvic_pending(RCC_IRQ));
+    rcc_writel(A_CICR, R_CICR_HSERDYC_MASK);
+    unpend_nvic_irq(RCC_IRQ);
+
+    rcc_writel(A_CIER, R_CIER_PLLRDYIE_MASK);
+    rcc_writel(A_CR, R_CR_PLLON_MASK);
+    g_assert_true(check_nvic_pending(RCC_IRQ));
+    rcc_writel(A_CICR, R_CICR_PLLRDYC_MASK);
+    unpend_nvic_irq(RCC_IRQ);
+
+    rcc_writel(A_CIER, R_CIER_PLLSAI1RDYIE_MASK);
+    rcc_writel(A_CR, R_CR_PLLSAI1ON_MASK);
+    g_assert_true(check_nvic_pending(RCC_IRQ));
+    rcc_writel(A_CICR, R_CICR_PLLSAI1RDYC_MASK);
+    unpend_nvic_irq(RCC_IRQ);
+
+    rcc_writel(A_CIER, R_CIER_PLLSAI2RDYIE_MASK);
+    rcc_writel(A_CR, R_CR_PLLSAI2ON_MASK);
+    g_assert_true(check_nvic_pending(RCC_IRQ));
+    rcc_writel(A_CICR, R_CICR_PLLSAI2RDYC_MASK);
+    unpend_nvic_irq(RCC_IRQ);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+    g_test_set_nonfatal_assertions();
+    /*
+     * These test separately that we can enable the plls, change the sys=
clk,
+     * and enable different devices.
+     * They are dependent on one another.
+     */
+    qtest_add_func("stm32l4x5/rcc/init_msi", test_init_msi);
+    qtest_add_func("stm32l4x5/rcc/set_msi_as_sysclk",
+        test_set_msi_as_sysclk);
+    qtest_add_func("stm32l4x5/rcc/activate_lse", test_activate_lse);
+    qtest_add_func("stm32l4x5/rcc/init_pll", test_init_pll);
+
+    qtest_add_func("stm32l4x5/rcc/irq", test_irq);
+
+    qtest_start("-machine b-l475e-iot01a");
+    ret =3D g_test_run();
+    qtest_end();
+
+    return ret;
+}
--=20
2.34.1


