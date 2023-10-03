Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D53C7B7546
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:40:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovL-00049N-GG; Tue, 03 Oct 2023 19:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovI-000486-Lk
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:28 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovG-00072n-Pb
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:28 -0400
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-79fe8986355so59681139f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376125; x=1696980925;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sv5fIcvD1HSjiZO4IkYJ3Frs5DqY4m3pn2tlZXjMwRw=;
 b=NzOkPeKZDKo5R8PFmAP5/IiOgx3c/2pyDiCGz43xiZPrn7M0RO9Yoz3NFUzbwirNBF
 rjJ+5BHAklZ2fqasZ//HcGFPdfUUXXblCWzVDJsw6dIYcMdhrdHLYgotrpYr0/H8lfJx
 iA+m4gVmQFycyxGovqamuN72E6TyRgwLtfMzsLqJvjF3FP+kechZL2pQaWKY4fD1Fg16
 PIT5mkbj9kELQ192ljafjBJ/CLmVSaBbR5F/KWZYUuTInkSbdmw6eD1BbnBr363IhG66
 fia47EVVQ5gJnS1STg0JKKMDnWjiPwZiHVU09sJVzWte0DHFLHgBrxmLM4h1gUHovUBk
 dFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376125; x=1696980925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sv5fIcvD1HSjiZO4IkYJ3Frs5DqY4m3pn2tlZXjMwRw=;
 b=CkYJNyDPdS/fGxQVjVgubtfjen9NpGMVSbaQ2EMVEUgOg9loXOh7AJ2tSeidyJBgMC
 EKP0pdRwFVKuMXFwsY9ud+877OCnYfPy2CFa3VUQH8EXWRP4EN7H2HmgJcLCYY2TUDzP
 SsGFzcaoaAb9TTbsE0UNQZ6TVI1oOY4kLwTnwhBP0SpxcWI+Rw6J31pXfT76Gx2qebg2
 RdE62UIs4QBUFl46oO1RaSnU+KigpTY8KAP3DE2b/9XDT16CqprG2CBMc81UDvxqg7XJ
 e9b3Q8NhKOFkrydeQIY57drFQ9Vu4QSD+QxfBRJdYHIvpyiiZ+0KYlwrsaANB53c+LfE
 mDkw==
X-Gm-Message-State: AOJu0YzUrFDDEFyN8v1oyNyxE0j/d4O89w4/oQHAx6dQRHksnEPGoRez
 7Yi/y4pWIyvET+l0+/7DDP88GYcbKW86Il9qJZ516g==
X-Google-Smtp-Source: AGHT+IHihLl8StzxS1Av2J8nfFrSkmsiigD5A2jkilmvDE6tVDJ3UGgleQ8UsZyDqLw3y8uNlwkClw==
X-Received: by 2002:a5d:9e19:0:b0:792:82f8:7402 with SMTP id
 h25-20020a5d9e19000000b0079282f87402mr991412ioh.16.1696376125147; 
 Tue, 03 Oct 2023 16:35:25 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:24 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PULL 20/51] bsd-user: Implement freebsd_exec_common,
 used in implementing execve/fexecve.
Date: Tue,  3 Oct 2023 17:31:44 -0600
Message-ID: <20231003233215.95557-21-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d29;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd29.google.com
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
Message-Id: <20230925182425.3163-21-kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-proc.c | 181 ++++++++++++++++++++++++++++++++++++-
 bsd-user/main.c            |   2 +-
 bsd-user/qemu.h            |   1 +
 3 files changed, 180 insertions(+), 4 deletions(-)

diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
index 2603c5c6538..12d78b7fc98 100644
--- a/bsd-user/freebsd/os-proc.c
+++ b/bsd-user/freebsd/os-proc.c
@@ -30,9 +30,7 @@ struct kinfo_proc;
  * Get the filename for the given file descriptor.
  * Note that this may return NULL (fail) if no longer cached in the kernel.
  */
-char *
-get_filename_from_fd(pid_t pid, int fd, char *filename, size_t len);
-char *
+static char *
 get_filename_from_fd(pid_t pid, int fd, char *filename, size_t len)
 {
     char *ret = NULL;
@@ -80,3 +78,180 @@ out:
     return ret;
 }
 
