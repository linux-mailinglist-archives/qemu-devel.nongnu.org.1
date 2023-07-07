Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB4274AECE
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 12:37:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHipB-0001l6-Pn; Fri, 07 Jul 2023 06:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHip4-0001c1-E4
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:36:22 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHip1-0005Ia-0G
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:36:22 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4faaaa476a9so2745031e87.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 03:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688726176; x=1691318176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAtnLNi/uv6ezOFoKAO0LnFsL79vAg3ew3PZjo4G9rg=;
 b=MUeq//skJY/QRKDjmGZHuUEbCxytYaiGsg6yoRiqobZ/awfyrbv7SfoCpbushWHzVO
 vPIiulNuBMW7Xol4EamS9aRSUjdNEPWwIos1AQuGPDwUwR0/1aVqbKnb6ih+xVQm4i7I
 ajjHa3zIddqdnQR2dXU/XrzarZR4JHsvvJ4eZH0xAIu7F4Ox8wSWDygDGMOL0qj541o5
 WO0vQtSAhw25iI7rTTjqc2yr4MPHO3M13WNNCoL5zqhTx0SWYzIDcm+ZX8y6EC1PLIP/
 qAxK1OHG2xCY2/cWbBEMThMn4qGAUIj5Zjyb07KStrT8LLW0D3Qr+92kUPXwrazmz4Gx
 0TKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688726176; x=1691318176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAtnLNi/uv6ezOFoKAO0LnFsL79vAg3ew3PZjo4G9rg=;
 b=O27m60u9d6FwaiWELoCLgJNpqGo/LcoMUh18rVKgFyXTN4aqBiO/DhcI0mDqOEZxPf
 FkxY89I/NSZhHpnW904UgxV7UX6H9V2V2M0JzJpBSs9xAZYx3bC5d4yebFf68WJ2ZV7K
 gxAM/EZkODExsY5Jxe8iLynnId0SzTBBEeYp16nGnMcp/67Vnk8NmDQR6ZFneTJ9Y7AX
 Ex69rPKnH4zEJTu62njVZ4cICBQWm+Ga2TdrPRKt0kmImBavvbTDOJi0DxaApOp3X9Pd
 Lgm1V/y0Q7XBlJBA/0vqLMdlbnQF71UstjcmQ1tGWyt+gllyKku+qj0sEl3F9jlxOON/
 ST5A==
X-Gm-Message-State: ABy/qLabPbU78DnuzPMtnDIywq1A6K7sHhh1fJ1p7B8+x8fvo7LD/aWj
 q9fJTFiweWpvISYjfNRn/1YpiHijqaFr0QPSX0w=
X-Google-Smtp-Source: APBJJlHLgqLZ0UBGj1e/lBWPIfpZfHfRiYaS8JssZFZswZCofbdZj62HH+JygA1+aJa4wtCnSrhI5A==
X-Received: by 2002:a05:6512:3589:b0:4fa:abe7:7c80 with SMTP id
 m9-20020a056512358900b004faabe77c80mr3143159lfr.39.1688726176365; 
 Fri, 07 Jul 2023 03:36:16 -0700 (PDT)
Received: from stoup.. ([91.223.100.9]) by smtp.gmail.com with ESMTPSA id
 q14-20020ac25a0e000000b004fb953f74d3sm626966lfn.264.2023.07.07.03.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 03:36:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: rjones@redhat.com,
	pbonzini@redhat.com,
	Liren Wei <lrwei@bupt.edu.cn>
Subject: [PATCH v2 2/2] accel/tcg: Always lock pages before translation
Date: Fri,  7 Jul 2023 11:36:11 +0100
Message-Id: <20230707103611.5906-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707103611.5906-1-richard.henderson@linaro.org>
References: <20230707103611.5906-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We had done this for user-mode by invoking page_protect
within the translator loop.  Extend this to handle system
mode as well.  Move page locking out of tb_link_page.

