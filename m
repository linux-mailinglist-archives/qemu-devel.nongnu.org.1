Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 076E973B7BA
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:42:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxA-0001n3-9k; Fri, 23 Jun 2023 08:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx0-0001VB-Pn
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:43 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfwy-0000eq-MI
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:42 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4f883420152so666198e87.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523499; x=1690115499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gyvx5K62q0+FJIslCa9Rhg6S+ur4ISC9ITMvP7s+UZ0=;
 b=vAeLU9i3kJ7j2NJSuAzVf+CJro0q0ccySBiMIRcLahhn2HDF84ViPT/r9CfW9SpoiR
 f+Ej8HKDbrRpnhnKhSAlhD84/J1PaMultDtLlekMYcW8bRoazFIBR9KzOn31DUnIHebS
 Rw+WgNpUMNlvK5lBU1q/xOWSFeBB3O/2h7W0+VoM37ZWRMF7o2OESbsEYnwgEHAX9r/K
 l8P3Pb38TjGgjxRIs1ZYqGrnYkOQ1XXXTVAMKgUn+MlxAmeIMIqX8G6LYIT96bL77S+Q
 SoCJMoVh9deQ/7E75grH+CAt2EKWYVJu+HRrJc5vWooDF7eVpewmcuR8ivTzO/fcqSYw
 zDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523499; x=1690115499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gyvx5K62q0+FJIslCa9Rhg6S+ur4ISC9ITMvP7s+UZ0=;
 b=l6glFKzDsbpYxSYKiAigjGeKmUmzYxe39EejbO2qvUA7QCHEjMfRx68z4KHAJezLPY
 gP/wYEQpNQTnEv9lCLW4eskPOSYoq5/mwo4y0Og+4uF2J8SpRdOTjXWzd0szs0/8iymx
 TkNq/dgjwe29HjbTIxkBv2Tfez5EAfPi17R99HwIN0OjWY8FYD7Jzt5+FalLcHMxvNkJ
 GF3bdrR1befyaQHA4SRFK1p/HLsX2GGzpDv9q+TIaOWmEJkTT2taefDXebAvBVelT66g
 VMJ3NW2bgfYOmJUSAHmA6DohFyMM8T8ydjd702pZsJz3hJeQrF3s91PnVQ2y3/8u8pmD
 3iLg==
X-Gm-Message-State: AC+VfDwYm3HCA7DNcvj4fWclFvBzDPaoGL56bMO3RosaneQy6fnYkjkx
 KWMsX9dbTxsX36N+8U7J4TafkgHFXrem3E7DV/w=
X-Google-Smtp-Source: ACHHUZ7T4mZbgyi94LRubYynBF7gvz4MchEzttKVo3bvDdrvATvCtrZqG0Q3IUGI8RxAlTnQp++wUg==
X-Received: by 2002:a19:6d0e:0:b0:4f6:520d:6b9b with SMTP id
 i14-20020a196d0e000000b004f6520d6b9bmr11417406lfc.60.1687523499159; 
 Fri, 23 Jun 2023 05:31:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/26] target/arm: Add RME cpregs
