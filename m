Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF65B7770D0
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 08:57:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTzaP-0001qa-96; Thu, 10 Aug 2023 02:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qTzaH-0001qP-Nf
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 02:55:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qTzaF-0002U6-Kw
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 02:55:49 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bbc06f830aso4477345ad.0
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 23:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691650545; x=1692255345;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1++nL/MiU2sIP3sjDdKQ9Id82Xc+o4+VrFOP8DqVsOo=;
 b=FKgD8bNlbbR3qS/2dRlA0Z5tRsScbnBJAgpXDmdo1XbzhnVCCBFv1CNfctviIt/bNP
 fDxWmPlgIjAOxt6y65Pu7UTifOm3Rv7RM1+IPXmFOmtsFlcWpV+z5yQmJVMkCz+FsYkx
 csL2GK05E5P3E8pu9rqnjOkTZOgAB9wWP10NitkxGh5fmJ7vEjIYQkxLZNCTyEMk2Wdq
 fXK5sdmKVWS5K5j9mJ7i/G8XQMa2UD0G8puEum6f6vpq+GxSKH4ETcEvWi+SVDggGLAy
 ye1SIZ4X1BVs3Eidi9PyEAtukTzWwvvMKQeby7rtuyWxiItJue4SPYqjhn0/6dhVVHsr
 sUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691650545; x=1692255345;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1++nL/MiU2sIP3sjDdKQ9Id82Xc+o4+VrFOP8DqVsOo=;
 b=f8i6vA0/KJf15btCfgkyQmGg0dPl/HjyP/KGJVteMlTqnKH0yHFOaKZ1ekm4CsDY8C
 +K8eV/QW1eVeKoR73nCHDScNu/QTsfbT8/fpdSVbrjE6h8VHkm5BZBp6AObVuX0KSqtP
 C9Lp8CklKvs0tQeSM6pLdR+UzkPqUws+ZrmihiAQKKmZDOv/ux1OTqJ711WKJap0HB5S
 JNGkH/Vb/I0C84Ce3xqtRzRINHM4HO0sn+oHmlP4popGtyPiBy/mgwBpUGWxW7ed6wma
 B+1hsCSV15pl7iaC/wsorIDqgN9SaacsFs+P6evDLeuIQ3rtIcPD+KA2JK2zzuUXBZZ/
 Qzpg==
X-Gm-Message-State: AOJu0YybYFV0bBHSpEZKnk/iO40jg7HhbD5IJ8cN/rbPsEJVDMJS5PcP
 Ez72wIB3yEouO2LXsmS/irA=
X-Google-Smtp-Source: AGHT+IGHtNJ0t9EVxpH1VNx01tiOgg13Bqr50puPiap4epIXA1RyzRvXDrTp3mVVFS4wAM6y7Upt5Q==
X-Received: by 2002:a17:902:e88e:b0:1bd:1b9a:fe61 with SMTP id
 w14-20020a170902e88e00b001bd1b9afe61mr1692851plg.6.1691650545306; 
 Wed, 09 Aug 2023 23:55:45 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 w4-20020a1709029a8400b001b9cdf11764sm817027plp.31.2023.08.09.23.55.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 23:55:44 -0700 (PDT)
Message-ID: <3fd3467c-e6ea-4cce-9d08-3ad521f66848@gmail.com>
Date: Thu, 10 Aug 2023 15:55:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] docs/system: add basic virtio-gpu documentation
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, kraxel@redhat.com,
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com
References: <20230809021108.674-1-gurchetansingh@chromium.org>
 <20230809021108.674-10-gurchetansingh@chromium.org>
 <41d8c647-164a-46ce-aaee-f48bc5f4d752@gmail.com>
 <CAAfnVB=Dbi8SiX1ZgbMHb3udTNNMUxwf78pt9sXjMYftGLveng@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <CAAfnVB=Dbi8SiX1ZgbMHb3udTNNMUxwf78pt9sXjMYftGLveng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pl1-x631.google.com
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

