Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D6574E109
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:28:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzMW-0006Rn-8j; Mon, 10 Jul 2023 18:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzMV-0006RR-3y
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:07 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzMT-0001su-G6
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:06 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3144098df56so5809438f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028083; x=1691620083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a6rUXAteCDM3yinm9Mi50Z+IwG3Y1n6ccXie7HTooFg=;
 b=Qbg4oqPO5DCRLWRHRhTtaLiC5LSwgTcJvsii+pIWTDNvQY95wFBs8d1zr0rPkZv4hH
 xhQwEMhIICvZp+sINqYF/NIOm+/cB7xsRe7oJK14euQ4008ecm0mYZ2dJi049BacYy2F
 35izpecOxgyhbphh++yw9HaMqbmraRNop6mJwROvmaCM4Wq9BqbS6Z5AXt0EjQwfu4yj
 9fs2MewHjgFhM71Gi5cb0zPiF/2KMWZ8g3k9vueS/Skxkn1yd1rvHMuCMVpXYapEfWYQ
 zv21nJliXaKTfcSvSAAWSs3xeDV2Ck+VI1x5M+tCxHt8igANyoNkZ7SspQ/3xBWBR6Lv
 FRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028083; x=1691620083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a6rUXAteCDM3yinm9Mi50Z+IwG3Y1n6ccXie7HTooFg=;
 b=WxZs89Cy6JN9fh73E4u6fYdJB6xS32w4ptwrM0mruIatQwRNKGJ+twonW5iebn7RrR
 pGfN/53ChpBnXE894YUTwX83Ke5Eg1jVHdhfeO8ImlnTADPUmpv5YQyodfELrXf4O/tu
 +LrewOp5lJYwlnHIpLs/lR4y8n8l5SFhcuKY/Z+ZAUdksjgDu76g6SyHc62Gli9PFJvV
 EfeziX+kLqg3EBGaRUKml9M8dVkEz607i7oL3PnR0MPGAjAn92DBCWptkE5ZDNs3bX7n
 7zZEDFKUlsS1nirS8BViicR0QZK0tPUjYRfxDZDbSMGK7AuVFLKoZ56Qd+d07vDTMCLO
 4obw==
X-Gm-Message-State: ABy/qLa5cFqeZzAGO3QCqslSVh3esOru5LBm3zCC+50dhOieODigdiMz
 RyUqMlvpm3mpLWm2OnkaKEObo+V8jXEVkYeiwi/+6w==
X-Google-Smtp-Source: APBJJlGvzaAmEgBWy/L870uIiVbdFJJ/CqgR+wgUvTWL9DsdW2Q6ejruHTivWWPGVg3hlrQbNlFkxA==
X-Received: by 2002:adf:df90:0:b0:314:9189:ce17 with SMTP id
 z16-20020adfdf90000000b003149189ce17mr10126533wrl.48.1689028083565; 
 Mon, 10 Jul 2023 15:28:03 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 f14-20020adfe90e000000b0030647449730sm523187wrm.74.2023.07.10.15.28.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:28:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 20/44] target/mips/mxu: Add D32ADDC instruction
Date: Tue, 11 Jul 2023 00:25:47 +0200
Message-Id: <20230710222611.50978-21-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

The instruction adds two 32-bit values with respect
to corresponding carry flags in MXU_CR.
XRa += XRb + LeftCarry flag;
XRd += XRc + RightCarry flag;
Suddenly, it doesn't modify carry flags as a result of addition.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-18-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 39 +++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 82a07040c6..84e8f760e4 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -268,7 +268,7 @@
  *          │                               13..10
  *          ├─ 010111 ─ OPC_MXU__POOL11 ─┬─ 0000 ─ OPC_MXU_S32SDIV
  *          │                            └─ 0001 ─ OPC_MXU_S32SDIVR
- *          ├─ 011000 ─ OPC_MXU_D32ADD
+ *          ├─ 011000 ─ OPC_MXU_D32ADD  (catches D32ADDC too)
  *          │                               23..22
  *   MXU    ├─ 011001 ─ OPC_MXU__POOL12 ─┬─ 00 ─ OPC_MXU_D32ACC
  * opcodes ─┤                            ├─ 01 ─ OPC_MXU_D32ACCM
@@ -2260,14 +2260,17 @@ static void gen_mxu_q16add(DisasContext *ctx)
 
 /*
  * D32ADD XRa, XRb, XRc, XRd, aptn2 - Double
- * 32 bit pattern addition/subtraction.
+ * 32 bit pattern addition/subtraction, set carry.
+ *
+ * D32ADDC XRa, XRb, XRc, XRd, aptn2 - Double
+ * 32 bit pattern addition/subtraction with carry.
  */
 static void gen_mxu_d32add(DisasContext *ctx)
 {
-    uint32_t aptn2, pad, XRc, XRb, XRa, XRd;
+    uint32_t aptn2, addc, XRc, XRb, XRa, XRd;
 
     aptn2 = extract32(ctx->opcode, 24, 2);
-    pad   = extract32(ctx->opcode, 22, 2);
+    addc  = extract32(ctx->opcode, 22, 2);
     XRd   = extract32(ctx->opcode, 18, 4);
     XRc   = extract32(ctx->opcode, 14, 4);
     XRb   = extract32(ctx->opcode, 10, 4);
@@ -2276,15 +2279,37 @@ static void gen_mxu_d32add(DisasContext *ctx)
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
     TCGv t2 = tcg_temp_new();
-    TCGv carry = tcg_temp_new();
     TCGv cr = tcg_temp_new();
 
-    if (unlikely(pad != 0)) {
-        /* opcode padding incorrect -> do nothing */
+    if (unlikely(addc > 1)) {
+        /* opcode incorrect -> do nothing */
+    } else if (addc == 1) {
+        if (unlikely(XRa == 0 && XRd == 0)) {
+            /* destinations are zero register -> do nothing */
+        } else {
+            /* FIXME ??? What if XRa == XRd ??? */
+            /* aptn2 is unused here */
+            gen_load_mxu_gpr(t0, XRb);
+            gen_load_mxu_gpr(t1, XRc);
+            gen_load_mxu_cr(cr);
+            if (XRa != 0) {
+                tcg_gen_extract_tl(t2, cr, 31, 1);
+                tcg_gen_add_tl(t0, t0, t2);
+                tcg_gen_add_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+            }
+            if (XRd != 0) {
+                tcg_gen_extract_tl(t2, cr, 30, 1);
+                tcg_gen_add_tl(t1, t1, t2);
+                tcg_gen_add_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t1);
+            }
+        }
     } else if (unlikely(XRa == 0 && XRd == 0)) {
         /* destinations are zero register -> do nothing */
     } else {
         /* common case */
+        /* FIXME ??? What if XRa == XRd ??? */
+        TCGv carry = tcg_temp_new();
+
         gen_load_mxu_gpr(t0, XRb);
         gen_load_mxu_gpr(t1, XRc);
         gen_load_mxu_cr(cr);
-- 
2.38.1


