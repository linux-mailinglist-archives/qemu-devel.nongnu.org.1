Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A19B7CEA4D
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:53:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESh-0001mt-SE; Wed, 18 Oct 2023 17:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtES7-0000jI-Rj
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:44 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtES5-0004N9-Pz
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:43 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b20577ef7bso4648803b3a.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665900; x=1698270700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNZMizemvrujc4XnqyNiXy5WpOSPf3XvMMBFfWR0das=;
 b=ayD/AAtZT34aCcjfvcAfIBSySIo5sKo7Ud8EWRzKvQUDmEspuENEqvZkMuykwdzsIk
 LRshcKvTqUAi0bd6jdINf9o8lgA4HBUqxxjB4v382KpO4SNhfaD8hxD4AkFB/EQe534H
 SdmRkraKkvPrCHAzP1Z0Ah5flfv/Nf9GwG+5sgcOIbzxOK8dPT4eOvSsOTQU9W/rLD42
 dSf43fO6P/cyHyM8sXgwT++mJGii5blzrap5Gqgk/2ke/HMGy9cm4IGTHEVMKneuIKSH
 j6FfOjvkgbtxopoEkoROZiG5Bb/aQp926mjiLEMJIVunEXGeic/lH7QDil9PUFTgwKjn
 YlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665900; x=1698270700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mNZMizemvrujc4XnqyNiXy5WpOSPf3XvMMBFfWR0das=;
 b=kclm7fy9gPV4PHLc+1nhVEL2DAKtGSg1sJByEpI/JHvQppEIJje2XSPRgJazdu259c
 t/BP6dQ3paJp65QAIAZ+bp5wc+9ZZLHp/emyegfPlVjvol7JZ9At0Bmu5tqfMfRoyRpJ
 jbEA9ic4OJEORR9KfKXYQdD031OTzRfIlAzrSAR9F7uCb5mSEs73LBQdKH0Nh9RyGb94
 qCBFJAGgspYmF6TpRTaB/T5p2sUfiL2DWbgum3N8//KruHPb7+zENOO7+x2W69m7Vqz2
 4OrcLjz+KyWIycEaaUGSYvYPOi/M2eJV8vwC0PAIYGZaV3wBXReDCn092aTz56nEaPRo
 KbxA==
X-Gm-Message-State: AOJu0YyI4s70w1xHu0AbwgOehq6XUV0PfPeAELyrFLOhF3DFkJnadEYz
 iDavSww90F33/r8lVNeItc6WZFZcLko4OqBLlkY=
X-Google-Smtp-Source: AGHT+IHahDbi6lQUK9pwmuToqzheubshgSDWDjq+UHLUFqHkr9+JhiWiZ1TWJnu94iCg8WKiMuCgVA==
X-Received: by 2002:a62:5e05:0:b0:690:2e46:aca3 with SMTP id
 s5-20020a625e05000000b006902e46aca3mr327818pfb.25.1697665900218; 
 Wed, 18 Oct 2023 14:51:40 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 04/61] target/hppa: Remove load_const
Date: Wed, 18 Oct 2023 14:50:38 -0700
Message-Id: <20231018215135.1561375-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Replace with tcg_constant_reg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 5302381a56..21f97f63a9 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -488,13 +488,6 @@ static void cond_free(DisasCond *cond)
     }
 }
 
-static TCGv_reg load_const(DisasContext *ctx, target_sreg v)
-{
-    TCGv_reg t = tcg_temp_new();
-    tcg_gen_movi_reg(t, v);
-    return t;
-}
-
 static TCGv_reg load_gpr(DisasContext *ctx, unsigned reg)
 {
     if (reg == 0) {
@@ -1164,7 +1157,7 @@ static bool do_add_imm(DisasContext *ctx, arg_rri_cf *a,
     if (a->cf) {
         nullify_over(ctx);
     }
-    tcg_im = load_const(ctx, a->i);
+    tcg_im = tcg_constant_reg(a->i);
     tcg_r2 = load_gpr(ctx, a->r);
     do_add(ctx, a->t, tcg_im, tcg_r2, 0, 0, is_tsv, is_tc, 0, a->cf);
     return nullify_end(ctx);
@@ -1253,7 +1246,7 @@ static bool do_sub_imm(DisasContext *ctx, arg_rri_cf *a, bool is_tsv)
     if (a->cf) {
         nullify_over(ctx);
     }
-    tcg_im = load_const(ctx, a->i);
+    tcg_im = tcg_constant_reg(a->i);
     tcg_r2 = load_gpr(ctx, a->r);
     do_sub(ctx, a->t, tcg_im, tcg_r2, is_tsv, 0, 0, a->cf);
     return nullify_end(ctx);
@@ -2808,7 +2801,7 @@ static bool trans_cmpiclr(DisasContext *ctx, arg_rri_cf *a)
         nullify_over(ctx);
     }
 
-    tcg_im = load_const(ctx, a->i);
+    tcg_im = tcg_constant_reg(a->i);
     tcg_r2 = load_gpr(ctx, a->r);
     do_cmpclr(ctx, a->t, tcg_im, tcg_r2, a->cf);
 
@@ -2994,7 +2987,7 @@ static bool trans_cmpb(DisasContext *ctx, arg_cmpb *a)
 static bool trans_cmpbi(DisasContext *ctx, arg_cmpbi *a)
 {
     nullify_over(ctx);
-    return do_cmpb(ctx, a->r, load_const(ctx, a->i), a->c, a->f, a->n, a->disp);
+    return do_cmpb(ctx, a->r, tcg_constant_reg(a->i), a->c, a->f, a->n, a->disp);
 }
 
 static bool do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
@@ -3033,7 +3026,7 @@ static bool trans_addb(DisasContext *ctx, arg_addb *a)
 static bool trans_addbi(DisasContext *ctx, arg_addbi *a)
 {
     nullify_over(ctx);
-    return do_addb(ctx, a->r, load_const(ctx, a->i), a->c, a->f, a->n, a->disp);
+    return do_addb(ctx, a->r, tcg_constant_reg(a->i), a->c, a->f, a->n, a->disp);
 }
 
 static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
@@ -3345,7 +3338,7 @@ static bool trans_depwi_sar(DisasContext *ctx, arg_depwi_sar *a)
     if (a->c) {
         nullify_over(ctx);
     }
-    return do_depw_sar(ctx, a->t, a->c, a->nz, a->clen, load_const(ctx, a->i));
+    return do_depw_sar(ctx, a->t, a->c, a->nz, a->clen, tcg_constant_reg(a->i));
 }
 
 static bool trans_be(DisasContext *ctx, arg_be *a)
@@ -3852,7 +3845,7 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
             return true;
         }
         if (inv) {
-            TCGv_reg c = load_const(ctx, mask);
+            TCGv_reg c = tcg_constant_reg(mask);
             tcg_gen_or_reg(t, t, c);
             ctx->null_cond = cond_make(TCG_COND_EQ, t, c);
         } else {
-- 
2.34.1


