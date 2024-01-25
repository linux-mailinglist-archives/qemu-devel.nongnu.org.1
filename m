Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD46483BA77
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Jan 2024 08:13:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rStHb-00076K-EC; Thu, 25 Jan 2024 01:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rStHY-00075m-FZ
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 01:32:12 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rStHU-0000wo-Rq
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 01:32:12 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxG+ny_7Fl42QFAA--.1754S3;
 Thu, 25 Jan 2024 14:30:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxHs_v_7FlDroYAA--.42256S2; 
 Thu, 25 Jan 2024 14:30:07 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, thuth@redhat.com, wainersm@redhat.com, bleal@redhat.com,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org, pbonzini@redhat.com, maobibo@loongson.cn,
 zhaotianrui@loongson.cn
Subject: [PATCH] target/loongarch: Fix qtest test-hmp error when KVM-only build
Date: Thu, 25 Jan 2024 14:14:01 +0800
Message-Id: <20240125061401.52526-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxHs_v_7FlDroYAA--.42256S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
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

The cc->sysemu_ops->get_phys_page_debug() is NULL when
KVM-only build. this patch fixes it.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/internals.h      |  20 ++-
 target/loongarch/cpu.c            |   2 -
 target/loongarch/cpu_helper.c     | 231 ++++++++++++++++++++++++++++++
 target/loongarch/tcg/tlb_helper.c | 230 -----------------------------
 target/loongarch/meson.build      |   1 +
 5 files changed, 250 insertions(+), 234 deletions(-)
 create mode 100644 target/loongarch/cpu_helper.c

diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 0beb034748..a2fc54c8a7 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -37,6 +37,17 @@ void restore_fp_status(CPULoongArchState *env);
 #endif
 
 #ifndef CONFIG_USER_ONLY
+enum {
+    TLBRET_MATCH = 0,
+    TLBRET_BADADDR = 1,
+    TLBRET_NOMATCH = 2,
+    TLBRET_INVALID = 3,
+    TLBRET_DIRTY = 4,
+    TLBRET_RI = 5,
+    TLBRET_XI = 6,
+    TLBRET_PE = 7,
+};
+
 extern const VMStateDescription vmstate_loongarch_cpu;
 
 void loongarch_cpu_set_irq(void *opaque, int irq, int level);
@@ -46,12 +57,17 @@ uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
 uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
 void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
                                                uint64_t value);
+bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
+                          int *index);
+int get_physical_address(CPULoongArchState *env, hwaddr *physical,
+                         int *prot, target_ulong address,
+                         MMUAccessType access_type, int mmu_idx);
+hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+
 #ifdef CONFIG_TCG
 bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                             MMUAccessType access_type, int mmu_idx,
                             bool probe, uintptr_t retaddr);
-
-hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 #endif
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 064540397d..1e58c160ab 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -752,9 +752,7 @@ static struct TCGCPUOps loongarch_tcg_ops = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps loongarch_sysemu_ops = {
-#ifdef CONFIG_TCG
     .get_phys_page_debug = loongarch_cpu_get_phys_page_debug,
-#endif
 };
 
 static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
