Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BE472B2BC
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 18:04:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8NVk-0006eY-91; Sun, 11 Jun 2023 12:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUt-000611-48
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:01:00 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUm-0000XV-El
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:54 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f7f6341bf9so35039965e9.1
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686499246; x=1689091246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Tjmthin5TQuDssMEMCBUr/UdC5X7+Wb+s2H58zsniSY=;
 b=Lju/q0TO9G1cE68bmBTRp3Nf1tEI8A/zakHeNQNTRrvYHijd3iYUeeqrH9yjUVsXiR
 Myq/OQ1MMkVdnFElEbVyBZ3JyIBAUTNNZTVvQin2carC/o3z/4DGrQZ3LxUzO7CqS77g
 yyLA5IYj5X7E81JuqAPdYlJBUuafGAcTA2bmjZTdOZ4Rg3az/2diw1VaM5VuACxqIKq6
 J24POTSNFy7nwL7OciLcSW/DE080pYbEwIf0aig/XKeqJ7QMAhaQLPv003VDRjpmQ4Yp
 kz2bdYDqf7OKLqS+bPwzICQtwEMyuJ+8+ggwSLJkjmm1eB0G5ARjPJfqJc8XTdCOCXOx
 +Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686499246; x=1689091246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tjmthin5TQuDssMEMCBUr/UdC5X7+Wb+s2H58zsniSY=;
 b=d+szbYstzrDcqcSI0EdIvri27B25voEh6ckf8T0acESztOeISddHAUnhu0kvJlKOOL
 ZR9gUf9pehB9sgIPhJgKOrU1D+6bNzWjne5HzWv4GpC7qp6Irdwl1YEIQE73ON3PvBSG
 SiwOcGWRacTDt2aRqNvHhc0fOCtV/EFu1d4+H9CoYJdbtL6Br2uEsXaW9lXFu2yzbEQ5
 OM+FbltaLP7mtIDAiCRGTbNOI3tJEqZfst3yGJMX7mPfAF+qB4t6+QnYBCP9YnhDAGxD
 b6IKlBOajLpZiWG+2YDpwF1WSfyFUfy19uMpBNYIA6X0pY17JuN22Dvtky0BfRkPVdnz
 779g==
X-Gm-Message-State: AC+VfDxYya0g8X52Ar7EN31ZizvK+VFqv5DpYCA27ft5Eicehvwa9O4H
 NaSsZu8u6FOwfDmfCpou87HbHVtvL0VqPhnbX3I=
X-Google-Smtp-Source: ACHHUZ5e3mwyeyrp6feU+7cHXcnKxUrnfXm8LGRRXp4qV9ESAaY7WbStESCZ44QXipirGe+SpsPasQ==
X-Received: by 2002:a5d:6107:0:b0:30a:ec3b:58d8 with SMTP id
 v7-20020a5d6107000000b0030aec3b58d8mr3326192wrt.3.1686499246427; 
 Sun, 11 Jun 2023 09:00:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a056000008900b0030ae499da59sm9923022wrx.111.2023.06.11.09.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 09:00:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 22/23] target/arm: Convert load/store single structure to
 decodetree
Date: Sun, 11 Jun 2023 17:00:31 +0100
Message-Id: <20230611160032.274823-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611160032.274823-1-peter.maydell@linaro.org>
References: <20230611160032.274823-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Convert the ASIMD load/store single structure insns to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230602155223.2040685-20-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |  34 +++++
 target/arm/tcg/translate-a64.c | 219 +++++++++++++++------------------
 2 files changed, 136 insertions(+), 117 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 69bdfa2e73b..4ffdc91865f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -494,3 +494,37 @@ LD_mult         0 . 001100 . 1 0 ..... 0110 .. ..... ..... @ldst_mult rpt=3 sele
 LD_mult         0 . 001100 . 1 0 ..... 0111 .. ..... ..... @ldst_mult rpt=1 selem=1
 LD_mult         0 . 001100 . 1 0 ..... 1000 .. ..... ..... @ldst_mult rpt=1 selem=2
 LD_mult         0 . 001100 . 1 0 ..... 1010 .. ..... ..... @ldst_mult rpt=2 selem=1
