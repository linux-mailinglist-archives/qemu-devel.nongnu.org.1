Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B66E476C55E
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 08:39:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR5Us-0003jv-Oe; Wed, 02 Aug 2023 02:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qR5Ul-0003c6-4I
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 02:38:11 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qR5Uh-0002yu-Ot
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 02:38:06 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bbd2761f1bso54393125ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 23:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690958281; x=1691563081;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H9qg/H4NOwahvnvgifKNTsOrR4APlPnkSjhCbbTz/oU=;
 b=ilSQiRmN5/UlkIi+vdYcZkkqYWd/kVb88/6xn1TrnSUvwaxC3BTqVrPBOVm7UKkgUk
 OLwh3cNS9BqtUl6r3iBihCbb5M8CYyxn1xAE0EDnp8tZLlU8Kt9lJCmKPVkZJv76fqsb
 o+r6fHgJEEkOgAXxUlMCSpplTfSkcCz3UcCHCqUYHzO/6vDuZiVU3YpxfddQIy/TVBAk
 47Ls/y5NLoO27IdkocWfVWwfqwN4LGKoJPuFOj5HfpDKPwEKwVZSTZkySklp5Mzptd7+
 O9sV4OkunbSD+MlJeq5GgjlnF/eE51JKUb/9DcsM0YbKbOqXiJaGFieHeKSXj25fg2zQ
 r27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690958281; x=1691563081;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H9qg/H4NOwahvnvgifKNTsOrR4APlPnkSjhCbbTz/oU=;
 b=bFIaI1hTsBoUTl9Xn9+QMjvxumigVOdN1DQbwjWFEzygwwnbDZsaozeeF5IJ1hySRq
 LBVq9Q8hQZ9X7HDq7MR8g9yYn7WFKC4NAM4XXwAwhp/QFMcGHbLUzqgQwoRrPRgDeV+o
 I0L6132rdWSFLDnYSEckeu2jZLXML8cxkoSip2i7miAeQIKXEEDjMGqE86Q/dqNz9825
 0jn8kxkSSw6YpmANbnmAOvCWTerBha1dLjBDh6kb1/UZeEdCEs89ueB2YDcuN0W/pANu
 pZW1jZ5cKxf3YzanQoXV126OTzm5LvyK8ynKgPcTRF1r/D3nfrX1TdnRMkdquMT0u135
 Bqaw==
X-Gm-Message-State: ABy/qLY9RPB579f9eolBCcdjNqfZ8fSTsZrhiPlqDzGgk6sLMYCsuAHr
 4RGOwOmcOXc2+gcvMX/vPH8=
X-Google-Smtp-Source: APBJJlG3Z1rt/aoDn9jKBxOiWxwIasIFjkz9Gy3HXT7Ug5oIsecpXa7tOs5xRF1DBiTPksfrkIg7vg==
X-Received: by 2002:a17:902:9b94:b0:1b8:b5f8:c485 with SMTP id
 y20-20020a1709029b9400b001b8b5f8c485mr14001749plp.50.1690958281472; 
 Tue, 01 Aug 2023 23:38:01 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a1709029a8500b001b03cda6389sm11545338plp.10.2023.08.01.23.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 23:38:01 -0700 (PDT)
Message-ID: <90b57a8f-e117-b95e-66c1-41c6c93a91f9@gmail.com>
Date: Wed, 2 Aug 2023 15:37:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] docs/system: add basic virtio-gpu documentation
Content-Language: en-US
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, hi@alyssa.is
References: <20230801011723.627-1-gurchetansingh@chromium.org>
 <20230801011723.627-10-gurchetansingh@chromium.org>
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20230801011723.627-10-gurchetansingh@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pl1-x62e.google.com
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

On 2023/08/01 10:17, Gurchetan Singh wrote:
> This adds basic documentation for virtio-gpu.
> 
> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> 
> ---
> v2: - Incorporated suggestions by Akihiko Odaki
>      - Listed the currently supported capset_names (Bernard)
> 
>   docs/system/device-emulation.rst   |  1 +
>   docs/system/devices/virtio-gpu.rst | 98 ++++++++++++++++++++++++++++++
>   2 files changed, 99 insertions(+)
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
> index 0000000000..f359584033
> --- /dev/null
> +++ b/docs/system/devices/virtio-gpu.rst
> @@ -0,0 +1,98 @@
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
> +QEMU provides a 2D virtio-gpu backend, and two accelerated backends:
> +virglrenderer ('gl' device label) and rutabaga_gfx ('rutabaga' device
> +label).  There is a vhost-user backend that runs the graphics stack in
> +a separate process for improved isolation.
> +
> +Theses backends can be further classified into VGA and non-VGA variants.

It's a bit unsound wording. virglrenderer and rutabaga_gfx are certainly 
backends, but "VGA" is not; it describes an interface exposed to the guest

> +The VGA ones are prefixed with virtio-vga or vhost-user-vga while the
> +non-VGA ones are prefixed with virtio-gpu or vhost-user-gpu.
> +
> +The VGA ones always use PCI interface, but for the non-VGA ones, you can
> +further pick simple MMIO or PCI. For MMIO, you can suffix the device
> +name with -device though vhost-user-gpu apparently does not support

You don't need the word "apparently" in the documentation.

> +MMIO. For PCI, you can suffix it with -pci. Without these suffixes, the
> +platform default will be chosen.  The syntax of  available combinations

Duplicate whitespaces between "of" and "available".

> +is listed below.
> +
> + * ``virtio-vga[-BACKEND]``
> + * ``virtio-gpu[-BACKEND][-INTERFACE]``
> + * ``vhost-user-vga``
> + * ``vhost-user-pci``

Probably this list should come first.

> +
> +This document uses the PCI variant in examples.
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
> +When using virgl accelerated graphics mode, OpenGL API calls are translated
> +into an intermediate representation (see `Gallium3D`_). The intermediate

Add "on the guest" to the first sentence for clarification.

> +representation is communicated to the host and the `virglrenderer`_ library
> +on the host translates the intermediate representation back to OpenGL API
> +calls.
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
> +virtio-gpu can also leverage `rutabaga_gfx`_ to provide `gfxstream`_ rendering
> +and `Wayland display passthrough`_.  With the gfxstream rendering mode, GLES
> +and Vulkan calls are forwarded directly to the host with minimal modification.

Nitpick: remove "directly". We already say "with minimal modification".

> +
> +The crosvm book provides directions on how to build a `gfxstream-enabled
> +rutabaga`_ and launch a `guest Wayland compositor`_.

It should be clarified it's not a conventional compositor but it's a proxy.

> +
> +This device does require host blob support (``hostmem`` field below), but not
> +all capsets (``capset_names`` below) have to enabled when starting the device.
> +
> +The currently supported ``capset_names`` are ``gfxstream-vulkan`` and
> +``cross-domain`` on Linux guests.  For Android guests, ``gfxstream-gles`` is
> +also supported.
> +
> +.. parsed-literal::
> +    -device virtio-gpu-rutabaga-pci,capset_names=gfxstream-vulkan:cross-domain,\\
> +      hostmem=8G,wayland_socket_path="$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY"
> +
> +.. _rutabaga_gfx: https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/rutabaga_gfx_ffi.h
> +.. _gfxstream: https://android.googlesource.com/platform/hardware/google/gfxstream/
> +.. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
> +.. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html
> +.. _guest Wayland compositor: https://crosvm.dev/book/devices/wayland.html

