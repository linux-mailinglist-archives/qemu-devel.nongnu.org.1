Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA757359A7
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:34:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFtP-0001CA-Da; Mon, 19 Jun 2023 10:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsk-0000bh-Uz
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:27 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsi-0002D4-5J
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:26 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f8f3786f1dso38809165e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184963; x=1689776963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zdWrcxAFWPcu8gfjJ8ZBg/XxlBs06EXCzgp0imYkLDs=;
 b=DW8gACuvqerhpco2+Jpb2vAim8cVMTJZF8WC31Gebkk6hNoNEBTvcGev93VBHDQ63M
 lEuvwkBsyuLA+9VueAfUtcROEv1DAgOf/JrSYPkWqAgS0UiaXdo1zvUW8lxgpDt4a7zD
 OHo4aawKjz74f+Jr+WGovtCQXdt6qJ0aMpvn90/g70gWXLXjpET9AuOee7wPj7oU35lL
 uECZXSQhJm7iciv1wvI2t7ygOK4ezwxmk0AOUVSaIZ797LYdQNCX/44CT4bQrXOSoIrL
 8V5yhE1r2YVZmiTHLHE81rovZthoI1AzoAfY7FY+qfpMQTzlLEPctNfXElqotEGFrDME
 38oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184963; x=1689776963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zdWrcxAFWPcu8gfjJ8ZBg/XxlBs06EXCzgp0imYkLDs=;
 b=Rd8tskSMqGVAN6AxskSh9B3OmbnHTQT0hyAOWymny+RrIQdJ92AHuUgtN5L0m3fdDl
 1eFW0srk46rUj/1KRRnAKJYz0fdbZqpbUXO09/YKUFd49fRSm4iikKzvv4niGI1SFSaH
 IN4VXFTMA4itJhh3lPAnfAjseo4rk1AzCfysKrp6iD14Bz56XW80kDDY7d2snkeMpSBh
 V/gsr3+8fRZGUykO4Ys24Q4wHyEyxgYrgPTRw7YC88Bxo4QAjDKjds9q8HHSMNsBZkjv
 zWQwzbWVko4GYG+71YU8mwSGRRQqYZ6+4yEMK+Od5dnUGwz7wmgyCE5HuVxicR9hZb3V
 7SXA==
X-Gm-Message-State: AC+VfDxR7dFFtKM1G/l15BF/ucPksiCZYYaM3Ex7bdqE2Fa+sEa4vUhl
 fDS9Ab9s8FimuUKoYzXg8tgKR82rKXhvpax83rw=
X-Google-Smtp-Source: ACHHUZ5oaIoH49MqoZOHSJPdluXmtcQ6A6BYWQyRJVldZvhpAoXL2YPSH34rK8tLO+5Ejy0DccYxzA==
X-Received: by 2002:a1c:f70f:0:b0:3f7:2a1d:1b05 with SMTP id
 v15-20020a1cf70f000000b003f72a1d1b05mr10605041wmh.14.1687184962742; 
 Mon, 19 Jun 2023 07:29:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/33] target/arm: Convert load/store-pair to decodetree
Date: Mon, 19 Jun 2023 15:28:55 +0100
Message-Id: <20230619142914.963184-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
Message-id: 20230602155223.2040685-12-peter.maydell@linaro.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  61 +++++
 target/arm/tcg/translate-a64.c | 422 ++++++++++++++++-----------------
 2 files changed, 268 insertions(+), 215 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index c2c6ac0196d..f5787919931 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -265,3 +265,64 @@ LD_lit_v        10 011 1 00 ................... ..... @ldlit sz=4 sign=0
 
 # PRFM
 NOP             11 011 0 00 ------------------- -----
