Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 111DD7A8C3D
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 21:04:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj2Ta-00013R-TQ; Wed, 20 Sep 2023 15:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2TY-00013G-Oo
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 15:03:04 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2TV-0008F1-P5
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 15:03:04 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-501eec0a373so366655e87.3
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 12:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695236578; x=1695841378;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m0zw9tPmIcPIt4I9pc1WGi4QXbbIUUIb7LnkkGvqIKY=;
 b=nU65hqf5Rd3JJPh8vfgu/Q10CHCvZ9tUFKJ0J3WmSWi6EB20G+L8uUNTigQUzkAixr
 DlVse371Blx2C9TKlR7PesIpLcUOatnkbu0BWFxEBu1v70xfHVOKN+aY6aHNOOU33ENY
 70XdlPqAh4fS0REiIFo2Beqe2LK7C/tDJYYMUB89vxa4hAEzh04jyflLSkmVhq2DpWZj
 8zWSvuZsvxSKr0KbQVCs1A3uO6ZNrSUBE5GhEm8gDLEndyZJGaLdTfjLNUGhJEx9Avct
 Url6zx4nwX3dviyb6Spa4Ri47ZWnQ74DH7D9QDZgmKAe/fEuGqEskJYa5ueFHx/Fw5/v
 GJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695236578; x=1695841378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m0zw9tPmIcPIt4I9pc1WGi4QXbbIUUIb7LnkkGvqIKY=;
 b=HVNeKq/m3ZLbPto8JuypV2dVQxFxr+GJLgQiOkkKhugxJnybdOZ8hFWiN1w4nkY6qg
 0MPJHSzkwrfpKtN1q0sj/j3lihw74H9tKVPaQZ0UfFizKQ+32/6u0CQ3aqu9tAU1Lym6
 HpRy5Btc8AlFjSOg20vnVBk76L0wIYkm/z17yA5aBJjVp9jEXUtAhGcXIRci3Jm8bmRb
 knSCDrvAWl/3qqAJdy1impQYGYGF5y3Fcp4a2cIXmMvwgDNothqKtHkNKcFzdQ8pHhH0
 W1vCYMcmQfa2QUsXVg7HT9tznHOQXBwNbDHm7U6ef61VDy/eSZ061EvESmn3Ja1/fJ6B
 PRpQ==
X-Gm-Message-State: AOJu0YzpK7Cx9sufCn2uBWutxFXvrilY2EmXU200+9WoTMM/tTIOcjOj
 rqw8SKf8bpWsqQtuVymjCUL4yBpGk6qE3eUJOBjodQ==
X-Google-Smtp-Source: AGHT+IFKNq+UEPoHPBNeyYgTL3QbUUTu8RCi0OJUIIOFE+NTHW/79toUK+dC8lM2GZ1SZ6Ravjkkyka0GgNxIrWWfGQ=
X-Received: by 2002:a19:6746:0:b0:500:c348:7efb with SMTP id
 e6-20020a196746000000b00500c3487efbmr3050936lfj.48.1695236577775; Wed, 20 Sep
 2023 12:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-22-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-22-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 20:02:46 +0100
Message-ID: <CANCZdfpQHJpRxNritJAQe0Dc8tC4_w4yK15gLcE7RSjto0btCw@mail.gmail.com>
Subject: Re: [PATCH v2 21/28] bsd-user: Implement procctl(2) along with
 necessary conversion functions.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000000776600605cf0687"
Received-SPF: none client-ip=2a00:1450:4864:20::12b;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x12b.google.com
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

