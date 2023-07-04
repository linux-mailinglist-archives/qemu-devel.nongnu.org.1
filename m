Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB1D7476E4
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 18:38:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGj1A-0001GD-IC; Tue, 04 Jul 2023 12:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj15-0001F8-W7
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:40 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj13-0001nf-Nm
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:39 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3142a9ff6d8so4121326f8f.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 09:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688488596; x=1691080596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=woUU+HiOTdfeWxIkByv1Ka1J61xMATqCD7GSJSY7c+4=;
 b=bq6XGx6vIzYSjaikfzWWvuPStDyyihVJ6RmEwst1cS2Nn2PCwCXytz7UQxSlutQ0ww
 al4D3COamNfKCPU2sEJRZop1jg5GTt7Amf7VZvEgQJ2pavVNsWLd9JNFXB92t8cJDr+K
 0CUHkmLvg3P/DO8AAKKVV/+38ZQSJ9lWpYkgvhtw7KbwBjkYywHInm3/ikHiaZCMxzyf
 qKSmR8Iuf86JN9RiQMFFB9XveblG3IV7OJeMxq9ivQfkvso1DapPp+3/PctT9edl3dIl
 izTrw67sGF2VbbI1JK4xf7dvhmDTOc7/xMWExTwSsTjRUlLT2OTRcvNZHhR+AocxHFT4
 MJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688488596; x=1691080596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=woUU+HiOTdfeWxIkByv1Ka1J61xMATqCD7GSJSY7c+4=;
 b=gTcTEJZe2pTCU2nClXD+Df0OQdt3j8iTgQ0Z5nYhEJqzyKGvkGFHdCtaY9Bo/zDiTV
 rP6DeVV5ZZbUjUKFK8ODCgmpZKxUSCPlitWKk/90bFAJ4ueL/MiRlCl3wuJjOFt/sbX5
 F2XYm52xnnXHQfMecVHKxnjEu64MOcWT4Ha2r8mrG6xB/KeOTtnmxmUAh9l6UvQpm8a1
 1loojAuvH6fGectDGuSOy0leJJ1GppU0I4hk6E4LbeHE4+Xd5g6Q6YhfDRl31cjMt6vY
 PvZn6kYzkADwkDYcMoPiNP3VIc9VDHcd76bWog0ozDTg+TPtBtc6K9JZ677fHjy+Iobr
 hRSA==
X-Gm-Message-State: ABy/qLaaQ4pSp3T6KfWD75Jv2ej0p6TDEafDegDvHreRtUrtSfuhnHSE
 Sey8E1okAL+cMbLyidESHdO1gPZ5vTL7qvL2E2M=
X-Google-Smtp-Source: APBJJlFx4w0HbppuE2P6SCjoFzTPx5CejP6GKwKP3tgnWQDWw/xoc3KXKhgakJfCaL1sRlJPtV2bLg==
X-Received: by 2002:a5d:4f08:0:b0:314:10c1:881d with SMTP id
 c8-20020a5d4f08000000b0031410c1881dmr11021939wru.68.1688488596243; 
 Tue, 04 Jul 2023 09:36:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a056000014800b003143b032b7asm4354258wrx.116.2023.07.04.09.36.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 09:36:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/11] target/arm: Add raw_writes ops for register whose write
 induce TLB maintenance
Date: Tue,  4 Jul 2023 17:36:24 +0100
Message-Id: <20230704163634.3188465-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704163634.3188465-1-peter.maydell@linaro.org>
References: <20230704163634.3188465-1-peter.maydell@linaro.org>
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

From: Eric Auger <eric.auger@redhat.com>

