Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DBA7206A5
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:55:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q574x-0003F3-Um; Fri, 02 Jun 2023 11:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574u-0003C4-Rt
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:36 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574q-0003TJ-MT
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:36 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-30ad752f433so2000685f8f.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685721151; x=1688313151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e6odzKrf0EsTUJUThJ0AIB19OGhJGnKfmzZWI8IgT24=;
 b=r8Wr9+RbJhw20nf7ATclpIL0Gv4Wtgp49boYgMyLiytE6Dhk8vuDV+QOdEhTG+rpCu
 QgeoNRybCczJJMzZMHhXXCk3WQw0q9HEhyDChs6mMJ3OfQwMUxXohRqTWy/sBHzx10SE
 diF5iFUxTnzLL64WsqeEbCaeYXLzN/yH8tY3Frjs74iguXvhYc+CDxdtDg4rasYFRrjY
 P3QU2a3w9Oi3qoNrZmkPUEMG6Bl9t+AUHqxbeUgIm4QtNJDqc0mRPwoh6V5uVQFuaVOz
 2o4FCIaj+rnHWKbdhM7EFWB6uGzQvS8YYuhkdGHRDJFWUyV2pFDC/suc20Nel5f2V71a
 SRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685721151; x=1688313151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e6odzKrf0EsTUJUThJ0AIB19OGhJGnKfmzZWI8IgT24=;
 b=hFXMyEvGd/nEDFYMl640g41Ec9XpqXQjcdWo0Ff1riLg1u98BSTnuxV6v0ExWzaDmT
 woV0ToskPlzq0IYu3fXa0+sH+7jMuthPHpt/9vI0v6zxpToLz2gENS30wFyxdsbO3Std
 E+LY6HouEuukewfIcqZuhuEgY7TV9PZlyxanmpTRHeeiQdthOe92GfEfN5E/s/qWjG6X
 qX9OpMxDz7jGff+kcvVAHOeXI240kllNipJMlSDk+mHWGxGNrMVQeaXWwYez77Ixc6RX
 p2D6xHmlJltsVwOoFCgC50boBpFbv7/7z6dYVMj1N/hZAJbsqprQm2gjMyu+X5tQJwme
 43Yw==
X-Gm-Message-State: AC+VfDxkgtQziuY8UPdLl5R5YcGPDc92V8Y59GSIQBB+bJ432yUf1+dq
 sXMyO9T/FW7SqFthLENXUA+IUSeLCRh9ZdB74Wo=
X-Google-Smtp-Source: ACHHUZ6p18PJm9xaRXLK2ocAM2xTFEdimhlDfK+kKQYYhZQ2U49ksWjpcr8CdKtMBV1a+Vm/mnfyIQ==
X-Received: by 2002:adf:e788:0:b0:30a:aeb0:910d with SMTP id
 n8-20020adfe788000000b0030aaeb0910dmr271530wrm.44.1685721151116; 
 Fri, 02 Jun 2023 08:52:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003f72a15301csm594952wml.2.2023.06.02.08.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 08:52:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 10/20] target/arm: Convert load reg (literal) group to
 decodetree
Date: Fri,  2 Jun 2023 16:52:13 +0100
Message-Id: <20230602155223.2040685-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602155223.2040685-1-peter.maydell@linaro.org>
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Convert the "Load register (literal)" instruction class to
decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      | 13 ++++++
 target/arm/tcg/translate-a64.c | 73 ++++++++++------------------------
 2 files changed, 33 insertions(+), 53 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 2b4827384b5..e24db340714 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -251,3 +251,16 @@ LDXP            1 . 001000 011 ..... . ..... ..... ..... @stxp # inc LDAXP
 CASP            0 . 001000 0 a:1 1 rs:5 lasr:1 11111 rn:5 rt:5 sz=%imm1_30_p2
 # CAS, CASA, CASAL, CASL
 CAS             sz:2 001000 1 a:1 1 rs:5 lasr:1 11111 rn:5 rt:5
