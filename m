Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A62781157
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:13:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX31y-0008ID-0b; Fri, 18 Aug 2023 13:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31u-0008HL-GK
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:58 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31r-00083h-KP
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:57 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bc0d39b52cso8890765ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378774; x=1692983574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jC5hJ3GCswcnU2akPG3677FrJC7qlQMO+Kr48jMs8x0=;
 b=E9P8z7+MjnlM/t0kAdA+fic+Oz/P4/zT1GF13UGr2p/hwrPltpJcpADintxj1ocZKf
 /hRZ0h57VtUuL6Rp1OYk7Z0MwrSyKf5rVNbtFREmQEwOBo0991ZHsnMZ1kyiOnsc0BFT
 +Q9AOrS5B707iwqlHxEa5SSsYv0bt7Z4lUB+RqMTz8ye6Uj/O4QZFbFG52XEAa/6j0WN
 RGNBfFcQu06hx2cf/NPVeSmL9J5qUW9Jhe8ZcEOJcsGh03BsQOSjAPQ1pUwVypPi2sLD
 2zSKpafby2qdA1gjic0KImR6GkeDG1HV9i/D+qwtkADg7d4z3IzIheKgett87OzzzU2E
 ZyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378774; x=1692983574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jC5hJ3GCswcnU2akPG3677FrJC7qlQMO+Kr48jMs8x0=;
 b=j5J1HpmQ/CCmd7lTSV0lGpbHe0JDq2rYfJu2kf6mLU7E8NxpZKuMijVtu3fYF/5rbC
 Vv12sliu42OrFixZsIcSvLEOt71ZYKr8ANX/sl2SbORbMZMEbPSfH+ysbfrOPRWrrozV
 vp0f8xtEgRcWcUhPJdwfbkbzXmTMDgnmVwCUelbI5xROOdwyLQdehXKvPzdD5kzJgHKe
 0Cl/cc7guc7NRN3C42F2DA18fPa2MjTfszwwWcwPGaU1kIALSjcog5MShFmrUBk4gxDp
 Lz6gl0Z69iPTWMBcm5hA+Gf3TkObXYJ0BmOF1u30WKGRdzmLq1nr4M2Jze6yBs7C9y5Z
 WKIg==
X-Gm-Message-State: AOJu0YyhQloNQtHgoVp1ceqUf4Qg35YXeoeHR0lnXq8LvlJw68z3RPTl
 c1HTqWEgHX+jgk7hzbSm9Yu9azuBvKMOXid5Oo0=
X-Google-Smtp-Source: AGHT+IFX7JFPgKrIxasgG/8ffj9ag7WzQYP29xPddqrGjNO+ZepFYnKCptjlZ65U/yv7JDsy1QGEYg==
X-Received: by 2002:a17:902:e88f:b0:1bb:b226:52a0 with SMTP id
 w15-20020a170902e88f00b001bbb22652a0mr3755997plg.44.1692378774005; 
 Fri, 18 Aug 2023 10:12:54 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/33] linux-user: Move some mmap checks outside the lock
Date: Fri, 18 Aug 2023 10:12:11 -0700
Message-Id: <20230818171227.141728-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Basic validation of operands does not require the lock.
Hoist them from target_mmap__locked back into target_mmap.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 107 +++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 54 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 448f168df1..85d16a29c1 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -447,52 +447,14 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 }
 
 static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
-                                    int target_prot, int flags,
+                                    int target_prot, int flags, int page_flags,
                                     int fd, off_t offset)
 {
     int host_page_size = qemu_real_host_page_size();
     abi_ulong ret, last, real_start, real_last, retaddr, host_len;
     abi_ulong passthrough_start = -1, passthrough_last = 0;
-    int page_flags;
     off_t host_offset;
 
-    if (!len) {
-        errno = EINVAL;
-        return -1;
-    }
-
-    page_flags = validate_prot_to_pageflags(target_prot);
-    if (!page_flags) {
-        errno = EINVAL;
-        return -1;
-    }
-
-    /* Also check for overflows... */
-    len = TARGET_PAGE_ALIGN(len);
-    if (!len) {
-        errno = ENOMEM;
-        return -1;
-    }
-
-    if (offset & ~TARGET_PAGE_MASK) {
-        errno = EINVAL;
-        return -1;
-    }
-
-    /*
-     * If we're mapping shared memory, ensure we generate code for parallel
-     * execution and flush old translations.  This will work up to the level
-     * supported by the host -- anything that requires EXCP_ATOMIC will not
-     * be atomic with respect to an external process.
-     */
-    if (flags & MAP_SHARED) {
-        CPUState *cpu = thread_cpu;
-        if (!(cpu->tcg_cflags & CF_PARALLEL)) {
-            cpu->tcg_cflags |= CF_PARALLEL;
-            tb_flush(cpu);
-        }
-    }
-
     real_start = start & -host_page_size;
     host_offset = offset & -host_page_size;
 
@@ -572,23 +534,9 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
         passthrough_start = start;
         passthrough_last = last;
     } else {
-        if (start & ~TARGET_PAGE_MASK) {
-            errno = EINVAL;
-            return -1;
-        }
         last = start + len - 1;
         real_last = ROUND_UP(last, host_page_size) - 1;
 
-        /*
-         * Test if requested memory area fits target address space
-         * It can fail only on 64-bit host with 32-bit target.
-         * On any other target/host host mmap() handles this error correctly.
-         */
-        if (last < start || !guest_range_valid_untagged(start, len)) {
-            errno = ENOMEM;
-            return -1;
-        }
-
         if (flags & MAP_FIXED_NOREPLACE) {
             /* Validate that the chosen range is empty. */
             if (!page_check_range_empty(start, last)) {
@@ -733,13 +681,64 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                      int flags, int fd, off_t offset)
 {
     abi_long ret;
+    int page_flags;
 
     trace_target_mmap(start, len, target_prot, flags, fd, offset);
+
+    if (!len) {
+        errno = EINVAL;
+        return -1;
+    }
+
+    page_flags = validate_prot_to_pageflags(target_prot);
+    if (!page_flags) {
+        errno = EINVAL;
+        return -1;
+    }
+
+    /* Also check for overflows... */
+    len = TARGET_PAGE_ALIGN(len);
+    if (!len || len != (size_t)len) {
+        errno = ENOMEM;
+        return -1;
+    }
+
+    if (offset & ~TARGET_PAGE_MASK) {
+        errno = EINVAL;
+        return -1;
+    }
+    if (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE)) {
+        if (start & ~TARGET_PAGE_MASK) {
+            errno = EINVAL;
+            return -1;
+        }
+        if (!guest_range_valid_untagged(start, len)) {
+            errno = ENOMEM;
+            return -1;
+        }
+    }
+
     mmap_lock();
 
-    ret = target_mmap__locked(start, len, target_prot, flags, fd, offset);
+    ret = target_mmap__locked(start, len, target_prot, flags,
+                              page_flags, fd, offset);
 
     mmap_unlock();
+
+    /*
+     * If we're mapping shared memory, ensure we generate code for parallel
+     * execution and flush old translations.  This will work up to the level
+     * supported by the host -- anything that requires EXCP_ATOMIC will not
+     * be atomic with respect to an external process.
+     */
+    if (ret != -1 && (flags & MAP_TYPE) != MAP_PRIVATE) {
+        CPUState *cpu = thread_cpu;
+        if (!(cpu->tcg_cflags & CF_PARALLEL)) {
+            cpu->tcg_cflags |= CF_PARALLEL;
+            tb_flush(cpu);
+        }
+    }
+
     return ret;
 }
 
-- 
2.34.1


