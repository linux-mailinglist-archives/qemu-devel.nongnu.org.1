Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C30347285B1
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 18:47:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Ils-0006cz-68; Thu, 08 Jun 2023 12:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q7Ilp-0006bz-E4
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:45:57 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q7Ilm-00054f-Kp
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:45:57 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-19f8af9aa34so667120fac.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 09:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1686242753; x=1688834753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSfMYKKS4NtlMAXhbXfBph60waYX40gvvFOukYTJSqs=;
 b=N+JmzNXWj+HEStY9Rql8NopNNennigFYkB9oNxboXhyleQ1SF9OitV1YbskRzFWgV7
 Y+1DNJuSpv/DKaCBQPSc/UNKJEEyzmF+VpwM1roBhaa1Cqhagj0n9tRglWtvy6mnZSie
 D8/q7lGKkDU8gerh1r+cG+lH8Fu3DWBeZLE/OKnt9bXVmKTfw91+5Xp6+v0fBlgiDePu
 2thddwaemEKVfBFTyq9MG2/lQ+GVRQ6aflYZy3bIG8g2iv103V93JZe3dLnyGx/V8WQy
 EMdoorPpwoyGOGo+6QCQeIROL8J2FyBBvfp6eAfJ5u8O+8wEimbhBWvUfjzo6UoUbNLK
 Imfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686242753; x=1688834753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dSfMYKKS4NtlMAXhbXfBph60waYX40gvvFOukYTJSqs=;
 b=mElVoL4hOjJvG+iCPDCIYUWv8hLztLfPXANr3CenqvHgrLpHiCJbWUYHXbeyYt5F6m
 sjKly9LHUSrFGF3H9hX2TsTzhaxgZ+TPmTyAyDITM+WHOoVQRC1qQRkSaEjQXcmt7lxV
 SFnEuRLlX+bPbl7JQ9WzF939DgXTdLN21nl5oFKV75GEf1fbc4dvKWP6fDeFTv9ZGxTQ
 vvtt0NwEbCgthIq7wF1SFhJAGzTycKktDmxX1k42yol5oLTJYj8DRysfGxtZ87qe0ELQ
 wB4IXMG6dqHOjVGaSdRFVvw9+J+xQRihLIii6xHE4eI8qabJ3cRo9W8BhTBJ8PjtPuX3
 ZdIw==
X-Gm-Message-State: AC+VfDw0NEZTHQ68OiuUqDPRlcN/r8FPHT5vDutEcGvdFzoWbyYT9vXA
 H8jbc0V/chFp3Uh6ziYexvkVcODF2E08mcThGaVnWZR2FrKOgzSHh7UsPQnIA6DEU0fsUX2f1M4
 ho6K74dmwkhIKT67cagpI2NV8tlomcXZW60YFmp554BbkHwLSJDRMC4+EbAxNFugM2xP51ovtjm
 cj
X-Google-Smtp-Source: ACHHUZ7df+IK/58DLks03x6MJDzPtBwwh78ebbIlPbV7EHVcca3c92loCSyeG/19aKwpqvRw0OtVYw==
X-Received: by 2002:a05:6870:d343:b0:1a3:b43:9c88 with SMTP id
 h3-20020a056870d34300b001a30b439c88mr8102427oag.34.1686242752898; 
 Thu, 08 Jun 2023 09:45:52 -0700 (PDT)
Received: from sw05.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a4adb8c000000b0054574f35b8esm9107oou.41.2023.06.08.09.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 09:45:52 -0700 (PDT)
From: Tommy Wu <tommy.wu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, bin.meng@windriver.com,
 jim.shu@sifive.com, frank.chang@sifive.com, liweiwei@iscas.ac.cn,
 philmd@linaro.org, Tommy Wu <tommy.wu@sifive.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v5 3/3] tests/qtest: sifive-e-aon-watchdog-test.c: Add QTest
 of watchdog of sifive_e
