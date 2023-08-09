Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1707B775582
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 10:35:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTedR-0003mh-If; Wed, 09 Aug 2023 04:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTedQ-0003jg-Hr
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:33:40 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTedN-0001nR-KD
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:33:39 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id F02AB43ED8;
 Wed,  9 Aug 2023 08:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691570016; bh=D0tFlHhfDfHzSlED2T9/gfSBR77fvD3kbkn6hF60yYo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JisWbAhoEQ78mLD/ri7muEe4KcfKiDA6I8RZtifOvNo1MR88vdWFEUjBpjGT+UEOs
 ig95JYbM9aYt2hKNVNkkWR5/zxP4X2/lR63f21/sIqWLKFGin215EpJY9+uiH7FTIk
 bqPz6AvzbT0I4o1aJbTPqZgJDxFaVUExhUkZuHJ4=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn,
 gaosong@loongson.cn, i.qemu@xen0n.name, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
Subject: [PATCH v5 06/11] target/loongarch: Support LoongArch32 VPPN
Date: Wed,  9 Aug 2023 16:26:34 +0800
Message-ID: <20230809083258.1787464-7-c@jia.je>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809083258.1787464-1-c@jia.je>
References: <20230809083258.1787464-1-c@jia.je>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

VPPN of TLBEHI/TLBREHI is limited to 19 bits in LA32.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/cpu-csr.h    |  6 ++++--
 target/loongarch/tlb_helper.c | 23 ++++++++++++++++++-----
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index b93f99a9ef..c59d7a9fcb 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -57,7 +57,8 @@ FIELD(CSR_TLBIDX, PS, 24, 6)
 FIELD(CSR_TLBIDX, NE, 31, 1)
 
 #define LOONGARCH_CSR_TLBEHI         0x11 /* TLB EntryHi */
-FIELD(CSR_TLBEHI, VPPN, 13, 35)
+FIELD(CSR_TLBEHI_32, VPPN, 13, 19)
+FIELD(CSR_TLBEHI_64, VPPN, 13, 35)
 
 #define LOONGARCH_CSR_TLBELO0        0x12 /* TLB EntryLo0 */
 #define LOONGARCH_CSR_TLBELO1        0x13 /* TLB EntryLo1 */
@@ -164,7 +165,8 @@ FIELD(CSR_TLBRERA, PC, 2, 62)
 #define LOONGARCH_CSR_TLBRELO1       0x8d /* TLB refill entrylo1 */
 #define LOONGARCH_CSR_TLBREHI        0x8e /* TLB refill entryhi */
 FIELD(CSR_TLBREHI, PS, 0, 6)
-FIELD(CSR_TLBREHI, VPPN, 13, 35)
+FIELD(CSR_TLBREHI_32, VPPN, 13, 19)
+FIELD(CSR_TLBREHI_64, VPPN, 13, 35)
 #define LOONGARCH_CSR_TLBRPRMD       0x8f /* TLB refill mode info */
 FIELD(CSR_TLBRPRMD, PPLV, 0, 2)
 FIELD(CSR_TLBRPRMD, PIE, 2, 1)
diff --git a/target/loongarch/tlb_helper.c b/target/loongarch/tlb_helper.c
index 1f8e7911c7..c8b8b0497f 100644
--- a/target/loongarch/tlb_helper.c
+++ b/target/loongarch/tlb_helper.c
@@ -300,8 +300,13 @@ static void raise_mmu_exception(CPULoongArchState *env, target_ulong address,
 
     if (tlb_error == TLBRET_NOMATCH) {
         env->CSR_TLBRBADV = address;
-        env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI, VPPN,
-                                      extract64(address, 13, 35));
+        if (is_la64(env)) {
+            env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI_64,
+                                        VPPN, extract64(address, 13, 35));
+        } else {
+            env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI_32,
+                                        VPPN, extract64(address, 13, 19));
+        }
     } else {
         if (!FIELD_EX64(env->CSR_DBG, CSR_DBG, DST)) {
             env->CSR_BADV = address;
@@ -366,12 +371,20 @@ static void fill_tlb_entry(CPULoongArchState *env, int index)
 
     if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
         csr_ps = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
-        csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, VPPN);
+        if (is_la64(env)) {
+            csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_64, VPPN);
+        } else {
+            csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_32, VPPN);
+        }
         lo0 = env->CSR_TLBRELO0;
         lo1 = env->CSR_TLBRELO1;
     } else {
         csr_ps = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
-        csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI, VPPN);
+        if (is_la64(env)) {
+            csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_64, VPPN);
+        } else {
+            csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_32, VPPN);
+        }
         lo0 = env->CSR_TLBELO0;
         lo1 = env->CSR_TLBELO1;
     }
@@ -491,7 +504,7 @@ void helper_tlbfill(CPULoongArchState *env)
 
     if (pagesize == stlb_ps) {
         /* Only write into STLB bits [47:13] */
-        address = entryhi & ~MAKE_64BIT_MASK(0, R_CSR_TLBEHI_VPPN_SHIFT);
+        address = entryhi & ~MAKE_64BIT_MASK(0, R_CSR_TLBEHI_64_VPPN_SHIFT);
 
         /* Choose one set ramdomly */
         set = get_random_tlb(0, 7);
-- 
2.41.0


