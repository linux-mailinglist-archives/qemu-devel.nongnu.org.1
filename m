Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EFC70A918
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 18:28:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0PQC-0003eo-MG; Sat, 20 May 2023 12:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQ3-0003e0-AH
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:26:59 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PPz-00038q-Ux
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:26:58 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6436dfa15b3so3150839b3a.1
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 09:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684600014; x=1687192014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDLGAPMJ+rUVMTpdZgvvo26halub+heLPUT3U1Wrh9A=;
 b=RhvuOrA9VZC0gJf2P1BbhjiCzc+M4HomovA6Y7JVBqSDAKbPtOf7HXtB3bxlexrZ+l
 qjU2nskHJC0dvrhgi7C/yJt91qlWFTRfx7jGLdR55ApFFWeTVgQguTGsOEfjN5tTdI7o
 NYxi2W0KbSZ32MTqlExIMcPdfe9zdGW0qN1Qa2uNmmNGnsS7MOp8+VxxiQ8tNTAosacU
 DO0xuKBTblOSiq7n7oFK7/C/iayiOxtO0RZzzeDsBNRuXLb1djtqXUND/M+WoKe//YWb
 w91ywwTHi/4bs/nngm6My3WgnJ4O+7VEnWqvzCITZ2a47bdxYUzfIN5hUejGcnEcHSrU
 KwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684600014; x=1687192014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDLGAPMJ+rUVMTpdZgvvo26halub+heLPUT3U1Wrh9A=;
 b=Rs9qanW19yddNhtQiFjoXbtvK9a3xzLd9xQv1xjJ9+lC1SiyT5eifblRb1QkwBNsoF
 Z0rr8LujCeTwz02J/CACfGkc6KkQw8P4ttIdJiDwcgibdRZFESQB0LNRbjcaFmXja8ax
 dxI6anTnRMp6F05WXUnuhi+1sZu2og3J8ST9FC0EiloN/UIkWsg4rJEb5uYsAyN7i4vU
 QomNOF/S/wwcLWzeeN3poCmQ2rkvaEmRUxZ/eoqyJ9g28nprf+HEMty4iyH8IneH7QKj
 Svgk1Hor+RK+ks4b1vK3+b8cT/ob3pF+wxrqixCRaDNsINw0PFpsBEB/8dMwizxPchch
 9mng==
X-Gm-Message-State: AC+VfDyetnIa7FF0Iexq1ywmOP7VjB7T/eMqrNBD1KCOKIDHX/4UhyWn
 Aixb8/xgdfiUi1MyvUABjHQoU/1aE6OU6Vf2hN0=
X-Google-Smtp-Source: ACHHUZ6n7FZrETlkpYxMM/760BFnjEdj5V4T84IEgcpHCqovkZFvclc779rV3emcxKkfK6uobP7z3w==
X-Received: by 2002:a17:902:bf06:b0:1ab:1bdd:b307 with SMTP id
 bi6-20020a170902bf0600b001ab1bddb307mr5232400plb.51.1684600014560; 
 Sat, 20 May 2023 09:26:54 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:d078:d94e:cb2b:a055])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170903230c00b001a5260a6e6csm1697104plh.206.2023.05.20.09.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 09:26:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 10/27] include/host: Split out atomic128-cas.h
Date: Sat, 20 May 2023 09:26:17 -0700
Message-Id: <20230520162634.3991009-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230520162634.3991009-1-richard.henderson@linaro.org>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
 host/include/aarch64/host/atomic128-cas.h | 43 ++++++++++++++++++
 host/include/generic/host/atomic128-cas.h | 43 ++++++++++++++++++
 include/qemu/atomic128.h                  | 55 +----------------------
 3 files changed, 87 insertions(+), 54 deletions(-)
 create mode 100644 host/include/aarch64/host/atomic128-cas.h
 create mode 100644 host/include/generic/host/atomic128-cas.h

diff --git a/host/include/aarch64/host/atomic128-cas.h b/host/include/aarch64/host/atomic128-cas.h
new file mode 100644
index 0000000000..1247995419
--- /dev/null
+++ b/host/include/aarch64/host/atomic128-cas.h
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


