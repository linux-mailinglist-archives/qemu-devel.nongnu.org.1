Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED437728DEC
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 04:28:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7RpG-0005wD-EB; Thu, 08 Jun 2023 22:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7RoG-00034y-4w
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:25:05 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7Rnh-0005kr-4p
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:25:03 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-33b1da9a8acso5782745ab.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 19:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686277468; x=1688869468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjvEaTKhzYzHhBmN+ZeK2Pcf7B5wC0/eWDhgyPAfEgA=;
 b=NlnYMLXt4kE4sr9HVjQ97UgDfK7BibN1fvaiD9ODjTKGIwHzLPNPehknmDKwXxvubk
 lgkcMc6aUuTRuuYJp9XojGPLNVhGd7aOv6Av2a9wxkTCVlCXV/ks/B0H7TqjmvOj4ych
 /g/kBUMXDqc0kmnN07gPMQKzaDNKg7uhXl9sBWskoZuArCxq9GiTuN0WZYu41ZyNlfg1
 VVF9Dx7FdQJDvK32zWHXGIVIsyB0C3rx9qyWAkc4WZ5xQhpul8VSuUY41AH6IKP5XyWB
 1okLLf6etWVKSnPkqjqQJ+aWj32yIszO+opV0k9jPHAEfSwPIoHz8Y3kU99Z9TrcQbju
 W/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686277468; x=1688869468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BjvEaTKhzYzHhBmN+ZeK2Pcf7B5wC0/eWDhgyPAfEgA=;
 b=fcoXpGSWGUcf812Th+uAdF6Gj+2qb+NJE/0fuq6nCV+i2M3vV8zVKLb8nIFp6MGQp3
 0/3yNLG0AT4vRxWaNoSr6xTnuCzHa5Hh8e/t4Grvm8o66eEIY2VjhyK1CokWPnFr//oY
 t8roPxQZZH2ciBdtpqT4bz/pJ7dNLNRG9K08fNJXOqq0mo4yhtLlQTUsxiKwXFIQHIsx
 zXE8LKR0qzAQKXG/2OArO1IZyJPD74joO3jDRQM0jTlhEfleuDhE1HCIgn4PqydkA1Oj
 cUdpuo5ugEAMrtI2ntm7quaiqIF8Lg2+jzxlEihoSLoW7w2gREuDOGyVN9BmTKFQZ31I
 Oziw==
X-Gm-Message-State: AC+VfDwK7oofF857ZlwTYcZgB6ZzJcE8WH5gF9CTZ4jXsVljM0lUne4p
 6vgO2WbCtGfKuMREkkuGHXnx8QPh/r7gwnmpdXU=
X-Google-Smtp-Source: ACHHUZ6hH7AcWIf+XdyMMQXc8TQ6YyOwyQELtZqZjiRPAb3t/64yh++1yv6PuUa+kRdHMpOTPQe0Hw==
X-Received: by 2002:a92:d445:0:b0:337:8342:e6a5 with SMTP id
 r5-20020a92d445000000b003378342e6a5mr326456ilm.31.1686277467851; 
 Thu, 08 Jun 2023 19:24:27 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:b071:df63:5761:f449])
 by smtp.gmail.com with ESMTPSA id
 x25-20020a62fb19000000b0063afb08afeesm1686458pfm.67.2023.06.08.19.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 19:24:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH v2 27/38] crypto: Add aesdec_ISB_ISR_IMC_AK
Date: Thu,  8 Jun 2023 19:23:50 -0700
Message-Id: <20230609022401.684157-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609022401.684157-1-richard.henderson@linaro.org>
References: <20230609022401.684157-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12a.google.com
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

Add a primitive for InvSubBytes + InvShiftRows +
InvMixColumns + AddRoundKey.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/aes-round.h |  3 ++
 include/crypto/aes-round.h            | 21 ++++++++++
 crypto/aes.c                          | 56 +++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/host/include/generic/host/aes-round.h b/host/include/generic/host/aes-round.h
index ee64db32fa..16b4447831 100644
--- a/host/include/generic/host/aes-round.h
+++ b/host/include/generic/host/aes-round.h
@@ -23,5 +23,8 @@ void aesdec_IMC_accel(AESState *, const AESState *, bool)
 void aesdec_ISB_ISR_AK_accel(AESState *, const AESState *,
                              const AESState *, bool)
     QEMU_ERROR("unsupported accel");
+void aesdec_ISB_ISR_IMC_AK_accel(AESState *, const AESState *,
+                                 const AESState *, bool)
+    QEMU_ERROR("unsupported accel");
 
 #endif
diff --git a/include/crypto/aes-round.h b/include/crypto/aes-round.h
index 9e10c3ee9e..31c5f10df6 100644
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
index 0c281472aa..b671a3a6fb 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -1508,6 +1508,62 @@ void aesdec_IMC_genrev(AESState *r, const AESState *st)
     aesdec_IMC_swap(r, st, true);
 }
 
+/* Perform InvSubBytes + InvShiftRows + InvMixColumns + AddRoundKey. */
+static inline void
+aesdec_ISB_ISR_IMC_AK_swap(AESState *r, const AESState *st,
+                           const AESState *rk, bool swap)
+{
+    int swap_b = swap * 0xf;
+    int swap_w = swap * 0x3;
+    bool be = HOST_BIG_ENDIAN ^ swap;
+    uint32_t w0, w1, w2, w3;
+
+    w0 = (AES_Td0[st->b[swap_b ^ AES_ISH_0]] ^
+          AES_Td1[st->b[swap_b ^ AES_ISH_1]] ^
+          AES_Td2[st->b[swap_b ^ AES_ISH_2]] ^
+          AES_Td3[st->b[swap_b ^ AES_ISH_3]]);
+
+    w1 = (AES_Td0[st->b[swap_b ^ AES_ISH_4]] ^
+          AES_Td1[st->b[swap_b ^ AES_ISH_5]] ^
+          AES_Td2[st->b[swap_b ^ AES_ISH_6]] ^
+          AES_Td3[st->b[swap_b ^ AES_ISH_7]]);
+
+    w2 = (AES_Td0[st->b[swap_b ^ AES_ISH_8]] ^
+          AES_Td1[st->b[swap_b ^ AES_ISH_9]] ^
+          AES_Td2[st->b[swap_b ^ AES_ISH_A]] ^
+          AES_Td3[st->b[swap_b ^ AES_ISH_B]]);
+
+    w3 = (AES_Td0[st->b[swap_b ^ AES_ISH_C]] ^
+          AES_Td1[st->b[swap_b ^ AES_ISH_D]] ^
+          AES_Td2[st->b[swap_b ^ AES_ISH_E]] ^
+          AES_Td3[st->b[swap_b ^ AES_ISH_F]]);
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


