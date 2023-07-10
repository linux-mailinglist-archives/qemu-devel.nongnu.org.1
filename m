Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CA474E118
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:30:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzMR-0006Ns-DD; Mon, 10 Jul 2023 18:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzMP-0006LK-Pw
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:01 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzMN-0001sD-WC
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:01 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbef8ad9bbso56165815e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028078; x=1691620078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZdZ4gNf3XP6DiS9UM8yuMmk3g2CgY2vf17KOgAxSDJA=;
 b=q/NxL+0ImGqujRHLBG4sLqeKUzonCBf98HOhp+nAaC8QAg2X/SsZFRrfUfczUa4uaZ
 rq0aD5sbqjXDc+hTAAfCHO2QaJDlcXvlbjm2ujYOKgbhqZQZiP4bigsY8wI+Je8XdHIV
 SIzGawf+bqYzaird60qDVA7VdkY8GgurdHS7FfKL3geXIcRpWYpBw1UHoeu9CbEKwHL3
 YGAEWetnQgjxEkQzqMRXcIJ9H85obi7bDjW9Gy/cybJpLcObMMUPymZTsSngC6l/sN6X
 zMPAIoiBkH/b5nqRvpbaTN/HtCT1A3qLONbHuFul4aXy6B4izCg5R2QLzXLdhVfKH0Ru
 6BFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028078; x=1691620078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZdZ4gNf3XP6DiS9UM8yuMmk3g2CgY2vf17KOgAxSDJA=;
 b=TZELiTW+kGE0A0HODilEkPZKYv3HXg3r0Z9iwEFBWiY2uzTDe/D/Z3ybqOhpzb/7Zt
 Aj94L74wy+RM1o6EmAKB4mMae5IB55c3Dx0EZIPTpEllbpk+/A820kFpFiJukc1N2a8z
 CV9y7TOfalMz8OO8nD8uFxoyxNhYE9rnpYHj0McxlQcXn7pRfKgzpBILcJHIrT2VbQhE
 GxqMaQnK5pbBLWTE38y9xrduQG3D2POEW6BV/PNd8p7OjrlfoQwvLW9qSE1rVZ8JOi8B
 9cqi7SEBqGrt2c9kl7w62FpjrQRCdxBvWFjyA7PIMPXeQxewsTHhVohTO3B1ANnc8kzy
 zm6Q==
X-Gm-Message-State: ABy/qLaJRr80XVgN8jMW1V68lDL5klv80wyPnTO34hhMJ/3bjeMFEASZ
 rBxBOb+/6NG+g9fTKYur0AGafMEM6fYDPBiTG0eN4Q==
X-Google-Smtp-Source: APBJJlGS1jUiwNIAFEb9n1lMcdjhhMzSW1zpib77MEV8BYtwfO8jJcbmsqZzOB9LxMGH6MRCMBrpsw==
X-Received: by 2002:a5d:6590:0:b0:314:db7:d132 with SMTP id
 q16-20020a5d6590000000b003140db7d132mr14235563wru.61.1689028078368; 
 Mon, 10 Jul 2023 15:27:58 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 j16-20020a5d4650000000b0031435c2600esm518482wrs.79.2023.07.10.15.27.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:27:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 19/44] target/mips/mxu: Add D32ACC D32ACCM D32ASUM instructions
Date: Tue, 11 Jul 2023 00:25:46 +0200
Message-Id: <20230710222611.50978-20-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

These instructions are all dual 32-bit addition/subtraction in
various combinations. The instructions are grouped in pool12,
see the opcode organization in the file.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-17-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 160 ++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index b133f9f11d..82a07040c6 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -377,6 +377,7 @@ enum {
     OPC_MXU__POOL10  = 0x16,
     OPC_MXU__POOL11  = 0x17,
     OPC_MXU_D32ADD   = 0x18,
+    OPC_MXU__POOL12  = 0x19,
     OPC_MXU_S8LDD    = 0x22,
     OPC_MXU__POOL16  = 0x27,
     OPC_MXU__POOL17  = 0x28,
@@ -439,6 +440,15 @@ enum {
     OPC_MXU_S32LDSTR = 0x01,
 };
 
+/*
+ * MXU pool 12
+ */
+enum {
+    OPC_MXU_D32ACC    = 0x00,
+    OPC_MXU_D32ACCM   = 0x01,
+    OPC_MXU_D32ASUM   = 0x02,
+};
+
 /*
  * MXU pool 16
  */
@@ -2308,6 +2318,132 @@ static void gen_mxu_d32add(DisasContext *ctx)
     }
 }
 
