Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 230CE74E112
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:29:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzM8-0004GU-Eh; Mon, 10 Jul 2023 18:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLy-0003wC-T1
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:36 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLx-0001pp-4i
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:34 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-314319c0d3eso5457560f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028051; x=1691620051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nYkFz4+3J6+gMYy7zGAAByxRLT3tZPBqXFdIfL3YZhY=;
 b=jLzpWlDmGYMb3wWZP9PfPzWY+B7UXgZL9aCKfifz3KqOtfrkibdR7p1ECxQOrCJVNA
 IeWftKWH/Fh39AKaDouZSzKK3T9RRzKn5KKQx7atsUKTq6CX2wnZ/jIwUNN2ievx4PTf
 EXtllCN80htHGX+3sqJ2rabwtpdDCghGbdZmdFC3OMAigJqclsGEL7brNonblh+oZivS
 FpCBtdK55X8pQ4Z8Ry8mTOLLMzJWE+hzFvXsr70p8lRILNI177ih1iOAwvA3wuqYFjwe
 5DQ+vRZmLDkwRy8f5bGo5VSmvpaErOcGjLEuwppRRwDdjT7jJY17oZaIyzPDZvKLnBan
 nKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028051; x=1691620051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nYkFz4+3J6+gMYy7zGAAByxRLT3tZPBqXFdIfL3YZhY=;
 b=TM743kN+Pmk9jU3oyG+YxOt26dA5OUXhW6omh0GjpzbTSnRB36lgjEG2H2WH5kCtAU
 A5sZD8+8sRT/Nnk7ao6E4zJhcuyjca0TEeIUkjVfq/PXbFnz4iV5+ZyzsSAOF6Kfubfb
 Rled9TK84GCZDb3NQioaTdx3vrEx8oCCwDmpq5GCXn3IYcpOIeFWJxDPvFVv5JD45Y5+
 C1me7qspUg1JeMNBOJeR/QAsnFzVE8P5/8VoOG8i+XDZ65VZKQj+0w7wwobuS2D54pBE
 xajQDbmzBphkZhG2gq4XT6xD4agwPdH4AK9i5f1B8blZyhPM5yE9D2nZNT7sDoFrlwRm
 h31A==
X-Gm-Message-State: ABy/qLZQAqK6KTadqGZ4jBnYvz71TYfahbEek/jtOW3gO2oaGXA96lit
 xJvF8ybqXi4+hKbKkLODkjn2UzekmWaoEmalIegstA==
X-Google-Smtp-Source: APBJJlHfwkrSLT+WGgwjZFg8LSITxCv1BF3erCkgmK2neQZsBBcHAXejjoa5ObqEFk9ileiWv5C3kg==
X-Received: by 2002:a05:6000:4e4:b0:313:f61c:42ab with SMTP id
 cr4-20020a05600004e400b00313f61c42abmr14709193wrb.56.1689028051737; 
 Mon, 10 Jul 2023 15:27:31 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 q15-20020adffecf000000b003142439c7bcsm515194wrs.80.2023.07.10.15.27.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:27:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 14/44] target/mips/mxu: Add D16MACF D16MACE instructions
Date: Tue, 11 Jul 2023 00:25:41 +0200
Message-Id: <20230710222611.50978-15-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

These instructions are close to D16MAC so common generation function
provided.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-12-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 74 ++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 6 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index b683f3d95c..b58fad4436 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -363,6 +363,8 @@ enum {
     OPC_MXU_D16MUL   = 0x08,
     OPC_MXU__POOL03  = 0x09,
     OPC_MXU_D16MAC   = 0x0A,
+    OPC_MXU_D16MACF  = 0x0B,
+    OPC_MXU_D16MACE  = 0x0F,
     OPC_MXU__POOL04  = 0x10,
     OPC_MXU__POOL05  = 0x11,
     OPC_MXU__POOL06  = 0x12,
@@ -772,10 +774,15 @@ static void gen_mxu_d16mul(DisasContext *ctx, bool fractional,
 }
 
 /*
- * D16MAC XRa, XRb, XRc, XRd, aptn2, optn2 - Signed 16 bit pattern multiply
- *                                           and accumulate
+ * D16MAC XRa, XRb, XRc, XRd, aptn2, optn2
+ *   Signed 16 bit pattern multiply and accumulate
+ * D16MACF XRa, XRb, XRc, aptn2, optn2
+ *   Signed Q15 fraction pattern multiply accumulate and pack
+ * D16MACE XRa, XRb, XRc, XRd, aptn2, optn2
+ *   Signed Q15 fraction pattern multiply and accumulate
  */
-static void gen_mxu_d16mac(DisasContext *ctx)
+static void gen_mxu_d16mac(DisasContext *ctx, bool fractional,
+                           bool packed_result)
 {
     TCGv t0, t1, t2, t3;
     uint32_t XRa, XRb, XRc, XRd, optn2, aptn2;
@@ -818,6 +825,11 @@ static void gen_mxu_d16mac(DisasContext *ctx)
         tcg_gen_mul_tl(t2, t1, t2);
         break;
     }
+
+    if (fractional) {
+        tcg_gen_shli_tl(t3, t3, 1);
+        tcg_gen_shli_tl(t2, t2, 1);
+    }
     gen_load_mxu_gpr(t0, XRa);
     gen_load_mxu_gpr(t1, XRd);
 
@@ -839,8 +851,52 @@ static void gen_mxu_d16mac(DisasContext *ctx)
         tcg_gen_sub_tl(t2, t1, t2);
         break;
     }
-    gen_store_mxu_gpr(t3, XRa);
-    gen_store_mxu_gpr(t2, XRd);
+
+    if (fractional) {
+        TCGLabel *l_done = gen_new_label();
+        TCGv rounding = tcg_temp_new();
+
+        tcg_gen_andi_tl(rounding, mxu_CR, 0x2);
+        tcg_gen_brcondi_tl(TCG_COND_EQ, rounding, 0, l_done);
+        if (packed_result) {
+            TCGLabel *l_apply_bias_l = gen_new_label();
+            TCGLabel *l_apply_bias_r = gen_new_label();
+            TCGLabel *l_half_done = gen_new_label();
+            TCGv bias = tcg_temp_new();
+
+            /*
+             * D16MACF supports unbiased rounding aka "bankers rounding",
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
+            /* D16MACE doesn't support unbiased rounding */
+            tcg_gen_addi_tl(t3, t3, 0x8000);
+            tcg_gen_addi_tl(t2, t2, 0x8000);
+        }
+        gen_set_label(l_done);
+    }
+
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
@@ -2698,7 +2754,13 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
             gen_mxu_d16mul(ctx, false, false);
             break;
         case OPC_MXU_D16MAC:
-            gen_mxu_d16mac(ctx);
+            gen_mxu_d16mac(ctx, false, false);
+            break;
+        case OPC_MXU_D16MACF:
+            gen_mxu_d16mac(ctx, true, true);
+            break;
+        case OPC_MXU_D16MACE:
+            gen_mxu_d16mac(ctx, true, false);
             break;
         case OPC_MXU__POOL01:
             decode_opc_mxu__pool01(ctx);
-- 
2.38.1


