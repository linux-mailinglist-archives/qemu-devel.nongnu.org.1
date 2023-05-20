Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0768570A92F
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 18:31:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0PQe-00042q-Ec; Sat, 20 May 2023 12:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQJ-0003oa-W4
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:16 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQE-00039N-Hl
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:15 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1ae6dce19f7so20701925ad.3
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 09:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684600029; x=1687192029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ls+MmvQQFANFQAxZzSV9sTIr5Z8/+s6kpLEK2WXn+jw=;
 b=TXyXj9IID37hb3JfhyZe6THdJxh+CuYdwSOs+eZ0SmNTPqvgCK92fM0C9GHuIAgvpS
 +Z43yHQkErIDFAAhtcp82bYHyGMIwj6OIJpOq4ep0zKoNBP02o4RV8c5Emy/sgVt7BMp
 xYm9RF5+3wAmhSWlIfmA4CYb7RcSHpKQieVqJmJfzGND/SDuGA9mV+LOZ6Y7oCBaDw5u
 Mg+fwu6T3UFtc0uL9FiObYNfLhQqZE6l+ifeQ6GW5jXVz/Sff6NShHdLQVDrE7Rc3IMQ
 yK1B5OaKI1IuBZpvO9fqw44tzKEDSb2Hl5u4JIH6X4Dm8mq/5ptN0bVUFZsjjR47roe5
 JeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684600029; x=1687192029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ls+MmvQQFANFQAxZzSV9sTIr5Z8/+s6kpLEK2WXn+jw=;
 b=IAyuuMXYUv6XzxltQnrlW2iz1l1VE9mmp4VI/0geSGMq5S63wTAhFr7f/1I/rLM6KL
 0/VgAxakoDlrJk55jbr7SBMVIDsNKjl1jKU2EgSniS4Rp4lu6KLV54NzaLv+u2Co1OXl
 4dEhP+C+CrQ7+sCtGO6deHFimcGsvuExeczAGHe50HEtxsv/jF239dZ2kSCBqh/nmmMj
 dypdNui1dFhQNNz5wuLdP+E1iggRH83+e1/SOR/W2S6JjBtXH3g2Rew2E6ibEZorqHD6
 SZgmjfop5VdVHR+fmoCIYonZskbRW/5T7VM8wN0YnN2k6jZ6ma11RexTZe3cwsSz8AuJ
 GY/w==
X-Gm-Message-State: AC+VfDysFPMPK7hPafH/ksyc4XrcFygs0a4vv9mOSkdwG1t9FT8Md3Dz
 AP7b7dNNafVo23OAEzTtTPocRW9ReQP5v/OrTqs=
X-Google-Smtp-Source: ACHHUZ5N4oSO3z6o3ibXOkAcpCkIWFcdpesT2350vW7ZLfssG3ZHT5DJIng7gFMmUYEZPQqpW99dcw==
X-Received: by 2002:a17:902:e80b:b0:1ae:62ed:9630 with SMTP id
 u11-20020a170902e80b00b001ae62ed9630mr7650150plg.15.1684600029290; 
 Sat, 20 May 2023 09:27:09 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:d078:d94e:cb2b:a055])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170903230c00b001a5260a6e6csm1697104plh.206.2023.05.20.09.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 09:27:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 26/27] qemu/atomic128: Add runtime test for FEAT_LSE2
Date: Sat, 20 May 2023 09:26:33 -0700
Message-Id: <20230520162634.3991009-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230520162634.3991009-1-richard.henderson@linaro.org>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

With FEAT_LSE2, load and store of int128 is directly supported.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/aarch64/host/atomic128-ldst.h | 53 ++++++++++++++++------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/host/include/aarch64/host/atomic128-ldst.h b/host/include/aarch64/host/atomic128-ldst.h
index 6959b2bd8e..57455c9b06 100644
--- a/host/include/aarch64/host/atomic128-ldst.h
+++ b/host/include/aarch64/host/atomic128-ldst.h
@@ -11,27 +11,48 @@
 #ifndef AARCH64_ATOMIC128_LDST_H
 #define AARCH64_ATOMIC128_LDST_H
 
