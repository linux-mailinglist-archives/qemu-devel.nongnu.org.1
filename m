Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFB3816C69
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:38:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsC-0006ng-MF; Mon, 18 Dec 2023 06:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsA-0006fq-3v
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:22 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs3-0003JU-9H
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:21 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33663adf953so823796f8f.3
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899193; x=1703503993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=urpNXs3M+FF7oEZo8r64KFSKVJx1Gqyt4aD/88KuZTA=;
 b=YmyqRQ/W/TQ4gZTQaHqKSFfO260i5ukf3iSlBJLlLtNnyWXclvm9rItmWPfW/oxyIq
 Xo9zlEObmHrC1MPhgmbTRJgSobX6Op/iyw026cK353mjbdLvZS0wxGGZpSH8YEBHQxt9
 9bafp21hdkpUKLDQBUJ7BTLLMdsmXhaKtS2vS/Hz3oRGfQP7VKu6BeGVvm1INRM+r4m1
 yqbwjvsZCgq+knchmKJYQEohbsZ9aTgKfyIyFvfnQyTN7V+crhInd/L0qkz7AVPMyosI
 rE2Krze8z1XTc2u02pEpGoTgHkSD34FrNy5fFX0bOih/bbgi4w6f2Dbg7aS3I05pPiD1
 mNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899193; x=1703503993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=urpNXs3M+FF7oEZo8r64KFSKVJx1Gqyt4aD/88KuZTA=;
 b=uwAV2L6n/liDfhtoGTu6gEj45fpyf17vB6Sd5AmSEkThRFZK+t36NhB6wU7jgA1TsU
 mEW+6ZvvM51Qulq276CTrtrWTRSXHLjxI9Ymd0gSZFjhmmy7Z11B1D2FbZkW2z8YBSj6
 M7ZHaoNa0MnlCdGRAqL9ggswiauSXyk7MaCG0xy1sTBGpd4iSQnWuGJkL2JZCxawxyfB
 rEIXzBXWVWGEE6+MR6Pu3bWguDaXIq8i8exM/9MvMPk9L6HmWzROZJNevodYLSqhWVHz
 7S4ubP33I5M8CuDvoQ6z/MAw0lET5GfN4KVQML4LQgND4WFGpi+QGcnVQ+pRchT3Kg8+
 PzOA==
X-Gm-Message-State: AOJu0YzDUqqsPZnxgV//QsfRm+lDJdfh8euc4k0dDRb1IXWyj7nRtVJu
 WkKy9d61sAB92cK480vx7XxM5BUopr/9UHbILD4=
X-Google-Smtp-Source: AGHT+IH24PuCtyxK6QZzN4eDr+CT6vkW/YDeulOW/8UtImR9tYbb78RpHnRwxl+TI65vGkgBRoXHGQ==
X-Received: by 2002:a05:6000:881:b0:333:2fd2:5210 with SMTP id
 cs1-20020a056000088100b003332fd25210mr7322748wrb.137.1702899192811; 
 Mon, 18 Dec 2023 03:33:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 13/35] target/arm: Trap sysreg accesses for FEAT_NV
Date: Mon, 18 Dec 2023 11:32:43 +0000
Message-Id: <20231218113305.2511480-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
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

For FEAT_NV, accesses to system registers and instructions from EL1
which would normally UNDEF there but which work in EL2 need to
instead be trapped to EL2. Detect this both for "we know this will
UNDEF at translate time" and "we found this UNDEFs at runtime", and
make the affected registers trap to EL2 instead.

The Arm ARM defines the set of registers that should trap in terms
of their names; for our implementation this would be both awkward
and inefficent as a test, so we instead trap based on the opc1
field of the sysreg. The regularity of the architectural choice
of encodings for sysregs means that in practice this captures
exactly the correct set of registers.

