Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B34793EACF
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Jul 2024 03:58:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYFdf-0004vY-Sx; Sun, 28 Jul 2024 21:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sYFdX-0004qu-BR
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 21:57:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sYFdS-0002Tz-Qe
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 21:57:18 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxHuvz9qZmhlQDAA--.11791S3;
 Mon, 29 Jul 2024 09:57:07 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBx4MXu9qZm1AIEAA--.19410S6;
 Mon, 29 Jul 2024 09:57:07 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn,
	philmd@linaro.org
Subject: [PATCH 4/5] target/loongarch: Add get_random_tlb_index()
Date: Mon, 29 Jul 2024 09:39:38 +0800
Message-Id: <20240729013939.1807982-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240729013939.1807982-1-gaosong@loongson.cn>
References: <20240729013939.1807982-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBx4MXu9qZm1AIEAA--.19410S6
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

get_random_tlb_index() is used to get a random tlb index.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 34 +++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index bc6d708484..463e9be7f2 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -291,19 +291,12 @@ void helper_tlbwr(CPULoongArchState *env)
     fill_tlb_entry(env, index);
 }
 
-void helper_tlbfill(CPULoongArchState *env)
+static int get_random_tlb_index(CPULoongArchState *env,
+                                uint64_t entryhi, uint16_t pagesize)
 {
-    uint64_t address, entryhi;
+    uint64_t address;
+    uint16_t stlb_ps;
     int index, set, stlb_idx;
-    uint16_t pagesize, stlb_ps;
-
-    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
-        entryhi = env->CSR_TLBREHI;
-        pagesize = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
-    } else {
-        entryhi = env->CSR_TLBEHI;
-        pagesize = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
-    }
 
     stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
 
@@ -323,6 +316,25 @@ void helper_tlbfill(CPULoongArchState *env)
         index = get_random_tlb(LOONGARCH_STLB, LOONGARCH_TLB_MAX - 1);
     }
 
+    return index;
+}
+
+void helper_tlbfill(CPULoongArchState *env)
+{
+    uint64_t entryhi;
+    uint16_t pagesize;
+    int index;
+
+    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
+        entryhi = env->CSR_TLBREHI;
+        pagesize = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
+    } else {
+        entryhi = env->CSR_TLBEHI;
+        pagesize = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
+    }
+
+    index = get_random_tlb_index(env, entryhi, pagesize);
+
     invalidate_tlb(env, index);
     fill_tlb_entry(env, index);
 }
-- 
2.33.0


