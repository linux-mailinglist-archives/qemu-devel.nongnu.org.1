Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E054F8C1799
	for <lists+qemu-devel@lfdr.de>; Thu,  9 May 2024 22:32:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5ALG-0000Op-N8; Thu, 09 May 2024 16:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AL1-0000F7-Hy; Thu, 09 May 2024 16:26:01 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AKz-00015d-2Z; Thu, 09 May 2024 16:25:58 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 92F8A4E646F;
 Thu, 09 May 2024 22:25:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id PXTKI7ULxX76; Thu,  9 May 2024 22:25:53 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A40934E6106; Thu, 09 May 2024 22:25:53 +0200 (CEST)
Message-Id: <350cbe83170e38a2589ffe452d484a89f6f470ff.1715285340.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715285340.git.balaton@eik.bme.hu>
References: <cover.1715285340.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 19/32] target/ppc: Remove pp_check() and reuse
 ppc_hash32_pp_prot()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 09 May 2024 22:25:53 +0200 (CEST)
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

The ppc_hash32_pp_prot() function in mmu-hash32.c is the same as
pp_check() in mmu_common.c, merge these to remove duplicated code.
Define the common function in internal.h as static lnline otherwise
exporting the function from mmu-hash32.c would stop the compiler
inlining it which results in slightly lower performance.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/internal.h   | 35 ++++++++++++++++++++++++++++++++
 target/ppc/mmu-hash32.c | 45 -----------------------------------------
 target/ppc/mmu_common.c | 44 ++--------------------------------------
 3 files changed, 37 insertions(+), 87 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 98b41a970c..ffdf6c075d 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -256,6 +256,41 @@ static inline int prot_for_access_type(MMUAccessType access_type)
 #ifndef CONFIG_USER_ONLY
 
 /* PowerPC MMU emulation */
+static inline int ppc_hash32_pp_prot(int key, int pp, int nx)
+{
+    int prot;
+
+    if (key == 0) {
+        switch (pp) {
+        case 0x0:
+        case 0x1:
+        case 0x2:
+            prot = PAGE_READ | PAGE_WRITE;
+            break;
+        case 0x3:
+            prot = PAGE_READ;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    } else {
+        switch (pp) {
+        case 0x0:
+            prot = 0;
+            break;
+        case 0x1:
+        case 0x3:
+            prot = PAGE_READ;
+            break;
+        case 0x2:
+            prot = PAGE_READ | PAGE_WRITE;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+    return nx ? prot : prot | PAGE_EXEC;
+}
 
 typedef struct mmu_ctx_t mmu_ctx_t;
 
diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 6dfedab11d..960751a50e 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -43,51 +43,6 @@ struct mmu_ctx_hash32 {
     int key;                       /* Access key                */
 };
 
-static int ppc_hash32_pp_prot(int key, int pp, int nx)
-{
-    int prot;
-
-    if (key == 0) {
-        switch (pp) {
-        case 0x0:
-        case 0x1:
-        case 0x2:
-            prot = PAGE_READ | PAGE_WRITE;
-            break;
-
-        case 0x3:
-            prot = PAGE_READ;
-            break;
-
-        default:
-            abort();
-        }
-    } else {
-        switch (pp) {
-        case 0x0:
-            prot = 0;
-            break;
-
-        case 0x1:
-        case 0x3:
-            prot = PAGE_READ;
-            break;
-
-        case 0x2:
-            prot = PAGE_READ | PAGE_WRITE;
-            break;
-
-        default:
-            abort();
-        }
-    }
-    if (nx == 0) {
-        prot |= PAGE_EXEC;
-    }
-
-    return prot;
-}
-
 static int ppc_hash32_pte_prot(int mmu_idx,
                                target_ulong sr, ppc_hash_pte32_t pte)
 {
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 004ea2111d..ab082bd12d 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -65,44 +65,6 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
 /*****************************************************************************/
 /* PowerPC MMU emulation */
 
-static int pp_check(int key, int pp, int nx)
-{
-    int access;
-
-    /* Compute access rights */
-    access = 0;
-    if (key == 0) {
-        switch (pp) {
-        case 0x0:
-        case 0x1:
-        case 0x2:
-            access |= PAGE_WRITE;
-            /* fall through */
-        case 0x3:
-            access |= PAGE_READ;
-            break;
-        }
-    } else {
-        switch (pp) {
-        case 0x0:
-            access = 0;
-            break;
-        case 0x1:
-        case 0x3:
-            access = PAGE_READ;
-            break;
-        case 0x2:
-            access = PAGE_READ | PAGE_WRITE;
-            break;
-        }
-    }
-    if (nx == 0) {
-        access |= PAGE_EXEC;
-    }
-
-    return access;
-}
-
 static int check_prot(int prot, MMUAccessType access_type)
 {
     return prot & prot_for_access_type(access_type) ? 0 : -2;
@@ -130,7 +92,7 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                                 MMUAccessType access_type)
 {
     target_ulong ptem, mmask;
-    int access, ret, pteh, ptev, pp;
+    int ret, pteh, ptev, pp;
 
     ret = -1;
     /* Check validity and table match */
@@ -149,11 +111,9 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                     return -3;
                 }
             }
-            /* Compute access rights */
-            access = pp_check(ctx->key, pp, ctx->nx);
             /* Keep the matching PTE information */
             ctx->raddr = pte1;
-            ctx->prot = access;
+            ctx->prot = ppc_hash32_pp_prot(ctx->key, pp, ctx->nx);
             ret = check_prot(ctx->prot, access_type);
             if (ret == 0) {
                 /* Access granted */
-- 
2.30.9


