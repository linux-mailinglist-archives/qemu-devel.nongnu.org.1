Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBDF855C21
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Feb 2024 09:17:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raWuC-0007mX-Qw; Thu, 15 Feb 2024 03:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raWtZ-0007Bb-GN
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:15:03 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raWtX-0001O5-Or
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:15:01 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5d3912c9a83so497968a12.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 00:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707984898; x=1708589698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o1WrtT24LEWJ2UE0G4+JsaaZMny8aXncXNU55PndN9g=;
 b=auiEAbsUS+da5ViS/dPNXxUTP12mUuVl4Ihtgw9dOzOwPs0p6twZkjSZMJJDKwdk80
 Ij/9DI5v3S7ygfdIGecRokFz120KDWZGwIfiypRZVHToXcF6E2NinWzzHNpzrtMA3ADo
 IYDcYfoqVMfRbpT+CWnYvVSMoZO0pJoafK4iUbYIgIgbAIv+CkHleWJ4FWROcKq53PnP
 F8Zu8O1QbgzcYaQRkK1AbOnDauxAeMMw/oYzbUtjYoZW5MhInR3sxgBjVlaM3EaG1Rr2
 TeK/WLKTGaiCbJP/yJEI/23wYPQHleQibFqGSZqnn6VzbzKwcBWSkjDM5PiUX5tnCM/e
 pvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707984898; x=1708589698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o1WrtT24LEWJ2UE0G4+JsaaZMny8aXncXNU55PndN9g=;
 b=hsTSQu3TpF5vgKXYQSCxfZZDMvejhvn4VTiHwwfwY3rq1Yp0/SDrMvMM/c2ywSZPwk
 tTBrdp55FaUJj7+qW5R7qjASI9csaTDiU2CpTePD5IeFaWtEDmw0bT1ybz+lMAgrWdXj
 8VqYaxqg0ySrDR+L7/PSO1WSxhM5CEP4ONggiUMFdMyLwePFtNnOKOGbN/8UvChhvpp/
 FfYXiVGOyJVKv01oeY7SSAdRTjBFaZ3fYt16ytNBjJ34HIKHrTMMBnOPY2BsiXm/gRpP
 PNbdbLxzwmquvjxz2t2TF90im2+NC5wnl/ovOi5H3hMn3mcew5oSRvEGr4LIX+Oorp77
 QU7A==
X-Gm-Message-State: AOJu0YwRNsAaGcgFGkdiQ+udchB7jeQeaQWEq4x4siiUyTli9Xm/SxS4
 qij8O3T2n4NxLTfn5EeKSA8jahEr3O4lTVk6fdOidmrDDgtMSeDhzOgIdC76LZg2Mck542pNY5u
 b
X-Google-Smtp-Source: AGHT+IGzO4CI/t4QjIU+2Qo27Ye8SxKsJp3yB8BLqMiz9HOQO23z1TlP+chyVgdOuy3RcyvZ2UrF+g==
X-Received: by 2002:a05:6a20:d70f:b0:1a0:686b:afdd with SMTP id
 iz15-20020a056a20d70f00b001a0686bafddmr1262724pzb.5.1707984898453; 
 Thu, 15 Feb 2024 00:14:58 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 qc14-20020a17090b288e00b0029900404e11sm807755pjb.27.2024.02.15.00.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 00:14:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: amonakov@ispras.ru,
	mmromanov@ispras.ru
Subject: [PATCH v4 05/10] util/bufferiszero: Optimize SSE2 and AVX2 variants
Date: Wed, 14 Feb 2024 22:14:44 -1000
Message-Id: <20240215081449.848220-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215081449.848220-1-richard.henderson@linaro.org>
References: <20240215081449.848220-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

From: Alexander Monakov <amonakov@ispras.ru>

Increase unroll factor in SIMD loops from 4x to 8x in order to move
their bottlenecks from ALU port contention to load issue rate (two loads
per cycle on popular x86 implementations).

Avoid using out-of-bounds pointers in loop boundary conditions.

Follow SSE2 implementation strategy in the AVX2 variant. Avoid use of
PTEST, which is not profitable there (like in the removed SSE4 variant).

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Mikhail Romanov <mmromanov@ispras.ru>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240206204809.9859-6-amonakov@ispras.ru>
---
 util/bufferiszero.c | 111 +++++++++++++++++++++++++++++---------------
 1 file changed, 73 insertions(+), 38 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 6ef5f8ec79..2822155c27 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -67,62 +67,97 @@ static bool buffer_is_zero_integer(const void *buf, size_t len)
 #if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
 #include <immintrin.h>
 
-/* Note that each of these vectorized functions require len >= 64.  */
+/* Helper for preventing the compiler from reassociating
+   chains of binary vector operations.  */
+#define SSE_REASSOC_BARRIER(vec0, vec1) asm("" : "+x"(vec0), "+x"(vec1))
+
+/* Note that these vectorized functions may assume len >= 256.  */
 
 static bool __attribute__((target("sse2")))
 buffer_zero_sse2(const void *buf, size_t len)
 {
-    __m128i t = _mm_loadu_si128(buf);
-    __m128i *p = (__m128i *)(((uintptr_t)buf + 5 * 16) & -16);
-    __m128i *e = (__m128i *)(((uintptr_t)buf + len) & -16);
-    __m128i zero = _mm_setzero_si128();
+    /* Unaligned loads at head/tail.  */
+    __m128i v = *(__m128i_u *)(buf);
+    __m128i w = *(__m128i_u *)(buf + len - 16);
+    /* Align head/tail to 16-byte boundaries.  */
+    const __m128i *p = QEMU_ALIGN_PTR_DOWN(buf + 16, 16);
+    const __m128i *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 16);
+    __m128i zero = { 0 };
 
