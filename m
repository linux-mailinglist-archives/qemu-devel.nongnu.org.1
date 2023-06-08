Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5242D728133
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:22:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWy-0003op-Uu; Thu, 08 Jun 2023 09:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6Q-0002N1-4e
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:50 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6O-0006Yz-90
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:49 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4f63006b4e3so590572e87.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220966; x=1688812966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lrm4XrVic9VlFN8GAG0zmq+7yUo2d4//gD+0ioab/eU=;
 b=BV3YAInRfjO7DxssoboM1CKx5OjIvTGIFTSBkRzqOR5EgalrlEBvrNsn+wNiU/BHw0
 rnPnpldQk2fM29jqQMyUN/RcxCzCbvAeoDnMXsRKE9BnE/XTMzZk0jtEwZrRhQID8t9E
 QV7A+z+8CNz0om1+hjmeRSrbcSewUaMVWNnR95TCXX6a7GxLrZyfIDMUo4KIAEsh76Ir
 rhlbXYBwUXX7fmvGDuKvuoV1zixp5+I0QJNW/h/T5X/DAa4ipyP6OIzbiNWDqNeGmy3s
 cewh3ThqCt34fTtbZ/snFyViA76V91F2Xeq6mtPTf75OO0LmcaL23a/R1nT1Vstclls1
 oA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220966; x=1688812966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lrm4XrVic9VlFN8GAG0zmq+7yUo2d4//gD+0ioab/eU=;
 b=Fr3LuDbJuqKxPdB58zGHmlr4Zsg7geoHD2ABNpO8Krd8pTbPotg6gjybs7aJkcKVmi
 V6OTHnTYoZxXz6XPbkEdFxnf+hdUy2Am9hSDbB1imM4fOh+Sy277l1YS69dD0d7Ep24N
 dcxo2sDyZ5wmEVhJRsSVT3DcpQGCtEVKLRLHRI27k4k7Ld+CLDyNNBEmnR4yM6H75Rsp
 yObODzmRqZxMfjXKLkJ9SzjI0kUThSOInofYhC/txB5G6g5UgZida4R3VGhQumXf729Q
 dUg7bHsWCbcS5bv1k3Fi5AVvOws4G2U9EUKjf7s/WUKPGBSaxxn9TungZUf7YlGexwB6
 JrZg==
X-Gm-Message-State: AC+VfDxMACVIgWwJ+I9PzM2XV08EUnJAjcyx9Kk4zrd0uJdmyhccmHLM
 MD0+FHwLizN6WTRi1eo8rzP65FofewI=
X-Google-Smtp-Source: ACHHUZ6hxi44BCozp1t2e5bC83gF36AnWBNAaF+mU+i/mRUF4MyIA9zzOLyVd7aGsJbYky3IwW4FzA==
X-Received: by 2002:a05:6512:374a:b0:4f3:a87f:a87b with SMTP id
 a10-20020a056512374a00b004f3a87fa87bmr2920687lfs.39.1686220966207; 
 Thu, 08 Jun 2023 03:42:46 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:45 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 20/33] target/mips: Add emulation of MXU S8STD S8LDI S8SDI
 instructions
Date: Thu,  8 Jun 2023 13:42:09 +0300
Message-Id: <20230608104222.1520143-21-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x132.google.com
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

These instructions are all load/store a byte from memory
and put it into/get it from MXU register in various combinations.
I-suffix instructions modify the base address GPR by offset provided.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 74 ++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index af80cf76e4..6460846149 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -384,6 +384,9 @@ enum {
     OPC_MXU__POOL14  = 0x1C,
     OPC_MXU_Q8ACCE   = 0x1D,
     OPC_MXU_S8LDD    = 0x22,
+    OPC_MXU_S8STD    = 0x23,
+    OPC_MXU_S8LDI    = 0x24,
+    OPC_MXU_S8SDI    = 0x25,
     OPC_MXU__POOL16  = 0x27,
     OPC_MXU__POOL17  = 0x28,
     OPC_MXU_S32M2I   = 0x2E,
@@ -635,8 +638,11 @@ static void gen_mxu_s32m2i(DisasContext *ctx)
 
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
@@ -651,6 +657,9 @@ static void gen_mxu_s8ldd(DisasContext *ctx)
 
     gen_load_gpr(t0, Rb);
     tcg_gen_addi_tl(t0, t0, (int8_t)s8);
+    if (postmodify) {
+        gen_store_gpr(t0, Rb);
+    }
 
     switch (optn3) {
     /* XRa[7:0] = tmp8 */
@@ -707,6 +716,58 @@ static void gen_mxu_s8ldd(DisasContext *ctx)
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
@@ -3709,7 +3770,16 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
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
2.40.0


