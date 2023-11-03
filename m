Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D382F7E07A4
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:40:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy8o-0005J1-9u; Fri, 03 Nov 2023 13:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8F-0005Di-2l
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:55 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8B-0003T4-Lh
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:53 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5b9a453d3d3so1810509a12.0
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699033129; x=1699637929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3DmrBxth2vygap1Jwf3K0CAb91IeeCiLK8OJMpHVdUM=;
 b=EOGa6ElRFXlgtQoztyw/sO7dYAkrvU+SC9+ZmWza1q5nJ9uxkTqjplMxi/TJMGt0Mt
 aHFqYxU2unlJFpLloGWgFUb963BXxAeiVmA15N49yITPg0rIkpDpmrGkxvruV2VBNITu
 dIAHffM1Di+ltGLo2Ectt6uMiiQjz/BVfMt7x6CVyCzl1baEDXCvw9RxCk1qjexfF4qz
 Mqhyw0UeAkwATP7/2VAMjLjZFR9R0rVRQluxqxnPPhJblScq7vuPxT1B/fY4yKwmqldC
 s9qGbOP+wfCYjxlqeA+x12dYL/kUTsYUyb8JEcSNAm6CanhjFLOaD8QslhMcy2cbt+AW
 SyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033129; x=1699637929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3DmrBxth2vygap1Jwf3K0CAb91IeeCiLK8OJMpHVdUM=;
 b=DJq6/0Q439OAWVW/vjd7vTDBUb3+4aeFYxPF8RhVd87yXTb1QbXS474Ox9RDxixuCR
 xtsT6JoBGKGCnDpQq08GsEOj7Dj0JUvNW+M32x7rlneW11bnBdCVOid8Xd0H/twMYrcx
 ueLT7Zb0tPL0w9857U9JuYMv7bPJDrd7/DHfpK0meApUMnDiKuvMJC3n/AGH14XGt3D4
 JRtKXL9Yr7kPxDsXzFRO7alPeaHywANjC2tmuNONkhdoBuZxrfE2Q2hrL/bsA8pxIkyY
 XjSsUfRTgfB6WPoREHybRfnqRACJ+X0+xfhjdprmYrYMhGY9uL02vWvvPUuUbAdTcWxj
 Sp5w==
X-Gm-Message-State: AOJu0YxGZtabxcBx3BCWKkb0793/8DvgygTtWexwhCvVKo8sRvP3Eq+2
 bhe8Tf30ao6lNW87N1zZ5IYrmyHcyp3MNpA2pAo=
X-Google-Smtp-Source: AGHT+IHudNLf5tSWOYqEruRVX/lZXu58LC07FXPDQnn8fGlB7crpcLPMfT+Dmcu6UeAO/nhPMnTxYA==
X-Received: by 2002:a05:6a20:42a5:b0:15d:624c:6e43 with SMTP id
 o37-20020a056a2042a500b0015d624c6e43mr22817490pzj.3.1699033129226; 
 Fri, 03 Nov 2023 10:38:49 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c10-20020a170902c1ca00b001c0cb2aa2easm1628267plc.121.2023.11.03.10.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:38:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 08/22] target/sparc: Use i128 for FqTOs, FqTOi
Date: Fri,  3 Nov 2023 10:38:27 -0700
Message-Id: <20231103173841.33651-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103173841.33651-1-richard.henderson@linaro.org>
References: <20231103173841.33651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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
 target/sparc/helper.h     | 4 ++--
 target/sparc/fop_helper.c | 8 ++++----
 target/sparc/translate.c  | 7 ++++---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 0a030fc908..e770107eb0 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -98,13 +98,13 @@ DEF_HELPER_FLAGS_2(fxtoq, TCG_CALL_NO_RWG, void, env, s64)
 #endif
 DEF_HELPER_FLAGS_2(fdtos, TCG_CALL_NO_RWG, f32, env, f64)
 DEF_HELPER_FLAGS_2(fstod, TCG_CALL_NO_RWG, f64, env, f32)
-DEF_HELPER_FLAGS_1(fqtos, TCG_CALL_NO_RWG, f32, env)
+DEF_HELPER_FLAGS_2(fqtos, TCG_CALL_NO_RWG, f32, env, i128)
 DEF_HELPER_FLAGS_2(fstoq, TCG_CALL_NO_RWG, void, env, f32)
 DEF_HELPER_FLAGS_1(fqtod, TCG_CALL_NO_RWG, f64, env)
 DEF_HELPER_FLAGS_2(fdtoq, TCG_CALL_NO_RWG, void, env, f64)
 DEF_HELPER_FLAGS_2(fstoi, TCG_CALL_NO_RWG, s32, env, f32)
 DEF_HELPER_FLAGS_2(fdtoi, TCG_CALL_NO_RWG, s32, env, f64)
-DEF_HELPER_FLAGS_1(fqtoi, TCG_CALL_NO_RWG, s32, env)
+DEF_HELPER_FLAGS_2(fqtoi, TCG_CALL_NO_RWG, s32, env, i128)
 #ifdef TARGET_SPARC64
 DEF_HELPER_FLAGS_2(fstox, TCG_CALL_NO_RWG, s64, env, f32)
 DEF_HELPER_FLAGS_2(fdtox, TCG_CALL_NO_RWG, s64, env, f64)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index ceb64d802f..657a14575d 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -180,9 +180,9 @@ float64 helper_fstod(CPUSPARCState *env, float32 src)
     return float32_to_float64(src, &env->fp_status);
 }
 
-float32 helper_fqtos(CPUSPARCState *env)
+float32 helper_fqtos(CPUSPARCState *env, Int128 src)
 {
-    return float128_to_float32(QT1, &env->fp_status);
+    return float128_to_float32(f128_in(src), &env->fp_status);
 }
 
 void helper_fstoq(CPUSPARCState *env, float32 src)
@@ -211,9 +211,9 @@ int32_t helper_fdtoi(CPUSPARCState *env, float64 src)
     return float64_to_int32_round_to_zero(src, &env->fp_status);
 }
 
-int32_t helper_fqtoi(CPUSPARCState *env)
+int32_t helper_fqtoi(CPUSPARCState *env, Int128 src)
 {
-    return float128_to_int32_round_to_zero(QT1, &env->fp_status);
+    return float128_to_int32_round_to_zero(f128_in(src), &env->fp_status);
 }
 
 #ifdef TARGET_SPARC64
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 437f54ff19..34a774c8ef 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4692,8 +4692,9 @@ static bool do_env_qq(DisasContext *dc, arg_r_r *a,
 TRANS(FSQRTq, ALL, do_env_qq, a, gen_helper_fsqrtq)
 
 static bool do_env_fq(DisasContext *dc, arg_r_r *a,
-                      void (*func)(TCGv_i32, TCGv_env))
+                      void (*func)(TCGv_i32, TCGv_env, TCGv_i128))
 {
+    TCGv_i128 src;
     TCGv_i32 dst;
 
     if (gen_trap_ifnofpu(dc)) {
@@ -4704,9 +4705,9 @@ static bool do_env_fq(DisasContext *dc, arg_r_r *a,
     }
 
     gen_op_clear_ieee_excp_and_FTT();
-    gen_op_load_fpr_QT1(QFPREG(a->rs));
+    src = gen_load_fpr_Q(dc, a->rs);
     dst = tcg_temp_new_i32();
-    func(dst, tcg_env);
+    func(dst, tcg_env, src);
     gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
     gen_store_fpr_F(dc, a->rd, dst);
     return advance_pc(dc);
-- 
2.34.1


