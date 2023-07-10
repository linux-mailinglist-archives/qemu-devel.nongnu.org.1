Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A3E74E12A
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:32:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzNN-0002HR-0v; Mon, 10 Jul 2023 18:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzNK-0002Ex-G0
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:58 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzNI-00024w-IH
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:58 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5746cso57974525e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028135; x=1691620135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vYeMIHzHX1cHcnWJO9AChRg0C7l8GR/aS1YwDn2EvQs=;
 b=oivgdqHOnuuHbcxanvFuHsTbFHL3Pb62/ONsHxgM/K/RFgQmg9iIUV3oKWhzgQ9VTs
 jLe2H7vwZ0xVu0C1joldFU8wGpGeMo8T5BuawYsAYamS6/jn5g66in8tq91v3QDQz7Xd
 GRf5FnGvtx6x4oDFShvA2pgUX1ojq4otaFRFqIdc4yKz43mcHQDTaqDatfxnEz3+NUm4
 UeB+0wQOXmsdiD3esjOxd6sFIiH1FY2ggYXaE4jC/ukDFw+L7hLCrSxtl0qkr4R8T6xx
 uGN3DuxPzcjw3RszYzwnhYmCQTSDdRAuzeV16aw0k2P9Qh+vapBycj67DO1KOMN5DPJE
 G3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028135; x=1691620135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vYeMIHzHX1cHcnWJO9AChRg0C7l8GR/aS1YwDn2EvQs=;
 b=YYvztORuvmDwVelNu/h/dvdlppqRh2vBaxnUZU+4ExcIkAKrAxsVQ8XP2cmO0j6U6M
 u/iQDvBMSHQFlpj+IGYBr6rpwOQzIIKCzwsm8vQZyhCWvXeumq8tpAQQELQi70xE9b0h
 SGYH0ree2SUgovhGDavcqAH8C/FrfxnppWXkh3Mu/06xGiPY+j/Ann5XwjIBmvAo/FZh
 hAF6xRDUWJCgHtkcgvwIQb5Z/K7s0iB7JzPqBbAvWqNlEFr0R7F2INV7JgO3YhdVm+n5
 VMFAgXjqeLqOj/P87gi6kOaGpy5Dvo9tC3RZSVFVcoCiYCAL3JDrv3WzP9Pk9WAmxlXJ
 bkxw==
X-Gm-Message-State: ABy/qLYAMwEk5ylbied5LRuPS0cIDzLyQhS7WRiOsBTyWl1n8YqBN1YG
 CFSpS5m5wb966TLwj1yhP7lxaNLsKSulBFIivZb9KA==
X-Google-Smtp-Source: APBJJlE5dRtmZ97Atd3EgB8QXoirxU81Pwryi2CZOzwi1y7a1DyY2z/raQf8kbkVm6iZV3ydpqK6TQ==
X-Received: by 2002:a05:600c:251:b0:3fb:e4ce:cc7a with SMTP id
 17-20020a05600c025100b003fbe4cecc7amr13536246wmj.0.1689028134920; 
 Mon, 10 Jul 2023 15:28:54 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 p6-20020a7bcc86000000b003fa95890484sm890875wma.20.2023.07.10.15.28.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:28:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 30/44] target/mips/mxu: Add D32/Q16- SLLV/SLRV/SARV instructions
Date: Tue, 11 Jul 2023 00:25:57 +0200
Message-Id: <20230710222611.50978-31-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

These instructions are counterparts for D32/Q16-SLL/SLR/SAR with
difference that the shift amount placed into GPR.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-28-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 166 +++++++++++++++++++++++++++++++-
 1 file changed, 162 insertions(+), 4 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 672b0041b5..32fc236d87 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -318,10 +318,10 @@
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
@@ -400,6 +400,7 @@ enum {
     OPC_MXU_D32SAR   = 0x33,
     OPC_MXU_Q16SLL   = 0x34,
     OPC_MXU_Q16SLR   = 0x35,
+    OPC_MXU__POOL18  = 0x36,
     OPC_MXU_Q16SAR   = 0x37,
     OPC_MXU__POOL19  = 0x38,
 };
@@ -520,6 +521,18 @@ enum {
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
@@ -1750,6 +1763,50 @@ static void gen_mxu_d32sxx(DisasContext *ctx, bool right, bool arithmetic)
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
@@ -1858,6 +1915,74 @@ static void gen_mxu_q16sxx(DisasContext *ctx, bool right, bool arithmetic)
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
@@ -4236,6 +4361,36 @@ static void decode_opc_mxu__pool17(DisasContext *ctx)
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
@@ -4400,6 +4555,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
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
2.38.1


