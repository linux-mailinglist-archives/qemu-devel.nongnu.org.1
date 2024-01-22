Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5457836DCC
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 18:39:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRyEn-0000De-MI; Mon, 22 Jan 2024 12:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <30aeuZQwKChA3qryxu89uvq3w44w1u.s426u2A-tuBu1343w3A.47w@flex--nabihestefan.bounces.google.com>)
 id 1rRyEe-00008r-VN
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:37:25 -0500
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <30aeuZQwKChA3qryxu89uvq3w44w1u.s426u2A-tuBu1343w3A.47w@flex--nabihestefan.bounces.google.com>)
 id 1rRyEc-0003zv-I7
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:37:24 -0500
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5ff93902762so51534847b3.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 09:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1705945041; x=1706549841; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=FnI4mKUjr9PEw5tAB0k4dIOsWaC4nmReMpnNfpzQsbI=;
 b=CXqlPaJRIWmDg5wGTm0LMkDRwajRX8FSoSY4od4hWDyx2zwQQfuT5e1KL4Nye93NmN
 KI3coic/hL+rRE2/X5DbEEsvwgx6+I17iLAcmqfj5AzStS1q+f+2Lt202NZYVGdTBXRL
 UQSMRMgNUYEoN/SQOWPtifvpiWyP3YUI5TTEDHcjLLmS16rQV4K2H1nJy2NJWaiE9KaE
 fXN93hTIaLaA6P3S5/guhl5p67vpzf+jtVh7jXT9z0m8UUtFsWuah5gE/wLbXWxlWyx+
 7Ur3V1c367PmvQ+WtMjNopUeaDmVVFEspO9hTd/StfgHVAEN4RXTc2kdGAEE24arwo85
 d0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705945041; x=1706549841;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FnI4mKUjr9PEw5tAB0k4dIOsWaC4nmReMpnNfpzQsbI=;
 b=PdMc46gCjiymr5WY2gPPvngdIny51CqRz69cRZ+GWmt548xnkElLozlRJADxgBgFmn
 Op/PuxWmIZFrdchBJWm/bmBUITidHyUIHE5jkHGrBUzMEE/tsJrc8qGcoixhzbNzirjs
 /qJy9hB4wdNRhhrOweGwGOkk1q9iZUThRcsdlEkTBNVI6VPIzJFTo1Njl0k4+BzW99sc
 CcE71JLJpWjyuGuG0aQMm4i4duYvj4AxBELn/orIv0arNYJe+t9P+3c/ybTVvqc+XMMe
 qSQlRRFPSN6YK8wmXfpAYHe+QZcxDnVNhqzDOvzW61Jwpwbiy/LWRlUC0UPdYF9kYoaY
 7UeQ==
X-Gm-Message-State: AOJu0YxkoezV+vUQ7W35EV+KuhbxAebZ8b2ig0L1b01HkEoJydback8e
 ysoJtXju1j6ZrA4AYg4Vgm9YTYKsyTRU9/HO/i4Zb96asFlBYA2VEkuXWim/lyIMpOXdWZViOrM
 TA9P+XBR+CL9yECa9cQdWkzRG6g==
X-Google-Smtp-Source: AGHT+IFLKgX0PXfwCywogNL2E3NhEPyKydXY+QcQAZM3T48AaOGZXdcLjKpTkVYuGRvWDN/tx0w5P9/6t2YJZ5TSU/Q=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a25:2946:0:b0:dc2:66ad:74c9 with SMTP
 id p67-20020a252946000000b00dc266ad74c9mr2237200ybp.0.1705945041060; Mon, 22
 Jan 2024 09:37:21 -0800 (PST)
Date: Mon, 22 Jan 2024 17:37:03 +0000
In-Reply-To: <20240122173706.4019545-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240122173706.4019545-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122173706.4019545-7-nabihestefan@google.com>
Subject: [PATCH v14 6/9] tests/qtest: Creating qtest for GMAC Module
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=30aeuZQwKChA3qryxu89uvq3w44w1u.s426u2A-tuBu1343w3A.47w@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x1149.google.com
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
index 53c8a62f33..547f474317 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -222,6 +222,7 @@ qtests_aarch64 = \
   (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test'] : []) +  \
   (config_all_accel.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
   ['arm-cpu-features',
    'numa-test',
    'boot-serial-test',
diff --git a/tests/qtest/npcm_gmac-test.c b/tests/qtest/npcm_gmac-test.c
new file mode 100644
index 0000000000..6914ac92f1
--- /dev/null
+++ b/tests/qtest/npcm_gmac-test.c
@@ -0,0 +1,209 @@
+/*
+ * QTests for Nuvoton NPCM7xx/8xx GMAC Modules.
+ *
+ * Copyright 2024 Google LLC
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
2.43.0.429.g432eaa2c6b-goog


