Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 590228C175E
	for <lists+qemu-devel@lfdr.de>; Thu,  9 May 2024 22:27:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5ALU-0000b1-E3; Thu, 09 May 2024 16:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5ALR-0000UP-4v; Thu, 09 May 2024 16:26:25 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5ALP-00017f-Gn; Thu, 09 May 2024 16:26:24 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DD7594E65D5;
 Thu, 09 May 2024 22:26:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id iwMQT0y0qW6a; Thu,  9 May 2024 22:26:00 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 00EE24E65D7; Thu, 09 May 2024 22:25:59 +0200 (CEST)
Message-Id: <550c2a5083e2cbdd78e78bafda3ba91a86c053bc.1715285340.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715285340.git.balaton@eik.bme.hu>
References: <cover.1715285340.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 25/32] target/ppc/mmu_common.c: Simplify ppc_booke_xlate()
 part 2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 09 May 2024 22:25:59 +0200 (CEST)
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

Merge the code fetch and data access cases in a common switch.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 52 ++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 87f28efbf9..5f5ac1f2e9 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1165,45 +1165,33 @@ static bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr,
 
     log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
     env->error_code = 0;
-    if (ret == -1) {
+    switch (ret) {
+    case -1:
+        /* No matches in page tables or TLB */
         if (env->mmu_model == POWERPC_MMU_BOOKE206) {
             booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
         }
-    }
-    if (access_type == MMU_INST_FETCH) {
-        switch (ret) {
-        case -1:
-            /* No matches in page tables or TLB */
-            cs->exception_index = POWERPC_EXCP_ITLB;
-            env->spr[SPR_BOOKE_DEAR] = eaddr;
-            env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
-            break;
-        case -2:
-            /* Access rights violation */
-            cs->exception_index = POWERPC_EXCP_ISI;
-            break;
-        case -3:
-            /* No execute protection violation */
-            cs->exception_index = POWERPC_EXCP_ISI;
-            env->spr[SPR_BOOKE_ESR] = 0;
-            break;
-        }
-    } else {
-        switch (ret) {
-        case -1:
-            /* No matches in page tables or TLB */
-            cs->exception_index = POWERPC_EXCP_DTLB;
-            env->spr[SPR_BOOKE_DEAR] = eaddr;
-            env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
-            break;
-        case -2:
-            /* Access rights violation */
-            cs->exception_index = POWERPC_EXCP_DSI;
+        cs->exception_index = (access_type == MMU_INST_FETCH) ?
+                              POWERPC_EXCP_ITLB : POWERPC_EXCP_DTLB;
+        env->spr[SPR_BOOKE_DEAR] = eaddr;
+        env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
+        break;
+    case -2:
+        /* Access rights violation */
+        cs->exception_index = (access_type == MMU_INST_FETCH) ?
+                              POWERPC_EXCP_ISI : POWERPC_EXCP_DSI;
+        if (access_type != MMU_INST_FETCH) {
             env->spr[SPR_BOOKE_DEAR] = eaddr;
             env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
-            break;
         }
+        break;
+    case -3:
+        /* No execute protection violation */
+        cs->exception_index = POWERPC_EXCP_ISI;
+        env->spr[SPR_BOOKE_ESR] = 0;
+        break;
     }
+
     return false;
 }
 
-- 
2.30.9


