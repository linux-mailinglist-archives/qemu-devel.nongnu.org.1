Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB1674E0FF
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:27:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzLJ-0003VI-G2; Mon, 10 Jul 2023 18:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLH-0003Um-9h
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:26:51 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLF-0001k0-Fb
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:26:51 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8fcso36854505e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028008; x=1691620008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/lyTZUrhNR7uCF/B13kcUkqX1idFJLM+1E5/815pBHo=;
 b=khRRPQ33ejItw3uSB2PfRll6ra5nmHQQaRT1f5IQ5pD6DvVuistWcwzM+aNqA6Ih5b
 UY7xb1yls7qy15/pssCvYnMefV1Klio3/VzZxT1RBKU8sYRJVrwUqTloplbwR22Pc9QZ
 XQqaJ8QXVO4IlgjIP0wrZuxXzRykkxG1bXvsoXiM5KlhGhy4HBkURg/6iHFl12T/lK/L
 EXRDpG5/7u1eh+O/fa/7z3oQApl+vxbN9J82Wh6CfaQxkVb8+rMo8x9so+qo6pPgmzwP
 lQ3UMuPYydjdWrmCwJLALwa5eBhl4KtomUVraHbOUrp9vw7SNH4FmrVn6Xe8tm2W/klP
 /h3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028008; x=1691620008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/lyTZUrhNR7uCF/B13kcUkqX1idFJLM+1E5/815pBHo=;
 b=PaJBWbta1eFSKl+zkTg1X5fmnEPo0YjAwUETzQHr4pv5KwnUmrLaW5fbGtEor2X/fW
 0BILpCZZ+WLlRiEkx8KuvhYuCEC5MlFW9K6mLyUB3W70zqiGZTVXqmtUvKNUVR4850wN
 mGvBXjcRGUZfnpkmgu1SRUEgJ3UoxR9XQ6Kq8GgWUnkyyjb/NPeB4LDtodUH7RFhStTT
 7uIgzFUOQ28aA7SflBmJdd5Rgp6xX3ccB8b+VTGjEeLWQvau/4Kck37F4vQcNUqlh15D
 avIvY74uq9uHsn1w9jmKZVxwexF8cqsbQoLABsPhCf/ybkZqF0WwnpU8vB/fb4KGMsUJ
 pUGQ==
X-Gm-Message-State: ABy/qLZqvV6FVo+ZfMDdxJQfsSrRCpATY0Q9DZDvJzqPDSNyHH/oGJ0u
 nidzirmeHx88yVBzNIGCzuyOBnZF4N9lxR4MNOKcNw==
X-Google-Smtp-Source: APBJJlFpzwrib9BM0wYLbi1zrQ3LeY3Pk8MOertu+MSE49zNtVQexkJu2m+xS1veA+eJDoWlAU4i3w==
X-Received: by 2002:a05:600c:850a:b0:3fa:8c8b:716 with SMTP id
 gw10-20020a05600c850a00b003fa8c8b0716mr15550575wmb.1.1689028008065; 
 Mon, 10 Jul 2023 15:26:48 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 p19-20020a1c7413000000b003fba137857esm898974wmc.14.2023.07.10.15.26.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:26:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 06/44] target/mips/mxu: Add LXW LXB LXH LXBU LXHU instructions
Date: Tue, 11 Jul 2023 00:25:33 +0200
Message-Id: <20230710222611.50978-7-philmd@linaro.org>
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

These instructions used to load from memory to GPR via indexed address
divided by base and index parts in GPR registers.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-4-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 83 ++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index c69c5795c9..6703e8aca4 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -304,7 +304,7 @@
  *          │                            ├─ 110 ─ OPC_MXU_S32OR
  *          │                            └─ 111 ─ OPC_MXU_S32XOR
  *          │
- *          │                               7..5
+ *          │                               8..6
  *          ├─ 101000 ─ OPC_MXU__POOL17 ─┬─ 000 ─ OPC_MXU_LXB
  *          │                            ├─ 001 ─ OPC_MXU_LXH
  *          ├─ 101001 ─ <not assigned>   ├─ 011 ─ OPC_MXU_LXW
@@ -366,6 +366,7 @@ enum {
     OPC_MXU__POOL11  = 0x17,
     OPC_MXU_S8LDD    = 0x22,
     OPC_MXU__POOL16  = 0x27,
+    OPC_MXU__POOL17  = 0x28,
     OPC_MXU_S32M2I   = 0x2E,
     OPC_MXU_S32I2M   = 0x2F,
     OPC_MXU__POOL19  = 0x38,
@@ -403,6 +404,17 @@ enum {
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
@@ -918,6 +930,38 @@ static void gen_mxu_s32ldxvx(DisasContext *ctx, bool reversed,
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
@@ -1716,6 +1760,40 @@ static void decode_opc_mxu__pool16(DisasContext *ctx)
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
@@ -1794,6 +1872,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
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
2.38.1


