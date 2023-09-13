Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8192979DD50
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 03:00:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgEDV-0001qZ-Q9; Tue, 12 Sep 2023 20:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qgEDH-0001ol-7A; Tue, 12 Sep 2023 20:58:40 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qgEDE-0003PM-GC; Tue, 12 Sep 2023 20:58:38 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68fc1bbc94eso2401956b3a.3; 
 Tue, 12 Sep 2023 17:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694566715; x=1695171515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/OUGhuQSVoJt8feFiPBaWGmhGLG9MKQgWrtSKRz0HCE=;
 b=o+d3lQUM83VPWxqSabmEqmp1d6/3ORc9afuvk3JNnjVugz7IteqkQWYJuztrI5U9YH
 ZLBFEgtaJ7Q9s2R16TBry6Y14a0IqqesUyYwnChupAgAOluwodVkt5XA29QXakxmhd34
 ZD6QxKZzQNKqlE+69TuU7643nuwhiX90VrdrhM0VCjA0PJ42KqljA4h9RAQ3DUoaKnQQ
 mNiuTVUdg1S73uNNQjc0vo0aLTZ3vYYLj84WvckD+U04zqdDeLzKZoq9AR+E0/8iRuDu
 AWebLCuPEj1967yNeRb7HdYqSuXJVadzH6yGcgdeZwAtXOY2PjK0I/LUDdzgYcdWTn+v
 0VWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694566715; x=1695171515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/OUGhuQSVoJt8feFiPBaWGmhGLG9MKQgWrtSKRz0HCE=;
 b=BPyGBxq6ualpPCqhdZOHpANfYRT8/7TFqcxNnmeIZheqJCryjOhZO1H9c9ZgvZAOci
 m1c5B1+XExAZ8sWlfQheCSN8Ejj33ErZ7nUEZ9c+H7niWYPEIOXyEIptfDpCt47L6zb9
 s6v7wueuA8Ll23lTPM1uP6GskLsSWDWJ8CukXeD7SJtGkR2aoqyymP82IL3C0vAxnFqu
 KrBbJI0kDfemQFxH+rvdOlVejHrYDUBvbCltrYIJWEPKeQAtNCEfW1/5OjSXu+irLm4+
 GOXdtRGoyH4BmMUfxOXl6S5UtEuxbcWc8s8llTapcK3eFvsRvzB5CQ9xwYmwR99dZ1D4
 vckg==
X-Gm-Message-State: AOJu0YytazIy7mf+e4dJxcabIzHlUAnidR+Uebd7wDdbq7PAlsOTfR44
 GoZji/dfe/hyJEL8gt9yXIj1f1lA2i0=
X-Google-Smtp-Source: AGHT+IHblA5CDlYj2JVWDJEHIT9avNMoKSwIMb9UkD/rLt53eO3RhCJG8vpKIT1ManU7f4yZEXdxpw==
X-Received: by 2002:a05:6a20:d405:b0:14c:d5e9:21b8 with SMTP id
 il5-20020a056a20d40500b0014cd5e921b8mr788536pzb.30.1694566714655; 
 Tue, 12 Sep 2023 17:58:34 -0700 (PDT)
Received: from wheely.local0.net ([193.114.103.68])
 by smtp.gmail.com with ESMTPSA id
 j2-20020a17090a588200b0026f4bb8b2casm208868pji.6.2023.09.12.17.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 17:58:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org
Subject: [RFC PATCH 3/3] target/ppc: Optimise after CR register tl conversion
Date: Wed, 13 Sep 2023 10:58:14 +1000
Message-Id: <20230913005814.413113-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913005814.413113-1-npiggin@gmail.com>
References: <20230913005814.413113-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

After changing CR registers from i32 to tl, a number of places that
that previously did type conversion are now redundant moves between
variables that can be removed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate.c                     | 97 +++++++++-------------
 target/ppc/translate/fixedpoint-impl.c.inc |  3 +-
 target/ppc/translate/fp-impl.c.inc         | 17 +---
 4 files changed, 46 insertions(+), 73 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3472697b30..8fdc3f3546 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1471,21 +1471,18 @@ static opc_handler_t invalid_handler = {
 
 static inline void gen_op_cmp(TCGv arg0, TCGv arg1, int s, int crf)
 {
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    TCGv t = tcg_temp_new();
+    TCGv tmp = tcg_temp_new();
+    TCGv cr = cpu_crf[crf];
 
-    tcg_gen_movi_tl(t0, CRF_EQ);
-    tcg_gen_movi_tl(t1, CRF_LT);
+    tcg_gen_movi_tl(cr, CRF_EQ);
+    tcg_gen_movi_tl(tmp, CRF_LT);
     tcg_gen_movcond_tl((s ? TCG_COND_LT : TCG_COND_LTU),
-                       t0, arg0, arg1, t1, t0);
-    tcg_gen_movi_tl(t1, CRF_GT);
+                       cr, arg0, arg1, tmp, cr);
+    tcg_gen_movi_tl(tmp, CRF_GT);
     tcg_gen_movcond_tl((s ? TCG_COND_GT : TCG_COND_GTU),
-                       t0, arg0, arg1, t1, t0);
+                       cr, arg0, arg1, tmp, cr);
 
