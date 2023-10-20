Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 159F17D1761
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:48:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLw-0007u1-Ad; Fri, 20 Oct 2023 16:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLl-0007ls-7n
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:09 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLi-0008Em-Si
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:04 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ba172c5f3dso1169986b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834640; x=1698439440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rGnZN4tQSt5rJQs9WbrfWk7f+59QeCqPHohQlMJykxU=;
 b=axrgHr8gYmjRXdk+WcT/R7ypVGU+dPXHhabWcQtdZuxNzwMHgQunNRV6qoDO1sV1Fn
 +f5Nla7kcwk2U6nM4Ho5vdUNzhUMGj/x9Yj7WM03WgTzTuLDLDJ56TfZhwor608JIOkr
 QBkn7poLZY5346L3ouPr7QhJI+z6oZbT+0vsu4cBIqZwEdNdu0hzySPYl1fK9WAlxgXX
 7Mm40wWC2PxEL8UQJfDlGQfur3X74bx/Jz5QYyC/2asjk35BrTlSsgAvkWQdg82l0ZKP
 s+XZFS9CdKCHoih6Q1ZeaHvuu854Npklj8lrR/mQdy5e6YEEyZO2osFVdWz/kLzJMNsL
 EEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834640; x=1698439440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rGnZN4tQSt5rJQs9WbrfWk7f+59QeCqPHohQlMJykxU=;
 b=vmkcvxmJm2Z9IRQTFAb6djSiIIFcHRMsNj34lvJicJOcVWF7I3J4IYXo74a9KPBWNk
 q+T01yjGGNNPFbJucnHephZ1caqQN/ykctBcz8QHnUXgRRZrfhxanZisi2dpPFf9POYn
 F3twJ4v/4iRhnkZPBpb+Ri+7VCiKtqEvOCTqeph7EzEfc3mI9yHysD29FhrswGQSvpW7
 V7inrkSf0FuhEP6KP7SalQFYX5eTPMzI9YIODoyNVZqjaVCZzn56EEYr06xiadypeyN9
 WfM8el2QvXb/+oTqwAKtJ1kpzPaLsegkau8EpqmOuFDYMEj6UhVDzHb5K26TFMFnnv8f
 AyjA==
X-Gm-Message-State: AOJu0Yzf/rokuDdPAibGQe6gdy2z+6E8RnEnVGv+jlgYfjlCktOwwqG2
 jMlaiarIEXMfbbyQ7NLVhK/w5Us213ODzSfx98A=
X-Google-Smtp-Source: AGHT+IGbtTtgG2kUKxpEVtEblz8fNiuZmZ4xm7rl5bQjrFQxLFcQpkUrP/yFhnzUVShaKd8VW9IUxA==
X-Received: by 2002:a05:6a21:71c7:b0:16b:f71d:1b82 with SMTP id
 ay7-20020a056a2171c700b0016bf71d1b82mr2914608pzc.34.1697834640653; 
 Fri, 20 Oct 2023 13:44:00 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 30/65] target/hppa: Decode d for logical instructions
Date: Fri, 20 Oct 2023 13:42:56 -0700
Message-Id: <20231020204331.139847-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
index 450f64bac3..733d5fe067 100644
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


