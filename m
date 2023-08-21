Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D26CB782E39
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:19:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7cN-0001T2-4s; Mon, 21 Aug 2023 12:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cK-0001SY-57
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:00 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cH-0005b7-PN
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:18:59 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bdaeb0f29aso21174715ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692634736; x=1693239536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZGGgJ/u6kYIIhaOOh+kZR6FBn3VxoSdiYPAwK2Kqk9k=;
 b=xVCAyVBy5QIyd/LkOZ/Y1ilE3FRVG1Z8sQjCZLOomDgsqF+X/dciH7n/NI2ufoHk6V
 uK0Nn8ZPd3FRFxZEZ0WcNpGDgd12YlgIfQVQDAz7udcm/gu4sGhqunvV3VPl5fQhTp+o
 4NHldpb3mYSZ0D3jJDPJnpxMZvZaOjgW0/jMbOKlZb2CJVnjxpLwqKIHyym2cPLSgLnB
 VuLUtMX931T2DPv4KFQ2EcOBdjBDPQrsROHzZAT81teQfo48DVl7dJz/nsvGnKn0k3fu
 pMT3sIzwHkLrxL4ETzJ9wMRXaI1fky5PctH2TNi1TwjDy+BDcpRSf9goeIl+NAk/e0Y5
 Kn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692634736; x=1693239536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZGGgJ/u6kYIIhaOOh+kZR6FBn3VxoSdiYPAwK2Kqk9k=;
 b=YzCMIXPpmnce/LFWDNw7kAa8As+WAoZr5wz47DJ3R4yZTIYRp20QpZqxQaocWU8xS7
 rGkONUi2yC+dLvePDAEUw1pd+ye4SbdkIU/htEBh4A39pV2ZtHga3xclFnfkaZzDENgv
 UsIQzRhVbjd4YJwFTQiWVj8mNkjreU4Df6MpJOMIiDRCamz1hCAT+UkIvLA7t/F5v9rv
 hmzBkqGvvHccJFY2l8rVdLEYGmEKttz2O42S/a1G5SNYM0ZNBhb+ju5iDHjSsy0zprj2
 YaYATyZcgvbyqrkXtdM40iGr7gpavcff6D5XrQmCrihFK+hzUzdbhX8qsx84U0gdqj7h
 g6Pg==
X-Gm-Message-State: AOJu0Yy2R8ELegcxmkLa7H7cno6o0h1zqP1UuImxGwiud3z0Wd4oyey6
 Ugpy1KkwgJ58jbD6SjswZHyNcYWFr+SnYNBzYHk=
X-Google-Smtp-Source: AGHT+IFMeKYZYqJuuWtVLnhyDaRSnsrQqKS4ad391O2rH6ZTixH6Fcn5fpM6oUpiMDcwR+d4IBZX9A==
X-Received: by 2002:a17:902:ce81:b0:1bd:d92d:6b2 with SMTP id
 f1-20020a170902ce8100b001bdd92d06b2mr5570741plg.10.1692634736293; 
 Mon, 21 Aug 2023 09:18:56 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001ab2b4105ddsm7234549plh.60.2023.08.21.09.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:18:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v3 01/19] crypto: Add generic 8-bit carry-less multiply
 routines
Date: Mon, 21 Aug 2023 09:18:35 -0700
Message-Id: <20230821161854.419893-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161854.419893-1-richard.henderson@linaro.org>
References: <20230821161854.419893-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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


