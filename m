Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A9272812D
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:21:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWz-0003pJ-6d; Thu, 08 Jun 2023 09:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6Q-0002NM-Tx
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:50 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6P-0006Za-50
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:50 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f4b2bc1565so570038e87.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220967; x=1688812967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8b7KrjCebnfWIrPsCkUgKYPJ7/0tuWaa+jvxau+kcyg=;
 b=MIWD8MS7a8LCbKOcRUPgojiAMscDVLCzgZntyRnN32L8z4ZeXU/kZq3mF5XsUj0YYX
 9iEBgQvktT1mXddRX00DKKZ1hSPHBJR+l2Z38qNrG7Li7pGL8gtikVfX+zvM2K9QRrJS
 4VYhGg6le7cGONAyog4AuX038Xw6U+qCzrE+NxVnHSh9f6ZSfEovknReDnQw/szR5zea
 RW8vnOSDWjV0IIc6Z1QMT8w9u8qk8xFnmioySsV1j3+wZcPsmBl/ulSQUnbdKlUhNwik
 8NrHohr1q8HBd7cOnX/vLGlVFQSIECN23D83vfv5ZYYi2MO37MC/ohA8ZUPVmGxlBpLF
 qe2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220967; x=1688812967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8b7KrjCebnfWIrPsCkUgKYPJ7/0tuWaa+jvxau+kcyg=;
 b=A6zWBWbbJyB99Vj0PHL6JNJLCbOMNl+lSHSRGdkNZG/aEllT+i7K0lWr4dobRLUQQC
 D3pj//p8DIhSgZ7pmE7W0XgSYLe9h3p0OVRXTPkoPrV8UK85JP1Epiyd3VsMtxTrVgrC
 CkB66dqFOwAotDAmN3oeHsfHTkpa4maDAIhP+P6dAu2q1jFCPtAGM86rKPhAXPCJO3Kd
 qF8RqUmUs6tG3ZsYE04WPXZiBGTTCZP13uJ1tCIV97jIZse7EDwvkOGhNrKLxhvHjDVn
 k5Ur9Rb+tv3ErdytIEJ+NxmSfJjoH3PaX/0DWP4nZsNzYcyRcernu38MF3gFsVSY/9FT
 fkcQ==
X-Gm-Message-State: AC+VfDxX6h2hM9Y2Vmil4evZJW6sf5M9FFLT8u3N28Tn3btt53uLZGYr
 lcTiHUbLELD0FaSMBjtzNnXlsmVxdUI=
X-Google-Smtp-Source: ACHHUZ6/HkcmsuLdSq8xVxn8btOwJ+12wu0pD6L85zS0YVg5yuOxSdRl82RpKN3P9oV6AEU0HiZvuQ==
X-Received: by 2002:ac2:4a7a:0:b0:4f2:6bc3:5e33 with SMTP id
 q26-20020ac24a7a000000b004f26bc35e33mr3139872lfp.9.1686220967238; 
 Thu, 08 Jun 2023 03:42:47 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:46 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 21/33] target/mips: Add emulation of MXU S16LDD S16STD S16LDI
 S16SDI instructions
Date: Thu,  8 Jun 2023 13:42:10 +0300
Message-Id: <20230608104222.1520143-22-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x133.google.com
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

These instructions are all load/store a halfword from memory
and put it into/get it from MXU register in various combinations.
I-suffix instructions modify the base address GPR by offset provided.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 117 ++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 6460846149..f867950f3d 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -389,6 +389,10 @@ enum {
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
@@ -768,6 +772,107 @@ static void gen_mxu_s8std(DisasContext *ctx, bool postmodify)
 
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
@@ -3787,6 +3892,18 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
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
2.40.0


