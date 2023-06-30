Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C807F743CAA
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:23:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4o-0007j6-3a; Fri, 30 Jun 2023 09:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4k-0007gU-Jp
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:14 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4i-0003Qo-Oi
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:14 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbab0d0b88so16304665e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131331; x=1690723331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ATo4xPCpqlJo0OX4/YmZKCOaCJgLjpigwZg6oDzTrO0=;
 b=ncxr59OwCTfb75YLVAliXNB93/aaCR+D5anQBig7mwD6jPea6bolwmBK+l1ai8EE/E
 mIZwGtI4yjQvo50itb3mUnv/s2fVilvYLBm2hlaqJSZZ5I6AOwHgmbueUIt0h9k3ZtzK
 LiqNaUE6gWz7RWDFlyLRy5dMVKUdPsVIpgHYFXbNbnymxVh7pVHgYT0TtUJ8N+lPvW4e
 s3wuEgst8UMDJyRy9p/kQt0E6aP4y17PCcC0eQ+6eT0INH2T2p75uCtdJYFRrSBDEswy
 RKP+9G3zq7GRA5rNOge5YJnjpWxZmU703jnAuWOsjhwuRHOn9iTKVfMu+0SMKBO6BcFb
 GWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131331; x=1690723331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ATo4xPCpqlJo0OX4/YmZKCOaCJgLjpigwZg6oDzTrO0=;
 b=F/ktImeNVJjRrEYUo3YXmba4CMamAFtC9KH24eWFb0hIMdVp+/34Xudk7m4qAR8Gnk
 c+pxg354mQTiVNl1ureJxm6qXBHLPjUB1tTd6bMzoL9WaRoYn58zGd5w0JtniQpgU0hU
 2oXH+8JV9SG/Ol6Sex8x8jl4pbW7WDGPlnjjHK3oYTIOWX1EW+5Z2HL3sCO8WGb0qf5S
 X94S89CQ9BO/1RLLZDqPZ/fUbADoNaOlso3KpN8lemi9+ND/N6JKWxPoL+pMDIQy64W2
 EsfWZuXPvgrtE11OLV5wO8tYmrnIhAyig798hYNprRbnhjXNcv+DmlyeIteqVx+xddFH
 aupw==
X-Gm-Message-State: ABy/qLbuXaXkbtubVydJ/6Sd9gjRWq1s8EiKOnLWO7APxRVYlfjFj6a7
 vtGMPPpW2VCzXwiWH9lvOuIzXtgdox6YWsXahV2zJg==
X-Google-Smtp-Source: APBJJlF+//sk6+IkNUm0qHHsYMX70sw5av+XvNevJQam9AKRv12sZ6AOFu9tN5qDoayBs+HQFeBKPg==
X-Received: by 2002:a5d:61d1:0:b0:313:f3a2:e5d9 with SMTP id
 q17-20020a5d61d1000000b00313f3a2e5d9mr2620690wrv.3.1688131330987; 
 Fri, 30 Jun 2023 06:22:10 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 13/24] linux-user: Rewrite mmap_frag
Date: Fri, 30 Jun 2023 15:21:48 +0200
Message-Id: <20230630132159.376995-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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
Always zero MAP_ANONYMOUS fragments, which we previously
failed to do if they were not writable; early exit in case
we allocate a new page from the kernel, known zeros.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 123 +++++++++++++++++++++++-----------------------
 1 file changed, 62 insertions(+), 61 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index c9bd72d3f9..e332555dd2 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -221,73 +221,76 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 }
 
 /* map an incomplete host page */
