Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A507CEA92
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:59:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEVb-0001us-Px; Wed, 18 Oct 2023 17:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVX-0001ek-0T
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:15 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVU-0004zp-FV
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:14 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-581d487f8dbso1242494eaf.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697666111; x=1698270911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=78mYjhrfKONFT0vl9EP6HLOTdieHpipZhGsvKVkOOxE=;
 b=Q24X8h60vY6jTvh77B1Bqg6X3LBF6l3RCrgFVAGunsStqau97T5Y1vFe06HV7/n+Om
 cH/3YfVdXFekhM898ux65skTI3eIM/3pztV0xZI5FGUTdwjswtaDzREn77Sfd2wGJ/os
 +VybTMgqBT4eieCJztje2AvEdsfa/lMlCi+2U+mHwqEydl2vO06iBQJq9VUZu75YWe9E
 it+Kak7l/ZeoUzjYPS9DQcCALNO3MHMPVE8O4HyhHsxriaPyuCAZYZoWH37p7cYHmyI1
 ltTcga0zEQ6ZAHKbbnS0jR7bhIUhcw2+PaZpm8u6pr6BulsyxEVgRh3JoJ/y32pfEcIa
 vKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697666111; x=1698270911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=78mYjhrfKONFT0vl9EP6HLOTdieHpipZhGsvKVkOOxE=;
 b=OebrRStvdzs/XOP9Z9uBMwxsE1jxpRDeyRdwXRBhC67KYB4dHkH2XCuUVLRfE/vOKV
 4RsKJqtuSmXSyHhI1oG1b31oOxupvLIBpFIcSNEzSoHTYPHkhO0kEHmuVbuXo68Lozur
 9iFx1lHcCwvXoCZXmsGLkHAaiaDQtX2I5WziVioIwkKtu8SC2+tr2wJ5Jb34aN4TcaBp
 j0QPjxYdVjOFWuLlmah73bHNfyt88e+dt6eJxPGOG1JpJAFz7ZbMJ+hqOEpoJVSnA5wl
 etCocZdqmS6fkigW7oRbJ/hdIWf7Yo+ussVsoga2dvCEYiiL6BIjon9BBsNDXJOc0bbt
 Fn8A==
X-Gm-Message-State: AOJu0YxRCdFcL4Yg71v/MSiaZ3NDzXBUAQ3evc7X+SI6hKCXVNHGimgX
 2Xn2LCkuCZmeNIDQquz9HUinmt+wF4vhn7kW1Q4=
X-Google-Smtp-Source: AGHT+IGCjlFZiKCwDQdKT6tDPgpP8LL7BFGdJ0Yt+hztIjwhiWoc9vbwBfENZ+maoN+t5rkMBs/rEA==
X-Received: by 2002:a05:6358:9d82:b0:143:81bd:c0ec with SMTP id
 d2-20020a0563589d8200b0014381bdc0ecmr252602rwo.6.1697666110784; 
 Wed, 18 Oct 2023 14:55:10 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r15-20020aa7962f000000b006889348ba6esm3796263pfg.127.2023.10.18.14.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:55:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 41/61] target/hppa: Implement EXTRD
Date: Wed, 18 Oct 2023 14:51:15 -0700
Message-Id: <20231018215135.1561375-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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
 target/hppa/insns.decode |  7 +++++--
 target/hppa/translate.c  | 34 +++++++++++++++++++++++-----------
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 12684b590e..7b51f39b9e 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -335,8 +335,11 @@ addbi           101011 ..... ..... ... ........... . .  @rib_cf f=1
 shrpw_sar       110100 r2:5 r1:5 c:3 00 0    00000  t:5
 shrpw_imm       110100 r2:5 r1:5 c:3 01 0    cpos:5 t:5
 
-extrw_sar       110100 r:5  t:5  c:3 10 se:1 00000  clen:5
-extrw_imm       110100 r:5  t:5  c:3 11 se:1 pos:5  clen:5
+extr_sar        110100 r:5  t:5  c:3 10 se:1 00 000 .....     d=0 len=%len5
+extr_sar        110100 r:5  t:5  c:3 10 se:1 1. 000 .....     d=1 len=%len6_8
+extr_imm        110100 r:5  t:5  c:3 11 se:1 pos:5  .....     d=0 len=%len5
+extr_imm        110110 r:5  t:5  c:3 .. se:1 ..... .....      \
+                d=1 len=%len6_12 pos=%cpos6_11
 
 dep_sar         110101 t:5 r:5   c:3 00 nz:1 00 000 .....     d=0 len=%len5
 dep_sar         110101 t:5 r:5   c:3 00 nz:1 1. 000 .....     d=1 len=%len6_8
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index b3d3506f94..974ed558d7 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3333,11 +3333,14 @@ static bool trans_shrpw_imm(DisasContext *ctx, arg_shrpw_imm *a)
     return nullify_end(ctx);
 }
 
-static bool trans_extrw_sar(DisasContext *ctx, arg_extrw_sar *a)
+static bool trans_extr_sar(DisasContext *ctx, arg_extr_sar *a)
 {
-    unsigned len = 32 - a->clen;
+    unsigned widthm1 = a->d ? 63 : 31;
     TCGv_reg dest, src, tmp;
 
+    if (!ctx->is_pa20 && a->d) {
+        return false;
+    }
     if (a->c) {
         nullify_over(ctx);
     }
@@ -3347,36 +3350,45 @@ static bool trans_extrw_sar(DisasContext *ctx, arg_extrw_sar *a)
     tmp = tcg_temp_new();
 
     /* Recall that SAR is using big-endian bit numbering.  */
-    tcg_gen_andi_reg(tmp, cpu_sar, 31);
-    tcg_gen_xori_reg(tmp, tmp, 31);
+    tcg_gen_andi_reg(tmp, cpu_sar, widthm1);
+    tcg_gen_xori_reg(tmp, tmp, widthm1);
 
     if (a->se) {
         tcg_gen_sar_reg(dest, src, tmp);
-        tcg_gen_sextract_reg(dest, dest, 0, len);
+        tcg_gen_sextract_reg(dest, dest, 0, a->len);
     } else {
         tcg_gen_shr_reg(dest, src, tmp);
-        tcg_gen_extract_reg(dest, dest, 0, len);
+        tcg_gen_extract_reg(dest, dest, 0, a->len);
     }
     save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     }
     return nullify_end(ctx);
 }
 
-static bool trans_extrw_imm(DisasContext *ctx, arg_extrw_imm *a)
+static bool trans_extr_imm(DisasContext *ctx, arg_extr_imm *a)
 {
-    unsigned len = 32 - a->clen;
-    unsigned cpos = 31 - a->pos;
+    unsigned len, cpos, width;
     TCGv_reg dest, src;
 
+    if (!ctx->is_pa20 && a->d) {
+        return false;
+    }
     if (a->c) {
         nullify_over(ctx);
     }
 
+    len = a->len;
+    width = a->d ? 64 : 32;
+    cpos = width - 1 - a->pos;
+    if (cpos + len > width) {
+        len = width - cpos;
+    }
+
     dest = dest_gpr(ctx, a->t);
     src = load_gpr(ctx, a->r);
     if (a->se) {
@@ -3389,7 +3401,7 @@ static bool trans_extrw_imm(DisasContext *ctx, arg_extrw_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     }
     return nullify_end(ctx);
 }
-- 
2.34.1


