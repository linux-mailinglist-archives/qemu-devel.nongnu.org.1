Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAD58CF6A6
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 01:16:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN4H-00044s-UC; Sun, 26 May 2024 19:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN4A-000432-TL; Sun, 26 May 2024 19:14:15 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN47-0003V2-P3; Sun, 26 May 2024 19:14:13 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3F5314E6001;
 Mon, 27 May 2024 01:12:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id c40DhPPqWH3m; Mon, 27 May 2024 01:12:37 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4E88C4E600E; Mon, 27 May 2024 01:12:37 +0200 (CEST)
Message-Id: <7ec05c493e91bd8ec351127aab8017a5a8caf29d.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 02/43] target/ppc/mmu_common.c: Remove local name for a
 constant
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:12:37 +0200 (CEST)
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

The mmask local variable is a less descriptive local name for a
constant. Drop it and use the constant directly in the two places it
is needed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 08c5b61f76..2618cdec6a 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -98,7 +98,7 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                                 target_ulong pte1, int h,
                                 MMUAccessType access_type)
 {
-    target_ulong ptem, mmask;
+    target_ulong ptem;
     int ret, pteh, ptev, pp;
 
     ret = -1;
@@ -108,12 +108,11 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
     if (ptev && h == pteh) {
         /* Check vsid & api */
         ptem = pte0 & PTE_PTEM_MASK;
-        mmask = PTE_CHECK_MASK;
         pp = pte1 & 0x00000003;
         if (ptem == ctx->ptem) {
             if (ctx->raddr != (hwaddr)-1ULL) {
                 /* all matches should have equal RPN, WIMG & PP */
-                if ((ctx->raddr & mmask) != (pte1 & mmask)) {
+                if ((ctx->raddr & PTE_CHECK_MASK) != (pte1 & PTE_CHECK_MASK)) {
                     qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
                     return -3;
                 }
-- 
2.30.9


