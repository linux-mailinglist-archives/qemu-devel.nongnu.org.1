Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B08FE8C1751
	for <lists+qemu-devel@lfdr.de>; Thu,  9 May 2024 22:27:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5ALF-0000Na-Ni; Thu, 09 May 2024 16:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AKy-0000Da-PP; Thu, 09 May 2024 16:25:57 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AKu-000140-SU; Thu, 09 May 2024 16:25:56 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 518DA4E65CE;
 Thu, 09 May 2024 22:25:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id JL1UlSfqjDvR; Thu,  9 May 2024 22:25:48 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5A7334E65DC; Thu, 09 May 2024 22:25:48 +0200 (CEST)
Message-Id: <afae601465f7753a1b2d1b1b6834c321d61c2fb9.1715285340.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715285340.git.balaton@eik.bme.hu>
References: <cover.1715285340.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 14/32] target/ppc/mmu_common.c: Deindent ppc_jumbo_xlate()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 09 May 2024 22:25:48 +0200 (CEST)
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

Instead of putting a large block of code in an if, invert the
condition and return early to be able to deindent the code block.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 319 ++++++++++++++++++++--------------------
 1 file changed, 159 insertions(+), 160 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 124148b3da..f40481b4b1 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1264,187 +1264,186 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
         *protp = ctx.prot;
         *psizep = TARGET_PAGE_BITS;
         return true;
+    } else if (!guest_visible) {
+        return false;
     }
 
