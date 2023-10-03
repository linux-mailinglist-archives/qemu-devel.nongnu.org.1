Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C72F7B7512
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:36:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovO-0004AV-5v; Tue, 03 Oct 2023 19:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovL-0004A0-UB
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:31 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovK-00078O-7W
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:31 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79fe6da0095so60242839f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376128; x=1696980928;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MApO9kv1LCt8gsX2fOSXKRD/PiBDzPPW73bw9SC1hGs=;
 b=NPY8/T8ENlSffc5jdN7f/Kdr8n7lBr6rx+kA3o98VSNaKC+oNC7sGkPSP/a63DUZoc
 6XYUoKDImG0VsYSuUwruKT9rxiROmQd6BrmgFTpAuTCvIO0QvbV3Vf+cuwHGNGl37VXu
 bw7hmTKrnGqBvbFhVk6ZntRReem7d2Qm+ZzDT0nh4uu956psSpokWasIpxnVZi7MWt8I
 IvOJwHSec8qO7Bo2l1d0hTv4bFmI1DEyZ+PBjsBkwDMYJOp4tNyB93V2EUY0SZNzYQHa
 EHPKstq0m37RKTm8iky8ffcAcvMMxtljz382keIt2401fnEkKmeB72p/i1pPJ/NyBS1x
 +MFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376128; x=1696980928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MApO9kv1LCt8gsX2fOSXKRD/PiBDzPPW73bw9SC1hGs=;
 b=I8W7JXK2pzm2j3PsSypaV0W5tVbjFtzk3e8/CaNlbh0LDG93fcM4CCiFpzYlXs2Jog
 m63LPp7hjUYD4ZXsmS4psLiUy0XdW8N0E/CwhtuU6w3JXHe+Acobp1Wi9AvfxMlQoV9O
 /+Ycle6EZ3+lFYAO3tCQ9o3adGNW0QNOgo+nrpuksHFfLEO6fx2PADhdRmG4eFvex23n
 lZeAASjoYjdEkmKbqkYY9j5vJkkitUyNTA5lVnTv8thZtPEj6NNBZYjiOAhFKSEmpxbi
 8MJ3gZSaPsKFTzWjPe7T/rmCDHp2xkXKpVAKyk25+KDlI7ANQadmSrAinoscZdkuhyB5
 KkBw==
X-Gm-Message-State: AOJu0YyfpgJD1kqWlgX8GXZJQlrQe8sId7HrVlV3cZDOY+yJ318bnwEn
 JD1JWcEJEnlFLBYBeUHHExygBupPD1VXxTg6sMDEpg==
X-Google-Smtp-Source: AGHT+IHIJ6CnXCwlI+pGUidKxP3QG8+BUfiwt0sbHrTYnK9ER6aKuIGeRFogbKP8opbDfERVgNOUQg==
X-Received: by 2002:a6b:5b16:0:b0:79f:d04d:ce59 with SMTP id
 v22-20020a6b5b16000000b0079fd04dce59mr976623ioh.6.1696376127996; 
 Tue, 03 Oct 2023 16:35:27 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:27 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PULL 23/51] bsd-user: Implement wait4(2) and wait6(2) system calls.
Date: Tue,  3 Oct 2023 17:31:47 -0600
Message-ID: <20231003233215.95557-24-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d36;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd36.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182425.3163-24-kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-proc.h    | 84 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 15 +++++++
 2 files changed, 99 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 75ed39f8ddd..04bce755e58 100644
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
index 515eaaf31f1..55e68e48159 100644
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
2.41.0


