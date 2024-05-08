Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB338BF399
	for <lists+qemu-devel@lfdr.de>; Wed,  8 May 2024 02:23:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Uyn-0007p5-FC; Tue, 07 May 2024 20:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4Uxi-00072C-KB; Tue, 07 May 2024 20:15:16 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4Uxf-0003jQ-R8; Tue, 07 May 2024 20:15:10 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D8F0A4E65CA;
 Wed, 08 May 2024 02:15:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id v0lBtLJ5nfiM; Wed,  8 May 2024 02:15:03 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E9D654E65C9; Wed, 08 May 2024 02:15:03 +0200 (CEST)
Message-Id: <0a55610186f38c9dbbad8cc948af3986d945e796.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715125376.git.balaton@eik.bme.hu>
References: <cover.1715125376.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 11/33] target/ppc/mmu_common.c: Move some debug logging
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Wed, 08 May 2024 02:15:03 +0200 (CEST)
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

Move the debug logging within ppc6xx_tlb_check() from after its only
call to simplify the caller.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 55 +++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 9d337a73ba..b2f2cee1a8 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -225,17 +225,14 @@ static int ppc6xx_tlb_check(CPUPPCState *env, mmu_ctx_t *ctx,
                       access_type == MMU_INST_FETCH ? 'I' : 'D');
         switch (ppc6xx_tlb_pte_check(ctx, tlb->pte0, tlb->pte1,
                                      0, access_type)) {
-        case -3:
-            /* TLB inconsistency */
-            return -1;
         case -2:
             /* Access violation */
             ret = -2;
             best = nr;
             break;
-        case -1:
+        case -1: /* No match */
+        case -3: /* TLB inconsistency */
         default:
-            /* No match */
             break;
         case 0:
             /* access granted */
@@ -251,14 +248,37 @@ static int ppc6xx_tlb_check(CPUPPCState *env, mmu_ctx_t *ctx,
         }
     }
     if (best != -1) {
-    done:
+done:
         qemu_log_mask(CPU_LOG_MMU, "found TLB at addr " HWADDR_FMT_plx
                       " prot=%01x ret=%d\n",
                       ctx->raddr & TARGET_PAGE_MASK, ctx->prot, ret);
         /* Update page flags */
         pte_update_flags(ctx, &env->tlb.tlb6[best].pte1, ret, access_type);
     }
+#if defined(DUMP_PAGE_TABLES)
+        if (qemu_loglevel_mask(CPU_LOG_MMU)) {
+            CPUState *cs = env_cpu(env);
+            PowerPCCPU *cpu = env_archcpu(env);
+            hwaddr curaddr;
+            uint32_t a0, a1, a2, a3;
 
+            qemu_log("Page table: " HWADDR_FMT_plx " len " HWADDR_FMT_plx "\n",
+                     ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu) + 0x80);
+            for (curaddr = ppc_hash32_hpt_base(cpu);
+                 curaddr < (ppc_hash32_hpt_base(cpu)
+                            + ppc_hash32_hpt_mask(cpu) + 0x80);
+                 curaddr += 16) {
+                a0 = ldl_phys(cs->as, curaddr);
+                a1 = ldl_phys(cs->as, curaddr + 4);
+                a2 = ldl_phys(cs->as, curaddr + 8);
+                a3 = ldl_phys(cs->as, curaddr + 12);
+                if (a0 != 0 || a1 != 0 || a2 != 0 || a3 != 0) {
+                    qemu_log(HWADDR_FMT_plx ": %08x %08x %08x %08x\n",
+                             curaddr, a0, a1, a2, a3);
+                }
+            }
+        }
+#endif
     return ret;
 }
 
@@ -420,29 +440,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
         ctx->raddr = (hwaddr)-1ULL;
         /* Software TLB search */
         ret = ppc6xx_tlb_check(env, ctx, eaddr, access_type);
-#if defined(DUMP_PAGE_TABLES)
-        if (qemu_loglevel_mask(CPU_LOG_MMU)) {
-            CPUState *cs = env_cpu(env);
-            hwaddr curaddr;
-            uint32_t a0, a1, a2, a3;
-
-            qemu_log("Page table: " HWADDR_FMT_plx " len " HWADDR_FMT_plx "\n",
-                     ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu) + 0x80);
-            for (curaddr = ppc_hash32_hpt_base(cpu);
-                 curaddr < (ppc_hash32_hpt_base(cpu)
-                            + ppc_hash32_hpt_mask(cpu) + 0x80);
-                 curaddr += 16) {
-                a0 = ldl_phys(cs->as, curaddr);
-                a1 = ldl_phys(cs->as, curaddr + 4);
-                a2 = ldl_phys(cs->as, curaddr + 8);
-                a3 = ldl_phys(cs->as, curaddr + 12);
-                if (a0 != 0 || a1 != 0 || a2 != 0 || a3 != 0) {
-                    qemu_log(HWADDR_FMT_plx ": %08x %08x %08x %08x\n",
-                             curaddr, a0, a1, a2, a3);
-                }
-            }
-        }
-#endif
     } else {
         qemu_log_mask(CPU_LOG_MMU, "direct store...\n");
         /* Direct-store segment : absolutely *BUGGY* for now */
-- 
2.30.9


