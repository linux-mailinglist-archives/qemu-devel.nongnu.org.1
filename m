Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FA074C497
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:04:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxj-0000eD-Ol; Sun, 09 Jul 2023 10:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxD-0000Lz-3I
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:03 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxB-0000NU-C3
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 09:59:58 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31441bc0092so3414429f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911196; x=1691503196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjel77SnKNWNctLdWi3qeIHBWb+IXzPkj8iWkSio4Cw=;
 b=hSHJK8/N3Z2VqaMhULS72fi0dDicfbINs2n7iDtqL9LS0DomH68QDO1XNLu5GXnaiz
 a5Bo3xUuhFK2ILWrG88L9rsWAZdipMmCz0VEgKlXDt6G0Zu4xVrBy5f6CZl13GMV+MgL
 pZDYeScvr5GSuA/M/Epku+/6qAQN0FAa+vEfU72548fKM4UOXuR6ClXIylfSG8Tg//X5
 WVAXGgCKrZN9ga+nbAi8xWSazMSwtMKI689tyY+l1e30C7nf6AmJL54uFCMxaBArqawM
 XRmtR7QwkYVfiuv1nvyXusHjVl1f9fhq4hNgaZ7M1vtuccQTo96Bat8ul9wyYZtv4iqN
 Oyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911196; x=1691503196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bjel77SnKNWNctLdWi3qeIHBWb+IXzPkj8iWkSio4Cw=;
 b=HUapNtRFie3Sv2xglAaTX9ps0JUMxOD1mu+zIXEVoCbUi2g14ThgLZUvNemAJMi4Jg
 dMRvdyer7jQQNv+/962g0xd0UVr95ptPirxeE7PRxk4kizm4TEBGI4z8dRB9YqDkGX0K
 8xV6An4zMYgcfcxZYThfOxTefHzz6e4X1OLCfO9wE1unIIH6OzqHY7rEuUIqCAcrAw79
 Wu5UDOWsu8VO4mGuZ232L1knFLEREdFk5WjVMbwfMezxtO7/dUwDUeG2RRplJkC80CQw
 9PS2AQL6BnuvuvUrppEvEzPh8P1/WZQ3ThVFhLyIZtywd+TCK95evt0wjG2Oslcb1g47
 frhg==
X-Gm-Message-State: ABy/qLYv/quUHk7io3QOx7z7nvb0656NzdOU9YgDFM2ypDdBWSfHadzQ
 tqapHeEKEFHY/HpBhzX2v1HElB7IX9nXDfU6IqCESg==
X-Google-Smtp-Source: APBJJlElQVupnEOrZ+qcWglPmbAmJdO+g4ia897wUiK0Wq1niiLo/jjLbhKQjtSD1ZuxqValYPqtZw==
X-Received: by 2002:a5d:4603:0:b0:314:11ab:11a0 with SMTP id
 t3-20020a5d4603000000b0031411ab11a0mr7415291wrq.34.1688911195834; 
 Sun, 09 Jul 2023 06:59:55 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.06.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 06:59:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 10/37] crypto: Add aesdec_ISB_ISR_IMC_AK
Date: Sun,  9 Jul 2023 14:59:18 +0100
Message-Id: <20230709135945.250311-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

Add a primitive for InvSubBytes + InvShiftRows +
InvMixColumns + AddRoundKey.

Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/crypto/aes-round.h |  3 +
 include/crypto/aes-round.h                   | 21 +++++++
 crypto/aes.c                                 | 58 ++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/host/include/generic/host/crypto/aes-round.h b/host/include/generic/host/crypto/aes-round.h
index 9886e81e50..db8cfe17eb 100644
--- a/host/include/generic/host/crypto/aes-round.h
+++ b/host/include/generic/host/crypto/aes-round.h
@@ -23,5 +23,8 @@ void aesdec_IMC_accel(AESState *, const AESState *, bool)
 void aesdec_ISB_ISR_AK_accel(AESState *, const AESState *,
                              const AESState *, bool)
     QEMU_ERROR("unsupported accel");
+void aesdec_ISB_ISR_IMC_AK_accel(AESState *, const AESState *,
+                                 const AESState *, bool)
+    QEMU_ERROR("unsupported accel");
 
 #endif /* GENERIC_HOST_CRYPTO_AES_ROUND_H */
diff --git a/include/crypto/aes-round.h b/include/crypto/aes-round.h
index 03688c8640..9996f1c219 100644
--- a/include/crypto/aes-round.h
+++ b/include/crypto/aes-round.h
@@ -119,4 +119,25 @@ static inline void aesdec_ISB_ISR_AK(AESState *r, const AESState *st,
     }
 }
 
