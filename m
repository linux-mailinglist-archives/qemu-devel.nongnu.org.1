Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5EC74821C
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 12:27:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGziX-0001cT-PJ; Wed, 05 Jul 2023 06:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qGziU-0001cI-WA
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 06:26:35 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qGziS-0001cC-UJ
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 06:26:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D5AF711980;
 Wed,  5 Jul 2023 13:26:30 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B2DF512FA0;
 Wed,  5 Jul 2023 13:26:29 +0300 (MSK)
Message-ID: <8fbd6900-7c33-17e4-600a-e4799719686b@tls.msk.ru>
Date: Wed, 5 Jul 2023 13:26:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] linux-user/syscall: Implement execve without execveat
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.henderson@linaro.org, sir@cmpwn.com
References: <20230705090056.610699-1-pierrick.bouvier@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230705090056.610699-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

05.07.2023 12:00, Pierrick Bouvier wrote:
...
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 08162cc966..4945ddd7f2 100644
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
> @@ -8615,9 +8616,9 @@ ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz)
>       return ret;
>   }
>   
> -static int do_execveat(CPUArchState *cpu_env, int dirfd,
> -                       abi_long pathname, abi_long guest_argp,
> -                       abi_long guest_envp, int flags)
> +static int do_execv(CPUArchState *cpu_env, int dirfd,
> +                    abi_long pathname, abi_long guest_argp,
> +                    abi_long guest_envp, int flags, bool is_execveat)
>   {
>       int ret;
>       char **argp, **envp;
> @@ -8696,11 +8697,14 @@ static int do_execveat(CPUArchState *cpu_env, int dirfd,
>           goto execve_efault;
>       }
>   
> +    const char* exe = p;
>       if (is_proc_myself(p, "exe")) {
> -        ret = get_errno(safe_execveat(dirfd, exec_path, argp, envp, flags));
> -    } else {
> -        ret = get_errno(safe_execveat(dirfd, p, argp, envp, flags));
> +        exe = exec_path;
>       }
> +    ret = is_execveat ?
> +        safe_execveat(dirfd, exe, argp, envp, flags):
> +        safe_execve(exe, argp, envp);
> +    ret = get_errno(ret);


This one has 2 issues reported by checkpatch.pl:

$ git show | ./scripts/checkpatch.pl -

ERROR: "foo* bar" should be "foo *bar"
#161: FILE: linux-user/syscall.c:8700:
+    const char* exe = p;

ERROR: spaces required around that ':' (ctx:VxE)
#169: FILE: linux-user/syscall.c:8705:
+        safe_execveat(dirfd, exe, argp, envp, flags):
                                                      ^

total: 2 errors, 0 warnings, 47 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

As I mentioned in the v1, I don't remember offhand how the arithmetic if
should be styled in qemu.  At the very best, the v2 variant is difficult
to read because ":" is too close to ";" visually, an extra space before
it will make it more explicit.

Other than that, I'm fine with this version.

With the checkpatch issues fixed,

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

Thanks,

/mjt

