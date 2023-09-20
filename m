Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6517A8F2D
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 00:19:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj5Wp-0002Rc-TM; Wed, 20 Sep 2023 18:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3t28LZQwKCvIhUVcbYmnYZUhaiiafY.WigkYgo-XYpYfhihaho.ila@flex--nabihestefan.bounces.google.com>)
 id 1qj5Wm-0002PX-KE
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 18:18:36 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3t28LZQwKCvIhUVcbYmnYZUhaiiafY.WigkYgo-XYpYfhihaho.ila@flex--nabihestefan.bounces.google.com>)
 id 1qj5Wj-0008B5-0t
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 18:18:36 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-cf4cb742715so459885276.2
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 15:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695248312; x=1695853112; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=iipax4OApn/M9zl+6fRBSo1VIvf0vsS6Evwnnregcb8=;
 b=YHS43VjtzOEW+ROe59xSMzyqlYVucm0cH4oGoOCRiIcyr3s4yHF+ul6Y53Lp/phdMR
 CjgbSq/99t7zf+owYQiQ6poXVieYIhTpQjSKS6x1NZIBNfmNDxIRE8GcEbL2DZ5+Mx1S
 eJw2S37y75eZJXxirv5J9BHYEJAAXC96NEt95+DVBqO54nPMxotO6cd3Z47+Xi7naFvU
 rQE9qv/cbbcqKDx/5xlVNZOKNTa8rUdduQ2h7fDbfeCBKMZdHuV/mavVoK1muzbZ8ujy
 ZNq9htK1eBqfsIiEnul6K/YnmSL+gmyzpdF5wNJ/D8J/MwisXRdRc2MJARIkyH/x72Aq
 Fpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695248312; x=1695853112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iipax4OApn/M9zl+6fRBSo1VIvf0vsS6Evwnnregcb8=;
 b=uKN2MBIVhbS0gAfEo9R394Fv1aw4xoupwB9BHHWt7uGikOimmk85RrxwZOrnBtbtMV
 f6V/Hw3hQEoX61pB3m2DAvagmD/Lq5L0vHwF0wLM1/B/UR/x837KrvGJZ+kMpsrvEd1b
 /1bLUKvddAjdhoZKdnbMNPUBx0tjv0LRFee4No19zdhSYaQauLKn3ndm6v2xepWJEGr9
 /zcvQanitj37hachYJnu3WLPmrW6HAd6RAfqF8bHFrHxmPVj9WLHAW/IaPqMcWf80OeJ
 FZnUb34lsTD0lrVCZvwjg+JhV6dNH12/LZKhbB0eyQqYunc2PJvUTYrDzVlp4HmN64CP
 C3aw==
X-Gm-Message-State: AOJu0Yz5TK2ZatNMcs4LVjyvfxdBgLlOf222B52kMSFg02OqBKlzgODx
 xTCFulvu6Oj7pwuu6NaaGK2Lnoa4IQBOo7GpFVc=
X-Google-Smtp-Source: AGHT+IE96oOwNlyrOzIr2fCOX6b+mvZARsKHAk9rLtvh41+IEcu11sCeuIN2Dfm1nD/WAepxZrWL6xJGJQaEVEE7/G4=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a25:585:0:b0:d79:3b84:9997 with SMTP
 id 127-20020a250585000000b00d793b849997mr52359ybf.7.1695248311917; Wed, 20
 Sep 2023 15:18:31 -0700 (PDT)
Date: Wed, 20 Sep 2023 22:18:14 +0000
In-Reply-To: <20230920221819.1106029-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20230920221819.1106029-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920221819.1106029-7-nabihestefan@google.com>
Subject: [PATCH v2 06/11] \tests/qtest: Creating qtest for GMAC Module
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com, 
 Nabih Estefan Diaz <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3t28LZQwKCvIhUVcbYmnYZUhaiiafY.WigkYgo-XYpYfhihaho.ila@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Nabih Estefan Diaz <nabihestefan@google.com>
---
 tests/qtest/meson.build      |  11 +-
 tests/qtest/npcm_gmac-test.c | 209 +++++++++++++++++++++++++++++++++++
 2 files changed, 215 insertions(+), 5 deletions(-)
 create mode 100644 tests/qtest/npcm_gmac-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 849394515d..7c9622d8e1 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -191,6 +191,8 @@ qtests_npcm7xx = \
    'npcm7xx_timer-test',
    'npcm7xx_watchdog_timer-test'] + \
    (slirp.found() ? ['npcm7xx_emc-test'] : [])
+qtests_npcm8xx = \
+  ['npcm_gmac-test']
 qtests_aspeed = \
   ['aspeed_hace-test',
    'aspeed_smc-test',
@@ -205,9 +207,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed : []) + \
   (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
   (config_all_devices.has_key('CONFIG_GENERIC_LOADER') ? ['hexloader-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
-  (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
   ['arm-cpu-features',
    'boot-serial-test']
 
@@ -219,8 +219,9 @@ qtests_aarch64 = \
   (config_all_devices.has_key('CONFIG_XLNX_ZYNQMP_ARM') ? ['xlnx-can-test', 'fuzz-xlnx-dp-test'] : []) + \
   (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test'] : []) + \
   (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test'] : []) +  \
-  (config_all.has_key('CONFIG_TCG') and                                            \
-   config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed : []) + \
+  (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
+  (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
   ['arm-cpu-features',
    'numa-test',
    'boot-serial-test',
diff --git a/tests/qtest/npcm_gmac-test.c b/tests/qtest/npcm_gmac-test.c
new file mode 100644
index 0000000000..30d27e8dcc
--- /dev/null
+++ b/tests/qtest/npcm_gmac-test.c
@@ -0,0 +1,209 @@
+/*
+ * QTests for Nuvoton NPCM7xx/8xx GMAC Modules.
+ *
+ * Copyright 2022 Google LLC
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
+    CHECK_REG32(NPCM_GMAC_VERSION, 0x00001037);
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
+            "npcm8xx_gmac/gmac[%d]/%s", gmac_module_index(td->module), name);
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
2.42.0.459.ge4e396fd5e-goog


