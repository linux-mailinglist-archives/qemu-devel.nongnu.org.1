Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BF374E128
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:32:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzMo-00084K-JG; Mon, 10 Jul 2023 18:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzMm-0007wX-7Z
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:24 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzMY-0001tf-3p
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:23 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-314172bac25so4941090f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028088; x=1691620088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+mmAezQBBJcxFsMt/6yHPGp2uS2b1jkU7KB0S8apiWQ=;
 b=XVZIfaC5xL+XKg9XrX6pDBjlYz+NeNExNs7/9KXj+R18wPP0VFsuiwRjM9YO4kCrrq
 POrBIy3+HIitAQMHqSnQ9sHRKKONLodTGKH3MIocivROInycMgSLUXTvqcNTxUVH/QQ+
 OxYyRMkOex5K5yfFyEtRRwojE9f73Xa16ulxKwYaU9SShODTD3Y4Ps5JiM9nIYv8NkF4
 ZekDo2sa0LMBEVU5e+hvJh/7ZTE617VxdRnBNRuewZj1Gk6d9fHEIsFPQrpLpO67/8dI
 SDBq/nk0TAMGRDRHjqxuyOusam6D/fQGWS3lwR/ctL8xeGYurG7pYZYvla071ENZB9ev
 Sd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028088; x=1691620088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+mmAezQBBJcxFsMt/6yHPGp2uS2b1jkU7KB0S8apiWQ=;
 b=YG+692BOV6H90ZzqRhHlSab+AdIVvbKtflC/GYFy7Ggv1uUftTzXrFlsrOgNqlI22p
 D5fIS9kIYuH7TSUIjE8Qvchkxv/O/PTi3OH5Gu76kAtlN1dvRNUivJiL8nPgQN6CEk4g
 sB49+zbxPQj37uaPxDESP4AqeWs2TexUETFm+WpcD7X8vqXe3pRPdHfVVJXcIXlum5A7
 gN1xjbBmYA5218z0uC2SeapMlzKK3Rlz1UkrsjL/kD602nQq8V0DtbhwQIsltg1RfyAg
 ZMU1GehiUGxIlV8mgs5VrtH4YXQy2JuJ0JyfRRjm6bx6JhidRjeh8bi6VCYLvxFGUVSd
 8mzA==
X-Gm-Message-State: ABy/qLaxhp+lCRWBsLxOtRTpO8udY4rT1a3WAvmTZtC3OHDtWRZD0t5T
 orRJG1GNJ72AEOItb2ZWPnL6oUITLlbyozVIIjQViA==
X-Google-Smtp-Source: APBJJlHZYrADLSx9aAGMlkNpPml5egKNfO4FuqBqxFhJTBt0rYrLxepOR0r7ZlRtVREk+iEjn5FdJA==
X-Received: by 2002:adf:f94c:0:b0:314:de6:3200 with SMTP id
 q12-20020adff94c000000b003140de63200mr11380234wrr.41.1689028088532; 
 Mon, 10 Jul 2023 15:28:08 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 n8-20020a5d6b88000000b003141e9e2f81sm559235wrx.4.2023.07.10.15.28.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:28:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 21/44] target/mips/mxu: Add Q16ACC Q16ACCM D16ASUM instructions
Date: Tue, 11 Jul 2023 00:25:48 +0200
Message-Id: <20230710222611.50978-22-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

