Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A567D1FCF
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 23:23:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quJQz-0007uH-DN; Sat, 21 Oct 2023 17:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quJQx-0007tw-SC; Sat, 21 Oct 2023 17:22:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quJQt-0006Ox-Ep; Sat, 21 Oct 2023 17:22:59 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39LL9Z5p011115; Sat, 21 Oct 2023 21:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FIGCDFjimx5A8uouhEBrpfGA+cnsH6xlHdekiWbY06Y=;
 b=YnPHlAfRQNP37EOiEtLorz5TaX32f0NFyqPzT7FX+drrB78zdgqz5RKmFP/iz420mkQZ
 ik4oFpOqSaabc1xD7NIlbx7k1hFA+u7Z16tKnGz1cr8mZ3jO558o+hSJOLpW6Om8blAm
 yEvG+SOR88TsvT6v4x+ZbXzK1sOTuLpt+K9h+V+0AF1dQA0O+Oq7J7MeCw9YY4F3D/aW
 YlbnjWPJWjkUqZbSOOb3OETNHMLE8hBTvzSxKCXYgXhBSV8L+xhFZiNbsLpLEKMMlxuc
 jpRgT7ez8ttF/S/k52fbbtlfErxKmHWL9P1rutCP6SSV3AlDG8HzqFlM+KbXiN3ltPBL sA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvpag0644-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 21:17:28 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39LL9n8O011248;
 Sat, 21 Oct 2023 21:17:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvpag063h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 21:17:27 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39LKFuqE032142; Sat, 21 Oct 2023 21:17:27 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tuc35wbys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 21:17:27 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39LLHQfm20251152
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 21 Oct 2023 21:17:26 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F79B58056;
 Sat, 21 Oct 2023 21:17:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24CB258052;
 Sat, 21 Oct 2023 21:17:26 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 21 Oct 2023 21:17:26 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org
Subject: [PATCH v6 08/10] hw/fsi: Added qtest
Date: Sat, 21 Oct 2023 16:17:17 -0500
Message-Id: <20231021211720.3571082-9-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231021211720.3571082-1-ninad@linux.ibm.com>
References: <20231021211720.3571082-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OSC_rtmaAWShgV7N0hL_c3Hez7xUMEG8
X-Proofpoint-GUID: 5eewEXfNTQdDxUMUWw6kfAJtlRxHwBxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-21_13,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=520 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310210195
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Added basic qtests for FSI model.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
v3:
 - Added new qtest as per Cedric's comment.
V4:
 - Remove MAINTAINER and documentation changes from this commit
v6:
 - Incorporated review comments by Thomas Huth.
---
 tests/qtest/fsi-test.c  | 207 ++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build |   1 +
 2 files changed, 208 insertions(+)
 create mode 100644 tests/qtest/fsi-test.c

