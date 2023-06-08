Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D9872812F
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:21:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWt-0003ad-Lb; Thu, 08 Jun 2023 09:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6A-0002Hf-Mr
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:34 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D69-0006Tc-1C
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:34 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4f4b384c09fso550720e87.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220950; x=1688812950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3egzxiJur2rN7/YWluxmXadVms9Pe9FdKBoP90GdKDY=;
 b=QzPdMh9mxw6jvcN0hYu85VVJat2IDS72c/0FLuSTJM3XPziKB33DWQj3PPImVfFHWE
 OUR96bhrsmzoy1PQEXEYJrlVmLUN5bcpVwzsmgjRpNHtYsb/QGp/VEUfHY766K9MiDzS
 IsPIxx9TXIJJwtPcDNIP4Kswon+llwA62h0sZGff2X7tHfvpgpGtetGWJSpzSNOmFUaJ
 I3R28bWrCxdJlEB7oJRqhrEVBC0kJkhTeaQ6UTde5dTot56gEr9lmDQ1hUdo0EcZ5VdR
 tzY/Cin7q2w78sn0Npya4mLyErI3azmpN1VdUGaAYITr4UrsOqhiL9BuBg0+cxYQKrd1
 2DFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220950; x=1688812950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3egzxiJur2rN7/YWluxmXadVms9Pe9FdKBoP90GdKDY=;
 b=Qp5mApPCBbHDuaIld+owLV34MdVeRFIYIYUeEzFg3TQCpjwNpdANuTtV3Y3EQKBtg0
 j8dM2FIJpYMRTWOaskXCy857kWROYDqH1be6ADnX4gwUB6CiA+xk850GMP4JSnRW5BVf
 I7x7/Fx7nqZp+R/CQDXuHwjyjuW6nMiZGYFrxEVz6nCodOUXTLjj1qiQjP2F3f4/6jR3
 lMwlam73C5N3w48g4e9C7CRmoJWnfEYn+U4U6qdC0uWRtEqUW8yBTikusjPQ13M6kl5X
 sEq1vGDZ/NrU/Q6I9dF5o5h96f7bKAoKqST64sJvILrQE93tUr5c9ehMVq79GkVznsiX
 9aKg==
X-Gm-Message-State: AC+VfDwodsgD4xCZiZeqo487bsUTCEbbVNo536P1ttZwkpB7T97tYwY7
 zs4GO+Vb+c6RBWl8WWbU3eTWcSMHbg0=
X-Google-Smtp-Source: ACHHUZ7ZHOJjlLPrZ25zWm87d+q2Z0jvxCeDduwHnF9UZbXzqB9d4VGkX7raBcEZfTqK3FIB/NF55w==
X-Received: by 2002:a2e:b004:0:b0:2af:8635:96a1 with SMTP id
 y4-20020a2eb004000000b002af863596a1mr3070872ljk.33.1686220950033; 
 Thu, 08 Jun 2023 03:42:30 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:29 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 05/33] target/mips: Add emulation of Q8SLT Q8SLTU instructions
Date: Thu,  8 Jun 2023 13:41:54 +0300
Message-Id: <20230608104222.1520143-6-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
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

These instructions are used to set bits depending on
comparison result in each byte respectively.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 65 +++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index f2c932eeb7..b7bdc07dd7 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -389,6 +389,8 @@ enum {
     OPC_MXU_D16MIN   = 0x03,
     OPC_MXU_Q8MAX    = 0x04,
     OPC_MXU_Q8MIN    = 0x05,
+    OPC_MXU_Q8SLT    = 0x06,
+    OPC_MXU_Q8SLTU   = 0x07,
 };
 
 /*
@@ -1399,6 +1401,63 @@ static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
     }
 }
 
+/*
+ *  Q8SLT
+ *    Update XRa with the signed "set less than" comparison of XRb and XRc
+ *    on per-byte basis.
+ *    a.k.a. XRa[0..3] = XRb[0..3] < XRc[0..3] ? 1 : 0;
+ *
+ *  Q8SLTU
+ *    Update XRa with the unsigned "set less than" comparison of XRb and XRc
+ *    on per-byte basis.
+ *    a.k.a. XRa[0..3] = XRb[0..3] < XRc[0..3] ? 1 : 0;
+ */
+static void gen_mxu_q8slt(DisasContext *ctx, bool sltu)
+{
+    uint32_t pad, XRc, XRb, XRa;
+
+    pad = extract32(ctx->opcode, 21, 5);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRa = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to zero */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+    } else if (unlikely(XRb == XRc)) {
+        /* both operands same registers -> just set destination to zero */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
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
+        tcg_gen_movi_tl(t2, 0);
+
+        for (int i = 0; i < 4; i++) {
+            if (sltu) {
+                tcg_gen_extract_tl(t0, t3, 8 * i, 8);
+                tcg_gen_extract_tl(t1, t4, 8 * i, 8);
+            } else {
+                tcg_gen_sextract_tl(t0, t3, 8 * i, 8);
+                tcg_gen_sextract_tl(t1, t4, 8 * i, 8);
+            }
+            tcg_gen_setcond_tl(TCG_COND_LT, t0, t0, t1);
+            tcg_gen_deposit_tl(t2, t2, t0, 8 * i, 8);
+        }
+        gen_store_mxu_gpr(t2, XRa);
+    }
+}
+
 
 /*
  *                 MXU instruction category: align
@@ -1664,6 +1723,12 @@ static void decode_opc_mxu__pool00(DisasContext *ctx)
     case OPC_MXU_Q8MIN:
         gen_mxu_Q8MAX_Q8MIN(ctx);
         break;
+    case OPC_MXU_Q8SLT:
+        gen_mxu_q8slt(ctx, false);
+        break;
+    case OPC_MXU_Q8SLTU:
+        gen_mxu_q8slt(ctx, true);
+        break;
     default:
         MIPS_INVAL("decode_opc_mxu");
         gen_reserved_instruction(ctx);
-- 
2.40.0


