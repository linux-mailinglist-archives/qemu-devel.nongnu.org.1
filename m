Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BE47817A1
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 08:15:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXFDT-0006Z0-TP; Sat, 19 Aug 2023 02:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qXFDO-0006XQ-NY
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 02:13:40 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qXFDK-0006ej-PF
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 02:13:38 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6887bc25e6bso1366173b3a.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 23:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692425613; x=1693030413;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h7DBVl+wBkKK9W5NvkJ1/31BUcivFg9Ul4JoQf6QoQA=;
 b=semrKjiOO0RteFO2SSqAv+NZS+S8Hs60H6aqRwvbYJObtG0oYrogSzIBYD0XHg037V
 1IU0UifqQUEfZ6kUGA07Bt427IKiL4bUkoSbO6Al65C5XFl7gNyx4GaU3kR7jNsC4TaJ
 eeCc8it7Q1I4I962SNXSAO5wFidzVXdxzodiQ6oEQtfH5Ev1IjRvF82TSynV714tq6Db
 TI+d/FfBo+M3zRlkz8Gt/kYPKE7JZo+MpFNm8gYxifIAZbKO6KuqoZSs6+04K4t0iBQu
 HNgqaNBwCVUQoHeTwsciCkzUmFp7Ref3KmiZb0kVrelaG+9GH1CvjEgYL2iZ+4AWWoCB
 6JVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692425613; x=1693030413;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h7DBVl+wBkKK9W5NvkJ1/31BUcivFg9Ul4JoQf6QoQA=;
 b=Xj+d5+GGk2eM6Qz0Rj0ycrVpmd8CIM9+mKNra5deByMg9IctVVxH40Bn2jt5ZYPTVA
 F2K9xvXipqkghwNdGCwLqlPdEt9qAWgeMGp2z/s+PR2JsmqvGzLGE/3KJYTT3fyXazG6
 s8n4foUJr6FeLOgtqlXxFGkEOcsF4GJ75GBnaGDN2FcTzXK/+gSFQnlB4OSsaBi4sPaN
 ciePU1AmyFhbV7Ji76c50cW7b1ipzez9u/allEG9frzQFQigjHKLBaPb1Th0zAttGZzi
 1PbpTXAiwuID1iYBeMMYNpmtU/OvCCZAbU9lCZVEs+h2AwGWn/ODeI7qgDi94uj7q7eh
 GSsA==
X-Gm-Message-State: AOJu0YzJDqoPo9DeVN2YZ7yOesoa4Pno4pn2mS/erseL48Mv0ooGDml7
 GBKznoT7LDonZD4+q1uRvcw=
X-Google-Smtp-Source: AGHT+IHZ6RLfR3rf/WtqVsGsBv21AZuPPG22cS3SdYRdaFvPseEp0OCYgTODIVhoY/wC+O/D6rm+7w==
X-Received: by 2002:a05:6a00:b45:b0:686:de6c:a9e5 with SMTP id
 p5-20020a056a000b4500b00686de6ca9e5mr1444428pfo.31.1692425612722; 
 Fri, 18 Aug 2023 23:13:32 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 x23-20020a62fb17000000b0064928cb5f03sm2482171pfm.69.2023.08.18.23.13.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 23:13:32 -0700 (PDT)
Message-ID: <5b5a8ee5-5938-4fbe-8fc7-9c30bb042da7@gmail.com>
Date: Sat, 19 Aug 2023 15:13:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] docs/system: add basic virtio-gpu documentation
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, kraxel@redhat.com,
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org
References: <20230817022322.466-1-gurchetansingh@google.com>
 <20230817022322.466-10-gurchetansingh@google.com>
 <1281e8f6-f91a-4ced-b5d1-773370db3eef@gmail.com>
 <CAAfnVBmmwWGTu0-6efVDqRRu9jvKmiboPzGtprm2h=U5XXj0Tw@mail.gmail.com>
 <fcf79be7-5cf7-4c74-844c-9812f0b31f4a@gmail.com>
 <CAAfnVBmSXOxHqO+w59XY57DTfqEQwfVprSWXEbPEhP7eTrO0dA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <CAAfnVBmSXOxHqO+w59XY57DTfqEQwfVprSWXEbPEhP7eTrO0dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2023/08/19 10:17, Gurchetan Singh wrote:
