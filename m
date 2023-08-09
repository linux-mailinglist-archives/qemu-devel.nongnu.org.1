Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AFE7766B4
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 19:51:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTnK5-0000Pl-64; Wed, 09 Aug 2023 13:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTnK1-0000Nl-Gq
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:50:13 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTnJz-0005eQ-O6
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:50:13 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-52cb8e5e9f5so56240a12.0
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 10:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691603409; x=1692208209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nhNF3NyHA/myxtoiTxBoO60EtQZnT1Z9BPdTCvWzf8U=;
 b=zWUgX+fhUvdee5k0J+N9Z0FPmZYymCZcYG5MB7TsadQkoVAf7h1beinLTIwFrYXWjI
 6eLHGpyrfbkc1N6iGmulcF1Ema2C3BPbDg7DfxpR3xnbi9QAhrSr331kbFO0zbMypDrr
 XvMTwXvKVxiZezr2MPfpmNkd7Pnb3fQ/4OADuCi1ptHoLlaXOJzcYQVPoTdRq+csnMMZ
 emcqnzJuWpqMFAFV5vA+IrPrcVb30I3zv/AUOrTTylCvJDVy2vGosIUKq3YyyvzystZr
 kizMJDt+quygb0SVWlekOhcfzjYmXg2w8cImZ3F69FnUHFKjBsB/7IFX6J4lTMoey6X1
 yX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691603409; x=1692208209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nhNF3NyHA/myxtoiTxBoO60EtQZnT1Z9BPdTCvWzf8U=;
 b=N03POJZwgz35q6URt/yJBaA7iKPGMQo7Z/+i0tSQh31IQ5IlW7MY6LwI8wXxgVzdIv
 rV0bgtlrKerPDHrk5zj/RB3Jzj3jSghlCpEkgn9wxzgSCpb3d3ryszKDItBzEd2U0azd
 heozeHqubcp4q7ZLy1ZeeXj9Zg4yLb7O9Q1PZeEupe7VFxPh41skdEbsOHWUlMTSlUaf
 GHwN4QpZxE6Mv4Tyr4vHJFPRkFrttl1712zQydKHot/96ySF4v9V6nd+VBqDCf3BSNgn
 gqy2L5r6+9yDNv63JHe1PPNUNHYLzBQXf/tHVnRypPDLHBsRlbyHUPsK4TH2r/XYlpEK
 VxKg==
X-Gm-Message-State: AOJu0YxZgyEVns5WjH7FPjuvF2GadJEOBPygaL6k1T58b6orZEAT22ql
 dIojq4s1AWdARqa7VIJpw6Jo99FEJ6M/MtXpkEk=
X-Google-Smtp-Source: AGHT+IHQxQTlXhbP+D4vAWyALE3rilpS+5d/U5MQ2OuQP7hsMzQmFyD5+VSV7qSxEB4J8YtsnCMjaQ==
X-Received: by 2002:a17:90b:370b:b0:267:f1d7:ed68 with SMTP id
 mg11-20020a17090b370b00b00267f1d7ed68mr97142pjb.14.1691603409441; 
 Wed, 09 Aug 2023 10:50:09 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090a2b4700b0025dc5749b4csm1753710pjc.21.2023.08.09.10.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 10:50:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 2/6] linux-user: Split out do_mmap
Date: Wed,  9 Aug 2023 10:50:02 -0700
Message-Id: <20230809175006.242479-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809175006.242479-1-richard.henderson@linaro.org>
References: <20230809175006.242479-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

New function that rejects unsupported map types and flags.
In 4b840f96 we should not have accepted MAP_SHARED_VALIDATE
without actually validating the rest of the flags.