+#include "host/cpuinfo.h"
+#include "tcg/debug-assert.h"
+
 /*
  * Through gcc 10, aarch64 has no support for 128-bit atomics.
  * Through clang 16, without -march=armv8.4-a, __atomic_load_16
  * is incorrectly expanded to a read-write operation.
+ *
+ * Anyway, this method allows runtime detection of FEAT_LSE2.
  */
 
-#define HAVE_ATOMIC128_RO 0
+#define HAVE_ATOMIC128_RO (cpuinfo & CPUINFO_LSE2)
 #define HAVE_ATOMIC128_RW 1
 
-Int128 QEMU_ERROR("unsupported atomic") atomic16_read_ro(const Int128 *ptr);
+static inline Int128 atomic16_read_ro(const Int128 *ptr)
+{
+    uint64_t l, h;
+
+    tcg_debug_assert(HAVE_ATOMIC128_RO);
+    /* With FEAT_LSE2, 16-byte aligned LDP is atomic. */
+    asm("ldp %[l], %[h], %[mem]"
+        : [l] "=r"(l), [h] "=r"(h) : [mem] "m"(*ptr));
+
+    return int128_make128(l, h);
+}
 
 static inline Int128 atomic16_read_rw(Int128 *ptr)
 {
     uint64_t l, h;
     uint32_t tmp;
 
-    /* The load must be paired with the store to guarantee not tearing.  */
-    asm("0: ldxp %[l], %[h], %[mem]\n\t"
-        "stxp %w[tmp], %[l], %[h], %[mem]\n\t"
-        "cbnz %w[tmp], 0b"
-        : [mem] "+m"(*ptr), [tmp] "=r"(tmp), [l] "=r"(l), [h] "=r"(h));
+    if (cpuinfo & CPUINFO_LSE2) {
+        /* With FEAT_LSE2, 16-byte aligned LDP is atomic. */
+        asm("ldp %[l], %[h], %[mem]"
+            : [l] "=r"(l), [h] "=r"(h) : [mem] "m"(*ptr));
+    } else {
+        /* The load must be paired with the store to guarantee not tearing.  */
+        asm("0: ldxp %[l], %[h], %[mem]\n\t"
+            "stxp %w[tmp], %[l], %[h], %[mem]\n\t"
+            "cbnz %w[tmp], 0b"
+            : [mem] "+m"(*ptr), [tmp] "=r"(tmp), [l] "=r"(l), [h] "=r"(h));
+    }
 
     return int128_make128(l, h);
 }
@@ -41,12 +62,18 @@ static inline void atomic16_set(Int128 *ptr, Int128 val)
     uint64_t l = int128_getlo(val), h = int128_gethi(val);
     uint64_t t1, t2;
 
-    /* Load into temporaries to acquire the exclusive access lock.  */
-    asm("0: ldxp %[t1], %[t2], %[mem]\n\t"
-        "stxp %w[t1], %[l], %[h], %[mem]\n\t"
-        "cbnz %w[t1], 0b"
-        : [mem] "+m"(*ptr), [t1] "=&r"(t1), [t2] "=&r"(t2)
-        : [l] "r"(l), [h] "r"(h));
+    if (cpuinfo & CPUINFO_LSE2) {
+        /* With FEAT_LSE2, 16-byte aligned STP is atomic. */
+        asm("stp %[l], %[h], %[mem]"
+            : [mem] "=m"(*ptr) : [l] "r"(l), [h] "r"(h));
+    } else {
+        /* Load into temporaries to acquire the exclusive access lock.  */
+        asm("0: ldxp %[t1], %[t2], %[mem]\n\t"
+            "stxp %w[t1], %[l], %[h], %[mem]\n\t"
+            "cbnz %w[t1], 0b"
+            : [mem] "+m"(*ptr), [t1] "=&r"(t1), [t2] "=&r"(t2)
+            : [l] "r"(l), [h] "r"(h));
+    }
 }
 
 #endif /* AARCH64_ATOMIC128_LDST_H */
-- 
2.34.1


