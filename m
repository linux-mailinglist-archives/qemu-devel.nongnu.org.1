Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A759D74723E
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:07:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfkB-0001SR-6E; Tue, 04 Jul 2023 09:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGfk7-0001RV-6O
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:06:55 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGfk5-0003Uo-11
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:06:54 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso4145132f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688476011; x=1691068011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=72OiX3Zm/JYZBpPMQQv+TlFgGKVlYsjEoawtRhhrRGU=;
 b=GLLc/0I+xIHy9hA7VyX5GNms7xbDhgKZl68wGH+TlN9hFOqr476xVRyCOOW1gX+vzQ
 HWu850xE5v797niiIsDtpK0ay5LoNeO1Xhn7OiDL3k2Pims1NdDHdO4zBFT2IOXfDkWg
 6PswGtnwASZv7AFvM9jX8zGuuGPs6V6vxaQmHHGcRAG5u77y4oUziaTpMfY0jZBtX3RO
 pYMVzXIzpASLqquXNQVsDa754UUiJjxDC0O2qk4RzSzSI7O5FiXjYCcLFTNGu2kjnS+Z
 7r1W3HjJSe2Wbdm0TBkypFBOQBomZInAyM9kcAHJfclhaF5NFi5aNsUafvn/V6BdKJfC
 135Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688476011; x=1691068011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=72OiX3Zm/JYZBpPMQQv+TlFgGKVlYsjEoawtRhhrRGU=;
 b=jl74C6+buTs4pWnbx+t5XZiiR88eFsdszTYeh2eBo343+TkvAtrh3QmpY/wUpptSti
 la+qYyzhkfPY7SfkC7g+tP1PRQEjEDVo/shPkj17SrOT4bMdzbunLJnQpBVM7rqyXsss
 W2MPs5VwBLoircuAf6EO8v37sHR+9Qpy9pObnWO9U/2V2PqH2/XfUdN969eA4+vlb3iJ
 roB6OlxHP5OeBcysamNc1fiVPRUh7sPEPvJiTGMdxn0u7HFMLu3sJL58XjdgzEv+aD/v
 Mj/qIiP7Dq2uCXtLZnrRgp4hfy97cEgkw2j/kSfbmiXF4qM10w9vPbU8C6PYXRkXA59l
 1zFg==
X-Gm-Message-State: ABy/qLZ/VXgOGIG47LqjY5HgDSl5X3AOAZbBxVpN7D08pmRUze0lH8bF
 slvW5kEpPrpOpt5JnK8HA9p4FA7RIWgKogoUIMc=
X-Google-Smtp-Source: APBJJlEWlG8MoyZmQRb7bgFRiKoTnQdhUKHp7bAggKuGf5IoCJDVlvUX+95LIe8GPLBp1Jd/itYqYg==
X-Received: by 2002:adf:fe8f:0:b0:314:183f:7ac0 with SMTP id
 l15-20020adffe8f000000b00314183f7ac0mr11251869wrr.43.1688476011636; 
 Tue, 04 Jul 2023 06:06:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a10-20020adfeeca000000b00314103d6daesm15834737wrp.47.2023.07.04.06.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 06:06:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/arm: Define neoverse-v1
Date: Tue,  4 Jul 2023 14:06:47 +0100
Message-Id: <20230704130647.2842917-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704130647.2842917-1-peter.maydell@linaro.org>
References: <20230704130647.2842917-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Now that we have implemented support for FEAT_LSE2, we can define
a CPU model for the Neoverse-V1, and enable it for the virt and
sbsa-ref boards.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
If you're checking the values against the TRM, note that the
summary tables differ from the register description in the TRM
for ID_AA64DFR0_EL1, ID_AA64ZFR0_EL1 and ID_PFR0_EL1: we
trust the versions in the register descriptions. Also the
MIDR value in the r1p2 TRM isn't updated from r1p1.
The CCSIDR_EL1 values in the TRM unfortunately seem to be wrong:
the comment in the patch describes how I've calculated the
values used here.

