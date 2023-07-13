Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A70C7515D1
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 03:29:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJl8g-0003oi-Br; Wed, 12 Jul 2023 21:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qJl8e-0003oa-Pq
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 21:29:00 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qJl8Y-0007ai-VK
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 21:29:00 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3110ab7110aso269397f8f.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 18:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1689211733; x=1691803733;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qzqPOiLha8RT8FHc/4gP4NjC6Nf5MRdIaS6qWzbdbHA=;
 b=NYwaHwZIz3cfUR9Dvx29u/8k6JGzHCtxnPYS5ZMSODTID7anGYspqbu+6g8jSYd1R3
 /H9ZHSs01V5sgK9LFTAXas0q4D5GZYH+Z0M8+gxTaihm+jFph69KmGkrV52w7BHEyi30
 gOXls85MPATuZ0i87yHlSNyce+H6vSAtK4H3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689211733; x=1691803733;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qzqPOiLha8RT8FHc/4gP4NjC6Nf5MRdIaS6qWzbdbHA=;
 b=k8zVygtyos8AqzfugLKaVUN2taYLPlAJUm24lF1LLLU9dcznUMvHjAUhPpZAgzkuKn
 OWsfl/1UNusINH2xTYJcGL/Btfx1VSoFpVBRGG/aTItHA5SFp+jFGeKuTyOPGX2mRZZ+
 cxq6aQ3zEiUoG/zW1DRxJ1we7/veZ0F2GL4RrROKogbcUwkPFoEf4kIrEsRAmjCehvnP
 BqhFeWIP95T/EwyYUQme70mTMsVvc+2/iHmrB5My/L/Oj1vpS2MPI62nsDDoNDdXd05M
 L86Z30uL5xuHoQTNnXHUFSPOJ8LGZY9n+n0nsnLdwkHuf6YDNhNZkTPHZqMR+ETXYPFg
 0X5A==
X-Gm-Message-State: ABy/qLYAKhyPYDbTc3WI6DgDCS24cvHAMzF7I9uCojUOHDGZSRwxmF6f
 Wg3V6M/AMbKIR1TnEiKtz+ipII4qSf7WgV0+pa3SSA==
X-Google-Smtp-Source: APBJJlEEbq4bcGCItcHPSW+p3ZbhnO6mDLtdtL4YQbLWZMQprnOr0C777dkk1VhdF4/eWGW442ZcYA==
X-Received: by 2002:a5d:498d:0:b0:314:13d8:8ae7 with SMTP id
 r13-20020a5d498d000000b0031413d88ae7mr135883wrq.26.1689211733335; 
 Wed, 12 Jul 2023 18:28:53 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com.
 [209.85.208.42]) by smtp.gmail.com with ESMTPSA id
 se18-20020a170906ce5200b0099329b3ab67sm3236871ejb.71.2023.07.12.18.28.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 18:28:53 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-51e55517de3so3743a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 18:28:52 -0700 (PDT)
X-Received: by 2002:a50:d755:0:b0:50b:f6ce:2f3d with SMTP id
 i21-20020a50d755000000b0050bf6ce2f3dmr236351edj.0.1689211732465; Wed, 12 Jul
 2023 18:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230711025649.708-1-gurchetansingh@chromium.org>
 <20230711025649.708-10-gurchetansingh@chromium.org>
 <38518b56-ff2b-f8ed-c7d7-fe0653c5d825@gmail.com>
In-Reply-To: <38518b56-ff2b-f8ed-c7d7-fe0653c5d825@gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed, 12 Jul 2023 18:28:39 -0700
X-Gmail-Original-Message-ID: <CAAfnVBmvdwRJgHtdfNcerT5ewcvKUvMLAs0TETVz=pdzCTj6hg@mail.gmail.com>
Message-ID: <CAAfnVBmvdwRJgHtdfNcerT5ewcvKUvMLAs0TETVz=pdzCTj6hg@mail.gmail.com>
Subject: Re: [PATCH v1 9/9] docs/system: add basic virtio-gpu documentation
To: Akihiko Odaki <akihiko.odaki@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@redhat.com, 
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org, 
 shentey@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=gurchetansingh@chromium.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jul 12, 2023 at 2:40=E2=80=AFPM Akihiko Odaki <akihiko.odaki@gmail.=
