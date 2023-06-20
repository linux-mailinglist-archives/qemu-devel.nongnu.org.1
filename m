Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8A3736C47
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:49:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBail-0001RQ-5g; Tue, 20 Jun 2023 08:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaii-0001QA-Lh
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:28 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaif-0001rq-Rn
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:27 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51a2de3385fso6295577a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687265064; x=1689857064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8db1arbbArNUPiE75CY7f/HIL5XIpMmiVA6pu1+whjw=;
 b=XaDGmUbCQRe1gdIIUHYmtSy0O5OHCMF2/+7ByLuaZTff1rz9mYK8OTKQ2H1F+zg/+5
 oX/c5kjMYbGISNsxKzmar/HAbnjiRaSHDCZC11WiRQwYaJemJ2LIsBCjfmizubyB3S+l
 1vJTkikdYKHPJIDW0acoQfVTosVj1Ee1LHHukFiRp2hoifTzPyHHUyNx+8vMbGW0BV1G
 T4auuGZEloP1eVBfh2Q3WRHbo+kB/mGWSo+mrxH9MWaOu2RNFkOukAaCOD7DCplsyiPd
 UeY7Pc7wsWQuzRjCr7wTC1J65c1jbBQ6q6RXrWuZ18N4QcEx0HDwqOQt/jf8Tjc6UUPa
 Ckqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687265064; x=1689857064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8db1arbbArNUPiE75CY7f/HIL5XIpMmiVA6pu1+whjw=;
 b=b9rmqrQK2KZ2qzRaJQODdNy0S6KqysK6gpjmaR+24/0jaYy9TfIBrtR4zhf0NcDtqc
 wu6T2bJ9plZRzF2My1muD4zQjBuLrTuvH33/b49P1pNA7S1fPA6YeAbERXp3xtjwiaLj
 MJtPx2LsiekO76uRd2p2iZZGh4CcD/KC9oAQfNvgq9TtjUpkWgjh2fkZV4N50wG1mm2B
 AUkkZjNbCi0hNPyMuHyzhgVxMyBQ+EaVoAvjqRALd7dM1QIdFDPY7awTb7YsA3BNY3LK
 zDBIrXRmpxZbLcl0K6G4FLeaSA18EWXOE0NFOYOXkc9rLN6cE5wg6DzkTr2qbdzb4Kg6
 Ipkw==
X-Gm-Message-State: AC+VfDxAgtGj4rz2oauFbJgH5+dvZZxHumtOXlFUnzd5tfB0VqhC0TuS
 zEgKxOVEbUNLqlcuCbMF6gtikqiq81vfcOfaXQnpPA+U
X-Google-Smtp-Source: ACHHUZ7ZZsbq2D7K57pZhLv+xBcGNKWuRAppdOScr9+ar5Q5VRlRJEKbqdA6L1XuIM7yXWP8BO9d6A==
X-Received: by 2002:aa7:d498:0:b0:51b:cd07:d0f8 with SMTP id
 b24-20020aa7d498000000b0051bcd07d0f8mr1030903edr.6.1687265064397; 
 Tue, 20 Jun 2023 05:44:24 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 w9-20020aa7dcc9000000b0051a313a66e8sm1142541edu.45.2023.06.20.05.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 05:44:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 04/20] target/arm: Add RME cpregs
Date: Tue, 20 Jun 2023 14:44:02 +0200
Message-Id: <20230620124418.805717-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620124418.805717-1-richard.henderson@linaro.org>
References: <20230620124418.805717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52a.google.com
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

This includes GPCCR, GPTBR, MFAR, the TLB flush insns PAALL, PAALLOS,
RPALOS, RPAOS, and the cache flush insns CIPAPA and CIGDPAPA.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 19 ++++++++++
 target/arm/helper.c | 84 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 318d1033b8..c9c87b515d 100644
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
index 9132d4de6a..006447dde8 100644
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


