Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3D9711B14
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 02:25:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2LFL-0002eE-KL; Thu, 25 May 2023 20:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LFK-0002do-8o
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:54 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LFD-0002Bu-H7
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:54 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64d5f65a2f7so270344b3a.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 17:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685060626; x=1687652626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MUe+ePpAXqeWQugAYIOwy5+kFWDdU+DeS/QoHodF2ms=;
 b=YPJL4LXaItaCdTT1Wk+w9SzMZexjbtJkqDF4P0Z5sLF/at1inAQAR+nvaNhcK9++tn
 99n+8/a3lnGnrVmLBzAmxqZrrFmBW1T01xVJahK4Tc3U1knQ/dR98C9c6Zv3u+bNvD5w
 +MJF0eY1NwTv7PhUb761HObbb7RFYL/KRYE+XFvodJiBe793XinAMVG4rDKvRHR3wdJL
 bPk1WEaBrWjXkrBSOPcVUb1aNiTPZAW0KhN+7nLj0B+CrRiuWNOo5YB+XtGOYvPWNIzf
 CETl9Ex+I3NNlR5bKflG1kBaF4TNyG5wYFTKb4hPqaSFM3Auj/H4zk5DalazNMuxnaS2
 v2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685060626; x=1687652626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MUe+ePpAXqeWQugAYIOwy5+kFWDdU+DeS/QoHodF2ms=;
 b=TViXgoIN4kR3EEbHRytK9dqCHZlOt5zZ5uQs485nI/h126Sbr6OgZWxwz2ZTcEL/eV
 vDnpw6/ZUBfwkuVQbkKo26gCboMMPlTppqN0iM6fzda8wcoJTIMpbRwT6CsPoAjFdLk/
 rwZDJLKwNGmKeB1fSqdgjSvfE8v9ozcWSuCBZsaZNQDyPKvDH7VM1XSn0lp31JMczW0K
 4PxoffjqmX8jnanI23ql1XOz/TdxrzXOJJkTVOptPLNNMowtL6Q+bhkDNkLFrtN+KdOE
 6wqykr4tT2qzS8PGNf1xPEX2bOQNm0j2HOipxJkDN8+C/WUFMxT5CPJlX2tb6iKjlx4K
 IumA==
X-Gm-Message-State: AC+VfDxc7TTaevtCIw+yHZkTP82lQglkuwZZIarl7aPDgIWNmx0kwmL0
 MZ11mM6PGOBx7Jj+pqwQCd5miZB+HkflTIHWSdA=
X-Google-Smtp-Source: ACHHUZ6MDpaK4uBUfwyAhPBLl3hPJXNslmyxUkfmBowA2oZEZj+JBNiKRaX5SK7E6rhPE2X3nlHGaQ==
X-Received: by 2002:a05:6a20:258b:b0:105:5800:c51b with SMTP id
 k11-20020a056a20258b00b001055800c51bmr25388429pzd.30.1685060626284; 
 Thu, 25 May 2023 17:23:46 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s188-20020a635ec5000000b0053491d92b65sm1675593pgb.84.2023.05.25.17.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 17:23:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 13/16] accel/tcg: Extract store_atom_insert_al16 to host
 header
Date: Thu, 25 May 2023 17:23:31 -0700
Message-Id: <20230526002334.1760495-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526002334.1760495-1-richard.henderson@linaro.org>
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/store-insert-al16.h | 50 +++++++++++++++++++
 accel/tcg/ldst_atomicity.c.inc                | 40 +--------------
 2 files changed, 51 insertions(+), 39 deletions(-)
 create mode 100644 host/include/generic/host/store-insert-al16.h

diff --git a/host/include/generic/host/store-insert-al16.h b/host/include/generic/host/store-insert-al16.h
new file mode 100644
index 0000000000..4a1662183d
--- /dev/null
+++ b/host/include/generic/host/store-insert-al16.h
@@ -0,0 +1,50 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Atomic store insert into 128-bit, generic version.
+ *
+ * Copyright (C) 2023 Linaro, Ltd.
+ */
+
+#ifndef HOST_STORE_INSERT_AL16_H
+#define HOST_STORE_INSERT_AL16_H
+
+/**
+ * store_atom_insert_al16:
+ * @p: host address
+ * @val: shifted value to store
+ * @msk: mask for value to store
+ *
+ * Atomically store @val to @p masked by @msk.
+ */
+static inline void ATTRIBUTE_ATOMIC128_OPT
+store_atom_insert_al16(Int128 *ps, Int128 val, Int128 msk)
+{
+#if defined(CONFIG_ATOMIC128)
+    __uint128_t *pu;
+    Int128Alias old, new;
+
+    /* With CONFIG_ATOMIC128, we can avoid the memory barriers. */
+    pu = __builtin_assume_aligned(ps, 16);
+    old.u = *pu;
+    msk = int128_not(msk);
+    do {
+        new.s = int128_and(old.s, msk);
+        new.s = int128_or(new.s, val);
+    } while (!__atomic_compare_exchange_n(pu, &old.u, new.u, true,
+                                          __ATOMIC_RELAXED, __ATOMIC_RELAXED));
+#else
+    Int128 old, new, cmp;
+
+    ps = __builtin_assume_aligned(ps, 16);
+    old = *ps;
+    msk = int128_not(msk);
+    do {
+        cmp = old;
+        new = int128_and(old, msk);
+        new = int128_or(new, val);
+        old = atomic16_cmpxchg(ps, cmp, new);
+    } while (int128_ne(cmp, old));
+#endif
+}
+
+#endif /* HOST_STORE_INSERT_AL16_H */
diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index 39ad89800d..6844f85d58 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -10,6 +10,7 @@
  */
 
 #include "host/load-extract-al16-al8.h"
+#include "host/store-insert-al16.h"
 
 #ifdef CONFIG_ATOMIC64
 # define HAVE_al8          true
@@ -681,45 +682,6 @@ static void store_atom_insert_al8(uint64_t *p, uint64_t val, uint64_t msk)
                                           __ATOMIC_RELAXED, __ATOMIC_RELAXED));
 }
 
-/**
- * store_atom_insert_al16:
- * @p: host address
- * @val: shifted value to store
- * @msk: mask for value to store
- *
- * Atomically store @val to @p masked by @msk.
- */
-static void ATTRIBUTE_ATOMIC128_OPT
-store_atom_insert_al16(Int128 *ps, Int128Alias val, Int128Alias msk)
-{
-#if defined(CONFIG_ATOMIC128)
-    __uint128_t *pu, old, new;
-
-    /* With CONFIG_ATOMIC128, we can avoid the memory barriers. */
-    pu = __builtin_assume_aligned(ps, 16);
-    old = *pu;
-    do {
-        new = (old & ~msk.u) | val.u;
-    } while (!__atomic_compare_exchange_n(pu, &old, new, true,
-                                          __ATOMIC_RELAXED, __ATOMIC_RELAXED));
-#elif defined(CONFIG_CMPXCHG128)
-    __uint128_t *pu, old, new;
-
-    /*
-     * Without CONFIG_ATOMIC128, __atomic_compare_exchange_n will always
-     * defer to libatomic, so we must use __sync_*_compare_and_swap_16
-     * and accept the sequential consistency that comes with it.
-     */
-    pu = __builtin_assume_aligned(ps, 16);
-    do {
-        old = *pu;
-        new = (old & ~msk.u) | val.u;
-    } while (!__sync_bool_compare_and_swap_16(pu, old, new));
-#else
-    qemu_build_not_reached();
-#endif
-}
-
 /**
  * store_bytes_leN:
  * @pv: host address
-- 
2.34.1


