Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5D674C73C
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:38:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEA-0004PS-2H; Sun, 09 Jul 2023 14:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDx-0003X4-8t
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDt-0004F9-6H
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:31 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8fcso28087955e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927605; x=1691519605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7S8fJjWsfM8/RKnCcasDShb0DLhg94fNTjj77rs37DE=;
 b=thoAjB3GpxKzMJcx1kcs1fdv/HJfX7A6qoQcNWX16u3f1tAbZANWzjLy0zZYzfdPWl
 4q6roZnfopurtCdH/6cETa9Hq4wtedV8RlP4KV9D2A1Th1D35hTOe4ju9iyRMR1FFOzB
 uu+/fCVoLwkZZM4MBauvIDCGNL2EJZZtOYOz9nDfXUn7sMHR/6Bpdxk/JoicIwdGFP/1
 j4tOUSsKyI1pSVFrDFGuMTOlxBZoeJVilSkwowpI/JKInmuLNq/ajmGKbRQyJt1J0RIT
 rfvsVFWKHthiUEoSy3aisPuKSSzO1kfsE+gbwaYT8ag2CutdV5U4AWoYTirdbgfC5luF
 CQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927605; x=1691519605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7S8fJjWsfM8/RKnCcasDShb0DLhg94fNTjj77rs37DE=;
 b=QyzfaF6M2yrBfwu66jTUvn3B8Bo4dPfW1os0cry5K1yNUBv+e1PHjT2HdDnO8Ol4Jl
 PUMROlUScFkwhNmtXdWuEe8PHDobGN0XLO50bsGWxbMnC2IY9CB5livzBDznje2tLzYe
 Yp7YadRkGOaYh7HYcC9dHsNOicOsXyulFKCPekKm4FQDI39ZnuTwkRCc0L1slxLZxGQz
 mHPW6p/E9c2DsZ1CreDXksCivQhUJIo1WEIkHtxO+WxhWrbZW1L2lmUZUBTf0ozGxWsG
 rdMs6fMX4X0865dwgbo6zdiYRgWstAlXE1QV4Hukx4jPTwsA/9dfT+QB1mefxHwVjTNB
 XrwA==
X-Gm-Message-State: ABy/qLbLN9Q3i9Gd9x2k22IsTIFtZ1vukRxACR9/nmQBtugKu1nWg/Dw
 rWBStSOqmrKZTFcFdX+9GX90ouhCJfWIY/pVUYur+A==
X-Google-Smtp-Source: APBJJlEKT+MLvRyZnoQ1pjkI4oI5LKr4gDuq+j639HCg/KWneAxU1WJB/NPgT9HSUQSvJfeVkLNcdw==
X-Received: by 2002:a1c:741a:0:b0:3fc:1a6:79a9 with SMTP id
 p26-20020a1c741a000000b003fc01a679a9mr1230997wmc.16.1688927605638; 
 Sun, 09 Jul 2023 11:33:25 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 29/45] linux-user: Split out target_to_host_prot
Date: Sun,  9 Jul 2023 19:29:09 +0100
Message-Id: <20230709182934.309468-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230707204054.8792-13-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 78 ++++++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 9dc34fc29d..12b1308a83 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -69,24 +69,11 @@ void mmap_fork_end(int child)
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
@@ -114,18 +101,34 @@ static int validate_prot_to_pageflags(int *host_prot, int prot)
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
@@ -143,7 +146,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
     host_end = HOST_PAGE_ALIGN(end);
     if (start > host_start) {
         /* handle host page containing start */
-        prot1 = host_prot;
+        prot1 = target_prot;
         for (addr = host_start; addr < start; addr += TARGET_PAGE_SIZE) {
             prot1 |= page_get_flags(addr);
         }
@@ -154,19 +157,19 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
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
@@ -175,8 +178,8 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 
     /* handle the pages in the middle */
     if (host_start < host_end) {
-        ret = mprotect(g2h_untagged(host_start),
-                       host_end - host_start, host_prot);
+        ret = mprotect(g2h_untagged(host_start), host_end - host_start,
+                       target_to_host_prot(target_prot));
         if (ret != 0) {
             goto error;
         }
@@ -212,7 +215,8 @@ static int mmap_frag(abi_ulong real_start,
 
     if (prot1 == 0) {
         /* no page was there, so we allocate one */
-        void *p = mmap(host_start, qemu_host_page_size, prot,
+        void *p = mmap(host_start, qemu_host_page_size,
+                       target_to_host_prot(prot),
                        flags | MAP_ANONYMOUS, -1, 0);
         if (p == MAP_FAILED) {
             return -1;
@@ -233,7 +237,8 @@ static int mmap_frag(abi_ulong real_start,
 
         /* adjust protection to be able to read */
         if (!(prot1 & PROT_WRITE)) {
-            mprotect(host_start, qemu_host_page_size, prot1 | PROT_WRITE);
+            mprotect(host_start, qemu_host_page_size,
+                     target_to_host_prot(prot1) | PROT_WRITE);
         }
 
         /* read the corresponding file data */
@@ -243,11 +248,13 @@ static int mmap_frag(abi_ulong real_start,
 
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
@@ -460,7 +467,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
 {
     abi_ulong ret, end, real_start, real_end, retaddr, host_offset, host_len,
               passthrough_start = -1, passthrough_end = -1;
-    int page_flags, host_prot;
+    int page_flags;
 
     mmap_lock();
     trace_target_mmap(start, len, target_prot, flags, fd, offset);
@@ -470,7 +477,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         goto fail;
     }
 
-    page_flags = validate_prot_to_pageflags(&host_prot, target_prot);
+    page_flags = validate_prot_to_pageflags(target_prot);
     if (!page_flags) {
         errno = EINVAL;
         goto fail;
@@ -553,10 +560,12 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
 
     if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         unsigned long host_start;
+        int host_prot;
         void *p;
 
         host_len = len + offset - host_offset;
         host_len = HOST_PAGE_ALIGN(host_len);
+        host_prot = target_to_host_prot(target_prot);
 
         /*
          * Note: we prefer to control the mapping address. It is
@@ -617,7 +626,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
              * msync() won't work here, so we return an error if write is
              * possible while it is a shared mapping
              */
-            if ((flags & MAP_TYPE) == MAP_SHARED && (host_prot & PROT_WRITE)) {
+            if ((flags & MAP_TYPE) == MAP_SHARED
+                && (target_prot & PROT_WRITE)) {
                 errno = EINVAL;
                 goto fail;
             }
@@ -631,7 +641,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             if (pread(fd, g2h_untagged(start), len, offset) == -1) {
                 goto fail;
             }
-            if (!(host_prot & PROT_WRITE)) {
+            if (!(target_prot & PROT_WRITE)) {
                 ret = target_mprotect(start, len, target_prot);
                 assert(ret == 0);
             }
@@ -643,14 +653,14 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
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
@@ -660,7 +670,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         if (end < real_end) {
             ret = mmap_frag(real_end - qemu_host_page_size,
                             real_end - qemu_host_page_size, end,
-                            host_prot, flags, fd,
+                            target_prot, flags, fd,
                             offset + real_end - qemu_host_page_size - start);
             if (ret == -1) {
                 goto fail;
@@ -678,7 +688,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
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


