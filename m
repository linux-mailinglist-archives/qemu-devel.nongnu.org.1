Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 995677483ED
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 14:11:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH1LO-0000MF-TI; Wed, 05 Jul 2023 08:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1qH1LM-0000M6-HZ
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 08:10:48 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1qH1LK-0004lX-Lk
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 08:10:48 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57ddso42567775e9.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 05:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688559045; x=1691151045;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gYs2uf4E6ilVJCM5ejmSh+SbQvFc6D+nHyfhsg7r/hs=;
 b=Eh/e6uLDgTSseouivU0ig1c5A6QRqqvFzFPEWMzWFizd+3oBXBemJbbxCtuRtWeimL
 VxVgUPcDBcgxn+UbqhiqOd1kdCIgfQ/eSx9isAJbYxeOtldz9MX4XL3bKByDn6iyCVbN
 Qo5SBqnbYKHJbKbqwkvFqp3LKy8FvI1eZySMHFMxkEJinIfsriECbNUe3n21KT3+Q/f3
 Ryiwq/5e/aI85cARShkWWx1PNCPbPyoP52l8bWkm8ze0rAfTiGp5Xb7cf2+JiGuu1WMR
 F9oE68XQ4MGIhnUaGWeLnxPTf0/+JJ4ucakq5p86DY08eYeyRbRGk+1XAqos9msgXf6R
 t6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688559045; x=1691151045;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gYs2uf4E6ilVJCM5ejmSh+SbQvFc6D+nHyfhsg7r/hs=;
 b=BEuRNZamxRX43NeakEGzlp6yVLwkVDqwrDLxYtOc3SwWCaaP5eD1JtXdxc3F5siA2a
 NHgcONoRRtJwWg+CNauuLnnGGHawL3T+XIJWuLijv7VRqbBYx1XEkeZ3CO9GCw3nfmxs
 LszaYjn8LbkKzeeJjhQatweytUrYE/qVdoSutwIgtwxw7QjoCGnNol+UdB/G4U/oz5Tq
 Bcpo9AGdnU9b6/BaEEIqT3J+AHJYfv1TgDCkvkQM0loy7DXxgRIZQhJFhLChvLued6Zm
 paa0Z4xwhZq1eHOHFIt7uiZvzRq5lw3cNLhPLo0y/ASpo8HmjikMEOIwEFlyQJh2svK/
 gwFA==
X-Gm-Message-State: AC+VfDzfsfulX+WmPm1YBai8dhS4QIjMqB6vcktJSmgTGLVJHMv7hDmh
 8l/R97XKxxWBbfsYy2VYr4ITchBCl/TNAwgxgs8=
X-Google-Smtp-Source: ACHHUZ5BQCdEMc0V9scESQ/OvPFN7E2tnpmtCWNkfjDH5TOifypDzsIWNW1DvR4S+If6tciq4c4krg==
X-Received: by 2002:a05:600c:364f:b0:3f9:b1e7:8a4b with SMTP id
 y15-20020a05600c364f00b003f9b1e78a4bmr12949237wmq.21.1688559044697; 
 Wed, 05 Jul 2023 05:10:44 -0700 (PDT)
Received: from localhost.localdomain ([31.32.81.187])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a7bca4c000000b003fa96fe2bd9sm1972988wml.22.2023.07.05.05.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 05:10:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.henderson@linaro.org, sir@cmpwn.com,
 philmd@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3] linux-user/syscall: Implement execve without execveat
Date: Wed,  5 Jul 2023 14:10:23 +0200
Message-Id: <20230705121023.973284-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x331.google.com
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
index 08162cc966..90777c5833 100644
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
 
+    const char *exe = p;
     if (is_proc_myself(p, "exe")) {
-        ret = get_errno(safe_execveat(dirfd, exec_path, argp, envp, flags));
-    } else {
-        ret = get_errno(safe_execveat(dirfd, p, argp, envp, flags));
+        exe = exec_path;
     }
+    ret = is_execveat
+        ? safe_execveat(dirfd, exe, argp, envp, flags)
+        : safe_execve(exe, argp, envp);
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