diff --git a/tests/qtest/fsi-test.c b/tests/qtest/fsi-test.c
new file mode 100644
index 0000000000..01a0739092
--- /dev/null
+++ b/tests/qtest/fsi-test.c
@@ -0,0 +1,207 @@
+/*
+ * QTest testcases for IBM's Flexible Service Interface (FSI)
+ *
+ * Copyright (c) 2023 IBM Corporation
+ *
+ * Authors:
+ *   Ninad Palsule <ninad@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <glib/gstdio.h>
+
+#include "qemu/module.h"
+#include "libqtest-single.h"
+
+/* Registers from ast2600 specifications */
+#define ASPEED_FSI_ENGINER_TRIGGER   0x04
+#define ASPEED_FSI_OPB0_BUS_SELECT   0x10
+#define ASPEED_FSI_OPB1_BUS_SELECT   0x28
+#define ASPEED_FSI_OPB0_RW_DIRECTION 0x14
+#define ASPEED_FSI_OPB1_RW_DIRECTION 0x2c
+#define ASPEED_FSI_OPB0_XFER_SIZE    0x18
+#define ASPEED_FSI_OPB1_XFER_SIZE    0x30
+#define ASPEED_FSI_OPB0_BUS_ADDR     0x1c
+#define ASPEED_FSI_OPB1_BUS_ADDR     0x34
+#define ASPEED_FSI_INTRRUPT_CLEAR    0x40
+#define ASPEED_FSI_INTRRUPT_STATUS   0x48
+#define ASPEED_FSI_OPB0_BUS_STATUS   0x80
+#define ASPEED_FSI_OPB1_BUS_STATUS   0x8c
+#define ASPEED_FSI_OPB0_READ_DATA    0x84
+#define ASPEED_FSI_OPB1_READ_DATA    0x90
+
+/*
+ * FSI Base addresses from the ast2600 specifications.
+ */
+#define AST2600_OPB_FSI0_BASE_ADDR 0x1e79b000
+#define AST2600_OPB_FSI1_BASE_ADDR 0x1e79b100
+
+static uint32_t aspeed_fsi_base_addr;
+
+static uint32_t aspeed_fsi_readl(QTestState *s, uint32_t reg)
+{
+    return qtest_readl(s, aspeed_fsi_base_addr + reg);
+}
+
+static void aspeed_fsi_writel(QTestState *s, uint32_t reg, uint32_t val)
+{
+    qtest_writel(s, aspeed_fsi_base_addr + reg, val);
+}
+
+/* Setup base address and select register */
+static void test_fsi_setup(QTestState *s, uint32_t base_addr)
+{
+    uint32_t curval;
+
+    /* Set the base select register */
+    if (base_addr == AST2600_OPB_FSI0_BASE_ADDR) {
+        aspeed_fsi_base_addr = base_addr;
+
+        /* Unselect FSI1 */
+        aspeed_fsi_writel(s, ASPEED_FSI_OPB1_BUS_SELECT, 0x0);
+        curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_SELECT);
+        g_assert_cmpuint(curval, ==, 0x0);
+
+        /* Select FSI0 */
+        aspeed_fsi_writel(s, ASPEED_FSI_OPB0_BUS_SELECT, 0x1);
+        curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_SELECT);
+        g_assert_cmpuint(curval, ==, 0x1);
+    } else if (base_addr == AST2600_OPB_FSI1_BASE_ADDR) {
+        aspeed_fsi_base_addr = base_addr;
+
+        /* Unselect FSI0 */
+        aspeed_fsi_writel(s, ASPEED_FSI_OPB0_BUS_SELECT, 0x0);
+        curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_SELECT);
+        g_assert_cmpuint(curval, ==, 0x0);
+
+        /* Select FSI1 */
+        aspeed_fsi_writel(s, ASPEED_FSI_OPB1_BUS_SELECT, 0x1);
+        curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_SELECT);
+        g_assert_cmpuint(curval, ==, 0x1);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
+static void test_fsi_reg_change(QTestState *s, uint32_t reg, uint32_t newval)
+{
+    uint32_t base;
+    uint32_t curval;
+
+    base = aspeed_fsi_readl(s, reg);
+    aspeed_fsi_writel(s, reg, newval);
+    curval = aspeed_fsi_readl(s, reg);
+    g_assert_cmpuint(curval, ==, newval);
+    aspeed_fsi_writel(s, reg, base);
+    curval = aspeed_fsi_readl(s, reg);
+    g_assert_cmpuint(curval, ==, base);
+}
+
+static void test_fsi0_master_regs(const void *data)
+{
+    QTestState *s = (QTestState *)data;
+
+    test_fsi_setup(s, AST2600_OPB_FSI0_BASE_ADDR);
+
+    test_fsi_reg_change(s, ASPEED_FSI_OPB0_RW_DIRECTION, 0xF3F4F514);
+    test_fsi_reg_change(s, ASPEED_FSI_OPB0_XFER_SIZE, 0xF3F4F518);
+    test_fsi_reg_change(s, ASPEED_FSI_OPB0_BUS_ADDR, 0xF3F4F51c);
+    test_fsi_reg_change(s, ASPEED_FSI_INTRRUPT_CLEAR, 0xF3F4F540);
+    test_fsi_reg_change(s, ASPEED_FSI_INTRRUPT_STATUS, 0xF3F4F548);
+    test_fsi_reg_change(s, ASPEED_FSI_OPB0_BUS_STATUS, 0xF3F4F580);
+    test_fsi_reg_change(s, ASPEED_FSI_OPB0_READ_DATA, 0xF3F4F584);
+}
+
+static void test_fsi1_master_regs(const void *data)
+{
+    QTestState *s = (QTestState *)data;
+
+    test_fsi_setup(s, AST2600_OPB_FSI1_BASE_ADDR);
+
+    test_fsi_reg_change(s, ASPEED_FSI_OPB1_RW_DIRECTION, 0xF3F4F514);
+    test_fsi_reg_change(s, ASPEED_FSI_OPB1_XFER_SIZE, 0xF3F4F518);
+    test_fsi_reg_change(s, ASPEED_FSI_OPB1_BUS_ADDR, 0xF3F4F51c);
+    test_fsi_reg_change(s, ASPEED_FSI_INTRRUPT_CLEAR, 0xF3F4F540);
+    test_fsi_reg_change(s, ASPEED_FSI_INTRRUPT_STATUS, 0xF3F4F548);
+    test_fsi_reg_change(s, ASPEED_FSI_OPB1_BUS_STATUS, 0xF3F4F580);
+    test_fsi_reg_change(s, ASPEED_FSI_OPB1_READ_DATA, 0xF3F4F584);
+}
+
+static void test_fsi0_getcfam_addr0(const void *data)
+{
+    QTestState *s = (QTestState *)data;
+    uint32_t curval;
+
+    test_fsi_setup(s, AST2600_OPB_FSI0_BASE_ADDR);
+
+    /* Master access direction read */
+    aspeed_fsi_writel(s, ASPEED_FSI_OPB0_RW_DIRECTION, 0x1);
+    /* word */
+    aspeed_fsi_writel(s, ASPEED_FSI_OPB0_XFER_SIZE, 0x3);
+    /* Address */
+    aspeed_fsi_writel(s, ASPEED_FSI_OPB0_BUS_ADDR, 0xa0000000);
+    aspeed_fsi_writel(s, ASPEED_FSI_INTRRUPT_CLEAR, 0x1);
+    aspeed_fsi_writel(s, ASPEED_FSI_ENGINER_TRIGGER, 0x1);
+
+    curval = aspeed_fsi_readl(s, ASPEED_FSI_INTRRUPT_STATUS);
+    g_assert_cmpuint(curval, ==, 0x10000);
+    curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_STATUS);
+    g_assert_cmpuint(curval, ==, 0x0);
+    curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_READ_DATA);
+    g_assert_cmpuint(curval, ==, 0x152d02c0);
+}
+
+static void test_fsi1_getcfam_addr0(const void *data)
+{
+    QTestState *s = (QTestState *)data;
+    uint32_t curval;
+
+    test_fsi_setup(s, AST2600_OPB_FSI1_BASE_ADDR);
+
+    /* Master access direction read */
+    aspeed_fsi_writel(s, ASPEED_FSI_OPB1_RW_DIRECTION, 0x1);
+
+    aspeed_fsi_writel(s, ASPEED_FSI_OPB1_XFER_SIZE, 0x3);
+    aspeed_fsi_writel(s, ASPEED_FSI_OPB1_BUS_ADDR, 0xa0000000);
+    aspeed_fsi_writel(s, ASPEED_FSI_INTRRUPT_CLEAR, 0x1);
+    aspeed_fsi_writel(s, ASPEED_FSI_ENGINER_TRIGGER, 0x1);
+
+    curval = aspeed_fsi_readl(s, ASPEED_FSI_INTRRUPT_STATUS);
+    g_assert_cmpuint(curval, ==, 0x20000);
+    curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_STATUS);
+    g_assert_cmpuint(curval, ==, 0x0);
+    curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_READ_DATA);
+    g_assert_cmpuint(curval, ==, 0x152d02c0);
+}
+
+int main(int argc, char **argv)
+{
+    int ret = -1;
+    QTestState *s;
+
+    g_test_init(&argc, &argv, NULL);
+
+    s = qtest_init("-machine ast2600-evb ");
+
+    /* Tests for OPB/FSI0 */
+    qtest_add_data_func("/fsi-test/test_fsi0_master_regs", s,
+                        test_fsi0_master_regs);
+
+    qtest_add_data_func("/fsi-test/test_fsi0_getcfam_addr0", s,
+                        test_fsi0_getcfam_addr0);
+
+    /* Tests for OPB/FSI1 */
+    qtest_add_data_func("/fsi-test/test_fsi1_master_regs", s,
+                        test_fsi1_master_regs);
+
+    qtest_add_data_func("/fsi-test/test_fsi1_getcfam_addr0", s,
+                        test_fsi1_getcfam_addr0);
+
+    ret = g_test_run();
+    qtest_quit(s);
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index d6022ebd64..74228a4aed 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -207,6 +207,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['fsi-test'] : []) + \
   ['arm-cpu-features',
    'boot-serial-test']
 
-- 
2.39.2


