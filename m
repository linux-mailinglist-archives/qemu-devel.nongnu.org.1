Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CA081F9C7
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 16:51:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIsdm-00058x-9u; Thu, 28 Dec 2023 10:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rIsdk-00058k-2p
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 10:49:44 -0500
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rIsdg-0002Uh-K5
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 10:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703778575; x=1704383375; i=deller@gmx.de;
 bh=XI0YSkV67rTi0j8Jnq5X0YKvRv8KueoLtcov7ypnI4U=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=e8xPrDicCpb2PJdPvEC1ybn34glMDntApI9h5gkYYZ0WOFppT8IUN97lrOyl+bKX
 woshAncUfsQ3+CKuqlacO92vn2vZ8A7GlzZTRfZ3u+GCQiBiQ89za6lY1feNaTcOX
 Xeq+BmoP06El+LIg4I0VVChNHrFocYgld9RBjVR+McPyAkt3a3MWu14RTGkMDMl79
 9Ns95XDJgKxZijSN1uBBBv2mvDn6SFHMeyRfR2C9XSwEq6i1pEIT/a/bOdor1F9KT
 1drCcE2Ov83HwnAtM1txdLoMs07HmZQVXf3XHjk0Zqw1FlVea5n40z5MeSlbtKgz6
 5r7f+KIvvGIoArGZdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.144.42]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79yQ-1rB7rf31TA-017Sus; Thu, 28
 Dec 2023 16:49:35 +0100
Message-ID: <e7ce2432-aba7-4893-b828-7f5df6cbe9a6@gmx.de>
Date: Thu, 28 Dec 2023 16:49:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] linux-user: Fix openat() emulation to not modify
 atime
Content-Language: en-US
To: Shu-Chun Weng <scw@google.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20231208224207.613445-1-scw@google.com>
 <20231208224207.613445-3-scw@google.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20231208224207.613445-3-scw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ffKNd0VceiV9CbwOPI4InDS/1ULwb9Bp70Z0SQotDUmfD2nIj3C
 sWtf28dPh086ToGw1iUz8A9GA0q6YfnQvR42ldvjfgDKLG1sEiYJ/7dQXnSmBYLPR4jRVlA
 5hV+i6qMKhjm0qYwY/oLBAc0Leyx0vnwWT9917oUAkJKxQk2E+T9yNFvM7rghvok6ydEzlv
 WpR9IyMPyqBVQ/hJjEvWQ==
UI-OutboundReport: notjunk:1;M01:P0:IUNRSu3gaKo=;V8cBiL8dSXLFFmV6hUCifYpdh9P
 ZUHVywCgGZ6I8pL1v2mB0e+tcTMB0ynQ4UjTK50p1kqMdQsplyQ0eon1w6UoOfEtBT7+UXpyz
 Ihn88ntv4iGCgams/oBpgb+tFPDmEcY4c3h2bEo36FFs/jNqefcNwU51yOS/Tm7a0uoWqBkHJ
 qFftnHrZy+RVAW3mn3s/T4xVyz6EiY9wDbURQoaLSeNj8XOZRadxJrDVO2ExUqSPYOFEezaDb
 eUokAODawC+tZMw/LLjX01cCfgrPLEHHHtS0CkLi+lBnP7lJ9NiLh0Fd7Ntd5qt549P24gb8g
 WmnzkSwOz6/0Wo91VgKZTdDK6RnPJ834KPBFEa6hZz5BovnBc7gYhWE8Og4uDva2XB2HyMbwN
 l15PwT7LII5ZNXJwSrNPANh2LYlVgya+vAkCsGIlRZYcGlVIKYkOphEJEfDRHoACI4EeG+E8C
 e5/5FIYPpfENDO5GTkt4zUdNNiQWYGqD/CKnKvtwZriy6Gv5SyFdZU8UQtcITulE6HESN+Iy+
 BWK/JeedxapVctBS/I43syveg0ji4eWFatcPY1fPLnn+UJkQAYE1Qt0ItOFLbdP9cEAhTZw4Z
 8gHCqtTOGvjuIXlka02NN0/01Gzao5FaKvezSlYxG3tmZtSuFDgJoctaFNwkoqnCik3wiGp4O
 UksoXpaIj7ZHaZYyjG03/6Mfd90cF1yP8cwZnxREBGgu87qpWzCrgc5eSwJm5Xwanz65PLBjD
 ms6KlHTwJVkfgzu7UZzlV+n48ozN6u6pSd5qZpPclF9jFIdnw6vau5qLxlboR+sZDgKcj/HZF
 FxwI7wfuEaCAX66NdhDTDPefX33kzAc7kFNHWmHpLEmOSEYzDJsqClMUR3EiQbc0UDtHrXxNU
 Ivi18Fp16lekAuMhXBulDfrMSOX1EFQlX8H4xMMFORiIfcWXwLrseBHM16SrN9UjriwPBPyfX
 ekIS0VjO5J18NdOq0BX2HOClSXU=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 12/8/23 23:42, Shu-Chun Weng wrote:
> Commit b8002058 strengthened openat()'s /proc detection by calling
> realpath(3) on the given path, which allows various paths and symlinks
> that points to the /proc file system to be intercepted correctly.
>
> Using realpath(3), though, has a side effect that it reads the symlinks
> along the way, and thus changes their atime. The results in the
> following code snippet already get ~now instead of the real atime:
>
>    int fd =3D open("/path/to/a/symlink", O_PATH | O_NOFOLLOW);
>    struct stat st;
>    fstat(fd, st);
>    return st.st_atime;
>
> This change opens a path that doesn't appear to be part of /proc
> directly and checks the destination of /proc/self/fd/n to determine if
> it actually refers to a file in /proc.
>
> Neither this nor the existing code works with symlinks or indirect paths
> (e.g.  /tmp/../proc/self/exe) that points to /proc/self/exe because it
> is itself a symlink, and both realpath(3) and /proc/self/fd/n will
> resolve into the location of QEMU.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2004
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
>   linux-user/syscall.c | 47 +++++++++++++++++++++++++++++++++++---------
>   1 file changed, 38 insertions(+), 9 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e384e14248..7c3772301f 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8308,8 +8308,7 @@ static int open_net_route(CPUArchState *cpu_env, i=
nt fd)
>   int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fnam=
e,
>                       int flags, mode_t mode, bool safe)
>   {
> -    g_autofree char *proc_name =3D NULL;
> -    const char *pathname;
> +    g_autofree char *pathname =3D NULL;
>       struct fake_open {
>           const char *filename;
>           int (*fill)(CPUArchState *cpu_env, int fd);
> @@ -8334,12 +8333,42 @@ int do_guest_openat(CPUArchState *cpu_env, int d=
irfd, const char *fname,
>           { NULL, NULL, NULL }
>       };
>
> -    /* if this is a file from /proc/ filesystem, expand full name */
> -    proc_name =3D realpath(fname, NULL);
> -    if (proc_name && strncmp(proc_name, "/proc/", 6) =3D=3D 0) {
> -        pathname =3D proc_name;
> +    if (strncmp(fname, "/proc/", 6) =3D=3D 0) {
> +        pathname =3D g_strdup(fname);
>       } else {
> -        pathname =3D fname;
> +        g_autofree char *proc_name =3D NULL;
> +        struct stat proc_stat;
> +        int fd;
> +
> +        if (safe) {
> +            fd =3D safe_openat(dirfd, path(fname), flags, mode);
> +        } else {
> +            fd =3D openat(dirfd, path(fname), flags, mode);
> +        }
> +        if (fd < 0) {
> +            return fd;
> +        }
> +
> +        /*
> +         * Try to get the real path of the file we just opened. We avoi=
d calling
> +         * `realpath(3)` because it calls `readlink(2)` on symlinks whi=
ch
> +         * changes their atime. Note that since `/proc/self/exe` is a s=
ymlink,
> +         * `pathname` will never resolve to it (neither will `realpath(=
3)`).
> +         * That's why we check `fname` against the "/proc/" prefix firs=
t.
> +         */
> +        proc_name =3D g_strdup_printf("/proc/self/fd/%d", fd);
> +        if (lstat(proc_name, &proc_stat) < 0 || !S_ISLNK(proc_stat.st_m=
ode)) {
> +            /* No procfs or something weird. Not going to dig further. =
*/
> +            return fd;
> +        }
> +        pathname =3D g_new(char, proc_stat.st_size + 1);
> +        readlink(proc_name, pathname, proc_stat.st_size + 1);

this gives a build error for me:
./qemu/linux-user/syscall.c:8365:9: error: ignoring return value of =E2=80=
=98readlink=E2=80=99 declared with attribute =E2=80=98warn_unused_result=
=E2=80=99 [-Werror=3Dunused-result]

Other than that, this patch indeed fixes the issue #2004

Reviewed-by: Helge Deller <deller@gmx.de>


Helge

> +
> +        /* if this is not a file from /proc/ filesystem, the fd is good=
 as-is */
> +        if (strncmp(pathname, "/proc/", 6) !=3D 0) {
> +            return fd;
> +        }
> +        close(fd);
>       }
>
>       if (is_proc_myself(pathname, "exe")) {
> @@ -8390,9 +8419,9 @@ int do_guest_openat(CPUArchState *cpu_env, int dir=
fd, const char *fname,
>       }
>
>       if (safe) {
> -        return safe_openat(dirfd, path(pathname), flags, mode);
> +        return safe_openat(dirfd, pathname, flags, mode);
>       } else {
> -        return openat(dirfd, path(pathname), flags, mode);
> +        return openat(dirfd, pathname, flags, mode);
>       }
>   }
>
>


