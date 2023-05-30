Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED9371527E
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 02:07:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ms8-0003Wt-Rv; Mon, 29 May 2023 20:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3ms3-0003We-Po
 for qemu-devel@nongnu.org; Mon, 29 May 2023 20:05:51 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3ms1-0000Yy-EC
 for qemu-devel@nongnu.org; Mon, 29 May 2023 20:05:51 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 19A3F746361;
 Tue, 30 May 2023 02:05:44 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4F83174632B; Tue, 30 May 2023 02:05:43 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] tcg: Add tlb_index_and_entry() function
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20230530000543.4F83174632B@zero.eik.bme.hu>
Date: Tue, 30 May 2023 02:05:43 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

The tlb index and entry are often retrieved together and tlb_entry()
already calls tlb_index() so it could easily return it. Add a
tlb_index_and_entry() function that does that to simplify callers and
maybe avoid some duplicate calculations.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 accel/tcg/cputlb.c      | 42 +++++++++++++++++++++--------------------
 include/exec/cpu_ldst.h | 17 ++++++++++++++---
 2 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 90c72c9940..616c68fd09 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1121,6 +1121,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     CPUTLB *tlb = env_tlb(env);
     CPUTLBDesc *desc = &tlb->d[mmu_idx];
     MemoryRegionSection *section;
+    uintptr_t idx;
     unsigned int index;
     target_ulong address;
     target_ulong write_address;
@@ -1203,8 +1204,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     wp_flags = cpu_watchpoint_address_matches(cpu, vaddr_page,
                                               TARGET_PAGE_SIZE);
 
-    index = tlb_index(env, mmu_idx, vaddr_page);
-    te = tlb_entry(env, mmu_idx, vaddr_page);
+    te = tlb_index_and_entry(env, mmu_idx, vaddr_page, &idx);
+    index = idx;
 
     /*
      * Hold the TLB lock for the rest of the function. We could acquire/release
@@ -1504,12 +1505,13 @@ static int probe_access_internal(CPUArchState *env, target_ulong addr,
                                  void **phost, CPUTLBEntryFull **pfull,
                                  uintptr_t retaddr)
 {
-    uintptr_t index = tlb_index(env, mmu_idx, addr);
-    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-    target_ulong tlb_addr = tlb_read_idx(entry, access_type);
-    target_ulong page_addr = addr & TARGET_PAGE_MASK;
+    uintptr_t index;
+    CPUTLBEntry *entry;
+    target_ulong tlb_addr, page_addr = addr & TARGET_PAGE_MASK;
     int flags = TLB_FLAGS_MASK;
 
+    entry = tlb_index_and_entry(env, mmu_idx, addr, &index);
+    tlb_addr = tlb_read_idx(entry, access_type);
     if (!tlb_hit_page(tlb_addr, page_addr)) {
         if (!victim_tlb_hit(env, mmu_idx, index, access_type, page_addr)) {
             CPUState *cs = env_cpu(env);
@@ -1523,8 +1525,7 @@ static int probe_access_internal(CPUArchState *env, target_ulong addr,
             }
 
             /* TLB resize via tlb_fill may have moved the entry.  */