new file mode 100644
index 0000000000..f68d63f466
--- /dev/null
+++ b/target/loongarch/cpu_helper.c
@@ -0,0 +1,231 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LoongArch CPU helpers for qemu
+ *
+ * Copyright (c) 2024 Loongson Technology Corporation Limited
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internals.h"
+#include "cpu-csr.h"
+
+static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
+                                   int *prot, target_ulong address,
+                                   int access_type, int index, int mmu_idx)
+{
+    LoongArchTLB *tlb = &env->tlb[index];
+    uint64_t plv = mmu_idx;
+    uint64_t tlb_entry, tlb_ppn;
+    uint8_t tlb_ps, n, tlb_v, tlb_d, tlb_plv, tlb_nx, tlb_nr, tlb_rplv;
+
+    if (index >= LOONGARCH_STLB) {
+        tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
+    } else {
+        tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
+    }
+    n = (address >> tlb_ps) & 0x1;/* Odd or even */
+
+    tlb_entry = n ? tlb->tlb_entry1 : tlb->tlb_entry0;
+    tlb_v = FIELD_EX64(tlb_entry, TLBENTRY, V);
+    tlb_d = FIELD_EX64(tlb_entry, TLBENTRY, D);
+    tlb_plv = FIELD_EX64(tlb_entry, TLBENTRY, PLV);
+    if (is_la64(env)) {
+        tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_64, PPN);
+        tlb_nx = FIELD_EX64(tlb_entry, TLBENTRY_64, NX);
+        tlb_nr = FIELD_EX64(tlb_entry, TLBENTRY_64, NR);
+        tlb_rplv = FIELD_EX64(tlb_entry, TLBENTRY_64, RPLV);
+    } else {
+        tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_32, PPN);
+        tlb_nx = 0;
+        tlb_nr = 0;
+        tlb_rplv = 0;
+    }
+
+    /* Remove sw bit between bit12 -- bit PS*/
+    tlb_ppn = tlb_ppn & ~(((0x1UL << (tlb_ps - 12)) -1));
+
+    /* Check access rights */
+    if (!tlb_v) {
+        return TLBRET_INVALID;
+    }
+
+    if (access_type == MMU_INST_FETCH && tlb_nx) {
+        return TLBRET_XI;
+    }
+
+    if (access_type == MMU_DATA_LOAD && tlb_nr) {
+        return TLBRET_RI;
+    }
+
+    if (((tlb_rplv == 0) && (plv > tlb_plv)) ||
+        ((tlb_rplv == 1) && (plv != tlb_plv))) {
+        return TLBRET_PE;
+    }
+
+    if ((access_type == MMU_DATA_STORE) && !tlb_d) {
+        return TLBRET_DIRTY;
+    }
+
+    *physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
+                (address & MAKE_64BIT_MASK(0, tlb_ps));
+    *prot = PAGE_READ;
+    if (tlb_d) {
+        *prot |= PAGE_WRITE;
+    }
+    if (!tlb_nx) {
+        *prot |= PAGE_EXEC;
+    }
+    return TLBRET_MATCH;
+}
+
+/*
+ * One tlb entry holds an adjacent odd/even pair, the vpn is the
+ * content of the virtual page number divided by 2. So the
+ * compare vpn is bit[47:15] for 16KiB page. while the vppn
+ * field in tlb entry contains bit[47:13], so need adjust.
+ * virt_vpn = vaddr[47:13]
+ */
+bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
+                          int *index)
+{
+    LoongArchTLB *tlb;
+    uint16_t csr_asid, tlb_asid, stlb_idx;
+    uint8_t tlb_e, tlb_ps, tlb_g, stlb_ps;
+    int i, compare_shift;
+    uint64_t vpn, tlb_vppn;
+
+    csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
+    stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
+    vpn = (vaddr & TARGET_VIRT_MASK) >> (stlb_ps + 1);
+    stlb_idx = vpn & 0xff; /* VA[25:15] <==> TLBIDX.index for 16KiB Page */
+    compare_shift = stlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
+
+    /* Search STLB */
+    for (i = 0; i < 8; ++i) {
+        tlb = &env->tlb[i * 256 + stlb_idx];
+        tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
+        if (tlb_e) {
+            tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
+            tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
+            tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
+
+            if ((tlb_g == 1 || tlb_asid == csr_asid) &&
+                (vpn == (tlb_vppn >> compare_shift))) {
+                *index = i * 256 + stlb_idx;
+                return true;
+            }
+        }
+    }
+
+    /* Search MTLB */
+    for (i = LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; ++i) {
+        tlb = &env->tlb[i];
+        tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
+        if (tlb_e) {
+            tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
+            tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
+            tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
+            tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
+            compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
+            vpn = (vaddr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
+            if ((tlb_g == 1 || tlb_asid == csr_asid) &&
+                (vpn == (tlb_vppn >> compare_shift))) {
+                *index = i;
+                return true;
+            }
+        }
+    }
+    return false;
+}
+
+static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
+                                 int *prot, target_ulong address,
+                                 MMUAccessType access_type, int mmu_idx)
+{
+    int index, match;
+
+    match = loongarch_tlb_search(env, address, &index);
+    if (match) {
+        return loongarch_map_tlb_entry(env, physical, prot,
+                                       address, access_type, index, mmu_idx);
+    }
+
+    return TLBRET_NOMATCH;
+}
+
+static hwaddr dmw_va2pa(CPULoongArchState *env, target_ulong va,
+                        target_ulong dmw)
+{
+    if (is_la64(env)) {
+        return va & TARGET_VIRT_MASK;
+    } else {
+        uint32_t pseg = FIELD_EX32(dmw, CSR_DMW_32, PSEG);
+        return (va & MAKE_64BIT_MASK(0, R_CSR_DMW_32_VSEG_SHIFT)) | \
+            (pseg << R_CSR_DMW_32_VSEG_SHIFT);
+    }
+}
+
+int get_physical_address(CPULoongArchState *env, hwaddr *physical,
+                         int *prot, target_ulong address,
+                         MMUAccessType access_type, int mmu_idx)
+{
+    int user_mode = mmu_idx == MMU_IDX_USER;
+    int kernel_mode = mmu_idx == MMU_IDX_KERNEL;
+    uint32_t plv, base_c, base_v;
+    int64_t addr_high;
+    uint8_t da = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, DA);
+    uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
+
+    /* Check PG and DA */
+    if (da & !pg) {
+        *physical = address & TARGET_PHYS_MASK;
+        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        return TLBRET_MATCH;
+    }
+
+    plv = kernel_mode | (user_mode << R_CSR_DMW_PLV3_SHIFT);
+    if (is_la64(env)) {
+        base_v = address >> R_CSR_DMW_64_VSEG_SHIFT;
+    } else {
+        base_v = address >> R_CSR_DMW_32_VSEG_SHIFT;
+    }
+    /* Check direct map window */
+    for (int i = 0; i < 4; i++) {
+        if (is_la64(env)) {
+            base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW_64, VSEG);
+        } else {
+            base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW_32, VSEG);
+        }
+        if ((plv & env->CSR_DMW[i]) && (base_c == base_v)) {
+            *physical = dmw_va2pa(env, address, env->CSR_DMW[i]);
+            *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+            return TLBRET_MATCH;
+        }
+    }
+
+    /* Check valid extension */
+    addr_high = sextract64(address, TARGET_VIRT_ADDR_SPACE_BITS, 16);
+    if (!(addr_high == 0 || addr_high == -1)) {
+        return TLBRET_BADADDR;
+    }
+
+    /* Mapped address */
+    return loongarch_map_address(env, physical, prot, address,
+                                 access_type, mmu_idx);
+}
+
+hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+    hwaddr phys_addr;
+    int prot;
+
+    if (get_physical_address(env, &phys_addr, &prot, addr, MMU_DATA_LOAD,
+                             cpu_mmu_index(env, false)) != 0) {
+        return -1;
+    }
+    return phys_addr;
+}
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 449043c68b..804ab7a263 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -17,236 +17,6 @@
 #include "exec/log.h"
 #include "cpu-csr.h"
 
