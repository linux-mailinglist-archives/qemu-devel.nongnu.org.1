Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B43F17D9BBF
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:42:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO09-0007D2-4Q; Fri, 27 Oct 2023 10:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO06-0007Bn-Ed
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:50 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO02-00086i-PZ
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:50 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-507e85ebf50so2969072e87.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417585; x=1699022385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mg9LXkIXVFbs5hMcYb96J18lF0/IET+BXp3TCRouZa4=;
 b=MYI+IRDuO0YCZtADJ31ZcZe9eMR9T8i3h5QrmApycfj9n57PN95a9n+9eCmeT7sEZt
 Ee1zNXWH61n6pemg/NyEsEI7AuUCS0eKbJdX4f0qiJFpmVCnywMhkzIlMK65bzJtdIib
 /DxnbFg1RNuJPtigj3DqTe/L+XnMxTY5hB/O0ZPvzL9gNNR6d5XtrvMlvGJFKsaRPeIv
 ksEiJxdB+ZCjA/JpiT8flMxdVkNeri0CSBilZtVQ577+Pn8wTMa0EysFhHYt473oZqFp
 xIaGq6gX1AXFPCuJc1kwESrQYL1ZtYdpHsl3Mx8otsfFQ1nN1qrRPzbXRRqfBpZId6GE
 Xs4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417585; x=1699022385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mg9LXkIXVFbs5hMcYb96J18lF0/IET+BXp3TCRouZa4=;
 b=i2Mab4HZqvxeqgpo3mfGyY/C1TCsAhVbbuO+JIR8aBILkTWs8fgs924YeN9Z9w1Hxn
 qSrv8QjYrJ7+BwfjA9uOzQz4zz6jxZIXT4OgfpDXguWgEW5b4MKnCd+/1XcNinpARdis
 bUi1stMPN+d1UjwQpJqH/TMR8uQlfRs0ooVRx7wfsm0G13ZtBzSpX1E4Jivd0yR3wRNk
 mY3D50AxVXwa7hGtD601uDVVSvWF1jfYOQb1vpWeQ6Hbe5e5Obf4wXp8TI7/2Y+sIkgp
 7XaQ/hXJin07zBTFMup+Yv05lxsAEYYjiLT7S/sn8UADugvBzV46vO1pW6bLpWerX33u
 CAng==
X-Gm-Message-State: AOJu0YwQ8dVRkoI+prlxc/MYlpq0pgjOrpeGh6Tdgr+yANDYrAYGD4ul
 BKfCo4Q0kPSMqac/GwLHuwaJLyhQlL7b9M0uQ8U=
X-Google-Smtp-Source: AGHT+IHUJ3Y9C5R3I7behpuWNCWsOV8ye3/wmL7GGZNSq6wAU5wWyoXaoqVi6/p7/09Xp8HqFaDcdA==
X-Received: by 2002:ac2:4a67:0:b0:507:a58f:622d with SMTP id
 q7-20020ac24a67000000b00507a58f622dmr1880012lfp.50.1698417584860; 
 Fri, 27 Oct 2023 07:39:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/41] target/arm: Implement Neoverse N2 CPU model
Date: Fri, 27 Oct 2023 15:39:03 +0100
Message-Id: <20231027143942.3413881-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

Implement a model of the Neoverse N2 CPU. This is an Armv9.0-A
processor very similar to the Cortex-A710. The differences are:
 * no FEAT_EVT
 * FEAT_DGH (data gathering hint)
 * FEAT_NV (not yet implemented in QEMU)
 * Statistical Profiling Extension (not implemented in QEMU)
 * 48 bit physical address range, not 40
 * CTR_EL0.DIC = 1 (no explicit icache cleaning needed)
 * PMCR_EL0.N = 6 (always 6 PMU counters, not 20)

