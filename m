Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E50782E40
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:20:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7cr-0001oP-IV; Mon, 21 Aug 2023 12:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cZ-0001Vb-A1
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:17 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cS-0005dZ-RB
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:10 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bba48b0bd2so21246505ad.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692634747; x=1693239547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v9aGtnTZpFDMgY3v11X1zR3alCRPd1TwbYXyjZl8p88=;
 b=YkRmhrz4bFm+nEFxqDe/RyAxNveMWtH8J4e6a8ZZPGW4EgcCGkImG8BzpuuZM2xdVk
 wJ5230HdpgWIlQvp1Y2+6eqXvyJ93OkGhnBxlxVfEt4jui6I55yUw1Yh1KiDVKgZZsJH
 ATceOlujXKy1QPvSCTcaySY9UIaFBv748Iu8VPICPekPgr0WPtEHiSbD7I/FuvXEmnz5
 tkyl+IhgEREKTo3YAVlF0PrUFm48E6vgkQISZg5ySnP/WmvecqMeuUC/LP1qLmYnbfM9
 XCwOF5n326/Bozoz5/TjQJQf9L3fnGDseYKlvbnZ6zGW5VuXoNe75bJ1xA5rpt11T3p3
 XjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692634747; x=1693239547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v9aGtnTZpFDMgY3v11X1zR3alCRPd1TwbYXyjZl8p88=;
 b=ErW7ghAIJOG/CBpvN8OPMtIH1YruPXKcpbL1PeMWL9fVhb07NnPVQ+CE09+6vJbtO4
 ukM9hjgEVPa0LdvwtT5J1AQNJfZrWDAftlaokEcoTqVkZ/NFFn12FCmAfTvtMzo0Zfse
 xouFWzC5slukQCwQ7HfIMDBvMdGGjigtGx/Kz0uwiDmTIXaCocwZFW8u1GhwUQEXbmNU
 R5L5WtDTcCEiWShjlbzw7dBJzKRdiIc59ZsV5+Fa6waxEvRoiG3uS2IBhZy3CA+wTglj
 n1fXWaSgT+oao+aqCu8wu6vGEwsiKWWLgTKDU5bP/XMFsv4hXFZvzDjhS/d3nxnWursc
 JmGw==
X-Gm-Message-State: AOJu0YzFUdEKdmCkNmDg1nQXRuzDTAOniKKReKLFw630lJZUOZtN5AJJ
 LOMRcVAyHVIlYhz0TGwluSMtjqsWzmzz+rT2eSg=
X-Google-Smtp-Source: AGHT+IFgY6XLmDaXILyS8S2Dynfb84eJiOP4xfCRxuNMp8CvAFhLTSA+IdcpLiN2IPbcbzN1HN3hQQ==
X-Received: by 2002:a17:903:278f:b0:1bc:e6a:205f with SMTP id
 jw15-20020a170903278f00b001bc0e6a205fmr4731120plb.20.1692634747440; 
 Mon, 21 Aug 2023 09:19:07 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001ab2b4105ddsm7234549plh.60.2023.08.21.09.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:19:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v3 13/19] crypto: Add generic 64-bit carry-less multiply
 routine
Date: Mon, 21 Aug 2023 09:18:47 -0700
Message-Id: <20230821161854.419893-14-richard.henderson@linaro.org>
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
 host/include/generic/host/crypto/clmul.h | 15 +++++++++++++++
 include/crypto/clmul.h                   | 19 +++++++++++++++++++
 crypto/clmul.c                           | 18 ++++++++++++++++++
 3 files changed, 52 insertions(+)
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
index 0ea25a252c..c82d2d7559 100644
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
index 36ada1be9d..abf79cc49a 100644
--- a/crypto/clmul.c
+++ b/crypto/clmul.c
@@ -92,3 +92,21 @@ uint64_t clmul_32(uint32_t n, uint32_t m32)
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
+        uint64_t mask = -(n & 1);
+        rl ^= (m << i) & mask;
+        rh ^= (m >> (64 - i)) & mask;
+        n >>= 1;
+    }
+    return int128_make128(rl, rh);
+}
-- 
2.34.1


