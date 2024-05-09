Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF9E8C174F
	for <lists+qemu-devel@lfdr.de>; Thu,  9 May 2024 22:27:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5ALF-0000Ng-Se; Thu, 09 May 2024 16:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AKz-0000Eu-V7; Thu, 09 May 2024 16:25:59 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AKy-00015N-4n; Thu, 09 May 2024 16:25:57 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 83F434E6426;
 Thu, 09 May 2024 22:25:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 1cIMqKxd4_Ce; Thu,  9 May 2024 22:25:52 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 996D84E600E; Thu, 09 May 2024 22:25:52 +0200 (CEST)
Message-Id: <39b356de922f6bac4a3f75f16d7ef819d4d36bc4.1715285340.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715285340.git.balaton@eik.bme.hu>
References: <cover.1715285340.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 18/32] target/ppc/mmu_common.c: Don't use mmu_ctx_t in
 mmubooke206_get_physical_address()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 09 May 2024 22:25:52 +0200 (CEST)
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

mmubooke206_get_physical_address() only uses the raddr and prot fields
from mmu_ctx_t. Pass these directly instead of using a ctx struct.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 12dac9e63a..004ea2111d 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -836,27 +836,22 @@ found_tlb:
     return access_type == MMU_INST_FETCH ? -3 : -2;
 }
 
-static int mmubooke206_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
-                                            target_ulong address,
+static int mmubooke206_get_physical_address(CPUPPCState *env, hwaddr *raddr,
+                                            int *prot, target_ulong address,
                                             MMUAccessType access_type,
                                             int mmu_idx)
 {
     ppcmas_tlb_t *tlb;
-    hwaddr raddr;
-    int i, j, ret;
-
-    ret = -1;
-    raddr = (hwaddr)-1ULL;
+    int i, j, ret = -1;
 
     for (i = 0; i < BOOKE206_MAX_TLBN; i++) {
         int ways = booke206_tlb_ways(env, i);
-
         for (j = 0; j < ways; j++) {
             tlb = booke206_get_tlbm(env, i, address, j);
             if (!tlb) {
                 continue;
             }
-            ret = mmubooke206_check_tlb(env, tlb, &raddr, &ctx->prot, address,
+            ret = mmubooke206_check_tlb(env, tlb, raddr, prot, address,
                                         access_type, mmu_idx);
             if (ret != -1) {
                 goto found_tlb;
@@ -866,17 +861,10 @@ static int mmubooke206_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
 
 found_tlb:
 
-    if (ret >= 0) {
-        ctx->raddr = raddr;
-         qemu_log_mask(CPU_LOG_MMU, "%s: access granted " TARGET_FMT_lx
-                       " => " HWADDR_FMT_plx " %d %d\n", __func__, address,
-                       ctx->raddr, ctx->prot, ret);
-    } else {
-         qemu_log_mask(CPU_LOG_MMU, "%s: access refused " TARGET_FMT_lx
-                       " => " HWADDR_FMT_plx " %d %d\n", __func__, address,
-                       raddr, ctx->prot, ret);
-    }
-
+    qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " => "
+                  HWADDR_FMT_plx " %d %d\n", __func__,
+                  ret < 0 ? "refused" : "granted", address,
+                  ret < 0 ? -1 : *raddr, ret == -1 ? 0 : *prot, ret);
     return ret;
 }
 
@@ -1135,8 +1123,8 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
         return mmubooke_get_physical_address(env, &ctx->raddr, &ctx->prot,
                                              eaddr, access_type);
     } else if (env->mmu_model == POWERPC_MMU_BOOKE206) {
-        return mmubooke206_get_physical_address(env, ctx, eaddr, access_type,
-                                                mmu_idx);
+        return mmubooke206_get_physical_address(env, &ctx->raddr, &ctx->prot,
+                                                eaddr, access_type, mmu_idx);
     }
 
     real_mode = (type == ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR, IR)
-- 
2.30.9


