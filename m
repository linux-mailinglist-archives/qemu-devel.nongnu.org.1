Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4725878F61E
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 01:26:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbr23-0006ps-JS; Thu, 31 Aug 2023 19:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbr21-0006oL-Sc
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 19:24:57 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbr1s-0002Hl-B7
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 19:24:57 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bdbf10333bso11350345ad.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 16:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693524285; x=1694129085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4qI2v8dkaMA+Ey6DiDpJl+F5PeeixKFwiYK6goiJTlc=;
 b=ytKj7u1b+uREoFuCqfVxl815/SGpzHWUFERVHsFuq7qvDZBekSIVV2gGlWR90Lr1pi
 6/Z8JdgS53gG7BUGQ64RLOsBeiF9bwBiJ/cNtc0slfkBMrrdnCGhV/SrlcNQ58iEUiEP
 ZMzGEVzkfL2sM8jMfeKABa5mADeI1g+mof3ey5BXkSA3Y2JfGAr3wn//q/2Es9oP/qB6
 huJtygJVSkB6Gn18yV2G/jMtNDf1RhhEL9agSFSKiPyep5zGzNTSGsgCshRPVWN+Cdvf
 tEJ/qYQWy80sVFN6pGdzkvhM+tEAIbUZqgaZIGb7XzbZjNEgUbczVGUR4gNrcnpiec+r
 Ye2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693524286; x=1694129086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4qI2v8dkaMA+Ey6DiDpJl+F5PeeixKFwiYK6goiJTlc=;
 b=WQoonIxLhuOOaohc9P0gFnxQGq1WLkGHTFkhlQyXMW3LDUgZ0mClqNn6cL7toXCJk/
 1qhc867o4oRdDT6P18M7gFDOL+nOszIEUFybyaCgJBnfF6jghJpGZD3GGr37yL3mgBQ2
 r+AoM8evXFL/cp4FkQWIlx/Inc9bWCUeoMfFYwbBGc6UwSl14Z+GM+8DdWIHWdvPTaXU
 sVe/IoJW9J87Nr7lmWs0EZUHtSAdTX12gNk/CnNi9oEzC1qIhx1DvWxq/fuvPNdk+mE5
 s6yZF3RME5VVl/XZ9pJFi3kj3QB+fa4bwqZnJRK7wVllEr6z3+UuucQ+SPmnVtSIk0Wf
 Zhdw==
X-Gm-Message-State: AOJu0YxB+a6RK/vWjjcbe4phwVKgcKLPQpi7KcIK8NlL30T+yvT+AjK7
 vqYpEkmouVoe3DFUBLrf0yAUXJ2uw3UxuRup23s=
X-Google-Smtp-Source: AGHT+IGqAhvp/6bZrDyx+43vMnlC6w+C7HiZ8AdEHeFzKor4YZ4cIe6zzrNIi+7Cwsva6VJ8VA/TwQ==
X-Received: by 2002:a17:902:7449:b0:1c1:fe87:f550 with SMTP id
 e9-20020a170902744900b001c1fe87f550mr1162857plt.7.1693524285692; 
 Thu, 31 Aug 2023 16:24:45 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 jd5-20020a170903260500b001bb8895848bsm1732711plb.71.2023.08.31.16.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 16:24:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 4/5] target/arm: Implement FEAT_TIDCP1
Date: Thu, 31 Aug 2023 16:24:40 -0700
Message-Id: <20230831232441.66020-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831232441.66020-1-richard.henderson@linaro.org>
References: <20230831232441.66020-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst  |  1 +
 target/arm/cpu.h               |  5 +++++
 target/arm/helper.h            |  1 +
 target/arm/tcg/cpu64.c         |  1 +
 target/arm/tcg/op_helper.c     | 20 ++++++++++++++++++++
 target/arm/tcg/translate-a64.c |  5 +++++
 target/arm/tcg/translate.c     |  6 ++++++
 7 files changed, 39 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 2e6a7c8961..ce81fd82fc 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -85,6 +85,7 @@ the following architecture extensions:
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SPECRES (Speculation restriction instructions)
 - FEAT_SSBS (Speculative Store Bypass Safe)
