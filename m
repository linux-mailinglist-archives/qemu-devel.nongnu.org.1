Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E291C728141
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:22:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWr-0003XK-Bh; Thu, 08 Jun 2023 09:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6S-0002ON-Vc
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:53 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6R-0006aH-6A
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:52 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f642a24555so558943e87.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220969; x=1688812969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BWWmBI/GczjQJo7V4t04yZusnXF3X7oxx3gC41AP1PM=;
 b=OSB3NfJwjUoqpqECzeVSOJhDGUjkZYPGaCmO910NQRijaO4xyqs3G2VA3Xj4IrRTm0
 lJqysdi+jMgxt26jpq24Ao27k3dN5YPpEElVHkEP+Ix4yzxJdCc3w1yDyBp6DPlkeYQT
 So57xPdQgH20CMmZWWHHwS+FZ2z/8tx/1tvl+/h6BS1WmyaVJIkDPA6P6oep7AzOLGTO
 Z32M7sDG7YuwKw7JnOgZ5nSCdQMwH2lbmdRXznz+d4iKloHArlEDS1E4WEJzjLSmhTZy
 l/XD4GR/jOgYaTL1U3pChVSRBr4DT1Z+AR1pnnHJ36uwpdwTfN4HvbbmuAm3PlsZrwBF
 HgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220969; x=1688812969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BWWmBI/GczjQJo7V4t04yZusnXF3X7oxx3gC41AP1PM=;
 b=MXiJuW4zY3teVht+IgE8GYsdNc1bcVYMh3BwHUyd/grfNEleciNi1wrW/s2+ZeH7wE
 RKrsXCcn29gWGKbSfntAPoVgRtxTpRnhVU32KPcgKhmKSJ8BJGMTaubwvfIOd7cewUHR
 1cSDqTOPxS7skdsCeU2Bf7wOGSvnLH14t06wQTYQSY+LNsvADPh7GJAZnN5YW+yuiofY
 KPLGMQ2odKsl6TYkunSm15HQrH1cy63hoCP4vl7R4ubJwXGAED4DxjYt65BfGPvpWHM1
 ApRoZbZEbHx3xf/3PEbmQY7DB4cKSnwOi1zc1FCXpJugEJl4b2in4SCg4Mg2Z7ycYYk3
 VP2g==
X-Gm-Message-State: AC+VfDyhcIok3FVLykSlKmbJVVPTKj2omn2NBVzx05HuNo/bz+3RUbeD
 3zUlGvjTvEpJYifNP8xoNBq7hzIzKZY=
X-Google-Smtp-Source: ACHHUZ7QUCOVDjleWp7C9T6pJoVhpuFfVGNwj2RCLxOBo9omJ9HvtzBr2EdY0S5l8A7AoOGp6VkVeg==
X-Received: by 2002:ac2:4303:0:b0:4f3:5038:5857 with SMTP id
 l3-20020ac24303000000b004f350385857mr2965845lfh.55.1686220969378; 
 Thu, 08 Jun 2023 03:42:49 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:49 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 23/33] target/mips: Add emulation of MXU S32ALN S32LUI insns
Date: Thu,  8 Jun 2023 13:42:12 +0300
Message-Id: <20230608104222.1520143-24-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x133.google.com
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

