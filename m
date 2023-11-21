Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9977F3188
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 15:48:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5S16-0000Ig-K8; Tue, 21 Nov 2023 09:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5S0x-0000IC-SU
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 09:46:14 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5S0u-0000mx-3d
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 09:46:11 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32f8441dfb5so4346880f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 06:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700577966; x=1701182766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z/Q0Ze2x0fQAFBtYAYpPfU903dcHJSY8SIbcnM+aFf8=;
 b=IybLorbYvvGgpeOErkXwOJ4pit3j75PI03VFLK5oMxfehRRMtPARpTqPDPeek0Pt0m
 tZIcgFYGVpFM3Sq8X39/9B/Gz0usnWXUxXv6Wz4N0Ifxsh5H00PoBsxsZs2uJ1Pk4tqy
 S5MWPcNOWCpwbRfeC2U9sFhnLLS38mCF8Mg3xsbvqAeKumBwXaq29GVEuUDLjqUbo0kA
 cv2meTzC+1wLSan9n4EI/SUkivynNYXI+8eUzJlav+dWFLnCgR3i4YY571X4PLUsO2Cc
 shSML4uCJsI3SVYMbd4wGaDlmkHkNov5SGcNAxLxcTp5Jxhm3HhFIoeme4uPpjgm5fvR
 EdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700577966; x=1701182766;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z/Q0Ze2x0fQAFBtYAYpPfU903dcHJSY8SIbcnM+aFf8=;
 b=IktRoyubf3pqD63y32kvy0akZn9vUGufH/WY3SfSl/7gja+PcVGgdDQ9BQpVriqjQC
 UuFuQYOWbT93BzbrqjzmM9o3aJKE9yxU5C1bfCjl8czUiFBUQ4CLbunylYJOX9brniUv
 5YUFPL2Vu2N+7do5Dl96BFymVsw6jtRnWa/S/ydV6HQKwlKNtC+qgO+HLYZ5S3aWh22q
 6owv46BdHneIWaoQab79wB2C0sYSVCyWcQIkhVdHffdS4EbOuH+mmFAH3wYXSk+hwCho
 /ZFQF8WDUxPH6Ts1A92/LcWcuyvt07Z+RJDedxympIIa3f8MuLFZ+fKLi4Ni65hxOvfF
 Oq/A==
X-Gm-Message-State: AOJu0Yw0u0McKEFXMXQXmP1K4Z+EYLX6p0MiiF/zUQ2y20Q6v6GtUdH6
 wrjuJ4u/EdtxtTc/Zdalb/AMUUL1GPmA2rV9xOA=
X-Google-Smtp-Source: AGHT+IEtRsjoJZJyuuN9bOzJcq6GeSc9QAUh5UTj+1Zuji4Iw/Plbl4Cn+yCLEMkuLQrhbcL62+DTw==
X-Received: by 2002:a05:6000:43:b0:32f:c3d0:89db with SMTP id
 k3-20020a056000004300b0032fc3d089dbmr7218859wrx.27.1700577966334; 
 Tue, 21 Nov 2023 06:46:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a5d644a000000b003316db2d48dsm12911463wrw.34.2023.11.21.06.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 06:46:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Don't implement *32_EL2 registers when EL1 is
 AArch64 only
Date: Tue, 21 Nov 2023 14:46:05 +0000
Message-Id: <20231121144605.3980419-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
---
I happened to notice this reading through the Arm ARM recently.  This
is technically a bug, but you'll only notice it if you deliberately
look at what should be an unimplemented register to see if it UNDEFs,
so I don't think it's worth either putting in 8.2 or backporting to
stable.
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
index ff1970981ee..bf26b995171 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5681,20 +5681,6 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
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
@@ -5729,6 +5715,24 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
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
@@ -8699,6 +8703,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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


