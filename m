Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC68A790AF3
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 07:41:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcfpt-0006VY-TC; Sun, 03 Sep 2023 01:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcfpr-0006V7-At
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:39:47 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcfpo-0003mY-Do
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:39:47 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68a3cae6d94so393074b3a.0
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 22:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693719583; x=1694324383;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ht2oSsbGIVQE/VA9erprFmrrQZEv1oX6m1VovqFC2WY=;
 b=VzbQPHXmWWTCoHkW2tqcwKrJOFyl3ysGY5Qv/vvXADZowdFFOjq5CWSh5Cw0Ovhzgd
 VKwcJnJGxmEOGKd1PZqXESbtWZ00pqOYagV4jb+xlwUn5+AF3uHx+ihqYmYmDPms8Lnr
 wuk3xZiYkoQqspT4Fqp2fAGp9OyMuojv3JmfFF/RHGhT4Iuao7VEcGXrws7r4K9EzqBm
 6zmTsb/AQa9/LEQ0iI2g/iAlGSbzO9GmuT0+H+CD+RmyOuS2bmYVYAN6PeiJYrR/CI49
 hWQxgT40bCwSMCQXqh/WUEhSe9D/MzYWAxcP2Jht+MtZfcXsEgpOEVFFCgA0pY2f1X8l
 MDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693719583; x=1694324383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ht2oSsbGIVQE/VA9erprFmrrQZEv1oX6m1VovqFC2WY=;
 b=dERrjpbzm4g5b57tqJ5XWuDAMYc9H6wrH/3RYLUVlxU/uWPRVPTHdb6ocfyLzVBfGC
 elhDhJESXbBgFPWIx5QoK03SzqcTDkxVSZXWPl+k83aCi2ZpQPDjOV1NkA2v5MJ+2e7O
 FzqL/wkhfgqgCMBOejrAm6V/xYpvbzWm37IWxpjKUMsCot6mbJNFDOY07gKjPUv+Djmp
 qha3YvYQbarXNruQ/eGQ8+coeJcuIEvG0EgPWgTNXA0D7oWpDLYdfj8tWzemPsWZIzmL
 R3nHBiEYF6SUfLS3LajHh8VuhNJaEIxdYvCLi5Ddj1AKCbr10BRHkp3h4UXkN/vjeuyl
 KDvQ==
X-Gm-Message-State: AOJu0Yz5jphtNrKAovmjdVKR7hCnHQ/GfpXl7X6GJzVr60wROB2CS6UT
 rHItOf6yl08ECOdsy4bEtBqHtQ==
X-Google-Smtp-Source: AGHT+IE/CbX+j2rQgcKVG89N6PS+Z0aIWxkn83pCw/SeKZIACGcbFlIFztcJpqXrLKC2BrNSiPGDNg==
X-Received: by 2002:a05:6a00:1507:b0:68b:f524:b8fa with SMTP id
 q7-20020a056a00150700b0068bf524b8famr8957044pfu.28.1693719582829; 
 Sat, 02 Sep 2023 22:39:42 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 x52-20020a056a000bf400b0063b898b3502sm5290957pfu.153.2023.09.02.22.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 22:39:42 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 joel@jms.id.au, laurent@vivier.eu, deller@gmx.de,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2] linux-user: Undo incomplete mmap
Date: Sun,  3 Sep 2023 14:39:25 +0900
Message-ID: <20230903053927.38037-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

When the host page size is greater than the target page size and
MAP_FIXED or MAP_FIXED_NOREPLACE is requested, mmap will be done for
three parts: start, middle, and end. If a later part of mmap fail,
mmap done in the earlier parts must be reverted.

Fixes: 54936004fd ("mmap emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
V1 -> V2: Rebased.

 linux-user/mmap.c | 65 +++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 9aab48d4a3..72521f8d27 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -224,13 +224,15 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 
 /* map an incomplete host page */
 static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
-                      int prot, int flags, int fd, off_t offset)
+                      int prot, int flags, int fd, off_t offset, bool *mapped)
 {
     abi_ulong real_last;
     void *host_start;
     int prot_old, prot_new;
     int host_prot_old, host_prot_new;
 
+    *mapped = false;
+
     if (!(flags & MAP_ANONYMOUS)
         && (flags & MAP_TYPE) == MAP_SHARED
         && (prot & PROT_WRITE)) {
@@ -271,6 +273,7 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
             return false;
         }
         prot_old = prot;
+        *mapped = true;
     }
     prot_new = prot | prot_old;
 