Because it has 48-bit physical address support, we can use
this CPU in the sbsa-ref board as well as the virt board.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20230915185453.1871167-3-peter.maydell@linaro.org
---
 docs/system/arm/virt.rst |   1 +
 hw/arm/sbsa-ref.c        |   1 +
 hw/arm/virt.c            |   1 +
 target/arm/tcg/cpu64.c   | 103 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index e1697ac8f48..7c4c80180c6 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -63,6 +63,7 @@ Supported guest CPU types:
 - ``host`` (with KVM only)
 - ``neoverse-n1`` (64-bit)
 - ``neoverse-v1`` (64-bit)
+- ``neoverse-n2`` (64-bit)
 - ``max`` (same as ``host`` for KVM; best possible emulation with TCG)
 
 Note that the default is ``cortex-a15``, so for an AArch64 guest you must
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e8a82618f0a..bce44690e5e 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -149,6 +149,7 @@ static const char * const valid_cpus[] = {
     ARM_CPU_TYPE_NAME("cortex-a72"),
     ARM_CPU_TYPE_NAME("neoverse-n1"),
     ARM_CPU_TYPE_NAME("neoverse-v1"),
+    ARM_CPU_TYPE_NAME("neoverse-n2"),
     ARM_CPU_TYPE_NAME("max"),
 };
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 529f1c089c0..92085d2d8fb 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -215,6 +215,7 @@ static const char *valid_cpus[] = {
     ARM_CPU_TYPE_NAME("a64fx"),
     ARM_CPU_TYPE_NAME("neoverse-n1"),
     ARM_CPU_TYPE_NAME("neoverse-v1"),
+    ARM_CPU_TYPE_NAME("neoverse-n2"),
 #endif
     ARM_CPU_TYPE_NAME("cortex-a53"),
     ARM_CPU_TYPE_NAME("cortex-a57"),
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index e2bcac48549..a9a8c0a0592 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -963,6 +963,108 @@ static void aarch64_a710_initfn(Object *obj)
     aarch64_add_sve_properties(obj);
 }
 
