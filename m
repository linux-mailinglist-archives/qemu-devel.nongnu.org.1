Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9216777522D
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 07:19:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTbaf-00019o-4y; Wed, 09 Aug 2023 01:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qTbac-00019M-Am
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 01:18:34 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qTbaa-0003Jr-9F
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 01:18:34 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-564b326185bso3095333a12.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 22:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691558311; x=1692163111;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T1vchhNw+HxemdR2dS5ZyswaYrJwYHNi8z6C4pxzG3o=;
 b=Vnlx6thzPV+VPPlI9QKJszkIB1gbSkrT1DR0qww+11/XlPYFxezHio8oHw9SmovM+a
 Nct29SqLM/aHzzwcGouoD1xedJidDYqOA/ej86EtAf2n1PW13e6oScY3lg2ENwO7CHId
 VdOYOmMflt1ozjruouTb5aNp+5RR8yPbPefgK6U/k5GEXj1K0P3my/brRvnUCsUAa300
 Q5p2qMuJ+F4iiuew/vCZAqaG2WtdrfIN4XU7fZcPmO8U0QAJHRrs+tLiaN+DSPkcbVFH
 bDMgfRuu+4meHDmwlNHeK9rpV9xv//S4RyEpCjQrlUU4ONJFclJFTHR8yGhovQUJxWiJ
 Vozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691558311; x=1692163111;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T1vchhNw+HxemdR2dS5ZyswaYrJwYHNi8z6C4pxzG3o=;
 b=eevf3ERpkTb62BP774EiJmoqzYia24IPlNuriJLS1nGzE9+M9B7e/TIPlddpGenLw4
 1C/a9xXRbIlseXR4yy3PWHJpkFSqR3dZUxCKHFka7XVj1iMpw/IN6nQNRFETE2bhyvJ3
 FQbhwuJeVWgdbm9eiR4kecOj5vtfc/N5Ro7X6bhqwaADQBpoUNcsYiIfrN6/UEZ3F9fn
 ozE0kaHYxoPFErPdEKJQE0f0hu96ymKArDuA4nP/x+HBU7SlElfpmN0LOigSk4u+Mn8p
 /v9m+Dcx5bkNgS7u39f9xyQsrLWN67kkoo9q0v4Nx5JCdzigajz42FUX779lctQCtl1v
 56nw==
X-Gm-Message-State: AOJu0YxsvemW2OgpyXMloTxhWMgx6WKEYi66ucEZlvoT/HipI0vDGL7C
 75cL6bOaZ4ZMgSnT8oG2VjQ=
X-Google-Smtp-Source: AGHT+IFtqc7vmixc3YKzt+lsPqAC7GN1d+FKC5UpzKtO0QUNPRz7ghIMa+vTjM+L+eWS2Z0lObpLuw==
X-Received: by 2002:a05:6a20:1c7:b0:13f:7c0e:dc74 with SMTP id
 7-20020a056a2001c700b0013f7c0edc74mr1011388pzz.55.1691558310639; 
 Tue, 08 Aug 2023 22:18:30 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 j1-20020aa783c1000000b0063b96574b8bsm8943749pfn.220.2023.08.08.22.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 22:18:30 -0700 (PDT)
Message-ID: <41d8c647-164a-46ce-aaee-f48bc5f4d752@gmail.com>
Date: Wed, 9 Aug 2023 14:18:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] docs/system: add basic virtio-gpu documentation
Content-Language: en-US
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is, ernunes@redhat.com
References: <20230809021108.674-1-gurchetansingh@chromium.org>
 <20230809021108.674-10-gurchetansingh@chromium.org>
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20230809021108.674-10-gurchetansingh@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pg1-x52e.google.com
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

On 2023/08/09 11:11, Gurchetan Singh wrote:
> This adds basic documentation for virtio-gpu.
> 
> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> ---
> v2: - Incorporated suggestions by Akihiko Odaki
>      - Listed the currently supported capset_names (Bernard)
> 
> v3: - Incorporated suggestions by Akihiko Odaki and Alyssa Ross
> 
> v4: - Incorporated suggestions by Akihiko Odaki
> 
>   docs/system/device-emulation.rst   |   1 +
>   docs/system/devices/virtio-gpu.rst | 115 +++++++++++++++++++++++++++++
>   2 files changed, 116 insertions(+)
>   create mode 100644 docs/system/devices/virtio-gpu.rst
> 
> diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
> index 4491c4cbf7..1167f3a9f2 100644
> --- a/docs/system/device-emulation.rst
> +++ b/docs/system/device-emulation.rst
> @@ -91,6 +91,7 @@ Emulated Devices
>      devices/nvme.rst
>      devices/usb.rst
>      devices/vhost-user.rst
> +   devices/virtio-gpu.rst
>      devices/virtio-pmem.rst
>      devices/vhost-user-rng.rst
>      devices/canokey.rst
> diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
> new file mode 100644
> index 0000000000..d56524270d
> --- /dev/null
> +++ b/docs/system/devices/virtio-gpu.rst
> @@ -0,0 +1,115 @@
> +..
> +   SPDX-License-Identifier: GPL-2.0
> +
> +virtio-gpu
> +==========
> +
> +This document explains the setup and usage of the virtio-gpu device.
> +The virtio-gpu device paravirtualizes the GPU and display controller.
> +
> +Linux kernel support
> +--------------------
> +
> +virtio-gpu requires a guest Linux kernel built with the
> +``CONFIG_DRM_VIRTIO_GPU`` option.
> +
> +QEMU virtio-gpu variants
> +------------------------
> +
> +QEMU virtio-gpu device variants come in the following form:
> +
> + * ``virtio-vga[-BACKEND]``
> + * ``virtio-gpu[-BACKEND][-INTERFACE]``
> + * ``vhost-user-vga``
> + * ``vhost-user-pci``
> +
> +**Backends:** QEMU provides a 2D virtio-gpu backend, and two accelerated
> +backends: virglrenderer ('gl' device label) and rutabaga_gfx ('rutabaga'
> +device label).  There is a vhost-user backend that runs the graphics stack
> +in a separate process for improved isolation.
> +
> +**Interfaces:** QEMU further categorizes virtio-gpu device variants based
> +on the interface exposed to the guest. The interfaces can be classified
> +into VGA and non-VGA variants. The VGA ones are prefixed with virtio-vga
> +or vhost-user-vga while the non-VGA ones are prefixed with virtio-gpu or
> +vhost-user-gpu.
> +
> +The VGA ones always use the PCI interface, but for the non-VGA ones, the
> +user can further pick between MMIO or PCI. For MMIO, the user can suffix
> +the device name with -device, though vhost-user-gpu does not support MMIO.
> +For PCI, the user can suffix it with -pci. Without these suffixes, the
> +platform default will be chosen.
> +
> +This document uses the PCI interface in examples.

