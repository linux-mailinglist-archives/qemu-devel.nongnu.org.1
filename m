Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C33728117
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:19:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWZ-0003Ml-PL; Thu, 08 Jun 2023 09:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6C-0002Hy-2u
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:36 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6A-0006U4-3c
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:35 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f505aace48so591904e87.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220952; x=1688812952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RoEURqNrSSd7deSyDoOGA4qzBi0iTzo/9sSniYj02l4=;
 b=sipVItxLIxGUeaJLMCWpD7cWTL5dO0QZw//Xg6G60bySnERBSVmuCJMT5erxCj/xsJ
 TT8V52lz9oI7fSxN6N/4SL+dISIhD8GZfjDa0Ub7LicaF73aW8VeDCf8t436Hqh0/MrC
 kHYHDoY5EwjU3lluvkjcP85l6L47VDpkbVFvTkRlX00jHuxroAWpVsujCs0eeCTWbhW8
 n8W3lPiQA0QLpkAxWhPtWHbqAKXqGH3IqRcMM9zw2yYObFwo/jNDQclgTnH9sjpEeEHO
 MNsDpYlJH/04MMz/wohX7wiKxVDAj7diCpBDm+2sv0oD31kujphCm25qqlCY5iv9jMoq
 BaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220952; x=1688812952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RoEURqNrSSd7deSyDoOGA4qzBi0iTzo/9sSniYj02l4=;
 b=E9++HjkWcXW/R8h/WMEkLouBluhpL2GBmgDT6THLft1/rqmLzoGDEItZSv3o1P+qdZ
 RH72uN0tckO2CZPHVWi6wWinldMX393aaEYtOv1OO4C2BTED2xM/X7wpz06HGrX0AXs8
 FiMDPSDY3y8s/5M3T+gG5MuhB036UY5pY1wEJJFoVw37BXzyfFBiugPZ1hVXdVC84NkN
 ZChWyJvSyOuNp77ABL6f/8oBTFFByYUebeI9VQIFeLh5pqK1g7P8LY5otGZ3kUwmDw5f
 ykIrIO2xy5wUdtiub367tNtmCSCO3SEwB6Z4MPb26wMI/Goohi7u50XnWPf9uUHIuUSh
 xbVg==
X-Gm-Message-State: AC+VfDzAgI4tR0Alp5wvvT3m91NYpm7oOaeblONp9J87Y0Q+KpRxSHx6
 tIdT8zCJCogxI7fRUhvQ4Lbv9lHpPvQ=
X-Google-Smtp-Source: ACHHUZ7m5llcrRrCmbGyCb4yTce2s8RHO3ervFMnoztA2Lh+RImx6sshx2KFTFZl3vhHaWuN2Qg2Hw==
X-Received: by 2002:a2e:7813:0:b0:2b1:c0d3:72cb with SMTP id
 t19-20020a2e7813000000b002b1c0d372cbmr3326465ljc.23.1686220952247; 
 Thu, 08 Jun 2023 03:42:32 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:31 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 07/33] target/mips: Add emulation of MXU S32SLT D16SLT
 D16AVG[R] Q8AVG[R] insns
Date: Thu,  8 Jun 2023 13:41:56 +0300
Message-Id: <20230608104222.1520143-8-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 08 Jun 2023 09:17:53 -0400
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

