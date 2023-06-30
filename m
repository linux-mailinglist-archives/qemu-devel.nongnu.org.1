Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD01743CA7
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:23:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4l-0007hM-Qe; Fri, 30 Jun 2023 09:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4j-0007gA-Rj
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:13 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4h-0003Qb-LC
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:13 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso2095724f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131330; x=1690723330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aj62CrXurYGS6qldiW3QI3IQ8iB1Fmrh8m1XANRmtvM=;
 b=ONhGhKdTbnT9axHBqRu8dFWgdD/hkHc8DvqCugeUMxW2FInraUeq7xyNj0asJnyTnw
 wEIZlx0i9WOfMvJpFdd4c6ZWxrqVjvs8sz2I93xSChmVNFq+4ezM4BI5FB9TgMsGxesE
 rnHzNudl23A/37o308FwcZ7jP4nqHh+iIuhn/iz+D0A79gfGzwQ8wgS23mYcFWK7Af/u
 ZWI2tE9Zu+DuzULTCYIV0CWlAd1NJ7krjb4JvuxoVpdLL6X7FjEGMFQr4MOrT/rGdxjM
 ZvapdL6r+g0KfgVJSTZVfpVJx2bBMld+I7voJiCCoXnOTBMdVft4siYPtm0j17eueFsp
 JXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131330; x=1690723330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aj62CrXurYGS6qldiW3QI3IQ8iB1Fmrh8m1XANRmtvM=;
 b=mCssGx6r4mfClNgyyR3MZScxXWN3bKx4dOm421qsokIavWvGqvpm2OC0FSWc5amMk4
 aXSJK1yl8RrvP7YZwAvBpM5Q9bv2NdJTBYx3OEJ1o2Hg8+/NH0Zt1m6djc/e5z4OoxP9
 A5uy1Ck6sjjAYrVaLJZVxkOFvGTs7cVz9pbEl5N9Aecj1ZJAbYSucUG52FjTkgNkhb1o
 rySTlO31L1MKdQ3zbvOHn/YQHMcmuhGk3Vpr9GKMV+rZSfs917BwnDSVub9zY9Se6UaD
 W6gAPimloMCMSqRjcEk/rmiUbV+vXEBG2gI7X1t0leGafxnikREo8zfwNnJwaXtkFdyq
 qymA==
X-Gm-Message-State: ABy/qLZDdYO+CicAtwrCDKYIuWZxleTku6IgkFgByVpnnDW6NKbQafkd
 CnJY2/7QVJult0qYjzbnVsrwEWq52y80MAKctP2eiQ==
X-Google-Smtp-Source: APBJJlHDOxT+uU2kDPlJ7oQZMnMZ4Jph3AqPaXLwkrBG87Tb+VNB8IE6MGO4vMyqnewjCf0J2I3DZg==
X-Received: by 2002:a5d:698f:0:b0:314:114d:3300 with SMTP id
 g15-20020a5d698f000000b00314114d3300mr1964171wru.57.1688131330175; 
 Fri, 30 Jun 2023 06:22:10 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 12/24] linux-user: Rewrite target_mprotect
Date: Fri, 30 Jun 2023 15:21:47 +0200
Message-Id: <20230630132159.376995-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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

