Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7017854C6
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 12:00:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYke9-0006KK-Sk; Wed, 23 Aug 2023 05:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qYke7-0006K7-L9
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:59:27 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qYke5-00056Z-K8
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:59:27 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6b9c9944da8so4125630a34.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 02:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692784764; x=1693389564;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pu3OsoD5x91KuH7OM+mz0eJReiEd4hHQdDlfN22n8QQ=;
 b=ew5VkdeZPJN8HmyZLf2HA/Q42vo1Zrel0d0gJHbV5aVPyt0Rb7js4IGnHCCAwdhO2k
 pByFzuudyieQfMnD9GyiBEyu5pPbkrbsfz2aGvjQX2TZ32mNSPlPUrHWcljZXc9qNnR3
 CD1Trv5tjkNuR/LNJv/Rzpby3BTLUuh6YdMhyXHKC6s4olyuiSjMN1Hyj6SUqNC4Mcjx
 3qEoppamyeLdXXyRIch7H61HF3HX2TyeY2/1W6LYMu1QAnypZOmfqn824pCMa4f+rAir
 8HuC2YdYdigoYskmSimqlKupW6HJdNPCns/2B8U761632/55Y695EfAfvbBfL45UIi2d
 UFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692784764; x=1693389564;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pu3OsoD5x91KuH7OM+mz0eJReiEd4hHQdDlfN22n8QQ=;
 b=jyxAqo3Xz4IPqLiC2MEoqR/WtvpmjgtWKb97pe1ustn1inNkRLzBm98OTPxT5dt51P
 iVa8xdhZa8H3QTXth8LJwLRKFPSzmMvaFs6DT56HnBNfMzhO5wEetcMdMfX3imqcnQxt
 rybxJ8ZOBPZY4zKx1Gpv80v2Sfc+XY+MyWvjEu8sn7LiW9Hnb5dtIRqX6piyjpFrs6UE
 mFXCobu1VdBHlEDk336j61cqlECmXCX/rgjvbBtm/7SN5u67xwrRuyDiCf1DL1xjLHg5
 r//BCjoK7l+Y6FKBsXuyp6o77rPpPpe1Gd9hK2R8+fOeLdrWgbtzfnRbpJbGpVtUaEeT
 fIlw==
X-Gm-Message-State: AOJu0YysKnHbIQXqPQnT014cmPNCRo47FlJOOIh3XSDrZWqVLSUABEiv
 aW0ddb7qC5Y7mKVJ2RuglM8=
X-Google-Smtp-Source: AGHT+IE3SrvbiobVYz/sAovZ4yR3uJVE5Ayu4IqeB8ILkzSjgbf+B28yGVeYva0vwLVF0CVio0igRg==
X-Received: by 2002:a05:6870:c22a:b0:1bb:6792:4787 with SMTP id
 z42-20020a056870c22a00b001bb67924787mr10527879oae.40.1692784764053; 
 Wed, 23 Aug 2023 02:59:24 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 28-20020a17090a019c00b00263d3448141sm10030358pjc.8.2023.08.23.02.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 02:59:23 -0700 (PDT)
Message-ID: <a189be69-6dbb-451e-998c-d6d07e88c453@gmail.com>
Date: Wed, 23 Aug 2023 18:59:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 6/9] gfxstream + rutabaga: add initial support for
 gfxstream
Content-Language: en-US
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, hi@alyssa.is, ernunes@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org
References: <20230823012541.485-1-gurchetansingh@chromium.org>
 <20230823012541.485-7-gurchetansingh@chromium.org>
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20230823012541.485-7-gurchetansingh@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-ot1-x331.google.com
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

