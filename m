Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAAA781C57
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:09:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXZkU-0003su-Up; Sun, 20 Aug 2023 00:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXZkQ-0003s9-13
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:09:06 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXZkM-0005Co-7B
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:09:04 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4ff9121fd29so3215970e87.3
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692504540; x=1693109340;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p8M0HmCvxQeYQFpBLoe2kVFE1V1vKH7gkDXVWOfrLZw=;
 b=g/vexghz9/LgCBrW+qVigFvdtBe5hkVgVyUpMdCnPgCbDWdGORS4zxqt/A35lAhIUY
 fEJ0Sgmv7OMDngvPWgXC/tOU+2Bmo7EhN3mSTVR+m0+UO+IwNQMzCLnKKUbQF74JZp66
 SGul7eU2+wXg86iI32ZQPjKWkvOjawzfWrRrotTK7exOs8k036YmhJnNaoiVKnCa/gnS
 l8+1up3v9fin8+PpEcbJD5mETfrvT0j6oxdLO1tzXoXkASNoSzERcF+tNyXF9Evxk0x5
 bXm1I0Tq+Nw/GzxxhBdTa4C5iHH+k3lHLk7fYSgmDoUWlbHJxAU7vn3P/VXHzFB9dagc
 UJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692504540; x=1693109340;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p8M0HmCvxQeYQFpBLoe2kVFE1V1vKH7gkDXVWOfrLZw=;
 b=V6lwwU1tLm1tHSMAf+pIQ2K7KHNbnLut/5NZZzP1UlxJ85HAR6mj2RuLAZZjnB5VSP
 IIPJY66OVuT0beZZEKwPzj5wCJX3rjbZoo1WfGEL+Q1rKq5Q8qO9hqyN78uzmWSsHTtg
 BFuQngpw3dqUFkrbezHYN3dM0nZVTVgzjGSecmrib6ZLpoUPMVSgz0XEnHJzwUH9U2Sy
 28xgol9kg6bJONNBcuk9RQc2MfqZcnHWSfKXuldxYikFBDaJFJB/8tZpYlLYDRz0eAdt
 bhT2pU2pr5iPkLx5+TBmD5wm06mBUrr80jL/ye8dCDPhMhk8p2Nq7QrqSL6GxO5VzzCr
 HeCQ==
X-Gm-Message-State: AOJu0Yya6TpQWo1KaZMRSNhtvVtzRyr+xIzZYZ/0EHZzZPjnvYIqaRAv
 TOiOuYEsyrgetyl+b3qUgfT61inWGmcN39/VuyBSmg==
X-Google-Smtp-Source: AGHT+IFutDzFaEy+a96wYmzxJatgx9pqPbcQ/orWwmY6gZzzXZu2nJJAPm7dvsSzZ14lwJMHQ1yKEhJtIzmrQt/6FJE=
X-Received: by 2002:a05:6512:6d1:b0:4f8:7734:8dd2 with SMTP id
 u17-20020a05651206d100b004f877348dd2mr2457532lff.53.1692504540249; Sat, 19
 Aug 2023 21:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-4-kariem.taha2.7@gmail.com>
In-Reply-To: <20230819094806.14965-4-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:08:53 -0600
Message-ID: <CANCZdfqADEjsNEamgznGe_c8uzB-o=fBvm4XefGi31A9Pjgb+A@mail.gmail.com>
Subject: Re: [PATCH 03/22] Declarations for ipc_perm and shmid_ds conversion
 functions
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000e71c32060352eb5b"
Received-SPF: none client-ip=2a00:1450:4864:20::12f;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x12f.google.com
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

--000000000000e71c32060352eb5b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 3:48=E2=80=AFAM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/qemu-bsd.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 bsd-user/qemu-bsd.h
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


> diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
> new file mode 100644
> index 0000000000..f98942ea91
> --- /dev/null
> +++ b/bsd-user/qemu-bsd.h
> @@ -0,0 +1,45 @@
> +/*
> + *  BSD conversion extern declarations
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
> +
> +#ifndef QEMU_BSD_H
> +#define QEMU_BSD_H
> +
> +#include <sys/types.h>
> +#include <sys/ipc.h>
> +#include <sys/msg.h>
> +#include <sys/resource.h>
> +#include <sys/sem.h>
> +#include <sys/shm.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +#include <sys/uuid.h>
> +#include <sys/wait.h>
> +#include <netinet/in.h>
> +
> +/* bsd-mem.c */
> +abi_long target_to_host_ipc_perm(struct ipc_perm *host_ip,
> +        abi_ulong target_addr);
> +abi_long host_to_target_ipc_perm(abi_ulong target_addr,
> +        struct ipc_perm *host_ip);
> +abi_long target_to_host_shmid_ds(struct shmid_ds *host_sd,
> +        abi_ulong target_addr);
> +abi_long host_to_target_shmid_ds(abi_ulong target_addr,
> +        struct shmid_ds *host_sd);
> +
> +#endif /* QEMU_BSD_H */
> --
> 2.40.0
>
>

--000000000000e71c32060352eb5b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 19, 2023 at 3:48=E2=80=AF=
AM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/qemu-bsd.h | 45 ++++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 45 insertions(+)<br>
=C2=A0create mode 100644 bsd-user/qemu-bsd.h<br></blockquote><div><br></div=
><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bs=
dimp.com</a>&gt;<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h<br>
new file mode 100644<br>
index 0000000000..f98942ea91<br>
--- /dev/null<br>
+++ b/bsd-user/qemu-bsd.h<br>
@@ -0,0 +1,45 @@<br>
+/*<br>
+ *=C2=A0 BSD conversion extern declarations<br>
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
+<br>
+#ifndef QEMU_BSD_H<br>
+#define QEMU_BSD_H<br>
+<br>
+#include &lt;sys/types.h&gt;<br>
+#include &lt;sys/ipc.h&gt;<br>
+#include &lt;sys/msg.h&gt;<br>
+#include &lt;sys/resource.h&gt;<br>
+#include &lt;sys/sem.h&gt;<br>
+#include &lt;sys/shm.h&gt;<br>
+#include &lt;sys/socket.h&gt;<br>
+#include &lt;sys/un.h&gt;<br>
+#include &lt;sys/uuid.h&gt;<br>
+#include &lt;sys/wait.h&gt;<br>
+#include &lt;netinet/in.h&gt;<br>
+<br>
+/* bsd-mem.c */<br>
+abi_long target_to_host_ipc_perm(struct ipc_perm *host_ip,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong target_addr);<br>
+abi_long host_to_target_ipc_perm(abi_ulong target_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ipc_perm *host_ip);<br>
+abi_long target_to_host_shmid_ds(struct shmid_ds *host_sd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong target_addr);<br>
+abi_long host_to_target_shmid_ds(abi_ulong target_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct shmid_ds *host_sd);<br>
+<br>
+#endif /* QEMU_BSD_H */<br>
-- <br>
2.40.0<br>
<br>
</blockquote></div></div>

--000000000000e71c32060352eb5b--

