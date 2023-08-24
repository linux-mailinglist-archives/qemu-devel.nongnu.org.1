Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA77786C03
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:33:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6em-0007TC-Ly; Thu, 24 Aug 2023 05:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eD-0004Ri-On
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:01 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e9-00052Q-Ly
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:01 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fe32016bc8so60066285e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869333; x=1693474133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x4DDzWHFyDRlseI7znq+s9DyvjvZkarZQ2nXqeTK/2Q=;
 b=at2qwn9C8fB7rCXSXFRq61QVRvBoAzzseNb2a79SKqQ1vRqzDdhBexr9zhEKUiIZb4
 I/ROE3BWgfg7yeSc4anzdBZBwYFiW2CZ7A0oPj2D6OSgvmWX16i4PYykhd0GlFXU3B2H
 b7BKuct6bvQXVo2MJhcQSu7u7hXAcwI3Bp8+cZHPIECrXSy3Mku6kgV5wpx+kPDSBVRk
 ibKiZicEaMfWiAvqq2YPtziEi9iehJtfAugimh51AFvLk8LWva6NdZ1231OKKb45J8aH
 mFGIgpiCqC2zpgkfPBf6JqIF9OsmcV/tO83pZD5s/V5Qsa5C+twl9OGKuXfJiYOW7Zrb
 +LyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869333; x=1693474133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x4DDzWHFyDRlseI7znq+s9DyvjvZkarZQ2nXqeTK/2Q=;
 b=ULImTacxxD6URZNenyHX9mzqHo1NL0bEzD72kPCSgjZtRs63DlQPDlv0tNl3S9K8nt
 5c3dYydYWhfRhgFeLwZWtaPb+IAtMNDu9z9a62pzhjzgHbMVKPiXtklR4T4a41XmGi6I
 N8V4KjqRFmqSDSbuAXujtsiI7Qi0jmwIgMHZmlyBy/iYdjpyXZ9YCOSiStXA6a9q5wz7
 4TqdF2OWOkLb8VUmeyw/3DdTCp1DEW1XP1GwbGXHejsL3w8s7KFbz8qvoEsvl0O+fUwe
 p416azT4Ty6ZoozTWobaF5GjB732ND9fqB0uvLC9wu9ztt5r2xGyNBvTtWxlSRSo7hbc
 Jvjg==
X-Gm-Message-State: AOJu0YwTt1jY7x1RrNGw93sUmQXTUlLdksiGMaddWuc40JH4rkxselkd
 wt82wr7LwPhNw03USpfX7umJy+AolcENvKSFvYI=
X-Google-Smtp-Source: AGHT+IFrPgwl1rQVU1NYMnohOiTS+3ewsNz5CWWqklOpBlWSKwYnmM2MkAbZi98PKYb0n7YQW6KkGw==
X-Received: by 2002:a7b:c40b:0:b0:3fe:e77b:b2f4 with SMTP id
 k11-20020a7bc40b000000b003fee77bb2f4mr11056613wmi.36.1692869333555; 
 Thu, 24 Aug 2023 02:28:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/35] target/arm/helper: Check SCR_EL3.{NSE,
 NS} encoding for AT instructions
Date: Thu, 24 Aug 2023 10:28:33 +0100
Message-Id: <20230824092836.2239644-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The AT instruction is UNDEFINED if the {NSE,NS} configuration is
invalid. Add a function to check this on all AT instructions that apply
to an EL lower than 3.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-id: 20230809123706.1842548-6-jean-philippe@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index de639d40871..b4618ee2b95 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3616,6 +3616,22 @@ static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
 #endif /* CONFIG_TCG */
 }
 
+static CPAccessResult at_e012_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     bool isread)
+{
+    /*
+     * R_NYXTL: instruction is UNDEFINED if it applies to an Exception level
+     * lower than EL3 and the combination SCR_EL3.{NSE,NS} is reserved. This can
+     * only happen when executing at EL3 because that combination also causes an
+     * illegal exception return. We don't need to check FEAT_RME either, because
+     * scr_write() ensures that the NSE bit is not set otherwise.
+     */
+    if ((env->cp15.scr_el3 & (SCR_NSE | SCR_NS)) == SCR_NSE) {
+        return CP_ACCESS_TRAP;
+    }
+    return CP_ACCESS_OK;
+}
+
 static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                      bool isread)
 {
@@ -3623,7 +3639,7 @@ static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo *ri,
         !(env->cp15.scr_el3 & (SCR_NS | SCR_EEL2))) {
         return CP_ACCESS_TRAP;
     }
-    return CP_ACCESS_OK;
+    return at_e012_access(env, ri, isread);
 }
 
 static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -5505,38 +5521,38 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 0,
       .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
       .fgt = FGT_ATS1E1R,
-      .writefn = ats_write64 },
+      .accessfn = at_e012_access, .writefn = ats_write64 },
     { .name = "AT_S1E1W", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 1,
       .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
       .fgt = FGT_ATS1E1W,
-      .writefn = ats_write64 },
+      .accessfn = at_e012_access, .writefn = ats_write64 },
     { .name = "AT_S1E0R", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 2,
       .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
       .fgt = FGT_ATS1E0R,
-      .writefn = ats_write64 },
+      .accessfn = at_e012_access, .writefn = ats_write64 },
     { .name = "AT_S1E0W", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 3,
       .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
       .fgt = FGT_ATS1E0W,
-      .writefn = ats_write64 },
+      .accessfn = at_e012_access, .writefn = ats_write64 },
     { .name = "AT_S12E1R", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 4,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .writefn = ats_write64 },
+      .accessfn = at_e012_access, .writefn = ats_write64 },
     { .name = "AT_S12E1W", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 5,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .writefn = ats_write64 },
+      .accessfn = at_e012_access, .writefn = ats_write64 },
     { .name = "AT_S12E0R", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 6,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .writefn = ats_write64 },
+      .accessfn = at_e012_access, .writefn = ats_write64 },
     { .name = "AT_S12E0W", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 7,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .writefn = ats_write64 },
+      .accessfn = at_e012_access, .writefn = ats_write64 },
     /* AT S1E2* are elsewhere as they UNDEF from EL3 if EL2 is not present */
     { .name = "AT_S1E3R", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 7, .crm = 8, .opc2 = 0,
@@ -8079,12 +8095,12 @@ static const ARMCPRegInfo ats1e1_reginfo[] = {
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 0,
       .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
       .fgt = FGT_ATS1E1RP,
-      .writefn = ats_write64 },
+      .accessfn = at_e012_access, .writefn = ats_write64 },
     { .name = "AT_S1E1WP", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 1,
       .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
       .fgt = FGT_ATS1E1WP,
-      .writefn = ats_write64 },
+      .accessfn = at_e012_access, .writefn = ats_write64 },
 };
 
 static const ARMCPRegInfo ats1cp_reginfo[] = {
-- 
2.34.1


