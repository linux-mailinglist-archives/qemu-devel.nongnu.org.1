Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2FC752BFF
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:18:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3ed-0000Ri-AR; Thu, 13 Jul 2023 17:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eQ-0000Mq-6g
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:15:04 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eN-00019J-KF
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:15:01 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-314417861b9so1313929f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689282898; x=1691874898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FzGMoLNjkDe1yX7tuu779EsO1joTMqPUtVQXclt+8ac=;
 b=LqnqEjsRBK+opcPjBUcVbLDs0MsRdBOa+vWNDBuLiRd2zpYFGNEAJDY1WLcw7FO3KA
 wbeWXcW0X4bjpo4l+1rH1bicn27nH2HdsRjA9s/8mPwkiNZivilBHw01z8GkaMcKbVvU
 bk02Y5NEp2m7opNdxZmhN22D6rW0tHamYXF+Yx8BtrlYmM1axdtkvvgBEI1x7iDyNoV/
 uyHxz9MA+8mdg6cHoe4HC1JpuZeyHZg7tx3KenzhCObzymvvhdTQX3S7MmBwYaobS/E9
 U28mBwB5b7wjwQFzSni2wRyUAuQxmX/UJ/PHU+2y9y30JNW50159U6lIkrBB0k+TfwRW
 GgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689282898; x=1691874898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FzGMoLNjkDe1yX7tuu779EsO1joTMqPUtVQXclt+8ac=;
 b=VV0NOir2DXSIgLkfsJ18b1Bg0MhdB1sVJSDkGnI0EO7ZO2nSUQ2TSchsCG+bLMOpaT
 ZkOKhUFjctJxVKTZG1uyu+rLI8s8BZFU2tBrA0F15Q8gdx1R47XquFuEfZ8/Ec2J8xKa
 Ro7El9smB0e0in0464c2WvfZkLYcfgwKERAuKmuu9+D0VeQl7xcsZkguxnLT6WFtAKFj
 c2r29W86Sw1BaDlMDmlxc3t0tyN2jVaD7FLtO+CvZDIcvu/ijzren8BY49YshUxgivV+
 iFdqIqesNtZYSIxJh9Zz9hPlpHjm3eRYlossoHsuPu0f/bONv50IbVDa9mf75PidKWJ9
 7vUA==
X-Gm-Message-State: ABy/qLYiaMkVfE018/a1flcf+Gw31T1g5r8BosGlBo9XlbpTJsIIWnFc
 fr++BUSJTyleseVU0FjyJWECRpPaOrXAZW9yBW+kyDZI
X-Google-Smtp-Source: APBJJlFKaEOJd9sssaxCAFfVImxCrJUzv19zmN9zSRkhbbfM9e8VNv9vlxmGIQwcPCmnuqke/NJi7g==
X-Received: by 2002:a5d:6b8f:0:b0:316:ee41:f1bf with SMTP id
 n15-20020a5d6b8f000000b00316ee41f1bfmr213435wrx.12.1689282898299; 
 Thu, 13 Jul 2023 14:14:58 -0700 (PDT)
Received: from stoup.. ([85.193.156.66]) by smtp.gmail.com with ESMTPSA id
 n12-20020adff08c000000b0030ada01ca78sm8973747wro.10.2023.07.13.14.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 14:14:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH 17/18] host/include/i386: Implement clmul.h
Date: Thu, 13 Jul 2023 22:14:34 +0100
Message-Id: <20230713211435.13505-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713211435.13505-1-richard.henderson@linaro.org>
References: <20230713211435.13505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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

Detect PCLMUL in cpuinfo; implement the accel hooks.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/i386/host/cpuinfo.h        |   1 +
 host/include/i386/host/crypto/clmul.h   | 187 ++++++++++++++++++++++++
 host/include/x86_64/host/crypto/clmul.h |   1 +
 util/cpuinfo-i386.c                     |   1 +
 4 files changed, 190 insertions(+)
 create mode 100644 host/include/i386/host/crypto/clmul.h
 create mode 100644 host/include/x86_64/host/crypto/clmul.h

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 073d0a426f..7ae21568f7 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -27,6 +27,7 @@
 #define CPUINFO_ATOMIC_VMOVDQA  (1u << 16)
 #define CPUINFO_ATOMIC_VMOVDQU  (1u << 17)
 #define CPUINFO_AES             (1u << 18)
