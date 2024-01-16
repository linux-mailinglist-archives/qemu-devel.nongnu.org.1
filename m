Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A557B82F137
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:16:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPl7K-0006fT-8j; Tue, 16 Jan 2024 10:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7F-0006cV-4W
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:37 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7B-0005pd-GY
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:36 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e779f030aso12579735e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 07:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705417952; x=1706022752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ST4HN3WaBRlCi3tLBjOoq22VPiz73Yp89Mu5XAstrUU=;
 b=wZVprqFNOIsO1BXV1nQnJ23P/nwLU/Do00nf/7BOXSvvXp/faLLsxjpNwtzhdel0Om
 LFRqCnsZBonJehb9awAwR+KVFE2KNmlJjTBxoHlWHG+nbbSEqxF91rL2FocUsdE/Lg/7
 fJibp2a9a8lE7533pAxH+9V2AMFP3M0eZ1nrwg92h0VYCr2kxjEtCe4UlNAUXa8k1qyj
 SbmvhrXJHNhK2s+FXd26XIYO72ZXvxQmCID6lXMt5JXdGTdQPtoGZQto3tM5tjoDSPc0
 GHTIIvmi0K+aYA+YBnXNfG5MdveoCaEKNyV7kI4sZiZY4HHxA9Z+r8WtjuRmsZyu6/MX
 CXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705417952; x=1706022752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ST4HN3WaBRlCi3tLBjOoq22VPiz73Yp89Mu5XAstrUU=;
 b=VIXdL4pZHV3MjQh2mldFEhveX0KHc594y6KlFMmMqxOky4QMRXHzepgoq6KdRFbbyp
 C/DgquJOJmLqaIfppKkoUT+OQHxa+Hlih3eBBF8TrPcO+j95Nxec1SxwhT7unduMPbHq
 SigeSJz0RsqJrYU2ixGonQ/fU08h9aKBbQOHWpWRCIdFIEvRkRZZ3bomSc/7DklYYZ69
 VgOvO8lgMZp3X93I+au6H+m+tqGBFWZbLfuR82dH2z3or23icrmr4pLXk8LmOPpn+kvE
 ylTZK+RIEn4cnW5CUnHggheRZb/6oBADS0QZRC2i0j/NEWbrfy33psYgkoYXXTofS305
 7wgQ==
X-Gm-Message-State: AOJu0YxU5kpxvyKBab37j2pf0g2rirwauOgnFRoOvh1wjOKWbKaUh6Q5
 7yzIry6XgsK3B4633vUzFVpTpCcNU0e96jDc8Ku66alCsCY=
X-Google-Smtp-Source: AGHT+IFhSEXRze2WwSpD80RuuZRTD+IzOfPJw1mVcNqbRFpSG1NVOKmkA/W8uICC1ISERWiDoJEaKg==
X-Received: by 2002:a05:600c:511f:b0:40d:770e:fd85 with SMTP id
 o31-20020a05600c511f00b0040d770efd85mr4312067wms.13.1705417951728; 
 Tue, 16 Jan 2024 07:12:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020adff38e000000b003379b549a00sm10091357wro.10.2024.01.16.07.12.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 07:12:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/21] tests/qtest: Add STM32L4x5 EXTI QTest testcase
Date: Tue, 16 Jan 2024 15:12:13 +0000
Message-Id: <20240116151228.2430754-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116151228.2430754-1-peter.maydell@linaro.org>
References: <20240116151228.2430754-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Inès Varhol <ines.varhol@telecom-paris.fr>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Message-id: 20240109160658.311932-4-ines.varhol@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/stm32l4x5_exti-test.c | 524 ++++++++++++++++++++++++++++++
 tests/qtest/meson.build           |   5 +
 2 files changed, 529 insertions(+)
 create mode 100644 tests/qtest/stm32l4x5_exti-test.c

