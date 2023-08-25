Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 741E3788F3A
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 21:20:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZcKi-0005Ro-Vm; Fri, 25 Aug 2023 15:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qZcKg-0005Re-9D
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 15:18:58 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qZcKd-000789-GX
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 15:18:58 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b9c907bc68so19312861fa.2
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 12:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692991132; x=1693595932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lpzlw/7H2xsPTU2hCIqhm0vT/bPV7ifztZD/fG5Wsos=;
 b=DmUckBIJZRxaheYdgnQo7x/Kkxu6GQly/dp4AtBq0y3JflJo3J9tbv6S3jczRyMzz7
 pHGegrsT1mXEIZ3fbu9o0Q0ppqHM8N98LmC1lOGpAQ3+blfPM/kBQa42+UyDqJmLlAlY
 foBIqsMmeIcA1wZO+vyDzbf7Hojfz7COU+dR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692991132; x=1693595932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lpzlw/7H2xsPTU2hCIqhm0vT/bPV7ifztZD/fG5Wsos=;
 b=U3BI7yF7yesWA34YyUbVA09/oIu/QjtvO3ZoywKwgJZZAJXo0GPUzs7owlGLGCQj+x
 1uSupzHi9VxfJluaL189MuFUjXTD+gInHSQ7lsvoK+B067c2MKehGm9DqfwfeDrWL8Kl
 WzQt9WsJdLOpWHINStt8TmD9iQ2873DxY5QqtOnYMcOW0IujNs2Jbl/D8y3mHnlFOiBQ
 ZUcpDMMbWDA3a31Osw+CyxepXVyycxvYwJIXEQH9gMB4uRUS8Kax0n7BMPkYtWeEcHTR
 zMw1SABDd+ZJdUpAO0XtKZs2j0yVeAVVE8mjQ0ozLgLGIFIP1a0Jn5CVh2oQTgqtBsza
 Meug==
X-Gm-Message-State: AOJu0YwNsUKPjMOZPEH9ITh2Ec9kZFB+QEOVJ05DA1QYi8NZKcdNxbFi
 CpJCLEcz/EGRyLQdzriKcDepRys4P9N9vF+BrYZRSQ==
X-Google-Smtp-Source: AGHT+IH520efzf033zKyRpiUCOWpEXDfmlgvARwhiYsjTR6uC5AFK8DInSaFol+uZOY+h9cO3HZmLA==
X-Received: by 2002:a2e:9357:0:b0:2b7:33b9:8809 with SMTP id
 m23-20020a2e9357000000b002b733b98809mr14260402ljh.16.1692991131835; 
 Fri, 25 Aug 2023 12:18:51 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com.
 [209.85.208.41]) by smtp.gmail.com with ESMTPSA id
 v19-20020a170906339300b0099bc8db97bcsm1241697eja.131.2023.08.25.12.18.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 12:18:50 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-5232ce75e26so2335a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 12:18:49 -0700 (PDT)
X-Received: by 2002:a50:f603:0:b0:525:573c:643b with SMTP id
 c3-20020a50f603000000b00525573c643bmr40520edn.7.1692991129712; Fri, 25 Aug
 2023 12:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230824234046.499-1-gurchetansingh@chromium.org>
 <50caa93a-c1be-4db5-94ee-eb154623f406@gmail.com>
In-Reply-To: <50caa93a-c1be-4db5-94ee-eb154623f406@gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Fri, 25 Aug 2023 12:18:37 -0700
X-Gmail-Original-Message-ID: <CAAfnVB=0wgM8OvqvgqAZPMAt2nAPLbMfBTVO9Ywb0RYCrKsW_A@mail.gmail.com>
Message-ID: <CAAfnVB=0wgM8OvqvgqAZPMAt2nAPLbMfBTVO9Ywb0RYCrKsW_A@mail.gmail.com>
Subject: Re: [PATCH v12 0/9] rutabaga_gfx + gfxstream
To: Akihiko Odaki <akihiko.odaki@gmail.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, ray.huang@amd.com, 
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is, ernunes@redhat.com, 
 manos.pitsidianakis@linaro.org, philmd@linaro.org, 
 mark.cave-ayland@ilande.co.uk
