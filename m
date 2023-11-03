Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AE87E07A3
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:40:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy8v-0005Nm-Bw; Fri, 03 Nov 2023 13:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8F-0005E3-VC
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:56 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8C-0003Te-Rt
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:55 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc5fa0e4d5so21280775ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699033130; x=1699637930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ER4uvX1BtxDZTzWgZDsDPwgYoxM33bU9YWvNBS9DKAE=;
 b=MR/YLB6dTErCIOmQTG4u8TGoYkwSlK9fFptaW9rcptO9YZEvmfbHbYkm/9EOtN3VGk
 d9UGTIUIik8MAlCZpj4UGRdks0w0ctWi12yY8j8hDeyQY4DF6Py96ar6Hz/jngGrs+bf
 joorw2OQ7h3hKbr3giXqR5lgc7HnhTJD/JOxmqgOwnxSdsa9UE4iwDAjEJStqekM8Axd
 yZQdv4YV1caKE2DyxDiqqB2BsWJzfY3pIr2jkIzXKMa4FZvhwWzb3ATtWNFB89jeNiX4
 XilinfnMvEiiu9NIMMLbpnpm5G0Ko+rBl9hiTSbPrRHi6TYxk0FYZhSUnY+L2fCjD4CU
 spKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033130; x=1699637930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ER4uvX1BtxDZTzWgZDsDPwgYoxM33bU9YWvNBS9DKAE=;
 b=NSXts5uRkOntwAmNmxvxqdd9Qy8H9EIQZ+TmY6A7nNOhLE8gMup0v5/UbbSerN7fdK
 nZNn+tgCWML/NdZyBBLD68oqhYACiFgyU7XthN9BOhNauZEhJUa5zaez2VYfEs9u/crb
 8QdUCp2JrR/4xk2FZI2fZ1vDZ8dGccDkfJpdZBJNW/HyZvZYpl+KHO9iQgxUGfPRRoam
 MdPnrmy6KXKY9whUSwiJ3q20ujslY0Ko7nKIEvUhLOU2dYX2+oJzTJUEpOJNWWMPKPm3
 g89RLR058zhFb2MDUo/D5qZFdiayNe4ucXgmFQQTrLs0Haesa3uHT27tdb/PwXI4SzMi
 pX1g==
X-Gm-Message-State: AOJu0Yyit+EVJb17vgj0Vf0vM1Q8XlphpPeWpZc3ox3QYHj7YizYSdhg
 XM4OmvNUqedGg3bUjBBPbpH0LJeorrN575FymDY=
X-Google-Smtp-Source: AGHT+IFwxYGW7nLd0LZb+bvzcXw4Dq+JP7NaH/EJ8qWLjUjnxmpRptaw4gHAZS0yR++UJYy3ma86pA==
X-Received: by 2002:a17:903:24f:b0:1cc:78a5:50a2 with SMTP id
 j15-20020a170903024f00b001cc78a550a2mr10527359plh.39.1699033130645; 
 Fri, 03 Nov 2023 10:38:50 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c10-20020a170902c1ca00b001c0cb2aa2easm1628267plc.121.2023.11.03.10.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:38:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 10/22] target/sparc: Use i128 for FCMPq, FCMPEq
Date: Fri,  3 Nov 2023 10:38:29 -0700
Message-Id: <20231103173841.33651-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103173841.33651-1-richard.henderson@linaro.org>
References: <20231103173841.33651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     | 16 ++++++------
 target/sparc/fop_helper.c | 23 +++++++++--------
 target/sparc/translate.c  | 54 +++++++++++++++------------------------
 3 files changed, 41 insertions(+), 52 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 4cb3451878..7caae9a441 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -44,8 +44,8 @@ DEF_HELPER_FLAGS_3(fcmpd, TCG_CALL_NO_WG, tl, env, f64, f64)
 DEF_HELPER_FLAGS_3(fcmpes, TCG_CALL_NO_WG, tl, env, f32, f32)
 DEF_HELPER_FLAGS_3(fcmped, TCG_CALL_NO_WG, tl, env, f64, f64)
 DEF_HELPER_FLAGS_2(fsqrtq, TCG_CALL_NO_RWG, i128, env, i128)
