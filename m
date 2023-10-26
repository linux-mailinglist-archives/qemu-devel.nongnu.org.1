Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 744997D795A
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:23:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo9V-0001R3-L0; Wed, 25 Oct 2023 20:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9P-0000nL-15
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:03 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9K-0008Bl-8P
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:02 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-27d0acd0903so240208a91.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279776; x=1698884576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MS8CtSutyWAJAksCJoGHPpSo/oeGceEkhH07ubL3sMY=;
 b=BygX+Jj9NP+IVqkgQagfv+J67MDHAtp6KEeb+RNQfDj0OXEKauQtg/QaFHkIPh6f7M
 rgM4f1mT+c37T3gEduVYzLuu0xlB1RaXFLvjPY87mlhHLlUsmz7ozt79KvXVf2uWVNFk
 /zTnOCtIDU5EMKhP1VD0Wr1yk0PQzFlLNBM05UIg6xfQI2XOvHQoYr6HxCdKVG1HJOfw
 uA45yGmZK+pDLpukjqOoMiuLSBDdUPg7HkaBlAwGdNYlDVmfM0BGDhGY9qmbFHUmDG29
 QLpYIyDGmJV+uJxdwQ4JUfjEuFDTjCeLOkOeTJpYyUBfoQWRdZGS5fHejq1Ld6ERYjyr
 58nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279776; x=1698884576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MS8CtSutyWAJAksCJoGHPpSo/oeGceEkhH07ubL3sMY=;
 b=htAxAL9rnWA/LSQplEvByUnlz3RMdsuXHNapksK+sFFlhTusssobbV75shmh9hTDW6
 +RfoMrVII+92dRp7U/IHYmO9jx8iNWuEgZzD+SG9r9Ash+m8MqIIffc/lCDX0vzvAw/I
 uliekMx5+l/EvyiIUH8GG/ZeXsPm3wL1Wot9At9limPR1g+iUTRcG6pnjuVOvTWaeOC1
 rQq8qiyvtNOqvEw8z71w2fCo/PFYwkm8tArKYvRmvF2VyytzLl8Rm4tCXX9ymDQj81zu
 LyP+F5uAD525lcDhhV+ouMwsA+ajMoGY8+zxl9JhJ8LBen5l7S5nXuw5n2VZXv1rnsAQ
 pnZg==
X-Gm-Message-State: AOJu0YxRiKrP6hAxumU//O0lvtXRGeiZDlgeun2wMD/emgTAZelJTwSu
 rPss/opH3Y+iBDrzbgCHqcxplFxRtvvKSmxEnbE=
X-Google-Smtp-Source: AGHT+IFDacrXp5DWghQ2gKumDQebG2jRrcGn2iZGQMydEZAYRgTZo08L0COJaIOkuc4ZLg17rhnVGg==
X-Received: by 2002:a17:90b:1093:b0:27d:2c3c:7e25 with SMTP id
 gj19-20020a17090b109300b0027d2c3c7e25mr14823515pjb.46.1698279776085; 
 Wed, 25 Oct 2023 17:22:56 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:22:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 58/94] target/sparc: Split out fp ldst functions with asi
 precomputed
Date: Wed, 25 Oct 2023 17:15:06 -0700
Message-Id: <20231026001542.1141412-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
index 363d8b7fc8..55d6f83736 100644
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


