Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB37672810E
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:18:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FX9-00040z-B4; Thu, 08 Jun 2023 09:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6U-0002PL-QR
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:54 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6T-0006au-4Q
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:54 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4f4b2bc1565so570094e87.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220971; x=1688812971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIt74xnOWuiFkSLaBnFmfokWx+l2oBjGHuHY8MrmuKU=;
 b=MqvuwpGDW8YqcrGnnkGq6qpehawt0ZqbBpBmVUu/qXy63NNKtJZYr1y6h6RCM/1Crv
 KCIiqOXhI1bXSwcHZ255wdpKwufOJw5rQK5vqrFSV9eUz8Wl7qLUc9G9UkCADCymR7D/
 3xoU/wXfZ3VA0QqxPL5Vx9HPHmuOB+S+UuTppnAhN5l+e6XwCCgknXkZjikzu2U2kLak
 7TeENdeQcpHcrFhgZaPGB+rJOdfgPcyGNsfb6CJpcUYPIGnGKMhWKzyVY9BQAXGX6GQe
 2ojWSuXphIJqbNEvzqg3STTvzwhHGJqeejwWCuvw+JmM2VBvQGhd9bRJYtpjKYNaJuo2
 wGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220971; x=1688812971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nIt74xnOWuiFkSLaBnFmfokWx+l2oBjGHuHY8MrmuKU=;
 b=DbO8ZqdwD6GtPXxB+jaU8bJ0kS+j6edM6LBRJZSBQtseNPVjQKDm+vDhhH6Z9SPVcl
 ZPkpC9QS3APveWcclNzfCVysuTcaT/uuV8MXiGp+yLra08WJLIBpjdpCEVhev+yFh2SG
 3hL37kt8WlGiQYi7WC2o1z+0bEt2My4ONSJuQUugPOM7ANkHqMP6SgClg50sFXFA/vvV
 XebYQp05JxqAWq1NpLOAk1lZhWcDnkOjUjlmCb9rrJowNpZTQfrkcDwg8lTkAH4COUNb
 1OREWzilCGHM/5KGjiIi2ULVSw21e9Vh7alII26RPP36W6obzmkU1MfvTomLtyZ0byqP
 yd2Q==
X-Gm-Message-State: AC+VfDzKxEDkiH+gthh+V2gYPzZcfN+na8jm1ScZ+nMob0ilaHtW0YXA
 1WPtQvESXO+n1JL7WdJ9R+o1X2ru/qA=
X-Google-Smtp-Source: ACHHUZ5vL7w7agjT93vs7jA8oI9aOFx/m/WBZHm4kaxLljQKsizTWAiTuDNq63HI18QNrBSG5Thd0Q==
X-Received: by 2002:ac2:44b7:0:b0:4f6:40e1:4a92 with SMTP id
 c23-20020ac244b7000000b004f640e14a92mr2119910lfm.13.1686220971359; 
 Thu, 08 Jun 2023 03:42:51 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:51 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 25/33] target/mips: Add emulation of MXU D32SLL D32SLR D32SAR
 instructions
Date: Thu,  8 Jun 2023 13:42:14 +0300
Message-Id: <20230608104222.1520143-26-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
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

These instructions are same data shift in various directions, thus one
generation function is implemented for all three.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 55 +++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index da6ffffaa4..93644d74e2 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -396,7 +396,10 @@ enum {
     OPC_MXU_S16SDI   = 0x2D,
     OPC_MXU_S32M2I   = 0x2E,
     OPC_MXU_S32I2M   = 0x2F,
+    OPC_MXU_D32SLL   = 0x30,
+    OPC_MXU_D32SLR   = 0x31,
     OPC_MXU_D32SARL  = 0x32,
+    OPC_MXU_D32SAR   = 0x33,
     OPC_MXU__POOL19  = 0x38,
 };
 
@@ -1703,6 +1706,49 @@ static void gen_mxu_S32XOR(DisasContext *ctx)
  *               Q16SLLV   Q16SLRV   Q16SARV
  */
 
+/*
+ *  D32SLL XRa, XRd, XRb, XRc, SFT4
+ *    Dual 32-bit shift left from XRb and XRc to SFT4
+ *    bits (0..15). Store to XRa and XRd respectively.
+ *  D32SLR XRa, XRd, XRb, XRc, SFT4
+ *    Dual 32-bit shift logic right from XRb and XRc
+ *    to SFT4 bits (0..15). Store to XRa and XRd respectively.
+ *  D32SAR XRa, XRd, XRb, XRc, SFT4
+ *    Dual 32-bit shift arithmetic right from XRb and XRc
+ *    to SFT4 bits (0..15). Store to XRa and XRd respectively.
+ */
+static void gen_mxu_d32sxx(DisasContext *ctx, bool right, bool arithmetic)
+{
+    uint32_t XRa, XRb, XRc, XRd, sft4;
+
+    XRa  = extract32(ctx->opcode,  6, 4);
+    XRb  = extract32(ctx->opcode, 10, 4);
+    XRc  = extract32(ctx->opcode, 14, 4);
+    XRd  = extract32(ctx->opcode, 18, 4);
+    sft4 = extract32(ctx->opcode, 22, 4);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+
+    gen_load_mxu_gpr(t0, XRb);
+    gen_load_mxu_gpr(t1, XRc);
+
+    if (right) {
+        if (arithmetic) {
+            tcg_gen_sari_tl(t0, t0, sft4);
+            tcg_gen_sari_tl(t1, t1, sft4);
+        } else {
+            tcg_gen_shri_tl(t0, t0, sft4);
+            tcg_gen_shri_tl(t1, t1, sft4);
+        }
+    } else {
+        tcg_gen_shli_tl(t0, t0, sft4);
+        tcg_gen_shli_tl(t1, t1, sft4);
+    }
+    gen_store_mxu_gpr(t0, XRa);
+    gen_store_mxu_gpr(t1, XRd);
+}
+
 /*
  *  D32SARL XRa, XRb, XRc, SFT4
  *    Dual shift arithmetic right 32-bit integers in XRb and XRc
@@ -4272,9 +4318,18 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU_S16SDI:
             gen_mxu_s16std(ctx, true);
             break;
+        case OPC_MXU_D32SLL:
+            gen_mxu_d32sxx(ctx, false, false);
+            break;
+        case OPC_MXU_D32SLR:
+            gen_mxu_d32sxx(ctx, true, false);
+            break;
         case OPC_MXU_D32SARL:
             gen_mxu_d32sarl(ctx, false);
             break;
+        case OPC_MXU_D32SAR:
+            gen_mxu_d32sxx(ctx, true, true);
+            break;
         case OPC_MXU__POOL19:
             decode_opc_mxu__pool19(ctx);
             break;
-- 
2.40.0


