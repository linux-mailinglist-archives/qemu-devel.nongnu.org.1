Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A184079D50B
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 17:36:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg5Q5-0007ME-Gb; Tue, 12 Sep 2023 11:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qg5Pq-0007If-3Y
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:35:03 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qg5Pe-0001Wf-25
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xlerWTxY/dIHL1wKz+c5zCtWpW92xylIr3aiOT+ZYNs=; b=dhPenxNoJHNPiWpyL0uEmPTghD
 QOX2nNPdNOH47JOL7wkIOkJ0exFTwvuyBPrb/+/+c9miFwi+67xE2c8xy7iPfJe18eeeX6T55+PRU
 uCyXbcwouItNzU5J1g1SbOGDYu3J5PmALKhH5IQ3huC3KFLMveN/80vPpGSslfWXHPZM=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, peter.maydell@linaro.org
Subject: [PATCH 05/11] accel/tcg: Modifies memory access functions to use
 CPUState
Date: Tue, 12 Sep 2023 17:34:22 +0200
Message-ID: <20230912153428.17816-6-anjo@rev.ng>
In-Reply-To: <20230912153428.17816-1-anjo@rev.ng>
References: <20230912153428.17816-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

do_[ld|st]*() and mmu_lookup*() are changed to use CPUState over
CPUArchState, moving the target-dependence to the target-facing facing
cpu_[ld|st] functions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 accel/tcg/cputlb.c | 324 ++++++++++++++++++++++-----------------------
 1 file changed, 161 insertions(+), 163 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 20ea2e2395..ebd174e23d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1367,11 +1367,10 @@ static void save_iotlb_data(CPUState *cs, MemoryRegionSection *section,
 #endif
 }
 
-static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
+static uint64_t io_readx(CPUState *cpu, CPUTLBEntryFull *full,
                          int mmu_idx, vaddr addr, uintptr_t retaddr,
                          MMUAccessType access_type, MemOp op)
 {
-    CPUState *cpu = env_cpu(env);
     hwaddr mr_offset;
     MemoryRegionSection *section;
     MemoryRegion *mr;
@@ -1408,11 +1407,10 @@ static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
     return val;
 }
 
