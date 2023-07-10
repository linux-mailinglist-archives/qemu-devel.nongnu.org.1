Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E90074E102
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:27:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzLC-0003Tr-5p; Mon, 10 Jul 2023 18:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLA-0003Th-BP
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:26:44 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzL4-0001jB-Sm
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:26:44 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbc656873eso63863685e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689027997; x=1691619997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1Cdm2xOyXJHfXBEnkIgza905DyMgXBlOTeRkhn8G/g=;
 b=jhobM+aZOV9b5m6eBdJyouvAtUQbqt4IjIGDiydxb7x3JWiC8y5/4J5JZlV4ftgxJi
 dlfTfhAhyaKWjg8ae5lux7ERGCgiOWmeKhJ2Oxv2kSn9hFyZYeQihGafgRNYEEGEKD4F
 me4k+axfo3q0FgQrf2ZkxJWtyFrrUfGDgbKwsqq5tyiRyZkFVwfyxJyHYSl7RKLf1f7b
 nhGO8cWfza5lU+cY1OTx7RnT2u2avIeMB3TMLod19z1s7S1y0UPzK1jeGtEtKhfa2Wwt
 41C7YRLeBa7pBJ9XDkoaFuQLSlSE6CKNGJmWx5WrDKg5SDol5LODwhU0GTqALHVBH2xw
 CxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689027997; x=1691619997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q1Cdm2xOyXJHfXBEnkIgza905DyMgXBlOTeRkhn8G/g=;
 b=ChKBvEd29lG5ef2SEES6hbEqhwKPARtX9Hr51wOy8eMLHoFk7/fPZUAHt16d7S5D7o
 Ie5AEH+ZtJQpOr36RpAys8Y4E+iIaZKtCCh8ahlHwDYf5z61JRYyBw6xTXEdFNpIgthj
 sBLpC+IbXkQsFSWVUAW/26r5fWrQLV+wyLxncpR6cRSrCZ0OYGSi6yAbL+7CVPZeMbOF
 rValNVKIDcP/wJ5T1frHRyb2wZsrJYjFPB7Bz7seii11uGPCJ9W/Z37Li66wK5NxAxjH
 J5hUgj5pxOIv9hRD5RQbN52JLRuWtqdY+0Sl4KJ/u8KivQQb0aAV5vO/nKNTipyW0HuP
 /dqg==
X-Gm-Message-State: ABy/qLZQrLC6xwE363OSJFIEulVe1b7rEBR663jlyyVPILVgwfsUnbMG
 xuKOChxDUAR3040G1apbv8sYrhTH48Vq9QsgDRSrDw==
X-Google-Smtp-Source: APBJJlE+GRi3AaWvw4av3X7xIQFjKIVgEXhL0oZxd7sJrAK7enj5oNNewwriphL5CT3hNg6zjgHJjQ==
X-Received: by 2002:a7b:c455:0:b0:3fa:85ad:6672 with SMTP id
 l21-20020a7bc455000000b003fa85ad6672mr16870801wmi.41.1689027997024; 
 Mon, 10 Jul 2023 15:26:37 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 l22-20020a7bc456000000b003fbb5142c4bsm11321350wmi.18.2023.07.10.15.26.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:26:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 04/44] target/mips: Add emulation of MXU instructions for
 32-bit load/store
Date: Tue, 11 Jul 2023 00:25:31 +0200
Message-Id: <20230710222611.50978-5-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add support for emulating:
- S32LDDV and S32LDDVR
- S32STD and S32STDR
- S32STDV and S32STDVR
MXU instructions.

Add support for emulating MXU instructions with address register
post-modify counterparts:
- S32LDI and S32LDIR
- S32LDIV and S32LDIVR
- S32SDI and S32SDIR
- S32SDIV and S32SDIVR

Refactor support for emulating the S32LDD and S32LDDR instructions.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-2-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 306 +++++++++++++++++++++++++++++---
 1 file changed, 281 insertions(+), 25 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 39348b3a91..c69c5795c9 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -237,11 +237,11 @@
  *          ├─ 001100 ─ OPC_MXU_D16MADL
  *          ├─ 001101 ─ OPC_MXU_S16MAD
  *          ├─ 001110 ─ OPC_MXU_Q16ADD
