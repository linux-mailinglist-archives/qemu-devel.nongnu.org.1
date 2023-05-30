Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AD5716D5B
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:18:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44o3-0006UM-Qa; Tue, 30 May 2023 15:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44nw-00066O-T7
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:49 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44nu-0004ea-Hn
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:48 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-64d24136663so3322585b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685474085; x=1688066085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rymPdgpajYoSymhNmUPGHozjpKn+tM24QE5wv8ugMXw=;
 b=o0q+NgvpI5HDLg5nirE9uAyGgTVkAfMRMkuV5OtWzVg6ryFAOVJpiZN8nZ8Fmj+8wa
 BEc1dAVtMNoSXABb7vy5FUAqn9ZWjdxK3MmwfeFZwDBevvPmo7RDzXM6JvoAIbD50bWF
 vMD5Dggc7Omz5FOIKycCSSkawur8OHXQe+hZI7KKvewGEbXYeK3BV4thGHCVrI9yXqMP
 X8K5pBN1XJuIQTsQ0OwMCdVsRWkSjdAuasH2ezpPoGg+zrQYztAAD7M9Qc9mtB21qPe/
 j5octfV9elQuZBpJdhlCS8mxFEc/qH7KK3K5rIuPFZ+GoSvFJ/9fYLHfQTgWXDEACnKt
 rPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685474085; x=1688066085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rymPdgpajYoSymhNmUPGHozjpKn+tM24QE5wv8ugMXw=;
 b=TGPA+2gqOPWoYlfxzQNDtjewRjljZCqZR3jy4KGf6aIXbWTx7Dny6yy6SqTypISN4T
 nPSM7GlQRoLfGB4Aj4TWdJBczF6pO20TwQhul6SwwNM3cQJJGxh9se2cNnv2KwLFDTuA
 dmQHnSKcOaE2ZsEK4ffVzKEZvQHVIdRWiktddgphMS8b1NTtCOWiCcvf/2OVWryq9NMj
 iZcDh1wZNmVbnTF2zW6qoPVRbwI7vf4FZ0PQf1xF5svOPFXwQGwHmx8xDyDSxAipymoK
 9c6u6xtnS+sJZXQ38MUAm0Po0KW9Y4hKfMIURdw2pEm+mOcvmDqVqraHADhgauCSkM5f
 tgiQ==
X-Gm-Message-State: AC+VfDweS4LaOKjG5pmhtteYXNK9hEk4Hf6PhnMCLRRczdwFZ29aXOkR
 QG417li9Exjtu8YIwQkkFi4qQVsGprPkbfepEEQ=
X-Google-Smtp-Source: ACHHUZ6H7ZWB7GhpB28cOjvbxcmMkay2oK4+6wlfb26PzC/IE8XbYVaX7g41ov2akOgiFHvU7k7JKA==
X-Received: by 2002:a05:6a21:100f:b0:10e:a8e6:35c5 with SMTP id
 nk15-20020a056a21100f00b0010ea8e635c5mr2856659pzb.59.1685474085264; 
 Tue, 30 May 2023 12:14:45 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 10-20020a63104a000000b0051806da5cd6sm8926757pgq.60.2023.05.30.12.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:14:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 07/20] target/arm: Use tcg_gen_qemu_{ld,
 st}_i128 in gen_sve_{ld, st}r