These instructions are part of pool16, see the grand opcode organization
tree on top of the file.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 122 +++++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 1 deletion(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 79c36cf54e..d67c6ecb0d 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -494,7 +494,9 @@ enum {
  * MXU pool 16
  */
 enum {
+    OPC_MXU_S32ALN   = 0x01,
     OPC_MXU_S32ALNI  = 0x02,
+    OPC_MXU_S32LUI   = 0x03,
     OPC_MXU_S32NOR   = 0x04,
     OPC_MXU_S32AND   = 0x05,
     OPC_MXU_S32OR    = 0x06,
@@ -3068,7 +3070,7 @@ static void gen_mxu_d32asum(DisasContext *ctx)
  *                 MXU instruction category: Miscellaneous
  *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
- *               S32EXTR
+ *               S32EXTR      S32LUI
  *               S32EXTRV
  *                            Q16SAT
  */
@@ -3184,6 +3186,59 @@ static void gen_mxu_s32extrv(DisasContext *ctx)
     gen_store_mxu_gpr(t0, XRa);
 }
 
+/*
+ *  S32LUI XRa, S8, optn3
+ *    Permutate the immediate S8 value to form a word
+ *    to update XRa.
+ */
+static void gen_mxu_s32lui(DisasContext *ctx)
+{
+    uint32_t XRa, s8, optn3, pad;
+
+    XRa   = extract32(ctx->opcode,  6, 4);
+    s8    = extract32(ctx->opcode, 10, 8);
+    pad   = extract32(ctx->opcode, 21, 2);
+    optn3 = extract32(ctx->opcode, 23, 3);
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else {
+        uint32_t s16;
+        TCGv t0 = tcg_temp_new();
+
+        switch (optn3) {
+        case 0:
+            tcg_gen_movi_tl(t0, s8);
+            break;
+        case 1:
+            tcg_gen_movi_tl(t0, s8 << 8);
+            break;
+        case 2:
+            tcg_gen_movi_tl(t0, s8 << 16);
+            break;
+        case 3:
+            tcg_gen_movi_tl(t0, s8 << 24);
+            break;
+        case 4:
+            tcg_gen_movi_tl(t0, (s8 << 16) | s8);
+            break;
+        case 5:
+            tcg_gen_movi_tl(t0, (s8 << 24) | (s8 << 8));
+            break;
+        case 6:
+            s16 = (uint16_t)(int16_t)(int8_t)s8;
+            tcg_gen_movi_tl(t0, (s16 << 16) | s16);
+            break;
+        case 7:
+            tcg_gen_movi_tl(t0, (s8 << 24) | (s8 << 16) | (s8 << 8) | s8);
+            break;
+        }
+        gen_store_mxu_gpr(t0, XRa);
+    }
+}
+
 /*
  *  Q16SAT XRa, XRb, XRc
  *  Packs four 16-bit signed integers in XRb and XRc to
@@ -3463,6 +3518,65 @@ static void gen_mxu_S32ALNI(DisasContext *ctx)
     }
 }
 
+/*
+ *  S32ALN XRc, XRb, XRa, rs
+ *    Arrange bytes from XRb and XRc according to one of five sets of
+ *    rules determined by rs[2:0], and place the result in XRa.
+ */
+static void gen_mxu_S32ALN(DisasContext *ctx)
+{
+    uint32_t rs, XRc, XRb, XRa;
+
+    rs  = extract32(ctx->opcode, 21, 5);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRa = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to all 0s */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+    } else {
+        /* the most general case */
+        TCGv t0 = tcg_temp_new();
+        TCGv t1 = tcg_temp_new();
+        TCGv t2 = tcg_temp_new();
+        TCGv t3 = tcg_temp_new();
+        TCGLabel *l_exit = gen_new_label();
+        TCGLabel *l_b_only = gen_new_label();
+        TCGLabel *l_c_only = gen_new_label();
+
+        gen_load_mxu_gpr(t0, XRb);
+        gen_load_mxu_gpr(t1, XRc);
+        gen_load_gpr(t2, rs);
+        tcg_gen_andi_tl(t2, t2, 0x07);
+
+        /* do nothing for undefined cases */
+        tcg_gen_brcondi_tl(TCG_COND_GE, t2, 5, l_exit);
+
+        tcg_gen_brcondi_tl(TCG_COND_EQ, t2, 0, l_b_only);
+        tcg_gen_brcondi_tl(TCG_COND_EQ, t2, 4, l_c_only);
+
+        tcg_gen_shli_tl(t2, t2, 3);
+        tcg_gen_subfi_tl(t3, 32, t2);
+
+        tcg_gen_shl_tl(t0, t0, t2);
+        tcg_gen_shr_tl(t1, t1, t3);
+        tcg_gen_or_tl(mxu_gpr[XRa - 1], t0, t1);
+        tcg_gen_br(l_exit);
+
+        gen_set_label(l_b_only);
+        gen_store_mxu_gpr(t0, XRa);
+        tcg_gen_br(l_exit);
+
+        gen_set_label(l_c_only);
+        gen_store_mxu_gpr(t1, XRa);
+
+        gen_set_label(l_exit);
+    }
+}
+
 /*
  *  S32MADD XRa, XRd, rb, rc
  *    32 to 64 bit signed multiply with subsequent add
@@ -3891,9 +4005,15 @@ static void decode_opc_mxu__pool16(DisasContext *ctx)
     uint32_t opcode = extract32(ctx->opcode, 18, 3);
 
     switch (opcode) {
+    case OPC_MXU_S32ALN:
+        gen_mxu_S32ALN(ctx);
+        break;
     case OPC_MXU_S32ALNI:
         gen_mxu_S32ALNI(ctx);
         break;
+    case OPC_MXU_S32LUI:
+        gen_mxu_s32lui(ctx);
+        break;
     case OPC_MXU_S32NOR:
         gen_mxu_S32NOR(ctx);
         break;
-- 
2.40.0


