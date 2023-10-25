Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 919367D62A9
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:29:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIr-0000NY-Do; Wed, 25 Oct 2023 03:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIl-0000M5-Nx
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:40 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIk-0004kc-3d
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:39 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1ca74e77aecso4356005ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218856; x=1698823656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jVGlwsfbm4sLINQJ1C25FK0LHbR26UwjjqtCg2xAyg8=;
 b=Rzj+kbf4wq+tjXPRkG7Jwud2DD2Wz7ojrsP1Yui5jTVd1gulN0s26SPMxcnbl3Aplx
 9hhY8ceGFwkZMrjlHuv9LGYOyWVh80MDOxV8+V9mLPJb81LcW9FlyKpBQ/Jmdf05iDcE
 k5b1IZNdwre62WRu/SDxdZ7lFd37kVTJvFzW7gq0HodlZfBHYrLZXIS236D0sceo3SWm
 tu2hEBIlS/CadVlAAF1S60vzqD0OgztursaM2Ibs4qzOnSVFf5yWXRWkN8upf67weEBo
 IIoY1W25Y9IEs5GTsfJDMUjXgVWrsFNw9V4430J4BGBTS7fL+xcVgLKLqJxGlQPGyc2/
 fGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218856; x=1698823656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jVGlwsfbm4sLINQJ1C25FK0LHbR26UwjjqtCg2xAyg8=;
 b=p4DWPA/LoqyXgfT8k/P8Vx7Rjcig9dBb36ngAMnbkz/m2GbqphCiLJ8ROzh7Q/OEvQ
 FviZsQPqB05egMx8l4nC5DZQ4807EXW64AvN1kGMA6qIpPs4GQwyHNbRvrxH4U0io1Fb
 qfCmfSIFttRRX3q2GHMg++RNIv2/CG9RoN3zwi9SoZbk9EtS78FuF2Oe6dL5R5ICvCFG
 hTtNbLPcVvfiADwqpz0frKlArIjz6OBoaftFaZkUewVKSpYX5jxpk8RJvsfd8gb/kBLw
 aMcDidV/sQ7LmYb7Xa01zHHj8UylS9Fnmz17M2frfyPrMWmHU00rD7PBnsB2twBbU22D
 qqyg==
X-Gm-Message-State: AOJu0YwQ+TiEconSArSVlwDYbxodzHy/ZFmltBfahb3cLsfTuFYMZTQa
 rtORi5MvRKEsZ0DreClp9NM1JPu2mJ2abFs3sOI=
X-Google-Smtp-Source: AGHT+IF10tXMEFN0yTCyuk45K++jr3JRI4PERsEVkdCC+rYuAW1ZboUEHc+1rvV5epa5R4bI0IJKCA==
X-Received: by 2002:a17:903:32c1:b0:1c7:5776:a30f with SMTP id
 i1-20020a17090332c100b001c75776a30fmr18013355plr.12.1698218856513; 
 Wed, 25 Oct 2023 00:27:36 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 29/29] target/alpha: Use TCG_COND_TSTNE for gen_fold_mzero
Date: Wed, 25 Oct 2023 00:27:07 -0700
Message-Id: <20231025072707.833943-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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


