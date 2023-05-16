Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 716D0704A59
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 12:21:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyrnF-0003PA-Ax; Tue, 16 May 2023 06:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pyrnC-0003KG-0g
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:20:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pyrnA-0007TV-71
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684232427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GlE+waBaMr0Saj2xUSqYiWcVwHllhRluLZTgHhavGKY=;
 b=ZBdHM7mXOh1SoIwN7nrXx2bu4IwiaA6Ct6WT6eVIvOZUiItj/EoPW2P96/AIgZ8l9ctbdV
 N9RivM5aM4ibJG2hhX0IXsiL0/1mGK4H73hJTU7ORLRhRyIJ9PheI7aVy/AgZWkl2Fk0lu
 gAJ4WgUJm3ixiAAmCypsU4R9MLk+gag=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-LZHr9i4xMXSrIOc9iOfTwg-1; Tue, 16 May 2023 06:20:23 -0400
X-MC-Unique: LZHr9i4xMXSrIOc9iOfTwg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D1C9381D4C8;
 Tue, 16 May 2023 10:20:23 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 340524021D9;
 Tue, 16 May 2023 10:20:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Alexander Bulekov <alxndr@bu.edu>
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
 Bandan Das <bsd@redhat.com>, Darren Kenny <darren.kenny@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: [PATCH] hw/scsi/lsi53c895a: Fix reentrancy issues in the LSI
 controller (CVE-2023-0330)
Date: Tue, 16 May 2023 12:20:16 +0200
Message-Id: <20230516102016.581877-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 hw/scsi/lsi53c895a.c               |  7 ++++++-
 tests/qtest/fuzz-lsi53c895a-test.c | 33 ++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 048436352b..8b34199ab8 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1134,10 +1134,13 @@ static void lsi_execute_script(LSIState *s)
     uint32_t addr, addr_high;
     int opcode;
     int insn_processed = 0;
+    static int reentrancy_level;
+
+    reentrancy_level++;
 
     s->istat1 |= LSI_ISTAT1_SRUN;
 again:
-    if (++insn_processed > LSI_MAX_INSN) {
+    if (++insn_processed > LSI_MAX_INSN || reentrancy_level > 8) {
         /* Some windows drivers make the device spin waiting for a memory
            location to change.  If we have been executed a lot of code then
            assume this is the case and force an unexpected device disconnect.
@@ -1596,6 +1599,8 @@ again:
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


