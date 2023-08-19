Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D85ED781665
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:18:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAbL-0001YF-KU; Fri, 18 Aug 2023 21:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qXAbI-0001Y0-LU
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:18:00 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qXAbD-00024M-M6
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:18:00 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99c353a395cso192131966b.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692407872; x=1693012672;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1TqWwoGXHjkFI7hT316xW0AQoI+Ez+erg220fPgHNlI=;
 b=VA0UPt78QtFSbP+xekiwphjNGNk6EF2SLaU81Osr+xsV9mYKN0p/P8hG6/wUk0B43w
 M6y0zcoGja4d0gOqpVhOpMqLAyLfg/SYT2LYv5ZrYO/2vfPsQIvdsmnPHuRLxOiEBR+9
 QAsA0y8722O8BXhdSvjDQeSqVgLBQK/6ZD3Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692407872; x=1693012672;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1TqWwoGXHjkFI7hT316xW0AQoI+Ez+erg220fPgHNlI=;
 b=T+BwKzeidWm0HBxb5optbnA5dMma3eUXVEajYIdiKdJpEt6lsrya/gaOQOgMejzcTu
 Zy28tcXo5Elibr8pvB6fWE3j+Wyn5yrj3bt+r55nuZiSwIgOjVhv7xt8p9P3YqXeTPGH
 3Lbg30nS8djzShajv4MYYuArHca1+4PaU1Rn8eUXl4HPSoObJoVKSK83qSXASwJ1ZzBx
 /6UMU6mAAAnIqwN+hEjF+xsxWaXB0P5sFDecEcuczkH5wKvyYPwjoc5U01FBgFgLaf3t
 zmL0ZoWcFF8WycLQb2hqTY5E180b0KnhYCNr8Kq78I0amaY9sDnBfF806IuGda1wjRE7
 kLCQ==
X-Gm-Message-State: AOJu0YxB8VZhHMohjXAuRV3Ptypi9jxRNPlS1Naaz/8+Iwr7Mgl6Ip9S
 kcl86fQ4dL1ruf35kR6VmSQfBEHUNVYoEYv310Irig==
X-Google-Smtp-Source: AGHT+IG1NgXqCT/z2DMaB0gztDgVmIkEAmd1cnGAxl+wmwfItGjZ/tUKT6DAEuSNLXkxpfrtF4NSDw==
X-Received: by 2002:a17:906:5a68:b0:99b:d178:f059 with SMTP id
 my40-20020a1709065a6800b0099bd178f059mr591736ejc.35.1692407872466; 
 Fri, 18 Aug 2023 18:17:52 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com.
 [209.85.208.51]) by smtp.gmail.com with ESMTPSA id
 e21-20020a170906249500b0098e2969ed44sm1828038ejb.45.2023.08.18.18.17.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 18:17:52 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-521e046f6c7so2340a12.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:17:51 -0700 (PDT)
X-Received: by 2002:a50:ab17:0:b0:522:cc9c:f5a4 with SMTP id
 s23-20020a50ab17000000b00522cc9cf5a4mr168794edc.4.1692407870850; Fri, 18 Aug
 2023 18:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230817022322.466-1-gurchetansingh@google.com>
 <20230817022322.466-10-gurchetansingh@google.com>
 <1281e8f6-f91a-4ced-b5d1-773370db3eef@gmail.com>
 <CAAfnVBmmwWGTu0-6efVDqRRu9jvKmiboPzGtprm2h=U5XXj0Tw@mail.gmail.com>
 <fcf79be7-5cf7-4c74-844c-9812f0b31f4a@gmail.com>
In-Reply-To: <fcf79be7-5cf7-4c74-844c-9812f0b31f4a@gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Fri, 18 Aug 2023 18:17:38 -0700
X-Gmail-Original-Message-ID: <CAAfnVBmSXOxHqO+w59XY57DTfqEQwfVprSWXEbPEhP7eTrO0dA@mail.gmail.com>
Message-ID: <CAAfnVBmSXOxHqO+w59XY57DTfqEQwfVprSWXEbPEhP7eTrO0dA@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] docs/system: add basic virtio-gpu documentation
To: Akihiko Odaki <akihiko.odaki@gmail.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, kraxel@redhat.com, 
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is, 
 ernunes@redhat.com, manos.pitsidianakis@linaro.org
Content-Type: multipart/alternative; boundary="000000000000fb04e206033c69fb"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ej1-x632.google.com
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

--000000000000fb04e206033c69fb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 5:08=E2=80=AFAM Akihiko Odaki <akihiko.odaki@gmail.=
com>
wrote:

> On 2023/08/18 8:47, Gurchetan Singh wrote:
> >
> >
> > On Wed, Aug 16, 2023 at 10:28=E2=80=AFPM Akihiko Odaki <akihiko.odaki@g=
mail.com
> > <mailto:akihiko.odaki@gmail.com>> wrote:
> >
> >     On 2023/08/17 11:23, Gurchetan Singh wrote:
> >      > From: Gurchetan Singh <gurchetansingh@chromium.org
> >     <mailto:gurchetansingh@chromium.org>>
> >      >
> >      > This adds basic documentation for virtio-gpu.
> >      >
> >      > Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>
> >      > Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org
> >     <mailto:gurchetansingh@chromium.org>>
> >      > Tested-by: Alyssa Ross <hi@alyssa.is <mailto:hi@alyssa.is>>
> >      > Tested-by: Emmanouil Pitsidianakis
> >     <manos.pitsidianakis@linaro.org <mailto:
> manos.pitsidianakis@linaro.org>>
> >      > Reviewed-by: Emmanouil Pitsidianakis
> >     <manos.pitsidianakis@linaro.org <mailto:
> manos.pitsidianakis@linaro.org>>
> >      > ---
> >      > v2: - Incorporated suggestions by Akihiko Odaki
> >      >      - Listed the currently supported capset_names (Bernard)
> >      >
> >      > v3: - Incorporated suggestions by Akihiko Odaki and Alyssa Ross
> >      >
> >      > v4: - Incorporated suggestions by Akihiko Odaki
> >      >
> >      > v5: - Removed pci suffix from examples
> >      >      - Verified that -device virtio-gpu-rutabaga works.  Strange=
ly
> >      >        enough, I don't remember changing anything, and I remembe=
r
> >      >        it not working.  I did rebase to top of tree though.
> >      >      - Fixed meson examples in crosvm docs
> >      >
> >      >   docs/system/device-emulation.rst   |   1 +
> >      >   docs/system/devices/virtio-gpu.rst | 113
> >     +++++++++++++++++++++++++++++
> >      >   2 files changed, 114 insertions(+)
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
> >      > index 0000000000..8c5c708272
> >      > --- /dev/null
> >      > +++ b/docs/system/devices/virtio-gpu.rst
> >      > @@ -0,0 +1,113 @@
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
> >      > +virtio-gpu 2d
> >      > +-------------
> >      > +
> >      > +The default 2D backend only performs 2D operations. The guest
> >     needs to
> >      > +employ a software renderer for 3D graphics.
> >      > +
> >      > +Typically, the software renderer is provided by `Mesa`_ or
> >     `SwiftShader`_.
> >      > +Mesa's implementations (LLVMpipe, Lavapipe and virgl below) wor=
k
> >     out of box
> >      > +on typical modern Linux distributions.
> >      > +
> >      > +.. parsed-literal::
> >      > +    -device virtio-gpu
> >      > +
> >      > +.. _Mesa: https://www.mesa3d.org/ <https://www.mesa3d.org/>
> >      > +.. _SwiftShader: https://github.com/google/swiftshader
> >     <https://github.com/google/swiftshader>
> >      > +
> >      > +virtio-gpu virglrenderer
> >      > +------------------------
> >      > +
> >      > +When using virgl accelerated graphics mode in the guest, OpenGL
> >     API calls
> >      > +are translated into an intermediate representation (see
> >     `Gallium3D`_). The
> >      > +intermediate representation is communicated to the host and the
> >      > +`virglrenderer`_ library on the host translates the intermediat=
e
> >      > +representation back to OpenGL API calls.
> >      > +
> >      > +.. parsed-literal::
> >      > +    -device virtio-gpu-gl
> >      > +
> >      > +.. _Gallium3D:
> >     https://www.freedesktop.org/wiki/Software/gallium/
> >     <https://www.freedesktop.org/wiki/Software/gallium/>
> >      > +.. _virglrenderer:
> >     https://gitlab.freedesktop.org/virgl/virglrenderer/
> >     <https://gitlab.freedesktop.org/virgl/virglrenderer/>
> >      > +
> >      > +virtio-gpu rutabaga
> >      > +-------------------
> >      > +
> >      > +virtio-gpu can also leverage `rutabaga_gfx`_ to provide
> `gfxstream`_
> >      > +rendering and `Wayland display passthrough`_.  With the
> >     gfxstream rendering
> >      > +mode, GLES and Vulkan calls are forwarded to the host with
> minimal
> >      > +modification.
> >      > +
> >      > +The crosvm book provides directions on how to build a
> >     `gfxstream-enabled
> >      > +rutabaga`_ and launch a `guest Wayland proxy`_.
> >      > +
> >      > +This device does require host blob support (``hostmem`` field
> >     below). The
> >      > +``hostmem`` field specifies the size of virtio-gpu host memory
> >     window.
> >      > +This is typically between 256M and 8G.
> >      > +
> >      > +At least one capset (see colon separated ``capset_names`` below=
)
> >     must be
> >      > +specified when starting the device.  The currently supported
> >      > +``capset_names`` are ``gfxstream-vulkan`` and ``cross-domain``
> >     on Linux
> >      > +guests. For Android guests, ``gfxstream-gles`` is also supporte=
d.
> >      > +
> >      > +The device will try to auto-detect the wayland socket path if t=
he
> >      > +``cross-domain`` capset name is set.  The user may optionally
> >     specify
> >      > +``wayland_socket_path`` for non-standard paths.
> >      > +
> >      > +The ``wsi`` option can be set to ``surfaceless`` or ``headless`=
`.
> >      > +Surfaceless doesn't create a native window surface, but does
> >     copy from the
> >      > +render target to the Pixman buffer if a virtio-gpu 2D hypercall
> >     is issued.
> >      > +Headless is like surfaceless, but doesn't copy to the Pixman
> buffer.
> >      > +Surfaceless is the default if ``wsi`` is not specified.
> >      > +
> >      > +.. parsed-literal::
> >      > +    -device
> >     virtio-gpu-rutabaga,capset_names=3Dgfxstream-vulkan:cross-domain,
> >      > +
> >       hostmem=3D8G,wayland_socket_path=3D/tmp/nonstandard/mock_wayland.=
sock,
> >      > +       wsi=3Dheadless
> >      > +
> >      > +.. _rutabaga_gfx:
> >
> https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/r=
utabaga_gfx_ffi.h
> <
> https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/r=
utabaga_gfx_ffi.h
> >
> >      > +.. _gfxstream:
> >     https://android.googlesource.com/platform/hardware/google/gfxstream=
/
> >     <
> https://android.googlesource.com/platform/hardware/google/gfxstream/>
> >      > +.. _Wayland display passthrough:
> >     https://www.youtube.com/watch?v=3DOZJiHMtIQ2M
> >     <https://www.youtube.com/watch?v=3DOZJiHMtIQ2M>
> >      > +.. _gfxstream-enabled rutabaga:
> >     https://crosvm.dev/book/appendix/rutabaga_gfx.html
> >     <https://crosvm.dev/book/appendix/rutabaga_gfx.html>
> >
> >     You have different links for "rutabaga_gfx" and "gfxstream-enabled
> >     rutabaga", but I think you only need one.
> >
> >
> > Done.  Didn't resend the entire patch series (to avoid spamming list),
> > just did "in-reply-to".  The change is also available at:
> >
> >
> https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qe=
mu-gfxstream-v8
> <
> https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qe=
mu-gfxstream-v8
> >
>
> The patch series now looks good so I finally decided to try this patch
> series, but I couldn't get it work.
>
> I noticed gfxstream has page size hardcoded as 4 KiB, which broke my
> setup on M2 MacBook Air (running Asahi Linux) that has 16 KiB page. You
> may add code to check host page size and to report an error if it's not
> 4 KiB to virtio-gpu-rutabaga, but I think it's trivial to fix gfxstream
> to query page size at runtime as QEMU and Rutabaga does so I hope you to
> do so. For testing purpose, I have replaced it with 16 KiB on my setup.
>