+/*
+ * D32ACC XRa, XRb, XRc, XRd, aptn2 - Double
+ * 32 bit pattern addition/subtraction and accumulate.
+ */
+static void gen_mxu_d32acc(DisasContext *ctx)
+{
+    uint32_t aptn2, XRc, XRb, XRa, XRd;
+
+    aptn2 = extract32(ctx->opcode, 24, 2);
+    XRd   = extract32(ctx->opcode, 18, 4);
+    XRc   = extract32(ctx->opcode, 14, 4);
+    XRb   = extract32(ctx->opcode, 10, 4);
+    XRa   = extract32(ctx->opcode,  6, 4);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+
+    if (unlikely(XRa == 0 && XRd == 0)) {
+        /* destinations are zero register -> do nothing */
+    } else {
+        /* common case */
+        gen_load_mxu_gpr(t0, XRb);
+        gen_load_mxu_gpr(t1, XRc);
+        if (XRa != 0) {
+            if (aptn2 & 2) {
+                tcg_gen_sub_tl(t2, t0, t1);
+            } else {
+                tcg_gen_add_tl(t2, t0, t1);
+            }
+            tcg_gen_add_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t2);
+        }
+        if (XRd != 0) {
+            if (aptn2 & 1) {
+                tcg_gen_sub_tl(t2, t0, t1);
+            } else {
+                tcg_gen_add_tl(t2, t0, t1);
+            }
+            tcg_gen_add_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t2);
+        }
+    }
+}
+
+/*
+ * D32ACCM XRa, XRb, XRc, XRd, aptn2 - Double
+ * 32 bit pattern addition/subtraction and accumulate.
+ */
+static void gen_mxu_d32accm(DisasContext *ctx)
+{
+    uint32_t aptn2, XRc, XRb, XRa, XRd;
+
+    aptn2 = extract32(ctx->opcode, 24, 2);
+    XRd   = extract32(ctx->opcode, 18, 4);
+    XRc   = extract32(ctx->opcode, 14, 4);
+    XRb   = extract32(ctx->opcode, 10, 4);
+    XRa   = extract32(ctx->opcode,  6, 4);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+
+    if (unlikely(XRa == 0 && XRd == 0)) {
+        /* destinations are zero register -> do nothing */
+    } else {
+        /* common case */
+        gen_load_mxu_gpr(t0, XRb);
+        gen_load_mxu_gpr(t1, XRc);
+        if (XRa != 0) {
+            tcg_gen_add_tl(t2, t0, t1);
+            if (aptn2 & 2) {
+                tcg_gen_sub_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t2);
+            } else {
+                tcg_gen_add_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t2);
+            }
+        }
+        if (XRd != 0) {
+            tcg_gen_sub_tl(t2, t0, t1);
+            if (aptn2 & 1) {
+                tcg_gen_sub_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t2);
+            } else {
+                tcg_gen_add_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t2);
+            }
+        }
+    }
+}
+
+/*
+ * D32ASUM XRa, XRb, XRc, XRd, aptn2 - Double
+ * 32 bit pattern addition/subtraction.
+ */
+static void gen_mxu_d32asum(DisasContext *ctx)
+{
+    uint32_t aptn2, XRc, XRb, XRa, XRd;
+
+    aptn2 = extract32(ctx->opcode, 24, 2);
+    XRd   = extract32(ctx->opcode, 18, 4);
+    XRc   = extract32(ctx->opcode, 14, 4);
+    XRb   = extract32(ctx->opcode, 10, 4);
+    XRa   = extract32(ctx->opcode,  6, 4);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+
+    if (unlikely(XRa == 0 && XRd == 0)) {
+        /* destinations are zero register -> do nothing */
+    } else {
+        /* common case */
+        gen_load_mxu_gpr(t0, XRb);
+        gen_load_mxu_gpr(t1, XRc);
+        if (XRa != 0) {
+            if (aptn2 & 2) {
+                tcg_gen_sub_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+            } else {
+                tcg_gen_add_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+            }
+        }
+        if (XRd != 0) {
+            if (aptn2 & 1) {
+                tcg_gen_sub_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t1);
+            } else {
+                tcg_gen_add_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t1);
+            }
+        }
+    }
+}
+
 /*
  *                 MXU instruction category: Miscellaneous
  *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -2930,6 +3066,27 @@ static void decode_opc_mxu__pool11(DisasContext *ctx)
     }
 }
 
+static void decode_opc_mxu__pool12(DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 22, 2);
+
+    switch (opcode) {
+    case OPC_MXU_D32ACC:
+        gen_mxu_d32acc(ctx);
+        break;
+    case OPC_MXU_D32ACCM:
+        gen_mxu_d32accm(ctx);
+        break;
+    case OPC_MXU_D32ASUM:
+        gen_mxu_d32asum(ctx);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        gen_reserved_instruction(ctx);
+        break;
+    }
+}
+
 static void decode_opc_mxu__pool16(DisasContext *ctx)
 {
     uint32_t opcode = extract32(ctx->opcode, 18, 3);
@@ -3095,6 +3252,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU_D32ADD:
             gen_mxu_d32add(ctx);
             break;
+        case OPC_MXU__POOL12:
+            decode_opc_mxu__pool12(ctx);
+            break;
         case OPC_MXU_S8LDD:
             gen_mxu_s8ldd(ctx);
             break;
-- 
2.38.1


