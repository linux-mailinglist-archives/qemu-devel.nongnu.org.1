Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 769B082ACFD
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:10:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssW-0001Rm-4a; Thu, 11 Jan 2024 06:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss8-0001LT-3r
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:16 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss5-0004Pq-Sh
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:15 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33674f60184so4942779f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971112; x=1705575912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6ycUm1aTQ8P1D0oHh26lik8xW1H5/8FvjoM1bUhF2Zc=;
 b=wDgrbvmhbWSIzdiR2fx44GKIzie6iOpWq55sKHgYZPQTxVeFSCRFioRMZ2dPCuufC1
 H36cKJJAll5pdlRyObvvBCRj1d5lkAnekXJ2XYxs0Z4Ha78RetPf3JyPM50Wt1d29Fjc
 n1ZPYuAKzPEIYSib5e+AtlTBbWOdfhFNeLswZCTfhWQsJQgUtyodbjW43vMh+QSRVnKy
 11ggjtgnnNmagDKvg8WGpyKHYR59IyR7NLPS3yN6fHNNLoCRQ22oMOGCRpRE9/gXf+bO
 tmZIlYjKolHM1rgz2oj/Uf7m5Zbf6Wirbi1dYOM6IRDIH4ZWtrCQySokM+UNmb42efWU
 F0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971112; x=1705575912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ycUm1aTQ8P1D0oHh26lik8xW1H5/8FvjoM1bUhF2Zc=;
 b=hME/ssCH2FYeAzz7eOKj+dwDUtszM0DwES7PpyXMmu4gRi+ZgZIclU8OGJN10GWfIt
 RnZZTecsFHAOZsGCBn2QF+lXrQzoIEsq2fwSuLuuIZxxArgYA/M6NmY7/o0eNSQ60hg0
 y53fth876DZz5CpSzUeKNmIJVzej1bnRqijXvdKva73jidmWCIZ7HxXwZiisF+JOP+ya
 FGTJqtqs87vlIShNl8blTSnVWhCRMArxEGNQLh7qJJ0Rzn75xCcolFrL4H6tvs8hAfmi
 kgcVhYFpyZYCrZumn3B32tNsVudY/jUkVE5XSTSIiYe8LmJ+xKBW5Cb5vnzzMDyilO/k
 sF7w==
X-Gm-Message-State: AOJu0YyHWqAy/gLOFtmPnakYOipSk7ia96lbaDfx6Lpf0xJxW7R3J8Ch
 6o4inl6/hmuyqhMIRgj7bnxPl53RPE2H+O9V/7gQNIaCLcc=
X-Google-Smtp-Source: AGHT+IHYwHP/k/R565XeAOTItZeuq+BXFtiJiwgKDgg/JZddU7Ox/D72WPWiMooohxuW/ZBm5jkorg==
X-Received: by 2002:adf:e9c2:0:b0:333:39d4:ff80 with SMTP id
 l2-20020adfe9c2000000b0033339d4ff80mr494842wrn.90.1704971112529; 
 Thu, 11 Jan 2024 03:05:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/41] target/arm: Always honour HCR_EL2.TSC when HCR_EL2.NV is
 set
Date: Thu, 11 Jan 2024 11:04:37 +0000
Message-Id: <20240111110505.1563291-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/tcg/op_helper.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 105ab63ed75..b5ac26061c7 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -985,7 +985,14 @@ void HELPER(pre_smc)(CPUARMState *env, uint32_t syndrome)
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
@@ -999,9 +1006,12 @@ void HELPER(pre_smc)(CPUARMState *env, uint32_t syndrome)
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


