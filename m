Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA968720D5A
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 04:37:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5H7c-0002BD-H1; Fri, 02 Jun 2023 22:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6q-0000go-F9
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:35:18 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6S-0004tr-Gj
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:35:15 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-394c7ba4cb5so2054503b6e.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 19:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685759691; x=1688351691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Wfwarj28UsVRxtCJ9/8wlBpJ8nucgIhos+4a7OUH+Q=;
 b=Y1hPjCFss8YZsHfg5LjjFGYIj2qFOlPjuekeWGntqcZ7QBwGCeAgKWxidn2pZqmjaY
 5skjFoPp/JjcY89/EPkKVKPmOi5lRISCbNBN2lhsNbzLQRd/X3MzhaPhr5DZAzaPUkna
 vLPAsD6u/SMB1zpaUEFDHr4CjQo+LlLR3P7jRRgkUik9QSK4RhDOYb0hDbBAab02JjPN
 gc/Cxqmg+bzz+rBLEIGUV0ndzBQmJkaQRmLfjxW9MYsOCIug6FvFqeHzGPviP6UzrLfO
 tyCXMzqDoN4wa+yBiRA6isbZLBDfy+T3F2PxzCK1H6OCxTlFnbS+FjJW6SU48/oMVJgr
 viEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685759691; x=1688351691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Wfwarj28UsVRxtCJ9/8wlBpJ8nucgIhos+4a7OUH+Q=;
 b=LqlLEA4oKcXGa2OurERQiM0PxGsRQeaMHV+E88M8HytOLz9JfRVCoQM+hdiWfLwg+c
 oFDgq4aTgEGTJWGg/N2Jn37iJpa53jlKiZDyo3iUjDnheoI37gTyHX+vFeTKqozIxMBR
 dMrjGhabLtSOuktdjdTj+xcZBEP2Al+96/haQPCyf9muCkxyNDwM1Djdn/Mv9n6wCGok
 MWcW2XV3rCdDP33eVmmb6yjfcVBcZqLoHXIiZNlb7nnwd/NnQhAe9LwnoPYE1ZTpxJ4Y
 5pAGADM9jdsuczBgPRj/7ORnNFB0ZEIImfPEcIYAjYZV4uNM2ttGm0sbs2hXT33GpukC
 Um5Q==
X-Gm-Message-State: AC+VfDyQw1maqRGd/5QAIrWwHySpZYdgbhols/88+MX4Owo4Dq8Uzy14
 WOdlsLcc45eEe95ia0CGjuQM25XBK5ugXWfroTY=
X-Google-Smtp-Source: ACHHUZ6/U1mUIkZ3yS8ra1m4zW+tB9Be51Sg3vyg2/YT6GyhzblPPMLNmJWqcLNIX7tYlLo1WDUpNQ==
X-Received: by 2002:a05:6808:2998:b0:396:9fe5:1a65 with SMTP id
 ex24-20020a056808299800b003969fe51a65mr1767640oib.16.1685759690795; 
 Fri, 02 Jun 2023 19:34:50 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 e91-20020a17090a6fe400b002508d73f4e8sm3914289pjk.57.2023.06.02.19.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 19:34:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH 25/35] crypto: Add aesdec_ISB_ISR_IMC_AK
Date: Fri,  2 Jun 2023 19:34:16 -0700
Message-Id: <20230603023426.1064431-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603023426.1064431-1-richard.henderson@linaro.org>
References: <20230603023426.1064431-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

Add a primitive for InvSubBytes + InvShiftRows +
InvMixColumns + AddRoundKey.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/aes-round.h |  4 ++
 include/crypto/aes-round.h            | 21 ++++++++++
 crypto/aes.c                          | 56 +++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/host/include/generic/host/aes-round.h b/host/include/generic/host/aes-round.h
index dc2c751ac3..848436379d 100644
--- a/host/include/generic/host/aes-round.h
+++ b/host/include/generic/host/aes-round.h
@@ -25,4 +25,8 @@ void aesdec_IMC_accel(AESState *, const AESState *, bool)
 void aesdec_ISB_ISR_accel(AESState *, const AESState *, bool)
     QEMU_ERROR("unsupported accel");
 
+void aesdec_ISB_ISR_IMC_AK_accel(AESState *, const AESState *,
+                                 const AESState *, bool)
+    QEMU_ERROR("unsupported accel");
+
 #endif
diff --git a/include/crypto/aes-round.h b/include/crypto/aes-round.h
index aefa17fcc3..352687ce11 100644
--- a/include/crypto/aes-round.h
+++ b/include/crypto/aes-round.h
@@ -113,4 +113,25 @@ static inline void aesdec_IMC(AESState *r, const AESState *st, bool be)
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
index 6172495b46..1696086868 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -1515,6 +1515,62 @@ void aesdec_IMC_genrev(AESState *r, const AESState *st)
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


