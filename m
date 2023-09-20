Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D73C7A8CB1
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 21:22:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj2li-00007l-Qd; Wed, 20 Sep 2023 15:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2lh-00007S-6Z
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 15:21:49 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2lf-00037C-EP
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 15:21:48 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53087f0e18bso85677a12.3
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 12:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695237706; x=1695842506;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fjDgEoOaOP3dcea1WMlCSgxJVpw7PazUYX0+6BPpeoI=;
 b=gD9UBSiunx4i0vR9+DYI2Z/LGX3po98vCRGvbnj+PDZZYtYyF0/zdCjmTZkk0W2j7x
 NkppBW2PcOzomWPgI3YqsRJE9DPpISTnlFrqyyt8EVPWGa05D9r0j4OzQdoXG2h9B2TQ
 V1RWDH32CWaFK9ChOxop9GmaSPE9s7i2sryAGCdEpjfijWemgFXOUspXnT6ysKwTVrtO
 huEfS2+NPVryoAWI1ITYJfUT6JW69gS44p7ShjhbTA5nV+odu1ClX7IyT+/Dg1u8EFZC
 cV8sgDQ3Vbrll6QNjTOji/asVMMmmacCLMAFxhjHqxQVZR6MZilFwSWbRZMjJelrfI3B
 pDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695237706; x=1695842506;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fjDgEoOaOP3dcea1WMlCSgxJVpw7PazUYX0+6BPpeoI=;
 b=AXwWYMB/8eVwgmQYsrQZh08FAX+x/lRnqgcPYWWsoLePonOO6b5ZpXKICiZn8r5XHK
 ESp92sYqwW/jqBinN2XRJ9tNo4v8EnlwuYMbxYtfqZlAH+99WkjxIECx3XTyNlx3jHaN
 cG7jrngXvyvdhDsaBckNq5BWKSEp8smJ4RZxYuo+cnRebKizDdF4PqoJyjF4dYfDpt3J
 jnQaareeqbSSmc8pclqypmZvV3lnOgjc9+LYCcJZCehKqLKssf70+QIR3R5hiIHfXnm6
 sDLLKuky66alMCNhRikCZgNlXESFUGpdsC4DGj7unGuosDFZKMdpium0mYsnif7KJRQV
 AWUg==
X-Gm-Message-State: AOJu0Yzxch5DKb8d25XT3tkNhfIXvDb9ktcMArmUa0sAXGEeuGDEYVg+
 +0+Ersp3qk+K35dqWQ0ixJ12+/9YcNz1btI60ufIvA==
X-Google-Smtp-Source: AGHT+IE5krXS7SvYNdViLuAT3zh1LDEe1XjFJsBDjfcV5+wl4deVFkoAo4osxWPcTly6oaV3GqvDO2mHDB2hdVX5lfE=
X-Received: by 2002:aa7:cb54:0:b0:52f:8ca7:f255 with SMTP id
 w20-20020aa7cb54000000b0052f8ca7f255mr3230974edt.37.1695237705788; Wed, 20
 Sep 2023 12:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-28-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-28-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 20:21:34 +0100
Message-ID: <CANCZdfo_mT65qKy4THG-6FX2BVfgth=_PZ1808vVDUo_c=jXeg@mail.gmail.com>
Subject: Re: [PATCH v2 27/28] bsd-user: Implement rfork(2) system call.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000043832b0605cf49a4"
Received-SPF: none client-ip=2a00:1450:4864:20::533;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x533.google.com
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

--00000000000043832b0605cf49a4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 10:39=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/freebsd/os-proc.h    | 39 +++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  4 ++++
>  2 files changed, 43 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


> diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
> index 14478d4bb5..a406ef7db8 100644
> --- a/bsd-user/freebsd/os-proc.h
> +++ b/bsd-user/freebsd/os-proc.h
> @@ -212,4 +212,43 @@ static inline abi_long do_freebsd_vfork(void *cpu_en=
v)
>      return do_freebsd_fork(cpu_env);
>  }
>
> +/* rfork(2) */
> +static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
> +{
> +    abi_long ret;
> +    abi_ulong child_flag;
> +
> +    /*
> +     * XXX We need to handle RFMEM here, as well.  Neither are safe to
> execute
> +     * as-is on x86 hosts because they'll split memory but not the stack=
,
> +     * wreaking havoc on host architectures that use the stack to store
> the
> +     * return address as both threads try to pop it off.  Rejecting
> RFSPAWN
> +     * entirely for now is ok, the only consumer at the moment is
> posix_spawn
> +     * and it will fall back to classic vfork(2) if we return EINVAL.
> +     */
> +    if ((flags & TARGET_RFSPAWN) !=3D 0) {
> +        return -TARGET_EINVAL;
> +    }
> +    fork_start();
> +    ret =3D rfork(flags);
> +    if (ret =3D=3D 0) {
> +        /* child */
> +        child_flag =3D 1;
> +        target_cpu_clone_regs(cpu_env, 0);
> +    } else {
> +        /* parent */
> +        child_flag =3D 0;
> +    }
> +
> +    /*
> +     * The fork system call sets a child flag in the second return
> +     * value: 0 for parent process, 1 for child process.
> +     */
> +    set_second_rval(cpu_env, child_flag);
> +    fork_end(child_flag);
> +
> +    return ret;
> +
> +}
> +
>  #endif /* BSD_USER_FREEBSD_OS_PROC_H */
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.=
c
> index cb9425c9ba..4c4e773d1d 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -234,6 +234,10 @@ static abi_long freebsd_syscall(void *cpu_env, int
> num, abi_long arg1,
>          ret =3D do_freebsd_vfork(cpu_env);
>          break;
>
> +    case TARGET_FREEBSD_NR_rfork: /* rfork(2) */
> +        ret =3D do_freebsd_rfork(cpu_env, arg1);
> +        break;
> +
>      case TARGET_FREEBSD_NR_execve: /* execve(2) */
>          ret =3D do_freebsd_execve(arg1, arg2, arg3);
>          break;
> --
> 2.42.0
>
>

--00000000000043832b0605cf49a4
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
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/freebsd/os-proc.h=C2=A0 =C2=A0 | 39 ++++++++++++++++++++++++=
+++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 4 ++++<br>
=C2=A02 files changed, 43 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h<br>
index 14478d4bb5..a406ef7db8 100644<br>
--- a/bsd-user/freebsd/os-proc.h<br>
+++ b/bsd-user/freebsd/os-proc.h<br>
@@ -212,4 +212,43 @@ static inline abi_long do_freebsd_vfork(void *cpu_env)=
<br>
=C2=A0 =C2=A0 =C2=A0return do_freebsd_fork(cpu_env);<br>
=C2=A0}<br>
<br>
+/* rfork(2) */<br>
+static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)<br>
+{<br>
+=C2=A0 =C2=A0 abi_long ret;<br>
+=C2=A0 =C2=A0 abi_ulong child_flag;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* XXX We need to handle RFMEM here, as well.=C2=A0 Nei=
ther are safe to execute<br>
+=C2=A0 =C2=A0 =C2=A0* as-is on x86 hosts because they&#39;ll split memory =
but not the stack,<br>
+=C2=A0 =C2=A0 =C2=A0* wreaking havoc on host architectures that use the st=
ack to store the<br>
+=C2=A0 =C2=A0 =C2=A0* return address as both threads try to pop it off.=C2=
=A0 Rejecting RFSPAWN<br>
+=C2=A0 =C2=A0 =C2=A0* entirely for now is ok, the only consumer at the mom=
ent is posix_spawn<br>
+=C2=A0 =C2=A0 =C2=A0* and it will fall back to classic vfork(2) if we retu=
rn EINVAL.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if ((flags &amp; TARGET_RFSPAWN) !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EINVAL;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 fork_start();<br>
+=C2=A0 =C2=A0 ret =3D rfork(flags);<br>
+=C2=A0 =C2=A0 if (ret =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* child */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 child_flag =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_cpu_clone_regs(cpu_env, 0);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* parent */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 child_flag =3D 0;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* The fork system call sets a child flag in the second=
 return<br>
+=C2=A0 =C2=A0 =C2=A0* value: 0 for parent process, 1 for child process.<br=
>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 set_second_rval(cpu_env, child_flag);<br>
+=C2=A0 =C2=A0 fork_end(child_flag);<br>
+<br>
+=C2=A0 =C2=A0 return ret;<br>
+<br>
+}<br>
+<br>
=C2=A0#endif /* BSD_USER_FREEBSD_OS_PROC_H */<br>
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c<=
br>
index cb9425c9ba..4c4e773d1d 100644<br>
--- a/bsd-user/freebsd/os-syscall.c<br>
+++ b/bsd-user/freebsd/os-syscall.c<br>
@@ -234,6 +234,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num=
, abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_freebsd_vfork(cpu_env);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_rfork: /* rfork(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_freebsd_rfork(cpu_env, arg1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0case TARGET_FREEBSD_NR_execve: /* execve(2) */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_freebsd_execve(arg1, arg2, arg=
3);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-- <br>
2.42.0<br>
<br>
</blockquote></div></div>

--00000000000043832b0605cf49a4--

