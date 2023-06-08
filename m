Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBBA72811C
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:20:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FXD-0004EX-NA; Thu, 08 Jun 2023 09:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6Y-0002QU-HN
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:58 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6W-0006Ts-LO
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:58 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b1ba018d94so4023001fa.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220975; x=1688812975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oukn5IHKaqjJWbKA9kcJmNnS+g/AopOldCdE2I5lKic=;
 b=n3MgjGZh49AaCI9SFWpeQ7K3I47JruaN0aoq95Bw1dAvSqKQnQQCg5GhiRSMb59BDH
 2FpulXISX42r9b1dhXjS4vHL48QVTm09wjQ6CnpdYekSjMLs8prTvdrlyNZBwJiUTL4g
 S2ClJBP5dnI5yUMCryzg7iw9e4GE44G1T+mgMtj1CspJ9IzZ7pm7gBha8iVAVHtePCWK
 TSOVhkwRb1YPCIXwPeHAqA9gDyhdkyGE6NBOf5IDvTp/6HhFqKyU9agRmIkPLaB1dqSH
 bCZcvhQ6qiHXN8syurO/nWYLorNjJZaQUxfGY7E3a4mak1rhHKz86Zv8EW7qkGLuZilO
 43/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220975; x=1688812975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oukn5IHKaqjJWbKA9kcJmNnS+g/AopOldCdE2I5lKic=;
 b=SmCTH1t1qpbfiiyZf8cGblWVjseLDpnoXpWQgY705QW0ymIT4OKJ2mdgyY3fao6Z+6
 2QV9KMXjIQe6qGbMiz4irNXo1uZJ+V38Cp+WeQn7vJM0VFpOrS3ylnq5rxDM8zotFiwz
 1qB1clH26L6YUqlCO/zxq+ZzIkhHt5l8M5wMpXrrJ69rFBQSqlASNAMLdiVrXqSOInsp
 JZb2XsBEHJKWvn5MOIRGkRGjksvAPVsGCJeWhC0rA39ktwDnoRSh33KlR4AqaetF9J6c
 7cGlZu/TZtDgHDKgymc2MSORnRylHLjNK2iD24QYyr+d9ksgkaFd4cw+SSQW3KjDsi7d
 v+HQ==
X-Gm-Message-State: AC+VfDyrEOPFbDMOuFP9N1GOp2m+qKCgELS0bR/+KzGdKgErmPvGEXEj
 w/gR9TWAHilynOqjqtvaYUQqL2qjC7k=
X-Google-Smtp-Source: ACHHUZ59SyhGrC7IRNGiNLRps4zKxM9E0U1XIZBGEKC+pjAoNSrRsaOmG6x3+/KodYPpfOqPv4G4GA==
X-Received: by 2002:a2e:7219:0:b0:2ad:1ba2:eff3 with SMTP id
 n25-20020a2e7219000000b002ad1ba2eff3mr3398581ljc.20.1686220975396; 
 Thu, 08 Jun 2023 03:42:55 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:55 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 28/33] target/mips: Add emulation of MXU S32/D16/Q8- MOVZ/MOVN
 instructions
Date: Thu,  8 Jun 2023 13:42:17 +0300
Message-Id: <20230608104222.1520143-29-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=lis8215@gmail.com; helo=mail-lj1-x234.google.com
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

These instructions are:
- single 32-bit
- dual 16-bit packed
- quad 8-bit packed
conditional moves.
They are grouped in pool20 in the source code.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 188 ++++++++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index ccc375db87..74b2712d8d 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -405,6 +405,7 @@ enum {
     OPC_MXU__POOL18  = 0x36,
     OPC_MXU_Q16SAR   = 0x37,
     OPC_MXU__POOL19  = 0x38,
+    OPC_MXU__POOL20  = 0x39,
 };
 
 
@@ -543,6 +544,18 @@ enum {
     OPC_MXU_Q8MULSU  = 0x01,
 };
 
