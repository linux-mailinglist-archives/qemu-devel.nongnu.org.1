Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CEF8CF6BF
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 01:17:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN4q-0004ey-Lj; Sun, 26 May 2024 19:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN4m-0004Q4-Db; Sun, 26 May 2024 19:14:52 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN4j-0003jt-NS; Sun, 26 May 2024 19:14:52 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B550A4E6036;
 Mon, 27 May 2024 01:12:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 5_BI7vhQg9rJ; Mon, 27 May 2024 01:12:47 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C388F4E603E; Mon, 27 May 2024 01:12:47 +0200 (CEST)
Message-Id: <3235abe633100992ad1437879a9869f3fb9a8189.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 12/43] target/ppc/mmu_common.c: Remove nx field from mmu_ctx_t
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:12:47 +0200 (CEST)
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

Pass it as a parameter instead. Also use named constants instead of
hex values when extracting bits from SR.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index c4902b7632..9f402a979d 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -43,7 +43,6 @@ typedef struct {
     int prot;          /* Protection bits          */
     target_ulong ptem; /* Virtual segment ID | API */
     int key;           /* Access key               */
-    int nx;            /* Non-execute area         */
 } mmu_ctx_t;
 
 void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
@@ -94,7 +93,7 @@ int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
 
 static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                                 target_ulong pte1, int pteh,
-                                MMUAccessType access_type)
+                                MMUAccessType access_type, bool nx)
 {
     /* Check validity and table match */
     if (!pte_is_valid(pte0) || ((pte0 >> 6) & 1) != pteh ||
@@ -109,7 +108,7 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
     }
     /* Keep the matching PTE information */
     ctx->raddr = pte1;
-    ctx->prot = ppc_hash32_prot(ctx->key, pte1 & HPTE32_R_PP, ctx->nx);
+    ctx->prot = ppc_hash32_prot(ctx->key, pte1 & HPTE32_R_PP, nx);
     if (check_prot_access_type(ctx->prot, access_type)) {
         qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
         return 0;
@@ -121,8 +120,9 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
 
 /* Software driven TLB helpers */
 
-static int ppc6xx_tlb_check(CPUPPCState *env, mmu_ctx_t *ctx,
-                            target_ulong eaddr, MMUAccessType access_type)
+static int ppc6xx_tlb_check(CPUPPCState *env,
+                            mmu_ctx_t *ctx, target_ulong eaddr,
+                            MMUAccessType access_type, bool nx)
 {
     ppc6xx_tlb_t *tlb;
     target_ulong *pte1p;
@@ -150,7 +150,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env, mmu_ctx_t *ctx,
                       access_type == MMU_DATA_STORE ? 'S' : 'L',
                       access_type == MMU_INST_FETCH ? 'I' : 'D');
         switch (ppc6xx_tlb_pte_check(ctx, tlb->pte0, tlb->pte1,
-                                     0, access_type)) {
+                                     0, access_type, nx)) {
         case -2:
             /* Access violation */
             ret = -2;
@@ -322,7 +322,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     hwaddr hash;
     target_ulong vsid, sr, pgidx;
     int ds, target_page_bits;
-    bool pr;
+    bool pr, nx;
 
     /* First try to find a BAT entry if there are any */
     if (env->nb_BATs && get_bat_6xx_tlb(env, ctx, eaddr, access_type) == 0) {
@@ -336,8 +336,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     ctx->key = (((sr & 0x20000000) && pr) ||
                 ((sr & 0x40000000) && !pr)) ? 1 : 0;
     ds = sr & 0x80000000 ? 1 : 0;
-    ctx->nx = sr & 0x10000000 ? 1 : 0;
-    vsid = sr & 0x00FFFFFF;
+    nx = sr & SR32_NX;
+    vsid = sr & SR32_VSID;
     target_page_bits = TARGET_PAGE_BITS;
     qemu_log_mask(CPU_LOG_MMU,
                   "Check segment v=" TARGET_FMT_lx " %d " TARGET_FMT_lx
@@ -352,10 +352,10 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     ctx->ptem = (vsid << 7) | (pgidx >> 10);
 
     qemu_log_mask(CPU_LOG_MMU, "pte segment: key=%d ds %d nx %d vsid "
-                  TARGET_FMT_lx "\n", ctx->key, ds, ctx->nx, vsid);
+                  TARGET_FMT_lx "\n", ctx->key, ds, nx, vsid);
     if (!ds) {
         /* Check if instruction fetch is allowed, if needed */
-        if (type == ACCESS_CODE && ctx->nx) {
+        if (type == ACCESS_CODE && nx) {
             qemu_log_mask(CPU_LOG_MMU, "No access allowed\n");
             return -3;
         }
@@ -368,7 +368,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
         /* Initialize real address with an invalid value */
         ctx->raddr = (hwaddr)-1ULL;
         /* Software TLB search */
-        return ppc6xx_tlb_check(env, ctx, eaddr, access_type);
+        return ppc6xx_tlb_check(env, ctx, eaddr, access_type, nx);
     }
 
     /* Direct-store segment : absolutely *BUGGY* for now */
-- 
2.30.9


