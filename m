Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CFB74E12C
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:32:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzNn-0003PL-5m; Mon, 10 Jul 2023 18:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzNl-0003Ls-61
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:25 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzNj-00029x-Hp
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:24 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbc656873eso63881645e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028161; x=1691620161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=olCE9WSawbC5JQmxGAo+xHeL9zp5d/vNOzhW5eRBh7k=;
 b=JZDu5aJ2HJ6iVL2+oe2xuhiazVCCtclQyXGZDhrHqno/bHP7siKTWJuIb6zaAeCB0V
 K649QFH3/484lunI5N6PaxIIanwlX6l/qQal5SkGTN0hrgVfecnh4O3/llAZNIkeE+dS
 w3nN0xjKRU/vK8/3TyB+gpZWQiZ2Drg+9vjVGlUSSk8RlHd6QisR3bQDNC7srSXEObKK
 tgFIrPTn72YyPqNih8T5tj5qPKVbTkw6On4xx2gsx0STwWDJu/Oe7hkQ1jicwvDig801
 kCDpzCZ2Gy0ESdaHYL4H3HfChppWL1QvAbx81erfBcIoidykKXhD7Q8tibLRZSJkiMXJ
 vqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028161; x=1691620161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=olCE9WSawbC5JQmxGAo+xHeL9zp5d/vNOzhW5eRBh7k=;
 b=QHHyaSPAS/TdMxcPbnKOZ8+jR2z8nZ0F6ck9PnK94nugCSEhCVJlFQ4Be/C/ORYB4T
 N7nKTGef3lIA0sPt5jfH5F+Fvb1Niysf4gEakI/8h2Te3ZfnYtoTXu+cfXKKQaB3Ay/U
 +SaKJRrEwDf31IVg84h6zo5GS7opcFxeZdRVGD+/QCD4s14gRvhjVhXkovC/bhAkyu/S
 iEUUOBeVyB3zf5A7Xat3DM7Ioe+doVYAvIN9e03M07chF09kThVR+d5TYg8KQVU8FKK9
 kUr4NTghU7ounMDLYNYdIYz9k+9H5p6HGrJLVLYAEHVLMre1ELCqHt9mZcltgTB8fwc/
 ur+A==
X-Gm-Message-State: ABy/qLZBpHGWEXzWtghVhFcINpVVi94VzEeiC7gTdxSedg+afU8fkRnF
 iC1Kl7cFx+AazQTiDuGIPhfis9j+mGnS7T64jmse1w==
X-Google-Smtp-Source: APBJJlHGiesKkoc7OEzfOs8JcmKqTrbGoj0C2BUMGDX+4tmFaZoce3QtaUDXOi1QfL79ICh9Eki81A==
X-Received: by 2002:a5d:5301:0:b0:314:44c8:aa98 with SMTP id
 e1-20020a5d5301000000b0031444c8aa98mr14841139wrv.67.1689028161039; 
 Mon, 10 Jul 2023 15:29:21 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 y18-20020adffa52000000b00313f031876esm535652wrr.43.2023.07.10.15.29.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:29:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 35/44] target/mips/mxu: Add S32SFL instruction
Date: Tue, 11 Jul 2023 00:26:02 +0200
Message-Id: <20230710222611.50978-36-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

The instruction shuffles 8 bytes in two registers by
one of 4 predefined patterns.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-33-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 81 +++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 84c52c55d6..c60404f739 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -407,6 +407,7 @@ enum {
     OPC_MXU__POOL21  = 0x3A,
     OPC_MXU_Q16SCOP  = 0x3B,
     OPC_MXU_Q8MADL   = 0x3C,
+    OPC_MXU_S32SFL   = 0x3D,
 };
 
 
@@ -3961,6 +3962,83 @@ static void gen_mxu_q16scop(DisasContext *ctx)
     gen_store_mxu_gpr(t4, XRd);
 }
 
