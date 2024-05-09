Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5948C07BF
	for <lists+qemu-devel@lfdr.de>; Thu,  9 May 2024 01:38:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4qpq-0003SU-Sn; Wed, 08 May 2024 19:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qpn-0003RI-Sh; Wed, 08 May 2024 19:36:27 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qpm-0002ak-7F; Wed, 08 May 2024 19:36:27 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AEE564E65BB;
 Thu, 09 May 2024 01:36:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ELY82SMat7FM; Thu,  9 May 2024 01:36:22 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BE2A84E65CE; Thu, 09 May 2024 01:36:22 +0200 (CEST)
Message-Id: <c70c4716eb59944e8eb810c2b1d57dc715ac551e.1715209155.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715209155.git.balaton@eik.bme.hu>
References: <cover.1715209155.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 19/33] target/ppc/mmu_common.c: Don't use mmu_ctx_t for
 mmu40x_get_physical_address()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 09 May 2024 01:36:22 +0200 (CEST)
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

mmu40x_get_physical_address() only uses the raddr and prot fields from
mmu_ctx_t. Pass these directly instead of using a ctx struct.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 6570b280ca..c5ef02f05e 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -519,20 +519,19 @@ int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid)
     return -1;
 }
 
-static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
-                                       target_ulong address,
+static int mmu40x_get_physical_address(CPUPPCState *env, hwaddr *raddr,
+                                       int *prot, target_ulong address,
                                        MMUAccessType access_type)
 {
     ppcemb_tlb_t *tlb;
-    hwaddr raddr;
     int i, ret, zsel, zpr, pr;
 
     ret = -1;
-    raddr = (hwaddr)-1ULL;
+    *prot = 0;
     pr = FIELD_EX64(env->msr, MSR, PR);
     for (i = 0; i < env->nb_tlb; i++) {
         tlb = &env->tlb.tlbe[i];
-        if (!ppcemb_tlb_check(env, tlb, &raddr, address,
+        if (!ppcemb_tlb_check(env, tlb, raddr, address,
                               env->spr[SPR_40x_PID], i)) {
             continue;
         }
@@ -550,40 +549,34 @@ static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
             /* fall through */
         case 0x3:
             /* All accesses granted */
-            ctx->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+            *prot = PAGE_RWX;
             ret = 0;
             break;
+
         case 0x0:
             if (pr != 0) {
                 /* Raise Zone protection fault.  */
                 env->spr[SPR_40x_ESR] = 1 << 22;
-                ctx->prot = 0;
+                *prot = 0;
                 ret = -2;
                 break;
             }
             /* fall through */
         case 0x1:
-        check_perms:
+check_perms:
             /* Check from TLB entry */
-            ctx->prot = tlb->prot;
-            ret = check_prot(ctx->prot, access_type);
+            *prot = tlb->prot;
+            ret = check_prot(*prot, access_type);
             if (ret == -2) {
                 env->spr[SPR_40x_ESR] = 0;
             }
             break;
         }
-        if (ret >= 0) {
-            ctx->raddr = raddr;
-            qemu_log_mask(CPU_LOG_MMU, "%s: access granted " TARGET_FMT_lx
-                          " => " HWADDR_FMT_plx
-                          " %d %d\n", __func__, address, ctx->raddr, ctx->prot,
-                          ret);
-            return 0;
-        }
     }
-    qemu_log_mask(CPU_LOG_MMU, "%s: access refused " TARGET_FMT_lx
-                  " => " HWADDR_FMT_plx " %d %d\n",
-                  __func__, address, raddr, ctx->prot, ret);
+    qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " => "
+                  HWADDR_FMT_plx " %d %d\n",  __func__,
+                  ret < 0 ? "refused" : "granted", address,
+                  ret < 0 ? 0 : *raddr, *prot, ret);
 
     return ret;
 }
@@ -1171,7 +1164,8 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
     case POWERPC_MMU_SOFT_6xx:
         return mmu6xx_get_physical_address(env, ctx, eaddr, access_type, type);
     case POWERPC_MMU_SOFT_4xx:
-        return mmu40x_get_physical_address(env, ctx, eaddr, access_type);
+        return mmu40x_get_physical_address(env, &ctx->raddr, &ctx->prot, eaddr,
+                                           access_type);
     case POWERPC_MMU_REAL:
         cpu_abort(env_cpu(env),
                   "PowerPC in real mode do not do any translation\n");
-- 
2.30.9


