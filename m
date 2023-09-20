Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEA07A8BEB
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:34:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj21G-0007x6-0c; Wed, 20 Sep 2023 14:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj21C-0007mc-Tn
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:33:46 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj21A-0003PI-Kg
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:33:46 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-502b1bbe5c3so284074e87.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695234822; x=1695839622;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xvMAiCeLPu9VmKIVZRO1ut0GkwbP0ZFH6V0jvz7gBfY=;
 b=PG50RboOPJ069OG/Fa/5hDbhPF+SWBagVtWM+qNg3Y/IWQLIfsCvyixMXmUAFcMqjg
 VPxHoMWjXCRs5zeyZ4qg4PQF9VZLZK0WVk9SzbKap+ATtf5yH8XAa2q/yWXLcZkmsN4c
 bMzSn4yhTIcU0RcOG6Mq2dztrafNCWjM9gxEJ/F0eF6rA8TBveEYu31N3gONNT3py++g
 z1o7KX9Nio8359i5KHEln+1yj4LJ+vBzOMPxkLnzMPJ/3q89IBEfsRyIy1bysnT0PJjY
 bvgmfaHECSeDQYYwRqBj6AjEY5ZVY+FTOiVpRnCJfSXH4mb62TfA8avk3x/mBsQwIDuZ
 sSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695234822; x=1695839622;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xvMAiCeLPu9VmKIVZRO1ut0GkwbP0ZFH6V0jvz7gBfY=;
 b=dg7prV8mtlh65ERwoAH5W+IwS+WcCFAFxHYkQcdvtXJOU8EivE4QxXIHZ5Vpie7uzJ
 /whE3W04ifYIheIek3FMPTycDMQMQYLG7mdVY9FAOVJCIcrZeW//V9cjTXvh7SMqyPiE
 MT9mUEqgVMNicbcQeFqqYOuUgu06ClTgeXoAjUxgX76HTzZG6cQ5nca1L7s4IJRT/RGS
 dsvBVNbkfsVOcIY2U0XWodhdX+F3DGe7L3sYNWQZhj9eP3aTBfIohBxDvtfUKg+ctvG1
 HzeFiSWCyqiH+FC7kN+/SattoQReDoqjWX7aPI/5wtlWAAb+FK/nKU5DktgY2SXLtDKy
 CvgQ==
X-Gm-Message-State: AOJu0YxcH9WS3Yze/jSa34uXQCdXIAjzyIV3HV8Abm3+S2eoNma1vrSR
 UyeYZrvukiqiR0ZoLNKSza1Ux1DtLDi1eE7V91rXag==
X-Google-Smtp-Source: AGHT+IHWyyN8G2F6ai6li/MsR43MBnTIl+Q8PFKpnljoJc9ELtFpNvPdcqjjmHDqsurAxZTSHFx0SXoVblcjvGPDALU=
X-Received: by 2002:a05:6512:234d:b0:500:b9f3:1dc4 with SMTP id
 p13-20020a056512234d00b00500b9f31dc4mr3941580lfu.68.1695234822417; Wed, 20
 Sep 2023 11:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-13-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-13-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 19:33:31 +0100
Message-ID: <CANCZdfqiJ2nTxZ-V4UmtkK4u4OJGp5X_d87egB9DYtmsR6cdCg@mail.gmail.com>
Subject: Re: [PATCH v2 12/28] bsd-user: Implement umask(2),
 setlogin(2) and getlogin(2)
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000066c7d50605ce9dad"
Received-SPF: none client-ip=2a00:1450:4864:20::12e;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x12e.google.com
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

