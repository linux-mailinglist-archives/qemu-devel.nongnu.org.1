Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB95674E110
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:29:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzMr-0008BT-6Z; Mon, 10 Jul 2023 18:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzMp-00089M-GB
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:27 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzMn-00021D-IK
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:27 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso4967252f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028104; x=1691620104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MuYh0Au2c1khtQa06fc1w+tPP6kd62N+ofg7GxEkmT8=;
 b=usPDuRauV6ECeLjYWoPq+nfzkW6sSwqn4ChDb/DCwR2JcHfQ9HCwXeBYQUJbyLDjqX
 pcKgLRzheuqfkCB86pgYaslhBaTevbY2mJtCUf7qqVv5rAEBGFSXt5f0bDMhohkUH9CL
 t2gumqBlOJJuCx0nrSCbW8iSEIqZOuf4JYHvxXGDVeeTKEH4nqNcezBnueoCi3nAocek
 Nz67F71tTYFpB0BfNwCx8IDWcbGBcYezz5mkbROeN2sKICQ7NWMXcE47/tmtXRrodAx7
 WELZRFP21/ZO+byAwvEKHEK5Q8zMXzzYONxQjY9+3V3GW70cXAsjTvJu3qM3Nkak+5LG
 lIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028104; x=1691620104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MuYh0Au2c1khtQa06fc1w+tPP6kd62N+ofg7GxEkmT8=;
 b=RqIFlZw6ffuvNJ2R13FjyV/JVI/ZeIgUz3wX5cnncU52fZKkiCvNKgHA5lErR1GucT
 Lgjucae0eEaD7oF1fduj4v5Pm3jxplaapLpOWWzDkcOCWqReXkOGMrI4BpYPYn4/hGVS
 6qT+uckJpXEYY/KAOtZhGskUnh/JhMVeyCtwfk0HXq618yQ+NoyD/9nr1au6eN1XIvtn
 1ouMcttANmppnAEfLKeYv42vzy6osLONr/L1qL8cNOjFRS0ru75089ZUZrcmZP9H6LDI
 YS4O4vPBs/oeB3GgDYWazyKV4rZlEY/IQcNAhztCr6EsL36TRciNS/HhMbUEHHLNKhAz
 ylHg==
X-Gm-Message-State: ABy/qLYh0Scfh+1/6HGYukGV1v+3MkyCPWXu9h89di52BUbZlla/ZL3r
 OCRnK6FJC606rUH8pDLEB20WqR3d0q7gm6SrU73Nqw==
X-Google-Smtp-Source: APBJJlEqSJRq12vc6im0ROnMYai6CrA4fD+wNOVFoeoJepIUo5hJfcteEBAM83Dm/FdVKfDlUZycKA==
X-Received: by 2002:a05:6000:4eb:b0:314:d8c:b881 with SMTP id
 cr11-20020a05600004eb00b003140d8cb881mr6580699wrb.70.1689028104083; 
 Mon, 10 Jul 2023 15:28:24 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 i16-20020adffdd0000000b0030fb4b55c13sm510772wrs.96.2023.07.10.15.28.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:28:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 24/44] target/mips/mxu: Add S16LDD S16STD S16LDI S16SDI
 instructions
Date: Tue, 11 Jul 2023 00:25:51 +0200
Message-Id: <20230710222611.50978-25-philmd@linaro.org>
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

These instructions are all load/store a halfword from memory
and put it into/get it from MXU register in various combinations.
I-suffix instructions modify the base address GPR by offset provided.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-22-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 117 ++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index dcb0e13f93..caf5257952 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -387,6 +387,10 @@ enum {
     OPC_MXU_S8SDI    = 0x25,
     OPC_MXU__POOL16  = 0x27,
     OPC_MXU__POOL17  = 0x28,
+    OPC_MXU_S16LDD   = 0x2A,
+    OPC_MXU_S16STD   = 0x2B,
+    OPC_MXU_S16LDI   = 0x2C,
+    OPC_MXU_S16SDI   = 0x2D,
     OPC_MXU_S32M2I   = 0x2E,
     OPC_MXU_S32I2M   = 0x2F,
     OPC_MXU__POOL19  = 0x38,
@@ -766,6 +770,107 @@ static void gen_mxu_s8std(DisasContext *ctx, bool postmodify)
 
     tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_UB);
 }
