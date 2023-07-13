Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11927752C00
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:18:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3eZ-0000PW-PX; Thu, 13 Jul 2023 17:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eK-0000JL-Q7
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:56 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eA-00015n-Ee
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:56 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-314172bac25so1314823f8f.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689282883; x=1691874883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l0ncNfWBAGzw2Z/9Y0q3EwyOwTxxOZI+c9r6426RCJU=;
 b=BsC33UBaPd62v8wYZAzibIOrEqPjHaemGFzIHaluNLbbFA7PoVDhbQLxiIoP4ZKeGN
 a5d+shms0krmastJj2MsGiqJccH64HeMgkmg/r/L4o/cysFOuDS3DiSXy/l5IAIbKCEc
 c7elm1Z0+GXa43d6h+j9DTHCTX0Hp8NGgXAS1G91HaCVs6jpBE6n6j1LNRnPs0DNFxV2
 eDgobUC7ePWtXLhgyPwcimFTBPSgs56NOQ7WcClekv+EybQsRZ8AJ9gdkDRJevUqgMqZ
 qFzvMQDPIESuLqs12gjxMRCe/os6+Zf6TvfftQwB0kGNwFxN8pVNuPPfZgZP3MLdKXkn
 TRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689282883; x=1691874883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l0ncNfWBAGzw2Z/9Y0q3EwyOwTxxOZI+c9r6426RCJU=;
 b=ZJSbULchtjy0ow+2aqVNRlaWAXlJ7NUyUSyyNmPxTHfRfdgBrmy0JEVMs+0vl69uBo
 quAI5grjm+4uPM4h+0aH1yEJleiIelQb2Jl9aeqOcrR6zaNA1/cEmbu740g35DxC1lx9
 GMxmW2W8Bo7kaEwRnTzR5xD5zjRl30LAYpKqgqLd03rbpcSx/jEjyKm8oYnX0TeXb6zg
 dphxSxhL9tvZCjWVvcJiY0G9tRw9ANXeLLdFry1zcLYhKnVE/7W9bbXD4ZqlIZNGkqeX
 TsoMevdwHNjsztIrs6hdDIbVCnwtBbA59zghXOWMFdmGRM5rYvXrLy+p1q605qrNi6/P
 9EZg==
X-Gm-Message-State: ABy/qLYNRryCFC9prB87Hf8vsl0FOJhqpNb0/8ZBwOmZKwEMfUjWJIk5
 yP49UvXN2XxOIqHTlg6DQkjcy4UuJhmsdfjOQPWGFXJb
X-Google-Smtp-Source: APBJJlHVgKXQalPDHUCiHqcn/EPZ6vm60u4xcvs0eQ/UvqiYbDqe6q9RwQ7zKR5lo7VqqYI3NPvPmA==
X-Received: by 2002:adf:ecc9:0:b0:314:182a:3d96 with SMTP id
 s9-20020adfecc9000000b00314182a3d96mr2662392wro.28.1689282883414; 
 Thu, 13 Jul 2023 14:14:43 -0700 (PDT)
Received: from stoup.. ([85.193.156.66]) by smtp.gmail.com with ESMTPSA id
 n12-20020adff08c000000b0030ada01ca78sm8973747wro.10.2023.07.13.14.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 14:14:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH 01/18] crypto: Add generic 8-bit carry-less multiply routines
Date: Thu, 13 Jul 2023 22:14:18 +0100
Message-Id: <20230713211435.13505-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713211435.13505-1-richard.henderson@linaro.org>
References: <20230713211435.13505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/crypto/clmul.h | 17 ++++++
 include/crypto/clmul.h                   | 61 +++++++++++++++++++
 crypto/clmul.c                           | 76 ++++++++++++++++++++++++
 crypto/meson.build                       |  9 ++-
 4 files changed, 160 insertions(+), 3 deletions(-)
 create mode 100644 host/include/generic/host/crypto/clmul.h
 create mode 100644 include/crypto/clmul.h
 create mode 100644 crypto/clmul.c

