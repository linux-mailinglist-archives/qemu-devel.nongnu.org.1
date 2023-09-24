Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBEA7ACE5B
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:39:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbT5-0003da-Vo; Sun, 24 Sep 2023 22:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbT4-0003cE-FB
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:37:02 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbT2-00009K-RL
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:37:02 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3231df054c4so1690213f8f.0
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609419; x=1696214219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Ly4EPq2uxWF3voxvrVfIvF9YiPa9H2yaSp9mHck8XY=;
 b=A8n5UdK31w5/4JuT7E/QfWQy09uf0fp4fLdcNxU6EzYU9lOacBbrtnZmKln9XNIX50
 3EC3jRlfduFiWbVdnu0dbRHSetSOx5OapHEuVWKdeR6wqSFroEEqZFJ1/HTTl5MSbVtM
 2GoZgoKNufFwo+Duld9Z8y3SBLc8pZFFugy0Fl1gF5hk/rD80X93++bAZvZIoxDKLM9A
 5tYf0/tWCXfiA4uRwlPlJgN28VJKHhVczqIzwbYbx/HRSrEi060NUpCpL+jBEehj+ca0
 l8enmfuc+G99vNG3oaI5h6k19xYcqHvrs3tPXVE7aoshM2ACU/ywRvNfyyTnX7o0jqD1
 9h2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609419; x=1696214219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Ly4EPq2uxWF3voxvrVfIvF9YiPa9H2yaSp9mHck8XY=;
 b=QvNiFGnk2TcPgHi7iJ/4etfLoQw70KV2HNZi9m8LxGX4cxI4PsKGLtyhoqgelfvoBw
 Uiezdunnrwvbefb8DAg7kfgu575HfqnQHVFeJnDxJaFqM/UzBummzfBHB/BRXcVuusR7
 LZCXEWddhfM09ho/oc153Bjy0YQqdt8i+JjHZlZjv3bT9HrpSXtgJ0z5WIMXZ0RA0ACL
 Cn8gs1goFHZJsBEKaguJ3KMw3fgd28DurIFJNYyT9Td/g2KBtXPuOMJ+SSj8U3ewqOEi
 0Lg18i+kHXP+3HhSebqu3ZnlXdOR6XlUdI3rd9juQz+3xne7dJNc57oAuzBbGrYe7jG1
 MgSg==
X-Gm-Message-State: AOJu0Yw9oE5hErwUWnrQJge9suDv3eBs4qfziBi8V9QJQF3vlDIWiGv/
 hAaPAWb81p9QVJ2mfgL5gclfpee3gSU=
X-Google-Smtp-Source: AGHT+IEPpgJxwougX+iB86L7aI/eiBq87rqUdMsm99OdxcA27PWCp6VhsklSiCfjoP6FQb/qBZcM6w==
X-Received: by 2002:adf:e981:0:b0:31f:c1b5:d4c1 with SMTP id
 h1-20020adfe981000000b0031fc1b5d4c1mr5017760wrm.35.1695609419122; 
 Sun, 24 Sep 2023 19:36:59 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:58 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 23/28] bsd-user: Implement wait4(2) and wait6(2) system
 calls.
Date: Mon, 25 Sep 2023 00:01:31 +0300
Message-ID: <20230924210136.11966-24-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-proc.h    | 84 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 15 +++++++
 2 files changed, 99 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 75ed39f8dd..04bce755e5 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -30,6 +30,10 @@
 
 #include "target_arch_cpu.h"
 
+pid_t safe_wait4(pid_t wpid, int *status, int options, struct rusage *rusage);
+pid_t safe_wait6(idtype_t idtype, id_t id, int *status, int options,
+    struct __wrusage *wrusage, siginfo_t *infop);
+
 /* execve(2) */
 static inline abi_long do_freebsd_execve(abi_ulong path_or_fd, abi_ulong argp,
         abi_ulong envp)
