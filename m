Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CD670A91A
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 18:28:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0PQJ-0003mZ-QN; Sat, 20 May 2023 12:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQ9-0003fJ-4F
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:06 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQ3-00039N-25
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:03 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1ae6dce19f7so20701315ad.3
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 09:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684600017; x=1687192017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DqFQEVjlcRQv07fj6FpnhLPU4q7Af597SdqlFdm/+U=;
 b=lGaHcHYcW5sessr2JXeHN3gEF1bQzcAqnz0Z2gpqw7SBttpcTsXKlN6oMp0WuV6JP8
 UMLwxrg6zUclXcwkwmbD2vc/+o62K56rf/QeJvAiIl6X8sp3hgWJDs1QEuh5qifTQO57
 zmNYgtYq4A8pc7d5d3z3xv3wze05HGzxpcU5GcWc1YLBm21dZc9JjoYkyAETHIPpWmbl
 sRsPb0hzWfBXmOTxQiL+lrRnH6kSZ4sItIWbx/rsdCjm4jVqJAI5VSRzVHVcRvb/KSAp
 Yp4Y6naleRuQ2/c1/gpZzN3DTeEJ7rNbGyC24f0+ybBNUJO/N1e83y11KvmSqpHOj5+g
 7SzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684600017; x=1687192017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2DqFQEVjlcRQv07fj6FpnhLPU4q7Af597SdqlFdm/+U=;
 b=hA73ODfY6XQ59xDch3OqJ3B0AbvqP+vm7pA3iF3J3j7KttMLi0DMr2eStHFpkwuUsM
 qKF79QMUudfdt/d0hWfP5IBezTGEq7nrVMxIPYY1x0YM5CfvGy9tIsSFBs93a6Ls/E+t
 7X0A8BEropQKID9MGZXAydPRwz4IAgea032p1dw4UVPpjVPxDvww9sQHkh/itAOt3ffP
 y1eqRbf3oRbqp70RJeKNvk5UJb3I86BsfXurpzjgtXqQTk1CDKK1hDKQH17nupDzpR3q
 3f8Kf9WFg/Q0p42HmUfMmRlroTzncztboqNNMbRV3B/y2b5Rv3Z7kwjefm3tpNeMybsz
 SfAg==
X-Gm-Message-State: AC+VfDyOwmsbUtn73apO8w6b+BSqHhWSv1fMe+KoUxu8c5WP2x+dsFqG
 b9nOOalyTzsYesd8/M0s6VRxXPRapq30JJ0GDoA=
X-Google-Smtp-Source: ACHHUZ5aer9MErtKXFS19KMiuw77IWTbGofST9DKlY6Ok1uCUGwmRa6MUXV0AMm8FSHPBu25tN0dkg==
X-Received: by 2002:a17:903:2444:b0:1aa:f203:781c with SMTP id
 l4-20020a170903244400b001aaf203781cmr7423499pls.44.1684600017246; 
 Sat, 20 May 2023 09:26:57 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:d078:d94e:cb2b:a055])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170903230c00b001a5260a6e6csm1697104plh.206.2023.05.20.09.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 09:26:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 13/27] include/qemu: Move CONFIG_ATOMIC128_OPT handling to
 atomic128.h
Date: Sat, 20 May 2023 09:26:20 -0700
Message-Id: <20230520162634.3991009-14-richard.henderson@linaro.org>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Not only the routines in ldst_atomicity.c.inc need markup,
but also the ones in the headers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/atomic128-cas.h  | 12 ++++++++----
 host/include/generic/host/atomic128-ldst.h | 18 ++++++++++++------
 include/qemu/atomic128.h                   | 17 +++++++++++++++++
 accel/tcg/ldst_atomicity.c.inc             | 17 -----------------
 4 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/host/include/generic/host/atomic128-cas.h b/host/include/generic/host/atomic128-cas.h
index 513622fe34..991d3da082 100644
--- a/host/include/generic/host/atomic128-cas.h
+++ b/host/include/generic/host/atomic128-cas.h
@@ -12,24 +12,28 @@
 #define HOST_ATOMIC128_CAS_H
 
 #if defined(CONFIG_ATOMIC128)
-static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
+static inline Int128 ATTRIBUTE_ATOMIC128_OPT
+atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
 {
+    __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
     Int128Alias r, c, n;
 
     c.s = cmp;
     n.s = new;
-    r.i = qatomic_cmpxchg__nocheck((__int128_t *)ptr, c.i, n.i);
+    r.i = qatomic_cmpxchg__nocheck(ptr_align, c.i, n.i);
     return r.s;
 }
 # define HAVE_CMPXCHG128 1
 #elif defined(CONFIG_CMPXCHG128)