-    /* Loop over 16-byte aligned blocks of 64.  */
-    while (likely(p <= e)) {
-        t = _mm_cmpeq_epi8(t, zero);
-        if (unlikely(_mm_movemask_epi8(t) != 0xFFFF)) {
+    /* Collect a partial block at tail end.  */
+    v |= e[-1]; w |= e[-2];
+    SSE_REASSOC_BARRIER(v, w);
+    v |= e[-3]; w |= e[-4];
+    SSE_REASSOC_BARRIER(v, w);
+    v |= e[-5]; w |= e[-6];
+    SSE_REASSOC_BARRIER(v, w);
+    v |= e[-7]; v |= w;
+
+    /*
+     * Loop over complete 128-byte blocks.
+     * With the head and tail removed, e - p >= 14, so the loop
+     * must iterate at least once.
+     */
+    do {
+        v = _mm_cmpeq_epi8(v, zero);
+        if (unlikely(_mm_movemask_epi8(v) != 0xFFFF)) {
             return false;
         }
-        t = p[-4] | p[-3] | p[-2] | p[-1];
-        p += 4;
-    }
+        v = p[0]; w = p[1];
+        SSE_REASSOC_BARRIER(v, w);
+        v |= p[2]; w |= p[3];
+        SSE_REASSOC_BARRIER(v, w);
+        v |= p[4]; w |= p[5];
+        SSE_REASSOC_BARRIER(v, w);
+        v |= p[6]; w |= p[7];
+        SSE_REASSOC_BARRIER(v, w);
+        v |= w;
+        p += 8;
+    } while (p < e - 7);
 
-    /* Finish the aligned tail.  */
-    t |= e[-3];
-    t |= e[-2];
-    t |= e[-1];
-
-    /* Finish the unaligned tail.  */
-    t |= _mm_loadu_si128(buf + len - 16);
-
-    return _mm_movemask_epi8(_mm_cmpeq_epi8(t, zero)) == 0xFFFF;
+    return _mm_movemask_epi8(_mm_cmpeq_epi8(v, zero)) == 0xFFFF;
 }
 
 #ifdef CONFIG_AVX2_OPT
 static bool __attribute__((target("avx2")))
 buffer_zero_avx2(const void *buf, size_t len)
 {
-    /* Begin with an unaligned head of 32 bytes.  */
-    __m256i t = _mm256_loadu_si256(buf);
-    __m256i *p = (__m256i *)(((uintptr_t)buf + 5 * 32) & -32);
-    __m256i *e = (__m256i *)(((uintptr_t)buf + len) & -32);
+    /* Unaligned loads at head/tail.  */
+    __m256i v = *(__m256i_u *)(buf);
+    __m256i w = *(__m256i_u *)(buf + len - 32);
+    /* Align head/tail to 32-byte boundaries.  */
+    const __m256i *p = QEMU_ALIGN_PTR_DOWN(buf + 32, 32);
+    const __m256i *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 32);
+    __m256i zero = { 0 };
 
-    /* Loop over 32-byte aligned blocks of 128.  */
-    while (p <= e) {
-        if (unlikely(!_mm256_testz_si256(t, t))) {
+    /* Collect a partial block at tail end.  */
+    v |= e[-1]; w |= e[-2];
+    SSE_REASSOC_BARRIER(v, w);
+    v |= e[-3]; w |= e[-4];
+    SSE_REASSOC_BARRIER(v, w);
+    v |= e[-5]; w |= e[-6];
+    SSE_REASSOC_BARRIER(v, w);
+    v |= e[-7]; v |= w;
+
+    /* Loop over complete 256-byte blocks.  */
+    for (; p < e - 7; p += 8) {
+        /* PTEST is not profitable here.  */
+        v = _mm256_cmpeq_epi8(v, zero);
+        if (unlikely(_mm256_movemask_epi8(v) != 0xFFFFFFFF)) {
             return false;
         }
-        t = p[-4] | p[-3] | p[-2] | p[-1];
-        p += 4;
-    } ;
+        v = p[0]; w = p[1];
+        SSE_REASSOC_BARRIER(v, w);
+        v |= p[2]; w |= p[3];
+        SSE_REASSOC_BARRIER(v, w);
+        v |= p[4]; w |= p[5];
+        SSE_REASSOC_BARRIER(v, w);
+        v |= p[6]; w |= p[7];
+        SSE_REASSOC_BARRIER(v, w);
+        v |= w;
+    }
 
-    /* Finish the last block of 128 unaligned.  */
-    t |= _mm256_loadu_si256(buf + len - 4 * 32);
-    t |= _mm256_loadu_si256(buf + len - 3 * 32);
-    t |= _mm256_loadu_si256(buf + len - 2 * 32);
-    t |= _mm256_loadu_si256(buf + len - 1 * 32);
-
-    return _mm256_testz_si256(t, t);
+    return _mm256_movemask_epi8(_mm256_cmpeq_epi8(v, zero)) == 0xFFFFFFFF;
 }
 #endif /* CONFIG_AVX2_OPT */
 
-- 
2.34.1


