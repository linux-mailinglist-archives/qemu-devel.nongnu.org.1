Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1F076C61C
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 09:10:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR5yk-0005e8-Rq; Wed, 02 Aug 2023 03:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qR5yi-0005dj-F1
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:09:04 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qR5yg-0007fk-FO
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:09:04 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-686ba29ccb1so418416b3a.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 00:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690960140; x=1691564940;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EZYJiA6oCVrCZ8+IqWAcDYRDEobTVPdWGSTrkamXnBI=;
 b=LwGoZIBAh0R33/kAaf1WHGOGyuYR+//rHlRmGWGooLjmC05a+W6Lj2mzA97ok0wz5s
 LpZKgNbYLKn74riD1QNlnU/gSnHj7uO/11EBu0AUPrtA7aP2sAf23TK+Viyq0E8wTiGp
 439DmJnp/O+18kkiHQcjtDm7qyQ1gLCTqr7U2Vwlcar1ZF//5FIzoHuim+GybfDVA1fU
 oiKlq1lYl0Yof/oHE9FtLkiUB5ki+1btzapjUGJp2Db3p6Tpb5vY3k9yHGY/oRe5KbJ/
 5nnPv8zEjmlpnFImMe4B5bwWWMiUOsSsfKLfREuwzOlgBj+RCbYGY73Q/+NgbRCMtoPr
 yXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690960140; x=1691564940;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EZYJiA6oCVrCZ8+IqWAcDYRDEobTVPdWGSTrkamXnBI=;
 b=GVVeS65O+p/6lJXimXX2Ic/H8IY/Ce6EqTHO2oe/gkLTzN1rlxEuV/FCQRg42fBeZX
 GweKn7RGgsrn/fEBvP9/+WxEuThTYW4vtARsCePz/wWEAPgApOd8riFEqbjXeYVwF7Z6
 rV3/31n1r/Cy906apSKmvztT7syG4nrhmXudILteHtWg/UTKSUlwmOog/2HbFLH4AwDs
 2+QBigzyCfm/IzdOwECJtR97XDTadgAZbDZedAsFir80xLWR6L9OOk5Rq3Xo5QzlUONo
 MaXxoLm0s1pg/S70romJSDmdxhFA/DZ7m98f7c9yIaPTqxESeDJnaIh8cLwoQtZcUT+s
 fwAw==
X-Gm-Message-State: ABy/qLZjj1S8fHt8w2/FHZH3rGPNRZMP7yDowUvESGfW0CYOrHhhlngL
 54ztvKBjcIC29tTmj3995ds=
X-Google-Smtp-Source: APBJJlEhm12fdabqvQzIfDJedYAWp5jp4Cu566lJJpMoCVHWDyCEtohcg23hu8bOetg85MDLJ4ABIA==
X-Received: by 2002:a05:6a20:8e12:b0:13e:90aa:8c8b with SMTP id
 y18-20020a056a208e1200b0013e90aa8c8bmr4884516pzj.4.1690960139982; 
 Wed, 02 Aug 2023 00:08:59 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 z10-20020aa791ca000000b006877b0b31c2sm259730pfa.147.2023.08.02.00.08.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 00:08:59 -0700 (PDT)
Message-ID: <e47e638e-d27b-7848-14e6-62d5c71ef20a@gmail.com>
Date: Wed, 2 Aug 2023 16:08:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] gfxstream + rutabaga_gfx
Content-Language: en-US
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, hi@alyssa.is
References: <20230801011723.627-1-gurchetansingh@chromium.org>
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20230801011723.627-1-gurchetansingh@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pf1-x429.google.com
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
> Latest iteration of rutabaga_gfx + gfxstream patches.  Previous versions
> available here:
> 
> https://patchew.org/QEMU/20230711025649.708-1-gurchetansingh@chromium.org/
> 
> https://patchew.org/QEMU/20230421011223.718-1-gurchetansingh@chromium.org/
> 
> Changes since v1:
> - New error callback hooked into QEMU error's handlers
> - Incorporated review feedback
> - goldfish-opengl repo is now gone: new unified repo for guest and host
> 
> How to build both rutabaga and gfxstream guest/host libs:
> 
> https://crosvm.dev/book/appendix/rutabaga_gfx.html

