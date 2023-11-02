Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 426EF7DEA21
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:36:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMb6-0006P0-BP; Wed, 01 Nov 2023 21:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMau-0006K5-IX
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:00 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMas-0001ue-Fb
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:00 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cacde97002so3129145ad.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888836; x=1699493636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLd8W3zal3J+slwE0L+I0m/NAcKeikLDIlYBd/HWxR0=;
 b=wpALjXFnp42Si7tKtYZZY5VDwqodObUyWdFmecX8iKygVnC6rw7xJbPiiAwzdjC7LL
 ZEOmNGRMJdVxnR78LjN7715dEyDXWzNsNnTX2/F1h3XRaNhzOonX0Zezz1S13fs9uKEc
 WF4nHhCQTXNW/EMUYGXCin6QjLvtH1wRaP4Sh1GITzfSxCr+j1FlH5VPo4yzjMp2eR/b
 WGbRGDUdXPkqywodOzjmmEaU+gy6br2Z12xo91NiZu6WJ8GlVPFo1crV59aifTH0o85p
 ndZnCGNhwfVE+0OnpC1eE2cYhJRSZcqs+WAQDavY0tJhN9ztAZC6ySevCONLow9Av0YL
 9qQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888836; x=1699493636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yLd8W3zal3J+slwE0L+I0m/NAcKeikLDIlYBd/HWxR0=;
 b=jKVGUKILaZW1UbCj27LYZgwNWthzIovV0dLJe9Xp3P7lyfYi3o6yMOO2rU1qj5p2v0
 uZpc80EM/uDDrr6pxHbJu2YjyLHtbZJmvMM/NFQbyVgtwgyEkHgiKmHqSypuFtA7KeMX
 quelQzBOmv58emhglsphn8Kr2/FTAbTllkFLYlbp7vRawKuUXC8YOigdoppSVbWnUyDQ
 CArT3aB3ZHjka+4icLqYr58iXDmLv4y+2zEgP5nXT9Wf1LLPB7ABd0ua51UDhqunav7t
 IeL6499rVSf+4vsujIg0ck+M4Vlp91j4dmW67fRfyZyVjTGOnBl9JXwnmGGfS2+yBzz8
 rtnw==
X-Gm-Message-State: AOJu0Yzzvrp+Z7kGlQIhFnEILhExbSljlyHM3RoT+GJ8Bhq+PYr4pbwy
 GXda14swFaSyHwzqJiZqz/1gHH8V9OPyIGp74xY=
X-Google-Smtp-Source: AGHT+IGNQwhfmj8Kl+ThsTk2I9AU7lko3yZsdTZd0ZnSQ4tgbWVplyCZqyscnJhnqH26wEyCpG7Vyw==
X-Received: by 2002:a17:902:f28b:b0:1ca:8169:e853 with SMTP id
 k11-20020a170902f28b00b001ca8169e853mr12631480plc.4.1698888836481; 
 Wed, 01 Nov 2023 18:33:56 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:33:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 43/88] target/hppa: Decode d for add instructions
Date: Wed,  1 Nov 2023 18:29:31 -0700
Message-Id: <20231102013016.369010-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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


