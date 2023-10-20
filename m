Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9867D173B
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:45:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLw-0007um-Nb; Fri, 20 Oct 2023 16:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLm-0007m3-Sv
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:09 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLj-0008F4-Rp
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:06 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6b20577ef7bso1113630b3a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834642; x=1698439442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RtqIFNm6JjPbDP1RVyPhidWGrmrDl/GX/xTGUiTer8g=;
 b=uA58pNXWtD02Ng/+CnCHNGa8nkqbSOGJ0JssvAKCOulAfv/KIvtlmkBskGdudbTNj8
 Y6GJvtGUUAwbYcTs7QTHZihMghEIhVEQE/oAjdPPrvB/Qwvht3xcsJHLs/3BfXRAllnP
 vtPiAuz+PD51XvnSdP+1Gsu/rj6BAfV//xBi0lpdHUHhcO/To3lQXvrJu2e/duQwm8mG
 NcewO0O7jjI4yExvQz7GLgLq6rYFku7ZvDhMaVbNe6NAaI665rg++UxuBvAZoLGQuF6X
 xPJ6bNSCRbyAS0qEpM9FsRgHaBxqQeludsp++OBLgIgC1CohlaxGmSBvuYzyHXh9IClx
 YNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834642; x=1698439442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RtqIFNm6JjPbDP1RVyPhidWGrmrDl/GX/xTGUiTer8g=;
 b=eTC3Ok0Akb++m3NEZnQkr+wCe39Hj69HTH/bnBHXQcjgrAObPlbF2HW0bDgOEKZi6P
 EwnaWdKU3vL6TyjWKeLcCqO6nVzHCpmekXT44dEQ9QzhkxNQZeszwu1JPWG+7K4l64Yv
 LTp5FNjFHwHfC0VPJNnkABNvAeQHecX+sL2BQQyyWJYDgcRznfBrJVZBoFAV8YQj7kf3
 MRw9eORPlrPWATVZ6T3xealJ2dL2D2InaC9Iv3r4I8jzhOCYy3wdg6gLqWvjq7UlJn3l
 6qzneGs+g2KmgPZeBxN6QVODPlZCu5eoN66ibD4oOPZrZjJe+cdhS9cAoehmtFqR3zHv
 t9hg==
X-Gm-Message-State: AOJu0YwVaohVv/psKVN9KYj3vwb3IUd2bcuc+L3xb569SR4gr5mlqB+S
 Iu2cvvMiZMY0lUu+FqA8/E1viNOGKqkWqr4LKTk=
X-Google-Smtp-Source: AGHT+IFkN5S/KSeX5qPnbxN7AvdQaXFgNAWc26/pogj0h9+Pgd7q5zjpxl7zz6XuEeHUx6BCxMFLzw==
X-Received: by 2002:a05:6a21:4982:b0:16b:80f2:f30c with SMTP id
 ax2-20020a056a21498200b0016b80f2f30cmr2655887pzc.26.1697834642154; 
 Fri, 20 Oct 2023 13:44:02 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:44:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 32/65] target/hppa: Decode d for cmpclr instructions
Date: Fri, 20 Oct 2023 13:42:58 -0700
Message-Id: <20231020204331.139847-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
 target/hppa/insns.decode |  6 ++++--
 target/hppa/translate.c  | 11 +++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 03b1a11cac..d4a03b0299 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -64,6 +64,7 @@
 &rrr_cf_d       t r1 r2 cf d
 &rrr_cf_sh      t r1 r2 cf sh
 &rri_cf         t r i cf
+&rri_cf_d       t r i cf d
 
 &rrb_c_f        disp n c f r1 r2
 &rib_c_f        disp n c f r i
@@ -78,6 +79,7 @@
 @rrr_cf_sh      ...... r2:5 r1:5 cf:4 .... sh:2 . t:5   &rrr_cf_sh
 @rrr_cf_sh0     ...... r2:5 r1:5 cf:4 ....... t:5       &rrr_cf_sh sh=0
 @rri_cf         ...... r:5  t:5  cf:4 . ...........     &rri_cf i=%lowsign_11
