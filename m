Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC5B7512B7
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 23:41:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJhZk-00075X-P6; Wed, 12 Jul 2023 17:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qJhZd-0006xX-Dm
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 17:40:38 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qJhZb-0008Hg-4A
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 17:40:37 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-666eba6f3d6so32589b3a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 14:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689198033; x=1691790033;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qjiGJAC9/lFUB3E6g6dfJ4mQayFQaBsuorvLSiUQVAA=;
 b=PWvP18AGUE6s5p/Y3QUYQCkdvvNms8UbRWbogg3G4HX1gN8R99nn4ucmyF+qwbbrl8
 WbMdYUyeQ8ztLj2/ApINsTHVGmgDwdTuCXNmEzQEJ0/62KpcNVS0zYE/QlFD/o69CNC9
 sIXXi0c06MbXGxnjMgTtjZ04+k9TkKla9ipOHa8QjSxzBaUr2FVXlApNNvJMELme0VtK
 CrowQ8Pk3moRkHh3aKQizq4Pf1AuUHW4quMkQ+t38sFMOngWVP20eEBZjRjLjWcimoMn
 4b9dwwlxvgEIY5vqImCzTSS6dLz1o3nqSoIgN30gftapRB8PYXlp/se/hua4qcOgrLe1
 JrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689198033; x=1691790033;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qjiGJAC9/lFUB3E6g6dfJ4mQayFQaBsuorvLSiUQVAA=;
 b=Z25sjNOBKPUiavVkhBqICtE9dU9SI1XaaCeQ6niOZbrEfTcKF1jnk0CDvSFAzNcrMZ
 r4VgySdFhQnE5eRkg2dObJF3KCWWU2/PvmnvuVtd6w4lW7oWpLhj8+eQj7pU3zNC4rHn
 kiCvQZPEhP7q24/1G77LMse2gy+G24p2OM4SkI3iExwyWdzaNFdMtWNnx8rM+7gmkA45
 +VYC1SNq8HKtVR4piWA6VIirb5iedGJAyhrRP1eHSQhREzGc/3XzNtrKCAlej2KjQxbL
 EV4BSpxEHC4Rs5avgnyTNBs24wiV9hkeJO9ZG94KvkkFPQ6yxbseWNQgENj10lcJe43h
 +yDw==
X-Gm-Message-State: ABy/qLb1cjmsapsIuUZZmTNaIOasAS0CFefulOrTdjEOEZSIbcL/xh+o
 l7X1yW1QTh3Fh6X0d5WnqUE=
X-Google-Smtp-Source: APBJJlE90v7q4VRiO2KyAFLN+aMeseTDeijJWT3zeJMVzSFFwDQNQFprg9JbjZP/JqwqI5dUMB2uuQ==
X-Received: by 2002:a05:6a20:9147:b0:12f:a373:ba95 with SMTP id
 x7-20020a056a20914700b0012fa373ba95mr18963343pzc.19.1689198033291; 
 Wed, 12 Jul 2023 14:40:33 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 k15-20020aa790cf000000b00666b3706be6sm3996966pfk.107.2023.07.12.14.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 14:40:32 -0700 (PDT)
Message-ID: <38518b56-ff2b-f8ed-c7d7-fe0653c5d825@gmail.com>
Date: Thu, 13 Jul 2023 06:40:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 9/9] docs/system: add basic virtio-gpu documentation
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com
References: <20230711025649.708-1-gurchetansingh@chromium.org>
 <20230711025649.708-10-gurchetansingh@chromium.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20230711025649.708-10-gurchetansingh@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.11, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/07/11 11:56, Gurchetan Singh wrote:
> This adds basic documentation for virtio-gpu.

Thank you for adding documentation for other backends too. I have been 
asked how virtio-gpu works so many times and always had to explain by 
myself though Gerd does have a nice article.* This documentation will help.

* https://www.kraxel.org/blog/2021/05/virtio-gpu-qemu-graphics-update/

> 
> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> ---
>   docs/system/device-emulation.rst   |  1 +
>   docs/system/devices/virtio-gpu.rst | 80 ++++++++++++++++++++++++++++++
>   2 files changed, 81 insertions(+)
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
> index 0000000000..2426039540
> --- /dev/null
> +++ b/docs/system/devices/virtio-gpu.rst
> @@ -0,0 +1,80 @@
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
> +There are many virtio-gpu device variants, listed below:
> +
> + * ``virtio-vga``
> + * ``virtio-gpu-pci``
> + * ``virtio-vga-gl``
> + * ``virtio-gpu-gl-pci``
> + * ``virtio-vga-rutabaga``
> + * ``virtio-gpu-rutabaga-pci``
> + * ``vhost-user-vga``
> + * ``vhost-user-gl-pci``

