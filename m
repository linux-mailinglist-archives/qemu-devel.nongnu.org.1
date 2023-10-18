Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F82A7CEA56
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:54:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESk-0001tI-7J; Wed, 18 Oct 2023 17:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESO-00019R-0f
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:01 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESL-0004RJ-Lj
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:59 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1dd8304b980so4636182fac.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665916; x=1698270716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwyqjJ9QUSpnAuYnVaYNZPjS81j2Avs+ZfX6KYX0BS0=;
 b=Zx9HixpLkS0tmEtuq9kMXnwQVGGyfxpWuKSrjhmZyKjBxOpTR6Fx8zvECnboEgRamh
 VxjU6kxaWixicD4ABfkjL7tnurTLHbxxC8dpdgZ2jlKfg0ZSqNCHm6r2xv6da8IPbrPy
 wr8QiIhFNe9xVNFQdY7Y8MQsaRIaZ4fC7CtfcUsJtpSCzAamo+M5Vm6dyhsB+QDb9l4I
 DU/8CSU8m+I5hQutZ3MOD4KNMjYJiljEz1VeUcw9g18fvCzXt2yFpfE+hv3dnBrnr7i3
 i+3MVa8n7RI7YopTmhAMPqVgFKyzTY5fK+kjH9WlrOpNJ/B9jBsWbk0+T7oT0qEQOrrR
 YfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665916; x=1698270716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UwyqjJ9QUSpnAuYnVaYNZPjS81j2Avs+ZfX6KYX0BS0=;
 b=o4CU4vx3MJLx/z5kpsiismMpQiB/33zR1dNiR235G3nDE2hnvghALRcyJuqTXJgaIj
 NrbyPN67rC3y7fvS0LCqhRMTqLaBU3OiOFSNJmOtThRddBuGYNpvz+nHsY7gGCX2sCHK
 yb1Ml3Dp+JOnNYzC5pz/+WkqkCBd/zialxqrGFBUbCs+JN8U6tw3w7ReRAjS8bQ6usyR
 oz9MkGHAI+BInfOrxrXR4kJIwtXwaE3RdtwsPbfEu/hqAolw6Sr97rjf5LRKYTeQm3Lq
 akeOj3ZXEhiBWaiNZ9kjBRIbvIrgRpIRalysSb4fs5dozeB2kBH8iCZura6KX+pZWmUd
 ytiw==
X-Gm-Message-State: AOJu0Yz5TYRmODxMciIwGR0Y9hqs8nG5X4U9GWzqw+XdKnvVBxLcf8AR
 NYVtJBz3+3O+AI/bXiG7lttl/Z0d/FezElm1nrA=
X-Google-Smtp-Source: AGHT+IEDM4Q8Na09YXPEq1HugHBr9LMSHFuNmtLYUIs+7JGSRj6MBaAJ4/rN43ax5AmOXezXidIq6A==
X-Received: by 2002:a05:6870:aa88:b0:1d0:f5bd:6d2 with SMTP id
 gr8-20020a056870aa8800b001d0f5bd06d2mr798424oab.38.1697665916443; 
 Wed, 18 Oct 2023 14:51:56 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 23/61] target/hppa: Pass d to do_sub_cond
Date: Wed, 18 Oct 2023 14:50:57 -0700
Message-Id: <20231018215135.1561375-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

Hoist the resolution of d up one level above do_sub_cond.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 77 ++++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index d6edad9adb..7c95c479dc 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -446,12 +446,15 @@ static DisasCond cond_make_n(void)
     };
 }
 
-static DisasCond cond_make_0_tmp(TCGCond c, TCGv_reg a0)
+static DisasCond cond_make_tmp(TCGCond c, TCGv_reg a0, TCGv_reg a1)
 {
     assert (c != TCG_COND_NEVER && c != TCG_COND_ALWAYS);
-    return (DisasCond){
-        .c = c, .a0 = a0, .a1 = tcg_constant_reg(0)
-    };
+    return (DisasCond){ .c = c, .a0 = a0, .a1 = a1 };
+}
+
+static DisasCond cond_make_0_tmp(TCGCond c, TCGv_reg a0)
+{
+    return cond_make_tmp(c, a0, tcg_constant_reg(0));
 }
 
 static DisasCond cond_make_0(TCGCond c, TCGv_reg a0)
@@ -463,15 +466,12 @@ static DisasCond cond_make_0(TCGCond c, TCGv_reg a0)
 
 static DisasCond cond_make(TCGCond c, TCGv_reg a0, TCGv_reg a1)
 {
-    DisasCond r = { .c = c };
+    TCGv_reg t0 = tcg_temp_new();
+    TCGv_reg t1 = tcg_temp_new();
 
-    assert (c != TCG_COND_NEVER && c != TCG_COND_ALWAYS);
-    r.a0 = tcg_temp_new();
-    tcg_gen_mov_reg(r.a0, a0);
-    r.a1 = tcg_temp_new();
-    tcg_gen_mov_reg(r.a1, a1);
-
-    return r;
+    tcg_gen_mov_reg(t0, a0);
+    tcg_gen_mov_reg(t1, a1);
+    return cond_make_tmp(c, t0, t1);
 }
 
 static void cond_free(DisasCond *cond)
