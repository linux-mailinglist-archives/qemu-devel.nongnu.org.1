Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6B7BE1322
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Oct 2025 03:52:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9D96-0002Xd-Gg; Wed, 15 Oct 2025 21:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v9D8j-0002U2-Gz
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 21:50:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v9D8h-0001UT-Bb
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 21:50:49 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Cxf9NoT_BoqrEWAA--.48348S3;
 Thu, 16 Oct 2025 09:50:32 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxH8JjT_BoAY3oAA--.64734S14;
 Thu, 16 Oct 2025 09:50:32 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v5 12/14] target/loongarch: Add basic hardware PTW support
Date: Thu, 16 Oct 2025 09:50:25 +0800
Message-Id: <20251016015027.1695116-13-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251016015027.1695116-1-maobibo@loongson.cn>
References: <20251016015027.1695116-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxH8JjT_BoAY3oAA--.64734S14
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

However with hardware PTW supported, hardware will search page table
with TLB miss. Also if there is no TLB miss however bit Present is not set,
hardware PTW will happen also. Because there is odd/even page in one TLB
entry on LoongArch system, for example in the first time odd TLB entry is
valid and even TLB entry is 0. When software accesses with address within
even page, there is no TLB miss only that TLB entry is 0. In this
condition, hardwre PTW will happen also.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu-mmu.h        |  2 ++
 target/loongarch/cpu_helper.c     | 17 ++++++++++++++---
 target/loongarch/tcg/tlb_helper.c | 25 +++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index c3e869234a..4c227d4ef3 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -67,6 +67,8 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
 TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
                             MMUAccessType access_type, int mmu_idx,
                             int is_debug);
+TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
+                     int access_type, int mmu_idx, int debug);
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
                                uint64_t *dir_width, target_ulong level);
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index e2d66f4c86..3fd0f574b4 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -107,11 +107,11 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
     return TLBRET_MATCH;
 }
 
-static TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
-                            int access_type, int mmu_idx, int debug)
+TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
+                     int access_type, int mmu_idx, int debug)
 {
     CPUState *cs = env_cpu(env);
-    target_ulong index, phys;
+    target_ulong index = 0, phys = 0;
     uint64_t dir_base, dir_width;
     uint64_t base;
     int level;
@@ -139,6 +139,8 @@ static TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
         if (level) {
             if (FIELD_EX64(base, TLBENTRY, HUGE)) {
                 /* base is a huge pte */
+                index = 0;
+                dir_base -= 1;
                 break;
             } else {
                 /* Discard high bits with page directory table */
@@ -156,6 +158,15 @@ static TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
             base = FIELD_DP64(base, TLBENTRY, HGLOBAL, 0);
             base = FIELD_DP64(base, TLBENTRY, G, 1);
         }
+
+        context->pte_buddy[index] = base;
+        context->pte_buddy[1 - index] = base + BIT_ULL(dir_base);
+        base += (BIT_ULL(dir_base) & address);
+    } else if (cpu_has_ptw(env)) {
+        index &= 1;
+        context->pte_buddy[index] = base;
+        context->pte_buddy[1 - index] = ldq_phys(cs->as,
+                                            phys + 8 * (1 - 2 * index));
     }
 
     context->ps = dir_base;
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 708d5576cb..4efa93110f 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -601,6 +601,18 @@ void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
     }
 }
 
+static void ptw_update_tlb(CPULoongArchState *env, MMUContext *context)
+{
+    int index;
+
+    index = context->tlb_index;
+    if (index < 0) {
+        index = get_tlb_random_index(env, context->addr, context->ps);
+    }
+
+    update_tlb_index(env, context, index);
+}
+
 bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                             MMUAccessType access_type, int mmu_idx,
                             bool probe, uintptr_t retaddr)
@@ -613,7 +625,20 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
     /* Data access */
     context.addr = address;
+    context.tlb_index = -1;
     ret = get_physical_address(env, &context, access_type, mmu_idx, 0);
+    if (ret != TLBRET_MATCH && cpu_has_ptw(env)) {
+        /* Take HW PTW if TLB missed or bit P is zero */
+        if (ret == TLBRET_NOMATCH || ret == TLBRET_INVALID) {
+            ret = loongarch_ptw(env, &context, access_type, mmu_idx, 0);
+            if (ret == TLBRET_MATCH) {
+                ptw_update_tlb(env, &context);
+            }
+        } else if (context.tlb_index >= 0) {
+            invalidate_tlb(env, context.tlb_index);
+        }
+    }
+
     if (ret == TLBRET_MATCH) {
         physical = context.physical;
         prot = context.prot;
-- 
2.39.3


