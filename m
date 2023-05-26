Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDC5711B18
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 02:26:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2LFB-0002XU-Sa; Thu, 25 May 2023 20:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LF8-0002W3-RP
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:43 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LF6-00028u-38
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:42 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-53063897412so157208a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 17:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685060619; x=1687652619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pGac7UlZVA4AZdD7xsv1J+iiIMdZOvspUsCJpDvtWoE=;
 b=ZSWlFJTOFcRK1Sy5MZLSOtwj/l+plhdh/pw7euLATZrRd6SntatWa0e4bgShZjflCZ
 JrQKiVszYbJNmb6IZqo4khgtb+wFyVvHxQEbsP444yuVMd3FQkWBl9mP8xDpWqPKgZGL
 mzG+D5Dq99qwquplogQr3EUS2qBC05y8MIe3mDGHDSWY6nSs+MjukpHo+bAt+ta7esaV
 O6XB65JcOsFlgpCY5BRmxIAS2xyDVn1XDVqy3VpMHYcgl1BJ/qtFpqSI3mQzzowUMQ8I
 vexjeLdh9Sm/7YaHoDEGP/MNik1e+azX8JCxTm9y/cFzaX/TJy2qorijXglQHvr8+WEu
 bqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685060619; x=1687652619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pGac7UlZVA4AZdD7xsv1J+iiIMdZOvspUsCJpDvtWoE=;
 b=Y5e9ff6ZFXJICJcWy92mqik30t68eUqnoPXcJuo0X7BySEUkUqafi+10HdLFUglQN+
 2yuFyWPPfPjm2j41peuFQRlBQ78W3+bq9hK6klTarnCgZK2zaFxhnXpSDAValDSkCizK
 6hT6bUdQeQ58OR1hOuQiAweZdeJt3/uM4WU2OC/2pz/kFxL0sdjfp4WCcxbSKZWQ8nDE
 O7SqbTDP2ja57JBdkzTBvRwr30H+y3Jj/xpVvrI/3NZnaYWEpX7hYSen98wGCX2xzEYm
 roi2NuB3KoG8h9J08Azr3TfbQjLcfzz6MZEbrRxPMfyHyTPR4jLecdCR3XbckrXa6Zv4
 z3fw==
X-Gm-Message-State: AC+VfDw17E3LcKDNB6d2EVwNVMcXRpB3PC9EizQLMLlw05EhuK8Nj7Hd
 3egFtJHYowLMOGKGp+NXyy/sTgvMpc8+Y9JSE7I=
X-Google-Smtp-Source: ACHHUZ5isXcobq+ww90kDT/ZJZA1WPLJOWx6ACOL5Kb24zUM0wi9FKj2DOyw6e1UEEQNGw3X/s7A5Q==
X-Received: by 2002:a05:6a20:430b:b0:10c:3535:162f with SMTP id
 h11-20020a056a20430b00b0010c3535162fmr123866pzk.0.1685060618826; 
 Thu, 25 May 2023 17:23:38 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s188-20020a635ec5000000b0053491d92b65sm1675593pgb.84.2023.05.25.17.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 17:23:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 04/16] qemu/atomic128: Add x86_64 atomic128-ldst.h
Date: Thu, 25 May 2023 17:23:22 -0700
Message-Id: <20230526002334.1760495-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526002334.1760495-1-richard.henderson@linaro.org>
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

With CPUINFO_ATOMIC_VMOVDQA, we can perform proper atomic
load/store without cmpxchg16b.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/x86_64/host/atomic128-ldst.h | 68 +++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 host/include/x86_64/host/atomic128-ldst.h

diff --git a/host/include/x86_64/host/atomic128-ldst.h b/host/include/x86_64/host/atomic128-ldst.h
new file mode 100644
index 0000000000..adc9332f91
--- /dev/null
+++ b/host/include/x86_64/host/atomic128-ldst.h
@@ -0,0 +1,68 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Load/store for 128-bit atomic operations, x86_64 version.
+ *
+ * Copyright (C) 2023 Linaro, Ltd.
+ *
+ * See docs/devel/atomics.rst for discussion about the guarantees each
+ * atomic primitive is meant to provide.
+ */
+
+#ifndef AARCH64_ATOMIC128_LDST_H
+#define AARCH64_ATOMIC128_LDST_H
+
+#ifdef CONFIG_INT128_TYPE
+#include "host/cpuinfo.h"
+#include "tcg/debug-assert.h"
+
+/*
+ * Through clang 16, with -mcx16, __atomic_load_n is incorrectly
+ * expanded to a read-write operation: lock cmpxchg16b.
+ */
+
+#define HAVE_ATOMIC128_RO  likely(cpuinfo & CPUINFO_ATOMIC_VMOVDQA)
+#define HAVE_ATOMIC128_RW  1
+
+static inline Int128 atomic16_read_ro(const Int128 *ptr)
+{
+    Int128Alias r;
+
+    tcg_debug_assert(HAVE_ATOMIC128_RO);
+    asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr));
+
+    return r.s;
+}
+
+static inline Int128 atomic16_read_rw(Int128 *ptr)
+{
+    __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
+    Int128Alias r;
+
+    if (HAVE_ATOMIC128_RO) {
+        asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr_align));
+    } else {
+        r.i = __sync_val_compare_and_swap_16(ptr_align, 0, 0);
+    }
+    return r.s;
+}
+
+static inline void atomic16_set(Int128 *ptr, Int128 val)
+{
+    __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
+    Int128Alias new = { .s = val };
+
+    if (HAVE_ATOMIC128_RO) {
+        asm("vmovdqa %1, %0" : "=m"(*ptr_align) : "x" (new.i));
+    } else {
+        __int128_t old;
+        do {
+            old = *ptr_align;
+        } while (!__sync_bool_compare_and_swap_16(ptr_align, old, new.i));
+    }
+}
+#else
+/* Provide QEMU_ERROR stubs. */
+#include "host/include/generic/host/atomic128-ldst.h"
+#endif
+
+#endif /* AARCH64_ATOMIC128_LDST_H */
-- 
2.34.1


