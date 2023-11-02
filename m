Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C82E17DEA5D
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:46:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMbD-0006VD-1o; Wed, 01 Nov 2023 21:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMau-0006K6-Jt
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:00 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMar-0001uW-D4
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:00 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc30bf9e22so3685745ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888836; x=1699493636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQKqVWPtgxXGrzYjTuQHxTd6qyqCynIOEiRaLSJd7Dw=;
 b=SsGvkUDv2Vp3254YMNwPHbQtqOenG/DnwtTl/gxfbdzIX90NGKjVIncn/t4j2g+w8A
 QGZW7B9ZUQbEInPEjh2737urDOKDcjNvBLiFlNCEQNt67wgx+8Nn0SzXi7twgMheNwvv
 sCuxlZ7fjIixv+DyrCs3JssYoFXTzJaCWLn2SO31WVBIyu7YVOBUvnIGi1avf4iv343n
 vmtbU0CWhE9JWPY2NxB4yF5rtNYdHqbsVwlPAhji26ESodqVNs+dIf0eUrDH4WM0F/Wu
 FCS6Mxw+/gqtfRRPlyzcEbkWvSRFza9BIYP7GKVuW3pjpizOcmV9mHqTlJk4XAs0Whlw
 0WYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888836; x=1699493636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RQKqVWPtgxXGrzYjTuQHxTd6qyqCynIOEiRaLSJd7Dw=;
 b=mgE+RUZpC/BffuYH/IkX5R2wK7/B5K/+c3cFrbEPYNTJOfeQFYXBSHPiJ4oKK+b9R/
 f6fMXAAiFHdgmposjsYB3HjzdHKxVf++KnNXO2DA/VtHEOkALFQ9MAUIjlYcB+BNJ3bc
 yM0alS6HBdx8JfrrqzEVOQ3OaoP4aTtvSIKniY0F78L7zieEmYt8hMEyf3qW/gZmuKZ8
 9PUbfkTb6IvGrGZj7ENwTjF8GNQ0NmY/2sXszIUNPf/LCOnGGtC0yAgFGiHdxgPi41Co
 NUI+wYPVEi3e8GLfoKwmqJvYZoZJRz7RsyU6mzaEBsJO9XRtDavZtPfqvLIPFbU4i7Dw
 edYg==
X-Gm-Message-State: AOJu0YwVbsWqjvl0XIznxrz0J3U6DJgASxIw/MGbQ71Oj92MNLSR6fVH
 96FdmQRZQQQmMqqMpWmjyimMWFt9KX4C8BQDnbA=
X-Google-Smtp-Source: AGHT+IGPE9JYXE4clP/g+jnNf88uamVsTnIFTLJmaz2kgN8zhnKQ6+5tbYnvutGcI/h7KbLTc+5gYQ==
X-Received: by 2002:a17:902:e848:b0:1c2:193e:1126 with SMTP id
 t8-20020a170902e84800b001c2193e1126mr9708350plg.28.1698888835765; 
 Wed, 01 Nov 2023 18:33:55 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:33:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 42/88] target/hppa: Decode d for cmpclr instructions
Date: Wed,  1 Nov 2023 18:29:30 -0700
Message-Id: <20231102013016.369010-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
index a0785bb32c..8301d007ff 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1377,11 +1377,10 @@ static bool do_sub_imm(DisasContext *ctx, arg_rri_cf *a, bool is_tsv)
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
@@ -2758,7 +2757,7 @@ static bool trans_xor(DisasContext *ctx, arg_rrr_cf_d *a)
     return do_log_reg(ctx, a, tcg_gen_xor_reg);
 }
 
-static bool trans_cmpclr(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_cmpclr(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     TCGv_reg tcg_r1, tcg_r2;
 
@@ -2767,7 +2766,7 @@ static bool trans_cmpclr(DisasContext *ctx, arg_rrr_cf *a)
     }
     tcg_r1 = load_gpr(ctx, a->r1);
     tcg_r2 = load_gpr(ctx, a->r2);
-    do_cmpclr(ctx, a->t, tcg_r1, tcg_r2, a->cf);
+    do_cmpclr(ctx, a->t, tcg_r1, tcg_r2, a->cf, a->d);
     return nullify_end(ctx);
 }
 
@@ -2925,7 +2924,7 @@ static bool trans_subi_tsv(DisasContext *ctx, arg_rri_cf *a)
     return do_sub_imm(ctx, a, true);
 }
 
-static bool trans_cmpiclr(DisasContext *ctx, arg_rri_cf *a)
+static bool trans_cmpiclr(DisasContext *ctx, arg_rri_cf_d *a)
 {
     TCGv_reg tcg_im, tcg_r2;
 
@@ -2935,7 +2934,7 @@ static bool trans_cmpiclr(DisasContext *ctx, arg_rri_cf *a)
 
     tcg_im = tcg_constant_reg(a->i);
     tcg_r2 = load_gpr(ctx, a->r);
-    do_cmpclr(ctx, a->t, tcg_im, tcg_r2, a->cf);
+    do_cmpclr(ctx, a->t, tcg_im, tcg_r2, a->cf, a->d);
 
     return nullify_end(ctx);
 }
-- 
2.34.1