Good catch, the fix to the 16KiB was merged today and is in gfxstream ToT
right now.


>
> I also found some bugs on QEMU side so I added comments to respective
> patches.
>
> Below is the logs from my last attempt of running vkgears:
>
> $ VK_LOADER_DEBUG=3Dall demos/build/src/vulkan/vkgears
> INFO:             Vulkan Loader Version 1.3.243
> LAYER:            Searching for layer manifest files
> LAYER:               In following locations:
> LAYER:                  /var/home/person/.config/vulkan/implicit_layer.d
> LAYER:                  /etc/xdg/vulkan/implicit_layer.d
> LAYER:                  /etc/vulkan/implicit_layer.d
> LAYER:
> /var/home/person/.local/share/vulkan/implicit_layer.d
> LAYER:
> /var/home/person/.local/share/flatpak/exports/share/vulkan/implicit_layer=
.d
> LAYER:
> /var/lib/flatpak/exports/share/vulkan/implicit_layer.d
> LAYER:                  /usr/local/share/vulkan/implicit_layer.d
> LAYER:                  /usr/share/vulkan/implicit_layer.d
> LAYER:               Found the following files:
> LAYER:
> /usr/share/vulkan/implicit_layer.d/VkLayer_MESA_device_select.json
> INFO:             Found manifest file
> /usr/share/vulkan/implicit_layer.d/VkLayer_MESA_device_select.json (file
> version "1.0.0")
> LAYER:            Searching for layer manifest files
> LAYER:               In following locations:
> LAYER:                  /var/home/person/.config/vulkan/explicit_layer.d
> LAYER:                  /etc/xdg/vulkan/explicit_layer.d
> LAYER:                  /etc/vulkan/explicit_layer.d
> LAYER:
> /var/home/person/.local/share/vulkan/explicit_layer.d
> LAYER:
> /var/home/person/.local/share/flatpak/exports/share/vulkan/explicit_layer=
.d
> LAYER:
> /var/lib/flatpak/exports/share/vulkan/explicit_layer.d
> LAYER:                  /usr/local/share/vulkan/explicit_layer.d
> LAYER:                  /usr/share/vulkan/explicit_layer.d
> LAYER:               Found no files
> DRIVER:           Searching for driver manifest files
> DRIVER:              In following locations:
> DRIVER:                 /var/home/person/.config/vulkan/icd.d
> DRIVER:                 /etc/xdg/vulkan/icd.d
> DRIVER:                 /etc/vulkan/icd.d
> DRIVER:                 /var/home/person/.local/share/vulkan/icd.d
> DRIVER:
> /var/home/person/.local/share/flatpak/exports/share/vulkan/icd.d
> DRIVER:                 /var/lib/flatpak/exports/share/vulkan/icd.d
> DRIVER:                 /usr/local/share/vulkan/icd.d
> DRIVER:                 /usr/share/vulkan/icd.d
> DRIVER:              Found the following files:
> DRIVER:
> /usr/local/share/vulkan/icd.d/cereal_icd.aarch64.json
> DRIVER:                 /usr/share/vulkan/icd.d/broadcom_icd.aarch64.json
> DRIVER:                 /usr/share/vulkan/icd.d/freedreno_icd.aarch64.jso=
n
> DRIVER:                 /usr/share/vulkan/icd.d/lvp_icd.aarch64.json
> DRIVER:                 /usr/share/vulkan/icd.d/panfrost_icd.aarch64.json
> DRIVER:                 /usr/share/vulkan/icd.d/radeon_icd.aarch64.json
> DRIVER:           Found ICD manifest file
> /usr/local/share/vulkan/icd.d/cereal_icd.aarch64.json, version "1.0.0"
> DEBUG | DRIVER:   Searching for ICD drivers named
> /usr/local/lib64/libvulkan_cereal.so
> [VirtGpuDevice.cpp(71)]
> [prio 6] virtgpu backend not enabling
> VIRTGPU_PARAM_CREATE_GUEST_HANDLE[AndroidHealthMonitor.cpp(275)]
> [prio 4] HealthMonitor disabled. Returning nullptrI0818 21:00:07.980257
> 154451 IntelDrmDecoder.cpp:38] IntelDrmDecoder created for context 2
> DRIVER:           Found ICD manifest file
> /usr/share/vulkan/icd.d/broadcom_icd.aarch64.json, version "1.0.0"
> DEBUG | DRIVER:   Searching for ICD drivers named
> /usr/lib64/libvulkan_broadcom.so
> DRIVER:           Found ICD manifest file
> /usr/share/vulkan/icd.d/freedreno_icd.aarch64.json, version "1.0.0"
> DEBUG | DRIVER:   Searching for ICD drivers named
> /usr/lib64/libvulkan_freedreno.so
> DRIVER:           Found ICD manifest file
> /usr/share/vulkan/icd.d/lvp_icd.aarch64.json, version "1.0.0"
> DEBUG | DRIVER:   Searching for ICD drivers named
> /usr/lib64/libvulkan_lvp.so
> DRIVER:           Found ICD manifest file
> /usr/share/vulkan/icd.d/panfrost_icd.aarch64.json, version "1.0.0"
> DEBUG | DRIVER:   Searching for ICD drivers named
> /usr/lib64/libvulkan_panfrost.so
> DRIVER:           Found ICD manifest file
> /usr/share/vulkan/icd.d/radeon_icd.aarch64.json, version "1.0.0"
> DEBUG | DRIVER:   Searching for ICD drivers named
> /usr/lib64/libvulkan_radeon.so
> DEBUG | LAYER:    Loading layer library libVkLayer_MESA_device_select.so
> INFO | LAYER:     Insert instance layer "VK_LAYER_MESA_device_select"
> (libVkLayer_MESA_device_select.so)
> LAYER:            vkCreateInstance layer callstack setup to:
> LAYER:               <Application>
> LAYER:                 ||
> LAYER:               <Loader>
> LAYER:                 ||
> LAYER:               VK_LAYER_MESA_device_select
> LAYER:                       Type: Implicit
> LAYER:                           Disable Env Var:  NODEVICE_SELECT
> LAYER:                       Manifest:
> /usr/share/vulkan/implicit_layer.d/VkLayer_MESA_device_select.json
> LAYER:                       Library:  libVkLayer_MESA_device_select.so
> LAYER:                 ||
> LAYER:               <Drivers>
> I0818 21:00:08.014896  154451 VkDecoderGlobalState.cpp:443] Creating
> Vulkan instance for app: vkgears
> INFO | DRIVER:    linux_read_sorted_physical_devices:
> INFO | DRIVER:         Original order:
> INFO | DRIVER:               [0] llvmpipe (LLVM 16.0.6, 128 bits)
> INFO | DRIVER:               [1] llvmpipe (LLVM 15.0.7, 128 bits)
> INFO | DRIVER:         Sorted order:
> INFO | DRIVER:               [0] llvmpipe (LLVM 15.0.7, 128 bits)
> INFO | DRIVER:               [1] llvmpipe (LLVM 16.0.6, 128 bits)
> INFO | DRIVER:    linux_read_sorted_physical_devices:
> INFO | DRIVER:         Original order:
> INFO | DRIVER:               [0] llvmpipe (LLVM 16.0.6, 128 bits)
> INFO | DRIVER:               [1] llvmpipe (LLVM 15.0.7, 128 bits)
> INFO | DRIVER:         Sorted order:
> INFO | DRIVER:               [0] llvmpipe (LLVM 15.0.7, 128 bits)
> INFO | DRIVER:               [1] llvmpipe (LLVM 16.0.6, 128 bits)
> DEBUG | DRIVER:   Copying old device 0 into new device 0
> DEBUG | DRIVER:   Copying old device 1 into new device 1
> INFO | DRIVER:    linux_read_sorted_physical_devices:
> INFO | DRIVER:         Original order:
> INFO | DRIVER:               [0] llvmpipe (LLVM 16.0.6, 128 bits)
> INFO | DRIVER:               [1] llvmpipe (LLVM 15.0.7, 128 bits)
> INFO | DRIVER:         Sorted order:
> INFO | DRIVER:               [0] llvmpipe (LLVM 15.0.7, 128 bits)
> INFO | DRIVER:               [1] llvmpipe (LLVM 16.0.6, 128 bits)
> DEBUG | DRIVER:   Copying old device 0 into new device 0
> DEBUG | DRIVER:   Copying old device 1 into new device 1
> INFO | DRIVER:    linux_read_sorted_physical_devices:
> INFO | DRIVER:         Original order:
> INFO | DRIVER:               [0] llvmpipe (LLVM 16.0.6, 128 bits)
> INFO | DRIVER:               [1] llvmpipe (LLVM 15.0.7, 128 bits)
> INFO | DRIVER:         Sorted order:
> INFO | DRIVER:               [0] llvmpipe (LLVM 15.0.7, 128 bits)
> INFO | DRIVER:               [1] llvmpipe (LLVM 16.0.6, 128 bits)
> DEBUG | DRIVER:   Copying old device 0 into new device 0
> DEBUG | DRIVER:   Copying old device 1 into new device 1
> ERROR:            loader_validate_device_extensions: Device extension
> VK_KHR_swapchain not supported by selected physical device or enabled