On 2023/08/23 10:25, Gurchetan Singh wrote:
> This adds initial support for gfxstream and cross-domain.  Both
> features rely on virtio-gpu blob resources and context types, which
> are also implemented in this patch.
> 
> gfxstream has a long and illustrious history in Android graphics
> paravirtualization.  It has been powering graphics in the Android
> Studio Emulator for more than a decade, which is the main developer
> platform.
> 
> Originally conceived by Jesse Hall, it was first known as "EmuGL" [a].
> The key design characteristic was a 1:1 threading model and
> auto-generation, which fit nicely with the OpenGLES spec.  It also
> allowed easy layering with ANGLE on the host, which provides the GLES
> implementations on Windows or MacOS enviroments.
> 
> gfxstream has traditionally been maintained by a single engineer, and
> between 2015 to 2021, the goldfish throne passed to Frank Yang.
> Historians often remark this glorious reign ("pax gfxstreama" is the
> academic term) was comparable to that of Augustus and both Queen
> Elizabeths.  Just to name a few accomplishments in a resplendent
> panoply: higher versions of GLES, address space graphics, snapshot
> support and CTS compliant Vulkan [b].
> 
> One major drawback was the use of out-of-tree goldfish drivers.
> Android engineers didn't know much about DRM/KMS and especially TTM so
> a simple guest to host pipe was conceived.
> 
> Luckily, virtio-gpu 3D started to emerge in 2016 due to the work of
> the Mesa/virglrenderer communities.  In 2018, the initial virtio-gpu
> port of gfxstream was done by Cuttlefish enthusiast Alistair Delva.
> It was a symbol compatible replacement of virglrenderer [c] and named
> "AVDVirglrenderer".  This implementation forms the basis of the
> current gfxstream host implementation still in use today.
> 
> cross-domain support follows a similar arc.  Originally conceived by
> Wayland aficionado David Reveman and crosvm enjoyer Zach Reizner in
> 2018, it initially relied on the downstream "virtio-wl" device.
> 
> In 2020 and 2021, virtio-gpu was extended to include blob resources
> and multiple timelines by yours truly, features gfxstream/cross-domain
> both require to function correctly.
> 
> Right now, we stand at the precipice of a truly fantastic possibility:
> the Android Emulator powered by upstream QEMU and upstream Linux
> kernel.  gfxstream will then be packaged properfully, and app
> developers can even fix gfxstream bugs on their own if they encounter
> them.
> 
> It's been quite the ride, my friends.  Where will gfxstream head next,
> nobody really knows.  I wouldn't be surprised if it's around for
> another decade, maintained by a new generation of Android graphics
> enthusiasts.
> 
> Technical details:
>    - Very simple initial display integration: just used Pixman
>    - Largely, 1:1 mapping of virtio-gpu hypercalls to rutabaga function
>      calls
> 
> Next steps for Android VMs:
>    - The next step would be improving display integration and UI interfaces
>      with the goal of the QEMU upstream graphics being in an emulator
>      release [d].
> 
> Next steps for Linux VMs for display virtualization:
>    - For widespread distribution, someone needs to package Sommelier or the
>      wayland-proxy-virtwl [e] ideally into Debian main. In addition, newer
>      versions of the Linux kernel come with DRM_VIRTIO_GPU_KMS option,
>      which allows disabling KMS hypercalls.  If anyone cares enough, it'll
>      probably be possible to build a custom VM variant that uses this display
>      virtualization strategy.
> 
> [a] https://android-review.googlesource.com/c/platform/development/+/34470
> [b] https://android-review.googlesource.com/q/topic:%22vulkan-hostconnection-start%22
> [c] https://android-review.googlesource.com/c/device/generic/goldfish-opengl/+/761927
> [d] https://developer.android.com/studio/releases/emulator
> [e] https://github.com/talex5/wayland-proxy-virtwl
> 
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Tested-by: Alyssa Ross <hi@alyssa.is>
> Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> v1: Incorported various suggestions by Akihiko Odaki and Bernard Berschow
>      - Removed GET_VIRTIO_GPU_GL / GET_RUTABAGA macros
>      - Used error_report(..)
>      - Used g_autofree to fix leaks on error paths
>      - Removed unnecessary casts
>      - added virtio-gpu-pci-rutabaga.c + virtio-vga-rutabaga.c files
> 
> v2: Incorported various suggestions by Akihiko Odaki, Marc-André Lureau and
>      Bernard Berschow:
>      - Parenthesis in CHECK macro
>      - CHECK_RESULT(result, ..) --> CHECK(!result, ..)
>      - delay until g->parent_obj.enable = 1
>      - Additional cast fixes
>      - initialize directly in virtio_gpu_rutabaga_realize(..)
>      - add debug callback to hook into QEMU error's APIs
> 
> v3: Incorporated feedback from Akihiko Odaki and Alyssa Ross:
>      - Autodetect Wayland socket when not explicitly specified
>      - Fix map_blob error paths
>      - Add comment why we need both `res` and `resource` in create blob
>      - Cast and whitespace fixes
>      - Big endian check comes before virtio_gpu_rutabaga_init().
>      - VirtIOVGARUTABAGA --> VirtIOVGARutabaga
> 
> v4: Incorporated feedback from Akihiko Odaki and Alyssa Ross:
>      - Double checked all casts
>      - Remove unnecessary parenthesis
>      - Removed `resource` in create_blob
>      - Added comment about failure case
>      - Pass user-provided socket as-is
>      - Use stack variable rather than heap allocation
>      - Future-proofed map info API to give access flags as well
> 
> v5: Incorporated feedback from Akihiko Odaki:
>      - Check (ss.scanout_id < VIRTIO_GPU_MAX_SCANOUTS)
>      - Simplify num_capsets check
>      - Call cleanup mapping on error paths
>      - uint64_t --> void* for rutabaga_map(..)
>      - Removed unnecessary parenthesis
>      - Removed unnecessary cast
>      - #define UNIX_PATH_MAX sizeof((struct sockaddr_un) {}.sun_path)
>      - Reuse result variable
> 
> v6: Incorporated feedback from Akihiko Odaki:
>      - Remove unnecessary #ifndef
>      - Disable scanout when appropriate
>      - CHECK capset index within range outside loop
>      - Add capset_version
> 
> v7: Incorporated feedback from Akihiko Odaki:
>      - aio_bh_schedule_oneshot_full --> aio_bh_schedule_oneshot
> 
> v9: Incorportated feedback from Akihiko Odaki:
>      - Remove extra error_setg(..) after virtio_gpu_rutabaga_init(..)
>      - Add error_setg(..) after rutabaga_init(..)
> 
> v10: Incorportated feedback from Akihiko Odaki:
>      - error_setg(..) --> error_setg_errno(..) when appropriate
>      - virtio_gpu_rutabaga_init returns a bool instead of an int
> 
> v11: Incorportated feedback from Philippe Mathieu-Daudé:
>      - C-style /* */ comments and avoid // comments.
>      - GPL-2.0 --> GPL-2.0-or-later
> 
>   hw/display/virtio-gpu-pci-rutabaga.c |   50 ++
>   hw/display/virtio-gpu-rutabaga.c     | 1121 ++++++++++++++++++++++++++
>   hw/display/virtio-vga-rutabaga.c     |   53 ++
>   3 files changed, 1224 insertions(+)
>   create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
>   create mode 100644 hw/display/virtio-gpu-rutabaga.c
>   create mode 100644 hw/display/virtio-vga-rutabaga.c
> 
> diff --git a/hw/display/virtio-gpu-pci-rutabaga.c b/hw/display/virtio-gpu-pci-rutabaga.c
> new file mode 100644
> index 0000000000..311eff308a
> --- /dev/null
> +++ b/hw/display/virtio-gpu-pci-rutabaga.c
> @@ -0,0 +1,50 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */

For an one-line comment, just do:
/* SPDX-License-Identifier: GPL-2.0-or-later */

