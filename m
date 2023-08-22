Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF053783707
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 02:22:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYF8P-0003Sj-U3; Mon, 21 Aug 2023 20:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qYF8N-0003SQ-Me
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 20:20:35 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qYF8I-0005x4-1I
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 20:20:35 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99c1d03e124so490035966b.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 17:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692663627; x=1693268427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lY+mY0xZiaN0XWg5bds8Oa68VvRAuzvG8m4WE1JZTRg=;
 b=j3Dn/CeaWGusPEnvIbQdODLfdcpZO5pR8ql8X5FN6oEzdbrfF7EntmhfLF9SfaUKyv
 cyhQ/uk+mk1duS3GtL5PAsmiwk3tWJFZ1JT372k4aL5vaLGmi3yIk7gPbF2htLi3hGl3
 GCsEUDVrh2qOJsJuFwT95TKtlzKeJlzbhBQIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692663627; x=1693268427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lY+mY0xZiaN0XWg5bds8Oa68VvRAuzvG8m4WE1JZTRg=;
 b=HBhctLT38upHcqgpy1uwKFKdtkgBSiw+SQnjWn56TSOwghm6btnyTnJdSRpD1zcjR4
 pRefrKT8IQzKX2yOztlO13l4GCenbUN1AVuc60jn3hDddQaLByXNwvbJbKOU8Piar1Dn
 Vtaqd9HkFA4LCxQXLE4RnSaU1jKc+FwjCm+dI8eltub7iX+BSKpUr4qNa3zJvy7MatEW
 RR1Qau0iNW7/wheM21iSqkr35BRIYAep8BZdKi3BhbUNTtf9EJYrAE8KmMG2pRv7MYTj
 MsZ7wY6HoH+RnS3hreQ7bsyMKhFgVRzwNacetpWd7zmx4yZKHOoQDgGNy7dDYcFsKyee
 0vQA==
X-Gm-Message-State: AOJu0YwVrh00kU7+UqdPaUysP6iv143pwwG94YYVTRP7YH2MemdXvz5y
 vMKD9j/azIwojsFBzsq/rOjF+lwZHRZ1BNeLAkfOBw==
X-Google-Smtp-Source: AGHT+IFjSEjxgbcXMVR8Wm/JoDJZq2V+UcAqsznsUBRjEkrSSz+k3Dk/+0MsWGji7opQTF+WZymfAw==
X-Received: by 2002:a17:907:75e6:b0:994:5b1:6f92 with SMTP id
 jz6-20020a17090775e600b0099405b16f92mr5595821ejc.3.1692663627247; 
 Mon, 21 Aug 2023 17:20:27 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com.
 [209.85.208.41]) by smtp.gmail.com with ESMTPSA id
 sb25-20020a170906edd900b0098ec690e6d7sm7244617ejb.73.2023.08.21.17.20.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 17:20:26 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-5232ce75e26so2605a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 17:20:26 -0700 (PDT)
X-Received: by 2002:a50:9311:0:b0:519:7d2:e256 with SMTP id
 m17-20020a509311000000b0051907d2e256mr45737eda.0.1692663626525; Mon, 21 Aug
 2023 17:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230817022322.466-1-gurchetansingh@google.com>
 <20230817022322.466-10-gurchetansingh@google.com>
 <1281e8f6-f91a-4ced-b5d1-773370db3eef@gmail.com>
 <CAAfnVBmmwWGTu0-6efVDqRRu9jvKmiboPzGtprm2h=U5XXj0Tw@mail.gmail.com>
 <fcf79be7-5cf7-4c74-844c-9812f0b31f4a@gmail.com>
 <CAAfnVBmSXOxHqO+w59XY57DTfqEQwfVprSWXEbPEhP7eTrO0dA@mail.gmail.com>
 <5b5a8ee5-5938-4fbe-8fc7-9c30bb042da7@gmail.com>
In-Reply-To: <5b5a8ee5-5938-4fbe-8fc7-9c30bb042da7@gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Mon, 21 Aug 2023 17:20:12 -0700
X-Gmail-Original-Message-ID: <CAAfnVBmqP5VgSY7PhYXWiiTNE-+FBF7vXf2XfdxKqWjgU4RxOg@mail.gmail.com>
Message-ID: <CAAfnVBmqP5VgSY7PhYXWiiTNE-+FBF7vXf2XfdxKqWjgU4RxOg@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] docs/system: add basic virtio-gpu documentation
To: Akihiko Odaki <akihiko.odaki@gmail.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, kraxel@redhat.com, 
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is, 
 ernunes@redhat.com, manos.pitsidianakis@linaro.org
Content-Type: multipart/alternative; boundary="0000000000002f949c060377f6ae"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ej1-x629.google.com
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

--0000000000002f949c060377f6ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 11:13=E2=80=AFPM Akihiko Odaki <akihiko.odaki@gmail=
.com>
wrote:

> On 2023/08/19 10:17, Gurchetan Singh wrote:
> >
> >
> > On Fri, Aug 18, 2023 at 5:08=E2=80=AFAM Akihiko Odaki <akihiko.odaki@gm=
ail.com
> > <mailto:akihiko.odaki@gmail.com>> wrote:
> >
> >     On 2023/08/18 8:47, Gurchetan Singh wrote:
> >      >
> >      >
> >      > On Wed, Aug 16, 2023 at 10:28=E2=80=AFPM Akihiko Odaki
> >     <akihiko.odaki@gmail.com <mailto:akihiko.odaki@gmail.com>
> >      > <mailto:akihiko.odaki@gmail.com
> >     <mailto:akihiko.odaki@gmail.com>>> wrote:
> >      >
> >      >     On 2023/08/17 11:23, Gurchetan Singh wrote:
> >      >      > From: Gurchetan Singh <gurchetansingh@chromium.org
> >     <mailto:gurchetansingh@chromium.org>
> >      >     <mailto:gurchetansingh@chromium.org
> >     <mailto:gurchetansingh@chromium.org>>>
> >      >      >
> >      >      > This adds basic documentation for virtio-gpu.
> >      >      >
> >      >      > Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>
> >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>>
> >      >      > Signed-off-by: Gurchetan Singh
> >     <gurchetansingh@chromium.org <mailto:gurchetansingh@chromium.org>
> >      >     <mailto:gurchetansingh@chromium.org
> >     <mailto:gurchetansingh@chromium.org>>>
> >      >      > Tested-by: Alyssa Ross <hi@alyssa.is <mailto:hi@alyssa.is=
>
> >     <mailto:hi@alyssa.is <mailto:hi@alyssa.is>>>
> >      >      > Tested-by: Emmanouil Pitsidianakis
> >      >     <manos.pitsidianakis@linaro.org
> >     <mailto:manos.pitsidianakis@linaro.org>
> >     <mailto:manos.pitsidianakis@linaro.org
> >     <mailto:manos.pitsidianakis@linaro.org>>>
> >      >      > Reviewed-by: Emmanouil Pitsidianakis
> >      >     <manos.pitsidianakis@linaro.org
> >     <mailto:manos.pitsidianakis@linaro.org>
> >     <mailto:manos.pitsidianakis@linaro.org
> >     <mailto:manos.pitsidianakis@linaro.org>>>
> >      >      > ---
> >      >      > v2: - Incorporated suggestions by Akihiko Odaki
> >      >      >      - Listed the currently supported capset_names
> (Bernard)
> >      >      >
> >      >      > v3: - Incorporated suggestions by Akihiko Odaki and Alyss=
a
> >     Ross
> >      >      >
> >      >      > v4: - Incorporated suggestions by Akihiko Odaki
> >      >      >
> >      >      > v5: - Removed pci suffix from examples
> >      >      >      - Verified that -device virtio-gpu-rutabaga works.
> >     Strangely
> >      >      >        enough, I don't remember changing anything, and I
> >     remember
> >      >      >        it not working.  I did rebase to top of tree thoug=
h.
> >      >      >      - Fixed meson examples in crosvm docs
> >      >      >
> >      >      >   docs/system/device-emulation.rst   |   1 +
> >      >      >   docs/system/devices/virtio-gpu.rst | 113
> >      >     +++++++++++++++++++++++++++++
> >      >      >   2 files changed, 114 insertions(+)
> >      >      >   create mode 100644 docs/system/devices/virtio-gpu.rst
> >      >      >
> >      >      > diff --git a/docs/system/device-emulation.rst
> >      >     b/docs/system/device-emulation.rst
> >      >      > index 4491c4cbf7..1167f3a9f2 100644
> >      >      > --- a/docs/system/device-emulation.rst
> >      >      > +++ b/docs/system/device-emulation.rst
> >      >      > @@ -91,6 +91,7 @@ Emulated Devices
> >      >      >      devices/nvme.rst
> >      >      >      devices/usb.rst
> >      >      >      devices/vhost-user.rst
> >      >      > +   devices/virtio-gpu.rst
> >      >      >      devices/virtio-pmem.rst
> >      >      >      devices/vhost-user-rng.rst
> >      >      >      devices/canokey.rst
> >      >      > diff --git a/docs/system/devices/virtio-gpu.rst
> >      >     b/docs/system/devices/virtio-gpu.rst
> >      >      > new file mode 100644
> >      >      > index 0000000000..8c5c708272
> >      >      > --- /dev/null
> >      >      > +++ b/docs/system/devices/virtio-gpu.rst
> >      >      > @@ -0,0 +1,113 @@
> >      >      > +..
> >      >      > +   SPDX-License-Identifier: GPL-2.0
> >      >      > +
> >      >      > +virtio-gpu
> >      >      > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >      >      > +
> >      >      > +This document explains the setup and usage of the
> >     virtio-gpu device.
> >      >      > +The virtio-gpu device paravirtualizes the GPU and displa=
y
> >      >     controller.
> >      >      > +
> >      >      > +Linux kernel support
> >      >      > +--------------------
> >      >      > +
> >      >      > +virtio-gpu requires a guest Linux kernel built with the
> >      >      > +``CONFIG_DRM_VIRTIO_GPU`` option.
> >      >      > +
> >      >      > +QEMU virtio-gpu variants
> >      >      > +------------------------
> >      >      > +
> >      >      > +QEMU virtio-gpu device variants come in the following
> form:
> >      >      > +
> >      >      > + * ``virtio-vga[-BACKEND]``
> >      >      > + * ``virtio-gpu[-BACKEND][-INTERFACE]``
> >      >      > + * ``vhost-user-vga``
> >      >      > + * ``vhost-user-pci``
> >      >      > +
> >      >      > +**Backends:** QEMU provides a 2D virtio-gpu backend, and
> two
> >      >     accelerated
> >      >      > +backends: virglrenderer ('gl' device label) and
> rutabaga_gfx
> >      >     ('rutabaga'
> >      >      > +device label).  There is a vhost-user backend that runs
> the
> >      >     graphics stack
> >      >      > +in a separate process for improved isolation.
> >      >      > +
> >      >      > +**Interfaces:** QEMU further categorizes virtio-gpu devi=
ce
> >      >     variants based
> >      >      > +on the interface exposed to the guest. The interfaces ca=
n
> be
> >      >     classified
> >      >      > +into VGA and non-VGA variants. The VGA ones are prefixed
> with
> >      >     virtio-vga
> >      >      > +or vhost-user-vga while the non-VGA ones are prefixed wi=
th
> >      >     virtio-gpu or
> >      >      > +vhost-user-gpu.
> >      >      > +
> >      >      > +The VGA ones always use the PCI interface, but for the
> >     non-VGA
> >      >     ones, the
> >      >      > +user can further pick between MMIO or PCI. For MMIO, the
> user
> >      >     can suffix
> >      >      > +the device name with -device, though vhost-user-gpu does
> not
> >      >     support MMIO.
> >      >      > +For PCI, the user can suffix it with -pci. Without these
> >      >     suffixes, the
> >      >      > +platform default will be chosen.
> >      >      > +
> >      >      > +virtio-gpu 2d
> >      >      > +-------------
> >      >      > +
> >      >      > +The default 2D backend only performs 2D operations. The
> guest
> >      >     needs to
> >      >      > +employ a software renderer for 3D graphics.
> >      >      > +
> >      >      > +Typically, the software renderer is provided by `Mesa`_ =
or
> >      >     `SwiftShader`_.
> >      >      > +Mesa's implementations (LLVMpipe, Lavapipe and virgl
> >     below) work
> >      >     out of box
> >      >      > +on typical modern Linux distributions.
> >      >      > +
> >      >      > +.. parsed-literal::
> >      >      > +    -device virtio-gpu
> >      >      > +
> >      >      > +.. _Mesa: https://www.mesa3d.org/
> >     <https://www.mesa3d.org/> <https://www.mesa3d.org/
> >     <https://www.mesa3d.org/>>
> >      >      > +.. _SwiftShader: https://github.com/google/swiftshader
> >     <https://github.com/google/swiftshader>
> >      >     <https://github.com/google/swiftshader
> >     <https://github.com/google/swiftshader>>
> >      >      > +
> >      >      > +virtio-gpu virglrenderer
> >      >      > +------------------------
> >      >      > +
> >      >      > +When using virgl accelerated graphics mode in the guest,
> >     OpenGL
> >      >     API calls
> >      >      > +are translated into an intermediate representation (see
> >      >     `Gallium3D`_). The
> >      >      > +intermediate representation is communicated to the host
> >     and the
> >      >      > +`virglrenderer`_ library on the host translates the
> >     intermediate
> >      >      > +representation back to OpenGL API calls.
> >      >      > +
> >      >      > +.. parsed-literal::
> >      >      > +    -device virtio-gpu-gl
> >      >      > +
> >      >      > +.. _Gallium3D:
> >      > https://www.freedesktop.org/wiki/Software/gallium/
> >     <https://www.freedesktop.org/wiki/Software/gallium/>
> >      >     <https://www.freedesktop.org/wiki/Software/gallium/
> >     <https://www.freedesktop.org/wiki/Software/gallium/>>
> >      >      > +.. _virglrenderer:
> >      > https://gitlab.freedesktop.org/virgl/virglrenderer/
> >     <https://gitlab.freedesktop.org/virgl/virglrenderer/>
> >      >     <https://gitlab.freedesktop.org/virgl/virglrenderer/
> >     <https://gitlab.freedesktop.org/virgl/virglrenderer/>>
> >      >      > +
> >      >      > +virtio-gpu rutabaga
> >      >      > +-------------------
> >      >      > +
> >      >      > +virtio-gpu can also leverage `rutabaga_gfx`_ to provide
> >     `gfxstream`_
> >      >      > +rendering and `Wayland display passthrough`_.  With the
> >      >     gfxstream rendering
> >      >      > +mode, GLES and Vulkan calls are forwarded to the host
> >     with minimal
> >      >      > +modification.
> >      >      > +
> >      >      > +The crosvm book provides directions on how to build a
> >      >     `gfxstream-enabled
> >      >      > +rutabaga`_ and launch a `guest Wayland proxy`_.
> >      >      > +
> >      >      > +This device does require host blob support (``hostmem``
> field
> >      >     below). The
> >      >      > +``hostmem`` field specifies the size of virtio-gpu host
> >     memory
> >      >     window.
> >      >      > +This is typically between 256M and 8G.
> >      >      > +
> >      >      > +At least one capset (see colon separated ``capset_names`=
`
> >     below)
> >      >     must be
> >      >      > +specified when starting the device.  The currently
> supported
> >      >      > +``capset_names`` are ``gfxstream-vulkan`` and
> >     ``cross-domain``
> >      >     on Linux
> >      >      > +guests. For Android guests, ``gfxstream-gles`` is also
> >     supported.
> >      >      > +
> >      >      > +The device will try to auto-detect the wayland socket
> >     path if the
> >      >      > +``cross-domain`` capset name is set.  The user may
> optionally
> >      >     specify
> >      >      > +``wayland_socket_path`` for non-standard paths.
> >      >      > +
> >      >      > +The ``wsi`` option can be set to ``surfaceless`` or
> >     ``headless``.
> >      >      > +Surfaceless doesn't create a native window surface, but
> does
> >      >     copy from the
> >      >      > +render target to the Pixman buffer if a virtio-gpu 2D
> >     hypercall
> >      >     is issued.
> >      >      > +Headless is like surfaceless, but doesn't copy to the
> >     Pixman buffer.
> >      >      > +Surfaceless is the default if ``wsi`` is not specified.
> >      >      > +
> >      >      > +.. parsed-literal::
> >      >      > +    -device
> >      >
>  virtio-gpu-rutabaga,capset_names=3Dgfxstream-vulkan:cross-domain,
> >      >      > +
> >      >
> >       hostmem=3D8G,wayland_socket_path=3D/tmp/nonstandard/mock_wayland.=
sock,
> >      >      > +       wsi=3Dheadless
> >      >      > +
> >      >      > +.. _rutabaga_gfx:
> >      >
> >
> https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/r=
utabaga_gfx_ffi.h
> <
> https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/r=
utabaga_gfx_ffi.h>
> <
> https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/r=
utabaga_gfx_ffi.h
> <
> https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/r=
utabaga_gfx_ffi.h
> >>
> >      >      > +.. _gfxstream:
> >      >
> >     https://android.googlesource.com/platform/hardware/google/gfxstream=
/
> >     <
> https://android.googlesource.com/platform/hardware/google/gfxstream/>
> >      >
> >       <
> https://android.googlesource.com/platform/hardware/google/gfxstream/ <
> https://android.googlesource.com/platform/hardware/google/gfxstream/>>
> >      >      > +.. _Wayland display passthrough:
> >      > https://www.youtube.com/watch?v=3DOZJiHMtIQ2M
> >     <https://www.youtube.com/watch?v=3DOZJiHMtIQ2M>
> >      >     <https://www.youtube.com/watch?v=3DOZJiHMtIQ2M
> >     <https://www.youtube.com/watch?v=3DOZJiHMtIQ2M>>
> >      >      > +.. _gfxstream-enabled rutabaga:
> >      > https://crosvm.dev/book/appendix/rutabaga_gfx.html
> >     <https://crosvm.dev/book/appendix/rutabaga_gfx.html>
> >      >     <https://crosvm.dev/book/appendix/rutabaga_gfx.html
> >     <https://crosvm.dev/book/appendix/rutabaga_gfx.html>>
> >      >
> >      >     You have different links for "rutabaga_gfx" and
> >     "gfxstream-enabled
> >      >     rutabaga", but I think you only need one.
> >      >
> >      >
> >      > Done.  Didn't resend the entire patch series (to avoid spamming
> >     list),
> >      > just did "in-reply-to".  The change is also available at:
> >      >
> >      >
> >
> https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qe=
mu-gfxstream-v8
> <
> https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qe=
mu-gfxstream-v8>
> <
> https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qe=
mu-gfxstream-v8
> <
> https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qe=
mu-gfxstream-v8
> >>
> >
> >     The patch series now looks good so I finally decided to try this
> patch
> >     series, but I couldn't get it work.
> >
> >     I noticed gfxstream has page size hardcoded as 4 KiB, which broke m=
y
> >     setup on M2 MacBook Air (running Asahi Linux) that has 16 KiB page.
> You
> >     may add code to check host page size and to report an error if it's
> not
> >     4 KiB to virtio-gpu-rutabaga, but I think it's trivial to fix
> gfxstream
> >     to query page size at runtime as QEMU and Rutabaga does so I hope
> >     you to
> >     do so. For testing purpose, I have replaced it with 16 KiB on my
> setup.
> >
> >
> > Good catch, the fix to the 16KiB was merged today and is in gfxstream
> > ToT right now.
>
> The fix is incomplete. There are a few other places that hardcodes page
> size, namely ANDROID_EMU_ADDRESS_SPACE_DEFAULT_PAGE_SIZE and
> ADDRESS_SPACE_GRAPHICS_PAGE_SIZE.
>
> ANDROID_EMU_ADDRESS_SPACE_DEFAULT_PAGE_SIZE is used by no one so you can
> just remove it. ADDRESS_SPACE_GRAPHICS_PAGE_SIZE is actually in use and
> needs to be fixed.
>
> It's also better to remove PAGE_SIZE definition from guest/meson.build
> just in case.
>

