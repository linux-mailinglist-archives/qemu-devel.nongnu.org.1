Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E62AD783AAD
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:16:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLay-0008Rf-NX; Tue, 22 Aug 2023 03:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLax-0008RQ-EN
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:14:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLav-0002tQ-5d
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:14:31 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fea0640d7aso41860155e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688467; x=1693293267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3rrV84vf0KvDLl6SX1WoOdtWUazfK9wKjoL6Oup5qkU=;
 b=PC+/Km5SxI4X5X0Gx6f4EEn6I/6em3GGwABRT6IAYoSRDNTE9dc4l+Z+AcEEDsg54Y
 zjXU9JCSwRL+atwP0qH0lV8+XijGnYgQDIgJmUWNz67SvlZ2mxSfkrAJSxO07lNQF5le
 yT4Benu628hfbsEqlqLCUliW4RBlNvHL+JzyNKDYcFOOs2HtzJ9pE6AlFVjnL7gxwzV2
 AkYSQ9GyvT8BC9X3n5br6y1zKuQoKHz+F4kcKRTLvwsItTP3wup4ppCZewfLqwULmHCj
 +MCxlbFrARIDbQMu7NtixN8D4LZy7HE0yGaJtY5tw2DU6kZpsZZ4tX4n8kFxabORMGgS
 GPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688467; x=1693293267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3rrV84vf0KvDLl6SX1WoOdtWUazfK9wKjoL6Oup5qkU=;
 b=SItBdedvtPkvVg/AfoQNmo9SCc5iY1yMZJW0sTHu998a2F6Xxw7IRAiT2LHA/Zt/MD
 0H3uSvi+mCsqYd6/jS6lhKeactXP0HIk3E4eDx2O5gD4PiD/PKoZFCt9qZvfuo4HiR9g
 +FRf47TGiWKcDrZHKmz3Box+u8mfAiLIfZ6fXPCE9MQy1Mmv1rPCIN3E66DoXCBQ0GSK
 wRvWpPnKQTIJkapipryAVprs1RZx0Cv8PyFsTkeP2CdfRrSoyv0Y5SXpsPlD56EmciGQ
 FcVcSz4rNbtVsewp0tcOgaZSCsCZR3gpmXjig7TfwRuuXVqqp77mJhxLT4QU4SgjXpcR
 OgqA==
X-Gm-Message-State: AOJu0YzHmu1MHzYekBJVrK4XLv7bEvg5V/6IyMCKHKuGR30DgNgEF/A+
 y5X1OR2XI1ffEacbACCFRqvwDU6YIHBh3HrDOErBrg==
X-Google-Smtp-Source: AGHT+IFFZLNRKRkGyYp4bs8G/ahkmMAPR/jU/sDUbLwvoao42zFVSh6uh1zhzwSorodw3G6OQH+cPA==
X-Received: by 2002:adf:fa47:0:b0:319:6e74:1637 with SMTP id
 y7-20020adffa47000000b003196e741637mr5816620wrr.27.1692688467340; 
 Tue, 22 Aug 2023 00:14:27 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 a8-20020adfed08000000b003196dba130asm14866177wro.106.2023.08.22.00.14.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:14:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>, Jiajie Chen <c@jia.je>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH RESEND v5 03/19] target/loongarch: Support LoongArch32 VPPN
Date: Tue, 22 Aug 2023 09:13:49 +0200
Message-ID: <20230822071405.35386-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071405.35386-1-philmd@linaro.org>
References: <20230822071405.35386-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

VPPN of TLBEHI/TLBREHI is limited to 19 bits in LA32.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20230822032724.1353391-4-gaosong@loongson.cn>
---
 target/loongarch/cpu-csr.h    |  6 ++++--
 target/loongarch/tlb_helper.c | 23 ++++++++++++++++++-----
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index b93f99a9ef..c59d7a9fcb 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -57,7 +57,8 @@ FIELD(CSR_TLBIDX, PS, 24, 6)
 FIELD(CSR_TLBIDX, NE, 31, 1)
 
 #define LOONGARCH_CSR_TLBEHI         0x11 /* TLB EntryHi */
-FIELD(CSR_TLBEHI, VPPN, 13, 35)
+FIELD(CSR_TLBEHI_32, VPPN, 13, 19)
+FIELD(CSR_TLBEHI_64, VPPN, 13, 35)
 
 #define LOONGARCH_CSR_TLBELO0        0x12 /* TLB EntryLo0 */
 #define LOONGARCH_CSR_TLBELO1        0x13 /* TLB EntryLo1 */
@@ -164,7 +165,8 @@ FIELD(CSR_TLBRERA, PC, 2, 62)
 #define LOONGARCH_CSR_TLBRELO1       0x8d /* TLB refill entrylo1 */
 #define LOONGARCH_CSR_TLBREHI        0x8e /* TLB refill entryhi */
 FIELD(CSR_TLBREHI, PS, 0, 6)
-FIELD(CSR_TLBREHI, VPPN, 13, 35)
+FIELD(CSR_TLBREHI_32, VPPN, 13, 19)
+FIELD(CSR_TLBREHI_64, VPPN, 13, 35)
 #define LOONGARCH_CSR_TLBRPRMD       0x8f /* TLB refill mode info */
 FIELD(CSR_TLBRPRMD, PPLV, 0, 2)
 FIELD(CSR_TLBRPRMD, PIE, 2, 1)
diff --git a/target/loongarch/tlb_helper.c b/target/loongarch/tlb_helper.c
index 1f8e7911c7..c8b8b0497f 100644
--- a/target/loongarch/tlb_helper.c
+++ b/target/loongarch/tlb_helper.c
@@ -300,8 +300,13 @@ static void raise_mmu_exception(CPULoongArchState *env, target_ulong address,
 
     if (tlb_error == TLBRET_NOMATCH) {
         env->CSR_TLBRBADV = address;
-        env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI, VPPN,
-                                      extract64(address, 13, 35));
+        if (is_la64(env)) {
+            env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI_64,
+                                        VPPN, extract64(address, 13, 35));
+        } else {
+            env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI_32,
+                                        VPPN, extract64(address, 13, 19));
+        }
     } else {
         if (!FIELD_EX64(env->CSR_DBG, CSR_DBG, DST)) {
             env->CSR_BADV = address;
@@ -366,12 +371,20 @@ static void fill_tlb_entry(CPULoongArchState *env, int index)
 
     if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
         csr_ps = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
-        csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, VPPN);
+        if (is_la64(env)) {
+            csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_64, VPPN);
+        } else {
+            csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_32, VPPN);
+        }
         lo0 = env->CSR_TLBRELO0;
         lo1 = env->CSR_TLBRELO1;
     } else {
         csr_ps = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
-        csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI, VPPN);
+        if (is_la64(env)) {
+            csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_64, VPPN);
+        } else {
+            csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_32, VPPN);
+        }
         lo0 = env->CSR_TLBELO0;
         lo1 = env->CSR_TLBELO1;
     }
@@ -491,7 +504,7 @@ void helper_tlbfill(CPULoongArchState *env)
 
     if (pagesize == stlb_ps) {
         /* Only write into STLB bits [47:13] */
-        address = entryhi & ~MAKE_64BIT_MASK(0, R_CSR_TLBEHI_VPPN_SHIFT);
+        address = entryhi & ~MAKE_64BIT_MASK(0, R_CSR_TLBEHI_64_VPPN_SHIFT);
 
         /* Choose one set ramdomly */
         set = get_random_tlb(0, 7);
-- 
2.41.0


