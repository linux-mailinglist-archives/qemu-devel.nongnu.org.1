Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F9D72B2B0
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 18:02:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8NVe-0006V0-SO; Sun, 11 Jun 2023 12:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUp-0005wV-Ae
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:53 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUj-0000Ub-1p
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:51 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-30af86a96b4so2285594f8f.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686499243; x=1689091243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L/WClOmRe7ZqC6CcCm7m1pNSLACFLdzYSCXTc15BbAs=;
 b=uUo6tIr9qAAHR0PMVFXpG0ELF2wSp8bSWyIy6xdwV4UGKACECpTcWeuo18NwyboXSh
 yfcT7oeu9JFmjhvMrB1QAkENGOtXQImsMOMC0hF2NQXwSkAqTGJkEOd/kQkAReeMCa53
 XbEspJCdek5KX+wZ4zSSaK7ullBazzwQT/YHcqGhzUfrINbx7jX75R6YKtYXdVIaDjx1
 52hvc0inrwcisO0y8x7l3/VQD83NZTvLwuk4RwNa+oETNmaUBYdXDg+NmOWjv5zgsqKW
 NcPDrWfvNmzRwNzuK40NwHhae+sEnuKI2d6Uie2nOkBhdrt/vP/VzbipeeLv56VSWJYI
 CAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686499243; x=1689091243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L/WClOmRe7ZqC6CcCm7m1pNSLACFLdzYSCXTc15BbAs=;
 b=NKfH0h4W1lsPyPzSmGY+yr+mltDXt3SOjbzsGajEM3tGlp3YiJOh8zdAEa4zVHZRyV
 XS6FqKz0ROYQdaD0TwuzL7pteYCA3athUrlDOA8COC00cTiW/2tYCdmS/Bty4ZRGePpC
 EaQ1G8d3iFXHeNuRfmO8KeYG28h3rImDW3+hP7qABCdXz3Xo9nprXhX25Sp6NJz4YMqg
 9yiEKdFuRTyd7ZORP3cm67P2BWDw0wUUG6+TNUiNcrm+rD7c6k605+w8lPGBiX73DEGt
 oGgosnXKFIXF00KE5u+kIzwRimx57NlX0OhKv/Wi/4TutkFP64OA6B5waJeUJf7cmVmB
 StTg==
X-Gm-Message-State: AC+VfDyzi+E9ngUDKc6IGH+tmJQzTIogc7zJoaxxXbnIqSYVC1QzpEO5
 KnBycaHwP/QgiBbG3YcH4WT7wg==
X-Google-Smtp-Source: ACHHUZ7/UxvWpxiYPbDsSB5JoWoyEGZKjPTkL4tVGl+m4vsXSkQ1Sch8FawkBLC3qBb2ZNAkxF1TNA==
X-Received: by 2002:a5d:50c2:0:b0:309:303b:3dc5 with SMTP id
 f2-20020a5d50c2000000b00309303b3dc5mr3050531wrt.7.1686499243280; 
 Sun, 11 Jun 2023 09:00:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a056000008900b0030ae499da59sm9923022wrx.111.2023.06.11.09.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 09:00:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 17/23] target/arm: Convert LDR/STR reg+reg to decodetree
Date: Sun, 11 Jun 2023 17:00:26 +0100
Message-Id: <20230611160032.274823-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611160032.274823-1-peter.maydell@linaro.org>
References: <20230611160032.274823-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Convert the LDR and STR instructions which take a register
plus register offset to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230602155223.2040685-15-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |  22 +++++
 target/arm/tcg/translate-a64.c | 173 +++++++++++++++------------------
 2 files changed, 103 insertions(+), 92 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index d6b31c10838..5c086d6af6d 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -420,3 +420,25 @@ STR_v_i         sz:2 111 1 01 00 ............ ..... ..... @ldst_uimm sign=0 ext=
 STR_v_i         00 111 1 01 10 ............ ..... ..... @ldst_uimm sign=0 ext=0 sz=4
 LDR_v_i         sz:2 111 1 01 01 ............ ..... ..... @ldst_uimm sign=0 ext=0
 LDR_v_i         00 111 1 01 11 ............ ..... ..... @ldst_uimm sign=0 ext=0 sz=4
