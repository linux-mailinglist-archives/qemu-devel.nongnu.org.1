Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 259607206AB
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:56:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5750-0003HD-IG; Fri, 02 Jun 2023 11:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574v-0003D3-V9
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:37 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574r-0003Td-1g
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:37 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f606a80d34so21277865e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685721151; x=1688313151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=77RbFzojTtJ/okh5WW9K0do57l5DLpmb5dkhivoChhA=;
 b=PTJlbABv8hVCQIPt35zz4X+X94uRUZdn/27QNkLhGFb2bTHiNK+vMdibVoZlb4HMGo
 lVRo/bQxTR+KjgOE4sW+no31jyZFroRJCvcE4xKCPXaU5XcpOdF+yDj94zWQA2EJ0EFn
 2gAEbLxaoguQbTgYO1Ejb3biBO8Hj6Y1yXcx4OpLe8XdFVMveS+bqrRtUtfgKZIx5S3U
 fCYIRkxapNpyP8zPyTxSJuk7dsfndv9QnGXD0sLg1lEIinE9vBBiLMAHF9KN/9n1kkSZ
 qTol++640szk1rZk8pOyBU30l+4Nw2kWVlJZc9oCFWOKbWMfqiNKLSxQMKaNLaUMrPvg
 RHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685721151; x=1688313151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=77RbFzojTtJ/okh5WW9K0do57l5DLpmb5dkhivoChhA=;
 b=f0+58yk8Qd4phcoCDypDqwxYd10LJQYphEaXqTuusqRw9PauCt/6R/embE8X35F5GU
 UpUpFRhYolW/HOipI6nDbLmyWx2BrYEsZJloeWJtLec/rSG5HbYQAZzYgeXhrQJXA2eq
 f1mO9sIMvmxKc4g/ZIgt2xW3njwr1rAu3s0hAVY2aRuntgCfy0bNvh9NOdyPPCJJfamc
 JXWX7p9uY47h71efDO23U4csN5I0FDlfQPHw74SyC/mT+ryhHacqE+AjUq+4hBn+/4ig
 ZGftH7UgG/n98izptK+beWrFDo4iOtrupLkIXElxhFTmoxWZgNE/NByqUwJlQacZ898+
 HY9A==
X-Gm-Message-State: AC+VfDxR2SBApYQJEPocg7Ay29YIsdfG/6lRkcrc2sJBBipscm2+Yneo
 qFxNvktDnYCgauJq3y3b0IU4GIBfKHIFJELbpqw=
X-Google-Smtp-Source: ACHHUZ55C3yf9u+o4R8SjepsN6YBUqek5LgjETnCpEebxxM/FT3b1X6F48zOG88LUhvXnligyDrK9A==
X-Received: by 2002:a5d:5945:0:b0:309:4176:702 with SMTP id
 e5-20020a5d5945000000b0030941760702mr292103wri.37.1685721151566; 
 Fri, 02 Jun 2023 08:52:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003f72a15301csm594952wml.2.2023.06.02.08.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 08:52:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 11/20] target/arm: Convert load/store-pair to decodetree
Date: Fri,  2 Jun 2023 16:52:14 +0100
Message-Id: <20230602155223.2040685-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602155223.2040685-1-peter.maydell@linaro.org>
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Convert the load/store register pair insns (LDP, STP,
LDNP, STNP, LDPSW, STGP) to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  62 +++++++
 target/arm/tcg/translate-a64.c | 299 ++++++++++++++-------------------
 2 files changed, 192 insertions(+), 169 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index e24db340714..0a3850fe8d5 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -264,3 +264,65 @@ LD_lit_v        10 011 1 00 ................... ..... @ldlit sz=4 sign=0
 
 # PRFM
 NOP             11 011 0 00 ------------------- -----
