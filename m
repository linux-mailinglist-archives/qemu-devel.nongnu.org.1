Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D95E77DEA50
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:44:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMbU-0006fX-2Y; Wed, 01 Nov 2023 21:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMaz-0006QP-Ox
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:06 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMay-0001wE-2b
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:05 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cc5916d578so3297185ad.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888842; x=1699493642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oL/Q9k4VdGpuvjlQ5aW5bW/J8E3SoDMupdQ5tQzg65o=;
 b=eH3k9t69KZ/8pNWKRsDkCSTcprj9rzumLOWCsLtP2avJ4HoGkmOY8+u7JIEjRBL61I
 Fonty8K50pyJADJzn3ESOxgmCn+x7jPB7djQ8SR+tOnv34I8zRP7oReXxwMbPWB1fzD9
 hIlx3Y7XelvhkE3el77owhkVGDCUyiyppre1hL4YofDbkdWR7lCKPMs+dGdCJ5lCLUU9
 MNuMogAtppoKDbPKwjM5JJ217q5VYnH8e6aVVl1fnOlCczHIzpBRZFQqVAxsbKnXFjTe
 C+u26Xo0DftqFwjRdZaGiiSphwb4IS3PjWbZRzvu/FAAHl2cOULmRldLmfyZn3Dl5YzN
 0poQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888842; x=1699493642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oL/Q9k4VdGpuvjlQ5aW5bW/J8E3SoDMupdQ5tQzg65o=;
 b=Va/mHt5zkGhBeA3iH1acX+dY1ctaQW5Q8Siez7F2+vAlxvOi8ZDNZVli7SZnuA1SJB
 DH4Ol7H3Y58fpKKg73t6dK+APPOuaJY51U/mn4EnQSpLu9wpAH+vUr6blwB9Ey7RiXYr
 IZIIDVw0Zx9HtG1a5TQZBkga1DN0937Zo3lZcwSheTLWSGErRCeIS6EcWxP/slEtOq9N
 Uu5F6RhLOvOIba2MHYWJK7nxSk7xvnEh6rbdNnHRMfIY+dqzP89XgFpJ1CtBnHkVikxk
 Lct17jJEgIrgxz8EVAT2JAGrLfGPfvZPzadijGcNoUS4ZUdpd2wFYp6rcvgkWKP1oSQ7
 OeOA==
X-Gm-Message-State: AOJu0YyluM7QqxoppYVRNtgwXODu6aI/ZH0aCgzshpEnspBiGN9YuMrv
 iexDR+mdXtJTAQ9GY95dh3mlhpve2Dsl4FXX+lc=
X-Google-Smtp-Source: AGHT+IFXbfWTdbX+bPjpmUejM3ctrU4tTUNIFX/KyCrRDRxi8wYw2wKSmlbM7IWYxl3h1+9XH9E5kQ==
X-Received: by 2002:a17:902:d144:b0:1ca:28f3:5690 with SMTP id
 t4-20020a170902d14400b001ca28f35690mr15738759plt.46.1698888842727; 
 Wed, 01 Nov 2023 18:34:02 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 51/88] target/hppa: Implement EXTRD
Date: Wed,  1 Nov 2023 18:29:39 -0700
Message-Id: <20231102013016.369010-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
 target/hppa/insns.decode |  7 +++++--
 target/hppa/translate.c  | 42 +++++++++++++++++++++++++++++-----------
 2 files changed, 36 insertions(+), 13 deletions(-)

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
index ea2150cc55..533e29879e 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3354,11 +3354,14 @@ static bool trans_shrpw_imm(DisasContext *ctx, arg_shrpw_imm *a)
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
@@ -3368,36 +3371,53 @@ static bool trans_extrw_sar(DisasContext *ctx, arg_extrw_sar *a)
     tmp = tcg_temp_new();
 
     /* Recall that SAR is using big-endian bit numbering.  */
-    tcg_gen_andi_reg(tmp, cpu_sar, 31);
-    tcg_gen_xori_reg(tmp, tmp, 31);
+    tcg_gen_andi_reg(tmp, cpu_sar, widthm1);
+    tcg_gen_xori_reg(tmp, tmp, widthm1);
 
     if (a->se) {
+        if (!a->d) {
+            tcg_gen_ext32s_reg(dest, src);
+            src = dest;
+        }
         tcg_gen_sar_reg(dest, src, tmp);
-        tcg_gen_sextract_reg(dest, dest, 0, len);
+        tcg_gen_sextract_reg(dest, dest, 0, a->len);
     } else {
+        if (!a->d) {
+            tcg_gen_ext32u_reg(dest, src);
+            src = dest;
+        }
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
@@ -3410,7 +3430,7 @@ static bool trans_extrw_imm(DisasContext *ctx, arg_extrw_imm *a)
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


