Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE427D593F
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:01:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKlJ-00017I-G7; Tue, 24 Oct 2023 13:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKl9-0000x7-G8
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 13:00:03 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKl5-0002u7-F0
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 13:00:03 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9c3aec5f326so1211218266b.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698166797; x=1698771597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/VaFybadz8sHRxLunLaPSmKQ0yZTOJvG0Do3RUVPUA=;
 b=yPOYM0QT0hgnpWwJ/q0KJa3FPW6ElQmDwxNPXZIRUhiT/JlmzLPgO30MfwAxTKeVog
 4u8T8c8TDwehvhRxLS1t9nb1m3b/pHIVIEZzhbxfxQEU4XGiykWF6BATVHJwq4PTqdHL
 1kBQ2s9yjwo1NL45QeA672noa7U2FAJ9Kvxol8VIpLrBuioBslWHTGREIsKU6/p6D1Oc
 awWAV4UzW4wiZ3FWEz0/LdiQ/TegX31FYb9Ed23h/fSywWE/2THsVELGN29zsDS0RP78
 wRhMPoVbVkgJIUqSWcANxr0F9e1jAq1jEH9iTL5t8JUvXFqhOuOqaAYnOFnGelHRkeFw
 Wfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698166797; x=1698771597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/VaFybadz8sHRxLunLaPSmKQ0yZTOJvG0Do3RUVPUA=;
 b=fIR2K3t954BvpC3kVtIiTZwsW/2POM+DeG/9OP4vG53i+m+41PzBQvEQ2kGrD+XnOd
 bpG4/jKDJFGQtypzsTvHtN5W6pnWyY0o/86rcRur6oYAiCzWm7VtSwRApq0GsxVg+dO5
 DieTURlMpQXrOLfMsvfj1Hoxp1vQzBFEP2xdzCfqKSXcF0v+FxT9TE8oJRrkiW2Xfbzi
 pzKuWtlXAgrNGGd7/g3xPwV2mznKA0/GdsqgZ3T9OqnwTQJb+md6QHNKqgUVdvc8XI4O
 gT0tsCJjFIvmcbdHviLKLpZV5z7uvgaZoSWcMcF4Qz+5RfztpvIAIE03OqcRXJix1zTV
 HnSA==
X-Gm-Message-State: AOJu0YyVUtR6tPuHhh0LTXZc5PRJDPYULSdbnX5Pn6f60FbSken4yNNd
 zloXHvbdyaipGqcXP3kwQSFggVUiz3UCxzktlJY=
X-Google-Smtp-Source: AGHT+IEhiRGYrQcAbc/kB3BdTgnbJBuFOuyXIHyimOJN5ijdp8ZpKAyDUgsOvZ9wSP1Ep3Ccv/b7xw==
X-Received: by 2002:a17:907:86a6:b0:9b7:4ec2:444e with SMTP id
 qa38-20020a17090786a600b009b74ec2444emr13098317ejc.8.1698166797513; 
 Tue, 24 Oct 2023 09:59:57 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 g27-20020a170906395b00b00988dbbd1f7esm8423762eje.213.2023.10.24.09.59.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 09:59:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PATCH v2 9/9] target/mips: Use tcg_gen_ext*u_tl
