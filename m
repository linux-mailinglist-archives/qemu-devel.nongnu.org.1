Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF02D743CB5
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:26:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4n-0007i3-5Y; Fri, 30 Jun 2023 09:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4i-0007cz-9a
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:12 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4g-0003Ps-4j
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:12 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3141c3a7547so1703238f8f.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131328; x=1690723328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xoWOZKa64xsR87TgP0bu6Uv4jgrNi1eFmvRemUFvDuo=;
 b=Pr1n4G3SuT6ZTTtzRo7aESDNsoCm85NCENc5sfEA1+zKLFckDJ0ioomsNde129MlBP
 PQHKgqizLt78oSw7P9RRpXimxIB3gTyOSnwrqAoXYdZXwFBo0ygkE+CYSqcNR/DBcfwz
 887Y94Mh9l3y/F4ljRsZYzDdd7dIlmg0Hn2sJTqRW+68jd1lWnTRG+Bq26Rk+681B5Wc
 vuU1HGwj50xTd86Ttfm3AXgF7xnBpQtagr9B7E3P0R8p8W0IgJHLaqkGt35iHRnDMtoW
 j1mkTYx5jwTDQE5EUvC88Gi4J2Lqu8JoAb9F9EC4g0GRvtP7OfQnNkPdbv4irlAuWK4/
 ROOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131328; x=1690723328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xoWOZKa64xsR87TgP0bu6Uv4jgrNi1eFmvRemUFvDuo=;
 b=E3f/hJLjkNm5KcITwUlLj4z/VkeD5e+kacSUvnz1FbWkMxFodQS5dR0N4XhX4du2/r
 RjiFY82+zBBhn2l0B7E6V0lGQp5X9wsuD5IV2UmWvouuU746kCgrmA5Atsek+9cLwkRh
 9C00JOKgoZ9VOaLoCkcOrImXCyxM7NSSo75xXzZaCwGI5oa5A5MOAnXjL1O44FlcAbMw
 shyS/lIZvd4CR3C2yURImJwsz8NpJtzz/NhwhTjro6Xr+iUA87nRvVdF1bl0MqAGpOwM
 aNSkm0+SuOrGvrMGwyZSWT8X0OZyO0Zga8wR/i4Nqew/0OzSbhlaT82uUUGQrzv5Uldc
 NHqA==
X-Gm-Message-State: ABy/qLbNzx3J0H4LVW7LiCbjoCsaZbQJ631Ura5Z0d4nd8cF1WnbH/P3
 +YMak0fofOm16fVP6co/gFUBoIwC6egAsLSSdLIG2g==
X-Google-Smtp-Source: APBJJlH42fWTRNXLJOwUno3Wl5yzKVkdeIZpF0bsduR9ZEqmBM08cxtuGkE9g5PGhDwr3CQtqnLEJw==
X-Received: by 2002:a5d:4651:0:b0:313:e9f6:3378 with SMTP id
 j17-20020a5d4651000000b00313e9f63378mr2202940wrs.4.1688131328450; 
 Fri, 30 Jun 2023 06:22:08 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 10/24] linux-user: Split out target_to_host_prot
Date: Fri, 30 Jun 2023 15:21:45 +0200
Message-Id: <20230630132159.376995-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
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

Split out from validate_prot_to_pageflags, as there is not
one single host_prot for the entire range.  We need to adjust
prot for every host page that overlaps multiple guest pages.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 77 +++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 41c2f09fd5..26d409cb60 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -68,24 +68,11 @@ void mmap_fork_end(int child)
  * Return 0 if the target prot bitmask is invalid, otherwise
  * the internal qemu page_flags (which will include PAGE_VALID).
  */