+@rri_cf_d       ...... r:5  t:5  cf:4 d:1 ...........   &rri_cf_d i=%lowsign_11
 
 @rrb_cf         ...... r2:5 r1:5 c:3 ........... n:1 .  \
                 &rrb_c_f disp=%assemble_12
@@ -158,7 +160,7 @@ or              000010 ..... ..... .... 001001 . .....  @rrr_cf_d
 xor             000010 ..... ..... .... 001010 . .....  @rrr_cf_d
 uxor            000010 ..... ..... .... 001110 . .....  @rrr_cf_d
 ds              000010 ..... ..... .... 010001 0 .....  @rrr_cf
-cmpclr          000010 ..... ..... .... 100010 0 .....  @rrr_cf
+cmpclr          000010 ..... ..... .... 100010 . .....  @rrr_cf_d
 uaddcm          000010 ..... ..... .... 100110 . .....  @rrr_cf_d
 uaddcm_tc       000010 ..... ..... .... 100111 . .....  @rrr_cf_d
 dcor            000010 ..... 00000 .... 101110 . .....  @rr_cf_d
@@ -189,7 +191,7 @@ addi_tc_tsv     101100 ..... ..... .... 1 ...........   @rri_cf
 subi            100101 ..... ..... .... 0 ...........   @rri_cf
 subi_tsv        100101 ..... ..... .... 1 ...........   @rri_cf
 
-cmpiclr         100100 ..... ..... .... 0 ...........   @rri_cf
+cmpiclr         100100 ..... ..... .... . ...........   @rri_cf_d
 
 ####
 # Index Mem
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index c08156772a..4bc00d5bc6 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1364,11 +1364,10 @@ static bool do_sub_imm(DisasContext *ctx, arg_rri_cf *a, bool is_tsv)
 }
 
 static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
-                      TCGv_reg in2, unsigned cf)
+                      TCGv_reg in2, unsigned cf, bool d)
 {
     TCGv_reg dest, sv;
     DisasCond cond;
-    bool d = false;
 
     dest = tcg_temp_new();
     tcg_gen_sub_reg(dest, in1, in2);
@@ -2737,7 +2736,7 @@ static bool trans_xor(DisasContext *ctx, arg_rrr_cf_d *a)
     return do_log_reg(ctx, a, tcg_gen_xor_reg);
 }
 
-static bool trans_cmpclr(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_cmpclr(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     TCGv_reg tcg_r1, tcg_r2;
 
@@ -2746,7 +2745,7 @@ static bool trans_cmpclr(DisasContext *ctx, arg_rrr_cf *a)
     }
     tcg_r1 = load_gpr(ctx, a->r1);
     tcg_r2 = load_gpr(ctx, a->r2);
-    do_cmpclr(ctx, a->t, tcg_r1, tcg_r2, a->cf);
+    do_cmpclr(ctx, a->t, tcg_r1, tcg_r2, a->cf, a->d);
     return nullify_end(ctx);
 }
 
@@ -2904,7 +2903,7 @@ static bool trans_subi_tsv(DisasContext *ctx, arg_rri_cf *a)
     return do_sub_imm(ctx, a, true);
 }
 
-static bool trans_cmpiclr(DisasContext *ctx, arg_rri_cf *a)
+static bool trans_cmpiclr(DisasContext *ctx, arg_rri_cf_d *a)
 {
     TCGv_reg tcg_im, tcg_r2;
 
@@ -2914,7 +2913,7 @@ static bool trans_cmpiclr(DisasContext *ctx, arg_rri_cf *a)
 
     tcg_im = tcg_constant_reg(a->i);
     tcg_r2 = load_gpr(ctx, a->r);
-    do_cmpclr(ctx, a->t, tcg_im, tcg_r2, a->cf);
+    do_cmpclr(ctx, a->t, tcg_im, tcg_r2, a->cf, a->d);
 
     return nullify_end(ctx);
 }
-- 
2.34.1


