Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A5C7ADC06
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:47:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qknnE-0003TV-7K; Mon, 25 Sep 2023 11:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qknnA-0003SK-7f
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:46:36 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qknn7-0003bd-Vz
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:46:35 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so17614771a12.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 08:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695656791; x=1696261591;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jKZLq4nL685BAWGiUMaVF7u9ocGOVf7yVpRDuRi9AKE=;
 b=txAdRbGaFqnrpuPFdF6aM1Pf5jJ4NgmxxO1UlBI6Z3J6ap3UoaU8XJFPXw8p6L/jYi
 7/3en60AFr9o2TZdbdwHx4aNMsR3HKK6HhGfFBNtt0yvoS34BXcT8u+e8y1BYvSTkER0
 csHbHGu109fVFhKNCJJgNFw6131qBpBixJ3iBVPSkFjHnUSWwNYjodbB8shHh4+N9Yzh
 T3xQG0tcJsWLYze0eOVWeef586t1BiSt4OZvbJMhyyN8UQaPUFFCmc5Gh8umHSgeM7Ku
 3Kn/ZG9ASlLQPKHCyid3Y1LZyPivqOcFcFWSmDZUxpzHd9YbAy/bQ+T+bMmTiWx7txAq
 y69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695656791; x=1696261591;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jKZLq4nL685BAWGiUMaVF7u9ocGOVf7yVpRDuRi9AKE=;
 b=KYsbhHK9ADFu0D4rlZFfDd7cIooQRLr5op9POsH6348O5T5OY7mMpIcYSAsaY8GPRK
 qktVZB4xw27uGOP2WwoRGpx6eDIdQpNXbJo78IfrUVvi4zqRyqpkPYRhLx96Ga2nBDFR
 z2YOdGjnCXIiIZl/MLWSaeDlRkKOsTHrMKQyppMdr/V1GEc40C/Qa/0D0P9nLSnx7fYz
 Fkp5oprIbvOh++57R/XvPSmtReW7Ii/I3uiZpeKPsEVUBNJ9znH1N6f+qQ7M5aEI78oL
 ciieY2JJvEtm03EaSapBlrVky5XJmtpZzSCmh71J4Or+I7ZlIs6tRUBXIIS9Dz7g4ki2
 O4TQ==
X-Gm-Message-State: AOJu0YwwKouN3R8xsevkSFiOTVSkODbAeakXeY6zTqmuP1QZK8+FwBVt
 plGpUjkSwbJQ9rn5Fn+MN86HeahXKGjfltcxY3qK6g==
X-Google-Smtp-Source: AGHT+IHlEPO22LXk5CrY7+/G8YHUm2K3cqmB3MpcjMnIyf6z+xxiJta9lmJ2xlG8SK80E6aQkqiFtRTnh7jJBfo5u/E=
X-Received: by 2002:a17:906:cd2:b0:9ae:5df2:2291 with SMTP id
 l18-20020a1709060cd200b009ae5df22291mr14036ejh.1.1695656790553; Mon, 25 Sep
 2023 08:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
 <20230924210136.11966-7-kariem.taha2.7@gmail.com>
In-Reply-To: <20230924210136.11966-7-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 25 Sep 2023 09:46:19 -0600
Message-ID: <CANCZdfozghzX5MqZk4tmQARHQvX4YW31Kwmzv=WG24X3W-9N6g@mail.gmail.com>
Subject: Re: [PATCH v4 06/28] bsd-user: Implement target_to_host_resource
 conversion function
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000a990aa060630dc7a"
Received-SPF: none client-ip=2a00:1450:4864:20::531;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x531.google.com
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

--000000000000a990aa060630dc7a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 8:36=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/bsd-proc.c  | 40 ++++++++++++++++++++++++++++++++++++++++
>  bsd-user/bsd-proc.h  |  4 ++++
>  bsd-user/meson.build |  6 ++++++
>  3 files changed, 50 insertions(+)
>  create mode 100644 bsd-user/bsd-proc.c
>

This looks good. The extra libraries relative to linux-user are for the
stuff bsd-user does to support some additional things than linux-user
supports.

Reviewed-by: Warner Losh <imp@bsdimp.com>



> diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
> new file mode 100644
> index 0000000000..68410a0aa9
> --- /dev/null
> +++ b/bsd-user/bsd-proc.c
> @@ -0,0 +1,40 @@
> +/*
> + *  BSD process related system call helpers
> + *
> + *  Copyright (c) 2013-14 Stacey D. Son
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
> +#include <sys/param.h>
> +#include <sys/types.h>
> +#include <sys/cpuset.h>
> +#include <sys/resource.h>
> +#include <sys/wait.h>
> +
> +#include "qemu.h"
> +#include "qemu-bsd.h"
> +#include "signal-common.h"
> +
> +#include "bsd-proc.h"
> +
> +/*
> + * resource/rusage conversion
> + */
> +int target_to_host_resource(int code)
> +{
> +    return code;
> +}
> +
> diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
> index a1061bffb8..048773a75d 100644
> --- a/bsd-user/bsd-proc.h
> +++ b/bsd-user/bsd-proc.h
> @@ -22,6 +22,10 @@
>
>  #include <sys/resource.h>
>
> +#include "qemu-bsd.h"
> +#include "gdbstub/syscalls.h"
> +#include "qemu/plugin.h"
> +
>  /* exit(2) */
>  static inline abi_long do_bsd_exit(void *cpu_env, abi_long arg1)
>  {
> diff --git a/bsd-user/meson.build b/bsd-user/meson.build
> index 5243122fc5..b97fce1472 100644
> --- a/bsd-user/meson.build
> +++ b/bsd-user/meson.build
> @@ -7,6 +7,7 @@ bsd_user_ss =3D ss.source_set()
>  common_user_inc +=3D include_directories('include')
>
>  bsd_user_ss.add(files(
> +  'bsd-proc.c',
>    'bsdload.c',
>    'elfload.c',
>    'main.c',
> @@ -16,6 +17,11 @@ bsd_user_ss.add(files(
>    'uaccess.c',
>  ))
>
> +elf =3D cc.find_library('elf', required: true)
> +procstat =3D cc.find_library('procstat', required: true)
> +kvm =3D cc.find_library('kvm', required: true)
> +bsd_user_ss.add(elf, procstat, kvm)
> +
>  # Pull in the OS-specific build glue, if any
>  subdir(targetos)
>
> --
> 2.42.0
>
>

--000000000000a990aa060630dc7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 24, 2023 at 8:36=E2=80=AF=
PM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-proc.c=C2=A0 | 40 ++++++++++++++++++++++++++++++++++++++=
++<br>
=C2=A0bsd-user/bsd-proc.h=C2=A0 |=C2=A0 4 ++++<br>
=C2=A0bsd-user/meson.build |=C2=A0 6 ++++++<br>
=C2=A03 files changed, 50 insertions(+)<br>
=C2=A0create mode 100644 bsd-user/bsd-proc.c<br></blockquote><div><br></div=
><div>This looks good. The extra libraries relative to linux-user are for t=
he stuff bsd-user does to support some additional things than linux-user su=
pports.</div><div><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"ma=
ilto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;</div><div><br></div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c<br>
new file mode 100644<br>
index 0000000000..68410a0aa9<br>
--- /dev/null<br>
+++ b/bsd-user/bsd-proc.c<br>
@@ -0,0 +1,40 @@<br>
+/*<br>
+ *=C2=A0 BSD process related system call helpers<br>
+ *<br>
+ *=C2=A0 Copyright (c) 2013-14 Stacey D. Son<br>
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
+#include &lt;sys/param.h&gt;<br>
+#include &lt;sys/types.h&gt;<br>
+#include &lt;sys/cpuset.h&gt;<br>
+#include &lt;sys/resource.h&gt;<br>
+#include &lt;sys/wait.h&gt;<br>
+<br>
+#include &quot;qemu.h&quot;<br>
+#include &quot;qemu-bsd.h&quot;<br>
+#include &quot;signal-common.h&quot;<br>
+<br>
+#include &quot;bsd-proc.h&quot;<br>
+<br>
+/*<br>
+ * resource/rusage conversion<br>
+ */<br>
+int target_to_host_resource(int code)<br>
+{<br>
+=C2=A0 =C2=A0 return code;<br>
+}<br>
+<br>
diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h<br>
index a1061bffb8..048773a75d 100644<br>
--- a/bsd-user/bsd-proc.h<br>
+++ b/bsd-user/bsd-proc.h<br>
@@ -22,6 +22,10 @@<br>
<br>
=C2=A0#include &lt;sys/resource.h&gt;<br>
<br>
+#include &quot;qemu-bsd.h&quot;<br>
+#include &quot;gdbstub/syscalls.h&quot;<br>
+#include &quot;qemu/plugin.h&quot;<br>
+<br>
=C2=A0/* exit(2) */<br>
=C2=A0static inline abi_long do_bsd_exit(void *cpu_env, abi_long arg1)<br>
=C2=A0{<br>
diff --git a/bsd-user/meson.build b/bsd-user/meson.build<br>
index 5243122fc5..b97fce1472 100644<br>
--- a/bsd-user/meson.build<br>
+++ b/bsd-user/meson.build<br>
@@ -7,6 +7,7 @@ bsd_user_ss =3D ss.source_set()<br>
=C2=A0common_user_inc +=3D include_directories(&#39;include&#39;)<br>
<br>
=C2=A0bsd_user_ss.add(files(<br>
+=C2=A0 &#39;bsd-proc.c&#39;,<br>
=C2=A0 =C2=A0&#39;bsdload.c&#39;,<br>
=C2=A0 =C2=A0&#39;elfload.c&#39;,<br>
=C2=A0 =C2=A0&#39;main.c&#39;,<br>
@@ -16,6 +17,11 @@ bsd_user_ss.add(files(<br>
=C2=A0 =C2=A0&#39;uaccess.c&#39;,<br>
=C2=A0))<br>
<br>
+elf =3D cc.find_library(&#39;elf&#39;, required: true)<br>
+procstat =3D cc.find_library(&#39;procstat&#39;, required: true)<br>
+kvm =3D cc.find_library(&#39;kvm&#39;, required: true)<br>
+bsd_user_ss.add(elf, procstat, kvm)<br>
+<br>
=C2=A0# Pull in the OS-specific build glue, if any<br>
=C2=A0subdir(targetos)<br>
<br>
-- <br>
2.42.0<br>
<br>
</blockquote></div></div>

--000000000000a990aa060630dc7a--