ANDROID_EMU_ADDRESS_SPACE_DEFAULT_PAGE_SIZE and  PAGE_SIZE were removed
from gfxstream ToT.
The host alignment of the ring blob is also now based on getpagesize(..)
and not hardcoded.


> >
> >
> >     I also found some bugs on QEMU side so I added comments to respecti=
ve
> >     patches.
> >
> >     Below is the logs from my last attempt of running vkgears:
> >
> >     $ VK_LOADER_DEBUG=3Dall demos/build/src/vulkan/vkgears
> >     INFO:             Vulkan Loader Version 1.3.243
> >     LAYER:            Searching for layer manifest files
> >     LAYER:               In following locations:
> >     LAYER:
> /var/home/person/.config/vulkan/implicit_layer.d
> >     LAYER:                  /etc/xdg/vulkan/implicit_layer.d
> >     LAYER:                  /etc/vulkan/implicit_layer.d
> >     LAYER:
> >     /var/home/person/.local/share/vulkan/implicit_layer.d
> >     LAYER:
> >
>  /var/home/person/.local/share/flatpak/exports/share/vulkan/implicit_laye=
r.d
> >     LAYER:
> >     /var/lib/flatpak/exports/share/vulkan/implicit_layer.d
> >     LAYER:                  /usr/local/share/vulkan/implicit_layer.d
> >     LAYER:                  /usr/share/vulkan/implicit_layer.d
> >     LAYER:               Found the following files:
> >     LAYER:
> >     /usr/share/vulkan/implicit_layer.d/VkLayer_MESA_device_select.json
> >     INFO:             Found manifest file
> >     /usr/share/vulkan/implicit_layer.d/VkLayer_MESA_device_select.json
> >     (file
> >     version "1.0.0")
> >     LAYER:            Searching for layer manifest files
> >     LAYER:               In following locations:
> >     LAYER:
> /var/home/person/.config/vulkan/explicit_layer.d
> >     LAYER:                  /etc/xdg/vulkan/explicit_layer.d
> >     LAYER:                  /etc/vulkan/explicit_layer.d
> >     LAYER:
> >     /var/home/person/.local/share/vulkan/explicit_layer.d
> >     LAYER:
> >
>  /var/home/person/.local/share/flatpak/exports/share/vulkan/explicit_laye=
r.d
> >     LAYER:
> >     /var/lib/flatpak/exports/share/vulkan/explicit_layer.d
> >     LAYER:                  /usr/local/share/vulkan/explicit_layer.d
> >     LAYER:                  /usr/share/vulkan/explicit_layer.d
> >     LAYER:               Found no files
> >     DRIVER:           Searching for driver manifest files
> >     DRIVER:              In following locations:
> >     DRIVER:                 /var/home/person/.config/vulkan/icd.d
> >     DRIVER:                 /etc/xdg/vulkan/icd.d
> >     DRIVER:                 /etc/vulkan/icd.d
> >     DRIVER:                 /var/home/person/.local/share/vulkan/icd.d
> >     DRIVER:
> >     /var/home/person/.local/share/flatpak/exports/share/vulkan/icd.d
> >     DRIVER:                 /var/lib/flatpak/exports/share/vulkan/icd.d
> >     DRIVER:                 /usr/local/share/vulkan/icd.d
> >     DRIVER:                 /usr/share/vulkan/icd.d
> >     DRIVER:              Found the following files:
> >     DRIVER:
> >     /usr/local/share/vulkan/icd.d/cereal_icd.aarch64.json
> >     DRIVER:
> >       /usr/share/vulkan/icd.d/broadcom_icd.aarch64.json
> >     DRIVER:
> >       /usr/share/vulkan/icd.d/freedreno_icd.aarch64.json
> >     DRIVER:                 /usr/share/vulkan/icd.d/lvp_icd.aarch64.jso=
n
> >     DRIVER:
> >       /usr/share/vulkan/icd.d/panfrost_icd.aarch64.json
> >     DRIVER:
>  /usr/share/vulkan/icd.d/radeon_icd.aarch64.json
> >     DRIVER:           Found ICD manifest file
> >     /usr/local/share/vulkan/icd.d/cereal_icd.aarch64.json, version
> "1.0.0"
> >     DEBUG | DRIVER:   Searching for ICD drivers named
> >     /usr/local/lib64/libvulkan_cereal.so
> >     [VirtGpuDevice.cpp(71)]
> >     [prio 6] virtgpu backend not enabling
> >     VIRTGPU_PARAM_CREATE_GUEST_HANDLE[AndroidHealthMonitor.cpp(275)]
> >     [prio 4] HealthMonitor disabled. Returning nullptrI0818
> 21:00:07.980257
> >     154451 IntelDrmDecoder.cpp:38] IntelDrmDecoder created for context =
2
> >     DRIVER:           Found ICD manifest file
> >     /usr/share/vulkan/icd.d/broadcom_icd.aarch64.json, version "1.0.0"
> >     DEBUG | DRIVER:   Searching for ICD drivers named
> >     /usr/lib64/libvulkan_broadcom.so
> >     DRIVER:           Found ICD manifest file
> >     /usr/share/vulkan/icd.d/freedreno_icd.aarch64.json, version "1.0.0"
> >     DEBUG | DRIVER:   Searching for ICD drivers named
> >     /usr/lib64/libvulkan_freedreno.so
> >     DRIVER:           Found ICD manifest file
> >     /usr/share/vulkan/icd.d/lvp_icd.aarch64.json, version "1.0.0"
> >     DEBUG | DRIVER:   Searching for ICD drivers named
> >     /usr/lib64/libvulkan_lvp.so
> >     DRIVER:           Found ICD manifest file
> >     /usr/share/vulkan/icd.d/panfrost_icd.aarch64.json, version "1.0.0"
> >     DEBUG | DRIVER:   Searching for ICD drivers named
> >     /usr/lib64/libvulkan_panfrost.so
> >     DRIVER:           Found ICD manifest file
> >     /usr/share/vulkan/icd.d/radeon_icd.aarch64.json, version "1.0.0"
> >     DEBUG | DRIVER:   Searching for ICD drivers named
> >     /usr/lib64/libvulkan_radeon.so
> >     DEBUG | LAYER:    Loading layer library
> libVkLayer_MESA_device_select.so
> >     INFO | LAYER:     Insert instance layer "VK_LAYER_MESA_device_selec=
t"
> >     (libVkLayer_MESA_device_select.so)
> >     LAYER:            vkCreateInstance layer callstack setup to:
> >     LAYER:               <Application>
> >     LAYER:                 ||
> >     LAYER:               <Loader>
> >     LAYER:                 ||
> >     LAYER:               VK_LAYER_MESA_device_select
> >     LAYER:                       Type: Implicit
> >     LAYER:                           Disable Env Var:  NODEVICE_SELECT
> >     LAYER:                       Manifest:
> >     /usr/share/vulkan/implicit_layer.d/VkLayer_MESA_device_select.json
> >     LAYER:                       Library:
> libVkLayer_MESA_device_select.so
> >     LAYER:                 ||
> >     LAYER:               <Drivers>
> >     I0818 21:00:08.014896  154451 VkDecoderGlobalState.cpp:443] Creatin=
g
> >     Vulkan instance for app: vkgears
> >     INFO | DRIVER:    linux_read_sorted_physical_devices:
> >     INFO | DRIVER:         Original order:
> >     INFO | DRIVER:               [0] llvmpipe (LLVM 16.0.6, 128 bits)
> >     INFO | DRIVER:               [1] llvmpipe (LLVM 15.0.7, 128 bits)
> >     INFO | DRIVER:         Sorted order:
> >     INFO | DRIVER:               [0] llvmpipe (LLVM 15.0.7, 128 bits)
> >     INFO | DRIVER:               [1] llvmpipe (LLVM 16.0.6, 128 bits)
> >     INFO | DRIVER:    linux_read_sorted_physical_devices:
> >     INFO | DRIVER:         Original order:
> >     INFO | DRIVER:               [0] llvmpipe (LLVM 16.0.6, 128 bits)
> >     INFO | DRIVER:               [1] llvmpipe (LLVM 15.0.7, 128 bits)
> >     INFO | DRIVER:         Sorted order:
> >     INFO | DRIVER:               [0] llvmpipe (LLVM 15.0.7, 128 bits)
> >     INFO | DRIVER:               [1] llvmpipe (LLVM 16.0.6, 128 bits)
> >     DEBUG | DRIVER:   Copying old device 0 into new device 0
> >     DEBUG | DRIVER:   Copying old device 1 into new device 1
> >     INFO | DRIVER:    linux_read_sorted_physical_devices:
> >     INFO | DRIVER:         Original order:
> >     INFO | DRIVER:               [0] llvmpipe (LLVM 16.0.6, 128 bits)
> >     INFO | DRIVER:               [1] llvmpipe (LLVM 15.0.7, 128 bits)
> >     INFO | DRIVER:         Sorted order:
> >     INFO | DRIVER:               [0] llvmpipe (LLVM 15.0.7, 128 bits)
> >     INFO | DRIVER:               [1] llvmpipe (LLVM 16.0.6, 128 bits)
> >     DEBUG | DRIVER:   Copying old device 0 into new device 0
> >     DEBUG | DRIVER:   Copying old device 1 into new device 1
> >     INFO | DRIVER:    linux_read_sorted_physical_devices:
> >     INFO | DRIVER:         Original order:
> >     INFO | DRIVER:               [0] llvmpipe (LLVM 16.0.6, 128 bits)
> >     INFO | DRIVER:               [1] llvmpipe (LLVM 15.0.7, 128 bits)
> >     INFO | DRIVER:         Sorted order:
> >     INFO | DRIVER:               [0] llvmpipe (LLVM 15.0.7, 128 bits)
> >     INFO | DRIVER:               [1] llvmpipe (LLVM 16.0.6, 128 bits)
> >     DEBUG | DRIVER:   Copying old device 0 into new device 0
> >     DEBUG | DRIVER:   Copying old device 1 into new device 1
> >     ERROR:            loader_validate_device_extensions: Device extensi=
on
> >     VK_KHR_swapchain not supported by selected physical device or enabl=
ed
> >
> >
> > Yeah, any non-headless Linux tests are unlikely to work.  Maybe in a
> > future gfxstream release, since our focus is of course on Android and
> > getting Vulkan in QEMU in general.
>
> I have just tried "vulkan-samples sample hello_triangle --headless" but
> no luck. Below is the output of QEMU with -trace virtio_gpu_cmd_*
>

