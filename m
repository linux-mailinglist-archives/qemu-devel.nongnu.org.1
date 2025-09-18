Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFA5B3CB95
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Aug 2025 17:00:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN3Z-0001ge-RS; Sat, 30 Aug 2025 10:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1urpGx-0008MV-HG
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 22:55:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1urpGr-000798-Fj
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 22:55:26 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxSNGVFrFoqm4EAA--.9038S3;
 Fri, 29 Aug 2025 10:55:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDxbMGMFrFoKstvAA--.33085S7;
 Fri, 29 Aug 2025 10:55:17 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/14] target/loongarch: Add enum type TLBRet definition
Date: Fri, 29 Aug 2025 10:54:58 +0800
Message-Id: <20250829025507.2315073-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250829025507.2315073-1-maobibo@loongson.cn>
References: <20250829025507.2315073-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxbMGMFrFoKstvAA--.33085S7
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

There is mixed usage between enum variable TLBRET_xxx and int type,
here add enum type TLBRet definition and replace int type variable
with enum type TLBRet in some functions.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/cpu-mmu.h           | 27 ++++++++++++++-------------
 target/loongarch/cpu_helper.c        | 26 ++++++++++++++------------
 target/loongarch/tcg/tcg_loongarch.h |  7 ++++---
 target/loongarch/tcg/tlb_helper.c    | 16 ++++++++--------
 4 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 4c5cbd7425..cbe6f37773 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -8,21 +8,22 @@
 #ifndef LOONGARCH_CPU_MMU_H
 #define LOONGARCH_CPU_MMU_H
 
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
+typedef enum TLBRet {
+    TLBRET_MATCH,
+    TLBRET_BADADDR,
+    TLBRET_NOMATCH,
+    TLBRET_INVALID,
+    TLBRET_DIRTY,
+    TLBRET_RI,
+    TLBRET_XI,
+    TLBRET_PE,
+} TLBRet;
 
 bool check_ps(CPULoongArchState *ent, uint8_t ps);
-int get_physical_address(CPULoongArchState *env, hwaddr *physical,
-                         int *prot, target_ulong address,
-                         MMUAccessType access_type, int mmu_idx, int is_debug);
+TLBRet get_physical_address(CPULoongArchState *env, hwaddr *physical,
+                            int *prot, target_ulong address,
+                            MMUAccessType access_type, int mmu_idx,
+                            int is_debug);
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
                                uint64_t *dir_width, target_ulong level);
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 418122f447..17a0735f5c 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -44,8 +44,9 @@ void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
     }
 }
 
-static int loongarch_page_table_walker(CPULoongArchState *env, hwaddr *physical,
-                                 int *prot, target_ulong address)
+static TLBRet loongarch_page_table_walker(CPULoongArchState *env,
+                                          hwaddr *physical,
+                                          int *prot, target_ulong address)
 {
     CPUState *cs = env_cpu(env);
     target_ulong index, phys;
@@ -116,15 +117,15 @@ static int loongarch_page_table_walker(CPULoongArchState *env, hwaddr *physical,
     /* mask other attribute bits */
     *physical = base & TARGET_PAGE_MASK;
 
-    return 0;
+    return TLBRET_MATCH;
 }
 
-static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
-                                 int *prot, target_ulong address,
-                                 MMUAccessType access_type, int mmu_idx,
-                                 int is_debug)
+static TLBRet loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
+                                    int *prot, target_ulong address,
+                                    MMUAccessType access_type, int mmu_idx,
+                                    int is_debug)
 {
-    int ret;
+    TLBRet ret;
 
     if (tcg_enabled()) {
         ret = loongarch_get_addr_from_tlb(env, physical, prot, address,
@@ -158,9 +159,10 @@ static hwaddr dmw_va2pa(CPULoongArchState *env, target_ulong va,
     }
 }
 
-int get_physical_address(CPULoongArchState *env, hwaddr *physical,
-                         int *prot, target_ulong address,
-                         MMUAccessType access_type, int mmu_idx, int is_debug)
+TLBRet get_physical_address(CPULoongArchState *env, hwaddr *physical,
+                            int *prot, target_ulong address,
+                            MMUAccessType access_type, int mmu_idx,
+                            int is_debug)
 {
     int user_mode = mmu_idx == MMU_USER_IDX;
     int kernel_mode = mmu_idx == MMU_KERNEL_IDX;
@@ -214,7 +216,7 @@ hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int prot;
 
     if (get_physical_address(env, &phys_addr, &prot, addr, MMU_DATA_LOAD,
-                             cpu_mmu_index(cs, false), 1) != 0) {
+                             cpu_mmu_index(cs, false), 1) != TLBRET_MATCH) {
         return -1;
     }
     return phys_addr;
diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
index fd4e116022..488700c3c3 100644
--- a/target/loongarch/tcg/tcg_loongarch.h
+++ b/target/loongarch/tcg/tcg_loongarch.h
@@ -7,6 +7,7 @@
 #ifndef TARGET_LOONGARCH_TCG_LOONGARCH_H
 #define TARGET_LOONGARCH_TCG_LOONGARCH_H
 #include "cpu.h"
+#include "cpu-mmu.h"
 
 void loongarch_csr_translate_init(void);
 
@@ -14,8 +15,8 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                             MMUAccessType access_type, int mmu_idx,
                             bool probe, uintptr_t retaddr);
 
-int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
-                                int *prot, target_ulong address,
-                                MMUAccessType access_type, int mmu_idx);
+TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
+                                   int *prot, target_ulong address,
+                                   MMUAccessType access_type, int mmu_idx);
 
 #endif  /* TARGET_LOONGARCH_TCG_LOONGARCH_H */
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 1f49619e7f..4a2a565985 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -30,7 +30,7 @@ bool check_ps(CPULoongArchState *env, uint8_t tlb_ps)
 }
 
 static void raise_mmu_exception(CPULoongArchState *env, target_ulong address,
-                                MMUAccessType access_type, int tlb_error)
+                                MMUAccessType access_type, TLBRet tlb_error)
 {
     CPUState *cs = env_cpu(env);
 
@@ -517,7 +517,7 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     CPULoongArchState *env = cpu_env(cs);
     hwaddr physical;
     int prot;
-    int ret;
+    TLBRet ret;
 
     /* Data access */
     ret = get_physical_address(env, &physical, &prot, address,
@@ -648,9 +648,9 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
     env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI, PS, ps);
 }
 
-static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
-                                   int *prot, target_ulong address,
-                                   int access_type, int index, int mmu_idx)
+static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
+                                      int *prot, target_ulong address,
+                                      int access_type, int index, int mmu_idx)
 {
     LoongArchTLB *tlb = &env->tlb[index];
     uint64_t plv = mmu_idx;
@@ -713,9 +713,9 @@ static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
     return TLBRET_MATCH;
 }
 
-int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
-                                int *prot, target_ulong address,
-                                MMUAccessType access_type, int mmu_idx)
+TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
+                                   int *prot, target_ulong address,
+                                   MMUAccessType access_type, int mmu_idx)
 {
     int index, match;
 
-- 
2.43.5


