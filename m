Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6A474E10C
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:28:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzMH-0005uR-IM; Mon, 10 Jul 2023 18:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzMF-0005j8-8S
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:51 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzMD-0001rO-Gf
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:51 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbc6ab5ff5so52525715e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028068; x=1691620068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c2gywGlg3U3R0miq997BeVmgkx+5ZHsZAXz08FZ2lJw=;
 b=vTbbqKg4hGH/ptcVd+ssjzSNCzvZDoVUIH+3H+K0+wDAyeOpxp+Hs4N4ZZQUPTSCU4
 pNevUhjqbFMtIwPM4nuG9g9FklTAE/4AFVBhKg1CtnsDuW3r5DEnFR3yFp1LfaUvVkyH
 +N2tzjoQvYWuDvCMUfLu3DDWlAjfGjcd1O7lmAawdr3K8EDR9CjzQsNjbr1SJCcyDXvT
 DINvKWPYyxRzZLX+BIqqZw0D4jACbRdIS4z+J1FF38ZX6sp/cpN76174M+UznNE7WQRu
 ptWOzoAG6pupnJr7Rs6PNrqf0QbJClgj8x8UB9fhNTauKd9unfaOSWCHp91/DeFGc3X2
 nuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028068; x=1691620068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c2gywGlg3U3R0miq997BeVmgkx+5ZHsZAXz08FZ2lJw=;
 b=SE0ydmXeU0tUkm8HQZhl4o91JsYPnMv8ZdQiwuxPf9OSdkP+ixgeaNejB1efEVQf1m
 PnCuKhbrhMfcxk0kAO4nouybfeAFBsRXVZS4KffwQlrhnXE3PpBWRpht8o1ouN/qpypr
 n+jYpxARHQeYQG2n+UWKvgvPH9ezJri1Ta0G5opF2Yk3Jk74q3Ti2tJtHeSO01ffGauG
 tmQDtmzlmfY9+WKLrLFvpnsPDIXKd2LQSSjLMIezlrdxSoJx97MZIhlyeoUCjB3vgQSA
 IlGXCTP62XbY/0ecz+V26s0IMp7M3wmlUT8hgE8JcJ6Yk0i41LTzkC+pv6QYj2lM/fVo
 VwTw==
X-Gm-Message-State: ABy/qLbzLec45rZDuwYUcdDubFHkCNYLq6+DXCrHTxT2USp/mYdIqKOz
 NodPjA1bQfAREltNCEy1zgZsG1gCl9+KucRAk92ztQ==
X-Google-Smtp-Source: APBJJlEsI8qvO++6ITapm1ox0JDCW8IDba0zw/lFXvW9ctMHVv1vk0oxf6HOTTrD/0ez86jcBEMWBw==
X-Received: by 2002:a05:600c:228d:b0:3f9:82f:bad1 with SMTP id
 13-20020a05600c228d00b003f9082fbad1mr12964818wmf.40.1689028067928; 
 Mon, 10 Jul 2023 15:27:47 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 hn32-20020a05600ca3a000b003fbdd5d0758sm891030wmb.22.2023.07.10.15.27.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:27:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 17/44] target/mips/mxu: Add Q16ADD instruction
Date: Tue, 11 Jul 2023 00:25:44 +0200
Message-Id: <20230710222611.50978-18-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

The instruction adds/subtracts four 16-bit packed in XRb and XRc.
Placing packed 16-bit results in XRa and XRd.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-15-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 89 +++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 88d5d659c6..dc4fdf1dd9 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -366,6 +366,7 @@ enum {
     OPC_MXU_D16MACF  = 0x0B,
     OPC_MXU_D16MADL  = 0x0C,
     OPC_MXU_S16MAD   = 0x0D,
+    OPC_MXU_Q16ADD   = 0x0E,
     OPC_MXU_D16MACE  = 0x0F,
     OPC_MXU__POOL04  = 0x10,
     OPC_MXU__POOL05  = 0x11,
@@ -2161,6 +2162,91 @@ static void gen_mxu_Q8ADD(DisasContext *ctx)
     }
 }
 
