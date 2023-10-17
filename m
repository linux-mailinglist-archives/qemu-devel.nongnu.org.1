Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 602F47CBB35
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:29:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNn-0003JV-Ag; Tue, 17 Oct 2023 02:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNZ-0002xm-Sm
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:35 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNX-0004iM-Ob
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:33 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6c7bbfb7a73so3614787a34.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523390; x=1698128190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3d0wuJleGzi80YFJZIm7tQsbxOIGrrhLpnqdAP71A+g=;
 b=nf3eB9cFlUmkCjwYwc1/8UWpHDqs3dYgr4KAITGLfd2OK5fd1NGUv/3FTpA/nP4YUN
 YcKY0Rkjhl2+AWSW6WEvhz2CtJwX1hCHjWx4vc45Hdr/A+rx04kxfhCHwO8WHzT8fwUi
 Zw3nvv2xXiwr0MJcBLF3sNU2Uk6yv7JMAmv+Oa1ybpD8ww8aBQOnCC8JNzCniHGgu97p
 pFLg7xAY/CcMA5YjklGK4tT+qF/xpG33akLkgUC8ZHZhgbohZvIqQAR+L6idVcmnOgNo
 +3YRW0o2I3SPwZhMaEBLuNEHudKafy5KcfI5G20GqHD5mFE9QqTBiFSNgFes0F3x9YUE
 03SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523390; x=1698128190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3d0wuJleGzi80YFJZIm7tQsbxOIGrrhLpnqdAP71A+g=;
 b=q/igljeCoGCnv0MOtq97GSSctI9IqugIu2rEpFjB+3SsVISaj/oT0t3Ja12xyheULW
 445vtAeska6qfbOocexWvYxuKs5xF2xUBGQg+gdBH0ugQErwopI6zx1LzCU0RiLHMGvu
 3OZD76wtEJMcGfUCWKVGrEEzHMAQH0ZdJ6KRaxoyhViIAtObRGvYh9Xu5U+Y3umSJEnx
 qi0/qxvHQMdjYnB6G3PvNbZWtOhnLvWJ1j+aR+gK8t3a2LmGV44QttUrvVBJD/QWHRhL
 r/joQ/n1HY3Q93soIHnhPy3apCnnrpCZjVBqYu0ZUCQvVxP9rW2nRr3QZJwouOai+q8a
 h/uw==
X-Gm-Message-State: AOJu0Yz4eZ2o82+jEMt2D/92OG0W2i14R6p1eShq64uLb6LSvY5XG7cZ
 1gkxPOl8zoi2WspjjrnCrCbkoJ3H3oCLZ1EOHd8=
X-Google-Smtp-Source: AGHT+IHvFIuUz2pcDujs/yyr17VXCA+gvYQByXwU0wkMPzema1/bPAnfEY8KIDhe9IMAnxo5Y6x1xA==
X-Received: by 2002:a9d:74d5:0:b0:6bd:63b:4b21 with SMTP id
 a21-20020a9d74d5000000b006bd063b4b21mr1418167otl.15.1697523390520; 
 Mon, 16 Oct 2023 23:16:30 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 54/90] target/sparc: Split out fp ldst functions with asi
 precomputed
Date: Mon, 16 Oct 2023 23:12:08 -0700
Message-Id: <20231017061244.681584-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 136 ++++++++++++++++++++++-----------------
 1 file changed, 78 insertions(+), 58 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1b402de49f..822e74fa3e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2263,35 +2263,40 @@ static void gen_ldstub_asi(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
     }
 }
 
-static void __attribute__((unused))
-gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
+static void gen_ldf_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
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
@@ -2301,24 +2306,19 @@ gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 
     case GET_ASI_BLOCK:
         /* Valid for lddfa on aligned registers only.  */
-        if (size == 8 && (rd & 7) == 0) {
-            MemOp memop;
+        if (size == MO_64 && (rd & 7) == 0) {
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
@@ -2327,10 +2327,9 @@ gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 
     case GET_ASI_SHORT:
         /* Valid for lddfa only.  */
-        if (size == 8) {
-            gen_address_mask(dc, addr);
-            tcg_gen_qemu_ld_i64(cpu_fpr[rd / 2], addr, da.mem_idx,
-                                da.memop | MO_ALIGN);
+        if (size == MO_64) {
+            tcg_gen_qemu_ld_i64(cpu_fpr[rd / 2], addr, da->mem_idx,
+                                memop | MO_ALIGN);
         } else {
             gen_exception(dc, TT_ILL_INSN);
         }
@@ -2338,8 +2337,8 @@ gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 
     default:
         {
-            TCGv_i32 r_asi = tcg_constant_i32(da.asi);
-            TCGv_i32 r_mop = tcg_constant_i32(da.memop | MO_ALIGN);
+            TCGv_i32 r_asi = tcg_constant_i32(da->asi);
+            TCGv_i32 r_mop = tcg_constant_i32(memop | MO_ALIGN);
 
             save_state(dc);
             /* According to the table in the UA2011 manual, the only
@@ -2347,21 +2346,23 @@ gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
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
@@ -2373,36 +2374,51 @@ gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 }
 
 static void __attribute__((unused))
-gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
+gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 {
-    DisasASI da = get_asi(dc, insn, (size == 4 ? MO_TEUL : MO_TEUQ));
+    DisasASI da = get_asi(dc, insn, (size == 4 ? MO_TEUL :
+                                     size == 8 ? MO_TEUQ : MO_TE | MO_128));
+
+    gen_address_mask(dc, addr);
+    gen_ldf_asi0(dc, &da, addr, rd);
+}
+
+static void gen_stf_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
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
@@ -2411,24 +2427,19 @@ gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 
     case GET_ASI_BLOCK:
         /* Valid for stdfa on aligned registers only.  */
-        if (size == 8 && (rd & 7) == 0) {
-            MemOp memop;
+        if (size == MO_64 && (rd & 7) == 0) {
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
@@ -2437,10 +2448,9 @@ gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 
     case GET_ASI_SHORT:
         /* Valid for stdfa only.  */
-        if (size == 8) {
-            gen_address_mask(dc, addr);
-            tcg_gen_qemu_st_i64(cpu_fpr[rd / 2], addr, da.mem_idx,
-                                da.memop | MO_ALIGN);
+        if (size == MO_64) {
+            tcg_gen_qemu_st_i64(cpu_fpr[rd / 2], addr, da->mem_idx,
+                                memop | MO_ALIGN);
         } else {
             gen_exception(dc, TT_ILL_INSN);
         }
@@ -2455,6 +2465,16 @@ gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
     }
 }
 
+static void __attribute__((unused))
+gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
+{
+    DisasASI da = get_asi(dc, insn, (size == 4 ? MO_TEUL :
+                                     size == 8 ? MO_TEUQ : MO_TE | MO_128));
+
+    gen_address_mask(dc, addr);
+    gen_stf_asi0(dc, &da, addr, rd);
+}
+
 static void gen_ldda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
 {
     TCGv hi = gen_dest_gpr(dc, rd);
-- 
2.34.1


