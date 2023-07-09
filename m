Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C2974C74C
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:40:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZDo-0003EN-2j; Sun, 09 Jul 2023 14:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDl-00033b-0j
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:21 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDe-00049m-Cg
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:17 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-313f3a6db22so3764784f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927593; x=1691519593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MU6soREEIeWjjQLlmK8RHmCnAP0c3qo3FFfRalqkkk=;
 b=Pk9oLJSPF2CrU7EBPWwY5ZDvUNb97VmFJpkDfOQkNfZFRw2XTxhJqwgQ64DOGoAOSS
 0rAl8BYkw2jIodbt0mS7CGuTUUQK+/FY/wGBip0sE/zRGhU3J65MP4E/IDEMQOXfxR24
 cAx+mKCyCckk3gPDNs4I3v6goY5BUP5W1eN11u5HsP1xf+Y/WqIv3vAmcvsbSEeDxqxx
 GUXgpqdvjQD+rnC15h/plsqFvX13HEZfB1j8VkuzEBEBsRVOwgRadiDOE/pk2ml51Bf0
 qcrDlK5vknqUih6gAlPSKAUvSMwyF2FQj0SCLjQZLsfrQAhBlxT/TeZKVesooB/K62F9
 6vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927593; x=1691519593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2MU6soREEIeWjjQLlmK8RHmCnAP0c3qo3FFfRalqkkk=;
 b=VdT9CKeK1kW+w0eA8wYcmiVU+attSmz0/odVNDSgOtlnRsWveMS+Dgsw7TDx3dN2AF
 g8/02y3dDekadnt0VYc5LMdwoztbBre142D6KetNB1T1TGDvrTsV2YL1wwRAXtegn8CK
 e5IGWdaBTi/LNIWeFESIh9Vhai2QK7MgXwxXFnACIWpn7IHRCBAz01c/rJednc2GB/oP
 ASZtEM0vQ123JgcfeXPITlHXO80TqyzIyhcsFMS8dbDrq2tmJYYpnM2JMCNPdBjB+B/f
 ucDVBjttMamrRqNa0gWMD+XefR8OLpQkM+hey5csxNrmhewnXUnAGDhKRY532xBBzH6l
 hevw==
X-Gm-Message-State: ABy/qLZXmxUcOoVJobtp8OG4CRdoNpWkKpe8bXo1Kcbh9dHgCF2B4daW
 jBltHzbsy8QnEi8P3Q9aW1JPE5jOLPX8U9yay41+5g==
X-Google-Smtp-Source: APBJJlHSABa4bDfPQh30HxSn62KO5eX6UtUWIh//TWyyB153C7meSDlVSokmf5sAQ+xeueAQ5w1IMQ==
X-Received: by 2002:adf:efd1:0:b0:2ce:d84d:388f with SMTP id
 i17-20020adfefd1000000b002ced84d388fmr9753276wrp.40.1688927592630; 
 Sun, 09 Jul 2023 11:33:12 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 21/45] linux-user: Fix formatting of mmap.c
Date: Sun,  9 Jul 2023 19:28:53 +0100
Message-Id: <20230709182934.309468-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Fix all checkpatch.pl errors within mmap.c.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230707204054.8792-5-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 199 ++++++++++++++++++++++++++++------------------
 1 file changed, 122 insertions(+), 77 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 2692936773..639921dba0 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -56,10 +56,11 @@ void mmap_fork_start(void)
 
 void mmap_fork_end(int child)
 {
-    if (child)
+    if (child) {
         pthread_mutex_init(&mmap_mutex, NULL);
-    else
+    } else {
         pthread_mutex_unlock(&mmap_mutex);
+    }
 }
 
 /*
@@ -203,40 +204,47 @@ static int mmap_frag(abi_ulong real_start,
 
     /* get the protection of the target pages outside the mapping */
     prot1 = 0;
