Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1480C9EB607
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Dec 2024 17:20:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2xL-0003Lt-Ga; Tue, 10 Dec 2024 11:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2ww-0002vE-Dt
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:05 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2wq-0006RN-Ml
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:18:58 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-30036310158so33201371fa.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847535; x=1734452335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TmvLC72KaZzM8jiapnL2kS3QqFWjexV3Z72ZJbn8iE0=;
 b=PFrFgZWsBmXk00eXOG/Qm813OsJFWkwgVAOWUo7VJP4qMF4Cb7ea9Fs4IqKw/GiIZ6
 QGpGel/n9Gieqr+w1i8gab6xxWcz3JFOUWy2yE2HhuaGjx0rBcslNWhJE+lhxuNu4Ztn
 MHB3Z6vO/x9C3JOZO8DxlMXtlaVAGzy7JVvsIscrLphfCXgSB4WCiwvNRAcoKmbs7d92
 gO2xfqMaTTHVHPOPv75dMyHm74+Ij39Qz20nJe+pwMocSP735+K9ctk7KkDGlE4dKTKq
 Lm0RoOcoQrY8t3k0/Xdcv9oBRGp/ecF+gTPy2H0ZpMrtDJBlwz45ozHpK5uiWs7yJOPS
 rdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847535; x=1734452335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TmvLC72KaZzM8jiapnL2kS3QqFWjexV3Z72ZJbn8iE0=;
 b=YC9r4m3pfhnYR8Nuh3LXHxp57Yzy/HTK7Lk/57UsYDhO+H3+wgq3biyN7XPKmcW6ZS
 rZtROnS4ecaxnBKxEqPZn1DKFeCV+FxNHc/JUyFk5ivnmAYBUNgMxSqN8JVJRHHeeMe7
 W+FwCWfCIdlsVxO44yvqEKKq6rl3P/f1Pss32phntbOskEoZp2WVSfpBdL6Pl4Dg2jCa
 eYn1Ba7UrE8/ekKaGWFa3lcMubTfMoiq5wM8nKu3QwduR0472Uln9XfDCbP5aWKVCu/q
 9Tpi2Q1zs3DwWWRMFEqB0XXwCIBQgPIJD6L8asxNiKELnBOzehmoJo3Ztcs25luv736i
 U8OA==
X-Gm-Message-State: AOJu0YyfzT+lgHTmFvkzITfx1m2HlfzKLhtxvOpYZElQS53DQB0BDcWB
 X+nfq8GI9/etDRCfuZ1hOZzyMgXRMTbZtEWza4ir8PMNrOVv9Y+DRlP9bsC5JOPTQYWcevVG66n
 Z19gdjgOr
X-Gm-Gg: ASbGnctwbcdZIqwmDO+F6TgqMFITrz9ukC/noIoz9qilOV9uQo4hAtSjnLwlZqJ4lex
 mPX8CNZSzhrNfAQ5vuOF47gzSVJdck1feHqnTEuxWg2tloJYMz6l7yT6/0Aznax/gMTtRuQOU2Z
 RL2stgv7/0p8nU67pzgVYf5L6fBH1shodPrdsxA9NnohO67y4X+slxfjzhJMB7TA9L52jSenZLj
 RrQ1Vp54HvhC1dMzbKF/Uu8ZV1knD2FeIRLT+37+R+9WH8T/XCCwLE5DqU=
X-Google-Smtp-Source: AGHT+IFp0sJhBMVbITwyfkZjsSndbjZ7gAj49iRmwx0k0Fu2tiumsMssufvFvUQLhskY5OmdJ7MRYQ==
X-Received: by 2002:a05:6512:33d0:b0:540:2339:376c with SMTP id
 2adb3069b0e04-540233937f2mr2174468e87.27.1733847534920; 
 Tue, 10 Dec 2024 08:18:54 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:18:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 18/69] target/arm: Convert CCMP, CCMN to decodetree
Date: Tue, 10 Dec 2024 10:16:42 -0600
Message-ID: <20241210161733.1830573-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 66 +++++++++++-----------------------
 target/arm/tcg/a64.decode      |  6 ++--
 2 files changed, 25 insertions(+), 47 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 774689641d..56a445a3c2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8092,68 +8092,46 @@ static bool do_setf(DisasContext *s, int rn, int shift)
 TRANS_FEAT(SETF8, aa64_condm_4, do_setf, a->rn, 24)
 TRANS_FEAT(SETF16, aa64_condm_4, do_setf, a->rn, 16)
 
