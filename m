Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC71782AD0B
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:12:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssj-0001en-Cu; Thu, 11 Jan 2024 06:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssL-0001PL-0V
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:31 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssF-0004V4-JL
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:27 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e5f615a32so4440285e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971121; x=1705575921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HDRuFqgtgBujOw/eF1ydKefrsWrCrRnaThf36FKE+Yw=;
 b=RDIRyQk440TdAJnvbkJZbv2+Pu4rJ4H2sGQz0o6QluEe4H5UuqVQ1J4A0Kc7Rk8278
 Do7gxUEDYdcWg809xkFHT7SWdbaypm+TXcLs7Q6QXUk8rhyVjKJZIKDraPdJa4/aOU5x
 gZEEXrr8qeRyagUx4pi32pdDnwsb4VXS9WbUYOiePUqO84zUcNxZnmFK4XIuMfNzOcf0
 4tuY7vAiUr/eGKP7tawfbf0mbcWKXfF0t0JL3b/SliDuhOu3UhwndJ1aBaGVzpVdA8EG
 zoqm4zB8fIInEzVAlyXdpj9g4MSYckXhARchPpZzLkaCFI/UyaN+IXxALHU9AsIZMi+c
 Mfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971121; x=1705575921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HDRuFqgtgBujOw/eF1ydKefrsWrCrRnaThf36FKE+Yw=;
 b=OGA4ZQjbSGH2SQ6Q4MqVodR3n/M4EzS6tXB8QpKz912Lh9oj5qu3ZzEzJcqQXHujEz
 HpIAq3xKHZnjMPSYmOIjTM7s+KNzlX7N0dzu1w6OCmwZtclLv3DqzE8dnnx/o+Bc0SAJ
 BDgczPAiO6xuIYHKwgzV/jG7lHjjTpR2W06rVLF53PWmI+7/x7YN8u5W3WbpFY6oggHJ
 OVm6x2EvgbxuFFDQLfRC0Oi1RocAbuv7f66WjWW5htaf+VFaTZZsx/vsCSZZS0Oj265N
 N2vAHsm0S+YQxWhzbrX/m6uVSkMvBCStE8o2OTcCxeUR4kwn7zu6aF5dbJmfQ/DfPcuT
 bp+A==
X-Gm-Message-State: AOJu0Yyv9jyx8i149upjfuvOlA4sn7W1o8jrWXepcwXd4B3u/Oz8kFAP
 d1Fhb+fqA1/crIgXeA3SgvdTxyl5gGIiK2Qp9II1Ly6TAyE=
X-Google-Smtp-Source: AGHT+IGRniTewWU+GgEFNzw/3pCcS2nuShlZvNd78PYK0/lL9EuIkhtPcQpf6bRuQy6rSV3i6/grgw==
X-Received: by 2002:a05:600c:540a:b0:40e:5a83:9cea with SMTP id
 he10-20020a05600c540a00b0040e5a839ceamr172712wmb.14.1704971120719; 
 Thu, 11 Jan 2024 03:05:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/41] target/arm: Handle FEAT_NV2 redirection of SPSR_EL2,
 ELR_EL2, ESR_EL2, FAR_EL2
Date: Thu, 11 Jan 2024 11:04:55 +0000
Message-Id: <20240111110505.1563291-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
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
index 0e48a1366bd..f521219ea95 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3239,6 +3239,8 @@ FIELD(TBFLAG_A64, TRAP_ERET, 29, 1)
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
index b9b3aaf4db7..93991c07b78 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6135,14 +6135,16 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
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
@@ -6151,7 +6153,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .access = PL2_RW,
       .fieldoffset = offsetofhigh32(CPUARMState, cp15.far_el[2]) },
     { .name = "SPSR_EL2", .state = ARM_CP_STATE_AA64,
-      .type = ARM_CP_ALIAS,
+      .type = ARM_CP_ALIAS | ARM_CP_NV2_REDIRECT,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 0,
       .access = PL2_RW,
       .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_HYP]) },
@@ -7876,11 +7878,13 @@ static CPAccessResult access_tfsr_el2(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -7917,6 +7921,7 @@ static const ARMCPRegInfo mte_reginfo[] = {
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
index ed1cc019a4c..2ada5b7e3f6 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2133,6 +2133,7 @@ static void handle_sys(DisasContext *s, bool isread,
     const ARMCPRegInfo *ri = get_arm_cp_reginfo(s->cp_regs, key);
     bool need_exit_tb = false;
     bool nv_trap_to_el2 = false;
+    bool nv_redirect_reg = false;
     bool skip_fp_access_checks = false;
     TCGv_ptr tcg_ri = NULL;
     TCGv_i64 tcg_rt;
@@ -2174,7 +2175,14 @@ static void handle_sys(DisasContext *s, bool isread,
          * for registers accessible at EL1).
          */
         skip_fp_access_checks = true;
-        if (s->nv && arm_cpreg_traps_in_nv(ri)) {
+        if (s->nv2 && (ri->type & ARM_CP_NV2_REDIRECT)) {
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
@@ -2226,6 +2234,27 @@ static void handle_sys(DisasContext *s, bool isread,
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
@@ -14032,6 +14061,8 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
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


