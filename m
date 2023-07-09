Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEE574C479
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:01:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxi-0000bN-Oq; Sun, 09 Jul 2023 10:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxY-0000Te-Qm
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxW-0000f4-5u
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:20 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8fcso27208425e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 07:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911216; x=1691503216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LO6Chl8aQYLOaHq+kw102b8WCIYofNouZUqxF+V9shk=;
 b=gl3oLWxKECjToR8Q7LAff5mTQBwoAraMppSlVJOiIAtObDzQwAP9shQ/CnX1w4YBGB
 OglhGL7H8cTwksAmZI1u5pibQBXDsXNeh29RxP7fy9voLyBEdlFrnHqAKg827YyFxwfs
 XAK//UTZA9Ord5/QNgvG67FVfp/HeQMp4OaSo+Yk+PVor8OHlXqh2am6CbhCaD1wzade
 YrINPzsw+wURACRij+lzcZRucsi7Jp3udO/nDpyrdWFhEIYDsISEAd2PcrOMD3jYYCZf
 8wWNh2Z0NwvbZvFP3/+5MnomVVaHbGurVaR7b0uDepPtVQ3nz39u6KKZkuabphCmQZ1J
 wsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911216; x=1691503216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LO6Chl8aQYLOaHq+kw102b8WCIYofNouZUqxF+V9shk=;
 b=QaPPR/ZnSNrJ+YXRFu52YkWivJ6v7P8YvNkW7oYLTGh6UIh48vdkTYhuS8xyn8l4by
 H/IlPJP5tkzafiAmUthnBgenslY4v4vJI/th9/680/CgBd9sBSxbMZF2OgMQ4DBqdOFu
 UIyolRqhNyPpVmvghCbJ3zXDzf6qlevd+Fio/Trh/SmfGCVItDk0Llk5HMtp7/SBiJfa
 1TMmBGeCwAwO0iIbT0jgtAY47BcDKHEeT6vIrzEk3bvqBxuQ8IVYaaTIvOW14MqLamJQ
 6idGS9gehSWqsPDvqJ5A0u+wGBkSythcfF2QaPOJJiLsc+kCLYw7cMEm+vyx2fQMYsX7
 xBsg==
X-Gm-Message-State: ABy/qLaAcoyd8j1lgeQjBcj6g/rKtWYrpjxvfAti+E1IaBYVIpexEL27
 67tGXN0l4nm9eTYKmBcSaCEVd5eMjyjkja4EBzgYNw==
X-Google-Smtp-Source: APBJJlEOlf/Mcb6Qpsac9zo1kMqwWoU0bdF09cJ+pe/fOVaVifWbvxhrAW+4iScFTfJAxtcur03f8A==
X-Received: by 2002:a05:600c:d4:b0:3fb:af9a:bf30 with SMTP id
 u20-20020a05600c00d400b003fbaf9abf30mr9450546wmm.2.1688911216306; 
 Sun, 09 Jul 2023 07:00:16 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.07.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 07:00:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/37] crypto: Remove AES_shifts, AES_ishifts
Date: Sun,  9 Jul 2023 14:59:42 +0100
Message-Id: <20230709135945.250311-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
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

These arrays are no longer used, replaced by AES_SH_*, AES_ISH_*.

Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/crypto/aes.h |  4 ----
 crypto/aes.c         | 14 --------------
 2 files changed, 18 deletions(-)

diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 24b073d569..aa8b54065d 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -30,10 +30,6 @@ void AES_decrypt(const unsigned char *in, unsigned char *out,
 extern const uint8_t AES_sbox[256];
 extern const uint8_t AES_isbox[256];
 
-/* AES ShiftRows and InvShiftRows */
-extern const uint8_t AES_shifts[16];
-extern const uint8_t AES_ishifts[16];
-
 /* AES MixColumns, for use with rot32. */
 extern const uint32_t AES_mc_rot[256];
 
diff --git a/crypto/aes.c b/crypto/aes.c
index c765f11c1e..00e16d3f92 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -114,23 +114,9 @@ const uint8_t AES_isbox[256] = {
 /* AES ShiftRows, for complete unrolling. */
 #define AES_SH(X)   (((X) * 5) & 15)
 
-const uint8_t AES_shifts[16] = {
-    AES_SH(0x0), AES_SH(0x1), AES_SH(0x2), AES_SH(0x3),
-    AES_SH(0x4), AES_SH(0x5), AES_SH(0x6), AES_SH(0x7),
-    AES_SH(0x8), AES_SH(0x9), AES_SH(0xA), AES_SH(0xB),
-    AES_SH(0xC), AES_SH(0xD), AES_SH(0xE), AES_SH(0xF),
-};
-
 /* AES InvShiftRows, for complete unrolling. */
 #define AES_ISH(X)  (((X) * 13) & 15)
 
-const uint8_t AES_ishifts[16] = {
-    AES_ISH(0x0), AES_ISH(0x1), AES_ISH(0x2), AES_ISH(0x3),
-    AES_ISH(0x4), AES_ISH(0x5), AES_ISH(0x6), AES_ISH(0x7),
-    AES_ISH(0x8), AES_ISH(0x9), AES_ISH(0xA), AES_ISH(0xB),
-    AES_ISH(0xC), AES_ISH(0xD), AES_ISH(0xE), AES_ISH(0xF),
-};
-
 /*
  * MixColumns lookup table, for use with rot32.
  */
-- 
2.34.1


