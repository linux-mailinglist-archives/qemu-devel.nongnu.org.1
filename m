Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A06A4798B34
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:07:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeewE-0005o3-EX; Fri, 08 Sep 2023 13:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeewB-0005kb-K8
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:31 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevr-00019m-Te
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:30 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-401da71b7c5so26096585e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192770; x=1694797570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Wofvi0Nq2hFBiNxj/Pi061PosJaNyCOvAPP9+pvHsoQ=;
 b=iyKidSp9D3nTRaWrkZmFo9lftS6wQBJ6GC6fd2I/HC5FMtjOiLB1w4xgXWJL9BVw5A
 x9KmbQNrkDd54d6epSNQvfwMV3Uy6vGIeGIYNMpApmIgvEgFg4zoP5iaghhyl0AQfAot
 K9nOfuZvu51BkWmonxN/IKaCGJhEr4MF0KOLEucJk0WBMPczDKM19Ph9AJXW22F4BbA4
 OFWhMiPuB4Z2NNI3H3OW41vvanCv24OIB+dNyx2OW744/4AQoT4saloFbwVC5bCnChPy
 ZVoA998xBQ75kLDvtUVfXU1ZdKM3Wcic3XVMspt3Mb5OkP4KGezSBMBdO8gU+BzzpuB2
 XqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192770; x=1694797570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wofvi0Nq2hFBiNxj/Pi061PosJaNyCOvAPP9+pvHsoQ=;
 b=IX8L6E9FDQ25N6ndYwHc9BSJSnH1ajJVeT+AiZT7q+WsLvnirISDq9YZfKk2bpKw1c
 LvBVgWmNJ+QF9Ob2Lad4enbgBTcJextpYZiD+qtA5Pu0SXbdBIUXlR7E3eU7poAHlJo9
 2Bg484cRvY+o7e8+KPyG/mYad33ONBmG6WyW7euFAS5RseMDRLEYVNvWeY1aKRw0Rj5b
 JsZ4Nv4EV0k803EMD+mbGjAlWEvTP68quC4NwQyqnLqC1Svmj1LEu32OTztTWh/9SkWL
 R20OIfELvjbhY/EhZ/X+6+VnczefS8lhC2GeBDpH9kVLhyP/N5shAi721Xo8pYfMc6eT
 rLFA==
X-Gm-Message-State: AOJu0YzpyYbo8RlEsEshf43CGxmnaqmvY6ehT299KrN54qTl0MIT1Xl0
 mIJqHiiE+gzwI89TODt1VvSta/qMvRFqOp1mblI=
X-Google-Smtp-Source: AGHT+IFf3DtTDuiy5ZYF5QNktE2TuV74EWnrPKpLVa8wi1IyIIPfkKLrciASV09+82OEQ7fJZSQPfw==
X-Received: by 2002:a7b:c051:0:b0:401:6800:7032 with SMTP id
 u17-20020a7bc051000000b0040168007032mr2670681wmc.18.1694192770309; 
 Fri, 08 Sep 2023 10:06:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/26] target/arm: Implement cortex-a710
Date: Fri,  8 Sep 2023 18:05:53 +0100
Message-Id: <20230908170557.773048-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The cortex-a710 is a first generation ARMv9.0-A processor.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230831232441.66020-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/virt.rst |   1 +
 hw/arm/virt.c            |   1 +
 target/arm/tcg/cpu64.c   | 212 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 51cdac68410..e1697ac8f48 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -58,6 +58,7 @@ Supported guest CPU types:
 - ``cortex-a57`` (64-bit)
 - ``cortex-a72`` (64-bit)
 - ``cortex-a76`` (64-bit)
+- ``cortex-a710`` (64-bit)
 - ``a64fx`` (64-bit)
 - ``host`` (with KVM only)
 - ``neoverse-n1`` (64-bit)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a13c658bbf6..8ad78b23c24 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -211,6 +211,7 @@ static const char *valid_cpus[] = {
     ARM_CPU_TYPE_NAME("cortex-a55"),
     ARM_CPU_TYPE_NAME("cortex-a72"),
     ARM_CPU_TYPE_NAME("cortex-a76"),
+    ARM_CPU_TYPE_NAME("cortex-a710"),
     ARM_CPU_TYPE_NAME("a64fx"),
     ARM_CPU_TYPE_NAME("neoverse-n1"),
     ARM_CPU_TYPE_NAME("neoverse-v1"),
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index ef222da57d4..6e5192ebfc3 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -745,6 +745,217 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     aarch64_add_sve_properties(obj);
 }
 
