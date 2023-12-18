Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B5F816C71
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:38:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBs6-0006bE-2F; Mon, 18 Dec 2023 06:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs3-0006Za-OX
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:15 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBry-0003Hg-Un
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:15 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-336668a5a8dso978281f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899189; x=1703503989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RGHbSdgWQToF9XoPUEdqhKpPWx7yHvt4xz3UKyzm5Bg=;
 b=K0tb4C/sh/RYGAVncMZmm4JvPTrd8Vjfo6S5PGeBuF29QLGfviH2YGa+7EKbCfcqYj
 kv6uK+PjXb0bwWlRFfGq3IYE+xgsgm4vz4E5pnQegCSUC70ZTCxadEIqe0UzcJFum3mz
 jwOoZfItcOlMJyjc8ZEejwXL3Rkk31vDJsHrJrS/LeYsXRYe6HOOn4J0EWU7Ydj29r0E
 8Q/Ol9u7fFDUJTNGz32UYbUIVmH4zwByWkA2dH8MbvnT9f8hm9MMfIOBTtCTa9wlL3hn
 bTiGQklwhlgY0/zw85YPdwwAJJMe/JRuJa22Y5pa/LL3cwBBh1SvgJu3jFBYVQHQDugN
 80Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899189; x=1703503989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RGHbSdgWQToF9XoPUEdqhKpPWx7yHvt4xz3UKyzm5Bg=;
 b=p4X8fDbQ4ip/1pexRQrOnWAE8xLv2ipsxsGY4vRH572TM/8f91Aa0CIDnKKzD/gMxx
 TzMt199a81NdHuWBrqPJXBaZpNdQb1IZb6j+lMGQZv0uPLn25vLRDmtXDW07inXxx1BU
 Oe/IOuDi3OtqmfUkTXHLu9NrvlpYTfIsQ5Jv8jY+53nk2icjypd8ilY1T4/1DGbAUfYJ
 AEBbQ2ATAdLN0bvPJadQLDKXtXzTasjPKzoLzi/guPGqAWbCTNTgwS6LE5t+DVgnlvzr
 UvZNhNs4y0NiFDsAk4fMrCLhgUetfwYfpd/4Aised79oznyLVObw7WN8xDLLYltM2PAY
 91Sg==
X-Gm-Message-State: AOJu0Yz1rM/sD9VQNI1hoQe4b7UQRp5D8R7LyIOlyBmOHYXJnekkv44q
 WkhYOd+LfPn4KCiBaPsewlknxw==
X-Google-Smtp-Source: AGHT+IFYhpZCU7uBmuw6oYM2pn7ZxaHz6JZOXfF0AY2DarSIT6SWpJGmyIPUHsc5qhIha6ykPkeDmg==
X-Received: by 2002:a5d:64aa:0:b0:336:6a76:87c with SMTP id
 m10-20020a5d64aa000000b003366a76087cmr613837wrp.40.1702899189591; 
 Mon, 18 Dec 2023 03:33:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/35] target/arm: Enable trapping of ERET for FEAT_NV
Date: Mon, 18 Dec 2023 11:32:36 +0000
Message-Id: <20231218113305.2511480-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

When FEAT_NV is turned on via the HCR_EL2.NV bit, ERET instructions
are trapped, with the same syndrome information as for the existing
FEAT_FGT fine-grained trap (in the pseudocode this is handled in
AArch64.CheckForEretTrap()).

Rename the DisasContext and tbflag bits to reflect that they are
no longer exclusively for FGT traps, and set the tbflag bit when
FEAT_NV is enabled as well as when the FGT is enabled.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               |  2 +-
 target/arm/tcg/translate.h     |  4 ++--
 target/arm/tcg/hflags.c        | 11 ++++++++++-
 target/arm/tcg/translate-a64.c |  6 +++---
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a0282e0d281..167b3759ac9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3235,7 +3235,7 @@ FIELD(TBFLAG_A64, PSTATE_ZA, 23, 1)
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
index a2e49c39f9f..00d12e148ca 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1605,7 +1605,7 @@ static bool trans_ERET(DisasContext *s, arg_ERET *a)
     if (s->current_el == 0) {
         return false;
     }
-    if (s->fgt_eret) {
+    if (s->trap_eret) {
         gen_exception_insn_el(s, 0, EXCP_UDEF, syn_erettrap(0), 2);
         return true;
     }
@@ -1632,7 +1632,7 @@ static bool trans_ERETA(DisasContext *s, arg_reta *a)
         return false;
     }
     /* The FGT trap takes precedence over an auth trap. */
-    if (s->fgt_eret) {
+    if (s->trap_eret) {
         gen_exception_insn_el(s, 0, EXCP_UDEF, syn_erettrap(a->m ? 3 : 2), 2);
         return true;
     }
@@ -13979,7 +13979,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
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


