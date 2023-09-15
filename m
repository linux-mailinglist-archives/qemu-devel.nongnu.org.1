Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A78577A22A1
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:41:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhAuM-0003Hg-5H; Fri, 15 Sep 2023 11:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qhAuI-0003Gg-Ql
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:38:58 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qhAuG-0007Lb-85
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:38:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id CEC1BCE2C46;
 Fri, 15 Sep 2023 15:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B55BC433C9;
 Fri, 15 Sep 2023 15:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694792331;
 bh=KXuMyWZDUXgWZNz0Stt68ziT1mTqMcTlh1Sk5Mgjwhw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hNGXy61t3idvDENukK4IAK30YmfnoJKaPG9UEQqMAz6a2bWVrjcE7xwNVKD3SAscg
 mKN3eq1/55D12sgibaELsdB1MM6RgeQpmEGP44Ez1ia2S5lgqtxKwHlSjI6yc7uwXr
 MX9C/AjWz70vP8mkfIrPVM6zEcJBDZjDbinNjGfwYnbUXvFBoteOIik+dyrJAStvZR
 04V7e6cqCmzqWF22t0qK8o5IyTQo8DDWfpVMMtVawe9kqA3YeGp1RzAj0sg2+9K+Ao
 DoodDY+CFgGBRZxMVabea/FQDpQBQVM8lUAzJXj39n9yPmsIgOX8ctbWywhXaYpjph
 xA/KZhwmIMOSA==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 4/6] target/hppa: Add BTLB support to hppa TLB functions
Date: Fri, 15 Sep 2023 17:38:39 +0200
Message-ID: <20230915153841.57564-5-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915153841.57564-1-deller@kernel.org>
References: <20230915153841.57564-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

Change the TLB code to store the Block-TLBs at the beginning
of the TLB table. New 4k TLB entries which are added later
shall not overwrite any of the BTLB entries.

Make sure that when the TLB is cleared by the OS via the ptlbe
instruction, the Block-TLBs will not be dropped.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/cpu.h        |  3 +-
 target/hppa/int_helper.c |  2 +-
 target/hppa/mem_helper.c | 87 +++++++++++++++++++++++++++-------------
 target/hppa/op_helper.c  |  3 +-
 4 files changed, 65 insertions(+), 30 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 23852d89b2..730f35231a 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -350,7 +350,8 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 void hppa_cpu_do_interrupt(CPUState *cpu);
 bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
-                              int type, hwaddr *pphys, int *pprot);
+                              int type, hwaddr *pphys, int *pprot,
+                              hppa_tlb_entry **tlb_entry);
 extern const MemoryRegionOps hppa_io_eir_ops;
 extern const VMStateDescription vmstate_hppa_cpu;
 void hppa_cpu_alarm_timer(void *);
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index bebc732c97..3ab9934a1d 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -154,7 +154,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
 
                     vaddr = hppa_form_gva_psw(old_psw, iasq_f, vaddr);
                     t = hppa_get_physical_address(env, vaddr, MMU_KERNEL_IDX,
-                                                  0, &paddr, &prot);
+                                                  0, &paddr, &prot, NULL);
                     if (t >= 0) {
                         /* We can't re-load the instruction.  */
                         env->cr[CR_IIR] = 0;
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 46c3dcaf15..ea33b58ddd 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -41,16 +41,24 @@ static hppa_tlb_entry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
     return NULL;
 }
 
