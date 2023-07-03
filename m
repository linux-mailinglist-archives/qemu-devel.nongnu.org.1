Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9DB746176
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 19:31:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGNNG-0004jJ-HK; Mon, 03 Jul 2023 13:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qGNNC-0004ix-W6
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 13:30:03 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qGNNA-0003xs-Gf
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 13:30:02 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C24D6111BE;
 Mon,  3 Jul 2023 20:29:56 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CFBE01162E;
 Mon,  3 Jul 2023 20:29:55 +0300 (MSK)
Message-ID: <08f9669f-1022-2b9c-4ca5-2f16bc1a2fda@tls.msk.ru>
Date: Mon, 3 Jul 2023 20:29:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] linux-user/syscall: Implement execve without execveat
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.henderson@linaro.org, sir@cmpwn.com
References: <20230703154831.1136575-1-pierrick.bouvier@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230703154831.1136575-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

03.07.2023 18:48, Pierrick Bouvier пишет:
> Support for execveat syscall was implemented in 55bbe4 and is available
> since QEMU 8.0.0. It relies on host execveat, which is widely available
> on most of Linux kernels today.
> 
> However, this change breaks qemu-user self emulation, if "host" qemu
> version is less than 8.0.0. Indeed, it does not implement yet execveat.
> This strange use case happens with most of distribution today having
> binfmt support.
> 
> With a concrete failing example:
> $ qemu-x86_64-7.2 qemu-x86_64-8.0 /bin/bash -c /bin/ls
> /bin/bash: line 1: /bin/ls: Function not implemented
> -> not implemented means execve returned ENOSYS
> 
> qemu-user-static 7.2 and 8.0 can be conveniently grabbed from debian
> packages qemu-user-static* [1].
> 
> One usage of this is running wine-arm64 from linux-x64 (details [2]).
> This is by updating qemu embedded in docker image that we ran into this
> issue.
> 
> The solution to update host qemu is not always possible. Either it's
> complicated or ask you to recompile it, or simply is not accessible
> (GitLab CI, GitHub Actions). Thus, it could be worth to implement execve
> without relying on execveat, which is the goal of this patch.
> 
> This patch was tested with example presented in this commit message.
> 
> [1] http://ftp.us.debian.org/debian/pool/main/q/qemu/
> [1] https://www.linaro.org/blog/emulate-windows-on-arm/
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   linux-user/syscall.c | 45 +++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 38 insertions(+), 7 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index f2cb101d83..b64ec3296a 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -659,6 +659,7 @@ safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
>   #endif
>   safe_syscall5(int, waitid, idtype_t, idtype, id_t, id, siginfo_t *, infop, \
>                 int, options, struct rusage *, rusage)
> +safe_syscall3(int, execve, const char *, filename, char **, argv, char **, envp)
>   safe_syscall5(int, execveat, int, dirfd, const char *, filename,
>                 char **, argv, char **, envp, int, flags)
>   #if defined(TARGET_NR_select) || defined(TARGET_NR__newselect) || \
> @@ -8520,9 +8521,12 @@ static int do_openat(CPUArchState *cpu_env, int dirfd, const char *pathname, int
>       return safe_openat(dirfd, path(pathname), flags, mode);
>   }
>   
> -static int do_execveat(CPUArchState *cpu_env, int dirfd,
> -                       abi_long pathname, abi_long guest_argp,
> -                       abi_long guest_envp, int flags)
> +#define IS_EXECVEAT 0
> +#define IS_EXECVE 1
> +
> +static int do_execv(CPUArchState *cpu_env, int dirfd,
> +                    abi_long pathname, abi_long guest_argp,
> +                    abi_long guest_envp, int flags, bool is_execve)
>   {
>       int ret;
>       char **argp, **envp;
> @@ -8601,10 +8605,18 @@ static int do_execveat(CPUArchState *cpu_env, int dirfd,
>           goto execve_efault;
>       }
>   
> -    if (is_proc_myself(p, "exe")) {
> -        ret = get_errno(safe_execveat(dirfd, exec_path, argp, envp, flags));
> +    if (is_execve == IS_EXECVE) {

is_execve is either bool or not. I'd use it as bool, and pass true/false.
Right now it is inconsistent.

> +        if (is_proc_myself(p, "exe")) {
> +            ret = get_errno(safe_execve(exec_path, argp, envp));
> +        } else {
> +            ret = get_errno(safe_execve(p, argp, envp));
> +        }
>       } else {
> -        ret = get_errno(safe_execveat(dirfd, p, argp, envp, flags));
> +        if (is_proc_myself(p, "exe")) {
> +            ret = get_errno(safe_execveat(dirfd, exec_path, argp, envp, flags));
> +        } else {
> +            ret = get_errno(safe_execveat(dirfd, p, argp, envp, flags));
> +        }
>       }

And this can be simplified quite a bit by using a condition on
is_proc_myself(p, "exe"):

   if (is_proc_myself(p, exe)) {
      p = exec_path;
   }
   ret = is_excveat ?
     safe_execveat(dirfd, p, argp, envp, flags) :
     safe_execve(p, argp, envp);
   ret = get_errno(ret);
   ...

I dunno which way Laurent might prefer, but to my taste this way it is
much more readable (give or take the proper coding style to use here, -
I don't remember how the arithmetic if should be styled).

>   
>       unlock_user(p, pathname, 0);
> @@ -8633,6 +8645,25 @@ execve_end:
>       return ret;
>   }
>   
> +static int do_execveat(CPUArchState *cpu_env, int dirfd,
> +                       abi_long pathname, abi_long guest_argp,
> +                       abi_long guest_envp, int flags)
> +{
> +    return do_execv(cpu_env, dirfd,
> +                    pathname, guest_argp, guest_envp, flags,
> +                    IS_EXECVEAT);
> +}
> +
> +static int do_execve(CPUArchState *cpu_env,
> +                     abi_long pathname, abi_long guest_argp,
> +                     abi_long guest_envp)
> +{
> +    return do_execv(cpu_env, AT_FDCWD,
> +                    pathname, guest_argp, guest_envp, 0,
> +                    IS_EXECVE);
> +}
> +
> +
>   #define TIMER_MAGIC 0x0caf0000
>   #define TIMER_MAGIC_MASK 0xffff0000
>   
> @@ -9158,7 +9189,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>       case TARGET_NR_execveat:
>           return do_execveat(cpu_env, arg1, arg2, arg3, arg4, arg5);
>       case TARGET_NR_execve:
> -        return do_execveat(cpu_env, AT_FDCWD, arg1, arg2, arg3, 0);
> +        return do_execve(cpu_env, arg1, arg2, arg3);

FWIW, there's no need to implement the intermediate wrapper functions,
it's fine to run do_execv(..., true/false) here directly.


Overall, this smells like a -stable material.

Thanks!

/mjt