These instructions are all dual 16-bit addition/subtraction in
various combinations. The instructions are grouped in pool13,
see the opcode organization in the file.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-19-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 228 +++++++++++++++++++++++++++++++-
 1 file changed, 227 insertions(+), 1 deletion(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 84e8f760e4..18188208b7 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -277,7 +277,7 @@
  *          │                               23..22
  *          ├─ 011011 ─ OPC_MXU__POOL13 ─┬─ 00 ─ OPC_MXU_Q16ACC
  *          │                            ├─ 01 ─ OPC_MXU_Q16ACCM
- *          │                            └─ 10 ─ OPC_MXU_Q16ASUM
+ *          │                            └─ 10 ─ OPC_MXU_D16ASUM
  *          │
  *          │                               23..22
  *          ├─ 011100 ─ OPC_MXU__POOL14 ─┬─ 00 ─ OPC_MXU_Q8ADDE
@@ -378,6 +378,7 @@ enum {
     OPC_MXU__POOL11  = 0x17,
     OPC_MXU_D32ADD   = 0x18,
     OPC_MXU__POOL12  = 0x19,
+    OPC_MXU__POOL13  = 0x1B,
     OPC_MXU_S8LDD    = 0x22,
     OPC_MXU__POOL16  = 0x27,
     OPC_MXU__POOL17  = 0x28,
@@ -449,6 +450,15 @@ enum {
     OPC_MXU_D32ASUM   = 0x02,
 };
 
+/*
+ * MXU pool 13
+ */
+enum {
+    OPC_MXU_Q16ACC    = 0x00,
+    OPC_MXU_Q16ACCM   = 0x01,
+    OPC_MXU_D16ASUM   = 0x02,
+};
+
 /*
  * MXU pool 16
  */
@@ -2258,6 +2268,198 @@ static void gen_mxu_q16add(DisasContext *ctx)
     tcg_gen_or_tl(mxu_gpr[XRd - 1], t0, t1);
 }
 
+/*
+ * Q16ACC XRa, XRb, XRc, XRd, aptn2 - Quad packed
+ * 16-bit addition/subtraction with accumulate.
+ */
+static void gen_mxu_q16acc(DisasContext *ctx)
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
+    TCGv t3 = tcg_temp_new();
+    TCGv s3 = tcg_temp_new();
+    TCGv s2 = tcg_temp_new();
+    TCGv s1 = tcg_temp_new();
+    TCGv s0 = tcg_temp_new();
+
+    gen_load_mxu_gpr(t1, XRb);
+    tcg_gen_extract_tl(t0, t1,  0, 16);
+    tcg_gen_extract_tl(t1, t1, 16, 16);
+
+    gen_load_mxu_gpr(t3, XRc);
+    tcg_gen_extract_tl(t2, t3,  0, 16);
+    tcg_gen_extract_tl(t3, t3, 16, 16);
+
+    switch (aptn2) {
+    case MXU_APTN2_AA: /* lop +, rop + */
+        tcg_gen_add_tl(s3, t1, t3);
+        tcg_gen_add_tl(s2, t0, t2);
+        tcg_gen_add_tl(s1, t1, t3);
+        tcg_gen_add_tl(s0, t0, t2);
+        break;
+    case MXU_APTN2_AS: /* lop +, rop - */
+        tcg_gen_sub_tl(s3, t1, t3);
+        tcg_gen_sub_tl(s2, t0, t2);
+        tcg_gen_add_tl(s1, t1, t3);
+        tcg_gen_add_tl(s0, t0, t2);
+        break;
+    case MXU_APTN2_SA: /* lop -, rop + */
+        tcg_gen_add_tl(s3, t1, t3);
+        tcg_gen_add_tl(s2, t0, t2);
+        tcg_gen_sub_tl(s1, t1, t3);
+        tcg_gen_sub_tl(s0, t0, t2);
+        break;
+    case MXU_APTN2_SS: /* lop -, rop - */
+        tcg_gen_sub_tl(s3, t1, t3);
+        tcg_gen_sub_tl(s2, t0, t2);
+        tcg_gen_sub_tl(s1, t1, t3);
+        tcg_gen_sub_tl(s0, t0, t2);
+        break;
+    }
+
+    if (XRa != 0) {
+        tcg_gen_add_tl(t0, mxu_gpr[XRa - 1], s0);
+        tcg_gen_extract_tl(t0, t0, 0, 16);
+        tcg_gen_extract_tl(t1, mxu_gpr[XRa - 1], 16, 16);
+        tcg_gen_add_tl(t1, t1, s1);
+        tcg_gen_shli_tl(t1, t1, 16);
+        tcg_gen_or_tl(mxu_gpr[XRa - 1], t1, t0);
+    }
+
+    if (XRd != 0) {
+        tcg_gen_add_tl(t0, mxu_gpr[XRd - 1], s2);
+        tcg_gen_extract_tl(t0, t0, 0, 16);
+        tcg_gen_extract_tl(t1, mxu_gpr[XRd - 1], 16, 16);
+        tcg_gen_add_tl(t1, t1, s3);
+        tcg_gen_shli_tl(t1, t1, 16);
+        tcg_gen_or_tl(mxu_gpr[XRd - 1], t1, t0);
+    }
+}
+
+/*
+ * Q16ACCM XRa, XRb, XRc, XRd, aptn2 - Quad packed
+ * 16-bit accumulate.
+ */
+static void gen_mxu_q16accm(DisasContext *ctx)
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
+    TCGv t3 = tcg_temp_new();
+
+    gen_load_mxu_gpr(t2, XRb);
+    gen_load_mxu_gpr(t3, XRc);
+
+    if (XRa != 0) {
+        TCGv a0 = tcg_temp_new();
+        TCGv a1 = tcg_temp_new();
+
+        tcg_gen_extract_tl(t0, t2,  0, 16);
+        tcg_gen_extract_tl(t1, t2, 16, 16);
+
+        gen_load_mxu_gpr(a1, XRa);
+        tcg_gen_extract_tl(a0, a1,  0, 16);
+        tcg_gen_extract_tl(a1, a1, 16, 16);
+
+        if (aptn2 & 2) {
+            tcg_gen_sub_tl(a0, a0, t0);
+            tcg_gen_sub_tl(a1, a1, t1);
+        } else {
+            tcg_gen_add_tl(a0, a0, t0);
+            tcg_gen_add_tl(a1, a1, t1);
+        }
+        tcg_gen_extract_tl(a0, a0, 0, 16);
+        tcg_gen_shli_tl(a1, a1, 16);
+        tcg_gen_or_tl(mxu_gpr[XRa - 1], a1, a0);
+    }
+
+    if (XRd != 0) {
+        TCGv a0 = tcg_temp_new();
+        TCGv a1 = tcg_temp_new();
+
+        tcg_gen_extract_tl(t0, t3,  0, 16);
+        tcg_gen_extract_tl(t1, t3, 16, 16);
+
+        gen_load_mxu_gpr(a1, XRd);
+        tcg_gen_extract_tl(a0, a1,  0, 16);
+        tcg_gen_extract_tl(a1, a1, 16, 16);
+
+        if (aptn2 & 1) {
+            tcg_gen_sub_tl(a0, a0, t0);
+            tcg_gen_sub_tl(a1, a1, t1);
+        } else {
+            tcg_gen_add_tl(a0, a0, t0);
+            tcg_gen_add_tl(a1, a1, t1);
+        }
+        tcg_gen_extract_tl(a0, a0, 0, 16);
+        tcg_gen_shli_tl(a1, a1, 16);
+        tcg_gen_or_tl(mxu_gpr[XRd - 1], a1, a0);
+    }
+}
+
+
+/*
+ * D16ASUM XRa, XRb, XRc, XRd, aptn2 - Double packed
+ * 16-bit sign extended addition and accumulate.
+ */
+static void gen_mxu_d16asum(DisasContext *ctx)
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
+    TCGv t3 = tcg_temp_new();
+
+    gen_load_mxu_gpr(t2, XRb);
+    gen_load_mxu_gpr(t3, XRc);
+
+    if (XRa != 0) {
+        tcg_gen_sextract_tl(t0, t2,  0, 16);
+        tcg_gen_sextract_tl(t1, t2, 16, 16);
+        tcg_gen_add_tl(t0, t0, t1);
+        if (aptn2 & 2) {
+            tcg_gen_sub_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+        } else {
+            tcg_gen_add_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+        }
+    }
+
+    if (XRd != 0) {
+        tcg_gen_sextract_tl(t0, t3,  0, 16);
+        tcg_gen_sextract_tl(t1, t3, 16, 16);
+        tcg_gen_add_tl(t0, t0, t1);
+        if (aptn2 & 1) {
+            tcg_gen_sub_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t0);
+        } else {
+            tcg_gen_add_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t0);
+        }
+    }
+}
+
 /*
  * D32ADD XRa, XRb, XRc, XRd, aptn2 - Double
  * 32 bit pattern addition/subtraction, set carry.
@@ -3112,6 +3314,27 @@ static void decode_opc_mxu__pool12(DisasContext *ctx)
     }
 }
 
+static void decode_opc_mxu__pool13(DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 22, 2);
+
+    switch (opcode) {
+    case OPC_MXU_Q16ACC:
+        gen_mxu_q16acc(ctx);
+        break;
+    case OPC_MXU_Q16ACCM:
+        gen_mxu_q16accm(ctx);
+        break;
+    case OPC_MXU_D16ASUM:
+        gen_mxu_d16asum(ctx);
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
@@ -3280,6 +3503,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU__POOL12:
             decode_opc_mxu__pool12(ctx);
             break;
+        case OPC_MXU__POOL13:
+            decode_opc_mxu__pool13(ctx);
+            break;
         case OPC_MXU_S8LDD:
             gen_mxu_s8ldd(ctx);
             break;
-- 
2.38.1


