Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA82970A935
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 18:31:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0PQn-0004P2-Ig; Sat, 20 May 2023 12:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQ9-0003fM-4g
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:06 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQ3-000393-1q
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:03 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64d2981e3abso1974689b3a.1
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 09:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684600015; x=1687192015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUpVnyemWEPOpO605ffDicbCJQoqq3GtxGHxc5DnjBc=;
 b=tsLk+47irudQUM9AhQj4lU+z/0Vqob39hWiHRZQyxpzh8u1vnhjsqccVnqTvXmQtRq
 Fk/cWvoflknTP0XHXU3OXgL/Eh3v47Ku4zHGmUKsfYdnWBzf/9shiPxbvcKpZnDdNIIV
 cejUNPq7T1tJ/PXUKjc6FxC4maxN6uflFA6yBp2x9rl3fsTR8zKPok0ZxOMhJabaf87n
 tTMi8cuZORfUPkfzta4LsjNe00C+uFJpfV1JMUmgJyMugNMTCfatibFW723w1K75k3hz
 a2DKv6vziKgMtcCmvdJ7l93WyWFFU5VwsJYIyR8ByIFgCrcwLTatC9uwdbEQRJfj6mf4
 L9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684600015; x=1687192015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SUpVnyemWEPOpO605ffDicbCJQoqq3GtxGHxc5DnjBc=;
 b=MxbXUaFicaVxcoGQe+x+bOLKcv17DaUMYKflV0vIEE4w0CEfpPLTDGcyUDSqj7YCUk
 /I+UN8fGQGuAk6X75ayLGp9PrPe7cQOzuNVack2jluDpxhED/tWYf/kCJOZ6pLMefc6C
 W+ts53sX/TlvNIJu9TI0/ZW92+ZCIxSiODUZ+ps5SXAV+NsA3bbg2GUsoyLY+CTEah/u
 vzedlCvrVT45EoetumK/CBPXXAmSeb5lcXi0mfkKduBKLfmtpQ36Mdw3/xh1Tkmyve0N
 Hjx355EnIqqNRcVPrVOS5Zo144EG9gopdYflsdYTOTxBMUre/6sHPNBu8okfK9tdKJOy
 0bXw==
X-Gm-Message-State: AC+VfDyk5U5IqsosNkwhLvvCzHyUdsEXurRgoc0wvFIYje8JaVBSlSML
 8iAGFWz/uJ0hxkqHQd3poUt240sgQ1wyrNK68xE=
X-Google-Smtp-Source: ACHHUZ6T3tI8kFXVbFNrVQf1T4n1QbV37EEFa8j+I86Y+ViaNe+GC18gJ+Old+d2qOsKYfzUSC7tjQ==
X-Received: by 2002:a17:902:f7d6:b0:1aa:fec9:5219 with SMTP id
 h22-20020a170902f7d600b001aafec95219mr5812680plw.61.1684600015618; 
 Sat, 20 May 2023 09:26:55 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:d078:d94e:cb2b:a055])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170903230c00b001a5260a6e6csm1697104plh.206.2023.05.20.09.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 09:26:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 11/27] include/host: Split out atomic128-ldst.h
Date: Sat, 20 May 2023 09:26:18 -0700
Message-Id: <20230520162634.3991009-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230520162634.3991009-1-richard.henderson@linaro.org>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Separates the aarch64-specific portion into its own file.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/aarch64/host/atomic128-cas.h  |  2 +-
 host/include/aarch64/host/atomic128-ldst.h | 49 ++++++++++++++
 host/include/generic/host/atomic128-ldst.h | 57 +++++++++++++++++
 include/qemu/atomic128.h                   | 74 +---------------------
 4 files changed, 108 insertions(+), 74 deletions(-)
 create mode 100644 host/include/aarch64/host/atomic128-ldst.h
 create mode 100644 host/include/generic/host/atomic128-ldst.h

diff --git a/host/include/aarch64/host/atomic128-cas.h b/host/include/aarch64/host/atomic128-cas.h
index 1247995419..33f365ce67 100644
--- a/host/include/aarch64/host/atomic128-cas.h
+++ b/host/include/aarch64/host/atomic128-cas.h
@@ -1,6 +1,6 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
- * Compare-and-swap for 128-bit atomic operations, generic version.
+ * Compare-and-swap for 128-bit atomic operations, aarch64 version.
  *
  * Copyright (C) 2018, 2023 Linaro, Ltd.
  *
