Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA46C7E3353
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:55:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9K-0008N6-Ci; Mon, 06 Nov 2023 21:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9H-0008KM-Tw
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:03 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C94-0005qC-AP
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:03 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b5af4662b7so4252607b3a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325329; x=1699930129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vHLAwIo9k4CChF5auIiY+68A+lSlhRobpJGeh7zUX4I=;
 b=u36fQvJkQezZC7ZrPhxhIBHAUJDGOwsXHt8C/fOJcqTHAOf6+GR9zCrzkhvqyJuJVC
 tmECJ1SbHQMCBE4Qr+dKEl2SRZDy/OcaaWscyKOOykqxdrX9rCQmfIlMTq4QxKx2zwFL
 IQ6wxYR5UaUQ27gmh9BVqBjmHqVR7ZwDXREwG7Y044eEjX1TFEAhpYoy5IZGQUUalovN
 2NNc8Tu6dgoHYs33nz/R+DvKClareMpnEmOQ7g64SZZWWSusHLn9LeBbWvy7CkYpU6gS
 zoj7lYKqwBZrXsylxrBWC++mI18P5/q5pYXENMU8zcEgP4it2BdMJHyf7Bql7DUnldtA
 arVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325329; x=1699930129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vHLAwIo9k4CChF5auIiY+68A+lSlhRobpJGeh7zUX4I=;
 b=wdigAKmSf+RjXss40ojg9z63YFuFMem2EbueafaaQ6DybADoV1YTEEo5D5tuBNCyhh
 PplHOtV57Yrj5sg/9aUSnpQRNy/+Mdgl6EGOCfSWN23Uaprvcljezvi8kdoP8+TPgra7
 YEQrqZQFhDKLhz7BpuiI6A+EjVxg5/CuR1yviNh27+XgLgg9mFqbDOHWI3bUuB2g5AVq
 G9x2qAaAAmCFCd44zlL/P8GmpWxrojIhvjOZ5Z8DyQ6JVZATz2ImsjNnKbKOtH66Vov1
 /8o9JoENu2Qry5utcePd2dI0dbhuN2JL/WcpxBgKxrcvfzgrsmK/lZ7LI7Ic/faiVk9k
 narQ==
X-Gm-Message-State: AOJu0YwWvJ9ng0ACJxIon76vtrdWw2TBsmjzCI31zCDKo4+Luy/ABJtC
 EN6s+V7tRIWz+7VnuUF5x9nlzO/ATCFLYXnQX/Y=
X-Google-Smtp-Source: AGHT+IGbiK2l9g5P+lUFLWNSrz5cUVdCWukuJBr6pAwh4fY1XepOQVGIXMayZ8A1+2wTrgXlhoSNJA==
X-Received: by 2002:a05:6a00:21c9:b0:68a:4103:9938 with SMTP id
 t9-20020a056a0021c900b0068a41039938mr28060198pfj.0.1699325328651; 
 Mon, 06 Nov 2023 18:48:48 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.48.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:48:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/35] host/include/loongarch64: Add atomic16 load and store
Date: Mon,  6 Nov 2023 18:48:13 -0800
Message-Id: <20231107024842.7650-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

While loongarch64 does not have a 128-bit cmpxchg, it does
have 128-bit atomic load and store via the vector unit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230916220151.526140-6-richard.henderson@linaro.org>
---
 .../include/loongarch64/host/atomic128-ldst.h | 52 +++++++++++++++++++
 .../loongarch64/host/load-extract-al16-al8.h  | 39 ++++++++++++++
 .../loongarch64/host/store-insert-al16.h      | 12 +++++
 3 files changed, 103 insertions(+)
 create mode 100644 host/include/loongarch64/host/atomic128-ldst.h
 create mode 100644 host/include/loongarch64/host/load-extract-al16-al8.h
 create mode 100644 host/include/loongarch64/host/store-insert-al16.h

