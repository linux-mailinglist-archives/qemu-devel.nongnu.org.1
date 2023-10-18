Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9467CEA52
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:53:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESf-0001m6-5n; Wed, 18 Oct 2023 17:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEST-0001A3-92
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:05 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESR-0004SL-G2
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:04 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-565e54cb93aso4818279a12.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665922; x=1698270722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+FXcWCsrSL2FX31DZnJU2ioV2yMKndFqHewFvzyUsw=;
 b=lgy7Il3TIq+gVyQ+DvUMkLxm91MDsPP8vDPoi6PFrGCJQTREtHyJGr66rvlE1KZgWR
 4GWh0HVKNEIshTgSS30mS8yyqt86ZTt84O1e9gbVfP4FLJlEgHiP/zj3JUQodpq9Dp2i
 Xr8zPyV8jvrHl9NBxSM9uWpCO8eJYRW8b3u9cgulw8mz3s3oQZJ3dUv+932WhcgPcYPp
 w+nV8hV71tknSiix3NuF6AhPuyY5QlGHOeKRpJdZfS0nxzHGu9yvSCq3ODj82srmJOuk
 JZhh6jDiNzL8nlrX+66YhkCXN1qcT+xJVYeAjJpe3JXtRA1zRFsOi1KSl7fiKKTnUxNo
 lYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665922; x=1698270722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+FXcWCsrSL2FX31DZnJU2ioV2yMKndFqHewFvzyUsw=;
 b=sGtDcnG7B6Q/C43E6Tuv+Tx9gfaeVvDFa+66FVGhqXm7U+ry4JMeDEfPCveQXBq42R
 8CloqHva+T+z0f4s9NW+mO4Y77qhotxcJeyshWBjwtsJoIDsjVUnnTYNAmrqdS/uu6jX
 Z19kt4W5ypjoasrUOdNwrpIihAJQsM7MynEs5wFMmHoL3iLXemutSCSrNB1XBIyxd5/Y
 f0deY+/BO6FlnMQCB1FcmA+JLOkVBZ0DFFDju4OWUb/m+vyPPfEmj1V0cHSrJjFPed0I
 vqmLvXwdCiHw7V+9xsEJ4865qfg8fK6ePPK2DlGV/bqIM86rQ8G8hE9Y4eAA6EXkf5+1
 RlRQ==
X-Gm-Message-State: AOJu0YwqQJYBjV9tFoX2kpq0Mr6gJ+QJ91mPX4xTRN7B5FNhl9punbbF
 DRBloNI3BRU4zlHx8N/P9O2ENISPohEKmRQ6z/o=
X-Google-Smtp-Source: AGHT+IE9VEVGt9sMBYRW3N27uD13qjYZxfxhTZRMuIyWGrZ+y6El9DYjPFlh7YmUWJfxJkyX9L6sSQ==
X-Received: by 2002:a05:6a20:4387:b0:15d:42d5:6cb5 with SMTP id
 i7-20020a056a20438700b0015d42d56cb5mr499007pzl.28.1697665922034; 
 Wed, 18 Oct 2023 14:52:02 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:52:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 30/61] target/hppa: Decode d for logical instructions
Date: Wed, 18 Oct 2023 14:51:04 -0700
Message-Id: <20231018215135.1561375-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
 target/hppa/insns.decode | 10 ++++++----
 target/hppa/translate.c  | 15 +++++++--------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index aebe03ccfd..26ca9f1063 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -61,6 +61,7 @@
 
 &rr_cf          t r cf
 &rrr_cf         t r1 r2 cf
+&rrr_cf_d       t r1 r2 cf d
 &rrr_cf_sh      t r1 r2 cf sh
 &rri_cf         t r i cf
 
@@ -73,6 +74,7 @@
 
 @rr_cf          ...... r:5 ..... cf:4 ....... t:5       &rr_cf
 @rrr_cf         ...... r2:5 r1:5 cf:4 ....... t:5       &rrr_cf
