Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B4A72069B
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:54:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q574z-0003Gp-TS; Fri, 02 Jun 2023 11:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574y-0003Fq-2u
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574s-0003XG-DJ
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:39 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f6e13940daso22402985e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 08:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685721153; x=1688313153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AJK9ynd718AWUtAFuAFb493t5xX258KsKMcz4WYMoiw=;
 b=t+vrC+4/J/tflF9XKJ9xaNYP4lLpnNcXbo1JAZq8Wgd4iKFS5NSUuN4IqyG8Zq+Yeq
 IPt04BVb/nyKIXWVsornWVe8HpLViENCTogvTr7YUdj+N9cEqDzEnoHRUHXqqAz8cUHp
 7m2t76+2IFOUZvrm3ACivLtOOlNN0ZgM3IhY/ivIv2IZ3JnbEhQMIyrdfNJhc3/4XlqM
 f9S3nJsNR5VvovIH1BJpVA67mQi2HUYm7lVCjjP7qaSqvndWHU12EBs5aHiXXSIFIP7h
 qIxl1sAR4+CIYzOM8WtAv38Q+Hcvb6QBP6dMzJhqXRQwlxjtpL8o0LwwjXqjqEH6idzl
 MdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685721153; x=1688313153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AJK9ynd718AWUtAFuAFb493t5xX258KsKMcz4WYMoiw=;
 b=McXU5dZ6ZCb+t9KX8XSNIz2o0f5m/tr5Cn72bKjjxv3J+xfhUk7Q+M9cB402JUL37E
 2UjoI9OTRbm3rraTeKyaV8/3sotHDWWkSTJ+igIILoW290oyyS5cgQbUuBCA7hEvLLg1
 54UzSPXCw1D7hoNeoeegZvdVfcPvMkyRFpLW+YQean7ufaCaBhSHgKDiOcsBzrE6DM6H
 EboKvdFEiglPDZIp5bEvbSEiYDRh529JNuUwAP1f1W77ohXCkKMssUzw/Q5vFo20vgla
 GGWjExJ2jJn9GfZq7f1gb+OFt1D5+uGVY2tZw4BO6O8QKVcDTVrOZQgm3NCAWe9e7hn7
 5V4Q==
X-Gm-Message-State: AC+VfDxA+L8iDlxQn6olaBIicqmKbIAmFAKkFCUcXHui1TzQZAbdotP3
 RCipl6g/gX1+B56RbLyz+jB+yRzuJaAyJ9yC0EU=
X-Google-Smtp-Source: ACHHUZ5HCGMjVtm7mfnyOcpKQu31G3bdniL0mDYNLPAEsKVluFuXl22RJrAZ50em+WoB2TTd4Ovtsg==
X-Received: by 2002:a05:600c:2298:b0:3f5:db0f:4a74 with SMTP id
 24-20020a05600c229800b003f5db0f4a74mr2399665wmf.21.1685721152982; 
 Fri, 02 Jun 2023 08:52:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003f72a15301csm594952wml.2.2023.06.02.08.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 08:52:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 14/20] target/arm: Convert LDR/STR reg+reg to decodetree
Date: Fri,  2 Jun 2023 16:52:17 +0100
Message-Id: <20230602155223.2040685-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602155223.2040685-1-peter.maydell@linaro.org>
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
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
---
 target/arm/tcg/a64.decode      |  22 +++++
 target/arm/tcg/translate-a64.c | 163 +++++++++++++++------------------
 2 files changed, 96 insertions(+), 89 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index c3a6d0b740a..189a30b1552 100644
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
index 9607e55cc59..c3eb51e99ff 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2987,100 +2987,87 @@ static bool trans_LDR_v_i(DisasContext *s, arg_ldst_imm *a)
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
+                             bool is_store)
 {
-    int rn = extract32(insn, 5, 5);
-    int shift = extract32(insn, 12, 1);
-    int rm = extract32(insn, 16, 5);
-    int opt = extract32(insn, 13, 3);
-    bool is_signed = false;
-    bool is_store = false;
-    bool is_extended = false;
+    TCGv_i64 tcg_rm;
 
-    TCGv_i64 tcg_rm, clean_addr, dirty_addr;
-
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
-        is_signed = extract32(opc, 1, 1);
-        is_extended = (size < 3) && extract32(opc, 0, 1);
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
-    clean_addr = gen_mte_check1(s, dirty_addr, is_store, true, size);
+    tcg_gen_add_i64(*dirty_addr, *dirty_addr, tcg_rm);
+    *clean_addr = gen_mte_check1(s, *dirty_addr, is_store, true, a->sz);
+}
 
