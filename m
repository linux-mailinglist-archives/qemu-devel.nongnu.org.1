Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6231748054
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 11:02:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGyO4-00085H-LW; Wed, 05 Jul 2023 05:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1qGyO0-00083O-JB
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 05:01:20 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1qGyNx-0000iu-1g
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 05:01:19 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57dcso45471895e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 02:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688547674; x=1691139674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kAGOvaX+oVgTitIG676Zopi82+678c3iJq+qpHOtacQ=;
 b=aw+Q3lIQVeuNxgRlqqBkZnSvyOhTK/i5gAzJ07ZYxvg+TmTiLX1wyxjmwFmtt/6Y75
 wuUTcgmKpVGk5RfyFRbzafR5qqESqVpXrcGEOah0O1YtKgskd8GogbxHqZtEuUjvfTv4
 O8imugCbf70UJ6Ck6SuyDFrrp4EPkriP69gtQuEzzhyF2Ff0MST4ABQLbUA7fSIu7enR
 N7ZTNMu+/y2sr2HkHqLcQKWZgu3HUNhCJth1M1dlWvrTeI9WIIcJZjgMnVPLfj+tkDiz
 D5nwxWwGln4PAsmBUBHQQMoLKwZFowYtgy63RtlYxSgyz/cGHYT/j2XZue66Hkg1erCt
 bc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688547674; x=1691139674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kAGOvaX+oVgTitIG676Zopi82+678c3iJq+qpHOtacQ=;
 b=B8Q0WF4+u/a+qmTo+UmnV6vdrgVjtTAT4w2VfvUvzynF/ZoAmD6QuBnfbIrybttBkt
 uoh0xUjKzmbnsctK3cYMJxl5oTmtxwQp2dTqSqo4JnCMqsYUPwp5/AvXjOchKWGAe69m
 6qZ8BfEUtf7pcgojkQKJEZCaMNszvx7EXSef3z3pq9vIRiDMB8hrP70psbJSZOuwvn8J
 O+svyjR1bcovai3AcAGaLL88BuBY/UySGeKeAwaw70/n26222VLMdVFWrGl5vvn1vQ9l
 W1nt+EtOF8vfy9KqtNktMJ3FqCmDaA+oz4ilzwN0mplEH6F6O2BfkSdfTWqhOvwVjhf2
 Jc2A==
X-Gm-Message-State: AC+VfDwrzVLTKRGEtWyxLDcElQpM9okpil/nLEnFpS5qgQ2dSPCoz2K6
 k7GxjE/qC7YqpR9x4L5r6wenNtTKqYWJ6dXMBLs=
X-Google-Smtp-Source: ACHHUZ7SvqTRnptOc+REN1OIBF/Ai6E5jNqzZOW0DZpmDXuU42BqCopdr17zS6DubJf11GubdyV3Ug==
X-Received: by 2002:a05:600c:2299:b0:3fb:b2a5:aeac with SMTP id
 25-20020a05600c229900b003fbb2a5aeacmr13589319wmf.20.1688547674578; 
 Wed, 05 Jul 2023 02:01:14 -0700 (PDT)
Received: from localhost.localdomain ([31.32.81.187])
 by smtp.gmail.com with ESMTPSA id
 cw8-20020a056000090800b00311d8c2561bsm30350140wrb.60.2023.07.05.02.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 02:01:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.henderson@linaro.org, sir@cmpwn.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2] linux-user/syscall: Implement execve without execveat
Date: Wed,  5 Jul 2023 11:00:56 +0200
Message-Id: <20230705090056.610699-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Support for execveat syscall was implemented in 55bbe4 and is available
since QEMU 8.0.0. It relies on host execveat, which is widely available
on most of Linux kernels today.

However, this change breaks qemu-user self emulation, if "host" qemu
version is less than 8.0.0. Indeed, it does not implement yet execveat.
This strange use case happens with most of distribution today having
binfmt support.

With a concrete failing example:
$ qemu-x86_64-7.2 qemu-x86_64-8.0 /bin/bash -c /bin/ls
/bin/bash: line 1: /bin/ls: Function not implemented
-> not implemented means execve returned ENOSYS

qemu-user-static 7.2 and 8.0 can be conveniently grabbed from debian
packages qemu-user-static* [1].

One usage of this is running wine-arm64 from linux-x64 (details [2]).
This is by updating qemu embedded in docker image that we ran into this
issue.

The solution to update host qemu is not always possible. Either it's
complicated or ask you to recompile it, or simply is not accessible
(GitLab CI, GitHub Actions). Thus, it could be worth to implement execve
without relying on execveat, which is the goal of this patch.

This patch was tested with example presented in this commit message.

[1] http://ftp.us.debian.org/debian/pool/main/q/qemu/
[1] https://www.linaro.org/blog/emulate-windows-on-arm/

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 linux-user/syscall.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 08162cc966..4945ddd7f2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -659,6 +659,7 @@ safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
 #endif
 safe_syscall5(int, waitid, idtype_t, idtype, id_t, id, siginfo_t *, infop, \
               int, options, struct rusage *, rusage)
+safe_syscall3(int, execve, const char *, filename, char **, argv, char **, envp)
 safe_syscall5(int, execveat, int, dirfd, const char *, filename,
               char **, argv, char **, envp, int, flags)
 #if defined(TARGET_NR_select) || defined(TARGET_NR__newselect) || \
@@ -8615,9 +8616,9 @@ ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz)
     return ret;
 }
 
-static int do_execveat(CPUArchState *cpu_env, int dirfd,
-                       abi_long pathname, abi_long guest_argp,
-                       abi_long guest_envp, int flags)
+static int do_execv(CPUArchState *cpu_env, int dirfd,
+                    abi_long pathname, abi_long guest_argp,
+                    abi_long guest_envp, int flags, bool is_execveat)
 {
     int ret;
     char **argp, **envp;
@@ -8696,11 +8697,14 @@ static int do_execveat(CPUArchState *cpu_env, int dirfd,
         goto execve_efault;
     }
 
+    const char* exe = p;
     if (is_proc_myself(p, "exe")) {
-        ret = get_errno(safe_execveat(dirfd, exec_path, argp, envp, flags));
-    } else {
-        ret = get_errno(safe_execveat(dirfd, p, argp, envp, flags));
+        exe = exec_path;
     }
+    ret = is_execveat ?
+        safe_execveat(dirfd, exe, argp, envp, flags):
+        safe_execve(exe, argp, envp);
+    ret = get_errno(ret);
 
     unlock_user(p, pathname, 0);
 
@@ -9251,9 +9255,9 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return ret;
 #endif
     case TARGET_NR_execveat:
-        return do_execveat(cpu_env, arg1, arg2, arg3, arg4, arg5);
+        return do_execv(cpu_env, arg1, arg2, arg3, arg4, arg5, true);
     case TARGET_NR_execve:
-        return do_execveat(cpu_env, AT_FDCWD, arg1, arg2, arg3, 0);
+        return do_execv(cpu_env, AT_FDCWD, arg1, arg2, arg3, 0, false);
     case TARGET_NR_chdir:
         if (!(p = lock_user_string(arg1)))
             return -TARGET_EFAULT;
-- 
2.40.1


