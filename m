Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF878CF6AB
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 01:16:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN5b-0006WN-1z; Sun, 26 May 2024 19:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN5F-0005vY-4g; Sun, 26 May 2024 19:15:21 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN5B-0003pR-11; Sun, 26 May 2024 19:15:20 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7F99D4E6039;
 Mon, 27 May 2024 01:13:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id CE2TDNumuyzT; Mon, 27 May 2024 01:13:02 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 93AC34E64C1; Mon, 27 May 2024 01:13:02 +0200 (CEST)
Message-Id: <069b4b98c933bb95ba12cf2d6d2921b986cf22c4.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 26/43] target/ppc/mmu_common.c: Stop using ctx in
 get_bat_6xx_tlb()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:13:02 +0200 (CEST)
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

Pass raddr and prot in function parameters instead

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 624ed51a92..4770b43630 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -193,7 +193,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env, hwaddr *raddr, int *prot,
     return ret;
 }
 
-static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
+static int get_bat_6xx_tlb(CPUPPCState *env, hwaddr *raddr, int *prot,
                            target_ulong eaddr, MMUAccessType access_type,
                            bool pr)
 {
@@ -224,16 +224,16 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
             if ((eaddr & BATU32_BEPIU) == BEPIu &&
                 ((eaddr & BATU32_BEPIL) & ~bl) == BEPIl) {
                 /* Get physical address */
-                ctx->raddr = (*BATl & BATU32_BEPIU) |
+                *raddr = (*BATl & BATU32_BEPIU) |
                     ((eaddr & BATU32_BEPIL & bl) | (*BATl & BATU32_BEPIL)) |
                     (eaddr & 0x0001F000);
                 /* Compute access rights */
-                ctx->prot = ppc_hash32_bat_prot(*BATu, *BATl);
-                if (check_prot_access_type(ctx->prot, access_type)) {
+                *prot = ppc_hash32_bat_prot(*BATu, *BATl);
+                if (check_prot_access_type(*prot, access_type)) {
                     qemu_log_mask(CPU_LOG_MMU, "BAT %d match: r " HWADDR_FMT_plx
-                                  " prot=%c%c\n", i, ctx->raddr,
-                                  ctx->prot & PAGE_READ ? 'R' : '-',
-                                  ctx->prot & PAGE_WRITE ? 'W' : '-');
+                                  " prot=%c%c\n", i, *raddr,
+                                  *prot & PAGE_READ ? 'R' : '-',
+                                  *prot & PAGE_WRITE ? 'W' : '-');
                     ret = 0;
                 } else {
                     ret = -2;
@@ -277,7 +277,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
 
     /* First try to find a BAT entry if there are any */
     if (env->nb_BATs &&
-        get_bat_6xx_tlb(env, ctx, eaddr, access_type, pr) == 0) {
+        get_bat_6xx_tlb(env, &ctx->raddr, &ctx->prot, eaddr,
+                        access_type, pr) == 0) {
         return 0;
     }
 
-- 
2.30.9


