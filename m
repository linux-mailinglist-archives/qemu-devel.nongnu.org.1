Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB5274E106
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:27:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzM9-0004iT-TX; Mon, 10 Jul 2023 18:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzM4-0004CY-QJ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:41 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzM3-0001qP-3H
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fc02a92dcfso32932285e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028057; x=1691620057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0etzPMoTBfN1VORUKR+U0D0LCT8oYv5PqzNMcPmRIw=;
 b=jmadiZwOlFxTnx23IDexFnDh9DKyFuEkZ2j+53bdtjZJogB8xz5JCEcrtbsqwzE9YD
 xbWDjJN7GpNb+oJ3oIQ7tvgch7n6dHNeTcERsis6A/uu6h+Q1C6jGmMjNjsSfoEs9q4A
 HTVzZE7P8gqO0nGaOOxDRUmPzHU8TlGiq8pkU+T9Axz6U3W5/7oEVwvRPrlpzmxZmvWn
 D3o00NWVW7LcQoiKfrQALTjYqjURdhdTMlrYIkCrB9vZO4Tl3QUhUjAmRvGhVgz5qFYo
 5VI2lxLwS7oa+lvfjFkDV/+Qs/IDZQ1Z9tgvCFOCRHZgFIuqQLf2mEluLRYAWMTULymV
 rk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028057; x=1691620057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W0etzPMoTBfN1VORUKR+U0D0LCT8oYv5PqzNMcPmRIw=;
 b=OkNjGx3862lb7LdbpBjF46+29pnPz1SII3M7dMk0A+1MZj3PKnpjXkMSy7Mbw6urVr
 BTVTKniLtQ+PgTKUdcm2AuPcGGilvC1bbH5oWUuO4lQWAGkQwrgebtfH6l4elaHwYD+4
 vlvLpQh83z8yhASLaa4iKxUXRJULGMuTRKHDn3J3zjiIhrOs3yDd46CwESKt8mSbivGq
 H2lzCi6qpnm/g33M20b//6gROy3LTUiFrZJRUFf8VE5fkFU/BidNtN7kkIyQ86xkPNK3
 LB4MrPLNMSpElJ8kSivEYjIuimArTjTr8QT2oIHCvJMZ6hNpF0AhqZV3p9XkN0qEAiBY
 0Aew==
X-Gm-Message-State: ABy/qLbNLhQdH9Gsc4oY28gfVpcRZDpXlaHHnEasjOZVvNtuOl4+UWjy
 swDW79lhFsOkvHkOBNy/ymHB5hDpNLzgjv+KQq19Ow==
X-Google-Smtp-Source: APBJJlHAXwSoA600fc1OZGZKPrfnKFtBCFMvMeRDXEqHHh33m/Q2IX48dQUsaESVG0IrPXFdOwqGUg==
X-Received: by 2002:a05:600c:2193:b0:3f9:b955:5584 with SMTP id
 e19-20020a05600c219300b003f9b9555584mr13024472wme.34.1689028057223; 
 Mon, 10 Jul 2023 15:27:37 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 f1-20020a5d50c1000000b0031438e42599sm520750wrt.82.2023.07.10.15.27.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:27:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 15/44] target/mips/mxu: Add D16MADL instruction
Date: Tue, 11 Jul 2023 00:25:42 +0200
Message-Id: <20230710222611.50978-16-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

The instruction is similar to multiply and accumulate
but works with MXU registers set.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-13-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 82 +++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index b58fad4436..202e1c6d35 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -364,6 +364,7 @@ enum {
     OPC_MXU__POOL03  = 0x09,
     OPC_MXU_D16MAC   = 0x0A,
     OPC_MXU_D16MACF  = 0x0B,
+    OPC_MXU_D16MADL  = 0x0C,
     OPC_MXU_D16MACE  = 0x0F,
     OPC_MXU__POOL04  = 0x10,
     OPC_MXU__POOL05  = 0x11,
@@ -899,6 +900,84 @@ static void gen_mxu_d16mac(DisasContext *ctx, bool fractional,
     }
 }
 