+/*
+ *  S32SFL XRa, XRd, XRb, XRc
+ *    Shuffle bytes according to one of four patterns.
+ */
+static void gen_mxu_s32sfl(DisasContext *ctx)
+{
+    uint32_t XRd, XRc, XRb, XRa, ptn2;
+
+    XRd  = extract32(ctx->opcode, 18, 4);
+    XRc  = extract32(ctx->opcode, 14, 4);
+    XRb  = extract32(ctx->opcode, 10, 4);
+    XRa  = extract32(ctx->opcode,  6, 4);
+    ptn2 = extract32(ctx->opcode, 24, 2);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+    TCGv t3 = tcg_temp_new();
+
+    gen_load_mxu_gpr(t0, XRb);
+    gen_load_mxu_gpr(t1, XRc);
+
+    switch (ptn2) {
+    case 0:
+        tcg_gen_andi_tl(t2, t0, 0xff000000);
+        tcg_gen_andi_tl(t3, t1, 0x000000ff);
+        tcg_gen_deposit_tl(t3, t3, t0,  8, 8);
+        tcg_gen_shri_tl(t0, t0,  8);
+        tcg_gen_shri_tl(t1, t1,  8);
+        tcg_gen_deposit_tl(t3, t3, t0, 24, 8);
+        tcg_gen_deposit_tl(t3, t3, t1, 16, 8);
+        tcg_gen_shri_tl(t0, t0,  8);
+        tcg_gen_shri_tl(t1, t1,  8);
+        tcg_gen_deposit_tl(t2, t2, t0,  8, 8);
+        tcg_gen_deposit_tl(t2, t2, t1,  0, 8);
+        tcg_gen_shri_tl(t1, t1,  8);
+        tcg_gen_deposit_tl(t2, t2, t1, 16, 8);
+        break;
+    case 1:
+        tcg_gen_andi_tl(t2, t0, 0xff000000);
+        tcg_gen_andi_tl(t3, t1, 0x000000ff);
+        tcg_gen_deposit_tl(t3, t3, t0, 16, 8);
+        tcg_gen_shri_tl(t0, t0,  8);
+        tcg_gen_shri_tl(t1, t1,  8);
+        tcg_gen_deposit_tl(t2, t2, t0, 16, 8);
+        tcg_gen_deposit_tl(t2, t2, t1,  0, 8);
+        tcg_gen_shri_tl(t0, t0,  8);
+        tcg_gen_shri_tl(t1, t1,  8);
+        tcg_gen_deposit_tl(t3, t3, t0, 24, 8);
+        tcg_gen_deposit_tl(t3, t3, t1,  8, 8);
+        tcg_gen_shri_tl(t1, t1,  8);
+        tcg_gen_deposit_tl(t2, t2, t1,  8, 8);
+        break;
+    case 2:
+        tcg_gen_andi_tl(t2, t0, 0xff00ff00);
+        tcg_gen_andi_tl(t3, t1, 0x00ff00ff);
+        tcg_gen_deposit_tl(t3, t3, t0,  8, 8);
+        tcg_gen_shri_tl(t0, t0, 16);
+        tcg_gen_shri_tl(t1, t1,  8);
+        tcg_gen_deposit_tl(t2, t2, t1,  0, 8);
+        tcg_gen_deposit_tl(t3, t3, t0, 24, 8);
+        tcg_gen_shri_tl(t1, t1, 16);
+        tcg_gen_deposit_tl(t2, t2, t1, 16, 8);
+        break;
+    case 3:
+        tcg_gen_andi_tl(t2, t0, 0xffff0000);
+        tcg_gen_andi_tl(t3, t1, 0x0000ffff);
+        tcg_gen_shri_tl(t1, t1, 16);
+        tcg_gen_deposit_tl(t2, t2, t1,  0, 16);
+        tcg_gen_deposit_tl(t3, t3, t0, 16, 16);
+        break;
+    }
+
+    gen_store_mxu_gpr(t2, XRa);
+    gen_store_mxu_gpr(t3, XRd);
+}
+
 /*
  *                 MXU instruction category: align
  *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -4959,6 +5037,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU_Q8MADL:
             gen_mxu_q8madl(ctx);
             break;
+        case OPC_MXU_S32SFL:
+            gen_mxu_s32sfl(ctx);
+            break;
         default:
             return false;
         }
-- 
2.38.1


