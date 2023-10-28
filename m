Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA0E7DA920
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:50:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpFx-0004qJ-RH; Sat, 28 Oct 2023 15:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFr-0004o0-Mf
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:55 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFp-0004B9-Lx
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:55 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-d852b28ec3bso2493597276.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522352; x=1699127152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qt73rqnYlScESAX1GLvymJtn101eThzhHh8tymn5hTE=;
 b=MZlh9eRV43aKOQk61y/h0q5ScuSemak6og2tworHN50N/qsSAwy6u1jyG3XCIZOm4u
 DredOxSHTXrc9GK/CWkdgdb6OgZONZhMJPm97fl21XeWF7CZLFpUhpSa4nlma44SWYgv
 s1uLdG7wWxnGwgpDeGWpIWpiMlFJWhVMfg5tmVWkAoEtLlXr52sXac6wOWFyx9wc2Pi/
 x14JPQfWOJ6pTf1KdyPGRbujjp0v5dyueM/nnETMD2aTHfxZpti3jy6TwHttBLyZ68kU
 p1trdi6sBGi/Jq/usKhbD9XwAdEx3ENxrDmyWHX1cBfm7Pt58u0LjyBHecMwxt3+sDDk
 JRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522352; x=1699127152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qt73rqnYlScESAX1GLvymJtn101eThzhHh8tymn5hTE=;
 b=jt3sxG9hv5UKvo8B2a5GPvMus/UnMwhtH8hQHpfWu51ysvkNsyvuMCkfZ5N87xj1QM
 LE44Cfp1t7w9coWbcPryaMRLb8tpAE+0wFr+IAgGnKNJmvqa+ELoLiPNe3EaRKXTnwmE
 YC4zGihW4n3fCJbCa97yo/k/wirHImTgCXiDDK59kaeGE9BnVSNakQrNegcVSyNJfcXV
 QhokGLc53r3i6Z8CeA3GmmzubcdecoFYrBR0eRJadYyWmkFSSFiM0yjAQdTe4bDyzrVt
 z03SRhBz62M10Un1XGeJaT+54PgccGUdoCwKgZV6EmFKBalgsr+jgL61PCZnCUmWIAqB
 dQXw==
X-Gm-Message-State: AOJu0Yw+RbdjB2NyXUb1G1GH2Hh6bUGifdQ1HjEy8Q2ClP7K8YrdWoMV
 2QInryd9x8q9lU8BfMShCVWKZE1hsImJC2cFyy8=
X-Google-Smtp-Source: AGHT+IFLkyTJMMC/fClf1+60ijE+Q1vkkcAx0T0KZ4mHNafRa9DI2X9m7RJC7HpoyO13GvLBQeNrUw==
X-Received: by 2002:a25:a2c9:0:b0:d9a:fe8c:c298 with SMTP id
 c9-20020a25a2c9000000b00d9afe8cc298mr5188166ybn.31.1698522352509; 
 Sat, 28 Oct 2023 12:45:52 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 32/35] target/alpha: Use TCG_COND_TST{EQ,NE} for BLB{C,S}
Date: Sat, 28 Oct 2023 12:45:19 -0700
Message-Id: <20231028194522.245170-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb34.google.com
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
 target/alpha/translate.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 32333081d8..49e6a7b62d 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -453,13 +453,13 @@ static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 }
 
 static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
-                                        TCGv cmp, int32_t disp)
+                                        TCGv cmp, uint64_t imm, int32_t disp)
 {
     uint64_t dest = ctx->base.pc_next + (disp << 2);
     TCGLabel *lab_true = gen_new_label();
 
     if (use_goto_tb(ctx, dest)) {
-        tcg_gen_brcondi_i64(cond, cmp, 0, lab_true);
+        tcg_gen_brcondi_i64(cond, cmp, imm, lab_true);
 
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
@@ -472,27 +472,20 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
 
         return DISAS_NORETURN;
     } else {
-        TCGv_i64 z = load_zero(ctx);
+        TCGv_i64 i = tcg_constant_i64(imm);
         TCGv_i64 d = tcg_constant_i64(dest);
         TCGv_i64 p = tcg_constant_i64(ctx->base.pc_next);
 
-        tcg_gen_movcond_i64(cond, cpu_pc, cmp, z, d, p);
+        tcg_gen_movcond_i64(cond, cpu_pc, cmp, i, d, p);
         return DISAS_PC_UPDATED;
     }
 }
 
 static DisasJumpType gen_bcond(DisasContext *ctx, TCGCond cond, int ra,
-                               int32_t disp, int mask)
+                               int32_t disp)
 {
-    if (mask) {
-        TCGv tmp = tcg_temp_new();
-        DisasJumpType ret;
-
-        tcg_gen_andi_i64(tmp, load_gpr(ctx, ra), 1);
-        ret = gen_bcond_internal(ctx, cond, tmp, disp);
-        return ret;
-    }
-    return gen_bcond_internal(ctx, cond, load_gpr(ctx, ra), disp);
+    return gen_bcond_internal(ctx, cond, load_gpr(ctx, ra),
+                              is_tst_cond(cond), disp);
 }
 
 /* Fold -0.0 for comparison with COND.  */
@@ -533,7 +526,7 @@ static DisasJumpType gen_fbcond(DisasContext *ctx, TCGCond cond, int ra,
     DisasJumpType ret;
 
     gen_fold_mzero(cond, cmp_tmp, load_fpr(ctx, ra));
-    ret = gen_bcond_internal(ctx, cond, cmp_tmp, disp);
+    ret = gen_bcond_internal(ctx, cond, cmp_tmp, 0, disp);
     return ret;
 }
 
@@ -2827,35 +2820,35 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
         break;
     case 0x38:
         /* BLBC */
-        ret = gen_bcond(ctx, TCG_COND_EQ, ra, disp21, 1);
+        ret = gen_bcond(ctx, TCG_COND_TSTEQ, ra, disp21);
         break;
     case 0x39:
         /* BEQ */
-        ret = gen_bcond(ctx, TCG_COND_EQ, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_EQ, ra, disp21);
         break;
     case 0x3A:
         /* BLT */
-        ret = gen_bcond(ctx, TCG_COND_LT, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_LT, ra, disp21);
         break;
     case 0x3B:
         /* BLE */
-        ret = gen_bcond(ctx, TCG_COND_LE, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_LE, ra, disp21);
         break;
     case 0x3C:
         /* BLBS */
-        ret = gen_bcond(ctx, TCG_COND_NE, ra, disp21, 1);
+        ret = gen_bcond(ctx, TCG_COND_TSTNE, ra, disp21);
         break;
     case 0x3D:
         /* BNE */
-        ret = gen_bcond(ctx, TCG_COND_NE, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_NE, ra, disp21);
         break;
     case 0x3E:
         /* BGE */
-        ret = gen_bcond(ctx, TCG_COND_GE, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_GE, ra, disp21);
         break;
     case 0x3F:
         /* BGT */
-        ret = gen_bcond(ctx, TCG_COND_GT, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_GT, ra, disp21);
         break;
     invalid_opc:
         ret = gen_invalid(ctx);
-- 
2.34.1


