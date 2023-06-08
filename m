Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14750728110
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:19:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWd-0003NY-FH; Thu, 08 Jun 2023 09:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6B-0002Hq-Lx
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:35 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D69-0006Ts-VA
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:35 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b1ba018d94so4020111fa.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220951; x=1688812951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9QhP8VU7XovoHStl7HCwRvoadeJ/T5l3srW6hsNs04=;
 b=EGnc8lk9liEcvpgNrghicpMBWVl84qPpoqQSmNfJgyCzf32TT/TQ1VwYo3YvT4j8EB
 +ZYYW/sDTzVLZNVFw+r1oNha+Z+fI/2oBXHfmEXqdzXn3rURh/h+fc9JnQi2obmymzQm
 YFyUao2nCS+JUEu8lsa4XTGmXP6hRpPZpWclB9BAwNQP5gRhCxm/FJC9W7RRRZQucKa8
 NCUwlgP+PygCbLumSEMOKx2L0XtIEC5Xd6BynjutZJextWoOfO5pQwSc1ilGcs6aWbXs
 FhW5TcugQUfczAC8vMsKYEFAGZnAhokF5qbFKqqvs5iZCvtuejX+ZJP6qU/FdPlBu2Fr
 bC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220951; x=1688812951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T9QhP8VU7XovoHStl7HCwRvoadeJ/T5l3srW6hsNs04=;
 b=F7uzYpXcI+hsc5zonVATlrkI5xA0gPmxkfvjjCf9/R2mPtnK8KlewlejUQJf00q+rz
 DNhfeq0zcjOHGyIFgaLLgJBTO95C9PJCR0lcrozy50QyplyrjtjtEasPh08z4E4Qkel9
 D+nCxYd/NZyjAPfaixZQBi/ozmOcpZYPe+AevXItU7msdduSoqzqkY0A8zv/VKWnvVrA
 mHNW5SVltLZ7pWwmo11xuNK4opCZ0p77NVbmLEAeCiZB4/9IlIEY5zXJsZOO4To6bLVY
 GOgvPHaquPLvw+kvvwJzdvZGp6tuwzJGc1QwudhgXxhpYxMbdGB1mAsVVR8lX/2l9QIA
 H4IA==
X-Gm-Message-State: AC+VfDzHwmB1dVqfT6UVOR+Vy9a4tIJLbRgkCrHaud0SvRrh4ddBNZcL
 M5CaFnR9yTIxeB0uunTYtuyTUu8NC1U=
X-Google-Smtp-Source: ACHHUZ6iK2kwSfbfIVcRy5g3legX8DqLlC1NTOlWa0A7hRI9Zs4Heq4gnwZqJrubUxj1ayfKQWeAAg==
X-Received: by 2002:a2e:7c01:0:b0:2b1:c5c5:192c with SMTP id
 x1-20020a2e7c01000000b002b1c5c5192cmr3142801ljc.44.1686220951021; 
 Thu, 08 Jun 2023 03:42:31 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:30 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 06/33] target/mips: fix MXU D16MAX D16MIN Q8MAX Q8MIN
 instructions
Date: Thu,  8 Jun 2023 13:41:55 +0300
Message-Id: <20230608104222.1520143-7-lis8215@gmail.com>
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

These instructions were designed that they overwrite source
register during partial storing of result.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index b7bdc07dd7..984d826c36 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -1243,13 +1243,14 @@ static void gen_mxu_D16MAX_D16MIN(DisasContext *ctx)
         /* ...and do half-word-wise max/min with one operand 0 */
         TCGv_i32 t0 = tcg_temp_new();
         TCGv_i32 t1 = tcg_constant_i32(0);
+        TCGv_i32 t2 = tcg_temp_new();
 
         /* the left half-word first */
         tcg_gen_andi_i32(t0, mxu_gpr[XRx - 1], 0xFFFF0000);
         if (opc == OPC_MXU_D16MAX) {
-            tcg_gen_smax_i32(mxu_gpr[XRa - 1], t0, t1);
+            tcg_gen_smax_i32(t2, t0, t1);
         } else {
-            tcg_gen_smin_i32(mxu_gpr[XRa - 1], t0, t1);
+            tcg_gen_smin_i32(t2, t0, t1);
         }
 
         /* the right half-word */
@@ -1265,7 +1266,7 @@ static void gen_mxu_D16MAX_D16MIN(DisasContext *ctx)
         /* return resulting half-words to its original position */
         tcg_gen_shri_i32(t0, t0, 16);
         /* finally update the destination */
