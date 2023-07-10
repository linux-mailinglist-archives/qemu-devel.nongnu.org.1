Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB90774E105
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:27:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzLk-0003pm-NV; Mon, 10 Jul 2023 18:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLi-0003nr-F4
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:18 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLg-0001mv-Ra
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:18 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3142ee41fd2so5090732f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028035; x=1691620035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlOVLh0VbIxlNWq6zZht8cBZYeoWPrgyVYcBv1fu/3w=;
 b=HX9YgduLVXDtk1ZKMunEFgE7s6FdcK3lPXrl8kJuZ62UfhbBTGGh0GePHruZRKM54K
 0aB9R/DfnQHXVEycOjwCC1I0OpPp32xh9Ms5xoIZC9ODv+IlIYeeNdHoMrSj6HTXnPEM
 cZh7ABKyUkx5PeMGZNvZeB3oO7u3D6YUmuZAIr79WJcc1VoTNypnFj2pzr6ebPYY1t2t
 5bPvNn+8bC+oeNY0VOpFqAUNYYgLeAxphspczxo/VS/9+rJ8eUYAwslGsfVAqjvfzPq4
 c4By9tEhvX0wfnB9S0nc9CVaLsXuxcq1+9c6XuxgzkyNrJ7LDFzIIKlmujtnOms5e4cJ
 ee9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028035; x=1691620035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KlOVLh0VbIxlNWq6zZht8cBZYeoWPrgyVYcBv1fu/3w=;
 b=fdzbJhHDCX2eX0T1pKyfWG+OfDhPXVY++qZ0GfkHrrS0vwJOU9Cc7hSIh4DRVU65Iw
 vAgSgbdCilzJ5oH0952xmXA1vN6Iha+s3Z9Z/L6agwAFREvRY5xAt4g1q3NOMhIzC0us
 ePYjnSNdO85t8Io7So3/u/Uwn5ee/ueoPg7jZHXUYnoubnLkynBtHqM3Kf9rj2T6jCj7
 kEmXcX6svV/IL3j+SHDtwjsuFz3ylDVFzXohQdJJEX21GqxJxJnwRRo4Rn1lphnY+n4y
 h6C0xnmfaeNXMyKjVktA6pyW8iHAY2a2mOi0O9uaaIMjny3xUFHyePtIxIFZwDAl58fb
 oeYw==
X-Gm-Message-State: ABy/qLYEQHJfppW8tstPTm7sGj2JC7PiMna+cuiFnRNRDMEB9GhtcBPn
 24ynmgW7TE/nGJfv4lbb8tcN0HNVC0OYbxtqgZHXqw==
X-Google-Smtp-Source: APBJJlFLcoHnvg4iGeD0nIE3IrSY5fcCTat95H5gRT5mtRwUTz+qNS+wdxAAnz0/6JMPaGIfWz4yDA==
X-Received: by 2002:a05:6000:18ce:b0:313:fe1b:f444 with SMTP id
 w14-20020a05600018ce00b00313fe1bf444mr12479741wrq.68.1689028035133; 
 Mon, 10 Jul 2023 15:27:15 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 f4-20020a5d4dc4000000b0031424f4ef1dsm542939wru.19.2023.07.10.15.27.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:27:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 11/44] target/mips/mxu: Add Q8ADD instruction
Date: Tue, 11 Jul 2023 00:25:38 +0200
Message-Id: <20230710222611.50978-12-philmd@linaro.org>
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

This instruction is used to add/subtract quadruple
8-bit values to another quadruple in parallel.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-9-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 77 +++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index f170195feb..034287e54b 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -402,6 +402,7 @@ enum {
     OPC_MXU_D16AVGR  = 0x03,
     OPC_MXU_Q8AVG    = 0x04,
     OPC_MXU_Q8AVGR   = 0x05,
+    OPC_MXU_Q8ADD    = 0x07,
 };
 
 /*
@@ -1673,6 +1674,79 @@ static void gen_mxu_q8avg(DisasContext *ctx, bool round45)
 }
 
 
+/*
+ *                 MXU instruction category: Arithmetic
+ *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *                       Q8ADD
+ */
+
+/*
+ *  Q8ADD XRa, XRb, XRc, ptn2
+ *  Add/subtract quadruple of 8-bit packed in XRb
+ *  to another one in XRc, put the result in XRa.
+ */
+static void gen_mxu_Q8ADD(DisasContext *ctx)
+{
+    uint32_t aptn2, pad, XRc, XRb, XRa;
+
+    aptn2 = extract32(ctx->opcode, 24, 2);
+    pad   = extract32(ctx->opcode, 21, 3);
+    XRc   = extract32(ctx->opcode, 14, 4);
+    XRb   = extract32(ctx->opcode, 10, 4);
+    XRa   = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to zero */
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
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
+
+        for (int i = 0; i < 4; i++) {
+            tcg_gen_andi_tl(t0, t3, 0xff);
+            tcg_gen_andi_tl(t1, t4, 0xff);
+
+            if (i < 2) {
+                if (aptn2 & 0x01) {
+                    tcg_gen_sub_tl(t0, t0, t1);
+                } else {
+                    tcg_gen_add_tl(t0, t0, t1);
+                }
+            } else {
+                if (aptn2 & 0x02) {
+                    tcg_gen_sub_tl(t0, t0, t1);
+                } else {
+                    tcg_gen_add_tl(t0, t0, t1);
+                }
+            }
+            if (i < 3) {
+                tcg_gen_shri_tl(t3, t3, 8);
+                tcg_gen_shri_tl(t4, t4, 8);
+            }
+            if (i > 0) {
+                tcg_gen_deposit_tl(t2, t2, t0, 8 * i, 8);
+            } else {
+                tcg_gen_andi_tl(t0, t0, 0xff);
+                tcg_gen_mov_tl(t2, t0);
+            }
+        }
+        gen_store_mxu_gpr(t2, XRa);
+    }
+}
+
+
 /*
  *                 MXU instruction category: align
  *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -2002,6 +2076,9 @@ static void decode_opc_mxu__pool01(DisasContext *ctx)
     case OPC_MXU_Q8AVGR:
         gen_mxu_q8avg(ctx, true);
         break;
+    case OPC_MXU_Q8ADD:
+        gen_mxu_Q8ADD(ctx);
+        break;
     default:
         MIPS_INVAL("decode_opc_mxu");
         gen_reserved_instruction(ctx);
-- 
2.38.1