Yeah, any non-headless Linux tests are unlikely to work.  Maybe in a future
gfxstream release, since our focus is of course on Android and getting
Vulkan in QEMU in general.


>
> layers.
> ERROR:            vkCreateDevice: Failed to validate extensions in list
> ERROR:            vkGetDeviceQueue2: Invalid device
> [VUID-vkGetDeviceQueue2-device-parameter]
> Aborted (core dumped)
>

--000000000000fb04e206033c69fb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 18, 2023 at 5:08=E2=80=AF=
AM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@gmail.com">akihiko.oda=
ki@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">On 2023/08/18 8:47, Gurchetan Singh wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Wed, Aug 16, 2023 at 10:28=E2=80=AFPM Akihiko Odaki &lt;<a href=3D"=
mailto:akihiko.odaki@gmail.com" target=3D"_blank">akihiko.odaki@gmail.com</=
a> <br>
&gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@gmail.com" target=3D"_blank=
">akihiko.odaki@gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2023/08/17 11:23, Gurchetan Singh wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; From: Gurchetan Singh &lt;<a href=3D"mailto:g=
urchetansingh@chromium.org" target=3D"_blank">gurchetansingh@chromium.org</=
a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:gurchetansingh@chromiu=
m.org" target=3D"_blank">gurchetansingh@chromium.org</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
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
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Tested-by: Alyssa Ross &lt;<a href=3D"mailto:=
hi@alyssa.is" target=3D"_blank">hi@alyssa.is</a> &lt;mailto:<a href=3D"mail=
to:hi@alyssa.is" target=3D"_blank">hi@alyssa.is</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Tested-by: Emmanouil Pitsidianakis<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:manos.pitsidianakis@linaro.or=
g" target=3D"_blank">manos.pitsidianakis@linaro.org</a> &lt;mailto:<a href=
=3D"mailto:manos.pitsidianakis@linaro.org" target=3D"_blank">manos.pitsidia=
nakis@linaro.org</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Reviewed-by: Emmanouil Pitsidianakis<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:manos.pitsidianakis@linaro.or=
g" target=3D"_blank">manos.pitsidianakis@linaro.org</a> &lt;mailto:<a href=
=3D"mailto:manos.pitsidianakis@linaro.org" target=3D"_blank">manos.pitsidia=
nakis@linaro.org</a>&gt;&gt;<br>
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
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; v5: - Removed pci suffix from examples<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 - Verified that -device v=
irtio-gpu-rutabaga works.=C2=A0 Strangely<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 enough, I don&#39;=
t remember changing anything, and I remember<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 it not working.=C2=
=A0 I did rebase to top of tree though.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 - Fixed meson examples in=
 crosvm docs<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0docs/system/device-emulation.rst=