+/*
+ * MXU pool 20
+ */
+enum {
+    OPC_MXU_Q8MOVZ   = 0x00,
+    OPC_MXU_Q8MOVN   = 0x01,
+    OPC_MXU_D16MOVZ  = 0x02,
+    OPC_MXU_D16MOVN  = 0x03,
+    OPC_MXU_S32MOVZ  = 0x04,
+    OPC_MXU_S32MOVN  = 0x05,
+};
+
 /* MXU accumulate add/subtract 1-bit pattern 'aptn1' */
 #define MXU_APTN1_A    0
 #define MXU_APTN1_S    1
@@ -1995,6 +2008,8 @@ static void gen_mxu_q16sxxv(DisasContext *ctx, bool right, bool arithmetic)
  *                                           Q8SLTU
  *                                D16AVG     Q8AVG
  *                                D16AVGR    Q8AVGR
+ *                     S32MOVZ    D16MOVZ    Q8MOVZ
+ *                     S32MOVN    D16MOVN    Q8MOVN
  */
 
 /*
@@ -2493,6 +2508,146 @@ static void gen_mxu_q8avg(DisasContext *ctx, bool round45)
     }
 }
 
+/*
+ *  Q8MOVZ
+ *    Quadruple 8-bit packed conditional move where
+ *    XRb contains conditions, XRc what to move and
+ *    XRa is the destination.
+ *    a.k.a. if (XRb[0..3] == 0) { XRa[0..3] = XRc[0..3] }
+ *
+ *  Q8MOVN
+ *    Quadruple 8-bit packed conditional move where
+ *    XRb contains conditions, XRc what to move and
+ *    XRa is the destination.
+ *    a.k.a. if (XRb[0..3] != 0) { XRa[0..3] = XRc[0..3] }
+ */
+static void gen_mxu_q8movzn(DisasContext *ctx, TCGCond cond)
+{
+    uint32_t XRc, XRb, XRa;
+
+    XRa = extract32(ctx->opcode,  6, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRc = extract32(ctx->opcode, 14, 4);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+    TCGv t3 = tcg_temp_new();
+    TCGLabel *l_quarterdone = gen_new_label();
+    TCGLabel *l_halfdone = gen_new_label();
+    TCGLabel *l_quarterrest = gen_new_label();
+    TCGLabel *l_done = gen_new_label();
+
+    gen_load_mxu_gpr(t0, XRc);
+    gen_load_mxu_gpr(t1, XRb);
+    gen_load_mxu_gpr(t2, XRa);
+
+    tcg_gen_extract_tl(t3, t1, 24, 8);
+    tcg_gen_brcondi_tl(cond, t3, 0, l_quarterdone);
+    tcg_gen_extract_tl(t3, t0, 24, 8);
+    tcg_gen_deposit_tl(t2, t2, t3, 24, 8);
+
+    gen_set_label(l_quarterdone);
+    tcg_gen_extract_tl(t3, t1, 16, 8);
+    tcg_gen_brcondi_tl(cond, t3, 0, l_halfdone);
+    tcg_gen_extract_tl(t3, t0, 16, 8);
+    tcg_gen_deposit_tl(t2, t2, t3, 16, 8);
+
+    gen_set_label(l_halfdone);
+    tcg_gen_extract_tl(t3, t1, 8, 8);
+    tcg_gen_brcondi_tl(cond, t3, 0, l_quarterrest);
+    tcg_gen_extract_tl(t3, t0, 8, 8);
+    tcg_gen_deposit_tl(t2, t2, t3, 8, 8);
+
+    gen_set_label(l_quarterrest);
+    tcg_gen_extract_tl(t3, t1, 0, 8);
+    tcg_gen_brcondi_tl(cond, t3, 0, l_done);
+    tcg_gen_extract_tl(t3, t0, 0, 8);
+    tcg_gen_deposit_tl(t2, t2, t3, 0, 8);
+
+    gen_set_label(l_done);
+    gen_store_mxu_gpr(t2, XRa);
+}
+
+/*
+ *  D16MOVZ
+ *    Double 16-bit packed conditional move where
+ *    XRb contains conditions, XRc what to move and
+ *    XRa is the destination.
+ *    a.k.a. if (XRb[0..1] == 0) { XRa[0..1] = XRc[0..1] }
+ *
+ *  D16MOVN
+ *    Double 16-bit packed conditional move where
+ *    XRb contains conditions, XRc what to move and
+ *    XRa is the destination.
+ *    a.k.a. if (XRb[0..3] != 0) { XRa[0..1] = XRc[0..1] }
+ */
+static void gen_mxu_d16movzn(DisasContext *ctx, TCGCond cond)
+{
+    uint32_t XRc, XRb, XRa;
+
+    XRa = extract32(ctx->opcode,  6, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRc = extract32(ctx->opcode, 14, 4);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+    TCGv t3 = tcg_temp_new();
+    TCGLabel *l_halfdone = gen_new_label();
+    TCGLabel *l_done = gen_new_label();
+
+    gen_load_mxu_gpr(t0, XRc);
+    gen_load_mxu_gpr(t1, XRb);
+    gen_load_mxu_gpr(t2, XRa);
+
+    tcg_gen_extract_tl(t3, t1, 16, 16);
+    tcg_gen_brcondi_tl(cond, t3, 0, l_halfdone);
+    tcg_gen_extract_tl(t3, t0, 16, 16);
+    tcg_gen_deposit_tl(t2, t2, t3, 16, 16);
+
+    gen_set_label(l_halfdone);
+    tcg_gen_extract_tl(t3, t1, 0, 16);
+    tcg_gen_brcondi_tl(cond, t3, 0, l_done);
+    tcg_gen_extract_tl(t3, t0, 0, 16);
+    tcg_gen_deposit_tl(t2, t2, t3, 0, 16);
+
+    gen_set_label(l_done);
+    gen_store_mxu_gpr(t2, XRa);
+}
+
+/*
+ *  S32MOVZ
+ *    Quadruple 32-bit conditional move where
+ *    XRb contains conditions, XRc what to move and
+ *    XRa is the destination.
+ *    a.k.a. if (XRb == 0) { XRa = XRc }
+ *
+ *  S32MOVN
+ *    Single 32-bit conditional move where
+ *    XRb contains conditions, XRc what to move and
+ *    XRa is the destination.
+ *    a.k.a. if (XRb != 0) { XRa = XRc }
+ */
+static void gen_mxu_s32movzn(DisasContext *ctx, TCGCond cond)
+{
+    uint32_t XRc, XRb, XRa;
+
+    XRa = extract32(ctx->opcode,  6, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRc = extract32(ctx->opcode, 14, 4);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGLabel *l_done = gen_new_label();
+
+    gen_load_mxu_gpr(t0, XRc);
+    gen_load_mxu_gpr(t1, XRb);
+
+    tcg_gen_brcondi_tl(cond, t1, 0, l_done);
+    gen_store_mxu_gpr(t0, XRa);
+    gen_set_label(l_done);
+}
 
 /*
  *      MXU instruction category: Addition and subtraction
@@ -4409,6 +4564,36 @@ static void decode_opc_mxu__pool19(DisasContext *ctx)
     }
 }
 
+static void decode_opc_mxu__pool20(DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 18, 3);
+
+    switch (opcode) {
+    case OPC_MXU_Q8MOVZ:
+        gen_mxu_q8movzn(ctx, TCG_COND_NE);
+        break;
+    case OPC_MXU_Q8MOVN:
+        gen_mxu_q8movzn(ctx, TCG_COND_EQ);
+        break;
+    case OPC_MXU_D16MOVZ:
+        gen_mxu_d16movzn(ctx, TCG_COND_NE);
+        break;
+    case OPC_MXU_D16MOVN:
+        gen_mxu_d16movzn(ctx, TCG_COND_EQ);
+        break;
+    case OPC_MXU_S32MOVZ:
+        gen_mxu_s32movzn(ctx, TCG_COND_NE);
+        break;
+    case OPC_MXU_S32MOVN:
+        gen_mxu_s32movzn(ctx, TCG_COND_EQ);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        gen_reserved_instruction(ctx);
+        break;
+    }
+}
+
 bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
 {
     uint32_t opcode = extract32(insn, 0, 6);
@@ -4569,6 +4754,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU__POOL19:
             decode_opc_mxu__pool19(ctx);
             break;
+        case OPC_MXU__POOL20:
+            decode_opc_mxu__pool20(ctx);
+            break;
         default:
             return false;
         }
-- 
2.40.0


