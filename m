Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4C774E121
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:31:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzN0-0000hR-6q; Mon, 10 Jul 2023 18:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzMy-0000aJ-GN
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:36 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzMs-00023B-Qw
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:28:36 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso51951635e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028109; x=1691620109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=itjW2Dx9jMI4ZUdMZbVpdbe/iacDRQ27Ew+SxZAZu2Y=;
 b=vbm/Exlcetj7nBJvcVwxM/X2ThDuMMNfzksLZ0MDwo7Y/4dgeA43ODZ0ql93QRumO4
 ubVcxyBKlaLaaOLsSCIZqhutB70POs4CVen83FwNYpBgs1xIDtBap0p6/TFw4Qps3msR
 lOTtXe5e83jwnYH/2Nehn2aoZe/+2/LcHyycoqBA6auLUlD9df5YoVuH1Q6EgiH5/0JK
 TehhDvFIpBV0tscL6k9LLXCOOMhW/NSUat0pJkC6dX3D9zi/j1nzQzE+PbcVlrWu1w1c
 hXnJ508P71wITW9JJ+JHTnrql4/fzEsRu43wgQ5zbBeFpoELtLewTqXnvGo4D0gHBZw2
 hREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028109; x=1691620109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=itjW2Dx9jMI4ZUdMZbVpdbe/iacDRQ27Ew+SxZAZu2Y=;
 b=kRXr3IjzV21uf6udBrtluTDOSWAJwN0ARXkDi0ltjUtavYiEbutF8GGwRjdg75m5EH
 oZ1lwQyfLvmKVJo3h6nK6anpMTAfLYdP52t7xlx+O8Y019ApIRWIjGKT6sbzJDebLoyI
 Y90pYYNy6/nSk8Bl9rf5t7EFxZUys4SLp35MKKp8SSSxPSvqiwWljZ3vi4w2xgjW9NGT
 efu6J3gMHRcuzWpvqajJOs6IuxUxoOqF4CxRVhzj37F1PtSrgxoVOGzLwJTVfGH00u2P
 Z2xH9O7CLsdlZFcFfPhDDA4nFH4f3ofR569mKKcN40TIGpmORAYG62bXJWpB0sUadEOx
 0LVQ==
X-Gm-Message-State: ABy/qLa4sqkHFlJmmUDP4eghdMMsdmUq1Jpjmn4EoHY5raOyFQq4xH1Z
 79t5cmToK0om5NQuBQN1Flvm02+JOquQ/8eXaAVfGw==
X-Google-Smtp-Source: APBJJlHUu8VP9qn8Xy3zAkc2DueXhoaxMS2bDd6WKec726eICyKKwHO+P/O9wLMyZvz1/FEa+y8lcg==
X-Received: by 2002:a7b:cbd8:0:b0:3f9:9a93:217f with SMTP id
 n24-20020a7bcbd8000000b003f99a93217fmr11194386wmi.3.1689028109302; 
 Mon, 10 Jul 2023 15:28:29 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 s21-20020a7bc395000000b003fbc89af035sm897465wmj.17.2023.07.10.15.28.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:28:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 25/44] target/mips/mxu: Add S32MUL S32MULU S32EXTR S32EXTRV
 insns
Date: Tue, 11 Jul 2023 00:25:52 +0200
Message-Id: <20230710222611.50978-26-philmd@linaro.org>
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

These instructions are part of pool15, see the grand opcode organization
tree on top of the file.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-23-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 200 +++++++++++++++++++++++++++++++-
 1 file changed, 196 insertions(+), 4 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index caf5257952..0704a8c7ff 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -290,9 +290,9 @@
  *          ├─ 100010 ─ OPC_MXU_S8LDD
  *          ├─ 100011 ─ OPC_MXU_S8STD       15..14
  *          ├─ 100100 ─ OPC_MXU_S8LDI    ┌─ 00 ─ OPC_MXU_S32MUL
- *          ├─ 100101 ─ OPC_MXU_S8SDI    ├─ 00 ─ OPC_MXU_S32MULU
- *          │                            ├─ 00 ─ OPC_MXU_S32EXTR
- *          ├─ 100110 ─ OPC_MXU__POOL15 ─┴─ 00 ─ OPC_MXU_S32EXTRV
+ *          ├─ 100101 ─ OPC_MXU_S8SDI    ├─ 01 ─ OPC_MXU_S32MULU
+ *          │                            ├─ 10 ─ OPC_MXU_S32EXTR
+ *          ├─ 100110 ─ OPC_MXU__POOL15 ─┴─ 11 ─ OPC_MXU_S32EXTRV
  *          │
  *          │                               20..18
  *          ├─ 100111 ─ OPC_MXU__POOL16 ─┬─ 000 ─ OPC_MXU_D32SARW
