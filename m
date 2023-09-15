Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3957A23D0
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:45:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBtu-0004QY-IO; Fri, 15 Sep 2023 12:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBts-0004Kf-OG
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:36 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBtr-0004sq-4E
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:36 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68fe39555a0so2117534b3a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796153; x=1695400953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1NLv1NBVG2fZ70ohDbUJX8NkURlg/p6IknSOTaveXw=;
 b=T6oMtT9WVYjCicF1ZWc7TNMa6Yn3ik7rnBAsqvlZmPoG7EQKquju2V1NjQdkPvHLws
 y7wgx5tWN/4J67jjrjYrdDwCXMR03jLNMtzQDQsKlyNz/E5c41ZhdWdrY8uEhEVUr1Iz
 QZUqJQ+LdEQ3R0BeiNVz0bj9p4Cu/8Voq5WOfskeyZvtJKU4QAJxchTEZH7r6H5PIhbR
 rCmWfVxWpabXbR+mAzqPq3d/IPK14lPwfWaX9Y9YmQNtedS0HmKM4+OKwvhT2rT10Sva
 LhpN+hMp3mCl9/+nfeG8RzCPvmPNCwztNN4Bko39Li6K5nW9wN7ozM8AYkPYkaFMQHcT
 yV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796153; x=1695400953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b1NLv1NBVG2fZ70ohDbUJX8NkURlg/p6IknSOTaveXw=;
 b=YfUgnAoK3SZgBk1H6kg3GRkB5LnuoRjykoZbb6nMpnuub2KPzGC9KmSB++uV1Z6udA
 uaOBQ//jhYsrf/d+yggLPBbYQ9GAixZG5GAB7O6fut1l7ERlccsreZyIWmbgg7sJML4D
 oHTrpvglXfHY1dI1qAheYlh35oAch9ES1k1ghFPxcWm/G0Sqeo6GfW0zO9DtNTsYwGi5
 bMQG0w/9YfC+0yACPLyT/uwG5Dqx2zFApJRuh+oYDgdEDqa0yb8LqfgglwG2Vvw+twO/
 dqI15boNiuYyq4i3Q7t4qi00BYuA4s4BxJFCMMDqePAWX3kLdcuLPchW29eO9PDTt+fr
 GJbA==
X-Gm-Message-State: AOJu0YzYB8Dk1q5NXfaFVBHZC7kZpwzEMikayCUuJbXzyERxwro5YwIQ
 QQdk04x9e2z6IrYqku/dsFI9O54UhYFPLJVhEzI=
X-Google-Smtp-Source: AGHT+IE6OenehM6n0Mr2sksr74NaeTtKfpDKQPgcpn2z1PjSrC+FuU4I+EPRRyAK8ACrALpPyxrEhA==
X-Received: by 2002:a05:6a00:1996:b0:68f:dfea:9100 with SMTP id
 d22-20020a056a00199600b0068fdfea9100mr2451745pfl.21.1694796153619; 
 Fri, 15 Sep 2023 09:42:33 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 s187-20020a6377c4000000b00577f55e4a4esm3010087pgc.20.2023.09.15.09.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:42:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Subject: [PULL 01/19] crypto: Add generic 8-bit carry-less multiply routines
Date: Fri, 15 Sep 2023 09:42:13 -0700
Message-Id: <20230915164231.123580-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915164231.123580-1-richard.henderson@linaro.org>
References: <20230915164231.123580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/crypto/clmul.h | 41 +++++++++++++++++++++++++++++
 crypto/clmul.c         | 60 ++++++++++++++++++++++++++++++++++++++++++
 crypto/meson.build     |  9 ++++---
 3 files changed, 107 insertions(+), 3 deletions(-)
 create mode 100644 include/crypto/clmul.h
 create mode 100644 crypto/clmul.c