-static void io_writex(CPUArchState *env, CPUTLBEntryFull *full,
+static void io_writex(CPUState *cpu, CPUTLBEntryFull *full,
                       int mmu_idx, uint64_t val, vaddr addr,
                       uintptr_t retaddr, MemOp op)
 {
-    CPUState *cpu = env_cpu(env);
     hwaddr mr_offset;
     MemoryRegionSection *section;
     MemoryRegion *mr;
@@ -1776,7 +1774,7 @@ typedef struct MMULookupLocals {
 
 /**
  * mmu_lookup1: translate one page
- * @env: cpu context
+ * @cpu: generic cpu state
  * @data: lookup parameters
  * @mmu_idx: virtual address context
  * @access_type: load/store/code
@@ -1787,12 +1785,12 @@ typedef struct MMULookupLocals {
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
@@ -1800,17 +1798,17 @@ static bool mmu_lookup1(CPUArchState *env, MMULookupPageData *data,
 
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
+    full = &cpu_tlb(cpu)->d[mmu_idx].fulltlb[index];
     flags = tlb_addr & (TLB_FLAGS_MASK & ~TLB_FORCE_SLOW);
     flags |= full->slow_flags[access_type];
 
@@ -1824,7 +1822,7 @@ static bool mmu_lookup1(CPUArchState *env, MMULookupPageData *data,
 
 /**
  * mmu_watch_or_dirty
- * @env: cpu context
+ * @cpu: generic cpu state
  * @data: lookup parameters
  * @access_type: load/store/code
  * @ra: return address into tcg generated code, or 0
@@ -1832,7 +1830,7 @@ static bool mmu_lookup1(CPUArchState *env, MMULookupPageData *data,
  * Trigger watchpoints for @data.addr:@data.size;
  * record writes to protected clean pages.
  */
-static void mmu_watch_or_dirty(CPUArchState *env, MMULookupPageData *data,
+static void mmu_watch_or_dirty(CPUState *cpu, MMULookupPageData *data,
                                MMUAccessType access_type, uintptr_t ra)
 {
     CPUTLBEntryFull *full = data->full;
@@ -1843,13 +1841,13 @@ static void mmu_watch_or_dirty(CPUArchState *env, MMULookupPageData *data,
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
@@ -1857,7 +1855,7 @@ static void mmu_watch_or_dirty(CPUArchState *env, MMULookupPageData *data,
 
 /**
  * mmu_lookup: translate page(s)
- * @env: cpu context
+ * @cpu: generic cpu state
  * @addr: virtual address
  * @oi: combined mmu_idx and MemOp
  * @ra: return address into tcg generated code, or 0
@@ -1867,7 +1865,7 @@ static void mmu_watch_or_dirty(CPUArchState *env, MMULookupPageData *data,
  * Resolve the translation for the page(s) beginning at @addr, for MemOp.size
  * bytes.  Return true if the lookup crosses a page boundary.
  */
-static bool mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
+static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
                        uintptr_t ra, MMUAccessType type, MMULookupLocals *l)
 {
     unsigned a_bits;
@@ -1882,7 +1880,7 @@ static bool mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
     /* Handle CPU specific unaligned behaviour */
     a_bits = get_alignment_bits(l->memop);
     if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(env_cpu(env), addr, type, l->mmu_idx, ra);
+        cpu_unaligned_access(cpu, addr, type, l->mmu_idx, ra);
     }
 
     l->page[0].addr = addr;
@@ -1892,11 +1890,11 @@ static bool mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
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
@@ -1911,16 +1909,16 @@ static bool mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
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
+            l->page[0].full = &cpu_tlb(cpu)->d[l->mmu_idx].fulltlb[index];
         }
 
         flags = l->page[0].flags | l->page[1].flags;
         if (unlikely(flags & (TLB_WATCHPOINT | TLB_NOTDIRTY))) {
-            mmu_watch_or_dirty(env, &l->page[0], type, ra);
-            mmu_watch_or_dirty(env, &l->page[1], type, ra);
+            mmu_watch_or_dirty(cpu, &l->page[0], type, ra);
+            mmu_watch_or_dirty(cpu, &l->page[1], type, ra);
         }
 
         /*
@@ -2060,7 +2058,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
 
 /**
  * do_ld_mmio_beN:
- * @env: cpu context
+ * @cpu: generic cpu state
  * @full: page parameters
  * @ret_be: accumulated data
  * @addr: virtual address
@@ -2072,7 +2070,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
  * Load @size bytes from @addr, which is memory-mapped i/o.
  * The bytes are concatenated in big-endian order with @ret_be.
  */
-static uint64_t do_ld_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
+static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
                                uint64_t ret_be, vaddr addr, int size,
                                int mmu_idx, MMUAccessType type, uintptr_t ra)
 {
@@ -2086,26 +2084,26 @@ static uint64_t do_ld_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
         case 3:
         case 5:
         case 7:
-            t = io_readx(env, full, mmu_idx, addr, ra, type, MO_UB);
+            t = io_readx(cpu, full, mmu_idx, addr, ra, type, MO_UB);
             ret_be = (ret_be << 8) | t;
             size -= 1;
             addr += 1;
             break;
         case 2:
         case 6:
-            t = io_readx(env, full, mmu_idx, addr, ra, type, MO_BEUW);
+            t = io_readx(cpu, full, mmu_idx, addr, ra, type, MO_BEUW);
             ret_be = (ret_be << 16) | t;
             size -= 2;
             addr += 2;
             break;
         case 4:
-            t = io_readx(env, full, mmu_idx, addr, ra, type, MO_BEUL);
+            t = io_readx(cpu, full, mmu_idx, addr, ra, type, MO_BEUL);
             ret_be = (ret_be << 32) | t;
             size -= 4;
             addr += 4;
             break;
         case 0:
-            return io_readx(env, full, mmu_idx, addr, ra, type, MO_BEUQ);
+            return io_readx(cpu, full, mmu_idx, addr, ra, type, MO_BEUQ);
         default:
             qemu_build_not_reached();
         }
@@ -2207,11 +2205,11 @@ static uint64_t do_ld_whole_be4(MMULookupPageData *p, uint64_t ret_be)
  * As do_ld_bytes_beN, but with one atomic load.
  * Eight aligned bytes are guaranteed to cover the load.
  */
-static uint64_t do_ld_whole_be8(CPUArchState *env, uintptr_t ra,
+static uint64_t do_ld_whole_be8(CPUState *cpu, uintptr_t ra,
                                 MMULookupPageData *p, uint64_t ret_be)
 {
     int o = p->addr & 7;
-    uint64_t x = load_atomic8_or_exit(env, ra, p->haddr - o);
+    uint64_t x = load_atomic8_or_exit(cpu->env_ptr, ra, p->haddr - o);
 
     x = cpu_to_be64(x);
     x <<= o * 8;
@@ -2227,11 +2225,11 @@ static uint64_t do_ld_whole_be8(CPUArchState *env, uintptr_t ra,
  * As do_ld_bytes_beN, but with one atomic load.
  * 16 aligned bytes are guaranteed to cover the load.
  */
-static Int128 do_ld_whole_be16(CPUArchState *env, uintptr_t ra,
+static Int128 do_ld_whole_be16(CPUState *cpu, uintptr_t ra,
                                MMULookupPageData *p, uint64_t ret_be)
 {
     int o = p->addr & 15;
-    Int128 x, y = load_atomic16_or_exit(env, ra, p->haddr - o);
+    Int128 x, y = load_atomic16_or_exit(cpu->env_ptr, ra, p->haddr - o);
     int size = p->size;
 
     if (!HOST_BIG_ENDIAN) {
@@ -2247,7 +2245,7 @@ static Int128 do_ld_whole_be16(CPUArchState *env, uintptr_t ra,
 /*
  * Wrapper for the above.
  */
-static uint64_t do_ld_beN(CPUArchState *env, MMULookupPageData *p,
+static uint64_t do_ld_beN(CPUState *cpu, MMULookupPageData *p,
                           uint64_t ret_be, int mmu_idx, MMUAccessType type,
                           MemOp mop, uintptr_t ra)
 {
@@ -2256,7 +2254,7 @@ static uint64_t do_ld_beN(CPUArchState *env, MMULookupPageData *p,
 
     if (unlikely(p->flags & TLB_MMIO)) {
         QEMU_IOTHREAD_LOCK_GUARD();
-        return do_ld_mmio_beN(env, p->full, ret_be, p->addr, p->size,
+        return do_ld_mmio_beN(cpu, p->full, ret_be, p->addr, p->size,
                               mmu_idx, type, ra);
     }
 
@@ -2280,7 +2278,7 @@ static uint64_t do_ld_beN(CPUArchState *env, MMULookupPageData *p,
             if (!HAVE_al8_fast && p->size < 4) {
                 return do_ld_whole_be4(p, ret_be);
             } else {
-                return do_ld_whole_be8(env, ra, p, ret_be);
+                return do_ld_whole_be8(cpu, ra, p, ret_be);
             }
         }
         /* fall through */
@@ -2298,7 +2296,7 @@ static uint64_t do_ld_beN(CPUArchState *env, MMULookupPageData *p,
 /*
  * Wrapper for the above, for 8 < size < 16.
  */
-static Int128 do_ld16_beN(CPUArchState *env, MMULookupPageData *p,
+static Int128 do_ld16_beN(CPUState *cpu, MMULookupPageData *p,
                           uint64_t a, int mmu_idx, MemOp mop, uintptr_t ra)
 {
     int size = p->size;
@@ -2307,9 +2305,9 @@ static Int128 do_ld16_beN(CPUArchState *env, MMULookupPageData *p,
 
     if (unlikely(p->flags & TLB_MMIO)) {
         QEMU_IOTHREAD_LOCK_GUARD();
-        a = do_ld_mmio_beN(env, p->full, a, p->addr, size - 8,
+        a = do_ld_mmio_beN(cpu, p->full, a, p->addr, size - 8,
                            mmu_idx, MMU_DATA_LOAD, ra);
-        b = do_ld_mmio_beN(env, p->full, 0, p->addr + 8, 8,
+        b = do_ld_mmio_beN(cpu, p->full, 0, p->addr + 8, 8,
                            mmu_idx, MMU_DATA_LOAD, ra);
         return int128_make128(b, a);
     }
@@ -2330,7 +2328,7 @@ static Int128 do_ld16_beN(CPUArchState *env, MMULookupPageData *p,
 
     case MO_ATOM_WITHIN16_PAIR:
         /* Since size > 8, this is the half that must be atomic. */
-        return do_ld_whole_be16(env, ra, p, a);
+        return do_ld_whole_be16(cpu, ra, p, a);
 
     case MO_ATOM_IFALIGN_PAIR:
         /*
@@ -2352,30 +2350,30 @@ static Int128 do_ld16_beN(CPUArchState *env, MMULookupPageData *p,
     return int128_make128(b, a);
 }
 
-static uint8_t do_ld_1(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
+static uint8_t do_ld_1(CPUState *cpu, MMULookupPageData *p, int mmu_idx,
                        MMUAccessType type, uintptr_t ra)
 {
     if (unlikely(p->flags & TLB_MMIO)) {
-        return io_readx(env, p->full, mmu_idx, p->addr, ra, type, MO_UB);
+        return io_readx(cpu, p->full, mmu_idx, p->addr, ra, type, MO_UB);
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
         QEMU_IOTHREAD_LOCK_GUARD();
-        ret = do_ld_mmio_beN(env, p->full, 0, p->addr, 2, mmu_idx, type, ra);
+        ret = do_ld_mmio_beN(cpu, p->full, 0, p->addr, 2, mmu_idx, type, ra);
         if ((memop & MO_BSWAP) == MO_LE) {
             ret = bswap16(ret);
         }
     } else {
         /* Perform the load host endian, then swap if necessary. */
-        ret = load_atom_2(env, ra, p->haddr, memop);
+        ret = load_atom_2(cpu->env_ptr, ra, p->haddr, memop);
         if (memop & MO_BSWAP) {
             ret = bswap16(ret);
         }
@@ -2383,20 +2381,20 @@ static uint16_t do_ld_2(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
     return ret;
 }
 
-static uint32_t do_ld_4(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
+static uint32_t do_ld_4(CPUState *cpu, MMULookupPageData *p, int mmu_idx,
                         MMUAccessType type, MemOp memop, uintptr_t ra)
 {
     uint32_t ret;
 
     if (unlikely(p->flags & TLB_MMIO)) {
         QEMU_IOTHREAD_LOCK_GUARD();
-        ret = do_ld_mmio_beN(env, p->full, 0, p->addr, 4, mmu_idx, type, ra);
+        ret = do_ld_mmio_beN(cpu, p->full, 0, p->addr, 4, mmu_idx, type, ra);
         if ((memop & MO_BSWAP) == MO_LE) {
             ret = bswap32(ret);
         }
     } else {
         /* Perform the load host endian. */
-        ret = load_atom_4(env, ra, p->haddr, memop);
+        ret = load_atom_4(cpu->env_ptr, ra, p->haddr, memop);
         if (memop & MO_BSWAP) {
             ret = bswap32(ret);
         }
@@ -2404,20 +2402,20 @@ static uint32_t do_ld_4(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
     return ret;
 }
 
-static uint64_t do_ld_8(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
+static uint64_t do_ld_8(CPUState *cpu, MMULookupPageData *p, int mmu_idx,
                         MMUAccessType type, MemOp memop, uintptr_t ra)
 {
     uint64_t ret;
 
     if (unlikely(p->flags & TLB_MMIO)) {
         QEMU_IOTHREAD_LOCK_GUARD();
-        ret = do_ld_mmio_beN(env, p->full, 0, p->addr, 8, mmu_idx, type, ra);
+        ret = do_ld_mmio_beN(cpu, p->full, 0, p->addr, 8, mmu_idx, type, ra);
         if ((memop & MO_BSWAP) == MO_LE) {
             ret = bswap64(ret);
         }
     } else {
         /* Perform the load host endian. */
-        ret = load_atom_8(env, ra, p->haddr, memop);
+        ret = load_atom_8(cpu->env_ptr, ra, p->haddr, memop);
         if (memop & MO_BSWAP) {
             ret = bswap64(ret);
         }
@@ -2425,27 +2423,27 @@ static uint64_t do_ld_8(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
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
@@ -2454,13 +2452,13 @@ static uint16_t do_ld2_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
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
@@ -2474,10 +2472,10 @@ tcg_target_ulong helper_lduw_mmu(CPUArchState *env, uint64_t addr,
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
@@ -2485,13 +2483,13 @@ static uint32_t do_ld4_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
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
@@ -2502,10 +2500,10 @@ tcg_target_ulong helper_ldul_mmu(CPUArchState *env, uint64_t addr,
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
@@ -2513,13 +2511,13 @@ static uint64_t do_ld8_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
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
@@ -2530,7 +2528,7 @@ uint64_t helper_ldq_mmu(CPUArchState *env, uint64_t addr,
                         MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
-    return do_ld8_mmu(env, addr, oi, retaddr, MMU_DATA_LOAD);
+    return do_ld8_mmu(env_cpu(env), addr, oi, retaddr, MMU_DATA_LOAD);
 }
 
 /*
@@ -2556,7 +2554,7 @@ tcg_target_ulong helper_ldsl_mmu(CPUArchState *env, uint64_t addr,
     return (int32_t)helper_ldul_mmu(env, addr, oi, retaddr);
 }
 
-static Int128 do_ld16_mmu(CPUArchState *env, vaddr addr,
+static Int128 do_ld16_mmu(CPUState *cpu, vaddr addr,
                           MemOpIdx oi, uintptr_t ra)
 {
     MMULookupLocals l;
@@ -2566,13 +2564,13 @@ static Int128 do_ld16_mmu(CPUArchState *env, vaddr addr,
     int first;
 
     cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
-    crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_LOAD, &l);
+    crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_LOAD, &l);
     if (likely(!crosspage)) {
         if (unlikely(l.page[0].flags & TLB_MMIO)) {
             QEMU_IOTHREAD_LOCK_GUARD();
-            a = do_ld_mmio_beN(env, l.page[0].full, 0, addr, 8,
+            a = do_ld_mmio_beN(cpu, l.page[0].full, 0, addr, 8,
                                l.mmu_idx, MMU_DATA_LOAD, ra);
-            b = do_ld_mmio_beN(env, l.page[0].full, 0, addr + 8, 8,
+            b = do_ld_mmio_beN(cpu, l.page[0].full, 0, addr + 8, 8,
                                l.mmu_idx, MMU_DATA_LOAD, ra);
             ret = int128_make128(b, a);
             if ((l.memop & MO_BSWAP) == MO_LE) {
@@ -2580,7 +2578,7 @@ static Int128 do_ld16_mmu(CPUArchState *env, vaddr addr,
             }
         } else {
             /* Perform the load host endian. */
-            ret = load_atom_16(env, ra, l.page[0].haddr, l.memop);
+            ret = load_atom_16(cpu->env_ptr, ra, l.page[0].haddr, l.memop);
             if (l.memop & MO_BSWAP) {
                 ret = bswap128(ret);
             }
@@ -2592,8 +2590,8 @@ static Int128 do_ld16_mmu(CPUArchState *env, vaddr addr,
     if (first == 8) {
         MemOp mop8 = (l.memop & ~MO_SIZE) | MO_64;
 
-        a = do_ld_8(env, &l.page[0], l.mmu_idx, MMU_DATA_LOAD, mop8, ra);
-        b = do_ld_8(env, &l.page[1], l.mmu_idx, MMU_DATA_LOAD, mop8, ra);
+        a = do_ld_8(cpu, &l.page[0], l.mmu_idx, MMU_DATA_LOAD, mop8, ra);
+        b = do_ld_8(cpu, &l.page[1], l.mmu_idx, MMU_DATA_LOAD, mop8, ra);
         if ((mop8 & MO_BSWAP) == MO_LE) {
             ret = int128_make128(a, b);
         } else {
@@ -2603,15 +2601,15 @@ static Int128 do_ld16_mmu(CPUArchState *env, vaddr addr,
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
@@ -2625,7 +2623,7 @@ Int128 helper_ld16_mmu(CPUArchState *env, uint64_t addr,
                        uint32_t oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
-    return do_ld16_mmu(env, addr, oi, retaddr);
+    return do_ld16_mmu(env_cpu(env), addr, oi, retaddr);
 }
 
 Int128 helper_ld_i128(CPUArchState *env, uint64_t addr, uint32_t oi)
@@ -2647,7 +2645,7 @@ uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintptr_t ra)
     uint8_t ret;
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_UB);
-    ret = do_ld1_mmu(env, addr, oi, ra, MMU_DATA_LOAD);
+    ret = do_ld1_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
     plugin_load_cb(env, addr, oi);
     return ret;
 }
@@ -2658,7 +2656,7 @@ uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr addr,
     uint16_t ret;
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
-    ret = do_ld2_mmu(env, addr, oi, ra, MMU_DATA_LOAD);
+    ret = do_ld2_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
     plugin_load_cb(env, addr, oi);
     return ret;
 }
@@ -2669,7 +2667,7 @@ uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr addr,
     uint32_t ret;
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
-    ret = do_ld4_mmu(env, addr, oi, ra, MMU_DATA_LOAD);
+    ret = do_ld4_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
     plugin_load_cb(env, addr, oi);
     return ret;
 }
@@ -2680,7 +2678,7 @@ uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr addr,
     uint64_t ret;
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
-    ret = do_ld8_mmu(env, addr, oi, ra, MMU_DATA_LOAD);
+    ret = do_ld8_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
     plugin_load_cb(env, addr, oi);
     return ret;
 }
@@ -2691,7 +2689,7 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
     Int128 ret;
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
-    ret = do_ld16_mmu(env, addr, oi, ra);
+    ret = do_ld16_mmu(env_cpu(env), addr, oi, ra);
     plugin_load_cb(env, addr, oi);
     return ret;
 }
@@ -2702,7 +2700,7 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
 
 /**
  * do_st_mmio_leN:
- * @env: cpu context
+ * @cpu: generic cpu state
  * @full: page parameters
  * @val_le: data to store
  * @addr: virtual address
@@ -2715,7 +2713,7 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
  * The bytes to store are extracted in little-endian order from @val_le;
  * return the bytes of @val_le beyond @p->size that have not been stored.
  */
-static uint64_t do_st_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
+static uint64_t do_st_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
                                uint64_t val_le, vaddr addr, int size,
                                int mmu_idx, uintptr_t ra)
 {
@@ -2728,26 +2726,26 @@ static uint64_t do_st_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
         case 3:
         case 5:
         case 7:
-            io_writex(env, full, mmu_idx, val_le, addr, ra, MO_UB);
+            io_writex(cpu, full, mmu_idx, val_le, addr, ra, MO_UB);
             val_le >>= 8;
             size -= 1;
             addr += 1;
             break;
         case 2:
         case 6:
-            io_writex(env, full, mmu_idx, val_le, addr, ra, MO_LEUW);
+            io_writex(cpu, full, mmu_idx, val_le, addr, ra, MO_LEUW);
             val_le >>= 16;
             size -= 2;
             addr += 2;
             break;
         case 4:
-            io_writex(env, full, mmu_idx, val_le, addr, ra, MO_LEUL);
+            io_writex(cpu, full, mmu_idx, val_le, addr, ra, MO_LEUL);
             val_le >>= 32;
             size -= 4;
             addr += 4;
             break;
         case 0:
-            io_writex(env, full, mmu_idx, val_le, addr, ra, MO_LEUQ);
+            io_writex(cpu, full, mmu_idx, val_le, addr, ra, MO_LEUQ);
             return 0;
         default:
             qemu_build_not_reached();
@@ -2760,7 +2758,7 @@ static uint64_t do_st_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
 /*
  * Wrapper for the above.
  */
-static uint64_t do_st_leN(CPUArchState *env, MMULookupPageData *p,
+static uint64_t do_st_leN(CPUState *cpu, MMULookupPageData *p,
                           uint64_t val_le, int mmu_idx,
                           MemOp mop, uintptr_t ra)
 {
@@ -2769,7 +2767,7 @@ static uint64_t do_st_leN(CPUArchState *env, MMULookupPageData *p,
 
     if (unlikely(p->flags & TLB_MMIO)) {
         QEMU_IOTHREAD_LOCK_GUARD();
-        return do_st_mmio_leN(env, p->full, val_le, p->addr,
+        return do_st_mmio_leN(cpu, p->full, val_le, p->addr,
                               p->size, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         return val_le >> (p->size * 8);
@@ -2797,7 +2795,7 @@ static uint64_t do_st_leN(CPUArchState *env, MMULookupPageData *p,
             } else if (HAVE_al8) {
                 return store_whole_le8(p->haddr, p->size, val_le);
             } else {
-                cpu_loop_exit_atomic(env_cpu(env), ra);
+                cpu_loop_exit_atomic(cpu, ra);
             }
         }
         /* fall through */
@@ -2815,7 +2813,7 @@ static uint64_t do_st_leN(CPUArchState *env, MMULookupPageData *p,
 /*
  * Wrapper for the above, for 8 < size < 16.
  */
-static uint64_t do_st16_leN(CPUArchState *env, MMULookupPageData *p,
+static uint64_t do_st16_leN(CPUState *cpu, MMULookupPageData *p,
                             Int128 val_le, int mmu_idx,
                             MemOp mop, uintptr_t ra)
 {
@@ -2824,9 +2822,9 @@ static uint64_t do_st16_leN(CPUArchState *env, MMULookupPageData *p,
 
     if (unlikely(p->flags & TLB_MMIO)) {
         QEMU_IOTHREAD_LOCK_GUARD();
-        do_st_mmio_leN(env, p->full, int128_getlo(val_le),
+        do_st_mmio_leN(cpu, p->full, int128_getlo(val_le),
                        p->addr, 8, mmu_idx, ra);
-        return do_st_mmio_leN(env, p->full, int128_gethi(val_le),
+        return do_st_mmio_leN(cpu, p->full, int128_gethi(val_le),
                               p->addr + 8, size - 8, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         return int128_gethi(val_le) >> ((size - 8) * 8);
@@ -2846,7 +2844,7 @@ static uint64_t do_st16_leN(CPUArchState *env, MMULookupPageData *p,
     case MO_ATOM_WITHIN16_PAIR:
         /* Since size > 8, this is the half that must be atomic. */
         if (!HAVE_ATOMIC128_RW) {
-            cpu_loop_exit_atomic(env_cpu(env), ra);
+            cpu_loop_exit_atomic(cpu, ra);
         }
         return store_whole_le16(p->haddr, p->size, val_le);
 
@@ -2867,11 +2865,11 @@ static uint64_t do_st16_leN(CPUArchState *env, MMULookupPageData *p,
     }
 }
 
-static void do_st_1(CPUArchState *env, MMULookupPageData *p, uint8_t val,
+static void do_st_1(CPUState *cpu, MMULookupPageData *p, uint8_t val,
                     int mmu_idx, uintptr_t ra)
 {
     if (unlikely(p->flags & TLB_MMIO)) {
-        io_writex(env, p->full, mmu_idx, val, p->addr, ra, MO_UB);
+        io_writex(cpu, p->full, mmu_idx, val, p->addr, ra, MO_UB);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         /* nothing */
     } else {
@@ -2879,7 +2877,7 @@ static void do_st_1(CPUArchState *env, MMULookupPageData *p, uint8_t val,
     }
 }
 
-static void do_st_2(CPUArchState *env, MMULookupPageData *p, uint16_t val,
+static void do_st_2(CPUState *cpu, MMULookupPageData *p, uint16_t val,
                     int mmu_idx, MemOp memop, uintptr_t ra)
 {
     if (unlikely(p->flags & TLB_MMIO)) {
@@ -2887,7 +2885,7 @@ static void do_st_2(CPUArchState *env, MMULookupPageData *p, uint16_t val,
             val = bswap16(val);
         }
         QEMU_IOTHREAD_LOCK_GUARD();
-        do_st_mmio_leN(env, p->full, val, p->addr, 2, mmu_idx, ra);
+        do_st_mmio_leN(cpu, p->full, val, p->addr, 2, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         /* nothing */
     } else {
@@ -2895,11 +2893,11 @@ static void do_st_2(CPUArchState *env, MMULookupPageData *p, uint16_t val,
         if (memop & MO_BSWAP) {
             val = bswap16(val);
         }
-        store_atom_2(env, ra, p->haddr, memop, val);
+        store_atom_2(cpu->env_ptr, ra, p->haddr, memop, val);
     }
 }
 
-static void do_st_4(CPUArchState *env, MMULookupPageData *p, uint32_t val,
+static void do_st_4(CPUState *cpu, MMULookupPageData *p, uint32_t val,
                     int mmu_idx, MemOp memop, uintptr_t ra)
 {
     if (unlikely(p->flags & TLB_MMIO)) {
@@ -2907,7 +2905,7 @@ static void do_st_4(CPUArchState *env, MMULookupPageData *p, uint32_t val,
             val = bswap32(val);
         }
         QEMU_IOTHREAD_LOCK_GUARD();
-        do_st_mmio_leN(env, p->full, val, p->addr, 4, mmu_idx, ra);
+        do_st_mmio_leN(cpu, p->full, val, p->addr, 4, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         /* nothing */
     } else {
@@ -2915,11 +2913,11 @@ static void do_st_4(CPUArchState *env, MMULookupPageData *p, uint32_t val,
         if (memop & MO_BSWAP) {
             val = bswap32(val);
         }
-        store_atom_4(env, ra, p->haddr, memop, val);
+        store_atom_4(cpu->env_ptr, ra, p->haddr, memop, val);
     }
 }
 
-static void do_st_8(CPUArchState *env, MMULookupPageData *p, uint64_t val,
+static void do_st_8(CPUState *cpu, MMULookupPageData *p, uint64_t val,
                     int mmu_idx, MemOp memop, uintptr_t ra)
 {
     if (unlikely(p->flags & TLB_MMIO)) {
@@ -2927,7 +2925,7 @@ static void do_st_8(CPUArchState *env, MMULookupPageData *p, uint64_t val,
             val = bswap64(val);
         }
         QEMU_IOTHREAD_LOCK_GUARD();
-        do_st_mmio_leN(env, p->full, val, p->addr, 8, mmu_idx, ra);
+        do_st_mmio_leN(cpu, p->full, val, p->addr, 8, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         /* nothing */
     } else {
@@ -2935,7 +2933,7 @@ static void do_st_8(CPUArchState *env, MMULookupPageData *p, uint64_t val,
         if (memop & MO_BSWAP) {
             val = bswap64(val);
         }
-        store_atom_8(env, ra, p->haddr, memop, val);
+        store_atom_8(cpu->env_ptr, ra, p->haddr, memop, val);
     }
 }
 
@@ -2947,13 +2945,13 @@ void helper_stb_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
 
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
@@ -2961,9 +2959,9 @@ static void do_st2_mmu(CPUArchState *env, vaddr addr, uint16_t val,
     uint8_t a, b;
 
     cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
-    crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE, &l);
+    crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
-        do_st_2(env, &l.page[0], val, l.mmu_idx, l.memop, ra);
+        do_st_2(cpu, &l.page[0], val, l.mmu_idx, l.memop, ra);
         return;
     }
 
@@ -2972,27 +2970,27 @@ static void do_st2_mmu(CPUArchState *env, vaddr addr, uint16_t val,
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
 
@@ -3000,27 +2998,27 @@ static void do_st4_mmu(CPUArchState *env, vaddr addr, uint32_t val,
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
 
@@ -3028,18 +3026,18 @@ static void do_st8_mmu(CPUArchState *env, vaddr addr, uint64_t val,
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
@@ -3048,7 +3046,7 @@ static void do_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
     int first;
 
     cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
-    crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE, &l);
+    crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
         if (unlikely(l.page[0].flags & TLB_MMIO)) {
             if ((l.memop & MO_BSWAP) != MO_LE) {
@@ -3057,8 +3055,8 @@ static void do_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
             a = int128_getlo(val);
             b = int128_gethi(val);
             QEMU_IOTHREAD_LOCK_GUARD();
-            do_st_mmio_leN(env, l.page[0].full, a, addr, 8, l.mmu_idx, ra);
-            do_st_mmio_leN(env, l.page[0].full, b, addr + 8, 8, l.mmu_idx, ra);
+            do_st_mmio_leN(cpu, l.page[0].full, a, addr, 8, l.mmu_idx, ra);
+            do_st_mmio_leN(cpu, l.page[0].full, b, addr + 8, 8, l.mmu_idx, ra);
         } else if (unlikely(l.page[0].flags & TLB_DISCARD_WRITE)) {
             /* nothing */
         } else {
@@ -3066,7 +3064,7 @@ static void do_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
             if (l.memop & MO_BSWAP) {
                 val = bswap128(val);
             }
-            store_atom_16(env, ra, l.page[0].haddr, l.memop, val);
+            store_atom_16(cpu->env_ptr, ra, l.page[0].haddr, l.memop, val);
         }
         return;
     }
@@ -3083,8 +3081,8 @@ static void do_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
         } else {
             a = int128_getlo(val), b = int128_gethi(val);
         }
-        do_st_8(env, &l.page[0], a, l.mmu_idx, mop8, ra);
-        do_st_8(env, &l.page[1], b, l.mmu_idx, mop8, ra);
+        do_st_8(cpu, &l.page[0], a, l.mmu_idx, mop8, ra);
+        do_st_8(cpu, &l.page[1], b, l.mmu_idx, mop8, ra);
         return;
     }
 
@@ -3092,12 +3090,12 @@ static void do_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
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
 
@@ -3105,7 +3103,7 @@ void helper_st16_mmu(CPUArchState *env, uint64_t addr, Int128 val,
                      MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
-    do_st16_mmu(env, addr, val, oi, retaddr);
+    do_st16_mmu(env_cpu(env), addr, val, oi, retaddr);
 }
 
 void helper_st_i128(CPUArchState *env, uint64_t addr, Int128 val, MemOpIdx oi)
@@ -3133,7 +3131,7 @@ void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
                  MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
-    do_st2_mmu(env, addr, val, oi, retaddr);
+    do_st2_mmu(env_cpu(env), addr, val, oi, retaddr);
     plugin_store_cb(env, addr, oi);
 }
 
@@ -3141,7 +3139,7 @@ void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
                     MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
-    do_st4_mmu(env, addr, val, oi, retaddr);
+    do_st4_mmu(env_cpu(env), addr, val, oi, retaddr);
     plugin_store_cb(env, addr, oi);
 }
 
@@ -3149,7 +3147,7 @@ void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
                  MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
-    do_st8_mmu(env, addr, val, oi, retaddr);
+    do_st8_mmu(env_cpu(env), addr, val, oi, retaddr);
     plugin_store_cb(env, addr, oi);
 }
 
@@ -3157,7 +3155,7 @@ void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
                   MemOpIdx oi, uintptr_t retaddr)
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
-    do_st16_mmu(env, addr, val, oi, retaddr);
+    do_st16_mmu(env_cpu(env), addr, val, oi, retaddr);
     plugin_store_cb(env, addr, oi);
 }
 
@@ -3199,47 +3197,47 @@ void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
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
2.41.0


