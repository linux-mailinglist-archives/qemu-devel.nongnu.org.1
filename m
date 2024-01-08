Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1C1827709
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:12:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMu5z-00053U-LL; Mon, 08 Jan 2024 13:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rMu5r-00051h-Dj; Mon, 08 Jan 2024 13:11:23 -0500
Received: from zproxy1.enst.fr ([137.194.2.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rMu5h-0003FC-UT; Mon, 08 Jan 2024 13:11:23 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 787FEC065A;
 Mon,  8 Jan 2024 19:11:12 +0100 (CET)
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id gMQQ8fCfOd8L; Mon,  8 Jan 2024 19:11:11 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 81FB2C0C9E;
 Mon,  8 Jan 2024 19:11:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy1.enst.fr 81FB2C0C9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1704737471;
 bh=GrQbGB7uFSdKMqnuxUXHBm51o5N0wnAfJ0XGl7B0aOs=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=L+y3kcd456Nx96jo9LXIjoTNUhkiBF+AQHN6rqDyEhq2J7L5LMfe2DiJ1nOOs+59L
 Bgg1mpLVzaS2c78g66GU0tkGgSoWqH6LNGZTkAj9lKt4ePbkh6c/5lS/avrDmv2vVh
 hekZmS6uzAzyOc/BxNUMO6+vei0U05hEh8RAnoXU=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id JwjWlhy_b2Wq; Mon,  8 Jan 2024 19:11:11 +0100 (CET)
Received: from localhost.localdomain (74.0.125.80.rev.sfr.net [80.125.0.74])
 by zproxy1.enst.fr (Postfix) with ESMTPSA id DA0DFC065A;
 Mon,  8 Jan 2024 19:11:10 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-arm@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 3/3] tests/qtest: Add STM32L4x5 EXTI QTest testcase
Date: Mon,  8 Jan 2024 19:03:06 +0100
Message-ID: <20240108181104.46880-4-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108181104.46880-1-ines.varhol@telecom-paris.fr>
References: <20240108181104.46880-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.220;
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 tests/qtest/meson.build           |   5 +
 tests/qtest/stm32l4x5_exti-test.c | 590 ++++++++++++++++++++++++++++++
 2 files changed, 595 insertions(+)
 create mode 100644 tests/qtest/stm32l4x5_exti-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index f25bffcc20..d890b6f333 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -194,6 +194,10 @@ qtests_aspeed =3D \
   ['aspeed_hace-test',
    'aspeed_smc-test',
    'aspeed_gpio-test']
+
+qtests_stm32l4x5 =3D \
+  ['stm32l4x5_exti-test']
+
 qtests_arm =3D \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) =
+ \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-ap=
b-dualtimer-test'] : []) + \
@@ -207,6 +211,7 @@ qtests_arm =3D \
   (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test=
'] : []) + \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] =
: []) + \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : [=
]) + \
+  (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5=
 : []) + \
   ['arm-cpu-features',
    'boot-serial-test']
