Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C21F7A23C9
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:44:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBuA-0004Xn-5o; Fri, 15 Sep 2023 12:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBu6-0004W6-VG
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:50 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBu1-0004wP-PB
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:50 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68fb6fd2836so2137923b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796164; x=1695400964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHZnlFNBtvPPOH9mS0fn2N0/KTEtZ6bjCbR6h+ACJf0=;
 b=jUAadngIND8Ll50rBMZnQfoekaFHNdGIWd02imDcMtbMBtlZInK5HpvUk0QXFdOWRF
 NEiHvpzmnzCSHk9W/TLELATsK/y4Fpimi/6VdqU+HaVd0p+NZd0a0hD7iGOtD+tIVxVw
 P9oQWSewjQJ3nfXqBK4N6K/fiQtexkvKwwsQhrzJ2IlwcTOqO4VAg1W/zFSADeFgYCjo
 /oUiBa5x9I67QFMV9hCt/5ExnJfCDW7IkhC/yNqqT7WLAe15ecKRCHM4fPKzNpgLNZy/
 lQCCNBKKvnFc7uivirmu3qEcMe44m7gbwVvGPFNG5AJM3myr9jDRlCfPUtNJdox2pimI
 UTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796164; x=1695400964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SHZnlFNBtvPPOH9mS0fn2N0/KTEtZ6bjCbR6h+ACJf0=;
 b=onZwj4RgxjwCE2pqrcuJV+LDFhuMj0N3Q/lHfKCb1UrLGG7u98NfLJl8/+//PK7DrV
 Ktej4pDAosNz8K4qE0aRWHVLgt91sLl5EVJEJpv8i+T2iw74/i4zmjQuHLFNFSljPG+2
 6ZtjK+LK0UIiXYYmTFjgZxKZ/MyUpFJmASSXUMdaqEXNrSdKPWIKPRYeaO6ZuvOvgc/Q
 wngCaoJpMosxkfcQE+acnPnL1FnMch0MEgsUt72toxWBcwgHmtOz8Xoh2hHjZgXF+UPN
 uAM/v/a2qG39OTG9Ea52z4tHHAKCy9T18NEmcuuIez1MGhaKdMfC4EQcX9mhyc7lrUP9
 qQcA==
X-Gm-Message-State: AOJu0YwICeFiNuIAyikwGB1FT6ddicMAJGz03BI9SdHWydKm3hnlN8x5
 nvdE19N8htETyC7AG4KX5+w9sh+TAQTd7cLERiI=
X-Google-Smtp-Source: AGHT+IHt7wLzZhgRaYK8Joixi7UB2RYrXUNM788+zo7vsxWlm4tKCHRjNmn3t+ARaynPINtHb+kRpQ==
X-Received: by 2002:a05:6a20:938a:b0:142:952d:3e61 with SMTP id
 x10-20020a056a20938a00b00142952d3e61mr2657794pzh.7.1694796164263; 
 Fri, 15 Sep 2023 09:42:44 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 s187-20020a6377c4000000b00577f55e4a4esm3010087pgc.20.2023.09.15.09.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:42:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Subject: [PULL 13/19] crypto: Add generic 64-bit carry-less multiply routine
Date: Fri, 15 Sep 2023 09:42:25 -0700
Message-Id: <20230915164231.123580-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915164231.123580-1-richard.henderson@linaro.org>
References: <20230915164231.123580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 host/include/generic/host/crypto/clmul.h | 15 +++++++++++++++
 include/crypto/clmul.h                   | 19 +++++++++++++++++++
 crypto/clmul.c                           | 17 +++++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 host/include/generic/host/crypto/clmul.h

diff --git a/host/include/generic/host/crypto/clmul.h b/host/include/generic/host/crypto/clmul.h
new file mode 100644
index 0000000000..915bfb88d3
--- /dev/null
+++ b/host/include/generic/host/crypto/clmul.h
@@ -0,0 +1,15 @@
+/*
+ * No host specific carry-less multiply acceleration.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef GENERIC_HOST_CRYPTO_CLMUL_H
+#define GENERIC_HOST_CRYPTO_CLMUL_H
+
+#define HAVE_CLMUL_ACCEL  false
+#define ATTR_CLMUL_ACCEL
+
+Int128 clmul_64_accel(uint64_t, uint64_t)
+    QEMU_ERROR("unsupported accel");
+
+#endif /* GENERIC_HOST_CRYPTO_CLMUL_H */
diff --git a/include/crypto/clmul.h b/include/crypto/clmul.h
index 80de516464..446931fe05 100644
--- a/include/crypto/clmul.h
+++ b/include/crypto/clmul.h
@@ -8,6 +8,9 @@
 #ifndef CRYPTO_CLMUL_H
 #define CRYPTO_CLMUL_H
 
+#include "qemu/int128.h"
+#include "host/crypto/clmul.h"
+
 /**
  * clmul_8x8_low:
  *
@@ -61,4 +64,20 @@ uint64_t clmul_16x2_odd(uint64_t, uint64_t);
  */
 uint64_t clmul_32(uint32_t, uint32_t);
 
+/**
+ * clmul_64:
+ *
+ * Perform a 64x64->128 carry-less multiply.
+ */
+Int128 clmul_64_gen(uint64_t, uint64_t);
+
+static inline Int128 clmul_64(uint64_t a, uint64_t b)
+{
+    if (HAVE_CLMUL_ACCEL) {
+        return clmul_64_accel(a, b);
+    } else {
+        return clmul_64_gen(a, b);
+    }
+}
+
 #endif /* CRYPTO_CLMUL_H */
diff --git a/crypto/clmul.c b/crypto/clmul.c
index 36ada1be9d..9e3e61a77d 100644
--- a/crypto/clmul.c
+++ b/crypto/clmul.c
@@ -92,3 +92,20 @@ uint64_t clmul_32(uint32_t n, uint32_t m32)
     }
     return r;
 }
+
+Int128 clmul_64_gen(uint64_t n, uint64_t m)
+{
+    uint64_t rl = 0, rh = 0;
+
+    /* Bit 0 can only influence the low 64-bit result.  */
+    if (n & 1) {
+        rl = m;
+    }
+
+    for (int i = 1; i < 64; ++i) {
+        uint64_t mask = -((n >> i) & 1);
+        rl ^= (m << i) & mask;
+        rh ^= (m >> (64 - i)) & mask;
+    }
+    return int128_make128(rl, rh);
+}
-- 
2.34.1


