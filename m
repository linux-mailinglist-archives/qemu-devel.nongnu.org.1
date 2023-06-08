Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5699C728120
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:20:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWX-0003Mb-Ct; Thu, 08 Jun 2023 09:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6L-0002LK-Ou
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:45 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6K-0006Wu-1W
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:45 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f4b2bc1565so569966e87.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220962; x=1688812962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ocX6egucweClanHXPfUXGJgty6BQ9b/kn/b9p27gG9o=;
 b=rKrwVdUJVCiTMyMRax6FWokuutYxrlcSI5kdaBl7CRms+h/EjWBQ6+gsdTP4F5UyuE
 xy2nTQLYfpZywtXdfD2TKmQif0q6isZ5DkF8781JfoQUo1q/qURTIitryPwqGzWkNI6f
 fRJ2WPK8SIg6pnYItvQ/0T1HXh694aHwsGrTEI8q70OiTg64bMruff89jWRtFqHn8hiS
 lulic2k1+aJQt4YimQPg07yysc5iwcPKdXhRCISnXyU3M63/6I/gmlQ4dzBua8Bu6ZYO
 UHIIoKP1NWXE0TRuSEwasM83vQFCS2QC1v7zI8oTnpkfjq5cGHjT+aINmgqZjWzBqRr2
 833w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220962; x=1688812962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ocX6egucweClanHXPfUXGJgty6BQ9b/kn/b9p27gG9o=;
 b=XqoHZWGo09zKteuMa9Sf5TCM36WbJe11FOD0Fqy3nebGzolweiZoyBzqli9HCp9pMm
 O/PJe5QeBdI72JXIBpDla/lttEeESPDIpItN+u7uescJGfl/hYR0Y+aL3cqP8skWpOkQ
 y7gF3lqvtxXetLpftf7MNuvMorUhd4jibfvNNp7qPoaHEQ9r99YSQga+cRNVxzq95Xwt
 KIcQX6XW/x1/IF9uGbEOueIaOJ2fmtngWO4jtchNgtk7GTOvFFgE1gAgFptfTZYpvQIO
 utxhHI3c6iN0Z9rGltsQS5rfT+mh9J4yLie48xPTZhNG/434qVT08fbRCQ/pr1SLOrVZ
 9HIA==
X-Gm-Message-State: AC+VfDxbF3N0wvPEtuMcQecHLyfALdkTSBrtgnObQIW6eknDI4vDhxcH
 zzQC5cvhE4K2QiJzar1PQs1DdR5yz/k=
X-Google-Smtp-Source: ACHHUZ5imLwg7/tvftN1ny4ieTLJ3jQgtun1p8FEL01qGoAt1hK/Qsj3iH8qJGS6Wxb3kST8MFGymA==
X-Received: by 2002:a19:4f0c:0:b0:4f6:4bf6:59a1 with SMTP id
 d12-20020a194f0c000000b004f64bf659a1mr1210820lfb.34.1686220961752; 
 Thu, 08 Jun 2023 03:42:41 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:41 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 16/33] target/mips: Add emulation of MXU D32ACC D32ACCM
 D32ASUM instructions
Date: Thu,  8 Jun 2023 13:42:05 +0300
Message-Id: <20230608104222.1520143-17-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x12d.google.com
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

These instructions are all dual 32-bit addition/subtraction in
various combinations. The instructions are grouped in pool12,
see the opcode organization in the file.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 160 ++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 03be624d86..56c894f4c7 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -379,6 +379,7 @@ enum {
     OPC_MXU__POOL10  = 0x16,
     OPC_MXU__POOL11  = 0x17,
     OPC_MXU_D32ADD   = 0x18,
+    OPC_MXU__POOL12  = 0x19,
     OPC_MXU_S8LDD    = 0x22,
     OPC_MXU__POOL16  = 0x27,
     OPC_MXU__POOL17  = 0x28,
@@ -441,6 +442,15 @@ enum {
     OPC_MXU_S32LDSTR = 0x01,
 };
 
+/*
+ * MXU pool 12
+ */
+enum {
+    OPC_MXU_D32ACC    = 0x00,
+    OPC_MXU_D32ACCM   = 0x01,
+    OPC_MXU_D32ASUM   = 0x02,
+};
+
 /*
  * MXU pool 16
  */
@@ -2310,6 +2320,132 @@ static void gen_mxu_d32add(DisasContext *ctx)
     }
 }
 