I have slightly different behavior on my setup, the app fails to find the
proper surface extensions and exits.   In headless mode, the app relies
on VK_EXT_headless_surface, which gfxstream does not currently support
(see on_vkEnumerateInstanceExtensionProperties).  For some reason, perhaps
due the presence of other VK drivers on the system, vulkaninfo does report
several X11/Wayland surface extensions with gfxstream.  This may confuse
some headless apps.

Either way, the crosvm docs will be clarified to mention what's been tested
regarding gfxstream guest Linux (crrev.com/c/4800334).  I suggest you run
deqp-vk if your goal is to test this patch series.


>
> virtio_gpu_cmd_ctx_create ctx 0x2, name vulkan_samples
> virtio_gpu_cmd_res_create_blob res 0x24, size 1064960
> virtio_gpu_cmd_ctx_res_attach ctx 0x2, res 0x24
> virtio_gpu_cmd_ctx_submit ctx 0x2, size 8
> I0819 15:10:06.916033   21850 IntelDrmDecoder.cpp:38] IntelDrmDecoder
> created for context 2
> virtio_gpu_cmd_ctx_submit ctx 0x2, size 8
> virtio_gpu_cmd_ctx_submit ctx 0x2, size 8
> W0819 15:10:06.916443   21850 VkDecoder.cpp:137] Bad packet length 0
> detected, decode may fail
> virtio_gpu_cmd_ctx_submit ctx 0x2, size 8
> W0819 15:10:06.916465   21850 VkDecoder.cpp:137] Bad packet length 0
> detected, decode may fail
> W0819 15:10:06.916473   21850 VkDecoder.cpp:137] Bad packet length 0
> detected, decode may fail
> W0819 15:10:06.916478   21850 VkDecoder.cpp:137] Bad packet length 0
> detected, decode may fail
> W0819 15:10:06.916482   21850 VkDecoder.cpp:137] Bad packet length 0
> detected, decode may fail
>
> And it endlessly outputs "Bad packet length" error messages.
>