+
+&ldlit          rt imm sz sign
+@ldlit          .. ... . .. ................... rt:5 &ldlit imm=%imm19
+
+LD_lit          00 011 0 00 ................... ..... @ldlit sz=2 sign=0
+LD_lit          01 011 0 00 ................... ..... @ldlit sz=3 sign=0
+LD_lit          10 011 0 00 ................... ..... @ldlit sz=2 sign=1
+LD_lit_v        00 011 1 00 ................... ..... @ldlit sz=2 sign=0
+LD_lit_v        01 011 1 00 ................... ..... @ldlit sz=3 sign=0
+LD_lit_v        10 011 1 00 ................... ..... @ldlit sz=4 sign=0
+
+# PRFM
+NOP             11 011 0 00 ------------------- -----
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ce4cf1a3878..07bcc700e0b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2711,60 +2711,30 @@ static bool trans_CAS(DisasContext *s, arg_CAS *a)
     return true;
 }
 
-/*
- * Load register (literal)
- *
- *  31 30 29   27  26 25 24 23                5 4     0
- * +-----+-------+---+-----+-------------------+-------+
- * | opc | 0 1 1 | V | 0 0 |     imm19         |  Rt   |
- * +-----+-------+---+-----+-------------------+-------+
- *
- * V: 1 -> vector (simd/fp)
- * opc (non-vector): 00 -> 32 bit, 01 -> 64 bit,
- *                   10-> 32 bit signed, 11 -> prefetch
- * opc (vector): 00 -> 32 bit, 01 -> 64 bit, 10 -> 128 bit (11 unallocated)
- */
-static void disas_ld_lit(DisasContext *s, uint32_t insn)
+static bool trans_LD_lit(DisasContext *s, arg_ldlit *a)
 {
-    int rt = extract32(insn, 0, 5);
-    int64_t imm = sextract32(insn, 5, 19) << 2;
-    bool is_vector = extract32(insn, 26, 1);
-    int opc = extract32(insn, 30, 2);
-    bool is_signed = false;
-    int size = 2;
-    TCGv_i64 tcg_rt, clean_addr;
+    bool iss_sf = ldst_iss_sf(a->sz, a->sign, false);
+    TCGv_i64 tcg_rt = cpu_reg(s, a->rt);
+    TCGv_i64 clean_addr = tcg_temp_new_i64();
 
-    if (is_vector) {
-        if (opc == 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        size = 2 + opc;
-        if (!fp_access_check(s)) {
-            return;
-        }
-    } else {
-        if (opc == 3) {
-            /* PRFM (literal) : prefetch */
-            return;
-        }
-        size = 2 + extract32(opc, 0, 1);
-        is_signed = extract32(opc, 1, 1);
+    gen_pc_plus_diff(s, clean_addr, a->imm);
+    do_gpr_ld(s, tcg_rt, clean_addr, a->sz + a->sign * MO_SIGN,
+              false, true, a->rt, iss_sf, false);
+    return true;
+}
+
+static bool trans_LD_lit_v(DisasContext *s, arg_ldlit *a)
+{
+    /* Load register (literal), vector version */
+    TCGv_i64 clean_addr;
+
+    if (!fp_access_check(s)) {
+        return true;
     }
-
-    tcg_rt = cpu_reg(s, rt);
-
     clean_addr = tcg_temp_new_i64();
-    gen_pc_plus_diff(s, clean_addr, imm);
-    if (is_vector) {
-        do_fp_ld(s, rt, clean_addr, size);
-    } else {
-        /* Only unsigned 32bit loads target 32bit registers.  */
-        bool iss_sf = opc != 0;
-
-        do_gpr_ld(s, tcg_rt, clean_addr, size + is_signed * MO_SIGN,
-                  false, true, rt, iss_sf, false);
-    }
+    gen_pc_plus_diff(s, clean_addr, a->imm);
+    do_fp_ld(s, a->rt, clean_addr, a->sz);
+    return true;
 }
 
 /*
@@ -4067,9 +4037,6 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
 static void disas_ldst(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 24, 6)) {
-    case 0x18: case 0x1c: /* Load register (literal) */
-        disas_ld_lit(s, insn);
-        break;
     case 0x28: case 0x29:
     case 0x2c: case 0x2d: /* Load/store pair (all forms) */
         disas_ldst_pair(s, insn);
-- 
2.34.1


