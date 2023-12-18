Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CACA816C44
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:34:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBs2-0006Xt-JH; Mon, 18 Dec 2023 06:33:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs0-0006Wa-SD
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:12 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBrx-0003H2-9N
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:12 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40c31f18274so35454445e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899187; x=1703503987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SnG0PeEkl3mljhE/7fINvl5kXhOpcofwqugvUBbBLDU=;
 b=nLwdacvJD3ViFui3Bhc7gb8IepM/Ydj8Hm1btqwLHLpzAhfG54CB/xmgZZM6wB5oDh
 mXfXuqrD3jrENeoyWEMFUerWxx8EQNRISGy3t7t7g02Fj4NQ3cG0nuCDmTNrFJ8o0bgl
 i5MGWe85zHK3kYU01odw2xOFwGuvxoYxw0xemEuQbzVZ78lxEjC9LgzJcfdwOhHfBN9T
 Ecbjf/DHHQCzr9o5vpbzEluKqNnFaJXj3sH3sPwRfpegGE75x1rcpCxZAplnZ2XHIcv9
 oe8+InSQRdHuiNq1jTr0tRzWf2/NtDsxu21m/Vt99seR6Pbf4gPzp5wHNNA9j7Ipj6VZ
 s9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899187; x=1703503987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SnG0PeEkl3mljhE/7fINvl5kXhOpcofwqugvUBbBLDU=;
 b=uAnDokMVNKKyQZsAdlPS0XQ/Iwu0NRIxJWnBLw1n3SbAXno9TmKvDpR3p+4hi5g4aT
 2wlw8kpPY5njmNlEO2XUONZ0WSIvHkV1zKLBEFif9UqRoyZiBsO2OBWT7rNT1mpe6WGB
 R33BfY71f0FO/+kHAJaghh8lrba0JBhwZ61QT7+Dlk7XTJFDW8GA7pdwsy3N1RH/JZKB
 2Q5pgUceKJqRKZpLLyOOsDCFzZsZT/p9Y0BF6xG+JeEGNhcTY7R9OtROQztgCZSdOc7r
 4hoiTF9b6HRx+kMhgZfLLfJx1yhupPUoCbQJpvrwlwBJqES2rXwEsK1AA7u0Wtk5uJ0J
 gBwA==
X-Gm-Message-State: AOJu0Ywl2gDDPNu/A5femF9XqXse9JAUF4k+y18DhxA27yRWY5+K+UTH
 QrKC/b0+61qUysO75Mafokmmldj/3nYYXgGU1Bo=
X-Google-Smtp-Source: AGHT+IH6sWkNc8hPtCbdMxaC4lS5UCL05lpagr7wtJwl1zgAfysMmx/0XrEqERBnKGyyUo6AGdNTzg==
X-Received: by 2002:a05:600c:181b:b0:40c:3dce:b02c with SMTP id
 n27-20020a05600c181b00b0040c3dceb02cmr7678930wmp.156.1702899187245; 
 Mon, 18 Dec 2023 03:33:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/35] target/arm: Don't implement *32_EL2 registers when EL1
 is AArch64 only
Date: Mon, 18 Dec 2023 11:32:31 +0000
Message-Id: <20231218113305.2511480-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
AArch32, but we implement them unconditionally. This was OK when
all our CPUs supported AArch32 EL1, but we have quite a lot of
CPU models now which only support AArch64 at EL1:
 a64fx
 cortex-a76
 cortex-a710
 neoverse-n1
 neoverse-n2
 neoverse-v1

Only define these registers for CPUs which allow AArch32 EL1.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


