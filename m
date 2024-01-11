Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C99AF82ACE7
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:08:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssg-0001ZD-Ke; Thu, 11 Jan 2024 06:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssN-0001PV-9T
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:31 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssH-0004XX-Um
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:30 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e54b2e437so22224005e9.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971123; x=1705575923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HjbFqOWn/TNSc9et6xxdifrEZI+6S3bwTcQGRjFtcY4=;
 b=TkmOJpH3XsOxFLEDJc+vidQcHmFsJm4AcE4ih+O4ivlt9UWQwBGdqJuzcZy4BVqbwL
 VgFkCIIv1vzlVcl/BMfwkPkX+yuAwyvLW6pPr0tnLFHOfpMXvC77dPl55E7d86eFN5ws
 0JQa3yKbZoJAtRsXZ5gIWyorISN6gmr40rfnmBZSLsGxzndqkuqPXRU/ck2il/VE9WgU
 Ka/qWB7tD3N0LnJNdJkYhIkZdL0veB6oGj3CdREaS84LqZM8Zdwn7vje4UxqVqGmYpaU
 4l1CtjwKXKtnR2YO4hGaqkyCp/wdaoOMyPgIc7QAS50jAzCDX7O22LBoHd8uvthieQtI
 h4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971123; x=1705575923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HjbFqOWn/TNSc9et6xxdifrEZI+6S3bwTcQGRjFtcY4=;
 b=r3NIXjhw+U8LKOhHJKJwD7WO0FA5LFnwFH92qkCrqNSeE03uiXo4yWJzXlhh0HcZOi
 8lC8AEi0eliSr33pOdwFcZD18GF+wOET8P2jjI4MmOrYRQ2dZR2CNAyzmZTaWANGmk7i
 LgjKZZPG7lPHDSL5+R2CYhFEXZSnEi2puE1LUbYtr3i24jGNOaRPUEqFCO/oNfLO/WEz
 0Jf9Qt1jT3jBSuFCXsujTV5Oa5zD5Be6KF59ypVj3slug/aTgBcoUmOqub2SDSGxflYp
 RPNNsCvMYdTem2QzfNpnOTanw+WFbQxVExkaxQKBAgodn1mRG39BrUOf6pvk/2gizhqG
 e6VQ==
X-Gm-Message-State: AOJu0YzbXPuZa5OvRPmN5wA4SfjTRqr45bUEBicstnlyqvKuEeNgF1Cj
 XRDzBoExVh1HvIf9rBEEH7XwlTtScgRpx/M0iEaZFRsz33c=
X-Google-Smtp-Source: AGHT+IE/sPSZZPsCY5jZsS0z5tILk+1K0PeTw31TDh9i5+dOdfwQwcpzC0osduDYVNg79evRsmycvQ==
X-Received: by 2002:a05:600c:3491:b0:40e:5d36:8bb0 with SMTP id
 a17-20020a05600c349100b0040e5d368bb0mr271602wmq.44.1704971123180; 
 Thu, 11 Jan 2024 03:05:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/41] target/arm: Mark up VNCR offsets (offsets >= 0x200,
 except GIC)
Date: Thu, 11 Jan 2024 11:05:01 +0000
Message-Id: <20240111110505.1563291-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index aa66f5169ab..4550ff7ffde 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4287,6 +4287,7 @@ static const ARMCPRegInfo vmsa_pmsa_cp_reginfo[] = {
       .opc0 = 3, .crn = 6, .crm = 0, .opc1 = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_FAR_EL1,
+      .nv2_redirect_offset = 0x220 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.far_el[1]),
       .resetvalue = 0, },
 };
@@ -4302,6 +4303,7 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_TTBR0_EL1,
+      .nv2_redirect_offset = 0x200 | NV2_REDIR_NV1,
       .writefn = vmsa_ttbr_write, .resetvalue = 0, .raw_writefn = raw_write,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
                              offsetof(CPUARMState, cp15.ttbr0_ns) } },
@@ -4309,6 +4311,7 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 1,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_TTBR1_EL1,
+      .nv2_redirect_offset = 0x210 | NV2_REDIR_NV1,
       .writefn = vmsa_ttbr_write, .resetvalue = 0, .raw_writefn = raw_write,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
                              offsetof(CPUARMState, cp15.ttbr1_ns) } },
@@ -5741,6 +5744,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 0, .opc2 = 1,
       .access = PL1_RW, .accessfn = access_nv1,
+      .nv2_redirect_offset = 0x230 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, elr_el[1]) },
     { .name = "SPSR_EL1", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
@@ -5760,6 +5764,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, sp_el[0]) },
     { .name = "SP_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 1, .opc2 = 0,
+      .nv2_redirect_offset = 0x240,
       .access = PL2_RW, .type = ARM_CP_ALIAS | ARM_CP_EL3_NO_EL2_KEEP,
       .fieldoffset = offsetof(CPUARMState, sp_el[1]) },
     { .name = "SPSel", .state = ARM_CP_STATE_AA64,
@@ -6882,9 +6887,11 @@ static const ARMCPRegInfo minimal_ras_reginfo[] = {
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
 
@@ -9548,6 +9555,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_RW, .writefn = vbar_write,
               .accessfn = access_nv1,
               .fgt = FGT_VBAR_EL1,
+              .nv2_redirect_offset = 0x250 | NV2_REDIR_NV1,
               .bank_fieldoffsets = { offsetof(CPUARMState, cp15.vbar_s),
                                      offsetof(CPUARMState, cp15.vbar_ns) },
               .resetvalue = 0 },
-- 
2.34.1