-    tcg_gen_mov_tl(t, t0);
-    tcg_gen_mov_tl(cpu_crf[crf], cpu_so);
-    tcg_gen_or_tl(cpu_crf[crf], cpu_crf[crf], t);
+    tcg_gen_or_tl(cr, cr, cpu_so);
 }
 
 static inline void gen_op_cmpi(TCGv arg0, target_ulong arg1, int s, int crf)
@@ -1531,19 +1528,16 @@ static void gen_cmprb(DisasContext *ctx)
     TCGv src2 = tcg_temp_new();
     TCGv src2lo = tcg_temp_new();
     TCGv src2hi = tcg_temp_new();
-    TCGv crf = cpu_crf[crfD(ctx->opcode)];
-
-    tcg_gen_mov_tl(src1, cpu_gpr[rA(ctx->opcode)]);
-    tcg_gen_mov_tl(src2, cpu_gpr[rB(ctx->opcode)]);
+    TCGv cr = cpu_crf[crfD(ctx->opcode)];
 
-    tcg_gen_andi_tl(src1, src1, 0xFF);
-    tcg_gen_ext8u_tl(src2lo, src2);
-    tcg_gen_shri_tl(src2, src2, 8);
+    tcg_gen_andi_tl(src1, cpu_gpr[rA(ctx->opcode)], 0xFF);
+    tcg_gen_ext8u_tl(src2lo, cpu_gpr[rB(ctx->opcode)]);
+    tcg_gen_shri_tl(src2, cpu_gpr[rB(ctx->opcode)], 8);
     tcg_gen_ext8u_tl(src2hi, src2);
 
     tcg_gen_setcond_tl(TCG_COND_LEU, src2lo, src2lo, src1);
     tcg_gen_setcond_tl(TCG_COND_LEU, src2hi, src1, src2hi);
-    tcg_gen_and_tl(crf, src2lo, src2hi);
+    tcg_gen_and_tl(cr, src2lo, src2hi);
 
     if (ctx->opcode & 0x00200000) {
         tcg_gen_shri_tl(src2, src2, 8);
@@ -1553,9 +1547,9 @@ static void gen_cmprb(DisasContext *ctx)
         tcg_gen_setcond_tl(TCG_COND_LEU, src2lo, src2lo, src1);
         tcg_gen_setcond_tl(TCG_COND_LEU, src2hi, src1, src2hi);
         tcg_gen_and_tl(src2lo, src2lo, src2hi);
-        tcg_gen_or_tl(crf, crf, src2lo);
+        tcg_gen_or_tl(cr, cr, src2lo);
     }
-    tcg_gen_shli_tl(crf, crf, CRF_GT_BIT);
+    tcg_gen_shli_tl(cr, cr, CRF_GT_BIT);
 }
 
 #if defined(TARGET_PPC64)
