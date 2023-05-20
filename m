Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D6270A910
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 18:27:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0PPr-0003aV-44; Sat, 20 May 2023 12:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PPp-0003ZX-Ck
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:26:45 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PPm-00035d-Tg
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:26:45 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1ae557aaf1dso37487775ad.2
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684600001; x=1687192001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCEmCa6svz6iI89FPgua0fOjkJEldQJYp9iT0pK2PQY=;
 b=S3C5W9l29tHbB0CbIR/XyPKetPQ5zqRW++q9amRBFfI0RpOpWpOxN3oriGV5TJUupa
 nku9WoZdEuvtS/aKLoVKUEIu/AOiYzP+DYyUbPlhFCJITGWhZzYR5exxi3lhUyTBQOLI
 F/TP6QY9D2o3OejOXMX/j+p2wD2u1DhvmkjY3n8Xo3KnrFA40YQffqJrrcAxx5uss3JL
 LvpwrwUbFn83J4Q2fG7Hst/eIF/pGoUeSEblNXcbsRNSNeiohbk5rFt/njT4Ay7PeNQf
 FXG3irN/2rtsWr4S8u1yp1qpS8OamwYsD2ddUb7W+ZDOTpV75qUuGQBFfnuzoUWsdxIw
 Mrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684600001; x=1687192001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCEmCa6svz6iI89FPgua0fOjkJEldQJYp9iT0pK2PQY=;
 b=Y3ZNnnSAWZTiMfCkchIgcmQhA07KJ2FDAADo3SsY2FxVO1uKAX2XmTTUanE6r1TwP0
 /tJ14YXq5jUhmkSCkaYvRBMOfUzx5FR8iTazm4PH89efZA3R089coMf+BCC+82O/CCZa
 c51ft84IaXFUAJYbE+hcX7QWFIgZrJEEQZw339y1bgRpsEeaq3+ltaRX+3uVagps49Xb
 hLcOQbLJjEBqL6wamdbfmYH/ykiAAQFzWfGtDMkwYMJYoEUlOm7ublZXI7Fwz4OoKztm
 w19AEy9ZdWmqshg1y3iH3WAaSFRkRnUJMSSlEMOC8GQRXqIQp/iFuPaKDrVxYpVeQ/xQ
 HIiw==
X-Gm-Message-State: AC+VfDyDEDFudjhuQUXFbBdhuOIRq/K0WDAz3nrXnUwP6Ltu+R6U+l8P
 Yrjn8h9R4bE8jA10aokKV40xlCRgczIuoR2sC9k=
X-Google-Smtp-Source: ACHHUZ5rjQHQZDJEZeHXaeYtedjMV65+z/zL9Kw2A1VRJYw8AKMVc5HtGAmlnlCStdQDxmHRO8+PIg==
X-Received: by 2002:a17:903:25ce:b0:1ac:797b:8cf6 with SMTP id
 jc14-20020a17090325ce00b001ac797b8cf6mr5911958plb.69.1684600001507; 
 Sat, 20 May 2023 09:26:41 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:d078:d94e:cb2b:a055])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170903230c00b001a5260a6e6csm1697104plh.206.2023.05.20.09.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 09:26:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Juan Quintela <quintela@redhat.com>
Subject: [PATCH 06/27] migration/xbzrle: Shuffle function order
Date: Sat, 20 May 2023 09:26:13 -0700
Message-Id: <20230520162634.3991009-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230520162634.3991009-1-richard.henderson@linaro.org>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Place the CONFIG_AVX512BW_OPT block at the top,
which will aid function selection in the next patch.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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