+
+/*
+ * S16LDD XRa, Rb, s10, optn2 - Load a halfword from memory to XRF
+ *
+ * S16LDI XRa, Rb, s10, optn2 - Load a halfword from memory to XRF,
+ * post modify address register
+ */
+static void gen_mxu_s16ldd(DisasContext *ctx, bool postmodify)
+{
+    TCGv t0, t1;
+    uint32_t XRa, Rb, optn2;
+    int32_t s10;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+
+    XRa   = extract32(ctx->opcode,   6, 4);
+    s10   = sextract32(ctx->opcode, 10, 9) * 2;
+    optn2 = extract32(ctx->opcode,  19, 2);
+    Rb    = extract32(ctx->opcode,  21, 5);
+
+    gen_load_gpr(t0, Rb);
+    tcg_gen_addi_tl(t0, t0, s10);
+    if (postmodify) {
+        gen_store_gpr(t0, Rb);
+    }
+
+    switch (optn2) {
+    /* XRa[15:0] = tmp16 */
+    case MXU_OPTN2_PTN0:
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UW);
+        gen_load_mxu_gpr(t0, XRa);
+        tcg_gen_deposit_tl(t0, t0, t1, 0, 16);
+        break;
+    /* XRa[31:16] = tmp16 */
+    case MXU_OPTN2_PTN1:
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UW);
+        gen_load_mxu_gpr(t0, XRa);
+        tcg_gen_deposit_tl(t0, t0, t1, 16, 16);
+        break;
+    /* XRa = sign_extend(tmp16) */
+    case MXU_OPTN2_PTN2:
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_SW);
+        break;
+    /* XRa = {tmp16, tmp16} */
+    case MXU_OPTN2_PTN3:
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UW);
+        tcg_gen_deposit_tl(t0, t1, t1,  0, 16);
+        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
+        break;
+    }
+
+    gen_store_mxu_gpr(t0, XRa);
+}
+
+/*
+ * S16STD XRa, Rb, s8, optn2 - Store a byte from XRF to memory
+ *
+ * S16SDI XRa, Rb, s8, optn2 - Store a byte from XRF to memory,
+ * post modify address register
+ */
+static void gen_mxu_s16std(DisasContext *ctx, bool postmodify)
+{
+    TCGv t0, t1;
+    uint32_t XRa, Rb, optn2;
+    int32_t s10;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+
+    XRa = extract32(ctx->opcode, 6, 4);
+    s10 = sextract32(ctx->opcode, 10, 9) * 2;
+    optn2 = extract32(ctx->opcode, 19, 2);
+    Rb = extract32(ctx->opcode, 21, 5);
+
+    if (optn2 > 1) {
+        /* reserved, do nothing */
+        return;
+    }
+
+    gen_load_gpr(t0, Rb);
+    tcg_gen_addi_tl(t0, t0, s10);
+    if (postmodify) {
+        gen_store_gpr(t0, Rb);
+    }
+    gen_load_mxu_gpr(t1, XRa);
+
+    switch (optn2) {
+    /* XRa[15:0] => tmp16 */
+    case MXU_OPTN2_PTN0:
+        tcg_gen_extract_tl(t1, t1, 0, 16);
+        break;
+    /* XRa[31:16] => tmp16 */
+    case MXU_OPTN2_PTN1:
+        tcg_gen_extract_tl(t1, t1, 16, 16);
+        break;
+    }
+
+    tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_UW);
+}
+
 /*
  * D16MUL  XRa, XRb, XRc, XRd, optn2 - Signed 16 bit pattern multiplication
  * D16MULF XRa, XRb, XRc, optn2 - Signed Q15 fraction pattern multiplication
@@ -3785,6 +3890,18 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU__POOL17:
             decode_opc_mxu__pool17(ctx);
             break;
+        case OPC_MXU_S16LDD:
+            gen_mxu_s16ldd(ctx, false);
+            break;
+        case OPC_MXU_S16STD:
+            gen_mxu_s16std(ctx, false);
+            break;
+        case OPC_MXU_S16LDI:
+            gen_mxu_s16ldd(ctx, true);
+            break;
+        case OPC_MXU_S16SDI:
+            gen_mxu_s16std(ctx, true);
+            break;
         case OPC_MXU__POOL19:
             decode_opc_mxu__pool19(ctx);
             break;
-- 
2.38.1


