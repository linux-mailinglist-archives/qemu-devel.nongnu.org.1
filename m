Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6746726699
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 18:57:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wTO-0008Vq-GD; Wed, 07 Jun 2023 12:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1q6wTB-0008Fx-AD; Wed, 07 Jun 2023 12:57:14 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1q6wT9-0001md-GB; Wed, 07 Jun 2023 12:57:13 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-650c8cb68aeso4203664b3a.3; 
 Wed, 07 Jun 2023 09:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686157029; x=1688749029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O3WaGEYLWcPiIzw6vB3RZqhbnQGY0LswNykwJliRoIg=;
 b=AJhggkqdcjz/eCrBDEl0P/iBfwNz19k38oWpeDv1C5JhNoPnraRvV0d90JCY4rnvu7
 FgRa3eAKo7mbkoKOuzqloDdB0pJDm3dnlNZrGwGBcAHAmFt0kSRaXo2D7uORCCE3uRao
 i/88T70Oio0ce/UWkRrYNhT4Ylf3Hv7twl/ha07vX5er3TkvUNJ+q7Dxa3AIXOdxCbfu
 KUioTNsYP8AkhoRIrhSO85H7w2PZrgZR1eKrIlNbvdHaXpY70cUUkvREsFTR4X/bpX99
 db+uNQVWWzRtqjm1jnEup7vqZvPElCDfhklts/q/nxip9Cum72jNeQdw8RlCNFaYiP17
 VnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686157029; x=1688749029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O3WaGEYLWcPiIzw6vB3RZqhbnQGY0LswNykwJliRoIg=;
 b=KL8pl9BO6KD2fsxHptrlqOeIacbx0Io+cwKQuixWIXIzjttuvSJvxTNHWXC+NCP+Jk
 XtU+TxauPCJX5FEl1jSJC2S1rwIW4QqcvLlc/4+NG1yKBBIq363GWI+G7IjXR51s27c/
 r0foWx7nhSQRmxU+I6WEQ972aJotBN4td/Fo1NJcRp1xjUNlPrXp+DxQQbkwXrTTLGxT
 XBSfIdfxQuWUcmw9iG3qUGxGVGH/IylESLAyfiZXZ6auFdoH/a/LeSpoBEQkFL5Z9KfC
 KEu7A1iCIN6U0jBV0ta/AaVnAX0Y7ORDUE2JC7aAH8S5QuM9ZCOauNLtuHXKOJPmDXcT
 IPeg==
X-Gm-Message-State: AC+VfDzSk5SOxf3RuH2HHaWoYCWY0hAvAPyzwlJqUmr7Jabf5fOXWdxV
 uLZwpJyk5zLTHsuK9e6VRzE7n67tQI9e/ZOj6Vk=
X-Google-Smtp-Source: ACHHUZ4hKpxnZf9pvcR+5WsqUFOIufUqlmCx6NIb0JCO3OX+ITK7s9LgZVri/XviOSo/UFP0ldRRFA==
X-Received: by 2002:a17:90a:ca06:b0:259:ae4d:3377 with SMTP id
 x6-20020a17090aca0600b00259ae4d3377mr1730686pjt.27.1686156569266; 
 Wed, 07 Jun 2023 09:49:29 -0700 (PDT)
Received: from localhost.localdomain ([223.104.40.226])
 by smtp.gmail.com with ESMTPSA id
 30-20020a17090a001e00b00250bf8495b3sm1671808pja.39.2023.06.07.09.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 09:49:28 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC v2 5/6] target/arm: Add native library calls
Date: Thu,  8 Jun 2023 00:47:49 +0800
Message-Id: <20230607164750.829586-6-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
References: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 target/arm/helper.c            | 47 ++++++++++++++++++++++++++++++++++
 target/arm/helper.h            |  6 +++++
 target/arm/tcg/translate-a64.c | 22 ++++++++++++++++
 target/arm/tcg/translate.c     | 25 +++++++++++++++++-
 target/arm/tcg/translate.h     | 19 ++++++++++++++
 5 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0b7fd2e7e6..03fbc3724b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -25,6 +25,7 @@
 #include "sysemu/tcg.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
+#include "exec/cpu_ldst.h"
 #ifdef CONFIG_TCG
 #include "semihosting/common-semi.h"
 #endif
@@ -12045,3 +12046,49 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
     }
 }
 #endif
