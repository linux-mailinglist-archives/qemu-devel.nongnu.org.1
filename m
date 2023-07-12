Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D5974FF0F
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 08:09:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJT2B-0000ea-HY; Wed, 12 Jul 2023 02:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJT1c-0000cd-47
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 02:08:32 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJT1Y-0007bv-RS
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 02:08:31 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fb761efa7aso10318849e87.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 23:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689142105; x=1691734105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQLSaBAsWK+XKeQRc/Qvxp+d8zerTRXpd0IZR5vliPg=;
 b=IRkLaBZoU/D/qMYeJVPCMXME+EpdQCqcRivPMLnXtedCqePdlpKJssK9/eXBVruD+x
 af8Sli1er/+oxZqwlVGRQa0lVBWTwu4yXk7l6Dz8HikpMC2OFFV3PFxcK6iH3EcKSL+f
 hMK7F8llfhKHxl0MpZyuQv5Z+UbxtQv37fh8pnAw2XxapHE7ZvXMG9Fl6Yv0ERrzAT/m
 CLicv0L33V+begVNZfy+VaZGvxXq/6cuEPsU7EEn2bCVBDkPIFK1WGUFHNBRR6wfsGJW
 c4Nip1i/AanLdJeD7YSCPFe3zyg6GSbeWSoE5F4QFrXEyqnxvR8ABSamJhIroB9cmLFU
 gKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689142105; x=1691734105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fQLSaBAsWK+XKeQRc/Qvxp+d8zerTRXpd0IZR5vliPg=;
 b=cjFK4P/SDwL62dAnxhJuBtZyx6qvh+3vZciQJyIEqXlev3feWk43YluPVFEsOJITkE
 B5iKUY9A5uVb7BaYOUva4kbr1QD2S6zGtrFqjsZwP5QdqdiWnB+hUKE0mPTns5Rq1SS2
 19BIQblD4ILtXyYcDjMzniZgogjRM0+CoG6gpJ3/PJI/eKbYLLnQ9ixRskhoehRydYHq
 QimJ6pXM7+mnL3X5aNuXzHGYYfP5EncxMT2NAZCOLdU3WW6EJlSLB2hOKfNzjrNE/Yy2
 gd6wqo41lP7nsUE0UiSd9ba6ycEfhR1/5x+B8slLxCBfbGD5JxvHNWhti6YTfZHKVw25
 HV+w==
X-Gm-Message-State: ABy/qLa8XX6E41EeIsL/9sES+I7zKVyTajW3LHf7Kzuodz7WyV4xvdlC
 SQitteXvHngNsLdhoFfB0GFU8/oiEGvUo5yEhVk=
X-Google-Smtp-Source: APBJJlHbUSjbY8j8oVgiLIH8I5eHe21jx4l3yevRuVKiYNu2MUzk8NLIjGewndyo+mFqqZQ6TYgM3g==
X-Received: by 2002:a05:6512:33ce:b0:4f8:5600:9e5e with SMTP id
 d14-20020a05651233ce00b004f856009e5emr17757744lfg.47.1689142105559; 
 Tue, 11 Jul 2023 23:08:25 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 l22-20020a7bc456000000b003fbb5142c4bsm14585383wmi.18.2023.07.11.23.08.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 23:08:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Craig Janeczek <jancraig@amazon.com>
Subject: [PATCH-for-8.1 3/3] target/mips/mxu: Avoid overrun in gen_mxu_q8adde()
Date: Wed, 12 Jul 2023 08:08:06 +0200
Message-Id: <20230712060806.82323-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230712060806.82323-1-philmd@linaro.org>
References: <20230712060806.82323-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

Coverity reports a potential overruns (CID 1517770):

  Overrunning array "mxu_gpr" of 15 8-byte elements at
  element index 4294967295 (byte offset 34359738367)
  using index "XRb - 1U" (which evaluates to 4294967295).

Add a gen_extract_mxu_gpr() helper similar to
gen_load_mxu_gpr() to safely extract MXU registers.

Fixes: eb79951ab6 ("target/mips/mxu: Add Q8ADDE ... insns")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


