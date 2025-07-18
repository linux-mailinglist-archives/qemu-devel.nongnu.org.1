Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A71B09CE3
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Jul 2025 09:43:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucfj3-0001ZS-4S; Fri, 18 Jul 2025 03:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ucfW4-0002de-79
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 03:28:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ucfVz-0002jF-2n
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 03:28:22 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxQK2M93lox8ksAQ--.9335S3;
 Fri, 18 Jul 2025 15:28:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxocKI93lo0QwcAA--.17387S7;
 Fri, 18 Jul 2025 15:28:11 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 5/9] target/loongarch: Add common function
 loongarch_check_pte()
Date: Fri, 18 Jul 2025 15:28:03 +0800
Message-Id: <20250718072807.3585466-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250718072807.3585466-1-maobibo@loongson.cn>
References: <20250718072807.3585466-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxocKI93lo0QwcAA--.17387S7
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Common function loongarch_check_pte() is to check tlb entry, return
the physical address and access priviledge. Also it can be used with
page table entry, which is used in page table walker.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu-mmu.h        |  8 ++++
 target/loongarch/cpu_helper.c     | 62 +++++++++++++++++++++++++++++++
 target/loongarch/tcg/tlb_helper.c | 61 ++++--------------------------
 3 files changed, 78 insertions(+), 53 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 4c5cbd7425..7162e76238 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -19,7 +19,15 @@ enum {
     TLBRET_PE = 7,
 };
 
+typedef struct mmu_context {
+    target_ulong  vaddr;
+    uint64_t      pte;
+    int           ps;  /* page size shift */
+} mmu_context;
+
 bool check_ps(CPULoongArchState *ent, uint8_t ps);
+int loongarch_check_pte(CPULoongArchState *env, hwaddr *physical, int *prot,
+                        mmu_context *context, int access_type, int mmu_idx);
 int get_physical_address(CPULoongArchState *env, hwaddr *physical,
                          int *prot, target_ulong address,
                          MMUAccessType access_type, int mmu_idx, int is_debug);
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 2e8d3d7cfb..c90e260566 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -44,6 +44,68 @@ void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
     }
 }
 
+int loongarch_check_pte(CPULoongArchState *env, hwaddr *physical, int *prot,
+                        mmu_context *context, int access_type, int mmu_idx)
+{
+    uint64_t plv = mmu_idx;
+    uint64_t tlb_entry, tlb_ppn;
+    uint8_t tlb_ps, tlb_v, tlb_d, tlb_plv, tlb_nx, tlb_nr, tlb_rplv;
+
+    tlb_entry = context->pte;
+    tlb_ps = context->ps;
+
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
+    /* Remove sw bit between bit12 -- bit PS*/
+    tlb_ppn = tlb_ppn & ~(((0x1UL << (tlb_ps - 12)) - 1));
+    *physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
+                (context->vaddr & MAKE_64BIT_MASK(0, tlb_ps));
+    *prot = PAGE_READ;
+    if (tlb_d) {
+        *prot |= PAGE_WRITE;
+    }
+    if (!tlb_nx) {
+        *prot |= PAGE_EXEC;
+    }
+
+    return TLBRET_MATCH;
+}
+
 static int loongarch_page_table_walker(CPULoongArchState *env, hwaddr *physical,
                                  int *prot, target_ulong address)
 {
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 1f49619e7f..ca2fabfa6a 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -653,64 +653,19 @@ static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
                                    int access_type, int index, int mmu_idx)
 {
     LoongArchTLB *tlb = &env->tlb[index];
-    uint64_t plv = mmu_idx;
-    uint64_t tlb_entry, tlb_ppn;
-    uint8_t tlb_ps, n, tlb_v, tlb_d, tlb_plv, tlb_nx, tlb_nr, tlb_rplv;
+    uint64_t tlb_entry;
+    uint8_t tlb_ps, n;
+    mmu_context context;
 
     tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
     n = (address >> tlb_ps) & 0x1;/* Odd or even */
 
     tlb_entry = n ? tlb->tlb_entry1 : tlb->tlb_entry0;
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
-    tlb_ppn = tlb_ppn & ~(((0x1UL << (tlb_ps - 12)) - 1));
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
+    context.vaddr = address;
+    context.ps = tlb_ps;
+    context.pte  = tlb_entry;
+    return loongarch_check_pte(env, physical, prot, &context, access_type,
+                               mmu_idx);
 }
 
 int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
-- 
2.39.3


