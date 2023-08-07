Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7510D771D5B
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 11:47:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSwoU-0006zu-P1; Mon, 07 Aug 2023 05:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSwoF-0006yt-GO
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:45:55 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSwoC-0002vW-7K
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:45:53 -0400
Received: from develop.s.cslab.moe (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 31D6E43B9B;
 Mon,  7 Aug 2023 09:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691401551; bh=xZe46J1Wvo9JiWgG9djX20kdj0wbXvYyt688QvGW8I0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mzThe6NEQ+XS8oC/w1Z2EZfco1F4qFs/LXUHLCyMHmNDzUhfI0yWBj+CRoORdGKqu
 H21EPW+/wXgUJu0dc1vVLsOkPo9Q0eSErTq3R+rTAQ90a8tqgp/qbr2QsdtF+jhbxW
 EloLprg6+FVzLnhOFag4Hxsd1oJVhhXbYx+yqw+A=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn,
 Jiajie Chen <c@jia.je>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
Subject: [PATCH v3 5/6] target/loongarch: Support LoongArch32 DMW
Date: Mon,  7 Aug 2023 17:45:04 +0800
Message-Id: <20230807094505.2030603-6-c@jia.je>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807094505.2030603-1-c@jia.je>
References: <20230807094505.2030603-1-c@jia.je>
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

LA32 uses a different encoding for CSR.DMW and a new direct mapping
mechanism.

Signed-off-by: Jiajie Chen <c@jia.je>
---
 target/loongarch/cpu-csr.h    |  7 +++----
 target/loongarch/tlb_helper.c | 31 ++++++++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 48ed2e0632..b93f99a9ef 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -188,10 +188,9 @@ FIELD(CSR_DMW, PLV1, 1, 1)
 FIELD(CSR_DMW, PLV2, 2, 1)
 FIELD(CSR_DMW, PLV3, 3, 1)
 FIELD(CSR_DMW, MAT, 4, 2)
-FIELD(CSR_DMW, VSEG, 60, 4)
-
-#define dmw_va2pa(va) \
-    (va & MAKE_64BIT_MASK(0, TARGET_VIRT_ADDR_SPACE_BITS))
+FIELD(CSR_DMW_32, PSEG, 25, 3)
+FIELD(CSR_DMW_32, VSEG, 29, 3)
+FIELD(CSR_DMW_64, VSEG, 60, 4)
 
 /* Debug CSRs */
 #define LOONGARCH_CSR_DBG            0x500 /* debug config */
diff --git a/target/loongarch/tlb_helper.c b/target/loongarch/tlb_helper.c
index 690c6ef25f..cf6f5863f9 100644
--- a/target/loongarch/tlb_helper.c
+++ b/target/loongarch/tlb_helper.c
@@ -173,6 +173,18 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
     return TLBRET_NOMATCH;
 }
 
+static hwaddr dmw_va2pa(CPULoongArchState *env, target_ulong va,
+                        target_ulong dmw)
+{
+    if (env->mode == LA64) {
+        return va & TARGET_PHYS_MASK;
+    } else {
+        uint32_t pseg = FIELD_EX32(dmw, CSR_DMW_32, PSEG);
+        return (va & MAKE_64BIT_MASK(0, R_CSR_DMW_32_VSEG_SHIFT)) | \
+            (pseg << R_CSR_DMW_32_VSEG_SHIFT);
+    }
+}
+
 static int get_physical_address(CPULoongArchState *env, hwaddr *physical,
                                 int *prot, target_ulong address,
                                 MMUAccessType access_type, int mmu_idx)
@@ -184,6 +196,11 @@ static int get_physical_address(CPULoongArchState *env, hwaddr *physical,
     uint8_t da = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, DA);
     uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
 
+    /* Truncate high 32 bits for LA32 */
+    if (env->mode == LA32) {
+        address = (uint32_t)address;
+    }
+
     /* Check PG and DA */
     if (da & !pg) {
         *physical = address & TARGET_PHYS_MASK;
@@ -192,12 +209,20 @@ static int get_physical_address(CPULoongArchState *env, hwaddr *physical,
     }
 
     plv = kernel_mode | (user_mode << R_CSR_DMW_PLV3_SHIFT);
-    base_v = address >> R_CSR_DMW_VSEG_SHIFT;
+    if (env->mode == LA64) {
+        base_v = address >> R_CSR_DMW_64_VSEG_SHIFT;
+    } else {
+        base_v = address >> R_CSR_DMW_32_VSEG_SHIFT;
+    }
     /* Check direct map window */
     for (int i = 0; i < 4; i++) {
-        base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW, VSEG);
+        if (env->mode == LA64) {
+            base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW_64, VSEG);
+        } else {
+            base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW_32, VSEG);
+        }
         if ((plv & env->CSR_DMW[i]) && (base_c == base_v)) {
-            *physical = dmw_va2pa(address);
+            *physical = dmw_va2pa(env, address, env->CSR_DMW[i]);
             *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
             return TLBRET_MATCH;
         }
-- 
2.39.2


