Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 141C37E3418
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:16:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRQ-000429-6q; Mon, 06 Nov 2023 22:07:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRK-0003vc-Lr
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:42 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRI-0001MK-HT
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:42 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cc3bb4c307so42487565ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326459; x=1699931259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yLd8W3zal3J+slwE0L+I0m/NAcKeikLDIlYBd/HWxR0=;
 b=o0qPlQ/snkeHM5+A1Bh6QN2sjhjudxMfcB2CBoryOy2pyekt1VyDByvhyigGYRREJF
 nDJd+SI6G3LcE62yH78vjJ2zpeE7njB0FllXay2HoLgMiG43hGsireJuAOmvsGQf8dFP
 xwlmCs7W2Sm6FLk/MTtYVQYvWBEQ9Vz3Cb/P21Flxzm9E3pEsIFqACucmNrrIWRVAoaC
 zrQZCf8eBsFZKRMgR4B4FvN6qC41ZNRuGhKfLuCPve/ojEayZWI0PtX1+oeiBEZ5XRUX
 5V4PWXo0QtYEIgTJxfidwF1ZbAgB8g7XqvktnLrsLVvBSQF/Yq/rS0JCNnsuCgzQhclo
 PjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326459; x=1699931259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yLd8W3zal3J+slwE0L+I0m/NAcKeikLDIlYBd/HWxR0=;
 b=ZDTx5sxWIweQ4UBAh1HbeGtz+EWPK97v/EEDXBH7Mq8KXrueB5M1zB9/aFEB+U4ZDQ
 8X659XX9t+3WtrzAfxec61nqMB6Xmo3PC80Phjb27lA2oGl+oUuJTQ1ofGk/zyahJQGw
 d7Adi/iHrI58BgbZu62Ty53I/LLPnGAUVTKVuh7fUde173tqtTBmrWd2KuJz4iYiJg4B
 /a6KomeVnZlkgLpKeJrfoEwGB0vYLweqDyI1YTUyOtKqF+moXcy2xo0Re6MDYGAk2GKv
 WNzVv1+nblQzMJTHNPmuYodUpaKu1P7AAebRDJV94RE3QlGyrAAGlGvw64MC2l8BJJUY
 Fc1A==
X-Gm-Message-State: AOJu0Yw/3U1dM9UFovhpbor7KveXhuzilYL0UC1x5rhscS2wNiWVg2eX
 rNV7/7NqCzpb+OO0j9/TiHrRmNi7ni0lRjl3qKI=
X-Google-Smtp-Source: AGHT+IENqKHRbrjN5qP0bvhkPvClK7bnzHk6S8i+zDeTuWWJIXDzB9rp46maP5mc2vOAwj48gdMwqA==
X-Received: by 2002:a17:90b:4a84:b0:280:6b5b:3f40 with SMTP id
 lp4-20020a17090b4a8400b002806b5b3f40mr20356149pjb.8.1699326459093; 
 Mon, 06 Nov 2023 19:07:39 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/85] target/hppa: Decode d for add instructions
Date: Mon,  6 Nov 2023 19:03:23 -0800
Message-Id: <20231107030407.8979-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode | 16 ++++++++--------
 target/hppa/translate.c  | 21 +++++++++++----------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index d4a03b0299..0f29869949 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -62,7 +62,7 @@
 &rr_cf_d        t r cf d
 &rrr_cf         t r1 r2 cf
 &rrr_cf_d       t r1 r2 cf d
-&rrr_cf_sh      t r1 r2 cf sh
+&rrr_cf_d_sh    t r1 r2 cf d sh
 &rri_cf         t r i cf
 &rri_cf_d       t r i cf d
 
@@ -76,8 +76,8 @@
 @rr_cf_d        ...... r:5 ..... cf:4 ...... d:1 t:5    &rr_cf_d
 @rrr_cf         ...... r2:5 r1:5 cf:4 ....... t:5       &rrr_cf
 @rrr_cf_d       ...... r2:5 r1:5 cf:4 ...... d:1 t:5    &rrr_cf_d
-@rrr_cf_sh      ...... r2:5 r1:5 cf:4 .... sh:2 . t:5   &rrr_cf_sh
-@rrr_cf_sh0     ...... r2:5 r1:5 cf:4 ....... t:5       &rrr_cf_sh sh=0
+@rrr_cf_d_sh    ...... r2:5 r1:5 cf:4 .... sh:2 d:1 t:5 &rrr_cf_d_sh
+@rrr_cf_d_sh0   ...... r2:5 r1:5 cf:4 ...... d:1 t:5    &rrr_cf_d_sh sh=0
 @rri_cf         ...... r:5  t:5  cf:4 . ...........     &rri_cf i=%lowsign_11
 @rri_cf_d       ...... r:5  t:5  cf:4 d:1 ...........   &rri_cf_d i=%lowsign_11
 
@@ -166,11 +166,11 @@ uaddcm_tc       000010 ..... ..... .... 100111 . .....  @rrr_cf_d
 dcor            000010 ..... 00000 .... 101110 . .....  @rr_cf_d
 dcor_i          000010 ..... 00000 .... 101111 . .....  @rr_cf_d
 
