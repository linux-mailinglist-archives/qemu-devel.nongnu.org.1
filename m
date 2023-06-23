Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C2973B7CD
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:43:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxH-00021B-0K; Fri, 23 Jun 2023 08:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx1-0001VD-AZ
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:43 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfwz-0000ey-4e
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:42 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f90a7325f6so7237445e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523499; x=1690115499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vh7CctXOXJ2RMqnKhdIgIBwSfX1eH9xKtTCUVyHhAZU=;
 b=kbl1tj/4PrqJ5dsBsVi0lYBPgbOk62sItWB2D+B5tB6BRQ8DlDqMk3ULEQ+BKW0QI7
 UipvZlehbJRnnyQZvI62knPkHSTbIslN6IE5fjmzKCYlcd3uaO2Q0HFTjI8mmpsC1Dpa
 UaeH/3FcSZkikuGxZBPFz1HPplzsMoTi9HIMpKNxU7k7gYCQyXJDYzfzrLTok95DUsW+
 gj7ebOv0SNJ3WY1HjN5eMAo6K/PoDcqLd8TMkKhIaixPmjPstOeIadkiKurszjJ+5Gkc
 Z3hNjcPc9QV0NOPN22S+AC9kJOAybuJqLU3yHvvKGoW7vQnOev3v8T/jQHcI4VFU6L9r
 Mdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523499; x=1690115499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vh7CctXOXJ2RMqnKhdIgIBwSfX1eH9xKtTCUVyHhAZU=;
 b=ka3i8WuUEBY356TehAD9nWfBGhQy2rXAnnKofnM26OnuvS/PgM/oL7S2TMw3V8hqGA
 cFz6EVVSu7f8+Jj9Excb775gDxdhoJGKLAeN1dOGKMTkrmGwnXl/qAtIiofCxpSUl1RJ
 tZsX1Y+GXsMYg3iYIPcr9EerSAQMa7JYlcYz9K7S79DBcLn+jaWRe7gGWcGND61cyVdB
 EZ3yyFgVWYpe5Fd3GH52tmjjy+f+57/Kmioko34t6fx7RBWOP8O+tCeBli2ysOqrjpjP
 HPO5Ne5ngx1BSadX2McvVaw4bhAPvBC6GOr5MHXPYYzeRvINpv87NzhUmpufTsrFMyFW
 jdAg==
X-Gm-Message-State: AC+VfDxl549tIPW8Udf6xRg8lmvlzQE5VFj8JAmuz7ktxfVP212Lo0Xs
 8CPwXOXiuaECAauILM2I2vyYdsfaeDxCGATPeNw=
X-Google-Smtp-Source: ACHHUZ664Ai3559hcsLs2r3pU7tZQbRT8Un4xxaiVvpXerRwOSd9on50FyWDja3KOgRJqcLeNe9Nmg==
X-Received: by 2002:a05:600c:2051:b0:3f7:3545:4630 with SMTP id
 p17-20020a05600c205100b003f735454630mr20422085wmg.20.1687523499655; 
 Fri, 23 Jun 2023 05:31:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/26] target/arm: Introduce ARMSecuritySpace
Date: Fri, 23 Jun 2023 13:31:14 +0100
Message-Id: <20230623123135.1788191-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Introduce both the enumeration and functions to retrieve
the current state, and state outside of EL3.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230620124418.805717-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 89 ++++++++++++++++++++++++++++++++++-----------
 target/arm/helper.c | 60 ++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+), 22 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c9c87b515df..125e53b83fe 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2414,25 +2414,53 @@ static inline int arm_feature(CPUARMState *env, int feature)
 
 void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp);
 
-#if !defined(CONFIG_USER_ONLY)
 /*
+ * ARM v9 security states.
+ * The ordering of the enumeration corresponds to the low 2 bits
+ * of the GPI value, and (except for Root) the concat of NSE:NS.
+ */
+
+typedef enum ARMSecuritySpace {
+    ARMSS_Secure     = 0,
+    ARMSS_NonSecure  = 1,
+    ARMSS_Root       = 2,
+    ARMSS_Realm      = 3,
+} ARMSecuritySpace;
+
+/* Return true if @space is secure, in the pre-v9 sense. */
+static inline bool arm_space_is_secure(ARMSecuritySpace space)
+{
+    return space == ARMSS_Secure || space == ARMSS_Root;
+}
+
+/* Return the ARMSecuritySpace for @secure, assuming !RME or EL[0-2]. */
+static inline ARMSecuritySpace arm_secure_to_space(bool secure)
+{
+    return secure ? ARMSS_Secure : ARMSS_NonSecure;
+}
+
+#if !defined(CONFIG_USER_ONLY)
+/**
+ * arm_security_space_below_el3:
+ * @env: cpu context
+ *
+ * Return the security space of exception levels below EL3, following
+ * an exception return to those levels.  Unlike arm_security_space,
+ * this doesn't care about the current EL.
+ */
+ARMSecuritySpace arm_security_space_below_el3(CPUARMState *env);
+
+/**
+ * arm_is_secure_below_el3:
+ * @env: cpu context
+ *
  * Return true if exception levels below EL3 are in secure state,
- * or would be following an exception return to that level.
- * Unlike arm_is_secure() (which is always a question about the
- * _current_ state of the CPU) this doesn't care about the current
- * EL or mode.
+ * or would be following an exception return to those levels.
  */
 static inline bool arm_is_secure_below_el3(CPUARMState *env)
 {
-    assert(!arm_feature(env, ARM_FEATURE_M));
-    if (arm_feature(env, ARM_FEATURE_EL3)) {
-        return !(env->cp15.scr_el3 & SCR_NS);
-    } else {
-        /* If EL3 is not supported then the secure state is implementation
-         * defined, in which case QEMU defaults to non-secure.
-         */
-        return false;
-    }
+    ARMSecuritySpace ss = arm_security_space_below_el3(env);
+    return ss == ARMSS_Secure;
 }
 
 /* Return true if the CPU is AArch64 EL3 or AArch32 Mon */
