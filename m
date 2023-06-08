Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E26C72811B
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:20:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWv-0003h2-GH; Thu, 08 Jun 2023 09:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D69-0002HW-S9
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:33 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D66-0006TK-Uz
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:33 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f642a24568so564597e87.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220949; x=1688812949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NHecAKie8Z+nQqF0HDXGBYLIWhD3Kd9qkCVUXQCCus=;
 b=V+P3EwMbMQLkU+UcnNfCot9Xle1vXF3y1aCO6KZOfBAydl15ZkTt0broxuVnzF0GJp
 OBGs6WTglBtmBieIrPJnFwuatVaCLrmZFk44bzKTh3D0C/my+13Pc7x6Oi751AIey9Co
 CnUIiZ0mkB8IH71P29idMy7HF9X7zaHSaMjJjGyCefQg+2R2a5whtnRHUyBhNAt6WPr8
 9XW1SyUSdinNQ0GConlMpetajLDQ5lgWTL5RBtZRhdnImDwHMjcqHxV/REfnVJedGl5T
 VhanVAzjAhUd0Ypt6txdPrifjBMcgiLfBF2F8/YPTW3wIu9LnZiwmir1v4xlBOSRwgah
 jz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220949; x=1688812949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+NHecAKie8Z+nQqF0HDXGBYLIWhD3Kd9qkCVUXQCCus=;
 b=EUrf7BI+M72VUBODEjsshe5FqJ7rC4f7jugZBobdDrwuX4Gd+fjbfiWO1t10rkpy0F
 LINj+lfMxcfiirfXZN1Lh5VVrKWDbZdCseoz5k4O2YwnE9MwRHNvSFN7WBMpXbwoGsGs
 rdx2UZTQ/SswnCn1eqtLgjvtpq4j4RX7HOqrGzhIXFblHQV7YdM7p8wfqadBREUZxw0G
 a2umYscp73ngq71QuEcNjAIgatLQLAy2ARFuj8eHL7eIUV0k9Qjoi55Ca18RPcTVk9DV
 o7Y+fvEduSMJxJo3ZN0GhRIfNY+y/xcKVgYsxHGbbCKArXXcuuOkobnm23EFXe08k5e5
 wB3Q==
X-Gm-Message-State: AC+VfDxCUbOdK3mUtb7s8N774bckPFH3rdUd2siDe47Ns76c2icGGvoE
 oVA6MTYXwdQCvvbzj/gSoFVpl19gR94=
X-Google-Smtp-Source: ACHHUZ5V25IKWfpLWCqwbtw0Ugowi9C5vfeo7BSSqZ1YAar5QLEja15A2wcxLlVlH+lwioDTzUn39g==
X-Received: by 2002:ac2:43ab:0:b0:4f3:792c:289d with SMTP id
 t11-20020ac243ab000000b004f3792c289dmr2872273lfl.20.1686220948909; 
 Thu, 08 Jun 2023 03:42:28 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:28 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 04/33] target/mips: Add emulation of S32MADD/MADDU/MSUB/MSUBU
 instructions
Date: Thu,  8 Jun 2023 13:41:53 +0300
Message-Id: <20230608104222.1520143-5-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x133.google.com
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

These instructions used to multiply 2x32-bit GPR sources & accumulate
result into 64-bit pair of XRF registers.

These instructions stain HI/LO registers with the final result.

Their opcode is close to the MIPS32R1 MADD[U]/MSUB[U], so it have to
call decode_opc_special2_legacy when failing to find MXU opcode.
Moreover, it solves issue with reinventing MUL and malfunction
MULU/CLZ/CLO instructions.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 105 +++++++++++++++++++++++++++++++-
 target/mips/tcg/translate.c     |   7 +--
 2 files changed, 105 insertions(+), 7 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 423c248d5a..f2c932eeb7 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -355,7 +355,11 @@
  */
 
 enum {
+    OPC_MXU_S32MADD  = 0x00,
+    OPC_MXU_S32MADDU = 0x01,
     OPC_MXU__POOL00  = 0x03,
+    OPC_MXU_S32MSUB  = 0x04,
+    OPC_MXU_S32MSUBU = 0x05,
     OPC_MXU_D16MUL   = 0x08,
     OPC_MXU_D16MAC   = 0x0A,
     OPC_MXU__POOL04  = 0x10,
@@ -1573,6 +1577,70 @@ static void gen_mxu_S32ALNI(DisasContext *ctx)
     }
 }
 
