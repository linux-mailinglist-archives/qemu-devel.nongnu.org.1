Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6920832B82
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:44:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq36-0005xR-Vp; Fri, 19 Jan 2024 09:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq30-0005tg-UK
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:42 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2x-0003vv-6B
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Gl36QuzYyvoBWlG81WaphhIIJAHdZ9uea0zXwZMnf8A=; b=wBQZ2AHdAZGtI8qvZrwPNJs1en
 v7/qruDFh82HC4U/SrDfVLd53y9wKhW7JM9kBi69pzamoYfKiV5xcopcboA8VsSeW5h1Tow7d+wsb
 wxt/NDKoIaw1YLT2WdhtDmhKUITLZnaIi3A8BLw/Ln/4ftjbc0vMZWgxxRMgovhZksTM=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 29/34] accel/tcg: Make tb-maint.c target indpendent
Date: Fri, 19 Jan 2024 15:40:19 +0100
Message-ID: <20240119144024.14289-30-anjo@rev.ng>
In-Reply-To: <20240119144024.14289-1-anjo@rev.ng>
References: <20240119144024.14289-1-anjo@rev.ng>
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

Uses target_has_precise_smc() and target_phys_addr_space_bits() to turn
ifdefs into runtime branches.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 accel/tcg/tb-maint.c | 47 +++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index b194f8f065..fdc3a30d0d 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -148,14 +148,6 @@ static PageForEachNext foreach_tb_next(PageForEachNext tb,
 }
 
 #else
-/*
- * In system mode we want L1_MAP to be based on ram offsets.
- */
-#if HOST_LONG_BITS < TARGET_PHYS_ADDR_SPACE_BITS
-# define L1_MAP_ADDR_SPACE_BITS  HOST_LONG_BITS
-#else
-# define L1_MAP_ADDR_SPACE_BITS  TARGET_PHYS_ADDR_SPACE_BITS
-#endif
 
 /* Size of the L2 (and L3, etc) page tables.  */
 #define V_L2_BITS 10
@@ -186,17 +178,28 @@ struct PageDesc {
 
 void page_table_config_init(void)
 {
+    int target_phys_addr_bits = target_phys_addr_space_bits();
+    uint32_t l1_map_addr_space_bits;
     uint32_t v_l1_bits;
 
+    /*
+     * In system mode we want L1_MAP to be based on ram offsets.
+     */
+    if (HOST_LONG_BITS < target_phys_addr_bits) {
+        l1_map_addr_space_bits = HOST_LONG_BITS;
+    } else {
+        l1_map_addr_space_bits = target_phys_addr_bits;
+    }
+
     assert(TARGET_PAGE_BITS);
     /* The bits remaining after N lower levels of page tables.  */
-    v_l1_bits = (L1_MAP_ADDR_SPACE_BITS - TARGET_PAGE_BITS) % V_L2_BITS;
+    v_l1_bits = (l1_map_addr_space_bits - TARGET_PAGE_BITS) % V_L2_BITS;
     if (v_l1_bits < V_L1_MIN_BITS) {
         v_l1_bits += V_L2_BITS;
     }
 
     v_l1_size = 1 << v_l1_bits;
-    v_l1_shift = L1_MAP_ADDR_SPACE_BITS - TARGET_PAGE_BITS - v_l1_bits;
+    v_l1_shift = l1_map_addr_space_bits - TARGET_PAGE_BITS - v_l1_bits;
     v_l2_levels = v_l1_shift / V_L2_BITS - 1;
 
     assert(v_l1_bits <= V_L1_MAX_BITS);
@@ -1045,14 +1048,15 @@ bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc)
     TranslationBlock *tb;
     PageForEachNext n;
     tb_page_addr_t last;
+    const bool has_precise_smc = target_has_precise_smc();
 
     /*
      * Without precise smc semantics, or when outside of a TB,
      * we can skip to invalidate.
      */
-#ifndef TARGET_HAS_PRECISE_SMC
-    pc = 0;
-#endif
+    if (!has_precise_smc) {
+        pc = 0;
+    }
     if (!pc) {
         tb_invalidate_phys_page(addr);
         return false;
@@ -1102,10 +1106,13 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
 {
     TranslationBlock *tb;
     PageForEachNext n;
-#ifdef TARGET_HAS_PRECISE_SMC
+    const bool has_precise_smc = target_has_precise_smc();
     bool current_tb_modified = false;
-    TranslationBlock *current_tb = retaddr ? tcg_tb_lookup(retaddr) : NULL;
-#endif /* TARGET_HAS_PRECISE_SMC */
+    TranslationBlock *current_tb = NULL;
+
+    if (has_precise_smc && retaddr) {
+        current_tb = tcg_tb_lookup(retaddr);
+    }
 
     /* Range may not cross a page. */
     tcg_debug_assert(((start ^ last) & TARGET_PAGE_MASK) == 0);
@@ -1127,8 +1134,7 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
             tb_last = tb_start + (tb_last & ~TARGET_PAGE_MASK);
         }
         if (!(tb_last < start || tb_start > last)) {
-#ifdef TARGET_HAS_PRECISE_SMC
-            if (current_tb == tb &&
+            if (has_precise_smc && current_tb == tb &&
                 (tb_cflags(current_tb) & CF_COUNT_MASK) != 1) {
                 /*
                  * If we are modifying the current TB, we must stop
@@ -1140,7 +1146,6 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
                 current_tb_modified = true;
                 cpu_restore_state_from_tb(current_cpu, current_tb, retaddr);
             }
-#endif /* TARGET_HAS_PRECISE_SMC */
             tb_phys_invalidate__locked(tb);
         }
     }
@@ -1150,15 +1155,13 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
         tlb_unprotect_code(start);
     }
 
-#ifdef TARGET_HAS_PRECISE_SMC
-    if (current_tb_modified) {
+    if (has_precise_smc && current_tb_modified) {
         page_collection_unlock(pages);
         /* Force execution of one insn next time.  */
         current_cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
         mmap_unlock();
         cpu_loop_exit_noexc(current_cpu);
     }
-#endif
 }
 
 /*
-- 
2.43.0


