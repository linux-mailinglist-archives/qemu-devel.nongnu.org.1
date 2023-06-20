Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AA0736A63
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:10:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZE3-0006ZY-Q2; Tue, 20 Jun 2023 07:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDz-0006Rt-EG
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:39 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDw-0004T1-RX
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:39 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-985b04c46caso685453366b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 04:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687259315; x=1689851315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VkkdZVWfvLDeeOXE0iU3FgNXPD+nxdYVaySYHBaRhYI=;
 b=v+68CWZ0mxTURbAjJjr9WXf0VivFSux3nXotwqNt3rXb+A8wWswiTLXgN4iM0Xg+Vr
 upMruGdr3TYboXy5pxPvEY4C4IWcwfx1q0j6sAjqywhBVhK00bgopOkY6GzeigrSFRzk
 sndpLA0zXxyMCUOub3fzNkVaC/y6jzX7YJXlpVElDiGO8gaVU76x0AHU9DKjirfwDitK
 IhtukiNV177+SZc63MY3JL7pnQG2qgpycYsvdH9Ea3yjzYj/ZMLH7uwAE+wsOCA8gOs4
 H8ThmXlct+11dgfEHPQrfC7FtpVcTdeh9vgT5+lFbKkALLQ5sNFe4oNkpTYpXz6uXg1d
 1CJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687259315; x=1689851315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VkkdZVWfvLDeeOXE0iU3FgNXPD+nxdYVaySYHBaRhYI=;
 b=WAImc6M9UoBRJxiXnc+fEMvNQtnCeS+scx9znzS7xsaOgno5FMV+l1Wm8u/MhWxuRy
 /ZFvvaW03sGmFOfQa2CI4qCxzwN4NiCu8IwnI4PfaKqdl7WLgICGdI48iJvOQkJWSVhG
 LQURXWYdz+GwulGuDpwSapcc0sjNaB03eYJeNjLwWgLlNalHalChEaNno5O7PqJHw1Hi
 kgqWCHwH5smsFpV7yoBElnnGXQY44g1gYZip6J9AD5vpw6zHd8jRfZKR8RgaunV0cIos
 RemFrOplcsdzTgW7DPfk/TTjSDT2Jw1RQjrtwnV46Re/3a2Qc4JOvGIHx2SAfD9DVT6r
 1yCQ==
X-Gm-Message-State: AC+VfDxux+YW+kO7zmzoRAHAZbf2gakKv06gtUvS3okvDn+Qwsh18vvk
 4wVmTwL+Hj54wMttvbR++/dGyJ2uWN9HZdT5FSL8gIsg
X-Google-Smtp-Source: ACHHUZ6p4kYCaZv6l07b3+HXCX74Qdx6tDA5X6FkSmJd32h5M107WDp//BAmqIEuCnLYdCFZ1BkO9Q==
X-Received: by 2002:a17:907:25cc:b0:989:450:e57b with SMTP id
 ae12-20020a17090725cc00b009890450e57bmr2331559ejc.7.1687259315398; 
 Tue, 20 Jun 2023 04:08:35 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 x17-20020a170906711100b009884f015a44sm1170687ejj.49.2023.06.20.04.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 04:08:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 26/37] crypto: Add aesdec_ISB_ISR_IMC_AK
Date: Tue, 20 Jun 2023 13:07:47 +0200
Message-Id: <20230620110758.787479-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620110758.787479-1-richard.henderson@linaro.org>
References: <20230620110758.787479-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x635.google.com
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
index 6c744b299d..68cec14950 100644
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
index c0350c0b76..53696e8953 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -1518,6 +1518,64 @@ void aesdec_ISB_ISR_AK_genrev(AESState *r, const AESState *s, const AESState *k)
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