+
+# Load/store single structure
+&ldst_single    rm rn rt p selem index scale
+
+%ldst_single_selem 13:1 21:1 !function=plus_1
+
+%ldst_single_index_b  30:1 10:3
+%ldst_single_index_h  30:1 11:2
+%ldst_single_index_s  30:1 12:1
+
+@ldst_single_b     .. ...... p:1 .. rm:5 ...... rn:5 rt:5 \
+                   &ldst_single scale=0 selem=%ldst_single_selem \
+                   index=%ldst_single_index_b
+@ldst_single_h     .. ...... p:1 .. rm:5 ...... rn:5 rt:5 \
+                   &ldst_single scale=1 selem=%ldst_single_selem \
+                   index=%ldst_single_index_h
+@ldst_single_s     .. ...... p:1 .. rm:5 ...... rn:5 rt:5 \
+                   &ldst_single scale=2 selem=%ldst_single_selem \
+                   index=%ldst_single_index_s
+@ldst_single_d     . index:1 ...... p:1 .. rm:5 ...... rn:5 rt:5 \
+                   &ldst_single scale=3 selem=%ldst_single_selem
+
+ST_single          0 . 001101 . 0 . ..... 00 . ... ..... .....  @ldst_single_b
+ST_single          0 . 001101 . 0 . ..... 01 . ..0 ..... .....  @ldst_single_h
+ST_single          0 . 001101 . 0 . ..... 10 . .00 ..... .....  @ldst_single_s
+ST_single          0 . 001101 . 0 . ..... 10 . 001 ..... .....  @ldst_single_d
+
+LD_single          0 . 001101 . 1 . ..... 00 . ... ..... .....  @ldst_single_b
+LD_single          0 . 001101 . 1 . ..... 01 . ..0 ..... .....  @ldst_single_h
+LD_single          0 . 001101 . 1 . ..... 10 . .00 ..... .....  @ldst_single_s
+LD_single          0 . 001101 . 1 . ..... 10 . 001 ..... .....  @ldst_single_d
+
+# Replicating load case
+LD_single_repl  0 q:1 001101 p:1 1 . rm:5 11 . 0 scale:2 rn:5 rt:5 selem=%ldst_single_selem
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1c8a57f7b52..6e7fe1f35cf 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3587,141 +3587,129 @@ static bool trans_ST_mult(DisasContext *s, arg_ldst_mult *a)
     return true;
 }
 
