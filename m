Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB47728143
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:22:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWV-0003MX-6J; Thu, 08 Jun 2023 09:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D68-0002HF-AX
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:32 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D65-0006T8-MN
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:32 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f4b384c09fso550675e87.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220948; x=1688812948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8suom5c4Zq4IF9eAO/a9IEhcFRdmjk/0kY8XvnG0/LY=;
 b=kVpQ1LHFCdWohz4c7M836qBkX11sW4ym72CNENgc86kBWNMpMjfnDt1eGFsimFxO7l
 RPEsrHgFNh/k32c4Ma6WYB4ioO02yyd5TaWMheCuRtIAiXFGLftKndmTs/cdHuY7dUY4
 J39Prk5GaAFoU5EJv4Hl0IdC0UyCpiTiqgYleD2/9R/Y5KXKRaELJHWN8sSRXxEr4Y0R
 lSp738D1M17zoT0lNOrg98/brtSrNuAatF3HfNjqu7D4Jw/Mfwisiex8ZnRROunAAXnR
 2Y/uqFaqO8IVr9Xpp/yCMQBfmjYXuJpSQgOEbjA52QKrhQalz0OsoDzWwZG1RsuoYXEW
 QVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220948; x=1688812948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8suom5c4Zq4IF9eAO/a9IEhcFRdmjk/0kY8XvnG0/LY=;
 b=B9TXD/MPNyrSW+qTXE3qWvkeEUw6aGLDHna1dqrrmdjWVz4YGBwtivJJMo0SmXYLmV
 +Jv1BWpUEpLBWohWJrZagBPtyXzo28GFdpaAO713KqFIarrXSCOXK2wglJORIJLHSKvk
 JQfY70UgA6gEc7VUnuNiThk+Nb3njteHJ3UwgKVvtbBg6GdEy8NEx7RJmeEaBF8GrwJf
 e8Enb8+clMcLvfSf8V6X5/zKLW4fbexd1YpIdm8gMmUrROhOH1ZWA0cSVLZeLSsKisGT
 hZxgUEETXz+EePwsI/6PtrbExCAgazEl52VXxcfB2LZoZiDan2YFv3FKht17/gWKZD+X
 h/PA==
X-Gm-Message-State: AC+VfDz9vdmBm4gPCtYmNGAT+txai2FeMR/bt9hX2pZO0i+L/Z49z8wB
 ZeRhzrdReDN3p/b3VZT2tHSk1/HDV6U=
X-Google-Smtp-Source: ACHHUZ54fejStoKInzLzngAFgxURq5CrhB/tASbsUznujnd1DjicJpEJfy4Aho2HfzvF1g0OF/6+uw==
X-Received: by 2002:ac2:5581:0:b0:4f6:2a63:d3fc with SMTP id
 v1-20020ac25581000000b004f62a63d3fcmr3036342lfg.32.1686220947811; 
 Thu, 08 Jun 2023 03:42:27 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:27 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 03/33] target/mips: Add emulation of LXW LXB LXH LXBU LXHU
 instructions
Date: Thu,  8 Jun 2023 13:41:52 +0300
Message-Id: <20230608104222.1520143-4-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x12e.google.com
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

These instructions used to load from memory to GPR via indexed address
divided by base and index parts in GPR registers.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 83 ++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index f7485a10cc..423c248d5a 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -306,7 +306,7 @@
  *          │                            ├─ 110 ─ OPC_MXU_S32OR
  *          │                            └─ 111 ─ OPC_MXU_S32XOR
  *          │
- *          │                               7..5
+ *          │                               8..6
  *          ├─ 101000 ─ OPC_MXU__POOL17 ─┬─ 000 ─ OPC_MXU_LXB
  *          │                            ├─ 001 ─ OPC_MXU_LXH
  *          ├─ 101001 ─ <not assigned>   ├─ 011 ─ OPC_MXU_LXW