-    if (is_vector) {
-        if (is_store) {
-            do_fp_st(s, rt, clean_addr, size);
-        } else {
-            do_fp_ld(s, rt, clean_addr, size);
-        }
-    } else {
-        TCGv_i64 tcg_rt = cpu_reg(s, rt);
-        bool iss_sf = disas_ldst_compute_iss_sf(size, is_signed, opc);
-        if (is_store) {
-            do_gpr_st(s, tcg_rt, clean_addr, size,
-                      true, rt, iss_sf, false);
-        } else {
-            do_gpr_ld(s, tcg_rt, clean_addr, size + is_signed * MO_SIGN,
-                      is_extended, true, rt, iss_sf, false);
-        }
+static bool trans_LDR(DisasContext *s, arg_ldst *a)
+{
+    TCGv_i64 clean_addr, dirty_addr, tcg_rt;
+    bool iss_sf = ldst_iss_sf(a->sz, a->sign, a->ext);
+
+    if (extract32(a->opt, 1, 1) == 0) {
+        return false;
     }
+
+    op_addr_ldst_pre(s, a, &clean_addr, &dirty_addr, false);
+    tcg_rt = cpu_reg(s, a->rt);
+    do_gpr_ld(s, tcg_rt, clean_addr, a->sz + a->sign * MO_SIGN,
+              a->ext, true, a->rt, iss_sf, false);
+    return true;
+}
+
+static bool trans_STR(DisasContext *s, arg_ldst *a)
+{
+    TCGv_i64 clean_addr, dirty_addr, tcg_rt;
+    bool iss_sf = ldst_iss_sf(a->sz, a->sign, a->ext);
+
+    if (extract32(a->opt, 1, 1) == 0) {
+        return false;
+    }
+
+    op_addr_ldst_pre(s, a, &clean_addr, &dirty_addr, true);
+    tcg_rt = cpu_reg(s, a->rt);
+    do_gpr_st(s, tcg_rt, clean_addr, a->sz, true, a->rt, iss_sf, false);
+    return true;
+}
+
+static bool trans_LDR_v(DisasContext *s, arg_ldst *a)
+{
+    TCGv_i64 clean_addr, dirty_addr;
+
+    if (extract32(a->opt, 1, 1) == 0) {
+        return false;
+    }
+
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    op_addr_ldst_pre(s, a, &clean_addr, &dirty_addr, false);
+    do_fp_ld(s, a->rt, clean_addr, a->sz);
+    return true;
+}
+
+static bool trans_STR_v(DisasContext *s, arg_ldst *a)
+{
+    TCGv_i64 clean_addr, dirty_addr;
+
+    if (extract32(a->opt, 1, 1) == 0) {
+        return false;
+    }
+
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    op_addr_ldst_pre(s, a, &clean_addr, &dirty_addr, true);
+    do_fp_st(s, a->rt, clean_addr, a->sz);
+    return true;
 }
 
 /* Atomic memory operations
@@ -3357,7 +3344,6 @@ static void disas_ldst_ldapr_stlr(DisasContext *s, uint32_t insn)
 static void disas_ldst_reg(DisasContext *s, uint32_t insn)
 {
     int rt = extract32(insn, 0, 5);
-    int opc = extract32(insn, 22, 2);
     bool is_vector = extract32(insn, 26, 1);
     int size = extract32(insn, 30, 2);
 
@@ -3371,8 +3357,7 @@ static void disas_ldst_reg(DisasContext *s, uint32_t insn)
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


