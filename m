Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F3D798B2E
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:07:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeew9-0005bl-Hw; Fri, 08 Sep 2023 13:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeew6-0005WI-K2
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevr-00019h-Fe
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-401b393ddd2so25933605e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192770; x=1694797570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6+hzQq6Hkaq0v8KlTeM75nHE4HX8jc3S1BI8MtXCF2U=;
 b=rYa+6iyeM9pzFbzf2hqTJGBpSbx62sOT8jYpqGiSqh35MdCPIG64rNZ7R7ouW3I2TW
 1m43jnSTgPj3k+q/y6MbeHpDzeDcIIgnXalZ7+BxEJTaNTPtTyN39BAVIsQYCMTESA5Q
 kcKpwxyH+5qRz/hmDs54A39LfeZsBoAmswQOC9hGOSyRgBwU90teVChpaRMM2ngintLG
 LWRtTSBXNgBT1NCyBuq3+U8Wacf7KRFtQ/0nrydUAidL3GjbCYZw1AKHMZrLUF/7UAzd
 afh2XVDJqMGGxNczS0ql4Xc6fac3uo4GW7vUNFu55kdtBjjzDyJ33KHz1cSsaNeJ24YZ
 K9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192770; x=1694797570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+hzQq6Hkaq0v8KlTeM75nHE4HX8jc3S1BI8MtXCF2U=;
 b=s1QXPoKkgTvJY9YlJWiUdKzGBxc61uLWIrmqrnxcrcNZDvFbDD70sn5+DMPQtexp0e
 NTbDyWu8TChYwrYfyF7SxdO3JoHOIt874sPps2sQxv0tu9c3oFaKsd51mg0bK27ip18k
 bQ3vcFlJBMAFilI++zyd4mtoigmA4UNtm4o7UN33MfHfislKYOIHpOxfO+3go04zqL/v
 wyRV0cN6+dfxDQq1mte7yjr2otGOgP97ByQNIi/AyVikU7+sGTXt/LDWNziq1PQLzZuf
 Do9a6YjZA52h2lMPvgbWcw3OR1kPpPgXAKRW7m9Z9+Gc1SBdLN2kg57QEql4CSbGdf5m
 Qc7g==
X-Gm-Message-State: AOJu0YyMoMe5zx+ve2ayPt/nsgd6rzwFdtHpRGeQIKjl5q0uHG+zEDlY
 WfwPjekpsA9nGK+kkfJgHM2eZ/6W2SZA3DLEUvU=
X-Google-Smtp-Source: AGHT+IHf6qgPfFQqUpLHoktA8MuE9TLXzMk2Jhj7PtnCJY+Ly5x0XI66qL6LgRK5bfTFrv7bcgK8vg==
X-Received: by 2002:a7b:c4ca:0:b0:401:aa8f:7565 with SMTP id
 g10-20020a7bc4ca000000b00401aa8f7565mr2516760wmk.34.1694192769893; 
 Fri, 08 Sep 2023 10:06:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/26] target/arm: Implement RMR_ELx
Date: Fri,  8 Sep 2023 18:05:52 +0100
Message-Id: <20230908170557.773048-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Provide a stub implementation, as a write is a "request".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230831232441.66020-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 64 +++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f9f7c3c39e9..3b22596eabf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8682,16 +8682,25 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         };
         modify_arm_cp_regs(v8_idregs, v8_user_idregs);
 #endif
