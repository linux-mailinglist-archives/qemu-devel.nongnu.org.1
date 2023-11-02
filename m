Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC6D7DEA1D
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:35:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMYK-0005pH-18; Wed, 01 Nov 2023 21:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXe-0005cH-Gr
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:38 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXa-0001Xh-22
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:35 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ba172c5f3dso493616b3a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888632; x=1699493432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BJWPaMmS7HS/DrXXKR0DYhMSrnqFI+qqQylX9ZBFipk=;
 b=rRMwf5eji0NArohWASGJVPPLJVSOj0tGJvxFYPqAg8VA+dDWUOr57+pXbZBRwhRgYk
 NxX9gu9oCjM+iOKLqiwFng/MlsktA30IaXm+wsbUStQkOtG2Z5biHXfYjMxWVXptQhWB
 RZsXYbgMUstHdyE9Mz/Yo5gtKDorQzI18rZ1qgG1BjHHvP/drLhEg7cDyy5++IKRpU+M
 mLYYWJGYCdaa3V0YRsKtcSVN6dnvhAbiU0isFgSa3ZCTQA7v58imEnNVKDoZf3gDuwlR
 vYrn0r+lv252x51REgOsxq0VgIqXFeg17O+9o5WevGIpdhiOwhOryAikuNcMn2H1sALU
 4W6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888632; x=1699493432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BJWPaMmS7HS/DrXXKR0DYhMSrnqFI+qqQylX9ZBFipk=;
 b=OUpH4eLiYMU7SinHQm6aqy5YDwKTMYbMe0sCBrEYb+wsXmKn7aTgd6s6zVxk/Pr/MC
 wkeoMI/dfn1qTlbQs52z1n+YdcmFEZ8HFOT7dEEwmEVWPTY4mRJ3EPmw/IxIbO3Tp6LB
 JzMx9ifs3sF6GIgcrhOA3IOlBZWe/XfOzsfFdXmN41yHA+PrjSRAaPB3a0rFudNymXiB
 X/8GCu2GTz8MpSR4cqp23JZLpnhn2R7JVjjjjhB0glxE0GzGsk8vgIbppk322qEdohYw
 lhMQpnZX0pN666hykrUNOK1vc5aQARpDlIHtio/Et0yu3tJxqTCeRIAX7FL8cEJvXrl1
 471A==
X-Gm-Message-State: AOJu0YyTH59F9wmgDDjP8AXUfwldrOpJarCzpUpMXjLYi0J4DTzeUQKu
 WYzDs7X8lLZtyzoUhC5psjj/hzJx7c1+41xlCj8=
X-Google-Smtp-Source: AGHT+IE1FG9DeENl1Xayb7qOsI7cFzBCcbWhxFjgjykO3d+WDooVgRPb3Ti7qYi5eD/Kf+EVTta/hA==
X-Received: by 2002:a05:6a00:2e28:b0:68e:41e9:10be with SMTP id
 fc40-20020a056a002e2800b0068e41e910bemr17533565pfb.20.1698888627393; 
 Wed, 01 Nov 2023 18:30:27 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 11/88] target/hppa: Remove load_const
Date: Wed,  1 Nov 2023 18:28:59 -0700
Message-Id: <20231102013016.369010-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Replace with tcg_constant_reg.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 3c4a759628..c8384fccd9 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -488,13 +488,6 @@ static void cond_free(DisasCond *cond)
     }
 }
 
-static TCGv_reg load_const(DisasContext *ctx, target_sreg v)
-{
-    TCGv_reg t = tcg_temp_new();
-    tcg_gen_movi_reg(t, v);
-    return t;
-}
-
 static TCGv_reg load_gpr(DisasContext *ctx, unsigned reg)
 {
     if (reg == 0) {
@@ -1164,7 +1157,7 @@ static bool do_add_imm(DisasContext *ctx, arg_rri_cf *a,
     if (a->cf) {
         nullify_over(ctx);
     }
-    tcg_im = load_const(ctx, a->i);
+    tcg_im = tcg_constant_reg(a->i);
     tcg_r2 = load_gpr(ctx, a->r);
     do_add(ctx, a->t, tcg_im, tcg_r2, 0, 0, is_tsv, is_tc, 0, a->cf);
     return nullify_end(ctx);
@@ -1253,7 +1246,7 @@ static bool do_sub_imm(DisasContext *ctx, arg_rri_cf *a, bool is_tsv)
     if (a->cf) {
         nullify_over(ctx);
     }
-    tcg_im = load_const(ctx, a->i);
+    tcg_im = tcg_constant_reg(a->i);
     tcg_r2 = load_gpr(ctx, a->r);
     do_sub(ctx, a->t, tcg_im, tcg_r2, is_tsv, 0, 0, a->cf);
     return nullify_end(ctx);
@@ -2808,7 +2801,7 @@ static bool trans_cmpiclr(DisasContext *ctx, arg_rri_cf *a)
         nullify_over(ctx);
     }
 
-    tcg_im = load_const(ctx, a->i);
+    tcg_im = tcg_constant_reg(a->i);
     tcg_r2 = load_gpr(ctx, a->r);
     do_cmpclr(ctx, a->t, tcg_im, tcg_r2, a->cf);
 
@@ -2994,7 +2987,7 @@ static bool trans_cmpb(DisasContext *ctx, arg_cmpb *a)
 static bool trans_cmpbi(DisasContext *ctx, arg_cmpbi *a)
 {
     nullify_over(ctx);
-    return do_cmpb(ctx, a->r, load_const(ctx, a->i), a->c, a->f, a->n, a->disp);
+    return do_cmpb(ctx, a->r, tcg_constant_reg(a->i), a->c, a->f, a->n, a->disp);
 }
 
 static bool do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
@@ -3033,7 +3026,7 @@ static bool trans_addb(DisasContext *ctx, arg_addb *a)
 static bool trans_addbi(DisasContext *ctx, arg_addbi *a)
 {
     nullify_over(ctx);
-    return do_addb(ctx, a->r, load_const(ctx, a->i), a->c, a->f, a->n, a->disp);
+    return do_addb(ctx, a->r, tcg_constant_reg(a->i), a->c, a->f, a->n, a->disp);
 }
 
 static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
@@ -3345,7 +3338,7 @@ static bool trans_depwi_sar(DisasContext *ctx, arg_depwi_sar *a)
     if (a->c) {
         nullify_over(ctx);
     }
-    return do_depw_sar(ctx, a->t, a->c, a->nz, a->clen, load_const(ctx, a->i));
+    return do_depw_sar(ctx, a->t, a->c, a->nz, a->clen, tcg_constant_reg(a->i));
 }
 
 static bool trans_be(DisasContext *ctx, arg_be *a)
@@ -3852,7 +3845,7 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
             return true;
         }
         if (inv) {
-            TCGv_reg c = load_const(ctx, mask);
+            TCGv_reg c = tcg_constant_reg(mask);
             tcg_gen_or_reg(t, t, c);
             ctx->null_cond = cond_make(TCG_COND_EQ, t, c);
         } else {
-- 
2.34.1