+/*
+ * D32ACC XRa, XRb, XRc, XRd, aptn2 - Double
+ * 32 bit pattern addition/subtraction and accumulate.
+ */
+static void gen_mxu_d32acc(DisasContext *ctx)
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
+
+    if (unlikely(XRa == 0 && XRd == 0)) {
+        /* destinations are zero register -> do nothing */
+    } else {
+        /* common case */
+        gen_load_mxu_gpr(t0, XRb);
+        gen_load_mxu_gpr(t1, XRc);
+        if (XRa != 0) {
+            if (aptn2 & 2) {
+                tcg_gen_sub_tl(t2, t0, t1);
+            } else {
+                tcg_gen_add_tl(t2, t0, t1);
+            }
+            tcg_gen_add_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t2);
+        }
+        if (XRd != 0) {
+            if (aptn2 & 1) {
+                tcg_gen_sub_tl(t2, t0, t1);
+            } else {
+                tcg_gen_add_tl(t2, t0, t1);
+            }
+            tcg_gen_add_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t2);
+        }
+    }
+}
+
+/*
+ * D32ACCM XRa, XRb, XRc, XRd, aptn2 - Double
+ * 32 bit pattern addition/subtraction and accumulate.
+ */
+static void gen_mxu_d32accm(DisasContext *ctx)
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
+
+    if (unlikely(XRa == 0 && XRd == 0)) {
+        /* destinations are zero register -> do nothing */
+    } else {
+        /* common case */
+        gen_load_mxu_gpr(t0, XRb);
+        gen_load_mxu_gpr(t1, XRc);
+        if (XRa != 0) {
+            tcg_gen_add_tl(t2, t0, t1);
+            if (aptn2 & 2) {
+                tcg_gen_sub_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t2);
+            } else {
+                tcg_gen_add_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t2);
+            }
+        }
+        if (XRd != 0) {
+            tcg_gen_sub_tl(t2, t0, t1);
+            if (aptn2 & 1) {
+                tcg_gen_sub_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t2);
+            } else {
+                tcg_gen_add_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t2);
+            }
+        }
+    }
+}
+
+/*
+ * D32ASUM XRa, XRb, XRc, XRd, aptn2 - Double
+ * 32 bit pattern addition/subtraction.
+ */
+static void gen_mxu_d32asum(DisasContext *ctx)
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
+
+    if (unlikely(XRa == 0 && XRd == 0)) {
+        /* destinations are zero register -> do nothing */
+    } else {
+        /* common case */
+        gen_load_mxu_gpr(t0, XRb);
+        gen_load_mxu_gpr(t1, XRc);
+        if (XRa != 0) {
+            if (aptn2 & 2) {
+                tcg_gen_sub_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+            } else {
+                tcg_gen_add_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+            }
+        }
+        if (XRd != 0) {
+            if (aptn2 & 1) {
+                tcg_gen_sub_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t1);
+            } else {
+                tcg_gen_add_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t1);
+            }
+        }
+    }
+}
+
 /*
  *                 MXU instruction category: Miscellaneous
  *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -2932,6 +3068,27 @@ static void decode_opc_mxu__pool11(DisasContext *ctx)
     }
 }
 
+static void decode_opc_mxu__pool12(DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 22, 2);
+
+    switch (opcode) {
+    case OPC_MXU_D32ACC:
+        gen_mxu_d32acc(ctx);
+        break;
+    case OPC_MXU_D32ACCM:
+        gen_mxu_d32accm(ctx);
+        break;
+    case OPC_MXU_D32ASUM:
+        gen_mxu_d32asum(ctx);
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
@@ -3097,6 +3254,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU_D32ADD:
             gen_mxu_d32add(ctx);
             break;
+        case OPC_MXU__POOL12:
+            decode_opc_mxu__pool12(ctx);
+            break;
         case OPC_MXU_S8LDD:
             gen_mxu_s8ldd(ctx);
             break;
-- 
2.40.0


