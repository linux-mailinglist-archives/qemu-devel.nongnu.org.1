Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5737D7DEA2C
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:37:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMc6-0007Js-9Y; Wed, 01 Nov 2023 21:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMb0-0006Qo-Ry
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:07 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMaz-0001wS-01
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:06 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-692c02adeefso468158b3a.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888843; x=1699493643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7KRVnVGnodF7hrNMTwH9K0ltpiIRZaSKr/Oi8z+/YM=;
 b=x5Hj2QeW0N74RM/T/DIr7+cXlxLB6WjPlX7DHL9vQsg62rdSnAYapLvrlms9BU74SB
 QcXLY0jNBzXq0Ytk+GAb6IDxQ/7rBxRb3QdytmeYL59zdHmOC6WD6ag8sRQI4hukPgp5
 jBoTRRUAF/o/OR70Wf39MVWNE6LvocX9gdisg2CcC8rAyYMrtbz22vdAsgGC8pcezJI5
 MPsKDrihJYuhgBv3bFYIyv5E4XvQUsBhwJAPX/hWouKWd77RsTbQ4eNCsFhan7Pqtkta
 R2cv/K76UdydfWyEBj3vNxGTF8UU4L6PCC5tKc85o/eIkl9EI+ot18vkAkOLsgU3VYjP
 vuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888843; x=1699493643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V7KRVnVGnodF7hrNMTwH9K0ltpiIRZaSKr/Oi8z+/YM=;
 b=Vv8sOzNMlDI4lozPJhPuhRXjzeWI2IH//6+az4tRMy7ZN0foLgy3gL92rUHaXbjVwE
 aSvOwJsKpSuEKoYxrLcJDiy7ZoFvlhAHJAx1ukF1RNGeFVCzJaF4nbh8UNCXOOX/y2dp
 Jsvb+tENw8zfTk4AGpfR0Gdax2SoRU6r8HHeWR+ei0SR2uJr8yH1QZ2p6WFYuDAwOq4c
 DSvd1KIjslAQt/7+L8nB/K3acg0VlPpctAXidP/YqT1OfQ/20YjFCznyBV8H8VEM5DgZ
 VdaZpeF48vYc+AsWnNYL553BO9VRXIlfgs+lU1JxFbOC+SLNyPpWcSiJwVSgtXpuIXCS
 2JXg==
X-Gm-Message-State: AOJu0Yzks9952F+Eh9Ns7bPHI4RUEKJu3AizC6txXEwqFNK1xYhUkYzF
 qewjDybIJ3vwIJ/iTPpK5RIWBjAwMZdkETYMaKI=
X-Google-Smtp-Source: AGHT+IG2y1Ol3FuGSMHqyzQfy+JAUolaam0I1XeAsxUSM2BY+UfbpWg70HCA8Yr1ReQhqlJmYkBSHg==
X-Received: by 2002:a05:6a20:918d:b0:13f:1622:29de with SMTP id
 v13-20020a056a20918d00b0013f162229demr16640527pzd.7.1698888843453; 
 Wed, 01 Nov 2023 18:34:03 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 52/88] target/hppa: Implement SHRPD
Date: Wed,  1 Nov 2023 18:29:40 -0700
Message-Id: <20231102013016.369010-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 target/hppa/insns.decode |  6 ++-
 target/hppa/translate.c  | 97 ++++++++++++++++++++++++++++------------
 2 files changed, 72 insertions(+), 31 deletions(-)

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
index 533e29879e..897b44d7e3 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3279,34 +3279,64 @@ static bool trans_movbi(DisasContext *ctx, arg_movbi *a)
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
-static bool trans_shrpw_sar(DisasContext *ctx, arg_shrpw_sar *a)
+static bool trans_shrp_sar(DisasContext *ctx, arg_shrp_sar *a)
 {
-    TCGv_reg dest;
+    TCGv_reg dest, src2;
 
+    if (!ctx->is_pa20 && a->d) {
+        return false;
+    }
     if (a->c) {
         nullify_over(ctx);
     }
 
     dest = dest_gpr(ctx, a->t);
+    src2 = load_gpr(ctx, a->r2);
     if (a->r1 == 0) {
-        tcg_gen_ext32u_reg(dest, load_gpr(ctx, a->r2));
-        tcg_gen_shr_reg(dest, dest, cpu_sar);
+        if (a->d) {
+            tcg_gen_shr_reg(dest, src2, cpu_sar);
+        } else {
+            TCGv_reg tmp = tcg_temp_new();
+
+            tcg_gen_ext32u_reg(dest, src2);
+            tcg_gen_andi_reg(tmp, cpu_sar, 31);
+            tcg_gen_shr_reg(dest, dest, tmp);
+        }
     } else if (a->r1 == a->r2) {
-        TCGv_i32 t32 = tcg_temp_new_i32();
-        TCGv_i32 s32 = tcg_temp_new_i32();
+        if (a->d) {
+            tcg_gen_rotr_reg(dest, src2, cpu_sar);
+        } else {
+            TCGv_i32 t32 = tcg_temp_new_i32();
+            TCGv_i32 s32 = tcg_temp_new_i32();
 
-        tcg_gen_trunc_reg_i32(t32, load_gpr(ctx, a->r2));
-        tcg_gen_trunc_reg_i32(s32, cpu_sar);
-        tcg_gen_rotr_i32(t32, t32, s32);
-        tcg_gen_extu_i32_reg(dest, t32);
+            tcg_gen_trunc_reg_i32(t32, src2);
+            tcg_gen_trunc_reg_i32(s32, cpu_sar);
+            tcg_gen_andi_i32(s32, s32, 31);
+            tcg_gen_rotr_i32(t32, t32, s32);
+            tcg_gen_extu_i32_reg(dest, t32);
+        }
     } else {
-        TCGv_i64 t = tcg_temp_new_i64();
-        TCGv_i64 s = tcg_temp_new_i64();
+        TCGv_reg src1 = load_gpr(ctx, a->r1);
 
-        tcg_gen_concat_reg_i64(t, load_gpr(ctx, a->r2), load_gpr(ctx, a->r1));
-        tcg_gen_extu_reg_i64(s, cpu_sar);
-        tcg_gen_shr_i64(t, t, s);
-        tcg_gen_trunc_i64_reg(dest, t);
+        if (a->d) {
+            TCGv_reg t = tcg_temp_new();
+            TCGv_reg n = tcg_temp_new();
+
+            tcg_gen_xori_reg(n, cpu_sar, 63);
+            tcg_gen_shl_reg(t, src2, n);
+            tcg_gen_shli_reg(t, t, 1);
+            tcg_gen_shr_reg(dest, src1, cpu_sar);
+            tcg_gen_or_reg(dest, dest, t);
+        } else {
+            TCGv_i64 t = tcg_temp_new_i64();
+            TCGv_i64 s = tcg_temp_new_i64();
+
+            tcg_gen_concat_reg_i64(t, src2, src1);
+            tcg_gen_extu_reg_i64(s, cpu_sar);
+            tcg_gen_andi_i64(s, s, 31);
+            tcg_gen_shr_i64(t, t, s);
+            tcg_gen_trunc_i64_reg(dest, t);
+        }
     }
     save_gpr(ctx, a->t, dest);
 
@@ -3318,31 +3348,40 @@ static bool trans_shrpw_sar(DisasContext *ctx, arg_shrpw_sar *a)
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


