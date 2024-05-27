Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC278CF6A7
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 01:16:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN3v-0003xn-Eh; Sun, 26 May 2024 19:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN3t-0003v1-EC; Sun, 26 May 2024 19:13:57 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN3p-0003b4-JL; Sun, 26 May 2024 19:13:56 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7DC714E602F;
 Mon, 27 May 2024 01:12:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id pSP3jqNBiyl5; Mon, 27 May 2024 01:12:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 929FF4E6030; Mon, 27 May 2024 01:12:43 +0200 (CEST)
Message-Id: <3c507fa202f01f913c40fab7a53ef9f68c446e4f.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 08/43] target/ppc/mmu_common.c: Simplify ppc6xx_tlb_pte_check()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:12:43 +0200 (CEST)
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

Invert conditions to avoid deep nested ifs and return early instead.
Remove some obvious comments that don't add more clarity.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 43 ++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index a5ae11394d..28adb3ca10 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -99,31 +99,26 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                                 MMUAccessType access_type)
 {
     /* Check validity and table match */
-    if (pte_is_valid(pte0) && ((pte0 >> 6) & 1) == pteh) {
-        /* Check vsid & api */
-        if ((pte0 & PTE_PTEM_MASK) == ctx->ptem) {
-            if (ctx->raddr != (hwaddr)-1ULL) {
-                /* all matches should have equal RPN, WIMG & PP */
-                if ((ctx->raddr & PTE_CHECK_MASK) != (pte1 & PTE_CHECK_MASK)) {
-                    qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
-                    return -3;
-                }
-            }
-            /* Keep the matching PTE information */
-            ctx->raddr = pte1;
-            ctx->prot = ppc_hash32_prot(ctx->key, pte1 & HPTE32_R_PP, ctx->nx);
-            if (check_prot_access_type(ctx->prot, access_type)) {
-                /* Access granted */
-                qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
-                return 0;
-            } else {
-                /* Access right violation */
-                qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
-                return -2;
-            }
-        }
+    if (!pte_is_valid(pte0) || ((pte0 >> 6) & 1) != pteh ||
+        (pte0 & PTE_PTEM_MASK) != ctx->ptem) {
+        return -1;
+    }
+    /* all matches should have equal RPN, WIMG & PP */
+    if (ctx->raddr != (hwaddr)-1ULL &&
+        (ctx->raddr & PTE_CHECK_MASK) != (pte1 & PTE_CHECK_MASK)) {
+        qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
+        return -3;
+    }
+    /* Keep the matching PTE information */
+    ctx->raddr = pte1;
+    ctx->prot = ppc_hash32_prot(ctx->key, pte1 & HPTE32_R_PP, ctx->nx);
+    if (check_prot_access_type(ctx->prot, access_type)) {
+        qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
+        return 0;
+    } else {
+        qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
+        return -2;
     }
-    return -1;
 }
 
 static int pte_update_flags(mmu_ctx_t *ctx, target_ulong *pte1p,
-- 
2.30.9