-static int validate_prot_to_pageflags(int *host_prot, int prot)
+static int validate_prot_to_pageflags(int prot)
 {
     int valid = PROT_READ | PROT_WRITE | PROT_EXEC | TARGET_PROT_SEM;
     int page_flags = (prot & PAGE_BITS) | PAGE_VALID;
 
-    /*
-     * For the host, we need not pass anything except read/write/exec.
-     * While PROT_SEM is allowed by all hosts, it is also ignored, so
-     * don't bother transforming guest bit to host bit.  Any other
-     * target-specific prot bits will not be understood by the host
-     * and will need to be encoded into page_flags for qemu emulation.
-     *
-     * Pages that are executable by the guest will never be executed
-     * by the host, but the host will need to be able to read them.
-     */
-    *host_prot = (prot & (PROT_READ | PROT_WRITE))
-               | (prot & PROT_EXEC ? PROT_READ : 0);
-
 #ifdef TARGET_AARCH64
     {
         ARMCPU *cpu = ARM_CPU(thread_cpu);
@@ -113,18 +100,34 @@ static int validate_prot_to_pageflags(int *host_prot, int prot)
     return prot & ~valid ? 0 : page_flags;
 }
 
+/*
+ * For the host, we need not pass anything except read/write/exec.
+ * While PROT_SEM is allowed by all hosts, it is also ignored, so
+ * don't bother transforming guest bit to host bit.  Any other
+ * target-specific prot bits will not be understood by the host
+ * and will need to be encoded into page_flags for qemu emulation.
+ *
+ * Pages that are executable by the guest will never be executed
+ * by the host, but the host will need to be able to read them.
+ */
+static int target_to_host_prot(int prot)
+{
+    return (prot & (PROT_READ | PROT_WRITE)) |
+           (prot & PROT_EXEC ? PROT_READ : 0);
+}
+
 /* NOTE: all the constants are the HOST ones, but addresses are target. */
 int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 {
     abi_ulong end, host_start, host_end, addr;
-    int prot1, ret, page_flags, host_prot;
+    int prot1, ret, page_flags;
 
     trace_target_mprotect(start, len, target_prot);
 
     if ((start & ~TARGET_PAGE_MASK) != 0) {
         return -TARGET_EINVAL;
     }
-    page_flags = validate_prot_to_pageflags(&host_prot, target_prot);
+    page_flags = validate_prot_to_pageflags(target_prot);
     if (!page_flags) {
         return -TARGET_EINVAL;
     }
@@ -142,7 +145,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
     host_end = HOST_PAGE_ALIGN(end);
     if (start > host_start) {
         /* handle host page containing start */
-        prot1 = host_prot;
+        prot1 = target_prot;
         for (addr = host_start; addr < start; addr += TARGET_PAGE_SIZE) {
             prot1 |= page_get_flags(addr);
         }
@@ -153,19 +156,19 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
             end = host_end;
         }
         ret = mprotect(g2h_untagged(host_start), qemu_host_page_size,
-                       prot1 & PAGE_BITS);
+                       target_to_host_prot(prot1));
         if (ret != 0) {
             goto error;
         }
         host_start += qemu_host_page_size;
     }
     if (end < host_end) {
-        prot1 = host_prot;
+        prot1 = target_prot;
         for (addr = end; addr < host_end; addr += TARGET_PAGE_SIZE) {
             prot1 |= page_get_flags(addr);
         }
         ret = mprotect(g2h_untagged(host_end - qemu_host_page_size),
-                       qemu_host_page_size, prot1 & PAGE_BITS);
+                       qemu_host_page_size, target_to_host_prot(prot1));
         if (ret != 0) {
             goto error;
         }
