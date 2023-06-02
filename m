Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 916B27206A3
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:55:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5750-0003HC-J3; Fri, 02 Jun 2023 11:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574y-0003Fu-4A
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574s-0003Xe-Rl
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:39 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f6042d605dso20943875e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 08:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685721153; x=1688313153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a4i0A8Mu1QFnQmDW94246VyJQXPq6h6YfEV1eAsIzvI=;
 b=HsgjNAeTHApXLoYtagNnBMbH+mSTSu7kepIQt/yql5udHw3KFSFUCjapUGEZm8QuEO
 36K3gR5stEfVeutJCliDGOg0/LlvV6Zp+4LCaYmsywrr4EI2CQMahjtZu3LfHNTvBEKs
 cPt78hHIKWVbmEqyqqV+FytqxHqyWptdPE3wzF1ySD/igZWwAJUEbS2kA2Q1VNWNpC8N
 nExbyFqMY8D4oAECQL9pyxcxv92053KJlBJbhUdRLvSLliry6YzBG1m8sXkZyv0PRkvt
 jD+XiLkR/8UVstFivCZ6JzUgEmEcKX7hisTKkYR/82GH7Mk8v1yumFXxUEgwWlttnYZl
 DJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685721153; x=1688313153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a4i0A8Mu1QFnQmDW94246VyJQXPq6h6YfEV1eAsIzvI=;
 b=A9DWjIeL8UnPMfNHjLG2c4YzFw+7OqaiqTmPx1Nbj4KD8rVPr9P6dgESGcIm6rGJFV
 e463X+SnhfgHEzKkyk7fOFsgJZZ7GNTvhQycFVYwHdI8ngHbmOmeLR/zeOQDbtAv5oec
 ADQ1PlY1gR9DTk3sGW+JxNbfNoN22Dh3Yz4+sM9pNTZ7TrnPVOsbnNqxCHbeFkxt9gp2
 8wZRWOKV22xMaLCDejSnlYWcaJU5i+VG0Z4K6ZUcDVYljxGi8DYIoIH0zP5Mo8BfD2l9
 3iUR5+YtXusn2mkUVAEpiodw6WCujs7QxIiFb1vvSoHD1UeK8R+mZF3903/JpTv9eYxo
 HDGg==
X-Gm-Message-State: AC+VfDw9rjAk8cYYBezrq41pDoOdKduVrcLqibwQOXJKFMGcEFfYvAF7
 DFVxnqJciTg0nB4uiFcnCma3nANpQhszI08G4N8=
X-Google-Smtp-Source: ACHHUZ62nkEPXYguvphz2Tyvvg6lR2erhccBhNTxKmv6tfZjRrMc0fhzf96SjVmSJb5BaoJqn7BmnA==
X-Received: by 2002:a7b:ce89:0:b0:3f6:552:8722 with SMTP id
 q9-20020a7bce89000000b003f605528722mr2203106wmj.18.1685721153405; 
 Fri, 02 Jun 2023 08:52:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003f72a15301csm594952wml.2.2023.06.02.08.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 08:52:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 15/20] target/arm: Convert atomic memory ops to decodetree
Date: Fri,  2 Jun 2023 16:52:18 +0100
Message-Id: <20230602155223.2040685-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602155223.2040685-1-peter.maydell@linaro.org>
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Convert the insns in the atomic memory operations group to
decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  15 ++++
 target/arm/tcg/translate-a64.c | 148 ++++++++++++---------------------
 2 files changed, 67 insertions(+), 96 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 189a30b1552..69635586718 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -442,3 +442,18 @@ STR_v           sz:2 111 1 00 00 1 ..... ... . 10 ..... ..... @ldst sign=0 ext=0
 STR_v           00 111 1 00 10 1 ..... ... . 10 ..... ..... @ldst sign=0 ext=0 sz=4
 LDR_v           sz:2 111 1 00 01 1 ..... ... . 10 ..... ..... @ldst sign=0 ext=0
 LDR_v           00 111 1 00 11 1 ..... ... . 10 ..... ..... @ldst sign=0 ext=0 sz=4