Date: Tue, 24 Oct 2023 18:59:02 +0200
Message-ID: <20231024165903.40861-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024165903.40861-1-philmd@linaro.org>
References: <20231024165903.40861-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 44 ++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 096a01e044..451fbd7664 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -823,7 +823,7 @@ static void gen_mxu_s8std(DisasContext *ctx, bool postmodify)
     switch (optn3) {
     /* XRa[7:0] => tmp8 */
     case MXU_OPTN3_PTN0:
-        tcg_gen_extract_tl(t1, t1, 0, 8);
+        tcg_gen_ext8u_tl(t1, t1);
         break;
     /* XRa[15:8] => tmp8 */
     case MXU_OPTN3_PTN1:
@@ -931,7 +931,7 @@ static void gen_mxu_s16std(DisasContext *ctx, bool postmodify)
     switch (optn2) {
     /* XRa[15:0] => tmp16 */
     case MXU_OPTN2_PTN0:
-        tcg_gen_extract_tl(t1, t1, 0, 16);
+        tcg_gen_ext16u_tl(t1, t1);
         break;
     /* XRa[31:16] => tmp16 */
     case MXU_OPTN2_PTN1:
@@ -1259,8 +1259,8 @@ static void gen_mxu_d16madl(DisasContext *ctx)
         tcg_gen_mul_tl(t2, t1, t2);
         break;
     }
-    tcg_gen_extract_tl(t2, t2, 0, 16);
-    tcg_gen_extract_tl(t3, t3, 0, 16);
+    tcg_gen_ext16u_tl(t2, t2);
+    tcg_gen_ext16u_tl(t3, t3);
 
     gen_load_mxu_gpr(t1, XRa);
     tcg_gen_extract_tl(t0, t1,  0, 16);
@@ -1961,7 +1961,7 @@ static void gen_mxu_d32sarl(DisasContext *ctx, bool sarw)
         gen_load_mxu_gpr(t1, XRc);
         tcg_gen_sar_tl(t0, t0, t2);
         tcg_gen_sar_tl(t1, t1, t2);
-        tcg_gen_extract_tl(t2, t1, 0, 16);
+        tcg_gen_ext16u_tl(t2, t1);
         tcg_gen_deposit_tl(t2, t2, t0, 16, 16);
         gen_store_mxu_gpr(t2, XRa);
     }
@@ -2667,9 +2667,9 @@ static void gen_mxu_q8movzn(DisasContext *ctx, TCGCond cond)
     tcg_gen_deposit_tl(t2, t2, t3, 8, 8);
 
     gen_set_label(l_quarterrest);
-    tcg_gen_extract_tl(t3, t1, 0, 8);
+    tcg_gen_ext8u_tl(t3, t1);
     tcg_gen_brcondi_tl(cond, t3, 0, l_done);
-    tcg_gen_extract_tl(t3, t0, 0, 8);
+    tcg_gen_ext8u_tl(t3, t0);
     tcg_gen_deposit_tl(t2, t2, t3, 0, 8);
 
     gen_set_label(l_done);
@@ -2714,9 +2714,9 @@ static void gen_mxu_d16movzn(DisasContext *ctx, TCGCond cond)
     tcg_gen_deposit_tl(t2, t2, t3, 16, 16);
 
     gen_set_label(l_halfdone);
-    tcg_gen_extract_tl(t3, t1, 0, 16);
+    tcg_gen_ext16u_tl(t3, t1);
     tcg_gen_brcondi_tl(cond, t3, 0, l_done);
-    tcg_gen_extract_tl(t3, t0, 0, 16);
+    tcg_gen_ext16u_tl(t3, t0);
     tcg_gen_deposit_tl(t2, t2, t3, 0, 16);
 
     gen_set_label(l_done);
@@ -2851,7 +2851,7 @@ static void gen_mxu_D16CPS(DisasContext *ctx)
         tcg_gen_br(l_done_lo);
 
         gen_set_label(l_not_less_lo);
-        tcg_gen_extract_tl(t0, mxu_gpr[XRb - 1],  0, 16);
+        tcg_gen_ext16u_tl(t0, mxu_gpr[XRb - 1]);
 
         gen_set_label(l_done_lo);
         tcg_gen_deposit_tl(mxu_gpr[XRa - 1], t1, t0, 0, 16);
@@ -3033,7 +3033,7 @@ static void gen_mxu_q8adde(DisasContext *ctx, bool accumulate)
                 tcg_gen_add_tl(t2, t2, t3);
             }
             tcg_gen_shli_tl(t2, t2, 16);
-            tcg_gen_extract_tl(t0, t0, 0, 16);
+            tcg_gen_ext16u_tl(t0, t0);
             tcg_gen_or_tl(t4, t2, t0);
         }
         if (XRd != 0) {
@@ -3056,7 +3056,7 @@ static void gen_mxu_q8adde(DisasContext *ctx, bool accumulate)
                 tcg_gen_add_tl(t2, t2, t3);
             }
             tcg_gen_shli_tl(t2, t2, 16);
-            tcg_gen_extract_tl(t0, t0, 0, 16);
+            tcg_gen_ext16u_tl(t0, t0);
             tcg_gen_or_tl(t5, t2, t0);
         }
 
