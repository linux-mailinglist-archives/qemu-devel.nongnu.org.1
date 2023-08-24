Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC37786BD3
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:29:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6eE-0004OH-6g; Thu, 24 Aug 2023 05:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e3-00044v-Ld
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:56 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6dv-0004xi-0F
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:47 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3ff5ddb4329so4107775e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869320; x=1693474120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=maKnpTX0sEKhyGC+nkCmnNKwDO8LJpaRhDI6Hxo5ERE=;
 b=vEJjrMCPkCHBDkiD/+8dwfopNGOVAMVtO+zn6KfUZgQjoyprZaQjQhPohXYZQjcSTV
 XEeInANb0o91YnVgqOnQYHz2VNX9IaJwDmR03Q5JSj4MQobRUy2wrbgSja5T17QtSNqn
 Qd+NV6drRor0op9n2NRwrMbM5QtWoc6hmPDw7X4pY3qomlGgsVMhoe2ynrz+I42TSApQ
 6h1df2z2nA906siM5PxuYP3mrkn778emiG2wchgUbxNZa9rpsttSjwQIMg72b8sN7BLg
 4UlgoYt8OKak4N7ajprONCin0p8EYHnifdP6KpVxPZQwuqLIhuZZX1Oj/J4s82T/uYBm
 FWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869320; x=1693474120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=maKnpTX0sEKhyGC+nkCmnNKwDO8LJpaRhDI6Hxo5ERE=;
 b=AnCyKOWkRY3vBE61JawFX1CUXWdysjhLCzdxUIcAJfYd+dR7dNi9fjQG7Au6OANfSo
 Ov3eSBoO9F+YAzJuCryjZjKJnFcoKtxEbs2jpSCCofHt5ump62VnSLixvC+5QpA4k9wU
 6orOXwDlG2t8sql1fphmqS44zCpopPEAnYiz4JPvlbU5ppfX8FvLPcjRc/hhNOpTJL8J
 FP/9jXiiA21iH0BpJY8NFIHxa3/HgAQ8LDGdFeLH5LR7o3bnPe34Ro/JL+8OsewClann
 wsbvVVmH6CP1iKma26TRRuCbArsYqZDvjBLU54YqdSTxk+E4M32+/mFNEZVTNrrhhxQ4
 hlyA==
X-Gm-Message-State: AOJu0YzRJEaeVGY9Ex3JB2rQ6tyvhCWEO1p6PhBkXumL0hZCF61UiN1a
 nFxz1h02jErpJY8n+XwQyhSaQugT7iL6dTblmnU=
X-Google-Smtp-Source: AGHT+IFhnIXASFVXpE+P7nEFTB53NrsSAMvujRSn50lH4NnfHj06ZsCD/6MSI8UUzQrDsbVIVMhZGQ==
X-Received: by 2002:a5d:50cf:0:b0:316:fc03:3c66 with SMTP id
 f15-20020a5d50cf000000b00316fc033c66mr14831897wrt.3.1692869320443; 
 Thu, 24 Aug 2023 02:28:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/35] qtest: microbit-test: add tests for nRF51 DETECT
Date: Thu, 24 Aug 2023 10:28:07 +0100
Message-Id: <20230824092836.2239644-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Chris Laplante <chris@laplante.io>

Exercise the DETECT mechanism of the GPIO peripheral.

Signed-off-by: Chris Laplante <chris@laplante.io>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230728160324.1159090-7-chris@laplante.io
[PMM: fixed coding style nits]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/microbit-test.c | 44 +++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tests/qtest/microbit-test.c b/tests/qtest/microbit-test.c
index 6022a92b6a9..2abcad8e31c 100644
--- a/tests/qtest/microbit-test.c
+++ b/tests/qtest/microbit-test.c
@@ -393,6 +393,49 @@ static void test_nrf51_gpio(void)
     qtest_quit(qts);
 }
 
+static void test_nrf51_gpio_detect(void)
+{
+    QTestState *qts = qtest_init("-M microbit");
+    int i;
+
+    /* Connect input buffer on pins 1-7, configure SENSE for high level */
+    for (i = 1; i <= 7; i++) {
+        qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START + i * 4,
+                     deposit32(0, 16, 2, 2));
+    }
+
+    qtest_irq_intercept_out_named(qts, "/machine/nrf51/gpio", "detect");
+
+    for (i = 1; i <= 7; i++) {
+        /* Set pin high */
+        qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", i, 1);
+        uint32_t actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN);
+        g_assert_cmpuint(actual, ==, 1 << i);
+
+        /* Check that DETECT is high */
+        g_assert_true(qtest_get_irq(qts, 0));
+
+        /* Set pin low, check that DETECT goes low. */
+        qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", i, 0);
+        actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN);
+        g_assert_cmpuint(actual, ==, 0x0);
+        g_assert_false(qtest_get_irq(qts, 0));
+    }
+
+    /* Set pin 0 high, check that DETECT doesn't fire */
+    qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, 1);
+    g_assert_false(qtest_get_irq(qts, 0));
+    qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, 0);
+
+    /* Set pins 1, 2, and 3 high, then set 3 low. Check DETECT is still high */
+    for (i = 1; i <= 3; i++) {
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
@@ -499,6 +542,7 @@ int main(int argc, char **argv)
 
     qtest_add_func("/microbit/nrf51/uart", test_nrf51_uart);
     qtest_add_func("/microbit/nrf51/gpio", test_nrf51_gpio);
+    qtest_add_func("/microbit/nrf51/gpio_detect", test_nrf51_gpio_detect);
     qtest_add_func("/microbit/nrf51/nvmc", test_nrf51_nvmc);
     qtest_add_func("/microbit/nrf51/timer", test_nrf51_timer);
     qtest_add_func("/microbit/microbit/i2c", test_microbit_i2c);
-- 
2.34.1


