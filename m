Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BACC82A50A
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 00:44:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNiDp-0007Vp-U8; Wed, 10 Jan 2024 18:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3eyufZQwKCoItghonkyzklgtmuumrk.iuswks0-jk1krtutmt0.uxm@flex--nabihestefan.bounces.google.com>)
 id 1rNiDn-0007Uf-KD
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 18:42:55 -0500
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3eyufZQwKCoItghonkyzklgtmuumrk.iuswks0-jk1krtutmt0.uxm@flex--nabihestefan.bounces.google.com>)
 id 1rNiDl-0006eW-Gm
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 18:42:55 -0500
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-dbe868fdc33so6489419276.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 15:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1704930172; x=1705534972; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=42xprXs06DWm4lStKy/BM57kGpD+2J+KlcSKMHAVbfs=;
 b=hhOKHRLOZbqsWV6MJDZ6cnBmYpc0OlrkjEAzsE2jtXnCjyHdX42g8pzayrsTe55wlw
 BhNRG8FXEbdTYgkDlhExdu/r2lKJhZRvKOt84GKseXmZ3QiV9YGdmf2Z9Dn9jBnhqcyW
 fa9cbunD1Bq8CS3oIiSHmweonpnS0SqrxnghUTitiUhnhasA+FgFtCDvyb6K8l8t1+4G
 USvLxjIn0UkxZtz7x5cdsXJxf2jFc7NQsNhxEfZ9s4H7WT94zd7ZsejimId/jNJSuNKX
 y4hzUXcaD33y9SAXZFjNJQAcIYLVw9AhZyS7RCAd3EUvwRNwhz7yFI5bN3pwt01/f/7D
 1Q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704930172; x=1705534972;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=42xprXs06DWm4lStKy/BM57kGpD+2J+KlcSKMHAVbfs=;
 b=IyM62sGDSCxbSPMQmex5CnjU8J6jg1h1+mYNPLakLJtaKOri13ay9Wds1Su/X8Vu2t
 ARr++CwNyQjmdpVid60Ctn2HRoFELEVhUhNrEUpoVgVNE7gZfTxXTsL1QGoE9Ep+03JU
 ntbqFQb1kUUYLk8Gi/jSPIIL2Z4Sl0ZtyklAwzhQgl8fkYyruiH94QpSdtzVzlbUFQGQ
 qanj2r4kpgx9SEyuvTC9W+LBk0qDKqaQZnjeG5zEKhsoOpWf0XDW7BZ8Tfu4Y+HAsDnm
 nrQkcrBcHUrNW632PWuw4a2jHX5fEpKQvtlth9zC6O6PSHoSdp4081WEzg3DRaarjeTK
 2UMQ==
X-Gm-Message-State: AOJu0YzxAbTmtpBslUKoSvSaxX2KWr9tQbR37mlu0YGwBMEq0o4xwuju
 pUuQf+WklEpwA5LWAYy/DRIyT71NDeVeG1tfVW8BL+iegA==
X-Google-Smtp-Source: AGHT+IGetWDTwHf+GmmidiXxyDdK4J26mQ7xpGgCmAqaf+xc1mrIsrpKOOpRQ9IHJVbMSwpDa9+g99T5kuPueNdLMQg=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:52b:b0:db5:f536:17d4 with
 SMTP id y11-20020a056902052b00b00db5f53617d4mr161779ybs.11.1704930171836;
 Wed, 10 Jan 2024 15:42:51 -0800 (PST)
Date: Wed, 10 Jan 2024 23:42:28 +0000
In-Reply-To: <20240110234232.4116804-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240110234232.4116804-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240110234232.4116804-7-nabihestefan@google.com>
Subject: [PATCH v12 06/10] tests/qtest: Creating qtest for GMAC Module
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3eyufZQwKCoItghonkyzklgtmuumrk.iuswks0-jk1krtutmt0.uxm@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Nabih Estefan Diaz <nabihestefan@google.com>

 - Created qtest to check initialization of registers in GMAC Module.
 - Implemented test into Build File.

