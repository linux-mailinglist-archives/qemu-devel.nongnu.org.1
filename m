Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 779D782164F
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:03:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3m-0003kr-Aa; Mon, 01 Jan 2024 20:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3Z-0003eP-Gl
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:02 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3X-00074b-NB
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:01 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6dc018228b4so3062009a34.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160738; x=1704765538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qA2a/PTKZLcZg5cbX228JZnmG9F2Eb0mEU1DFgp6lOI=;
 b=tXc2OJRCBlQorvRvX/hn7/nUSOktcroMzwn7shw9Ag9QDegfsFDZL9vh7pP7BDY7c9
 eWkvxNHJwGNUEmNHcnsg4HTkQBsYMDYnuxj8ejlLAkdhyyCkfE3+5R+fLg7PU0kthK9p
 pHHI+CgX5sJa/qSONH7mzWCpXkX9p/l+m3iqCE0JhSwx3fLDAMkMUJhey0DN8o19n/8K
 75rGkVfBNqQwBT/r5xU+3GqNKjmr+vMoryFe5OKqDCMzPFuwGE30M50MqoedJkdAcpxg
 JJMKTATANwZ0BS4mTmZdS2HFQSwAagMwdzKkweq5Y28ERjRG5PnfTsRjSWnDpodXjr+6
 Szfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160738; x=1704765538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qA2a/PTKZLcZg5cbX228JZnmG9F2Eb0mEU1DFgp6lOI=;
 b=ltEru97ggWBl4JCiDGqeucl2+tdK3q1ukBpAR26kyLnI9k0VlFycTOPYi6jQrhTXm5
 zr24f47eCJbGYiIdb3BonG9BdYcF5+ktMfTsIN2CZ92daCnzgeHol9QDu6pq3kZLyMoQ
 iM3Cpa3RS+mULl1MwgcW7N1Mpwxf2c6IidGoxldjzm4BoQoo1yBrmQBj1ukfP06CJoxh
 mxff6yj122w6Sdutg1mCqsTG7ERwOGn6Z8yYCEvACUhC4k/EzEG9/F6JUXYo2ODvlam6
 H3aMMakjoOb76QsolGhJFniqfJcfVdSjmhRDudqjGJfAWljWCcW5k4j6fagw/xt6GX/H
 ZmYw==
X-Gm-Message-State: AOJu0YwAi/PH4bFFRHXunPr82S96hvvz7zpHYlE3oP6ZxiJqK5OQftqK
 pZFJXQgvtJ1kHggVN++dugSGn3rMRpSqs0qiExkgMa4moe0=
X-Google-Smtp-Source: AGHT+IEW1aa2hupVZ45dmHHnSO+I1c8E6HwKME+OmDikxt4hfGmRSgxV5JyDWtKG4MkAZT/WaX4KcQ==
X-Received: by 2002:a05:6808:238e:b0:3bb:e1bb:3546 with SMTP id
 bp14-20020a056808238e00b003bbe1bb3546mr6643355oib.44.1704160738363; 
 Mon, 01 Jan 2024 17:58:58 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 22/33] linux-user: Split out mmap_h_lt_g
Date: Tue,  2 Jan 2024 12:57:57 +1100
Message-Id: <20240102015808.132373-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

Work much harder to get alignment and mapping beyond the end
of the file correct.  Both of which are excercised by our
test-mmap for alpha (8k pages) on any 4k page host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 156 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 125 insertions(+), 31 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 00003b8329..8b0a26e50d 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -552,6 +552,128 @@ static abi_long mmap_h_eq_g(abi_ulong start, abi_ulong len,
     return mmap_end(start, last, start, last, flags, page_flags);
 }
 
