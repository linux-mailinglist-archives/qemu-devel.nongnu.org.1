Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEB07DEA03
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:31:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMXk-0005jE-1b; Wed, 01 Nov 2023 21:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXe-0005cD-GJ
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:38 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXZ-0001XL-FS
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:35 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b709048f32so492567b3a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888631; x=1699493431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPY1sdpy0MpwadGHKWVBaHzMfJjgShg6fGAA7ikVCVc=;
 b=wwQh41y3lx6oAxsdC3eDtRUNo84zAtFGLAlMTanSYJo+i4QmqxxmRofJZZq8tX/K3E
 hgBXYEadPkY0GIIYGoPsIGGICe6RMFRKsYI/wX6N6YB1GgX+VcG6Ojj8QFWtuDJ1x2Re
 91Ifr/JuQ6B3O91wpNoHFMVlNk8cP6309tOkYqiXD5EI0R1EDkWxiXQtRYLCuvi5xT9G
 OeyFY8vPYrm8976sngYwPvSVrtVyGd1C4osoOz0GjCOZWM35565ZuDy0VXHdouBclpFz
 ghuEflbY9CPRjxrrmjW/HKAt+YKFu35VjETnYX5sphhQeCHPAHEq5uBEnJuJvrrU8YzH
 F1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888631; x=1699493431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TPY1sdpy0MpwadGHKWVBaHzMfJjgShg6fGAA7ikVCVc=;
 b=wBZGInXZ+VfZLP4vwK451qzFK5cDdmEvUHOny8g2EEb20bOQuFDia1yhdku+DIVo4Y
 uDEqUxpq4LZrA8EC4pXQS+OpGz1dAjq0Nt7WtvIaMuM0MEGlG5gMjWqvrKID4fJEKVX2
 mk5jFFGPWmnQi4LMpNCAIzH0lln+kypPqCrJ1xgicJ99fu3NJp+OE4wvj2i3iJaQStwk
 ExyWzIuS8wtaYhgWpJA3wPVnxBKdj27PjUBTUSiTl/kF9hhtICq/sT63BpWt7QI1rVEy
 vo2NKljGY8QWhNwSHQERwSAxYzyymlZ4cOV0ruoh7ToYXj0/IXddfgSAcKnB3R9Ip9F+
 z2CA==
X-Gm-Message-State: AOJu0YzzDcwAuzkvP+WwdgUfcZvo/Ypi5v6U7DdyhB20RlhC9n1FXeQQ
 NQ8qk6wJWmj0G/iFnnq5Vnq/4vt8zTzWealYgS4=
X-Google-Smtp-Source: AGHT+IG2JKfT2FoLIfK7vMn2HfHxzIhJA47OwSafvwn/5KTzlA3fnOD8SJllfp2R9SDJ6o8W02imAA==
X-Received: by 2002:a05:6a00:3024:b0:6c2:cb9a:885e with SMTP id
 ay36-20020a056a00302400b006c2cb9a885emr5344157pfb.15.1698888630356; 
 Wed, 01 Nov 2023 18:30:30 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 15/88] target/hppa: Fix trans_ds for hppa64
Date: Wed,  1 Nov 2023 18:29:03 -0700
Message-Id: <20231102013016.369010-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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