+
+# Atomic memory operations
+&atomic         rs rn rt a r sz
+@atomic         sz:2 ... . .. a:1 r:1 . rs:5 . ... .. rn:5 rt:5 &atomic
+LDADD           .. 111 0 00 . . 1 ..... 0000 00 ..... ..... @atomic
+LDCLR           .. 111 0 00 . . 1 ..... 0001 00 ..... ..... @atomic
+LDEOR           .. 111 0 00 . . 1 ..... 0010 00 ..... ..... @atomic
+LDSET           .. 111 0 00 . . 1 ..... 0011 00 ..... ..... @atomic
+LDSMAX          .. 111 0 00 . . 1 ..... 0100 00 ..... ..... @atomic
+LDSMIN          .. 111 0 00 . . 1 ..... 0101 00 ..... ..... @atomic
+LDUMAX          .. 111 0 00 . . 1 ..... 0110 00 ..... ..... @atomic
+LDUMIN          .. 111 0 00 . . 1 ..... 0111 00 ..... ..... @atomic
+SWP             .. 111 0 00 . . 1 ..... 1000 00 ..... ..... @atomic
+
+LDAPR           sz:2 111 0 00 1 0 1 11111 1100 00 rn:5 rt:5
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c3eb51e99ff..4e3bebab8e0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3070,111 +3070,31 @@ static bool trans_STR_v(DisasContext *s, arg_ldst *a)
     return true;
 }
 
-/* Atomic memory operations
- *
- *  31  30      27  26    24    22  21   16   15    12    10    5     0
- * +------+-------+---+-----+-----+---+----+----+-----+-----+----+-----+
- * | size | 1 1 1 | V | 0 0 | A R | 1 | Rs | o3 | opc | 0 0 | Rn |  Rt |
- * +------+-------+---+-----+-----+--------+----+-----+-----+----+-----+
- *
- * Rt: the result register
- * Rn: base address or SP
- * Rs: the source register for the operation
- * V: vector flag (always 0 as of v8.3)
- * A: acquire flag
- * R: release flag
- */
-static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
-                              int size, int rt, bool is_vector)
+
+static bool do_atomic_ld(DisasContext *s, arg_atomic *a, AtomicThreeOpFn *fn,
+                         int sign, bool invert)
 {
-    int rs = extract32(insn, 16, 5);
-    int rn = extract32(insn, 5, 5);
-    int o3_opc = extract32(insn, 12, 4);
-    bool r = extract32(insn, 22, 1);
-    bool a = extract32(insn, 23, 1);
-    TCGv_i64 tcg_rs, tcg_rt, clean_addr;
-    AtomicThreeOpFn *fn = NULL;
-    MemOp mop = s->be_data | size | MO_ALIGN;
+    MemOp mop = s->be_data | a->sz | MO_ALIGN | sign;
+    TCGv_i64 clean_addr, tcg_rs, tcg_rt;
 
-    if (is_vector || !dc_isar_feature(aa64_atomics, s)) {
-        unallocated_encoding(s);
-        return;
-    }
-    switch (o3_opc) {
-    case 000: /* LDADD */
-        fn = tcg_gen_atomic_fetch_add_i64;
-        break;
-    case 001: /* LDCLR */
-        fn = tcg_gen_atomic_fetch_and_i64;
-        break;
-    case 002: /* LDEOR */
-        fn = tcg_gen_atomic_fetch_xor_i64;
-        break;
-    case 003: /* LDSET */
-        fn = tcg_gen_atomic_fetch_or_i64;
-        break;
-    case 004: /* LDSMAX */
-        fn = tcg_gen_atomic_fetch_smax_i64;
-        mop |= MO_SIGN;
-        break;
-    case 005: /* LDSMIN */
-        fn = tcg_gen_atomic_fetch_smin_i64;
-        mop |= MO_SIGN;
-        break;
-    case 006: /* LDUMAX */
-        fn = tcg_gen_atomic_fetch_umax_i64;
-        break;
-    case 007: /* LDUMIN */
-        fn = tcg_gen_atomic_fetch_umin_i64;
-        break;
-    case 010: /* SWP */
-        fn = tcg_gen_atomic_xchg_i64;
-        break;
-    case 014: /* LDAPR, LDAPRH, LDAPRB */
-        if (!dc_isar_feature(aa64_rcpc_8_3, s) ||
-            rs != 31 || a != 1 || r != 0) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
-    default:
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (rn == 31) {
+    if (a->rn == 31) {
         gen_check_sp_alignment(s);
     }
-    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn), false, rn != 31, size);
-
-    if (o3_opc == 014) {
-        /*
-         * LDAPR* are a special case because they are a simple load, not a
-         * fetch-and-do-something op.
-         * The architectural consistency requirements here are weaker than
-         * full load-acquire (we only need "load-acquire processor consistent"),
-         * but we choose to implement them as full LDAQ.
-         */
-        do_gpr_ld(s, cpu_reg(s, rt), clean_addr, size, false,
-                  true, rt, disas_ldst_compute_iss_sf(size, false, 0), true);
-        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
-        return;
-    }
-
-    tcg_rs = read_cpu_reg(s, rs, true);
-    tcg_rt = cpu_reg(s, rt);
-
-    if (o3_opc == 1) { /* LDCLR */
+    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, a->rn), false,
+                                a->rn != 31, a->sz);
+    tcg_rs = read_cpu_reg(s, a->rs, true);
+    tcg_rt = cpu_reg(s, a->rt);
+    if (invert) {
         tcg_gen_not_i64(tcg_rs, tcg_rs);
     }
