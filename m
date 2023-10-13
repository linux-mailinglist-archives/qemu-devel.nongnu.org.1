Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D26D7C8D6C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 21:02:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrNPk-0003nt-55; Fri, 13 Oct 2023 15:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mmromanov@ispras.ru>)
 id 1qrKZs-0003ze-1w
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:59:52 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mmromanov@ispras.ru>)
 id 1qrKZp-0007wL-1F
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:59:51 -0400
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTP id 3299F40F1DEB;
 Fri, 13 Oct 2023 15:59:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3299F40F1DEB
From: Mikhail Romanov <mmromanov@ispras.ru>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>,
 Alexander Monakov <amonakov@ispras.ru>,
 Mikhail Romanov <mmromanov@ispras.ru>
Subject: [PATCH] buffer_is_zero improvement
Date: Fri, 13 Oct 2023 18:58:56 +0300
Message-Id: <20231013155856.21475-1-mmromanov@ispras.ru>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84; envelope-from=mmromanov@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Oct 2023 15:01:32 -0400
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

Improve buffer_is_zero function which is often used in qemu-img utility.

Executing buffer_is_zero function takes around 40% of qemu-img runtime
(measured on a 4.4 GiB Windows 10 raw image converting to qcow2 format
via perf record utility, ~100000 samples over 4 seconds).

1) Define an inline wrapper for this function in include/qemu/cutils.h.
It checks the first, the middle and the last byte of the buffer and
returns false if a non-zero byte encountered, else the main (internal)
function is called.

2) Delete AVX-512 accelerator because it is called rarely thanks to
inline wrapper, so its speed benefit is neutralized by processor
throttling before first in a while 512-bit vector function use. See:
https://travisdowns.github.io/blog/2020/01/17/avxfreq1.html

3) Delete SSE4 accelerator because its only difference with the SSE2 one
is using testz instead of cmpeq+movemask to compare a buffer with 0, but
it gives no perfomance benefit (according to uops.info data).

4) Improve checking buffers with len < 8 in internal integer function
because inline wrapper ensures len >= 4.

5) Add uint64_a type for pointers in integer version so they can alias
with any other type used in the buffer.

6) Replace unaligned tail checking in AVX2 accelerator with aligned tail
checking similar to SSE2's one because reading unaligned tail gives no
benefit.

7) Move tail checking in both SSE2 and AVX2 accelerators before the main
loop so cmpeq+movemask checks become more evenly on time.

8) The main loop pointer in both SSE2 and AVX2 accelerators point to the
beginning of processed portion of bytes instead of the end so it never
points beyond the end of the buffer.

9) Double amount of bytes checked in an iteration of the main loop in
both SSE2 and AVX2 accelerators to meet processors' data loading per
cycle limit.

10) Move the decision between accelerators to the inline wrapper so it
can be omitted by the compiler if buffer size is known at compile time.

11) Remove all prefetches because they are done just a few processor
cycles before memory is read.

After these improvements buffer_is_zero works ~40% faster and takes 28%
of qemu-img runtime (measured the same way as initial version, inline
wrapper execution included).

The test-bufferiszero.c unit test still passes.

Signed-off-by: Mikhail Romanov <mmromanov@ispras.ru>
---

Now buffer_is_zero wrapper has a sophisticated contract so it may be
useful to move the inline wrapper to a distinct header file.

 include/qemu/cutils.h |  25 ++++-
 util/bufferiszero.c   | 244 +++++++++++++++++-------------------------
 2 files changed, 120 insertions(+), 149 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 92c927a6a3..6e35802b5e 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -187,7 +187,30 @@ char *freq_to_str(uint64_t freq_hz);
 /* used to print char* safely */
 #define STR_OR_NULL(str) ((str) ? (str) : "null")
 
