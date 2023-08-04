Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF83776FF3C
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 13:11:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRsgs-0004WY-TQ; Fri, 04 Aug 2023 07:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1qRsgj-0004Se-J7
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 07:09:47 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1qRsgg-0006tL-Io
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 07:09:45 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 86E95C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1691147374; bh=jo7zwN76uewZLDwXdtVSRX/JiVGCe8JGbavMtvU6y+g=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=hsUen5QjpRhky8SN6dpcnL+cbdOctRn7lP2n0oDcbwk3Yoy5TDR3jIBIkj8eyTxJv
 ZqSsCIvoNxSoRciA/xkgtPxUEOFKWDMn1RtcP7BqI1RGwa0lkLTNZngog2ZTOKw1Ed
 bMZUkaWKvvES7wftzo0g1/bbRr9scyGesj1Nd+2bR77vIGWX57IkBR9JgE2MQUC8aH
 Y1MHAMolaHw0vS47RRycqATAQteayg10eugv/b6ZDHTBBfBcCcmIBg3TgDLgKGqYFq
 nMdCnzGZi4+ANfX27QqRWCaKS/S6nHoZvrVUxVXoohel6xyT85V5FnDtFe69ZUyrQm
 hYlg8kDsG4I/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1691147374; bh=jo7zwN76uewZLDwXdtVSRX/JiVGCe8JGbavMtvU6y+g=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=GDi8A5Kvo7Pucga1HgYcu5mkRS2i9B/aSGCeTgldMEkb4IzNsBZjzF92igQCESvg0
 moidY3vxz6eYJJYU8FahGhWzImQc8sk2Gytw27NZQAlH3rv+jZNkYQXPrcmeuuA1wo
 0Ak5YFjk3SOtxQlqjJpBYhnkKeQhCLj2Xs24P34DJRi/FyNbj01yX2SofstBs4ros5
 zLnqlEgqnYj8yrOzQPBCkJBHwlQf3FXr5mQhi1dE0/UHXylLBj0vUoyf2dB68xFnbT
 U8hVkgvIWcmpzJ7efoPBkfABeTBv1jvIUsPh7oSHG/Pr+zdXgdRJ9dsXb8j6yhvZXP
 WBjqRM1+hNIfw==
From: Mikhail Tyutin <m.tyutin@yadro.com>
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <pbonzini@redhat.com>,
 <alex.bennee@linaro.org>, <peter.maydell@linaro.org>, Mikhail Tyutin
 <m.tyutin@yadro.com>, Dmitriy Solovev <d.solovev@yadro.com>
Subject: [PATCH v3] Fix SEGFAULT on getting physical address of MMIO region.
Date: Fri, 4 Aug 2023 14:09:03 +0300
Message-ID: <20230804110903.19968-1-m.tyutin@yadro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
Received-SPF: pass client-ip=89.207.88.248; envelope-from=m.tyutin@yadro.com;
 helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Apply save_iotlb_data() to io_readx() as well as to io_writex(). This fixes
SEGFAULT on qemu_plugin_hwaddr_phys_addr() call plugins for addresses inside of
MMIO region.

Signed-off-by: Dmitriy Solovev <d.solovev@yadro.com>
Signed-off-by: Mikhail Tyutin <m.tyutin@yadro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v3:
- commit wording update


 accel/tcg/cputlb.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ba44501a7c..addce3be38 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1363,6 +1363,21 @@ static inline void cpu_transaction_failed(CPUState *cpu, hwaddr physaddr,
     }
 }
 
+/*
+ * Save a potentially trashed CPUTLBEntryFull for later lookup by plugin.
+ * This is read by tlb_plugin_lookup if the fulltlb entry doesn't match
+ * because of the side effect of io_writex changing memory layout.
+ */
+static void save_iotlb_data(CPUState *cs, MemoryRegionSection *section,
+                            hwaddr mr_offset)
+{
+#ifdef CONFIG_PLUGIN
+    SavedIOTLB *saved = &cs->saved_iotlb;
+    saved->section = section;
+    saved->mr_offset = mr_offset;
+#endif
+}
+
 static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
                          int mmu_idx, vaddr addr, uintptr_t retaddr,
                          MMUAccessType access_type, MemOp op)
@@ -1382,6 +1397,12 @@ static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
         cpu_io_recompile(cpu, retaddr);
     }
 
+    /*
+     * The memory_region_dispatch may trigger a flush/resize
+     * so for plugins we save the iotlb_data just in case.
+     */
+    save_iotlb_data(cpu, section, mr_offset);
+
     {
         QEMU_IOTHREAD_LOCK_GUARD();
         r = memory_region_dispatch_read(mr, mr_offset, &val, op, full->attrs);
@@ -1398,21 +1419,6 @@ static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
     return val;
 }
 
-/*
- * Save a potentially trashed CPUTLBEntryFull for later lookup by plugin.
- * This is read by tlb_plugin_lookup if the fulltlb entry doesn't match
- * because of the side effect of io_writex changing memory layout.
- */
-static void save_iotlb_data(CPUState *cs, MemoryRegionSection *section,
-                            hwaddr mr_offset)
-{
-#ifdef CONFIG_PLUGIN
-    SavedIOTLB *saved = &cs->saved_iotlb;
-    saved->section = section;
-    saved->mr_offset = mr_offset;
-#endif
-}
-
 static void io_writex(CPUArchState *env, CPUTLBEntryFull *full,
                       int mmu_idx, uint64_t val, vaddr addr,
                       uintptr_t retaddr, MemOp op)
-- 
2.34.1