-static int mmap_frag(abi_ulong real_start,
-                     abi_ulong start, abi_ulong end,
-                     int prot, int flags, int fd, off_t offset)
+static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
+                      int prot, int flags, int fd, off_t offset)
 {
-    abi_ulong real_end, addr;
+    abi_ulong real_last;
     void *host_start;
-    int prot1, prot_new;
+    int prot_old, prot_new;
+    int host_prot_old, host_prot_new;
 
-    real_end = real_start + qemu_host_page_size;
-    host_start = g2h_untagged(real_start);
-
-    /* get the protection of the target pages outside the mapping */
-    prot1 = 0;
-    for (addr = real_start; addr < real_end; addr++) {
-        if (addr < start || addr >= end) {
-            prot1 |= page_get_flags(addr);
-        }
+    if (!(flags & MAP_ANONYMOUS)
+        && (flags & MAP_TYPE) == MAP_SHARED
+        && (prot & PROT_WRITE)) {
+        /*
+         * msync() won't work with the partial page, so we return an
+         * error if write is possible while it is a shared mapping.
+         */
+        errno = EINVAL;
+        return false;
     }
 
-    if (prot1 == 0) {
-        /* no page was there, so we allocate one */
+    real_last = real_start + qemu_host_page_size - 1;
+    host_start = g2h_untagged(real_start);
+
+    /* Get the protection of the target pages outside the mapping. */
+    prot_old = 0;
+    for (abi_ulong a = real_start; a < start; a += TARGET_PAGE_SIZE) {
+        prot_old |= page_get_flags(a);
+    }
+    for (abi_ulong a = real_last; a > last; a -= TARGET_PAGE_SIZE) {
+        prot_old |= page_get_flags(a);
+    }
+
+    if (prot_old == 0) {
+        /*
+         * Since !(prot_old & PAGE_VALID), there were no guest pages
+         * outside of the fragment we need to map.  Allocate a new host
+         * page to cover, discarding whatever else may have been present.
+         */
         void *p = mmap(host_start, qemu_host_page_size,
                        target_to_host_prot(prot),
                        flags | MAP_ANONYMOUS, -1, 0);
         if (p == MAP_FAILED) {
-            return -1;
+            return false;
         }
-        prot1 = prot;
+        prot_old = prot;
     }
-    prot1 &= PAGE_BITS;
+    prot_new = prot | prot_old;
 
-    prot_new = prot | prot1;
-    if (!(flags & MAP_ANONYMOUS)) {
-        /*
-         * msync() won't work here, so we return an error if write is
-         * possible while it is a shared mapping.
-         */
-        if ((flags & MAP_TYPE) == MAP_SHARED && (prot & PROT_WRITE)) {
-            return -1;
-        }
+    host_prot_old = target_to_host_prot(prot_old);
+    host_prot_new = target_to_host_prot(prot_new);
 
-        /* adjust protection to be able to read */
-        if (!(prot1 & PROT_WRITE)) {
-            mprotect(host_start, qemu_host_page_size,
-                     target_to_host_prot(prot1) | PROT_WRITE);
-        }
+    /* Adjust protection to be able to write. */
+    if (!(host_prot_old & PROT_WRITE)) {
+        host_prot_old |= PROT_WRITE;
+        mprotect(host_start, qemu_host_page_size, host_prot_old);
+    }
 
-        /* read the corresponding file data */
-        if (pread(fd, g2h_untagged(start), end - start, offset) == -1) {
-            return -1;
-        }
-
-        /* put final protection */
-        if (prot_new != (prot1 | PROT_WRITE)) {
-            mprotect(host_start, qemu_host_page_size,
-                     target_to_host_prot(prot_new));
-        }
+    /* Read or zero the new guest pages. */
+    if (flags & MAP_ANONYMOUS) {
+        memset(g2h_untagged(start), 0, last - start + 1);
     } else {
-        if (prot_new != prot1) {
-            mprotect(host_start, qemu_host_page_size,
-                     target_to_host_prot(prot_new));
-        }
-        if (prot_new & PROT_WRITE) {
-            memset(g2h_untagged(start), 0, end - start);
+        if (pread(fd, g2h_untagged(start), last - start + 1, offset) == -1) {
+            return false;
         }
     }
-    return 0;
+
+    /* Put final protection */
+    if (host_prot_new != host_prot_old) {
+        mprotect(host_start, qemu_host_page_size, host_prot_new);
+    }
+    return true;
 }
 
 #if HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
@@ -675,27 +678,25 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         if (start > real_start) {
             if (real_end == real_start + qemu_host_page_size) {
                 /* one single host page */
-                ret = mmap_frag(real_start, start, end,
-                                target_prot, flags, fd, offset);
-                if (ret == -1) {
+                if (!mmap_frag(real_start, start, end - 1,
+                               target_prot, flags, fd, offset)) {
                     goto fail;
                 }
                 goto the_end1;
             }
-            ret = mmap_frag(real_start, start, real_start + qemu_host_page_size,
-                            target_prot, flags, fd, offset);
-            if (ret == -1) {
+            if (!mmap_frag(real_start, start,
+                           real_start + qemu_host_page_size - 1,
+                           target_prot, flags, fd, offset)) {
                 goto fail;
             }
             real_start += qemu_host_page_size;
         }
         /* handle the end of the mapping */
         if (end < real_end) {
-            ret = mmap_frag(real_end - qemu_host_page_size,
-                            real_end - qemu_host_page_size, end,
-                            target_prot, flags, fd,
-                            offset + real_end - qemu_host_page_size - start);
-            if (ret == -1) {
+            if (!mmap_frag(real_end - qemu_host_page_size,
+                           real_end - qemu_host_page_size, end - 1,
+                           target_prot, flags, fd,
+                           offset + real_end - qemu_host_page_size - start)) {
                 goto fail;
             }
             real_end -= qemu_host_page_size;
-- 
2.34.1


