Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EC174E126
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:32:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzN2-0000mK-QM; Mon, 10 Jul 2023 18:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzMz-0000ie-Pu
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzMx-00023G-T2
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:37 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbab0d0b88so46138425e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028114; x=1691620114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdUqHTuEdqBmvrkfm1bRIEI+OIlwJsW52MELVUyLflY=;
 b=jeyJNCPH/Inz+m5VtHTgxLVwvsYbrM8bOArFCqB99rpoAYwXwwVoL1yJETHUWzp6Dp
 Edh6zgMdzFFMtcMKwiNk1PXoDKBIHJe3cQmU84L0iuGQefjmdhi4gNq9iF8EOzShgYOQ
 i7LeRk2bFHX/7d4m5KSUybiJYENPblmTJMYkSg9EDpwcZbQ8rOCWAbbvxdGcm7+LJO/4
 nWiFtsgFKohDyiuRvXcsEg3GmOp8yCH9psbaEFxBh+I0GEuq07rMadSEHZgVmzUVGtIY
 HO1fMyRBV3gOuKf/ToC5dCIWrDK36hCSOtBWtG/uWJl2a+HI9oe6QweTbhKDZxK8VA/5
 tCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028114; x=1691620114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CdUqHTuEdqBmvrkfm1bRIEI+OIlwJsW52MELVUyLflY=;
 b=QNPKxQ1C2Z6hg1yyE85ioGwHPCBtIu4iPwtYYj/bCy+Azj7/S01UVpEub5Wu/Ltm4z
 WXcN5fAfwfHmt85gkv5Z+9wKbxEJsLDhvJlBTN1rfkFTlJo81L693eZG6iVw3Gpw4mk7
 nDIHm3kvqApXaZMk/6Wo/mceqxz+zetur0cAY2UZ2t/XmUueK4FG5f+YGWV7Wl4uYWI7
 sDpcniCNZVDDG/2Doe/WB5ANG3+IXJth0M1SL8rHBt/YZqECTEmr/drbqNgcwKgEL77r
 PuEQhOYCDwRZKbK/kZQwcyJ7XZv3grZIq+WnTYwJz2mQe+NI2mwdQh3D85dtR3qjyNpN
 NADw==
X-Gm-Message-State: ABy/qLaKtM5uuAYO48M2U7iWrUj1ZzPQnraib4AySfqHKWR6vpBxBQ59
 Wk0MvbIy8Agp1PxhPIUzjEc3KNO3Hu3Z6988fMHz+A==
X-Google-Smtp-Source: APBJJlGD/4IFcYRmlRdUoG+kncIih83ZbdN711l+vE48zI7/O5vfFwPl+WdGrj9yEf1g7eM1tTr55w==
X-Received: by 2002:adf:fd84:0:b0:314:a8d:2c9 with SMTP id
 d4-20020adffd84000000b003140a8d02c9mr13540589wrr.0.1689028114279; 
 Mon, 10 Jul 2023 15:28:34 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 v16-20020a5d4b10000000b003143be36d99sm528224wrq.58.2023.07.10.15.28.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:28:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 26/44] target/mips/mxu: Add S32ALN S32LUI insns
Date: Tue, 11 Jul 2023 00:25:53 +0200
Message-Id: <20230710222611.50978-27-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

