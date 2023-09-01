Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 464FA78F707
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:25:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtpK-0006fZ-Eh; Thu, 31 Aug 2023 22:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpJ-0006f5-5F
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:01 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpB-0001S5-5P
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:55 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68a6f6a66e1so1239917b3a.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535031; x=1694139831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NJQTkGtLKBIQbaCTGpYdZiGcCYcEb9NdqL6VTgxKtpE=;
 b=pT6W9LoHthTn0XoVvEcPFLkVicaYz1Y/EeXjvGuY2Kh9ICh3ha/hgZcYSgLiMzCk62
 SRPpD3ni038XnNK2GFFN32xv7o27O2J9SUSvY3X6xinPj2N7S2RWyBqJMev9Y6HB5RLV
 4GSkwvvX7gz7Z7SwZlmi7UCSqDfoZbJE4R8ExLtKHTbNIdsWX2/au7sGDEMYc1YHpwwd
 fJ0S57GzXXwPoy1yzoDy8OPkx3mqesRNN7s5pmmMa40co+Oep3ERJamMdhdSDKLK6OBp
 iswQlny5whkVC0cxPTndetJdl9eo+AWP3DlyfPeO8+42CrXsmwhG7m67i++84puQQ4jI
 /fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535031; x=1694139831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NJQTkGtLKBIQbaCTGpYdZiGcCYcEb9NdqL6VTgxKtpE=;
 b=EaaOLJkM3IcDvE2umtyUZvHgjbEbVSsKstSmpvVUIn876EXxpMZMzrksxai6HWWa0k
 cncGTP8HYBZJers+5chRFgllp636JGG3RssGdSpPdy3tChcCwA1WhyRfyYxtBXyx8h4m
 sXsT9Z86qftz9r+eSGkeOEh/+kmbF3c0UL1zIzmg5LJ3plNYDJDaB2YpAkZpOCqwWHi4
 5yfLeWPgwr+96fQkpB9LgDqsfsvy3BWVufRhPPcd6b/Vr7zoOD2D3PUUVrXWrT84r1u1
 0wy60uZTnv8mdsFQ9eqtLGA9WuTVdN0G93Ae5LwdiIvioBCNM1hRSnmFeIhuGWWSfx8b
 f6aw==
X-Gm-Message-State: AOJu0YwrFZXBA8B14GlDUB5kkGHIqQ2CAUsyO+8hXzmcE1ir3KTeJ9F+
 p5stEzwhXznK7/lLwlfJ/8odp3Y1pE68ZbdxTeA=
X-Google-Smtp-Source: AGHT+IE8yxLNRwi/uKzUS1y9gG+l2LMaGb2Lro2xmgBcfu9nBNqfrHwmcn0apPXIYhDVuCGhhXNzIQ==
X-Received: by 2002:a05:6a00:234c:b0:68b:c1a2:abca with SMTP id
 j12-20020a056a00234c00b0068bc1a2abcamr1509159pfj.14.1693535031578; 
 Thu, 31 Aug 2023 19:23:51 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 23/33] linux-user: Split out mmap_h_gt_g
Date: Thu, 31 Aug 2023 19:23:21 -0700
Message-Id: <20230901022331.115247-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 288 ++++++++++++++++++++++------------------------
 1 file changed, 139 insertions(+), 149 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index ed82b4bb75..6ab2f35e6f 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -223,7 +223,16 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
     return ret;
 }
 