Content-Type: multipart/alternative; boundary="000000000000e5a40e0603c436e1"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=gurchetansingh@chromium.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000e5a40e0603c436e1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 9:53=E2=80=AFPM Akihiko Odaki <akihiko.odaki@gmail.=
com>
wrote:

> On 2023/08/25 8:40, Gurchetan Singh wrote:
> > From: Gurchetan Singh <gurchetansingh@google.com>
> >
> > Prior versions:
> >
> > Changes since v11:
> > - Incorporated review feedback
> >
> > How to build both rutabaga and gfxstream guest/host libs:
> >
> > https://crosvm.dev/book/appendix/rutabaga_gfx.html
> >
> > Branch containing this patch series (now on QEMU Gitlab):
> >
> > https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v12
> >
> > Antonio Caggiano (2):
> >    virtio-gpu: CONTEXT_INIT feature
> >    virtio-gpu: blob prep
> >
> > Dr. David Alan Gilbert (1):
> >    virtio: Add shared memory capability
> >
> > Gerd Hoffmann (1):
> >    virtio-gpu: hostmem
> >
> > Gurchetan Singh (5):
> >    gfxstream + rutabaga prep: added need defintions, fields, and option=
s
> >    gfxstream + rutabaga: add initial support for gfxstream
> >    gfxstream + rutabaga: meson support
> >    gfxstream + rutabaga: enable rutabaga
> >    docs/system: add basic virtio-gpu documentation
> >
> >   docs/system/device-emulation.rst     |    1 +
> >   docs/system/devices/virtio-gpu.rst   |  112 +++
> >   hw/display/meson.build               |   22 +
> >   hw/display/virtio-gpu-base.c         |    6 +-
> >   hw/display/virtio-gpu-pci-rutabaga.c |   47 ++
> >   hw/display/virtio-gpu-pci.c          |   14 +
> >   hw/display/virtio-gpu-rutabaga.c     | 1119 +++++++++++++++++++++++++=
+
> >   hw/display/virtio-gpu.c              |   16 +-
> >   hw/display/virtio-vga-rutabaga.c     |   50 ++
> >   hw/display/virtio-vga.c              |   33 +-
> >   hw/virtio/virtio-pci.c               |   18 +
> >   include/hw/virtio/virtio-gpu-bswap.h |   15 +
> >   include/hw/virtio/virtio-gpu.h       |   41 +
> >   include/hw/virtio/virtio-pci.h       |    4 +
> >   meson.build                          |    7 +
> >   meson_options.txt                    |    2 +
> >   scripts/meson-buildoptions.sh        |    3 +
> >   softmmu/qdev-monitor.c               |    3 +
> >   softmmu/vl.c                         |    1 +
> >   19 files changed, 1495 insertions(+), 19 deletions(-)
> >   create mode 100644 docs/system/devices/virtio-gpu.rst
> >   create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
> >   create mode 100644 hw/display/virtio-gpu-rutabaga.c
> >   create mode 100644 hw/display/virtio-vga-rutabaga.c
> >
>
> Thanks for keeping working on this. For the entire series:
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>

Awesome, thanks.  I'll wait a few days for possible additional comments,
otherwise I'll send out v13 with additional r-b tags.

--000000000000e5a40e0603c436e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 24, 2023 at 9:53=E2=80=AF=
PM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@gmail.com" target=3D"_=
blank">akihiko.odaki@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On 2023/08/25 8:40, Gurchetan Singh wrote:<br=
>
&gt; From: Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@google.com"=
 target=3D"_blank">gurchetansingh@google.com</a>&gt;<br>
