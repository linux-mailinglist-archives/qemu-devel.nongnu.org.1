Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F5772B2C7
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 18:06:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8NVg-0006XA-5A; Sun, 11 Jun 2023 12:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUp-0005wt-KU
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:53 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUj-0000WL-Dc
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:51 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30e412a852dso2205549f8f.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686499244; x=1689091244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oLXqPmCYkrVQJjFssdMLngIfPo1Xii5VF1gQjOemTjU=;
 b=FztI6AKJSqmxnkw6DQTdM5787q4EEfj/2IRls1cxJXF40xY4Q64XQq5n56GYm8rQmf
 B2QUiPpJYLm3Q2wiHZH33wjPOyhwTuY9IHBlCNfaPeS5ZrlCjMIBrvMWxcOLdSGR8Tvc
 q/lNygn+VySdGz/V+78E3jBCSpII5ghqxasHM1svvqOO2/0ISyCqLFhbeYecZ9/2WGt2
 WKQfgK2c2jEubr1FJAKSleT4oaorSah2AYcv2Uwum3Oir3e93bWqAq+/Ug5Boy5+EI6t
 HggNsj7yQaThluJdH0N5UH1jEayJWHC5pZQHXOxxLxft4Qn+EBUIyqSdfjW14ZPWRsW/
 jK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686499244; x=1689091244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oLXqPmCYkrVQJjFssdMLngIfPo1Xii5VF1gQjOemTjU=;
 b=l7QdzL82vl6ppVmX2J5rutn79n8ZNKLSOp+5zvabPxiOFqtikJSJRwjBv04RD1IeXd
 yBzoT+997SkF4DcZl3m6KmSUuRVpGd00Bw+Kwj8jupbWHfzekNLO/PvNDrCEjQ9GHatn
 OFTvL5WaIA2AueL1WSyFR9yTAY4ABNcFEQsR46apI7tGQKOr5lcnaUMYTU4qUnLA+FlJ
 9jt3X0c+eGrh/9CihYIbcV3Wux4q1vOXZ8QS3MPxCy5AVUJ9gVie5/eUIlEBTuveZQ+N
 q81XihYN3x0O83kHTdPGyI2sL7SmTGqFuhta7K/FadbaxmqYcGBQTam2pfB1sJlgKA0g
 4bNQ==
X-Gm-Message-State: AC+VfDwSxfS1QwMwbyorWuKGWTQB/A/JRrcCTgReW5JzuzRPxEXEdqEA
 QqEqKTr4XL6ZfpHhYyOIdvnvXA==
X-Google-Smtp-Source: ACHHUZ7Aj0/tieaFGlWPf0cvh8zHacxNdQM++DsJwV06/TgQQAICw+m2NsAd9N4L3GHTV68/Shd85w==
X-Received: by 2002:adf:f642:0:b0:2f0:2dfe:e903 with SMTP id
 x2-20020adff642000000b002f02dfee903mr2240852wrp.69.1686499243992; 
 Sun, 11 Jun 2023 09:00:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a056000008900b0030ae499da59sm9923022wrx.111.2023.06.11.09.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 09:00:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 18/23] target/arm: Convert atomic memory ops to decodetree
Date: Sun, 11 Jun 2023 17:00:27 +0100
Message-Id: <20230611160032.274823-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611160032.274823-1-peter.maydell@linaro.org>
References: <20230611160032.274823-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230602155223.2040685-16-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |  15 ++++
 target/arm/tcg/translate-a64.c | 153 ++++++++++++---------------------
 2 files changed, 70 insertions(+), 98 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 5c086d6af6d..799c5ecb77a 100644
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
index 3d161169411..ba072e557e1 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3244,113 +3244,32 @@ static bool trans_STR_v(DisasContext *s, arg_ldst *a)
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
-    MemOp mop = size;
+    MemOp mop = a->sz | sign;
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
-
-    mop = check_atomic_align(s, rn, mop);
-    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn), false, rn != 31, mop);
-
-    if (o3_opc == 014) {
-        /*
-         * LDAPR* are a special case because they are a simple load, not a
-         * fetch-and-do-something op.
-         * The architectural consistency requirements here are weaker than
-         * full load-acquire (we only need "load-acquire processor consistent"),
-         * but we choose to implement them as full LDAQ.
-         */
-        do_gpr_ld(s, cpu_reg(s, rt), clean_addr, mop, false,
-                  true, rt, disas_ldst_compute_iss_sf(size, false, 0), true);
-        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
-        return;
-    }
-
-    tcg_rs = read_cpu_reg(s, rs, true);
-    tcg_rt = cpu_reg(s, rt);
-
-    if (o3_opc == 1) { /* LDCLR */
+    mop = check_atomic_align(s, a->rn, mop);
+    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, a->rn), false,
+                                a->rn != 31, mop);
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
@@ -3366,6 +3285,46 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
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
+    MemOp mop;
+
+    if (!dc_isar_feature(aa64_atomics, s) ||
+        !dc_isar_feature(aa64_rcpc_8_3, s)) {
+        return false;
+    }
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+    mop = check_atomic_align(s, a->rn, a->sz);
+    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, a->rn), false,
+                                a->rn != 31, mop);
+    /*
+     * LDAPR* are a special case because they are a simple load, not a
+     * fetch-and-do-something op.
+     * The architectural consistency requirements here are weaker than
+     * full load-acquire (we only need "load-acquire processor consistent"),
+     * but we choose to implement them as full LDAQ.
+     */
+    do_gpr_ld(s, cpu_reg(s, a->rt), clean_addr, mop, false,
+              true, a->rt, iss_sf, true);
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+    return true;
 }
 
 /*
@@ -3532,8 +3491,6 @@ static void disas_ldst_reg(DisasContext *s, uint32_t insn)
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