It's nice to see a documentation for this. The below are some comments:

Why not install dependencies in one command?
sudo apt install libdrm libglm-dev libstb-dev

The cmake command for AEMU is broken into two lines but the newline 
character between them are not escaped. It should be one line or the 
newline should be escaped.

It also gives a warning:
CMake Warning:
   Ignoring extra path from command line:

    "../"

And it's probably better to have a dedicated build directory. /build is 
in .gitignore so you may:
cmake -DAEMU_COMMON_GEN_PKGCONFIG=ON \
       -DAEMU_COMMON_BUILD_CONFIG=gfxstream \
       -DENABLE_VKCEREAL_TESTS=OFF -B build

It's also better to use the following commands to build and install it 
just in case the system has a different backend (like Ninja):
cmake --build build -j
sudo cmake --install build

The build directory of gfxstream may be named just "build" so that you 
can blindly copy the command on Arm64 or whatever and to ignore it with 
.gitignore.

You may build and install it with the following command:
meson install -C build
No need for separate build command and sudo. Meson takes care of that.

The documentation has one command for building and installing Rutabaga, 
but that may cause a problem. For example, you may have rustup 
configured for a normal user but not for the superuser. Perhaps it's 
better not to have "build" as a dependency of "install" and have two 
commands for each of the steps:
make
sudo make install

> 
> Branch containing this patch series:
> 
> https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstream-v2
> 
> Next steps:
>   - Will add a v0.1.2 release "commit" after this patch series is fully
>     reviewed, but before it's merged
> 
> Antonio Caggiano (2):
>    virtio-gpu: CONTEXT_INIT feature
>    virtio-gpu: blob prep
> 
> Dr. David Alan Gilbert (1):
>    virtio: Add shared memory capability
> 
> Gerd Hoffmann (1):
>    virtio-gpu: hostmem
> 
> Gurchetan Singh (5):
>    gfxstream + rutabaga prep: added need defintions, fields, and options
>    gfxstream + rutabaga: add initial support for gfxstream
>    gfxstream + rutabaga: meson support
>    gfxstream + rutabaga: enable rutabaga
>    docs/system: add basic virtio-gpu documentation
> 
>   docs/system/device-emulation.rst     |    1 +
>   docs/system/devices/virtio-gpu.rst   |   98 +++
>   hw/display/meson.build               |   22 +
>   hw/display/virtio-gpu-base.c         |    6 +-
>   hw/display/virtio-gpu-pci-rutabaga.c |   48 ++
>   hw/display/virtio-gpu-pci.c          |   14 +
>   hw/display/virtio-gpu-rutabaga.c     | 1077 ++++++++++++++++++++++++++
>   hw/display/virtio-gpu.c              |   17 +-
>   hw/display/virtio-vga-rutabaga.c     |   52 ++
>   hw/display/virtio-vga.c              |   33 +-
>   hw/virtio/virtio-pci.c               |   18 +
>   include/hw/virtio/virtio-gpu-bswap.h |   18 +
>   include/hw/virtio/virtio-gpu.h       |   41 +
>   include/hw/virtio/virtio-pci.h       |    4 +
>   meson.build                          |    7 +
>   meson_options.txt                    |    2 +
>   scripts/meson-buildoptions.sh        |    3 +
>   softmmu/qdev-monitor.c               |    3 +
>   softmmu/vl.c                         |    1 +
>   19 files changed, 1445 insertions(+), 20 deletions(-)
>   create mode 100644 docs/system/devices/virtio-gpu.rst
>   create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
>   create mode 100644 hw/display/virtio-gpu-rutabaga.c
>   create mode 100644 hw/display/virtio-vga-rutabaga.c
> 

