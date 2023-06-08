Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36972728132
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:22:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWi-0003R7-Gl; Thu, 08 Jun 2023 09:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6F-0002J1-U8
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:39 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6D-0006V6-53
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:39 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4f122ff663eso550659e87.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220955; x=1688812955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VOKWKGLAIXv9YiGFIoj/OF3at1WTFXY+plOc1+ku6cg=;
 b=PMkrJPldKugqj1+qbWKmcs7i7i5Kn0zqE+dtlGOMOX9kS687Dj7SEjzbM7bz8JG352
 A7ywmAmkr32wsGPhDyfdsrILaxny5B3cr8ixHMCVm8Zmav/Awqtj8zqwtSGzXDJ0ZY4Z
 fqAlyNoDSYYyiHmESOL1mZ6gkEPvBRGPdhmeR2mZQHSnZXDcjR0LJjOKQaCJ3GYDMELu
 k0M7pNt1hCnS8VNQFDvrKgnihu72XuD035wXOw4/5aXpwWX2t49jXggx7J2PKXxSUu1e
 5tOS+v7qOt3dMCU1b1/Rnb9Nm7GJxM83/uJFsjvIhVQi2JUb6uL5ANXKBo2/4U6Hd5t1
 owQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220955; x=1688812955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VOKWKGLAIXv9YiGFIoj/OF3at1WTFXY+plOc1+ku6cg=;
 b=QE4XjsNh/ExpsgE7fneX3gqvQUFALrIVjVUw7azY47aMkFTYax97BY3AiLEJ7nfmkU
 S9/fv2LQqP/LzAQPPfDPUQWVubDeD4agBwMqAWyHJlImtDSkMHr3PUlgqXQzpAmFKYfE
 gG5fG/zlbimDFBW2/dE8p10/yzwdGlDpflZoeDNMDHwo6GLB+uoYwiBMxfTzZjqY1mKA
 jKQYDMZzpzKNYLNBYa2KogU3nATOBO96xfqHYXnsumXNlebfW41/5XjUWpqWJz+vTj/5
 1d9mZ2IhVyIBMNrLwYSfQkkrPazaI6K4MdivXeSwyp0o2GgMUPGNBe+V93max1woGIPl
 viGQ==
X-Gm-Message-State: AC+VfDychpL2BNQ/I3jUtk0ecYwlS+HMJNq11HXre6TcypMZDSSTvKRF
 kd3PVmKEGXUJvUZ86ZTGI8opSkRDDdE=
X-Google-Smtp-Source: ACHHUZ59xw8r0w5bd2NKru5o2v90CKh+qLQ6d5Z5qu659dsYoAfofI2ks2jdKcdmw+LsCx/60g514g==
X-Received: by 2002:a19:ee07:0:b0:4f3:a812:5ae with SMTP id
 g7-20020a19ee07000000b004f3a81205aemr2979000lfb.37.1686220955382; 
 Thu, 08 Jun 2023 03:42:35 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:35 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 10/33] target/mips: Add emulation of MXU D16MULF D16MULE
 instructions
Date: Thu,  8 Jun 2023 13:41:59 +0300
Message-Id: <20230608104222.1520143-11-lis8215@gmail.com>
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

These instructions are part of pool3, see the grand tree above
in the file.
The instructions are close to D16MUL so common generation function
provided.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 95 +++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 5 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index b3e3937545..d1f4fc79de 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -363,6 +363,7 @@ enum {
     OPC_MXU__POOL01  = 0x06,
     OPC_MXU__POOL02  = 0x07,
     OPC_MXU_D16MUL   = 0x08,
+    OPC_MXU__POOL03  = 0x09,
     OPC_MXU_D16MAC   = 0x0A,
     OPC_MXU__POOL04  = 0x10,
     OPC_MXU__POOL05  = 0x11,
@@ -418,6 +419,14 @@ enum {
     OPC_MXU_Q16SAT   = 0x06,
 };
 
+/*
+ * MXU pool 03
+ */
+enum {
+    OPC_MXU_D16MULF  = 0x00,
+    OPC_MXU_D16MULE  = 0x01,
+};
+
 /*
  * MXU pool 04 05 06 07 08 09 10 11
  */
@@ -662,9 +671,14 @@ static void gen_mxu_s8ldd(DisasContext *ctx)
 }
 
 /*
- * D16MUL XRa, XRb, XRc, XRd, optn2 - Signed 16 bit pattern multiplication
+ * D16MUL  XRa, XRb, XRc, XRd, optn2 - Signed 16 bit pattern multiplication
+ * D16MULF XRa, XRb, XRc, optn2 - Signed Q15 fraction pattern multiplication
+ *   with rounding and packing result
+ * D16MULE XRa, XRb, XRc, XRd, optn2 - Signed Q15 fraction pattern
+ *   multiplication with rounding
  */
