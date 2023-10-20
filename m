Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 335C67D1798
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:54:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwM7-0007zb-0R; Fri, 20 Oct 2023 16:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLj-0007l6-5n
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:08 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLd-0008CM-7V
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:01 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b26a3163acso1100580b3a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834634; x=1698439434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bjm4am++QtRrdDOjyV6ZJHM+umovDVM2bFLkEqCxtAk=;
 b=pzji8I/dj8/xU9X3fl+0d+zcblcAexYgpsEEEtnrUzLBLR/wQGgJqUQ70gxDhjP9Nu
 cQLujwi6o8MFyOZ4Mk9nUPGZ8mWOHCpcVRyUyhYCJMzww6LsE3wi458Ya7Tpu0Di4XOQ
 MG7EZtGDQxD3A5ptqOmTmXB5UdmeP1xwAx5QC2nvvGTRX0DqD3SA1uehRtG1tYFKvndJ
 5/xwd2Dy6bb2Fw2ZbX1lAyqHkSiv/RDGC8xEmMUmRaIzZFeO1PVq86wfbd1vtQLsUwh3
 8+a5gf+3Y1quAYQi+t19H8ifd0c3aFD+2PYx0voBdHVIwo6rKuzRI8M6p6qOhcVd2w8n
 urGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834634; x=1698439434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bjm4am++QtRrdDOjyV6ZJHM+umovDVM2bFLkEqCxtAk=;
 b=Rccx6pqw6l9KiglkRKbHu1JsxkPICuB9QZhN8ex7h8zBOwv/nsD4DTICu54DHS0bFH
 NK8ltAWT48zlLuHTjEtaz6jubpYp+A/pg2lXkr3dECw/2vZKDvxdhxXkCqrnpTFu/ANp
 iBPOhMOJnq/k6KtzC0et/PGQ0n1rmeVTlz2E8wio4iJQIy+NvT1SQJiiBRymtYlPulOx
 OVyqjs6j44bZo5szbrZEqs7aUYfRX1nevO2BjECZ0rfGfLUma60vXa52eXDup8VQiC5l
 3SUIaQAPKowlXPA9wDWht0oHZGXUaoCfrCAn9TZMH6YfSzqhoyckgB3co++wAoEXlw9C
 m4nw==
X-Gm-Message-State: AOJu0Yzfr3Q1XRG04tZf4N1OmWZdF/SeOSxOjcHLVNPEaNs/0vV+MGY6
 sQyn4ldS0kdplEYmiwtgfzeb0xm/H3/x+swVFVY=
X-Google-Smtp-Source: AGHT+IEMNARZVyv/tJlZTmt0KAFfIkY1al8oV+YgvBUyp06NqT2DQfZm3voslnWtCksiQPr7SUQf6A==
X-Received: by 2002:a05:6a00:15c2:b0:693:3be8:feba with SMTP id
 o2-20020a056a0015c200b006933be8febamr2895362pfu.19.1697834634035; 
 Fri, 20 Oct 2023 13:43:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 24/65] target/hppa: Pass d to do_log_cond
Date: Fri, 20 Oct 2023 13:42:50 -0700
Message-Id: <20231020204331.139847-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Hoist the resolution of d up one level above do_log_cond.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 48 ++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index d480bac03d..d629f5f7f8 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -970,9 +970,11 @@ static DisasCond do_sub_cond(DisasContext *ctx, unsigned cf, bool d,
  * how cases c={2,3} are treated.
  */
 
-static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, TCGv_reg res)
+static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, bool d,
+                             TCGv_reg res)
 {
-    bool d = false;
+    TCGCond tc;
+    bool ext_uns;
 
     switch (cf) {
     case 0:  /* never */
@@ -988,17 +990,29 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, TCGv_reg res)
         return cond_make_t();
 
     case 2:  /* == */
-        return cond_make_0(TCG_COND_EQ, res);
+        tc = TCG_COND_EQ;
+        ext_uns = true;
+        break;
     case 3:  /* <> */
-        return cond_make_0(TCG_COND_NE, res);
+        tc = TCG_COND_NE;
+        ext_uns = true;
+        break;
     case 4:  /* < */
-        return cond_make_0(TCG_COND_LT, res);
+        tc = TCG_COND_LT;
+        ext_uns = false;
+        break;
     case 5:  /* >= */
-        return cond_make_0(TCG_COND_GE, res);
+        tc = TCG_COND_GE;
+        ext_uns = false;
+        break;
     case 6:  /* <= */
-        return cond_make_0(TCG_COND_LE, res);
+        tc = TCG_COND_LE;
+        ext_uns = false;
+        break;
     case 7:  /* > */
-        return cond_make_0(TCG_COND_GT, res);
+        tc = TCG_COND_GT;
+        ext_uns = false;
+        break;
 
     case 14: /* OD */
     case 15: /* EV */
@@ -1007,6 +1021,18 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, TCGv_reg res)
     default:
         g_assert_not_reached();
     }
+
+    if (cond_need_ext(ctx, d)) {
+        TCGv_reg tmp = tcg_temp_new();
+
+        if (ext_uns) {
+            tcg_gen_ext32u_reg(tmp, res);
+        } else {
+            tcg_gen_ext32s_reg(tmp, res);
+        }
+        return cond_make_0_tmp(tc, tmp);
+    }
+    return cond_make_0(tc, res);
 }
 
 /* Similar, but for shift/extract/deposit conditions.  */
@@ -1014,6 +1040,7 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, TCGv_reg res)
 static DisasCond do_sed_cond(DisasContext *ctx, unsigned orig, TCGv_reg res)
 {
     unsigned c, f;
+    bool d = false;
 
     /* Convert the compressed condition codes to standard.
        0-2 are the same as logicals (nv,<,<=), while 3 is OD.
@@ -1024,7 +1051,7 @@ static DisasCond do_sed_cond(DisasContext *ctx, unsigned orig, TCGv_reg res)
     }
     f = (orig & 4) / 4;
 
-    return do_log_cond(ctx, c * 2 + f, res);
+    return do_log_cond(ctx, c * 2 + f, d, res);
 }
 
 /* Similar, but for unit conditions.  */
@@ -1368,6 +1395,7 @@ static void do_log(DisasContext *ctx, unsigned rt, TCGv_reg in1,
                    void (*fn)(TCGv_reg, TCGv_reg, TCGv_reg))
 {
     TCGv_reg dest = dest_gpr(ctx, rt);
+    bool d = false;
 
     /* Perform the operation, and writeback.  */
     fn(dest, in1, in2);
@@ -1376,7 +1404,7 @@ static void do_log(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (cf) {
-        ctx->null_cond = do_log_cond(ctx, cf, dest);
+        ctx->null_cond = do_log_cond(ctx, cf, d, dest);
     }
 }
 
-- 
2.34.1


