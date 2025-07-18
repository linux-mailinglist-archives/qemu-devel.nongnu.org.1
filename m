Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F7AB09CDE
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Jul 2025 09:42:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucfj4-0001cF-8b; Fri, 18 Jul 2025 03:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ucfW4-0002df-B5
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 03:28:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ucfVz-0002jh-22
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 03:28:24 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxnOKN93lozcksAQ--.56658S3;
 Fri, 18 Jul 2025 15:28:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxocKI93lo0QwcAA--.17387S9;
 Fri, 18 Jul 2025 15:28:12 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 7/9] target/loongarch: Use mmu idx bitmap method when flush
 tlb
Date: Fri, 18 Jul 2025 15:28:05 +0800
Message-Id: <20250718072807.3585466-8-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250718072807.3585466-1-maobibo@loongson.cn>
References: <20250718072807.3585466-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxocKI93lo0QwcAA--.17387S9
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

With API tlb_flush_range_by_mmuidx(), bitmap method of mmu idx should
be used rather than itself. Also mmu idx comes from page table entry
information rather current running mode. With page table entry,
global bit for MMU_KERNEL_IDX, otherwise it is MMU_USER_IDX.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index ca2fabfa6a..76ec469341 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -101,8 +101,7 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
     target_ulong addr, mask, pagesize;
     uint8_t tlb_ps;
     LoongArchTLB *tlb = &env->tlb[index];
-
-    int mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    int mmu_idx;
     uint8_t tlb_v0 = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, V);
     uint8_t tlb_v1 = FIELD_EX64(tlb->tlb_entry1, TLBENTRY, V);
     uint64_t tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
@@ -118,12 +117,14 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
 
     if (tlb_v0) {
         addr = (tlb_vppn << R_TLB_MISC_VPPN_SHIFT) & ~mask;    /* even */
+        mmu_idx = BIT(FIELD_EX64(tlb->tlb_entry0, TLBENTRY, PLV));
         tlb_flush_range_by_mmuidx(env_cpu(env), addr, pagesize,
                                   mmu_idx, TARGET_LONG_BITS);
     }
 
     if (tlb_v1) {
         addr = (tlb_vppn << R_TLB_MISC_VPPN_SHIFT) & pagesize;    /* odd */
+        mmu_idx = BIT(FIELD_EX64(tlb->tlb_entry1, TLBENTRY, PLV));
         tlb_flush_range_by_mmuidx(env_cpu(env), addr, pagesize,
                                   mmu_idx, TARGET_LONG_BITS);
     }
-- 
2.39.3


