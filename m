Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CFD74C717
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:33:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAk-0008SX-5a; Sun, 09 Jul 2023 14:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAc-0008PH-DF
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:06 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAa-0000So-DY
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:06 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbc59de0e2so39209095e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927402; x=1691519402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6hJ2cBLCXpJZWqn0v9yRV3HoMGVrJoXrdXR9GSCECU=;
 b=nLPER94Y+i+FGuqXGwSel/YLsXT1LzhmaqVciKXmpVQFfNeui+lwZX1plKlxZ56hyF
 BMgli/IHSlsJS5tvz0nl9P7LimSIn5sa4y4ARM9O9RNfE5jG5MThWJhC37qg/RHv+idg
 r+z6asWyT1CXECOesY4BhBQ9UBKXdq5IM8vCHpd7Lor/MS1bvFJUfTPN4v80uQy49Y7U
 YDPINJlqmYida15xJTqXMWzYBLyX6DOCQyfQB3KF74/cPYFFUCRunryReY0GNjX770eJ
 yIv7lJTKtPKysh5fV7Mfpc+o4AuiH9SJpWPCUPHAtYZbKkir9J/uTOPIltPdXaB9sF6e
 1jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927402; x=1691519402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M6hJ2cBLCXpJZWqn0v9yRV3HoMGVrJoXrdXR9GSCECU=;
 b=P/qHYiWW0LzH7o1mGPMLLYEqAFN0unppJ9sq/zoeS4QJcmj586bzfAAleffpSoLKyV
 h99fsC1Z31zEBK0+VwQ9oeQjnZbZs68NY+n6eN28FUm5+UmDrMTjWHWUjshAlRKSoCko
 KBFxzAUDDbUL7T6E/BsOsaSUCB2byaje5xI2WXn2K0raHVtILmAMF4ThQlFsB0ZCHUgk
 m2BgMjwuTaj9TFEYZLkiRoOCdTbOG9dBIkBHppr9PSjkD0d9kZxEwb4XIxSccQPRv4bT
 DmWyQbGkJ+Ra04EZDbpv6XzPVWX0YVR/OLnCzwrXEK1O9idE4hZ0IHs3pTN1l9xBMfhq
 AZLw==
X-Gm-Message-State: ABy/qLbrG+7lzA+cJX5RjO/OluCazKulU66Qr//UhKLEHxj8ks7pzOk3
 8H01tWW+zqS8JQ33LqCSgzmPwUTM3p8Hkf91n331Lg==
X-Google-Smtp-Source: APBJJlHeW/uBvC8XehZ2mIRLtKHJb8+F1uWarobYvZjlgN/HFwFvybN0fagU92dVzOyhyEcaTKiiag==
X-Received: by 2002:a7b:cd08:0:b0:3fb:b248:67c with SMTP id
 f8-20020a7bcd08000000b003fbb248067cmr9227054wmj.22.1688927402578; 
 Sun, 09 Jul 2023 11:30:02 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:30:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 16/45] linux-user/syscall: Implement execve without execveat
Date: Sun,  9 Jul 2023 19:28:43 +0100
Message-Id: <20230709182934.309468-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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
2.34.1


