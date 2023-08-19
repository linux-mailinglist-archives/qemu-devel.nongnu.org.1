Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C4A781636
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:03:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAMH-0008Q9-3j; Fri, 18 Aug 2023 21:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAME-0008PU-QI
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:26 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMC-0007Kh-Am
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:26 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bc3d94d40fso12489335ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692406941; x=1693011741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZGGgJ/u6kYIIhaOOh+kZR6FBn3VxoSdiYPAwK2Kqk9k=;
 b=Dvc7qTBv4QzAtYROGST9D2CmvA+u5/pauRnyedkdFuaYG0M4LePTS30ayluwjGTNFB
 lxjij/nbWXA+YZ5Wr7uzqqv3SDEdegCDNscxDPiX5cQpkZjnchNQKg5fHDQUUMWycytM
 6ANpBIewuUrl0j5OM4EYqCQxavGgSr0Rhl+bJ4BYZwHFZg88++n52XlnaoVK5wwTE9Ka
 I0dmoMbBh5qLtIUejrhyI0QxSlWicMup7lhAcSaZ5EDII/6PV/9N/Qv96oluo37As19u
 0HeF+1w9orckytIV8uTQBRYBMUayQP/NfgpD3KNfCa90hVm0Q5dGeWfBUB/mg7xqivOo
 j7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692406941; x=1693011741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZGGgJ/u6kYIIhaOOh+kZR6FBn3VxoSdiYPAwK2Kqk9k=;
 b=SncrRIjg17ElS7zcYbYDJRKhR71h2RGAzd9HQpZ1KOqXu2NAXknCnYmX0H39vS5uXx
 /M7pAATXbUFg5ByCseNU9MM3qNttSuwJSyjuu27PgWK/ftddB0XXyOsVrqc6/QkrgVO4
 TLgGur2uY08vOFtvkCrJlOX/+j0Y7xO1UHtpZPVjQSVvCWbhBdMNdeQ4QfDpzCn+mT3b
 p5O/QZ4KVxjeSGJ1dFPcsSNEZW5glbkyHZzXqqV1HBqUZSPeXdXZwHmWUX5IZieRYgYQ
 aZ0kncASAbY4i22iNdlWvY3l/4uD+sVrlhkojmLHKwhy9KIdLh775uiDmVhgSJDhbpSq
 i1ew==
X-Gm-Message-State: AOJu0YwwjWannVxds8OxSYkz9sqLnppqAOm3ZLgvxgfY+gCz4jHq8Xwg
 zYMmai38mfkS1OCP7laj7G2fQkxMHbi9D7lYpzI=
X-Google-Smtp-Source: AGHT+IGiCkFufyQQhHTuh5zYx+F7fuplXdt9vwYJUs6/TQyzxJRQ51/adNSTemX60adj88Y4EevvXw==
X-Received: by 2002:a17:902:ec8f:b0:1bb:ce4a:5893 with SMTP id
 x15-20020a170902ec8f00b001bbce4a5893mr1054184plg.30.1692406941410; 
 Fri, 18 Aug 2023 18:02:21 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902d50d00b001b87bedcc6fsm2372019plg.93.2023.08.18.18.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:02:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v2 01/18] crypto: Add generic 8-bit carry-less multiply
 routines
Date: Fri, 18 Aug 2023 18:02:01 -0700
Message-Id: <20230819010218.192706-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819010218.192706-1-richard.henderson@linaro.org>
References: <20230819010218.192706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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


