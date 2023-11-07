Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3FD7E337D
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:06:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0COc-0007Hn-DM; Mon, 06 Nov 2023 22:04:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO4-0006Lw-Vb
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:22 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO1-0000du-SI
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:20 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cc3216b2a1so42166095ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326255; x=1699931055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BJWPaMmS7HS/DrXXKR0DYhMSrnqFI+qqQylX9ZBFipk=;
 b=EK1TbhzWSE631avqyy5D6jX8aI8kSvp/1VuJPtwXI/ZqiM5ciFC+HjGRkacWXkSxKt
 cfm/40r/xwMqLBugsjlE3FNVdaK/jqPuCWtVJbzFrjHUmjHzYjlCwvf7l+p0ycbtTY7B
 42TgzgFBuOITo6Zc1MLGHPFUZUdzZTAYmViHZMfOvo3bYqfjLVFHHhhfwHz85+omlt6/
 rultKC77RywXUJ5akxz6otfVkyWwj7b1PbFEGHHkBMJB40HzRLUtzDmhAPxsxcAGL2y8
 vfXpuJQ8cPrTTB127RSVBDoQXIXhE71SFEdjCD7TYaw5GvvsV8yWjX1xOAgCK3bYaeAO
 ogKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326255; x=1699931055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BJWPaMmS7HS/DrXXKR0DYhMSrnqFI+qqQylX9ZBFipk=;
 b=hspBEPTQbFt+NxkVtiwo7PguJzZ07265KOicEdFqFQ5agxZUPXrO0qfNKswFr0sZTH
 LZWIOIqYosakEjVaXPgQ8kXm3bMfhkdpmG2Uz67a9jA2DE90uQhF+hdLnoKbH7sPjnAC
 +enCrKvr1d8DyA2p5CL0nC22qCrYnmTogonJgO2M5tFjpV1AdLOIg6+IkcwbsjBjRvIf
 78yJuMFlZvBd2kxFe+10J/vhZZsy/VojwK/yj7+zt0t6WY1P6sb8JNhi7/atW7Ey9BVx
 np/ah7Nat/1W8mZZTWynWoX/eibRANWGf7dPLhUTTfjGGVV2GrAV1TpXFU0n5wieQ0Bh
 5i2Q==
X-Gm-Message-State: AOJu0Ywt0SvM352o+OTHUkr/RCroVCBYRxTXTEznuepUI4sU1JNyaMve
 ssZSgRjNsWNEpirVFiqUVXDnkmleaNxfjZIHR0Y=
X-Google-Smtp-Source: AGHT+IEGeOhF4UKaE7nOBgVqeSqbkr8niQ7e7TySP8XTPNAPtQmdEgj+fuZOBiTPA9dM2tqSzFNHrg==
X-Received: by 2002:a17:902:f551:b0:1cc:5b2a:2f33 with SMTP id
 h17-20020a170902f55100b001cc5b2a2f33mr21998388plf.43.1699326255417; 
 Mon, 06 Nov 2023 19:04:15 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/85] target/hppa: Remove load_const
Date: Mon,  6 Nov 2023 19:02:51 -0800
Message-Id: <20231107030407.8979-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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