+/*
+ * Special case host page size < target page size.
+ *
+ * The two special cases are increased guest alignment, and mapping
+ * past the end of a file.
+ *
+ * When mapping files into a memory area larger than the file,
+ * accesses to pages beyond the file size will cause a SIGBUS.
+ *
+ * For example, if mmaping a file of 100 bytes on a host with 4K
+ * pages emulating a target with 8K pages, the target expects to
+ * be able to access the first 8K. But the host will trap us on
+ * any access beyond 4K.
+ *
+ * When emulating a target with a larger page-size than the hosts,
+ * we may need to truncate file maps at EOF and add extra anonymous
+ * pages up to the targets page boundary.
+ *
+ * This workaround only works for files that do not change.
+ * If the file is later extended (e.g. ftruncate), the SIGBUS
+ * vanishes and the proper behaviour is that changes within the
+ * anon page should be reflected in the file.
+ *
+ * However, this case is rather common with executable images,
+ * so the workaround is important for even trivial tests, whereas
+ * the mmap of of a file being extended is less common.
+ */
+static abi_long mmap_h_lt_g(abi_ulong start, abi_ulong len, int host_prot,
+                            int mmap_flags, int page_flags, int fd,
+                            off_t offset, int host_page_size)
+{
+    void *p, *want_p = g2h_untagged(start);
+    off_t fileend_adj = 0;
+    int flags = mmap_flags;
+    abi_ulong last, pass_last;
+
+    if (!(flags & MAP_ANONYMOUS)) {
+        struct stat sb;
+
+        if (fstat(fd, &sb) == -1) {
+            return -1;
+        }
+        if (offset >= sb.st_size) {
+            /*
+             * The entire map is beyond the end of the file.
+             * Transform it to an anonymous mapping.
+             */
+            flags |= MAP_ANONYMOUS;
+            fd = -1;
+            offset = 0;
+        } else if (offset + len > sb.st_size) {
+            /*
+             * A portion of the map is beyond the end of the file.
+             * Truncate the file portion of the allocation.
+             */
+            fileend_adj = offset + len - sb.st_size;
+        }
+    }
+
+    if (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE)) {
+        if (fileend_adj) {
+            p = mmap(want_p, len, host_prot, flags | MAP_ANONYMOUS, -1, 0);
+        } else {
+            p = mmap(want_p, len, host_prot, flags, fd, offset);
+        }
+        if (p != want_p) {
+            if (p != MAP_FAILED) {
+                munmap(p, len);
+                errno = EEXIST;
+            }
+            return -1;
+        }
+
+        if (fileend_adj) {
+            void *t = mmap(p, len - fileend_adj, host_prot,
+                           (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED,
+                           fd, offset);
+            assert(t != MAP_FAILED);
+        }
+    } else {
+        size_t host_len, part_len;
+
+        /*
+         * Take care to align the host memory.  Perform a larger anonymous
+         * allocation and extract the aligned portion.  Remap the file on
+         * top of that.
+         */
+        host_len = len + TARGET_PAGE_SIZE - host_page_size;
+        p = mmap(want_p, host_len, host_prot, flags | MAP_ANONYMOUS, -1, 0);
+        if (p == MAP_FAILED) {
+            return -1;
+        }
+
+        part_len = (uintptr_t)p & (TARGET_PAGE_SIZE - 1);
+        if (part_len) {
+            part_len = TARGET_PAGE_SIZE - part_len;
+            munmap(p, part_len);
+            p += part_len;
+            host_len -= part_len;
+        }
+        if (len < host_len) {
+            munmap(p + len, host_len - len);
+        }
+
+        if (!(flags & MAP_ANONYMOUS)) {
+            void *t = mmap(p, len - fileend_adj, host_prot,
+                           flags | MAP_FIXED, fd, offset);
+            assert(t != MAP_FAILED);
+        }
+
+        start = h2g(p);
+    }
+
+    last = start + len - 1;
+    if (fileend_adj) {
+        pass_last = ROUND_UP(last - fileend_adj, host_page_size) - 1;
+    } else {
+        pass_last = last;
+    }
+    return mmap_end(start, last, start, pass_last, mmap_flags, page_flags);
+}
+
 static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                                     int target_prot, int flags, int page_flags,
                                     int fd, off_t offset)
@@ -596,37 +718,9 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
     if (host_page_size == TARGET_PAGE_SIZE) {
         return mmap_h_eq_g(start, len, host_prot, flags,
                            page_flags, fd, offset);
-    }
-
-    /*
-     * When mapping files into a memory area larger than the file, accesses
-     * to pages beyond the file size will cause a SIGBUS.
-     *
-     * For example, if mmaping a file of 100 bytes on a host with 4K pages
-     * emulating a target with 8K pages, the target expects to be able to
-     * access the first 8K. But the host will trap us on any access beyond
-     * 4K.
-     *
-     * When emulating a target with a larger page-size than the hosts, we
-     * may need to truncate file maps at EOF and add extra anonymous pages
-     * up to the targets page boundary.
-     */
-    if (host_page_size < TARGET_PAGE_SIZE && !(flags & MAP_ANONYMOUS)) {
-        struct stat sb;
-
-        if (fstat(fd, &sb) == -1) {
-            return -1;
-        }
-
-        /* Are we trying to create a map beyond EOF?.  */
-        if (offset + len > sb.st_size) {
-            /*
-             * If so, truncate the file map at eof aligned with
-             * the hosts real pagesize. Additional anonymous maps
-             * will be created beyond EOF.
-             */
-            len = ROUND_UP(sb.st_size - offset, host_page_size);
-        }
+    } else if (host_page_size < TARGET_PAGE_SIZE) {
+        return mmap_h_lt_g(start, len, host_prot, flags,
+                           page_flags, fd, offset, host_page_size);
     }
 
     if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
-- 
2.34.1


