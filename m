Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CED79D516
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 17:37:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg5QA-0007Nz-Hb; Tue, 12 Sep 2023 11:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qg5Ps-0007Iu-Ea
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:35:05 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qg5Ph-0001WZ-SR
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C/v3CCWgAmZwtexjXdzrHXxC9xO96YviJzsqXM2DB9Q=; b=UpC4Qn/JhR6A+Q85kPK0gj09M7
 DwSdOvxiRDRviV1fNJYWcdxT/RQDlCpLlHS3Lvr9m2PCJwqyMA3/c/JHP0zqM6+HBAMCouXoI5dYL
 ta6FliPmwm1KxHQX5gwMZ/DNd+hwzls12Ai5sQCFEGjwpgAMS7FMnx5Fe7gQ/DYk2+ZA=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, peter.maydell@linaro.org
Subject: [PATCH 04/11] accel/tcg: Modify probe_access_internal() to use
 CPUState
Date: Tue, 12 Sep 2023 17:34:21 +0200
Message-ID: <20230912153428.17816-5-anjo@rev.ng>
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

probe_access_internal() is changed to instead take the generic CPUState
over CPUArchState, in order to lessen the target-specific coupling of
cputlb.c. Note: probe_access*() also don't need the full CPUArchState,
but aren't touched in this patch as they are target-facing.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 accel/tcg/cputlb.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 213b3236bb..20ea2e2395 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1504,27 +1504,24 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
     }
 }
 
-static int probe_access_internal(CPUArchState *env, vaddr addr,
+static int probe_access_internal(CPUState *cpu, vaddr addr,
                                  int fault_size, MMUAccessType access_type,
                                  int mmu_idx, bool nonfault,
                                  void **phost, CPUTLBEntryFull **pfull,
                                  uintptr_t retaddr, bool check_mem_cbs)
 {
-    uintptr_t index = tlb_index(env_cpu(env), mmu_idx, addr);
-    CPUTLBEntry *entry = tlb_entry(env_cpu(env), mmu_idx, addr);
+    uintptr_t index = tlb_index(cpu, mmu_idx, addr);
+    CPUTLBEntry *entry = tlb_entry(cpu, mmu_idx, addr);
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
     vaddr page_addr = addr & TARGET_PAGE_MASK;
     int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
-    bool force_mmio = check_mem_cbs && cpu_plugin_mem_cbs_enabled(env_cpu(env));
+    bool force_mmio = check_mem_cbs && cpu_plugin_mem_cbs_enabled(cpu);
     CPUTLBEntryFull *full;
 
     if (!tlb_hit_page(tlb_addr, page_addr)) {
-        if (!victim_tlb_hit(env_cpu(env), mmu_idx, index,
-                            access_type, page_addr)) {
-            CPUState *cs = env_cpu(env);
-
-            if (!cs->cc->tcg_ops->tlb_fill(cs, addr, fault_size, access_type,
-                                           mmu_idx, nonfault, retaddr)) {
+        if (!victim_tlb_hit(cpu, mmu_idx, index, access_type, page_addr)) {
+            if (!cpu->cc->tcg_ops->tlb_fill(cpu, addr, fault_size, access_type,
+                                            mmu_idx, nonfault, retaddr)) {
                 /* Non-faulting page table read failed.  */
                 *phost = NULL;
                 *pfull = NULL;
@@ -1532,8 +1529,8 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
             }
 
             /* TLB resize via tlb_fill may have moved the entry.  */
-            index = tlb_index(env_cpu(env), mmu_idx, addr);
-            entry = tlb_entry(env_cpu(env), mmu_idx, addr);
+            index = tlb_index(cpu, mmu_idx, addr);
+            entry = tlb_entry(cpu, mmu_idx, addr);
 
             /*
              * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
@@ -1546,7 +1543,7 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
     }
     flags &= tlb_addr;
 
-    *pfull = full = &env_tlb(env)->d[mmu_idx].fulltlb[index];
+    *pfull = full = &cpu_tlb(cpu)->d[mmu_idx].fulltlb[index];
     flags |= full->slow_flags[access_type];
 
     /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
@@ -1567,8 +1564,9 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
                       bool nonfault, void **phost, CPUTLBEntryFull **pfull,
                       uintptr_t retaddr)
 {
-    int flags = probe_access_internal(env, addr, size, access_type, mmu_idx,
-                                      nonfault, phost, pfull, retaddr, true);
+    int flags = probe_access_internal(env_cpu(env), addr, size, access_type,
+                                      mmu_idx, nonfault, phost, pfull, retaddr,
+                                      true);
 
     /* Handle clean RAM pages.  */
     if (unlikely(flags & TLB_NOTDIRTY)) {
@@ -1590,8 +1588,8 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
     phost = phost ? phost : &discard_phost;
     pfull = pfull ? pfull : &discard_tlb;
 
-    int flags = probe_access_internal(env, addr, size, access_type, mmu_idx,
-                                      true, phost, pfull, 0, false);
+    int flags = probe_access_internal(env_cpu(env), addr, size, access_type,
+                                      mmu_idx, true, phost, pfull, 0, false);
 
     /* Handle clean RAM pages.  */
     if (unlikely(flags & TLB_NOTDIRTY)) {
@@ -1611,8 +1609,9 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
 
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
 
-    flags = probe_access_internal(env, addr, size, access_type, mmu_idx,
-                                  nonfault, phost, &full, retaddr, true);
+    flags = probe_access_internal(env_cpu(env), addr, size, access_type,
+                                  mmu_idx, nonfault, phost, &full, retaddr,
+                                  true);
 
     /* Handle clean RAM pages. */
     if (unlikely(flags & TLB_NOTDIRTY)) {
@@ -1632,8 +1631,9 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
 
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
 
-    flags = probe_access_internal(env, addr, size, access_type, mmu_idx,
-                                  false, &host, &full, retaddr, true);
+    flags = probe_access_internal(env_cpu(env), addr, size, access_type,
+                                  mmu_idx, false, &host, &full, retaddr,
+                                  true);
 
     /* Per the interface, size == 0 merely faults the access. */
     if (size == 0) {
@@ -1665,7 +1665,7 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
     void *host;
     int flags;
 
-    flags = probe_access_internal(env, addr, 0, access_type,
+    flags = probe_access_internal(env_cpu(env), addr, 0, access_type,
                                   mmu_idx, true, &host, &full, 0, false);
 
     /* No combination of flags are expected by the caller. */
@@ -1688,7 +1688,7 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
     CPUTLBEntryFull *full;
     void *p;
 
-    (void)probe_access_internal(env, addr, 1, MMU_INST_FETCH,
+    (void)probe_access_internal(env_cpu(env), addr, 1, MMU_INST_FETCH,
                                 cpu_mmu_index(env, true), false,
                                 &p, &full, 0, false);
     if (p == NULL) {
-- 
2.41.0