+#define CPUINFO_PCLMUL          (1u << 19)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/host/include/i386/host/crypto/clmul.h b/host/include/i386/host/crypto/clmul.h
new file mode 100644
index 0000000000..0877d65ab6
--- /dev/null
+++ b/host/include/i386/host/crypto/clmul.h
@@ -0,0 +1,187 @@
+/*
+ * x86 specific clmul acceleration.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef X86_HOST_CRYPTO_CLMUL_H
+#define X86_HOST_CRYPTO_CLMUL_H
+
+#include "host/cpuinfo.h"
+#include <immintrin.h>
+
+#if defined(__PCLMUL__)
+# define HAVE_CLMUL_ACCEL  true
+# define ATTR_CLMUL_ACCEL
+#else
+# define HAVE_CLMUL_ACCEL  likely(cpuinfo & CPUINFO_PCLMUL)
+# define ATTR_CLMUL_ACCEL  __attribute__((target("pclmul")))
+#endif
+
+static inline Int128 ATTR_CLMUL_ACCEL
+clmul_64(uint64_t n, uint64_t m)
+{
+    union { __m128i v; Int128 s; } u;
+
+    if (!HAVE_CLMUL_ACCEL) {
+        return clmul_64_gen(n, m);
+    }
+
+    u.v = _mm_clmulepi64_si128(_mm_set_epi64x(0, n), _mm_set_epi64x(0, m), 0);
+    return u.s;
+}
+
+static inline uint64_t ATTR_CLMUL_ACCEL
+clmul_32(uint32_t n, uint32_t m)
+{
+    __m128i r;
+
+    if (!HAVE_CLMUL_ACCEL) {
+        return clmul_32_gen(n, m);
+    }
+
+    r = _mm_clmulepi64_si128(_mm_cvtsi32_si128(n), _mm_cvtsi32_si128(m), 0);
+    return ((__v2di)r)[0];
+}
+
+static inline Int128 ATTR_CLMUL_ACCEL
+clmul_32x2_even(Int128 n, Int128 m)
+{
+    union { __m128i v; Int128 s; } ur, un, um;
+    __m128i n02, m02, r0, r2;
+
+    if (!HAVE_CLMUL_ACCEL) {
+        return clmul_32x2_even_gen(n, m);
+    }
+
+    un.s = n;
+    um.s = m;
+    n02 = _mm_slli_epi64(un.v, 32);
+    m02 = _mm_slli_epi64(um.v, 32);
+    r0  = _mm_clmulepi64_si128(n02, m02, 0x00);
+    r2  = _mm_clmulepi64_si128(n02, m02, 0x11);
+    ur.v = _mm_unpackhi_epi64(r0, r2);
+    return ur.s;
+}
+
+static inline Int128 ATTR_CLMUL_ACCEL
+clmul_32x2_odd(Int128 n, Int128 m)
+{
+    union { __m128i v; Int128 s; } ur, un, um;
+    __m128i n13, m13, r1, r3;
+
+    if (!HAVE_CLMUL_ACCEL) {
+        return clmul_32x2_odd_gen(n, m);
+    }
+
+    un.s = n;
+    um.s = m;
+    n13 = _mm_srli_epi64(un.v, 32);
+    m13 = _mm_srli_epi64(um.v, 32);
+    r1  = _mm_clmulepi64_si128(n13, m13, 0x00);
+    r3  = _mm_clmulepi64_si128(n13, m13, 0x11);
+    ur.v = _mm_unpacklo_epi64(r1, r3);
+    return ur.s;
+}
+
+static inline uint64_t ATTR_CLMUL_ACCEL
+clmul_16x2_even(uint64_t n, uint64_t m)
+{
+    __m128i r0, r2;
+
+    if (!HAVE_CLMUL_ACCEL) {
+        return clmul_16x2_even_gen(n, m);
+    }
+
+    r0 = _mm_clmulepi64_si128(_mm_cvtsi32_si128(n & 0xffff),
+                              _mm_cvtsi32_si128(m & 0xffff), 0);
+    r2 = _mm_clmulepi64_si128(_mm_cvtsi32_si128((n >> 32) & 0xffff),
+                              _mm_cvtsi32_si128((m >> 32) & 0xffff), 0);
+    r0 = _mm_unpacklo_epi32(r0, r2);
+    return ((__v2di)r0)[0];
+}
+
+static inline uint64_t ATTR_CLMUL_ACCEL
+clmul_16x2_odd(uint64_t n, uint64_t m)
+{
+    __m128i r1, r3;
+
+    if (!HAVE_CLMUL_ACCEL) {
+        return clmul_16x2_even_gen(n, m);
+    }
+
+    r1 = _mm_clmulepi64_si128(_mm_cvtsi32_si128((n >> 16) & 0xffff),
+                              _mm_cvtsi32_si128((m >> 16) & 0xffff), 0);
+    r3 = _mm_clmulepi64_si128(_mm_cvtsi32_si128((n >> 48) & 0xffff),
+                              _mm_cvtsi32_si128((m >> 48) & 0xffff), 0);
+    r1 = _mm_unpacklo_epi32(r1, r3);
+    return ((__v2di)r1)[0];
+}
+
+static inline Int128 ATTR_CLMUL_ACCEL
+clmul_16x4_even(Int128 n, Int128 m)
+{
+    union { __m128i v; Int128 s; } ur, un, um;
+    __m128i mask = _mm_set_epi16(0, 0, 0, -1, 0, 0, 0, -1);
+    __m128i n04, m04, n26, m26, r0, r2, r4, r6;
+
+    if (!HAVE_CLMUL_ACCEL) {
+        return clmul_16x4_even_gen(n, m);
+    }
+
+    un.s = n;
+    um.s = m;
+    n04 = _mm_and_si128(un.v, mask);
+    m04 = _mm_and_si128(um.v, mask);
+    r0  = _mm_clmulepi64_si128(n04, m04, 0x00);
+    r4  = _mm_clmulepi64_si128(n04, m04, 0x11);
+    n26 = _mm_and_si128(_mm_srli_epi64(un.v, 32), mask);
+    m26 = _mm_and_si128(_mm_srli_epi64(um.v, 32), mask);
+    r2  = _mm_clmulepi64_si128(n26, m26, 0x00);
+    r6  = _mm_clmulepi64_si128(n26, m26, 0x11);
+
+    r0   = _mm_unpacklo_epi32(r0, r2);
+    r4   = _mm_unpacklo_epi32(r4, r6);
+    ur.v = _mm_unpacklo_epi64(r0, r4);
+    return ur.s;
+}
+
+static inline Int128 ATTR_CLMUL_ACCEL
+clmul_16x4_odd(Int128 n, Int128 m)
+{
+    union { __m128i v; Int128 s; } ur, un, um;
+    __m128i mask = _mm_set_epi16(0, 0, 0, -1, 0, 0, 0, -1);
+    __m128i n15, m15, n37, m37, r1, r3, r5, r7;
+
+    if (!HAVE_CLMUL_ACCEL) {
+        return clmul_16x4_odd_gen(n, m);
+    }
+
+    un.s = n;
+    um.s = m;
+    n15 = _mm_and_si128(_mm_srli_epi64(un.v, 16), mask);
+    m15 = _mm_and_si128(_mm_srli_epi64(um.v, 16), mask);
+    r1  = _mm_clmulepi64_si128(n15, m15, 0x00);
+    r5  = _mm_clmulepi64_si128(n15, m15, 0x11);
+    n37 = _mm_srli_epi64(un.v, 48);
+    m37 = _mm_srli_epi64(um.v, 48);
+    r3  = _mm_clmulepi64_si128(n37, m37, 0x00);
+    r7  = _mm_clmulepi64_si128(n37, m37, 0x11);
+
+    r1   = _mm_unpacklo_epi32(r1, r3);
+    r5   = _mm_unpacklo_epi32(r5, r7);
+    ur.v = _mm_unpacklo_epi64(r1, r5);
+    return ur.s;
+}
+
+/*
+ * Defer everything else to the generic routines.
+ * We could implement them with even more element manipulation.
+ */
+#define clmul_8x8_low           clmul_8x8_low_gen
+#define clmul_8x4_even          clmul_8x4_even_gen
+#define clmul_8x4_odd           clmul_8x4_odd_gen
+#define clmul_8x8_even          clmul_8x8_even_gen
+#define clmul_8x8_odd           clmul_8x8_odd_gen
+#define clmul_8x8_packed        clmul_8x8_packed_gen
+
+#endif /* X86_HOST_CRYPTO_CLMUL_H */
diff --git a/host/include/x86_64/host/crypto/clmul.h b/host/include/x86_64/host/crypto/clmul.h
new file mode 100644
index 0000000000..f25eced416
--- /dev/null
+++ b/host/include/x86_64/host/crypto/clmul.h
@@ -0,0 +1 @@
+#include "host/include/i386/host/crypto/clmul.h"
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 3a7b7e0ad1..c6f6364826 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -39,6 +39,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
         info |= (c & bit_SSE4_1 ? CPUINFO_SSE4 : 0);
         info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
+        info |= (c & bit_PCLMULQDQ ? CPUINFO_PCLMUL : 0);
 
         /* Our AES support requires PSHUFB as well. */
         info |= ((c & bit_AES) && (c & bit_SSSE3) ? CPUINFO_AES : 0);
-- 
2.34.1