I've stuck with the existing approach for aarch64_add_*_properties
in the interests of getting this in before softfreeze, though
there does seem like there ought to be a workable refactoring
there somewhere.
---
 docs/system/arm/virt.rst |   1 +
 hw/arm/sbsa-ref.c        |   1 +
 hw/arm/virt.c            |   1 +
 target/arm/tcg/cpu64.c   | 128 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 131 insertions(+)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 1cab33f02e3..51cdac68410 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -61,6 +61,7 @@ Supported guest CPU types:
 - ``a64fx`` (64-bit)
 - ``host`` (with KVM only)
 - ``neoverse-n1`` (64-bit)
+- ``neoverse-v1`` (64-bit)
 - ``max`` (same as ``host`` for KVM; best possible emulation with TCG)
 
 Note that the default is ``cortex-a15``, so for an AArch64 guest you must
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 0639f97dd5f..f0857198983 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -150,6 +150,7 @@ static const char * const valid_cpus[] = {
     ARM_CPU_TYPE_NAME("cortex-a57"),
     ARM_CPU_TYPE_NAME("cortex-a72"),
     ARM_CPU_TYPE_NAME("neoverse-n1"),
+    ARM_CPU_TYPE_NAME("neoverse-v1"),
     ARM_CPU_TYPE_NAME("max"),
 };
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9b9f7d9c687..20b134fe477 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -213,6 +213,7 @@ static const char *valid_cpus[] = {
     ARM_CPU_TYPE_NAME("cortex-a76"),
     ARM_CPU_TYPE_NAME("a64fx"),
     ARM_CPU_TYPE_NAME("neoverse-n1"),
+    ARM_CPU_TYPE_NAME("neoverse-v1"),
 #endif
     ARM_CPU_TYPE_NAME("cortex-a53"),
     ARM_CPU_TYPE_NAME("cortex-a57"),
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 6fec2d8a57a..6b8e8461f54 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -502,6 +502,31 @@ static void define_neoverse_n1_cp_reginfo(ARMCPU *cpu)
     define_arm_cp_regs(cpu, neoverse_n1_cp_reginfo);
 }
 
+static const ARMCPRegInfo neoverse_v1_cp_reginfo[] = {
+    { .name = "CPUECTLR2_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 1, .opc2 = 5,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "CPUPPMCR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 2, .opc2 = 0,
+      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "CPUPPMCR2_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 2, .opc2 = 1,
+      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "CPUPPMCR3_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 2, .opc2 = 6,
+      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+};
+
+static void define_neoverse_v1_cp_reginfo(ARMCPU *cpu)
+{
+    /*
+     * The Neoverse V1 has all of the Neoverse N1's IMPDEF
+     * registers and a few more of its own.
+     */
+    define_arm_cp_regs(cpu, neoverse_n1_cp_reginfo);
+    define_arm_cp_regs(cpu, neoverse_v1_cp_reginfo);
+}
+
 static void aarch64_neoverse_n1_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -573,6 +598,108 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     define_neoverse_n1_cp_reginfo(cpu);
 }
 
