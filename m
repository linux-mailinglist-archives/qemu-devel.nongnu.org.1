Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 654557E07AB
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:41:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy8x-0005QS-8F; Fri, 03 Nov 2023 13:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8P-0005FZ-5y
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:39:05 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy89-0003Rq-ST
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:39:02 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cc0d0a0355so19406035ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699033128; x=1699637928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79UoIHmncXrhe4I6I98wXx5LW7um7q3ZZLn3iG6CLYg=;
 b=nMYtIzC72Gwc1H8TnscIRGyW674qjHtq7kahi/4lT3GE1kjVhPW1o0ARD0iTJsCTAi
 ytSycmHfZ1jzCRNk4IsID65bIipRlW1h3vIk6OOUNpLXm3VhThHQzCCTnoZrFr5pY1Un
 jsnuIsDnr3wOWux9lNJgWX2YDKFoRZAWnMg0uSp9I0RSdguV120q7jx8Jx+cALRkTdqu
 FO4DPuDeJFKhXK7HxRv2lk9QdLqaPIHr+9NU48cYbLYswQXPRrofzrsL8ZgRLbeNDSZX
 C84ACpxl+IgIji38oapsygCVmHdlbNVaBW+pnNZyECnQ8sCmBGnW/cZbI7p+1LhSdX6w
 ds/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033128; x=1699637928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79UoIHmncXrhe4I6I98wXx5LW7um7q3ZZLn3iG6CLYg=;
 b=RFcUjpOeHULLWiSeYeJPHErcVz376N15pdb8CvQf9TTuoMnIf2AVtYQXUxyr+aRnrc
 Ycxpdgt/jTEmdBsMYf8vF7fXV9I3tcgF5lWusCStRdQaFSnBR5YTJO8ViV/pl/lL74at
 EJ2W4ypcu3fS5IDIFdCPO13RBpuNo8pSPfGgc42e9jQnLIS6iWI1tfoxGXa8SQClX2A7
 Glxe5rnU3mYucvPuSbh25h13cYL4yUoJOm4HlkI3bfQXZH2JQebn2GYTIHBRqkpZFxjP
 mslYStOkyGivgJBYAO49WA5rVqdLGqDgoP2CpAJJHupikDu379+2fYdZnwInxlZ8HGdx
 mXJA==
X-Gm-Message-State: AOJu0Yznq4AFB8e7FBPxgynXXqMQWjqmyytkVhgOytSp+8R9W9Nv0vIE
 aMnb6vLvh9qc51hv8FbGpjiNYF9nUeO3CpN9mJU=
X-Google-Smtp-Source: AGHT+IEClxgoO3wBRaH9Y5DyrUDEQJI6J8vAqf+qK2ENKfw3hGbt2dpt8nTvTohlAB/EqiHXHUOYqg==
X-Received: by 2002:a17:903:22cf:b0:1cc:5521:570a with SMTP id
 y15-20020a17090322cf00b001cc5521570amr17770524plg.14.1699033128505; 
 Fri, 03 Nov 2023 10:38:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c10-20020a170902c1ca00b001c0cb2aa2easm1628267plc.121.2023.11.03.10.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:38:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 07/22] target/sparc: Use i128 for FADDq, FSUBq, FMULq, FDIVq
Date: Fri,  3 Nov 2023 10:38:26 -0700
Message-Id: <20231103173841.33651-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103173841.33651-1-richard.henderson@linaro.org>
References: <20231103173841.33651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/sparc/helper.h     | 12 +++++-------
 target/sparc/fop_helper.c | 29 ++++++++++++++---------------
 target/sparc/translate.c  | 13 +++++++------
 3 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index eea2fa570c..0a030fc908 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -67,17 +67,16 @@ DEF_HELPER_FLAGS_1(fcmpeq_fcc2, TCG_CALL_NO_WG, tl, env)
 DEF_HELPER_FLAGS_1(fcmpeq_fcc3, TCG_CALL_NO_WG, tl, env)
 #endif
 DEF_HELPER_2(raise_exception, noreturn, env, int)
