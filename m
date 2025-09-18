Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33285B3CBAE
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Aug 2025 17:09:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN3g-0001pw-33; Sat, 30 Aug 2025 11:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1urpH0-0008O8-Jv
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 22:55:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1urpGs-00079x-Sm
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 22:55:28 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxaNGXFrFotG4EAA--.8935S3;
 Fri, 29 Aug 2025 10:55:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDxbMGMFrFoKstvAA--.33085S11;
 Fri, 29 Aug 2025 10:55:19 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/14] target/loongarch: Use loongarch_check_pte in
 loongarch_page_table_walker
Date: Fri, 29 Aug 2025 10:55:02 +0800
Message-Id: <20250829025507.2315073-10-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250829025507.2315073-1-maobibo@loongson.cn>
References: <20250829025507.2315073-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxbMGMFrFoKstvAA--.33085S11
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

Function loongarch_check_pte() can get physical address and access
priviledge, it works on both TLB entry and pte entry. It can be used
in function loongarch_page_table_walker() also.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/cpu_helper.c | 42 +++++++++++++----------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 739cdab5aa..cd61b33ef9 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -106,15 +106,17 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
 }
 
 static TLBRet loongarch_page_table_walker(CPULoongArchState *env,
-                                          hwaddr *physical,
-                                          int *prot, vaddr address)
+                                          MMUContext *context,
+                                          int access_type, int mmu_idx)
 {
     CPUState *cs = env_cpu(env);
     target_ulong index, phys;
     uint64_t dir_base, dir_width;
     uint64_t base;
     int level;
+    vaddr address;
 
+    address = context->addr;
     if ((address >> 63) & 0x1) {
         base = env->CSR_PGDH;
     } else {
@@ -156,29 +158,9 @@ static TLBRet loongarch_page_table_walker(CPULoongArchState *env,
         base = ldq_phys(cs->as, phys);
     }
 
-    /* TODO: check plv and other bits? */
-
-    /* base is pte, in normal pte format */
-    if (!FIELD_EX64(base, TLBENTRY, V)) {
-        return TLBRET_NOMATCH;
-    }
-
-    if (!FIELD_EX64(base, TLBENTRY, D)) {
-        *prot = PAGE_READ;
-    } else {
-        *prot = PAGE_READ | PAGE_WRITE;
-    }
-
-    /* get TARGET_PAGE_SIZE aligned physical address */
-    base += (address & TARGET_PHYS_MASK) & ((1 << dir_base) - 1);
-    /* mask RPLV, NX, NR bits */
-    base = FIELD_DP64(base, TLBENTRY_64, RPLV, 0);
-    base = FIELD_DP64(base, TLBENTRY_64, NX, 0);
-    base = FIELD_DP64(base, TLBENTRY_64, NR, 0);
-    /* mask other attribute bits */
-    *physical = base & TARGET_PAGE_MASK;
-
-    return TLBRET_MATCH;
+    context->ps = dir_base;
+    context->pte = base;
+    return loongarch_check_pte(env, context, access_type, mmu_idx);
 }
 
 static TLBRet loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
@@ -187,7 +169,9 @@ static TLBRet loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
                                     int is_debug)
 {
     TLBRet ret;
+    MMUContext context;
 
+    context.addr = address;
     if (tcg_enabled()) {
         ret = loongarch_get_addr_from_tlb(env, physical, prot, address,
                                           access_type, mmu_idx);
@@ -202,7 +186,13 @@ static TLBRet loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
          * legal mapping, even if the mapping is not yet in TLB. return 0 if
          * there is a valid map, else none zero.
          */
-        return loongarch_page_table_walker(env, physical, prot, address);
+        ret = loongarch_page_table_walker(env, &context, access_type, mmu_idx);
+        if (ret == TLBRET_MATCH) {
+            *physical = context.physical;
+            *prot = context.prot;
+        }
+
+        return ret;
     }
 
     return TLBRET_NOMATCH;
-- 
2.43.5


