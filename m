Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE47821633
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:00:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3O-0003Lh-Lj; Mon, 01 Jan 2024 20:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3M-0003LD-U9
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:48 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3L-00072X-4O
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:48 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3bbd6f87959so2438372b6e.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160726; x=1704765526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCVGxN0fnWUc6maO2wa7dwEI9dVIrhQYXz7yUCQwr68=;
 b=Gk9qLQmxGv4qKw8p86XCfG4z+OwjmQuWyHIBOSx3Htu4N0q3gZII+kZFHZZWQ16IEo
 GB2BpgHcxrI+kzcFEizQmMHxps4Bm8PxgI5b/pVwB9ph/0qza+ZxVsG2VrSgV3E2tLhK
 RtkVmQcMen+jUC9k7ByYsrMc3qqCTKKh8UNdT1i9jXdcWLBBnZVxLUUy6ZWUGMqp4y8y
 lba7JnVNMDCGTZuKVnTxTWm3hALGY09t6K3zl8f8kASeEGLuubBpSOmlO5iNa7GZPJmd
 G5HLgAiLEeVP9HENIDHq1XB7Xd+4HRu2nxc/P4mRTuuQjxOL7SsGZCwNY90hYpPa+1Qf
 ev7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160726; x=1704765526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCVGxN0fnWUc6maO2wa7dwEI9dVIrhQYXz7yUCQwr68=;
 b=wDn9lVbb/PkTTR28Bf1YswB2T4n1jTx7cUNqpLex7hb37e/Kfhnpa1bSoez982xwOK
 Sw8eMPzlHBp78SozLnyHHU8+TY+jLQ+uegB1WV2Je1SfwwHmSOQRwOylLDi9iCXx4V2A
 RGgIFzjGEkMm+zZxo13mbpcMyiUKD/m4uRbQkqBG2pLynt252vJ4q5o6ZBPJaX0Ucs0g
 UBzIa604wFFtpjNoIi1ATEHi+gy6Oa6EIHNZg3vw1SOr4cbHxblRuvmyjZUoH9B/ORP2
 CMUXt0v42ZpF/j4lFffsgsbW90hqeb4TYSK11LYLWnzZ2YJMHyJCsBk3I6sQEH95QUTa
 2dzw==
X-Gm-Message-State: AOJu0Yzb4RT0Hlq9aPFAI1mV455ELay7ID7pljUgA1r2aAdt2VKFyxBl
 1e81I08H1dTeUXmdQptILlNRqj96fKiR3u2PSypQk5kfH3s=
X-Google-Smtp-Source: AGHT+IFSfWkWw+ykc02cxF/IAAJDocZtPwmgTGs/MlDQprQgtZciMKLd4Fspg3DQWJUyvtVRKG319w==
X-Received: by 2002:a05:6808:159e:b0:3bc:18d8:d208 with SMTP id
 t30-20020a056808159e00b003bc18d8d208mr317011oiw.30.1704160725851; 
 Mon, 01 Jan 2024 17:58:45 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 16/33] linux-user: Split out target_mmap__locked
Date: Tue,  2 Jan 2024 12:57:51 +1100
Message-Id: <20240102015808.132373-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

All "goto fail" may be transformed to "return -1".

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 62 ++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index d11f758d07..b4c3cc65aa 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -490,9 +490,9 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
     }
 }
 