-    for(addr = real_start; addr < real_end; addr++) {
-        if (addr < start || addr >= end)
+    for (addr = real_start; addr < real_end; addr++) {
+        if (addr < start || addr >= end) {
             prot1 |= page_get_flags(addr);
+        }
     }
 
     if (prot1 == 0) {
         /* no page was there, so we allocate one */
         void *p = mmap(host_start, qemu_host_page_size, prot,
                        flags | MAP_ANONYMOUS, -1, 0);
-        if (p == MAP_FAILED)
+        if (p == MAP_FAILED) {
             return -1;
+        }
         prot1 = prot;
     }
     prot1 &= PAGE_BITS;
 
     prot_new = prot | prot1;
     if (!(flags & MAP_ANONYMOUS)) {
-        /* msync() won't work here, so we return an error if write is
-           possible while it is a shared mapping */
-        if ((flags & MAP_TYPE) == MAP_SHARED &&
-            (prot & PROT_WRITE))
+        /*
+         * msync() won't work here, so we return an error if write is
+         * possible while it is a shared mapping.
+         */
+        if ((flags & MAP_TYPE) == MAP_SHARED && (prot & PROT_WRITE)) {
             return -1;
+        }
 
         /* adjust protection to be able to read */
-        if (!(prot1 & PROT_WRITE))
+        if (!(prot1 & PROT_WRITE)) {
             mprotect(host_start, qemu_host_page_size, prot1 | PROT_WRITE);
+        }
 
         /* read the corresponding file data */
-        if (pread(fd, g2h_untagged(start), end - start, offset) == -1)
+        if (pread(fd, g2h_untagged(start), end - start, offset) == -1) {
             return -1;
+        }
 
         /* put final protection */
-        if (prot_new != (prot1 | PROT_WRITE))
+        if (prot_new != (prot1 | PROT_WRITE)) {
             mprotect(host_start, qemu_host_page_size, prot_new);
+        }
     } else {
         if (prot_new != prot1) {
             mprotect(host_start, qemu_host_page_size, prot_new);
@@ -265,8 +273,10 @@ abi_ulong mmap_next_start = TASK_UNMAPPED_BASE;
 
 unsigned long last_brk;
 
-/* Subroutine of mmap_find_vma, used when we have pre-allocated a chunk
-   of guest address space.  */
+/*
+ * Subroutine of mmap_find_vma, used when we have pre-allocated
+ * a chunk of guest address space.
+ */
 static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
                                         abi_ulong align)
 {
@@ -362,15 +372,17 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
          *  - shmat() with SHM_REMAP flag
          */
         ptr = mmap(g2h_untagged(addr), size, PROT_NONE,
-                   MAP_ANONYMOUS|MAP_PRIVATE|MAP_NORESERVE, -1, 0);
+                   MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
 
         /* ENOMEM, if host address space has no memory */
         if (ptr == MAP_FAILED) {
             return (abi_ulong)-1;
         }
 
-        /* Count the number of sequential returns of the same address.
-           This is used to modify the search algorithm below.  */
+        /*
+         * Count the number of sequential returns of the same address.
+         * This is used to modify the search algorithm below.
+         */
         repeat = (ptr == prev ? repeat + 1 : 0);
 
         if (h2g_valid(ptr + size - 1)) {
@@ -387,14 +399,18 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
             /* The address is not properly aligned for the target.  */
             switch (repeat) {
             case 0:
-                /* Assume the result that the kernel gave us is the
-                   first with enough free space, so start again at the
-                   next higher target page.  */
+                /*
+                 * Assume the result that the kernel gave us is the
+                 * first with enough free space, so start again at the
+                 * next higher target page.
+                 */
                 addr = ROUND_UP(addr, align);
                 break;
             case 1:
-                /* Sometimes the kernel decides to perform the allocation
-                   at the top end of memory instead.  */
+                /*
+                 * Sometimes the kernel decides to perform the allocation
+                 * at the top end of memory instead.
+                 */
                 addr &= -align;
                 break;
             case 2:
@@ -407,8 +423,10 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
                 break;
             }
         } else {
-            /* Since the result the kernel gave didn't fit, start
-               again at low memory.  If any repetition, fail.  */
+            /*
+             * Since the result the kernel gave didn't fit, start
+             * again at low memory.  If any repetition, fail.
+             */
             addr = (repeat ? -1 : 0);
         }
 
@@ -423,8 +441,10 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
                 return (abi_ulong)-1;
             }
             wrapped = 1;
-            /* Don't actually use 0 when wrapping, instead indicate
-               that we'd truly like an allocation in low memory.  */
+            /*
+             * Don't actually use 0 when wrapping, instead indicate
+             * that we'd truly like an allocation in low memory.
+             */
             addr = (mmap_min_addr > TARGET_PAGE_SIZE
                      ? TARGET_PAGE_ALIGN(mmap_min_addr)
                      : TARGET_PAGE_SIZE);
@@ -485,8 +505,10 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
     real_start = start & qemu_host_page_mask;
     host_offset = offset & qemu_host_page_mask;
 
-    /* If the user is asking for the kernel to find a location, do that
-       before we truncate the length for mapping files below.  */
+    /*
+     * If the user is asking for the kernel to find a location, do that
+     * before we truncate the length for mapping files below.
+     */
     if (!(flags & MAP_FIXED)) {
         host_len = len + offset - host_offset;
         host_len = HOST_PAGE_ALIGN(host_len);
@@ -497,32 +519,36 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         }
     }
 
-    /* When mapping files into a memory area larger than the file, accesses
-       to pages beyond the file size will cause a SIGBUS. 
-
-       For example, if mmaping a file of 100 bytes on a host with 4K pages
-       emulating a target with 8K pages, the target expects to be able to
-       access the first 8K. But the host will trap us on any access beyond
-       4K.  
-
-       When emulating a target with a larger page-size than the hosts, we
-       may need to truncate file maps at EOF and add extra anonymous pages
-       up to the targets page boundary.  */
-
+    /*
+     * When mapping files into a memory area larger than the file, accesses
+     * to pages beyond the file size will cause a SIGBUS.
+     *
+     * For example, if mmaping a file of 100 bytes on a host with 4K pages
+     * emulating a target with 8K pages, the target expects to be able to
+     * access the first 8K. But the host will trap us on any access beyond
+     * 4K.
+     *
+     * When emulating a target with a larger page-size than the hosts, we
+     * may need to truncate file maps at EOF and add extra anonymous pages
+     * up to the targets page boundary.
+     */
     if ((qemu_real_host_page_size() < qemu_host_page_size) &&
         !(flags & MAP_ANONYMOUS)) {
         struct stat sb;
 
-       if (fstat (fd, &sb) == -1)
-           goto fail;
+        if (fstat(fd, &sb) == -1) {
+            goto fail;
+        }
 
-       /* Are we trying to create a map beyond EOF?.  */
-       if (offset + len > sb.st_size) {
-           /* If so, truncate the file map at eof aligned with 
-              the hosts real pagesize. Additional anonymous maps
-              will be created beyond EOF.  */
-           len = REAL_HOST_PAGE_ALIGN(sb.st_size - offset);
-       }
+        /* Are we trying to create a map beyond EOF?.  */
+        if (offset + len > sb.st_size) {
+            /*
+             * If so, truncate the file map at eof aligned with
+             * the hosts real pagesize. Additional anonymous maps
+             * will be created beyond EOF.
+             */
+            len = REAL_HOST_PAGE_ALIGN(sb.st_size - offset);
+        }
     }
 
     if (!(flags & MAP_FIXED)) {
@@ -532,9 +558,11 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         host_len = len + offset - host_offset;
         host_len = HOST_PAGE_ALIGN(host_len);
 
-        /* Note: we prefer to control the mapping address. It is
-           especially important if qemu_host_page_size >
-           qemu_real_host_page_size */
+        /*
+         * Note: we prefer to control the mapping address. It is
+         * especially important if qemu_host_page_size >
+         * qemu_real_host_page_size.
+         */
         p = mmap(g2h_untagged(start), host_len, host_prot,
                  flags | MAP_FIXED | MAP_ANONYMOUS, -1, 0);
         if (p == MAP_FAILED) {
@@ -572,45 +600,52 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             goto fail;
         }
 
-        /* worst case: we cannot map the file because the offset is not
-           aligned, so we read it */
+        /*
+         * worst case: we cannot map the file because the offset is not
+         * aligned, so we read it
+         */
         if (!(flags & MAP_ANONYMOUS) &&
             (offset & ~qemu_host_page_mask) != (start & ~qemu_host_page_mask)) {
-            /* msync() won't work here, so we return an error if write is
-               possible while it is a shared mapping */
-            if ((flags & MAP_TYPE) == MAP_SHARED &&
-                (host_prot & PROT_WRITE)) {
+            /*
+             * msync() won't work here, so we return an error if write is
+             * possible while it is a shared mapping
+             */
+            if ((flags & MAP_TYPE) == MAP_SHARED && (host_prot & PROT_WRITE)) {
                 errno = EINVAL;
                 goto fail;
             }
             retaddr = target_mmap(start, len, target_prot | PROT_WRITE,
                                   MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS,
                                   -1, 0);
-            if (retaddr == -1)
+            if (retaddr == -1) {
                 goto fail;
-            if (pread(fd, g2h_untagged(start), len, offset) == -1)
+            }
+            if (pread(fd, g2h_untagged(start), len, offset) == -1) {
                 goto fail;
+            }
             if (!(host_prot & PROT_WRITE)) {
                 ret = target_mprotect(start, len, target_prot);
                 assert(ret == 0);
             }
             goto the_end;
         }
-        
+
         /* handle the start of the mapping */
         if (start > real_start) {
             if (real_end == real_start + qemu_host_page_size) {
                 /* one single host page */
                 ret = mmap_frag(real_start, start, end,
                                 host_prot, flags, fd, offset);
-                if (ret == -1)
+                if (ret == -1) {
                     goto fail;
+                }
                 goto the_end1;
             }
             ret = mmap_frag(real_start, start, real_start + qemu_host_page_size,
                             host_prot, flags, fd, offset);
-            if (ret == -1)
+            if (ret == -1) {
                 goto fail;
+            }
             real_start += qemu_host_page_size;
         }
         /* handle the end of the mapping */
@@ -619,8 +654,9 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                             real_end - qemu_host_page_size, end,
                             host_prot, flags, fd,
                             offset + real_end - qemu_host_page_size - start);
-            if (ret == -1)
+            if (ret == -1) {
                 goto fail;
+            }
             real_end -= qemu_host_page_size;
         }
 
@@ -628,14 +664,16 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         if (real_start < real_end) {
             void *p;
             unsigned long offset1;
-            if (flags & MAP_ANONYMOUS)
+            if (flags & MAP_ANONYMOUS) {
                 offset1 = 0;
-            else
+            } else {
                 offset1 = offset + real_start - start;
+            }
             p = mmap(g2h_untagged(real_start), real_end - real_start,
                      host_prot, flags, fd, offset1);
-            if (p == MAP_FAILED)
+            if (p == MAP_FAILED) {
                 goto fail;
+            }
             passthrough_start = real_start;
             passthrough_end = real_end;
         }
@@ -697,16 +735,18 @@ static void mmap_reserve(abi_ulong start, abi_ulong size)
             }
             end = real_end;
         }
