Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDF97AA954
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 08:51:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qja0A-00023B-Bx; Fri, 22 Sep 2023 02:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qjZzx-00020K-NB; Fri, 22 Sep 2023 02:50:45 -0400
Received: from mail-bn8nam04on2061e.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::61e]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qjZzu-00047H-PG; Fri, 22 Sep 2023 02:50:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SO8nvdFaq/cM3JvI1dKXlLbc/UvsH3AyPX5SKCn7XZxGooFP+Q5PhWCfLM6/WN7m5OJwLH1ZwlX+esfPHUg1jqs2l8ShV1ToacFKnQJcSg5waq2DS+QLWvLl3mkzzAal8NpAXgv/iRleMnaoGDoPsRD1xU9EKAKns4LI52+pfLKdBWzUgvRByx8tL/nF1MTGa8FrWqQrq1rH5ji+JSGM1e8vqTO1Kf/IRKxJeBZiBTSDBI1rEHsosK73mLX/otvDnGdDWTk5MKlQiTJRz+aYSUAl3d3lDu9AlYNnra+j/xugnIHvcdRg1M7CuDZDKsZjJuMhsU+okAeYA7O9XrJ55g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9xEi5hWWY2HEoKdU8D2tPKgridiE+9m4l2BvdSJR3M=;
 b=fOxf4BSbUKda6aUifI3uspbKfNnqd0pII0yNKSO/aPoVWwZtinAFYCbjNSZSR3qZNLxwjMhKFvZUuVJWvKAPO/Si76T6ESNbzJQ2TMTM5IGFhKhnCfrqV7lQ82dHSwkIrDqWbJzCMRpA1YYUYiHclPdpV/H4MVc+uhCjrmjUHcSPKHwafPVjtku6cxCFx9M3JUbgs9/ezciZuAKr01JkLCdTBdMAw6pvOMxiiyD3mgTVP+C7qEQURDf3vOrRbD46JVeuC2ckR6ieQTVeSKLlOWhAjgWArAczD9dM5+cyR1EFwZUmgLxWoxytxzBmQ0LNECKSfjrmQ7DN2dL6uLc2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9xEi5hWWY2HEoKdU8D2tPKgridiE+9m4l2BvdSJR3M=;
 b=J+kGfvr00XJwoNHbhuHS1PIcixZ1tyEfnUau7KMhe8irb1qW8/O7VMWNOq7I7yxEtaCWUNGhwThggx0EOVdcjZDVZHYWiUtLoJe5Lu6HdPmaMqJ4yOfAAREAA3N8r8IKQZwvGPknuesxeyYgX8Tif89781J9P5P9kuQ4gCA0jYM=
