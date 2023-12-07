Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC8D8169B1
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 10:19:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF9lh-0003PY-TM; Mon, 18 Dec 2023 04:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1rF9lR-0003AX-Vp; Mon, 18 Dec 2023 04:18:25 -0500
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1rF9lN-00005X-Nk; Mon, 18 Dec 2023 04:18:17 -0500
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id B93DD11EFCD;
 Mon, 18 Dec 2023 09:18:10 +0000 (UTC)
From: ~inesvarhol <inesvarhol@git.sr.ht>
Date: Thu, 07 Dec 2023 21:12:42 +0100
Subject: [PATCH qemu v3 2/3] tests/qtest: Add STM32L4x5 EXTI QTest testcase
MIME-Version: 1.0
Message-ID: <170289109015.23396.9428181315206234398-2@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <170289109015.23396.9428181315206234398-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alistair@alistair23.me, philmd@linaro.org,
 peter.maydell@linaro.org, ines.varhol@telecom-paris.fr,
 arnaud.minier@telecom-paris.fr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: ~inesvarhol <inesvarhol@proton.me>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 tests/qtest/meson.build           |   5 +
 tests/qtest/stm32l4x5_exti-test.c | 485 ++++++++++++++++++++++++++++++
 2 files changed, 490 insertions(+)
 create mode 100644 tests/qtest/stm32l4x5_exti-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 47dabf91d0..d5126f4d86 100644
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
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-du=
altimer-test'] : []) + \
@@ -207,6 +211,7 @@ qtests_arm =3D \
   (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] :=
 []) + \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []=
) + \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) +=
 \
+  (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : [=
]) + \
   ['arm-cpu-features',
    'boot-serial-test']
=20
diff --git a/tests/qtest/stm32l4x5_exti-test.c b/tests/qtest/stm32l4x5_exti-t=
est.c
new file mode 100644
index 0000000000..e105b3dea3
--- /dev/null
+++ b/tests/qtest/stm32l4x5_exti-test.c
@@ -0,0 +1,485 @@
+/*
+ * QTest testcase for STM32L4x5_EXTI
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
+static void test_reg_write_read(void)
+{
+    /* Test that non-reserved bits in xMR and xTSR can be set and cleared */
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
+    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
+                     NULL, 1, 1);
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
+    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
+                     NULL, 1, 1);
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
+    qtest_add_func("stm32l4x5/exti/direct_lines", test_direct_lines_write);
+    qtest_add_func("stm32l4x5/exti/reserved_bits", test_reserved_bits_write);
+    qtest_add_func("stm32l4x5/exti/reg_write_read", test_reg_write_read);
+    qtest_add_func("stm32l4x5/exti/no_software_interrupt",
+                   test_no_software_interrupt);
+    qtest_add_func("stm32l4x5/exti/software_interrupt",
+                   test_software_interrupt);
+    qtest_add_func("stm32l4x5/exti/masked_interrupt", test_masked_interrupt);
+    qtest_add_func("stm32l4x5/exti/interrupt", test_interrupt);
+
+    qtest_start("-machine b-l475e-iot01a");
+    ret =3D g_test_run();
+    qtest_end();
+
+    return ret;
+}
--=20
2.38.5


