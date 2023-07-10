Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A682874E10A
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:28:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzMh-0007dA-Nb; Mon, 10 Jul 2023 18:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzMf-0007LR-As
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:17 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzMd-0001va-AH
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:17 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc63c2e84so56012065e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028093; x=1691620093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qrKWorx2W+9ITDLrESbxcQflFKH3wr3nKlJX3FtN6Gw=;
 b=Pw1hyuLiT4qLkwa28njNl+Brv81uWAg7KV6zzEMZmu4mj2KM9fru9vyq/9/Qe0Cf4A
 t0AzH5Sow4vVINlL5EG/PsTyn/pvKMp6Y1rWc/e/sYoIMTnw5989OVawxA7ut/TGOP1I
 e9Z5QszGLibV1fGO20UegaXPufXSDxUkc4MDfIfgaICjWa7hBpCDMy8MNwgzE+Tejf3d
 vraglAkLiJOlg3ID1JU9LE9rw0mEYqKdi1DXq86+iyKV06it+rBTOktdD8R6eDTtsppd
 oko4EJeXpuW1rqAi9vkwl6Ly0pYHwEG71Fth/klKrFpay5NTlF+p9KByL3+xlp8/F2xf
 cSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028093; x=1691620093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qrKWorx2W+9ITDLrESbxcQflFKH3wr3nKlJX3FtN6Gw=;
 b=XCsBsa41YrE7H55wkDVDwb2/oerDEK1hSfgKSR+HiJgBCBlbpweiP7VZgkF+yOgvT5
 V3fqUG1wL6tK4NzsSNBm7qL2uxUg/nrBKuih28UU9Hn3FZIiSEX8Db8hzmpoKtn4h8qI
 s63KZ/1zNsNkwKPsQki3audhrKz57gnVjw1Wm41rkfuBjpjDkWegUlu47XJzJFOisMpO
 gAkLcRylvL9CLLY7ySy6mic8xtXASwPhkAKnM5/Y7Dq57n0jLw71k6oxRrASyjfi1fPw
 rpyVw63/ea9Zumfcsckm1WmdUEZiqzxLRHoyNvkuh/XJOx7xIuCCDqPr8lpgqO24TMjq
 alYg==
X-Gm-Message-State: ABy/qLa7UBuZ2xuTNvqZdwCEZ9Itb4KIk5Qd12Fe55HIVBgQxzs89SOg
 FSt4zzSyEB60SmH8Pyx+a84BoqlAjz/AyidihNMdYg==
X-Google-Smtp-Source: APBJJlGkQUSoFIy+PRcb4Mby52ODquhY16Z144bKuyP9NYlxKd5yW4I25iIOsF7b9wbeDRlmptx0Ag==
X-Received: by 2002:a5d:6092:0:b0:314:3994:cd98 with SMTP id
 w18-20020a5d6092000000b003143994cd98mr13519424wrt.62.1689028093682; 
 Mon, 10 Jul 2023 15:28:13 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 a23-20020a5d4577000000b0030ae53550f5sm530260wrc.51.2023.07.10.15.28.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:28:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 22/44] target/mips/mxu: Add Q8ADDE Q8ACCE D8SUM D8SUMC
 instructions
Date: Tue, 11 Jul 2023 00:25:49 +0200
Message-Id: <20230710222611.50978-23-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

These instructions are all dual 8-bit addition/subtraction in
various combinations. Most instructions are grouped in pool14,
see the opcode organization in the file.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-20-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 200 ++++++++++++++++++++++++++++++++
 1 file changed, 200 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 18188208b7..5556fd152d 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -379,6 +379,8 @@ enum {
     OPC_MXU_D32ADD   = 0x18,
     OPC_MXU__POOL12  = 0x19,
     OPC_MXU__POOL13  = 0x1B,
+    OPC_MXU__POOL14  = 0x1C,
+    OPC_MXU_Q8ACCE   = 0x1D,
     OPC_MXU_S8LDD    = 0x22,
     OPC_MXU__POOL16  = 0x27,
     OPC_MXU__POOL17  = 0x28,
@@ -459,6 +461,15 @@ enum {
     OPC_MXU_D16ASUM   = 0x02,
 };
 
+/*
+ * MXU pool 14
+ */
+enum {
+    OPC_MXU_Q8ADDE    = 0x00,
+    OPC_MXU_D8SUM     = 0x01,
+    OPC_MXU_D8SUMC    = 0x02,
+};
+
 /*
  * MXU pool 16
  */
@@ -2183,6 +2194,168 @@ static void gen_mxu_Q8ADD(DisasContext *ctx)
     }
 }
 