Some registers whose 'cooked' writefns induce TLB maintenance do
not have raw_writefn ops defined. If only the writefn ops is set
(ie. no raw_writefn is provided), it is assumed the cooked also
work as the raw one. For those registers it is not obvious the
tlb_flush works on KVM mode so better/safer setting the raw write.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d08c058e424..a0b84efab52 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4189,14 +4189,14 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_TTBR0_EL1,
-      .writefn = vmsa_ttbr_write, .resetvalue = 0,
+      .writefn = vmsa_ttbr_write, .resetvalue = 0, .raw_writefn = raw_write,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
                              offsetof(CPUARMState, cp15.ttbr0_ns) } },
     { .name = "TTBR1_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 1,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_TTBR1_EL1,
-      .writefn = vmsa_ttbr_write, .resetvalue = 0,
+      .writefn = vmsa_ttbr_write, .resetvalue = 0, .raw_writefn = raw_write,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
                              offsetof(CPUARMState, cp15.ttbr1_ns) } },
     { .name = "TCR_EL1", .state = ARM_CP_STATE_AA64,
@@ -4456,13 +4456,13 @@ static const ARMCPRegInfo lpae_cp_reginfo[] = {
       .type = ARM_CP_64BIT | ARM_CP_ALIAS,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
                              offsetof(CPUARMState, cp15.ttbr0_ns) },
-      .writefn = vmsa_ttbr_write, },
+      .writefn = vmsa_ttbr_write, .raw_writefn = raw_write },
     { .name = "TTBR1", .cp = 15, .crm = 2, .opc1 = 1,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .type = ARM_CP_64BIT | ARM_CP_ALIAS,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
                              offsetof(CPUARMState, cp15.ttbr1_ns) },
-      .writefn = vmsa_ttbr_write, },
+      .writefn = vmsa_ttbr_write, .raw_writefn = raw_write },
 };
 
 static uint64_t aa64_fpcr_read(CPUARMState *env, const ARMCPRegInfo *ri)
@@ -5911,7 +5911,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .type = ARM_CP_IO,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.hcr_el2),
-      .writefn = hcr_write },
+      .writefn = hcr_write, .raw_writefn = raw_write },
     { .name = "HCR", .state = ARM_CP_STATE_AA32,
       .type = ARM_CP_ALIAS | ARM_CP_IO,
       .cp = 15, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
@@ -5983,6 +5983,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "TCR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 2,
       .access = PL2_RW, .writefn = vmsa_tcr_el12_write,
+      .raw_writefn = raw_write,
       .fieldoffset = offsetof(CPUARMState, cp15.tcr_el[2]) },
     { .name = "VTCR", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 2,
@@ -5999,10 +6000,10 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .type = ARM_CP_64BIT | ARM_CP_ALIAS,
       .access = PL2_RW, .accessfn = access_el3_aa32ns,
       .fieldoffset = offsetof(CPUARMState, cp15.vttbr_el2),
-      .writefn = vttbr_write },
+      .writefn = vttbr_write, .raw_writefn = raw_write },
     { .name = "VTTBR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 0,
-      .access = PL2_RW, .writefn = vttbr_write,
+      .access = PL2_RW, .writefn = vttbr_write, .raw_writefn = raw_write,
       .fieldoffset = offsetof(CPUARMState, cp15.vttbr_el2) },
     { .name = "SCTLR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 0, .opc2 = 0,
@@ -6014,7 +6015,8 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.tpidr_el[2]) },
     { .name = "TTBR0_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 0,
-      .access = PL2_RW, .resetvalue = 0, .writefn = vmsa_tcr_ttbr_el2_write,
+      .access = PL2_RW, .resetvalue = 0,
+      .writefn = vmsa_tcr_ttbr_el2_write, .raw_writefn = raw_write,
       .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[2]) },
     { .name = "HTTBR", .cp = 15, .opc1 = 4, .crm = 2,
       .access = PL2_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS,
@@ -6201,12 +6203,12 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
     { .name = "SCR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL3_RW, .fieldoffset = offsetof(CPUARMState, cp15.scr_el3),
-      .resetfn = scr_reset, .writefn = scr_write },
+      .resetfn = scr_reset, .writefn = scr_write, .raw_writefn = raw_write },
     { .name = "SCR",  .type = ARM_CP_ALIAS | ARM_CP_NEWEL,
       .cp = 15, .opc1 = 0, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_trap_aa32s_el1,
       .fieldoffset = offsetoflow32(CPUARMState, cp15.scr_el3),
-      .writefn = scr_write },
+      .writefn = scr_write, .raw_writefn = raw_write },
     { .name = "SDER32_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 1, .opc2 = 1,
       .access = PL3_RW, .resetvalue = 0,
@@ -7927,6 +7929,7 @@ static const ARMCPRegInfo vhe_reginfo[] = {
     { .name = "TTBR1_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 1,
       .access = PL2_RW, .writefn = vmsa_tcr_ttbr_el2_write,
+      .raw_writefn = raw_write,
       .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el[2]) },
 #ifndef CONFIG_USER_ONLY
     { .name = "CNTHV_CVAL_EL2", .state = ARM_CP_STATE_AA64,
-- 
2.34.1