--0000000000002f949c060377f6ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 18, 2023 at 11:13=E2=80=
=AFPM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@gmail.com" target=
=3D"_blank">akihiko.odaki@gmail.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On 2023/08/19 10:17, Gurchetan Singh wro=
te:<br>
&gt; <br>
&gt; <br>
&gt; On Fri, Aug 18, 2023 at 5:08=E2=80=AFAM Akihiko Odaki &lt;<a href=3D"m=
ailto:akihiko.odaki@gmail.com" target=3D"_blank">akihiko.odaki@gmail.com</a=
> <br>
&gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@gmail.com" target=3D"_blank=
">akihiko.odaki@gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2023/08/18 8:47, Gurchetan Singh wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Wed, Aug 16, 2023 at 10:28=E2=80=AFPM Akih=
iko Odaki<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:akihiko.odaki@gmail.com" targ=
et=3D"_blank">akihiko.odaki@gmail.com</a> &lt;mailto:<a href=3D"mailto:akih=
iko.odaki@gmail.com" target=3D"_blank">akihiko.odaki@gmail.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@gm=
ail.com" target=3D"_blank">akihiko.odaki@gmail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@gmail.co=
m" target=3D"_blank">akihiko.odaki@gmail.com</a>&gt;&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0On 2023/08/17 11:23, Gurch=
etan Singh wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; From: Gurchetan Sing=
h &lt;<a href=3D"mailto:gurchetansingh@chromium.org" target=3D"_blank">gurc=
hetansingh@chromium.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:gurchetansingh@chromiu=
m.org" target=3D"_blank">gurchetansingh@chromium.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:gurchetansingh@chromium.org" target=3D"_blank">gurchetansingh@chromium.o=
rg</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:gurchetansingh@chromiu=
m.org" target=3D"_blank">gurchetansingh@chromium.org</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; This adds basic docu=
mentation for virtio-gpu.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Suggested-by: Akihik=
o Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blank">a=
kihiko.odaki@daynix.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Gurch=
etan Singh<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:gurchetansingh@chromium.org" =
target=3D"_blank">gurchetansingh@chromium.org</a> &lt;mailto:<a href=3D"mai=
lto:gurchetansingh@chromium.org" target=3D"_blank">gurchetansingh@chromium.=
org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:gurchetansingh@chromium.org" target=3D"_blank">gurchetansingh@chromium.o=
rg</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:gurchetansingh@chromiu=
m.org" target=3D"_blank">gurchetansingh@chromium.org</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Tested-by: Alyssa Ro=
ss &lt;<a href=3D"mailto:hi@alyssa.is" target=3D"_blank">hi@alyssa.is</a> &=
lt;mailto:<a href=3D"mailto:hi@alyssa.is" target=3D"_blank">hi@alyssa.is</a=
>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:hi@alyssa.is" target=
=3D"_blank">hi@alyssa.is</a> &lt;mailto:<a href=3D"mailto:hi@alyssa.is" tar=
get=3D"_blank">hi@alyssa.is</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Tested-by: Emmanouil=
 Pitsidianakis<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:mano=
s.pitsidianakis@linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.or=
g</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:manos.pitsidianakis@li=
naro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:manos.pitsidianakis@li=
naro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:manos.pitsidianakis@li=
naro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;&gt;&gt;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Reviewed-by: Emmanou=
il Pitsidianakis<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:mano=
s.pitsidianakis@linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.or=
g</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:manos.pitsidianakis@li=
naro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:manos.pitsidianakis@li=
naro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:manos.pitsidianakis@li=
naro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;&gt;&gt;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; v2: - Incorporated s=
uggestions by Akihiko Odaki<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
- Listed the currently supported capset_names (Bernard)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; v3: - Incorporated s=
uggestions by Akihiko Odaki and Alyssa<br>
&gt;=C2=A0 =C2=A0 =C2=A0Ross<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; v4: - Incorporated s=
uggestions by Akihiko Odaki<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; v5: - Removed pci su=
ffix from examples<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
- Verified that -device virtio-gpu-rutabaga works. <br>
&gt;=C2=A0 =C2=A0 =C2=A0Strangely<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 enough, I don&#39;t remember changing anything, and I<br>
&gt;=C2=A0 =C2=A0 =C2=A0remember<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 it not working.=C2=A0 I did rebase to top of tree though.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
- Fixed meson examples in crosvm docs<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0docs/sys=
tem/device-emulation.rst=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0docs/sys=
tem/devices/virtio-gpu.rst | 113<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0++++++++++++++++++++++++++=
+++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A02 files =
changed, 114 insertions(+)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0create m=
ode 100644 docs/system/devices/virtio-gpu.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/docs/sy=
stem/device-emulation.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0b/docs/system/device-emula=
tion.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 4491c4cbf7..11=
67f3a9f2 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/docs/system/de=
vice-emulation.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/docs/system/de=
vice-emulation.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -91,6 +91,7 @@ Em=
ulated Devices<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
devices/nvme.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
devices/usb.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
devices/vhost-user.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0device=
s/virtio-gpu.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
devices/virtio-pmem.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
devices/vhost-user-rng.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
devices/canokey.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/docs/sy=
stem/devices/virtio-gpu.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0b/docs/system/devices/virt=
io-gpu.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; new file mode 100644=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 0000000000..8c=
5c708272<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/docs/system/de=
vices/virtio-gpu.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -0,0 +1,113 @@<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +..<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0SPDX-L=
icense-Identifier: GPL-2.0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +virtio-gpu<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +This document expla=
ins the setup and usage of the<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio-gpu device.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +The virtio-gpu devi=
ce paravirtualizes the GPU and display<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0controller.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +Linux kernel suppor=
t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +-------------------=
-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +virtio-gpu requires=
 a guest Linux kernel built with the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +``CONFIG_DRM_VIRTIO=
