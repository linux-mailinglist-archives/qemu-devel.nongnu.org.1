Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6967D1795
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:52:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwP6-000250-SG; Fri, 20 Oct 2023 16:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwP4-00023T-0C
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:30 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwP2-0001EK-B1
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:29 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6be840283ceso1162851b3a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834847; x=1698439647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EaDJt/aWXDXMzB/5b+cw749X5lfpuA3DGgkyKvYHvVQ=;
 b=dIXwHgAR/3biY/wFcJ9VOGfU74MqbElexA86Mhc3l/9YaXzt/EMVX9mlku91fKOto/
 h/1BucG3Vyd2AYrgaEWEvqKsziglpqTJpwaJagrnjEhnxr9/ZsLi/6CgIMpuTIEDU+bx
 0g3qMpq4/0t41oWixOnMKLMwkzqeL/9lOp09PAV2FdC8avjTnlJu6qmahEB8hsfIGqCT
 K641fuFUl44aO2l8pDmvkwfYuNKqRHs7JTtkip6aLBmzmlzKOQwgcSBZyIDx8bshJlii
 sGw0RT0SubmNP026taTah3BbvdGpTdn/EeivrqXlOwuDkts2pSPCjc0MgG5hbLGhoew5
 9A2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834847; x=1698439647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EaDJt/aWXDXMzB/5b+cw749X5lfpuA3DGgkyKvYHvVQ=;
 b=m1Lahxk4XVBqpo3c0Tzz2UEzA6LgPeukERylrZu5WdfQPIFAOz++cttCSf3ovfxSAJ
 2Px3y1L3yzatyNjpAqKApfD88qI6WRjMLf8ZzBfAPUApZkncjZrlRxr8ryp50fU0NXew
 3GTFlvJ1rpisy5bv/vKpK/r9BBVGS4WzJqo/UoUapLNtY921bR8hSwUzJmICaKvkNEiV
 7kd7CrYAjUkkmw/A69KvDEytrD+PTXThwpia1Lv1JnTuE2QI21mZFYLvr1R3EQCvHpnD
 c6+klwKcnMiKCYOT26G4hzDSJ3yd4T4rH9IPQaeXhlygP+Jm4ZihV9yNZ7uhPnpTzkKl
 nhzg==
X-Gm-Message-State: AOJu0YzuMTDKOpLqASVkhHW93QJBb99GyTsIka+cW4vX76XKA8vaWhdq
 UIZHOlHbnFdcfaH3iVAkmpCdgYp3v15ekJpjBjk=
X-Google-Smtp-Source: AGHT+IFh3Vt0RmiGb3d0aupVa0qouYJxhW/llBMQOntPwbGBoyLwDbyUhcmXfEtQhZqMzpOoueev5A==
X-Received: by 2002:a05:6a20:918e:b0:179:f81b:12d9 with SMTP id
 v14-20020a056a20918e00b00179f81b12d9mr3089394pzd.11.1697834846982; 
 Fri, 20 Oct 2023 13:47:26 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1946775pfn.208.2023.10.20.13.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:47:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 62/65] target/hppa: Simplify trans_dep*_imm
Date: Fri, 20 Oct 2023 13:43:28 -0700
Message-Id: <20231020204331.139847-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
index ce2aff8c4e..47cfb16738 100644
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


