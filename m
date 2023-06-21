Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C127385D5
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:58:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByKM-0004BF-8Q; Wed, 21 Jun 2023 09:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qByKJ-0004AT-CX
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:56:51 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qByKH-00057L-E9
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=A2qob2InuXTgLstwPO/VefZSuA6YgP+Qhnq0lUwXTfk=; b=tQHYhpF8Ze/VGIyIixzgE2WhuK
 Z1bMa8jLc2vYjsaVo9h94Gtq3Nq5sdkvbi7fYAv458MnArhl1Y74ILA9LBP1LQ54u8Uv57Sjqq+zC
 D/Q0E4DBRIDA5Ny5y3XByiXx/d4RtIiDTVo5zQR4bm5Rb8q+kZBr/Oku4wjJCYhiKs5g=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com
Subject: [PATCH v3 04/12] accel/tcg/cputlb.c: Widen CPUTLBEntry access
 functions
Date: Wed, 21 Jun 2023 15:56:25 +0200
Message-ID: <20230621135633.1649-5-anjo@rev.ng>
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

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c      |  8 ++++----
 include/exec/cpu_ldst.h | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5caeccb52d..ac990a1526 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1453,7 +1453,7 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
     assert_cpu_is_self(env_cpu(env));
     for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
         CPUTLBEntry *vtlb = &env_tlb(env)->d[mmu_idx].vtable[vidx];
-        target_ulong cmp = tlb_read_idx(vtlb, access_type);
+        uint64_t cmp = tlb_read_idx(vtlb, access_type);
 
         if (cmp == page) {
             /* Found entry in victim tlb, swap tlb and iotlb.  */
@@ -1507,7 +1507,7 @@ static int probe_access_internal(CPUArchState *env, target_ulong addr,
 {
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-    target_ulong tlb_addr = tlb_read_idx(entry, access_type);
+    uint64_t tlb_addr = tlb_read_idx(entry, access_type);
     target_ulong page_addr = addr & TARGET_PAGE_MASK;
     int flags = TLB_FLAGS_MASK;
 
@@ -1694,7 +1694,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
     CPUArchState *env = cpu->env_ptr;
     CPUTLBEntry *tlbe = tlb_entry(env, mmu_idx, addr);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
-    vaddr tlb_addr = is_store ? tlb_addr_write(tlbe) : tlbe->addr_read;
+    uint64_t tlb_addr = is_store ? tlb_addr_write(tlbe) : tlbe->addr_read;
 
     if (likely(tlb_hit(tlb_addr, addr))) {
         /* We must have an iotlb entry for MMIO */
@@ -1759,7 +1759,7 @@ static bool mmu_lookup1(CPUArchState *env, MMULookupPageData *data,
     target_ulong addr = data->addr;
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-    target_ulong tlb_addr = tlb_read_idx(entry, access_type);
+    uint64_t tlb_addr = tlb_read_idx(entry, access_type);
     bool maybe_resized = false;
 
     /* If the TLB entry is for a different page, reload and try again.  */
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 896f305ff3..645476f0e5 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -328,8 +328,8 @@ static inline void clear_helper_retaddr(void)
 
 #include "tcg/oversized-guest.h"
 
-static inline target_ulong tlb_read_idx(const CPUTLBEntry *entry,
-                                        MMUAccessType access_type)
+static inline uint64_t tlb_read_idx(const CPUTLBEntry *entry,
+                                    MMUAccessType access_type)
 {
     /* Do not rearrange the CPUTLBEntry structure members. */
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_read) !=
@@ -355,14 +355,14 @@ static inline target_ulong tlb_read_idx(const CPUTLBEntry *entry,
 #endif
 }
 
-static inline target_ulong tlb_addr_write(const CPUTLBEntry *entry)
+static inline uint64_t tlb_addr_write(const CPUTLBEntry *entry)
 {
     return tlb_read_idx(entry, MMU_DATA_STORE);
 }
 
 /* Find the TLB index corresponding to the mmu_idx + address pair.  */
 static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
-                                  target_ulong addr)
+                                  vaddr addr)
 {
     uintptr_t size_mask = env_tlb(env)->f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS;
 
@@ -371,7 +371,7 @@ static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
 
 /* Find the TLB entry corresponding to the mmu_idx + address pair.  */
 static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
-                                     target_ulong addr)
+                                     vaddr addr)
 {
     return &env_tlb(env)->f[mmu_idx].table[tlb_index(env, mmu_idx, addr)];
 }
-- 
2.41.0