diff --git a/include/crypto/clmul.h b/include/crypto/clmul.h
new file mode 100644
index 0000000000..153b5e3057
--- /dev/null
+++ b/include/crypto/clmul.h
@@ -0,0 +1,41 @@
+/*
+ * Carry-less multiply operations.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (C) 2023 Linaro, Ltd.
+ */
+
+#ifndef CRYPTO_CLMUL_H
+#define CRYPTO_CLMUL_H
+
+/**
+ * clmul_8x8_low:
+ *
+ * Perform eight 8x8->8 carry-less multiplies.
+ */
+uint64_t clmul_8x8_low(uint64_t, uint64_t);
+
+/**
+ * clmul_8x4_even:
+ *
+ * Perform four 8x8->16 carry-less multiplies.
+ * The odd bytes of the inputs are ignored.
+ */
+uint64_t clmul_8x4_even(uint64_t, uint64_t);
+
+/**
+ * clmul_8x4_odd:
+ *
+ * Perform four 8x8->16 carry-less multiplies.
+ * The even bytes of the inputs are ignored.
+ */
+uint64_t clmul_8x4_odd(uint64_t, uint64_t);
+
+/**
+ * clmul_8x4_packed:
+ *
+ * Perform four 8x8->16 carry-less multiplies.
+ */
+uint64_t clmul_8x4_packed(uint32_t, uint32_t);
+
+#endif /* CRYPTO_CLMUL_H */
diff --git a/crypto/clmul.c b/crypto/clmul.c
new file mode 100644
index 0000000000..82d873fee5
--- /dev/null
+++ b/crypto/clmul.c
@@ -0,0 +1,60 @@
+/*
+ * Carry-less multiply operations.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (C) 2023 Linaro, Ltd.
+ */
+
+#include "qemu/osdep.h"
+#include "crypto/clmul.h"
+
+uint64_t clmul_8x8_low(uint64_t n, uint64_t m)
+{
+    uint64_t r = 0;
+
+    for (int i = 0; i < 8; ++i) {
+        uint64_t mask = (n & 0x0101010101010101ull) * 0xff;
+        r ^= m & mask;
+        m = (m << 1) & 0xfefefefefefefefeull;
+        n >>= 1;
+    }
+    return r;
+}
+
+static uint64_t clmul_8x4_even_int(uint64_t n, uint64_t m)
+{
+    uint64_t r = 0;
+
+    for (int i = 0; i < 8; ++i) {
+        uint64_t mask = (n & 0x0001000100010001ull) * 0xffff;
+        r ^= m & mask;
+        n >>= 1;
+        m <<= 1;
+    }
+    return r;
+}
+
+uint64_t clmul_8x4_even(uint64_t n, uint64_t m)
+{
+    n &= 0x00ff00ff00ff00ffull;
+    m &= 0x00ff00ff00ff00ffull;
+    return clmul_8x4_even_int(n, m);
+}
+
+uint64_t clmul_8x4_odd(uint64_t n, uint64_t m)
+{
+    return clmul_8x4_even(n >> 8, m >> 8);
+}
+
+static uint64_t unpack_8_to_16(uint64_t x)
+{
+    return  (x & 0x000000ff)
+         | ((x & 0x0000ff00) << 8)
+         | ((x & 0x00ff0000) << 16)
+         | ((x & 0xff000000) << 24);
+}
+
+uint64_t clmul_8x4_packed(uint32_t n, uint32_t m)
+{
+    return clmul_8x4_even_int(unpack_8_to_16(n), unpack_8_to_16(m));
+}
diff --git a/crypto/meson.build b/crypto/meson.build
index 5f03a30d34..9ac1a89802 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -48,9 +48,12 @@ if have_afalg
 endif
 crypto_ss.add(when: gnutls, if_true: files('tls-cipher-suites.c'))
 
-util_ss.add(files('sm4.c'))
-util_ss.add(files('aes.c'))
-util_ss.add(files('init.c'))
+util_ss.add(files(
+  'aes.c',
+  'clmul.c',
+  'init.c',
+  'sm4.c',
+))
 if gnutls.found()
   util_ss.add(gnutls)
 endif
-- 
2.34.1