These instructions are part of pool16, see the grand opcode organization
tree on top of the file.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-24-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 122 +++++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 1 deletion(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 0704a8c7ff..4f07201fcc 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -492,7 +492,9 @@ enum {
  * MXU pool 16
  */
 enum {
+    OPC_MXU_S32ALN   = 0x01,
     OPC_MXU_S32ALNI  = 0x02,
+    OPC_MXU_S32LUI   = 0x03,
     OPC_MXU_S32NOR   = 0x04,
     OPC_MXU_S32AND   = 0x05,
     OPC_MXU_S32OR    = 0x06,
@@ -3066,7 +3068,7 @@ static void gen_mxu_d32asum(DisasContext *ctx)
  *                 MXU instruction category: Miscellaneous
  *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
- *               S32EXTR
+ *               S32EXTR      S32LUI
  *               S32EXTRV
  *                            Q16SAT
  */
@@ -3182,6 +3184,59 @@ static void gen_mxu_s32extrv(DisasContext *ctx)
     gen_store_mxu_gpr(t0, XRa);
 }
 
+/*
+ *  S32LUI XRa, S8, optn3
+ *    Permutate the immediate S8 value to form a word
+ *    to update XRa.
+ */
+static void gen_mxu_s32lui(DisasContext *ctx)
+{
+    uint32_t XRa, s8, optn3, pad;
+
+    XRa   = extract32(ctx->opcode,  6, 4);
+    s8    = extract32(ctx->opcode, 10, 8);
+    pad   = extract32(ctx->opcode, 21, 2);
+    optn3 = extract32(ctx->opcode, 23, 3);
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else {
+        uint32_t s16;
+        TCGv t0 = tcg_temp_new();
+
+        switch (optn3) {
+        case 0:
+            tcg_gen_movi_tl(t0, s8);
+            break;
+        case 1:
+            tcg_gen_movi_tl(t0, s8 << 8);
+            break;
+        case 2:
+            tcg_gen_movi_tl(t0, s8 << 16);
+            break;
+        case 3:
+            tcg_gen_movi_tl(t0, s8 << 24);
+            break;
+        case 4:
+            tcg_gen_movi_tl(t0, (s8 << 16) | s8);
+            break;
+        case 5:
+            tcg_gen_movi_tl(t0, (s8 << 24) | (s8 << 8));
+            break;
+        case 6:
+            s16 = (uint16_t)(int16_t)(int8_t)s8;
+            tcg_gen_movi_tl(t0, (s16 << 16) | s16);
+            break;
+        case 7:
+            tcg_gen_movi_tl(t0, (s8 << 24) | (s8 << 16) | (s8 << 8) | s8);
+            break;
+        }
+        gen_store_mxu_gpr(t0, XRa);
+    }
+}
+
 /*
  *  Q16SAT XRa, XRb, XRc
  *  Packs four 16-bit signed integers in XRb and XRc to
@@ -3461,6 +3516,65 @@ static void gen_mxu_S32ALNI(DisasContext *ctx)
     }
 }
 
+/*
+ *  S32ALN XRc, XRb, XRa, rs
+ *    Arrange bytes from XRb and XRc according to one of five sets of
+ *    rules determined by rs[2:0], and place the result in XRa.
+ */
+static void gen_mxu_S32ALN(DisasContext *ctx)
+{
+    uint32_t rs, XRc, XRb, XRa;
+
+    rs  = extract32(ctx->opcode, 21, 5);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRa = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to all 0s */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+    } else {
+        /* the most general case */
+        TCGv t0 = tcg_temp_new();
+        TCGv t1 = tcg_temp_new();
+        TCGv t2 = tcg_temp_new();
+        TCGv t3 = tcg_temp_new();
+        TCGLabel *l_exit = gen_new_label();
+        TCGLabel *l_b_only = gen_new_label();
+        TCGLabel *l_c_only = gen_new_label();
+
+        gen_load_mxu_gpr(t0, XRb);
+        gen_load_mxu_gpr(t1, XRc);
+        gen_load_gpr(t2, rs);
+        tcg_gen_andi_tl(t2, t2, 0x07);
+
+        /* do nothing for undefined cases */
+        tcg_gen_brcondi_tl(TCG_COND_GE, t2, 5, l_exit);
+
+        tcg_gen_brcondi_tl(TCG_COND_EQ, t2, 0, l_b_only);
+        tcg_gen_brcondi_tl(TCG_COND_EQ, t2, 4, l_c_only);
+
+        tcg_gen_shli_tl(t2, t2, 3);
+        tcg_gen_subfi_tl(t3, 32, t2);
+
+        tcg_gen_shl_tl(t0, t0, t2);
+        tcg_gen_shr_tl(t1, t1, t3);
+        tcg_gen_or_tl(mxu_gpr[XRa - 1], t0, t1);
+        tcg_gen_br(l_exit);
+
+        gen_set_label(l_b_only);
+        gen_store_mxu_gpr(t0, XRa);
+        tcg_gen_br(l_exit);
+
+        gen_set_label(l_c_only);
+        gen_store_mxu_gpr(t1, XRa);
+
+        gen_set_label(l_exit);
+    }
+}
+
 /*
  *  S32MADD XRa, XRd, rb, rc
  *    32 to 64 bit signed multiply with subsequent add
@@ -3889,9 +4003,15 @@ static void decode_opc_mxu__pool16(DisasContext *ctx)
     uint32_t opcode = extract32(ctx->opcode, 18, 3);
 
     switch (opcode) {
+    case OPC_MXU_S32ALN:
+        gen_mxu_S32ALN(ctx);
+        break;
     case OPC_MXU_S32ALNI:
         gen_mxu_S32ALNI(ctx);
         break;
+    case OPC_MXU_S32LUI:
+        gen_mxu_s32lui(ctx);
+        break;
     case OPC_MXU_S32NOR:
         gen_mxu_S32NOR(ctx);
         break;
-- 
2.38.1


