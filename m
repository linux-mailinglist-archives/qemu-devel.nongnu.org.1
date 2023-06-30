Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB6C743C9D
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:23:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4l-0007gV-72; Fri, 30 Jun 2023 09:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4i-0007e3-N4
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4g-0003QI-Lb
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:12 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8deso23133705e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131329; x=1690723329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OUAuwo10Yq9+V7BF7q6x9M7fE+x9XcbokQqcquvrZKI=;
 b=eAC6/hdTA7Sv2mmgrlVtc6HyUyPZfJ5unK1MCQ6VAcuz8B7W6IQ3UuZvjCWtIh0GPB
 LyafnR4HqDn/cvNKrbsCRBw8b7QnDpmwbPLg9DtpRx0e7RV830nhx3cDKyYRlwa88Hau
 hXg+tV2vmNJS5GkVmJS4Axdwf707B8c5T0qp+5UxXobIwlnp2OA4OaA3a19DW+McRxm9
 AbZA0RGCbLFKM3GDisBgeuI3UJAToDPesLg31cKn0s5Jnq/MOUMkIxF/l5LaMXj9yPRi
 ElVXBKxchgFimnrgcR59ShZt9CRMtxEKxZjveUvRzNt8lrvzok7OSCuto9P8+jhA0SCG
 3OCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131329; x=1690723329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OUAuwo10Yq9+V7BF7q6x9M7fE+x9XcbokQqcquvrZKI=;
 b=gD2oAtiU2SfHiGGVl+36XmDMDAjWB3+Rcm23trnzbp10Tv4/DzT1JJ3KBBfKNnA9gg
 heVN0+6UEzmodaSKu6DlfFVWQKgxjKgzi2CT24OWvWqp9iJQ6e1Q9YYHlmueKqPklCsd
 LV9Enrp8aOOaJ2Z5qkB7A0L4gaKaAq1kMbPI049wlXsezRF5W6u3hRPatn8pXZK3moaZ
 x6Zek9m0thQKiisXIbD5vOXLbCVTuAnhtGCza4N+f3ZbFZgAJrhP6GBuByKo/OxjCkdb
 VJiIE6jGNgJFykVvE0WhyAcTqxmoRnzm1kFZ+Ak9lx1wpQ+BvGOO0ADh428Zth2f2vYY
 iysA==
X-Gm-Message-State: ABy/qLZaYYD15orH+ou6lgfsDqfGca4VOEp1KXr6mtDuXbGx+tqeZ+6U
 fM8FIO10OY2D6FMaM5rMTFIo8P/Zx4FNmswGLVYmuQ==
X-Google-Smtp-Source: APBJJlHaZSEdt+HtlnTFNQX7oj0n2aaJqxSeT559mxU5B9qVAbAXnZJhxFysnwbX8q3/T3g+xVYNoQ==
X-Received: by 2002:a5d:4f08:0:b0:313:dfa3:4f7b with SMTP id
 c8-20020a5d4f08000000b00313dfa34f7bmr2714153wru.20.1688131329301; 
 Fri, 30 Jun 2023 06:22:09 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 11/24] linux-user: Widen target_mmap offset argument to off_t
Date: Fri, 30 Jun 2023 15:21:46 +0200
Message-Id: <20230630132159.376995-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

We build with _FILE_OFFSET_BITS=64, so off_t = off64_t = uint64_t.
With an extra cast, this fixes emulation of mmap2, which could
overflow the computation of the full value of offset.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/user-mmap.h |  2 +-
 linux-user/mmap.c      | 14 ++++++++------
 linux-user/syscall.c   |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/linux-user/user-mmap.h b/linux-user/user-mmap.h
index 480ce1c114..3fc986f92f 100644
--- a/linux-user/user-mmap.h
+++ b/linux-user/user-mmap.h
@@ -20,7 +20,7 @@
 
 int target_mprotect(abi_ulong start, abi_ulong len, int prot);
 abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
-                     int flags, int fd, abi_ulong offset);
+                     int flags, int fd, off_t offset);
 int target_munmap(abi_ulong start, abi_ulong len);
 abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_size, unsigned long flags,
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 26d409cb60..98be739b5b 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -195,7 +195,7 @@ error:
 /* map an incomplete host page */
 static int mmap_frag(abi_ulong real_start,
                      abi_ulong start, abi_ulong end,
-                     int prot, int flags, int fd, abi_ulong offset)
+                     int prot, int flags, int fd, off_t offset)
 {
     abi_ulong real_end, addr;
     void *host_start;
@@ -456,11 +456,12 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 
 /* NOTE: all the constants are the HOST ones */
 abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
-                     int flags, int fd, abi_ulong offset)
+                     int flags, int fd, off_t offset)
 {
-    abi_ulong ret, end, real_start, real_end, retaddr, host_offset, host_len,
+    abi_ulong ret, end, real_start, real_end, retaddr, host_len,
               passthrough_start = -1, passthrough_end = -1;
     int page_flags;
+    off_t host_offset;
 
     mmap_lock();
     trace_target_mmap(start, len, target_prot, flags, fd, offset);
@@ -552,7 +553,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
     }
 
     if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
-        unsigned long host_start;
+        uintptr_t host_start;
         int host_prot;
         void *p;
 
@@ -571,7 +572,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             goto fail;
         }
         /* update start so that it points to the file position at 'offset' */
-        host_start = (unsigned long)p;
+        host_start = (uintptr_t)p;
         if (!(flags & MAP_ANONYMOUS)) {
             p = mmap(g2h_untagged(start), len, host_prot,
                      flags | MAP_FIXED, fd, host_offset);
@@ -675,7 +676,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         /* map the middle (easier) */
         if (real_start < real_end) {
             void *p;
-            unsigned long offset1;
+            off_t offset1;
+
             if (flags & MAP_ANONYMOUS) {
                 offset1 = 0;
             } else {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 459a2d8bc7..94cb4ad8fb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10350,7 +10350,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #endif
         ret = target_mmap(arg1, arg2, arg3,
                           target_to_host_bitmask(arg4, mmap_flags_tbl),
-                          arg5, arg6 << MMAP_SHIFT);
+                          arg5, (off_t)(abi_ulong)arg6 << MMAP_SHIFT);
         return get_errno(ret);
 #endif
     case TARGET_NR_munmap:
-- 
2.34.1