These instructions are part of pool1, see the grand tree above
in the file. Q8ADD is part of pool1 too but belong to another
category of instructions, thus will be made in later patches.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 244 +++++++++++++++++++++++++++++++-
 1 file changed, 243 insertions(+), 1 deletion(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 984d826c36..2c1d7f139e 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -360,6 +360,7 @@ enum {
     OPC_MXU__POOL00  = 0x03,
     OPC_MXU_S32MSUB  = 0x04,
     OPC_MXU_S32MSUBU = 0x05,
+    OPC_MXU__POOL01  = 0x06,
     OPC_MXU_D16MUL   = 0x08,
     OPC_MXU_D16MAC   = 0x0A,
     OPC_MXU__POOL04  = 0x10,
@@ -393,6 +394,18 @@ enum {
     OPC_MXU_Q8SLTU   = 0x07,
 };
 
+/*
+ * MXU pool 01
+ */
+enum {
+    OPC_MXU_S32SLT   = 0x00,
+    OPC_MXU_D16SLT   = 0x01,
+    OPC_MXU_D16AVG   = 0x02,
+    OPC_MXU_D16AVGR  = 0x03,
+    OPC_MXU_Q8AVG    = 0x04,
+    OPC_MXU_Q8AVGR   = 0x05,
+};
+
 /*
  * MXU pool 04 05 06 07 08 09 10 11
  */
@@ -1154,11 +1167,15 @@ static void gen_mxu_S32XOR(DisasContext *ctx)
 
 
 /*
- *                   MXU instruction category max/min
+ *                   MXU instruction category max/min/avg
  *                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  *                     S32MAX     D16MAX     Q8MAX
  *                     S32MIN     D16MIN     Q8MIN
+ *                     S32SLT     D16SLT     Q8SLT
+ *                                           Q8SLTU
+ *                                D16AVG     Q8AVG
+ *                                D16AVGR    Q8AVGR
  */
 
 /*
@@ -1464,6 +1481,199 @@ static void gen_mxu_q8slt(DisasContext *ctx, bool sltu)
     }
 }
 
+/*
+ *  S32SLT
+ *    Update XRa with the signed "set less than" comparison of XRb and XRc.
+ *    a.k.a. XRa = XRb < XRc ? 1 : 0;
+ */
+static void gen_mxu_S32SLT(DisasContext *ctx)
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
+    } else if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to zero */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+    } else if (unlikely(XRb == XRc)) {
+        /* both operands same registers -> just set destination to zero */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+    } else {
+        /* the most general case */
+        tcg_gen_setcond_tl(TCG_COND_LT, mxu_gpr[XRa - 1],
+                           mxu_gpr[XRb - 1], mxu_gpr[XRc - 1]);
+    }
+}
+
+/*
+ *  D16SLT
+ *    Update XRa with the signed "set less than" comparison of XRb and XRc
+ *    on per-word basis.
+ *    a.k.a. XRa[0..1] = XRb[0..1] < XRc[0..1] ? 1 : 0;
+ */
+static void gen_mxu_D16SLT(DisasContext *ctx)
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
+    } else if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to zero */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+    } else if (unlikely(XRb == XRc)) {
+        /* both operands same registers -> just set destination to zero */
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
+        tcg_gen_sextract_tl(t0, t3, 16, 16);
+        tcg_gen_sextract_tl(t1, t4, 16, 16);
+        tcg_gen_setcond_tl(TCG_COND_LT, t0, t0, t1);
+        tcg_gen_shli_tl(t2, t0, 16);
+        tcg_gen_sextract_tl(t0, t3,  0, 16);
+        tcg_gen_sextract_tl(t1, t4,  0, 16);
+        tcg_gen_setcond_tl(TCG_COND_LT, t0, t0, t1);
+        tcg_gen_or_tl(mxu_gpr[XRa - 1], t2, t0);
+    }
+}
+
+/*
+ *  D16AVG
+ *    Update XRa with the signed average of XRb and XRc
+ *    on per-word basis, rounding down.
+ *    a.k.a. XRa[0..1] = (XRb[0..1] + XRc[0..1]) >> 1;
+ *
+ *  D16AVGR
+ *    Update XRa with the signed average of XRb and XRc
+ *    on per-word basis, math rounding 4/5.
+ *    a.k.a. XRa[0..1] = (XRb[0..1] + XRc[0..1] + 1) >> 1;
+ */
+static void gen_mxu_d16avg(DisasContext *ctx, bool round45)
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
+    } else if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to zero */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+    } else if (unlikely(XRb == XRc)) {
+        /* both operands same registers -> just set destination to same */
+        tcg_gen_mov_tl(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
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
+        tcg_gen_sextract_tl(t0, t3, 16, 16);
+        tcg_gen_sextract_tl(t1, t4, 16, 16);
+        tcg_gen_add_tl(t0, t0, t1);
+        if (round45) {
+            tcg_gen_addi_tl(t0, t0, 1);
+        }
+        tcg_gen_shli_tl(t2, t0, 15);
+        tcg_gen_andi_tl(t2, t2, 0xffff0000);
+        tcg_gen_sextract_tl(t0, t3,  0, 16);
+        tcg_gen_sextract_tl(t1, t4,  0, 16);
+        tcg_gen_add_tl(t0, t0, t1);
+        if (round45) {
+            tcg_gen_addi_tl(t0, t0, 1);
+        }
+        tcg_gen_shri_tl(t0, t0, 1);
+        tcg_gen_deposit_tl(t2, t2, t0, 0, 16);
+        gen_store_mxu_gpr(t2, XRa);
+    }
+}
+
+/*
+ *  Q8AVG
+ *    Update XRa with the signed average of XRb and XRc
+ *    on per-byte basis, rounding down.
+ *    a.k.a. XRa[0..3] = (XRb[0..3] + XRc[0..3]) >> 1;
+ *
+ *  Q8AVGR
+ *    Update XRa with the signed average of XRb and XRc
+ *    on per-word basis, math rounding 4/5.
+ *    a.k.a. XRa[0..3] = (XRb[0..3] + XRc[0..3] + 1) >> 1;
+ */
+static void gen_mxu_q8avg(DisasContext *ctx, bool round45)
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
+    } else if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to zero */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+    } else if (unlikely(XRb == XRc)) {
+        /* both operands same registers -> just set destination to same */
+        tcg_gen_mov_tl(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
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
+            tcg_gen_add_tl(t0, t0, t1);
+            if (round45) {
+                tcg_gen_addi_tl(t0, t0, 1);
+            }
+            tcg_gen_shri_tl(t0, t0, 1);
+            tcg_gen_deposit_tl(t2, t2, t0, 8 * i, 8);
+        }
+        gen_store_mxu_gpr(t2, XRa);
+    }
+}
+
 
 /*
  *                 MXU instruction category: align
@@ -1771,6 +1981,35 @@ static bool decode_opc_mxu_s32madd_sub(DisasContext *ctx)
     return true;
 }
 
+static void decode_opc_mxu__pool01(DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 18, 3);
+
+    switch (opcode) {
+    case OPC_MXU_S32SLT:
+        gen_mxu_S32SLT(ctx);
+        break;
+    case OPC_MXU_D16SLT:
+        gen_mxu_D16SLT(ctx);
+        break;
+    case OPC_MXU_D16AVG:
+        gen_mxu_d16avg(ctx, false);
+        break;
+    case OPC_MXU_D16AVGR:
+        gen_mxu_d16avg(ctx, true);
+        break;
+    case OPC_MXU_Q8AVG:
+        gen_mxu_q8avg(ctx, false);
+        break;
+    case OPC_MXU_Q8AVGR:
+        gen_mxu_q8avg(ctx, true);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        gen_reserved_instruction(ctx);
+        break;
+    }
+}
 static void decode_opc_mxu__pool04(DisasContext *ctx)
 {
     uint32_t reversed = extract32(ctx->opcode, 20, 1);
@@ -2017,6 +2256,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU_D16MAC:
             gen_mxu_d16mac(ctx);
             break;
+        case OPC_MXU__POOL01:
+            decode_opc_mxu__pool01(ctx);
+            break;
         case OPC_MXU__POOL04:
             decode_opc_mxu__pool04(ctx);
             break;
-- 
2.40.0


