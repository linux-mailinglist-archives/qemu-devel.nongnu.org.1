Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9749F7E33AB
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:12:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRb-0004Xq-Rs; Mon, 06 Nov 2023 22:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRW-0004SF-Pa
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:54 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRU-0001P2-Rx
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:54 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-27db9fdec0dso4943347a91.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326471; x=1699931271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5LcF9LoYUfkHMUXrodl2B+uzzvbwDBzafXMANmAdcak=;
 b=GxKqQgtCNnHpEb9pukT0UeXsmpDgKw4PYXGdJXeEA/SKio2yKuppe+QCeIsMRQw7K1
 r6OPKp2aVsdgB/tEoyCowlDMkThBh0Lw1CCNLEysSJR93DU8itlA0O0BjCk6s8KnyRbK
 EuIzI9nch9fG/dcP2iDu+pZH7qzQ569BfLNbUB4BEar+P3/GxhCaQtAvO18s8OSc93QI
 pwvCqoy363TPbhi0HvShHrvwmxucBr3fEuQu/WQa06nTKGbVI3G7mUzyUPiVG6yQOjFz
 Svjd51Dv0npsDYnAcEj5r/7ieL0XDRc836dUYnMULdU47CPAf+M+2azuuzVUbhhvtGwB
 7p5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326471; x=1699931271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5LcF9LoYUfkHMUXrodl2B+uzzvbwDBzafXMANmAdcak=;
 b=YDHT9F3D1+4sRr+CvFNluGE1YtF7b3XPTi/8nf+cy7O5a0S3QdaQQ6C9EUUJh9O00h
 yLU15tC9cxunArTfPbPuK/yGYZ8f7pgsa/ABB+aa/Yo0TrAPnG8Srx0+omxJcvhUAznn
 c0zDhvwkKvSjiinMQIN+LFzV84/VZYkd8ZWypbvEgdOhcbPwET9Lq67PWw6/HC0kDxO3
 ZDfHbcE0z8udtzDsgAIE+3SsfaCTHZZnZSE9Au5lYXNUBcqLiXcOYWCuexgEMb8zb/Vk
 6C+vO9UqjS8Xnxn4Fp6YgOTAMuxsRWTRYuyefeo8/cILU6ytww7A1eZrusrBrpQNAxTI
 7X0w==
X-Gm-Message-State: AOJu0YxxZjidi+4SVT8yiZP8VY5dqfBFjrF9T4uknFaTl2adsECk0xFU
 PpAX9Gr//jSwO5/8pBbUaBdu07JteP8Nx0Pe9jM=
X-Google-Smtp-Source: AGHT+IHrjeeea20SrI7NBhMa7igVJWlf5dXsZ4qiMWnZZwHqbnJtJWy1Jh+iut3IEWC3ywV37TX/sA==
X-Received: by 2002:a17:90a:34d:b0:280:c9a1:861e with SMTP id
 13-20020a17090a034d00b00280c9a1861emr15214644pjf.13.1699326471441; 
 Mon, 06 Nov 2023 19:07:51 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 57/85] target/hppa: Remove remaining TARGET_REGISTER_BITS
 redirections
Date: Mon,  6 Nov 2023 19:03:39 -0800
Message-Id: <20231107030407.8979-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

The conversions to/from i64 can be eliminated entirely,
folding computation into adjacent operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 46 ++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ec3f70e46e..0024c38c84 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -33,15 +33,6 @@
 #undef  HELPER_H
 
 
