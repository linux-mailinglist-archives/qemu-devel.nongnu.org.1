Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 541AE7801E9
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 01:48:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWmik-0003DA-Ju; Thu, 17 Aug 2023 19:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qWmii-0003Cy-RJ
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 19:48:04 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qWmif-0004AP-3R
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 19:48:04 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fe1489ced6so459825e87.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 16:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692316078; x=1692920878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/eCO6/dKOj8qjRyhAl78WCgFyK41kJuiPF9RSR63MOk=;
 b=oVr8Dk6eOXny3/V9Vc8HwHmSuJvQ5XC+KSgt9vSAPOalgwJwuXUV3f4Yy1Qga3LyJm
 9S4dmwyhf0Ant+1WZSKczPoPd6dCQ6yuBBXrBoUI1PDDUcKHVOMAfelch8IULVgN8zx2
 gmRgcRNqHRCGyrC0XtEk3Mraf57Hytnchv3UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692316078; x=1692920878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/eCO6/dKOj8qjRyhAl78WCgFyK41kJuiPF9RSR63MOk=;
 b=gyY8nQYlccBl+gqwyVJkLT/uXneAQQcKM43484TZWF6cBuM+paPgvP98JOL3maw/c2
 qCe/CPEXw7crq9WxbWt0dKXKaE2CNTdHSXValWleiRvG67hpvdVnC2E3ZL2nLpUjq1y/
 q9JxbNOYGOZnMf1XRjgGeznmx5buCY6hESlbqUobMSO8/dXSSW4khXJ1batys9t/BEO9
 mXn4tZTBIrWN/NPfTLb0muXAjoUYF9bFDy8IlMB1JiRdtE6oFPU974GERvk6XmBJ9MBu
 Rrg95OlhhuJlprvJz9/tP/VLol3alDtv3uv+TofCYSNCRZdBcELAOilpYT3rl+zo8VV3
 eVTA==
X-Gm-Message-State: AOJu0YxNXug0ecV/CA7Z2I/d4mGYxy3MaYOUjXCTRkESDkZjOtWDJ+R/
 tS1poU9tebbEpDlW6JSmv2fxm8G6xZaWEQV6G9S64Q==
X-Google-Smtp-Source: AGHT+IFXaVP/QFQ5a0JH611VT2YYHx1W9xUT68sEyz0pjLLwLco/hOOzlAxyfr2ayQ3G6ITRkM+9hw==
X-Received: by 2002:a19:ca4d:0:b0:4fb:8616:7a03 with SMTP id
 h13-20020a19ca4d000000b004fb86167a03mr480155lfj.4.1692316078096; 
 Thu, 17 Aug 2023 16:47:58 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com.
 [209.85.208.49]) by smtp.gmail.com with ESMTPSA id
 c22-20020aa7c756000000b00522572f323dsm377428eds.16.2023.08.17.16.47.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 16:47:57 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-5257d67368bso5118a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 16:47:57 -0700 (PDT)
X-Received: by 2002:a50:baa5:0:b0:523:d5bc:8424 with SMTP id
 x34-20020a50baa5000000b00523d5bc8424mr21511ede.5.1692316077507; Thu, 17 Aug
 2023 16:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230817022322.466-1-gurchetansingh@google.com>
 <20230817022322.466-10-gurchetansingh@google.com>
 <1281e8f6-f91a-4ced-b5d1-773370db3eef@gmail.com>
In-Reply-To: <1281e8f6-f91a-4ced-b5d1-773370db3eef@gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 17 Aug 2023 16:47:44 -0700
X-Gmail-Original-Message-ID: <CAAfnVBmmwWGTu0-6efVDqRRu9jvKmiboPzGtprm2h=U5XXj0Tw@mail.gmail.com>
Message-ID: <CAAfnVBmmwWGTu0-6efVDqRRu9jvKmiboPzGtprm2h=U5XXj0Tw@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] docs/system: add basic virtio-gpu documentation
To: Akihiko Odaki <akihiko.odaki@gmail.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, kraxel@redhat.com, 
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is, 
 ernunes@redhat.com, manos.pitsidianakis@linaro.org
