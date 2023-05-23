Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8937D70DDE7
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:50:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SMu-0001Ac-SB; Tue, 23 May 2023 09:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMs-00017r-4Z
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:48:02 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMq-0001AT-If
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:48:01 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d426e63baso4400909b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849678; x=1687441678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FvkUN9jgmDAOLN4anBgxZjSYCqoddaXAUfRdd1Denco=;
 b=Ukqy8hdLZBFZB8fCERx5VXrZEUf/5gIXs3k0aJmXOk6ORfQc+4CFnvp1F3DVahsVuY
 YUAl4tJY0Xyz8f47LzmoHvlI5psGIIT4Yz2yjup+7gOj4X2fj6CG4CtkL2zeU6invWCz
 LzJjPl9kPLy8KdN6mOQzpy+3Bt/LeEua2uHRS5Myqcm2cCJd0+MPK1wu6NnjECfmvjeI
 z0vvoNxt10i4M3fkOaimQkP14MlUMEg3JZ+Ajlm3y3EZUsAnQJP5K6E9I6yu8WuJWWlR
 owcPIOqBqyy023UI8reEAU7YZ4Xj08InH5T+Iz9rQoLWVReA+q4vqdrbNpYxNEtWC7x3
 lqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849678; x=1687441678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FvkUN9jgmDAOLN4anBgxZjSYCqoddaXAUfRdd1Denco=;
 b=SAr4g+a0GbMTJCXA7QKBOPqKke9yi+zKzktNIwjQ9kn35sTO2XFbmZdp+lKaAHiRi3
 ljUC2XrP7aQeYq+yOJOO5Qkybb1tHBXT4mGu+/fU6kZC7kItIdZ/10m6OsSV6NL+4ELU
 X7dImBU2A8D9vRp+wE89p2RaQUAMJFKgez0Ka47vU7l9rmsr37IejPX0uVU29NLW13Wv
 uGVygvtpHDwEMM9h6j9tK7V+HRZ2JrvgWpxoPXM5Dsp7Q94eNcnvvsq21ceY8QwiXOLM
 74fO/Son0gTx/coQQOnwHCiowBgm6rqWhPgFZarPUstqIKFmGLpXgwSpGEscXbqOjz46
 DYbg==
X-Gm-Message-State: AC+VfDwHFZUJmJSwISRzXUPPJ5lu5k4jULApk/ef5dbOquVDYZHObU48
 KeZZu3HBjtMPmgUQxBoh74u2fLEjIJ8mJhK1vnM=
X-Google-Smtp-Source: ACHHUZ4TNtzdzbBNmnf1kQCrSrUPCjt43QGLUmiSe3f0lJuWKeNGw/uhPZnk5fuz+gWbRCJzbzT01A==
X-Received: by 2002:a05:6a00:1788:b0:636:e52f:631e with SMTP id
 s8-20020a056a00178800b00636e52f631emr19931490pfg.1.1684849678344; 
 Tue, 23 May 2023 06:47:58 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 j4-20020aa79284000000b0064d1349dc31sm5737122pfa.199.2023.05.23.06.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:47:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 27/27] qemu/atomic128: Add x86_64 atomic128-ldst.h
Date: Tue, 23 May 2023 06:47:33 -0700
Message-Id: <20230523134733.678646-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523134733.678646-1-richard.henderson@linaro.org>
References: <20230523134733.678646-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/x86_64/host/atomic128-ldst.h | 54 +++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 host/include/x86_64/host/atomic128-ldst.h

diff --git a/host/include/x86_64/host/atomic128-ldst.h b/host/include/x86_64/host/atomic128-ldst.h
new file mode 100644
index 0000000000..4be9071d3f
--- /dev/null
+++ b/host/include/x86_64/host/atomic128-ldst.h
@@ -0,0 +1,54 @@
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
+#include "host/cpuinfo.h"
+#include "tcg/debug-assert.h"
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
+    Int128Alias r;
+
+    if (HAVE_ATOMIC128_RO) {
+        asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr));
+    } else {
+        r.i = __sync_val_compare_and_swap_16(ptr, 0, 0);
+    }
+    return r.s;
+}
+
+static inline void atomic16_set(Int128 *ptr, Int128Alias val)
+{
+    if (HAVE_ATOMIC128_RO) {
+        asm("vmovdqa %1, %0" : "=m"(*ptr) : "x" (val.i));
+    } else {
+        Int128Alias old;
+        do {
+            old.s = *ptr;
+        } while (!__sync_bool_compare_and_swap_16(ptr, old.i, val.i));
+    }
+}
+
+#endif /* AARCH64_ATOMIC128_LDST_H */
-- 
2.34.1


