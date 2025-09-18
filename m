Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8452B157AD
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Jul 2025 05:03:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugx5J-0004HL-6c; Tue, 29 Jul 2025 23:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ugx5A-0003vY-Pw
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 23:02:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ugx58-0007IN-F1
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 23:02:20 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Ax3eI4i4lo+ro0AQ--.1864S3;
 Wed, 30 Jul 2025 11:02:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJAxE+Qri4loJ_AsAA--.30108S12;
 Wed, 30 Jul 2025 11:02:15 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 10/19] target/loongarch: Use MMUConext in
 loongarch_map_tlb_entry()
Date: Wed, 30 Jul 2025 11:01:53 +0800
Message-Id: <20250730030202.3425934-11-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250730030202.3425934-1-maobibo@loongson.cn>
References: <20250730030202.3425934-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxE+Qri4loJ_AsAA--.30108S12
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

With function loongarch_map_tlb_entry(), parameter MMUConext is added
and remove parameter physical, prot and address.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 33 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 10322da62e..703ab9c8ca 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -648,28 +648,19 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
     env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI, PS, ps);
 }
 
-static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
-                                      int *prot, vaddr address,
+static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env,
+                                      MMUContext *context,
                                       MMUAccessType access_type, int index,
                                       int mmu_idx)
 {
     LoongArchTLB *tlb = &env->tlb[index];
     uint8_t tlb_ps, n;
-    MMUContext context;
-    TLBRet ret;
 
     tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
-    n = (address >> tlb_ps) & 0x1;/* Odd or even */
-    context.pte = n ? tlb->tlb_entry1 : tlb->tlb_entry0;
-    context.addr = address;
-    context.ps = tlb_ps;
-    ret = loongarch_check_pte(env, &context, access_type, mmu_idx);
-    if (ret == TLBRET_MATCH) {
-        *physical = context.physical;
-        *prot = context.prot;
-     }
-
-    return ret;
+    n = (context->addr >> tlb_ps) & 0x1;/* Odd or even */
+    context->pte = n ? tlb->tlb_entry1 : tlb->tlb_entry0;
+    context->ps = tlb_ps;
+    return loongarch_check_pte(env, context, access_type, mmu_idx);
 }
 
 TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
@@ -677,11 +668,19 @@ TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
                                    MMUAccessType access_type, int mmu_idx)
 {
     int index, match;
+    MMUContext context;
+    TLBRet ret;
 
+    context.addr = address;
     match = loongarch_tlb_search(env, address, &index);
     if (match) {
-        return loongarch_map_tlb_entry(env, physical, prot,
-                                       address, access_type, index, mmu_idx);
+        ret = loongarch_map_tlb_entry(env, &context, access_type, index,
+                                      mmu_idx);
+        if (ret == TLBRET_MATCH) {
+            *physical = context.physical;
+            *prot = context.prot;
+        }
+        return ret;
     }
 
     return TLBRET_NOMATCH;
-- 
2.39.3


