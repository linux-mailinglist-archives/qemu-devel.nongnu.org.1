Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB277743CB4
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:26:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4t-0007mu-8e; Fri, 30 Jun 2023 09:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4p-0007jx-14
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4n-0003ST-AC
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:18 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbc0981733so16661035e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131336; x=1690723336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mwwpiV6MaHNjI0ciuX+pvMo7jFfE+x6J89Pmy8AxQUY=;
 b=Bf9ReICQepZmHlH27q33m7J8RebYRc2M5lM7V4u1l7+l2O1Kp/9SX3IVGixiMEXLfN
 x/q3zFe8/yQPHf6G04ektFlh8qwL5feJRETU/sDVUDpa/6/04xpaUVNI8qJ/O8eufd54
 fy64p3g0M/u47sXQmDxwevFxxYkfcldGn1SSuCBklvSaciG9q9X1uMx3w8PHtNn8wGAs
 9F4k1ia3RnT5ga9aobQJl+HDp5WuSjIGEpn+gxUKWTxBzyj19oLOIzHa8o12QPAP4FsS
 pUN5XdXiVdAO8+0Yt+MKeVgnbCfGveAH4NbSPDgV4pmk4CQGRTxHYPy2lihH0Wva5rYV
 pkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131336; x=1690723336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mwwpiV6MaHNjI0ciuX+pvMo7jFfE+x6J89Pmy8AxQUY=;
 b=j5u3E+TqbmqEclzGxO8ezj6OolHeGu15mpgVIOLTpG892G2oUREFgIEPmeIIkz84cf
 silRQYBVHLgYexJ7L9Cime+hEZBq09+cmnAM+p99xuSEofcpqM4I/gaviwnrXqZ7/STU
 cZ9oDNfZlEBEli8CllPViwWK7qoT3oZ9x1LEzHXBr0VYH8Qe0OCX2og1w62asxPlar3i
 Oo8f0jrmDcpj19Yj2C0e3oYYM4rlRzgv36be60wrvprjdJNnSP7cQ+3/Q0FVwfyo3gK2
 USzLMnSTHYDD0NyD5K8TpP0HL2Rw3Q9tKGy2hYUiSkXu1tOLs1l5Xv3j41zsat1L0yv2
 yRtg==
X-Gm-Message-State: AC+VfDyKlI+F74Gy+fbj2kwKnvqxACpwSWUf1YJI8FNgG6IT7YvN0l7F
 xyawnj3+lpZ9kzY4GLze0Gl4ZyCyznoCo1/wmY+dIQ==
X-Google-Smtp-Source: ACHHUZ6yOw+qw6HwDIyuIWb0KrHPr1asa5zQ/JgfHUeq+OpMK6a+I7mOGv458SrdhMcfq1GDpOHVvw==
X-Received: by 2002:a7b:c8d1:0:b0:3fa:9554:fb23 with SMTP id
 f17-20020a7bc8d1000000b003fa9554fb23mr2192997wml.21.1688131335472; 
 Fri, 30 Jun 2023 06:22:15 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 19/24] linux-user: Rename mmap_reserve to mmap_reserve_or_unmap
Date: Fri, 30 Jun 2023 15:21:54 +0200
Message-Id: <20230630132159.376995-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

If !reserved_va, munmap instead and assert success.
Update all callers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 6b030dac42..8c90a690dd 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -722,14 +722,14 @@ fail:
     return -1;
 }
 
-static void mmap_reserve(abi_ulong start, abi_ulong len)
+static void mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
 {
     abi_ulong real_start;
     abi_ulong real_last;
     abi_ulong real_len;
     abi_ulong last;
     abi_ulong a;
-    void *host_start, *ptr;
+    void *host_start;
     int prot;
 
     last = start + len - 1;
@@ -776,9 +776,15 @@ static void mmap_reserve(abi_ulong start, abi_ulong len)
     real_len = real_last - real_start + 1;
     host_start = g2h_untagged(real_start);
 
-    ptr = mmap(host_start, real_len, PROT_NONE,
-               MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
-    assert(ptr == host_start);
+    if (reserved_va) {
+        void *ptr = mmap(host_start, real_len, PROT_NONE,
+                         MAP_FIXED | MAP_ANONYMOUS
+                         | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
+        assert(ptr == host_start);
+    } else {
+        int ret = munmap(host_start, real_len);
+        assert(ret == 0);
+    }
 }
 
 int target_munmap(abi_ulong start, abi_ulong len)
@@ -830,11 +836,7 @@ int target_munmap(abi_ulong start, abi_ulong len)
     ret = 0;
     /* unmap what we can */
     if (real_start < real_end) {
-        if (reserved_va) {
-            mmap_reserve(real_start, real_end - real_start);
-        } else {
-            ret = munmap(g2h_untagged(real_start), real_end - real_start);
-        }
+        mmap_reserve_or_unmap(real_start, real_end - real_start);
     }
 
     if (ret == 0) {
@@ -871,7 +873,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
              * If new and old addresses overlap then the above mremap will
              * already have failed with EINVAL.
              */
-            mmap_reserve(old_addr, old_size);
+            mmap_reserve_or_unmap(old_addr, old_size);
         }
     } else if (flags & MREMAP_MAYMOVE) {
         abi_ulong mmap_start;
@@ -886,7 +888,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                                flags | MREMAP_FIXED,
                                g2h_untagged(mmap_start));
             if (reserved_va) {
-                mmap_reserve(old_addr, old_size);
+                mmap_reserve_or_unmap(old_addr, old_size);
             }
         }
     } else {
@@ -912,7 +914,8 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                     errno = ENOMEM;
                     host_addr = MAP_FAILED;
                 } else if (reserved_va && old_size > new_size) {
-                    mmap_reserve(old_addr + old_size, old_size - new_size);
+                    mmap_reserve_or_unmap(old_addr + old_size,
+                                          old_size - new_size);
                 }
             }
         } else {
-- 
2.34.1


