Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C46647459CB
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:11:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGRK-0002eA-8e; Mon, 03 Jul 2023 06:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGR9-0002aI-FL
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:05:45 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGR3-0005gv-6T
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:05:38 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8fcso36047625e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688378725; x=1690970725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mPmUCjpRZwFOi0fix68D6WvDW8xFOeagc+Ir4MNFYrg=;
 b=BhSqWarOcSNp5PqbEm3/Xek0TVUNfOSjL7eMV2LLLxBlUN/cGYTC34Rn6g0xzh3JQl
 rt1XtTsy7Vzfw6HD/m6hHVAmdybFNc5KSsBoHzMtkcQndiGnwUJ6OzVWgSuY4SFCvi8b
 ajBqK9hotpU8EFV4D1xGxI7i1PNLiYaxR7Ml2fFAKMbU3I4VJ43v8Xa5vw7qmUmxb7vE
 MFwRxi1Z/SJ1L13WeyXwaksnRHK3P9P/8BREW8bQoWTlQ44Q2aKhijMy33Dit6PBNvmq
 uNMdIH+Yij1EM6Ne5SsFffQwhz5OdYZ7XFeaaP/YRD9FIDgQj8lzVP4tj3oK4dmiPrkc
 PZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688378725; x=1690970725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mPmUCjpRZwFOi0fix68D6WvDW8xFOeagc+Ir4MNFYrg=;
 b=WJxIXhe0zYMI5etjsZQYUNl4W9laB7nPlGYB7NrDDcqZKSUPSH30h1LlYxd28QiXEs
 RkETw21Hzfmr5rGT7KKsm69Hx1pE25uzy4SsDhIj2S8yj8+kOjPE7DYqd4UKO/XmV6U7
 tMGD+iG1RP9Fcp+PISU5+knH4VU5fpzYDHYN/UH+iZoOk8xjsnoq8GFhvQlGHrOQltf0
 HuY8MNFqyD/11dndIoVfXbIyF1pd6uWMP5P3m8nNp/6rTxvLDddLEt8oWTW5M+glu8t8
 S6461FcKU+rlWF9XCX2o9ucjQrZ9iHh7kRcRL3jmfz1m2NC/QmZdXcTvYsa2u9LuRL2B
 J5ZA==
X-Gm-Message-State: AC+VfDy7vjapM4Z61ZDo1vXechbuQQ/X+ohx8qnkZsLfYNElxES+/Ah5
 fUPzFPR5reeaQ5WTbgWXrFQ2Sgfbhod9cJB7KFmGtw==
X-Google-Smtp-Source: ACHHUZ4OihRehnjJpZh8ECKZ5ZcKf4FPa0h9T0gpcz/jdgSbzUBqz4sJJwtOz0xHfIyccYvPoHxG+g==
X-Received: by 2002:a05:600c:1e0b:b0:3fa:955a:9291 with SMTP id
 ay11-20020a05600c1e0b00b003fa955a9291mr13191697wmb.9.1688378724650; 
 Mon, 03 Jul 2023 03:05:24 -0700 (PDT)
Received: from stoup.home (91.232.79.188.dynamic.jazztel.es. [188.79.232.91])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm18446562wrx.59.2023.07.03.03.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:05:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 02/37] tests/multiarch: Add test-aes
Date: Mon,  3 Jul 2023 12:04:45 +0200
Message-Id: <20230703100520.68224-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703100520.68224-1-richard.henderson@linaro.org>
References: <20230703100520.68224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

Use a shared driver and backends for i386, aarch64, ppc64, riscv64.

Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/test-aes.c            |  58 ++++++++
 tests/tcg/i386/test-aes.c               |  68 +++++++++
 tests/tcg/ppc64/test-aes.c              | 116 +++++++++++++++
 tests/tcg/riscv64/test-aes.c            |  76 ++++++++++
 tests/tcg/multiarch/test-aes-main.c.inc | 183 ++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target       |   4 +
 tests/tcg/i386/Makefile.target          |   4 +
 tests/tcg/ppc64/Makefile.target         |   1 +
 tests/tcg/riscv64/Makefile.target       |  13 ++
 9 files changed, 523 insertions(+)
 create mode 100644 tests/tcg/aarch64/test-aes.c
 create mode 100644 tests/tcg/i386/test-aes.c
 create mode 100644 tests/tcg/ppc64/test-aes.c
 create mode 100644 tests/tcg/riscv64/test-aes.c
 create mode 100644 tests/tcg/multiarch/test-aes-main.c.inc