+
+%imms7          15:s7
+&ldstpair       rt2 rt rn imm sz sign w p
+@ldstpair       .. ... . ... . ....... rt2:5 rn:5 rt:5 &ldstpair imm=%imms7
+
+# STNP, LDNP: Signed offset, non-temporal hint. We don't emulate caches
+# so we ignore hints about data access patterns, and handle these like
+# plain signed offset.
+STP             00 101 0 000 0 ....... ..... ..... ..... @ldstpair sz=2 sign=0 p=0 w=0
+LDP             00 101 0 000 1 ....... ..... ..... ..... @ldstpair sz=2 sign=0 p=0 w=0
+STP             10 101 0 000 0 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=0 w=0
+LDP             10 101 0 000 1 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=0 w=0
+STP_v           00 101 1 000 0 ....... ..... ..... ..... @ldstpair sz=2 sign=0 p=0 w=0
+LDP_v           00 101 1 000 1 ....... ..... ..... ..... @ldstpair sz=2 sign=0 p=0 w=0
+STP_v           01 101 1 000 0 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=0 w=0
+LDP_v           01 101 1 000 1 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=0 w=0
+STP_v           10 101 1 000 0 ....... ..... ..... ..... @ldstpair sz=4 sign=0 p=0 w=0
+LDP_v           10 101 1 000 1 ....... ..... ..... ..... @ldstpair sz=4 sign=0 p=0 w=0
+
+# STP and LDP: post-indexed
+STP             00 101 0 001 0 ....... ..... ..... ..... @ldstpair sz=2 sign=0 p=1 w=1
+LDP             00 101 0 001 1 ....... ..... ..... ..... @ldstpair sz=2 sign=0 p=1 w=1
+LDP             01 101 0 001 1 ....... ..... ..... ..... @ldstpair sz=2 sign=1 p=1 w=1
+STP             10 101 0 001 0 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=1 w=1
+LDP             10 101 0 001 1 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=1 w=1
+STP_v           00 101 1 001 0 ....... ..... ..... ..... @ldstpair sz=2 sign=0 p=1 w=1
+LDP_v           00 101 1 001 1 ....... ..... ..... ..... @ldstpair sz=2 sign=0 p=1 w=1
+STP_v           01 101 1 001 0 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=1 w=1
+LDP_v           01 101 1 001 1 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=1 w=1
+STP_v           10 101 1 001 0 ....... ..... ..... ..... @ldstpair sz=4 sign=0 p=1 w=1
+LDP_v           10 101 1 001 1 ....... ..... ..... ..... @ldstpair sz=4 sign=0 p=1 w=1
+
+# STP and LDP: offset
+STP             00 101 0 010 0 ....... ..... ..... ..... @ldstpair sz=2 sign=0 p=0 w=0
+LDP             00 101 0 010 1 ....... ..... ..... ..... @ldstpair sz=2 sign=0 p=0 w=0
+LDP             01 101 0 010 1 ....... ..... ..... ..... @ldstpair sz=2 sign=1 p=0 w=0
+STP             10 101 0 010 0 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=0 w=0
+LDP             10 101 0 010 1 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=0 w=0
+STP_v           00 101 1 010 0 ....... ..... ..... ..... @ldstpair sz=2 sign=0 p=0 w=0
+LDP_v           00 101 1 010 1 ....... ..... ..... ..... @ldstpair sz=2 sign=0 p=0 w=0
+STP_v           01 101 1 010 0 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=0 w=0
+LDP_v           01 101 1 010 1 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=0 w=0
+STP_v           10 101 1 010 0 ....... ..... ..... ..... @ldstpair sz=4 sign=0 p=0 w=0
+LDP_v           10 101 1 010 1 ....... ..... ..... ..... @ldstpair sz=4 sign=0 p=0 w=0
+
+# STP and LDP: pre-indexed
+STP             00 101 0 011 0 ....... ..... ..... ..... @ldstpair sz=2 sign=0 p=0 w=1
+LDP             00 101 0 011 1 ....... ..... ..... ..... @ldstpair sz=2 sign=0 p=0 w=1
+LDP             01 101 0 011 1 ....... ..... ..... ..... @ldstpair sz=2 sign=1 p=0 w=1
+STP             10 101 0 011 0 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=0 w=1
+LDP             10 101 0 011 1 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=0 w=1
+STP_v           00 101 1 011 0 ....... ..... ..... ..... @ldstpair sz=2 sign=0 p=0 w=1
+LDP_v           00 101 1 011 1 ....... ..... ..... ..... @ldstpair sz=2 sign=0 p=0 w=1
+STP_v           01 101 1 011 0 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=0 w=1
+LDP_v           01 101 1 011 1 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=0 w=1
+STP_v           10 101 1 011 0 ....... ..... ..... ..... @ldstpair sz=4 sign=0 p=0 w=1
+LDP_v           10 101 1 011 1 ....... ..... ..... ..... @ldstpair sz=4 sign=0 p=0 w=1
+
+# STGP: store tag and pair
+STGP            01 101 0 001 0 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=1 w=1
+STGP            01 101 0 010 0 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=0 w=0
+STGP            01 101 0 011 0 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=0 w=1
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 07bcc700e0b..bd591122628 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2737,181 +2737,146 @@ static bool trans_LD_lit_v(DisasContext *s, arg_ldlit *a)
     return true;
 }
 
