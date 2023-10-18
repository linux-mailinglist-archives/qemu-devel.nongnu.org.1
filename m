Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB237CEAE4
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:02:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESm-0001yF-A4; Wed, 18 Oct 2023 17:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESU-0001Dc-Eb
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:07 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESS-0004Sm-NT
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:06 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b2ec5ee2e4so599734b6e.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665923; x=1698270723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=leH/P1FgQ25G4esAT7/kknyUp8v25189+bLSqs43GQs=;
 b=dvkbwgc1cFY360i28ZbAmMEoQJKuZ0JTit9L3s9dVSxmCgwY2hxKAv4rJxzp6npSpA
 2ObYaNgSZBn5OsvUDKxtY7gxIDNz90z/f4ypY3HpM+Hts4F0Yt4ccrBKnAmwtrPrCCf4
 6XtnseUexmFp2ryPf+eZSOYciI6IztQzOAgKaClMnOjogwXNm1piMjzbuejwxB5t8wMJ
 7NrgcPoTNxa3vuO4bfrCzkdwTmVx/muogIZc7Hn0HP5ZAcY2Umo17sFLbC/zLBqS5f5d
 9oZe7puIRiasYgnixIJue5JEykAFKycDlKv7boLR43vmLsNlzg5Jr9q0HgJZecpWjwka
 CqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665923; x=1698270723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=leH/P1FgQ25G4esAT7/kknyUp8v25189+bLSqs43GQs=;
 b=vH2g0/qKCa7jqSOpld097b/wQGEu83Ckp3LE5sLoN923BCFgYaVXvo/o5Ahro91VMw
 DxnteHiQYDf1bcj8vWLszZ1jRrS/wrroFcAs618Ev79PKdH3O7AX6IeXLA9Ms61U8aqy
 MAHtShHxFfiRFZ9AE69oheCsKKMrXu+BNTmkEyrSRIKXtt0KoQW8ah+hYy4aQLfa83j/
 SX7YKxBhYRopeddh6stjFDTjxL0p14WDKkb+/h/2tlwtpp9TD9bLvchRCh23AZGg1QYm
 B0KRWk+6KTY5+0P0IBl8A4UKj4sC7GoHhM9ctLR4x2/6TG3Nc7IUzEyttdRdLEhCVKjA
 iYqA==
X-Gm-Message-State: AOJu0YydpENlulBD2oXADrgV/uBImTMejy3ei01bwFD2KAPkCePLWqwG
 cmIy/ZjWcl44Ot/4wpdk6iW0uLi90zxldyF7og4=
X-Google-Smtp-Source: AGHT+IE3Op4ivM/oixIHfIyXapJJXNQzwO8JT4fh4sAA0qeqq1aLmc6tsqR9U4VLTAxP4zu1t+7t/Q==
X-Received: by 2002:a05:6808:1a1a:b0:3a8:4e27:3af3 with SMTP id
 bk26-20020a0568081a1a00b003a84e273af3mr532453oib.48.1697665923703; 
 Wed, 18 Oct 2023 14:52:03 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:52:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 32/61] target/hppa: Decode d for cmpclr instructions
Date: Wed, 18 Oct 2023 14:51:06 -0700
Message-Id: <20231018215135.1561375-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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
index ed00b58fbc..58d69cb748 100644
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


