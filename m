Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B173782F11E
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:13:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPl7J-0006f4-E9; Tue, 16 Jan 2024 10:12:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7F-0006cm-VF
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:38 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7D-0005q1-EK
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:37 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33694bf8835so7572533f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 07:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705417953; x=1706022753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EPSSZe4IiKN8I89ANspE8D1mP9j6uJZqqEJM4+uOkMM=;
 b=UuOHJqgCTz6vEE+sHRO6oZ+YsM0jbC1cSSeTTN/vMZgkpqNUcrhZWNYv8hstAuWtXM
 xfEkgy/KYwuAAKvu9ILxzX9A75IcPqIJ6p6XpZn/gJ9FjoDneewtKZrf3X0FFG9FXAuD
 KGKAwdofDrkDZRjTDrKTuidqwVB6AD1I0vMlec76m5kyQrnv43W1lFmNdEGjOpsCUvAe
 nsWLCxvHdl1oHH2kkLfbXuROd1ENr8/fGSUwFtUh1/FjweeXtO7dJcbTUfvMDgkOHRi4
 e0hPwQN6aEEEobeYM8NvO7kDsHstF0Q3dyTodviFDivGc894AE/fAd6OvnRogfp3Meeb
 g3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705417953; x=1706022753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EPSSZe4IiKN8I89ANspE8D1mP9j6uJZqqEJM4+uOkMM=;
 b=c3IfLg7jg9+pv9+5FrKxKvn8lpBQ/VcACCDwP/ICb0tCWQY7EHEYTfOYJ+0zLu4Hw7
 S9zKf/yNuoHTucEWeZ+yb34GVIfScOhYs712TFXEBYzPLI6QoZLjihLLXZ/0y3kGDiEG
 R5k5tGfmnJIMkI4ANZd/u36yCsmOjJQl8WhP5Xrs7QBvnu7RJkBGp1fjwjZv2/zb3yIm
 ReXUnpBKBtGDSNkbW/XTskw4qYn3Mpo1juykhl+cTgxE1H8koMXQmdD2kW8/288ZmEdH
 hP6UvmY1sfefyB45dkgnGM5ls1zE0wEMdMwDe0NtxUOL1pp7Svi6CXSZgjmREnfiiPv8
 geHg==
X-Gm-Message-State: AOJu0Yygi9TEW38CprFsx9eLCCReIXAPdqRmUc2+rTnPMzXtX7odhISO
 BW4p8diIeGSWSvWPPhzno1BUzMuDjss/aMqJDAOCbtmjx6Y=
X-Google-Smtp-Source: AGHT+IEbAFx1B7ZU/cIxylfTsjAN0+5w/CnaN/ItSC/LtcH9Hq2d2cgsXHIJBNGHkdf9LuQearmFMg==
X-Received: by 2002:a5d:5234:0:b0:337:62d2:fba8 with SMTP id
 i20-20020a5d5234000000b0033762d2fba8mr4136744wra.94.1705417953029; 
 Tue, 16 Jan 2024 07:12:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020adff38e000000b003379b549a00sm10091357wro.10.2024.01.16.07.12.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 07:12:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/21] tests/qtest: Add STM32L4x5 SYSCFG QTest testcase
Date: Tue, 16 Jan 2024 15:12:16 +0000
Message-Id: <20240116151228.2430754-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116151228.2430754-1-peter.maydell@linaro.org>
References: <20240116151228.2430754-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Message-id: 20240109194438.70934-4-ines.varhol@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/stm32l4x5_syscfg-test.c | 331 ++++++++++++++++++++++++++++
 tests/qtest/meson.build             |   3 +-
 2 files changed, 333 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/stm32l4x5_syscfg-test.c

