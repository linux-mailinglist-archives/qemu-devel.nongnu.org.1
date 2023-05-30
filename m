Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53711716D20
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:06:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44Zy-0000uk-QO; Tue, 30 May 2023 15:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zh-0000pR-RD
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:05 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zf-0000ux-EM
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:05 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-53f8da65701so1650099a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473202; x=1688065202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvHT61xsxGrBjBYeB6GWGqFVxfYeSD1n3dxDi9mtfR8=;
 b=D6isedExoOUi8QgLPSWQJSsElO1MOuNyqV/Ssvf5xMCy47HZ+SriJLAk9UORGVYS/L
 eNmwx6FXcZmNWfzomWRHDe0jy2gSZVP0AQaPo4CyBxz3JHodd8/y8e6W+SlGdy6frnze
 y0IwwLKghGOmBFeq1VWsY7s+JhbKedpmGHYzgQ08TUmQCtSIK9FRT2JFzZB06J5BVWUb
 vVWUTv3eUpaWgi5RBbcRGDSPzRObt7sg5S7DYbrfO8LGuOD/k74skR3gO9kASTlmw87Z
 dgiFqVzWRIh+v2Dl93pg36qLk4XjnxR7pMbUYww/n+d6LVorSe41z/ZIThW13qtu+Aqe
 RusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473202; x=1688065202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fvHT61xsxGrBjBYeB6GWGqFVxfYeSD1n3dxDi9mtfR8=;
 b=IbPGRnfz8Skpd3uMh4TDiLhd9sWYzOjK/Z11kxU8RPumNs0bWCtCV927u3T0IWeFWC
 lb9P8ladG713wOclXGdDKNlVEXOAoiBel8wrQLGa/UwDudVmOij1fLBHOBUxF1x2TcF9
 FHVXeV4c7FsIXoehivCLlQpRVhEqQsIew7HV/Vk4QOYt5JWH89PWGnka01diytUg6Lmj
 ljRKB2kyjvOCzTj4KPpD4evmsRXG9AkTcgZQga8SX3sTomPtwt9TQmRS9fVsDjW7MiHA
 r+H88k3uNd0hrMN2zxMeaeJLtvtFsOC9cDFKOml9bUZ3TfUUpNF2T4mNIIgdnSB6YFK1
 kCRQ==
X-Gm-Message-State: AC+VfDwIZTdYPq6G1LeAxvCNjDzUh1StCbKYGopl3Qr2Jm9XiRVtZPlB
 SiLV6JRuGfY364EGbk+0BIkVCwzepL9Wcmgpa1k=
X-Google-Smtp-Source: ACHHUZ7uB3dv8XHHKTsv9G7x+8pU29zuxNGsEQrd7JZtyv1aTJJ4Pn8jLEshGBNqeoqIjGUL2R8HPg==
X-Received: by 2002:a05:6a20:e186:b0:110:493f:6bfd with SMTP id
 ks6-20020a056a20e18600b00110493f6bfdmr3083789pzb.46.1685473201803; 
 Tue, 30 May 2023 12:00:01 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.12.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:00:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 13/27] accel/tcg: Extract store_atom_insert_al16 to host header
Date: Tue, 30 May 2023 11:59:35 -0700
Message-Id: <20230530185949.410208-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index 6063395e11..2514899408 100644
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


