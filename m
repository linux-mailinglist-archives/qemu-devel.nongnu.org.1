Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FE78C3948
	for <lists+qemu-devel@lfdr.de>; Mon, 13 May 2024 01:32:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Id2-0002OY-IN; Sun, 12 May 2024 19:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Icc-0001yP-IT; Sun, 12 May 2024 19:28:50 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Ica-0000QU-GD; Sun, 12 May 2024 19:28:50 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A87694E6786;
 Mon, 13 May 2024 01:28:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Mi1xrfZql26F; Mon, 13 May 2024 01:28:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B8D134E6783; Mon, 13 May 2024 01:28:18 +0200 (CEST)
Message-Id: <6d51f7ba7f352eb27abf3112fdee7a7805804d58.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715555763.git.balaton@eik.bme.hu>
References: <cover.1715555763.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 44/61] target/ppc/mmu_common.c: Remove hash field from
 mmu_ctx_t
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 13 May 2024 01:28:18 +0200 (CEST)
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

Return hash value via a parameter and remove it from mmu_ctx.t.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 07c127d673..ccacc70ba6 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -41,7 +41,6 @@
 typedef struct {
     hwaddr raddr;      /* Real address             */
     int prot;          /* Protection bits          */
-    hwaddr hash[2];    /* Pagetable hash values    */
     target_ulong ptem; /* Virtual segment ID | API */
     int key;           /* Access key               */
     int nx;            /* Non-execute area         */
@@ -316,7 +315,7 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
 }
 
 static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
-                                       target_ulong eaddr,
+                                       target_ulong eaddr, hwaddr *hashp,
                                        MMUAccessType access_type, int type)
 {
     PowerPCCPU *cpu = env_archcpu(env);
@@ -364,8 +363,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
         qemu_log_mask(CPU_LOG_MMU, "htab_base " HWADDR_FMT_plx " htab_mask "
                       HWADDR_FMT_plx " hash " HWADDR_FMT_plx "\n",
                       ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu), hash);
-        ctx->hash[0] = hash;
-        ctx->hash[1] = ~hash;
+        *hashp = hash;
 
         /* Initialize real address with an invalid value */
         ctx->raddr = (hwaddr)-1ULL;
@@ -746,8 +744,8 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     mmu_ctx_t ctx;
-    int type;
-    int ret;
+    hwaddr hash = 0; /* init to 0 to avoid used uninit warning */
+    int type, ret;
 
     if (ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep, protp)) {
         return true;
@@ -764,9 +762,8 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
     }
 
     ctx.prot = 0;
-    ctx.hash[0] = 0;
-    ctx.hash[1] = 0;
-    ret = mmu6xx_get_physical_address(env, &ctx, eaddr, access_type, type);
+    ret = mmu6xx_get_physical_address(env, &ctx, eaddr, &hash,
+                                      access_type, type);
     if (ret == 0) {
         *raddrp = ctx.raddr;
         *protp = ctx.prot;
@@ -819,9 +816,9 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
 tlb_miss:
             env->error_code |= ctx.key << 19;
             env->spr[SPR_HASH1] = ppc_hash32_hpt_base(cpu) +
-                                  get_pteg_offset32(cpu, ctx.hash[0]);
+                                  get_pteg_offset32(cpu, hash);
             env->spr[SPR_HASH2] = ppc_hash32_hpt_base(cpu) +
-                                  get_pteg_offset32(cpu, ctx.hash[1]);
+                                  get_pteg_offset32(cpu, ~hash);
             break;
         case -2:
             /* Access rights violation */
-- 
2.30.9


