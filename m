Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 754B076D4A8
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 19:04:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRFEj-0000Qg-GS; Wed, 02 Aug 2023 13:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qRFEh-0000Ov-Q0
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 13:02:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qRFEe-0003Um-LG
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 13:02:11 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3178dd771ceso25250f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 10:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690995727; x=1691600527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EXteElOZ4aVLc5E6hGgaB+KaS5kQH078EqMK8VfCtIU=;
 b=osP7/V+tt9gOFpvVUYh4H9Bg3JMk2BUf60j/DfsZ+iYUbVGzSvwjbXNs1TYPMSs1kV
 28ugNojazNQMRzwKXHmWRGivVvdjr72fiMdvfFrlGKn4HqrSPu/PJg32jnGxLLz61U/+
 4S18EDntuSF7wd5iWxnpe7uSjfHb1wLSD6wJCO/h76E8BNAq37PMNd47rB3CY7W4CaBh
 WGRo0FznS6GUyOFRD10l8IL009IJYZZ2BccI0wYi+dYo8q27DQwLys/5FYhLhBGbDRce
 7bE4KEpDZVz5dttjF/0rOAyhaJdNc3mjaAW2oQfj5BpMOvHWm6GDbja4ZTVFNvlwiyT7
 5SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690995727; x=1691600527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EXteElOZ4aVLc5E6hGgaB+KaS5kQH078EqMK8VfCtIU=;
 b=e6PcYVnIv0Sqn+7rbJTeVnG78gkna42qcV1gpTPHfS1Ql7gWMrq9m0i9ua42hNEyvX
 ikjfEtA7xR+pPuON6+t9CzXAjBr23YDSOsudAYx0dXBbjubMPYcsJ9OcAiYWTlsmbT7l
 c1f1qFCoYvGt99utScgqQcFVb0ZiUVrXlW7Z67ttSccsiwwoikcxYMKjp9XQPk1TOv59
 4Bk6ym3dzOcfiRAhVuVzTn3rQl163ZflFYXKPmzDwjUl5eJ4Ga5Nl+XSzfl6OoYgJyJS
 JPv3bL3eeRR/nYCr1f0kO2aaDv8qxwhqdfveDEbpGfZ9ilZG9DKeRbZGWlTghw29TnyP
 5mBg==
X-Gm-Message-State: ABy/qLaHCIWPo+e+efJ+t/XGn4RebkEUaN0T07jDkAw7f2h8KZDBLbWJ
 MaUIZ3/ubtdaLkwtr2ocfGDaww==
X-Google-Smtp-Source: APBJJlF1z++d6YJlXe3kX3FVrF3W2xAK2s3IddLqIkuaE96rgRXd7vR6S2uO9OsIWliEnDsGVmWpDw==
X-Received: by 2002:adf:f1d1:0:b0:313:ee2e:dae5 with SMTP id
 z17-20020adff1d1000000b00313ee2edae5mr5489652wro.21.1690995727243; 
 Wed, 02 Aug 2023 10:02:07 -0700 (PDT)
Received: from localhost.localdomain ([2.219.138.198])
 by smtp.gmail.com with ESMTPSA id
 q7-20020a1cf307000000b003fa98908014sm2149081wmq.8.2023.08.02.10.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 10:02:06 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 5/6] target/arm/helper: Check SCR_EL3.{NSE,
 NS} encoding for AT instructions
Date: Wed,  2 Aug 2023 18:01:56 +0100
Message-ID: <20230802170157.401491-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802170157.401491-1-jean-philippe@linaro.org>
References: <20230802170157.401491-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The AT instruction is UNDEFINED if the {NSE,NS} configuration is
invalid. Add a function to check this on all AT instructions that apply
to an EL lower than 3.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 target/arm/helper.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index fbb03c364b..77dd80ad28 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3616,6 +3616,20 @@ static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
 #endif /* CONFIG_TCG */
 }
 
+static CPAccessResult at_e012_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     bool isread)
+{
+    /*
+     * R_NYXTL: instruction is UNDEFINED if it applies to an Exception level
+     * lower than EL3 and the combination SCR_EL3.{NSE,NS} is reserved.
+     */
+    if (cpu_isar_feature(aa64_rme, env_archcpu(env)) &&
+        (env->cp15.scr_el3 & (SCR_NSE | SCR_NS)) == SCR_NSE) {
+        return CP_ACCESS_TRAP;
+    }
+    return CP_ACCESS_OK;
+}
+
 static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                      bool isread)
 {
@@ -3623,7 +3637,7 @@ static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo *ri,
         !(env->cp15.scr_el3 & (SCR_NS | SCR_EEL2))) {
         return CP_ACCESS_TRAP;
     }
-    return CP_ACCESS_OK;
+    return at_e012_access(env, ri, isread);
 }
 
 static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -5505,38 +5519,38 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
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
@@ -8078,12 +8092,12 @@ static const ARMCPRegInfo ats1e1_reginfo[] = {
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
2.41.0