-DEF_HELPER_FLAGS_1(fcmpq, TCG_CALL_NO_WG, tl, env)
-DEF_HELPER_FLAGS_1(fcmpeq, TCG_CALL_NO_WG, tl, env)
+DEF_HELPER_FLAGS_3(fcmpq, TCG_CALL_NO_WG, tl, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpeq, TCG_CALL_NO_WG, tl, env, i128, i128)
 #ifdef TARGET_SPARC64
 DEF_HELPER_FLAGS_3(fcmps_fcc1, TCG_CALL_NO_WG, tl, env, f32, f32)
 DEF_HELPER_FLAGS_3(fcmps_fcc2, TCG_CALL_NO_WG, tl, env, f32, f32)
@@ -59,12 +59,12 @@ DEF_HELPER_FLAGS_3(fcmpes_fcc3, TCG_CALL_NO_WG, tl, env, f32, f32)
 DEF_HELPER_FLAGS_3(fcmped_fcc1, TCG_CALL_NO_WG, tl, env, f64, f64)
 DEF_HELPER_FLAGS_3(fcmped_fcc2, TCG_CALL_NO_WG, tl, env, f64, f64)
 DEF_HELPER_FLAGS_3(fcmped_fcc3, TCG_CALL_NO_WG, tl, env, f64, f64)
-DEF_HELPER_FLAGS_1(fcmpq_fcc1, TCG_CALL_NO_WG, tl, env)
-DEF_HELPER_FLAGS_1(fcmpq_fcc2, TCG_CALL_NO_WG, tl, env)
-DEF_HELPER_FLAGS_1(fcmpq_fcc3, TCG_CALL_NO_WG, tl, env)
-DEF_HELPER_FLAGS_1(fcmpeq_fcc1, TCG_CALL_NO_WG, tl, env)
-DEF_HELPER_FLAGS_1(fcmpeq_fcc2, TCG_CALL_NO_WG, tl, env)
-DEF_HELPER_FLAGS_1(fcmpeq_fcc3, TCG_CALL_NO_WG, tl, env)
+DEF_HELPER_FLAGS_3(fcmpq_fcc1, TCG_CALL_NO_WG, tl, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpq_fcc2, TCG_CALL_NO_WG, tl, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpq_fcc3, TCG_CALL_NO_WG, tl, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpeq_fcc1, TCG_CALL_NO_WG, tl, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpeq_fcc2, TCG_CALL_NO_WG, tl, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpeq_fcc3, TCG_CALL_NO_WG, tl, env, i128, i128)
 #endif
 DEF_HELPER_2(raise_exception, noreturn, env, int)
 
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 9f39b933e8..faf75e651f 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -248,9 +248,12 @@ Int128 helper_fsqrtq(CPUSPARCState *env, Int128 src)
     return f128_ret(float128_sqrt(f128_in(src), &env->fp_status));
 }
 
