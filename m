Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 020287E079C
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:40:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy8o-0005LK-SC; Fri, 03 Nov 2023 13:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8F-0005E2-VH
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:56 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8C-0003T8-5p
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:54 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc316ccc38so24471195ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699033130; x=1699637930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lbb3rMlg4VD8iSbSZnACM2xokoJipwsMU8Cfj5jb73U=;
 b=dFEXkouJoLPKBSNbqJBDQ/VR5RTAJltMFjjBwxXPp60pUcbWQuYjW2Bi2tzwjR8W3Q
 lJIpmYlTJjvDuipD3Fl8USxq5JMaeY3AvR23LD5KSwiHglN11JH6cWZqGPovAbwoCuPO
 SVthkBnmEMBOmAdpINvUVQ2zMrKfZAaJVOcG8LNKZ/5ax0JVVlrb0skGNx+974m+oBXc
 hhYhyJjqOAugPG9rf3CBWKRw1/iCKQA2tUcexxzhcMrXh78AO8pLj6POctvPES40skn9
 FYyboDOre6tgPzRZV7HYBhVIklHA2AkrIccg2YRbkOnBejUswlKa0YA/9MDP8bpGuVQB
 +h5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033130; x=1699637930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lbb3rMlg4VD8iSbSZnACM2xokoJipwsMU8Cfj5jb73U=;
 b=PTZlXIYCBUNpp1SkRCXu8ZHg6cmskkpsuiReU1hoeTa3y/rf2NNJm1LAgPN7vpPBta
 8tHLAKvMe3OC8gjsu0iFfPwGduPg9kLfW8TNTc32DwGzrJigOoDaY/CQ3YZ7A3aVpYFq
 83MhmgHhjQ8cHBwbj3oDJoFOGDEyOQZYKOVVF3PwIuq0fm4aiZN3lQ88gU3IHIs8ksmC
 IrM1+zehFGD9lx1Bn8Wbh69RHz46kImDse3ZlgUyaoKgAd0EUljjvIOJfT1cUv8WdVTV
 j7CGN7ElXN/tUWvvp79UhHgjirKoJpOIq+nFrudHDsROOybjwrhahThIUNFRnR1lPZty
 rpEQ==
X-Gm-Message-State: AOJu0YxakZekkeeYDf8qXMEDiTDEBDp3YO/c5ng8WhneepBHVer+El3g
 3gg423iTTXhk2pqVqEjzKDgT82rzh0FDuzuKtoU=
X-Google-Smtp-Source: AGHT+IGo+zNA2ONweGnhqBt1CAxeNSXadyWxzYH5iFZaWIGmbgbWzFBIwwqjYrwRo5aTLB/noYl44g==
X-Received: by 2002:a17:903:1c6:b0:1cc:65bd:b453 with SMTP id
 e6-20020a17090301c600b001cc65bdb453mr13899071plh.32.1699033129888; 
 Fri, 03 Nov 2023 10:38:49 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c10-20020a170902c1ca00b001c0cb2aa2easm1628267plc.121.2023.11.03.10.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:38:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 09/22] target/sparc: Use i128 for FqTOd, FqTOx
Date: Fri,  3 Nov 2023 10:38:28 -0700
Message-Id: <20231103173841.33651-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103173841.33651-1-richard.henderson@linaro.org>
References: <20231103173841.33651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
index e770107eb0..4cb3451878 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -100,7 +100,7 @@ DEF_HELPER_FLAGS_2(fdtos, TCG_CALL_NO_RWG, f32, env, f64)
 DEF_HELPER_FLAGS_2(fstod, TCG_CALL_NO_RWG, f64, env, f32)
 DEF_HELPER_FLAGS_2(fqtos, TCG_CALL_NO_RWG, f32, env, i128)
 DEF_HELPER_FLAGS_2(fstoq, TCG_CALL_NO_RWG, void, env, f32)
-DEF_HELPER_FLAGS_1(fqtod, TCG_CALL_NO_RWG, f64, env)
+DEF_HELPER_FLAGS_2(fqtod, TCG_CALL_NO_RWG, f64, env, i128)
 DEF_HELPER_FLAGS_2(fdtoq, TCG_CALL_NO_RWG, void, env, f64)
 DEF_HELPER_FLAGS_2(fstoi, TCG_CALL_NO_RWG, s32, env, f32)
 DEF_HELPER_FLAGS_2(fdtoi, TCG_CALL_NO_RWG, s32, env, f64)
@@ -108,7 +108,7 @@ DEF_HELPER_FLAGS_2(fqtoi, TCG_CALL_NO_RWG, s32, env, i128)
 #ifdef TARGET_SPARC64
 DEF_HELPER_FLAGS_2(fstox, TCG_CALL_NO_RWG, s64, env, f32)
 DEF_HELPER_FLAGS_2(fdtox, TCG_CALL_NO_RWG, s64, env, f64)
-DEF_HELPER_FLAGS_1(fqtox, TCG_CALL_NO_RWG, s64, env)
+DEF_HELPER_FLAGS_2(fqtox, TCG_CALL_NO_RWG, s64, env, i128)
 
 DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 657a14575d..9f39b933e8 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -190,9 +190,9 @@ void helper_fstoq(CPUSPARCState *env, float32 src)
     QT0 = float32_to_float128(src, &env->fp_status);
 }
 
-float64 helper_fqtod(CPUSPARCState *env)
+float64 helper_fqtod(CPUSPARCState *env, Int128 src)
 {
-    return float128_to_float64(QT1, &env->fp_status);
+    return float128_to_float64(f128_in(src), &env->fp_status);
 }
 
 void helper_fdtoq(CPUSPARCState *env, float64 src)
@@ -227,9 +227,9 @@ int64_t helper_fdtox(CPUSPARCState *env, float64 src)
     return float64_to_int64_round_to_zero(src, &env->fp_status);
 }
 
-int64_t helper_fqtox(CPUSPARCState *env)
+int64_t helper_fqtox(CPUSPARCState *env, Int128 src)
 {
-    return float128_to_int64_round_to_zero(QT1, &env->fp_status);
+    return float128_to_int64_round_to_zero(f128_in(src), &env->fp_status);
 }
 #endif
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 34a774c8ef..ba0b7f32d2 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4717,8 +4717,9 @@ TRANS(FqTOs, ALL, do_env_fq, a, gen_helper_fqtos)
 TRANS(FqTOi, ALL, do_env_fq, a, gen_helper_fqtoi)
 
 static bool do_env_dq(DisasContext *dc, arg_r_r *a,
-                      void (*func)(TCGv_i64, TCGv_env))
+                      void (*func)(TCGv_i64, TCGv_env, TCGv_i128))
 {
+    TCGv_i128 src;
     TCGv_i64 dst;
 
     if (gen_trap_ifnofpu(dc)) {
@@ -4729,9 +4730,9 @@ static bool do_env_dq(DisasContext *dc, arg_r_r *a,
     }
 
     gen_op_clear_ieee_excp_and_FTT();
-    gen_op_load_fpr_QT1(QFPREG(a->rs));
+    src = gen_load_fpr_Q(dc, a->rs);
     dst = gen_dest_fpr_D(dc, a->rd);
-    func(dst, tcg_env);
+    func(dst, tcg_env, src);
     gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
     gen_store_fpr_D(dc, a->rd, dst);
     return advance_pc(dc);
-- 
2.34.1


