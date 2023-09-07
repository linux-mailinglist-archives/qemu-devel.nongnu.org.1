Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADED0799643
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:35:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepfG-0000zT-8K; Sat, 09 Sep 2023 00:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfE-0000yz-3p
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:44 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfB-0002vl-Ow
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:43 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso2478875f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234020; x=1694838820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7TrfBeMTvldfbKpqmn3rJZFleCngQ8YSqhuAsSyAkaU=;
 b=cjK5Zogr9poGLb3qOSf00B9JxFjCeox/Ee5FTPz2Br4zOjlJ1TKiRWe9LvlBFuS4ra
 ktbbXJw2Il7Zbogn6vhe72jMz9Y4SqWGGvz0oXb3NibZhtbZ1y7C8jGVL8OK2d8TzA5k
 5mL+Xk8XE8DDOotr9Mh8zhmW5PyMVrOrC0FZopYBE/yxGgH4VPVnG1u8sCd/1eKxVyXK
 GX2C4BeabxQIkj4IqHnyraEpWeiSZ7AtnEmhbkPZ9iieZ0Unux3rc7yCSHhHT1tZ3hYm
 FKLHAoYfrlhDJD/2pVcXzSJdBT5Neh7hjpxUQuyfisFH5rIySnX0zVHdWzxLk6+KlYTE
 o8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234020; x=1694838820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7TrfBeMTvldfbKpqmn3rJZFleCngQ8YSqhuAsSyAkaU=;
 b=VhgpVHdD+AJXU0dhziO/UZi4apIqTjnPZ/JFsgVh5ymzhMraCKg1cTxmrj3LyMANXC
 3psVSSgetVpi40fRYRo9mJ9TAViiLbJmMmEYK/wUEksbyTy2LZ26D3zRDwtSkEDuy8Z1
 pSLE+AgCTOhCa6l1gmt7Z4fIDZeVwk8Asx7BUaxXAhRdOagO0HXsNq7sbN7UNxZFaggS
 M7ECNr45/JHEXYW5cD89LCToW9JFRo1RRGnYhzeAcOtr2pjXveVomKUgvn+RzanzRHH7
 EO4BEAUrUs7Un2CG5hsuhgi2v7Ht2zDJZCWEgFLHO1cvXUwFPtj5r5BJ+ZBq2l1sl8pu
 GDjA==
X-Gm-Message-State: AOJu0YwjSmzBf1Qc9u58Yl+I/qC5sVi7sntU/tVPMY6xMG8mrwDKIE7O
 Dr1bqKzrKNULdJIFixhl/dwr22B7zOA=
X-Google-Smtp-Source: AGHT+IHBX8TnxcCuCKvEn1ikpfAEFfPRfDIjI8XNPeo8WulHUWkm4QzPKL03CFZD/IF7ni8yQb2LbA==
X-Received: by 2002:adf:e68f:0:b0:31c:8257:2c78 with SMTP id
 r15-20020adfe68f000000b0031c82572c78mr3615531wrm.52.1694234019900; 
 Fri, 08 Sep 2023 21:33:39 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:33:39 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 05/23] bsd-user: Implement shm_open2(2) system call
Date: Thu,  7 Sep 2023 09:42:44 +0200
Message-ID: <20230907074302.79234-6-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-misc.h    | 42 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 13 +++++++++++
 2 files changed, 55 insertions(+)

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index 8436ccb2f7..6b424b7078 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -24,5 +24,47 @@
 #include <sys/random.h>
 #include <sched.h>
 
+int shm_open2(const char *path, int flags, mode_t mode, int shmflags,
+    const char *);
+
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
+/* shm_open2(2) */
+static inline abi_long do_freebsd_shm_open2(abi_ulong pathptr, abi_ulong flags,
+    abi_long mode, abi_ulong shmflags, abi_ulong nameptr)
+{
+    int ret;
+    void *uname, *upath;
+
+    if (pathptr == (uintptr_t)SHM_ANON) {
+        upath = SHM_ANON;
+    } else {
+        upath = lock_user_string(pathptr);
+        if (upath == NULL) {
+            return -TARGET_EFAULT;
+        }
+    }
+
+    uname = NULL;
+    if (nameptr != 0) {
+        uname = lock_user_string(nameptr);
+        if (uname == NULL) {
+            unlock_user(upath, pathptr, 0);
+            return -TARGET_EFAULT;
+        }
+    }
+    ret = get_errno(shm_open2(upath,
+                target_to_host_bitmask(flags, fcntl_flags_tbl), mode,
+                target_to_host_bitmask(shmflags, shmflag_flags_tbl), uname));
+
+    if (upath != SHM_ANON) {
+        unlock_user(upath, pathptr, 0);
+    }
+    if (uname != NULL) {
+        unlock_user(uname, nameptr, 0);
+    }
+    return ret;
+}
+#endif /* __FreeBSD_version >= 1300048 */
+
 
 #endif /* OS_MISC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 2224a280ea..b4311db578 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -33,9 +33,13 @@
 #include "signal-common.h"
 #include "user/syscall-trace.h"
 
+/* BSD independent syscall shims */
 #include "bsd-file.h"
 #include "bsd-proc.h"
 
+/* *BSD dependent syscall shims */
+#include "os-misc.h"
+
 /* I/O */
 safe_syscall3(int, open, const char *, path, int, flags, mode_t, mode);
 safe_syscall4(int, openat, int, fd, const char *, path, int, flags, mode_t,
@@ -482,6 +486,15 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_undelete(arg1);
         break;
 
+        /*
+         * Memory management system calls.
+         */
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
+    case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
+        ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
+        break;
+#endif
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.42.0


