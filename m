Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B38BA86A89A
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Feb 2024 07:56:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfDrP-0000XW-Mt; Wed, 28 Feb 2024 01:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1rfDrK-0000WO-P5
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 01:56:06 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1rfDrG-0002VX-VG
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 01:56:06 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxWOj62N5lcUYSAA--.27040S3;
 Wed, 28 Feb 2024 14:55:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxX8_42N5l25BJAA--.63826S2; 
 Wed, 28 Feb 2024 14:55:52 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PATCH] Fixed tlb huge page loading issue
Date: Wed, 28 Feb 2024 14:55:52 +0800
Message-Id: <20240228065552.365973-1-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxX8_42N5l25BJAA--.63826S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The lddir and ldpte instruction emulation has
a problem with the use of large page processing above level 2.
The page size is not correctly calculated,
resulting in the wrong page size of the table entry found by tlb.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
 target/loongarch/cpu.h            |  1 +
 target/loongarch/tcg/tlb_helper.c | 21 ++++++++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ec37579fd6..eab3e41c71 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -292,6 +292,7 @@ typedef struct CPUArchState {
     uint32_t fcsr0_mask;
 
     uint32_t cpucfg[21];
+    uint32_t lddir_ps;
 
     uint64_t lladdr; /* LL virtual address compared against SC */
     uint64_t llval;
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index a08c08b05a..3594c800b3 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -38,6 +38,7 @@ static void raise_mmu_exception(CPULoongArchState *env, target_ulong address,
             cs->exception_index = EXCCODE_PIF;
         }
         env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 1);
+        env->lddir_ps = 0;
         break;
     case TLBRET_INVALID:
         /* TLB match with no valid bit */
@@ -488,13 +489,6 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     uint64_t dir_base, dir_width;
     bool huge = (base >> LOONGARCH_PAGE_HUGE_SHIFT) & 0x1;
 
-    badvaddr = env->CSR_TLBRBADV;
-    base = base & TARGET_PHYS_MASK;
-
-    /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
-    shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
-    shift = (shift + 1) * 3;
-
     if (huge) {
         return base;
     }
@@ -519,9 +513,18 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
         do_raise_exception(env, EXCCODE_INE, GETPC());
         return 0;
     }
+
+    /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
+    shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
+    shift = (shift + 1) * 3;
+    badvaddr = env->CSR_TLBRBADV;
+    base = base & TARGET_PHYS_MASK;
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys = base | index << shift;
     ret = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
+    if (ret & BIT_ULL(LOONGARCH_PAGE_HUGE_SHIFT)) {
+        env->lddir_ps = dir_base;
+    }
     return ret;
 }
 
@@ -538,13 +541,13 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
     base = base & TARGET_PHYS_MASK;
 
     if (huge) {
-        /* Huge Page. base is paddr */
         tmp0 = base ^ (1 << LOONGARCH_PAGE_HUGE_SHIFT);
         /* Move Global bit */
         tmp0 = ((tmp0 & (1 << LOONGARCH_HGLOBAL_SHIFT))  >>
                 LOONGARCH_HGLOBAL_SHIFT) << R_TLBENTRY_G_SHIFT |
                 (tmp0 & (~(1 << LOONGARCH_HGLOBAL_SHIFT)));
-        ps = ptbase + ptwidth - 1;
+
+        ps = env->lddir_ps - 1;
         if (odd) {
             tmp0 += MAKE_64BIT_MASK(ps, 1);
         }
-- 
2.39.1


