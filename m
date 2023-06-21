Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BAC738A63
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 18:04:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC0Is-0007iA-Vz; Wed, 21 Jun 2023 12:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qC0Iq-0007gS-56; Wed, 21 Jun 2023 12:03:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qC0Im-0001m8-RI; Wed, 21 Jun 2023 12:03:27 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35LG2A5l004374; Wed, 21 Jun 2023 16:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=U7MMtxFyDlFmucvR/ikgK8O86T+5qNS0usDaBvKh9oU=;
 b=hoaOx+hgC1XwCroId9IOaTC+jqqn3yFr/7xk7eYUJIaV0TPLfcjKAHpXuji3ecHIXdUB
 PhKv/dDacudIklXfGg2WhVRQOg477DRLRhWTYoYjDbnl6Se3ztO3uhLP+qlS1y/32XRw
 0SPupe0Q+8yvwR0eiQlE0duLl6MiojZrrGU+xGZm914t2YMTTSBN97AOrnsoPcylCJbm
 tGnr204UsaQnJTorPp5hSAaRl6R5h7y3qN44UFNFYK0A7qPLQzHASJF2lAWAJNjaZ4NU
 DRZxMmcz66/Bch9RR7DoPsu6K7WiIjnIxA9o5IFaZfem6lubV1oDE5ybOhBCKtvWMPH0 Og== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc4cdr2h5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 16:03:18 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35LG3F5I014160;
 Wed, 21 Jun 2023 16:03:15 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc4cdr25c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 16:03:14 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35LCtMxE032427;
 Wed, 21 Jun 2023 16:03:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3r94f5a5ws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 16:03:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35LG38aD28050072
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 16:03:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02D6720043;
 Wed, 21 Jun 2023 16:03:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CF6A20040;
 Wed, 21 Jun 2023 16:03:07 +0000 (GMT)
Received: from borneo.ibmuc.com (unknown [9.171.1.141])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Jun 2023 16:03:07 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: clg@kaod.org, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] pnv/xive2: Check TIMA special ops against a dedicated
 array for P10
Date: Wed, 21 Jun 2023 18:03:06 +0200
Message-ID: <20230621160306.896045-3-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621160306.896045-1-fbarrat@linux.ibm.com>
References: <20230621160306.896045-1-fbarrat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y7gdqaZ9cKaes7aPWYYqVbVa_dsM8VaL
X-Proofpoint-ORIG-GUID: I3nqY5RyTG6MjgDI4TH9-N9T5lT8HTA6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_09,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210131
Received-SPF: pass client-ip=148.163.156.1; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Accessing the TIMA from some specific ring/offset combination can
trigger a special operation, with or without side effects. It is
implemented in qemu with an array of special operations to compare
accesses against. Since the presenter on P10 is pretty similar to P9,
we had the full array defined for P9 and we just had a special case
for P10 to treat one access differently. With a recent change,
6f2cbd133d4 ("pnv/xive2: Handle TIMA access through all ports"), we
now ignore some of the bits of the TIMA address, but that patch
managed to botch the detection of the special case for P10.

To clean that up, this patch introduces a full array of special ops to
be used for P10. The code to detect a special access is common with
P9, only the array of operations differs. The presenter can pick the
correct array of special ops based on its configuration introduced in
a previous patch.

Fixes: Coverity CID 1512997, 1512998
Fixes: 6f2cbd133d4 ("pnv/xive2: Handle TIMA access through all ports")
Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 hw/intc/pnv_xive2.c | 32 ----------------------------
 hw/intc/xive.c      | 52 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 59534f6843..ed438a20ed 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1656,17 +1656,6 @@ static const MemoryRegionOps pnv_xive2_ic_tm_indirect_ops = {
 /*
  * TIMA ops
  */
-
-/*
- * Special TIMA offsets to handle accesses in a POWER10 way.
- *
- * Only the CAM line updates done by the hypervisor should be handled
- * specifically.
- */
-#define HV_PAGE_OFFSET         (XIVE_TM_HV_PAGE << TM_SHIFT)
-#define HV_PUSH_OS_CTX_OFFSET  (HV_PAGE_OFFSET | (TM_QW1_OS + TM_WORD2))
-#define HV_PULL_OS_CTX_OFFSET  (HV_PAGE_OFFSET | TM_SPC_PULL_OS_CTX)
-
 static void pnv_xive2_tm_write(void *opaque, hwaddr offset,
                                uint64_t value, unsigned size)
 {
@@ -1674,18 +1663,7 @@ static void pnv_xive2_tm_write(void *opaque, hwaddr offset,
     PnvXive2 *xive = pnv_xive2_tm_get_xive(cpu);
     XiveTCTX *tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
     XivePresenter *xptr = XIVE_PRESENTER(xive);
-    bool gen1_tima_os =
-        xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
-
-    offset &= TM_ADDRESS_MASK;
 
-    /* TODO: should we switch the TM ops table instead ? */
-    if (!gen1_tima_os && offset == HV_PUSH_OS_CTX_OFFSET) {
-        xive2_tm_push_os_ctx(xptr, tctx, offset, value, size);
-        return;
-    }
-
-    /* Other TM ops are the same as XIVE1 */
     xive_tctx_tm_write(xptr, tctx, offset, value, size);
 }
 
@@ -1695,17 +1673,7 @@ static uint64_t pnv_xive2_tm_read(void *opaque, hwaddr offset, unsigned size)
     PnvXive2 *xive = pnv_xive2_tm_get_xive(cpu);
     XiveTCTX *tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
     XivePresenter *xptr = XIVE_PRESENTER(xive);
-    bool gen1_tima_os =
-        xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
-
-    offset &= TM_ADDRESS_MASK;
-
-    /* TODO: should we switch the TM ops table instead ? */
-    if (!gen1_tima_os && offset == HV_PULL_OS_CTX_OFFSET) {
-        return xive2_tm_pull_os_ctx(xptr, tctx, offset, size);
-    }
 
-    /* Other TM ops are the same as XIVE1 */
     return xive_tctx_tm_read(xptr, tctx, offset, size);
 }
 
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 34a868b185..84c079b034 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -20,6 +20,7 @@
 #include "monitor/monitor.h"
 #include "hw/irq.h"
 #include "hw/ppc/xive.h"
+#include "hw/ppc/xive2.h"
 #include "hw/ppc/xive_regs.h"
 #include "trace.h"
 
@@ -461,7 +462,7 @@ static void xive_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     }
 }
 