-static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
+static inline Int128 ATTRIBUTE_ATOMIC128_OPT
+atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
 {
+    __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
     Int128Alias r, c, n;
 
     c.s = cmp;
     n.s = new;
-    r.i = __sync_val_compare_and_swap_16((__int128_t *)ptr, c.i, n.i);
+    r.i = __sync_val_compare_and_swap_16(ptr_align, c.i, n.i);
     return r.s;
 }
 # define HAVE_CMPXCHG128 1
diff --git a/host/include/generic/host/atomic128-ldst.h b/host/include/generic/host/atomic128-ldst.h
index e7354a9255..46911dfb61 100644
--- a/host/include/generic/host/atomic128-ldst.h
+++ b/host/include/generic/host/atomic128-ldst.h
@@ -12,32 +12,38 @@
 #define HOST_ATOMIC128_LDST_H
 
 #if defined(CONFIG_ATOMIC128)
-static inline Int128 atomic16_read(Int128 *ptr)
+static inline Int128 ATTRIBUTE_ATOMIC128_OPT
+atomic16_read(Int128 *ptr)
 {
+    __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
     Int128Alias r;
 
-    r.i = qatomic_read__nocheck((__int128_t *)ptr);
+    r.i = qatomic_read__nocheck(ptr_align);
     return r.s;
 }
 
-static inline void atomic16_set(Int128 *ptr, Int128 val)
+static inline void ATTRIBUTE_ATOMIC128_OPT
+atomic16_set(Int128 *ptr, Int128 val)
 {
+    __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
     Int128Alias v;
 
     v.s = val;
-    qatomic_set__nocheck((__int128_t *)ptr, v.i);
+    qatomic_set__nocheck(ptr_align, v.i);
 }
 
 # define HAVE_ATOMIC128 1
 #elif !defined(CONFIG_USER_ONLY) && HAVE_CMPXCHG128
-static inline Int128 atomic16_read(Int128 *ptr)
+static inline Int128 ATTRIBUTE_ATOMIC128_OPT
+atomic16_read(Int128 *ptr)
 {
     /* Maybe replace 0 with 0, returning the old value.  */
     Int128 z = int128_make64(0);
     return atomic16_cmpxchg(ptr, z, z);
 }
 
-static inline void atomic16_set(Int128 *ptr, Int128 val)
+static inline void ATTRIBUTE_ATOMIC128_OPT
+atomic16_set(Int128 *ptr, Int128 val)
 {
     Int128 old = *ptr, cmp;
     do {
diff --git a/include/qemu/atomic128.h b/include/qemu/atomic128.h
index 3a8adb4d47..34554bf0ac 100644
--- a/include/qemu/atomic128.h
+++ b/include/qemu/atomic128.h
@@ -15,6 +15,23 @@
 
 #include "qemu/int128.h"
 
+/*
+ * If __alignof(unsigned __int128) < 16, GCC may refuse to inline atomics
+ * that are supported by the host, e.g. s390x.  We can force the pointer to
+ * have our known alignment with __builtin_assume_aligned, however prior to
+ * GCC 13 that was only reliable with optimization enabled.  See
+ *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107389
+ */
+#if defined(CONFIG_ATOMIC128_OPT)
+# if !defined(__OPTIMIZE__)
+#  define ATTRIBUTE_ATOMIC128_OPT  __attribute__((optimize("O1")))
+# endif
+# define CONFIG_ATOMIC128
+#endif
+#ifndef ATTRIBUTE_ATOMIC128_OPT
+# define ATTRIBUTE_ATOMIC128_OPT
+#endif
+
 /*
  * GCC is a house divided about supporting large atomic operations.
  *
diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index ba5db7c366..b89631bbef 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -16,23 +16,6 @@
 #endif
 #define HAVE_al8_fast      (ATOMIC_REG_SIZE >= 8)
 
-/*
- * If __alignof(unsigned __int128) < 16, GCC may refuse to inline atomics
- * that are supported by the host, e.g. s390x.  We can force the pointer to
- * have our known alignment with __builtin_assume_aligned, however prior to
- * GCC 13 that was only reliable with optimization enabled.  See
- *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107389
- */
-#if defined(CONFIG_ATOMIC128_OPT)
-# if !defined(__OPTIMIZE__)
-#  define ATTRIBUTE_ATOMIC128_OPT  __attribute__((optimize("O1")))
-# endif
-# define CONFIG_ATOMIC128
-#endif
-#ifndef ATTRIBUTE_ATOMIC128_OPT
-# define ATTRIBUTE_ATOMIC128_OPT
-#endif
-
 #if defined(CONFIG_ATOMIC128)
 # define HAVE_al16_fast    true
 #else
-- 
2.34.1


