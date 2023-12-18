Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3763C816C78
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:38:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsX-0007AH-4I; Mon, 18 Dec 2023 06:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsL-00077L-5v
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:33 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsA-0003Nu-9v
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:32 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33668163949so694011f8f.2
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899201; x=1703504001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NRuw6DRSRtcEOUgfTxYJIjGMHE4VBSQoJphbpoL6X/Y=;
 b=ir0K8KqeqFlFdsBcVAgl8ztUaMxU1P83kfqwZ5qoO+9ByV6zr9auOvqyXueAFCZCRp
 3w/uL8xgd6YueoMH2lKxeVWcE7Q1L3qzyjESQnJ9ZnhinUIDpB+we2Be5OoK2FSNxec+
 coDT2kO10JVDL06Xje2fB/nBlDzV66J+4BpbmvVIg+J41oaNVXRQAaUueAREpu7bN2he
 okuJQIyfGZ3SzCzDCxjtdS6JKYwyyeZVQq0d0/VEp9QxLYEgI18qwTSuCr9tj4pDrPBW
 Dlf+JuNl1ndxHczNEvgBqW4mgtwXx3IuTq+dIGLySE1T12cse2pKHXFRGvIf28HJNQQT
 fBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899201; x=1703504001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NRuw6DRSRtcEOUgfTxYJIjGMHE4VBSQoJphbpoL6X/Y=;
 b=rQSNhlddWR8kV3BpmAnLW8BLCb0ke5crftALoClz72L3pICd/K1wGwRFQNDcAE0IcF
 4P4ejwLDvoV8kcjT3LOWwFUggHmiiDDpHkZJ7VHq+7f3suCcr65nt9E3Vc9Khk2Mxw1B
 Tz25yf7IenNOqJKxwkBFShNvST3cPlZup38TZDYFMkqMjjYXWhWdsyRonljLjYLc3Xrz
 zbyxol+tfcf5j6XeeRjpIvSZz7rrWqjtCQaP0qps6KEVvjHtXv+AMcPWHMkfRjLN5I0t
 LFNJRxlJPWLYfS+iyb6Rb8YgSmxSQhuJ7Ky3g4zahxtft6+mNbzZe5hl8Q8/HccfTjWS
 4qkA==
X-Gm-Message-State: AOJu0Yy0qEqqn1POzGE80JlKZAGVFdYIDRffwcvet+ugdC2CRbQ+Cuet
 oUiITL+3hXis34VkiNBwtoatNw==
X-Google-Smtp-Source: AGHT+IHCP6taLPCSssnAbsaHYG0eYc8OKXPmXPO8rWxa5RZ9WeNKBDmS+iyMAR3DTVMCS0HtQlojYw==
X-Received: by 2002:a05:6000:1f07:b0:336:6600:c191 with SMTP id
 bv7-20020a0560001f0700b003366600c191mr640147wrb.107.1702899200798; 
 Mon, 18 Dec 2023 03:33:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 29/35] target/arm: Mark up VNCR offsets (offsets 0x100..0x160)
Date: Mon, 18 Dec 2023 11:32:59 +0000
Message-Id: <20231218113305.2511480-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

Mark up the cpreginfo structs to indicate offsets for system
registers from VNCR_EL2, as defined in table D8-66 in rule R_CSRPQ in
the Arm ARM.  This commit covers offsets 0x100 to 0x160.

Many (but not all) of the registers in this range have _EL12 aliases,
and the slot in memory is shared between the _EL12 version of the
register and the _EL1 version.  Where we programmatically generate
the regdef for the _EL12 register, arrange that its
nv2_redirect_offset is set up correctly to do this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/debug_helper.c |  1 +
 target/arm/helper.c       | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index b39144d5b93..7d856acddf2 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -960,6 +960,7 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
       .cp = 14, .opc0 = 2, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tda,
       .fgt = FGT_MDSCR_EL1,