+
+&ldstpair       rt2 rt rn imm sz sign w p
+@ldstpair       .. ... . ... . imm:s7 rt2:5 rn:5 rt:5 &ldstpair
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
index d1df41f2e5e..103e54d0c49 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2816,229 +2816,225 @@ static bool trans_LD_lit_v(DisasContext *s, arg_ldlit *a)
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
+                                 uint64_t offset, bool is_store, MemOp mop)
 {
-    int rt = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int rt2 = extract32(insn, 10, 5);
-    uint64_t offset = sextract64(insn, 15, 7);
-    int index = extract32(insn, 23, 2);
-    bool is_vector = extract32(insn, 26, 1);
-    bool is_load = extract32(insn, 22, 1);
-    int opc = extract32(insn, 30, 2);
-    bool is_signed = false;
-    bool postindex = false;
-    bool wback = false;
-    bool set_tag = false;
-    TCGv_i64 clean_addr, dirty_addr;
-    MemOp mop;
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
+                                 (a->w || a->rn != 31), 2 << a->sz, mop);
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
+    MemOp mop = finalize_memop(s, a->sz);
+
+    op_addr_ldstpair_pre(s, a, &clean_addr, &dirty_addr, offset, true, mop);
+    tcg_rt = cpu_reg(s, a->rt);
+    tcg_rt2 = cpu_reg(s, a->rt2);
+    /*
+     * We built mop above for the single logical access -- rebuild it
+     * now for the paired operation.
+     *
+     * With LSE2, non-sign-extending pairs are treated atomically if
+     * aligned, and if unaligned one of the pair will be completely
+     * within a 16-byte block and that element will be atomic.
+     * Otherwise each element is separately atomic.
+     * In all cases, issue one operation with the correct atomicity.
+     */
+    mop = a->sz + 1;
+    if (s->align_mem) {
+        mop |= (a->sz == 2 ? MO_ALIGN_4 : MO_ALIGN_8);
+    }
+    mop = finalize_memop_pair(s, mop);
+    if (a->sz == 2) {
+        TCGv_i64 tmp = tcg_temp_new_i64();
+
+        if (s->be_data == MO_LE) {
+            tcg_gen_concat32_i64(tmp, tcg_rt, tcg_rt2);
+        } else {
+            tcg_gen_concat32_i64(tmp, tcg_rt2, tcg_rt);
+        }
+        tcg_gen_qemu_st_i64(tmp, clean_addr, get_mem_index(s), mop);
+    } else {
+        TCGv_i128 tmp = tcg_temp_new_i128();
+
+        if (s->be_data == MO_LE) {
+            tcg_gen_concat_i64_i128(tmp, tcg_rt, tcg_rt2);
+        } else {
+            tcg_gen_concat_i64_i128(tmp, tcg_rt2, tcg_rt);
+        }
+        tcg_gen_qemu_st_i128(tmp, clean_addr, get_mem_index(s), mop);
+    }
+    op_addr_ldstpair_post(s, a, dirty_addr, offset);
+    return true;
+}
+
+static bool trans_LDP(DisasContext *s, arg_ldstpair *a)
+{
+    uint64_t offset = a->imm << a->sz;
+    TCGv_i64 clean_addr, dirty_addr, tcg_rt, tcg_rt2;
+    MemOp mop = finalize_memop(s, a->sz);
+
+    op_addr_ldstpair_pre(s, a, &clean_addr, &dirty_addr, offset, false, mop);
+    tcg_rt = cpu_reg(s, a->rt);
+    tcg_rt2 = cpu_reg(s, a->rt2);
+
+    /*
+     * We built mop above for the single logical access -- rebuild it
+     * now for the paired operation.
+     *
+     * With LSE2, non-sign-extending pairs are treated atomically if
+     * aligned, and if unaligned one of the pair will be completely
+     * within a 16-byte block and that element will be atomic.
+     * Otherwise each element is separately atomic.
+     * In all cases, issue one operation with the correct atomicity.
+     *
+     * This treats sign-extending loads like zero-extending loads,
+     * since that reuses the most code below.
+     */
+    mop = a->sz + 1;
+    if (s->align_mem) {
+        mop |= (a->sz == 2 ? MO_ALIGN_4 : MO_ALIGN_8);
+    }
+    mop = finalize_memop_pair(s, mop);
+    if (a->sz == 2) {
+        int o2 = s->be_data == MO_LE ? 32 : 0;
+        int o1 = o2 ^ 32;
+
+        tcg_gen_qemu_ld_i64(tcg_rt, clean_addr, get_mem_index(s), mop);
+        if (a->sign) {
+            tcg_gen_sextract_i64(tcg_rt2, tcg_rt, o2, 32);
+            tcg_gen_sextract_i64(tcg_rt, tcg_rt, o1, 32);
+        } else {
+            tcg_gen_extract_i64(tcg_rt2, tcg_rt, o2, 32);
+            tcg_gen_extract_i64(tcg_rt, tcg_rt, o1, 32);
+        }
+    } else {
+        TCGv_i128 tmp = tcg_temp_new_i128();
+
+        tcg_gen_qemu_ld_i128(tmp, clean_addr, get_mem_index(s), mop);
+        if (s->be_data == MO_LE) {
+            tcg_gen_extr_i128_i64(tcg_rt, tcg_rt2, tmp);
+        } else {
+            tcg_gen_extr_i128_i64(tcg_rt2, tcg_rt, tmp);
+        }
+    }
+    op_addr_ldstpair_post(s, a, dirty_addr, offset);
+    return true;
+}
+
+static bool trans_STP_v(DisasContext *s, arg_ldstpair *a)
+{
+    uint64_t offset = a->imm << a->sz;
+    TCGv_i64 clean_addr, dirty_addr;
+    MemOp mop;
+
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    /* LSE2 does not merge FP pairs; leave these as separate operations. */
+    mop = finalize_memop_asimd(s, a->sz);
+    op_addr_ldstpair_pre(s, a, &clean_addr, &dirty_addr, offset, true, mop);
+    do_fp_st(s, a->rt, clean_addr, mop);
+    tcg_gen_addi_i64(clean_addr, clean_addr, 1 << a->sz);
+    do_fp_st(s, a->rt2, clean_addr, mop);
+    op_addr_ldstpair_post(s, a, dirty_addr, offset);
+    return true;
+}
+
+static bool trans_LDP_v(DisasContext *s, arg_ldstpair *a)
+{
+    uint64_t offset = a->imm << a->sz;
+    TCGv_i64 clean_addr, dirty_addr;
+    MemOp mop;
+
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    /* LSE2 does not merge FP pairs; leave these as separate operations. */
+    mop = finalize_memop_asimd(s, a->sz);
+    op_addr_ldstpair_pre(s, a, &clean_addr, &dirty_addr, offset, false, mop);
+    do_fp_ld(s, a->rt, clean_addr, mop);
+    tcg_gen_addi_i64(clean_addr, clean_addr, 1 << a->sz);
+    do_fp_ld(s, a->rt2, clean_addr, mop);
+    op_addr_ldstpair_post(s, a, dirty_addr, offset);
+    return true;
+}
+
+static bool trans_STGP(DisasContext *s, arg_ldstpair *a)
+{
+    TCGv_i64 clean_addr, dirty_addr, tcg_rt, tcg_rt2;
+    uint64_t offset = a->imm << LOG2_TAG_GRANULE;
+    MemOp mop;
+    TCGv_i128 tmp;
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
-    if (is_vector) {
-        mop = finalize_memop_asimd(s, size);
-    } else {
-        mop = finalize_memop(s, size);
-    }
-    clean_addr = gen_mte_checkN(s, dirty_addr, !is_load,
-                                (wback || rn != 31) && !set_tag,
-                                2 << size, mop);
-
-    if (is_vector) {
-        /* LSE2 does not merge FP pairs; leave these as separate operations. */
-        if (is_load) {
-            do_fp_ld(s, rt, clean_addr, mop);
-        } else {
-            do_fp_st(s, rt, clean_addr, mop);
-        }
-        tcg_gen_addi_i64(clean_addr, clean_addr, 1 << size);
-        if (is_load) {
-            do_fp_ld(s, rt2, clean_addr, mop);
-        } else {
-            do_fp_st(s, rt2, clean_addr, mop);
-        }
-    } else {
-        TCGv_i64 tcg_rt = cpu_reg(s, rt);
-        TCGv_i64 tcg_rt2 = cpu_reg(s, rt2);
-
+    if (!s->ata) {
         /*
-         * We built mop above for the single logical access -- rebuild it
-         * now for the paired operation.
-         *
-         * With LSE2, non-sign-extending pairs are treated atomically if
-         * aligned, and if unaligned one of the pair will be completely
-         * within a 16-byte block and that element will be atomic.
-         * Otherwise each element is separately atomic.
-         * In all cases, issue one operation with the correct atomicity.
-         *
-         * This treats sign-extending loads like zero-extending loads,
-         * since that reuses the most code below.
+         * TODO: We could rely on the stores below, at least for
+         * system mode, if we arrange to add MO_ALIGN_16.
          */
-        mop = size + 1;
-        if (s->align_mem) {
-            mop |= (size == 2 ? MO_ALIGN_4 : MO_ALIGN_8);
-        }
-        mop = finalize_memop_pair(s, mop);
-
-        if (is_load) {
-            if (size == 2) {
-                int o2 = s->be_data == MO_LE ? 32 : 0;
-                int o1 = o2 ^ 32;
-
-                tcg_gen_qemu_ld_i64(tcg_rt, clean_addr, get_mem_index(s), mop);
-                if (is_signed) {
-                    tcg_gen_sextract_i64(tcg_rt2, tcg_rt, o2, 32);
-                    tcg_gen_sextract_i64(tcg_rt, tcg_rt, o1, 32);
-                } else {
-                    tcg_gen_extract_i64(tcg_rt2, tcg_rt, o2, 32);
-                    tcg_gen_extract_i64(tcg_rt, tcg_rt, o1, 32);
-                }
-            } else {
-                TCGv_i128 tmp = tcg_temp_new_i128();
-
-                tcg_gen_qemu_ld_i128(tmp, clean_addr, get_mem_index(s), mop);
-                if (s->be_data == MO_LE) {
-                    tcg_gen_extr_i128_i64(tcg_rt, tcg_rt2, tmp);
-                } else {
-                    tcg_gen_extr_i128_i64(tcg_rt2, tcg_rt, tmp);
-                }
-            }
-        } else {
-            if (size == 2) {
-                TCGv_i64 tmp = tcg_temp_new_i64();
-
-                if (s->be_data == MO_LE) {
-                    tcg_gen_concat32_i64(tmp, tcg_rt, tcg_rt2);
-                } else {
-                    tcg_gen_concat32_i64(tmp, tcg_rt2, tcg_rt);
-                }
-                tcg_gen_qemu_st_i64(tmp, clean_addr, get_mem_index(s), mop);
-            } else {
-                TCGv_i128 tmp = tcg_temp_new_i128();
-
-                if (s->be_data == MO_LE) {
-                    tcg_gen_concat_i64_i128(tmp, tcg_rt, tcg_rt2);
-                } else {
-                    tcg_gen_concat_i64_i128(tmp, tcg_rt2, tcg_rt);
-                }
-                tcg_gen_qemu_st_i128(tmp, clean_addr, get_mem_index(s), mop);
-            }
-        }
+        gen_helper_stg_stub(cpu_env, dirty_addr);
+    } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+        gen_helper_stg_parallel(cpu_env, dirty_addr, dirty_addr);
+    } else {
+        gen_helper_stg(cpu_env, dirty_addr, dirty_addr);
     }
 
-    if (wback) {
-        if (postindex) {
-            tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
-        }
-        tcg_gen_mov_i64(cpu_reg_sp(s, rn), dirty_addr);
+    mop = finalize_memop(s, a->sz);
+    clean_addr = gen_mte_checkN(s, dirty_addr, true, false, 2 << a->sz, mop);
+
+    tcg_rt = cpu_reg(s, a->rt);
+    tcg_rt2 = cpu_reg(s, a->rt2);
+
+    assert(a->sz == 3);
+
+    tmp = tcg_temp_new_i128();
+    if (s->be_data == MO_LE) {
+        tcg_gen_concat_i64_i128(tmp, tcg_rt, tcg_rt2);
+    } else {
+        tcg_gen_concat_i64_i128(tmp, tcg_rt2, tcg_rt);
     }
+    tcg_gen_qemu_st_i128(tmp, clean_addr, get_mem_index(s), mop);
+
+    op_addr_ldstpair_post(s, a, dirty_addr, offset);
+    return true;
 }
 
 /*
@@ -4184,10 +4180,6 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
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


