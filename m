Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE9A7E3395
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:08:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0COO-0006cq-Ak; Mon, 06 Nov 2023 22:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO6-0006Ma-Ap
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:22 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO4-0000eZ-Bi
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:22 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cc5b6d6228so34173875ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326259; x=1699931059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TPY1sdpy0MpwadGHKWVBaHzMfJjgShg6fGAA7ikVCVc=;
 b=GdLLetd0i8Pd6k1PQH3dKA8cYqidJS5dWJvdGvZd1BhFodOBmFRWQ5SvwMwzuKqk96
 7JJyv2GPKiREkwJZ7FDxv7XnlRMkKYQtHQc6w9RABsfM2lFfP5jdf8XWVtMxl1SVAuw2
 3uQPk2wg8MuAIZOaAipjFpbQvWTV6sfcYQrGuettrwB4OMZdM0axinD7id9XcQJeZwhy
 VU0F5S6x6P0IFGm6evhjY5Xv2MavtxnUyKcGucjQtp8ACXcETZdIiFadVEwVqBPMdZHa
 gbZVwiA8lJ6lPj7Nf6GF3i83AZ+7uhlq7yFkbFE2kBRR28xnV1F5JA1mI8zI28VxKzca
 utSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326259; x=1699931059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TPY1sdpy0MpwadGHKWVBaHzMfJjgShg6fGAA7ikVCVc=;
 b=IFmJZ1RZzZcx07iqFtr1nT+M2kR+/G78SMEv20e3S/dJwwmqEdb4A1jnfvS+KXGY2U
 1BeSiLC+l+35aBZl1c+B6FGK6Hwl6Mda8qYX8B8M3djMQGASBKgCq/MYxlBeEbOm+e4t
 c91yofVP2LV1SpMddAIqyjEAPi1OAX9vV93ZSnm8wjpr3VGvaYYXR4m9/rAfV7RF4QK7
 5ZR3w6L9h4lMUK3zcGtkvY06mC4twD26bd2uPzXjTzzY1ApR8urE1vlDAKliZ4z2+N7W
 JiDr0ejstitmBRdF9gIPTJ1PwuThNUviHJPDhI+jFr6G8s0ZkHxg8IWtuUQIF0E9R5VJ
 c67A==
X-Gm-Message-State: AOJu0YwOavj1IiYeiN6+3+vqJ6He3SSSRamCntQH5GuGlnIqhwLo32L9
 vTET0Mtqe951lLbDwJrVgjOf64JLfM71ihd7Kx4=
X-Google-Smtp-Source: AGHT+IGk5awEaK4OAmRIkFkXqZmdHEPq66ucvqQG4d75OD8K7NQ+glUdUnwewbAyswH4cl/8JL45BQ==
X-Received: by 2002:a17:903:10a:b0:1cc:6101:2086 with SMTP id
 y10-20020a170903010a00b001cc61012086mr14286566plc.11.1699326258762; 
 Mon, 06 Nov 2023 19:04:18 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/85] target/hppa: Fix trans_ds for hppa64
Date: Mon,  6 Nov 2023 19:02:55 -0800
Message-Id: <20231107030407.8979-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

This instruction always uses the input carry from bit 32,
but produces all 16 output carry bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 48 +++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index d6ccce020a..8ba95ae320 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -803,6 +803,12 @@ static bool cond_need_cb(int c)
     return c == 4 || c == 5;
 }
 
