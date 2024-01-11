Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0651082AD0A
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:11:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssl-0001hs-65; Thu, 11 Jan 2024 06:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssN-0001PX-AA
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:31 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssH-0004X7-Tv
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:30 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e60e13581so3470645e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971122; x=1705575922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MQYD8SQs+AzWTjyK2oOu6sKdgpJPRWaLpCdGPJiYEZU=;
 b=EoEIL8jYrBVJn6ZwxO9wJ4q61YZb+vQk8Y2+tR7M/vZl2O6a/E6Fw1Uk1FmMp6MJtY
 VCGYd9+QyOYjvIUxJUwQXAcuF7UW50dEX9lyVY/NwGJWWw13O8lZs1zZXTFbo2C3vbc9
 uYEUL2TyHT0fuqUaCxJMwg0ubCt8FVghbiDAHQtDEot7sRJaffhRi0EXWgJKeohXyEQB
 ygbPVBWl4DQ5XX0VQsAcT0+my+sa7ud4qED+c4XF3gXucjIGzDj5zXDV9P83b2xNMkpN
 FHqx3nD5sfhbzf6AiuO/v7ipKY0iqu5vxIqC+MtuXVXhJr/RLezd8MWKPDpl70RhMi9L
 N8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971122; x=1705575922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MQYD8SQs+AzWTjyK2oOu6sKdgpJPRWaLpCdGPJiYEZU=;
 b=R9uoWDMknZ1zTXZTrQ/U4HGYCEAZu/NLSR5mdvSTkhnFDR3yuxDAP+rmQCReAyWeq2
 utQ+BzMkudX9Dgu3ppTuI73nBPypkleucDtmTV4GhEU71QIQ9SbePtCKNUyB0zWGWxux
 YGOeOG/HcaSUV93MqBhV5L4YmeQj0bncSx3aK9WlTh7jB+0U2XI3yz01ro3CP3WSoI/B
 8u0IZkBFcjbHp5YIyrvPCMQCO73tMboBcRsr2qV8JZ70MkMnO3CmLSdIuSf2S9Mftv/a
 WPB2MUZYEU+Eh4UL79hYgmFkIkDTaXZdy+6ff7/0gRknTkqQZZIXX/KucwQfaGJKW+9e
 l87A==
X-Gm-Message-State: AOJu0YzJgjpEv+f9P61UA7c1OegGLd5r5Mg4pPg7Jz69lfvfzDazGIIj
 wkAjZvccIb2v0vr374O3TXCZ2IV9ui/Z3b6biA1o3K6kn+c=
X-Google-Smtp-Source: AGHT+IHyojjV5U3f7hlM+S8gk5qO5YAk+Tvg2VGP3GB21VRZ5fa6VCmqDEVajPxqoFLjPKWSt7a8EA==
X-Received: by 2002:a05:600c:c15:b0:40d:8550:878d with SMTP id
 fm21-20020a05600c0c1500b0040d8550878dmr219569wmb.15.1704971122403; 
 Thu, 11 Jan 2024 03:05:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/41] target/arm: Mark up VNCR offsets (offsets 0x100..0x160)
Date: Thu, 11 Jan 2024 11:04:59 +0000
Message-Id: <20240111110505.1563291-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Mark up the cpreginfo structs to indicate offsets for system
registers from VNCR_EL2, as defined in table D8-66 in rule R_CSRPQ in
the Arm ARM.  This commit covers offsets 0x100 to 0x160.

Many (but not all) of the registers in this range have _EL12 aliases,
and the slot in memory is shared between the _EL12 version of the
register and the _EL1 version.  Where we programmatically generate
the regdef for the _EL12 register, arrange that its
nv2_redirect_offset is set up correctly to do this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
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
index bc5a0810421..1d62d243cdc 100644
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
@@ -2250,11 +2252,13 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
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
@@ -2264,6 +2268,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 2, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_MAIR_EL1,
+      .nv2_redirect_offset = 0x140 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.mair_el[1]),
       .resetvalue = 0 },
     { .name = "MAIR_EL3", .state = ARM_CP_STATE_AA64,
@@ -4287,6 +4292,7 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
       .opc0 = 3, .crn = 5, .crm = 2, .opc1 = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_ESR_EL1,
+      .nv2_redirect_offset = 0x138 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.esr_el[1]), .resetvalue = 0, },
     { .name = "TTBR0_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
@@ -4306,6 +4312,7 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
       .opc0 = 3, .crn = 2, .crm = 0, .opc1 = 0, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_TCR_EL1,
+      .nv2_redirect_offset = 0x120 | NV2_REDIR_NV1,
       .writefn = vmsa_tcr_el12_write,
       .raw_writefn = raw_write,
       .resetvalue = 0,
@@ -4545,6 +4552,7 @@ static const ARMCPRegInfo lpae_cp_reginfo[] = {
       .opc0 = 3, .crn = 10, .crm = 3, .opc1 = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_AMAIR_EL1,
+      .nv2_redirect_offset = 0x148 | NV2_REDIR_NV1,
       .type = ARM_CP_CONST, .resetvalue = 0 },
     /* AMAIR1 is mapped to AMAIR_EL1[63:32] */
     { .name = "AMAIR1", .cp = 15, .crn = 10, .crm = 3, .opc1 = 0, .opc2 = 1,
@@ -5734,6 +5742,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_nv1,
+      .nv2_redirect_offset = 0x160 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_SVC]) },
     /*
      * We rely on the access checks not allowing the guest to write to the
@@ -6726,6 +6735,17 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
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
@@ -9438,6 +9458,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ACTLR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 1,
               .access = PL1_RW, .accessfn = access_tacr,
+              .nv2_redirect_offset = 0x118,
               .type = ARM_CP_CONST, .resetvalue = cpu->reset_auxcr },
             { .name = "ACTLR_EL2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 0, .opc2 = 1,
@@ -9523,6 +9544,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 0,
             .access = PL1_RW, .accessfn = access_tvm_trvm,
             .fgt = FGT_SCTLR_EL1,
+            .nv2_redirect_offset = 0x110 | NV2_REDIR_NV1,
             .bank_fieldoffsets = { offsetof(CPUARMState, cp15.sctlr_s),
                                    offsetof(CPUARMState, cp15.sctlr_ns) },
             .writefn = sctlr_write, .resetvalue = cpu->reset_sctlr,
-- 
2.34.1


