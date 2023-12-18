Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD32816C45
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:34:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsa-0007SW-PD; Mon, 18 Dec 2023 06:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsM-00077w-Re
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:35 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsB-0003OS-3u
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:34 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-336672406f0so654679f8f.2
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899201; x=1703504001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nDtTmxnTvjnXEk8xcvOOb8nCioQSxbevWpP7qdlO2bA=;
 b=NP7stvqto2DP1dMJU4jwONfSRNkn9zFUNx9+gLUPftvVQFh6BGfFqtczEFe3z2kq3Q
 UjS3vzuhPMSJB1tkm28wTB0eBKPEBW8fTWry4qxekqWTZbft/TPHyRN7JgbMJgf2piNF
 xajNxMhOe6a00N4+W8LNdktHXjWsmetTxr07gbs8BORGnvlqV7V5dRvfKAcpfx+WjSzS
 5PGGhJs3QJN2scLgoT2kcE2VcDPPI5/MYqDVL/AGsyOyN4CdDAJ9dVxz2Ng6xdbIOhQK
 hVcE42DwzErO0NgYwneSqtAclsioUm8miG+Cl8hVlLtJTxmQihnL0ITcTMbbvmSg1eZ1
 FBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899201; x=1703504001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nDtTmxnTvjnXEk8xcvOOb8nCioQSxbevWpP7qdlO2bA=;
 b=gVpRlnwHkkJVk6NoAtOX+meZw7xjSDINIjRzu9NzwwVEPlbN/vAY0fEyisxz1X+nn6
 dnlS49GI2g6EgWYciUWi8CieZ0GtB0uidi16dkQcGP8LdWOlC4nbTkueZglfmgH3aNo5
 mOuiwoI2qHD2PXrdNoq7SelPnUXP0NeWYXl9s8uP5IyUXuWbW7bAPT3/kAK4r3H3I9Iw
 fYZ67UR+vHp1nIJuIGmcUl9vpmKPP6z6m5Lhbo/jghwsfZQ2RmRoUkPYB/QWSQPmt7ea
 Vd0+yKx+DBi3LoIyVLJeI8oPgjVWgFkJIJ/XGnUP5UVxDBobSLvCHaAevhthAmCGf5kW
 VrQQ==
X-Gm-Message-State: AOJu0YysXoGO1kUWlmEOKBRkJJ1h9GYVYsXXz6zED0Ax4LcO2VUWMot2
 eUlCDc9Y1tAgWi+43cOZCSnnLnBfW9Fmz5IFXpg=
X-Google-Smtp-Source: AGHT+IG6kv57zpFTZcTvXUdeRGXf9tnDa/ZRB9rfNWJcNgsv5NHDTQzXsDRzcW+1N60E/VzY9VogAQ==
X-Received: by 2002:a5d:5191:0:b0:333:3c28:2895 with SMTP id
 k17-20020a5d5191000000b003333c282895mr7819790wrv.77.1702899201695; 
 Mon, 18 Dec 2023 03:33:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 31/35] target/arm: Mark up VNCR offsets (offsets >= 0x200,
 except GIC)
Date: Mon, 18 Dec 2023 11:33:01 +0000
Message-Id: <20231218113305.2511480-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
the Arm ARM.  This covers all the remaining offsets at 0x200 and
above, except for the GIC ICH_* registers.

(Note that because we don't implement FEAT_SPE, FEAT_TRF,
FEAT_MPAM, FEAT_BRBE or FEAT_AMUv1p1 we don't implement any
of the registers that use offsets at 0x800 and above.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6c33619d646..c72ce4aee09 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4271,6 +4271,7 @@ static const ARMCPRegInfo vmsa_pmsa_cp_reginfo[] = {
       .opc0 = 3, .crn = 6, .crm = 0, .opc1 = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_FAR_EL1,
+      .nv2_redirect_offset = 0x220 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.far_el[1]),
       .resetvalue = 0, },
 };
@@ -4286,6 +4287,7 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_TTBR0_EL1,
+      .nv2_redirect_offset = 0x200 | NV2_REDIR_NV1,
       .writefn = vmsa_ttbr_write, .resetvalue = 0, .raw_writefn = raw_write,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
                              offsetof(CPUARMState, cp15.ttbr0_ns) } },
@@ -4293,6 +4295,7 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 1,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_TTBR1_EL1,
+      .nv2_redirect_offset = 0x210 | NV2_REDIR_NV1,
       .writefn = vmsa_ttbr_write, .resetvalue = 0, .raw_writefn = raw_write,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
                              offsetof(CPUARMState, cp15.ttbr1_ns) } },
@@ -5725,6 +5728,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 0, .opc2 = 1,
       .access = PL1_RW, .accessfn = access_nv1,
+      .nv2_redirect_offset = 0x230 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, elr_el[1]) },
     { .name = "SPSR_EL1", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
@@ -5744,6 +5748,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, sp_el[0]) },
     { .name = "SP_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 1, .opc2 = 0,
+      .nv2_redirect_offset = 0x240,
       .access = PL2_RW, .type = ARM_CP_ALIAS | ARM_CP_EL3_NO_EL2_KEEP,
       .fieldoffset = offsetof(CPUARMState, sp_el[1]) },
     { .name = "SPSel", .state = ARM_CP_STATE_AA64,
@@ -6866,9 +6871,11 @@ static const ARMCPRegInfo minimal_ras_reginfo[] = {
       .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "VDISR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 1, .opc2 = 1,
+      .nv2_redirect_offset = 0x500,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.vdisr_el2) },
     { .name = "VSESR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 5, .crm = 2, .opc2 = 3,
+      .nv2_redirect_offset = 0x508,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.vsesr_el2) },
 };
 
@@ -9524,6 +9531,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_RW, .writefn = vbar_write,
               .accessfn = access_nv1,
               .fgt = FGT_VBAR_EL1,
+              .nv2_redirect_offset = 0x250 | NV2_REDIR_NV1,
               .bank_fieldoffsets = { offsetof(CPUARMState, cp15.vbar_s),
                                      offsetof(CPUARMState, cp15.vbar_ns) },
               .resetvalue = 0 },
-- 
2.34.1