@@ -1572,11 +1566,11 @@ static void gen_isel(DisasContext *ctx)
 {
     uint32_t bi = rC(ctx->opcode);
     uint32_t mask = 0x08 >> (bi & 0x03);
+    TCGv cr = cpu_crf[bi >> 2];
     TCGv t0 = tcg_temp_new();
     TCGv zr;
 
-    tcg_gen_mov_tl(t0, cpu_crf[bi >> 2]);
-    tcg_gen_andi_tl(t0, t0, mask);
+    tcg_gen_andi_tl(t0, cr, mask);
 
     zr = tcg_constant_tl(0);
     tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[rD(ctx->opcode)], t0, zr,
@@ -3806,13 +3800,12 @@ static void gen_conditional_store(DisasContext *ctx, MemOp memop)
 {
     TCGLabel *lfail;
     TCGv EA;
-    TCGv cr0;
+    TCGv cr0 = cpu_crf[0];
     TCGv t0;
     int rs = rS(ctx->opcode);
 
     lfail = gen_new_label();
     EA = tcg_temp_new();
-    cr0 = tcg_temp_new();
     t0 = tcg_temp_new();
 
     tcg_gen_mov_tl(cr0, cpu_so);
@@ -3829,7 +3822,6 @@ static void gen_conditional_store(DisasContext *ctx, MemOp memop)
     tcg_gen_or_tl(cr0, cr0, t0);
 
     gen_set_label(lfail);
-    tcg_gen_mov_tl(cpu_crf[0], cr0);
     tcg_gen_movi_tl(cpu_reserve, -1);
 }
 
@@ -3885,7 +3877,7 @@ static void gen_stqcx_(DisasContext *ctx)
 {
     TCGLabel *lfail;
     TCGv EA, t0, t1;
-    TCGv cr0;
+    TCGv cr0 = cpu_crf[0];
     TCGv_i128 cmp, val;
     int rs = rS(ctx->opcode);
 
@@ -3896,7 +3888,6 @@ static void gen_stqcx_(DisasContext *ctx)
 
     lfail = gen_new_label();
     EA = tcg_temp_new();
-    cr0 = tcg_temp_new();
 
     tcg_gen_mov_tl(cr0, cpu_so);
     gen_set_access_type(ctx, ACCESS_RES);
@@ -3928,7 +3919,6 @@ static void gen_stqcx_(DisasContext *ctx)
     tcg_gen_or_tl(cr0, cr0, t0);
 
     gen_set_label(lfail);
-    tcg_gen_mov_tl(cpu_crf[0], cr0);
     tcg_gen_movi_tl(cpu_reserve, -1);
 }
 #endif /* defined(TARGET_PPC64) */
@@ -4680,34 +4670,30 @@ static void gen_mcrxrx(DisasContext *ctx)
 /* mfcr mfocrf */
 static void gen_mfcr(DisasContext *ctx)
 {
+    TCGv dst = cpu_gpr[rD(ctx->opcode)];
     uint32_t crm, crn;
 
     if (likely(ctx->opcode & 0x00100000)) {
         crm = CRM(ctx->opcode);
         if (likely(crm && ((crm & (crm - 1)) == 0))) {
             crn = ctz32(crm);
-            tcg_gen_mov_tl(cpu_gpr[rD(ctx->opcode)], cpu_crf[7 - crn]);
-            tcg_gen_shli_tl(cpu_gpr[rD(ctx->opcode)],
-                            cpu_gpr[rD(ctx->opcode)], crn * 4);
+            tcg_gen_shli_tl(dst, cpu_crf[7 - crn], crn * 4);
         }
     } else {
-        TCGv t0 = tcg_temp_new();
-        tcg_gen_mov_tl(t0, cpu_crf[0]);
-        tcg_gen_shli_tl(t0, t0, 4);
-        tcg_gen_or_tl(t0, t0, cpu_crf[1]);
-        tcg_gen_shli_tl(t0, t0, 4);
-        tcg_gen_or_tl(t0, t0, cpu_crf[2]);
-        tcg_gen_shli_tl(t0, t0, 4);
-        tcg_gen_or_tl(t0, t0, cpu_crf[3]);
-        tcg_gen_shli_tl(t0, t0, 4);
-        tcg_gen_or_tl(t0, t0, cpu_crf[4]);
-        tcg_gen_shli_tl(t0, t0, 4);
-        tcg_gen_or_tl(t0, t0, cpu_crf[5]);
-        tcg_gen_shli_tl(t0, t0, 4);
-        tcg_gen_or_tl(t0, t0, cpu_crf[6]);
-        tcg_gen_shli_tl(t0, t0, 4);
-        tcg_gen_or_tl(t0, t0, cpu_crf[7]);
-        tcg_gen_mov_tl(cpu_gpr[rD(ctx->opcode)], t0);
+        tcg_gen_shli_tl(dst, cpu_crf[0], 4);
+        tcg_gen_or_tl(dst, dst, cpu_crf[1]);
+        tcg_gen_shli_tl(dst, dst, 4);
+        tcg_gen_or_tl(dst, dst, cpu_crf[2]);
+        tcg_gen_shli_tl(dst, dst, 4);
+        tcg_gen_or_tl(dst, dst, cpu_crf[3]);
+        tcg_gen_shli_tl(dst, dst, 4);
+        tcg_gen_or_tl(dst, dst, cpu_crf[4]);
+        tcg_gen_shli_tl(dst, dst, 4);
+        tcg_gen_or_tl(dst, dst, cpu_crf[5]);
+        tcg_gen_shli_tl(dst, dst, 4);
+        tcg_gen_or_tl(dst, dst, cpu_crf[6]);
+        tcg_gen_shli_tl(dst, dst, 4);
+        tcg_gen_or_tl(dst, dst, cpu_crf[7]);
     }
 }
 
@@ -4794,23 +4780,22 @@ static void gen_mftb(DisasContext *ctx)
 /* mtcrf mtocrf*/
 static void gen_mtcrf(DisasContext *ctx)
 {
+    TCGv src = cpu_gpr[rS(ctx->opcode)];
     uint32_t crm, crn;
 
     crm = CRM(ctx->opcode);
     if (likely((ctx->opcode & 0x00100000))) {
         if (crm && ((crm & (crm - 1)) == 0)) {
-            TCGv temp = tcg_temp_new();
+            TCGv crf;
             crn = ctz32(crm);
-            tcg_gen_mov_tl(temp, cpu_gpr[rS(ctx->opcode)]);
-            tcg_gen_shri_tl(temp, temp, crn * 4);
-            tcg_gen_andi_tl(cpu_crf[7 - crn], temp, 0xf);
+            crf = cpu_crf[7 - crn];
+            tcg_gen_shri_tl(crf, src, crn * 4);
+            tcg_gen_andi_tl(crf, crf, 0xf);
         }
     } else {
-        TCGv temp = tcg_temp_new();
-        tcg_gen_mov_tl(temp, cpu_gpr[rS(ctx->opcode)]);
         for (crn = 0 ; crn < 8 ; crn++) {
             if (crm & (1 << crn)) {
-                    tcg_gen_shri_tl(cpu_crf[7 - crn], temp, crn * 4);
+                    tcg_gen_shri_tl(cpu_crf[7 - crn], src, crn * 4);
                     tcg_gen_andi_tl(cpu_crf[7 - crn], cpu_crf[7 - crn], 0xf);
             }
         }
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 1ad4049df6..17cd3febb9 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -344,8 +344,7 @@ static bool do_set_bool_cond(DisasContext *ctx, arg_X_bi *a, bool neg, bool rev)
     TCGv temp = tcg_temp_new();
     TCGv zero = tcg_constant_tl(0);
 
-    tcg_gen_mov_tl(temp, cpu_crf[a->bi >> 2]);
-    tcg_gen_andi_tl(temp, temp, mask);
+    tcg_gen_andi_tl(temp, cpu_crf[a->bi >> 2], mask);
     if (neg) {
         tcg_gen_negsetcond_tl(cond, cpu_gpr[a->rt], temp, zero);
     } else {
diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
index 9f71c039ce..1d986c26eb 100644
--- a/target/ppc/translate/fp-impl.c.inc
+++ b/target/ppc/translate/fp-impl.c.inc
@@ -15,19 +15,10 @@ static inline void gen_compute_fprf_float64(TCGv_i64 arg)
     gen_helper_float_check_status(cpu_env);
 }
 
-#if defined(TARGET_PPC64)
-static void gen_set_cr1_from_fpscr(DisasContext *ctx)
-{
-    TCGv tmp = tcg_temp_new();
-    tcg_gen_mov_tl(tmp, cpu_fpscr);
-    tcg_gen_shri_tl(cpu_crf[1], tmp, FPSCR_OX);
-}
-#else
 static void gen_set_cr1_from_fpscr(DisasContext *ctx)
 {
     tcg_gen_shri_tl(cpu_crf[1], cpu_fpscr, FPSCR_OX);
 }
-#endif
 
 /***                       Floating-Point arithmetic                       ***/
 #define _GEN_FLOAT_ACB(name, op1, op2, set_fprf, type)                        \
@@ -518,7 +509,7 @@ static void gen_fmrgow(DisasContext *ctx)
 /* mcrfs */
 static void gen_mcrfs(DisasContext *ctx)
 {
-    TCGv tmp = tcg_temp_new();
+    TCGv cr = cpu_crf[crfD(ctx->opcode)];
     TCGv_i32 tmask;
     TCGv_i64 tnew_fpscr = tcg_temp_new_i64();
     int bfa;
@@ -532,10 +523,8 @@ static void gen_mcrfs(DisasContext *ctx)
     bfa = crfS(ctx->opcode);
     nibble = 7 - bfa;
     shift = 4 * nibble;
-    tcg_gen_shri_tl(tmp, cpu_fpscr, shift);
-    tcg_gen_mov_tl(cpu_crf[crfD(ctx->opcode)], tmp);
-    tcg_gen_andi_tl(cpu_crf[crfD(ctx->opcode)], cpu_crf[crfD(ctx->opcode)],
-                     0xf);
+    tcg_gen_shri_tl(cr, cpu_fpscr, shift);
+    tcg_gen_andi_tl(cr, cr, 0xf);
     tcg_gen_extu_tl_i64(tnew_fpscr, cpu_fpscr);
     /* Only the exception bits (including FX) should be cleared if read */
     tcg_gen_andi_i64(tnew_fpscr, tnew_fpscr,
-- 
2.40.1


