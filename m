Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A277372812C
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:21:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWz-0003pY-IQ; Thu, 08 Jun 2023 09:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6X-0002Q2-31
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:57 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6V-0006bl-8o
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:56 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4f62d93f38aso575702e87.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220973; x=1688812973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6tYw+AoezPC+Runh3S/Ff5huRkr12otKbVI1apGCIVA=;
 b=JtHImBG+bfLE08Ek9Trs80hO62LAB/94teVgVhb7daATauWqpULjVx2jKhFuZYkctd
 jcl67YoLYLYT0wsVyQ1X+9kg4POqKn1h/KPcCsvHe0h1Pgv/i40a2iYtZHFHg+g6IG+r
 NzPzXLTY8cEmPYD0B9GxFkEgi6VFKG4bT3mM+aElhUvFQm29nm0zeKYWCU8O3Hq8sxc1
 Vb4TV2H9sznc2rQc/zgJ0MjVTvJ7kGl7smN34CVImKJRbqZTF5mVqv5+1zxAvM+/t/Vt
 E2VreETSu+99L56pzB2+Hvib14YTpv6Uwn+0Ev996nBrHYWDyrKEtH6PLih11RIdaREK
 5/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220973; x=1688812973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6tYw+AoezPC+Runh3S/Ff5huRkr12otKbVI1apGCIVA=;
 b=loZZsCsSGCXBINFdXaZB7yI9sTDGsWmVZwHLfd07Yf7WUlHtMBAw4EtUScc8YcNbMC
 1xruqJ3KbOzLwomUW7p6GoCHZnxRcASOna8zFXRAD/yimfwJITmC50vTuptdDRtZNYiO
 wNFu1nvUqIrHP/fLQSxrOzxxyvOllOKBYQqkolPVIRs4eGo/MoCOAXPKSULecKyWlhZw
 Z1XMAgdplNb9dSL8dsNzADitEZcLddPNyOG3jb/CRYFte0KwQ7azAsU4YbU5wkaas4uO
 zyyDegI6d/uNtIRCQKVI5YqeTcSr7z8Xu8svV6vvdv589ujIVsj+qQkyo1D/Nq52wSL7
 uNuw==
X-Gm-Message-State: AC+VfDyUo37UYYE0G523Q4m/jDRXLKiMDFfgOy7Xf6sXNdWDXH8H3F9j
 53+v8iCaA2BLvIO/uKJxmsWFcqq3XeY=
X-Google-Smtp-Source: ACHHUZ6EYJ7ZizzXpZaToxIhrVlbJSqQhkvxOobpG+OqPxB+KEoeTOnypXSQX4YUx3LnBK3x764uZA==
X-Received: by 2002:a19:4f1b:0:b0:4f6:54f1:ea37 with SMTP id
 d27-20020a194f1b000000b004f654f1ea37mr148914lfb.42.1686220973022; 
 Thu, 08 Jun 2023 03:42:53 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:52 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 26/33] target/mips: Add emulation of MXU Q16SLL Q16SLR Q16SAR
 instructions
Date: Thu,  8 Jun 2023 13:42:15 +0300
Message-Id: <20230608104222.1520143-27-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x134.google.com
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

These instructions are same data shift in various directions, thus one
generation function is implemented for all three.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 78 +++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 93644d74e2..418c02eb8e 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -400,6 +400,9 @@ enum {
     OPC_MXU_D32SLR   = 0x31,
     OPC_MXU_D32SARL  = 0x32,
     OPC_MXU_D32SAR   = 0x33,
+    OPC_MXU_Q16SLL   = 0x34,
+    OPC_MXU_Q16SLR   = 0x35,
+    OPC_MXU_Q16SAR   = 0x37,
     OPC_MXU__POOL19  = 0x38,
 };
 
@@ -1791,6 +1794,72 @@ static void gen_mxu_d32sarl(DisasContext *ctx, bool sarw)
     }
 }
 
