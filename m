Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3716816C63
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:37:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsV-00079F-20; Mon, 18 Dec 2023 06:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsJ-00076M-Og
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:31 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs9-0003Nd-HW
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:31 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-336668a5a8dso978402f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899200; x=1703504000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z7QW8HRv+OdPPQfiZWYsUh8DiaaeWI6g2SxQoB+HBCo=;
 b=RKMA4up7J6tkfvw9L+xRRJ3WEeXNIF0sSbj4FAn/yJGj+F/XVJwICyIKcKNsgpxF7N
 vYUvcqFM8c0EUMfFQcfC8DQwHCdxnbhkR0Woar/rCFK9PQguz4/7IGkYPcq2A622HxXo
 jpr6Ae05Y1oPnGgCGTB1IgSucDJmeY84DEARQmre4O6lYkMoEaSrEDHAVM13pEmHDz8w
 Mma7thXsqV2kBGqeI1U8x+4uiUXOxVxqQFwe3aSRI4Ef2sSWIn1+IUMjf4/ZUYW7Nb77
 uEvtZgMdA0XSHzcsslVvzfjtK8PDT9yiaDc484VUhLf6K9RF9V1GSeij3K2gQrwvMnFK
 ZnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899200; x=1703504000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z7QW8HRv+OdPPQfiZWYsUh8DiaaeWI6g2SxQoB+HBCo=;
 b=SVbFNMRA7kX8KzftYK8WMdMNQVqsZ2wRF5WN0gpdV2nGS/AVXQ91Lf8wuS6VlL4pa2
 IpsBoVZII2caz53ZO9VGH1ClB9E8clC0FsXxbanu7FhVQm/zWw7rjoCgHmUV2uRBFzzZ
 5Vfgaths0RyDricE/m0pfT0V6X4xwtuT2cunAENfGfPQZIy/yn/IshPiLtFWxGUilmEN
 +kbvYc+KCs3dTCoG4rjxU4jZlPIJR2Aksr8Rv2zFIiqE4x3rvV582+xktJWebbaXXC9o
 Md3MoCDIi9FRnrC4mOupnvewGCRDQgCJqlfkBIQ39beLjoU9zafrvzx7jzK5bwuKePN5
 fUOA==
X-Gm-Message-State: AOJu0Yz+9prkSvQSIMSg0anJB6mcyK2kBNVHpetFdf7lH65tGCMILVx6
 lBj8oOo9D1HwKGiclyuK8BgPfWYtuDTvP992EzY=
X-Google-Smtp-Source: AGHT+IEg2OrL+46VK0iq2bU6MtV5rWjBDYULpVVIdCSBJzQnR/h/I3vHMaHggYTLTLONYRhYO7DrEA==
X-Received: by 2002:adf:ea0a:0:b0:336:6054:7dda with SMTP id
 q10-20020adfea0a000000b0033660547ddamr1657181wrm.131.1702899200310; 
 Mon, 18 Dec 2023 03:33:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 28/35] target/arm: Mark up VNCR offsets (offsets 0x0..0xff)
Date: Mon, 18 Dec 2023 11:32:58 +0000
Message-Id: <20231218113305.2511480-29-peter.maydell@linaro.org>
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
the Arm ARM. This commit covers offsets below 0x100; all of these
registers are redirected to memory regardless of the value of
HCR_EL2.NV1.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 61aac61bcc4..ff7f90fa4af 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6043,6 +6043,7 @@ static const ARMCPRegInfo hcrx_el2_reginfo = {
     .name = "HCRX_EL2", .state = ARM_CP_STATE_AA64,
     .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 2, .opc2 = 2,
     .access = PL2_RW, .writefn = hcrx_write, .accessfn = access_hxen,
+    .nv2_redirect_offset = 0xa0,
     .fieldoffset = offsetof(CPUARMState, cp15.hcrx_el2),
 };
 