Date: Thu,  8 Jun 2023 09:45:42 -0700
Message-Id: <20230608164542.3675619-4-tommy.wu@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230608164542.3675619-1-tommy.wu@sifive.com>
References: <20230608164542.3675619-1-tommy.wu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=tommy.wu@sifive.com; helo=mail-oa1-x31.google.com
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

Add some simple tests of the watchdog timer in the always-on domain device
of HiFive 1 rev b.

Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/meson.build                  |   3 +
 tests/qtest/sifive-e-aon-watchdog-test.c | 450 +++++++++++++++++++++++
 2 files changed, 453 insertions(+)
 create mode 100644 tests/qtest/sifive-e-aon-watchdog-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 5fa6833ad7..eb8d153a65 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -234,6 +234,9 @@ qtests_s390x = \
    'cpu-plug-test',
    'migration-test']
 
+qtests_riscv32 = \
+  (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
+
 qos_test_ss = ss.source_set()
 qos_test_ss.add(
   'ac97-test.c',
diff --git a/tests/qtest/sifive-e-aon-watchdog-test.c b/tests/qtest/sifive-e-aon-watchdog-test.c
new file mode 100644
index 0000000000..1f313d16ad
--- /dev/null
+++ b/tests/qtest/sifive-e-aon-watchdog-test.c
@@ -0,0 +1,450 @@
+/*
+ * QTest testcase for the watchdog timer of HiFive 1 rev b.
+ *
+ * Copyright (c) 2023 SiFive, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "qemu/bitops.h"
+#include "libqtest.h"
+#include "hw/registerfields.h"
+#include "hw/misc/sifive_e_aon.h"
+
+FIELD(AON_WDT_WDOGCFG, SCALE, 0, 4)
+FIELD(AON_WDT_WDOGCFG, RSVD0, 4, 4)
+FIELD(AON_WDT_WDOGCFG, RSTEN, 8, 1)
+FIELD(AON_WDT_WDOGCFG, ZEROCMP, 9, 1)
+FIELD(AON_WDT_WDOGCFG, RSVD1, 10, 2)
+FIELD(AON_WDT_WDOGCFG, EN_ALWAYS, 12, 1)
+FIELD(AON_WDT_WDOGCFG, EN_CORE_AWAKE, 13, 1)
+FIELD(AON_WDT_WDOGCFG, RSVD2, 14, 14)
+FIELD(AON_WDT_WDOGCFG, IP0, 28, 1)
+FIELD(AON_WDT_WDOGCFG, RSVD3, 29, 3)
+
+#define WDOG_BASE (0x10000000)
+#define WDOGCFG (0x0)
+#define WDOGCOUNT (0x8)
+#define WDOGS (0x10)
+#define WDOGFEED (0x18)
+#define WDOGKEY (0x1c)
+#define WDOGCMP0 (0x20)
+
+#define SIFIVE_E_AON_WDOGKEY (0x51F15E)
+#define SIFIVE_E_AON_WDOGFEED (0xD09F00D)
+#define SIFIVE_E_LFCLK_DEFAULT_FREQ (32768)
+
+static void test_init(QTestState *qts)
+{
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCOUNT, 0);
+
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCFG, 0);
+
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCMP0, 0xBEEF);
+}
+
+static void test_wdogcount(void)
+{
+    uint64_t tmp;
+    QTestState *qts = qtest_init("-machine sifive_e");
+
+    test_init(qts);
+
+    tmp = qtest_readl(qts, WDOG_BASE + WDOGCOUNT);
+    qtest_writel(qts, WDOG_BASE + WDOGCOUNT, 0xBEEF);
+    g_assert(qtest_readl(qts, WDOG_BASE + WDOGCOUNT) == tmp);
+
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCOUNT, 0xBEEF);
+    g_assert(0xBEEF == qtest_readl(qts, WDOG_BASE + WDOGCOUNT));
+
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCOUNT, 0xAAAAAAAA);
+    g_assert(0x2AAAAAAA == qtest_readl(qts, WDOG_BASE + WDOGCOUNT));
+
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGFEED, 0xAAAAAAAA);
+    g_assert(0x2AAAAAAA == qtest_readl(qts, WDOG_BASE + WDOGCOUNT));
+
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGFEED, SIFIVE_E_AON_WDOGFEED);
+    g_assert(0 == qtest_readl(qts, WDOG_BASE + WDOGCOUNT));
+
+    qtest_quit(qts);
+}
+
+static void test_wdogcfg(void)
+{
+    uint32_t tmp_cfg;
+    QTestState *qts = qtest_init("-machine sifive_e");
+
+    test_init(qts);
+
+    tmp_cfg = qtest_readl(qts, WDOG_BASE + WDOGCFG);
+    qtest_writel(qts, WDOG_BASE + WDOGCFG, 0xFFFFFFFF);
+    g_assert(qtest_readl(qts, WDOG_BASE + WDOGCFG) == tmp_cfg);
+
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCFG, 0xFFFFFFFF);
+    g_assert(0xFFFFFFFF == qtest_readl(qts, WDOG_BASE + WDOGCFG));
+
+    tmp_cfg = qtest_readl(qts, WDOG_BASE + WDOGCFG);
+    g_assert(15 == FIELD_EX32(tmp_cfg, AON_WDT_WDOGCFG, SCALE));
+    g_assert(1 == FIELD_EX32(tmp_cfg, AON_WDT_WDOGCFG, RSTEN));
+    g_assert(1 == FIELD_EX32(tmp_cfg, AON_WDT_WDOGCFG, ZEROCMP));
+    g_assert(1 == FIELD_EX32(tmp_cfg, AON_WDT_WDOGCFG, EN_ALWAYS));
+    g_assert(1 == FIELD_EX32(tmp_cfg, AON_WDT_WDOGCFG, EN_CORE_AWAKE));
+    g_assert(1 == FIELD_EX32(tmp_cfg, AON_WDT_WDOGCFG, IP0));
+
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCFG, 0);
+    tmp_cfg = qtest_readl(qts, WDOG_BASE + WDOGCFG);
+    g_assert(0 == FIELD_EX32(tmp_cfg, AON_WDT_WDOGCFG, SCALE));
+    g_assert(0 == FIELD_EX32(tmp_cfg, AON_WDT_WDOGCFG, RSTEN));
+    g_assert(0 == FIELD_EX32(tmp_cfg, AON_WDT_WDOGCFG, ZEROCMP));
+    g_assert(0 == FIELD_EX32(tmp_cfg, AON_WDT_WDOGCFG, EN_ALWAYS));
+    g_assert(0 == FIELD_EX32(tmp_cfg, AON_WDT_WDOGCFG, EN_CORE_AWAKE));
+    g_assert(0 == FIELD_EX32(tmp_cfg, AON_WDT_WDOGCFG, IP0));
+    g_assert(0 == qtest_readl(qts, WDOG_BASE + WDOGCFG));
+
+    qtest_quit(qts);
+}
+
+static void test_wdogcmp0(void)
+{
+    uint32_t tmp;
+    QTestState *qts = qtest_init("-machine sifive_e");
+
+    test_init(qts);
+
+    tmp = qtest_readl(qts, WDOG_BASE + WDOGCMP0);
+    qtest_writel(qts, WDOG_BASE + WDOGCMP0, 0xBEEF);
+    g_assert(qtest_readl(qts, WDOG_BASE + WDOGCMP0) == tmp);
+
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCMP0, 0xBEEF);
+    g_assert(0xBEEF == qtest_readl(qts, WDOG_BASE + WDOGCMP0));
+
+    qtest_quit(qts);
+}
+
+static void test_wdogkey(void)
+{
+    QTestState *qts = qtest_init("-machine sifive_e");
+
+    test_init(qts);
+
+    g_assert(0 == qtest_readl(qts, WDOG_BASE + WDOGKEY));
+
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, 0xFFFF);
+    g_assert(0 == qtest_readl(qts, WDOG_BASE + WDOGKEY));
+
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    g_assert(1 == qtest_readl(qts, WDOG_BASE + WDOGKEY));
+
+    qtest_writel(qts, WDOG_BASE + WDOGFEED, 0xAAAAAAAA);
+    g_assert(0 == qtest_readl(qts, WDOG_BASE + WDOGKEY));
+
+    qtest_quit(qts);
+}
+
+static void test_wdogfeed(void)
+{
+    QTestState *qts = qtest_init("-machine sifive_e");
+
+    test_init(qts);
+
+    g_assert(0 == qtest_readl(qts, WDOG_BASE + WDOGFEED));
+
+    qtest_writel(qts, WDOG_BASE + WDOGFEED, 0xFFFF);
+    g_assert(0 == qtest_readl(qts, WDOG_BASE + WDOGFEED));
+
+    qtest_quit(qts);
+}
+
+static void test_scaled_wdogs(void)
+{
+    uint32_t cfg;
+    uint32_t fake_count = 0x12345678;
+    QTestState *qts = qtest_init("-machine sifive_e");
+
+    test_init(qts);
+
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCOUNT, fake_count);
+    g_assert(qtest_readl(qts, WDOG_BASE + WDOGCOUNT) == fake_count);
+    g_assert((uint16_t)qtest_readl(qts, WDOG_BASE + WDOGS) ==
+             (uint16_t)fake_count);
+
+    for (int i = 0; i < 16; i++) {
+        cfg = qtest_readl(qts, WDOG_BASE + WDOGCFG);
+        cfg = FIELD_DP32(cfg, AON_WDT_WDOGCFG, SCALE, i);
+        qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+        qtest_writel(qts, WDOG_BASE + WDOGCFG, cfg);
+        g_assert((uint16_t)qtest_readl(qts, WDOG_BASE + WDOGS) ==
+                 (uint16_t)(fake_count >>
+                            FIELD_EX32(cfg, AON_WDT_WDOGCFG, SCALE)));
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_watchdog(void)
+{
+    uint32_t cfg;
+    QTestState *qts = qtest_init("-machine sifive_e");
+
+    test_init(qts);
+
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCMP0, SIFIVE_E_LFCLK_DEFAULT_FREQ);
+
+    cfg = qtest_readl(qts, WDOG_BASE + WDOGCFG);
+    cfg = FIELD_DP32(cfg, AON_WDT_WDOGCFG, SCALE, 0);
+    cfg = FIELD_DP32(cfg, AON_WDT_WDOGCFG, EN_ALWAYS, 1);
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCFG, cfg);
+
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND);
+
+    g_assert(qtest_readl(qts, WDOG_BASE + WDOGCOUNT) ==
+             SIFIVE_E_LFCLK_DEFAULT_FREQ);
+    g_assert(qtest_readl(qts, WDOG_BASE + WDOGS) ==
+             SIFIVE_E_LFCLK_DEFAULT_FREQ);
+
+    cfg = qtest_readl(qts, WDOG_BASE + WDOGCFG);
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, SCALE));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, RSTEN));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, ZEROCMP));
+    g_assert(1 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, EN_ALWAYS));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, EN_CORE_AWAKE));
+    g_assert(1 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, IP0));
+
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCOUNT, 0);
+    cfg = FIELD_DP32(cfg, AON_WDT_WDOGCFG, IP0, 0);
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCFG, cfg);
+    cfg = qtest_readl(qts, WDOG_BASE + WDOGCFG);
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, IP0));
+
+    qtest_quit(qts);
+}
+
+static void test_scaled_watchdog(void)
+{
+    uint32_t cfg;
+    QTestState *qts = qtest_init("-machine sifive_e");
+
+    test_init(qts);
+
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCMP0, 10);
+
+    cfg = qtest_readl(qts, WDOG_BASE + WDOGCFG);
+    cfg = FIELD_DP32(cfg, AON_WDT_WDOGCFG, SCALE, 15);
+    cfg = FIELD_DP32(cfg, AON_WDT_WDOGCFG, EN_ALWAYS, 1);
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCFG, cfg);
+
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND * 10);
+
+    g_assert(qtest_readl(qts, WDOG_BASE + WDOGCOUNT) ==
+             SIFIVE_E_LFCLK_DEFAULT_FREQ * 10);
+
+    g_assert(10 == qtest_readl(qts, WDOG_BASE + WDOGS));
+
+    cfg = qtest_readl(qts, WDOG_BASE + WDOGCFG);
+    g_assert(15 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, SCALE));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, RSTEN));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, ZEROCMP));
+    g_assert(1 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, EN_ALWAYS));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, EN_CORE_AWAKE));
+    g_assert(1 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, IP0));
+
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCOUNT, 0);
+    cfg = FIELD_DP32(cfg, AON_WDT_WDOGCFG, IP0, 0);
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCFG, cfg);
+    cfg = qtest_readl(qts, WDOG_BASE + WDOGCFG);
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, IP0));
+
+    qtest_quit(qts);
+}
+
+static void test_periodic_int(void)
+{
+    uint32_t cfg;
+    QTestState *qts = qtest_init("-machine sifive_e");
+
+    test_init(qts);
+
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCMP0, SIFIVE_E_LFCLK_DEFAULT_FREQ);
+
+    cfg = qtest_readl(qts, WDOG_BASE + WDOGCFG);
+    cfg = FIELD_DP32(cfg, AON_WDT_WDOGCFG, SCALE, 0);
+    cfg = FIELD_DP32(cfg, AON_WDT_WDOGCFG, ZEROCMP, 1);
+    cfg = FIELD_DP32(cfg, AON_WDT_WDOGCFG, EN_ALWAYS, 1);
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCFG, cfg);
+
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND);
+
+    g_assert(0 == qtest_readl(qts, WDOG_BASE + WDOGCOUNT));
+    g_assert(0 == qtest_readl(qts, WDOG_BASE + WDOGS));
+
+    cfg = qtest_readl(qts, WDOG_BASE + WDOGCFG);
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, SCALE));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, RSTEN));
+    g_assert(1 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, ZEROCMP));
+    g_assert(1 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, EN_ALWAYS));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, EN_CORE_AWAKE));
+    g_assert(1 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, IP0));
+
+    cfg = FIELD_DP32(cfg, AON_WDT_WDOGCFG, IP0, 0);
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCFG, cfg);
+    cfg = qtest_readl(qts, WDOG_BASE + WDOGCFG);
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, IP0));
+
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND);
+
+    g_assert(0 == qtest_readl(qts, WDOG_BASE + WDOGCOUNT));
+    g_assert(0 == qtest_readl(qts, WDOG_BASE + WDOGS));
+
+    cfg = qtest_readl(qts, WDOG_BASE + WDOGCFG);
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, SCALE));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, RSTEN));
+    g_assert(1 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, ZEROCMP));
+    g_assert(1 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, EN_ALWAYS));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, EN_CORE_AWAKE));
+    g_assert(1 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, IP0));
+
+    cfg = FIELD_DP32(cfg, AON_WDT_WDOGCFG, IP0, 0);
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCFG, cfg);
+    cfg = qtest_readl(qts, WDOG_BASE + WDOGCFG);
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, IP0));
+
+    qtest_quit(qts);
+}
+
+static void test_enable_disable(void)
+{
+    uint32_t cfg;
+    QTestState *qts = qtest_init("-machine sifive_e");
+
+    test_init(qts);
+
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCMP0, 10);
+
+    cfg = qtest_readl(qts, WDOG_BASE + WDOGCFG);
+    cfg = FIELD_DP32(cfg, AON_WDT_WDOGCFG, SCALE, 15);
+    cfg = FIELD_DP32(cfg, AON_WDT_WDOGCFG, EN_ALWAYS, 1);
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCFG, cfg);
+
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND * 2);
+
+    g_assert(qtest_readl(qts, WDOG_BASE + WDOGCOUNT) ==
+             SIFIVE_E_LFCLK_DEFAULT_FREQ * 2);
+    g_assert(2 == qtest_readl(qts, WDOG_BASE + WDOGS));
+
+    cfg = qtest_readl(qts, WDOG_BASE + WDOGCFG);
+    g_assert(15 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, SCALE));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, RSTEN));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, ZEROCMP));
+    g_assert(1 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, EN_ALWAYS));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, EN_CORE_AWAKE));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, IP0));
+
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    cfg = FIELD_DP32(cfg, AON_WDT_WDOGCFG, EN_ALWAYS, 0);
+    qtest_writel(qts, WDOG_BASE + WDOGCFG, cfg);
+
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND * 8);
+
+    g_assert(qtest_readl(qts, WDOG_BASE + WDOGCOUNT) ==
+             SIFIVE_E_LFCLK_DEFAULT_FREQ * 2);
+    g_assert(2 == qtest_readl(qts, WDOG_BASE + WDOGS));
+
+    cfg = qtest_readl(qts, WDOG_BASE + WDOGCFG);
+    g_assert(15 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, SCALE));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, RSTEN));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, ZEROCMP));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, EN_ALWAYS));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, EN_CORE_AWAKE));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, IP0));
+
+    cfg = FIELD_DP32(cfg, AON_WDT_WDOGCFG, EN_ALWAYS, 1);
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCFG, cfg);
+
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND * 8);
+
+    g_assert(qtest_readl(qts, WDOG_BASE + WDOGCOUNT) ==
+             SIFIVE_E_LFCLK_DEFAULT_FREQ * 10);
+    g_assert(10 == qtest_readl(qts, WDOG_BASE + WDOGS));
+
+    cfg = qtest_readl(qts, WDOG_BASE + WDOGCFG);
+    g_assert(15 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, SCALE));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, RSTEN));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, ZEROCMP));
+    g_assert(1 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, EN_ALWAYS));
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, EN_CORE_AWAKE));
+    g_assert(1 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, IP0));
+
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCOUNT, 0);
+    cfg = FIELD_DP32(cfg, AON_WDT_WDOGCFG, IP0, 0);
+    qtest_writel(qts, WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
+    qtest_writel(qts, WDOG_BASE + WDOGCFG, cfg);
+    cfg = qtest_readl(qts, WDOG_BASE + WDOGCFG);
+    g_assert(0 == FIELD_EX32(cfg, AON_WDT_WDOGCFG, IP0));
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/sifive-e-aon-watchdog-test/wdogcount",
+                   test_wdogcount);
+    qtest_add_func("/sifive-e-aon-watchdog-test/wdogcfg",
+                   test_wdogcfg);
+    qtest_add_func("/sifive-e-aon-watchdog-test/wdogcmp0",
+                   test_wdogcmp0);
+    qtest_add_func("/sifive-e-aon-watchdog-test/wdogkey",
+                   test_wdogkey);
+    qtest_add_func("/sifive-e-aon-watchdog-test/wdogfeed",
+                   test_wdogfeed);
+    qtest_add_func("/sifive-e-aon-watchdog-test/scaled_wdogs",
+                   test_scaled_wdogs);
+    qtest_add_func("/sifive-e-aon-watchdog-test/watchdog",
+                   test_watchdog);
+    qtest_add_func("/sifive-e-aon-watchdog-test/scaled_watchdog",
+                   test_scaled_watchdog);
+    qtest_add_func("/sifive-e-aon-watchdog-test/periodic_int",
+                   test_periodic_int);
+    qtest_add_func("/sifive-e-aon-watchdog-test/enable_disable",
+                   test_enable_disable);
+    return g_test_run();
+}
-- 
2.27.0


