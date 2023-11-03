Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BDC7E079D
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:40:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy8a-0005H5-US; Fri, 03 Nov 2023 13:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8I-0005Ek-Bh
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:39:00 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8E-0003UC-Rw
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:56 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc7077d34aso19339285ad.2
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699033132; x=1699637932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YRZtObwWQaX9TO3lug87cQ176cg0u3ArC+G+NFVft7c=;
 b=qUWLGIkghipUuswd68B9AHJ78JODQUrYMDKcmKZjsR6G+KVa3bjiVnF/GvEgZsNOSq
 ijCnkakXeUD2SLVTe8xxr+XxFz5iqdm0KKHSqng75ZACdPzNBP4GQXH6AShj1y70KZRZ
 Mo1IBSqWT9hxp4jlOeQzKvHZO+UPxx6HW44iBpRmwk5umQQmxazf3Bsors3v/h4zDKdE
 2Pjy1jbVowCha+xjQHtyD0MYyMxNtnINvkds27HUkjRpYQu/hmK1uatv1FaexULKCNI7
 LChMudIjgbExyZ2xypS3nN7wy7L9boAqohItvP/hlI2OCw180CiEracUrbpIDy8B6yuA
 u8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033132; x=1699637932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YRZtObwWQaX9TO3lug87cQ176cg0u3ArC+G+NFVft7c=;
 b=slXabqu9TKZ/AvH4z7wg2/DcmZ4vtQ/1F/NpcowEJ1+7YR5bETZDLvnfVLHT0f6oCG
 ngCwvzdLFsYQQc5dXWifpj+AyYxYmwVE3IUXTb8cViQNCuYz88WOG36ZfUaLJ2i2pUPm
 UFB98OmU9I7YHbVbiyeox7re7sMaMxHWjMfiFXz1yAfaYBXKAaU/SdqFUw85EQ5MbvxH
 0lRPSeM/0GmzYGKea8PUcFkR1gnYSlB7X3BcWKBlkDe29VbZ0qlnWO/t3sUR785gfjOM
 gQDP06GUUhZSo3dI3AdoyYDPgmNA3VFyW6iz4OtP5qW9TuNkdAGoQxZ1T0mcFv4I6mZS
 ytSw==
X-Gm-Message-State: AOJu0YwylRF40DlimZme7LKXWI6qvmudq2mINUxITKUh46sDl4Z3I0EF
 s4s5KmAsKpSXsyNa6Sq7r+g1pKEyGHQkKRZM3jE=
X-Google-Smtp-Source: AGHT+IHMV+BJT2ibdd4Ke3Lbhz2EP4sfiZjIgGHQSK3eCFIq13CS4WnZoF/h6NdKl/q5YDyDtA48bA==
X-Received: by 2002:a17:903:2306:b0:1cc:3fc9:1802 with SMTP id
 d6-20020a170903230600b001cc3fc91802mr17475751plh.61.1699033132275; 
 Fri, 03 Nov 2023 10:38:52 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c10-20020a170902c1ca00b001c0cb2aa2easm1628267plc.121.2023.11.03.10.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:38:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 12/22] target/sparc: Use i128 for FdTOq, FxTOq
Date: Fri,  3 Nov 2023 10:38:31 -0700
Message-Id: <20231103173841.33651-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103173841.33651-1-richard.henderson@linaro.org>
References: <20231103173841.33651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 target/sparc/translate.c  | 9 +++++----
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 5e93342583..20f67f89b0 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -94,14 +94,14 @@ DEF_HELPER_FLAGS_2(fitos, TCG_CALL_NO_RWG, f32, env, s32)
 #ifdef TARGET_SPARC64
 DEF_HELPER_FLAGS_2(fxtos, TCG_CALL_NO_RWG, f32, env, s64)
 DEF_HELPER_FLAGS_2(fxtod, TCG_CALL_NO_RWG, f64, env, s64)
-DEF_HELPER_FLAGS_2(fxtoq, TCG_CALL_NO_RWG, void, env, s64)
+DEF_HELPER_FLAGS_2(fxtoq, TCG_CALL_NO_RWG, i128, env, s64)
 #endif
 DEF_HELPER_FLAGS_2(fdtos, TCG_CALL_NO_RWG, f32, env, f64)
 DEF_HELPER_FLAGS_2(fstod, TCG_CALL_NO_RWG, f64, env, f32)
 DEF_HELPER_FLAGS_2(fqtos, TCG_CALL_NO_RWG, f32, env, i128)
 DEF_HELPER_FLAGS_2(fstoq, TCG_CALL_NO_RWG, i128, env, f32)
 DEF_HELPER_FLAGS_2(fqtod, TCG_CALL_NO_RWG, f64, env, i128)
-DEF_HELPER_FLAGS_2(fdtoq, TCG_CALL_NO_RWG, void, env, f64)
+DEF_HELPER_FLAGS_2(fdtoq, TCG_CALL_NO_RWG, i128, env, f64)
 DEF_HELPER_FLAGS_2(fstoi, TCG_CALL_NO_RWG, s32, env, f32)
 DEF_HELPER_FLAGS_2(fdtoi, TCG_CALL_NO_RWG, s32, env, f64)
 DEF_HELPER_FLAGS_2(fqtoi, TCG_CALL_NO_RWG, s32, env, i128)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index c7dc835d28..9a0110e201 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -163,9 +163,9 @@ float64 helper_fxtod(CPUSPARCState *env, int64_t src)
     return int64_to_float64(src, &env->fp_status);
 }
 
-void helper_fxtoq(CPUSPARCState *env, int64_t src)
+Int128 helper_fxtoq(CPUSPARCState *env, int64_t src)
 {
-    QT0 = int64_to_float128(src, &env->fp_status);
+    return f128_ret(int64_to_float128(src, &env->fp_status));
 }
 #endif
 
@@ -195,9 +195,9 @@ float64 helper_fqtod(CPUSPARCState *env, Int128 src)
     return float128_to_float64(f128_in(src), &env->fp_status);
 }
 
-void helper_fdtoq(CPUSPARCState *env, float64 src)
+Int128 helper_fdtoq(CPUSPARCState *env, float64 src)
 {
-    QT0 = float64_to_float128(src, &env->fp_status);
+    return f128_ret(float64_to_float128(src, &env->fp_status));
 }
 
 /* Float to integer conversion.  */
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1f96990316..e01cbc5bcb 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4750,9 +4750,10 @@ TRANS(FiTOq, ALL, do_env_qf, a, gen_helper_fitoq)
 TRANS(FsTOq, ALL, do_env_qf, a, gen_helper_fstoq)
 
 static bool do_env_qd(DisasContext *dc, arg_r_r *a,
-                      void (*func)(TCGv_env, TCGv_i64))
+                      void (*func)(TCGv_i128, TCGv_env, TCGv_i64))
 {
     TCGv_i64 src;
+    TCGv_i128 dst;
 
     if (gen_trap_ifnofpu(dc)) {
         return true;
@@ -4763,9 +4764,9 @@ static bool do_env_qd(DisasContext *dc, arg_r_r *a,
 
     gen_op_clear_ieee_excp_and_FTT();
     src = gen_load_fpr_D(dc, a->rs);
-    func(tcg_env, src);
-    gen_op_store_QT0_fpr(QFPREG(a->rd));
-    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    dst = tcg_temp_new_i128();
+    func(dst, tcg_env, src);
+    gen_store_fpr_Q(dc, a->rd, dst);
     return advance_pc(dc);
 }
 
-- 
2.34.1


