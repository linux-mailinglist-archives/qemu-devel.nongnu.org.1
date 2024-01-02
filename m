Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8C882163C
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:00:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3i-0003h0-Nv; Mon, 01 Jan 2024 20:59:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3X-0003ca-V1
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:59 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3V-00074J-P8
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:59 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-28c467446f0so3839128a91.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160736; x=1704765536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Agx2bj5+PO3H0m/DZ+WXfvcf7Vu2LJVqySA/YVtXeLI=;
 b=MJ21oOH6KOGyz7Jwk2LdJrOs+delovfo2tJApoUL7RsNSLn0oEohvF4s4Wzm30E9Rn
 UHSCRBmbGYSaDPpOo4cYUi9DaDoQYCPfuXAFURFeKwpFBtwYQx9HV3Hn5UhGfVp/WN4g
 boiSXGmYkBIKTtwXqEHJI3TJaYLWEvfq3tv3PZb6NTtWMRAIsMiNPmv2wlzUKgzF0d+S
 XlE4M6XbXjUOzKsZrElWbHOS79ePgpO8+lGZ4/2RKoJxSLOb94pKsZ18/eVYFv3KgtTv
 PSCA1Nhjj6sD8bHGyrMhkha5rCopwcI9GtPtX3OZVDjV2abfmjdivJMxyrB/RpKRLk77
 GXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160736; x=1704765536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Agx2bj5+PO3H0m/DZ+WXfvcf7Vu2LJVqySA/YVtXeLI=;
 b=YnvpT7Hlz9kqXyLhnEHVwSV74/2QzIFfcmWDAGdW/guUL+Jtap757nsw/Eve3OsQDd
 zYf0Dnzno+mmQOo/Rdpzmlz0sWq/rHc0fksgt3OhNMoJFIn/cZSYyBzLywuy1jRrLfca
 dKZ8an1+9bWIfCCawvN1G+xrs/q0MMFAcDiTmBH+hgj1EL05mUdckSzT5LUg6DdIbfCt
 Vo60RYjjJCLuizC9wUyqoAUPZ6uxSuhSdP+cyqQ53RmDyzVnJZ8/uaaZHNh48RQr7V66
 5MGrekkVr0gEmjzhibk4Qs8f8OhTOQAASt30grjbF1ZZHD2SgJkLnXe9PxLoJ3SdZAva
 Tdyg==
X-Gm-Message-State: AOJu0YxfKThpOcUOd+TuassZHMfpYa3wVzY3UoNznDTHO9OgpTLL1kSc
 RnG/nRg0/IKf0OZ7wWzXOJe2E94m0Wry96Y8O3on/4gD944=
X-Google-Smtp-Source: AGHT+IG0p43Jz7zHHpmdcqtX8fOuBNtEIX5Rnnjmqh7KeozxvvemLvLDx1OOogkoVU1ieh9wp+qYnw==
X-Received: by 2002:a17:90a:de04:b0:28b:bd9d:8d50 with SMTP id
 m4-20020a17090ade0400b0028bbd9d8d50mr19527276pjv.13.1704160736445; 
 Mon, 01 Jan 2024 17:58:56 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 21/33] linux-user: Split out mmap_h_eq_g
Date: Tue,  2 Jan 2024 12:57:56 +1100
Message-Id: <20240102015808.132373-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Move the MAX_FIXED_NOREPLACE check for reserved_va earlier.
Move the computation of host_prot earlier.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 66 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 13 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 42eb3eb2b4..00003b8329 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -527,6 +527,31 @@ static abi_long mmap_end(abi_ulong start, abi_ulong last,
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
@@ -535,6 +560,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
     abi_ulong ret, last, real_start, real_last, retaddr, host_len;
     abi_ulong passthrough_start = -1, passthrough_last = 0;
     off_t host_offset;
+    int host_prot;
 
     real_start = start & -host_page_size;
     host_offset = offset & -host_page_size;
@@ -543,16 +569,33 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
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
@@ -588,12 +631,10 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
 
     if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         uintptr_t host_start;
-        int host_prot;
         void *p;
 
         host_len = len + offset - host_offset;
         host_len = ROUND_UP(host_len, host_page_size);
-        host_prot = target_to_host_prot(target_prot);
 
         /* Note: we prefer to control the mapping address. */
         p = mmap(g2h_untagged(start), host_len, host_prot,
@@ -716,8 +757,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
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


