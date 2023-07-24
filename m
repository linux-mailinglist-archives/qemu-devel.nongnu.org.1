Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB2575EE7B
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 10:56:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNrK1-00026l-HX; Mon, 24 Jul 2023 04:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNrJy-00023K-7q
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:53:38 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNrJv-0000er-9Q
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:53:37 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbc656873eso39516165e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 01:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690188814; x=1690793614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2zCvmEJYFTqfiAcu8CvxN/tos2dn//8Q84Fs7tMAmMg=;
 b=eT1Sq9I1U+ds2I5KVwn/NwqB0XzltNohvUhzxG19l7HtIdnSmW+HdONq09+CisDR86
 TOBIUJC88BGjWolDqVYCyVQ5+9NiYRUd3d505OX+i2+5JNPQSA1gytLM6aH7Q6uHoMei
 Z923hLPKj3zl9oO1p/ZljeO9lSnNpOntMFPBhnv/tuV9cGbSbwRZeG+8JcKEeSF15q5V
 dbD507D9NMgX9yWt6MJG7798hpPU2u1btQr8pPSn4ijtIajXnEQNxyKISBSesevSTzpA
 1Vzo7XiheUmNYsF39UNteTRk+J5MMBFqiSN3seSf9swGnYrBUsv1DIFqolHVRo5oaS5f
 obPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690188814; x=1690793614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2zCvmEJYFTqfiAcu8CvxN/tos2dn//8Q84Fs7tMAmMg=;
 b=eb8fmleKkyU/r50OZfN8gn4hLT3qJ8RsmTIWPyHBmk5N+TQVdc4QltNSbp3cSfy+ep
 5TvHlHUdCm4B7poxhb852Kh2PWJWB6WzTFqewpq86iWOpu0nb2TC6St/or7FGrQ+/MYr
 MOkxHc+7IutQkjiuzviLqPseaWxrhBX4kULCUPJLQcbjaxUi5y6TrlptUjziGeNXdAqb
 qIia8rlPxZFKRSkbsafsY0L/vC+NBD+HTjItwBU2WhkFZ0MtOB32L7oUUwOGSHlnod7T
 2DdffloBOt2FSAx081qiYsvs9ADiFq8ojtwN4/0og3EhLLbQUonQCuRVsJbx5M9On1ZW
 Vtsg==
X-Gm-Message-State: ABy/qLZVzg6SXsowJqKai9HirDOPR6rMnTHJ1d0K3zjDdBh1ve13enDM
 gNm+xrX3HyBnQ443q/2qOOkxAKicW899dC6Zd58LDg==
X-Google-Smtp-Source: APBJJlEcGyC7tpTcYe5pyyOqIYHhPbheQpcbI2ETvZPinCHYZujUNmXw8xztyMysX2F90DDESoespA==
X-Received: by 2002:a7b:c315:0:b0:3fc:80a:cf63 with SMTP id
 k21-20020a7bc315000000b003fc080acf63mr8085728wmj.38.1690188813866; 
 Mon, 24 Jul 2023 01:53:33 -0700 (PDT)
Received: from stoup.. ([62.252.144.58]) by smtp.gmail.com with ESMTPSA id
 t8-20020a1c7708000000b003fa74bff02asm9570994wmi.26.2023.07.24.01.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 01:53:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PULL 5/7] tcg/{i386,
 s390x}: Add earlyclobber to the op_add2's first output
Date: Mon, 24 Jul 2023 09:53:26 +0100
Message-Id: <20230724085328.4936-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724085328.4936-1-richard.henderson@linaro.org>
References: <20230724085328.4936-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

i386 and s390x implementations of op_add2 require an earlyclobber,
which is currently missing. This breaks VCKSM in s390x guests. E.g., on
x86_64 the following op:

    add2_i32 tmp2,tmp3,tmp2,tmp3,tmp3,tmp2   dead: 0 2 3 4 5  pref=none,0xffff

is translated to:

    addl     %ebx, %r12d
    adcl     %r12d, %ebx

Introduce a new C_N1_O1_I4 constraint, and make sure that earlyclobber
of aliased outputs is honored.

Cc: qemu-stable@nongnu.org
Fixes: 82790a870992 ("tcg: Add markup for output requires new register")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230719221310.1968845-7-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target-con-set.h  | 5 ++++-
 tcg/s390x/tcg-target-con-set.h | 8 +++++---
 tcg/tcg.c                      | 8 +++++++-
 tcg/i386/tcg-target.c.inc      | 2 +-
 tcg/s390x/tcg-target.c.inc     | 4 ++--
 5 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
index 91ceb0e1da..5ea3a292f0 100644
--- a/tcg/i386/tcg-target-con-set.h
+++ b/tcg/i386/tcg-target-con-set.h
@@ -11,6 +11,9 @@
  *
  * C_N1_Im(...) defines a constraint set with 1 output and <m> inputs,
  * except that the output must use a new register.
+ *
+ * C_Nn_Om_Ik(...) defines a constraint set with <n + m> outputs and <k>
+ * inputs, except that the first <n> outputs must use new registers.
  */
 C_O0_I1(r)
 C_O0_I2(L, L)
@@ -53,4 +56,4 @@ C_O2_I1(r, r, L)
 C_O2_I2(a, d, a, r)
 C_O2_I2(r, r, L, L)
 C_O2_I3(a, d, 0, 1, r)
