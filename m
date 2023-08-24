Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9409786BC1
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:28:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6bo-0003Zq-Fl; Thu, 24 Aug 2023 05:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qZ6bT-0003Er-AR
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:26:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qZ6bO-0004D5-Gh
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:26:10 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxVujBIedkUXkbAA--.20602S3;
 Thu, 24 Aug 2023 17:24:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxJ826IedkJjhiAA--.40637S12; 
 Thu, 24 Aug 2023 17:24:16 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, richard.henderson@linaro.org, Jiajie Chen <c@jia.je>
Subject: [PULL 10/31] target/loongarch: Support LoongArch32 DMW
Date: Thu, 24 Aug 2023 17:23:48 +0800
Message-Id: <20230824092409.1492470-11-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230824092409.1492470-1-gaosong@loongson.cn>
References: <20230824092409.1492470-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ826IedkJjhiAA--.40637S12
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

From: Jiajie Chen <c@jia.je>

LA32 uses a different encoding for CSR.DMW and a new direct mapping
mechanism.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20230822032724.1353391-3-gaosong@loongson.cn>
Message-Id: <20230822071405.35386-3-philmd@linaro.org>
---
 target/loongarch/cpu-csr.h    |  7 +++----
 target/loongarch/tlb_helper.c | 26 +++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 7 deletions(-)

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
index cef10e2257..1f8e7911c7 100644
--- a/target/loongarch/tlb_helper.c
+++ b/target/loongarch/tlb_helper.c
@@ -173,6 +173,18 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
     return TLBRET_NOMATCH;
 }
 
+static hwaddr dmw_va2pa(CPULoongArchState *env, target_ulong va,
+                        target_ulong dmw)
+{
+    if (is_la64(env)) {
+        return va & TARGET_VIRT_MASK;
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
@@ -192,12 +204,20 @@ static int get_physical_address(CPULoongArchState *env, hwaddr *physical,
     }
 
     plv = kernel_mode | (user_mode << R_CSR_DMW_PLV3_SHIFT);
-    base_v = address >> R_CSR_DMW_VSEG_SHIFT;
+    if (is_la64(env)) {
+        base_v = address >> R_CSR_DMW_64_VSEG_SHIFT;
+    } else {
+        base_v = address >> R_CSR_DMW_32_VSEG_SHIFT;
+    }
     /* Check direct map window */
     for (int i = 0; i < 4; i++) {
-        base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW, VSEG);
+        if (is_la64(env)) {
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
2.39.1