Regardless of how we try to define the registers this trapping
applies to, there's going to be a certain possibility of breakage
if new architectural features introduce new registers that don't
follow the current rules (FEAT_MEC is one example already visible
in the released sysreg XML, though not yet in the Arm ARM). This
approach seems to me to be straightforward and likely to require
a minimum of manual overrides.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h            | 34 +++++++++++++++++++++++
 target/arm/cpu.h               |  1 +
 target/arm/tcg/translate.h     |  2 ++
 target/arm/tcg/hflags.c        |  1 +
 target/arm/tcg/translate-a64.c | 49 +++++++++++++++++++++++++++-------
 5 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index e748d184cb6..3c5f1b48879 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -1080,4 +1080,38 @@ void define_cortex_a72_a57_a53_cp_reginfo(ARMCPU *cpu);
 
 CPAccessResult access_tvm_trvm(CPUARMState *, const ARMCPRegInfo *, bool);
 
+/**
+ * arm_cpreg_trap_in_nv: Return true if cpreg traps in nested virtualization
+ *
+ * Return true if this cpreg is one which should be trapped to EL2 if
+ * it is executed at EL1 when nested virtualization is enabled via HCR_EL2.NV.
+ */
+static inline bool arm_cpreg_traps_in_nv(const ARMCPRegInfo *ri)
+{
+    /*
+     * The Arm ARM defines the registers to be trapped in terms of
+     * their names (I_TZTZL). However the underlying principle is "if
+     * it would UNDEF at EL1 but work at EL2 then it should trap", and
+     * the way the encoding of sysregs and system instructions is done
+     * means that the right set of registers is exactly those where
+     * the opc1 field is 4 or 5. (You can see this also in the assert
+     * we do that the opc1 field and the permissions mask line up in
+     * define_one_arm_cp_reg_with_opaque().)
+     * Checking the opc1 field is easier for us and avoids the problem
+     * that we do not consistently use the right architectural names
+     * for all sysregs, since we treat the name field as largely for debug.
+     *
+     * However we do this check, it is going to be at least potentially
+     * fragile to future new sysregs, but this seems the least likely
+     * to break.
+     *
+     * In particular, note that the released sysreg XML defines that
+     * the FEAT_MEC sysregs and instructions do not follow this FEAT_NV
+     * trapping rule, so we will need to add an ARM_CP_* flag to indicate
+     * "register does not trap on NV" to handle those if/when we implement
+     * FEAT_MEC.
+     */
+    return ri->opc1 == 4 || ri->opc1 == 5;
+}
+
 #endif /* TARGET_ARM_CPREGS_H */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 91157db85ae..0ec67847181 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3238,6 +3238,7 @@ FIELD(TBFLAG_A64, SME_TRAP_NONSTREAMING, 28, 1)
 FIELD(TBFLAG_A64, TRAP_ERET, 29, 1)
 FIELD(TBFLAG_A64, NAA, 30, 1)
 FIELD(TBFLAG_A64, ATA0, 31, 1)