--00000000000066c7d50605ce9dad
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
>  bsd-user/bsd-proc.h           | 39 +++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c | 12 +++++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
> index 7b25aa1982..fd05422d9a 100644
> --- a/bsd-user/bsd-proc.h
> +++ b/bsd-user/bsd-proc.h
> @@ -26,6 +26,7 @@
>  #include "gdbstub/syscalls.h"
>  #include "qemu/plugin.h"
>
> +extern int _getlogin(char*, int);
>  int bsd_get_ncpu(void);
>
>  /* exit(2) */
> @@ -85,4 +86,42 @@ static inline abi_long do_bsd_setgroups(abi_long
> gidsetsize, abi_long arg2)
>      return get_errno(setgroups(gidsetsize, grouplist));
>  }
>
> +/* umask(2) */
> +static inline abi_long do_bsd_umask(abi_long arg1)
> +{
> +    return get_errno(umask(arg1));
> +}
> +
> +/* setlogin(2) */
> +static inline abi_long do_bsd_setlogin(abi_long arg1)
> +{
> +    abi_long ret;
> +    void *p;
> +
> +    p =3D lock_user_string(arg1);
> +    if (p =3D=3D NULL) {
> +        return -TARGET_EFAULT;
> +    }
> +    ret =3D get_errno(setlogin(p));
> +    unlock_user(p, arg1, 0);
> +
> +    return ret;
> +}
> +
> +/* getlogin(2) */
> +static inline abi_long do_bsd_getlogin(abi_long arg1, abi_long arg2)
> +{
> +    abi_long ret;
> +    void *p;
> +
> +    p =3D lock_user_string(arg1);
> +    if (p =3D=3D NULL) {
> +        return -TARGET_EFAULT;
> +    }
>

This looks backwards. We're calling the kernel to get this string, so the
target_strlen() tht lock_user_string() does is on the receiving buffer, not
the length of the string that we'd like to write.

 I think we want
    p =3D lock_user(VERIFY_READ, arg1, arg2, 0);

for this. sys_getlogin in sys/kern/kern_prot.c does a copyout. This is
clearly
broken in the 'blitz' branch.

Warner

--00000000000066c7d50605ce9dad
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
=C2=A0bsd-user/bsd-proc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 39 ++++=
+++++++++++++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c | 12 +++++++++++<br>
=C2=A02 files changed, 51 insertions(+)<br>
<br>
diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h<br>
index 7b25aa1982..fd05422d9a 100644<br>
--- a/bsd-user/bsd-proc.h<br>
+++ b/bsd-user/bsd-proc.h<br>
@@ -26,6 +26,7 @@<br>
=C2=A0#include &quot;gdbstub/syscalls.h&quot;<br>
=C2=A0#include &quot;qemu/plugin.h&quot;<br>
<br>
+extern int _getlogin(char*, int);<br>
=C2=A0int bsd_get_ncpu(void);<br>
<br>
=C2=A0/* exit(2) */<br>
@@ -85,4 +86,42 @@ static inline abi_long do_bsd_setgroups(abi_long gidsets=
ize, abi_long arg2)<br>
=C2=A0 =C2=A0 =C2=A0return get_errno(setgroups(gidsetsize, grouplist));<br>
=C2=A0}<br>
<br>
+/* umask(2) */<br>
+static inline abi_long do_bsd_umask(abi_long arg1)<br>
+{<br>
+=C2=A0 =C2=A0 return get_errno(umask(arg1));<br>
+}<br>
+<br>
+/* setlogin(2) */<br>
+static inline abi_long do_bsd_setlogin(abi_long arg1)<br>
+{<br>
+=C2=A0 =C2=A0 abi_long ret;<br>
+=C2=A0 =C2=A0 void *p;<br>
+<br>
+=C2=A0 =C2=A0 p =3D lock_user_string(arg1);<br>
+=C2=A0 =C2=A0 if (p =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ret =3D get_errno(setlogin(p));<br>
+=C2=A0 =C2=A0 unlock_user(p, arg1, 0);<br>
+<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+/* getlogin(2) */<br>
+static inline abi_long do_bsd_getlogin(abi_long arg1, abi_long arg2)<br>
+{<br>
+=C2=A0 =C2=A0 abi_long ret;<br>
+=C2=A0 =C2=A0 void *p;<br>
+<br>
+=C2=A0 =C2=A0 p =3D lock_user_string(arg1);<br>
+=C2=A0 =C2=A0 if (p =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>This looks backwards. =
We&#39;re calling the kernel to get this string, so the</div><div>target_st=
rlen() tht lock_user_string() does is on the receiving buffer, not</div><di=
v>the length of the string that we&#39;d like to write.</div><div><br></div=
><div>=C2=A0I think we want</div><div>=C2=A0 =C2=A0 p =3D lock_user(VERIFY_=
READ, arg1, arg2, 0);<br></div><div><br></div><div>for this. sys_getlogin i=
n sys/kern/kern_prot.c does a copyout. This is clearly</div><div>broken in =
the &#39;blitz&#39; branch.</div><div><br></div><div>Warner</div></div></di=
v>

--00000000000066c7d50605ce9dad--

