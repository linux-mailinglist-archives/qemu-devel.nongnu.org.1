Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFC182ACDE
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:07:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssU-0001Ri-PP; Thu, 11 Jan 2024 06:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssB-0001Ms-5V
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:19 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss8-0004RI-Kf
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:18 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e490c2115so24158575e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971115; x=1705575915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6RsxSjIcUD58WUOvXsMPtdbR5ZpZEnA1hGh8Q+e0BqA=;
 b=QL+xBxFVlqJr/5OX74AnruaCNI6/RnFHREfzzwQQhhaQVcmmtipG5vjdX16bZnBw8x
 8BTFW4PSFcZGBtk+afvRhS6+ktRzjBTLhUOo/zN/f3cvg3rFAZQwZ3YFkeWTos4Oln16
 t0kg2zTq6yn/+QY3zUBWNicuy0NARpJoknNBay6c2mSiGAFX3STNMt2hRZ50z6rkSqfN
 I7dliTONOJ5vJppwtx31lSQ2eGh4fpx9mSGC/4g9AMFmtUnsqFGLk9InUObb9b6SlX9g
 93qpbPIq7fgjapB+LHVQ4HGGbv3wnmMY7Bcb8V6k27cm91MzALjnDyVMemRWJVQUxRIw
 nWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971115; x=1705575915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6RsxSjIcUD58WUOvXsMPtdbR5ZpZEnA1hGh8Q+e0BqA=;
 b=AxWkub4UisVF/PtN5Iy9Hpn4qKUuMGJqB6BB/iQ9rtWRdS0jZwgmqAZcg1yLMAnP7S
 SPZvp4g0OwY7jF4Y5rqSdO4hPyidtpWh0s5hE4oGzJ/fOupWVvU1HHanUSVKOjs89Wik
 keidghdHL3sRK4v1+nXB4sHv5tb+LUyPGy1mpccuPVaicd+rRKejH+mTVEZ5OXg+6TQq
 Hkxw8oMHSY6VdZGItQM+HWFeNR9U/J5zE2e06iIMQ6W07CzmjS/9unxg4Eyd+p0p+0gG
 XHMRSXNT4hKLV9+se9AQ18AhAATjkbp8B3QgB5TbW2y5Eu9JsN9siTGpqsbmkK2Vqrs0
 txUQ==
X-Gm-Message-State: AOJu0YxWN1yEox30tdy0WnfHmXUNIANx6HMB98XIQ9RDudmSHBz1QT6K
 xuFgeh00HNr06WXwHcl6+zOZdeXgDGU7bT4h4eSe9HF/SW4=
X-Google-Smtp-Source: AGHT+IG79IACIsPFIwnWABakgWy4Tl67Vi06UXHoKQO/RCkYFjK31aIOTHYh5XLayCb9axiGTbkKxQ==
X-Received: by 2002:a05:600c:4f12:b0:40d:8850:a988 with SMTP id
 l18-20020a05600c4f1200b0040d8850a988mr386238wmq.5.1704971114990; 
 Thu, 11 Jan 2024 03:05:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/41] target/arm: Trap sysreg accesses for FEAT_NV
Date: Thu, 11 Jan 2024 11:04:43 +0000
Message-Id: <20240111110505.1563291-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
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
index 6dd0f642581..d7a10fb4b61 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3235,6 +3235,7 @@ FIELD(TBFLAG_A64, SME_TRAP_NONSTREAMING, 28, 1)
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
index 5975fc47930..f5377dbaf2d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2132,16 +2132,17 @@ static void handle_sys(DisasContext *s, bool isread,
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
@@ -2167,15 +2168,35 @@ static void handle_sys(DisasContext *s, bool isread,
 
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
+             * (This makes a difference only for a couple of registers like
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
@@ -2190,11 +2211,18 @@ static void handle_sys(DisasContext *s, bool isread,
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
 
@@ -13998,6 +14026,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->pstate_za = EX_TBFLAG_A64(tb_flags, PSTATE_ZA);
     dc->sme_trap_nonstreaming = EX_TBFLAG_A64(tb_flags, SME_TRAP_NONSTREAMING);
     dc->naa = EX_TBFLAG_A64(tb_flags, NAA);
+    dc->nv = EX_TBFLAG_A64(tb_flags, NV);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.34.1