@@ -448,7 +451,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                      int flags, int fd, off_t offset)
 {
-    abi_ulong ret, last, real_start, real_last, retaddr, host_len;
+    abi_ulong ret, last, real_start, retaddr, host_len;
     abi_ulong passthrough_start = -1, passthrough_last = 0;
     int page_flags;
     off_t host_offset;
@@ -577,12 +580,16 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         passthrough_start = start;
         passthrough_last = last;
     } else {
+        abi_ulong middle_start = HOST_PAGE_ALIGN(start);
+        abi_ulong middle_last = ((start + len) & qemu_host_page_mask) - 1;
+        abi_ulong mapped_len = 0;
+        bool mapped;
+
         if (start & ~TARGET_PAGE_MASK) {
             errno = EINVAL;
             goto fail;
         }
         last = start + len - 1;
-        real_last = HOST_PAGE_ALIGN(last) - 1;
 
         /*
          * Test if requested memory area fits target address space
@@ -649,35 +656,26 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         }
 
         /* handle the start of the mapping */
-        if (start > real_start) {
-            if (real_last == real_start + qemu_host_page_size - 1) {
+        if (start < middle_start) {
+            if (last < middle_start) {
                 /* one single host page */
                 if (!mmap_frag(real_start, start, last,
-                               target_prot, flags, fd, offset)) {
+                               target_prot, flags, fd, offset, &mapped)) {
                     goto fail;
                 }
                 goto the_end1;
             }
-            if (!mmap_frag(real_start, start,
-                           real_start + qemu_host_page_size - 1,
-                           target_prot, flags, fd, offset)) {
+            if (!mmap_frag(real_start, start, middle_start - 1,
+                           target_prot, flags, fd, offset, &mapped)) {
                 goto fail;
             }
-            real_start += qemu_host_page_size;
-        }
-        /* handle the end of the mapping */
-        if (last < real_last) {
-            abi_ulong real_page = real_last - qemu_host_page_size + 1;
-            if (!mmap_frag(real_page, real_page, last,
-                           target_prot, flags, fd,
-                           offset + real_page - start)) {
-                goto fail;
+            if (mapped) {
+                mapped_len = qemu_host_page_size;
             }
-            real_last -= qemu_host_page_size;
         }
 
         /* map the middle (easier) */
-        if (real_start < real_last) {
+        if (middle_start < middle_last) {
             void *p, *want_p;
             off_t offset1;
             size_t len1;
@@ -685,10 +683,10 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             if (flags & MAP_ANONYMOUS) {
                 offset1 = 0;
             } else {
-                offset1 = offset + real_start - start;
+                offset1 = offset + middle_start - start;
             }
-            len1 = real_last - real_start + 1;
-            want_p = g2h_untagged(real_start);
+            len1 = middle_last - middle_start + 1;
+            want_p = g2h_untagged(middle_start);
 
             p = mmap(want_p, len1, target_to_host_prot(target_prot),
                      flags, fd, offset1);
@@ -697,10 +695,27 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                     munmap(p, len1);
                     errno = EEXIST;
                 }
+                if (mapped_len) {
+                    munmap(g2h_untagged(middle_start - mapped_len), mapped_len);
+                }
+                goto fail;
+            }
+            mapped_len += len1;
+            passthrough_start = middle_start;
+            passthrough_last = middle_last;
+        }
+
+        /* handle the end of the mapping */
+        if (last > middle_last) {
+            abi_ulong real_page = middle_last + 1;
+            if (!mmap_frag(real_page, real_page, last,
+                           target_prot, flags, fd,
+                           offset + real_page - start, &mapped)) {
+                if (mapped_len) {
+                    munmap(g2h_untagged(real_page - mapped_len), mapped_len);
+                }
                 goto fail;
             }
-            passthrough_start = real_start;
-            passthrough_last = real_last;
         }
     }
  the_end1:
-- 
2.42.0