=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0docs/system/devices/virtio-gpu.rs=
t | 113<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A02 files changed, 114 insertions(+=
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
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 0000000000..8c5c708272<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/docs/system/devices/virtio-gpu.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -0,0 +1,113 @@<br>
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
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +virtio-gpu 2d<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +-------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +The default 2D backend only performs 2D oper=
ations. The guest<br>
&gt;=C2=A0 =C2=A0 =C2=A0needs to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +employ a software renderer for 3D graphics.<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +Typically, the software renderer is provided=
 by `Mesa`_ or<br>
&gt;=C2=A0 =C2=A0 =C2=A0`SwiftShader`_.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +Mesa&#39;s implementations (LLVMpipe, Lavapi=
pe and virgl below) work<br>
&gt;=C2=A0 =C2=A0 =C2=A0out of box<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +on typical modern Linux distributions.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. parsed-literal::<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 -device virtio-gpu<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. _Mesa: <a href=3D"https://www.mesa3d.org/=
" rel=3D"noreferrer" target=3D"_blank">https://www.mesa3d.org/</a> &lt;<a h=
ref=3D"https://www.mesa3d.org/" rel=3D"noreferrer" target=3D"_blank">https:=
//www.mesa3d.org/</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. _SwiftShader: <a href=3D"https://github.c=
om/google/swiftshader" rel=3D"noreferrer" target=3D"_blank">https://github.=
com/google/swiftshader</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://github.com/google/swiftshade=
r" rel=3D"noreferrer" target=3D"_blank">https://github.com/google/swiftshad=
er</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +virtio-gpu virglrenderer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +------------------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +When using virgl accelerated graphics mode i=
n the guest, OpenGL<br>
&gt;=C2=A0 =C2=A0 =C2=A0API calls<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +are translated into an intermediate represen=
tation (see<br>
&gt;=C2=A0 =C2=A0 =C2=A0`Gallium3D`_). The<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +intermediate representation is communicated =
to the host and the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +`virglrenderer`_ library on the host transla=
tes the intermediate<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +representation back to OpenGL API calls.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. parsed-literal::<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 -device virtio-gpu-gl<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. _Gallium3D:<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://www.freedesktop.org/wiki/Softwar=
e/gallium/" rel=3D"noreferrer" target=3D"_blank">https://www.freedesktop.or=
g/wiki/Software/gallium/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://www.freedesktop.org/wiki/Sof=
tware/gallium/" rel=3D"noreferrer" target=3D"_blank">https://www.freedeskto=
p.org/wiki/Software/gallium/</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. _virglrenderer:<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://gitlab.freedesktop.org/virgl/vir=
glrenderer/" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedeskto=
p.org/virgl/virglrenderer/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://gitlab.freedesktop.org/virgl=
/virglrenderer/" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freede=
sktop.org/virgl/virglrenderer/</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +virtio-gpu rutabaga<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +-------------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +virtio-gpu can also leverage `rutabaga_gfx`_=
 to provide `gfxstream`_<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +rendering and `Wayland display passthrough`_=
