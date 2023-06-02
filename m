Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CD2720698
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:54:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5752-0003KK-Jx; Fri, 02 Jun 2023 11:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574z-0003H0-LV
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:41 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574u-0003YH-6e
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:41 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f4b0a0b557so2987333e87.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685721154; x=1688313154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JfVx2Kw/t7FJ/1OcwZhRCEKMkqtcz8J5PlkevWU/G8w=;
 b=uCTXQ9Q2byZnGQjGGsmPl+KwDRH3s9xJYPn5+L6dEiAlFZUJeay4mW+wQkkPLll8s+
 EAvS8VK88usd3iIveoFJizq4CqGsk5xN1U2pQEJCoR4IlG+0n3zCKVaSBL2ZPCO7Q4sM
 FHPkj1Cp7/w85B32dKEA6q4j1XJ10DZfMKCSCXRqZ9gbfLU3FsowjB+0+/chQqfXBQMt
 lIh9BOudovR+09OC882jZiJEYRzePQeyurVrqPSNqviDcOtBDjKG8eFS9fK7bt9fAGzO
 7L5Rp4WSisZs4yPB4GMu4eE4qfDPWf1skzM1fgzqEkxb/Z1MX3+6gibW2XcqiF2Hetxk
 H0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685721154; x=1688313154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JfVx2Kw/t7FJ/1OcwZhRCEKMkqtcz8J5PlkevWU/G8w=;
 b=TOZQz3J/mz7gVquvWLg2OCmX1qq+/+24lu0w0d+ENnCD3s8kGMGNyqBQ9TOso5B2PU
 jaO25VDmyGxp2tZqX0XRgLQSb1NKo77Y0XP7uS1rcdaZX01O3U+Q0xPBK6lborXgAXhS
 A1BwE4WlMNvKfO65UT6AdSKBmMLa2Yb7QcWO0yGRQI73t+oHClhZCIbl3hhxG0eQyb/S
 lBX/Tpxp5Dd09f3Cy3FDKunwJAtjrfctET0nl1TqgJpixI8tyc+tQoop0kYw5JUYesew
 AQpxWadX6AtY+CWJzzWhKlEUwfdAEpNb5zKQ1BRtboihWAo/IhMHUjOyv112RNDd76Ht
 tJPg==
X-Gm-Message-State: AC+VfDwUrweK8t4/MpGY/TuhCPLe3tMkvsWR4NqMqs0lXYsCqGAMBjjF
 fHl8cse7EGypxjF6qe5OtGKavxUT09TZ2H3zCCM=
X-Google-Smtp-Source: ACHHUZ5NULUlrg3548WKfIBRaViSEldUBWvLwSvNUzOlYCBoEy9IhjSYtb8go9Ct1Ydteza7V0zR9w==
X-Received: by 2002:ac2:4428:0:b0:4f2:5c4b:e69b with SMTP id
 w8-20020ac24428000000b004f25c4be69bmr2388741lfl.67.1685721154307; 
 Fri, 02 Jun 2023 08:52:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003f72a15301csm594952wml.2.2023.06.02.08.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 08:52:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 17/20] target/arm: Convert LDAPR/STLR (imm) to decodetree
Date: Fri,  2 Jun 2023 16:52:20 +0100
Message-Id: <20230602155223.2040685-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602155223.2040685-1-peter.maydell@linaro.org>
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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
---
 target/arm/tcg/a64.decode      |  10 +++
 target/arm/tcg/translate-a64.c | 129 +++++++++++----------------------
 2 files changed, 54 insertions(+), 85 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 2ea85312bba..f75c227629b 100644
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
index 10a6fc4efb7..1cfd1cd7037 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2560,22 +2560,12 @@ static void gen_compare_and_swap_pair(DisasContext *s, int rs, int rt,
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
 
@@ -3191,89 +3181,60 @@ static bool trans_LDRA(DisasContext *s, arg_LDRA *a)
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
-    MemOp mop;
+    MemOp mop = a->sz | MO_ALIGN | (a->sign ? MO_SIGN : 0);
+    bool iss_sf = ldst_iss_sf(a->sz, a->sign, a->ext);
 
     if (!dc_isar_feature(aa64_rcpc_8_4, s)) {
-        unallocated_encoding(s);
-        return;
+        return false;
     }
 
     /* TODO: ARMv8.4-LSE SCTLR.nAA */
-    mop = size | MO_ALIGN;
 
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
 
-    dirty_addr = read_cpu_reg_sp(s, rn, 1);
-    tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
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
+    MemOp mop = a->sz | MO_ALIGN;
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
@@ -3794,8 +3755,6 @@ static void disas_ldst(DisasContext *s, uint32_t insn)
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