Date: Fri, 23 Jun 2023 13:31:13 +0100
Message-Id: <20230623123135.1788191-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This includes GPCCR, GPTBR, MFAR, the TLB flush insns PAALL, PAALLOS,
RPALOS, RPAOS, and the cache flush insns CIPAPA and CIGDPAPA.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230620124418.805717-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 19 ++++++++++
 target/arm/helper.c | 84 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 318d1033b87..c9c87b515df 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -541,6 +541,11 @@ typedef struct CPUArchState {
         uint64_t fgt_read[2]; /* HFGRTR, HDFGRTR */
         uint64_t fgt_write[2]; /* HFGWTR, HDFGWTR */
         uint64_t fgt_exec[1]; /* HFGITR */
+
+        /* RME registers */
+        uint64_t gpccr_el3;
+        uint64_t gptbr_el3;
+        uint64_t mfar_el3;
     } cp15;
 
     struct {
@@ -1055,6 +1060,7 @@ struct ArchCPU {
     uint64_t reset_cbar;
     uint32_t reset_auxcr;
     bool reset_hivecs;
+    uint8_t reset_l0gptsz;
 
     /*
      * Intermediate values used during property parsing.
@@ -2341,6 +2347,19 @@ FIELD(MVFR1, SIMDFMAC, 28, 4)
 FIELD(MVFR2, SIMDMISC, 0, 4)
 FIELD(MVFR2, FPMISC, 4, 4)
 
+FIELD(GPCCR, PPS, 0, 3)
+FIELD(GPCCR, IRGN, 8, 2)
+FIELD(GPCCR, ORGN, 10, 2)
+FIELD(GPCCR, SH, 12, 2)
+FIELD(GPCCR, PGS, 14, 2)
+FIELD(GPCCR, GPC, 16, 1)
+FIELD(GPCCR, GPCP, 17, 1)
+FIELD(GPCCR, L0GPTSZ, 20, 4)
+
+FIELD(MFAR, FPA, 12, 40)
+FIELD(MFAR, NSE, 62, 1)
+FIELD(MFAR, NS, 63, 1)
+
 QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
 
 /* If adding a feature bit which corresponds to a Linux ELF
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9132d4de6a4..006447dde8f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6910,6 +6910,83 @@ static const ARMCPRegInfo sme_reginfo[] = {
       .access = PL2_RW, .accessfn = access_esm,
       .type = ARM_CP_CONST, .resetvalue = 0 },
 };
+
+static void tlbi_aa64_paall_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+
+    tlb_flush(cs);
+}
+
+static void gpccr_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                        uint64_t value)
+{
+    /* L0GPTSZ is RO; other bits not mentioned are RES0. */
+    uint64_t rw_mask = R_GPCCR_PPS_MASK | R_GPCCR_IRGN_MASK |
+        R_GPCCR_ORGN_MASK | R_GPCCR_SH_MASK | R_GPCCR_PGS_MASK |
+        R_GPCCR_GPC_MASK | R_GPCCR_GPCP_MASK;
+
+    env->cp15.gpccr_el3 = (value & rw_mask) | (env->cp15.gpccr_el3 & ~rw_mask);
+}
+
+static void gpccr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    env->cp15.gpccr_el3 = FIELD_DP64(0, GPCCR, L0GPTSZ,
+                                     env_archcpu(env)->reset_l0gptsz);
+}
+
+static void tlbi_aa64_paallos_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+
+    tlb_flush_all_cpus_synced(cs);
+}
+
+static const ARMCPRegInfo rme_reginfo[] = {
+    { .name = "GPCCR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 1, .opc2 = 6,
+      .access = PL3_RW, .writefn = gpccr_write, .resetfn = gpccr_reset,
+      .fieldoffset = offsetof(CPUARMState, cp15.gpccr_el3) },
+    { .name = "GPTBR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 1, .opc2 = 4,
+      .access = PL3_RW, .fieldoffset = offsetof(CPUARMState, cp15.gptbr_el3) },
+    { .name = "MFAR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 6, .crm = 0, .opc2 = 5,
+      .access = PL3_RW, .fieldoffset = offsetof(CPUARMState, cp15.mfar_el3) },
+    { .name = "TLBI_PAALL", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 7, .opc2 = 4,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_paall_write },
+    { .name = "TLBI_PAALLOS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 1, .opc2 = 4,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_paallos_write },
+    /*
+     * QEMU does not have a way to invalidate by physical address, thus
+     * invalidating a range of physical addresses is accomplished by
+     * flushing all tlb entries in the outer sharable domain,
+     * just like PAALLOS.
+     */
+    { .name = "TLBI_RPALOS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 4, .opc2 = 7,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_paallos_write },
+    { .name = "TLBI_RPAOS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 4, .opc2 = 3,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_paallos_write },
+    { .name = "DC_CIPAPA", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 7, .crm = 14, .opc2 = 1,
+      .access = PL3_W, .type = ARM_CP_NOP },
+};
+
+static const ARMCPRegInfo rme_mte_reginfo[] = {
+    { .name = "DC_CIGDPAPA", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 7, .crm = 14, .opc2 = 5,
+      .access = PL3_W, .type = ARM_CP_NOP },
+};
 #endif /* TARGET_AARCH64 */
 
 static void define_pmu_regs(ARMCPU *cpu)
@@ -9130,6 +9207,13 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_fgt, cpu)) {
         define_arm_cp_regs(cpu, fgt_reginfo);
     }
+
+    if (cpu_isar_feature(aa64_rme, cpu)) {
+        define_arm_cp_regs(cpu, rme_reginfo);
+        if (cpu_isar_feature(aa64_mte, cpu)) {
+            define_arm_cp_regs(cpu, rme_mte_reginfo);
+        }
+    }
 #endif
 
     if (cpu_isar_feature(any_predinv, cpu)) {
-- 
2.34.1


