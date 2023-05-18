Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63593707937
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 06:42:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzVSA-0006An-Gy; Thu, 18 May 2023 00:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzVS7-0006AL-Mg
 for qemu-devel@nongnu.org; Thu, 18 May 2023 00:41:23 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzVRs-00078x-Bi
 for qemu-devel@nongnu.org; Thu, 18 May 2023 00:41:19 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ab032d9266so17109735ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 21:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684384867; x=1686976867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JODVRTQ4r29pt3fg+MkOslUd/IIiYE6j2BX9EScRpR0=;
 b=xWo0wtLyLTTCGtlPFPqidLHeKNxxc2rENEsguhWoHOTSpnMkLoRr8zadFsBnmKONnr
 CaLEllBxcQTr0Np0rqkCx5YcFSI7P8MAPJGQRuEXRVw2R+zzXkP+/J/qhOyPn6kxiPLA
 NRC8YoFmjo6dAcge0alLFgtU2ifI31qGIgV9TV99dMMqiOt97IzByOelq6CAl+2gsk0L
 EslmFq/o48ahPL1hf19UY0S+UGeYu/R1VbzaWDysgIvDgQHVnqQPt4Y87BOZyf7LHnSi
 ULOgVWaIoW8c0XH52KMoKUMQhYGikLSGMs7sBEgHfKFC/NkbLjo5hhWsv6nyTQG5TC5Q
 1cGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684384867; x=1686976867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JODVRTQ4r29pt3fg+MkOslUd/IIiYE6j2BX9EScRpR0=;
 b=CSASy/eeOUt2lRubD/d5/WUDzacrYDHax5gjrDbwOf0boVa+HJ7xc31HSyf4K6bUEL
 xlONeUIJI2P6MtKSG0TYDpg5EgcO5bwH2kG/0c2E+1uoZXbnLDSWSRm7N0og21ouDofY
 leDir40AGMJAfahFypDnHbIw4BJzkkGXAYKEEkr/DKAXfeXFC+UU6mkk0zDySp03nGQM
 ofawVtWsE+s9C//hce9waUhnYkk9hBnloaq/aZy3P5ZO73IIfX832dLUT+BR3L075uBM
 LISmWZmDBCkBe5uiMvEWeIfysTjOKfi82eKuE8Pzhd6rqxS6RL/970TF2TQkf7BBQ86r
 cHqQ==
X-Gm-Message-State: AC+VfDzouMWTMGloya3LFS9eQv8avLejfFirzjZGAunQCy/JpyOnt1bp
 MAQ+SNlO2EP/vnQhrFoidN9ZwPaIZy23rev46No=
X-Google-Smtp-Source: ACHHUZ6sF3OufIiPm5U6iw7wst+V19Ag6J1jYJ9hFsPSMzwN8LrOQa6z+tMuppKlZW7ktcePzJkDSg==
X-Received: by 2002:a17:902:8347:b0:19a:9890:eac6 with SMTP id
 z7-20020a170902834700b0019a9890eac6mr1107805pln.24.1684384867013; 
 Wed, 17 May 2023 21:41:07 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a170902e84900b001ab1d23bf5dsm225592plg.258.2023.05.17.21.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 21:41:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 7/9] migration/xbzrle: Use i386 cacheinfo.h
Date: Wed, 17 May 2023 21:40:56 -0700
Message-Id: <20230518044058.2777467-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518044058.2777467-1-richard.henderson@linaro.org>
References: <20230518044058.2777467-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Perform the function selection once, and only if CONFIG_AVX512_OPT
is enabled.  Centralize the selection to xbzrle.c, instead of
spreading the init across 3 files.

Remove xbzrle-bench.c.  The benefit of being able to benchmark
the different implementations is less important than peeking into
the internals of the implementation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Cc: Juan Quintela <quintela@redhat.com> 
Cc: Peter Xu <peterx@redhat.com> 
Cc: Leonardo Bras <leobras@redhat.com> 
---
 migration/xbzrle.h         |   5 +-
 migration/ram.c            |  34 +--
 migration/xbzrle.c         |  26 +-
 tests/bench/xbzrle-bench.c | 469 -------------------------------------
 tests/unit/test-xbzrle.c   |  49 +---
 tests/bench/meson.build    |   6 -
 6 files changed, 39 insertions(+), 550 deletions(-)
 delete mode 100644 tests/bench/xbzrle-bench.c

