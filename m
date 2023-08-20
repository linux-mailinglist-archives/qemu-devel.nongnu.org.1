Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C50781C5D
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:23:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXZxV-0008Fz-L8; Sun, 20 Aug 2023 00:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXZxT-0008Fp-4c
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:22:35 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXZxQ-0007KP-Cz
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:22:34 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-522dd6b6438so2650433a12.0
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692505351; x=1693110151;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nQKg6FKFPtPrfIGepbVU6+4Z5nXpUe0RaWYkYYJpcgc=;
 b=br4b/S9HsNHdjLvISRkNCpf8Oi9osr+geRuaK9iKPqLSYNQbxQ031G0aV1pO2vOeWy
 BigJq+w47gNvnS/sBSl69/tSEUm6Um4vvPOYgVK8TEIDPyOql2FCu/EZJXq/ZkYPtcHN
 +LNpSW7KJGKWNqfa0Pv1LsvAmIjqjXvB2Kh3A54vp8GWBs5Kq1+MLLgvLsYgUcwqMZob
 OemqcjFhOQbk8RKMlrGa7b0qtYab24oey5qzGgy79+1bDiLg2nQ0Okmxjl2mKGaYK3Sb
 avNL19simiIpPQ68idFYYyKaa5fq/fBf0UOrAuP4in8d5ICsY5CJ6nXtw943BXyFPESh
 k6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692505351; x=1693110151;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nQKg6FKFPtPrfIGepbVU6+4Z5nXpUe0RaWYkYYJpcgc=;
 b=IlotgLd/5yb4WEoHDQUaJikncCDEp/VRRtT+X0y643cjXbLKb/6R2WNKaA2n8WQktj
 0aHddw0v6p0OtjElgjsy1KX5fxa6bE1fd//MltJMZjouFVD7gGOHcLPAqoMw0eGO3yh4
 LqgkDC1muPCaxVGjlz96Wlur8mPfuYuYGIZWd6VjAnVAU+gAPjB7zIM9El9PwaGYn3jg
 wpQSiJBjkANsBQdaMagAkaQZePDJ04nNy6f+gD4IT33P5mlTY6yAG1iCg9cfUAQQf5dP
 5WcH9zzLP40M98iSCXFzB9jm8/Wpe/eK3mecP5Vvk6l/pOFk4mVCOzaDpT9ODRnLvKaY
 T9cg==
X-Gm-Message-State: AOJu0Yz7LC0LhBrmqLbAWgJLe/xCrqGNUnMJz4dB8Z41TwOXaQsyBLIy
 J2ndjE4wy2fmMr5JxnAmPrV21qeY/BooHJe0W//K9DcHsjjR6lGpTM0=
X-Google-Smtp-Source: AGHT+IE6x8iu09YAYoMVOVUtisJ/oeZtxE4Y3k8wFTZ4HtqI3R7dQckS/vhpFR73mBLJqcHakX69jTkihxbN6/2YeIk=
X-Received: by 2002:a50:fb9a:0:b0:523:364b:e6a9 with SMTP id
 e26-20020a50fb9a000000b00523364be6a9mr2066076edq.38.1692505350494; Sat, 19
 Aug 2023 21:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-9-kariem.taha2.7@gmail.com>
In-Reply-To: <20230819094806.14965-9-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:22:23 -0600
Message-ID: <CANCZdfrP0cRHOhgV9Q4sbZS1KrfSu2BwUiGyCQFz+sMOxbFaog@mail.gmail.com>
Subject: Re: [PATCH 08/22] Implement target_set_brk function in bsd-mem.c
 instead of os-syscall.c
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Stacey Son <sson@freebsd.org>, 
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000003270780603531c38"
Received-SPF: none client-ip=2a00:1450:4864:20::530;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x530.google.com
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

--0000000000003270780603531c38
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 3:48=E2=80=AFAM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Co-authored-by: Mika=C3=ABl Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Mika=C3=ABl Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/bsd-mem.c            | 38 +++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  4 ----
>  2 files changed, 38 insertions(+), 4 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

but see below


> diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
> index e69de29bb2..6c123abf04 100644
> --- a/bsd-user/bsd-mem.c
> +++ b/bsd-user/bsd-mem.c
> @@ -0,0 +1,38 @@
> +/*
> + *  memory management system conversion routines
> + *
> + *  Copyright (c) 2013 Stacey D. Son
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#include "qemu/osdep.h"
> +
> +#include <sys/ipc.h>
> +#include <sys/shm.h>
> +
>

I'll let others comment if this is a good thing here or it needs to be
elsewhere.
I can't recall what the project's rules are for system headers on code that
runs on a limited subset of systems. For code that can run anywhere, I
know that the preference is to put this in osdep.h, but in this case I'm
unsure.

Warner


> +#include "qemu.h"
> +#include "qemu-bsd.h"
> +
> +struct bsd_shm_regions bsd_shm_regions[N_BSD_SHM_REGIONS];
> +
> +abi_ulong bsd_target_brk;
> +abi_ulong bsd_target_original_brk;
> +abi_ulong brk_page;
> +
> +void target_set_brk(abi_ulong new_brk)
> +{
> +
> +    bsd_target_original_brk =3D bsd_target_brk =3D HOST_PAGE_ALIGN(new_b=
rk);
> +    brk_page =3D HOST_PAGE_ALIGN(bsd_target_brk);
> +}
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.=
c
> index 2920370ad2..c0a22eb746 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -59,10 +59,6 @@ safe_syscall3(ssize_t, writev, int, fd, const struct
> iovec *, iov, int, iovcnt);
>  safe_syscall4(ssize_t, pwritev, int, fd, const struct iovec *, iov, int,
> iovcnt,
>      off_t, offset);
>
> -void target_set_brk(abi_ulong new_brk)
> -{
> -}
> -
>  /*
>   * errno conversion.
>   */
> --
> 2.40.0
>
>

