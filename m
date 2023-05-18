Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F1470793D
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 06:43:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzVRx-00068R-Eq; Thu, 18 May 2023 00:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzVRu-00067U-RU
 for qemu-devel@nongnu.org; Thu, 18 May 2023 00:41:10 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzVRr-00078K-EV
 for qemu-devel@nongnu.org; Thu, 18 May 2023 00:41:10 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-52cb78647ecso1057356a12.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 21:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684384866; x=1686976866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hvg0osdHLkOhj0PtXI1wjXd4d+316/OODP4J9ycDye8=;
 b=rt+3qUBQZYYYaWkN6wOqCXvXrj8vFXx4cgP9nkOjXBx04byJNDPeXb/b46E+Vqggb2
 rdSoPw6geyR/Zl9ZXy10NRd/YszfbWt+CgICwinooUec4lAKUojJXHWL6LbwUCW6QKn5
 dO4VYU0ENXZJeanukcAPCqWmkkx5ZxOM6vKkJoJ7ZLu8zPM1jTl5N/Gok1Aqkg4axP9U
 HCWcA3kUmecVkYgKOWeUR86qnbJRPRmlXmyBWDO9WKUEny3ZLNMYNc8n3B0swFrnsoyq
 3Y6j0q95D9d4B8b62Yw+178NYiL4296ti1QFGD0cj9XICEB9y3hYihuOKnz4fJD8SAT/
 8HAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684384866; x=1686976866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hvg0osdHLkOhj0PtXI1wjXd4d+316/OODP4J9ycDye8=;
 b=Xg00UGIWuNFxDhHp0++CLC9oGc6MjYHlc6clfv8hH/qzO4LUhoGZAXaxuE4g+dkFTN
 27evlBza6ouedu+2f+hs84I4VjQAZuXQaESADhlqg9K4j2BjCwqZQOcHLKjGYhJ6xCNB
 lYO5Kzf0w6226+ehJ9omTRcfrez4h+PhkHwacIPMhNbTWjJMwY78R/PDPCOSdlbKfO+Y
 0BfiIKL5a4XRTbQzJjPF2ByVXEAu72ftFVRDDawVfvxd5Nkh3/3UjzrnklCkqADc9vGl
 mSUfQXDmtbgZJi3HklxD/yFJAYSqs+2m0c3EMqjLkJxBx5HPMx2GAMoTkBAv+E5Endg3
 cxqQ==
X-Gm-Message-State: AC+VfDw4otP+jHZKB4uAmg6Rn6R6tokSDY42odVVCJiYGjZWeii5slGQ
 G+w/ZzCNlpnOWVEwJe9i0A/RbvpoUvGzPbEsqhs=
X-Google-Smtp-Source: ACHHUZ7e+STJb8+KEnSBTVobU/3M4riRnZ5jiHMOEl7GAgyrM03cGGYiN66+2YwWYmmxhytOw0o68w==
X-Received: by 2002:a17:902:b18c:b0:1ae:5c80:5d61 with SMTP id
 s12-20020a170902b18c00b001ae5c805d61mr950434plr.28.1684384866136; 
 Wed, 17 May 2023 21:41:06 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a170902e84900b001ab1d23bf5dsm225592plg.258.2023.05.17.21.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 21:41:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 6/9] migration/xbzrle: Shuffle function order
Date: Wed, 17 May 2023 21:40:55 -0700
Message-Id: <20230518044058.2777467-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518044058.2777467-1-richard.henderson@linaro.org>
References: <20230518044058.2777467-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Place the CONFIG_AVX512BW_OPT block at the top,
which will aid function selection in the next patch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Cc: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>
---
 migration/xbzrle.c | 244 ++++++++++++++++++++++-----------------------
 1 file changed, 122 insertions(+), 122 deletions(-)

diff --git a/migration/xbzrle.c b/migration/xbzrle.c
index 258e4959c9..751b5428f7 100644
--- a/migration/xbzrle.c
+++ b/migration/xbzrle.c
@@ -15,6 +15,128 @@
 #include "qemu/host-utils.h"
 #include "xbzrle.h"
 
