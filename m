Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4287D1B08
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:40:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4ea-0003LX-TI; Sat, 21 Oct 2023 01:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eK-0002Xw-Hw
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:48 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eH-00017C-VE
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:47 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3af609c4dfeso1054084b6e.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866545; x=1698471345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K2PQEuxq+yQBrL7qoakVAwsA2K0bUEaLhrg1z7qMIJ8=;
 b=ymQfKfaRrET4Yxh5OqhcZ0fNiWnZ/YjGeOsvmi2pBvbcH3qmO9rOp8IyDv6zYrjNPT
 h0N+5fojeEu0YQrmd5f/HV2HdP1DZyxN531Li7/8+WeEiEc6ewaepFqa+QGlATXnkNZy
 DijGLvHtd3gV4niV0ud27f4tTTeZdv4kL+SRtQaEQyX+tR8lPX0wnIIjrHpaFeS2MYjG
 6sXx8S4DG6s32QD3qN71aplgiISGS8NzIWOQrbnhp+ofrg9NxndAZ5/FUDTVVQcoS/pO
 i/xMgLRgpiXE4/dCE/wS8yplM61JKt0n+XMHY/X5uinqpjINjf2rJSxjsDezD639eS1p
 u6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866545; x=1698471345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K2PQEuxq+yQBrL7qoakVAwsA2K0bUEaLhrg1z7qMIJ8=;
 b=sWKFW1l76GrDnTpKhzHD8YxsGQCP869agk2IfbEQX6qFzmcTd/s7Fsdl2t32b6+irb
 CjIKE7sNcx/AqVrDAg+E07An1PEWrPLGHE0sExz/Rxtj/0j493HBNMNzo7ho5aCteGCF
 dRqiezdxCHn+mDTHqmZRW5hX3kuDwo2m4052Qys+3+CVoaFgFiU6RNc6wzomXHh7UJ0r
 r0HhT3PUzrEoSTdCc9GZS+LhG6y40HFH53v9geBZnUo8WphnffQWn4pK/no2HbXZwe78
 8EkedjEwDd+ePjIgCvo2Fr9Fs7/+vUBurKddlWhWc5y/nP2ADmGFk9pHcZiiKie0WchP
 JaKg==
X-Gm-Message-State: AOJu0Yy44t3LKVkcShunQYRfM8SNDReTvuKomSQBr37Kju8051iI6PUN
 d4svzYWebD/B223sNdpfh9mnVslAGBTUvxXhqeY=
X-Google-Smtp-Source: AGHT+IGI/pPHpyqN5J4mmhX+osb1s6PCx91l30a5UzdAXh7q7boe5vzfcJ0dTrPgH1ZwwKldIqZGYA==
X-Received: by 2002:a05:6808:15a3:b0:3ae:4ca9:cae5 with SMTP id
 t35-20020a05680815a300b003ae4ca9cae5mr4935644oiw.21.1697866544767; 
 Fri, 20 Oct 2023 22:35:44 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:35:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 54/90] target/sparc: Split out fp ldst functions with asi
 precomputed
Date: Fri, 20 Oct 2023 22:31:22 -0700
Message-Id: <20231021053158.278135-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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
index 9053cafd47..df4a22eb04 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2305,35 +2305,40 @@ static void gen_ldstub_asi(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
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
@@ -2343,24 +2348,19 @@ gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 
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
@@ -2369,10 +2369,9 @@ gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 
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
@@ -2380,8 +2379,8 @@ gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 
     default:
         {
-            TCGv_i32 r_asi = tcg_constant_i32(da.asi);
-            TCGv_i32 r_mop = tcg_constant_i32(da.memop | MO_ALIGN);
+            TCGv_i32 r_asi = tcg_constant_i32(da->asi);
+            TCGv_i32 r_mop = tcg_constant_i32(memop | MO_ALIGN);
 
             save_state(dc);
             /* According to the table in the UA2011 manual, the only
@@ -2389,21 +2388,23 @@ gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
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
@@ -2415,36 +2416,51 @@ gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
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
@@ -2453,24 +2469,19 @@ gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 
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
@@ -2479,10 +2490,9 @@ gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 
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
@@ -2497,6 +2507,16 @@ gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
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


