Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D647CBB78
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdmC-0007x3-7t; Tue, 17 Oct 2023 02:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlk-0007vF-86
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:36 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdle-0001tb-SC
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:31 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-578b4981526so3146751a12.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524885; x=1698129685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ShJyWywDcW6kwGEIx4axsLzYdlXE0bNbLMVVcliJbPE=;
 b=bS6Bl90YpyO9xKL/ecqOqSUn4M38UnrAjgEBcRqPRBUWSMnQRb6ne32gPO9sFbov7d
 fQhzKGidGZ99CxW+SHN0I7Tlg1+WGIyknoP6+H4rHSd5Eujzdo8pAmsnsza/D8IzEoTF
 aI+ZHxXcL6Fxpfofv3fjhFBZtJdoYQZiD8/Dkila6gj/0hhUnkQ8ep+1rxTVpHNgiI/e
 9l81ju+71vZ5yIykTYWWRuJCNtTT8mTYYNd3yFnxIV+BpvA/d8QLqLChbRL+iYIRo5f+
 LDN1yo+TfYqXg7lgCBmuhsDYDS35wL/n0kFP2HgVy4EieEoX4M03Qvt7NvJqTp2GpXud
 k0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524885; x=1698129685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ShJyWywDcW6kwGEIx4axsLzYdlXE0bNbLMVVcliJbPE=;
 b=HzS1MwuBXaXAMZBtQaSjAclXSbcWiYTeffc/WKQvy+LsduJYVre21E/PidG2rbUs6l
 S0MByU3ao9gYUMT00GX8J1cKbt+3YI5HbcPJKdYXZ+x+DYhKViM+hCBU5k7FvqJvWG8o
 v7/lvs5cBhZZReeSTHMxs6R0rjjlzj/RtVQenLZN0c4XDCmssjZqO7/8eWfRprk0VN9K
 Pv+e3U8XiF5q89a4vRrjEBwg7Wqz/z7y1cgHO9IJxrtdBB0Udbt8y9KAxV+B0XxpFXYw
 Pg+zfrB9Vl8qD6iYAKn9quGLlvLeLik7jvm98YadFn+1uqwDa9rnuj6KJ32N2gHqVZyY
 n3IA==
X-Gm-Message-State: AOJu0YzZgSbf2LwElD6VyIrRxeo1XwLhjOtHUmiWYDpHe8DsYab8rdS8
 7h26MeR92vCkhVO4N/i/pszEunxcoS5werz04Z8=
X-Google-Smtp-Source: AGHT+IFSSVEiq0lcotSVeZq3tiusFTy9c7961im0t4K8vOz2+9dqTqwPbp9Q44bbNqUjtbRx4juSow==
X-Received: by 2002:a05:6a20:4429:b0:153:a461:d96e with SMTP id
 ce41-20020a056a20442900b00153a461d96emr1433607pzb.47.1697524885024; 
 Mon, 16 Oct 2023 23:41:25 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 19/20] target/sparc: Implement UDIVX and SDIVX inline
Date: Mon, 16 Oct 2023 23:41:08 -0700
Message-Id: <20231017064109.681935-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017064109.681935-1-richard.henderson@linaro.org>
References: <20231017064109.681935-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 target/sparc/helper.h    |   4 --
 target/sparc/helper.c    |  24 ---------
 target/sparc/translate.c | 109 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 95 insertions(+), 42 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 6415942e03..12181d1106 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -33,10 +33,6 @@ DEF_HELPER_3(udiv_cc, tl, env, tl, tl)
 DEF_HELPER_3(sdiv_cc, tl, env, tl, tl)
 DEF_HELPER_3(taddcctv, tl, env, tl, tl)
 DEF_HELPER_3(tsubcctv, tl, env, tl, tl)
-#ifdef TARGET_SPARC64
-DEF_HELPER_FLAGS_3(sdivx, TCG_CALL_NO_WG, s64, env, s64, s64)
-DEF_HELPER_FLAGS_3(udivx, TCG_CALL_NO_WG, i64, env, i64, i64)
-#endif
 #if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
 DEF_HELPER_FLAGS_4(ld_asi, TCG_CALL_NO_WG, i64, env, tl, int, i32)
 DEF_HELPER_FLAGS_5(st_asi, TCG_CALL_NO_WG, void, env, tl, i64, int, i32)
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 4887f295a5..3830d01634 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -177,30 +177,6 @@ target_ulong helper_sdiv_cc(CPUSPARCState *env, target_ulong a, target_ulong b)
     return do_sdiv(env, a, b, 1, GETPC());
 }
 
-#ifdef TARGET_SPARC64
-int64_t helper_sdivx(CPUSPARCState *env, int64_t a, int64_t b)
-{
-    if (b == 0) {
-        /* Raise divide by zero trap.  */
-        cpu_raise_exception_ra(env, TT_DIV_ZERO, GETPC());
-    } else if (b == -1) {
-        /* Avoid overflow trap with i386 divide insn.  */
-        return -a;
-    } else {
-        return a / b;
-    }
-}
-
-uint64_t helper_udivx(CPUSPARCState *env, uint64_t a, uint64_t b)
-{
-    if (b == 0) {
-        /* Raise divide by zero trap.  */
-        cpu_raise_exception_ra(env, TT_DIV_ZERO, GETPC());
-    }
-    return a / b;
-}
-#endif
-
 target_ulong helper_taddcctv(CPUSPARCState *env, target_ulong src1,
                              target_ulong src2)
 {
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9f53e703e6..b344422f8a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -65,8 +65,6 @@
 #define gen_helper_fabsd(D, S)          qemu_build_not_reached()
 #define gen_helper_done(E)              qemu_build_not_reached()
 #define gen_helper_retry(E)             qemu_build_not_reached()
-#define gen_helper_udivx(D, E, A, B)    qemu_build_not_reached()
-#define gen_helper_sdivx(D, E, A, B)    qemu_build_not_reached()
 #define gen_helper_fmul8x16             ({ g_assert_not_reached(); NULL; })
 #define gen_helper_fmul8x16au           ({ g_assert_not_reached(); NULL; })
 #define gen_helper_fmul8x16al           ({ g_assert_not_reached(); NULL; })
@@ -578,16 +576,6 @@ static void gen_op_smul(TCGv dst, TCGv src1, TCGv src2)
     gen_op_multiply(dst, src1, src2, 1);
 }
 