@@ -6109,6 +6110,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .type = ARM_CP_IO,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.hcr_el2),
+      .nv2_redirect_offset = 0x78,
       .writefn = hcr_write, .raw_writefn = raw_write },
     { .name = "HCR", .state = ARM_CP_STATE_AA32,
       .type = ARM_CP_ALIAS | ARM_CP_IO,
@@ -6193,6 +6195,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "VTCR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 2,
       .access = PL2_RW,
+      .nv2_redirect_offset = 0x40,
       /* no .writefn needed as this can't cause an ASID change */
       .fieldoffset = offsetof(CPUARMState, cp15.vtcr_el2) },
     { .name = "VTTBR", .state = ARM_CP_STATE_AA32,
@@ -6204,6 +6207,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "VTTBR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 0,
       .access = PL2_RW, .writefn = vttbr_write, .raw_writefn = raw_write,
+      .nv2_redirect_offset = 0x20,
       .fieldoffset = offsetof(CPUARMState, cp15.vttbr_el2) },
     { .name = "SCTLR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 0, .opc2 = 0,
@@ -6212,6 +6216,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "TPIDR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 13, .crm = 0, .opc2 = 2,
       .access = PL2_RW, .resetvalue = 0,
+      .nv2_redirect_offset = 0x90,
       .fieldoffset = offsetof(CPUARMState, cp15.tpidr_el[2]) },
     { .name = "TTBR0_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 0,
@@ -6307,6 +6312,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 0, .opc2 = 3,
       .access = PL2_RW, .type = ARM_CP_IO, .resetvalue = 0,
       .writefn = gt_cntvoff_write,
+      .nv2_redirect_offset = 0x60,
       .fieldoffset = offsetof(CPUARMState, cp15.cntvoff_el2) },
     { .name = "CNTVOFF", .cp = 15, .opc1 = 4, .crm = 14,
       .access = PL2_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS | ARM_CP_IO,
@@ -6345,6 +6351,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "HSTR_EL2", .state = ARM_CP_STATE_BOTH,
       .cp = 15, .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 3,
       .access = PL2_RW,
+      .nv2_redirect_offset = 0x80,
       .fieldoffset = offsetof(CPUARMState, cp15.hstr_el2) },
 };
 
@@ -6370,10 +6377,12 @@ static const ARMCPRegInfo el2_sec_cp_reginfo[] = {
     { .name = "VSTTBR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 6, .opc2 = 0,
       .access = PL2_RW, .accessfn = sel2_access,
+      .nv2_redirect_offset = 0x30,
       .fieldoffset = offsetof(CPUARMState, cp15.vsttbr_el2) },
     { .name = "VSTCR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 6, .opc2 = 2,
       .access = PL2_RW, .accessfn = sel2_access,
+      .nv2_redirect_offset = 0x48,
       .fieldoffset = offsetof(CPUARMState, cp15.vstcr_el2) },
 };
 
@@ -8131,6 +8140,7 @@ static const ARMCPRegInfo nv2_reginfo[] = {
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 2, .opc2 = 0,
       .access = PL2_RW,
       .writefn = vncr_write,
+      .nv2_redirect_offset = 0xb0,
       .fieldoffset = offsetof(CPUARMState, cp15.vncr_el2) },
 };
 
@@ -8962,6 +8972,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 4, .crn = 0, .crm = 0, .opc2 = 0,
               .access = PL2_RW, .resetvalue = cpu->midr,
               .type = ARM_CP_EL3_NO_EL2_C_NZ,
+              .nv2_redirect_offset = 0x88,
               .fieldoffset = offsetof(CPUARMState, cp15.vpidr_el2) },
             { .name = "VMPIDR", .state = ARM_CP_STATE_AA32,
               .cp = 15, .opc1 = 4, .crn = 0, .crm = 0, .opc2 = 5,
@@ -8973,6 +8984,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 4, .crn = 0, .crm = 0, .opc2 = 5,
               .access = PL2_RW, .resetvalue = vmpidr_def,
               .type = ARM_CP_EL3_NO_EL2_C_NZ,
+              .nv2_redirect_offset = 0x50,
               .fieldoffset = offsetof(CPUARMState, cp15.vmpidr_el2) },
         };
         /*
-- 
2.34.1