diff --git a/host/include/aarch64/host/atomic128-ldst.h b/host/include/aarch64/host/atomic128-ldst.h
new file mode 100644
index 0000000000..c2e7b44bc5
--- /dev/null
+++ b/host/include/aarch64/host/atomic128-ldst.h
@@ -0,0 +1,49 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Load/store for 128-bit atomic operations, aarch64 version.
+ *
+ * Copyright (C) 2018, 2023 Linaro, Ltd.
+ *
+ * See docs/devel/atomics.rst for discussion about the guarantees each
+ * atomic primitive is meant to provide.
+ */
+
+#ifndef AARCH64_ATOMIC128_LDST_H
+#define AARCH64_ATOMIC128_LDST_H
+
+/* Through gcc 10, aarch64 has no support for 128-bit atomics.  */
+#if !defined(CONFIG_ATOMIC128) && !defined(CONFIG_USER_ONLY)
+/* We can do better than cmpxchg for AArch64.  */
+static inline Int128 atomic16_read(Int128 *ptr)
+{
+    uint64_t l, h;
+    uint32_t tmp;
+
+    /* The load must be paired with the store to guarantee not tearing.  */
+    asm("0: ldxp %[l], %[h], %[mem]\n\t"
+        "stxp %w[tmp], %[l], %[h], %[mem]\n\t"
+        "cbnz %w[tmp], 0b"
+        : [mem] "+m"(*ptr), [tmp] "=r"(tmp), [l] "=r"(l), [h] "=r"(h));
+
+    return int128_make128(l, h);
+}
+
+static inline void atomic16_set(Int128 *ptr, Int128 val)
+{
+    uint64_t l = int128_getlo(val), h = int128_gethi(val);
+    uint64_t t1, t2;
+
+    /* Load into temporaries to acquire the exclusive access lock.  */
+    asm("0: ldxp %[t1], %[t2], %[mem]\n\t"
+        "stxp %w[t1], %[l], %[h], %[mem]\n\t"
+        "cbnz %w[t1], 0b"
+        : [mem] "+m"(*ptr), [t1] "=&r"(t1), [t2] "=&r"(t2)
+        : [l] "r"(l), [h] "r"(h));
+}
+
+# define HAVE_ATOMIC128 1
+#else
+#include "host/include/generic/host/atomic128-ldst.h"
+#endif
+
+#endif /* AARCH64_ATOMIC128_LDST_H */
diff --git a/host/include/generic/host/atomic128-ldst.h b/host/include/generic/host/atomic128-ldst.h
new file mode 100644
index 0000000000..e7354a9255
--- /dev/null
+++ b/host/include/generic/host/atomic128-ldst.h
@@ -0,0 +1,57 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Load/store for 128-bit atomic operations, generic version.
+ *
+ * Copyright (C) 2018, 2023 Linaro, Ltd.
+ *
+ * See docs/devel/atomics.rst for discussion about the guarantees each
+ * atomic primitive is meant to provide.
+ */
+
+#ifndef HOST_ATOMIC128_LDST_H
+#define HOST_ATOMIC128_LDST_H
+
+#if defined(CONFIG_ATOMIC128)
+static inline Int128 atomic16_read(Int128 *ptr)
+{
+    Int128Alias r;
+
+    r.i = qatomic_read__nocheck((__int128_t *)ptr);
+    return r.s;
+}
+
+static inline void atomic16_set(Int128 *ptr, Int128 val)
+{
+    Int128Alias v;
+
+    v.s = val;
+    qatomic_set__nocheck((__int128_t *)ptr, v.i);
+}
+
+# define HAVE_ATOMIC128 1
+#elif !defined(CONFIG_USER_ONLY) && HAVE_CMPXCHG128
+static inline Int128 atomic16_read(Int128 *ptr)
+{
+    /* Maybe replace 0 with 0, returning the old value.  */
+    Int128 z = int128_make64(0);
+    return atomic16_cmpxchg(ptr, z, z);
+}
+
+static inline void atomic16_set(Int128 *ptr, Int128 val)
+{
+    Int128 old = *ptr, cmp;
+    do {
+        cmp = old;
+        old = atomic16_cmpxchg(ptr, cmp, val);
+    } while (int128_ne(old, cmp));
+}
+
+# define HAVE_ATOMIC128 1
+#else
+/* Fallback definitions that must be optimized away, or error.  */
+Int128 QEMU_ERROR("unsupported atomic") atomic16_read(Int128 *ptr);
+void QEMU_ERROR("unsupported atomic") atomic16_set(Int128 *ptr, Int128 val);
+# define HAVE_ATOMIC128 0
+#endif
+
+#endif /* HOST_ATOMIC128_LDST_H */
diff --git a/include/qemu/atomic128.h b/include/qemu/atomic128.h
index 10a2322c44..3a8adb4d47 100644
--- a/include/qemu/atomic128.h
+++ b/include/qemu/atomic128.h
@@ -42,78 +42,6 @@
  */
 
 #include "host/atomic128-cas.h"
