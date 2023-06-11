Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 102ED72B2C0
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 18:05:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8NVg-0006ZR-On; Sun, 11 Jun 2023 12:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUr-0005xo-3x
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:56 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUk-0000Ww-GT
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:52 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f7a8089709so36542515e9.1
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686499245; x=1689091245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=54h5KyRrZywpu1fDQUIOHLpTGvmaF3+L9nkmV/iZDt8=;
 b=siFfS4UeRkmZilsU8crwbaSQ0PtTACdyuQZNBjPeZkCl2/oeuNOIEPjUJCo/wGpG4n
 OEYNDhgLUVFZEybG2nfEYIv3sC636kT3ttpt1//LzwtTsZpCBN/ijhgLVZmjQw7lrIAk
 lt9ajJzD7yZPFlEBL8wJSrqhZXEiTvoHScr1TYhyZKfIjZk2Xw+HZ5UxY+r7cHEJOoBz
 qodiuoLRlKPPWZLvAj23b6hfKwIHrNwaQfjc+kIn+U+8pFwnDkMyL/bkG//HUD2YPE+7
 WE9zh9tYL4Dwbbr6jSs86iAGVeYjMYSSsvzA42xIwWjGJTXvLH3ISFaYMFEoFr5DE3m8
 MTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686499245; x=1689091245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=54h5KyRrZywpu1fDQUIOHLpTGvmaF3+L9nkmV/iZDt8=;
 b=A76UN+KvMsNn2xbVC7gkAawVfxVhCfiV6O+CeVw4bSMbgncLtzF8v/wDGtL4oePaqg
 3z7U2Qp0sRp5PEpFoXWkth5DuONx/CRfOgszOcMktLcweky92DNw5NyF6QDvza4ASKQW
 wU3hVlBWmNRhr/OLR+VdBGws7f/QaDcj2/be+jG/Y7fuTFz8JkXJsRYGfOB7V0JaYKH/
 TxD8UtjB114n/O16sqJOggtnsNJjetKLATGluLQ+/MDYHehtUEhS8BwtT0GMsBc80aFg
 can2Yt+oUifKD32jW0itMQq/RBgJjO29ePafAS3cyqO6pDqwe5eur0DrGGC0j86BzxY7
 ujxA==
X-Gm-Message-State: AC+VfDzR6+Z9qJgUz4I1AEChb8ynlrj0pJIvN6KBYfaa5g+4W5erMen6
 UavnE8Xx+3qMtBGeVNKbcmKu7yXIiSHvp39N/3A=
X-Google-Smtp-Source: ACHHUZ5E2M6xE/U1EtrMoq4EYYGmmjex2M1v7LY/1qfLsw6WPitxQS7S/9To2O1P78748cU+SofNvQ==
X-Received: by 2002:a05:6000:147:b0:30a:bf2b:e03b with SMTP id
 r7-20020a056000014700b0030abf2be03bmr2997799wrx.1.1686499245224; 
 Sun, 11 Jun 2023 09:00:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a056000008900b0030ae499da59sm9923022wrx.111.2023.06.11.09.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 09:00:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 20/23] target/arm: Convert LDAPR/STLR (imm) to decodetree
Date: Sun, 11 Jun 2023 17:00:29 +0100
Message-Id: <20230611160032.274823-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611160032.274823-1-peter.maydell@linaro.org>
References: <20230611160032.274823-1-peter.maydell@linaro.org>
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
index b4b029d0910..54383211006 100644
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
 
@@ -3371,88 +3361,60 @@ static bool trans_LDRA(DisasContext *s, arg_LDRA *a)
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
@@ -3981,8 +3943,6 @@ static void disas_ldst(DisasContext *s, uint32_t insn)
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


