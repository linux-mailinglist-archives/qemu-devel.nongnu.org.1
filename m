Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF54474E114
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:29:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzNc-00033i-C9; Mon, 10 Jul 2023 18:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzNZ-0002mK-T5
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:13 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzNT-00026v-HJ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbea14700bso51718725e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028145; x=1691620145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jk3TdcHIxqTem2Pjvqcy8oiXG7odaogilZzWv2/mbGk=;
 b=wB6aH42lbBCR25SIIFOUQULdZmvm7BL924ohCj+ImmuRTPR//MqS+DUB8QIhr+KG/D
 wzf0axyvHpV2Q1VY5dPkKf4CpUOPHD7jWnQQm/QJl+Iqc8qIE/cljBpxcXWTXPutG0dd
 WkJTg6SqRuRLDNLRLzfc9csrJHqq8NzWoxIVl9LJL9MWibr25yL4+0hQfKAR5v+NiJpp
 oeUchO9RKhBUjlh6vtiQpcfjIqSWagmK7v8udj71gwmonrZ0yxNeMF5oJYbmYcoZ1mm1
 MxzZSyX+M0x/KToosfmK7YA3ShN0K/4WtGK71zk+/VxcdNngLSs+SuxeVper2P5Yx0Sf
 n9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028145; x=1691620145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jk3TdcHIxqTem2Pjvqcy8oiXG7odaogilZzWv2/mbGk=;
 b=G5wB8B7i/4/5sewQFIfwJSj1nCAn2M5RIaW7BkZi2jy4t1LvyyNLVGoKEQumrNE+hz
 ZqI6vsvN6G1B/63kaNNEoig7IqzqQPnb5GIkkyZQBqwMEgi4R/9+Fp1xWhH8t/GpaAij
 JxK2JbUn7OQJXWOoPOkUYWh7Te3BtAQuEe0bokwllj1WLWKm75x5A3RgnlAFE2bUz7O9
 HcQb0AIiyMVi4G44BRvvoQTWQVhIe+Qks/y4yKyP7hObuiwJ5lWuaOTPrXXD10rh9MWa
 fvrmIzRqs/CocVU6oZoC7LF1VB2LPmoVKE/oUJp9x3+OUi1wt3BmuvAHRcNVxsRjPLE/
 lqmA==
X-Gm-Message-State: ABy/qLbch3Vq7vxvJoMLLlne2GSogAmO4atqjhV2mkUfQnhPmnIN+xJQ
 qp90JM0kn/om+1Fsod0SPCLt13UD/q3nnQRIsjxbbA==
X-Google-Smtp-Source: APBJJlHGRT7BVATL9YBn5U7f+vP5P7W/pVUZI/G5JLLG8inq+2gHm7iMjYDQIeejSWBcYru61sU2mQ==
X-Received: by 2002:a7b:c019:0:b0:3fb:a62d:1992 with SMTP id
 c25-20020a7bc019000000b003fba62d1992mr10725914wmb.0.1689028145282; 
 Mon, 10 Jul 2023 15:29:05 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 z9-20020a1c4c09000000b003fa74bff02asm884601wmf.26.2023.07.10.15.29.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:29:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 32/44] target/mips/mxu: Add Q8MAC Q8MACSU instructions
Date: Tue, 11 Jul 2023 00:25:59 +0200
Message-Id: <20230710222611.50978-33-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

These instructions do parallel quad 8-bit multiply and accumulate.
They are close to existing Q8MUL Q8MULSU so the generation
function modified to support all of them.
Also the patch fixes decoding of Q8MULSU according to tests on
hardware.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-30-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 128 +++++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 42 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index f8c3fdb103..6a82849ef7 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -326,7 +326,7 @@
  *          ├─ 110111 ─ OPC_MXU_Q16SAR
  *          │                               23..22
  *          ├─ 111000 ─ OPC_MXU__POOL19 ─┬─ 00 ─ OPC_MXU_Q8MUL
- *          │                            └─ 01 ─ OPC_MXU_Q8MULSU
+ *          │                            └─ 10 ─ OPC_MXU_Q8MULSU
  *          │
  *          │                               20..18
  *          ├─ 111001 ─ OPC_MXU__POOL20 ─┬─ 000 ─ OPC_MXU_Q8MOVZ
@@ -404,6 +404,7 @@ enum {
     OPC_MXU_Q16SAR   = 0x37,
     OPC_MXU__POOL19  = 0x38,
     OPC_MXU__POOL20  = 0x39,
+    OPC_MXU__POOL21  = 0x3A,
 };
 
 
