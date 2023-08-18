Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3D5781172
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:16:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX322-0008M4-U5; Fri, 18 Aug 2023 13:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31y-0008IW-5U
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:02 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31u-000848-DK
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:01 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bc73a2b0easo9421905ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378777; x=1692983577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ySu5X2pwP/FjpufFI3frCgcVNyTN0K5y3i0eNXjPfK8=;
 b=ecJDup/XEPfibIvZ2A8m964UBWDcwzIeCtPZHvZ8OJv+eXTm0riS3yR+jiqZVBjHds
 4xtPO/MGWMjLtxSEUUOWjv/VqgTLZzlE57c3qGrnA5a+ql5n2qlUWpts2PA39ysi3Fr0
 +5DI5OWiBl4gdcFqt32djc/eYy/CYYQBwcmyP9Xj27ssh4rGTyrVAr+eQsfm1VpWFRJ4
 Q0BtVy5alvUwM3E26llm4vpYJfMlMLiiEtN8N9Y3OEQhYHXp38vX6YYKkvtJKO8ZaMcZ
 AuQqAR2uLbmFfuAypzIStza0Y8TDIcIRB9GnQQT22Bs0odMZgPjPdERCK9+1/7i+hXrj
 NyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378777; x=1692983577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ySu5X2pwP/FjpufFI3frCgcVNyTN0K5y3i0eNXjPfK8=;
 b=RH77LztNnSz20HvFyWUTnx3c8dUqKvfBwWrGviF5GZO0UpI7KKh1oMKc8XKU88PxGi
 kbYfUyXqhwDDQ7Bn21y5L2uY7anbTIUUWPUajw1W2oKMlH1i9sQ882cQEB5YKD3hSndO
 iT6frXgfjrIX/6xv+ul/M43/13Nrl3xIoga6FTkcQIsaxH3WwYDr7JdstF1B5up2b+8N
 LZR+PQfCmv8/HkLCgQqRoDgxHEKphxApLOrD8rJ81GW5CCqb/oXGh8LMsXfl+ecb349s
 6GVclmGwtSZtekWfdjr0EP5WrTPun9Xs5kw+OIGEwZg1G/Qc87iVwgCpIGcX81TbY/vD
 XZBQ==
X-Gm-Message-State: AOJu0YzAv75R6058KBV0jf/YNoreb+Tqw6n1obzACvrLnvSbTVwSlpfm
 I+Fr/cffE52HupnnztJuih4/ydof6cQZf6/ImC4=
X-Google-Smtp-Source: AGHT+IFcwL5prOinwOCTcvRaHcbOB3K0YinwdeksGUy6I+FfHw0b8DGWwuU7aZ3Ooy2if+zOQ1KyzQ==
X-Received: by 2002:a17:902:748a:b0:1bd:e64c:5c70 with SMTP id
 h10-20020a170902748a00b001bde64c5c70mr3348825pll.7.1692378777054; 
 Fri, 18 Aug 2023 10:12:57 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/33] linux-user: Split out mmap_h_eq_g
Date: Fri, 18 Aug 2023 10:12:15 -0700
Message-Id: <20230818171227.141728-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Move the MAX_FIXED_NOREPLACE check for reserved_va earlier.
Move the computation of host_prot earlier.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 66 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 13 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 7d482df06d..7a0c0c1f35 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -482,6 +482,31 @@ static abi_long mmap_end(abi_ulong start, abi_ulong last,
     return start;
 }
 
+/*
+ * Special case host page size == target page size,
+ * where there are no edge conditions.
+ */
+static abi_long mmap_h_eq_g(abi_ulong start, abi_ulong len,
+                            int host_prot, int flags, int page_flags,
+                            int fd, off_t offset)
+{
+    void *p, *want_p = g2h_untagged(start);
+    abi_ulong last;
+
+    p = mmap(want_p, len, host_prot, flags, fd, offset);
+    if (p == MAP_FAILED) {
+        return -1;
+    }
+    if ((flags & MAP_FIXED_NOREPLACE) && p != want_p) {
+        errno = EEXIST;
+        return -1;
+    }
+
+    start = h2g(p);
+    last = start + len - 1;
+    return mmap_end(start, last, start, last, flags, page_flags);
+}
+
 static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                                     int target_prot, int flags, int page_flags,
                                     int fd, off_t offset)
@@ -490,6 +515,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
     abi_ulong ret, last, real_start, real_last, retaddr, host_len;
     abi_ulong passthrough_start = -1, passthrough_last = 0;
     off_t host_offset;
+    int host_prot;
 
     real_start = start & -host_page_size;
     host_offset = offset & -host_page_size;
@@ -498,16 +524,33 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
      * For reserved_va, we are in full control of the allocation.
      * Find a suitible hole and convert to MAP_FIXED.
      */
-    if (reserved_va && !(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
-        host_len = len + offset - host_offset;
-        start = mmap_find_vma(real_start, host_len,
-                              MAX(host_page_size, TARGET_PAGE_SIZE));
-        if (start == (abi_ulong)-1) {
-            errno = ENOMEM;
-            return -1;
+    if (reserved_va) {
+        if (flags & MAP_FIXED_NOREPLACE) {
+            /* Validate that the chosen range is empty. */
+            if (!page_check_range_empty(start, start + len - 1)) {
+                errno = EEXIST;
+                return -1;
+            }
+            flags = (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED;
+        } else if (!(flags & MAP_FIXED)) {
+            size_t real_len = len + offset - host_offset;
+            abi_ulong align = MAX(host_page_size, TARGET_PAGE_SIZE);
+
+            start = mmap_find_vma(real_start, real_len, align);
+            if (start == (abi_ulong)-1) {
+                errno = ENOMEM;
+                return -1;
+            }
+            start += offset - host_offset;
+            flags |= MAP_FIXED;
         }
-        start += offset - host_offset;
-        flags |= MAP_FIXED;
+    }
+
+    host_prot = target_to_host_prot(target_prot);
+
+    if (host_page_size == TARGET_PAGE_SIZE) {
+        return mmap_h_eq_g(start, len, host_prot, flags,
+                           page_flags, fd, offset);
     }
 
     /*
@@ -543,12 +586,10 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
 
     if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         uintptr_t host_start;
-        int host_prot;
         void *p;
 
         host_len = len + offset - host_offset;
         host_len = ROUND_UP(host_len, host_page_size);
-        host_prot = target_to_host_prot(target_prot);
 
         /* Note: we prefer to control the mapping address. */
         p = mmap(g2h_untagged(start), host_len, host_prot,
@@ -671,8 +712,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
             len1 = real_last - real_start + 1;
             want_p = g2h_untagged(real_start);
 
-            p = mmap(want_p, len1, target_to_host_prot(target_prot),
-                     flags, fd, offset1);
+            p = mmap(want_p, len1, host_prot, flags, fd, offset1);
             if (p != want_p) {
                 if (p != MAP_FAILED) {
                     munmap(p, len1);
-- 
2.34.1


