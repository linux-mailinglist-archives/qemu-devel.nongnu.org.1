Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 445E87E341F
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:17:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRO-000413-Ss; Mon, 06 Nov 2023 22:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRL-0003xE-4K
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:43 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRJ-0001MN-6E
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:42 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5b980391d70so3939711a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326460; x=1699931260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=we3IFCWv2xg8MNB7vl19STMFoB0LdqgzaOSIdpBMD+0=;
 b=nJcjl7BHVUOoob6WcB4fmBWpDrCkylsJ4t9IxkuD+l/OoFh631kSoQaiXPLuI8MQpP
 dQq3RmPiuo0ZAgzwY2ZPxQL12AaiRWQLcC64pmQnnvXPp2RLDDyTSYqbxt2mtCcTgmae
 l5K5fuss9rO0mDbMZ7FxtV8dLBX/SQkC7woayPbBlO1a0mFcmE8gfVE4/5RIz9l62CAy
 8oPvh6i/q7JNSMHm14pBL7GhwDQH3XiYek3XNA4HD4TerwzuON6DOC3TKAscYc1+HtQq
 c3RHpXsA+mPr6ShmxmegnpXEdZpmMgmeWMXF+BXO5ed2Nmv8zvsmLSSwSugahSrXzq8j
 lX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326460; x=1699931260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=we3IFCWv2xg8MNB7vl19STMFoB0LdqgzaOSIdpBMD+0=;
 b=U444nmdSCC7MSEzqxKPIBmxh7wOs6cFGM3ih+yCsc19g6vcXveCn0GTZWZa5tN93Tm
 V4ulyKG1zaBNsz04uBaWfGgS/e4jA8ddceHvqs3yeilgcsTT4zJiadKCIpfbyaQopWky
 p18dWfHc67pcx3MHlHCRMBy3Iqt7wP3Ewy+oNM0WdnoaFE5CPlgtCWwccx28t7BbichC
 lbHq4AyrbeFSC6I2Fcjxst6/nxihWVuzfprAHkZfhSB5URV4iKsb1PuwMdwpHvVleGhB
 ZseXLSmQGQsZgB5xwhaObu3gmBYa/OcCcNBCIm7C6BE7nrEocgN7HYzt9ncr7Z0MP9l5
 P48Q==
X-Gm-Message-State: AOJu0YxgyUNTaus65pnGieKe99dhqAIgHieeXaIvYH0g9K0Nc3UtJ7pu
 mKvuAyDmlMfbGAyCHeDW+NM0GyA4fVf4ZFYR00A=
X-Google-Smtp-Source: AGHT+IEunI85EMooQGjY+aREl6g/9mYRB4f7pNICN4srmw4Hv2++MPiQBABH3MTYI2LyjeD54cXzDA==
X-Received: by 2002:a05:6a20:914a:b0:17e:87c1:7971 with SMTP id
 x10-20020a056a20914a00b0017e87c17971mr39916727pzc.46.1699326459755; 
 Mon, 06 Nov 2023 19:07:39 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/85] target/hppa: Decode d for sub instructions
Date: Mon,  6 Nov 2023 19:03:24 -0800
Message-Id: <20231107030407.8979-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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
 target/hppa/insns.decode | 12 ++++++------
 target/hppa/translate.c  | 22 +++++++++++-----------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 0f29869949..ad454adcbb 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -172,12 +172,12 @@ add_tsv         000010 ..... ..... .... 1110.. . .....  @rrr_cf_d_sh
 add_c           000010 ..... ..... .... 011100 . .....  @rrr_cf_d_sh0
 add_c_tsv       000010 ..... ..... .... 111100 . .....  @rrr_cf_d_sh0
 