+/*
+ * Q16ADD XRa, XRb, XRc, XRd, aptn2, optn2 - Quad packed
+ * 16-bit pattern addition.
+ */
+static void gen_mxu_q16add(DisasContext *ctx)
+{
+    uint32_t aptn2, optn2, XRc, XRb, XRa, XRd;
+
+    aptn2 = extract32(ctx->opcode, 24, 2);
+    optn2 = extract32(ctx->opcode, 22, 2);
+    XRd   = extract32(ctx->opcode, 18, 4);
+    XRc   = extract32(ctx->opcode, 14, 4);
+    XRb   = extract32(ctx->opcode, 10, 4);
+    XRa   = extract32(ctx->opcode,  6, 4);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+    TCGv t3 = tcg_temp_new();
+    TCGv t4 = tcg_temp_new();
+    TCGv t5 = tcg_temp_new();
+
+    gen_load_mxu_gpr(t1, XRb);
+    tcg_gen_extract_tl(t0, t1,  0, 16);
+    tcg_gen_extract_tl(t1, t1, 16, 16);
+
+    gen_load_mxu_gpr(t3, XRc);
+    tcg_gen_extract_tl(t2, t3,  0, 16);
+    tcg_gen_extract_tl(t3, t3, 16, 16);
+
+    switch (optn2) {
+    case MXU_OPTN2_WW: /* XRB.H+XRC.H == lop, XRB.L+XRC.L == rop */
+        tcg_gen_mov_tl(t4, t1);
+        tcg_gen_mov_tl(t5, t0);
+        break;
+    case MXU_OPTN2_LW: /* XRB.L+XRC.H == lop, XRB.L+XRC.L == rop */
+        tcg_gen_mov_tl(t4, t0);
+        tcg_gen_mov_tl(t5, t0);
+        break;
+    case MXU_OPTN2_HW: /* XRB.H+XRC.H == lop, XRB.H+XRC.L == rop */
+        tcg_gen_mov_tl(t4, t1);
+        tcg_gen_mov_tl(t5, t1);
+        break;
+    case MXU_OPTN2_XW: /* XRB.L+XRC.H == lop, XRB.H+XRC.L == rop */
+        tcg_gen_mov_tl(t4, t0);
+        tcg_gen_mov_tl(t5, t1);
+        break;
+    }
+
+    switch (aptn2) {
+    case MXU_APTN2_AA: /* lop +, rop + */
+        tcg_gen_add_tl(t0, t4, t3);
+        tcg_gen_add_tl(t1, t5, t2);
+        tcg_gen_add_tl(t4, t4, t3);
+        tcg_gen_add_tl(t5, t5, t2);
+        break;
+    case MXU_APTN2_AS: /* lop +, rop + */
+        tcg_gen_sub_tl(t0, t4, t3);
+        tcg_gen_sub_tl(t1, t5, t2);
+        tcg_gen_add_tl(t4, t4, t3);
+        tcg_gen_add_tl(t5, t5, t2);
+        break;
+    case MXU_APTN2_SA: /* lop +, rop + */
+        tcg_gen_add_tl(t0, t4, t3);
+        tcg_gen_add_tl(t1, t5, t2);
+        tcg_gen_sub_tl(t4, t4, t3);
+        tcg_gen_sub_tl(t5, t5, t2);
+        break;
+    case MXU_APTN2_SS: /* lop +, rop + */
+        tcg_gen_sub_tl(t0, t4, t3);
+        tcg_gen_sub_tl(t1, t5, t2);
+        tcg_gen_sub_tl(t4, t4, t3);
+        tcg_gen_sub_tl(t5, t5, t2);
+        break;
+    }
+
+    tcg_gen_shli_tl(t0, t0, 16);
+    tcg_gen_extract_tl(t1, t1, 0, 16);
+    tcg_gen_shli_tl(t4, t4, 16);
+    tcg_gen_extract_tl(t5, t5, 0, 16);
+
+    tcg_gen_or_tl(mxu_gpr[XRa - 1], t4, t5);
+    tcg_gen_or_tl(mxu_gpr[XRd - 1], t0, t1);
+}
+
 /*
  *                 MXU instruction category: Miscellaneous
  *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -2906,6 +2992,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU_S16MAD:
             gen_mxu_s16mad(ctx);
             break;
+        case OPC_MXU_Q16ADD:
+            gen_mxu_q16add(ctx);
+            break;
         case OPC_MXU_D16MACE:
             gen_mxu_d16mac(ctx, true, false);
             break;
-- 
2.38.1


