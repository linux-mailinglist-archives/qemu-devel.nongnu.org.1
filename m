Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAE5728115
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:19:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWw-0003kA-Fx; Thu, 08 Jun 2023 09:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6a-0002RU-9Z
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:43:00 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6W-0006cy-To
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:59 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4f4b384c09fso551056e87.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220974; x=1688812974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iIX5uN1RZ3+Do9/+iBI35ySrInqmWigdgngoGpLRp+8=;
 b=qopJ/wRDG4FV51/g5ni7bI/wgzXekSmUr95X696Y1DK4jAd2MSEX80/W8OD0UrQm6n
 86plHbP5g8HrJaLgzg+idpFN0qYCkYdwbsKp8InB5CJ25R206KSyopIBDiZkpJqmtvY4
 PM3rG60go/UYUbr/FtSMMcvbEp3a9WrLesAseDm1obB8ozlHJu04ZoX8Nnu0kffLnQIs
 QotnjfbMkfjFJeaQkTvFx3D4U2fM3XNTL0Phe6D5EXB8K9s2jG3ZivO6YNiYsfjfiDCs
 EdDGT7YuxApe2ALsOuGQibfKfKiEqS3tvOn99ZlPU4B65c/GORtEuillqcrq941mwnxf
 oIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220974; x=1688812974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iIX5uN1RZ3+Do9/+iBI35ySrInqmWigdgngoGpLRp+8=;
 b=RN7RnySpc6OWmuvilp5FsFmnrX4WOsx+3XDeNochnQU3ArO5np+lEJj8Bb9W6KfVMy
 9IY3i6xugXaOFChrByIal5iKNes84kDg3YkYLX7J7Z1lBDo0YYb2ZkmaDRK9dJe+/mu3
 bgn5g7JWwC30LiLKUBkBpMZRYqGpGzPaVFdfw2Am2iagfTFza3qDIPZzSHOcjyvuAZhf
 uS35C0gopKoNzKVsTd6WiaWujtbyaFw03goWClRkdpY8T4l8FBs8RBbakykKqkNt5x93
 YlX9nUAQJuWNHP19SXqoldv+JdjesLOYZ6n8wTO4v6QdIw2OV6AR5EZoKJ1/CUHyRmLl
 xoUA==
X-Gm-Message-State: AC+VfDzmdzQ6A1uSvSc1eEnKoOoZX0LngpwGQZezlY9446kSUqYpB7vv
 9A0kaLbudg/M1bZ8zumVD90EcrYo7EU=
X-Google-Smtp-Source: ACHHUZ6wlyZleunOMyF1ptixqsl8p6j9LSTHsUgcmPGyb07gwqw2Di2PMQ0Dq1zB96x4x+AtbRxTXQ==
X-Received: by 2002:a05:6512:508:b0:4f6:3000:94a0 with SMTP id
 o8-20020a056512050800b004f6300094a0mr3130664lfb.61.1686220974377; 
 Thu, 08 Jun 2023 03:42:54 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:54 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 27/33] target/mips: Add emulation of MXU D32/Q16-
 SLLV/SLRV/SARV instructions
Date: Thu,  8 Jun 2023 13:42:16 +0300
Message-Id: <20230608104222.1520143-28-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x136.google.com
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

These instructions are counterparts for D32/Q16-SLL/SLR/SAR with
difference that the shift amount placed into GPR.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 166 +++++++++++++++++++++++++++++++-
 1 file changed, 162 insertions(+), 4 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 418c02eb8e..ccc375db87 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -320,10 +320,10 @@
  *          ├─ 110001 ─ OPC_MXU_D32SLR      20..18
  *          ├─ 110010 ─ OPC_MXU_D32SARL  ┌─ 000 ─ OPC_MXU_D32SLLV
  *          ├─ 110011 ─ OPC_MXU_D32SAR   ├─ 001 ─ OPC_MXU_D32SLRV
