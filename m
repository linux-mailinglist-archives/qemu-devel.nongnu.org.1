Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEA6777FA3
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 19:55:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU9rd-0004nI-6o; Thu, 10 Aug 2023 13:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qU9rX-0004n7-N4
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:54:20 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qU9rV-0006vg-Ac
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:54:19 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-99cce6f7de2so170444566b.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 10:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1691690054; x=1692294854;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kiC+AdZKw56QpFeTtr12gCed9KwcNKMnpINP7NU4/l8=;
 b=ExujqNl/V6isPG8tw/bHVfCpL694a/qC7JxGr9vg8VWoDoJSvUdXSLGWANwNFKPWAP
 xZFmx4A73l6stUDl7Q8KYzeBiGJjqMKR40PtC6+yZjsY3YGYDuXb52XEaa6OgtDjlwP4
 No0qHlnQiZb+dcE7+bGNIIXo4ZaOvoOaSVGGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691690054; x=1692294854;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kiC+AdZKw56QpFeTtr12gCed9KwcNKMnpINP7NU4/l8=;
 b=je846Ue/KVoe1VO7wx5n1+eiI6wG0b27xFaCEhC2t57pmZ01VKvhxJMfb6acmuf30V
 MjZR/LbqPcA0BWkV6DpX0W0DgZe/hKanhcBTov94e6kv3FP7I6J/6zQ+31MCvA1qEdL1
 1d8CWtteyNPDO0WQpx4BU19Cc4GkWI8bjrNlguIU2rweJBpLFh3TDxkhdwwgoLi6V8dY
 CIkkIE3IVeHNZP74K0F34MREhDbGOTlcDAzgCBDkPZPTYIxAgo3kLqf+cuHbyFBHkxy3
 ri3lUr+TgkNljxasB4N2nmw7gc2oo69f8w+NSBe7+RkTHG+4jP3X1gZioWTY+XkNknNY
 pPog==
X-Gm-Message-State: AOJu0Yx1L4nPj5aRRgt932VEFDTP59FUXlFdNUro/D4otzfsoELQP1WA
 /xinHBJB3H8+VA9WlHX8Qmwb6hHRH1ts6AFMNDiQsA==
X-Google-Smtp-Source: AGHT+IFzEkmObCmqCzq5DKrEAh7OZI/VRWfVp2X8KLnXK33w9HDdvi0lnsruggN+tUTEVRE6UtoDWQ==
X-Received: by 2002:a17:906:109:b0:99b:efd3:3dcc with SMTP id
 9-20020a170906010900b0099befd33dccmr2605487eje.62.1691690054329; 
 Thu, 10 Aug 2023 10:54:14 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com.
 [209.85.208.53]) by smtp.gmail.com with ESMTPSA id
 qx22-20020a170906fcd600b0099cd008c1a4sm1227269ejb.136.2023.08.10.10.54.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 10:54:14 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-5232ce75e26so1453a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 10:54:13 -0700 (PDT)
X-Received: by 2002:a50:c30e:0:b0:523:193b:5587 with SMTP id
 a14-20020a50c30e000000b00523193b5587mr8264edb.6.1691690053240; Thu, 10 Aug
 2023 10:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230809021108.674-1-gurchetansingh@chromium.org>
 <20230809021108.674-10-gurchetansingh@chromium.org>
 <41d8c647-164a-46ce-aaee-f48bc5f4d752@gmail.com>
 <CAAfnVB=Dbi8SiX1ZgbMHb3udTNNMUxwf78pt9sXjMYftGLveng@mail.gmail.com>
 <3fd3467c-e6ea-4cce-9d08-3ad521f66848@gmail.com>
In-Reply-To: <3fd3467c-e6ea-4cce-9d08-3ad521f66848@gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 10 Aug 2023 10:54:00 -0700
X-Gmail-Original-Message-ID: <CAAfnVBkdmaKY9zDb+fp-NqxKGiuA5Z8m+gRX_tfissOA+W4mXA@mail.gmail.com>
Message-ID: <CAAfnVBkdmaKY9zDb+fp-NqxKGiuA5Z8m+gRX_tfissOA+W4mXA@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] docs/system: add basic virtio-gpu documentation
To: Akihiko Odaki <akihiko.odaki@gmail.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, kraxel@redhat.com, 
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is, 
 ernunes@redhat.com
Content-Type: multipart/alternative; boundary="000000000000b2609c0602954812"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ej1-x634.google.com
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

--000000000000b2609c0602954812
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 9, 2023 at 11:55=E2=80=AFPM Akihiko Odaki <akihiko.odaki@gmail.=
com>
wrote:

