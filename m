Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 182AD70E9FA
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 02:04:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1btV-0004BS-6u; Tue, 23 May 2023 19:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btS-0004B7-I2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:18 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btP-0001ng-Tu
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:18 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64d426e63baso168574b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886294; x=1687478294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yUAsUnFho/cwZWVFrY9aBytCBOU03OnLc6iH8Ijw6TM=;
 b=xHGz/5sByi8KwcR8zbSrOflisl1C1z9fwcFk8/o9CPeeBaI2/tmOK73Z9V0mlU9u4p
 59apUiqg3Hffr5gbH2IUE6kPrh3sxyKidTzYmDYzmkR+N6/E/VSG4wn6fKRpECkJEiJi
 XKMGNGUa6Dcxf8n8u9qrFunU6N8SXxU3+A0Vsi8oDrLY5JE+mDHIpXM+n97IE2DHo/TW
 7Yls/LNybTWXbdBCRYcREJNaRF72YuYlqycu0nDYfDCZOaIy9o3huFg3r1s6tRcH2YOb
 20zzfB0SuzNMa1I4ZyWhN7f2V4VwBvJoRHy1qDL+NQIw5udSR5iZu+Z11hkhYJQJ0YxB
 gBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886294; x=1687478294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yUAsUnFho/cwZWVFrY9aBytCBOU03OnLc6iH8Ijw6TM=;
 b=X2QxajybhR2MrMzYVsbO7Dh/XEXosCcpmav5pA5z6S1GZjcWdvXJURR5djdQBCJyE4
 ktbD6NqkMWpipaO8MJLwHikgSf1TN1zIfmDJWssZ0UGH12QabwSW3RZaCTdkieH2nFSQ
 DdpOlHesjZjxQTbxyeP7vBCTrqzke3FbChvn6ay/14SlpbklPPUCcY7dpQNCN/aqVvQZ
 tNcLKyDiGE2RkQKwINjYWZB08ZWS8EXJ1v2VrvBbJ7yPac6ELxcx552k9YA7otMzhVCD
 LMwSTC01Rca/NI8ts3DRSX3bR139ZUKcEBKkhSWI5PpS+/dKYcDGI979QjbRqZqloiUl
 5BIA==
X-Gm-Message-State: AC+VfDz6AuxJ+GDQXv8+mUcfgHu2NyVYV90t2WyyPp5iMwSrJQWip1PO
 2StdT64fTH3qgieogaa7SuJn6KbJGTMzWZxobes=
X-Google-Smtp-Source: ACHHUZ7/OyLCjN/Oeq8bFzi6G0P5x8cggCHgyktGuavcjWjNTtRVwbvv4aHOFcf8oYC1h+LOCwMu3Q==
X-Received: by 2002:a05:6a00:2305:b0:63b:4313:f8c4 with SMTP id
 h5-20020a056a00230500b0063b4313f8c4mr902490pfh.9.1684886294538; 
 Tue, 23 May 2023 16:58:14 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 10/28] include/host: Split out atomic128-cas.h
Date: Tue, 23 May 2023 16:57:46 -0700
Message-Id: <20230523235804.747803-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523235804.747803-1-richard.henderson@linaro.org>
References: <20230523235804.747803-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Separates the aarch64-specific portion into its own file.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/aarch64/host/atomic128-cas.h | 43 ++++++++++++++++++
 host/include/generic/host/atomic128-cas.h | 43 ++++++++++++++++++
 include/qemu/atomic128.h                  | 55 +----------------------
 3 files changed, 87 insertions(+), 54 deletions(-)
 create mode 100644 host/include/aarch64/host/atomic128-cas.h
 create mode 100644 host/include/generic/host/atomic128-cas.h

