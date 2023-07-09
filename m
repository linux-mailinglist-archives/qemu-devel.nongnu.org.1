Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5989074C71F
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:34:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAX-0008L1-Bx; Sun, 09 Jul 2023 14:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAR-0008HN-RY
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:55 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAQ-0000HH-4q
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:55 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbc244d384so38081755e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927393; x=1691519393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjel77SnKNWNctLdWi3qeIHBWb+IXzPkj8iWkSio4Cw=;
 b=z2AcgigWyJgFm1tUG1xzDL7CS9a2LyzJzFS4KxiQPEv65MlsRwfQ2ir6OgVdQ22Jp4
 MF0X9uPpVKj7l6q6aQmQnTaNROM3TwE8qIO//5qS/XF9/QbMQFyQ3zQqUWWg+713Mtkk
 F4fl91NFQEOzNTTMqZrxV38+HvNTcx7pbg2/p2FY6tHx5WEZkRJ0WBXUKmOYYZXHu+8Y
 QfVS/YKIu6uexsMRT96olFD0r2llVM9UBmrexmAmHIjDcjAGxCQhBeWxky/oOxCroI5H
 lI16wKrg9geknkLD45HmHKWG6UE/Hf2KWJMrLKizLhz+YTexNzFJ3zf+vqpjhmvqFrci
 JiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927393; x=1691519393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bjel77SnKNWNctLdWi3qeIHBWb+IXzPkj8iWkSio4Cw=;
 b=Lky6ue+tnko+tNM8jJzSFDx0ofTsUJHsFf1lgTRyyMwQmO0QlNX2fDHu3WSveh3Iei
 n8mxZxiMCLdJmDcCKWBZe4tnfb6CSTmHFEXI0UMknxJahE9o6VtUsAdY/BIHF3BWCLlE
 kL9Cbc3BkzbJgYUJ7e5/smYPXSnJTqcjsqEb9U1/ngBnpFFrSlARTidchTKKqe/mdS4y
 cZ7uBHLul8/XPq2yx17HamECDPymmr3DvG9sjhcQgh00PH7lmP5pvweMINCarloJ9u6u
 Zv8Zrb2qV1YTbm+ZmWXkOPIC+PYWxA0oSGmZYRY5q35lM8d1i9qhqzWj9s+3+wH8S1Jw
 BQrg==
X-Gm-Message-State: ABy/qLb0B/KD+N5N0RKJUkUbCs+uZSL390OA9lyVAEfuWR4wD7s1CW01
 RYe1MG3LXD+l5BHqIUKScf7Vgpn1DfoPX5a9zsjvhA==
X-Google-Smtp-Source: APBJJlGdNCeLI2wsc7jnsLMKZatqfs1UqueLj4GXakgseoalmoW1+M2E3d9z6tNKvcFExnSGtg4k6A==
X-Received: by 2002:a05:600c:20cb:b0:3fc:f9c:a3e2 with SMTP id
 y11-20020a05600c20cb00b003fc0f9ca3e2mr1632065wmm.6.1688927392911; 
 Sun, 09 Jul 2023 11:29:52 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 10/37] crypto: Add aesdec_ISB_ISR_IMC_AK
Date: Sun,  9 Jul 2023 19:28:31 +0100
Message-Id: <20230709182934.309468-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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


