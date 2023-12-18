Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A84A816C61
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:37:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsK-000768-EX; Mon, 18 Dec 2023 06:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsH-00073h-Jx
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:29 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs8-0003Mu-E8
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:29 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3365f1326e4so1568716f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899199; x=1703503999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zRze+6j2KKiB/ZDWJ1SJRi44YTc45GRhnCZ1EhtoXBk=;
 b=zth0QdCGwVXtQfxc+HwfEf4DfQanuL22b4gBQosF9jxvcEbXCtcqY7d5SSK5d1+pft
 Qsf19Bp4CDcKmZMfUxGJJz290b+9+DxJg9PPLsdH1pSiP04nPIpyJpirT+5gZcX9oTZj
 Hmwr8mOp/9Re5SBC+GV7cx7jWDZOzkydFG11lsMjKLWy8CNoltroq31KHGhO/HCEXDxD
 7us0ekS94hxV9DtQSHQzMopGRBpQl20Bed9SicawjE1enFAFhE0ye9avEQn1JM/jt3Ai
 P6VtpcoPC351j1uJceSIN4WcWL8R5Nw7gQm0yivENbfcOIY30e3ny+qWdGsEPS/JUAcX
 jETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899199; x=1703503999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zRze+6j2KKiB/ZDWJ1SJRi44YTc45GRhnCZ1EhtoXBk=;
 b=IEDvFNczpocxn+k9e4DiqZmAMECr2URwPInd0wuWMzN8a9/uRUerfT6/wIec6dEioh
 RO5u8ujvaL5CCvZb/aOBdI0mo8zl11ucQuf4M2+/LgxIRu5C2c948e3AQl3QpKAxhdZi
 ouHeXc9rJa8t2MgOlv8FSTcFPvzbGJWFX0ZnwSHkZTnoxzbOVMgZI1ex4A8ZLxByciFV
 +3ygFsKMFf/yda+WBSYFl6QHZZVJZqzBDk2MsbKj9OKgAM9ikTSYru3lM/FJceZsNdwW
 Eti31zIji1vGtZtsMO+/3BFSW/ntAnjREeyi1fFQX2PF3+iYPFuVTCP6I+3uaaUuzZwG
 7AxQ==
X-Gm-Message-State: AOJu0YxAYOqafgzAaMe1iqFRW/atxbey8tlLScpYT3EiCJ8zggSYrVOO
 MCuhjD8gk5gIn3LL8QnnSLP4YH31TrLRnyu4aSs=
X-Google-Smtp-Source: AGHT+IGicZjo2PuTcdrIcbMfooM7Jzs8MPpa2MJ0vc06Ia7R5lKtjOMpBS8xCknDyAV5z7t0qDKkIA==
X-Received: by 2002:a5d:67c8:0:b0:336:6dbf:d081 with SMTP id
 n8-20020a5d67c8000000b003366dbfd081mr140044wrw.60.1702899198911; 
 Mon, 18 Dec 2023 03:33:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 25/35] target/arm: Handle FEAT_NV2 redirection of SPSR_EL2,
 ELR_EL2, ESR_EL2, FAR_EL2
Date: Mon, 18 Dec 2023 11:32:55 +0000
Message-Id: <20231218113305.2511480-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Under FEAT_NV2, when HCR_EL2.{NV,NV2} == 0b11 at EL1, accesses to the
registers SPSR_EL2, ELR_EL2, ESR_EL2, FAR_EL2 and TFSR_EL2 (which
would UNDEF without FEAT_NV or FEAT_NV2) should instead access the
equivalent EL1 registers SPSR_EL1, ELR_EL1, ESR_EL1, FAR_EL1 and
TFSR_EL1.

Because there are only five registers involved and the encoding for
the EL1 register is identical to that of the EL2 register except
that opc1 is 0, we handle this by finding the EL1 register in the
hash table and using it instead.

Note that traps that apply to direct accesses to the EL1 register,
such as active fine-grained traps or other trap bits, do not trigger
when it is accessed via the EL2 encoding in this way.  However, some
traps that are defined by the EL2 register may apply.  We therefore
call the EL2 register's accessfn first.  The only one of the five
which has such traps is TFSR_EL2: make sure its accessfn correctly
handles both FEAT_NV (where we trap to EL2 without checking ATA bits)
and FEAT_NV2 (where we check ATA bits and then redirect to TFSR_EL1).