-/* Conditional compare (immediate / register)
- *  31 30 29 28 27 26 25 24 23 22 21  20    16 15  12  11  10  9   5  4 3   0
- * +--+--+--+------------------------+--------+------+----+--+------+--+-----+
- * |sf|op| S| 1  1  0  1  0  0  1  0 |imm5/rm | cond |i/r |o2|  Rn  |o3|nzcv |
- * +--+--+--+------------------------+--------+------+----+--+------+--+-----+
- *        [1]                             y                [0]       [0]
- */
-static void disas_cc(DisasContext *s, uint32_t insn)
+/* CCMP, CCMN */
+static bool trans_CCMP(DisasContext *s, arg_CCMP *a)
 {
-    unsigned int sf, op, y, cond, rn, nzcv, is_imm;
-    TCGv_i32 tcg_t0, tcg_t1, tcg_t2;
-    TCGv_i64 tcg_tmp, tcg_y, tcg_rn;
+    TCGv_i32 tcg_t0 = tcg_temp_new_i32();
+    TCGv_i32 tcg_t1 = tcg_temp_new_i32();
+    TCGv_i32 tcg_t2 = tcg_temp_new_i32();
+    TCGv_i64 tcg_tmp = tcg_temp_new_i64();
+    TCGv_i64 tcg_rn, tcg_y;
     DisasCompare c;
-
-    if (!extract32(insn, 29, 1)) {
-        unallocated_encoding(s);
-        return;
-    }
-    if (insn & (1 << 10 | 1 << 4)) {
-        unallocated_encoding(s);
-        return;
-    }
-    sf = extract32(insn, 31, 1);
-    op = extract32(insn, 30, 1);
-    is_imm = extract32(insn, 11, 1);
-    y = extract32(insn, 16, 5); /* y = rm (reg) or imm5 (imm) */
-    cond = extract32(insn, 12, 4);
-    rn = extract32(insn, 5, 5);
-    nzcv = extract32(insn, 0, 4);
+    unsigned nzcv;
 
     /* Set T0 = !COND.  */
-    tcg_t0 = tcg_temp_new_i32();
-    arm_test_cc(&c, cond);
+    arm_test_cc(&c, a->cond);
     tcg_gen_setcondi_i32(tcg_invert_cond(c.cond), tcg_t0, c.value, 0);
 
     /* Load the arguments for the new comparison.  */
-    if (is_imm) {
-        tcg_y = tcg_temp_new_i64();
-        tcg_gen_movi_i64(tcg_y, y);
+    if (a->imm) {
+        tcg_y = tcg_constant_i64(a->y);
     } else {
-        tcg_y = cpu_reg(s, y);
+        tcg_y = cpu_reg(s, a->y);
     }
-    tcg_rn = cpu_reg(s, rn);
+    tcg_rn = cpu_reg(s, a->rn);
 
     /* Set the flags for the new comparison.  */
-    tcg_tmp = tcg_temp_new_i64();
-    if (op) {
-        gen_sub_CC(sf, tcg_tmp, tcg_rn, tcg_y);
+    if (a->op) {
+        gen_sub_CC(a->sf, tcg_tmp, tcg_rn, tcg_y);
     } else {
-        gen_add_CC(sf, tcg_tmp, tcg_rn, tcg_y);
+        gen_add_CC(a->sf, tcg_tmp, tcg_rn, tcg_y);
     }
 
-    /* If COND was false, force the flags to #nzcv.  Compute two masks
+    /*
+     * If COND was false, force the flags to #nzcv.  Compute two masks
      * to help with this: T1 = (COND ? 0 : -1), T2 = (COND ? -1 : 0).
      * For tcg hosts that support ANDC, we can make do with just T1.
      * In either case, allow the tcg optimizer to delete any unused mask.
      */
-    tcg_t1 = tcg_temp_new_i32();
-    tcg_t2 = tcg_temp_new_i32();
     tcg_gen_neg_i32(tcg_t1, tcg_t0);
     tcg_gen_subi_i32(tcg_t2, tcg_t0, 1);
 
+    nzcv = a->nzcv;
     if (nzcv & 8) { /* N */
         tcg_gen_or_i32(cpu_NF, cpu_NF, tcg_t1);
     } else {
@@ -8190,6 +8168,7 @@ static void disas_cc(DisasContext *s, uint32_t insn)
             tcg_gen_and_i32(cpu_VF, cpu_VF, tcg_t2);
         }
     }
+    return true;
 }
 
 /* Conditional select
@@ -8266,10 +8245,6 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
     }
 
     switch (op2) {
-    case 0x2: /* Conditional compare */
-        disas_cc(s, insn); /* both imm and reg forms */
-        break;
-
     case 0x4: /* Conditional select */
         disas_cond_select(s, insn);
         break;
@@ -8277,6 +8252,7 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
     default:
     do_unallocated:
     case 0x0:
+    case 0x2: /* Conditional compare */
     case 0x6: /* Data-processing */
     case 0x8 ... 0xf: /* (3 source) */
         unallocated_encoding(s);
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index ae2c6831d7..a9d7d57199 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -761,8 +761,10 @@ RMIF            1 01 11010000 imm:6 00001 rn:5 0 mask:4
 SETF8           0 01 11010000 00000 000010 rn:5 01101
 SETF16          0 01 11010000 00000 010010 rn:5 01101
 
-# Conditional compare (regster)
-# Conditional compare (immediate)
+# Conditional compare
+
+CCMP            sf:1 op:1 1 11010010 y:5 cond:4 imm:1 0 rn:5 0 nzcv:4
+
 # Conditional select
 # Data Processing (3-source)
 
-- 
2.43.0


