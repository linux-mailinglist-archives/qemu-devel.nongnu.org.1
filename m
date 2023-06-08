Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25409728116
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:19:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWg-0003PT-N3; Thu, 08 Jun 2023 09:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6S-0002Nw-6I
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:52 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6Q-0006a2-79
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:51 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b1afe57bdfso4023301fa.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220968; x=1688812968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PmBZ7dDnFyJcc3L/gekp5fuudx9wh9cTvVl0/lG4MwQ=;
 b=Mi0SD0/UgkP2TFf3a3whn7wPcHK28roDD9N8VunnT1O3HA8nyz1tvOVHaTkEsjS56k
 cZ205n2XBGABUi/wUCXpws9Nce6T73SRzk2MlpEa41pGM1qX4J9P9K7eSvtWBEmPybTB
 zqWTYMXY17+hvnfk0jUmLslr5p+mcGMqtp27iVt31mmoYWzkF1UdyAIFjNyKMNPIvm/B
 59blD722hEc6ex2yeGUDQEWejOzJTH9/5lsig4MWpFZIJwyIdh654zdWYMGdHeAil7q3
 G9LK+ebkZpFS1mxOV8S5Dmrsk1uGxPYxIv/pJSJoziF0n1pt/bVxlL0zpi13/frF75Ix
 oLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220968; x=1688812968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PmBZ7dDnFyJcc3L/gekp5fuudx9wh9cTvVl0/lG4MwQ=;
 b=CmjYBy5/i2rasOVuCYiR6UX6fQwKW+EenxHox5/ox6BZxSyKf9z0ZdRRutL3ElCCPY
 xabm/f1QRbo2zGGkFYeJQna+GkgTdhj1jMZj6UGnVQ/UWTqbaEggbltTthOpVQdk0ycX
 0RBZX84nZ01XiIYdz+DTnrhahlTrZhnUjZ12HQHCXw1Jej2RF7fIzpsBC3DBPnRZpuGB
 nRLiBjmsBzJZOIDK0Zotq7aIujTgJDaD7MoYj8eE+R3y1Ndi84AuUY91L9kd/X3RYDEp
 OFEQswkfBfUPb6DZW2ZbYvFDWkxzU4hogSERJUcPOg3VkMGUx1Zxm8XyT2ky5ldGg611
 NTuw==
X-Gm-Message-State: AC+VfDx8WZpK+V9wpbHjIGpPME0x1ntAu+vD/s+n64ZzK8F/luv5dCJs
 4QjGJGET+h9otqpghwOq260OtPElVn8=
X-Google-Smtp-Source: ACHHUZ654kDBjVl8g+4imJpivOG9EPLXxwCN3jLLnmeJv/B3HNFfgl9T03FQJaWMiKkPRZCccPS7eA==
X-Received: by 2002:a2e:9009:0:b0:2a8:dcd4:6161 with SMTP id
 h9-20020a2e9009000000b002a8dcd46161mr3233928ljg.28.1686220968325; 
 Thu, 08 Jun 2023 03:42:48 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:48 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 22/33] target/mips: Add emulation of MXU S32MUL S32MULU
 S32EXTR S32EXTRV insns
Date: Thu,  8 Jun 2023 13:42:11 +0300
Message-Id: <20230608104222.1520143-23-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=lis8215@gmail.com; helo=mail-lj1-x236.google.com
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

These instructions are part of pool15, see the grand opcode organization
tree on top of the file.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 200 +++++++++++++++++++++++++++++++-
 1 file changed, 196 insertions(+), 4 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index f867950f3d..79c36cf54e 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -292,9 +292,9 @@
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
@@ -387,6 +387,7 @@ enum {
     OPC_MXU_S8STD    = 0x23,
     OPC_MXU_S8LDI    = 0x24,
     OPC_MXU_S8SDI    = 0x25,
+    OPC_MXU__POOL15  = 0x26,
     OPC_MXU__POOL16  = 0x27,
     OPC_MXU__POOL17  = 0x28,
     OPC_MXU_S16LDD   = 0x2A,
@@ -479,6 +480,16 @@ enum {
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
@@ -873,6 +884,47 @@ static void gen_mxu_s16std(DisasContext *ctx, bool postmodify)
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
@@ -3016,8 +3068,121 @@ static void gen_mxu_d32asum(DisasContext *ctx)
  *                 MXU instruction category: Miscellaneous
  *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
- *                       Q16SAT
+ *               S32EXTR
+ *               S32EXTRV
+ *                            Q16SAT
+ */
+
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
  */
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
 
 /*
  *  Q16SAT XRa, XRb, XRc
@@ -3697,6 +3862,30 @@ static void decode_opc_mxu__pool14(DisasContext *ctx)
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
@@ -3886,6 +4075,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
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
2.40.0


