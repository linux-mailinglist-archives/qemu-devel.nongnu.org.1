Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B2374E133
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:33:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzNH-000231-Be; Mon, 10 Jul 2023 18:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzNE-0001n6-VK
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:52 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzND-00024f-7Z
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:52 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57dcso56177905e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028129; x=1691620129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w24qCGipOFLgfiJ0fjsZXsRTZKWbqT9NbJtcLXAN6Ok=;
 b=aQ1PsucQ07ewoyVYYnvmTDM3PLf9s+XEUOASDvuZwBhuerIz/p7qtLN2BJEjw6vDuT
 bHmQaAXwPcdpV9zAYzGDBp9o6h6Sovny/6+5YiSn5QN4VcJOCwV5RhIVKXmPClWydEts
 9v9iOfeiOA0C2Ef7fzSjuUqULZbtGmor5Qg+bfgYdp7DxRX8DQpGMTcJqcSEc3wyS9J7
 B4N1KHcooYqQ9X2DjzQ1J7NQ1+gb59cvrpo62BCLUsB5K/YHbC9tdvU12irBqBUpoQRY
 sEpywLBwLxmtppqASkEyH5yVpph4ud2MCSqQ6I1Pg3oHimgnH2l/aWVV/6q7RbsLGHHY
 ywOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028129; x=1691620129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w24qCGipOFLgfiJ0fjsZXsRTZKWbqT9NbJtcLXAN6Ok=;
 b=d1/PsPdCFvjUgIC58OXqdJoFHs0Dc+tYi3a1CVcBrqnwTTvfwX25Yy+YwkYzF/K6z2
 uhIO/dl7mUQ75fYcwdqYrr2/fTK1zK5FxZYWz5RnvVYLvlteisiNxER+Ef6BoD2kW1xd
 wyqabSW4HPwEnrEWUsQmEjTQcA7e6YM7SR29bLECbrzNvglTpsopWfU4mkojzTNXt+tt
 rz+48+1c2vuuyBW/q5tcvUTQHVBptsfR6KZj5ZNcyb/SPc0C0aEzZEiuhihJJjWvqhg1
 2CKL6bRVhe0+cL9q1+x7VcJ4QVrvTX8CDA3H4sd/4dYDkFZS76C+8JBsGLsCSQYl0N7E
 M6dQ==
X-Gm-Message-State: ABy/qLblUJ0Soldj0+qZBUCNNV0nbbU/lS3Wm+hlgBnH62EWd7MBOMji
 1AZYbjm/9qa8JL0GcbLqUdoN26CRKOhI1AmSzqSqEQ==
X-Google-Smtp-Source: APBJJlGjCalkFihAN0S9yYH7ATw02ug1ttn592AxAA3qI144uYtwBXo0zTE54JXiZJ1oPvEFQlAmvQ==
X-Received: by 2002:a05:600c:378d:b0:3fc:e1:24b5 with SMTP id
 o13-20020a05600c378d00b003fc00e124b5mr8770498wmr.23.1689028129812; 
 Mon, 10 Jul 2023 15:28:49 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 13-20020a05600c228d00b003fbe4cecc3bsm11324921wmf.16.2023.07.10.15.28.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:28:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 29/44] target/mips/mxu: Add Q16SLL Q16SLR Q16SAR instructions
Date: Tue, 11 Jul 2023 00:25:56 +0200
Message-Id: <20230710222611.50978-30-philmd@linaro.org>
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
Message-Id: <20230608104222.1520143-27-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 78 +++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 79263e97c3..672b0041b5 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -398,6 +398,9 @@ enum {
     OPC_MXU_D32SLR   = 0x31,
     OPC_MXU_D32SARL  = 0x32,
     OPC_MXU_D32SAR   = 0x33,
+    OPC_MXU_Q16SLL   = 0x34,
+    OPC_MXU_Q16SLR   = 0x35,
+    OPC_MXU_Q16SAR   = 0x37,
     OPC_MXU__POOL19  = 0x38,
 };
 
@@ -1789,6 +1792,72 @@ static void gen_mxu_d32sarl(DisasContext *ctx, bool sarw)
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
@@ -4328,6 +4397,15 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
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
2.38.1


