Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA17C7CEA7C
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:59:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEVq-0002RK-Lo; Wed, 18 Oct 2023 17:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVo-0002NK-Mb
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:32 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVm-00059e-MR
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:32 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6b87c1edfd5so4164064b3a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697666129; x=1698270929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHJACBbF9+uJIXW5w/FHxtZpUnFRR5qhz5RTWQgzwyE=;
 b=dSgcWlCfzhAx+Tb6iYsZCaT5ZgDQBvMWum4STXVeXIhhPxhTBNg9zVkxqzbd9Fo2qu
 rTwRWC22w5P/HQmaMq3Ig02m9act/JNMSGXRKVz21CcMkKmGyVLLi6EaCQGF4hGhDc3U
 YqNI9gKB5weHPWhYOok0fKx32hba4EZ6swdq8qSOcdCY1cQfO3A9bjTczVwg7S5ahmLm
 mw4LL3cgfXUYym6NuMLVAR5XuFrT0vtqqlJLlkU/T/emF0BTZRZocEot+lbeDg2kVP3D
 peYEl21yp4WyAvS/IEidkspq5gbJAi7Qt0j3QR4FSg4ta0rGNVzsO1/pz53m6cG5s1Yi
 7+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697666129; x=1698270929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bHJACBbF9+uJIXW5w/FHxtZpUnFRR5qhz5RTWQgzwyE=;
 b=TVf69puw3wv43mA7Ks7F62KvFtcfXtn/5vIFG2v7V988rp0Wzl4Epc79OUyUkYFINo
 T0ioZIl+5cQiSr4JHJUvNZFf8MFAhHMlDXBEGqatDW2x2wrCiIiuKIfIBU/0PiUISi5S
 XCUQsQUNL03GVZUoHfMTHns1NGfzJX5pWtN4Lmd8P6PjzbXe5zQMxjW956J060ZgJHt0
 YRcvPYyLMcmWrmLcdZXULQ2fRC6yfy1y5OVSXYQ+nH5x/IAihxvMcX+zxZigc7yeGF5K
 4v4KlK9eQvaZrNIvLmuhCFk0p+7R9vtuP7nyOiX6unbkLsxX05KK4B5Hj2sW30HUUkoG
 yL4A==
X-Gm-Message-State: AOJu0Yy18YcBVmuWJ5SCIPAm+eevCVX5FEKhX6DYnm1o8LcwoqCEBV+g
 UjxLy1zfLx8idurrA04w+M1Pz0RU6mlDK4RVGeU=
X-Google-Smtp-Source: AGHT+IG+eLqL3CGQ2mgCgE1Xgh7vd7rshBzReNb+um9k7z8QSrOMRt6cWtDc+ecqcju5yOOJKWQ2Tg==
X-Received: by 2002:a05:6a00:a1a:b0:6be:43d5:6505 with SMTP id
 p26-20020a056a000a1a00b006be43d56505mr417860pfh.6.1697666129395; 
 Wed, 18 Oct 2023 14:55:29 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r15-20020aa7962f000000b006889348ba6esm3796263pfg.127.2023.10.18.14.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:55:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 61/61] target/hppa: Simplify trans_dep*_imm
Date: Wed, 18 Oct 2023 14:51:35 -0700
Message-Id: <20231018215135.1561375-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

All of the special cases here are now handled during
generic expansion.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 80 +++++++++++++----------------------------
 1 file changed, 25 insertions(+), 55 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index a9e0e1706f..e8ce41b5a7 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3473,80 +3473,50 @@ static bool trans_extr_imm(DisasContext *ctx, arg_extr_imm *a)
     return nullify_end(ctx);
 }
 
-static bool trans_depi_imm(DisasContext *ctx, arg_depi_imm *a)
+static bool do_dep_imm(DisasContext *ctx, unsigned rt, unsigned c,
+                       bool d, unsigned len, unsigned cpos,
+                       TCGv_i64 src, TCGv_i64 val)
 {
-    unsigned len, width;
-    uint64_t mask0, mask1;
+    unsigned width = d ? 64 : 32;
     TCGv_i64 dest;
 
-    if (!ctx->is_pa20 && a->d) {
-        return false;
+    if (cpos + len > width) {
+        len = width - cpos;
     }
-    if (a->c) {
+
+    if (c) {
         nullify_over(ctx);
     }
 
-    len = a->len;
-    width = a->d ? 64 : 32;
-    if (a->cpos + len > width) {
-        len = width - a->cpos;
-    }
+    dest = dest_gpr(ctx, rt);
+    tcg_gen_deposit_i64(dest, src, val, cpos, len);
+    save_gpr(ctx, rt, dest);
 
-    dest = dest_gpr(ctx, a->t);
-    mask0 = deposit64(0, a->cpos, len, a->i);
-    mask1 = deposit64(-1, a->cpos, len, a->i);
-
-    if (a->nz) {
-        TCGv_i64 src = load_gpr(ctx, a->t);
-        tcg_gen_andi_i64(dest, src, mask1);
-        tcg_gen_ori_i64(dest, dest, mask0);
-    } else {
-        tcg_gen_movi_i64(dest, mask0);
-    }
-    save_gpr(ctx, a->t, dest);
-
-    /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
-    if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
+    if (c) {
+        ctx->null_cond = do_sed_cond(ctx, c, d, dest);
     }
     return nullify_end(ctx);
 }
 
-static bool trans_dep_imm(DisasContext *ctx, arg_dep_imm *a)
+static bool trans_depi_imm(DisasContext *ctx, arg_depi_imm *a)
 {
-    unsigned rs = a->nz ? a->t : 0;
-    unsigned len, width;
-    TCGv_i64 dest, val;
-
     if (!ctx->is_pa20 && a->d) {
         return false;
     }
-    if (a->c) {
-        nullify_over(ctx);
-    }
+    return do_dep_imm(ctx, a->t, a->c, a->d, a->len, a->cpos,
+                      a->nz ? load_gpr(ctx, a->t) : ctx->zero,
+                      tcg_constant_i64(a->i));
+}
 
-    len = a->len;
-    width = a->d ? 64 : 32;
-    if (a->cpos + len > width) {
-        len = width - a->cpos;
+static bool trans_dep_imm(DisasContext *ctx, arg_dep_imm *a)
+{
+    if (!ctx->is_pa20 && a->d) {
+        return false;
     }
-
-    dest = dest_gpr(ctx, a->t);
-    val = load_gpr(ctx, a->r);
-    if (rs == 0) {
-        tcg_gen_deposit_z_i64(dest, val, a->cpos, len);
-    } else {
-        tcg_gen_deposit_i64(dest, cpu_gr[rs], val, a->cpos, len);
-    }
-    save_gpr(ctx, a->t, dest);
-
-    /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
-    }
-    return nullify_end(ctx);
+    return do_dep_imm(ctx, a->t, a->c, a->d, a->len, a->cpos,
+                      a->nz ? load_gpr(ctx, a->t) : ctx->zero,
+                      load_gpr(ctx, a->r));
 }
 
 static bool do_dep_sar(DisasContext *ctx, unsigned rt, unsigned c,
-- 
2.34.1


