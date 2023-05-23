Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 577CD70DDF4
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:51:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SMq-00010R-UJ; Tue, 23 May 2023 09:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMn-0000ng-Ku
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:57 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMk-000141-Sk
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:57 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64d44b198baso2519505b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849674; x=1687441674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mquIrAzxY6HIVGUqj9r7egc6IC0VGhEvBfBIbrm5c5Q=;
 b=qMyx/P5aqqhAZNIMYpm4J+YceY7sMpMhJdOC7k0chnL3I0c6m0NWqYPRl/K6lWcriY
 xWMG+U5lgWdbcCjwsEUkbbhSxvYYhxYqO82gzGMrXAi1SxzKeO4zi1nXxXMDHeRIntac
 2I11kvphGg/Fz/auvrBDs7JfEDKjzzVxaoIwvvNhVc2cAwvY58uMaQvFfjn/KPRtfnqI
 FRiLYU74M+pe1IOncqzht3WwwptrbfmXJfbfzz/RNPeuROzufB9jdA8nk7BayS52AAnY
 awSj/Hdh5Sr4GhySaTsr3gnnUEeBkgUACg7QkY9bXG/2KVglkjiwgjWmc2jIB4u7Qbe5
 shMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849674; x=1687441674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mquIrAzxY6HIVGUqj9r7egc6IC0VGhEvBfBIbrm5c5Q=;
 b=BS+orOFaOZYVxIbneO9ZByyeW12LZfDY4eS19MmKciJInDFncbM2eajrsQyiHsEiEG
 jX2PCUC9xLR+KvIX6ffZ5nBdB8KMa0vzvE8ExbYNnFr17pBUpKPqyOWhFAwSRhWfkCun
 HS/KAZGjxEg2tJwG2NO8iI3YaTxy1wov0f5IYUX7SxDF1b+aoRfjmPVtMA20XoFelDf5
 +Gnes4HHKVQL6ICEQ6trEDm+xxChL7Akl39cDYfvB6qp9yfNT4n8Kz2rWDDQAc4lt+E+
 N4UNg7dmMsLadJvLNqsDALn7Kfm9HqTjmIkoAfE1rYHJmD9e+hs/CuBTw6XRtN/7w2c4
 M6Kw==
X-Gm-Message-State: AC+VfDyiunfFmIxWtm44VrSeMzt0+yK5Afm2+Yoz4V/Ho5L3MWtqFtfY
 B++8/GJu5sASvRtblLYGSP+/eqVTa+Ru3k1D3tY=
X-Google-Smtp-Source: ACHHUZ46FqS9H0KFCX2bQrdGaQHOa1fYc+U+gjQ6LVynCZ9uAxOwu0Mcrc9CJOf0Cr64iCUtM6HzHw==
X-Received: by 2002:a05:6a00:990:b0:64d:40e0:5580 with SMTP id
 u16-20020a056a00099000b0064d40e05580mr15394039pfg.3.1684849674059; 
 Tue, 23 May 2023 06:47:54 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 j4-20020aa79284000000b0064d1349dc31sm5737122pfa.199.2023.05.23.06.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:47:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 22/27] qemu/atomic128: Split atomic16_read
Date: Tue, 23 May 2023 06:47:28 -0700
Message-Id: <20230523134733.678646-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523134733.678646-1-richard.henderson@linaro.org>
References: <20230523134733.678646-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Create both atomic16_read_ro and atomic16_read_rw.
Previously we pretended that we had atomic16_read in system mode,
because we "know" that all ram is always writable to the host.
Now, expose read-only and read-write versions all of the time.

For aarch64, do not fall back to __atomic_read_16 even if
supported by the compiler, to work around a clang bug.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/aarch64/host/atomic128-ldst.h | 21 ++++++++-------
 host/include/generic/host/atomic128-ldst.h | 31 ++++++++++++++++------
 target/s390x/tcg/mem_helper.c              |  2 +-
 3 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/host/include/aarch64/host/atomic128-ldst.h b/host/include/aarch64/host/atomic128-ldst.h
index bd61fce50d..4b1360de39 100644
--- a/host/include/aarch64/host/atomic128-ldst.h
+++ b/host/include/aarch64/host/atomic128-ldst.h
@@ -11,10 +11,18 @@
 #ifndef AARCH64_ATOMIC128_LDST_H
 #define AARCH64_ATOMIC128_LDST_H
 