-        /* RVBAR_EL1 is only implemented if EL1 is the highest EL */
+        /*
+         * RVBAR_EL1 and RMR_EL1 only implemented if EL1 is the highest EL.
+         * TODO: For RMR, a write with bit 1 set should do something with
+         * cpu_reset(). In the meantime, "the bit is strictly a request",
+         * so we are in spec just ignoring writes.
+         */
         if (!arm_feature(env, ARM_FEATURE_EL3) &&
             !arm_feature(env, ARM_FEATURE_EL2)) {
-            ARMCPRegInfo rvbar = {
-                .name = "RVBAR_EL1", .state = ARM_CP_STATE_BOTH,
-                .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 0, .opc2 = 1,
-                .access = PL1_R,
-                .fieldoffset = offsetof(CPUARMState, cp15.rvbar),
+            ARMCPRegInfo el1_reset_regs[] = {
+                { .name = "RVBAR_EL1", .state = ARM_CP_STATE_BOTH,
+                  .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 0, .opc2 = 1,
+                  .access = PL1_R,
+                  .fieldoffset = offsetof(CPUARMState, cp15.rvbar) },
+                { .name = "RMR_EL1", .state = ARM_CP_STATE_BOTH,
+                  .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 0, .opc2 = 2,
+                  .access = PL1_RW, .type = ARM_CP_CONST,
+                  .resetvalue = arm_feature(env, ARM_FEATURE_AARCH64) }
             };
-            define_one_arm_cp_reg(cpu, &rvbar);
+            define_arm_cp_regs(cpu, el1_reset_regs);
         }
         define_arm_cp_regs(cpu, v8_idregs);
         define_arm_cp_regs(cpu, v8_cp_reginfo);
@@ -8775,22 +8784,25 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         if (cpu_isar_feature(aa64_sel2, cpu)) {
             define_arm_cp_regs(cpu, el2_sec_cp_reginfo);
         }
-        /* RVBAR_EL2 is only implemented if EL2 is the highest EL */
+        /*
+         * RVBAR_EL2 and RMR_EL2 only implemented if EL2 is the highest EL.
+         * See commentary near RMR_EL1.
+         */
         if (!arm_feature(env, ARM_FEATURE_EL3)) {
-            ARMCPRegInfo rvbar[] = {
-                {
-                    .name = "RVBAR_EL2", .state = ARM_CP_STATE_AA64,
-                    .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 0, .opc2 = 1,
-                    .access = PL2_R,
-                    .fieldoffset = offsetof(CPUARMState, cp15.rvbar),
-                },
-                {   .name = "RVBAR", .type = ARM_CP_ALIAS,
-                    .cp = 15, .opc1 = 0, .crn = 12, .crm = 0, .opc2 = 1,
-                    .access = PL2_R,
-                    .fieldoffset = offsetof(CPUARMState, cp15.rvbar),
-                },
+            static const ARMCPRegInfo el2_reset_regs[] = {
+                { .name = "RVBAR_EL2", .state = ARM_CP_STATE_AA64,
+                  .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 0, .opc2 = 1,
+                  .access = PL2_R,
+                  .fieldoffset = offsetof(CPUARMState, cp15.rvbar) },
+                { .name = "RVBAR", .type = ARM_CP_ALIAS,
+                  .cp = 15, .opc1 = 0, .crn = 12, .crm = 0, .opc2 = 1,
+                  .access = PL2_R,
+                  .fieldoffset = offsetof(CPUARMState, cp15.rvbar) },
+                { .name = "RMR_EL2", .state = ARM_CP_STATE_AA64,
+                  .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 0, .opc2 = 2,
+                  .access = PL2_RW, .type = ARM_CP_CONST, .resetvalue = 1 },
             };
-            define_arm_cp_regs(cpu, rvbar);
+            define_arm_cp_regs(cpu, el2_reset_regs);
         }
     }
 
@@ -8801,8 +8813,14 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "RVBAR_EL3", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 6, .crn = 12, .crm = 0, .opc2 = 1,
               .access = PL3_R,
-              .fieldoffset = offsetof(CPUARMState, cp15.rvbar),
-            },
+              .fieldoffset = offsetof(CPUARMState, cp15.rvbar), },
+            { .name = "RMR_EL3", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 6, .crn = 12, .crm = 0, .opc2 = 2,
+              .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 1 },
+            { .name = "RMR", .state = ARM_CP_STATE_AA32,
+              .cp = 15, .opc1 = 0, .crn = 12, .crm = 0, .opc2 = 2,
+              .access = PL3_RW, .type = ARM_CP_CONST,
+              .resetvalue = arm_feature(env, ARM_FEATURE_AARCH64) },
             { .name = "SCTLR_EL3", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 0, .opc2 = 0,
               .access = PL3_RW,
-- 
2.34.1


