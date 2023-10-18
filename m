Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAA67CEA80
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:59:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEVo-0002MU-MS; Wed, 18 Oct 2023 17:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVm-0002Iu-Io
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:30 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVk-00058X-Nm
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:30 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-581d487f8dbso1242613eaf.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697666127; x=1698270927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tHP2tYsmSSxOo6HHRVeOWeqkS383GwwwAeL+hfFxJSs=;
 b=ImD/qiw1YiELKJwJKwCrLZIkYq6QrIrPe5y0ePplAmsnAHgS5/512p59Hd+f9Y0KYI
 IRwUQTiQDZwpSWFL5z9H3+qqCLTd7s3WfZKbxsx3hu4dThAmxGYNXNyJHT7wVsZzBYtN
 5YrsmX86t2lxLOXVzdzQ02Wt6nsICzmn3V5XsUJ7uGm8yLSd8r5wUyRSltYSh9aMkrmk
 3LN0jKT5OffVj7ERbBrnmgknYLXpEYQjOFPVpiLZ8YOwNNMotN5jkRbijc+9nwtb7p2B
 a0s4xiCOtJyLBEiIeA0cQJb4QoEHAqGuHOHwG7gJ4g3OSYxqNqvi6Ks7z8eRQZUT+T91
 eODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697666127; x=1698270927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tHP2tYsmSSxOo6HHRVeOWeqkS383GwwwAeL+hfFxJSs=;
 b=blWhCRPx+axkYUK+7jvcv6L+959e0lPS+Z3j1DIwwXPDphkUPxsdCJ7IzEag9PDBMG
 mCHTTOCQv+6rQZotkAPPW8/jHSKiJxdNTEl16Nnt3DMlUEUrpYw0JKy1EsR4brvDOjjG
 r5125NY4SudAsV3ptIkymOMmFuhdWcxaGvdusNkJHKzFatFquPl1ra5XvC03CLeYYFOx
 FM0KuE1grcSlYhkrKICHHRGaGWop1tWKgWprW2SWVxtvFBSwseFre49mhJNGSZdNpVQa
 5+7sb7w6p6ONdXTThVDg3H37N0nkug/+ytKR6F47JjZEthkOAuVc9lE6EHzoHyipSznF
 NjWw==
X-Gm-Message-State: AOJu0YzpuWP+pDmszCrkAVvRgJSByIhCqF+D1TsHeGx5/LI4AssYZ/5p
 /gGh52B7eWlNETrYPjYwjvaT7gtFDdv8hsFRNfA=
X-Google-Smtp-Source: AGHT+IHegTZe4RKPlhcCgZWirONfshWbK/imB1KbIqCDBehCWd9qYQvbYfhDYs9Sx4YJOXqFl+YYZg==
X-Received: by 2002:a05:6358:190f:b0:150:8ba9:4d with SMTP id
 w15-20020a056358190f00b001508ba9004dmr320605rwm.3.1697666127581; 
 Wed, 18 Oct 2023 14:55:27 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r15-20020aa7962f000000b006889348ba6esm3796263pfg.127.2023.10.18.14.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:55:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 59/61] target/hppa: Precompute zero into DisasContext
Date: Wed, 18 Oct 2023 14:51:33 -0700
Message-Id: <20231018215135.1561375-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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

Reduce the number of times we look for the constant 0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 40b5a3d8c3..9a9876c529 100644
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
@@ -1004,14 +1006,13 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
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
@@ -1089,7 +1090,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
                    TCGv_i64 in2, bool is_tsv, bool is_b,
                    bool is_tc, unsigned cf, bool d)
 {
-    TCGv_i64 dest, sv, cb, cb_msb, zero, tmp;
+    TCGv_i64 dest, sv, cb, cb_msb, tmp;
     unsigned c = cf >> 1;
     DisasCond cond;
 
@@ -1097,12 +1098,12 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
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
@@ -1111,7 +1112,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
          * operations by seeding the high word with 1 and subtracting.
          */
         TCGv_i64 one = tcg_constant_i64(1);
-        tcg_gen_sub2_i64(dest, cb_msb, in1, one, in2, zero);
+        tcg_gen_sub2_i64(dest, cb_msb, in1, one, in2, ctx->zero);
         tcg_gen_eqv_i64(cb, in1, in2);
         tcg_gen_xor_i64(cb, cb, dest);
     }
@@ -2430,7 +2431,7 @@ static bool trans_lci(DisasContext *ctx, arg_lci *a)
        physical address.  Two addresses with the same CI have a coherent
        view of the cache.  Our implementation is to return 0 for all,
        since the entire address space is coherent.  */
-    save_gpr(ctx, a->t, tcg_constant_i64(0));
+    save_gpr(ctx, a->t, ctx->zero);
 
     cond_free(&ctx->null_cond);
     return true;
@@ -2639,7 +2640,7 @@ static bool trans_dcor_i(DisasContext *ctx, arg_rr_cf_d *a)
 
 static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
 {
-    TCGv_i64 dest, add1, add2, addc, zero, in1, in2;
+    TCGv_i64 dest, add1, add2, addc, in1, in2;
     TCGv_i64 cout;
 
     nullify_over(ctx);
@@ -2651,7 +2652,6 @@ static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
     add2 = tcg_temp_new_i64();
     addc = tcg_temp_new_i64();
     dest = tcg_temp_new_i64();
-    zero = tcg_constant_i64(0);
 
     /* Form R1 << 1 | PSW[CB]{8}.  */
     tcg_gen_add_i64(add1, in1, in1);
@@ -2667,8 +2667,9 @@ static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
     tcg_gen_xor_i64(add2, in2, addc);
     tcg_gen_andi_i64(addc, addc, 1);
 
-    tcg_gen_add2_i64(dest, cpu_psw_cb_msb, add1, zero, add2, zero);
-    tcg_gen_add2_i64(dest, cpu_psw_cb_msb, dest, cpu_psw_cb_msb, addc, zero);
+    tcg_gen_add2_i64(dest, cpu_psw_cb_msb, add1, ctx->zero, add2, ctx->zero);
+    tcg_gen_add2_i64(dest, cpu_psw_cb_msb, dest, cpu_psw_cb_msb,
+                     addc, ctx->zero);
 
     /* Write back the result register.  */
     save_gpr(ctx, a->t, dest);
@@ -2968,7 +2969,7 @@ static bool trans_st(DisasContext *ctx, arg_ldst *a)
 static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
 {
     MemOp mop = MO_TE | MO_ALIGN | a->size;
-    TCGv_i64 zero, dest, ofs;
+    TCGv_i64 dest, ofs;
     TCGv_i64 addr;
 
     if (!ctx->is_pa20 && a->size > MO_32) {
@@ -2998,8 +2999,7 @@ static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
      */
     gen_helper_ldc_check(addr);
 
-    zero = tcg_constant_i64(0);
-    tcg_gen_atomic_xchg_i64(dest, addr, zero, ctx->mmu_idx, mop);
+    tcg_gen_atomic_xchg_i64(dest, addr, ctx->zero, ctx->mmu_idx, mop);
 
     if (a->m) {
         save_gpr(ctx, a->b, ofs);
@@ -4337,6 +4337,8 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->iaoq_n = -1;
     ctx->iaoq_n_var = NULL;
 
+    ctx->zero = tcg_constant_i64(0);
+
     /* Bound the number of instructions by those left on the page.  */
     bound = -(ctx->base.pc_first | TARGET_PAGE_MASK) / 4;
     ctx->base.max_insns = MIN(ctx->base.max_insns, bound);
-- 
2.34.1