- *          ├─ 110100 ─ OPC_MXU_Q16SLL   ├─ 010 ─ OPC_MXU_D32SARV
- *          ├─ 110101 ─ OPC_MXU_Q16SLR   ├─ 011 ─ OPC_MXU_Q16SLLV
- *          │                            ├─ 100 ─ OPC_MXU_Q16SLRV
- *          ├─ 110110 ─ OPC_MXU__POOL18 ─┴─ 101 ─ OPC_MXU_Q16SARV
+ *          ├─ 110100 ─ OPC_MXU_Q16SLL   ├─ 011 ─ OPC_MXU_D32SARV
+ *          ├─ 110101 ─ OPC_MXU_Q16SLR   ├─ 100 ─ OPC_MXU_Q16SLLV
+ *          │                            ├─ 101 ─ OPC_MXU_Q16SLRV
+ *          ├─ 110110 ─ OPC_MXU__POOL18 ─┴─ 111 ─ OPC_MXU_Q16SARV
  *          │
  *          ├─ 110111 ─ OPC_MXU_Q16SAR
  *          │                               23..22
@@ -402,6 +402,7 @@ enum {
     OPC_MXU_D32SAR   = 0x33,
     OPC_MXU_Q16SLL   = 0x34,
     OPC_MXU_Q16SLR   = 0x35,
+    OPC_MXU__POOL18  = 0x36,
     OPC_MXU_Q16SAR   = 0x37,
     OPC_MXU__POOL19  = 0x38,
 };
@@ -522,6 +523,18 @@ enum {
     OPC_MXU_LXHU     = 0x05,
 };
 
+/*
+ * MXU pool 18
+ */
+enum {
+    OPC_MXU_D32SLLV  = 0x00,
+    OPC_MXU_D32SLRV  = 0x01,
+    OPC_MXU_D32SARV  = 0x03,
+    OPC_MXU_Q16SLLV  = 0x04,
+    OPC_MXU_Q16SLRV  = 0x05,
+    OPC_MXU_Q16SARV  = 0x07,
+};
+
 /*
  * MXU pool 19
  */
@@ -1752,6 +1765,50 @@ static void gen_mxu_d32sxx(DisasContext *ctx, bool right, bool arithmetic)
     gen_store_mxu_gpr(t1, XRd);
 }
 
