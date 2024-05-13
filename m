Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 358AD8C393E
	for <lists+qemu-devel@lfdr.de>; Mon, 13 May 2024 01:30:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Id9-0002v1-U1; Sun, 12 May 2024 19:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Icd-00020z-TB; Sun, 12 May 2024 19:28:53 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Icb-0000Qu-3y; Sun, 12 May 2024 19:28:51 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CBDB84E6787;
 Mon, 13 May 2024 01:28:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id vajg1yB-yD97; Mon, 13 May 2024 01:28:21 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DAE704E6788; Mon, 13 May 2024 01:28:21 +0200 (CEST)
Message-Id: <447b618211423732bb6b3c7e12982a7c9ea2d042.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715555763.git.balaton@eik.bme.hu>
References: <cover.1715555763.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 47/61] target/ppc/mmu_common.c: Remove single use local
 variable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 13 May 2024 01:28:21 +0200 (CEST)
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

In mmu6xx_get_physical_address() tagtet_page_bits local is declared
only to use TARGET_PAGE_BITS once. Drop the unneeded variable.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 9b73581fc7..1a2b4158d5 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -321,7 +321,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     PowerPCCPU *cpu = env_archcpu(env);
     hwaddr hash;
     target_ulong vsid, sr, pgidx;
-    int target_page_bits;
     bool pr, ds, nx;
 
     /* First try to find a BAT entry if there are any */
@@ -338,7 +337,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     ds = sr & SR32_T;
     nx = sr & SR32_NX;
     vsid = sr & SR32_VSID;
-    target_page_bits = TARGET_PAGE_BITS;
     qemu_log_mask(CPU_LOG_MMU,
                   "Check segment v=" TARGET_FMT_lx " %d " TARGET_FMT_lx
                   " nip=" TARGET_FMT_lx " lr=" TARGET_FMT_lx
@@ -347,7 +345,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
                   (int)FIELD_EX64(env->msr, MSR, IR),
                   (int)FIELD_EX64(env->msr, MSR, DR), pr ? 1 : 0,
                   access_type == MMU_DATA_STORE, type);
-    pgidx = (eaddr & ~SEGMENT_MASK_256M) >> target_page_bits;
+    pgidx = (eaddr & ~SEGMENT_MASK_256M) >> TARGET_PAGE_BITS;
     hash = vsid ^ pgidx;
     ctx->ptem = (vsid << 7) | (pgidx >> 10);
 
-- 
2.30.9


