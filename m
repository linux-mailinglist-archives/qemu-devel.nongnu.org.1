Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 838B1728121
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:20:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWX-0003Md-Oz; Thu, 08 Jun 2023 09:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6H-0002JB-7G
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:41 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6E-0006VM-Fo
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:40 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4f4b384c09fso550808e87.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220956; x=1688812956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LwWjK9SsNWU0odkW1I3f9wANPMtQ81Hp5nXl4kMSUs8=;
 b=InEXUWeVIz+SWzq0jaDdQzO3P35PJbTYhMgULU42uCsi7ymtdNTGhh05L653GThtr3
 24Dzt8+qX8Jz6dP6klbQvldQaOk1GUaRjnxBlppeipCsr6FX1tLkeL0ELRMYVUmLRR1b
 mAruSGhpGzVQ+5oauff6c3wLID/rP8/MNlos+dMyRvhcQsq7knXQz/g8blUq4zA8RCyC
 UnEEPCGR4V+onG4JVy4jmdnhjqqcK13kUW94Wiu9KoNhXv6kE6cmpN5WKPip6kL+VY1V
 d7ax/luyooLVJ1K7Ozp6k04joMu1xrHFiqckzdgy80mNspP9BtGFSoj/Iko4n8k/KhC5
 AyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220956; x=1688812956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LwWjK9SsNWU0odkW1I3f9wANPMtQ81Hp5nXl4kMSUs8=;
 b=W6SU08M5PE43pOhLeTZ2j55ZiZqLRpZiG3lMJoO2nE0GopVf+F0grum1X3GuI0ekjy
 sUwgOeeulT0yUt0GS0SkbbaJBqLHrK999B8YILd4RCIl+23+XIat54mmgWy28MTEow8J
 W8tBxtRe+rHn7EGDwW1vYNjD3Y/Mn7K1/qpWdNgSTSTF3moJjB8O4zSlWP6iYVNUV8Ic
 t4nkUY9RskysmnllfD4Vx0ujm7yq0YDw6ImjSW4PNkDiM3X61rshlAsb4qa+oxWMlfmc
 M+ffac3CJMJFc6hPukDiHmA5kQJgJDehQUz9Pzw4Aeyxztb7Ug8hvFMDWPCEYhTyQkjf
 0hmw==
X-Gm-Message-State: AC+VfDzxwNEa946z/1Em3xyJA0Fmgn65A9DiSCq0A77uxqNjo8mj3GCb
 +1hq9pHJX8Ael0MItxT/JSnqj4aCcZ4=
X-Google-Smtp-Source: ACHHUZ7o5+YQY62erb2cbtdJz58GMuI/3sJSdJPO4NqFKVjTw11P2yUkEUBTpQq04hmuvKqRdHVKdg==
X-Received: by 2002:ac2:4a7c:0:b0:4f3:b32d:f72c with SMTP id
 q28-20020ac24a7c000000b004f3b32df72cmr2856791lfp.9.1686220956497; 
 Thu, 08 Jun 2023 03:42:36 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:36 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 11/33] target/mips: Add emulation of MXU D16MACF D16MACE
 instructions
Date: Thu,  8 Jun 2023 13:42:00 +0300
Message-Id: <20230608104222.1520143-12-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x132.google.com
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

