Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E64A781637
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:03:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAMH-0008QQ-Sb; Fri, 18 Aug 2023 21:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMF-0008Pd-FH
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:27 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMC-0007Ky-M0
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:27 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bee82fab5aso12288785ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692406943; x=1693011743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MlO/4lz23eNLFrlyrvCLQF2KGu4x8cNZ2TLPxKRIDg=;
 b=H70jcr5BfrlqBN0+pLjDPgqW+cWguEilfHAWtClZWlwrUtNDHgD3uVTPWaVR4qRTyY
 Va4MmaWdThnG94WnKFg9+VVPMwH55eQZzBubMSnUCInWcqoC5uLX7TeRDZm3PvUjdPvp
 SPN2DokvV7Duef9esDrH+4AWoo1eqM0g9CBMK4IAi/oeU0Rp+XsN28mTbp6rjrVPOFDJ
 5okLb05kYHbkMqWZCQX0yo2sD0c3aWc/TPDXa6q3kpZy2VVO8IieM0B0KzfEi882r5tG
 FXbruWVc3SXnlt7OE7mhNaKzwBJAvP1zarWoJBjwHTD2QCYOmNm/13ZSLnzIR+GccvLh
 Vgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692406943; x=1693011743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7MlO/4lz23eNLFrlyrvCLQF2KGu4x8cNZ2TLPxKRIDg=;
 b=TL8njucepis+tHkT5f7eaQSrww4JYjXslHUvVGO7wnTBimta+l6w9JyCHN+sX5KH0R
 qDweF7zRNYFgJEGGo+Lz0z+e3PRMoXmCQURm6mNphTh4fv7bXFhVmIUkG93bYX1aiVjx
 wEy5JRfn2uk1jkrpJ+XJfA7WE0tW+RyXf7Emszqs82OAjVzeDgMZGvz/yO0hb2uMf+zR
 JMroVDQP5pn1DsZSdEl260jflGK1WLyQv7pKM7Oo6CGL6ZYKFxR3LDFkI5Oo21qHp5hj
 Rc/2GD5cCa7/Me2eqiehTn43n5qTaK1UVP4XOjTTVgk0tB0mGtuQLtdBYDx92RYRCiU3
 RGgA==
X-Gm-Message-State: AOJu0YyxXwoblws6q6+PknbrBrW5Z/3vmHpSfMdQcj1JO2wEV2WL8lG9
 538npG355g5AxOrmnd8e/MSkL+0phJ9CAbUujHw=
X-Google-Smtp-Source: AGHT+IFF4/xr4NgW/PGffJSYR6LU1F+59Rqb+8t3UUPQW4V8pT69U8u0fEyd4DUD/fheFjloS3LWdw==
X-Received: by 2002:a17:903:2291:b0:1bc:6c8:cde3 with SMTP id
 b17-20020a170903229100b001bc06c8cde3mr1000380plh.57.1692406943358; 
 Fri, 18 Aug 2023 18:02:23 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902d50d00b001b87bedcc6fsm2372019plg.93.2023.08.18.18.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:02:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v2 03/18] target/s390x: Use clmul_8* routines
Date: Fri, 18 Aug 2023 18:02:03 -0700
Message-Id: <20230819010218.192706-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819010218.192706-1-richard.henderson@linaro.org>
References: <20230819010218.192706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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


