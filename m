Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BEB70DE04
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:53:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SMi-0000UP-PQ; Tue, 23 May 2023 09:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMf-0000Hi-MS
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:49 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMd-000175-IL
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:49 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-64d5f65a2f7so2014712b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849666; x=1687441666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DqFQEVjlcRQv07fj6FpnhLPU4q7Af597SdqlFdm/+U=;
 b=hcOc3ftnldIG8D8G0l6d7WeujSpQ/+j/KpzJcqYwAFWPzVBxuHn5PtdyWjf7baHmn6
 CjS89sPL1mCXRu1YO2liOcWQSAa+n6xDsDCaQF0jsxvIzUMnsPmSIwhPVLFWe2z+BMoY
 Jy4ZTHhUNU1hl/E0XzSlsB5kbHknEkO8wrWSBbHuwgO49gVRLSOKGAP5+FTo+0lYyIDG
 J1RpSRMuXIQtkuCDGUSWYh7He3WF7Zzo+Ur/mXjRDWrrU+ez7jbcbYyAPrYVg6ywU+9F
 eDDNuqZ7K9As/kvcrc2urHMvBgdlA/o42liF/Ly36KztbsrSui6sqxq+vtj6ZmCJgWcv
 U/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849666; x=1687441666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2DqFQEVjlcRQv07fj6FpnhLPU4q7Af597SdqlFdm/+U=;
 b=IVagL8MdwIQ/cCRd7u9oE0qnVqybyIV4MeffHsQODRRVFYZP/dMtSEUk7t688hEiRf
 oubP7jXd+q6uaX6BdhzyVjGD16TgGzXpY79P+GSrwDumL8U0op34jRVPjPRaod/h6fbV
 A6QGpV1j6jISe3w+7w2Qqz3sR6KsFTUOjoFVuEES9J6zR+YM50nO7IYbaJHSDGedek9Y
 WPdIMQpvhvbKu8olmlEUxeBVn59gMg+yXnR8ivvTGzAJ/2zKuOmnH40sqzkAo5/a30aV
 oZ6j5WrcwPm8X9uylqdG4+GlSWa4fdKygMgC5TRtvw6EMk5k5JkThmmiFerjLFTqjeTb
 VCcw==
X-Gm-Message-State: AC+VfDwFNE6vDNpMUqdGazSd13L+7rHwQxHhKvXa8+xjcGff3bv0eFNo
 Go0eSJgoUO9hslCqSxev14jR1MKe1fSgIgKvtPA=
X-Google-Smtp-Source: ACHHUZ5KWYmXT2Ued3HfW3UzT4qxG1huyvBOaGIgPpItaHUAntmFElcNjlsH/Bi6B2eyl+4Aerx/Qw==
X-Received: by 2002:a05:6a20:c701:b0:105:53:998 with SMTP id
 hi1-20020a056a20c70100b0010500530998mr12486354pzb.12.1684849666339; 
 Tue, 23 May 2023 06:47:46 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 j4-20020aa79284000000b0064d1349dc31sm5737122pfa.199.2023.05.23.06.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:47:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 13/27] include/qemu: Move CONFIG_ATOMIC128_OPT handling to
 atomic128.h
Date: Tue, 23 May 2023 06:47:19 -0700
Message-Id: <20230523134733.678646-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523134733.678646-1-richard.henderson@linaro.org>
References: <20230523134733.678646-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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