Content-Type: multipart/alternative; boundary="000000000000a659000603270a99"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=gurchetansingh@chromium.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
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

--000000000000a659000603270a99
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 10:28=E2=80=AFPM Akihiko Odaki <akihiko.odaki@gmail=
.com>
wrote:

> On 2023/08/17 11:23, Gurchetan Singh wrote:
> > From: Gurchetan Singh <gurchetansingh@chromium.org>
> >
> > This adds basic documentation for virtio-gpu.
> >
> > Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> > Tested-by: Alyssa Ross <hi@alyssa.is>
> > Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> > Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> > v2: - Incorporated suggestions by Akihiko Odaki
> >      - Listed the currently supported capset_names (Bernard)
> >
> > v3: - Incorporated suggestions by Akihiko Odaki and Alyssa Ross
> >
> > v4: - Incorporated suggestions by Akihiko Odaki
> >
> > v5: - Removed pci suffix from examples
> >      - Verified that -device virtio-gpu-rutabaga works.  Strangely
> >        enough, I don't remember changing anything, and I remember
> >        it not working.  I did rebase to top of tree though.
> >      - Fixed meson examples in crosvm docs
> >
> >   docs/system/device-emulation.rst   |   1 +
> >   docs/system/devices/virtio-gpu.rst | 113 ++++++++++++++++++++++++++++=
+
> >   2 files changed, 114 insertions(+)
> >   create mode 100644 docs/system/devices/virtio-gpu.rst
> >
> > diff --git a/docs/system/device-emulation.rst
> b/docs/system/device-emulation.rst
> > index 4491c4cbf7..1167f3a9f2 100644
> > --- a/docs/system/device-emulation.rst
> > +++ b/docs/system/device-emulation.rst
> > @@ -91,6 +91,7 @@ Emulated Devices
> >      devices/nvme.rst
> >      devices/usb.rst
> >      devices/vhost-user.rst
> > +   devices/virtio-gpu.rst
> >      devices/virtio-pmem.rst
> >      devices/vhost-user-rng.rst
> >      devices/canokey.rst
> > diff --git a/docs/system/devices/virtio-gpu.rst
> b/docs/system/devices/virtio-gpu.rst
> > new file mode 100644
> > index 0000000000..8c5c708272
> > --- /dev/null
> > +++ b/docs/system/devices/virtio-gpu.rst
> > @@ -0,0 +1,113 @@
> > +..
> > +   SPDX-License-Identifier: GPL-2.0
> > +
> > +virtio-gpu
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This document explains the setup and usage of the virtio-gpu device.
> > +The virtio-gpu device paravirtualizes the GPU and display controller.
> > +
> > +Linux kernel support
> > +--------------------
> > +
> > +virtio-gpu requires a guest Linux kernel built with the
> > +``CONFIG_DRM_VIRTIO_GPU`` option.
> > +
> > +QEMU virtio-gpu variants
> > +------------------------
> > +
> > +QEMU virtio-gpu device variants come in the following form:
> > +
> > + * ``virtio-vga[-BACKEND]``
> > + * ``virtio-gpu[-BACKEND][-INTERFACE]``
> > + * ``vhost-user-vga``
> > + * ``vhost-user-pci``
> > +
> > +**Backends:** QEMU provides a 2D virtio-gpu backend, and two accelerat=
ed
> > +backends: virglrenderer ('gl' device label) and rutabaga_gfx ('rutabag=
a'
> > +device label).  There is a vhost-user backend that runs the graphics
> stack
> > +in a separate process for improved isolation.
> > +
> > +**Interfaces:** QEMU further categorizes virtio-gpu device variants
> based
> > +on the interface exposed to the guest. The interfaces can be classifie=
d
> > +into VGA and non-VGA variants. The VGA ones are prefixed with virtio-v=
ga
> > +or vhost-user-vga while the non-VGA ones are prefixed with virtio-gpu =
or
> > +vhost-user-gpu.
> > +
> > +The VGA ones always use the PCI interface, but for the non-VGA ones, t=
he
> > +user can further pick between MMIO or PCI. For MMIO, the user can suff=
ix
> > +the device name with -device, though vhost-user-gpu does not support
> MMIO.
> > +For PCI, the user can suffix it with -pci. Without these suffixes, the
> > +platform default will be chosen.
> > +
> > +virtio-gpu 2d
> > +-------------
> > +
> > +The default 2D backend only performs 2D operations. The guest needs to
> > +employ a software renderer for 3D graphics.
> > +
> > +Typically, the software renderer is provided by `Mesa`_ or
> `SwiftShader`_.
> > +Mesa's implementations (LLVMpipe, Lavapipe and virgl below) work out o=
f
> box
> > +on typical modern Linux distributions.
> > +
> > +.. parsed-literal::
> > +    -device virtio-gpu
> > +
> > +.. _Mesa: https://www.mesa3d.org/
> > +.. _SwiftShader: https://github.com/google/swiftshader
> > +
> > +virtio-gpu virglrenderer
> > +------------------------
> > +
> > +When using virgl accelerated graphics mode in the guest, OpenGL API
> calls
> > +are translated into an intermediate representation (see `Gallium3D`_).
> The
> > +intermediate representation is communicated to the host and the
> > +`virglrenderer`_ library on the host translates the intermediate
> > +representation back to OpenGL API calls.
> > +
> > +.. parsed-literal::
> > +    -device virtio-gpu-gl
> > +
> > +.. _Gallium3D: https://www.freedesktop.org/wiki/Software/gallium/
> > +.. _virglrenderer: https://gitlab.freedesktop.org/virgl/virglrenderer/
> > +
> > +virtio-gpu rutabaga
> > +-------------------
> > +
> > +virtio-gpu can also leverage `rutabaga_gfx`_ to provide `gfxstream`_
> > +rendering and `Wayland display passthrough`_.  With the gfxstream
> rendering
> > +mode, GLES and Vulkan calls are forwarded to the host with minimal
> > +modification.
> > +
> > +The crosvm book provides directions on how to build a `gfxstream-enabl=
ed
> > +rutabaga`_ and launch a `guest Wayland proxy`_.
> > +
> > +This device does require host blob support (``hostmem`` field below).
> The
> > +``hostmem`` field specifies the size of virtio-gpu host memory window.
> > +This is typically between 256M and 8G.
> > +
> > +At least one capset (see colon separated ``capset_names`` below) must =
be
> > +specified when starting the device.  The currently supported
> > +``capset_names`` are ``gfxstream-vulkan`` and ``cross-domain`` on Linu=
x
> > +guests. For Android guests, ``gfxstream-gles`` is also supported.
> > +
> > +The device will try to auto-detect the wayland socket path if the
> > +``cross-domain`` capset name is set.  The user may optionally specify
> > +``wayland_socket_path`` for non-standard paths.
> > +
> > +The ``wsi`` option can be set to ``surfaceless`` or ``headless``.
> > +Surfaceless doesn't create a native window surface, but does copy from
> the
> > +render target to the Pixman buffer if a virtio-gpu 2D hypercall is
> issued.
> > +Headless is like surfaceless, but doesn't copy to the Pixman buffer.
> > +Surfaceless is the default if ``wsi`` is not specified.
> > +
> > +.. parsed-literal::
> > +    -device
> virtio-gpu-rutabaga,capset_names=3Dgfxstream-vulkan:cross-domain,
> > +
>  hostmem=3D8G,wayland_socket_path=3D/tmp/nonstandard/mock_wayland.sock,
> > +       wsi=3Dheadless
> > +
> > +.. _rutabaga_gfx:
> https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/r=
utabaga_gfx_ffi.h
> > +.. _gfxstream:
> https://android.googlesource.com/platform/hardware/google/gfxstream/
> > +.. _Wayland display passthrough:
> https://www.youtube.com/watch?v=3DOZJiHMtIQ2M
> > +.. _gfxstream-enabled rutabaga:
> https://crosvm.dev/book/appendix/rutabaga_gfx.html
>
> You have different links for "rutabaga_gfx" and "gfxstream-enabled
> rutabaga", but I think you only need one.
>

