Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B3C752C0A
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:18:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3ea-0000Q8-EZ; Thu, 13 Jul 2023 17:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eL-0000Je-VQ
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eK-00018V-4k
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbef8ad9bbso10026315e9.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689282895; x=1691874895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xK0qTtWWEN2PFwA7pUogqEsxDTZZLq0zFIIqlW+dA/A=;
 b=OGUieX20zuHlPj8X1Z1sK2vXL0FyybB9otlgkVcNVaxMWdnatdBb0FvZMBIzSywf8w
 VzjG/NAieG3LtYYfzuCY98LoWyHEjVvvDXTHBk5ZB9xoqCKLHsj3MXVA0ZSFg0x3ZxFv
 lTznQ+m1jgfjfAG7L3gUxzuPOzObIO3XsL5s64VSV3j/Slf+sfaBwD4d9fp6FlGWFVvT
 yGeOyn4x5oyyN7MnQzD5yaedzqCKAl5CtxUKtdbpMMQPF3GG55WjhOeRPqe9mcRq5peq
 kYb/zpRh/wV69MRP6I4lkVkfBUO90xfbLQFBYVMdM7Ko04e0CzFl+CAHWWafvTu7wD4+
 8FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689282895; x=1691874895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xK0qTtWWEN2PFwA7pUogqEsxDTZZLq0zFIIqlW+dA/A=;
 b=QVogE1p+faw5Bs/LwmA3iThVHb7o2lZINgBiJYGZYtg5WAAG6O/rcq+D+rCSQLTxgF
 V1ZoVfi3ETAY4/TfgPi6Jo5/w19Gy0+IXOOhzIc6d0xuxGhmCmfO/uZLqQugi4lv2LNG
 jnzIa/5qIvbC1KdSsSpfHNSYN7MCEpB3352fwPCy2jm+WWE0XISoW+ufzAc690hcijbl
 cDYu8Ym4EBPY/4wjup1aIKyaPQcR5PAka+88lgu4TCcZM0R5T06LITFGuXGKYo9XBVlU
 WlaqWCs1540DueELz9rIz5GTVtSNN3YOhmNVX80fDNUCIJ8BvpEYPU97F5K+Dqjxy3PY
 Vedg==
X-Gm-Message-State: ABy/qLa0d/tMo2xng/TZcPliGXZoH6HWyJYBkSSSPax0huyu2UXp+4D+
 j6R7zb9PiPVkjZtT3yxjkMp8QmruHUJ4e3hbVik/hvws
X-Google-Smtp-Source: APBJJlFofT+upDIHU876qDUQ98A+o/PCDzR7GfcL9YEOjcgjt1KhpeZKa/XQaKrz7tVe038/0WRnSQ==
X-Received: by 2002:adf:e483:0:b0:314:db7:d132 with SMTP id
 i3-20020adfe483000000b003140db7d132mr2544451wrm.61.1689282894830; 
 Thu, 13 Jul 2023 14:14:54 -0700 (PDT)
Received: from stoup.. ([85.193.156.66]) by smtp.gmail.com with ESMTPSA id
 n12-20020adff08c000000b0030ada01ca78sm8973747wro.10.2023.07.13.14.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 14:14:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH 13/18] crypto: Add generic 64-bit carry-less multiply routine
Date: Thu, 13 Jul 2023 22:14:30 +0100
Message-Id: <20230713211435.13505-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713211435.13505-1-richard.henderson@linaro.org>
References: <20230713211435.13505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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
 host/include/generic/host/crypto/clmul.h |  2 ++
 include/crypto/clmul.h                   |  7 +++++++
 crypto/clmul.c                           | 17 +++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/host/include/generic/host/crypto/clmul.h b/host/include/generic/host/crypto/clmul.h
index 3fbb1576cf..7f70afeb57 100644
--- a/host/include/generic/host/crypto/clmul.h
+++ b/host/include/generic/host/crypto/clmul.h
@@ -23,4 +23,6 @@
 #define clmul_32x2_even         clmul_32x2_even_gen
 #define clmul_32x2_odd          clmul_32x2_odd_gen
 
+#define clmul_64                clmul_64_gen
+
 #endif /* GENERIC_HOST_CRYPTO_CLMUL_H */
diff --git a/include/crypto/clmul.h b/include/crypto/clmul.h
index ce43c9aeb1..8b4c263459 100644
--- a/include/crypto/clmul.h
+++ b/include/crypto/clmul.h
@@ -111,6 +111,13 @@ Int128 clmul_32x2_even_gen(Int128, Int128);
  */
 Int128 clmul_32x2_odd_gen(Int128, Int128);
 
+/**
+ * clmul_64:
+ *
+ * Perform a 64x64->128 carry-less multiply.
+ */
+Int128 clmul_64_gen(uint64_t, uint64_t);
+
 #include "host/crypto/clmul.h"
 
 #endif /* CRYPTO_CLMUL_H */
diff --git a/crypto/clmul.c b/crypto/clmul.c
index c197cd5f21..0be06073f0 100644
--- a/crypto/clmul.c
+++ b/crypto/clmul.c
@@ -144,3 +144,20 @@ Int128 clmul_32x2_odd_gen(Int128 n, Int128 m)
     rh = clmul_32_gen(int128_gethi(n) >> 32, int128_gethi(m) >> 32);
     return int128_make128(rl, rh);
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