.=C2=A0 With the<br>
&gt;=C2=A0 =C2=A0 =C2=A0gfxstream rendering<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +mode, GLES and Vulkan calls are forwarded to=
 the host with minimal<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +modification.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +The crosvm book provides directions on how t=
o build a<br>
&gt;=C2=A0 =C2=A0 =C2=A0`gfxstream-enabled<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +rutabaga`_ and launch a `guest Wayland proxy=
`_.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +This device does require host blob support (=
``hostmem`` field<br>
&gt;=C2=A0 =C2=A0 =C2=A0below). The<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +``hostmem`` field specifies the size of virt=
io-gpu host memory<br>
&gt;=C2=A0 =C2=A0 =C2=A0window.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +This is typically between 256M and 8G.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +At least one capset (see colon separated ``c=
apset_names`` below)<br>
&gt;=C2=A0 =C2=A0 =C2=A0must be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +specified when starting the device.=C2=A0 Th=
e currently supported<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +``capset_names`` are ``gfxstream-vulkan`` an=
d ``cross-domain``<br>
&gt;=C2=A0 =C2=A0 =C2=A0on Linux<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +guests. For Android guests, ``gfxstream-gles=
`` is also supported.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +The device will try to auto-detect the wayla=
nd socket path if the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +``cross-domain`` capset name is set.=C2=A0 T=
he user may optionally<br>
&gt;=C2=A0 =C2=A0 =C2=A0specify<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +``wayland_socket_path`` for non-standard pat=
hs.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +The ``wsi`` option can be set to ``surfacele=
ss`` or ``headless``.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +Surfaceless doesn&#39;t create a native wind=
ow surface, but does<br>
&gt;=C2=A0 =C2=A0 =C2=A0copy from the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +render target to the Pixman buffer if a virt=
io-gpu 2D hypercall<br>
&gt;=C2=A0 =C2=A0 =C2=A0is issued.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +Headless is like surfaceless, but doesn&#39;=
t copy to the Pixman buffer.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +Surfaceless is the default if ``wsi`` is not=
 specified.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. parsed-literal::<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 -device<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio-gpu-rutabaga,capset_names=3Dgfxstream-vulkan=
:cross-domain,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hostmem=3D8G,wayland_socket_path=3D/tmp/nons=
tandard/mock_wayland.sock,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0wsi=3Dheadless<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. _rutabaga_gfx:<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://github.com/google/crosvm/blob/ma=
in/rutabaga_gfx/ffi/src/include/rutabaga_gfx_ffi.h" rel=3D"noreferrer" targ=
et=3D"_blank">https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/s=
rc/include/rutabaga_gfx_ffi.h</a> &lt;<a href=3D"https://github.com/google/=
crosvm/blob/main/rutabaga_gfx/ffi/src/include/rutabaga_gfx_ffi.h" rel=3D"no=
referrer" target=3D"_blank">https://github.com/google/crosvm/blob/main/ruta=
baga_gfx/ffi/src/include/rutabaga_gfx_ffi.h</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. _gfxstream:<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://android.googlesource.com/platfor=
m/hardware/google/gfxstream/" rel=3D"noreferrer" target=3D"_blank">https://=
android.googlesource.com/platform/hardware/google/gfxstream/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://android.googlesource.com/pla=
tform/hardware/google/gfxstream/" rel=3D"noreferrer" target=3D"_blank">http=
s://android.googlesource.com/platform/hardware/google/gfxstream/</a>&gt;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. _Wayland display passthrough:<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://www.youtube.com/watch?v=3DOZJiHM=
tIQ2M" rel=3D"noreferrer" target=3D"_blank">https://www.youtube.com/watch?v=
=3DOZJiHMtIQ2M</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://www.youtube.com/watch?v=3DOZ=
JiHMtIQ2M" rel=3D"noreferrer" target=3D"_blank">https://www.youtube.com/wat=
ch?v=3DOZJiHMtIQ2M</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. _gfxstream-enabled rutabaga:<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://crosvm.dev/book/appendix/rutabag=
a_gfx.html" rel=3D"noreferrer" target=3D"_blank">https://crosvm.dev/book/ap=
pendix/rutabaga_gfx.html</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://crosvm.dev/book/appendix/rut=
abaga_gfx.html" rel=3D"noreferrer" target=3D"_blank">https://crosvm.dev/boo=
k/appendix/rutabaga_gfx.html</a>&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0You have different links for &quot;rutabaga_gfx&quo=
t; and &quot;gfxstream-enabled<br>
&gt;=C2=A0 =C2=A0 =C2=A0rutabaga&quot;, but I think you only need one.<br>
&gt; <br>
&gt; <br>
&gt; Done.=C2=A0 Didn&#39;t resend the entire patch series (to avoid spammi=
ng list), <br>
&gt; just did &quot;in-reply-to&quot;.=C2=A0 The change is also available a=
t:<br>
&gt; <br>
&gt; <a href=3D"https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstrea=
m/-/commits/qemu-gfxstream-v8" rel=3D"noreferrer" target=3D"_blank">https:/=
/gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstr=
eam-v8</a> &lt;<a href=3D"https://gitlab.freedesktop.org/gurchetansingh/qem=
u-gfxstream/-/commits/qemu-gfxstream-v8" rel=3D"noreferrer" target=3D"_blan=
k">https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/q=
emu-gfxstream-v8</a>&gt;<br>
<br>
The patch series now looks good so I finally decided to try this patch <br>
series, but I couldn&#39;t get it work.<br>
<br>
I noticed gfxstream has page size hardcoded as 4 KiB, which broke my <br>
setup on M2 MacBook Air (running Asahi Linux) that has 16 KiB page. You <br=
>
may add code to check host page size and to report an error if it&#39;s not=
 <br>
