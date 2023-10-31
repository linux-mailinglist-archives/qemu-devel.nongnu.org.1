Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9747DD644
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 19:47:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtlR-0005MN-Cw; Tue, 31 Oct 2023 14:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qxtlA-0005I9-Pe; Tue, 31 Oct 2023 14:46:42 -0400
Received: from mail-dm6nam11on20627.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::627]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qxtl8-0003mA-Fh; Tue, 31 Oct 2023 14:46:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/e9Zi8di0dZt/8HfEjOdUIU4GLuYMNNt3iG/AQVm/Ld+UcvxZaTAxU0X6btKGP+MJRXqp5I31ljLd1P2ICrpz3Std+ANenwNyd87sQ1Agm1dqA9/ym/ANw5AwcKJ0ENx+8yNTvdhUA/t9R0BN8qz8Zr6ZUD6W0fYw8RIfF0RJXGHa7l5Dp7mo6I6Xmvel0nY+QILCE36YFfXLE2gYYGHA4m+MWvSdanqHREYNGo2lTD4ucBXpQ3oPOl1XS9AD41hJdRSOhOEYt4IHNnlFdc45Kz5EzKf9Yphv7qq9K2s7LK0HLiqstwCkqkl3jgmzNVO1Q6efaBCO5QrXj3hgk5dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=objj/FDquT/1p9npsqZred/iyWW+1TNiwAzdvnEsvKE=;
 b=h1sGg9JzdbST74OcUG7cAyozJ4soHZUKecVDd16+hTlCEdRofpvtNPypsBpNrodb5buAhtuTLtlK0r3p9QZBb70UQFu3GBH6x64B4wxermA/L7zGgICjwS6O7M2IM+Nr10VxBu3CqI5/DeBlpAId27C/IxfoEnuWF6KapqF+ilZrwyNJPCGFwBGKe1vHgDdeBu7q/m/BRYXhvOBck8qb+QmaX5ufM/nQSzDNh3TV0FaGTpUw5LMzwt8ZQqtOpfpMroaGGMM4Ta66Ilc8B2v3M7fcupiLvFAg7TZutU+POItp77FfZctfP4yARGOLnNfIpyZN86hpCubwidQdk6Wv0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=objj/FDquT/1p9npsqZred/iyWW+1TNiwAzdvnEsvKE=;
 b=BqvveHkwrEkBxS8+ckFXKEhQgsyopWOAY/jW4vNV2X7ZPUcfclHdrb86dBP6kw62wmUIfOr9FZfR4BU5+ugbD962OymRDG7I3qJPE48DTeHMnyLHe6AyRXWw70om5PgTHnSMN7bY724Us2uC4Cu4wEvJ2QnFI7Po1j1solIAmJ8=
