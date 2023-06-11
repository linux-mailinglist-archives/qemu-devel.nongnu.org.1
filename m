Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E0A72B2C3
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 18:05:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8NVc-0006SA-H9; Sun, 11 Jun 2023 12:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUm-0005u1-M7
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:52 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUh-0000Tc-JJ
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:48 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f7f4819256so25411035e9.1
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686499241; x=1689091241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zon/L+1E7pApwo5q3JdDpEUBgb4onUwkVEYPmbfuPTc=;
 b=CGcl4O4q1QVCU27e1WrwojCYtLjCGvcxo1eL1svsBWC8+dzEqU3ffqCzvTQPuHId1M
 fXv9zgyTON6h3+SEJBVk8BS6IcXN/u7QTXGw2I3zIm502zD+0LsdplJuu6DzGyYecMKw
 /h/lNqhZRtqTDIDFcZoCcmuPnjOFxXItbF3SHqqUc9VDvZD3OGkgjDLFK0BbbhJdsvor
 hMvKlbhtPTVa5Ny+JPQ5oOjTX4t8g5WrEScMccV6HQemFhwXVA5reyH2IgB3YIPVlB4v
 V/Fs48wwg/mhwotTqgtzwz+CxG+o/Q5Tl4nk3VWqODSuv47xZDSqnNQ6SPvMOI9aqQF3
 xykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686499241; x=1689091241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zon/L+1E7pApwo5q3JdDpEUBgb4onUwkVEYPmbfuPTc=;
 b=E4MBg5Tkk2dywaHgOSs9uMvvJyKCyxK2pFk4/u0Plgkd6HWTe2nQqjL8s+pxNwlGCr
 HnbAp6zFG3E+qzbrcW20tLPlDU3pxvX8w8+nsTi/Bf64BbGohuzNqgIv/lA26F2fVITF
 gGup7Kkh40rw5uJNPDKEJzHhLnIrLlPcZbFXRa+QxBtPB1tLg4aaPlqgOzWzRbgrvojb
 ENKJXX9mDlDWWwFnyC/D5OQZP1zHgqSBsLUOOvgH7raBz2rm+K8E/uaYuen/gH8hbNCy
 LG3PnUzhAiKOcwpY+mpb18D/aZF5zfsbHhWt0ZHJpM6k6AjD74OsqrUmtgRFzGw50I+e
 xzhQ==
X-Gm-Message-State: AC+VfDzYwrXlGClINyjdRa675piJkHUjqFse2Jj3W66Nk/mmYYYFhWLx
 T8uJuAlcGFnHD57X0f3wfiBJx2OkZjSbU6Shn6k=
X-Google-Smtp-Source: ACHHUZ64yRwLQyn9v7eIJzI5bcTUBD0TRPFGuXBqyJHCyaALWwLWbAZdsFDTYIvBeh6Qt+OdfYcclw==
X-Received: by 2002:adf:fac9:0:b0:30a:b4e1:a89b with SMTP id
 a9-20020adffac9000000b0030ab4e1a89bmr3151898wrs.67.1686499241004; 
 Sun, 11 Jun 2023 09:00:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a056000008900b0030ae499da59sm9923022wrx.111.2023.06.11.09.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 09:00:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 13/23] target/arm: Convert load reg (literal) group to
 decodetree
Date: Sun, 11 Jun 2023 17:00:22 +0100
Message-Id: <20230611160032.274823-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611160032.274823-1-peter.maydell@linaro.org>
References: <20230611160032.274823-1-peter.maydell@linaro.org>
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

Convert the "Load register (literal)" instruction class to
decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230602155223.2040685-11-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      | 13 ++++++
 target/arm/tcg/translate-a64.c | 76 ++++++++++------------------------
 2 files changed, 35 insertions(+), 54 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 6b1079b8bdf..c2c6ac0196d 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -252,3 +252,16 @@ LDXP            1 . 001000 011 ..... . ..... ..... ..... @stxp # inc LDAXP
 CASP            0 . 001000 0 - 1 rs:5 - 11111 rn:5 rt:5 sz=%imm1_30_p2
 # CAS, CASA, CASAL, CASL
 CAS             sz:2 001000 1 - 1 rs:5 - 11111 rn:5 rt:5
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
index ff4338ee4df..d1df41f2e5e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2787,62 +2787,33 @@ static bool trans_CAS(DisasContext *s, arg_CAS *a)
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
+    MemOp memop = finalize_memop(s, a->sz + a->sign * MO_SIGN);
+
+    gen_pc_plus_diff(s, clean_addr, a->imm);
+    do_gpr_ld(s, tcg_rt, clean_addr, memop,
+              false, true, a->rt, iss_sf, false);
+    return true;
+}
+
+static bool trans_LD_lit_v(DisasContext *s, arg_ldlit *a)
+{
+    /* Load register (literal), vector version */
+    TCGv_i64 clean_addr;
     MemOp memop;
 
-    if (is_vector) {
-        if (opc == 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        size = 2 + opc;
-        if (!fp_access_check(s)) {
-            return;
-        }
-        memop = finalize_memop_asimd(s, size);
-    } else {
-        if (opc == 3) {
-            /* PRFM (literal) : prefetch */
-            return;
-        }
-        size = 2 + extract32(opc, 0, 1);
-        is_signed = extract32(opc, 1, 1);
-        memop = finalize_memop(s, size + is_signed * MO_SIGN);
+    if (!fp_access_check(s)) {
+        return true;
     }
-
-    tcg_rt = cpu_reg(s, rt);
-
+    memop = finalize_memop_asimd(s, a->sz);
     clean_addr = tcg_temp_new_i64();
-    gen_pc_plus_diff(s, clean_addr, imm);
-
-    if (is_vector) {
-        do_fp_ld(s, rt, clean_addr, memop);
-    } else {
-        /* Only unsigned 32bit loads target 32bit registers.  */
-        bool iss_sf = opc != 0;
-        do_gpr_ld(s, tcg_rt, clean_addr, memop, false, true, rt, iss_sf, false);
-    }
+    gen_pc_plus_diff(s, clean_addr, a->imm);
+    do_fp_ld(s, a->rt, clean_addr, memop);
+    return true;
 }
 
 /*
@@ -4213,9 +4184,6 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
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


