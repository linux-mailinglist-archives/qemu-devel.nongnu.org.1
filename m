Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7FD70E9F1
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 02:03:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1btV-0004BK-6E; Tue, 23 May 2023 19:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btO-00049r-EK
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:15 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btM-0001mh-HL
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:14 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64d3491609fso102340b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886291; x=1687478291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ye0/RXUVZWBrvEwXDswgbk/0qm/ligDVrCm5lhuZP0=;
 b=iEdq+DMv47db3W/6eb6wJDsYOz+GsrBJzgUBX6t/3H0Z8BdUkOqfrdhWaeVzFpRiWe
 +qrxn1YbIkStcws9d7S5jAh0c0uPA+xz7eSmXvvz7KHZQYA2xzDPaWkKiW7Rst5kivpc
 Ze9bV1uyLLFw0bp1HYLaf3D2bkshXf07aH4VypfV1LbpIFPf0yQX4vuxaS7jq0QOYoH0
 I9ohpZyQkowp2dt7IeMQi0Lws9m0i97O8jWuktxJAVUTgQyDNwdXtYv8w7mBUJiF0B7m
 zMwZ4krQjtXKL5lM+c0gsC/Bfr64uCYpiCQAhoT/xMxGpz58fT8bk8bWQTMWV+lKhekm
 MDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886291; x=1687478291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ye0/RXUVZWBrvEwXDswgbk/0qm/ligDVrCm5lhuZP0=;
 b=Clx3jhT/JSGYu4LebTmbF5WAfXWgG5DM00g7RBv56GPDOSVsvt/JWkRvRudhLqhtQB
 FhnvhgvCwO6+rJ+xNoAwWoKo+BDOAr8oukebrcAtZmN+jZiEujXeUVTMXarMKstRa4jy
 Y6eBBP9DphO/WQvJoeLBVZoHsdVwYhAbe6yCpn+lXvFKKqe/basACp9vcE2d+cbPfT2w
 bQd4xVvIHIYcsflFmGWc/gTNzGUMusmrTCoeyahy5ANaCsCP7bTWjoGV2CW1sGAiRelB
 1T3sNaYPeH7L/OZPmcbFIQ/5Yar8m5ZrTWguPBIETyWMyOjsgtfC8U82dQOgRIgYe7yf
 Yd5A==
X-Gm-Message-State: AC+VfDy45Uu35x7kccN4ISSEki9Z42QJAtffdoBqiy2N+OqMpnw3FdiN
 e9oSMwstDQK0VBCtj4r9lvaGzzDOw+lSt5R8F+4=
X-Google-Smtp-Source: ACHHUZ5l8z10pfzFMfFyXZMqJ5zDTu4Ugw63P3UyNkmRxspvGKCySle5QTowCoE0GdoUZrIaUbDPtQ==
X-Received: by 2002:a05:6a00:22c2:b0:64c:c5f9:1533 with SMTP id
 f2-20020a056a0022c200b0064cc5f91533mr1048118pfj.33.1684886291261; 
 Tue, 23 May 2023 16:58:11 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: [PULL 06/28] migration/xbzrle: Shuffle function order
Date: Tue, 23 May 2023 16:57:42 -0700
Message-Id: <20230523235804.747803-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523235804.747803-1-richard.henderson@linaro.org>
References: <20230523235804.747803-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


