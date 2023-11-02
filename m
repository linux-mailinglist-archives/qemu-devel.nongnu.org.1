Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9357DEA5B
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:46:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMbu-000786-On; Wed, 01 Nov 2023 21:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbG-0006cU-LK
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:23 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbD-00027m-DR
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:21 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c9b95943beso3341945ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888858; x=1699493658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ifv9SSAPN+ChQ5diIn47KGLE/FuvesYppuuoVucSBEM=;
 b=pMclFrQqUFyyXU2qAFI6YHiX8UsUUdFkSYA/qP1zaXey5NjZb5QmkLA0DYgzWwApyu
 Cq8k5rtpAjpdEwdjj+FOIZVOlhlRANahJiaFpSJoRnrF9V2U0tgxjTusYOtJSwO4GyS9
 vu9LEurGISWzAaGmR7rUybT6kBln2yc9bUmHiceOVSpq35XysIzgp56aOz/waMOXzUpv
 FGbcrnp6yRNV3upl+9Zw7zVbhN/7595moDU3KyR3/1S2uY6lBrpxlRQFUDeG8kHwSAZp
 kBUpHqC2AYPLZAqH05Lli1pDXv+MRR+5oa56+pSRQacEgsmasp+vYEtV2O9j8XPT01/e
 ZcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888858; x=1699493658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ifv9SSAPN+ChQ5diIn47KGLE/FuvesYppuuoVucSBEM=;
 b=DINihHT5Rb73p4PKT8bJmf9O9Az3PRVoTljBnM1ODo6PbkNb4XlaolJ6XjiHtRT6hN
 bS1a482E0p7TA8rrYj6N3XE11YCgbLbnhB64PeV0TKl74tx0GEHbB+ZHjFYp/Krv2GW2
 6AzQi0zqb97ytwJzeF/Fn7NdOVCnoPzRBc+4xxsqywJbdODU1gRh43NXfFPGMpQPCap8
 S2Jn8dWaHmdX38z0XnP09QVB4QuPSiCHZDemo1gyFrxf3JFyoo2rq0nNr99F7tY8FC7z
 rV6kcifRsacSfLcMLzmnzawftcDg9V7YxBbXErg99/PLixQqMP866oXVYanwKjs/lde7
 oR4A==
X-Gm-Message-State: AOJu0YydsPUkyHgV8nuMq+KUbppOdbB70yGMll1z1c++BgYq1zXSHn72
 Ao3nBEiul5wjPN6E49ywjRp9/S5MoHwQh+jC04I=
X-Google-Smtp-Source: AGHT+IHJ2q5N8xlRDMa2jDqmzTH4PEzpB7S5lKIXn5WTFLQpXpXbSBvQw5v1Uu4myNJ5W8MjDJzIUw==
X-Received: by 2002:a17:902:e805:b0:1cc:482c:bc46 with SMTP id
 u5-20020a170902e80500b001cc482cbc46mr13328037plg.34.1698888858206; 
 Wed, 01 Nov 2023 18:34:18 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 71/88] target/hppa: Precompute zero into DisasContext
Date: Wed,  1 Nov 2023 18:29:59 -0700
Message-Id: <20231102013016.369010-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
index 36653486fb..5d780bcf56 100644
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
@@ -4380,6 +4380,8 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->iaoq_n = -1;
     ctx->iaoq_n_var = NULL;
 
+    ctx->zero = tcg_constant_i64(0);
+
     /* Bound the number of instructions by those left on the page.  */
     bound = -(ctx->base.pc_first | TARGET_PAGE_MASK) / 4;
     ctx->base.max_insns = MIN(ctx->base.max_insns, bound);
-- 
2.34.1


