Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A667DEA3A
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:40:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMbs-000740-1z; Wed, 01 Nov 2023 21:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMb8-0006Y1-Oa
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:15 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMb4-0001xt-30
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:14 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cc3c51f830so3277785ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888849; x=1699493649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C5PbIDheBSeiqmcNlYHSK8nvmVpp5+OaGBYstVJp+mo=;
 b=NjQ/UaElKKA6vpNqXx/NCjum/5CUIHxr6ZYWV/SbS7v7QGIW8cl/gMFkGHegN0eRhp
 frcZCPDGD9nQY5RRAbQqtnJN9W3L5C+IxE5MxcoPGvYiwOvK8QyCsQgt2ZT5X7kmW46a
 b3Wo6+NOs9IuEQx9j4OZnFPMmSASnPyccPvIOLZOoSfh/7a3oo8CBcL5BFJnvX+vfj7d
 +IiMSX2asDhe7bXkQeEecj6/1UYdPkI+I/6vftMA0hVXTwA6ysa269z4RlQ6x7CTb7Nk
 UDRYPdRm2Mpb4I1whcd3nnk76I4LWWRjmmjYo5TsXZjlwbuC/VStMSGSGGJcjfvpaVAG
 YFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888849; x=1699493649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C5PbIDheBSeiqmcNlYHSK8nvmVpp5+OaGBYstVJp+mo=;
 b=co7F4zLLJnmnxer5cNJ+ILVLCfU2gRWxpgZqwekTb0Zh+WdK+UokKNV1LfQvUmw6hW
 y5uZsffL6AI9fstInSjO2c2CBJwY1OTpH4xc+YhbHQuXoz7cM2NxaNnqr3SoKS5FvrUs
 iIvGkdCpUUXjIpYNzB/PVsExFwb3BmGTWsbwi6TjfxsFviFFQ5tTwWr5ttH2cNqM5Tt3
 yFE0+mRzSc4wqnMnA4+WQLkFYbSZl1VqhHfnRtqVPw2VwKlUDOfDoVaDLZGtxd/vUzII
 Vn9yJ4QC21MoKX8/whbIksONY6NCrMZewQJKxezTNSx4noSxtViMH6KQc7aHh6tDaq3Q
 ikMA==
X-Gm-Message-State: AOJu0Yznd55E4CxVQ0AtB+egrYrAGS2290rMUwJJ6Ya+Kff6OQ3Hlhy+
 tCGlR1pPJjPqh8XFfR+Tgryn6tbywvfdcboE/LI=
X-Google-Smtp-Source: AGHT+IFgPatYsS4vIIcqWsI7U1qcuFmAa6dhJnTFS/Le4zoLYbBGzmIova6JarBRolQPY8itygreqw==
X-Received: by 2002:a17:902:e494:b0:1c9:d948:33d5 with SMTP id
 i20-20020a170902e49400b001c9d94833d5mr10744123ple.64.1698888848770; 
 Wed, 01 Nov 2023 18:34:08 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 59/88] target/hppa: Remove remaining TARGET_REGISTER_BITS
 redirections
Date: Wed,  1 Nov 2023 18:29:47 -0700
Message-Id: <20231102013016.369010-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
index 520a375e3a..ce8d812e04 100644
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
 
@@ -3185,10 +3169,8 @@ static bool trans_shrp_sar(DisasContext *ctx, arg_shrp_sar *a)
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
@@ -3230,10 +3212,8 @@ static bool trans_shrp_imm(DisasContext *ctx, arg_shrp_imm *a)
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


