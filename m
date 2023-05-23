Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B4C70E9FB
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 02:05:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1btl-0004Hx-Ei; Tue, 23 May 2023 19:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btf-0004Gk-At
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:31 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btS-0001nz-5R
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:31 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64f47448aeaso116966b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886295; x=1687478295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckMaH7dUG54Wdl747ViXjNwZk3Jd4mSMPCGpnGQ4+ys=;
 b=CqjsNSdXOOzKUJZZESVCaokcDtcsyUhbkykFegMf+7rsZrzvPAK2nE57GRzqoHerSh
 I6SrXd3XDwA7PJUHugfk1z4NnrHyf2Wn3c1UW2y6P9a8+hlXNGsbTkG3dbbAYsmi/y71
 kAUbbbFQrHG25oV8MjJYHzS45dUkKxVOs4rcoc26rDg6w7xdY4FGm6AbkYfeSt/wOkgv
 xyjZOJkLitmtfrQkVMLCtj+Ix+bkIslW7BDZ6rBc/aUaNqodtnURt2J4jHgBTa/10L2/
 q3dJxRSONCjrQEGvKYdo2qjLi5p+UgP5g//70o5yES/3PwToxcd5p3cwy6cLXwmP4vS5
 N2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886295; x=1687478295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ckMaH7dUG54Wdl747ViXjNwZk3Jd4mSMPCGpnGQ4+ys=;
 b=a3uIEvDKda9DWfPbooWvZtfTsIYdH/uT5ey1Q/eRVLg1bH9BiLhr+7KdhhS91EfcAi
 ToFwUSNw9e4X18pauJaG64Zku6feZUxAnT5PWVkK0qOGwc54f9KBmv4KoZI2m8jmTjqL
 Hm8C+KIl/qWotJsZVwA/IBP2Lt6kxOP/GenIIS14kim0IpZxupSCEnpO7FtdqiT16Fop
 M2ihKQWc1/uzPL9Iax9nLUhXmtKVk2sEhXQa7oYZ3uwAClcXNK+B6biE/DeV75e2TFB6
 oyH6KOT37JHfp7q4klruQtGoCi4Hc7m1rtB7VS72FXsqtFNsUVrpSLMiv2Imf2wqKSdm
 3LTQ==
X-Gm-Message-State: AC+VfDzsx/74Ex+GWACNHYF3FREO/+JTcAs5yy9Is3IIr4FhMB+GIuCD
 Qmn5ZpmiWHT0wOB0D98c/+0TvKDiwvI9q8NBwNc=
X-Google-Smtp-Source: ACHHUZ4yY0j9GdPHwH+ImzIDl6S9rvPYOl9PekKQPfCze+q+I4hrQBu2f/oUtUe+TIHukyGvnHXOAQ==
X-Received: by 2002:a05:6a00:392a:b0:643:53b6:d841 with SMTP id
 fh42-20020a056a00392a00b0064353b6d841mr1112090pfb.2.1684886295369; 
 Tue, 23 May 2023 16:58:15 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 11/28] include/host: Split out atomic128-ldst.h
Date: Tue, 23 May 2023 16:57:47 -0700
Message-Id: <20230523235804.747803-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523235804.747803-1-richard.henderson@linaro.org>
References: <20230523235804.747803-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Separates the aarch64-specific portion into its own file.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


