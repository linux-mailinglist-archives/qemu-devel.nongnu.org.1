Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 536557A23CC
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:44:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBtw-0004Rb-Bq; Fri, 15 Sep 2023 12:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBtu-0004QZ-6p
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:38 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBts-0004t4-KD
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:37 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68fb2e9ebcdso1944656b3a.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796155; x=1695400955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1HqpqG1SCyo6N98nxssbdjX05tzqj9OxhfNx1abB4M=;
 b=ZRkTKckmQP4GfMt7g1ytDalJALVslhW/D0RWtSEo92CRpLuuL1T0ginyFTDaeDm7AT
 GTetWbC6pWl0p7xFPvCnnfTia73g9DNvXzwkfsXtlLU+bOxbJk60dAMY8Aozl0b9+KuI
 AJ0gJegSjZPnHpzV28HGHxWcELqSJwBqW3q6+eNVQsLDw3ro7ev0oZ6ZcW7OHimVa4d7
 GnceHVWYn+FRji96PrbjdF7JS6iivlZ21dmHzQ5cM2+jDryfV9y6oKGqXE41ffAdZJI1
 W2UJqrV/3PTpODVFFd6Sx1R7zHkiQFrAKTFzuQmbvt4yh5/FMF32n+vVJ/IAjejwrI1q
 1b2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796155; x=1695400955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q1HqpqG1SCyo6N98nxssbdjX05tzqj9OxhfNx1abB4M=;
 b=THwjpuVFhCu7ILURIDXUv1Jr5sRGU7q8TxdqPKX7yqREFwcS6533o1WhtX5IkohRg0
 xn0IqahycIku76PBmkknc0WiTOSo9U8PUmirOmZWVhnnPNdfBK2YaoRHeYpEICYvOFNV
 5uxP+MZiGioTr3BLLEbEBEDfid6Cai107/cskwU9VGN0rNENOJQbhaha98lQ6T0gCsqq
 B7cfmkxRb3SE6PM6aTyIrdkKFjNwDT7pHC0ybgJoanI4Ejmm25lZXqhLrBDKKhpxZACr
 jN0dQFhVKxVbEx1KioKDUBQZe+U/zKKlGrSsekaLgcjlHTl6FZ2iccl/hrwgr1TMMaDI
 X8eQ==
X-Gm-Message-State: AOJu0Yw2dyS0CamPz8MxiBEABMRgSA82SYETMfc5I99kgTx1/UAeasZj
 l7Ekt5k6RmEIxtsDgzpbY736JGNnxdzomKh9vmE=
X-Google-Smtp-Source: AGHT+IG8W48SftxAwF1XWNJqLqS4l+mZccs5X3qNWRJZbWkdeB1r7PDLnd3P9LbBZSUlgDeLFCAx2Q==
X-Received: by 2002:a05:6a20:12c4:b0:159:b45e:1c7d with SMTP id
 v4-20020a056a2012c400b00159b45e1c7dmr2651096pzg.15.1694796155282; 
 Fri, 15 Sep 2023 09:42:35 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 s187-20020a6377c4000000b00577f55e4a4esm3010087pgc.20.2023.09.15.09.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:42:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/19] target/s390x: Use clmul_8* routines
Date: Fri, 15 Sep 2023 09:42:15 -0700
Message-Id: <20230915164231.123580-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915164231.123580-1-richard.henderson@linaro.org>
References: <20230915164231.123580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use generic routines for 8-bit carry-less multiply.
Remove our local version of galois_multiply8.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/vec_int_helper.c | 32 ++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/vec_int_helper.c b/target/s390x/tcg/vec_int_helper.c
index 53ab5c5eb3..edff4d6b2b 100644
--- a/target/s390x/tcg/vec_int_helper.c
+++ b/target/s390x/tcg/vec_int_helper.c
@@ -14,6 +14,7 @@
 #include "vec.h"
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
+#include "crypto/clmul.h"
 
 static bool s390_vec_is_zero(const S390Vector *v)
 {
@@ -179,7 +180,6 @@ static uint##TBITS##_t galois_multiply##BITS(uint##TBITS##_t a,                \
     }                                                                          \
     return res;                                                                \
 }
-DEF_GALOIS_MULTIPLY(8, 16)
 DEF_GALOIS_MULTIPLY(16, 32)
 DEF_GALOIS_MULTIPLY(32, 64)
 
@@ -203,6 +203,34 @@ static S390Vector galois_multiply64(uint64_t a, uint64_t b)
     return res;
 }
 
+/*
+ * There is no carry across the two doublewords, so their order does
+ * not matter.  Nor is there partial overlap between registers.
+ */
+static inline uint64_t do_gfma8(uint64_t n, uint64_t m, uint64_t a)
+{
+    return clmul_8x4_even(n, m) ^ clmul_8x4_odd(n, m) ^ a;
+}
+
+void HELPER(gvec_vgfm8)(void *v1, const void *v2, const void *v3, uint32_t d)
+{
+    uint64_t *q1 = v1;
+    const uint64_t *q2 = v2, *q3 = v3;
+
+    q1[0] = do_gfma8(q2[0], q3[0], 0);
+    q1[1] = do_gfma8(q2[1], q3[1], 0);
+}
+
+void HELPER(gvec_vgfma8)(void *v1, const void *v2, const void *v3,
+                         const void *v4, uint32_t desc)
+{
+    uint64_t *q1 = v1;
+    const uint64_t *q2 = v2, *q3 = v3, *q4 = v4;
+
+    q1[0] = do_gfma8(q2[0], q3[0], q4[0]);
+    q1[1] = do_gfma8(q2[1], q3[1], q4[1]);
+}
+
 #define DEF_VGFM(BITS, TBITS)                                                  \
 void HELPER(gvec_vgfm##BITS)(void *v1, const void *v2, const void *v3,         \
                              uint32_t desc)                                    \
@@ -220,7 +248,6 @@ void HELPER(gvec_vgfm##BITS)(void *v1, const void *v2, const void *v3,         \
         s390_vec_write_element##TBITS(v1, i, d);                               \
     }                                                                          \
 }
-DEF_VGFM(8, 16)
 DEF_VGFM(16, 32)
 DEF_VGFM(32, 64)
 
@@ -257,7 +284,6 @@ void HELPER(gvec_vgfma##BITS)(void *v1, const void *v2, const void *v3,        \
         s390_vec_write_element##TBITS(v1, i, d);                               \
     }                                                                          \
 }
-DEF_VGFMA(8, 16)
 DEF_VGFMA(16, 32)
 DEF_VGFMA(32, 64)
 
-- 
2.34.1


