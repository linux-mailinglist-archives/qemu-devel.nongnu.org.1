Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 724C37E3412
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:16:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRx-0005tE-Mk; Mon, 06 Nov 2023 22:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRi-00058g-PE
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:07 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRd-0001Qk-VX
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:06 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5bd099e3d3cso3285610a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326480; x=1699931280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UfFXEHPeBlW2V+aws/3IUtgVl463NxLI7ZbA2FGNb/Q=;
 b=INwRd8p0VV/XM5UMB8QKQ6/nVg2sy2P9ozOPb2OiX5vuRnXAWEU1V2ajnMxXtgOJ5F
 R5+PzjtZUV9ObrffdVx/k/wC10LeFqTJyycRr3ry14wKKoRsaC0keWYzmgtXcztTqmGF
 QmCKmz8AQEXC5GzPFi+ze+IZa66YdAQpRQrVX4fZ1t2KtEUL0JVqwlh+CNK4mZT0Vcjw
 ZJjCfThhqOJ+mM9vydN4Is2IU0/7KJxe+MkkMWuYsk1fhc33zxZjdLTGVCC8TGmQcjgd
 pMh9dacLnGpVelnVg60PB4KNHuUhmr0yw9gkgSxja3qVEAkr9c2yoSKKT8weZ13/Lktj
 qxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326480; x=1699931280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UfFXEHPeBlW2V+aws/3IUtgVl463NxLI7ZbA2FGNb/Q=;
 b=lN/rM5Z0hdNwCB0jBdI3uK269UFlFS8Zh72+ETGiNdGr9T2ffXuiQpDscbi67iW8Y7
 ZYIFrOUmcTbqz5+vn+mS5DjJar4g8aq2vG3O7TFCGCbsidF8g+DfTqvg9XMTySWJsTAD
 L90zd46tDalP3O47zMDvNi3HjWzefiu8qULIADn63Ip2ye/b+bz43I7jB9Ix98oxiFPI
 3vO6lyiF5g3ass7U7uhlv9MhUqFkdnpXVP7atSB6ZX5m9w9YaEJz6y17aKxePV6umwqQ
 1gpkmRfKJEDyckjlB7TBX28byxnyGkF9c6wGLh/20weoVVyR9O0SH87GhUIFqT8NoqTx
 BW+Q==
X-Gm-Message-State: AOJu0YxFrfPa5FEzcuDcphkbUF+sgDXl9SjilnIOXqhFjdSe3J3T86Rf
 kWOtvOtM4QSvF1qteuqHhQIsbP+efkB+uIIveq8=
X-Google-Smtp-Source: AGHT+IHwXwF/Qo1mUn6/1asaJcIyCY7g9iqndCRvHRinrW8GQjQqBl8+eaC8rjmZT165aQGppC0irw==
X-Received: by 2002:a17:90b:3746:b0:280:c85d:450 with SMTP id
 ne6-20020a17090b374600b00280c85d0450mr12054581pjb.44.1699326480181; 
 Mon, 06 Nov 2023 19:08:00 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 69/85] target/hppa: Precompute zero into DisasContext
Date: Mon,  6 Nov 2023 19:03:51 -0800
Message-Id: <20231107030407.8979-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Reduce the number of times we look for the constant 0.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ffdd306d31..b04a5bc444 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -53,6 +53,8 @@ typedef struct DisasContext {
     DisasCond null_cond;
     TCGLabel *null_lab;
 
+    TCGv_i64 zero;
+
     uint32_t insn;
     uint32_t tb_flags;
     int mmu_idx;
@@ -1017,14 +1019,13 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     }
 
     if (!is_l || cond_need_cb(c)) {
-        TCGv_i64 zero = tcg_constant_i64(0);
         cb_msb = tcg_temp_new_i64();
         cb = tcg_temp_new_i64();
 
-        tcg_gen_add2_i64(dest, cb_msb, in1, zero, in2, zero);
+        tcg_gen_add2_i64(dest, cb_msb, in1, ctx->zero, in2, ctx->zero);
         if (is_c) {
             tcg_gen_add2_i64(dest, cb_msb, dest, cb_msb,
-                             get_psw_carry(ctx, d), zero);
+                             get_psw_carry(ctx, d), ctx->zero);
         }
         tcg_gen_xor_i64(cb, in1, in2);
         tcg_gen_xor_i64(cb, cb, dest);