Date: Tue, 30 May 2023 12:14:25 -0700
Message-Id: <20230530191438.411344-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530191438.411344-1-richard.henderson@linaro.org>
References: <20230530191438.411344-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Round len_align to 16 instead of 8, handling an odd 8-byte as part
of the tail.  Use MO_ATOM_NONE to indicate that all of these memory
ops have only byte atomicity.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 95 +++++++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 25 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 92ab290106..058f7ef237 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4178,11 +4178,12 @@ TRANS_FEAT(UCVTF_dd, aa64_sve, gen_gvec_fpst_arg_zpz,
 void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
                  int len, int rn, int imm)
 {
-    int len_align = QEMU_ALIGN_DOWN(len, 8);
-    int len_remain = len % 8;
-    int nparts = len / 8 + ctpop8(len_remain);
+    int len_align = QEMU_ALIGN_DOWN(len, 16);
+    int len_remain = len % 16;
+    int nparts = len / 16 + ctpop8(len_remain);
     int midx = get_mem_index(s);
     TCGv_i64 dirty_addr, clean_addr, t0, t1;
+    TCGv_i128 t16;
 
     dirty_addr = tcg_temp_new_i64();
     tcg_gen_addi_i64(dirty_addr, cpu_reg_sp(s, rn), imm);
@@ -4199,10 +4200,16 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
         int i;
 
         t0 = tcg_temp_new_i64();
-        for (i = 0; i < len_align; i += 8) {
-            tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEUQ);
+        t1 = tcg_temp_new_i64();
+        t16 = tcg_temp_new_i128();
+
+        for (i = 0; i < len_align; i += 16) {
+            tcg_gen_qemu_ld_i128(t16, clean_addr, midx,
+                                 MO_LE | MO_128 | MO_ATOM_NONE);
+            tcg_gen_extr_i128_i64(t0, t1, t16);
             tcg_gen_st_i64(t0, base, vofs + i);
-            tcg_gen_addi_i64(clean_addr, clean_addr, 8);
+            tcg_gen_st_i64(t1, base, vofs + i + 8);
+            tcg_gen_addi_i64(clean_addr, clean_addr, 16);
         }
     } else {
         TCGLabel *loop = gen_new_label();
@@ -4211,14 +4218,21 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
         tcg_gen_movi_ptr(i, 0);
         gen_set_label(loop);
 
-        t0 = tcg_temp_new_i64();
-        tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEUQ);
-        tcg_gen_addi_i64(clean_addr, clean_addr, 8);
+        t16 = tcg_temp_new_i128();
+        tcg_gen_qemu_ld_i128(t16, clean_addr, midx,
+                             MO_LE | MO_128 | MO_ATOM_NONE);
+        tcg_gen_addi_i64(clean_addr, clean_addr, 16);
 
         tp = tcg_temp_new_ptr();
         tcg_gen_add_ptr(tp, base, i);
-        tcg_gen_addi_ptr(i, i, 8);
+        tcg_gen_addi_ptr(i, i, 16);
+
+        t0 = tcg_temp_new_i64();
+        t1 = tcg_temp_new_i64();
+        tcg_gen_extr_i128_i64(t0, t1, t16);
+
         tcg_gen_st_i64(t0, tp, vofs);
+        tcg_gen_st_i64(t1, tp, vofs + 8);
 
         tcg_gen_brcondi_ptr(TCG_COND_LTU, i, len_align, loop);
     }
@@ -4227,6 +4241,16 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
      * Predicate register loads can be any multiple of 2.
      * Note that we still store the entire 64-bit unit into cpu_env.
      */
+    if (len_remain >= 8) {
+        t0 = tcg_temp_new_i64();
+        tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEUQ | MO_ATOM_NONE);
+        tcg_gen_st_i64(t0, base, vofs + len_align);
+        len_remain -= 8;
+        len_align += 8;
+        if (len_remain) {
+            tcg_gen_addi_i64(clean_addr, clean_addr, 8);
+        }
+    }
     if (len_remain) {
         t0 = tcg_temp_new_i64();
         switch (len_remain) {
@@ -4234,14 +4258,14 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
         case 4:
         case 8:
             tcg_gen_qemu_ld_i64(t0, clean_addr, midx,
-                                MO_LE | ctz32(len_remain));
+                                MO_LE | ctz32(len_remain) | MO_ATOM_NONE);
             break;
 
         case 6:
             t1 = tcg_temp_new_i64();
-            tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEUL);
+            tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEUL | MO_ATOM_NONE);
             tcg_gen_addi_i64(clean_addr, clean_addr, 4);
-            tcg_gen_qemu_ld_i64(t1, clean_addr, midx, MO_LEUW);
+            tcg_gen_qemu_ld_i64(t1, clean_addr, midx, MO_LEUW | MO_ATOM_NONE);
             tcg_gen_deposit_i64(t0, t0, t1, 32, 32);
             break;
 
