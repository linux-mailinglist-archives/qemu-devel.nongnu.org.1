Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31214783AC3
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:21:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLhO-0007tU-Ap; Tue, 22 Aug 2023 03:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLh9-0007lU-39
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:20:55 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLh5-0004ub-N8
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:20:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31781e15a0cso3755142f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688850; x=1693293650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KnPndFGWPKyJgKZYwj/NrXHvzc48jUGPmLniULjVdE=;
 b=Z7FJhZ/hbFgD6QmuldEiGScPjdAHnYyXgfgfvhMaiEPcqVJeq8EX6D6MnLIydJqx93
 58oTCF2obgytEQ5nzH6e6JIXit9wwvnCn8VpxKqRXdfkRb196mebadAICuQBrWBchqKu
 hxWhXF3ormn6bS8QXdEquZuqx+guuoCxSVcxcufL37pI+ZpJYktNZbTIAd48vZ2ikEAo
 eLfv0tUolZeYb9Xuc+40j8x/YV5M3WyIEd10SYrYVIzSIoA19cP78e03rGTUwDc1Nmjf
 phIcfdr4/+tIB1NlEyLMscVY1Bl1Nj6X1o9MSbnR0ORHbqotbFZzq2ox6djKN0frnwSP
 zdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688850; x=1693293650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+KnPndFGWPKyJgKZYwj/NrXHvzc48jUGPmLniULjVdE=;
 b=eg41vgAQHjeGxbeck3WZz0+tcabE8PiMZfr44VBJOrOEp7chqMgOpypqEcTKoSDCWD
 usRPk+Rx9IftUgpOVgJy+iP/cFNdAbfrbDl74unAIUh7Bg/L6Dwr8EiM9ghZYgbVB1Zo
 5mA/lmizNuGBGyunj6VEEB5NEcqwdB2zGytRB22GQKCncIIo/FbWJPghAaB1duUCCmU9
 YOgHITDEIK2j/mer7O7iBOzodI29KRpKI+YJpfDGuPKuhzOfrwzo1eNyr4UyKMgxmzvF
 CmNBr+UBgzdyTFEhidVIN3YxHR1LtYbad/YxVHGOH4h2tZ0jzoEfHJasZRZ2c8Tu6+dE
 ZsfA==
X-Gm-Message-State: AOJu0Yy8H6CIHbhiIn8PZrhQ4P+kzE6tX78uqMTwxIhqVElgrnx3n1C4
 Ra3RTGkmYJRiz33te+prCbiTBRQp8JeH7Jn/3/nvcQ==
X-Google-Smtp-Source: AGHT+IFk7B0aRNJrKpP65MWq2OMndoKCPwovNvZHP5ZR/3wRWdft6rCYz+lJb0g+defIpUkwRo4a3g==
X-Received: by 2002:a5d:510e:0:b0:31c:5c77:48ec with SMTP id
 s14-20020a5d510e000000b0031c5c7748ecmr2646512wrt.62.1692688849864; 
 Tue, 22 Aug 2023 00:20:49 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 l23-20020a1ced17000000b003fe2de3f94fsm14802811wmh.12.2023.08.22.00.20.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:20:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Jiajie Chen <c@jia.je>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH RESEND v5 15/19] target/loongarch: Add avail_FP/FP_SP/FP_DP to
 check fpu instructions
Date: Tue, 22 Aug 2023 09:19:55 +0200
Message-ID: <20230822071959.35620-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071405.35386-1-philmd@linaro.org>
References: <20230822071405.35386-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Song Gao <gaosong@loongson.cn>

Signed-off-by: Song Gao <gaosong@loongson.cn>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20230822032724.1353391-12-gaosong@loongson.cn>
---
 target/loongarch/translate.h                  |  4 +
 target/loongarch/translate.c                  |  1 +
 .../loongarch/insn_trans/trans_farith.c.inc   | 96 ++++++++++++-------
 target/loongarch/insn_trans/trans_fcmp.c.inc  |  8 ++
 target/loongarch/insn_trans/trans_fcnv.c.inc  | 56 +++++------
 .../loongarch/insn_trans/trans_fmemory.c.inc  | 32 +++----
 target/loongarch/insn_trans/trans_fmov.c.inc  | 48 ++++++++--
 7 files changed, 159 insertions(+), 86 deletions(-)

diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 1342446242..0f244cd83b 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -17,6 +17,9 @@
 #define avail_ALL(C)   true
 #define avail_64(C)    (FIELD_EX32((C)->cpucfg1, CPUCFG1, ARCH) == \
                         CPUCFG1_ARCH_LA64)
+#define avail_FP(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP))
+#define avail_FP_SP(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_SP))
+#define avail_FP_DP(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_DP))
 
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
@@ -40,6 +43,7 @@ typedef struct DisasContext {
     bool la64; /* LoongArch64 mode */
     bool va32; /* 32-bit virtual address */
     uint32_t cpucfg1;
+    uint32_t cpucfg2;
 } DisasContext;
 
 void generate_exception(DisasContext *ctx, int excp);
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 6967e12fc3..fd393ed76d 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -129,6 +129,7 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
     ctx->zero = tcg_constant_tl(0);
 
     ctx->cpucfg1 = env->cpucfg[1];
+    ctx->cpucfg2 = env->cpucfg[2];
 }
 
 static void loongarch_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/loongarch/insn_trans/trans_farith.c.inc b/target/loongarch/insn_trans/trans_farith.c.inc
index b1a1dc7b01..a7ced99fd3 100644
--- a/target/loongarch/insn_trans/trans_farith.c.inc
+++ b/target/loongarch/insn_trans/trans_farith.c.inc
@@ -67,6 +67,10 @@ static bool trans_fcopysign_s(DisasContext *ctx, arg_fcopysign_s *a)
     TCGv src1 = get_fpr(ctx, a->fk);
     TCGv src2 = get_fpr(ctx, a->fj);
 
+    if (!avail_FP_SP(ctx)) {
+        return false;
+    }
+
     CHECK_FPE;
 
     tcg_gen_deposit_i64(dest, src1, src2, 0, 31);
@@ -81,6 +85,10 @@ static bool trans_fcopysign_d(DisasContext *ctx, arg_fcopysign_d *a)
     TCGv src1 = get_fpr(ctx, a->fk);
     TCGv src2 = get_fpr(ctx, a->fj);
 
+    if (!avail_FP_DP(ctx)) {
+        return false;
+    }
+
     CHECK_FPE;
 
     tcg_gen_deposit_i64(dest, src1, src2, 0, 63);
@@ -94,6 +102,10 @@ static bool trans_fabs_s(DisasContext *ctx, arg_fabs_s *a)
     TCGv dest = get_fpr(ctx, a->fd);
     TCGv src = get_fpr(ctx, a->fj);
 
+    if (!avail_FP_SP(ctx)) {
+        return false;
+    }
+
     CHECK_FPE;
 
     tcg_gen_andi_i64(dest, src, MAKE_64BIT_MASK(0, 31));
@@ -108,6 +120,10 @@ static bool trans_fabs_d(DisasContext *ctx, arg_fabs_d *a)
     TCGv dest = get_fpr(ctx, a->fd);
     TCGv src = get_fpr(ctx, a->fj);
 
+    if (!avail_FP_DP(ctx)) {
+        return false;
+    }
+
     CHECK_FPE;
 
     tcg_gen_andi_i64(dest, src, MAKE_64BIT_MASK(0, 63));
@@ -121,6 +137,10 @@ static bool trans_fneg_s(DisasContext *ctx, arg_fneg_s *a)
     TCGv dest = get_fpr(ctx, a->fd);
     TCGv src = get_fpr(ctx, a->fj);
 
+    if (!avail_FP_SP(ctx)) {
+        return false;
+    }
+
     CHECK_FPE;
 
     tcg_gen_xori_i64(dest, src, 0x80000000);
