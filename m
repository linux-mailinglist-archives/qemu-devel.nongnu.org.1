Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 770AA7CEA60
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:57:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESo-00022w-6o; Wed, 18 Oct 2023 17:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESW-0001L6-28
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:09 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESU-0004TB-7r
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:07 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-57b9231e91dso4348205eaf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665925; x=1698270725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hXC/m2cfeyFglevkvGf9SMDY8blHKSFBgtiFx7rF8fg=;
 b=EpHMntBBXgGi5lI9p1l3KsFWotYu2aiea7RKVH/bHdkOPWe7VaXHTzyefjqxeGCY0L
 GRJi5IgujTNuibVbgAQH9dLQEF67UJAd30JIxeJvch1sOr1NpXZZ2wag49TWw2fnpSk3
 689WRr86XxXjC0l8IL5D5/clYaRWEl5zvTyDhrI1NBFV13TP8cMSuJmkb74OqzjtfzkA
 vMqT6BTe8GdFDm5+dNK9hdLmC8COVGskN8lmj03aUfsc0vEnHnn1yHdAanoms2tFMcTX
 6sQj8Xl6Vp80ky9Z6UVpxUKiiLe/MQ8NRAALfi8LYHKbZRYnpFMiOlNtVDA5ojeQj587
 TTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665925; x=1698270725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hXC/m2cfeyFglevkvGf9SMDY8blHKSFBgtiFx7rF8fg=;
 b=CnMfy5o55GmEY+abUB7DY2/HBD4fxjWL7/201nIHV+3sjeR6nUWD0xtWxFxHJNu57T
 4gEwbs+xviTZLxxIacRZvKyX4gSZrQotcubdwxVD9kkUHdg1PbnJG2iUlnZvOuov8Ers
 VmO79uQzFpdwsmUlA5fumA7sDcj4erm9b3rfHODRsD4V7X3HwhLLS0Gy1+ECJf1pitJT
 PETL+SfpOsUTPeUqIR4x4bEDRLPjFsBoMJTFwDdqocXH7WhXUAvOTkZwrX/mWUcIELv0
 oUQ+2+DkcjDxdQbnTOj9tgHo8MAmLTLc94XE2vmkvFmgH0aeYvAoEhfyOkz/K1y8KYmR
 9p9g==
X-Gm-Message-State: AOJu0YxasFATSKh5dd5yJrPyF/U8JWN/OkQN9qhGBEjqYy/py0shHw64
 /O/oUJcc6A3Ppg68+KGBZe7dtRrGLMEl6cEdbLo=
X-Google-Smtp-Source: AGHT+IHenVrZoLVUCa0h/NddpPpofPc2CR1Ko6L92IabM5b3hhY1GfgjthxJr32MOlDYWFY84667Jw==
X-Received: by 2002:a05:6359:3015:b0:164:953b:35a9 with SMTP id
 rf21-20020a056359301500b00164953b35a9mr217504rwb.23.1697665925071; 
 Wed, 18 Oct 2023 14:52:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:52:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 34/61] target/hppa: Decode d for sub instructions
Date: Wed, 18 Oct 2023 14:51:08 -0700
Message-Id: <20231018215135.1561375-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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
index 1bf61628d1..e21a206466 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1274,12 +1274,11 @@ static bool do_add_imm(DisasContext *ctx, arg_rri_cf *a,
 
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
@@ -1337,7 +1336,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     ctx->null_cond = cond;
 }
 
-static bool do_sub_reg(DisasContext *ctx, arg_rrr_cf *a,
+static bool do_sub_reg(DisasContext *ctx, arg_rrr_cf_d *a,
                        bool is_tsv, bool is_b, bool is_tc)
 {
     TCGv_reg tcg_r1, tcg_r2;
@@ -1347,7 +1346,7 @@ static bool do_sub_reg(DisasContext *ctx, arg_rrr_cf *a,
     }
     tcg_r1 = load_gpr(ctx, a->r1);
     tcg_r2 = load_gpr(ctx, a->r2);
-    do_sub(ctx, a->t, tcg_r1, tcg_r2, is_tsv, is_b, is_tc, a->cf);
+    do_sub(ctx, a->t, tcg_r1, tcg_r2, is_tsv, is_b, is_tc, a->cf, a->d);
     return nullify_end(ctx);
 }
 
@@ -1360,7 +1359,8 @@ static bool do_sub_imm(DisasContext *ctx, arg_rri_cf *a, bool is_tsv)
     }
     tcg_im = tcg_constant_reg(a->i);
     tcg_r2 = load_gpr(ctx, a->r);
-    do_sub(ctx, a->t, tcg_im, tcg_r2, is_tsv, 0, 0, a->cf);
+    /* All SUBI conditions are 32-bit. */
+    do_sub(ctx, a->t, tcg_im, tcg_r2, is_tsv, 0, 0, a->cf, false);
     return nullify_end(ctx);
 }
 
@@ -2640,32 +2640,32 @@ static bool trans_add_c_tsv(DisasContext *ctx, arg_rrr_cf_d_sh *a)
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


