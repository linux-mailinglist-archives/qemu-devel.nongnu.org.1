Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D95272811F
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:20:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWZ-0003Mk-Oh; Thu, 08 Jun 2023 09:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6K-0002L4-CK
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:44 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6I-0006WI-Px
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:44 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4effb818c37so562529e87.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220961; x=1688812961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3uE4GaEsW/x50YRMMv7uHN9X9c9wJxLCodd7Qq/a4k=;
 b=PPtJrrgnlDXCTgZ5p6UOS6Kl0y8XvauVx/zdf4KcUn24Nx7CyjdlVKlFGXiacyeAoR
 w+zD44fx1njnHVHfGRmTqkvjCZGqB8rNO+BxUhuBbWjNOIhozBteNAXmFPZIFZcMts+/
 4IHaCbzFczcQ/wmqozuRGUKTnZkGeCHzhpltyBydCW41jgXF60Cm6iRM7CeDxQH9X3On
 k5WUsZPOqqElPTm3mRJmPtWslb5LIF61SJy5DUa8IvE+EIt8g99CB4BRGdqyriesTCgj
 Y1wDuJtkhAps6e0ysdg4lwM72TTuVz4YhkjEfEtvAuOMnur+604DDJTk/Y/0oYcj2Gbr
 w0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220961; x=1688812961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t3uE4GaEsW/x50YRMMv7uHN9X9c9wJxLCodd7Qq/a4k=;
 b=PiCwBnSM/VCHIWWgERmF6dufOxqWokzi/PNVa9sgSmLoHKtEVkEXjOlMvHYJ+qtY+r
 ZmjCh3uvP9i26cZCAHwxrmEJS9oBNCOYlnfetk/eDPLNCGtNXpo+GmRGXw1Wp9lvx0S6
 rxsISBtoKpTTz4Cp8E8IADR1WhpHKJaGxb8dIrV4HK/qmpxc+Vkq4wRhtdrDoCb3fVWd
 eE1cWvVTrFygbtcE0MCdzmR3KIi5RukF0RxRgKUZA8dmMhZYbJP9NFn9hEQ5OLtGiaso
 5wIuayhJ0sYhtxd6ScWKbzmKxY6NeJF6e1lRl6+/40C0Qzss0StEkMHYvXTEdGNOxh9G
 0mnA==
X-Gm-Message-State: AC+VfDxHX2U7AS4fK6PUxR3vF+MDwrYd+axhMCX/3kItncOy390Puwjl
 Vgp/kK3uT30BlMIq7ZalhWRdg7GGmfQ=
X-Google-Smtp-Source: ACHHUZ5EeqQ/qYji1q2KXxnYRHLAzOO8ZEbBash7rVT/BkR6+ZZ7uELRo/ZGeVJ3mxzhXSuiuOX/Vg==
X-Received: by 2002:ac2:510b:0:b0:4dc:807a:d144 with SMTP id
 q11-20020ac2510b000000b004dc807ad144mr2908319lfb.39.1686220960744; 
 Thu, 08 Jun 2023 03:42:40 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:40 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 15/33] target/mips: Add emulation of MXU D32ADD instruction
Date: Thu,  8 Jun 2023 13:42:04 +0300
Message-Id: <20230608104222.1520143-16-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x135.google.com
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

The instruction adds/subtracts two 32-bit values in XRb and XRc.
Placing results in XRa and XRd and updates carry bits for each
path in the MXU control register.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 64 +++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 5596d86234..03be624d86 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -378,6 +378,7 @@ enum {
     OPC_MXU__POOL09  = 0x15,
     OPC_MXU__POOL10  = 0x16,
     OPC_MXU__POOL11  = 0x17,
+    OPC_MXU_D32ADD   = 0x18,
     OPC_MXU_S8LDD    = 0x22,
     OPC_MXU__POOL16  = 0x27,
     OPC_MXU__POOL17  = 0x28,
@@ -2249,6 +2250,66 @@ static void gen_mxu_q16add(DisasContext *ctx)
     tcg_gen_or_tl(mxu_gpr[XRd - 1], t0, t1);
 }
 
+/*
+ * D32ADD XRa, XRb, XRc, XRd, aptn2 - Double
+ * 32 bit pattern addition/subtraction.
+ */
+static void gen_mxu_d32add(DisasContext *ctx)
+{
+    uint32_t aptn2, pad, XRc, XRb, XRa, XRd;
+
+    aptn2 = extract32(ctx->opcode, 24, 2);
+    pad   = extract32(ctx->opcode, 22, 2);
+    XRd   = extract32(ctx->opcode, 18, 4);
+    XRc   = extract32(ctx->opcode, 14, 4);
+    XRb   = extract32(ctx->opcode, 10, 4);
+    XRa   = extract32(ctx->opcode,  6, 4);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+    TCGv carry = tcg_temp_new();
+    TCGv cr = tcg_temp_new();
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0 && XRd == 0)) {
+        /* destinations are zero register -> do nothing */
+    } else {
+        /* common case */
+        gen_load_mxu_gpr(t0, XRb);
+        gen_load_mxu_gpr(t1, XRc);
+        gen_load_mxu_cr(cr);
+        if (XRa != 0) {
+            if (aptn2 & 2) {
+                tcg_gen_sub_i32(t2, t0, t1);
+                tcg_gen_setcond_tl(TCG_COND_GTU, carry, t0, t1);
+            } else {
+                tcg_gen_add_i32(t2, t0, t1);
+                tcg_gen_setcond_tl(TCG_COND_GTU, carry, t0, t2);
+            }
+            tcg_gen_andi_tl(cr, cr, 0x7fffffff);
+            tcg_gen_shli_tl(carry, carry, 31);
+            tcg_gen_or_tl(cr, cr, carry);
+            gen_store_mxu_gpr(t2, XRa);
+        }
+        if (XRd != 0) {
+            if (aptn2 & 1) {
+                tcg_gen_sub_i32(t2, t0, t1);
+                tcg_gen_setcond_tl(TCG_COND_GTU, carry, t0, t1);
+            } else {
+                tcg_gen_add_i32(t2, t0, t1);
+                tcg_gen_setcond_tl(TCG_COND_GTU, carry, t0, t2);
+            }
+            tcg_gen_andi_tl(cr, cr, 0xbfffffff);
+            tcg_gen_shli_tl(carry, carry, 30);
+            tcg_gen_or_tl(cr, cr, carry);
+            gen_store_mxu_gpr(t2, XRd);
+        }
+        gen_store_mxu_cr(cr);
+    }
+}
+
 /*
  *                 MXU instruction category: Miscellaneous
  *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -3033,6 +3094,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU__POOL11:
             decode_opc_mxu__pool11(ctx);
             break;
+        case OPC_MXU_D32ADD:
+            gen_mxu_d32add(ctx);
+            break;
         case OPC_MXU_S8LDD:
             gen_mxu_s8ldd(ctx);
             break;
-- 
2.40.0