+/*
+ * D16MADL XRa, XRb, XRc, XRd, aptn2, optn2 - Double packed
+ * unsigned 16 bit pattern multiply and add/subtract.
+ */
+static void gen_mxu_d16madl(DisasContext *ctx)
+{
+    TCGv t0, t1, t2, t3;
+    uint32_t XRa, XRb, XRc, XRd, optn2, aptn2;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+    t2 = tcg_temp_new();
+    t3 = tcg_temp_new();
+
+    XRa = extract32(ctx->opcode, 6, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRd = extract32(ctx->opcode, 18, 4);
+    optn2 = extract32(ctx->opcode, 22, 2);
+    aptn2 = extract32(ctx->opcode, 24, 2);
+
+    gen_load_mxu_gpr(t1, XRb);
+    tcg_gen_sextract_tl(t0, t1,  0, 16);
+    tcg_gen_sextract_tl(t1, t1, 16, 16);
+
+    gen_load_mxu_gpr(t3, XRc);
+    tcg_gen_sextract_tl(t2, t3,  0, 16);
+    tcg_gen_sextract_tl(t3, t3, 16, 16);
+
+    switch (optn2) {
+    case MXU_OPTN2_WW: /* XRB.H*XRC.H == lop, XRB.L*XRC.L == rop */
+        tcg_gen_mul_tl(t3, t1, t3);
+        tcg_gen_mul_tl(t2, t0, t2);
+        break;
+    case MXU_OPTN2_LW: /* XRB.L*XRC.H == lop, XRB.L*XRC.L == rop */
+        tcg_gen_mul_tl(t3, t0, t3);
+        tcg_gen_mul_tl(t2, t0, t2);
+        break;
+    case MXU_OPTN2_HW: /* XRB.H*XRC.H == lop, XRB.H*XRC.L == rop */
+        tcg_gen_mul_tl(t3, t1, t3);
+        tcg_gen_mul_tl(t2, t1, t2);
+        break;
+    case MXU_OPTN2_XW: /* XRB.L*XRC.H == lop, XRB.H*XRC.L == rop */
+        tcg_gen_mul_tl(t3, t0, t3);
+        tcg_gen_mul_tl(t2, t1, t2);
+        break;
+    }
+    tcg_gen_extract_tl(t2, t2, 0, 16);
+    tcg_gen_extract_tl(t3, t3, 0, 16);
+
+    gen_load_mxu_gpr(t1, XRa);
+    tcg_gen_extract_tl(t0, t1,  0, 16);
+    tcg_gen_extract_tl(t1, t1, 16, 16);
+
+    switch (aptn2) {
+    case MXU_APTN2_AA:
+        tcg_gen_add_tl(t3, t1, t3);
+        tcg_gen_add_tl(t2, t0, t2);
+        break;
+    case MXU_APTN2_AS:
+        tcg_gen_add_tl(t3, t1, t3);
+        tcg_gen_sub_tl(t2, t0, t2);
+        break;
+    case MXU_APTN2_SA:
+        tcg_gen_sub_tl(t3, t1, t3);
+        tcg_gen_add_tl(t2, t0, t2);
+        break;
+    case MXU_APTN2_SS:
+        tcg_gen_sub_tl(t3, t1, t3);
+        tcg_gen_sub_tl(t2, t0, t2);
+        break;
+    }
+
+    tcg_gen_andi_tl(t2, t2, 0xffff);
+    tcg_gen_shli_tl(t3, t3, 16);
+    tcg_gen_or_tl(mxu_gpr[XRd - 1], t3, t2);
+}
+
 /*
  * Q8MUL   XRa, XRb, XRc, XRd - Parallel unsigned 8 bit pattern multiply
  * Q8MULSU XRa, XRb, XRc, XRd - Parallel signed 8 bit pattern multiply
@@ -2759,6 +2838,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU_D16MACF:
             gen_mxu_d16mac(ctx, true, true);
             break;
+        case OPC_MXU_D16MADL:
+            gen_mxu_d16madl(ctx);
+            break;
         case OPC_MXU_D16MACE:
             gen_mxu_d16mac(ctx, true, false);
             break;
-- 
2.38.1