-#define GEN_FCMP(name, size, reg1, reg2, FS, E)                         \
-    target_ulong glue(helper_, name) (CPUSPARCState *env)               \
+#define GEN_FCMP(name, size, FS, E)                                     \
+    target_ulong glue(helper_, name) (CPUSPARCState *env,               \
+                                      Int128 src1, Int128 src2)         \
     {                                                                   \
+        float128 reg1 = f128_in(src1);                                  \
+        float128 reg2 = f128_in(src2);                                  \
         FloatRelation ret;                                              \
         target_ulong fsr;                                               \
         if (E) {                                                        \
@@ -316,33 +319,33 @@ GEN_FCMP_T(fcmpd, float64, 0, 0);
 GEN_FCMP_T(fcmpes, float32, 0, 1);
 GEN_FCMP_T(fcmped, float64, 0, 1);
 
-GEN_FCMP(fcmpq, float128, QT0, QT1, 0, 0);
-GEN_FCMP(fcmpeq, float128, QT0, QT1, 0, 1);
+GEN_FCMP(fcmpq, float128, 0, 0);
+GEN_FCMP(fcmpeq, float128, 0, 1);
 
 #ifdef TARGET_SPARC64
 GEN_FCMP_T(fcmps_fcc1, float32, 22, 0);
 GEN_FCMP_T(fcmpd_fcc1, float64, 22, 0);
-GEN_FCMP(fcmpq_fcc1, float128, QT0, QT1, 22, 0);
+GEN_FCMP(fcmpq_fcc1, float128, 22, 0);
 
 GEN_FCMP_T(fcmps_fcc2, float32, 24, 0);
 GEN_FCMP_T(fcmpd_fcc2, float64, 24, 0);
-GEN_FCMP(fcmpq_fcc2, float128, QT0, QT1, 24, 0);
+GEN_FCMP(fcmpq_fcc2, float128, 24, 0);
 
 GEN_FCMP_T(fcmps_fcc3, float32, 26, 0);
 GEN_FCMP_T(fcmpd_fcc3, float64, 26, 0);
-GEN_FCMP(fcmpq_fcc3, float128, QT0, QT1, 26, 0);
+GEN_FCMP(fcmpq_fcc3, float128, 26, 0);
 
 GEN_FCMP_T(fcmpes_fcc1, float32, 22, 1);
 GEN_FCMP_T(fcmped_fcc1, float64, 22, 1);
-GEN_FCMP(fcmpeq_fcc1, float128, QT0, QT1, 22, 1);
+GEN_FCMP(fcmpeq_fcc1, float128, 22, 1);
 
 GEN_FCMP_T(fcmpes_fcc2, float32, 24, 1);
 GEN_FCMP_T(fcmped_fcc2, float64, 24, 1);
-GEN_FCMP(fcmpeq_fcc2, float128, QT0, QT1, 24, 1);
+GEN_FCMP(fcmpeq_fcc2, float128, 24, 1);
 
 GEN_FCMP_T(fcmpes_fcc3, float32, 26, 1);
 GEN_FCMP_T(fcmped_fcc3, float64, 26, 1);
-GEN_FCMP(fcmpeq_fcc3, float128, QT0, QT1, 26, 1);
+GEN_FCMP(fcmpeq_fcc3, float128, 26, 1);
 #endif
 #undef GEN_FCMP_T
 #undef GEN_FCMP
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ba0b7f32d2..d4eea47c33 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -276,22 +276,6 @@ static void gen_store_fpr_Q(DisasContext *dc, unsigned int dst, TCGv_i128 v)
     gen_update_fprs_dirty(dc, dst);
 }
 
-static void gen_op_load_fpr_QT0(unsigned int src)
-{
-    tcg_gen_st_i64(cpu_fpr[src / 2], tcg_env, offsetof(CPUSPARCState, qt0) +
-                   offsetof(CPU_QuadU, ll.upper));
-    tcg_gen_st_i64(cpu_fpr[src/2 + 1], tcg_env, offsetof(CPUSPARCState, qt0) +
-                   offsetof(CPU_QuadU, ll.lower));
-}
-
-static void gen_op_load_fpr_QT1(unsigned int src)
-{
-    tcg_gen_st_i64(cpu_fpr[src / 2], tcg_env, offsetof(CPUSPARCState, qt1) +
-                   offsetof(CPU_QuadU, ll.upper));
-    tcg_gen_st_i64(cpu_fpr[src/2 + 1], tcg_env, offsetof(CPUSPARCState, qt1) +
-                   offsetof(CPU_QuadU, ll.lower));
-}
-
 static void gen_op_store_QT0_fpr(unsigned int dst)
 {
     tcg_gen_ld_i64(cpu_fpr[dst / 2], tcg_env, offsetof(CPUSPARCState, qt0) +
@@ -1319,20 +1303,20 @@ static void gen_op_fcmpd(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
     }
 }
 
-static void gen_op_fcmpq(int fccno)
+static void gen_op_fcmpq(int fccno, TCGv_i128 r_rs1, TCGv_i128 r_rs2)
 {
     switch (fccno) {
     case 0:
-        gen_helper_fcmpq(cpu_fsr, tcg_env);
+        gen_helper_fcmpq(cpu_fsr, tcg_env, r_rs1, r_rs2);
         break;
     case 1:
-        gen_helper_fcmpq_fcc1(cpu_fsr, tcg_env);
+        gen_helper_fcmpq_fcc1(cpu_fsr, tcg_env, r_rs1, r_rs2);
         break;
     case 2:
-        gen_helper_fcmpq_fcc2(cpu_fsr, tcg_env);
+        gen_helper_fcmpq_fcc2(cpu_fsr, tcg_env, r_rs1, r_rs2);
         break;
     case 3:
-        gen_helper_fcmpq_fcc3(cpu_fsr, tcg_env);
+        gen_helper_fcmpq_fcc3(cpu_fsr, tcg_env, r_rs1, r_rs2);
         break;
     }
 }
@@ -1373,20 +1357,20 @@ static void gen_op_fcmped(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
     }
 }
 
-static void gen_op_fcmpeq(int fccno)
+static void gen_op_fcmpeq(int fccno, TCGv_i128 r_rs1, TCGv_i128 r_rs2)
 {
     switch (fccno) {
     case 0:
-        gen_helper_fcmpeq(cpu_fsr, tcg_env);
+        gen_helper_fcmpeq(cpu_fsr, tcg_env, r_rs1, r_rs2);
         break;
     case 1:
-        gen_helper_fcmpeq_fcc1(cpu_fsr, tcg_env);
+        gen_helper_fcmpeq_fcc1(cpu_fsr, tcg_env, r_rs1, r_rs2);
         break;
     case 2:
-        gen_helper_fcmpeq_fcc2(cpu_fsr, tcg_env);
+        gen_helper_fcmpeq_fcc2(cpu_fsr, tcg_env, r_rs1, r_rs2);
         break;
     case 3:
-        gen_helper_fcmpeq_fcc3(cpu_fsr, tcg_env);
+        gen_helper_fcmpeq_fcc3(cpu_fsr, tcg_env, r_rs1, r_rs2);
         break;
     }
 }
@@ -1403,9 +1387,9 @@ static void gen_op_fcmpd(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
     gen_helper_fcmpd(cpu_fsr, tcg_env, r_rs1, r_rs2);
 }
 
-static void gen_op_fcmpq(int fccno)
+static void gen_op_fcmpq(int fccno, TCGv_i128 r_rs1, TCGv_i128 r_rs2)
 {
-    gen_helper_fcmpq(cpu_fsr, tcg_env);
+    gen_helper_fcmpq(cpu_fsr, tcg_env, r_rs1, r_rs2);
 }
 
 static void gen_op_fcmpes(int fccno, TCGv r_rs1, TCGv r_rs2)
@@ -1418,9 +1402,9 @@ static void gen_op_fcmped(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
     gen_helper_fcmped(cpu_fsr, tcg_env, r_rs1, r_rs2);
 }
 
-static void gen_op_fcmpeq(int fccno)
+static void gen_op_fcmpeq(int fccno, TCGv_i128 r_rs1, TCGv_i128 r_rs2)
 {
-    gen_helper_fcmpeq(cpu_fsr, tcg_env);
+    gen_helper_fcmpeq(cpu_fsr, tcg_env, r_rs1, r_rs2);
 }
 #endif
 
@@ -5144,6 +5128,8 @@ TRANS(FCMPEd, ALL, do_fcmpd, a, true)
 
 static bool do_fcmpq(DisasContext *dc, arg_FCMPq *a, bool e)
 {
+    TCGv_i128 src1, src2;
+
     if (avail_32(dc) && a->cc != 0) {
         return false;
     }
@@ -5155,12 +5141,12 @@ static bool do_fcmpq(DisasContext *dc, arg_FCMPq *a, bool e)
     }
 
     gen_op_clear_ieee_excp_and_FTT();
-    gen_op_load_fpr_QT0(QFPREG(a->rs1));
-    gen_op_load_fpr_QT1(QFPREG(a->rs2));
+    src1 = gen_load_fpr_Q(dc, a->rs1);
+    src2 = gen_load_fpr_Q(dc, a->rs2);
     if (e) {
-        gen_op_fcmpeq(a->cc);
+        gen_op_fcmpeq(a->cc, src1, src2);
     } else {
-        gen_op_fcmpq(a->cc);
+        gen_op_fcmpq(a->cc, src1, src2);
     }
     return advance_pc(dc);
 }
-- 
2.34.1