> 
> 
> On Fri, Aug 18, 2023 at 5:08 AM Akihiko Odaki <akihiko.odaki@gmail.com 
> <mailto:akihiko.odaki@gmail.com>> wrote:
> 
>     On 2023/08/18 8:47, Gurchetan Singh wrote:
>      >
>      >
>      > On Wed, Aug 16, 2023 at 10:28 PM Akihiko Odaki
>     <akihiko.odaki@gmail.com <mailto:akihiko.odaki@gmail.com>
>      > <mailto:akihiko.odaki@gmail.com
>     <mailto:akihiko.odaki@gmail.com>>> wrote:
>      >
>      >     On 2023/08/17 11:23, Gurchetan Singh wrote:
>      >      > From: Gurchetan Singh <gurchetansingh@chromium.org
>     <mailto:gurchetansingh@chromium.org>
>      >     <mailto:gurchetansingh@chromium.org
>     <mailto:gurchetansingh@chromium.org>>>
>      >      >
>      >      > This adds basic documentation for virtio-gpu.
>      >      >
>      >      > Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>
>      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>>
>      >      > Signed-off-by: Gurchetan Singh
>     <gurchetansingh@chromium.org <mailto:gurchetansingh@chromium.org>
>      >     <mailto:gurchetansingh@chromium.org
>     <mailto:gurchetansingh@chromium.org>>>
>      >      > Tested-by: Alyssa Ross <hi@alyssa.is <mailto:hi@alyssa.is>
>     <mailto:hi@alyssa.is <mailto:hi@alyssa.is>>>
>      >      > Tested-by: Emmanouil Pitsidianakis
>      >     <manos.pitsidianakis@linaro.org
>     <mailto:manos.pitsidianakis@linaro.org>
>     <mailto:manos.pitsidianakis@linaro.org
>     <mailto:manos.pitsidianakis@linaro.org>>>
>      >      > Reviewed-by: Emmanouil Pitsidianakis
>      >     <manos.pitsidianakis@linaro.org
>     <mailto:manos.pitsidianakis@linaro.org>
>     <mailto:manos.pitsidianakis@linaro.org
>     <mailto:manos.pitsidianakis@linaro.org>>>
>      >      > ---
>      >      > v2: - Incorporated suggestions by Akihiko Odaki
>      >      >      - Listed the currently supported capset_names (Bernard)
>      >      >
>      >      > v3: - Incorporated suggestions by Akihiko Odaki and Alyssa
>     Ross
>      >      >
>      >      > v4: - Incorporated suggestions by Akihiko Odaki
>      >      >
>      >      > v5: - Removed pci suffix from examples
>      >      >      - Verified that -device virtio-gpu-rutabaga works. 
>     Strangely
>      >      >        enough, I don't remember changing anything, and I
>     remember
>      >      >        it not working.  I did rebase to top of tree though.
>      >      >      - Fixed meson examples in crosvm docs
>      >      >
>      >      >   docs/system/device-emulation.rst   |   1 +
>      >      >   docs/system/devices/virtio-gpu.rst | 113
>      >     +++++++++++++++++++++++++++++
>      >      >   2 files changed, 114 insertions(+)
>      >      >   create mode 100644 docs/system/devices/virtio-gpu.rst
>      >      >
>      >      > diff --git a/docs/system/device-emulation.rst
>      >     b/docs/system/device-emulation.rst
>      >      > index 4491c4cbf7..1167f3a9f2 100644
>      >      > --- a/docs/system/device-emulation.rst
>      >      > +++ b/docs/system/device-emulation.rst
>      >      > @@ -91,6 +91,7 @@ Emulated Devices
>      >      >      devices/nvme.rst
>      >      >      devices/usb.rst
>      >      >      devices/vhost-user.rst
>      >      > +   devices/virtio-gpu.rst
>      >      >      devices/virtio-pmem.rst
>      >      >      devices/vhost-user-rng.rst
>      >      >      devices/canokey.rst
>      >      > diff --git a/docs/system/devices/virtio-gpu.rst
>      >     b/docs/system/devices/virtio-gpu.rst
>      >      > new file mode 100644
>      >      > index 0000000000..8c5c708272
>      >      > --- /dev/null
>      >      > +++ b/docs/system/devices/virtio-gpu.rst
>      >      > @@ -0,0 +1,113 @@
>      >      > +..
>      >      > +   SPDX-License-Identifier: GPL-2.0
>      >      > +
>      >      > +virtio-gpu
>      >      > +==========
>      >      > +
>      >      > +This document explains the setup and usage of the
>     virtio-gpu device.
>      >      > +The virtio-gpu device paravirtualizes the GPU and display
>      >     controller.
>      >      > +
>      >      > +Linux kernel support
>      >      > +--------------------
>      >      > +
>      >      > +virtio-gpu requires a guest Linux kernel built with the
>      >      > +``CONFIG_DRM_VIRTIO_GPU`` option.
>      >      > +
>      >      > +QEMU virtio-gpu variants
>      >      > +------------------------
>      >      > +
>      >      > +QEMU virtio-gpu device variants come in the following form:
>      >      > +
>      >      > + * ``virtio-vga[-BACKEND]``
>      >      > + * ``virtio-gpu[-BACKEND][-INTERFACE]``
>      >      > + * ``vhost-user-vga``
>      >      > + * ``vhost-user-pci``
>      >      > +
>      >      > +**Backends:** QEMU provides a 2D virtio-gpu backend, and two
>      >     accelerated
>      >      > +backends: virglrenderer ('gl' device label) and rutabaga_gfx
>      >     ('rutabaga'
>      >      > +device label).  There is a vhost-user backend that runs the
>      >     graphics stack
>      >      > +in a separate process for improved isolation.
>      >      > +
>      >      > +**Interfaces:** QEMU further categorizes virtio-gpu device
>      >     variants based
>      >      > +on the interface exposed to the guest. The interfaces can be
>      >     classified
>      >      > +into VGA and non-VGA variants. The VGA ones are prefixed with
>      >     virtio-vga
>      >      > +or vhost-user-vga while the non-VGA ones are prefixed with
>      >     virtio-gpu or
>      >      > +vhost-user-gpu.
>      >      > +
>      >      > +The VGA ones always use the PCI interface, but for the
>     non-VGA
>      >     ones, the
>      >      > +user can further pick between MMIO or PCI. For MMIO, the user
>      >     can suffix
>      >      > +the device name with -device, though vhost-user-gpu does not
>      >     support MMIO.
>      >      > +For PCI, the user can suffix it with -pci. Without these
>      >     suffixes, the
>      >      > +platform default will be chosen.
>      >      > +
>      >      > +virtio-gpu 2d
>      >      > +-------------
>      >      > +
>      >      > +The default 2D backend only performs 2D operations. The guest
>      >     needs to
>      >      > +employ a software renderer for 3D graphics.
>      >      > +
>      >      > +Typically, the software renderer is provided by `Mesa`_ or
>      >     `SwiftShader`_.
>      >      > +Mesa's implementations (LLVMpipe, Lavapipe and virgl
>     below) work
>      >     out of box
>      >      > +on typical modern Linux distributions.
>      >      > +
>      >      > +.. parsed-literal::
>      >      > +    -device virtio-gpu
>      >      > +
>      >      > +.. _Mesa: https://www.mesa3d.org/
>     <https://www.mesa3d.org/> <https://www.mesa3d.org/
>     <https://www.mesa3d.org/>>
>      >      > +.. _SwiftShader: https://github.com/google/swiftshader
>     <https://github.com/google/swiftshader>
>      >     <https://github.com/google/swiftshader
>     <https://github.com/google/swiftshader>>
>      >      > +
>      >      > +virtio-gpu virglrenderer
>      >      > +------------------------
>      >      > +
>      >      > +When using virgl accelerated graphics mode in the guest,
>     OpenGL
>      >     API calls
>      >      > +are translated into an intermediate representation (see
>      >     `Gallium3D`_). The
>      >      > +intermediate representation is communicated to the host
>     and the
>      >      > +`virglrenderer`_ library on the host translates the
>     intermediate
>      >      > +representation back to OpenGL API calls.
>      >      > +
>      >      > +.. parsed-literal::
>      >      > +    -device virtio-gpu-gl
>      >      > +
>      >      > +.. _Gallium3D:
>      > https://www.freedesktop.org/wiki/Software/gallium/
>     <https://www.freedesktop.org/wiki/Software/gallium/>
>      >     <https://www.freedesktop.org/wiki/Software/gallium/
>     <https://www.freedesktop.org/wiki/Software/gallium/>>
>      >      > +.. _virglrenderer:
>      > https://gitlab.freedesktop.org/virgl/virglrenderer/
>     <https://gitlab.freedesktop.org/virgl/virglrenderer/>
>      >     <https://gitlab.freedesktop.org/virgl/virglrenderer/
>     <https://gitlab.freedesktop.org/virgl/virglrenderer/>>
>      >      > +
>      >      > +virtio-gpu rutabaga
>      >      > +-------------------
>      >      > +
>      >      > +virtio-gpu can also leverage `rutabaga_gfx`_ to provide
>     `gfxstream`_
>      >      > +rendering and `Wayland display passthrough`_.  With the
>      >     gfxstream rendering
>      >      > +mode, GLES and Vulkan calls are forwarded to the host
>     with minimal
>      >      > +modification.
>      >      > +
>      >      > +The crosvm book provides directions on how to build a
>      >     `gfxstream-enabled
>      >      > +rutabaga`_ and launch a `guest Wayland proxy`_.
>      >      > +
>      >      > +This device does require host blob support (``hostmem`` field
>      >     below). The
>      >      > +``hostmem`` field specifies the size of virtio-gpu host
>     memory
>      >     window.
>      >      > +This is typically between 256M and 8G.
>      >      > +
>      >      > +At least one capset (see colon separated ``capset_names``
>     below)
>      >     must be
>      >      > +specified when starting the device.  The currently supported
>      >      > +``capset_names`` are ``gfxstream-vulkan`` and
>     ``cross-domain``
>      >     on Linux
>      >      > +guests. For Android guests, ``gfxstream-gles`` is also
>     supported.
>      >      > +
>      >      > +The device will try to auto-detect the wayland socket
>     path if the
>      >      > +``cross-domain`` capset name is set.  The user may optionally
>      >     specify
>      >      > +``wayland_socket_path`` for non-standard paths.
>      >      > +
>      >      > +The ``wsi`` option can be set to ``surfaceless`` or
>     ``headless``.
>      >      > +Surfaceless doesn't create a native window surface, but does
>      >     copy from the
>      >      > +render target to the Pixman buffer if a virtio-gpu 2D
>     hypercall
>      >     is issued.
>      >      > +Headless is like surfaceless, but doesn't copy to the
>     Pixman buffer.
>      >      > +Surfaceless is the default if ``wsi`` is not specified.
>      >      > +
>      >      > +.. parsed-literal::
>      >      > +    -device
>      >     virtio-gpu-rutabaga,capset_names=gfxstream-vulkan:cross-domain,
>      >      > +
>      >     
>       hostmem=8G,wayland_socket_path=/tmp/nonstandard/mock_wayland.sock,
>      >      > +       wsi=headless
>      >      > +
>      >      > +.. _rutabaga_gfx:
>      >
>     https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/rutabaga_gfx_ffi.h <https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/rutabaga_gfx_ffi.h> <https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/rutabaga_gfx_ffi.h <https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/rutabaga_gfx_ffi.h>>
>      >      > +.. _gfxstream:
>      >
>     https://android.googlesource.com/platform/hardware/google/gfxstream/
>     <https://android.googlesource.com/platform/hardware/google/gfxstream/>
>      >   
>       <https://android.googlesource.com/platform/hardware/google/gfxstream/ <https://android.googlesource.com/platform/hardware/google/gfxstream/>>
>      >      > +.. _Wayland display passthrough:
>      > https://www.youtube.com/watch?v=OZJiHMtIQ2M
>     <https://www.youtube.com/watch?v=OZJiHMtIQ2M>
>      >     <https://www.youtube.com/watch?v=OZJiHMtIQ2M
>     <https://www.youtube.com/watch?v=OZJiHMtIQ2M>>
>      >      > +.. _gfxstream-enabled rutabaga:
>      > https://crosvm.dev/book/appendix/rutabaga_gfx.html
>     <https://crosvm.dev/book/appendix/rutabaga_gfx.html>
>      >     <https://crosvm.dev/book/appendix/rutabaga_gfx.html
>     <https://crosvm.dev/book/appendix/rutabaga_gfx.html>>
>      >
>      >     You have different links for "rutabaga_gfx" and
>     "gfxstream-enabled
>      >     rutabaga", but I think you only need one.
>      >
>      >
>      > Done.  Didn't resend the entire patch series (to avoid spamming
>     list),
>      > just did "in-reply-to".  The change is also available at:
>      >
>      >
>     https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstream-v8 <https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstream-v8> <https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstream-v8 <https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstream-v8>>
> 
>     The patch series now looks good so I finally decided to try this patch
>     series, but I couldn't get it work.
> 
>     I noticed gfxstream has page size hardcoded as 4 KiB, which broke my
>     setup on M2 MacBook Air (running Asahi Linux) that has 16 KiB page. You
>     may add code to check host page size and to report an error if it's not
>     4 KiB to virtio-gpu-rutabaga, but I think it's trivial to fix gfxstream
>     to query page size at runtime as QEMU and Rutabaga does so I hope
>     you to
>     do so. For testing purpose, I have replaced it with 16 KiB on my setup.
> 
> 
> Good catch, the fix to the 16KiB was merged today and is in gfxstream 
> ToT right now.

