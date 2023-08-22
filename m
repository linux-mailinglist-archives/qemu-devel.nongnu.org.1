Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5418F783A67
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:10:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLX7-0002A9-IA; Tue, 22 Aug 2023 03:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLX2-00029l-J4
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:10:28 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLWz-0001xM-9Z
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:10:28 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fef3c3277bso12895415e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688223; x=1693293023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=js7oG4DiRv1a4biKMcFP1KhLlrjkX0Ffo4ofKONC+vY=;
 b=LjnsYBOMiD85mxT9wIojt2PRG2gfGgg0kDhaSIFe2lSZ864NGCiqmXy75QbLpJ/kjS
 TNheR0/2UlpygiFSRiu+aEHg4Bzb1TQBhCCHgrfhcfiHWyfSz/dInQ0YoBwVky0+VHeT
 Vc5qcqZw3DSvTGfH1j6yMe1RPpJd2HusuMrCPpbIEBV1THQW4Yhswy++I7+Lls6MWHzk
 mvBzG3GHOUlngF1rN3Wnd4GBLDVeBDF9FrzZhz5UAxF6sPWoz46X4g1MvrlpcZ5lRQvH
 yo4G//w/F2T3sYZu3tfcXbT5QYkbGjMJZmy4/46w2AgTZNqnFsZ8bx0VEXW2RnKj9rtK
 YPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688223; x=1693293023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=js7oG4DiRv1a4biKMcFP1KhLlrjkX0Ffo4ofKONC+vY=;
 b=EsNHivSiEIORkVvR4a8pnIgJB0Zh6ink1uEOMg2ApsbOSEbXB4cyhADdZcqnsI02uI
 pO/KdD6ZONXwGSJ0VlgqYSP77mOnd6q4xJbpl2ZQaBP6OVdMJ4TXeEVzyTrN2xaQxiza
 CKXgmLhL/Tbd0IH3arsvWr9cD0bH4BgMIxvafzz4rkCNkw0/oLJc1bqUV2DLOhdGS1vI
 IHtTbCIh/X3lDc0VpwZCZcix3LfZhc1lfyHT8v/U1qWBzSl9g/ZL/j6wfhncmKwaNg3c
 5Q/Ccmt/jsSdw9kg5o9RFu2ORQH/lI2R+k62/NsbovSwnlX/rUOxrA7Z40Rvd4lCzQy7
 6Y+w==
X-Gm-Message-State: AOJu0YwoLuYePCHAA7ufUtv/EtNhW9rddak1ot1e+IpD4QW9LuXx7ilB
 dHU9evFrvKQ4HRkWJzMWNpni1+Bd2fheEwSxPyN/eg==
X-Google-Smtp-Source: AGHT+IFC/Hty/vzYpU8HD4T36DcuBSO0kDECYsozHRwXElY17m8td1EQlrDeDO1K8MIdvLLX6EXB8Q==
X-Received: by 2002:a7b:c4c9:0:b0:3fe:2b8c:9f0b with SMTP id
 g9-20020a7bc4c9000000b003fe2b8c9f0bmr6543968wmk.23.1692688223599; 
 Tue, 22 Aug 2023 00:10:23 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a7bcb01000000b003fefcbe7fa8sm40904wmj.28.2023.08.22.00.10.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:10:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 01/19] target/loongarch: Support LoongArch32 TLB entry
Date: Tue, 22 Aug 2023 09:09:54 +0200
Message-ID: <20230822071013.34884-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071013.34884-1-philmd@linaro.org>
References: <20230822071013.34884-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
2.41.0


