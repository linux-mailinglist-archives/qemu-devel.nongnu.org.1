Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B15D7D5943
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:01:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKlB-0000jO-1H; Tue, 24 Oct 2023 13:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKl2-0000dl-1S
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:59:56 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKkz-0002tK-G3
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:59:55 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5384975e34cso7439328a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698166791; x=1698771591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ncCgWtfinnqqDtx4stcx4MicUxQ5sAnO3Rr4b4ddO70=;
 b=ONyfJiFdZGFla/QFuvXCprU2Wr1mgLE/v6YKlF7V40h5kctIkE5uGyJSiIjXm0AT0c
 QLq5gmu2T1UHLhkTRz9+Ai+7PEGunWh37rmPMCkFPhNnmfE81XUNK7T7A1ITXt9zDsL4
 QwICFcJQ1+AvR4wPmkkc+dHR5kVT7+qv51JzRJ4zQUsxKy3dgSFuh5R1ZN6edXZfLFqW
 DzY/jMyetEIKCuq2oiiCO3LfkXLf2a0e/8T2mcsE9xPHdA1uP1rCz+IObLew/Sc20ice
 JaMjYpbMGEU2pZTAJjGJDdjrfV4cp1PcCLmOsYtYR6DhS0DApEGOxSJueX3iGK3uXme2
 ZnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698166791; x=1698771591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ncCgWtfinnqqDtx4stcx4MicUxQ5sAnO3Rr4b4ddO70=;
 b=C2Ir96IZu1dS1DhL2VOSb29TBXxc7T63rjIqq/NYtE44BnTbEnX0d/ZSFNch0Mg3CA
 GDDJj92zxGyClePUNhF9eqwrwYUk6wlf+IfCqm0X6CgpbLD38+nfBK8JtTZD4wUZDdDU
 KtJtMgI8xJ14d3etDIP0kHozY7tDxpvc+AHntGEpYx5H0KA2QmCxd5d87h5meH4YVK2D
 /xVxQGDZFcA/M/n4hvAEWOnWFiiJTzu8ewPyNNr3b46+s7HTg/bU02mAlwSrR3pUWL8J
 zp8T4Ie2hBbOGUfvS8GMuZebY5QNnbqD33CH5GKF0j7zU6pAHtF14Bk4jARoEssc515q
 A9Ng==
X-Gm-Message-State: AOJu0YwhOpDdhF6SRXJ1uVnVKqEBT3NmbkJ5pwjCKuwe+rFfTvOOv8tf
 aiJyrlQURH57TZ5SPNB9zR9bUFNzomAGrFALhkc=
X-Google-Smtp-Source: AGHT+IH1fzLuFtoANKzlYaKAQpS+D0ahKIRry+HZNm+0MGpLEBwkPZEkOwPbjPrL67QaqTUk1NnSZQ==
X-Received: by 2002:a17:907:1c93:b0:9bf:70ea:6926 with SMTP id
 nb19-20020a1709071c9300b009bf70ea6926mr10660594ejc.2.1698166791500; 
 Tue, 24 Oct 2023 09:59:51 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 gx13-20020a1709068a4d00b009ae6a6451fdsm8503502ejc.35.2023.10.24.09.59.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 09:59:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PATCH v2 8/9] target/mips: Use tcg_gen_ext16s_tl
