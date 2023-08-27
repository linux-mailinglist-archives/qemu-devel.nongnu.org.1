Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB46478B940
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:12:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiaZ-0006sf-4y; Mon, 28 Aug 2023 16:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiaG-0005i5-C9
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:11:37 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiaD-0007pa-Qt
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:11:36 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2bcb50e194dso55307631fa.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253492; x=1693858292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlbKBSPmQsCPqGfy/9OfnhyDKKj90lt8zkXdT5ciTw0=;
 b=DAD28W+AbBmiGU0BMTvWOfoBqaEoRAdqRcFn6ZU5SmRdfVgR2MMSpR9/gzadH/fxP8
 bSo1ZBYyyj0fY1uQM7RsyXvsAcsPD19NBoAaswtIm9BlDJAc/mkUvVV+Tw92jtUyY6YA
 6+8nqvd2pkLM2vwBCy2yutrqKJm+b5drRkFTfzqVL54NZypmuMp/IsTclkZZ77HM77GS
 wa7ZVAm7FmkR1XiduhJeGLZxXbTwwEBUrzFTr1cS7CvUItwpNnnMfW2JKRs9/bkW+YzZ
 RxFBh3Mn3IKKfadNPjcEwHxr6ggzKdjtyirc0Shdh7odSaA2Xd1x7pJvTI5MJ+zfhHOx
 1aHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253492; x=1693858292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tlbKBSPmQsCPqGfy/9OfnhyDKKj90lt8zkXdT5ciTw0=;
 b=WHm+GKJRQJt7vZy1N8WlnyEQD4ER51VAPiPZk3x1hjTo7sHPu9aY8d9TwGQApdvKI6
 yc8wkrjgU7IKVnsNGciCz0Kx+cv8mbHCogBfS3rUCDNemix7r3tNi0me7OHunThEUzEL
 S2XL+wfu00J1nAx/GQilxqETKzGKttFQJ68oyJkqD8zq/J8wZM2d4Cl+VF86Vj5gYQW3
 hZzKjLvI7/2ZaicLD0ckMem2cY3/ank4n6btT8/kUEr4sN1S3QHSEgAhyriBN/v5ayzj
 QFyMFKLRSx97z0Bs4gBnmDI7VYOtUKS6qeiRbT++OwIxzUz3DozLZfJsEgNFt3QFzYXt
 5vpw==
X-Gm-Message-State: AOJu0YyUQ01TTdpFmzE2jJNU17Fjp7wz/rLt4ihiE44TL2PHiqlrjz1k
 4F+BW7IncDzaPUKkx9y8ZLTtEAlTNbb3tQ==
X-Google-Smtp-Source: AGHT+IHMiM1xu/cPJ8p7BUog3vLcrGpL4ck0SbMizkLra9VPIub4j3S3MBJTCM6/Z86vmfnjxBtZ4w==
X-Received: by 2002:a05:651c:1056:b0:2bc:c830:4cbb with SMTP id
 x22-20020a05651c105600b002bcc8304cbbmr14668996ljm.45.1693253491679; 
 Mon, 28 Aug 2023 13:11:31 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:11:31 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 27/32] bsd-user: Implement wait4(2) and wait6(2) system calls.
Date: Sun, 27 Aug 2023 17:57:41 +0200
Message-Id: <20230827155746.84781-28-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-lj1-x231.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-proc.h    | 75 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 14 +++++++
 2 files changed, 89 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 75ed39f8dd..544e45b3ef 100644
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
@@ -46,4 +50,75 @@ static inline abi_long do_freebsd_fexecve(abi_ulong path_or_fd, abi_ulong argp,
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
+	abi_ulong target_infop, abi_ulong pad1)
+{
+    abi_long ret;
+    int status;
+    struct __wrusage wrusage, *wrusage_ptr = NULL;
+    siginfo_t info;
+    void *p;
+
+    if (regpairs_aligned(cpu_env) != 0) {
+		/* printf("shifting args\n"); */
+		/* 64-bit id is aligned, so shift all the arguments over by one */
+		id1 = id2;
+		id2 = target_status;
+		target_status = options;
+		options = target_wrusage;
+		target_wrusage = target_infop;
+		target_infop = pad1;
+    }
+
+    if (target_wrusage) {
+        wrusage_ptr = &wrusage;
+    }
+    ret = get_errno(safe_wait6(idtype, target_arg64(id1, id2), &status, options, wrusage_ptr, &info));
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
index 3f3ca96752..2775f89304 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -38,6 +38,12 @@
 
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
@@ -226,6 +232,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_fexecve(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_wait4: /* wait4(2) */
+        ret = do_freebsd_wait4(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_wait6: /* wait6(2) */
+        ret = do_freebsd_wait6(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
+        break;
+
     case TARGET_FREEBSD_NR_exit: /* exit(2) */
         ret = do_bsd_exit(cpu_env, arg1);
         break;
-- 
2.40.0