I think it's better to omit -pci.

By the way you are not adding the aliases for Rutabaga so please do so. 
You can find the table in: softmmu/qdev-monitor.c

> +
> +virtio-gpu 2d
> +-------------
> +
> +The default 2D backend only performs 2D operations. The guest needs to
> +employ a software renderer for 3D graphics.
> +
> +Typically, the software renderer is provided by `Mesa`_ or `SwiftShader`_.
> +Mesa's implementations (LLVMpipe, Lavapipe and virgl below) work out of box
> +on typical modern Linux distributions.
> +
> +.. parsed-literal::
> +    -device virtio-gpu-pci
> +
> +.. _Mesa: https://www.mesa3d.org/
> +.. _SwiftShader: https://github.com/google/swiftshader
> +
> +virtio-gpu virglrenderer
> +------------------------
> +
> +When using virgl accelerated graphics mode in the guest, OpenGL API calls
> +are translated into an intermediate representation (see `Gallium3D`_). The
> +intermediate representation is communicated to the host and the
> +`virglrenderer`_ library on the host translates the intermediate
> +representation back to OpenGL API calls.
> +
> +.. parsed-literal::
> +    -device virtio-gpu-gl-pci
> +
> +.. _Gallium3D: https://www.freedesktop.org/wiki/Software/gallium/
> +.. _virglrenderer: https://gitlab.freedesktop.org/virgl/virglrenderer/
> +
> +virtio-gpu rutabaga
> +-------------------
> +
> +virtio-gpu can also leverage `rutabaga_gfx`_ to provide `gfxstream`_
> +rendering and `Wayland display passthrough`_.  With the gfxstream rendering
> +mode, GLES and Vulkan calls are forwarded to the host with minimal
> +modification.
> +
> +The crosvm book provides directions on how to build a `gfxstream-enabled
> +rutabaga`_ and launch a `guest Wayland proxy`_.
> +
> +This device does require host blob support (``hostmem`` field below). The
> +``hostmem`` field specifies the size of virtio-gpu host memory window.
> +This is typically between 256M and 8G.
> +
> +At least one capset (see colon separated ``capset_names`` below) must be
> +specified when starting the device.  The currently supported
> +``capset_names`` are ``gfxstream-vulkan`` and ``cross-domain`` on Linux
> +guests. For Android guests, ``gfxstream-gles`` is also supported.
> +
> +The device will try to auto-detect the wayland socket path if the
> +``cross-domain`` capset name is set.  The user may optionally specify
> +``wayland_socket_path`` for non-standard paths.
> +
> +The ``wsi`` option can be set to ``surfaceless`` or ``headless``.
> +Surfaceless doesn't create a native window surface, but does copy from the
> +render target to the Pixman buffer if a virtio-gpu 2D hypercall is issued.
> +Headless is like surfaceless, but doesn't copy to the Pixman buffer.
> +Surfaceless is the default if ``wsi`` is not specified.
> +
> +.. parsed-literal::
> +    -device virtio-gpu-rutabaga-pci,capset_names=gfxstream-vulkan:cross-domain,
> +       hostmem=8G,wayland_socket_path=/tmp/nonstandard/mock_wayland.sock,
> +       wsi=headless
> +
> +.. _rutabaga_gfx: https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/rutabaga_gfx_ffi.h
> +.. _gfxstream: https://android.googlesource.com/platform/hardware/google/gfxstream/
> +.. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
> +.. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html

The build procedure looks almost good, but a command for building gfxstream:
meson -Ddefault_library=static build/

This results in a warning:
WARNING: Running the setup command as `meson [options]` instead of 
`meson setup [options]` is ambiguous and deprecated.

The same goes for the command for guest-side libraries.

> +.. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html

