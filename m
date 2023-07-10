Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0992374E100
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:27:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzLa-0003hb-20; Mon, 10 Jul 2023 18:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLX-0003dw-L3
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:07 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLV-0001ln-SO
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:07 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3159d5e409dso857574f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028024; x=1691620024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DGaYnatoGOgdlFc+Y429tF9PlhmF+pcnR+hTd6tWiJE=;
 b=IPPGKaxUdEx/9EvZ3MVe7n16jVAQ5o7liVuSL5bCniDyheMU+FzTdoFmpp74hDXgpf
 T+9x3OO4H+eIoLQI5NcfjkgLE5vPcAHUSWvio4OfAJX/EvwNj7oBE57WSvhfw6zmd+qI
 l+DOnHSIFye4vY1G5Yt4cjrEfEN2FghAy1+afHPk4dt0tMrlJrew20HNsKypcIe6Zogb
 Yu2cpOGFwcWNjacmvo5kTdUKFiITHPdSCp82GXVu08yj97xN6jQIVxvS1sr+QUxEXpOB
 jHb4I4YGnOPjgp3Ah7bc/FyCnAdMAo4Ti8oHpSSSmZZGT+4qENWz9hcUTub7KkO2eeNG
 8rWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028024; x=1691620024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DGaYnatoGOgdlFc+Y429tF9PlhmF+pcnR+hTd6tWiJE=;
 b=fXT5ZZDVWB3aZXbxyoaRSbfgK24DTpFUZ0g+GU//ykGLGDAyVeBN0htju+dFuOI8Lt
 tUfUPSeV52jIhk8YC84TrondTL/WquQQzFGUGyb9gcxQQWGaeau8UsmZZjJSJ18kNRz7
 nvuBryjVfyxBGhUGu3pyG+QfEcd6/XzlUi3JgbhUWF0Tpa/zu8/+l1bfZYISoeazF1KK
 nLjMyOLIu50LPOSxWi0U9qIvDH5tN002nt+8act3pQ6JnlI3gnwwMjRBrvVhRpTxfc5E
 7qdvWTjT3T87fjUK04sFYdAQtCv/+uZzIhk0UzznI90KNIrpbiO7JUtbs2cKnHs07tjW
 2OmQ==
X-Gm-Message-State: ABy/qLb0Me1xPnnQ6rE393ZbxBm8cTc55yjW4Dz6pOCWnYsC7lLCmeLX
 SD25YOG68VhdcdTk5eUHGZN3aNDx8bv0iHWgitx3Cg==
X-Google-Smtp-Source: APBJJlHpQwo99qH6ARFgZ67qzH5QKhPYdrx6ZAdrgr5cUQUfcAWzc4CqI9OxUEvz+fx1rJ6yotQGkA==
X-Received: by 2002:adf:f592:0:b0:314:1d6:8aa7 with SMTP id
 f18-20020adff592000000b0031401d68aa7mr13084622wro.29.1689028024400; 
 Mon, 10 Jul 2023 15:27:04 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 h7-20020a5d5487000000b0030ae901bc54sm520740wrv.62.2023.07.10.15.27.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:27:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 09/44] target/mips/mxu: Fix D16MAX D16MIN Q8MAX Q8MIN
 instructions
Date: Tue, 11 Jul 2023 00:25:36 +0200
Message-Id: <20230710222611.50978-10-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

These instructions were designed that they overwrite source
register during partial storing of result.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-7-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 6d25562710..e63b4754be 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -1241,13 +1241,14 @@ static void gen_mxu_D16MAX_D16MIN(DisasContext *ctx)
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
@@ -1263,7 +1264,7 @@ static void gen_mxu_D16MAX_D16MIN(DisasContext *ctx)
         /* return resulting half-words to its original position */
         tcg_gen_shri_i32(t0, t0, 16);
         /* finally update the destination */
-        tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+        tcg_gen_or_i32(mxu_gpr[XRa - 1], t2, t0);
     } else if (unlikely(XRb == XRc)) {
         /* both operands same -> just set destination to one of them */
         tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
@@ -1271,14 +1272,15 @@ static void gen_mxu_D16MAX_D16MIN(DisasContext *ctx)
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
@@ -1296,7 +1298,7 @@ static void gen_mxu_D16MAX_D16MIN(DisasContext *ctx)
         /* return resulting half-words to its original position */
         tcg_gen_shri_i32(t0, t0, 16);
         /* finally update the destination */
-        tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+        tcg_gen_or_i32(mxu_gpr[XRa - 1], t2, t0);
     }
 }
 
@@ -1332,14 +1334,15 @@ static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
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
@@ -1357,8 +1360,9 @@ static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
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
@@ -1366,15 +1370,16 @@ static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
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
@@ -1394,8 +1399,9 @@ static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
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
2.38.1