diff --git a/host/include/loongarch64/host/atomic128-ldst.h b/host/include/loongarch64/host/atomic128-ldst.h
new file mode 100644
index 0000000000..9a4a8f8b9e
--- /dev/null
+++ b/host/include/loongarch64/host/atomic128-ldst.h
@@ -0,0 +1,52 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Load/store for 128-bit atomic operations, LoongArch version.
+ *
+ * See docs/devel/atomics.rst for discussion about the guarantees each
+ * atomic primitive is meant to provide.
+ */
+
+#ifndef LOONGARCH_ATOMIC128_LDST_H
+#define LOONGARCH_ATOMIC128_LDST_H
+
+#include "host/cpuinfo.h"
+#include "tcg/debug-assert.h"
+
+#define HAVE_ATOMIC128_RO  likely(cpuinfo & CPUINFO_LSX)
+#define HAVE_ATOMIC128_RW  HAVE_ATOMIC128_RO
+
+/*
+ * As of gcc 13 and clang 16, there is no compiler support for LSX at all.
+ * Use inline assembly throughout.
+ */
+
+static inline Int128 atomic16_read_ro(const Int128 *ptr)
+{
+    uint64_t l, h;
+
+    tcg_debug_assert(HAVE_ATOMIC128_RO);
+    asm("vld $vr0, %2, 0\n\t"
+        "vpickve2gr.d %0, $vr0, 0\n\t"
+        "vpickve2gr.d %1, $vr0, 1"
+	: "=r"(l), "=r"(h) : "r"(ptr), "m"(*ptr) : "f0");
+
+    return int128_make128(l, h);
+}
+
+static inline Int128 atomic16_read_rw(Int128 *ptr)
+{
+    return atomic16_read_ro(ptr);
+}
+
+static inline void atomic16_set(Int128 *ptr, Int128 val)
+{
+    uint64_t l = int128_getlo(val), h = int128_gethi(val);
+
+    tcg_debug_assert(HAVE_ATOMIC128_RW);
+    asm("vinsgr2vr.d $vr0, %1, 0\n\t"
+        "vinsgr2vr.d $vr0, %2, 1\n\t"
+        "vst $vr0, %3, 0"
+	: "=m"(*ptr) : "r"(l), "r"(h), "r"(ptr) : "f0");
+}
+
+#endif /* LOONGARCH_ATOMIC128_LDST_H */
diff --git a/host/include/loongarch64/host/load-extract-al16-al8.h b/host/include/loongarch64/host/load-extract-al16-al8.h
new file mode 100644
index 0000000000..d1fb59d8af
--- /dev/null
+++ b/host/include/loongarch64/host/load-extract-al16-al8.h
@@ -0,0 +1,39 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Atomic extract 64 from 128-bit, LoongArch version.
+ *
+ * Copyright (C) 2023 Linaro, Ltd.
+ */
+
+#ifndef LOONGARCH_LOAD_EXTRACT_AL16_AL8_H
+#define LOONGARCH_LOAD_EXTRACT_AL16_AL8_H
+
+#include "host/cpuinfo.h"
+#include "tcg/debug-assert.h"
+
+/**
+ * load_atom_extract_al16_or_al8:
+ * @pv: host address
+ * @s: object size in bytes, @s <= 8.
+ *
+ * Load @s bytes from @pv, when pv % s != 0.  If [p, p+s-1] does not
+ * cross an 16-byte boundary then the access must be 16-byte atomic,
+ * otherwise the access must be 8-byte atomic.
+ */
+static inline uint64_t load_atom_extract_al16_or_al8(void *pv, int s)
+{
+    uintptr_t pi = (uintptr_t)pv;
+    Int128 *ptr_align = (Int128 *)(pi & ~7);
+    int shr = (pi & 7) * 8;
+    uint64_t l, h;
+
+    tcg_debug_assert(HAVE_ATOMIC128_RO);
+    asm("vld $vr0, %2, 0\n\t"
+        "vpickve2gr.d %0, $vr0, 0\n\t"
+        "vpickve2gr.d %1, $vr0, 1"
+	: "=r"(l), "=r"(h) : "r"(ptr_align), "m"(*ptr_align) : "f0");
+
+    return (l >> shr) | (h << (-shr & 63));
+}
+
+#endif /* LOONGARCH_LOAD_EXTRACT_AL16_AL8_H */
diff --git a/host/include/loongarch64/host/store-insert-al16.h b/host/include/loongarch64/host/store-insert-al16.h
new file mode 100644
index 0000000000..919fd8d744
--- /dev/null
+++ b/host/include/loongarch64/host/store-insert-al16.h
@@ -0,0 +1,12 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Atomic store insert into 128-bit, LoongArch version.
+ */
+
+#ifndef LOONGARCH_STORE_INSERT_AL16_H
+#define LOONGARCH_STORE_INSERT_AL16_H
+
+void store_atom_insert_al16(Int128 *ps, Int128 val, Int128 msk)
+    QEMU_ERROR("unsupported atomic");
+
+#endif /* LOONGARCH_STORE_INSERT_AL16_H */
-- 
2.34.1