-add             000010 ..... ..... .... 0110.. - .....  @rrr_cf_sh
-add_l           000010 ..... ..... .... 1010.. 0 .....  @rrr_cf_sh
-add_tsv         000010 ..... ..... .... 1110.. 0 .....  @rrr_cf_sh
-add_c           000010 ..... ..... .... 011100 0 .....  @rrr_cf_sh0
-add_c_tsv       000010 ..... ..... .... 111100 0 .....  @rrr_cf_sh0
+add             000010 ..... ..... .... 0110.. . .....  @rrr_cf_d_sh
+add_l           000010 ..... ..... .... 1010.. . .....  @rrr_cf_d_sh
+add_tsv         000010 ..... ..... .... 1110.. . .....  @rrr_cf_d_sh
+add_c           000010 ..... ..... .... 011100 . .....  @rrr_cf_d_sh0
+add_c_tsv       000010 ..... ..... .... 111100 . .....  @rrr_cf_d_sh0
 
 sub             000010 ..... ..... .... 010000 - .....  @rrr_cf
 sub_tsv         000010 ..... ..... .... 110000 0 .....  @rrr_cf
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8301d007ff..2f5cc597ad 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1186,12 +1186,11 @@ static TCGv_reg do_sub_sv(DisasContext *ctx, TCGv_reg res,
 
 static void do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1,
                    TCGv_reg in2, unsigned shift, bool is_l,
-                   bool is_tsv, bool is_tc, bool is_c, unsigned cf)
+                   bool is_tsv, bool is_tc, bool is_c, unsigned cf, bool d)
 {
     TCGv_reg dest, cb, cb_msb, cb_cond, sv, tmp;
     unsigned c = cf >> 1;
     DisasCond cond;
-    bool d = false;
 
     dest = tcg_temp_new();
     cb = NULL;
@@ -1256,7 +1255,7 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     ctx->null_cond = cond;
 }
 
-static bool do_add_reg(DisasContext *ctx, arg_rrr_cf_sh *a,
+static bool do_add_reg(DisasContext *ctx, arg_rrr_cf_d_sh *a,
                        bool is_l, bool is_tsv, bool is_tc, bool is_c)
 {
     TCGv_reg tcg_r1, tcg_r2;
@@ -1266,7 +1265,8 @@ static bool do_add_reg(DisasContext *ctx, arg_rrr_cf_sh *a,
     }
     tcg_r1 = load_gpr(ctx, a->r1);
     tcg_r2 = load_gpr(ctx, a->r2);
-    do_add(ctx, a->t, tcg_r1, tcg_r2, a->sh, is_l, is_tsv, is_tc, is_c, a->cf);
+    do_add(ctx, a->t, tcg_r1, tcg_r2, a->sh, is_l,
+           is_tsv, is_tc, is_c, a->cf, a->d);
     return nullify_end(ctx);
 }
 
@@ -1280,7 +1280,8 @@ static bool do_add_imm(DisasContext *ctx, arg_rri_cf *a,
     }
     tcg_im = tcg_constant_reg(a->i);
     tcg_r2 = load_gpr(ctx, a->r);
-    do_add(ctx, a->t, tcg_im, tcg_r2, 0, 0, is_tsv, is_tc, 0, a->cf);
+    /* All ADDI conditions are 32-bit. */
+    do_add(ctx, a->t, tcg_im, tcg_r2, 0, 0, is_tsv, is_tc, 0, a->cf, false);
     return nullify_end(ctx);
 }
 
@@ -2635,27 +2636,27 @@ static bool trans_lci(DisasContext *ctx, arg_lci *a)
     return true;
 }
 
-static bool trans_add(DisasContext *ctx, arg_rrr_cf_sh *a)
+static bool trans_add(DisasContext *ctx, arg_rrr_cf_d_sh *a)
 {
     return do_add_reg(ctx, a, false, false, false, false);
 }
 
-static bool trans_add_l(DisasContext *ctx, arg_rrr_cf_sh *a)
+static bool trans_add_l(DisasContext *ctx, arg_rrr_cf_d_sh *a)
 {
     return do_add_reg(ctx, a, true, false, false, false);
 }
 
-static bool trans_add_tsv(DisasContext *ctx, arg_rrr_cf_sh *a)
+static bool trans_add_tsv(DisasContext *ctx, arg_rrr_cf_d_sh *a)
 {
     return do_add_reg(ctx, a, false, true, false, false);
 }
 
-static bool trans_add_c(DisasContext *ctx, arg_rrr_cf_sh *a)
+static bool trans_add_c(DisasContext *ctx, arg_rrr_cf_d_sh *a)
 {
     return do_add_reg(ctx, a, false, false, false, true);
 }
 
-static bool trans_add_c_tsv(DisasContext *ctx, arg_rrr_cf_sh *a)
+static bool trans_add_c_tsv(DisasContext *ctx, arg_rrr_cf_d_sh *a)
 {
     return do_add_reg(ctx, a, false, true, false, true);
 }
-- 
2.34.1