-static void hppa_flush_tlb_ent(CPUHPPAState *env, hppa_tlb_entry *ent)
+static void hppa_flush_tlb_ent(CPUHPPAState *env, hppa_tlb_entry *ent,
+                               bool force_flush_btlb)
 {
     CPUState *cs = env_cpu(env);
-    unsigned i, n = 1 << (2 * ent->page_size);
-    uint64_t addr = ent->va_b;
+
+    if (!ent->entry_valid) {
+        return;
+    }
 
     trace_hppa_tlb_flush_ent(env, ent, ent->va_b, ent->va_e, ent->pa);
 
-    for (i = 0; i < n; ++i, addr += TARGET_PAGE_SIZE) {
-        tlb_flush_page_by_mmuidx(cs, addr, HPPA_MMU_FLUSH_MASK);
+    tlb_flush_range_by_mmuidx(cs, ent->va_b,
+                                ent->va_e - ent->va_b + 1,
+                                HPPA_MMU_FLUSH_MASK, TARGET_LONG_BITS);
+
+    /* never clear BTLBs, unless forced to do so. */
+    if (ent < &env->tlb[HPPA_BTLB_ENTRIES] && !force_flush_btlb) {
+        return;
     }
 
     memset(ent, 0, sizeof(*ent));
@@ -60,23 +68,35 @@ static void hppa_flush_tlb_ent(CPUHPPAState *env, hppa_tlb_entry *ent)
 static hppa_tlb_entry *hppa_alloc_tlb_ent(CPUHPPAState *env)
 {
     hppa_tlb_entry *ent;
-    uint32_t i = env->tlb_last;
+    uint32_t i;
+
+    if (env->tlb_last < HPPA_BTLB_ENTRIES || env->tlb_last >= ARRAY_SIZE(env->tlb)) {
+        i = HPPA_BTLB_ENTRIES;
+        env->tlb_last = HPPA_BTLB_ENTRIES + 1;
+    } else {
+        i = env->tlb_last;
+        env->tlb_last++;
+    }
 
-    env->tlb_last = (i == ARRAY_SIZE(env->tlb) - 1 ? 0 : i + 1);
     ent = &env->tlb[i];
 
-    hppa_flush_tlb_ent(env, ent);
+    hppa_flush_tlb_ent(env, ent, false);
     return ent;
 }
 
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
-                              int type, hwaddr *pphys, int *pprot)
+                              int type, hwaddr *pphys, int *pprot,
+                              hppa_tlb_entry **tlb_entry)
 {
     hwaddr phys;
     int prot, r_prot, w_prot, x_prot, priv;
     hppa_tlb_entry *ent;
     int ret = -1;
 
+    if (tlb_entry) {
+        *tlb_entry = NULL;
+    }
+
     /* Virtual translation disabled.  Direct map virtual to physical.  */
     if (mmu_idx == MMU_PHYS_IDX) {
         phys = addr;
@@ -93,8 +113,12 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         goto egress;
     }
 
+    if (tlb_entry) {
+        *tlb_entry = ent;
+    }
+
     /* We now know the physical address.  */
-    phys = ent->pa + (addr & ~TARGET_PAGE_MASK);
+    phys = ent->pa + (addr - ent->va_b);
 
     /* Map TLB access_rights field to QEMU protection.  */
     priv = MMU_IDX_TO_PRIV(mmu_idx);
@@ -193,7 +217,7 @@ hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     }
 
     excp = hppa_get_physical_address(&cpu->env, addr, MMU_KERNEL_IDX, 0,
-                                     &phys, &prot);
+                                     &phys, &prot, NULL);
 
     /* Since we're translating for debugging, the only error that is a
        hard error is no translation at all.  Otherwise, while a real cpu
@@ -207,6 +231,7 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
+    hppa_tlb_entry *ent;
     int prot, excp, a_prot;
     hwaddr phys;
 
@@ -223,7 +248,7 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     }
 
     excp = hppa_get_physical_address(env, addr, mmu_idx,
-                                     a_prot, &phys, &prot);
+                                     a_prot, &phys, &prot, &ent);
     if (unlikely(excp >= 0)) {
         if (probe) {
             return false;
@@ -243,7 +268,7 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
                                 phys & TARGET_PAGE_MASK, size, type, mmu_idx);
     /* Success!  Store the translation into the QEMU TLB.  */
     tlb_set_page(cs, addr & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
-                 prot, mmu_idx, TARGET_PAGE_SIZE);
+                 prot, mmu_idx, TARGET_PAGE_SIZE << (ent ? 2 * ent->page_size : 0));
     return true;
 }
 
@@ -254,11 +279,11 @@ void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
     int i;
 
     /* Zap any old entries covering ADDR; notice empty entries on the way.  */