+/*
+ *  S32MADD XRa, XRd, rb, rc
+ *    32 to 64 bit signed multiply with subsequent add
+ *    result stored in {XRa, XRd} pair, stain HI/LO.
+ *  S32MADDU XRa, XRd, rb, rc
+ *    32 to 64 bit unsigned multiply with subsequent add
+ *    result stored in {XRa, XRd} pair, stain HI/LO.
+ *  S32MSUB XRa, XRd, rb, rc
+ *    32 to 64 bit signed multiply with subsequent subtract
+ *    result stored in {XRa, XRd} pair, stain HI/LO.
+ *  S32MSUBU XRa, XRd, rb, rc
+ *    32 to 64 bit unsigned multiply with subsequent subtract
+ *    result stored in {XRa, XRd} pair, stain HI/LO.
+ */
+static void gen_mxu_s32madd_sub(DisasContext *ctx, bool sub, bool uns)
+{
+    uint32_t XRa, XRd, Rb, Rc;
+
+    XRa  = extract32(ctx->opcode,  6, 4);
+    XRd  = extract32(ctx->opcode, 10, 4);
+    Rb   = extract32(ctx->opcode, 16, 5);
+    Rc   = extract32(ctx->opcode, 21, 5);
+
+    if (unlikely(Rb == 0 || Rc == 0)) {
+        /* do nothing because x + 0 * y => x */
+    } else if (unlikely(XRa == 0 && XRd == 0)) {
+        /* do nothing because result just dropped */
+    } else {
+        TCGv t0 = tcg_temp_new();
+        TCGv t1 = tcg_temp_new();
+        TCGv_i64 t2 = tcg_temp_new_i64();
+        TCGv_i64 t3 = tcg_temp_new_i64();
+
+        gen_load_gpr(t0, Rb);
+        gen_load_gpr(t1, Rc);
+
+        if (uns) {
+            tcg_gen_extu_tl_i64(t2, t0);
+            tcg_gen_extu_tl_i64(t3, t1);
+        } else {
+            tcg_gen_ext_tl_i64(t2, t0);
+            tcg_gen_ext_tl_i64(t3, t1);
+        }
+        tcg_gen_mul_i64(t2, t2, t3);
+
+        gen_load_mxu_gpr(t0, XRa);
+        gen_load_mxu_gpr(t1, XRd);
+
+        tcg_gen_concat_tl_i64(t3, t1, t0);
+        if (sub) {
+            tcg_gen_sub_i64(t3, t3, t2);
+        } else {
+            tcg_gen_add_i64(t3, t3, t2);
+        }
+        gen_move_low32(t1, t3);
+        gen_move_high32(t0, t3);
+
+        tcg_gen_mov_tl(cpu_HI[0], t0);
+        tcg_gen_mov_tl(cpu_LO[0], t1);
+
+        gen_store_mxu_gpr(t1, XRd);
+        gen_store_mxu_gpr(t0, XRa);
+    }
+}
 
 /*
  * Decoding engine for MXU
@@ -1603,6 +1671,35 @@ static void decode_opc_mxu__pool00(DisasContext *ctx)
     }
 }
 
+static bool decode_opc_mxu_s32madd_sub(DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 0, 6);
+    uint32_t pad  = extract32(ctx->opcode, 14, 2);
+
+    if (pad != 2) {
+        /* MIPS32R1 MADD/MADDU/MSUB/MSUBU are on pad == 0 */
+        return false;
+    }
+
+    switch (opcode) {
+    case OPC_MXU_S32MADD:
+        gen_mxu_s32madd_sub(ctx, false, false);
+        break;
+    case OPC_MXU_S32MADDU:
+        gen_mxu_s32madd_sub(ctx, false, true);
+        break;
+    case OPC_MXU_S32MSUB:
+        gen_mxu_s32madd_sub(ctx, true, false);
+        break;
+    case OPC_MXU_S32MSUBU:
+        gen_mxu_s32madd_sub(ctx, true, true);
+        break;
+    default:
+        return false;
+    }
+    return true;
+}
+
 static void decode_opc_mxu__pool04(DisasContext *ctx)
 {
     uint32_t reversed = extract32(ctx->opcode, 20, 1);
@@ -1835,6 +1932,11 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         tcg_gen_brcondi_tl(TCG_COND_NE, t_mxu_cr, MXU_CR_MXU_EN, l_exit);
 
         switch (opcode) {
+        case OPC_MXU_S32MADD:
+        case OPC_MXU_S32MADDU:
+        case OPC_MXU_S32MSUB:
+        case OPC_MXU_S32MSUBU:
+            return decode_opc_mxu_s32madd_sub(ctx);
         case OPC_MXU__POOL00:
             decode_opc_mxu__pool00(ctx);
             break;
@@ -1881,8 +1983,7 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
             decode_opc_mxu__pool19(ctx);
             break;
         default:
-            MIPS_INVAL("decode_opc_mxu");
-            gen_reserved_instruction(ctx);
+            return false;
         }
 
         gen_set_label(l_exit);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index a6ca2e5a3b..27cc8e57af 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -14653,12 +14653,9 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
         }
 #endif
         if (TARGET_LONG_BITS == 32 && (ctx->insn_flags & ASE_MXU)) {
-            if (MASK_SPECIAL2(ctx->opcode) == OPC_MUL) {
-                gen_arith(ctx, OPC_MUL, rd, rs, rt);
-            } else {
-                decode_ase_mxu(ctx, ctx->opcode);
+            if (decode_ase_mxu(ctx, ctx->opcode)) {
+                break;
             }
-            break;
         }
         decode_opc_special2_legacy(env, ctx);
         break;
-- 
2.40.0


