Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E97A74C75F
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:43:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZED-0004tr-9A; Sun, 09 Jul 2023 14:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDx-0003X2-7g
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:33 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDu-0004Fd-6A
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:32 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3142860734aso3826039f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927607; x=1691519607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n45s477h1C3Bg6RmtpzjbWFEleMZVTqSI+26VJaWtyU=;
 b=IB8ycmOvK5tx6xi4Wa0QGm8UQPho6UWjQDCIYg7eKygLgYJ3YC0euY63P/uBnYtpJB
 QCVFWgqIepX5YJqC18ZUGidPJCKJUcdEjJ9uECKL/GuglKrcRVJyZ88nWWD4Cq7eedgV
 VsGxwkMQN0cO2O5Xu7RoxRwDSeqN6rUk+JbPgBqc9+X7l4LYuQmfv7YkiB7cANaC5sce
 IOGRX5mIVvJMP26X+dSgFld0ApPpS3LRQhaC9qNAieL7TS0JK17gWPC4w9n+YBj1b5cI
 7XbJpFniuvPFWm2WU8whXRKVQ/fFdZTjLsm6MjIXICntW+0T4qn7Hakw0V66iV1NIhQe
 NF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927607; x=1691519607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n45s477h1C3Bg6RmtpzjbWFEleMZVTqSI+26VJaWtyU=;
 b=hJX3ncPFgQpsbcCje2rnNwA8UhHDlTwNOhAJYX9FbwtHhNtJUcrClnxxnDmDSEisl7
 f7cQle5xRfLKQcV4IMDeZMgORvTbbK5HAYEJAA3m2m7EWHhZJMemkxfwUshzGXxBmgGs
 2eUs2cdhVvysBSVr0dMRyZQSs4w0NLguzu0b3IRytIhZ8GnCuVInKP8zSixF2nZPvBBJ
 1tlxviQk62JRNSVYWYSXYLrWk18Rcrs22LoKe/1Uykv/84KOBwOPJ80YCKjMIrgODL+S
 qFZRuhXe4q5CkXtARJ7B8CNrSpDqwVhAxUan1lBl2Yo0itrNeaQsbO9ZYao7VPOo5Lom
 Yfvg==
X-Gm-Message-State: ABy/qLYNeXfjudOZu2+xIjGxlQWOvqzb195LG0CRES1OFCn0USW21pzj
 yeE25A5y6tyO8nUB8AVRwzQWspdqvJfNcD/09Gbp0Q==
X-Google-Smtp-Source: APBJJlF3fSyqd2wfpjhXcxwBbIwAb0I97p3a95SfbS0W9VCSVCPxG1iO/sBNe2Sht+rPqYRSVFH6+w==
X-Received: by 2002:a5d:4b91:0:b0:315:8f4f:9c50 with SMTP id
 b17-20020a5d4b91000000b003158f4f9c50mr3667365wrt.16.1688927607326; 
 Sun, 09 Jul 2023 11:33:27 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 30/45] linux-user: Widen target_mmap offset argument to off_t
Date: Sun,  9 Jul 2023 19:29:11 +0100
Message-Id: <20230709182934.309468-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230707204054.8792-14-richard.henderson@linaro.org>
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
index 12b1308a83..b2c2d85857 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -196,7 +196,7 @@ error:
 /* map an incomplete host page */
 static int mmap_frag(abi_ulong real_start,
                      abi_ulong start, abi_ulong end,
-                     int prot, int flags, int fd, abi_ulong offset)
+                     int prot, int flags, int fd, off_t offset)
 {
     abi_ulong real_end, addr;
     void *host_start;
@@ -463,11 +463,12 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 
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
@@ -559,7 +560,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
     }
 
     if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
-        unsigned long host_start;
+        uintptr_t host_start;
         int host_prot;
         void *p;
 
@@ -578,7 +579,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             goto fail;
         }
         /* update start so that it points to the file position at 'offset' */
-        host_start = (unsigned long)p;
+        host_start = (uintptr_t)p;
         if (!(flags & MAP_ANONYMOUS)) {
             p = mmap(g2h_untagged(start), len, host_prot,
                      flags | MAP_FIXED, fd, host_offset);
@@ -681,7 +682,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
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
index 36c4d88793..8a5a82fcec 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10436,7 +10436,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
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


