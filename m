Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0038CF6C3
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 01:18:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN4I-000471-HE; Sun, 26 May 2024 19:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN4F-00045c-7F; Sun, 26 May 2024 19:14:19 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN4C-0003eo-4g; Sun, 26 May 2024 19:14:17 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E011B4E61D6;
 Mon, 27 May 2024 01:12:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 81b-xXlvFses; Mon, 27 May 2024 01:12:51 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EF16C4E610B; Mon, 27 May 2024 01:12:51 +0200 (CEST)
Message-Id: <67350d0b2e2773d02536ba9cce812361ff1b5a16.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 16/43] target/ppc/mmu_common.c: Inline and remove
 ppc6xx_tlb_pte_check()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:12:51 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

This function is only called once and we can make the caller simpler
by inlining it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 71 +++++++++++++----------------------------
 1 file changed, 22 insertions(+), 49 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index b2993e8563..784e833ff2 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -91,33 +91,6 @@ int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
     return nr;
 }
 
-static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
-                                target_ulong pte1, int pteh,
-                                MMUAccessType access_type, bool nx)
-{
-    /* Check validity and table match */
-    if (!pte_is_valid(pte0) || ((pte0 >> 6) & 1) != pteh ||
-        (pte0 & PTE_PTEM_MASK) != ctx->ptem) {
-        return -1;
-    }
-    /* all matches should have equal RPN, WIMG & PP */
-    if (ctx->raddr != (hwaddr)-1ULL &&
-        (ctx->raddr & PTE_CHECK_MASK) != (pte1 & PTE_CHECK_MASK)) {
-        qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
-        return -3;
-    }
-    /* Keep the matching PTE information */
-    ctx->raddr = pte1;
-    ctx->prot = ppc_hash32_prot(ctx->key, pte1 & HPTE32_R_PP, nx);
-    if (check_prot_access_type(ctx->prot, access_type)) {
-        qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
-        return 0;
-    } else {
-        qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
-        return -2;
-    }
-}
-
 /* Software driven TLB helpers */
 
 static int ppc6xx_tlb_check(CPUPPCState *env,
@@ -149,32 +122,32 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
                       tlb->EPN, eaddr, tlb->pte1,
                       access_type == MMU_DATA_STORE ? 'S' : 'L',
                       access_type == MMU_INST_FETCH ? 'I' : 'D');
-        switch (ppc6xx_tlb_pte_check(ctx, tlb->pte0, tlb->pte1,
-                                     0, access_type, nx)) {
-        case -2:
-            /* Access violation */
-            ret = -2;
-            best = nr;
-            break;
-        case -1: /* No match */
-        case -3: /* TLB inconsistency */
-        default:
-            break;
-        case 0:
-            /* access granted */
-            /*
-             * XXX: we should go on looping to check all TLBs
-             *      consistency but we can speed-up the whole thing as
-             *      the result would be undefined if TLBs are not
-             *      consistent.
-             */
+        /* Check validity and table match */
+        if (!pte_is_valid(tlb->pte0) || ((tlb->pte0 >> 6) & 1) != 0 ||
+            (tlb->pte0 & PTE_PTEM_MASK) != ctx->ptem) {
+            continue;
+        }
+        /* all matches should have equal RPN, WIMG & PP */
+        if (ctx->raddr != (hwaddr)-1ULL &&
+            (ctx->raddr & PTE_CHECK_MASK) != (tlb->pte1 & PTE_CHECK_MASK)) {
+            qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
+            /* TLB inconsistency */
+            continue;
+        }
+        /* Keep the matching PTE information */
+        best = nr;
+        ctx->raddr = tlb->pte1;
+        ctx->prot = ppc_hash32_prot(ctx->key, tlb->pte1 & HPTE32_R_PP, nx);
+        if (check_prot_access_type(ctx->prot, access_type)) {
+            qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
             ret = 0;
-            best = nr;
-            goto done;
+            break;
+        } else {
+            qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
+            ret = -2;
         }
     }
     if (best != -1) {
-done:
         qemu_log_mask(CPU_LOG_MMU, "found TLB at addr " HWADDR_FMT_plx
                       " prot=%01x ret=%d\n",
                       ctx->raddr & TARGET_PAGE_MASK, ctx->prot, ret);
-- 
2.30.9