Reported-by: Liren Wei <lrwei@bupt.edu.cn>
Reported-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
---
 accel/tcg/internal.h      |  30 ++++-
 accel/tcg/cpu-exec.c      |  20 ++++
 accel/tcg/tb-maint.c      | 242 ++++++++++++++++++++------------------
 accel/tcg/translate-all.c |  43 ++++++-
 accel/tcg/translator.c    |  34 ++++--
 5 files changed, 236 insertions(+), 133 deletions(-)

diff --git a/accel/tcg/internal.h b/accel/tcg/internal.h
index 650c3ac53f..e8cbbde581 100644
--- a/accel/tcg/internal.h
+++ b/accel/tcg/internal.h
@@ -10,6 +10,7 @@
 #define ACCEL_TCG_INTERNAL_H
 
 #include "exec/exec-all.h"
+#include "exec/translate-all.h"
 
 /*
  * Access to the various translations structures need to be serialised
@@ -35,6 +36,32 @@ static inline void page_table_config_init(void) { }
 void page_table_config_init(void);
 #endif
 
+#ifdef CONFIG_USER_ONLY
+/*
+ * For user-only, page_protect sets the page read-only.
+ * Since most execution is already on read-only pages, and we'd need to
+ * account for other TBs on the same page, defer undoing any page protection
+ * until we receive the write fault.
+ */
+static inline void tb_lock_page0(tb_page_addr_t p0)
+{
+    page_protect(p0);
+}
+
+static inline void tb_lock_page1(tb_page_addr_t p0, tb_page_addr_t p1)
+{
+    page_protect(p1);
+}
+
+static inline void tb_unlock_page1(tb_page_addr_t p0, tb_page_addr_t p1) { }
+static inline void tb_unlock_pages(TranslationBlock *tb) { }
+#else
+void tb_lock_page0(tb_page_addr_t);
+void tb_lock_page1(tb_page_addr_t, tb_page_addr_t);
+void tb_unlock_page1(tb_page_addr_t, tb_page_addr_t);
+void tb_unlock_pages(TranslationBlock *);
+#endif
+
 #ifdef CONFIG_SOFTMMU
 void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
                                    unsigned size,
@@ -48,8 +75,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu, vaddr pc,
 void page_init(void);
 void tb_htable_init(void);
 void tb_reset_jump(TranslationBlock *tb, int n);
-TranslationBlock *tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
-                               tb_page_addr_t phys_page2);
+TranslationBlock *tb_link_page(TranslationBlock *tb);
 bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc);
 void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
                                uintptr_t host_pc);
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 31aa320513..fdd6d3e0e4 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -536,6 +536,26 @@ static void cpu_exec_longjmp_cleanup(CPUState *cpu)
     if (have_mmap_lock()) {
         mmap_unlock();
     }
+#else
+    /*
+     * For softmmu, a tlb_fill fault during translation will land here,
+     * and we need to release any page locks held.  In system mode we
+     * have one tcg_ctx per thread, so we know it was this cpu doing
+     * the translation.
+     *
+     * Alternative 1: Install a cleanup to be called via an exception
+     * handling safe longjmp.  It seems plausible that all our hosts
+     * support such a thing.  We'd have to properly register unwind info
+     * for the JIT for EH, rather that just for GDB.
+     *
+     * Alternative 2: Set and restore cpu->jmp_env in tb_gen_code to
+     * capture the cpu_loop_exit longjmp, perform the cleanup, and
+     * jump again to arrive here.
+     */
+    if (tcg_ctx->gen_tb) {
+        tb_unlock_pages(tcg_ctx->gen_tb);
+        tcg_ctx->gen_tb = NULL;
+    }
 #endif
     if (qemu_mutex_iothread_locked()) {
         qemu_mutex_unlock_iothread();
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 9566224d18..c406b2f7b7 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -70,17 +70,7 @@ typedef struct PageDesc PageDesc;
  */
 #define assert_page_locked(pd) tcg_debug_assert(have_mmap_lock())
 
-static inline void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
-                                  PageDesc **ret_p2, tb_page_addr_t phys2,
-                                  bool alloc)
-{
-    *ret_p1 = NULL;
-    *ret_p2 = NULL;
-}
-
-static inline void page_unlock(PageDesc *pd) { }
-static inline void page_lock_tb(const TranslationBlock *tb) { }
-static inline void page_unlock_tb(const TranslationBlock *tb) { }
+static inline void tb_lock_pages(const TranslationBlock *tb) { }
 
 /*
  * For user-only, since we are protecting all of memory with a single lock,
@@ -96,7 +86,7 @@ static void tb_remove_all(void)
 }
 
 /* Call with mmap_lock held. */
