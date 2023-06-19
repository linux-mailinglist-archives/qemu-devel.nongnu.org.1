Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D687359AD
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:34:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFtc-0001so-Nl; Mon, 19 Jun 2023 10:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsp-0000eG-Ka
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:31 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsl-0002Et-KI
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:29 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f9b4bf99c2so2677525e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184965; x=1689776965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UCkEkguPOB/xIEzZv8yei29B4GMdfNYqdXLsWKHETTU=;
 b=DXG5deqSwM0TiItSxNbgpTIRnEZAoxoncUlZX3o+sDNt0LEpSzepOvlXlx5Rbh68F7
 tHF1WAClgFUkChhzTs6FurupY8UUxuegR3Uw1UBS7jOz4gqQ6lMkgyaRTLHnBtFtelL6
 LelR7/nDewtaFgZr8ggJ5w6uM5587jopojGtx2OR0/Iq6yuLk3ecexUGm1+bI1YIEBQx
 nb6JQubaWT3Y2PhgP5gFYl+x0PmsCGWM1M136kY0XT1wwPfDhvJ1atOlJ3R5Sqfqd1QA
 4V3q0Bmm3Xuhf8WclRpz1a9qjk9Ag83hfH2lr8Ox76wUoc16T0Yh01Yyr1lStuK/333V
 7OkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184965; x=1689776965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCkEkguPOB/xIEzZv8yei29B4GMdfNYqdXLsWKHETTU=;
 b=Jw9xkBwd/Qr/vMsIgs6IfKdrjdotI2Jg53jxavdBlzIKxbrEV2H1CuWz7606M6IZph
 2dgFshgDAcKecyUNbRkyI7wRg7/yT747VMKs8FfkI1k5QcTXSfzHO/rkrdRULLT4DzTI
 b1phlB5FhSO7RCsCho5ohGD6bWk32v/Bb/nP+Qqj4ETN6+bYXU/EjFU9OoQihqN80bnh
 TcL6jwqHlbQRzwLrKtHfS18q1lNjE+lomBRHXLaLsEtIE0D5spUTHa1qFDCB3/iuGu4M
 w4BEYeGV+Q8ddaR86dXCvMjNVtPuCiSO2fKL4kTfAhwPWVPnQz15/uy6Cz3eSXkgeo1a
 cchA==
X-Gm-Message-State: AC+VfDy6/SPCQwwxjj6DcE6eNboPNgeNCwxrw3MFc17TdtA5bHmMXTWF
 mf43XlMTapNQujCVUKvMIcolyKF7aR+FtQQr4ZI=
X-Google-Smtp-Source: ACHHUZ7EYQb9vJjrTzr5cjuW3Rl4ANG5LHvphGprFZAEP+rQssphEB5uxGybv6Tcnyih2iHDEJFHqw==
X-Received: by 2002:a7b:c38f:0:b0:3f8:ff9d:dcdd with SMTP id
 s15-20020a7bc38f000000b003f8ff9ddcddmr5517773wmj.8.1687184965131; 
 Mon, 19 Jun 2023 07:29:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/33] target/arm: Convert LDAPR/STLR (imm) to decodetree
Date: Mon, 19 Jun 2023 15:29:01 +0100
Message-Id: <20230619142914.963184-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Convert the instructions in the LDAPR/STLR (unscaled immediate)
group to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230602155223.2040685-18-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |  10 +++
 target/arm/tcg/translate-a64.c | 132 ++++++++++++---------------------
 2 files changed, 56 insertions(+), 86 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index b80a17111e7..db4f44c4f40 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -464,3 +464,13 @@ LDAPR           sz:2 111 0 00 1 0 1 11111 1100 00 rn:5 rt:5
 %ldra_imm       22:s1 12:9 !function=times_2
 
 LDRA            11 111 0 00 m:1 . 1 ......... w:1 1 rn:5 rt:5 imm=%ldra_imm
+
+&ldapr_stlr_i   rn rt imm sz sign ext
+@ldapr_stlr_i   .. ...... .. . imm:9 .. rn:5 rt:5 &ldapr_stlr_i
+STLR_i          sz:2 011001 00 0 ......... 00 ..... ..... @ldapr_stlr_i sign=0 ext=0
+LDAPR_i         sz:2 011001 01 0 ......... 00 ..... ..... @ldapr_stlr_i sign=0 ext=0
+LDAPR_i         00 011001 10 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=0 sz=0
+LDAPR_i         01 011001 10 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=0 sz=1
+LDAPR_i         10 011001 10 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=0 sz=2
+LDAPR_i         00 011001 11 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=1 sz=0
+LDAPR_i         01 011001 11 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=1 sz=1
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2bffb14e84e..c0d38c48798 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2652,22 +2652,12 @@ static void gen_compare_and_swap_pair(DisasContext *s, int rs, int rt,
     }
 }
 
-/* Update the Sixty-Four bit (SF) registersize. This logic is derived
+/*
+ * Compute the ISS.SF bit for syndrome information if an exception
+ * is taken on a load or store. This indicates whether the instruction
+ * is accessing a 32-bit or 64-bit register. This logic is derived
  * from the ARMv8 specs for LDR (Shared decode for all encodings).
  */