@@ -910,36 +910,55 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
    can use the inputs directly.  This can allow other computation to be
    deleted as unused.  */
 
-static DisasCond do_sub_cond(DisasContext *ctx, unsigned cf, TCGv_reg res,
-                             TCGv_reg in1, TCGv_reg in2, TCGv_reg sv)
+static DisasCond do_sub_cond(DisasContext *ctx, unsigned cf, bool d,
+                             TCGv_reg res, TCGv_reg in1,
+                             TCGv_reg in2, TCGv_reg sv)
 {
-    DisasCond cond;
-    bool d = false;
+    TCGCond tc;
+    bool ext_uns;
 
     switch (cf >> 1) {
     case 1: /* = / <> */
-        cond = cond_make(TCG_COND_EQ, in1, in2);
+        tc = TCG_COND_EQ;
+        ext_uns = true;
         break;
     case 2: /* < / >= */
-        cond = cond_make(TCG_COND_LT, in1, in2);
+        tc = TCG_COND_LT;
+        ext_uns = false;
         break;
     case 3: /* <= / > */
-        cond = cond_make(TCG_COND_LE, in1, in2);
+        tc = TCG_COND_LE;
+        ext_uns = false;
         break;
     case 4: /* << / >>= */
-        cond = cond_make(TCG_COND_LTU, in1, in2);
+        tc = TCG_COND_LTU;
+        ext_uns = true;
         break;
     case 5: /* <<= / >> */
-        cond = cond_make(TCG_COND_LEU, in1, in2);
+        tc = TCG_COND_LEU;
+        ext_uns = true;
         break;
     default:
         return do_cond(ctx, cf, d, res, NULL, sv);
     }
-    if (cf & 1) {
-        cond.c = tcg_invert_cond(cond.c);
-    }
 
-    return cond;
+    if (cf & 1) {
+        tc = tcg_invert_cond(tc);
+    }
+    if (cond_need_ext(ctx, d)) {
+        TCGv_reg t1 = tcg_temp_new();
+        TCGv_reg t2 = tcg_temp_new();
+
+        if (ext_uns) {
+            tcg_gen_ext32u_reg(t1, in1);
+            tcg_gen_ext32u_reg(t2, in2);
+        } else {
+            tcg_gen_ext32s_reg(t1, in1);
+            tcg_gen_ext32s_reg(t2, in2);
+        }
+        return cond_make_tmp(tc, t1, t2);
+    }
+    return cond_make(tc, in1, in2);
 }
 
 /*
@@ -1267,7 +1286,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 
     /* Compute the condition.  We cannot use the special case for borrow.  */
     if (!is_b) {
-        cond = do_sub_cond(ctx, cf, dest, in1, in2, sv);
+        cond = do_sub_cond(ctx, cf, d, dest, in1, in2, sv);
     } else {
         cond = do_cond(ctx, cf, d, dest, get_carry(ctx, d, cb, cb_msb), sv);
     }
@@ -1321,6 +1340,7 @@ static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 {
     TCGv_reg dest, sv;
     DisasCond cond;
+    bool d = false;
 
     dest = tcg_temp_new();
     tcg_gen_sub_reg(dest, in1, in2);
@@ -1332,7 +1352,7 @@ static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     }
 
     /* Form the condition for the compare.  */
-    cond = do_sub_cond(ctx, cf, dest, in1, in2, sv);
+    cond = do_sub_cond(ctx, cf, d, dest, in1, in2, sv);
 
     /* Clear.  */
     tcg_gen_movi_reg(dest, 0);
@@ -3028,6 +3048,7 @@ static bool do_cmpb(DisasContext *ctx, unsigned r, TCGv_reg in1,
 {
     TCGv_reg dest, in2, sv;
     DisasCond cond;
+    bool d = false;
 
     in2 = load_gpr(ctx, r);
     dest = tcg_temp_new();
@@ -3039,7 +3060,7 @@ static bool do_cmpb(DisasContext *ctx, unsigned r, TCGv_reg in1,
         sv = do_sub_sv(ctx, dest, in1, in2);
     }
 
-    cond = do_sub_cond(ctx, c * 2 + f, dest, in1, in2, sv);
+    cond = do_sub_cond(ctx, c * 2 + f, d, dest, in1, in2, sv);
     return do_cbranch(ctx, disp, n, &cond);
 }
 
-- 
2.34.1


