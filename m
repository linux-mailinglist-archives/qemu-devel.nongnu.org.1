Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80630781175
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:17:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX324-0008OF-Is; Fri, 18 Aug 2023 13:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31y-0008Ia-Ff
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:02 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31v-00085c-Vl
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:02 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bc5acc627dso8833235ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378778; x=1692983578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4bucLpoT0vquWNBuZLTOreK2BOdVySJCazC6PuHo6Rk=;
 b=ZCaWLtRO9P1T02CRbutzXY9rxnMJeCP+gcQYTIlQbzksZxPQ5uAlTAM8qNJYJxCrJ8
 NjdBD+9uoXPzKys9Y988CJBKSzAGXXBD/4hjSca1dvGuaN2Jk1ufUL33GHIildsTboZa
 zzr3xqwDHpS99S7D7TqWXakLZpogXy7xyHtA5Xa/mis8QgpOoCpmN6JQcAD4ZYUCQ5p0
 +UpZj5uBrSxxTAZRnOK7P97jcDKlbhNaKy3n9ZcjpHzxfXZKSCucZy5b4JXxt+O19JGg
 0YG/ZoYNl3nFJZJKzETU18FVMu1/ibX0NILDX6GHuC0S4oIsVupBJXrSEtYmSTy2Gq3W
 mU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378778; x=1692983578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4bucLpoT0vquWNBuZLTOreK2BOdVySJCazC6PuHo6Rk=;
 b=FX1L4QAc58E/Qjf9i6diteHaHzxtwT/OUMGfWjA+2FTMr4ilviDwe4Ssw3uYD5I7wC
 hdFsIu0L2mXUTgIF4B9D4/HXTdJ40AYjWuR0fwS/tFfcAo8mVpwZ9Xo/ZJ1uXtt6rSmM
 vtvh9b4aRorpfZjoCay7BOfaWbrZh4ZeMGGZsqZDVSXvSe5m4wrn8nQJLw/SZSzjUizV
 /NuFQ0tr6fDIGnYfULlBi6cAOa5o7B07T+DBL50D+erMn3e5DLQpAPJsu/EIcA9flxlI
 dvwC/uleX9FDsL1Z6qCChHowhQ8pcCVl4Bjv0HXT9HNiItsvah36Tj+WVKU1s0HZkFVN
 GLBQ==
X-Gm-Message-State: AOJu0YyQB5cWpUxakAM6wKh0XLquMMMVtyA/TLc1+m1zC0RrJD99jdNn
 aYLz5ZiKpt41XUHFbH/rmaqJpCxs5/YoLDJ2VMk=
X-Google-Smtp-Source: AGHT+IEOCKiEdWh9MM8pSPwClp6zkNKJiMyZfJqQAMWicYtlYSZ2NtORHve9AuxRrJ0A1PElWGJybA==
X-Received: by 2002:a17:902:c3d1:b0:1bd:ba57:5a8f with SMTP id
 j17-20020a170902c3d100b001bdba575a8fmr3161386plj.13.1692378777771; 
 Fri, 18 Aug 2023 10:12:57 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/33] linux-user: Split out mmap_h_lt_g
Date: Fri, 18 Aug 2023 10:12:16 -0700
Message-Id: <20230818171227.141728-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Work much harder to get alignment and mapping beyond the end
of the file correct.  Both of which are excercised by our
test-mmap for alpha (8k pages) on any 4k page host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 156 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 125 insertions(+), 31 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 7a0c0c1f35..ed82b4bb75 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -507,6 +507,128 @@ static abi_long mmap_h_eq_g(abi_ulong start, abi_ulong len,
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
@@ -551,37 +673,9 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
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


