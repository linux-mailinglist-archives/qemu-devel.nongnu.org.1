Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4636A72B2B3
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 18:02:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8NVi-0006bh-L9; Sun, 11 Jun 2023 12:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUs-00060w-UY
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:01:00 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUl-0000XH-5h
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:54 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-30fb7be435dso470973f8f.1
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686499246; x=1689091246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2RxZp4L2OOp86GeN9wdwmMgvMFkloHNsLM24GLSIa0U=;
 b=eoAJnuGRZa9p4qK/jadAodscf5DyoMNOwEAgGqxG8OtUn1mnpBAZ2lxOkTNpURuWou
 BgkWwGONwLZ74CHChimq4u0rZyDsmS3s9MNXC3J6xXwY0lOiFzeuGocD+vlEx0lpiIVM
 lFkxho2zLtz7Pq360SI2gNhfdyACwHARsJ4buYAAtwdwk22ZKyAgI7hpwqsx/1bs30xo
 AyTHKbcNgpCut45b4vB7Q7BhkqWam4hgEJwf+MIPhsRMiGWNJ7+lppobdBiMSFbM9tIt
 z6r0rmII9lwJ0C/g/G6Z1ACcqS/2c+45iOzDitL390/dZxu2Mi+T2rfTdOQY6ULbd4GQ
 nA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686499246; x=1689091246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2RxZp4L2OOp86GeN9wdwmMgvMFkloHNsLM24GLSIa0U=;
 b=llq4xJT2iDL21zx73um+PsHAE8o1og+RJyhEUx6IVmcliQepvRIn5VVGz2o+G4LUNa
 2a1ariq4H2ixbhGBLE0l0TzeYE9T2UJsIbijWZzt5e05Vk4lBcK+McEn/0X+RVbK/8lG
 QhMi6J5q6NmLQaxL4aI/vz/IHQbLOQytzRI2Di86N5X7tsbFBjJ56SKOnG2Rp2Bpwj69
 yc8CUi57RWi5fWSCdPkV8c+UfjUx3A8MIYdfscLsP7iT+ijaR5DLWGJ5/H4OlKLa559K
 4dBRg8MmUM6qV++nCFk7V3ZU5dAiC6faAf0uPQJXcg1osnh2CSDvi3+v/2KTUqPhM4sF
 catg==
X-Gm-Message-State: AC+VfDyHv3X5wT3wkYIvL7Ls6iA2z8az8Yks3UEEsDpFqGpX09rH3xFZ
 1VLSozsvh13s5ZPJ7coNcC34eg==
X-Google-Smtp-Source: ACHHUZ5XYMicalWOvbqUjT5G2UxM7N+NFGFkolpcjOvkbanFsXQUwiTJ+S5s3brQitZ3FJfQTB5btA==
X-Received: by 2002:a5d:6a87:0:b0:2cf:e747:b0d4 with SMTP id
 s7-20020a5d6a87000000b002cfe747b0d4mr2417583wru.40.1686499245790; 
 Sun, 11 Jun 2023 09:00:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a056000008900b0030ae499da59sm9923022wrx.111.2023.06.11.09.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 09:00:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 21/23] target/arm: Convert load/store (multiple structures)
 to decodetree
Date: Sun, 11 Jun 2023 17:00:30 +0100
Message-Id: <20230611160032.274823-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611160032.274823-1-peter.maydell@linaro.org>
References: <20230611160032.274823-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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
index 54383211006..1c8a57f7b52 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3417,99 +3417,28 @@ static bool trans_STLR_i(DisasContext *s, arg_ldapr_stlr_i *a)
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
 
@@ -3519,22 +3448,22 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
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
@@ -3543,45 +3472,119 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
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
@@ -3934,9 +3937,6 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
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