-/* Since we have a distinction between register size and address size,
-   we need to redefine all of these.  */
-
-#define tcg_gen_extu_reg_tl  tcg_gen_mov_i64
-#define tcg_gen_trunc_i64_reg tcg_gen_mov_i64
-#define tcg_gen_extu_reg_i64 tcg_gen_mov_i64
-#define tcg_gen_ext_reg_i64  tcg_gen_mov_i64
-
-
 typedef struct DisasCond {
     TCGCond c;
     TCGv_i64 a0, a1;
@@ -1345,8 +1336,7 @@ static void form_gva(DisasContext *ctx, TCGv_i64 *pgva, TCGv_i64 *pofs,
 
     *pofs = ofs;
     *pgva = addr = tcg_temp_new_i64();
-    tcg_gen_extu_reg_tl(addr, modify <= 0 ? ofs : base);
-    tcg_gen_andi_tl(addr, addr, gva_offset_mask(ctx));
+    tcg_gen_andi_tl(addr, modify <= 0 ? ofs : base, gva_offset_mask(ctx));
 #ifndef CONFIG_USER_ONLY
     if (!is_phys) {
         tcg_gen_or_tl(addr, addr, space_select(ctx, sp, base));
@@ -1966,13 +1956,11 @@ static bool trans_mfsp(DisasContext *ctx, arg_mfsp *a)
     unsigned rt = a->t;
     unsigned rs = a->sp;
     TCGv_i64 t0 = tcg_temp_new_i64();
-    TCGv_i64 t1 = tcg_temp_new();
 
     load_spr(ctx, t0, rs);
     tcg_gen_shri_i64(t0, t0, 32);
-    tcg_gen_trunc_i64_reg(t1, t0);
 
-    save_gpr(ctx, rt, t1);
+    save_gpr(ctx, rt, t0);
 
     cond_free(&ctx->null_cond);
     return true;
@@ -2029,22 +2017,21 @@ static bool trans_mtsp(DisasContext *ctx, arg_mtsp *a)
 {
     unsigned rr = a->r;
     unsigned rs = a->sp;
-    TCGv_i64 t64;
+    TCGv_i64 tmp;
 
     if (rs >= 5) {
         CHECK_MOST_PRIVILEGED(EXCP_PRIV_REG);
     }
     nullify_over(ctx);
 
-    t64 = tcg_temp_new_i64();
-    tcg_gen_extu_reg_i64(t64, load_gpr(ctx, rr));
-    tcg_gen_shli_i64(t64, t64, 32);
+    tmp = tcg_temp_new_i64();
+    tcg_gen_shli_i64(tmp, load_gpr(ctx, rr), 32);
 
     if (rs >= 4) {
-        tcg_gen_st_i64(t64, tcg_env, offsetof(CPUHPPAState, sr[rs]));
+        tcg_gen_st_i64(tmp, tcg_env, offsetof(CPUHPPAState, sr[rs]));
         ctx->tb_flags &= ~TB_FLAG_SR_SAME;
     } else {
-        tcg_gen_mov_i64(cpu_sr[rs], t64);
+        tcg_gen_mov_i64(cpu_sr[rs], tmp);
     }
 
     return nullify_end(ctx);
@@ -2135,11 +2122,8 @@ static bool trans_ldsid(DisasContext *ctx, arg_ldsid *a)
     /* We don't implement space registers in user mode. */
     tcg_gen_movi_i64(dest, 0);
 #else
-    TCGv_i64 t0 = tcg_temp_new_i64();
-
-    tcg_gen_mov_i64(t0, space_select(ctx, a->sp, load_gpr(ctx, a->b)));
-    tcg_gen_shri_i64(t0, t0, 32);
-    tcg_gen_trunc_i64_reg(dest, t0);
+    tcg_gen_mov_i64(dest, space_select(ctx, a->sp, load_gpr(ctx, a->b)));
+    tcg_gen_shri_i64(dest, dest, 32);
 #endif
     save_gpr(ctx, a->t, dest);
 
@@ -3188,10 +3172,8 @@ static bool trans_shrp_sar(DisasContext *ctx, arg_shrp_sar *a)
             TCGv_i64 s = tcg_temp_new_i64();
 
             tcg_gen_concat32_i64(t, src2, src1);
-            tcg_gen_extu_reg_i64(s, cpu_sar);
-            tcg_gen_andi_i64(s, s, 31);
-            tcg_gen_shr_i64(t, t, s);
-            tcg_gen_trunc_i64_reg(dest, t);
+            tcg_gen_andi_i64(s, cpu_sar, 31);
+            tcg_gen_shr_i64(dest, t, s);
         }
     }
     save_gpr(ctx, a->t, dest);
@@ -3233,10 +3215,8 @@ static bool trans_shrp_imm(DisasContext *ctx, arg_shrp_imm *a)
             tcg_gen_rotri_i32(t32, t32, sa);
             tcg_gen_extu_i32_i64(dest, t32);
         } else {
-            TCGv_i64 t64 = tcg_temp_new_i64();
-            tcg_gen_concat32_i64(t64, t2, cpu_gr[a->r1]);
-            tcg_gen_shri_i64(t64, t64, sa);
-            tcg_gen_trunc_i64_reg(dest, t64);
+            tcg_gen_concat32_i64(dest, t2, cpu_gr[a->r1]);
+            tcg_gen_extract_i64(dest, dest, sa, 32);
         }
     }
     save_gpr(ctx, a->t, dest);
-- 
2.34.1