+/*
+ * execve/fexecve
+ */
+abi_long freebsd_exec_common(abi_ulong path_or_fd, abi_ulong guest_argp,
+        abi_ulong guest_envp, int do_fexec)
+{
+    char **argp, **envp, **qargp, **qarg1, **qarg0, **qargend;
+    int argc, envc;
+    abi_ulong gp;
+    abi_ulong addr;
+    char **q;
+    int total_size = 0;
+    void *p;
+    abi_long ret;
+
+    argc = 0;
+    for (gp = guest_argp; gp; gp += sizeof(abi_ulong)) {
+        if (get_user_ual(addr, gp)) {
+            return -TARGET_EFAULT;
+        }
+        if (!addr) {
+            break;
+        }
+        argc++;
+    }
+    envc = 0;
+    for (gp = guest_envp; gp; gp += sizeof(abi_ulong)) {
+        if (get_user_ual(addr, gp)) {
+            return -TARGET_EFAULT;
+        }
+        if (!addr) {
+            break;
+        }
+        envc++;
+    }
+
+    qarg0 = argp = g_new0(char *, argc + 9);
+    /* save the first agrument for the emulator */
+    *argp++ = (char *)getprogname();
+    qargp = argp;
+    *argp++ = (char *)getprogname();
+    qarg1 = argp;
+    envp = g_new0(char *, envc + 1);
+    for (gp = guest_argp, q = argp; gp; gp += sizeof(abi_ulong), q++) {
+        if (get_user_ual(addr, gp)) {
+            ret = -TARGET_EFAULT;
+            goto execve_end;
+        }
+        if (!addr) {
+            break;
+        }
+        *q = lock_user_string(addr);
+        if (*q == NULL) {
+            ret = -TARGET_EFAULT;
+            goto execve_end;
+        }
+        total_size += strlen(*q) + 1;
+    }
+    *q++ = NULL;
+    qargend = q;
+
+    for (gp = guest_envp, q = envp; gp; gp += sizeof(abi_ulong), q++) {
+        if (get_user_ual(addr, gp)) {
+            ret = -TARGET_EFAULT;
+            goto execve_end;
+        }
+        if (!addr) {
+            break;
+        }
+        *q = lock_user_string(addr);
+        if (*q == NULL) {
+            ret = -TARGET_EFAULT;
+            goto execve_end;
+        }
+        total_size += strlen(*q) + 1;
+    }
+    *q = NULL;
+
+    /*
+     * This case will not be caught by the host's execve() if its
+     * page size is bigger than the target's.
+     */
+    if (total_size > MAX_ARG_PAGES * TARGET_PAGE_SIZE) {
+        ret = -TARGET_E2BIG;
+        goto execve_end;
+    }
+
+    if (do_fexec) {
+        if (((int)path_or_fd > 0 &&
+            is_target_elf_binary((int)path_or_fd)) == 1) {
+            char execpath[PATH_MAX];
+
+            /*
+             * The executable is an elf binary for the target
+             * arch.  execve() it using the emulator if we can
+             * determine the filename path from the fd.
+             */
+            if (get_filename_from_fd(getpid(), (int)path_or_fd, execpath,
+                        sizeof(execpath)) != NULL) {
+                memmove(qarg1 + 2, qarg1, (qargend - qarg1) * sizeof(*qarg1));
+                qarg1[1] = qarg1[0];
+                qarg1[0] = (char *)"-0";
+                qarg1 += 2;
+                qargend += 2;
+                *qarg1 = execpath;
+#ifndef DONT_INHERIT_INTERP_PREFIX
+                memmove(qarg1 + 2, qarg1, (qargend - qarg1) * sizeof(*qarg1));
+                *qarg1++ = (char *)"-L";
+                *qarg1++ = (char *)interp_prefix;
+#endif
+                ret = get_errno(execve(qemu_proc_pathname, qargp, envp));
+            } else {
+                /* Getting the filename path failed. */
+                ret = -TARGET_EBADF;
+                goto execve_end;
+            }
+        } else {
+            ret = get_errno(fexecve((int)path_or_fd, argp, envp));
+        }
+    } else {
+        int fd;
+
+        p = lock_user_string(path_or_fd);
+        if (p == NULL) {
+            ret = -TARGET_EFAULT;
+            goto execve_end;
+        }
+
+        /*
+         * Check the header and see if it a target elf binary.  If so
+         * then execute using qemu user mode emulator.
+         */
+        fd = open(p, O_RDONLY | O_CLOEXEC);
+        if (fd > 0 && is_target_elf_binary(fd) == 1) {
+            close(fd);
+            /* execve() as a target binary using emulator. */
+            memmove(qarg1 + 2, qarg1, (qargend - qarg1) * sizeof(*qarg1));
+            qarg1[1] = qarg1[0];
+            qarg1[0] = (char *)"-0";
+            qarg1 += 2;
+            qargend += 2;
+            *qarg1 = (char *)p;
+#ifndef DONT_INHERIT_INTERP_PREFIX
+            memmove(qarg1 + 2, qarg1, (qargend - qarg1) * sizeof(*qarg1));
+            *qarg1++ = (char *)"-L";
+            *qarg1++ = (char *)interp_prefix;
+#endif
+            ret = get_errno(execve(qemu_proc_pathname, qargp, envp));
+        } else {
+            close(fd);
+            /* Execve() as a host native binary. */
+            ret = get_errno(execve(p, argp, envp));
+        }
+        unlock_user(p, path_or_fd, 0);
+    }
+
+execve_end:
+    for (gp = guest_argp, q = argp; *q; gp += sizeof(abi_ulong), q++) {
+        if (get_user_ual(addr, gp) || !addr) {
+            break;
+        }
+        unlock_user(*q, addr, 0);
+    }
+
+    for (gp = guest_envp, q = envp; *q; gp += sizeof(abi_ulong), q++) {
+        if (get_user_ual(addr, gp) || !addr) {
+            break;
+        }
+        unlock_user(*q, addr, 0);
+    }
+
+    g_free(qarg0);
+    g_free(envp);
+
+    return ret;
+}
+
diff --git a/bsd-user/main.c b/bsd-user/main.c
index f913cb55a72..a12b4be80f1 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -88,7 +88,7 @@ unsigned long reserved_va = MAX_RESERVED_VA;
 unsigned long reserved_va;
 #endif
 
-static const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
+const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
 const char *qemu_uname_release;
 char qemu_proc_pathname[PATH_MAX];  /* full path to exeutable */
 
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 41c7bd31d3c..6047805ae38 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -111,6 +111,7 @@ typedef struct TaskState {
 } __attribute__((aligned(16))) TaskState;
 
 void stop_all_tasks(void);
+extern const char *interp_prefix;
 extern const char *qemu_uname_release;
 
 /*
-- 
2.41.0


