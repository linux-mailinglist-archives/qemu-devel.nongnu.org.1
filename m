Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 171047385FB
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:59:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByKP-0004DI-Em; Wed, 21 Jun 2023 09:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qByKM-0004CX-TK
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:56:54 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qByKL-00057u-00
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=I/h6CCTzFOa7W7e+KNJhOlafpIubjkWhZVPVv3nr0lc=; b=SJ/9y/WA+Owl7Cp361S17tsdQm
 Y+gIx1N8GHjJJt4DWqLblYrqb8danBW34f7fNFrvyNWOTS8xYxy8B1FZJauOD+2QK1+is3OhIrYOd
 w04pLmgPJZI+EOlb9myQuY3FOFC5eO1/8bF9rAJ1/H4F/oD84/otNvx8GIPiuOl8qsaE=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com
Subject: [PATCH v3 08/12] accel: Replace target_ulong with vaddr in probe_*()
Date: Wed, 21 Jun 2023 15:56:29 +0200
Message-ID: <20230621135633.1649-9-anjo@rev.ng>
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

Functions for probing memory accesses (and functions that call these)
are updated to take a vaddr for guest virtual addresses over
target_ulong.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/stubs/tcg-stub.c  |  4 ++--
 accel/tcg/cputlb.c      | 12 ++++++------
 accel/tcg/user-exec.c   |  8 ++++----
 include/exec/exec-all.h | 14 +++++++-------
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 0998e601ad..a9e7a2d5b4 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -26,14 +26,14 @@ void tcg_flush_jmp_cache(CPUState *cpu)
 {
 }
 
