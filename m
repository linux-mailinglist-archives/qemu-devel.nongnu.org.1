Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C03736AA4
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:15:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZDs-0006Kb-UZ; Tue, 20 Jun 2023 07:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDp-0006F9-Cw
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:29 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDn-0004Nl-HW
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:29 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-986d871a9beso591159166b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 04:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687259306; x=1689851306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SiJKh9OddvMER1urjRI8ROm1oVZkVAu8kaqi4NJ0AwE=;
 b=PB36B7SEdItAgBXCjw+qZCcY3cUxIf+ce08VbPqQS89g/RPh3rGq2OVoSc0oK8D9UW
 pA9/kA8s7+8pmVjxjC3zzwBOiWJr8BHdLgRNGwD1YCU44Kba4BB+kfS4SeAvAnfGSIIt
 rNOyWkx36Z1kYwfrzJxIiHXBS0Kxcmcowh4OZZmlJJZLP8Zqfeq1UPmdp9DRL24JOPv+
 XMKH04/i3n9qtu7mt9QMrETWiFbG26IGFVcv2qRwesAJ96ObZ/yEnD2cmhCVN79Aoxp+
 ISrQl/bgBokfEKZpTLsuHPBXUy2Ra4/+KU6Cx5OHW5tdDzJNCsqawGXOnojiqe29pB72
 fJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687259306; x=1689851306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SiJKh9OddvMER1urjRI8ROm1oVZkVAu8kaqi4NJ0AwE=;
 b=HKLWTHfP+HbX3wNGVUPM0iUiTat7myCJle2K0njFURfHEA+6TfQ/VdP9j3RqI/xDII
 5F1YmqAPhBI80qCEPh8KW5o2f82tlv73KTg9C0BrDX4XanSi5p/NuW2lu6A6fvgEw0qz
 4NYQsYSEoqXFiHrqqGZQvfwlV+lJDv2gXCmGmCuxIZsRzE5MSEXZpplIOBZgL1omaCZP
 7d5Xi8ky+ISWV7/x2rA/BjiqXcyfvWHgvIFfGnrYHqBH+YBoWKsFaiDxPpT4bLDb4zAy
 cHglDr5zKufNVYnDFPTrQWXja1Z6nJdM9BShAgGytguNgXcHpck6NkErQmo9cvO86o4S
 nQvw==
X-Gm-Message-State: AC+VfDxahwMnFiT9hE4Y5wrv3ix6niEsq9+ISqCu5qPXRlnpZ7b6GBi7
 DQJJK3eTwfvH68EgCzK+kZbjx8MGsjVxZ7xFnD0owYDc
X-Google-Smtp-Source: ACHHUZ4swoU6BZ1VSPVMAvqdXR4TezaSUkxecgq08nzaQ07BaA1qXYQ0Ynt0qNBlzGPWAmd4yh9yOA==
X-Received: by 2002:a17:906:fe4e:b0:96f:c46f:d8fe with SMTP id
 wz14-20020a170906fe4e00b0096fc46fd8femr10620729ejb.27.1687259306084; 
 Tue, 20 Jun 2023 04:08:26 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 x17-20020a170906711100b009884f015a44sm1170687ejj.49.2023.06.20.04.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 04:08:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 18/37] crypto: Add aesdec_IMC
Date: Tue, 20 Jun 2023 13:07:39 +0200
Message-Id: <20230620110758.787479-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620110758.787479-1-richard.henderson@linaro.org>
References: <20230620110758.787479-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
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

Add a primitive for InvMixColumns.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/crypto/aes-round.h |  2 +
 include/crypto/aes-round.h                   | 18 ++++++
 crypto/aes.c                                 | 59 ++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/host/include/generic/host/crypto/aes-round.h b/host/include/generic/host/crypto/aes-round.h
index 1b82afc629..335ec3f11e 100644
--- a/host/include/generic/host/crypto/aes-round.h
+++ b/host/include/generic/host/crypto/aes-round.h
@@ -15,6 +15,8 @@ void aesenc_SB_SR_AK_accel(AESState *, const AESState *,
                            const AESState *, bool)
     QEMU_ERROR("unsupported accel");
 
