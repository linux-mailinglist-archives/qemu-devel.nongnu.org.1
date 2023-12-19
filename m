Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A1D81908E
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:18:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfX7-00021Q-GD; Tue, 19 Dec 2023 14:13:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfX4-0001zb-4S
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:34 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWy-0001sX-Sp
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:32 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33660cf2296so3956139f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013207; x=1703618007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0gBHCNexdbG+zEv+b4Ytrqor1JdvLFRCIBJ8HsM7maA=;
 b=xLsc6S/akiQ/dmQtKHUjcn4qHhHW3FjifaO2eaS4zaocJOm8bWj/oT7+Ogz3Zz2qi0
 mm6CddeSsJr3u2tCn3Ne8XHOWTKs5UnPJ5JmRsXLIdINK2LAA1BGgCcK2nL8JwS7S8Q8
 bxkISKoeAogZjTD2GthMzMElQzDPZFjvPM44fcnu8Y7k0/wddvcwyjeYyzNTxKNIQMiF
 z1gAYKfU1P+kMVeJyt3aeVPQXmuSi1DYUMdsjUiNeHcBfRuWiiBqELkZFniB95MzkdGL
 LWsi2xYPPEBLHGPMizw/7R7dsssfQ+ShWaOnXAtuKwYgVfEJ8Z3iNPa5qMCSvOnCfqOT
 FZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013207; x=1703618007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gBHCNexdbG+zEv+b4Ytrqor1JdvLFRCIBJ8HsM7maA=;
 b=H7f4CbNoewuoQbcV4zPwS2D47CpyTlU9RtF44QXaAuqwKB1igozjTLmQuZSRgT4xwQ
 JL6YORyYcqLmoipfqoeyaq6CIZZlSgRP9xLhx1kCLVMlnTUKzFH+qIjMCFClqMhWn7sS
 OO7Sjw+gYsnCNFFpW4pJGLMNSDkk0Yc0TC1i9PUz4wWFk9yDfOIIoAJmzwt3J1Pw1ZtR
 bFFaFs2r7xMOP2TZ6Jdl4MBziPJcKSMjm4EAcuRKBiLeP1uHZUEk+02q8wkG7O573VM6
 neNmXhXc6tWdVOyYiEWmQ1Dcry+LVK/baOvNwITLu0m+2GA43YCRVl2y9fwsSwpNZoBV
 85NQ==
X-Gm-Message-State: AOJu0Yx/2vW8rpHw+2qoY1bfV0t4YKH2QKknFnv3C17xHwlx3Uul2V1m
 yJNIlhj/vg19P1/jGTRP1HtuQ++DNR/9INZcuHk=
X-Google-Smtp-Source: AGHT+IHF536noumzaQyVsy1+bksZIMp16F47IX/DvFW1Km/8kz7wHqERIRQv0cVqMaVWzSWSkf0sJg==
X-Received: by 2002:adf:f5c6:0:b0:336:7197:56e6 with SMTP id
 k6-20020adff5c6000000b00336719756e6mr1149861wrp.136.1703013207615; 
 Tue, 19 Dec 2023 11:13:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/43] target/arm: Don't implement *32_EL2 registers when EL1
 is AArch64 only
Date: Tue, 19 Dec 2023 19:13:02 +0000
Message-Id: <20231219191307.2895919-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

The system registers DBGVCR32_EL2, FPEXC32_EL2, DACR32_EL2 and
IFSR32_EL2 are present only to allow an AArch64 EL2 or EL3 to read
and write the contents of an AArch32-only system register.  The
architecture requires that they are present only when EL1 can be
AArch32, but we implement them unconditionally.  This was OK when all
our CPUs supported AArch32 EL1, but we have quite a lot of CPU models
now which only support AArch64 at EL1:
 a64fx
 cortex-a76
 cortex-a710
 neoverse-n1
 neoverse-n2
 neoverse-v1

Only define these registers for CPUs which allow AArch32 EL1.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231121144605.3980419-1-peter.maydell@linaro.org
---
 target/arm/debug_helper.c | 23 +++++++++++++++--------
 target/arm/helper.c       | 35 +++++++++++++++++++++--------------
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index cbfba532f50..83d2619080f 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -1026,14 +1026,6 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
       .cp = 14, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tda,
       .type = ARM_CP_NOP },