-            index = tlb_index(env, mmu_idx, addr);
-            entry = tlb_entry(env, mmu_idx, addr);
+            entry = tlb_index_and_entry(env, mmu_idx, addr, &index);
 
             /*
              * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
@@ -1691,10 +1692,12 @@ bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
                        bool is_store, struct qemu_plugin_hwaddr *data)
 {
     CPUArchState *env = cpu->env_ptr;
-    CPUTLBEntry *tlbe = tlb_entry(env, mmu_idx, addr);
-    uintptr_t index = tlb_index(env, mmu_idx, addr);
-    target_ulong tlb_addr = is_store ? tlb_addr_write(tlbe) : tlbe->addr_read;
+    CPUTLBEntry *tlbe;
+    uintptr_t index;
+    target_ulong tlb_addr;
 
+    tlbe = tlb_index_and_entry(env, mmu_idx, addr, &index);
+    tlb_addr = is_store ? tlb_addr_write(tlbe) : tlbe->addr_read;
     if (likely(tlb_hit(tlb_addr, addr))) {
         /* We must have an iotlb entry for MMIO */
         if (tlb_addr & TLB_MMIO) {
@@ -1756,19 +1759,20 @@ static bool mmu_lookup1(CPUArchState *env, MMULookupPageData *data,
                         int mmu_idx, MMUAccessType access_type, uintptr_t ra)
 {
     target_ulong addr = data->addr;
-    uintptr_t index = tlb_index(env, mmu_idx, addr);
-    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-    target_ulong tlb_addr = tlb_read_idx(entry, access_type);
+    uintptr_t index;
+    CPUTLBEntry *entry;
+    target_ulong tlb_addr;
     bool maybe_resized = false;
 
+    entry = tlb_index_and_entry(env, mmu_idx, addr, &index);
+    tlb_addr = tlb_read_idx(entry, access_type);
     /* If the TLB entry is for a different page, reload and try again.  */
     if (!tlb_hit(tlb_addr, addr)) {
         if (!victim_tlb_hit(env, mmu_idx, index, access_type,
                             addr & TARGET_PAGE_MASK)) {
             tlb_fill(env_cpu(env), addr, data->size, access_type, mmu_idx, ra);
             maybe_resized = true;
-            index = tlb_index(env, mmu_idx, addr);
-            entry = tlb_entry(env, mmu_idx, addr);
+            entry = tlb_index_and_entry(env, mmu_idx, addr, &index);
         }
         tlb_addr = tlb_read_idx(entry, access_type) & ~TLB_INVALID_MASK;
     }
@@ -1930,8 +1934,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
         goto stop_the_world;
     }
 
-    index = tlb_index(env, mmu_idx, addr);
-    tlbe = tlb_entry(env, mmu_idx, addr);
+    tlbe = tlb_index_and_entry(env, mmu_idx, addr, &index);
 
     /* Check TLB entry and enforce page permissions.  */
     tlb_addr = tlb_addr_write(tlbe);
@@ -1940,8 +1943,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
                             addr & TARGET_PAGE_MASK)) {
             tlb_fill(env_cpu(env), addr, size,
                      MMU_DATA_STORE, mmu_idx, retaddr);
-            index = tlb_index(env, mmu_idx, addr);
-            tlbe = tlb_entry(env, mmu_idx, addr);
+            tlbe = tlb_index_and_entry(env, mmu_idx, addr, &index);
         }
         tlb_addr = tlb_addr_write(tlbe) & ~TLB_INVALID_MASK;
     }
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 5939688f69..7a09edfd50 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -354,7 +354,7 @@ static inline target_ulong tlb_addr_write(const CPUTLBEntry *entry)
     return tlb_read_idx(entry, MMU_DATA_STORE);
 }
 
-/* Find the TLB index corresponding to the mmu_idx + address pair.  */
+/* Find the TLB index corresponding to the mmu_idx + address pair. */
 static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
                                   target_ulong addr)
 {
@@ -363,11 +363,22 @@ static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
     return (addr >> TARGET_PAGE_BITS) & size_mask;
 }
 
-/* Find the TLB entry corresponding to the mmu_idx + address pair.  */
+/* Find the TLB index and entry corresponding to the mmu_idx + address pair. */
+static inline CPUTLBEntry *tlb_index_and_entry(CPUArchState *env,
+                                               uintptr_t mmu_idx,
+                                               target_ulong addr,
+                                               uintptr_t *index)
+{
+    *index = tlb_index(env, mmu_idx, addr);
+    return &env_tlb(env)->f[mmu_idx].table[*index];
+}
+
+/* Find the TLB entry corresponding to the mmu_idx + address pair. */
 static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
                                      target_ulong addr)
 {
-    return &env_tlb(env)->f[mmu_idx].table[tlb_index(env, mmu_idx, addr)];
+    uintptr_t index;
+    return tlb_index_and_entry(env, mmu_idx, addr, &index);
 }
 
 #endif /* defined(CONFIG_USER_ONLY) */
-- 
2.30.9


