Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8207CEAE3
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:02:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEVd-00027r-Ro; Wed, 18 Oct 2023 17:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVY-0001jn-K6
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:17 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVV-0004zx-7V
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:16 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b5cac99cfdso4520384b3a.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697666111; x=1698270911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DqhTZ/67UqvsjENOJGo2HAt1BkeJsPyDRGA2t98wGsU=;
 b=ikxMF9tE7U/Yd7ww0tqIb25FULEZmrVJ2BaQEE2Gn1ForBPoA+Ej6hjamIyGxeYcZR
 Lnc1vsxY/c7HxkMEMzXwJHSHncKACfVaaaPr7LorZNYUVh4OjNtQEqXM24T+cpe66AtQ
 LmyJl6INblaFXLGmDJ0PiQ7ThytZRJcxML56qkHQpkG4dDkbH6hlKT+kChCfvF9YoFT8
 mDxnpUfSWffW9wjNpZOrbdBWbgQSE3PZDJVgoRboQhjjUKmNucpsu61983Eys3QPyqWj
 V48g8Il+PxAegFy4SpbjmtwSIvI0wLM3S4L1vBt3c7PN8wuUAhbSgfkJtatncRckUqGQ
 f20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697666111; x=1698270911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DqhTZ/67UqvsjENOJGo2HAt1BkeJsPyDRGA2t98wGsU=;
 b=Yn2saIv9Kf34Vw+KVg/WizbsKaLoseK6xLFfj/YK5NbG/3ohGcQn/5lDPxsuUGq7Ve
 1kz/xJqHoWU/75IEm9tWohlYiEY8bhPYpuCC42hZfAaXHJW/94fDil7blMlLeD2bZWFf
 C4OsYGt8Z0sGlYdbqY5iuQXd3O4INruT47qqy7rXMyCPkM5Z2Zx4oqcqsZOqUE9SaFEA
 PToSjteUwS5xv08cqIQaVePzftYZn1ZSzI943yme2a4oozZPqs2d9jpFTwrEkVcuHheo
 UKPjPLj0cfZtXaQRABYESySIvGbT6wQKUNOyARmSJpMluGq1ILW9CQZSHldBfIoWCDfI
 ZcQg==
X-Gm-Message-State: AOJu0YzR/PyAFzcpxuZQrScNE9FBLtMGeW7BGdEB99CDfpPKc5aiG2oV
 Zw+I8bTILvuwQZ881ZCTf+0XKvSDkxejqu4M7ZI=
X-Google-Smtp-Source: AGHT+IG15NEt+7S8Q/D9diGuzuUn2pleQUfFyCF1jRzv/SmOdyoWmVZWWSKlmrngOZf8VZG0ap6iqQ==
X-Received: by 2002:a05:6a00:2341:b0:6b3:2106:94b0 with SMTP id
 j1-20020a056a00234100b006b3210694b0mr392899pfj.23.1697666111469; 
 Wed, 18 Oct 2023 14:55:11 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r15-20020aa7962f000000b006889348ba6esm3796263pfg.127.2023.10.18.14.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:55:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 42/61] target/hppa: Implement SHRPD
Date: Wed, 18 Oct 2023 14:51:16 -0700
Message-Id: <20231018215135.1561375-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode |  6 ++-
 target/hppa/translate.c  | 79 ++++++++++++++++++++++++++++------------
 2 files changed, 60 insertions(+), 25 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 7b51f39b9e..6f0c3f6ea5 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -332,8 +332,10 @@ addbi           101011 ..... ..... ... ........... . .  @rib_cf f=1
 # Shift, Extract, Deposit
 ####
 
