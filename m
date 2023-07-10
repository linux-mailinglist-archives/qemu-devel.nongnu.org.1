Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C8E74E10F
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:29:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzNB-0001YH-Ax; Mon, 10 Jul 2023 18:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzNA-0001V3-3C
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:48 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzN8-000247-El
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:47 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbdfda88f4so51776805e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028124; x=1691620124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3MsxiCt5nJiEc6wQO1pDa009vw+SZ+eH48A/Z+HwV3w=;
 b=SEUtmzUbDEhxPF2xY3DCyqGkUHzyxlcmmgZSJz1nncYOzxNdXlZjykpTahJqxUQ07R
 wlaDpaorXkWH1WeHxiyW/CtJTOjbOgeJqNq1ghS3c+5hCZwBJCbZqemzNqiwSqr/NK9+
 gRVvT5QRCGWAnukN4qYMoizo1kcsml8R0jPKyKb2AHf3s2eUls6E22f8nzV13O8FynMT
 XRhGI9AaiAhudTSCT6zKyifpnMxIqugb7kOdRJ5vDrYKC9digN5QGbJnQHJvLWzxsLpd
 DjrMrh4hzgQEJISjkav6dO8sbuMZvvt0Avn2sr5jWxI9nwP+tDWLWGao6eA8u6UAtxf+
 3nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028124; x=1691620124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3MsxiCt5nJiEc6wQO1pDa009vw+SZ+eH48A/Z+HwV3w=;
 b=MSInKqBRY0hPJ+n/mW2eq0kzDv7Zf5Vtwk3TnvQAW809Pl6VHp6ZC0meqamO+cvJPq
 B2i8MnbSzPZN6vfZLpqZ378VyU5Ky3JpLCkSXfXhrugpk360ry6CIy2FEND28yFffMcH
 ZvwqfhZ9IFIy3XqLx/5vDTSwwD2HzoGVMF8P1u7LXwVP9ueLCkPUk/qOMo1Qv8JN650v
 6MnJR/mKfbX8ifElHcqzbfimizBXptXAWj3k4KdNFBeWW5MUwdNEYwMDIQQAEr2CNGdG
 DfRLe+bS0DeFdMRlgXzDstCa2T2IeqAtlU/R05ZJdNfEUVWopjnX6MP8oTw2uvHFZ7Eq
 HCvA==
X-Gm-Message-State: ABy/qLbJGQBbVAVmNjlPPbnX8ht75uiyMkDg259sQeZQx2LwqeZTtsJ7
 /URdtMsYKknzO9YkuoceBF9O6O46epiQ0umLl0/Dcw==
X-Google-Smtp-Source: APBJJlGegwUaYnsRWFcsINNx/uiWQCeO/8YdjX3Oqgk0VCcHK0n7lhMoJU/+q2E2l0xpMlnx2nsB+A==
X-Received: by 2002:adf:fb07:0:b0:314:d19:fc31 with SMTP id
 c7-20020adffb07000000b003140d19fc31mr12409561wrr.51.1689028124664; 
 Mon, 10 Jul 2023 15:28:44 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 cr13-20020a05600004ed00b003143ba62cf4sm524681wrb.86.2023.07.10.15.28.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:28:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 28/44] target/mips/mxu: Add D32SLL D32SLR D32SAR instructions
Date: Tue, 11 Jul 2023 00:25:55 +0200
Message-Id: <20230710222611.50978-29-philmd@linaro.org>
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

These instructions are same data shift in various directions, thus one
generation function is implemented for all three.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-26-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 55 +++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 36fb4232cd..79263e97c3 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -394,7 +394,10 @@ enum {
     OPC_MXU_S16SDI   = 0x2D,
     OPC_MXU_S32M2I   = 0x2E,
     OPC_MXU_S32I2M   = 0x2F,
+    OPC_MXU_D32SLL   = 0x30,
+    OPC_MXU_D32SLR   = 0x31,
     OPC_MXU_D32SARL  = 0x32,
+    OPC_MXU_D32SAR   = 0x33,
     OPC_MXU__POOL19  = 0x38,
 };
 
@@ -1701,6 +1704,49 @@ static void gen_mxu_S32XOR(DisasContext *ctx)
  *               Q16SLLV   Q16SLRV   Q16SARV
  */
 
+/*
+ *  D32SLL XRa, XRd, XRb, XRc, SFT4
+ *    Dual 32-bit shift left from XRb and XRc to SFT4
+ *    bits (0..15). Store to XRa and XRd respectively.
+ *  D32SLR XRa, XRd, XRb, XRc, SFT4
+ *    Dual 32-bit shift logic right from XRb and XRc
+ *    to SFT4 bits (0..15). Store to XRa and XRd respectively.
+ *  D32SAR XRa, XRd, XRb, XRc, SFT4
+ *    Dual 32-bit shift arithmetic right from XRb and XRc
+ *    to SFT4 bits (0..15). Store to XRa and XRd respectively.
+ */
+static void gen_mxu_d32sxx(DisasContext *ctx, bool right, bool arithmetic)
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
+
+    gen_load_mxu_gpr(t0, XRb);
+    gen_load_mxu_gpr(t1, XRc);
+
+    if (right) {
+        if (arithmetic) {
+            tcg_gen_sari_tl(t0, t0, sft4);
+            tcg_gen_sari_tl(t1, t1, sft4);
+        } else {
+            tcg_gen_shri_tl(t0, t0, sft4);
+            tcg_gen_shri_tl(t1, t1, sft4);
+        }
+    } else {
+        tcg_gen_shli_tl(t0, t0, sft4);
+        tcg_gen_shli_tl(t1, t1, sft4);
+    }
+    gen_store_mxu_gpr(t0, XRa);
+    gen_store_mxu_gpr(t1, XRd);
+}
+
 /*
  *  D32SARL XRa, XRb, XRc, SFT4
  *    Dual shift arithmetic right 32-bit integers in XRb and XRc
@@ -4270,9 +4316,18 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU_S16SDI:
             gen_mxu_s16std(ctx, true);
             break;
+        case OPC_MXU_D32SLL:
+            gen_mxu_d32sxx(ctx, false, false);
+            break;
+        case OPC_MXU_D32SLR:
+            gen_mxu_d32sxx(ctx, true, false);
+            break;
         case OPC_MXU_D32SARL:
             gen_mxu_d32sarl(ctx, false);
             break;
+        case OPC_MXU_D32SAR:
+            gen_mxu_d32sxx(ctx, true, true);
+            break;
         case OPC_MXU__POOL19:
             decode_opc_mxu__pool19(ctx);
             break;
-- 
2.38.1


