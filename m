Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FF3720693
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:54:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5755-0003NF-Fn; Fri, 02 Jun 2023 11:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q5751-0003JD-Dk
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:43 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574u-0003aI-Lg
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:43 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-30ae61354fbso2094567f8f.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 08:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685721155; x=1688313155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H6fyr2YQkbjchR/WdhRPzKgYunXwMbfvKfnvzphQvVI=;
 b=W/vArtXJyG0e6B3Up4dANO3h51G1TXeVXaMWevoAQqxh7Qvw1MMDL444rOBuDSsvtG
 vheDDKzS/KuNW3fefoX/Oqa+EasovsDqeriMdSuHUr38Q3366JIFbAtyO2qYEe9ZP6N5
 8DzWwbM3cWRiTa+ILGCtRRJbzFpfTriAsj6RRwMr9cIjFB/10Y+Fj7bngbKZ1WcnRbp4
 3NYGznTuwgz5cQDhmOAyqpZViMLm4tn5/4Bchuu0s9cRPJEVv5Izolerm/BIXYiupnNS
 MCmudjglIFfptCRw5P8P9eHQgu9UL8yH5Wp6DYG9BJXDNgw8go1yVaqZnehvgAgicFQA
 PxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685721155; x=1688313155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H6fyr2YQkbjchR/WdhRPzKgYunXwMbfvKfnvzphQvVI=;
 b=IPsJHSqQSzzTrdqPJYpjF0IeBiq6By3We2SQBnb0nPJT0hyR6CDHtLvc5AmQKojY00
 IwZvU9lA+yVL//gSlsyR4kYw0IGkx72SuSKaf4l/A7XDRSkSqt0dA9KPcspqlto8MsP6
 +EoaRSG2cefgZS7SRzdZzCC348UCyI6QMww6/IFJh+Yz5XqjjuJKn7j05lTjnVRGtm40
 mQvImA3hpaLHGTrPzvoRu4QIcA+hALmWRL0sKjTjH6BcA+d4DqOmxPuPQ7k32iS8SU7k
 4HjIuaplLd1waFv7O1sRV2vC2gZvkKako2Lv4AVOGCaInuDwJhuyiIz63Jg0zCyEUZqV
 a2uw==
X-Gm-Message-State: AC+VfDwpzbVYn7hnaTmrxNPueDf8YIInQ+FgvST52YgidBeYRiPm7MMw
 8q5qk3A/hnTHvI36bSi3ywwIYAvzPu080dLh9lw=
X-Google-Smtp-Source: ACHHUZ7sonfJk8H85Xp6KWPmkA2PumaHl/mhqlRvY8S+oKF1MfEY3l8OFqfHYWlgH+UbR5uuo/2/0w==
X-Received: by 2002:a5d:628b:0:b0:309:5029:b071 with SMTP id
 k11-20020a5d628b000000b003095029b071mr268512wru.45.1685721155208; 
 Fri, 02 Jun 2023 08:52:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003f72a15301csm594952wml.2.2023.06.02.08.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 08:52:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 19/20] target/arm: Convert load/store single structure to
 decodetree
Date: Fri,  2 Jun 2023 16:52:22 +0100
Message-Id: <20230602155223.2040685-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602155223.2040685-1-peter.maydell@linaro.org>
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
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

Convert the ASIMD load/store single structure insns to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I note that compared to the old decoder this is rather harder
to compare against the pseudocode; the old hand-decode can
follow the pseudocode quite closely with its switch on 'scale',
whereas here quite a lot of magic is happening in the calculation
of 'index'.
---
 target/arm/tcg/a64.decode      |  37 ++++++
 target/arm/tcg/translate-a64.c | 228 ++++++++++++++++-----------------
 2 files changed, 148 insertions(+), 117 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 12d331b4c2a..48461a0540e 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -494,3 +494,40 @@ LD_mult         0 . 001100 . 1 0 ..... 0110 .. ..... ..... @ldst_mult rpt=3 sele
 LD_mult         0 . 001100 . 1 0 ..... 0111 .. ..... ..... @ldst_mult rpt=1 selem=1
 LD_mult         0 . 001100 . 1 0 ..... 1000 .. ..... ..... @ldst_mult rpt=1 selem=2
 LD_mult         0 . 001100 . 1 0 ..... 1010 .. ..... ..... @ldst_mult rpt=2 selem=1