+/* Need extensions from TCGv_i32 to TCGv_reg. */
+static bool cond_need_ext(DisasContext *ctx, bool d)
+{
+    return TARGET_REGISTER_BITS == 64 && !d;
+}
+
 /*
  * Compute conditional for arithmetic.  See Page 5-3, Table 5-1, of
  * the Parisc 1.1 Architecture Reference Manual for details.
@@ -1040,6 +1046,22 @@ static DisasCond do_unit_cond(unsigned cf, TCGv_reg res,
     return cond;
 }
 
+static TCGv_reg get_carry(DisasContext *ctx, bool d,
+                          TCGv_reg cb, TCGv_reg cb_msb)
+{
+    if (cond_need_ext(ctx, d)) {
+        TCGv_reg t = tcg_temp_new();
+        tcg_gen_extract_reg(t, cb, 32, 1);
+        return t;
+    }
+    return cb_msb;
+}
+
+static TCGv_reg get_psw_carry(DisasContext *ctx, bool d)
+{
+    return get_carry(ctx, d, cpu_psw_cb, cpu_psw_cb_msb);
+}
+
 /* Compute signed overflow for addition.  */
 static TCGv_reg do_add_sv(DisasContext *ctx, TCGv_reg res,
                           TCGv_reg in1, TCGv_reg in2)
@@ -2712,6 +2734,7 @@ static bool trans_dcor_i(DisasContext *ctx, arg_rr_cf *a)
 static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
 {
     TCGv_reg dest, add1, add2, addc, zero, in1, in2;
+    TCGv_reg cout;
 
     nullify_over(ctx);
 
@@ -2726,18 +2749,20 @@ static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
 
     /* Form R1 << 1 | PSW[CB]{8}.  */
     tcg_gen_add_reg(add1, in1, in1);
-    tcg_gen_add_reg(add1, add1, cpu_psw_cb_msb);
+    tcg_gen_add_reg(add1, add1, get_psw_carry(ctx, false));
 
-    /* Add or subtract R2, depending on PSW[V].  Proper computation of
-       carry{8} requires that we subtract via + ~R2 + 1, as described in
-       the manual.  By extracting and masking V, we can produce the
-       proper inputs to the addition without movcond.  */
-    tcg_gen_sari_reg(addc, cpu_psw_v, TARGET_REGISTER_BITS - 1);
+    /*
+     * Add or subtract R2, depending on PSW[V].  Proper computation of
+     * carry requires that we subtract via + ~R2 + 1, as described in
+     * the manual.  By extracting and masking V, we can produce the
+     * proper inputs to the addition without movcond.
+     */
+    tcg_gen_sextract_reg(addc, cpu_psw_v, 31, 1);
     tcg_gen_xor_reg(add2, in2, addc);
     tcg_gen_andi_reg(addc, addc, 1);
-    /* ??? This is only correct for 32-bit.  */
-    tcg_gen_add2_i32(dest, cpu_psw_cb_msb, add1, zero, add2, zero);
-    tcg_gen_add2_i32(dest, cpu_psw_cb_msb, dest, cpu_psw_cb_msb, addc, zero);
+
+    tcg_gen_add2_reg(dest, cpu_psw_cb_msb, add1, zero, add2, zero);
+    tcg_gen_add2_reg(dest, cpu_psw_cb_msb, dest, cpu_psw_cb_msb, addc, zero);
 
     /* Write back the result register.  */
     save_gpr(ctx, a->t, dest);
@@ -2747,7 +2772,8 @@ static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
     tcg_gen_xor_reg(cpu_psw_cb, cpu_psw_cb, dest);
 
     /* Write back PSW[V] for the division step.  */
-    tcg_gen_neg_reg(cpu_psw_v, cpu_psw_cb_msb);
+    cout = get_psw_carry(ctx, false);
+    tcg_gen_neg_reg(cpu_psw_v, cout);
     tcg_gen_xor_reg(cpu_psw_v, cpu_psw_v, in2);
 
     /* Install the new nullification.  */
@@ -2757,7 +2783,7 @@ static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
             /* ??? The lshift is supposed to contribute to overflow.  */
             sv = do_add_sv(ctx, dest, add1, add2);
         }
-        ctx->null_cond = do_cond(a->cf, dest, cpu_psw_cb_msb, sv);
+        ctx->null_cond = do_cond(a->cf, dest, cout, sv);
     }
 
     return nullify_end(ctx);
-- 
2.34.1


