Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 819C9793352
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 03:22:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdhDz-0005sa-Dl; Tue, 05 Sep 2023 21:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qdhDr-0005r1-0G
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 21:20:48 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qdhDn-0003vh-TU
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 21:20:46 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2bd0d135ca3so53088321fa.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 18:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693963241; x=1694568041; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YKzdHmJquKXWVSJeYgYm2iRBv8SFP5FpoylDUQCDYBk=;
 b=F1ITU5tDyzSrypHm7OzXhRspBgK9m+p9QBmQBtYY7NIayPxJkWxkFEx3jm26IdZ2Kj
 td/EYSWHBxGSMYbUhtsJ56UYxWe6pRErP6HGC+mtiblgIvLOg06vjMXuILAgFj9EIrH1
 J+0+IbQQhBpHhGU14NrkPs81XNED2f7M7+GB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693963241; x=1694568041;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YKzdHmJquKXWVSJeYgYm2iRBv8SFP5FpoylDUQCDYBk=;
 b=NwRTccL8Sqehf9F9/tlfJD/bFGt26GcAgTocVQBMUj57sKvjaX64OZ7z+pf542oBDV
 ZSTOmlcmuCrNxj5voh7aTP9MUrJVNnKMh7mMl4AgSxJKJOV6I2BAaIA7sKqc/VUGK+fL
 YAhexnmSfOJLOjaPAhGKjKjxiHPt9lU1jb7FjdBTlBhkHASpsBMfosXoZ5bUYCCEBXf5
 JpamjD94HQrsrit7duRsYHiBU8fJ1VLNMQ2RQBlSHJKhelUmiQbQGVrKY1d6hMhPc2V1
 vDoq5kT4sUo1AKvL3OnEvOD9hT3+C6QSDumop+aDiCesMtbW5/VOmlNMUraHflU8T9gK
 H7cw==
X-Gm-Message-State: AOJu0Yw+1mr4/J4eMrSQNmbgnN8ErDUpu0b1lou13BZTcoRKol59oxOo
 6M/Im/UJSzFBBRiObTDUaxquv5/TLrsrhYgtBqobJA==
X-Google-Smtp-Source: AGHT+IF4Up3fa4B50rvTE8qbxhJBv4AnZ1o5m25mV0+Q5Ll6d/hqW7RIy5RydQebkK5Vqc335eJ4bA==
X-Received: by 2002:a2e:3603:0:b0:2b9:e53f:e201 with SMTP id
 d3-20020a2e3603000000b002b9e53fe201mr1020490lja.31.1693963240826; 
 Tue, 05 Sep 2023 18:20:40 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com.
 [209.85.167.46]) by smtp.gmail.com with ESMTPSA id
 w20-20020a2e3014000000b002bcb89e92dcsm3174291ljw.6.2023.09.05.18.20.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 18:20:40 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-50095f6bdc5so1079e87.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 18:20:40 -0700 (PDT)
X-Received: by 2002:ac2:47e9:0:b0:501:a31d:59ef with SMTP id
 b9-20020ac247e9000000b00501a31d59efmr32972lfp.3.1693963240098; Tue, 05 Sep
 2023 18:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230829003629.410-1-gurchetansingh@chromium.org>
 <ZO/6JXmYm/lW9dSZ@amd.com>
In-Reply-To: <ZO/6JXmYm/lW9dSZ@amd.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Tue, 5 Sep 2023 18:20:27 -0700
X-Gmail-Original-Message-ID: <CAAfnVBmxaAbEX-0wVVwE94cKrGtoCRWKv58X73P+_hKM8-_hkQ@mail.gmail.com>
Message-ID: <CAAfnVBmxaAbEX-0wVVwE94cKrGtoCRWKv58X73P+_hKM8-_hkQ@mail.gmail.com>
Subject: Re: [PATCH v13 0/9] rutabaga_gfx + gfxstream
To: Huang Rui <ray.huang@amd.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, 
 "akihiko.odaki@gmail.com" <akihiko.odaki@gmail.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, 
 "shentey@gmail.com" <shentey@gmail.com>, "hi@alyssa.is" <hi@alyssa.is>, 
 "ernunes@redhat.com" <ernunes@redhat.com>, 
 "manos.pitsidianakis@linaro.org" <manos.pitsidianakis@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000310d5a0604a68dea"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=gurchetansingh@chromium.org; helo=mail-lj1-x22c.google.com
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

--000000000000310d5a0604a68dea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 7:26=E2=80=AFPM Huang Rui <ray.huang@amd.com> wrote=
:

> On Tue, Aug 29, 2023 at 08:36:20AM +0800, Gurchetan Singh wrote:
> > From: Gurchetan Singh <gurchetansingh@google.com>
> >
> > Changes since v12:
> > - Added r-b tags from Antonio Caggiano and Akihiko Odaki
> > - Removed review version from commit messages
> > - I think we're good to merge since we've had multiple people test and
> review this series??
> >
> > How to build both rutabaga and gfxstream guest/host libs:
> >
> > https://crosvm.dev/book/appendix/rutabaga_gfx.html
> >
> > Branch containing this patch series:
> >
> > https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v13
> >
> > Antonio Caggiano (2):
> >   virtio-gpu: CONTEXT_INIT feature
> >   virtio-gpu: blob prep
> >
> > Dr. David Alan Gilbert (1):
> >   virtio: Add shared memory capability
> >
> > Gerd Hoffmann (1):
> >   virtio-gpu: hostmem
>
> Patch 1 -> 4 are
>
> Acked-and-Tested-by: Huang Rui <ray.huang@amd.com>
>

Thanks Ray, I've rebased
https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v13 and
added the additional acks in the commit message.

UI/gfx maintainers, since everything is reviewed and there hasn't been any
additional review comments, may we merge the gfxstream + rutabaga_gfx
series?  Thank you!




>
> >
> > Gurchetan Singh (5):
> >   gfxstream + rutabaga prep: added need defintions, fields, and options
> >   gfxstream + rutabaga: add initial support for gfxstream
> >   gfxstream + rutabaga: meson support
> >   gfxstream + rutabaga: enable rutabaga
> >   docs/system: add basic virtio-gpu documentation
> >
> >  docs/system/device-emulation.rst     |    1 +
> >  docs/system/devices/virtio-gpu.rst   |  112 +++
> >  hw/display/meson.build               |   22 +
> >  hw/display/virtio-gpu-base.c         |    6 +-
> >  hw/display/virtio-gpu-pci-rutabaga.c |   47 ++
> >  hw/display/virtio-gpu-pci.c          |   14 +
> >  hw/display/virtio-gpu-rutabaga.c     | 1119 ++++++++++++++++++++++++++
> >  hw/display/virtio-gpu.c              |   16 +-
> >  hw/display/virtio-vga-rutabaga.c     |   50 ++
> >  hw/display/virtio-vga.c              |   33 +-
> >  hw/virtio/virtio-pci.c               |   18 +
> >  include/hw/virtio/virtio-gpu-bswap.h |   15 +
> >  include/hw/virtio/virtio-gpu.h       |   41 +
> >  include/hw/virtio/virtio-pci.h       |    4 +
> >  meson.build                          |    7 +
> >  meson_options.txt                    |    2 +
> >  scripts/meson-buildoptions.sh        |    3 +
> >  softmmu/qdev-monitor.c               |    3 +
> >  softmmu/vl.c                         |    1 +
> >  19 files changed, 1495 insertions(+), 19 deletions(-)
> >  create mode 100644 docs/system/devices/virtio-gpu.rst
> >  create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
> >  create mode 100644 hw/display/virtio-gpu-rutabaga.c
> >  create mode 100644 hw/display/virtio-vga-rutabaga.c
> >
> > --
> > 2.42.0.rc2.253.gd59a3bf2b4-goog
> >
>

--000000000000310d5a0604a68dea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 30, 2023 at 7:26=E2=80=AF=
PM Huang Rui &lt;<a href=3D"mailto:ray.huang@amd.com">ray.huang@amd.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On T=
ue, Aug 29, 2023 at 08:36:20AM +0800, Gurchetan Singh wrote:<br>
&gt; From: Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@google.com"=
 target=3D"_blank">gurchetansingh@google.com</a>&gt;<br>
