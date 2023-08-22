Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 738D57838CC
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 06:27:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYIxd-0006Lt-5s; Tue, 22 Aug 2023 00:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYIxb-0006Ki-BX
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:25:43 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYIxW-0007XJ-NL
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:25:43 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68a3cae6e1eso1456627b3a.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 21:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692678337; x=1693283137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSHDOqmpvVqWZn7zJjJYDufm+wpdwBxF2KdyWkAtGiQ=;
 b=o6QqnfH7xoHPpg49fkRKIFeOMYozEa1i0WoduEgnvvEyHOmL+ZtcfwkWCey35XRu34
 w4tagANRsxBwV0USzksRYFpTeNQiH7OYcQocexiTt3FPLEcjd8mPzmmsn4gHRhhrR6Rd
 p7UH3+dAUPPkoSLfmjkOQM2I6PgKHJXuzPgMnkl98pbjfBokaCnI4zSN2bPPBfCgab4b
 mBymnvup1l+mVnJQy72n5UhFpCkpQc3mhstF6P61L1gftMp5K1tFfKrgjiVgGUaqNaFn
 pQ5WKB63H1YEjz07mkF1Zwti1leXTELZqAaS8b4oWHeyi3QLVHbIBAoa9EocRCDoQHMS
 V/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692678337; x=1693283137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dSHDOqmpvVqWZn7zJjJYDufm+wpdwBxF2KdyWkAtGiQ=;
 b=SwVk1SBsdVBG3/v4IcC4/AW2SoHqiKgEjLEMlhzdFRZa+FlQVuziYUytq2/ir9BLRh
 NsZkxgmItGVIngkf9mSzdQXSOrIg+0hNIy3Dc5gSU2tOrbJFYYejGzACK1tUz3Ax9dM+
 Q1e3Z93zGPn7c4XBgrTf9vK6Ib/nlUq7kO9KT82qNciZsEde0YmdDxnrKlcML3nCrxxF
 drdletzOXplTydMrOjXmliuiFbvOJbVfUNMNdTHAiYi/GtQ8anVSxpeLDD4mLqBexANZ
 FIG2yUWH7Sgwtx8tRnM8vOZYAd4dgYaoHzvg/AwQFCXk+19uxYFqwRePbIavsunJIrDh
 Xupw==
X-Gm-Message-State: AOJu0YyFtYkyhwHNtBk5T7vYExyqAJjJ9AtfkHLncOF2WXEwoCt2is4I
 5IzVk46ILV8ot4CCT3agKcOYCZbEUBjoyYccq0M=
X-Google-Smtp-Source: AGHT+IFUDYbG5AurrHaqFP3B8k/r2Yfor7ieiNjZndr22v563rY6VcMgpmHqA53ca7p3NuNb37prYQ==
X-Received: by 2002:aa7:888f:0:b0:687:82a4:49f8 with SMTP id
 z15-20020aa7888f000000b0068782a449f8mr7088281pfe.30.1692678337218; 
 Mon, 21 Aug 2023 21:25:37 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 m14-20020aa7900e000000b0068a3f861b24sm3364908pfo.195.2023.08.21.21.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 21:25:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Aaron Lindsay <aaron@os.amperecomputing.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v4 6/9] target/arm: Implement FEAT_EPAC
Date: Mon, 21 Aug 2023 21:25:27 -0700
Message-Id: <20230822042530.1026751-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822042530.1026751-1-richard.henderson@linaro.org>
References: <20230822042530.1026751-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Aaron Lindsay <aaron@os.amperecomputing.com>

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230609172324.982888-5-aaron@os.amperecomputing.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst |  1 +
 target/arm/tcg/cpu64.c        |  2 +-
 target/arm/tcg/pauth_helper.c | 16 +++++++++++-----
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 06af20d10f..4866a73ca0 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -27,6 +27,7 @@ the following architecture extensions:
 - FEAT_DotProd (Advanced SIMD dot product instructions)
 - FEAT_DoubleFault (Double Fault Extension)
 - FEAT_E0PD (Preventing EL0 access to halves of address maps)
+- FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
 - FEAT_FCMA (Floating-point complex number instructions)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index fec6a4875d..85bf94ee40 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -758,7 +758,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = cpu->isar.id_aa64isar1;
     t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);      /* FEAT_DPB2 */
-    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_1);
+    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_EPAC);
     t = FIELD_DP64(t, ID_AA64ISAR1, API, 1);
     t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);    /* FEAT_JSCVT */
     t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);     /* FEAT_FCMA */
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index bb03409ee5..63e1009ea7 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -326,8 +326,10 @@ static uint64_t pauth_computepac(CPUARMState *env, uint64_t data,
 static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
                              ARMPACKey *key, bool data)
 {
+    ARMCPU *cpu = env_archcpu(env);
     ARMMMUIdx mmu_idx = arm_stage1_mmu_idx(env);
     ARMVAParameters param = aa64_va_parameters(env, ptr, mmu_idx, data, false);
+    ARMPauthFeature pauth_feature = cpu_isar_feature(pauth_feature, cpu);
     uint64_t pac, ext_ptr, ext, test;
     int bot_bit, top_bit;
 
@@ -351,11 +353,15 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
      */
     test = sextract64(ptr, bot_bit, top_bit - bot_bit);
     if (test != 0 && test != -1) {
-        /*
-         * Note that our top_bit is one greater than the pseudocode's
-         * version, hence "- 2" here.
-         */
-        pac ^= MAKE_64BIT_MASK(top_bit - 2, 1);
+        if (pauth_feature == PauthFeat_EPAC) {
+            pac = 0;
+        } else {
+            /*
+             * Note that our top_bit is one greater than the pseudocode's
+             * version, hence "- 2" here.
+             */
+            pac ^= MAKE_64BIT_MASK(top_bit - 2, 1);
+        }
     }
 
     /*
-- 
2.34.1