+/* Extra IMPDEF regs in the N2 beyond those in the A710 */
+static const ARMCPRegInfo neoverse_n2_cp_reginfo[] = {
+    { .name = "CPURNDBR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 3, .opc2 = 0,
+      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "CPURNDPEID_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 3, .opc2 = 1,
+      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+};
+
+static void aarch64_neoverse_n2_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    cpu->dtb_compatible = "arm,neoverse-n2";
+    set_feature(&cpu->env, ARM_FEATURE_V8);
+    set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
+    set_feature(&cpu->env, ARM_FEATURE_EL2);
+    set_feature(&cpu->env, ARM_FEATURE_EL3);
+    set_feature(&cpu->env, ARM_FEATURE_PMU);
+
+    /* Ordered by Section B.5: AArch64 ID registers */
+    cpu->midr          = 0x410FD493; /* r0p3 */
+    cpu->revidr        = 0;
+    cpu->isar.id_pfr0  = 0x21110131;
+    cpu->isar.id_pfr1  = 0x00010000; /* GIC filled in later */
+    cpu->isar.id_dfr0  = 0x16011099;
+    cpu->id_afr0       = 0;
+    cpu->isar.id_mmfr0 = 0x10201105;
+    cpu->isar.id_mmfr1 = 0x40000000;
+    cpu->isar.id_mmfr2 = 0x01260000;
+    cpu->isar.id_mmfr3 = 0x02122211;
+    cpu->isar.id_isar0 = 0x02101110;
+    cpu->isar.id_isar1 = 0x13112111;
+    cpu->isar.id_isar2 = 0x21232042;
+    cpu->isar.id_isar3 = 0x01112131;
+    cpu->isar.id_isar4 = 0x00010142;
+    cpu->isar.id_isar5 = 0x11011121; /* with Crypto */
+    cpu->isar.id_mmfr4 = 0x01021110;
+    cpu->isar.id_isar6 = 0x01111111;
+    cpu->isar.mvfr0    = 0x10110222;
+    cpu->isar.mvfr1    = 0x13211111;
+    cpu->isar.mvfr2    = 0x00000043;
+    cpu->isar.id_pfr2  = 0x00000011;
+    cpu->isar.id_aa64pfr0  = 0x1201111120111112ull; /* GIC filled in later */
+    cpu->isar.id_aa64pfr1  = 0x0000000000000221ull;
+    cpu->isar.id_aa64zfr0  = 0x0000110100110021ull; /* with Crypto */
+    cpu->isar.id_aa64dfr0  = 0x000011f210305619ull;
+    cpu->isar.id_aa64dfr1  = 0;
+    cpu->id_aa64afr0       = 0;
+    cpu->id_aa64afr1       = 0;
+    cpu->isar.id_aa64isar0 = 0x0221111110212120ull; /* with Crypto */
+    cpu->isar.id_aa64isar1 = 0x0011111101211052ull;
+    cpu->isar.id_aa64mmfr0 = 0x0000022200101125ull;
+    cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
+    cpu->isar.id_aa64mmfr2 = 0x1221011112101011ull;
+    cpu->clidr             = 0x0000001482000023ull;
+    cpu->gm_blocksize      = 4;
+    cpu->ctr               = 0x00000004b444c004ull;
+    cpu->dcz_blocksize     = 4;
+    /* TODO FEAT_MPAM: mpamidr_el1 = 0x0000_0001_001e_01ff */
+
+    /* Section B.7.2: PMCR_EL0 */
+    cpu->isar.reset_pmcr_el0 = 0x3000;  /* with 6 counters */
+
+    /* Section B.8.9: ICH_VTR_EL2 */
+    cpu->gic_num_lrs = 4;
+    cpu->gic_vpribits = 5;
+    cpu->gic_vprebits = 5;
+    cpu->gic_pribits = 5;
+
+    /* Section 14: Scalable Vector Extensions support */
+    cpu->sve_vq.supported = 1 << 0;  /* 128bit */
+
+    /*
+     * The Neoverse N2 TRM does not list CCSIDR values.  The layout of
+     * the caches are in text in Table 7-1, Table 8-1, and Table 9-1.
+     *
+     * L1: 4-way set associative 64-byte line size, total 64K.
+     * L2: 8-way set associative 64 byte line size, total either 512K or 1024K.
+     */
+    cpu->ccsidr[0] = make_ccsidr64(4, 64, 64 * KiB);   /* L1 dcache */
+    cpu->ccsidr[1] = cpu->ccsidr[0];                   /* L1 icache */
+    cpu->ccsidr[2] = make_ccsidr64(8, 64, 512 * KiB);  /* L2 cache */
+
+    /* FIXME: Not documented -- copied from neoverse-v1 */
+    cpu->reset_sctlr = 0x30c50838;
+
+    /*
+     * The Neoverse N2 has all of the Cortex-A710 IMPDEF registers,
+     * and a few more RNG related ones.
+     */
+    define_arm_cp_regs(cpu, cortex_a710_cp_reginfo);
+    define_arm_cp_regs(cpu, neoverse_n2_cp_reginfo);
+
+    aarch64_add_pauth_properties(obj);
+    aarch64_add_sve_properties(obj);
+}
+
 /*
  * -cpu max: a CPU with as many features enabled as our emulation supports.
  * The version of '-cpu max' for qemu-system-arm is defined in cpu32.c;
@@ -1165,6 +1267,7 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "a64fx",              .initfn = aarch64_a64fx_initfn },
     { .name = "neoverse-n1",        .initfn = aarch64_neoverse_n1_initfn },
     { .name = "neoverse-v1",        .initfn = aarch64_neoverse_v1_initfn },
+    { .name = "neoverse-n2",        .initfn = aarch64_neoverse_n2_initfn },
 };
 
 static void aarch64_cpu_register_types(void)
-- 
2.34.1