> On 2023/08/10 10:11, Gurchetan Singh wrote:
> >
> >
> > On Tue, Aug 8, 2023 at 10:18=E2=80=AFPM Akihiko Odaki <akihiko.odaki@gm=
ail.com
> > <mailto:akihiko.odaki@gmail.com>> wrote:
> >
> >     On 2023/08/09 11:11, Gurchetan Singh wrote:
> >      > This adds basic documentation for virtio-gpu.
> >      >
> >      > Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>
> >      > Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org
> >     <mailto:gurchetansingh@chromium.org>>
> >      > ---
> >      > v2: - Incorporated suggestions by Akihiko Odaki
> >      >      - Listed the currently supported capset_names (Bernard)
> >      >
> >      > v3: - Incorporated suggestions by Akihiko Odaki and Alyssa Ross
> >      >
> >      > v4: - Incorporated suggestions by Akihiko Odaki
> >      >
> >      >   docs/system/device-emulation.rst   |   1 +
> >      >   docs/system/devices/virtio-gpu.rst | 115
> >     +++++++++++++++++++++++++++++
> >      >   2 files changed, 116 insertions(+)
> >      >   create mode 100644 docs/system/devices/virtio-gpu.rst
> >      >
> >      > diff --git a/docs/system/device-emulation.rst
> >     b/docs/system/device-emulation.rst
> >      > index 4491c4cbf7..1167f3a9f2 100644
> >      > --- a/docs/system/device-emulation.rst
> >      > +++ b/docs/system/device-emulation.rst
> >      > @@ -91,6 +91,7 @@ Emulated Devices
> >      >      devices/nvme.rst
> >      >      devices/usb.rst
> >      >      devices/vhost-user.rst
> >      > +   devices/virtio-gpu.rst
> >      >      devices/virtio-pmem.rst
> >      >      devices/vhost-user-rng.rst
> >      >      devices/canokey.rst
> >      > diff --git a/docs/system/devices/virtio-gpu.rst
> >     b/docs/system/devices/virtio-gpu.rst
> >      > new file mode 100644
> >      > index 0000000000..d56524270d
> >      > --- /dev/null
> >      > +++ b/docs/system/devices/virtio-gpu.rst
> >      > @@ -0,0 +1,115 @@
> >      > +..
> >      > +   SPDX-License-Identifier: GPL-2.0
> >      > +
> >      > +virtio-gpu
> >      > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >      > +
> >      > +This document explains the setup and usage of the virtio-gpu
> device.
> >      > +The virtio-gpu device paravirtualizes the GPU and display
> >     controller.
> >      > +
> >      > +Linux kernel support
> >      > +--------------------
> >      > +
> >      > +virtio-gpu requires a guest Linux kernel built with the
> >      > +``CONFIG_DRM_VIRTIO_GPU`` option.
> >      > +
> >      > +QEMU virtio-gpu variants
> >      > +------------------------
> >      > +
> >      > +QEMU virtio-gpu device variants come in the following form:
> >      > +
> >      > + * ``virtio-vga[-BACKEND]``
> >      > + * ``virtio-gpu[-BACKEND][-INTERFACE]``
> >      > + * ``vhost-user-vga``
> >      > + * ``vhost-user-pci``
> >      > +
> >      > +**Backends:** QEMU provides a 2D virtio-gpu backend, and two
> >     accelerated
> >      > +backends: virglrenderer ('gl' device label) and rutabaga_gfx
> >     ('rutabaga'
> >      > +device label).  There is a vhost-user backend that runs the
> >     graphics stack
> >      > +in a separate process for improved isolation.
> >      > +
> >      > +**Interfaces:** QEMU further categorizes virtio-gpu device
> >     variants based
> >      > +on the interface exposed to the guest. The interfaces can be
> >     classified
> >      > +into VGA and non-VGA variants. The VGA ones are prefixed with
> >     virtio-vga
> >      > +or vhost-user-vga while the non-VGA ones are prefixed with
> >     virtio-gpu or
> >      > +vhost-user-gpu.
> >      > +
> >      > +The VGA ones always use the PCI interface, but for the non-VGA
> >     ones, the
> >      > +user can further pick between MMIO or PCI. For MMIO, the user
> >     can suffix
> >      > +the device name with -device, though vhost-user-gpu does not
> >     support MMIO.
> >      > +For PCI, the user can suffix it with -pci. Without these
> >     suffixes, the
> >      > +platform default will be chosen.
> >      > +
> >      > +This document uses the PCI interface in examples.
> >
> >     I think it's better to omit -pci.
> >
> >
> > Are you suggesting to use "-device virtio-gpu-rutabaga" or "-device
> > virtio-gpu-gl" in the examples?  Or "-device virtio-gpu-rutabaga-device=
"
> > or "-device virtio-gpu-gl-device"?  The former I believe wouldn't
> > launch, and the examples should ideally be directly applicable to a use=
r.
> >
> >
> >     By the way you are not adding the aliases for Rutabaga so please do
> so.
> >     You can find the table in: softmmu/qdev-monitor.c
> >
> >
> > I don't follow this comment.  Isn't "-device virtio-gpu-rutabaga-pci"
> > (along with "-device virtio-gpu-rutabaga-device") an alias for the
> > rutabaga device?  Where would the alias be placed in the doc (we don't
> > explicitly list aliases for other devices either), outside the
> > "..parsed-literal::" launch command?
>
> virtio-gpu-gl should work, and you need add an alias definition to get
> virtio-gpu-rutabaga work.
>

