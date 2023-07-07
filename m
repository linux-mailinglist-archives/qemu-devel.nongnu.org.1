Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C15D74B83B
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:44:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGO-0004pX-FR; Fri, 07 Jul 2023 16:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGL-0004nr-8P
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:09 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGH-0004hs-Nh
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:08 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3144098df56so2553915f8f.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762464; x=1691354464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f2/OyoNqam0/AVMCv04Uy+mQaVidqBwtlKBQnTyCUHY=;
 b=dqSnTN7U/fntXFnEghGFlRVqkpjpSGql+qRtj3+6KhwnL7Iwp2cFfrDjz/FsQmkbZ9
 hnIghGBjkHz8Ll35tH0/adBTjCi+l51jgcHYgP15dk1AhwJAmlym5kzO+fTWRK8vS8Rs
 SnFiiQlqcDljhpAdiPN2Of0/VAjUsBcL4Sjb1Y/LpzeccgNKcsBKb9NgmUZ9ahl4av0r
 weUgArFh0bEqe7RWulEXLwOnC+F9DLD/CPHqoP6IC1G+LD7P/yTn3+xfqbPz32lnvFAb
 MZarlO2TR7mWb4InX9Jjyz0o5D3i0V3IMrEVterKTm2a0XIV3Lg7wJh9BEOnrLcTlAW7
 qrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762464; x=1691354464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f2/OyoNqam0/AVMCv04Uy+mQaVidqBwtlKBQnTyCUHY=;
 b=OOJ3V6bXqTs2tAftt9ISaVMc0JaGbHE1+NaZry1qO8GCxvcKdwhLj4cTfrCprT8ryv
 sxb9tar3ThIbcYI+N0m5XfPFtKfx48y+fQxxGs0ZKyrRSfsZlGq8BgxTxVMrku/tgTFU
 Msngc5QHYO51Ldw2yvk55bfVNkpPL/9ubFLi3196IjbxL2H4REsrOek5jiZB0y+TU1VZ
 nzy53bYcYZhHyWnpJkPmAlVwISA/4ZLiXI7o43lKju/M2prq9kr9XP7GY5kIX8MBV6dJ
 4WTQ861YdrmmhjiYcmfDtu0+8GUL+CtGEci2TS5oYHSnQTP012g7l0N1BDZtKA+TsPtu
 j29Q==
X-Gm-Message-State: ABy/qLZySLbTfzTxL11ig4lxSZ25WX830b4ig+KUWSFSNKmYrQ58IMPi
 fM52+l+tLCq2y+7Uz3+nlvDtztAONDvR+Soi1O2+2g==
X-Google-Smtp-Source: APBJJlHkQRGddtDJoXiqzuPPZvYk5V1D9AaVJn+U2c9qZKLcDYipLB3o8h0SjeFPBEfc/wLj5HN6zA==
X-Received: by 2002:a7b:cc9a:0:b0:3fb:40ff:1cba with SMTP id
 p26-20020a7bcc9a000000b003fb40ff1cbamr5379965wma.6.1688762464247; 
 Fri, 07 Jul 2023 13:41:04 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:41:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, mjt@tls.msk.ru,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 10/24] linux-user: Split out target_to_host_prot
Date: Fri,  7 Jul 2023 21:40:40 +0100
Message-Id: <20230707204054.8792-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707204054.8792-1-richard.henderson@linaro.org>
References: <20230707204054.8792-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Split out from validate_prot_to_pageflags, as there is not
one single host_prot for the entire range.  We need to adjust
prot for every host page that overlaps multiple guest pages.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 77 +++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index b2e130e700..422583ed4f 100644
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
@@ -459,7 +466,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
 {
     abi_ulong ret, end, real_start, real_end, retaddr, host_offset, host_len,
               passthrough_start = -1, passthrough_end = -1;
-    int page_flags, host_prot;
+    int page_flags;
 
     mmap_lock();
     trace_target_mmap(start, len, target_prot, flags, fd, offset);
@@ -469,7 +476,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         goto fail;
     }
 
-    page_flags = validate_prot_to_pageflags(&host_prot, target_prot);
+    page_flags = validate_prot_to_pageflags(target_prot);
     if (!page_flags) {
         errno = EINVAL;
         goto fail;
@@ -552,10 +559,12 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
 
     if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         unsigned long host_start;
+        int host_prot;
         void *p;
 
         host_len = len + offset - host_offset;
         host_len = HOST_PAGE_ALIGN(host_len);
+        host_prot = target_to_host_prot(target_prot);
 
         /*
          * Note: we prefer to control the mapping address. It is
@@ -612,6 +621,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
          */
         if (!(flags & MAP_ANONYMOUS) &&
             (offset & ~qemu_host_page_mask) != (start & ~qemu_host_page_mask)) {
+            int host_prot = target_to_host_prot(target_prot);
+
             /*
              * msync() won't work here, so we return an error if write is
              * possible while it is a shared mapping
@@ -620,7 +631,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                 errno = EINVAL;
                 goto fail;
             }
-            retaddr = target_mmap(start, len, target_prot | PROT_WRITE,
+            retaddr = target_mmap(start, len, host_prot | PROT_WRITE,
                                   (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))
                                   | MAP_PRIVATE | MAP_ANONYMOUS,
                                   -1, 0);
@@ -642,14 +653,14 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
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
@@ -659,7 +670,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         if (end < real_end) {
             ret = mmap_frag(real_end - qemu_host_page_size,
                             real_end - qemu_host_page_size, end,
-                            host_prot, flags, fd,
+                            target_prot, flags, fd,
                             offset + real_end - qemu_host_page_size - start);
             if (ret == -1) {
                 goto fail;
@@ -677,7 +688,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
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