@@ -135,6 +155,10 @@ static bool trans_fneg_d(DisasContext *ctx, arg_fneg_d *a)
     TCGv dest = get_fpr(ctx, a->fd);
     TCGv src = get_fpr(ctx, a->fj);
 
+    if (!avail_FP_DP(ctx)) {
+        return false;
+    }
+
     CHECK_FPE;
 
     tcg_gen_xori_i64(dest, src, 0x8000000000000000LL);
@@ -143,41 +167,41 @@ static bool trans_fneg_d(DisasContext *ctx, arg_fneg_d *a)
     return true;
 }
 
-TRANS(fadd_s, ALL, gen_fff, gen_helper_fadd_s)
-TRANS(fadd_d, ALL, gen_fff, gen_helper_fadd_d)
-TRANS(fsub_s, ALL, gen_fff, gen_helper_fsub_s)
-TRANS(fsub_d, ALL, gen_fff, gen_helper_fsub_d)
-TRANS(fmul_s, ALL, gen_fff, gen_helper_fmul_s)
-TRANS(fmul_d, ALL, gen_fff, gen_helper_fmul_d)
-TRANS(fdiv_s, ALL, gen_fff, gen_helper_fdiv_s)
-TRANS(fdiv_d, ALL, gen_fff, gen_helper_fdiv_d)
-TRANS(fmax_s, ALL, gen_fff, gen_helper_fmax_s)
-TRANS(fmax_d, ALL, gen_fff, gen_helper_fmax_d)
-TRANS(fmin_s, ALL, gen_fff, gen_helper_fmin_s)
-TRANS(fmin_d, ALL, gen_fff, gen_helper_fmin_d)
-TRANS(fmaxa_s, ALL, gen_fff, gen_helper_fmaxa_s)
-TRANS(fmaxa_d, ALL, gen_fff, gen_helper_fmaxa_d)
-TRANS(fmina_s, ALL, gen_fff, gen_helper_fmina_s)
-TRANS(fmina_d, ALL, gen_fff, gen_helper_fmina_d)
-TRANS(fscaleb_s, ALL, gen_fff, gen_helper_fscaleb_s)
-TRANS(fscaleb_d, ALL, gen_fff, gen_helper_fscaleb_d)
-TRANS(fsqrt_s, ALL, gen_ff, gen_helper_fsqrt_s)
-TRANS(fsqrt_d, ALL, gen_ff, gen_helper_fsqrt_d)
-TRANS(frecip_s, ALL, gen_ff, gen_helper_frecip_s)
-TRANS(frecip_d, ALL, gen_ff, gen_helper_frecip_d)
-TRANS(frsqrt_s, ALL, gen_ff, gen_helper_frsqrt_s)
-TRANS(frsqrt_d, ALL, gen_ff, gen_helper_frsqrt_d)
-TRANS(flogb_s, ALL, gen_ff, gen_helper_flogb_s)
-TRANS(flogb_d, ALL, gen_ff, gen_helper_flogb_d)
-TRANS(fclass_s, ALL, gen_ff, gen_helper_fclass_s)
-TRANS(fclass_d, ALL, gen_ff, gen_helper_fclass_d)
-TRANS(fmadd_s, ALL, gen_muladd, gen_helper_fmuladd_s, 0)
-TRANS(fmadd_d, ALL, gen_muladd, gen_helper_fmuladd_d, 0)
-TRANS(fmsub_s, ALL, gen_muladd, gen_helper_fmuladd_s, float_muladd_negate_c)
-TRANS(fmsub_d, ALL, gen_muladd, gen_helper_fmuladd_d, float_muladd_negate_c)
-TRANS(fnmadd_s, ALL, gen_muladd, gen_helper_fmuladd_s, float_muladd_negate_result)
-TRANS(fnmadd_d, ALL, gen_muladd, gen_helper_fmuladd_d, float_muladd_negate_result)
-TRANS(fnmsub_s, ALL, gen_muladd, gen_helper_fmuladd_s,
+TRANS(fadd_s, FP_SP, gen_fff, gen_helper_fadd_s)
+TRANS(fadd_d, FP_DP, gen_fff, gen_helper_fadd_d)
+TRANS(fsub_s, FP_SP, gen_fff, gen_helper_fsub_s)
+TRANS(fsub_d, FP_DP, gen_fff, gen_helper_fsub_d)
+TRANS(fmul_s, FP_SP, gen_fff, gen_helper_fmul_s)
+TRANS(fmul_d, FP_DP, gen_fff, gen_helper_fmul_d)
+TRANS(fdiv_s, FP_SP, gen_fff, gen_helper_fdiv_s)
+TRANS(fdiv_d, FP_DP, gen_fff, gen_helper_fdiv_d)
+TRANS(fmax_s, FP_SP, gen_fff, gen_helper_fmax_s)
+TRANS(fmax_d, FP_DP, gen_fff, gen_helper_fmax_d)
+TRANS(fmin_s, FP_SP, gen_fff, gen_helper_fmin_s)
+TRANS(fmin_d, FP_DP, gen_fff, gen_helper_fmin_d)
+TRANS(fmaxa_s, FP_SP, gen_fff, gen_helper_fmaxa_s)
+TRANS(fmaxa_d, FP_DP, gen_fff, gen_helper_fmaxa_d)
+TRANS(fmina_s, FP_SP, gen_fff, gen_helper_fmina_s)
+TRANS(fmina_d, FP_DP, gen_fff, gen_helper_fmina_d)
+TRANS(fscaleb_s, FP_SP, gen_fff, gen_helper_fscaleb_s)
+TRANS(fscaleb_d, FP_DP, gen_fff, gen_helper_fscaleb_d)
+TRANS(fsqrt_s, FP_SP, gen_ff, gen_helper_fsqrt_s)
+TRANS(fsqrt_d, FP_DP, gen_ff, gen_helper_fsqrt_d)
+TRANS(frecip_s, FP_SP, gen_ff, gen_helper_frecip_s)
+TRANS(frecip_d, FP_DP, gen_ff, gen_helper_frecip_d)
+TRANS(frsqrt_s, FP_SP, gen_ff, gen_helper_frsqrt_s)
+TRANS(frsqrt_d, FP_DP, gen_ff, gen_helper_frsqrt_d)
+TRANS(flogb_s, FP_SP, gen_ff, gen_helper_flogb_s)
+TRANS(flogb_d, FP_DP, gen_ff, gen_helper_flogb_d)
+TRANS(fclass_s, FP_SP, gen_ff, gen_helper_fclass_s)
+TRANS(fclass_d, FP_DP, gen_ff, gen_helper_fclass_d)
+TRANS(fmadd_s, FP_SP, gen_muladd, gen_helper_fmuladd_s, 0)
+TRANS(fmadd_d, FP_DP, gen_muladd, gen_helper_fmuladd_d, 0)
+TRANS(fmsub_s, FP_SP, gen_muladd, gen_helper_fmuladd_s, float_muladd_negate_c)
+TRANS(fmsub_d, FP_DP, gen_muladd, gen_helper_fmuladd_d, float_muladd_negate_c)
+TRANS(fnmadd_s, FP_SP, gen_muladd, gen_helper_fmuladd_s, float_muladd_negate_result)
+TRANS(fnmadd_d, FP_DP, gen_muladd, gen_helper_fmuladd_d, float_muladd_negate_result)
+TRANS(fnmsub_s, FP_SP, gen_muladd, gen_helper_fmuladd_s,
       float_muladd_negate_c | float_muladd_negate_result)
-TRANS(fnmsub_d, ALL, gen_muladd, gen_helper_fmuladd_d,
+TRANS(fnmsub_d, FP_DP, gen_muladd, gen_helper_fmuladd_d,
       float_muladd_negate_c | float_muladd_negate_result)
diff --git a/target/loongarch/insn_trans/trans_fcmp.c.inc b/target/loongarch/insn_trans/trans_fcmp.c.inc
index a78868dbc4..43d5866a67 100644
--- a/target/loongarch/insn_trans/trans_fcmp.c.inc
+++ b/target/loongarch/insn_trans/trans_fcmp.c.inc
@@ -29,6 +29,10 @@ static bool trans_fcmp_cond_s(DisasContext *ctx, arg_fcmp_cond_s *a)
     uint32_t flags;
     void (*fn)(TCGv, TCGv_env, TCGv, TCGv, TCGv_i32);
 
+    if (!avail_FP_SP(ctx)) {
+        return false;
+    }
+
     CHECK_FPE;
 
     var = tcg_temp_new();
@@ -49,6 +53,10 @@ static bool trans_fcmp_cond_d(DisasContext *ctx, arg_fcmp_cond_d *a)
     uint32_t flags;
     void (*fn)(TCGv, TCGv_env, TCGv, TCGv, TCGv_i32);
 
+    if (!avail_FP_DP(ctx)) {
+        return false;
+    }
+
     CHECK_FPE;
 
     var = tcg_temp_new();
diff --git a/target/loongarch/insn_trans/trans_fcnv.c.inc b/target/loongarch/insn_trans/trans_fcnv.c.inc
index 329a2d6872..833c059d6d 100644
--- a/target/loongarch/insn_trans/trans_fcnv.c.inc
+++ b/target/loongarch/insn_trans/trans_fcnv.c.inc
@@ -3,31 +3,31 @@
  * Copyright (c) 2021 Loongson Technology Corporation Limited
  */
 
-TRANS(fcvt_s_d, ALL, gen_ff, gen_helper_fcvt_s_d)
-TRANS(fcvt_d_s, ALL, gen_ff, gen_helper_fcvt_d_s)
-TRANS(ftintrm_w_s, ALL, gen_ff, gen_helper_ftintrm_w_s)
-TRANS(ftintrm_w_d, ALL, gen_ff, gen_helper_ftintrm_w_d)
-TRANS(ftintrm_l_s, ALL, gen_ff, gen_helper_ftintrm_l_s)
-TRANS(ftintrm_l_d, ALL, gen_ff, gen_helper_ftintrm_l_d)
-TRANS(ftintrp_w_s, ALL, gen_ff, gen_helper_ftintrp_w_s)
-TRANS(ftintrp_w_d, ALL, gen_ff, gen_helper_ftintrp_w_d)
-TRANS(ftintrp_l_s, ALL, gen_ff, gen_helper_ftintrp_l_s)
-TRANS(ftintrp_l_d, ALL, gen_ff, gen_helper_ftintrp_l_d)
-TRANS(ftintrz_w_s, ALL, gen_ff, gen_helper_ftintrz_w_s)
-TRANS(ftintrz_w_d, ALL, gen_ff, gen_helper_ftintrz_w_d)
-TRANS(ftintrz_l_s, ALL, gen_ff, gen_helper_ftintrz_l_s)
-TRANS(ftintrz_l_d, ALL, gen_ff, gen_helper_ftintrz_l_d)
-TRANS(ftintrne_w_s, ALL, gen_ff, gen_helper_ftintrne_w_s)
-TRANS(ftintrne_w_d, ALL, gen_ff, gen_helper_ftintrne_w_d)
-TRANS(ftintrne_l_s, ALL, gen_ff, gen_helper_ftintrne_l_s)
-TRANS(ftintrne_l_d, ALL, gen_ff, gen_helper_ftintrne_l_d)
-TRANS(ftint_w_s, ALL, gen_ff, gen_helper_ftint_w_s)
-TRANS(ftint_w_d, ALL, gen_ff, gen_helper_ftint_w_d)
-TRANS(ftint_l_s, ALL, gen_ff, gen_helper_ftint_l_s)
-TRANS(ftint_l_d, ALL, gen_ff, gen_helper_ftint_l_d)
-TRANS(ffint_s_w, ALL, gen_ff, gen_helper_ffint_s_w)
-TRANS(ffint_s_l, ALL, gen_ff, gen_helper_ffint_s_l)
-TRANS(ffint_d_w, ALL, gen_ff, gen_helper_ffint_d_w)
-TRANS(ffint_d_l, ALL, gen_ff, gen_helper_ffint_d_l)
-TRANS(frint_s, ALL, gen_ff, gen_helper_frint_s)
-TRANS(frint_d, ALL, gen_ff, gen_helper_frint_d)
+TRANS(fcvt_s_d, FP_DP, gen_ff, gen_helper_fcvt_s_d)
+TRANS(fcvt_d_s, FP_DP, gen_ff, gen_helper_fcvt_d_s)
+TRANS(ftintrm_w_s, FP_SP, gen_ff, gen_helper_ftintrm_w_s)
+TRANS(ftintrm_w_d, FP_DP, gen_ff, gen_helper_ftintrm_w_d)
+TRANS(ftintrm_l_s, FP_SP, gen_ff, gen_helper_ftintrm_l_s)
+TRANS(ftintrm_l_d, FP_DP, gen_ff, gen_helper_ftintrm_l_d)
+TRANS(ftintrp_w_s, FP_SP, gen_ff, gen_helper_ftintrp_w_s)
+TRANS(ftintrp_w_d, FP_DP, gen_ff, gen_helper_ftintrp_w_d)
+TRANS(ftintrp_l_s, FP_SP, gen_ff, gen_helper_ftintrp_l_s)
+TRANS(ftintrp_l_d, FP_DP, gen_ff, gen_helper_ftintrp_l_d)
+TRANS(ftintrz_w_s, FP_SP, gen_ff, gen_helper_ftintrz_w_s)
+TRANS(ftintrz_w_d, FP_DP, gen_ff, gen_helper_ftintrz_w_d)
+TRANS(ftintrz_l_s, FP_SP, gen_ff, gen_helper_ftintrz_l_s)
+TRANS(ftintrz_l_d, FP_DP, gen_ff, gen_helper_ftintrz_l_d)
+TRANS(ftintrne_w_s, FP_SP, gen_ff, gen_helper_ftintrne_w_s)
+TRANS(ftintrne_w_d, FP_DP, gen_ff, gen_helper_ftintrne_w_d)
+TRANS(ftintrne_l_s, FP_SP, gen_ff, gen_helper_ftintrne_l_s)
+TRANS(ftintrne_l_d, FP_DP, gen_ff, gen_helper_ftintrne_l_d)
+TRANS(ftint_w_s, FP_SP, gen_ff, gen_helper_ftint_w_s)
+TRANS(ftint_w_d, FP_DP, gen_ff, gen_helper_ftint_w_d)
+TRANS(ftint_l_s, FP_SP, gen_ff, gen_helper_ftint_l_s)
+TRANS(ftint_l_d, FP_DP, gen_ff, gen_helper_ftint_l_d)
+TRANS(ffint_s_w, FP_SP, gen_ff, gen_helper_ffint_s_w)
+TRANS(ffint_s_l, FP_SP, gen_ff, gen_helper_ffint_s_l)
+TRANS(ffint_d_w, FP_DP, gen_ff, gen_helper_ffint_d_w)
+TRANS(ffint_d_l, FP_DP, gen_ff, gen_helper_ffint_d_l)
+TRANS(frint_s, FP_SP, gen_ff, gen_helper_frint_s)
+TRANS(frint_d, FP_DP, gen_ff, gen_helper_frint_d)
diff --git a/target/loongarch/insn_trans/trans_fmemory.c.inc b/target/loongarch/insn_trans/trans_fmemory.c.inc
index 8e3b4522c9..5ddb8a473b 100644
--- a/target/loongarch/insn_trans/trans_fmemory.c.inc
+++ b/target/loongarch/insn_trans/trans_fmemory.c.inc
@@ -140,19 +140,19 @@ static bool gen_fstore_le(DisasContext *ctx, arg_frr *a, MemOp mop)
     return true;
 }
 
-TRANS(fld_s, ALL, gen_fload_i, MO_TEUL)
-TRANS(fst_s, ALL, gen_fstore_i, MO_TEUL)
-TRANS(fld_d, ALL, gen_fload_i, MO_TEUQ)
-TRANS(fst_d, ALL, gen_fstore_i, MO_TEUQ)
-TRANS(fldx_s, ALL, gen_floadx, MO_TEUL)
-TRANS(fldx_d, ALL, gen_floadx, MO_TEUQ)
-TRANS(fstx_s, ALL, gen_fstorex, MO_TEUL)
-TRANS(fstx_d, ALL, gen_fstorex, MO_TEUQ)
-TRANS(fldgt_s, ALL, gen_fload_gt, MO_TEUL)
-TRANS(fldgt_d, ALL, gen_fload_gt, MO_TEUQ)
-TRANS(fldle_s, ALL, gen_fload_le, MO_TEUL)
-TRANS(fldle_d, ALL, gen_fload_le, MO_TEUQ)
-TRANS(fstgt_s, ALL, gen_fstore_gt, MO_TEUL)
-TRANS(fstgt_d, ALL, gen_fstore_gt, MO_TEUQ)
-TRANS(fstle_s, ALL, gen_fstore_le, MO_TEUL)
-TRANS(fstle_d, ALL, gen_fstore_le, MO_TEUQ)
+TRANS(fld_s, FP_SP, gen_fload_i, MO_TEUL)
+TRANS(fst_s, FP_SP, gen_fstore_i, MO_TEUL)
+TRANS(fld_d, FP_DP, gen_fload_i, MO_TEUQ)
+TRANS(fst_d, FP_DP, gen_fstore_i, MO_TEUQ)
+TRANS(fldx_s, FP_SP, gen_floadx, MO_TEUL)
+TRANS(fldx_d, FP_DP, gen_floadx, MO_TEUQ)
+TRANS(fstx_s, FP_SP, gen_fstorex, MO_TEUL)
+TRANS(fstx_d, FP_DP, gen_fstorex, MO_TEUQ)
+TRANS(fldgt_s, FP_SP, gen_fload_gt, MO_TEUL)
+TRANS(fldgt_d, FP_DP, gen_fload_gt, MO_TEUQ)
+TRANS(fldle_s, FP_SP, gen_fload_le, MO_TEUL)
+TRANS(fldle_d, FP_DP, gen_fload_le, MO_TEUQ)
+TRANS(fstgt_s, FP_SP, gen_fstore_gt, MO_TEUL)
+TRANS(fstgt_d, FP_DP, gen_fstore_gt, MO_TEUQ)
+TRANS(fstle_s, FP_SP, gen_fstore_le, MO_TEUL)
+TRANS(fstle_d, FP_DP, gen_fstore_le, MO_TEUQ)
diff --git a/target/loongarch/insn_trans/trans_fmov.c.inc b/target/loongarch/insn_trans/trans_fmov.c.inc
index 385bbb7929..928e127820 100644
--- a/target/loongarch/insn_trans/trans_fmov.c.inc
+++ b/target/loongarch/insn_trans/trans_fmov.c.inc
@@ -15,6 +15,10 @@ static bool trans_fsel(DisasContext *ctx, arg_fsel *a)
     TCGv src2 = get_fpr(ctx, a->fk);
     TCGv cond;
 
+    if (!avail_FP(ctx)) {
+        return false;
+    }
+
     CHECK_FPE;
 
     cond = tcg_temp_new();
@@ -48,6 +52,10 @@ static bool gen_r2f(DisasContext *ctx, arg_fr *a,
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv dest = get_fpr(ctx, a->fd);
 
+    if (!avail_FP(ctx)) {
+        return false;
+    }
+
     CHECK_FPE;
 
     func(dest, src);
@@ -62,6 +70,10 @@ static bool gen_f2r(DisasContext *ctx, arg_rf *a,
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src = get_fpr(ctx, a->fj);
 
+    if (!avail_FP(ctx)) {
+        return false;
+    }
+
     CHECK_FPE;
 
     func(dest, src);
@@ -75,6 +87,10 @@ static bool trans_movgr2fcsr(DisasContext *ctx, arg_movgr2fcsr *a)
     uint32_t mask = fcsr_mask[a->fcsrd];
     TCGv Rj = gpr_src(ctx, a->rj, EXT_NONE);
 
+    if (!avail_FP(ctx)) {
+        return false;
+    }
+
     CHECK_FPE;
 
     if (mask == UINT32_MAX) {
@@ -105,6 +121,10 @@ static bool trans_movfcsr2gr(DisasContext *ctx, arg_movfcsr2gr *a)
 {
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
 
+    if (!avail_FP(ctx)) {
+        return false;
+    }
+
     CHECK_FPE;
 
     tcg_gen_ld32u_i64(dest, cpu_env, offsetof(CPULoongArchState, fcsr0));
@@ -134,6 +154,10 @@ static bool trans_movfr2cf(DisasContext *ctx, arg_movfr2cf *a)
     TCGv t0;
     TCGv src = get_fpr(ctx, a->fj);
 
+    if (!avail_FP(ctx)) {
+        return false;
+    }
+
     CHECK_FPE;
 
     t0 = tcg_temp_new();
@@ -147,6 +171,10 @@ static bool trans_movcf2fr(DisasContext *ctx, arg_movcf2fr *a)
 {
     TCGv dest = get_fpr(ctx, a->fd);
 
+    if (!avail_FP(ctx)) {
+        return false;
+    }
+
     CHECK_FPE;
 
     tcg_gen_ld8u_tl(dest, cpu_env,
@@ -160,6 +188,10 @@ static bool trans_movgr2cf(DisasContext *ctx, arg_movgr2cf *a)
 {
     TCGv t0;
 
+    if (!avail_FP(ctx)) {
+        return false;
+    }
+
     CHECK_FPE;
 
     t0 = tcg_temp_new();
@@ -171,6 +203,10 @@ static bool trans_movgr2cf(DisasContext *ctx, arg_movgr2cf *a)
 
 static bool trans_movcf2gr(DisasContext *ctx, arg_movcf2gr *a)
 {
+    if (!avail_FP(ctx)) {
+        return false;
+    }
+
     CHECK_FPE;
 
     tcg_gen_ld8u_tl(gpr_dst(ctx, a->rd, EXT_NONE), cpu_env,
@@ -178,11 +214,11 @@ static bool trans_movcf2gr(DisasContext *ctx, arg_movcf2gr *a)
     return true;
 }
 
-TRANS(fmov_s, ALL, gen_f2f, tcg_gen_mov_tl, true)
-TRANS(fmov_d, ALL, gen_f2f, tcg_gen_mov_tl, false)
-TRANS(movgr2fr_w, ALL, gen_r2f, gen_movgr2fr_w)
+TRANS(fmov_s, FP_SP, gen_f2f, tcg_gen_mov_tl, true)
+TRANS(fmov_d, FP_DP, gen_f2f, tcg_gen_mov_tl, false)
+TRANS(movgr2fr_w, FP_SP, gen_r2f, gen_movgr2fr_w)
 TRANS(movgr2fr_d, 64, gen_r2f, tcg_gen_mov_tl)
-TRANS(movgr2frh_w, ALL, gen_r2f, gen_movgr2frh_w)
-TRANS(movfr2gr_s, ALL, gen_f2r, tcg_gen_ext32s_tl)
+TRANS(movgr2frh_w, FP_DP, gen_r2f, gen_movgr2frh_w)
+TRANS(movfr2gr_s, FP_SP, gen_f2r, tcg_gen_ext32s_tl)
 TRANS(movfr2gr_d, 64, gen_f2r, tcg_gen_mov_tl)
-TRANS(movfrh2gr_s, ALL, gen_f2r, gen_movfrh2gr_s)
+TRANS(movfrh2gr_s, FP_DP, gen_f2r, gen_movfrh2gr_s)
-- 
2.41.0


