Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D9C74E11F
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:31:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzNa-0002ph-Mr; Mon, 10 Jul 2023 18:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzNT-0002XH-Nt
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzNO-00025N-1m
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:06 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbc12181b6so56030375e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028140; x=1691620140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=euQhAQvXbEs7j0sguxx0MdXawuSdWHEUZ1wzSe2fcO4=;
 b=es+bfiEDvv3SAnV/ZY6MlOVd+vm2AfisOdccq+RjzMiXfmy72Dw7F+nbgWbV+Qvps1
 8K9MMK1KsQz5pd634d8wld2sHbRc1+jceUl2uDoOK6z+EHA5LMsopf4zyAtMl3bjvCE/
 Gncju3pTinWbE22GOKWgkifwaTcX88ANdt2N+zLs51VHBosfrFi/C5iTNfkhFAcLaZ5G
 39pSZTk//bLKKfxE8slmndSE7uTy+jnGkxIdZ9lHUT0hZh/aOMewbnOKuIMkVvQ4CzIf
 0f86VrNV9giYv/AFbo7nU2Tgb4tBFnf8CV6Hr3/SlyVeco36BVKisyiEvr20OCL7Xqbu
 hXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028140; x=1691620140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=euQhAQvXbEs7j0sguxx0MdXawuSdWHEUZ1wzSe2fcO4=;
 b=M3+nhyUQEZszwoGmvz/gsIOS5RLqN52owWmZ8WLZt5d24qpdAnxMdwMvnOqhPyUwPz
 SwVhNJE9mWTuQkOSVLj5thRajpedB2Ed9DZ78J6R68FQ779HiZ7EQNBKqeXsj8p6fdmj
 Skpht2EqqMW1Kni8f2nQ6toNBYdzFuBomvC/DlXqvU+fnSsBCM3PobA7b3xkl6AB+SOd
 5YG3WiqVkFgaPqwhf97VBK6WvLXWe8y1JI75XXWG6N/yMZvJYE2gfkZIUkgmYRKQV7uV
 hJS5mnSToKjipAjXun/Zb+dcovsl2JpzRX8WL5KTx2n/4DVZDXLKCH5SxEBsypqAy2pF
 8dgg==
X-Gm-Message-State: ABy/qLY5+ljl3R1GFzOe9lX6ltVoVx5NyEgGGP9tQTNR9VdKOD+YLKKj
 C5pJbAxuRtAbyMeORXeLg7RVmPpAls5zRh11DkQsgg==
X-Google-Smtp-Source: APBJJlH+cu3Rzf43ZlexsGxNFBqKGOA6hhqZ+Mx0tMe+GQVIVvDEG0EDzNi+oR/ixwjK2D2ihYQlNw==
X-Received: by 2002:a7b:cd8e:0:b0:3f9:b9e7:2f8d with SMTP id
 y14-20020a7bcd8e000000b003f9b9e72f8dmr12554446wmj.2.1689028140162; 
 Mon, 10 Jul 2023 15:29:00 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 11-20020a05600c230b00b003fbaade0735sm11295211wmo.19.2023.07.10.15.28.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:28:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 31/44] target/mips/mxu: Add S32/D16/Q8- MOVZ/MOVN instructions
Date: Tue, 11 Jul 2023 00:25:58 +0200
Message-Id: <20230710222611.50978-32-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

These instructions are:
- single 32-bit
- dual 16-bit packed
- quad 8-bit packed
conditional moves.
They are grouped in pool20 in the source code.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-29-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 188 ++++++++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 32fc236d87..f8c3fdb103 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -403,6 +403,7 @@ enum {
     OPC_MXU__POOL18  = 0x36,
     OPC_MXU_Q16SAR   = 0x37,
     OPC_MXU__POOL19  = 0x38,
+    OPC_MXU__POOL20  = 0x39,
 };
 
 
@@ -541,6 +542,18 @@ enum {
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
@@ -1993,6 +2006,8 @@ static void gen_mxu_q16sxxv(DisasContext *ctx, bool right, bool arithmetic)
  *                                           Q8SLTU
  *                                D16AVG     Q8AVG
  *                                D16AVGR    Q8AVGR
+ *                     S32MOVZ    D16MOVZ    Q8MOVZ
+ *                     S32MOVN    D16MOVN    Q8MOVN
  */
 
 /*
@@ -2491,6 +2506,146 @@ static void gen_mxu_q8avg(DisasContext *ctx, bool round45)
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
@@ -4407,6 +4562,36 @@ static void decode_opc_mxu__pool19(DisasContext *ctx)
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
@@ -4567,6 +4752,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
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
2.38.1


