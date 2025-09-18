Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 930E4B469C4
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Sep 2025 09:06:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uumyz-0001R3-Ho; Sat, 06 Sep 2025 03:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uumyq-0001Ia-QE
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 03:05:02 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uumyg-0003LU-4l
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 03:04:59 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bxnr8N3btoqVgHAA--.14504S3;
 Sat, 06 Sep 2025 15:04:45 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDx_8MJ3btoC6OBAA--.17248S6;
 Sat, 06 Sep 2025 15:04:45 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 04/13] target/loongarch: Update TLB index selection method
Date: Sat,  6 Sep 2025 15:04:32 +0800
Message-Id: <20250906070441.3749413-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250906070441.3749413-1-maobibo@loongson.cn>
References: <20250906070441.3749413-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDx_8MJ3btoC6OBAA--.17248S6
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

With function helper_tlbfill(), since there is no suitable TLB entry,
new TLB will be added and flush one old TLB entry. The old TLB entry
index is selected randomly now, instead it can be optimized as
following:
  1. invalid TLB entry can be selected at first.
  2. TLB entry with other ASID can be selected secondly
  3. random method is used by last.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/tcg/tlb_helper.c | 49 ++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 88dba9eb3e..b46621f203 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -336,8 +336,11 @@ void helper_tlbwr(CPULoongArchState *env)
 void helper_tlbfill(CPULoongArchState *env)
 {
     uint64_t address, entryhi;
-    int index, set, stlb_idx;
+    int index, set, i, stlb_idx;
     uint16_t pagesize, stlb_ps;
+    uint16_t asid, tlb_asid;
+    LoongArchTLB *tlb;
+    uint8_t tlb_e;
 
     if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
         entryhi = env->CSR_TLBREHI;
@@ -351,20 +354,52 @@ void helper_tlbfill(CPULoongArchState *env)
 
     /* Validity of stlb_ps is checked in helper_csrwr_stlbps() */
     stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
+    asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
     if (pagesize == stlb_ps) {
         /* Only write into STLB bits [47:13] */
         address = entryhi & ~MAKE_64BIT_MASK(0, R_CSR_TLBEHI_64_VPPN_SHIFT);
-
-        /* Choose one set ramdomly */
-        set = get_random_tlb(0, 7);
-
-        /* Index in one set */
+        set = -1;
         stlb_idx = (address >> (stlb_ps + 1)) & 0xff; /* [0,255] */
+        for (i = 0; i < 8; ++i) {
+            tlb = &env->tlb[i * 256 + stlb_idx];
+            tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
+            if (!tlb_e) {
+                set = i;
+                break;
+            }
+
+            tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
+            if (asid != tlb_asid) {
+                set = i;
+            }
+        }
 
+        /* Choose one set randomly */
+        if (set < 0) {
+            set = get_random_tlb(0, 7);
+        }
         index = set * 256 + stlb_idx;
     } else {
         /* Only write into MTLB */
-        index = get_random_tlb(LOONGARCH_STLB, LOONGARCH_TLB_MAX - 1);
+        index = -1;
+        for (i = LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; i++) {
+            tlb = &env->tlb[i];
+            tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
+
+            if (!tlb_e) {
+                index = i;
+                break;
+            }
+
+            tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
+            if (asid != tlb_asid) {
+                index = i;
+            }
+        }
+
+        if (index < 0) {
+            index = get_random_tlb(LOONGARCH_STLB, LOONGARCH_TLB_MAX - 1);
+        }
     }
 
     invalidate_tlb(env, index);
-- 
2.39.3


