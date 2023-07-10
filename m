Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D4374E129
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:32:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzLO-0003X6-DH; Mon, 10 Jul 2023 18:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLN-0003WZ-8E
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:26:57 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLL-0001km-Gx
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:26:57 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3143b88faebso5803828f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028013; x=1691620013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5oVbsbU8jbT/CYyTr6Av4cwt8dIizvkvGiVKYMDBysA=;
 b=o2kVd8IKx2TS8v+XDHY58FgtBcDVgYY3By3/Rl+YZ1+0PHAsJ5gTATaZ0HXOPE/Xzu
 y9ESqjMQaEaphd4Dv+SsdHI/mZSJbT99sG8Yl/uUCDLMymlnLDgnPVyYg/mMOB0l2L8o
 Y/NwFZ3omQIdWx5wAzPuaRIM5oJdSZmxbgkhVkhK5uqXM+FYzbLKXh7NOugM+L9t/xex
 0LKSJYJinQbddXt2dJb+fNt5ds73q9GDV9C8VszPuN4ZNaKt1OyKdjiL7N2j2306IVzf
 doupaJsMoAss0yTOqUsDNBLaMIITOf1LlCOj1KKKXdm9qZVPU8o/cLpYCMOww4KzOeWl
 tsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028013; x=1691620013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5oVbsbU8jbT/CYyTr6Av4cwt8dIizvkvGiVKYMDBysA=;
 b=W8Virv19993Ic97Os7hA+PqGFH98D/F5SjHAAyftcOmADlxBBlrngfzfuUaFz1NBjr
 nd4zFFLLi8Isl13ZomrhoJ6S2X5yYBE/GQ7yh1FG8c3iV/8z+6chxSookt4yIzb7MIGZ
 vVPIXhMnx7qsm1EivYFB9H2iDy+ZarYTc+BYkT77lScPZREqnZnmeRRywoUH6asX3ScI
 pRAUfllOfY6QJGuEn650yZRonsSHEay9BzBAvFn9uam8sHbjOMVBg3NfLGJhkpqH0sKp
 LxvJIMiBAcEnNPc1IieNb394FVNWB5/S1VoClmq9aJ5xb2xzR9MhGTCbqIyla66/xmht
 IpHg==
X-Gm-Message-State: ABy/qLbPCzF6N0I/Y1cSoCoV+ohP6JvLNlNRdla6zOd7v6aueX/sfgYT
 sUdy4aJOaHbsfcwB3RK8Q833+aHObkG9MTzorj4Lpw==
X-Google-Smtp-Source: APBJJlHLjDYgxQzyxw0eEZ5gkkYEjkgC3fF2lnflu2lB7c6Ayq9b3vskiubaNYFWtYrR1/hga91hvg==
X-Received: by 2002:a5d:6a48:0:b0:313:f2bf:295a with SMTP id
 t8-20020a5d6a48000000b00313f2bf295amr14270540wrw.39.1689028013702; 
 Mon, 10 Jul 2023 15:26:53 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 c3-20020a5d4cc3000000b00311299df211sm517959wrt.77.2023.07.10.15.26.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:26:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 07/44] target/mips/mxu: Add S32MADD/MADDU/MSUB/MSUBU
 instructions
Date: Tue, 11 Jul 2023 00:25:34 +0200
Message-Id: <20230710222611.50978-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

These instructions used to multiply 2x32-bit GPR sources & accumulate
result into 64-bit pair of XRF registers.

These instructions stain HI/LO registers with the final result.

Their opcode is close to the MIPS32R1 MADD[U]/MSUB[U], so it have to
call decode_opc_special2_legacy when failing to find MXU opcode.
Moreover, it solves issue with reinventing MUL and malfunction
MULU/CLZ/CLO instructions.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-5-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 105 +++++++++++++++++++++++++++++++-
 target/mips/tcg/translate.c     |   7 +--
 2 files changed, 105 insertions(+), 7 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 6703e8aca4..00a4d1da18 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -353,7 +353,11 @@
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
@@ -1571,6 +1575,70 @@ static void gen_mxu_S32ALNI(DisasContext *ctx)
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
@@ -1601,6 +1669,35 @@ static void decode_opc_mxu__pool00(DisasContext *ctx)
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
@@ -1833,6 +1930,11 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
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
@@ -1879,8 +1981,7 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
             decode_opc_mxu__pool19(ctx);
             break;
         default:
-            MIPS_INVAL("decode_opc_mxu");
-            gen_reserved_instruction(ctx);
+            return false;
         }
 
         gen_set_label(l_exit);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 7abbb0b5e2..9bb40f1849 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -14644,12 +14644,9 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
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
2.38.1


