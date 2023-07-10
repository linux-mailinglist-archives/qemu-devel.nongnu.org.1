Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2897E74E113
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:29:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzLq-0003qp-T2; Mon, 10 Jul 2023 18:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLp-0003qd-CS
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:25 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLm-0001nS-9e
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:24 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3142970df44so4841755f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028040; x=1691620040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RtTL5bQ25A6n7tfhgT5171sR9zV7gwztAuSP4914Akw=;
 b=esYikflRpF0k3Wpw2ornQWqHUx/vXyZvat4PSsLj5XUhJhhqDr7xsNX0owkHFMwPrD
 UX1NjL788EBi+At98Pkz98xnhticsvsi00zkQXPO6BZ9sBzcdHk91Z056rilkc8gWl2R
 LlgmxBxNbgd+oGVChmeIyGWHjeZhK7M3euqdorztwkkTqW4Fl4hR5bgNm2PEkOK2bx6D
 mEj0x7WzMHY0tRik28tQR6vGm54Hf3U3LpPI98tNBiX/hy3N262y8k4s2rqYpZx6VrAY
 r/gP2l3UNQwedEGrY0/RG83Re2gRJP3NxscjlfjN7UenSo/UXqXxTXFXSQ5CJUbsmKIx
 69yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028040; x=1691620040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RtTL5bQ25A6n7tfhgT5171sR9zV7gwztAuSP4914Akw=;
 b=EYRN6zwyzRfWYFV7Uj/g1g01bm9MH/vmrjGq0yg5nMpWJaYsWwWFBfOx+iiNhU//Ae
 q9iyQTOjVH6UfK3WZExYBNST/MeIIVZmz23UKdNaWhFx6rwgDcn7ibX80khf7KM+eulC
 hYtY6PglZ/mc7ThhoJw7i/Vr6bfUVf3s9AMECHToYcBYqlOV/GPtShRItCXf+NU27fxb
 mWj7sxW9H0KfQCC4kG+ddsMDZX4dOB/LeSSQQdsD9WpB4xvgwiVQEiJ8NMkWdiIhwUja
 HGOnA0YQbRtGQ4v/AQsjzmsg37je28lEnAdHVlpBR8HNph7KtVdJOR7hvoiwAVRW17mN
 hugw==
X-Gm-Message-State: ABy/qLY/q+gu5mIjVjuVimsfFLYCQHTg1wyHtHn1f7KpgDz5ddUH8AVC
 li1Lgg3rDxug1k20ZxVUQJhkNrva549hvtvFuft1dA==
X-Google-Smtp-Source: APBJJlEEu4ooYbg6qv4nHf0WHCzHEWAR66vLp2ytDVSBTFK6ivuISWoEutFTyyrRSd5dHcmmiCvbSw==
X-Received: by 2002:adf:e803:0:b0:314:11ea:480d with SMTP id
 o3-20020adfe803000000b0031411ea480dmr12073700wrm.9.1689028040581; 
 Mon, 10 Jul 2023 15:27:20 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 q13-20020a05600000cd00b00314367cf43asm506633wrx.106.2023.07.10.15.27.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:27:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 12/44] target/mips/mxu: Add S32CPS D16CPS Q8ABD Q16SAT insns
Date: Tue, 11 Jul 2023 00:25:39 +0200
Message-Id: <20230710222611.50978-13-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Siarhei Volkau <lis8215@gmail.com>