+static const ARMCPRegInfo cortex_a710_cp_reginfo[] = {
+    { .name = "CPUACTLR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 1, .opc2 = 0,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0,
+      .accessfn = access_actlr_w },
+    { .name = "CPUACTLR2_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 1, .opc2 = 1,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0,
+      .accessfn = access_actlr_w },
+    { .name = "CPUACTLR3_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 1, .opc2 = 2,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0,
+      .accessfn = access_actlr_w },
+    { .name = "CPUACTLR4_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 1, .opc2 = 3,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0,
+      .accessfn = access_actlr_w },
+    { .name = "CPUECTLR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 1, .opc2 = 4,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0,
+      .accessfn = access_actlr_w },
+    { .name = "CPUECTLR2_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 1, .opc2 = 5,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0,
+      .accessfn = access_actlr_w },
+    { .name = "CPUPPMCR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 2, .opc2 = 4,
+      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "CPUPWRCTLR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 2, .opc2 = 7,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0,
+      .accessfn = access_actlr_w },
+    { .name = "ATCR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 7, .opc2 = 0,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "CPUACTLR5_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 8, .opc2 = 0,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0,
+      .accessfn = access_actlr_w },
+    { .name = "CPUACTLR6_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 8, .opc2 = 1,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0,
+      .accessfn = access_actlr_w },
+    { .name = "CPUACTLR7_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 8, .opc2 = 2,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0,
+      .accessfn = access_actlr_w },
+    { .name = "ATCR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 15, .crm = 7, .opc2 = 0,
+      .access = PL2_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "AVTCR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 15, .crm = 7, .opc2 = 1,
+      .access = PL2_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "CPUPPMCR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 2, .opc2 = 0,
+      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "CPUPPMCR2_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 2, .opc2 = 1,
+      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "CPUPPMCR4_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 2, .opc2 = 4,
+      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "CPUPPMCR5_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 2, .opc2 = 5,
+      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "CPUPPMCR6_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 2, .opc2 = 6,
+      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "CPUACTLR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 4, .opc2 = 0,
+      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "ATCR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 7, .opc2 = 0,
+      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "CPUPSELR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 8, .opc2 = 0,
+      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "CPUPCR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 8, .opc2 = 1,
+      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "CPUPOR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 8, .opc2 = 2,
+      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "CPUPMR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 8, .opc2 = 3,
+      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "CPUPOR2_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 8, .opc2 = 4,
+      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "CPUPMR2_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 8, .opc2 = 5,
+      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "CPUPFR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 8, .opc2 = 6,
+      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+
+    /*
+     * Stub RAMINDEX, as we don't actually implement caches, BTB,
+     * or anything else with cpu internal memory.
+     * "Read" zeros into the IDATA* and DDATA* output registers.
+     */
+    { .name = "RAMINDEX_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 15, .crm = 0, .opc2 = 0,
+      .access = PL3_W, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IDATA0_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 0, .opc2 = 0,
+      .access = PL3_R, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IDATA1_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 0, .opc2 = 1,
+      .access = PL3_R, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "IDATA2_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 0, .opc2 = 2,
+      .access = PL3_R, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "DDATA0_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 1, .opc2 = 0,
+      .access = PL3_R, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "DDATA1_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 1, .opc2 = 1,
+      .access = PL3_R, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "DDATA2_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 1, .opc2 = 2,
+      .access = PL3_R, .type = ARM_CP_CONST, .resetvalue = 0 },
+};
+
+static void aarch64_a710_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    cpu->dtb_compatible = "arm,cortex-a710";
+    set_feature(&cpu->env, ARM_FEATURE_V8);
+    set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
+    set_feature(&cpu->env, ARM_FEATURE_EL2);
+    set_feature(&cpu->env, ARM_FEATURE_EL3);
+    set_feature(&cpu->env, ARM_FEATURE_PMU);
+
+    /* Ordered by Section B.4: AArch64 registers */
+    cpu->midr          = 0x412FD471; /* r2p1 */
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
+    cpu->isar.id_mmfr4 = 0x21021110;
+    cpu->isar.id_isar6 = 0x01111111;
+    cpu->isar.mvfr0    = 0x10110222;
+    cpu->isar.mvfr1    = 0x13211111;
+    cpu->isar.mvfr2    = 0x00000043;
+    cpu->isar.id_pfr2  = 0x00000011;
+    cpu->isar.id_aa64pfr0  = 0x1201111120111112ull; /* GIC filled in later */
+    cpu->isar.id_aa64pfr1  = 0x0000000000000221ull;
+    cpu->isar.id_aa64zfr0  = 0x0000110100110021ull; /* with Crypto */
+    cpu->isar.id_aa64dfr0  = 0x000011f010305611ull;
+    cpu->isar.id_aa64dfr1  = 0;
+    cpu->id_aa64afr0       = 0;
+    cpu->id_aa64afr1       = 0;
+    cpu->isar.id_aa64isar0 = 0x0221111110212120ull; /* with Crypto */
+    cpu->isar.id_aa64isar1 = 0x0010111101211032ull;
+    cpu->isar.id_aa64mmfr0 = 0x0000022200101122ull;
+    cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
+    cpu->isar.id_aa64mmfr2 = 0x1221011110101011ull;
+    cpu->clidr             = 0x0000001482000023ull;
+    cpu->gm_blocksize      = 4;
+    cpu->ctr               = 0x000000049444c004ull;
+    cpu->dcz_blocksize     = 4;
+    /* TODO FEAT_MPAM: mpamidr_el1 = 0x0000_0001_0006_003f */
+
+    /* Section B.5.2: PMCR_EL0 */
+    cpu->isar.reset_pmcr_el0 = 0xa000;  /* with 20 counters */
+
+    /* Section B.6.7: ICH_VTR_EL2 */
+    cpu->gic_num_lrs = 4;
+    cpu->gic_vpribits = 5;
+    cpu->gic_vprebits = 5;
+    cpu->gic_pribits = 5;
+
+    /* Section 14: Scalable Vector Extensions support */
+    cpu->sve_vq.supported = 1 << 0;  /* 128bit */
+
+    /*
+     * The cortex-a710 TRM does not list CCSIDR values.  The layout of
+     * the caches are in text in Table 7-1, Table 8-1, and Table 9-1.
+     *
+     * L1: 4-way set associative 64-byte line size, total either 32K or 64K.
+     * L2: 8-way set associative 64 byte line size, total either 256K or 512K.
+     */
+    cpu->ccsidr[0] = make_ccsidr64(4, 64, 64 * KiB);   /* L1 dcache */
+    cpu->ccsidr[1] = cpu->ccsidr[0];                   /* L1 icache */
+    cpu->ccsidr[2] = make_ccsidr64(8, 64, 512 * KiB);  /* L2 cache */
+
+    /* FIXME: Not documented -- copied from neoverse-v1 */
+    cpu->reset_sctlr = 0x30c50838;
+
+    define_arm_cp_regs(cpu, cortex_a710_cp_reginfo);
+
+    aarch64_add_pauth_properties(obj);
+    aarch64_add_sve_properties(obj);
+}
+
 /*
  * -cpu max: a CPU with as many features enabled as our emulation supports.
  * The version of '-cpu max' for qemu-system-arm is defined in cpu32.c;
@@ -936,6 +1147,7 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a55",         .initfn = aarch64_a55_initfn },
     { .name = "cortex-a72",         .initfn = aarch64_a72_initfn },
     { .name = "cortex-a76",         .initfn = aarch64_a76_initfn },
+    { .name = "cortex-a710",        .initfn = aarch64_a710_initfn },
     { .name = "a64fx",              .initfn = aarch64_a64fx_initfn },
     { .name = "neoverse-n1",        .initfn = aarch64_neoverse_n1_initfn },
     { .name = "neoverse-v1",        .initfn = aarch64_neoverse_v1_initfn },
-- 
2.34.1


