Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C13FB7B7539
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:39:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovY-0004Eq-Gs; Tue, 03 Oct 2023 19:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovW-0004EW-1g
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:42 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovS-0007Q3-A6
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:40 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79fb78e297bso61796539f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376137; x=1696980937;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9k2xFREJ+w8CMIVs9kMy/TL+LfskRJju2B00DBUrNyk=;
 b=wparATsjCtYScuR3dh8DZNV35+ocs6LUEKa57sWPoKkwrukPImllUoXJtNL707lLpl
 DR/kkBryl6SgB9fm3QunJOCycUkUKEbbJrJhiMnmqS8DgG2gC5sRVs3cgyYOOxRbIxzb
 iDLqY/DbIp7/l8wur31UnP4vMj8UH6VmkXQEBAQt38tOqa4gmneeRuXNGds7/5tbXiX5
 mfoG/ZtS/IJ/P3WwtKWmJaWBqVwKS2CBwnmsqR6b2iyG4iaAFM1X6vo6/3MTf/enRimj
 /YtHSC0M6LYCp/1HfiIyxns/PskJZKnKbV1Y0naL2biEvxxP85mCkA0xPPiqwVYteteb
 YmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376137; x=1696980937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9k2xFREJ+w8CMIVs9kMy/TL+LfskRJju2B00DBUrNyk=;
 b=IHbt4HeAi1cOr0+jBO3MlbwISBnoWgGbYfk517z4dH6Wn+uJXq9gDx5IEQulxXBt1x
 YoBGqoaoEQN8IaIUk7J9tYxMZTQNPnjxxuXlYgW6isDgNjkTAWwk7H1PualTbXalZTr0
 iyvevaQv9dsxnaMmvniqiyXzi6eWSLDI1s+rNDPEeNprAnU+6r02QUC6K0Ixw5AvBR0Y
 CgFlgXNLAvWrbgFkUq3p0Qx2KfO3AoZ6aQwkKtG1y42H9jaUi7WFFxwUX0xcwrtEp01L
 fpbhAFQWWmFxhkOPsRDLQbKzs2HPA5XwPQtDzWJChhj9LLYXL8qH4eE45vJ5ecmW9zJ5
 dP6g==
X-Gm-Message-State: AOJu0YytPA19PL2q796VMmkYposV6JMZQMgMe4ggEtE3qu4ywWadI8qV
 nQzkAO+Gq1Ga7n9DgeHXJrnYvnp/6FrgWs+Tn6L8Lg==
X-Google-Smtp-Source: AGHT+IEXvxd++3vx1MPatOmVfIjdDMCH25RkSj/Vd4sxC/x7wwpwnFatxOZ64owcaFiVKyBejeBLmg==
X-Received: by 2002:a6b:4f0b:0:b0:783:5209:c01 with SMTP id
 d11-20020a6b4f0b000000b0078352090c01mr990534iob.17.1696376137025; 
 Tue, 03 Oct 2023 16:35:37 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:36 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 33/51] bsd-user: Implement shm_open2(2) system call
Date: Tue,  3 Oct 2023 17:31:57 -0600
Message-ID: <20231003233215.95557-34-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d35;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Karim Taha <kariem.taha2.7@gmail.com>

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230925182709.4834-6-kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-misc.h    | 46 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 22 ++++++++++++-----
 2 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index 8436ccb2f7d..d5e8b5484c8 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -24,5 +24,51 @@
 #include <sys/random.h>
 #include <sched.h>
 
+/*
+ * shm_open2 isn't exported, but the __sys_ alias is. We can use either for the
+ * static version, but to dynamically link we have to use the sys version.
+ */
+int __sys_shm_open2(const char *path, int flags, mode_t mode, int shmflags,
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
+    ret = get_errno(__sys_shm_open2(upath,
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
index d04712f0a7e..122e186b501 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -33,18 +33,14 @@
 #include "signal-common.h"
 #include "user/syscall-trace.h"
 
+/* BSD independent syscall shims */
 #include "bsd-file.h"
 #include "bsd-proc.h"
 
 /* BSD dependent syscall shims */
 #include "os-stat.h"
 #include "os-proc.h"
-
-/* used in os-proc */
-safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
-    struct rusage *, rusage);
-safe_syscall6(pid_t, wait6, idtype_t, idtype, id_t, id, int *, status, int,
-    options, struct __wrusage *, wrusage, siginfo_t *, infop);
+#include "os-misc.h"
 
 /* I/O */
 safe_syscall3(int, open, const char *, path, int, flags, mode_t, mode);
@@ -65,6 +61,12 @@ safe_syscall3(ssize_t, writev, int, fd, const struct iovec *, iov, int, iovcnt);
 safe_syscall4(ssize_t, pwritev, int, fd, const struct iovec *, iov, int, iovcnt,
     off_t, offset);
 
+/* used in os-proc */
+safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
+    struct rusage *, rusage);
+safe_syscall6(pid_t, wait6, idtype_t, idtype, id_t, id, int *, status, int,
+    options, struct __wrusage *, wrusage, siginfo_t *, infop);
+
 void target_set_brk(abi_ulong new_brk)
 {
 }
@@ -796,6 +798,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_fcntl(arg1, arg2, arg3);
         break;
 
+        /*
+         * Memory management system calls.
+         */
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
+    case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
+        ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
+        break;
+#endif
 
         /*
          * sys{ctl, arch, call}
-- 
2.41.0