- *          ├─ 001111 ─ OPC_MXU_D16MACE     23
+ *          ├─ 001111 ─ OPC_MXU_D16MACE     20 (13..10 don't care)
  *          │                            ┌─ 0 ─ OPC_MXU_S32LDD
  *          ├─ 010000 ─ OPC_MXU__POOL04 ─┴─ 1 ─ OPC_MXU_S32LDDR
  *          │
- *          │                               23
+ *          │                               20 (13..10 don't care)
  *          ├─ 010001 ─ OPC_MXU__POOL05 ─┬─ 0 ─ OPC_MXU_S32STD
  *          │                            └─ 1 ─ OPC_MXU_S32STDR
  *          │
@@ -253,11 +253,11 @@
  *          ├─ 010011 ─ OPC_MXU__POOL07 ─┬─ 0000 ─ OPC_MXU_S32STDV
  *          │                            └─ 0001 ─ OPC_MXU_S32STDVR
  *          │
- *          │                               23
+ *          │                               20 (13..10 don't care)
  *          ├─ 010100 ─ OPC_MXU__POOL08 ─┬─ 0 ─ OPC_MXU_S32LDI
  *          │                            └─ 1 ─ OPC_MXU_S32LDIR
  *          │
- *          │                               23
+ *          │                               20 (13..10 don't care)
  *          ├─ 010101 ─ OPC_MXU__POOL09 ─┬─ 0 ─ OPC_MXU_S32SDI
  *          │                            └─ 1 ─ OPC_MXU_S32SDIR
  *          │
@@ -357,6 +357,13 @@ enum {
     OPC_MXU_D16MUL   = 0x08,
     OPC_MXU_D16MAC   = 0x0A,
     OPC_MXU__POOL04  = 0x10,
+    OPC_MXU__POOL05  = 0x11,
+    OPC_MXU__POOL06  = 0x12,
+    OPC_MXU__POOL07  = 0x13,
+    OPC_MXU__POOL08  = 0x14,
+    OPC_MXU__POOL09  = 0x15,
+    OPC_MXU__POOL10  = 0x16,
+    OPC_MXU__POOL11  = 0x17,
     OPC_MXU_S8LDD    = 0x22,
     OPC_MXU__POOL16  = 0x27,
     OPC_MXU_S32M2I   = 0x2E,
@@ -378,11 +385,11 @@ enum {
 };
 
 /*
- * MXU pool 04
+ * MXU pool 04 05 06 07 08 09 10 11
  */
 enum {
-    OPC_MXU_S32LDD   = 0x00,
-    OPC_MXU_S32LDDR  = 0x01,
+    OPC_MXU_S32LDST  = 0x00,
+    OPC_MXU_S32LDSTR = 0x01,
 };
 
 /*
@@ -806,35 +813,147 @@ static void gen_mxu_q8mul_q8mulsu(DisasContext *ctx)
 
 /*
  * S32LDD  XRa, Rb, S12 - Load a word from memory to XRF
- * S32LDDR XRa, Rb, S12 - Load a word from memory to XRF, reversed byte seq.
+ * S32LDDR XRa, Rb, S12 - Load a word from memory to XRF
+ *   in reversed byte seq.
+ * S32LDI  XRa, Rb, S12 - Load a word from memory to XRF,
+ *   post modify base address GPR.
+ * S32LDIR XRa, Rb, S12 - Load a word from memory to XRF,
+ *   post modify base address GPR and load in reversed byte seq.
  */
-static void gen_mxu_s32ldd_s32lddr(DisasContext *ctx)
+static void gen_mxu_s32ldxx(DisasContext *ctx, bool reversed, bool postinc)
 {
     TCGv t0, t1;
-    uint32_t XRa, Rb, s12, sel;
+    uint32_t XRa, Rb, s12;
 
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
 
     XRa = extract32(ctx->opcode, 6, 4);
-    s12 = extract32(ctx->opcode, 10, 10);
-    sel = extract32(ctx->opcode, 20, 1);
+    s12 = sextract32(ctx->opcode, 10, 10);
     Rb = extract32(ctx->opcode, 21, 5);
 
     gen_load_gpr(t0, Rb);
+    tcg_gen_movi_tl(t1, s12 * 4);
+    tcg_gen_add_tl(t0, t0, t1);
 
-    tcg_gen_movi_tl(t1, s12);
-    tcg_gen_shli_tl(t1, t1, 2);
-    if (s12 & 0x200) {
-        tcg_gen_ori_tl(t1, t1, 0xFFFFF000);
-    }
-    tcg_gen_add_tl(t1, t0, t1);
-    tcg_gen_qemu_ld_tl(t1, t1, ctx->mem_idx, (MO_TESL ^ (sel * MO_BSWAP)) |
-                       ctx->default_tcg_memop_mask);
-
+    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx,
+                       (MO_TESL ^ (reversed ? MO_BSWAP : 0)) |
+                        ctx->default_tcg_memop_mask);
     gen_store_mxu_gpr(t1, XRa);
+
+    if (postinc) {
+        gen_store_gpr(t0, Rb);
+    }
 }
 
+/*
+ * S32STD  XRa, Rb, S12 - Store a word from XRF to memory
+ * S32STDR XRa, Rb, S12 - Store a word from XRF to memory
+ *   in reversed byte seq.
+ * S32SDI  XRa, Rb, S12 - Store a word from XRF to memory,
+ *   post modify base address GPR.
+ * S32SDIR XRa, Rb, S12 - Store a word from XRF to memory,
+ *   post modify base address GPR and store in reversed byte seq.
+ */
+static void gen_mxu_s32stxx(DisasContext *ctx, bool reversed, bool postinc)
+{
+    TCGv t0, t1;
+    uint32_t XRa, Rb, s12;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+
+    XRa = extract32(ctx->opcode, 6, 4);
+    s12 = sextract32(ctx->opcode, 10, 10);
+    Rb = extract32(ctx->opcode, 21, 5);
+
+    gen_load_gpr(t0, Rb);
+    tcg_gen_movi_tl(t1, s12 * 4);
+    tcg_gen_add_tl(t0, t0, t1);
+
+    gen_load_mxu_gpr(t1, XRa);
+    tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
+                       (MO_TESL ^ (reversed ? MO_BSWAP : 0)) |
+                        ctx->default_tcg_memop_mask);
+
+    if (postinc) {
+        gen_store_gpr(t0, Rb);
+    }
+}
+
+/*
+ * S32LDDV  XRa, Rb, Rc, STRD2 - Load a word from memory to XRF
+ * S32LDDVR XRa, Rb, Rc, STRD2 - Load a word from memory to XRF
+ *   in reversed byte seq.
+ * S32LDIV  XRa, Rb, Rc, STRD2 - Load a word from memory to XRF,
+ *   post modify base address GPR.
+ * S32LDIVR XRa, Rb, Rc, STRD2 - Load a word from memory to XRF,
+ *   post modify base address GPR and load in reversed byte seq.
+ */
+static void gen_mxu_s32ldxvx(DisasContext *ctx, bool reversed,
+                             bool postinc, uint32_t strd2)
+{
+    TCGv t0, t1;
+    uint32_t XRa, Rb, Rc;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+
+    XRa = extract32(ctx->opcode, 6, 4);
+    Rc = extract32(ctx->opcode, 16, 5);
+    Rb = extract32(ctx->opcode, 21, 5);
+
+    gen_load_gpr(t0, Rb);
+    gen_load_gpr(t1, Rc);
+    tcg_gen_shli_tl(t1, t1, strd2);
+    tcg_gen_add_tl(t0, t0, t1);
+
+    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx,
+                       (MO_TESL ^ (reversed ? MO_BSWAP : 0)) |
+                        ctx->default_tcg_memop_mask);
+    gen_store_mxu_gpr(t1, XRa);
+
+    if (postinc) {
+        gen_store_gpr(t0, Rb);
+    }
+}
+
+/*
+ * S32STDV  XRa, Rb, Rc, STRD2 - Load a word from memory to XRF
+ * S32STDVR XRa, Rb, Rc, STRD2 - Load a word from memory to XRF
+ *   in reversed byte seq.
+ * S32SDIV  XRa, Rb, Rc, STRD2 - Load a word from memory to XRF,
+ *   post modify base address GPR.
+ * S32SDIVR XRa, Rb, Rc, STRD2 - Load a word from memory to XRF,
+ *   post modify base address GPR and store in reversed byte seq.
+ */
+static void gen_mxu_s32stxvx(DisasContext *ctx, bool reversed,
+                             bool postinc, uint32_t strd2)
+{
+    TCGv t0, t1;
+    uint32_t XRa, Rb, Rc;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+
+    XRa = extract32(ctx->opcode, 6, 4);
+    Rc = extract32(ctx->opcode, 16, 5);
+    Rb = extract32(ctx->opcode, 21, 5);
+
+    gen_load_gpr(t0, Rb);
+    gen_load_gpr(t1, Rc);
+    tcg_gen_shli_tl(t1, t1, strd2);
+    tcg_gen_add_tl(t0, t0, t1);
+
+    gen_load_mxu_gpr(t1, XRa);
+    tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
+                       (MO_TESL ^ (reversed ? MO_BSWAP : 0)) |
+                        ctx->default_tcg_memop_mask);
+
+    if (postinc) {
+        gen_store_gpr(t0, Rb);
+    }
+}
 
 /*
  *                 MXU instruction category: logic
@@ -1440,13 +1559,129 @@ static void decode_opc_mxu__pool00(DisasContext *ctx)
 
 static void decode_opc_mxu__pool04(DisasContext *ctx)
 {
-    uint32_t opcode = extract32(ctx->opcode, 20, 1);
+    uint32_t reversed = extract32(ctx->opcode, 20, 1);
+    uint32_t opcode = extract32(ctx->opcode, 10, 4);
+
+    /* Don't care about opcode bits as their meaning is unknown yet */
+    switch (opcode) {
+    default:
+        gen_mxu_s32ldxx(ctx, reversed, false);
+        break;
+    }
+}
+
+static void decode_opc_mxu__pool05(DisasContext *ctx)
+{
+    uint32_t reversed = extract32(ctx->opcode, 20, 1);
+    uint32_t opcode = extract32(ctx->opcode, 10, 4);
+
+    /* Don't care about opcode bits as their meaning is unknown yet */
+    switch (opcode) {
+    default:
+        gen_mxu_s32stxx(ctx, reversed, false);
+        break;
+    }
+}
+
+static void decode_opc_mxu__pool06(DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 10, 4);
+    uint32_t strd2  = extract32(ctx->opcode, 14, 2);
 
     switch (opcode) {
-    case OPC_MXU_S32LDD:
-    case OPC_MXU_S32LDDR:
-        gen_mxu_s32ldd_s32lddr(ctx);
+    case OPC_MXU_S32LDST:
+    case OPC_MXU_S32LDSTR:
+        if (strd2 <= 2) {
+            gen_mxu_s32ldxvx(ctx, opcode, false, strd2);
+            break;
+        }
+        /* fallthrough */
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        gen_reserved_instruction(ctx);
         break;
+    }
+}
+
+static void decode_opc_mxu__pool07(DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 10, 4);
+    uint32_t strd2  = extract32(ctx->opcode, 14, 2);
+
+    switch (opcode) {
+    case OPC_MXU_S32LDST:
+    case OPC_MXU_S32LDSTR:
+        if (strd2 <= 2) {
+            gen_mxu_s32stxvx(ctx, opcode, false, strd2);
+            break;
+        }
+        /* fallthrough */
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        gen_reserved_instruction(ctx);
+        break;
+    }
+}
+
+static void decode_opc_mxu__pool08(DisasContext *ctx)
+{
+    uint32_t reversed = extract32(ctx->opcode, 20, 1);
+    uint32_t opcode = extract32(ctx->opcode, 10, 4);
+
+    /* Don't care about opcode bits as their meaning is unknown yet */
+    switch (opcode) {
+    default:
+        gen_mxu_s32ldxx(ctx, reversed, true);
+        break;
+    }
+}
+
+static void decode_opc_mxu__pool09(DisasContext *ctx)
+{
+    uint32_t reversed = extract32(ctx->opcode, 20, 1);
+    uint32_t opcode = extract32(ctx->opcode, 10, 4);
+
+    /* Don't care about opcode bits as their meaning is unknown yet */
+    switch (opcode) {
+    default:
+        gen_mxu_s32stxx(ctx, reversed, true);
+        break;
+    }
+}
+
+static void decode_opc_mxu__pool10(DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 10, 4);
+    uint32_t strd2  = extract32(ctx->opcode, 14, 2);
+
+    switch (opcode) {
+    case OPC_MXU_S32LDST:
+    case OPC_MXU_S32LDSTR:
+        if (strd2 <= 2) {
+            gen_mxu_s32ldxvx(ctx, opcode, true, strd2);
+            break;
+        }
+        /* fallthrough */
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        gen_reserved_instruction(ctx);
+        break;
+    }
+}
+
+static void decode_opc_mxu__pool11(DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 10, 4);
+    uint32_t strd2  = extract32(ctx->opcode, 14, 2);
+
+    switch (opcode) {
+    case OPC_MXU_S32LDST:
+    case OPC_MXU_S32LDSTR:
+        if (strd2 <= 2) {
+            gen_mxu_s32stxvx(ctx, opcode, true, strd2);
+            break;
+        }
+        /* fallthrough */
     default:
         MIPS_INVAL("decode_opc_mxu");
         gen_reserved_instruction(ctx);
@@ -1532,6 +1767,27 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU__POOL04:
             decode_opc_mxu__pool04(ctx);
             break;
+        case OPC_MXU__POOL05:
+            decode_opc_mxu__pool05(ctx);
+            break;
+        case OPC_MXU__POOL06:
+            decode_opc_mxu__pool06(ctx);
+            break;
+        case OPC_MXU__POOL07:
+            decode_opc_mxu__pool07(ctx);
+            break;
+        case OPC_MXU__POOL08:
+            decode_opc_mxu__pool08(ctx);
+            break;
+        case OPC_MXU__POOL09:
+            decode_opc_mxu__pool09(ctx);
+            break;
+        case OPC_MXU__POOL10:
+            decode_opc_mxu__pool10(ctx);
+            break;
+        case OPC_MXU__POOL11:
+            decode_opc_mxu__pool11(ctx);
+            break;
         case OPC_MXU_S8LDD:
             gen_mxu_s8ldd(ctx);
             break;
-- 
2.38.1


