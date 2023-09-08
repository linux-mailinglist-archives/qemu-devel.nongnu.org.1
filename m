Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8733798B47
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:10:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeewD-0005o4-PR; Fri, 08 Sep 2023 13:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeewB-0005kt-N2
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevt-0001AK-JF
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:31 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401da71b83cso25613865e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192771; x=1694797571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vziyo8GQy0EqIgqmXC/MDGq2nc1zropvaGJtoq9SVxg=;
 b=n069689nB49703PhLCRMXwK8bNwP7XpAhu2jo0wZt67zwoOi9SK3DR/coJfwvPR5Tp
 yHDS0hcvYcmL3Eg9fB1bmOj9CD4G81lZRaoi5+Y30ZQ/jvLn5Q/d2z1O+SAdH5N1WpIJ
 ++qNxE8kV85gPyS7WavaGzsnpo0Iy8Q4Aly1Zhenvno8m2RVNuVUZKtaBksAnlrNRpo6
 bv1VVdaK7Qo26OxYZGuHWnQWimM6UQG3itBkFJ0oFSlAKCxWvi+SXHmmA2AgCp86dcxS
 Umd83XdA7bbD03wy5xzYR0bTNjh0CZ3BDLDIR0EnW+2xfPD5fjQMoelh4tk7qiIMhq6k
 aGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192771; x=1694797571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vziyo8GQy0EqIgqmXC/MDGq2nc1zropvaGJtoq9SVxg=;
 b=BOZ7QIqPM0uAvOmRYX56rmgJcSyTodHTAM9RKcYhex21+txOG9McIB3LZ96ccB+jWt
 WI6j+yUMeNufOWUho7JAeOENvwCRuOSl/1HuUQfx1smdfF+em8FONUeXfFe63/iPCq0I
 K3vH3E1Rav885rbGjfeJpMLyiMfEStRA4mQo7vH1FYOTOBGjGehR5r8BYWcNdjBml/lb
 9XjAsGKuU1T55q8VFlJpacYVNBiTQ3MM7otYDWN1i/xVdGZOxD7sFzRevbkJpt+lv+kC
 lO8A4pJTei/pA05tu6VpL0H4y1NJFVo5dstdvMjHmlhdYXHrdxJOOF2oOM5n8rLJ/Suc
 1KzA==
X-Gm-Message-State: AOJu0Yy2YlaBiqOOZna9Zr5HfNmexSGeyftok6T4PR7TYgx353y51byJ
 XuT/YzFh9X3B71RNh8ub/9TOcYWKGBr+3Xiys6k=
X-Google-Smtp-Source: AGHT+IHHdu8ZIYZdbdF1Y7XvHr44DdNu6zGTOgBL8j/wcE9sQbUU1+2BldFoJcNxJTAiSG+pxsY47A==
X-Received: by 2002:a7b:cd17:0:b0:3f6:58ad:ed85 with SMTP id
 f23-20020a7bcd17000000b003f658aded85mr2531179wmj.10.1694192771258; 
 Fri, 08 Sep 2023 10:06:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/26] target/arm: Implement FEAT_TIDCP1
Date: Fri,  8 Sep 2023 18:05:55 +0100
Message-Id: <20230908170557.773048-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230831232441.66020-5-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index 305b36b19e7..3df936fc356 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -92,6 +92,7 @@ the following architecture extensions:
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SPECRES (Speculation restriction instructions)
 - FEAT_SSBS (Speculative Store Bypass Safe)
+- FEAT_TIDCP1 (EL0 use of IMPLEMENTATION DEFINED functionality)
 - FEAT_TLBIOS (TLB invalidate instructions in Outer Shareable domain)
 - FEAT_TLBIRANGE (TLB invalidate range instructions)
 - FEAT_TTCNP (Translation table Common not private translations)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6f75ccfcef9..d1aa3da38f6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3980,6 +3980,11 @@ static inline bool isar_feature_aa64_hcx(const ARMISARegisters *id)
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
index cf5c55a12b3..2b027333053 100644
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
index 6e5192ebfc3..7264ab5ead1 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1071,6 +1071,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR1, XNX, 1);      /* FEAT_XNX */
     t = FIELD_DP64(t, ID_AA64MMFR1, ETS, 1);      /* FEAT_ETS */
     t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* FEAT_HCX */
+    t = FIELD_DP64(t, ID_AA64MMFR1, TIDCP1, 1);   /* FEAT_TIDCP1 */
     cpu->isar.id_aa64mmfr1 = t;
 
     t = cpu->isar.id_aa64mmfr2;
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 9014c3ca460..403f8b09d36 100644
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
index cb5c42638cc..1b6fbb61e2b 100644
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
index 47d3bc5fd51..976b7042008 100644
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