> +
> +QEMU provides a 2D virtio-gpu backend, and two accelerated backends:
> +virglrenderer ('gl' device label) and rutabaga_gfx ('rutabaga' device
> +label).  There is also a vhost-user backend that runs the 2D device > +in a separate process.  Each device type as VGA or PCI variant.  This
> +document uses the PCI variant in examples.

I suggest to replace "2D device" with "graphics stack"; vhost-user works 
with 3D too. It's also slightly awkward to say a device runs in a 
separate process as some portion of device emulation always stuck in 
QEMU. In my opinion, the point of vhost-user backend is to isolate the 
gigantic graphics stack so let's put this phrase.

I also have a bit different understanding regarding virtio-gpu variants.
First, the variants can be classified into VGA and non-VGA ones. The VGA 
ones are prefixed with virtio-vga or vhost-user-vga while the non-VGA 
ones are prefixed with virtio-gpu or vhost-user-gpu.

The VGA ones always use PCI interface, but for the non-VGA ones, you can 
further pick simple MMIO or PCI. For MMIO, you can suffix the device 
name with -device though vhost-user-gpu apparently does not support 
MMIO. For PCI, you can suffix it with -pci. Without these suffixes, the 
platform default will be chosen.

Since enumerating all variants will result in a long list, you may 
provide abstract syntaxes like the following for this explanation:

* virtio-vga[-BACKEND]
* virtio-gpu[-BACKEND][-INTERFACE]
* vhost-user-vga
* vhost-user-pci

> +
> +virtio-gpu 2d
> +-------------
> +
> +The default 2D mode uses a guest software renderer (llvmpipe, lavapipe,
> +Swiftshader) to provide the OpenGL/Vulkan implementations.

It's certainly possible to use virtio-gpu without software 
OpenGL/Vulkan. A major example is Windows; its software renderer is 
somewhat limited in my understanding.

My suggestion:
The default 2D backend only performs 2D operations. The guest needs to 
employ a software renderer for 3D graphics.

It's also better to provide links for the renderers. Apparently lavapipe 
does not have a dedicated documentation, so you may add a link for Mesa 
and mention them like:
LLVMpipe and Lavapipe included in `Mesa`_, or `SwiftShader`_

And I think it will be helpful to say LLVMpipe and Lavapipe work out of 
box on typical modern Linux distributions as that should be what people 
care.

> +
> +.. parsed-literal::
> +    -device virtio-gpu-pci
> +
> +virtio-gpu virglrenderer
> +------------------------
> +
> +When using virgl accelerated graphics mode, OpenGL API calls are translated
> +into an intermediate representation (see `Gallium3D`_). The intermediate
> +representation is communicated to the host and the `virglrenderer`_ library
> +on the host translates the intermediate representation back to OpenGL API
> +calls.
It should be mentioned that the translation occurs in the guest side, 
and the guest side component is included in Linux distributions as like 
LLVMpipe and Lavapipe are.

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

I find the description included in the PDF you posted on GitLab* quite a 
useful so I suggest to incorporate its content.

You may omit the overall design diagram as it mentions guest side and 
Rutabaga details and crosvm and may be confusing for QEMU users.

The detailed commands for building dependencies may also be omitted and 
instead point to the documentation of respective projects as they should 
be subject to future changes.

It's unfortunate that rutabaga_gfx and goldfish-opengl do not come with 
proper documentations (and I wonder rutabaga_gfx still need a hack 
mentioned in the PDF). For now the procedure to build them should be 
included in the documentation since it will take hours to figure out for 
a first-time reader otherwise.

* 
https://gitlab.com/qemu-project/qemu/uploads/f960580bf0f19077e0330960b4a3152e/gfxstream_+_QEMU_setup__public_.pdf

> +
> +Please refer the `crosvm book`_ on how to setup the guest for Wayland
> +passthrough (QEMU uses the same implementation).
> +
> +This device does require host blob support (``hostmem`` field below), but not
> +all capsets (``capset_names`` below) have to enabled when starting the device.
> +
> +.. parsed-literal::
> +    -device virtio-gpu-rutabaga-pci,capset_names=gfxstream-vulkan:cross-domain,\\
> +      hostmem=8G,wayland_socket_path="$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY"
> +
> +.. _rutabaga_gfx: https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/rutabaga_gfx_ffi.h
> +.. _gfxstream: https://android.googlesource.com/platform/hardware/google/gfxstream/
> +.. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
> +.. _crosvm book: https://crosvm.dev/book/devices/wayland.html

