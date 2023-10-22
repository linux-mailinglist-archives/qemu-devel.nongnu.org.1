Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E80BA7D2735
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:40:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhwp-0005WF-JB; Sun, 22 Oct 2023 19:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwl-00052M-1P
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:27 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwi-0007bG-Q0
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:26 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ba54c3ed97so2638457b3a.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017603; x=1698622403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00af4A9i2R+ofyYXcNTB9PrYrsZGrsK6ttMyi1BZFNw=;
 b=GDz0vGQJtHgdwWFtNY1UMiWfyuHrtvWlVgUMVenwCgV//UacbVI7fSj2R2wpkkcQ+0
 lkpjv4QvM7AxRj9t5rN/3N4k2jBJ+pKYicwBYjoIQbrBNZp9ubG3Ca2C7TJ90evzPu3g
 EO5AuZ1JWbqQwDgeO7zrcKsFTxPMC4iPx2ZfMCHALdo/hNj780JpHj+zLzk5CJcZiFDy
 +XtwdF8dZLx9NVpizF3CunRohyQapMStuXk/y0eb/lsZhqF2G/NJAjgbNbqtMTsqDJ9Z
 Xb6roig7J83MAqR8C5W6Gm4g82riVEApjB1mawiRvwS1W1SxPLu6Y9VcvFdXZTILMMAm
 GxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017603; x=1698622403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=00af4A9i2R+ofyYXcNTB9PrYrsZGrsK6ttMyi1BZFNw=;
 b=EQ1vlm7p21DsPBLam17cFBAz0cgINLloMX4xl9wXkQtdcP7EvBdOmwlG3YdL8GOXto
 B5HW2un5HNk/v/liVV8jNrSAc6f7fRq4vgu7x1xukhypDG5dHewwUG2u3hcI+UALohsN
 kXykIn0Px/x6n+S9eNLe/K9m0sqhlorl3hGmFZ15yWuqpXXWNPrcrkwA1KcRoFyAO3uj
 w+zxVHvTarWm63rFxpCP/UF23e/R4xIN9CSIAQGe8c6rZwZRDr1KzU+Lx41AHU57AYIs
 KiSXIO53wOev1Cek1KhpsrPg/bR5E0YINfL9fhmav9/HRf+3ObFC3rusGg+otHndIyNG
 45tA==
X-Gm-Message-State: AOJu0Yxi2wRr+CIe5w9DXqPr8UTFFgnA2S7CR1sY9Ir2cF/H9ek9TtM+
 NuVP1LU0oMJy+9Q5RFzv2YegeSpOlSL4yKG49m4=
X-Google-Smtp-Source: AGHT+IFCeJtRptijVOnNjhyRW1Fc8UIMPS856EXyxibClgEEmJTgJTXjOs9yQivhvut5rj8ASn3M2w==
X-Received: by 2002:aa7:97b9:0:b0:6be:334c:6fd1 with SMTP id
 d25-20020aa797b9000000b006be334c6fd1mr7526838pfq.26.1698017603290; 
 Sun, 22 Oct 2023 16:33:23 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 58/94] target/sparc: Split out fp ldst functions with asi
 precomputed
Date: Sun, 22 Oct 2023 16:28:56 -0700
Message-Id: <20231022232932.80507-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
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

Take the operation size from the MemOp instead of a
separate parameter.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 138 +++++++++++++++++++++++----------------
 1 file changed, 80 insertions(+), 58 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index a65bf9ebd6..58f6b91ee1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2320,35 +2320,41 @@ static void gen_ldstub_asi(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
     }
 }
 