-    if (guest_visible) {
-        log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
-        if (type == ACCESS_CODE) {
-            switch (ret) {
-            case -1:
-                /* No matches in page tables or TLB */
-                switch (env->mmu_model) {
-                case POWERPC_MMU_SOFT_6xx:
-                    cs->exception_index = POWERPC_EXCP_IFTLB;
-                    env->error_code = 1 << 18;
-                    env->spr[SPR_IMISS] = eaddr;
-                    env->spr[SPR_ICMP] = 0x80000000 | ctx.ptem;
-                    goto tlb_miss;
-                case POWERPC_MMU_SOFT_4xx:
-                    cs->exception_index = POWERPC_EXCP_ITLB;
-                    env->error_code = 0;
-                    env->spr[SPR_40x_DEAR] = eaddr;
-                    env->spr[SPR_40x_ESR] = 0x00000000;
-                    break;
-                case POWERPC_MMU_BOOKE206:
-                    booke206_update_mas_tlb_miss(env, eaddr, 2, mmu_idx);
-                    /* fall through */
-                case POWERPC_MMU_BOOKE:
-                    cs->exception_index = POWERPC_EXCP_ITLB;
-                    env->error_code = 0;
-                    env->spr[SPR_BOOKE_DEAR] = eaddr;
-                    env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, MMU_DATA_LOAD);
-                    break;
-                case POWERPC_MMU_REAL:
-                    cpu_abort(cs, "PowerPC in real mode should never raise "
-                              "any MMU exceptions\n");
-                default:
-                    cpu_abort(cs, "Unknown or invalid MMU model\n");
-                }
+    log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
+    if (type == ACCESS_CODE) {
+        switch (ret) {
+        case -1:
+            /* No matches in page tables or TLB */
+            switch (env->mmu_model) {
+            case POWERPC_MMU_SOFT_6xx:
+                cs->exception_index = POWERPC_EXCP_IFTLB;
+                env->error_code = 1 << 18;
+                env->spr[SPR_IMISS] = eaddr;
+                env->spr[SPR_ICMP] = 0x80000000 | ctx.ptem;
+                goto tlb_miss;
+            case POWERPC_MMU_SOFT_4xx:
+                cs->exception_index = POWERPC_EXCP_ITLB;
+                env->error_code = 0;
+                env->spr[SPR_40x_DEAR] = eaddr;
+                env->spr[SPR_40x_ESR] = 0x00000000;
                 break;
-            case -2:
-                /* Access rights violation */
-                cs->exception_index = POWERPC_EXCP_ISI;
-                if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
-                    (env->mmu_model == POWERPC_MMU_BOOKE206)) {
-                    env->error_code = 0;
-                } else {
-                    env->error_code = 0x08000000;
-                }
+            case POWERPC_MMU_BOOKE206:
+                booke206_update_mas_tlb_miss(env, eaddr, 2, mmu_idx);
+                /* fall through */
+            case POWERPC_MMU_BOOKE:
+                cs->exception_index = POWERPC_EXCP_ITLB;
+                env->error_code = 0;
+                env->spr[SPR_BOOKE_DEAR] = eaddr;
+                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, MMU_DATA_LOAD);
                 break;
-            case -3:
-                /* No execute protection violation */
-                if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
-                    (env->mmu_model == POWERPC_MMU_BOOKE206)) {
-                    env->spr[SPR_BOOKE_ESR] = 0x00000000;
-                    env->error_code = 0;
+            case POWERPC_MMU_REAL:
+                cpu_abort(cs, "PowerPC in real mode should never raise "
+                              "any MMU exceptions\n");
+            default:
+                cpu_abort(cs, "Unknown or invalid MMU model\n");
+            }
+            break;
+        case -2:
+            /* Access rights violation */
+            cs->exception_index = POWERPC_EXCP_ISI;
+            if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
+                (env->mmu_model == POWERPC_MMU_BOOKE206)) {
+                env->error_code = 0;
+            } else {
+                env->error_code = 0x08000000;
+            }
+            break;
+        case -3:
+            /* No execute protection violation */
+            if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
+                (env->mmu_model == POWERPC_MMU_BOOKE206)) {
+                env->spr[SPR_BOOKE_ESR] = 0x00000000;
+                env->error_code = 0;
+            } else {
+                env->error_code = 0x10000000;
+            }
+            cs->exception_index = POWERPC_EXCP_ISI;
+            break;
+        case -4:
+            /* Direct store exception */
+            /* No code fetch is allowed in direct-store areas */
+            cs->exception_index = POWERPC_EXCP_ISI;
+            if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
+                (env->mmu_model == POWERPC_MMU_BOOKE206)) {
+                env->error_code = 0;
+            } else {
+                env->error_code = 0x10000000;
+            }
+            break;
+        }
+    } else {
+        switch (ret) {
+        case -1:
+            /* No matches in page tables or TLB */
+            switch (env->mmu_model) {
+            case POWERPC_MMU_SOFT_6xx:
+                if (access_type == MMU_DATA_STORE) {
+                    cs->exception_index = POWERPC_EXCP_DSTLB;
+                    env->error_code = 1 << 16;
                 } else {
-                    env->error_code = 0x10000000;
+                    cs->exception_index = POWERPC_EXCP_DLTLB;
+                    env->error_code = 0;
                 }
-                cs->exception_index = POWERPC_EXCP_ISI;
+                env->spr[SPR_DMISS] = eaddr;
+                env->spr[SPR_DCMP] = 0x80000000 | ctx.ptem;
+            tlb_miss:
+                env->error_code |= ctx.key << 19;
+                env->spr[SPR_HASH1] = ppc_hash32_hpt_base(cpu) +
+                  get_pteg_offset32(cpu, ctx.hash[0]);
+                env->spr[SPR_HASH2] = ppc_hash32_hpt_base(cpu) +
+                  get_pteg_offset32(cpu, ctx.hash[1]);
                 break;
-            case -4:
-                /* Direct store exception */
-                /* No code fetch is allowed in direct-store areas */
-                cs->exception_index = POWERPC_EXCP_ISI;
-                if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
-                    (env->mmu_model == POWERPC_MMU_BOOKE206)) {
-                    env->error_code = 0;
+            case POWERPC_MMU_SOFT_4xx:
+                cs->exception_index = POWERPC_EXCP_DTLB;
+                env->error_code = 0;
+                env->spr[SPR_40x_DEAR] = eaddr;
+                if (access_type == MMU_DATA_STORE) {
+                    env->spr[SPR_40x_ESR] = 0x00800000;
                 } else {
-                    env->error_code = 0x10000000;
+                    env->spr[SPR_40x_ESR] = 0x00000000;
                 }
                 break;
-            }
-        } else {
-            switch (ret) {
-            case -1:
-                /* No matches in page tables or TLB */
-                switch (env->mmu_model) {
-                case POWERPC_MMU_SOFT_6xx:
-                    if (access_type == MMU_DATA_STORE) {
-                        cs->exception_index = POWERPC_EXCP_DSTLB;
-                        env->error_code = 1 << 16;
-                    } else {
-                        cs->exception_index = POWERPC_EXCP_DLTLB;
-                        env->error_code = 0;
-                    }
-                    env->spr[SPR_DMISS] = eaddr;
-                    env->spr[SPR_DCMP] = 0x80000000 | ctx.ptem;
-                tlb_miss:
-                    env->error_code |= ctx.key << 19;
-                    env->spr[SPR_HASH1] = ppc_hash32_hpt_base(cpu) +
-                        get_pteg_offset32(cpu, ctx.hash[0]);
-                    env->spr[SPR_HASH2] = ppc_hash32_hpt_base(cpu) +
-                        get_pteg_offset32(cpu, ctx.hash[1]);
-                    break;
-                case POWERPC_MMU_SOFT_4xx:
-                    cs->exception_index = POWERPC_EXCP_DTLB;
-                    env->error_code = 0;
-                    env->spr[SPR_40x_DEAR] = eaddr;
-                    if (access_type == MMU_DATA_STORE) {
-                        env->spr[SPR_40x_ESR] = 0x00800000;
-                    } else {
-                        env->spr[SPR_40x_ESR] = 0x00000000;
-                    }
-                    break;
-                case POWERPC_MMU_BOOKE206:
-                    booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
-                    /* fall through */
-                case POWERPC_MMU_BOOKE:
-                    cs->exception_index = POWERPC_EXCP_DTLB;
-                    env->error_code = 0;
-                    env->spr[SPR_BOOKE_DEAR] = eaddr;
-                    env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
-                    break;
-                case POWERPC_MMU_REAL:
-                    cpu_abort(cs, "PowerPC in real mode should never raise "
+            case POWERPC_MMU_BOOKE206:
+                booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
+                /* fall through */
+            case POWERPC_MMU_BOOKE:
+                cs->exception_index = POWERPC_EXCP_DTLB;
+                env->error_code = 0;
+                env->spr[SPR_BOOKE_DEAR] = eaddr;
+                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
+                break;
+            case POWERPC_MMU_REAL:
+                cpu_abort(cs, "PowerPC in real mode should never raise "
                               "any MMU exceptions\n");
-                default:
-                    cpu_abort(cs, "Unknown or invalid MMU model\n");
+            default:
+                cpu_abort(cs, "Unknown or invalid MMU model\n");
+            }
+            break;
+        case -2:
+            /* Access rights violation */
+            cs->exception_index = POWERPC_EXCP_DSI;
+            env->error_code = 0;
+            if (env->mmu_model == POWERPC_MMU_SOFT_4xx) {
+                env->spr[SPR_40x_DEAR] = eaddr;
+                if (access_type == MMU_DATA_STORE) {
+                    env->spr[SPR_40x_ESR] |= 0x00800000;
+                }
+            } else if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
+                       (env->mmu_model == POWERPC_MMU_BOOKE206)) {
+                env->spr[SPR_BOOKE_DEAR] = eaddr;
+                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
+            } else {
+                env->spr[SPR_DAR] = eaddr;
+                if (access_type == MMU_DATA_STORE) {
+                    env->spr[SPR_DSISR] = 0x0A000000;
+                } else {
+                    env->spr[SPR_DSISR] = 0x08000000;
                 }
+            }
+            break;
+        case -4:
+            /* Direct store exception */
+            switch (type) {
+            case ACCESS_FLOAT:
+                /* Floating point load/store */
+                cs->exception_index = POWERPC_EXCP_ALIGN;
+                env->error_code = POWERPC_EXCP_ALIGN_FP;
+                env->spr[SPR_DAR] = eaddr;
                 break;
-            case -2:
-                /* Access rights violation */
+            case ACCESS_RES:
+                /* lwarx, ldarx or stwcx. */
                 cs->exception_index = POWERPC_EXCP_DSI;
                 env->error_code = 0;
-                if (env->mmu_model == POWERPC_MMU_SOFT_4xx) {
-                    env->spr[SPR_40x_DEAR] = eaddr;
-                    if (access_type == MMU_DATA_STORE) {
-                        env->spr[SPR_40x_ESR] |= 0x00800000;
-                    }
-                } else if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
-                           (env->mmu_model == POWERPC_MMU_BOOKE206)) {
-                    env->spr[SPR_BOOKE_DEAR] = eaddr;
-                    env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
+                env->spr[SPR_DAR] = eaddr;
+                if (access_type == MMU_DATA_STORE) {
+                    env->spr[SPR_DSISR] = 0x06000000;
                 } else {
-                    env->spr[SPR_DAR] = eaddr;
-                    if (access_type == MMU_DATA_STORE) {
-                        env->spr[SPR_DSISR] = 0x0A000000;
-                    } else {
-                        env->spr[SPR_DSISR] = 0x08000000;
-                    }
+                    env->spr[SPR_DSISR] = 0x04000000;
                 }
                 break;
-            case -4:
-                /* Direct store exception */
-                switch (type) {
-                case ACCESS_FLOAT:
-                    /* Floating point load/store */
-                    cs->exception_index = POWERPC_EXCP_ALIGN;
-                    env->error_code = POWERPC_EXCP_ALIGN_FP;
-                    env->spr[SPR_DAR] = eaddr;
-                    break;
-                case ACCESS_RES:
-                    /* lwarx, ldarx or stwcx. */
-                    cs->exception_index = POWERPC_EXCP_DSI;
-                    env->error_code = 0;
-                    env->spr[SPR_DAR] = eaddr;
-                    if (access_type == MMU_DATA_STORE) {
-                        env->spr[SPR_DSISR] = 0x06000000;
-                    } else {
-                        env->spr[SPR_DSISR] = 0x04000000;
-                    }
-                    break;
-                case ACCESS_EXT:
-                    /* eciwx or ecowx */
-                    cs->exception_index = POWERPC_EXCP_DSI;
-                    env->error_code = 0;
-                    env->spr[SPR_DAR] = eaddr;
-                    if (access_type == MMU_DATA_STORE) {
-                        env->spr[SPR_DSISR] = 0x06100000;
-                    } else {
-                        env->spr[SPR_DSISR] = 0x04100000;
-                    }
-                    break;
-                default:
-                    printf("DSI: invalid exception (%d)\n", ret);
-                    cs->exception_index = POWERPC_EXCP_PROGRAM;
-                    env->error_code =
-                        POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL;
-                    env->spr[SPR_DAR] = eaddr;
-                    break;
+            case ACCESS_EXT:
+                /* eciwx or ecowx */
+                cs->exception_index = POWERPC_EXCP_DSI;
+                env->error_code = 0;
+                env->spr[SPR_DAR] = eaddr;
+                if (access_type == MMU_DATA_STORE) {
+                    env->spr[SPR_DSISR] = 0x06100000;
+                } else {
+                    env->spr[SPR_DSISR] = 0x04100000;
                 }
                 break;
+            default:
+                printf("DSI: invalid exception (%d)\n", ret);
+                cs->exception_index = POWERPC_EXCP_PROGRAM;
+                env->error_code = POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL;
+                env->spr[SPR_DAR] = eaddr;
+                break;
             }
+            break;
         }
     }
     return false;
-- 
2.30.9