The fix is incomplete. There are a few other places that hardcodes page 
size, namely ANDROID_EMU_ADDRESS_SPACE_DEFAULT_PAGE_SIZE and 
ADDRESS_SPACE_GRAPHICS_PAGE_SIZE.

ANDROID_EMU_ADDRESS_SPACE_DEFAULT_PAGE_SIZE is used by no one so you can 
just remove it. ADDRESS_SPACE_GRAPHICS_PAGE_SIZE is actually in use and 
needs to be fixed.

It's also better to remove PAGE_SIZE definition from guest/meson.build 
just in case.

> 
> 
>     I also found some bugs on QEMU side so I added comments to respective
>     patches.
> 
>     Below is the logs from my last attempt of running vkgears:
> 
>     $ VK_LOADER_DEBUG=all demos/build/src/vulkan/vkgears
>     INFO:             Vulkan Loader Version 1.3.243
>     LAYER:            Searching for layer manifest files
>     LAYER:               In following locations:
>     LAYER:                  /var/home/person/.config/vulkan/implicit_layer.d
>     LAYER:                  /etc/xdg/vulkan/implicit_layer.d
>     LAYER:                  /etc/vulkan/implicit_layer.d
>     LAYER:
>     /var/home/person/.local/share/vulkan/implicit_layer.d
>     LAYER:
>     /var/home/person/.local/share/flatpak/exports/share/vulkan/implicit_layer.d
>     LAYER:
>     /var/lib/flatpak/exports/share/vulkan/implicit_layer.d
>     LAYER:                  /usr/local/share/vulkan/implicit_layer.d
>     LAYER:                  /usr/share/vulkan/implicit_layer.d
>     LAYER:               Found the following files:
>     LAYER:
>     /usr/share/vulkan/implicit_layer.d/VkLayer_MESA_device_select.json
>     INFO:             Found manifest file
>     /usr/share/vulkan/implicit_layer.d/VkLayer_MESA_device_select.json
>     (file
>     version "1.0.0")
>     LAYER:            Searching for layer manifest files
>     LAYER:               In following locations:
>     LAYER:                  /var/home/person/.config/vulkan/explicit_layer.d
>     LAYER:                  /etc/xdg/vulkan/explicit_layer.d
>     LAYER:                  /etc/vulkan/explicit_layer.d
>     LAYER:
>     /var/home/person/.local/share/vulkan/explicit_layer.d
>     LAYER:
>     /var/home/person/.local/share/flatpak/exports/share/vulkan/explicit_layer.d
>     LAYER:
>     /var/lib/flatpak/exports/share/vulkan/explicit_layer.d
>     LAYER:                  /usr/local/share/vulkan/explicit_layer.d
>     LAYER:                  /usr/share/vulkan/explicit_layer.d
>     LAYER:               Found no files
>     DRIVER:           Searching for driver manifest files
>     DRIVER:              In following locations:
>     DRIVER:                 /var/home/person/.config/vulkan/icd.d
>     DRIVER:                 /etc/xdg/vulkan/icd.d
>     DRIVER:                 /etc/vulkan/icd.d
>     DRIVER:                 /var/home/person/.local/share/vulkan/icd.d
>     DRIVER:
>     /var/home/person/.local/share/flatpak/exports/share/vulkan/icd.d
>     DRIVER:                 /var/lib/flatpak/exports/share/vulkan/icd.d
>     DRIVER:                 /usr/local/share/vulkan/icd.d
>     DRIVER:                 /usr/share/vulkan/icd.d
>     DRIVER:              Found the following files:
>     DRIVER:
>     /usr/local/share/vulkan/icd.d/cereal_icd.aarch64.json
>     DRIVER:               
>       /usr/share/vulkan/icd.d/broadcom_icd.aarch64.json
>     DRIVER:               
>       /usr/share/vulkan/icd.d/freedreno_icd.aarch64.json
>     DRIVER:                 /usr/share/vulkan/icd.d/lvp_icd.aarch64.json
>     DRIVER:               
>       /usr/share/vulkan/icd.d/panfrost_icd.aarch64.json
>     DRIVER:                 /usr/share/vulkan/icd.d/radeon_icd.aarch64.json
>     DRIVER:           Found ICD manifest file
>     /usr/local/share/vulkan/icd.d/cereal_icd.aarch64.json, version "1.0.0"
>     DEBUG | DRIVER:   Searching for ICD drivers named
>     /usr/local/lib64/libvulkan_cereal.so
>     [VirtGpuDevice.cpp(71)]
>     [prio 6] virtgpu backend not enabling
>     VIRTGPU_PARAM_CREATE_GUEST_HANDLE[AndroidHealthMonitor.cpp(275)]
>     [prio 4] HealthMonitor disabled. Returning nullptrI0818 21:00:07.980257
>     154451 IntelDrmDecoder.cpp:38] IntelDrmDecoder created for context 2
>     DRIVER:           Found ICD manifest file
>     /usr/share/vulkan/icd.d/broadcom_icd.aarch64.json, version "1.0.0"
>     DEBUG | DRIVER:   Searching for ICD drivers named
>     /usr/lib64/libvulkan_broadcom.so
>     DRIVER:           Found ICD manifest file
>     /usr/share/vulkan/icd.d/freedreno_icd.aarch64.json, version "1.0.0"
>     DEBUG | DRIVER:   Searching for ICD drivers named
>     /usr/lib64/libvulkan_freedreno.so
>     DRIVER:           Found ICD manifest file
>     /usr/share/vulkan/icd.d/lvp_icd.aarch64.json, version "1.0.0"
>     DEBUG | DRIVER:   Searching for ICD drivers named
>     /usr/lib64/libvulkan_lvp.so
>     DRIVER:           Found ICD manifest file
>     /usr/share/vulkan/icd.d/panfrost_icd.aarch64.json, version "1.0.0"
>     DEBUG | DRIVER:   Searching for ICD drivers named
>     /usr/lib64/libvulkan_panfrost.so
>     DRIVER:           Found ICD manifest file
>     /usr/share/vulkan/icd.d/radeon_icd.aarch64.json, version "1.0.0"
>     DEBUG | DRIVER:   Searching for ICD drivers named
>     /usr/lib64/libvulkan_radeon.so
>     DEBUG | LAYER:    Loading layer library libVkLayer_MESA_device_select.so
>     INFO | LAYER:     Insert instance layer "VK_LAYER_MESA_device_select"
>     (libVkLayer_MESA_device_select.so)
>     LAYER:            vkCreateInstance layer callstack setup to:
>     LAYER:               <Application>
>     LAYER:                 ||
>     LAYER:               <Loader>
>     LAYER:                 ||
>     LAYER:               VK_LAYER_MESA_device_select
>     LAYER:                       Type: Implicit
>     LAYER:                           Disable Env Var:  NODEVICE_SELECT
>     LAYER:                       Manifest:
>     /usr/share/vulkan/implicit_layer.d/VkLayer_MESA_device_select.json
>     LAYER:                       Library:  libVkLayer_MESA_device_select.so
>     LAYER:                 ||
>     LAYER:               <Drivers>
>     I0818 21:00:08.014896  154451 VkDecoderGlobalState.cpp:443] Creating
>     Vulkan instance for app: vkgears
>     INFO | DRIVER:    linux_read_sorted_physical_devices:
>     INFO | DRIVER:         Original order:
>     INFO | DRIVER:               [0] llvmpipe (LLVM 16.0.6, 128 bits)
>     INFO | DRIVER:               [1] llvmpipe (LLVM 15.0.7, 128 bits)
>     INFO | DRIVER:         Sorted order:
>     INFO | DRIVER:               [0] llvmpipe (LLVM 15.0.7, 128 bits)
>     INFO | DRIVER:               [1] llvmpipe (LLVM 16.0.6, 128 bits)
>     INFO | DRIVER:    linux_read_sorted_physical_devices:
>     INFO | DRIVER:         Original order:
>     INFO | DRIVER:               [0] llvmpipe (LLVM 16.0.6, 128 bits)
>     INFO | DRIVER:               [1] llvmpipe (LLVM 15.0.7, 128 bits)
>     INFO | DRIVER:         Sorted order:
>     INFO | DRIVER:               [0] llvmpipe (LLVM 15.0.7, 128 bits)
>     INFO | DRIVER:               [1] llvmpipe (LLVM 16.0.6, 128 bits)
>     DEBUG | DRIVER:   Copying old device 0 into new device 0
>     DEBUG | DRIVER:   Copying old device 1 into new device 1
>     INFO | DRIVER:    linux_read_sorted_physical_devices:
>     INFO | DRIVER:         Original order:
>     INFO | DRIVER:               [0] llvmpipe (LLVM 16.0.6, 128 bits)
>     INFO | DRIVER:               [1] llvmpipe (LLVM 15.0.7, 128 bits)
>     INFO | DRIVER:         Sorted order:
>     INFO | DRIVER:               [0] llvmpipe (LLVM 15.0.7, 128 bits)
>     INFO | DRIVER:               [1] llvmpipe (LLVM 16.0.6, 128 bits)
>     DEBUG | DRIVER:   Copying old device 0 into new device 0
>     DEBUG | DRIVER:   Copying old device 1 into new device 1
>     INFO | DRIVER:    linux_read_sorted_physical_devices:
>     INFO | DRIVER:         Original order:
>     INFO | DRIVER:               [0] llvmpipe (LLVM 16.0.6, 128 bits)
>     INFO | DRIVER:               [1] llvmpipe (LLVM 15.0.7, 128 bits)
>     INFO | DRIVER:         Sorted order:
>     INFO | DRIVER:               [0] llvmpipe (LLVM 15.0.7, 128 bits)
>     INFO | DRIVER:               [1] llvmpipe (LLVM 16.0.6, 128 bits)
>     DEBUG | DRIVER:   Copying old device 0 into new device 0
>     DEBUG | DRIVER:   Copying old device 1 into new device 1
>     ERROR:            loader_validate_device_extensions: Device extension
>     VK_KHR_swapchain not supported by selected physical device or enabled
> 
> 
> Yeah, any non-headless Linux tests are unlikely to work.  Maybe in a 
> future gfxstream release, since our focus is of course on Android and 
> getting Vulkan in QEMU in general.

