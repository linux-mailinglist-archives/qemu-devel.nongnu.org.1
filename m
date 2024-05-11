Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F08488C2E84
	for <lists+qemu-devel@lfdr.de>; Sat, 11 May 2024 03:47:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5boM-0004kI-Io; Fri, 10 May 2024 21:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5bo6-0004jn-8S; Fri, 10 May 2024 21:45:50 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5bo3-0003MC-MY; Fri, 10 May 2024 21:45:50 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DC6D14E6776;
 Sat, 11 May 2024 03:45:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id D--L4DJWfiia; Sat, 11 May 2024 03:45:42 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E8DB74E6777; Sat, 11 May 2024 03:45:42 +0200 (CEST)
Message-Id: <20b23099bc0e51eedb7a97e1c34b582a95a38239.1715390232.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715390232.git.balaton@eik.bme.hu>
References: <cover.1715390232.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 04/48] target/ppc/mmu_common.c: Remove unneeded local
 variable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Sat, 11 May 2024 03:45:42 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

In mmubooke_check_tlb() and mmubooke206_check_tlb() we can assign the
value of prot2 directly to the destination, no need to have a separate
local variable for it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index f79e390306..09cbeb0052 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -628,8 +628,6 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
                               hwaddr *raddr, int *prot, target_ulong address,
                               MMUAccessType access_type, int i)
 {
-    int prot2;
-
     if (!mmubooke_check_pid(env, tlb, raddr, address, i)) {
         qemu_log_mask(CPU_LOG_MMU, "%s: TLB entry not found\n", __func__);
         return -1;
@@ -644,17 +642,16 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
     }
 
     if (FIELD_EX64(env->msr, MSR, PR)) {
-        prot2 = tlb->prot & 0xF;
+        *prot = tlb->prot & 0xF;
     } else {
-        prot2 = (tlb->prot >> 4) & 0xF;
+        *prot = (tlb->prot >> 4) & 0xF;
     }
-    *prot = prot2;
-    if (prot2 & prot_for_access_type(access_type)) {
+    if (*prot & prot_for_access_type(access_type)) {
         qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
         return 0;
     }
 
-    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, prot2);
+    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, *prot);
     return access_type == MMU_INST_FETCH ? -3 : -2;
 }
 
@@ -795,7 +792,6 @@ static int mmubooke206_check_tlb(CPUPPCState *env, ppcmas_tlb_t *tlb,
                                  target_ulong address,
                                  MMUAccessType access_type, int mmu_idx)
 {
-    int prot2 = 0;
     uint32_t epid;
     bool as, pr;
     bool use_epid = mmubooke206_get_as(env, mmu_idx, &epid, &as, &pr);
@@ -841,34 +837,34 @@ found_tlb:
         return -1;
     }
 
+    *prot = 0;
     if (pr) {
         if (tlb->mas7_3 & MAS3_UR) {
-            prot2 |= PAGE_READ;
+            *prot |= PAGE_READ;
         }
         if (tlb->mas7_3 & MAS3_UW) {
-            prot2 |= PAGE_WRITE;
+            *prot |= PAGE_WRITE;
         }
         if (tlb->mas7_3 & MAS3_UX) {
-            prot2 |= PAGE_EXEC;
+            *prot |= PAGE_EXEC;
         }
     } else {
         if (tlb->mas7_3 & MAS3_SR) {
-            prot2 |= PAGE_READ;
+            *prot |= PAGE_READ;
         }
         if (tlb->mas7_3 & MAS3_SW) {
-            prot2 |= PAGE_WRITE;
+            *prot |= PAGE_WRITE;
         }
         if (tlb->mas7_3 & MAS3_SX) {
-            prot2 |= PAGE_EXEC;
+            *prot |= PAGE_EXEC;
         }
     }
-    *prot = prot2;
-    if (prot2 & prot_for_access_type(access_type)) {
+    if (*prot & prot_for_access_type(access_type)) {
         qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
         return 0;
     }
 
-    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, prot2);
+    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, *prot);
     return access_type == MMU_INST_FETCH ? -3 : -2;
 }
 
-- 
2.30.9


