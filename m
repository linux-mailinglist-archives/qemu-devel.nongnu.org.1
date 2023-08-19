Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5827818B1
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:51:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIZu-0008Bh-Fv; Sat, 19 Aug 2023 05:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZZ-000808-CT
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:48:51 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZU-0004Hd-MT
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:48:42 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fee06efd6bso3082345e9.0
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438519; x=1693043319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ssWpB1TdSRberSIq+NHyAWC3tlwKWsnTa+/5C/DIew=;
 b=IH5fns7DEmJIqMNrQC/mBIKSArzlDJw+ncy+MgfhjoD5cbdjMKWFsHi2w81dtuzagc
 WnXaZCnr5S8EjF71aj9hwkGPrO9usiLf+XOq6n5TiE5rOabVDqYt4gfQ/f5MEKLGjlcQ
 P2NF8yTEUOl7APRdQtJwiLsr9HOVY5vqMcAd6UtCiGkCHdfmF0yZHPeZAJDDETBAh4iP
 o4JlIAX0VB5Vl+uz/u+6av6zJP/5k1XUhhVsoF16UVp2hxgjeJIqGOXJjTV3wBxz26VF
 JmD0fIjQygfdBv+KNaOHkmdv58FOiLm/qLoEgVNN3w58iI4Cgu4Li/tX8aRt4Sx4Ygue
 cwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438519; x=1693043319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ssWpB1TdSRberSIq+NHyAWC3tlwKWsnTa+/5C/DIew=;
 b=ej1FgI33LrJFpXqT4eF05HD+SavN98E3fDLUuNzn/Kxn6HTLOsX3/v+1cyr3MmY9RZ
 tDt1UUtuHtrfyOmrFfpN31lPwzSA2NJxq3qpIZcAoG5kSBcdX5VTg2tU0QzXktUk6dcH
 mhkHpr+gSXUAF3Pge4+xjIk6x4dvbEEszXzTbXMDvEIaDd6bOt9UUrn3XOT5ujA31HG/
 TQLtafGlygn9GIzBw4CoUF0nvtEJ0excV10MkbkTOYF8tQ3YGqFOIO3WQ3reevg3v/hC
 QRyIg0ECDqxoK8LJdN6/OnqEi3YuViW2WN/0e8/dzqm+iA8afAsZPQ0vo5bcnJ1AqFQ+
 I1Pg==
X-Gm-Message-State: AOJu0YzX5jrT2qsIogXmji2o+B7VjghRKCqOQYydSoUzNpY8M10hT81F
 UtEu6ZpC2Zitxp5jDIOER1gPhu0gsEM=
X-Google-Smtp-Source: AGHT+IEdqpPAOVcVMkwpnAPSvNz6ER4gY0v6cBGEGCzA0Dw/+7rhdV+bPZOwvRmMsOH81qLl46qXCw==
X-Received: by 2002:adf:dcc1:0:b0:314:1096:6437 with SMTP id
 x1-20020adfdcc1000000b0031410966437mr3367362wrm.19.1692438519098; 
 Sat, 19 Aug 2023 02:48:39 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:48:38 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 05/22] Implement shm_open2(2) system call
Date: Sat, 19 Aug 2023 11:47:49 +0200
Message-Id: <20230819094806.14965-6-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-misc.h    | 52 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 13 +++++++++
 2 files changed, 65 insertions(+)

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index 8436ccb2f7..993e4598f9 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -24,5 +24,57 @@
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
+#ifdef SHM_ANON
+#define SHM_PATH(p) (p) == SHM_ANON ? (p) : path(p)
+    if (pathptr == (uintptr_t)SHM_ANON) {
+        upath = SHM_ANON;
+    } else
+#else
+#define SHM_PATH(p) path(p)
+#endif
+    {
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
+    ret = get_errno(shm_open2(SHM_PATH(upath),
+                target_to_host_bitmask(flags, fcntl_flags_tbl), mode,
+                target_to_host_bitmask(shmflags, shmflag_flags_tbl), uname));
+
+#ifdef SHM_ANON
+    if (upath != SHM_ANON)
+#endif
+    {
+        unlock_user(upath, pathptr, 0);
+    }
+    if (uname != NULL) {
+        unlock_user(uname, nameptr, 0);
+    }
+    return ret;
+}
+#undef SHM_PATH
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
2.40.0