-static void gen_op_udivx(TCGv dst, TCGv src1, TCGv src2)
-{
-    gen_helper_udivx(dst, tcg_env, src1, src2);
-}
-
-static void gen_op_sdivx(TCGv dst, TCGv src1, TCGv src2)
-{
-    gen_helper_sdivx(dst, tcg_env, src1, src2);
-}
-
 static void gen_op_udiv(TCGv dst, TCGv src1, TCGv src2)
 {
     gen_helper_udiv(dst, tcg_env, src1, src2);
@@ -3627,8 +3615,6 @@ TRANS(XORN, ALL, do_arith, a, tcg_gen_eqv_tl, NULL)
 TRANS(MULX, 64, do_arith, a, tcg_gen_mul_tl, tcg_gen_muli_tl)
 TRANS(UMUL, MUL, do_arith, a, gen_op_umul, NULL)
 TRANS(SMUL, MUL, do_arith, a, gen_op_smul, NULL)
-TRANS(UDIVX, 64, do_arith, a, gen_op_udivx, NULL)
-TRANS(SDIVX, 64, do_arith, a, gen_op_sdivx, NULL)
 TRANS(UDIV, DIV, do_arith, a, gen_op_udiv, NULL)
 TRANS(SDIV, DIV, do_arith, a, gen_op_sdiv, NULL)
 TRANS(ADDC, ALL, do_arith, a, gen_op_addc, NULL)
@@ -3656,6 +3642,101 @@ TRANS(ADDCcc, ALL, do_arith, a, gen_op_addccc, NULL)
 TRANS(SUBCcc, ALL, do_arith, a, gen_op_subccc, NULL)
 TRANS(MULScc, ALL, do_arith, a, gen_op_mulscc, NULL)
 
+static bool trans_UDIVX(DisasContext *dc, arg_r_r_ri *a)
+{
+    TCGv dst, src1, src2;
+
+    if (!avail_64(dc)) {
+        return false;
+    }
+    /* For simplicity, we under-decoded the rs2 form. */
+    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+        return false;
+    }
+
+    if (unlikely(a->rs2_or_imm == 0)) {
+        gen_exception(dc, TT_DIV_ZERO);
+        return true;
+    }
+
+    if (a->imm) {
+        src2 = tcg_constant_tl(a->rs2_or_imm);
+    } else {
+        TCGLabel *lab;
+
+        finishing_insn(dc);
+        flush_cond(dc);
+
+        lab = delay_exception(dc, TT_DIV_ZERO);
+        src2 = cpu_regs[a->rs2_or_imm];
+        tcg_gen_brcondi_tl(TCG_COND_EQ, src2, 0, lab);
+    }
+
+    dst = gen_dest_gpr(dc, a->rd);
+    src1 = gen_load_gpr(dc, a->rs1);
+
+    tcg_gen_divu_tl(dst, src1, src2);
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+static bool trans_SDIVX(DisasContext *dc, arg_r_r_ri *a)
+{
+    TCGv dst, src1, src2;
+
+    if (!avail_64(dc)) {
+        return false;
+    }
+    /* For simplicity, we under-decoded the rs2 form. */
+    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+        return false;
+    }
+
+    if (unlikely(a->rs2_or_imm == 0)) {
+        gen_exception(dc, TT_DIV_ZERO);
+        return true;
+    }
+
+    dst = gen_dest_gpr(dc, a->rd);
+    src1 = gen_load_gpr(dc, a->rs1);
+
+    if (a->imm) {
+        if (unlikely(a->rs2_or_imm == -1)) {
+            tcg_gen_neg_tl(dst, src1);
+            gen_store_gpr(dc, a->rd, dst);
+            return advance_pc(dc);
+        }
+        src2 = tcg_constant_tl(a->rs2_or_imm);
+    } else {
+        TCGLabel *lab;
+        TCGv t1, t2;
+
+        finishing_insn(dc);
+        flush_cond(dc);
+
+        lab = delay_exception(dc, TT_DIV_ZERO);
+        src2 = cpu_regs[a->rs2_or_imm];
+        tcg_gen_brcondi_tl(TCG_COND_EQ, src2, 0, lab);
+
+        /*
+         * Need to avoid INT64_MIN / -1, which will trap on x86 host.
+         * Set SRC2 to 1 as a new divisor, to produce the correct result.
+         */
+        t1 = tcg_temp_new();
+        t2 = tcg_temp_new();
+        tcg_gen_setcondi_tl(TCG_COND_EQ, t1, src1, (target_long)INT64_MIN);
+        tcg_gen_setcondi_tl(TCG_COND_EQ, t2, src2, -1);
+        tcg_gen_and_tl(t1, t1, t2);
+        tcg_gen_movcond_tl(TCG_COND_NE, t2, t1, tcg_constant_tl(0),
+                           tcg_constant_tl(1), src2);
+        src2 = t2;
+    }
+
+    tcg_gen_div_tl(dst, src1, src2);
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
 static TCGv gen_rs2_or_imm(DisasContext *dc, bool imm, int rs2_or_imm)
 {
     /* For simplicity, we under-decoded the rs2 form. */
-- 
2.34.1


