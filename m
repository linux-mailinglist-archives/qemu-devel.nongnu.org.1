Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9A97E0798
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:40:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy8U-0005GH-0Y; Fri, 03 Nov 2023 13:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8K-0005Ex-QO
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:39:01 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8F-0003VR-MW
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:58 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc3216b2a1so24354205ad.2
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699033133; x=1699637933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V230nSs1H4kGSikZfBS8US/3aV2ZoAIvMpmb/SpDknc=;
 b=VHPFzy46NbdZaP8n8FKd2iv9lHNtII4PextpmJnI8IKlko3t+3ASXFATL0y0wjr40k
 cN2Yzb37Si6Oy2ut0PJ1e9rxC/0RJ2XgQNuEjwiM5cY5pVJIsbRBhZOvMjj4kEXQuFJe
 EqiQpb9LZ6WRWJeZp1Jk5MF+OSWULcODQACfCC9zXbWWyQ5WCkwhDEToPvCqupKk7r4h
 a+0HsEk5tdvymG0uBysKXS3R30h6Z89w1ONUUlXHXO5GbQzukQWhSPgSBwShL9Lv0OVd
 wDtoEEhftSnddCtZWodOBgGeYs5clqe6RctSSCjievDbn34xNiRvcpilRWB/giVmot+R
 P0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033133; x=1699637933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V230nSs1H4kGSikZfBS8US/3aV2ZoAIvMpmb/SpDknc=;
 b=TNMK8xCt0F06BQgTJFNi4nCnYIMDdTYxJ15G8gfZ0lSKISnic7I53W5n8QhrfvFveP
 e9t3WfZ7oCB2cKDLkhswHp5YvhK/sSF5oMeI5SREQ7iFw3NGMYtSze1/2+uR2F376KYX
 f1ZznuW7vG3pVwZbhRD++xTDHEp0TfyuoHUltY5TazG2xhlj5jFGIYIPzhD40NF/T+y5
 Ly3KakkxtFvgXQ7dAN5AUzuEnW3DLQIh38ZzHF24WRyFtvScFGyXFvdRutUWgSbYfVhb
 b792iyleKxNefxejSit+08H2mfzNH9DiUQJq0x+NBD4Znv2wubmql5NcXLC2VLtBhSAc
 NsIQ==
X-Gm-Message-State: AOJu0YyMTlH/Jex8VFCeIsFN3viGUr3gQSQUXVMsBuhQVlF/k8Y5T6yA
 eOO7w/CH32KKF7J2SfJi6Z+EOGreyClAv7HSzPM=
X-Google-Smtp-Source: AGHT+IFuPcadBWxmvvNeJ00Hp4U+CjuBILW93Jbd53rnnHHbJ4XboIDjDNj2vW8tOHsyJODCJSTAgw==
X-Received: by 2002:a17:903:6c7:b0:1cc:7a8e:6079 with SMTP id
 kj7-20020a17090306c700b001cc7a8e6079mr6647396plb.11.1699033133209; 
 Fri, 03 Nov 2023 10:38:53 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c10-20020a170902c1ca00b001c0cb2aa2easm1628267plc.121.2023.11.03.10.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:38:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 13/22] target/sparc: Use i128 for Fdmulq
Date: Fri,  3 Nov 2023 10:38:32 -0700
Message-Id: <20231103173841.33651-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103173841.33651-1-richard.henderson@linaro.org>
References: <20231103173841.33651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
 target/sparc/helper.h     |  2 +-
 target/sparc/fop_helper.c |  8 ++++----
 target/sparc/translate.c  | 15 ++++-----------
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 20f67f89b0..f7aeb31169 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -84,7 +84,7 @@ DEF_HELPER_FLAGS_3(fmuls, TCG_CALL_NO_RWG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fdivs, TCG_CALL_NO_RWG, f32, env, f32, f32)
 
 DEF_HELPER_FLAGS_3(fsmuld, TCG_CALL_NO_RWG, f64, env, f32, f32)
-DEF_HELPER_FLAGS_3(fdmulq, TCG_CALL_NO_RWG, void, env, f64, f64)
+DEF_HELPER_FLAGS_3(fdmulq, TCG_CALL_NO_RWG, i128, env, f64, f64)
 
 DEF_HELPER_FLAGS_2(fitod, TCG_CALL_NO_RWG_SE, f64, env, s32)
 DEF_HELPER_FLAGS_2(fitoq, TCG_CALL_NO_RWG, i128, env, s32)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 9a0110e201..cd9b212597 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -129,11 +129,11 @@ float64 helper_fsmuld(CPUSPARCState *env, float32 src1, float32 src2)
                        &env->fp_status);
 }
 
-void helper_fdmulq(CPUSPARCState *env, float64 src1, float64 src2)
+Int128 helper_fdmulq(CPUSPARCState *env, float64 src1, float64 src2)
 {
-    QT0 = float128_mul(float64_to_float128(src1, &env->fp_status),
-                       float64_to_float128(src2, &env->fp_status),
-                       &env->fp_status);
+    return f128_ret(float128_mul(float64_to_float128(src1, &env->fp_status),
+                                 float64_to_float128(src2, &env->fp_status),
+                                 &env->fp_status));
 }
 
 /* Integer to float conversion.  */
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index e01cbc5bcb..99482df256 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -276,14 +276,6 @@ static void gen_store_fpr_Q(DisasContext *dc, unsigned int dst, TCGv_i128 v)
     gen_update_fprs_dirty(dc, dst);
 }
 
-static void gen_op_store_QT0_fpr(unsigned int dst)
-{
-    tcg_gen_ld_i64(cpu_fpr[dst / 2], tcg_env, offsetof(CPUSPARCState, qt0) +
-                   offsetof(CPU_QuadU, ll.upper));
-    tcg_gen_ld_i64(cpu_fpr[dst/2 + 1], tcg_env, offsetof(CPUSPARCState, qt0) +
-                   offsetof(CPU_QuadU, ll.lower));
-}
-
 /* moves */
 #ifdef CONFIG_USER_ONLY
 #define supervisor(dc) 0
@@ -4992,6 +4984,7 @@ TRANS(FDIVq, ALL, do_env_qqq, a, gen_helper_fdivq)
 static bool trans_FdMULq(DisasContext *dc, arg_r_r_r *a)
 {
     TCGv_i64 src1, src2;
+    TCGv_i128 dst;
 
     if (gen_trap_ifnofpu(dc)) {
         return true;
@@ -5003,10 +4996,10 @@ static bool trans_FdMULq(DisasContext *dc, arg_r_r_r *a)
     gen_op_clear_ieee_excp_and_FTT();
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
-    gen_helper_fdmulq(tcg_env, src1, src2);
+    dst = tcg_temp_new_i128();
+    gen_helper_fdmulq(dst, tcg_env, src1, src2);
     gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-    gen_op_store_QT0_fpr(QFPREG(a->rd));
-    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    gen_store_fpr_Q(dc, a->rd, dst);
     return advance_pc(dc);
 }
 
-- 
2.34.1