@@ -539,7 +540,7 @@ enum {
  */
 enum {
     OPC_MXU_Q8MUL    = 0x00,
-    OPC_MXU_Q8MULSU  = 0x01,
+    OPC_MXU_Q8MULSU  = 0x02,
 };
 
 /*
@@ -554,6 +555,15 @@ enum {
     OPC_MXU_S32MOVN  = 0x05,
 };
 
+/*
+ * MXU pool 21
+ */
+enum {
+    OPC_MXU_Q8MAC    = 0x00,
+    OPC_MXU_Q8MACSU  = 0x02,
+};
+
+
 /* MXU accumulate add/subtract 1-bit pattern 'aptn1' */
 #define MXU_APTN1_A    0
 #define MXU_APTN1_S    1
@@ -1328,13 +1338,17 @@ static void gen_mxu_s16mad(DisasContext *ctx)
 }
 
 /*
- * Q8MUL   XRa, XRb, XRc, XRd - Parallel unsigned 8 bit pattern multiply
- * Q8MULSU XRa, XRb, XRc, XRd - Parallel signed 8 bit pattern multiply
+ * Q8MUL   XRa, XRb, XRc, XRd - Parallel quad unsigned 8 bit multiply
+ * Q8MULSU XRa, XRb, XRc, XRd - Parallel quad signed 8 bit multiply
+ * Q8MAC   XRa, XRb, XRc, XRd - Parallel quad unsigned 8 bit multiply
+ *   and accumulate
+ * Q8MACSU XRa, XRb, XRc, XRd - Parallel quad signed 8 bit multiply
+ *   and accumulate
  */
