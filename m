Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F99678F70C
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:25:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtp3-0006Un-B5; Thu, 31 Aug 2023 22:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtp1-0006UM-Cj
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:43 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtoy-0001Oy-LH
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:43 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3a88ef953adso981664b6e.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535019; x=1694139819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r4oK6DpGgmRt3Rqz8pdIMkWopOhHonW2cpDcnZxadQo=;
 b=xZrNlPBUZZb36OGPapt90/XvRtvUOeD6kuoR0sOZ+ZDuOUCzc7yLDi3YihXDEBrD0p
 aSOaP9TloRx+AhciqsZ7am/DG41srN7D1Wd4OuPBAq1nCRPIUJurKd1UWi0BNUHvqntO
 bSj0CMNdRESbvM85ASEWUYvV/S7oSwlHWwdZv2uMr24Xtu/niyTFnvrb7qCh3mxYnvVL
 8S9d5SjlOb/DsCdEM5ymFfH+i7WWEcKIf3lNycAobrLpSsvSaJ8SYN1RHMyKZLovIhRI
 uoTqMUp0Gv2ODh3Xxfm5JdMWDFIJCVcUcjfF885lIH2Im87m9KmqMenTLI3FN1TtjiXN
 idpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535019; x=1694139819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r4oK6DpGgmRt3Rqz8pdIMkWopOhHonW2cpDcnZxadQo=;
 b=Bt3Fis2WyKZgl6A2Ce+fulEJk9VzDsOR7TV0K+wZd4d4LnrvrYEDHJ1AWAAx2O0u6d
 KgzLsuqKgwhmDfiFqBzxH7TwRMUjht6dlTqMBR/j6njOOMhoFrH5+FGKo2UEca1qsOXo
 r+JwmuVRKExtAGogm5vQMYfUruT21MjWLPqloevo3wc0asW2F3AMzZ+nPhv4DsuiUdoi
 0Y4TB4O9NEdnoBqwHTWjgFPCr9xtrAacjusfA+MROupfCm/G0jgYfd9u33UoUnCSyMKh
 abOmD0e1/55ZMWqpLWKR8qYlgDwMF+/AmJrs149yNTIoy0dfyC2qi6cqh3z5KfbxuMlD
 EgvA==
X-Gm-Message-State: AOJu0YxmrV8sec0YTIoN1gO/JPzTRkxEneEHSRiAtIF6Poi7ytx7iAG7
 AluxO5WddxEsxmboLVbAhok4wsJl/hOTutw6PPk=
X-Google-Smtp-Source: AGHT+IGDBhDzYA97npnCzQ2UlvnjxXlVOimX+iObGDaqRKWLcrCi5jXVx4Y3pAxxe8f6cbBIpfTc9w==
X-Received: by 2002:a05:6808:23d4:b0:3a8:5997:21e3 with SMTP id
 bq20-20020a05680823d400b003a8599721e3mr1591024oib.33.1693535019304; 
 Thu, 31 Aug 2023 19:23:39 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 08/33] linux-user: Remove qemu_host_page_{size,
 mask} from mmap.c
Date: Thu, 31 Aug 2023 19:23:06 -0700
Message-Id: <20230901022331.115247-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use qemu_real_host_page_size instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 66 +++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 9aab48d4a3..fc23192a32 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -121,6 +121,7 @@ static int target_to_host_prot(int prot)
 /* NOTE: all the constants are the HOST ones, but addresses are target. */
 int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 {
+    int host_page_size = qemu_real_host_page_size();
     abi_ulong starts[3];
     abi_ulong lens[3];
     int prots[3];
@@ -145,13 +146,13 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
     }
 
     last = start + len - 1;
-    host_start = start & qemu_host_page_mask;
+    host_start = start & -host_page_size;
     host_last = HOST_PAGE_ALIGN(last) - 1;
     nranges = 0;
 
     mmap_lock();
 
