Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8D174E10B
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:28:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzMm-0007xK-VA; Mon, 10 Jul 2023 18:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzMl-0007tK-8g
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:23 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzMi-0001zS-IZ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:22 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbc59de009so53097905e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028099; x=1691620099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQthq4rjmEx3k6hdMx4Zv3YTZEjHKOj7dC7fmyz9pe0=;
 b=TnqrhNvdtMJ/Du9kKZTHxZ5Yb7U1+bFf5E5x7cpr/Qi/vh2XC+FILXUlgsKnPO5hVx
 WduGNQEXQafdxRkW9AHgPwMH9sAlIyFkSv6EfsFSdVgnjdUv4egq/yEMsix3sk/aCSGp
 uNt76JP015fYNC5KHu4Ghk1bqj+Q69wBnm+7xY0UyrDHuWk+7OTqQJckmLhMuoXs8d3j
 OErlcLGZJTr2QQSOLsXqH/BERHj37TFfNvZVoRlvyJX2MlJsWF+X5VTTv7BGCRZPrRtA
 hT9Tbt1oRUA/6ytKWMcXHrXEo8KUe6Z+UP58eWyhco0nnOIHjZVdZyQkfwzs8I0wpnC1
 2Skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028099; x=1691620099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQthq4rjmEx3k6hdMx4Zv3YTZEjHKOj7dC7fmyz9pe0=;
 b=b1GQExFf58DTdt5iu92pjJGa3jwyV4ZDbwBPdg0ypVeNPaD8sliVCTrNwCex3vATJY
 dxMguhU4y/iLHRAQuMg5pZexf3511mAKEZ9KoFXiTRle38qAu0+Vk9XTCsq0a8PBJ3om
 nnZiScH1l+uS03GPElA+zUyyzJ+0mdOPqT0kSp6h7lrUF7TM99wefqkD1NIxP7rBUDPG
 yV0izRJRMAuYEOkP5I2ijysMAniaV+yL5iHl3CR10Kq6jY/weNFaI2dRkSKtkn5T4rQL
 wx/q6ENgNQX4cImLhKc1L1GnU7ef+pZKlmVcmC2XmZI6AFEa7cPSW+HuXXxuqtR66qc1
 2jNw==
X-Gm-Message-State: ABy/qLYcNdVFQm68k8754N7UiL5/Hcj3WXTG1NKAXiTOFZLFOOUy6O+3
 VnxlKcFgwm/IuWqXyQTVzoLWbrGZ2RsgFHS1MopzRw==
X-Google-Smtp-Source: APBJJlGdyzUZuAzmjN0XsqcPD5a0xFQ9AvG9MaB09pGHUoYtU4rLr7yEFewCAEX4pO0y9MFWi0MSTg==
X-Received: by 2002:a7b:ce0f:0:b0:3f9:b87c:10db with SMTP id
 m15-20020a7bce0f000000b003f9b87c10dbmr11647072wmc.3.1689028098724; 
 Mon, 10 Jul 2023 15:28:18 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 y23-20020a1c4b17000000b003fbd0c50ba2sm11323365wma.32.2023.07.10.15.28.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:28:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 23/44] target/mips/mxu: Add S8STD S8LDI S8SDI instructions
Date: Tue, 11 Jul 2023 00:25:50 +0200
Message-Id: <20230710222611.50978-24-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