-static void __attribute__((unused))
-gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
+static void gen_ldf_asi0(DisasContext *dc, DisasASI *da, MemOp orig_size,
+                         TCGv addr, int rd)
 {
-    DisasASI da = get_asi(dc, insn, (size == 4 ? MO_TEUL : MO_TEUQ));
+    MemOp memop = da->memop;
+    MemOp size = memop & MO_SIZE;
     TCGv_i32 d32;
     TCGv_i64 d64;
 
-    switch (da.type) {
+    /* TODO: Use 128-bit load/store below. */
+    if (size == MO_128) {
+        memop = (memop & ~MO_SIZE) | MO_64;
+    }
+
+    switch (da->type) {
     case GET_ASI_EXCP:
         break;
 
     case GET_ASI_DIRECT:
-        gen_address_mask(dc, addr);
+        memop |= MO_ALIGN_4;
         switch (size) {
-        case 4:
+        case MO_32:
             d32 = gen_dest_fpr_F(dc);
-            tcg_gen_qemu_ld_i32(d32, addr, da.mem_idx, da.memop | MO_ALIGN);
+            tcg_gen_qemu_ld_i32(d32, addr, da->mem_idx, memop);
             gen_store_fpr_F(dc, rd, d32);
             break;
-        case 8:
-            tcg_gen_qemu_ld_i64(cpu_fpr[rd / 2], addr, da.mem_idx,
-                                da.memop | MO_ALIGN_4);
+
+        case MO_64:
+            tcg_gen_qemu_ld_i64(cpu_fpr[rd / 2], addr, da->mem_idx, memop);
             break;
-        case 16:
+
+        case MO_128:
             d64 = tcg_temp_new_i64();
-            tcg_gen_qemu_ld_i64(d64, addr, da.mem_idx, da.memop | MO_ALIGN_4);
+            tcg_gen_qemu_ld_i64(d64, addr, da->mem_idx, memop);
             tcg_gen_addi_tl(addr, addr, 8);
-            tcg_gen_qemu_ld_i64(cpu_fpr[rd/2+1], addr, da.mem_idx,
-                                da.memop | MO_ALIGN_4);
+            tcg_gen_qemu_ld_i64(cpu_fpr[rd / 2 + 1], addr, da->mem_idx, memop);
             tcg_gen_mov_i64(cpu_fpr[rd / 2], d64);
             break;
         default:
@@ -2358,24 +2364,19 @@ gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 
     case GET_ASI_BLOCK:
         /* Valid for lddfa on aligned registers only.  */
-        if (size == 8 && (rd & 7) == 0) {
-            MemOp memop;
+        if (orig_size == MO_64 && (rd & 7) == 0) {
             TCGv eight;
             int i;
 
-            gen_address_mask(dc, addr);
-
             /* The first operation checks required alignment.  */
-            memop = da.memop | MO_ALIGN_64;
             eight = tcg_constant_tl(8);
             for (i = 0; ; ++i) {
-                tcg_gen_qemu_ld_i64(cpu_fpr[rd / 2 + i], addr,
-                                    da.mem_idx, memop);
+                tcg_gen_qemu_ld_i64(cpu_fpr[rd / 2 + i], addr, da->mem_idx,
+                                    memop | (i == 0 ? MO_ALIGN_64 : 0));
                 if (i == 7) {
                     break;
                 }
                 tcg_gen_add_tl(addr, addr, eight);
-                memop = da.memop;
             }
         } else {
             gen_exception(dc, TT_ILL_INSN);
@@ -2384,10 +2385,9 @@ gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 
     case GET_ASI_SHORT:
         /* Valid for lddfa only.  */
-        if (size == 8) {
-            gen_address_mask(dc, addr);
-            tcg_gen_qemu_ld_i64(cpu_fpr[rd / 2], addr, da.mem_idx,
-                                da.memop | MO_ALIGN);
+        if (orig_size == MO_64) {
+            tcg_gen_qemu_ld_i64(cpu_fpr[rd / 2], addr, da->mem_idx,
+                                memop | MO_ALIGN);
         } else {
             gen_exception(dc, TT_ILL_INSN);
         }
@@ -2395,8 +2395,8 @@ gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 
     default:
         {
-            TCGv_i32 r_asi = tcg_constant_i32(da.asi);
-            TCGv_i32 r_mop = tcg_constant_i32(da.memop | MO_ALIGN);
+            TCGv_i32 r_asi = tcg_constant_i32(da->asi);
+            TCGv_i32 r_mop = tcg_constant_i32(memop | MO_ALIGN);
 
             save_state(dc);
             /* According to the table in the UA2011 manual, the only
@@ -2404,21 +2404,23 @@ gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
                the NO_FAULT asis.  We still need a helper for these,
                but we can just use the integer asi helper for them.  */
             switch (size) {
-            case 4:
+            case MO_32:
                 d64 = tcg_temp_new_i64();
                 gen_helper_ld_asi(d64, tcg_env, addr, r_asi, r_mop);
                 d32 = gen_dest_fpr_F(dc);
                 tcg_gen_extrl_i64_i32(d32, d64);
                 gen_store_fpr_F(dc, rd, d32);
                 break;
-            case 8:
-                gen_helper_ld_asi(cpu_fpr[rd / 2], tcg_env, addr, r_asi, r_mop);
+            case MO_64:
+                gen_helper_ld_asi(cpu_fpr[rd / 2], tcg_env, addr,
+                                  r_asi, r_mop);
                 break;
-            case 16:
+            case MO_128:
                 d64 = tcg_temp_new_i64();
                 gen_helper_ld_asi(d64, tcg_env, addr, r_asi, r_mop);
                 tcg_gen_addi_tl(addr, addr, 8);
-                gen_helper_ld_asi(cpu_fpr[rd/2+1], tcg_env, addr, r_asi, r_mop);
+                gen_helper_ld_asi(cpu_fpr[rd / 2 + 1], tcg_env, addr,
+                                  r_asi, r_mop);
                 tcg_gen_mov_i64(cpu_fpr[rd / 2], d64);
                 break;
             default:
@@ -2430,36 +2432,52 @@ gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 }
 
 static void __attribute__((unused))
-gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
+gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 {
-    DisasASI da = get_asi(dc, insn, (size == 4 ? MO_TEUL : MO_TEUQ));
+    MemOp sz = ctz32(size);
+    DisasASI da = get_asi(dc, insn, MO_TE | sz);
+
+    gen_address_mask(dc, addr);
+    gen_ldf_asi0(dc, &da, sz, addr, rd);
+}
+
+static void gen_stf_asi0(DisasContext *dc, DisasASI *da, MemOp orig_size,
+                         TCGv addr, int rd)
+{
+    MemOp memop = da->memop;
+    MemOp size = memop & MO_SIZE;
     TCGv_i32 d32;
 
-    switch (da.type) {
+    /* TODO: Use 128-bit load/store below. */
+    if (size == MO_128) {
+        memop = (memop & ~MO_SIZE) | MO_64;
+    }
+
+    switch (da->type) {
     case GET_ASI_EXCP:
         break;
 
     case GET_ASI_DIRECT:
-        gen_address_mask(dc, addr);
+        memop |= MO_ALIGN_4;
         switch (size) {
-        case 4:
+        case MO_32:
             d32 = gen_load_fpr_F(dc, rd);
-            tcg_gen_qemu_st_i32(d32, addr, da.mem_idx, da.memop | MO_ALIGN);
+            tcg_gen_qemu_st_i32(d32, addr, da->mem_idx, memop | MO_ALIGN);
             break;
-        case 8:
-            tcg_gen_qemu_st_i64(cpu_fpr[rd / 2], addr, da.mem_idx,
-                                da.memop | MO_ALIGN_4);
+        case MO_64:
+            tcg_gen_qemu_st_i64(cpu_fpr[rd / 2], addr, da->mem_idx,
+                                memop | MO_ALIGN_4);
             break;
-        case 16:
+        case MO_128:
             /* Only 4-byte alignment required.  However, it is legal for the
                cpu to signal the alignment fault, and the OS trap handler is
                required to fix it up.  Requiring 16-byte alignment here avoids
                having to probe the second page before performing the first
                write.  */
-            tcg_gen_qemu_st_i64(cpu_fpr[rd / 2], addr, da.mem_idx,
-                                da.memop | MO_ALIGN_16);
+            tcg_gen_qemu_st_i64(cpu_fpr[rd / 2], addr, da->mem_idx,
+                                memop | MO_ALIGN_16);
             tcg_gen_addi_tl(addr, addr, 8);
-            tcg_gen_qemu_st_i64(cpu_fpr[rd/2+1], addr, da.mem_idx, da.memop);
+            tcg_gen_qemu_st_i64(cpu_fpr[rd / 2 + 1], addr, da->mem_idx, memop);
             break;
         default:
             g_assert_not_reached();
@@ -2468,24 +2486,19 @@ gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 
     case GET_ASI_BLOCK:
         /* Valid for stdfa on aligned registers only.  */
-        if (size == 8 && (rd & 7) == 0) {
-            MemOp memop;
+        if (orig_size == MO_64 && (rd & 7) == 0) {
             TCGv eight;
             int i;
 
-            gen_address_mask(dc, addr);
-
             /* The first operation checks required alignment.  */
-            memop = da.memop | MO_ALIGN_64;
             eight = tcg_constant_tl(8);
             for (i = 0; ; ++i) {
-                tcg_gen_qemu_st_i64(cpu_fpr[rd / 2 + i], addr,
-                                    da.mem_idx, memop);
+                tcg_gen_qemu_st_i64(cpu_fpr[rd / 2 + i], addr, da->mem_idx,
+                                    memop | (i == 0 ? MO_ALIGN_64 : 0));
                 if (i == 7) {
                     break;
                 }
                 tcg_gen_add_tl(addr, addr, eight);
-                memop = da.memop;
             }
         } else {
             gen_exception(dc, TT_ILL_INSN);
@@ -2494,10 +2507,9 @@ gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 
     case GET_ASI_SHORT:
         /* Valid for stdfa only.  */
-        if (size == 8) {
-            gen_address_mask(dc, addr);
-            tcg_gen_qemu_st_i64(cpu_fpr[rd / 2], addr, da.mem_idx,
-                                da.memop | MO_ALIGN);
+        if (orig_size == MO_64) {
+            tcg_gen_qemu_st_i64(cpu_fpr[rd / 2], addr, da->mem_idx,
+                                memop | MO_ALIGN);
         } else {
             gen_exception(dc, TT_ILL_INSN);
         }
@@ -2512,6 +2524,16 @@ gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
     }
 }
 
+static void __attribute__((unused))
+gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
+{
+    MemOp sz = ctz32(size);
+    DisasASI da = get_asi(dc, insn, MO_TE | sz);
+
+    gen_address_mask(dc, addr);
+    gen_stf_asi0(dc, &da, sz, addr, rd);
+}
+
 static void gen_ldda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
 {
     TCGv hi = gen_dest_gpr(dc, rd);
-- 
2.34.1