-    /*
-     * Dummy DBGVCR32_EL2 (which is only for a 64-bit hypervisor
-     * to save and restore a 32-bit guest's DBGVCR)
-     */
-    { .name = "DBGVCR32_EL2", .state = ARM_CP_STATE_AA64,
-      .opc0 = 2, .opc1 = 4, .crn = 0, .crm = 7, .opc2 = 0,
-      .access = PL2_RW, .accessfn = access_tda,
-      .type = ARM_CP_NOP | ARM_CP_EL3_NO_EL2_KEEP },
     /*
      * Dummy MDCCINT_EL1, since we don't implement the Debug Communications
      * Channel but Linux may try to access this register. The 32-bit
@@ -1062,6 +1054,18 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.dbgclaim) },
 };
 
+/* These are present only when EL1 supports AArch32 */
+static const ARMCPRegInfo debug_aa32_el1_reginfo[] = {
+    /*
+     * Dummy DBGVCR32_EL2 (which is only for a 64-bit hypervisor
+     * to save and restore a 32-bit guest's DBGVCR)
+     */
+    { .name = "DBGVCR32_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 2, .opc1 = 4, .crn = 0, .crm = 7, .opc2 = 0,
+      .access = PL2_RW, .accessfn = access_tda,
+      .type = ARM_CP_NOP | ARM_CP_EL3_NO_EL2_KEEP },
+};
+
 static const ARMCPRegInfo debug_lpae_cp_reginfo[] = {
     /* 64 bit access versions of the (dummy) debug registers */
     { .name = "DBGDRAR", .cp = 14, .crm = 1, .opc1 = 0,
@@ -1207,6 +1211,9 @@ void define_debug_regs(ARMCPU *cpu)
     assert(ctx_cmps <= brps);
 
     define_arm_cp_regs(cpu, debug_cp_reginfo);
+    if (cpu_isar_feature(aa64_aa32_el1, cpu)) {
+        define_arm_cp_regs(cpu, debug_aa32_el1_reginfo);
+    }
 
     if (arm_feature(&cpu->env, ARM_FEATURE_LPAE)) {
         define_arm_cp_regs(cpu, debug_lpae_cp_reginfo);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2746d3fdac8..39830c7f948 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5698,20 +5698,6 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 2, .opc2 = 0,
       .type = ARM_CP_NO_RAW,
       .access = PL1_RW, .readfn = spsel_read, .writefn = spsel_write },
-    { .name = "FPEXC32_EL2", .state = ARM_CP_STATE_AA64,
-      .opc0 = 3, .opc1 = 4, .crn = 5, .crm = 3, .opc2 = 0,
-      .access = PL2_RW,
-      .type = ARM_CP_ALIAS | ARM_CP_FPU | ARM_CP_EL3_NO_EL2_KEEP,
-      .fieldoffset = offsetof(CPUARMState, vfp.xregs[ARM_VFP_FPEXC]) },
-    { .name = "DACR32_EL2", .state = ARM_CP_STATE_AA64,
-      .opc0 = 3, .opc1 = 4, .crn = 3, .crm = 0, .opc2 = 0,
-      .access = PL2_RW, .resetvalue = 0, .type = ARM_CP_EL3_NO_EL2_KEEP,
-      .writefn = dacr_write, .raw_writefn = raw_write,
-      .fieldoffset = offsetof(CPUARMState, cp15.dacr32_el2) },
-    { .name = "IFSR32_EL2", .state = ARM_CP_STATE_AA64,
-      .opc0 = 3, .opc1 = 4, .crn = 5, .crm = 0, .opc2 = 1,
-      .access = PL2_RW, .resetvalue = 0, .type = ARM_CP_EL3_NO_EL2_KEEP,
-      .fieldoffset = offsetof(CPUARMState, cp15.ifsr32_el2) },
     { .name = "SPSR_IRQ", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 3, .opc2 = 0,
@@ -5746,6 +5732,24 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .fieldoffset = offsetoflow32(CPUARMState, cp15.mdcr_el3) },
 };
 
+/* These are present only when EL1 supports AArch32 */
+static const ARMCPRegInfo v8_aa32_el1_reginfo[] = {
+    { .name = "FPEXC32_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 5, .crm = 3, .opc2 = 0,
+      .access = PL2_RW,
+      .type = ARM_CP_ALIAS | ARM_CP_FPU | ARM_CP_EL3_NO_EL2_KEEP,
+      .fieldoffset = offsetof(CPUARMState, vfp.xregs[ARM_VFP_FPEXC]) },
+    { .name = "DACR32_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 3, .crm = 0, .opc2 = 0,
+      .access = PL2_RW, .resetvalue = 0, .type = ARM_CP_EL3_NO_EL2_KEEP,
+      .writefn = dacr_write, .raw_writefn = raw_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.dacr32_el2) },
+    { .name = "IFSR32_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 5, .crm = 0, .opc2 = 1,
+      .access = PL2_RW, .resetvalue = 0, .type = ARM_CP_EL3_NO_EL2_KEEP,
+      .fieldoffset = offsetof(CPUARMState, cp15.ifsr32_el2) },
+};
+
 static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -8716,6 +8720,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         }
         define_arm_cp_regs(cpu, v8_idregs);
         define_arm_cp_regs(cpu, v8_cp_reginfo);
+        if (cpu_isar_feature(aa64_aa32_el1, cpu)) {
+            define_arm_cp_regs(cpu, v8_aa32_el1_reginfo);
+        }
 
         for (i = 4; i < 16; i++) {
             /*
-- 
2.34.1