-/* AdvSIMD load/store single structure
- *
- *  31  30  29           23 22 21 20       16 15 13 12  11  10 9    5 4    0
- * +---+---+---------------+-----+-----------+-----+---+------+------+------+
- * | 0 | Q | 0 0 1 1 0 1 0 | L R | 0 0 0 0 0 | opc | S | size |  Rn  |  Rt  |
- * +---+---+---------------+-----+-----------+-----+---+------+------+------+
- *
- * AdvSIMD load/store single structure (post-indexed)
- *
- *  31  30  29           23 22 21 20       16 15 13 12  11  10 9    5 4    0
- * +---+---+---------------+-----+-----------+-----+---+------+------+------+
- * | 0 | Q | 0 0 1 1 0 1 1 | L R |     Rm    | opc | S | size |  Rn  |  Rt  |
- * +---+---+---------------+-----+-----------+-----+---+------+------+------+
- *
- * Rt: first (or only) SIMD&FP register to be transferred
- * Rn: base address or SP
- * Rm (post-index only): post-index register (when !31) or size dependent #imm
- * index = encoded in Q:S:size dependent on size
- *
- * lane_size = encoded in R, opc
- * transfer width = encoded in opc, S, size
- */
-static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
+static bool trans_ST_single(DisasContext *s, arg_ldst_single *a)
 {
-    int rt = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int rm = extract32(insn, 16, 5);
-    int size = extract32(insn, 10, 2);
-    int S = extract32(insn, 12, 1);
-    int opc = extract32(insn, 13, 3);
-    int R = extract32(insn, 21, 1);
-    int is_load = extract32(insn, 22, 1);
-    int is_postidx = extract32(insn, 23, 1);
-    int is_q = extract32(insn, 30, 1);
-
-    int scale = extract32(opc, 1, 2);
-    int selem = (extract32(opc, 0, 1) << 1 | R) + 1;
-    bool replicate = false;
-    int index = is_q << 3 | S << 2 | size;
-    int xs, total;
+    int xs, total, rt;
     TCGv_i64 clean_addr, tcg_rn, tcg_ebytes;
     MemOp mop;
 
-    if (extract32(insn, 31, 1)) {
-        unallocated_encoding(s);
-        return;
+    if (!a->p && a->rm != 0) {
+        return false;
     }
-    if (!is_postidx && rm != 0) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (scale) {
-    case 3:
-        if (!is_load || S) {
-            unallocated_encoding(s);
-            return;
-        }
-        scale = size;
-        replicate = true;
-        break;
-    case 0:
-        break;
-    case 1:
-        if (extract32(size, 0, 1)) {
-            unallocated_encoding(s);
-            return;
-        }
-        index >>= 1;
-        break;
-    case 2:
-        if (extract32(size, 1, 1)) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (!extract32(size, 0, 1)) {
-            index >>= 2;
-        } else {
-            if (S) {
-                unallocated_encoding(s);
-                return;
-            }
-            index >>= 3;
-            scale = 3;
-        }
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
     if (!fp_access_check(s)) {
-        return;
+        return true;
     }
 
-    if (rn == 31) {
+    if (a->rn == 31) {
         gen_check_sp_alignment(s);
     }
 
-    total = selem << scale;
-    tcg_rn = cpu_reg_sp(s, rn);
+    total = a->selem << a->scale;
+    tcg_rn = cpu_reg_sp(s, a->rn);
 
-    mop = finalize_memop_asimd(s, scale);
-
-    clean_addr = gen_mte_checkN(s, tcg_rn, !is_load, is_postidx || rn != 31,
+    mop = finalize_memop_asimd(s, a->scale);
+    clean_addr = gen_mte_checkN(s, tcg_rn, true, a->p || a->rn != 31,
                                 total, mop);
 
-    tcg_ebytes = tcg_constant_i64(1 << scale);
-    for (xs = 0; xs < selem; xs++) {
-        if (replicate) {
-            /* Load and replicate to all elements */
-            TCGv_i64 tcg_tmp = tcg_temp_new_i64();
-
-            tcg_gen_qemu_ld_i64(tcg_tmp, clean_addr, get_mem_index(s), mop);
-            tcg_gen_gvec_dup_i64(scale, vec_full_reg_offset(s, rt),
-                                 (is_q + 1) * 8, vec_full_reg_size(s),
-                                 tcg_tmp);
-        } else {
-            /* Load/store one element per register */
-            if (is_load) {
-                do_vec_ld(s, rt, index, clean_addr, mop);
-            } else {
-                do_vec_st(s, rt, index, clean_addr, mop);
-            }
-        }
+    tcg_ebytes = tcg_constant_i64(1 << a->scale);
+    for (xs = 0, rt = a->rt; xs < a->selem; xs++, rt = (rt + 1) % 32) {
+        do_vec_st(s, rt, a->index, clean_addr, mop);
         tcg_gen_add_i64(clean_addr, clean_addr, tcg_ebytes);
-        rt = (rt + 1) % 32;
     }
 
-    if (is_postidx) {
-        if (rm == 31) {
+    if (a->p) {
+        if (a->rm == 31) {
             tcg_gen_addi_i64(tcg_rn, tcg_rn, total);
         } else {
-            tcg_gen_add_i64(tcg_rn, tcg_rn, cpu_reg(s, rm));
+            tcg_gen_add_i64(tcg_rn, tcg_rn, cpu_reg(s, a->rm));
         }
     }
+    return true;
+}
+
+static bool trans_LD_single(DisasContext *s, arg_ldst_single *a)
+{
+    int xs, total, rt;
+    TCGv_i64 clean_addr, tcg_rn, tcg_ebytes;
+    MemOp mop;
+
+    if (!a->p && a->rm != 0) {
+        return false;
+    }
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+
+    total = a->selem << a->scale;
+    tcg_rn = cpu_reg_sp(s, a->rn);
+
+    mop = finalize_memop_asimd(s, a->scale);
+    clean_addr = gen_mte_checkN(s, tcg_rn, false, a->p || a->rn != 31,
+                                total, mop);
+
+    tcg_ebytes = tcg_constant_i64(1 << a->scale);
+    for (xs = 0, rt = a->rt; xs < a->selem; xs++, rt = (rt + 1) % 32) {
+        do_vec_ld(s, rt, a->index, clean_addr, mop);
+        tcg_gen_add_i64(clean_addr, clean_addr, tcg_ebytes);
+    }
+
+    if (a->p) {
+        if (a->rm == 31) {
+            tcg_gen_addi_i64(tcg_rn, tcg_rn, total);
+        } else {
+            tcg_gen_add_i64(tcg_rn, tcg_rn, cpu_reg(s, a->rm));
+        }
+    }
+    return true;
+}
+
+static bool trans_LD_single_repl(DisasContext *s, arg_LD_single_repl *a)
+{
+    int xs, total, rt;
+    TCGv_i64 clean_addr, tcg_rn, tcg_ebytes;
+    MemOp mop;
+
+    if (!a->p && a->rm != 0) {
+        return false;
+    }
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+
+    total = a->selem << a->scale;
+    tcg_rn = cpu_reg_sp(s, a->rn);
+
+    mop = finalize_memop_asimd(s, a->scale);
+    clean_addr = gen_mte_checkN(s, tcg_rn, false, a->p || a->rn != 31,
+                                total, mop);
+
+    tcg_ebytes = tcg_constant_i64(1 << a->scale);
+    for (xs = 0, rt = a->rt; xs < a->selem; xs++, rt = (rt + 1) % 32) {
+        /* Load and replicate to all elements */
+        TCGv_i64 tcg_tmp = tcg_temp_new_i64();
+
+        tcg_gen_qemu_ld_i64(tcg_tmp, clean_addr, get_mem_index(s), mop);
+        tcg_gen_gvec_dup_i64(a->scale, vec_full_reg_offset(s, rt),
+                             (a->q + 1) * 8, vec_full_reg_size(s), tcg_tmp);
+        tcg_gen_add_i64(clean_addr, clean_addr, tcg_ebytes);
+    }
+
+    if (a->p) {
+        if (a->rm == 31) {
+            tcg_gen_addi_i64(tcg_rn, tcg_rn, total);
+        } else {
+            tcg_gen_add_i64(tcg_rn, tcg_rn, cpu_reg(s, a->rm));
+        }
+    }
+    return true;
 }
 
 /*
@@ -3937,9 +3925,6 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
 static void disas_ldst(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 24, 6)) {
-    case 0x0d: /* AdvSIMD load/store single structure */
-        disas_ldst_single_struct(s, insn);
-        break;
     case 0x19:
         if (extract32(insn, 21, 1) != 0) {
             disas_ldst_tag(s, insn);
-- 
2.34.1


