Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4CC752BE8
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:16:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3ea-0000QL-Iw; Thu, 13 Jul 2023 17:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eH-0000I5-Ng
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:54 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eC-00016U-C5
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:53 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57dcso11896265e9.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689282887; x=1691874887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hpm+Tse7Y103FOMmNwDNKcmWp0woIdWlhDNb7L+eKdk=;
 b=Ymkx1ZkBA98FvqUJN4LQVtifHOY4M47/ksi6Gj3oSgYXTnHDop4dcUOnWIZm78I70/
 Llpsa1zsKVQCd2DY7+3nRoBPflcXWxyocFxsjXjlVUIshM+aTXHz96OwEKjD74lBaHO7
 k3OfrG5xqqhAy4zzU+iBRfZSaImbJSzes7917nLMa4yb3A9CdMyjy3aVBzqEVVYhXyq/
 zQFJ7Mj+A31+GrjseWvg9NwByLBnfplOo2HthjEd+vKovQpWE97+MVKfw19n603p+EXX
 pg79dPJz/E6tHS95Z6OpIwx8DGlUhwwrutd0PXNNjOGUJZT5F0ESkYIWx2UPxF1so2Ct
 kA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689282887; x=1691874887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hpm+Tse7Y103FOMmNwDNKcmWp0woIdWlhDNb7L+eKdk=;
 b=IvQwCPsIgcdZAzXel2f7/m2l5ZiE6sqEBMrzSpusKBV3MD2poiVd2DJGDspkNK/Way
 f64GwEzt9qKKdmVCmdC+rWUICZ9FwCCfDAL9gdVPJ3ZPqNLXYKZq5UN+zcMVb9J11Xu0
 kBCZlZ4ETpoPji7rzDZ3WSMvkpqpHWLDsHM0mJsFLCBu6OOAmlkwjO2t8co2rHdoI05f
 UiFmg4MH+54mag+WsvhKUrlxrX5iUFAqFSsaAs2a4V+h1GZt9IPnfa3DypYfcnZfoLWc
 89M9QYJNBvZ7P1nw+ZM0TrA7Tog2N8C+Q1Zt6tqpL9vdLnmfpNBYpryaSUrxvOWrY3Sa
 +jkw==
X-Gm-Message-State: ABy/qLZ5qGPnTQBQfDPS+Lkpg2seMz3HaGHI9Diujn+YJre/a3Yh/hmD
 p/ijLsphacw5LXuhXTEhthHhUaNZ8vwq7SZmePyOE9SK
X-Google-Smtp-Source: APBJJlG74ihcKs6KctfOYKxQUKP33ZKbqaiuRLNBqbJ8shi6b1WS00fL1Pl6z0sgAJPUFRXCE+NNLQ==
X-Received: by 2002:a05:6000:86:b0:311:1a45:3606 with SMTP id
 m6-20020a056000008600b003111a453606mr2378255wrx.30.1689282887123; 
 Thu, 13 Jul 2023 14:14:47 -0700 (PDT)
Received: from stoup.. ([85.193.156.66]) by smtp.gmail.com with ESMTPSA id
 n12-20020adff08c000000b0030ada01ca78sm8973747wro.10.2023.07.13.14.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 14:14:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH 05/18] crypto: Add generic 16-bit carry-less multiply routines
Date: Thu, 13 Jul 2023 22:14:22 +0100
Message-Id: <20230713211435.13505-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713211435.13505-1-richard.henderson@linaro.org>
References: <20230713211435.13505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
 host/include/generic/host/crypto/clmul.h |  5 +++
 include/crypto/clmul.h                   | 32 +++++++++++++++++++
 crypto/clmul.c                           | 39 ++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/host/include/generic/host/crypto/clmul.h b/host/include/generic/host/crypto/clmul.h
index 694705f703..cba8bbf3e4 100644
--- a/host/include/generic/host/crypto/clmul.h
+++ b/host/include/generic/host/crypto/clmul.h
@@ -14,4 +14,9 @@
 #define clmul_8x8_odd           clmul_8x8_odd_gen
 #define clmul_8x8_packed        clmul_8x8_packed_gen
 
