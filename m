Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 605FB73D78E
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:08:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDfFH-0005Eq-6V; Mon, 26 Jun 2023 01:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfF8-0004Lm-4v; Mon, 26 Jun 2023 01:58:31 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfF2-0007hD-Ja; Mon, 26 Jun 2023 01:58:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QqHFp0Jxjz4wb8;
 Mon, 26 Jun 2023 15:58:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqHFl5YlHz4wb6;
 Mon, 26 Jun 2023 15:58:19 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 29/30] pnv/xive2: Check TIMA special ops against a dedicated
 array for P10
Date: Mon, 26 Jun 2023 07:56:46 +0200
Message-ID: <20230626055647.1147743-30-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626055647.1147743-1-clg@kaod.org>
References: <20230626055647.1147743-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/intc/pnv_xive2.c | 32 ----------------------------
 hw/intc/xive.c      | 52 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 59534f684335..ed438a20ed4f 100644
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
index 34a868b1850b..84c079b03440 100644
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