-#define F_HELPER_0_1(name) \
-  DEF_HELPER_FLAGS_1(f ## name, TCG_CALL_NO_RWG, void, env)
 
 DEF_HELPER_FLAGS_3(faddd, TCG_CALL_NO_RWG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fsubd, TCG_CALL_NO_RWG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fmuld, TCG_CALL_NO_RWG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fdivd, TCG_CALL_NO_RWG, f64, env, f64, f64)
-F_HELPER_0_1(addq)
-F_HELPER_0_1(subq)
-F_HELPER_0_1(mulq)
-F_HELPER_0_1(divq)
+
+DEF_HELPER_FLAGS_3(faddq, TCG_CALL_NO_RWG, i128, env, i128, i128)
+DEF_HELPER_FLAGS_3(fsubq, TCG_CALL_NO_RWG, i128, env, i128, i128)
+DEF_HELPER_FLAGS_3(fmulq, TCG_CALL_NO_RWG, i128, env, i128, i128)
+DEF_HELPER_FLAGS_3(fdivq, TCG_CALL_NO_RWG, i128, env, i128, i128)
 
 DEF_HELPER_FLAGS_3(fadds, TCG_CALL_NO_RWG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fsubs, TCG_CALL_NO_RWG, f32, env, f32, f32)
@@ -135,6 +134,5 @@ VIS_CMPHELPER(cmpeq)
 VIS_CMPHELPER(cmple)
 VIS_CMPHELPER(cmpne)
 #endif
-#undef F_HELPER_0_1
 #undef VIS_HELPER
 #undef VIS_CMPHELPER
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index d639e50965..ceb64d802f 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -98,22 +98,22 @@ target_ulong helper_check_ieee_exceptions(CPUSPARCState *env)
     return do_check_ieee_exceptions(env, GETPC());
 }
 
-#define F_HELPER(name, p) void helper_f##name##p(CPUSPARCState *env)
-
-#define F_BINOP(name)                                           \
+#define F_BINOP(name)                                                \
     float32 helper_f ## name ## s (CPUSPARCState *env, float32 src1, \
-                                   float32 src2)                \
-    {                                                           \
-        return float32_ ## name (src1, src2, &env->fp_status);  \
-    }                                                           \
+                                   float32 src2)                     \
+    {                                                                \
+        return float32_ ## name (src1, src2, &env->fp_status);       \
+    }                                                                \
     float64 helper_f ## name ## d (CPUSPARCState * env, float64 src1,\
-                                   float64 src2)                \
-    {                                                           \
-        return float64_ ## name (src1, src2, &env->fp_status);  \
-    }                                                           \
-    F_HELPER(name, q)                                           \
-    {                                                           \
-        QT0 = float128_ ## name (QT0, QT1, &env->fp_status);    \
+                                   float64 src2)                     \
+    {                                                                \
+        return float64_ ## name (src1, src2, &env->fp_status);       \
+    }                                                                \
+    Int128 helper_f ## name ## q(CPUSPARCState * env, Int128 src1,   \
+                                 Int128 src2)                        \
+    {                                                                \
+        return f128_ret(float128_ ## name (f128_in(src1), f128_in(src2), \
+                                           &env->fp_status));        \
     }
 
 F_BINOP(add);
@@ -168,7 +168,6 @@ void helper_fxtoq(CPUSPARCState *env, int64_t src)
     QT0 = int64_to_float128(src, &env->fp_status);
 }
 #endif
-#undef F_HELPER
 
 /* floating point conversion */
 float32 helper_fdtos(CPUSPARCState *env, float64 src)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6c08bf909e..437f54ff19 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4976,8 +4976,10 @@ static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
 TRANS(PDIST, VIS1, do_dddd, a, gen_helper_pdist)
 
 static bool do_env_qqq(DisasContext *dc, arg_r_r_r *a,
-                       void (*func)(TCGv_env))
+                       void (*func)(TCGv_i128, TCGv_env, TCGv_i128, TCGv_i128))
 {
+    TCGv_i128 src1, src2;
+
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
@@ -4986,12 +4988,11 @@ static bool do_env_qqq(DisasContext *dc, arg_r_r_r *a,
     }
 
     gen_op_clear_ieee_excp_and_FTT();
-    gen_op_load_fpr_QT0(QFPREG(a->rs1));
-    gen_op_load_fpr_QT1(QFPREG(a->rs2));
-    func(tcg_env);
+    src1 = gen_load_fpr_Q(dc, a->rs1);
+    src2 = gen_load_fpr_Q(dc, a->rs2);
+    func(src1, tcg_env, src1, src2);
     gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-    gen_op_store_QT0_fpr(QFPREG(a->rd));
-    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    gen_store_fpr_Q(dc, a->rd, src1);
     return advance_pc(dc);
 }
 
-- 
2.34.1


