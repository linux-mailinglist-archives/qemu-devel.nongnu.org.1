Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 113D7B3CB9D
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Aug 2025 17:02:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN3e-0001ns-Ei; Sat, 30 Aug 2025 10:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1urpHA-0008QB-Bf
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 22:55:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1urpH6-0007Ap-M4
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 22:55:40 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxmdGYFrFovG4EAA--.9127S3;
 Fri, 29 Aug 2025 10:55:20 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDxbMGMFrFoKstvAA--.33085S15;
 Fri, 29 Aug 2025 10:55:20 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/14] target/loongarch: Use MMUContext in
 get_physical_address()
Date: Fri, 29 Aug 2025 10:55:06 +0800
Message-Id: <20250829025507.2315073-14-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250829025507.2315073-1-maobibo@loongson.cn>
References: <20250829025507.2315073-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxbMGMFrFoKstvAA--.33085S15
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

With function get_physical_address(), parameter MMUContext is added
and remove parameter address, prot and address.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/cpu-mmu.h        |  3 +--
 target/loongarch/cpu_helper.c     | 32 ++++++++++++-------------------
 target/loongarch/tcg/tlb_helper.c |  8 +++++---
 3 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index be3d11d3c1..0068d22efc 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -30,8 +30,7 @@ typedef struct MMUContext {
 bool check_ps(CPULoongArchState *ent, uint8_t ps);
 TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
                            MMUAccessType access_type, int mmu_idx);
-TLBRet get_physical_address(CPULoongArchState *env, hwaddr *physical,
-                            int *prot, vaddr address,
+TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
                             MMUAccessType access_type, int mmu_idx,
                             int is_debug);
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 225382f70e..4a9db3ea4c 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -200,8 +200,7 @@ static hwaddr dmw_va2pa(CPULoongArchState *env, vaddr va, target_ulong dmw)
     }
 }
 
-TLBRet get_physical_address(CPULoongArchState *env, hwaddr *physical,
-                            int *prot, vaddr address,
+TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
                             MMUAccessType access_type, int mmu_idx,
                             int is_debug)
 {
@@ -211,13 +210,13 @@ TLBRet get_physical_address(CPULoongArchState *env, hwaddr *physical,
     int64_t addr_high;
     uint8_t da = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, DA);
     uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
-    MMUContext context;
-    TLBRet ret;
+    vaddr address;
 
     /* Check PG and DA */
+    address = context->addr;
     if (da & !pg) {
-        *physical = address & TARGET_PHYS_MASK;
-        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        context->physical = address & TARGET_PHYS_MASK;
+        context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         return TLBRET_MATCH;
     }
 
@@ -235,8 +234,8 @@ TLBRet get_physical_address(CPULoongArchState *env, hwaddr *physical,
             base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW_32, VSEG);
         }
         if ((plv & env->CSR_DMW[i]) && (base_c == base_v)) {
-            *physical = dmw_va2pa(env, address, env->CSR_DMW[i]);
-            *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+            context->physical = dmw_va2pa(env, address, env->CSR_DMW[i]);
+            context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
             return TLBRET_MATCH;
         }
     }
@@ -248,25 +247,18 @@ TLBRet get_physical_address(CPULoongArchState *env, hwaddr *physical,
     }
 
     /* Mapped address */
-    context.addr = address;
-    ret = loongarch_map_address(env, &context,
-                                access_type, mmu_idx, is_debug);
-    if (ret == TLBRET_MATCH) {
-        *physical = context.physical;
-        *prot = context.prot;
-    }
-    return ret;
+    return loongarch_map_address(env, context, access_type, mmu_idx, is_debug);
 }
 
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     CPULoongArchState *env = cpu_env(cs);
-    hwaddr phys_addr;
-    int prot;
+    MMUContext context;
 
-    if (get_physical_address(env, &phys_addr, &prot, addr, MMU_DATA_LOAD,
+    context.addr = addr;
+    if (get_physical_address(env, &context, MMU_DATA_LOAD,
                              cpu_mmu_index(cs, false), 1) != TLBRET_MATCH) {
         return -1;
     }
-    return phys_addr;
+    return context.physical;
 }
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 64a4e82dec..7d3f98633d 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -517,13 +517,15 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     CPULoongArchState *env = cpu_env(cs);
     hwaddr physical;
     int prot;
+    MMUContext context;
     TLBRet ret;
 
     /* Data access */
-    ret = get_physical_address(env, &physical, &prot, address,
-                               access_type, mmu_idx, 0);
-
+    context.addr = address;
+    ret = get_physical_address(env, &context, access_type, mmu_idx, 0);
     if (ret == TLBRET_MATCH) {
+        physical = context.physical;
+        prot = context.prot;
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
                      physical & TARGET_PAGE_MASK, prot,
                      mmu_idx, TARGET_PAGE_SIZE);
-- 
2.43.5