=20
diff --git a/tests/qtest/stm32l4x5_exti-test.c b/tests/qtest/stm32l4x5_ex=
ti-test.c
new file mode 100644
index 0000000000..faba530a24
--- /dev/null
+++ b/tests/qtest/stm32l4x5_exti-test.c
@@ -0,0 +1,590 @@
+/*
+ * QTest testcase for STM32L4x5_EXTI
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
+#define EXTI_BASE_ADDR 0x40010400
+#define EXTI_IMR1 0x00
+#define EXTI_EMR1 0x04
+#define EXTI_RTSR1 0x08
+#define EXTI_FTSR1 0x0C
+#define EXTI_SWIER1 0x10
+#define EXTI_PR1 0x14
+#define EXTI_IMR2 0x20
+#define EXTI_EMR2 0x24
+#define EXTI_RTSR2 0x28
+#define EXTI_FTSR2 0x2C
+#define EXTI_SWIER2 0x30
+#define EXTI_PR2 0x34
+
+#define NVIC_ISER 0xE000E100
+#define NVIC_ISPR 0xE000E200
+#define NVIC_ICPR 0xE000E280
+
+#define EXTI0_IRQ 6
+#define EXTI1_IRQ 7
+#define EXTI35_IRQ 1
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
+static void exti_writel(unsigned int offset, uint32_t value)
+{
+    writel(EXTI_BASE_ADDR + offset, value);
+}
+
+static uint32_t exti_readl(unsigned int offset)
+{
+    return readl(EXTI_BASE_ADDR + offset);
+}
+
+static void exti_set_irq(int num, int level)
+{
+   qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL,
+                    num, level);
+}
+
+static void test_reg_write_read(void)
+{
+    /* Test that non-reserved bits in xMR and xTSR can be set and cleare=
d */
+
+    exti_writel(EXTI_IMR1, 0xFFFFFFFF);
+    uint32_t imr1 =3D exti_readl(EXTI_IMR1);
+    g_assert_cmpuint(imr1, =3D=3D, 0xFFFFFFFF);
+    exti_writel(EXTI_IMR1, 0x00000000);
+    imr1 =3D exti_readl(EXTI_IMR1);
+    g_assert_cmpuint(imr1, =3D=3D, 0x00000000);
+
+    exti_writel(EXTI_EMR1, 0xFFFFFFFF);
+    uint32_t emr1 =3D exti_readl(EXTI_EMR1);
+    g_assert_cmpuint(emr1, =3D=3D, 0xFFFFFFFF);
+    exti_writel(EXTI_EMR1, 0x00000000);
+    emr1 =3D exti_readl(EXTI_EMR1);
+    g_assert_cmpuint(emr1, =3D=3D, 0x00000000);
+
+    exti_writel(EXTI_RTSR1, 0xFFFFFFFF);
+    uint32_t rtsr1 =3D exti_readl(EXTI_RTSR1);
+    g_assert_cmpuint(rtsr1, =3D=3D, 0x007DFFFF);
+    exti_writel(EXTI_RTSR1, 0x00000000);
+    rtsr1 =3D exti_readl(EXTI_RTSR1);
+    g_assert_cmpuint(rtsr1, =3D=3D, 0x00000000);
+
+    exti_writel(EXTI_FTSR1, 0xFFFFFFFF);
+    uint32_t ftsr1 =3D exti_readl(EXTI_FTSR1);
+    g_assert_cmpuint(ftsr1, =3D=3D, 0x007DFFFF);
+    exti_writel(EXTI_FTSR1, 0x00000000);
+    ftsr1 =3D exti_readl(EXTI_FTSR1);
+    g_assert_cmpuint(ftsr1, =3D=3D, 0x00000000);
+
+    exti_writel(EXTI_IMR2, 0xFFFFFFFF);
+    uint32_t imr2 =3D exti_readl(EXTI_IMR2);
+    g_assert_cmpuint(imr2, =3D=3D, 0x000000FF);
+    exti_writel(EXTI_IMR2, 0x00000000);
+    imr2 =3D exti_readl(EXTI_IMR2);
+    g_assert_cmpuint(imr2, =3D=3D, 0x00000000);
+
+    exti_writel(EXTI_EMR2, 0xFFFFFFFF);
+    uint32_t emr2 =3D exti_readl(EXTI_EMR2);
+    g_assert_cmpuint(emr2, =3D=3D, 0x000000FF);
+    exti_writel(EXTI_EMR2, 0x00000000);
+    emr2 =3D exti_readl(EXTI_EMR2);
+    g_assert_cmpuint(emr2, =3D=3D, 0x00000000);
+
+    exti_writel(EXTI_RTSR2, 0xFFFFFFFF);
+    uint32_t rtsr2 =3D exti_readl(EXTI_RTSR2);
+    g_assert_cmpuint(rtsr2, =3D=3D, 0x00000078);
+    exti_writel(EXTI_RTSR2, 0x00000000);
+    rtsr2 =3D exti_readl(EXTI_RTSR2);
+    g_assert_cmpuint(rtsr2, =3D=3D, 0x00000000);
+
+    exti_writel(EXTI_FTSR2, 0xFFFFFFFF);
+    uint32_t ftsr2 =3D exti_readl(EXTI_FTSR2);
+    g_assert_cmpuint(ftsr2, =3D=3D, 0x00000078);
+    exti_writel(EXTI_FTSR2, 0x00000000);
+    ftsr2 =3D exti_readl(EXTI_FTSR2);
+    g_assert_cmpuint(ftsr2, =3D=3D, 0x00000000);
+}
+
+static void test_direct_lines_write(void)
+{
+    /* Test that direct lines reserved bits are not written to */
+
+    exti_writel(EXTI_RTSR1, 0xFF820000);
+    uint32_t rtsr1 =3D exti_readl(EXTI_RTSR1);
+    g_assert_cmpuint(rtsr1, =3D=3D, 0x00000000);
+
+    exti_writel(EXTI_FTSR1, 0xFF820000);
+    uint32_t ftsr1 =3D exti_readl(EXTI_FTSR1);
+    g_assert_cmpuint(ftsr1, =3D=3D, 0x00000000);
+
+    exti_writel(EXTI_SWIER1, 0xFF820000);
+    uint32_t swier1 =3D exti_readl(EXTI_SWIER1);
+    g_assert_cmpuint(swier1, =3D=3D, 0x00000000);
+
+    exti_writel(EXTI_PR1, 0xFF820000);
+    uint32_t pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
+
+    exti_writel(EXTI_RTSR2, 0x00000087);
+    const uint32_t rtsr2 =3D exti_readl(EXTI_RTSR2);
+    g_assert_cmpuint(rtsr2, =3D=3D, 0x00000000);
+
+    exti_writel(EXTI_FTSR2, 0x00000087);
+    const uint32_t ftsr2 =3D exti_readl(EXTI_FTSR2);
+    g_assert_cmpuint(ftsr2, =3D=3D, 0x00000000);
+
+    exti_writel(EXTI_SWIER2, 0x00000087);
+    const uint32_t swier2 =3D exti_readl(EXTI_SWIER2);
+    g_assert_cmpuint(swier2, =3D=3D, 0x00000000);
+
+    exti_writel(EXTI_PR2, 0x00000087);
+    const uint32_t pr2 =3D exti_readl(EXTI_PR2);
+    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
+}
+
+static void test_reserved_bits_write(void)
+{
+    /* Test that reserved bits stay are not written to */
+
+    exti_writel(EXTI_IMR2, 0xFFFFFF00);
+    uint32_t imr2 =3D exti_readl(EXTI_IMR2);
+    g_assert_cmpuint(imr2, =3D=3D, 0x00000000);
+
+    exti_writel(EXTI_EMR2, 0xFFFFFF00);
+    uint32_t emr2 =3D exti_readl(EXTI_EMR2);
+    g_assert_cmpuint(emr2, =3D=3D, 0x00000000);
+
+    exti_writel(EXTI_RTSR2, 0xFFFFFF00);
+    const uint32_t rtsr2 =3D exti_readl(EXTI_RTSR2);
+    g_assert_cmpuint(rtsr2, =3D=3D, 0x00000000);
+
+    exti_writel(EXTI_FTSR2, 0xFFFFFF00);
+    const uint32_t ftsr2 =3D exti_readl(EXTI_FTSR2);
+    g_assert_cmpuint(ftsr2, =3D=3D, 0x00000000);
+
+    exti_writel(EXTI_SWIER2, 0xFFFFFF00);
+    const uint32_t swier2 =3D exti_readl(EXTI_SWIER2);
+    g_assert_cmpuint(swier2, =3D=3D, 0x00000000);
+
+    exti_writel(EXTI_PR2, 0xFFFFFF00);
+    const uint32_t pr2 =3D exti_readl(EXTI_PR2);
+    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
+}
+
+static void test_software_interrupt(void)
+{
+    /*
+     * Test that we can launch a software irq by :
+     * - enabling its line in IMR
+     * - and then setting a bit from '0' to '1' in SWIER
+     *
+     * And that the interruption stays pending in NVIC
+     * even after clearing the pending bit in PR.
+     */
+
+    /*
+     * Testing interrupt line EXTI0
+     * Bit 0 in EXTI_*1 registers (EXTI0) corresponds to GPIO Px_0
+     */
+
+    enable_nvic_irq(EXTI0_IRQ);
+    /* Check that there are no interrupts already pending in PR */
+    uint32_t pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
+    /* Check that this specific interrupt isn't pending in NVIC */
+    g_assert_false(check_nvic_pending(EXTI0_IRQ));
+
+    /* Enable interrupt line EXTI0 */
+    exti_writel(EXTI_IMR1, 0x00000001);
+    /* Set the right SWIER bit from '0' to '1' */
+    exti_writel(EXTI_SWIER1, 0x00000000);
+    exti_writel(EXTI_SWIER1, 0x00000001);
+
+    /* Check that the write in SWIER was effective */
+    uint32_t swier1 =3D exti_readl(EXTI_SWIER1);
+    g_assert_cmpuint(swier1, =3D=3D, 0x00000001);
+    /* Check that the corresponding pending bit in PR is set */
+    pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000001);
+    /* Check that the corresponding interrupt is pending in the NVIC */
+    g_assert_true(check_nvic_pending(EXTI0_IRQ));
+
+    /* Clear the pending bit in PR */
+    exti_writel(EXTI_PR1, 0x00000001);
+
+    /* Check that the write in PR was effective */
+    pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
+    /* Check that the corresponding bit in SWIER was cleared */
+    swier1 =3D exti_readl(EXTI_SWIER1);
+    g_assert_cmpuint(swier1, =3D=3D, 0x00000000);
+    /* Check that the interrupt is still pending in the NVIC */
+    g_assert_true(check_nvic_pending(EXTI0_IRQ));
+
+    /*
+     * Testing interrupt line EXTI35
+     * Bit 3 in EXTI_*2 registers (EXTI35) corresponds to PVM 1 Wakeup
+     */
+
+    enable_nvic_irq(EXTI35_IRQ);
+    /* Check that there are no interrupts already pending */
+    uint32_t pr2 =3D exti_readl(EXTI_PR2);
+    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
+    g_assert_false(check_nvic_pending(EXTI35_IRQ));
+
+    /* Enable interrupt line EXTI0 */
+    exti_writel(EXTI_IMR2, 0x00000008);
+    /* Set the right SWIER bit from '0' to '1' */
+    exti_writel(EXTI_SWIER2, 0x00000000);
+    exti_writel(EXTI_SWIER2, 0x00000008);
+
+    /* Check that the write in SWIER was effective */
+    uint32_t swier2 =3D exti_readl(EXTI_SWIER2);
+    g_assert_cmpuint(swier2, =3D=3D, 0x00000008);
+    /* Check that the corresponding pending bit in PR is set */
+    pr2 =3D exti_readl(EXTI_PR2);
+    g_assert_cmpuint(pr2, =3D=3D, 0x00000008);
+    /* Check that the corresponding interrupt is pending in the NVIC */
+    g_assert_true(check_nvic_pending(EXTI35_IRQ));
+
+    /* Clear the pending bit in PR */
+    exti_writel(EXTI_PR2, 0x00000008);
+
+    /* Check that the write in PR was effective */
+    pr2 =3D exti_readl(EXTI_PR2);
+    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
+    /* Check that the corresponding bit in SWIER was cleared */
+    swier2 =3D exti_readl(EXTI_SWIER2);
+    g_assert_cmpuint(swier2, =3D=3D, 0x00000000);
+    /* Check that the interrupt is still pending in the NVIC */
+    g_assert_true(check_nvic_pending(EXTI35_IRQ));
+
+    /* Clean NVIC */
+    unpend_nvic_irq(EXTI0_IRQ);
+    g_assert_false(check_nvic_pending(EXTI0_IRQ));
+    unpend_nvic_irq(EXTI35_IRQ);
+    g_assert_false(check_nvic_pending(EXTI35_IRQ));
+}
+
+static void test_edge_selector(void)
+{
+    enable_nvic_irq(EXTI0_IRQ);
+
+    /* Configure EXTI line 0 irq on rising edge */
+    exti_set_irq(0, 1);
+    exti_writel(EXTI_IMR1, 0x00000001);
+    exti_writel(EXTI_RTSR1, 0x00000001);
+    exti_writel(EXTI_FTSR1, 0x00000000);
+
+    /* Test that an irq is raised on rising edge only */
+    exti_set_irq(0, 0);
+    uint32_t pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
+    g_assert_false(check_nvic_pending(EXTI0_IRQ));
+
+    exti_set_irq(0, 1);
+    pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000001);
+    g_assert_true(check_nvic_pending(EXTI0_IRQ));
+
+    /* Clean the test */
+    exti_writel(EXTI_PR1, 0x00000001);
+    pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
+    unpend_nvic_irq(EXTI0_IRQ);
+    g_assert_false(check_nvic_pending(EXTI0_IRQ));
+
+    /* Configure EXTI line 0 irq on falling edge */
+    exti_set_irq(0, 0);
+    exti_writel(EXTI_IMR1, 0x00000001);
+    exti_writel(EXTI_RTSR1, 0x00000000);
+    exti_writel(EXTI_FTSR1, 0x00000001);
+
+    /* Test that an irq is raised on falling edge only */
+    exti_set_irq(0, 1);
+    pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
+    g_assert_false(check_nvic_pending(EXTI0_IRQ));
+
+    exti_set_irq(0, 0);
+    pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000001);
+    g_assert_true(check_nvic_pending(EXTI0_IRQ));
+
+    /* Clean the test */
+    exti_writel(EXTI_PR1, 0x00000001);
+    pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
+    unpend_nvic_irq(EXTI0_IRQ);
+    g_assert_false(check_nvic_pending(EXTI0_IRQ));
+
+    /* Configure EXTI line 0 irq on falling and rising edge */
+    exti_writel(EXTI_IMR1, 0x00000001);
+    exti_writel(EXTI_RTSR1, 0x00000001);
+    exti_writel(EXTI_FTSR1, 0x00000001);
+
+    /* Test that an irq is raised on rising edge */
+    exti_set_irq(0, 1);
+    pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000001);
+    g_assert_true(check_nvic_pending(EXTI0_IRQ));
+
+    /* Clean the test */
+    exti_writel(EXTI_PR1, 0x00000001);
+    pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
+    unpend_nvic_irq(EXTI0_IRQ);
+    g_assert_false(check_nvic_pending(EXTI0_IRQ));
+
+    /* Test that an irq is raised on falling edge */
+    exti_set_irq(0, 0);
+    pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000001);
+    g_assert_true(check_nvic_pending(EXTI0_IRQ));
+
+    /* Clean the test */
+    exti_writel(EXTI_PR1, 0x00000001);
+    pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
+    unpend_nvic_irq(EXTI0_IRQ);
+    g_assert_false(check_nvic_pending(EXTI0_IRQ));
+
+    /* Configure EXTI line 0 irq without selecting an edge trigger */
+    exti_writel(EXTI_IMR1, 0x00000001);
+    exti_writel(EXTI_RTSR1, 0x00000000);
+    exti_writel(EXTI_FTSR1, 0x00000000);
+
+    /* Test that no irq is raised */
+    exti_set_irq(0, 1);
+    pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
+    g_assert_false(check_nvic_pending(EXTI0_IRQ));
+
+    exti_set_irq(0, 0);
+    pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
+    g_assert_false(check_nvic_pending(EXTI0_IRQ));
+}
+
+static void test_no_software_interrupt(void)
+{
+    /*
+     * Test that software irq doesn't happen when :
+     * - corresponding bit in IMR isn't set
+     * - SWIER is set to 1 before IMR is set to 1
+     */
+
+    /*
+     * Testing interrupt line EXTI0
+     * Bit 0 in EXTI_*1 registers (EXTI0) corresponds to GPIO Px_0
+     */
+
+    enable_nvic_irq(EXTI0_IRQ);
+    /* Check that there are no interrupts already pending in PR */
+    uint32_t pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
+    /* Check that this specific interrupt isn't pending in NVIC */
+    g_assert_false(check_nvic_pending(EXTI0_IRQ));
+
+    /* Mask interrupt line EXTI0 */
+    exti_writel(EXTI_IMR1, 0x00000000);
+    /* Set the corresponding SWIER bit from '0' to '1' */
+    exti_writel(EXTI_SWIER1, 0x00000000);
+    exti_writel(EXTI_SWIER1, 0x00000001);
+
+    /* Check that the write in SWIER was effective */
+    uint32_t swier1 =3D exti_readl(EXTI_SWIER1);
+    g_assert_cmpuint(swier1, =3D=3D, 0x00000001);
+    /* Check that the pending bit in PR wasn't set */
+    pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
+    /* Check that the interrupt isn't pending in NVIC */
+    g_assert_false(check_nvic_pending(EXTI0_IRQ));
+
+    /* Enable interrupt line EXTI0 */
+    exti_writel(EXTI_IMR1, 0x00000001);
+
+    /* Check that the pending bit in PR wasn't set */
+    pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
+    /* Check that the interrupt isn't pending in NVIC */
+    g_assert_false(check_nvic_pending(EXTI0_IRQ));
+
+    /*
+     * Testing interrupt line EXTI35
+     * Bit 3 in EXTI_*2 registers (EXTI35) corresponds to PVM 1 Wakeup
+     */
+
+    enable_nvic_irq(EXTI35_IRQ);
+    /* Check that there are no interrupts already pending in PR */
+    uint32_t pr2 =3D exti_readl(EXTI_PR2);
+    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
+    /* Check that this specific interrupt isn't pending in NVIC */
+    g_assert_false(check_nvic_pending(EXTI35_IRQ));
+
+    /* Mask interrupt line EXTI35 */
+    exti_writel(EXTI_IMR2, 0x00000000);
+    /* Set the corresponding SWIER bit from '0' to '1' */
+    exti_writel(EXTI_SWIER2, 0x00000000);
+    exti_writel(EXTI_SWIER2, 0x00000008);
+
+    /* Check that the write in SWIER was effective */
+    uint32_t swier2 =3D exti_readl(EXTI_SWIER2);
+    g_assert_cmpuint(swier2, =3D=3D, 0x00000008);
+    /* Check that the pending bit in PR wasn't set */
+    pr2 =3D exti_readl(EXTI_PR2);
+    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
+    /* Check that the interrupt isn't pending in NVIC */
+    g_assert_false(check_nvic_pending(EXTI35_IRQ));
+
+    /* Enable interrupt line EXTI35 */
+    exti_writel(EXTI_IMR2, 0x00000008);
+
+    /* Check that the pending bit in PR wasn't set */
+    pr2 =3D exti_readl(EXTI_PR2);
+    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
+    /* Check that the interrupt isn't pending in NVIC */
+    g_assert_false(check_nvic_pending(EXTI35_IRQ));
+}
+
+static void test_masked_interrupt(void)
+{
+    /*
+     * Test that irq doesn't happen when :
+     * - corresponding bit in IMR isn't set
+     * - SWIER is set to 1 before IMR is set to 1
+     */
+
+    /*
+     * Testing interrupt line EXTI1
+     * with rising edge from GPIOx pin 1
+     */
+
+    enable_nvic_irq(EXTI1_IRQ);
+    /* Check that there are no interrupts already pending in PR */
+    uint32_t pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
+    /* Check that this specific interrupt isn't pending in NVIC */
+    g_assert_false(check_nvic_pending(EXTI1_IRQ));
+
+    /* Mask interrupt line EXTI1 */
+    exti_writel(EXTI_IMR1, 0x00000000);
+
+    /* Configure interrupt on rising edge */
+    exti_writel(EXTI_RTSR1, 0x00000002);
+
+    /* Simulate rising edge from GPIO line 1 */
+    exti_set_irq(1, 1);
+
+    /* Check that the pending bit in PR wasn't set */
+    pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
+    /* Check that the interrupt isn't pending in NVIC */
+    g_assert_false(check_nvic_pending(EXTI1_IRQ));
+
+    /* Enable interrupt line EXTI1 */
+    exti_writel(EXTI_IMR1, 0x00000002);
+
+    /* Check that the pending bit in PR wasn't set */
+    pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
+    /* Check that the interrupt isn't pending in NVIC */
+    g_assert_false(check_nvic_pending(EXTI1_IRQ));
+}
+
+static void test_interrupt(void)
+{
+    /*
+     * Test that we can launch an irq by :
+     * - enabling its line in IMR
+     * - configuring interrupt on rising edge
+     * - and then setting the input line from '0' to '1'
+     *
+     * And that the interruption stays pending in NVIC
+     * even after clearing the pending bit in PR.
+     */
+
+    /*
+     * Testing interrupt line EXTI1
+     * with rising edge from GPIOx pin 1
+     */
+
+    enable_nvic_irq(EXTI1_IRQ);
+    /* Check that there are no interrupts already pending in PR */
+    uint32_t pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
+    /* Check that this specific interrupt isn't pending in NVIC */
+    g_assert_false(check_nvic_pending(EXTI1_IRQ));
+
+    /* Enable interrupt line EXTI1 */
+    exti_writel(EXTI_IMR1, 0x00000002);
+
+    /* Configure interrupt on rising edge */
+    exti_writel(EXTI_RTSR1, 0x00000002);
+
+    /* Simulate rising edge from GPIO line 1 */
+    exti_set_irq(1, 1);
+
+    /* Check that the pending bit in PR was set */
+    pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000002);
+    /* Check that the interrupt is pending in NVIC */
+    g_assert_true(check_nvic_pending(EXTI1_IRQ));
+
+    /* Clear the pending bit in PR */
+    exti_writel(EXTI_PR1, 0x00000002);
+
+    /* Check that the write in PR was effective */
+    pr1 =3D exti_readl(EXTI_PR1);
+    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
+    /* Check that the interrupt is still pending in the NVIC */
+    g_assert_true(check_nvic_pending(EXTI1_IRQ));
+
+    /* Clean NVIC */
+    unpend_nvic_irq(EXTI1_IRQ);
+    g_assert_false(check_nvic_pending(EXTI1_IRQ));
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+    g_test_set_nonfatal_assertions();
+    qtest_add_func("stm32l4x5/exti/direct_lines", test_direct_lines_writ=
e);
+    qtest_add_func("stm32l4x5/exti/reserved_bits", test_reserved_bits_wr=
ite);
+    qtest_add_func("stm32l4x5/exti/reg_write_read", test_reg_write_read)=
;
+    qtest_add_func("stm32l4x5/exti/no_software_interrupt",
+                   test_no_software_interrupt);
+    qtest_add_func("stm32l4x5/exti/software_interrupt",
+                   test_software_interrupt);
+    qtest_add_func("stm32l4x5/exti/masked_interrupt", test_masked_interr=
upt);
+    qtest_add_func("stm32l4x5/exti/interrupt", test_interrupt);
+    qtest_add_func("stm32l4x5/exti/test_edge_selector", test_edge_select=
or);
+
+    qtest_start("-machine b-l475e-iot01a");
+    ret =3D g_test_run();
+    qtest_end();
+
+    return ret;
+}
--=20
2.43.0


