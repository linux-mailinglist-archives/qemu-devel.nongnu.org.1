Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CC374C765
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:43:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEQ-0005sX-1p; Sun, 09 Jul 2023 14:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDx-0003X1-7X
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:33 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDu-0004G3-6Q
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:32 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3094910b150so4053614f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927608; x=1691519608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N9gguT3TBruptKaq1lWfbF+0g4+LhgVIPeZNOW/uhRg=;
 b=G9K+b0x9w8fTHKaRB/7mFxdF7zebDiwf/1ae7p57yxhIZMbZ7ru9zNwbLrwKvhysgI
 I5IFwLo/q39j/pwYp6TvxBedqiiGFDJuRDAgtFrTTrQzliTNOkeVlBMcqrfHdtpf2g72
 jApRWKYq48yHz8hWGIX6oFO4rwodJ7U91vR+1igc6Efe0hmBDnJAtDC+6/1NprcjU6lM
 rchprJEmasgDek4l7hkkuaq8/X9ZwR12PnmIL/CXdKKM5F4tW62MVKgqD0C3Eu/WjEeU
 dvelBYRFwzB8IIo03P2mlqHnud1vhwlyT1kHGG/3kxpdjncd0Ko2U9lxRIFxq29e9l9n
 CtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927608; x=1691519608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N9gguT3TBruptKaq1lWfbF+0g4+LhgVIPeZNOW/uhRg=;
 b=L9oIsWILnGE6o38WT8DIKPnqn7/2u8sY8Rai8pGPz00Gn+5iaFGBcLSepl30t8Kabo
 ENH3StzhalF79dDZz1BwuTD0S8LiKz/CHOq9FRWuDNmXwIqHWioH6vjpC9lzkaXEfv21
 SskyfoTmpy2sA696cmL4W+xP6n97vZOW1krQ63SVWkKL9Nv5ws7vqhcaz2UP3AfaqV6e
 9EoLppbnlbP0E+gajjT8+aHb9EPidHdCCYavIordyJs3cC79/1Cy8ZUVGuH77dQaUO8t
 l9nhbJ/81fbgsSMr+T4f9rZ8uqFrbIIiyFlO8J+4MqP8epSSw7ufQx+gd+wSR4rW6Tio
 +IqA==
X-Gm-Message-State: ABy/qLa+QnQllJ8U7aCojP6uWASJPRmYhapkqgCTM5ClxlX/uQkRcdTv
 oTOA5YVm0ZeawrHD+BMyPjFdVS9HSzMMGSIKMvXdJA==
X-Google-Smtp-Source: APBJJlHKhVSXQEioYRq6hnPmoCSX5MEeD7q12HzZMkd31HgQJ5h0PqgLtWXab6S/aUgO5o6iATns9Q==
X-Received: by 2002:adf:e286:0:b0:313:dfb8:b4d0 with SMTP id
 v6-20020adfe286000000b00313dfb8b4d0mr10365023wri.66.1688927608768; 
 Sun, 09 Jul 2023 11:33:28 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 31/45] linux-user: Rewrite target_mprotect
Date: Sun,  9 Jul 2023 19:29:13 +0100
Message-Id: <20230709182934.309468-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
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

Use 'last' variables instead of 'end' variables.
When host page size > guest page size, detect when
adjacent host pages have the same protection and
merge that expanded host range into fewer syscalls.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230707204054.8792-15-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 106 +++++++++++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 39 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index b2c2d85857..d02d74d279 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -120,8 +120,11 @@ static int target_to_host_prot(int prot)
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
 
@@ -132,63 +135,88 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
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