+/*
+ *  Q16SLL XRa, XRd, XRb, XRc, SFT4
+ *    Quad 16-bit shift left from XRb and XRc to SFT4
+ *    bits (0..15). Store to XRa and XRd respectively.
+ *  Q16SLR XRa, XRd, XRb, XRc, SFT4
+ *    Quad 16-bit shift logic right from XRb and XRc
+ *    to SFT4 bits (0..15). Store to XRa and XRd respectively.
+ *  Q16SAR XRa, XRd, XRb, XRc, SFT4
+ *    Quad 16-bit shift arithmetic right from XRb and XRc
+ *    to SFT4 bits (0..15). Store to XRa and XRd respectively.
+ */
+static void gen_mxu_q16sxx(DisasContext *ctx, bool right, bool arithmetic)
+{
+    uint32_t XRa, XRb, XRc, XRd, sft4;
+
+    XRa  = extract32(ctx->opcode,  6, 4);
+    XRb  = extract32(ctx->opcode, 10, 4);
+    XRc  = extract32(ctx->opcode, 14, 4);
+    XRd  = extract32(ctx->opcode, 18, 4);
+    sft4 = extract32(ctx->opcode, 22, 4);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+    TCGv t3 = tcg_temp_new();
+
+    gen_load_mxu_gpr(t0, XRb);
+    gen_load_mxu_gpr(t2, XRc);
+
+    if (arithmetic) {
+        tcg_gen_sextract_tl(t1, t0, 16, 16);
+        tcg_gen_sextract_tl(t0, t0,  0, 16);
+        tcg_gen_sextract_tl(t3, t2, 16, 16);
+        tcg_gen_sextract_tl(t2, t2,  0, 16);
+    } else {
+        tcg_gen_extract_tl(t1, t0, 16, 16);
+        tcg_gen_extract_tl(t0, t0,  0, 16);
+        tcg_gen_extract_tl(t3, t2, 16, 16);
+        tcg_gen_extract_tl(t2, t2,  0, 16);
+    }
+
+    if (right) {
+        if (arithmetic) {
+            tcg_gen_sari_tl(t0, t0, sft4);
+            tcg_gen_sari_tl(t1, t1, sft4);
+            tcg_gen_sari_tl(t2, t2, sft4);
+            tcg_gen_sari_tl(t3, t3, sft4);
+        } else {
+            tcg_gen_shri_tl(t0, t0, sft4);
+            tcg_gen_shri_tl(t1, t1, sft4);
+            tcg_gen_shri_tl(t2, t2, sft4);
+            tcg_gen_shri_tl(t3, t3, sft4);
+        }
+    } else {
+        tcg_gen_shli_tl(t0, t0, sft4);
+        tcg_gen_shli_tl(t1, t1, sft4);
+        tcg_gen_shli_tl(t2, t2, sft4);
+        tcg_gen_shli_tl(t3, t3, sft4);
+    }
+    tcg_gen_deposit_tl(t0, t0, t1, 16, 16);
+    tcg_gen_deposit_tl(t2, t2, t3, 16, 16);
+
+    gen_store_mxu_gpr(t0, XRa);
+    gen_store_mxu_gpr(t2, XRd);
+}
+
 /*
  *                   MXU instruction category max/min/avg
  *                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -4330,6 +4399,15 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU_D32SAR:
             gen_mxu_d32sxx(ctx, true, true);
             break;
+        case OPC_MXU_Q16SLL:
+            gen_mxu_q16sxx(ctx, false, false);
+            break;
+        case OPC_MXU_Q16SLR:
+            gen_mxu_q16sxx(ctx, true, false);
+            break;
+        case OPC_MXU_Q16SAR:
+            gen_mxu_q16sxx(ctx, true, true);
+            break;
         case OPC_MXU__POOL19:
             decode_opc_mxu__pool19(ctx);
             break;
-- 
2.40.0


