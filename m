Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA4C74E125
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:31:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzLf-0003iM-1s; Mon, 10 Jul 2023 18:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLd-0003iD-8Y
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:13 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLb-0001mM-8k
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:13 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3142860734aso4694598f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028029; x=1691620029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+cKmfCehL9ccjAK2Zy+PLAYfzOsJV5kPaaPkIQJVXoM=;
 b=EKKCJEbkvGfGYO6Up/3e9CTTJbKdeFwem7D7RWNBiHMGLvu0r8VfOyQN7w9sINkXHj
 Z5aNxFVyISX3pUV133KVAyF4Wa9CwHSoGDpAXMDME+zGCxqBhhKCi2Yj30d1eyNr9Fjv
 7MDLWyIboYczozJ3ujae+QSfXvf8qMFaKdHufu7QVG1Zfx+vHHdcaoqWUl+nMMDhAQSu
 zz2GGstCXYaWuM3iV5VmcF6/zNV6YwCdry+Hm5nM+3ht0qcvK9fZQ3GdghTLlixZ/zS4
 fq782GHukHdhrC1A+A/kFLhWSQ0rHu71M16vT56e2YVfjOUnyAKYAYEJtmSUs/sKWz8f
 t2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028029; x=1691620029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+cKmfCehL9ccjAK2Zy+PLAYfzOsJV5kPaaPkIQJVXoM=;
 b=AJZGrRtH99p44RGKcqS5sXDjElwI9WovpsUiY9Ri+L+JetvV0kw7FeMmyLsABwUCoU
 X+TqNn4KVqPJ4ELW9ZEy2nzOC7MY9mvWYMniPEuEXArQaut4+YoFpooRGZqyw106AYjn
 HoYsvvTPWEpldJU9eCL6nHwjqOUmU3SOVuWCQpY1FZJJBp/nwzdKJZeSX/HA83OTP61m
 UJHhsGRu0hJvPrxtRWJZL4gJEVNiolx9zzvlTZOXFLqvGVB+K/oy5yi/ge0t45bfpjTP
 cECsjY0apeTSW+e905KggzZ/IM3S4kEjwvV4hmuMNCTzkeSxm1U21dXqWk3ph3T9C4pP
 jRIg==
X-Gm-Message-State: ABy/qLatUNpvYernuf1sOgVxD+PJrrlf2jvsDqynIQVyPvefl47EuLyw
 DoU/qqCUybyGTJIgq61zt4AJtxM3DzKKWHlZBKe2sA==
X-Google-Smtp-Source: APBJJlFDcEKUi2cA4O73EjuGs9FwZLXQ/vqAg2RWsy5sJQ2uDpKiMf50SIo/d/9Jjcoyukibx8sA6A==
X-Received: by 2002:a5d:44cb:0:b0:311:b18:9ca4 with SMTP id
 z11-20020a5d44cb000000b003110b189ca4mr15126312wrr.17.1689028029615; 
 Mon, 10 Jul 2023 15:27:09 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 s14-20020adfea8e000000b00301a351a8d6sm515832wrm.84.2023.07.10.15.27.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:27:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 10/44] target/mips/mxu: Add S32SLT D16SLT D16AVG[R] Q8AVG[R]
 insns
Date: Tue, 11 Jul 2023 00:25:37 +0200
Message-Id: <20230710222611.50978-11-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

