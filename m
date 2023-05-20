Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA11F70A926
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 18:30:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0PPq-0003aC-Gv; Sat, 20 May 2023 12:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PPo-0003Ys-Qt
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:26:44 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PPl-000352-UQ
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:26:44 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ae3ed1b08eso44072265ad.0
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684600000; x=1687192000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WcxZjIY/T80MjuA6OZ00h+5fCLAwNHjF9M1KXt4rlvU=;
 b=ftns1YCZXVXo6UzN2ClFhxIZnc+TKeKlz2IlfyDXsQ4vzrk4S8ylrmBsFrzJZpIKcW
 2O/ufe+sZHU+5XeyRtuL/NAbKBIVvMSAFJPMuLcKqgFgbMVwkM+pnMwm8gARKj7Cdo8i
 VFiR2c8mVbIQlbpXcwSGFAE6s3PsUmxaEANoF88MXDlF+7DfkGHbOCycdKp0Yx7wLLMD
 cz+aCqFe9m3MYqbPQzR9/TpAhQrxX91sYkGpvosCOPGFE97TlYn/G3/PnAeFJ1nj26ii
 IDyqbbNOWVIZ3pukwnRzVb9pmtMhrU3jfahxNaq8MMRLlCGm1rlVxp2ml54wJ/wX+hjp
 SsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684600000; x=1687192000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WcxZjIY/T80MjuA6OZ00h+5fCLAwNHjF9M1KXt4rlvU=;
 b=DehAoLg0/H6SlM2J4W5ezgV8FnpJjr/Kapmtx+eXIPdndLJtBFA7RjXtKYvjBG15sX
 vwc3g5gz3A1IcP/G6+SaWP4FXun63/NleR8VKKu79O9VgNT63LGzvNx1sINve99am1lF
 3RlCKnFOnP8vfOvi2xs/M9ZaUxdi7CbAok+sh0vX/F+X/2sw5QYeWONNdG4a7aTC1SAg
 ueNiWBIQUP5fz9SK2+YE6SOoqjPJmib8rZV6T5uYW0fURaeXBzoWH4n2kSCwcGVRPnWB
 +aErlfa3Ij1uzrPSaaC0qx4xafvLqd757xsyOiCmfaqMJ7xokmDhWWRxkyhGQMDhmSCp
 gL+g==
X-Gm-Message-State: AC+VfDyQKO1eO15LKHSeUgnfiOoK+X6b9u0V23hIoZRdjl+UneVHstPl
 1PO9zKTQckTe9FsEc19v3lqtdQedQOncl2ZX6IU=
X-Google-Smtp-Source: ACHHUZ7EqAGyZMfj1YnSLnaMnfYk2fLRApCRP3fwuMKjTTkCGVaAP9PrGKDqiOAIEWMPyoCD55lxzQ==
X-Received: by 2002:a17:902:bb16:b0:1aa:ee36:40a5 with SMTP id
 im22-20020a170902bb1600b001aaee3640a5mr5204155plb.34.1684600000535; 
 Sat, 20 May 2023 09:26:40 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:d078:d94e:cb2b:a055])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170903230c00b001a5260a6e6csm1697104plh.206.2023.05.20.09.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 09:26:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 05/27] util/bufferiszero: Use i386 host/cpuinfo.h
Date: Sat, 20 May 2023 09:26:12 -0700
Message-Id: <20230520162634.3991009-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230520162634.3991009-1-richard.henderson@linaro.org>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Use cpuinfo_init() during init_accel(), and the variable cpuinfo
during test_buffer_is_zero_next_accel().  Adjust the logic that
cycles through the set of accelerators for testing.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/bufferiszero.c | 126 ++++++++++++++++----------------------------
 1 file changed, 45 insertions(+), 81 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 1886bc5ba4..d3c14320ef 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/bswap.h"
+#include "host/cpuinfo.h"
 
 static bool
 buffer_zero_int(const void *buf, size_t len)
@@ -184,111 +185,74 @@ buffer_zero_avx512(const void *buf, size_t len)
 }
 #endif /* CONFIG_AVX512F_OPT */
 
-
-/* Note that for test_buffer_is_zero_next_accel, the most preferred
- * ISA must have the least significant bit.
- */
-#define CACHE_AVX512F 1
-#define CACHE_AVX2    2
-#define CACHE_SSE4    4
-#define CACHE_SSE2    8
-
-/* Make sure that these variables are appropriately initialized when
+/*
+ * Make sure that these variables are appropriately initialized when
  * SSE2 is enabled on the compiler command-line, but the compiler is
  * too old to support CONFIG_AVX2_OPT.
  */
 #if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
-# define INIT_CACHE 0
-# define INIT_ACCEL buffer_zero_int
+# define INIT_USED     0
+# define INIT_LENGTH   0
+# define INIT_ACCEL    buffer_zero_int
 #else
 # ifndef __SSE2__
 #  error "ISA selection confusion"
 # endif
