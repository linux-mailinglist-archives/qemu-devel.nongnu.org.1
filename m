Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D96E58CF6AC
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 01:16:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN4S-0004Dh-7k; Sun, 26 May 2024 19:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN4L-00048Z-0w; Sun, 26 May 2024 19:14:25 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN4I-0003gD-3v; Sun, 26 May 2024 19:14:24 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 639D44E646F;
 Mon, 27 May 2024 01:13:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id XnQmU2qyv5X6; Mon, 27 May 2024 01:13:00 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 741F04E63BF; Mon, 27 May 2024 01:13:00 +0200 (CEST)
Message-Id: <635b831560a89d6e996ae0e8514f3b669217e967.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 24/43] target/ppc/mmu_common.c: Use defines instead of numeric
 constants
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:13:00 +0200 (CEST)
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

Replace some BAT related constants with defines from mmu-hash32.h

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 110936ca83..aa002bba35 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -201,7 +201,7 @@ static inline void bat_size_prot(CPUPPCState *env, target_ulong *blp,
     target_ulong bl;
     int pp, valid, prot;
 
-    bl = (*BATu & 0x00001FFC) << 15;
+    bl = (*BATu & BATU32_BL) << 15;
     valid = 0;
     prot = 0;
     if ((!FIELD_EX64(env->msr, MSR, PR) && (*BATu & 0x00000002)) ||
@@ -241,19 +241,19 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
     for (i = 0; i < env->nb_BATs; i++) {
         BATu = &BATut[i];
         BATl = &BATlt[i];
-        BEPIu = *BATu & 0xF0000000;
-        BEPIl = *BATu & 0x0FFE0000;
+        BEPIu = *BATu & BATU32_BEPIU;
+        BEPIl = *BATu & BATU32_BEPIL;
         bat_size_prot(env, &bl, &valid, &prot, BATu, BATl);
         qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_lx " BATu "
                       TARGET_FMT_lx " BATl " TARGET_FMT_lx "\n", __func__,
                       ifetch ? 'I' : 'D', i, eaddr, *BATu, *BATl);
-        if ((eaddr & 0xF0000000) == BEPIu &&
-            ((eaddr & 0x0FFE0000) & ~bl) == BEPIl) {
+        if ((eaddr & BATU32_BEPIU) == BEPIu &&
+            ((eaddr & BATU32_BEPIL) & ~bl) == BEPIl) {
             /* BAT matches */
             if (valid != 0) {
                 /* Get physical address */
-                ctx->raddr = (*BATl & 0xF0000000) |
-                    ((eaddr & 0x0FFE0000 & bl) | (*BATl & 0x0FFE0000)) |
+                ctx->raddr = (*BATl & BATU32_BEPIU) |
+                    ((eaddr & BATU32_BEPIL & bl) | (*BATl & BATU32_BEPIL)) |
                     (eaddr & 0x0001F000);
                 /* Compute access rights */
                 ctx->prot = prot;
@@ -277,9 +277,9 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
             for (i = 0; i < 4; i++) {
                 BATu = &BATut[i];
                 BATl = &BATlt[i];
-                BEPIu = *BATu & 0xF0000000;
-                BEPIl = *BATu & 0x0FFE0000;
-                bl = (*BATu & 0x00001FFC) << 15;
+                BEPIu = *BATu & BATU32_BEPIU;
+                BEPIl = *BATu & BATU32_BEPIL;
+                bl = (*BATu & BATU32_BL) << 15;
                 qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_lx
                               " BATu " TARGET_FMT_lx " BATl " TARGET_FMT_lx
                               "\n\t" TARGET_FMT_lx " " TARGET_FMT_lx " "
@@ -520,9 +520,9 @@ static void mmu6xx_dump_BATs(CPUPPCState *env, int type)
     for (i = 0; i < env->nb_BATs; i++) {
         BATu = &BATut[i];
         BATl = &BATlt[i];
-        BEPIu = *BATu & 0xF0000000;
-        BEPIl = *BATu & 0x0FFE0000;
-        bl = (*BATu & 0x00001FFC) << 15;
+        BEPIu = *BATu & BATU32_BEPIU;
+        BEPIl = *BATu & BATU32_BEPIL;
+        bl = (*BATu & BATU32_BL) << 15;
         qemu_printf("%s BAT%d BATu " TARGET_FMT_lx
                     " BATl " TARGET_FMT_lx "\n\t" TARGET_FMT_lx " "
                     TARGET_FMT_lx " " TARGET_FMT_lx "\n",
-- 
2.30.9