diff --git a/migration/xbzrle.h b/migration/xbzrle.h
index 6feb49160a..39e651b9ec 100644
--- a/migration/xbzrle.h
+++ b/migration/xbzrle.h
@@ -18,8 +18,5 @@ int xbzrle_encode_buffer(uint8_t *old_buf, uint8_t *new_buf, int slen,
                          uint8_t *dst, int dlen);
 
 int xbzrle_decode_buffer(uint8_t *src, int slen, uint8_t *dst, int dlen);
-#if defined(CONFIG_AVX512BW_OPT)
-int xbzrle_encode_buffer_avx512(uint8_t *old_buf, uint8_t *new_buf, int slen,
-                                uint8_t *dst, int dlen);
-#endif
+
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index f69d8d42b0..f9e35a45e1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -90,34 +90,6 @@
 #define RAM_SAVE_FLAG_MULTIFD_FLUSH    0x200
 /* We can't use any flag that is bigger than 0x200 */
 
-int (*xbzrle_encode_buffer_func)(uint8_t *, uint8_t *, int,
-     uint8_t *, int) = xbzrle_encode_buffer;
-#if defined(CONFIG_AVX512BW_OPT)
-#include "qemu/cpuid.h"
-static void __attribute__((constructor)) init_cpu_flag(void)
-{
-    unsigned max = __get_cpuid_max(0, NULL);
-    int a, b, c, d;
-    if (max >= 1) {
-        __cpuid(1, a, b, c, d);
-         /* We must check that AVX is not just available, but usable.  */
-        if ((c & bit_OSXSAVE) && (c & bit_AVX) && max >= 7) {
-            int bv;
-            __asm("xgetbv" : "=a"(bv), "=d"(d) : "c"(0));
-            __cpuid_count(7, 0, a, b, c, d);
-           /* 0xe6:
-            *  XCR0[7:5] = 111b (OPMASK state, upper 256-bit of ZMM0-ZMM15
-            *                    and ZMM16-ZMM31 state are enabled by OS)
-            *  XCR0[2:1] = 11b (XMM state and YMM state are enabled by OS)
-            */
-            if ((bv & 0xe6) == 0xe6 && (b & bit_AVX512BW)) {
-                xbzrle_encode_buffer_func = xbzrle_encode_buffer_avx512;
-            }
-        }
-    }
-}
-#endif
-
 XBZRLECacheStats xbzrle_counters;
 
 /* used by the search for pages to send */
