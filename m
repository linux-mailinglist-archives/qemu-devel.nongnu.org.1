Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2154282AD01
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:10:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssl-0001j8-SX; Thu, 11 Jan 2024 06:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssL-0001PQ-JY
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:31 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssH-0004XT-UI
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:29 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-336c9acec03so4519400f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971123; x=1705575923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WIRlikOf+Qay01mq3PzxaBC1vuA3jtjYGSPSXLeA82A=;
 b=XCnQAlISTS3twzGAPwmcQJ/yD02xa19Z8AB7XEJNc9/ykP9HVPRB6Oh7gyeYL3wiFq
 KwjnvyYVqZSaCbp1PsSD5fCH1qMcXUwtXSszcdxCMuhZqy0+AgKy2TNOeWODu0rWuGXl
 WP9X4Ve4peZqEyCU/CQV3kKcAQlc53PluGASfIviCh3tmg28WrF6OOFkCWXJYXHBvxlA
 FYvfAL8HdkmXVKbC+BQ+dTwjWSZBZmb+NYEJHp0SWRKoOBsVXK0DoDzheRK6x6PogYKg
 Zzxo2Q3B+xy8qUxjVL7YVI0QQep4p3XA2terscCF/+9heaj20KTy2Z9dgf3IwAwZztgn
 Cutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971123; x=1705575923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WIRlikOf+Qay01mq3PzxaBC1vuA3jtjYGSPSXLeA82A=;
 b=IeYgcIDeVz0fEXqzdYRe9qXIRr/mBr6EqIjYoQei6NbMVKUOwXU1qGAG1GmuTPUKFF
 P3Anu3oulbQGAHoEaR29rLSiAu4gon19NPTmInVYYjtDuiwY242Uhsb/MYxVuRnxSCz3
 ERFUsr/giCJg7n19zNq+KD+PV+IwTNRBSnPD/kqHBBslaqk1/+c2zncRn8H+7EWi5eUl
 YWa2ABSypCnLlPE/vXgL7xysZajMB9Kv2BdPnfJxxsjTYSsV3I2WqbqTRw7LO7iWdPJh
 5p+cVZQ5lOqHn+AujViNd2RNtqZRg0XW2c85dFTgln7hnRYM2z4hOymeb8ChopF+SBuE
 MRCA==
X-Gm-Message-State: AOJu0Yz0ic88AyKI+u1KWdintkPM9Qo8KqB17y+ft1gmXJ7f4ixvzH1w
 68CD75ee8+kl40zObfxa4+RsCPl6NCufrD5wpAeAS2kNu6Y=
X-Google-Smtp-Source: AGHT+IGa6cxL7DAc35zfJHDD2MZ26BuL8DJWF3oGMjwRMvr04wWxcos8ivs8a0rtGvB5UIZA55sVOA==
X-Received: by 2002:adf:cc8b:0:b0:337:3a52:9aa6 with SMTP id
 p11-20020adfcc8b000000b003373a529aa6mr587453wrj.39.1704971122771; 
 Thu, 11 Jan 2024 03:05:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/41] target/arm: Mark up VNCR offsets (offsets 0x168..0x1f8)
Date: Thu, 11 Jan 2024 11:05:00 +0000
Message-Id: <20240111110505.1563291-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
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

Mark up the cpreginfo structs to indicate offsets for system
registers from VNCR_EL2, as defined in table D8-66 in rule R_CSRPQ in
the Arm ARM.  This commit covers offsets 0x168 to 0x1f8.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/helper.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1d62d243cdc..aa66f5169ab 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3191,6 +3191,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 2, .opc2 = 1,
       .type = ARM_CP_IO, .access = PL0_RW,
       .accessfn = gt_ptimer_access,
+      .nv2_redirect_offset = 0x180 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].ctl),
       .resetvalue = 0,
       .readfn = gt_phys_redir_ctl_read, .raw_readfn = raw_read,
@@ -3208,6 +3209,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 3, .opc2 = 1,
       .type = ARM_CP_IO, .access = PL0_RW,
       .accessfn = gt_vtimer_access,
+      .nv2_redirect_offset = 0x170 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].ctl),
       .resetvalue = 0,
       .readfn = gt_virt_redir_ctl_read, .raw_readfn = raw_read,
@@ -3287,6 +3289,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 2, .opc2 = 2,
       .access = PL0_RW,
       .type = ARM_CP_IO,
+      .nv2_redirect_offset = 0x178 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].cval),
       .resetvalue = 0, .accessfn = gt_ptimer_access,
       .readfn = gt_phys_redir_cval_read, .raw_readfn = raw_read,
@@ -3304,6 +3307,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 3, .opc2 = 2,
       .access = PL0_RW,
       .type = ARM_CP_IO,
+      .nv2_redirect_offset = 0x168 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].cval),
       .resetvalue = 0, .accessfn = gt_vtimer_access,
       .readfn = gt_virt_redir_cval_read, .raw_readfn = raw_read,