Received: from BL1PR13CA0325.namprd13.prod.outlook.com (2603:10b6:208:2c1::30)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 06:50:35 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::4a) by BL1PR13CA0325.outlook.office365.com
 (2603:10b6:208:2c1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.12 via Frontend
 Transport; Fri, 22 Sep 2023 06:50:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 06:50:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 01:50:25 -0500
Received: from xsjtongh40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 22 Sep 2023 01:50:25 -0500
From: Tong Ho <tong.ho@amd.com>
To: <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <tong.ho@amd.com>
Subject: [PATCH v2 3/3] tests/qtest: Introduce tests for AMD/Xilinx Versal
 TRNG device
Date: Thu, 21 Sep 2023 23:50:10 -0700
Message-ID: <20230922065010.4071693-4-tong.ho@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230922065010.4071693-1-tong.ho@amd.com>
References: <20230922065010.4071693-1-tong.ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: d293ea72-317e-4f48-2b0c-08dbbb3838cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ENdcMxzH/fKZ80wt+v1XV8SEcENWAHu9PTas2wYw2EZ5NsPYlk/xY3jLm8lfbemQJ2zHP9tGhTIQ64KRhGqsDrFAiUGYb1D1xqW5nT8qgIkgRNxya6pU9+WcfxIkwzWTqHefb7VPCXmG6jHS50GhzsUnedf0xPGoWZD4bkYwiT6DtvesHazVCCU5o84NIyfFDMWPIgmDbOY0OFE1sDqAHoCek34WEY++l8a38M/3elU/N+IadkEMcYmJr3prl+cIRl8lrQMvx/S2h7PfWxpD/Xfh8VjRCCI1KhdCC04+EG2deOmgSbbUKn2HAHwQvOMsxHS18DEI4eWQE1+J2Gl4x1jXUlK79r4l5KIi0sWYzb+Xci0j0SWAIvlIAKM1G73UA8koPBBWq9GZKhn+E1QZExFQcBVALRT9mLxzB1cWJtHgBZGmwTZNvN/yWxONOGZ5BOAND2EE7m5YKuVDKsQ4QS2nNLbPEmkk7BGsYIihrCxNeOKt0IN+LsfV12BYAfY+ltnRE+6aG4cCmcXZUO1/OnJx9rt4dAGxwtqZPwfpouhdnaqnEohj4SpmGx9Rx8cFI1WpHp4n79bcwV4IvW4SMVNqn9IgHhnDipvWyL1BpBvdIzP9wBwhOYQpertJACWu/YZN6j4BRyDbZ1JgFSPj3U4oZAxD/VLldVNkvvIGTYYA3cx7ZSO47SG7aExua2kmXjZT8m7cYbP1PAltpH5scqUpE1KxhI7YjbuD+4JnDw2aCnAEu0GY7TWNHZa7pUhc6buS8kYeiXx2Af92P2APzWAscxU564PWw/MUtEpkpwvsC7AnJVur2BRMQWisCaa4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(82310400011)(1800799009)(186009)(230921699003)(451199024)(40470700004)(46966006)(36840700001)(6666004)(478600001)(2616005)(83380400001)(26005)(1076003)(426003)(30864003)(336012)(47076005)(2906002)(44832011)(70586007)(70206006)(6916009)(54906003)(316002)(4326008)(8676002)(8936002)(5660300002)(41300700001)(40460700003)(36860700001)(86362001)(36756003)(40480700001)(356005)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 06:50:34.8277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d293ea72-317e-4f48-2b0c-08dbbb3838cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
Received-SPF: softfail client-ip=2a01:111:f400:7e8d::61e;
 envelope-from=tong.ho@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 tests/qtest/xlnx-versal-trng-test.c | 490 ++++++++++++++++++++++++++++
 2 files changed, 491 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/xlnx-versal-trng-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 1fba07f4ed..215d20e8cf 100644
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
index 0000000000..6aff00c7fc
--- /dev/null
+++ b/tests/qtest/xlnx-versal-trng-test.c
@@ -0,0 +1,490 @@
+/*
+ * QTests for the Xilinx Versal True Random Number Generator device
+ *
+ * Copyright (c) 2023 Advanced Micro Devices, Inc.
+ *
+ * SPDX-License-Identifier: MIT
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
+#define FAILED(FMT, ...) g_error("%s(): " FMT, __func__, ## __VA_ARGS__)
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
+static void trng_wait(uint32_t wait_mask, bool on, const char *act)
+{
+    time_t tmo = time(NULL) + 2; /* at most 2 seconds */
+    uint32_t event_mask = 0;
+    uint32_t clear_mask = 0;
+
+    /*
+     * Only selected bits are events in R_TRNG_STATUS, and
+     * clear them needs to go through R_INT_CTRL.
+     */
+    if (wait_mask & TRNG_STATUS_CERTF_MASK) {
+        event_mask |= TRNG_STATUS_CERTF_MASK;
+        clear_mask |= TRNG_INT_CTRL_CERTF_RST_MASK;
+    }
+    if (wait_mask & TRNG_STATUS_DTF_MASK) {
+        event_mask |= TRNG_STATUS_DTF_MASK;
+        clear_mask |= TRNG_INT_CTRL_DTF_RST_MASK;
+    }
+    if (wait_mask & TRNG_STATUS_DONE_MASK) {
+        event_mask |= TRNG_STATUS_DONE_MASK;
+        clear_mask |= TRNG_INT_CTRL_DONE_RST_MASK;
+    }
+
+    for (;;) {
+        bool sta = !!(trng_status() & event_mask);
+
+        if ((on ^ sta) == 0) {
+            break;
+        }
+
+        if (time(NULL) >= tmo) {
+            FAILED("%s: Timed out waiting for event 0x%x to be %d%s",
+                   act, event_mask, (int)on, trng_info());
+        }
+
+        g_usleep(10000);
+    }
+
+    /* Remove event */
+    trng_bit_set(R_TRNG_INT_CTRL, clear_mask);
+
+    if (!!(trng_read(R_TRNG_STATUS) & event_mask)) {
+        FAILED("%s: Event 0x%0x stuck at 1 after clear: %s",
+               act, event_mask, trng_info());
+    }
+}
+
+static void trng_wait_done(const char *act)
+{
+    trng_wait(TRNG_STATUS_DONE_MASK, true, act);
+}
+
+static void trng_wait_dtf(void)
+{
+    trng_wait(TRNG_STATUS_DTF_MASK, true, "DTF injection");
+}
+
+static void trng_wait_certf(void)
+{
+    trng_wait(TRNG_STATUS_CERTF_MASK, true, "CERTF injection");
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
+    trng_wait_done(act);
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
+    trng_wait_done("Generate");
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
+        FAILED("PRNG_1 Auto-gen test failed: expected = %u, got = %u",
+               (unsigned)cnt, (unsigned)n);
+    }
+
+    /* TRNG, should not match PRNG */
+    trng_reseed(NULL);
+    trng_generate(true);
+
+    n = trng_collect(rng, cnt);
+    if (n != cnt) {
+        FAILED("TRNG Auto-gen test failed: expected = %u, got = %u",
+               (unsigned)cnt, (unsigned)n);
+    }
+
+    if (!memcmp(rng, prng, sizeof(rng))) {
+        FAILED("TRNG test failed: matching PRNG");
+    }
+
+    /* PRNG #2: should matches run #1 */
+    trng_reseed(prng_seed);
+    trng_generate(true);
+
+    n = trng_collect(rng, cnt);
+    if (n != cnt) {
+        FAILED("PRNG_2 Auto-gen test failed: expected = %u, got = %u",
+               (unsigned)cnt, (unsigned)n);
+    }
+
+    if (memcmp(rng, prng, sizeof(rng))) {
+        FAILED("PRNG_2 Auto-gen test failed: does not match PRNG_1");
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
+        FAILED("PRNG_1 One-shot gen test failed");
+    }
+
+    /* TRNG, should not match PRNG */
+    trng_reseed(NULL);
+    trng_generate(false);
+
+    n = trng_collect(rng, cnt);
+    if (n == cnt) {
+        FAILED("TRNG One-shot test failed");
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
+        FAILED("Failed: PER_DISABLE != PER_STRNG_ALL_ZERO");
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
+        FAILED("Failed: PER_DISABLE == PER_STRNG_NON_ZERO");
+    }
+}
+
+static void trng_test_forced_prng(void)
+{
+    const char *prop = "forced-prng";
+    const uint64_t seed = 0xdeadbeefbad1bad0ULL;
+
+    trng_reset();
+    const size_t cnt = 512 / 32;
+    uint32_t rng[cnt], prng[cnt];
+    size_t n;
+
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
+        FAILED("Forced-prng test failed: results do not match");
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
+    trng_wait_certf();
+
+    trng_test_set_uint_prop(prop, TRNG_STATUS_DTF_MASK);
+    trng_wait_dtf();
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