@@ -3156,11 +3156,11 @@ static void gen_mxu_q16add(DisasContext *ctx)
     TCGv t5 = tcg_temp_new();
 
     gen_load_mxu_gpr(t1, XRb);
-    tcg_gen_extract_tl(t0, t1,  0, 16);
+    tcg_gen_ext16u_tl(t0, t1);
     tcg_gen_extract_tl(t1, t1, 16, 16);
 
     gen_load_mxu_gpr(t3, XRc);
-    tcg_gen_extract_tl(t2, t3,  0, 16);
+    tcg_gen_ext16u_tl(t2, t3);
     tcg_gen_extract_tl(t3, t3, 16, 16);
 
     switch (optn2) {
@@ -3210,9 +3210,9 @@ static void gen_mxu_q16add(DisasContext *ctx)
     }
 
     tcg_gen_shli_tl(t0, t0, 16);
-    tcg_gen_extract_tl(t1, t1, 0, 16);
+    tcg_gen_ext16u_tl(t1, t1);
     tcg_gen_shli_tl(t4, t4, 16);
-    tcg_gen_extract_tl(t5, t5, 0, 16);
+    tcg_gen_ext16u_tl(t5, t5);
 
     tcg_gen_or_tl(mxu_gpr[XRa - 1], t4, t5);
     tcg_gen_or_tl(mxu_gpr[XRd - 1], t0, t1);
@@ -3242,11 +3242,11 @@ static void gen_mxu_q16acc(DisasContext *ctx)
     TCGv s0 = tcg_temp_new();
 
     gen_load_mxu_gpr(t1, XRb);
-    tcg_gen_extract_tl(t0, t1,  0, 16);
+    tcg_gen_ext16u_tl(t0, t1);
     tcg_gen_extract_tl(t1, t1, 16, 16);
 
     gen_load_mxu_gpr(t3, XRc);
-    tcg_gen_extract_tl(t2, t3,  0, 16);
+    tcg_gen_ext16u_tl(t2, t3);
     tcg_gen_extract_tl(t3, t3, 16, 16);
 
     switch (aptn2) {
@@ -3278,7 +3278,7 @@ static void gen_mxu_q16acc(DisasContext *ctx)
 
     if (XRa != 0) {
         tcg_gen_add_tl(t0, mxu_gpr[XRa - 1], s0);
-        tcg_gen_extract_tl(t0, t0, 0, 16);
+        tcg_gen_ext16u_tl(t0, t0);
         tcg_gen_extract_tl(t1, mxu_gpr[XRa - 1], 16, 16);
         tcg_gen_add_tl(t1, t1, s1);
         tcg_gen_shli_tl(t1, t1, 16);
@@ -3287,7 +3287,7 @@ static void gen_mxu_q16acc(DisasContext *ctx)
 
     if (XRd != 0) {
         tcg_gen_add_tl(t0, mxu_gpr[XRd - 1], s2);
-        tcg_gen_extract_tl(t0, t0, 0, 16);
+        tcg_gen_ext16u_tl(t0, t0);
         tcg_gen_extract_tl(t1, mxu_gpr[XRd - 1], 16, 16);
         tcg_gen_add_tl(t1, t1, s3);
         tcg_gen_shli_tl(t1, t1, 16);
@@ -3335,7 +3335,7 @@ static void gen_mxu_q16accm(DisasContext *ctx)
             tcg_gen_add_tl(a0, a0, t0);
             tcg_gen_add_tl(a1, a1, t1);
         }
-        tcg_gen_extract_tl(a0, a0, 0, 16);
+        tcg_gen_ext16u_tl(a0, a0);
         tcg_gen_shli_tl(a1, a1, 16);
         tcg_gen_or_tl(mxu_gpr[XRa - 1], a1, a0);
     }
@@ -3358,7 +3358,7 @@ static void gen_mxu_q16accm(DisasContext *ctx)
             tcg_gen_add_tl(a0, a0, t0);
             tcg_gen_add_tl(a1, a1, t1);
         }
-        tcg_gen_extract_tl(a0, a0, 0, 16);
+        tcg_gen_ext16u_tl(a0, a0);
         tcg_gen_shli_tl(a1, a1, 16);
         tcg_gen_or_tl(mxu_gpr[XRd - 1], a1, a0);
     }
-- 
2.41.0


