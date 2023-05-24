Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5F470EA9C
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 03:16:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1d5k-00005h-HW; Tue, 23 May 2023 21:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1d5j-00005H-4a
 for qemu-devel@nongnu.org; Tue, 23 May 2023 21:15:03 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1d5c-0001jN-79
 for qemu-devel@nongnu.org; Tue, 23 May 2023 21:15:02 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-64d5f65a2f7so163012b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 18:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684890894; x=1687482894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ly+VK0VMO/TuoOVvjQ+uSzdztuTYMwcqrfWrGWGkIGA=;
 b=tvE0sIaa0irnsXrB+OiIf8PLWgS3fsoNDU3/YwPvpNO+eG3/NYAxizSasDkaZS2Lnj
 Wsgl9Lr28Qlc3xrJCgntX4ebRLeK34PD3vouTtsAiMVVlcViANk6WQgTvsy9dkE0oo1d
 vQNiU1fbZdPfbLwkcF2dc7jLA8J0wb1MK7ueooyVbfqrjLq41ZDQGnnwTJRr/+mYTBJp
 YaW/YD7uSB0Xq32G04Hk9GyAAlRB2Eco2S0Ho05mLwyUTx/LO5W2QC4OFSzQjOin67Lq
 CSNwrRXOazsPbkHDSfOMc1WnwDmzs1FGW/NINuUWIwF7oqUZo7pN/Q3WzQQPZEHwmnxQ
 BfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684890894; x=1687482894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ly+VK0VMO/TuoOVvjQ+uSzdztuTYMwcqrfWrGWGkIGA=;
 b=gCANEJSe0uJ6Q6yaTc+aOsJH6fO9Lt5v84MdAE38YJJWo9hLyXO/Ua6smmeY8d26IS
 AmuNqs3cnV54wbdiB6cJa6QRJQX5bPMphiBJIqxK+DqZIU7IlLWYJY59W2gyw+JjyxiT
 0v04mmxDnY8Xe7MJPmHCzK8fXVu4iQrkMVPHyi+Zbgs83DnDZlaejtraiVa09vs2m2Xb
 T+76Uu+dnwWncCiNQ+tSfzyzs1LkSvy2uSW9y9duB18ID+n9+SmkdPltQOmwl9qASCpo
 ad+hEZVQpMNZWvyUS2QzDnndQ1pSi2S6q0mVmYwMpSuO1L9YnCN2NVKQzDAfcivC2kjV
 mMfg==
X-Gm-Message-State: AC+VfDyKaDIGqXIryykdVwy954DAAO5TLb2Td5wnVEpVUB/sq2xFgoLB
 kVM8+Wiui93JdLVUuEVs5WezR9XuW1Jdp+y7MqQ=
X-Google-Smtp-Source: ACHHUZ6TaekuouEQlHvxyKxhyjdcSv1zl7Urteyl0rZY0AqtHLj4J6QFN0wnrtmoWDJ9bLAcKCcr2w==
X-Received: by 2002:a05:6a00:1a12:b0:64d:742f:f590 with SMTP id
 g18-20020a056a001a1200b0064d742ff590mr1119289pfv.8.1684890894268; 
 Tue, 23 May 2023 18:14:54 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 d8-20020aa78688000000b005d72e54a7e1sm6271652pfo.215.2023.05.23.18.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 18:14:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 26/28] qemu/atomic128: Add runtime test for FEAT_LSE2
Date: Tue, 23 May 2023 18:14:52 -0700
Message-Id: <20230524011452.807053-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524011452.807053-1-richard.henderson@linaro.org>
References: <20230524011452.807053-1-richard.henderson@linaro.org>
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
index 4b1360de39..a08f62c40a 100644
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
+            : [mem] "+m"(*ptr), [tmp] "=&r"(tmp), [l] "=&r"(l), [h] "=&r"(h));
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


