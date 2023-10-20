Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E2A7D1764
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:48:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwM4-0007yS-Mh; Fri, 20 Oct 2023 16:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLo-0007mI-7E
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:09 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLm-0008Fs-1n
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:07 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b1ef786b7fso1158017b3a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834643; x=1698439443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObJx9R3yQ+h7Sn6gc+ZiKm70o/Xu9BpZYR8uMzdovJM=;
 b=UZeZdT0SL6Z4pnZGvumKS5+J9vgcCojhoHs4pO0o1CMmDAS99ZC/WaeM2+ar1ocZpA
 d9ECzerkBnRsq33UvRiCl/Tmr1LR8PJ9msy/D8YLFZ542E6pajdrze8VatwVvHdls9n+
 vfiVqwFTLkFA3UM7KnmKypFQ9HO3rdSKhwbCmaeC5QaXcmIK29Puto2bki4dhKZhoGLg
 NeIB15jmGhUvUyTXp8cWY2v7hhdJPBbFJ7z5jR5bGKz0moPbFDNmZqX2Lu6AC0QRJID5
 qbJ/5Quq8nhSg8+ccrL2ygG4q9dHNYDXM1stc3OH1F3PrB4hmrhpuIQiaHvYsqkzWeXR
 23ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834643; x=1698439443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ObJx9R3yQ+h7Sn6gc+ZiKm70o/Xu9BpZYR8uMzdovJM=;
 b=lrTwo/w+p97pGj98o86VOfCwZefxVcrlib5U1W8tVc7Hp5Qm4wdF5poNOHYaCvoerl
 b2AVtXX1l3j0YAoT54yudAgMMN1DCl5berg32JBOJZ5jhpeNRzPyII06v/R/Hc6+zmRk
 ZAUQ3HA/0L/2lHZxayhkP8GbTsJYn4m0SarFw3fOMsF4Sw8UCx7j2T3lXw/rmlDqdD/l
 Bsob3Lvoq3w0E5jhdwiDh0YDOQ4tbM2Ja8FJn9/C8rJAMxC1cjDxyBMLEVcByML2lpJO
 4ZXmm2KiED5SR4SDEIofrI7Nmmt4EDiHYpdTLbKYawQwCAhfNcuA1WwdtYeAnBAvxBlU
 ezrQ==
X-Gm-Message-State: AOJu0YxYGpRGOLPU0+W0xJ3XJmzHKctBcXeWM3D7KaYypZ0isetbL0eO
 8H62w3xoCwm/tmNK1/yVGDu3tIERsXfHs1tbdWI=
X-Google-Smtp-Source: AGHT+IFfxseF6MGI4tCvpKb09+ohglef95XgMQldqqH+/9SLRX+ScbPbBNpxSaxJhLfi1FkAcpN5Zw==
X-Received: by 2002:a05:6a20:4c95:b0:16b:c9f2:b632 with SMTP id
 fq21-20020a056a204c9500b0016bc9f2b632mr2476251pzb.62.1697834643675; 
 Fri, 20 Oct 2023 13:44:03 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:44:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 34/65] target/hppa: Decode d for sub instructions
Date: Fri, 20 Oct 2023 13:43:00 -0700
Message-Id: <20231020204331.139847-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
index 50be7df76c..df5a6dc896 100644
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