-int probe_access_flags(CPUArchState *env, target_ulong addr, int size,
+int probe_access_flags(CPUArchState *env, vaddr addr, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool nonfault, void **phost, uintptr_t retaddr)
 {
      g_assert_not_reached();
 }
 
-void *probe_access(CPUArchState *env, target_ulong addr, int size,
+void *probe_access(CPUArchState *env, vaddr addr, int size,
                    MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
      /* Handled by hardware accelerator. */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index bdf400f6e6..d873e58a5d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1499,7 +1499,7 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
     }
 }
 
-static int probe_access_internal(CPUArchState *env, target_ulong addr,
+static int probe_access_internal(CPUArchState *env, vaddr addr,
                                  int fault_size, MMUAccessType access_type,
                                  int mmu_idx, bool nonfault,
                                  void **phost, CPUTLBEntryFull **pfull,
@@ -1508,7 +1508,7 @@ static int probe_access_internal(CPUArchState *env, target_ulong addr,
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
-    target_ulong page_addr = addr & TARGET_PAGE_MASK;
+    vaddr page_addr = addr & TARGET_PAGE_MASK;
     int flags = TLB_FLAGS_MASK;
 
     if (!tlb_hit_page(tlb_addr, page_addr)) {
@@ -1551,7 +1551,7 @@ static int probe_access_internal(CPUArchState *env, target_ulong addr,
     return flags;
 }
 
-int probe_access_full(CPUArchState *env, target_ulong addr, int size,
+int probe_access_full(CPUArchState *env, vaddr addr, int size,
                       MMUAccessType access_type, int mmu_idx,
                       bool nonfault, void **phost, CPUTLBEntryFull **pfull,
                       uintptr_t retaddr)
@@ -1568,7 +1568,7 @@ int probe_access_full(CPUArchState *env, target_ulong addr, int size,
     return flags;
 }
 
-int probe_access_flags(CPUArchState *env, target_ulong addr, int size,
+int probe_access_flags(CPUArchState *env, vaddr addr, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool nonfault, void **phost, uintptr_t retaddr)
 {
@@ -1589,7 +1589,7 @@ int probe_access_flags(CPUArchState *env, target_ulong addr, int size,
     return flags;
 }
 
-void *probe_access(CPUArchState *env, target_ulong addr, int size,
+void *probe_access(CPUArchState *env, vaddr addr, int size,
                    MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     CPUTLBEntryFull *full;
@@ -1648,7 +1648,7 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
  * NOTE: This function will trigger an exception if the page is
  * not executable.
  */
-tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, target_ulong addr,
+tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
                                         void **hostp)
 {
     CPUTLBEntryFull *full;
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index dc8d6b5d40..d71e26a7b5 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -721,7 +721,7 @@ int page_unprotect(target_ulong address, uintptr_t pc)
     return current_tb_invalidated ? 2 : 1;
 }
 
-static int probe_access_internal(CPUArchState *env, target_ulong addr,
+static int probe_access_internal(CPUArchState *env, vaddr addr,
                                  int fault_size, MMUAccessType access_type,
                                  bool nonfault, uintptr_t ra)
 {
@@ -759,7 +759,7 @@ static int probe_access_internal(CPUArchState *env, target_ulong addr,
     cpu_loop_exit_sigsegv(env_cpu(env), addr, access_type, maperr, ra);
 }
 
-int probe_access_flags(CPUArchState *env, target_ulong addr, int size,
+int probe_access_flags(CPUArchState *env, vaddr addr, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool nonfault, void **phost, uintptr_t ra)
 {
@@ -771,7 +771,7 @@ int probe_access_flags(CPUArchState *env, target_ulong addr, int size,
     return flags;
 }
 
-void *probe_access(CPUArchState *env, target_ulong addr, int size,
+void *probe_access(CPUArchState *env, vaddr addr, int size,
                    MMUAccessType access_type, int mmu_idx, uintptr_t ra)
 {
     int flags;
@@ -783,7 +783,7 @@ void *probe_access(CPUArchState *env, target_ulong addr, int size,
     return size ? g2h(env_cpu(env), addr) : NULL;
 }
 
-tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, target_ulong addr,
+tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
                                         void **hostp)
 {
     int flags;
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index f5508e242b..cc1c3556f6 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -413,16 +413,16 @@ static inline void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
  * Finally, return the host address for a page that is backed by RAM,
  * or NULL if the page requires I/O.
  */
-void *probe_access(CPUArchState *env, target_ulong addr, int size,
+void *probe_access(CPUArchState *env, vaddr addr, int size,
                    MMUAccessType access_type, int mmu_idx, uintptr_t retaddr);
 
-static inline void *probe_write(CPUArchState *env, target_ulong addr, int size,
+static inline void *probe_write(CPUArchState *env, vaddr addr, int size,
                                 int mmu_idx, uintptr_t retaddr)
 {
     return probe_access(env, addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
 }
 
-static inline void *probe_read(CPUArchState *env, target_ulong addr, int size,
+static inline void *probe_read(CPUArchState *env, vaddr addr, int size,
                                int mmu_idx, uintptr_t retaddr)
 {
     return probe_access(env, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
@@ -447,7 +447,7 @@ static inline void *probe_read(CPUArchState *env, target_ulong addr, int size,
  * Do handle clean pages, so exclude TLB_NOTDIRY from the returned flags.
  * For simplicity, all "mmio-like" flags are folded to TLB_MMIO.
  */
-int probe_access_flags(CPUArchState *env, target_ulong addr, int size,
+int probe_access_flags(CPUArchState *env, vaddr addr, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool nonfault, void **phost, uintptr_t retaddr);
 
@@ -460,7 +460,7 @@ int probe_access_flags(CPUArchState *env, target_ulong addr, int size,
  * and must be consumed or copied immediately, before any further
  * access or changes to TLB @mmu_idx.
  */
-int probe_access_full(CPUArchState *env, target_ulong addr, int size,
+int probe_access_full(CPUArchState *env, vaddr addr, int size,
                       MMUAccessType access_type, int mmu_idx,
                       bool nonfault, void **phost,
                       CPUTLBEntryFull **pfull, uintptr_t retaddr);
@@ -581,7 +581,7 @@ struct MemoryRegionSection *iotlb_to_section(CPUState *cpu,
  *
  * Note: this function can trigger an exception.
  */
-tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, target_ulong addr,
+tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
                                         void **hostp);
 
 /**
@@ -596,7 +596,7 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, target_ulong addr,
  * Note: this function can trigger an exception.
  */
 static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
-                                                target_ulong addr)
+                                                vaddr addr)
 {
     return get_page_addr_code_hostp(env, addr, NULL);
 }
-- 
2.41.0