@@ -174,8 +177,8 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 
     /* handle the pages in the middle */
     if (host_start < host_end) {
-        ret = mprotect(g2h_untagged(host_start),
-                       host_end - host_start, host_prot);
+        ret = mprotect(g2h_untagged(host_start), host_end - host_start,
+                       target_to_host_prot(target_prot));
         if (ret != 0) {
             goto error;
         }
@@ -211,7 +214,8 @@ static int mmap_frag(abi_ulong real_start,
 
     if (prot1 == 0) {
         /* no page was there, so we allocate one */
-        void *p = mmap(host_start, qemu_host_page_size, prot,
+        void *p = mmap(host_start, qemu_host_page_size,
+                       target_to_host_prot(prot),
                        flags | MAP_ANONYMOUS, -1, 0);
         if (p == MAP_FAILED) {
             return -1;
@@ -232,7 +236,8 @@ static int mmap_frag(abi_ulong real_start,
 
         /* adjust protection to be able to read */
         if (!(prot1 & PROT_WRITE)) {
-            mprotect(host_start, qemu_host_page_size, prot1 | PROT_WRITE);
+            mprotect(host_start, qemu_host_page_size,
+                     target_to_host_prot(prot1) | PROT_WRITE);
         }
 
         /* read the corresponding file data */
@@ -242,11 +247,13 @@ static int mmap_frag(abi_ulong real_start,
 
         /* put final protection */
         if (prot_new != (prot1 | PROT_WRITE)) {
-            mprotect(host_start, qemu_host_page_size, prot_new);
+            mprotect(host_start, qemu_host_page_size,
+                     target_to_host_prot(prot_new));
         }
     } else {
         if (prot_new != prot1) {
-            mprotect(host_start, qemu_host_page_size, prot_new);
+            mprotect(host_start, qemu_host_page_size,
+                     target_to_host_prot(prot_new));
         }
         if (prot_new & PROT_WRITE) {
             memset(g2h_untagged(start), 0, end - start);
@@ -453,7 +460,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
 {
     abi_ulong ret, end, real_start, real_end, retaddr, host_offset, host_len,
               passthrough_start = -1, passthrough_end = -1;
-    int page_flags, host_prot;
+    int page_flags;
 
     mmap_lock();
     trace_target_mmap(start, len, target_prot, flags, fd, offset);
@@ -463,7 +470,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         goto fail;
     }
 
-    page_flags = validate_prot_to_pageflags(&host_prot, target_prot);
+    page_flags = validate_prot_to_pageflags(target_prot);
     if (!page_flags) {
         errno = EINVAL;
         goto fail;
@@ -546,10 +553,12 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
 
     if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         unsigned long host_start;
+        int host_prot;
         void *p;
 
         host_len = len + offset - host_offset;
         host_len = HOST_PAGE_ALIGN(host_len);
+        host_prot = target_to_host_prot(target_prot);
 
         /*
          * Note: we prefer to control the mapping address. It is
@@ -606,6 +615,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
          */
         if (!(flags & MAP_ANONYMOUS) &&
             (offset & ~qemu_host_page_mask) != (start & ~qemu_host_page_mask)) {
+            int host_prot = target_to_host_prot(target_prot);
+
             /*
              * msync() won't work here, so we return an error if write is
              * possible while it is a shared mapping
@@ -614,7 +625,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                 errno = EINVAL;
                 goto fail;
             }
-            retaddr = target_mmap(start, len, target_prot | PROT_WRITE,
+            retaddr = target_mmap(start, len, host_prot | PROT_WRITE,
                                   (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))
                                   | MAP_PRIVATE | MAP_ANONYMOUS,
                                   -1, 0);
@@ -636,14 +647,14 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             if (real_end == real_start + qemu_host_page_size) {
                 /* one single host page */
                 ret = mmap_frag(real_start, start, end,
-                                host_prot, flags, fd, offset);
+                                target_prot, flags, fd, offset);
                 if (ret == -1) {
                     goto fail;
                 }
                 goto the_end1;
             }
             ret = mmap_frag(real_start, start, real_start + qemu_host_page_size,
-                            host_prot, flags, fd, offset);
+                            target_prot, flags, fd, offset);
             if (ret == -1) {
                 goto fail;
             }
@@ -653,7 +664,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         if (end < real_end) {
             ret = mmap_frag(real_end - qemu_host_page_size,
                             real_end - qemu_host_page_size, end,
-                            host_prot, flags, fd,
+                            target_prot, flags, fd,
                             offset + real_end - qemu_host_page_size - start);
             if (ret == -1) {
                 goto fail;
@@ -671,7 +682,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                 offset1 = offset + real_start - start;
             }
             p = mmap(g2h_untagged(real_start), real_end - real_start,
-                     host_prot, flags, fd, offset1);
+                     target_to_host_prot(target_prot), flags, fd, offset1);
             if (p == MAP_FAILED) {
                 goto fail;
             }
-- 
2.34.1