+void aesdec_IMC_accel(AESState *, const AESState *, bool)
+    QEMU_ERROR("unsupported accel");
 void aesdec_ISB_ISR_AK_accel(AESState *, const AESState *,
                              const AESState *, bool)
     QEMU_ERROR("unsupported accel");
diff --git a/include/crypto/aes-round.h b/include/crypto/aes-round.h
index df252ac76d..e1a9c24cca 100644
--- a/include/crypto/aes-round.h
+++ b/include/crypto/aes-round.h
@@ -59,6 +59,24 @@ static inline void aesenc_SB_SR_AK(AESState *r, const AESState *st,
     }
 }
 
+/*
+ * Perform InvMixColumns.
+ */
+
+void aesdec_IMC_gen(AESState *ret, const AESState *st);
+void aesdec_IMC_genrev(AESState *ret, const AESState *st);
+
+static inline void aesdec_IMC(AESState *r, const AESState *st, bool be)
+{
+    if (HAVE_AES_ACCEL) {
+        aesdec_IMC_accel(r, st, be);
+    } else if (HOST_BIG_ENDIAN == be) {
+        aesdec_IMC_gen(r, st);
+    } else {
+        aesdec_IMC_genrev(r, st);
+    }
+}
+
 /*
  * Perform InvSubBytes + InvShiftRows + AddRoundKey.
  */
diff --git a/crypto/aes.c b/crypto/aes.c
index d1ef4c19c2..31028609d6 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -1356,6 +1356,65 @@ void aesenc_SB_SR_AK_genrev(AESState *r, const AESState *s, const AESState *k)
     aesenc_SB_SR_AK_swap(r, s, k, true);
 }
 
+/*
+ * Perform InvMixColumns.
+ */
+static inline void
+aesdec_IMC_swap(AESState *r, const AESState *st, bool swap)
+{
+    int swap_b = swap * 0xf;
+    int swap_w = swap * 0x3;
+    bool be = HOST_BIG_ENDIAN ^ swap;
+    uint32_t t;
+
+    /* Note that AES_imc is encoded for big-endian. */
+    t = (AES_imc[st->b[swap_b ^ 0x0]][0] ^
+         AES_imc[st->b[swap_b ^ 0x1]][1] ^
+         AES_imc[st->b[swap_b ^ 0x2]][2] ^
+         AES_imc[st->b[swap_b ^ 0x3]][3]);
+    if (!be) {
+        t = bswap32(t);
+    }
+    r->w[swap_w ^ 0] = t;
+
+    t = (AES_imc[st->b[swap_b ^ 0x4]][0] ^
+         AES_imc[st->b[swap_b ^ 0x5]][1] ^
+         AES_imc[st->b[swap_b ^ 0x6]][2] ^
+         AES_imc[st->b[swap_b ^ 0x7]][3]);
+    if (!be) {
+        t = bswap32(t);
+    }
+    r->w[swap_w ^ 1] = t;
+
+    t = (AES_imc[st->b[swap_b ^ 0x8]][0] ^
+         AES_imc[st->b[swap_b ^ 0x9]][1] ^
+         AES_imc[st->b[swap_b ^ 0xA]][2] ^
+         AES_imc[st->b[swap_b ^ 0xB]][3]);
+    if (!be) {
+        t = bswap32(t);
+    }
+    r->w[swap_w ^ 2] = t;
+
+    t = (AES_imc[st->b[swap_b ^ 0xC]][0] ^
+         AES_imc[st->b[swap_b ^ 0xD]][1] ^
+         AES_imc[st->b[swap_b ^ 0xE]][2] ^
+         AES_imc[st->b[swap_b ^ 0xF]][3]);
+    if (!be) {
+        t = bswap32(t);
+    }
+    r->w[swap_w ^ 3] = t;
+}
+
+void aesdec_IMC_gen(AESState *r, const AESState *st)
+{
+    aesdec_IMC_swap(r, st, false);
+}
+
+void aesdec_IMC_genrev(AESState *r, const AESState *st)
+{
+    aesdec_IMC_swap(r, st, true);
+}
+
 /*
  * Perform InvSubBytes + InvShiftRows + AddRoundKey.
  */
-- 
2.34.1