&gt; <br>
&gt; Prior versions:<br>
&gt; <br>
&gt; Changes since v11:<br>
&gt; - Incorporated review feedback<br>
&gt; <br>
&gt; How to build both rutabaga and gfxstream guest/host libs:<br>
&gt; <br>
&gt; <a href=3D"https://crosvm.dev/book/appendix/rutabaga_gfx.html" rel=3D"=
noreferrer" target=3D"_blank">https://crosvm.dev/book/appendix/rutabaga_gfx=
.html</a><br>
&gt; <br>
&gt; Branch containing this patch series (now on QEMU Gitlab):<br>
&gt; <br>
&gt; <a href=3D"https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxst=
ream-v12" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/gurchetan=
singh/qemu/-/commits/qemu-gfxstream-v12</a><br>
&gt; <br>
&gt; Antonio Caggiano (2):<br>
&gt;=C2=A0 =C2=A0 virtio-gpu: CONTEXT_INIT feature<br>
&gt;=C2=A0 =C2=A0 virtio-gpu: blob prep<br>
&gt; <br>
&gt; Dr. David Alan Gilbert (1):<br>
&gt;=C2=A0 =C2=A0 virtio: Add shared memory capability<br>
&gt; <br>
&gt; Gerd Hoffmann (1):<br>
&gt;=C2=A0 =C2=A0 virtio-gpu: hostmem<br>
&gt; <br>
&gt; Gurchetan Singh (5):<br>
&gt;=C2=A0 =C2=A0 gfxstream + rutabaga prep: added need defintions, fields,=
 and options<br>
&gt;=C2=A0 =C2=A0 gfxstream + rutabaga: add initial support for gfxstream<b=
r>
&gt;=C2=A0 =C2=A0 gfxstream + rutabaga: meson support<br>
&gt;=C2=A0 =C2=A0 gfxstream + rutabaga: enable rutabaga<br>
&gt;=C2=A0 =C2=A0 docs/system: add basic virtio-gpu documentation<br>
&gt; <br>
&gt;=C2=A0 =C2=A0docs/system/device-emulation.rst=C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0docs/system/devices/virtio-gpu.rst=C2=A0 =C2=A0|=C2=A0 112=
 +++<br>
&gt;=C2=A0 =C2=A0hw/display/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A022 +<br>
&gt;=C2=A0 =C2=A0hw/display/virtio-gpu-base.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A0 6 +-<br>
&gt;=C2=A0 =C2=A0hw/display/virtio-gpu-pci-rutabaga.c |=C2=A0 =C2=A047 ++<b=
r>
&gt;=C2=A0 =C2=A0hw/display/virtio-gpu-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A014 +<br>
&gt;=C2=A0 =C2=A0hw/display/virtio-gpu-rutabaga.c=C2=A0 =C2=A0 =C2=A0| 1119=
 ++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/display/virtio-gpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A016 +-<br>
&gt;=C2=A0 =C2=A0hw/display/virtio-vga-rutabaga.c=C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A050 ++<br>
&gt;=C2=A0 =C2=A0hw/display/virtio-vga.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A033 +-<br>
&gt;=C2=A0 =C2=A0hw/virtio/virtio-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A018 +<br>
&gt;=C2=A0 =C2=A0include/hw/virtio/virtio-gpu-bswap.h |=C2=A0 =C2=A015 +<br=
>
&gt;=C2=A0 =C2=A0include/hw/virtio/virtio-gpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A041 +<br>
&gt;=C2=A0 =C2=A0include/hw/virtio/virtio-pci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 4 +<br>
&gt;=C2=A0 =C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 7 +<br>
&gt;=C2=A0 =C2=A0meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
&gt;=C2=A0 =C2=A0scripts/meson-buildoptions.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 3 +<br>
&gt;=C2=A0 =C2=A0softmmu/qdev-monitor.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 3 +<br>
&gt;=C2=A0 =C2=A0softmmu/vl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1 +<br>
&gt;=C2=A0 =C2=A019 files changed, 1495 insertions(+), 19 deletions(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/system/devices/virtio-gpu.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c<br=
>
&gt;=C2=A0 =C2=A0create mode 100644 hw/display/virtio-gpu-rutabaga.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/display/virtio-vga-rutabaga.c<br>
&gt; <br>
<br>
Thanks for keeping working on this. For the entire series:<br>
Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" =
target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
Tested-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" ta=
rget=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br></blockquote><div><br><=
/div><div>Awesome, thanks.=C2=A0 I&#39;ll wait a few days for possible addi=
tional comments, otherwise I&#39;ll send out v13 with additional r-b tags.<=
/div><div>=C2=A0</div></div></div>

--000000000000e5a40e0603c436e1--