-static void gen_mxu_q8mul_q8mulsu(DisasContext *ctx)
+static void gen_mxu_q8mul_mac(DisasContext *ctx, bool su, bool mac)
 {
     TCGv t0, t1, t2, t3, t4, t5, t6, t7;
-    uint32_t XRa, XRb, XRc, XRd, sel;
+    uint32_t XRa, XRb, XRc, XRd, aptn2;
 
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
@@ -1349,54 +1363,60 @@ static void gen_mxu_q8mul_q8mulsu(DisasContext *ctx)
     XRb = extract32(ctx->opcode, 10, 4);
     XRc = extract32(ctx->opcode, 14, 4);
     XRd = extract32(ctx->opcode, 18, 4);
-    sel = extract32(ctx->opcode, 22, 2);
+    aptn2 = extract32(ctx->opcode, 24, 2);
 
     gen_load_mxu_gpr(t3, XRb);
     gen_load_mxu_gpr(t7, XRc);
 
-    if (sel == 0x2) {
-        /* Q8MULSU */
-        tcg_gen_ext8s_tl(t0, t3);
-        tcg_gen_shri_tl(t3, t3, 8);
-        tcg_gen_ext8s_tl(t1, t3);
-        tcg_gen_shri_tl(t3, t3, 8);
-        tcg_gen_ext8s_tl(t2, t3);
-        tcg_gen_shri_tl(t3, t3, 8);
-        tcg_gen_ext8s_tl(t3, t3);
+    if (su) {
+        /* Q8MULSU / Q8MACSU */
+        tcg_gen_sextract_tl(t0, t3,  0, 8);
+        tcg_gen_sextract_tl(t1, t3,  8, 8);
+        tcg_gen_sextract_tl(t2, t3, 16, 8);
+        tcg_gen_sextract_tl(t3, t3, 24, 8);
     } else {
-        /* Q8MUL */
-        tcg_gen_ext8u_tl(t0, t3);
-        tcg_gen_shri_tl(t3, t3, 8);
-        tcg_gen_ext8u_tl(t1, t3);
-        tcg_gen_shri_tl(t3, t3, 8);
-        tcg_gen_ext8u_tl(t2, t3);
-        tcg_gen_shri_tl(t3, t3, 8);
-        tcg_gen_ext8u_tl(t3, t3);
+        /* Q8MUL / Q8MAC */
+        tcg_gen_extract_tl(t0, t3,  0, 8);
+        tcg_gen_extract_tl(t1, t3,  8, 8);
+        tcg_gen_extract_tl(t2, t3, 16, 8);
+        tcg_gen_extract_tl(t3, t3, 24, 8);
     }
 
-    tcg_gen_ext8u_tl(t4, t7);
-    tcg_gen_shri_tl(t7, t7, 8);
-    tcg_gen_ext8u_tl(t5, t7);
-    tcg_gen_shri_tl(t7, t7, 8);
-    tcg_gen_ext8u_tl(t6, t7);
-    tcg_gen_shri_tl(t7, t7, 8);
-    tcg_gen_ext8u_tl(t7, t7);
+    tcg_gen_extract_tl(t4, t7,  0, 8);
+    tcg_gen_extract_tl(t5, t7,  8, 8);
+    tcg_gen_extract_tl(t6, t7, 16, 8);
+    tcg_gen_extract_tl(t7, t7, 24, 8);
 
     tcg_gen_mul_tl(t0, t0, t4);
     tcg_gen_mul_tl(t1, t1, t5);
     tcg_gen_mul_tl(t2, t2, t6);
     tcg_gen_mul_tl(t3, t3, t7);
 
-    tcg_gen_andi_tl(t0, t0, 0xFFFF);
-    tcg_gen_andi_tl(t1, t1, 0xFFFF);
-    tcg_gen_andi_tl(t2, t2, 0xFFFF);
-    tcg_gen_andi_tl(t3, t3, 0xFFFF);
+    if (mac) {
+        gen_load_mxu_gpr(t4, XRd);
+        gen_load_mxu_gpr(t5, XRa);
+        tcg_gen_extract_tl(t6, t4,  0, 16);
+        tcg_gen_extract_tl(t7, t4, 16, 16);
+        if (aptn2 & 1) {
+            tcg_gen_sub_tl(t0, t6, t0);
+            tcg_gen_sub_tl(t1, t7, t1);
+        } else {
+            tcg_gen_add_tl(t0, t6, t0);
+            tcg_gen_add_tl(t1, t7, t1);
+        }
+        tcg_gen_extract_tl(t6, t5,  0, 16);
+        tcg_gen_extract_tl(t7, t5, 16, 16);
+        if (aptn2 & 2) {
+            tcg_gen_sub_tl(t2, t6, t2);
+            tcg_gen_sub_tl(t3, t7, t3);
+        } else {
+            tcg_gen_add_tl(t2, t6, t2);
+            tcg_gen_add_tl(t3, t7, t3);
+        }
+    }
 
-    tcg_gen_shli_tl(t1, t1, 16);
-    tcg_gen_shli_tl(t3, t3, 16);
-
-    tcg_gen_or_tl(t0, t0, t1);
-    tcg_gen_or_tl(t1, t2, t3);
+    tcg_gen_deposit_tl(t0, t0, t1, 16, 16);
+    tcg_gen_deposit_tl(t1, t2, t3, 16, 16);
 
     gen_store_mxu_gpr(t0, XRd);
     gen_store_mxu_gpr(t1, XRa);
@@ -4548,12 +4568,14 @@ static void decode_opc_mxu__pool18(DisasContext *ctx)
 
 static void decode_opc_mxu__pool19(DisasContext *ctx)
 {
-    uint32_t opcode = extract32(ctx->opcode, 22, 2);
+    uint32_t opcode = extract32(ctx->opcode, 22, 4);
 
     switch (opcode) {
     case OPC_MXU_Q8MUL:
+        gen_mxu_q8mul_mac(ctx, false, false);
+        break;
     case OPC_MXU_Q8MULSU:
-        gen_mxu_q8mul_q8mulsu(ctx);
+        gen_mxu_q8mul_mac(ctx, true, false);
         break;
     default:
         MIPS_INVAL("decode_opc_mxu");
@@ -4592,6 +4614,25 @@ static void decode_opc_mxu__pool20(DisasContext *ctx)
     }
 }
 
+static void decode_opc_mxu__pool21(DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 22, 2);
+
+    switch (opcode) {
+    case OPC_MXU_Q8MAC:
+        gen_mxu_q8mul_mac(ctx, false, true);
+        break;
+    case OPC_MXU_Q8MACSU:
+        gen_mxu_q8mul_mac(ctx, true, true);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        gen_reserved_instruction(ctx);
+        break;
+    }
+}
+
+
 bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
 {
     uint32_t opcode = extract32(insn, 0, 6);
@@ -4755,6 +4796,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU__POOL20:
             decode_opc_mxu__pool20(ctx);
             break;
+        case OPC_MXU__POOL21:
+            decode_opc_mxu__pool21(ctx);
+            break;
         default:
             return false;
         }
-- 
2.38.1