These instructions are close to D16MAC so common generation function
provided.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 74 ++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 6 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index d1f4fc79de..cd93992eed 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -365,6 +365,8 @@ enum {
     OPC_MXU_D16MUL   = 0x08,
     OPC_MXU__POOL03  = 0x09,
     OPC_MXU_D16MAC   = 0x0A,
+    OPC_MXU_D16MACF  = 0x0B,
+    OPC_MXU_D16MACE  = 0x0F,
     OPC_MXU__POOL04  = 0x10,
     OPC_MXU__POOL05  = 0x11,
     OPC_MXU__POOL06  = 0x12,
@@ -774,10 +776,15 @@ static void gen_mxu_d16mul(DisasContext *ctx, bool fractional,
 }
 
 /*
- * D16MAC XRa, XRb, XRc, XRd, aptn2, optn2 - Signed 16 bit pattern multiply
- *                                           and accumulate
+ * D16MAC XRa, XRb, XRc, XRd, aptn2, optn2
+ *   Signed 16 bit pattern multiply and accumulate
+ * D16MACF XRa, XRb, XRc, aptn2, optn2
+ *   Signed Q15 fraction pattern multiply accumulate and pack
+ * D16MACE XRa, XRb, XRc, XRd, aptn2, optn2
+ *   Signed Q15 fraction pattern multiply and accumulate
  */
-static void gen_mxu_d16mac(DisasContext *ctx)
+static void gen_mxu_d16mac(DisasContext *ctx, bool fractional,
+                           bool packed_result)
 {
     TCGv t0, t1, t2, t3;
     uint32_t XRa, XRb, XRc, XRd, optn2, aptn2;
@@ -820,6 +827,11 @@ static void gen_mxu_d16mac(DisasContext *ctx)
         tcg_gen_mul_tl(t2, t1, t2);
         break;
     }
+
+    if (fractional) {
+        tcg_gen_shli_tl(t3, t3, 1);
+        tcg_gen_shli_tl(t2, t2, 1);
+    }
     gen_load_mxu_gpr(t0, XRa);
     gen_load_mxu_gpr(t1, XRd);
 
@@ -841,8 +853,52 @@ static void gen_mxu_d16mac(DisasContext *ctx)
         tcg_gen_sub_tl(t2, t1, t2);
         break;
     }
-    gen_store_mxu_gpr(t3, XRa);
-    gen_store_mxu_gpr(t2, XRd);
+
+    if (fractional) {
+        TCGLabel *l_done = gen_new_label();
+        TCGv rounding = tcg_temp_new();
+
+        tcg_gen_andi_tl(rounding, mxu_CR, 0x2);
+        tcg_gen_brcondi_tl(TCG_COND_EQ, rounding, 0, l_done);
+        if (packed_result) {
+            TCGLabel *l_apply_bias_l = gen_new_label();
+            TCGLabel *l_apply_bias_r = gen_new_label();
+            TCGLabel *l_half_done = gen_new_label();
+            TCGv bias = tcg_temp_new();
+
+            /*
+             * D16MACF supports unbiased rounding aka "bankers rounding",
+             * "round to even", "convergent rounding"
+             */
+            tcg_gen_andi_tl(bias, mxu_CR, 0x4);
+            tcg_gen_brcondi_tl(TCG_COND_NE, bias, 0, l_apply_bias_l);
+            tcg_gen_andi_tl(t0, t3, 0x1ffff);
+            tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0x8000, l_half_done);
+            gen_set_label(l_apply_bias_l);
+            tcg_gen_addi_tl(t3, t3, 0x8000);
+            gen_set_label(l_half_done);
+            tcg_gen_brcondi_tl(TCG_COND_NE, bias, 0, l_apply_bias_r);
+            tcg_gen_andi_tl(t0, t2, 0x1ffff);
+            tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0x8000, l_done);
+            gen_set_label(l_apply_bias_r);
+            tcg_gen_addi_tl(t2, t2, 0x8000);
+        } else {
+            /* D16MACE doesn't support unbiased rounding */
+            tcg_gen_addi_tl(t3, t3, 0x8000);
+            tcg_gen_addi_tl(t2, t2, 0x8000);
+        }
+        gen_set_label(l_done);
+    }
+
+    if (!packed_result) {
+        gen_store_mxu_gpr(t3, XRa);
+        gen_store_mxu_gpr(t2, XRd);
+    } else {
+        tcg_gen_andi_tl(t3, t3, 0xffff0000);
+        tcg_gen_shri_tl(t2, t2, 16);
+        tcg_gen_or_tl(t3, t3, t2);
+        gen_store_mxu_gpr(t3, XRa);
+    }
 }
 
 /*
@@ -2700,7 +2756,13 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
             gen_mxu_d16mul(ctx, false, false);
             break;
         case OPC_MXU_D16MAC:
-            gen_mxu_d16mac(ctx);
+            gen_mxu_d16mac(ctx, false, false);
+            break;
+        case OPC_MXU_D16MACF:
+            gen_mxu_d16mac(ctx, true, true);
+            break;
+        case OPC_MXU_D16MACE:
+            gen_mxu_d16mac(ctx, true, false);
             break;
         case OPC_MXU__POOL01:
             decode_opc_mxu__pool01(ctx);
-- 
2.40.0


