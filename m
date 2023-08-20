Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1862781C61
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:27:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXa1j-0001xU-Sg; Sun, 20 Aug 2023 00:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXa1f-0001vk-Nw
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:26:57 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXa1b-0007sE-IS
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:26:55 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4fe21e7f3d1so3332948e87.3
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692505609; x=1693110409;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oZoJa1ExXgSC+HpWz3rg6pua/y98tFfgAaxhOCXdQSY=;
 b=rI565r67fcwtgIOjBW0aFFgQqMsocZJypD2g4CL/eN0+cyAeafxhtU305XWIIn4mV8
 O90ezJTNqTVq2YRzLkuyk/RZI8VTHsE3sKvdHt7seV8yUS/8B6Of1kj16AZKAlKkDh22
 PtwVO7hv28VXVoYCxxtHCST1nP85o/rlpsyhm4fUB4KYPPAMAPuVW9JP/Rw0Sf6PCEB6
 d8lE8FMFORzgH6RC3KITe6nmnGxXyDEfpE9aAf11Re3556TIO+04O05fZ2kDwcuRJ+vB
 l0kks667nfNYsCz71/U+LzuFGQlRUUpk/2DObyNjHGZsUPaQGrW8cSv9QS/stBi+4vjg
 5yCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692505609; x=1693110409;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oZoJa1ExXgSC+HpWz3rg6pua/y98tFfgAaxhOCXdQSY=;
 b=EeRViSuPPOyd7Pkly02QZ10EoHLvOR+A04rf0+dUhqZCFJT3VihKo4xvQ/2/L22RWe
 Wgd2Nf/jO9uqjh6mD+tth+Q4xCSGixe5XM/HnYBtXQ8RaA9TcAus0eEfIskDE0s5dekc
 ObfqOulbxV+q15sH2R7sZ1D6Yb0RX6O5hXaRW61fGcWqq7Zf4VWNFauUOqRJ+WDos5uM
 MPr0dF+CTOvUUqqoPKTYMjByMLyf+/liRWDxO76+/3GkZJ5Q/pkxDd/+qJERdladXuKC
 vRHtKeSCeAarnIVrl7+9OS0m65R25ZsnLMOFxt/wNLlE7Md1PXO4bsNCEtGSYnkQ3NCY
 q5oA==
X-Gm-Message-State: AOJu0YzkeMW6w7G3274m+8T/F+I7iyw/O5Qeo67tT8yoa/mM554UbXxr
 k+p2DkrINYjZpnMDkOLVqv/2CVoGMFPM07BnDJ1oEt/Qm4VHbzT4irs=
X-Google-Smtp-Source: AGHT+IHUrTdAqBEOfCBdWhj1ZhuLrbKj+BpTXhCUFmTp2aPx2YUXue+TWArHrXhvBQdsa7WCgU48+cju17b+hMDLIBI=
X-Received: by 2002:a05:6512:1145:b0:4fb:76a5:2325 with SMTP id
 m5-20020a056512114500b004fb76a52325mr1849762lfg.24.1692505609562; Sat, 19 Aug
 2023 21:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-12-kariem.taha2.7@gmail.com>
In-Reply-To: <20230819094806.14965-12-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:26:42 -0600
Message-ID: <CANCZdfp5A27NZkYPTk_+3jUpy==9-7pUdgnpPx2ZAizPQrqbDA@mail.gmail.com>
Subject: Re: [PATCH 11/22] Introduce bsd-mem.h to the source tree
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000a3818c0603532bbe"
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

--000000000000a3818c0603532bbe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 3:49=E2=80=AFAM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> To preserve the copyright notice and help with the 'Author' info for
> subsequent changes to the file.
>

I'd drop the first 'To' in this message. It's clearer without it what is
meant.


> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/bsd-mem.h            | 65 +++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  1 +
>  2 files changed, 66 insertions(+)
>  create mode 100644 bsd-user/bsd-mem.h
>

otherwise
Reviewed-by: Warner Losh <imp@bsdimp.com>

Warner


> diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
> new file mode 100644
> index 0000000000..fed7b7cd80
> --- /dev/null
> +++ b/bsd-user/bsd-mem.h
> @@ -0,0 +1,65 @@
> +/*
> + *  memory management system call shims and definitions
> + *
> + *  Copyright (c) 2013-15 Stacey D. Son
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
> +/*
> + * Copyright (c) 1982, 1986, 1993
> + *      The Regents of the University of California.  All rights reserve=
d.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in th=
e
> + *    documentation and/or other materials provided with the distributio=
n.
> + * 4. Neither the name of the University nor the names of its contributo=
rs
> + *    may be used to endorse or promote products derived from this
> software
> + *    without specific prior written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' A=
ND
> + * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
> PURPOSE
> + * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE
> LIABLE
> + * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> CONSEQUENTIAL
> + * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOO=
DS
> + * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
> STRICT
> + * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
> WAY
> + * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY O=
F
> + * SUCH DAMAGE.
> + */
> +
> +#ifndef BSD_USER_BSD_MEM_H
> +#define BSD_USER_BSD_MEM_H
> +
> +#include <sys/types.h>
> +#include <sys/ipc.h>
> +#include <sys/mman.h>
> +#include <sys/shm.h>
> +#include <fcntl.h>
> +
> +#include "qemu-bsd.h"
> +
> +extern struct bsd_shm_regions bsd_shm_regions[];
> +extern abi_ulong bsd_target_brk;
> +extern abi_ulong bsd_target_original_brk;
> +extern abi_ulong brk_page;
> +
> +#endif /* BSD_USER_BSD_MEM_H */
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.=
c
> index c0a22eb746..7e2a395e0f 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -35,6 +35,7 @@
>
>  /* BSD independent syscall shims */
>  #include "bsd-file.h"
> +#include "bsd-mem.h"
>  #include "bsd-proc.h"
>
>  /* *BSD dependent syscall shims */
> --
> 2.40.0
>
>

