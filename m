Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 205477520CE
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 14:09:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJv78-0003MA-71; Thu, 13 Jul 2023 08:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qJv75-0003Lu-Qd
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 08:08:03 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qJv73-0001b7-W0
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 08:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=F2EkOvj9S1G7UG0otxN/yK1uHMN8pd9pWmDc5//eKME=; b=vu/fYwRtkIzxSEc20dEKDDaE3W
 J+3wmfxAt8j19A13R+rgsNzbGL6y3zrg7cOmo07IEs8kRIWhX13NV34AQ+bmIkKEGkkBF96W2krmn
 3IN5RkfuStDO1KXzNcZ7+HqRHNMslZHK8nGEGD72r1cdwMO1gCUzKaDJbEzbe0fLHHLA=;
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	peter.maydell@linaro.org
Subject: [PATCH] accel/tcg: Zero-pad vaddr in tlb_debug output
Date: Thu, 13 Jul 2023 14:07:46 +0200
Message-ID: <20230713120746.26897-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

In replacing target_ulong with vaddr and TARGET_FMT_lx with VADDR_PRIx,
the zero-padding of TARGET_FMT_lx got lost.  Readd 16-wide zero-padding
for logging consistency.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 accel/tcg/cputlb.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5b51eff5a4..12a4b2a187 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -497,8 +497,8 @@ static void tlb_flush_page_locked(CPUArchState *env, int midx, vaddr page)
 
     /* Check if we need to flush due to large pages.  */
     if ((page & lp_mask) == lp_addr) {
-        tlb_debug("forcing full flush midx %d (%"
-                  VADDR_PRIx "/%" VADDR_PRIx ")\n",
+        tlb_debug("forcing full flush midx %d (%016"
+                  VADDR_PRIx "/%016" VADDR_PRIx ")\n",
                   midx, lp_addr, lp_mask);
         tlb_flush_one_mmuidx_locked(env, midx, get_clock_realtime());
     } else {
@@ -527,7 +527,7 @@ static void tlb_flush_page_by_mmuidx_async_0(CPUState *cpu,
 
     assert_cpu_is_self(cpu);
 
-    tlb_debug("page addr: %" VADDR_PRIx " mmu_map:0x%x\n", addr, idxmap);
+    tlb_debug("page addr: %016" VADDR_PRIx " mmu_map:0x%x\n", addr, idxmap);
 
     qemu_spin_lock(&env_tlb(env)->c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
@@ -591,7 +591,7 @@ static void tlb_flush_page_by_mmuidx_async_2(CPUState *cpu,
 
 void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr, uint16_t idxmap)
 {
-    tlb_debug("addr: %" VADDR_PRIx " mmu_idx:%" PRIx16 "\n", addr, idxmap);
+    tlb_debug("addr: %016" VADDR_PRIx " mmu_idx:%" PRIx16 "\n", addr, idxmap);
 
     /* This should already be page aligned */
     addr &= TARGET_PAGE_MASK;
@@ -625,7 +625,7 @@ void tlb_flush_page(CPUState *cpu, vaddr addr)
 void tlb_flush_page_by_mmuidx_all_cpus(CPUState *src_cpu, vaddr addr,
                                        uint16_t idxmap)
 {
-    tlb_debug("addr: %" VADDR_PRIx " mmu_idx:%"PRIx16"\n", addr, idxmap);
+    tlb_debug("addr: %016" VADDR_PRIx " mmu_idx:%"PRIx16"\n", addr, idxmap);
 
     /* This should already be page aligned */
     addr &= TARGET_PAGE_MASK;
@@ -666,7 +666,7 @@ void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
                                               vaddr addr,
                                               uint16_t idxmap)
 {
-    tlb_debug("addr: %" VADDR_PRIx " mmu_idx:%"PRIx16"\n", addr, idxmap);
+    tlb_debug("addr: %016" VADDR_PRIx " mmu_idx:%"PRIx16"\n", addr, idxmap);
 
     /* This should already be page aligned */
     addr &= TARGET_PAGE_MASK;
@@ -728,7 +728,7 @@ static void tlb_flush_range_locked(CPUArchState *env, int midx,
      */
     if (mask < f->mask || len > f->mask) {
         tlb_debug("forcing full flush midx %d ("
-                  "%" VADDR_PRIx "/%" VADDR_PRIx "+%" VADDR_PRIx ")\n",
+                  "%016" VADDR_PRIx "/%016" VADDR_PRIx "+%016" VADDR_PRIx ")\n",
                   midx, addr, mask, len);
         tlb_flush_one_mmuidx_locked(env, midx, get_clock_realtime());
         return;
@@ -741,7 +741,7 @@ static void tlb_flush_range_locked(CPUArchState *env, int midx,
      */
     if (((addr + len - 1) & d->large_page_mask) == d->large_page_addr) {
         tlb_debug("forcing full flush midx %d ("
-                  "%" VADDR_PRIx "/%" VADDR_PRIx ")\n",
+                  "%016" VADDR_PRIx "/%016" VADDR_PRIx ")\n",
                   midx, d->large_page_addr, d->large_page_mask);
         tlb_flush_one_mmuidx_locked(env, midx, get_clock_realtime());
         return;
@@ -773,7 +773,7 @@ static void tlb_flush_range_by_mmuidx_async_0(CPUState *cpu,
 
     assert_cpu_is_self(cpu);
 
-    tlb_debug("range: %" VADDR_PRIx "/%u+%" VADDR_PRIx " mmu_map:0x%x\n",
+    tlb_debug("range: %016" VADDR_PRIx "/%u+%016" VADDR_PRIx " mmu_map:0x%x\n",
               d.addr, d.bits, d.len, d.idxmap);
 
     qemu_spin_lock(&env_tlb(env)->c.lock);
@@ -1165,7 +1165,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
                                                 &xlat, &sz, full->attrs, &prot);
     assert(sz >= TARGET_PAGE_SIZE);
 
-    tlb_debug("vaddr=%" VADDR_PRIx " paddr=0x" HWADDR_FMT_plx
+    tlb_debug("vaddr=%016" VADDR_PRIx " paddr=0x" HWADDR_FMT_plx
               " prot=%x idx=%d\n",
               addr, full->phys_addr, prot, mmu_idx);
 
-- 
2.41.0