_GPU`` option.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +QEMU virtio-gpu var=
iants<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +-------------------=
-----<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +QEMU virtio-gpu dev=
ice variants come in the following form:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * ``virtio-vga[-BA=
CKEND]``<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * ``virtio-gpu[-BA=
CKEND][-INTERFACE]``<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * ``vhost-user-vga=
``<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * ``vhost-user-pci=
``<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +**Backends:** QEMU =
provides a 2D virtio-gpu backend, and two<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0accelerated<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +backends: virglrend=
erer (&#39;gl&#39; device label) and rutabaga_gfx<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0(&#39;rutabaga&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +device label).=C2=
=A0 There is a vhost-user backend that runs the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0graphics stack<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +in a separate proce=
ss for improved isolation.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +**Interfaces:** QEM=
U further categorizes virtio-gpu device<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0variants based<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +on the interface ex=
posed to the guest. The interfaces can be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0classified<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +into VGA and non-VG=
A variants. The VGA ones are prefixed with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0virtio-vga<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +or vhost-user-vga w=
hile the non-VGA ones are prefixed with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0virtio-gpu or<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +vhost-user-gpu.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +The VGA ones always=
 use the PCI interface, but for the<br>
&gt;=C2=A0 =C2=A0 =C2=A0non-VGA<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0ones, the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +user can further pi=
ck between MMIO or PCI. For MMIO, the user<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0can suffix<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +the device name wit=
h -device, though vhost-user-gpu does not<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0support MMIO.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +For PCI, the user c=
an suffix it with -pci. Without these<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0suffixes, the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +platform default wi=
ll be chosen.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +virtio-gpu 2d<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +-------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +The default 2D back=
end only performs 2D operations. The guest<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0needs to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +employ a software r=
enderer for 3D graphics.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +Typically, the soft=
ware renderer is provided by `Mesa`_ or<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0`SwiftShader`_.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +Mesa&#39;s implemen=
tations (LLVMpipe, Lavapipe and virgl<br>
&gt;=C2=A0 =C2=A0 =C2=A0below) work<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0out of box<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +on typical modern L=
inux distributions.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. parsed-literal::=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 -devi=
ce virtio-gpu<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. _Mesa: <a href=
=3D"https://www.mesa3d.org/" rel=3D"noreferrer" target=3D"_blank">https://w=
ww.mesa3d.org/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://www.mesa3d.org/" rel=3D"nore=
ferrer" target=3D"_blank">https://www.mesa3d.org/</a>&gt; &lt;<a href=3D"ht=
tps://www.mesa3d.org/" rel=3D"noreferrer" target=3D"_blank">https://www.mes=
a3d.org/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://www.mesa3d.org/" rel=3D"nore=
ferrer" target=3D"_blank">https://www.mesa3d.org/</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. _SwiftShader: <a=
 href=3D"https://github.com/google/swiftshader" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/google/swiftshader</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://github.com/google/swiftshade=
r" rel=3D"noreferrer" target=3D"_blank">https://github.com/google/swiftshad=
er</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://git=
hub.com/google/swiftshader" rel=3D"noreferrer" target=3D"_blank">https://gi=
thub.com/google/swiftshader</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://github.com/google/swiftshade=
r" rel=3D"noreferrer" target=3D"_blank">https://github.com/google/swiftshad=
er</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +virtio-gpu virglren=
derer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +-------------------=
-----<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +When using virgl ac=
celerated graphics mode in the guest,<br>
&gt;=C2=A0 =C2=A0 =C2=A0OpenGL<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0API calls<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +are translated into=
 an intermediate representation (see<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0`Gallium3D`_). The<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +intermediate repres=
entation is communicated to the host<br>
&gt;=C2=A0 =C2=A0 =C2=A0and the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +`virglrenderer`_ li=
brary on the host translates the<br>
&gt;=C2=A0 =C2=A0 =C2=A0intermediate<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +representation back=
 to OpenGL API calls.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. parsed-literal::=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 -devi=
ce virtio-gpu-gl<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. _Gallium3D:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"https://www.freedesktop.org/wiki/S=
oftware/gallium/" rel=3D"noreferrer" target=3D"_blank">https://www.freedesk=
top.org/wiki/Software/gallium/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://www.freedesktop.org/wiki/Sof=
tware/gallium/" rel=3D"noreferrer" target=3D"_blank">https://www.freedeskto=
p.org/wiki/Software/gallium/</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://www=
.freedesktop.org/wiki/Software/gallium/" rel=3D"noreferrer" target=3D"_blan=
k">https://www.freedesktop.org/wiki/Software/gallium/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://www.freedesktop.org/wiki/Sof=
tware/gallium/" rel=3D"noreferrer" target=3D"_blank">https://www.freedeskto=
p.org/wiki/Software/gallium/</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. _virglrenderer:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"https://gitlab.freedesktop.org/vir=
gl/virglrenderer/" rel=3D"noreferrer" target=3D"_blank">https://gitlab.free=
desktop.org/virgl/virglrenderer/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://gitlab.freedesktop.org/virgl=
/virglrenderer/" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freede=
sktop.org/virgl/virglrenderer/</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://git=
lab.freedesktop.org/virgl/virglrenderer/" rel=3D"noreferrer" target=3D"_bla=
nk">https://gitlab.freedesktop.org/virgl/virglrenderer/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://gitlab.freedesktop.org/virgl=
/virglrenderer/" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freede=
sktop.org/virgl/virglrenderer/</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +virtio-gpu rutabaga=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +-------------------=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +virtio-gpu can also=
 leverage `rutabaga_gfx`_ to provide<br>
&gt;=C2=A0 =C2=A0 =C2=A0`gfxstream`_<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +rendering and `Wayl=
and display passthrough`_.=C2=A0 With the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0gfxstream rendering<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +mode, GLES and Vulk=
an calls are forwarded to the host<br>
&gt;=C2=A0 =C2=A0 =C2=A0with minimal<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +modification.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +The crosvm book pro=
vides directions on how to build a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0`gfxstream-enabled<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +rutabaga`_ and laun=
ch a `guest Wayland proxy`_.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +This device does re=
quire host blob support (``hostmem`` field<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0below). The<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +``hostmem`` field s=
pecifies the size of virtio-gpu host<br>
&gt;=C2=A0 =C2=A0 =C2=A0memory<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0window.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +This is typically b=
etween 256M and 8G.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +At least one capset=
 (see colon separated ``capset_names``<br>
&gt;=C2=A0 =C2=A0 =C2=A0below)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0must be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +specified when star=
ting the device.=C2=A0 The currently supported<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +``capset_names`` ar=
e ``gfxstream-vulkan`` and<br>
&gt;=C2=A0 =C2=A0 =C2=A0``cross-domain``<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0on Linux<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +guests. For Android=
 guests, ``gfxstream-gles`` is also<br>
&gt;=C2=A0 =C2=A0 =C2=A0supported.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +The device will try=
 to auto-detect the wayland socket<br>
&gt;=C2=A0 =C2=A0 =C2=A0path if the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +``cross-domain`` ca=
pset name is set.=C2=A0 The user may optionally<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0specify<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +``wayland_socket_pa=
th`` for non-standard paths.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +The ``wsi`` option =
can be set to ``surfaceless`` or<br>
&gt;=C2=A0 =C2=A0 =C2=A0``headless``.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +Surfaceless doesn&#=
39;t create a native window surface, but does<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0copy from the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +render target to th=
e Pixman buffer if a virtio-gpu 2D<br>
&gt;=C2=A0 =C2=A0 =C2=A0hypercall<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0is issued.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +Headless is like su=
rfaceless, but doesn&#39;t copy to the<br>
&gt;=C2=A0 =C2=A0 =C2=A0Pixman buffer.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +Surfaceless is the =
default if ``wsi`` is not specified.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. parsed-literal::=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 -devi=
ce<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0virtio-gpu-rutabaga,capset=
_names=3Dgfxstream-vulkan:cross-domain,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hostmem=3D8G,wayland_socket_path=3D/tmp/nons=
tandard/mock_wayland.sock,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0wsi=3Dheadless<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. _rutabaga_gfx:<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://github.com/google/crosvm/blob/ma=
in/rutabaga_gfx/ffi/src/include/rutabaga_gfx_ffi.h" rel=3D"noreferrer" targ=
et=3D"_blank">https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/s=
rc/include/rutabaga_gfx_ffi.h</a> &lt;<a href=3D"https://github.com/google/=
crosvm/blob/main/rutabaga_gfx/ffi/src/include/rutabaga_gfx_ffi.h" rel=3D"no=
referrer" target=3D"_blank">https://github.com/google/crosvm/blob/main/ruta=
baga_gfx/ffi/src/include/rutabaga_gfx_ffi.h</a>&gt; &lt;<a href=3D"https://=
github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/rutabaga_gf=
x_ffi.h" rel=3D"noreferrer" target=3D"_blank">https://github.com/google/cro=
svm/blob/main/rutabaga_gfx/ffi/src/include/rutabaga_gfx_ffi.h</a> &lt;<a hr=
ef=3D"https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/inclu=
de/rutabaga_gfx_ffi.h" rel=3D"noreferrer" target=3D"_blank">https://github.=
com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/rutabaga_gfx_ffi.h=
</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. _gfxstream:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://android.googlesource.com/platfor=
m/hardware/google/gfxstream/" rel=3D"noreferrer" target=3D"_blank">https://=
android.googlesource.com/platform/hardware/google/gfxstream/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://android.googlesource.com/pla=
tform/hardware/google/gfxstream/" rel=3D"noreferrer" target=3D"_blank">http=
s://android.googlesource.com/platform/hardware/google/gfxstream/</a>&gt;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://android.googlesource.=
com/platform/hardware/google/gfxstream/" rel=3D"noreferrer" target=3D"_blan=
k">https://android.googlesource.com/platform/hardware/google/gfxstream/</a>=
 &lt;<a href=3D"https://android.googlesource.com/platform/hardware/google/g=
fxstream/" rel=3D"noreferrer" target=3D"_blank">https://android.googlesourc=
e.com/platform/hardware/google/gfxstream/</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. _Wayland display=
 passthrough:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"https://www.youtube.com/watch?v=3D=
OZJiHMtIQ2M" rel=3D"noreferrer" target=3D"_blank">https://www.youtube.com/w=
atch?v=3DOZJiHMtIQ2M</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://www.youtube.com/watch?v=3DOZ=
JiHMtIQ2M" rel=3D"noreferrer" target=3D"_blank">https://www.youtube.com/wat=
ch?v=3DOZJiHMtIQ2M</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://www=
.youtube.com/watch?v=3DOZJiHMtIQ2M" rel=3D"noreferrer" target=3D"_blank">ht=
tps://www.youtube.com/watch?v=3DOZJiHMtIQ2M</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://www.youtube.com/watch?v=3DOZ=
JiHMtIQ2M" rel=3D"noreferrer" target=3D"_blank">https://www.youtube.com/wat=
ch?v=3DOZJiHMtIQ2M</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. _gfxstream-enabl=
ed rutabaga:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"https://crosvm.dev/book/appendix/r=
utabaga_gfx.html" rel=3D"noreferrer" target=3D"_blank">https://crosvm.dev/b=
ook/appendix/rutabaga_gfx.html</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://crosvm.dev/book/appendix/rut=
abaga_gfx.html" rel=3D"noreferrer" target=3D"_blank">https://crosvm.dev/boo=
k/appendix/rutabaga_gfx.html</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://cro=
svm.dev/book/appendix/rutabaga_gfx.html" rel=3D"noreferrer" target=3D"_blan=
k">https://crosvm.dev/book/appendix/rutabaga_gfx.html</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://crosvm.dev/book/appendix/rut=
abaga_gfx.html" rel=3D"noreferrer" target=3D"_blank">https://crosvm.dev/boo=
k/appendix/rutabaga_gfx.html</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0You have different links f=
or &quot;rutabaga_gfx&quot; and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;gfxstream-enabled<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0rutabaga&quot;, but I thin=
k you only need one.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Done.=C2=A0 Didn&#39;t resend the entire patc=
h series (to avoid spamming<br>
&gt;=C2=A0 =C2=A0 =C2=A0list),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; just did &quot;in-reply-to&quot;.=C2=A0 The c=
hange is also available at:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://gitlab.freedesktop.org/gurchetan=
singh/qemu-gfxstream/-/commits/qemu-gfxstream-v8" rel=3D"noreferrer" target=
=3D"_blank">https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/=
commits/qemu-gfxstream-v8</a> &lt;<a href=3D"https://gitlab.freedesktop.org=
/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstream-v8" rel=3D"noreferr=
er" target=3D"_blank">https://gitlab.freedesktop.org/gurchetansingh/qemu-gf=
xstream/-/commits/qemu-gfxstream-v8</a>&gt; &lt;<a href=3D"https://gitlab.f=
reedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstream-v8" r=
el=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.org/gurcheta=
nsingh/qemu-gfxstream/-/commits/qemu-gfxstream-v8</a> &lt;<a href=3D"https:=
//gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxst=
ream-v8" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.or=
g/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstream-v8</a>&gt;&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The patch series now looks good so I finally decide=
d to try this patch<br>
&gt;=C2=A0 =C2=A0 =C2=A0series, but I couldn&#39;t get it work.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I noticed gfxstream has page size hardcoded as 4 Ki=
B, which broke my<br>
&gt;=C2=A0 =C2=A0 =C2=A0setup on M2 MacBook Air (running Asahi Linux) that =
has 16 KiB page. You<br>
&gt;=C2=A0 =C2=A0 =C2=A0may add code to check host page size and to report =
an error if it&#39;s not<br>
&gt;=C2=A0 =C2=A0 =C2=A04 KiB to virtio-gpu-rutabaga, but I think it&#39;s =
trivial to fix gfxstream<br>
&gt;=C2=A0 =C2=A0 =C2=A0to query page size at runtime as QEMU and Rutabaga =
does so I hope<br>
&gt;=C2=A0 =C2=A0 =C2=A0you to<br>
&gt;=C2=A0 =C2=A0 =C2=A0do so. For testing purpose, I have replaced it with=
 16 KiB on my setup.<br>
&gt; <br>
&gt; <br>
&gt; Good catch, the fix to the 16KiB was merged today and is in gfxstream =
<br>
&gt; ToT right now.<br>
<br>
The fix is incomplete. There are a few other places that hardcodes page <br=
>
size, namely ANDROID_EMU_ADDRESS_SPACE_DEFAULT_PAGE_SIZE and <br>
ADDRESS_SPACE_GRAPHICS_PAGE_SIZE.<br>
<br>
ANDROID_EMU_ADDRESS_SPACE_DEFAULT_PAGE_SIZE is used by no one so you can <b=
r>
just remove it. ADDRESS_SPACE_GRAPHICS_PAGE_SIZE is actually in use and <br=
>
needs to be fixed.<br>
<br>
It&#39;s also better to remove PAGE_SIZE definition from guest/meson.build =
<br>
just in case.<br></blockquote><div><br></div><div>ANDROID_EMU_ADDRESS_SPACE=
_DEFAULT_PAGE_SIZE=C2=A0and=C2=A0 PAGE_SIZE were removed from gfxstream ToT=
.=C2=A0</div><div>The host alignment of the ring blob is also now based on =
getpagesize(..) and not hardcoded.=C2=A0</div><div><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I also found some bugs on QEMU side so I added comm=
ents to respective<br>
&gt;=C2=A0 =C2=A0 =C2=A0patches.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Below is the logs from my last attempt of running v=
kgears:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0$ VK_LOADER_DEBUG=3Dall demos/build/src/vulkan/vkge=
ars<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Vulkan Loader Version 1.3.243<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Sea=
rching for layer manifest files<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0In following locations:<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /var/home/person/.config/vulkan/implicit_layer.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /etc/xdg/vulkan/implicit_layer.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /etc/vulkan/implicit_layer.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/var/home/person/.local/share/vulkan/implicit_layer=
.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/var/home/person/.local/share/flatpak/exports/share=
/vulkan/implicit_layer.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/var/lib/flatpak/exports/share/vulkan/implicit_laye=
r.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /usr/local/share/vulkan/implicit_layer.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /usr/share/vulkan/implicit_layer.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Found the following files:<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/share/vulkan/implicit_layer.d/VkLayer_MESA_dev=
ice_select.json<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Found manifest file<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/share/vulkan/implicit_layer.d/VkLayer_MESA_dev=
ice_select.json<br>
&gt;=C2=A0 =C2=A0 =C2=A0(file<br>
&gt;=C2=A0 =C2=A0 =C2=A0version &quot;1.0.0&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Sea=
rching for layer manifest files<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0In following locations:<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /var/home/person/.config/vulkan/explicit_layer.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /etc/xdg/vulkan/explicit_layer.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /etc/vulkan/explicit_layer.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/var/home/person/.local/share/vulkan/explicit_layer=
.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/var/home/person/.local/share/flatpak/exports/share=
/vulkan/explicit_layer.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/var/lib/flatpak/exports/share/vulkan/explicit_laye=
r.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /usr/local/share/vulkan/explicit_layer.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /usr/share/vulkan/explicit_layer.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Found no files<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Sea=
rching for driver manifest files<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 In following locations:<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/var/home/person/.config/vulkan/icd.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/etc/xdg/vulkan/icd.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/etc/vulkan/icd.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/var/home/person/.local/share/vulkan/icd.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/var/home/person/.local/share/flatpak/exports/share=
/vulkan/icd.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/var/lib/flatpak/exports/share/vulkan/icd.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/usr/local/share/vulkan/icd.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/usr/share/vulkan/icd.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Found the following files:<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/local/share/vulkan/icd.d/cereal_icd.aarch64.js=
on<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/usr/share/vulkan/icd.d/broadcom_icd.aarch64=
.json<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/usr/share/vulkan/icd.d/freedreno_icd.aarch6=
4.json<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/usr/share/vulkan/icd.d/lvp_icd.aarch64.json<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/usr/share/vulkan/icd.d/panfrost_icd.aarch64=
.json<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/usr/share/vulkan/icd.d/radeon_icd.aarch64.json<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Fou=
nd ICD manifest file<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/local/share/vulkan/icd.d/cereal_icd.aarch64.js=
on, version &quot;1.0.0&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0DEBUG | DRIVER:=C2=A0 =C2=A0Searching for ICD drive=
rs named<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/local/lib64/libvulkan_cereal.so<br>
&gt;=C2=A0 =C2=A0 =C2=A0[VirtGpuDevice.cpp(71)]<br>
&gt;=C2=A0 =C2=A0 =C2=A0[prio 6] virtgpu backend not enabling<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTGPU_PARAM_CREATE_GUEST_HANDLE[AndroidHealthMoni=
tor.cpp(275)]<br>
&gt;=C2=A0 =C2=A0 =C2=A0[prio 4] HealthMonitor disabled. Returning nullptrI=
0818 21:00:07.980257<br>
&gt;=C2=A0 =C2=A0 =C2=A0154451 IntelDrmDecoder.cpp:38] IntelDrmDecoder crea=
ted for context 2<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Fou=
nd ICD manifest file<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/share/vulkan/icd.d/broadcom_icd.aarch64.json, =
version &quot;1.0.0&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0DEBUG | DRIVER:=C2=A0 =C2=A0Searching for ICD drive=
rs named<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/lib64/libvulkan_broadcom.so<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Fou=
nd ICD manifest file<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/share/vulkan/icd.d/freedreno_icd.aarch64.json,=
 version &quot;1.0.0&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0DEBUG | DRIVER:=C2=A0 =C2=A0Searching for ICD drive=
rs named<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/lib64/libvulkan_freedreno.so<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Fou=
nd ICD manifest file<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/share/vulkan/icd.d/lvp_icd.aarch64.json, versi=
on &quot;1.0.0&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0DEBUG | DRIVER:=C2=A0 =C2=A0Searching for ICD drive=
rs named<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/lib64/libvulkan_lvp.so<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Fou=
nd ICD manifest file<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/share/vulkan/icd.d/panfrost_icd.aarch64.json, =
version &quot;1.0.0&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0DEBUG | DRIVER:=C2=A0 =C2=A0Searching for ICD drive=
rs named<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/lib64/libvulkan_panfrost.so<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Fou=
nd ICD manifest file<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/share/vulkan/icd.d/radeon_icd.aarch64.json, ve=
rsion &quot;1.0.0&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0DEBUG | DRIVER:=C2=A0 =C2=A0Searching for ICD drive=
rs named<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/lib64/libvulkan_radeon.so<br>
&gt;=C2=A0 =C2=A0 =C2=A0DEBUG | LAYER:=C2=A0 =C2=A0 Loading layer library l=
ibVkLayer_MESA_device_select.so<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | LAYER:=C2=A0 =C2=A0 =C2=A0Insert instance la=
yer &quot;VK_LAYER_MESA_device_select&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0(libVkLayer_MESA_device_select.so)<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vkC=
reateInstance layer callstack setup to:<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&lt;Application&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0||<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&lt;Loader&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0||<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0VK_LAYER_MESA_device_select<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Type: Implicit<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Disable Env Var:=C2=A0 =
NODEVICE_SELECT<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Manifest:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/share/vulkan/implicit_layer.d/VkLayer_MESA_dev=
ice_select.json<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Library:=C2=A0 libVkLayer_MESA_device=
_select.so<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0||<br>
&gt;=C2=A0 =C2=A0 =C2=A0LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&lt;Drivers&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0I0818 21:00:08.014896=C2=A0 154451 VkDecoderGlobalS=
tate.cpp:443] Creating<br>
&gt;=C2=A0 =C2=A0 =C2=A0Vulkan instance for app: vkgears<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 linux_read_sorted_physi=
cal_devices:<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Ori=
ginal order:<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0[0] llvmpipe (LLVM 16.0.6, 128 bits)<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0[1] llvmpipe (LLVM 15.0.7, 128 bits)<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Sor=
ted order:<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0[0] llvmpipe (LLVM 15.0.7, 128 bits)<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0[1] llvmpipe (LLVM 16.0.6, 128 bits)<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 linux_read_sorted_physi=
cal_devices:<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Ori=
ginal order:<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0[0] llvmpipe (LLVM 16.0.6, 128 bits)<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0[1] llvmpipe (LLVM 15.0.7, 128 bits)<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Sor=
ted order:<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0[0] llvmpipe (LLVM 15.0.7, 128 bits)<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0[1] llvmpipe (LLVM 16.0.6, 128 bits)<br>
&gt;=C2=A0 =C2=A0 =C2=A0DEBUG | DRIVER:=C2=A0 =C2=A0Copying old device 0 in=
to new device 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0DEBUG | DRIVER:=C2=A0 =C2=A0Copying old device 1 in=
to new device 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 linux_read_sorted_physi=
cal_devices:<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Ori=
ginal order:<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0[0] llvmpipe (LLVM 16.0.6, 128 bits)<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0[1] llvmpipe (LLVM 15.0.7, 128 bits)<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Sor=
ted order:<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0[0] llvmpipe (LLVM 15.0.7, 128 bits)<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0[1] llvmpipe (LLVM 16.0.6, 128 bits)<br>
&gt;=C2=A0 =C2=A0 =C2=A0DEBUG | DRIVER:=C2=A0 =C2=A0Copying old device 0 in=
to new device 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0DEBUG | DRIVER:=C2=A0 =C2=A0Copying old device 1 in=
to new device 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 linux_read_sorted_physi=
cal_devices:<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Ori=
ginal order:<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0[0] llvmpipe (LLVM 16.0.6, 128 bits)<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0[1] llvmpipe (LLVM 15.0.7, 128 bits)<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Sor=
ted order:<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0[0] llvmpipe (LLVM 15.0.7, 128 bits)<br>
&gt;=C2=A0 =C2=A0 =C2=A0INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0[1] llvmpipe (LLVM 16.0.6, 128 bits)<br>
&gt;=C2=A0 =C2=A0 =C2=A0DEBUG | DRIVER:=C2=A0 =C2=A0Copying old device 0 in=
to new device 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0DEBUG | DRIVER:=C2=A0 =C2=A0Copying old device 1 in=
to new device 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0ERROR:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 loa=
der_validate_device_extensions: Device extension<br>
&gt;=C2=A0 =C2=A0 =C2=A0VK_KHR_swapchain not supported by selected physical=
 device or enabled<br>
