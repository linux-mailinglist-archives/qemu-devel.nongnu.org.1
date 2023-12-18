Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7893C816C76
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:38:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBs8-0006dU-Dd; Mon, 18 Dec 2023 06:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs4-0006a6-KE
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:16 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBrz-0003Hv-Nn
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:16 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3366920db54so496470f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899190; x=1703503990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EyJRCO1XP4DU5/IhvXG3T58MrbkI/dO5YbOl9jkE3SQ=;
 b=C229Yu/9emIuvYDu/WHHDbUpw0rNT12mTeh2ROXtOCVYCj+SE+L7idAeZJsJUztekw
 OvjmKpCJL7O9L6aq3ANbD5Iy7iZJdHk+Gi3IAgObZuSMWfsLapg1XUXd2CqaCi449f+U
 WUiaaMyZMJqQ5xvsOD1pfqmmd1wiTFSvb5zQCB3sDNR9Hho3EagRcgJD99m2WgQs/iu9
 oSjYXBwQgL3r/fMErYpNLU6+bIBT6EfzHW28JhNx6MNJXwMWJumYOOjmTCZgou7Qla7/
 ycOIGUB1SuMGVqpqWWyBwSJnF12VrUPG27X9KmtgN7/KYbPXelvtrVXA9jRLJWODbZKP
 Unbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899190; x=1703503990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EyJRCO1XP4DU5/IhvXG3T58MrbkI/dO5YbOl9jkE3SQ=;
 b=wVLwakmQ6nUK4eOUSP/A/kCrFKuTMoYhaUgYe3OW67zdFbA9z9BZBPQfwDtf/Ybl/6
 QIUYWVqirAEkE9mCF0QbJBgL2bMvb9qxjB1aDJYnjrEIRlxBy27of74K+/e8CQBWTKpA
 sEBffGBYXNQwnx0AnoCEPHjih+MqNv0v2QDtkscjtbIelYZNZV6d9a69X9fX5m1IGr/d
 aHP80BB5l8TFNjodKiCQJy24uc6TM2K7lPcM/XYEPYe73LH+itzQAluo95nUJsKacM8J
 kI2Ig0FF5bBuDkhqnsAFvmnjKHqM3Hr8Be8wt3zqXF7UfVSwXkATwGTDVq2N+q5hubLk
 oCCg==
X-Gm-Message-State: AOJu0YyVI0DAU7lda5cq0NTmZoJ5hXCUVsoM+2TYDDpuIIPKWlmzdj4u
 kpQ34fRQCzqbapXUJwX5ZgiNCZTeEHxqV8xIjYI=
X-Google-Smtp-Source: AGHT+IE+kIAFQftHkCxTT3DqNWZpBJ3l0IKcYytYp5I79l1J66S6eqcmkUv5unfBH8i+VxJ9xeiL1Q==
X-Received: by 2002:adf:f90e:0:b0:333:3821:2339 with SMTP id
 b14-20020adff90e000000b0033338212339mr3735967wrr.192.1702899190061; 
 Mon, 18 Dec 2023 03:33:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 07/35] target/arm: Always honour HCR_EL2.TSC when HCR_EL2.NV
 is set
Date: Mon, 18 Dec 2023 11:32:37 +0000
Message-Id: <20231218113305.2511480-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

The HCR_EL2.TSC trap for trapping EL1 execution of SMC instructions
has a behaviour change for FEAT_NV when EL3 is not implemented:

 * in older architecture versions TSC was required to have no
   effect (i.e. the SMC insn UNDEFs)
 * with FEAT_NV, when HCR_EL2.NV == 1 the trap must apply
   (i.e. SMC traps to EL2, as it already does in all cases when
   EL3 is implemented)
 * in newer architecture versions, the behaviour either without
   FEAT_NV or with FEAT_NV and HCR_EL2.NV == 0 is relaxed to
   an IMPDEF choice between UNDEF and trap-to-EL2 (i.e. it is
   permitted to always honour HCR_EL2.TSC) for AArch64 only

Add the condition to honour the trap bit when HCR_EL2.NV == 1.  We
leave the HCR_EL2.NV == 0 case with the existing (UNDEF) behaviour,
as our IMPDEF choice (both because it avoids a behaviour change
for older CPU models and because we'd have to distinguish AArch32
from AArch64 if we opted to trap to EL2).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/op_helper.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index ea08936a852..ae158200c00 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -930,7 +930,14 @@ void HELPER(pre_smc)(CPUARMState *env, uint32_t syndrome)
      *
      *  Conduit SMC, valid call  Trap to EL2         PSCI Call
      *  Conduit SMC, inval call  Trap to EL2         Undef insn
-     *  Conduit not SMC          Undef insn          Undef insn
+     *  Conduit not SMC          Undef or trap[1]    Undef insn
+     *
+     * [1] In this case:
+     *  - if HCR_EL2.NV == 1 we must trap to EL2
+     *  - if HCR_EL2.NV == 0 then newer architecture revisions permit
+     *    AArch64 (but not AArch32) to trap to EL2 as an IMPDEF choice
+     *  - otherwise we must UNDEF
+     * We take the IMPDEF choice to always UNDEF if HCR_EL2.NV == 0.
      */
 
     /* On ARMv8 with EL3 AArch64, SMD applies to both S and NS state.
@@ -944,9 +951,12 @@ void HELPER(pre_smc)(CPUARMState *env, uint32_t syndrome)
                                                      : smd_flag && !secure;
 
     if (!arm_feature(env, ARM_FEATURE_EL3) &&
+        !(arm_hcr_el2_eff(env) & HCR_NV) &&
         cpu->psci_conduit != QEMU_PSCI_CONDUIT_SMC) {
-        /* If we have no EL3 then SMC always UNDEFs and can't be
-         * trapped to EL2. PSCI-via-SMC is a sort of ersatz EL3
+        /*
+         * If we have no EL3 then traditionally SMC always UNDEFs and can't be
+         * trapped to EL2. For nested virtualization, SMC can be trapped to
+         * the outer hypervisor. PSCI-via-SMC is a sort of ersatz EL3
          * firmware within QEMU, and we want an EL2 guest to be able
          * to forbid its EL1 from making PSCI calls into QEMU's
          * "firmware" via HCR.TSC, so for these purposes treat
-- 
2.34.1


