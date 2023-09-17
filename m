Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD0F7A3DED
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:41:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUq-0004dp-MN; Sun, 17 Sep 2023 17:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUh-0004bF-LB
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:56 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUe-0004J7-MA
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:55 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-404773f2501so33428275e9.0
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986791; x=1695591591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ys1OyN6LWTWmM5gC1nm5PCKVJBs4yHemXKcMj/MrNMQ=;
 b=kSY7i+/whaRaHl2t7j6Aa+OkrRUzndx6gJZc9nOLludvf8DsZbBMpGsbgCDLGogRfQ
 VSc9LtwNw/kJJOCJSSRissxLayz03GoNSb6qDWy305q3VS4S/VPCSjjMRrXM7Zku7dtb
 hTEhsXvXhGSTYqreSSKHSHVYUTWi2yLEjCu64Q2II0szqhorH1QS5lxgD6YmtORCNZLg
 iD7vpiDQgVJOML7/eD4Mp+0CkV9TAmY42nCZffO0e1Ng32yON+3m2LzvRwv/0JiIMfpK
 mqBWxyzVMD1pjzjeDnaNEldtQPo+dnhhhuKfmmbhN1/9TlJNUZfwDfDLeqhjsaoXerbD
 XKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986791; x=1695591591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ys1OyN6LWTWmM5gC1nm5PCKVJBs4yHemXKcMj/MrNMQ=;
 b=BU/7iI47XhJ+ODLm0imcWkDHAW0Figzp8xrlUM3G2hMf5ypmtL+z7Lfv2eYcrR1Mb4
 7RzjkLSDJcG7Y74iWGwqY6sZ/kdP/UDqDy25PxllmYGrEoJn8/zS6iikpPuF88bZwWjF
 MBVMczjHQPWXs6T5bNQ71AXLFF+lCor6/DTMUo6ABxbGP5fdlpuZobJtTMVnq68jC1r3
 FYrUF8zaqGU3znDOINvzN4v12gEqJ6qHHOprgvXp7u9YLXwH5GucMpPXJHKIpGzdWH92
 yIRaVutP11xfCFL3lWgY2UFjFbnjptHZFrQCtnarfqiD4aJPd7PWiljdK0Wsv4s9+sFi
 3yIQ==
X-Gm-Message-State: AOJu0YyGrMPvsmGX9pJgMubM28B/hEGLn7xOm9KVnoX8FoNNav1fIf/5
 XbcXS+0ZqJ87ilPUcW/zlmsnDTR4ZOA=
X-Google-Smtp-Source: AGHT+IFNgoi7UX++iKtkq0Hn0JpDjWDZtoMXltfbr97lZOl0O5nWIqLCBaikDyYAo9OY6UcHaJA2pg==
X-Received: by 2002:a7b:cd9a:0:b0:401:264b:5df7 with SMTP id
 y26-20020a7bcd9a000000b00401264b5df7mr6112826wmj.35.1694986790871; 
 Sun, 17 Sep 2023 14:39:50 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:50 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 20/28] bsd-user: Implement freebsd_exec_common,
 used in implementing execve/fexecve.
Date: Mon, 18 Sep 2023 00:37:55 +0300
Message-ID: <20230917213803.20683-21-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32e.google.com
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
---
 bsd-user/freebsd/os-proc.c | 177 +++++++++++++++++++++++++++++++++++++
 bsd-user/main.c            |   2 +-
 bsd-user/qemu.h            |   1 +
 3 files changed, 179 insertions(+), 1 deletion(-)

diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
index cb35f29f10..12d78b7fc9 100644
--- a/bsd-user/freebsd/os-proc.c
+++ b/bsd-user/freebsd/os-proc.c
@@ -78,3 +78,180 @@ out:
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
index f913cb55a7..a12b4be80f 100644
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
index 2cf96d9a15..1ed6024b5d 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -111,6 +111,7 @@ typedef struct TaskState {
 } __attribute__((aligned(16))) TaskState;
 
 void stop_all_tasks(void);
+extern const char *interp_prefix;
 extern const char *qemu_uname_release;
 
 /*
-- 
2.42.0