-        tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+        tcg_gen_or_i32(mxu_gpr[XRa - 1], t2, t0);
     } else if (unlikely(XRb == XRc)) {
         /* both operands same -> just set destination to one of them */
         tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
@@ -1273,14 +1274,15 @@ static void gen_mxu_D16MAX_D16MIN(DisasContext *ctx)
         /* the most general case */
         TCGv_i32 t0 = tcg_temp_new();
         TCGv_i32 t1 = tcg_temp_new();
+        TCGv_i32 t2 = tcg_temp_new();
 
         /* the left half-word first */
         tcg_gen_andi_i32(t0, mxu_gpr[XRb - 1], 0xFFFF0000);
         tcg_gen_andi_i32(t1, mxu_gpr[XRc - 1], 0xFFFF0000);
         if (opc == OPC_MXU_D16MAX) {
-            tcg_gen_smax_i32(mxu_gpr[XRa - 1], t0, t1);
+            tcg_gen_smax_i32(t2, t0, t1);
         } else {
-            tcg_gen_smin_i32(mxu_gpr[XRa - 1], t0, t1);
+            tcg_gen_smin_i32(t2, t0, t1);
         }
 
         /* the right half-word */
@@ -1298,7 +1300,7 @@ static void gen_mxu_D16MAX_D16MIN(DisasContext *ctx)
         /* return resulting half-words to its original position */
         tcg_gen_shri_i32(t0, t0, 16);
         /* finally update the destination */
-        tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+        tcg_gen_or_i32(mxu_gpr[XRa - 1], t2, t0);
     }
 }
 
@@ -1334,14 +1336,15 @@ static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
         /* ...and do byte-wise max/min with one operand 0 */
         TCGv_i32 t0 = tcg_temp_new();
         TCGv_i32 t1 = tcg_constant_i32(0);
+        TCGv_i32 t2 = tcg_temp_new();
         int32_t i;
 
         /* the leftmost byte (byte 3) first */
         tcg_gen_andi_i32(t0, mxu_gpr[XRx - 1], 0xFF000000);
         if (opc == OPC_MXU_Q8MAX) {
-            tcg_gen_smax_i32(mxu_gpr[XRa - 1], t0, t1);
+            tcg_gen_smax_i32(t2, t0, t1);
         } else {
-            tcg_gen_smin_i32(mxu_gpr[XRa - 1], t0, t1);
+            tcg_gen_smin_i32(t2, t0, t1);
         }
 
         /* bytes 2, 1, 0 */
@@ -1359,8 +1362,9 @@ static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
             /* return resulting byte to its original position */
             tcg_gen_shri_i32(t0, t0, 8 * (3 - i));
             /* finally update the destination */
-            tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+            tcg_gen_or_i32(t2, t2, t0);
         }
+        gen_store_mxu_gpr(t2, XRa);
     } else if (unlikely(XRb == XRc)) {
         /* both operands same -> just set destination to one of them */
         tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
@@ -1368,15 +1372,16 @@ static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
         /* the most general case */
         TCGv_i32 t0 = tcg_temp_new();
         TCGv_i32 t1 = tcg_temp_new();
+        TCGv_i32 t2 = tcg_temp_new();
         int32_t i;
 
         /* the leftmost bytes (bytes 3) first */
         tcg_gen_andi_i32(t0, mxu_gpr[XRb - 1], 0xFF000000);
         tcg_gen_andi_i32(t1, mxu_gpr[XRc - 1], 0xFF000000);
         if (opc == OPC_MXU_Q8MAX) {
-            tcg_gen_smax_i32(mxu_gpr[XRa - 1], t0, t1);
+            tcg_gen_smax_i32(t2, t0, t1);
         } else {
-            tcg_gen_smin_i32(mxu_gpr[XRa - 1], t0, t1);
+            tcg_gen_smin_i32(t2, t0, t1);
         }
 
         /* bytes 2, 1, 0 */
@@ -1396,8 +1401,9 @@ static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
             /* return resulting byte to its original position */
             tcg_gen_shri_i32(t0, t0, 8 * (3 - i));
             /* finally update the destination */
-            tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+            tcg_gen_or_i32(t2, t2, t0);
         }
+        gen_store_mxu_gpr(t2, XRa);
     }
 }
 
-- 
2.40.0