These instructions are part of pool2, see the grand tree above
in the file.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-10-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 296 +++++++++++++++++++++++++++++++-
 1 file changed, 293 insertions(+), 3 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 034287e54b..3bd5fcb98a 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -359,6 +359,7 @@ enum {
     OPC_MXU_S32MSUB  = 0x04,
     OPC_MXU_S32MSUBU = 0x05,
     OPC_MXU__POOL01  = 0x06,
+    OPC_MXU__POOL02  = 0x07,
     OPC_MXU_D16MUL   = 0x08,
     OPC_MXU_D16MAC   = 0x0A,
     OPC_MXU__POOL04  = 0x10,
@@ -405,6 +406,16 @@ enum {
     OPC_MXU_Q8ADD    = 0x07,
 };
 
+/*
+ * MXU pool 02
+ */
+enum {
+    OPC_MXU_S32CPS   = 0x00,
+    OPC_MXU_D16CPS   = 0x02,
+    OPC_MXU_Q8ABD    = 0x04,
+    OPC_MXU_Q16SAT   = 0x06,
+};
+
 /*
  * MXU pool 04 05 06 07 08 09 10 11
  */
@@ -1675,12 +1686,155 @@ static void gen_mxu_q8avg(DisasContext *ctx, bool round45)
 
 
 /*
- *                 MXU instruction category: Arithmetic
- *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *      MXU instruction category: Addition and subtraction
+ *      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
- *                       Q8ADD
+ *              S32CPS      D16CPS
+ *                                       Q8ADD
  */
 
+/*
+ *  S32CPS
+ *    Update XRa if XRc < 0 by value of 0 - XRb
+ *    else XRa = XRb
+ */
+static void gen_mxu_S32CPS(DisasContext *ctx)
+{
+    uint32_t pad, XRc, XRb, XRa;
+
+    pad = extract32(ctx->opcode, 21, 5);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRa = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely(XRb == 0)) {
+        /* XRc make no sense 0 - 0 = 0 -> just set destination to zero */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+    } else if (unlikely(XRc == 0)) {
+        /* condition always false -> just move XRb to XRa */
+        tcg_gen_mov_tl(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+    } else {
+        /* the most general case */
+        TCGv t0 = tcg_temp_new();
+        TCGLabel *l_not_less = gen_new_label();
+        TCGLabel *l_done = gen_new_label();
+
+        tcg_gen_brcondi_tl(TCG_COND_GE, mxu_gpr[XRc - 1], 0, l_not_less);
+        tcg_gen_neg_tl(t0, mxu_gpr[XRb - 1]);
+        tcg_gen_br(l_done);
+        gen_set_label(l_not_less);
+        gen_load_mxu_gpr(t0, XRb);
+        gen_set_label(l_done);
+        gen_store_mxu_gpr(t0, XRa);
+    }
+}
+
+/*
+ *  D16CPS
+ *    Update XRa[0..1] if XRc[0..1] < 0 by value of 0 - XRb[0..1]
+ *    else XRa[0..1] = XRb[0..1]
+ */
+static void gen_mxu_D16CPS(DisasContext *ctx)
+{
+    uint32_t pad, XRc, XRb, XRa;
+
+    pad = extract32(ctx->opcode, 21, 5);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRa = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely(XRb == 0)) {
+        /* XRc make no sense 0 - 0 = 0 -> just set destination to zero */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+    } else if (unlikely(XRc == 0)) {
+        /* condition always false -> just move XRb to XRa */
+        tcg_gen_mov_tl(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+    } else {
+        /* the most general case */
+        TCGv t0 = tcg_temp_new();
+        TCGv t1 = tcg_temp_new();
+        TCGLabel *l_done_hi = gen_new_label();
+        TCGLabel *l_not_less_lo = gen_new_label();
+        TCGLabel *l_done_lo = gen_new_label();
+
+        tcg_gen_sextract_tl(t0, mxu_gpr[XRc - 1], 16, 16);
+        tcg_gen_sextract_tl(t1, mxu_gpr[XRb - 1], 16, 16);
+        tcg_gen_brcondi_tl(TCG_COND_GE, t0, 0, l_done_hi);
+        tcg_gen_subfi_tl(t1, 0, t1);
+
+        gen_set_label(l_done_hi);
+        tcg_gen_shli_i32(t1, t1, 16);
+
+        tcg_gen_sextract_tl(t0, mxu_gpr[XRc - 1],  0, 16);
+        tcg_gen_brcondi_tl(TCG_COND_GE, t0, 0, l_not_less_lo);
+        tcg_gen_sextract_tl(t0, mxu_gpr[XRb - 1],  0, 16);
+        tcg_gen_subfi_tl(t0, 0, t0);
+        tcg_gen_br(l_done_lo);
+
+        gen_set_label(l_not_less_lo);
+        tcg_gen_extract_tl(t0, mxu_gpr[XRb - 1],  0, 16);
+
+        gen_set_label(l_done_lo);
+        tcg_gen_deposit_tl(mxu_gpr[XRa - 1], t1, t0, 0, 16);
+    }
+}
+
+/*
+ *  Q8ABD XRa, XRb, XRc
+ *  Gets absolute difference for quadruple of 8-bit
+ *  packed in XRb to another one in XRc,
+ *  put the result in XRa.
+ *  a.k.a. XRa[0..3] = abs(XRb[0..3] - XRc[0..3]);
+ */
+static void gen_mxu_Q8ABD(DisasContext *ctx)
+{
+    uint32_t pad, XRc, XRb, XRa;
+
+    pad = extract32(ctx->opcode, 21, 3);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRa = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to zero */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+    } else {
+        /* the most general case */
+        TCGv t0 = tcg_temp_new();
+        TCGv t1 = tcg_temp_new();
+        TCGv t2 = tcg_temp_new();
+        TCGv t3 = tcg_temp_new();
+        TCGv t4 = tcg_temp_new();
+
+        gen_load_mxu_gpr(t3, XRb);
+        gen_load_mxu_gpr(t4, XRc);
+        tcg_gen_movi_tl(t2, 0);
+
+        for (int i = 0; i < 4; i++) {
+            tcg_gen_extract_tl(t0, t3, 8 * i, 8);
+            tcg_gen_extract_tl(t1, t4, 8 * i, 8);
+
+            tcg_gen_sub_tl(t0, t0, t1);
+            tcg_gen_abs_tl(t0, t0);
+
+            tcg_gen_deposit_tl(t2, t2, t0, 8 * i, 8);
+        }
+        gen_store_mxu_gpr(t2, XRa);
+    }
+}
+
 /*
  *  Q8ADD XRa, XRb, XRc, ptn2
  *  Add/subtract quadruple of 8-bit packed in XRb
@@ -1746,6 +1900,114 @@ static void gen_mxu_Q8ADD(DisasContext *ctx)
     }
 }
 
+/*
+ *                 MXU instruction category: Miscellaneous
+ *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *                       Q16SAT
+ */
+
+/*
+ *  Q16SAT XRa, XRb, XRc
+ *  Packs four 16-bit signed integers in XRb and XRc to
+ *  four saturated unsigned 8-bit into XRa.
+ *
+ */
+static void gen_mxu_Q16SAT(DisasContext *ctx)
+{
+    uint32_t pad, XRc, XRb, XRa;
+
+    pad = extract32(ctx->opcode, 21, 3);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRa = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else {
+        /* the most general case */
+        TCGv t0 = tcg_temp_new();
+        TCGv t1 = tcg_temp_new();
+        TCGv t2 = tcg_temp_new();
+
+        tcg_gen_movi_tl(t2, 0);
+        if (XRb != 0) {
+            TCGLabel *l_less_hi = gen_new_label();
+            TCGLabel *l_less_lo = gen_new_label();
+            TCGLabel *l_lo = gen_new_label();
+            TCGLabel *l_greater_hi = gen_new_label();
+            TCGLabel *l_greater_lo = gen_new_label();
+            TCGLabel *l_done = gen_new_label();
+
+            tcg_gen_sari_tl(t0, mxu_gpr[XRb - 1], 16);
+            tcg_gen_brcondi_tl(TCG_COND_LT, t0, 0, l_less_hi);
+            tcg_gen_brcondi_tl(TCG_COND_GT, t0, 255, l_greater_hi);
+            tcg_gen_br(l_lo);
+            gen_set_label(l_less_hi);
+            tcg_gen_movi_tl(t0, 0);
+            tcg_gen_br(l_lo);
+            gen_set_label(l_greater_hi);
+            tcg_gen_movi_tl(t0, 255);
+
+            gen_set_label(l_lo);
+            tcg_gen_shli_tl(t1, mxu_gpr[XRb - 1], 16);
+            tcg_gen_sari_tl(t1, t1, 16);
+            tcg_gen_brcondi_tl(TCG_COND_LT, t1, 0, l_less_lo);
+            tcg_gen_brcondi_tl(TCG_COND_GT, t1, 255, l_greater_lo);
+            tcg_gen_br(l_done);
+            gen_set_label(l_less_lo);
+            tcg_gen_movi_tl(t1, 0);
+            tcg_gen_br(l_done);
+            gen_set_label(l_greater_lo);
+            tcg_gen_movi_tl(t1, 255);
+
+            gen_set_label(l_done);
+            tcg_gen_shli_tl(t2, t0, 24);
+            tcg_gen_shli_tl(t1, t1, 16);
+            tcg_gen_or_tl(t2, t2, t1);
+        }
+
+        if (XRc != 0) {
+            TCGLabel *l_less_hi = gen_new_label();
+            TCGLabel *l_less_lo = gen_new_label();
+            TCGLabel *l_lo = gen_new_label();
+            TCGLabel *l_greater_hi = gen_new_label();
+            TCGLabel *l_greater_lo = gen_new_label();
+            TCGLabel *l_done = gen_new_label();
+
+            tcg_gen_sari_tl(t0, mxu_gpr[XRc - 1], 16);
+            tcg_gen_brcondi_tl(TCG_COND_LT, t0, 0, l_less_hi);
+            tcg_gen_brcondi_tl(TCG_COND_GT, t0, 255, l_greater_hi);
+            tcg_gen_br(l_lo);
+            gen_set_label(l_less_hi);
+            tcg_gen_movi_tl(t0, 0);
+            tcg_gen_br(l_lo);
+            gen_set_label(l_greater_hi);
+            tcg_gen_movi_tl(t0, 255);
+
+            gen_set_label(l_lo);
+            tcg_gen_shli_tl(t1, mxu_gpr[XRc - 1], 16);
+            tcg_gen_sari_tl(t1, t1, 16);
+            tcg_gen_brcondi_tl(TCG_COND_LT, t1, 0, l_less_lo);
+            tcg_gen_brcondi_tl(TCG_COND_GT, t1, 255, l_greater_lo);
+            tcg_gen_br(l_done);
+            gen_set_label(l_less_lo);
+            tcg_gen_movi_tl(t1, 0);
+            tcg_gen_br(l_done);
+            gen_set_label(l_greater_lo);
+            tcg_gen_movi_tl(t1, 255);
+
+            gen_set_label(l_done);
+            tcg_gen_shli_tl(t0, t0, 8);
+            tcg_gen_or_tl(t2, t2, t0);
+            tcg_gen_or_tl(t2, t2, t1);
+        }
+        gen_store_mxu_gpr(t2, XRa);
+    }
+}
+
 
 /*
  *                 MXU instruction category: align
@@ -2085,6 +2347,31 @@ static void decode_opc_mxu__pool01(DisasContext *ctx)
         break;
     }
 }
+
+static void decode_opc_mxu__pool02(DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 18, 3);
+
+    switch (opcode) {
+    case OPC_MXU_S32CPS:
+        gen_mxu_S32CPS(ctx);
+        break;
+    case OPC_MXU_D16CPS:
+        gen_mxu_D16CPS(ctx);
+        break;
+    case OPC_MXU_Q8ABD:
+        gen_mxu_Q8ABD(ctx);
+        break;
+    case OPC_MXU_Q16SAT:
+        gen_mxu_Q16SAT(ctx);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        gen_reserved_instruction(ctx);
+        break;
+    }
+}
+
 static void decode_opc_mxu__pool04(DisasContext *ctx)
 {
     uint32_t reversed = extract32(ctx->opcode, 20, 1);
@@ -2334,6 +2621,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU__POOL01:
             decode_opc_mxu__pool01(ctx);
             break;
+        case OPC_MXU__POOL02:
+            decode_opc_mxu__pool02(ctx);
+            break;
         case OPC_MXU__POOL04:
             decode_opc_mxu__pool04(ctx);
             break;
-- 
2.38.1


