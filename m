Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E990C7CEA78
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:59:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESl-0001xc-Hz; Wed, 18 Oct 2023 17:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESV-0001JL-M2
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:07 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEST-0004Sx-OJ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:07 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3513b5a9e8eso30287375ab.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665924; x=1698270724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=biyRHnz4u+QbGENxZ1z6pneJoG8Ry2KV/Vovu130SIs=;
 b=PFFwe4pD5IdIY0Yvy88QZOg/uYLkkjfUQE3DPdCZG9WHsx7xUjCDE2YkzZF+xX24gh
 rIbYOfFGVOX6CxXKNPdtQt7rnyu6YEolJFA+QNtRacqQ7YzigxglOT+KBKoqJmmHkFMn
 OYUJcgsmlT50gUdGYoQGzMbwNkd6YD99M3M6vaspRHzLemAlaCa6paYsF4fnbPUfQdI4
 6Iqr+RSVMUP1JSR9+eI1alCXGSVf1vNcmcCWaxShtIMpKsu6aSiBPmhNVJu7q2iedafV
 as5sqQZq0wmxsyMuLc+uXhsgAf/2aOGITxk8pXvh5jqq3IzERtl8eDurCh5cl7PWAfq5
 l50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665924; x=1698270724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=biyRHnz4u+QbGENxZ1z6pneJoG8Ry2KV/Vovu130SIs=;
 b=G6iIn2P7tC9dS+cc4P1rZYEw7KMRYwHOklApIxQk/U4JoRYObot7yXjEEOsN9laeld
 3sQE1BssLlIEgFzAOUGHIglX0gzy9hb2VV2rLv8VSNzN/V+RykCXpZEtaoSgEJDmZjau
 mePrz+cG3X4g7hSDVRoLuepUJE/15zKx+awwqV/pne2BADInXmSuoDS7RKx2xJldd/Tt
 KVsXW5xjj4XAEiraZmuKKpMtmmnU5rZmBW88sMdcSSylF6dapdVpmxMkvVa9uWsMbgfA
 +zD2kyTtKkXxMwviHYlj3y5WzqM/63BuDGwL3786dWvy1odJF9FwAXsgEaFJF3JryCVU
 /Xnw==
X-Gm-Message-State: AOJu0YxWtLilVNlEahYhYk2c1iB92BI+QWA+lr0EPvAwNgfg1vc81xdi
 UHuHyvSL8HhSKsslfmtOgNVigGy1LYte8lY2/H4=
X-Google-Smtp-Source: AGHT+IGvW//SjTNMLNg5AYAMfDHGLHh5q5JlEeKK598ho5Oild0iuYkA3+EKPc734RUx+fdygv8jjA==
X-Received: by 2002:a92:c846:0:b0:352:609f:e4af with SMTP id
 b6-20020a92c846000000b00352609fe4afmr593675ilq.24.1697665924409; 
 Wed, 18 Oct 2023 14:52:04 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:52:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 33/61] target/hppa: Decode d for add instructions
Date: Wed, 18 Oct 2023 14:51:07 -0700
Message-Id: <20231018215135.1561375-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x132.google.com
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
index 58d69cb748..1bf61628d1 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1173,12 +1173,11 @@ static TCGv_reg do_sub_sv(DisasContext *ctx, TCGv_reg res,
 
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
@@ -1243,7 +1242,7 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     ctx->null_cond = cond;
 }
 
-static bool do_add_reg(DisasContext *ctx, arg_rrr_cf_sh *a,
+static bool do_add_reg(DisasContext *ctx, arg_rrr_cf_d_sh *a,
                        bool is_l, bool is_tsv, bool is_tc, bool is_c)
 {
     TCGv_reg tcg_r1, tcg_r2;
@@ -1253,7 +1252,8 @@ static bool do_add_reg(DisasContext *ctx, arg_rrr_cf_sh *a,
     }
     tcg_r1 = load_gpr(ctx, a->r1);
     tcg_r2 = load_gpr(ctx, a->r2);
-    do_add(ctx, a->t, tcg_r1, tcg_r2, a->sh, is_l, is_tsv, is_tc, is_c, a->cf);
+    do_add(ctx, a->t, tcg_r1, tcg_r2, a->sh, is_l,
+           is_tsv, is_tc, is_c, a->cf, a->d);
     return nullify_end(ctx);
 }
 
@@ -1267,7 +1267,8 @@ static bool do_add_imm(DisasContext *ctx, arg_rri_cf *a,
     }
     tcg_im = tcg_constant_reg(a->i);
     tcg_r2 = load_gpr(ctx, a->r);
-    do_add(ctx, a->t, tcg_im, tcg_r2, 0, 0, is_tsv, is_tc, 0, a->cf);
+    /* All ADDI conditions are 32-bit. */
+    do_add(ctx, a->t, tcg_im, tcg_r2, 0, 0, is_tsv, is_tc, 0, a->cf, false);
     return nullify_end(ctx);
 }
 
@@ -2614,27 +2615,27 @@ static bool trans_lci(DisasContext *ctx, arg_lci *a)
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


