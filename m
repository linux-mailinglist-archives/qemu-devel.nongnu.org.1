Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D977A332A
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 00:03:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhdMY-0006JH-RE; Sat, 16 Sep 2023 18:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhdMW-0006Ht-Ef
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 18:02:00 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhdMU-00047h-LV
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 18:02:00 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6bee392fe9dso2003176a34.1
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 15:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694901717; x=1695506517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ehEUavbZvgcgBL8frO9PD9bHTe622IrGxL5uXkHeD50=;
 b=J4QHpYdYmKkylvO9Iy7a/4AFxBSgFaw0V1lrbgg3AZPD8buKtVeMtUPR3M+im6KeDS
 vjUgmeK7pNGBL/sL1d67FOaiuemZd67lyrXbRP8YiYdCAv/BUQGaPVG6yUsl9IWHb3Tf
 lSlCJi93F809Zzv8Obfbn5zz3qhRpGXLB2A0wLMK/bFvwYJOuc752XFFuGqbdtXX7/dZ
 GDKVk8KwjUv5WacmaL4UPLC3L36BFZBSTlqv9KbLYPzP7QGkOjDTFPNG+Tuxy3dfz7Qm
 c5ph9YzJEUfgBCQ0mDzhdp/3a6UINTUEVGvXE1YvB4mL0d4UFXskaUSfTXjn/Vzn5tMh
 AF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694901717; x=1695506517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ehEUavbZvgcgBL8frO9PD9bHTe622IrGxL5uXkHeD50=;
 b=GVUEaM7SkWkZxYOi+sJ36MRJ+XVIU/ZvdxgE9xfz62GRWbUaQs4xWpsbyBg7UMBG4v
 owJPIz+xZUey1ckaV/vRDH3OinlAJaBhQUpXE3goCH42MC+BihV7dEB376K/9Q5uyQNo
 AIsKSZZnUk0AKQBUNv0LqcKseH3VwSO/1z43AH80Jd/Z7dSUnqywEBdAXGYgzWQevC/H
 4V9/fkCYdqwOemc4psvXwJPvLRO6rGmiaKATUoWyf0QkZBpu/FQ0h62fy53NCn06Mxd7
 rk6s4EdxqOT9EZbGsNr+0bZj1tvn5+6msZ0snq1h1d+R0cqRP34+qxmMS2P88h5iD51P
 ytTA==
X-Gm-Message-State: AOJu0YyN5u0MYnOaz1memEeiUse1iulQm2s5Y/B/ZuR/CIAFWsGSetRI
 8O8VeFHaZT27qGphPIv1Sy4dLrSwc7IyZnJ2BGI=
X-Google-Smtp-Source: AGHT+IGNGalCS+VT7NGDbEgnctBqderYyEsWDa4E82IniA4PSmY61OJ1RhEMaM0b1D/FSDivZZb5BA==
X-Received: by 2002:a05:6358:9894:b0:142:fb25:c7e6 with SMTP id
 q20-20020a056358989400b00142fb25c7e6mr4875007rwa.13.1694901717319; 
 Sat, 16 Sep 2023 15:01:57 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 q3-20020a170902788300b001b531e8a000sm5707763pll.157.2023.09.16.15.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 15:01:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name, c@jia.je, gaosong@loongson.cn, yangxiaojuan@loongson.cn
Subject: [PATCH 5/7] host/include/loongarch64: Add atomic16 load and store
Date: Sat, 16 Sep 2023 15:01:49 -0700
Message-Id: <20230916220151.526140-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916220151.526140-1-richard.henderson@linaro.org>
References: <20230916220151.526140-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