I see the problem: virtio-gpu-gl as a device works, but virtio-gpu-rutabaga
doesn't.  But the aliases for the gl device and rutabaga device are the
same in softmmu/qdev-monitor.c?

    { "virtio-gpu-gl-device", "virtio-gpu-gl", QEMU_ARCH_VIRTIO_MMIO },
    { "virtio-gpu-gl-pci", "virtio-gpu-gl", QEMU_ARCH_VIRTIO_PCI },
    { "virtio-gpu-rutabaga-device", "virtio-gpu-rutabaga",
      QEMU_ARCH_VIRTIO_MMIO },
    { "virtio-gpu-rutabaga-pci", "virtio-gpu-rutabaga",
QEMU_ARCH_VIRTIO_PCI },

What else needs to be added?


> Your documentation already says:
>  > Without these suffixes, the platform default will be chosen.
>
> You should confirm what you say in the documentation and fix the
> documentation or code if something is wrong.

--000000000000b2609c0602954812
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 9, 2023 at 11:55=E2=80=AF=
PM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@gmail.com">akihiko.oda=
ki@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">On 2023/08/10 10:11, Gurchetan Singh wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Tue, Aug 8, 2023 at 10:18=E2=80=AFPM Akihiko Odaki &lt;<a href=3D"m=
ailto:akihiko.odaki@gmail.com" target=3D"_blank">akihiko.odaki@gmail.com</a=
> <br>
&gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@gmail.com" target=3D"_blank=
">akihiko.odaki@gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2023/08/09 11:11, Gurchetan Singh wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; This adds basic documentation for virtio-gpu.=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Suggested-by: Akihiko Odaki &lt;<a href=3D"ma=
ilto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</=
a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Gurchetan Singh &lt;<a href=3D=
"mailto:gurchetansingh@chromium.org" target=3D"_blank">gurchetansingh@chrom=
ium.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:gurchetansingh@chromiu=
m.org" target=3D"_blank">gurchetansingh@chromium.org</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; v2: - Incorporated suggestions by Akihiko Oda=
ki<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 - Listed the currently su=
pported capset_names (Bernard)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; v3: - Incorporated suggestions by Akihiko Oda=
ki and Alyssa Ross<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; v4: - Incorporated suggestions by Akihiko Oda=
ki<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0docs/system/device-emulation.rst=
=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0docs/system/devices/virtio-gpu.rs=
t | 115<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A02 files changed, 116 insertions(+=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0create mode 100644 docs/system/de=
vices/virtio-gpu.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/docs/system/device-emulation.rst=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0b/docs/system/device-emulation.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 4491c4cbf7..1167f3a9f2 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/docs/system/device-emulation.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/docs/system/device-emulation.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -91,6 +91,7 @@ Emulated Devices<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 devices/nvme.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 devices/usb.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 devices/vhost-user.rst<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0devices/virtio-gpu.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 devices/virtio-pmem.rst<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 devices/vhost-user-rng.rs=
t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 devices/canokey.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/docs/system/devices/virtio-gpu.r=
st<br>
&gt;=C2=A0 =C2=A0 =C2=A0b/docs/system/devices/virtio-gpu.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 0000000000..d56524270d<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/docs/system/devices/virtio-gpu.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -0,0 +1,115 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +..<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0SPDX-License-Identifier: GPL-2.=
0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +virtio-gpu<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +This document explains the setup and usage o=
f the virtio-gpu device.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +The virtio-gpu device paravirtualizes the GP=
U and display<br>
&gt;=C2=A0 =C2=A0 =C2=A0controller.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +Linux kernel support<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +--------------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +virtio-gpu requires a guest Linux kernel bui=
lt with the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +``CONFIG_DRM_VIRTIO_GPU`` option.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +QEMU virtio-gpu variants<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +------------------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +QEMU virtio-gpu device variants come in the =
following form:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * ``virtio-vga[-BACKEND]``<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * ``virtio-gpu[-BACKEND][-INTERFACE]``<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * ``vhost-user-vga``<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * ``vhost-user-pci``<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +**Backends:** QEMU provides a 2D virtio-gpu =
backend, and two<br>
&gt;=C2=A0 =C2=A0 =C2=A0accelerated<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +backends: virglrenderer (&#39;gl&#39; device=
 label) and rutabaga_gfx<br>
&gt;=C2=A0 =C2=A0 =C2=A0(&#39;rutabaga&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +device label).=C2=A0 There is a vhost-user b=
ackend that runs the<br>
&gt;=C2=A0 =C2=A0 =C2=A0graphics stack<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +in a separate process for improved isolation=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +**Interfaces:** QEMU further categorizes vir=
tio-gpu device<br>
&gt;=C2=A0 =C2=A0 =C2=A0variants based<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +on the interface exposed to the guest. The i=
nterfaces can be<br>
&gt;=C2=A0 =C2=A0 =C2=A0classified<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +into VGA and non-VGA variants. The VGA ones =
are prefixed with<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio-vga<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +or vhost-user-vga while the non-VGA ones are=
 prefixed with<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio-gpu or<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +vhost-user-gpu.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +The VGA ones always use the PCI interface, b=
ut for the non-VGA<br>
&gt;=C2=A0 =C2=A0 =C2=A0ones, the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +user can further pick between MMIO or PCI. F=
or MMIO, the user<br>
&gt;=C2=A0 =C2=A0 =C2=A0can suffix<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +the device name with -device, though vhost-u=
ser-gpu does not<br>
&gt;=C2=A0 =C2=A0 =C2=A0support MMIO.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +For PCI, the user can suffix it with -pci. W=
ithout these<br>
&gt;=C2=A0 =C2=A0 =C2=A0suffixes, the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +platform default will be chosen.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +This document uses the PCI interface in exam=
ples.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I think it&#39;s better to omit -pci.<br>
&gt; <br>
&gt; <br>
&gt; Are you suggesting to use &quot;-device virtio-gpu-rutabaga&quot; or &=
quot;-device <br>
&gt; virtio-gpu-gl&quot; in the examples?=C2=A0 Or &quot;-device virtio-gpu=
-rutabaga-device&quot; <br>
&gt; or &quot;-device virtio-gpu-gl-device&quot;?=C2=A0 The former I believ=
e wouldn&#39;t <br>
&gt; launch, and the examples should ideally be directly applicable to a us=
er.<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0By the way you are not adding the aliases for Rutab=
aga so please do so.<br>
&gt;=C2=A0 =C2=A0 =C2=A0You can find the table in: softmmu/qdev-monitor.c<b=
r>
&gt; <br>
&gt; <br>
&gt; I don&#39;t follow this comment.=C2=A0 Isn&#39;t &quot;-device virtio-=
gpu-rutabaga-pci&quot; <br>
&gt; (along with &quot;-device virtio-gpu-rutabaga-device&quot;) an alias f=
or the <br>
&gt; rutabaga device?=C2=A0 Where would the alias be placed in the doc (we =
don&#39;t <br>
&gt; explicitly list aliases for other devices either), outside the <br>
&gt; &quot;..parsed-literal::&quot; launch command?<br>
<br>
virtio-gpu-gl should work, and you need add an alias definition to get <br>
virtio-gpu-rutabaga work.<br></blockquote><div><br></div><div>I see the pro=
blem: virtio-gpu-gl as a device works, but virtio-gpu-rutabaga doesn&#39;t.=
=C2=A0 But the aliases for the gl device and rutabaga device are the same i=
n softmmu/qdev-monitor.c?=C2=A0</div><div><br></div><div>=C2=A0 =C2=A0 { &q=
uot;virtio-gpu-gl-device&quot;, &quot;virtio-gpu-gl&quot;, QEMU_ARCH_VIRTIO=
_MMIO },<br>=C2=A0 =C2=A0 { &quot;virtio-gpu-gl-pci&quot;, &quot;virtio-gpu=
-gl&quot;, QEMU_ARCH_VIRTIO_PCI },<br>=C2=A0 =C2=A0 { &quot;virtio-gpu-ruta=
baga-device&quot;, &quot;virtio-gpu-rutabaga&quot;,<br>=C2=A0 =C2=A0 =C2=A0=
 QEMU_ARCH_VIRTIO_MMIO },<br>=C2=A0 =C2=A0 { &quot;virtio-gpu-rutabaga-pci&=
quot;, &quot;virtio-gpu-rutabaga&quot;, QEMU_ARCH_VIRTIO_PCI },<br></div><d=
iv><br></div><div>What else needs to be added?=C2=A0</div><div><br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Your documentation already says:<br>
=C2=A0&gt; Without these suffixes, the platform default will be chosen.<br>
<br>
You should confirm what you say in the documentation and fix the <br>
documentation or code if something is wrong.=C2=A0</blockquote></div></div>

--000000000000b2609c0602954812--

