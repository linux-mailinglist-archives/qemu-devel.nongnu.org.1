Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3C9990A6D
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Oct 2024 19:52:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swmS8-0008B0-Dv; Fri, 04 Oct 2024 13:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1swmS3-00088M-T9; Fri, 04 Oct 2024 13:50:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1swmS0-0005p2-7F; Fri, 04 Oct 2024 13:50:51 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494Hj6Tb027517;
 Fri, 4 Oct 2024 17:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=Bvb0IyckUlFW8moT10ItLOI/vy
 3G0V3fUrhN3PwfT7U=; b=Fx0OLop9JQPm50psMlXbma3AZ8MVjjVXBO9FrQE41W
 c7E3m06eXQOdnd1G7D6PqV82lhthvyMESrs/ZsJluPMcZJ9DHuQLaUCtSDvoNreE
 4xs6FMjEai5mmRoLNYmOwwgIzCQo2dlEmFpvv5yS7z8E/Oss9HlFqtyVArUm9P9o
 WK7SmtZO+45V0erXvcZVYZq2Xs9658X2AywXeWAhzVI5XKJpnfEqDGwPHMM22+kE
 WPnMOXMrOclmO2XdYDf9IHWPwtFBVsmZSgyRDyy//s4yZ7IF2EVOu+stgCihZ1LF
 Ti3q2IdDsDPiOTM6ukJU6tYNv0rUev5FnyNxOOAhAb7A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 422n1h818h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Oct 2024 17:50:35 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 494HoYDx007932;
 Fri, 4 Oct 2024 17:50:34 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 422n1h818b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Oct 2024 17:50:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 494HXs8x002700;
 Fri, 4 Oct 2024 17:50:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42207jnbbq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Oct 2024 17:50:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 494HoUah34144768
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Oct 2024 17:50:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A37F20043;
 Fri,  4 Oct 2024 17:50:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A62620040;
 Fri,  4 Oct 2024 17:50:28 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  4 Oct 2024 17:50:28 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v3] tests/qtest: Add XIVE tests for the powernv10 machine
Date: Fri,  4 Oct 2024 12:50:22 -0500
Message-Id: <20241004175022.21134-1-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2C7QuXuW1Y_UK1HDDFvNGAnginJ-EiII
X-Proofpoint-ORIG-GUID: DYO5HfB5obLT6JXLzqIvxrDDhIh9_2I8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_15,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

These XIVE tests include:
- General interrupt IRQ tests that:
  - enable and trigger an interrupt
  - acknowledge the interrupt
  - end of interrupt processing
- Test the Pull Thread Context to Odd Thread Reporting Line
- Test the different cache flush inject and queue sync inject operations

Co-authored-by: Frederic Barrat <fbarrat@linux.ibm.com>
Co-authored-by: Glenn Miles <milesg@linux.ibm.com>
Co-authored-by: Michael Kowal <kowal@linux.ibm.com>

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 MAINTAINERS                        |   1 +
 tests/qtest/pnv-xive2-common.h     | 111 ++++++++++
 tests/qtest/pnv-xive2-common.c     | 190 ++++++++++++++++
 tests/qtest/pnv-xive2-flush-sync.c | 205 +++++++++++++++++
 tests/qtest/pnv-xive2-test.c       | 344 +++++++++++++++++++++++++++++
 tests/qtest/meson.build            |   2 +
 6 files changed, 853 insertions(+)
 create mode 100644 tests/qtest/pnv-xive2-common.h
 create mode 100644 tests/qtest/pnv-xive2-common.c
 create mode 100644 tests/qtest/pnv-xive2-flush-sync.c
 create mode 100644 tests/qtest/pnv-xive2-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ffacd60f40..384777611d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2660,6 +2660,7 @@ L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/*/*xive*
 F: include/hw/*/*xive*
+F: tests/qtest/*xive*
 F: docs/*/*xive*
 
 Renesas peripherals