@@ -368,6 +368,7 @@ enum {
     OPC_MXU__POOL11  = 0x17,
     OPC_MXU_S8LDD    = 0x22,
     OPC_MXU__POOL16  = 0x27,
+    OPC_MXU__POOL17  = 0x28,
     OPC_MXU_S32M2I   = 0x2E,
     OPC_MXU_S32I2M   = 0x2F,
     OPC_MXU__POOL19  = 0x38,
@@ -405,6 +406,17 @@ enum {
     OPC_MXU_S32XOR   = 0x07,
 };
 
+/*
+ * MXU pool 17
+ */
+enum {
+    OPC_MXU_LXB      = 0x00,
+    OPC_MXU_LXH      = 0x01,
+    OPC_MXU_LXW      = 0x03,
+    OPC_MXU_LXBU     = 0x04,
+    OPC_MXU_LXHU     = 0x05,
+};
+
 /*
  * MXU pool 19
  */
@@ -920,6 +932,38 @@ static void gen_mxu_s32ldxvx(DisasContext *ctx, bool reversed,
     }
 }
 
+/*
+ * LXW  Ra, Rb, Rc, STRD2 - Load a word from memory to GPR
+ * LXB  Ra, Rb, Rc, STRD2 - Load a byte from memory to GPR,
+ *   sign extending to GPR size.
+ * LXH  Ra, Rb, Rc, STRD2 - Load a byte from memory to GPR,
+ *   sign extending to GPR size.
+ * LXBU Ra, Rb, Rc, STRD2 - Load a halfword from memory to GPR,
+ *   zero extending to GPR size.
+ * LXHU Ra, Rb, Rc, STRD2 - Load a halfword from memory to GPR,
+ *   zero extending to GPR size.
+ */
+static void gen_mxu_lxx(DisasContext *ctx, uint32_t strd2, MemOp mop)
+{
+    TCGv t0, t1;
+    uint32_t Ra, Rb, Rc;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+
+    Ra = extract32(ctx->opcode, 11, 5);
+    Rc = extract32(ctx->opcode, 16, 5);
+    Rb = extract32(ctx->opcode, 21, 5);
+
+    gen_load_gpr(t0, Rb);
+    gen_load_gpr(t1, Rc);
+    tcg_gen_shli_tl(t1, t1, strd2);
+    tcg_gen_add_tl(t0, t0, t1);
+
+    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mop | ctx->default_tcg_memop_mask);
+    gen_store_gpr(t1, Ra);
+}
+
 /*
  * S32STDV  XRa, Rb, Rc, STRD2 - Load a word from memory to XRF
  * S32STDVR XRa, Rb, Rc, STRD2 - Load a word from memory to XRF
@@ -1718,6 +1762,40 @@ static void decode_opc_mxu__pool16(DisasContext *ctx)
     }
 }
 
+static void decode_opc_mxu__pool17(DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 6, 3);
+    uint32_t strd2  = extract32(ctx->opcode, 9, 2);
+
+    if (strd2 > 2) {
+        MIPS_INVAL("decode_opc_mxu");
+        gen_reserved_instruction(ctx);
+        return;
+    }
+
+    switch (opcode) {
+    case OPC_MXU_LXW:
+          gen_mxu_lxx(ctx, strd2, MO_TE | MO_UL);
+          break;
+    case OPC_MXU_LXB:
+          gen_mxu_lxx(ctx, strd2, MO_TE | MO_SB);
+          break;
+    case OPC_MXU_LXH:
+          gen_mxu_lxx(ctx, strd2, MO_TE | MO_SW);
+          break;
+    case OPC_MXU_LXBU:
+          gen_mxu_lxx(ctx, strd2, MO_TE | MO_UB);
+          break;
+    case OPC_MXU_LXHU:
+          gen_mxu_lxx(ctx, strd2, MO_TE | MO_UW);
+          break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        gen_reserved_instruction(ctx);
+        break;
+    }
+}
+
 static void decode_opc_mxu__pool19(DisasContext *ctx)
 {
     uint32_t opcode = extract32(ctx->opcode, 22, 2);
@@ -1796,6 +1874,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU__POOL16:
             decode_opc_mxu__pool16(ctx);
             break;
+        case OPC_MXU__POOL17:
+            decode_opc_mxu__pool17(ctx);
+            break;
         case OPC_MXU__POOL19:
             decode_opc_mxu__pool19(ctx);
             break;
-- 
2.40.0


