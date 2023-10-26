Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 585A87D7943
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:21:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6K-0001Dg-I2; Wed, 25 Oct 2023 20:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6B-0000yz-Mx
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:44 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo61-0006d3-KB
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:43 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cbf47fa563so2294255ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279571; x=1698884371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jVGlwsfbm4sLINQJ1C25FK0LHbR26UwjjqtCg2xAyg8=;
 b=FeJMXiYGlpWU+R4zX53zg7iprgSjuBBAFS2uUI1P3LyrWoauPOkKSrgBHCvad3MUt4
 sBFqjzRKA0tVeUtj03z2HFky4k/cfibXmLhVcu2s4eFr9UFz6H0Qkl/Rv8zbo2cHWYF1
 FzxhPpoAwSlWmulFv5YpcRXNK2w2v0I5liK2hhZle1LBkrP8nTBm/FiFW23o3hM6o8mP
 Mgae4Valtq4JM6SxIeupEIw8raWsbEwQ4/ZXGz00kltWXyfbMwlkmChBh7uilo4eNLsu
 CS/kz6qQwqTjBrdHvmNCTl3i654XuwUjNnaYq3zYKOsLotKNFw009a3RCN6aLyobbTnR
 7/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279571; x=1698884371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jVGlwsfbm4sLINQJ1C25FK0LHbR26UwjjqtCg2xAyg8=;
 b=XO8Jw/JnvlIjQwitRoDjNG3RY6Yw4IR0MyGRjcSOm7ANPdIPZK2aXmq6euh6l4YkOe
 vKcN0IJdsn44XeIGjG1izpZuYqRwXZCLQdtRnOZYVJMxrhokBxlE9ypzEvsudKQ8rT8B
 Rf51XE77iJENOgzQsEK0easc6fFbDRfZwV6Q2lH2P2k2DpwYCQGAmo7MqFLfA2/0t5tg
 TXXKW1zn3HPxvk8E3Kn/XY33Y6jiG1VnrTU7ouHcTsOGpATJRCm62geSTZBUQbamPmdk
 Y4NkhmuCJoR26NkkckN0nqvGNE7jBNLTVAY4UbBRxShXXe6z4iRadXlqzYXgbz9z/+Pb
 JOtQ==
X-Gm-Message-State: AOJu0YyPXuHkcx8ruKseCJ+S0h1HZbZuDVDQBu6f9FlRMlavTZYJmY67
 10HJpHpD+unvlcyeC0hM1sF6I1v6Vun0U66ZWwU=
X-Google-Smtp-Source: AGHT+IEoe4rqU7bXUwPqYyYLqfs7FC5egsca0B+Yx7z+rfU2XtPuaErBwvkcUbkDs2f1JftVsc2O6g==
X-Received: by 2002:a17:902:d2c1:b0:1c7:495c:87df with SMTP id
 n1-20020a170902d2c100b001c7495c87dfmr17741585plc.53.1698279571171; 
 Wed, 25 Oct 2023 17:19:31 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 29/29] target/alpha: Use TCG_COND_TSTNE for gen_fold_mzero
Date: Wed, 25 Oct 2023 17:14:36 -0700
Message-Id: <20231026001542.1141412-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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