4 KiB to virtio-gpu-rutabaga, but I think it&#39;s trivial to fix gfxstream=
 <br>
to query page size at runtime as QEMU and Rutabaga does so I hope you to <b=
r>
do so. For testing purpose, I have replaced it with 16 KiB on my setup.<br>=
</blockquote><div><br></div><div>Good catch, the fix to the 16KiB was merge=
d today and is in gfxstream ToT right now.</div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
I also found some bugs on QEMU side so I added comments to respective <br>
patches.<br>
<br>
Below is the logs from my last attempt of running vkgears:<br>
<br>
$ VK_LOADER_DEBUG=3Dall demos/build/src/vulkan/vkgears<br>
INFO:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Vulkan Loader Version =
1.3.243<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Searching for layer manifes=
t files<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0In following l=
ocations:<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /var/h=
ome/person/.config/vulkan/implicit_layer.d<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /etc/x=
dg/vulkan/implicit_layer.d<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /etc/v=
ulkan/implicit_layer.d<br>
LAYER: <br>
/var/home/person/.local/share/vulkan/implicit_layer.d<br>
LAYER: <br>
/var/home/person/.local/share/flatpak/exports/share/vulkan/implicit_layer.d=
<br>
LAYER: <br>
/var/lib/flatpak/exports/share/vulkan/implicit_layer.d<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /usr/l=
ocal/share/vulkan/implicit_layer.d<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /usr/s=
hare/vulkan/implicit_layer.d<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Found the foll=
owing files:<br>
LAYER: <br>
/usr/share/vulkan/implicit_layer.d/VkLayer_MESA_device_select.json<br>
INFO:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Found manifest file <b=
r>
/usr/share/vulkan/implicit_layer.d/VkLayer_MESA_device_select.json (file <b=
r>
version &quot;1.0.0&quot;)<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Searching for layer manifes=
t files<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0In following l=
ocations:<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /var/h=
ome/person/.config/vulkan/explicit_layer.d<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /etc/x=
dg/vulkan/explicit_layer.d<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /etc/v=
ulkan/explicit_layer.d<br>
LAYER: <br>
/var/home/person/.local/share/vulkan/explicit_layer.d<br>
LAYER: <br>
/var/home/person/.local/share/flatpak/exports/share/vulkan/explicit_layer.d=
<br>
LAYER: <br>
/var/lib/flatpak/exports/share/vulkan/explicit_layer.d<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /usr/l=
ocal/share/vulkan/explicit_layer.d<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /usr/s=
hare/vulkan/explicit_layer.d<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Found no files=
<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Searching for driver manife=
st files<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 In following locati=
ons:<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/var/h=
ome/person/.config/vulkan/icd.d<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/etc/x=
dg/vulkan/icd.d<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/etc/v=
ulkan/icd.d<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/var/h=
ome/person/.local/share/vulkan/icd.d<br>
DRIVER: <br>
/var/home/person/.local/share/flatpak/exports/share/vulkan/icd.d<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/var/l=
ib/flatpak/exports/share/vulkan/icd.d<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/usr/l=
ocal/share/vulkan/icd.d<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/usr/s=
hare/vulkan/icd.d<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Found the following=
 files:<br>
