Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F438C1774
	for <lists+qemu-devel@lfdr.de>; Thu,  9 May 2024 22:28:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5ALB-0000JE-M3; Thu, 09 May 2024 16:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AKs-00008V-DR; Thu, 09 May 2024 16:25:50 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AKp-00011E-3B; Thu, 09 May 2024 16:25:50 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EDABF4E65D4;
 Thu, 09 May 2024 22:25:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Yp5yoZFszfH1; Thu,  9 May 2024 22:25:41 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0B41D4E65D6; Thu, 09 May 2024 22:25:41 +0200 (CEST)
Message-Id: <cc150f50906038895d6dc86a773b4e525be54c57.1715285340.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715285340.git.balaton@eik.bme.hu>
References: <cover.1715285340.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 07/32] target/ppc/mmu_common.c: Move else branch to avoid
 large if block
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 09 May 2024 22:25:41 +0200 (CEST)
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

In mmu6xx_get_physical_address() we have a large if block with a two
line else branch that effectively returns. Invert the condition and
move the else there to allow deindenting the large if block to make
the flow easier to follow.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 71 ++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 37 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index b7c07cf515..ba60b4902b 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -405,47 +405,44 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     ret = -1;
     if (!ds) {
         /* Check if instruction fetch is allowed, if needed */
-        if (type != ACCESS_CODE || ctx->nx == 0) {
-            /* Page address translation */
-            qemu_log_mask(CPU_LOG_MMU, "htab_base " HWADDR_FMT_plx
-                    " htab_mask " HWADDR_FMT_plx
-                    " hash " HWADDR_FMT_plx "\n",
-                    ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu), hash);
-            ctx->hash[0] = hash;
-            ctx->hash[1] = ~hash;
-
-            /* Initialize real address with an invalid value */
-            ctx->raddr = (hwaddr)-1ULL;
-            /* Software TLB search */
-            ret = ppc6xx_tlb_check(env, ctx, eaddr, access_type);
+        if (type == ACCESS_CODE && ctx->nx) {
+            qemu_log_mask(CPU_LOG_MMU, "No access allowed\n");
+            return -3;
+        }
+        /* Page address translation */
+        qemu_log_mask(CPU_LOG_MMU, "htab_base " HWADDR_FMT_plx " htab_mask "
+                      HWADDR_FMT_plx " hash " HWADDR_FMT_plx "\n",
+                      ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu), hash);
+        ctx->hash[0] = hash;
+        ctx->hash[1] = ~hash;
+
+        /* Initialize real address with an invalid value */
+        ctx->raddr = (hwaddr)-1ULL;
+        /* Software TLB search */
+        ret = ppc6xx_tlb_check(env, ctx, eaddr, access_type);
 #if defined(DUMP_PAGE_TABLES)
-            if (qemu_loglevel_mask(CPU_LOG_MMU)) {
-                CPUState *cs = env_cpu(env);
-                hwaddr curaddr;
-                uint32_t a0, a1, a2, a3;
-
-                qemu_log("Page table: " HWADDR_FMT_plx " len " HWADDR_FMT_plx
-                         "\n", ppc_hash32_hpt_base(cpu),
-                         ppc_hash32_hpt_mask(cpu) + 0x80);
-                for (curaddr = ppc_hash32_hpt_base(cpu);
-                     curaddr < (ppc_hash32_hpt_base(cpu)
-                                + ppc_hash32_hpt_mask(cpu) + 0x80);
-                     curaddr += 16) {
-                    a0 = ldl_phys(cs->as, curaddr);
-                    a1 = ldl_phys(cs->as, curaddr + 4);
-                    a2 = ldl_phys(cs->as, curaddr + 8);
-                    a3 = ldl_phys(cs->as, curaddr + 12);
-                    if (a0 != 0 || a1 != 0 || a2 != 0 || a3 != 0) {
-                        qemu_log(HWADDR_FMT_plx ": %08x %08x %08x %08x\n",
-                                 curaddr, a0, a1, a2, a3);
-                    }
+        if (qemu_loglevel_mask(CPU_LOG_MMU)) {
+            CPUState *cs = env_cpu(env);
+            hwaddr curaddr;
+            uint32_t a0, a1, a2, a3;
+
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
                 }
             }
-#endif
-        } else {
-            qemu_log_mask(CPU_LOG_MMU, "No access allowed\n");
-            ret = -3;
         }
+#endif
     } else {
         qemu_log_mask(CPU_LOG_MMU, "direct store...\n");
         /* Direct-store segment : absolutely *BUGGY* for now */
-- 
2.30.9