@@ -660,9 +632,9 @@ static int save_xbzrle_page(RAMState *rs, PageSearchStatus *pss,
     memcpy(XBZRLE.current_buf, *current_data, TARGET_PAGE_SIZE);
 
     /* XBZRLE encoding (if there is no overflow) */
-    encoded_len = xbzrle_encode_buffer_func(prev_cached_page, XBZRLE.current_buf,
-                                            TARGET_PAGE_SIZE, XBZRLE.encoded_buf,
-                                            TARGET_PAGE_SIZE);
+    encoded_len = xbzrle_encode_buffer(prev_cached_page, XBZRLE.current_buf,
+                                       TARGET_PAGE_SIZE, XBZRLE.encoded_buf,
+                                       TARGET_PAGE_SIZE);
 
     /*
      * Update the cache contents, so that it corresponds to the data
diff --git a/migration/xbzrle.c b/migration/xbzrle.c
index 751b5428f7..57da6f4c96 100644
--- a/migration/xbzrle.c
+++ b/migration/xbzrle.c
@@ -17,8 +17,9 @@
 
 #if defined(CONFIG_AVX512BW_OPT)
 #include <immintrin.h>
+#include "cpuinfo.h"
 
-int __attribute__((target("avx512bw")))
+static int __attribute__((target("avx512bw")))
 xbzrle_encode_buffer_avx512(uint8_t *old_buf, uint8_t *new_buf, int slen,
                             uint8_t *dst, int dlen)
 {
@@ -135,6 +136,29 @@ xbzrle_encode_buffer_avx512(uint8_t *old_buf, uint8_t *new_buf, int slen,
     }
     return d;
 }
+
+static int xbzrle_encode_buffer_int(uint8_t *old_buf, uint8_t *new_buf,
+                                    int slen, uint8_t *dst, int dlen);
+
+static int (*accel_func)(uint8_t *, uint8_t *, int, uint8_t *, int);
+
+static void __attribute__((constructor)) init_accel(void)
+{
+    unsigned info = cpuinfo_init();
+    if (info & CPUINFO_AVX512BW) {
+        accel_func = xbzrle_encode_buffer_avx512;
+    } else {
+        accel_func = xbzrle_encode_buffer_int;
+    }
+}
+
+int xbzrle_encode_buffer(uint8_t *old_buf, uint8_t *new_buf, int slen,
+                         uint8_t *dst, int dlen)
+{
+    return accel_func(old_buf, new_buf, slen, dst, dlen);
+}
+
+#define xbzrle_encode_buffer xbzrle_encode_buffer_int
 #endif
 
 /*
diff --git a/tests/bench/xbzrle-bench.c b/tests/bench/xbzrle-bench.c
deleted file mode 100644
index 8848a3a32d..0000000000
--- a/tests/bench/xbzrle-bench.c
+++ /dev/null
@@ -1,469 +0,0 @@
-/*
- * Xor Based Zero Run Length Encoding unit tests.
- *
- * Copyright 2013 Red Hat, Inc. and/or its affiliates
- *
- * Authors:
- *  Orit Wasserman  <owasserm@redhat.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-#include "qemu/osdep.h"
-#include "qemu/cutils.h"
-#include "../migration/xbzrle.h"
-
-#if defined(CONFIG_AVX512BW_OPT)
-#define XBZRLE_PAGE_SIZE 4096
-static bool is_cpu_support_avx512bw;
-#include "qemu/cpuid.h"
-static void __attribute__((constructor)) init_cpu_flag(void)
-{
-    unsigned max = __get_cpuid_max(0, NULL);
-    int a, b, c, d;
-    is_cpu_support_avx512bw = false;
-    if (max >= 1) {
-        __cpuid(1, a, b, c, d);
-         /* We must check that AVX is not just available, but usable.  */
-        if ((c & bit_OSXSAVE) && (c & bit_AVX) && max >= 7) {
-            int bv;
-            __asm("xgetbv" : "=a"(bv), "=d"(d) : "c"(0));
-            __cpuid_count(7, 0, a, b, c, d);
-           /* 0xe6:
-            *  XCR0[7:5] = 111b (OPMASK state, upper 256-bit of ZMM0-ZMM15
-            *                    and ZMM16-ZMM31 state are enabled by OS)
-            *  XCR0[2:1] = 11b (XMM state and YMM state are enabled by OS)
-            */
-            if ((bv & 0xe6) == 0xe6 && (b & bit_AVX512BW)) {
-                is_cpu_support_avx512bw = true;
-            }
-        }
-    }
-    return ;
-}
-
-struct ResTime {
-    float t_raw;
-    float t_512;
-};
-
-
-/* Function prototypes
-int xbzrle_encode_buffer_avx512(uint8_t *old_buf, uint8_t *new_buf, int slen,
-                                uint8_t *dst, int dlen);
-*/
-static void encode_decode_zero(struct ResTime *res)
-{
-    uint8_t *buffer = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *compressed = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *buffer512 = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *compressed512 = g_malloc0(XBZRLE_PAGE_SIZE);
-    int i = 0;
-    int dlen = 0, dlen512 = 0;
-    int diff_len = g_test_rand_int_range(0, XBZRLE_PAGE_SIZE - 1006);
-
-    for (i = diff_len; i > 0; i--) {
-        buffer[1000 + i] = i;
-        buffer512[1000 + i] = i;
-    }
-
-    buffer[1000 + diff_len + 3] = 103;
-    buffer[1000 + diff_len + 5] = 105;
-
-    buffer512[1000 + diff_len + 3] = 103;
-    buffer512[1000 + diff_len + 5] = 105;
-
-    /* encode zero page */
-    time_t t_start, t_end, t_start512, t_end512;
-    t_start = clock();
-    dlen = xbzrle_encode_buffer(buffer, buffer, XBZRLE_PAGE_SIZE, compressed,
-                       XBZRLE_PAGE_SIZE);
-    t_end = clock();
-    float time_val = difftime(t_end, t_start);
-    g_assert(dlen == 0);
-
-    t_start512 = clock();
-    dlen512 = xbzrle_encode_buffer_avx512(buffer512, buffer512, XBZRLE_PAGE_SIZE,
-                                       compressed512, XBZRLE_PAGE_SIZE);
-    t_end512 = clock();
-    float time_val512 = difftime(t_end512, t_start512);
-    g_assert(dlen512 == 0);
-
-    res->t_raw = time_val;
-    res->t_512 = time_val512;
-
-    g_free(buffer);
-    g_free(compressed);
-    g_free(buffer512);
-    g_free(compressed512);
-
-}
-
-static void test_encode_decode_zero_avx512(void)
-{
-    int i;
-    float time_raw = 0.0, time_512 = 0.0;
-    struct ResTime res;
-    for (i = 0; i < 10000; i++) {
-        encode_decode_zero(&res);
-        time_raw += res.t_raw;
-        time_512 += res.t_512;
-    }
-    printf("Zero test:\n");
-    printf("Raw xbzrle_encode time is %f ms\n", time_raw);
-    printf("512 xbzrle_encode time is %f ms\n", time_512);
-}
-
-static void encode_decode_unchanged(struct ResTime *res)
-{
-    uint8_t *compressed = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *test = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *compressed512 = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *test512 = g_malloc0(XBZRLE_PAGE_SIZE);
-    int i = 0;
-    int dlen = 0, dlen512 = 0;
-    int diff_len = g_test_rand_int_range(0, XBZRLE_PAGE_SIZE - 1006);
-
-    for (i = diff_len; i > 0; i--) {
-        test[1000 + i] = i + 4;
-        test512[1000 + i] = i + 4;
-    }
-
-    test[1000 + diff_len + 3] = 107;
-    test[1000 + diff_len + 5] = 109;
-
-    test512[1000 + diff_len + 3] = 107;
-    test512[1000 + diff_len + 5] = 109;
-
-    /* test unchanged buffer */
-    time_t t_start, t_end, t_start512, t_end512;
-    t_start = clock();
-    dlen = xbzrle_encode_buffer(test, test, XBZRLE_PAGE_SIZE, compressed,
-                                XBZRLE_PAGE_SIZE);
-    t_end = clock();
-    float time_val = difftime(t_end, t_start);
-    g_assert(dlen == 0);
-
-    t_start512 = clock();
-    dlen512 = xbzrle_encode_buffer_avx512(test512, test512, XBZRLE_PAGE_SIZE,
-                                       compressed512, XBZRLE_PAGE_SIZE);
-    t_end512 = clock();
-    float time_val512 = difftime(t_end512, t_start512);
-    g_assert(dlen512 == 0);
-
-    res->t_raw = time_val;
-    res->t_512 = time_val512;
-
-    g_free(test);
-    g_free(compressed);
-    g_free(test512);
-    g_free(compressed512);
-
-}
-
-static void test_encode_decode_unchanged_avx512(void)
-{
-    int i;
-    float time_raw = 0.0, time_512 = 0.0;
-    struct ResTime res;
-    for (i = 0; i < 10000; i++) {
-        encode_decode_unchanged(&res);
-        time_raw += res.t_raw;
-        time_512 += res.t_512;
-    }
-    printf("Unchanged test:\n");
-    printf("Raw xbzrle_encode time is %f ms\n", time_raw);
-    printf("512 xbzrle_encode time is %f ms\n", time_512);
-}
-
-static void encode_decode_1_byte(struct ResTime *res)
-{
-    uint8_t *buffer = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *test = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *compressed = g_malloc(XBZRLE_PAGE_SIZE);
-    uint8_t *buffer512 = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *test512 = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *compressed512 = g_malloc(XBZRLE_PAGE_SIZE);
-    int dlen = 0, rc = 0, dlen512 = 0, rc512 = 0;
-    uint8_t buf[2];
-    uint8_t buf512[2];
-
-    test[XBZRLE_PAGE_SIZE - 1] = 1;
-    test512[XBZRLE_PAGE_SIZE - 1] = 1;
-
-    time_t t_start, t_end, t_start512, t_end512;
-    t_start = clock();
-    dlen = xbzrle_encode_buffer(buffer, test, XBZRLE_PAGE_SIZE, compressed,
-                       XBZRLE_PAGE_SIZE);
-    t_end = clock();
-    float time_val = difftime(t_end, t_start);
-    g_assert(dlen == (uleb128_encode_small(&buf[0], 4095) + 2));
-
-    rc = xbzrle_decode_buffer(compressed, dlen, buffer, XBZRLE_PAGE_SIZE);
-    g_assert(rc == XBZRLE_PAGE_SIZE);
-    g_assert(memcmp(test, buffer, XBZRLE_PAGE_SIZE) == 0);
-
-    t_start512 = clock();
-    dlen512 = xbzrle_encode_buffer_avx512(buffer512, test512, XBZRLE_PAGE_SIZE,
-                                       compressed512, XBZRLE_PAGE_SIZE);
-    t_end512 = clock();
-    float time_val512 = difftime(t_end512, t_start512);
-    g_assert(dlen512 == (uleb128_encode_small(&buf512[0], 4095) + 2));
-
-    rc512 = xbzrle_decode_buffer(compressed512, dlen512, buffer512,
-                                 XBZRLE_PAGE_SIZE);
-    g_assert(rc512 == XBZRLE_PAGE_SIZE);
-    g_assert(memcmp(test512, buffer512, XBZRLE_PAGE_SIZE) == 0);
-
-    res->t_raw = time_val;
-    res->t_512 = time_val512;
-
-    g_free(buffer);
-    g_free(compressed);
-    g_free(test);
-    g_free(buffer512);
-    g_free(compressed512);
-    g_free(test512);
-
-}
-
-static void test_encode_decode_1_byte_avx512(void)
-{
-    int i;
-    float time_raw = 0.0, time_512 = 0.0;
-    struct ResTime res;
-    for (i = 0; i < 10000; i++) {
-        encode_decode_1_byte(&res);
-        time_raw += res.t_raw;
-        time_512 += res.t_512;
-    }
-    printf("1 byte test:\n");
-    printf("Raw xbzrle_encode time is %f ms\n", time_raw);
-    printf("512 xbzrle_encode time is %f ms\n", time_512);
-}
-
-static void encode_decode_overflow(struct ResTime *res)
-{
-    uint8_t *compressed = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *test = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *buffer = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *compressed512 = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *test512 = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *buffer512 = g_malloc0(XBZRLE_PAGE_SIZE);
-    int i = 0, rc = 0, rc512 = 0;
-
-    for (i = 0; i < XBZRLE_PAGE_SIZE / 2 - 1; i++) {
-        test[i * 2] = 1;
-        test512[i * 2] = 1;
-    }
-
-    /* encode overflow */
-    time_t t_start, t_end, t_start512, t_end512;
-    t_start = clock();
-    rc = xbzrle_encode_buffer(buffer, test, XBZRLE_PAGE_SIZE, compressed,
-                              XBZRLE_PAGE_SIZE);
-    t_end = clock();
-    float time_val = difftime(t_end, t_start);
-    g_assert(rc == -1);
-
-    t_start512 = clock();
-    rc512 = xbzrle_encode_buffer_avx512(buffer512, test512, XBZRLE_PAGE_SIZE,
-                                     compressed512, XBZRLE_PAGE_SIZE);
-    t_end512 = clock();
-    float time_val512 = difftime(t_end512, t_start512);
-    g_assert(rc512 == -1);
-
-    res->t_raw = time_val;
-    res->t_512 = time_val512;
-
-    g_free(buffer);
-    g_free(compressed);
-    g_free(test);
-    g_free(buffer512);
-    g_free(compressed512);
-    g_free(test512);
-
-}
-
-static void test_encode_decode_overflow_avx512(void)
-{
-    int i;
-    float time_raw = 0.0, time_512 = 0.0;
-    struct ResTime res;
-    for (i = 0; i < 10000; i++) {
-        encode_decode_overflow(&res);
-        time_raw += res.t_raw;
-        time_512 += res.t_512;
-    }
-    printf("Overflow test:\n");
-    printf("Raw xbzrle_encode time is %f ms\n", time_raw);
-    printf("512 xbzrle_encode time is %f ms\n", time_512);
-}
-
-static void encode_decode_range_avx512(struct ResTime *res)
-{
-    uint8_t *buffer = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *compressed = g_malloc(XBZRLE_PAGE_SIZE);
-    uint8_t *test = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *buffer512 = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *compressed512 = g_malloc(XBZRLE_PAGE_SIZE);
-    uint8_t *test512 = g_malloc0(XBZRLE_PAGE_SIZE);
-    int i = 0, rc = 0, rc512 = 0;
-    int dlen = 0, dlen512 = 0;
-
-    int diff_len = g_test_rand_int_range(0, XBZRLE_PAGE_SIZE - 1006);
-
-    for (i = diff_len; i > 0; i--) {
-        buffer[1000 + i] = i;
-        test[1000 + i] = i + 4;
-        buffer512[1000 + i] = i;
-        test512[1000 + i] = i + 4;
-    }
-
-    buffer[1000 + diff_len + 3] = 103;
-    test[1000 + diff_len + 3] = 107;
-
-    buffer[1000 + diff_len + 5] = 105;
-    test[1000 + diff_len + 5] = 109;
-
-    buffer512[1000 + diff_len + 3] = 103;
-    test512[1000 + diff_len + 3] = 107;
-
-    buffer512[1000 + diff_len + 5] = 105;
-    test512[1000 + diff_len + 5] = 109;
-
-    /* test encode/decode */
-    time_t t_start, t_end, t_start512, t_end512;
-    t_start = clock();
-    dlen = xbzrle_encode_buffer(test, buffer, XBZRLE_PAGE_SIZE, compressed,
-                                XBZRLE_PAGE_SIZE);
-    t_end = clock();
-    float time_val = difftime(t_end, t_start);
-    rc = xbzrle_decode_buffer(compressed, dlen, test, XBZRLE_PAGE_SIZE);
-    g_assert(rc < XBZRLE_PAGE_SIZE);
-    g_assert(memcmp(test, buffer, XBZRLE_PAGE_SIZE) == 0);
-
-    t_start512 = clock();
-    dlen512 = xbzrle_encode_buffer_avx512(test512, buffer512, XBZRLE_PAGE_SIZE,
-                                       compressed512, XBZRLE_PAGE_SIZE);
-    t_end512 = clock();
-    float time_val512 = difftime(t_end512, t_start512);
-    rc512 = xbzrle_decode_buffer(compressed512, dlen512, test512, XBZRLE_PAGE_SIZE);
-    g_assert(rc512 < XBZRLE_PAGE_SIZE);
-    g_assert(memcmp(test512, buffer512, XBZRLE_PAGE_SIZE) == 0);
-
-    res->t_raw = time_val;
-    res->t_512 = time_val512;
-
-    g_free(buffer);
-    g_free(compressed);
-    g_free(test);
-    g_free(buffer512);
-    g_free(compressed512);
-    g_free(test512);
-
-}
-
-static void test_encode_decode_avx512(void)
-{
-    int i;
-    float time_raw = 0.0, time_512 = 0.0;
-    struct ResTime res;
-    for (i = 0; i < 10000; i++) {
-        encode_decode_range_avx512(&res);
-        time_raw += res.t_raw;
-        time_512 += res.t_512;
-    }
-    printf("Encode decode test:\n");
-    printf("Raw xbzrle_encode time is %f ms\n", time_raw);
-    printf("512 xbzrle_encode time is %f ms\n", time_512);
-}
-
-static void encode_decode_random(struct ResTime *res)
-{
-    uint8_t *buffer = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *compressed = g_malloc(XBZRLE_PAGE_SIZE);
-    uint8_t *test = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *buffer512 = g_malloc0(XBZRLE_PAGE_SIZE);
-    uint8_t *compressed512 = g_malloc(XBZRLE_PAGE_SIZE);
-    uint8_t *test512 = g_malloc0(XBZRLE_PAGE_SIZE);
-    int i = 0, rc = 0, rc512 = 0;
-    int dlen = 0, dlen512 = 0;
-
-    int diff_len = g_test_rand_int_range(0, XBZRLE_PAGE_SIZE - 1);
-    /* store the index of diff */
-    int dirty_index[diff_len];
-    for (int j = 0; j < diff_len; j++) {
-        dirty_index[j] = g_test_rand_int_range(0, XBZRLE_PAGE_SIZE - 1);
-    }
-    for (i = diff_len - 1; i >= 0; i--) {
-        buffer[dirty_index[i]] = i;
-        test[dirty_index[i]] = i + 4;
-        buffer512[dirty_index[i]] = i;
-        test512[dirty_index[i]] = i + 4;
-    }
-
-    time_t t_start, t_end, t_start512, t_end512;
-    t_start = clock();
-    dlen = xbzrle_encode_buffer(test, buffer, XBZRLE_PAGE_SIZE, compressed,
-                                XBZRLE_PAGE_SIZE);
-    t_end = clock();
-    float time_val = difftime(t_end, t_start);
-    rc = xbzrle_decode_buffer(compressed, dlen, test, XBZRLE_PAGE_SIZE);
-    g_assert(rc < XBZRLE_PAGE_SIZE);
-
-    t_start512 = clock();
-    dlen512 = xbzrle_encode_buffer_avx512(test512, buffer512, XBZRLE_PAGE_SIZE,
-                                       compressed512, XBZRLE_PAGE_SIZE);
-    t_end512 = clock();
-    float time_val512 = difftime(t_end512, t_start512);
-    rc512 = xbzrle_decode_buffer(compressed512, dlen512, test512, XBZRLE_PAGE_SIZE);
-    g_assert(rc512 < XBZRLE_PAGE_SIZE);
-
-    res->t_raw = time_val;
-    res->t_512 = time_val512;
-
-    g_free(buffer);
-    g_free(compressed);
-    g_free(test);
-    g_free(buffer512);
-    g_free(compressed512);
-    g_free(test512);
-
-}
-
-static void test_encode_decode_random_avx512(void)
-{
-    int i;
-    float time_raw = 0.0, time_512 = 0.0;
-    struct ResTime res;
-    for (i = 0; i < 10000; i++) {
-        encode_decode_random(&res);
-        time_raw += res.t_raw;
-        time_512 += res.t_512;
-    }
-    printf("Random test:\n");
-    printf("Raw xbzrle_encode time is %f ms\n", time_raw);
-    printf("512 xbzrle_encode time is %f ms\n", time_512);
-}
-#endif
-
-int main(int argc, char **argv)
-{
-    g_test_init(&argc, &argv, NULL);
-    g_test_rand_int();
-    #if defined(CONFIG_AVX512BW_OPT)
-    if (likely(is_cpu_support_avx512bw)) {
-        g_test_add_func("/xbzrle/encode_decode_zero", test_encode_decode_zero_avx512);
-        g_test_add_func("/xbzrle/encode_decode_unchanged",
-                        test_encode_decode_unchanged_avx512);
-        g_test_add_func("/xbzrle/encode_decode_1_byte", test_encode_decode_1_byte_avx512);
-        g_test_add_func("/xbzrle/encode_decode_overflow",
-                        test_encode_decode_overflow_avx512);
-        g_test_add_func("/xbzrle/encode_decode", test_encode_decode_avx512);
-        g_test_add_func("/xbzrle/encode_decode_random", test_encode_decode_random_avx512);
-    }
-    #endif
-    return g_test_run();
-}
diff --git a/tests/unit/test-xbzrle.c b/tests/unit/test-xbzrle.c
index 547046d093..b6996de69a 100644
--- a/tests/unit/test-xbzrle.c
+++ b/tests/unit/test-xbzrle.c
@@ -16,35 +16,6 @@
 
 #define XBZRLE_PAGE_SIZE 4096
 