diff --git a/host/include/generic/host/crypto/clmul.h b/host/include/generic/host/crypto/clmul.h
new file mode 100644
index 0000000000..694705f703
--- /dev/null
+++ b/host/include/generic/host/crypto/clmul.h
@@ -0,0 +1,17 @@
+/*
+ * No host specific carry-less multiply acceleration.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef GENERIC_HOST_CRYPTO_CLMUL_H
+#define GENERIC_HOST_CRYPTO_CLMUL_H
+
+/* Defer everything to the generic routines. */
+#define clmul_8x8_low           clmul_8x8_low_gen
+#define clmul_8x4_even          clmul_8x4_even_gen
+#define clmul_8x4_odd           clmul_8x4_odd_gen
+#define clmul_8x8_even          clmul_8x8_even_gen
+#define clmul_8x8_odd           clmul_8x8_odd_gen
+#define clmul_8x8_packed        clmul_8x8_packed_gen
+
+#endif /* GENERIC_HOST_CRYPTO_CLMUL_H */
diff --git a/include/crypto/clmul.h b/include/crypto/clmul.h
new file mode 100644
index 0000000000..7f19205d6f
--- /dev/null
+++ b/include/crypto/clmul.h
@@ -0,0 +1,61 @@
+/*
+ * Carry-less multiply
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (C) 2023 Linaro, Ltd.
+ */
+
+#ifndef CRYPTO_CLMUL_H
+#define CRYPTO_CLMUL_H
+
+#include "qemu/int128.h"
+
+/**
+ * clmul_8x8_low:
+ *
+ * Perform eight 8x8->8 carry-less multiplies.
+ */
+uint64_t clmul_8x8_low_gen(uint64_t, uint64_t);
+
+/**
+ * clmul_8x4_even:
+ *
+ * Perform four 8x8->16 carry-less multiplies.
+ * The odd bytes of the inputs are ignored.
+ */
+uint64_t clmul_8x4_even_gen(uint64_t, uint64_t);
+
+/**
+ * clmul_8x4_odd:
+ *
+ * Perform four 8x8->16 carry-less multiplies.
+ * The even bytes of the inputs are ignored.
+ */
+uint64_t clmul_8x4_odd_gen(uint64_t, uint64_t);
+
+/**
+ * clmul_8x8_even:
+ *
+ * Perform eight 8x8->16 carry-less multiplies.
+ * The odd bytes of the inputs are ignored.
+ */
+Int128 clmul_8x8_even_gen(Int128, Int128);
+
+/**
+ * clmul_8x8_odd:
+ *
+ * Perform eight 8x8->16 carry-less multiplies.
+ * The even bytes of the inputs are ignored.
+ */
+Int128 clmul_8x8_odd_gen(Int128, Int128);
+
+/**
+ * clmul_8x8_packed:
+ *
+ * Perform eight 8x8->16 carry-less multiplies.
+ */
+Int128 clmul_8x8_packed_gen(uint64_t, uint64_t);
+
+#include "host/crypto/clmul.h"
+
+#endif /* CRYPTO_CLMUL_H */
diff --git a/crypto/clmul.c b/crypto/clmul.c
new file mode 100644
index 0000000000..866704e751
--- /dev/null
+++ b/crypto/clmul.c
@@ -0,0 +1,76 @@
+/*
+ * No host specific carry-less multiply acceleration.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "crypto/clmul.h"
+
+uint64_t clmul_8x8_low_gen(uint64_t n, uint64_t m)
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
+uint64_t clmul_8x4_even_gen(uint64_t n, uint64_t m)
+{
+    uint64_t r = 0;
+
+    n &= 0x00ff00ff00ff00ffull;
+    m &= 0x00ff00ff00ff00ffull;
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
+uint64_t clmul_8x4_odd_gen(uint64_t n, uint64_t m)
+{
+    return clmul_8x4_even_gen(n >> 8, m >> 8);
+}
+
+Int128 clmul_8x8_even_gen(Int128 n, Int128 m)
+{
+    uint64_t rl, rh;
+
+    rl = clmul_8x4_even_gen(int128_getlo(n), int128_getlo(m));
+    rh = clmul_8x4_even_gen(int128_gethi(n), int128_gethi(m));
+    return int128_make128(rl, rh);
+}
+
+Int128 clmul_8x8_odd_gen(Int128 n, Int128 m)
+{
+    uint64_t rl, rh;
+
+    rl = clmul_8x4_odd_gen(int128_getlo(n), int128_getlo(m));
+    rh = clmul_8x4_odd_gen(int128_gethi(n), int128_gethi(m));
+    return int128_make128(rl, rh);
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
+Int128 clmul_8x8_packed_gen(uint64_t n, uint64_t m)
+{
+    uint64_t rl, rh;
+
+    rl = clmul_8x4_even_gen(unpack_8_to_16(n), unpack_8_to_16(m));
+    rh = clmul_8x4_even_gen(unpack_8_to_16(n >> 32), unpack_8_to_16(m >> 32));
+    return int128_make128(rl, rh);
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