(We don't need the NV1 tbflag bit until the next patch, but we
introduce it here to avoid putting the NV, NV1, NV2 bits in an
odd order.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h            |  5 +++++
 target/arm/cpu.h               |  2 ++
 target/arm/tcg/translate.h     |  4 ++++
 target/arm/helper.c            | 13 +++++++++----
 target/arm/tcg/hflags.c        |  6 ++++++
 target/arm/tcg/translate-a64.c | 33 ++++++++++++++++++++++++++++++++-
 6 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 3c5f1b48879..cb795bed75b 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -118,6 +118,11 @@ enum {
      * ARM pseudocode function CheckSMEAccess().
      */
     ARM_CP_SME                   = 1 << 19,
+    /*
+     * Flag: one of the four EL2 registers which redirect to the
+     * equivalent EL1 register when FEAT_NV2 is enabled.
+     */
+    ARM_CP_NV2_REDIRECT          = 1 << 20,
 };
 
 /*
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9df8fc08d79..e60b4f34fe4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3242,6 +3242,8 @@ FIELD(TBFLAG_A64, TRAP_ERET, 29, 1)
 FIELD(TBFLAG_A64, NAA, 30, 1)
 FIELD(TBFLAG_A64, ATA0, 31, 1)
 FIELD(TBFLAG_A64, NV, 32, 1)
+FIELD(TBFLAG_A64, NV1, 33, 1)
+FIELD(TBFLAG_A64, NV2, 34, 1)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 63e075bce3a..9e13c4ef7b6 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -146,6 +146,10 @@ typedef struct DisasContext {
     bool naa;
     /* True if FEAT_NV HCR_EL2.NV is enabled */
     bool nv;
+    /* True if NV enabled and HCR_EL2.NV1 is set */
+    bool nv1;
+    /* True if NV enabled and HCR_EL2.NV2 is set */
+    bool nv2;
     /*
      * >= 0, a copy of PSTATE.BTYPE, which will be 0 without v8.5-BTI.
      *  < 0, set by the current instruction.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 38e16c2f8a5..61aac61bcc4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6119,14 +6119,16 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 7,
       .access = PL2_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "ELR_EL2", .state = ARM_CP_STATE_AA64,
-      .type = ARM_CP_ALIAS,
+      .type = ARM_CP_ALIAS | ARM_CP_NV2_REDIRECT,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 1,
       .access = PL2_RW,
       .fieldoffset = offsetof(CPUARMState, elr_el[2]) },
     { .name = "ESR_EL2", .state = ARM_CP_STATE_BOTH,
+      .type = ARM_CP_NV2_REDIRECT,
       .opc0 = 3, .opc1 = 4, .crn = 5, .crm = 2, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.esr_el[2]) },
     { .name = "FAR_EL2", .state = ARM_CP_STATE_BOTH,
+      .type = ARM_CP_NV2_REDIRECT,
       .opc0 = 3, .opc1 = 4, .crn = 6, .crm = 0, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.far_el[2]) },
     { .name = "HIFAR", .state = ARM_CP_STATE_AA32,
@@ -6135,7 +6137,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .access = PL2_RW,
       .fieldoffset = offsetofhigh32(CPUARMState, cp15.far_el[2]) },
     { .name = "SPSR_EL2", .state = ARM_CP_STATE_AA64,
-      .type = ARM_CP_ALIAS,
+      .type = ARM_CP_ALIAS | ARM_CP_NV2_REDIRECT,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 0,
       .access = PL2_RW,
       .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_HYP]) },
@@ -7852,11 +7854,13 @@ static CPAccessResult access_tfsr_el2(CPUARMState *env, const ARMCPRegInfo *ri,
     /*
      * TFSR_EL2: similar to generic access_mte(), but we need to
      * account for FEAT_NV. At EL1 this must be a FEAT_NV access;
-     * we will trap to EL2 and the HCR/SCR traps do not apply.
+     * if NV2 is enabled then we will redirect this to TFSR_EL1
+     * after doing the HCR and SCR ATA traps; otherwise this will
+     * be a trap to EL2 and the HCR/SCR traps do not apply.
      */
     int el = arm_current_el(env);
 
-    if (el == 1) {
+    if (el == 1 && (arm_hcr_el2_eff(env) & HCR_NV2)) {
         return CP_ACCESS_OK;
     }
     if (el < 2 && arm_is_el2_enabled(env)) {
@@ -7893,6 +7897,7 @@ static const ARMCPRegInfo mte_reginfo[] = {
       .access = PL1_RW, .accessfn = access_tfsr_el1,
       .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[1]) },
     { .name = "TFSR_EL2", .state = ARM_CP_STATE_AA64,
+      .type = ARM_CP_NV2_REDIRECT,
       .opc0 = 3, .opc1 = 4, .crn = 5, .crm = 6, .opc2 = 0,
       .access = PL2_RW, .accessfn = access_tfsr_el2,
       .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[2]) },
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 8f254bf9ccb..d2b352663e8 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -302,6 +302,12 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     if (el == 1 && (hcr & HCR_NV)) {
         DP_TBFLAG_A64(flags, TRAP_ERET, 1);
         DP_TBFLAG_A64(flags, NV, 1);
+        if (hcr & HCR_NV1) {
+            DP_TBFLAG_A64(flags, NV1, 1);
+        }
+        if (hcr & HCR_NV2) {
+            DP_TBFLAG_A64(flags, NV2, 1);
+        }
     }
 
     if (cpu_isar_feature(aa64_mte, env_archcpu(env))) {
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6bfc39d8ea7..6909c9df30d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2132,6 +2132,7 @@ static void handle_sys(DisasContext *s, bool isread,
     const ARMCPRegInfo *ri = get_arm_cp_reginfo(s->cp_regs, key);
     bool need_exit_tb = false;
     bool nv_trap_to_el2 = false;
+    bool nv_redirect_reg = false;
     bool skip_fp_access_checks = false;
     TCGv_ptr tcg_ri = NULL;
     TCGv_i64 tcg_rt;
@@ -2173,7 +2174,14 @@ static void handle_sys(DisasContext *s, bool isread,
          * for registers accessible at EL1).
          */
         skip_fp_access_checks = true;
-        if (s->nv && arm_cpreg_traps_in_nv(ri)) {
+        if (s->nv && s->nv2 && (ri->type & ARM_CP_NV2_REDIRECT)) {
+            /*
+             * This is one of the few EL2 registers which should redirect
+             * to the equivalent EL1 register. We do that after running
+             * the EL2 register's accessfn.
+             */
+            nv_redirect_reg = true;
+        } else if (s->nv && arm_cpreg_traps_in_nv(ri)) {
             /*
              * This register / instruction exists and is an EL2 register, so
              * we must trap to EL2 if accessed in nested virtualization EL1
@@ -2225,6 +2233,27 @@ static void handle_sys(DisasContext *s, bool isread,
         return;
     }
 
+    if (nv_redirect_reg) {
+        /*
+         * FEAT_NV2 redirection of an EL2 register to an EL1 register.
+         * Conveniently in all cases the encoding of the EL1 register is
+         * identical to the EL2 register except that opc1 is 0.
+         * Get the reginfo for the EL1 register to use for the actual access.
+         * We don't use the EL1 register's access function, and
+         * fine-grained-traps on EL1 also do not apply here.
+         */
+        key = ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP,
+                                 crn, crm, op0, 0, op2);
+        ri = get_arm_cp_reginfo(s->cp_regs, key);
+        assert(ri);
+        assert(cp_access_ok(s->current_el, ri, isread));
+        /*
+         * We might not have done an update_pc earlier, so check we don't
+         * need it. We could support this in future if necessary.
+         */
+        assert(!(ri->type & ARM_CP_RAISES_EXC));
+    }
+
     /* Handle special cases first */
     switch (ri->type & ARM_CP_SPECIAL_MASK) {
     case 0:
@@ -14031,6 +14060,8 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->sme_trap_nonstreaming = EX_TBFLAG_A64(tb_flags, SME_TRAP_NONSTREAMING);
     dc->naa = EX_TBFLAG_A64(tb_flags, NAA);
     dc->nv = EX_TBFLAG_A64(tb_flags, NV);
+    dc->nv1 = EX_TBFLAG_A64(tb_flags, NV1);
+    dc->nv2 = EX_TBFLAG_A64(tb_flags, NV2);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.34.1


