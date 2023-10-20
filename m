Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF3E7D1782
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:51:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLt-0007pK-0l; Fri, 20 Oct 2023 16:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLT-0007iv-6T
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:47 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLP-00089q-P7
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:45 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b87c1edfd5so1107289b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834621; x=1698439421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jy+spAs5u7WgOQZspkjRSxDs5g0jtQCLczTslsy9ExE=;
 b=hC8IZ3VinQnesMt+Lo0qkAAfWtu1W1+oc1WqznhSBsVZSP8JvQH84i7abk+qC1XArd
 68ubvz804AEdxvOjO4B/7cjZYS5mpIthz+CI2d7LlzqSwfKbU41UPsUbL2vBiz7tGc7k
 6uySOVzg1rgNh2jnfhJoI2MyFrSJBQcFKdO/jx8d3yLR33eEICZsoGC4pNFbBgAwKRLH
 do1Tt2+zvMt+tQSD7ue/641FoaDKsIVVpSuZ+U5cv6VxW1tbePDQTaU6CrVUYgFghHfn
 OTFBlJK7W9tgfA8dJOMqlbNr/+yTQVAewm57ebeBrK8TeDz92JoqVhsY1yCamNzeMGjt
 v3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834621; x=1698439421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jy+spAs5u7WgOQZspkjRSxDs5g0jtQCLczTslsy9ExE=;
 b=c2jFXilOmQ+y9g8hgiobAXczsMinA61rPfSaphDFYuE8bfGcFpCA5m4KwxywZLVK8d
 vK6g8F6IMcFT66ZbbRargW0Fipj2nHYwlgENHNDaaq+sdCEb1JY+v90frpqMK3XeyKRr
 Z7q8suJzotIf6GcpdGNntJKoCeokL5YmdadsZGfx4RsYO6eNDH6WgEQ5L+WHOmZRN2Qj
 t0q6qmG2LUzD8AyU3EnVHI2kKAYoZiC6mox/yu/2HliV/xBxq8bHkURNYKqOlekWNtHt
 t8NHaSrL2jEjavatyp/RWkmOm70ucrau1B9MoWN7UX6FS3hXEIpt7LE25JbCUeuz8dBO
 OrQA==
X-Gm-Message-State: AOJu0Yza2pEjZJPdP0Roel7JZmpRxELUVTRdDW9ZqSPcj+dwq4EeIte1
 RZRydY3GlBtl4v0W50uRLMqmNXxXoRHCUX37XJY=
X-Google-Smtp-Source: AGHT+IHwfLE/aeY5SMA6wSXKTfQ4aQ0hqo/e1Hst9rbmUD6yqyrf0kMVrliJnmQVzRtRq6oRb0Q4PQ==
X-Received: by 2002:a05:6a00:22c5:b0:6b4:c21c:8b56 with SMTP id
 f5-20020a056a0022c500b006b4c21c8b56mr3193565pfj.23.1697834621559; 
 Fri, 20 Oct 2023 13:43:41 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 09/65] target/hppa: Fix trans_ds for hppa64
Date: Fri, 20 Oct 2023 13:42:35 -0700
Message-Id: <20231020204331.139847-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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