@@ -7052,6 +7056,7 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static const ARMCPRegInfo zcr_reginfo[] = {
     { .name = "ZCR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 2, .opc2 = 0,
+      .nv2_redirect_offset = 0x1e0 | NV2_REDIR_NV1,
       .access = PL1_RW, .type = ARM_CP_SVE,
       .fieldoffset = offsetof(CPUARMState, vfp.zcr_el[1]),
       .writefn = zcr_write, .raw_writefn = raw_write },
@@ -7193,6 +7198,7 @@ static const ARMCPRegInfo sme_reginfo[] = {
       .writefn = svcr_write, .raw_writefn = raw_write },
     { .name = "SMCR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 2, .opc2 = 6,
+      .nv2_redirect_offset = 0x1f0 | NV2_REDIR_NV1,
       .access = PL1_RW, .type = ARM_CP_SME,
       .fieldoffset = offsetof(CPUARMState, vfp.smcr_el[1]),
       .writefn = smcr_write, .raw_writefn = raw_write },
@@ -7226,6 +7232,7 @@ static const ARMCPRegInfo sme_reginfo[] = {
       .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "SMPRIMAP_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 2, .opc2 = 5,
+      .nv2_redirect_offset = 0x1f8,
       .access = PL2_RW, .accessfn = access_smprimap,
       .type = ARM_CP_CONST, .resetvalue = 0 },
 };
@@ -7948,6 +7955,7 @@ static const ARMCPRegInfo mte_reginfo[] = {
     { .name = "TFSR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 5, .crm = 6, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tfsr_el1,
+      .nv2_redirect_offset = 0x190 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[1]) },
     { .name = "TFSR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_NV2_REDIRECT,
@@ -8122,6 +8130,7 @@ static const ARMCPRegInfo scxtnum_reginfo[] = {
       .opc0 = 3, .opc1 = 0, .crn = 13, .crm = 0, .opc2 = 7,
       .access = PL1_RW, .accessfn = access_scxtnum_el1,
       .fgt = FGT_SCXTNUM_EL1,
+      .nv2_redirect_offset = 0x188 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, scxtnum_el[1]) },
     { .name = "SCXTNUM_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 13, .crm = 0, .opc2 = 7,
@@ -8146,22 +8155,27 @@ static CPAccessResult access_fgt(CPUARMState *env, const ARMCPRegInfo *ri,
 static const ARMCPRegInfo fgt_reginfo[] = {
     { .name = "HFGRTR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 4,
+      .nv2_redirect_offset = 0x1b8,
       .access = PL2_RW, .accessfn = access_fgt,
       .fieldoffset = offsetof(CPUARMState, cp15.fgt_read[FGTREG_HFGRTR]) },
     { .name = "HFGWTR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 5,
+      .nv2_redirect_offset = 0x1c0,
       .access = PL2_RW, .accessfn = access_fgt,
       .fieldoffset = offsetof(CPUARMState, cp15.fgt_write[FGTREG_HFGWTR]) },
     { .name = "HDFGRTR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 3, .crm = 1, .opc2 = 4,
+      .nv2_redirect_offset = 0x1d0,
       .access = PL2_RW, .accessfn = access_fgt,
       .fieldoffset = offsetof(CPUARMState, cp15.fgt_read[FGTREG_HDFGRTR]) },
     { .name = "HDFGWTR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 3, .crm = 1, .opc2 = 5,
+      .nv2_redirect_offset = 0x1d8,
       .access = PL2_RW, .accessfn = access_fgt,
       .fieldoffset = offsetof(CPUARMState, cp15.fgt_write[FGTREG_HDFGWTR]) },
     { .name = "HFGITR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 6,
+      .nv2_redirect_offset = 0x1c8,
       .access = PL2_RW, .accessfn = access_fgt,
       .fieldoffset = offsetof(CPUARMState, cp15.fgt_exec[FGTREG_HFGITR]) },
 };
@@ -8348,12 +8362,14 @@ static const ARMCPRegInfo vhe_reginfo[] = {
       .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 2, .opc2 = 1,
       .type = ARM_CP_IO | ARM_CP_ALIAS,
       .access = PL2_RW, .accessfn = e2h_access,
+      .nv2_redirect_offset = 0x180 | NV2_REDIR_NO_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].ctl),
       .writefn = gt_phys_ctl_write, .raw_writefn = raw_write },
     { .name = "CNTV_CTL_EL02", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 3, .opc2 = 1,
       .type = ARM_CP_IO | ARM_CP_ALIAS,
       .access = PL2_RW, .accessfn = e2h_access,
+      .nv2_redirect_offset = 0x170 | NV2_REDIR_NO_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].ctl),
       .writefn = gt_virt_ctl_write, .raw_writefn = raw_write },
     { .name = "CNTP_TVAL_EL02", .state = ARM_CP_STATE_AA64,
@@ -8370,11 +8386,13 @@ static const ARMCPRegInfo vhe_reginfo[] = {
       .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 2, .opc2 = 2,
       .type = ARM_CP_IO | ARM_CP_ALIAS,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].cval),
+      .nv2_redirect_offset = 0x178 | NV2_REDIR_NO_NV1,
       .access = PL2_RW, .accessfn = e2h_access,
       .writefn = gt_phys_cval_write, .raw_writefn = raw_write },
     { .name = "CNTV_CVAL_EL02", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 3, .opc2 = 2,
       .type = ARM_CP_IO | ARM_CP_ALIAS,
+      .nv2_redirect_offset = 0x168 | NV2_REDIR_NO_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].cval),
       .access = PL2_RW, .accessfn = e2h_access,
       .writefn = gt_virt_cval_write, .raw_writefn = raw_write },
-- 
2.34.1


