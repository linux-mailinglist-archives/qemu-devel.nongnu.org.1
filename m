Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBC47D28A7
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 04:41:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quksV-0006fc-3x; Sun, 22 Oct 2023 22:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1quksS-0006fQ-If
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 22:41:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1quksP-0005Ua-7b
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 22:41:12 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cxh+g73TVl0dYzAA--.65134S3;
 Mon, 23 Oct 2023 10:40:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxkN053TVl7L0uAA--.35823S2; 
 Mon, 23 Oct 2023 10:40:57 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, philmd@linaro.org,
 maobibo@loongson.cn
Subject: [PATCH] target/loongarch: Support 4K page size
Date: Mon, 23 Oct 2023 10:40:59 +0800
Message-Id: <20231023024059.3858349-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxkN053TVl7L0uAA--.35823S2
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

The LoongArch kernel supports 4K page size.
Change TARGET_PAGE_BITS to 12.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu-param.h  | 2 +-
 target/loongarch/tlb_helper.c | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index 1265dc7cb5..cfe195db4e 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -12,6 +12,6 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 48
 #define TARGET_VIRT_ADDR_SPACE_BITS 48
 
-#define TARGET_PAGE_BITS 14
+#define TARGET_PAGE_BITS 12
 
 #endif
diff --git a/target/loongarch/tlb_helper.c b/target/loongarch/tlb_helper.c
index c8b8b0497f..449043c68b 100644
--- a/target/loongarch/tlb_helper.c
+++ b/target/loongarch/tlb_helper.c
@@ -60,6 +60,9 @@ static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
         tlb_rplv = 0;
     }
 
+    /* Remove sw bit between bit12 -- bit PS*/
+    tlb_ppn = tlb_ppn & ~(((0x1UL << (tlb_ps - 12)) -1));
+
     /* Check access rights */
     if (!tlb_v) {
         return TLBRET_INVALID;
@@ -82,10 +85,6 @@ static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
         return TLBRET_DIRTY;
     }
 
-    /*
-     * tlb_entry contains ppn[47:12] while 16KiB ppn is [47:15]
-     * need adjust.
-     */
     *physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
                 (address & MAKE_64BIT_MASK(0, tlb_ps));
     *prot = PAGE_READ;
@@ -774,7 +773,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
         /* Move Global bit */
         tmp0 = ((tmp0 & (1 << LOONGARCH_HGLOBAL_SHIFT))  >>
                 LOONGARCH_HGLOBAL_SHIFT) << R_TLBENTRY_G_SHIFT |
-                (tmp0 & (~(1 << R_TLBENTRY_G_SHIFT)));
+                (tmp0 & (~(1 << LOONGARCH_HGLOBAL_SHIFT)));
         ps = ptbase + ptwidth - 1;
         if (odd) {
             tmp0 += MAKE_64BIT_MASK(ps, 1);
-- 
2.25.1