-/* NOTE: all the constants are the HOST ones */
-abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
-                     int flags, int fd, off_t offset)
+static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
+                                    int target_prot, int flags,
+                                    int fd, off_t offset)
 {
     int host_page_size = qemu_real_host_page_size();
     abi_ulong ret, last, real_start, real_last, retaddr, host_len;
@@ -500,30 +500,27 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
     int page_flags;
     off_t host_offset;
 
-    mmap_lock();
-    trace_target_mmap(start, len, target_prot, flags, fd, offset);
-
     if (!len) {
         errno = EINVAL;
-        goto fail;
+        return -1;
     }
 
     page_flags = validate_prot_to_pageflags(target_prot);
     if (!page_flags) {
         errno = EINVAL;
-        goto fail;
+        return -1;
     }
 
     /* Also check for overflows... */
     len = TARGET_PAGE_ALIGN(len);
     if (!len) {
         errno = ENOMEM;
-        goto fail;
+        return -1;
     }
 
     if (offset & ~TARGET_PAGE_MASK) {
         errno = EINVAL;
-        goto fail;
+        return -1;
     }
 
     /*
@@ -553,7 +550,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
-            goto fail;
+            return -1;
         }
     }
 
@@ -574,7 +571,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         struct stat sb;
 
         if (fstat(fd, &sb) == -1) {
-            goto fail;
+            return -1;
         }
 
         /* Are we trying to create a map beyond EOF?.  */
@@ -601,7 +598,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         p = mmap(g2h_untagged(start), host_len, host_prot,
                  flags | MAP_FIXED | MAP_ANONYMOUS, -1, 0);
         if (p == MAP_FAILED) {
-            goto fail;
+            return -1;
         }
         /* update start so that it points to the file position at 'offset' */
         host_start = (uintptr_t)p;
@@ -610,7 +607,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                      flags | MAP_FIXED, fd, host_offset);
             if (p == MAP_FAILED) {
                 munmap(g2h_untagged(start), host_len);
-                goto fail;
+                return -1;
             }
             host_start += offset - host_offset;
         }
@@ -621,7 +618,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
     } else {
         if (start & ~TARGET_PAGE_MASK) {
             errno = EINVAL;
-            goto fail;
+            return -1;
         }
         last = start + len - 1;
         real_last = ROUND_UP(last, host_page_size) - 1;
@@ -633,14 +630,14 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
          */
         if (last < start || !guest_range_valid_untagged(start, len)) {
             errno = ENOMEM;
-            goto fail;
+            return -1;
         }
 
         if (flags & MAP_FIXED_NOREPLACE) {
             /* Validate that the chosen range is empty. */
             if (!page_check_range_empty(start, last)) {
                 errno = EEXIST;
-                goto fail;
+                return -1;
             }
 
             /*
@@ -671,17 +668,17 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             if ((flags & MAP_TYPE) == MAP_SHARED
                 && (target_prot & PROT_WRITE)) {
                 errno = EINVAL;
-                goto fail;
+                return -1;
             }
             retaddr = target_mmap(start, len, target_prot | PROT_WRITE,
                                   (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))
                                   | MAP_PRIVATE | MAP_ANONYMOUS,
                                   -1, 0);
             if (retaddr == -1) {
-                goto fail;
+                return -1;
             }
             if (pread(fd, g2h_untagged(start), len, offset) == -1) {
-                goto fail;
+                return -1;
             }
             if (!(target_prot & PROT_WRITE)) {
                 ret = target_mprotect(start, len, target_prot);
@@ -696,14 +693,14 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                 /* one single host page */
                 if (!mmap_frag(real_start, start, last,
                                target_prot, flags, fd, offset)) {
-                    goto fail;
+                    return -1;
                 }
                 goto the_end1;
             }
             if (!mmap_frag(real_start, start,
                            real_start + host_page_size - 1,
                            target_prot, flags, fd, offset)) {
-                goto fail;
+                return -1;
             }
             real_start += host_page_size;
         }
@@ -713,7 +710,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             if (!mmap_frag(real_page, real_page, last,
                            target_prot, flags, fd,
                            offset + real_page - start)) {
-                goto fail;
+                return -1;
             }
             real_last -= host_page_size;
         }
@@ -739,7 +736,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                     munmap(p, len1);
                     errno = EEXIST;
                 }
-                goto fail;
+                return -1;
             }
             passthrough_start = real_start;
             passthrough_last = real_last;
@@ -773,11 +770,22 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             qemu_log_unlock(f);
         }
     }
-    mmap_unlock();
     return start;
-fail:
+}
+
+/* NOTE: all the constants are the HOST ones */
+abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
+                     int flags, int fd, off_t offset)
+{
+    abi_long ret;
+
+    trace_target_mmap(start, len, target_prot, flags, fd, offset);
+    mmap_lock();
+
+    ret = target_mmap__locked(start, len, target_prot, flags, fd, offset);
+
     mmap_unlock();
-    return -1;
+    return ret;
 }
 
 static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
-- 
2.34.1


