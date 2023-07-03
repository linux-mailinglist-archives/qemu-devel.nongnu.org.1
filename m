Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E36746014
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 17:49:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGLnP-00062C-5c; Mon, 03 Jul 2023 11:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1qGLnL-0005zc-Hi
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:48:55 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1qGLnJ-0001un-IQ
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:48:55 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-313f1085ac2so5131939f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 08:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688399331; x=1690991331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K6nvw44qQqM9g5knmzRWwl/2devY8jYCycM1edBfsPA=;
 b=xYCGqR8fBLyDSP4nCE3vVLK+nYwIAvJGXqAKyEzKuaoZiwp7exRZFqki8E+7kV5tQd
 zfxrTGXqTE8PX8r8Bv+hGPjF6KjoG8dlv+ka+9M61LYX41dWh5KGmCjC4zsvf7pdXvhf
 4I38ypnL0ZdrmtK/uBBiFu8iahdzqK1qrzY+fkr7KoiRCCad1aG4Mu+8brairUR1+8mx
 CdfqRRP+i66yMfhs4v07mRiPRd2G+MTdcx5gXdXx9dUZaEz9Xw4u5PabsBZnWogCNI7e
 GGOihEq5I0/GVdJ+3vWFGHp7EpKZxbZ56ZixhWXFa1RVDwcEiETrNW4acg5oR4nM7AvO
 QAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688399331; x=1690991331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K6nvw44qQqM9g5knmzRWwl/2devY8jYCycM1edBfsPA=;
 b=BrYaWma/k7zUPL/GDWYjYzfr78tu3BJ0qJrvs0sJKzCv6n7siub+WQaviVAtFljHqZ
 6TmXylaMGx6z4jMhGzT1/QWFxnN0ZVx1mORpbEPCLF1HAyffmshz1LmNeQUatLmjV5Ok
 lKk69iECtHq0Mpr8god+FU4rIKGTaaWx05jhzxyUgEQamg462ZhZClU36nNDO1fOJRVN
 lRY9MJjrfOmgODGICF4Bg93EpB7NUW0PAafQZcPmz7FpAGfkHdYqCiIefxENKg8nfcHL
 K0L9UOU7I55S9NXjR60Zc5BXuM4P+6e9cUwOFgoENu0Ba9ncCNpl6Zjmj/wVFy0r6LSa
 Bepw==
X-Gm-Message-State: ABy/qLZpYO8LqNbDkxlMFtbOh0ZHcuLY7e88KufeJsxEEb2qIFi1dvc0
 HMV2RUSB0WhkvhwzoRJC/S4hGRL9Y9xEsJ8aVe8=
X-Google-Smtp-Source: APBJJlGEJrZksWZvjFjtCuQHgLrLRpoxg4swelDn+SdWwua78FtYYbAqcWEx+WNYSqcGmXx8om2gCw==
X-Received: by 2002:adf:ee51:0:b0:314:2a9:1071 with SMTP id
 w17-20020adfee51000000b0031402a91071mr9711954wro.19.1688399331110; 
 Mon, 03 Jul 2023 08:48:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:5cc:caa0:6d79:3eab:6444:9cd4])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a05600004cf00b0030e52d4c1bcsm26154285wri.71.2023.07.03.08.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 08:48:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.henderson@linaro.org, sir@cmpwn.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] linux-user/syscall: Implement execve without execveat
Date: Mon,  3 Jul 2023 17:48:31 +0200
Message-Id: <20230703154831.1136575-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x434.google.com
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
 linux-user/syscall.c | 45 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f2cb101d83..b64ec3296a 100644
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
@@ -8520,9 +8521,12 @@ static int do_openat(CPUArchState *cpu_env, int dirfd, const char *pathname, int
     return safe_openat(dirfd, path(pathname), flags, mode);
 }
 
-static int do_execveat(CPUArchState *cpu_env, int dirfd,
-                       abi_long pathname, abi_long guest_argp,
-                       abi_long guest_envp, int flags)
+#define IS_EXECVEAT 0
+#define IS_EXECVE 1
+
+static int do_execv(CPUArchState *cpu_env, int dirfd,
+                    abi_long pathname, abi_long guest_argp,
+                    abi_long guest_envp, int flags, bool is_execve)
 {
     int ret;
     char **argp, **envp;
@@ -8601,10 +8605,18 @@ static int do_execveat(CPUArchState *cpu_env, int dirfd,
         goto execve_efault;
     }
 
-    if (is_proc_myself(p, "exe")) {
-        ret = get_errno(safe_execveat(dirfd, exec_path, argp, envp, flags));
+    if (is_execve == IS_EXECVE) {
+        if (is_proc_myself(p, "exe")) {
+            ret = get_errno(safe_execve(exec_path, argp, envp));
+        } else {
+            ret = get_errno(safe_execve(p, argp, envp));
+        }
     } else {
-        ret = get_errno(safe_execveat(dirfd, p, argp, envp, flags));
+        if (is_proc_myself(p, "exe")) {
+            ret = get_errno(safe_execveat(dirfd, exec_path, argp, envp, flags));
+        } else {
+            ret = get_errno(safe_execveat(dirfd, p, argp, envp, flags));
+        }
     }
 
     unlock_user(p, pathname, 0);
@@ -8633,6 +8645,25 @@ execve_end:
     return ret;
 }
 
+static int do_execveat(CPUArchState *cpu_env, int dirfd,
+                       abi_long pathname, abi_long guest_argp,
+                       abi_long guest_envp, int flags)
+{
+    return do_execv(cpu_env, dirfd,
+                    pathname, guest_argp, guest_envp, flags,
+                    IS_EXECVEAT);
+}
+
+static int do_execve(CPUArchState *cpu_env,
+                     abi_long pathname, abi_long guest_argp,
+                     abi_long guest_envp)
+{
+    return do_execv(cpu_env, AT_FDCWD,
+                    pathname, guest_argp, guest_envp, 0,
+                    IS_EXECVE);
+}
+
+
 #define TIMER_MAGIC 0x0caf0000
 #define TIMER_MAGIC_MASK 0xffff0000
 
@@ -9158,7 +9189,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_execveat:
         return do_execveat(cpu_env, arg1, arg2, arg3, arg4, arg5);
     case TARGET_NR_execve:
-        return do_execveat(cpu_env, AT_FDCWD, arg1, arg2, arg3, 0);
+        return do_execve(cpu_env, arg1, arg2, arg3);
     case TARGET_NR_chdir:
         if (!(p = lock_user_string(arg1)))
             return -TARGET_EFAULT;
-- 
2.40.1


