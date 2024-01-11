Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A65F882AD02
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:10:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssU-0001RZ-0C; Thu, 11 Jan 2024 06:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss8-0001LS-1S
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:16 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss5-0004PV-Oe
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:15 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e6275e9beso161175e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971112; x=1705575912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UXRcXu0KHC3KDr0EhA03orQJ3pMJ3fXxZkZHJokxdik=;
 b=dRBZzVMB+9dNxeAO2D3vJC6zdAMOnaI2673gYwFxehWyznFenB8XUBqyCY0nVSTXgZ
 st4L/Ivv6L5wU/M3Q9rN7TcJ9CmvwZYgwPA8rnUg6+XjYx2vwZnIaLgH84+kRaFj6FZP
 MKthQIOtYw+LKcs9lYie0B48tLI82yOAvjHKqRPfOXUO2iOv5EHkBZE5pGSgjSp4SdMe
 8TyYUjhf7by6pn/oFg1Qc90pmw9LEHIsKpFi23wpFk014NX4pyflWOqYw+N9UdUXswnD
 ghBWp/MAim0W+rBYbYm0hze2cwW9pO/Y0BJswa1/M1ck5uzr9lIB3AshwsZ9zfnnFMHM
 eRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971112; x=1705575912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UXRcXu0KHC3KDr0EhA03orQJ3pMJ3fXxZkZHJokxdik=;
 b=IRugoXmcsosxJZme8O8nPNF2cyFGu/oxFwBqN4NbOFIl61EOT/SDN3URDZ3TD3pBnB
 m/hpqCetV80+N6Z6n+JAczM5F5Wkm70Q0d04xuA0sA7kXo6dWnH0HydA9hzAzV+q27XD
 itHWQk/8JUyTHw1LMlB4XkmazLrJJEXNv5xA5+Ew/R9dxbYU0gjPlY6PBdCgUxRqTaz0
 /3zNwbE7V5lpzHXVvXk0x8AwP1g11N8NuBpRLwfJI+6KtuABkRv7wmqrZh45umDyesO+
 IOZAwt0ns0zxDdqhYdcuI2n8blajhpChmKhqI79m5pTocTaruywpvJbY1QfOHwHjBjfD
 X4TA==
X-Gm-Message-State: AOJu0YyK553gzmWNuquLreVvFScWH87+/jQ1GrEeezAUI268tT6wS+8V
 nPfE+M2P3dg2D5vGSK2nsUp6y0PCw+ampLkMLYO7Iql37ng=
X-Google-Smtp-Source: AGHT+IGhLeZ85eX7BmK7/YcJoQrCUIwxLBYXdFQtyj5TzunLUqfEmcc6Hyvef/A5Z/xoZSHcGTL1DA==
X-Received: by 2002:a05:600c:4f16:b0:40c:2394:1796 with SMTP id
 l22-20020a05600c4f1600b0040c23941796mr331979wmq.174.1704971112098; 
 Thu, 11 Jan 2024 03:05:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/41] target/arm: Enable trapping of ERET for FEAT_NV
Date: Thu, 11 Jan 2024 11:04:36 +0000
Message-Id: <20240111110505.1563291-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

When FEAT_NV is turned on via the HCR_EL2.NV bit, ERET instructions
are trapped, with the same syndrome information as for the existing
FEAT_FGT fine-grained trap (in the pseudocode this is handled in
AArch64.CheckForEretTrap()).

Rename the DisasContext and tbflag bits to reflect that they are
no longer exclusively for FGT traps, and set the tbflag bit when
FEAT_NV is enabled as well as when the FGT is enabled.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/cpu.h               |  2 +-
 target/arm/tcg/translate.h     |  4 ++--
 target/arm/tcg/hflags.c        | 11 ++++++++++-
 target/arm/tcg/translate-a64.c |  6 +++---
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8c3ca2e2319..8da6bfda228 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3232,7 +3232,7 @@ FIELD(TBFLAG_A64, PSTATE_ZA, 23, 1)
 FIELD(TBFLAG_A64, SVL, 24, 4)
 /* Indicates that SME Streaming mode is active, and SMCR_ELx.FA64 is not. */
 FIELD(TBFLAG_A64, SME_TRAP_NONSTREAMING, 28, 1)
