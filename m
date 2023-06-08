Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4A3728131
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:22:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FXC-00048N-C4; Thu, 08 Jun 2023 09:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6M-0002Ln-ME
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:46 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6L-0006XP-3x
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:46 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4f654d713c0so190507e87.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220963; x=1688812963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7HdtqCpfs4XvWuoJWtomEMbaUt+zWKnppoDSDVHuEQE=;
 b=OxdZaEbfrrzTIkLZzgBVme0Naw3ocsiQWJLXQsxz6PRL8kcLo6JnJ7BI45rOqJwPlw
 Yj4fT5seJ48193xUlxpgJ6fyd8bWwkz0FNuPzQPXFT5yvPNB6NBmHNp9++OnVQJjARBo
 ZYldRczc4/iI2gFukxYDj4PKjYCewVa/yylALiJ5lylAtwHV9chpgPUPrSPOi6UYVMCp
 fmKC3ozCzyFn3KFQj4H3W7/9uzAB7NfWdrWguLHCvW6YpvTXYBvl7AlNPZO8tdkx58lq
 1zRuvdJ4Um1DrYnVB7jsi713OLevOQkeW/xFRC67F0zQxplUBwld4COI3rLQRF3r9FdR
 dCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220963; x=1688812963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7HdtqCpfs4XvWuoJWtomEMbaUt+zWKnppoDSDVHuEQE=;
 b=BuOmpYfu2qIVlO3zJbZJVwOouljTXMzvchjRX5m4txR9jyLxsGQ2Ss3yQxVDJPjjbE
 bbOCwDHliSKHQ9ATvoKkHPW0WeDOPqirYq42sOIccX75ldK5xvNTd8KavjqeV3EoQ58Y
 mWYYbx2KaJUDx1M8nEJApfYFCBaEe1Hr6IqUeyG+ml69S3xcAjjfVwW6PyYj6/uTJ8nw
 pGNkOjxzTL6tTqXJGy/r4Avd1GiJZg2u93rJwTbUjLhE9EE7OkumTSqqH/SsZ9AAuYuN
 7UAQ/vomU7GibRGm/Zw5mJkdbMSK+dqMe/NJjZiIKim+lm2TSebvAMnD5+r1TTkORzi0
 Ze6Q==
X-Gm-Message-State: AC+VfDwOTD2zYWsrEJyhfdG5FO6FU+l7LdhjMul9R/pWwZLG+/1WoWQX
 wfvx17oOxt7WFdszI6R6474/ZPyeW1Y=
X-Google-Smtp-Source: ACHHUZ74/uVG637g0OoUOv6385ef6laXZOoY82VlE2LDyqYsB2U02bEV1MR8KrASSF8wY7yzOrCkrQ==
X-Received: by 2002:ac2:5ecf:0:b0:4e8:c81b:1a11 with SMTP id
 d15-20020ac25ecf000000b004e8c81b1a11mr3429196lfq.49.1686220963067; 
 Thu, 08 Jun 2023 03:42:43 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:42 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 17/33] target/mips: Add emulation of MXU D32ADDC instruction
Date: Thu,  8 Jun 2023 13:42:06 +0300
Message-Id: <20230608104222.1520143-18-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x12c.google.com
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

The instruction adds two 32-bit values with respect
to corresponding carry flags in MXU_CR.
XRa += XRb + LeftCarry flag;
XRd += XRc + RightCarry flag;
Suddenly, it doesn't modify carry flags as a result of addition.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 39 +++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 56c894f4c7..2b677407d5 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -270,7 +270,7 @@
  *          │                               13..10
  *          ├─ 010111 ─ OPC_MXU__POOL11 ─┬─ 0000 ─ OPC_MXU_S32SDIV
  *          │                            └─ 0001 ─ OPC_MXU_S32SDIVR
- *          ├─ 011000 ─ OPC_MXU_D32ADD
+ *          ├─ 011000 ─ OPC_MXU_D32ADD  (catches D32ADDC too)
  *          │                               23..22
  *   MXU    ├─ 011001 ─ OPC_MXU__POOL12 ─┬─ 00 ─ OPC_MXU_D32ACC
  * opcodes ─┤                            ├─ 01 ─ OPC_MXU_D32ACCM
@@ -2262,14 +2262,17 @@ static void gen_mxu_q16add(DisasContext *ctx)
 
 /*
  * D32ADD XRa, XRb, XRc, XRd, aptn2 - Double
- * 32 bit pattern addition/subtraction.
+ * 32 bit pattern addition/subtraction, set carry.
+ *
+ * D32ADDC XRa, XRb, XRc, XRd, aptn2 - Double
+ * 32 bit pattern addition/subtraction with carry.
  */
 static void gen_mxu_d32add(DisasContext *ctx)
 {
-    uint32_t aptn2, pad, XRc, XRb, XRa, XRd;
+    uint32_t aptn2, addc, XRc, XRb, XRa, XRd;
 
     aptn2 = extract32(ctx->opcode, 24, 2);
-    pad   = extract32(ctx->opcode, 22, 2);
+    addc  = extract32(ctx->opcode, 22, 2);
     XRd   = extract32(ctx->opcode, 18, 4);
     XRc   = extract32(ctx->opcode, 14, 4);
     XRb   = extract32(ctx->opcode, 10, 4);
@@ -2278,15 +2281,37 @@ static void gen_mxu_d32add(DisasContext *ctx)
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
     TCGv t2 = tcg_temp_new();
-    TCGv carry = tcg_temp_new();
     TCGv cr = tcg_temp_new();
 
-    if (unlikely(pad != 0)) {
-        /* opcode padding incorrect -> do nothing */
+    if (unlikely(addc > 1)) {
+        /* opcode incorrect -> do nothing */
+    } else if (addc == 1) {
+        if (unlikely(XRa == 0 && XRd == 0)) {
+            /* destinations are zero register -> do nothing */
+        } else {
+            /* FIXME ??? What if XRa == XRd ??? */
+            /* aptn2 is unused here */
+            gen_load_mxu_gpr(t0, XRb);
+            gen_load_mxu_gpr(t1, XRc);
+            gen_load_mxu_cr(cr);
+            if (XRa != 0) {
+                tcg_gen_extract_tl(t2, cr, 31, 1);
+                tcg_gen_add_tl(t0, t0, t2);
+                tcg_gen_add_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+            }
+            if (XRd != 0) {
+                tcg_gen_extract_tl(t2, cr, 30, 1);
+                tcg_gen_add_tl(t1, t1, t2);
+                tcg_gen_add_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t1);
+            }
+        }
     } else if (unlikely(XRa == 0 && XRd == 0)) {
         /* destinations are zero register -> do nothing */
     } else {
         /* common case */
+        /* FIXME ??? What if XRa == XRd ??? */
+        TCGv carry = tcg_temp_new();
+
         gen_load_mxu_gpr(t0, XRb);
         gen_load_mxu_gpr(t1, XRc);
         gen_load_mxu_cr(cr);
-- 
2.40.0