diff --git a/host/include/aarch64/host/atomic128-cas.h b/host/include/aarch64/host/atomic128-cas.h
new file mode 100644
index 0000000000..80de58e06d
--- /dev/null
+++ b/host/include/aarch64/host/atomic128-cas.h
@@ -0,0 +1,43 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Compare-and-swap for 128-bit atomic operations, AArch64 version.
+ *
+ * Copyright (C) 2018, 2023 Linaro, Ltd.
+ *
+ * See docs/devel/atomics.rst for discussion about the guarantees each
+ * atomic primitive is meant to provide.
+ */
+
+#ifndef AARCH64_ATOMIC128_CAS_H
+#define AARCH64_ATOMIC128_CAS_H
+
+/* Through gcc 10, aarch64 has no support for 128-bit atomics.  */
+#if defined(CONFIG_ATOMIC128) || defined(CONFIG_CMPXCHG128)
+#include "host/include/generic/host/atomic128-cas.h"
+#else
+static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
+{
+    uint64_t cmpl = int128_getlo(cmp), cmph = int128_gethi(cmp);
+    uint64_t newl = int128_getlo(new), newh = int128_gethi(new);
+    uint64_t oldl, oldh;
+    uint32_t tmp;
+
+    asm("0: ldaxp %[oldl], %[oldh], %[mem]\n\t"
+        "cmp %[oldl], %[cmpl]\n\t"
+        "ccmp %[oldh], %[cmph], #0, eq\n\t"
+        "b.ne 1f\n\t"
+        "stlxp %w[tmp], %[newl], %[newh], %[mem]\n\t"
+        "cbnz %w[tmp], 0b\n"
+        "1:"
+        : [mem] "+m"(*ptr), [tmp] "=&r"(tmp),
+          [oldl] "=&r"(oldl), [oldh] "=&r"(oldh)
+        : [cmpl] "r"(cmpl), [cmph] "r"(cmph),
+          [newl] "r"(newl), [newh] "r"(newh)
+        : "memory", "cc");
+
+    return int128_make128(oldl, oldh);
+}
+# define HAVE_CMPXCHG128 1
+#endif
+
+#endif /* AARCH64_ATOMIC128_CAS_H */
diff --git a/host/include/generic/host/atomic128-cas.h b/host/include/generic/host/atomic128-cas.h
new file mode 100644
index 0000000000..513622fe34
--- /dev/null
+++ b/host/include/generic/host/atomic128-cas.h
@@ -0,0 +1,43 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Compare-and-swap for 128-bit atomic operations, generic version.
+ *
+ * Copyright (C) 2018, 2023 Linaro, Ltd.
+ *
+ * See docs/devel/atomics.rst for discussion about the guarantees each
+ * atomic primitive is meant to provide.
+ */
+
+#ifndef HOST_ATOMIC128_CAS_H
+#define HOST_ATOMIC128_CAS_H
+
+#if defined(CONFIG_ATOMIC128)
+static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
+{
+    Int128Alias r, c, n;
+
+    c.s = cmp;
+    n.s = new;
+    r.i = qatomic_cmpxchg__nocheck((__int128_t *)ptr, c.i, n.i);
+    return r.s;
+}
+# define HAVE_CMPXCHG128 1
+#elif defined(CONFIG_CMPXCHG128)
+static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
+{
+    Int128Alias r, c, n;
+
+    c.s = cmp;
+    n.s = new;
+    r.i = __sync_val_compare_and_swap_16((__int128_t *)ptr, c.i, n.i);
+    return r.s;
+}
+# define HAVE_CMPXCHG128 1
+#else
+/* Fallback definition that must be optimized away, or error.  */
+Int128 QEMU_ERROR("unsupported atomic")
+    atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new);
+# define HAVE_CMPXCHG128 0
+#endif
+
+#endif /* HOST_ATOMIC128_CAS_H */
diff --git a/include/qemu/atomic128.h b/include/qemu/atomic128.h
index d0ba0b9c65..10a2322c44 100644
--- a/include/qemu/atomic128.h
+++ b/include/qemu/atomic128.h
@@ -41,60 +41,7 @@
  * Therefore, special case each platform.
  */
 
-#if defined(CONFIG_ATOMIC128)
-static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
-{
-    Int128Alias r, c, n;
-
-    c.s = cmp;
-    n.s = new;
-    r.i = qatomic_cmpxchg__nocheck((__int128_t *)ptr, c.i, n.i);
-    return r.s;
-}
-# define HAVE_CMPXCHG128 1
-#elif defined(CONFIG_CMPXCHG128)
-static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
-{
-    Int128Alias r, c, n;
-
-    c.s = cmp;
-    n.s = new;
-    r.i = __sync_val_compare_and_swap_16((__int128_t *)ptr, c.i, n.i);
-    return r.s;
-}
-# define HAVE_CMPXCHG128 1
-#elif defined(__aarch64__)
-/* Through gcc 8, aarch64 has no support for 128-bit at all.  */
-static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
-{
-    uint64_t cmpl = int128_getlo(cmp), cmph = int128_gethi(cmp);
-    uint64_t newl = int128_getlo(new), newh = int128_gethi(new);
-    uint64_t oldl, oldh;
-    uint32_t tmp;
-
-    asm("0: ldaxp %[oldl], %[oldh], %[mem]\n\t"
-        "cmp %[oldl], %[cmpl]\n\t"
-        "ccmp %[oldh], %[cmph], #0, eq\n\t"
-        "b.ne 1f\n\t"
-        "stlxp %w[tmp], %[newl], %[newh], %[mem]\n\t"
-        "cbnz %w[tmp], 0b\n"
-        "1:"
-        : [mem] "+m"(*ptr), [tmp] "=&r"(tmp),
-          [oldl] "=&r"(oldl), [oldh] "=&r"(oldh)
-        : [cmpl] "r"(cmpl), [cmph] "r"(cmph),
-          [newl] "r"(newl), [newh] "r"(newh)
-        : "memory", "cc");
-
-    return int128_make128(oldl, oldh);
-}
-# define HAVE_CMPXCHG128 1
-#else
-/* Fallback definition that must be optimized away, or error.  */
-Int128 QEMU_ERROR("unsupported atomic")
-    atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new);
-# define HAVE_CMPXCHG128 0
-#endif /* Some definition for HAVE_CMPXCHG128 */
-
+#include "host/atomic128-cas.h"
 
 #if defined(CONFIG_ATOMIC128)
 static inline Int128 atomic16_read(Int128 *ptr)
-- 
2.34.1