diff --git a/tests/qtest/pnv-xive2-common.h b/tests/qtest/pnv-xive2-common.h
new file mode 100644
index 0000000000..215856edcc
--- /dev/null
+++ b/tests/qtest/pnv-xive2-common.h
@@ -0,0 +1,111 @@
+/*
+ * QTest testcase for PowerNV 10 interrupt controller (xive2)
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ * 
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef TEST_PNV_XIVE2_COMMON_H
+#define TEST_PNV_XIVE2_COMMON_H
+
+#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
+#define PPC_BIT32(bit)          (0x80000000 >> (bit))
+#define PPC_BIT8(bit)           (0x80 >> (bit))
+#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
+#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
+                                 PPC_BIT32(bs))
+#include "qemu/bswap.h"
+#include "hw/intc/pnv_xive2_regs.h"
+#include "hw/ppc/xive_regs.h"
+#include "hw/ppc/xive2_regs.h"
+
+/*
+ * sizing:
+ * 128 interrupts
+ *   => ESB BAR range: 16M
+ * 256 ENDs
+ *   => END BAR range: 16M
+ * 256 VPs
+ *   => NVPG,NVC BAR range: 32M
+ */
+#define MAX_IRQS                128
+#define MAX_ENDS                256
+#define MAX_VPS                 256
+
+#define XIVE_PAGE_SHIFT         16
+
+#define XIVE_TRIGGER_PAGE       0
+#define XIVE_EOI_PAGE           1
+
+#define XIVE_IC_ADDR            0x0006030200000000ull
+#define XIVE_IC_TM_INDIRECT     (XIVE_IC_ADDR + (256 << XIVE_PAGE_SHIFT))
+#define XIVE_IC_BAR             ((0x3ull << 62) | XIVE_IC_ADDR)
+#define XIVE_TM_BAR             0xc006030203180000ull
+#define XIVE_ESB_ADDR           0x0006050000000000ull
+#define XIVE_ESB_BAR            ((0x3ull << 62) | XIVE_ESB_ADDR)
+#define XIVE_END_BAR            0xc006060000000000ull
+#define XIVE_NVPG_ADDR          0x0006040000000000ull
+#define XIVE_NVPG_BAR           ((0x3ull << 62) | XIVE_NVPG_ADDR)
+#define XIVE_NVC_ADDR           0x0006030208000000ull
+#define XIVE_NVC_BAR            ((0x3ull << 62) | XIVE_NVC_ADDR)
+
+/*
+ * Memory layout
+ * A check is done when a table is configured to ensure that the max
+ * size of the resource fits in the table.
+ */
+#define XIVE_VST_SIZE           0x10000ull /* must be at least 4k */
+
+#define XIVE_MEM_START          0x10000000ull
+#define XIVE_ESB_MEM            XIVE_MEM_START
+#define XIVE_EAS_MEM            (XIVE_ESB_MEM + XIVE_VST_SIZE)
+#define XIVE_END_MEM            (XIVE_EAS_MEM + XIVE_VST_SIZE)
+#define XIVE_NVP_MEM            (XIVE_END_MEM + XIVE_VST_SIZE)
+#define XIVE_NVG_MEM            (XIVE_NVP_MEM + XIVE_VST_SIZE)
+#define XIVE_NVC_MEM            (XIVE_NVG_MEM + XIVE_VST_SIZE)
+#define XIVE_SYNC_MEM           (XIVE_NVC_MEM + XIVE_VST_SIZE)
+#define XIVE_QUEUE_MEM          (XIVE_SYNC_MEM + XIVE_VST_SIZE)
+#define XIVE_QUEUE_SIZE         4096 /* per End */
+#define XIVE_REPORT_MEM         (XIVE_QUEUE_MEM + XIVE_QUEUE_SIZE * MAX_VPS)
+#define XIVE_REPORT_SIZE        256 /* two cache lines per NVP */
+#define XIVE_MEM_END            (XIVE_REPORT_MEM + XIVE_REPORT_SIZE * MAX_VPS)
+
+#define P10_XSCOM_BASE          0x000603fc00000000ull
+#define XIVE_XSCOM              0x2010800ull
+
+#define XIVE_ESB_RESET          0b00
+#define XIVE_ESB_OFF            0b01
+#define XIVE_ESB_PENDING        0b10
+#define XIVE_ESB_QUEUED         0b11
+
+#define XIVE_ESB_GET            0x800
+#define XIVE_ESB_SET_PQ_00      0xc00 /* Load */
+#define XIVE_ESB_SET_PQ_01      0xd00 /* Load */
+#define XIVE_ESB_SET_PQ_10      0xe00 /* Load */
+#define XIVE_ESB_SET_PQ_11      0xf00 /* Load */
+
+#define XIVE_ESB_STORE_EOI      0x400 /* Store */
+
+
+extern uint64_t pnv_xive_xscom_read(QTestState *qts, uint32_t reg);
+extern void pnv_xive_xscom_write(QTestState *qts, uint32_t reg, uint64_t val);
+extern uint64_t xive_get_queue_addr(uint32_t end_index);
+extern uint8_t get_esb(QTestState *qts, uint32_t index, uint8_t page,
+                       uint32_t offset);
+extern void set_esb(QTestState *qts, uint32_t index, uint8_t page,
+                    uint32_t offset, uint32_t val);
+extern void get_nvp(QTestState *qts, uint32_t index, Xive2Nvp* nvp);
+extern void set_nvp(QTestState *qts, uint32_t index, uint8_t first);
+extern void get_cl_pair(QTestState *qts, Xive2Nvp *nvp, uint8_t *cl_pair);
+extern void set_cl_pair(QTestState *qts, Xive2Nvp *nvp, uint8_t *cl_pair);
+extern void set_nvg(QTestState *qts, uint32_t index, uint8_t next);
+extern void set_eas(QTestState *qts, uint32_t index, uint32_t end_index,
+                    uint32_t data);
+extern void set_end(QTestState *qts, uint32_t index, uint32_t nvp_index,
+                    uint8_t priority, bool i);
+
+
+void test_flush_sync_inject(QTestState *qts);
+
+#endif /* TEST_PNV_XIVE2_COMMON_H */
diff --git a/tests/qtest/pnv-xive2-common.c b/tests/qtest/pnv-xive2-common.c
new file mode 100644
index 0000000000..bf2bce0056
--- /dev/null
+++ b/tests/qtest/pnv-xive2-common.c
@@ -0,0 +1,190 @@
+/*
+ * QTest testcase for PowerNV 10 interrupt controller (xive2)
+ *  - Common functions for XIVE2 tests
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#include "pnv-xive2-common.h"
+
+
+static uint64_t pnv_xscom_addr(uint32_t pcba)
+{
+    return P10_XSCOM_BASE | ((uint64_t) pcba << 3);
+}
+
+static uint64_t pnv_xive_xscom_addr(uint32_t reg)
+{
+    return pnv_xscom_addr(XIVE_XSCOM + reg);
+}
+
+uint64_t pnv_xive_xscom_read(QTestState *qts, uint32_t reg)
+{
+    return qtest_readq(qts, pnv_xive_xscom_addr(reg));
+}
+
+void pnv_xive_xscom_write(QTestState *qts, uint32_t reg, uint64_t val)
+{
+    qtest_writeq(qts, pnv_xive_xscom_addr(reg), val);
+}
+
+static void xive_get_struct(QTestState *qts, uint64_t src, void *dest,
+                            size_t size)
+{
+    uint8_t *destination = (uint8_t *)dest;
+    size_t i;
+
+    for (i = 0; i < size; i++) {
+        *(destination + i) = qtest_readb(qts, src + i);
+    }
+}
+
+static void xive_copy_struct(QTestState *qts, void *src, uint64_t dest,
+                             size_t size)
+{
+    uint8_t *source = (uint8_t *)src;
+    size_t i;
+
+    for (i = 0; i < size; i++) {
+        qtest_writeb(qts, dest + i, *(source + i));
+    }
+}
+
+uint64_t xive_get_queue_addr(uint32_t end_index)
+{
+    return XIVE_QUEUE_MEM + (uint64_t)end_index * XIVE_QUEUE_SIZE;
+}
+
+uint8_t get_esb(QTestState *qts, uint32_t index, uint8_t page,
+                uint32_t offset)
+{
+    uint64_t addr;
+
+    addr = XIVE_ESB_ADDR + ((uint64_t)index << (XIVE_PAGE_SHIFT + 1));
+    if (page == 1) {
+        addr += 1 << XIVE_PAGE_SHIFT;
+    }
+    return qtest_readb(qts, addr + offset);
+}
+
+void set_esb(QTestState *qts, uint32_t index, uint8_t page,
+             uint32_t offset, uint32_t val)
+{
+    uint64_t addr;
+
+    addr = XIVE_ESB_ADDR + ((uint64_t)index << (XIVE_PAGE_SHIFT + 1));
+    if (page == 1) {
+        addr += 1 << XIVE_PAGE_SHIFT;
+    }
+    return qtest_writel(qts, addr + offset, cpu_to_be32(val));
+}
+
+void get_nvp(QTestState *qts, uint32_t index, Xive2Nvp* nvp)
+{
+    uint64_t addr = XIVE_NVP_MEM + (uint64_t)index * sizeof(Xive2Nvp);
+    xive_get_struct(qts, addr, nvp, sizeof(Xive2Nvp));
+}
+
+void set_nvp(QTestState *qts, uint32_t index, uint8_t first)
+{
+    uint64_t nvp_addr;
+    Xive2Nvp nvp;
+    uint64_t report_addr;
+
+    nvp_addr = XIVE_NVP_MEM + (uint64_t)index * sizeof(Xive2Nvp);
+    report_addr = (XIVE_REPORT_MEM + (uint64_t)index * XIVE_REPORT_SIZE) >> 8;
+
+    memset(&nvp, 0, sizeof(nvp));
+    nvp.w0 = xive_set_field32(NVP2_W0_VALID, 0, 1);
+    nvp.w0 = xive_set_field32(NVP2_W0_PGOFIRST, nvp.w0, first);
+    nvp.w6 = xive_set_field32(NVP2_W6_REPORTING_LINE, nvp.w6,
+                              (report_addr >> 24) & 0xfffffff);
+    nvp.w7 = xive_set_field32(NVP2_W7_REPORTING_LINE, nvp.w7,
+                              report_addr & 0xffffff);
+    xive_copy_struct(qts, &nvp, nvp_addr, sizeof(nvp));
+}
+
+static uint64_t get_cl_pair_addr(Xive2Nvp *nvp)
+{
+    uint64_t upper = xive_get_field32(0x0fffffff, nvp->w6);
+    uint64_t lower = xive_get_field32(0xffffff00, nvp->w7);
+    return (upper << 32) | (lower << 8);
+}
+
+void get_cl_pair(QTestState *qts, Xive2Nvp *nvp, uint8_t *cl_pair)
+{
+    uint64_t addr = get_cl_pair_addr(nvp);
+    xive_get_struct(qts, addr, cl_pair, XIVE_REPORT_SIZE);
+}
+
+void set_cl_pair(QTestState *qts, Xive2Nvp *nvp, uint8_t *cl_pair)
+{
+    uint64_t addr = get_cl_pair_addr(nvp);
+    xive_copy_struct(qts, cl_pair, addr, XIVE_REPORT_SIZE);
+}
+
+void set_nvg(QTestState *qts, uint32_t index, uint8_t next)
+{
+    uint64_t nvg_addr;
+    Xive2Nvgc nvg;
+
+    nvg_addr = XIVE_NVG_MEM + (uint64_t)index * sizeof(Xive2Nvgc);
+
+    memset(&nvg, 0, sizeof(nvg));
+    nvg.w0 = xive_set_field32(NVGC2_W0_VALID, 0, 1);
+    nvg.w0 = xive_set_field32(NVGC2_W0_PGONEXT, nvg.w0, next);
+    xive_copy_struct(qts, &nvg, nvg_addr, sizeof(nvg));
+}
+
+void set_eas(QTestState *qts, uint32_t index, uint32_t end_index,
+             uint32_t data)
+{
+    uint64_t eas_addr;
+    Xive2Eas eas;
+
+    eas_addr = XIVE_EAS_MEM + (uint64_t)index * sizeof(Xive2Eas);
+
+    memset(&eas, 0, sizeof(eas));
+    eas.w = xive_set_field64(EAS2_VALID, 0, 1);
+    eas.w = xive_set_field64(EAS2_END_INDEX, eas.w, end_index);
+    eas.w = xive_set_field64(EAS2_END_DATA, eas.w, data);
+    xive_copy_struct(qts, &eas, eas_addr, sizeof(eas));
+}
+
+void set_end(QTestState *qts, uint32_t index, uint32_t nvp_index,
+             uint8_t priority, bool i)
+{
+    uint64_t end_addr, queue_addr, queue_hi, queue_lo;
+    uint8_t queue_size;
+    Xive2End end;
+
+    end_addr = XIVE_END_MEM + (uint64_t)index * sizeof(Xive2End);
+    queue_addr = xive_get_queue_addr(index);
+    queue_hi = (queue_addr >> 32) & END2_W2_EQ_ADDR_HI;
+    queue_lo = queue_addr & END2_W3_EQ_ADDR_LO;
+    queue_size = ctz16(XIVE_QUEUE_SIZE) - 12;
+
+    memset(&end, 0, sizeof(end));
+    end.w0 = xive_set_field32(END2_W0_VALID, 0, 1);
+    end.w0 = xive_set_field32(END2_W0_ENQUEUE, end.w0, 1);
+    end.w0 = xive_set_field32(END2_W0_UCOND_NOTIFY, end.w0, 1);
+    end.w0 = xive_set_field32(END2_W0_BACKLOG, end.w0, 1);
+
+    end.w1 = xive_set_field32(END2_W1_GENERATION, 0, 1);
+
+    end.w2 = cpu_to_be32(queue_hi);
+
+    end.w3 = cpu_to_be32(queue_lo);
+    end.w3 = xive_set_field32(END2_W3_QSIZE, end.w3, queue_size);
+
+    end.w6 = xive_set_field32(END2_W6_IGNORE, 0, i);
+    end.w6 = xive_set_field32(END2_W6_VP_OFFSET, end.w6, nvp_index);
+
+    end.w7 = xive_set_field32(END2_W7_F0_PRIORITY, 0, priority);
+    xive_copy_struct(qts, &end, end_addr, sizeof(end));
+}
+
diff --git a/tests/qtest/pnv-xive2-flush-sync.c b/tests/qtest/pnv-xive2-flush-sync.c
new file mode 100644
index 0000000000..3b32446adb
--- /dev/null
+++ b/tests/qtest/pnv-xive2-flush-sync.c
@@ -0,0 +1,205 @@
+/*
+ * QTest testcase for PowerNV 10 interrupt controller (xive2)
+ *  - Test cache flush/queue sync injection
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#include "pnv-xive2-common.h"
+#include "hw/intc/pnv_xive2_regs.h"
+#include "hw/ppc/xive_regs.h"
+#include "hw/ppc/xive2_regs.h"
+
+#define PNV_XIVE2_QUEUE_IPI              0x00
+#define PNV_XIVE2_QUEUE_HW               0x01
+#define PNV_XIVE2_QUEUE_NXC              0x02
+#define PNV_XIVE2_QUEUE_INT              0x03
+#define PNV_XIVE2_QUEUE_OS               0x04
+#define PNV_XIVE2_QUEUE_POOL             0x05
+#define PNV_XIVE2_QUEUE_HARD             0x06
+#define PNV_XIVE2_CACHE_ENDC             0x08
+#define PNV_XIVE2_CACHE_ESBC             0x09
+#define PNV_XIVE2_CACHE_EASC             0x0a
+#define PNV_XIVE2_QUEUE_NXC_LD_LCL_NCO   0x10
+#define PNV_XIVE2_QUEUE_NXC_LD_LCL_CO    0x11
+#define PNV_XIVE2_QUEUE_NXC_ST_LCL_NCI   0x12
+#define PNV_XIVE2_QUEUE_NXC_ST_LCL_CI    0x13
+#define PNV_XIVE2_QUEUE_NXC_ST_RMT_NCI   0x14
+#define PNV_XIVE2_QUEUE_NXC_ST_RMT_CI    0x15
+#define PNV_XIVE2_CACHE_NXC              0x18
+
+#define PNV_XIVE2_SYNC_IPI              0x000
+#define PNV_XIVE2_SYNC_HW               0x080
+#define PNV_XIVE2_SYNC_NxC              0x100
+#define PNV_XIVE2_SYNC_INT              0x180
+#define PNV_XIVE2_SYNC_OS_ESC           0x200
+#define PNV_XIVE2_SYNC_POOL_ESC         0x280
+#define PNV_XIVE2_SYNC_HARD_ESC         0x300
+#define PNV_XIVE2_SYNC_NXC_LD_LCL_NCO   0x800
+#define PNV_XIVE2_SYNC_NXC_LD_LCL_CO    0x880
+#define PNV_XIVE2_SYNC_NXC_ST_LCL_NCI   0x900
+#define PNV_XIVE2_SYNC_NXC_ST_LCL_CI    0x980
+#define PNV_XIVE2_SYNC_NXC_ST_RMT_NCI   0xA00
+#define PNV_XIVE2_SYNC_NXC_ST_RMT_CI    0xA80
+
+
+static uint64_t get_sync_addr(uint32_t src_pir, int ic_topo_id, int type)
+{
+    int thread_nr = src_pir & 0x7f;
+    uint64_t addr = XIVE_SYNC_MEM +  thread_nr * 512 + ic_topo_id * 32 + type;
+    return addr;
+}
+
+static uint8_t get_sync(QTestState *qts, uint32_t src_pir, int ic_topo_id,
+                        int type)
+{
+    uint64_t addr = get_sync_addr(src_pir, ic_topo_id, type);
+    return qtest_readb(qts, addr);
+}
+
+static void clr_sync(QTestState *qts, uint32_t src_pir, int ic_topo_id,
+                        int type)
+{
+    uint64_t addr = get_sync_addr(src_pir, ic_topo_id, type);
+    qtest_writeb(qts, addr, 0x0);
+}
+
+static void inject_cache_flush(QTestState *qts, int ic_topo_id,
+                               uint64_t scom_addr)
+{
+    (void)ic_topo_id;
+    pnv_xive_xscom_write(qts, scom_addr, 0);
+}
+
+static void inject_queue_sync(QTestState *qts, int ic_topo_id, uint64_t offset)
+{
+    (void)ic_topo_id;
+    uint64_t addr = XIVE_IC_ADDR + (VST_SYNC << XIVE_PAGE_SHIFT) + offset;
+    qtest_writeq(qts, addr, 0);
+}
+
+static void inject_op(QTestState *qts, int ic_topo_id, int type)
+{
+    switch (type) {
+    case PNV_XIVE2_QUEUE_IPI:
+        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_IPI);
+        break;
+    case PNV_XIVE2_QUEUE_HW:
+        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_HW);
+        break;
+    case PNV_XIVE2_QUEUE_NXC:
+        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_NxC);
+        break;
+    case PNV_XIVE2_QUEUE_INT:
+        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_INT);
+        break;
+    case PNV_XIVE2_QUEUE_OS:
+        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_OS_ESC);
+        break;
+    case PNV_XIVE2_QUEUE_POOL:
+        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_POOL_ESC);
+        break;
+    case PNV_XIVE2_QUEUE_HARD:
+        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_HARD_ESC);
+        break;
+    case PNV_XIVE2_CACHE_ENDC:
+        inject_cache_flush(qts, ic_topo_id, X_VC_ENDC_FLUSH_INJECT);
+        break;
+    case PNV_XIVE2_CACHE_ESBC:
+        inject_cache_flush(qts, ic_topo_id, X_VC_ESBC_FLUSH_INJECT);
+        break;
+    case PNV_XIVE2_CACHE_EASC:
+        inject_cache_flush(qts, ic_topo_id, X_VC_EASC_FLUSH_INJECT);
+        break;
+    case PNV_XIVE2_QUEUE_NXC_LD_LCL_NCO:
+        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_NXC_LD_LCL_NCO);
+        break;
+    case PNV_XIVE2_QUEUE_NXC_LD_LCL_CO:
+        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_NXC_LD_LCL_CO);
+        break;
+    case PNV_XIVE2_QUEUE_NXC_ST_LCL_NCI:
+        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_NXC_ST_LCL_NCI);
+        break;
+    case PNV_XIVE2_QUEUE_NXC_ST_LCL_CI:
+        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_NXC_ST_LCL_CI);
+        break;
+    case PNV_XIVE2_QUEUE_NXC_ST_RMT_NCI:
+        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_NXC_ST_RMT_NCI);
+        break;
+    case PNV_XIVE2_QUEUE_NXC_ST_RMT_CI:
+        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_NXC_ST_RMT_CI);
+        break;
+    case PNV_XIVE2_CACHE_NXC:
+        inject_cache_flush(qts, ic_topo_id, X_PC_NXC_FLUSH_INJECT);
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+}
+
+const uint8_t xive_inject_tests[] = {
+    PNV_XIVE2_QUEUE_IPI,
+    PNV_XIVE2_QUEUE_HW,
+    PNV_XIVE2_QUEUE_NXC,
+    PNV_XIVE2_QUEUE_INT,
+    PNV_XIVE2_QUEUE_OS,
+    PNV_XIVE2_QUEUE_POOL,
+    PNV_XIVE2_QUEUE_HARD,
+    PNV_XIVE2_CACHE_ENDC,
+    PNV_XIVE2_CACHE_ESBC,
+    PNV_XIVE2_CACHE_EASC,
+    PNV_XIVE2_QUEUE_NXC_LD_LCL_NCO,
+    PNV_XIVE2_QUEUE_NXC_LD_LCL_CO,
+    PNV_XIVE2_QUEUE_NXC_ST_LCL_NCI,
+    PNV_XIVE2_QUEUE_NXC_ST_LCL_CI,
+    PNV_XIVE2_QUEUE_NXC_ST_RMT_NCI,
+    PNV_XIVE2_QUEUE_NXC_ST_RMT_CI,
+    PNV_XIVE2_CACHE_NXC,
+};
+
+void test_flush_sync_inject(QTestState *qts)
+{
+    int ic_topo_id = 0;
+
+    /*
+     * Writes performed by qtest are not done in the context of a thread.
+     * This means that QEMU XIVE code doesn't have a way to determine what
+     * thread is originating the write.  In order to allow for some testing,
+     * QEMU XIVE code will assume a PIR of 0 when unable to determine the
+     * source thread for cache flush and queue sync inject operations.
+     * See hw/intc/pnv_xive2.c: pnv_xive2_inject_notify() for details.
+     */
+    int src_pir = 0;
+    int test_nr;
+    uint8_t byte;
+
+    printf("# ============================================================\n");
+    printf("# Starting cache flush/queue sync injection tests...\n");
+
+    for (test_nr = 0; test_nr < sizeof(xive_inject_tests);
+         test_nr++) {
+        int op_type = xive_inject_tests[test_nr];
+
+        printf("# Running test %d\n", test_nr);
+
+        /* start with status byte set to 0 */
+        clr_sync(qts, src_pir, ic_topo_id, op_type);
+        byte = get_sync(qts, src_pir, ic_topo_id, op_type);
+        g_assert_cmphex(byte, ==, 0);
+
+        /* request cache flush or queue sync operation */
+        inject_op(qts, ic_topo_id, op_type);
+
+        /* verify that status byte was written to 0xff */
+        byte = get_sync(qts, src_pir, ic_topo_id, op_type);
+        g_assert_cmphex(byte, ==, 0xff);
+
+        clr_sync(qts, src_pir, ic_topo_id, op_type);
+    }
+}
+
diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
new file mode 100644
index 0000000000..dd19e88861
--- /dev/null
+++ b/tests/qtest/pnv-xive2-test.c
@@ -0,0 +1,344 @@
+/*
+ * QTest testcase for PowerNV 10 interrupt controller (xive2)
+ *  - Test irq to hardware thread
+ *  - Test 'Pull Thread Context to Odd Thread Reporting Line'
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#include "pnv-xive2-common.h"
+#include "hw/intc/pnv_xive2_regs.h"
+#include "hw/ppc/xive_regs.h"
+#include "hw/ppc/xive2_regs.h"
+
+#define SMT                     4 /* some tests will break if less than 4 */
+
+
+static void set_table(QTestState *qts, uint64_t type, uint64_t addr)
+{
+    uint64_t vsd, size, log_size;
+
+    /*
+     * First, let's make sure that all the resources used fit in the
+     * given table.
+     */
+    switch (type) {
+    case VST_ESB:
+        size = MAX_IRQS / 4;
+        break;
+    case VST_EAS:
+        size = MAX_IRQS * 8;
+        break;
+    case VST_END:
+        size = MAX_ENDS * 32;
+        break;
+    case VST_NVP:
+    case VST_NVG:
+    case VST_NVC:
+        size = MAX_VPS * 32;
+        break;
+    case VST_SYNC:
+        size = 64 * 1024;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    g_assert_cmpuint(size, <=, XIVE_VST_SIZE);
+    log_size = ctzl(XIVE_VST_SIZE) - 12;
+
+    vsd = ((uint64_t) VSD_MODE_EXCLUSIVE) << 62 | addr | log_size;
+    pnv_xive_xscom_write(qts, X_VC_VSD_TABLE_ADDR, type << 48);
+    pnv_xive_xscom_write(qts, X_VC_VSD_TABLE_DATA, vsd);
+
+    if (type != VST_EAS && type != VST_IC && type != VST_ERQ) {
+        pnv_xive_xscom_write(qts, X_PC_VSD_TABLE_ADDR, type << 48);
+        pnv_xive_xscom_write(qts, X_PC_VSD_TABLE_DATA, vsd);
+    }
+}
+
+static void set_tima8(QTestState *qts, uint32_t pir, uint32_t offset,
+                      uint8_t b)
+{
+    uint64_t ic_addr;
+
+    ic_addr = XIVE_IC_TM_INDIRECT + (pir << XIVE_PAGE_SHIFT);
+    qtest_writeb(qts, ic_addr + offset, b);
+}
+
+static void set_tima32(QTestState *qts, uint32_t pir, uint32_t offset,
+                       uint32_t l)
+{
+    uint64_t ic_addr;
+
+    ic_addr = XIVE_IC_TM_INDIRECT + (pir << XIVE_PAGE_SHIFT);
+    qtest_writel(qts, ic_addr + offset, l);
+}
+
+static uint8_t get_tima8(QTestState *qts, uint32_t pir, uint32_t offset)
+{
+    uint64_t ic_addr;
+
+    ic_addr = XIVE_IC_TM_INDIRECT + (pir << XIVE_PAGE_SHIFT);
+    return qtest_readb(qts, ic_addr + offset);
+}
+
+static uint16_t get_tima16(QTestState *qts, uint32_t pir, uint32_t offset)
+{
+    uint64_t ic_addr;
+
+    ic_addr = XIVE_IC_TM_INDIRECT + (pir << XIVE_PAGE_SHIFT);
+    return qtest_readw(qts, ic_addr + offset);
+}
+
+static uint32_t get_tima32(QTestState *qts, uint32_t pir, uint32_t offset)
+{
+    uint64_t ic_addr;
+
+    ic_addr = XIVE_IC_TM_INDIRECT + (pir << XIVE_PAGE_SHIFT);
+    return qtest_readl(qts, ic_addr + offset);
+}
+
+static void reset_pool_threads(QTestState *qts)
+{
+    uint8_t first_group = 0;
+    int i;
+
+    for (i = 0; i < SMT; i++) {
+        uint32_t nvp_idx = 0x100 + i;
+        set_nvp(qts, nvp_idx, first_group);
+        set_tima32(qts, i, TM_QW2_HV_POOL + TM_WORD0, 0x000000ff);
+        set_tima32(qts, i, TM_QW2_HV_POOL + TM_WORD1, 0);
+        set_tima32(qts, i, TM_QW2_HV_POOL + TM_WORD2, TM_QW2W2_VP | nvp_idx);
+    }
+}
+
+static void reset_hw_threads(QTestState *qts)
+{
+    uint8_t first_group = 0;
+    uint32_t w1 = 0x000000ff;
+    int i;
+
+    if (SMT >= 4) {
+        /* define 2 groups of 2, part of a bigger group of size 4 */
+        set_nvg(qts, 0x80, 0x02);
+        set_nvg(qts, 0x82, 0x02);
+        set_nvg(qts, 0x81, 0);
+        first_group = 0x01;
+        w1 = 0x000300ff;
+    }
+
+    for (i = 0; i < SMT; i++) {
+        set_nvp(qts, 0x80 + i, first_group);
+        set_tima32(qts, i, TM_QW3_HV_PHYS + TM_WORD0, 0x00ff00ff);
+        set_tima32(qts, i, TM_QW3_HV_PHYS + TM_WORD1, w1);
+        set_tima32(qts, i, TM_QW3_HV_PHYS + TM_WORD2, 0x80000000);
+    }
+}
+
+static void reset_state(QTestState *qts)
+{
+    size_t mem_used = XIVE_MEM_END - XIVE_MEM_START;
+
+    qtest_memset(qts, XIVE_MEM_START, 0, mem_used);
+    reset_hw_threads(qts);
+    reset_pool_threads(qts);
+}
+
+static void init_xive(QTestState *qts)
+{
+    uint64_t val1, val2, range;
+
+    /*
+     * We can take a few shortcuts here, as we know the default values
+     * used for xive initialization
+     */
+
+    /*
+     * Set the BARs.
+     * We reuse the same values used by firmware to ease debug.
+     */
+    pnv_xive_xscom_write(qts, X_CQ_IC_BAR, XIVE_IC_BAR);
+    pnv_xive_xscom_write(qts, X_CQ_TM_BAR, XIVE_TM_BAR);
+
+    /* ESB and NVPG use 2 pages per resource. The others only one page */
+    range = (MAX_IRQS << 17) >> 25;
+    val1 = XIVE_ESB_BAR | range;
+    pnv_xive_xscom_write(qts, X_CQ_ESB_BAR, val1);
+
+    range = (MAX_ENDS << 16) >> 25;
+    val1 = XIVE_END_BAR | range;
+    pnv_xive_xscom_write(qts, X_CQ_END_BAR, val1);
+
+    range = (MAX_VPS << 17) >> 25;
+    val1 = XIVE_NVPG_BAR | range;
+    pnv_xive_xscom_write(qts, X_CQ_NVPG_BAR, val1);
+
+    range = (MAX_VPS << 16) >> 25;
+    val1 = XIVE_NVC_BAR | range;
+    pnv_xive_xscom_write(qts, X_CQ_NVC_BAR, val1);
+
+    /*
+     * Enable hw threads.
+     * We check the value written. Useless with current
+     * implementation, but it validates the xscom read path and it's
+     * what the hardware procedure says
+     */
+    val1 = 0xF000000000000000ull; /* core 0, 4 threads */
+    pnv_xive_xscom_write(qts, X_TCTXT_EN0, val1);
+    val2 = pnv_xive_xscom_read(qts, X_TCTXT_EN0);
+    g_assert_cmphex(val1, ==, val2);
+
+    /* Memory tables */
+    set_table(qts, VST_ESB, XIVE_ESB_MEM);
+    set_table(qts, VST_EAS, XIVE_EAS_MEM);
+    set_table(qts, VST_END, XIVE_END_MEM);
+    set_table(qts, VST_NVP, XIVE_NVP_MEM);
+    set_table(qts, VST_NVG, XIVE_NVG_MEM);
+    set_table(qts, VST_NVC, XIVE_NVC_MEM);
+    set_table(qts, VST_SYNC, XIVE_SYNC_MEM);
+
+    reset_hw_threads(qts);
+    reset_pool_threads(qts);
+}
+
+static void test_hw_irq(QTestState *qts)
+{
+    uint32_t irq = 2;
+    uint32_t irq_data = 0x600df00d;
+    uint32_t end_index = 5;
+    uint32_t target_pir = 1;
+    uint32_t target_nvp = 0x80 + target_pir;
+    uint8_t priority = 5;
+    uint32_t reg32;
+    uint16_t reg16;
+    uint8_t pq, nsr, cppr;
+
+    printf("# ============================================================\n");
+    printf("# Testing irq %d to hardware thread %d\n", irq, target_pir);
+
+    /* irq config */
+    set_eas(qts, irq, end_index, irq_data);
+    set_end(qts, end_index, target_nvp, priority, false /* group */);
+
+    /* enable and trigger irq */
+    get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_SET_PQ_00);
+    set_esb(qts, irq, XIVE_TRIGGER_PAGE, 0, 0);
+
+    /* check irq is raised on cpu */
+    pq = get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_GET);
+    g_assert_cmpuint(pq, ==, XIVE_ESB_PENDING);
+
+    reg32 = get_tima32(qts, target_pir, TM_QW3_HV_PHYS + TM_WORD0);
+    nsr = reg32 >> 24;
+    cppr = (reg32 >> 16) & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x80);
+    g_assert_cmphex(cppr, ==, 0xFF);
+
+    /* ack the irq */
+    reg16 = get_tima16(qts, target_pir, TM_SPC_ACK_HV_REG);
+    nsr = reg16 >> 8;
+    cppr = reg16 & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x80);
+    g_assert_cmphex(cppr, ==, priority);
+
+    /* check irq data is what was configured */
+    reg32 = qtest_readl(qts, xive_get_queue_addr(end_index));
+    g_assert_cmphex((reg32 & 0x7fffffff), ==, (irq_data & 0x7fffffff));
+
+    /* End Of Interrupt */
+    set_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_STORE_EOI, 0);
+    pq = get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_GET);
+    g_assert_cmpuint(pq, ==, XIVE_ESB_RESET);
+
+    /* reset CPPR */
+    set_tima8(qts, target_pir, TM_QW3_HV_PHYS + TM_CPPR, 0xFF);
+    reg32 = get_tima32(qts, target_pir, TM_QW3_HV_PHYS + TM_WORD0);
+    nsr = reg32 >> 24;
+    cppr = (reg32 >> 16) & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x00);
+    g_assert_cmphex(cppr, ==, 0xFF);
+}
+
+#define XIVE_ODD_CL 0x80
+static void test_pull_thread_ctx_to_odd_thread_cl(QTestState *qts)
+{
+    uint32_t target_pir = 1;
+    uint32_t target_nvp = 0x80 + target_pir;
+    Xive2Nvp nvp;
+    uint8_t cl_pair[XIVE_REPORT_SIZE];
+    uint32_t qw1w0, qw3w0, qw1w2, qw2w2;
+    uint8_t qw3b8;
+    uint32_t cl_word;
+    uint32_t word2;
+
+    printf("# ============================================================\n");
+    printf("# Testing 'Pull Thread Context to Odd Thread Reporting Line'\n");
+
+    /* clear odd cache line prior to pull operation */
+    memset(cl_pair, 0, sizeof(cl_pair));
+    get_nvp(qts, target_nvp, &nvp);
+    set_cl_pair(qts, &nvp, cl_pair);
+
+    /* Read some values from TIMA that we expect to see in cacheline */
+    qw1w0 = get_tima32(qts, target_pir, TM_QW1_OS + TM_WORD0);
+    qw3w0 = get_tima32(qts, target_pir, TM_QW3_HV_PHYS + TM_WORD0);
+    qw1w2 = get_tima32(qts, target_pir, TM_QW1_OS + TM_WORD2);
+    qw2w2 = get_tima32(qts, target_pir, TM_QW2_HV_POOL + TM_WORD2);
+    qw3b8 = get_tima8(qts, target_pir, TM_QW3_HV_PHYS + TM_WORD2);
+
+    /* Execute the pull operation */
+    set_tima8(qts, target_pir, TM_SPC_PULL_PHYS_CTX_OL, 0);
+
+    /* Verify odd cache line values match TIMA after pull operation */
+    get_cl_pair(qts, &nvp, cl_pair);
+    memcpy(&cl_word, &cl_pair[XIVE_ODD_CL + TM_QW1_OS + TM_WORD0], 4);
+    g_assert_cmphex(qw1w0, ==, be32_to_cpu(cl_word));
+    memcpy(&cl_word, &cl_pair[XIVE_ODD_CL + TM_QW3_HV_PHYS + TM_WORD0], 4);
+    g_assert_cmphex(qw3w0, ==, be32_to_cpu(cl_word));
+    memcpy(&cl_word, &cl_pair[XIVE_ODD_CL + TM_QW1_OS + TM_WORD2], 4);
+    g_assert_cmphex(qw1w2, ==, be32_to_cpu(cl_word));
+    memcpy(&cl_word, &cl_pair[XIVE_ODD_CL + TM_QW2_HV_POOL + TM_WORD2], 4);
+    g_assert_cmphex(qw2w2, ==, be32_to_cpu(cl_word));
+    g_assert_cmphex(qw3b8, ==,
+                    cl_pair[XIVE_ODD_CL + TM_QW3_HV_PHYS + TM_WORD2]);
+
+    /* Verify that all TIMA valid bits for target thread are cleared */
+    word2 = get_tima32(qts, target_pir, TM_QW1_OS + TM_WORD2);
+    g_assert_cmphex(xive_get_field32(TM_QW1W2_VO, word2), ==, 0);
+    word2 = get_tima32(qts, target_pir, TM_QW2_HV_POOL + TM_WORD2);
+    g_assert_cmphex(xive_get_field32(TM_QW2W2_VP, word2), ==, 0);
+    word2 = get_tima32(qts, target_pir, TM_QW3_HV_PHYS + TM_WORD2);
+    g_assert_cmphex(xive_get_field32(TM_QW3W2_VT, word2), ==, 0);
+}
+static void test_xive(void)
+{
+    QTestState *qts;
+
+    qts = qtest_initf("-M powernv10 -smp %d,cores=1,threads=%d -nographic "
+                      "-nodefaults -serial mon:stdio -S "
+                      "-d guest_errors -trace '*xive*'",
+                      SMT, SMT);
+    init_xive(qts);
+
+    test_hw_irq(qts);
+
+    /* omit reset_state here and use settings from test_hw_irq */
+    test_pull_thread_ctx_to_odd_thread_cl(qts);
+
+    reset_state(qts);
+    test_flush_sync_inject(qts);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("xive2", test_xive);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index fc852f3d8b..d2af58800d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -172,6 +172,7 @@ qtests_ppc64 = \
   qtests_ppc + \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['device-plug-test'] : []) +               \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xscom-test'] : []) +                 \
+  (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xive2-test'] : []) +                 \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-spi-seeprom-test'] : []) +           \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-host-i2c-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : []) +                      \
@@ -336,6 +337,7 @@ qtests = {
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
   'migration-test': migration_files,
   'pxe-test': files('boot-sector.c'),
+  'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c'),
   'qos-test': [chardev, io, qos_test_ss.apply({}).sources()],
   'tpm-crb-swtpm-test': [io, tpmemu_files],
   'tpm-crb-test': [io, tpmemu_files],
-- 
2.43.0


