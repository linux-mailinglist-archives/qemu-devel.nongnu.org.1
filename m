Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D66C07D178D
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:51:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwOq-0001lK-9s; Fri, 20 Oct 2023 16:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOn-0001fv-SF
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:13 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOm-0001AB-15
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:13 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6b709048d8eso1084316b3a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834831; x=1698439631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BhzrhB16C9PweWmZVzgb1Vp7AhWyTVscP3gbZpvYFDM=;
 b=SUTxvSYoguvpHgN1y3GpbwOV0FWAE+rIC7ascr+kTs2HMknfDjKFTNpCXtCruZmRH1
 /PcHsjjvS9BaCP32cULrZT7GugXHBwA6YATrgHTM+XENjXpktvw7cQA9aKx2ODkTX5Aq
 m2psBQyJCZyBjQaUp5801icEj/SOsrsqVA7i6jFVyDLGBA9gf45h+Zdcq1bRK3+xr5FP
 TnTndWyAmqL93ZQWR8fXOxLOHMm045Xc02hqr7hGXNgCaaEOgQgM2apBMmyMOoclkWZh
 TB9amJpdaDcDFZFIiNiX1fm0FHRt0Sknlol5p4czT8RmQjFfjmnfZrcVE8kDIMUwxI1t
 Vc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834831; x=1698439631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BhzrhB16C9PweWmZVzgb1Vp7AhWyTVscP3gbZpvYFDM=;
 b=Uulx/uV30aooYIvHxAaIuO5SjAxg3vWH9aq1B8RWka1XutSI1GtUakhSXEMHVHWz9T
 Xm/DBDJ3CvGS4uPUWuJFQa2PjyrXjgEDv6vkY1aWfZI8NqJRylCT03thnxtitP/g5+Iy
 +xWvuSaIT7u2awE1qqlCf+n8t2u/Cs+JhK159usAIm6eEg8bLChmalmRU6LC+iOHRWN6
 vlYyN5BFkjH8t6G51iTq16g56aruwUxxZ3b8r/u+SaYngb9hd8mZqUc4Op7QumZlK2zL
 Mfs14GGfOBVSAX2B3CyuS68pcSBvg7p7TwJk/PpDMSYyj7s6YRehZDpBlBVS7M3prc+c
 gJnw==
X-Gm-Message-State: AOJu0YxxLenBJ6lCywmWu0cSqCdLPpm23ADJSRdSgFzzSWY4fazQd2L/
 gAq/xOtalUKBs2sPVxk8MafXnqTOrxG60sY/Z9Q=
X-Google-Smtp-Source: AGHT+IFRgzlDaTpfJmYIQs4qtS9QMOTBbHHb8nM7jSXjYp3Et6LJAsejW3Bin8b6u4zWgwoCLPnXag==
X-Received: by 2002:a05:6a21:a103:b0:16b:abad:87c5 with SMTP id
 aq3-20020a056a21a10300b0016babad87c5mr2663180pzc.10.1697834830748; 
 Fri, 20 Oct 2023 13:47:10 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1946775pfn.208.2023.10.20.13.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:47:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 42/65] target/hppa: Implement SHRPD
Date: Fri, 20 Oct 2023 13:43:08 -0700
Message-Id: <20231020204331.139847-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
index 99b7622841..05fe5bf7fe 100644
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