--0000000000000776600605cf0687
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 10:39=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Implement t2h_procctl_cmd, h2t_reaper_status, h2t_reaper_pidinfo and
> h2t/t2h reaper_kill conversion functions.
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/freebsd/os-proc.c    | 223 ++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |   3 +
>  2 files changed, 226 insertions(+)
>
> diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
> index 12d78b7fc9..6b8753f8e5 100644
> --- a/bsd-user/freebsd/os-proc.c
> +++ b/bsd-user/freebsd/os-proc.c
> @@ -255,3 +255,226 @@ execve_end:
>      return ret;
>  }
>
> +#include <sys/procctl.h>
> +
> +static abi_long
> +t2h_procctl_cmd(int target_cmd, int *host_cmd)
> +{
> +    switch (target_cmd) {
> +    case TARGET_PROC_SPROTECT:
> +        *host_cmd =3D PROC_SPROTECT;
> +        break;
> +
> +    case TARGET_PROC_REAP_ACQUIRE:
> +        *host_cmd =3D PROC_REAP_ACQUIRE;
> +        break;
> +
> +    case TARGET_PROC_REAP_RELEASE:
> +        *host_cmd =3D PROC_REAP_RELEASE;
> +        break;
> +
> +    case TARGET_PROC_REAP_STATUS:
> +        *host_cmd =3D PROC_REAP_STATUS;
> +        break;
> +
> +    case TARGET_PROC_REAP_KILL:
> +        *host_cmd =3D PROC_REAP_KILL;
> +        break;
> +
> +    default:
> +        return -TARGET_EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +static abi_long
> +h2t_reaper_status(struct procctl_reaper_status *host_rs,
> +        abi_ulong target_rs_addr)
> +{
> +    struct target_procctl_reaper_status *target_rs;
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_rs, target_rs_addr, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __put_user(host_rs->rs_flags, &target_rs->rs_flags);
> +    __put_user(host_rs->rs_children, &target_rs->rs_children);
> +    __put_user(host_rs->rs_descendants, &target_rs->rs_descendants);
> +    __put_user(host_rs->rs_reaper, &target_rs->rs_reaper);
> +    __put_user(host_rs->rs_pid, &target_rs->rs_pid);
> +    unlock_user_struct(target_rs, target_rs_addr, 1);
> +
> +    return 0;
> +}
> +
> +static abi_long
> +t2h_reaper_kill(abi_ulong target_rk_addr, struct procctl_reaper_kill
> *host_rk)
> +{
> +    struct target_procctl_reaper_kill *target_rk;
> +
> +    if (!lock_user_struct(VERIFY_READ, target_rk, target_rk_addr, 1)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __get_user(host_rk->rk_sig, &target_rk->rk_sig);
> +    __get_user(host_rk->rk_flags, &target_rk->rk_flags);
> +    __get_user(host_rk->rk_subtree, &target_rk->rk_subtree);
> +    __get_user(host_rk->rk_killed, &target_rk->rk_killed);
> +    __get_user(host_rk->rk_fpid, &target_rk->rk_fpid);
> +    unlock_user_struct(target_rk, target_rk_addr, 0);
> +
> +    return 0;
> +}
> +
> +static abi_long
> +h2t_reaper_kill(struct procctl_reaper_kill *host_rk, abi_ulong
> target_rk_addr)
> +{
> +    struct target_procctl_reaper_kill *target_rk;
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_rk, target_rk_addr, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __put_user(host_rk->rk_sig, &target_rk->rk_sig);
> +    __put_user(host_rk->rk_flags, &target_rk->rk_flags);
> +    __put_user(host_rk->rk_subtree, &target_rk->rk_subtree);
> +    __put_user(host_rk->rk_killed, &target_rk->rk_killed);
> +    __put_user(host_rk->rk_fpid, &target_rk->rk_fpid);
> +    unlock_user_struct(target_rk, target_rk_addr, 1);
> +
> +    return 0;
> +}
> +
> +static abi_long
> +h2t_procctl_reaper_pidinfo(struct procctl_reaper_pidinfo *host_pi,
> +        abi_ulong target_pi_addr)
> +{
> +    struct target_procctl_reaper_pidinfo *target_pi;
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_pi, target_pi_addr, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __put_user(host_pi->pi_pid, &target_pi->pi_pid);
> +    __put_user(host_pi->pi_subtree, &target_pi->pi_subtree);
> +    __put_user(host_pi->pi_flags, &target_pi->pi_flags);
> +    unlock_user_struct(target_pi, target_pi_addr, 1);
> +
> +    return 0;
> +}
> +
> +abi_long
> +do_freebsd_procctl(void *cpu_env, int idtype, abi_ulong arg2, abi_ulong
> arg3,
> +       abi_ulong arg4, abi_ulong arg5, abi_ulong arg6)
> +{
> +    abi_long error =3D 0, target_rp_pids;
> +    void *data;
> +    int host_cmd, flags;
> +    uint32_t u, target_rp_count;
> +    union {
> +        struct procctl_reaper_status rs;
> +        struct procctl_reaper_pids rp;
> +        struct procctl_reaper_kill rk;
> +    } host;
> +    struct target_procctl_reaper_pids *target_rp;
> +    id_t id; /* 64-bit */
> +    int target_cmd;
> +    abi_ulong target_arg;
> +
> +#if TARGET_ABI_BITS =3D=3D 32
> +    /* See if we need to align the register pairs. */
> +    if (regpairs_aligned(cpu_env)) {
> +        id =3D (id_t)target_arg64(arg3, arg4);
> +        target_cmd =3D (int)arg5;
> +        target_arg =3D arg6;
> +    } else {
> +        id =3D (id_t)target_arg64(arg2, arg3);
> +        target_cmd =3D (int)arg4;
> +        target_arg =3D arg5;
> +    }
> +#else
> +    id =3D (id_t)arg2;
> +    target_cmd =3D (int)arg3;
> +    target_arg =3D arg4;
> +#endif
> +
> +    error =3D t2h_procctl_cmd(target_cmd, &host_cmd);
> +    if (error) {
> +        return error;
> +    }
> +    switch (host_cmd) {
> +    case PROC_SPROTECT:
> +        data =3D &flags;
> +        break;
> +
> +    case PROC_REAP_ACQUIRE:
> +    case PROC_REAP_RELEASE:
> +        if (target_arg =3D=3D 0) {
> +            data =3D NULL;
> +        } else {
> +            error =3D -TARGET_EINVAL;
> +        }
> +        break;
> +
> +    case PROC_REAP_STATUS:
> +        data =3D &host.rs;
> +        break;
> +
> +    case PROC_REAP_GETPIDS:
> +        if (!lock_user_struct(VERIFY_READ, target_rp, target_arg, 1)) {
> +            return -TARGET_EFAULT;
> +        }
> +        __get_user(target_rp_count, &target_rp->rp_count);
> +        __get_user(target_rp_pids, &target_rp->rp_pids);
> +        unlock_user_struct(target_rp, target_arg, 0);
> +        host.rp.rp_count =3D target_rp_count;
> +        /* XXX we should check target_rc_count to see if it is
> reasonable. */
> +        host.rp.rp_pids =3D alloca(target_rp_count *
> +                sizeof(struct procctl_reaper_pidinfo));
>

I think that there's been a general move to using the 'smart pointer'
version of
this that you've done for other patches. I think that target_rc_count
likely is going to be small enough, but that doing the conversion will
ensure that
it is (so we can eliminate the comment too).

Warner


> +        if (host.rp.rp_pids =3D=3D NULL) {
> +            error =3D -TARGET_ENOMEM;
> +        } else {
> +            data =3D &host.rp;
> +        }
> +        break;
> +
> +    case PROC_REAP_KILL:
> +        error =3D t2h_reaper_kill(target_arg, &host.rk);
> +        break;
> +    }
> +
> +    if (error) {
> +        return error;
> +    }
> +    error =3D get_errno(procctl(idtype, id, host_cmd, data));
> +
> +    if (error) {
> +        return error;
> +    }
> +    switch (host_cmd) {
> +    case PROC_SPROTECT:
> +        if (put_user_s32(flags, target_arg)) {
> +            return -TARGET_EFAULT;
> +        }
> +        break;
> +
> +    case PROC_REAP_STATUS:
> +        error =3D h2t_reaper_status(&host.rs, target_arg);
> +        break;
> +
> +    case PROC_REAP_GETPIDS:
> +        /* copyout reaper pidinfo */
> +        for (u =3D 0; u < target_rp_count; u++) {
> +            error =3D h2t_procctl_reaper_pidinfo(&host.rp.rp_pids[u],
> +                    target_rp_pids +
> +                    (u * sizeof(struct target_procctl_reaper_pidinfo)));
> +            if (error) {
> +                break;
> +            }
> +        }
> +        break;
> +
> +    case PROC_REAP_KILL:
> +        error =3D h2t_reaper_kill(&host.rk, target_arg);
> +        break;
> +    }
> +
> +    return error;
> +}
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.=
c
> index 71a2657dd0..b7bd0b92a6 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -367,6 +367,9 @@ static abi_long freebsd_syscall(void *cpu_env, int
> num, abi_long arg1,
>          ret =3D do_bsd_setpriority(arg1, arg2, arg3);
>          break;
>
> +    case TARGET_FREEBSD_NR_procctl: /* procctl(2) */
> +        ret =3D do_freebsd_procctl(cpu_env, arg1, arg2, arg3, arg4, arg5=
,
> arg6);
> +        break;
>
>          /*
>           * File system calls.
> --
> 2.42.0
>
>

--0000000000000776600605cf0687
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 17, 2023 at 10:39=E2=80=
=AFPM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.tah=
a2.7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Implement t2h_procctl_cmd, h2t_reaper_status, h2t_reaper_pidinfo and h2t/t2=
h reaper_kill conversion functions.<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/freebsd/os-proc.c=C2=A0 =C2=A0 | 223 +++++++++++++++++++++++=
+++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 =C2=A03 +<br>
=C2=A02 files changed, 226 insertions(+)<br>
<br>
diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c<br>
index 12d78b7fc9..6b8753f8e5 100644<br>
--- a/bsd-user/freebsd/os-proc.c<br>
+++ b/bsd-user/freebsd/os-proc.c<br>
@@ -255,3 +255,226 @@ execve_end:<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
+#include &lt;sys/procctl.h&gt;<br>
+<br>
+static abi_long<br>
+t2h_procctl_cmd(int target_cmd, int *host_cmd)<br>
+{<br>
+=C2=A0 =C2=A0 switch (target_cmd) {<br>
+=C2=A0 =C2=A0 case TARGET_PROC_SPROTECT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *host_cmd =3D PROC_SPROTECT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_PROC_REAP_ACQUIRE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *host_cmd =3D PROC_REAP_ACQUIRE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_PROC_REAP_RELEASE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *host_cmd =3D PROC_REAP_RELEASE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_PROC_REAP_STATUS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *host_cmd =3D PROC_REAP_STATUS;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_PROC_REAP_KILL:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *host_cmd =3D PROC_REAP_KILL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EINVAL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static abi_long<br>
+h2t_reaper_status(struct procctl_reaper_status *host_rs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong target_rs_addr)<br>
+{<br>
+=C2=A0 =C2=A0 struct target_procctl_reaper_status *target_rs;<br>
+<br>
+=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_WRITE, target_rs, target_rs_add=
r, 0)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 __put_user(host_rs-&gt;rs_flags, &amp;target_rs-&gt;rs_flags=
);<br>
+=C2=A0 =C2=A0 __put_user(host_rs-&gt;rs_children, &amp;target_rs-&gt;rs_ch=
ildren);<br>
+=C2=A0 =C2=A0 __put_user(host_rs-&gt;rs_descendants, &amp;target_rs-&gt;rs=
_descendants);<br>
+=C2=A0 =C2=A0 __put_user(host_rs-&gt;rs_reaper, &amp;target_rs-&gt;rs_reap=
er);<br>
+=C2=A0 =C2=A0 __put_user(host_rs-&gt;rs_pid, &amp;target_rs-&gt;rs_pid);<b=
r>
+=C2=A0 =C2=A0 unlock_user_struct(target_rs, target_rs_addr, 1);<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static abi_long<br>
+t2h_reaper_kill(abi_ulong target_rk_addr, struct procctl_reaper_kill *host=
_rk)<br>
+{<br>
+=C2=A0 =C2=A0 struct target_procctl_reaper_kill *target_rk;<br>
+<br>
+=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_READ, target_rk, target_rk_addr=
, 1)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 __get_user(host_rk-&gt;rk_sig, &amp;target_rk-&gt;rk_sig);<b=
r>
+=C2=A0 =C2=A0 __get_user(host_rk-&gt;rk_flags, &amp;target_rk-&gt;rk_flags=
);<br>
+=C2=A0 =C2=A0 __get_user(host_rk-&gt;rk_subtree, &amp;target_rk-&gt;rk_sub=
tree);<br>
+=C2=A0 =C2=A0 __get_user(host_rk-&gt;rk_killed, &amp;target_rk-&gt;rk_kill=
ed);<br>
+=C2=A0 =C2=A0 __get_user(host_rk-&gt;rk_fpid, &amp;target_rk-&gt;rk_fpid);=
<br>
+=C2=A0 =C2=A0 unlock_user_struct(target_rk, target_rk_addr, 0);<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static abi_long<br>
+h2t_reaper_kill(struct procctl_reaper_kill *host_rk, abi_ulong target_rk_a=
ddr)<br>
+{<br>
+=C2=A0 =C2=A0 struct target_procctl_reaper_kill *target_rk;<br>
+<br>
+=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_WRITE, target_rk, target_rk_add=
r, 0)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 __put_user(host_rk-&gt;rk_sig, &amp;target_rk-&gt;rk_sig);<b=
r>
+=C2=A0 =C2=A0 __put_user(host_rk-&gt;rk_flags, &amp;target_rk-&gt;rk_flags=
);<br>
+=C2=A0 =C2=A0 __put_user(host_rk-&gt;rk_subtree, &amp;target_rk-&gt;rk_sub=
tree);<br>
+=C2=A0 =C2=A0 __put_user(host_rk-&gt;rk_killed, &amp;target_rk-&gt;rk_kill=
ed);<br>
+=C2=A0 =C2=A0 __put_user(host_rk-&gt;rk_fpid, &amp;target_rk-&gt;rk_fpid);=
<br>
+=C2=A0 =C2=A0 unlock_user_struct(target_rk, target_rk_addr, 1);<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static abi_long<br>
+h2t_procctl_reaper_pidinfo(struct procctl_reaper_pidinfo *host_pi,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong target_pi_addr)<br>
+{<br>
+=C2=A0 =C2=A0 struct target_procctl_reaper_pidinfo *target_pi;<br>
+<br>
+=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_WRITE, target_pi, target_pi_add=
r, 0)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 __put_user(host_pi-&gt;pi_pid, &amp;target_pi-&gt;pi_pid);<b=
r>
+=C2=A0 =C2=A0 __put_user(host_pi-&gt;pi_subtree, &amp;target_pi-&gt;pi_sub=
tree);<br>
+=C2=A0 =C2=A0 __put_user(host_pi-&gt;pi_flags, &amp;target_pi-&gt;pi_flags=
);<br>
+=C2=A0 =C2=A0 unlock_user_struct(target_pi, target_pi_addr, 1);<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+abi_long<br>
+do_freebsd_procctl(void *cpu_env, int idtype, abi_ulong arg2, abi_ulong ar=
g3,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0abi_ulong arg4, abi_ulong arg5, abi_ulong arg6)=
<br>
+{<br>
+=C2=A0 =C2=A0 abi_long error =3D 0, target_rp_pids;<br>
+=C2=A0 =C2=A0 void *data;<br>
+=C2=A0 =C2=A0 int host_cmd, flags;<br>
+=C2=A0 =C2=A0 uint32_t u, target_rp_count;<br>
+=C2=A0 =C2=A0 union {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct procctl_reaper_status rs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct procctl_reaper_pids rp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct procctl_reaper_kill rk;<br>
+=C2=A0 =C2=A0 } host;<br>
+=C2=A0 =C2=A0 struct target_procctl_reaper_pids *target_rp;<br>
+=C2=A0 =C2=A0 id_t id; /* 64-bit */<br>
+=C2=A0 =C2=A0 int target_cmd;<br>
+=C2=A0 =C2=A0 abi_ulong target_arg;<br>
+<br>
+#if TARGET_ABI_BITS =3D=3D 32<br>
+=C2=A0 =C2=A0 /* See if we need to align the register pairs. */<br>
+=C2=A0 =C2=A0 if (regpairs_aligned(cpu_env)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 id =3D (id_t)target_arg64(arg3, arg4);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_cmd =3D (int)arg5;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_arg =3D arg6;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 id =3D (id_t)target_arg64(arg2, arg3);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_cmd =3D (int)arg4;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_arg =3D arg5;<br>
+=C2=A0 =C2=A0 }<br>
+#else<br>
+=C2=A0 =C2=A0 id =3D (id_t)arg2;<br>
+=C2=A0 =C2=A0 target_cmd =3D (int)arg3;<br>
+=C2=A0 =C2=A0 target_arg =3D arg4;<br>
+#endif<br>
+<br>
+=C2=A0 =C2=A0 error =3D t2h_procctl_cmd(target_cmd, &amp;host_cmd);<br>
+=C2=A0 =C2=A0 if (error) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return error;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 switch (host_cmd) {<br>
+=C2=A0 =C2=A0 case PROC_SPROTECT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D &amp;flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case PROC_REAP_ACQUIRE:<br>
+=C2=A0 =C2=A0 case PROC_REAP_RELEASE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (target_arg =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D -TARGET_EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case PROC_REAP_STATUS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D &amp;<a href=3D"http://host.rs" rel=
=3D"noreferrer" target=3D"_blank">host.rs</a>;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case PROC_REAP_GETPIDS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_READ, target_rp, =
target_arg, 1)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(target_rp_count, &amp;target_rp-&gt=
;rp_count);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(target_rp_pids, &amp;target_rp-&gt;=
rp_pids);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_user_struct(target_rp, target_arg, 0);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 host.rp.rp_count =3D target_rp_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* XXX we should check target_rc_count to see =
if it is reasonable. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 host.rp.rp_pids =3D alloca(target_rp_count *<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct proc=
ctl_reaper_pidinfo));<br></blockquote><div><br></div><div>I think that ther=
e&#39;s been a general move to using the &#39;smart pointer&#39; version of=
</div><div>this that you&#39;ve done for other patches. I think that target=
_rc_count</div><div>likely is going to be small enough, but that doing the =
conversion will ensure that</div><div>it is (so we can eliminate the commen=
t too).</div><div><br></div><div>Warner</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host.rp.rp_pids =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D -TARGET_ENOMEM;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D &amp;host.rp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case PROC_REAP_KILL:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D t2h_reaper_kill(target_arg, &amp;hos=
t.rk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (error) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return error;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 error =3D get_errno(procctl(idtype, id, host_cmd, data));<br=
>
+<br>
+=C2=A0 =C2=A0 if (error) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return error;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 switch (host_cmd) {<br>
+=C2=A0 =C2=A0 case PROC_SPROTECT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (put_user_s32(flags, target_arg)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case PROC_REAP_STATUS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D h2t_reaper_status(&amp;<a href=3D"ht=
tp://host.rs" rel=3D"noreferrer" target=3D"_blank">host.rs</a>, target_arg)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case PROC_REAP_GETPIDS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* copyout reaper pidinfo */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (u =3D 0; u &lt; target_rp_count; u++) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D h2t_procctl_reaper_pid=
info(&amp;host.rp.rp_pids[u],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 targ=
et_rp_pids +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (u *=
 sizeof(struct target_procctl_reaper_pidinfo)));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (error) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case PROC_REAP_KILL:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D h2t_reaper_kill(&amp;host.rk, target=
_arg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return error;<br>
+}<br>
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c<=
br>
index 71a2657dd0..b7bd0b92a6 100644<br>
--- a/bsd-user/freebsd/os-syscall.c<br>
+++ b/bsd-user/freebsd/os-syscall.c<br>
@@ -367,6 +367,9 @@ static abi_long freebsd_syscall(void *cpu_env, int num,=
 abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_bsd_setpriority(arg1, arg2, ar=
g3);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_procctl: /* procctl(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_freebsd_procctl(cpu_env, arg1, arg2=
, arg3, arg4, arg5, arg6);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * File system calls.<br>
-- <br>
2.42.0<br>
<br>
</blockquote></div></div>

--0000000000000776600605cf0687--