+
+#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
+
+#define NATIVE_FN_W_3W()           \
+    target_ulong arg0, arg1, arg2; \
+    arg0 = env->regs[0];           \
+    arg1 = env->regs[1];           \
+    arg2 = env->regs[2];
+
+void helper_native_memcpy(CPUARMState *env)
+{
+    CPUState *cs = env_cpu(env);
+    NATIVE_FN_W_3W();
+    void *ret;
+    void *dest = g2h(cs, arg0);
+    void *src = g2h(cs, arg1);
+    size_t n = (size_t)arg2;
+    ret = memcpy(dest, src, n);
+    env->regs[0] = (target_ulong)h2g(ret);
+}
+
+void helper_native_memcmp(CPUARMState *env)
+{
+    CPUState *cs = env_cpu(env);
+    NATIVE_FN_W_3W();
+    int ret;
+    void *s1 = g2h(cs, arg0);
+    void *s2 = g2h(cs, arg1);
+    size_t n = (size_t)arg2;
+    ret = memcmp(s1, s2, n);
+    env->regs[0] = ret;
+}
+
+void helper_native_memset(CPUARMState *env)
+{
+    CPUState *cs = env_cpu(env);
+    NATIVE_FN_W_3W();
+    void *ret;
+    void *s = g2h(cs, arg0);
+    int c = (int)arg1;
+    size_t n = (size_t)arg2;
+    ret = memset(s, c, n);
+    env->regs[0] = (target_ulong)h2g(ret);
+}
+
+#endif
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 3335c2b10b..57144bf6fb 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1038,6 +1038,12 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
+DEF_HELPER_1(native_memcpy, void, env)
+DEF_HELPER_1(native_memcmp, void, env)
+DEF_HELPER_1(native_memset, void, env)
+#endif
+
 #ifdef TARGET_AARCH64
 #include "tcg/helper-a64.h"
 #include "tcg/helper-sve.h"
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 741a608739..04421af6c6 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -35,6 +35,7 @@
 #include "cpregs.h"
 #include "translate-a64.h"
 #include "qemu/atomic128.h"
+#include "native/native-func.h"
 
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
@@ -2291,6 +2292,9 @@ static void disas_exc(DisasContext *s, uint32_t insn)
             if (s->fgt_svc) {
                 gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, 2);
                 break;
+            } else if (native_bypass() && imm16 == 0xff) {
+                s->native_call_status = true;
+                break;
             }
             gen_ss_advance(s);
             gen_exception_insn(s, 4, EXCP_SWI, syndrome);
@@ -14203,6 +14207,24 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     s->fp_access_checked = false;
     s->sve_access_checked = false;
 
+    if (native_bypass() && s->native_call_status) {
+        switch (insn) {
+        case NATIVE_MEMCPY:
+            gen_helper_native_memcpy(cpu_env);
+            break;
+        case NATIVE_MEMCMP:
+            gen_helper_native_memcmp(cpu_env);
+            break;
+        case NATIVE_MEMSET:
+            gen_helper_native_memset(cpu_env);
+            break;
+        default:
+            unallocated_encoding(s);
+        }
+        s->native_call_status = false;
+        return;
+    }
+
     if (s->pstate_il) {
         /*
          * Illegal execution state. This has priority over BTI
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 7468476724..83ce0f7437 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -34,7 +34,7 @@
 #include "exec/helper-gen.h"
 #include "exec/log.h"
 #include "cpregs.h"
-
+#include "native/native-func.h"
 
 #define ENABLE_ARCH_4T    arm_dc_feature(s, ARM_FEATURE_V4T)
 #define ENABLE_ARCH_5     arm_dc_feature(s, ARM_FEATURE_V5)
@@ -58,6 +58,10 @@ TCGv_i32 cpu_CF, cpu_NF, cpu_VF, cpu_ZF;
 TCGv_i64 cpu_exclusive_addr;
 TCGv_i64 cpu_exclusive_val;
 
+#if defined(CONFIG_USER_ONLY) && !defined(TARGET_AARCH64)  \
+    && defined(CONFIG_USER_NATIVE_CALL)
+#endif
+
 #include "exec/gen-icount.h"
 
 static const char * const regnames[] =
@@ -8576,6 +8580,8 @@ static bool trans_SVC(DisasContext *s, arg_SVC *a)
         if (s->fgt_svc) {
             uint32_t syndrome = syn_aa32_svc(a->imm, s->thumb);
             gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, 2);
+        } else if (native_bypass() && a->imm == 0xff) {
+            s->native_call_status = true;
         } else {
             gen_update_pc(s, curr_insn_len(s));
             s->svc_imm = a->imm;
@@ -9372,6 +9378,23 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     insn = arm_ldl_code(env, &dc->base, pc, dc->sctlr_b);
     dc->insn = insn;
     dc->base.pc_next = pc + 4;
+    if (native_bypass() && dc->native_call_status) {
+        switch (insn) {
+        case NATIVE_MEMCPY:
+            gen_helper_native_memcpy(cpu_env);
+            break;
+        case NATIVE_MEMCMP:
+            gen_helper_native_memcmp(cpu_env);
+            break;
+        case NATIVE_MEMSET:
+            gen_helper_native_memset(cpu_env);
+            break;
+        default:
+            unallocated_encoding(dc);
+        }
+        dc->native_call_status = false;
+        return;
+    }
     disas_arm_insn(dc, insn);
 
     arm_post_translate_insn(dc);
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index a9d1f4adc2..19c4f7af7f 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -149,6 +149,13 @@ typedef struct DisasContext {
     int c15_cpar;
     /* TCG op of the current insn_start.  */
     TCGOp *insn_start;
+    /*
+     * Indicate whether the next instruction is a native function call (true)
+     * or not (false).
+     */
+#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
+    bool native_call_status;
+#endif
 } DisasContext;
 
 typedef struct DisasCompare {
@@ -657,3 +664,15 @@ static inline void gen_restore_rmode(TCGv_i32 old, TCGv_ptr fpst)
     }
 
 #endif /* TARGET_ARM_TRANSLATE_H */
+
+/*
+ * Check if the native bypass feature is enabled.
+ */
+static inline bool native_bypass(void)
+{
+#if defined(CONFIG_USER_ONLY) && defined(CONFIG_USER_NATIVE_CALL)
+    return true;
+#else
+    return false;
+#endif
+}
-- 
2.34.1