+/*
+ * Perform InvSubBytes + InvShiftRows + InvMixColumns + AddRoundKey.
+ */
+
+void aesdec_ISB_ISR_IMC_AK_gen(AESState *ret, const AESState *st,
+                               const AESState *rk);
+void aesdec_ISB_ISR_IMC_AK_genrev(AESState *ret, const AESState *st,
+                                  const AESState *rk);
+
+static inline void aesdec_ISB_ISR_IMC_AK(AESState *r, const AESState *st,
+                                         const AESState *rk, bool be)
+{
+    if (HAVE_AES_ACCEL) {
+        aesdec_ISB_ISR_IMC_AK_accel(r, st, rk, be);
+    } else if (HOST_BIG_ENDIAN == be) {
+        aesdec_ISB_ISR_IMC_AK_gen(r, st, rk);
+    } else {
+        aesdec_ISB_ISR_IMC_AK_genrev(r, st, rk);
+    }
+}
+
 #endif /* CRYPTO_AES_ROUND_H */
diff --git a/crypto/aes.c b/crypto/aes.c
index a193d98d54..c2546ef12e 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -1484,6 +1484,64 @@ void aesdec_ISB_ISR_AK_genrev(AESState *r, const AESState *s, const AESState *k)
     aesdec_ISB_ISR_AK_swap(r, s, k, true);
 }
 
+/*
+ * Perform InvSubBytes + InvShiftRows + InvMixColumns + AddRoundKey.
+ */
+static inline void
+aesdec_ISB_ISR_IMC_AK_swap(AESState *r, const AESState *st,
+                           const AESState *rk, bool swap)
+{
+    int swap_b = swap * 0xf;
+    int swap_w = swap * 0x3;
+    bool be = HOST_BIG_ENDIAN ^ swap;
+    uint32_t w0, w1, w2, w3;
+
+    w0 = (AES_Td0[st->b[swap_b ^ AES_ISH(0x0)]] ^
+          AES_Td1[st->b[swap_b ^ AES_ISH(0x1)]] ^
+          AES_Td2[st->b[swap_b ^ AES_ISH(0x2)]] ^
+          AES_Td3[st->b[swap_b ^ AES_ISH(0x3)]]);
+
+    w1 = (AES_Td0[st->b[swap_b ^ AES_ISH(0x4)]] ^
+          AES_Td1[st->b[swap_b ^ AES_ISH(0x5)]] ^
+          AES_Td2[st->b[swap_b ^ AES_ISH(0x6)]] ^
+          AES_Td3[st->b[swap_b ^ AES_ISH(0x7)]]);
+
+    w2 = (AES_Td0[st->b[swap_b ^ AES_ISH(0x8)]] ^
+          AES_Td1[st->b[swap_b ^ AES_ISH(0x9)]] ^
+          AES_Td2[st->b[swap_b ^ AES_ISH(0xA)]] ^
+          AES_Td3[st->b[swap_b ^ AES_ISH(0xB)]]);
+
+    w3 = (AES_Td0[st->b[swap_b ^ AES_ISH(0xC)]] ^
+          AES_Td1[st->b[swap_b ^ AES_ISH(0xD)]] ^
+          AES_Td2[st->b[swap_b ^ AES_ISH(0xE)]] ^
+          AES_Td3[st->b[swap_b ^ AES_ISH(0xF)]]);
+
+    /* Note that AES_TdX is encoded for big-endian. */
+    if (!be) {
+        w0 = bswap32(w0);
+        w1 = bswap32(w1);
+        w2 = bswap32(w2);
+        w3 = bswap32(w3);
+    }
+
+    r->w[swap_w ^ 0] = rk->w[swap_w ^ 0] ^ w0;
+    r->w[swap_w ^ 1] = rk->w[swap_w ^ 1] ^ w1;
+    r->w[swap_w ^ 2] = rk->w[swap_w ^ 2] ^ w2;
+    r->w[swap_w ^ 3] = rk->w[swap_w ^ 3] ^ w3;
+}
+
+void aesdec_ISB_ISR_IMC_AK_gen(AESState *r, const AESState *st,
+                               const AESState *rk)
+{
+    aesdec_ISB_ISR_IMC_AK_swap(r, st, rk, false);
+}
+
+void aesdec_ISB_ISR_IMC_AK_genrev(AESState *r, const AESState *st,
+                                  const AESState *rk)
+{
+    aesdec_ISB_ISR_IMC_AK_swap(r, st, rk, true);
+}
+
 /**
  * Expand the cipher key into the encryption key schedule.
  */
-- 
2.34.1


