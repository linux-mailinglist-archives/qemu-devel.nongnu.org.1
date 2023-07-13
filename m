Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 508DF752BEE
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:17:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3eO-0000Jw-9p; Thu, 13 Jul 2023 17:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eI-0000I9-FO
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:54 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eG-00017U-Pq
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:54 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso11255705e9.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689282891; x=1691874891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/VchOJmp/PdkjGrWpO7FtoJjXcBbpTQPyllwuZ+9STU=;
 b=kQIxRxw+RpNmTfB3c1AJOyZkE7mchlHaPAT2bg6WzywfUo8ez/Yd7xbPK/RVIX57sH
 NJIme9uP6JJ7Crj2jt9tWtynUR0XvMF9szTlWYQ1HNLvadNUBlmf9aheVhCJwWpK0IMa
 JZ8ka0+8liKeZYqjQOYO0HRRPSFxosYlqD34hx4LpXsMKpF0AqwILFzVWeZgaKFJEYiT
 CTyrxJB66E49ypDteL2SDkN7vv5J/zVB7rM/lXH0C1IeKoemmJx+sY8y8E/j3JMCSyTv
 pO7sli3LScNCQ77N6oJd0zC69LRIyAOgJrXqCOfa9IBpLhMczH6ozD4+Lz2wVYiXrA2F
 Uozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689282891; x=1691874891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/VchOJmp/PdkjGrWpO7FtoJjXcBbpTQPyllwuZ+9STU=;
 b=eN2seIlvjbkXJhLlKbQnzTEsG3S4DmSedpzt5aEKqombqvDPtqcuLETK6HTMkIwV2i
 X1YHONrlZjNsa0NxHxj69BHSrWmuPEABd1CDI72ZUmiUtuyVOUbJuLZ5Jhw3Jyp6mdiu
 x2FiEosbt1Cb6QD76H8aP5GB0pWNY4EO1AdcD6J04L2U8Fe/HADTIjhSBL7ONaTX0GDF
 1TYQTXlP0g0yrV4bkrw5Q9MrC+YBWDVgGRUsqLS5QJIwMjItaWRCLBKo8EuWJ4f5v3Nv
 nYSW33dH64ccQTND4q7LinORj8q+QnXBX5+ROg1/DhwGvQ4Aq7vEkei1Ai5Yv/X2V3XE
 S/OQ==
X-Gm-Message-State: ABy/qLZ1PZzP5w4hq01twc9e4a5MkaLHod+AOBuUXUEIxcXNGX127k03
 kGEVXVEglDmuFce3rDP0Usq/D3dEXSPLRlYBxNW1vvBw
X-Google-Smtp-Source: APBJJlHDEipIKDhO/g4zqlPkUSItrrOZYlvlAUFl5J5Eww8fSCdXruewHQZcuJwnzE9HfousdjqqOw==
X-Received: by 2002:adf:ed4c:0:b0:313:f347:eea0 with SMTP id
 u12-20020adfed4c000000b00313f347eea0mr2351551wro.60.1689282891100; 
 Thu, 13 Jul 2023 14:14:51 -0700 (PDT)
Received: from stoup.. ([85.193.156.66]) by smtp.gmail.com with ESMTPSA id
 n12-20020adff08c000000b0030ada01ca78sm8973747wro.10.2023.07.13.14.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 14:14:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH 09/18] crypto: Add generic 32-bit carry-less multiply routines
Date: Thu, 13 Jul 2023 22:14:26 +0100
Message-Id: <20230713211435.13505-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713211435.13505-1-richard.henderson@linaro.org>
References: <20230713211435.13505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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
 host/include/generic/host/crypto/clmul.h |  4 +++
 include/crypto/clmul.h                   | 23 ++++++++++++++++++
 crypto/clmul.c                           | 31 ++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/host/include/generic/host/crypto/clmul.h b/host/include/generic/host/crypto/clmul.h
index cba8bbf3e4..3fbb1576cf 100644
--- a/host/include/generic/host/crypto/clmul.h
+++ b/host/include/generic/host/crypto/clmul.h
@@ -19,4 +19,8 @@
 #define clmul_16x4_even         clmul_16x4_even_gen
 #define clmul_16x4_odd          clmul_16x4_odd_gen
 
+#define clmul_32                clmul_32_gen
+#define clmul_32x2_even         clmul_32x2_even_gen
+#define clmul_32x2_odd          clmul_32x2_odd_gen
+
 #endif /* GENERIC_HOST_CRYPTO_CLMUL_H */
diff --git a/include/crypto/clmul.h b/include/crypto/clmul.h
index b701bac9d6..ce43c9aeb1 100644
--- a/include/crypto/clmul.h
+++ b/include/crypto/clmul.h
@@ -88,6 +88,29 @@ Int128 clmul_16x4_even_gen(Int128, Int128);
  */
 Int128 clmul_16x4_odd_gen(Int128, Int128);
 
+/**
+ * clmul_32:
+ *
+ * Perform a 32x32->64 carry-less multiply.
+ */
+uint64_t clmul_32_gen(uint32_t, uint32_t);
+
+/**
+ * clmul_32x2_even:
+ *
+ * Perform two 32x32->64 carry-less multiplies.
+ * The odd words of the inputs are ignored.
+ */
+Int128 clmul_32x2_even_gen(Int128, Int128);
+
+/**
+ * clmul_32x2_odd:
+ *
+ * Perform two 32x32->64 carry-less multiplies.
+ * The even words of the inputs are ignored.
+ */
+Int128 clmul_32x2_odd_gen(Int128, Int128);
+
 #include "host/crypto/clmul.h"
 
 #endif /* CRYPTO_CLMUL_H */
diff --git a/crypto/clmul.c b/crypto/clmul.c
index 69a3b6f7ff..c197cd5f21 100644
--- a/crypto/clmul.c
+++ b/crypto/clmul.c
@@ -113,3 +113,34 @@ Int128 clmul_16x4_odd_gen(Int128 n, Int128 m)
     rh = clmul_16x2_odd_gen(int128_gethi(n), int128_gethi(m));
     return int128_make128(rl, rh);
 }
+
+uint64_t clmul_32_gen(uint32_t n, uint32_t m32)
+{
+    uint64_t r = 0;
+    uint64_t m = m32;
+
+    for (int i = 0; i < 32; ++i) {
+        r ^= n & 1 ? m : 0;
+        n >>= 1;
+        m <<= 1;
+    }
+    return r;
+}
+
+Int128 clmul_32x2_even_gen(Int128 n, Int128 m)
+{
+    uint64_t rl, rh;
+
+    rl = clmul_32_gen(int128_getlo(n), int128_getlo(m));
+    rh = clmul_32_gen(int128_gethi(n), int128_gethi(m));
+    return int128_make128(rl, rh);
+}
+
+Int128 clmul_32x2_odd_gen(Int128 n, Int128 m)
+{
+    uint64_t rl, rh;
+
+    rl = clmul_32_gen(int128_getlo(n) >> 32, int128_getlo(m) >> 32);
+    rh = clmul_32_gen(int128_gethi(n) >> 32, int128_gethi(m) >> 32);
+    return int128_make128(rl, rh);
+}
-- 
2.34.1