-int (*xbzrle_encode_buffer_func)(uint8_t *, uint8_t *, int,
-     uint8_t *, int) = xbzrle_encode_buffer;
-#if defined(CONFIG_AVX512BW_OPT)
-#include "qemu/cpuid.h"
-static void __attribute__((constructor)) init_cpu_flag(void)
-{
-    unsigned max = __get_cpuid_max(0, NULL);
-    int a, b, c, d;
-    if (max >= 1) {
-        __cpuid(1, a, b, c, d);
-         /* We must check that AVX is not just available, but usable.  */
-        if ((c & bit_OSXSAVE) && (c & bit_AVX) && max >= 7) {
-            int bv;
-            __asm("xgetbv" : "=a"(bv), "=d"(d) : "c"(0));
-            __cpuid_count(7, 0, a, b, c, d);
-           /* 0xe6:
-            *  XCR0[7:5] = 111b (OPMASK state, upper 256-bit of ZMM0-ZMM15
-            *                    and ZMM16-ZMM31 state are enabled by OS)
-            *  XCR0[2:1] = 11b (XMM state and YMM state are enabled by OS)
-            */
-            if ((bv & 0xe6) == 0xe6 && (b & bit_AVX512BW)) {
-                xbzrle_encode_buffer_func = xbzrle_encode_buffer_avx512;
-            }
-        }
-    }
-    return ;
-}
-#endif
-
 static void test_uleb(void)
 {
     uint32_t i, val;
@@ -83,8 +54,8 @@ static void test_encode_decode_zero(void)
     buffer[1000 + diff_len + 5] = 105;
 
     /* encode zero page */
-    dlen = xbzrle_encode_buffer_func(buffer, buffer, XBZRLE_PAGE_SIZE, compressed,
-                       XBZRLE_PAGE_SIZE);
+    dlen = xbzrle_encode_buffer(buffer, buffer, XBZRLE_PAGE_SIZE,
+                                compressed, XBZRLE_PAGE_SIZE);
     g_assert(dlen == 0);
 
     g_free(buffer);
@@ -107,8 +78,8 @@ static void test_encode_decode_unchanged(void)
     test[1000 + diff_len + 5] = 109;
 
     /* test unchanged buffer */
-    dlen = xbzrle_encode_buffer_func(test, test, XBZRLE_PAGE_SIZE, compressed,
-                                XBZRLE_PAGE_SIZE);
+    dlen = xbzrle_encode_buffer(test, test, XBZRLE_PAGE_SIZE,
+                                compressed, XBZRLE_PAGE_SIZE);
     g_assert(dlen == 0);
 
     g_free(test);
@@ -125,8 +96,8 @@ static void test_encode_decode_1_byte(void)
 
     test[XBZRLE_PAGE_SIZE - 1] = 1;
 
-    dlen = xbzrle_encode_buffer_func(buffer, test, XBZRLE_PAGE_SIZE, compressed,
-                       XBZRLE_PAGE_SIZE);
+    dlen = xbzrle_encode_buffer(buffer, test, XBZRLE_PAGE_SIZE,
+                                compressed, XBZRLE_PAGE_SIZE);
     g_assert(dlen == (uleb128_encode_small(&buf[0], 4095) + 2));
 
     rc = xbzrle_decode_buffer(compressed, dlen, buffer, XBZRLE_PAGE_SIZE);
@@ -150,8 +121,8 @@ static void test_encode_decode_overflow(void)
     }
 
     /* encode overflow */
