Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAA0773615
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 03:57:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTBwt-0002bn-QP; Mon, 07 Aug 2023 21:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTBwr-0002bJ-2G
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:55:49 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTBwp-0003gE-JC
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:55:48 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 9747A43F3A;
 Tue,  8 Aug 2023 01:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691459746; bh=q6w9V504UmX6Msb6OLHz0dKWjviEio2HPXlhiZTBxQs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RN5QMa9HMPOT5dbDS7MhWIoy47UZva2VrC9ITWgIia5fxFNSxzOCBDfBs6bqG+UOn
 9wG7dMydu/MZaNrg/FDoIZVlRj0CySBSmqBmU39pjUAR5fqzPLHQFZhS0E8ptMXSBZ
 I1ECI7DWopPh/UH4ieQ4XmIFGenDvbe1hUzqCxO4=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn,
 gaosong@loongson.cn, i.qemu@xen0n.name, Jiajie Chen <c@jia.je>
Subject: [PATCH v4 04/11] target/loongarch: Support LoongArch32 TLB entry
Date: Tue,  8 Aug 2023 09:54:30 +0800
Message-ID: <20230808015506.1705140-5-c@jia.je>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808015506.1705140-1-c@jia.je>
References: <20230808015506.1705140-1-c@jia.je>
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

The TLB entry of LA32 lacks NR, NX and RPLV and they are hardwired to
zero in LoongArch32.

Signed-off-by: Jiajie Chen <c@jia.je>
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
index 6e00190547..f74940ea9f 100644
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
+    if (LOONGARCH_CPUCFG_ARCH(env, LA64)) {
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
2.41.0


