Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CA3761C84
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:59:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJVJ-0003Of-OJ; Tue, 25 Jul 2023 10:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJVH-0003HF-I1
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:59:11 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJVE-0001Cs-3s
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:59:11 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4fdd31bf179so8695067e87.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690297146; x=1690901946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qSioxDMzRpvFdzVJXhUN5omfX+PmBMAzJgemy6xBhaw=;
 b=xpX1GZZ9V+sqeNY+hafzPXiByHa8UJTrgdvqxOxcdEzPPIDWDDKGWmIrD5rLzUnSOn
 I1zHheeFzdfqqADapYCYvGhJ+hgYsmf1w4QE1aRqyv50aEjEaXG+4Jvofi0xD6BhBBen
 DstFHBunl+A7uiHc5Qj22Eu81Fi6o3SpqJEY0t8JthMHT+7pVjvGKbJvuG15RNS6xueo
 W/OpvOlAbqm8uzAPLHg63oUqmKGAkR0zmdaZz3VTFI8n2R2eFUoD6X1rgOwNY0/G0o/i
 Dfhkdb6dOkO/s/VZxi+gVhjHHxQ5GNWUENmmRbSbAtn7/0d+MpQvswWwhJf8vmXWC2fP
 nicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690297146; x=1690901946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qSioxDMzRpvFdzVJXhUN5omfX+PmBMAzJgemy6xBhaw=;
 b=YV/YQF3ywhIYliPq2eIS/9Fz6QHCGU+oRAulQb8m7+SzlvOnTbcwR/XwLPBTxNuxnE
 fuLm0NNz9zGZYzlX27JUWX7p4G4K5gqY6Gc1VW9QqqE8vepsHnQrjpLy2WJzP/3q0Zoe
 pELOtYxj36aKMCgjs99EMg+jvTam+B/jTHpCqKlNLt683E3gGfBTye04kb7RgL+fsMTs
 /TBQmdxLglxRCoGnwv1qzsI35Gu08o2icsvkpMB70cRTlSkN5aI43yomgTaEEtt/9OgJ
 FVkZfzTuZQWxmcT5lU4yQoNLKxj+YAq16clUt6HO3wT23XMNwstb4WnAyRCiBKtlXGMg
 XlJA==
X-Gm-Message-State: ABy/qLaXZpcOsnaI0a+pna2bR3aoATqjzBVP9YjJCVcIeArVtdQBjEuA
 r29FZB15TiqnVF2yPTFVB56O0EKoTgXeOgulPfA=
X-Google-Smtp-Source: APBJJlGA1o4V/IEKdWRS/MuqhF6hezUEMKuCsvVnmNv33bCejXDzZqVN30AQ9p7uP45K6Tlw5wXugw==
X-Received: by 2002:a05:6512:401e:b0:4fb:7447:e71a with SMTP id
 br30-20020a056512401e00b004fb7447e71amr8173027lfb.63.1690297146152; 
 Tue, 25 Jul 2023 07:59:06 -0700 (PDT)
Received: from localhost.localdomain ([176.187.203.142])
 by smtp.gmail.com with ESMTPSA id
 w9-20020adfd4c9000000b0031423a8f4f7sm16821042wrk.56.2023.07.25.07.59.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Jul 2023 07:59:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/10] target/mips/mxu: Avoid overrun in gen_mxu_q8adde()
Date: Tue, 25 Jul 2023 16:58:25 +0200
Message-Id: <20230725145829.37782-7-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230725145829.37782-1-philmd@linaro.org>
References: <20230725145829.37782-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Coverity reports a potential overruns (CID 1517770):

  Overrunning array "mxu_gpr" of 15 8-byte elements at
  element index 4294967295 (byte offset 34359738367)
  using index "XRb - 1U" (which evaluates to 4294967295).

Add a gen_extract_mxu_gpr() helper similar to
gen_load_mxu_gpr() to safely extract MXU registers.

Fixes: eb79951ab6 ("target/mips/mxu: Add Q8ADDE ... insns")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230712060806.82323-4-philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 520747a597..e662acd5df 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -644,6 +644,16 @@ static inline void gen_store_mxu_gpr(TCGv t, unsigned int reg)
     }
 }
 
+static inline void gen_extract_mxu_gpr(TCGv t, unsigned int reg,
+                                       unsigned int ofs, unsigned int len)
+{
+    if (reg == 0) {
+        tcg_gen_movi_tl(t, 0);
+    } else if (reg <= 15) {
+        tcg_gen_extract_tl(t, mxu_gpr[reg - 1], ofs, len);
+    }
+}
+
 /* MXU control register moves. */
 static inline void gen_load_mxu_cr(TCGv t)
 {
@@ -3004,10 +3014,10 @@ static void gen_mxu_q8adde(DisasContext *ctx, bool accumulate)
         TCGv t5 = tcg_temp_new();
 
         if (XRa != 0) {
-            tcg_gen_extract_tl(t0, mxu_gpr[XRb - 1], 16, 8);
-            tcg_gen_extract_tl(t1, mxu_gpr[XRc - 1], 16, 8);
-            tcg_gen_extract_tl(t2, mxu_gpr[XRb - 1], 24, 8);
-            tcg_gen_extract_tl(t3, mxu_gpr[XRc - 1], 24, 8);
+            gen_extract_mxu_gpr(t0, XRb, 16, 8);
+            gen_extract_mxu_gpr(t1, XRc, 16, 8);
+            gen_extract_mxu_gpr(t2, XRb, 24, 8);
+            gen_extract_mxu_gpr(t3, XRc, 24, 8);
             if (aptn2 & 2) {
                 tcg_gen_sub_tl(t0, t0, t1);
                 tcg_gen_sub_tl(t2, t2, t3);
@@ -3027,10 +3037,10 @@ static void gen_mxu_q8adde(DisasContext *ctx, bool accumulate)
             tcg_gen_or_tl(t4, t2, t0);
         }
         if (XRd != 0) {
-            tcg_gen_extract_tl(t0, mxu_gpr[XRb - 1], 0, 8);
-            tcg_gen_extract_tl(t1, mxu_gpr[XRc - 1], 0, 8);
-            tcg_gen_extract_tl(t2, mxu_gpr[XRb - 1], 8, 8);
-            tcg_gen_extract_tl(t3, mxu_gpr[XRc - 1], 8, 8);
+            gen_extract_mxu_gpr(t0, XRb, 0, 8);
+            gen_extract_mxu_gpr(t1, XRc, 0, 8);
+            gen_extract_mxu_gpr(t2, XRb, 8, 8);
+            gen_extract_mxu_gpr(t3, XRc, 8, 8);
             if (aptn2 & 1) {
                 tcg_gen_sub_tl(t0, t0, t1);
                 tcg_gen_sub_tl(t2, t2, t3);
-- 
2.38.1