-    rc = xbzrle_encode_buffer_func(buffer, test, XBZRLE_PAGE_SIZE, compressed,
-                              XBZRLE_PAGE_SIZE);
+    rc = xbzrle_encode_buffer(buffer, test, XBZRLE_PAGE_SIZE,
+                              compressed, XBZRLE_PAGE_SIZE);
     g_assert(rc == -1);
 
     g_free(buffer);
@@ -181,8 +152,8 @@ static void encode_decode_range(void)
     test[1000 + diff_len + 5] = 109;
 
     /* test encode/decode */
-    dlen = xbzrle_encode_buffer_func(test, buffer, XBZRLE_PAGE_SIZE, compressed,
-                                XBZRLE_PAGE_SIZE);
+    dlen = xbzrle_encode_buffer(test, buffer, XBZRLE_PAGE_SIZE,
+                                compressed, XBZRLE_PAGE_SIZE);
 
     rc = xbzrle_decode_buffer(compressed, dlen, test, XBZRLE_PAGE_SIZE);
     g_assert(rc < XBZRLE_PAGE_SIZE);
diff --git a/tests/bench/meson.build b/tests/bench/meson.build
index 4e6b469066..3c799dbd98 100644
--- a/tests/bench/meson.build
+++ b/tests/bench/meson.build
@@ -3,12 +3,6 @@ qht_bench = executable('qht-bench',
                        sources: 'qht-bench.c',
                        dependencies: [qemuutil])
 
-if have_system
-xbzrle_bench = executable('xbzrle-bench',
-                       sources: 'xbzrle-bench.c',
-                       dependencies: [qemuutil,migration])
-endif
-
 qtree_bench = executable('qtree-bench',
                          sources: 'qtree-bench.c',
                          dependencies: [qemuutil])
-- 
2.34.1


