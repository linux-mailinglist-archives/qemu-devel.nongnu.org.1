Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB54374C762
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:43:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEH-0005aa-NQ; Sun, 09 Jul 2023 14:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZEC-0004ra-Cn
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:48 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZE7-0004JE-OG
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fba8e2aa52so42044675e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927619; x=1691519619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1F2YVr3IWQtmqpjJeR+MoFqCj9awn2sZVMTfzE1Dbtk=;
 b=vv5/sAHgPhVuWtQjtVGI/Vqw7lnLUfVWYbTua4JNp8Rt8VQCTMJDJ3Cfvwrj5hmBG9
 LeHQVGV4YWJsjs500+NlNvgaMuZY8m7nhGrqk+L9rLyy7sB3TLzPzkHD9CteKTR99sa+
 wuFmOCaSSI1pwtirPQKm7akbH8L8kyG9g0fzqGq7B+Bc01GelYlawLOl1mn8Dqip+yQ4
 tHX0/K7Vtov6RdQuoIkWqdrHGZM+s7PQAsfE3WbxT+I9P7bQkjPGq03JoRMNSKTP3M+m
 a/ShxbtmLjFcg6GwzPyaJWwZiZYIHylc7+RZ2JsmNvF+lmCEhsSh31P7W+HUNMqFEyay
 zOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927619; x=1691519619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1F2YVr3IWQtmqpjJeR+MoFqCj9awn2sZVMTfzE1Dbtk=;
 b=eaj4vb3aU+GMaFY3oj8iWDDnvPXHL2KyV8WES8SK4d3eg0mUhcT2xQIFYXEKmXdskT
 B3nFGDop6YMzRghvuJRd+KBf7akpWASJbptgpL9uNCkT2BjK9owww1l895332dQOy3dL
 Un0rAiTMYzdpmADVsCfgvT6fk3z7fPIYf5Z0oYQSnrt1h78JKlTfhTjrdiJ9EHHmBMTh
 rC7seT3N2S2rmXdtS9gyM8Bs/Ny4PgtV8e6UzLs7I+HCdVIGKSxz0p+Nf+G13TLVlRKz
 eUAjgypzr2/lKlka/E500O5OpemuYKySu4PH+dG/S0mnxPtmz2ICSp+CgjdyExHE5u+8
 HrKQ==
X-Gm-Message-State: ABy/qLZjDh/3UPkBMKHG8aqaxJlHC6+1d30GpLAD6KuCxskh7IUo0lJP
 jbhrKyroXfZR4A14kpo8MwM+nbR8lY/a71F3XOS0Pg==
X-Google-Smtp-Source: APBJJlFnWrBSaI32XrgfFXbRyylhi+nCHJbkg8nk3jLgAqlX3L7+zwYip0+QxfLPSxSS3lJKqLcnKg==
X-Received: by 2002:a05:600c:258:b0:3fb:c15c:698a with SMTP id
 24-20020a05600c025800b003fbc15c698amr10397580wmj.4.1688927618792; 
 Sun, 09 Jul 2023 11:33:38 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 37/37] crypto: Unexport AES_*_rot, AES_TeN, AES_TdN
Date: Sun,  9 Jul 2023 19:29:25 +0100
Message-Id: <20230709182934.309468-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

These arrays are no longer used outside of aes.c.

Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/crypto/aes.h | 25 -------------------------
 crypto/aes.c         | 33 +++++++++++++++++++++------------
 2 files changed, 21 insertions(+), 37 deletions(-)

diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 99209f51b9..709d4d226b 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -30,29 +30,4 @@ void AES_decrypt(const unsigned char *in, unsigned char *out,
 extern const uint8_t AES_sbox[256];
 extern const uint8_t AES_isbox[256];
 
-/* AES MixColumns, for use with rot32. */
-extern const uint32_t AES_mc_rot[256];
-
-/* AES InvMixColumns, for use with rot32. */
-extern const uint32_t AES_imc_rot[256];
-
-/*
-AES_Te0[x] = S [x].[02, 01, 01, 03];
-AES_Te1[x] = S [x].[03, 02, 01, 01];
-AES_Te2[x] = S [x].[01, 03, 02, 01];
-AES_Te3[x] = S [x].[01, 01, 03, 02];
-AES_Te4[x] = S [x].[01, 01, 01, 01];
-
-AES_Td0[x] = Si[x].[0e, 09, 0d, 0b];
-AES_Td1[x] = Si[x].[0b, 0e, 09, 0d];
-AES_Td2[x] = Si[x].[0d, 0b, 0e, 09];
-AES_Td3[x] = Si[x].[09, 0d, 0b, 0e];
-AES_Td4[x] = Si[x].[01, 01, 01, 01];
-*/
-
-extern const uint32_t AES_Te0[256], AES_Te1[256], AES_Te2[256],
-                      AES_Te3[256], AES_Te4[256];
-extern const uint32_t AES_Td0[256], AES_Td1[256], AES_Td2[256],
-                      AES_Td3[256], AES_Td4[256];
-
 #endif
diff --git a/crypto/aes.c b/crypto/aes.c
index 685efbd583..836d7d5c0b 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -120,7 +120,7 @@ const uint8_t AES_isbox[256] = {
 /*
  * MixColumns lookup table, for use with rot32.
  */
-const uint32_t AES_mc_rot[256] = {
+static const uint32_t AES_mc_rot[256] = {
     0x00000000, 0x03010102, 0x06020204, 0x05030306,
     0x0c040408, 0x0f05050a, 0x0a06060c, 0x0907070e,
     0x18080810, 0x1b090912, 0x1e0a0a14, 0x1d0b0b16,
@@ -190,7 +190,7 @@ const uint32_t AES_mc_rot[256] = {
 /*
  * Inverse MixColumns lookup table, for use with rot32.
  */
-const uint32_t AES_imc_rot[256] = {
+static const uint32_t AES_imc_rot[256] = {
     0x00000000, 0x0b0d090e, 0x161a121c, 0x1d171b12,
     0x2c342438, 0x27392d36, 0x3a2e3624, 0x31233f2a,
     0x58684870, 0x5365417e, 0x4e725a6c, 0x457f5362,
@@ -272,7 +272,7 @@ AES_Td3[x] = Si[x].[09, 0d, 0b, 0e];
 AES_Td4[x] = Si[x].[01, 01, 01, 01];
 */
 
-const uint32_t AES_Te0[256] = {
+static const uint32_t AES_Te0[256] = {
     0xc66363a5U, 0xf87c7c84U, 0xee777799U, 0xf67b7b8dU,
     0xfff2f20dU, 0xd66b6bbdU, 0xde6f6fb1U, 0x91c5c554U,
     0x60303050U, 0x02010103U, 0xce6767a9U, 0x562b2b7dU,
@@ -338,7 +338,8 @@ const uint32_t AES_Te0[256] = {
     0x824141c3U, 0x299999b0U, 0x5a2d2d77U, 0x1e0f0f11U,
     0x7bb0b0cbU, 0xa85454fcU, 0x6dbbbbd6U, 0x2c16163aU,
 };
-const uint32_t AES_Te1[256] = {
+
+static const uint32_t AES_Te1[256] = {
     0xa5c66363U, 0x84f87c7cU, 0x99ee7777U, 0x8df67b7bU,
     0x0dfff2f2U, 0xbdd66b6bU, 0xb1de6f6fU, 0x5491c5c5U,
     0x50603030U, 0x03020101U, 0xa9ce6767U, 0x7d562b2bU,
@@ -404,7 +405,8 @@ const uint32_t AES_Te1[256] = {
     0xc3824141U, 0xb0299999U, 0x775a2d2dU, 0x111e0f0fU,
     0xcb7bb0b0U, 0xfca85454U, 0xd66dbbbbU, 0x3a2c1616U,
 };
-const uint32_t AES_Te2[256] = {
+
+static const uint32_t AES_Te2[256] = {
     0x63a5c663U, 0x7c84f87cU, 0x7799ee77U, 0x7b8df67bU,
     0xf20dfff2U, 0x6bbdd66bU, 0x6fb1de6fU, 0xc55491c5U,
     0x30506030U, 0x01030201U, 0x67a9ce67U, 0x2b7d562bU,
@@ -470,8 +472,8 @@ const uint32_t AES_Te2[256] = {
     0x41c38241U, 0x99b02999U, 0x2d775a2dU, 0x0f111e0fU,
     0xb0cb7bb0U, 0x54fca854U, 0xbbd66dbbU, 0x163a2c16U,
 };
-const uint32_t AES_Te3[256] = {
 
+static const uint32_t AES_Te3[256] = {
     0x6363a5c6U, 0x7c7c84f8U, 0x777799eeU, 0x7b7b8df6U,
     0xf2f20dffU, 0x6b6bbdd6U, 0x6f6fb1deU, 0xc5c55491U,
     0x30305060U, 0x01010302U, 0x6767a9ceU, 0x2b2b7d56U,
@@ -537,7 +539,8 @@ const uint32_t AES_Te3[256] = {
     0x4141c382U, 0x9999b029U, 0x2d2d775aU, 0x0f0f111eU,
     0xb0b0cb7bU, 0x5454fca8U, 0xbbbbd66dU, 0x16163a2cU,
 };
-const uint32_t AES_Te4[256] = {
+
+static const uint32_t AES_Te4[256] = {
     0x63636363U, 0x7c7c7c7cU, 0x77777777U, 0x7b7b7b7bU,
     0xf2f2f2f2U, 0x6b6b6b6bU, 0x6f6f6f6fU, 0xc5c5c5c5U,
     0x30303030U, 0x01010101U, 0x67676767U, 0x2b2b2b2bU,
@@ -603,7 +606,8 @@ const uint32_t AES_Te4[256] = {
     0x41414141U, 0x99999999U, 0x2d2d2d2dU, 0x0f0f0f0fU,
     0xb0b0b0b0U, 0x54545454U, 0xbbbbbbbbU, 0x16161616U,
 };
-const uint32_t AES_Td0[256] = {
+
+static const uint32_t AES_Td0[256] = {
     0x51f4a750U, 0x7e416553U, 0x1a17a4c3U, 0x3a275e96U,
     0x3bab6bcbU, 0x1f9d45f1U, 0xacfa58abU, 0x4be30393U,
     0x2030fa55U, 0xad766df6U, 0x88cc7691U, 0xf5024c25U,
@@ -669,7 +673,8 @@ const uint32_t AES_Td0[256] = {
     0x39a80171U, 0x080cb3deU, 0xd8b4e49cU, 0x6456c190U,
     0x7bcb8461U, 0xd532b670U, 0x486c5c74U, 0xd0b85742U,
 };
-const uint32_t AES_Td1[256] = {
+
+static const uint32_t AES_Td1[256] = {
     0x5051f4a7U, 0x537e4165U, 0xc31a17a4U, 0x963a275eU,
     0xcb3bab6bU, 0xf11f9d45U, 0xabacfa58U, 0x934be303U,
     0x552030faU, 0xf6ad766dU, 0x9188cc76U, 0x25f5024cU,
@@ -735,7 +740,8 @@ const uint32_t AES_Td1[256] = {
     0x7139a801U, 0xde080cb3U, 0x9cd8b4e4U, 0x906456c1U,
     0x617bcb84U, 0x70d532b6U, 0x74486c5cU, 0x42d0b857U,
 };
-const uint32_t AES_Td2[256] = {
+
+static const uint32_t AES_Td2[256] = {
     0xa75051f4U, 0x65537e41U, 0xa4c31a17U, 0x5e963a27U,
     0x6bcb3babU, 0x45f11f9dU, 0x58abacfaU, 0x03934be3U,
     0xfa552030U, 0x6df6ad76U, 0x769188ccU, 0x4c25f502U,
@@ -802,7 +808,8 @@ const uint32_t AES_Td2[256] = {
     0x017139a8U, 0xb3de080cU, 0xe49cd8b4U, 0xc1906456U,
     0x84617bcbU, 0xb670d532U, 0x5c74486cU, 0x5742d0b8U,
 };
-const uint32_t AES_Td3[256] = {
+
+static const uint32_t AES_Td3[256] = {
     0xf4a75051U, 0x4165537eU, 0x17a4c31aU, 0x275e963aU,
     0xab6bcb3bU, 0x9d45f11fU, 0xfa58abacU, 0xe303934bU,
     0x30fa5520U, 0x766df6adU, 0xcc769188U, 0x024c25f5U,
@@ -868,7 +875,8 @@ const uint32_t AES_Td3[256] = {
     0xa8017139U, 0x0cb3de08U, 0xb4e49cd8U, 0x56c19064U,
     0xcb84617bU, 0x32b670d5U, 0x6c5c7448U, 0xb85742d0U,
 };
-const uint32_t AES_Td4[256] = {
+
+static const uint32_t AES_Td4[256] = {
     0x52525252U, 0x09090909U, 0x6a6a6a6aU, 0xd5d5d5d5U,
     0x30303030U, 0x36363636U, 0xa5a5a5a5U, 0x38383838U,
     0xbfbfbfbfU, 0x40404040U, 0xa3a3a3a3U, 0x9e9e9e9eU,
@@ -934,6 +942,7 @@ const uint32_t AES_Td4[256] = {
     0xe1e1e1e1U, 0x69696969U, 0x14141414U, 0x63636363U,
     0x55555555U, 0x21212121U, 0x0c0c0c0cU, 0x7d7d7d7dU,
 };
+
 static const u32 rcon[] = {
         0x01000000, 0x02000000, 0x04000000, 0x08000000,
         0x10000000, 0x20000000, 0x40000000, 0x80000000,
-- 
2.34.1