These instructions are all load/store a byte from memory
and put it into/get it from MXU register in various combinations.
I-suffix instructions modify the base address GPR by offset provided.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-21-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 74 ++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 5556fd152d..dcb0e13f93 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -382,6 +382,9 @@ enum {
     OPC_MXU__POOL14  = 0x1C,
     OPC_MXU_Q8ACCE   = 0x1D,
     OPC_MXU_S8LDD    = 0x22,
+    OPC_MXU_S8STD    = 0x23,
+    OPC_MXU_S8LDI    = 0x24,
+    OPC_MXU_S8SDI    = 0x25,
     OPC_MXU__POOL16  = 0x27,
     OPC_MXU__POOL17  = 0x28,
     OPC_MXU_S32M2I   = 0x2E,
@@ -633,8 +636,11 @@ static void gen_mxu_s32m2i(DisasContext *ctx)
 
 /*
  * S8LDD XRa, Rb, s8, optn3 - Load a byte from memory to XRF
+ *
+ * S8LDI XRa, Rb, s8, optn3 - Load a byte from memory to XRF,
+ * post modify address register
  */
-static void gen_mxu_s8ldd(DisasContext *ctx)
+static void gen_mxu_s8ldd(DisasContext *ctx, bool postmodify)
 {
     TCGv t0, t1;
     uint32_t XRa, Rb, s8, optn3;
@@ -649,6 +655,9 @@ static void gen_mxu_s8ldd(DisasContext *ctx)
 
     gen_load_gpr(t0, Rb);
     tcg_gen_addi_tl(t0, t0, (int8_t)s8);
+    if (postmodify) {
+        gen_store_gpr(t0, Rb);
+    }
 
     switch (optn3) {
     /* XRa[7:0] = tmp8 */
@@ -705,6 +714,58 @@ static void gen_mxu_s8ldd(DisasContext *ctx)
     gen_store_mxu_gpr(t0, XRa);
 }
 
+/*
+ * S8STD XRa, Rb, s8, optn3 - Store a byte from XRF to memory
+ *
+ * S8SDI XRa, Rb, s8, optn3 - Store a byte from XRF to memory,
+ * post modify address register
+ */
+static void gen_mxu_s8std(DisasContext *ctx, bool postmodify)
+{
+    TCGv t0, t1;
+    uint32_t XRa, Rb, s8, optn3;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+
+    XRa = extract32(ctx->opcode, 6, 4);
+    s8 = extract32(ctx->opcode, 10, 8);
+    optn3 = extract32(ctx->opcode, 18, 3);
+    Rb = extract32(ctx->opcode, 21, 5);
+
+    if (optn3 > 3) {
+        /* reserved, do nothing */
+        return;
+    }
+
+    gen_load_gpr(t0, Rb);
+    tcg_gen_addi_tl(t0, t0, (int8_t)s8);
+    if (postmodify) {
+        gen_store_gpr(t0, Rb);
+    }
+    gen_load_mxu_gpr(t1, XRa);
+
+    switch (optn3) {
+    /* XRa[7:0] => tmp8 */
+    case MXU_OPTN3_PTN0:
+        tcg_gen_extract_tl(t1, t1, 0, 8);
+        break;
+    /* XRa[15:8] => tmp8 */
+    case MXU_OPTN3_PTN1:
+        tcg_gen_extract_tl(t1, t1, 8, 8);
+        break;
+    /* XRa[23:16] => tmp8 */
+    case MXU_OPTN3_PTN2:
+        tcg_gen_extract_tl(t1, t1, 16, 8);
+        break;
+    /* XRa[31:24] => tmp8 */
+    case MXU_OPTN3_PTN3:
+        tcg_gen_extract_tl(t1, t1, 24, 8);
+        break;
+    }
+
+    tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_UB);
+}
 /*
  * D16MUL  XRa, XRb, XRc, XRd, optn2 - Signed 16 bit pattern multiplication
  * D16MULF XRa, XRb, XRc, optn2 - Signed Q15 fraction pattern multiplication
@@ -3707,7 +3768,16 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
             gen_mxu_q8adde(ctx, true);
             break;
         case OPC_MXU_S8LDD:
-            gen_mxu_s8ldd(ctx);
+            gen_mxu_s8ldd(ctx, false);
+            break;
+        case OPC_MXU_S8STD:
+            gen_mxu_s8std(ctx, false);
+            break;
+        case OPC_MXU_S8LDI:
+            gen_mxu_s8ldd(ctx, true);
+            break;
+        case OPC_MXU_S8SDI:
+            gen_mxu_s8std(ctx, true);
             break;
         case OPC_MXU__POOL16:
             decode_opc_mxu__pool16(ctx);
-- 
2.38.1