-static bool disas_ldst_compute_iss_sf(int size, bool is_signed, int opc)
-{
-    int opc0 = extract32(opc, 0, 1);
-    int regsize;
-
-    if (is_signed) {
-        regsize = opc0 ? 32 : 64;
-    } else {
-        regsize = size == 3 ? 64 : 32;
-    }
-    return regsize == 64;
-}
-
 static bool ldst_iss_sf(int size, bool sign, bool ext)
 {
 
@@ -3368,88 +3358,60 @@ static bool trans_LDRA(DisasContext *s, arg_LDRA *a)
     return true;
 }
 
-/*
- * LDAPR/STLR (unscaled immediate)
- *
- *  31  30            24    22  21       12    10    5     0
- * +------+-------------+-----+---+--------+-----+----+-----+
- * | size | 0 1 1 0 0 1 | opc | 0 |  imm9  | 0 0 | Rn |  Rt |
- * +------+-------------+-----+---+--------+-----+----+-----+
- *
- * Rt: source or destination register
- * Rn: base register
- * imm9: unscaled immediate offset
- * opc: 00: STLUR*, 01/10/11: various LDAPUR*
- * size: size of load/store
- */
-static void disas_ldst_ldapr_stlr(DisasContext *s, uint32_t insn)
+static bool trans_LDAPR_i(DisasContext *s, arg_ldapr_stlr_i *a)
 {
-    int rt = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int offset = sextract32(insn, 12, 9);
-    int opc = extract32(insn, 22, 2);
-    int size = extract32(insn, 30, 2);
     TCGv_i64 clean_addr, dirty_addr;
-    bool is_store = false;
-    bool extend = false;
-    bool iss_sf;
-    MemOp mop = size;
+    MemOp mop = a->sz | (a->sign ? MO_SIGN : 0);
+    bool iss_sf = ldst_iss_sf(a->sz, a->sign, a->ext);
 
     if (!dc_isar_feature(aa64_rcpc_8_4, s)) {
-        unallocated_encoding(s);
-        return;
+        return false;
     }
 
-    switch (opc) {
-    case 0: /* STLURB */
-        is_store = true;
-        break;
-    case 1: /* LDAPUR* */
-        break;
-    case 2: /* LDAPURS* 64-bit variant */
-        if (size == 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        mop |= MO_SIGN;
-        break;
-    case 3: /* LDAPURS* 32-bit variant */
-        if (size > 1) {
-            unallocated_encoding(s);
-            return;
-        }
-        mop |= MO_SIGN;
-        extend = true; /* zero-extend 32->64 after signed load */
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    iss_sf = disas_ldst_compute_iss_sf(size, (mop & MO_SIGN) != 0, opc);
-
-    if (rn == 31) {
+    if (a->rn == 31) {
         gen_check_sp_alignment(s);
     }
 
-    mop = check_ordered_align(s, rn, offset, is_store, mop);
-
-    dirty_addr = read_cpu_reg_sp(s, rn, 1);
-    tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
+    mop = check_ordered_align(s, a->rn, a->imm, false, mop);
+    dirty_addr = read_cpu_reg_sp(s, a->rn, 1);
+    tcg_gen_addi_i64(dirty_addr, dirty_addr, a->imm);
     clean_addr = clean_data_tbi(s, dirty_addr);
 
-    if (is_store) {
-        /* Store-Release semantics */
-        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
-        do_gpr_st(s, cpu_reg(s, rt), clean_addr, mop, true, rt, iss_sf, true);
-    } else {
-        /*
-         * Load-AcquirePC semantics; we implement as the slightly more
-         * restrictive Load-Acquire.
-         */
-        do_gpr_ld(s, cpu_reg(s, rt), clean_addr, mop,
-                  extend, true, rt, iss_sf, true);
-        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+    /*
+     * Load-AcquirePC semantics; we implement as the slightly more
+     * restrictive Load-Acquire.
+     */
+    do_gpr_ld(s, cpu_reg(s, a->rt), clean_addr, mop, a->ext, true,
+              a->rt, iss_sf, true);
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+    return true;
+}
+
+static bool trans_STLR_i(DisasContext *s, arg_ldapr_stlr_i *a)
+{
+    TCGv_i64 clean_addr, dirty_addr;
+    MemOp mop = a->sz;
+    bool iss_sf = ldst_iss_sf(a->sz, a->sign, a->ext);
+
+    if (!dc_isar_feature(aa64_rcpc_8_4, s)) {
+        return false;
     }
+
+    /* TODO: ARMv8.4-LSE SCTLR.nAA */
+
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+
+    mop = check_ordered_align(s, a->rn, a->imm, true, mop);
+    dirty_addr = read_cpu_reg_sp(s, a->rn, 1);
+    tcg_gen_addi_i64(dirty_addr, dirty_addr, a->imm);
+    clean_addr = clean_data_tbi(s, dirty_addr);
+
+    /* Store-Release semantics */
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+    do_gpr_st(s, cpu_reg(s, a->rt), clean_addr, mop, true, a->rt, iss_sf, true);
+    return true;
 }
 
 /* AdvSIMD load/store multiple structures
@@ -3978,8 +3940,6 @@ static void disas_ldst(DisasContext *s, uint32_t insn)
     case 0x19:
         if (extract32(insn, 21, 1) != 0) {
             disas_ldst_tag(s, insn);
-        } else if (extract32(insn, 10, 2) == 0) {
-            disas_ldst_ldapr_stlr(s, insn);
         } else {
             unallocated_encoding(s);
         }
-- 
2.34.1