@@ -46,4 +50,84 @@ static inline abi_long do_freebsd_fexecve(abi_ulong path_or_fd, abi_ulong argp,
     return freebsd_exec_common(path_or_fd, argp, envp, 1);
 }
 
+/* wait4(2) */
+static inline abi_long do_freebsd_wait4(abi_long arg1, abi_ulong target_status,
+        abi_long arg3, abi_ulong target_rusage)
+{
+    abi_long ret;
+    int status;
+    struct rusage rusage, *rusage_ptr = NULL;
+
+    if (target_rusage) {
+        rusage_ptr = &rusage;
+    }
+    ret = get_errno(safe_wait4(arg1, &status, arg3, rusage_ptr));
+
+    if (ret < 0) {
+        return ret;
+    }
+    if (target_status != 0) {
+        status = host_to_target_waitstatus(status);
+        if (put_user_s32(status, target_status) != 0) {
+            return -TARGET_EFAULT;
+        }
+    }
+    if (target_rusage != 0) {
+        host_to_target_rusage(target_rusage, &rusage);
+    }
+    return ret;
+}
+
+/* wait6(2) */
+static inline abi_long do_freebsd_wait6(void *cpu_env, abi_long idtype,
+    abi_long id1, abi_long id2,
+    abi_ulong target_status, abi_long options, abi_ulong target_wrusage,
+    abi_ulong target_infop, abi_ulong pad1)
+{
+    abi_long ret;
+    int status;
+    struct __wrusage wrusage, *wrusage_ptr = NULL;
+    siginfo_t info;
+    void *p;
+
+    if (regpairs_aligned(cpu_env) != 0) {
+        /* printf("shifting args\n"); */
+        /* 64-bit id is aligned, so shift all the arguments over by one */
+        id1 = id2;
+        id2 = target_status;
+        target_status = options;
+        options = target_wrusage;
+        target_wrusage = target_infop;
+        target_infop = pad1;
+    }
+
+    if (target_wrusage) {
+        wrusage_ptr = &wrusage;
+    }
+    ret = get_errno(safe_wait6(idtype, target_arg64(id1, id2),
+                               &status, options, wrusage_ptr, &info));
+
+    if (ret < 0) {
+        return ret;
+    }
+    if (target_status != 0) {
+        status = host_to_target_waitstatus(status);
+        if (put_user_s32(status, target_status) != 0) {
+            return -TARGET_EFAULT;
+        }
+    }
+    if (target_wrusage != 0) {
+        host_to_target_wrusage(target_wrusage, &wrusage);
+    }
+    if (target_infop != 0) {
+        p = lock_user(VERIFY_WRITE, target_infop, sizeof(target_siginfo_t), 0);
+        if (p == NULL) {
+            return -TARGET_EFAULT;
+        }
+        host_to_target_siginfo(p, &info);
+        unlock_user(p, target_infop, sizeof(target_siginfo_t));
+    }
+    return ret;
+}
+
 #endif /* BSD_USER_FREEBSD_OS_PROC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 515eaaf31f..55e68e4815 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -40,6 +40,12 @@
 #include "os-stat.h"
 #include "os-proc.h"
 
+/* used in os-proc */
+safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
+    struct rusage *, rusage);
+safe_syscall6(pid_t, wait6, idtype_t, idtype, id_t, id, int *, status, int,
+    options, struct __wrusage *, wrusage, siginfo_t *, infop);
+
 /* I/O */
 safe_syscall3(int, open, const char *, path, int, flags, mode_t, mode);
 safe_syscall4(int, openat, int, fd, const char *, path, int, flags, mode_t,
@@ -228,6 +234,15 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_fexecve(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_wait4: /* wait4(2) */
+        ret = do_freebsd_wait4(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_wait6: /* wait6(2) */
+        ret = do_freebsd_wait6(cpu_env, arg1, arg2, arg3,
+                               arg4, arg5, arg6, arg7, arg8);
+        break;
+
     case TARGET_FREEBSD_NR_exit: /* exit(2) */
         ret = do_bsd_exit(cpu_env, arg1);
         break;
-- 
2.42.0