+      .nv2_redirect_offset = 0x158,
       .fieldoffset = offsetof(CPUARMState, cp15.mdscr_el1),
       .resetvalue = 0 },
     /*
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ff7f90fa4af..78c3c3ebd8d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -647,6 +647,7 @@ static const ARMCPRegInfo cp_reginfo[] = {
       .opc0 = 3, .opc1 = 0, .crn = 13, .crm = 0, .opc2 = 1,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_CONTEXTIDR_EL1,
+      .nv2_redirect_offset = 0x108 | NV2_REDIR_NV1,
       .secure = ARM_CP_SECSTATE_NS,
       .fieldoffset = offsetof(CPUARMState, cp15.contextidr_el[1]),
       .resetvalue = 0, .writefn = contextidr_write, .raw_writefn = raw_write, },
@@ -883,6 +884,7 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
     { .name = "CPACR", .state = ARM_CP_STATE_BOTH, .opc0 = 3,
       .crn = 1, .crm = 0, .opc1 = 0, .opc2 = 2, .accessfn = cpacr_access,
       .fgt = FGT_CPACR_EL1,
+      .nv2_redirect_offset = 0x100 | NV2_REDIR_NV1,
       .access = PL1_RW, .fieldoffset = offsetof(CPUARMState, cp15.cpacr_el1),
       .resetfn = cpacr_reset, .writefn = cpacr_write, .readfn = cpacr_read },
 };
@@ -2234,11 +2236,13 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 0, .crn = 5, .crm = 1, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_AFSR0_EL1,
+      .nv2_redirect_offset = 0x128 | NV2_REDIR_NV1,
       .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "AFSR1_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 5, .crm = 1, .opc2 = 1,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_AFSR1_EL1,
+      .nv2_redirect_offset = 0x130 | NV2_REDIR_NV1,
       .type = ARM_CP_CONST, .resetvalue = 0 },
     /*
      * MAIR can just read-as-written because we don't implement caches
@@ -2248,6 +2252,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 2, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_MAIR_EL1,
+      .nv2_redirect_offset = 0x140 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.mair_el[1]),
       .resetvalue = 0 },
     { .name = "MAIR_EL3", .state = ARM_CP_STATE_AA64,
@@ -4271,6 +4276,7 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
       .opc0 = 3, .crn = 5, .crm = 2, .opc1 = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_ESR_EL1,
+      .nv2_redirect_offset = 0x138 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.esr_el[1]), .resetvalue = 0, },
     { .name = "TTBR0_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
@@ -4290,6 +4296,7 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
       .opc0 = 3, .crn = 2, .crm = 0, .opc1 = 0, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_TCR_EL1,
+      .nv2_redirect_offset = 0x120 | NV2_REDIR_NV1,
       .writefn = vmsa_tcr_el12_write,
       .raw_writefn = raw_write,
       .resetvalue = 0,
@@ -4529,6 +4536,7 @@ static const ARMCPRegInfo lpae_cp_reginfo[] = {
       .opc0 = 3, .crn = 10, .crm = 3, .opc1 = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_AMAIR_EL1,
+      .nv2_redirect_offset = 0x148 | NV2_REDIR_NV1,
       .type = ARM_CP_CONST, .resetvalue = 0 },
     /* AMAIR1 is mapped to AMAIR_EL1[63:32] */
     { .name = "AMAIR1", .cp = 15, .crn = 10, .crm = 3, .opc1 = 0, .opc2 = 1,
@@ -5718,6 +5726,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_nv1,
+      .nv2_redirect_offset = 0x160 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_SVC]) },
     /*
      * We rely on the access checks not allowing the guest to write to the
@@ -6710,6 +6719,17 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
         new_reg->writefn = el2_e2h_e12_write;
         new_reg->accessfn = el2_e2h_e12_access;
 
+        /*
+         * If the _EL1 register is redirected to memory by FEAT_NV2,
+         * then it shares the offset with the _EL12 register,
+         * and which one is redirected depends on HCR_EL2.NV1.
+         */
+        if (new_reg->nv2_redirect_offset) {
+            assert(new_reg->nv2_redirect_offset & NV2_REDIR_NV1);
+            new_reg->nv2_redirect_offset &= ~NV2_REDIR_NV1;
+            new_reg->nv2_redirect_offset |= NV2_REDIR_NO_NV1;
+        }
+
         ok = g_hash_table_insert(cpu->cp_regs,
                                  (gpointer)(uintptr_t)a->new_key, new_reg);
         g_assert(ok);
@@ -9414,6 +9434,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ACTLR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 1,
               .access = PL1_RW, .accessfn = access_tacr,
+              .nv2_redirect_offset = 0x118,
               .type = ARM_CP_CONST, .resetvalue = cpu->reset_auxcr },
             { .name = "ACTLR_EL2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 0, .opc2 = 1,
@@ -9499,6 +9520,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 0,
             .access = PL1_RW, .accessfn = access_tvm_trvm,
             .fgt = FGT_SCTLR_EL1,
+            .nv2_redirect_offset = 0x110 | NV2_REDIR_NV1,
             .bank_fieldoffsets = { offsetof(CPUARMState, cp15.sctlr_s),
                                    offsetof(CPUARMState, cp15.sctlr_ns) },
             .writefn = sctlr_write, .resetvalue = cpu->reset_sctlr,
-- 
2.34.1


