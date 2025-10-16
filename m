Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F64BE1330
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Oct 2025 03:52:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9D8g-0002T0-HI; Wed, 15 Oct 2025 21:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v9D8b-0002Rk-4m
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 21:50:41 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v9D8W-0001Tf-Sm
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 21:50:39 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dxfb9mT_BolbEWAA--.47011S3;
 Thu, 16 Oct 2025 09:50:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxH8JjT_BoAY3oAA--.64734S7;
 Thu, 16 Oct 2025 09:50:30 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v5 05/14] target/loongarch: target/loongarch: Add common
 function get_tlb_random_index()
Date: Thu, 16 Oct 2025 09:50:18 +0800
Message-Id: <20251016015027.1695116-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251016015027.1695116-1-maobibo@loongson.cn>
References: <20251016015027.1695116-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxH8JjT_BoAY3oAA--.64734S7
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

With software PTW system, tlb index is calculated randomly when new
TLB entry is added. For hardware PTW, it is the same logic to add
new TLB entry.

Here common function get_tlb_random_index() is added to get random
tlb index when adding new TLB entry.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 39 +++++++++++++++++++------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 3ad3b2ccd5..ef2089efb5 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -383,31 +383,21 @@ void helper_tlbwr(CPULoongArchState *env)
     *old = new;
 }
 
-void helper_tlbfill(CPULoongArchState *env)
+static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
+                                int pagesize)
 {
-    uint64_t address, entryhi;
+    uint64_t address;
     int index, set, i, stlb_idx;
-    uint16_t pagesize, stlb_ps;
-    uint16_t asid, tlb_asid;
+    uint16_t asid, tlb_asid, stlb_ps;
     LoongArchTLB *tlb;
     uint8_t tlb_e, tlb_g;
 
-    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
-        entryhi = env->CSR_TLBREHI;
-        /* Validity of pagesize is checked in helper_ldpte() */
-        pagesize = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
-    } else {
-        entryhi = env->CSR_TLBEHI;
-        /* Validity of pagesize is checked in helper_tlbrd() */
-        pagesize = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
-    }
-
     /* Validity of stlb_ps is checked in helper_csrwr_stlbps() */
     stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
     asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
     if (pagesize == stlb_ps) {
         /* Only write into STLB bits [47:13] */
-        address = entryhi & ~MAKE_64BIT_MASK(0, R_CSR_TLBEHI_64_VPPN_SHIFT);
+        address = addr & ~MAKE_64BIT_MASK(0, R_CSR_TLBEHI_64_VPPN_SHIFT);
         set = -1;
         stlb_idx = (address >> (stlb_ps + 1)) & 0xff; /* [0,255] */
         for (i = 0; i < 8; ++i) {
@@ -454,6 +444,25 @@ void helper_tlbfill(CPULoongArchState *env)
         }
     }
 
+    return index;
+}
+
+void helper_tlbfill(CPULoongArchState *env)
+{
+    vaddr entryhi;
+    int index, pagesize;
+
+    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
+        entryhi = env->CSR_TLBREHI;
+        /* Validity of pagesize is checked in helper_ldpte() */
+        pagesize = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
+    } else {
+        entryhi = env->CSR_TLBEHI;
+        /* Validity of pagesize is checked in helper_tlbrd() */
+        pagesize = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
+    }
+
+    index = get_tlb_random_index(env, entryhi, pagesize);
     invalidate_tlb(env, index);
     fill_tlb_entry(env, env->tlb + index);
 }
-- 
2.39.3