--0000000000003270780603531c38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 19, 2023 at 3:48=E2=80=AF=
AM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Co-authored-by: Mika=C3=ABl Urankar &lt;<a href=3D"mailto:mikael.urankar@gm=
ail.com" target=3D"_blank">mikael.urankar@gmail.com</a>&gt;<br>
Signed-off-by: Mika=C3=ABl Urankar &lt;<a href=3D"mailto:mikael.urankar@gma=
il.com" target=3D"_blank">mikael.urankar@gmail.com</a>&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-mem.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 38 ++++=
+++++++++++++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 4 ----<br>
=C2=A02 files changed, 38 insertions(+), 4 deletions(-)<br></blockquote><di=
v><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.=
com">imp@bsdimp.com</a>&gt;</div><div><br></div><div>but see below<br></div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c<br>
index e69de29bb2..6c123abf04 100644<br>
--- a/bsd-user/bsd-mem.c<br>
+++ b/bsd-user/bsd-mem.c<br>
@@ -0,0 +1,38 @@<br>
+/*<br>
+ *=C2=A0 memory management system conversion routines<br>
+ *<br>
+ *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
+ *<br>
+ *=C2=A0 This program is free software; you can redistribute it and/or mod=
ify<br>
+ *=C2=A0 it under the terms of the GNU General Public License as published=
 by<br>
+ *=C2=A0 the Free Software Foundation; either version 2 of the License, or=
<br>
+ *=C2=A0 (at your option) any later version.<br>
+ *<br>
+ *=C2=A0 This program is distributed in the hope that it will be useful,<b=
r>
+ *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br=
>
+ *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See th=
e<br>
+ *=C2=A0 GNU General Public License for more details.<br>
+ *<br>
+ *=C2=A0 You should have received a copy of the GNU General Public License=
<br>
+ *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://www.gn=
u.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/li=
censes/</a>&gt;.<br>
+ */<br>
+#include &quot;qemu/osdep.h&quot;<br>
+<br>
+#include &lt;sys/ipc.h&gt;<br>
+#include &lt;sys/shm.h&gt;<br>
+<br></blockquote><div><br></div><div>I&#39;ll let others comment if this i=
s a good thing here or it needs to be elsewhere.</div><div>I can&#39;t reca=
ll what the project&#39;s rules are for system headers on code that</div><d=
iv>runs on a limited subset of systems. For code that can run anywhere, I</=
div><div>know that the preference is to put this in osdep.h, but in this ca=
se I&#39;m</div><div>unsure.</div><div><br></div><div>Warner<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+#include &quot;qemu.h&quot;<br>
+#include &quot;qemu-bsd.h&quot;<br>
+<br>
+struct bsd_shm_regions bsd_shm_regions[N_BSD_SHM_REGIONS];<br>
+<br>
+abi_ulong bsd_target_brk;<br>
+abi_ulong bsd_target_original_brk;<br>
+abi_ulong brk_page;<br>
+<br>
+void target_set_brk(abi_ulong new_brk)<br>
+{<br>
+<br>
+=C2=A0 =C2=A0 bsd_target_original_brk =3D bsd_target_brk =3D HOST_PAGE_ALI=
GN(new_brk);<br>
+=C2=A0 =C2=A0 brk_page =3D HOST_PAGE_ALIGN(bsd_target_brk);<br>
+}<br>
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c<=
br>
index 2920370ad2..c0a22eb746 100644<br>
--- a/bsd-user/freebsd/os-syscall.c<br>
+++ b/bsd-user/freebsd/os-syscall.c<br>
@@ -59,10 +59,6 @@ safe_syscall3(ssize_t, writev, int, fd, const struct iov=
ec *, iov, int, iovcnt);<br>
=C2=A0safe_syscall4(ssize_t, pwritev, int, fd, const struct iovec *, iov, i=
nt, iovcnt,<br>
=C2=A0 =C2=A0 =C2=A0off_t, offset);<br>
<br>
-void target_set_brk(abi_ulong new_brk)<br>
-{<br>
-}<br>
-<br>
=C2=A0/*<br>
=C2=A0 * errno conversion.<br>
=C2=A0 */<br>
-- <br>
2.40.0<br>
<br>
</blockquote></div></div>

--0000000000003270780603531c38--

