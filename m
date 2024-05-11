Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC528C2E9B
	for <lists+qemu-devel@lfdr.de>; Sat, 11 May 2024 03:49:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5bpf-00070l-FA; Fri, 10 May 2024 21:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5bov-00059b-76; Fri, 10 May 2024 21:46:41 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5bol-0003aY-JA; Fri, 10 May 2024 21:46:34 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4442C4E6777;
 Sat, 11 May 2024 03:46:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Z8B_8QX-DtKv; Sat, 11 May 2024 03:46:07 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 553244E677A; Sat, 11 May 2024 03:46:07 +0200 (CEST)
Message-Id: <9ff2ff4ae75e69d4086976bfa8e312fb6c2d3476.1715390232.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715390232.git.balaton@eik.bme.hu>
References: <cover.1715390232.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 27/48] target/ppc/mmu_common.c: Transform ppc_jumbo_xlate()
 into ppc_6xx_xlate()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Sat, 11 May 2024 03:46:07 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

Now that only 6xx cases left in ppc_jumbo_xlate() we can change it
to ppc_6xx_xlate() also removing get_physical_address_wtlb().

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/internal.h   |  5 +----
 target/ppc/mmu_common.c | 38 ++++++++++++--------------------------
 2 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index ffdf6c075d..5b28e8f3b0 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -297,10 +297,7 @@ typedef struct mmu_ctx_t mmu_ctx_t;
 bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp,
                       int mmu_idx, bool guest_visible);
-int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
-                                     target_ulong eaddr,
-                                     MMUAccessType access_type, int type,
-                                     int mmu_idx);
+
 /* Software driven TLB helpers */
 int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
                                     int way, int is_code);
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 7829bd81ef..22c9894881 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1072,22 +1072,6 @@ void dump_mmu(CPUPPCState *env)
     }
 }
 
-int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
-                                     target_ulong eaddr,
-                                     MMUAccessType access_type, int type,
-                                     int mmu_idx)
-{
-    switch (env->mmu_model) {
-    case POWERPC_MMU_SOFT_6xx:
-        return mmu6xx_get_physical_address(env, ctx, eaddr, access_type, type);
-    case POWERPC_MMU_SOFT_4xx:
-        return mmu40x_get_physical_address(env, &ctx->raddr, &ctx->prot, eaddr,
-                                           access_type);
-    default:
-        cpu_abort(env_cpu(env), "Unknown or invalid MMU model\n");
-    }
-}
-
 static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong address,
                                          MMUAccessType access_type, int mmu_idx)
 {
@@ -1286,12 +1270,10 @@ static bool ppc_40x_xlate(PowerPCCPU *cpu, vaddr eaddr,
     return false;
 }
 
-/* Perform address translation */
-/* TODO: Split this by mmu_model. */
-static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
-                            MMUAccessType access_type,
-                            hwaddr *raddrp, int *psizep, int *protp,
-                            int mmu_idx, bool guest_visible)
+static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
+                          MMUAccessType access_type,
+                          hwaddr *raddrp, int *psizep, int *protp,
+                          int mmu_idx, bool guest_visible)
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
@@ -1313,8 +1295,10 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
         type = ACCESS_INT;
     }
 
-    ret = get_physical_address_wtlb(env, &ctx, eaddr, access_type,
-                                    type, mmu_idx);
+    ctx.prot = 0;
+    ctx.hash[0] = 0;
+    ctx.hash[1] = 0;
+    ret = mmu6xx_get_physical_address(env, &ctx, eaddr, access_type, type);
     if (ret == 0) {
         *raddrp = ctx.raddr;
         *protp = ctx.prot;
@@ -1458,14 +1442,16 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     case POWERPC_MMU_SOFT_4xx:
         return ppc_40x_xlate(cpu, eaddr, access_type, raddrp,
                              psizep, protp, mmu_idx, guest_visible);
+    case POWERPC_MMU_SOFT_6xx:
+        return ppc_6xx_xlate(cpu, eaddr, access_type, raddrp,
+                             psizep, protp, mmu_idx, guest_visible);
     case POWERPC_MMU_REAL:
         return ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep,
                                    protp);
     case POWERPC_MMU_MPC8xx:
         cpu_abort(env_cpu(&cpu->env), "MPC8xx MMU model is not implemented\n");
     default:
-        return ppc_jumbo_xlate(cpu, eaddr, access_type, raddrp,
-                               psizep, protp, mmu_idx, guest_visible);
+        cpu_abort(CPU(cpu), "Unknown or invalid MMU model\n");
     }
 }
 
-- 
2.30.9


