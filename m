Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 550297A32A5
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:43:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd3P-0005Ew-VD; Sat, 16 Sep 2023 17:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd30-0005Bu-Qj
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:51 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2v-0000Ss-6f
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:50 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68fb79ef55eso3072283b3a.0
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900503; x=1695505303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+MOXHAYWRt1NBMGx/8qJG158g8ws8XFH4dqMDtNCnIk=;
 b=YbIb2cL89mwCNLh2gQiphaTbVoeZaOt/zlA+SzAU33WbDGOzF6QIlFGOesgOjF4E5g
 SbmOWxpfyT4GYgY8XHrP8mbAqRDpQmP/uNZ0AOjxZCvbvl04TNnuOiLGXcKWjG7laUpT
 K78GusNeCtDa3Nkn09mFvrbRKzv62Ju+dTT29HYhsg3a4BFv6hu8eSoQpqS4LtUGoNpS
 gqykfiCPILFZj1zIKB6oWjOVd6dByTxH92byocHrHAp9MY6J5lRdW6cyENC4OvxMBVpS
 JsGb4+ORa6HQvt1sS2iebBk6JQHNLqPD2/3J7J8LNRXuyeFatSOlX44jkpQRDtMhMgwL
 AxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900503; x=1695505303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+MOXHAYWRt1NBMGx/8qJG158g8ws8XFH4dqMDtNCnIk=;
 b=gReh2XGImv1yF3G0QHSP06WgmuDOn/7Dzl6513/zk26HjqvUdRz+zEpuIiaGQk7ZNU
 G2EgFmUw1swNoaGKKgC4bKeqxS43VsHskx89lEuTJSSaHBZaKP2PeRSsQatie3lpoGAe
 +ITOivgds6CVkwqJGwDLc6UwVEOEaDGFjqK0IvXOOZnHGft4J8NEkARAohuzJXH0bcL1
 b7N9+8eYulxJMsKNbmHs0fwNWqQZkMKOIaNO9YimhEWqcee1bYtKFb7YimsP/pd6qYXl
 BRLsISeY92qw1ZdfXMul9d/CHf2aLfbp/0hIQTqCX6wxJpvmKpLtYT/bKkkI6lLBOb73
 ptzQ==
X-Gm-Message-State: AOJu0Ywwqt6984twId4rlqTAsBxDNARb19IBOMvNj76p+yzDzNagLdBC
 jDXywYsDeLtbCNsy2dbxG5Fr2vFCl0Hly4ojX/U=
X-Google-Smtp-Source: AGHT+IEZ6jF2AyQXlyE13H5t/ilkoaxuAcGDRLc10wIOjbsl42Mruys9ubzI9Il2fWl6QremqSM12g==
X-Received: by 2002:a05:6a00:1490:b0:690:454a:dc7b with SMTP id
 v16-20020a056a00149000b00690454adc7bmr6778917pfu.28.1694900503488; 
 Sat, 16 Sep 2023 14:41:43 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 18/39] accel/tcg: Modify memory access functions to use
 CPUState
Date: Sat, 16 Sep 2023 14:41:02 -0700
Message-Id: <20230916214123.525796-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Anton Johansson <anjo@rev.ng>

do_[ld|st]*() and mmu_lookup*() are changed to use CPUState over
CPUArchState, moving the target-dependence to the target-facing facing
cpu_[ld|st] functions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230912153428.17816-6-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[rth: Use cpu->neg.tlb instead of cpu_tlb; cpu_env instead of env_ptr.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 348 ++++++++++++++++++++++-----------------------
 1 file changed, 171 insertions(+), 177 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ab52afb3f3..0e4bc82294 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1339,10 +1339,9 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
 }
 
 static MemoryRegionSection *