Done.  Didn't resend the entire patch series (to avoid spamming list), just
did "in-reply-to".  The change is also available at:

https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qemu=
-gfxstream-v8


>
> > +.. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
>

--000000000000a659000603270a99
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 16, 2023 at 10:28=E2=80=
=AFPM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@gmail.com">akihiko.=
odaki@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On 2023/08/17 11:23, Gurchetan Singh wrote:<br>
&gt; From: Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@chromium.or=
g" target=3D"_blank">gurchetansingh@chromium.org</a>&gt;<br>
&gt; <br>
&gt; This adds basic documentation for virtio-gpu.<br>
&gt; <br>
&gt; Suggested-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix=
.com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
&gt; Signed-off-by: Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@ch=
romium.org" target=3D"_blank">gurchetansingh@chromium.org</a>&gt;<br>
&gt; Tested-by: Alyssa Ross &lt;<a href=3D"mailto:hi@alyssa.is" target=3D"_=
blank">hi@alyssa.is</a>&gt;<br>
&gt; Tested-by: Emmanouil Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidi=
anakis@linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;=
<br>
&gt; Reviewed-by: Emmanouil Pitsidianakis &lt;<a href=3D"mailto:manos.pitsi=
dianakis@linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&g=
t;<br>
&gt; ---<br>
&gt; v2: - Incorporated suggestions by Akihiko Odaki<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Listed the currently supported capset_names (Ber=
nard)<br>
&gt; <br>
&gt; v3: - Incorporated suggestions by Akihiko Odaki and Alyssa Ross<br>
&gt; <br>
&gt; v4: - Incorporated suggestions by Akihiko Odaki<br>
&gt; <br>
&gt; v5: - Removed pci suffix from examples<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Verified that -device virtio-gpu-rutabaga works.=
=C2=A0 Strangely<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 enough, I don&#39;t remember changing anyth=
ing, and I remember<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 it not working.=C2=A0 I did rebase to top o=
f tree though.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Fixed meson examples in crosvm docs<br>
&gt; <br>
&gt;=C2=A0 =C2=A0docs/system/device-emulation.rst=C2=A0 =C2=A0|=C2=A0 =C2=
=A01 +<br>
&gt;=C2=A0 =C2=A0docs/system/devices/virtio-gpu.rst | 113 +++++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A02 files changed, 114 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/system/devices/virtio-gpu.rst<br>
&gt; <br>
&gt; diff --git a/docs/system/device-emulation.rst b/docs/system/device-emu=
lation.rst<br>
&gt; index 4491c4cbf7..1167f3a9f2 100644<br>
&gt; --- a/docs/system/device-emulation.rst<br>
&gt; +++ b/docs/system/device-emulation.rst<br>
&gt; @@ -91,6 +91,7 @@ Emulated Devices<br>
&gt;=C2=A0 =C2=A0 =C2=A0 devices/nvme.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 devices/usb.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 devices/vhost-user.rst<br>
&gt; +=C2=A0 =C2=A0devices/virtio-gpu.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 devices/virtio-pmem.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 devices/vhost-user-rng.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 devices/canokey.rst<br>
&gt; diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/=
virtio-gpu.rst<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..8c5c708272<br>
&gt; --- /dev/null<br>
&gt; +++ b/docs/system/devices/virtio-gpu.rst<br>
&gt; @@ -0,0 +1,113 @@<br>
&gt; +..<br>
&gt; +=C2=A0 =C2=A0SPDX-License-Identifier: GPL-2.0<br>
&gt; +<br>
&gt; +virtio-gpu<br>
&gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; +<br>
&gt; +This document explains the setup and usage of the virtio-gpu device.<=
br>
&gt; +The virtio-gpu device paravirtualizes the GPU and display controller.=
<br>
&gt; +<br>
&gt; +Linux kernel support<br>
&gt; +--------------------<br>
&gt; +<br>
&gt; +virtio-gpu requires a guest Linux kernel built with the<br>
&gt; +``CONFIG_DRM_VIRTIO_GPU`` option.<br>
&gt; +<br>
&gt; +QEMU virtio-gpu variants<br>
&gt; +------------------------<br>
&gt; +<br>
&gt; +QEMU virtio-gpu device variants come in the following form:<br>
&gt; +<br>
&gt; + * ``virtio-vga[-BACKEND]``<br>
&gt; + * ``virtio-gpu[-BACKEND][-INTERFACE]``<br>
&gt; + * ``vhost-user-vga``<br>
&gt; + * ``vhost-user-pci``<br>
&gt; +<br>
&gt; +**Backends:** QEMU provides a 2D virtio-gpu backend, and two accelera=
ted<br>
&gt; +backends: virglrenderer (&#39;gl&#39; device label) and rutabaga_gfx =
(&#39;rutabaga&#39;<br>
&gt; +device label).=C2=A0 There is a vhost-user backend that runs the grap=
hics stack<br>
&gt; +in a separate process for improved isolation.<br>
&gt; +<br>
&gt; +**Interfaces:** QEMU further categorizes virtio-gpu device variants b=
ased<br>
&gt; +on the interface exposed to the guest. The interfaces can be classifi=
ed<br>
&gt; +into VGA and non-VGA variants. The VGA ones are prefixed with virtio-=
vga<br>
&gt; +or vhost-user-vga while the non-VGA ones are prefixed with virtio-gpu=
 or<br>
&gt; +vhost-user-gpu.<br>
&gt; +<br>
&gt; +The VGA ones always use the PCI interface, but for the non-VGA ones, =
the<br>
&gt; +user can further pick between MMIO or PCI. For MMIO, the user can suf=
fix<br>
&gt; +the device name with -device, though vhost-user-gpu does not support =
MMIO.<br>
&gt; +For PCI, the user can suffix it with -pci. Without these suffixes, th=
e<br>
&gt; +platform default will be chosen.<br>
&gt; +<br>
&gt; +virtio-gpu 2d<br>
&gt; +-------------<br>
&gt; +<br>
&gt; +The default 2D backend only performs 2D operations. The guest needs t=
o<br>
&gt; +employ a software renderer for 3D graphics.<br>
&gt; +<br>
&gt; +Typically, the software renderer is provided by `Mesa`_ or `SwiftShad=
er`_.<br>
&gt; +Mesa&#39;s implementations (LLVMpipe, Lavapipe and virgl below) work =
out of box<br>
&gt; +on typical modern Linux distributions.<br>
&gt; +<br>
&gt; +.. parsed-literal::<br>
&gt; +=C2=A0 =C2=A0 -device virtio-gpu<br>
&gt; +<br>
&gt; +.. _Mesa: <a href=3D"https://www.mesa3d.org/" rel=3D"noreferrer" targ=
et=3D"_blank">https://www.mesa3d.org/</a><br>
&gt; +.. _SwiftShader: <a href=3D"https://github.com/google/swiftshader" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/google/swiftshader</a=
><br>
&gt; +<br>
&gt; +virtio-gpu virglrenderer<br>
&gt; +------------------------<br>
&gt; +<br>
&gt; +When using virgl accelerated graphics mode in the guest, OpenGL API c=
alls<br>
&gt; +are translated into an intermediate representation (see `Gallium3D`_)=
. The<br>
&gt; +intermediate representation is communicated to the host and the<br>
&gt; +`virglrenderer`_ library on the host translates the intermediate<br>
&gt; +representation back to OpenGL API calls.<br>
&gt; +<br>
&gt; +.. parsed-literal::<br>
&gt; +=C2=A0 =C2=A0 -device virtio-gpu-gl<br>
&gt; +<br>
&gt; +.. _Gallium3D: <a href=3D"https://www.freedesktop.org/wiki/Software/g=
allium/" rel=3D"noreferrer" target=3D"_blank">https://www.freedesktop.org/w=
iki/Software/gallium/</a><br>
&gt; +.. _virglrenderer: <a href=3D"https://gitlab.freedesktop.org/virgl/vi=
rglrenderer/" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedeskt=
op.org/virgl/virglrenderer/</a><br>
&gt; +<br>
&gt; +virtio-gpu rutabaga<br>
&gt; +-------------------<br>
&gt; +<br>
&gt; +virtio-gpu can also leverage `rutabaga_gfx`_ to provide `gfxstream`_<=
br>
&gt; +rendering and `Wayland display passthrough`_.=C2=A0 With the gfxstrea=
m rendering<br>
&gt; +mode, GLES and Vulkan calls are forwarded to the host with minimal<br=
>
&gt; +modification.<br>
&gt; +<br>
&gt; +The crosvm book provides directions on how to build a `gfxstream-enab=
led<br>
&gt; +rutabaga`_ and launch a `guest Wayland proxy`_.<br>
&gt; +<br>
&gt; +This device does require host blob support (``hostmem`` field below).=
 The<br>
&gt; +``hostmem`` field specifies the size of virtio-gpu host memory window=
.<br>
&gt; +This is typically between 256M and 8G.<br>
&gt; +<br>
&gt; +At least one capset (see colon separated ``capset_names`` below) must=
 be<br>
&gt; +specified when starting the device.=C2=A0 The currently supported<br>
&gt; +``capset_names`` are ``gfxstream-vulkan`` and ``cross-domain`` on Lin=
ux<br>
&gt; +guests. For Android guests, ``gfxstream-gles`` is also supported.<br>
&gt; +<br>
&gt; +The device will try to auto-detect the wayland socket path if the<br>
&gt; +``cross-domain`` capset name is set.=C2=A0 The user may optionally sp=
ecify<br>
&gt; +``wayland_socket_path`` for non-standard paths.<br>
&gt; +<br>
&gt; +The ``wsi`` option can be set to ``surfaceless`` or ``headless``.<br>
&gt; +Surfaceless doesn&#39;t create a native window surface, but does copy=
 from the<br>
&gt; +render target to the Pixman buffer if a virtio-gpu 2D hypercall is is=
sued.<br>
&gt; +Headless is like surfaceless, but doesn&#39;t copy to the Pixman buff=
er.<br>
&gt; +Surfaceless is the default if ``wsi`` is not specified.<br>
&gt; +<br>
&gt; +.. parsed-literal::<br>
&gt; +=C2=A0 =C2=A0 -device virtio-gpu-rutabaga,capset_names=3Dgfxstream-vu=
lkan:cross-domain,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0hostmem=3D8G,wayland_socket_path=3D/tmp/no=
nstandard/mock_wayland.sock,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0wsi=3Dheadless<br>
&gt; +<br>
&gt; +.. _rutabaga_gfx: <a href=3D"https://github.com/google/crosvm/blob/ma=
in/rutabaga_gfx/ffi/src/include/rutabaga_gfx_ffi.h" rel=3D"noreferrer" targ=
et=3D"_blank">https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/s=
rc/include/rutabaga_gfx_ffi.h</a><br>
&gt; +.. _gfxstream: <a href=3D"https://android.googlesource.com/platform/h=
ardware/google/gfxstream/" rel=3D"noreferrer" target=3D"_blank">https://and=
roid.googlesource.com/platform/hardware/google/gfxstream/</a><br>
&gt; +.. _Wayland display passthrough: <a href=3D"https://www.youtube.com/w=
atch?v=3DOZJiHMtIQ2M" rel=3D"noreferrer" target=3D"_blank">https://www.yout=
ube.com/watch?v=3DOZJiHMtIQ2M</a><br>
&gt; +.. _gfxstream-enabled rutabaga: <a href=3D"https://crosvm.dev/book/ap=
pendix/rutabaga_gfx.html" rel=3D"noreferrer" target=3D"_blank">https://cros=
vm.dev/book/appendix/rutabaga_gfx.html</a><br>
<br>
You have different links for &quot;rutabaga_gfx&quot; and &quot;gfxstream-e=
nabled <br>
rutabaga&quot;, but I think you only need one.<br></blockquote><div><br></d=
iv><div>Done.=C2=A0 Didn&#39;t resend the entire patch series (to avoid spa=
mming list), just did &quot;in-reply-to&quot;.=C2=A0 The change is also ava=
ilable at:</div><div><br></div><div><a href=3D"https://gitlab.freedesktop.o=
rg/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstream-v8">https://gitla=
b.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstream-v8=
</a>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +.. _guest Wayland proxy: <a href=3D"https://crosvm.dev/book/devices/w=
ayland.html" rel=3D"noreferrer" target=3D"_blank">https://crosvm.dev/book/d=
evices/wayland.html</a><br>
</blockquote></div></div>

--000000000000a659000603270a99--

