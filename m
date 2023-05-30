Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 391867161F6
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:32:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zOs-0001Rs-8t; Tue, 30 May 2023 09:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3zOZ-00015J-1F; Tue, 30 May 2023 09:28:16 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3zOU-0002BS-Tr; Tue, 30 May 2023 09:28:14 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 8A28174635C;
 Tue, 30 May 2023 15:28:08 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 63C2A746335; Tue, 30 May 2023 15:28:08 +0200 (CEST)
Message-Id: <b21f11ae20e8a8c2e8b5d943f2bff12b5356005a.1685448535.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1685448535.git.balaton@eik.bme.hu>
References: <cover.1685448535.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 2/7] target/ppc: Remove "ext" parameter of ppcemb_tlb_check()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue, 30 May 2023 15:28:08 +0200 (CEST)
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

This is only used by one caller so simplify function by removing this
parameter and move the operation to the single place where it's used.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/cpu.h        |  3 +--
 target/ppc/mmu_common.c | 21 +++++++++------------
 target/ppc/mmu_helper.c |  2 +-
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0f9f2e1a0c..5cd1b442b4 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1430,8 +1430,7 @@ int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb,
                             uint32_t pid);
 int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
                             hwaddr *raddrp,
-                            target_ulong address, uint32_t pid, int ext,
-                            int i);
+                            target_ulong address, uint32_t pid, int i);
 hwaddr booke206_tlb_to_page_size(CPUPPCState *env,
                                         ppcmas_tlb_t *tlb);
 #endif
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 7235a4befe..21a353c51a 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -491,8 +491,7 @@ static int get_segment_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
 /* Generic TLB check function for embedded PowerPC implementations */
 int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
                             hwaddr *raddrp,
-                            target_ulong address, uint32_t pid, int ext,
-                            int i)
+                            target_ulong address, uint32_t pid, int i)
 {
     target_ulong mask;
 
@@ -514,11 +513,6 @@ int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
         return -1;
     }
     *raddrp = (tlb->RPN & mask) | (address & ~mask);
-    if (ext) {
-        /* Extend the physical address to 36 bits */
-        *raddrp |= (uint64_t)(tlb->RPN & 0xF) << 32;
-    }
-
     return 0;
 }
 
@@ -536,7 +530,7 @@ static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     for (i = 0; i < env->nb_tlb; i++) {
         tlb = &env->tlb.tlbe[i];
         if (ppcemb_tlb_check(env, tlb, &raddr, address,
-                             env->spr[SPR_40x_PID], 0, i) < 0) {
+                             env->spr[SPR_40x_PID], i) < 0) {
             continue;
         }
         zsel = (tlb->attr >> 4) & 0xF;
@@ -598,20 +592,23 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
     int prot2;
 
     if (ppcemb_tlb_check(env, tlb, raddr, address,
-                         env->spr[SPR_BOOKE_PID],
-                         !env->nb_pids, i) >= 0) {
+                         env->spr[SPR_BOOKE_PID], i) >= 0) {
+        if (!env->nb_pids) {
+            /* Extend the physical address to 36 bits */
+            *raddr |= (uint64_t)(tlb->RPN & 0xF) << 32;
+        }
         goto found_tlb;
     }
 
     if (env->spr[SPR_BOOKE_PID1] &&
         ppcemb_tlb_check(env, tlb, raddr, address,
-                         env->spr[SPR_BOOKE_PID1], 0, i) >= 0) {
+                         env->spr[SPR_BOOKE_PID1], i) >= 0) {
         goto found_tlb;
     }
 
     if (env->spr[SPR_BOOKE_PID2] &&
         ppcemb_tlb_check(env, tlb, raddr, address,
-                         env->spr[SPR_BOOKE_PID2], 0, i) >= 0) {
+                         env->spr[SPR_BOOKE_PID2], i) >= 0) {
         goto found_tlb;
     }
 
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index c0c71a68ff..e7275eaec1 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -124,7 +124,7 @@ static int ppcemb_tlb_search(CPUPPCState *env, target_ulong address,
     ret = -1;
     for (i = 0; i < env->nb_tlb; i++) {
         tlb = &env->tlb.tlbe[i];
-        if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, 0, i) == 0) {
+        if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, i) == 0) {
             ret = i;
             break;
         }
-- 
2.30.9