-bool buffer_is_zero(const void *buf, size_t len);
+bool buffer_is_zero_len_4_plus(const void *buf, size_t len);
+extern bool (*buffer_is_zero_len_256_plus)(const void *, size_t);
+static inline bool buffer_is_zero(const void *vbuf, size_t len)
+{
+    const char *buf = vbuf;
+
+    if (len == 0) {
+        return true;
+    }
+    if (buf[0] || buf[len - 1] || buf[len / 2]) {
+        return false;
+    }
+    /* For len <= 3, all bytes are already tested.  */
+    if (len <= 3) {
+        return true;
+    }
+
+    if (len >= 256) {
+        return buffer_is_zero_len_256_plus(vbuf, len);
+    } else {
+        return buffer_is_zero_len_4_plus(vbuf, len);
+    }
+}
+
 bool test_buffer_is_zero_next_accel(void);
 
 /*
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 3e6a5dfd63..61cab171b0 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -26,30 +26,23 @@
 #include "qemu/bswap.h"
 #include "host/cpuinfo.h"
 
-static bool
-buffer_zero_int(const void *buf, size_t len)
+typedef uint64_t uint64_a __attribute__((may_alias));
+
+bool
+buffer_is_zero_len_4_plus(const void *buf, size_t len)
 {
     if (unlikely(len < 8)) {
-        /* For a very small buffer, simply accumulate all the bytes.  */
-        const unsigned char *p = buf;
-        const unsigned char *e = buf + len;
-        unsigned char t = 0;
-
-        do {
-            t |= *p++;
-        } while (p < e);
-
-        return t == 0;
+        /* Inline wrapper already checked that len >= 4.  */
+        return (ldl_he_p(buf) | ldl_he_p(buf + len - 4)) == 0;
     } else {
-        /* Otherwise, use the unaligned memory access functions to
-           handle the beginning and end of the buffer, with a couple
+        /* Use the unaligned memory access functions to handle
+           the beginning and end of the buffer, with a couple
            of loops handling the middle aligned section.  */
         uint64_t t = ldq_he_p(buf);
-        const uint64_t *p = (uint64_t *)(((uintptr_t)buf + 8) & -8);
-        const uint64_t *e = (uint64_t *)(((uintptr_t)buf + len) & -8);
+        const uint64_a *p = (uint64_a *)(((uintptr_t)buf + 8) & -8);
+        const uint64_a *e = (uint64_a *)(((uintptr_t)buf + len) & -8);
 
         for (; p + 8 <= e; p += 8) {
-            __builtin_prefetch(p + 8);
             if (t) {
                 return false;
             }
@@ -67,124 +60,112 @@ buffer_zero_int(const void *buf, size_t len)
 #if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
 #include <immintrin.h>
 
-/* Note that each of these vectorized functions require len >= 64.  */
+/* Prevent the compiler from reassociating
+   a chain of similar operations.  */
+#define SSE_REASSOC_BARRIER(a, b) asm("" : "+x"(a), "+x"(b))
+
+/* Note that each of these vectorized functions require len >= 256.  */
 
 static bool __attribute__((target("sse2")))
 buffer_zero_sse2(const void *buf, size_t len)
 {
-    __m128i t = _mm_loadu_si128(buf);
-    __m128i *p = (__m128i *)(((uintptr_t)buf + 5 * 16) & -16);
-    __m128i *e = (__m128i *)(((uintptr_t)buf + len) & -16);
-    __m128i zero = _mm_setzero_si128();
+    /* Begin with an unaligned head and tail of 16 bytes.  */
+    __m128i t = *(__m128i_u *)buf;
+    __m128i t2 = *(__m128i_u *)(buf + len - 16);
+    const __m128i *p = (__m128i *)(((uintptr_t)buf + 16) & -16);
+    const __m128i *e = (__m128i *)(((uintptr_t)buf + len) & -16);
+    __m128i zero = { 0 };
 
-    /* Loop over 16-byte aligned blocks of 64.  */
-    while (likely(p <= e)) {
-        __builtin_prefetch(p);
+    /* Proceed with an aligned tail.  */
+    t2 |= e[-7];
+    t |= e[-6];
+    /* Use the barrier to ensure two independent chains.  */
+    SSE_REASSOC_BARRIER(t, t2);
+    t2 |= e[-5];
+    t |= e[-4];
+    SSE_REASSOC_BARRIER(t, t2);
+    t2 |= e[-3];
+    t |= e[-2];
+    SSE_REASSOC_BARRIER(t, t2);
+    t2 |= e[-1];
+    t |= t2;
+
+    /* Loop over 16-byte aligned blocks of 128.  */
+    while (likely(p < e - 7)) {
         t = _mm_cmpeq_epi8(t, zero);
         if (unlikely(_mm_movemask_epi8(t) != 0xFFFF)) {
             return false;
         }
-        t = p[-4] | p[-3] | p[-2] | p[-1];
-        p += 4;
+        t = p[0];
+        t2 = p[1];
+        SSE_REASSOC_BARRIER(t, t2);
+        t |= p[2];
+        t2 |= p[3];
+        SSE_REASSOC_BARRIER(t, t2);
+        t |= p[4];
+        t2 |= p[5];
+        SSE_REASSOC_BARRIER(t, t2);
+        t |= p[6];
+        t2 |= p[7];
+        SSE_REASSOC_BARRIER(t, t2);
+        t |= t2;
+        p += 8;
     }
 
-    /* Finish the aligned tail.  */
-    t |= e[-3];
-    t |= e[-2];
-    t |= e[-1];
-
-    /* Finish the unaligned tail.  */
-    t |= _mm_loadu_si128(buf + len - 16);
-
     return _mm_movemask_epi8(_mm_cmpeq_epi8(t, zero)) == 0xFFFF;
 }
 
 #ifdef CONFIG_AVX2_OPT
-static bool __attribute__((target("sse4")))
-buffer_zero_sse4(const void *buf, size_t len)
-{
-    __m128i t = _mm_loadu_si128(buf);
-    __m128i *p = (__m128i *)(((uintptr_t)buf + 5 * 16) & -16);
-    __m128i *e = (__m128i *)(((uintptr_t)buf + len) & -16);
-
-    /* Loop over 16-byte aligned blocks of 64.  */
-    while (likely(p <= e)) {
-        __builtin_prefetch(p);
-        if (unlikely(!_mm_testz_si128(t, t))) {
-            return false;
-        }
-        t = p[-4] | p[-3] | p[-2] | p[-1];
-        p += 4;
-    }
-
-    /* Finish the aligned tail.  */
-    t |= e[-3];
-    t |= e[-2];
-    t |= e[-1];
-
-    /* Finish the unaligned tail.  */
-    t |= _mm_loadu_si128(buf + len - 16);
-
-    return _mm_testz_si128(t, t);
-}
 
 static bool __attribute__((target("avx2")))
 buffer_zero_avx2(const void *buf, size_t len)
 {
     /* Begin with an unaligned head of 32 bytes.  */
-    __m256i t = _mm256_loadu_si256(buf);
-    __m256i *p = (__m256i *)(((uintptr_t)buf + 5 * 32) & -32);
-    __m256i *e = (__m256i *)(((uintptr_t)buf + len) & -32);
+    __m256i t = *(__m256i_u *)buf;
+    __m256i t2 = *(__m256i_u *)(buf + len - 32);
+    const __m256i *p = (__m256i *)(((uintptr_t)buf + 32) & -32);
+    const __m256i *e = (__m256i *)(((uintptr_t)buf + len) & -32);
+    __m256i zero = { 0 };
 
-    /* Loop over 32-byte aligned blocks of 128.  */
-    while (p <= e) {
-        __builtin_prefetch(p);
-        if (unlikely(!_mm256_testz_si256(t, t))) {
+    /* Proceed with an aligned tail.  */
+    t2 |= e[-7];
+    t |= e[-6];
+    SSE_REASSOC_BARRIER(t, t2);
+    t2 |= e[-5];
+    t |= e[-4];
+    SSE_REASSOC_BARRIER(t, t2);
+    t2 |= e[-3];
+    t |= e[-2];
+    SSE_REASSOC_BARRIER(t, t2);
+    t2 |= e[-1];
+    t |= t2;
+
+    /* Loop over 32-byte aligned blocks of 256.  */
+    while (likely(p < e - 7)) {
+        t = _mm256_cmpeq_epi8(t, zero);
+        if (unlikely(_mm256_movemask_epi8(t) != 0xFFFFFFFF)) {
             return false;
         }
-        t = p[-4] | p[-3] | p[-2] | p[-1];
-        p += 4;
-    } ;
+        t = p[0];
+        t2 = p[1];
+        SSE_REASSOC_BARRIER(t, t2);
+        t |= p[2];
+        t2 |= p[3];
+        SSE_REASSOC_BARRIER(t, t2);
+        t |= p[4];
+        t2 |= p[5];
+        SSE_REASSOC_BARRIER(t, t2);
+        t |= p[6];
+        t2 |= p[7];
+        SSE_REASSOC_BARRIER(t, t2);
+        t |= t2;
+        p += 8;
+    }
 
-    /* Finish the last block of 128 unaligned.  */
-    t |= _mm256_loadu_si256(buf + len - 4 * 32);
-    t |= _mm256_loadu_si256(buf + len - 3 * 32);
-    t |= _mm256_loadu_si256(buf + len - 2 * 32);
-    t |= _mm256_loadu_si256(buf + len - 1 * 32);
-
-    return _mm256_testz_si256(t, t);
+    return _mm256_movemask_epi8(_mm256_cmpeq_epi8(t, zero)) == 0xFFFFFFFF;
 }
 #endif /* CONFIG_AVX2_OPT */
 
-#ifdef CONFIG_AVX512F_OPT
-static bool __attribute__((target("avx512f")))
-buffer_zero_avx512(const void *buf, size_t len)
-{
-    /* Begin with an unaligned head of 64 bytes.  */
-    __m512i t = _mm512_loadu_si512(buf);
-    __m512i *p = (__m512i *)(((uintptr_t)buf + 5 * 64) & -64);
-    __m512i *e = (__m512i *)(((uintptr_t)buf + len) & -64);
-
-    /* Loop over 64-byte aligned blocks of 256.  */
-    while (p <= e) {
-        __builtin_prefetch(p);
-        if (unlikely(_mm512_test_epi64_mask(t, t))) {
-            return false;
-        }
-        t = p[-4] | p[-3] | p[-2] | p[-1];
-        p += 4;
-    }
-
-    t |= _mm512_loadu_si512(buf + len - 4 * 64);
-    t |= _mm512_loadu_si512(buf + len - 3 * 64);
-    t |= _mm512_loadu_si512(buf + len - 2 * 64);
-    t |= _mm512_loadu_si512(buf + len - 1 * 64);
-
-    return !_mm512_test_epi64_mask(t, t);
-
-}
-#endif /* CONFIG_AVX512F_OPT */
-
 /*
  * Make sure that these variables are appropriately initialized when
  * SSE2 is enabled on the compiler command-line, but the compiler is
@@ -192,20 +173,17 @@ buffer_zero_avx512(const void *buf, size_t len)
  */
 #if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
 # define INIT_USED     0
-# define INIT_LENGTH   0
-# define INIT_ACCEL    buffer_zero_int
+# define INIT_ACCEL    buffer_is_zero_len_4_plus
 #else
 # ifndef __SSE2__
 #  error "ISA selection confusion"
 # endif
 # define INIT_USED     CPUINFO_SSE2
-# define INIT_LENGTH   64
 # define INIT_ACCEL    buffer_zero_sse2
 #endif
 
 static unsigned used_accel = INIT_USED;
-static unsigned length_to_accel = INIT_LENGTH;
-static bool (*buffer_accel)(const void *, size_t) = INIT_ACCEL;
+bool (*buffer_is_zero_len_256_plus)(const void *, size_t) = INIT_ACCEL;
 
 static unsigned __attribute__((noinline))
 select_accel_cpuinfo(unsigned info)
@@ -213,24 +191,18 @@ select_accel_cpuinfo(unsigned info)
     /* Array is sorted in order of algorithm preference. */
     static const struct {
         unsigned bit;
-        unsigned len;
         bool (*fn)(const void *, size_t);
     } all[] = {
-#ifdef CONFIG_AVX512F_OPT
-        { CPUINFO_AVX512F, 256, buffer_zero_avx512 },
-#endif
 #ifdef CONFIG_AVX2_OPT
-        { CPUINFO_AVX2,    128, buffer_zero_avx2 },
-        { CPUINFO_SSE4,     64, buffer_zero_sse4 },
+        { CPUINFO_AVX2,   buffer_zero_avx2 },
 #endif
-        { CPUINFO_SSE2,     64, buffer_zero_sse2 },
-        { CPUINFO_ALWAYS,    0, buffer_zero_int },
+        { CPUINFO_SSE2,   buffer_zero_sse2 },
+        { CPUINFO_ALWAYS, buffer_is_zero_len_4_plus },
     };
 
     for (unsigned i = 0; i < ARRAY_SIZE(all); ++i) {
         if (info & all[i].bit) {
-            length_to_accel = all[i].len;
-            buffer_accel = all[i].fn;
+            buffer_is_zero_len_256_plus = all[i].fn;
             return all[i].bit;
         }
     }
@@ -256,35 +228,11 @@ bool test_buffer_is_zero_next_accel(void)
     return used;
 }
 
-static bool select_accel_fn(const void *buf, size_t len)
-{
-    if (likely(len >= length_to_accel)) {
-        return buffer_accel(buf, len);
-    }
-    return buffer_zero_int(buf, len);
-}
-
 #else
-#define select_accel_fn  buffer_zero_int
+#define select_accel_fn  buffer_is_zero_len_4_plus
 bool test_buffer_is_zero_next_accel(void)
 {
     return false;
 }
 #endif
 
-/*
- * Checks if a buffer is all zeroes
- */
-bool buffer_is_zero(const void *buf, size_t len)
-{
-    if (unlikely(len == 0)) {
-        return true;
-    }
-
-    /* Fetch the beginning of the buffer while we select the accelerator.  */
-    __builtin_prefetch(buf);
-
-    /* Use an optimized zero check if possible.  Note that this also
-       includes a check for an unrolled loop over 64-bit integers.  */
-    return select_accel_fn(buf, len);
-}
-- 
2.34.1