+/*
+ *  D32SLLV XRa, XRd, rs
+ *    Dual 32-bit shift left from XRa and XRd to rs[3:0]
+ *    bits. Store back to XRa and XRd respectively.
+ *  D32SLRV XRa, XRd, rs
+ *    Dual 32-bit shift logic right from XRa and XRd to rs[3:0]
+ *    bits. Store back to XRa and XRd respectively.
+ *  D32SARV XRa, XRd, rs
+ *    Dual 32-bit shift arithmetic right from XRa and XRd to rs[3:0]
+ *    bits. Store back to XRa and XRd respectively.
+ */
+static void gen_mxu_d32sxxv(DisasContext *ctx, bool right, bool arithmetic)
+{
+    uint32_t XRa, XRd, rs;
+
+    XRa = extract32(ctx->opcode, 10, 4);
+    XRd = extract32(ctx->opcode, 14, 4);
+    rs  = extract32(ctx->opcode, 21, 5);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+
+    gen_load_mxu_gpr(t0, XRa);
+    gen_load_mxu_gpr(t1, XRd);
+    gen_load_gpr(t2, rs);
+    tcg_gen_andi_tl(t2, t2, 0x0f);
+
+    if (right) {
+        if (arithmetic) {
+            tcg_gen_sar_tl(t0, t0, t2);
+            tcg_gen_sar_tl(t1, t1, t2);
+        } else {
+            tcg_gen_shr_tl(t0, t0, t2);
+            tcg_gen_shr_tl(t1, t1, t2);
+        }
+    } else {
+        tcg_gen_shl_tl(t0, t0, t2);
+        tcg_gen_shl_tl(t1, t1, t2);
+    }
+    gen_store_mxu_gpr(t0, XRa);
+    gen_store_mxu_gpr(t1, XRd);
+}
+
 /*
  *  D32SARL XRa, XRb, XRc, SFT4
  *    Dual shift arithmetic right 32-bit integers in XRb and XRc
@@ -1860,6 +1917,74 @@ static void gen_mxu_q16sxx(DisasContext *ctx, bool right, bool arithmetic)
     gen_store_mxu_gpr(t2, XRd);
 }
 
+/*
+ *  Q16SLLV XRa, XRd, rs
+ *    Quad 16-bit shift left from XRa and XRd to rs[3:0]
+ *    bits. Store to XRa and XRd respectively.
+ *  Q16SLRV XRa, XRd, rs
+ *    Quad 16-bit shift logic right from XRa and XRd to rs[3:0]
+ *    bits. Store to XRa and XRd respectively.
+ *  Q16SARV XRa, XRd, rs
+ *    Quad 16-bit shift arithmetic right from XRa and XRd to rs[3:0]
+ *    bits. Store to XRa and XRd respectively.
+ */
+static void gen_mxu_q16sxxv(DisasContext *ctx, bool right, bool arithmetic)
+{
+    uint32_t XRa, XRd, rs;
+
+    XRa = extract32(ctx->opcode, 10, 4);
+    XRd = extract32(ctx->opcode, 14, 4);
+    rs  = extract32(ctx->opcode, 21, 5);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+    TCGv t3 = tcg_temp_new();
+    TCGv t5 = tcg_temp_new();
+
+    gen_load_mxu_gpr(t0, XRa);
+    gen_load_mxu_gpr(t2, XRd);
+    gen_load_gpr(t5, rs);
+    tcg_gen_andi_tl(t5, t5, 0x0f);
+
+
+    if (arithmetic) {
+        tcg_gen_sextract_tl(t1, t0, 16, 16);
+        tcg_gen_sextract_tl(t0, t0,  0, 16);
+        tcg_gen_sextract_tl(t3, t2, 16, 16);
+        tcg_gen_sextract_tl(t2, t2,  0, 16);
+    } else {
+        tcg_gen_extract_tl(t1, t0, 16, 16);
+        tcg_gen_extract_tl(t0, t0,  0, 16);
+        tcg_gen_extract_tl(t3, t2, 16, 16);
+        tcg_gen_extract_tl(t2, t2,  0, 16);
+    }
+
+    if (right) {
+        if (arithmetic) {
+            tcg_gen_sar_tl(t0, t0, t5);
+            tcg_gen_sar_tl(t1, t1, t5);
+            tcg_gen_sar_tl(t2, t2, t5);
+            tcg_gen_sar_tl(t3, t3, t5);
+        } else {
+            tcg_gen_shr_tl(t0, t0, t5);
+            tcg_gen_shr_tl(t1, t1, t5);
+            tcg_gen_shr_tl(t2, t2, t5);
+            tcg_gen_shr_tl(t3, t3, t5);
+        }
+    } else {
+        tcg_gen_shl_tl(t0, t0, t5);
+        tcg_gen_shl_tl(t1, t1, t5);
+        tcg_gen_shl_tl(t2, t2, t5);
+        tcg_gen_shl_tl(t3, t3, t5);
+    }
+    tcg_gen_deposit_tl(t0, t0, t1, 16, 16);
+    tcg_gen_deposit_tl(t2, t2, t3, 16, 16);
+
+    gen_store_mxu_gpr(t0, XRa);
+    gen_store_mxu_gpr(t2, XRd);
+}
+
 /*
  *                   MXU instruction category max/min/avg
  *                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -4238,6 +4363,36 @@ static void decode_opc_mxu__pool17(DisasContext *ctx)
     }
 }
 
+static void decode_opc_mxu__pool18(DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 18, 3);
+
+    switch (opcode) {
+    case OPC_MXU_D32SLLV:
+        gen_mxu_d32sxxv(ctx, false, false);
+        break;
+    case OPC_MXU_D32SLRV:
+        gen_mxu_d32sxxv(ctx, true, false);
+        break;
+    case OPC_MXU_D32SARV:
+        gen_mxu_d32sxxv(ctx, true, true);
+        break;
+    case OPC_MXU_Q16SLLV:
+        gen_mxu_q16sxxv(ctx, false, false);
+        break;
+    case OPC_MXU_Q16SLRV:
+        gen_mxu_q16sxxv(ctx, true, false);
+        break;
+    case OPC_MXU_Q16SARV:
+        gen_mxu_q16sxxv(ctx, true, true);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        gen_reserved_instruction(ctx);
+        break;
+    }
+}
+
 static void decode_opc_mxu__pool19(DisasContext *ctx)
 {
     uint32_t opcode = extract32(ctx->opcode, 22, 2);
@@ -4402,6 +4557,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU_Q16SLL:
             gen_mxu_q16sxx(ctx, false, false);
             break;
+        case OPC_MXU__POOL18:
+            decode_opc_mxu__pool18(ctx);
+            break;
         case OPC_MXU_Q16SLR:
             gen_mxu_q16sxx(ctx, true, false);
             break;
-- 
2.40.0