-static void tb_record(TranslationBlock *tb, PageDesc *p1, PageDesc *p2)
+static void tb_record(TranslationBlock *tb)
 {
     vaddr addr;
     int flags;
@@ -391,12 +381,108 @@ static void page_lock(PageDesc *pd)
     qemu_spin_lock(&pd->lock);
 }
 
+/* Like qemu_spin_trylock, returns false on success */
+static bool page_trylock(PageDesc *pd)
+{
+    bool busy = qemu_spin_trylock(&pd->lock);
+    if (!busy) {
+        page_lock__debug(pd);
+    }
+    return busy;
+}
+
 static void page_unlock(PageDesc *pd)
 {
     qemu_spin_unlock(&pd->lock);
     page_unlock__debug(pd);
 }
 
+void tb_lock_page0(tb_page_addr_t paddr)
+{
+    page_lock(page_find_alloc(paddr >> TARGET_PAGE_BITS, true));
+}
+
+void tb_lock_page1(tb_page_addr_t paddr0, tb_page_addr_t paddr1)
+{
+    tb_page_addr_t pindex0 = paddr0 >> TARGET_PAGE_BITS;
+    tb_page_addr_t pindex1 = paddr1 >> TARGET_PAGE_BITS;
+    PageDesc *pd0, *pd1;
+
+    if (pindex0 == pindex1) {
+        /* Identical pages, and the first page is already locked. */
+        return;
+    }
+
+    pd1 = page_find_alloc(pindex1, true);
+    if (pindex0 < pindex1) {
+        /* Correct locking order, we may block. */
+        page_lock(pd1);
+        return;
+    }
+
+    /* Incorrect locking order, we cannot block lest we deadlock. */
+    if (!page_trylock(pd1)) {
+        return;
+    }
+
+    /*
+     * Drop the lock on page0 and get both page locks in the right order.
+     * Restart translation via longjmp.
+     */
+    pd0 = page_find_alloc(pindex0, false);
+    page_unlock(pd0);
+    page_lock(pd1);
+    page_lock(pd0);
+    siglongjmp(tcg_ctx->jmp_trans, -3);
+}
+
+void tb_unlock_page1(tb_page_addr_t paddr0, tb_page_addr_t paddr1)
+{
+    tb_page_addr_t pindex0 = paddr0 >> TARGET_PAGE_BITS;
+    tb_page_addr_t pindex1 = paddr1 >> TARGET_PAGE_BITS;
+
+    if (pindex0 != pindex1) {
+        page_unlock(page_find_alloc(pindex1, false));
+    }
+}
+
+static void tb_lock_pages(TranslationBlock *tb)
+{
+    tb_page_addr_t paddr0 = tb_page_addr0(tb);
+    tb_page_addr_t paddr1 = tb_page_addr1(tb);
+    tb_page_addr_t pindex0 = paddr0 >> TARGET_PAGE_BITS;
+    tb_page_addr_t pindex1 = paddr1 >> TARGET_PAGE_BITS;
+
+    if (unlikely(paddr0 == -1)) {
+        return;
+    }
+    if (unlikely(paddr1 != -1) && pindex0 != pindex1) {
+        if (pindex0 < pindex1) {
+            page_lock(page_find_alloc(pindex0, true));
+            page_lock(page_find_alloc(pindex1, true));
+            return;
+        }
+        page_lock(page_find_alloc(pindex1, true));
+    }
+    page_lock(page_find_alloc(pindex0, true));
+}
+
+void tb_unlock_pages(TranslationBlock *tb)
+{
+    tb_page_addr_t paddr0 = tb_page_addr0(tb);
+    tb_page_addr_t paddr1 = tb_page_addr1(tb);
+    tb_page_addr_t pindex0 = paddr0 >> TARGET_PAGE_BITS;
+    tb_page_addr_t pindex1 = paddr1 >> TARGET_PAGE_BITS;
+
+    if (unlikely(paddr0 == -1)) {
+        return;
+    }
+    if (unlikely(paddr1 != -1) && pindex0 != pindex1) {
+        page_unlock(page_find_alloc(pindex1, false));
+    }
+    page_unlock(page_find_alloc(pindex0, false));
+}
+
 static inline struct page_entry *
 page_entry_new(PageDesc *pd, tb_page_addr_t index)
 {
@@ -420,13 +506,10 @@ static void page_entry_destroy(gpointer p)
 /* returns false on success */
 static bool page_entry_trylock(struct page_entry *pe)
 {
-    bool busy;
-
-    busy = qemu_spin_trylock(&pe->pd->lock);
+    bool busy = page_trylock(pe->pd);
     if (!busy) {
         g_assert(!pe->locked);
         pe->locked = true;
-        page_lock__debug(pe->pd);
     }
     return busy;
 }
@@ -604,8 +687,7 @@ static void tb_remove_all(void)
  * Add the tb in the target page and protect it if necessary.
  * Called with @p->lock held.
  */
-static inline void tb_page_add(PageDesc *p, TranslationBlock *tb,
-                               unsigned int n)
+static void tb_page_add(PageDesc *p, TranslationBlock *tb, unsigned int n)
 {
     bool page_already_protected;
 
@@ -625,15 +707,21 @@ static inline void tb_page_add(PageDesc *p, TranslationBlock *tb,
     }
 }
 
-static void tb_record(TranslationBlock *tb, PageDesc *p1, PageDesc *p2)
+static void tb_record(TranslationBlock *tb)
 {
-    tb_page_add(p1, tb, 0);
-    if (unlikely(p2)) {
-        tb_page_add(p2, tb, 1);
+    tb_page_addr_t paddr0 = tb_page_addr0(tb);
+    tb_page_addr_t paddr1 = tb_page_addr1(tb);
+    tb_page_addr_t pindex0 = paddr0 >> TARGET_PAGE_BITS;
+    tb_page_addr_t pindex1 = paddr0 >> TARGET_PAGE_BITS;
+
+    assert(paddr0 != -1);
+    if (unlikely(paddr1 != -1) && pindex0 != pindex1) {
+        tb_page_add(page_find_alloc(pindex1, false), tb, 1);
     }
+    tb_page_add(page_find_alloc(pindex0, false), tb, 0);
 }
 
-static inline void tb_page_remove(PageDesc *pd, TranslationBlock *tb)
+static void tb_page_remove(PageDesc *pd, TranslationBlock *tb)
 {
     TranslationBlock *tb1;
     uintptr_t *pprev;
@@ -653,74 +741,16 @@ static inline void tb_page_remove(PageDesc *pd, TranslationBlock *tb)
 
 static void tb_remove(TranslationBlock *tb)
 {
-    PageDesc *pd;
+    tb_page_addr_t paddr0 = tb_page_addr0(tb);
+    tb_page_addr_t paddr1 = tb_page_addr1(tb);
+    tb_page_addr_t pindex0 = paddr0 >> TARGET_PAGE_BITS;
+    tb_page_addr_t pindex1 = paddr0 >> TARGET_PAGE_BITS;
 
-    pd = page_find(tb->page_addr[0] >> TARGET_PAGE_BITS);
-    tb_page_remove(pd, tb);
-    if (unlikely(tb->page_addr[1] != -1)) {
-        pd = page_find(tb->page_addr[1] >> TARGET_PAGE_BITS);
-        tb_page_remove(pd, tb);
-    }
-}
-
-static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
-                           PageDesc **ret_p2, tb_page_addr_t phys2, bool alloc)
-{
-    PageDesc *p1, *p2;
-    tb_page_addr_t page1;
-    tb_page_addr_t page2;
-
-    assert_memory_lock();
-    g_assert(phys1 != -1);
-
-    page1 = phys1 >> TARGET_PAGE_BITS;
-    page2 = phys2 >> TARGET_PAGE_BITS;
-
-    p1 = page_find_alloc(page1, alloc);
-    if (ret_p1) {
-        *ret_p1 = p1;
-    }
-    if (likely(phys2 == -1)) {
-        page_lock(p1);
-        return;
-    } else if (page1 == page2) {
-        page_lock(p1);
-        if (ret_p2) {
-            *ret_p2 = p1;
-        }
-        return;
-    }
-    p2 = page_find_alloc(page2, alloc);
-    if (ret_p2) {
-        *ret_p2 = p2;
-    }
-    if (page1 < page2) {
-        page_lock(p1);
-        page_lock(p2);
-    } else {
-        page_lock(p2);
-        page_lock(p1);
-    }
-}
-
-/* lock the page(s) of a TB in the correct acquisition order */
-static void page_lock_tb(const TranslationBlock *tb)
-{
-    page_lock_pair(NULL, tb_page_addr0(tb), NULL, tb_page_addr1(tb), false);
-}
-
-static void page_unlock_tb(const TranslationBlock *tb)
-{
-    PageDesc *p1 = page_find(tb_page_addr0(tb) >> TARGET_PAGE_BITS);
-
-    page_unlock(p1);
-    if (unlikely(tb_page_addr1(tb) != -1)) {
-        PageDesc *p2 = page_find(tb_page_addr1(tb) >> TARGET_PAGE_BITS);
-
-        if (p2 != p1) {
-            page_unlock(p2);
-        }
+    assert(paddr0 != -1);
+    if (unlikely(paddr1 != -1) && pindex0 != pindex1) {
+        tb_page_remove(page_find_alloc(pindex1, false), tb);
     }
+    tb_page_remove(page_find_alloc(pindex0, false), tb);
 }
 #endif /* CONFIG_USER_ONLY */
 
@@ -925,18 +955,16 @@ static void tb_phys_invalidate__locked(TranslationBlock *tb)
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
 {
     if (page_addr == -1 && tb_page_addr0(tb) != -1) {
-        page_lock_tb(tb);
+        tb_lock_pages(tb);
         do_tb_phys_invalidate(tb, true);
-        page_unlock_tb(tb);
+        tb_unlock_pages(tb);
     } else {
         do_tb_phys_invalidate(tb, false);
     }
 }
 
 /*
- * Add a new TB and link it to the physical page tables. phys_page2 is
- * (-1) to indicate that only one page contains the TB.
- *
+ * Add a new TB and link it to the physical page tables.
  * Called with mmap_lock held for user-mode emulation.
  *
  * Returns a pointer @tb, or a pointer to an existing TB that matches @tb.
@@ -944,43 +972,29 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
  * for the same block of guest code that @tb corresponds to. In that case,
  * the caller should discard the original @tb, and use instead the returned TB.
  */
-TranslationBlock *tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
-                               tb_page_addr_t phys_page2)
+TranslationBlock *tb_link_page(TranslationBlock *tb)
 {
-    PageDesc *p;
-    PageDesc *p2 = NULL;
     void *existing_tb = NULL;
     uint32_t h;
 
     assert_memory_lock();
     tcg_debug_assert(!(tb->cflags & CF_INVALID));
 
-    /*
-     * Add the TB to the page list, acquiring first the pages's locks.
-     * We keep the locks held until after inserting the TB in the hash table,
-     * so that if the insertion fails we know for sure that the TBs are still
-     * in the page descriptors.
-     * Note that inserting into the hash table first isn't an option, since
-     * we can only insert TBs that are fully initialized.
-     */
-    page_lock_pair(&p, phys_pc, &p2, phys_page2, true);
-    tb_record(tb, p, p2);
+    tb_record(tb);
 
     /* add in the hash table */
-    h = tb_hash_func(phys_pc, (tb->cflags & CF_PCREL ? 0 : tb->pc),
+    h = tb_hash_func(tb_page_addr0(tb), (tb->cflags & CF_PCREL ? 0 : tb->pc),
                      tb->flags, tb->cs_base, tb->cflags);
     qht_insert(&tb_ctx.htable, tb, h, &existing_tb);
 
     /* remove TB from the page(s) if we couldn't insert it */
     if (unlikely(existing_tb)) {
         tb_remove(tb);
-        tb = existing_tb;
+        tb_unlock_pages(tb);
+        return existing_tb;
     }
 
-    if (p2 && p2 != p) {
-        page_unlock(p2);
-    }
-    page_unlock(p);
+    tb_unlock_pages(tb);
     return tb;
 }
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d3d4fbc1a4..4c17474fa2 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -290,7 +290,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 {
     CPUArchState *env = cpu->env_ptr;
     TranslationBlock *tb, *existing_tb;
-    tb_page_addr_t phys_pc;
+    tb_page_addr_t phys_pc, phys_p2;
     tcg_insn_unit *gen_code_buf;
     int gen_code_size, search_size, max_insns;
     int64_t ti;
@@ -313,6 +313,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     QEMU_BUILD_BUG_ON(CF_COUNT_MASK + 1 != TCG_MAX_INSNS);
 
  buffer_overflow:
+    assert_no_pages_locked();
     tb = tcg_tb_alloc(tcg_ctx);
     if (unlikely(!tb)) {
         /* flush must be done */
@@ -333,6 +334,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->cflags = cflags;
     tb_set_page_addr0(tb, phys_pc);
     tb_set_page_addr1(tb, -1);
+    if (phys_pc != -1) {
+        tb_lock_page0(phys_pc);
+    }
+
     tcg_ctx->gen_tb = tb;
     tcg_ctx->addr_type = TARGET_LONG_BITS == 32 ? TCG_TYPE_I32 : TCG_TYPE_I64;
 #ifdef CONFIG_SOFTMMU
@@ -349,8 +354,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->guest_mo = TCG_MO_ALL;
 #endif
 
- tb_overflow:
-
+ restart_translate:
     trace_translate_block(tb, pc, tb->tc.ptr);
 
     gen_code_size = setjmp_gen_code(env, tb, pc, host_pc, &max_insns, &ti);
@@ -369,6 +373,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
             qemu_log_mask(CPU_LOG_TB_OP | CPU_LOG_TB_OP_OPT,
                           "Restarting code generation for "
                           "code_gen_buffer overflow\n");
+            tb_unlock_pages(tb);
             goto buffer_overflow;
 
         case -2:
@@ -387,14 +392,39 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
                           "Restarting code generation with "
                           "smaller translation block (max %d insns)\n",
                           max_insns);
-            goto tb_overflow;
+
+            /*
+             * The half-sized TB may not cross pages.
+             * TODO: Fix all targets that cross pages except with
+             * the first insn, at which point this can't be reached.
+             */
+            phys_p2 = tb_page_addr1(tb);
+            if (unlikely(phys_p2 != -1)) {
+                tb_unlock_page1(phys_pc, phys_p2);
+                tb_set_page_addr1(tb, -1);
+            }
+            goto restart_translate;
+
+        case -3:
+            /*
+             * We had a page lock ordering problem.  In order to avoid
+             * deadlock we had to drop the lock on page0, which means
+             * that everything we translated so far is compromised.
+             * Restart with locks held on both pages.
+             */
+            qemu_log_mask(CPU_LOG_TB_OP | CPU_LOG_TB_OP_OPT,
+                          "Restarting code generation with re-locked pages");
+            goto restart_translate;
 
         default:
             g_assert_not_reached();
         }
     }
+    tcg_ctx->gen_tb = NULL;
+
     search_size = encode_search(tb, (void *)gen_code_buf + gen_code_size);
     if (unlikely(search_size < 0)) {
+        tb_unlock_pages(tb);
         goto buffer_overflow;
     }
     tb->tc.size = gen_code_size;
@@ -504,6 +534,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
      * before attempting to link to other TBs or add to the lookup table.
      */
     if (tb_page_addr0(tb) == -1) {
+        assert_no_pages_locked();
         return tb;
     }
 
@@ -518,7 +549,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
      * No explicit memory barrier is required -- tb_link_page() makes the
      * TB visible in a consistent state.
      */
-    existing_tb = tb_link_page(tb, tb_page_addr0(tb), tb_page_addr1(tb));
+    existing_tb = tb_link_page(tb);
+    assert_no_pages_locked();
+
     /* if the TB already exists, discard what we just translated */
     if (unlikely(existing_tb != tb)) {
         uintptr_t orig_aligned = (uintptr_t)gen_code_buf;
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 0fd9efceba..1a6a5448c8 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -12,9 +12,9 @@
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
 #include "exec/translator.h"
-#include "exec/translate-all.h"
 #include "exec/plugin-gen.h"
 #include "tcg/tcg-op-common.h"
+#include "internal.h"
 
 static void gen_io_start(void)
 {
@@ -147,10 +147,6 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->host_addr[0] = host_pc;
     db->host_addr[1] = NULL;
 
-#ifdef CONFIG_USER_ONLY
-    page_protect(pc);
-#endif
-
     ops->init_disas_context(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
@@ -256,22 +252,36 @@ static void *translator_access(CPUArchState *env, DisasContextBase *db,
         host = db->host_addr[1];
         base = TARGET_PAGE_ALIGN(db->pc_first);
         if (host == NULL) {
-            tb_page_addr_t phys_page =
-                get_page_addr_code_hostp(env, base, &db->host_addr[1]);
+            tb_page_addr_t page0, old_page1, new_page1;
+
+            new_page1 = get_page_addr_code_hostp(env, base, &db->host_addr[1]);
 
             /*
              * If the second page is MMIO, treat as if the first page
              * was MMIO as well, so that we do not cache the TB.
              */
-            if (unlikely(phys_page == -1)) {
+            if (unlikely(new_page1 == -1)) {
+                tb_unlock_pages(tb);
                 tb_set_page_addr0(tb, -1);
                 return NULL;
             }
 
-            tb_set_page_addr1(tb, phys_page);
-#ifdef CONFIG_USER_ONLY
-            page_protect(end);
-#endif
+            /*
+             * If this is not the first time around, and page1 matches,
+             * then we already have the page locked.  Alternately, we're
+             * not doing anything to prevent the PTE from changing, so
+             * we might wind up with a different page, requiring us to
+             * re-do the locking.
+             */
+            old_page1 = tb_page_addr1(tb);
+            if (likely(new_page1 != old_page1)) {
+                page0 = tb_page_addr0(tb);
+                if (unlikely(old_page1 != -1)) {
+                    tb_unlock_page1(page0, old_page1);
+                }
+                tb_set_page_addr1(tb, new_page1);
+                tb_lock_page1(page0, new_page1);
+            }
             host = db->host_addr[1];
         }
 
-- 
2.34.1


