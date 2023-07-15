Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 742777548FD
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:56:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfj7-0004ZL-Ra; Sat, 15 Jul 2023 09:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiL-00044I-0H
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:38 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiH-0001GP-RO
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:35 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-307d20548adso2876430f8f.0
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429212; x=1692021212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WkQYBTdmbAtTnWW2W9s3BK95MSziKUcKtiWY2RX73t0=;
 b=PptHln31sBhZ5BPAO2orRGKH/Od5By8a2EuS+D8d8AfX+pSxoVzQAlxCC/tERMrQ9Y
 JHcrFyshgkOXoaTEUxiAgK083lrgzCbeGm1uzW8Dzor/MF76OEPzHvSWIsgF7iEGLrH6
 eFHInefQd7IBXwoOrBxUeWAEfyUhvaVszrd6mu1HLdh+/9mmh5llMS0nolBNs/Q0TpdJ
 bTcfegMowBDPU2rAyUSCPw8rm1dCzjkLhYlHRiZguQoctlT1GnOmcKwtpWrp3dvgBWko
 mrxV0+iGntdjI5QLdEcAl1eltvwFKX4g2hLkvTUYzmwAJMpKhTYwNS6GvE9BTeS4XnbB
 Rtbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429212; x=1692021212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WkQYBTdmbAtTnWW2W9s3BK95MSziKUcKtiWY2RX73t0=;
 b=Und6NmTJb/rpToM5neOwtP6TEC6g9u1rQRTPAM8BfDQ3yDm2/vYL+LiG8fPLV6VBrx
 kOFazekyVdMbEB7v+5/6q3UD8UeIwqIKp9rhH9OHBuCsx/h1OdSFW2+J5FYJmwPyvQkm
 lf4EZnUz0cII9a26XGKeNRkeL4AAyCh8geZbKGqll/y6DX358FdczHkQKcaBmyVHVP6W
 xmbFBSRZASG5IhWHfKlcWbTJY55UXglp0OZGUkWRzoTNZuvBwErphPWOWBZcFWienGM6
 TLwFLLXDht/fUrnVxQmPIVcqMWstXkGwMNQbRw4l7x4L92Ifvf/3aPwCCdonUxarU9lb
 UGzQ==
X-Gm-Message-State: ABy/qLbnB/9FinpdCpX0hU/PF5/aMm0YUZ4qWJyCLVjYn3BZcKcLYiqa
 SPjfID11PNCdbYDv8h1fGlfydVtofE+/UhL4OYCyDQ==
X-Google-Smtp-Source: APBJJlEt1xGF9soNsuuH/EiAMLfEA/8PMzdoYLjrJt7UJZILjdxOJnWU8G5ckhsVVkzXgh5zQIE1JA==
X-Received: by 2002:a5d:4b10:0:b0:314:1ddc:ecbd with SMTP id
 v16-20020a5d4b10000000b003141ddcecbdmr6019130wrq.18.1689429212471; 
 Sat, 15 Jul 2023 06:53:32 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 16/47] linux-user/syscall: Implement execve without execveat
Date: Sat, 15 Jul 2023 14:52:46 +0100
Message-Id: <20230715135317.7219-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20230705121023.973284-1-pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 420bab7c68..c15d9ad743 100644
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
@@ -8629,9 +8630,9 @@ ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz)
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
@@ -8710,11 +8711,14 @@ static int do_execveat(CPUArchState *cpu_env, int dirfd,
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
 
@@ -9406,9 +9410,9 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
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
2.34.1