+/*
+ *  Q8ADDE XRa, XRb, XRc, XRd, aptn2
+ *    Add/subtract quadruple of 8-bit packed in XRb
+ *    to another one in XRc, with zero extending
+ *    to 16-bit and put results as packed 16-bit data
+ *    into XRa and XRd.
+ *    aptn2 manages action add or subract of pairs of data.
+ *
+ *  Q8ACCE XRa, XRb, XRc, XRd, aptn2
+ *    Add/subtract quadruple of 8-bit packed in XRb
+ *    to another one in XRc, with zero extending
+ *    to 16-bit and accumulate results as packed 16-bit data
+ *    into XRa and XRd.
+ *    aptn2 manages action add or subract of pairs of data.
+ */
+static void gen_mxu_q8adde(DisasContext *ctx, bool accumulate)
+{
+    uint32_t aptn2, XRd, XRc, XRb, XRa;
+
+    aptn2 = extract32(ctx->opcode, 24, 2);
+    XRd   = extract32(ctx->opcode, 18, 4);
+    XRc   = extract32(ctx->opcode, 14, 4);
+    XRb   = extract32(ctx->opcode, 10, 4);
+    XRa   = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to zero */
+        if (XRa != 0) {
+            tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+        }
+        if (XRd != 0) {
+            tcg_gen_movi_tl(mxu_gpr[XRd - 1], 0);
+        }
+    } else {
+        /* the most general case */
+        TCGv t0 = tcg_temp_new();
+        TCGv t1 = tcg_temp_new();
+        TCGv t2 = tcg_temp_new();
+        TCGv t3 = tcg_temp_new();
+        TCGv t4 = tcg_temp_new();
+        TCGv t5 = tcg_temp_new();
+
+        if (XRa != 0) {
+            tcg_gen_extract_tl(t0, mxu_gpr[XRb - 1], 16, 8);
+            tcg_gen_extract_tl(t1, mxu_gpr[XRc - 1], 16, 8);
+            tcg_gen_extract_tl(t2, mxu_gpr[XRb - 1], 24, 8);
+            tcg_gen_extract_tl(t3, mxu_gpr[XRc - 1], 24, 8);
+            if (aptn2 & 2) {
+                tcg_gen_sub_tl(t0, t0, t1);
+                tcg_gen_sub_tl(t2, t2, t3);
+            } else {
+                tcg_gen_add_tl(t0, t0, t1);
+                tcg_gen_add_tl(t2, t2, t3);
+            }
+            if (accumulate) {
+                gen_load_mxu_gpr(t5, XRa);
+                tcg_gen_extract_tl(t1, t5,  0, 16);
+                tcg_gen_extract_tl(t3, t5, 16, 16);
+                tcg_gen_add_tl(t0, t0, t1);
+                tcg_gen_add_tl(t2, t2, t3);
+            }
+            tcg_gen_shli_tl(t2, t2, 16);
+            tcg_gen_extract_tl(t0, t0, 0, 16);
+            tcg_gen_or_tl(t4, t2, t0);
+        }
+        if (XRd != 0) {
+            tcg_gen_extract_tl(t0, mxu_gpr[XRb - 1], 0, 8);
+            tcg_gen_extract_tl(t1, mxu_gpr[XRc - 1], 0, 8);
+            tcg_gen_extract_tl(t2, mxu_gpr[XRb - 1], 8, 8);
+            tcg_gen_extract_tl(t3, mxu_gpr[XRc - 1], 8, 8);
+            if (aptn2 & 1) {
+                tcg_gen_sub_tl(t0, t0, t1);
+                tcg_gen_sub_tl(t2, t2, t3);
+            } else {
+                tcg_gen_add_tl(t0, t0, t1);
+                tcg_gen_add_tl(t2, t2, t3);
+            }
+            if (accumulate) {
+                gen_load_mxu_gpr(t5, XRd);
+                tcg_gen_extract_tl(t1, t5,  0, 16);
+                tcg_gen_extract_tl(t3, t5, 16, 16);
+                tcg_gen_add_tl(t0, t0, t1);
+                tcg_gen_add_tl(t2, t2, t3);
+            }
+            tcg_gen_shli_tl(t2, t2, 16);
+            tcg_gen_extract_tl(t0, t0, 0, 16);
+            tcg_gen_or_tl(t5, t2, t0);
+        }
+
+        gen_store_mxu_gpr(t4, XRa);
+        gen_store_mxu_gpr(t5, XRd);
+    }
+}
+
+/*
+ *  D8SUM XRa, XRb, XRc
+ *    Double parallel add of quadruple unsigned 8-bit together
+ *    with zero extending to 16-bit data.
+ *  D8SUMC XRa, XRb, XRc
+ *    Double parallel add of quadruple unsigned 8-bit together
+ *    with zero extending to 16-bit data and adding 2 to each
+ *    parallel result.
+ */
+static void gen_mxu_d8sum(DisasContext *ctx, bool sumc)
+{
+    uint32_t pad, pad2, XRc, XRb, XRa;
+
+    pad  = extract32(ctx->opcode, 24, 2);
+    pad2 = extract32(ctx->opcode, 18, 4);
+    XRc  = extract32(ctx->opcode, 14, 4);
+    XRb  = extract32(ctx->opcode, 10, 4);
+    XRa  = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad != 0 || pad2 != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to zero */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+    } else {
+        /* the most general case */
+        TCGv t0 = tcg_temp_new();
+        TCGv t1 = tcg_temp_new();
+        TCGv t2 = tcg_temp_new();
+        TCGv t3 = tcg_temp_new();
+        TCGv t4 = tcg_temp_new();
+        TCGv t5 = tcg_temp_new();
+
+        if (XRb != 0) {
+            tcg_gen_extract_tl(t0, mxu_gpr[XRb - 1],  0, 8);
+            tcg_gen_extract_tl(t1, mxu_gpr[XRb - 1],  8, 8);
+            tcg_gen_extract_tl(t2, mxu_gpr[XRb - 1], 16, 8);
+            tcg_gen_extract_tl(t3, mxu_gpr[XRb - 1], 24, 8);
+            tcg_gen_add_tl(t4, t0, t1);
+            tcg_gen_add_tl(t4, t4, t2);
+            tcg_gen_add_tl(t4, t4, t3);
+        } else {
+            tcg_gen_mov_tl(t4, 0);
+        }
+        if (XRc != 0) {
+            tcg_gen_extract_tl(t0, mxu_gpr[XRc - 1],  0, 8);
+            tcg_gen_extract_tl(t1, mxu_gpr[XRc - 1],  8, 8);
+            tcg_gen_extract_tl(t2, mxu_gpr[XRc - 1], 16, 8);
+            tcg_gen_extract_tl(t3, mxu_gpr[XRc - 1], 24, 8);
+            tcg_gen_add_tl(t5, t0, t1);
+            tcg_gen_add_tl(t5, t5, t2);
+            tcg_gen_add_tl(t5, t5, t3);
+        } else {
+            tcg_gen_mov_tl(t5, 0);
+        }
+
+        if (sumc) {
+            tcg_gen_addi_tl(t4, t4, 2);
+            tcg_gen_addi_tl(t5, t5, 2);
+        }
+        tcg_gen_shli_tl(t4, t4, 16);
+
+        tcg_gen_or_tl(mxu_gpr[XRa - 1], t4, t5);
+    }
+}
+
 /*
  * Q16ADD XRa, XRb, XRc, XRd, aptn2, optn2 - Quad packed
  * 16-bit pattern addition.
@@ -3335,6 +3508,27 @@ static void decode_opc_mxu__pool13(DisasContext *ctx)
     }
 }
 
+static void decode_opc_mxu__pool14(DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 22, 2);
+
+    switch (opcode) {
+    case OPC_MXU_Q8ADDE:
+        gen_mxu_q8adde(ctx, false);
+        break;
+    case OPC_MXU_D8SUM:
+        gen_mxu_d8sum(ctx, false);
+        break;
+    case OPC_MXU_D8SUMC:
+        gen_mxu_d8sum(ctx, true);
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
@@ -3506,6 +3700,12 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU__POOL13:
             decode_opc_mxu__pool13(ctx);
             break;
+        case OPC_MXU__POOL14:
+            decode_opc_mxu__pool14(ctx);
+            break;
+        case OPC_MXU_Q8ACCE:
+            gen_mxu_q8adde(ctx, true);
+            break;
         case OPC_MXU_S8LDD:
             gen_mxu_s8ldd(ctx);
             break;
-- 
2.38.1


