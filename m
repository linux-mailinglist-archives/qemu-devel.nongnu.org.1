Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DB87359A4
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:33:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFtP-0001F0-T6; Mon, 19 Jun 2023 10:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsm-0000dl-Vd
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:29 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsj-0002E3-Mh
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:28 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f9002a1a39so19963055e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184964; x=1689776964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GWDPHwbryLWLThkqGYPBgX9bWZ5mDhC9sezGwxPcAlQ=;
 b=XKumKUw282wpVtjdBX8yek+frrlnzqkJM7dcFDwj88/KqRlHDItdzVvKQQB4WcAGDv
 VcVTrCkNzIVgE3JsPfeFBaZA/w1HZtJnLh4AG5G8Jsya6Nqz/n5HlqpjIKERvIQ2+I3X
 HU/PEMZuQar2CB6sFPcZDeYI73PFLDfYBP6RYY2/ejhoI3mcfdp8ZGM5btowRxzRgV2f
 afBK0ysicjthC0nbKIqlCBskTPZlaLBvZbjjEXGsrgRMgqqaygF2kTDV/ZWmjS7WLdF5
 Ik9YR2wR32Ht6QawVCWjXP4vVxtVU9M8WMSkfKmHC2tA/8dt5eKPapw5fRMaEJrMilHI
 R0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184964; x=1689776964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GWDPHwbryLWLThkqGYPBgX9bWZ5mDhC9sezGwxPcAlQ=;
 b=hfhR5tqQJ4DPimXehyCsAOYEDCUb3uUllGgjpMam0ze4VyqnCDzgjRlaFL+TgAeM8i
 tMMrAuEmZ8R9RruNyaIh9PG5bV39eB1eVm30BnxpHyX7MmOBbiADEPAtVd7jlqlPtEcd
 dIVZxwl4K1fqngF8stgOMPriX3C3OF5votDLvtw7UTB5a458/mbPGQbGayfoDxg6vL1L
 hSLk3ucBahLy/0B466tc/IsIRgje2c1hvjXK742Ls5kGQHa9a47u8pF6owRRaWOzyqqE
 FfASFnfIxeI3G+m8DJV0lVNF6/lN8s6/zDBnmCbb0XG+J+khul03Cc11vYUtE45hnA6D
 oriQ==
X-Gm-Message-State: AC+VfDwt/HV5mU6+vfhGTyQgbnBJVa3Wx//4Y3tjTv6UNCc/e178LxDK
 d8dSpg4krM3cKgQxfVUOMPnpptthFNEGp3t4DVc=
X-Google-Smtp-Source: ACHHUZ7miIBrxYVck+Arp5oASn1LNM0JZ2R0ftJOh8+bDOPqdP7n4F6HprF6G30gHVaksIRn7VIIKA==
X-Received: by 2002:a7b:c8c9:0:b0:3f9:82f:bad5 with SMTP id
 f9-20020a7bc8c9000000b003f9082fbad5mr4190522wml.35.1687184964341; 
 Mon, 19 Jun 2023 07:29:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/33] target/arm: Convert atomic memory ops to decodetree
Date: Mon, 19 Jun 2023 15:28:59 +0100
Message-Id: <20230619142914.963184-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
index 2d5e920c7bb..6dc8151c407 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3241,113 +3241,32 @@ static bool trans_STR_v(DisasContext *s, arg_ldst *a)
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
@@ -3363,6 +3282,46 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
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
@@ -3529,8 +3488,6 @@ static void disas_ldst_reg(DisasContext *s, uint32_t insn)
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


