Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C662A7359A1
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:33:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFtb-0001pm-KO; Mon, 19 Jun 2023 10:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsp-0000eB-K3
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:31 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsl-0002F7-W1
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:30 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4f6283d0d84so4574906e87.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184965; x=1689776965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ecFzLygpAx1acENNT2vpDRF7LirFVwYSwEwJOiBRXNw=;
 b=dw0Y9OkdwRM6niVfLFQQN+pPcgH7yplnpRCyI0FtZRsi07ClNjpvlNwgeHw7CBqJ83
 ixkky6w8rrvZBUDBqTledNeLAc4iSH00yNm5nj7XwvcBcrctBkOQ76AYv0u8pelE+8nK
 X4xhj/RQ5IzAFvBhyBrCx1jLVVz8ea1PhduAD8bBmxOaK7LBZFD5yycUNS4eGhrlXzjX
 l7mQvse3ZHx2J3dYpPVGqaaRBTmatjaKJgY5b4z0wAmjTDT9V2C60h203GyKTd6woC71
 S+KRdJPYN5FuEJJduRhEEsCIOSsagi5TyYiJDl8Y/aHMokU4zaRvT4hcegLCagYp4RRQ
 QEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184966; x=1689776966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ecFzLygpAx1acENNT2vpDRF7LirFVwYSwEwJOiBRXNw=;
 b=Ds7q97SUrtehi2QvBIGXIJ7y4wYCf9+BkyZXUq82xcAughiJKNpk5zFzfKpj+7+Bfx
 7CAuTjE0azQcQ1W2fJ333Yeh5xflCb7MfC1MSHuUMbUGN9mVKazGDcZVTvm6nm+H3/qT
 o8c+E9qX4NkjDOoAjZwVKViT4tJStOWaNPBIokU5YZVBqPoeVnJC1nL/XcjfR6RvYgRA
 w4Q2/gsFTYlYbesH2RMyIzTFcivvhFTk3zd637olagwPhn0rMsrR6f73RQvZ+WzMimTt
 9qbdHC2XSLcALf13+gvaEMzmFfEqab689Nz9Jzf5kysV3xv6wAB0T0Mc4EpwoHRWXfl7
 CAVg==
X-Gm-Message-State: AC+VfDxMizBVTnYQAeUjyyNpbRKNVGPrV1s6ogeUhiN7is6kKtKZKs8F
 UHcF8dXNZ36erI7t62a8twZlKhOPmQSGL1ZNtCE=
X-Google-Smtp-Source: ACHHUZ69RSulJoZptmSnesqUeq/Z9cn2Fm5GQV/XdmQxVOMsUimjoUw1a4kjunSq3NIOwv9n+VTtWA==
X-Received: by 2002:a19:3851:0:b0:4f5:a181:97bf with SMTP id
 d17-20020a193851000000b004f5a18197bfmr4751203lfj.58.1687184965704; 
 Mon, 19 Jun 2023 07:29:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/33] target/arm: Convert load/store (multiple structures) to
 decodetree
Date: Mon, 19 Jun 2023 15:29:02 +0100
Message-Id: <20230619142914.963184-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

Convert the instructions in the ASIMD load/store multiple structures
instruction classes to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230602155223.2040685-19-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |  20 +++
 target/arm/tcg/translate-a64.c | 222 ++++++++++++++++-----------------
 2 files changed, 131 insertions(+), 111 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index db4f44c4f40..69bdfa2e73b 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -474,3 +474,23 @@ LDAPR_i         01 011001 10 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext
 LDAPR_i         10 011001 10 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=0 sz=2
 LDAPR_i         00 011001 11 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=1 sz=0
 LDAPR_i         01 011001 11 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=1 sz=1
+
+# Load/store multiple structures
+# The 4-bit opcode in [15:12] encodes repeat count and structure elements
+&ldst_mult      rm rn rt sz q p rpt selem
+@ldst_mult      . q:1 ...... p:1 . . rm:5 .... sz:2 rn:5 rt:5 &ldst_mult
+ST_mult         0 . 001100 . 0 0 ..... 0000 .. ..... ..... @ldst_mult rpt=1 selem=4
+ST_mult         0 . 001100 . 0 0 ..... 0010 .. ..... ..... @ldst_mult rpt=4 selem=1
+ST_mult         0 . 001100 . 0 0 ..... 0100 .. ..... ..... @ldst_mult rpt=1 selem=3
+ST_mult         0 . 001100 . 0 0 ..... 0110 .. ..... ..... @ldst_mult rpt=3 selem=1
+ST_mult         0 . 001100 . 0 0 ..... 0111 .. ..... ..... @ldst_mult rpt=1 selem=1
+ST_mult         0 . 001100 . 0 0 ..... 1000 .. ..... ..... @ldst_mult rpt=1 selem=2
+ST_mult         0 . 001100 . 0 0 ..... 1010 .. ..... ..... @ldst_mult rpt=2 selem=1
+
+LD_mult         0 . 001100 . 1 0 ..... 0000 .. ..... ..... @ldst_mult rpt=1 selem=4
+LD_mult         0 . 001100 . 1 0 ..... 0010 .. ..... ..... @ldst_mult rpt=4 selem=1
+LD_mult         0 . 001100 . 1 0 ..... 0100 .. ..... ..... @ldst_mult rpt=1 selem=3
+LD_mult         0 . 001100 . 1 0 ..... 0110 .. ..... ..... @ldst_mult rpt=3 selem=1
+LD_mult         0 . 001100 . 1 0 ..... 0111 .. ..... ..... @ldst_mult rpt=1 selem=1
+LD_mult         0 . 001100 . 1 0 ..... 1000 .. ..... ..... @ldst_mult rpt=1 selem=2
+LD_mult         0 . 001100 . 1 0 ..... 1010 .. ..... ..... @ldst_mult rpt=2 selem=1
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c0d38c48798..f2d9ceeed04 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3414,99 +3414,28 @@ static bool trans_STLR_i(DisasContext *s, arg_ldapr_stlr_i *a)
     return true;
 }
 
