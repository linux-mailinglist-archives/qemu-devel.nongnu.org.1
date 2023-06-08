Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 739D0728128
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:21:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWi-0003R9-Kd; Thu, 08 Jun 2023 09:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D69-0002HP-Kz
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:33 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D65-0006Sw-E3
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:33 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4f63006b4e3so590279e87.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220946; x=1688812946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MrxcB4KoNu+w11NX5AcvNib0cKW/SO6hoef67m3ZfsQ=;
 b=RJWlECkv5b2l5cbRXbHxvu7sRuyo9iCik/0+7Ds+VnuzFT4a7DSHW7mwIZkdbgTNMC
 YC4omyLCOqeLkgjOcU9nklSnBgRgfvXkka1MxIntPHX0xbPjpKJgXfmzqSQBSdIx+Vsp
 Bxse/2ZVDDVH/yehR2RWS34kMgVFmYl6JPEtVBdFmFj5CWp8LyxWxUP5RzGskbofyFbd
 F7uaqqvxQQRxcra8b/q+VLXPc1vkqAOifMkeDtLUTtkW2JIY9jnxykRZQSfK9Dl+ZVzJ
 NnYMBK/9zxdYe4/XPK8LSwWvhO0iWEgf8qyizzLRZ7PuMR/ClHfWug4DDLW7LZXOJiho
 OGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220946; x=1688812946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MrxcB4KoNu+w11NX5AcvNib0cKW/SO6hoef67m3ZfsQ=;
 b=EkAj/b0ZLCsGmLSHGWeBbjlMZnJNsRjsClvRf55XIqsynuf2uhKevUW+lYfV6gR8Dp
 2ADL/G6cwXh/CZTCYdO+RsCA+nFN2hhLcw9yufu8LPhAtnX6A6d19UhbOSSmlmBS0A+6
 0eE4rY5Ur54CwkEy2p8D/siFLGW7Gs1f1fHa1kqxz4YytgcDmmeVp1H8wOji8cKYvcrD
 7xNb1K5MfezjfCVpbpzxx3q7D1MK/F7kNInXkkmH6at5oCQuzwqN/sCznPmsIJoivYdl
 u2lLj4hEbH16u9r6isUqHpKx3zSyurDrlyVKDEt6W9G75PPLcWOlacDu1jpweAK5j7XN
 ODcA==
X-Gm-Message-State: AC+VfDx8nrWUY+hYdGjDWu3kaOT4oj6WltSlX2IOqAECj2N1aME3o/Xv
 pbtl6swCuPemAkD8UVbTNndCrYFFGe0=
X-Google-Smtp-Source: ACHHUZ6NV4gGk7H2o6gSnpJew0eIInybJ0aFQNiBaiJ/SNGuG4QgZKXpM9cw9TIPmoA4lXat4oDwmQ==
X-Received: by 2002:a19:ee13:0:b0:4f4:cae3:8a2f with SMTP id
 g19-20020a19ee13000000b004f4cae38a2fmr3400749lfb.16.1686220945714; 
 Thu, 08 Jun 2023 03:42:25 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:25 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 01/33] target/mips: Add emulation of MXU instructions for
 32-bit load/store
Date: Thu,  8 Jun 2023 13:41:50 +0300
Message-Id: <20230608104222.1520143-2-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x12f.google.com
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
---
 target/mips/tcg/mxu_translate.c | 302 +++++++++++++++++++++++++++++---
 1 file changed, 279 insertions(+), 23 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index be038b5f07..f7485a10cc 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -239,11 +239,11 @@
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
@@ -255,11 +255,11 @@
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
@@ -359,6 +359,13 @@ enum {
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
@@ -380,11 +387,11 @@ enum {
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
@@ -808,35 +815,147 @@ static void gen_mxu_q8mul_q8mulsu(DisasContext *ctx)
 
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
     }
-    tcg_gen_add_tl(t1, t0, t1);
-    tcg_gen_qemu_ld_tl(t1, t1, ctx->mem_idx, (MO_TESL ^ (sel * MO_BSWAP)) |
-                       ctx->default_tcg_memop_mask);
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
@@ -1442,13 +1561,129 @@ static void decode_opc_mxu__pool00(DisasContext *ctx)
 
 static void decode_opc_mxu__pool04(DisasContext *ctx)
 {
-    uint32_t opcode = extract32(ctx->opcode, 20, 1);
+    uint32_t reversed = extract32(ctx->opcode, 20, 1);
+    uint32_t opcode = extract32(ctx->opcode, 10, 4);
 
+    /* Don't care about opcode bits as their meaning is unknown yet */
     switch (opcode) {
-    case OPC_MXU_S32LDD:
-    case OPC_MXU_S32LDDR:
-        gen_mxu_s32ldd_s32lddr(ctx);
+    default:
+        gen_mxu_s32ldxx(ctx, reversed, false);
         break;
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
+
+    switch (opcode) {
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
+        break;
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
@@ -1534,6 +1769,27 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
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
2.40.0