&gt; <br>
&gt; <br>
&gt; Yeah, any non-headless Linux tests are unlikely to work.=C2=A0 Maybe i=
n a <br>
&gt; future gfxstream release, since our focus is of course on Android and =
<br>
&gt; getting Vulkan in QEMU in general.<br>
<br>
I have just tried &quot;vulkan-samples sample hello_triangle --headless&quo=
t; but <br>
no luck. Below is the output of QEMU with -trace virtio_gpu_cmd_*<br></bloc=
kquote><div><br></div><div>I have slightly different behavior on my setup, =
the app fails to find the proper surface extensions and exits.=C2=A0 =C2=A0=
In headless mode, the app relies on=C2=A0VK_EXT_headless_surface, which gfx=
stream does not currently support (see=C2=A0on_vkEnumerateInstanceExtension=
Properties).=C2=A0 For some reason, perhaps due the presence of other VK dr=
ivers on the system, vulkaninfo does report several X11/Wayland surface ext=
ensions with gfxstream.=C2=A0 This may confuse some headless apps.=C2=A0=C2=
=A0</div><div><br></div><div>Either way, the crosvm docs will be clarified =
to mention what&#39;s been tested regarding gfxstream guest Linux (<a href=
=3D"http://crrev.com/c/4800334" target=3D"_blank">crrev.com/c/4800334</a>).=
=C2=A0 I suggest you run deqp-vk if your goal is to test this patch series.=
=C2=A0=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
virtio_gpu_cmd_ctx_create ctx 0x2, name vulkan_samples<br>
virtio_gpu_cmd_res_create_blob res 0x24, size 1064960<br>
virtio_gpu_cmd_ctx_res_attach ctx 0x2, res 0x24<br>
virtio_gpu_cmd_ctx_submit ctx 0x2, size 8<br>
I0819 15:10:06.916033=C2=A0 =C2=A021850 IntelDrmDecoder.cpp:38] IntelDrmDec=
oder <br>
created for context 2<br>
virtio_gpu_cmd_ctx_submit ctx 0x2, size 8<br>
virtio_gpu_cmd_ctx_submit ctx 0x2, size 8<br>
W0819 15:10:06.916443=C2=A0 =C2=A021850 VkDecoder.cpp:137] Bad packet lengt=
h 0 <br>
detected, decode may fail<br>
virtio_gpu_cmd_ctx_submit ctx 0x2, size 8<br>
W0819 15:10:06.916465=C2=A0 =C2=A021850 VkDecoder.cpp:137] Bad packet lengt=
h 0 <br>
detected, decode may fail<br>
W0819 15:10:06.916473=C2=A0 =C2=A021850 VkDecoder.cpp:137] Bad packet lengt=
h 0 <br>
detected, decode may fail<br>
W0819 15:10:06.916478=C2=A0 =C2=A021850 VkDecoder.cpp:137] Bad packet lengt=
h 0 <br>
detected, decode may fail<br>
W0819 15:10:06.916482=C2=A0 =C2=A021850 VkDecoder.cpp:137] Bad packet lengt=
h 0 <br>
detected, decode may fail<br>
<br>
And it endlessly outputs &quot;Bad packet length&quot; error messages.<br>
</blockquote></div></div>

--0000000000002f949c060377f6ae--

