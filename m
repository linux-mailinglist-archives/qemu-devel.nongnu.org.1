Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0B6B115F5
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Jul 2025 03:41:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf7Pm-0002Ik-AT; Thu, 24 Jul 2025 21:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uf7Nf-0000hJ-Pz
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:37:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uf7Nc-0002Z8-BY
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:37:51 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxQK_l34Jog5AxAQ--.65435S3;
 Fri, 25 Jul 2025 09:37:41 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxdOTk34Joz5wlAA--.62171S5;
 Fri, 25 Jul 2025 09:37:41 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 03/17] target/loongarch: Set page size in TLB misc with STLB
Date: Fri, 25 Jul 2025 09:37:25 +0800
Message-Id: <20250725013739.994437-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250725013739.994437-1-maobibo@loongson.cn>
References: <20250725013739.994437-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxdOTk34Joz5wlAA--.62171S5
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

With VTLB different TLB entry may have different page size, and
page size is set in PS field of TLB misc. However with STLB, all the
TLB entries have the same page size, page size comes from register
CSR_STLBPS, PS field of TLB misc is not used.

Here PS field of TLB misc is used with all TLB entries, even with
STLB, it is convenient with TLB maintainance operation.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 41 ++++++++-----------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 8872593ff0..3ea0e153b1 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -110,11 +110,8 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
     if (!tlb_e) {
         return;
     }
-    if (index >= LOONGARCH_STLB) {
-        tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
-    } else {
-        tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
-    }
+
+    tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
     pagesize = MAKE_64BIT_MASK(tlb_ps, 1);
     mask = MAKE_64BIT_MASK(0, tlb_ps + 1);
 
@@ -173,11 +170,8 @@ static void fill_tlb_entry(CPULoongArchState *env, int index)
         lo1 = env->CSR_TLBELO1;
     }
 
-    /* Only MTLB has the ps fields */
-    if (index >= LOONGARCH_STLB) {
-        tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, csr_ps);
-    }
-
+    /* Store page size in field PS */
+    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, csr_ps);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, VPPN, csr_vppn);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 1);
     csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
@@ -283,12 +277,7 @@ void helper_tlbrd(CPULoongArchState *env)
 
     index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
     tlb = &env->tlb[index];
-
-    if (index >= LOONGARCH_STLB) {
-        tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
-    } else {
-        tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
-    }
+    tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
     tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
 
     if (!tlb_e) {
@@ -476,11 +465,8 @@ void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
         if (!tlb_e) {
             continue;
         }
-        if (i >= LOONGARCH_STLB) {
-            tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
-        } else {
-            tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
-        }
+
+        tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
         tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
         vpn = (addr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
         compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
@@ -509,11 +495,8 @@ void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
         if (!tlb_e) {
             continue;
         }
-        if (i >= LOONGARCH_STLB) {
-            tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
-        } else {
-            tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
-        }
+
+        tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
         tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
         vpn = (addr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
         compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
@@ -673,11 +656,7 @@ static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
     uint64_t tlb_entry, tlb_ppn;
     uint8_t tlb_ps, n, tlb_v, tlb_d, tlb_plv, tlb_nx, tlb_nr, tlb_rplv;
 
-    if (index >= LOONGARCH_STLB) {
-        tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
-    } else {
-        tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
-    }
+    tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
     n = (address >> tlb_ps) & 0x1;/* Odd or even */
 
     tlb_entry = n ? tlb->tlb_entry1 : tlb->tlb_entry0;
-- 
2.39.3