com> wrote:
>
> On 2023/07/11 11:56, Gurchetan Singh wrote:
> > This adds basic documentation for virtio-gpu.
>
> Thank you for adding documentation for other backends too. I have been
> asked how virtio-gpu works so many times and always had to explain by
> myself though Gerd does have a nice article.* This documentation will hel=
p.
>
> * https://www.kraxel.org/blog/2021/05/virtio-gpu-qemu-graphics-update/
>
> >
> > Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> > ---
> >   docs/system/device-emulation.rst   |  1 +
> >   docs/system/devices/virtio-gpu.rst | 80 +++++++++++++++++++++++++++++=
+
> >   2 files changed, 81 insertions(+)
> >   create mode 100644 docs/system/devices/virtio-gpu.rst
> >
> > diff --git a/docs/system/device-emulation.rst b/docs/system/device-emul=
ation.rst
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
> > diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/v=
irtio-gpu.rst
> > new file mode 100644
> > index 0000000000..2426039540
> > --- /dev/null
> > +++ b/docs/system/devices/virtio-gpu.rst
> > @@ -0,0 +1,80 @@
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
> > +There are many virtio-gpu device variants, listed below:
> > +
> > + * ``virtio-vga``
> > + * ``virtio-gpu-pci``
> > + * ``virtio-vga-gl``
> > + * ``virtio-gpu-gl-pci``
> > + * ``virtio-vga-rutabaga``
> > + * ``virtio-gpu-rutabaga-pci``
> > + * ``vhost-user-vga``
> > + * ``vhost-user-gl-pci``
>
> > +
> > +QEMU provides a 2D virtio-gpu backend, and two accelerated backends:
> > +virglrenderer ('gl' device label) and rutabaga_gfx ('rutabaga' device
> > +label).  There is also a vhost-user backend that runs the 2D device > =
+in a separate process.  Each device type as VGA or PCI variant.  This
> > +document uses the PCI variant in examples.
>
> I suggest to replace "2D device" with "graphics stack"; vhost-user works
> with 3D too. It's also slightly awkward to say a device runs in a
> separate process as some portion of device emulation always stuck in
> QEMU. In my opinion, the point of vhost-user backend is to isolate the
> gigantic graphics stack so let's put this phrase.
>
> I also have a bit different understanding regarding virtio-gpu variants.
> First, the variants can be classified into VGA and non-VGA ones. The VGA
> ones are prefixed with virtio-vga or vhost-user-vga while the non-VGA
> ones are prefixed with virtio-gpu or vhost-user-gpu.
>
> The VGA ones always use PCI interface, but for the non-VGA ones, you can
> further pick simple MMIO or PCI. For MMIO, you can suffix the device
> name with -device though vhost-user-gpu apparently does not support
> MMIO. For PCI, you can suffix it with -pci. Without these suffixes, the
> platform default will be chosen.
>
> Since enumerating all variants will result in a long list, you may
> provide abstract syntaxes like the following for this explanation:
>
> * virtio-vga[-BACKEND]
> * virtio-gpu[-BACKEND][-INTERFACE]
> * vhost-user-vga
> * vhost-user-pci
>
> > +
> > +virtio-gpu 2d
> > +-------------
> > +
> > +The default 2D mode uses a guest software renderer (llvmpipe, lavapipe=
,
> > +Swiftshader) to provide the OpenGL/Vulkan implementations.
>
> It's certainly possible to use virtio-gpu without software
> OpenGL/Vulkan. A major example is Windows; its software renderer is
> somewhat limited in my understanding.
>
> My suggestion:
> The default 2D backend only performs 2D operations. The guest needs to
> employ a software renderer for 3D graphics.
>
> It's also better to provide links for the renderers. Apparently lavapipe
> does not have a dedicated documentation, so you may add a link for Mesa
> and mention them like:
> LLVMpipe and Lavapipe included in `Mesa`_, or `SwiftShader`_
>
> And I think it will be helpful to say LLVMpipe and Lavapipe work out of
> box on typical modern Linux distributions as that should be what people
> care.
>
> > +
> > +.. parsed-literal::
> > +    -device virtio-gpu-pci
> > +
> > +virtio-gpu virglrenderer
> > +------------------------
> > +
> > +When using virgl accelerated graphics mode, OpenGL API calls are trans=
lated
> > +into an intermediate representation (see `Gallium3D`_). The intermedia=
te
> > +representation is communicated to the host and the `virglrenderer`_ li=
brary
> > +on the host translates the intermediate representation back to OpenGL =
API
> > +calls.
> It should be mentioned that the translation occurs in the guest side,
> and the guest side component is included in Linux distributions as like
> LLVMpipe and Lavapipe are.
>
> > +
> > +.. parsed-literal::
> > +    -device virtio-gpu-gl-pci
> > +
> > +.. _Gallium3D: https://www.freedesktop.org/wiki/Software/gallium/
> > +.. _virglrenderer: https://gitlab.freedesktop.org/virgl/virglrenderer/
> > +
> > +virtio-gpu rutabaga
> > +-------------------
> > +
> > +virtio-gpu can also leverage `rutabaga_gfx`_ to provide `gfxstream`_ r=
endering
> > +and `Wayland display passthrough`_.  With the gfxstream rendering mode=
, GLES
> > +and Vulkan calls are forwarded directly to the host with minimal modif=
ication.
>
> I find the description included in the PDF you posted on GitLab* quite a
> useful so I suggest to incorporate its content.
>
> You may omit the overall design diagram as it mentions guest side and
> Rutabaga details and crosvm and may be confusing for QEMU users.
>
> The detailed commands for building dependencies may also be omitted and
> instead point to the documentation of respective projects as they should
> be subject to future changes.
>
> It's unfortunate that rutabaga_gfx and goldfish-opengl do not come with
> proper documentations (and I wonder rutabaga_gfx still need a hack
> mentioned in the PDF). For now the procedure to build them should be
> included in the documentation since it will take hours to figure out for
> a first-time reader otherwise.
>
> *
> https://gitlab.com/qemu-project/qemu/uploads/f960580bf0f19077e0330960b4a3=
152e/gfxstream_+_QEMU_setup__public_.pdf

