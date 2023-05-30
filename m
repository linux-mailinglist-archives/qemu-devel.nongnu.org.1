Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69654716D12
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:04:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44Zv-0000tq-9p; Tue, 30 May 2023 15:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44ZZ-0000nB-IE
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:59:59 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44ZX-0000sl-Tt
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:59:57 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64d5b4c400fso5416825b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 11:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473194; x=1688065194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pGac7UlZVA4AZdD7xsv1J+iiIMdZOvspUsCJpDvtWoE=;
 b=Ry/Wwj1OgzM9Q2VHhqT3iGB+vqfmjdwEaUQYGgjQTsTevMtwQ2ufA80r/z4Vm1sVcq
 RZWll1K+sZPnpO13xXDAE59hiyTy3dTWBTZXa58YIekZbHktPLobxNd/fYz45YsvyyC9
 n7sEA26r5VQs1K4/Z+0ReW/YfsMDuc2bwLGzor/0lrFmdKXKxaY4/ISHwHWPFfo1o0fh
 r19LNbqld/KRNkJlZ6K2GvYQSJK35lDTz34NcJd/Qh4VHXHLnKdNlKtQk1P6wI1CHAcj
 Uo+IwgixUXazAc81ZYN0CY2yhhochB0izJQM+2glWT82vASNJiV4rZB3YaLuGcvaU8rY
 LUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473194; x=1688065194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pGac7UlZVA4AZdD7xsv1J+iiIMdZOvspUsCJpDvtWoE=;
 b=EBk0zNa8R6gFeosMPiu5Q1WBOje42sEGhai93QgUOFPvCdbi6admxBlTJ1T0tjQ+rO
 7+bt9mUXRBDB7xjvNp05nw6ni/80jeD2UvwnWlOlOlN09vBqC27t0xfuz0sBf9r22eIF
 qjz1vrO4VI3yqGOsButJXA4WvTKTFkiHJh4MpyP0ZlQ/zNQzWtqQl/ZqlOQl/nxfpT7Q
 apNGZXoCegNN5Wba3Rkd5CZEruEmvajtyGYjHtJo50ktmA0CHZO1YWZgDRrQb3YsiMfJ
 vpslbq4tl4EzpduhFR9qfEpUSX/L0js7Y5/dJSHtNwHfA9ZAKaI4oJcfH21CyZX8xddw
 HRdw==
X-Gm-Message-State: AC+VfDwSmGp96FiVICBJcUjGUqiUhQCvFUeol4ywNzeiFPA5id4Srl5z
 r/Pda0oZyVZ4Lk79K7CnwyNqkIh9b/C7EPHoOW8=
X-Google-Smtp-Source: ACHHUZ4i7HuL8IDns2oSPB3imNFCVkdzLIFBd6LJiTOROon5gQFhAv85KWI06xvUg5W4mR4TuOakBQ==
X-Received: by 2002:a05:6a20:e185:b0:109:38b4:a210 with SMTP id
 ks5-20020a056a20e18500b0010938b4a210mr3209840pzb.29.1685473194126; 
 Tue, 30 May 2023 11:59:54 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.11.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 11:59:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 04/27] qemu/atomic128: Add x86_64 atomic128-ldst.h
Date: Tue, 30 May 2023 11:59:26 -0700
Message-Id: <20230530185949.410208-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