-static void gen_mxu_d16mul(DisasContext *ctx)
+static void gen_mxu_d16mul(DisasContext *ctx, bool fractional,
+                           bool packed_result)
 {
     TCGv t0, t1, t2, t3;
     uint32_t XRa, XRb, XRc, XRd, optn2;
@@ -680,6 +694,12 @@ static void gen_mxu_d16mul(DisasContext *ctx)
     XRd = extract32(ctx->opcode, 18, 4);
     optn2 = extract32(ctx->opcode, 22, 2);
 
+    /*
+     * TODO: XRd field isn't used for D16MULF
+     * There's no knowledge how this field affect
+     * instruction decoding/behavior
+     */
+
     gen_load_mxu_gpr(t1, XRb);
     tcg_gen_sextract_tl(t0, t1, 0, 16);
     tcg_gen_sextract_tl(t1, t1, 16, 16);
@@ -705,8 +725,52 @@ static void gen_mxu_d16mul(DisasContext *ctx)
         tcg_gen_mul_tl(t2, t1, t2);
         break;
     }
-    gen_store_mxu_gpr(t3, XRa);
-    gen_store_mxu_gpr(t2, XRd);
+    if (fractional) {
+        TCGLabel *l_done = gen_new_label();
+        TCGv rounding = tcg_temp_new();
+
+        tcg_gen_shli_tl(t3, t3, 1);
+        tcg_gen_shli_tl(t2, t2, 1);
+        tcg_gen_andi_tl(rounding, mxu_CR, 0x2);
+        tcg_gen_brcondi_tl(TCG_COND_EQ, rounding, 0, l_done);
+        if (packed_result) {
+            TCGLabel *l_apply_bias_l = gen_new_label();
+            TCGLabel *l_apply_bias_r = gen_new_label();
+            TCGLabel *l_half_done = gen_new_label();
+            TCGv bias = tcg_temp_new();
+
+            /*
+             * D16MULF supports unbiased rounding aka "bankers rounding",
+             * "round to even", "convergent rounding"
+             */
+            tcg_gen_andi_tl(bias, mxu_CR, 0x4);
+            tcg_gen_brcondi_tl(TCG_COND_NE, bias, 0, l_apply_bias_l);
+            tcg_gen_andi_tl(t0, t3, 0x1ffff);
+            tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0x8000, l_half_done);
+            gen_set_label(l_apply_bias_l);
+            tcg_gen_addi_tl(t3, t3, 0x8000);
+            gen_set_label(l_half_done);
+            tcg_gen_brcondi_tl(TCG_COND_NE, bias, 0, l_apply_bias_r);
+            tcg_gen_andi_tl(t0, t2, 0x1ffff);
+            tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0x8000, l_done);
+            gen_set_label(l_apply_bias_r);
+            tcg_gen_addi_tl(t2, t2, 0x8000);
+        } else {
+            /* D16MULE doesn't support unbiased rounding */
+            tcg_gen_addi_tl(t3, t3, 0x8000);
+            tcg_gen_addi_tl(t2, t2, 0x8000);
+        }
+        gen_set_label(l_done);
+    }
+    if (!packed_result) {
+        gen_store_mxu_gpr(t3, XRa);
+        gen_store_mxu_gpr(t2, XRd);
+    } else {
+        tcg_gen_andi_tl(t3, t3, 0xffff0000);
+        tcg_gen_shri_tl(t2, t2, 16);
+        tcg_gen_or_tl(t3, t3, t2);
+        gen_store_mxu_gpr(t3, XRa);
+    }
 }
 
 /*
@@ -2374,6 +2438,24 @@ static void decode_opc_mxu__pool02(DisasContext *ctx)
     }
 }
 
+static void decode_opc_mxu__pool03(DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 24, 2);
+
+    switch (opcode) {
+    case OPC_MXU_D16MULF:
+        gen_mxu_d16mul(ctx, true, true);
+        break;
+    case OPC_MXU_D16MULE:
+        gen_mxu_d16mul(ctx, true, false);
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
@@ -2615,7 +2697,7 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
             decode_opc_mxu__pool00(ctx);
             break;
         case OPC_MXU_D16MUL:
-            gen_mxu_d16mul(ctx);
+            gen_mxu_d16mul(ctx, false, false);
             break;
         case OPC_MXU_D16MAC:
             gen_mxu_d16mac(ctx);
@@ -2626,6 +2708,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU__POOL02:
             decode_opc_mxu__pool02(ctx);
             break;
+        case OPC_MXU__POOL03:
+            decode_opc_mxu__pool03(ctx);
+            break;
         case OPC_MXU__POOL04:
             decode_opc_mxu__pool04(ctx);
             break;
-- 
2.40.0


