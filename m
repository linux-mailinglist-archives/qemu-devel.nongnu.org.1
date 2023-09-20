Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C077A8C23
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:58:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj2ON-0006zc-RD; Wed, 20 Sep 2023 14:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2OJ-0006zS-7A
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:57:39 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2OG-0007Wx-2J
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:57:38 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-502b0d23f28so314424e87.2
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695236252; x=1695841052;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KpgRaQ2wkdTKp6KYgkItdcUOhFI1J8neImjQpPw41IY=;
 b=o3iLkyaITq1KhQv29oT7XusGd3v6jYGdjVNO9YZOgqbqMUMx85DIVrHfto+HQBZSvQ
 mHS39aX521S/EH5qmwPun+bEkAxHhaxGbC4vxlogaTkEs7Byut2yYJjIDnAIaO6k3I5q
 SohLvFOyAydOZ0cgWWldHNoELcamSrOmHydfjzyVaqH0TplFrf+njhH25Urq9Zt79+ch
 8EBUDG6UbYlPeH0FONuF2yaWQ/KQTjuzN6XXWjn2OZo57+omRdqBGQNDlGf9B14kX7kG
 +2r4tFSWL/SfL4Y/e6rWkj9j9jujitVdtO/W3w7o0MVfa54INS3e9vphtDrtnPB4VmNc
 SaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695236252; x=1695841052;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KpgRaQ2wkdTKp6KYgkItdcUOhFI1J8neImjQpPw41IY=;
 b=X3dVi5KYZdbGHqKbLSwYNWH3vLbkqj8JXaRzvyGjQZuMkRl2VQZ/RtfpmcTRt1S1bw
 cJoGDAYWdbKapGEpDTJxf7h8i5ZhxKvkc9PiTVZR+ZCIz1csce8mqBpnaGmkzsLH9Pzu
 oc3Hrmnb/bsFvfISID6vGWlW8Vln3uerOzK3DDAX0BuW+8Vrgsus2kH6gkYe5H8lUEA6
 11cw33V5izLD6SyNvNrmFHqE7ya+wolJz55Ft1EQVdNORvmXy3eEwsS/fG1iL/FqbI3K
 0vdzOH3+GHS7ah3YaMYNYadK1qVxEG8Bf/SMMRmOOXUZQaInMGmjMQV6Ci4IS53s6qG6
 Rbpg==
X-Gm-Message-State: AOJu0YyVL7YMje392I2GHUKC5d8xG4QmVSjWQmikDqH/85L8z69IGnGX
 yuWhWJdYRg3w4rhMaCV60y5W2871t4WVxk8H5V0lWQ/znSML243SCZ/SO9fa
X-Google-Smtp-Source: AGHT+IExAulnI/C4LiMmd9dCeC6fzpVOexwlr2NE3RBgT94ujP1yj3BZgme2Hu79iE0faW6xcT5ItOBd2xc5n9983mU=
X-Received: by 2002:ac2:5283:0:b0:502:feeb:48b2 with SMTP id
 q3-20020ac25283000000b00502feeb48b2mr2940078lfm.35.1695236251752; Wed, 20 Sep
 2023 11:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-21-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-21-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 19:57:21 +0100
Message-ID: <CANCZdfr1ow3YCvSo-75ycj9zniFG0F7FF3jZXLV+qh_jjdAAtw@mail.gmail.com>
Subject: Re: [PATCH v2 20/28] bsd-user: Implement freebsd_exec_common, used in
 implementing execve/fexecve.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000098b5aa0605cef20d"