+static void aarch64_neoverse_v1_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    cpu->dtb_compatible = "arm,neoverse-v1";
+    set_feature(&cpu->env, ARM_FEATURE_V8);
+    set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
+    set_feature(&cpu->env, ARM_FEATURE_EL2);
+    set_feature(&cpu->env, ARM_FEATURE_EL3);
+    set_feature(&cpu->env, ARM_FEATURE_PMU);
+
+    /* Ordered by 3.2.4 AArch64 registers by functional group */
+    cpu->clidr = 0x82000023;
+    cpu->ctr = 0xb444c004; /* With DIC and IDC set */
+    cpu->dcz_blocksize = 4;
+    cpu->id_aa64afr0 = 0x00000000;
+    cpu->id_aa64afr1 = 0x00000000;
+    cpu->isar.id_aa64dfr0  = 0x000001f210305519ull;
+    cpu->isar.id_aa64dfr1 = 0x00000000;
+    cpu->isar.id_aa64isar0 = 0x1011111110212120ull; /* with FEAT_RNG */
+    cpu->isar.id_aa64isar1 = 0x0111000001211032ull;
+    cpu->isar.id_aa64mmfr0 = 0x0000000000101125ull;
+    cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
+    cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
+    cpu->isar.id_aa64pfr0  = 0x1101110120111112ull; /* GIC filled in later */
+    cpu->isar.id_aa64pfr1  = 0x0000000000000020ull;
+    cpu->id_afr0       = 0x00000000;
+    cpu->isar.id_dfr0  = 0x15011099;
+    cpu->isar.id_isar0 = 0x02101110;
+    cpu->isar.id_isar1 = 0x13112111;
+    cpu->isar.id_isar2 = 0x21232042;
+    cpu->isar.id_isar3 = 0x01112131;
+    cpu->isar.id_isar4 = 0x00010142;
+    cpu->isar.id_isar5 = 0x11011121;
+    cpu->isar.id_isar6 = 0x01100111;
+    cpu->isar.id_mmfr0 = 0x10201105;
+    cpu->isar.id_mmfr1 = 0x40000000;
+    cpu->isar.id_mmfr2 = 0x01260000;
+    cpu->isar.id_mmfr3 = 0x02122211;
+    cpu->isar.id_mmfr4 = 0x01021110;
+    cpu->isar.id_pfr0  = 0x21110131;
+    cpu->isar.id_pfr1  = 0x00010000; /* GIC filled in later */
+    cpu->isar.id_pfr2  = 0x00000011;
+    cpu->midr = 0x411FD402;          /* r1p2 */
+    cpu->revidr = 0;
+
+    /*
+     * The Neoverse-V1 r1p2 TRM lists 32-bit format CCSIDR_EL1 values,
+     * but also says it implements CCIDX, which means they should be
+     * 64-bit format. So we here use values which are based on the textual
+     * information in chapter 2 of the TRM (and on the fact that
+     * sets * associativity * linesize == cachesize).
+     *
+     * The 64-bit CCSIDR_EL1 format is:
+     *   [55:32] number of sets - 1
+     *   [23:3]  associativity - 1
+     *   [2:0]   log2(linesize) - 4
+     *           so 0 == 16 bytes, 1 == 32 bytes, 2 == 64 bytes, etc
+     *
+     * L1: 4-way set associative 64-byte line size, total size 64K,
+     * so sets is 256.
+     *
+     * L2: 8-way set associative, 64 byte line size, either 512K or 1MB.
+     * We pick 1MB, so this has 2048 sets.
+     *
+     * L3: No L3 (this matches the CLIDR_EL1 value).
+     */
+    cpu->ccsidr[0] = 0x000000ff0000001aull; /* 64KB L1 dcache */
+    cpu->ccsidr[1] = 0x000000ff0000001aull; /* 64KB L1 icache */
+    cpu->ccsidr[2] = 0x000007ff0000003aull; /* 1MB L2 cache */
+
+    /* From 3.2.115 SCTLR_EL3 */
+    cpu->reset_sctlr = 0x30c50838;
+
+    /* From 3.4.8 ICC_CTLR_EL3 and 3.4.23 ICH_VTR_EL2 */
+    cpu->gic_num_lrs = 4;
+    cpu->gic_vpribits = 5;
+    cpu->gic_vprebits = 5;
+    cpu->gic_pribits = 5;
+
+    /* From 3.5.1 AdvSIMD AArch64 register summary */
+    cpu->isar.mvfr0 = 0x10110222;
+    cpu->isar.mvfr1 = 0x13211111;
+    cpu->isar.mvfr2 = 0x00000043;
+
+    /* From 3.7.5 ID_AA64ZFR0_EL1 */
+    cpu->isar.id_aa64zfr0 = 0x0000100000100000;
+    cpu->sve_vq.supported = (1 << 0)  /* 128bit */
+                            | (1 << 1);  /* 256bit */
+
+    /* From 5.5.1 AArch64 PMU register summary */
+    cpu->isar.reset_pmcr_el0 = 0x41213000;
+
+    define_neoverse_v1_cp_reginfo(cpu);
+
+    aarch64_add_pauth_properties(obj);
+    aarch64_add_sve_properties(obj);
+}
+
 /*
  * -cpu max: a CPU with as many features enabled as our emulation supports.
  * The version of '-cpu max' for qemu-system-arm is defined in cpu32.c;
@@ -763,6 +890,7 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a76",         .initfn = aarch64_a76_initfn },
     { .name = "a64fx",              .initfn = aarch64_a64fx_initfn },
     { .name = "neoverse-n1",        .initfn = aarch64_neoverse_n1_initfn },
+    { .name = "neoverse-v1",        .initfn = aarch64_neoverse_v1_initfn },
 };
 
 static void aarch64_cpu_register_types(void)
-- 
2.34.1