Change-Id: I8b2fe152d3987a7eec4cf6a1d25ba92e75a5391d
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
---
 tests/qtest/meson.build      |   1 +
 tests/qtest/npcm_gmac-test.c | 209 +++++++++++++++++++++++++++++++++++
 2 files changed, 210 insertions(+)
 create mode 100644 tests/qtest/npcm_gmac-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 41bc75c8b1..2471298f3e 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -221,6 +221,7 @@ qtests_aarch64 = \
   (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test'] : []) +  \
   (config_all_accel.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
   ['arm-cpu-features',
    'numa-test',
    'boot-serial-test',
diff --git a/tests/qtest/npcm_gmac-test.c b/tests/qtest/npcm_gmac-test.c
new file mode 100644
index 0000000000..130a1599a8
--- /dev/null
+++ b/tests/qtest/npcm_gmac-test.c
@@ -0,0 +1,209 @@
+/*
+ * QTests for Nuvoton NPCM7xx/8xx GMAC Modules.
+ *
+ * Copyright 2023 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#include "qemu/osdep.h"
+#include "libqos/libqos.h"
+
+/* Name of the GMAC Device */
+#define TYPE_NPCM_GMAC "npcm-gmac"
+
+typedef struct GMACModule {
+    int irq;
+    uint64_t base_addr;
+} GMACModule;
+
+typedef struct TestData {
+    const GMACModule *module;
+} TestData;
+
+/* Values extracted from hw/arm/npcm8xx.c */
+static const GMACModule gmac_module_list[] = {
+    {
+        .irq        = 14,
+        .base_addr  = 0xf0802000
+    },
+    {
+        .irq        = 15,
+        .base_addr  = 0xf0804000
+    },
+    {
+        .irq        = 16,
+        .base_addr  = 0xf0806000
+    },
+    {
+        .irq        = 17,
+        .base_addr  = 0xf0808000
+    }
+};
+
+/* Returns the index of the GMAC module. */
+static int gmac_module_index(const GMACModule *mod)
+{
+    ptrdiff_t diff = mod - gmac_module_list;
+
+    g_assert_true(diff >= 0 && diff < ARRAY_SIZE(gmac_module_list));
+
+    return diff;
+}
+
+/* 32-bit register indices. Taken from npcm_gmac.c */
+typedef enum NPCMRegister {
+    /* DMA Registers */
+    NPCM_DMA_BUS_MODE = 0x1000,
+    NPCM_DMA_XMT_POLL_DEMAND = 0x1004,
+    NPCM_DMA_RCV_POLL_DEMAND = 0x1008,
+    NPCM_DMA_RCV_BASE_ADDR = 0x100c,
+    NPCM_DMA_TX_BASE_ADDR = 0x1010,
+    NPCM_DMA_STATUS = 0x1014,
+    NPCM_DMA_CONTROL = 0x1018,
+    NPCM_DMA_INTR_ENA = 0x101c,
+    NPCM_DMA_MISSED_FRAME_CTR = 0x1020,
+    NPCM_DMA_HOST_TX_DESC = 0x1048,
+    NPCM_DMA_HOST_RX_DESC = 0x104c,
+    NPCM_DMA_CUR_TX_BUF_ADDR = 0x1050,
+    NPCM_DMA_CUR_RX_BUF_ADDR = 0x1054,
+    NPCM_DMA_HW_FEATURE = 0x1058,
+
+    /* GMAC Registers */
+    NPCM_GMAC_MAC_CONFIG = 0x0,
+    NPCM_GMAC_FRAME_FILTER = 0x4,
+    NPCM_GMAC_HASH_HIGH = 0x8,
+    NPCM_GMAC_HASH_LOW = 0xc,
+    NPCM_GMAC_MII_ADDR = 0x10,
+    NPCM_GMAC_MII_DATA = 0x14,
+    NPCM_GMAC_FLOW_CTRL = 0x18,
+    NPCM_GMAC_VLAN_FLAG = 0x1c,
+    NPCM_GMAC_VERSION = 0x20,
+    NPCM_GMAC_WAKEUP_FILTER = 0x28,
+    NPCM_GMAC_PMT = 0x2c,
+    NPCM_GMAC_LPI_CTRL = 0x30,
+    NPCM_GMAC_TIMER_CTRL = 0x34,
+    NPCM_GMAC_INT_STATUS = 0x38,
+    NPCM_GMAC_INT_MASK = 0x3c,
+    NPCM_GMAC_MAC0_ADDR_HI = 0x40,
+    NPCM_GMAC_MAC0_ADDR_LO = 0x44,
+    NPCM_GMAC_MAC1_ADDR_HI = 0x48,
+    NPCM_GMAC_MAC1_ADDR_LO = 0x4c,
+    NPCM_GMAC_MAC2_ADDR_HI = 0x50,
+    NPCM_GMAC_MAC2_ADDR_LO = 0x54,
+    NPCM_GMAC_MAC3_ADDR_HI = 0x58,
+    NPCM_GMAC_MAC3_ADDR_LO = 0x5c,
+    NPCM_GMAC_RGMII_STATUS = 0xd8,
+    NPCM_GMAC_WATCHDOG = 0xdc,
+    NPCM_GMAC_PTP_TCR = 0x700,
+    NPCM_GMAC_PTP_SSIR = 0x704,
+    NPCM_GMAC_PTP_STSR = 0x708,
+    NPCM_GMAC_PTP_STNSR = 0x70c,
+    NPCM_GMAC_PTP_STSUR = 0x710,
+    NPCM_GMAC_PTP_STNSUR = 0x714,
+    NPCM_GMAC_PTP_TAR = 0x718,
+    NPCM_GMAC_PTP_TTSR = 0x71c,
+} NPCMRegister;
+
+static uint32_t gmac_read(QTestState *qts, const GMACModule *mod,
+                          NPCMRegister regno)
+{
+    return qtest_readl(qts, mod->base_addr + regno);
+}
+
+/* Check that GMAC registers are reset to default value */
+static void test_init(gconstpointer test_data)
+{
+    const TestData *td = test_data;
+    const GMACModule *mod = td->module;
+    QTestState *qts = qtest_init("-machine npcm845-evb");
+
+#define CHECK_REG32(regno, value) \
+    do { \
+        g_assert_cmphex(gmac_read(qts, mod, (regno)), ==, (value)); \
+    } while (0)
+
+    CHECK_REG32(NPCM_DMA_BUS_MODE, 0x00020100);
+    CHECK_REG32(NPCM_DMA_XMT_POLL_DEMAND, 0);
+    CHECK_REG32(NPCM_DMA_RCV_POLL_DEMAND, 0);
+    CHECK_REG32(NPCM_DMA_RCV_BASE_ADDR, 0);
+    CHECK_REG32(NPCM_DMA_TX_BASE_ADDR, 0);
+    CHECK_REG32(NPCM_DMA_STATUS, 0);
+    CHECK_REG32(NPCM_DMA_CONTROL, 0);
+    CHECK_REG32(NPCM_DMA_INTR_ENA, 0);
+    CHECK_REG32(NPCM_DMA_MISSED_FRAME_CTR, 0);
+    CHECK_REG32(NPCM_DMA_HOST_TX_DESC, 0);
+    CHECK_REG32(NPCM_DMA_HOST_RX_DESC, 0);
+    CHECK_REG32(NPCM_DMA_CUR_TX_BUF_ADDR, 0);
+    CHECK_REG32(NPCM_DMA_CUR_RX_BUF_ADDR, 0);
+    CHECK_REG32(NPCM_DMA_HW_FEATURE, 0x100d4f37);
+
+    CHECK_REG32(NPCM_GMAC_MAC_CONFIG, 0);
+    CHECK_REG32(NPCM_GMAC_FRAME_FILTER, 0);
+    CHECK_REG32(NPCM_GMAC_HASH_HIGH, 0);
+    CHECK_REG32(NPCM_GMAC_HASH_LOW, 0);
+    CHECK_REG32(NPCM_GMAC_MII_ADDR, 0);
+    CHECK_REG32(NPCM_GMAC_MII_DATA, 0);
+    CHECK_REG32(NPCM_GMAC_FLOW_CTRL, 0);
+    CHECK_REG32(NPCM_GMAC_VLAN_FLAG, 0);
+    CHECK_REG32(NPCM_GMAC_VERSION, 0x00001032);
+    CHECK_REG32(NPCM_GMAC_WAKEUP_FILTER, 0);
+    CHECK_REG32(NPCM_GMAC_PMT, 0);
+    CHECK_REG32(NPCM_GMAC_LPI_CTRL, 0);
+    CHECK_REG32(NPCM_GMAC_TIMER_CTRL, 0x03e80000);
+    CHECK_REG32(NPCM_GMAC_INT_STATUS, 0);
+    CHECK_REG32(NPCM_GMAC_INT_MASK, 0);
+    CHECK_REG32(NPCM_GMAC_MAC0_ADDR_HI, 0x8000ffff);
+    CHECK_REG32(NPCM_GMAC_MAC0_ADDR_LO, 0xffffffff);
+    CHECK_REG32(NPCM_GMAC_MAC1_ADDR_HI, 0x0000ffff);
+    CHECK_REG32(NPCM_GMAC_MAC1_ADDR_LO, 0xffffffff);
+    CHECK_REG32(NPCM_GMAC_MAC2_ADDR_HI, 0x0000ffff);
+    CHECK_REG32(NPCM_GMAC_MAC2_ADDR_LO, 0xffffffff);
+    CHECK_REG32(NPCM_GMAC_MAC3_ADDR_HI, 0x0000ffff);
+    CHECK_REG32(NPCM_GMAC_MAC3_ADDR_LO, 0xffffffff);
+    CHECK_REG32(NPCM_GMAC_RGMII_STATUS, 0);
+    CHECK_REG32(NPCM_GMAC_WATCHDOG, 0);
+    CHECK_REG32(NPCM_GMAC_PTP_TCR, 0x00002000);
+    CHECK_REG32(NPCM_GMAC_PTP_SSIR, 0);
+    CHECK_REG32(NPCM_GMAC_PTP_STSR, 0);
+    CHECK_REG32(NPCM_GMAC_PTP_STNSR, 0);
+    CHECK_REG32(NPCM_GMAC_PTP_STSUR, 0);
+    CHECK_REG32(NPCM_GMAC_PTP_STNSUR, 0);
+    CHECK_REG32(NPCM_GMAC_PTP_TAR, 0);
+    CHECK_REG32(NPCM_GMAC_PTP_TTSR, 0);
+
+    qtest_quit(qts);
+}
+
+static void gmac_add_test(const char *name, const TestData* td,
+                          GTestDataFunc fn)
+{
+    g_autofree char *full_name = g_strdup_printf(
+            "npcm7xx_gmac/gmac[%d]/%s", gmac_module_index(td->module), name);
+    qtest_add_data_func(full_name, td, fn);
+}
+
+int main(int argc, char **argv)
+{
+    TestData test_data_list[ARRAY_SIZE(gmac_module_list)];
+
+    g_test_init(&argc, &argv, NULL);
+
+    for (int i = 0; i < ARRAY_SIZE(gmac_module_list); ++i) {
+        TestData *td = &test_data_list[i];
+
+        td->module = &gmac_module_list[i];
+
+        gmac_add_test("init", td, test_init);
+    }
+
+    return g_test_run();
+}
-- 
2.43.0.275.g3460e3d667-goog