I have just tried "vulkan-samples sample hello_triangle --headless" but 
no luck. Below is the output of QEMU with -trace virtio_gpu_cmd_*

virtio_gpu_cmd_ctx_create ctx 0x2, name vulkan_samples
virtio_gpu_cmd_res_create_blob res 0x24, size 1064960
virtio_gpu_cmd_ctx_res_attach ctx 0x2, res 0x24
virtio_gpu_cmd_ctx_submit ctx 0x2, size 8
I0819 15:10:06.916033   21850 IntelDrmDecoder.cpp:38] IntelDrmDecoder 
created for context 2
virtio_gpu_cmd_ctx_submit ctx 0x2, size 8
virtio_gpu_cmd_ctx_submit ctx 0x2, size 8
W0819 15:10:06.916443   21850 VkDecoder.cpp:137] Bad packet length 0 
detected, decode may fail
virtio_gpu_cmd_ctx_submit ctx 0x2, size 8
W0819 15:10:06.916465   21850 VkDecoder.cpp:137] Bad packet length 0 
detected, decode may fail
W0819 15:10:06.916473   21850 VkDecoder.cpp:137] Bad packet length 0 
detected, decode may fail
W0819 15:10:06.916478   21850 VkDecoder.cpp:137] Bad packet length 0 
detected, decode may fail
W0819 15:10:06.916482   21850 VkDecoder.cpp:137] Bad packet length 0 
detected, decode may fail

And it endlessly outputs "Bad packet length" error messages.