-        if (prot != 0)
+        if (prot != 0) {
             real_start += qemu_host_page_size;
+        }
     }
     if (end < real_end) {
         prot = 0;
         for (addr = end; addr < real_end; addr += TARGET_PAGE_SIZE) {
             prot |= page_get_flags(addr);
         }
-        if (prot != 0)
+        if (prot != 0) {
             real_end -= qemu_host_page_size;
+        }
     }
     if (real_start != real_end) {
         mmap(g2h_untagged(real_start), real_end - real_start, PROT_NONE,
@@ -722,8 +762,9 @@ int target_munmap(abi_ulong start, abi_ulong len)
 
     trace_target_munmap(start, len);
 
-    if (start & ~TARGET_PAGE_MASK)
+    if (start & ~TARGET_PAGE_MASK) {
         return -TARGET_EINVAL;
+    }
     len = TARGET_PAGE_ALIGN(len);
     if (len == 0 || !guest_range_valid_untagged(start, len)) {
         return -TARGET_EINVAL;
@@ -737,25 +778,27 @@ int target_munmap(abi_ulong start, abi_ulong len)
     if (start > real_start) {
         /* handle host page containing start */
         prot = 0;
-        for(addr = real_start; addr < start; addr += TARGET_PAGE_SIZE) {
+        for (addr = real_start; addr < start; addr += TARGET_PAGE_SIZE) {
             prot |= page_get_flags(addr);
         }
         if (real_end == real_start + qemu_host_page_size) {
-            for(addr = end; addr < real_end; addr += TARGET_PAGE_SIZE) {
+            for (addr = end; addr < real_end; addr += TARGET_PAGE_SIZE) {
                 prot |= page_get_flags(addr);
             }
             end = real_end;
         }
-        if (prot != 0)
+        if (prot != 0) {
             real_start += qemu_host_page_size;
+        }
     }
     if (end < real_end) {
         prot = 0;
-        for(addr = end; addr < real_end; addr += TARGET_PAGE_SIZE) {
+        for (addr = end; addr < real_end; addr += TARGET_PAGE_SIZE) {
             prot |= page_get_flags(addr);
         }
-        if (prot != 0)
+        if (prot != 0) {
             real_end -= qemu_host_page_size;
+        }
     }
 
     ret = 0;
@@ -798,8 +841,10 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                            flags, g2h_untagged(new_addr));
 
         if (reserved_va && host_addr != MAP_FAILED) {
-            /* If new and old addresses overlap then the above mremap will
-               already have failed with EINVAL.  */
+            /*
+             * If new and old addresses overlap then the above mremap will
+             * already have failed with EINVAL.
+             */
             mmap_reserve(old_addr, old_size);
         }
     } else if (flags & MREMAP_MAYMOVE) {
-- 
2.34.1


