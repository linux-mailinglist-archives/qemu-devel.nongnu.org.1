Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFEA723E54
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:52:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIw-0007o0-M8; Tue, 06 Jun 2023 05:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIm-0007h2-74
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:32 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIj-0004jK-KN
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:31 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-30af86a966eso4817035f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044908; x=1688636908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NWz6UkpA2J6z2+riJzixJ3T+PZxvsaDLDf/K/Qrd3b4=;
 b=Fk88LqmS/JJ1NhUvF9Ib+7ZIca9ZO4S+xCCJGfZ0JcDbPVSmU4nBxWa2I9geL+LHmq
 5ZgFMBn4eXgfNaA7ZwEE+pD2QcsXDCtPGPCXHOTUm859qZS2Pe4jQG0CgJM0wb2Iu998
 XRmyWVyNb07EzmrivRyUvdLN7m4a0b82oZMZSEDZcGocJeTY4F40SVZJPa/nZImLyCPa
 C1OSbIBIVcOjI6rfqyU6Z/F1eRU8t1LfaRGI5BrpEuxF/iGjCHhDOitGzTuQyEV/aNqN
 M3aR+DUyapmSwGGUEaGf0QaMKWAPeR/K7TXvuxlBQRV4qDB/GvJZmosRgOJlEZv94sqq
 zrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044908; x=1688636908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NWz6UkpA2J6z2+riJzixJ3T+PZxvsaDLDf/K/Qrd3b4=;
 b=iCw8GToudNCsog4auftWkH6KWAT59EcaiqH0YEbAGqZMHGXTyXmo5D8V8IW5Viu9WI
 fyO+9z1S3APiEqKC8bTwFugsKQxR357mDXyX1gVZu+MaI2VAHU8QM6SauYd6pjokbg0v
 Z6zlHSVNBr9qPVy6FSfE3Yd1BnIAEppPU8abehZgUHcMhie8X8UEVeBeK4SgoNKsoukv
 Wv5R2bWNdEtvOrl2fzxnKgsDZBb4GjFz+O7SiNVP3PA0lBlTnQSBCkpJmTLdjeN8woJa
 p2UDK8o7YeFt26yaycT+wL88AAf1oq91Iy+/Fosu4808UJbgkMlF7yiRNEu+jdl/FEw0
 U6tg==
X-Gm-Message-State: AC+VfDyvMMteKHjPt9xrzxyXPaBD4JH2m6YbirxcFphLZ5brAlzCHlT8
 kUMu/Ixco6Ro3jJG6acqe6rYeviZVxgovgDaqqE=
X-Google-Smtp-Source: ACHHUZ6fkrWKlHcLczj2blw14MrD6tqwAxOTbp44Qr2RYrLghp1EDrzfEtWibcyxjokzIzmhI5fX6w==
X-Received: by 2002:adf:fc43:0:b0:306:2c16:8361 with SMTP id
 e3-20020adffc43000000b003062c168361mr1221958wrs.22.1686044908640; 
 Tue, 06 Jun 2023 02:48:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/42] target/arm: Use tcg_gen_qemu_{ld, st}_i128 in gen_sve_{ld,
 st}r
Date: Tue,  6 Jun 2023 10:47:58 +0100
Message-Id: <20230606094814.3581397-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Round len_align to 16 instead of 8, handling an odd 8-byte as part
of the tail.  Use MO_ATOM_NONE to indicate that all of these memory
ops have only byte atomicity.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230530191438.411344-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 95 +++++++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 25 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index d9d5810ddea..57051a4729a 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4167,11 +4167,12 @@ TRANS_FEAT(UCVTF_dd, aa64_sve, gen_gvec_fpst_arg_zpz,
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
@@ -4188,10 +4189,16 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
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
@@ -4200,14 +4207,21 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
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
@@ -4216,6 +4230,16 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
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
@@ -4223,14 +4247,14 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
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
 
@@ -4245,11 +4269,12 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
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
@@ -4267,10 +4292,15 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
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
@@ -4280,18 +4310,33 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
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
@@ -4301,14 +4346,14 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
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