+
+# Load/store with register offset
+&ldst rm rn rt sign ext sz opt s
+@ldst           .. ... . .. .. . rm:5 opt:3 s:1 .. rn:5 rt:5 &ldst
+STR             sz:2 111 0 00 00 1 ..... ... . 10 ..... ..... @ldst sign=0 ext=0
+LDR             00 111 0 00 01 1 ..... ... . 10 ..... ..... @ldst sign=0 ext=1 sz=0
+LDR             01 111 0 00 01 1 ..... ... . 10 ..... ..... @ldst sign=0 ext=1 sz=1
+LDR             10 111 0 00 01 1 ..... ... . 10 ..... ..... @ldst sign=0 ext=1 sz=2
+LDR             11 111 0 00 01 1 ..... ... . 10 ..... ..... @ldst sign=0 ext=0 sz=3
+LDR             00 111 0 00 10 1 ..... ... . 10 ..... ..... @ldst sign=1 ext=0 sz=0
+LDR             01 111 0 00 10 1 ..... ... . 10 ..... ..... @ldst sign=1 ext=0 sz=1
+LDR             10 111 0 00 10 1 ..... ... . 10 ..... ..... @ldst sign=1 ext=0 sz=2
+LDR             00 111 0 00 11 1 ..... ... . 10 ..... ..... @ldst sign=1 ext=1 sz=0
+LDR             01 111 0 00 11 1 ..... ... . 10 ..... ..... @ldst sign=1 ext=1 sz=1
+
+# PRFM
+NOP             11 111 0 00 10 1 ----- -1- - 10 ----- -----
+
+STR_v           sz:2 111 1 00 00 1 ..... ... . 10 ..... ..... @ldst sign=0 ext=0
+STR_v           00 111 1 00 10 1 ..... ... . 10 ..... ..... @ldst sign=0 ext=0 sz=4
+LDR_v           sz:2 111 1 00 01 1 ..... ... . 10 ..... ..... @ldst sign=0 ext=0
+LDR_v           00 111 1 00 11 1 ..... ... . 10 ..... ..... @ldst sign=0 ext=0 sz=4
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e1936c7c246..3d161169411 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3153,104 +3153,95 @@ static bool trans_LDR_v_i(DisasContext *s, arg_ldst_imm *a)
     return true;
 }
 
