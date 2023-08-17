Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1290C77F030
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 07:30:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWVYv-0005c8-NZ; Thu, 17 Aug 2023 01:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qWVYg-0005bo-Fv
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 01:28:34 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qWVYb-0002w0-PW
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 01:28:33 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-56dfe5ce871so3287338eaf.2
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 22:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692250108; x=1692854908;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/hNHm6aUiLKZ4SdJA8lJbxRlwtnLC8Jb2TvvhT9h78g=;
 b=JRYOC/Q6o+/OdxqAULR4uEY6UE42iYbnPTICNhgD59n7RkvVNyLCIUuAJAieayw9Ep
 Rc6u7qVWqGtphp2zbP/3iUbuc+AgwvM9MXlsw3PFOtiG+NOdlxm6kKFCcVPgYsNHKJgp
 ID4axuYpArW4MMdJCJtgNlotp4GSrr9fwsX5as8u1WJZD5vaKXiB4MqOT+gW30ByjwNm
 jsi6MEAhDTeOXSE9hyHag6Lwwk5zSNThY5rlLWsxBqpLr8VjWxgznFCgsavfIne8G+mu
 XFoW373RJ2In7XyIXMZBP5Qc2P2x++O2qu6hoAERxERien08urp92DFWs4cs1QuBZiOB
 DE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692250108; x=1692854908;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/hNHm6aUiLKZ4SdJA8lJbxRlwtnLC8Jb2TvvhT9h78g=;
 b=ICfHigQ5AP4bi2WOBZhvDrUWeVb0rLhOaOAVuklQDnQMy9ojB6BFBX4llPoBbRSJTx
 gcoYjzsj4gO9xhJngcXfk6EIyWHEib/57td/McJQOfrTCqYV1oYtNT6qlZjtlLGqn2jz
 euQ7wbi/kUMN3mp3XUwD3B339gwgQm7dNXbCgpRXMlMrLu9ypjjSAGFDAr+nOGAnHgJm
 EYpqxWr3ORSq5IitOWH2TFS25SKAXcvqWR4G8388KBHcM3frDZRD6eotNqEZ+pEifPVg
 ComuSZT0FJUWZCsZH1TcPxADcN1zBnVwTdTfOc/cAM7DAyQVDh/xciiJ6bucm2eNjzc/
 Y6eQ==
X-Gm-Message-State: AOJu0YwVkmJA4IQ/Fm3lDfsg2ZV/yHmpxRdceQZCQk/ezScNIvNT061S
 b9oWLZ32ZoceSB+A/XxB1gnyU9uD0Pc=
X-Google-Smtp-Source: AGHT+IEDfS8FNrmpYUN9lKHQGp6whz0QNtTv7uCv9Z/To0FMya7Yur4YjdMZciqo58l4xzo+OPCryA==
X-Received: by 2002:a05:6808:2888:b0:3a7:2d4c:5d4e with SMTP id
 eu8-20020a056808288800b003a72d4c5d4emr3839546oib.7.1692250108071; 
 Wed, 16 Aug 2023 22:28:28 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a63ab09000000b005641bbe783bsm12821331pgf.11.2023.08.16.22.28.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 22:28:27 -0700 (PDT)
Message-ID: <1281e8f6-f91a-4ced-b5d1-773370db3eef@gmail.com>
Date: Thu, 17 Aug 2023 14:28:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] docs/system: add basic virtio-gpu documentation
Content-Language: en-US
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is, ernunes@redhat.com,
 manos.pitsidianakis@linaro.org
References: <20230817022322.466-1-gurchetansingh@google.com>
 <20230817022322.466-10-gurchetansingh@google.com>
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20230817022322.466-10-gurchetansingh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-oo1-xc2d.google.com
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

On 2023/08/17 11:23, Gurchetan Singh wrote:
> From: Gurchetan Singh <gurchetansingh@chromium.org>
> 
> This adds basic documentation for virtio-gpu.
> 
> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Tested-by: Alyssa Ross <hi@alyssa.is>
> Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> v2: - Incorporated suggestions by Akihiko Odaki
>      - Listed the currently supported capset_names (Bernard)
> 
> v3: - Incorporated suggestions by Akihiko Odaki and Alyssa Ross
> 
> v4: - Incorporated suggestions by Akihiko Odaki
> 
> v5: - Removed pci suffix from examples
>      - Verified that -device virtio-gpu-rutabaga works.  Strangely
>        enough, I don't remember changing anything, and I remember
>        it not working.  I did rebase to top of tree though.
>      - Fixed meson examples in crosvm docs
> 
>   docs/system/device-emulation.rst   |   1 +
>   docs/system/devices/virtio-gpu.rst | 113 +++++++++++++++++++++++++++++
>   2 files changed, 114 insertions(+)
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
> index 0000000000..8c5c708272
> --- /dev/null
> +++ b/docs/system/devices/virtio-gpu.rst
> @@ -0,0 +1,113 @@
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
> +    -device virtio-gpu
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
> +    -device virtio-gpu-gl
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
> +    -device virtio-gpu-rutabaga,capset_names=gfxstream-vulkan:cross-domain,
> +       hostmem=8G,wayland_socket_path=/tmp/nonstandard/mock_wayland.sock,
> +       wsi=headless
> +
> +.. _rutabaga_gfx: https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/rutabaga_gfx_ffi.h
> +.. _gfxstream: https://android.googlesource.com/platform/hardware/google/gfxstream/
> +.. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
> +.. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html

You have different links for "rutabaga_gfx" and "gfxstream-enabled 
rutabaga", but I think you only need one.

> +.. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html

