Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6307572810C
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:18:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWm-0003RJ-Rl; Thu, 08 Jun 2023 09:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6a-0002RV-B5
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:43:00 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6Y-0006dh-Cx
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:43:00 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4f62cf9755eso577031e87.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220976; x=1688812976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QeZBVKiRoAuXavabMg1ubmBNf1WEzNO4ztDQF0y8S5o=;
 b=IkWN7SdDWocbULcwAahTxc6hwnQ2qN6zCQ0nx9A00rKi+mLllTcIKdjPRivIWjOS3o
 VcpXNPWQLlqdxMADlkgZa9iSIWF80Rfkp0LEO14zDA/jd9cQ7kYpP51xBWqe6NHkHID/
 t5tXSyHOAGl8o2cTgDkzk4yZzX5nOIrzYH5eEuJVRm6qiUmG/aa58rGQblIqO/3jRo8s
 gxzQhENzsRpgJ6/f/YkxQw0TW83L+9T8WPgHdJCmhErzU7bSHQAj8LiiAZ69/SBrVM0x
 7hx7KhGkAvm/lec0Du+rzttkoqfB11PSMud4jnjn6kJnhicwNuS8Sk+sn3KMGLDLMJhg
 5a8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220976; x=1688812976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QeZBVKiRoAuXavabMg1ubmBNf1WEzNO4ztDQF0y8S5o=;
 b=A4ql6ombgpRwlZP1iMP3HHa6K4C5SJuVeMWFUveHn/Jz+V3fmj1kj1sJ+epHDJsGFF
 aSAvmWvS68OL/iQbTLw+af78Yr8/0SHsQbR+ymMDDpCUij2Oos75/eSM+Sk5EBgEh6MH
 CVq+CS/23MhO5vLHSvdgDYZewTAUfP2L9//yB1OXFRwTFP6O376Im0CznKULeB4fLo3Y
 c7rzts7NOPafHgDYq1Hp8lpG12OHEVa6cHbWIdeQp11oK5eM5FxSDvZQQOqlDw3NBxlX
 vuANvvoiVUA/yf0oiwJJnXWAa7nD6PClN3JmX+FfKWVDY2SYolRoCuCnplKhJhZxULWz
 c+mQ==
X-Gm-Message-State: AC+VfDyhUxZhRLjCVHeyied/RBkQRHdVLKIxsvPWiEoWlMWXnG3YvXEQ
 TWrv+bjbi0D6wGMhRArmm06fsYkxkeM=
X-Google-Smtp-Source: ACHHUZ6nQZC28TwhvSho0aoHkK4eCp4GQdoVqMY2+RrGRvJy1rWuTFzsrUOfXM55xFqKfphEgsKn8w==
X-Received: by 2002:ac2:44d7:0:b0:4f2:5338:d0a8 with SMTP id
 d23-20020ac244d7000000b004f25338d0a8mr3549485lfm.56.1686220976495; 
 Thu, 08 Jun 2023 03:42:56 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:56 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 29/33] target/mips: Add emulation of MXU Q8MAC Q8MACSU
 instructions
Date: Thu,  8 Jun 2023 13:42:18 +0300
Message-Id: <20230608104222.1520143-30-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x12f.google.com
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

These instructions do parallel quad 8-bit multiply and accumulate.
They are close to existing Q8MUL Q8MULSU so the generation
function modified to support all of them.
Also the patch fixes decoding of Q8MULSU according to tests on
hardware.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 128 +++++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 42 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 74b2712d8d..dc985342d6 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -328,7 +328,7 @@
  *          ├─ 110111 ─ OPC_MXU_Q16SAR
  *          │                               23..22
  *          ├─ 111000 ─ OPC_MXU__POOL19 ─┬─ 00 ─ OPC_MXU_Q8MUL
- *          │                            └─ 01 ─ OPC_MXU_Q8MULSU
+ *          │                            └─ 10 ─ OPC_MXU_Q8MULSU
  *          │
  *          │                               20..18
  *          ├─ 111001 ─ OPC_MXU__POOL20 ─┬─ 000 ─ OPC_MXU_Q8MOVZ
@@ -406,6 +406,7 @@ enum {
     OPC_MXU_Q16SAR   = 0x37,
     OPC_MXU__POOL19  = 0x38,
     OPC_MXU__POOL20  = 0x39,
+    OPC_MXU__POOL21  = 0x3A,
 };
 
 
@@ -541,7 +542,7 @@ enum {
  */
 enum {
     OPC_MXU_Q8MUL    = 0x00,
-    OPC_MXU_Q8MULSU  = 0x01,
+    OPC_MXU_Q8MULSU  = 0x02,
 };
 
 /*
@@ -556,6 +557,15 @@ enum {
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
@@ -1330,13 +1340,17 @@ static void gen_mxu_s16mad(DisasContext *ctx)
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
@@ -1351,54 +1365,60 @@ static void gen_mxu_q8mul_q8mulsu(DisasContext *ctx)
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
-
-    tcg_gen_shli_tl(t1, t1, 16);
-    tcg_gen_shli_tl(t3, t3, 16);
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
 
-    tcg_gen_or_tl(t0, t0, t1);
-    tcg_gen_or_tl(t1, t2, t3);
+    tcg_gen_deposit_tl(t0, t0, t1, 16, 16);
+    tcg_gen_deposit_tl(t1, t2, t3, 16, 16);
 
     gen_store_mxu_gpr(t0, XRd);
     gen_store_mxu_gpr(t1, XRa);
@@ -4550,12 +4570,14 @@ static void decode_opc_mxu__pool18(DisasContext *ctx)
 
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
@@ -4594,6 +4616,25 @@ static void decode_opc_mxu__pool20(DisasContext *ctx)
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
@@ -4757,6 +4798,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
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
2.40.0