&gt; <br>
&gt; Changes since v12:<br>
&gt; - Added r-b tags from Antonio Caggiano and Akihiko Odaki<br>
&gt; - Removed review version from commit messages<br>
&gt; - I think we&#39;re good to merge since we&#39;ve had multiple people =
test and review this series??<br>
&gt; <br>
&gt; How to build both rutabaga and gfxstream guest/host libs:<br>
&gt; <br>
&gt; <a href=3D"https://crosvm.dev/book/appendix/rutabaga_gfx.html" rel=3D"=
noreferrer" target=3D"_blank">https://crosvm.dev/book/appendix/rutabaga_gfx=
.html</a><br>
&gt; <br>
&gt; Branch containing this patch series:<br>
&gt; <br>
&gt; <a href=3D"https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxst=
ream-v13" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/gurchetan=
singh/qemu/-/commits/qemu-gfxstream-v13</a><br>
&gt; <br>
&gt; Antonio Caggiano (2):<br>
&gt;=C2=A0 =C2=A0virtio-gpu: CONTEXT_INIT feature<br>
&gt;=C2=A0 =C2=A0virtio-gpu: blob prep<br>
&gt; <br>
&gt; Dr. David Alan Gilbert (1):<br>
&gt;=C2=A0 =C2=A0virtio: Add shared memory capability<br>
&gt; <br>
&gt; Gerd Hoffmann (1):<br>
&gt;=C2=A0 =C2=A0virtio-gpu: hostmem<br>
<br>
Patch 1 -&gt; 4 are<br>
<br>
Acked-and-Tested-by: Huang Rui &lt;<a href=3D"mailto:ray.huang@amd.com" tar=
get=3D"_blank">ray.huang@amd.com</a>&gt;<br></blockquote><div><br></div><di=
v>Thanks Ray, I&#39;ve rebased=C2=A0<a href=3D"https://gitlab.com/gurchetan=
singh/qemu/-/commits/qemu-gfxstream-v13">https://gitlab.com/gurchetansingh/=
qemu/-/commits/qemu-gfxstream-v13</a> and added the additional acks in the =
commit message.</div><div><br></div><div>UI/gfx maintainers, since everythi=
ng is reviewed and there hasn&#39;t been any additional review comments, ma=
y we merge the gfxstream=C2=A0+ rutabaga_gfx series?=C2=A0 Thank you!</div>=
<div><br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
&gt; <br>
&gt; Gurchetan Singh (5):<br>
&gt;=C2=A0 =C2=A0gfxstream + rutabaga prep: added need defintions, fields, =
and options<br>
&gt;=C2=A0 =C2=A0gfxstream + rutabaga: add initial support for gfxstream<br=
>
&gt;=C2=A0 =C2=A0gfxstream + rutabaga: meson support<br>
&gt;=C2=A0 =C2=A0gfxstream + rutabaga: enable rutabaga<br>
&gt;=C2=A0 =C2=A0docs/system: add basic virtio-gpu documentation<br>
&gt; <br>
&gt;=C2=A0 docs/system/device-emulation.rst=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0 1 +<br>
&gt;=C2=A0 docs/system/devices/virtio-gpu.rst=C2=A0 =C2=A0|=C2=A0 112 +++<b=
r>
&gt;=C2=A0 hw/display/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A022 +<br>
&gt;=C2=A0 hw/display/virtio-gpu-base.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 6 +-<br>
&gt;=C2=A0 hw/display/virtio-gpu-pci-rutabaga.c |=C2=A0 =C2=A047 ++<br>
&gt;=C2=A0 hw/display/virtio-gpu-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A014 +<br>
&gt;=C2=A0 hw/display/virtio-gpu-rutabaga.c=C2=A0 =C2=A0 =C2=A0| 1119 +++++=
+++++++++++++++++++++<br>
&gt;=C2=A0 hw/display/virtio-gpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A016 +-<br>
&gt;=C2=A0 hw/display/virtio-vga-rutabaga.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A050 ++<br>
&gt;=C2=A0 hw/display/virtio-vga.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A033 +-<br>
&gt;=C2=A0 hw/virtio/virtio-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A018 +<br>
&gt;=C2=A0 include/hw/virtio/virtio-gpu-bswap.h |=C2=A0 =C2=A015 +<br>
&gt;=C2=A0 include/hw/virtio/virtio-gpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A041 +<br>
&gt;=C2=A0 include/hw/virtio/virtio-pci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A0 4 +<br>
&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 7 +<br>
&gt;=C2=A0 meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
&gt;=C2=A0 scripts/meson-buildoptions.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 =C2=A0 3 +<br>
&gt;=C2=A0 softmmu/qdev-monitor.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 3 +<br>
&gt;=C2=A0 softmmu/vl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1 +<br>
&gt;=C2=A0 19 files changed, 1495 insertions(+), 19 deletions(-)<br>
&gt;=C2=A0 create mode 100644 docs/system/devices/virtio-gpu.rst<br>
&gt;=C2=A0 create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c<br>
&gt;=C2=A0 create mode 100644 hw/display/virtio-gpu-rutabaga.c<br>
&gt;=C2=A0 create mode 100644 hw/display/virtio-vga-rutabaga.c<br>
&gt; <br>
&gt; -- <br>
&gt; 2.42.0.rc2.253.gd59a3bf2b4-goog<br>
&gt; <br>
</blockquote></div></div>

--000000000000310d5a0604a68dea--