--000000000000a3818c0603532bbe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 19, 2023 at 3:49=E2=80=AF=
AM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
To preserve the copyright notice and help with the &#39;Author&#39; info fo=
r<br>
subsequent changes to the file.<br></blockquote><div><br></div><div>I&#39;d=
 drop the first &#39;To&#39; in this message. It&#39;s clearer without it w=
hat is meant.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 65 ++++=
+++++++++++++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 1 +<br>
=C2=A02 files changed, 66 insertions(+)<br>
=C2=A0create mode 100644 bsd-user/bsd-mem.h<br></blockquote><div><br></div>=
<div>otherwise</div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp=
@bsdimp.com">imp@bsdimp.com</a>&gt;</div><div><br></div><div>Warner<br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h<br>
new file mode 100644<br>
index 0000000000..fed7b7cd80<br>
--- /dev/null<br>
+++ b/bsd-user/bsd-mem.h<br>
@@ -0,0 +1,65 @@<br>
+/*<br>
+ *=C2=A0 memory management system call shims and definitions<br>
+ *<br>
+ *=C2=A0 Copyright (c) 2013-15 Stacey D. Son<br>
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
+/*<br>
+ * Copyright (c) 1982, 1986, 1993<br>
+ *=C2=A0 =C2=A0 =C2=A0 The Regents of the University of California.=C2=A0 =
All rights reserved.<br>
+ *<br>
+ * Redistribution and use in source and binary forms, with or without<br>
+ * modification, are permitted provided that the following conditions<br>
+ * are met:<br>
+ * 1. Redistributions of source code must retain the above copyright<br>
+ *=C2=A0 =C2=A0 notice, this list of conditions and the following disclaim=
er.<br>
+ * 2. Redistributions in binary form must reproduce the above copyright<br=
>
+ *=C2=A0 =C2=A0 notice, this list of conditions and the following disclaim=
er in the<br>
+ *=C2=A0 =C2=A0 documentation and/or other materials provided with the dis=
tribution.<br>
+ * 4. Neither the name of the University nor the names of its contributors=
<br>
+ *=C2=A0 =C2=A0 may be used to endorse or promote products derived from th=
is software<br>
+ *=C2=A0 =C2=A0 without specific prior written permission.<br>
+ *<br>
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS&#39;&=
#39; AND<br>
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE<b=
r>
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURP=
OSE<br>
+ * ARE DISCLAIMED.=C2=A0 IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE =
LIABLE<br>
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENT=
IAL<br>
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS=
<br>
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)<b=
r>
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STR=
ICT<br>
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY W=
AY<br>
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF<=
br>
+ * SUCH DAMAGE.<br>
+ */<br>
+<br>
+#ifndef BSD_USER_BSD_MEM_H<br>
+#define BSD_USER_BSD_MEM_H<br>
+<br>
+#include &lt;sys/types.h&gt;<br>
+#include &lt;sys/ipc.h&gt;<br>
+#include &lt;sys/mman.h&gt;<br>
+#include &lt;sys/shm.h&gt;<br>
+#include &lt;fcntl.h&gt;<br>
+<br>
+#include &quot;qemu-bsd.h&quot;<br>
+<br>
+extern struct bsd_shm_regions bsd_shm_regions[];<br>
+extern abi_ulong bsd_target_brk;<br>
+extern abi_ulong bsd_target_original_brk;<br>
+extern abi_ulong brk_page;<br>
+<br>
+#endif /* BSD_USER_BSD_MEM_H */<br>
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c<=
br>
index c0a22eb746..7e2a395e0f 100644<br>
--- a/bsd-user/freebsd/os-syscall.c<br>
+++ b/bsd-user/freebsd/os-syscall.c<br>
@@ -35,6 +35,7 @@<br>
<br>
=C2=A0/* BSD independent syscall shims */<br>
=C2=A0#include &quot;bsd-file.h&quot;<br>
+#include &quot;bsd-mem.h&quot;<br>
=C2=A0#include &quot;bsd-proc.h&quot;<br>
<br>
=C2=A0/* *BSD dependent syscall shims */<br>
-- <br>
2.40.0<br>
<br>
</blockquote></div></div>

--000000000000a3818c0603532bbe--

