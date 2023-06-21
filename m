Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D3B7385D8
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:58:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByKW-0004GI-LI; Wed, 21 Jun 2023 09:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qByKT-0004FZ-R1
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:57:01 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qByKR-00058g-RC
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pCgYtAKTVtWsD+TcGxpr/At+BuUr+4RlBiGDWYZhwd4=; b=ikxVU5iU+UH+NtgQjsLYsXxdjo
 rf6O+/8LpndFQ7WN2KyrV2rYaaTk5xHfv+HO4adtx50AqI/QO50xWQhvSeKqhQB5plIn3rcjJVV50
 X2imWnEKfr9KWhQ5P0J9mOIJ5QQnNu4Bo+qlsQoQ9c9Co96Tf5XiwqoOROSeuRo/2Aps=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com
Subject: [PATCH v3 11/12] accel/tcg: Replace target_ulong with vaddr in
 page_*()
Date: Wed, 21 Jun 2023 15:56:32 +0200
Message-ID: <20230621135633.1649-12-anjo@rev.ng>
In-Reply-To: <20230621135633.1649-1-anjo@rev.ng>
References: <20230621135633.1649-1-anjo@rev.ng>
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

Use vaddr for guest virtual addresses for functions dealing with page
flags.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c        | 44 +++++++++++++++++-------------------
 include/exec/cpu-all.h       | 10 ++++----
 include/exec/translate-all.h |  2 +-
 3 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index f8b16d6ab8..6b0cbcf2e5 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -144,7 +144,7 @@ typedef struct PageFlagsNode {
 
 static IntervalTreeRoot pageflags_root;
 
-static PageFlagsNode *pageflags_find(target_ulong start, target_long last)
+static PageFlagsNode *pageflags_find(vaddr start, vaddr last)
 {
     IntervalTreeNode *n;
 
@@ -152,8 +152,7 @@ static PageFlagsNode *pageflags_find(target_ulong start, target_long last)
     return n ? container_of(n, PageFlagsNode, itree) : NULL;
 }
 
-static PageFlagsNode *pageflags_next(PageFlagsNode *p, target_ulong start,
-                                     target_long last)
+static PageFlagsNode *pageflags_next(PageFlagsNode *p, vaddr start, vaddr last)
 {
     IntervalTreeNode *n;
 
@@ -205,7 +204,7 @@ void page_dump(FILE *f)
     walk_memory_regions(f, dump_region);
 }
 
-int page_get_flags(target_ulong address)
+int page_get_flags(vaddr address)
 {
     PageFlagsNode *p = pageflags_find(address, address);
 
@@ -228,7 +227,7 @@ int page_get_flags(target_ulong address)
 }
 
 /* A subroutine of page_set_flags: insert a new node for [start,last]. */
-static void pageflags_create(target_ulong start, target_ulong last, int flags)
+static void pageflags_create(vaddr start, vaddr last, int flags)
 {
     PageFlagsNode *p = g_new(PageFlagsNode, 1);
 
@@ -239,13 +238,13 @@ static void pageflags_create(target_ulong start, target_ulong last, int flags)
 }
 
 /* A subroutine of page_set_flags: remove everything in [start,last]. */
-static bool pageflags_unset(target_ulong start, target_ulong last)
+static bool pageflags_unset(vaddr start, vaddr last)
 {
     bool inval_tb = false;
 
     while (true) {
         PageFlagsNode *p = pageflags_find(start, last);
-        target_ulong p_last;
+        vaddr p_last;
 
         if (!p) {
             break;
@@ -284,8 +283,7 @@ static bool pageflags_unset(target_ulong start, target_ulong last)
  * A subroutine of page_set_flags: nothing overlaps [start,last],
  * but check adjacent mappings and maybe merge into a single range.
  */
-static void pageflags_create_merge(target_ulong start, target_ulong last,
-                                   int flags)
+static void pageflags_create_merge(vaddr start, vaddr last, int flags)
 {
     PageFlagsNode *next = NULL, *prev = NULL;
 
@@ -336,11 +334,11 @@ static void pageflags_create_merge(target_ulong start, target_ulong last,
 #define PAGE_STICKY  (PAGE_ANON | PAGE_PASSTHROUGH | PAGE_TARGET_STICKY)
 
 /* A subroutine of page_set_flags: add flags to [start,last]. */
-static bool pageflags_set_clear(target_ulong start, target_ulong last,
+static bool pageflags_set_clear(vaddr start, vaddr last,
                                 int set_flags, int clear_flags)
 {
     PageFlagsNode *p;
-    target_ulong p_start, p_last;
+    vaddr p_start, p_last;
     int p_flags, merge_flags;
     bool inval_tb = false;
 
@@ -480,7 +478,7 @@ static bool pageflags_set_clear(target_ulong start, target_ulong last,
  * The flag PAGE_WRITE_ORG is positioned automatically depending
  * on PAGE_WRITE.  The mmap_lock should already be held.
  */
-void page_set_flags(target_ulong start, target_ulong last, int flags)
+void page_set_flags(vaddr start, vaddr last, int flags)
 {
     bool reset = false;
     bool inval_tb = false;
@@ -520,9 +518,9 @@ void page_set_flags(target_ulong start, target_ulong last, int flags)
     }
 }
 
-int page_check_range(target_ulong start, target_ulong len, int flags)
+int page_check_range(vaddr start, vaddr len, int flags)
 {
-    target_ulong last;
+    vaddr last;
     int locked;  /* tri-state: =0: unlocked, +1: global, -1: local */
     int ret;
 
@@ -601,7 +599,7 @@ int page_check_range(target_ulong start, target_ulong len, int flags)
 void page_protect(tb_page_addr_t address)
 {
     PageFlagsNode *p;
-    target_ulong start, last;
+    vaddr start, last;
     int prot;
 
     assert_memory_lock();
@@ -642,7 +640,7 @@ void page_protect(tb_page_addr_t address)
  * immediately exited. (We can only return 2 if the 'pc' argument is
  * non-zero.)
  */
-int page_unprotect(target_ulong address, uintptr_t pc)
+int page_unprotect(vaddr address, uintptr_t pc)
 {
     PageFlagsNode *p;
     bool current_tb_invalidated;
@@ -676,7 +674,7 @@ int page_unprotect(target_ulong address, uintptr_t pc)
         }
 #endif
     } else {
-        target_ulong start, len, i;
+        vaddr start, len, i;
         int prot;
 
         if (qemu_host_page_size <= TARGET_PAGE_SIZE) {
@@ -691,7 +689,7 @@ int page_unprotect(target_ulong address, uintptr_t pc)
             prot = 0;
 
             for (i = 0; i < len; i += TARGET_PAGE_SIZE) {
-                target_ulong addr = start + i;
+                vaddr addr = start + i;
 
                 p = pageflags_find(addr, addr);
                 if (p) {
@@ -814,7 +812,7 @@ typedef struct TargetPageDataNode {
 
 static IntervalTreeRoot targetdata_root;
 
-void page_reset_target_data(target_ulong start, target_ulong last)
+void page_reset_target_data(vaddr start, vaddr last)
 {
     IntervalTreeNode *n, *next;
 
@@ -828,7 +826,7 @@ void page_reset_target_data(target_ulong start, target_ulong last)
          n != NULL;
          n = next,
          next = next ? interval_tree_iter_next(n, start, last) : NULL) {
-        target_ulong n_start, n_last, p_ofs, p_len;
+        vaddr n_start, n_last, p_ofs, p_len;
         TargetPageDataNode *t = container_of(n, TargetPageDataNode, itree);
 
         if (n->start >= start && n->last <= last) {
@@ -851,11 +849,11 @@ void page_reset_target_data(target_ulong start, target_ulong last)
     }
 }
 
-void *page_get_target_data(target_ulong address)
+void *page_get_target_data(vaddr address)
 {
     IntervalTreeNode *n;
     TargetPageDataNode *t;
-    target_ulong page, region;
+    vaddr page, region;
 
     page = address & TARGET_PAGE_MASK;
     region = address & TBD_MASK;
@@ -884,7 +882,7 @@ void *page_get_target_data(target_ulong address)
     return t->data[(page - region) >> TARGET_PAGE_BITS];
 }
 #else
-void page_reset_target_data(target_ulong start, target_ulong last) { }
+void page_reset_target_data(vaddr start, vaddr last) { }
 #endif /* TARGET_PAGE_DATA_SIZE */
 
 /* The softmmu versions of these helpers are in cputlb.c.  */
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 09bf4c0cc6..97be7c2c3c 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -219,10 +219,10 @@ typedef int (*walk_memory_regions_fn)(void *, target_ulong,
                                       target_ulong, unsigned long);
 int walk_memory_regions(void *, walk_memory_regions_fn);
 
-int page_get_flags(target_ulong address);
-void page_set_flags(target_ulong start, target_ulong last, int flags);
-void page_reset_target_data(target_ulong start, target_ulong last);
-int page_check_range(target_ulong start, target_ulong len, int flags);
+int page_get_flags(vaddr address);
+void page_set_flags(vaddr start, vaddr last, int flags);
+void page_reset_target_data(vaddr start, vaddr last);
+int page_check_range(vaddr start, vaddr len, int flags);
 
 /**
  * page_get_target_data(address)
@@ -235,7 +235,7 @@ int page_check_range(target_ulong start, target_ulong len, int flags);
  * The memory will be freed when the guest page is deallocated,
  * e.g. with the munmap system call.
  */
-void *page_get_target_data(target_ulong address)
+void *page_get_target_data(vaddr address)
     __attribute__((returns_nonnull));
 #endif
 
diff --git a/include/exec/translate-all.h b/include/exec/translate-all.h
index 88602ae8d8..0b9d2e3b32 100644
--- a/include/exec/translate-all.h
+++ b/include/exec/translate-all.h
@@ -28,7 +28,7 @@ void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
 
 #ifdef CONFIG_USER_ONLY
 void page_protect(tb_page_addr_t page_addr);
-int page_unprotect(target_ulong address, uintptr_t pc);
+int page_unprotect(vaddr address, uintptr_t pc);
 #endif
 
 #endif /* TRANSLATE_ALL_H */
-- 
2.41.0


