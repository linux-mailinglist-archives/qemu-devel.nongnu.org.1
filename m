Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6BB728136
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:22:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWV-0003MZ-MH; Thu, 08 Jun 2023 09:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6C-0002IW-W4
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:37 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6B-0006UR-BE
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:36 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b1bf74e080so6079221fa.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220953; x=1688812953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lylHHh7C6wzcTOs6sJVxLs/h1D3pxOjTHqnreM1ZEnY=;
 b=EdrF5il8FkIWLUju1vAJLI0go3onXdHTJGE6Ub7zpztf6wbw5Tl+VzPCxmFh4euOJ/
 Vb/NboWVbyO/eC8a2M7cybwgFRxQGIqojvAhKuaa0y8p7mO+iHvM+SKJXjsMFovhGdTe
 2ourry4BY3r0BC9wqp0jPf/uG/uEhy2hhzGVVk/3PYkqoCoHy20F6wBsJRooBdGqdwU3
 1MwrOu0kjElwORSWDDy2k8NTb8uFx/aetm16KsferrHTexFx0J30NHFnud/1XqgSCJVb
 2IvKQ3qkvcexDzBtLzfS6CoRcjY/DybwNbh5dO2Eu41C0+LH35avcHEnQRZMKx18C9B2
 ALSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220953; x=1688812953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lylHHh7C6wzcTOs6sJVxLs/h1D3pxOjTHqnreM1ZEnY=;
 b=Dc9sDHgguUbIwie8LAoR1uVA9QmJilz4y6ySemS1jdftYqkHSyxithYyP22eZjnrBu
 nBkMaWRQVlSx6RSR86+ublDjSdFK5lpYYnYyZU7HC7hf3WM3U9aF7PLdaENHkLqa2X3D
 4hfbjMpGTIuSe7EwKIhtE6EMEJTpwyLK1Eld8ewvpxCmeBgkxtPCBiyP+W7Vcyqr3Zlp
 1B+MhLL5JU3+3/IvrrCtVPBhtmSWCHaLxqjH4PsmUez5QCNdjCKwrdblGSqEIzPDi/dA
 Vdep9hMkm/XrXiC8y0T0lXbzN0zvX2IJYW+dMfjBkhhXudW/pVyHo/4/5wfpydwaBXHv
 8jtw==
X-Gm-Message-State: AC+VfDzrnk0UdLzK/Y2F0RJfmXOFzbE+v8u4xUGlJgDoyfJM8MzP4x2W
 sbcSBnbXhE9xX33v4gftR01j7JrUhkA=
X-Google-Smtp-Source: ACHHUZ5oAbHxP5JeHZ80ZUE0QJ1KTNHJ+sAYOTbZGMCStB4vOLTaD4a/qGJonNU/16LcAQe+pGwF2w==
X-Received: by 2002:a2e:b113:0:b0:2b2:621:2e60 with SMTP id
 p19-20020a2eb113000000b002b206212e60mr670041ljl.3.1686220953267; 
 Thu, 08 Jun 2023 03:42:33 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:32 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 08/33] target/mips: Add emulation of Q8ADD instruction
Date: Thu,  8 Jun 2023 13:41:57 +0300
Message-Id: <20230608104222.1520143-9-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=lis8215@gmail.com; helo=mail-lj1-x232.google.com
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

This instruction is used to add/subtract quadruple
8-bit values to another quadruple in parallel.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 77 +++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 2c1d7f139e..2eebdfe8ca 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -404,6 +404,7 @@ enum {
     OPC_MXU_D16AVGR  = 0x03,
     OPC_MXU_Q8AVG    = 0x04,
     OPC_MXU_Q8AVGR   = 0x05,
+    OPC_MXU_Q8ADD    = 0x07,
 };
 
 /*
@@ -1675,6 +1676,79 @@ static void gen_mxu_q8avg(DisasContext *ctx, bool round45)
 }
 
 
+/*
+ *                 MXU instruction category: Arithmetic
+ *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *                       Q8ADD
+ */
+
+/*
+ *  Q8ADD XRa, XRb, XRc, ptn2
+ *  Add/subtract quadruple of 8-bit packed in XRb
+ *  to another one in XRc, put the result in XRa.
+ */
+static void gen_mxu_Q8ADD(DisasContext *ctx)
+{
+    uint32_t aptn2, pad, XRc, XRb, XRa;
+
+    aptn2 = extract32(ctx->opcode, 24, 2);
+    pad   = extract32(ctx->opcode, 21, 3);
+    XRc   = extract32(ctx->opcode, 14, 4);
+    XRb   = extract32(ctx->opcode, 10, 4);
+    XRa   = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to zero */
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
+    } else {
+        /* the most general case */
+        TCGv t0 = tcg_temp_new();
+        TCGv t1 = tcg_temp_new();
+        TCGv t2 = tcg_temp_new();
+        TCGv t3 = tcg_temp_new();
+        TCGv t4 = tcg_temp_new();
+
+        gen_load_mxu_gpr(t3, XRb);
+        gen_load_mxu_gpr(t4, XRc);
+
+        for (int i = 0; i < 4; i++) {
+            tcg_gen_andi_tl(t0, t3, 0xff);
+            tcg_gen_andi_tl(t1, t4, 0xff);
+
+            if (i < 2) {
+                if (aptn2 & 0x01) {
+                    tcg_gen_sub_tl(t0, t0, t1);
+                } else {
+                    tcg_gen_add_tl(t0, t0, t1);
+                }
+            } else {
+                if (aptn2 & 0x02) {
+                    tcg_gen_sub_tl(t0, t0, t1);
+                } else {
+                    tcg_gen_add_tl(t0, t0, t1);
+                }
+            }
+            if (i < 3) {
+                tcg_gen_shri_tl(t3, t3, 8);
+                tcg_gen_shri_tl(t4, t4, 8);
+            }
+            if (i > 0) {
+                tcg_gen_deposit_tl(t2, t2, t0, 8 * i, 8);
+            } else {
+                tcg_gen_andi_tl(t0, t0, 0xff);
+                tcg_gen_mov_tl(t2, t0);
+            }
+        }
+        gen_store_mxu_gpr(t2, XRa);
+    }
+}
+
+
 /*
  *                 MXU instruction category: align
  *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -2004,6 +2078,9 @@ static void decode_opc_mxu__pool01(DisasContext *ctx)
     case OPC_MXU_Q8AVGR:
         gen_mxu_q8avg(ctx, true);
         break;
+    case OPC_MXU_Q8ADD:
+        gen_mxu_Q8ADD(ctx);
+        break;
     default:
         MIPS_INVAL("decode_opc_mxu");
         gen_reserved_instruction(ctx);
-- 
2.40.0