Received: from MW4PR02CA0027.namprd02.prod.outlook.com (2603:10b6:303:16d::32)
 by DS0PR12MB7703.namprd12.prod.outlook.com (2603:10b6:8:130::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 18:46:33 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::fb) by MW4PR02CA0027.outlook.office365.com
 (2603:10b6:303:16d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29 via Frontend
 Transport; Tue, 31 Oct 2023 18:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Tue, 31 Oct 2023 18:46:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 13:46:19 -0500
Received: from xsjtongh40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 31 Oct 2023 13:46:19 -0500
From: Tong Ho <tong.ho@amd.com>
To: <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <frasse.iglesias@gmail.com>,
 <tong.ho@amd.com>
Subject: [PATCH v5 3/3] tests/qtest: Introduce tests for AMD/Xilinx Versal
 TRNG device
Date: Tue, 31 Oct 2023 11:46:11 -0700
Message-ID: <20231031184611.3029156-4-tong.ho@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031184611.3029156-1-tong.ho@amd.com>
References: <20231031184611.3029156-1-tong.ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|DS0PR12MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7b1152-2580-4172-a95b-08dbda41b3a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nybXUiZTTDWJcAz7clF2zwr35aesGNsHFnkTPwHcYRE+kK0bD9ie5ULvLNj0bZQo5JxKKCzZIbZch5wsWOy0XMrq5T2EaOSaZZPImxxOQba6aTMIxPR3J52GUVWf4nmLKDIw16L60gNKtGr52WKtXiCzkdxJ1FOTaL9NTn/3R1hY3Vkjn89MyidRkHtH6SEN0PGt5G+VwhXxIIWwkrDmWFr0mPkpltlNmSZj+9jU79Acu0ILAOlc8zCRp/TXthheHwWuv9q+tvpMc/f385gvKVBUfwwAIgnTGPo7PLVr69QxYsB/MR9bigQ2dhRba+CfiLtFXg8KpB7RF/dZSwVmspUFn3Kf/ZBPQX5O6b4lRwjEJvizteJSuZqvKapeXtA3hUrUHgG1EypWZaihUHmn22LHqQ7by6c/tHD6rW2eZ/hx37Fhh1fZcgs1xvINsmFpEomfkmup+WjXpAwgCR89kLf+9VAZOeWsLmNONZRqHMLs/DgLMhEtTp1APOM7OxyCkTim+u52NXxcfngkCLQ/NFveaaH1SqeBvdlGTkG/V/QwJmQ5gsLsTmYbKEDgyUYtatZhMtIa53soxkk+O6UsdX6sxe1eo7o9Majn/gijSK+IMUGHeqwjwTJAVugfHQX+EJAzAsxPPYR1kR60Gnagv/hWVa0NtBr9ODsGIDFzdVi6sqS0rckoBPr9gjqVtWLaPIsKD9ohjkSy4xPxXEblmutZP5yN6+df/a7cWR6Ui8pN65e29Jct1UtZB2rdzjxaTFn72K1tqEN/fBR6sfx78A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(26005)(1076003)(40460700003)(86362001)(36756003)(40480700001)(81166007)(82740400003)(356005)(426003)(30864003)(8936002)(2906002)(83380400001)(478600001)(36860700001)(47076005)(6666004)(2616005)(316002)(8676002)(54906003)(6916009)(336012)(4326008)(5660300002)(41300700001)(70586007)(44832011)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 18:46:30.2461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7b1152-2580-4172-a95b-08dbda41b3a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7703
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::627;
 envelope-from=tong.ho@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Signed-off-by: Tong Ho <tong.ho@amd.com>
---
 tests/qtest/meson.build             |   2 +-
 tests/qtest/xlnx-versal-trng-test.c | 485 ++++++++++++++++++++++++++++
 2 files changed, 486 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/xlnx-versal-trng-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index d6022ebd64..c9945e69b1 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -216,7 +216,7 @@ qtests_aarch64 = \
   (config_all.has_key('CONFIG_TCG') and config_all_devices.has_key('CONFIG_TPM_TIS_SYSBUS') ?            \
     ['tpm-tis-device-test', 'tpm-tis-device-swtpm-test'] : []) +                                         \
   (config_all_devices.has_key('CONFIG_XLNX_ZYNQMP_ARM') ? ['xlnx-can-test', 'fuzz-xlnx-dp-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test', 'xlnx-versal-trng-test'] : []) + \
   (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test'] : []) +  \
   (config_all.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
diff --git a/tests/qtest/xlnx-versal-trng-test.c b/tests/qtest/xlnx-versal-trng-test.c
new file mode 100644
index 0000000000..cef4e575bb
--- /dev/null
+++ b/tests/qtest/xlnx-versal-trng-test.c
@@ -0,0 +1,485 @@
+/*
+ * QTests for the Xilinx Versal True Random Number Generator device
+ *
+ * Copyright (c) 2023 Advanced Micro Devices, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+/* Base Address */
+#define TRNG_BASEADDR      (0xf1230000)
+
+/* TRNG_INT_CTRL */
+#define R_TRNG_INT_CTRL                 (0x0000)
+#define   TRNG_INT_CTRL_CERTF_RST_MASK  (1 << 5)
+#define   TRNG_INT_CTRL_DTF_RST_MASK    (1 << 4)
+#define   TRNG_INT_CTRL_DONE_RST_MASK   (1 << 3)
+#define   TRNG_INT_CTRL_CERTF_EN_MASK   (1 << 2)
+#define   TRNG_INT_CTRL_DTF_EN_MASK     (1 << 1)
+#define   TRNG_INT_CTRL_DONE_EN_MASK    (1)
+
+/* TRNG_STATUS */
+#define R_TRNG_STATUS              (0x0004)
+#define   TRNG_STATUS_QCNT_SHIFT   (9)
+#define   TRNG_STATUS_QCNT_MASK    (7 << TRNG_STATUS_QCNT_SHIFT)
+#define   TRNG_STATUS_CERTF_MASK   (1 << 3)
+#define   TRNG_STATUS_DTF_MASK     (1 << 1)
+#define   TRNG_STATUS_DONE_MASK    (1)
+
+/* TRNG_CTRL */
+#define R_TRNG_CTRL                (0x0008)
+#define   TRNG_CTRL_PERSODISABLE_MASK   (1 << 10)
+#define   TRNG_CTRL_SINGLEGENMODE_MASK  (1 << 9)
+#define   TRNG_CTRL_PRNGMODE_MASK       (1 << 7)
+#define   TRNG_CTRL_TSTMODE_MASK        (1 << 6)
+#define   TRNG_CTRL_PRNGSTART_MASK      (1 << 5)
+#define   TRNG_CTRL_PRNGXS_MASK         (1 << 3)
+#define   TRNG_CTRL_TRSSEN_MASK         (1 << 2)
+#define   TRNG_CTRL_QERTUEN_MASK        (1 << 1)
+#define   TRNG_CTRL_PRNGSRST_MASK       (1)
+
+/* TRNG_EXT_SEED_0 ... _11 */
+#define R_TRNG_EXT_SEED_0          (0x0040)
+#define R_TRNG_EXT_SEED_11         (R_TRNG_EXT_SEED_0 + 4 * 11)
+
+/* TRNG_PER_STRNG_0 ... 11 */
+#define R_TRNG_PER_STRNG_0         (0x0080)
+#define R_TRNG_PER_STRNG_11        (R_TRNG_PER_STRNG_0 + 4 * 11)
+
+/* TRNG_CORE_OUTPUT */
+#define R_TRNG_CORE_OUTPUT         (0x00c0)
+
+/* TRNG_RESET */
+#define R_TRNG_RESET               (0x00d0)
+#define   TRNG_RESET_VAL_MASK      (1)
+
+/* TRNG_OSC_EN */
+#define R_TRNG_OSC_EN              (0x00d4)
+#define   TRNG_OSC_EN_VAL_MASK     (1)
+
+/* TRNG_TRNG_ISR, _IMR, _IER, _IDR */
+#define R_TRNG_ISR                 (0x00e0)
+#define R_TRNG_IMR                 (0x00e4)
+#define R_TRNG_IER                 (0x00e8)
+#define R_TRNG_IDR                 (0x00ec)
+#define   TRNG_IRQ_SLVERR_MASK     (1 << 1)
+#define   TRNG_IRQ_CORE_INT_MASK   (1)
+
+/*
+ * End test with a formatted error message, by embedding the message
+ * in a GError.
+ */
+#define TRNG_FAILED(FMT, ...)                           \
+    do {                                                \
+        g_autoptr(GError) err = g_error_new(            \
+            g_quark_from_static_string(trng_qname), 0,  \
+            FMT, ## __VA_ARGS__);                       \
+        g_assert_no_error(err);                         \
+    } while (0)
+
+static const gchar trng_qname[] = "xlnx-versal-trng-test";
+
+static const uint32_t prng_seed[12] = {
+    0x01234567, 0x12345678, 0x23456789, 0x3456789a, 0x456789ab, 0x56789abc,
+    0x76543210, 0x87654321, 0x98765432, 0xa9876543, 0xba987654, 0xfedcba98,
+};
+
+static const uint32_t pers_str[12] = {
+    0x76543210, 0x87654321, 0x98765432, 0xa9876543, 0xba987654, 0xfedcba98,
+    0x01234567, 0x12345678, 0x23456789, 0x3456789a, 0x456789ab, 0x56789abc,
+};
+
+static void trng_test_start(void)
+{
+    qtest_start("-machine xlnx-versal-virt");
+}
+
+static void trng_test_stop(void)
+{
+    qtest_end();
+}
+
+static void trng_test_set_uint_prop(const char *name, uint64_t value)
+{
+    const char *path = "/machine/xlnx-versal/trng";
+    QDict *response;
+
+    response = qmp("{ 'execute': 'qom-set',"
+                    " 'arguments': {"
+                       " 'path': %s,"
+                       " 'property': %s,"
+                       " 'value': %llu"
+                      "} }", path,
+                   name, (unsigned long long)value);
+    g_assert(qdict_haskey(response, "return"));
+    qobject_unref(response);
+}
+
+static void trng_write(unsigned ra, uint32_t val)
+{
+    writel(TRNG_BASEADDR + ra, val);
+}
+
+static uint32_t trng_read(unsigned ra)
+{
+    return readl(TRNG_BASEADDR + ra);
+}
+
+static void trng_bit_set(unsigned ra, uint32_t bits)
+{
+    trng_write(ra, (trng_read(ra) | bits));
+}
+
+static void trng_bit_clr(unsigned ra, uint32_t bits)
+{
+    trng_write(ra, (trng_read(ra) & ~bits));
+}
+
+static void trng_ctrl_set(uint32_t bits)
+{
+    trng_bit_set(R_TRNG_CTRL, bits);
+}
+
+static void trng_ctrl_clr(uint32_t bits)
+{
+    trng_bit_clr(R_TRNG_CTRL, bits);
+}
+
+static uint32_t trng_status(void)
+{
+    return trng_read(R_TRNG_STATUS);
+}
+
+static unsigned trng_qcnt(void)
+{
+    uint32_t sta = trng_status();
+
+    return (sta & TRNG_STATUS_QCNT_MASK) >> TRNG_STATUS_QCNT_SHIFT;
+}
+
+static const char *trng_info(void)
+{
+    uint32_t sta = trng_status();
+    uint32_t ctl = trng_read(R_TRNG_CTRL);
+
+    static char info[64];
+
+    snprintf(info, sizeof(info), "; status=0x%x, ctrl=0x%x", sta, ctl);
+    return info;
+}
+
+static void trng_check_status(uint32_t status_mask, const char *act)
+{
+    uint32_t clear_mask = 0;
+    uint32_t status;
+
+    /*
+     * Only selected bits are events in R_TRNG_STATUS, and
+     * clear them needs to go through R_INT_CTRL.
+     */
+    if (status_mask & TRNG_STATUS_CERTF_MASK) {
+        clear_mask |= TRNG_INT_CTRL_CERTF_RST_MASK;
+    }
+    if (status_mask & TRNG_STATUS_DTF_MASK) {
+        clear_mask |= TRNG_INT_CTRL_DTF_RST_MASK;
+    }
+    if (status_mask & TRNG_STATUS_DONE_MASK) {
+        clear_mask |= TRNG_INT_CTRL_DONE_RST_MASK;
+    }
+
+    status = trng_status();
+    if ((status & status_mask) != status_mask) {
+        TRNG_FAILED("%s: Status bitmask 0x%x failed to be 1%s",
+                    act, status_mask, trng_info());
+    }
+
+    /* Remove event */
+    trng_bit_set(R_TRNG_INT_CTRL, clear_mask);
+
+    if (!!(trng_read(R_TRNG_STATUS) & status_mask)) {
+        TRNG_FAILED("%s: Event 0x%0x stuck at 1 after clear: %s",
+                    act, status_mask, trng_info());
+    }
+}
+
+static void trng_check_done_status(const char *act)
+{
+    trng_check_status(TRNG_STATUS_DONE_MASK, act);
+}
+
+static void trng_check_dtf_status(void)
+{
+    trng_check_status(TRNG_STATUS_DTF_MASK, "DTF injection");
+}
+
+static void trng_check_certf_status(void)
+{
+    trng_check_status(TRNG_STATUS_CERTF_MASK, "CERTF injection");
+}
+
+static void trng_reset(void)
+{
+    trng_write(R_TRNG_RESET, TRNG_RESET_VAL_MASK);
+    trng_write(R_TRNG_RESET, 0);
+}
+
+static void trng_load(unsigned r0, const uint32_t *b384)
+{
+    static const uint32_t zero[12] = { 0 };
+    unsigned k;
+
+    if (!b384) {
+        b384 = zero;
+    }
+
+    for (k = 0; k < 12; k++) {
+        trng_write(r0 + 4 * k, b384[k]);
+    }
+}
+
+static void trng_reseed(const uint32_t *seed)
+{
+    const char *act;
+    uint32_t ctl;
+
+    ctl = TRNG_CTRL_PRNGSTART_MASK |
+          TRNG_CTRL_PRNGXS_MASK |
+          TRNG_CTRL_TRSSEN_MASK;
+
+    trng_ctrl_clr(ctl | TRNG_CTRL_PRNGMODE_MASK);
+
+    if (seed) {
+        trng_load(R_TRNG_EXT_SEED_0, seed);
+        act = "Reseed PRNG";
+        ctl &= ~TRNG_CTRL_TRSSEN_MASK;
+    } else {
+        trng_write(R_TRNG_OSC_EN, TRNG_OSC_EN_VAL_MASK);
+        act = "Reseed TRNG";
+        ctl &= ~TRNG_CTRL_PRNGXS_MASK;
+    }
+
+    trng_ctrl_set(ctl);
+    trng_check_done_status(act);
+    trng_ctrl_clr(TRNG_CTRL_PRNGSTART_MASK);
+}
+
+static void trng_generate(bool auto_enb)
+{
+    uint32_t ctl;
+
+    ctl = TRNG_CTRL_PRNGSTART_MASK | TRNG_CTRL_SINGLEGENMODE_MASK;
+    trng_ctrl_clr(ctl);
+
+    if (auto_enb) {
+        ctl &= ~TRNG_CTRL_SINGLEGENMODE_MASK;
+    }
+
+    trng_ctrl_set(ctl | TRNG_CTRL_PRNGMODE_MASK);
+
+    trng_check_done_status("Generate");
+    g_assert(trng_qcnt() != 7);
+}
+
+static size_t trng_collect(uint32_t *rnd, size_t cnt)
+{
+    size_t i;
+
+    for (i = 0; i < cnt; i++) {
+        if (trng_qcnt() == 0) {
+            return i;
+        }
+
+        rnd[i] = trng_read(R_TRNG_CORE_OUTPUT);
+    }
+
+    return i;
+}
+
+static void trng_test_autogen(void)
+{
+    const size_t cnt = 512 / 32;
+    uint32_t rng[cnt], prng[cnt];
+    size_t n;
+
+    trng_reset();
+
+    /* PRNG run #1 */
+    trng_reseed(prng_seed);
+    trng_generate(true);
+
+    n = trng_collect(prng, cnt);
+    if (n != cnt) {
+        TRNG_FAILED("PRNG_1 Auto-gen test failed: expected = %u, got = %u",
+                    (unsigned)cnt, (unsigned)n);
+    }
+
+    /* TRNG, should not match PRNG */
+    trng_reseed(NULL);
+    trng_generate(true);
+
+    n = trng_collect(rng, cnt);
+    if (n != cnt) {
+        TRNG_FAILED("TRNG Auto-gen test failed: expected = %u, got = %u",
+                    (unsigned)cnt, (unsigned)n);
+    }
+
+    /* PRNG #2: should matches run #1 */
+    trng_reseed(prng_seed);
+    trng_generate(true);
+
+    n = trng_collect(rng, cnt);
+    if (n != cnt) {
+        TRNG_FAILED("PRNG_2 Auto-gen test failed: expected = %u, got = %u",
+                    (unsigned)cnt, (unsigned)n);
+    }
+
+    if (memcmp(rng, prng, sizeof(rng))) {
+        TRNG_FAILED("PRNG_2 Auto-gen test failed: does not match PRNG_1");
+    }
+}
+
+static void trng_test_oneshot(void)
+{
+    const size_t cnt = 512 / 32;
+    uint32_t rng[cnt];
+    size_t n;
+
+    trng_reset();
+
+    /* PRNG run #1 */
+    trng_reseed(prng_seed);
+    trng_generate(false);
+
+    n = trng_collect(rng, cnt);
+    if (n == cnt) {
+        TRNG_FAILED("PRNG_1 One-shot gen test failed");
+    }
+
+    /* TRNG, should not match PRNG */
+    trng_reseed(NULL);
+    trng_generate(false);
+
+    n = trng_collect(rng, cnt);
+    if (n == cnt) {
+        TRNG_FAILED("TRNG One-shot test failed");
+    }
+}
+
+static void trng_test_per_str(void)
+{
+    const size_t cnt = 512 / 32;
+    uint32_t rng[cnt], prng[cnt];
+    size_t n;
+
+    trng_reset();
+
+    /* #1: disabled */
+    trng_ctrl_set(TRNG_CTRL_PERSODISABLE_MASK);
+    trng_reseed(prng_seed);
+    trng_ctrl_clr(TRNG_CTRL_PERSODISABLE_MASK);
+
+    trng_generate(true);
+    n = trng_collect(prng, cnt);
+    g_assert_cmpuint(n, ==, cnt);
+
+    /* #2: zero string should match personalization disabled */
+    trng_load(R_TRNG_PER_STRNG_0, NULL);
+    trng_reseed(prng_seed);
+
+    trng_generate(true);
+    n = trng_collect(rng, cnt);
+    g_assert_cmpuint(n, ==, cnt);
+
+    if (memcmp(rng, prng, sizeof(rng))) {
+        TRNG_FAILED("Failed: PER_DISABLE != PER_STRNG_ALL_ZERO");
+    }
+
+    /* #3: non-zero string should not match personalization disabled */
+    trng_load(R_TRNG_PER_STRNG_0, pers_str);
+    trng_reseed(prng_seed);
+
+    trng_generate(true);
+    n = trng_collect(rng, cnt);
+    g_assert_cmpuint(n, ==, cnt);
+
+    if (!memcmp(rng, prng, sizeof(rng))) {
+        TRNG_FAILED("Failed: PER_DISABLE == PER_STRNG_NON_ZERO");
+    }
+}
+
+static void trng_test_forced_prng(void)
+{
+    const char *prop = "forced-prng";
+    const uint64_t seed = 0xdeadbeefbad1bad0ULL;
+
+    const size_t cnt = 512 / 32;
+    uint32_t rng[cnt], prng[cnt];
+    size_t n;
+
+    trng_reset();
+    trng_test_set_uint_prop(prop, seed);
+
+    /* TRNG run #1 */
+    trng_reset();
+    trng_reseed(NULL);
+    trng_generate(true);
+
+    n = trng_collect(prng, cnt);
+    g_assert_cmpuint(n, ==, cnt);
+
+    /* TRNG run #2 should match run #1 */
+    trng_reset();
+    trng_reseed(NULL);
+    trng_generate(true);
+
+    n = trng_collect(rng, cnt);
+    g_assert_cmpuint(n, ==, cnt);
+
+    if (memcmp(rng, prng, sizeof(rng))) {
+        TRNG_FAILED("Forced-prng test failed: results do not match");
+    }
+}
+
+static void trng_test_fault_events(void)
+{
+    const char *prop = "fips-fault-events";
+
+    trng_reset();
+
+    /* Fault events only when TRSS is enabled */
+    trng_write(R_TRNG_OSC_EN, TRNG_OSC_EN_VAL_MASK);
+    trng_ctrl_set(TRNG_CTRL_TRSSEN_MASK);
+
+    trng_test_set_uint_prop(prop, TRNG_STATUS_CERTF_MASK);
+    trng_check_certf_status();
+
+    trng_test_set_uint_prop(prop, TRNG_STATUS_DTF_MASK);
+    trng_check_dtf_status();
+
+    trng_reset();
+}
+
+int main(int argc, char **argv)
+{
+    int rc;
+
+    g_test_init(&argc, &argv, NULL);
+
+    #define TRNG_TEST_ADD(n) \
+            qtest_add_func("/hw/misc/xlnx-versal-trng/" #n, trng_test_ ## n);
+    TRNG_TEST_ADD(autogen);
+    TRNG_TEST_ADD(oneshot);
+    TRNG_TEST_ADD(per_str);
+    TRNG_TEST_ADD(forced_prng);
+    TRNG_TEST_ADD(fault_events);
+    #undef TRNG_TEST_ADD
+
+    trng_test_start();
+    rc = g_test_run();
+    trng_test_stop();
+
+    return rc;
+}
-- 
2.25.1