-sub             000010 ..... ..... .... 010000 - .....  @rrr_cf
-sub_tsv         000010 ..... ..... .... 110000 0 .....  @rrr_cf
-sub_tc          000010 ..... ..... .... 010011 0 .....  @rrr_cf
-sub_tsv_tc      000010 ..... ..... .... 110011 0 .....  @rrr_cf
-sub_b           000010 ..... ..... .... 010100 0 .....  @rrr_cf
-sub_b_tsv       000010 ..... ..... .... 110100 0 .....  @rrr_cf
+sub             000010 ..... ..... .... 010000 . .....  @rrr_cf_d
+sub_tsv         000010 ..... ..... .... 110000 . .....  @rrr_cf_d
+sub_tc          000010 ..... ..... .... 010011 . .....  @rrr_cf_d
+sub_tsv_tc      000010 ..... ..... .... 110011 . .....  @rrr_cf_d
+sub_b           000010 ..... ..... .... 010100 . .....  @rrr_cf_d
+sub_b_tsv       000010 ..... ..... .... 110100 . .....  @rrr_cf_d
 
 ldil            001000 t:5 .....................        i=%assemble_21
 addil           001010 r:5 .....................        i=%assemble_21
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 2f5cc597ad..f2b2933c88 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1287,12 +1287,11 @@ static bool do_add_imm(DisasContext *ctx, arg_rri_cf *a,
 
 static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
                    TCGv_reg in2, bool is_tsv, bool is_b,
-                   bool is_tc, unsigned cf)
+                   bool is_tc, unsigned cf, bool d)
 {
     TCGv_reg dest, sv, cb, cb_msb, zero, tmp;
     unsigned c = cf >> 1;
     DisasCond cond;
-    bool d = false;
 
     dest = tcg_temp_new();
     cb = tcg_temp_new();
@@ -1350,7 +1349,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     ctx->null_cond = cond;
 }
 
-static bool do_sub_reg(DisasContext *ctx, arg_rrr_cf *a,
+static bool do_sub_reg(DisasContext *ctx, arg_rrr_cf_d *a,
                        bool is_tsv, bool is_b, bool is_tc)
 {
     TCGv_reg tcg_r1, tcg_r2;
@@ -1360,7 +1359,7 @@ static bool do_sub_reg(DisasContext *ctx, arg_rrr_cf *a,
     }
     tcg_r1 = load_gpr(ctx, a->r1);
     tcg_r2 = load_gpr(ctx, a->r2);
-    do_sub(ctx, a->t, tcg_r1, tcg_r2, is_tsv, is_b, is_tc, a->cf);
+    do_sub(ctx, a->t, tcg_r1, tcg_r2, is_tsv, is_b, is_tc, a->cf, a->d);
     return nullify_end(ctx);
 }
 
@@ -1373,7 +1372,8 @@ static bool do_sub_imm(DisasContext *ctx, arg_rri_cf *a, bool is_tsv)
     }
     tcg_im = tcg_constant_reg(a->i);
     tcg_r2 = load_gpr(ctx, a->r);
-    do_sub(ctx, a->t, tcg_im, tcg_r2, is_tsv, 0, 0, a->cf);
+    /* All SUBI conditions are 32-bit. */
+    do_sub(ctx, a->t, tcg_im, tcg_r2, is_tsv, 0, 0, a->cf, false);
     return nullify_end(ctx);
 }
 
@@ -2661,32 +2661,32 @@ static bool trans_add_c_tsv(DisasContext *ctx, arg_rrr_cf_d_sh *a)
     return do_add_reg(ctx, a, false, true, false, true);
 }
 
-static bool trans_sub(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_sub(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     return do_sub_reg(ctx, a, false, false, false);
 }
 
-static bool trans_sub_tsv(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_sub_tsv(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     return do_sub_reg(ctx, a, true, false, false);
 }
 
-static bool trans_sub_tc(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_sub_tc(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     return do_sub_reg(ctx, a, false, false, true);
 }
 
-static bool trans_sub_tsv_tc(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_sub_tsv_tc(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     return do_sub_reg(ctx, a, true, false, true);
 }
 
-static bool trans_sub_b(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_sub_b(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     return do_sub_reg(ctx, a, false, true, false);
 }
 
-static bool trans_sub_b_tsv(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_sub_b_tsv(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     return do_sub_reg(ctx, a, true, true, false);
 }
-- 
2.34.1


