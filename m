Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B39874E11B
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:30:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzMM-000617-Ip; Mon, 10 Jul 2023 18:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzMK-00060L-E5
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:56 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzMI-0001re-Lz
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:56 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbef8ad9bbso56165155e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028073; x=1691620073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AU1HvItk70vnhoMbywXGUhi8V0SZiSsR4Yq02rZeJz4=;
 b=miqHtfuJfnxjGbyIA5VNBs86lwGZOxlsTUC2NUqDMcKOwp9TdhIPEWSQ7mfOznjjdc
 pe7dQ55GPwKxKntdKSeRRtPtqKB0QERyEstGAh+8gtElefCX3kNkNFd45N/VJyw/UxJ1
 Q8S0uN7GXqsJXOEHYlsKgSv0Jkyfv1tOzZYeZb5mG+22SApaYv7TE4PEehGzJ4V6RVx3
 TBj8nhcx3+4LC0qqNXX1UXoeKViCi3fL5XsxT+qlhJwSVYMoScUblO8ZaM3V74tRFURW
 GrwVQXgG0OabwBczQvOlYELxhBF6YtqYqOSfI5TAu/W4Q7ebdcAb38TDg27nln0S9e26
 qVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028073; x=1691620073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AU1HvItk70vnhoMbywXGUhi8V0SZiSsR4Yq02rZeJz4=;
 b=AAVB23/UUiJldiCLxEM8SmBGNbb83Q3ohwa51/L6Mf0E9C20XEHZztV/8Ll2wOIJWJ
 4gEWBt/LefPYzMrydKNKOcArHv3XPhqlwOLtzYDtpxvPSN6jVP4CnKHCNN+VNJhTLEfY
 umRlCp882fIkjd/enbKs3p8/uMQkvl9X+lWG3rznIjqc2lc02GHKjobIl9N3eDA2cR1X
 k1kKuS1u7wXzwaodDTn5IoaA54BZhFd7Tx4C5T/BZPLquW11Mr+YUo6lPZyRz4AyXvYT
 37pJuR4ktkl7rb8wqC8J2OS5AXwMoHsEek07ZHslSC+MJNU9iYrS011EETXpvm/aYyyn
 Yc+A==
X-Gm-Message-State: ABy/qLYim2YL1nKD7NEGIvhnCc+b6IDYpFsQn1uLB4eAp7fSib1wgP94
 /pcUp6E0EJgwe/VoZ2wEr5NqIEJa7IWdpk8MrZBTnA==
X-Google-Smtp-Source: APBJJlERLK232gCoEAGLavwmHTlwqV4fvOPVtUGlt3SzzVNTVd8e5KB2+yKvhsfqeRe/mXFfgnarxA==
X-Received: by 2002:adf:f8c3:0:b0:314:3985:b291 with SMTP id
 f3-20020adff8c3000000b003143985b291mr14190930wrq.15.1689028073144; 
 Mon, 10 Jul 2023 15:27:53 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 c14-20020adfed8e000000b0031411b7087dsm542729wro.20.2023.07.10.15.27.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:27:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 18/44] target/mips/mxu: Add D32ADD instruction
Date: Tue, 11 Jul 2023 00:25:45 +0200
Message-Id: <20230710222611.50978-19-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

The instruction adds/subtracts two 32-bit values in XRb and XRc.
Placing results in XRa and XRd and updates carry bits for each
path in the MXU control register.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-16-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 64 +++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index dc4fdf1dd9..b133f9f11d 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -376,6 +376,7 @@ enum {
     OPC_MXU__POOL09  = 0x15,
     OPC_MXU__POOL10  = 0x16,
     OPC_MXU__POOL11  = 0x17,
+    OPC_MXU_D32ADD   = 0x18,
     OPC_MXU_S8LDD    = 0x22,
     OPC_MXU__POOL16  = 0x27,
     OPC_MXU__POOL17  = 0x28,
@@ -2247,6 +2248,66 @@ static void gen_mxu_q16add(DisasContext *ctx)
     tcg_gen_or_tl(mxu_gpr[XRd - 1], t0, t1);
 }
 
+/*
+ * D32ADD XRa, XRb, XRc, XRd, aptn2 - Double
+ * 32 bit pattern addition/subtraction.
+ */
+static void gen_mxu_d32add(DisasContext *ctx)
+{
+    uint32_t aptn2, pad, XRc, XRb, XRa, XRd;
+
+    aptn2 = extract32(ctx->opcode, 24, 2);
+    pad   = extract32(ctx->opcode, 22, 2);
+    XRd   = extract32(ctx->opcode, 18, 4);
+    XRc   = extract32(ctx->opcode, 14, 4);
+    XRb   = extract32(ctx->opcode, 10, 4);
+    XRa   = extract32(ctx->opcode,  6, 4);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+    TCGv carry = tcg_temp_new();
+    TCGv cr = tcg_temp_new();
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0 && XRd == 0)) {
+        /* destinations are zero register -> do nothing */
+    } else {
+        /* common case */
+        gen_load_mxu_gpr(t0, XRb);
+        gen_load_mxu_gpr(t1, XRc);
+        gen_load_mxu_cr(cr);
+        if (XRa != 0) {
+            if (aptn2 & 2) {
+                tcg_gen_sub_i32(t2, t0, t1);
+                tcg_gen_setcond_tl(TCG_COND_GTU, carry, t0, t1);
+            } else {
+                tcg_gen_add_i32(t2, t0, t1);
+                tcg_gen_setcond_tl(TCG_COND_GTU, carry, t0, t2);
+            }
+            tcg_gen_andi_tl(cr, cr, 0x7fffffff);
+            tcg_gen_shli_tl(carry, carry, 31);
+            tcg_gen_or_tl(cr, cr, carry);
+            gen_store_mxu_gpr(t2, XRa);
+        }
+        if (XRd != 0) {
+            if (aptn2 & 1) {
+                tcg_gen_sub_i32(t2, t0, t1);
+                tcg_gen_setcond_tl(TCG_COND_GTU, carry, t0, t1);
+            } else {
+                tcg_gen_add_i32(t2, t0, t1);
+                tcg_gen_setcond_tl(TCG_COND_GTU, carry, t0, t2);
+            }
+            tcg_gen_andi_tl(cr, cr, 0xbfffffff);
+            tcg_gen_shli_tl(carry, carry, 30);
+            tcg_gen_or_tl(cr, cr, carry);
+            gen_store_mxu_gpr(t2, XRd);
+        }
+        gen_store_mxu_cr(cr);
+    }
+}
+
 /*
  *                 MXU instruction category: Miscellaneous
  *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -3031,6 +3092,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU__POOL11:
             decode_opc_mxu__pool11(ctx);
             break;
+        case OPC_MXU_D32ADD:
+            gen_mxu_d32add(ctx);
+            break;
         case OPC_MXU_S8LDD:
             gen_mxu_s8ldd(ctx);
             break;
-- 
2.38.1