Date: Tue, 24 Oct 2023 18:59:01 +0200
Message-ID: <20231024165903.40861-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024165903.40861-1-philmd@linaro.org>
References: <20231024165903.40861-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 54 ++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index c517258ac5..096a01e044 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -1014,10 +1014,10 @@ static void gen_mxu_d16mul(DisasContext *ctx, bool fractional,
      */
 
     gen_load_mxu_gpr(t1, XRb);
-    tcg_gen_sextract_tl(t0, t1, 0, 16);
+    tcg_gen_ext16s_tl(t0, t1);
     tcg_gen_sextract_tl(t1, t1, 16, 16);
     gen_load_mxu_gpr(t3, XRc);
-    tcg_gen_sextract_tl(t2, t3, 0, 16);
+    tcg_gen_ext16s_tl(t2, t3);
     tcg_gen_sextract_tl(t3, t3, 16, 16);
 
     switch (optn2) {
@@ -1113,11 +1113,11 @@ static void gen_mxu_d16mac(DisasContext *ctx, bool fractional,
     aptn2 = extract32(ctx->opcode, 24, 2);
 
     gen_load_mxu_gpr(t1, XRb);
-    tcg_gen_sextract_tl(t0, t1, 0, 16);
+    tcg_gen_ext16s_tl(t0, t1);
     tcg_gen_sextract_tl(t1, t1, 16, 16);
 
     gen_load_mxu_gpr(t3, XRc);
-    tcg_gen_sextract_tl(t2, t3, 0, 16);
+    tcg_gen_ext16s_tl(t2, t3);
     tcg_gen_sextract_tl(t3, t3, 16, 16);
 
     switch (optn2) {
@@ -1234,11 +1234,11 @@ static void gen_mxu_d16madl(DisasContext *ctx)
     aptn2 = extract32(ctx->opcode, 24, 2);
 
     gen_load_mxu_gpr(t1, XRb);
-    tcg_gen_sextract_tl(t0, t1,  0, 16);
+    tcg_gen_ext16s_tl(t0, t1);
     tcg_gen_sextract_tl(t1, t1, 16, 16);
 
     gen_load_mxu_gpr(t3, XRc);
-    tcg_gen_sextract_tl(t2, t3,  0, 16);
+    tcg_gen_ext16s_tl(t2, t3);
     tcg_gen_sextract_tl(t3, t3, 16, 16);
 
     switch (optn2) {
@@ -1323,15 +1323,15 @@ static void gen_mxu_s16mad(DisasContext *ctx)
         tcg_gen_sextract_tl(t1, t1, 16, 16);
         break;
     case MXU_OPTN2_LW: /* XRB.L*XRC.L */
-        tcg_gen_sextract_tl(t0, t0,  0, 16);
-        tcg_gen_sextract_tl(t1, t1,  0, 16);
+        tcg_gen_ext16s_tl(t0, t0);
+        tcg_gen_ext16s_tl(t1, t1);
         break;
     case MXU_OPTN2_HW: /* XRB.H*XRC.L */
         tcg_gen_sextract_tl(t0, t0, 16, 16);
-        tcg_gen_sextract_tl(t1, t1,  0, 16);
+        tcg_gen_ext16s_tl(t1, t1);
         break;
     case MXU_OPTN2_XW: /* XRB.L*XRC.H */
-        tcg_gen_sextract_tl(t0, t0,  0, 16);
+        tcg_gen_ext16s_tl(t0, t0);
         tcg_gen_sextract_tl(t1, t1, 16, 16);
         break;
     }
@@ -1998,9 +1998,9 @@ static void gen_mxu_q16sxx(DisasContext *ctx, bool right, bool arithmetic)
 
     if (arithmetic) {
         tcg_gen_sextract_tl(t1, t0, 16, 16);
-        tcg_gen_sextract_tl(t0, t0,  0, 16);
+        tcg_gen_ext16s_tl(t0, t0);
         tcg_gen_sextract_tl(t3, t2, 16, 16);
-        tcg_gen_sextract_tl(t2, t2,  0, 16);
+        tcg_gen_ext16s_tl(t2, t2);
     } else {
         tcg_gen_extract_tl(t1, t0, 16, 16);
         tcg_gen_extract_tl(t0, t0,  0, 16);
@@ -2066,9 +2066,9 @@ static void gen_mxu_q16sxxv(DisasContext *ctx, bool right, bool arithmetic)
 
     if (arithmetic) {
         tcg_gen_sextract_tl(t1, t0, 16, 16);
-        tcg_gen_sextract_tl(t0, t0,  0, 16);
+        tcg_gen_ext16s_tl(t0, t0);
         tcg_gen_sextract_tl(t3, t2, 16, 16);
-        tcg_gen_sextract_tl(t2, t2,  0, 16);
+        tcg_gen_ext16s_tl(t2, t2);
     } else {
         tcg_gen_extract_tl(t1, t0, 16, 16);
         tcg_gen_extract_tl(t0, t0,  0, 16);
@@ -2492,8 +2492,8 @@ static void gen_mxu_D16SLT(DisasContext *ctx)
         tcg_gen_sextract_tl(t1, t4, 16, 16);
         tcg_gen_setcond_tl(TCG_COND_LT, t0, t0, t1);
         tcg_gen_shli_tl(t2, t0, 16);
-        tcg_gen_sextract_tl(t0, t3,  0, 16);
-        tcg_gen_sextract_tl(t1, t4,  0, 16);
+        tcg_gen_ext16s_tl(t0, t3);
+        tcg_gen_ext16s_tl(t1, t4);
         tcg_gen_setcond_tl(TCG_COND_LT, t0, t0, t1);
         tcg_gen_or_tl(mxu_gpr[XRa - 1], t2, t0);
     }
@@ -2547,8 +2547,8 @@ static void gen_mxu_d16avg(DisasContext *ctx, bool round45)
         }
         tcg_gen_shli_tl(t2, t0, 15);
         tcg_gen_andi_tl(t2, t2, 0xffff0000);
-        tcg_gen_sextract_tl(t0, t3,  0, 16);
-        tcg_gen_sextract_tl(t1, t4,  0, 16);
+        tcg_gen_ext16s_tl(t0, t3);
+        tcg_gen_ext16s_tl(t1, t4);
         tcg_gen_add_tl(t0, t0, t1);
         if (round45) {
             tcg_gen_addi_tl(t0, t0, 1);
@@ -2844,9 +2844,9 @@ static void gen_mxu_D16CPS(DisasContext *ctx)
         gen_set_label(l_done_hi);
         tcg_gen_shli_i32(t1, t1, 16);
 
-        tcg_gen_sextract_tl(t0, mxu_gpr[XRc - 1],  0, 16);
+        tcg_gen_ext16s_tl(t0, mxu_gpr[XRc - 1]);
         tcg_gen_brcondi_tl(TCG_COND_GE, t0, 0, l_not_less_lo);
-        tcg_gen_sextract_tl(t0, mxu_gpr[XRb - 1],  0, 16);
+        tcg_gen_ext16s_tl(t0, mxu_gpr[XRb - 1]);
         tcg_gen_subfi_tl(t0, 0, t0);
         tcg_gen_br(l_done_lo);
 
@@ -3388,7 +3388,7 @@ static void gen_mxu_d16asum(DisasContext *ctx)
     gen_load_mxu_gpr(t3, XRc);
 
     if (XRa != 0) {
-        tcg_gen_sextract_tl(t0, t2,  0, 16);
+        tcg_gen_ext16s_tl(t0, t2);
         tcg_gen_sextract_tl(t1, t2, 16, 16);
         tcg_gen_add_tl(t0, t0, t1);
         if (aptn2 & 2) {
@@ -3399,7 +3399,7 @@ static void gen_mxu_d16asum(DisasContext *ctx)
     }
 
     if (XRd != 0) {
-        tcg_gen_sextract_tl(t0, t3,  0, 16);
+        tcg_gen_ext16s_tl(t0, t3);
         tcg_gen_sextract_tl(t1, t3, 16, 16);
         tcg_gen_add_tl(t0, t0, t1);
         if (aptn2 & 1) {
@@ -3840,8 +3840,7 @@ static void gen_mxu_Q16SAT(DisasContext *ctx)
             tcg_gen_movi_tl(t0, 255);
 
             gen_set_label(l_lo);
-            tcg_gen_shli_tl(t1, mxu_gpr[XRb - 1], 16);
-            tcg_gen_sari_tl(t1, t1, 16);
+            tcg_gen_ext16s_tl(t1, mxu_gpr[XRb - 1]);
             tcg_gen_brcondi_tl(TCG_COND_LT, t1, 0, l_less_lo);
             tcg_gen_brcondi_tl(TCG_COND_GT, t1, 255, l_greater_lo);
             tcg_gen_br(l_done);
@@ -3876,8 +3875,7 @@ static void gen_mxu_Q16SAT(DisasContext *ctx)
             tcg_gen_movi_tl(t0, 255);
 
             gen_set_label(l_lo);
-            tcg_gen_shli_tl(t1, mxu_gpr[XRc - 1], 16);
-            tcg_gen_sari_tl(t1, t1, 16);
+            tcg_gen_ext16s_tl(t1, mxu_gpr[XRc - 1]);
             tcg_gen_brcondi_tl(TCG_COND_LT, t1, 0, l_less_lo);
             tcg_gen_brcondi_tl(TCG_COND_GT, t1, 255, l_greater_lo);
             tcg_gen_br(l_done);
@@ -3942,7 +3940,7 @@ static void gen_mxu_q16scop(DisasContext *ctx)
     tcg_gen_movi_tl(t3, 0x00010000);
 
     gen_set_label(l_b_lo);
-    tcg_gen_sextract_tl(t2, t0, 0, 16);
+    tcg_gen_ext16s_tl(t2, t0);
     tcg_gen_brcondi_tl(TCG_COND_EQ, t2, 0, l_c_hi);
     tcg_gen_brcondi_tl(TCG_COND_LT, t2, 0, l_b_lo_lt);
     tcg_gen_ori_tl(t3, t3, 0x00000001);
@@ -3964,7 +3962,7 @@ static void gen_mxu_q16scop(DisasContext *ctx)
     tcg_gen_movi_tl(t4, 0x00010000);
 
     gen_set_label(l_c_lo);
-    tcg_gen_sextract_tl(t2, t1, 0, 16);
+    tcg_gen_ext16s_tl(t2, t1);
     tcg_gen_brcondi_tl(TCG_COND_EQ, t2, 0, l_done);
     tcg_gen_brcondi_tl(TCG_COND_LT, t2, 0, l_c_lo_lt);
     tcg_gen_ori_tl(t4, t4, 0x00000001);
-- 
2.41.0


