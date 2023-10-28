Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D337DA91C
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:49:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpGA-0005Xu-84; Sat, 28 Oct 2023 15:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFu-0004pj-6f
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:58 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFr-0004Bd-Ew
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:56 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6bd0e1b1890so2765381b3a.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522354; x=1699127154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jVGlwsfbm4sLINQJ1C25FK0LHbR26UwjjqtCg2xAyg8=;
 b=PA+rCgEf9DOIvJgR9vXeAZx0v1wkvPaDPb9AWIGuo8nqX41BmaSaPzTe1YZhiMYHiJ
 rfmc31p7FlYFouFfT6RARbmXIaTfM5o4FGg/nVn1zlUpNx1BVWE4Tdxtt+EQ2qL12+PE
 A0S9NvbeRt4Os/+a0EyIuTi8LKbUUcEoJnkctku+Bu1g3Jfyi26ZaEUL54MI1jF5v2VJ
 l6t25RpZKTqHfKdI4nGySCHIoBY7Wu5whAUxVQi+26U5AKaNnEX5vJdI1Uukl8R6Q9WK
 mwowR8nNklgVam0lB3AJaKIAzQssayDRApTknQPkh4gGJKsD4cXA8pKIgNklKoD6JNXL
 TCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522354; x=1699127154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jVGlwsfbm4sLINQJ1C25FK0LHbR26UwjjqtCg2xAyg8=;
 b=Al74QNpr6nTUQtgs/csuQdi2IWNlSPu0+sgLUWZnrYuvdGKUjqI3QR+/dBHjQFV6ZT
 CBHu0Vt7WH10qhqiDg8z+5OaZOPn+ijtnXTS3eWocdEoAcpbiMXjE4hHucsFJv+qVydX
 ceFunGfffhHKZwKbCVTOAEhh1ZUYrYrQbbzw6+OX33JmFiLdRblBEUTOvGqgXiBK2ZhG
 DBJSJNuk87gjjE1XqnrHkokWB9uARdir5BJD50EAlQ8LpWciYN/t9WGJ0TZ0BJYaG4oH
 OTNui0JxBb4B4AI1K24R7ej45NP6fzhOZO4UKKTCbF7luVn21aNtaj4EcxeIcptFCekQ
 PbKw==
X-Gm-Message-State: AOJu0YyX0LzQkZmv5vmlCHaPCWfbSEZvhCP4hYK5P8e8o2mdUfI0OAkp
 Nf63lBhm47R+qpa2dwprcVDPDYyqowUzglXv+aw=
X-Google-Smtp-Source: AGHT+IHAHpU31ROKlXQWUTH9AWJyHrQ/WG8uQhFZGtlZCCl6GBDFlb0aCwSppGfUQClEYDaLLbWJdA==
X-Received: by 2002:a05:6a20:918d:b0:17a:eddb:ac65 with SMTP id
 v13-20020a056a20918d00b0017aeddbac65mr6266375pzd.9.1698522354229; 
 Sat, 28 Oct 2023 12:45:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 34/35] target/alpha: Use TCG_COND_TSTNE for gen_fold_mzero
Date: Sat, 28 Oct 2023 12:45:21 -0700
Message-Id: <20231028194522.245170-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 49 +++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index c7daf46de7..c68c2bcd21 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -490,56 +490,53 @@ static DisasJumpType gen_bcond(DisasContext *ctx, TCGCond cond, int ra,
 
 /* Fold -0.0 for comparison with COND.  */
 
-static void gen_fold_mzero(TCGCond cond, TCGv dest, TCGv src)
+static TCGv_i64 gen_fold_mzero(TCGCond *pcond, uint64_t *pimm, TCGv_i64 src)
 {
-    uint64_t mzero = 1ull << 63;
+    TCGv_i64 tmp;
 
-    switch (cond) {
+    *pimm = 0;
+    switch (*pcond) {
     case TCG_COND_LE:
     case TCG_COND_GT:
         /* For <= or >, the -0.0 value directly compares the way we want.  */
-        tcg_gen_mov_i64(dest, src);
-        break;
+        return src;
 
     case TCG_COND_EQ:
     case TCG_COND_NE:
-        /* For == or !=, we can simply mask off the sign bit and compare.  */
-        tcg_gen_andi_i64(dest, src, mzero - 1);
-        break;
+        /* For == or !=, we can compare without the sign bit. */
+        *pcond = *pcond == TCG_COND_EQ ? TCG_COND_TSTEQ : TCG_COND_TSTNE;
+        *pimm = INT64_MAX;
+        return src;
 
     case TCG_COND_GE:
     case TCG_COND_LT:
         /* For >= or <, map -0.0 to +0.0. */
-        tcg_gen_movcond_i64(TCG_COND_NE, dest, src, tcg_constant_i64(mzero),
-                            src, tcg_constant_i64(0));
-        break;
+        tmp = tcg_temp_new_i64();
+        tcg_gen_movcond_i64(TCG_COND_EQ, tmp,
+                            src, tcg_constant_i64(INT64_MIN),
+                            tcg_constant_i64(0), src);
+        return tmp;
 
     default:
-        abort();
+        g_assert_not_reached();
     }
 }
 
 static DisasJumpType gen_fbcond(DisasContext *ctx, TCGCond cond, int ra,
                                 int32_t disp)
 {
-    TCGv cmp_tmp = tcg_temp_new();
-    DisasJumpType ret;
-
-    gen_fold_mzero(cond, cmp_tmp, load_fpr(ctx, ra));
-    ret = gen_bcond_internal(ctx, cond, cmp_tmp, 0, disp);
-    return ret;
+    uint64_t imm;
+    TCGv_i64 tmp = gen_fold_mzero(&cond, &imm, load_fpr(ctx, ra));
+    return gen_bcond_internal(ctx, cond, tmp, imm, disp);
 }
 
 static void gen_fcmov(DisasContext *ctx, TCGCond cond, int ra, int rb, int rc)
 {
-    TCGv_i64 va, vb, z;
-
-    z = load_zero(ctx);
-    vb = load_fpr(ctx, rb);
-    va = tcg_temp_new();
-    gen_fold_mzero(cond, va, load_fpr(ctx, ra));
-
-    tcg_gen_movcond_i64(cond, dest_fpr(ctx, rc), va, z, vb, load_fpr(ctx, rc));
+    uint64_t imm;
+    TCGv_i64 tmp = gen_fold_mzero(&cond, &imm, load_fpr(ctx, ra));
+    tcg_gen_movcond_i64(cond, dest_fpr(ctx, rc),
+                        tmp, tcg_constant_i64(imm),
+                        load_fpr(ctx, rb), load_fpr(ctx, rc));
 }
 
 #define QUAL_RM_N       0x080   /* Round mode nearest even */
-- 
2.34.1


