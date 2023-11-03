Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CA97E079A
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:40:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy8c-0005Hi-Vi; Fri, 03 Nov 2023 13:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8F-0005E4-WD
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:56 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8C-0003Tw-Rx
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:54 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cc3388621cso27367145ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699033131; x=1699637931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9/Fy2RC41FFUq2KQ+J32FhgY01C6DRftqW1d2nHNNg=;
 b=Q0D/UwYNEytcN+I8W2qqgsIswjvL0bI0qllBrInshImgVyM9liwt0oIBLucVYgeVy3
 6ZPlN/D3AWKqGqjtoQYuW9WmVOMFPmziFtc5CpoSCILhjRItyYNPnWjMrsWdm6QqaspB
 4SxNsBTEauAcMzUh88YsV4nywgVZovd+E2nmO1u93fJJbMmKahLyos5VIm8WHBJ2pjtu
 5+y2w7ns7OP+tWo0q9bwq8chjd7++JoL8kLePhyTDpqahpK3sjFDK5oRyJ6A8vrRIUc6
 BHpUvWUeuLWPqBMOz3yb8TzZ0S+dKdKhpqJalTMrFmuPGEsIBJGeV7hg7KVgvjCnThd/
 HSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033131; x=1699637931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F9/Fy2RC41FFUq2KQ+J32FhgY01C6DRftqW1d2nHNNg=;
 b=ZLtlyyCOU0YpN9G+XYkJGQeOAb/JpHJH72TqfL3UGW6UJSn2b1sU6rMx6EfvVYuo7n
 lZQ0agImUl/tbAxHqNI2tK+PkO6WywD9PPgz/X5Ae976+7GI1g0z6pQ+GnELxgjg9ScO
 00CctqdjJ6Wyom8ESlk688+2Z+UprrYWg1O09JN+JikblnAnTEHkwv4t65QVoQaUY3sM
 DAQu7RgQTzaJqkKFdnYZGmAfeqVwf2hIgTkxxkTB72GnI3wX2czYarydDC4cmsbsi2Up
 7MRe9z4QgfCkKHNtJabIR2XNAJ1Cy03rmu5C6B2+vSSWy1rybGiBdKKfkYPHvjDYjl9J
 Eg0w==
X-Gm-Message-State: AOJu0YzIR+p3gDPVnBhZ71ImgqncY0dbv027iUuBc5mxzPJAN4YqXs41
 acNtdygNfvzIm0i4x7LX8ucAZSMC2c0bAjRP6IQ=
X-Google-Smtp-Source: AGHT+IF/H2T9lH3PMtZTf4uDE23GTV+z652IY76DSW7vjh0X/4Jy6xsu7WxGjp+feJqai7uCtnSGDA==
X-Received: by 2002:a17:903:2301:b0:1cc:419e:cb4b with SMTP id
 d1-20020a170903230100b001cc419ecb4bmr4601341plh.19.1699033131469; 
 Fri, 03 Nov 2023 10:38:51 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c10-20020a170902c1ca00b001c0cb2aa2easm1628267plc.121.2023.11.03.10.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:38:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 11/22] target/sparc: Use i128 for FsTOq, FiTOq
Date: Fri,  3 Nov 2023 10:38:30 -0700
Message-Id: <20231103173841.33651-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103173841.33651-1-richard.henderson@linaro.org>
References: <20231103173841.33651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
index 7caae9a441..5e93342583 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -87,7 +87,7 @@ DEF_HELPER_FLAGS_3(fsmuld, TCG_CALL_NO_RWG, f64, env, f32, f32)
 DEF_HELPER_FLAGS_3(fdmulq, TCG_CALL_NO_RWG, void, env, f64, f64)
 
 DEF_HELPER_FLAGS_2(fitod, TCG_CALL_NO_RWG_SE, f64, env, s32)
-DEF_HELPER_FLAGS_2(fitoq, TCG_CALL_NO_RWG, void, env, s32)
+DEF_HELPER_FLAGS_2(fitoq, TCG_CALL_NO_RWG, i128, env, s32)
 
 DEF_HELPER_FLAGS_2(fitos, TCG_CALL_NO_RWG, f32, env, s32)
 
@@ -99,7 +99,7 @@ DEF_HELPER_FLAGS_2(fxtoq, TCG_CALL_NO_RWG, void, env, s64)
 DEF_HELPER_FLAGS_2(fdtos, TCG_CALL_NO_RWG, f32, env, f64)
 DEF_HELPER_FLAGS_2(fstod, TCG_CALL_NO_RWG, f64, env, f32)
 DEF_HELPER_FLAGS_2(fqtos, TCG_CALL_NO_RWG, f32, env, i128)
-DEF_HELPER_FLAGS_2(fstoq, TCG_CALL_NO_RWG, void, env, f32)
+DEF_HELPER_FLAGS_2(fstoq, TCG_CALL_NO_RWG, i128, env, f32)
 DEF_HELPER_FLAGS_2(fqtod, TCG_CALL_NO_RWG, f64, env, i128)
 DEF_HELPER_FLAGS_2(fdtoq, TCG_CALL_NO_RWG, void, env, f64)
 DEF_HELPER_FLAGS_2(fstoi, TCG_CALL_NO_RWG, s32, env, f32)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index faf75e651f..c7dc835d28 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -147,9 +147,9 @@ float64 helper_fitod(CPUSPARCState *env, int32_t src)
     return int32_to_float64(src, &env->fp_status);
 }
 
-void helper_fitoq(CPUSPARCState *env, int32_t src)
+Int128 helper_fitoq(CPUSPARCState *env, int32_t src)
 {
-    QT0 = int32_to_float128(src, &env->fp_status);
+    return f128_ret(int32_to_float128(src, &env->fp_status));
 }
 
 #ifdef TARGET_SPARC64
@@ -185,9 +185,9 @@ float32 helper_fqtos(CPUSPARCState *env, Int128 src)
     return float128_to_float32(f128_in(src), &env->fp_status);
 }
 
-void helper_fstoq(CPUSPARCState *env, float32 src)
+Int128 helper_fstoq(CPUSPARCState *env, float32 src)
 {
-    QT0 = float32_to_float128(src, &env->fp_status);
+    return f128_ret(float32_to_float128(src, &env->fp_status));
 }
 
 float64 helper_fqtod(CPUSPARCState *env, Int128 src)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d4eea47c33..1f96990316 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4726,9 +4726,10 @@ TRANS(FqTOd, ALL, do_env_dq, a, gen_helper_fqtod)
 TRANS(FqTOx, 64, do_env_dq, a, gen_helper_fqtox)
 
 static bool do_env_qf(DisasContext *dc, arg_r_r *a,
-                      void (*func)(TCGv_env, TCGv_i32))
+                      void (*func)(TCGv_i128, TCGv_env, TCGv_i32))
 {
     TCGv_i32 src;
+    TCGv_i128 dst;
 
     if (gen_trap_ifnofpu(dc)) {
         return true;
@@ -4739,9 +4740,9 @@ static bool do_env_qf(DisasContext *dc, arg_r_r *a,
 
     gen_op_clear_ieee_excp_and_FTT();
     src = gen_load_fpr_F(dc, a->rs);
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