diff --git a/tests/qtest/stm32l4x5_syscfg-test.c b/tests/qtest/stm32l4x5_syscfg-test.c
new file mode 100644
index 00000000000..ed4801798d4
--- /dev/null
+++ b/tests/qtest/stm32l4x5_syscfg-test.c
@@ -0,0 +1,331 @@
+/*
+ * QTest testcase for STM32L4x5_SYSCFG
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
+    response = qtest_qmp(global_qtest, "{'execute': 'system_reset'}");
+    g_assert(qdict_haskey(response, "return"));
+    qobject_unref(response);
+}
+
+static void test_reset(void)
+{
+    /*
+     * Test that registers are initialized at the correct values
+     */
+    g_assert_cmpuint(syscfg_readl(SYSCFG_MEMRMP), ==, 0x00000000);
+
+    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), ==, 0x7C000001);
+
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR1), ==, 0x00000000);
+
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR2), ==, 0x00000000);
+
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR3), ==, 0x00000000);
+
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR4), ==, 0x00000000);
+
+    g_assert_cmpuint(syscfg_readl(SYSCFG_SCSR), ==, 0x00000000);
+
+    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR2), ==, 0x00000000);
+
+    g_assert_cmpuint(syscfg_readl(SYSCFG_SWPR), ==, 0x00000000);
+
+    g_assert_cmpuint(syscfg_readl(SYSCFG_SKR), ==, 0x00000000);
+
+    g_assert_cmpuint(syscfg_readl(SYSCFG_SWPR2), ==, 0x00000000);
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
+    g_assert_cmpuint(syscfg_readl(SYSCFG_MEMRMP), ==, 0x00000000);
+
+    syscfg_writel(SYSCFG_CFGR1, 0x7F00FEFF);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), ==, 0x7C000001);
+
+    syscfg_writel(SYSCFG_EXTICR1, 0xFFFF0000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR1), ==, 0x00000000);
+
+    syscfg_writel(SYSCFG_EXTICR2, 0xFFFF0000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR2), ==, 0x00000000);
+
+    syscfg_writel(SYSCFG_EXTICR3, 0xFFFF0000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR3), ==, 0x00000000);
+
+    syscfg_writel(SYSCFG_EXTICR4, 0xFFFF0000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR4), ==, 0x00000000);
+
+    syscfg_writel(SYSCFG_SKR, 0xFFFFFF00);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_SKR), ==, 0x00000000);
+}
+
+static void test_set_and_clear(void)
+{
+    /*
+     * Test that regular bits can be set and cleared
+     */
+    syscfg_writel(SYSCFG_MEMRMP, 0x00000107);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_MEMRMP), ==, 0x00000107);
+    syscfg_writel(SYSCFG_MEMRMP, 0x00000000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_MEMRMP), ==, 0x00000000);
+
+    /* cfgr1 bit 0 is clear only so we keep it set */
+    syscfg_writel(SYSCFG_CFGR1, 0xFCFF0101);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), ==, 0xFCFF0101);
+    syscfg_writel(SYSCFG_CFGR1, 0x00000001);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), ==, 0x00000001);
+
+    syscfg_writel(SYSCFG_EXTICR1, 0x0000FFFF);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR1), ==, 0x0000FFFF);
+    syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR1), ==, 0x00000000);
+
+    syscfg_writel(SYSCFG_EXTICR2, 0x0000FFFF);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR2), ==, 0x0000FFFF);
+    syscfg_writel(SYSCFG_EXTICR2, 0x00000000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR2), ==, 0x00000000);
+
+    syscfg_writel(SYSCFG_EXTICR3, 0x0000FFFF);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR3), ==, 0x0000FFFF);
+    syscfg_writel(SYSCFG_EXTICR3, 0x00000000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR3), ==, 0x00000000);
+
+    syscfg_writel(SYSCFG_EXTICR4, 0x0000FFFF);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR4), ==, 0x0000FFFF);
+    syscfg_writel(SYSCFG_EXTICR4, 0x00000000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR4), ==, 0x00000000);
+
+    syscfg_writel(SYSCFG_SKR, 0x000000FF);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_SKR), ==, 0x000000FF);
+    syscfg_writel(SYSCFG_SKR, 0x00000000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_SKR), ==, 0x00000000);
+}
+
+static void test_clear_by_writing_1(void)
+{
+    /*
+     * Test that writing '1' doesn't set the bit
+     */
+    syscfg_writel(SYSCFG_CFGR2, 0x00000100);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR2), ==, 0x00000000);
+}
+
+static void test_set_only_bits(void)
+{
+    /*
+     * Test that set only bits stay can't be cleared
+     */
+    syscfg_writel(SYSCFG_CFGR2, 0x0000000F);
+    syscfg_writel(SYSCFG_CFGR2, 0x00000000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR2), ==, 0x0000000F);
+
+    syscfg_writel(SYSCFG_SWPR, 0xFFFFFFFF);
+    syscfg_writel(SYSCFG_SWPR, 0x00000000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_SWPR), ==, 0xFFFFFFFF);
+
+    syscfg_writel(SYSCFG_SWPR2, 0xFFFFFFFF);
+    syscfg_writel(SYSCFG_SWPR2, 0x00000000);
+    g_assert_cmpuint(syscfg_readl(SYSCFG_SWPR2), ==, 0xFFFFFFFF);
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
+    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), ==, 0x00000000);
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
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 07fdd2dc1a5..5e4bc3da85e 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -197,7 +197,8 @@ qtests_aspeed = \
    'aspeed_gpio-test']
 
 qtests_stm32l4x5 = \
-  ['stm32l4x5_exti-test']
+  ['stm32l4x5_exti-test',
+   'stm32l4x5_syscfg-test']
 
 qtests_arm = \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
-- 
2.34.1


