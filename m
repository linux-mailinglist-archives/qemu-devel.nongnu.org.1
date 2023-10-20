Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 560C67D1799
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:54:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwP4-00023b-Pt; Fri, 20 Oct 2023 16:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwP2-00022P-NT
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:28 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwP0-0001Dt-TU
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:28 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6b6f4c118b7so1182084b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834845; x=1698439645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7SjukT8MkZFkJ3ExB67ZCgDVB5vB1uA1Vxc0UPcY5M=;
 b=Wd6zEQjK9XYvKTmVQHYP47ko5V4Q9dwE1ExYNtRAkjhw2pihaFgqllh8WzVfFjtTxO
 A3P3y9vAcPfVF4qZX+DyT20Kfgsyczcjvzl1h+W6DJ0WoSctsvhhgbLo4FPEm4XBW3TA
 EapbZfNoJZivVy3lV1LByH1byScJH65Q7GLZOYGO8vE1W1bqYAMwiBmbKedtW7TI2hiR
 23RLKvLSmuGqldf36TgjllJxpi8rGzw095S4pJKy0b4LhqrhBpZvwgATE9RG6n1sKZmV
 63J2Sl2IDJEsCl8xNO0ivLSTv0vmn1+Or8PS17RgFpf3YAsiWRe5WLTNt0DYyibS7S23
 bxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834845; x=1698439645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7SjukT8MkZFkJ3ExB67ZCgDVB5vB1uA1Vxc0UPcY5M=;
 b=u/TyQ443f6xTMaImtLBu+Ye2a2nBZSGKHvLdBvK4SgwQXkTYm9q1QR5PQlc6ApcrIu
 NV1/mnJlJsFkqiU7tN9ccIY6nWyqkSO6rbHBXtriQgYD4jmipiM4mhwOgSSQHslxzA1w
 +c/nT4n5ltJM+6JgTq5nsT/OVBzwTKKKvEs+idohvD7jNMkwTaruFv5x9n+ds6fnPFl4
 sbe7N3tbgVsjHt9Cew0/QDrTGOqhae3zQiu84QFNhzKeLEu5rA/R7lmkUDQoBkYMChvx
 wKW0JBGpXzeCmf5HCjV3IZGWtGrr7IsW1x6wA0L6o0VP3jKQGsj1MUdCHDHA2PRzeyf1
 HS+g==
X-Gm-Message-State: AOJu0YwhosRnT4QzIf0z/eDeMi8YW4eOFz88fuI1iTRg4DI6Gg07b5mq
 EtOutKNzAA4JwK6ADjrBMwuqUGI85P5kuOj1ywg=
X-Google-Smtp-Source: AGHT+IFwtF5UxrHInrf5vQ59AXDFyDdf4tB55t/WQlUQj+N5s3TKmVa4M30sJvYW1VNcojuZMtOMFg==
X-Received: by 2002:a05:6a21:66c7:b0:16b:9285:69f5 with SMTP id
 ze7-20020a056a2166c700b0016b928569f5mr2544162pzb.35.1697834845498; 
 Fri, 20 Oct 2023 13:47:25 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1946775pfn.208.2023.10.20.13.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:47:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 60/65] target/hppa: Precompute zero into DisasContext
Date: Fri, 20 Oct 2023 13:43:26 -0700
Message-Id: <20231020204331.139847-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
index a79cf52fcc..9b60924057 100644
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
@@ -4336,6 +4336,8 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->iaoq_n = -1;
     ctx->iaoq_n_var = NULL;
 
+    ctx->zero = tcg_constant_i64(0);
+
     /* Bound the number of instructions by those left on the page.  */
     bound = -(ctx->base.pc_first | TARGET_PAGE_MASK) / 4;
     ctx->base.max_insns = MIN(ctx->base.max_insns, bound);
-- 
2.34.1


