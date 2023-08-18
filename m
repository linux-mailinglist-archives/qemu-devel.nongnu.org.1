Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF53B781169
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:15:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX31z-0008IV-NJ; Fri, 18 Aug 2023 13:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31u-0008HJ-Fu
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:58 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31q-00083b-Mg
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:56 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bdca7cc28dso9452205ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378773; x=1692983573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m1beAKqAHv3vWel3I5O47E14cIOUPK0xwqCuArIxTEk=;
 b=gzxEpCqu/uMl8lqD7ANQxJlwVKZwmusxGyECuX79n61zlQMN3ByQsWYyxjWjqSG/C/
 yNYlNtTeZdBHFqhN5t+gj3hKJTVRy02VAU4dwgILfXdANFKpcn3377yNKRA/3Oyn7Net
 SLtpLE8+tna0EOGP9reRYVQ9LJyfoI3urKe3l1e6foSIq+8rRf0g1mJzKwInyW/IT0dy
 8WxGWHFv98ufPk7xPXfVM5hmlsTrHE4xbupl82qPpMq5+PG8wf6w4M8CpcEC0OGFAYQC
 h0JeqGbeensrajEt9qduIAIADw4u0/AZrgeTK4oz+JxwDchpboj22sCcgLjYK5IAS7X+
 wOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378773; x=1692983573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m1beAKqAHv3vWel3I5O47E14cIOUPK0xwqCuArIxTEk=;
 b=EOK2/HKKHcWWdDFwTEHQJ8cN/vA89Vr5kF6IgnSj/13/C0DirfxeTVZ1rXahNQRCmK
 RMZe+XvqJ0UpHcn7PmCsj4pugL/y8NhxA6T1LUhCZf9ZvVodvigGWt1MYlZKyZ83wE8c
 o485YVMLSjh05U5KoUWk0ycYHbW2kfEdx5LzVpNaGe0ZGfDti3bR5jLufIz6ZMb5+PXq
 Pg/R4JuRV3aUC+5GPqvplN03ykvVMblQnoH6euZp9UY4wrIlVb+4wUH6+Wry5PW4UaFw
 Kk8U43NS/hmHSSXQW+NXds7+0zLmvwaQD2kGupNoD1lNrCWcO2I9x3j5LZqFZSqitFod
 /4qA==
X-Gm-Message-State: AOJu0Yy40/YVX/boM9Cl5KV2TSLA74N6UokeSQnxklJB0Ird9Xhg/W2L
 87Fap+9H81RyDhZYl5sZQIpzA2jrKtodMWR/+54=
X-Google-Smtp-Source: AGHT+IGLCNicyHv2XvIIua07UaPuLhxvojbzEBzwgVcElTiFdY9uwOITnub9IYaHDdxGB/J97MSWrg==
X-Received: by 2002:a17:902:c155:b0:1bf:728:7459 with SMTP id
 21-20020a170902c15500b001bf07287459mr3223402plj.63.1692378773259; 
 Fri, 18 Aug 2023 10:12:53 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/33] linux-user: Split out target_mmap__locked
Date: Fri, 18 Aug 2023 10:12:10 -0700
Message-Id: <20230818171227.141728-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

All "goto fail" may be transformed to "return -1".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 62 ++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 35f270ec2e..448f168df1 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -446,9 +446,9 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
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
@@ -456,30 +456,27 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
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
@@ -509,7 +506,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
-            goto fail;
+            return -1;
         }
     }
 
@@ -530,7 +527,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         struct stat sb;
 
         if (fstat(fd, &sb) == -1) {
-            goto fail;
+            return -1;
         }
 
         /* Are we trying to create a map beyond EOF?.  */
@@ -557,7 +554,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         p = mmap(g2h_untagged(start), host_len, host_prot,
                  flags | MAP_FIXED | MAP_ANONYMOUS, -1, 0);
         if (p == MAP_FAILED) {
-            goto fail;
+            return -1;
         }
         /* update start so that it points to the file position at 'offset' */
         host_start = (uintptr_t)p;
@@ -566,7 +563,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                      flags | MAP_FIXED, fd, host_offset);
             if (p == MAP_FAILED) {
                 munmap(g2h_untagged(start), host_len);
-                goto fail;
+                return -1;
             }
             host_start += offset - host_offset;
         }
@@ -577,7 +574,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
     } else {
         if (start & ~TARGET_PAGE_MASK) {
             errno = EINVAL;
-            goto fail;
+            return -1;
         }
         last = start + len - 1;
         real_last = ROUND_UP(last, host_page_size) - 1;
@@ -589,14 +586,14 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
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
@@ -627,17 +624,17 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
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
@@ -652,14 +649,14 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
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
@@ -669,7 +666,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             if (!mmap_frag(real_page, real_page, last,
                            target_prot, flags, fd,
                            offset + real_page - start)) {
-                goto fail;
+                return -1;
             }
             real_last -= host_page_size;
         }
@@ -695,7 +692,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                     munmap(p, len1);
                     errno = EEXIST;
                 }
-                goto fail;
+                return -1;
             }
             passthrough_start = real_start;
             passthrough_last = real_last;
@@ -728,11 +725,22 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
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
 
 static void mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
-- 
2.34.1