-/* map an incomplete host page */
+/*
+ * Map an incomplete host page.
+ *
+ * Here be dragons.  This case will not work if there is an existing
+ * overlapping host page, which is file mapped, and for which the mapping
+ * is beyond the end of the file.  In that case, we will see SIGBUS when
+ * trying to write a portion of this page.
+ *
+ * FIXME: Work around this with a temporary signal handler and longjmp.
+ */
 static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
                       int prot, int flags, int fd, off_t offset)
 {
@@ -629,19 +638,138 @@ static abi_long mmap_h_lt_g(abi_ulong start, abi_ulong len, int host_prot,
     return mmap_end(start, last, start, pass_last, mmap_flags, page_flags);
 }
 
+/*
+ * Special case host page size > target page size.
+ *
+ * The two special cases are address and file offsets that are valid
+ * for the guest that cannot be directly represented by the host.
+ */
+static abi_long mmap_h_gt_g(abi_ulong start, abi_ulong len,
+                            int target_prot, int host_prot,
+                            int flags, int page_flags, int fd,
+                            off_t offset, int host_page_size)
+{
+    void *p, *want_p = g2h_untagged(start);
+    off_t host_offset = offset & -host_page_size;
+    abi_ulong last, real_start, real_last;
+    bool misaligned_offset = false;
+    size_t host_len;
+
+    if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
+        /*
+         * Adjust the offset to something representable on the host.
+         */
+        host_len = len + offset - host_offset;
+        p = mmap(want_p, host_len, host_prot, flags, fd, host_offset);
+        if (p == MAP_FAILED) {
+            return -1;
+        }
+
+        /* Update start to the file position at offset. */
+        p += offset - host_offset;
+
+        start = h2g(p);
+        last = start + len - 1;
+        return mmap_end(start, last, start, last, flags, page_flags);
+    }
+
+    if (!(flags & MAP_ANONYMOUS)) {
+        misaligned_offset = (start ^ offset) & (host_page_size - 1);
+
+        /*
+         * The fallback for misalignment is a private mapping + read.
+         * This carries none of semantics required of MAP_SHARED.
+         */
+        if (misaligned_offset && (flags & MAP_TYPE) != MAP_PRIVATE) {
+            errno = EINVAL;
+            return -1;
+        }
+    }
+
+    last = start + len - 1;
+    real_start = start & -host_page_size;
+    real_last = ROUND_UP(last, host_page_size) - 1;
+
+    /*
+     * Handle the start and end of the mapping.
+     */
+    if (real_start < start) {
+        abi_ulong real_page_last = real_start + host_page_size - 1;
+        if (last <= real_page_last) {
+            /* Entire allocation a subset of one host page. */
+            if (!mmap_frag(real_start, start, last, target_prot,
+                           flags, fd, offset)) {
+                return -1;
+            }
+            return mmap_end(start, last, -1, 0, flags, page_flags);
+        }
+
+        if (!mmap_frag(real_start, start, real_page_last, target_prot,
+                       flags, fd, offset)) {
+            return -1;
+        }
+        real_start = real_page_last + 1;
+    }
+
+    if (last < real_last) {
+        abi_ulong real_page_start = real_last - host_page_size + 1;
+        if (!mmap_frag(real_page_start, real_page_start, last,
+                       target_prot, flags, fd,
+                       offset + real_page_start - start)) {
+            return -1;
+        }
+        real_last = real_page_start - 1;
+    }
+
+    if (real_start > real_last) {
+        return mmap_end(start, last, -1, 0, flags, page_flags);
+    }
+
+    /*
+     * Handle the middle of the mapping.
+     */
+
+    host_len = real_last - real_start + 1;
+    want_p += real_start - start;
+
+    if (flags & MAP_ANONYMOUS) {
+        p = mmap(want_p, host_len, host_prot, flags, -1, 0);
+    } else if (!misaligned_offset) {
+        p = mmap(want_p, host_len, host_prot, flags, fd,
+                 offset + real_start - start);
+    } else {
+        p = mmap(want_p, host_len, host_prot | PROT_WRITE,
+                 flags | MAP_ANONYMOUS, -1, 0);
+    }
+    if (p != want_p) {
+        if (p != MAP_FAILED) {
+            munmap(p, host_len);
+            errno = EEXIST;
+        }
+        return -1;
+    }
+
+    if (misaligned_offset) {
+        /* TODO: The read could be short. */
+        if (pread(fd, p, host_len, offset + real_start - start) != host_len) {
+            munmap(p, host_len);
+            return -1;
+        }
+        if (!(host_prot & PROT_WRITE)) {
+            mprotect(p, host_len, host_prot);
+        }
+    }
+
+    return mmap_end(start, last, -1, 0, flags, page_flags);
+}
+
 static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                                     int target_prot, int flags, int page_flags,
                                     int fd, off_t offset)
 {
     int host_page_size = qemu_real_host_page_size();
-    abi_ulong ret, last, real_start, real_last, retaddr, host_len;
-    abi_ulong passthrough_start = -1, passthrough_last = 0;
-    off_t host_offset;
     int host_prot;
 
-    real_start = start & -host_page_size;
-    host_offset = offset & -host_page_size;
-
     /*
      * For reserved_va, we are in full control of the allocation.
      * Find a suitible hole and convert to MAP_FIXED.
@@ -655,6 +783,8 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
             }
             flags = (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED;
         } else if (!(flags & MAP_FIXED)) {
+            abi_ulong real_start = start & -host_page_size;
+            off_t host_offset = offset & -host_page_size;
             size_t real_len = len + offset - host_offset;
             abi_ulong align = MAX(host_page_size, TARGET_PAGE_SIZE);
 
@@ -676,150 +806,10 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
     } else if (host_page_size < TARGET_PAGE_SIZE) {
         return mmap_h_lt_g(start, len, host_prot, flags,
                            page_flags, fd, offset, host_page_size);
-    }
-
-    if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
-        uintptr_t host_start;
-        void *p;
-
-        host_len = len + offset - host_offset;
-        host_len = ROUND_UP(host_len, host_page_size);
-
-        /* Note: we prefer to control the mapping address. */
-        p = mmap(g2h_untagged(start), host_len, host_prot,
-                 flags | MAP_FIXED | MAP_ANONYMOUS, -1, 0);
-        if (p == MAP_FAILED) {
-            return -1;
-        }
-        /* update start so that it points to the file position at 'offset' */
-        host_start = (uintptr_t)p;
-        if (!(flags & MAP_ANONYMOUS)) {
-            p = mmap(g2h_untagged(start), len, host_prot,
-                     flags | MAP_FIXED, fd, host_offset);
-            if (p == MAP_FAILED) {
-                munmap(g2h_untagged(start), host_len);
-                return -1;
-            }
-            host_start += offset - host_offset;
-        }
-        start = h2g(host_start);
-        last = start + len - 1;
-        passthrough_start = start;
-        passthrough_last = last;
     } else {
-        last = start + len - 1;
-        real_last = ROUND_UP(last, host_page_size) - 1;
-
-        if (flags & MAP_FIXED_NOREPLACE) {
-            /* Validate that the chosen range is empty. */
-            if (!page_check_range_empty(start, last)) {
-                errno = EEXIST;
-                return -1;
-            }
-
-            /*
-             * With reserved_va, the entire address space is mmaped in the
-             * host to ensure it isn't accidentally used for something else.
-             * We have just checked that the guest address is not mapped
-             * within the guest, but need to replace the host reservation.
-             *
-             * Without reserved_va, despite the guest address check above,
-             * keep MAP_FIXED_NOREPLACE so that the guest does not overwrite
-             * any host address mappings.
-             */
-            if (reserved_va) {
-                flags = (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED;
-            }
-        }
-
-        /*
-         * worst case: we cannot map the file because the offset is not
-         * aligned, so we read it
-         */
-        if (!(flags & MAP_ANONYMOUS) &&
-            (offset & (host_page_size - 1)) != (start & (host_page_size - 1))) {
-            /*
-             * msync() won't work here, so we return an error if write is
-             * possible while it is a shared mapping
-             */
-            if ((flags & MAP_TYPE) == MAP_SHARED
-                && (target_prot & PROT_WRITE)) {
-                errno = EINVAL;
-                return -1;
-            }
-            retaddr = target_mmap(start, len, target_prot | PROT_WRITE,
-                                  (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))
-                                  | MAP_PRIVATE | MAP_ANONYMOUS,
-                                  -1, 0);
-            if (retaddr == -1) {
-                return -1;
-            }
-            if (pread(fd, g2h_untagged(start), len, offset) == -1) {
-                return -1;
-            }
-            if (!(target_prot & PROT_WRITE)) {
-                ret = target_mprotect(start, len, target_prot);
-                assert(ret == 0);
-            }
-            return mmap_end(start, last, -1, 0, flags, page_flags);
-        }
-
-        /* handle the start of the mapping */
-        if (start > real_start) {
-            if (real_last == real_start + host_page_size - 1) {
-                /* one single host page */
-                if (!mmap_frag(real_start, start, last,
-                               target_prot, flags, fd, offset)) {
-                    return -1;
-                }
-                return mmap_end(start, last, -1, 0, flags, page_flags);
-            }
-            if (!mmap_frag(real_start, start,
-                           real_start + host_page_size - 1,
-                           target_prot, flags, fd, offset)) {
-                return -1;
-            }
-            real_start += host_page_size;
-        }
-        /* handle the end of the mapping */
-        if (last < real_last) {
-            abi_ulong real_page = real_last - host_page_size + 1;
-            if (!mmap_frag(real_page, real_page, last,
-                           target_prot, flags, fd,
-                           offset + real_page - start)) {
-                return -1;
-            }
-            real_last -= host_page_size;
-        }
-
-        /* map the middle (easier) */
-        if (real_start < real_last) {
-            void *p, *want_p;
-            off_t offset1;
-            size_t len1;
-
-            if (flags & MAP_ANONYMOUS) {
-                offset1 = 0;
-            } else {
-                offset1 = offset + real_start - start;
-            }
-            len1 = real_last - real_start + 1;
-            want_p = g2h_untagged(real_start);
-
-            p = mmap(want_p, len1, host_prot, flags, fd, offset1);
-            if (p != want_p) {
-                if (p != MAP_FAILED) {
-                    munmap(p, len1);
-                    errno = EEXIST;
-                }
-                return -1;
-            }
-            passthrough_start = real_start;
-            passthrough_last = real_last;
-        }
+        return mmap_h_gt_g(start, len, target_prot, host_prot, flags,
+                           page_flags, fd, offset, host_page_size);
     }
-    return mmap_end(start, last, passthrough_start, passthrough_last,
-                    flags, page_flags);
 }
 
 /* NOTE: all the constants are the HOST ones */
-- 
2.34.1