DRIVER: <br>
/usr/local/share/vulkan/icd.d/cereal_icd.aarch64.json<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/usr/s=
hare/vulkan/icd.d/broadcom_icd.aarch64.json<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/usr/s=
hare/vulkan/icd.d/freedreno_icd.aarch64.json<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/usr/s=
hare/vulkan/icd.d/lvp_icd.aarch64.json<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/usr/s=
hare/vulkan/icd.d/panfrost_icd.aarch64.json<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/usr/s=
hare/vulkan/icd.d/radeon_icd.aarch64.json<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Found ICD manifest file <br=
>
/usr/local/share/vulkan/icd.d/cereal_icd.aarch64.json, version &quot;1.0.0&=
quot;<br>
DEBUG | DRIVER:=C2=A0 =C2=A0Searching for ICD drivers named <br>
/usr/local/lib64/libvulkan_cereal.so<br>
[VirtGpuDevice.cpp(71)]<br>
[prio 6] virtgpu backend not enabling <br>
VIRTGPU_PARAM_CREATE_GUEST_HANDLE[AndroidHealthMonitor.cpp(275)]<br>
[prio 4] HealthMonitor disabled. Returning nullptrI0818 21:00:07.980257 <br=
>
154451 IntelDrmDecoder.cpp:38] IntelDrmDecoder created for context 2<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Found ICD manifest file <br=
>
/usr/share/vulkan/icd.d/broadcom_icd.aarch64.json, version &quot;1.0.0&quot=
;<br>
DEBUG | DRIVER:=C2=A0 =C2=A0Searching for ICD drivers named <br>
/usr/lib64/libvulkan_broadcom.so<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Found ICD manifest file <br=
>
/usr/share/vulkan/icd.d/freedreno_icd.aarch64.json, version &quot;1.0.0&quo=
t;<br>
DEBUG | DRIVER:=C2=A0 =C2=A0Searching for ICD drivers named <br>
/usr/lib64/libvulkan_freedreno.so<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Found ICD manifest file <br=
>
/usr/share/vulkan/icd.d/lvp_icd.aarch64.json, version &quot;1.0.0&quot;<br>
DEBUG | DRIVER:=C2=A0 =C2=A0Searching for ICD drivers named <br>
/usr/lib64/libvulkan_lvp.so<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Found ICD manifest file <br=
>
/usr/share/vulkan/icd.d/panfrost_icd.aarch64.json, version &quot;1.0.0&quot=
;<br>
DEBUG | DRIVER:=C2=A0 =C2=A0Searching for ICD drivers named <br>
/usr/lib64/libvulkan_panfrost.so<br>
DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Found ICD manifest file <br=
>
/usr/share/vulkan/icd.d/radeon_icd.aarch64.json, version &quot;1.0.0&quot;<=
br>
DEBUG | DRIVER:=C2=A0 =C2=A0Searching for ICD drivers named <br>
/usr/lib64/libvulkan_radeon.so<br>
DEBUG | LAYER:=C2=A0 =C2=A0 Loading layer library libVkLayer_MESA_device_se=
lect.so<br>
INFO | LAYER:=C2=A0 =C2=A0 =C2=A0Insert instance layer &quot;VK_LAYER_MESA_=
device_select&quot; <br>
(libVkLayer_MESA_device_select.so)<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vkCreateInstance layer call=
stack setup to:<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Applicatio=
n&gt;<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0||<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Loader&gt;=
<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0||<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VK_LAYER_MESA_=
device_select<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0Type: Implicit<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0Disable Env Var:=C2=A0 NODEVICE_SELECT<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0Manifest: <br>
/usr/share/vulkan/implicit_layer.d/VkLayer_MESA_device_select.json<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0Library:=C2=A0 libVkLayer_MESA_device_select.so<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0||<br>
LAYER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Drivers&gt=
;<br>
I0818 21:00:08.014896=C2=A0 154451 VkDecoderGlobalState.cpp:443] Creating <=
br>
Vulkan instance for app: vkgears<br>
INFO | DRIVER:=C2=A0 =C2=A0 linux_read_sorted_physical_devices:<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Original order:<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0] ll=
vmpipe (LLVM 16.0.6, 128 bits)<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[1] ll=
vmpipe (LLVM 15.0.7, 128 bits)<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Sorted order:<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0] ll=
vmpipe (LLVM 15.0.7, 128 bits)<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[1] ll=
vmpipe (LLVM 16.0.6, 128 bits)<br>
INFO | DRIVER:=C2=A0 =C2=A0 linux_read_sorted_physical_devices:<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Original order:<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0] ll=
vmpipe (LLVM 16.0.6, 128 bits)<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[1] ll=
vmpipe (LLVM 15.0.7, 128 bits)<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Sorted order:<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0] ll=
vmpipe (LLVM 15.0.7, 128 bits)<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[1] ll=
vmpipe (LLVM 16.0.6, 128 bits)<br>
DEBUG | DRIVER:=C2=A0 =C2=A0Copying old device 0 into new device 0<br>
DEBUG | DRIVER:=C2=A0 =C2=A0Copying old device 1 into new device 1<br>
INFO | DRIVER:=C2=A0 =C2=A0 linux_read_sorted_physical_devices:<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Original order:<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0] ll=
vmpipe (LLVM 16.0.6, 128 bits)<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[1] ll=
vmpipe (LLVM 15.0.7, 128 bits)<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Sorted order:<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0] ll=
vmpipe (LLVM 15.0.7, 128 bits)<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[1] ll=
vmpipe (LLVM 16.0.6, 128 bits)<br>
DEBUG | DRIVER:=C2=A0 =C2=A0Copying old device 0 into new device 0<br>
DEBUG | DRIVER:=C2=A0 =C2=A0Copying old device 1 into new device 1<br>
INFO | DRIVER:=C2=A0 =C2=A0 linux_read_sorted_physical_devices:<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Original order:<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0] ll=
vmpipe (LLVM 16.0.6, 128 bits)<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[1] ll=
vmpipe (LLVM 15.0.7, 128 bits)<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Sorted order:<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0] ll=
vmpipe (LLVM 15.0.7, 128 bits)<br>
INFO | DRIVER:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[1] ll=
vmpipe (LLVM 16.0.6, 128 bits)<br>
DEBUG | DRIVER:=C2=A0 =C2=A0Copying old device 0 into new device 0<br>
DEBUG | DRIVER:=C2=A0 =C2=A0Copying old device 1 into new device 1<br>
ERROR:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 loader_validate_device_exte=
nsions: Device extension <br>
VK_KHR_swapchain not supported by selected physical device or enabled</bloc=
kquote><div><br></div><div>Yeah, any non-headless Linux tests are unlikely =
to work.=C2=A0 Maybe in a future gfxstream release, since our focus is of c=
ourse on Android and getting Vulkan in QEMU in general.=C2=A0=C2=A0</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"> <br>
layers.<br>
ERROR:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vkCreateDevice: Failed to v=
alidate extensions in list<br>
ERROR:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vkGetDeviceQueue2: Invalid =
device <br>
[VUID-vkGetDeviceQueue2-device-parameter]<br>
Aborted (core dumped)<br>
</blockquote></div></div>

--000000000000fb04e206033c69fb--