+
+# Load/store single structure
+
+%ldst_single_selem 13:1 21:1 !function=plus_1
+# The index is made up from bits Q, S and the size; we may then need to scale
+# it down by the size.
+%ldst_single_index q:1 s:1 sz:2
+%ldst_single_index_scaled q:1 s:1 sz:2 scale:3 !function=uimm_scaled_down
+%ldst_single_repl_scale 10:2
+
+# We don't care about S in the trans functions (the decode folds it into
+# the calculation of index), but we have to list it here so that we can
+# handle the S-must-be-0 pattern lines. Similarly we don't care about sz
+# once it has been used to calculate index.
+&ldst_single    rm rn rt sz p q s selem index scale repl
+
+@ldst_single        . q:1 ...... p:1 . . rm:5 ... . .. rn:5 rt:5 \
+                    &ldst_single index=%ldst_single_index_scaled \
+                    selem=%ldst_single_selem repl=0
+@ldst_single_repl   . q:1 ...... p:1 . . rm:5 ... . sz:2 rn:5 rt:5 \
+                    &ldst_single index=%ldst_single_index \
+                    scale=%ldst_single_repl_scale selem=%ldst_single_selem repl=1
+
+
+ST_single       0 . 001101 . 0 . ..... 00 . s:1 sz:2 ..... ..... @ldst_single scale=0
+ST_single       0 . 001101 . 0 . ..... 01 . s:1 00 ..... ..... @ldst_single scale=1 sz=0
+ST_single       0 . 001101 . 0 . ..... 01 . s:1 10 ..... ..... @ldst_single scale=1 sz=2
+ST_single       0 . 001101 . 0 . ..... 10 . s:1 00 ..... ..... @ldst_single scale=2 sz=0
+ST_single       0 . 001101 . 0 . ..... 10 . 0 01 ..... ..... @ldst_single scale=3 sz=1 s=0
+
+LD_single       0 . 001101 . 1 . ..... 00 . s:1 sz:2 ..... ..... @ldst_single scale=0
+LD_single       0 . 001101 . 1 . ..... 01 . s:1 00 ..... ..... @ldst_single scale=1 sz=0
+LD_single       0 . 001101 . 1 . ..... 01 . s:1 10 ..... ..... @ldst_single scale=1 sz=2
+LD_single       0 . 001101 . 1 . ..... 10 . s:1 00 ..... ..... @ldst_single scale=2 sz=0
+LD_single       0 . 001101 . 1 . ..... 10 . 0 01 ..... ..... @ldst_single scale=3 sz=1 s=0
+# Replicating load case
+LD_single_repl  0 . 001101 . 1 . ..... 11 . 0 .. ..... ..... @ldst_single_repl s=0
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c3b22a74dd5..128c2b8b4b5 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -72,6 +72,17 @@ static int uimm_scaled(DisasContext *s, int x)
     return imm << scale;
 }
 
+/*
+ * For ASIMD load/store single structure: immediate is in bits [31:3],
+ * and should be scaled down by the scale in bits [2:0].
+ */
+static int uimm_scaled_down(DisasContext *s, int x)
+{
+    unsigned imm = x >> 3;
+    unsigned scale = extract32(x, 0, 3);
+    return imm >> scale;
+}
+
 /*
  * Include the generated decoders.
  */
@@ -3405,140 +3416,126 @@ static bool trans_ST_mult(DisasContext *s, arg_ldst_mult *a)
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
 
-    clean_addr = gen_mte_checkN(s, tcg_rn, !is_load, is_postidx || rn != 31,
-                                total);
-    mop = finalize_memop(s, scale);
+    clean_addr = gen_mte_checkN(s, tcg_rn, true, a->p || a->rn != 31, total);
+    mop = finalize_memop(s, a->scale);
 
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
+    clean_addr = gen_mte_checkN(s, tcg_rn, false, a->p || a->rn != 31, total);
+    mop = finalize_memop(s, a->scale);
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
+static bool trans_LD_single_repl(DisasContext *s, arg_ldst_single *a)
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
+    clean_addr = gen_mte_checkN(s, tcg_rn, false, a->p || a->rn != 31, total);
+    mop = finalize_memop(s, a->scale);
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
@@ -3747,9 +3744,6 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
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