Use 'last' variables instead of 'end' variables.
When host page size > guest page size, detect when
adjacent host pages have the same protection and
merge that expanded host range into fewer syscalls.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 106 +++++++++++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 39 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 98be739b5b..c9bd72d3f9 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -119,8 +119,11 @@ static int target_to_host_prot(int prot)
 /* NOTE: all the constants are the HOST ones, but addresses are target. */
 int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 {
-    abi_ulong end, host_start, host_end, addr;
-    int prot1, ret, page_flags;
+    abi_ulong starts[3];
+    abi_ulong lens[3];
+    int prots[3];
+    abi_ulong host_start, host_last, last;
+    int prot1, ret, page_flags, nranges;
 
     trace_target_mprotect(start, len, target_prot);
 
@@ -131,63 +134,88 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
     if (!page_flags) {
         return -TARGET_EINVAL;
     }
-    len = TARGET_PAGE_ALIGN(len);
-    end = start + len;
-    if (!guest_range_valid_untagged(start, len)) {
-        return -TARGET_ENOMEM;
-    }
     if (len == 0) {
         return 0;
     }
+    len = TARGET_PAGE_ALIGN(len);
+    if (!guest_range_valid_untagged(start, len)) {
+        return -TARGET_ENOMEM;
+    }
+
+    last = start + len - 1;
+    host_start = start & qemu_host_page_mask;
+    host_last = HOST_PAGE_ALIGN(last) - 1;
+    nranges = 0;
 
     mmap_lock();
-    host_start = start & qemu_host_page_mask;
-    host_end = HOST_PAGE_ALIGN(end);
-    if (start > host_start) {
-        /* handle host page containing start */
+
+    if (host_last - host_start < qemu_host_page_size) {
+        /* Single host page contains all guest pages: sum the prot. */
         prot1 = target_prot;
-        for (addr = host_start; addr < start; addr += TARGET_PAGE_SIZE) {
-            prot1 |= page_get_flags(addr);
+        for (abi_ulong a = host_start; a < start; a += TARGET_PAGE_SIZE) {
+            prot1 |= page_get_flags(a);
         }
-        if (host_end == host_start + qemu_host_page_size) {
-            for (addr = end; addr < host_end; addr += TARGET_PAGE_SIZE) {
-                prot1 |= page_get_flags(addr);
+        for (abi_ulong a = last; a < host_last; a += TARGET_PAGE_SIZE) {
+            prot1 |= page_get_flags(a + 1);
+        }
+        starts[nranges] = host_start;
+        lens[nranges] = qemu_host_page_size;
+        prots[nranges] = prot1;
+        nranges++;
+    } else {
+        if (host_start < start) {
+            /* Host page contains more than one guest page: sum the prot. */
+            prot1 = target_prot;
+            for (abi_ulong a = host_start; a < start; a += TARGET_PAGE_SIZE) {
+                prot1 |= page_get_flags(a);
+            }
+            /* If the resulting sum differs, create a new range. */
+            if (prot1 != target_prot) {
+                starts[nranges] = host_start;
+                lens[nranges] = qemu_host_page_size;
+                prots[nranges] = prot1;
+                nranges++;
+                host_start += qemu_host_page_size;
             }
-            end = host_end;
         }
-        ret = mprotect(g2h_untagged(host_start), qemu_host_page_size,
-                       target_to_host_prot(prot1));
-        if (ret != 0) {
-            goto error;
+
+        if (last < host_last) {
+            /* Host page contains more than one guest page: sum the prot. */
+            prot1 = target_prot;
+            for (abi_ulong a = last; a < host_last; a += TARGET_PAGE_SIZE) {
+                prot1 |= page_get_flags(a + 1);
+            }
+            /* If the resulting sum differs, create a new range. */
+            if (prot1 != target_prot) {
+                host_last -= qemu_host_page_size;
+                starts[nranges] = host_last + 1;
+                lens[nranges] = qemu_host_page_size;
+                prots[nranges] = prot1;
+                nranges++;
+            }
         }
-        host_start += qemu_host_page_size;
-    }
-    if (end < host_end) {
-        prot1 = target_prot;
-        for (addr = end; addr < host_end; addr += TARGET_PAGE_SIZE) {
-            prot1 |= page_get_flags(addr);
+
+        /* Create a range for the middle, if any remains. */
+        if (host_start < host_last) {
+            starts[nranges] = host_start;
+            lens[nranges] = host_last - host_start + 1;
+            prots[nranges] = target_prot;
+            nranges++;
         }
-        ret = mprotect(g2h_untagged(host_end - qemu_host_page_size),
-                       qemu_host_page_size, target_to_host_prot(prot1));
-        if (ret != 0) {
-            goto error;
-        }
-        host_end -= qemu_host_page_size;
     }
 
-    /* handle the pages in the middle */
-    if (host_start < host_end) {
-        ret = mprotect(g2h_untagged(host_start), host_end - host_start,
-                       target_to_host_prot(target_prot));
+    for (int i = 0; i < nranges; ++i) {
+        ret = mprotect(g2h_untagged(starts[i]), lens[i],
+                       target_to_host_prot(prots[i]));
         if (ret != 0) {
             goto error;
         }
     }
 
-    page_set_flags(start, start + len - 1, page_flags);
+    page_set_flags(start, last, page_flags);
     ret = 0;
 
-error:
+ error:
     mmap_unlock();
     return ret;
 }
-- 
2.34.1