On 2023/08/10 10:11, Gurchetan Singh wrote:
> 
> 
> On Tue, Aug 8, 2023 at 10:18 PM Akihiko Odaki <akihiko.odaki@gmail.com 
> <mailto:akihiko.odaki@gmail.com>> wrote:
> 
>     On 2023/08/09 11:11, Gurchetan Singh wrote:
>      > This adds basic documentation for virtio-gpu.
>      >
>      > Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>
>      > Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org
>     <mailto:gurchetansingh@chromium.org>>
>      > ---
>      > v2: - Incorporated suggestions by Akihiko Odaki
>      >      - Listed the currently supported capset_names (Bernard)
>      >
>      > v3: - Incorporated suggestions by Akihiko Odaki and Alyssa Ross
>      >
>      > v4: - Incorporated suggestions by Akihiko Odaki
>      >
>      >   docs/system/device-emulation.rst   |   1 +
>      >   docs/system/devices/virtio-gpu.rst | 115
>     +++++++++++++++++++++++++++++
>      >   2 files changed, 116 insertions(+)
>      >   create mode 100644 docs/system/devices/virtio-gpu.rst
>      >
>      > diff --git a/docs/system/device-emulation.rst
>     b/docs/system/device-emulation.rst
>      > index 4491c4cbf7..1167f3a9f2 100644
>      > --- a/docs/system/device-emulation.rst
>      > +++ b/docs/system/device-emulation.rst
>      > @@ -91,6 +91,7 @@ Emulated Devices
>      >      devices/nvme.rst
>      >      devices/usb.rst
>      >      devices/vhost-user.rst
>      > +   devices/virtio-gpu.rst
>      >      devices/virtio-pmem.rst
>      >      devices/vhost-user-rng.rst
>      >      devices/canokey.rst
>      > diff --git a/docs/system/devices/virtio-gpu.rst
>     b/docs/system/devices/virtio-gpu.rst
>      > new file mode 100644
>      > index 0000000000..d56524270d
>      > --- /dev/null
>      > +++ b/docs/system/devices/virtio-gpu.rst
>      > @@ -0,0 +1,115 @@
>      > +..
>      > +   SPDX-License-Identifier: GPL-2.0
>      > +
>      > +virtio-gpu
>      > +==========
>      > +
>      > +This document explains the setup and usage of the virtio-gpu device.
>      > +The virtio-gpu device paravirtualizes the GPU and display
>     controller.
>      > +
>      > +Linux kernel support
>      > +--------------------
>      > +
>      > +virtio-gpu requires a guest Linux kernel built with the
>      > +``CONFIG_DRM_VIRTIO_GPU`` option.
>      > +
>      > +QEMU virtio-gpu variants
>      > +------------------------
>      > +
>      > +QEMU virtio-gpu device variants come in the following form:
>      > +
>      > + * ``virtio-vga[-BACKEND]``
>      > + * ``virtio-gpu[-BACKEND][-INTERFACE]``
>      > + * ``vhost-user-vga``
>      > + * ``vhost-user-pci``
>      > +
>      > +**Backends:** QEMU provides a 2D virtio-gpu backend, and two
>     accelerated
>      > +backends: virglrenderer ('gl' device label) and rutabaga_gfx
>     ('rutabaga'
>      > +device label).  There is a vhost-user backend that runs the
>     graphics stack
>      > +in a separate process for improved isolation.
>      > +
>      > +**Interfaces:** QEMU further categorizes virtio-gpu device
>     variants based
>      > +on the interface exposed to the guest. The interfaces can be
>     classified
>      > +into VGA and non-VGA variants. The VGA ones are prefixed with
>     virtio-vga
>      > +or vhost-user-vga while the non-VGA ones are prefixed with
>     virtio-gpu or
>      > +vhost-user-gpu.
>      > +
>      > +The VGA ones always use the PCI interface, but for the non-VGA
>     ones, the
>      > +user can further pick between MMIO or PCI. For MMIO, the user
>     can suffix
>      > +the device name with -device, though vhost-user-gpu does not
>     support MMIO.
>      > +For PCI, the user can suffix it with -pci. Without these
>     suffixes, the
>      > +platform default will be chosen.
>      > +
>      > +This document uses the PCI interface in examples.
> 
>     I think it's better to omit -pci.
> 
> 
> Are you suggesting to use "-device virtio-gpu-rutabaga" or "-device 
> virtio-gpu-gl" in the examples?  Or "-device virtio-gpu-rutabaga-device" 
> or "-device virtio-gpu-gl-device"?  The former I believe wouldn't 
> launch, and the examples should ideally be directly applicable to a user.
> 
> 
>     By the way you are not adding the aliases for Rutabaga so please do so.
>     You can find the table in: softmmu/qdev-monitor.c
> 
> 
> I don't follow this comment.  Isn't "-device virtio-gpu-rutabaga-pci" 
> (along with "-device virtio-gpu-rutabaga-device") an alias for the 
> rutabaga device?  Where would the alias be placed in the doc (we don't 
> explicitly list aliases for other devices either), outside the 
> "..parsed-literal::" launch command?

virtio-gpu-gl should work, and you need add an alias definition to get 
virtio-gpu-rutabaga work.

Your documentation already says:
 > Without these suffixes, the platform default will be chosen.

You should confirm what you say in the documentation and fix the 
documentation or code if something is wrong.

