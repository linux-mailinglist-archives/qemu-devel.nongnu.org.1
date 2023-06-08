Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5DC72811A
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:19:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWg-0003Nb-MH; Thu, 08 Jun 2023 09:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6F-0002Is-Kg
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:39 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6C-0006Ur-Gk
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:38 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f61735676fso559177e87.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220954; x=1688812954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AI+7AqSnoQezfqx21rFzO/758w7Rg9rRRO4yk1jYXRY=;
 b=MgVXJDM+UNjtgU3KR2ydqu0X/J5fK9s6FK90Cu7W7jV6gy3yDRmFODRGM4UVE0ezk8
 CNPDsK31y+1okYNp3hYHXA22sH1omlqixpJbUP3gcoGQrfTMhNcO7v3aqqnz1eg0e5e/
 EdIhFdv6aisIAT1QA9IClgXlIqI359Yq25KDCkNlfnx/fBD0YYa69GYSHOcF0qVO0zdC
 jq59NTruP9S4Chwd/MEq9I4tCSvfte1Q2buQ+JQbFv27uKXMs7TPeQLD5s3HmAHeGKR0
 +PGw5JkQ2jnsheolGWix1nHgbIreyAkBdyJFabEay69u/igVpgYKDBgiU503LKWYWXxh
 r/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220954; x=1688812954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AI+7AqSnoQezfqx21rFzO/758w7Rg9rRRO4yk1jYXRY=;
 b=i1cdnwqpdJKZ4PGcGnwK/sY+nOjmKm7Vi0v4yuEzk67ZDTvagFXqpgAzVtc+mm4iT9
 PjwU1GHzMRAHxt6Slrn484Je2DB/JJlQts7LxDFlJcrfs/0k/NoNWxtyS1w0ewkrk6+A
 msJ2BRBSPXnIU8RhIIOKYG0hsDx50KyKsearHK0eYS5zl7yhcOpUQ0qfMBbcPOL1EfnJ
 pgVxvIcSQH9AeJOiuiRoOjklTvgPakH0pcZJvAd13M6jSOwleP2KU4xE5KNabHR4A/U6
 ObG1t8S1gbHdlyBeCH8AUuYkkzwF03Xqy5zeKnbhQxTYPsRuwGlQzdXvRWvWV1WXXCSj
 832A==
X-Gm-Message-State: AC+VfDx6SyRou8aG/IwXUl1xkYK/f6NJsxczidG9BIN152Ylx9quhDGH
 iU8xnIWGqkBPXp5piyNkxE+qpxw+P6M=
X-Google-Smtp-Source: ACHHUZ5EoqxCgbSE+64ssjM/N+BM8UDj+5gXheqxS00pG3gzZmTn47QHgPG1MhzlgSefOSw2C8wkjg==
X-Received: by 2002:ac2:4825:0:b0:4f3:a99c:fbbe with SMTP id
 5-20020ac24825000000b004f3a99cfbbemr3180649lft.14.1686220954335; 
 Thu, 08 Jun 2023 03:42:34 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:33 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 09/33] target/mips: Add emulation of MXU S32CPS D16CPS Q8ABD
 Q16SAT insns
Date: Thu,  8 Jun 2023 13:41:58 +0300
Message-Id: <20230608104222.1520143-10-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x129.google.com
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

These instructions are part of pool2, see the grand tree above
in the file.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 296 +++++++++++++++++++++++++++++++-
 1 file changed, 293 insertions(+), 3 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 2eebdfe8ca..b3e3937545 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -361,6 +361,7 @@ enum {
     OPC_MXU_S32MSUB  = 0x04,
     OPC_MXU_S32MSUBU = 0x05,
     OPC_MXU__POOL01  = 0x06,
+    OPC_MXU__POOL02  = 0x07,
     OPC_MXU_D16MUL   = 0x08,
     OPC_MXU_D16MAC   = 0x0A,
     OPC_MXU__POOL04  = 0x10,
@@ -407,6 +408,16 @@ enum {
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
@@ -1677,11 +1688,154 @@ static void gen_mxu_q8avg(DisasContext *ctx, bool round45)
 
 
 /*
- *                 MXU instruction category: Arithmetic
- *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *      MXU instruction category: Addition and subtraction
+ *      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
- *                       Q8ADD
+ *              S32CPS      D16CPS
+ *                                       Q8ADD
+ */
+
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
  */
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
 
 /*
  *  Q8ADD XRa, XRb, XRc, ptn2
@@ -1748,6 +1902,114 @@ static void gen_mxu_Q8ADD(DisasContext *ctx)
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
@@ -2087,6 +2349,31 @@ static void decode_opc_mxu__pool01(DisasContext *ctx)
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
@@ -2336,6 +2623,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
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
2.40.0


