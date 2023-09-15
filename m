Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E39E7A26A3
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 20:55:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhDyS-0000Wp-S4; Fri, 15 Sep 2023 14:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qhDy9-0000OQ-AQ
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 14:55:11 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qhDxy-00063Z-HP
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 14:55:03 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-404573e6c8fso23551205e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 11:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694804096; x=1695408896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5R4zE8heAJ76w0EEJu7tUdeCBxBgPEWGUttS6DVMkwI=;
 b=Mmgi9dlDmv1kCXf8gRsc1UKFuFj4aStPWiM9Q6vGM90WDi2kuwLs4CyTTft9hCXqyX
 3tI0ez9LQPUE9iA+0b7S/82kKXCB6AmVgAX/Nmxig2iYTbcNQubGO3F0sXNgDfYbQs89
 cIhlOktDH3qWczbRZuZ0jw6wpfLncWnmCOikeCFYmVOULsADHiwuwtMLcOZcO68uViB2
 c9X/LkQdRzajhYD+ynphesAoLQVTViMOyjpJFK6aIXiC4+Sp3s0qCOvwFrtszhkI1SoX
 ibKMLSuxHq55+u5z8FIYbmb3xT+UWe9dXzcx/OpzIWAlqadxVkIMiwy5Sw9rcsJKAZd/
 i/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694804096; x=1695408896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5R4zE8heAJ76w0EEJu7tUdeCBxBgPEWGUttS6DVMkwI=;
 b=wv8QM6MjrUfMXySYxdNB+C0EEEwR+C6xu42HiCFgu8kcKEOo+0DPzwRZuePSe6hyZW
 QcSk3QIRQqkHAMZKeSeec/aARXmOT0luSkwZWrkwZZ1zty1plEnhrgUfSbsKSg9J5LqF
 LECzYIn2YfpdrsIZZ0Rsam95Omiw9OykHCf0eTAmjxOik/LomQPqZxwSm7NQwu+1g0dd
 KkvIReCEKGb45UjMdcmVSDTaeSnK67v147oJzrBXkbpRD89O48ch4w2khLOg/mRB7pqu
 0OuCiQbciudgKvDT+947qMsu1wabW9GBbV4ecXI9QfDW/I9APC2OnNBbjX8/AhvvGKcd
 aKXQ==
X-Gm-Message-State: AOJu0Ywa9zfwnJaaW9sSrt6AgGRCd1aQ/KSICcFnvlH3SwzoGbYw66zK
 q5JT5drpmIesHQH1krhn2yXPpw==
X-Google-Smtp-Source: AGHT+IFZltuStAIOIcZc/6GiDiMlAY7c6kRm5z4cRWXROiEWMkr8GlXvZJyDIt9n+tgjFw0Nsrkwlw==
X-Received: by 2002:a7b:c4c8:0:b0:3fe:16c8:65fa with SMTP id
 g8-20020a7bc4c8000000b003fe16c865famr2119414wmk.4.1694804096451; 
 Fri, 15 Sep 2023 11:54:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n12-20020a05600c294c00b003fee777fd84sm5298849wmd.41.2023.09.15.11.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 11:54:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH 2/2] target/arm: Implement Neoverse N2 CPU model
Date: Fri, 15 Sep 2023 19:54:53 +0100
Message-Id: <20230915185453.1871167-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915185453.1871167-1-peter.maydell@linaro.org>
References: <20230915185453.1871167-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
index bc89eb48062..4db287287e1 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -154,6 +154,7 @@ static const char * const valid_cpus[] = {
     ARM_CPU_TYPE_NAME("cortex-a72"),
     ARM_CPU_TYPE_NAME("neoverse-n1"),
     ARM_CPU_TYPE_NAME("neoverse-v1"),
+    ARM_CPU_TYPE_NAME("neoverse-n2"),
     ARM_CPU_TYPE_NAME("max"),
 };
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8ad78b23c24..42253462735 100644
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
index ea43cf3c1ee..370cc82f0ef 100644
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
@@ -1159,6 +1261,7 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "a64fx",              .initfn = aarch64_a64fx_initfn },
     { .name = "neoverse-n1",        .initfn = aarch64_neoverse_n1_initfn },
     { .name = "neoverse-v1",        .initfn = aarch64_neoverse_v1_initfn },
+    { .name = "neoverse-n2",        .initfn = aarch64_neoverse_n2_initfn },
 };
 
 static void aarch64_cpu_register_types(void)
-- 
2.34.1


