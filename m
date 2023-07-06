Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A59D74A471
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 21:34:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHUjL-0006sR-Un; Thu, 06 Jul 2023 15:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1qHUjK-0006s4-Em
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:33:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1qHUjE-00081A-4A
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688672001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KRVsyYv6aNoLkRejitJfgohzwzz6dlYlMCYSOHBDHd0=;
 b=hAn1ztkSdc5BnWjhrKS3at6uVr0mQkloTiLZEeHcJmUOQDQ6Obz69Zan+0xyNVE5uOTuPr
 14hWskYT/8jDtBUwtd4RMPau38f9h67EPcE1Yeetg3ptOBBgA45xaxNWOi4ZfdMNFycx6Z
 VSq8+ISbXSIOOOHQ8RwddCsStPYJtCQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-iDwDJ8XZMC-Q6zCwQkmm-Q-1; Thu, 06 Jul 2023 15:33:18 -0400
X-MC-Unique: iDwDJ8XZMC-Q6zCwQkmm-Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86B15104458C;
 Thu,  6 Jul 2023 19:33:17 +0000 (UTC)
Received: from localhost (unknown [10.42.28.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02C16492B01;
 Thu,  6 Jul 2023 19:33:16 +0000 (UTC)
Date: Thu, 6 Jul 2023 20:33:16 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peterz@infradead.org, arnd@arndb.de,
 naresh.kamboju@linaro.org, anders.roxell@linaro.org,
 daniel.diaz@linaro.org, ben.copeland@linaro.org,
 pbonzini@redhat.com, Liren Wei <lrwei@bupt.edu.cn>
Subject: Re: [PATCH 2/2] accel/tcg: Always lock pages before translation
Message-ID: <20230706193316.GQ7636@redhat.com>
References: <20230706170537.95959-1-richard.henderson@linaro.org>
 <20230706170537.95959-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706170537.95959-3-richard.henderson@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jul 06, 2023 at 06:05:37PM +0100, Richard Henderson wrote:
> We had done this for user-mode by invoking page_protect
> within the translator loop.  Extend this to handle system
> mode as well.  Move page locking out of tb_link_page.
> 
> Reported-by: Liren Wei <lrwei@bupt.edu.cn>
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Richard W.M. Jones <rjones@redhat.com>

I tested it across two machines, total of 10,000 iterations successfully.
Great fix, thanks.

Rich.

>  accel/tcg/internal.h      |  30 ++++-
>  accel/tcg/cpu-exec.c      |   4 +
>  accel/tcg/tb-maint.c      | 242 ++++++++++++++++++++------------------
>  accel/tcg/translate-all.c |  43 ++++++-
>  accel/tcg/translator.c    |  34 ++++--
>  5 files changed, 220 insertions(+), 133 deletions(-)
> 
> diff --git a/accel/tcg/internal.h b/accel/tcg/internal.h
> index 650c3ac53f..e8cbbde581 100644
> --- a/accel/tcg/internal.h
> +++ b/accel/tcg/internal.h
> @@ -10,6 +10,7 @@
>  #define ACCEL_TCG_INTERNAL_H
>  
>  #include "exec/exec-all.h"
> +#include "exec/translate-all.h"
>  
>  /*
>   * Access to the various translations structures need to be serialised
> @@ -35,6 +36,32 @@ static inline void page_table_config_init(void) { }
>  void page_table_config_init(void);
>  #endif
>  
> +#ifdef CONFIG_USER_ONLY
> +/*
> + * For user-only, page_protect sets the page read-only.
> + * Since most execution is already on read-only pages, and we'd need to
> + * account for other TBs on the same page, defer undoing any page protection
> + * until we receive the write fault.
> + */
> +static inline void tb_lock_page0(tb_page_addr_t p0)
> +{
> +    page_protect(p0);
> +}
> +
> +static inline void tb_lock_page1(tb_page_addr_t p0, tb_page_addr_t p1)
> +{
> +    page_protect(p1);
> +}
> +
> +static inline void tb_unlock_page1(tb_page_addr_t p0, tb_page_addr_t p1) { }
> +static inline void tb_unlock_pages(TranslationBlock *tb) { }
> +#else
> +void tb_lock_page0(tb_page_addr_t);
> +void tb_lock_page1(tb_page_addr_t, tb_page_addr_t);
> +void tb_unlock_page1(tb_page_addr_t, tb_page_addr_t);
> +void tb_unlock_pages(TranslationBlock *);
> +#endif
> +
>  #ifdef CONFIG_SOFTMMU
>  void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
>                                     unsigned size,
> @@ -48,8 +75,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu, vaddr pc,
>  void page_init(void);
>  void tb_htable_init(void);
>  void tb_reset_jump(TranslationBlock *tb, int n);
> -TranslationBlock *tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
> -                               tb_page_addr_t phys_page2);
> +TranslationBlock *tb_link_page(TranslationBlock *tb);
>  bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc);
>  void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
>                                 uintptr_t host_pc);
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 31aa320513..4e9dc0b3ba 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -531,6 +531,10 @@ static void cpu_exec_longjmp_cleanup(CPUState *cpu)
>      /* Non-buggy compilers preserve this; assert the correct value. */
>      g_assert(cpu == current_cpu);
>  
> +    if (tcg_ctx->gen_tb) {
> +        tb_unlock_pages(tcg_ctx->gen_tb);
> +        tcg_ctx->gen_tb = NULL;
> +    }
>  #ifdef CONFIG_USER_ONLY
>      clear_helper_retaddr();
>      if (have_mmap_lock()) {
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index 9566224d18..c406b2f7b7 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -70,17 +70,7 @@ typedef struct PageDesc PageDesc;
>   */
>  #define assert_page_locked(pd) tcg_debug_assert(have_mmap_lock())
>  
> -static inline void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
> -                                  PageDesc **ret_p2, tb_page_addr_t phys2,
> -                                  bool alloc)
> -{
> -    *ret_p1 = NULL;
> -    *ret_p2 = NULL;
> -}
> -
> -static inline void page_unlock(PageDesc *pd) { }
> -static inline void page_lock_tb(const TranslationBlock *tb) { }
> -static inline void page_unlock_tb(const TranslationBlock *tb) { }
> +static inline void tb_lock_pages(const TranslationBlock *tb) { }
>  
>  /*
>   * For user-only, since we are protecting all of memory with a single lock,
> @@ -96,7 +86,7 @@ static void tb_remove_all(void)
>  }
>  
>  /* Call with mmap_lock held. */
> -static void tb_record(TranslationBlock *tb, PageDesc *p1, PageDesc *p2)
> +static void tb_record(TranslationBlock *tb)
>  {
>      vaddr addr;
>      int flags;
> @@ -391,12 +381,108 @@ static void page_lock(PageDesc *pd)
>      qemu_spin_lock(&pd->lock);
>  }
>  
> +/* Like qemu_spin_trylock, returns false on success */
> +static bool page_trylock(PageDesc *pd)
> +{
> +    bool busy = qemu_spin_trylock(&pd->lock);
> +    if (!busy) {
> +        page_lock__debug(pd);
> +    }
> +    return busy;
> +}
> +
>  static void page_unlock(PageDesc *pd)
>  {
>      qemu_spin_unlock(&pd->lock);
>      page_unlock__debug(pd);
>  }
>  
> +void tb_lock_page0(tb_page_addr_t paddr)
> +{
> +    page_lock(page_find_alloc(paddr >> TARGET_PAGE_BITS, true));
> +}
> +
> +void tb_lock_page1(tb_page_addr_t paddr0, tb_page_addr_t paddr1)
> +{
> +    tb_page_addr_t pindex0 = paddr0 >> TARGET_PAGE_BITS;
> +    tb_page_addr_t pindex1 = paddr1 >> TARGET_PAGE_BITS;
> +    PageDesc *pd0, *pd1;
> +
> +    if (pindex0 == pindex1) {
> +        /* Identical pages, and the first page is already locked. */
> +        return;
> +    }
> +
> +    pd1 = page_find_alloc(pindex1, true);
> +    if (pindex0 < pindex1) {
> +        /* Correct locking order, we may block. */
> +        page_lock(pd1);
> +        return;
> +    }
> +
> +    /* Incorrect locking order, we cannot block lest we deadlock. */
> +    if (!page_trylock(pd1)) {
> +        return;
> +    }
> +
> +    /*
> +     * Drop the lock on page0 and get both page locks in the right order.
> +     * Restart translation via longjmp.
> +     */
> +    pd0 = page_find_alloc(pindex0, false);
> +    page_unlock(pd0);
> +    page_lock(pd1);
> +    page_lock(pd0);
> +    siglongjmp(tcg_ctx->jmp_trans, -3);
> +}
> +
> +void tb_unlock_page1(tb_page_addr_t paddr0, tb_page_addr_t paddr1)
> +{
> +    tb_page_addr_t pindex0 = paddr0 >> TARGET_PAGE_BITS;
> +    tb_page_addr_t pindex1 = paddr1 >> TARGET_PAGE_BITS;
> +
> +    if (pindex0 != pindex1) {
> +        page_unlock(page_find_alloc(pindex1, false));
> +    }
> +}
> +
> +static void tb_lock_pages(TranslationBlock *tb)
> +{
> +    tb_page_addr_t paddr0 = tb_page_addr0(tb);
> +    tb_page_addr_t paddr1 = tb_page_addr1(tb);
> +    tb_page_addr_t pindex0 = paddr0 >> TARGET_PAGE_BITS;
> +    tb_page_addr_t pindex1 = paddr1 >> TARGET_PAGE_BITS;
> +
> +    if (unlikely(paddr0 == -1)) {
> +        return;
> +    }
> +    if (unlikely(paddr1 != -1) && pindex0 != pindex1) {
> +        if (pindex0 < pindex1) {
> +            page_lock(page_find_alloc(pindex0, true));
> +            page_lock(page_find_alloc(pindex1, true));
> +            return;
> +        }
> +        page_lock(page_find_alloc(pindex1, true));
> +    }
> +    page_lock(page_find_alloc(pindex0, true));
> +}
> +
> +void tb_unlock_pages(TranslationBlock *tb)
> +{
> +    tb_page_addr_t paddr0 = tb_page_addr0(tb);
> +    tb_page_addr_t paddr1 = tb_page_addr1(tb);
> +    tb_page_addr_t pindex0 = paddr0 >> TARGET_PAGE_BITS;
> +    tb_page_addr_t pindex1 = paddr1 >> TARGET_PAGE_BITS;
> +
> +    if (unlikely(paddr0 == -1)) {
> +        return;
> +    }
> +    if (unlikely(paddr1 != -1) && pindex0 != pindex1) {
> +        page_unlock(page_find_alloc(pindex1, false));
> +    }
> +    page_unlock(page_find_alloc(pindex0, false));
> +}
> +
>  static inline struct page_entry *
>  page_entry_new(PageDesc *pd, tb_page_addr_t index)
>  {
> @@ -420,13 +506,10 @@ static void page_entry_destroy(gpointer p)
>  /* returns false on success */
>  static bool page_entry_trylock(struct page_entry *pe)
>  {
> -    bool busy;
> -
> -    busy = qemu_spin_trylock(&pe->pd->lock);
> +    bool busy = page_trylock(pe->pd);
>      if (!busy) {
>          g_assert(!pe->locked);
>          pe->locked = true;
> -        page_lock__debug(pe->pd);
>      }
>      return busy;
>  }
> @@ -604,8 +687,7 @@ static void tb_remove_all(void)
>   * Add the tb in the target page and protect it if necessary.
>   * Called with @p->lock held.
>   */
> -static inline void tb_page_add(PageDesc *p, TranslationBlock *tb,
> -                               unsigned int n)
> +static void tb_page_add(PageDesc *p, TranslationBlock *tb, unsigned int n)
>  {
>      bool page_already_protected;
>  
> @@ -625,15 +707,21 @@ static inline void tb_page_add(PageDesc *p, TranslationBlock *tb,
>      }
>  }
>  
> -static void tb_record(TranslationBlock *tb, PageDesc *p1, PageDesc *p2)
> +static void tb_record(TranslationBlock *tb)
>  {
> -    tb_page_add(p1, tb, 0);
> -    if (unlikely(p2)) {
> -        tb_page_add(p2, tb, 1);
> +    tb_page_addr_t paddr0 = tb_page_addr0(tb);
> +    tb_page_addr_t paddr1 = tb_page_addr1(tb);
> +    tb_page_addr_t pindex0 = paddr0 >> TARGET_PAGE_BITS;
> +    tb_page_addr_t pindex1 = paddr0 >> TARGET_PAGE_BITS;
> +
> +    assert(paddr0 != -1);
> +    if (unlikely(paddr1 != -1) && pindex0 != pindex1) {
> +        tb_page_add(page_find_alloc(pindex1, false), tb, 1);
>      }
> +    tb_page_add(page_find_alloc(pindex0, false), tb, 0);
>  }
>  
> -static inline void tb_page_remove(PageDesc *pd, TranslationBlock *tb)
> +static void tb_page_remove(PageDesc *pd, TranslationBlock *tb)
>  {
>      TranslationBlock *tb1;
>      uintptr_t *pprev;
> @@ -653,74 +741,16 @@ static inline void tb_page_remove(PageDesc *pd, TranslationBlock *tb)
>  
>  static void tb_remove(TranslationBlock *tb)
>  {
> -    PageDesc *pd;
> +    tb_page_addr_t paddr0 = tb_page_addr0(tb);
> +    tb_page_addr_t paddr1 = tb_page_addr1(tb);
> +    tb_page_addr_t pindex0 = paddr0 >> TARGET_PAGE_BITS;
> +    tb_page_addr_t pindex1 = paddr0 >> TARGET_PAGE_BITS;
>  
> -    pd = page_find(tb->page_addr[0] >> TARGET_PAGE_BITS);
> -    tb_page_remove(pd, tb);
> -    if (unlikely(tb->page_addr[1] != -1)) {
> -        pd = page_find(tb->page_addr[1] >> TARGET_PAGE_BITS);
> -        tb_page_remove(pd, tb);
> -    }
> -}
> -
> -static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
> -                           PageDesc **ret_p2, tb_page_addr_t phys2, bool alloc)
> -{
> -    PageDesc *p1, *p2;
> -    tb_page_addr_t page1;
> -    tb_page_addr_t page2;
> -
> -    assert_memory_lock();
> -    g_assert(phys1 != -1);
> -
> -    page1 = phys1 >> TARGET_PAGE_BITS;
> -    page2 = phys2 >> TARGET_PAGE_BITS;
> -
> -    p1 = page_find_alloc(page1, alloc);
> -    if (ret_p1) {
> -        *ret_p1 = p1;
> -    }
> -    if (likely(phys2 == -1)) {
> -        page_lock(p1);
> -        return;
> -    } else if (page1 == page2) {
> -        page_lock(p1);
> -        if (ret_p2) {
> -            *ret_p2 = p1;
> -        }
> -        return;
> -    }
> -    p2 = page_find_alloc(page2, alloc);
> -    if (ret_p2) {
> -        *ret_p2 = p2;
> -    }
> -    if (page1 < page2) {
> -        page_lock(p1);
> -        page_lock(p2);
> -    } else {
> -        page_lock(p2);
> -        page_lock(p1);
> -    }
> -}
> -
> -/* lock the page(s) of a TB in the correct acquisition order */
> -static void page_lock_tb(const TranslationBlock *tb)
> -{
> -    page_lock_pair(NULL, tb_page_addr0(tb), NULL, tb_page_addr1(tb), false);
> -}
> -
> -static void page_unlock_tb(const TranslationBlock *tb)
> -{
> -    PageDesc *p1 = page_find(tb_page_addr0(tb) >> TARGET_PAGE_BITS);
> -
> -    page_unlock(p1);
> -    if (unlikely(tb_page_addr1(tb) != -1)) {
> -        PageDesc *p2 = page_find(tb_page_addr1(tb) >> TARGET_PAGE_BITS);
> -
> -        if (p2 != p1) {
> -            page_unlock(p2);
> -        }
> +    assert(paddr0 != -1);
> +    if (unlikely(paddr1 != -1) && pindex0 != pindex1) {
> +        tb_page_remove(page_find_alloc(pindex1, false), tb);
>      }
> +    tb_page_remove(page_find_alloc(pindex0, false), tb);
>  }
>  #endif /* CONFIG_USER_ONLY */
>  
> @@ -925,18 +955,16 @@ static void tb_phys_invalidate__locked(TranslationBlock *tb)
>  void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
>  {
>      if (page_addr == -1 && tb_page_addr0(tb) != -1) {
> -        page_lock_tb(tb);
> +        tb_lock_pages(tb);
>          do_tb_phys_invalidate(tb, true);
> -        page_unlock_tb(tb);
> +        tb_unlock_pages(tb);
>      } else {
>          do_tb_phys_invalidate(tb, false);
>      }
>  }
>  
>  /*
> - * Add a new TB and link it to the physical page tables. phys_page2 is
> - * (-1) to indicate that only one page contains the TB.
> - *
> + * Add a new TB and link it to the physical page tables.
>   * Called with mmap_lock held for user-mode emulation.
>   *
>   * Returns a pointer @tb, or a pointer to an existing TB that matches @tb.
> @@ -944,43 +972,29 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
>   * for the same block of guest code that @tb corresponds to. In that case,
>   * the caller should discard the original @tb, and use instead the returned TB.
>   */
> -TranslationBlock *tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
> -                               tb_page_addr_t phys_page2)
> +TranslationBlock *tb_link_page(TranslationBlock *tb)
>  {
> -    PageDesc *p;
> -    PageDesc *p2 = NULL;
>      void *existing_tb = NULL;
>      uint32_t h;
>  
>      assert_memory_lock();
>      tcg_debug_assert(!(tb->cflags & CF_INVALID));
>  
> -    /*
> -     * Add the TB to the page list, acquiring first the pages's locks.
> -     * We keep the locks held until after inserting the TB in the hash table,
> -     * so that if the insertion fails we know for sure that the TBs are still
> -     * in the page descriptors.
> -     * Note that inserting into the hash table first isn't an option, since
> -     * we can only insert TBs that are fully initialized.
> -     */
> -    page_lock_pair(&p, phys_pc, &p2, phys_page2, true);
> -    tb_record(tb, p, p2);
> +    tb_record(tb);
>  
>      /* add in the hash table */
> -    h = tb_hash_func(phys_pc, (tb->cflags & CF_PCREL ? 0 : tb->pc),
> +    h = tb_hash_func(tb_page_addr0(tb), (tb->cflags & CF_PCREL ? 0 : tb->pc),
>                       tb->flags, tb->cs_base, tb->cflags);
>      qht_insert(&tb_ctx.htable, tb, h, &existing_tb);
>  
>      /* remove TB from the page(s) if we couldn't insert it */
>      if (unlikely(existing_tb)) {
>          tb_remove(tb);
> -        tb = existing_tb;
> +        tb_unlock_pages(tb);
> +        return existing_tb;
>      }
>  
> -    if (p2 && p2 != p) {
> -        page_unlock(p2);
> -    }
> -    page_unlock(p);
> +    tb_unlock_pages(tb);
>      return tb;
>  }
>  
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index d3d4fbc1a4..4c17474fa2 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -290,7 +290,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>  {
>      CPUArchState *env = cpu->env_ptr;
>      TranslationBlock *tb, *existing_tb;
> -    tb_page_addr_t phys_pc;
> +    tb_page_addr_t phys_pc, phys_p2;
>      tcg_insn_unit *gen_code_buf;
>      int gen_code_size, search_size, max_insns;
>      int64_t ti;
> @@ -313,6 +313,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      QEMU_BUILD_BUG_ON(CF_COUNT_MASK + 1 != TCG_MAX_INSNS);
>  
>   buffer_overflow:
> +    assert_no_pages_locked();
>      tb = tcg_tb_alloc(tcg_ctx);
>      if (unlikely(!tb)) {
>          /* flush must be done */
> @@ -333,6 +334,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      tb->cflags = cflags;
>      tb_set_page_addr0(tb, phys_pc);
>      tb_set_page_addr1(tb, -1);
> +    if (phys_pc != -1) {
> +        tb_lock_page0(phys_pc);
> +    }
> +
>      tcg_ctx->gen_tb = tb;
>      tcg_ctx->addr_type = TARGET_LONG_BITS == 32 ? TCG_TYPE_I32 : TCG_TYPE_I64;
>  #ifdef CONFIG_SOFTMMU
> @@ -349,8 +354,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      tcg_ctx->guest_mo = TCG_MO_ALL;
>  #endif
>  
> - tb_overflow:
> -
> + restart_translate:
>      trace_translate_block(tb, pc, tb->tc.ptr);
>  
>      gen_code_size = setjmp_gen_code(env, tb, pc, host_pc, &max_insns, &ti);
> @@ -369,6 +373,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>              qemu_log_mask(CPU_LOG_TB_OP | CPU_LOG_TB_OP_OPT,
>                            "Restarting code generation for "
>                            "code_gen_buffer overflow\n");
> +            tb_unlock_pages(tb);
>              goto buffer_overflow;
>  
>          case -2:
> @@ -387,14 +392,39 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>                            "Restarting code generation with "
>                            "smaller translation block (max %d insns)\n",
>                            max_insns);
> -            goto tb_overflow;
> +
> +            /*
> +             * The half-sized TB may not cross pages.
> +             * TODO: Fix all targets that cross pages except with
> +             * the first insn, at which point this can't be reached.
> +             */
> +            phys_p2 = tb_page_addr1(tb);
> +            if (unlikely(phys_p2 != -1)) {
> +                tb_unlock_page1(phys_pc, phys_p2);
> +                tb_set_page_addr1(tb, -1);
> +            }
> +            goto restart_translate;
> +
> +        case -3:
> +            /*
> +             * We had a page lock ordering problem.  In order to avoid
> +             * deadlock we had to drop the lock on page0, which means
> +             * that everything we translated so far is compromised.
> +             * Restart with locks held on both pages.
> +             */
> +            qemu_log_mask(CPU_LOG_TB_OP | CPU_LOG_TB_OP_OPT,
> +                          "Restarting code generation with re-locked pages");
> +            goto restart_translate;
>  
>          default:
>              g_assert_not_reached();
>          }
>      }
> +    tcg_ctx->gen_tb = NULL;
> +
>      search_size = encode_search(tb, (void *)gen_code_buf + gen_code_size);
>      if (unlikely(search_size < 0)) {
> +        tb_unlock_pages(tb);
>          goto buffer_overflow;
>      }
>      tb->tc.size = gen_code_size;
> @@ -504,6 +534,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       * before attempting to link to other TBs or add to the lookup table.
>       */
>      if (tb_page_addr0(tb) == -1) {
> +        assert_no_pages_locked();
>          return tb;
>      }
>  
> @@ -518,7 +549,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       * No explicit memory barrier is required -- tb_link_page() makes the
>       * TB visible in a consistent state.
>       */
> -    existing_tb = tb_link_page(tb, tb_page_addr0(tb), tb_page_addr1(tb));
> +    existing_tb = tb_link_page(tb);
> +    assert_no_pages_locked();
> +
>      /* if the TB already exists, discard what we just translated */
>      if (unlikely(existing_tb != tb)) {
>          uintptr_t orig_aligned = (uintptr_t)gen_code_buf;
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 0fd9efceba..1a6a5448c8 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -12,9 +12,9 @@
>  #include "qemu/error-report.h"
>  #include "exec/exec-all.h"
>  #include "exec/translator.h"
> -#include "exec/translate-all.h"
>  #include "exec/plugin-gen.h"
>  #include "tcg/tcg-op-common.h"
> +#include "internal.h"
>  
>  static void gen_io_start(void)
>  {
> @@ -147,10 +147,6 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
>      db->host_addr[0] = host_pc;
>      db->host_addr[1] = NULL;
>  
> -#ifdef CONFIG_USER_ONLY
> -    page_protect(pc);
> -#endif
> -
>      ops->init_disas_context(db, cpu);
>      tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
>  
> @@ -256,22 +252,36 @@ static void *translator_access(CPUArchState *env, DisasContextBase *db,
>          host = db->host_addr[1];
>          base = TARGET_PAGE_ALIGN(db->pc_first);
>          if (host == NULL) {
> -            tb_page_addr_t phys_page =
> -                get_page_addr_code_hostp(env, base, &db->host_addr[1]);
> +            tb_page_addr_t page0, old_page1, new_page1;
> +
> +            new_page1 = get_page_addr_code_hostp(env, base, &db->host_addr[1]);
>  
>              /*
>               * If the second page is MMIO, treat as if the first page
>               * was MMIO as well, so that we do not cache the TB.
>               */
> -            if (unlikely(phys_page == -1)) {
> +            if (unlikely(new_page1 == -1)) {
> +                tb_unlock_pages(tb);
>                  tb_set_page_addr0(tb, -1);
>                  return NULL;
>              }
>  
> -            tb_set_page_addr1(tb, phys_page);
> -#ifdef CONFIG_USER_ONLY
> -            page_protect(end);
> -#endif
> +            /*
> +             * If this is not the first time around, and page1 matches,
> +             * then we already have the page locked.  Alternately, we're
> +             * not doing anything to prevent the PTE from changing, so
> +             * we might wind up with a different page, requiring us to
> +             * re-do the locking.
> +             */
> +            old_page1 = tb_page_addr1(tb);
> +            if (likely(new_page1 != old_page1)) {
> +                page0 = tb_page_addr0(tb);
> +                if (unlikely(old_page1 != -1)) {
> +                    tb_unlock_page1(page0, old_page1);
> +                }
> +                tb_set_page_addr1(tb, new_page1);
> +                tb_lock_page1(page0, new_page1);
> +            }
>              host = db->host_addr[1];
>          }
>  
> -- 
> 2.34.1

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
nbdkit - Flexible, fast NBD server with plugins
https://gitlab.com/nbdkit/nbdkit