Fixes: 4b840f96 ("linux-user: Populate more bits in mmap_flags_tbl")
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 90 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 73 insertions(+), 17 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a15bce2be2..34deff0723 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5985,10 +5985,6 @@ static const StructEntry struct_termios_def = {
 #endif
 
 static const bitmask_transtbl mmap_flags_tbl[] = {
-    { TARGET_MAP_TYPE, TARGET_MAP_SHARED, MAP_TYPE, MAP_SHARED },
-    { TARGET_MAP_TYPE, TARGET_MAP_PRIVATE, MAP_TYPE, MAP_PRIVATE },
-    { TARGET_MAP_TYPE, TARGET_MAP_SHARED_VALIDATE,
-      MAP_TYPE, MAP_SHARED_VALIDATE },
     { TARGET_MAP_FIXED, TARGET_MAP_FIXED, MAP_FIXED, MAP_FIXED },
     { TARGET_MAP_ANONYMOUS, TARGET_MAP_ANONYMOUS,
       MAP_ANONYMOUS, MAP_ANONYMOUS },
@@ -6006,7 +6002,6 @@ static const bitmask_transtbl mmap_flags_tbl[] = {
        Recognize it for the target insofar as we do not want to pass
        it through to the host.  */
     { TARGET_MAP_STACK, TARGET_MAP_STACK, 0, 0 },
-    { TARGET_MAP_SYNC, TARGET_MAP_SYNC, MAP_SYNC, MAP_SYNC },
     { TARGET_MAP_NONBLOCK, TARGET_MAP_NONBLOCK, MAP_NONBLOCK, MAP_NONBLOCK },
     { TARGET_MAP_POPULATE, TARGET_MAP_POPULATE, MAP_POPULATE, MAP_POPULATE },
     { TARGET_MAP_FIXED_NOREPLACE, TARGET_MAP_FIXED_NOREPLACE,
@@ -6016,6 +6011,75 @@ static const bitmask_transtbl mmap_flags_tbl[] = {
     { 0, 0, 0, 0 }
 };
 
+/*
+ * Arrange for legacy / undefined architecture specific flags to be
+ * ignored by mmap handling code.
+ */
+#ifndef TARGET_MAP_32BIT
+#define TARGET_MAP_32BIT 0
+#endif
+#ifndef TARGET_MAP_HUGE_2MB
+#define TARGET_MAP_HUGE_2MB 0
+#endif
+#ifndef TARGET_MAP_HUGE_1GB
+#define TARGET_MAP_HUGE_1GB 0
+#endif
+
+static abi_long do_mmap(abi_ulong addr, abi_ulong len, int prot,
+                        int target_flags, int fd, off_t offset)
+{
+    /*
+     * The historical set of flags that all mmap types implicitly support.
+     */
+    enum {
+        TARGET_LEGACY_MAP_MASK = TARGET_MAP_SHARED
+                               | TARGET_MAP_PRIVATE
+                               | TARGET_MAP_FIXED
+                               | TARGET_MAP_ANONYMOUS
+                               | TARGET_MAP_DENYWRITE
+                               | TARGET_MAP_EXECUTABLE
+                               | TARGET_MAP_UNINITIALIZED
+                               | TARGET_MAP_GROWSDOWN
+                               | TARGET_MAP_LOCKED
+                               | TARGET_MAP_NORESERVE
+                               | TARGET_MAP_POPULATE
+                               | TARGET_MAP_NONBLOCK
+                               | TARGET_MAP_STACK
+                               | TARGET_MAP_HUGETLB
+                               | TARGET_MAP_32BIT
+                               | TARGET_MAP_HUGE_2MB
+                               | TARGET_MAP_HUGE_1GB
+    };
+    int host_flags;
+
+    switch (target_flags & TARGET_MAP_TYPE) {
+    case TARGET_MAP_PRIVATE:
+        host_flags = MAP_PRIVATE;
+        break;
+    case TARGET_MAP_SHARED:
+        host_flags = MAP_SHARED;
+        break;
+    case TARGET_MAP_SHARED_VALIDATE:
+        /*
+         * MAP_SYNC is only supported for MAP_SHARED_VALIDATE, and is
+         * therefore omitted from mmap_flags_tbl and TARGET_LEGACY_MAP_MASK.
+         */
+        if (target_flags & ~(TARGET_LEGACY_MAP_MASK | TARGET_MAP_SYNC)) {
+            return -TARGET_EOPNOTSUPP;
+        }
+        host_flags = MAP_SHARED_VALIDATE;
+        if (target_flags & TARGET_MAP_SYNC) {
+            host_flags |= MAP_SYNC;
+        }
+        break;
+    default:
+        return -TARGET_EINVAL;
+    }
+    host_flags |= target_to_host_bitmask(target_flags, mmap_flags_tbl);
+
+    return get_errno(target_mmap(addr, len, prot, host_flags, fd, offset));
+}
+
 /*
  * NOTE: TARGET_ABI32 is defined for TARGET_I386 (but not for TARGET_X86_64)
  *       TARGET_I386 is defined if TARGET_X86_64 is defined
@@ -10536,28 +10600,20 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             v5 = tswapal(v[4]);
             v6 = tswapal(v[5]);
             unlock_user(v, arg1, 0);
-            ret = get_errno(target_mmap(v1, v2, v3,
-                                        target_to_host_bitmask(v4, mmap_flags_tbl),
-                                        v5, v6));
+            return do_mmap(v1, v2, v3, v4, v5, v6);
         }
 #else
         /* mmap pointers are always untagged */
-        ret = get_errno(target_mmap(arg1, arg2, arg3,
-                                    target_to_host_bitmask(arg4, mmap_flags_tbl),
-                                    arg5,
-                                    arg6));
+        return do_mmap(arg1, arg2, arg3, arg4, arg5, arg6);
 #endif
-        return ret;
 #endif
 #ifdef TARGET_NR_mmap2
     case TARGET_NR_mmap2:
 #ifndef MMAP_SHIFT
 #define MMAP_SHIFT 12
 #endif
-        ret = target_mmap(arg1, arg2, arg3,
-                          target_to_host_bitmask(arg4, mmap_flags_tbl),
-                          arg5, (off_t)(abi_ulong)arg6 << MMAP_SHIFT);
-        return get_errno(ret);
+        return do_mmap(arg1, arg2, arg3, arg4, arg5,
+                       (off_t)(abi_ulong)arg6 << MMAP_SHIFT);
 #endif
     case TARGET_NR_munmap:
         arg1 = cpu_untagged_addr(cpu, arg1);
-- 
2.34.1