@@ -4256,11 +4280,12 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
 void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
                  int len, int rn, int imm)
 {
-    int len_align = QEMU_ALIGN_DOWN(len, 8);
-    int len_remain = len % 8;
-    int nparts = len / 8 + ctpop8(len_remain);
+    int len_align = QEMU_ALIGN_DOWN(len, 16);
+    int len_remain = len % 16;
+    int nparts = len / 16 + ctpop8(len_remain);
     int midx = get_mem_index(s);
-    TCGv_i64 dirty_addr, clean_addr, t0;
+    TCGv_i64 dirty_addr, clean_addr, t0, t1;
+    TCGv_i128 t16;
 
     dirty_addr = tcg_temp_new_i64();
     tcg_gen_addi_i64(dirty_addr, cpu_reg_sp(s, rn), imm);
@@ -4278,10 +4303,15 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
         int i;
 
         t0 = tcg_temp_new_i64();
+        t1 = tcg_temp_new_i64();
+        t16 = tcg_temp_new_i128();
         for (i = 0; i < len_align; i += 8) {
             tcg_gen_ld_i64(t0, base, vofs + i);
-            tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUQ);
-            tcg_gen_addi_i64(clean_addr, clean_addr, 8);
+            tcg_gen_ld_i64(t1, base, vofs + i + 8);
+            tcg_gen_concat_i64_i128(t16, t0, t1);
+            tcg_gen_qemu_st_i128(t16, clean_addr, midx,
+                                 MO_LE | MO_128 | MO_ATOM_NONE);
+            tcg_gen_addi_i64(clean_addr, clean_addr, 16);
         }
     } else {
         TCGLabel *loop = gen_new_label();
@@ -4291,18 +4321,33 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
         gen_set_label(loop);
 
         t0 = tcg_temp_new_i64();
+        t1 = tcg_temp_new_i64();
         tp = tcg_temp_new_ptr();
         tcg_gen_add_ptr(tp, base, i);
         tcg_gen_ld_i64(t0, tp, vofs);
-        tcg_gen_addi_ptr(i, i, 8);
+        tcg_gen_ld_i64(t1, tp, vofs + 8);
+        tcg_gen_addi_ptr(i, i, 16);
 
-        tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUQ);
-        tcg_gen_addi_i64(clean_addr, clean_addr, 8);
+        t16 = tcg_temp_new_i128();
+        tcg_gen_concat_i64_i128(t16, t0, t1);
+
+        tcg_gen_qemu_st_i128(t16, clean_addr, midx, MO_LEUQ);
+        tcg_gen_addi_i64(clean_addr, clean_addr, 16);
 
         tcg_gen_brcondi_ptr(TCG_COND_LTU, i, len_align, loop);
     }
 
     /* Predicate register stores can be any multiple of 2.  */
+    if (len_remain >= 8) {
+        t0 = tcg_temp_new_i64();
+        tcg_gen_st_i64(t0, base, vofs + len_align);
+        tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUQ | MO_ATOM_NONE);
+        len_remain -= 8;
+        len_align += 8;
+        if (len_remain) {
+            tcg_gen_addi_i64(clean_addr, clean_addr, 8);
+        }
+    }
     if (len_remain) {
         t0 = tcg_temp_new_i64();
         tcg_gen_ld_i64(t0, base, vofs + len_align);
@@ -4312,14 +4357,14 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
         case 4:
         case 8:
             tcg_gen_qemu_st_i64(t0, clean_addr, midx,
-                                MO_LE | ctz32(len_remain));
+                                MO_LE | ctz32(len_remain) | MO_ATOM_NONE);
             break;
 
         case 6:
-            tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUL);
+            tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUL | MO_ATOM_NONE);
             tcg_gen_addi_i64(clean_addr, clean_addr, 4);
             tcg_gen_shri_i64(t0, t0, 32);
-            tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUW);
+            tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUW | MO_ATOM_NONE);
             break;
 
         default:
-- 
2.34.1


