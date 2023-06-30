Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FE9743CA2
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:23:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4q-0007kt-GA; Fri, 30 Jun 2023 09:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4n-0007jG-Ua
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:17 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4m-0003S2-5X
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:17 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-313f1085ac2so2045194f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131334; x=1690723334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rcUcYz/ENHU71nYFSKtvNzNb/+e+Z1fgOhw2rx254o=;
 b=M/V2YWHOcTzTeKzlm0waAJuXOJIJBUTVdf9Vu+Eszzes3ILpt/fKz6iQDUd4e+y4Zd
 Qy4Anq0XMDBsZQQwrq0GI+pq7awn/aC2iE/I7paf2ueOyVIK80bY2O6kzlY5aLJbXlcf
 dYvjwByWvVmJtxC7mv8+h/wrTs5vCjTCjCOwkZ5CneEZHCX9oP3RvdKuA58WtWZg+giV
 EYHG1g9u/6U9kcnZ6id4tbQPN5/lYMhRDVOvxFhNGtlIe2bMCJGh+YWikANduTTdcU0q
 FTBG7lPPaTPK2BXJu01bZ5fTwbidAHGDjfnauZuK+RiH5gbGG09QfcYCunQ5akX+PEFF
 2a2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131334; x=1690723334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0rcUcYz/ENHU71nYFSKtvNzNb/+e+Z1fgOhw2rx254o=;
 b=kVUrkrriy7pOWtvq1nk8Z320Nv0qv5mEQKnioL70cDoHBww7aRppJ77BFgSdBI5iiV
 8PXuq7xm7V8WNZN1CrMzOk/xshPIyJrZi/VxiYVjRW7oQyPcby+fZjkLaHJb1HapBAgQ
 40YmreG8+ZjDR5Qi1E4oS3jwg+WRYb50Po8gaGyFmqh3hCwKkZrqGfpcUOfBmmjxqQpd
 nPwLldz8L060O0KtuKfrPVWIQHqMy63b6f92C9gEZwn2tA9RB0N8Kr/1gWa7A0WOLml0
 wiul3NhzsXi/fZhe7Ra/JL9bqUDzvMzAHxf3qZ8Vet+3FJV/59NwV1qUEDLjIflvw3rL
 Vyag==
X-Gm-Message-State: ABy/qLbtrpkNn8Dpduz0Jp600PXKcvNevk1Y6oXp50KTyq/nZVmMj7Kp
 LlMH3UTIP2eRGslRxqzVNuiy82r8h3oXHhtv+0LQIQ==
X-Google-Smtp-Source: APBJJlFJqgpfdQzYStct+0jjQFrxGGZqMy7R7+cy+UuB7TGBsFbR/XCNeCYn8pvSJKz1v8nlOG1aWQ==
X-Received: by 2002:a5d:58d8:0:b0:313:ee2e:dae1 with SMTP id
 o24-20020a5d58d8000000b00313ee2edae1mr2311431wrf.18.1688131334616; 
 Fri, 30 Jun 2023 06:22:14 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 18/24] linux-user: Rewrite mmap_reserve
Date: Fri, 30 Jun 2023 15:21:53 +0200
Message-Id: <20230630132159.376995-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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

Use 'last' variables instead of 'end' variables; be careful
about avoiding overflow.  Assert that the mmap succeeded.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 68 +++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 67a117823f..6b030dac42 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -722,47 +722,63 @@ fail:
     return -1;
 }
 
-static void mmap_reserve(abi_ulong start, abi_ulong size)
+static void mmap_reserve(abi_ulong start, abi_ulong len)
 {
     abi_ulong real_start;
-    abi_ulong real_end;
-    abi_ulong addr;
-    abi_ulong end;
+    abi_ulong real_last;
+    abi_ulong real_len;
+    abi_ulong last;
+    abi_ulong a;
+    void *host_start, *ptr;
     int prot;
 
+    last = start + len - 1;
     real_start = start & qemu_host_page_mask;
-    real_end = HOST_PAGE_ALIGN(start + size);
-    end = start + size;
-    if (start > real_start) {
-        /* handle host page containing start */
+    real_last = HOST_PAGE_ALIGN(last) - 1;
+
+    /*
+     * If guest pages remain on the first or last host pages,
+     * adjust the deallocation to retain those guest pages.
+     * The single page special case is required for the last page,
+     * lest real_start overflow to zero.
+     */
+    if (real_last - real_start < qemu_host_page_size) {
         prot = 0;
-        for (addr = real_start; addr < start; addr += TARGET_PAGE_SIZE) {
-            prot |= page_get_flags(addr);
+        for (a = real_start; a < start; a += TARGET_PAGE_SIZE) {
+            prot |= page_get_flags(a);
         }
-        if (real_end == real_start + qemu_host_page_size) {
-            for (addr = end; addr < real_end; addr += TARGET_PAGE_SIZE) {
-                prot |= page_get_flags(addr);
-            }
-            end = real_end;
+        for (a = last; a < real_last; a += TARGET_PAGE_SIZE) {
+            prot |= page_get_flags(a + 1);
+        }
+        if (prot != 0) {
+            return;
+        }
+    } else {
+        for (prot = 0, a = real_start; a < start; a += TARGET_PAGE_SIZE) {
+            prot |= page_get_flags(a);
         }
         if (prot != 0) {
             real_start += qemu_host_page_size;
         }
-    }
-    if (end < real_end) {
-        prot = 0;
-        for (addr = end; addr < real_end; addr += TARGET_PAGE_SIZE) {
-            prot |= page_get_flags(addr);
+
+        for (prot = 0, a = last; a < real_last; a += TARGET_PAGE_SIZE) {
+            prot |= page_get_flags(a + 1);
         }
         if (prot != 0) {
-            real_end -= qemu_host_page_size;
+            real_last -= qemu_host_page_size;
+        }
+
+        if (real_last < real_start) {
+            return;
         }
     }
-    if (real_start != real_end) {
-        mmap(g2h_untagged(real_start), real_end - real_start, PROT_NONE,
-                 MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE,
-                 -1, 0);
-    }
+
+    real_len = real_last - real_start + 1;
+    host_start = g2h_untagged(real_start);
+
+    ptr = mmap(host_start, real_len, PROT_NONE,
+               MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
+    assert(ptr == host_start);
 }
 
 int target_munmap(abi_ulong start, abi_ulong len)
-- 
2.34.1