-enum {
-    TLBRET_MATCH = 0,
-    TLBRET_BADADDR = 1,
-    TLBRET_NOMATCH = 2,
-    TLBRET_INVALID = 3,
-    TLBRET_DIRTY = 4,
-    TLBRET_RI = 5,
-    TLBRET_XI = 6,
-    TLBRET_PE = 7,
-};
-
-static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
-                                   int *prot, target_ulong address,
-                                   int access_type, int index, int mmu_idx)
-{
-    LoongArchTLB *tlb = &env->tlb[index];
-    uint64_t plv = mmu_idx;
-    uint64_t tlb_entry, tlb_ppn;
-    uint8_t tlb_ps, n, tlb_v, tlb_d, tlb_plv, tlb_nx, tlb_nr, tlb_rplv;
-
-    if (index >= LOONGARCH_STLB) {
-        tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
-    } else {
-        tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
-    }
-    n = (address >> tlb_ps) & 0x1;/* Odd or even */
-
-    tlb_entry = n ? tlb->tlb_entry1 : tlb->tlb_entry0;
-    tlb_v = FIELD_EX64(tlb_entry, TLBENTRY, V);
-    tlb_d = FIELD_EX64(tlb_entry, TLBENTRY, D);
-    tlb_plv = FIELD_EX64(tlb_entry, TLBENTRY, PLV);
-    if (is_la64(env)) {
-        tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_64, PPN);
-        tlb_nx = FIELD_EX64(tlb_entry, TLBENTRY_64, NX);
-        tlb_nr = FIELD_EX64(tlb_entry, TLBENTRY_64, NR);
-        tlb_rplv = FIELD_EX64(tlb_entry, TLBENTRY_64, RPLV);
-    } else {
-        tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_32, PPN);
-        tlb_nx = 0;
-        tlb_nr = 0;
-        tlb_rplv = 0;
-    }
-
-    /* Remove sw bit between bit12 -- bit PS*/
-    tlb_ppn = tlb_ppn & ~(((0x1UL << (tlb_ps - 12)) -1));
-
-    /* Check access rights */
-    if (!tlb_v) {
-        return TLBRET_INVALID;
-    }
-
-    if (access_type == MMU_INST_FETCH && tlb_nx) {
-        return TLBRET_XI;
-    }
-
-    if (access_type == MMU_DATA_LOAD && tlb_nr) {
-        return TLBRET_RI;
-    }
-
-    if (((tlb_rplv == 0) && (plv > tlb_plv)) ||
-        ((tlb_rplv == 1) && (plv != tlb_plv))) {
-        return TLBRET_PE;
-    }
-
-    if ((access_type == MMU_DATA_STORE) && !tlb_d) {
-        return TLBRET_DIRTY;
-    }
-
-    *physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
-                (address & MAKE_64BIT_MASK(0, tlb_ps));
-    *prot = PAGE_READ;
-    if (tlb_d) {
-        *prot |= PAGE_WRITE;
-    }
-    if (!tlb_nx) {
-        *prot |= PAGE_EXEC;
-    }
-    return TLBRET_MATCH;
-}
-
-/*
- * One tlb entry holds an adjacent odd/even pair, the vpn is the
- * content of the virtual page number divided by 2. So the
- * compare vpn is bit[47:15] for 16KiB page. while the vppn
- * field in tlb entry contains bit[47:13], so need adjust.
- * virt_vpn = vaddr[47:13]
- */
-static bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
-                                 int *index)
-{
-    LoongArchTLB *tlb;
-    uint16_t csr_asid, tlb_asid, stlb_idx;
-    uint8_t tlb_e, tlb_ps, tlb_g, stlb_ps;
-    int i, compare_shift;
-    uint64_t vpn, tlb_vppn;
-
-    csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
-    stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
-    vpn = (vaddr & TARGET_VIRT_MASK) >> (stlb_ps + 1);
-    stlb_idx = vpn & 0xff; /* VA[25:15] <==> TLBIDX.index for 16KiB Page */
-    compare_shift = stlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
-
-    /* Search STLB */
-    for (i = 0; i < 8; ++i) {
-        tlb = &env->tlb[i * 256 + stlb_idx];
-        tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
-        if (tlb_e) {
-            tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
-            tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
-            tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-
-            if ((tlb_g == 1 || tlb_asid == csr_asid) &&
-                (vpn == (tlb_vppn >> compare_shift))) {
-                *index = i * 256 + stlb_idx;
-                return true;
-            }
-        }
-    }
-
-    /* Search MTLB */
-    for (i = LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; ++i) {
-        tlb = &env->tlb[i];
-        tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
-        if (tlb_e) {
-            tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
-            tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
-            tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
-            tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-            compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
-            vpn = (vaddr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
-            if ((tlb_g == 1 || tlb_asid == csr_asid) &&
-                (vpn == (tlb_vppn >> compare_shift))) {
-                *index = i;
-                return true;
-            }
-        }
-    }
-    return false;
-}
-
-static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
-                                 int *prot, target_ulong address,
-                                 MMUAccessType access_type, int mmu_idx)
-{
-    int index, match;
-
-    match = loongarch_tlb_search(env, address, &index);
-    if (match) {
-        return loongarch_map_tlb_entry(env, physical, prot,
-                                       address, access_type, index, mmu_idx);
-    }
-
-    return TLBRET_NOMATCH;
-}
-
-static hwaddr dmw_va2pa(CPULoongArchState *env, target_ulong va,
-                        target_ulong dmw)
-{
-    if (is_la64(env)) {
-        return va & TARGET_VIRT_MASK;
-    } else {
-        uint32_t pseg = FIELD_EX32(dmw, CSR_DMW_32, PSEG);
-        return (va & MAKE_64BIT_MASK(0, R_CSR_DMW_32_VSEG_SHIFT)) | \
-            (pseg << R_CSR_DMW_32_VSEG_SHIFT);
-    }
-}
-
-static int get_physical_address(CPULoongArchState *env, hwaddr *physical,
-                                int *prot, target_ulong address,
-                                MMUAccessType access_type, int mmu_idx)
-{
-    int user_mode = mmu_idx == MMU_IDX_USER;
-    int kernel_mode = mmu_idx == MMU_IDX_KERNEL;
-    uint32_t plv, base_c, base_v;
-    int64_t addr_high;
-    uint8_t da = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, DA);
-    uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
-
-    /* Check PG and DA */
-    if (da & !pg) {
-        *physical = address & TARGET_PHYS_MASK;
-        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-        return TLBRET_MATCH;
-    }
-
-    plv = kernel_mode | (user_mode << R_CSR_DMW_PLV3_SHIFT);
-    if (is_la64(env)) {
-        base_v = address >> R_CSR_DMW_64_VSEG_SHIFT;
-    } else {
-        base_v = address >> R_CSR_DMW_32_VSEG_SHIFT;
-    }
-    /* Check direct map window */
-    for (int i = 0; i < 4; i++) {
-        if (is_la64(env)) {
-            base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW_64, VSEG);
-        } else {
-            base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW_32, VSEG);
-        }
-        if ((plv & env->CSR_DMW[i]) && (base_c == base_v)) {
-            *physical = dmw_va2pa(env, address, env->CSR_DMW[i]);
-            *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-            return TLBRET_MATCH;
-        }
-    }
-
-    /* Check valid extension */
-    addr_high = sextract64(address, TARGET_VIRT_ADDR_SPACE_BITS, 16);
-    if (!(addr_high == 0 || addr_high == -1)) {
-        return TLBRET_BADADDR;
-    }
-
-    /* Mapped address */
-    return loongarch_map_address(env, physical, prot, address,
-                                 access_type, mmu_idx);
-}
-
-hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
-{
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
-    hwaddr phys_addr;
-    int prot;
-
-    if (get_physical_address(env, &phys_addr, &prot, addr, MMU_DATA_LOAD,
-                             cpu_mmu_index(env, false)) != 0) {
-        return -1;
-    }
-    return phys_addr;
-}
-
 static void raise_mmu_exception(CPULoongArchState *env, target_ulong address,
                                 MMUAccessType access_type, int tlb_error)
 {
diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
index db310f6022..e002e9aaf6 100644
--- a/target/loongarch/meson.build
+++ b/target/loongarch/meson.build
@@ -8,6 +8,7 @@ loongarch_ss.add(files(
 
 loongarch_system_ss = ss.source_set()
 loongarch_system_ss.add(files(
+  'cpu_helper.c',
   'loongarch-qmp-cmds.c',
   'machine.c',
 ))
-- 
2.25.1


