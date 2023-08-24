Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D4E786BA0
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:25:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6Zv-0003iQ-ID; Thu, 24 Aug 2023 05:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qZ6Zr-0003Yg-N1
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:24:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qZ6Zl-0003Pz-Ni
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:24:31 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxlPDAIedkTHkbAA--.56192S3;
 Thu, 24 Aug 2023 17:24:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxJ826IedkJjhiAA--.40637S11; 
 Thu, 24 Aug 2023 17:24:15 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, richard.henderson@linaro.org, Jiajie Chen <c@jia.je>
Subject: [PULL 09/31] target/loongarch: Support LoongArch32 TLB entry
Date: Thu, 24 Aug 2023 17:23:47 +0800
Message-Id: <20230824092409.1492470-10-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230824092409.1492470-1-gaosong@loongson.cn>
References: <20230824092409.1492470-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ826IedkJjhiAA--.40637S11
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

The TLB entry of LA32 lacks NR, NX and RPLV and they are hardwired to
zero in LoongArch32.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20230822032724.1353391-2-gaosong@loongson.cn>
Message-Id: <20230822071405.35386-2-philmd@linaro.org>
---
 target/loongarch/cpu-csr.h    |  9 +++++----
 target/loongarch/tlb_helper.c | 17 ++++++++++++-----
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index f8f24032cb..48ed2e0632 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -66,10 +66,11 @@ FIELD(TLBENTRY, D, 1, 1)
 FIELD(TLBENTRY, PLV, 2, 2)
 FIELD(TLBENTRY, MAT, 4, 2)
 FIELD(TLBENTRY, G, 6, 1)
-FIELD(TLBENTRY, PPN, 12, 36)
-FIELD(TLBENTRY, NR, 61, 1)
-FIELD(TLBENTRY, NX, 62, 1)
-FIELD(TLBENTRY, RPLV, 63, 1)
+FIELD(TLBENTRY_32, PPN, 8, 24)
+FIELD(TLBENTRY_64, PPN, 12, 36)
+FIELD(TLBENTRY_64, NR, 61, 1)
+FIELD(TLBENTRY_64, NX, 62, 1)
+FIELD(TLBENTRY_64, RPLV, 63, 1)
 
 #define LOONGARCH_CSR_ASID           0x18 /* Address space identifier */
 FIELD(CSR_ASID, ASID, 0, 10)
diff --git a/target/loongarch/tlb_helper.c b/target/loongarch/tlb_helper.c
index 6e00190547..cef10e2257 100644
--- a/target/loongarch/tlb_helper.c
+++ b/target/loongarch/tlb_helper.c
@@ -48,10 +48,17 @@ static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
     tlb_v = FIELD_EX64(tlb_entry, TLBENTRY, V);
     tlb_d = FIELD_EX64(tlb_entry, TLBENTRY, D);
     tlb_plv = FIELD_EX64(tlb_entry, TLBENTRY, PLV);
-    tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY, PPN);
-    tlb_nx = FIELD_EX64(tlb_entry, TLBENTRY, NX);
-    tlb_nr = FIELD_EX64(tlb_entry, TLBENTRY, NR);
-    tlb_rplv = FIELD_EX64(tlb_entry, TLBENTRY, RPLV);
+    if (is_la64(env)) {
+        tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_64, PPN);
+        tlb_nx = FIELD_EX64(tlb_entry, TLBENTRY_64, NX);
+        tlb_nr = FIELD_EX64(tlb_entry, TLBENTRY_64, NR);
+        tlb_rplv = FIELD_EX64(tlb_entry, TLBENTRY_64, RPLV);
+    } else {
+        tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_32, PPN);
+        tlb_nx = 0;
+        tlb_nr = 0;
+        tlb_rplv = 0;
+    }
 
     /* Check access rights */
     if (!tlb_v) {
@@ -79,7 +86,7 @@ static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
      * tlb_entry contains ppn[47:12] while 16KiB ppn is [47:15]
      * need adjust.
      */
-    *physical = (tlb_ppn << R_TLBENTRY_PPN_SHIFT) |
+    *physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
                 (address & MAKE_64BIT_MASK(0, tlb_ps));
     *prot = PAGE_READ;
     if (tlb_d) {
-- 
2.39.1