+FIELD(TBFLAG_A64, NV, 32, 1)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 8c84377003c..63e075bce3a 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -144,6 +144,8 @@ typedef struct DisasContext {
     bool trap_eret;
     /* True if FEAT_LSE2 SCTLR_ELx.nAA is set */
     bool naa;
+    /* True if FEAT_NV HCR_EL2.NV is enabled */
+    bool nv;
     /*
      * >= 0, a copy of PSTATE.BTYPE, which will be 0 without v8.5-BTI.
      *  < 0, set by the current instruction.
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 560fb7964ab..f33c0a12741 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -299,6 +299,7 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
      */
     if (el == 1 && (hcr & HCR_NV)) {
         DP_TBFLAG_A64(flags, TRAP_ERET, 1);
+        DP_TBFLAG_A64(flags, NV, 1);
     }
 
     if (cpu_isar_feature(aa64_mte, env_archcpu(env))) {
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2d26cb6210f..d060e24356d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2131,16 +2131,17 @@ static void handle_sys(DisasContext *s, bool isread,
                                       crn, crm, op0, op1, op2);
     const ARMCPRegInfo *ri = get_arm_cp_reginfo(s->cp_regs, key);
     bool need_exit_tb = false;
+    bool nv_trap_to_el2 = false;
+    bool skip_fp_access_checks = false;
     TCGv_ptr tcg_ri = NULL;
     TCGv_i64 tcg_rt;
-    uint32_t syndrome;
+    uint32_t syndrome = syn_aa64_sysregtrap(op0, op1, op2, crn, crm, rt, isread);
 
     if (crn == 11 || crn == 15) {
         /*
          * Check for TIDCP trap, which must take precedence over
          * the UNDEF for "no such register" etc.
          */
-        syndrome = syn_aa64_sysregtrap(op0, op1, op2, crn, crm, rt, isread);
         switch (s->current_el) {
         case 0:
             if (dc_isar_feature(aa64_tidcp1, s)) {
@@ -2166,15 +2167,35 @@ static void handle_sys(DisasContext *s, bool isread,
 
     /* Check access permissions */
     if (!cp_access_ok(s->current_el, ri, isread)) {
-        gen_sysreg_undef(s, isread, op0, op1, op2, crn, crm, rt);
-        return;
+        /*
+         * FEAT_NV/NV2 handling does not do the usual FP access checks
+         * for registers only accessible at EL2 (though it *does* do them
+         * for registers accessible at EL1).
+         */
+        skip_fp_access_checks = true;
+        if (s->nv && arm_cpreg_traps_in_nv(ri)) {
+            /*
+             * This register / instruction exists and is an EL2 register, so
+             * we must trap to EL2 if accessed in nested virtualization EL1
+             * instead of UNDEFing. We'll do that after the usual access checks.
+             * (This makes a difference only for a couple of registers likee
+             * VSTTBR_EL2 where the "UNDEF if NonSecure" should take priority
+             * over the trap-to-EL2. Most trapped-by-FEAT_NV registers have
+             * an accessfn which does nothing when called from EL1, because
+             * the trap-to-EL3 controls which would apply to that register
+             * at EL2 don't take priority over the FEAT_NV trap-to-EL2.)
+             */
+            nv_trap_to_el2 = true;
+        } else {
+            gen_sysreg_undef(s, isread, op0, op1, op2, crn, crm, rt);
+            return;
+        }
     }
 
     if (ri->accessfn || (ri->fgt && s->fgt_active)) {
         /* Emit code to perform further access permissions checks at
          * runtime; this may result in an exception.
          */
-        syndrome = syn_aa64_sysregtrap(op0, op1, op2, crn, crm, rt, isread);
         gen_a64_update_pc(s, 0);
         tcg_ri = tcg_temp_new_ptr();
         gen_helper_access_check_cp_reg(tcg_ri, tcg_env,
@@ -2189,11 +2210,18 @@ static void handle_sys(DisasContext *s, bool isread,
         gen_a64_update_pc(s, 0);
     }
 
-    if ((ri->type & ARM_CP_FPU) && !fp_access_check_only(s)) {
-        return;
-    } else if ((ri->type & ARM_CP_SVE) && !sve_access_check(s)) {
-        return;
-    } else if ((ri->type & ARM_CP_SME) && !sme_access_check(s)) {
+    if (!skip_fp_access_checks) {
+        if ((ri->type & ARM_CP_FPU) && !fp_access_check_only(s)) {
+            return;
+        } else if ((ri->type & ARM_CP_SVE) && !sve_access_check(s)) {
+            return;
+        } else if ((ri->type & ARM_CP_SME) && !sme_access_check(s)) {
+            return;
+        }
+    }
+
+    if (nv_trap_to_el2) {
+        gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, 2);
         return;
     }
 
@@ -13997,6 +14025,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->pstate_za = EX_TBFLAG_A64(tb_flags, PSTATE_ZA);
     dc->sme_trap_nonstreaming = EX_TBFLAG_A64(tb_flags, SME_TRAP_NONSTREAMING);
     dc->naa = EX_TBFLAG_A64(tb_flags, NAA);
+    dc->nv = EX_TBFLAG_A64(tb_flags, NV);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.34.1