+- FEAT_TIDCP1 (EL0 use of IMPLEMENTATION DEFINED functionality)
 - FEAT_TLBIOS (TLB invalidate instructions in Outer Shareable domain)
 - FEAT_TLBIRANGE (TLB invalidate range instructions)
 - FEAT_TTCNP (Translation table Common not private translations)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 278cc135c2..c4ce1b915f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3947,6 +3947,11 @@ static inline bool isar_feature_aa64_hcx(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HCX) != 0;
 }
 
+static inline bool isar_feature_aa64_tidcp1(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR1, TIDCP1) != 0;
+}
+
 static inline bool isar_feature_aa64_uao(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, UAO) != 0;
diff --git a/target/arm/helper.h b/target/arm/helper.h
index cf5c55a12b..2b02733305 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -81,6 +81,7 @@ DEF_HELPER_FLAGS_2(check_bxj_trap, TCG_CALL_NO_WG, void, env, i32)
 
 DEF_HELPER_4(access_check_cp_reg, cptr, env, i32, i32, i32)
 DEF_HELPER_FLAGS_2(lookup_cp_reg, TCG_CALL_NO_RWG_SE, cptr, env, i32)
+DEF_HELPER_FLAGS_2(tidcp_el0, TCG_CALL_NO_WG, void, env, i32)
 DEF_HELPER_FLAGS_2(tidcp_el1, TCG_CALL_NO_WG, void, env, i32)
 DEF_HELPER_3(set_cp_reg, void, env, cptr, i32)
 DEF_HELPER_2(get_cp_reg, i32, env, cptr)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index ab63526bea..b9691f24f8 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1069,6 +1069,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR1, XNX, 1);      /* FEAT_XNX */
     t = FIELD_DP64(t, ID_AA64MMFR1, ETS, 1);      /* FEAT_ETS */
     t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* FEAT_HCX */
+    t = FIELD_DP64(t, ID_AA64MMFR1, TIDCP1, 1);   /* FEAT_TIDCP1 */
     cpu->isar.id_aa64mmfr1 = t;
 
     t = cpu->isar.id_aa64mmfr2;
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 9014c3ca46..403f8b09d3 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -777,6 +777,26 @@ void HELPER(tidcp_el1)(CPUARMState *env, uint32_t syndrome)
     }
 }
 
+/*
+ * Similarly, for FEAT_TIDCP1 at EL0.
+ * We have already checked for the presence of the feature.
+ */
+void HELPER(tidcp_el0)(CPUARMState *env, uint32_t syndrome)
+{
+    /* See arm_sctlr(), but we also need the sctlr el. */
+    ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, 0);
+    int target_el = mmu_idx == ARMMMUIdx_E20_0 ? 2 : 1;
+
+    /*
+     * The bit is not valid unless the target el is aa64, but since the
+     * bit test is simpler perform that first and check validity after.
+     */
+    if ((env->cp15.sctlr_el[target_el] & SCTLR_TIDCP)
+        && arm_el_is_aa64(env, target_el)) {
+        raise_exception_ra(env, EXCP_UDEF, syndrome, target_el, GETPC());
+    }
+}
+
 void HELPER(set_cp_reg)(CPUARMState *env, const void *rip, uint32_t value)
 {
     const ARMCPRegInfo *ri = rip;
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 786a568d31..15d985d95e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2163,6 +2163,11 @@ static void handle_sys(DisasContext *s, bool isread,
          */
         syndrome = syn_aa64_sysregtrap(op0, op1, op2, crn, crm, rt, isread);
         switch (s->current_el) {
+        case 0:
+            if (dc_isar_feature(aa64_tidcp1, s)) {
+                gen_helper_tidcp_el0(cpu_env, tcg_constant_i32(syndrome));
+            }
+            break;
         case 1:
             gen_helper_tidcp_el1(cpu_env, tcg_constant_i32(syndrome));
             break;
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 47d3bc5fd5..976b704200 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -4640,6 +4640,12 @@ static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
          * but raises the same exception, so order doesn't matter.
          */
         switch (s->current_el) {
+        case 0:
+            if (arm_dc_feature(s, ARM_FEATURE_AARCH64)
+                && dc_isar_feature(aa64_tidcp1, s)) {
+                gen_helper_tidcp_el0(cpu_env, tcg_constant_i32(syndrome));
+            }
+            break;
         case 1:
             gen_helper_tidcp_el1(cpu_env, tcg_constant_i32(syndrome));
             break;
-- 
2.34.1