These instructions are part of pool1, see the grand tree above
in the file. Q8ADD is part of pool1 too but belong to another
category of instructions, thus will be made in later patches.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-8-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 244 +++++++++++++++++++++++++++++++-
 1 file changed, 243 insertions(+), 1 deletion(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index e63b4754be..f170195feb 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -358,6 +358,7 @@ enum {
     OPC_MXU__POOL00  = 0x03,
     OPC_MXU_S32MSUB  = 0x04,
     OPC_MXU_S32MSUBU = 0x05,
+    OPC_MXU__POOL01  = 0x06,
     OPC_MXU_D16MUL   = 0x08,
     OPC_MXU_D16MAC   = 0x0A,
     OPC_MXU__POOL04  = 0x10,
@@ -391,6 +392,18 @@ enum {
     OPC_MXU_Q8SLTU   = 0x07,
 };
 
+/*
+ * MXU pool 01
+ */
+enum {
+    OPC_MXU_S32SLT   = 0x00,
+    OPC_MXU_D16SLT   = 0x01,
+    OPC_MXU_D16AVG   = 0x02,
+    OPC_MXU_D16AVGR  = 0x03,
+    OPC_MXU_Q8AVG    = 0x04,
+    OPC_MXU_Q8AVGR   = 0x05,
+};
+
 /*
  * MXU pool 04 05 06 07 08 09 10 11
  */
@@ -1152,11 +1165,15 @@ static void gen_mxu_S32XOR(DisasContext *ctx)
 
 
 /*
- *                   MXU instruction category max/min
+ *                   MXU instruction category max/min/avg
  *                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  *                     S32MAX     D16MAX     Q8MAX
  *                     S32MIN     D16MIN     Q8MIN
+ *                     S32SLT     D16SLT     Q8SLT
+ *                                           Q8SLTU
+ *                                D16AVG     Q8AVG
+ *                                D16AVGR    Q8AVGR
  */
 
 /*
@@ -1462,6 +1479,199 @@ static void gen_mxu_q8slt(DisasContext *ctx, bool sltu)
     }
 }
 
+/*
+ *  S32SLT
+ *    Update XRa with the signed "set less than" comparison of XRb and XRc.
+ *    a.k.a. XRa = XRb < XRc ? 1 : 0;
+ */
+static void gen_mxu_S32SLT(DisasContext *ctx)
+{
+    uint32_t pad, XRc, XRb, XRa;
+
+    pad = extract32(ctx->opcode, 21, 5);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRa = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to zero */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+    } else if (unlikely(XRb == XRc)) {
+        /* both operands same registers -> just set destination to zero */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+    } else {
+        /* the most general case */
+        tcg_gen_setcond_tl(TCG_COND_LT, mxu_gpr[XRa - 1],
+                           mxu_gpr[XRb - 1], mxu_gpr[XRc - 1]);
+    }
+}
+
+/*
+ *  D16SLT
+ *    Update XRa with the signed "set less than" comparison of XRb and XRc
+ *    on per-word basis.
+ *    a.k.a. XRa[0..1] = XRb[0..1] < XRc[0..1] ? 1 : 0;
+ */
+static void gen_mxu_D16SLT(DisasContext *ctx)
+{
+    uint32_t pad, XRc, XRb, XRa;
+
+    pad = extract32(ctx->opcode, 21, 5);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRa = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to zero */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+    } else if (unlikely(XRb == XRc)) {
+        /* both operands same registers -> just set destination to zero */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
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
+        tcg_gen_sextract_tl(t0, t3, 16, 16);
+        tcg_gen_sextract_tl(t1, t4, 16, 16);
+        tcg_gen_setcond_tl(TCG_COND_LT, t0, t0, t1);
+        tcg_gen_shli_tl(t2, t0, 16);
+        tcg_gen_sextract_tl(t0, t3,  0, 16);
+        tcg_gen_sextract_tl(t1, t4,  0, 16);
+        tcg_gen_setcond_tl(TCG_COND_LT, t0, t0, t1);
+        tcg_gen_or_tl(mxu_gpr[XRa - 1], t2, t0);
+    }
+}
+
+/*
+ *  D16AVG
+ *    Update XRa with the signed average of XRb and XRc
+ *    on per-word basis, rounding down.
+ *    a.k.a. XRa[0..1] = (XRb[0..1] + XRc[0..1]) >> 1;
+ *
+ *  D16AVGR
+ *    Update XRa with the signed average of XRb and XRc
+ *    on per-word basis, math rounding 4/5.
+ *    a.k.a. XRa[0..1] = (XRb[0..1] + XRc[0..1] + 1) >> 1;
+ */
+static void gen_mxu_d16avg(DisasContext *ctx, bool round45)
+{
+    uint32_t pad, XRc, XRb, XRa;
+
+    pad = extract32(ctx->opcode, 21, 5);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRa = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to zero */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+    } else if (unlikely(XRb == XRc)) {
+        /* both operands same registers -> just set destination to same */
+        tcg_gen_mov_tl(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
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
+        tcg_gen_sextract_tl(t0, t3, 16, 16);
+        tcg_gen_sextract_tl(t1, t4, 16, 16);
+        tcg_gen_add_tl(t0, t0, t1);
+        if (round45) {
+            tcg_gen_addi_tl(t0, t0, 1);
+        }
+        tcg_gen_shli_tl(t2, t0, 15);
+        tcg_gen_andi_tl(t2, t2, 0xffff0000);
+        tcg_gen_sextract_tl(t0, t3,  0, 16);
+        tcg_gen_sextract_tl(t1, t4,  0, 16);
+        tcg_gen_add_tl(t0, t0, t1);
+        if (round45) {
+            tcg_gen_addi_tl(t0, t0, 1);
+        }
+        tcg_gen_shri_tl(t0, t0, 1);
+        tcg_gen_deposit_tl(t2, t2, t0, 0, 16);
+        gen_store_mxu_gpr(t2, XRa);
+    }
+}
+
+/*
+ *  Q8AVG
+ *    Update XRa with the signed average of XRb and XRc
+ *    on per-byte basis, rounding down.
+ *    a.k.a. XRa[0..3] = (XRb[0..3] + XRc[0..3]) >> 1;
+ *
+ *  Q8AVGR
+ *    Update XRa with the signed average of XRb and XRc
+ *    on per-word basis, math rounding 4/5.
+ *    a.k.a. XRa[0..3] = (XRb[0..3] + XRc[0..3] + 1) >> 1;
+ */
+static void gen_mxu_q8avg(DisasContext *ctx, bool round45)
+{
+    uint32_t pad, XRc, XRb, XRa;
+
+    pad = extract32(ctx->opcode, 21, 5);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRa = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to zero */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+    } else if (unlikely(XRb == XRc)) {
+        /* both operands same registers -> just set destination to same */
+        tcg_gen_mov_tl(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
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
+        tcg_gen_movi_tl(t2, 0);
+
+        for (int i = 0; i < 4; i++) {
+            tcg_gen_extract_tl(t0, t3, 8 * i, 8);
+            tcg_gen_extract_tl(t1, t4, 8 * i, 8);
+            tcg_gen_add_tl(t0, t0, t1);
+            if (round45) {
+                tcg_gen_addi_tl(t0, t0, 1);
+            }
+            tcg_gen_shri_tl(t0, t0, 1);
+            tcg_gen_deposit_tl(t2, t2, t0, 8 * i, 8);
+        }
+        gen_store_mxu_gpr(t2, XRa);
+    }
+}
+
 
 /*
  *                 MXU instruction category: align
@@ -1769,6 +1979,35 @@ static bool decode_opc_mxu_s32madd_sub(DisasContext *ctx)
     return true;
 }
 
+static void decode_opc_mxu__pool01(DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 18, 3);
+
+    switch (opcode) {
+    case OPC_MXU_S32SLT:
+        gen_mxu_S32SLT(ctx);
+        break;
+    case OPC_MXU_D16SLT:
+        gen_mxu_D16SLT(ctx);
+        break;
+    case OPC_MXU_D16AVG:
+        gen_mxu_d16avg(ctx, false);
+        break;
+    case OPC_MXU_D16AVGR:
+        gen_mxu_d16avg(ctx, true);
+        break;
+    case OPC_MXU_Q8AVG:
+        gen_mxu_q8avg(ctx, false);
+        break;
+    case OPC_MXU_Q8AVGR:
+        gen_mxu_q8avg(ctx, true);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        gen_reserved_instruction(ctx);
+        break;
+    }
+}
 static void decode_opc_mxu__pool04(DisasContext *ctx)
 {
     uint32_t reversed = extract32(ctx->opcode, 20, 1);
@@ -2015,6 +2254,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU_D16MAC:
             gen_mxu_d16mac(ctx);
             break;
+        case OPC_MXU__POOL01:
+            decode_opc_mxu__pool01(ctx);
+            break;
         case OPC_MXU__POOL04:
             decode_opc_mxu__pool04(ctx);
             break;
-- 
2.38.1


