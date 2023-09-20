Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC517A8B90
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:20:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj1nv-0001w7-1f; Wed, 20 Sep 2023 14:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj1nq-0001vK-Io
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:19:59 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj1nk-0000na-WD
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:19:58 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52bcb8b199aso15261a12.3
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695233990; x=1695838790;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xJfCHF3mX1d04EdoY4hw5FTD2GvX/sXGPEgbq4lGkxg=;
 b=l8fuNphmhfZtdetWrXfEongqbq/wSMVzIib4FOeVZOMWDrzCRQPf9B0zANfDuwOKex
 4tfGqRchvDwpaRhO+Km6pFDvomJxqBgBhIR+Iaw6WpQtdL4sHsjw1RizsdsH8LP9bzdl
 NcWxInR+MrV957NM8Kb+vecMGtBBVhe4eYhiGzXaVC6GCO39GKW6KtrN1zpk7G96qJr2
 fhixdbBcyGx25cliMiHbi9Jbh+8VHppD/CDwQe4HfWiRsbseIZ8QgZbXVMg6fHDP+8ss
 Qna1TWeZBiYct9EzZwJq7i8zeaDuGpxiXyylTV/UJB7bXyFGmhqzC/iNazDqugU71r4z
 QODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695233990; x=1695838790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xJfCHF3mX1d04EdoY4hw5FTD2GvX/sXGPEgbq4lGkxg=;
 b=QD+YsIqzU0HlWAK3yenMufSkpgPsrASlMXMmSaCo7zk+fS+eypgTiL9jWlk1nd5DrO
 u8alH7cWbXmO70RqOcWLCKAs+GHDBEoBppI+7Y/gsxJ6JbivCi3KPA6HmKpo7CBhB5S1
 xACvnUhUHE8PanWdZhdzdCIvaCs6Rw/MeBIeEmhlTNNafSsZiGQIrOhYQw6tKfrmoayu
 wFdihzwHdV142Z8Yc0DOuQNphAbRioRjvZfX1ICEtBZUYTqQ8Yd2ksmycTuL49iqpAV8
 p91YC4ugiI/OGO7orsDwv1ugqogwm897AcG6vSF2KnImSXle1K+puU7MTGKGpqmjoDh1
 PjHg==
X-Gm-Message-State: AOJu0YwqeNyemULW1WEj3OFWAWXmWsk1yExXmd8smhSzjrjKAWdGgUud
 cTsgP96Mxe5Pv4PMiQ14Xw7VdvdQoSWqz/F2r8FdXg==
X-Google-Smtp-Source: AGHT+IHy+cPyMWilOcKi57doedcINgOWZKQ9VzZxzknsPswEfYNnYP9RVlUr8cRNva6ZuCI+EluG5VqGvnKjZUMVybA=
X-Received: by 2002:aa7:c0c6:0:b0:530:c717:b8f2 with SMTP id
 j6-20020aa7c0c6000000b00530c717b8f2mr2810865edp.38.1695233989963; Wed, 20 Sep
 2023 11:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-11-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-11-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 19:19:38 +0100
Message-ID: <CANCZdfoKUZtYQX2EwgXXYXndZth+awA-1XV0+0wpOFHhqy-Q4g@mail.gmail.com>
Subject: Re: [PATCH v2 10/28] bsd-user: Get number of cpus.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000c895810605ce6b2c"
Received-SPF: none client-ip=2a00:1450:4864:20::52c;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x52c.google.com
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

--000000000000c895810605ce6b2c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This one is almost right... one tweak is needed I think...

On Sun, Sep 17, 2023 at 10:39=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> From: Kyle Evans <kevans@FreeBSD.org>
>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/bsd-proc.c | 23 +++++++++++++++++++++++
>  bsd-user/bsd-proc.h |  2 ++
>  2 files changed, 25 insertions(+)
>
> diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
> index 19f6efe1f7..78f5b172d7 100644
> --- a/bsd-user/bsd-proc.c
> +++ b/bsd-user/bsd-proc.c
> @@ -119,3 +119,26 @@ int host_to_target_waitstatus(int status)
>      return status;
>  }
>
> +int bsd_get_ncpu(void)
> +{
> +    int ncpu =3D -1;
> +    cpuset_t mask;
> +
> +    CPU_ZERO(&mask);
> +
> +    if (cpuset_getaffinity(CPU_LEVEL_WHICH, CPU_WHICH_TID, -1,
> sizeof(mask),
> +                           &mask) =3D=3D 0) {
> +        ncpu =3D CPU_COUNT(&mask);
> +    }
> +#ifdef _SC_NPROCESSORS_ONLN
> +    if (ncpu =3D=3D -1) {
> +        ncpu =3D sysconf(_SC_NPROCESSORS_ONLN);
> +    }
> +#endif
>

I think that the #ifdef and #endif lines can be removed. These are defined
on all version of FreeBSD, NetBSD and OpenBSD (I think also DragonFly)
in the unlikely event that it gets bsd-user support.

With that fixed,

Reviewed by: Warner Losh <imp@bsdimp.com>

--000000000000c895810605ce6b2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">This one is almost right... one tweak is =
needed I think...</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Sun, Sep 17, 2023 at 10:39=E2=80=AFPM Karim Taha &lt;<a=
 href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.7@gmail.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Kyl=
e Evans &lt;kevans@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-proc.c | 23 +++++++++++++++++++++++<br>
=C2=A0bsd-user/bsd-proc.h |=C2=A0 2 ++<br>
=C2=A02 files changed, 25 insertions(+)<br>
<br>
diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c<br>
index 19f6efe1f7..78f5b172d7 100644<br>
--- a/bsd-user/bsd-proc.c<br>
+++ b/bsd-user/bsd-proc.c<br>
@@ -119,3 +119,26 @@ int host_to_target_waitstatus(int status)<br>
=C2=A0 =C2=A0 =C2=A0return status;<br>
=C2=A0}<br>
<br>
+int bsd_get_ncpu(void)<br>
+{<br>
+=C2=A0 =C2=A0 int ncpu =3D -1;<br>
+=C2=A0 =C2=A0 cpuset_t mask;<br>
+<br>
+=C2=A0 =C2=A0 CPU_ZERO(&amp;mask);<br>
+<br>
+=C2=A0 =C2=A0 if (cpuset_getaffinity(CPU_LEVEL_WHICH, CPU_WHICH_TID, -1, s=
izeof(mask),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;mask) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ncpu =3D CPU_COUNT(&amp;mask);<br>
+=C2=A0 =C2=A0 }<br>
+#ifdef _SC_NPROCESSORS_ONLN<br>
+=C2=A0 =C2=A0 if (ncpu =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ncpu =3D sysconf(_SC_NPROCESSORS_ONLN);<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br></blockquote><div><br></div><div>I think that the #ifdef and #en=
dif lines can be removed. These are defined</div><div>on all version of Fre=
eBSD, NetBSD and OpenBSD (I think also DragonFly)</div><div>in the unlikely=
 event that it gets bsd-user support.</div><div><br></div><div>With that fi=
xed,</div><div><br></div><div>Reviewed by: Warner Losh &lt;<a href=3D"mailt=
o:imp@bsdimp.com">imp@bsdimp.com</a>&gt;=C2=A0</div></div></div>

--000000000000c895810605ce6b2c--

