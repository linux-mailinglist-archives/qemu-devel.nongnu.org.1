Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE0F76FB49
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 09:36:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRpMZ-0007pu-QG; Fri, 04 Aug 2023 03:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qRpMX-0007ix-B6
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 03:36:42 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qRpMV-0007j3-67
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 03:36:41 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bbc06f830aso12887395ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 00:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691134597; x=1691739397;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DPb1f8YcWppECPWSF/BKjkLMhuP50PjKQ0nKu7XLuz8=;
 b=MeikXlDullzQsA9SRmbOr+gqRMs6wDu2gkKWqH1qDc0KlXRaUKDwN5K/YSED5PdQhw
 exEq5H9w5Rom2l5FYGVcvuM2BKDaDyRugn0XdWKUMHbRJDFbUizqfWzsrur6HrnewK58
 Ab5AWkOSENb028rklUuHqmoqF2dls+pj8Xnaz0Bb2su4vzhje3uIsEBfDDuiyw8j/vww
 CxWFwk6tO7qbYMsk7v2C0e+qTmfnVGfAvUD79PHro1PAT//BuzegSTrV/AAH2lg17rQo
 g/eBjszNtt/bzSIicRNZhCSbkoj0F+7tQytDZRxNyQYCU8x4hnv+h192u+2RGogTfGkb
 +Zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691134597; x=1691739397;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DPb1f8YcWppECPWSF/BKjkLMhuP50PjKQ0nKu7XLuz8=;
 b=KvMzkVXNpjrWWU9RZ3SjCghXA0Y/sHuZruuHHGyBtv/X8C3Gg8QFhK+5Bb89P1nIRt
 tfQrvkGoqjH6uOiUbPmjaJ79IJF2S1/CmfFLm58QsF4BfMj8Y6kMMQ/GWSfKlZGlJ7TW
 s2mDzR6oJqxrJkES4SB0i6f07B0Q8R57h2BsMDo2oLihrW925hAxLMhXK8xHojsRD4tu
 KMZetsflklnKIWkIctogC9uoL00aTPxosiNHzsePprjd1PqwWeAavB0G8zKN5MRGPkjr
 t5gG3C76EIwutHKOvvnVh31IGQTGu8vBCfdXeTc/gRzBndGjEWLtY3uKti8IAhYtrenv
 2DtQ==
X-Gm-Message-State: AOJu0Yy5u2dKmqTb5Qcofg2Bbh6I6E6JskuNXuSHOX+sF2E4dp+eshMN
 8V7CuLlYtGrl8riPIMNzuZ80dbg62bc=
X-Google-Smtp-Source: AGHT+IErCFUzNDND+F7KJ1C8JYkS8Shvt+bOzefJNMjlF7i/+kB2J7Lct4dWcVyIEkquK8RQSfmvYg==
X-Received: by 2002:a17:903:41d1:b0:1bc:210d:6365 with SMTP id
 u17-20020a17090341d100b001bc210d6365mr1448457ple.2.1691134596894; 
 Fri, 04 Aug 2023 00:36:36 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 iz11-20020a170902ef8b00b001b9c5e0393csm1045055plb.225.2023.08.04.00.36.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Aug 2023 00:36:36 -0700 (PDT)
Message-ID: <7e864cd3-f277-e249-fb75-50871d584f7e@gmail.com>
Date: Fri, 4 Aug 2023 16:36:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] docs/system: add basic virtio-gpu documentation
Content-Language: en-US
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, hi@alyssa.is
References: <20230803235502.373-1-gurchetansingh@google.com>
 <20230803235502.373-10-gurchetansingh@google.com>
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20230803235502.373-10-gurchetansingh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 2023/08/04 8:55, Gurchetan Singh wrote:
> From: Gurchetan Singh <gurchetansingh@chromium.org>
> 
> This adds basic documentation for virtio-gpu.
> 
> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> 
> ---
> v2: - Incorporated suggestions by Akihiko Odaki
>      - Listed the currently supported capset_names (Bernard)
> 
> v3: - Incorporated suggestions by Akihiko Odaki and Alyssa Ross
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
> index 0000000000..2b8ecdac32
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
> +Atleast one capset (see colon separated ``capset_names`` below) must be

"At least".

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
> +       hostmem=8G,wayland_socket_path="$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY",

You will no longer want to specify: 
wayland_socket_path="$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY"

> +       wsi=headless
> +
> +.. _rutabaga_gfx: https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/rutabaga_gfx_ffi.h
> +.. _gfxstream: https://android.googlesource.com/platform/hardware/google/gfxstream/
> +.. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
> +.. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html
> +.. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html