+@rrr_cf_d       ...... r2:5 r1:5 cf:4 ...... d:1 t:5    &rrr_cf_d
 @rrr_cf_sh      ...... r2:5 r1:5 cf:4 .... sh:2 . t:5   &rrr_cf_sh
 @rrr_cf_sh0     ...... r2:5 r1:5 cf:4 ....... t:5       &rrr_cf_sh sh=0
 @rri_cf         ...... r:5  t:5  cf:4 . ...........     &rri_cf i=%lowsign_11
@@ -150,10 +152,10 @@ lci             000001 ----- ----- -- 01001100 0 t:5
 # Arith/Log
 ####
 
-andcm           000010 ..... ..... .... 000000 - .....  @rrr_cf
-and             000010 ..... ..... .... 001000 - .....  @rrr_cf
-or              000010 ..... ..... .... 001001 - .....  @rrr_cf
-xor             000010 ..... ..... .... 001010 0 .....  @rrr_cf
+andcm           000010 ..... ..... .... 000000 . .....  @rrr_cf_d
+and             000010 ..... ..... .... 001000 . .....  @rrr_cf_d
+or              000010 ..... ..... .... 001001 . .....  @rrr_cf_d
+xor             000010 ..... ..... .... 001010 . .....  @rrr_cf_d
 uxor            000010 ..... ..... .... 001110 0 .....  @rrr_cf
 ds              000010 ..... ..... .... 010001 0 .....  @rrr_cf
 cmpclr          000010 ..... ..... .... 100010 0 .....  @rrr_cf
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 94969cf2f0..5eecced442 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1392,11 +1392,10 @@ static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 }
 
 static void do_log(DisasContext *ctx, unsigned rt, TCGv_reg in1,
-                   TCGv_reg in2, unsigned cf,
+                   TCGv_reg in2, unsigned cf, bool d,
                    void (*fn)(TCGv_reg, TCGv_reg, TCGv_reg))
 {
     TCGv_reg dest = dest_gpr(ctx, rt);
-    bool d = false;
 
     /* Perform the operation, and writeback.  */
     fn(dest, in1, in2);
@@ -1409,7 +1408,7 @@ static void do_log(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     }
 }
 
-static bool do_log_reg(DisasContext *ctx, arg_rrr_cf *a,
+static bool do_log_reg(DisasContext *ctx, arg_rrr_cf_d *a,
                        void (*fn)(TCGv_reg, TCGv_reg, TCGv_reg))
 {
     TCGv_reg tcg_r1, tcg_r2;
@@ -1419,7 +1418,7 @@ static bool do_log_reg(DisasContext *ctx, arg_rrr_cf *a,
     }
     tcg_r1 = load_gpr(ctx, a->r1);
     tcg_r2 = load_gpr(ctx, a->r2);
-    do_log(ctx, a->t, tcg_r1, tcg_r2, a->cf, fn);
+    do_log(ctx, a->t, tcg_r1, tcg_r2, a->cf, a->d, fn);
     return nullify_end(ctx);
 }
 
@@ -2672,17 +2671,17 @@ static bool trans_sub_b_tsv(DisasContext *ctx, arg_rrr_cf *a)
     return do_sub_reg(ctx, a, true, true, false);
 }
 
-static bool trans_andcm(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_andcm(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     return do_log_reg(ctx, a, tcg_gen_andc_reg);
 }
 
-static bool trans_and(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_and(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     return do_log_reg(ctx, a, tcg_gen_and_reg);
 }
 
-static bool trans_or(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     if (a->cf == 0) {
         unsigned r2 = a->r2;
@@ -2734,7 +2733,7 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf *a)
     return do_log_reg(ctx, a, tcg_gen_or_reg);
 }
 
-static bool trans_xor(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_xor(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     return do_log_reg(ctx, a, tcg_gen_xor_reg);
 }
-- 
2.34.1