-/*
- * LDNP (Load Pair - non-temporal hint)
- * LDP (Load Pair - non vector)
- * LDPSW (Load Pair Signed Word - non vector)
- * STNP (Store Pair - non-temporal hint)
- * STP (Store Pair - non vector)
- * LDNP (Load Pair of SIMD&FP - non-temporal hint)
- * LDP (Load Pair of SIMD&FP)
- * STNP (Store Pair of SIMD&FP - non-temporal hint)
- * STP (Store Pair of SIMD&FP)
- *
- *  31 30 29   27  26  25 24   23  22 21   15 14   10 9    5 4    0
- * +-----+-------+---+---+-------+---+-----------------------------+
- * | opc | 1 0 1 | V | 0 | index | L |  imm7 |  Rt2  |  Rn  | Rt   |
- * +-----+-------+---+---+-------+---+-------+-------+------+------+
- *
- * opc: LDP/STP/LDNP/STNP        00 -> 32 bit, 10 -> 64 bit
- *      LDPSW/STGP               01
- *      LDP/STP/LDNP/STNP (SIMD) 00 -> 32 bit, 01 -> 64 bit, 10 -> 128 bit
- *   V: 0 -> GPR, 1 -> Vector
- * idx: 00 -> signed offset with non-temporal hint, 01 -> post-index,
- *      10 -> signed offset, 11 -> pre-index
- *   L: 0 -> Store 1 -> Load
- *
- * Rt, Rt2 = GPR or SIMD registers to be stored
- * Rn = general purpose register containing address
- * imm7 = signed offset (multiple of 4 or 8 depending on size)
- */
-static void disas_ldst_pair(DisasContext *s, uint32_t insn)
+static void op_addr_ldstpair_pre(DisasContext *s, arg_ldstpair *a,
+                                 TCGv_i64 *clean_addr, TCGv_i64 *dirty_addr,
+                                 uint64_t offset, bool is_store)
 {
-    int rt = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int rt2 = extract32(insn, 10, 5);
-    uint64_t offset = sextract64(insn, 15, 7);
-    int index = extract32(insn, 23, 2);
-    bool is_vector = extract32(insn, 26, 1);
-    bool is_load = extract32(insn, 22, 1);
-    int opc = extract32(insn, 30, 2);
-
-    bool is_signed = false;
-    bool postindex = false;
-    bool wback = false;
-    bool set_tag = false;
-
-    TCGv_i64 clean_addr, dirty_addr;
-
-    int size;
-
-    if (opc == 3) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (is_vector) {
-        size = 2 + opc;
-    } else if (opc == 1 && !is_load) {
-        /* STGP */
-        if (!dc_isar_feature(aa64_mte_insn_reg, s) || index == 0) {
-            unallocated_encoding(s);
-            return;
-        }
-        size = 3;
-        set_tag = true;
-    } else {
-        size = 2 + extract32(opc, 1, 1);
-        is_signed = extract32(opc, 0, 1);
-        if (!is_load && is_signed) {
-            unallocated_encoding(s);
-            return;
-        }
-    }
-
-    switch (index) {
-    case 1: /* post-index */
-        postindex = true;
-        wback = true;
-        break;
-    case 0:
-        /* signed offset with "non-temporal" hint. Since we don't emulate
-         * caches we don't care about hints to the cache system about
-         * data access patterns, and handle this identically to plain
-         * signed offset.
-         */
-        if (is_signed) {
-            /* There is no non-temporal-hint version of LDPSW */
-            unallocated_encoding(s);
-            return;
-        }
-        postindex = false;
-        break;
-    case 2: /* signed offset, rn not updated */
-        postindex = false;
-        break;
-    case 3: /* pre-index */
-        postindex = false;
-        wback = true;
-        break;
-    }
-
-    if (is_vector && !fp_access_check(s)) {
-        return;
-    }
-
-    offset <<= (set_tag ? LOG2_TAG_GRANULE : size);
-
-    if (rn == 31) {
+    if (a->rn == 31) {
         gen_check_sp_alignment(s);
     }
 
-    dirty_addr = read_cpu_reg_sp(s, rn, 1);
-    if (!postindex) {
+    *dirty_addr = read_cpu_reg_sp(s, a->rn, 1);
+    if (!a->p) {
+        tcg_gen_addi_i64(*dirty_addr, *dirty_addr, offset);
+    }
+
+    *clean_addr = gen_mte_checkN(s, *dirty_addr, is_store,
+                                 (a->w || a->rn != 31), 2 << a->sz);
+}
+
+static void op_addr_ldstpair_post(DisasContext *s, arg_ldstpair *a,
+                                  TCGv_i64 dirty_addr, uint64_t offset)
+{
+    if (a->w) {
+        if (a->p) {
+            tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
+        }
+        tcg_gen_mov_i64(cpu_reg_sp(s, a->rn), dirty_addr);
+    }
+}
+
+static bool trans_STP(DisasContext *s, arg_ldstpair *a)
+{
+    uint64_t offset = a->imm << a->sz;
+    TCGv_i64 clean_addr, dirty_addr, tcg_rt, tcg_rt2;
+
+    op_addr_ldstpair_pre(s, a, &clean_addr, &dirty_addr, offset, true);
+    tcg_rt = cpu_reg(s, a->rt);
+    tcg_rt2 = cpu_reg(s, a->rt2);
+    do_gpr_st(s, tcg_rt, clean_addr, a->sz, false, 0, false, false);
+    tcg_gen_addi_i64(clean_addr, clean_addr, 1 << a->sz);
+    do_gpr_st(s, tcg_rt2, clean_addr, a->sz, false, 0, false, false);
+    op_addr_ldstpair_post(s, a, dirty_addr, offset);
+    return true;
+}
+
+static bool trans_LDP(DisasContext *s, arg_ldstpair *a)
+{
+    uint64_t offset = a->imm << a->sz;
+    TCGv_i64 clean_addr, dirty_addr, tcg_rt, tcg_rt2, tmp;
+
+    op_addr_ldstpair_pre(s, a, &clean_addr, &dirty_addr, offset, false);
+    tcg_rt = cpu_reg(s, a->rt);
+    tcg_rt2 = cpu_reg(s, a->rt2);
+    tmp = tcg_temp_new_i64();
+
+    /*
+     * Do not modify tcg_rt before recognizing any exception
+     * from the second load.
+     */
+    do_gpr_ld(s, tmp, clean_addr, a->sz + a->sign * MO_SIGN,
+              false, false, 0, false, false);
+    tcg_gen_addi_i64(clean_addr, clean_addr, 1 << a->sz);
+    do_gpr_ld(s, tcg_rt2, clean_addr, a->sz + a->sign * MO_SIGN,
+              false, false, 0, false, false);
+    tcg_gen_mov_i64(tcg_rt, tmp);
+    op_addr_ldstpair_post(s, a, dirty_addr, offset);
+    return true;
+}
+
+static bool trans_STP_v(DisasContext *s, arg_ldstpair *a)
+{
+    uint64_t offset = a->imm << a->sz;
+    TCGv_i64 clean_addr, dirty_addr;
+
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    op_addr_ldstpair_pre(s, a, &clean_addr, &dirty_addr, offset, true);
+    do_fp_st(s, a->rt, clean_addr, a->sz);
+    tcg_gen_addi_i64(clean_addr, clean_addr, 1 << a->sz);
+    do_fp_st(s, a->rt2, clean_addr, a->sz);
+    op_addr_ldstpair_post(s, a, dirty_addr, offset);
+    return true;
+}
+
+static bool trans_LDP_v(DisasContext *s, arg_ldstpair *a)
+{
+    uint64_t offset = a->imm << a->sz;
+    TCGv_i64 clean_addr, dirty_addr;
+
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    op_addr_ldstpair_pre(s, a, &clean_addr, &dirty_addr, offset, false);
+    do_fp_ld(s, a->rt, clean_addr, a->sz);
+    tcg_gen_addi_i64(clean_addr, clean_addr, 1 << a->sz);
+    do_fp_ld(s, a->rt2, clean_addr, a->sz);
+    op_addr_ldstpair_post(s, a, dirty_addr, offset);
+    return true;
+}
+
+static bool trans_STGP(DisasContext *s, arg_ldstpair *a)
+{
+    TCGv_i64 clean_addr, dirty_addr, tcg_rt, tcg_rt2;
+    uint64_t offset = a->imm << LOG2_TAG_GRANULE;
+
+    if (!dc_isar_feature(aa64_mte_insn_reg, s)) {
+        return false;
+    }
+
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+
+    dirty_addr = read_cpu_reg_sp(s, a->rn, 1);
+    if (!a->p) {
         tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
     }
 
-    if (set_tag) {
-        if (!s->ata) {
-            /*
-             * TODO: We could rely on the stores below, at least for
-             * system mode, if we arrange to add MO_ALIGN_16.
-             */
-            gen_helper_stg_stub(cpu_env, dirty_addr);
-        } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
-            gen_helper_stg_parallel(cpu_env, dirty_addr, dirty_addr);
-        } else {
-            gen_helper_stg(cpu_env, dirty_addr, dirty_addr);
-        }
-    }
-
-    clean_addr = gen_mte_checkN(s, dirty_addr, !is_load,
-                                (wback || rn != 31) && !set_tag, 2 << size);
-
-    if (is_vector) {
-        if (is_load) {
-            do_fp_ld(s, rt, clean_addr, size);
-        } else {
-            do_fp_st(s, rt, clean_addr, size);
-        }
-        tcg_gen_addi_i64(clean_addr, clean_addr, 1 << size);
-        if (is_load) {
-            do_fp_ld(s, rt2, clean_addr, size);
-        } else {
-            do_fp_st(s, rt2, clean_addr, size);
-        }
+    if (!s->ata) {
+        /*
+         * TODO: We could rely on the stores below, at least for
+         * system mode, if we arrange to add MO_ALIGN_16.
+         */
+        gen_helper_stg_stub(cpu_env, dirty_addr);
+    } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+        gen_helper_stg_parallel(cpu_env, dirty_addr, dirty_addr);
     } else {
-        TCGv_i64 tcg_rt = cpu_reg(s, rt);
-        TCGv_i64 tcg_rt2 = cpu_reg(s, rt2);
-
-        if (is_load) {
-            TCGv_i64 tmp = tcg_temp_new_i64();
-
-            /* Do not modify tcg_rt before recognizing any exception
-             * from the second load.
-             */
-            do_gpr_ld(s, tmp, clean_addr, size + is_signed * MO_SIGN,
-                      false, false, 0, false, false);
-            tcg_gen_addi_i64(clean_addr, clean_addr, 1 << size);
-            do_gpr_ld(s, tcg_rt2, clean_addr, size + is_signed * MO_SIGN,
-                      false, false, 0, false, false);
-
-            tcg_gen_mov_i64(tcg_rt, tmp);
-        } else {
-            do_gpr_st(s, tcg_rt, clean_addr, size,
-                      false, 0, false, false);
-            tcg_gen_addi_i64(clean_addr, clean_addr, 1 << size);
-            do_gpr_st(s, tcg_rt2, clean_addr, size,
-                      false, 0, false, false);
-        }
+        gen_helper_stg(cpu_env, dirty_addr, dirty_addr);
     }
 
-    if (wback) {
-        if (postindex) {
-            tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
-        }
-        tcg_gen_mov_i64(cpu_reg_sp(s, rn), dirty_addr);
-    }
+    clean_addr = gen_mte_checkN(s, dirty_addr, true, false, 2 << a->sz);
+
+    tcg_rt = cpu_reg(s, a->rt);
+    tcg_rt2 = cpu_reg(s, a->rt2);
+    do_gpr_st(s, tcg_rt, clean_addr, a->sz, false, 0, false, false);
+    tcg_gen_addi_i64(clean_addr, clean_addr, 1 << a->sz);
+    do_gpr_st(s, tcg_rt2, clean_addr, a->sz, false, 0, false, false);
+    op_addr_ldstpair_post(s, a, dirty_addr, offset);
+    return true;
 }
 
 /*
@@ -4037,10 +4002,6 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
 static void disas_ldst(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 24, 6)) {
-    case 0x28: case 0x29:
-    case 0x2c: case 0x2d: /* Load/store pair (all forms) */
-        disas_ldst_pair(s, insn);
-        break;
     case 0x38: case 0x39:
     case 0x3c: case 0x3d: /* Load/store register (all forms) */
         disas_ldst_reg(s, insn);
-- 
2.34.1