-C_O2_I4(r, r, 0, 1, re, re)
+C_N1_O1_I4(r, r, 0, 1, re, re)
diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
index cbad91b2b5..9a42037499 100644
--- a/tcg/s390x/tcg-target-con-set.h
+++ b/tcg/s390x/tcg-target-con-set.h
@@ -8,6 +8,9 @@
  * C_On_Im(...) defines a constraint set with <n> outputs and <m> inputs.
  * Each operand should be a sequence of constraint letters as defined by
  * tcg-target-con-str.h; the constraint combination is inclusive or.
+ *
+ * C_Nn_Om_Ik(...) defines a constraint set with <n + m> outputs and <k>
+ * inputs, except that the first <n> outputs must use new registers.
  */
 C_O0_I1(r)
 C_O0_I2(r, r)
@@ -41,6 +44,5 @@ C_O2_I1(o, m, r)
 C_O2_I2(o, m, 0, r)
 C_O2_I2(o, m, r, r)
 C_O2_I3(o, m, 0, 1, r)
-C_O2_I4(r, r, 0, 1, rA, r)
-C_O2_I4(r, r, 0, 1, ri, r)
-C_O2_I4(r, r, 0, 1, r, r)
+C_N1_O1_I4(r, r, 0, 1, ri, r)
+C_N1_O1_I4(r, r, 0, 1, rA, r)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 652e8ea6b9..ddfe9a96cb 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -648,6 +648,7 @@ static void tcg_out_movext3(TCGContext *s, const TCGMovExtend *i1,
 #define C_O2_I2(O1, O2, I1, I2)         C_PFX4(c_o2_i2_, O1, O2, I1, I2),
 #define C_O2_I3(O1, O2, I1, I2, I3)     C_PFX5(c_o2_i3_, O1, O2, I1, I2, I3),
 #define C_O2_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_o2_i4_, O1, O2, I1, I2, I3, I4),
+#define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_n1_o1_i4_, O1, O2, I1, I2, I3, I4),
 
 typedef enum {
 #include "tcg-target-con-set.h"
@@ -668,6 +669,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
 #undef C_O2_I2
 #undef C_O2_I3
 #undef C_O2_I4
+#undef C_N1_O1_I4
 
 /* Put all of the constraint sets into an array, indexed by the enum. */
 
@@ -687,6 +689,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
 #define C_O2_I2(O1, O2, I1, I2)         { .args_ct_str = { #O1, #O2, #I1, #I2 } },
 #define C_O2_I3(O1, O2, I1, I2, I3)     { .args_ct_str = { #O1, #O2, #I1, #I2, #I3 } },
 #define C_O2_I4(O1, O2, I1, I2, I3, I4) { .args_ct_str = { #O1, #O2, #I1, #I2, #I3, #I4 } },
+#define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) { .args_ct_str = { "&" #O1, #O2, #I1, #I2, #I3, #I4 } },
 
 static const TCGTargetOpDef constraint_sets[] = {
 #include "tcg-target-con-set.h"
@@ -706,6 +709,7 @@ static const TCGTargetOpDef constraint_sets[] = {
 #undef C_O2_I2
 #undef C_O2_I3
 #undef C_O2_I4
+#undef C_N1_O1_I4
 
 /* Expand the enumerator to be returned from tcg_target_op_def(). */
 
@@ -725,6 +729,7 @@ static const TCGTargetOpDef constraint_sets[] = {
 #define C_O2_I2(O1, O2, I1, I2)         C_PFX4(c_o2_i2_, O1, O2, I1, I2)
 #define C_O2_I3(O1, O2, I1, I2, I3)     C_PFX5(c_o2_i3_, O1, O2, I1, I2, I3)
 #define C_O2_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_o2_i4_, O1, O2, I1, I2, I3, I4)
+#define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_n1_o1_i4_, O1, O2, I1, I2, I3, I4)
 
 #include "tcg-target.c.inc"
 
@@ -4703,7 +4708,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
                  * dead after the instruction, we must allocate a new
                  * register and move it.
                  */
-                if (temp_readonly(ts) || !IS_DEAD_ARG(i)) {
+                if (temp_readonly(ts) || !IS_DEAD_ARG(i)
+                    || def->args_ct[arg_ct->alias_index].newreg) {
                     allocate_new_reg = true;
                 } else if (ts->val_type == TEMP_VAL_REG) {
                     /*
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index ab997b5fb3..77482da070 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3335,7 +3335,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
     case INDEX_op_sub2_i64:
-        return C_O2_I4(r, r, 0, 1, re, re);
+        return C_N1_O1_I4(r, r, 0, 1, re, re);
 
     case INDEX_op_ctz_i32:
     case INDEX_op_ctz_i64:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index a878acd8ca..a94f7908d6 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3229,11 +3229,11 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_add2_i32:
     case INDEX_op_sub2_i32:
-        return C_O2_I4(r, r, 0, 1, ri, r);
+        return C_N1_O1_I4(r, r, 0, 1, ri, r);
 
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i64:
-        return C_O2_I4(r, r, 0, 1, rA, r);
+        return C_N1_O1_I4(r, r, 0, 1, rA, r);
 
     case INDEX_op_st_vec:
         return C_O0_I2(v, r);
-- 
2.34.1


