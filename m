Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE0FB25DAA
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Aug 2025 09:39:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umSW2-0006we-Uc; Thu, 14 Aug 2025 03:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1umSVt-0006uG-Fs
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 03:36:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1umSVm-0004RE-B1
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 03:36:39 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxaeH5kZ1oBas_AQ--.12282S3;
 Thu, 14 Aug 2025 15:36:25 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxM+T4kZ1oM9xKAA--.22944S6;
 Thu, 14 Aug 2025 15:36:25 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 4/9] target/loongarch: Add function sptw_prepare_tlb before
 adding tlb entry
Date: Thu, 14 Aug 2025 15:36:19 +0800
Message-Id: <20250814073624.430928-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250814073624.430928-1-maobibo@loongson.cn>
References: <20250814073624.430928-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxM+T4kZ1oM9xKAA--.22944S6
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

With software page table walker, tlb entry comes from CSR registers.
however with hardware page table walker, tlb entry comes from page
table entry information directly, TLB CSR registers are not necessary.

Here add function sptw_prepare_context(), get tlb entry information
from TLB CSR registers.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu-mmu.h        |  1 +
 target/loongarch/tcg/tlb_helper.c | 37 ++++++++++++++++++++-----------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index e4f3199f44..c3e869234a 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -27,6 +27,7 @@ typedef struct MMUContext {
     int           prot;
     int           tlb_index;
     int           mmu_index;
+    uint64_t      pte_buddy[2];
 } MMUContext;
 
 static inline bool cpu_has_ptw(CPULoongArchState *env)
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 10c01ead3f..fa216b92fd 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -174,42 +174,53 @@ static void invalidate_tlb(CPULoongArchState *env, int index)
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
 }
 
-static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb)
+/* Prepare tlb entry information in software PTW mode */
+static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context)
 {
-    uint64_t lo0, lo1, csr_vppn;
-    uint16_t csr_asid;
-    uint8_t csr_ps;
+    uint64_t csr_vppn;
 
     if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
-        csr_ps = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
+        context->ps = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
         if (is_la64(env)) {
             csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_64, VPPN);
         } else {
             csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_32, VPPN);
         }
-        lo0 = env->CSR_TLBRELO0;
-        lo1 = env->CSR_TLBRELO1;
+        context->pte_buddy[0] = env->CSR_TLBRELO0;
+        context->pte_buddy[1] = env->CSR_TLBRELO1;
     } else {
-        csr_ps = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
+        context->ps = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
         if (is_la64(env)) {
             csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_64, VPPN);
         } else {
             csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_32, VPPN);
         }
-        lo0 = env->CSR_TLBELO0;
-        lo1 = env->CSR_TLBELO1;
+        context->pte_buddy[0] = env->CSR_TLBELO0;
+        context->pte_buddy[1] = env->CSR_TLBELO1;
     }
 
+    context->addr  = csr_vppn << R_TLB_MISC_VPPN_SHIFT;
+}
+
+static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb)
+{
+    uint64_t csr_vppn;
+    uint16_t csr_asid;
+    MMUContext context;
+
+    sptw_prepare_context(env, &context);
+    csr_vppn = context.addr >> R_TLB_MISC_VPPN_SHIFT;
+
     /* Store page size in field PS */
     tlb->tlb_misc = 0;
-    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, csr_ps);
+    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, context.ps);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, VPPN, csr_vppn);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 1);
     csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, ASID, csr_asid);
 
-    tlb->tlb_entry0 = lo0;
-    tlb->tlb_entry1 = lo1;
+    tlb->tlb_entry0 = context.pte_buddy[0];
+    tlb->tlb_entry1 = context.pte_buddy[1];
 }
 
 /* Return an random value between low and high */
-- 
2.39.3


