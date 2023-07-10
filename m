Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0564774E12F
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:33:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzM5-0003z6-UI; Mon, 10 Jul 2023 18:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLy-0003uL-6F
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:34 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLr-0001pB-KK
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:32 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3094910b150so5525843f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028046; x=1691620046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0FO2ha3etxMvQjKWnYnIqZK4pico0eQHriQkByVcS+E=;
 b=j4DF+mZJ7K27vE4VKQfBOwNHgX2/auzSpYWfJjwjdyBuOoT1j5exFabFia2odkeI6U
 MMVQTOWrpjp3s3byRj50l5vfTnj0ISu8cgv2EpHiT9fBqSpBS1/jBWZ0CmagrJ+A/Tqs
 I7XVuLRA02fmgvPWQRn0Q8oosNNzqtn4q3WqvWgkSozx32wLaDWVkqBqtpGbIqL8hkvl
 lT4Lw3f+yLuZNvhC0C4zHfn8aLlI9a52Eio66WbEguy+iC3jKqu771XI9rc52M/LQ4+G
 RoZ+aWPmnxrESu9IjnSB3IhjZV2DezSkbTAlJ5zkSAekJDs0CuUvDYjFJIhhATcZamsZ
 R14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028046; x=1691620046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0FO2ha3etxMvQjKWnYnIqZK4pico0eQHriQkByVcS+E=;
 b=Nk0jqu07zxaoIVCbIxvLfh+g5IiEefLpus6CYwpkz+pgz4DFD96zRff9cytXyKeC/I
 VrBFQcbHcOvaBXJKJ2qbdlbwMFKDoBNYQdOp4pTejp8W+sofVwG8tf7rr+aiUKEi3sD3
 K+jdrn9mD6Cu027wyoL1ji9azzVtFvd+ae7DuteLi0gtbGCBPZ6gY8aCEyMO1OIvwnIT
 uz+8jScGLdlJN7TtW9+zLRFY0R+K5qGgmeLfFjkFtM13GjESbd2Ae1Ex2Fe3yDjd1YJ7
 BDU+9zhrupb+e/xYXnjm/C6aZHvldYVWs0Do94R6GesZ9XViDaa8L09FPnRtmif9qV1J
 R1fQ==
X-Gm-Message-State: ABy/qLYCIGw2OmsJRWGrAEwwLWqvAJHc6TR/EuQOjK4EudHrth7uGJL/
 L8VctwT8GDB7SQf/ZRUkHOLw4WugLwjFFsEcmQFAsg==
X-Google-Smtp-Source: APBJJlFKnfFjherE5sm6RrhPVpbMoJnVaL0gnJ9kl4R0wr1XvHVqaj4XNQxLptEl4Je7AMN8sza2qQ==
X-Received: by 2002:a05:6000:1087:b0:314:dc0:2fca with SMTP id
 y7-20020a056000108700b003140dc02fcamr13612629wrw.29.1689028046115; 
 Mon, 10 Jul 2023 15:27:26 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 f6-20020adff586000000b003142eb75724sm541344wro.24.2023.07.10.15.27.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:27:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 13/44] target/mips/mxu: Add D16MULF D16MULE instructions
Date: Tue, 11 Jul 2023 00:25:40 +0200
Message-Id: <20230710222611.50978-14-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

These instructions are part of pool3, see the grand tree above
in the file.
The instructions are close to D16MUL so common generation function
provided.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-11-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 95 +++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 5 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 3bd5fcb98a..b683f3d95c 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -361,6 +361,7 @@ enum {
     OPC_MXU__POOL01  = 0x06,
     OPC_MXU__POOL02  = 0x07,
     OPC_MXU_D16MUL   = 0x08,
+    OPC_MXU__POOL03  = 0x09,
     OPC_MXU_D16MAC   = 0x0A,
     OPC_MXU__POOL04  = 0x10,
     OPC_MXU__POOL05  = 0x11,
@@ -416,6 +417,14 @@ enum {
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
@@ -660,9 +669,14 @@ static void gen_mxu_s8ldd(DisasContext *ctx)
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
@@ -678,6 +692,12 @@ static void gen_mxu_d16mul(DisasContext *ctx)
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
@@ -703,8 +723,52 @@ static void gen_mxu_d16mul(DisasContext *ctx)
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
@@ -2372,6 +2436,24 @@ static void decode_opc_mxu__pool02(DisasContext *ctx)
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
@@ -2613,7 +2695,7 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
             decode_opc_mxu__pool00(ctx);
             break;
         case OPC_MXU_D16MUL:
-            gen_mxu_d16mul(ctx);
+            gen_mxu_d16mul(ctx, false, false);
             break;
         case OPC_MXU_D16MAC:
             gen_mxu_d16mac(ctx);
@@ -2624,6 +2706,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
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
2.38.1