diff --git a/tests/tcg/aarch64/test-aes.c b/tests/tcg/aarch64/test-aes.c
new file mode 100644
index 0000000000..2cd324f09b
--- /dev/null
+++ b/tests/tcg/aarch64/test-aes.c
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "../multiarch/test-aes-main.c.inc"
+
+bool test_SB_SR(uint8_t *o, const uint8_t *i)
+{
+    /* aese also adds round key, so supply zero. */
+    asm("ld1 { v0.16b }, [%1]\n\t"
+        "movi v1.16b, #0\n\t"
+        "aese v0.16b, v1.16b\n\t"
+        "st1 { v0.16b }, [%0]"
+        : : "r"(o), "r"(i) : "v0", "v1", "memory");
+    return true;
+}
+
+bool test_MC(uint8_t *o, const uint8_t *i)
+{
+    asm("ld1 { v0.16b }, [%1]\n\t"
+        "aesmc v0.16b, v0.16b\n\t"
+        "st1 { v0.16b }, [%0]"
+        : : "r"(o), "r"(i) : "v0", "memory");
+    return true;
+}
+
+bool test_SB_SR_MC_AK(uint8_t *o, const uint8_t *i, const uint8_t *k)
+{
+    return false;
+}
+
+bool test_ISB_ISR(uint8_t *o, const uint8_t *i)
+{
+    /* aesd also adds round key, so supply zero. */
+    asm("ld1 { v0.16b }, [%1]\n\t"
+        "movi v1.16b, #0\n\t"
+        "aesd v0.16b, v1.16b\n\t"
+        "st1 { v0.16b }, [%0]"
+        : : "r"(o), "r"(i) : "v0", "v1", "memory");
+    return true;
+}
+
+bool test_IMC(uint8_t *o, const uint8_t *i)
+{
+    asm("ld1 { v0.16b }, [%1]\n\t"
+        "aesimc v0.16b, v0.16b\n\t"
+        "st1 { v0.16b }, [%0]"
+        : : "r"(o), "r"(i) : "v0", "memory");
+    return true;
+}
+
+bool test_ISB_ISR_AK_IMC(uint8_t *o, const uint8_t *i, const uint8_t *k)
+{
+    return false;
+}
+
+bool test_ISB_ISR_IMC_AK(uint8_t *o, const uint8_t *i, const uint8_t *k)
+{
+    return false;
+}
diff --git a/tests/tcg/i386/test-aes.c b/tests/tcg/i386/test-aes.c
new file mode 100644
index 0000000000..199395e6cc
--- /dev/null
+++ b/tests/tcg/i386/test-aes.c
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "../multiarch/test-aes-main.c.inc"
+#include <immintrin.h>
+
+static bool test_SB_SR(uint8_t *o, const uint8_t *i)
+{
+    __m128i vi = _mm_loadu_si128((const __m128i_u *)i);
+
+    /* aesenclast also adds round key, so supply zero. */
+    vi = _mm_aesenclast_si128(vi, _mm_setzero_si128());
+
+    _mm_storeu_si128((__m128i_u *)o, vi);
+    return true;
+}
+
+static bool test_MC(uint8_t *o, const uint8_t *i)
+{
+    return false;
+}
+
+static bool test_SB_SR_MC_AK(uint8_t *o, const uint8_t *i, const uint8_t *k)
+{
+    __m128i vi = _mm_loadu_si128((const __m128i_u *)i);
+    __m128i vk = _mm_loadu_si128((const __m128i_u *)k);
+
+    vi = _mm_aesenc_si128(vi, vk);
+
+    _mm_storeu_si128((__m128i_u *)o, vi);
+    return true;
+}
+
+static bool test_ISB_ISR(uint8_t *o, const uint8_t *i)
+{
+    __m128i vi = _mm_loadu_si128((const __m128i_u *)i);
+
+    /* aesdeclast also adds round key, so supply zero. */
+    vi = _mm_aesdeclast_si128(vi, _mm_setzero_si128());
+
+    _mm_storeu_si128((__m128i_u *)o, vi);
+    return true;
+}
+
+static bool test_IMC(uint8_t *o, const uint8_t *i)
+{
+    __m128i vi = _mm_loadu_si128((const __m128i_u *)i);
+
+    vi = _mm_aesimc_si128(vi);
+
+    _mm_storeu_si128((__m128i_u *)o, vi);
+    return true;
+}
+
+static bool test_ISB_ISR_AK_IMC(uint8_t *o, const uint8_t *i, const uint8_t *k)
+{
+    return false;
+}
+
+static bool test_ISB_ISR_IMC_AK(uint8_t *o, const uint8_t *i, const uint8_t *k)
+{
+    __m128i vi = _mm_loadu_si128((const __m128i_u *)i);
+    __m128i vk = _mm_loadu_si128((const __m128i_u *)k);
+
+    vi = _mm_aesdec_si128(vi, vk);
+
+    _mm_storeu_si128((__m128i_u *)o, vi);
+    return true;
+}
diff --git a/tests/tcg/ppc64/test-aes.c b/tests/tcg/ppc64/test-aes.c
new file mode 100644
index 0000000000..1d2be488e9
--- /dev/null
+++ b/tests/tcg/ppc64/test-aes.c
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "../multiarch/test-aes-main.c.inc"
+
+#undef BIG_ENDIAN
+#define BIG_ENDIAN  (__BYTE_ORDER__ == __ORDER_BIG_ENDIAN__)
+
+static unsigned char bswap_le[16] __attribute__((aligned(16))) = {
+    8,9,10,11,12,13,14,15,
+    0,1,2,3,4,5,6,7
+};
+
+bool test_SB_SR(uint8_t *o, const uint8_t *i)
+{
+    /* vcipherlast also adds round key, so supply zero. */
+    if (BIG_ENDIAN) {
+        asm("lxvd2x 32,0,%1\n\t"
+            "vspltisb 1,0\n\t"
+            "vcipherlast 0,0,1\n\t"
+            "stxvd2x 32,0,%0"
+            : : "r"(o), "r"(i) : "memory", "v0", "v1");
+    } else {
+        asm("lxvd2x 32,0,%1\n\t"
+            "lxvd2x 34,0,%2\n\t"
+            "vspltisb 1,0\n\t"
+            "vperm 0,0,0,2\n\t"
+            "vcipherlast 0,0,1\n\t"
+            "vperm 0,0,0,2\n\t"
+            "stxvd2x 32,0,%0"
+            : : "r"(o), "r"(i), "r"(bswap_le) : "memory", "v0", "v1", "v2");
+    }
+    return true;
+}
+
+bool test_MC(uint8_t *o, const uint8_t *i)
+{
+    return false;
+}
+
+bool test_SB_SR_MC_AK(uint8_t *o, const uint8_t *i, const uint8_t *k)
+{
+    if (BIG_ENDIAN) {
+        asm("lxvd2x 32,0,%1\n\t"
+            "lxvd2x 33,0,%2\n\t"
+            "vcipher 0,0,1\n\t"
+            "stxvd2x 32,0,%0"
+            : : "r"(o), "r"(i), "r"(k) : "memory", "v0", "v1");
+    } else {
+        asm("lxvd2x 32,0,%1\n\t"
+            "lxvd2x 33,0,%2\n\t"
+            "lxvd2x 34,0,%3\n\t"
+            "vperm 0,0,0,2\n\t"
+            "vperm 1,1,1,2\n\t"
+            "vcipher 0,0,1\n\t"
+            "vperm 0,0,0,2\n\t"
+            "stxvd2x 32,0,%0"
+            : : "r"(o), "r"(i), "r"(k), "r"(bswap_le)
+              : "memory", "v0", "v1", "v2");
+    }
+    return true;
+}
+
+bool test_ISB_ISR(uint8_t *o, const uint8_t *i)
+{
+    /* vcipherlast also adds round key, so supply zero. */
+    if (BIG_ENDIAN) {
+        asm("lxvd2x 32,0,%1\n\t"
+            "vspltisb 1,0\n\t"
+            "vncipherlast 0,0,1\n\t"
+            "stxvd2x 32,0,%0"
+            : : "r"(o), "r"(i) : "memory", "v0", "v1");
+    } else {
+        asm("lxvd2x 32,0,%1\n\t"
+            "lxvd2x 34,0,%2\n\t"
+            "vspltisb 1,0\n\t"
+            "vperm 0,0,0,2\n\t"
+            "vncipherlast 0,0,1\n\t"
+            "vperm 0,0,0,2\n\t"
+            "stxvd2x 32,0,%0"
+            : : "r"(o), "r"(i), "r"(bswap_le) : "memory", "v0", "v1", "v2");
+    }
+    return true;
+}
+
+bool test_IMC(uint8_t *o, const uint8_t *i)
+{
+    return false;
+}
+
+bool test_ISB_ISR_AK_IMC(uint8_t *o, const uint8_t *i, const uint8_t *k)
+{
+    if (BIG_ENDIAN) {
+        asm("lxvd2x 32,0,%1\n\t"
+            "lxvd2x 33,0,%2\n\t"
+            "vncipher 0,0,1\n\t"
+            "stxvd2x 32,0,%0"
+            : : "r"(o), "r"(i), "r"(k) : "memory", "v0", "v1");
+    } else {
+        asm("lxvd2x 32,0,%1\n\t"
+            "lxvd2x 33,0,%2\n\t"
+            "lxvd2x 34,0,%3\n\t"
+            "vperm 0,0,0,2\n\t"
+            "vperm 1,1,1,2\n\t"
+            "vncipher 0,0,1\n\t"
+            "vperm 0,0,0,2\n\t"
+            "stxvd2x 32,0,%0"
+            : : "r"(o), "r"(i), "r"(k), "r"(bswap_le)
+              : "memory", "v0", "v1", "v2");
+    }
+    return true;
+}
+
+bool test_ISB_ISR_IMC_AK(uint8_t *o, const uint8_t *i, const uint8_t *k)
+{
+    return false;
+}
diff --git a/tests/tcg/riscv64/test-aes.c b/tests/tcg/riscv64/test-aes.c
new file mode 100644
index 0000000000..3d7ef0e33a
--- /dev/null
+++ b/tests/tcg/riscv64/test-aes.c
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "../multiarch/test-aes-main.c.inc"
+
+bool test_SB_SR(uint8_t *o, const uint8_t *i)
+{
+    uint64_t *o8 = (uint64_t *)o;
+    const uint64_t *i8 = (const uint64_t *)i;
+
+    asm("aes64es %0,%2,%3\n\t"
+        "aes64es %1,%3,%2"
+        : "=&r"(o8[0]), "=&r"(o8[1]) : "r"(i8[0]), "r"(i8[1]));
+    return true;
+}
+
+bool test_MC(uint8_t *o, const uint8_t *i)
+{
+    return false;
+}
+
+bool test_SB_SR_MC_AK(uint8_t *o, const uint8_t *i, const uint8_t *k)
+{
+    uint64_t *o8 = (uint64_t *)o;
+    const uint64_t *i8 = (const uint64_t *)i;
+    const uint64_t *k8 = (const uint64_t *)k;
+
+    asm("aes64esm %0,%2,%3\n\t"
+        "aes64esm %1,%3,%2\n\t"
+        "xor %0,%0,%4\n\t"
+        "xor %1,%1,%5"
+        : "=&r"(o8[0]), "=&r"(o8[1])
+        : "r"(i8[0]), "r"(i8[1]), "r"(k8[0]), "r"(k8[1]));
+    return true;
+}
+
+bool test_ISB_ISR(uint8_t *o, const uint8_t *i)
+{
+    uint64_t *o8 = (uint64_t *)o;
+    const uint64_t *i8 = (const uint64_t *)i;
+
+    asm("aes64ds %0,%2,%3\n\t"
+        "aes64ds %1,%3,%2"
+        : "=&r"(o8[0]), "=&r"(o8[1]) : "r"(i8[0]), "r"(i8[1]));
+    return true;
+}
+
+bool test_IMC(uint8_t *o, const uint8_t *i)
+{
+    uint64_t *o8 = (uint64_t *)o;
+    const uint64_t *i8 = (const uint64_t *)i;
+
+    asm("aes64im %0,%0\n\t"
+        "aes64im %1,%1"
+        : "=r"(o8[0]), "=r"(o8[1]) : "0"(i8[0]), "1"(i8[1]));
+    return true;
+}
+
+bool test_ISB_ISR_AK_IMC(uint8_t *o, const uint8_t *i, const uint8_t *k)
+{
+    return false;
+}
+
+bool test_ISB_ISR_IMC_AK(uint8_t *o, const uint8_t *i, const uint8_t *k)
+{
+    uint64_t *o8 = (uint64_t *)o;
+    const uint64_t *i8 = (const uint64_t *)i;
+    const uint64_t *k8 = (const uint64_t *)k;
+
+    asm("aes64dsm %0,%2,%3\n\t"
+        "aes64dsm %1,%3,%2\n\t"
+        "xor %0,%0,%4\n\t"
+        "xor %1,%1,%5"
+        : "=&r"(o8[0]), "=&r"(o8[1])
+        : "r"(i8[0]), "r"(i8[1]), "r"(k8[0]), "r"(k8[1]));
+    return true;
+}
diff --git a/tests/tcg/multiarch/test-aes-main.c.inc b/tests/tcg/multiarch/test-aes-main.c.inc
new file mode 100644
index 0000000000..0039f8ba55
--- /dev/null
+++ b/tests/tcg/multiarch/test-aes-main.c.inc
@@ -0,0 +1,183 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+
+static bool test_SB_SR(uint8_t *o, const uint8_t *i);
+static bool test_MC(uint8_t *o, const uint8_t *i);
+static bool test_SB_SR_MC_AK(uint8_t *o, const uint8_t *i, const uint8_t *k);
+
+static bool test_ISB_ISR(uint8_t *o, const uint8_t *i);
+static bool test_IMC(uint8_t *o, const uint8_t *i);
+static bool test_ISB_ISR_AK_IMC(uint8_t *o, const uint8_t *i, const uint8_t *k);
+static bool test_ISB_ISR_IMC_AK(uint8_t *o, const uint8_t *i, const uint8_t *k);
+
+/*
+ * From https://doi.org/10.6028/NIST.FIPS.197-upd1,
+ * Appendix B -- Cipher Example
+ *
+ * Note that the formatting of the 4x4 matrices in the document is
+ * column-major, whereas C is row-major.  Therefore to get the bytes
+ * in the same order as the text, the matrices are transposed.
+ *
+ * Note that we are not going to test SubBytes or ShiftRows separately,
+ * so the "After SubBytes" column is omitted, using only the combined
+ * result "After ShiftRows" column.
+ */
+
+/* Ease the inline assembly by aligning everything. */
+typedef struct {
+    uint8_t b[16] __attribute__((aligned(16)));
+} State;
+
+typedef struct {
+    State start, after_sr, after_mc, round_key;
+} Round;
+
+static const Round rounds[] = {
+    /* Round 1 */
+    { { { 0x19, 0x3d, 0xe3, 0xbe,       /* start */
+          0xa0, 0xf4, 0xe2, 0x2b,
+          0x9a, 0xc6, 0x8d, 0x2a,
+          0xe9, 0xf8, 0x48, 0x08, } },
+
+      { { 0xd4, 0xbf, 0x5d, 0x30,       /* after shiftrows */
+          0xe0, 0xb4, 0x52, 0xae,
+          0xb8, 0x41, 0x11, 0xf1,
+          0x1e, 0x27, 0x98, 0xe5, } },
+
+      { { 0x04, 0x66, 0x81, 0xe5,       /* after mixcolumns */
+          0xe0, 0xcb, 0x19, 0x9a,
+          0x48, 0xf8, 0xd3, 0x7a,
+          0x28, 0x06, 0x26, 0x4c, } },
+
+      { { 0xa0, 0xfa, 0xfe, 0x17,       /* round key */
+          0x88, 0x54, 0x2c, 0xb1,
+          0x23, 0xa3, 0x39, 0x39,
+          0x2a, 0x6c, 0x76, 0x05, } } },
+
+    /* Round 2 */
+    { { { 0xa4, 0x9c, 0x7f, 0xf2,       /* start */
+          0x68, 0x9f, 0x35, 0x2b,
+          0x6b, 0x5b, 0xea, 0x43,
+          0x02, 0x6a, 0x50, 0x49, } },
+
+      { { 0x49, 0xdb, 0x87, 0x3b,       /* after shiftrows */
+          0x45, 0x39, 0x53, 0x89,
+          0x7f, 0x02, 0xd2, 0xf1,
+          0x77, 0xde, 0x96, 0x1a, } },
+
+      { { 0x58, 0x4d, 0xca, 0xf1,       /* after mixcolumns */
+          0x1b, 0x4b, 0x5a, 0xac,
+          0xdb, 0xe7, 0xca, 0xa8,
+          0x1b, 0x6b, 0xb0, 0xe5, } },
+
+      { { 0xf2, 0xc2, 0x95, 0xf2,       /* round key */
+          0x7a, 0x96, 0xb9, 0x43,
+          0x59, 0x35, 0x80, 0x7a,
+          0x73, 0x59, 0xf6, 0x7f, } } },
+
+    /* Round 3 */
+    { { { 0xaa, 0x8f, 0x5f, 0x03,       /* start */
+          0x61, 0xdd, 0xe3, 0xef,
+          0x82, 0xd2, 0x4a, 0xd2,
+          0x68, 0x32, 0x46, 0x9a, } },
+
+      { { 0xac, 0xc1, 0xd6, 0xb8,       /* after shiftrows */
+          0xef, 0xb5, 0x5a, 0x7b,
+          0x13, 0x23, 0xcf, 0xdf,
+          0x45, 0x73, 0x11, 0xb5, } },
+
+      { { 0x75, 0xec, 0x09, 0x93,       /* after mixcolumns */
+          0x20, 0x0b, 0x63, 0x33,
+          0x53, 0xc0, 0xcf, 0x7c,
+          0xbb, 0x25, 0xd0, 0xdc, } },
+
+      { { 0x3d, 0x80, 0x47, 0x7d,       /* round key */
+          0x47, 0x16, 0xfe, 0x3e,
+          0x1e, 0x23, 0x7e, 0x44,
+          0x6d, 0x7a, 0x88, 0x3b, } } },
+};
+
+static void verify_log(const char *prefix, const State *s)
+{
+    printf("%s:", prefix);
+    for (int i = 0; i < sizeof(State); ++i) {
+        printf(" %02x", s->b[i]);
+    }
+    printf("\n");
+}
+
+static void verify(const State *ref, const State *tst, const char *which)
+{
+    if (!memcmp(ref, tst, sizeof(State))) {
+        return;
+    }
+
+    printf("Mismatch on %s\n", which);
+    verify_log("ref", ref);
+    verify_log("tst", tst);
+    exit(EXIT_FAILURE);
+}
+
+int main()
+{
+    int i, n = sizeof(rounds) / sizeof(Round);
+    State t;
+
+    for (i = 0; i < n; ++i) {
+        if (test_SB_SR(t.b, rounds[i].start.b)) {
+            verify(&rounds[i].after_sr, &t, "SB+SR");
+        }
+    }
+
+    for (i = 0; i < n; ++i) {
+        if (test_MC(t.b, rounds[i].after_sr.b)) {
+            verify(&rounds[i].after_mc, &t, "MC");
+        }
+    }
+
+    /* The kernel of Cipher(). */
+    for (i = 0; i < n - 1; ++i) {
+        if (test_SB_SR_MC_AK(t.b, rounds[i].start.b, rounds[i].round_key.b)) {
+            verify(&rounds[i + 1].start, &t, "SB+SR+MC+AK");
+        }
+    }
+
+    for (i = 0; i < n; ++i) {
+        if (test_ISB_ISR(t.b, rounds[i].after_sr.b)) {
+            verify(&rounds[i].start, &t, "ISB+ISR");
+        }
+    }
+
+    for (i = 0; i < n; ++i) {
+        if (test_IMC(t.b, rounds[i].after_mc.b)) {
+            verify(&rounds[i].after_sr, &t, "IMC");
+        }
+    }
+
+    /* The kernel of InvCipher(). */
+    for (i = n - 1; i > 0; --i) {
+        if (test_ISB_ISR_AK_IMC(t.b, rounds[i].after_sr.b,
+                                rounds[i - 1].round_key.b)) {
+            verify(&rounds[i - 1].after_sr, &t, "ISB+ISR+AK+IMC");
+        }
+    }
+
+    /*
+     * The kernel of EqInvCipher().  
+     * We must compute a different round key: apply InvMixColumns to
+     * the standard round key, per KeyExpansion vs KeyExpansionEIC.
+     */
+    for (i = 1; i < n; ++i) {
+        if (test_IMC(t.b, rounds[i - 1].round_key.b) &&
+            test_ISB_ISR_IMC_AK(t.b, rounds[i].after_sr.b, t.b)) {
+            verify(&rounds[i - 1].after_sr, &t, "ISB+ISR+IMC+AK");
+        }
+    }
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 3430fd3cd8..d217474d0d 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -74,6 +74,10 @@ endif
 AARCH64_TESTS += sve-ioctls
 sve-ioctls: CFLAGS+=-march=armv8.1-a+sve
 
+AARCH64_TESTS += test-aes
+test-aes: CFLAGS += -O -march=armv8-a+aes
+test-aes: test-aes-main.c.inc
+
 # Vector SHA1
 sha1-vector: CFLAGS=-O3
 sha1-vector: sha1.c
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index f2ee7a4db7..fdf757c6ce 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -28,6 +28,10 @@ run-test-i386-bmi2: QEMU_OPTS += -cpu max
 test-i386-adcox: CFLAGS=-O2
 run-test-i386-adcox: QEMU_OPTS += -cpu max
 
+test-aes: CFLAGS += -O -msse2 -maes
+test-aes: test-aes-main.c.inc
+run-test-aes: QEMU_OPTS += -cpu max
+
 #
 # hello-i386 is a barebones app
 #
diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.target
index b084963b9a..5721c159f2 100644
--- a/tests/tcg/ppc64/Makefile.target
+++ b/tests/tcg/ppc64/Makefile.target
@@ -36,5 +36,6 @@ run-vector: QEMU_OPTS += -cpu POWER10
 
 PPC64_TESTS += signal_save_restore_xer
 PPC64_TESTS += xxspltw
+PPC64_TESTS += test-aes
 
 TESTS += $(PPC64_TESTS)
diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
index 9973ba3b5f..4b14a67f48 100644
--- a/tests/tcg/riscv64/Makefile.target
+++ b/tests/tcg/riscv64/Makefile.target
@@ -1,6 +1,13 @@
 # -*- Mode: makefile -*-
 # RISC-V specific tweaks
 
+config-cc.mak: Makefile
+	$(quiet-@)( \
+	    $(call cc-option,-mrv64g_zk, CROSS_CC_HAS_ZK) \
+	) 3> config-cc.mak
+
+-include config-cc.mak
+
 VPATH += $(SRC_PATH)/tests/tcg/riscv64
 TESTS += test-div
 TESTS += noexec
@@ -9,3 +16,9 @@ TESTS += noexec
 TESTS += test-noc
 test-noc: LDFLAGS = -nostdlib -static
 run-test-noc: QEMU_OPTS += -cpu rv64,c=false
+
+ifneq ($(CROSS_CC_HAS_ZK),)
+TESTS += test-aes
+test-aes: CFLAGS += -O -march=rv64gzk
+run-test-aes: QEMU_OPTS += -cpu rv64,zk=on
+endif
-- 
2.34.1