-FIELD(TBFLAG_A64, FGT_ERET, 29, 1)
+FIELD(TBFLAG_A64, TRAP_ERET, 29, 1)
 FIELD(TBFLAG_A64, NAA, 30, 1)
 FIELD(TBFLAG_A64, ATA0, 31, 1)
 
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 3c3bb3431ad..8c84377003c 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -138,10 +138,10 @@ typedef struct DisasContext {
     bool mve_no_pred;
     /* True if fine-grained traps are active */
     bool fgt_active;
-    /* True if fine-grained trap on ERET is enabled */
-    bool fgt_eret;
     /* True if fine-grained trap on SVC is enabled */
     bool fgt_svc;
+    /* True if a trap on ERET is enabled (FGT or NV) */
+    bool trap_eret;
     /* True if FEAT_LSE2 SCTLR_ELx.nAA is set */
     bool naa;
     /*
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index a6ebd7571a3..560fb7964ab 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -169,6 +169,7 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     CPUARMTBFlags flags = {};
     ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
     uint64_t tcr = regime_tcr(env, mmu_idx);
+    uint64_t hcr = arm_hcr_el2_eff(env);
     uint64_t sctlr;
     int tbii, tbid;
 
@@ -285,13 +286,21 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     if (arm_fgt_active(env, el)) {
         DP_TBFLAG_ANY(flags, FGT_ACTIVE, 1);
         if (FIELD_EX64(env->cp15.fgt_exec[FGTREG_HFGITR], HFGITR_EL2, ERET)) {
-            DP_TBFLAG_A64(flags, FGT_ERET, 1);
+            DP_TBFLAG_A64(flags, TRAP_ERET, 1);
         }
         if (fgt_svc(env, el)) {
             DP_TBFLAG_ANY(flags, FGT_SVC, 1);
         }
     }
 
+    /*
+     * ERET can also be trapped for FEAT_NV. arm_hcr_el2_eff() takes care
+     * of "is EL2 enabled" and the NV bit can only be set if FEAT_NV is present.
+     */
+    if (el == 1 && (hcr & HCR_NV)) {
+        DP_TBFLAG_A64(flags, TRAP_ERET, 1);
+    }
+
     if (cpu_isar_feature(aa64_mte, env_archcpu(env))) {
         /*
          * Set MTE_ACTIVE if any access may be Checked, and leave clear
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f3b5b9124d0..0f30e71f9bd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1606,7 +1606,7 @@ static bool trans_ERET(DisasContext *s, arg_ERET *a)
     if (s->current_el == 0) {
         return false;
     }
-    if (s->fgt_eret) {
+    if (s->trap_eret) {
         gen_exception_insn_el(s, 0, EXCP_UDEF, syn_erettrap(0), 2);
         return true;
     }
@@ -1633,7 +1633,7 @@ static bool trans_ERETA(DisasContext *s, arg_reta *a)
         return false;
     }
     /* The FGT trap takes precedence over an auth trap. */
-    if (s->fgt_eret) {
+    if (s->trap_eret) {
         gen_exception_insn_el(s, 0, EXCP_UDEF, syn_erettrap(a->m ? 3 : 2), 2);
         return true;
     }
@@ -13980,7 +13980,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->pstate_il = EX_TBFLAG_ANY(tb_flags, PSTATE__IL);
     dc->fgt_active = EX_TBFLAG_ANY(tb_flags, FGT_ACTIVE);
     dc->fgt_svc = EX_TBFLAG_ANY(tb_flags, FGT_SVC);
-    dc->fgt_eret = EX_TBFLAG_A64(tb_flags, FGT_ERET);
+    dc->trap_eret = EX_TBFLAG_A64(tb_flags, TRAP_ERET);
     dc->sve_excp_el = EX_TBFLAG_A64(tb_flags, SVEEXC_EL);
     dc->sme_excp_el = EX_TBFLAG_A64(tb_flags, SMEEXC_EL);
     dc->vl = (EX_TBFLAG_A64(tb_flags, VL) + 1) * 16;
-- 
2.34.1