-/* Through gcc 10, aarch64 has no support for 128-bit atomics.  */
-#if !defined(CONFIG_ATOMIC128) && !defined(CONFIG_USER_ONLY)
-/* We can do better than cmpxchg for AArch64.  */
-static inline Int128 atomic16_read(Int128 *ptr)
+/*
+ * Through gcc 10, aarch64 has no support for 128-bit atomics.
+ * Through clang 16, without -march=armv8.4-a, __atomic_load_16
+ * is incorrectly expanded to a read-write operation.
+ */
+
+#define HAVE_ATOMIC128_RO 0
+#define HAVE_ATOMIC128_RW 1
+
+Int128 QEMU_ERROR("unsupported atomic") atomic16_read_ro(const Int128 *ptr);
+
+static inline Int128 atomic16_read_rw(Int128 *ptr)
 {
     uint64_t l, h;
     uint32_t tmp;
@@ -41,9 +49,4 @@ static inline void atomic16_set(Int128 *ptr, Int128 val)
         : [l] "r"(l), [h] "r"(h));
 }
 
-# define HAVE_ATOMIC128 1
-#else
-#include "host/include/generic/host/atomic128-ldst.h"
-#endif
-
 #endif /* AARCH64_ATOMIC128_LDST_H */
diff --git a/host/include/generic/host/atomic128-ldst.h b/host/include/generic/host/atomic128-ldst.h
index 06a62e9dd0..79d208b7a4 100644
--- a/host/include/generic/host/atomic128-ldst.h
+++ b/host/include/generic/host/atomic128-ldst.h
@@ -12,16 +12,25 @@
 #define HOST_ATOMIC128_LDST_H
 
 #if defined(CONFIG_ATOMIC128)
+# define HAVE_ATOMIC128_RO 1
+# define HAVE_ATOMIC128_RW 1
+
 static inline Int128 ATTRIBUTE_ATOMIC128_OPT
-atomic16_read(Int128 *ptr)
+atomic16_read_ro(const Int128 *ptr)
 {
-    __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
+    const __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
     Int128Alias r;
 
     r.i = qatomic_read__nocheck(ptr_align);
     return r.s;
 }
 
+static inline Int128 ATTRIBUTE_ATOMIC128_OPT
+atomic16_read_rw(Int128 *ptr)
+{
+    return atomic16_read_ro(ptr);
+}
+
 static inline void ATTRIBUTE_ATOMIC128_OPT
 atomic16_set(Int128 *ptr, Int128 val)
 {
@@ -32,10 +41,14 @@ atomic16_set(Int128 *ptr, Int128 val)
     qatomic_set__nocheck(ptr_align, v.i);
 }
 
-# define HAVE_ATOMIC128 1
-#elif defined(CONFIG_CMPXCHG128) && !defined(CONFIG_USER_ONLY)
+#elif defined(CONFIG_CMPXCHG128)
+# define HAVE_ATOMIC128_RO 0
+# define HAVE_ATOMIC128_RW 1
+
+Int128 QEMU_ERROR("unsupported atomic") atomic16_read_ro(const Int128 *ptr);
+
 static inline Int128 ATTRIBUTE_ATOMIC128_OPT
-atomic16_read(Int128 *ptr)
+atomic16_read_rw(Int128 *ptr)
 {
     /* Maybe replace 0 with 0, returning the old value.  */
     Int128 z = int128_make64(0);
@@ -52,12 +65,14 @@ atomic16_set(Int128 *ptr, Int128 val)
     } while (int128_ne(old, cmp));
 }
 
-# define HAVE_ATOMIC128 1
 #else
+# define HAVE_ATOMIC128_RO 0
+# define HAVE_ATOMIC128_RW 0
+
 /* Fallback definitions that must be optimized away, or error.  */
-Int128 QEMU_ERROR("unsupported atomic") atomic16_read(Int128 *ptr);
+Int128 QEMU_ERROR("unsupported atomic") atomic16_read_ro(const Int128 *ptr);
+Int128 QEMU_ERROR("unsupported atomic") atomic16_read_rw(Int128 *ptr);
 void QEMU_ERROR("unsupported atomic") atomic16_set(Int128 *ptr, Int128 val);
-# define HAVE_ATOMIC128 0
 #endif
 
 #endif /* HOST_ATOMIC128_LDST_H */
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index aa8ec6ba6d..d02ec861d8 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -1780,7 +1780,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
         max = 3;
 #endif
         if ((HAVE_CMPXCHG128 ? 0 : fc + 2 > max) ||
-            (HAVE_ATOMIC128  ? 0 : sc > max)) {
+            (HAVE_ATOMIC128_RW ? 0 : sc > max)) {
             cpu_loop_exit_atomic(env_cpu(env), ra);
         }
     }
-- 
2.34.1


