Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21859783AA4
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:14:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLan-0008Md-Pk; Tue, 22 Aug 2023 03:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLam-0008MV-0I
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:14:20 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLai-0002pb-Jl
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:14:19 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31adc5c899fso3886373f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688455; x=1693293255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=js7oG4DiRv1a4biKMcFP1KhLlrjkX0Ffo4ofKONC+vY=;
 b=IVyed04yOf53m/KTlRhA6/Mq0qXTxSpKsYKJ+1ffnhX8lPIjeMgXzrlkYHxgyBK4Su
 bqODQ0fDD6Vhjy3WPcFEK10iC4q727VsklbEdzCHdoKkhuMTO/rkilVuy7ueDAoN/MUT
 PcoPifHZv42/Otzx0PSom3hdGvTgtlijBV7hb28YMPdieKaOwZfCmsyQecibSrxb2YDu
 2890Hb5Tw/eYCROdvzOpxec/Yhy3SX1YnY2AIcNMp6GkFzIpymNoYyCB6nHPV26khCrD
 C2HKP5duM/Gb4D0bTmtTQJj6yTb6nlusBnc5hVqTSSTEBrDep3n1oW9zhnDPayMDzVAi
 XYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688455; x=1693293255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=js7oG4DiRv1a4biKMcFP1KhLlrjkX0Ffo4ofKONC+vY=;
 b=B2YqeNv4SgkQKPAbiUtKdVv54tT8P6aGCyD6P+0UzEDackm79kgfHyZteq3OPsfve5
 y4RPmpZBKIpKqaX8dCghgjprXYxdEMG3LhsI7+mzW4ncyNMVcZY0SvoDednvh21hOHv3
 1rIURi0yF6u+gY7Gsqv5R1KwkrXiGXba3YyjvUY8/TONyYkciWB8CO6MAtlSr4hWjRr1
 oQile9Gt0J28XE5I5W6ItazQEMipO7bC0PJCbWGiJqDrxnhJrdCbvRRRKtDFQo9AvFpR
 GZkSHRiM++e3mNUpsbCPafaNHkmv2RpzkZdFUQQE/iNuIy3RO8SXCx7Kk++v4AezatGo
 uoMw==
X-Gm-Message-State: AOJu0YxJt4lgvLht8d8am6p2bDg+ydnuoP8zBQWyJPAU24D51md0gz7D
 8dVWLvfIKXj0G1BB1LXtNfVvHthf1xVj81gj943GVw==
X-Google-Smtp-Source: AGHT+IGJPAqdZgF2hW3bCmCDfKNYM23HbeiTQZRNoVqnLxzxxEhHiIiRi6xWfaq5G0eaNOT+PO94lQ==
X-Received: by 2002:a5d:5242:0:b0:317:5351:e428 with SMTP id
 k2-20020a5d5242000000b003175351e428mr6798342wrc.4.1692688454951; 
 Tue, 22 Aug 2023 00:14:14 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 c10-20020adffb4a000000b00317a29af4b2sm14740574wrs.68.2023.08.22.00.14.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:14:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>, Jiajie Chen <c@jia.je>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH RESEND v5 01/19] target/loongarch: Support LoongArch32 TLB
 entry
Date: Tue, 22 Aug 2023 09:13:47 +0200
Message-ID: <20230822071405.35386-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071405.35386-1-philmd@linaro.org>
References: <20230822071405.35386-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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


