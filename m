Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E619B7D178C
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:51:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwOp-0001kY-Hw; Fri, 20 Oct 2023 16:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOn-0001fh-0X
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:13 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOl-0001A1-7r
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:12 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b3c2607d9bso1166278b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834830; x=1698439630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HnFt0Jqc97RoWbYAH0MygVjhqU7llo2mciBhZg9UKaQ=;
 b=RXz1t7WK/hFdf9lZ3aSXcjOsYUoY7Ez5fCNp3N7+dk6lhG+Oneh2EFuooIueXWDYQ3
 7nw6jcJENJHJBGfFG6bSSZQa7FljLckijEDpEO35eOQlpE+zx8bRJ5y7hZ3Hjzu8jSjs
 IC8gB3Wk04gweH+P+LLGWbd7xxiychoNjU7yDCAvuRf1s2EHX/1lf8cEG0mlxG8lJKAS
 K7AmNLFudXDTde8sJsOvsBZ0NDhT5ArsL7gr1qiXpRiaOszenlrLGinz4lb14RBGY4Ms
 3avkj2ACv3oHepU+FRD6iNMgQ7WxbWxEsCvV9dWHwmXwodhbbTUW87SVCCJYYUAeEmkv
 xcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834830; x=1698439630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HnFt0Jqc97RoWbYAH0MygVjhqU7llo2mciBhZg9UKaQ=;
 b=dh5GLyD3P5qopi6JutlQMysNbfJFLh0Qptji3dlHmkJqNWT73IKBx5ZmSW0HkUi42l
 0CSDMY/Pb5fD6rrZ+E7p85izg8MS5gWJmqAqj6jtM0wfm0Q3Y3KtgutFtokyiDtfFHdE
 ucZPeQ002s91t3i6ygi9ZDuw9+sAH8v34fM2T/88Iah/e/G9ji6jVQV+Z+/txCtvizPa
 LQzCuOm7hYYeOEzZwlPDA0/vVI+5T11SghAVhrXZc95UGj6vqf8YCNwRpOMQ5qRjpCpU
 9TeG2k606jLVUABwrLve5RZRO9ZH3UwPj2+mjGJS8vJatrzqPB05AuPC3L9mG8B64Ela
 xNRw==
X-Gm-Message-State: AOJu0YyJ3+/B3GSVoKgSg44JcFlMX393QoYBDzejUymlHs/6/KqwzAYh
 0HAGJm3JoN3fT5enRjemFtQv1IzNHZ2FQrC9saQ=
X-Google-Smtp-Source: AGHT+IFhH5GGLwOhcv6YgaMWaYzmieniZ3KMiIbZdP7EUVqSKiLwiHjdlHpiNG8MaqA4dJ6T6uKasA==
X-Received: by 2002:a05:6a00:194a:b0:690:bdda:7c35 with SMTP id
 s10-20020a056a00194a00b00690bdda7c35mr2914314pfk.1.1697834829946; 
 Fri, 20 Oct 2023 13:47:09 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1946775pfn.208.2023.10.20.13.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:47:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 41/65] target/hppa: Implement EXTRD
Date: Fri, 20 Oct 2023 13:43:07 -0700
Message-Id: <20231020204331.139847-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
index 5d07d0d890..99b7622841 100644
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


