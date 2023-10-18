Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C14D07CEA7D
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:59:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESY-0001BB-4x; Wed, 18 Oct 2023 17:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESB-0000y8-RO
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:47 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESA-0004O2-5S
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:47 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-581d4f9a2c5so1258453eaf.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665903; x=1698270703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jy+spAs5u7WgOQZspkjRSxDs5g0jtQCLczTslsy9ExE=;
 b=M+KngcJOuAS+GoE9u33VRTnk17iY9Z7CVFcqSxPRbzaRwv/5ebdysrBxgEDtlcg+C4
 d090iouG/p5T8rq7d7JZA8JG5x1/tRDQRLPQbwLlQGFnqnD92LM+tVymwxSxXG3LUziT
 76ZEUIozHCpP+OADMEWisUPBdzJhELQKOw/0HXD1mnDrKEsFI01ZISnaGRHP0o6WrUIk
 JNFKCcKo/Ne2w7ku09FbOBpz0n94Rk9sGsKy8amD+1Bt1ZqCX0Qhv5XgLFnBSOY5xjE/
 j3ptcvvjxMTt2EqP6/vLoOrnzvjIlbi52zkW6V2T5hy0Jf/UNNK+MbR9kza8v4CcEWO2
 B97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665903; x=1698270703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jy+spAs5u7WgOQZspkjRSxDs5g0jtQCLczTslsy9ExE=;
 b=srDK6sHMuPuLMzFs6SJja3OSEewLboYcHkp/+SHJoazp1qAcnSTmrdULGi/6BWDdad
 zo1R6L+Ndg19luJ+ub/2+8CxZ7jr50Iqqex818GAj9xgHWfz+87acrsbGqMjF+Kk4Ksp
 MdHvdBhxleZ9hJgZ8tECgsQwZTosjCP1fS+u1/akrA6e7EpxKuR+PB4VKDKW6LJZSnAa
 rlvWkB9YcFQnHE+DVlbvtssGgsC98VO8dD2l3UTQCIIaKoGYGMoVZQoHuVzNqYmx5/UP
 HTw+8JgcKPha8oYoYV6YwldIRt2Wn73C4sWEUytsq9jfo2h5lwYBS0e4tPEgPuVOx9Lf
 ++LA==
X-Gm-Message-State: AOJu0YzPvP28EvL4pVGmvWBVRiylrhjFmg9nv+HyNGAymri+zB+H1EGJ
 p0Wz/BtfGXKc0ssxfcGQVs2jD2DODzPk/rQWoZA=
X-Google-Smtp-Source: AGHT+IGzECKSV1Vbvuhc0R1GMyx171rvkk3NZ0iRgwxlQN10yIQ6/stbU6IyL8T8Jw9Gvz77SKs7+g==
X-Received: by 2002:a05:6359:5d27:b0:139:c75f:63eb with SMTP id
 ps39-20020a0563595d2700b00139c75f63ebmr219978rwb.21.1697665903522; 
 Wed, 18 Oct 2023 14:51:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 08/61] target/hppa: Fix trans_ds for hppa64
Date: Wed, 18 Oct 2023 14:50:42 -0700
Message-Id: <20231018215135.1561375-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

This instruction always uses the input carry from bit 32,
but produces all 16 output carry bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 48 +++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e6ab113a1c..fb7a295367 100644
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