-static __attribute__((unused)) uint32_t xive_presenter_get_config(XivePresenter *xptr)
+static uint32_t xive_presenter_get_config(XivePresenter *xptr)
 {
     XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
 
@@ -504,14 +505,47 @@ static const XiveTmOp xive_tm_operations[] = {
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  8, NULL, xive_tm_pull_pool_ctx },
 };
 
-static const XiveTmOp *xive_tm_find_op(hwaddr offset, unsigned size, bool write)
+static const XiveTmOp xive2_tm_operations[] = {
+    /*
+     * MMIOs below 2K : raw values and special operations without side
+     * effects
+     */
+    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,   1, xive_tm_set_os_cppr, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,  4, xive2_tm_push_os_ctx, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR, 1, xive_tm_set_hv_cppr, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL, xive_tm_vt_poll },
+
+    /* MMIOs above 2K : special operations with side effects */
+    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,     2, NULL, xive_tm_ack_os_reg },
+    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING, 1, xive_tm_set_os_pending, NULL },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,    4, NULL, xive2_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,    8, NULL, xive2_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,     2, NULL, xive_tm_ack_hv_reg },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  4, NULL, xive_tm_pull_pool_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  8, NULL, xive_tm_pull_pool_ctx },
+};
+
+static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offset,
+                                       unsigned size, bool write)
 {
     uint8_t page_offset = (offset >> TM_SHIFT) & 0x3;
     uint32_t op_offset = offset & TM_ADDRESS_MASK;
-    int i;
+    const XiveTmOp *tm_ops;
+    int i, tm_ops_count;
+    uint32_t cfg;
+
+    cfg = xive_presenter_get_config(xptr);
+    if (cfg & XIVE_PRESENTER_GEN1_TIMA_OS) {
+        tm_ops = xive_tm_operations;
+        tm_ops_count = ARRAY_SIZE(xive_tm_operations);
+    } else {
+        tm_ops = xive2_tm_operations;
+        tm_ops_count = ARRAY_SIZE(xive2_tm_operations);
+    }
 
-    for (i = 0; i < ARRAY_SIZE(xive_tm_operations); i++) {
-        const XiveTmOp *xto = &xive_tm_operations[i];
+    for (i = 0; i < tm_ops_count; i++) {
+        const XiveTmOp *xto = &tm_ops[i];
 
         /* Accesses done from a more privileged TIMA page is allowed */
         if (xto->page_offset >= page_offset &&
@@ -542,7 +576,7 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
      * First, check for special operations in the 2K region
      */
     if (offset & TM_SPECIAL_OP) {
-        xto = xive_tm_find_op(offset, size, true);
+        xto = xive_tm_find_op(tctx->xptr, offset, size, true);
         if (!xto) {
             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid write access at TIMA "
                           "@%"HWADDR_PRIx"\n", offset);
@@ -555,7 +589,7 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
     /*
      * Then, for special operations in the region below 2K.
      */
-    xto = xive_tm_find_op(offset, size, true);
+    xto = xive_tm_find_op(tctx->xptr, offset, size, true);
     if (xto) {
         xto->write_handler(xptr, tctx, offset, value, size);
         return;
@@ -581,7 +615,7 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
      * First, check for special operations in the 2K region
      */
     if (offset & TM_SPECIAL_OP) {
-        xto = xive_tm_find_op(offset, size, false);
+        xto = xive_tm_find_op(tctx->xptr, offset, size, false);
         if (!xto) {
             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid read access to TIMA"
                           "@%"HWADDR_PRIx"\n", offset);
@@ -594,7 +628,7 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
     /*
      * Then, for special operations in the region below 2K.
      */
-    xto = xive_tm_find_op(offset, size, false);
+    xto = xive_tm_find_op(tctx->xptr, offset, size, false);
     if (xto) {
         ret = xto->read_handler(xptr, tctx, offset, size);
         goto out;
-- 
2.41.0


