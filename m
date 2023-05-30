Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E54D7161D7
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:29:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zOz-0001vi-K1; Tue, 30 May 2023 09:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3zOc-0001Kr-Ey; Tue, 30 May 2023 09:28:21 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3zOa-0002Ju-8V; Tue, 30 May 2023 09:28:18 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id D0DD9748A67;
 Tue, 30 May 2023 15:28:12 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AA8CC748A65; Tue, 30 May 2023 15:28:12 +0200 (CEST)
Message-Id: <bacd1bcbe99c07930c29a9815915da9ac75f6920.1685448535.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1685448535.git.balaton@eik.bme.hu>
References: <cover.1685448535.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 6/7] target/ppc: Change ppcemb_tlb_check() to return bool
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue, 30 May 2023 15:28:12 +0200 (CEST)
X-Spam-Probability: 8%
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

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index ff7f987546..bd7d7d5257 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -489,15 +489,15 @@ static int get_segment_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
 }
 
 /* Generic TLB check function for embedded PowerPC implementations */
-static int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
-                            hwaddr *raddrp,
-                            target_ulong address, uint32_t pid, int i)
+static bool ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
+                             hwaddr *raddrp,
+                             target_ulong address, uint32_t pid, int i)
 {
     target_ulong mask;
 
     /* Check valid flag */
     if (!(tlb->prot & PAGE_VALID)) {
-        return -1;
+        return false;
     }
     mask = ~(tlb->size - 1);
     qemu_log_mask(CPU_LOG_MMU, "%s: TLB %d address " TARGET_FMT_lx
@@ -506,14 +506,14 @@ static int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
                   mask, (uint32_t)tlb->PID, tlb->prot);
     /* Check PID */
     if (tlb->PID != 0 && tlb->PID != pid) {
-        return -1;
+        return false;
     }
     /* Check effective address */
     if ((address & mask) != tlb->EPN) {
-        return -1;
+        return false;
     }
     *raddrp = (tlb->RPN & mask) | (address & ~mask);
-    return 0;
+    return true;
 }
 
 /* Generic TLB search function for PowerPC embedded implementations */
@@ -525,7 +525,7 @@ int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid)
 
     for (i = 0; i < env->nb_tlb; i++) {
         tlb = &env->tlb.tlbe[i];
-        if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, i) == 0) {
+        if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, i)) {
             return i;
         }
     }
@@ -545,8 +545,8 @@ static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     pr = FIELD_EX64(env->msr, MSR, PR);
     for (i = 0; i < env->nb_tlb; i++) {
         tlb = &env->tlb.tlbe[i];
-        if (ppcemb_tlb_check(env, tlb, &raddr, address,
-                             env->spr[SPR_40x_PID], i) < 0) {
+        if (!ppcemb_tlb_check(env, tlb, &raddr, address,
+                              env->spr[SPR_40x_PID], i)) {
             continue;
         }
         zsel = (tlb->attr >> 4) & 0xF;
@@ -608,7 +608,7 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
     int prot2;
 
     if (ppcemb_tlb_check(env, tlb, raddr, address,
-                         env->spr[SPR_BOOKE_PID], i) >= 0) {
+                         env->spr[SPR_BOOKE_PID], i)) {
         if (!env->nb_pids) {
             /* Extend the physical address to 36 bits */
             *raddr |= (uint64_t)(tlb->RPN & 0xF) << 32;
@@ -618,13 +618,13 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
 
     if (env->spr[SPR_BOOKE_PID1] &&
         ppcemb_tlb_check(env, tlb, raddr, address,
-                         env->spr[SPR_BOOKE_PID1], i) >= 0) {
+                         env->spr[SPR_BOOKE_PID1], i)) {
         goto found_tlb;
     }
 
     if (env->spr[SPR_BOOKE_PID2] &&
         ppcemb_tlb_check(env, tlb, raddr, address,
-                         env->spr[SPR_BOOKE_PID2], i) >= 0) {
+                         env->spr[SPR_BOOKE_PID2], i)) {
         goto found_tlb;
     }
 
-- 
2.30.9