-# define INIT_CACHE CACHE_SSE2
-# define INIT_ACCEL buffer_zero_sse2
+# define INIT_USED     CPUINFO_SSE2
+# define INIT_LENGTH   64
+# define INIT_ACCEL    buffer_zero_sse2
 #endif
 
-static unsigned cpuid_cache = INIT_CACHE;
+static unsigned used_accel = INIT_USED;
+static unsigned length_to_accel = INIT_LENGTH;
 static bool (*buffer_accel)(const void *, size_t) = INIT_ACCEL;
-static int length_to_accel = 64;
 
-static void init_accel(unsigned cache)
+static unsigned __attribute__((noinline))
+select_accel_cpuinfo(unsigned info)
 {
-    bool (*fn)(const void *, size_t) = buffer_zero_int;
-    if (cache & CACHE_SSE2) {
-        fn = buffer_zero_sse2;
-        length_to_accel = 64;
-    }
-#ifdef CONFIG_AVX2_OPT
-    if (cache & CACHE_SSE4) {
-        fn = buffer_zero_sse4;
-        length_to_accel = 64;
-    }
-    if (cache & CACHE_AVX2) {
-        fn = buffer_zero_avx2;
-        length_to_accel = 128;
-    }
-#endif
+    static const struct {
+        unsigned bit;
+        unsigned len;
+        bool (*fn)(const void *, size_t);
+    } all[] = {
 #ifdef CONFIG_AVX512F_OPT
-    if (cache & CACHE_AVX512F) {
-        fn = buffer_zero_avx512;
-        length_to_accel = 256;
-    }
+        { CPUINFO_AVX512F, 256, buffer_zero_avx512 },
 #endif
-    buffer_accel = fn;
+#ifdef CONFIG_AVX2_OPT
+        { CPUINFO_AVX2,    128, buffer_zero_avx2 },
+        { CPUINFO_SSE4,     64, buffer_zero_sse4 },
+#endif
+        { CPUINFO_SSE2,     64, buffer_zero_sse2 },
+        { CPUINFO_ALWAYS,    0, buffer_zero_int },
+    };
+
+    for (unsigned i = 0; i < ARRAY_SIZE(all); ++i) {
+        if (info & all[i].bit) {
+            length_to_accel = all[i].len;
+            buffer_accel = all[i].fn;
+            return all[i].bit;
+        }
+    }
+    return 0;
 }
 
 #if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
-#include "qemu/cpuid.h"
-
-static void __attribute__((constructor)) init_cpuid_cache(void)
+static void __attribute__((constructor)) init_accel(void)
 {
-    unsigned max = __get_cpuid_max(0, NULL);
-    int a, b, c, d;
-    unsigned cache = 0;
-
-    if (max >= 1) {
-        __cpuid(1, a, b, c, d);
-        if (d & bit_SSE2) {
-            cache |= CACHE_SSE2;
-        }
-        if (c & bit_SSE4_1) {
-            cache |= CACHE_SSE4;
-        }
-
-        /* We must check that AVX is not just available, but usable.  */
-        if ((c & bit_OSXSAVE) && (c & bit_AVX) && max >= 7) {
-            unsigned bv = xgetbv_low(0);
-            __cpuid_count(7, 0, a, b, c, d);
-            if ((bv & 0x6) == 0x6 && (b & bit_AVX2)) {
-                cache |= CACHE_AVX2;
-            }
-            /* 0xe6:
-            *  XCR0[7:5] = 111b (OPMASK state, upper 256-bit of ZMM0-ZMM15
-            *                    and ZMM16-ZMM31 state are enabled by OS)
-            *  XCR0[2:1] = 11b (XMM state and YMM state are enabled by OS)
-            */
-            if ((bv & 0xe6) == 0xe6 && (b & bit_AVX512F)) {
-                cache |= CACHE_AVX512F;
-            }
-        }
-    }
-    cpuid_cache = cache;
-    init_accel(cache);
+    used_accel = select_accel_cpuinfo(cpuinfo_init());
 }
 #endif /* CONFIG_AVX2_OPT */
 
 bool test_buffer_is_zero_next_accel(void)
 {
-    /* If no bits set, we just tested buffer_zero_int, and there
-       are no more acceleration options to test.  */
-    if (cpuid_cache == 0) {
-        return false;
-    }
-    /* Disable the accelerator we used before and select a new one.  */
-    cpuid_cache &= cpuid_cache - 1;
-    init_accel(cpuid_cache);
-    return true;
+    /*
+     * Accumulate the accelerators that we've already tested, and
+     * remove them from the set to test this round.  We'll get back
+     * a zero from select_accel_cpuinfo when there are no more.
+     */
+    unsigned used = select_accel_cpuinfo(cpuinfo & ~used_accel);
+    used_accel |= used;
+    return used;
 }
 
 static bool select_accel_fn(const void *buf, size_t len)
-- 
2.34.1