-
-    /* The tcg atomic primitives are all full barriers.  Therefore we
+    /*
+     * The tcg atomic primitives are all full barriers.  Therefore we
      * can ignore the Acquire and Release bits of this instruction.
      */
     fn(tcg_rt, clean_addr, tcg_rs, get_mem_index(s), mop);
 
     if (mop & MO_SIGN) {
-        switch (size) {
+        switch (a->sz) {
         case MO_8:
             tcg_gen_ext8u_i64(tcg_rt, tcg_rt);
             break;
@@ -3190,6 +3110,44 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
             g_assert_not_reached();
         }
     }
+    return true;
+}
+
+TRANS_FEAT(LDADD, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_add_i64, 0, false)
+TRANS_FEAT(LDCLR, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_and_i64, 0, true)
+TRANS_FEAT(LDEOR, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_xor_i64, 0, false)
+TRANS_FEAT(LDSET, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_or_i64, 0, false)
+TRANS_FEAT(LDSMAX, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_smax_i64, MO_SIGN, false)
+TRANS_FEAT(LDSMIN, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_smin_i64, MO_SIGN, false)
+TRANS_FEAT(LDUMAX, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_umax_i64, 0, false)
+TRANS_FEAT(LDUMIN, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_umin_i64, 0, false)
+TRANS_FEAT(SWP, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_xchg_i64, 0, false)
+
+static bool trans_LDAPR(DisasContext *s, arg_LDAPR *a)
+{
+    bool iss_sf = ldst_iss_sf(a->sz, false, false);
+    TCGv_i64 clean_addr;
+
+    if (!dc_isar_feature(aa64_atomics, s) ||
+        !dc_isar_feature(aa64_rcpc_8_3, s)) {
+        return false;
+    }
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, a->rn), false,
+                                a->rn != 31, a->sz);
+    /*
+     * LDAPR* are a special case because they are a simple load, not a
+     * fetch-and-do-something op.
+     * The architectural consistency requirements here are weaker than
+     * full load-acquire (we only need "load-acquire processor consistent"),
+     * but we choose to implement them as full LDAQ.
+     */
+    do_gpr_ld(s, cpu_reg(s, a->rt), clean_addr, a->sz, false,
+              true, a->rt, iss_sf, true);
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+    return true;
 }
 
 /*
@@ -3354,8 +3312,6 @@ static void disas_ldst_reg(DisasContext *s, uint32_t insn)
         }
         switch (extract32(insn, 10, 2)) {
         case 0:
-            disas_ldst_atomic(s, insn, size, rt, is_vector);
-            return;
         case 2:
             break;
         default:
-- 
2.34.1