-    if (host_last - host_start < qemu_host_page_size) {
+    if (host_last - host_start < host_page_size) {
         /* Single host page contains all guest pages: sum the prot. */
         prot1 = target_prot;
         for (abi_ulong a = host_start; a < start; a += TARGET_PAGE_SIZE) {
@@ -161,7 +162,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
             prot1 |= page_get_flags(a + 1);
         }
         starts[nranges] = host_start;
-        lens[nranges] = qemu_host_page_size;
+        lens[nranges] = host_page_size;
         prots[nranges] = prot1;
         nranges++;
     } else {
@@ -174,10 +175,10 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
             /* If the resulting sum differs, create a new range. */
             if (prot1 != target_prot) {
                 starts[nranges] = host_start;
-                lens[nranges] = qemu_host_page_size;
+                lens[nranges] = host_page_size;
                 prots[nranges] = prot1;
                 nranges++;
-                host_start += qemu_host_page_size;
+                host_start += host_page_size;
             }
         }
 
@@ -189,9 +190,9 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
             }
             /* If the resulting sum differs, create a new range. */
             if (prot1 != target_prot) {
-                host_last -= qemu_host_page_size;
+                host_last -= host_page_size;
                 starts[nranges] = host_last + 1;
-                lens[nranges] = qemu_host_page_size;
+                lens[nranges] = host_page_size;
                 prots[nranges] = prot1;
                 nranges++;
             }
@@ -226,6 +227,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
                       int prot, int flags, int fd, off_t offset)
 {
+    int host_page_size = qemu_real_host_page_size();
     abi_ulong real_last;
     void *host_start;
     int prot_old, prot_new;
@@ -242,7 +244,7 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
         return false;
     }
 
-    real_last = real_start + qemu_host_page_size - 1;
+    real_last = real_start + host_page_size - 1;
     host_start = g2h_untagged(real_start);
 
     /* Get the protection of the target pages outside the mapping. */
@@ -260,12 +262,12 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
          * outside of the fragment we need to map.  Allocate a new host
          * page to cover, discarding whatever else may have been present.
          */
-        void *p = mmap(host_start, qemu_host_page_size,
+        void *p = mmap(host_start, host_page_size,
                        target_to_host_prot(prot),
                        flags | MAP_ANONYMOUS, -1, 0);
         if (p != host_start) {
             if (p != MAP_FAILED) {
-                munmap(p, qemu_host_page_size);
+                munmap(p, host_page_size);
                 errno = EEXIST;
             }
             return false;
@@ -280,7 +282,7 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
     /* Adjust protection to be able to write. */
     if (!(host_prot_old & PROT_WRITE)) {
         host_prot_old |= PROT_WRITE;
-        mprotect(host_start, qemu_host_page_size, host_prot_old);
+        mprotect(host_start, host_page_size, host_prot_old);
     }
 
     /* Read or zero the new guest pages. */
@@ -294,7 +296,7 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
 
     /* Put final protection */
     if (host_prot_new != host_prot_old) {
-        mprotect(host_start, qemu_host_page_size, host_prot_new);
+        mprotect(host_start, host_page_size, host_prot_new);
     }
     return true;
 }
@@ -329,17 +331,18 @@ static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
  */
 abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 {
+    int host_page_size = qemu_real_host_page_size();
     void *ptr, *prev;
     abi_ulong addr;
     int wrapped, repeat;
 
-    align = MAX(align, qemu_host_page_size);
+    align = MAX(align, host_page_size);
 
     /* If 'start' == 0, then a default start address is used. */
     if (start == 0) {
         start = mmap_next_start;
     } else {
-        start &= qemu_host_page_mask;
+        start &= -host_page_size;
     }
     start = ROUND_UP(start, align);
 
@@ -448,6 +451,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                      int flags, int fd, off_t offset)
 {
+    int host_page_size = qemu_real_host_page_size();
     abi_ulong ret, last, real_start, real_last, retaddr, host_len;
     abi_ulong passthrough_start = -1, passthrough_last = 0;
     int page_flags;
@@ -493,8 +497,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         }
     }
 
-    real_start = start & qemu_host_page_mask;
-    host_offset = offset & qemu_host_page_mask;
+    real_start = start & -host_page_size;
+    host_offset = offset & -host_page_size;
 
     /*
      * If the user is asking for the kernel to find a location, do that
@@ -523,8 +527,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
      * may need to truncate file maps at EOF and add extra anonymous pages
      * up to the targets page boundary.
      */