-    for (i = 0; i < ARRAY_SIZE(env->tlb); ++i) {
+    for (i = HPPA_BTLB_ENTRIES; i < ARRAY_SIZE(env->tlb); ++i) {
         hppa_tlb_entry *ent = &env->tlb[i];
         if (ent->va_b <= addr && addr <= ent->va_e) {
             if (ent->entry_valid) {
-                hppa_flush_tlb_ent(env, ent);
+                hppa_flush_tlb_ent(env, ent, false);
             }
             if (!empty) {
                 empty = ent;
@@ -278,16 +303,8 @@ void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
     trace_hppa_tlb_itlba(env, empty, empty->va_b, empty->va_e, empty->pa);
 }
 
-/* Insert (Insn/Data) TLB Protection.  Note this is PA 1.1 only.  */
-void HELPER(itlbp)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
+static void set_access_bits(CPUHPPAState *env, hppa_tlb_entry *ent, target_ureg reg)
 {
-    hppa_tlb_entry *ent = hppa_find_tlb(env, addr);
-
-    if (unlikely(ent == NULL)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "ITLBP not following ITLBA\n");
-        return;
-    }
-
     ent->access_id = extract32(reg, 1, 18);
     ent->u = extract32(reg, 19, 1);
     ent->ar_pl2 = extract32(reg, 20, 2);
@@ -301,6 +318,19 @@ void HELPER(itlbp)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
                          ent->ar_pl1, ent->ar_type, ent->b, ent->d, ent->t);
 }
 
+/* Insert (Insn/Data) TLB Protection.  Note this is PA 1.1 only.  */
+void HELPER(itlbp)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
+{
+    hppa_tlb_entry *ent = hppa_find_tlb(env, addr);
+
+    if (unlikely(ent == NULL)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "ITLBP not following ITLBA\n");
+        return;
+    }
+
+    set_access_bits(env, ent, reg);
+}
+
 /* Purge (Insn/Data) TLB.  This is explicitly page-based, and is
    synchronous across all processors.  */
 static void ptlb_work(CPUState *cpu, run_on_cpu_data data)
@@ -310,7 +340,7 @@ static void ptlb_work(CPUState *cpu, run_on_cpu_data data)
     hppa_tlb_entry *ent = hppa_find_tlb(env, addr);
 
     if (ent && ent->entry_valid) {
-        hppa_flush_tlb_ent(env, ent);
+        hppa_flush_tlb_ent(env, ent, false);
     }
 }
 
@@ -334,7 +364,10 @@ void HELPER(ptlb)(CPUHPPAState *env, target_ulong addr)
 void HELPER(ptlbe)(CPUHPPAState *env)
 {
     trace_hppa_tlb_ptlbe(env);
-    memset(env->tlb, 0, sizeof(env->tlb));
+    qemu_log_mask(CPU_LOG_MMU, "FLUSH ALL TLB ENTRIES\n");
+    memset(&env->tlb[HPPA_BTLB_ENTRIES], 0,
+        sizeof(env->tlb) - HPPA_BTLB_ENTRIES * sizeof(env->tlb[0]));
+    env->tlb_last = HPPA_BTLB_ENTRIES;
     tlb_flush_by_mmuidx(env_cpu(env), HPPA_MMU_FLUSH_MASK);
 }
 
@@ -356,7 +389,7 @@ target_ureg HELPER(lpa)(CPUHPPAState *env, target_ulong addr)
     int prot, excp;
 
     excp = hppa_get_physical_address(env, addr, MMU_KERNEL_IDX, 0,
-                                     &phys, &prot);
+                                     &phys, &prot, NULL);
     if (excp >= 0) {
         if (env->psw & PSW_Q) {
             /* ??? Needs tweaking for hppa64.  */
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index f25a5a72aa..837e2b3117 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -179,7 +179,8 @@ target_ureg HELPER(probe)(CPUHPPAState *env, target_ulong addr,
         return 0;
     }
 
-    excp = hppa_get_physical_address(env, addr, level, 0, &phys, &prot);
+    excp = hppa_get_physical_address(env, addr, level, 0, &phys,
+                                     &prot, NULL);
     if (excp >= 0) {
         if (env->psw & PSW_Q) {
             /* ??? Needs tweaking for hppa64.  */
-- 
2.41.0


