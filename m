Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF4670E9F8
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 02:04:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1bu8-0004Ok-7W; Tue, 23 May 2023 19:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btl-0004J6-Fd
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:37 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btc-0001lW-Pb
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:37 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-64d41d8bc63so123957b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886308; x=1687478308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5xRZz/kuOTdd5TU904Y896iQ+sGtDMJKa0ny6/I3nUo=;
 b=Ses2nkijVl+BQ79F/LgRIB00D9bj6Ce23NwKDzKBBz6wRSSwPxX7xvhVxlDOTye2Pv
 SpiM6+FNqhwUIDrAHjWnSskQ/Sy/KQLyD7eYsaC4F2gJ7q0c4brlxklgDDPOjzwfCN8o
 s6DWHpPJ0kJhsRZ4WweZO4983y+nwc1cBRUtDSGDpJsSCw+ES0y8bGiabDvQjB78aBhp
 YQvOLC8HXF56PE8dIURP6hSocGKOArJc6jrqWLYQxKRbN22WXZC8PMsUbhudFasYXnQG
 iSwSZ6+cKS04lwbxI2RIBV9p0NHQFLnB8R4Z6SbNHTGC30+vjioRlde8WEWP+t6VkDsf
 YJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886308; x=1687478308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5xRZz/kuOTdd5TU904Y896iQ+sGtDMJKa0ny6/I3nUo=;
 b=V/wn3OMDcCpgKLlWctvTSa5xAUotFqT8LnsSnCqBGZn7CtILqGc6AW25n0OzBxnek8
 IFCecSJf9doJ9LWnh6RO4dGkOQZXbB+v5hS5wMuYpKgdsgUkeCijLjcEK/yPH2YX2gdi
 6EE2XnCDiNM+o5pHsvPVgZt3d0sUAOOVbgp7y98JVDrg6JM6gvCGuXZelqZayKF7U8C6
 uuPa1sqvCcyC0z4FcPq9FcCaMtgmbEaGnlFelo8omjPetMeBlDqkIzqij6Eb+3uRKbBM
 pU30LowKt4W4OBSzohN350G0Sf1wNcwNeYC4kJoMXuFgssRrCnst1HSqbo0ditMiArYP
 2JKA==
X-Gm-Message-State: AC+VfDwtZ5Mi4b1W+PzzvDjkOr3xiBZz0VAV8FmJHsmHTCskUFVJB44I
 noms1nT6jVGtqw32JMfL/44SRA8LdflKN1hcCmc=
X-Google-Smtp-Source: ACHHUZ4GO8+luN0prRZRjAkD7c4z/8P+JWPw1u8lAuUvL5pVv9JhFB4o+KJChk+4iofmBoAMWP3LTw==
X-Received: by 2002:a05:6a00:218a:b0:64d:1451:8233 with SMTP id
 h10-20020a056a00218a00b0064d14518233mr838823pfi.21.1684886308039; 
 Tue, 23 May 2023 16:58:28 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 26/28] qemu/atomic128: Add runtime test for FEAT_LSE2
Date: Tue, 23 May 2023 16:58:02 -0700
Message-Id: <20230523235804.747803-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523235804.747803-1-richard.henderson@linaro.org>
References: <20230523235804.747803-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