Received-SPF: none client-ip=2a00:1450:4864:20::133;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--00000000000098b5aa0605cef20d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 10:39=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/freebsd/os-proc.c | 177 +++++++++++++++++++++++++++++++++++++
>  bsd-user/main.c            |   2 +-
>  bsd-user/qemu.h            |   1 +
>  3 files changed, 179 insertions(+), 1 deletion(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

But see comment below.


> diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
> index cb35f29f10..12d78b7fc9 100644
> --- a/bsd-user/freebsd/os-proc.c
> +++ b/bsd-user/freebsd/os-proc.c
> @@ -78,3 +78,180 @@ out:
>      return ret;
>  }
>
> +/*
> + * execve/fexecve
> + */
> +abi_long freebsd_exec_common(abi_ulong path_or_fd, abi_ulong guest_argp,
> +        abi_ulong guest_envp, int do_fexec)
> +{
> +    char **argp, **envp, **qargp, **qarg1, **qarg0, **qargend;
> +    int argc, envc;
> +    abi_ulong gp;
> +    abi_ulong addr;
> +    char **q;
> +    int total_size =3D 0;
> +    void *p;
> +    abi_long ret;
> +
> +    argc =3D 0;
> +    for (gp =3D guest_argp; gp; gp +=3D sizeof(abi_ulong)) {
> +        if (get_user_ual(addr, gp)) {
> +            return -TARGET_EFAULT;
> +        }
> +        if (!addr) {
> +            break;
> +        }
> +        argc++;
> +    }
> +    envc =3D 0;
> +    for (gp =3D guest_envp; gp; gp +=3D sizeof(abi_ulong)) {
> +        if (get_user_ual(addr, gp)) {
> +            return -TARGET_EFAULT;
> +        }
> +        if (!addr) {
> +            break;
> +        }
> +        envc++;
> +    }
> +
> +    qarg0 =3D argp =3D g_new0(char *, argc + 9);
> +    /* save the first agrument for the emulator */
> +    *argp++ =3D (char *)getprogname();
> +    qargp =3D argp;
> +    *argp++ =3D (char *)getprogname();
> +    qarg1 =3D argp;
> +    envp =3D g_new0(char *, envc + 1);
> +    for (gp =3D guest_argp, q =3D argp; gp; gp +=3D sizeof(abi_ulong), q=
++) {
> +        if (get_user_ual(addr, gp)) {
> +            ret =3D -TARGET_EFAULT;
> +            goto execve_end;
> +        }
> +        if (!addr) {
> +            break;
> +        }
> +        *q =3D lock_user_string(addr);
> +        if (*q =3D=3D NULL) {
> +            ret =3D -TARGET_EFAULT;
> +            goto execve_end;
> +        }
> +        total_size +=3D strlen(*q) + 1;
> +    }
> +    *q++ =3D NULL;
> +    qargend =3D q;
> +
> +    for (gp =3D guest_envp, q =3D envp; gp; gp +=3D sizeof(abi_ulong), q=
++) {
> +        if (get_user_ual(addr, gp)) {
> +            ret =3D -TARGET_EFAULT;
> +            goto execve_end;
> +        }
> +        if (!addr) {
> +            break;
> +        }
> +        *q =3D lock_user_string(addr);
> +        if (*q =3D=3D NULL) {
> +            ret =3D -TARGET_EFAULT;
> +            goto execve_end;
> +        }
> +        total_size +=3D strlen(*q) + 1;
> +    }
> +    *q =3D NULL;
> +
> +    /*
> +     * This case will not be caught by the host's execve() if its
> +     * page size is bigger than the target's.
> +     */
> +    if (total_size > MAX_ARG_PAGES * TARGET_PAGE_SIZE) {
> +        ret =3D -TARGET_E2BIG;
> +        goto execve_end;
> +    }
> +
> +    if (do_fexec) {
> +        if (((int)path_or_fd > 0 &&
> +            is_target_elf_binary((int)path_or_fd)) =3D=3D 1) {
> +            char execpath[PATH_MAX];
> +
> +            /*
> +             * The executable is an elf binary for the target
> +             * arch.  execve() it using the emulator if we can
> +             * determine the filename path from the fd.
> +             */
>

So we do this fd dance so we can make things like 'qemu-arm-static
/armv7/bin/sh' work.
Doug Rabson has some changes that means we can ditch this, I think, since
the
kernel will just track it and it will default to 'what is doing the current
process'
rather than the system default for the same binfmt entry.


> +            if (get_filename_from_fd(getpid(), (int)path_or_fd, execpath=
,
> +                        sizeof(execpath)) !=3D NULL) {
> +                memmove(qarg1 + 2, qarg1, (qargend - qarg1) *
> sizeof(*qarg1));
> +                qarg1[1] =3D qarg1[0];
> +                qarg1[0] =3D (char *)"-0";
> +                qarg1 +=3D 2;
> +                qargend +=3D 2;
> +                *qarg1 =3D execpath;
> +#ifndef DONT_INHERIT_INTERP_PREFIX
> +                memmove(qarg1 + 2, qarg1, (qargend - qarg1) *
> sizeof(*qarg1));
> +                *qarg1++ =3D (char *)"-L";
> +                *qarg1++ =3D (char *)interp_prefix;
> +#endif
>

And we do this inheritance so we can pass in a non-standard library path,
maybe for testing, and have the above example also work.

Warner


> +                ret =3D get_errno(execve(qemu_proc_pathname, qargp, envp=
));
> +            } else {
> +                /* Getting the filename path failed. */
> +                ret =3D -TARGET_EBADF;
> +                goto execve_end;
> +            }
> +        } else {
> +            ret =3D get_errno(fexecve((int)path_or_fd, argp, envp));
> +        }
> +    } else {
> +        int fd;
> +
> +        p =3D lock_user_string(path_or_fd);
> +        if (p =3D=3D NULL) {
> +            ret =3D -TARGET_EFAULT;
> +            goto execve_end;
> +        }
> +
> +        /*
> +         * Check the header and see if it a target elf binary.  If so
> +         * then execute using qemu user mode emulator.
> +         */
> +        fd =3D open(p, O_RDONLY | O_CLOEXEC);
> +        if (fd > 0 && is_target_elf_binary(fd) =3D=3D 1) {
> +            close(fd);
> +            /* execve() as a target binary using emulator. */
> +            memmove(qarg1 + 2, qarg1, (qargend - qarg1) * sizeof(*qarg1)=
);
> +            qarg1[1] =3D qarg1[0];
> +            qarg1[0] =3D (char *)"-0";
> +            qarg1 +=3D 2;
> +            qargend +=3D 2;
> +            *qarg1 =3D (char *)p;
> +#ifndef DONT_INHERIT_INTERP_PREFIX
> +            memmove(qarg1 + 2, qarg1, (qargend - qarg1) * sizeof(*qarg1)=
);
> +            *qarg1++ =3D (char *)"-L";
> +            *qarg1++ =3D (char *)interp_prefix;
> +#endif
> +            ret =3D get_errno(execve(qemu_proc_pathname, qargp, envp));
> +        } else {
> +            close(fd);
> +            /* Execve() as a host native binary. */
> +            ret =3D get_errno(execve(p, argp, envp));
> +        }
> +        unlock_user(p, path_or_fd, 0);
> +    }


It might be nice to unify these two if statements, but I'm thinking
we don't want to do it now since Doug's work will obsolete it if I
understand it correctly.

Warner


>
>
+execve_end:
> +    for (gp =3D guest_argp, q =3D argp; *q; gp +=3D sizeof(abi_ulong), q=
++) {
> +        if (get_user_ual(addr, gp) || !addr) {
> +            break;
> +        }
> +        unlock_user(*q, addr, 0);
> +    }
> +
> +    for (gp =3D guest_envp, q =3D envp; *q; gp +=3D sizeof(abi_ulong), q=
++) {
> +        if (get_user_ual(addr, gp) || !addr) {
> +            break;
> +        }
> +        unlock_user(*q, addr, 0);
> +    }
> +
> +    g_free(qarg0);
> +    g_free(envp);
> +
> +    return ret;
> +}
> +
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index f913cb55a7..a12b4be80f 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -88,7 +88,7 @@ unsigned long reserved_va =3D MAX_RESERVED_VA;
>  unsigned long reserved_va;
>  #endif
>
> -static const char *interp_prefix =3D CONFIG_QEMU_INTERP_PREFIX;
> +const char *interp_prefix =3D CONFIG_QEMU_INTERP_PREFIX;
>  const char *qemu_uname_release;
>  char qemu_proc_pathname[PATH_MAX];  /* full path to exeutable */
>
> diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> index 2cf96d9a15..1ed6024b5d 100644
> --- a/bsd-user/qemu.h
> +++ b/bsd-user/qemu.h
> @@ -111,6 +111,7 @@ typedef struct TaskState {
>  } __attribute__((aligned(16))) TaskState;
>
>  void stop_all_tasks(void);
> +extern const char *interp_prefix;
>  extern const char *qemu_uname_release;
>
>  /*
> --
> 2.42.0
>
>

--00000000000098b5aa0605cef20d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 17, 2023 at 10:39=E2=80=
=AFPM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.tah=
a2.7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/freebsd/os-proc.c | 177 ++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0bsd-user/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A02 +-<br>
=C2=A0bsd-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A01 +<br>
=C2=A03 files changed, 179 insertions(+), 1 deletion(-)<br></blockquote><di=
v><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.=
com">imp@bsdimp.com</a>&gt;</div><div><br></div><div>But see comment below.=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c<br>
index cb35f29f10..12d78b7fc9 100644<br>
--- a/bsd-user/freebsd/os-proc.c<br>
+++ b/bsd-user/freebsd/os-proc.c<br>
@@ -78,3 +78,180 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
+/*<br>
+ * execve/fexecve<br>
+ */<br>
+abi_long freebsd_exec_common(abi_ulong path_or_fd, abi_ulong guest_argp,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong guest_envp, int do_fexec)<br>
+{<br>
+=C2=A0 =C2=A0 char **argp, **envp, **qargp, **qarg1, **qarg0, **qargend;<b=
r>
+=C2=A0 =C2=A0 int argc, envc;<br>
+=C2=A0 =C2=A0 abi_ulong gp;<br>
+=C2=A0 =C2=A0 abi_ulong addr;<br>
+=C2=A0 =C2=A0 char **q;<br>
+=C2=A0 =C2=A0 int total_size =3D 0;<br>
+=C2=A0 =C2=A0 void *p;<br>
+=C2=A0 =C2=A0 abi_long ret;<br>
+<br>
+=C2=A0 =C2=A0 argc =3D 0;<br>
+=C2=A0 =C2=A0 for (gp =3D guest_argp; gp; gp +=3D sizeof(abi_ulong)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_user_ual(addr, gp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 argc++;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 envc =3D 0;<br>
+=C2=A0 =C2=A0 for (gp =3D guest_envp; gp; gp +=3D sizeof(abi_ulong)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_user_ual(addr, gp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 envc++;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 qarg0 =3D argp =3D g_new0(char *, argc + 9);<br>
+=C2=A0 =C2=A0 /* save the first agrument for the emulator */<br>
+=C2=A0 =C2=A0 *argp++ =3D (char *)getprogname();<br>
+=C2=A0 =C2=A0 qargp =3D argp;<br>
+=C2=A0 =C2=A0 *argp++ =3D (char *)getprogname();<br>
+=C2=A0 =C2=A0 qarg1 =3D argp;<br>
+=C2=A0 =C2=A0 envp =3D g_new0(char *, envc + 1);<br>
+=C2=A0 =C2=A0 for (gp =3D guest_argp, q =3D argp; gp; gp +=3D sizeof(abi_u=
long), q++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_user_ual(addr, gp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto execve_end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *q =3D lock_user_string(addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*q =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto execve_end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 total_size +=3D strlen(*q) + 1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 *q++ =3D NULL;<br>
+=C2=A0 =C2=A0 qargend =3D q;<br>
+<br>
+=C2=A0 =C2=A0 for (gp =3D guest_envp, q =3D envp; gp; gp +=3D sizeof(abi_u=
long), q++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_user_ual(addr, gp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto execve_end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *q =3D lock_user_string(addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*q =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto execve_end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 total_size +=3D strlen(*q) + 1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 *q =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* This case will not be caught by the host&#39;s execv=
e() if its<br>
+=C2=A0 =C2=A0 =C2=A0* page size is bigger than the target&#39;s.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (total_size &gt; MAX_ARG_PAGES * TARGET_PAGE_SIZE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -TARGET_E2BIG;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto execve_end;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (do_fexec) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (((int)path_or_fd &gt; 0 &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_target_elf_binary((int)path_o=
r_fd)) =3D=3D 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char execpath[PATH_MAX];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The executable is an elf=
 binary for the target<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* arch.=C2=A0 execve() it =
using the emulator if we can<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* determine the filename p=
ath from the fd.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br></blockquote><div><b=
r></div><div>So we do this fd dance so we can make things like &#39;qemu-ar=
m-static /armv7/bin/sh&#39; work.</div><div>Doug Rabson has some changes th=
at means we can ditch this, I think, since the</div><div>kernel will just t=
rack it and it will default to &#39;what is doing the current process&#39;<=
/div><div>rather than the system default for the same binfmt entry.</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_filename_from_fd(getpid(=
), (int)path_or_fd, execpath,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sizeof(execpath)) !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memmove(qarg1 + 2,=
 qarg1, (qargend - qarg1) * sizeof(*qarg1));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qarg1[1] =3D qarg1=
[0];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qarg1[0] =3D (char=
 *)&quot;-0&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qarg1 +=3D 2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qargend +=3D 2;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *qarg1 =3D execpat=
h;<br>
+#ifndef DONT_INHERIT_INTERP_PREFIX<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memmove(qarg1 + 2,=
 qarg1, (qargend - qarg1) * sizeof(*qarg1));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *qarg1++ =3D (char=
 *)&quot;-L&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *qarg1++ =3D (char=
 *)interp_prefix;<br>
+#endif<br></blockquote><div><br></div><div>And we do this inheritance so w=
e can pass=C2=A0in a non-standard library path,</div><div>maybe for testing=
, and have the above example also=C2=A0work.</div><div><br></div><div>Warne=
r</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(=
execve(qemu_proc_pathname, qargp, envp));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Getting the fil=
ename path failed. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -TARGET_EB=
ADF;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto execve_end;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(fexecve((int)p=
ath_or_fd, argp, envp));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int fd;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p =3D lock_user_string(path_or_fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (p =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto execve_end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Check the header and see if it a targe=
t elf binary.=C2=A0 If so<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* then execute using qemu user mode emul=
ator.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fd =3D open(p, O_RDONLY | O_CLOEXEC);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &gt; 0 &amp;&amp; is_target_elf_binary(=
fd) =3D=3D 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* execve() as a target binary u=
sing emulator. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memmove(qarg1 + 2, qarg1, (qarge=
nd - qarg1) * sizeof(*qarg1));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qarg1[1] =3D qarg1[0];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qarg1[0] =3D (char *)&quot;-0&qu=
ot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qarg1 +=3D 2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qargend +=3D 2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *qarg1 =3D (char *)p;<br>
+#ifndef DONT_INHERIT_INTERP_PREFIX<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memmove(qarg1 + 2, qarg1, (qarge=
nd - qarg1) * sizeof(*qarg1));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *qarg1++ =3D (char *)&quot;-L&qu=
ot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *qarg1++ =3D (char *)interp_pref=
ix;<br>
+#endif<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(execve(qemu_pr=
oc_pathname, qargp, envp));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Execve() as a host native bin=
ary. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(execve(p, argp=
, envp));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_user(p, path_or_fd, 0);<br>
+=C2=A0 =C2=A0 }</blockquote><div><br></div><div>It might be nice to unify =
these two if statements, but I&#39;m thinking</div><div>we don&#39;t want t=
o do it now since Doug&#39;s work will obsolete it if I</div><div>understan=
d it correctly.</div><div><br></div><div>Warner</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">=C2=A0<br></blockquote><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
+execve_end:<br>
+=C2=A0 =C2=A0 for (gp =3D guest_argp, q =3D argp; *q; gp +=3D sizeof(abi_u=
long), q++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_user_ual(addr, gp) || !addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_user(*q, addr, 0);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 for (gp =3D guest_envp, q =3D envp; *q; gp +=3D sizeof(abi_u=
long), q++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_user_ual(addr, gp) || !addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_user(*q, addr, 0);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 g_free(qarg0);<br>
+=C2=A0 =C2=A0 g_free(envp);<br>
+<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
diff --git a/bsd-user/main.c b/bsd-user/main.c<br>
index f913cb55a7..a12b4be80f 100644<br>
--- a/bsd-user/main.c<br>
+++ b/bsd-user/main.c<br>
@@ -88,7 +88,7 @@ unsigned long reserved_va =3D MAX_RESERVED_VA;<br>
=C2=A0unsigned long reserved_va;<br>
=C2=A0#endif<br>
<br>
-static const char *interp_prefix =3D CONFIG_QEMU_INTERP_PREFIX;<br>
+const char *interp_prefix =3D CONFIG_QEMU_INTERP_PREFIX;<br>
=C2=A0const char *qemu_uname_release;<br>
=C2=A0char qemu_proc_pathname[PATH_MAX];=C2=A0 /* full path to exeutable */=
<br>
<br>
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h<br>
index 2cf96d9a15..1ed6024b5d 100644<br>
--- a/bsd-user/qemu.h<br>
+++ b/bsd-user/qemu.h<br>
@@ -111,6 +111,7 @@ typedef struct TaskState {<br>
=C2=A0} __attribute__((aligned(16))) TaskState;<br>
<br>
=C2=A0void stop_all_tasks(void);<br>
+extern const char *interp_prefix;<br>
=C2=A0extern const char *qemu_uname_release;<br>
<br>
=C2=A0/*<br>
-- <br>
2.42.0<br>
<br>
</blockquote></div></div>

--00000000000098b5aa0605cef20d--

