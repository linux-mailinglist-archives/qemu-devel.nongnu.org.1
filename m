Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9648670B8A3
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 11:11:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q11Yi-0002tu-Cl; Mon, 22 May 2023 05:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q11Yf-0002tR-Ao
 for qemu-devel@nongnu.org; Mon, 22 May 2023 05:10:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q11Yd-0005e4-6P
 for qemu-devel@nongnu.org; Mon, 22 May 2023 05:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684746621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GrdjZvf6wgmfxGrEaqWt8G9LMo+OIUL/yDVc7Hc5jUU=;
 b=c8PScgm4vE9/NiBGLDT85FDS//EqFacrOGC26lQ7Xg5R0s2p1KukdaAve/Lci2PgY2twUR
 enx4or57DFbUD/zAiSKoRgtEW5kY9mlZvCm+q+3g2XfnuROL6zgKDabIpv3RdMEMkBY/PQ
 s5gMNMezgyYZm2jwKSGGLjg8CrEovYM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-0uS6V7vGN56v5kzjah1Tsg-1; Mon, 22 May 2023 05:10:18 -0400
X-MC-Unique: 0uS6V7vGN56v5kzjah1Tsg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF7713806622;
 Mon, 22 May 2023 09:10:17 +0000 (UTC)
Received: from thuth.com (unknown [10.45.224.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21DEF20296C6;
 Mon, 22 May 2023 09:10:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
 Bandan Das <bsd@redhat.com>, Darren Kenny <darren.kenny@oracle.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, qemu-stable@nongnu.org
Subject: [PATCH v2] hw/scsi/lsi53c895a: Fix reentrancy issues in the LSI
 controller (CVE-2023-0330)
Date: Mon, 22 May 2023 11:10:11 +0200
Message-Id: <20230522091011.1082574-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We cannot use the generic reentrancy guard in the LSI code, so
we have to manually prevent endless reentrancy here. The problematic
lsi_execute_script() function has already a way to detect whether
too many instructions have been executed - we just have to slightly
change the logic here that it also takes into account if the function
has been called too often in a reentrant way.

The code in fuzz-lsi53c895a-test.c has been taken from an earlier
patch by Mauro Matteo Cascella.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1563
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Add a comment about the reentrancy problem to the source code

 hw/scsi/lsi53c895a.c               | 23 +++++++++++++++------
 tests/qtest/fuzz-lsi53c895a-test.c | 33 ++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 048436352b..f7d45b0b20 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1134,15 +1134,24 @@ static void lsi_execute_script(LSIState *s)
     uint32_t addr, addr_high;
     int opcode;
     int insn_processed = 0;
+    static int reentrancy_level;
+
+    reentrancy_level++;
 
     s->istat1 |= LSI_ISTAT1_SRUN;
 again:
-    if (++insn_processed > LSI_MAX_INSN) {
-        /* Some windows drivers make the device spin waiting for a memory
-           location to change.  If we have been executed a lot of code then
-           assume this is the case and force an unexpected device disconnect.
-           This is apparently sufficient to beat the drivers into submission.
-         */
+    /*
+     * Some windows drivers make the device spin waiting for a memory location
+     * to change. If we have executed more than LSI_MAX_INSN instructions then
+     * assume this is the case and force an unexpected device disconnect. This
+     * is apparently sufficient to beat the drivers into submission.
+     *
+     * Another issue (CVE-2023-0330) can occur if the script is programmed to
+     * trigger itself again and again. Avoid this problem by stopping after
+     * being called multiple times in a reentrant way (8 is an arbitrary value
+     * which should be enough for all valid use cases).
+     */
+    if (++insn_processed > LSI_MAX_INSN || reentrancy_level > 8) {
         if (!(s->sien0 & LSI_SIST0_UDC)) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "lsi_scsi: inf. loop with UDC masked");
@@ -1596,6 +1605,8 @@ again:
         }
     }
     trace_lsi_execute_script_stop();
+
+    reentrancy_level--;
 }
 
 static uint8_t lsi_reg_readb(LSIState *s, int offset)
diff --git a/tests/qtest/fuzz-lsi53c895a-test.c b/tests/qtest/fuzz-lsi53c895a-test.c
index 2012bd54b7..1b55928b9f 100644
--- a/tests/qtest/fuzz-lsi53c895a-test.c
+++ b/tests/qtest/fuzz-lsi53c895a-test.c
@@ -8,6 +8,36 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 
+/*
+ * This used to trigger a DMA reentrancy issue
+ * leading to memory corruption bugs like stack
+ * overflow or use-after-free
+ * https://gitlab.com/qemu-project/qemu/-/issues/1563
+ */
+static void test_lsi_dma_reentrancy(void)
+{
+    QTestState *s;
+
+    s = qtest_init("-M q35 -m 512M -nodefaults "
+                   "-blockdev driver=null-co,node-name=null0 "
+                   "-device lsi53c810 -device scsi-cd,drive=null0");
+
+    qtest_outl(s, 0xcf8, 0x80000804); /* PCI Command Register */
+    qtest_outw(s, 0xcfc, 0x7);        /* Enables accesses */
+    qtest_outl(s, 0xcf8, 0x80000814); /* Memory Bar 1 */
+    qtest_outl(s, 0xcfc, 0xff100000); /* Set MMIO Address*/
+    qtest_outl(s, 0xcf8, 0x80000818); /* Memory Bar 2 */
+    qtest_outl(s, 0xcfc, 0xff000000); /* Set RAM Address*/
+    qtest_writel(s, 0xff000000, 0xc0000024);
+    qtest_writel(s, 0xff000114, 0x00000080);
+    qtest_writel(s, 0xff00012c, 0xff000000);
+    qtest_writel(s, 0xff000004, 0xff000114);
+    qtest_writel(s, 0xff000008, 0xff100014);
+    qtest_writel(s, 0xff10002f, 0x000000ff);
+
+    qtest_quit(s);
+}
+
 /*
  * This used to trigger a UAF in lsi_do_msgout()
  * https://gitlab.com/qemu-project/qemu/-/issues/972
@@ -124,5 +154,8 @@ int main(int argc, char **argv)
     qtest_add_func("fuzz/lsi53c895a/lsi_do_msgout_cancel_req",
                    test_lsi_do_msgout_cancel_req);
 
+    qtest_add_func("fuzz/lsi53c895a/lsi_dma_reentrancy",
+                   test_lsi_dma_reentrancy);
+
     return g_test_run();
 }
-- 
2.31.1