@@ -385,6 +385,7 @@ enum {
     OPC_MXU_S8STD    = 0x23,
     OPC_MXU_S8LDI    = 0x24,
     OPC_MXU_S8SDI    = 0x25,
+    OPC_MXU__POOL15  = 0x26,
     OPC_MXU__POOL16  = 0x27,
     OPC_MXU__POOL17  = 0x28,
     OPC_MXU_S16LDD   = 0x2A,
@@ -477,6 +478,16 @@ enum {
     OPC_MXU_D8SUMC    = 0x02,
 };
 
+/*
+ * MXU pool 15
+ */
+enum {
+    OPC_MXU_S32MUL    = 0x00,
+    OPC_MXU_S32MULU   = 0x01,
+    OPC_MXU_S32EXTR   = 0x02,
+    OPC_MXU_S32EXTRV  = 0x03,
+};
+
 /*
  * MXU pool 16
  */
@@ -871,6 +882,47 @@ static void gen_mxu_s16std(DisasContext *ctx, bool postmodify)
     tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_UW);
 }
 
+/*
+ * S32MUL  XRa, XRd, rs, rt - Signed 32x32=>64 bit multiplication
+ * of GPR's and stores result into pair of MXU registers.
+ * It strains HI and LO registers.
+ *
+ * S32MULU XRa, XRd, rs, rt - Unsigned 32x32=>64 bit multiplication
+ * of GPR's and stores result into pair of MXU registers.
+ * It strains HI and LO registers.
+ */
+static void gen_mxu_s32mul(DisasContext *ctx, bool mulu)
+{
+    TCGv t0, t1;
+    uint32_t XRa, XRd, rs, rt;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+
+    XRa = extract32(ctx->opcode,  6, 4);
+    XRd = extract32(ctx->opcode, 10, 4);
+    rs  = extract32(ctx->opcode, 16, 5);
+    rt  = extract32(ctx->opcode, 21, 5);
+
+    if (unlikely(rs == 0 || rt == 0)) {
+        tcg_gen_movi_tl(t0, 0);
+        tcg_gen_movi_tl(t1, 0);
+    } else {
+        gen_load_gpr(t0, rs);
+        gen_load_gpr(t1, rt);
+
+        if (mulu) {
+            tcg_gen_mulu2_tl(t0, t1, t0, t1);
+        } else {
+            tcg_gen_muls2_tl(t0, t1, t0, t1);
+        }
+    }
+    tcg_gen_mov_tl(cpu_HI[0], t1);
+    tcg_gen_mov_tl(cpu_LO[0], t0);
+    gen_store_mxu_gpr(t1, XRa);
+    gen_store_mxu_gpr(t0, XRd);
+}
+
 /*
  * D16MUL  XRa, XRb, XRc, XRd, optn2 - Signed 16 bit pattern multiplication
  * D16MULF XRa, XRb, XRc, optn2 - Signed Q15 fraction pattern multiplication
@@ -3014,9 +3066,122 @@ static void gen_mxu_d32asum(DisasContext *ctx)
  *                 MXU instruction category: Miscellaneous
  *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
- *                       Q16SAT
+ *               S32EXTR
+ *               S32EXTRV
+ *                            Q16SAT
  */
 
