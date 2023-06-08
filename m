Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A545D72812A
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:21:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWz-0003pa-QN; Thu, 08 Jun 2023 09:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6T-0002OX-P5
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:53 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6S-0006af-5C
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:53 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f61d79b0f2so572189e87.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220970; x=1688812970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1csWmmT3ijoAR1lJUCJk3GmLmgxjOq7UEKKYd20Tasg=;
 b=OEyyw7Udw3tZSVxS/Dez+hujD/eeYF3BNlwhDqU8T6s70sxiD+4PJQrAQTvwvTTor/
 PTPlXk9OQ1GyDkW+787OpH+XgMO0SBct/epYNjqu9yESpT1OIHtJPM3zW+/qhllHxDIo
 JrS3F5mcEtGCEm0ro6wYecVOUXWaWtT/JWsC3Kw1pxmc0jmT8F3idBqPEO6M3VXQGAYe
 +nc1DpVxyRURuVlbzEjCpOh4p0if570cNlle5EqgH25d23WBUvon2/AJt6DqBwsfZ32K
 Ln5oGaCu0yMx0jkJ+fOi/8rtwAfT0SWNfVj8wSHXZML1Bi4ZEd6n0tTW6Vl4eqvD0ITL
 sBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220970; x=1688812970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1csWmmT3ijoAR1lJUCJk3GmLmgxjOq7UEKKYd20Tasg=;
 b=GSA3jZDgDNqVjZ1/Utq+a//nGf5qNhfhGooRiYWzgwLTq4WwBCKY63n6bZJS2ib/Vp
 gJNaBpgKPLOx345mUlTHzEC7+Bsg4qSv8S7N1Ir6NmBksiibSOOj/keBtSpVBH2SSUXv
 QaGtlO3OBZDzqPaFmQYqAO2JipkqGEsza7xSrMg85+KU3EZ0ndlrqCG09TCoGFmuSA76
 QtrxRBzlfDnSdvVRIWVAMC6F5SQUJGJHcyrXNu4VKjlSm089lUrxvl2Ojx1a1niY8JhT
 96dRYmF6gwMMrSuLOtOWO3WslZo4vOWkyGc5nrGYaDopn00bM9KIjW049ltadwMSok6W
 VhBQ==
X-Gm-Message-State: AC+VfDz5TEJ2YspSzpe//9PVJSRi7w9Oe92Z6PhirDZ9u8FptTJjToJB
 qbifHd7mJ/bKZcAyJoDN8BC+ivLPlvs=
X-Google-Smtp-Source: ACHHUZ6wqIe8OjD1jcI0URh7jv7D5VR5vk8lQgPdlkthYMxWzlBUC9U431PTIANj289kK5JKTJNzLw==
X-Received: by 2002:a19:ca5b:0:b0:4f6:4d92:a001 with SMTP id
 h27-20020a19ca5b000000b004f64d92a001mr603893lfj.27.1686220970352; 
 Thu, 08 Jun 2023 03:42:50 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:50 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 24/33] target/mips: Add emulation of MXU D32SARL D32SARW
 instructions
Date: Thu,  8 Jun 2023 13:42:13 +0300
Message-Id: <20230608104222.1520143-25-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x12e.google.com
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

These instructions are dual 32-bit arithmetic shift right and
pack LSBs to 2x 16-bit into a MXU register.
The difference is the shift amount source: immediate or GP reg.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 59 +++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index d67c6ecb0d..da6ffffaa4 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -396,6 +396,7 @@ enum {
     OPC_MXU_S16SDI   = 0x2D,
     OPC_MXU_S32M2I   = 0x2E,
     OPC_MXU_S32I2M   = 0x2F,
+    OPC_MXU_D32SARL  = 0x32,
     OPC_MXU__POOL19  = 0x38,
 };
 
@@ -494,6 +495,7 @@ enum {
  * MXU pool 16
  */
 enum {
+    OPC_MXU_D32SARW  = 0x00,
     OPC_MXU_S32ALN   = 0x01,
     OPC_MXU_S32ALNI  = 0x02,
     OPC_MXU_S32LUI   = 0x03,
@@ -1691,6 +1693,57 @@ static void gen_mxu_S32XOR(DisasContext *ctx)
     }
 }
 
+/*
+ *                 MXU instruction category: shift
+ *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *               D32SLL    D32SLR    D32SAR    D32SARL
+ *               D32SLLV   D32SLRV   D32SARV   D32SARW
+ *               Q16SLL    Q16SLR    Q16SAR
+ *               Q16SLLV   Q16SLRV   Q16SARV
+ */
+
+/*
+ *  D32SARL XRa, XRb, XRc, SFT4
+ *    Dual shift arithmetic right 32-bit integers in XRb and XRc
+ *    to SFT4 bits (0..15). Pack 16 LSBs of each into XRa.
+ *
+ *  D32SARW XRa, XRb, XRc, rb
+ *    Dual shift arithmetic right 32-bit integers in XRb and XRc
+ *    to rb[3:0] bits. Pack 16 LSBs of each into XRa.
+ */
+static void gen_mxu_d32sarl(DisasContext *ctx, bool sarw)
+{
+    uint32_t XRa, XRb, XRc, rb;
+
+    XRa = extract32(ctx->opcode,  6, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRc = extract32(ctx->opcode, 14, 4);
+    rb  = extract32(ctx->opcode, 21, 5);
+
+    if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else {
+        TCGv t0 = tcg_temp_new();
+        TCGv t1 = tcg_temp_new();
+        TCGv t2 = tcg_temp_new();
+
+        if (!sarw) {
+            /* Make SFT4 from rb field */
+            tcg_gen_movi_tl(t2, rb >> 1);
+        } else {
+            gen_load_gpr(t2, rb);
+            tcg_gen_andi_tl(t2, t2, 0x0f);
+        }
+        gen_load_mxu_gpr(t0, XRb);
+        gen_load_mxu_gpr(t1, XRc);
+        tcg_gen_sar_tl(t0, t0, t2);
+        tcg_gen_sar_tl(t1, t1, t2);
+        tcg_gen_extract_tl(t2, t1, 0, 16);
+        tcg_gen_deposit_tl(t2, t2, t0, 16, 16);
+        gen_store_mxu_gpr(t2, XRa);
+    }
+}
 
 /*
  *                   MXU instruction category max/min/avg
@@ -4005,6 +4058,9 @@ static void decode_opc_mxu__pool16(DisasContext *ctx)
     uint32_t opcode = extract32(ctx->opcode, 18, 3);
 
     switch (opcode) {
+    case OPC_MXU_D32SARW:
+        gen_mxu_d32sarl(ctx, true);
+        break;
     case OPC_MXU_S32ALN:
         gen_mxu_S32ALN(ctx);
         break;
@@ -4216,6 +4272,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU_S16SDI:
             gen_mxu_s16std(ctx, true);
             break;
+        case OPC_MXU_D32SARL:
+            gen_mxu_d32sarl(ctx, false);
+            break;
         case OPC_MXU__POOL19:
             decode_opc_mxu__pool19(ctx);
             break;
-- 
2.40.0