+#if defined(CONFIG_AVX512BW_OPT)
+#include <immintrin.h>
+
+int __attribute__((target("avx512bw")))
+xbzrle_encode_buffer_avx512(uint8_t *old_buf, uint8_t *new_buf, int slen,
+                            uint8_t *dst, int dlen)
+{
+    uint32_t zrun_len = 0, nzrun_len = 0;
+    int d = 0, i = 0, num = 0;
+    uint8_t *nzrun_start = NULL;
+    /* add 1 to include residual part in main loop */
+    uint32_t count512s = (slen >> 6) + 1;
+    /* countResidual is tail of data, i.e., countResidual = slen % 64 */
+    uint32_t count_residual = slen & 0b111111;
+    bool never_same = true;
+    uint64_t mask_residual = 1;
+    mask_residual <<= count_residual;
+    mask_residual -= 1;
+    __m512i r = _mm512_set1_epi32(0);
+
+    while (count512s) {
+        int bytes_to_check = 64;
+        uint64_t mask = 0xffffffffffffffff;
+        if (count512s == 1) {
+            bytes_to_check = count_residual;
+            mask = mask_residual;
+        }
+        __m512i old_data = _mm512_mask_loadu_epi8(r,
+                                                  mask, old_buf + i);
+        __m512i new_data = _mm512_mask_loadu_epi8(r,
+                                                  mask, new_buf + i);
+        uint64_t comp = _mm512_cmpeq_epi8_mask(old_data, new_data);
+        count512s--;
+
+        bool is_same = (comp & 0x1);
+        while (bytes_to_check) {
+            if (d + 2 > dlen) {
+                return -1;
+            }
+            if (is_same) {
+                if (nzrun_len) {
+                    d += uleb128_encode_small(dst + d, nzrun_len);
+                    if (d + nzrun_len > dlen) {
+                        return -1;
+                    }
+                    nzrun_start = new_buf + i - nzrun_len;
+                    memcpy(dst + d, nzrun_start, nzrun_len);
+                    d += nzrun_len;
+                    nzrun_len = 0;
+                }
+                /* 64 data at a time for speed */
+                if (count512s && (comp == 0xffffffffffffffff)) {
+                    i += 64;
+                    zrun_len += 64;
+                    break;
+                }
+                never_same = false;
+                num = ctz64(~comp);
+                num = (num < bytes_to_check) ? num : bytes_to_check;
+                zrun_len += num;
+                bytes_to_check -= num;
+                comp >>= num;
+                i += num;
+                if (bytes_to_check) {
+                    /* still has different data after same data */
+                    d += uleb128_encode_small(dst + d, zrun_len);
+                    zrun_len = 0;
+                } else {
+                    break;
+                }
+            }
+            if (never_same || zrun_len) {
+                /*
+                 * never_same only acts if
+                 * data begins with diff in first count512s
+                 */
+                d += uleb128_encode_small(dst + d, zrun_len);
+                zrun_len = 0;
+                never_same = false;
+            }
+            /* has diff, 64 data at a time for speed */
+            if ((bytes_to_check == 64) && (comp == 0x0)) {
+                i += 64;
+                nzrun_len += 64;
+                break;
+            }
+            num = ctz64(comp);
+            num = (num < bytes_to_check) ? num : bytes_to_check;
+            nzrun_len += num;
+            bytes_to_check -= num;
+            comp >>= num;
+            i += num;
+            if (bytes_to_check) {
+                /* mask like 111000 */
+                d += uleb128_encode_small(dst + d, nzrun_len);
+                /* overflow */
+                if (d + nzrun_len > dlen) {
+                    return -1;
+                }
+                nzrun_start = new_buf + i - nzrun_len;
+                memcpy(dst + d, nzrun_start, nzrun_len);
+                d += nzrun_len;
+                nzrun_len = 0;
+                is_same = true;
+            }
+        }
+    }
+
+    if (nzrun_len != 0) {
+        d += uleb128_encode_small(dst + d, nzrun_len);
+        /* overflow */
+        if (d + nzrun_len > dlen) {
+            return -1;
+        }
+        nzrun_start = new_buf + i - nzrun_len;
+        memcpy(dst + d, nzrun_start, nzrun_len);
+        d += nzrun_len;
+    }
+    return d;
+}
+#endif
+
 /*
   page = zrun nzrun
        | zrun nzrun page
@@ -175,125 +297,3 @@ int xbzrle_decode_buffer(uint8_t *src, int slen, uint8_t *dst, int dlen)
 
     return d;
 }
-
-#if defined(CONFIG_AVX512BW_OPT)
-#include <immintrin.h>
-
-int __attribute__((target("avx512bw")))
-xbzrle_encode_buffer_avx512(uint8_t *old_buf, uint8_t *new_buf, int slen,
-                            uint8_t *dst, int dlen)
-{
-    uint32_t zrun_len = 0, nzrun_len = 0;
-    int d = 0, i = 0, num = 0;
-    uint8_t *nzrun_start = NULL;
-    /* add 1 to include residual part in main loop */
-    uint32_t count512s = (slen >> 6) + 1;
-    /* countResidual is tail of data, i.e., countResidual = slen % 64 */
-    uint32_t count_residual = slen & 0b111111;
-    bool never_same = true;
-    uint64_t mask_residual = 1;
-    mask_residual <<= count_residual;
-    mask_residual -= 1;
-    __m512i r = _mm512_set1_epi32(0);
-
-    while (count512s) {
-        int bytes_to_check = 64;
-        uint64_t mask = 0xffffffffffffffff;
-        if (count512s == 1) {
-            bytes_to_check = count_residual;
-            mask = mask_residual;
-        }
-        __m512i old_data = _mm512_mask_loadu_epi8(r,
-                                                  mask, old_buf + i);
-        __m512i new_data = _mm512_mask_loadu_epi8(r,
-                                                  mask, new_buf + i);
-        uint64_t comp = _mm512_cmpeq_epi8_mask(old_data, new_data);
-        count512s--;
-
-        bool is_same = (comp & 0x1);
-        while (bytes_to_check) {
-            if (d + 2 > dlen) {
-                return -1;
-            }
-            if (is_same) {
-                if (nzrun_len) {
-                    d += uleb128_encode_small(dst + d, nzrun_len);
-                    if (d + nzrun_len > dlen) {
-                        return -1;
-                    }
-                    nzrun_start = new_buf + i - nzrun_len;
-                    memcpy(dst + d, nzrun_start, nzrun_len);
-                    d += nzrun_len;
-                    nzrun_len = 0;
-                }
-                /* 64 data at a time for speed */
-                if (count512s && (comp == 0xffffffffffffffff)) {
-                    i += 64;
-                    zrun_len += 64;
-                    break;
-                }
-                never_same = false;
-                num = ctz64(~comp);
-                num = (num < bytes_to_check) ? num : bytes_to_check;
-                zrun_len += num;
-                bytes_to_check -= num;
-                comp >>= num;
-                i += num;
-                if (bytes_to_check) {
-                    /* still has different data after same data */
-                    d += uleb128_encode_small(dst + d, zrun_len);
-                    zrun_len = 0;
-                } else {
-                    break;
-                }
-            }
-            if (never_same || zrun_len) {
-                /*
-                 * never_same only acts if
-                 * data begins with diff in first count512s
-                 */
-                d += uleb128_encode_small(dst + d, zrun_len);
-                zrun_len = 0;
-                never_same = false;
-            }
-            /* has diff, 64 data at a time for speed */
-            if ((bytes_to_check == 64) && (comp == 0x0)) {
-                i += 64;
-                nzrun_len += 64;
-                break;
-            }
-            num = ctz64(comp);
-            num = (num < bytes_to_check) ? num : bytes_to_check;
-            nzrun_len += num;
-            bytes_to_check -= num;
-            comp >>= num;
-            i += num;
-            if (bytes_to_check) {
-                /* mask like 111000 */
-                d += uleb128_encode_small(dst + d, nzrun_len);
-                /* overflow */
-                if (d + nzrun_len > dlen) {
-                    return -1;
-                }
-                nzrun_start = new_buf + i - nzrun_len;
-                memcpy(dst + d, nzrun_start, nzrun_len);
-                d += nzrun_len;
-                nzrun_len = 0;
-                is_same = true;
-            }
-        }
-    }
-
-    if (nzrun_len != 0) {
-        d += uleb128_encode_small(dst + d, nzrun_len);
-        /* overflow */
-        if (d + nzrun_len > dlen) {
-            return -1;
-        }
-        nzrun_start = new_buf + i - nzrun_len;
-        memcpy(dst + d, nzrun_start, nzrun_len);
-        d += nzrun_len;
-    }
-    return d;
-}
-#endif
-- 
2.34.1