-
-#if defined(CONFIG_ATOMIC128)
-static inline Int128 atomic16_read(Int128 *ptr)
-{
-    Int128Alias r;
-
-    r.i = qatomic_read__nocheck((__int128_t *)ptr);
-    return r.s;
-}
-
-static inline void atomic16_set(Int128 *ptr, Int128 val)
-{
-    Int128Alias v;
-
-    v.s = val;
-    qatomic_set__nocheck((__int128_t *)ptr, v.i);
-}
-
-# define HAVE_ATOMIC128 1
-#elif !defined(CONFIG_USER_ONLY) && defined(__aarch64__)
-/* We can do better than cmpxchg for AArch64.  */
-static inline Int128 atomic16_read(Int128 *ptr)
-{
-    uint64_t l, h;
-    uint32_t tmp;
-
-    /* The load must be paired with the store to guarantee not tearing.  */
-    asm("0: ldxp %[l], %[h], %[mem]\n\t"
-        "stxp %w[tmp], %[l], %[h], %[mem]\n\t"
-        "cbnz %w[tmp], 0b"
-        : [mem] "+m"(*ptr), [tmp] "=r"(tmp), [l] "=r"(l), [h] "=r"(h));
-
-    return int128_make128(l, h);
-}
-
-static inline void atomic16_set(Int128 *ptr, Int128 val)
-{
-    uint64_t l = int128_getlo(val), h = int128_gethi(val);
-    uint64_t t1, t2;
-
-    /* Load into temporaries to acquire the exclusive access lock.  */
-    asm("0: ldxp %[t1], %[t2], %[mem]\n\t"
-        "stxp %w[t1], %[l], %[h], %[mem]\n\t"
-        "cbnz %w[t1], 0b"
-        : [mem] "+m"(*ptr), [t1] "=&r"(t1), [t2] "=&r"(t2)
-        : [l] "r"(l), [h] "r"(h));
-}
-
-# define HAVE_ATOMIC128 1
-#elif !defined(CONFIG_USER_ONLY) && HAVE_CMPXCHG128
-static inline Int128 atomic16_read(Int128 *ptr)
-{
-    /* Maybe replace 0 with 0, returning the old value.  */
-    Int128 z = int128_make64(0);
-    return atomic16_cmpxchg(ptr, z, z);
-}
-
-static inline void atomic16_set(Int128 *ptr, Int128 val)
-{
-    Int128 old = *ptr, cmp;
-    do {
-        cmp = old;
-        old = atomic16_cmpxchg(ptr, cmp, val);
-    } while (int128_ne(old, cmp));
-}
-
-# define HAVE_ATOMIC128 1
-#else
-/* Fallback definitions that must be optimized away, or error.  */
-Int128 QEMU_ERROR("unsupported atomic") atomic16_read(Int128 *ptr);
-void QEMU_ERROR("unsupported atomic") atomic16_set(Int128 *ptr, Int128 val);
-# define HAVE_ATOMIC128 0
-#endif /* Some definition for HAVE_ATOMIC128 */
+#include "host/atomic128-ldst.h"
 
 #endif /* QEMU_ATOMIC128_H */
-- 
2.34.1


