Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B5A74B846
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:45:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGP-0004px-Md; Fri, 07 Jul 2023 16:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGM-0004o2-30
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:10 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGI-0004jY-Rf
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:09 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso25737055e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762465; x=1691354465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OCjpCmgTYSJQaYpH88C84bJaDepq/uowpCtDyP1aGHQ=;
 b=TvPj6GzAViK4mk0PAiMD6pbfRRPNSwGvG1kZOve0FdwtwxAGAGN54APvkTKTPOPAzG
 /JaHBKfy3X5yoviHstNQLCk3e/8RR4Ax6uAUIN05mmuad+gamq9amI7zx5tEIqV+tBSR
 kKnJZUNzkp5Nxkq7In4TYqqOP4DyzBo63iJTSYp11MDArDz4OpEHa+XJKa1rPwBxnaqC
 2tgSlmjFr5ZSZCEd/7WsG8YXZCirEVadMeOM6JtUOsY+JcMIW48iLk1dkc5RqP9Hj0/+
 xjkUDyvbUrHbjDJg1JomvCTIUj7yxVr8jXEMJ9UEG+apGbMItcvnGs8u3EMwmSU8pMLY
 t2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762465; x=1691354465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OCjpCmgTYSJQaYpH88C84bJaDepq/uowpCtDyP1aGHQ=;
 b=h0rpaQbS8rvMkL1W9y9AB4JTTE4thqjfIb9GUAnvXCtUJLMV7jntNg9joeHMweY2b6
 Ym8r/45819i4jMtn/R1hDnZ95D15V5AT4uEQJ7fvGmQz8uiz913GYAlSBNOS5xQKAt7n
 yZgEspvU66KpKxHDHa2vbW/X6viwLnB+sG50BtEi+snosZb9g0FRu2XminFzJbLvVGgw
 341hnlXXmPUYyyL+gPXiNt6Wc5JXqCPTZJjRJIKhANB/MuU1L+XAPOSng2xz4B8woDsc
 2TZcZluzzHLueLhXHlcWyruxd+sGEdXlck89Udw8i+FjFazxwF9FN4JE+e9ZKETW9nLe
 +Hgg==
X-Gm-Message-State: ABy/qLaDvUqXieBelzadGH69zg3V8LOywSHaCCF/UkZ4vmctaTx9lI0e
 RpPxCyify3mKV9atVydY+CXbN8kKeSd1WpEqRztOVQ==
X-Google-Smtp-Source: APBJJlG2s7/AkEMTNw5vE9avycmyaqfHTTgTtq1TU1OqkPftPA9CaEmhIZpByILlX5j+2vxkF+3B3A==
X-Received: by 2002:a7b:c7d1:0:b0:3fa:9590:a365 with SMTP id
 z17-20020a7bc7d1000000b003fa9590a365mr4463993wmk.17.1688762465546; 
 Fri, 07 Jul 2023 13:41:05 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:41:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	mjt@tls.msk.ru
Subject: [PATCH v2 12/24] linux-user: Rewrite target_mprotect
Date: Fri,  7 Jul 2023 21:40:42 +0100
Message-Id: <20230707204054.8792-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707204054.8792-1-richard.henderson@linaro.org>
References: <20230707204054.8792-1-richard.henderson@linaro.org>
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

Use 'last' variables instead of 'end' variables.
When host page size > guest page size, detect when
adjacent host pages have the same protection and
merge that expanded host range into fewer syscalls.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 106 +++++++++++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 39 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index bba01804b3..c03b0b4e43 100644
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


