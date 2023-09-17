Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C487A3DFF
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:43:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUs-0004ep-9r; Sun, 17 Sep 2023 17:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUk-0004cN-Bz
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:59 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUi-0004JW-4l
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:57 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32008b5e2d2so596127f8f.0
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986794; x=1695591594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ghjayZwkbL273HpL8TRoMXjx0yU87UyELyhBwrVLyT0=;
 b=D10wOiFPMGpK3hYZCbGOhJzlvFwzuQtzFZ1UcNq8Sq20aaHOiUq0evUSzmcYk4N3ff
 Q6TaADPMkfC/E1b9gYLmZbKapYT9dSbcJ/0fiKvRnxRcj2UDh4fVmQ1fv2BtyGkuBS8h
 sAFAcLk6PLGVcyhrjizmGRameuXP98m5qIOqMdLearK8CYaQlSBywSHViGwOSYAMcLSD
 TM83GpgLv78add4eJMYinov+SPABLEDE2bbtkS3mgOgXS4OeOUAwr4xwG9qec0erQYIH
 Abz9/z7GybMAT8uU2Rextg3P4hHEtjUsSVg9CRo6Rr7mu9qd9Q4TJm7DphekMrMQVtXW
 vaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986794; x=1695591594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ghjayZwkbL273HpL8TRoMXjx0yU87UyELyhBwrVLyT0=;
 b=VsKTAvex1m7Qpclat6W4QwVPKWehkkqj6IiqdNVvc3F7oPd3CWFAbYyMAeQ3mcFyiP
 cqOJjCvw1biDXqws5lH1gqGsQidkiN9JcFBV/r2aApzrG3DaDBgPRIyfr/O5unlk0/Cs
 isSz5zJlnpI6Wg4/2Lm32+8MAcTCNsqO/FilehuDvxG8c3AYv4T6PH/kxn5mlfWjTiJB
 LsNehhjikpeza4g/jZDT8zso4o8E8V+KdzVtKmfF8+/SGVXRxoPk1cgu6aGiMz68UdyI
 F3QYVzqmdS+82Fl9e4+iqLFVkkV+wp3EbDsfrMnsajtvdzQg6+/Fh8wqu3gySdHYQ6T5
 9+xw==
X-Gm-Message-State: AOJu0YwR+T+lC2sUMwv+bZyeuOLZTaZwkxlKczyDcZYGquwRgShFl7sr
 +fKa1tjkb8aFpyqZiFzmmUIJ4SlA7eM=
X-Google-Smtp-Source: AGHT+IHmjj52XDaUQfdAyGVtMsr8Lxr3Rcl+fajjPbXiosgOpynR43A9ju9PW75rO+lBac5EFidpYQ==
X-Received: by 2002:a5d:530f:0:b0:31f:fc9a:a03 with SMTP id
 e15-20020a5d530f000000b0031ffc9a0a03mr3626554wrv.20.1694986794388; 
 Sun, 17 Sep 2023 14:39:54 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:54 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 23/28] bsd-user: Implement wait4(2) and wait6(2) system
 calls.
Date: Mon, 18 Sep 2023 00:37:58 +0300
Message-ID: <20230917213803.20683-24-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42e.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-proc.h    | 77 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 15 +++++++
 2 files changed, 92 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 75ed39f8dd..8a0b6e25bb 100644
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
@@ -46,4 +50,77 @@ static inline abi_long do_freebsd_fexecve(abi_ulong path_or_fd, abi_ulong argp,
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
+    ret = safe_wait6(idtype, target_arg64(id1, id2),
+                     &status, options, wrusage_ptr, &info);
+    ret = get_errno(ret);
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