@@ -2452,16 +2480,23 @@ static inline bool arm_is_el3_or_mon(CPUARMState *env)
     return false;
 }
 
-/* Return true if the processor is in secure state */
+/**
+ * arm_security_space:
+ * @env: cpu context
+ *
+ * Return the current security space of the cpu.
+ */
+ARMSecuritySpace arm_security_space(CPUARMState *env);
+
+/**
+ * arm_is_secure:
+ * @env: cpu context
+ *
+ * Return true if the processor is in secure state.
+ */
 static inline bool arm_is_secure(CPUARMState *env)
 {
-    if (arm_feature(env, ARM_FEATURE_M)) {
-        return env->v7m.secure;
-    }
-    if (arm_is_el3_or_mon(env)) {
-        return true;
-    }
-    return arm_is_secure_below_el3(env);
+    return arm_space_is_secure(arm_security_space(env));
 }
 
 /*
@@ -2480,11 +2515,21 @@ static inline bool arm_is_el2_enabled(CPUARMState *env)
 }
 
 #else
+static inline ARMSecuritySpace arm_security_space_below_el3(CPUARMState *env)
+{
+    return ARMSS_NonSecure;
+}
+
 static inline bool arm_is_secure_below_el3(CPUARMState *env)
 {
     return false;
 }
 
+static inline ARMSecuritySpace arm_security_space(CPUARMState *env)
+{
+    return ARMSS_NonSecure;
+}
+
 static inline bool arm_is_secure(CPUARMState *env)
 {
     return false;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 006447dde8f..f68923d73b4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12136,3 +12136,63 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
     }
 }
 #endif
+
+#ifndef CONFIG_USER_ONLY
+ARMSecuritySpace arm_security_space(CPUARMState *env)
+{
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        return arm_secure_to_space(env->v7m.secure);
+    }
+
+    /*
+     * If EL3 is not supported then the secure state is implementation
+     * defined, in which case QEMU defaults to non-secure.
+     */
+    if (!arm_feature(env, ARM_FEATURE_EL3)) {
+        return ARMSS_NonSecure;
+    }
+
+    /* Check for AArch64 EL3 or AArch32 Mon. */
+    if (is_a64(env)) {
+        if (extract32(env->pstate, 2, 2) == 3) {
+            if (cpu_isar_feature(aa64_rme, env_archcpu(env))) {
+                return ARMSS_Root;
+            } else {
+                return ARMSS_Secure;
+            }
+        }
+    } else {
+        if ((env->uncached_cpsr & CPSR_M) == ARM_CPU_MODE_MON) {
+            return ARMSS_Secure;
+        }
+    }
+
+    return arm_security_space_below_el3(env);
+}
+
+ARMSecuritySpace arm_security_space_below_el3(CPUARMState *env)
+{
+    assert(!arm_feature(env, ARM_FEATURE_M));
+
+    /*
+     * If EL3 is not supported then the secure state is implementation
+     * defined, in which case QEMU defaults to non-secure.
+     */
+    if (!arm_feature(env, ARM_FEATURE_EL3)) {
+        return ARMSS_NonSecure;
+    }
+
+    /*
+     * Note NSE cannot be set without RME, and NSE & !NS is Reserved.
+     * Ignoring NSE when !NS retains consistency without having to
+     * modify other predicates.
+     */
+    if (!(env->cp15.scr_el3 & SCR_NS)) {
+        return ARMSS_Secure;
+    } else if (env->cp15.scr_el3 & SCR_NSE) {
+        return ARMSS_Realm;
+    } else {
+        return ARMSS_NonSecure;
+    }
+}
+#endif /* !CONFIG_USER_ONLY */
-- 
2.34.1