+#define clmul_16x2_even         clmul_16x2_even_gen
+#define clmul_16x2_odd          clmul_16x2_odd_gen
+#define clmul_16x4_even         clmul_16x4_even_gen
+#define clmul_16x4_odd          clmul_16x4_odd_gen
+
 #endif /* GENERIC_HOST_CRYPTO_CLMUL_H */
diff --git a/include/crypto/clmul.h b/include/crypto/clmul.h
index 7f19205d6f..b701bac9d6 100644
--- a/include/crypto/clmul.h
+++ b/include/crypto/clmul.h
@@ -56,6 +56,38 @@ Int128 clmul_8x8_odd_gen(Int128, Int128);
  */
 Int128 clmul_8x8_packed_gen(uint64_t, uint64_t);
 
+/**
+ * clmul_16x2_even:
+ *
+ * Perform two 16x16->32 carry-less multiplies.
+ * The odd words of the inputs are ignored.
+ */
+uint64_t clmul_16x2_even_gen(uint64_t, uint64_t);
+
+/**
+ * clmul_16x2_odd:
+ *
+ * Perform two 16x16->32 carry-less multiplies.
+ * The even bytes of the inputs are ignored.
+ */
+uint64_t clmul_16x2_odd_gen(uint64_t, uint64_t);
+
+/**
+ * clmul_16x4_even:
+ *
+ * Perform four 16x16->32 carry-less multiplies.
+ * The odd bytes of the inputs are ignored.
+ */
+Int128 clmul_16x4_even_gen(Int128, Int128);
+
+/**
+ * clmul_16x4_odd:
+ *
+ * Perform eight 16x16->32 carry-less multiplies.
+ * The even bytes of the inputs are ignored.
+ */
+Int128 clmul_16x4_odd_gen(Int128, Int128);
+
 #include "host/crypto/clmul.h"
 
 #endif /* CRYPTO_CLMUL_H */
diff --git a/crypto/clmul.c b/crypto/clmul.c
index 866704e751..69a3b6f7ff 100644
--- a/crypto/clmul.c
+++ b/crypto/clmul.c
@@ -74,3 +74,42 @@ Int128 clmul_8x8_packed_gen(uint64_t n, uint64_t m)
     rh = clmul_8x4_even_gen(unpack_8_to_16(n >> 32), unpack_8_to_16(m >> 32));
     return int128_make128(rl, rh);
 }
+
+uint64_t clmul_16x2_even_gen(uint64_t n, uint64_t m)
+{
+    uint64_t r = 0;
+
+    n &= 0x0000ffff0000ffffull;
+    m &= 0x0000ffff0000ffffull;
+
+    for (int i = 0; i < 16; ++i) {
+        uint64_t mask = (n & 0x0000000100000001ull) * 0xffffffffull;
+        r ^= m & mask;
+        n >>= 1;
+        m <<= 1;
+    }
+    return r;
+}
+
+uint64_t clmul_16x2_odd_gen(uint64_t n, uint64_t m)
+{
+    return clmul_16x2_even_gen(n >> 16, m >> 16);
+}
+
+Int128 clmul_16x4_even_gen(Int128 n, Int128 m)
+{
+    uint64_t rl, rh;
+
+    rl = clmul_16x2_even_gen(int128_getlo(n), int128_getlo(m));
+    rh = clmul_16x2_even_gen(int128_gethi(n), int128_gethi(m));
+    return int128_make128(rl, rh);
+}
+
+Int128 clmul_16x4_odd_gen(Int128 n, Int128 m)
+{
+    uint64_t rl, rh;
+
+    rl = clmul_16x2_odd_gen(int128_getlo(n), int128_getlo(m));
+    rh = clmul_16x2_odd_gen(int128_gethi(n), int128_gethi(m));
+    return int128_make128(rl, rh);
+}
-- 
2.34.1