-shrpw_sar       110100 r2:5 r1:5 c:3 00 0    00000  t:5
-shrpw_imm       110100 r2:5 r1:5 c:3 01 0    cpos:5 t:5
+shrp_sar        110100 r2:5 r1:5 c:3 00 0 d:1 0000  t:5
+shrp_imm        110100 r2:5 r1:5 c:3 01 0 cpos:5    t:5       d=0
+shrp_imm        110100 r2:5 r1:5 c:3 0. 1 .....  t:5          \
+                d=1 cpos=%cpos6_11
 
 extr_sar        110100 r:5  t:5  c:3 10 se:1 00 000 .....     d=0 len=%len5
 extr_sar        110100 r:5  t:5  c:3 10 se:1 1. 000 .....     d=1 len=%len6_8
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 974ed558d7..a23c44e3d6 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3258,32 +3258,56 @@ static bool trans_movbi(DisasContext *ctx, arg_movbi *a)
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
-static bool trans_shrpw_sar(DisasContext *ctx, arg_shrpw_sar *a)
+static bool trans_shrp_sar(DisasContext *ctx, arg_shrp_sar *a)
 {
-    TCGv_reg dest;
+    TCGv_reg dest, tmp;
 
+    if (!ctx->is_pa20 && a->d) {
+        return false;
+    }
     if (a->c) {
         nullify_over(ctx);
     }
 
     dest = dest_gpr(ctx, a->t);
     if (a->r1 == 0) {
-        tcg_gen_ext32u_reg(dest, load_gpr(ctx, a->r2));
-        tcg_gen_shr_reg(dest, dest, cpu_sar);
+        if (a->d) {
+            tcg_gen_shr_reg(dest, dest, cpu_sar);
+        } else {
+            tcg_gen_ext32u_reg(dest, load_gpr(ctx, a->r2));
+            tmp = tcg_temp_new();
+            tcg_gen_andi_reg(tmp, cpu_sar, 31);
+            tcg_gen_shr_reg(dest, dest, tmp);
+        }
     } else if (a->r1 == a->r2) {
-        TCGv_i32 t32 = tcg_temp_new_i32();
-        TCGv_i32 s32 = tcg_temp_new_i32();
+        if (a->d) {
+            tcg_gen_rotr_reg(dest, load_gpr(ctx, a->r2), cpu_sar);
+        } else {
+            TCGv_i32 t32 = tcg_temp_new_i32();
+            TCGv_i32 s32 = tcg_temp_new_i32();
 
-        tcg_gen_trunc_reg_i32(t32, load_gpr(ctx, a->r2));
-        tcg_gen_trunc_reg_i32(s32, cpu_sar);
-        tcg_gen_rotr_i32(t32, t32, s32);
-        tcg_gen_extu_i32_reg(dest, t32);
+            tcg_gen_trunc_reg_i32(t32, load_gpr(ctx, a->r2));
+            tcg_gen_trunc_reg_i32(s32, cpu_sar);
+            tcg_gen_andi_i32(s32, s32, 31);
+            tcg_gen_rotr_i32(t32, t32, s32);
+            tcg_gen_extu_i32_reg(dest, t32);
+        }
+    } else if (a->d) {
+        TCGv_reg t = tcg_temp_new();
+        TCGv_reg n = tcg_temp_new();
+
+        tcg_gen_xori_reg(n, cpu_sar, 63);
+        tcg_gen_shl_reg(t, load_gpr(ctx, a->r2), n);
+        tcg_gen_shli_reg(t, t, 1);
+        tcg_gen_shr_reg(dest, load_gpr(ctx, a->r1), cpu_sar);
+        tcg_gen_or_reg(dest, dest, t);
     } else {
         TCGv_i64 t = tcg_temp_new_i64();
         TCGv_i64 s = tcg_temp_new_i64();
 
         tcg_gen_concat_reg_i64(t, load_gpr(ctx, a->r2), load_gpr(ctx, a->r1));
         tcg_gen_extu_reg_i64(s, cpu_sar);
+        tcg_gen_andi_i64(s, s, 31);
         tcg_gen_shr_i64(t, t, s);
         tcg_gen_trunc_i64_reg(dest, t);
     }
@@ -3297,31 +3321,40 @@ static bool trans_shrpw_sar(DisasContext *ctx, arg_shrpw_sar *a)
     return nullify_end(ctx);
 }
 
-static bool trans_shrpw_imm(DisasContext *ctx, arg_shrpw_imm *a)
+static bool trans_shrp_imm(DisasContext *ctx, arg_shrp_imm *a)
 {
-    unsigned sa = 31 - a->cpos;
+    unsigned width, sa;
     TCGv_reg dest, t2;
 
+    if (!ctx->is_pa20 && a->d) {
+        return false;
+    }
     if (a->c) {
         nullify_over(ctx);
     }
 
+    width = a->d ? 64 : 32;
+    sa = width - 1 - a->cpos;
+
     dest = dest_gpr(ctx, a->t);
     t2 = load_gpr(ctx, a->r2);
     if (a->r1 == 0) {
-        tcg_gen_extract_reg(dest, t2, sa, 32 - sa);
-    } else if (TARGET_REGISTER_BITS == 32) {
+        tcg_gen_extract_reg(dest, t2, sa, width - sa);
+    } else if (width == TARGET_REGISTER_BITS) {
         tcg_gen_extract2_reg(dest, t2, cpu_gr[a->r1], sa);
-    } else if (a->r1 == a->r2) {
-        TCGv_i32 t32 = tcg_temp_new_i32();
-        tcg_gen_trunc_reg_i32(t32, t2);
-        tcg_gen_rotri_i32(t32, t32, sa);
-        tcg_gen_extu_i32_reg(dest, t32);
     } else {
-        TCGv_i64 t64 = tcg_temp_new_i64();
-        tcg_gen_concat_reg_i64(t64, t2, cpu_gr[a->r1]);
-        tcg_gen_shri_i64(t64, t64, sa);
-        tcg_gen_trunc_i64_reg(dest, t64);
+        assert(!a->d);
+        if (a->r1 == a->r2) {
+            TCGv_i32 t32 = tcg_temp_new_i32();
+            tcg_gen_trunc_reg_i32(t32, t2);
+            tcg_gen_rotri_i32(t32, t32, sa);
+            tcg_gen_extu_i32_reg(dest, t32);
+        } else {
+            TCGv_i64 t64 = tcg_temp_new_i64();
+            tcg_gen_concat_reg_i64(t64, t2, cpu_gr[a->r1]);
+            tcg_gen_shri_i64(t64, t64, sa);
+            tcg_gen_trunc_i64_reg(dest, t64);
+        }
     }
     save_gpr(ctx, a->t, dest);
 
-- 
2.34.1