-/*
- * Load/store (register offset)
- *
- * 31 30 29   27  26 25 24 23 22 21  20  16 15 13 12 11 10 9  5 4  0
- * +----+-------+---+-----+-----+---+------+-----+--+-----+----+----+
- * |size| 1 1 1 | V | 0 0 | opc | 1 |  Rm  | opt | S| 1 0 | Rn | Rt |
- * +----+-------+---+-----+-----+---+------+-----+--+-----+----+----+
- *
- * For non-vector:
- *   size: 00-> byte, 01 -> 16 bit, 10 -> 32bit, 11 -> 64bit
- *   opc: 00 -> store, 01 -> loadu, 10 -> loads 64, 11 -> loads 32
- * For vector:
- *   size is opc<1>:size<1:0> so 100 -> 128 bit; 110 and 111 unallocated
- *   opc<0>: 0 -> store, 1 -> load
- * V: 1 -> vector/simd
- * opt: extend encoding (see DecodeRegExtend)
- * S: if S=1 then scale (essentially index by sizeof(size))
- * Rt: register to transfer into/out of
- * Rn: address register or SP for base
- * Rm: offset register or ZR for offset
- */
-static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
-                                   int opc,
-                                   int size,
-                                   int rt,
-                                   bool is_vector)
+static void op_addr_ldst_pre(DisasContext *s, arg_ldst *a,
+                             TCGv_i64 *clean_addr, TCGv_i64 *dirty_addr,
+                             bool is_store, MemOp memop)
 {
-    int rn = extract32(insn, 5, 5);
-    int shift = extract32(insn, 12, 1);
-    int rm = extract32(insn, 16, 5);
-    int opt = extract32(insn, 13, 3);
-    bool is_signed = false;
-    bool is_store = false;
-    bool is_extended = false;
-    TCGv_i64 tcg_rm, clean_addr, dirty_addr;
-    MemOp memop;
+    TCGv_i64 tcg_rm;
 
-    if (extract32(opt, 1, 1) == 0) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (is_vector) {
-        size |= (opc & 2) << 1;
-        if (size > 4) {
-            unallocated_encoding(s);
-            return;
-        }
-        is_store = !extract32(opc, 0, 1);
-        if (!fp_access_check(s)) {
-            return;
-        }
-        memop = finalize_memop_asimd(s, size);
-    } else {
-        if (size == 3 && opc == 2) {
-            /* PRFM - prefetch */
-            return;
-        }
-        if (opc == 3 && size > 1) {
-            unallocated_encoding(s);
-            return;
-        }
-        is_store = (opc == 0);
-        is_signed = !is_store && extract32(opc, 1, 1);
-        is_extended = (size < 3) && extract32(opc, 0, 1);
-        memop = finalize_memop(s, size + is_signed * MO_SIGN);
-    }
-
-    if (rn == 31) {
+    if (a->rn == 31) {
         gen_check_sp_alignment(s);
     }
-    dirty_addr = read_cpu_reg_sp(s, rn, 1);
+    *dirty_addr = read_cpu_reg_sp(s, a->rn, 1);
 
-    tcg_rm = read_cpu_reg(s, rm, 1);
-    ext_and_shift_reg(tcg_rm, tcg_rm, opt, shift ? size : 0);
+    tcg_rm = read_cpu_reg(s, a->rm, 1);
+    ext_and_shift_reg(tcg_rm, tcg_rm, a->opt, a->s ? a->sz : 0);
 
-    tcg_gen_add_i64(dirty_addr, dirty_addr, tcg_rm);
+    tcg_gen_add_i64(*dirty_addr, *dirty_addr, tcg_rm);
+    *clean_addr = gen_mte_check1(s, *dirty_addr, is_store, true, memop);
+}
 
-    clean_addr = gen_mte_check1(s, dirty_addr, is_store, true, memop);
+static bool trans_LDR(DisasContext *s, arg_ldst *a)
+{
+    TCGv_i64 clean_addr, dirty_addr, tcg_rt;
+    bool iss_sf = ldst_iss_sf(a->sz, a->sign, a->ext);
+    MemOp memop;
 
-    if (is_vector) {
-        if (is_store) {
-            do_fp_st(s, rt, clean_addr, memop);
-        } else {
-            do_fp_ld(s, rt, clean_addr, memop);
-        }
-    } else {
-        TCGv_i64 tcg_rt = cpu_reg(s, rt);
-        bool iss_sf = disas_ldst_compute_iss_sf(size, is_signed, opc);
-
-        if (is_store) {
-            do_gpr_st(s, tcg_rt, clean_addr, memop,
-                      true, rt, iss_sf, false);
-        } else {
-            do_gpr_ld(s, tcg_rt, clean_addr, memop,
-                      is_extended, true, rt, iss_sf, false);
-        }
+    if (extract32(a->opt, 1, 1) == 0) {
+        return false;
     }
+
+    memop = finalize_memop(s, a->sz + a->sign * MO_SIGN);
+    op_addr_ldst_pre(s, a, &clean_addr, &dirty_addr, false, memop);
+    tcg_rt = cpu_reg(s, a->rt);
+    do_gpr_ld(s, tcg_rt, clean_addr, memop,
+              a->ext, true, a->rt, iss_sf, false);
+    return true;
+}
+
+static bool trans_STR(DisasContext *s, arg_ldst *a)
+{
+    TCGv_i64 clean_addr, dirty_addr, tcg_rt;
+    bool iss_sf = ldst_iss_sf(a->sz, a->sign, a->ext);
+    MemOp memop;
+
+    if (extract32(a->opt, 1, 1) == 0) {
+        return false;
+    }
+
+    memop = finalize_memop(s, a->sz);
+    op_addr_ldst_pre(s, a, &clean_addr, &dirty_addr, true, memop);
+    tcg_rt = cpu_reg(s, a->rt);
+    do_gpr_st(s, tcg_rt, clean_addr, memop, true, a->rt, iss_sf, false);
+    return true;
+}
+
+static bool trans_LDR_v(DisasContext *s, arg_ldst *a)
+{
+    TCGv_i64 clean_addr, dirty_addr;
+    MemOp memop;
+
+    if (extract32(a->opt, 1, 1) == 0) {
+        return false;
+    }
+
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    memop = finalize_memop_asimd(s, a->sz);
+    op_addr_ldst_pre(s, a, &clean_addr, &dirty_addr, false, memop);
+    do_fp_ld(s, a->rt, clean_addr, memop);
+    return true;
+}
+
+static bool trans_STR_v(DisasContext *s, arg_ldst *a)
+{
+    TCGv_i64 clean_addr, dirty_addr;
+    MemOp memop;
+
+    if (extract32(a->opt, 1, 1) == 0) {
+        return false;
+    }
+
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    memop = finalize_memop_asimd(s, a->sz);
+    op_addr_ldst_pre(s, a, &clean_addr, &dirty_addr, true, memop);
+    do_fp_st(s, a->rt, clean_addr, memop);
+    return true;
 }
 
 /* Atomic memory operations
@@ -3531,7 +3522,6 @@ static void disas_ldst_ldapr_stlr(DisasContext *s, uint32_t insn)
 static void disas_ldst_reg(DisasContext *s, uint32_t insn)
 {
     int rt = extract32(insn, 0, 5);
-    int opc = extract32(insn, 22, 2);
     bool is_vector = extract32(insn, 26, 1);
     int size = extract32(insn, 30, 2);
 
@@ -3545,8 +3535,7 @@ static void disas_ldst_reg(DisasContext *s, uint32_t insn)
             disas_ldst_atomic(s, insn, size, rt, is_vector);
             return;
         case 2:
-            disas_ldst_reg_roffset(s, insn, opc, size, rt, is_vector);
-            return;
+            break;
         default:
             disas_ldst_pac(s, insn, size, rt, is_vector);
             return;
-- 
2.34.1


