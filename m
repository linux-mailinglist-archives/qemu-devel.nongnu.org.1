Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C254670DDFC
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:51:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SMt-00019m-Mc; Tue, 23 May 2023 09:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMr-00016R-GX
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:48:01 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMp-0001AJ-Pw
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:48:01 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d3491609fso3270231b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849677; x=1687441677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPrkOt+CaBTbeGyLx8wQPnc67J39LOMdRfd1HdHQv5I=;
 b=n67asMjnfKzgaIwCTyugaT9SJPx/v1B2fNo8xpIO9u6xO98HhfagOFClpAUsy2ofZ7
 7tvRiAvbydYUmz6P66//kS1ojGjz3Hb5oF2nNurKyJgR5UXI61F1Jy0xVU9QlWhsI5Be
 MBUsyG/9643JXa1x02F6fKjJz3QVSFSDxG8G4XP5/9V0akEmK3kFNhSlixEuwPxwsHX/
 u7+HgSwMAfmcltZaCsvw82ZBB7bNbkFibA0wkBAs9GguVSKUb9pd9fScaKoorajUiJzL
 5Qe4rjKEMAwmrTFB9IpdiBjyU6KDTaA1IHokJiZ60CavhlZb8+bX8y6y2wqnH/leYc/4
 8Zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849677; x=1687441677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PPrkOt+CaBTbeGyLx8wQPnc67J39LOMdRfd1HdHQv5I=;
 b=Au5I9avbbIrV68MPaxsWJWHXeSUetGjsLQAMdK6H4C6f/a4SjF7RQyHm5eF78nQwBu
 zO2v8awBlxmcQ1uXza32mWwaS2Qo373WxTKvY8Q5bGLCrMYHW31Z98xAUzg9UPwdx57i
 3KRRZzNGaSp5LTHDaAe/ABFwo2x2Bw6+ZjN/l2Xs37kRc1MnltzKiX2nYlb1y1eGKdNO
 9a48IEjBrjpuo0PR1bbdsCMMhIgO1cUh9zyVsIRO+B/3D48v7vV8x/Cpf1Qc9BU9CJ/a
 OPW3yVF45SahTHA1Npgvxy5008KR8GWVCrl4T5/TS9mGBCMoY/z4lzp1h1IgjcUUtjkf
 L9iA==
X-Gm-Message-State: AC+VfDwkSPASUI5ZbHV768pwqL+JL+59jWf+RMMMlSRBm0heEgazMQ1J
 axMWYvjNSEMvR2Bwco+Mzpwp1KbriwWjBZ/QB5g=
X-Google-Smtp-Source: ACHHUZ42IpqWW4ifcwPTXyb0+WIRMi7nttk60YK2BwQstRO3Xn5xIq9VKbdM/xbG62XjgOhc7LGk6g==
X-Received: by 2002:a05:6a00:24d1:b0:63b:7a55:ae89 with SMTP id
 d17-20020a056a0024d100b0063b7a55ae89mr19497198pfv.27.1684849677518; 
 Tue, 23 May 2023 06:47:57 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 j4-20020aa79284000000b0064d1349dc31sm5737122pfa.199.2023.05.23.06.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:47:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 26/27] qemu/atomic128: Add runtime test for FEAT_LSE2
Date: Tue, 23 May 2023 06:47:32 -0700
Message-Id: <20230523134733.678646-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523134733.678646-1-richard.henderson@linaro.org>
References: <20230523134733.678646-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
index 4b1360de39..5aabd6b978 100644
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


