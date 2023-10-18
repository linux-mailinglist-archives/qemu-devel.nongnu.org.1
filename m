Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C84DF7CEA5A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:55:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESk-0001tR-Ae; Wed, 18 Oct 2023 17:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESQ-00019o-Aq
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:05 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESN-0004RS-29
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:00 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3514bf96fd2so29603295ab.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665917; x=1698270717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IzgNOQnYTPtvhWHame0+1TsFsoAlkTYKxkzC3eocI48=;
 b=XO+OaPlEVOURV6KPPhALzuBw+5A8nUD3Brb+1gCYuGvbVDULSUSx5Nt1MWOp92p/Y6
 q/UQ9LmPYfB+SkKPMe8bvibxTz0E+oHfMRqJtB4oi7/W+t0jh+Cw+Y8FTy8VflMpijwv
 1IIDUSKXC2+WNqbON/HGGtlYOPJTwZXxYEyIWKZqzuopS8j8kSmHetGa7iRefLfHDf9v
 2NiavH1HuhD2TNuIzmZEoVKRDFGWbbpMlNyBg0wdZH0uGcWsZZk0GYUn3xaZP0+f5/Lm
 u5stPykyKOcnupH4AA6te53JcKsFSEmVozN5iOrue40DXF8mS2118XkR1symf5BRFmSm
 IVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665917; x=1698270717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IzgNOQnYTPtvhWHame0+1TsFsoAlkTYKxkzC3eocI48=;
 b=iJBCpdQMM0SgpZQz8ZhAir/W15HdXnpaVFsHgQwyzQ3ADd+vgSwm7otSkMRQNXlU0q
 ckQCAJY5Ma4Ri9AZ/SwB943VEBMERThAXJ8oAu9exnFE0OpbC8w2mLo2bdTB6lG3pYwp
 RB21uHBxKXbeJHv2DbyX4oJA7L/EVZ17aYwV+amt+CYJDzZjSonPTklPXPHYLHkwLWlu
 0gWgd2tdeEJ8UZ0NWQ61NdCA5H3+pm1egfEcweAFE25hhid5smjyFQcMxiaNV0cEdnz3
 mup19x9nmMQdM0V/txgHkuYluKgPu2TtSR8i74+vY5xwYNWgFc+bIenBUZq5Ms1419fU
 b9gA==
X-Gm-Message-State: AOJu0YylHit97kIeCekAYgkK5dmwDCxgc63L1T0WAQKF2tRpbjWWBes+
 fY1opA+tB0XMo/13ODs2tARhq9LN6g5UzTqrcQs=
X-Google-Smtp-Source: AGHT+IEmKxzWzFrC/YN16KUkVbUwDbP0wLQsfsJs1XnPqBcdD18sut7HuebsE/YBKRCQpxKSa4KB+Q==
X-Received: by 2002:a92:c14a:0:b0:357:3d32:bf76 with SMTP id
 b10-20020a92c14a000000b003573d32bf76mr658827ilh.1.1697665917234; 
 Wed, 18 Oct 2023 14:51:57 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 24/61] target/hppa: Pass d to do_log_cond
Date: Wed, 18 Oct 2023 14:50:58 -0700
Message-Id: <20231018215135.1561375-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12b.google.com
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
index 7c95c479dc..7a3b0f1de7 100644
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


