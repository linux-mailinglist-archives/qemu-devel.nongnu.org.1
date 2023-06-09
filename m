Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD23728E0F
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 04:33:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7RpM-0006zZ-Km; Thu, 08 Jun 2023 22:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7RoY-0003OI-0G
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:25:22 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7Rnl-0005my-Ru
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:25:21 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-652d76be8c2so1345177b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 19:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686277472; x=1688869472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHn7761oYxdsJZ0uyv7CBW336hBHMDMZ5Sm0uogz08I=;
 b=MjIrTMQbbKf90XXrS1mG3BIfqynCvvOLZBqj/LuJcIPOZplNNTnqQS3fdU8gNkprPN
 qPKby+ybb+hOyTFuVwIafNDa8KyD1L/3jTW1Yr+pxQ4aZDOiUzqwDCOY2AoKEKFNWcat
 85GJrZKdBFwr4v8nXMqmkMoWfBgZP3XLiN1xWoJeXXq69xRW36NjYtBD6rfDWbybNlCr
 tDGnbHd/lsTUHLqyE6TRa6NiCO+UeMZmXyUW1zdS9IWFiN45Gk1bQlqiBcYrY63d6TWD
 F3snut0h2GaNuBqoPTEeVFzfpn1fHyY9AYGrYN5r06h2TqpvtQ2Ap3Cbj+FIjEtPYUJb
 KctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686277472; x=1688869472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FHn7761oYxdsJZ0uyv7CBW336hBHMDMZ5Sm0uogz08I=;
 b=lsOvn2rtNuybqXewxPnsFAeErmdB0aUz6LDKkI5S7o/WJgMxVs294HhlFlJofgymyY
 MTp4RDBUGYV8IUBV1O03ihlLmP84jxXS9D5+7mAIqj9RjzfnrbKx/UoRavewQxGPKynV
 checuesQ4uokjY5RFahHzIKumi4wAHSAIYwpcA5B86ow/cim5ljUTIx/vEYEUDz7aPMV
 VoxXjJZs057e7uBoEY/pYdFJoGQrHB4zTN1bOzyuIe+kUgQWM0p6r4/pNez/tbrEEu8X
 Kljjs3DT3hBCuQanguxjFSYiVCzzLWcfDX9zddUgQN+M/b5zoTcMK2Jn+XmLguHYixz1
 tsMg==
X-Gm-Message-State: AC+VfDw7OqRFXwPiKyiXR7jVTGEOH4zeIiNWbzcD9R5bLdJWpaVySo/P
 Swug3EQ25Si/789LHDkI1myNUIXHKxRhUG0yd8g=
X-Google-Smtp-Source: ACHHUZ6dND9nKD2NQnt08w6sCcr0UG4L9GuCCxNhbpxHEKZ7Arei4YnT+sp5YbwxtI8B6zBtIF09Jw==
X-Received: by 2002:a05:6a00:2403:b0:652:7b99:df30 with SMTP id
 z3-20020a056a00240300b006527b99df30mr11622655pfh.25.1686277472475; 
 Thu, 08 Jun 2023 19:24:32 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:b071:df63:5761:f449])
 by smtp.gmail.com with ESMTPSA id
 x25-20020a62fb19000000b0063afb08afeesm1686458pfm.67.2023.06.08.19.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 19:24:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH v2 32/38] crypto: Remove AES_shifts, AES_ishifts
Date: Thu,  8 Jun 2023 19:23:55 -0700
Message-Id: <20230609022401.684157-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609022401.684157-1-richard.henderson@linaro.org>
References: <20230609022401.684157-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

These arrays are no longer used, replaced by AES_SH_*, AES_ISH_*.

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
index f0721ad4a2..7b8a22fe3e 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -131,13 +131,6 @@ enum {
     AES_SH_F = 0xb,
 };
 
-const uint8_t AES_shifts[16] = {
-    AES_SH_0, AES_SH_1, AES_SH_2, AES_SH_3,
-    AES_SH_4, AES_SH_5, AES_SH_6, AES_SH_7,
-    AES_SH_8, AES_SH_9, AES_SH_A, AES_SH_B,
-    AES_SH_C, AES_SH_D, AES_SH_E, AES_SH_F,
-};
-
 /* AES InvShiftRows, for complete unrolling. */
 enum {
     AES_ISH_0 = 0x0,
@@ -158,13 +151,6 @@ enum {
     AES_ISH_F = 0x3,
 };
 
-const uint8_t AES_ishifts[16] = {
-    AES_ISH_0, AES_ISH_1, AES_ISH_2, AES_ISH_3,
-    AES_ISH_4, AES_ISH_5, AES_ISH_6, AES_ISH_7,
-    AES_ISH_8, AES_ISH_9, AES_ISH_A, AES_ISH_B,
-    AES_ISH_C, AES_ISH_D, AES_ISH_E, AES_ISH_F,
-};
-
 /*
  * MixColumns lookup table, for use with rot32.
  */
-- 
2.34.1


