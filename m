Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEBC70DDFB
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:51:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SMg-0000HN-6h; Tue, 23 May 2023 09:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMe-0000CZ-6K
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:48 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMc-00016c-2G
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:47 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64d5b4c3ffeso2141788b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849664; x=1687441664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jB5qzpA06Oq7YWao0ePdlph12dZD3cppuuTihIbPb0c=;
 b=LWB/UA5R8n+T+In/0ithAEutCj17Ka5SLgsu++S/ImQLNF85rCRy3TiLRf0wADaYSH
 M1IKv2w3TVHnriRrNeuFwByro060PfIPHyOE3jdFYB/pINruokNIR9HGVdFo3iYuTfX9
 KW8j+Hln2HUJwayTdHxsaWflXvArRxsMg7YjCcUAnmv9r8Q06T0v2sf/WYaQqrJx29Sp
 AAHIrPmtpSPIPJ81X+rj/b1aA4K+LfCfrp9mYvN0eI5xabQbfNYzu8F4kANoh0kSk+J4
 KOk4fmCCV4gerCWlfaIoNcNm325GmxIL1gt+yb5ByEwi9OJXU6jZiD4ys5CjKyz/fhNA
 STtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849664; x=1687441664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jB5qzpA06Oq7YWao0ePdlph12dZD3cppuuTihIbPb0c=;
 b=KpGF+Tf1DzvMRPGloce9K6beVBvzs+TpzQP0m365tbj0OlQFVgB5/NajE4OWSgDn2Y
 wv1Ouwf+2wdmW9WcUIGNQQyyIhuxrO7FvPFImAPwJ3zkmwtvCQxV4rHaPf+l0DTbh2LA
 npk2AYqOrDZT7Vivhf8v2gyA1SaSFeWTnChEW9xRVxQ3aVt0wqS4ppOQ/vIWF/zOwJIM
 nNLSl7YMqKlqdmMFiToCL3WgAPL8Vp3l6DD6WbMSPhS1xCDGZzziH7fm5FII2EnC8WNZ
 GGfzg9UrHPZQykdZ5Nq6x/e3dSrQ2q0GabKCjW9QHEBk682JCmmWtiDUEI6nHOH8nUVz
 v4/A==
X-Gm-Message-State: AC+VfDxjZhrTCxukAVK419hKvivw5a+q5LCJg2e7DeBVOVpv72Fmbxdr
 yfAsKpg2Q7pf2hhHVgVVDzKlNvFL8ASbuS118Jw=
X-Google-Smtp-Source: ACHHUZ6rX26eIjEa1HQevhaB6T7qJKZaWitphuUO/zjSOQLVlcohnVRravneEFl5hi3Xh4NFQn8+DA==
X-Received: by 2002:a05:6a00:1948:b0:640:defd:a6d5 with SMTP id
 s8-20020a056a00194800b00640defda6d5mr15899311pfk.12.1684849664441; 
 Tue, 23 May 2023 06:47:44 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 j4-20020aa79284000000b0064d1349dc31sm5737122pfa.199.2023.05.23.06.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:47:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 11/27] include/host: Split out atomic128-ldst.h
Date: Tue, 23 May 2023 06:47:17 -0700
Message-Id: <20230523134733.678646-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523134733.678646-1-richard.henderson@linaro.org>
References: <20230523134733.678646-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/aarch64/host/atomic128-ldst.h | 49 ++++++++++++++
 host/include/generic/host/atomic128-ldst.h | 57 +++++++++++++++++
 include/qemu/atomic128.h                   | 74 +---------------------
 3 files changed, 107 insertions(+), 73 deletions(-)
 create mode 100644 host/include/aarch64/host/atomic128-ldst.h
 create mode 100644 host/include/generic/host/atomic128-ldst.h

diff --git a/host/include/aarch64/host/atomic128-ldst.h b/host/include/aarch64/host/atomic128-ldst.h
new file mode 100644
index 0000000000..bd61fce50d
--- /dev/null
+++ b/host/include/aarch64/host/atomic128-ldst.h
@@ -0,0 +1,49 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Load/store for 128-bit atomic operations, AArch64 version.
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


