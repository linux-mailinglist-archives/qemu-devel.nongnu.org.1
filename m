Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D926B82A43A
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:48:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhKi-0005Pt-Rg; Wed, 10 Jan 2024 17:46:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKG-0004y2-Fh
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:33 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKC-0002wZ-Ce
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:29 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-429be919998so1957051cf.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926727; x=1705531527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Mi02s/8pPhslq92YCDg9owTXJVUIjB51aqomHFCjPA=;
 b=UFG6cNwE2nYjK72QtMVbbEHP1lnq6X+5vqew8499JX0guQ+h1tLEciNXnleoEzIdN2
 ZIOwyu0tjs53t1T7YAFZNkvxVQTe/49vHGYknCN5Vh9oj+fo1nTJHwv9WOlDDNC+Gu8w
 rhy/zq2ZLSQFqDGYvJ5SMqGtrQj7x+DrXceoowxqFnjmr/FI4pn+yZH8P3/bcAsfm2Mm
 DXU8Hzz2ZzIw2DX3Zh3qXGRp0vC8diSIYXk2rvaSfvE/wG9+SUryy3Klk6oy+WHPYCU6
 0gcDcVhvQl8SPz4MrhfRZe0POFBdNQveuRK4F9kWMgHG0atKpGYJySw/VHA3fM91B0O8
 vv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926727; x=1705531527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Mi02s/8pPhslq92YCDg9owTXJVUIjB51aqomHFCjPA=;
 b=lXsIIgd1heKGzQ13QXc4DbJqkNP+69mDYLfqxG3fsFRWuKZ8Jl5HIoORZsFbbaLaSP
 3Yq+FVjJ55PB4XJltrGqzW9GuzIjP/ruzJu3QBuyKHxPRq0AdE5X7XpgvNKxxz+GdFcG
 4Uf5vwskuFYV4DkOndQlZmc3qumYTkv25SFAcmQeV1HIZYgdasyo/63gfHkFS0u6emFn
 NCClukPre6LFp1kveGSMyA5BwknyKZTmsiXkOWcyHK1k45muK7HZWNQfz5F9ZosHswsJ
 bl0v+1Y2Jo97OH2ya+OQlie9yBlpE4hqdG1pLkYnJwOw7kHpecvATa4f1jOFbo6mxXju
 ypaA==
X-Gm-Message-State: AOJu0YzfhJ258NRoHRR8uMcNLb102+PcXFCVEag56IZUqd3xi5r8CYLR
 DL9VceGsqoK5XKa2JLlmeDf1WNO1v0ZnCtSusi8+B0LvECxo0reU
X-Google-Smtp-Source: AGHT+IGKypzb+F1Ao0IiRN76RS4P8UOOH42hixf+LFKc8wtWQ9lIowdjVCeZ6UdsHUgefUA9nldHtQ==
X-Received: by 2002:a05:622a:e:b0:429:bb88:6f1e with SMTP id
 x14-20020a05622a000e00b00429bb886f1emr252029qtw.118.1704926727080; 
 Wed, 10 Jan 2024 14:45:27 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:45:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 11/38] target/alpha: Use TCG_COND_TSTNE for gen_fold_mzero
Date: Thu, 11 Jan 2024 09:43:41 +1100
Message-Id: <20240110224408.10444-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x832.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