-io_prepare(hwaddr *out_offset, CPUArchState *env, hwaddr xlat,
+io_prepare(hwaddr *out_offset, CPUState *cpu, hwaddr xlat,
            MemTxAttrs attrs, vaddr addr, uintptr_t retaddr)
 {
-    CPUState *cpu = env_cpu(env);
     MemoryRegionSection *section;
     hwaddr mr_offset;
 
@@ -1357,22 +1356,17 @@ io_prepare(hwaddr *out_offset, CPUArchState *env, hwaddr xlat,
     return section;
 }
 
-static void io_failed(CPUArchState *env, CPUTLBEntryFull *full, vaddr addr,
+static void io_failed(CPUState *cpu, CPUTLBEntryFull *full, vaddr addr,
                       unsigned size, MMUAccessType access_type, int mmu_idx,
                       MemTxResult response, uintptr_t retaddr)
 {
-    CPUState *cpu = env_cpu(env);
+    if (!cpu->ignore_memory_transaction_failures
+        && cpu->cc->tcg_ops->do_transaction_failed) {
+        hwaddr physaddr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
 
-    if (!cpu->ignore_memory_transaction_failures) {
-        CPUClass *cc = CPU_GET_CLASS(cpu);
-
-        if (cc->tcg_ops->do_transaction_failed) {
-            hwaddr physaddr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
-
-            cc->tcg_ops->do_transaction_failed(cpu, physaddr, addr, size,
-                                               access_type, mmu_idx,
-                                               full->attrs, response, retaddr);
-        }
+        cpu->cc->tcg_ops->do_transaction_failed(cpu, physaddr, addr, size,
+                                                access_type, mmu_idx,
+                                                full->attrs, response, retaddr);
     }
 }
 
@@ -1700,7 +1694,7 @@ typedef struct MMULookupLocals {
 
 /**
  * mmu_lookup1: translate one page
- * @env: cpu context
+ * @cpu: generic cpu state
  * @data: lookup parameters
  * @mmu_idx: virtual address context
  * @access_type: load/store/code
@@ -1711,12 +1705,12 @@ typedef struct MMULookupLocals {
  * tlb_fill will longjmp out.  Return true if the softmmu tlb for
  * @mmu_idx may have resized.
  */
-static bool mmu_lookup1(CPUArchState *env, MMULookupPageData *data,
+static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data,
                         int mmu_idx, MMUAccessType access_type, uintptr_t ra)
 {
     vaddr addr = data->addr;
-    uintptr_t index = tlb_index(env_cpu(env), mmu_idx, addr);
-    CPUTLBEntry *entry = tlb_entry(env_cpu(env), mmu_idx, addr);
+    uintptr_t index = tlb_index(cpu, mmu_idx, addr);
+    CPUTLBEntry *entry = tlb_entry(cpu, mmu_idx, addr);
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
     bool maybe_resized = false;
     CPUTLBEntryFull *full;
@@ -1724,17 +1718,17 @@ static bool mmu_lookup1(CPUArchState *env, MMULookupPageData *data,
 
     /* If the TLB entry is for a different page, reload and try again.  */
     if (!tlb_hit(tlb_addr, addr)) {
-        if (!victim_tlb_hit(env_cpu(env), mmu_idx, index, access_type,
+        if (!victim_tlb_hit(cpu, mmu_idx, index, access_type,
                             addr & TARGET_PAGE_MASK)) {
-            tlb_fill(env_cpu(env), addr, data->size, access_type, mmu_idx, ra);
+            tlb_fill(cpu, addr, data->size, access_type, mmu_idx, ra);
             maybe_resized = true;
-            index = tlb_index(env_cpu(env), mmu_idx, addr);
-            entry = tlb_entry(env_cpu(env), mmu_idx, addr);
+            index = tlb_index(cpu, mmu_idx, addr);
+            entry = tlb_entry(cpu, mmu_idx, addr);
         }
         tlb_addr = tlb_read_idx(entry, access_type) & ~TLB_INVALID_MASK;
     }
 
-    full = &env_tlb(env)->d[mmu_idx].fulltlb[index];
+    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
     flags = tlb_addr & (TLB_FLAGS_MASK & ~TLB_FORCE_SLOW);
     flags |= full->slow_flags[access_type];
 
@@ -1748,7 +1742,7 @@ static bool mmu_lookup1(CPUArchState *env, MMULookupPageData *data,
 
 /**
  * mmu_watch_or_dirty
- * @env: cpu context
+ * @cpu: generic cpu state
  * @data: lookup parameters
  * @access_type: load/store/code
  * @ra: return address into tcg generated code, or 0
@@ -1756,7 +1750,7 @@ static bool mmu_lookup1(CPUArchState *env, MMULookupPageData *data,
  * Trigger watchpoints for @data.addr:@data.size;
  * record writes to protected clean pages.
  */
-static void mmu_watch_or_dirty(CPUArchState *env, MMULookupPageData *data,
+static void mmu_watch_or_dirty(CPUState *cpu, MMULookupPageData *data,
                                MMUAccessType access_type, uintptr_t ra)
 {
     CPUTLBEntryFull *full = data->full;
@@ -1767,13 +1761,13 @@ static void mmu_watch_or_dirty(CPUArchState *env, MMULookupPageData *data,
     /* On watchpoint hit, this will longjmp out.  */
     if (flags & TLB_WATCHPOINT) {
         int wp = access_type == MMU_DATA_STORE ? BP_MEM_WRITE : BP_MEM_READ;
-        cpu_check_watchpoint(env_cpu(env), addr, size, full->attrs, wp, ra);
+        cpu_check_watchpoint(cpu, addr, size, full->attrs, wp, ra);
         flags &= ~TLB_WATCHPOINT;
     }
 
     /* Note that notdirty is only set for writes. */
     if (flags & TLB_NOTDIRTY) {
-        notdirty_write(env_cpu(env), addr, size, full, ra);
+        notdirty_write(cpu, addr, size, full, ra);
         flags &= ~TLB_NOTDIRTY;
     }
     data->flags = flags;
@@ -1781,7 +1775,7 @@ static void mmu_watch_or_dirty(CPUArchState *env, MMULookupPageData *data,
 
 /**
  * mmu_lookup: translate page(s)
- * @env: cpu context
+ * @cpu: generic cpu state
  * @addr: virtual address
  * @oi: combined mmu_idx and MemOp
  * @ra: return address into tcg generated code, or 0
@@ -1791,7 +1785,7 @@ static void mmu_watch_or_dirty(CPUArchState *env, MMULookupPageData *data,
  * Resolve the translation for the page(s) beginning at @addr, for MemOp.size
  * bytes.  Return true if the lookup crosses a page boundary.
  */
-static bool mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
+static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
                        uintptr_t ra, MMUAccessType type, MMULookupLocals *l)
 {
     unsigned a_bits;
@@ -1806,7 +1800,7 @@ static bool mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
     /* Handle CPU specific unaligned behaviour */
     a_bits = get_alignment_bits(l->memop);
     if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(env_cpu(env), addr, type, l->mmu_idx, ra);
+        cpu_unaligned_access(cpu, addr, type, l->mmu_idx, ra);
     }
 
     l->page[0].addr = addr;
@@ -1816,11 +1810,11 @@ static bool mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
     crosspage = (addr ^ l->page[1].addr) & TARGET_PAGE_MASK;
 
     if (likely(!crosspage)) {
-        mmu_lookup1(env, &l->page[0], l->mmu_idx, type, ra);
+        mmu_lookup1(cpu, &l->page[0], l->mmu_idx, type, ra);
 
         flags = l->page[0].flags;
         if (unlikely(flags & (TLB_WATCHPOINT | TLB_NOTDIRTY))) {
-            mmu_watch_or_dirty(env, &l->page[0], type, ra);
+            mmu_watch_or_dirty(cpu, &l->page[0], type, ra);
         }
         if (unlikely(flags & TLB_BSWAP)) {
             l->memop ^= MO_BSWAP;
@@ -1835,16 +1829,16 @@ static bool mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
          * Lookup both pages, recognizing exceptions from either.  If the
          * second lookup potentially resized, refresh first CPUTLBEntryFull.
          */
-        mmu_lookup1(env, &l->page[0], l->mmu_idx, type, ra);
-        if (mmu_lookup1(env, &l->page[1], l->mmu_idx, type, ra)) {
-            uintptr_t index = tlb_index(env_cpu(env), l->mmu_idx, addr);
-            l->page[0].full = &env_tlb(env)->d[l->mmu_idx].fulltlb[index];
+        mmu_lookup1(cpu, &l->page[0], l->mmu_idx, type, ra);
+        if (mmu_lookup1(cpu, &l->page[1], l->mmu_idx, type, ra)) {
+            uintptr_t index = tlb_index(cpu, l->mmu_idx, addr);
+            l->page[0].full = &cpu->neg.tlb.d[l->mmu_idx].fulltlb[index];
         }
 
         flags = l->page[0].flags | l->page[1].flags;
         if (unlikely(flags & (TLB_WATCHPOINT | TLB_NOTDIRTY))) {
-            mmu_watch_or_dirty(env, &l->page[0], type, ra);
-            mmu_watch_or_dirty(env, &l->page[1], type, ra);
+            mmu_watch_or_dirty(cpu, &l->page[0], type, ra);
+            mmu_watch_or_dirty(cpu, &l->page[1], type, ra);
         }
 
         /*
@@ -1984,7 +1978,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
 
 /**
  * do_ld_mmio_beN:
- * @env: cpu context
+ * @cpu: generic cpu state
  * @full: page parameters
  * @ret_be: accumulated data
  * @addr: virtual address
@@ -1996,7 +1990,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
  * Load @size bytes from @addr, which is memory-mapped i/o.
  * The bytes are concatenated in big-endian order with @ret_be.
  */
-static uint64_t int_ld_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
+static uint64_t int_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
                                 uint64_t ret_be, vaddr addr, int size,
                                 int mmu_idx, MMUAccessType type, uintptr_t ra,
                                 MemoryRegion *mr, hwaddr mr_offset)
@@ -2015,7 +2009,7 @@ static uint64_t int_ld_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
         r = memory_region_dispatch_read(mr, mr_offset, &val,
                                         this_mop, full->attrs);
         if (unlikely(r != MEMTX_OK)) {
-            io_failed(env, full, addr, this_size, type, mmu_idx, r, ra);
+            io_failed(cpu, full, addr, this_size, type, mmu_idx, r, ra);
         }
         if (this_size == 8) {
             return val;
@@ -2030,7 +2024,7 @@ static uint64_t int_ld_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
     return ret_be;
 }
 
-static uint64_t do_ld_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
+static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
                                uint64_t ret_be, vaddr addr, int size,
                                int mmu_idx, MMUAccessType type, uintptr_t ra)
 {
@@ -2043,18 +2037,18 @@ static uint64_t do_ld_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 0 && size <= 8);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, env, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
     mr = section->mr;
 
     qemu_mutex_lock_iothread();
-    ret = int_ld_mmio_beN(env, full, ret_be, addr, size, mmu_idx,
+    ret = int_ld_mmio_beN(cpu, full, ret_be, addr, size, mmu_idx,
                           type, ra, mr, mr_offset);
     qemu_mutex_unlock_iothread();
 
     return ret;
 }
 
-static Int128 do_ld16_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
+static Int128 do_ld16_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
                                uint64_t ret_be, vaddr addr, int size,
                                int mmu_idx, uintptr_t ra)
 {
@@ -2067,13 +2061,13 @@ static Int128 do_ld16_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 8 && size <= 16);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, env, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
     mr = section->mr;
 
     qemu_mutex_lock_iothread();
-    a = int_ld_mmio_beN(env, full, ret_be, addr, size - 8, mmu_idx,
+    a = int_ld_mmio_beN(cpu, full, ret_be, addr, size - 8, mmu_idx,
                         MMU_DATA_LOAD, ra, mr, mr_offset);
-    b = int_ld_mmio_beN(env, full, ret_be, addr + size - 8, 8, mmu_idx,
+    b = int_ld_mmio_beN(cpu, full, ret_be, addr + size - 8, 8, mmu_idx,
                         MMU_DATA_LOAD, ra, mr, mr_offset + size - 8);
     qemu_mutex_unlock_iothread();
 
@@ -2174,11 +2168,11 @@ static uint64_t do_ld_whole_be4(MMULookupPageData *p, uint64_t ret_be)
  * As do_ld_bytes_beN, but with one atomic load.
  * Eight aligned bytes are guaranteed to cover the load.
  */
-static uint64_t do_ld_whole_be8(CPUArchState *env, uintptr_t ra,
+static uint64_t do_ld_whole_be8(CPUState *cpu, uintptr_t ra,
                                 MMULookupPageData *p, uint64_t ret_be)
 {
     int o = p->addr & 7;
-    uint64_t x = load_atomic8_or_exit(env, ra, p->haddr - o);
+    uint64_t x = load_atomic8_or_exit(cpu_env(cpu), ra, p->haddr - o);
 
     x = cpu_to_be64(x);
     x <<= o * 8;
@@ -2194,11 +2188,11 @@ static uint64_t do_ld_whole_be8(CPUArchState *env, uintptr_t ra,
  * As do_ld_bytes_beN, but with one atomic load.
  * 16 aligned bytes are guaranteed to cover the load.
  */
-static Int128 do_ld_whole_be16(CPUArchState *env, uintptr_t ra,
+static Int128 do_ld_whole_be16(CPUState *cpu, uintptr_t ra,
                                MMULookupPageData *p, uint64_t ret_be)
 {
     int o = p->addr & 15;
-    Int128 x, y = load_atomic16_or_exit(env, ra, p->haddr - o);
+    Int128 x, y = load_atomic16_or_exit(cpu_env(cpu), ra, p->haddr - o);
     int size = p->size;
 
     if (!HOST_BIG_ENDIAN) {
@@ -2214,7 +2208,7 @@ static Int128 do_ld_whole_be16(CPUArchState *env, uintptr_t ra,
 /*
  * Wrapper for the above.
  */
-static uint64_t do_ld_beN(CPUArchState *env, MMULookupPageData *p,
+static uint64_t do_ld_beN(CPUState *cpu, MMULookupPageData *p,
                           uint64_t ret_be, int mmu_idx, MMUAccessType type,
                           MemOp mop, uintptr_t ra)
 {
@@ -2222,7 +2216,7 @@ static uint64_t do_ld_beN(CPUArchState *env, MMULookupPageData *p,
     unsigned tmp, half_size;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        return do_ld_mmio_beN(env, p->full, ret_be, p->addr, p->size,
+        return do_ld_mmio_beN(cpu, p->full, ret_be, p->addr, p->size,
                               mmu_idx, type, ra);
     }
 
@@ -2246,7 +2240,7 @@ static uint64_t do_ld_beN(CPUArchState *env, MMULookupPageData *p,
             if (!HAVE_al8_fast && p->size < 4) {
                 return do_ld_whole_be4(p, ret_be);
             } else {
-                return do_ld_whole_be8(env, ra, p, ret_be);
+                return do_ld_whole_be8(cpu, ra, p, ret_be);
             }
         }
         /* fall through */
@@ -2264,7 +2258,7 @@ static uint64_t do_ld_beN(CPUArchState *env, MMULookupPageData *p,
 /*
  * Wrapper for the above, for 8 < size < 16.
  */
-static Int128 do_ld16_beN(CPUArchState *env, MMULookupPageData *p,
+static Int128 do_ld16_beN(CPUState *cpu, MMULookupPageData *p,
                           uint64_t a, int mmu_idx, MemOp mop, uintptr_t ra)
 {
     int size = p->size;
@@ -2272,7 +2266,7 @@ static Int128 do_ld16_beN(CPUArchState *env, MMULookupPageData *p,
     MemOp atom;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        return do_ld16_mmio_beN(env, p->full, a, p->addr, size, mmu_idx, ra);
+        return do_ld16_mmio_beN(cpu, p->full, a, p->addr, size, mmu_idx, ra);
     }
 
     /*
@@ -2291,7 +2285,7 @@ static Int128 do_ld16_beN(CPUArchState *env, MMULookupPageData *p,
 
     case MO_ATOM_WITHIN16_PAIR:
         /* Since size > 8, this is the half that must be atomic. */
-        return do_ld_whole_be16(env, ra, p, a);
+        return do_ld_whole_be16(cpu, ra, p, a);
 
     case MO_ATOM_IFALIGN_PAIR:
         /*
@@ -2313,29 +2307,29 @@ static Int128 do_ld16_beN(CPUArchState *env, MMULookupPageData *p,
     return int128_make128(b, a);
 }
 
-static uint8_t do_ld_1(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
+static uint8_t do_ld_1(CPUState *cpu, MMULookupPageData *p, int mmu_idx,
                        MMUAccessType type, uintptr_t ra)
 {
     if (unlikely(p->flags & TLB_MMIO)) {
-        return do_ld_mmio_beN(env, p->full, 0, p->addr, 1, mmu_idx, type, ra);
+        return do_ld_mmio_beN(cpu, p->full, 0, p->addr, 1, mmu_idx, type, ra);
     } else {
         return *(uint8_t *)p->haddr;
     }
 }
 
-static uint16_t do_ld_2(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
+static uint16_t do_ld_2(CPUState *cpu, MMULookupPageData *p, int mmu_idx,
                         MMUAccessType type, MemOp memop, uintptr_t ra)
 {
     uint16_t ret;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        ret = do_ld_mmio_beN(env, p->full, 0, p->addr, 2, mmu_idx, type, ra);
+        ret = do_ld_mmio_beN(cpu, p->full, 0, p->addr, 2, mmu_idx, type, ra);
         if ((memop & MO_BSWAP) == MO_LE) {
             ret = bswap16(ret);
         }
     } else {
         /* Perform the load host endian, then swap if necessary. */
-        ret = load_atom_2(env, ra, p->haddr, memop);
+        ret = load_atom_2(cpu_env(cpu), ra, p->haddr, memop);
         if (memop & MO_BSWAP) {
             ret = bswap16(ret);
         }
@@ -2343,19 +2337,19 @@ static uint16_t do_ld_2(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
     return ret;
 }
 
-static uint32_t do_ld_4(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
+static uint32_t do_ld_4(CPUState *cpu, MMULookupPageData *p, int mmu_idx,
                         MMUAccessType type, MemOp memop, uintptr_t ra)
 {
     uint32_t ret;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        ret = do_ld_mmio_beN(env, p->full, 0, p->addr, 4, mmu_idx, type, ra);
+        ret = do_ld_mmio_beN(cpu, p->full, 0, p->addr, 4, mmu_idx, type, ra);
         if ((memop & MO_BSWAP) == MO_LE) {
             ret = bswap32(ret);
         }
     } else {
         /* Perform the load host endian. */
-        ret = load_atom_4(env, ra, p->haddr, memop);
+        ret = load_atom_4(cpu_env(cpu), ra, p->haddr, memop);
         if (memop & MO_BSWAP) {
             ret = bswap32(ret);
         }
@@ -2363,19 +2357,19 @@ static uint32_t do_ld_4(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
     return ret;
 }
 
-static uint64_t do_ld_8(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
+static uint64_t do_ld_8(CPUState *cpu, MMULookupPageData *p, int mmu_idx,
                         MMUAccessType type, MemOp memop, uintptr_t ra)
 {
     uint64_t ret;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        ret = do_ld_mmio_beN(env, p->full, 0, p->addr, 8, mmu_idx, type, ra);
+        ret = do_ld_mmio_beN(cpu, p->full, 0, p->addr, 8, mmu_idx, type, ra);
         if ((memop & MO_BSWAP) == MO_LE) {
             ret = bswap64(ret);
         }
     } else {
         /* Perform the load host endian. */
-        ret = load_atom_8(env, ra, p->haddr, memop);
+        ret = load_atom_8(cpu_env(cpu), ra, p->haddr, memop);
         if (memop & MO_BSWAP) {
             ret = bswap64(ret);
         }
@@ -2383,27 +2377,27 @@ static uint64_t do_ld_8(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
     return ret;
 }
 
-static uint8_t do_ld1_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
+static uint8_t do_ld1_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
                           uintptr_t ra, MMUAccessType access_type)
 {
     MMULookupLocals l;
     bool crosspage;
 
     cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
-    crosspage = mmu_lookup(env, addr, oi, ra, access_type, &l);
+    crosspage = mmu_lookup(cpu, addr, oi, ra, access_type, &l);
     tcg_debug_assert(!crosspage);
 
-    return do_ld_1(env, &l.page[0], l.mmu_idx, access_type, ra);
+    return do_ld_1(cpu, &l.page[0], l.mmu_idx, access_type, ra);
 }
 
 tcg_target_ulong helper_ldub_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
-    return do_ld1_mmu(env, addr, oi, retaddr, MMU_DATA_LOAD);
+    return do_ld1_mmu(env_cpu(env), addr, oi, retaddr, MMU_DATA_LOAD);
 }
 
-static uint16_t do_ld2_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
+static uint16_t do_ld2_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
                            uintptr_t ra, MMUAccessType access_type)
 {
     MMULookupLocals l;
@@ -2412,13 +2406,13 @@ static uint16_t do_ld2_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
     uint8_t a, b;
 
     cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
-    crosspage = mmu_lookup(env, addr, oi, ra, access_type, &l);
+    crosspage = mmu_lookup(cpu, addr, oi, ra, access_type, &l);
     if (likely(!crosspage)) {
-        return do_ld_2(env, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
+        return do_ld_2(cpu, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
     }
 
-    a = do_ld_1(env, &l.page[0], l.mmu_idx, access_type, ra);
-    b = do_ld_1(env, &l.page[1], l.mmu_idx, access_type, ra);
+    a = do_ld_1(cpu, &l.page[0], l.mmu_idx, access_type, ra);
+    b = do_ld_1(cpu, &l.page[1], l.mmu_idx, access_type, ra);
 
     if ((l.memop & MO_BSWAP) == MO_LE) {
         ret = a | (b << 8);
@@ -2432,10 +2426,10 @@ tcg_target_ulong helper_lduw_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
-    return do_ld2_mmu(env, addr, oi, retaddr, MMU_DATA_LOAD);
+    return do_ld2_mmu(env_cpu(env), addr, oi, retaddr, MMU_DATA_LOAD);
 }
 
-static uint32_t do_ld4_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
+static uint32_t do_ld4_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
                            uintptr_t ra, MMUAccessType access_type)
 {
     MMULookupLocals l;
@@ -2443,13 +2437,13 @@ static uint32_t do_ld4_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
     uint32_t ret;
 
     cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
-    crosspage = mmu_lookup(env, addr, oi, ra, access_type, &l);
+    crosspage = mmu_lookup(cpu, addr, oi, ra, access_type, &l);
     if (likely(!crosspage)) {
-        return do_ld_4(env, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
+        return do_ld_4(cpu, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
     }
 
-    ret = do_ld_beN(env, &l.page[0], 0, l.mmu_idx, access_type, l.memop, ra);
-    ret = do_ld_beN(env, &l.page[1], ret, l.mmu_idx, access_type, l.memop, ra);
+    ret = do_ld_beN(cpu, &l.page[0], 0, l.mmu_idx, access_type, l.memop, ra);
+    ret = do_ld_beN(cpu, &l.page[1], ret, l.mmu_idx, access_type, l.memop, ra);
     if ((l.memop & MO_BSWAP) == MO_LE) {
         ret = bswap32(ret);
     }
@@ -2460,10 +2454,10 @@ tcg_target_ulong helper_ldul_mmu(CPUArchState *env, uint64_t addr,
                                  MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
-    return do_ld4_mmu(env, addr, oi, retaddr, MMU_DATA_LOAD);
+    return do_ld4_mmu(env_cpu(env), addr, oi, retaddr, MMU_DATA_LOAD);
 }
 
-static uint64_t do_ld8_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
+static uint64_t do_ld8_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
                            uintptr_t ra, MMUAccessType access_type)
 {
     MMULookupLocals l;
@@ -2471,13 +2465,13 @@ static uint64_t do_ld8_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
     uint64_t ret;
 
     cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
-    crosspage = mmu_lookup(env, addr, oi, ra, access_type, &l);
+    crosspage = mmu_lookup(cpu, addr, oi, ra, access_type, &l);
     if (likely(!crosspage)) {
-        return do_ld_8(env, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
+        return do_ld_8(cpu, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
     }
 
-    ret = do_ld_beN(env, &l.page[0], 0, l.mmu_idx, access_type, l.memop, ra);
-    ret = do_ld_beN(env, &l.page[1], ret, l.mmu_idx, access_type, l.memop, ra);
+    ret = do_ld_beN(cpu, &l.page[0], 0, l.mmu_idx, access_type, l.memop, ra);
+    ret = do_ld_beN(cpu, &l.page[1], ret, l.mmu_idx, access_type, l.memop, ra);
     if ((l.memop & MO_BSWAP) == MO_LE) {
         ret = bswap64(ret);
     }
@@ -2488,7 +2482,7 @@ uint64_t helper_ldq_mmu(CPUArchState *env, uint64_t addr,
                         MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
-    return do_ld8_mmu(env, addr, oi, retaddr, MMU_DATA_LOAD);
+    return do_ld8_mmu(env_cpu(env), addr, oi, retaddr, MMU_DATA_LOAD);
 }
 
 /*
@@ -2514,7 +2508,7 @@ tcg_target_ulong helper_ldsl_mmu(CPUArchState *env, uint64_t addr,
     return (int32_t)helper_ldul_mmu(env, addr, oi, retaddr);
 }
 
-static Int128 do_ld16_mmu(CPUArchState *env, vaddr addr,
+static Int128 do_ld16_mmu(CPUState *cpu, vaddr addr,
                           MemOpIdx oi, uintptr_t ra)
 {
     MMULookupLocals l;
@@ -2524,17 +2518,17 @@ static Int128 do_ld16_mmu(CPUArchState *env, vaddr addr,
     int first;
 
     cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
-    crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_LOAD, &l);
+    crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_LOAD, &l);
     if (likely(!crosspage)) {
         if (unlikely(l.page[0].flags & TLB_MMIO)) {
-            ret = do_ld16_mmio_beN(env, l.page[0].full, 0, addr, 16,
+            ret = do_ld16_mmio_beN(cpu, l.page[0].full, 0, addr, 16,
                                    l.mmu_idx, ra);
             if ((l.memop & MO_BSWAP) == MO_LE) {
                 ret = bswap128(ret);
             }
         } else {
             /* Perform the load host endian. */
-            ret = load_atom_16(env, ra, l.page[0].haddr, l.memop);
+            ret = load_atom_16(cpu_env(cpu), ra, l.page[0].haddr, l.memop);
             if (l.memop & MO_BSWAP) {
                 ret = bswap128(ret);
             }
@@ -2546,8 +2540,8 @@ static Int128 do_ld16_mmu(CPUArchState *env, vaddr addr,
     if (first == 8) {
         MemOp mop8 = (l.memop & ~MO_SIZE) | MO_64;
 
-        a = do_ld_8(env, &l.page[0], l.mmu_idx, MMU_DATA_LOAD, mop8, ra);
-        b = do_ld_8(env, &l.page[1], l.mmu_idx, MMU_DATA_LOAD, mop8, ra);
+        a = do_ld_8(cpu, &l.page[0], l.mmu_idx, MMU_DATA_LOAD, mop8, ra);
+        b = do_ld_8(cpu, &l.page[1], l.mmu_idx, MMU_DATA_LOAD, mop8, ra);
         if ((mop8 & MO_BSWAP) == MO_LE) {
             ret = int128_make128(a, b);
         } else {
@@ -2557,15 +2551,15 @@ static Int128 do_ld16_mmu(CPUArchState *env, vaddr addr,
     }
 
     if (first < 8) {
-        a = do_ld_beN(env, &l.page[0], 0, l.mmu_idx,
+        a = do_ld_beN(cpu, &l.page[0], 0, l.mmu_idx,
                       MMU_DATA_LOAD, l.memop, ra);
-        ret = do_ld16_beN(env, &l.page[1], a, l.mmu_idx, l.memop, ra);
+        ret = do_ld16_beN(cpu, &l.page[1], a, l.mmu_idx, l.memop, ra);
     } else {
-        ret = do_ld16_beN(env, &l.page[0], 0, l.mmu_idx, l.memop, ra);
+        ret = do_ld16_beN(cpu, &l.page[0], 0, l.mmu_idx, l.memop, ra);
         b = int128_getlo(ret);
         ret = int128_lshift(ret, l.page[1].size * 8);
         a = int128_gethi(ret);
-        b = do_ld_beN(env, &l.page[1], b, l.mmu_idx,
+        b = do_ld_beN(cpu, &l.page[1], b, l.mmu_idx,
                       MMU_DATA_LOAD, l.memop, ra);
         ret = int128_make128(b, a);
     }
@@ -2579,7 +2573,7 @@ Int128 helper_ld16_mmu(CPUArchState *env, uint64_t addr,
                        uint32_t oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
-    return do_ld16_mmu(env, addr, oi, retaddr);
+    return do_ld16_mmu(env_cpu(env), addr, oi, retaddr);
 }
 
 Int128 helper_ld_i128(CPUArchState *env, uint64_t addr, uint32_t oi)
@@ -2601,7 +2595,7 @@ uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintptr_t ra)
     uint8_t ret;
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_UB);
-    ret = do_ld1_mmu(env, addr, oi, ra, MMU_DATA_LOAD);
+    ret = do_ld1_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
     plugin_load_cb(env, addr, oi);
     return ret;
 }
@@ -2612,7 +2606,7 @@ uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr addr,
     uint16_t ret;
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
-    ret = do_ld2_mmu(env, addr, oi, ra, MMU_DATA_LOAD);
+    ret = do_ld2_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
     plugin_load_cb(env, addr, oi);
     return ret;
 }
@@ -2623,7 +2617,7 @@ uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr addr,
     uint32_t ret;
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
-    ret = do_ld4_mmu(env, addr, oi, ra, MMU_DATA_LOAD);
+    ret = do_ld4_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
     plugin_load_cb(env, addr, oi);
     return ret;
 }
@@ -2634,7 +2628,7 @@ uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr addr,
     uint64_t ret;
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
-    ret = do_ld8_mmu(env, addr, oi, ra, MMU_DATA_LOAD);
+    ret = do_ld8_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
     plugin_load_cb(env, addr, oi);
     return ret;
 }
@@ -2645,7 +2639,7 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
     Int128 ret;
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
-    ret = do_ld16_mmu(env, addr, oi, ra);
+    ret = do_ld16_mmu(env_cpu(env), addr, oi, ra);
     plugin_load_cb(env, addr, oi);
     return ret;
 }
@@ -2656,7 +2650,7 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
 
 /**
  * do_st_mmio_leN:
- * @env: cpu context
+ * @cpu: generic cpu state
  * @full: page parameters
  * @val_le: data to store
  * @addr: virtual address
@@ -2669,7 +2663,7 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
  * The bytes to store are extracted in little-endian order from @val_le;
  * return the bytes of @val_le beyond @p->size that have not been stored.
  */
-static uint64_t int_st_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
+static uint64_t int_st_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
                                 uint64_t val_le, vaddr addr, int size,
                                 int mmu_idx, uintptr_t ra,
                                 MemoryRegion *mr, hwaddr mr_offset)
@@ -2687,7 +2681,7 @@ static uint64_t int_st_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
         r = memory_region_dispatch_write(mr, mr_offset, val_le,
                                          this_mop, full->attrs);
         if (unlikely(r != MEMTX_OK)) {
-            io_failed(env, full, addr, this_size, MMU_DATA_STORE,
+            io_failed(cpu, full, addr, this_size, MMU_DATA_STORE,
                       mmu_idx, r, ra);
         }
         if (this_size == 8) {
@@ -2703,7 +2697,7 @@ static uint64_t int_st_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
     return val_le;
 }
 
-static uint64_t do_st_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
+static uint64_t do_st_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
                                uint64_t val_le, vaddr addr, int size,
                                int mmu_idx, uintptr_t ra)
 {
@@ -2716,18 +2710,18 @@ static uint64_t do_st_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 0 && size <= 8);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, env, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
     mr = section->mr;
 
     qemu_mutex_lock_iothread();
-    ret = int_st_mmio_leN(env, full, val_le, addr, size, mmu_idx,
+    ret = int_st_mmio_leN(cpu, full, val_le, addr, size, mmu_idx,
                           ra, mr, mr_offset);
     qemu_mutex_unlock_iothread();
 
     return ret;
 }
 
-static uint64_t do_st16_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
+static uint64_t do_st16_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
                                  Int128 val_le, vaddr addr, int size,
                                  int mmu_idx, uintptr_t ra)
 {
@@ -2740,13 +2734,13 @@ static uint64_t do_st16_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 8 && size <= 16);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, env, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
     mr = section->mr;
 
     qemu_mutex_lock_iothread();
-    int_st_mmio_leN(env, full, int128_getlo(val_le), addr, 8,
+    int_st_mmio_leN(cpu, full, int128_getlo(val_le), addr, 8,
                     mmu_idx, ra, mr, mr_offset);
-    ret = int_st_mmio_leN(env, full, int128_gethi(val_le), addr + 8,
+    ret = int_st_mmio_leN(cpu, full, int128_gethi(val_le), addr + 8,
                           size - 8, mmu_idx, ra, mr, mr_offset + 8);
     qemu_mutex_unlock_iothread();
 
@@ -2756,7 +2750,7 @@ static uint64_t do_st16_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
 /*
  * Wrapper for the above.
  */
-static uint64_t do_st_leN(CPUArchState *env, MMULookupPageData *p,
+static uint64_t do_st_leN(CPUState *cpu, MMULookupPageData *p,
                           uint64_t val_le, int mmu_idx,
                           MemOp mop, uintptr_t ra)
 {
@@ -2764,7 +2758,7 @@ static uint64_t do_st_leN(CPUArchState *env, MMULookupPageData *p,
     unsigned tmp, half_size;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        return do_st_mmio_leN(env, p->full, val_le, p->addr,
+        return do_st_mmio_leN(cpu, p->full, val_le, p->addr,
                               p->size, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         return val_le >> (p->size * 8);
@@ -2792,7 +2786,7 @@ static uint64_t do_st_leN(CPUArchState *env, MMULookupPageData *p,
             } else if (HAVE_al8) {
                 return store_whole_le8(p->haddr, p->size, val_le);
             } else {
-                cpu_loop_exit_atomic(env_cpu(env), ra);
+                cpu_loop_exit_atomic(cpu, ra);
             }
         }
         /* fall through */
@@ -2810,7 +2804,7 @@ static uint64_t do_st_leN(CPUArchState *env, MMULookupPageData *p,
 /*
  * Wrapper for the above, for 8 < size < 16.
  */
-static uint64_t do_st16_leN(CPUArchState *env, MMULookupPageData *p,
+static uint64_t do_st16_leN(CPUState *cpu, MMULookupPageData *p,
                             Int128 val_le, int mmu_idx,
                             MemOp mop, uintptr_t ra)
 {
@@ -2818,7 +2812,7 @@ static uint64_t do_st16_leN(CPUArchState *env, MMULookupPageData *p,
     MemOp atom;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        return do_st16_mmio_leN(env, p->full, val_le, p->addr,
+        return do_st16_mmio_leN(cpu, p->full, val_le, p->addr,
                                 size, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         return int128_gethi(val_le) >> ((size - 8) * 8);
@@ -2838,7 +2832,7 @@ static uint64_t do_st16_leN(CPUArchState *env, MMULookupPageData *p,
     case MO_ATOM_WITHIN16_PAIR:
         /* Since size > 8, this is the half that must be atomic. */
         if (!HAVE_ATOMIC128_RW) {
-            cpu_loop_exit_atomic(env_cpu(env), ra);
+            cpu_loop_exit_atomic(cpu, ra);
         }
         return store_whole_le16(p->haddr, p->size, val_le);
 
@@ -2859,11 +2853,11 @@ static uint64_t do_st16_leN(CPUArchState *env, MMULookupPageData *p,
     }
 }
 
-static void do_st_1(CPUArchState *env, MMULookupPageData *p, uint8_t val,
+static void do_st_1(CPUState *cpu, MMULookupPageData *p, uint8_t val,
                     int mmu_idx, uintptr_t ra)
 {
     if (unlikely(p->flags & TLB_MMIO)) {
-        do_st_mmio_leN(env, p->full, val, p->addr, 1, mmu_idx, ra);
+        do_st_mmio_leN(cpu, p->full, val, p->addr, 1, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         /* nothing */
     } else {
@@ -2871,14 +2865,14 @@ static void do_st_1(CPUArchState *env, MMULookupPageData *p, uint8_t val,
     }
 }
 
-static void do_st_2(CPUArchState *env, MMULookupPageData *p, uint16_t val,
+static void do_st_2(CPUState *cpu, MMULookupPageData *p, uint16_t val,
                     int mmu_idx, MemOp memop, uintptr_t ra)
 {
     if (unlikely(p->flags & TLB_MMIO)) {
         if ((memop & MO_BSWAP) != MO_LE) {
             val = bswap16(val);
         }
-        do_st_mmio_leN(env, p->full, val, p->addr, 2, mmu_idx, ra);
+        do_st_mmio_leN(cpu, p->full, val, p->addr, 2, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         /* nothing */
     } else {
@@ -2886,18 +2880,18 @@ static void do_st_2(CPUArchState *env, MMULookupPageData *p, uint16_t val,
         if (memop & MO_BSWAP) {
             val = bswap16(val);
         }
-        store_atom_2(env, ra, p->haddr, memop, val);
+        store_atom_2(cpu_env(cpu), ra, p->haddr, memop, val);
     }
 }
 
-static void do_st_4(CPUArchState *env, MMULookupPageData *p, uint32_t val,
+static void do_st_4(CPUState *cpu, MMULookupPageData *p, uint32_t val,
                     int mmu_idx, MemOp memop, uintptr_t ra)
 {
     if (unlikely(p->flags & TLB_MMIO)) {
         if ((memop & MO_BSWAP) != MO_LE) {
             val = bswap32(val);
         }
-        do_st_mmio_leN(env, p->full, val, p->addr, 4, mmu_idx, ra);
+        do_st_mmio_leN(cpu, p->full, val, p->addr, 4, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         /* nothing */
     } else {
@@ -2905,18 +2899,18 @@ static void do_st_4(CPUArchState *env, MMULookupPageData *p, uint32_t val,
         if (memop & MO_BSWAP) {
             val = bswap32(val);
         }
-        store_atom_4(env, ra, p->haddr, memop, val);
+        store_atom_4(cpu_env(cpu), ra, p->haddr, memop, val);
     }
 }
 
-static void do_st_8(CPUArchState *env, MMULookupPageData *p, uint64_t val,
+static void do_st_8(CPUState *cpu, MMULookupPageData *p, uint64_t val,
                     int mmu_idx, MemOp memop, uintptr_t ra)
 {
     if (unlikely(p->flags & TLB_MMIO)) {
         if ((memop & MO_BSWAP) != MO_LE) {
             val = bswap64(val);
         }
-        do_st_mmio_leN(env, p->full, val, p->addr, 8, mmu_idx, ra);
+        do_st_mmio_leN(cpu, p->full, val, p->addr, 8, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         /* nothing */
     } else {
@@ -2924,7 +2918,7 @@ static void do_st_8(CPUArchState *env, MMULookupPageData *p, uint64_t val,
         if (memop & MO_BSWAP) {
             val = bswap64(val);
         }
-        store_atom_8(env, ra, p->haddr, memop, val);
+        store_atom_8(cpu_env(cpu), ra, p->haddr, memop, val);
     }
 }
 
@@ -2936,13 +2930,13 @@ void helper_stb_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_8);
     cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
-    crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE, &l);
+    crosspage = mmu_lookup(env_cpu(env), addr, oi, ra, MMU_DATA_STORE, &l);
     tcg_debug_assert(!crosspage);
 
-    do_st_1(env, &l.page[0], val, l.mmu_idx, ra);
+    do_st_1(env_cpu(env), &l.page[0], val, l.mmu_idx, ra);
 }
 
-static void do_st2_mmu(CPUArchState *env, vaddr addr, uint16_t val,
+static void do_st2_mmu(CPUState *cpu, vaddr addr, uint16_t val,
                        MemOpIdx oi, uintptr_t ra)
 {
     MMULookupLocals l;
@@ -2950,9 +2944,9 @@ static void do_st2_mmu(CPUArchState *env, vaddr addr, uint16_t val,
     uint8_t a, b;
 
     cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
-    crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE, &l);
+    crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
-        do_st_2(env, &l.page[0], val, l.mmu_idx, l.memop, ra);
+        do_st_2(cpu, &l.page[0], val, l.mmu_idx, l.memop, ra);
         return;
     }
 
@@ -2961,27 +2955,27 @@ static void do_st2_mmu(CPUArchState *env, vaddr addr, uint16_t val,
     } else {
         b = val, a = val >> 8;
     }
-    do_st_1(env, &l.page[0], a, l.mmu_idx, ra);
-    do_st_1(env, &l.page[1], b, l.mmu_idx, ra);
+    do_st_1(cpu, &l.page[0], a, l.mmu_idx, ra);
+    do_st_1(cpu, &l.page[1], b, l.mmu_idx, ra);
 }
 
 void helper_stw_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
                     MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
-    do_st2_mmu(env, addr, val, oi, retaddr);
+    do_st2_mmu(env_cpu(env), addr, val, oi, retaddr);
 }
 
-static void do_st4_mmu(CPUArchState *env, vaddr addr, uint32_t val,
+static void do_st4_mmu(CPUState *cpu, vaddr addr, uint32_t val,
                        MemOpIdx oi, uintptr_t ra)
 {
     MMULookupLocals l;
     bool crosspage;
 
     cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
-    crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE, &l);
+    crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
-        do_st_4(env, &l.page[0], val, l.mmu_idx, l.memop, ra);
+        do_st_4(cpu, &l.page[0], val, l.mmu_idx, l.memop, ra);
         return;
     }
 
@@ -2989,27 +2983,27 @@ static void do_st4_mmu(CPUArchState *env, vaddr addr, uint32_t val,
     if ((l.memop & MO_BSWAP) != MO_LE) {
         val = bswap32(val);
     }
-    val = do_st_leN(env, &l.page[0], val, l.mmu_idx, l.memop, ra);
-    (void) do_st_leN(env, &l.page[1], val, l.mmu_idx, l.memop, ra);
+    val = do_st_leN(cpu, &l.page[0], val, l.mmu_idx, l.memop, ra);
+    (void) do_st_leN(cpu, &l.page[1], val, l.mmu_idx, l.memop, ra);
 }
 
 void helper_stl_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
                     MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
-    do_st4_mmu(env, addr, val, oi, retaddr);
+    do_st4_mmu(env_cpu(env), addr, val, oi, retaddr);
 }
 
-static void do_st8_mmu(CPUArchState *env, vaddr addr, uint64_t val,
+static void do_st8_mmu(CPUState *cpu, vaddr addr, uint64_t val,
                        MemOpIdx oi, uintptr_t ra)
 {
     MMULookupLocals l;
     bool crosspage;
 
     cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
-    crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE, &l);
+    crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
-        do_st_8(env, &l.page[0], val, l.mmu_idx, l.memop, ra);
+        do_st_8(cpu, &l.page[0], val, l.mmu_idx, l.memop, ra);
         return;
     }
 
@@ -3017,18 +3011,18 @@ static void do_st8_mmu(CPUArchState *env, vaddr addr, uint64_t val,
     if ((l.memop & MO_BSWAP) != MO_LE) {
         val = bswap64(val);
     }
-    val = do_st_leN(env, &l.page[0], val, l.mmu_idx, l.memop, ra);
-    (void) do_st_leN(env, &l.page[1], val, l.mmu_idx, l.memop, ra);
+    val = do_st_leN(cpu, &l.page[0], val, l.mmu_idx, l.memop, ra);
+    (void) do_st_leN(cpu, &l.page[1], val, l.mmu_idx, l.memop, ra);
 }
 
 void helper_stq_mmu(CPUArchState *env, uint64_t addr, uint64_t val,
                     MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
-    do_st8_mmu(env, addr, val, oi, retaddr);
+    do_st8_mmu(env_cpu(env), addr, val, oi, retaddr);
 }
 
-static void do_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
+static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
                         MemOpIdx oi, uintptr_t ra)
 {
     MMULookupLocals l;
@@ -3037,13 +3031,13 @@ static void do_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
     int first;
 
     cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
-    crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE, &l);
+    crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
         if (unlikely(l.page[0].flags & TLB_MMIO)) {
             if ((l.memop & MO_BSWAP) != MO_LE) {
                 val = bswap128(val);
             }
-            do_st16_mmio_leN(env, l.page[0].full, val, addr, 16, l.mmu_idx, ra);
+            do_st16_mmio_leN(cpu, l.page[0].full, val, addr, 16, l.mmu_idx, ra);
         } else if (unlikely(l.page[0].flags & TLB_DISCARD_WRITE)) {
             /* nothing */
         } else {
@@ -3051,7 +3045,7 @@ static void do_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
             if (l.memop & MO_BSWAP) {
                 val = bswap128(val);
             }
-            store_atom_16(env, ra, l.page[0].haddr, l.memop, val);
+            store_atom_16(cpu_env(cpu), ra, l.page[0].haddr, l.memop, val);
         }
         return;
     }
@@ -3068,8 +3062,8 @@ static void do_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
         } else {
             a = int128_getlo(val), b = int128_gethi(val);
         }
-        do_st_8(env, &l.page[0], a, l.mmu_idx, mop8, ra);
-        do_st_8(env, &l.page[1], b, l.mmu_idx, mop8, ra);
+        do_st_8(cpu, &l.page[0], a, l.mmu_idx, mop8, ra);
+        do_st_8(cpu, &l.page[1], b, l.mmu_idx, mop8, ra);
         return;
     }
 
@@ -3077,12 +3071,12 @@ static void do_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
         val = bswap128(val);
     }
     if (first < 8) {
-        do_st_leN(env, &l.page[0], int128_getlo(val), l.mmu_idx, l.memop, ra);
+        do_st_leN(cpu, &l.page[0], int128_getlo(val), l.mmu_idx, l.memop, ra);
         val = int128_urshift(val, first * 8);
-        do_st16_leN(env, &l.page[1], val, l.mmu_idx, l.memop, ra);
+        do_st16_leN(cpu, &l.page[1], val, l.mmu_idx, l.memop, ra);
     } else {
-        b = do_st16_leN(env, &l.page[0], val, l.mmu_idx, l.memop, ra);
-        do_st_leN(env, &l.page[1], b, l.mmu_idx, l.memop, ra);
+        b = do_st16_leN(cpu, &l.page[0], val, l.mmu_idx, l.memop, ra);
+        do_st_leN(cpu, &l.page[1], b, l.mmu_idx, l.memop, ra);
     }
 }
 
@@ -3090,7 +3084,7 @@ void helper_st16_mmu(CPUArchState *env, uint64_t addr, Int128 val,
                      MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
-    do_st16_mmu(env, addr, val, oi, retaddr);
+    do_st16_mmu(env_cpu(env), addr, val, oi, retaddr);
 }
 
 void helper_st_i128(CPUArchState *env, uint64_t addr, Int128 val, MemOpIdx oi)
@@ -3118,7 +3112,7 @@ void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
                  MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
-    do_st2_mmu(env, addr, val, oi, retaddr);
+    do_st2_mmu(env_cpu(env), addr, val, oi, retaddr);
     plugin_store_cb(env, addr, oi);
 }
 
@@ -3126,7 +3120,7 @@ void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
                     MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
-    do_st4_mmu(env, addr, val, oi, retaddr);
+    do_st4_mmu(env_cpu(env), addr, val, oi, retaddr);
     plugin_store_cb(env, addr, oi);
 }
 
@@ -3134,7 +3128,7 @@ void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
                  MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
-    do_st8_mmu(env, addr, val, oi, retaddr);
+    do_st8_mmu(env_cpu(env), addr, val, oi, retaddr);
     plugin_store_cb(env, addr, oi);
 }
 
@@ -3142,7 +3136,7 @@ void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
                   MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
-    do_st16_mmu(env, addr, val, oi, retaddr);
+    do_st16_mmu(env_cpu(env), addr, val, oi, retaddr);
     plugin_store_cb(env, addr, oi);
 }
 
@@ -3184,47 +3178,47 @@ void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
 uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
 {
     MemOpIdx oi = make_memop_idx(MO_UB, cpu_mmu_index(env, true));
-    return do_ld1_mmu(env, addr, oi, 0, MMU_INST_FETCH);
+    return do_ld1_mmu(env_cpu(env), addr, oi, 0, MMU_INST_FETCH);
 }
 
 uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr)
 {
     MemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(env, true));
-    return do_ld2_mmu(env, addr, oi, 0, MMU_INST_FETCH);
+    return do_ld2_mmu(env_cpu(env), addr, oi, 0, MMU_INST_FETCH);
 }
 
 uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr)
 {
     MemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(env, true));
-    return do_ld4_mmu(env, addr, oi, 0, MMU_INST_FETCH);
+    return do_ld4_mmu(env_cpu(env), addr, oi, 0, MMU_INST_FETCH);
 }
 
 uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
 {
     MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(env, true));
-    return do_ld8_mmu(env, addr, oi, 0, MMU_INST_FETCH);
+    return do_ld8_mmu(env_cpu(env), addr, oi, 0, MMU_INST_FETCH);
 }
 
 uint8_t cpu_ldb_code_mmu(CPUArchState *env, abi_ptr addr,
                          MemOpIdx oi, uintptr_t retaddr)
 {
-    return do_ld1_mmu(env, addr, oi, retaddr, MMU_INST_FETCH);
+    return do_ld1_mmu(env_cpu(env), addr, oi, retaddr, MMU_INST_FETCH);
 }
 
 uint16_t cpu_ldw_code_mmu(CPUArchState *env, abi_ptr addr,
                           MemOpIdx oi, uintptr_t retaddr)
 {
-    return do_ld2_mmu(env, addr, oi, retaddr, MMU_INST_FETCH);
+    return do_ld2_mmu(env_cpu(env), addr, oi, retaddr, MMU_INST_FETCH);
 }
 
 uint32_t cpu_ldl_code_mmu(CPUArchState *env, abi_ptr addr,
                           MemOpIdx oi, uintptr_t retaddr)
 {
-    return do_ld4_mmu(env, addr, oi, retaddr, MMU_INST_FETCH);
+    return do_ld4_mmu(env_cpu(env), addr, oi, retaddr, MMU_INST_FETCH);
 }
 
 uint64_t cpu_ldq_code_mmu(CPUArchState *env, abi_ptr addr,
                           MemOpIdx oi, uintptr_t retaddr)
 {
-    return do_ld8_mmu(env, addr, oi, retaddr, MMU_INST_FETCH);
+    return do_ld8_mmu(env_cpu(env), addr, oi, retaddr, MMU_INST_FETCH);
 }
-- 
2.34.1


