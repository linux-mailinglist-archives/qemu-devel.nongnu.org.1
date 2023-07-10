Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 315EB74E13B
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:33:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzN7-000151-KP; Mon, 10 Jul 2023 18:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzN5-0000uX-TR
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:43 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzN3-00023w-AB
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:43 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-314313f127fso5207800f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028119; x=1691620119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+wp+sjHHgL9R8LRSHFq7OIwpxhd2bBWYkZc/QFRjA1g=;
 b=BT8bZqNkzZXtyVMnSY7q4DcTn2OuJLtCUu1kPOlJd3hfdI4pCVtgts1SDVFDy3f5Lc
 9dia1GxmmWUGprVhGkClXQaOEKcFk+a8H1dhFhxkdpykifeyutNeeH/fFKXeOIClQfZU
 VgyfAAMyOUURM15VtfpaXbXXBYqsi2D4RDba49sKqEzES+ciNDm1gpSl/26oDu5LM95e
 3ljZ1J0cby+rn7+VwA9ZoNSoJqKsQfSvb72/zhel79g6k432U/cqsFvpYQU0e1UPHlTH
 OsdqCf3e+HQAvqK7nShq08oQmzXuM1Nd8bT/tHEIi8yNcB2allbUM3K70Ed0rsQ2sczN
 9vjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028119; x=1691620119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+wp+sjHHgL9R8LRSHFq7OIwpxhd2bBWYkZc/QFRjA1g=;
 b=NfpKYdEF106z2T7mI8zKpBAyYqKRe9JJCBZMLh3SNcWbymTfIICdGcmHCQzFjZ/dhC
 sSVFinCHzdDRRsp1VpRxMEAR7ALX00phe8/MThjNtzC+EPqzqiCo6P56ysDw13yakVEa
 oWYHd6zAMkQY3vwDgYaC98+WZemjEJNi+Lt87r/pVN6Uarjz4y1C3SSkOdrz6q719Mu6
 DccP6l2KRSTihoomrx8O/wGY2zk2KYOEmG3tnhEo9tpMw8YfoflSd7vbL8HqO+cPH6fq
 zH6v0rJQgNwd2BR6FJPVUaPN3kWu3UojFvaMtIWcdkqtb6DfIl6iKgIXbl0IbUYyTqb/
 EkmQ==
X-Gm-Message-State: ABy/qLZDaJtNHl3n95osplw5PQTvZOaMHtQUuK95k9UbLhD2ZAk7fKFx
 oh2hpOgECKxgenC1zSM3qnZIX9u2O7X8XjqZA87V3A==
X-Google-Smtp-Source: APBJJlEbm6xQV6tmqIhjFMl+liQqdMH72DzbI7smV3UxUwq9jBmj1xaRG63XrNQVO9r/o3ZU7RG78g==
X-Received: by 2002:adf:f5cf:0:b0:313:f4ea:4d97 with SMTP id
 k15-20020adff5cf000000b00313f4ea4d97mr13156115wrp.23.1689028119462; 
 Mon, 10 Jul 2023 15:28:39 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 a3-20020a5d5703000000b003143cb109d5sm544865wrv.14.2023.07.10.15.28.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:28:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 27/44] target/mips/mxu: Add D32SARL D32SARW instructions
Date: Tue, 11 Jul 2023 00:25:54 +0200
Message-Id: <20230710222611.50978-28-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

These instructions are dual 32-bit arithmetic shift right and
pack LSBs to 2x 16-bit into a MXU register.
The difference is the shift amount source: immediate or GP reg.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-25-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 59 +++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 4f07201fcc..36fb4232cd 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -394,6 +394,7 @@ enum {
     OPC_MXU_S16SDI   = 0x2D,
     OPC_MXU_S32M2I   = 0x2E,
     OPC_MXU_S32I2M   = 0x2F,
+    OPC_MXU_D32SARL  = 0x32,
     OPC_MXU__POOL19  = 0x38,
 };
 
@@ -492,6 +493,7 @@ enum {
  * MXU pool 16
  */
 enum {
+    OPC_MXU_D32SARW  = 0x00,
     OPC_MXU_S32ALN   = 0x01,
     OPC_MXU_S32ALNI  = 0x02,
     OPC_MXU_S32LUI   = 0x03,
@@ -1689,6 +1691,57 @@ static void gen_mxu_S32XOR(DisasContext *ctx)
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
@@ -4003,6 +4056,9 @@ static void decode_opc_mxu__pool16(DisasContext *ctx)
     uint32_t opcode = extract32(ctx->opcode, 18, 3);
 
     switch (opcode) {
+    case OPC_MXU_D32SARW:
+        gen_mxu_d32sarl(ctx, true);
+        break;
     case OPC_MXU_S32ALN:
         gen_mxu_S32ALN(ctx);
         break;
@@ -4214,6 +4270,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
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
2.38.1