The new doc in https://gitlab.com/qemu-project/qemu/-/issues/1611#note_1464=
562962
doesn't require the hack patch.  I'll incorporate your other
suggestions in v2.



> > +
> > +Please refer the `crosvm book`_ on how to setup the guest for Wayland
> > +passthrough (QEMU uses the same implementation).
> > +
> > +This device does require host blob support (``hostmem`` field below), =
but not
> > +all capsets (``capset_names`` below) have to enabled when starting the=
 device.
> > +
> > +.. parsed-literal::
> > +    -device virtio-gpu-rutabaga-pci,capset_names=3Dgfxstream-vulkan:cr=
oss-domain,\\
> > +      hostmem=3D8G,wayland_socket_path=3D"$XDG_RUNTIME_DIR/$WAYLAND_DI=
SPLAY"
> > +
> > +.. _rutabaga_gfx: https://github.com/google/crosvm/blob/main/rutabaga_=
gfx/ffi/src/include/rutabaga_gfx_ffi.h
> > +.. _gfxstream: https://android.googlesource.com/platform/hardware/goog=
le/gfxstream/
> > +.. _Wayland display passthrough: https://www.youtube.com/watch?v=3DOZJ=
iHMtIQ2M
> > +.. _crosvm book: https://crosvm.dev/book/devices/wayland.html

