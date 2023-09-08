Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB186798B45
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:10:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeew2-0005So-SJ; Fri, 08 Sep 2023 13:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevz-0005JP-2o
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:19 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevn-000173-Vk
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:18 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-403004a96a4so109335e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192763; x=1694797563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uSgZZn+Jnut5EDCBHYA8pVwRk6TsaSgwb6RuIhbgXCw=;
 b=m1YfgYIhRupm0aj9an3YTZbW6OKfR7gcfsrR4cyzmwhQx0kAAfCbdmgWalBPzMyUBm
 dSFMYwyAGeLFLPVuDU8RASE9rA7eoF8AL/2AmrNUuuynXq8WWrs1BBrTXR0viiU7sEws
 XPmPT25I07PpgfddemSNnuMnWxZP+/0ioywKBI0ORym+LZDg2p7VVrE+e17Ln+RXdj+x
 ghqwlcZDgPLoGMJH+J/KDan6s4fVkdTYbBBjqvuSD590MDqKRO1yjDyHoHYEPfOG8l8k
 /xE4O6YzWfEH4enyMShxxq+fS+M3NaCQnG65y6nbLeR9QlksFfJnPQ//+SpHBG+r6PSD
 DiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192763; x=1694797563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uSgZZn+Jnut5EDCBHYA8pVwRk6TsaSgwb6RuIhbgXCw=;
 b=KhBb5UhAgonnSJSYMuDuWtAtcdEDkyEPCXGMxu9N1HdGDw2cXraB3NGbjf+l5PWUNt
 S1fRGKjR1Od326ikb9JQv77TCDkNpsruTzczkiQ3tf8IWYtMdbT20w5I2vfa5pge4Sxy
 XjUgBgPKbANOdHuztmGdrVDc8UoTUBddexM802zBS+3lGB+TGybFxzESGGc/m3qidRkg
 Znb+s2OWcZRgh+TKp/qYgxinIlpxvashBtLm2vWDX2rXcAJXbRvUfLOfeCx2PP8bdzGa
 DB596rjAIa0hTJCQfxfnxkl+VB6xCo81BcafQM4SoGUJhP/2f9Vp9eALy5dMuaQ2mEsD
 SkCA==
X-Gm-Message-State: AOJu0YzoX82L+bmY8NOEmgE+/FKW8quNG+e7oYd2b4roq1MmJpcp2Pl7
 kwK/8oRBJLIUQKjMa5GKfnhSGBVyU+k2KNe10vY=
X-Google-Smtp-Source: AGHT+IH7Ngqnhi5xDZ7S37aS4O0KmnuUyh0FQKiWXiWCkxb3TKMV14txLYbY34ji0Kiwsdt/PFBh3Q==
X-Received: by 2002:a05:600c:2611:b0:401:1066:53e4 with SMTP id
 h17-20020a05600c261100b00401106653e4mr2811911wma.38.1694192763358; 
 Fri, 08 Sep 2023 10:06:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/26] target/arm: Implement FEAT_EPAC
Date: Fri,  8 Sep 2023 18:05:37 +0100
Message-Id: <20230908170557.773048-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Aaron Lindsay <aaron@os.amperecomputing.com>

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230829232335.965414-7-richard.henderson@linaro.org
Message-Id: <20230609172324.982888-5-aaron@os.amperecomputing.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst |  1 +
 target/arm/tcg/cpu64.c        |  2 +-
 target/arm/tcg/pauth_helper.c | 16 +++++++++++-----
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index c4bc4074866..2e99888a6ae 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -28,6 +28,7 @@ the following architecture extensions:
 - FEAT_DotProd (Advanced SIMD dot product instructions)
 - FEAT_DoubleFault (Double Fault Extension)
 - FEAT_E0PD (Preventing EL0 access to halves of address maps)
+- FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
 - FEAT_FCMA (Floating-point complex number instructions)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 4a1d9816dfb..b6a820aae74 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -803,7 +803,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = cpu->isar.id_aa64isar1;
     t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);      /* FEAT_DPB2 */
-    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_1);
+    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_EPAC);
     t = FIELD_DP64(t, ID_AA64ISAR1, API, 1);
     t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);    /* FEAT_JSCVT */
     t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);     /* FEAT_FCMA */
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index bb03409ee55..63e1009ea74 100644
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