@@ -1102,7 +1103,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
                    TCGv_i64 in2, bool is_tsv, bool is_b,
                    bool is_tc, unsigned cf, bool d)
 {
-    TCGv_i64 dest, sv, cb, cb_msb, zero, tmp;
+    TCGv_i64 dest, sv, cb, cb_msb, tmp;
     unsigned c = cf >> 1;
     DisasCond cond;
 
@@ -1110,12 +1111,12 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     cb = tcg_temp_new_i64();
     cb_msb = tcg_temp_new_i64();
 
-    zero = tcg_constant_i64(0);
     if (is_b) {
         /* DEST,C = IN1 + ~IN2 + C.  */
         tcg_gen_not_i64(cb, in2);
-        tcg_gen_add2_i64(dest, cb_msb, in1, zero, get_psw_carry(ctx, d), zero);
-        tcg_gen_add2_i64(dest, cb_msb, dest, cb_msb, cb, zero);
+        tcg_gen_add2_i64(dest, cb_msb, in1, ctx->zero,
+                         get_psw_carry(ctx, d), ctx->zero);
+        tcg_gen_add2_i64(dest, cb_msb, dest, cb_msb, cb, ctx->zero);
         tcg_gen_xor_i64(cb, cb, in1);
         tcg_gen_xor_i64(cb, cb, dest);
     } else {
@@ -1124,7 +1125,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
          * operations by seeding the high word with 1 and subtracting.
          */
         TCGv_i64 one = tcg_constant_i64(1);
-        tcg_gen_sub2_i64(dest, cb_msb, in1, one, in2, zero);
+        tcg_gen_sub2_i64(dest, cb_msb, in1, one, in2, ctx->zero);
         tcg_gen_eqv_i64(cb, in1, in2);
         tcg_gen_xor_i64(cb, cb, dest);
     }
@@ -2458,7 +2459,7 @@ static bool trans_lci(DisasContext *ctx, arg_lci *a)
        physical address.  Two addresses with the same CI have a coherent
        view of the cache.  Our implementation is to return 0 for all,
        since the entire address space is coherent.  */
-    save_gpr(ctx, a->t, tcg_constant_i64(0));
+    save_gpr(ctx, a->t, ctx->zero);
 
     cond_free(&ctx->null_cond);
     return true;
@@ -2667,7 +2668,7 @@ static bool trans_dcor_i(DisasContext *ctx, arg_rr_cf_d *a)
 
 static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
 {
-    TCGv_i64 dest, add1, add2, addc, zero, in1, in2;
+    TCGv_i64 dest, add1, add2, addc, in1, in2;
     TCGv_i64 cout;
 
     nullify_over(ctx);
@@ -2679,7 +2680,6 @@ static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
     add2 = tcg_temp_new_i64();
     addc = tcg_temp_new_i64();
     dest = tcg_temp_new_i64();
-    zero = tcg_constant_i64(0);
 
     /* Form R1 << 1 | PSW[CB]{8}.  */
     tcg_gen_add_i64(add1, in1, in1);
@@ -2695,8 +2695,9 @@ static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
     tcg_gen_xor_i64(add2, in2, addc);
     tcg_gen_andi_i64(addc, addc, 1);
 
-    tcg_gen_add2_i64(dest, cpu_psw_cb_msb, add1, zero, add2, zero);
-    tcg_gen_add2_i64(dest, cpu_psw_cb_msb, dest, cpu_psw_cb_msb, addc, zero);
+    tcg_gen_add2_i64(dest, cpu_psw_cb_msb, add1, ctx->zero, add2, ctx->zero);
+    tcg_gen_add2_i64(dest, cpu_psw_cb_msb, dest, cpu_psw_cb_msb,
+                     addc, ctx->zero);
 
     /* Write back the result register.  */
     save_gpr(ctx, a->t, dest);
@@ -2996,7 +2997,7 @@ static bool trans_st(DisasContext *ctx, arg_ldst *a)
 static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
 {
     MemOp mop = MO_TE | MO_ALIGN | a->size;
-    TCGv_i64 zero, dest, ofs;
+    TCGv_i64 dest, ofs;
     TCGv_i64 addr;
 
     if (!ctx->is_pa20 && a->size > MO_32) {
@@ -3026,8 +3027,7 @@ static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
      */
     gen_helper_ldc_check(addr);
 
-    zero = tcg_constant_i64(0);
-    tcg_gen_atomic_xchg_i64(dest, addr, zero, ctx->mmu_idx, mop);
+    tcg_gen_atomic_xchg_i64(dest, addr, ctx->zero, ctx->mmu_idx, mop);
 
     if (a->m) {
         save_gpr(ctx, a->b, ofs);
@@ -4383,6 +4383,8 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->iaoq_n = -1;
     ctx->iaoq_n_var = NULL;
 
+    ctx->zero = tcg_constant_i64(0);
+
     /* Bound the number of instructions by those left on the page.  */
     bound = -(ctx->base.pc_first | TARGET_PAGE_MASK) / 4;
     ctx->base.max_insns = MIN(ctx->base.max_insns, bound);
-- 
2.34.1