-    if ((qemu_real_host_page_size() < qemu_host_page_size) &&
-        !(flags & MAP_ANONYMOUS)) {
+    if (host_page_size < TARGET_PAGE_SIZE && !(flags & MAP_ANONYMOUS)) {
         struct stat sb;
 
         if (fstat(fd, &sb) == -1) {
@@ -551,11 +554,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         host_len = HOST_PAGE_ALIGN(host_len);
         host_prot = target_to_host_prot(target_prot);
 
-        /*
-         * Note: we prefer to control the mapping address. It is
-         * especially important if qemu_host_page_size >
-         * qemu_real_host_page_size.
-         */
+        /* Note: we prefer to control the mapping address. */
         p = mmap(g2h_untagged(start), host_len, host_prot,
                  flags | MAP_FIXED | MAP_ANONYMOUS, -1, 0);
         if (p == MAP_FAILED) {
@@ -621,7 +620,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
          * aligned, so we read it
          */
         if (!(flags & MAP_ANONYMOUS) &&
-            (offset & ~qemu_host_page_mask) != (start & ~qemu_host_page_mask)) {
+            (offset & (host_page_size - 1)) != (start & (host_page_size - 1))) {
             /*
              * msync() won't work here, so we return an error if write is
              * possible while it is a shared mapping
@@ -650,7 +649,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
 
         /* handle the start of the mapping */
         if (start > real_start) {
-            if (real_last == real_start + qemu_host_page_size - 1) {
+            if (real_last == real_start + host_page_size - 1) {
                 /* one single host page */
                 if (!mmap_frag(real_start, start, last,
                                target_prot, flags, fd, offset)) {
@@ -659,21 +658,21 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                 goto the_end1;
             }
             if (!mmap_frag(real_start, start,
-                           real_start + qemu_host_page_size - 1,
+                           real_start + host_page_size - 1,
                            target_prot, flags, fd, offset)) {
                 goto fail;
             }
-            real_start += qemu_host_page_size;
+            real_start += host_page_size;
         }
         /* handle the end of the mapping */
         if (last < real_last) {
-            abi_ulong real_page = real_last - qemu_host_page_size + 1;
+            abi_ulong real_page = real_last - host_page_size + 1;
             if (!mmap_frag(real_page, real_page, last,
                            target_prot, flags, fd,
                            offset + real_page - start)) {
                 goto fail;
             }
-            real_last -= qemu_host_page_size;
+            real_last -= host_page_size;
         }
 
         /* map the middle (easier) */
@@ -739,6 +738,7 @@ fail:
 
 static void mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
 {
+    int host_page_size = qemu_real_host_page_size();
     abi_ulong real_start;
     abi_ulong real_last;
     abi_ulong real_len;
@@ -748,7 +748,7 @@ static void mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
     int prot;
 
     last = start + len - 1;
-    real_start = start & qemu_host_page_mask;
+    real_start = start & -host_page_size;
     real_last = HOST_PAGE_ALIGN(last) - 1;
 
     /*
@@ -757,7 +757,7 @@ static void mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
      * The single page special case is required for the last page,
      * lest real_start overflow to zero.
      */
-    if (real_last - real_start < qemu_host_page_size) {
+    if (real_last - real_start < host_page_size) {
         prot = 0;
         for (a = real_start; a < start; a += TARGET_PAGE_SIZE) {
             prot |= page_get_flags(a);
@@ -773,14 +773,14 @@ static void mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
             prot |= page_get_flags(a);
         }
         if (prot != 0) {
-            real_start += qemu_host_page_size;
+            real_start += host_page_size;
         }
 
         for (prot = 0, a = last; a < real_last; a += TARGET_PAGE_SIZE) {
             prot |= page_get_flags(a + 1);
         }
         if (prot != 0) {
-            real_last -= qemu_host_page_size;
+            real_last -= host_page_size;
         }
 
         if (real_last < real_start) {
-- 
2.34.1