diff --git a/tests/qtest/stm32l4x5_exti-test.c b/tests/qtest/stm32l4x5_exti-test.c
new file mode 100644
index 00000000000..c3900777139
--- /dev/null
+++ b/tests/qtest/stm32l4x5_exti-test.c
@@ -0,0 +1,524 @@
+/*
+ * QTest testcase for STM32L4x5_EXTI
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
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
+static void exti_set_irq(int num, int level)
+{
+   qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL,
+                    num, level);
+}
+
+static void test_reg_write_read(void)
+{
+    /* Test that non-reserved bits in xMR and xTSR can be set and cleared */
+
+    exti_writel(EXTI_IMR1, 0xFFFFFFFF);
+    g_assert_cmpuint(exti_readl(EXTI_IMR1), ==, 0xFFFFFFFF);
+    exti_writel(EXTI_IMR1, 0x00000000);
+    g_assert_cmpuint(exti_readl(EXTI_IMR1), ==, 0x00000000);
+
+    exti_writel(EXTI_EMR1, 0xFFFFFFFF);
+    g_assert_cmpuint(exti_readl(EXTI_EMR1), ==, 0xFFFFFFFF);
+    exti_writel(EXTI_EMR1, 0x00000000);
+    g_assert_cmpuint(exti_readl(EXTI_EMR1), ==, 0x00000000);
+
+    exti_writel(EXTI_RTSR1, 0xFFFFFFFF);
+    g_assert_cmpuint(exti_readl(EXTI_RTSR1), ==, 0x007DFFFF);
+    exti_writel(EXTI_RTSR1, 0x00000000);
+    g_assert_cmpuint(exti_readl(EXTI_RTSR1), ==, 0x00000000);
+
+    exti_writel(EXTI_FTSR1, 0xFFFFFFFF);
+    g_assert_cmpuint(exti_readl(EXTI_FTSR1), ==, 0x007DFFFF);
+    exti_writel(EXTI_FTSR1, 0x00000000);
+    g_assert_cmpuint(exti_readl(EXTI_FTSR1), ==, 0x00000000);
+
+    exti_writel(EXTI_IMR2, 0xFFFFFFFF);
+    g_assert_cmpuint(exti_readl(EXTI_IMR2), ==, 0x000000FF);
+    exti_writel(EXTI_IMR2, 0x00000000);
+    g_assert_cmpuint(exti_readl(EXTI_IMR2), ==, 0x00000000);
+
+    exti_writel(EXTI_EMR2, 0xFFFFFFFF);
+    g_assert_cmpuint(exti_readl(EXTI_EMR2), ==, 0x000000FF);
+    exti_writel(EXTI_EMR2, 0x00000000);
+    g_assert_cmpuint(exti_readl(EXTI_EMR2), ==, 0x00000000);
+
+    exti_writel(EXTI_RTSR2, 0xFFFFFFFF);
+    g_assert_cmpuint(exti_readl(EXTI_RTSR2), ==, 0x00000078);
+    exti_writel(EXTI_RTSR2, 0x00000000);
+    g_assert_cmpuint(exti_readl(EXTI_RTSR2), ==, 0x00000000);
+
+    exti_writel(EXTI_FTSR2, 0xFFFFFFFF);
+    g_assert_cmpuint(exti_readl(EXTI_FTSR2), ==, 0x00000078);
+    exti_writel(EXTI_FTSR2, 0x00000000);
+    g_assert_cmpuint(exti_readl(EXTI_FTSR2), ==, 0x00000000);
+}
+
+static void test_direct_lines_write(void)
+{
+    /* Test that direct lines reserved bits are not written to */
+
+    exti_writel(EXTI_RTSR1, 0xFF820000);
+    g_assert_cmpuint(exti_readl(EXTI_RTSR1), ==, 0x00000000);
+
+    exti_writel(EXTI_FTSR1, 0xFF820000);
+    g_assert_cmpuint(exti_readl(EXTI_FTSR1), ==, 0x00000000);
+
+    exti_writel(EXTI_SWIER1, 0xFF820000);
+    g_assert_cmpuint(exti_readl(EXTI_SWIER1), ==, 0x00000000);
+
+    exti_writel(EXTI_PR1, 0xFF820000);
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+
+    exti_writel(EXTI_RTSR2, 0x00000087);
+    g_assert_cmpuint(exti_readl(EXTI_RTSR2), ==, 0x00000000);
+
+    exti_writel(EXTI_FTSR2, 0x00000087);
+    g_assert_cmpuint(exti_readl(EXTI_FTSR2), ==, 0x00000000);
+
+    exti_writel(EXTI_SWIER2, 0x00000087);
+    g_assert_cmpuint(exti_readl(EXTI_SWIER2), ==, 0x00000000);
+
+    exti_writel(EXTI_PR2, 0x00000087);
+    g_assert_cmpuint(exti_readl(EXTI_PR2), ==, 0x00000000);
+}
+
+static void test_reserved_bits_write(void)
+{
+    /* Test that reserved bits stay are not written to */
+
+    exti_writel(EXTI_IMR2, 0xFFFFFF00);
+    g_assert_cmpuint(exti_readl(EXTI_IMR2), ==, 0x00000000);
+
+    exti_writel(EXTI_EMR2, 0xFFFFFF00);
+    g_assert_cmpuint(exti_readl(EXTI_EMR2), ==, 0x00000000);
+
+    exti_writel(EXTI_RTSR2, 0xFFFFFF00);
+    g_assert_cmpuint(exti_readl(EXTI_RTSR2), ==, 0x00000000);
+
+    exti_writel(EXTI_FTSR2, 0xFFFFFF00);
+    g_assert_cmpuint(exti_readl(EXTI_FTSR2), ==, 0x00000000);
+
+    exti_writel(EXTI_SWIER2, 0xFFFFFF00);
+    g_assert_cmpuint(exti_readl(EXTI_SWIER2), ==, 0x00000000);
+
+    exti_writel(EXTI_PR2, 0xFFFFFF00);
+    g_assert_cmpuint(exti_readl(EXTI_PR2), ==, 0x00000000);
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
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
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
+    g_assert_cmpuint(exti_readl(EXTI_SWIER1), ==, 0x00000001);
+    /* Check that the corresponding pending bit in PR is set */
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000001);
+    /* Check that the corresponding interrupt is pending in the NVIC */
+    g_assert_true(check_nvic_pending(EXTI0_IRQ));
+
+    /* Clear the pending bit in PR */
+    exti_writel(EXTI_PR1, 0x00000001);
+
+    /* Check that the write in PR was effective */
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    /* Check that the corresponding bit in SWIER was cleared */
+    g_assert_cmpuint(exti_readl(EXTI_SWIER1), ==, 0x00000000);
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
+    g_assert_cmpuint(exti_readl(EXTI_PR2), ==, 0x00000000);
+    g_assert_false(check_nvic_pending(EXTI35_IRQ));
+
+    /* Enable interrupt line EXTI0 */
+    exti_writel(EXTI_IMR2, 0x00000008);
+    /* Set the right SWIER bit from '0' to '1' */
+    exti_writel(EXTI_SWIER2, 0x00000000);
+    exti_writel(EXTI_SWIER2, 0x00000008);
+
+    /* Check that the write in SWIER was effective */
+    g_assert_cmpuint(exti_readl(EXTI_SWIER2), ==, 0x00000008);
+    /* Check that the corresponding pending bit in PR is set */
+    g_assert_cmpuint(exti_readl(EXTI_PR2), ==, 0x00000008);
+    /* Check that the corresponding interrupt is pending in the NVIC */
+    g_assert_true(check_nvic_pending(EXTI35_IRQ));
+
+    /* Clear the pending bit in PR */
+    exti_writel(EXTI_PR2, 0x00000008);
+
+    /* Check that the write in PR was effective */
+    g_assert_cmpuint(exti_readl(EXTI_PR2), ==, 0x00000000);
+    /* Check that the corresponding bit in SWIER was cleared */
+    g_assert_cmpuint(exti_readl(EXTI_SWIER2), ==, 0x00000000);
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
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_false(check_nvic_pending(EXTI0_IRQ));
+
+    exti_set_irq(0, 1);
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000001);
+    g_assert_true(check_nvic_pending(EXTI0_IRQ));
+
+    /* Clean the test */
+    exti_writel(EXTI_PR1, 0x00000001);
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
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
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_false(check_nvic_pending(EXTI0_IRQ));
+
+    exti_set_irq(0, 0);
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000001);
+    g_assert_true(check_nvic_pending(EXTI0_IRQ));
+
+    /* Clean the test */
+    exti_writel(EXTI_PR1, 0x00000001);
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
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
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000001);
+    g_assert_true(check_nvic_pending(EXTI0_IRQ));
+
+    /* Clean the test */
+    exti_writel(EXTI_PR1, 0x00000001);
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    unpend_nvic_irq(EXTI0_IRQ);
+    g_assert_false(check_nvic_pending(EXTI0_IRQ));
+
+    /* Test that an irq is raised on falling edge */
+    exti_set_irq(0, 0);
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000001);
+    g_assert_true(check_nvic_pending(EXTI0_IRQ));
+
+    /* Clean the test */
+    exti_writel(EXTI_PR1, 0x00000001);
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
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
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_false(check_nvic_pending(EXTI0_IRQ));
+
+    exti_set_irq(0, 0);
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
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
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
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
+    g_assert_cmpuint(exti_readl(EXTI_SWIER1), ==, 0x00000001);
+    /* Check that the pending bit in PR wasn't set */
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    /* Check that the interrupt isn't pending in NVIC */
+    g_assert_false(check_nvic_pending(EXTI0_IRQ));
+
+    /* Enable interrupt line EXTI0 */
+    exti_writel(EXTI_IMR1, 0x00000001);
+
+    /* Check that the pending bit in PR wasn't set */
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
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
+    g_assert_cmpuint(exti_readl(EXTI_PR2), ==, 0x00000000);
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
+    g_assert_cmpuint(exti_readl(EXTI_SWIER2), ==, 0x00000008);
+    /* Check that the pending bit in PR wasn't set */
+    g_assert_cmpuint(exti_readl(EXTI_PR2), ==, 0x00000000);
+    /* Check that the interrupt isn't pending in NVIC */
+    g_assert_false(check_nvic_pending(EXTI35_IRQ));
+
+    /* Enable interrupt line EXTI35 */
+    exti_writel(EXTI_IMR2, 0x00000008);
+
+    /* Check that the pending bit in PR wasn't set */
+    g_assert_cmpuint(exti_readl(EXTI_PR2), ==, 0x00000000);
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
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
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
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    /* Check that the interrupt isn't pending in NVIC */
+    g_assert_false(check_nvic_pending(EXTI1_IRQ));
+
+    /* Enable interrupt line EXTI1 */
+    exti_writel(EXTI_IMR1, 0x00000002);
+
+    /* Check that the pending bit in PR wasn't set */
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
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
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
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
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000002);
+    /* Check that the interrupt is pending in NVIC */
+    g_assert_true(check_nvic_pending(EXTI1_IRQ));
+
+    /* Clear the pending bit in PR */
+    exti_writel(EXTI_PR1, 0x00000002);
+
+    /* Check that the write in PR was effective */
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
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
+    qtest_add_func("stm32l4x5/exti/test_edge_selector", test_edge_selector);
+
+    qtest_start("-machine b-l475e-iot01a");
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index fd40136fa9c..07fdd2dc1a5 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -195,6 +195,10 @@ qtests_aspeed = \
   ['aspeed_hace-test',
    'aspeed_smc-test',
    'aspeed_gpio-test']
+
+qtests_stm32l4x5 = \
+  ['stm32l4x5_exti-test']
+
 qtests_arm = \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
@@ -208,6 +212,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
   ['arm-cpu-features',
    'boot-serial-test']
 
-- 
2.34.1


