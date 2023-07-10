Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B5D74D5BC
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:37:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq5U-0002lq-Th; Mon, 10 Jul 2023 08:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq55-0002TX-Na
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:34 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq51-0004dm-UV
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:31 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3a1ebb85f99so3917840b6e.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992406; x=1691584406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cxBrCIolhIsD7NI1IP0Rohed8fcXsI/MKTpiPGDk7nM=;
 b=pucbyxw0F2wpm5bTX0kRazPEYqbKgqQz0cnOAK4jFvcqIjSKU6Ix0QLSE7rVh/XvZr
 PeG6iYsfWslVSZ6Wi6bxbSOMyjXAH1o1Fd+NHrbb6H5dTkSe983ZIDzrJMv012i3/Q+V
 F/+AWX0mfNCiteMV9Jg7eCzJyy+bEtJlU9MA4POu1NYLczh3NWGfP/+6KndNKlpN+/tp
 ud3n2jt9Nf9sGoAJIWMvg9uAbqTaaNZ05o+FDwyVRXOw+ITvca86o+baiE80sN2i2tky
 Ec+ozCEwNl0Ctz1QAqNamd84pewBRYfoRVxKWSS9ul7VKJXgqwqXf0EnaaPVD/fVujyr
 LDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992406; x=1691584406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cxBrCIolhIsD7NI1IP0Rohed8fcXsI/MKTpiPGDk7nM=;
 b=Y/Rh1SLMkk7bHgoAcrIaWh7xc1GepWyeyBCkxXiJLLhE3j84SM3ghBu4wazJ6ZbvTp
 /5vGqn05th/jjhsG+hakJEF4+BIzJOJOB1WcikokMsw3mMsvqRgc5mWg7GSBnDKIBAnF
 48TOnwC5gAgwyGHRZuZovVNqVwVrfDBVOsYUk6QTAyfF5ZRChY6Qw2nIsHfW69IYhGXY
 4d7PpeMEyvnKvnLgbntm/J+tT293y2k33OSkUkbKCfSG9zTqmXb3AV5zDEMVfcj2tclK
 AopLEPQgp0DFkRd/I30O0jvJca7bJ6vy9oJTInjY9gHA7jWSRWyy0hED0OH9QuA/dXzt
 ZdMw==
X-Gm-Message-State: ABy/qLYHej8K9FYT6QPycCwGCHxCGG2EFN/T9w82mEJBn8eANaSskzRt
 awT66UWozFhrHS4aU/WRcaaHVtjownqang==
X-Google-Smtp-Source: APBJJlFVSusxeIDoRH6q9Lm/8gipfz9b7cRrhc4Zi4aPDlDwshew8N0SYvUI2oFSMveYpz5fTtLlBw==
X-Received: by 2002:a05:6358:88b:b0:132:db25:bbfc with SMTP id
 m11-20020a056358088b00b00132db25bbfcmr14739368rwj.2.1688992406454; 
 Mon, 10 Jul 2023 05:33:26 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:33:25 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 19/54] tests/qtest: sifive-e-aon-watchdog-test.c: Add QTest of
 watchdog of sifive_e
Date: Mon, 10 Jul 2023 22:31:30 +1000
Message-Id: <20230710123205.2441106-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Tommy Wu <tommy.wu@sifive.com>

Add some simple tests of the watchdog timer in the always-on domain device
of HiFive 1 rev b.

Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230627141216.3962299-4-tommy.wu@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/sifive-e-aon-watchdog-test.c | 450 +++++++++++++++++++++++
 tests/qtest/meson.build                  |   3 +
 2 files changed, 453 insertions(+)
 create mode 100644 tests/qtest/sifive-e-aon-watchdog-test.c

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
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 74630f6672..b071d400b3 100644
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
-- 
2.40.1


