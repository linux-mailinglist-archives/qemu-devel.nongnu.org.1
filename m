Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E977D2165
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:12:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRaV-0002o9-BE; Sun, 22 Oct 2023 02:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRa4-0000q3-DG
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:56 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRZw-0002Fa-Mc
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:55 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-58441865ffaso516097eaf.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954687; x=1698559487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEi9EO+FIbId6BvqeWNibh5o/A3CalHenj5faU92Nh4=;
 b=bD3C1Iq3GkLWFr1Wl5PTdSgCW6o2ZWtmvk+y+OqKrKs6UQdCwmzXoTIW74G35XtOQ2
 FjEYMVhiLpZuZYVvRaYZ0ltdhlFEpdhKXdNFyONMe0tmuGZaZlQpE4w9hRvvylY5JW6y
 J0YzYh0BbmjW0aMP+tMOQqCZu8km4+6DRpcqCU2CoRu0jQXv/SttXktVCJF1GFihbcuO
 Diwaw4lfYmbS6XoD+YF37WmTxD3BtQQA0fdGTcnuuZp36zrJXlUD2EWU/6hFtCFvIbjI
 2s8xuaTyq05Utppo0SocjW568mcEXghVfby0P8X4I6jCXc2I472jq0r8VwEXWUaRiPjM
 ob6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954687; x=1698559487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iEi9EO+FIbId6BvqeWNibh5o/A3CalHenj5faU92Nh4=;
 b=UgHNKCalZrzhyKqjR+8u8rPic5NZ8IclI4Jce2dUvNKz58zLGOFYN54+cMXvx5Nlbn
 hNtXM8bFTujjMD8DLxCQWHbSMGfFp9KVAFRwz16pr5xELz310iJh+iI6BBmU7eJ5n0lk
 OEjyDk9Wv1enQX5JQgK1nSUx8rlJgIwolT49GW+mXK+Y2tvKTMHISPsO9zwO8UCZeE/s
 okbYKTAyaWIO4VAZUxyUgi4TH23qmdWScKAxRYKNKqf+I+Lgi608pEmDtKBTHN4hTnmW
 gZYRCLq36WpfGJd8pEAx5vdnzTbN3Ov3wKpaKRLPsaVsaZHwrc7sl6ARyKUHAMDxI88d
 D7HQ==
X-Gm-Message-State: AOJu0Yw/T3aRHeni6ZsjBSya+I5Fsij1p2Man6EIvUiEV48xME/GDZtN
 hxzbTjjPQyB1ezgFPyxlU8Z/orxxiIYp75LHokQ=
X-Google-Smtp-Source: AGHT+IEgZ9Hz96c1DzJJfhEzgMEUZ41Jtr9v8D5TJ88PpqLU3s90x46dSpFDO1E+lcFXFJe6PAI+DA==
X-Received: by 2002:a05:6358:9895:b0:140:fbfe:d941 with SMTP id
 q21-20020a056358989500b00140fbfed941mr7906278rwa.20.1697954687110; 
 Sat, 21 Oct 2023 23:04:47 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:04:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 54/90] target/sparc: Split out fp ldst functions with asi
 precomputed
Date: Sat, 21 Oct 2023 22:59:55 -0700
Message-Id: <20231022060031.490251-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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
 target/sparc/translate.c | 138 +++++++++++++++++++++++----------------
 1 file changed, 80 insertions(+), 58 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 07bd3c123a..5a385024ce 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2305,35 +2305,41 @@ static void gen_ldstub_asi(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
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
@@ -2343,24 +2349,19 @@ gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 
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
@@ -2369,10 +2370,9 @@ gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 
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
@@ -2380,8 +2380,8 @@ gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 
     default:
         {
-            TCGv_i32 r_asi = tcg_constant_i32(da.asi);
-            TCGv_i32 r_mop = tcg_constant_i32(da.memop | MO_ALIGN);
+            TCGv_i32 r_asi = tcg_constant_i32(da->asi);
+            TCGv_i32 r_mop = tcg_constant_i32(memop | MO_ALIGN);
 
             save_state(dc);
             /* According to the table in the UA2011 manual, the only
@@ -2389,21 +2389,23 @@ gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
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
@@ -2415,36 +2417,52 @@ gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
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
@@ -2453,24 +2471,19 @@ gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 
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
@@ -2479,10 +2492,9 @@ gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 
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
@@ -2497,6 +2509,16 @@ gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
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