+/*
+ *  S32EXTR XRa, XRd, rs, bits5
+ *    Extract bits5 bits from 64-bit pair {XRa:XRd}
+ *    starting from rs[4:0] offset and put to the XRa.
+ */
+static void gen_mxu_s32extr(DisasContext *ctx)
+{
+    TCGv t0, t1, t2, t3;
+    uint32_t XRa, XRd, rs, bits5;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+    t2 = tcg_temp_new();
+    t3 = tcg_temp_new();
+
+    XRa   = extract32(ctx->opcode,  6, 4);
+    XRd   = extract32(ctx->opcode, 10, 4);
+    bits5 = extract32(ctx->opcode, 16, 5);
+    rs    = extract32(ctx->opcode, 21, 5);
+
+    /* {tmp} = {XRa:XRd} >> (64 - rt - bits5); */
+    /* {XRa} = extract({tmp}, 0, bits5); */
+    if (bits5 > 0) {
+        TCGLabel *l_xra_only = gen_new_label();
+        TCGLabel *l_done = gen_new_label();
+
+        gen_load_mxu_gpr(t0, XRd);
+        gen_load_mxu_gpr(t1, XRa);
+        gen_load_gpr(t2, rs);
+        tcg_gen_andi_tl(t2, t2, 0x1f);
+        tcg_gen_subfi_tl(t2, 32, t2);
+        tcg_gen_brcondi_tl(TCG_COND_GE, t2, bits5, l_xra_only);
+        tcg_gen_subfi_tl(t2, bits5, t2);
+        tcg_gen_subfi_tl(t3, 32, t2);
+        tcg_gen_shr_tl(t0, t0, t3);
+        tcg_gen_shl_tl(t1, t1, t2);
+        tcg_gen_or_tl(t0, t0, t1);
+        tcg_gen_br(l_done);
+        gen_set_label(l_xra_only);
+        tcg_gen_subi_tl(t2, t2, bits5);
+        tcg_gen_shr_tl(t0, t1, t2);
+        gen_set_label(l_done);
+        tcg_gen_extract_tl(t0, t0, 0, bits5);
+    } else {
+        /* unspecified behavior but matches tests on real hardware*/
+        tcg_gen_movi_tl(t0, 0);
+    }
+    gen_store_mxu_gpr(t0, XRa);
+}
+
+/*
+ *  S32EXTRV XRa, XRd, rs, rt
+ *    Extract rt[4:0] bits from 64-bit pair {XRa:XRd}
+ *    starting from rs[4:0] offset and put to the XRa.
+ */
+static void gen_mxu_s32extrv(DisasContext *ctx)
+{
+    TCGv t0, t1, t2, t3, t4;
+    uint32_t XRa, XRd, rs, rt;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+    t2 = tcg_temp_new();
+    t3 = tcg_temp_new();
+    t4 = tcg_temp_new();
+    TCGLabel *l_xra_only = gen_new_label();
+    TCGLabel *l_done = gen_new_label();
+    TCGLabel *l_zero = gen_new_label();
+    TCGLabel *l_extract = gen_new_label();
+
+    XRa = extract32(ctx->opcode,  6, 4);
+    XRd = extract32(ctx->opcode, 10, 4);
+    rt  = extract32(ctx->opcode, 16, 5);
+    rs  = extract32(ctx->opcode, 21, 5);
+
+    /* {tmp} = {XRa:XRd} >> (64 - rs - rt) */
+    gen_load_mxu_gpr(t0, XRd);
+    gen_load_mxu_gpr(t1, XRa);
+    gen_load_gpr(t2, rs);
+    gen_load_gpr(t4, rt);
+    tcg_gen_brcondi_tl(TCG_COND_EQ, t4, 0, l_zero);
+    tcg_gen_andi_tl(t2, t2, 0x1f);
+    tcg_gen_subfi_tl(t2, 32, t2);
+    tcg_gen_brcond_tl(TCG_COND_GE, t2, t4, l_xra_only);
+    tcg_gen_sub_tl(t2, t4, t2);
+    tcg_gen_subfi_tl(t3, 32, t2);
+    tcg_gen_shr_tl(t0, t0, t3);
+    tcg_gen_shl_tl(t1, t1, t2);
+    tcg_gen_or_tl(t0, t0, t1);
+    tcg_gen_br(l_extract);
+
+    gen_set_label(l_xra_only);
+    tcg_gen_sub_tl(t2, t2, t4);
+    tcg_gen_shr_tl(t0, t1, t2);
+    tcg_gen_br(l_extract);
+
+    /* unspecified behavior but matches tests on real hardware*/
+    gen_set_label(l_zero);
+    tcg_gen_movi_tl(t0, 0);
+    tcg_gen_br(l_done);
+
+    /* {XRa} = extract({tmp}, 0, rt) */
+    gen_set_label(l_extract);
+    tcg_gen_subfi_tl(t4, 32, t4);
+    tcg_gen_shl_tl(t0, t0, t4);
+    tcg_gen_shr_tl(t0, t0, t4);
+
+    gen_set_label(l_done);
+    gen_store_mxu_gpr(t0, XRa);
+}
+
 /*
  *  Q16SAT XRa, XRb, XRc
  *  Packs four 16-bit signed integers in XRb and XRc to
@@ -3695,6 +3860,30 @@ static void decode_opc_mxu__pool14(DisasContext *ctx)
     }
 }
 
+static void decode_opc_mxu__pool15(DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 14, 2);
+
+    switch (opcode) {
+    case OPC_MXU_S32MUL:
+        gen_mxu_s32mul(ctx, false);
+        break;
+    case OPC_MXU_S32MULU:
+        gen_mxu_s32mul(ctx, true);
+        break;
+    case OPC_MXU_S32EXTR:
+        gen_mxu_s32extr(ctx);
+        break;
+    case OPC_MXU_S32EXTRV:
+        gen_mxu_s32extrv(ctx);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        gen_reserved_instruction(ctx);
+        break;
+    }
+}
+
 static void decode_opc_mxu__pool16(DisasContext *ctx)
 {
     uint32_t opcode = extract32(ctx->opcode, 18, 3);
@@ -3884,6 +4073,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU_S8SDI:
             gen_mxu_s8std(ctx, true);
             break;
+        case OPC_MXU__POOL15:
+            decode_opc_mxu__pool15(ctx);
+            break;
         case OPC_MXU__POOL16:
             decode_opc_mxu__pool16(ctx);
             break;
-- 
2.38.1