-/* AdvSIMD load/store multiple structures
- *
- *  31  30  29           23 22  21         16 15    12 11  10 9    5 4    0
- * +---+---+---------------+---+-------------+--------+------+------+------+
- * | 0 | Q | 0 0 1 1 0 0 0 | L | 0 0 0 0 0 0 | opcode | size |  Rn  |  Rt  |
- * +---+---+---------------+---+-------------+--------+------+------+------+
- *
- * AdvSIMD load/store multiple structures (post-indexed)
- *
- *  31  30  29           23 22  21  20     16 15    12 11  10 9    5 4    0
- * +---+---+---------------+---+---+---------+--------+------+------+------+
- * | 0 | Q | 0 0 1 1 0 0 1 | L | 0 |   Rm    | opcode | size |  Rn  |  Rt  |
- * +---+---+---------------+---+---+---------+--------+------+------+------+
- *
- * Rt: first (or only) SIMD&FP register to be transferred
- * Rn: base address or SP
- * Rm (post-index only): post-index register (when !31) or size dependent #imm
- */
-static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
+static bool trans_LD_mult(DisasContext *s, arg_ldst_mult *a)
 {
-    int rt = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int rm = extract32(insn, 16, 5);
-    int size = extract32(insn, 10, 2);
-    int opcode = extract32(insn, 12, 4);
-    bool is_store = !extract32(insn, 22, 1);
-    bool is_postidx = extract32(insn, 23, 1);
-    bool is_q = extract32(insn, 30, 1);
     TCGv_i64 clean_addr, tcg_rn, tcg_ebytes;
     MemOp endian, align, mop;
 
     int total;    /* total bytes */
     int elements; /* elements per vector */
-    int rpt;    /* num iterations */
-    int selem;  /* structure elements */
     int r;
+    int size = a->sz;
 
-    if (extract32(insn, 31, 1) || extract32(insn, 21, 1)) {
-        unallocated_encoding(s);
-        return;
+    if (!a->p && a->rm != 0) {
+        /* For non-postindexed accesses the Rm field must be 0 */
+        return false;
     }
-
-    if (!is_postidx && rm != 0) {
-        unallocated_encoding(s);
-        return;
+    if (size == 3 && !a->q && a->selem != 1) {
+        return false;
     }
-
-    /* From the shared decode logic */
-    switch (opcode) {
-    case 0x0:
-        rpt = 1;
-        selem = 4;
-        break;
-    case 0x2:
-        rpt = 4;
-        selem = 1;
-        break;
-    case 0x4:
-        rpt = 1;
-        selem = 3;
-        break;
-    case 0x6:
-        rpt = 3;
-        selem = 1;
-        break;
-    case 0x7:
-        rpt = 1;
-        selem = 1;
-        break;
-    case 0x8:
-        rpt = 1;
-        selem = 2;
-        break;
-    case 0xa:
-        rpt = 2;
-        selem = 1;
-        break;
-    default:
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (size == 3 && !is_q && selem != 1) {
-        /* reserved */
-        unallocated_encoding(s);
-        return;
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
 
@@ -3516,22 +3445,22 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
         endian = MO_LE;
     }
 
-    total = rpt * selem * (is_q ? 16 : 8);
-    tcg_rn = cpu_reg_sp(s, rn);
+    total = a->rpt * a->selem * (a->q ? 16 : 8);
+    tcg_rn = cpu_reg_sp(s, a->rn);
 
     /*
      * Issue the MTE check vs the logical repeat count, before we
      * promote consecutive little-endian elements below.
      */
-    clean_addr = gen_mte_checkN(s, tcg_rn, is_store, is_postidx || rn != 31,
-                                total, finalize_memop_asimd(s, size));
+    clean_addr = gen_mte_checkN(s, tcg_rn, false, a->p || a->rn != 31, total,
+                                finalize_memop_asimd(s, size));
 
     /*
      * Consecutive little-endian elements from a single register
      * can be promoted to a larger little-endian operation.
      */
     align = MO_ALIGN;
-    if (selem == 1 && endian == MO_LE) {
+    if (a->selem == 1 && endian == MO_LE) {
         align = pow2_align(size);
         size = 3;
     }
@@ -3540,45 +3469,119 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
     }
     mop = endian | size | align;
 
-    elements = (is_q ? 16 : 8) >> size;
+    elements = (a->q ? 16 : 8) >> size;
     tcg_ebytes = tcg_constant_i64(1 << size);
-    for (r = 0; r < rpt; r++) {
+    for (r = 0; r < a->rpt; r++) {
         int e;
         for (e = 0; e < elements; e++) {
             int xs;
-            for (xs = 0; xs < selem; xs++) {
-                int tt = (rt + r + xs) % 32;
-                if (is_store) {
-                    do_vec_st(s, tt, e, clean_addr, mop);
-                } else {
-                    do_vec_ld(s, tt, e, clean_addr, mop);
-                }
+            for (xs = 0; xs < a->selem; xs++) {
+                int tt = (a->rt + r + xs) % 32;
+                do_vec_ld(s, tt, e, clean_addr, mop);
                 tcg_gen_add_i64(clean_addr, clean_addr, tcg_ebytes);
             }
         }
     }
 
-    if (!is_store) {
-        /* For non-quad operations, setting a slice of the low
-         * 64 bits of the register clears the high 64 bits (in
-         * the ARM ARM pseudocode this is implicit in the fact
-         * that 'rval' is a 64 bit wide variable).
-         * For quad operations, we might still need to zero the
-         * high bits of SVE.
-         */
-        for (r = 0; r < rpt * selem; r++) {
-            int tt = (rt + r) % 32;
-            clear_vec_high(s, is_q, tt);
+    /*
+     * For non-quad operations, setting a slice of the low 64 bits of
+     * the register clears the high 64 bits (in the ARM ARM pseudocode
+     * this is implicit in the fact that 'rval' is a 64 bit wide
+     * variable).  For quad operations, we might still need to zero
+     * the high bits of SVE.
+     */
+    for (r = 0; r < a->rpt * a->selem; r++) {
+        int tt = (a->rt + r) % 32;
+        clear_vec_high(s, a->q, tt);
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
+static bool trans_ST_mult(DisasContext *s, arg_ldst_mult *a)
+{
+    TCGv_i64 clean_addr, tcg_rn, tcg_ebytes;
+    MemOp endian, align, mop;
+
+    int total;    /* total bytes */
+    int elements; /* elements per vector */
+    int r;
+    int size = a->sz;
+
+    if (!a->p && a->rm != 0) {
+        /* For non-postindexed accesses the Rm field must be 0 */
+        return false;
+    }
+    if (size == 3 && !a->q && a->selem != 1) {
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
+    /* For our purposes, bytes are always little-endian.  */
+    endian = s->be_data;
+    if (size == 0) {
+        endian = MO_LE;
+    }
+
+    total = a->rpt * a->selem * (a->q ? 16 : 8);
+    tcg_rn = cpu_reg_sp(s, a->rn);
+
+    /*
+     * Issue the MTE check vs the logical repeat count, before we
+     * promote consecutive little-endian elements below.
+     */
+    clean_addr = gen_mte_checkN(s, tcg_rn, true, a->p || a->rn != 31, total,
+                                finalize_memop_asimd(s, size));
+
+    /*
+     * Consecutive little-endian elements from a single register
+     * can be promoted to a larger little-endian operation.
+     */
+    align = MO_ALIGN;
+    if (a->selem == 1 && endian == MO_LE) {
+        align = pow2_align(size);
+        size = 3;
+    }
+    if (!s->align_mem) {
+        align = 0;
+    }
+    mop = endian | size | align;
+
+    elements = (a->q ? 16 : 8) >> size;
+    tcg_ebytes = tcg_constant_i64(1 << size);
+    for (r = 0; r < a->rpt; r++) {
+        int e;
+        for (e = 0; e < elements; e++) {
+            int xs;
+            for (xs = 0; xs < a->selem; xs++) {
+                int tt = (a->rt + r + xs) % 32;
+                do_vec_st(s, tt, e, clean_addr, mop);
+                tcg_gen_add_i64(clean_addr, clean_addr, tcg_ebytes);
+            }
         }
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
 }
 
 /* AdvSIMD load/store single structure
@@ -3931,9 +3934,6 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
 static void disas_ldst(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 24, 6)) {
-    case 0x0c: /* AdvSIMD load/store multiple structures */
-        disas_ldst_multiple_struct(s, insn);
-        break;
     case 0x0d: /* AdvSIMD load/store single structure */
         disas_ldst_single_struct(s, insn);
         break;
-- 
2.34.1


