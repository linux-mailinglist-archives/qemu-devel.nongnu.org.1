Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 831B47AA5C1
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 01:46:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjTM9-0004Wu-VO; Thu, 21 Sep 2023 19:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qjTM5-0004WV-PB
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 19:45:09 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qjTLx-0006YS-Aa
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 19:45:09 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9adcb89b48bso185539466b.2
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 16:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695339899; x=1695944699; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/XM1ohW0km32TP/I2TGiWPyXiUJC+StSf+mcGLqu4qc=;
 b=mGgFaSgv6qVLY06/bkpP1REy7aODZdJA9wP/pglmxOwF5IeZBE8ZDpw7EBCUCeXNKC
 zf6eupa1M3ZZWcRxnCMO37Hrws98keny19KIje67LWwYg3tYcqmZKcMMAVmZf6YReHnz
 bxPCef0T9/42mYo5RFXCxRF2CZIgXYZu0Xd0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695339899; x=1695944699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/XM1ohW0km32TP/I2TGiWPyXiUJC+StSf+mcGLqu4qc=;
 b=pOF2/GFWtp6qoOpfrQNgZY+O1kFrjeEnha0+Z3ptHX8KMexQ/Qs3MPcyqklsmCwPfq
 33FMWcH4a/lMTs6+F8gZw9Dd7C0Dfek3DSyi9QJnnf9UCXXrzlYX/qaIEYWLXrCBxSAo
 xn6pf7VuCDyNLh2d9FWBhSqM5EoHwd/Wg+9lksme26xw1gPzO4DXD3fegc4xyPOlaNLe
 hw/IxKYkL0CEBnF5LDppfv+DKHrxnO161/No5IuvNEyNUCDM+QQfOldL7aX3NRs8MaiO
 CGXPob7GpowWC79/5k7J3a+mfIMP41OnpixfWd0m/KIve4vtNNrSt5phv9I6zgYgvSuT
 C5rg==
X-Gm-Message-State: AOJu0YxZowV4JKvCjg4RGSK+BRD9RjZRa7m1MWSTTy3sL0HracBD+jtD
 uqI9YKQjsgKk4bbceilCLiqDnhFb7zed+cO/rTbhqw==
X-Google-Smtp-Source: AGHT+IE1jba9WVLwyJAaWCW89IctyHNuL3XSL+0Tz/Zg2cfCqSkOLNte4O0wwtfJDd/eKlhqQTcSkw==
X-Received: by 2002:a17:906:3045:b0:9a2:232f:6f85 with SMTP id
 d5-20020a170906304500b009a2232f6f85mr5549812ejd.52.1695339897832; 
 Thu, 21 Sep 2023 16:44:57 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com.
 [209.85.208.51]) by smtp.gmail.com with ESMTPSA id
 s12-20020a170906168c00b009737b8d47b6sm1724113ejd.203.2023.09.21.16.44.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 16:44:57 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-53368df6093so3660a12.1
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 16:44:56 -0700 (PDT)
X-Received: by 2002:a50:d0d9:0:b0:52e:f99a:b5f8 with SMTP id
 g25-20020a50d0d9000000b0052ef99ab5f8mr4341edf.7.1695339896418; Thu, 21 Sep
 2023 16:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230823012541.485-1-gurchetansingh@chromium.org>
 <20230823012541.485-7-gurchetansingh@chromium.org>
 <B1A4DF8C-3078-48AD-BC8B-F2FD7BA413CF@gmail.com>
 <CAAfnVBk6C7-Vn3buLOh453fz-dRB2vv-4BdkZWjuJDJoWLPAqA@mail.gmail.com>
 <D3C6E21B-E37E-41DA-8131-0C3D9EAF01FD@gmail.com>
 <CAAfnVBngeT8Ezt3osJW2NipFB3r9mJsLXzo1DEo4FtBaZpAO0w@mail.gmail.com>
 <ED6A24A1-42EC-47B2-A5D1-D57135A2D7D6@gmail.com>
 <83364d82-1a1e-4483-aad4-249ce30206a0@gmail.com>
In-Reply-To: <83364d82-1a1e-4483-aad4-249ce30206a0@gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 21 Sep 2023 16:44:42 -0700
X-Gmail-Original-Message-ID: <CAAfnVBmAJL4TsRFcfwNyXKG7FESNDV_k1m1HW8_oaOio0WdWKA@mail.gmail.com>
Message-ID: <CAAfnVBmAJL4TsRFcfwNyXKG7FESNDV_k1m1HW8_oaOio0WdWKA@mail.gmail.com>
Subject: Re: [PATCH v11 6/9] gfxstream + rutabaga: add initial support for
 gfxstream
To: Akihiko Odaki <akihiko.odaki@gmail.com>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, 
 ray.huang@amd.com, alex.bennee@linaro.org, hi@alyssa.is, ernunes@redhat.com, 
 manos.pitsidianakis@linaro.org, philmd@linaro.org, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004cfd7f0605e71496"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000004cfd7f0605e71496
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 3:07=E2=80=AFPM Akihiko Odaki <akihiko.odaki@gmail.=
com>
wrote:

> On 2023/09/20 3:36, Bernhard Beschow wrote:
> >
> >
> > Am 15. September 2023 02:38:02 UTC schrieb Gurchetan Singh <
> gurchetansingh@chromium.org>:
> >> On Thu, Sep 14, 2023 at 12:23=E2=80=AFAM Bernhard Beschow <shentey@gma=
il.com>
> wrote:
> >>
> >>>
> >>>
> >>> Am 14. September 2023 04:38:51 UTC schrieb Gurchetan Singh <
> >>> gurchetansingh@chromium.org>:
> >>>> On Wed, Sep 13, 2023 at 4:58=E2=80=AFAM Bernhard Beschow <shentey@gm=
ail.com>
> >>> wrote:
> >>>>
> >>>>>
> >>>>>
> >>>>> Am 23. August 2023 01:25:38 UTC schrieb Gurchetan Singh <
> >>>>> gurchetansingh@chromium.org>:
> >>>>>> This adds initial support for gfxstream and cross-domain.  Both
> >>>>>> features rely on virtio-gpu blob resources and context types, whic=
h
> >>>>>> are also implemented in this patch.
> >>>>>>
> >>>>>> gfxstream has a long and illustrious history in Android graphics
> >>>>>> paravirtualization.  It has been powering graphics in the Android
> >>>>>> Studio Emulator for more than a decade, which is the main develope=
r
> >>>>>> platform.
> >>>>>>
> >>>>>> Originally conceived by Jesse Hall, it was first known as "EmuGL"
> [a].
> >>>>>> The key design characteristic was a 1:1 threading model and
> >>>>>> auto-generation, which fit nicely with the OpenGLES spec.  It also
> >>>>>> allowed easy layering with ANGLE on the host, which provides the
> GLES
> >>>>>> implementations on Windows or MacOS enviroments.
> >>>>>>
> >>>>>> gfxstream has traditionally been maintained by a single engineer,
> and
> >>>>>> between 2015 to 2021, the goldfish throne passed to Frank Yang.
> >>>>>> Historians often remark this glorious reign ("pax gfxstreama" is t=
he
> >>>>>> academic term) was comparable to that of Augustus and both Queen
> >>>>>> Elizabeths.  Just to name a few accomplishments in a resplendent
> >>>>>> panoply: higher versions of GLES, address space graphics, snapshot
> >>>>>> support and CTS compliant Vulkan [b].
> >>>>>>
> >>>>>> One major drawback was the use of out-of-tree goldfish drivers.
> >>>>>> Android engineers didn't know much about DRM/KMS and especially TT=
M
> so
> >>>>>> a simple guest to host pipe was conceived.
> >>>>>>
> >>>>>> Luckily, virtio-gpu 3D started to emerge in 2016 due to the work o=
f
> >>>>>> the Mesa/virglrenderer communities.  In 2018, the initial virtio-g=
pu
> >>>>>> port of gfxstream was done by Cuttlefish enthusiast Alistair Delva=
.
> >>>>>> It was a symbol compatible replacement of virglrenderer [c] and
> named
> >>>>>> "AVDVirglrenderer".  This implementation forms the basis of the
> >>>>>> current gfxstream host implementation still in use today.
> >>>>>>
> >>>>>> cross-domain support follows a similar arc.  Originally conceived =
by
> >>>>>> Wayland aficionado David Reveman and crosvm enjoyer Zach Reizner i=
n
> >>>>>> 2018, it initially relied on the downstream "virtio-wl" device.
> >>>>>>
> >>>>>> In 2020 and 2021, virtio-gpu was extended to include blob resource=
s
> >>>>>> and multiple timelines by yours truly, features
> gfxstream/cross-domain
> >>>>>> both require to function correctly.
> >>>>>>
> >>>>>> Right now, we stand at the precipice of a truly fantastic
> possibility:
> >>>>>> the Android Emulator powered by upstream QEMU and upstream Linux
> >>>>>> kernel.  gfxstream will then be packaged properfully, and app
> >>>>>> developers can even fix gfxstream bugs on their own if they
> encounter
> >>>>>> them.
> >>>>>>
> >>>>>> It's been quite the ride, my friends.  Where will gfxstream head
> next,
> >>>>>> nobody really knows.  I wouldn't be surprised if it's around for
> >>>>>> another decade, maintained by a new generation of Android graphics
> >>>>>> enthusiasts.
> >>>>>>
> >>>>>> Technical details:
> >>>>>>   - Very simple initial display integration: just used Pixman
> >>>>>>   - Largely, 1:1 mapping of virtio-gpu hypercalls to rutabaga
> function
> >>>>>>     calls
> >>>>>>
> >>>>>> Next steps for Android VMs:
> >>>>>>   - The next step would be improving display integration and UI
> >>> interfaces
> >>>>>>     with the goal of the QEMU upstream graphics being in an emulat=
or
> >>>>>>     release [d].
> >>>>>>
> >>>>>> Next steps for Linux VMs for display virtualization:
> >>>>>>   - For widespread distribution, someone needs to package Sommelie=
r
> or
> >>> the
> >>>>>>     wayland-proxy-virtwl [e] ideally into Debian main. In addition=
,
> >>> newer
> >>>>>>     versions of the Linux kernel come with DRM_VIRTIO_GPU_KMS
> option,
> >>>>>>     which allows disabling KMS hypercalls.  If anyone cares enough=
,
> >>> it'll
> >>>>>>     probably be possible to build a custom VM variant that uses th=
is
> >>>>> display
> >>>>>>     virtualization strategy.
> >>>>>>
> >>>>>> [a]
> >>>>>
> https://android-review.googlesource.com/c/platform/development/+/34470
> >>>>>> [b]
> >>>>>
> >>>
> https://android-review.googlesource.com/q/topic:%22vulkan-hostconnection-=
start%22
> >>>>>> [c]
> >>>>>
> >>>
> https://android-review.googlesource.com/c/device/generic/goldfish-opengl/=
+/761927
> >>>>>> [d] https://developer.android.com/studio/releases/emulator
> >>>>>> [e] https://github.com/talex5/wayland-proxy-virtwl
> >>>>>>
> >>>>>> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> >>>>>> Tested-by: Alyssa Ross <hi@alyssa.is>
> >>>>>> Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org=
>
> >>>>>> Reviewed-by: Emmanouil Pitsidianakis <
> manos.pitsidianakis@linaro.org>
> >>>>>> ---
> >>>>>> v1: Incorported various suggestions by Akihiko Odaki and Bernard
> >>> Berschow
> >>>>>>     - Removed GET_VIRTIO_GPU_GL / GET_RUTABAGA macros
> >>>>>>     - Used error_report(..)
> >>>>>>     - Used g_autofree to fix leaks on error paths
> >>>>>>     - Removed unnecessary casts
> >>>>>>     - added virtio-gpu-pci-rutabaga.c + virtio-vga-rutabaga.c file=
s
> >>>>>>
> >>>>>> v2: Incorported various suggestions by Akihiko Odaki, Marc-Andr=C3=
=A9
> Lureau
> >>>>> and
> >>>>>>     Bernard Berschow:
> >>>>>>     - Parenthesis in CHECK macro
> >>>>>>     - CHECK_RESULT(result, ..) --> CHECK(!result, ..)
> >>>>>>     - delay until g->parent_obj.enable =3D 1
> >>>>>>     - Additional cast fixes
> >>>>>>     - initialize directly in virtio_gpu_rutabaga_realize(..)
> >>>>>>     - add debug callback to hook into QEMU error's APIs
> >>>>>>
> >>>>>> v3: Incorporated feedback from Akihiko Odaki and Alyssa Ross:
> >>>>>>     - Autodetect Wayland socket when not explicitly specified
> >>>>>>     - Fix map_blob error paths
> >>>>>>     - Add comment why we need both `res` and `resource` in create
> blob
> >>>>>>     - Cast and whitespace fixes
> >>>>>>     - Big endian check comes before virtio_gpu_rutabaga_init().
> >>>>>>     - VirtIOVGARUTABAGA --> VirtIOVGARutabaga
> >>>>>>
> >>>>>> v4: Incorporated feedback from Akihiko Odaki and Alyssa Ross:
> >>>>>>     - Double checked all casts
> >>>>>>     - Remove unnecessary parenthesis
> >>>>>>     - Removed `resource` in create_blob
> >>>>>>     - Added comment about failure case
> >>>>>>     - Pass user-provided socket as-is
> >>>>>>     - Use stack variable rather than heap allocation
> >>>>>>     - Future-proofed map info API to give access flags as well
> >>>>>>
> >>>>>> v5: Incorporated feedback from Akihiko Odaki:
> >>>>>>     - Check (ss.scanout_id < VIRTIO_GPU_MAX_SCANOUTS)
> >>>>>>     - Simplify num_capsets check
> >>>>>>     - Call cleanup mapping on error paths
> >>>>>>     - uint64_t --> void* for rutabaga_map(..)
> >>>>>>     - Removed unnecessary parenthesis
> >>>>>>     - Removed unnecessary cast
> >>>>>>     - #define UNIX_PATH_MAX sizeof((struct sockaddr_un) {}.sun_pat=
h)
> >>>>>>     - Reuse result variable
> >>>>>>
> >>>>>> v6: Incorporated feedback from Akihiko Odaki:
> >>>>>>     - Remove unnecessary #ifndef
> >>>>>>     - Disable scanout when appropriate
> >>>>>>     - CHECK capset index within range outside loop
> >>>>>>     - Add capset_version
> >>>>>>
> >>>>>> v7: Incorporated feedback from Akihiko Odaki:
> >>>>>>     - aio_bh_schedule_oneshot_full --> aio_bh_schedule_oneshot
> >>>>>>
> >>>>>> v9: Incorportated feedback from Akihiko Odaki:
> >>>>>>     - Remove extra error_setg(..) after virtio_gpu_rutabaga_init(.=
.)
> >>>>>>     - Add error_setg(..) after rutabaga_init(..)
> >>>>>>
> >>>>>> v10: Incorportated feedback from Akihiko Odaki:
> >>>>>>     - error_setg(..) --> error_setg_errno(..) when appropriate
> >>>>>>     - virtio_gpu_rutabaga_init returns a bool instead of an int
> >>>>>>
> >>>>>> v11: Incorportated feedback from Philippe Mathieu-Daud=C3=A9:
> >>>>>>     - C-style /* */ comments and avoid // comments.
> >>>>>>     - GPL-2.0 --> GPL-2.0-or-later
> >>>>>>
> >>>>>> hw/display/virtio-gpu-pci-rutabaga.c |   50 ++
> >>>>>> hw/display/virtio-gpu-rutabaga.c     | 1121
> ++++++++++++++++++++++++++
> >>>>>> hw/display/virtio-vga-rutabaga.c     |   53 ++
> >>>>>> 3 files changed, 1224 insertions(+)
> >>>>>> create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
> >>>>>> create mode 100644 hw/display/virtio-gpu-rutabaga.c
> >>>>>> create mode 100644 hw/display/virtio-vga-rutabaga.c
> >>>>>>
> >>>>>> diff --git a/hw/display/virtio-gpu-pci-rutabaga.c
> >>>>> b/hw/display/virtio-gpu-pci-rutabaga.c
> >>>>>> new file mode 100644
> >>>>>> index 0000000000..311eff308a
> >>>>>> --- /dev/null
> >>>>>> +++ b/hw/display/virtio-gpu-pci-rutabaga.c
> >>>>>> @@ -0,0 +1,50 @@
> >>>>>> +/*
> >>>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
> >>>>>> + */
> >>>>>> +
> >>>>>> +#include "qemu/osdep.h"
> >>>>>> +#include "qapi/error.h"
> >>>>>> +#include "qemu/module.h"
> >>>>>> +#include "hw/pci/pci.h"
> >>>>>> +#include "hw/qdev-properties.h"
> >>>>>> +#include "hw/virtio/virtio.h"
> >>>>>> +#include "hw/virtio/virtio-bus.h"
> >>>>>> +#include "hw/virtio/virtio-gpu-pci.h"
> >>>>>> +#include "qom/object.h"
> >>>>>> +
> >>>>>> +#define TYPE_VIRTIO_GPU_RUTABAGA_PCI "virtio-gpu-rutabaga-pci"
> >>>>>> +typedef struct VirtIOGPURutabagaPCI VirtIOGPURutabagaPCI;
> >>>>>> +DECLARE_INSTANCE_CHECKER(VirtIOGPURutabagaPCI,
> >>> VIRTIO_GPU_RUTABAGA_PCI,
> >>>>>> +                         TYPE_VIRTIO_GPU_RUTABAGA_PCI)
> >>>>>> +
> >>>>>> +struct VirtIOGPURutabagaPCI {
> >>>>>> +    VirtIOGPUPCIBase parent_obj;
> >>>>>> +    VirtIOGPURutabaga vdev;
> >>>>>> +};
> >>>>>> +
> >>>>>> +static void virtio_gpu_rutabaga_initfn(Object *obj)
> >>>>>> +{
> >>>>>> +    VirtIOGPURutabagaPCI *dev =3D VIRTIO_GPU_RUTABAGA_PCI(obj);
> >>>>>> +
> >>>>>> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev=
),
> >>>>>> +                                TYPE_VIRTIO_GPU_RUTABAGA);
> >>>>>> +    VIRTIO_GPU_PCI_BASE(obj)->vgpu =3D VIRTIO_GPU_BASE(&dev->vdev=
);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static const VirtioPCIDeviceTypeInfo virtio_gpu_rutabaga_pci_info
> =3D {
> >>>>>> +    .generic_name =3D TYPE_VIRTIO_GPU_RUTABAGA_PCI,
> >>>>>> +    .parent =3D TYPE_VIRTIO_GPU_PCI_BASE,
> >>>>>> +    .instance_size =3D sizeof(VirtIOGPURutabagaPCI),
> >>>>>> +    .instance_init =3D virtio_gpu_rutabaga_initfn,
> >>>>>> +};
> >>>>>> +module_obj(TYPE_VIRTIO_GPU_RUTABAGA_PCI);
> >>>>>> +module_kconfig(VIRTIO_PCI);
> >>>>>> +
> >>>>>> +static void virtio_gpu_rutabaga_pci_register_types(void)
> >>>>>> +{
> >>>>>> +    virtio_pci_types_register(&virtio_gpu_rutabaga_pci_info);
> >>>>>> +}
> >>>>>> +
> >>>>>> +type_init(virtio_gpu_rutabaga_pci_register_types)
> >>>>>> +
> >>>>>> +module_dep("hw-display-virtio-gpu-pci");
> >>>>>> diff --git a/hw/display/virtio-gpu-rutabaga.c
> >>>>> b/hw/display/virtio-gpu-rutabaga.c
> >>>>>> new file mode 100644
> >>>>>> index 0000000000..9018e5a702
> >>>>>> --- /dev/null
> >>>>>> +++ b/hw/display/virtio-gpu-rutabaga.c
> >>>>>> @@ -0,0 +1,1121 @@
> >>>>>> +/*
> >>>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
> >>>>>> + */
> >>>>>> +
> >>>>>> +#include "qemu/osdep.h"
> >>>>>> +#include "qapi/error.h"
> >>>>>> +#include "qemu/error-report.h"
> >>>>>> +#include "qemu/iov.h"
> >>>>>> +#include "trace.h"
> >>>>>> +#include "hw/virtio/virtio.h"
> >>>>>> +#include "hw/virtio/virtio-gpu.h"
> >>>>>> +#include "hw/virtio/virtio-gpu-pixman.h"
> >>>>>> +#include "hw/virtio/virtio-iommu.h"
> >>>>>> +
> >>>>>> +#include <glib/gmem.h>
> >>>>>> +#include <rutabaga_gfx/rutabaga_gfx_ffi.h>
> >>>>>> +
> >>>>>> +#define CHECK(condition, cmd)
> >>>>>       \
> >>>>>> +    do {
> >>>>>        \
> >>>>>> +        if (!(condition)) {
> >>>>>       \
> >>>>>> +            error_report("CHECK failed in %s() %s:" "%d", __func_=
_,
> >>>>>       \
> >>>>>> +                         __FILE__, __LINE__);
> >>>>>       \
> >>>>>> +            (cmd)->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
> >>>>>        \
> >>>>>> +            return;
> >>>>>       \
> >>>>>> +       }
> >>>>>        \
> >>>>>> +    } while (0)
> >>>>>> +
> >>>>>> +/*
> >>>>>> + * This is the size of the char array in struct sock_addr_un. No
> >>> Wayland
> >>>>> socket
> >>>>>> + * can be created with a path longer than this, including the nul=
l
> >>>>> terminator.
> >>>>>> + */
> >>>>>> +#define UNIX_PATH_MAX sizeof((struct sockaddr_un) {} .sun_path)
> >>>>>> +
> >>>>>> +struct rutabaga_aio_data {
> >>>>>> +    struct VirtIOGPURutabaga *vr;
> >>>>>> +    struct rutabaga_fence fence;
> >>>>>> +};
> >>>>>> +
> >>>>>> +static void
> >>>>>> +virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, struct
> >>>>> virtio_gpu_scanout *s,
> >>>>>> +                                  uint32_t resource_id)
> >>>>>> +{
> >>>>>> +    struct virtio_gpu_simple_resource *res;
> >>>>>> +    struct rutabaga_transfer transfer =3D { 0 };
> >>>>>> +    struct iovec transfer_iovec;
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    res =3D virtio_gpu_find_resource(g, resource_id);
> >>>>>> +    if (!res) {
> >>>>>> +        return;
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    if (res->width !=3D s->current_cursor->width ||
> >>>>>> +        res->height !=3D s->current_cursor->height) {
> >>>>>> +        return;
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    transfer.x =3D 0;
> >>>>>> +    transfer.y =3D 0;
> >>>>>> +    transfer.z =3D 0;
> >>>>>> +    transfer.w =3D res->width;
> >>>>>> +    transfer.h =3D res->height;
> >>>>>> +    transfer.d =3D 1;
> >>>>>> +
> >>>>>> +    transfer_iovec.iov_base =3D s->current_cursor->data;
> >>>>>> +    transfer_iovec.iov_len =3D res->width * res->height * 4;
> >>>>>> +
> >>>>>> +    rutabaga_resource_transfer_read(vr->rutabaga, 0,
> >>>>>> +                                    resource_id, &transfer,
> >>>>>> +                                    &transfer_iovec);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +virtio_gpu_rutabaga_gl_flushed(VirtIOGPUBase *b)
> >>>>>> +{
> >>>>>> +    VirtIOGPU *g =3D VIRTIO_GPU(b);
> >>>>>> +    virtio_gpu_process_cmdq(g);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +rutabaga_cmd_create_resource_2d(VirtIOGPU *g,
> >>>>>> +                                struct virtio_gpu_ctrl_command
> *cmd)
> >>>>>> +{
> >>>>>> +    int32_t result;
> >>>>>> +    struct rutabaga_create_3d rc_3d =3D { 0 };
> >>>>>> +    struct virtio_gpu_simple_resource *res;
> >>>>>> +    struct virtio_gpu_resource_create_2d c2d;
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(c2d);
> >>>>>> +    trace_virtio_gpu_cmd_res_create_2d(c2d.resource_id, c2d.forma=
t,
> >>>>>> +                                       c2d.width, c2d.height);
> >>>>>> +
> >>>>>> +    rc_3d.target =3D 2;
> >>>>>> +    rc_3d.format =3D c2d.format;
> >>>>>> +    rc_3d.bind =3D (1 << 1);
> >>>>>> +    rc_3d.width =3D c2d.width;
> >>>>>> +    rc_3d.height =3D c2d.height;
> >>>>>> +    rc_3d.depth =3D 1;
> >>>>>> +    rc_3d.array_size =3D 1;
> >>>>>> +    rc_3d.last_level =3D 0;
> >>>>>> +    rc_3d.nr_samples =3D 0;
> >>>>>> +    rc_3d.flags =3D VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
> >>>>>> +
> >>>>>> +    result =3D rutabaga_resource_create_3d(vr->rutabaga,
> >>> c2d.resource_id,
> >>>>> &rc_3d);
> >>>>>> +    CHECK(!result, cmd);
> >>>>>> +
> >>>>>> +    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
> >>>>>> +    res->width =3D c2d.width;
> >>>>>> +    res->height =3D c2d.height;
> >>>>>> +    res->format =3D c2d.format;
> >>>>>> +    res->resource_id =3D c2d.resource_id;
> >>>>>> +
> >>>>>> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
> >>>>>> +                                struct virtio_gpu_ctrl_command
> *cmd)
> >>>>>> +{
> >>>>>> +    int32_t result;
> >>>>>> +    struct rutabaga_create_3d rc_3d =3D { 0 };
> >>>>>> +    struct virtio_gpu_simple_resource *res;
> >>>>>> +    struct virtio_gpu_resource_create_3d c3d;
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(c3d);
> >>>>>> +
> >>>>>> +    trace_virtio_gpu_cmd_res_create_3d(c3d.resource_id, c3d.forma=
t,
> >>>>>> +                                       c3d.width, c3d.height,
> >>> c3d.depth);
> >>>>>> +
> >>>>>> +    rc_3d.target =3D c3d.target;
> >>>>>> +    rc_3d.format =3D c3d.format;
> >>>>>> +    rc_3d.bind =3D c3d.bind;
> >>>>>> +    rc_3d.width =3D c3d.width;
> >>>>>> +    rc_3d.height =3D c3d.height;
> >>>>>> +    rc_3d.depth =3D c3d.depth;
> >>>>>> +    rc_3d.array_size =3D c3d.array_size;
> >>>>>> +    rc_3d.last_level =3D c3d.last_level;
> >>>>>> +    rc_3d.nr_samples =3D c3d.nr_samples;
> >>>>>> +    rc_3d.flags =3D c3d.flags;
> >>>>>> +
> >>>>>> +    result =3D rutabaga_resource_create_3d(vr->rutabaga,
> >>> c3d.resource_id,
> >>>>> &rc_3d);
> >>>>>> +    CHECK(!result, cmd);
> >>>>>> +
> >>>>>> +    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
> >>>>>> +    res->width =3D c3d.width;
> >>>>>> +    res->height =3D c3d.height;
> >>>>>> +    res->format =3D c3d.format;
> >>>>>> +    res->resource_id =3D c3d.resource_id;
> >>>>>> +
> >>>>>> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +rutabaga_cmd_resource_unref(VirtIOGPU *g,
> >>>>>> +                            struct virtio_gpu_ctrl_command *cmd)
> >>>>>> +{
> >>>>>> +    int32_t result;
> >>>>>> +    struct virtio_gpu_simple_resource *res;
> >>>>>> +    struct virtio_gpu_resource_unref unref;
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(unref);
> >>>>>> +
> >>>>>> +    trace_virtio_gpu_cmd_res_unref(unref.resource_id);
> >>>>>> +
> >>>>>> +    res =3D virtio_gpu_find_resource(g, unref.resource_id);
> >>>>>> +    CHECK(res, cmd);
> >>>>>> +
> >>>>>> +    result =3D rutabaga_resource_unref(vr->rutabaga,
> unref.resource_id);
> >>>>>> +    CHECK(!result, cmd);
> >>>>>> +
> >>>>>> +    if (res->image) {
> >>>>>> +        pixman_image_unref(res->image);
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    QTAILQ_REMOVE(&g->reslist, res, next);
> >>>>>> +    g_free(res);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +rutabaga_cmd_context_create(VirtIOGPU *g,
> >>>>>> +                            struct virtio_gpu_ctrl_command *cmd)
> >>>>>> +{
> >>>>>> +    int32_t result;
> >>>>>> +    struct virtio_gpu_ctx_create cc;
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(cc);
> >>>>>> +    trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,
> >>>>>> +                                    cc.debug_name);
> >>>>>> +
> >>>>>> +    result =3D rutabaga_context_create(vr->rutabaga, cc.hdr.ctx_i=
d,
> >>>>>> +                                     cc.context_init,
> cc.debug_name,
> >>>>> cc.nlen);
> >>>>>> +    CHECK(!result, cmd);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +rutabaga_cmd_context_destroy(VirtIOGPU *g,
> >>>>>> +                             struct virtio_gpu_ctrl_command *cmd)
> >>>>>> +{
> >>>>>> +    int32_t result;
> >>>>>> +    struct virtio_gpu_ctx_destroy cd;
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(cd);
> >>>>>> +    trace_virtio_gpu_cmd_ctx_destroy(cd.hdr.ctx_id);
> >>>>>> +
> >>>>>> +    result =3D rutabaga_context_destroy(vr->rutabaga, cd.hdr.ctx_=
id);
> >>>>>> +    CHECK(!result, cmd);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +rutabaga_cmd_resource_flush(VirtIOGPU *g, struct
> >>> virtio_gpu_ctrl_command
> >>>>> *cmd)
> >>>>>> +{
> >>>>>> +    int32_t result, i;
> >>>>>> +    struct virtio_gpu_scanout *scanout =3D NULL;
> >>>>>> +    struct virtio_gpu_simple_resource *res;
> >>>>>> +    struct rutabaga_transfer transfer =3D { 0 };
> >>>>>> +    struct iovec transfer_iovec;
> >>>>>> +    struct virtio_gpu_resource_flush rf;
> >>>>>> +    bool found =3D false;
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +    if (vr->headless) {
> >>>>>> +        return;
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(rf);
> >>>>>> +    trace_virtio_gpu_cmd_res_flush(rf.resource_id,
> >>>>>> +                                   rf.r.width, rf.r.height, rf.r.=
x,
> >>>>> rf.r.y);
> >>>>>> +
> >>>>>> +    res =3D virtio_gpu_find_resource(g, rf.resource_id);
> >>>>>> +    CHECK(res, cmd);
> >>>>>> +
> >>>>>> +    for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
> >>>>>> +        scanout =3D &g->parent_obj.scanout[i];
> >>>>>> +        if (i =3D=3D res->scanout_bitmask) {
> >>>>>> +            found =3D true;
> >>>>>> +            break;
> >>>>>> +        }
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    if (!found) {
> >>>>>> +        return;
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    transfer.x =3D 0;
> >>>>>> +    transfer.y =3D 0;
> >>>>>> +    transfer.z =3D 0;
> >>>>>> +    transfer.w =3D res->width;
> >>>>>> +    transfer.h =3D res->height;
> >>>>>> +    transfer.d =3D 1;
> >>>>>> +
> >>>>>> +    transfer_iovec.iov_base =3D pixman_image_get_data(res->image)=
;
> >>>>>> +    transfer_iovec.iov_len =3D res->width * res->height * 4;
> >>>>>> +
> >>>>>> +    result =3D rutabaga_resource_transfer_read(vr->rutabaga, 0,
> >>>>>> +                                             rf.resource_id,
> >>> &transfer,
> >>>>>> +                                             &transfer_iovec);
> >>>>>> +    CHECK(!result, cmd);
> >>>>>> +    dpy_gfx_update_full(scanout->con);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +rutabaga_cmd_set_scanout(VirtIOGPU *g, struct
> virtio_gpu_ctrl_command
> >>>>> *cmd)
> >>>>>> +{
> >>>>>> +    struct virtio_gpu_simple_resource *res;
> >>>>>> +    struct virtio_gpu_scanout *scanout =3D NULL;
> >>>>>> +    struct virtio_gpu_set_scanout ss;
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +    if (vr->headless) {
> >>>>>> +        return;
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(ss);
> >>>>>> +    trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_i=
d,
> >>>>>> +                                     ss.r.width, ss.r.height,
> ss.r.x,
> >>>>> ss.r.y);
> >>>>>> +
> >>>>>> +    CHECK(ss.scanout_id < VIRTIO_GPU_MAX_SCANOUTS, cmd);
> >>>>>> +    scanout =3D &g->parent_obj.scanout[ss.scanout_id];
> >>>>>> +
> >>>>>> +    if (ss.resource_id =3D=3D 0) {
> >>>>>> +        dpy_gfx_replace_surface(scanout->con, NULL);
> >>>>>> +        dpy_gl_scanout_disable(scanout->con);
> >>>>>> +        return;
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    res =3D virtio_gpu_find_resource(g, ss.resource_id);
> >>>>>> +    CHECK(res, cmd);
> >>>>>> +
> >>>>>> +    if (!res->image) {
> >>>>>> +        pixman_format_code_t pformat;
> >>>>>> +        pformat =3D virtio_gpu_get_pixman_format(res->format);
> >>>>>> +        CHECK(pformat, cmd);
> >>>>>> +
> >>>>>> +        res->image =3D pixman_image_create_bits(pformat,
> >>>>>> +                                              res->width,
> >>>>>> +                                              res->height,
> >>>>>> +                                              NULL, 0);
> >>>>>> +        CHECK(res->image, cmd);
> >>>>>> +        pixman_image_ref(res->image);
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    g->parent_obj.enable =3D 1;
> >>>>>> +
> >>>>>> +    /* realloc the surface ptr */
> >>>>>> +    scanout->ds =3D qemu_create_displaysurface_pixman(res->image)=
;
> >>>>>> +    dpy_gfx_replace_surface(scanout->con, NULL);
> >>>>>> +    dpy_gfx_replace_surface(scanout->con, scanout->ds);
> >>>>>> +    res->scanout_bitmask =3D ss.scanout_id;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +rutabaga_cmd_submit_3d(VirtIOGPU *g,
> >>>>>> +                       struct virtio_gpu_ctrl_command *cmd)
> >>>>>> +{
> >>>>>> +    int32_t result;
> >>>>>> +    struct virtio_gpu_cmd_submit cs;
> >>>>>> +    struct rutabaga_command rutabaga_cmd =3D { 0 };
> >>>>>> +    g_autofree uint8_t *buf =3D NULL;
> >>>>>> +    size_t s;
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(cs);
> >>>>>> +    trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size);
> >>>>>> +
> >>>>>> +    buf =3D g_new0(uint8_t, cs.size);
> >>>>>> +    s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> >>>>>> +                   sizeof(cs), buf, cs.size);
> >>>>>> +    CHECK(s =3D=3D cs.size, cmd);
> >>>>>> +
> >>>>>> +    rutabaga_cmd.ctx_id =3D cs.hdr.ctx_id;
> >>>>>> +    rutabaga_cmd.cmd =3D buf;
> >>>>>> +    rutabaga_cmd.cmd_size =3D cs.size;
> >>>>>> +
> >>>>>> +    result =3D rutabaga_submit_command(vr->rutabaga, &rutabaga_cm=
d);
> >>>>>> +    CHECK(!result, cmd);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +rutabaga_cmd_transfer_to_host_2d(VirtIOGPU *g,
> >>>>>> +                                 struct virtio_gpu_ctrl_command
> *cmd)
> >>>>>> +{
> >>>>>> +    int32_t result;
> >>>>>> +    struct rutabaga_transfer transfer =3D { 0 };
> >>>>>> +    struct virtio_gpu_transfer_to_host_2d t2d;
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(t2d);
> >>>>>> +    trace_virtio_gpu_cmd_res_xfer_toh_2d(t2d.resource_id);
> >>>>>> +
> >>>>>> +    transfer.x =3D t2d.r.x;
> >>>>>> +    transfer.y =3D t2d.r.y;
> >>>>>> +    transfer.z =3D 0;
> >>>>>> +    transfer.w =3D t2d.r.width;
> >>>>>> +    transfer.h =3D t2d.r.height;
> >>>>>> +    transfer.d =3D 1;
> >>>>>> +
> >>>>>> +    result =3D rutabaga_resource_transfer_write(vr->rutabaga, 0,
> >>>>> t2d.resource_id,
> >>>>>> +                                              &transfer);
> >>>>>> +    CHECK(!result, cmd);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +rutabaga_cmd_transfer_to_host_3d(VirtIOGPU *g,
> >>>>>> +                                 struct virtio_gpu_ctrl_command
> *cmd)
> >>>>>> +{
> >>>>>> +    int32_t result;
> >>>>>> +    struct rutabaga_transfer transfer =3D { 0 };
> >>>>>> +    struct virtio_gpu_transfer_host_3d t3d;
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(t3d);
> >>>>>> +    trace_virtio_gpu_cmd_res_xfer_toh_3d(t3d.resource_id);
> >>>>>> +
> >>>>>> +    transfer.x =3D t3d.box.x;
> >>>>>> +    transfer.y =3D t3d.box.y;
> >>>>>> +    transfer.z =3D t3d.box.z;
> >>>>>> +    transfer.w =3D t3d.box.w;
> >>>>>> +    transfer.h =3D t3d.box.h;
> >>>>>> +    transfer.d =3D t3d.box.d;
> >>>>>> +    transfer.level =3D t3d.level;
> >>>>>> +    transfer.stride =3D t3d.stride;
> >>>>>> +    transfer.layer_stride =3D t3d.layer_stride;
> >>>>>> +    transfer.offset =3D t3d.offset;
> >>>>>> +
> >>>>>> +    result =3D rutabaga_resource_transfer_write(vr->rutabaga,
> >>>>> t3d.hdr.ctx_id,
> >>>>>> +                                              t3d.resource_id,
> >>>>> &transfer);
> >>>>>> +    CHECK(!result, cmd);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +rutabaga_cmd_transfer_from_host_3d(VirtIOGPU *g,
> >>>>>> +                                   struct virtio_gpu_ctrl_command
> >>> *cmd)
> >>>>>> +{
> >>>>>> +    int32_t result;
> >>>>>> +    struct rutabaga_transfer transfer =3D { 0 };
> >>>>>> +    struct virtio_gpu_transfer_host_3d t3d;
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(t3d);
> >>>>>> +    trace_virtio_gpu_cmd_res_xfer_fromh_3d(t3d.resource_id);
> >>>>>> +
> >>>>>> +    transfer.x =3D t3d.box.x;
> >>>>>> +    transfer.y =3D t3d.box.y;
> >>>>>> +    transfer.z =3D t3d.box.z;
> >>>>>> +    transfer.w =3D t3d.box.w;
> >>>>>> +    transfer.h =3D t3d.box.h;
> >>>>>> +    transfer.d =3D t3d.box.d;
> >>>>>> +    transfer.level =3D t3d.level;
> >>>>>> +    transfer.stride =3D t3d.stride;
> >>>>>> +    transfer.layer_stride =3D t3d.layer_stride;
> >>>>>> +    transfer.offset =3D t3d.offset;
> >>>>>> +
> >>>>>> +    result =3D rutabaga_resource_transfer_read(vr->rutabaga,
> >>>>> t3d.hdr.ctx_id,
> >>>>>> +                                             t3d.resource_id,
> >>> &transfer,
> >>>>> NULL);
> >>>>>> +    CHECK(!result, cmd);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +rutabaga_cmd_attach_backing(VirtIOGPU *g, struct
> >>> virtio_gpu_ctrl_command
> >>>>> *cmd)
> >>>>>> +{
> >>>>>> +    struct rutabaga_iovecs vecs =3D { 0 };
> >>>>>> +    struct virtio_gpu_simple_resource *res;
> >>>>>> +    struct virtio_gpu_resource_attach_backing att_rb;
> >>>>>> +    int ret;
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(att_rb);
> >>>>>> +    trace_virtio_gpu_cmd_res_back_attach(att_rb.resource_id);
> >>>>>> +
> >>>>>> +    res =3D virtio_gpu_find_resource(g, att_rb.resource_id);
> >>>>>> +    CHECK(res, cmd);
> >>>>>> +    CHECK(!res->iov, cmd);
> >>>>>> +
> >>>>>> +    ret =3D virtio_gpu_create_mapping_iov(g, att_rb.nr_entries,
> >>>>> sizeof(att_rb),
> >>>>>> +                                        cmd, NULL, &res->iov,
> >>>>> &res->iov_cnt);
> >>>>>> +    CHECK(!ret, cmd);
> >>>>>> +
> >>>>>> +    vecs.iovecs =3D res->iov;
> >>>>>> +    vecs.num_iovecs =3D res->iov_cnt;
> >>>>>> +
> >>>>>> +    ret =3D rutabaga_resource_attach_backing(vr->rutabaga,
> >>>>> att_rb.resource_id,
> >>>>>> +                                           &vecs);
> >>>>>> +    if (ret !=3D 0) {
> >>>>>> +        virtio_gpu_cleanup_mapping(g, res);
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    CHECK(!ret, cmd);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +rutabaga_cmd_detach_backing(VirtIOGPU *g, struct
> >>> virtio_gpu_ctrl_command
> >>>>> *cmd)
> >>>>>> +{
> >>>>>> +    struct virtio_gpu_simple_resource *res;
> >>>>>> +    struct virtio_gpu_resource_detach_backing detach_rb;
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(detach_rb);
> >>>>>> +    trace_virtio_gpu_cmd_res_back_detach(detach_rb.resource_id);
> >>>>>> +
> >>>>>> +    res =3D virtio_gpu_find_resource(g, detach_rb.resource_id);
> >>>>>> +    CHECK(res, cmd);
> >>>>>> +
> >>>>>> +    rutabaga_resource_detach_backing(vr->rutabaga,
> >>>>>> +                                     detach_rb.resource_id);
> >>>>>> +
> >>>>>> +    virtio_gpu_cleanup_mapping(g, res);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +rutabaga_cmd_ctx_attach_resource(VirtIOGPU *g,
> >>>>>> +                                 struct virtio_gpu_ctrl_command
> *cmd)
> >>>>>> +{
> >>>>>> +    int32_t result;
> >>>>>> +    struct virtio_gpu_ctx_resource att_res;
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(att_res);
> >>>>>> +    trace_virtio_gpu_cmd_ctx_res_attach(att_res.hdr.ctx_id,
> >>>>>> +                                        att_res.resource_id);
> >>>>>> +
> >>>>>> +    result =3D rutabaga_context_attach_resource(vr->rutabaga,
> >>>>> att_res.hdr.ctx_id,
> >>>>>> +                                              att_res.resource_id=
);
> >>>>>> +    CHECK(!result, cmd);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +rutabaga_cmd_ctx_detach_resource(VirtIOGPU *g,
> >>>>>> +                                 struct virtio_gpu_ctrl_command
> *cmd)
> >>>>>> +{
> >>>>>> +    int32_t result;
> >>>>>> +    struct virtio_gpu_ctx_resource det_res;
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(det_res);
> >>>>>> +    trace_virtio_gpu_cmd_ctx_res_detach(det_res.hdr.ctx_id,
> >>>>>> +                                        det_res.resource_id);
> >>>>>> +
> >>>>>> +    result =3D rutabaga_context_detach_resource(vr->rutabaga,
> >>>>> det_res.hdr.ctx_id,
> >>>>>> +                                              det_res.resource_id=
);
> >>>>>> +    CHECK(!result, cmd);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct
> >>>>> virtio_gpu_ctrl_command *cmd)
> >>>>>> +{
> >>>>>> +    int32_t result;
> >>>>>> +    struct virtio_gpu_get_capset_info info;
> >>>>>> +    struct virtio_gpu_resp_capset_info resp;
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(info);
> >>>>>> +
> >>>>>> +    result =3D rutabaga_get_capset_info(vr->rutabaga,
> info.capset_index,
> >>>>>> +                                      &resp.capset_id,
> >>>>> &resp.capset_max_version,
> >>>>>> +                                      &resp.capset_max_size);
> >>>>>> +    CHECK(!result, cmd);
> >>>>>> +
> >>>>>> +    resp.hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET_INFO;
> >>>>>> +    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +rutabaga_cmd_get_capset(VirtIOGPU *g, struct
> virtio_gpu_ctrl_command
> >>>>> *cmd)
> >>>>>> +{
> >>>>>> +    int32_t result;
> >>>>>> +    struct virtio_gpu_get_capset gc;
> >>>>>> +    struct virtio_gpu_resp_capset *resp;
> >>>>>> +    uint32_t capset_size, capset_version;
> >>>>>> +    uint32_t current_id, i;
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(gc);
> >>>>>> +    for (i =3D 0; i < vr->num_capsets; i++) {
> >>>>>> +        result =3D rutabaga_get_capset_info(vr->rutabaga, i,
> >>>>>> +                                          &current_id,
> >>> &capset_version,
> >>>>>> +                                          &capset_size);
> >>>>>> +        CHECK(!result, cmd);
> >>>>>> +
> >>>>>> +        if (current_id =3D=3D gc.capset_id) {
> >>>>>> +            break;
> >>>>>> +        }
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    CHECK(i < vr->num_capsets, cmd);
> >>>>>> +
> >>>>>> +    resp =3D g_malloc0(sizeof(*resp) + capset_size);
> >>>>>> +    resp->hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET;
> >>>>>> +    rutabaga_get_capset(vr->rutabaga, gc.capset_id,
> gc.capset_version,
> >>>>>> +                        resp->capset_data, capset_size);
> >>>>>> +
> >>>>>> +    virtio_gpu_ctrl_response(g, cmd, &resp->hdr, sizeof(*resp) +
> >>>>> capset_size);
> >>>>>> +    g_free(resp);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
> >>>>>> +                                  struct virtio_gpu_ctrl_command
> *cmd)
> >>>>>> +{
> >>>>>> +    int result;
> >>>>>> +    struct rutabaga_iovecs vecs =3D { 0 };
> >>>>>> +    g_autofree struct virtio_gpu_simple_resource *res =3D NULL;
> >>>>>> +    struct virtio_gpu_resource_create_blob cblob;
> >>>>>> +    struct rutabaga_create_blob rc_blob =3D { 0 };
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(cblob);
> >>>>>> +    trace_virtio_gpu_cmd_res_create_blob(cblob.resource_id,
> >>> cblob.size);
> >>>>>> +
> >>>>>> +    CHECK(cblob.resource_id !=3D 0, cmd);
> >>>>>> +
> >>>>>> +    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
> >>>>>> +
> >>>>>> +    res->resource_id =3D cblob.resource_id;
> >>>>>> +    res->blob_size =3D cblob.size;
> >>>>>> +
> >>>>>> +    if (cblob.blob_mem !=3D VIRTIO_GPU_BLOB_MEM_HOST3D) {
> >>>>>> +        result =3D virtio_gpu_create_mapping_iov(g, cblob.nr_entr=
ies,
> >>>>>> +                                               sizeof(cblob), cmd=
,
> >>>>> &res->addrs,
> >>>>>> +                                               &res->iov,
> >>> &res->iov_cnt);
> >>>>>> +        CHECK(!result, cmd);
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    rc_blob.blob_id =3D cblob.blob_id;
> >>>>>> +    rc_blob.blob_mem =3D cblob.blob_mem;
> >>>>>> +    rc_blob.blob_flags =3D cblob.blob_flags;
> >>>>>> +    rc_blob.size =3D cblob.size;
> >>>>>> +
> >>>>>> +    vecs.iovecs =3D res->iov;
> >>>>>> +    vecs.num_iovecs =3D res->iov_cnt;
> >>>>>> +
> >>>>>> +    result =3D rutabaga_resource_create_blob(vr->rutabaga,
> >>>>> cblob.hdr.ctx_id,
> >>>>>> +                                           cblob.resource_id,
> >>> &rc_blob,
> >>>>> &vecs,
> >>>>>> +                                           NULL);
> >>>>>> +
> >>>>>> +    if (result && cblob.blob_mem !=3D VIRTIO_GPU_BLOB_MEM_HOST3D)=
 {
> >>>>>> +        virtio_gpu_cleanup_mapping(g, res);
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    CHECK(!result, cmd);
> >>>>>> +
> >>>>>> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
> >>>>>> +    res =3D NULL;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +rutabaga_cmd_resource_map_blob(VirtIOGPU *g,
> >>>>>> +                               struct virtio_gpu_ctrl_command *cm=
d)
> >>>>>> +{
> >>>>>> +    int32_t result;
> >>>>>> +    uint32_t map_info =3D 0;
> >>>>>> +    uint32_t slot =3D 0;
> >>>>>> +    struct virtio_gpu_simple_resource *res;
> >>>>>> +    struct rutabaga_mapping mapping =3D { 0 };
> >>>>>> +    struct virtio_gpu_resource_map_blob mblob;
> >>>>>> +    struct virtio_gpu_resp_map_info resp =3D { 0 };
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(mblob);
> >>>>>> +
> >>>>>> +    CHECK(mblob.resource_id !=3D 0, cmd);
> >>>>>> +
> >>>>>> +    res =3D virtio_gpu_find_resource(g, mblob.resource_id);
> >>>>>> +    CHECK(res, cmd);
> >>>>>> +
> >>>>>> +    result =3D rutabaga_resource_map_info(vr->rutabaga,
> >>> mblob.resource_id,
> >>>>>> +                                        &map_info);
> >>>>>> +    CHECK(!result, cmd);
> >>>>>> +
> >>>>>> +    /*
> >>>>>> +     * RUTABAGA_MAP_ACCESS_* flags are not part of the virtio-gpu
> >>> spec,
> >>>>> but do
> >>>>>> +     * exist to potentially allow the hypervisor to restrict writ=
e
> >>>>> access to
> >>>>>> +     * memory. QEMU does not need to use this functionality at th=
e
> >>>>> moment.
> >>>>>> +     */
> >>>>>> +    resp.map_info =3D map_info & RUTABAGA_MAP_CACHE_MASK;
> >>>>>> +
> >>>>>> +    result =3D rutabaga_resource_map(vr->rutabaga, mblob.resource=
_id,
> >>>>> &mapping);
> >>>>>> +    CHECK(!result, cmd);
> >>>>>> +
> >>>>>> +    for (slot =3D 0; slot < MAX_SLOTS; slot++) {
> >>>>>> +        if (vr->memory_regions[slot].used) {
> >>>>>> +            continue;
> >>>>>> +        }
> >>>>>> +
> >>>>>> +        MemoryRegion *mr =3D &(vr->memory_regions[slot].mr);
> >>>>>> +        memory_region_init_ram_ptr(mr, NULL, "blob", mapping.size=
,
> >>>>>> +                                   mapping.ptr);
> >>>>>> +        memory_region_add_subregion(&g->parent_obj.hostmem,
> >>>>>> +                                    mblob.offset, mr);
> >>>>>> +        vr->memory_regions[slot].resource_id =3D mblob.resource_i=
d;
> >>>>>> +        vr->memory_regions[slot].used =3D 1;
> >>>>>> +        break;
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    if (slot >=3D MAX_SLOTS) {
> >>>>>> +        result =3D rutabaga_resource_unmap(vr->rutabaga,
> >>>>> mblob.resource_id);
> >>>>>> +        CHECK(!result, cmd);
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    CHECK(slot < MAX_SLOTS, cmd);
> >>>>>> +
> >>>>>> +    resp.hdr.type =3D VIRTIO_GPU_RESP_OK_MAP_INFO;
> >>>>>> +    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +rutabaga_cmd_resource_unmap_blob(VirtIOGPU *g,
> >>>>>> +                                 struct virtio_gpu_ctrl_command
> *cmd)
> >>>>>> +{
> >>>>>> +    int32_t result;
> >>>>>> +    uint32_t slot =3D 0;
> >>>>>> +    struct virtio_gpu_simple_resource *res;
> >>>>>> +    struct virtio_gpu_resource_unmap_blob ublob;
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(ublob);
> >>>>>> +
> >>>>>> +    CHECK(ublob.resource_id !=3D 0, cmd);
> >>>>>> +
> >>>>>> +    res =3D virtio_gpu_find_resource(g, ublob.resource_id);
> >>>>>> +    CHECK(res, cmd);
> >>>>>> +
> >>>>>> +    for (slot =3D 0; slot < MAX_SLOTS; slot++) {
> >>>>>> +        if (vr->memory_regions[slot].resource_id !=3D
> >>> ublob.resource_id) {
> >>>>>> +            continue;
> >>>>>> +        }
> >>>>>> +
> >>>>>> +        MemoryRegion *mr =3D &(vr->memory_regions[slot].mr);
> >>>>>> +        memory_region_del_subregion(&g->parent_obj.hostmem, mr);
> >>>>>> +
> >>>>>> +        vr->memory_regions[slot].resource_id =3D 0;
> >>>>>> +        vr->memory_regions[slot].used =3D 0;
> >>>>>> +        break;
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    CHECK(slot < MAX_SLOTS, cmd);
> >>>>>> +    result =3D rutabaga_resource_unmap(vr->rutabaga,
> res->resource_id);
> >>>>>> +    CHECK(!result, cmd);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +virtio_gpu_rutabaga_process_cmd(VirtIOGPU *g,
> >>>>>> +                                struct virtio_gpu_ctrl_command
> *cmd)
> >>>>>> +{
> >>>>>> +    struct rutabaga_fence fence =3D { 0 };
> >>>>>> +    int32_t result;
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
> >>>>>> +
> >>>>>> +    switch (cmd->cmd_hdr.type) {
> >>>>>> +    case VIRTIO_GPU_CMD_CTX_CREATE:
> >>>>>> +        rutabaga_cmd_context_create(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_CTX_DESTROY:
> >>>>>> +        rutabaga_cmd_context_destroy(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_2D:
> >>>>>> +        rutabaga_cmd_create_resource_2d(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_3D:
> >>>>>> +        rutabaga_cmd_create_resource_3d(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_SUBMIT_3D:
> >>>>>> +        rutabaga_cmd_submit_3d(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D:
> >>>>>> +        rutabaga_cmd_transfer_to_host_2d(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D:
> >>>>>> +        rutabaga_cmd_transfer_to_host_3d(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D:
> >>>>>> +        rutabaga_cmd_transfer_from_host_3d(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING:
> >>>>>> +        rutabaga_cmd_attach_backing(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:
> >>>>>> +        rutabaga_cmd_detach_backing(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_SET_SCANOUT:
> >>>>>> +        rutabaga_cmd_set_scanout(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_FLUSH:
> >>>>>> +        rutabaga_cmd_resource_flush(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_UNREF:
> >>>>>> +        rutabaga_cmd_resource_unref(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:
> >>>>>> +        rutabaga_cmd_ctx_attach_resource(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE:
> >>>>>> +        rutabaga_cmd_ctx_detach_resource(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_GET_CAPSET_INFO:
> >>>>>> +        rutabaga_cmd_get_capset_info(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_GET_CAPSET:
> >>>>>> +        rutabaga_cmd_get_capset(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:
> >>>>>> +        virtio_gpu_get_display_info(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_GET_EDID:
> >>>>>> +        virtio_gpu_get_edid(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB:
> >>>>>> +        rutabaga_cmd_resource_create_blob(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB:
> >>>>>> +        rutabaga_cmd_resource_map_blob(g, cmd);
> >>>>>> +        break;
> >>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:
> >>>>>> +        rutabaga_cmd_resource_unmap_blob(g, cmd);
> >>>>>> +        break;
> >>>>>> +    default:
> >>>>>> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
> >>>>>> +        break;
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    if (cmd->finished) {
> >>>>>> +        return;
> >>>>>> +    }
> >>>>>> +    if (cmd->error) {
> >>>>>> +        error_report("%s: ctrl 0x%x, error 0x%x", __func__,
> >>>>>> +                     cmd->cmd_hdr.type, cmd->error);
> >>>>>> +        virtio_gpu_ctrl_response_nodata(g, cmd, cmd->error);
> >>>>>> +        return;
> >>>>>> +    }
> >>>>>> +    if (!(cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE)) {
> >>>>>> +        virtio_gpu_ctrl_response_nodata(g, cmd,
> >>>>> VIRTIO_GPU_RESP_OK_NODATA);
> >>>>>> +        return;
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    fence.flags =3D cmd->cmd_hdr.flags;
> >>>>>> +    fence.ctx_id =3D cmd->cmd_hdr.ctx_id;
> >>>>>> +    fence.fence_id =3D cmd->cmd_hdr.fence_id;
> >>>>>> +    fence.ring_idx =3D cmd->cmd_hdr.ring_idx;
> >>>>>> +
> >>>>>> +    trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id,
> >>>>> cmd->cmd_hdr.type);
> >>>>>> +
> >>>>>> +    result =3D rutabaga_create_fence(vr->rutabaga, &fence);
> >>>>>> +    CHECK(!result, cmd);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +virtio_gpu_rutabaga_aio_cb(void *opaque)
> >>>>>> +{
> >>>>>> +    struct rutabaga_aio_data *data =3D opaque;
> >>>>>> +    VirtIOGPU *g =3D VIRTIO_GPU(data->vr);
> >>>>>> +    struct rutabaga_fence fence_data =3D data->fence;
> >>>>>> +    struct virtio_gpu_ctrl_command *cmd, *tmp;
> >>>>>> +
> >>>>>> +    uint32_t signaled_ctx_specific =3D fence_data.flags &
> >>>>>> +                                     RUTABAGA_FLAG_INFO_RING_IDX;
> >>>>>> +
> >>>>>> +    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
> >>>>>> +        /*
> >>>>>> +         * Due to context specific timelines.
> >>>>>> +         */
> >>>>>> +        uint32_t target_ctx_specific =3D cmd->cmd_hdr.flags &
> >>>>>> +                                       RUTABAGA_FLAG_INFO_RING_ID=
X;
> >>>>>> +
> >>>>>> +        if (signaled_ctx_specific !=3D target_ctx_specific) {
> >>>>>> +            continue;
> >>>>>> +        }
> >>>>>> +
> >>>>>> +        if (signaled_ctx_specific &&
> >>>>>> +           (cmd->cmd_hdr.ring_idx !=3D fence_data.ring_idx)) {
> >>>>>> +            continue;
> >>>>>> +        }
> >>>>>> +
> >>>>>> +        if (cmd->cmd_hdr.fence_id > fence_data.fence_id) {
> >>>>>> +            continue;
> >>>>>> +        }
> >>>>>> +
> >>>>>> +        trace_virtio_gpu_fence_resp(cmd->cmd_hdr.fence_id);
> >>>>>> +        virtio_gpu_ctrl_response_nodata(g, cmd,
> >>>>> VIRTIO_GPU_RESP_OK_NODATA);
> >>>>>> +        QTAILQ_REMOVE(&g->fenceq, cmd, next);
> >>>>>> +        g_free(cmd);
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    g_free(data);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +virtio_gpu_rutabaga_fence_cb(uint64_t user_data,
> >>>>>> +                             const struct rutabaga_fence *fence) =
{
> >>>>>> +    struct rutabaga_aio_data *data;
> >>>>>> +    VirtIOGPU *g =3D (VirtIOGPU *)user_data;
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +
> >>>>>> +    /*
> >>>>>> +     * gfxstream and both cross-domain (and even newer versions
> >>>>> virglrenderer:
> >>>>>> +     * see VIRGL_RENDERER_ASYNC_FENCE_CB) like to signal fence
> >>>>> completion on
> >>>>>> +     * threads ("callback threads") that are different from the
> thread
> >>>>> that
> >>>>>> +     * processes the command queue ("main thread").
> >>>>>> +     *
> >>>>>> +     * crosvm and other virtio-gpu 1.1 implementations enable
> callback
> >>>>> threads
> >>>>>> +     * via locking.  However, on QEMU a deadlock is observed if
> >>>>>> +     * virtio_gpu_ctrl_response_nodata(..) [used in the fence
> >>> callback]
> >>>>> is used
> >>>>>> +     * from a thread that is not the main thread.
> >>>>>> +     *
> >>>>>> +     * The reason is QEMU's internal locking is designed to work
> with
> >>>>> QEMU
> >>>>>> +     * threads (see rcu_register_thread()) and not generic
> C/C++/Rust
> >>>>> threads.
> >>>>>> +     * For now, we can workaround this by scheduling the return o=
f
> the
> >>>>>> +     * fence descriptors on the main thread.
> >>>>>> +     */
> >>>>>> +
> >>>>>> +    data =3D g_new0(struct rutabaga_aio_data, 1);
> >>>>>> +    data->vr =3D vr;
> >>>>>> +    data->fence =3D *fence;
> >>>>>> +    aio_bh_schedule_oneshot(qemu_get_aio_context(),
> >>>>>> +                            virtio_gpu_rutabaga_aio_cb,
> >>>>>> +                            data);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void
> >>>>>> +virtio_gpu_rutabaga_debug_cb(uint64_t user_data,
> >>>>>> +                             const struct rutabaga_debug *debug) =
{
> >>>>>> +
> >>>>>> +    if (debug->debug_type =3D=3D RUTABAGA_DEBUG_ERROR) {
> >>>>>> +        error_report("%s", debug->message);
> >>>>>> +    } else if (debug->debug_type =3D=3D RUTABAGA_DEBUG_WARN) {
> >>>>>> +        warn_report("%s", debug->message);
> >>>>>> +    } else if (debug->debug_type =3D=3D RUTABAGA_DEBUG_INFO) {
> >>>>>> +        info_report("%s", debug->message);
> >>>>>> +    }
> >>>>>> +}
> >>>>>> +
> >>>>>> +static bool virtio_gpu_rutabaga_init(VirtIOGPU *g, Error **errp)
> >>>>>> +{
> >>>>>> +    int result;
> >>>>>> +    uint64_t capset_mask;
> >>>>>> +    struct rutabaga_builder builder =3D { 0 };
> >>>>>> +    char wayland_socket_path[UNIX_PATH_MAX];
> >>>>>> +    struct rutabaga_channel channel =3D { 0 };
> >>>>>> +    struct rutabaga_channels channels =3D { 0 };
> >>>>>> +
> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> >>>>>> +    vr->rutabaga =3D NULL;
> >>>>>> +
> >>>>>> +    if (!vr->capset_names) {
> >>>>>> +        error_setg(errp, "a capset name from the virtio-gpu spec =
is
> >>>>> required");
> >>>>>> +        return false;
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    builder.wsi =3D RUTABAGA_WSI_SURFACELESS;
> >>>>>> +    /*
> >>>>>> +     * Currently, if WSI is specified, the only valid strings are
> >>>>> "surfaceless"
> >>>>>> +     * or "headless".  Surfaceless doesn't create a native window
> >>>>> surface, but
> >>>>>> +     * does copy from the render target to the Pixman buffer if a
> >>>>> virtio-gpu
> >>>>>> +     * 2D hypercall is issued.  Surfacless is the default.
> >>>>>> +     *
> >>>>>> +     * Headless is like surfaceless, but doesn't copy to the Pixm=
an
> >>>>> buffer. The
> >>>>>> +     * use case is automated testing environments where there is =
no
> >>> need
> >>>>> to view
> >>>>>> +     * results.
> >>>>>> +     *
> >>>>>> +     * In the future, more performant virtio-gpu 2D UI integratio=
n
> may
> >>>>> be added.
> >>>>>> +     */
> >>>>>> +    if (vr->wsi) {
> >>>>>> +        if (g_str_equal(vr->wsi, "surfaceless")) {
> >>>>>> +            vr->headless =3D false;
> >>>>>> +        } else if (g_str_equal(vr->wsi, "headless")) {
> >>>>>> +            vr->headless =3D true;
> >>>>>> +        } else {
> >>>>>> +            error_setg(errp, "invalid wsi option selected");
> >>>>>> +            return false;
> >>>>>> +        }
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    result =3D rutabaga_calculate_capset_mask(vr->capset_names,
> >>>>> &capset_mask);
> >>>>>
> >>>>> First, sorry for responding after such a long time. I've been busy
> with
> >>>>> work and I'm doing QEMU in my free time.
> >>>>>
> >>>>> In iteration 1 I've raised the topic on capset_names [1] and I
> haven't
> >>>>> seen it answered properly. Perhaps I need to rephrase a bit so here
> we
> >>> go:
> >>>>> capset_names seems to be colon-separated list of bit options manage=
d
> by
> >>>>> rutabaga. This introduces yet another way of options handling. Ther=
e
> >>> have
> >>>>> been talks about harmonizing options handling in QEMU since
> apparently
> >>> it
> >>>>> is considered too complex [2,3].
> >>>>
> >>>>
> >>>>> Why not pass the "capset" as a bitfield like capset_mask and have
> QEMU
> >>>>> create "capset" from QOM properties?
> >>>>
> >>>> IIUC these flags could come from virtio_gpu.h which is already
> present in
> >>>>> the QEMU tree. This would not inly shortcut the dependency on
> rutabaga
> >>> here
> >>>>> but would also be more idiomatic QEMU (since it makes the options
> more
> >>>>> introspectable by internal machinery).
> >>>>
> >>>>
> >>>>> Of course the bitfield approach would require modifications in QEMU
> >>>>> whenever rutabaga gains new features. However, I figure that in the
> long
> >>>>> term rutabaga will be quite feature complete such that the benefits
> of
> >>>>> idiomatic QEMU handling will outweigh the decoupling of the project=
s.
> >>>>>
> >>>>> What do you think?
> >>>>>
> >>>>
> >>>> I think what you're suggesting is something like -device
> >>>> virtio-gpu-rutabaga,capset_mask=3D0x10100 [40, which would be
> >>>> gfxstream_vulkan + cross_domain]?
> >>>
> >>> I was thinking more along the lines of
> >>> `virtio-gpu-rutabaga,gfxstream_vulkan=3Don,cross_domain=3Don` where
> >>> gfxstream_vulkan and cross_domain are boolean QOM properties. This
> would
> >>> make for a human-readable format which follows QEMU style.
> >>>
> >>>>
> >>>> We actually did consider something like that when adding the
> >>>> --context-types flag [with crosvm], but there was a desire for a
> >>>> human-readable format rather than numbers [even if they are in the
> >>>> virtio-gpu spec].
> >>>>
> >>>> Additionally, there are quite a few context types that people are
> playing
> >>>> around with [gfxstream-gles, gfxstream-composer] that are launchable
> and
> >>>> aren't in the spec just yet.
> >>>
> >>> Right, QEMU had to be modified for this kind of experimentation. I
> >>> considered this in my last paragraph and figured that in the long run
> QEMU
> >>> *may* prefer more idiomatic option handling since it tries hard to no=
t
> >>> break its command line interface. I'm just pointing this out -- the
> >>> decision is ultimately up to the community.
> >>>
> >>> Why not have dedicated QEMU development branches for experimentation?
> >>> Wouldn't upstreaming new features into QEMU be a good motivation to
> get the
> >>> missing pieces into the spec, once they are mature?
> >>
> >>
> >>>>
> >>>> Also, a key feature we want to explicitly **not** turn on all
> available
> >>>> context-types and let the user decide.
> >>>
> >>> How would you prevent that with the current colon-separated approach?
> >>> Splitting capset_mask in multiple parameters is just a different
> >>> syntactical representation of the same thing.
> >>>
> >>>> That'll allow guest Mesa in
> >>>> particular to do its magic in its loader.  So one may run Zink + ANV
> with
> >>>> ioctl forwarding, or Iris + ioctl forwarding and compare performance
> with
> >>>> the same guest image.
> >>>>
> >>>> And another thing is one needs some knowledge of the host system to
> choose
> >>>> the right context type.  You wouldn't do Zink + ANV ioctl forwarding
> on
> >>>> MacOS.  So I think the task of choosing the right context type will
> fall
> >>> to
> >>>> projects that depend on QEMU (such as Android Emulator) which have
> some
> >>>> knowledge of the host environment.
> >>>>
> >>>> We actually have a graphics detector somewhere that calls VK/OpenGL
> before
> >>>> launching the VM and sets the right options.  Plan is to port into
> >>>> gfxstream, maybe we could use that.
> >>>
> >>> You could bail out in QEMU if rutabaga_calculate_capset_mask() detect=
s
> >>> conflicting combinations, no?
> >>>
> >>>>
> >>>> So given the desire for human readable formats, being portable acros=
s
> VMMs
> >>>> (crosvm, qemu, rust-vmm??) and experimentation, the string -> capset
> mask
> >>>> conversion was put in the rutabaga API.  So I wouldn't change it for
> those
> >>>> reasons.
> >>>
> >>> What do you mean by being portable across VMMs?
> >>
> >>
> >> Having the API inside rutabaga is (mildly) useful when multiple VMMs
> have
> >> the need to translate from a human-readable format to flags digestible
> by
> >> rutabaga.
> >>
> >>
> https://android.googlesource.com/device/google/cuttlefish/+/refs/heads/ma=
in/host/libs/vm_manager/qemu_manager.cpp#452
> >>
> >>
> https://android.googlesource.com/device/google/cuttlefish/+/refs/heads/ma=
in/host/libs/vm_manager/crosvm_manager.cpp#353
> >>
> >>
> https://chromium.googlesource.com/chromiumos/platform2/+/refs/heads/main/=
vm_tools/concierge/vm_builder.cc#505
> >>
> >> For these crosvm/qemu launchers, I imagine capset names will be plumbe=
d
> all
> >> the way through eventually (launch_cvd
> >> --gpu_context=3Dgfxstream-vulkan:cross-domain if you've played around =
with
> >> Cuttlefish, or vmc start --gpu_contexts=3Dgfxstream-vulkan if you play=
ed
> >> around with Termina VMs).
> >>
> >> I think rust-vmm could also use the same API ("--capset_names") too.
> >>
> >>
> >>> Sure, QEMU had to be taught new flags before being able to use new
> >>> rutabaga features. I agree that this comes with a certain
> inconvenience.
> >>> But it may also be inconvenient for QEMU to deal with additional ad-h=
oc
> >>> options parsing when there are efforts for harmonization.
> >>>
> >>> Did my comments shed new light into the discussion?
> >>
> >>
> >> Yes, they do.  I agree with you that both crosvm/qemu have too many
> flags,
> >> and having a stable command line interface is important.  We are aimin=
g
> for
> >> stability with the `--capset_names=3D{colon string}` command line, and=
 at
> >> least for crosvm looking to deprecate older options [since we've never
> had
> >> an official release of crosvm yet].
> >>
> >> I do think:
> >>
> >> 1) "capset_names=3Dgfxstream-vulkan:cross-domain"
> >> 2) "cross-domain=3Don,gfxstream-vulkan=3Don"
> >>
> >> are similar enough.  I would choose (1) for since I think not
> duplicating
> >> the [name] -> flag logic and having a similar interface across VMMs +
> VMM
> >> launchers is ever-so slightly useful.
> >
> > I think we've now reached a good understanding of the issue. It's now u=
p
> to the QEMU community to make a choice. So I'm cc'ing Markus and Thomas a=
s
> the experts of the topic.
>
> As a virtio-gpu user, I'm slightly inclined to (2) since it would be
> easier to implement the same option for virtio-gpu-virgl when a need
> arises.
>

The rutabaga/virgl implementations will likely be done via DEFINE_PROP_BIT,
no?  For virgl, it'll set the virgl flags, and for rutabaga, it'll set the
capset mask.  So it would be different.

That said, the change isn't too bad to make.  Here's the key part:

+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -1084,6 +1084,14 @@ static Property virtio_gpu_rutabaga_properties[] =3D=
 {
     DEFINE_PROP_STRING("wayland_socket_path", VirtIOGPURutabaga,
                        wayland_socket_path),
     DEFINE_PROP_STRING("wsi", VirtIOGPURutabaga, wsi),
+    DEFINE_PROP_BIT("gfxstream-vulkan-experimental", VirtIOGPURutabaga,
+                    capset_mask, RUTABAGA_CAPSET_GFXSTREAM_VULKAN, false),
+    DEFINE_PROP_BIT("cross-domain-experimental", VirtIOGPURutabaga,
+                    capset_mask, RUTABAGA_CAPSET_CROSS_DOMAIN, false),
+    DEFINE_PROP_BIT("gfxstream-gles-experimental", VirtIOGPURutabaga,
+                    capset_mask, RUTABAGA_CAPSET_GFXSTREAM_GLES, false),
+    DEFINE_PROP_BIT("gfxstream-composer-experimental", VirtIOGPURutabaga,
+                    capset_mask, RUTABAGA_CAPSET_GFXSTREAM_COMPOSER,
false),
     DEFINE_PROP_END_OF_LIST(),
 };

One thing though: I borrowed a page of the Mesa-3d playbook (since they
land non-working/experimental drivers to speed development) and named all
gfxstream/rutabaga_gfx context types as "experimental".  That'll allow us
to experiment in-tree.

If you closely follow:

https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg03319.html

you may notice packaging/distributing rutabaga/gfxstream is low-priority,
since I do have the Android emulator use case in mind and I'm not sure
anybody else will find production targets for it in QEMU.  I think this is
somewhat closely related to crosvm/qemu has "too many flags" situation.
Many times a flag/config is landed, and production target changes, and the
history is lost.  By prefixing everything as "experimental", we explicitly
make it clear that QEMU makes no guarantees at this time regarding
rutabaga.  That'll allow hobbyists who build QEMU from sources anyways (the
main non-Android users of rutabaga/gfxstream) to play around with it
upstream, and also allow downstream to follow upstream but not make any
guarantees until everything is ready.

I'm curious what everyone thinks of the plan.

--0000000000004cfd7f0605e71496
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 19, 2023 at 3:07=E2=80=AF=
PM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@gmail.com" target=3D"_=
blank">akihiko.odaki@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On 2023/09/20 3:36, Bernhard Beschow wrote:<b=
r>
&gt; <br>
&gt; <br>
&gt; Am 15. September 2023 02:38:02 UTC schrieb Gurchetan Singh &lt;<a href=
=3D"mailto:gurchetansingh@chromium.org" target=3D"_blank">gurchetansingh@ch=
romium.org</a>&gt;:<br>
&gt;&gt; On Thu, Sep 14, 2023 at 12:23=E2=80=AFAM Bernhard Beschow &lt;<a h=
ref=3D"mailto:shentey@gmail.com" target=3D"_blank">shentey@gmail.com</a>&gt=
; wrote:<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Am 14. September 2023 04:38:51 UTC schrieb Gurchetan Singh &lt=
;<br>
&gt;&gt;&gt; <a href=3D"mailto:gurchetansingh@chromium.org" target=3D"_blan=
k">gurchetansingh@chromium.org</a>&gt;:<br>
&gt;&gt;&gt;&gt; On Wed, Sep 13, 2023 at 4:58=E2=80=AFAM Bernhard Beschow &=
lt;<a href=3D"mailto:shentey@gmail.com" target=3D"_blank">shentey@gmail.com=
</a>&gt;<br>
&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Am 23. August 2023 01:25:38 UTC schrieb Gurchetan Sing=
h &lt;<br>
&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:gurchetansingh@chromium.org" target=
=3D"_blank">gurchetansingh@chromium.org</a>&gt;:<br>
&gt;&gt;&gt;&gt;&gt;&gt; This adds initial support for gfxstream and cross-=
domain.=C2=A0 Both<br>
&gt;&gt;&gt;&gt;&gt;&gt; features rely on virtio-gpu blob resources and con=
text types, which<br>
&gt;&gt;&gt;&gt;&gt;&gt; are also implemented in this patch.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; gfxstream has a long and illustrious history in An=
droid graphics<br>
&gt;&gt;&gt;&gt;&gt;&gt; paravirtualization.=C2=A0 It has been powering gra=
phics in the Android<br>
&gt;&gt;&gt;&gt;&gt;&gt; Studio Emulator for more than a decade, which is t=
he main developer<br>
&gt;&gt;&gt;&gt;&gt;&gt; platform.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Originally conceived by Jesse Hall, it was first k=
nown as &quot;EmuGL&quot; [a].<br>
&gt;&gt;&gt;&gt;&gt;&gt; The key design characteristic was a 1:1 threading =
model and<br>
&gt;&gt;&gt;&gt;&gt;&gt; auto-generation, which fit nicely with the OpenGLE=
S spec.=C2=A0 It also<br>
&gt;&gt;&gt;&gt;&gt;&gt; allowed easy layering with ANGLE on the host, whic=
h provides the GLES<br>
&gt;&gt;&gt;&gt;&gt;&gt; implementations on Windows or MacOS enviroments.<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; gfxstream has traditionally been maintained by a s=
ingle engineer, and<br>
&gt;&gt;&gt;&gt;&gt;&gt; between 2015 to 2021, the goldfish throne passed t=
o Frank Yang.<br>
&gt;&gt;&gt;&gt;&gt;&gt; Historians often remark this glorious reign (&quot=
;pax gfxstreama&quot; is the<br>
&gt;&gt;&gt;&gt;&gt;&gt; academic term) was comparable to that of Augustus =
and both Queen<br>
&gt;&gt;&gt;&gt;&gt;&gt; Elizabeths.=C2=A0 Just to name a few accomplishmen=
ts in a resplendent<br>
&gt;&gt;&gt;&gt;&gt;&gt; panoply: higher versions of GLES, address space gr=
aphics, snapshot<br>
&gt;&gt;&gt;&gt;&gt;&gt; support and CTS compliant Vulkan [b].<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; One major drawback was the use of out-of-tree gold=
fish drivers.<br>
&gt;&gt;&gt;&gt;&gt;&gt; Android engineers didn&#39;t know much about DRM/K=
MS and especially TTM so<br>
&gt;&gt;&gt;&gt;&gt;&gt; a simple guest to host pipe was conceived.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Luckily, virtio-gpu 3D started to emerge in 2016 d=
ue to the work of<br>
&gt;&gt;&gt;&gt;&gt;&gt; the Mesa/virglrenderer communities.=C2=A0 In 2018,=
 the initial virtio-gpu<br>
&gt;&gt;&gt;&gt;&gt;&gt; port of gfxstream was done by Cuttlefish enthusias=
t Alistair Delva.<br>
&gt;&gt;&gt;&gt;&gt;&gt; It was a symbol compatible replacement of virglren=
derer [c] and named<br>
&gt;&gt;&gt;&gt;&gt;&gt; &quot;AVDVirglrenderer&quot;.=C2=A0 This implement=
ation forms the basis of the<br>
&gt;&gt;&gt;&gt;&gt;&gt; current gfxstream host implementation still in use=
 today.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; cross-domain support follows a similar arc.=C2=A0 =
Originally conceived by<br>
&gt;&gt;&gt;&gt;&gt;&gt; Wayland aficionado David Reveman and crosvm enjoye=
r Zach Reizner in<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2018, it initially relied on the downstream &quot;=
virtio-wl&quot; device.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; In 2020 and 2021, virtio-gpu was extended to inclu=
de blob resources<br>
&gt;&gt;&gt;&gt;&gt;&gt; and multiple timelines by yours truly, features gf=
xstream/cross-domain<br>
&gt;&gt;&gt;&gt;&gt;&gt; both require to function correctly.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Right now, we stand at the precipice of a truly fa=
ntastic possibility:<br>
&gt;&gt;&gt;&gt;&gt;&gt; the Android Emulator powered by upstream QEMU and =
upstream Linux<br>
&gt;&gt;&gt;&gt;&gt;&gt; kernel.=C2=A0 gfxstream will then be packaged prop=
erfully, and app<br>
&gt;&gt;&gt;&gt;&gt;&gt; developers can even fix gfxstream bugs on their ow=
n if they encounter<br>
&gt;&gt;&gt;&gt;&gt;&gt; them.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; It&#39;s been quite the ride, my friends.=C2=A0 Wh=
ere will gfxstream head next,<br>
&gt;&gt;&gt;&gt;&gt;&gt; nobody really knows.=C2=A0 I wouldn&#39;t be surpr=
ised if it&#39;s around for<br>
&gt;&gt;&gt;&gt;&gt;&gt; another decade, maintained by a new generation of =
Android graphics<br>
&gt;&gt;&gt;&gt;&gt;&gt; enthusiasts.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Technical details:<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0- Very simple initial display integrat=
ion: just used Pixman<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0- Largely, 1:1 mapping of virtio-gpu h=
ypercalls to rutabaga function<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0calls<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Next steps for Android VMs:<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0- The next step would be improving dis=
play integration and UI<br>
&gt;&gt;&gt; interfaces<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0with the goal of the QEMU upstr=
eam graphics being in an emulator<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0release [d].<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Next steps for Linux VMs for display virtualizatio=
n:<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0- For widespread distribution, someone=
 needs to package Sommelier or<br>
&gt;&gt;&gt; the<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0wayland-proxy-virtwl [e] ideall=
y into Debian main. In addition,<br>
&gt;&gt;&gt; newer<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0versions of the Linux kernel co=
me with DRM_VIRTIO_GPU_KMS option,<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0which allows disabling KMS hype=
rcalls.=C2=A0 If anyone cares enough,<br>
&gt;&gt;&gt; it&#39;ll<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0probably be possible to build a=
 custom VM variant that uses this<br>
&gt;&gt;&gt;&gt;&gt; display<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0virtualization strategy.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; [a]<br>
&gt;&gt;&gt;&gt;&gt; <a href=3D"https://android-review.googlesource.com/c/p=
latform/development/+/34470" rel=3D"noreferrer" target=3D"_blank">https://a=
ndroid-review.googlesource.com/c/platform/development/+/34470</a><br>
&gt;&gt;&gt;&gt;&gt;&gt; [b]<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; <a href=3D"https://android-review.googlesource.com/q/topic:%22=
vulkan-hostconnection-start%22" rel=3D"noreferrer" target=3D"_blank">https:=
//android-review.googlesource.com/q/topic:%22vulkan-hostconnection-start%22=
</a><br>
&gt;&gt;&gt;&gt;&gt;&gt; [c]<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; <a href=3D"https://android-review.googlesource.com/c/device/ge=
neric/goldfish-opengl/+/761927" rel=3D"noreferrer" target=3D"_blank">https:=
//android-review.googlesource.com/c/device/generic/goldfish-opengl/+/761927=
</a><br>
&gt;&gt;&gt;&gt;&gt;&gt; [d] <a href=3D"https://developer.android.com/studi=
o/releases/emulator" rel=3D"noreferrer" target=3D"_blank">https://developer=
.android.com/studio/releases/emulator</a><br>
&gt;&gt;&gt;&gt;&gt;&gt; [e] <a href=3D"https://github.com/talex5/wayland-p=
roxy-virtwl" rel=3D"noreferrer" target=3D"_blank">https://github.com/talex5=
/wayland-proxy-virtwl</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Signed-off-by: Gurchetan Singh &lt;<a href=3D"mail=
to:gurchetansingh@chromium.org" target=3D"_blank">gurchetansingh@chromium.o=
rg</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Tested-by: Alyssa Ross &lt;<a href=3D"mailto:hi@al=
yssa.is" target=3D"_blank">hi@alyssa.is</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Tested-by: Emmanouil Pitsidianakis &lt;<a href=3D"=
mailto:manos.pitsidianakis@linaro.org" target=3D"_blank">manos.pitsidianaki=
s@linaro.org</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Reviewed-by: Emmanouil Pitsidianakis &lt;<a href=
=3D"mailto:manos.pitsidianakis@linaro.org" target=3D"_blank">manos.pitsidia=
nakis@linaro.org</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&gt;&gt; v1: Incorported various suggestions by Akihiko Oda=
ki and Bernard<br>
&gt;&gt;&gt; Berschow<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Removed GET_VIRTIO_GPU_GL / G=
ET_RUTABAGA macros<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Used error_report(..)<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Used g_autofree to fix leaks =
on error paths<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Removed unnecessary casts<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- added virtio-gpu-pci-rutabaga=
.c + virtio-vga-rutabaga.c files<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; v2: Incorported various suggestions by Akihiko Oda=
ki, Marc-Andr=C3=A9 Lureau<br>
&gt;&gt;&gt;&gt;&gt; and<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Bernard Berschow:<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Parenthesis in CHECK macro<br=
>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- CHECK_RESULT(result, ..) --&g=
t; CHECK(!result, ..)<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- delay until g-&gt;parent_obj.=
enable =3D 1<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Additional cast fixes<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- initialize directly in virtio=
_gpu_rutabaga_realize(..)<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- add debug callback to hook in=
to QEMU error&#39;s APIs<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; v3: Incorporated feedback from Akihiko Odaki and A=
lyssa Ross:<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Autodetect Wayland socket whe=
n not explicitly specified<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Fix map_blob error paths<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Add comment why we need both =
`res` and `resource` in create blob<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Cast and whitespace fixes<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Big endian check comes before=
 virtio_gpu_rutabaga_init().<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- VirtIOVGARUTABAGA --&gt; Virt=
IOVGARutabaga<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; v4: Incorporated feedback from Akihiko Odaki and A=
lyssa Ross:<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Double checked all casts<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Remove unnecessary parenthesi=
s<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Removed `resource` in create_=
blob<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Added comment about failure c=
ase<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Pass user-provided socket as-=
is<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Use stack variable rather tha=
n heap allocation<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Future-proofed map info API t=
o give access flags as well<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; v5: Incorporated feedback from Akihiko Odaki:<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Check (ss.scanout_id &lt; VIR=
TIO_GPU_MAX_SCANOUTS)<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Simplify num_capsets check<br=
>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Call cleanup mapping on error=
 paths<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- uint64_t --&gt; void* for rut=
abaga_map(..)<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Removed unnecessary parenthes=
is<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Removed unnecessary cast<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- #define UNIX_PATH_MAX sizeof(=
(struct sockaddr_un) {}.sun_path)<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Reuse result variable<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; v6: Incorporated feedback from Akihiko Odaki:<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Remove unnecessary #ifndef<br=
>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Disable scanout when appropri=
ate<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- CHECK capset index within ran=
ge outside loop<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Add capset_version<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; v7: Incorporated feedback from Akihiko Odaki:<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- aio_bh_schedule_oneshot_full =
--&gt; aio_bh_schedule_oneshot<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; v9: Incorportated feedback from Akihiko Odaki:<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Remove extra error_setg(..) a=
fter virtio_gpu_rutabaga_init(..)<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- Add error_setg(..) after ruta=
baga_init(..)<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; v10: Incorportated feedback from Akihiko Odaki:<br=
>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- error_setg(..) --&gt; error_s=
etg_errno(..) when appropriate<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- virtio_gpu_rutabaga_init retu=
rns a bool instead of an int<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; v11: Incorportated feedback from Philippe Mathieu-=
Daud=C3=A9:<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- C-style /* */ comments and av=
oid // comments.<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0- GPL-2.0 --&gt; GPL-2.0-or-lat=
er<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; hw/display/virtio-gpu-pci-rutabaga.c |=C2=A0 =C2=
=A050 ++<br>
&gt;&gt;&gt;&gt;&gt;&gt; hw/display/virtio-gpu-rutabaga.c=C2=A0 =C2=A0 =C2=
=A0| 1121 ++++++++++++++++++++++++++<br>
&gt;&gt;&gt;&gt;&gt;&gt; hw/display/virtio-vga-rutabaga.c=C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A053 ++<br>
&gt;&gt;&gt;&gt;&gt;&gt; 3 files changed, 1224 insertions(+)<br>
&gt;&gt;&gt;&gt;&gt;&gt; create mode 100644 hw/display/virtio-gpu-pci-rutab=
aga.c<br>
&gt;&gt;&gt;&gt;&gt;&gt; create mode 100644 hw/display/virtio-gpu-rutabaga.=
c<br>
&gt;&gt;&gt;&gt;&gt;&gt; create mode 100644 hw/display/virtio-vga-rutabaga.=
c<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; diff --git a/hw/display/virtio-gpu-pci-rutabaga.c<=
br>
&gt;&gt;&gt;&gt;&gt; b/hw/display/virtio-gpu-pci-rutabaga.c<br>
&gt;&gt;&gt;&gt;&gt;&gt; new file mode 100644<br>
&gt;&gt;&gt;&gt;&gt;&gt; index 0000000000..311eff308a<br>
&gt;&gt;&gt;&gt;&gt;&gt; --- /dev/null<br>
&gt;&gt;&gt;&gt;&gt;&gt; +++ b/hw/display/virtio-gpu-pci-rutabaga.c<br>
&gt;&gt;&gt;&gt;&gt;&gt; @@ -0,0 +1,50 @@<br>
&gt;&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt;&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#include &quot;qapi/error.h&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#include &quot;qemu/module.h&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#include &quot;hw/pci/pci.h&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#include &quot;hw/virtio/virtio.h&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#include &quot;hw/virtio/virtio-bus.h&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#include &quot;hw/virtio/virtio-gpu-pci.h&quot;<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt; +#include &quot;qom/object.h&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#define TYPE_VIRTIO_GPU_RUTABAGA_PCI &quot;virtio=
-gpu-rutabaga-pci&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +typedef struct VirtIOGPURutabagaPCI VirtIOGPURuta=
bagaPCI;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +DECLARE_INSTANCE_CHECKER(VirtIOGPURutabagaPCI,<br=
>
&gt;&gt;&gt; VIRTIO_GPU_RUTABAGA_PCI,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_VIRTIO_GPU_RUTABAGA_PCI)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +struct VirtIOGPURutabagaPCI {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPUPCIBase parent_obj;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga vdev;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +};<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void virtio_gpu_rutabaga_initfn(Object *ob=
j)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabagaPCI *dev =3D VIRTI=
O_GPU_RUTABAGA_PCI(obj);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 virtio_instance_init_common(obj, &a=
mp;dev-&gt;vdev, sizeof(dev-&gt;vdev),<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_VIRTIO_=
GPU_RUTABAGA);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_PCI_BASE(obj)-&gt;vgpu =
=3D VIRTIO_GPU_BASE(&amp;dev-&gt;vdev);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static const VirtioPCIDeviceTypeInfo virtio_gpu_r=
utabaga_pci_info =3D {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 .generic_name =3D TYPE_VIRTIO_GPU_R=
UTABAGA_PCI,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 .parent =3D TYPE_VIRTIO_GPU_PCI_BAS=
E,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(VirtIOGPU=
RutabagaPCI),<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 .instance_init =3D virtio_gpu_rutab=
aga_initfn,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +};<br>
&gt;&gt;&gt;&gt;&gt;&gt; +module_obj(TYPE_VIRTIO_GPU_RUTABAGA_PCI);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +module_kconfig(VIRTIO_PCI);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void virtio_gpu_rutabaga_pci_register_type=
s(void)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 virtio_pci_types_register(&amp;virt=
io_gpu_rutabaga_pci_info);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +type_init(virtio_gpu_rutabaga_pci_register_types)=
<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +module_dep(&quot;hw-display-virtio-gpu-pci&quot;)=
;<br>
&gt;&gt;&gt;&gt;&gt;&gt; diff --git a/hw/display/virtio-gpu-rutabaga.c<br>
&gt;&gt;&gt;&gt;&gt; b/hw/display/virtio-gpu-rutabaga.c<br>
&gt;&gt;&gt;&gt;&gt;&gt; new file mode 100644<br>
&gt;&gt;&gt;&gt;&gt;&gt; index 0000000000..9018e5a702<br>
&gt;&gt;&gt;&gt;&gt;&gt; --- /dev/null<br>
&gt;&gt;&gt;&gt;&gt;&gt; +++ b/hw/display/virtio-gpu-rutabaga.c<br>
&gt;&gt;&gt;&gt;&gt;&gt; @@ -0,0 +1,1121 @@<br>
&gt;&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt;&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#include &quot;qapi/error.h&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#include &quot;qemu/error-report.h&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#include &quot;qemu/iov.h&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#include &quot;trace.h&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#include &quot;hw/virtio/virtio.h&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#include &quot;hw/virtio/virtio-gpu.h&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#include &quot;hw/virtio/virtio-gpu-pixman.h&quot=
;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#include &quot;hw/virtio/virtio-iommu.h&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#include &lt;glib/gmem.h&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#include &lt;rutabaga_gfx/rutabaga_gfx_ffi.h&gt;<=
br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#define CHECK(condition, cmd)<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 do {<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(condition)) {<b=
r>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_r=
eport(&quot;CHECK failed in %s() %s:&quot; &quot;%d&quot;, __func__,<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__FILE__, __LINE__);<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (cmd)-&=
gt;error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;=
<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 } while (0)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt;&gt; + * This is the size of the char array in struct s=
ock_addr_un. No<br>
&gt;&gt;&gt; Wayland<br>
&gt;&gt;&gt;&gt;&gt; socket<br>
&gt;&gt;&gt;&gt;&gt;&gt; + * can be created with a path longer than this, i=
ncluding the null<br>
&gt;&gt;&gt;&gt;&gt; terminator.<br>
&gt;&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt;&gt; +#define UNIX_PATH_MAX sizeof((struct sockaddr_un)=
 {} .sun_path)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +struct rutabaga_aio_data {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct VirtIOGPURutabaga *vr;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct rutabaga_fence fence;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +};<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, s=
truct<br>
&gt;&gt;&gt;&gt;&gt; virtio_gpu_scanout *s,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint3=
2_t resource_id)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *=
res;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct rutabaga_transfer transfer =
=3D { 0 };<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct iovec transfer_iovec;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g,=
 resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (!res) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (res-&gt;width !=3D s-&gt;curren=
t_cursor-&gt;width ||<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res-&gt;height !=3D s=
-&gt;current_cursor-&gt;height) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.x =3D 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.y =3D 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.z =3D 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.w =3D res-&gt;width;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.h =3D res-&gt;height;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.d =3D 1;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer_iovec.iov_base =3D s-&gt;c=
urrent_cursor-&gt;data;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer_iovec.iov_len =3D res-&gt;=
width * res-&gt;height * 4;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rutabaga_resource_transfer_read(vr-=
&gt;rutabaga, 0,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 resource_id, &amp;transfer,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;transfer_iovec);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +virtio_gpu_rutabaga_gl_flushed(VirtIOGPUBase *b)<=
br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPU *g =3D VIRTIO_GPU(b);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 virtio_gpu_process_cmdq(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +rutabaga_cmd_create_resource_2d(VirtIOGPU *g,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virti=
o_gpu_ctrl_command *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct rutabaga_create_3d rc_3d =3D=
 { 0 };<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *=
res;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resource_create_2=
d c2d;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(c2d);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_create_2d(=
c2d.resource_id, c2d.format,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0c2d.width, c2d.height);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_3d.target =3D 2;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_3d.format =3D c2d.format;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_3d.bind =3D (1 &lt;&lt; 1);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_3d.width =3D c2d.width;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_3d.height =3D c2d.height;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_3d.depth =3D 1;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_3d.array_size =3D 1;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_3d.last_level =3D 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_3d.nr_samples =3D 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_3d.flags =3D VIRTIO_GPU_RESOURCE=
_FLAG_Y_0_TOP;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_create=
_3d(vr-&gt;rutabaga,<br>
&gt;&gt;&gt; c2d.resource_id,<br>
&gt;&gt;&gt;&gt;&gt; &amp;rc_3d);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res =3D g_new0(struct virtio_gpu_si=
mple_resource, 1);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res-&gt;width =3D c2d.width;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res-&gt;height =3D c2d.height;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res-&gt;format =3D c2d.format;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res-&gt;resource_id =3D c2d.resourc=
e_id;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 QTAILQ_INSERT_HEAD(&amp;g-&gt;resli=
st, res, next);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +rutabaga_cmd_create_resource_3d(VirtIOGPU *g,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virti=
o_gpu_ctrl_command *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct rutabaga_create_3d rc_3d =3D=
 { 0 };<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *=
res;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resource_create_3=
d c3d;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(c3d);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_create_3d(=
c3d.resource_id, c3d.format,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0c3d.width, c3d.height,<br>
&gt;&gt;&gt; c3d.depth);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_3d.target =3D c3d.target;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_3d.format =3D c3d.format;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_3d.bind =3D c3d.bind;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_3d.width =3D c3d.width;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_3d.height =3D c3d.height;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_3d.depth =3D c3d.depth;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_3d.array_size =3D c3d.array_size=
;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_3d.last_level =3D c3d.last_level=
;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_3d.nr_samples =3D c3d.nr_samples=
;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_3d.flags =3D c3d.flags;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_create=
_3d(vr-&gt;rutabaga,<br>
&gt;&gt;&gt; c3d.resource_id,<br>
&gt;&gt;&gt;&gt;&gt; &amp;rc_3d);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res =3D g_new0(struct virtio_gpu_si=
mple_resource, 1);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res-&gt;width =3D c3d.width;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res-&gt;height =3D c3d.height;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res-&gt;format =3D c3d.format;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res-&gt;resource_id =3D c3d.resourc=
e_id;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 QTAILQ_INSERT_HEAD(&amp;g-&gt;resli=
st, res, next);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +rutabaga_cmd_resource_unref(VirtIOGPU *g,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_ctrl_com=
mand *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *=
res;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resource_unref un=
ref;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(unref);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_unref(unre=
f.resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g,=
 unref.resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(res, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_unref(=
vr-&gt;rutabaga, unref.resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (res-&gt;image) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pixman_image_unref(re=
s-&gt;image);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 QTAILQ_REMOVE(&amp;g-&gt;reslist, r=
es, next);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 g_free(res);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +rutabaga_cmd_context_create(VirtIOGPU *g,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_ctrl_com=
mand *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_ctx_create cc;<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(cc);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_ctx_create(cc.=
hdr.ctx_id,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 cc.debug_name);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 result =3D rutabaga_context_create(=
vr-&gt;rutabaga, cc.hdr.ctx_id,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cc.context_init, cc.debug_name,<br>
&gt;&gt;&gt;&gt;&gt; cc.nlen);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +rutabaga_cmd_context_destroy(VirtIOGPU *g,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ct=
rl_command *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_ctx_destroy cd;<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(cd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_ctx_destroy(cd=
.hdr.ctx_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 result =3D rutabaga_context_destroy=
(vr-&gt;rutabaga, cd.hdr.ctx_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +rutabaga_cmd_resource_flush(VirtIOGPU *g, struct<=
br>
&gt;&gt;&gt; virtio_gpu_ctrl_command<br>
&gt;&gt;&gt;&gt;&gt; *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int32_t result, i;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_scanout *scanout =
=3D NULL;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *=
res;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct rutabaga_transfer transfer =
=3D { 0 };<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct iovec transfer_iovec;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resource_flush rf=
;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 bool found =3D false;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (vr-&gt;headless) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(rf);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_flush(rf.r=
esource_id,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0rf.r.width, rf.r.height, rf.r.x,<br>
&gt;&gt;&gt;&gt;&gt; rf.r.y);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g,=
 rf.resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(res, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; g-&gt;parent_o=
bj.conf.max_outputs; i++) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 scanout =3D &amp;g-&g=
t;parent_obj.scanout[i];<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D res-&gt;=
scanout_bitmask) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 found =
=3D true;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<=
br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (!found) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.x =3D 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.y =3D 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.z =3D 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.w =3D res-&gt;width;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.h =3D res-&gt;height;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.d =3D 1;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer_iovec.iov_base =3D pixman_=
image_get_data(res-&gt;image);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer_iovec.iov_len =3D res-&gt;=
width * res-&gt;height * 4;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_transf=
er_read(vr-&gt;rutabaga, 0,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rf.resource_id,<br>
&gt;&gt;&gt; &amp;transfer,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;transfer_iovec);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 dpy_gfx_update_full(scanout-&gt;con=
);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +rutabaga_cmd_set_scanout(VirtIOGPU *g, struct vir=
tio_gpu_ctrl_command<br>
&gt;&gt;&gt;&gt;&gt; *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *=
res;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_scanout *scanout =
=3D NULL;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_set_scanout ss;<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (vr-&gt;headless) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(ss);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_set_scanout(ss=
.scanout_id, ss.resource_id,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ss.r.width, ss.r.height, ss.r.x,<br>
&gt;&gt;&gt;&gt;&gt; ss.r.y);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(ss.scanout_id &lt; VIRTIO_GPU=
_MAX_SCANOUTS, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 scanout =3D &amp;g-&gt;parent_obj.s=
canout[ss.scanout_id];<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (ss.resource_id =3D=3D 0) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_gfx_replace_surfa=
ce(scanout-&gt;con, NULL);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_gl_scanout_disabl=
e(scanout-&gt;con);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g,=
 ss.resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(res, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (!res-&gt;image) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pixman_format_code_t =
pformat;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pformat =3D virtio_gp=
u_get_pixman_format(res-&gt;format);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHECK(pformat, cmd);<=
br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res-&gt;image =3D pix=
man_image_create_bits(pformat,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res-&gt;width,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res-&gt;height,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, 0);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHECK(res-&gt;image, =
cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pixman_image_ref(res-=
&gt;image);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 g-&gt;parent_obj.enable =3D 1;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 /* realloc the surface ptr */<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 scanout-&gt;ds =3D qemu_create_disp=
laysurface_pixman(res-&gt;image);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 dpy_gfx_replace_surface(scanout-&gt=
;con, NULL);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 dpy_gfx_replace_surface(scanout-&gt=
;con, scanout-&gt;ds);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res-&gt;scanout_bitmask =3D ss.scan=
out_id;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +rutabaga_cmd_submit_3d(VirtIOGPU *g,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_command *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_cmd_submit cs;<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct rutabaga_command rutabaga_cm=
d =3D { 0 };<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 g_autofree uint8_t *buf =3D NULL;<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 size_t s;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(cs);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_ctx_submit(cs.=
hdr.ctx_id, cs.size);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 buf =3D g_new0(uint8_t, cs.size);<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 s =3D iov_to_buf(cmd-&gt;elem.out_s=
g, cmd-&gt;elem.out_num,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sizeof(cs), buf, cs.size);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(s =3D=3D cs.size, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rutabaga_cmd.ctx_id =3D cs.hdr.ctx_=
id;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rutabaga_cmd.cmd =3D buf;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rutabaga_cmd.cmd_size =3D cs.size;<=
br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 result =3D rutabaga_submit_command(=
vr-&gt;rutabaga, &amp;rutabaga_cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +rutabaga_cmd_transfer_to_host_2d(VirtIOGPU *g,<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=
 virtio_gpu_ctrl_command *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct rutabaga_transfer transfer =
=3D { 0 };<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_transfer_to_host_=
2d t2d;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(t2d);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_xfer_toh_2=
d(t2d.resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.x =3D t2d.r.x;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.y =3D t2d.r.y;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.z =3D 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.w =3D t2d.r.width;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.h =3D t2d.r.height;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.d =3D 1;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_transf=
er_write(vr-&gt;rutabaga, 0,<br>
&gt;&gt;&gt;&gt;&gt; t2d.resource_id,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;transfer);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +rutabaga_cmd_transfer_to_host_3d(VirtIOGPU *g,<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=
 virtio_gpu_ctrl_command *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct rutabaga_transfer transfer =
=3D { 0 };<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_transfer_host_3d =
t3d;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(t3d);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_xfer_toh_3=
d(t3d.resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.x =3D t3d.box.x;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.y =3D t3d.box.y;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.z =3D t3d.box.z;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.w =3D t3d.box.w;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.h =3D t3d.box.h;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.d =3D t3d.box.d;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.level =3D t3d.level;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.stride =3D t3d.stride;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.layer_stride =3D t3d.layer=
_stride;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.offset =3D t3d.offset;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_transf=
er_write(vr-&gt;rutabaga,<br>
&gt;&gt;&gt;&gt;&gt; t3d.hdr.ctx_id,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t3d.resource_id,<br>
&gt;&gt;&gt;&gt;&gt; &amp;transfer);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +rutabaga_cmd_transfer_from_host_3d(VirtIOGPU *g,<=
br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0struct virtio_gpu_ctrl_command<br>
&gt;&gt;&gt; *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct rutabaga_transfer transfer =
=3D { 0 };<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_transfer_host_3d =
t3d;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(t3d);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_xfer_fromh=
_3d(t3d.resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.x =3D t3d.box.x;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.y =3D t3d.box.y;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.z =3D t3d.box.z;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.w =3D t3d.box.w;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.h =3D t3d.box.h;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.d =3D t3d.box.d;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.level =3D t3d.level;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.stride =3D t3d.stride;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.layer_stride =3D t3d.layer=
_stride;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 transfer.offset =3D t3d.offset;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_transf=
er_read(vr-&gt;rutabaga,<br>
&gt;&gt;&gt;&gt;&gt; t3d.hdr.ctx_id,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t3d.resource_id,<br>
&gt;&gt;&gt; &amp;transfer,<br>
&gt;&gt;&gt;&gt;&gt; NULL);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +rutabaga_cmd_attach_backing(VirtIOGPU *g, struct<=
br>
&gt;&gt;&gt; virtio_gpu_ctrl_command<br>
&gt;&gt;&gt;&gt;&gt; *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct rutabaga_iovecs vecs =3D { 0=
 };<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *=
res;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resource_attach_b=
acking att_rb;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int ret;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(att_rb);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_back_attac=
h(att_rb.resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g,=
 att_rb.resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(res, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!res-&gt;iov, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 ret =3D virtio_gpu_create_mapping_i=
ov(g, att_rb.nr_entries,<br>
&gt;&gt;&gt;&gt;&gt; sizeof(att_rb),<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 cmd, NULL, &amp;res-&gt;iov,<br>
&gt;&gt;&gt;&gt;&gt; &amp;res-&gt;iov_cnt);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!ret, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 vecs.iovecs =3D res-&gt;iov;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 vecs.num_iovecs =3D res-&gt;iov_cnt=
;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 ret =3D rutabaga_resource_attach_ba=
cking(vr-&gt;rutabaga,<br>
&gt;&gt;&gt;&gt;&gt; att_rb.resource_id,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;vecs);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (ret !=3D 0) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_cleanup_ma=
pping(g, res);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!ret, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +rutabaga_cmd_detach_backing(VirtIOGPU *g, struct<=
br>
&gt;&gt;&gt; virtio_gpu_ctrl_command<br>
&gt;&gt;&gt;&gt;&gt; *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *=
res;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resource_detach_b=
acking detach_rb;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(detach_rb);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_back_detac=
h(detach_rb.resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g,=
 detach_rb.resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(res, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rutabaga_resource_detach_backing(vr=
-&gt;rutabaga,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0detach_rb.resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 virtio_gpu_cleanup_mapping(g, res);=
<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +rutabaga_cmd_ctx_attach_resource(VirtIOGPU *g,<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=
 virtio_gpu_ctrl_command *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_ctx_resource att_=
res;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(att_res);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_ctx_res_attach=
(att_res.hdr.ctx_id,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 att_res.resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 result =3D rutabaga_context_attach_=
resource(vr-&gt;rutabaga,<br>
&gt;&gt;&gt;&gt;&gt; att_res.hdr.ctx_id,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 att_res.resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +rutabaga_cmd_ctx_detach_resource(VirtIOGPU *g,<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=
 virtio_gpu_ctrl_command *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_ctx_resource det_=
res;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(det_res);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_ctx_res_detach=
(det_res.hdr.ctx_id,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 det_res.resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 result =3D rutabaga_context_detach_=
resource(vr-&gt;rutabaga,<br>
&gt;&gt;&gt;&gt;&gt; det_res.hdr.ctx_id,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 det_res.resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct=
<br>
&gt;&gt;&gt;&gt;&gt; virtio_gpu_ctrl_command *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_get_capset_info i=
nfo;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resp_capset_info =
resp;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(info);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 result =3D rutabaga_get_capset_info=
(vr-&gt;rutabaga, info.capset_index,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &amp;resp.capset_id,<br>
&gt;&gt;&gt;&gt;&gt; &amp;resp.capset_max_version,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &amp;resp.capset_max_size);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 resp.hdr.type =3D VIRTIO_GPU_RESP_O=
K_CAPSET_INFO;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 virtio_gpu_ctrl_response(g, cmd, &a=
mp;resp.hdr, sizeof(resp));<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +rutabaga_cmd_get_capset(VirtIOGPU *g, struct virt=
io_gpu_ctrl_command<br>
&gt;&gt;&gt;&gt;&gt; *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_get_capset gc;<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resp_capset *resp=
;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t capset_size, capset_versio=
n;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t current_id, i;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(gc);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; vr-&gt;num_cap=
sets; i++) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D rutabaga_g=
et_capset_info(vr-&gt;rutabaga, i,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;current_id,<br>
&gt;&gt;&gt; &amp;capset_version,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;capset_size);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHECK(!result, cmd);<=
br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (current_id =3D=3D=
 gc.capset_id) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<=
br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(i &lt; vr-&gt;num_capsets, cm=
d);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 resp =3D g_malloc0(sizeof(*resp) + =
capset_size);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 resp-&gt;hdr.type =3D VIRTIO_GPU_RE=
SP_OK_CAPSET;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rutabaga_get_capset(vr-&gt;rutabaga=
, gc.capset_id, gc.capset_version,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resp-&gt;capset_data, capset_size);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 virtio_gpu_ctrl_response(g, cmd, &a=
mp;resp-&gt;hdr, sizeof(*resp) +<br>
&gt;&gt;&gt;&gt;&gt; capset_size);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 g_free(resp);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +rutabaga_cmd_resource_create_blob(VirtIOGPU *g,<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struc=
t virtio_gpu_ctrl_command *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int result;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct rutabaga_iovecs vecs =3D { 0=
 };<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 g_autofree struct virtio_gpu_simple=
_resource *res =3D NULL;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resource_create_b=
lob cblob;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct rutabaga_create_blob rc_blob=
 =3D { 0 };<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(cblob);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_create_blo=
b(cblob.resource_id,<br>
&gt;&gt;&gt; cblob.size);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(cblob.resource_id !=3D 0, cmd=
);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res =3D g_new0(struct virtio_gpu_si=
mple_resource, 1);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res-&gt;resource_id =3D cblob.resou=
rce_id;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res-&gt;blob_size =3D cblob.size;<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (cblob.blob_mem !=3D VIRTIO_GPU_=
BLOB_MEM_HOST3D) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D virtio_gpu=
_create_mapping_iov(g, cblob.nr_entries,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(cblob), cmd,<br>
&gt;&gt;&gt;&gt;&gt; &amp;res-&gt;addrs,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;res-&gt;iov,<br>
&gt;&gt;&gt; &amp;res-&gt;iov_cnt);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHECK(!result, cmd);<=
br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_blob.blob_id =3D cblob.blob_id;<=
br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_blob.blob_mem =3D cblob.blob_mem=
;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_blob.blob_flags =3D cblob.blob_f=
lags;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 rc_blob.size =3D cblob.size;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 vecs.iovecs =3D res-&gt;iov;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 vecs.num_iovecs =3D res-&gt;iov_cnt=
;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_create=
_blob(vr-&gt;rutabaga,<br>
&gt;&gt;&gt;&gt;&gt; cblob.hdr.ctx_id,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cblob.resource_id,<br>
&gt;&gt;&gt; &amp;rc_blob,<br>
&gt;&gt;&gt;&gt;&gt; &amp;vecs,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (result &amp;&amp; cblob.blob_me=
m !=3D VIRTIO_GPU_BLOB_MEM_HOST3D) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_cleanup_ma=
pping(g, res);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 QTAILQ_INSERT_HEAD(&amp;g-&gt;resli=
st, res, next);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res =3D NULL;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +rutabaga_cmd_resource_map_blob(VirtIOGPU *g,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio=
_gpu_ctrl_command *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t map_info =3D 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t slot =3D 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *=
res;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct rutabaga_mapping mapping =3D=
 { 0 };<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resource_map_blob=
 mblob;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resp_map_info res=
p =3D { 0 };<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(mblob);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(mblob.resource_id !=3D 0, cmd=
);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g,=
 mblob.resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(res, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_map_in=
fo(vr-&gt;rutabaga,<br>
&gt;&gt;&gt; mblob.resource_id,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &amp;map_info);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 /*<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* RUTABAGA_MAP_ACCESS_* flags=
 are not part of the virtio-gpu<br>
&gt;&gt;&gt; spec,<br>
&gt;&gt;&gt;&gt;&gt; but do<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* exist to potentially allow =
the hypervisor to restrict write<br>
&gt;&gt;&gt;&gt;&gt; access to<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* memory. QEMU does not need =
to use this functionality at the<br>
&gt;&gt;&gt;&gt;&gt; moment.<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 resp.map_info =3D map_info &amp; RU=
TABAGA_MAP_CACHE_MASK;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_map(vr=
-&gt;rutabaga, mblob.resource_id,<br>
&gt;&gt;&gt;&gt;&gt; &amp;mapping);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 for (slot =3D 0; slot &lt; MAX_SLOT=
S; slot++) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vr-&gt;memory_reg=
ions[slot].used) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continu=
e;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MemoryRegion *mr =3D =
&amp;(vr-&gt;memory_regions[slot].mr);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_init_ra=
m_ptr(mr, NULL, &quot;blob&quot;, mapping.size,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0mapping.ptr);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_add_sub=
region(&amp;g-&gt;parent_obj.hostmem,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mblob.offset, mr);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vr-&gt;memory_regions=
[slot].resource_id =3D mblob.resource_id;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vr-&gt;memory_regions=
[slot].used =3D 1;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (slot &gt;=3D MAX_SLOTS) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D rutabaga_r=
esource_unmap(vr-&gt;rutabaga,<br>
&gt;&gt;&gt;&gt;&gt; mblob.resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHECK(!result, cmd);<=
br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(slot &lt; MAX_SLOTS, cmd);<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 resp.hdr.type =3D VIRTIO_GPU_RESP_O=
K_MAP_INFO;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 virtio_gpu_ctrl_response(g, cmd, &a=
mp;resp.hdr, sizeof(resp));<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +rutabaga_cmd_resource_unmap_blob(VirtIOGPU *g,<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=
 virtio_gpu_ctrl_command *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t slot =3D 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *=
res;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resource_unmap_bl=
ob ublob;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(ublob);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(ublob.resource_id !=3D 0, cmd=
);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g,=
 ublob.resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(res, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 for (slot =3D 0; slot &lt; MAX_SLOT=
S; slot++) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vr-&gt;memory_reg=
ions[slot].resource_id !=3D<br>
&gt;&gt;&gt; ublob.resource_id) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continu=
e;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MemoryRegion *mr =3D =
&amp;(vr-&gt;memory_regions[slot].mr);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_del_sub=
region(&amp;g-&gt;parent_obj.hostmem, mr);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vr-&gt;memory_regions=
[slot].resource_id =3D 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vr-&gt;memory_regions=
[slot].used =3D 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(slot &lt; MAX_SLOTS, cmd);<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_unmap(=
vr-&gt;rutabaga, res-&gt;resource_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +virtio_gpu_rutabaga_process_cmd(VirtIOGPU *g,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virti=
o_gpu_ctrl_command *cmd)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct rutabaga_fence fence =3D { 0=
 };<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(cmd-&gt;cmd_hdr=
);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 switch (cmd-&gt;cmd_hdr.type) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_CTX_CREATE:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_context_=
create(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_CTX_DESTROY:<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_context_=
destroy(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_CREATE=
_2D:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_create_r=
esource_2d(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_CREATE=
_3D:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_create_r=
esource_3d(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_SUBMIT_3D:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_submit_3=
d(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_TRANSFER_TO_HOS=
T_2D:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_transfer=
_to_host_2d(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_TRANSFER_TO_HOS=
T_3D:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_transfer=
_to_host_3d(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_TRANSFER_FROM_H=
OST_3D:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_transfer=
_from_host_3d(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_ATTACH=
_BACKING:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_attach_b=
acking(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_DETACH=
_BACKING:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_detach_b=
acking(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_SET_SCANOUT:<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_set_scan=
out(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_FLUSH:=
<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_resource=
_flush(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_UNREF:=
<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_resource=
_unref(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_CTX_ATTACH_RESO=
URCE:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_ctx_atta=
ch_resource(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_CTX_DETACH_RESO=
URCE:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_ctx_deta=
ch_resource(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_GET_CAPSET_INFO=
:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_get_caps=
et_info(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_GET_CAPSET:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_get_caps=
et(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_GET_DISPLAY_INF=
O:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_get_displa=
y_info(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_GET_EDID:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_get_edid(g=
, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_CREATE=
_BLOB:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_resource=
_create_blob(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_MAP_BL=
OB:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_resource=
_map_blob(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_UNMAP_=
BLOB:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_resource=
_unmap_blob(g, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 default:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;error =3D VIR=
TIO_GPU_RESP_ERR_UNSPEC;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (cmd-&gt;finished) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (cmd-&gt;error) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s=
: ctrl 0x%x, error 0x%x&quot;, __func__,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0cmd-&gt;cmd_hdr.type, cmd-&gt;error);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_ctrl_respo=
nse_nodata(g, cmd, cmd-&gt;error);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (!(cmd-&gt;cmd_hdr.flags &amp; V=
IRTIO_GPU_FLAG_FENCE)) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_ctrl_respo=
nse_nodata(g, cmd,<br>
&gt;&gt;&gt;&gt;&gt; VIRTIO_GPU_RESP_OK_NODATA);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 fence.flags =3D cmd-&gt;cmd_hdr.fla=
gs;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 fence.ctx_id =3D cmd-&gt;cmd_hdr.ct=
x_id;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 fence.fence_id =3D cmd-&gt;cmd_hdr.=
fence_id;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 fence.ring_idx =3D cmd-&gt;cmd_hdr.=
ring_idx;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_fence_ctrl(cmd-&gt=
;cmd_hdr.fence_id,<br>
&gt;&gt;&gt;&gt;&gt; cmd-&gt;cmd_hdr.type);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 result =3D rutabaga_create_fence(vr=
-&gt;rutabaga, &amp;fence);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +virtio_gpu_rutabaga_aio_cb(void *opaque)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct rutabaga_aio_data *data =3D =
opaque;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPU *g =3D VIRTIO_GPU(data-&g=
t;vr);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct rutabaga_fence fence_data =
=3D data-&gt;fence;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct virtio_gpu_ctrl_command *cmd=
, *tmp;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t signaled_ctx_specific =3D =
fence_data.flags &amp;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0RUTABAGA_FLAG_INFO_RING_IDX;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 QTAILQ_FOREACH_SAFE(cmd, &amp;g-&gt=
;fenceq, next, tmp) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Due to contex=
t specific timelines.<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t target_ctx_s=
pecific =3D cmd-&gt;cmd_hdr.flags &amp;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0RUTABAGA_FLAG_INFO_RING_IDX;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (signaled_ctx_spec=
ific !=3D target_ctx_specific) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continu=
e;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (signaled_ctx_spec=
ific &amp;&amp;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(cmd-&gt=
;cmd_hdr.ring_idx !=3D fence_data.ring_idx)) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continu=
e;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cmd-&gt;cmd_hdr.f=
ence_id &gt; fence_data.fence_id) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continu=
e;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_virtio_gpu_fenc=
e_resp(cmd-&gt;cmd_hdr.fence_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_ctrl_respo=
nse_nodata(g, cmd,<br>
&gt;&gt;&gt;&gt;&gt; VIRTIO_GPU_RESP_OK_NODATA);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 QTAILQ_REMOVE(&amp;g-=
&gt;fenceq, cmd, next);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(cmd);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 g_free(data);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +virtio_gpu_rutabaga_fence_cb(uint64_t user_data,<=
br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct rutabag=
a_fence *fence) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct rutabaga_aio_data *data;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPU *g =3D (VirtIOGPU *)user_=
data;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 /*<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* gfxstream and both cross-do=
main (and even newer versions<br>
&gt;&gt;&gt;&gt;&gt; virglrenderer:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* see VIRGL_RENDERER_ASYNC_FE=
NCE_CB) like to signal fence<br>
&gt;&gt;&gt;&gt;&gt; completion on<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* threads (&quot;callback thr=
eads&quot;) that are different from the thread<br>
&gt;&gt;&gt;&gt;&gt; that<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* processes the command queue=
 (&quot;main thread&quot;).<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* crosvm and other virtio-gpu=
 1.1 implementations enable callback<br>
&gt;&gt;&gt;&gt;&gt; threads<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* via locking.=C2=A0 However,=
 on QEMU a deadlock is observed if<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* virtio_gpu_ctrl_response_no=
data(..) [used in the fence<br>
&gt;&gt;&gt; callback]<br>
&gt;&gt;&gt;&gt;&gt; is used<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* from a thread that is not t=
he main thread.<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* The reason is QEMU&#39;s in=
ternal locking is designed to work with<br>
&gt;&gt;&gt;&gt;&gt; QEMU<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* threads (see rcu_register_t=
hread()) and not generic C/C++/Rust<br>
&gt;&gt;&gt;&gt;&gt; threads.<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* For now, we can workaround =
this by scheduling the return of the<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* fence descriptors on the ma=
in thread.<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 data =3D g_new0(struct rutabaga_aio=
_data, 1);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 data-&gt;vr =3D vr;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 data-&gt;fence =3D *fence;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 aio_bh_schedule_oneshot(qemu_get_ai=
o_context(),<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_rutabaga_aio_cb=
,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static void<br>
&gt;&gt;&gt;&gt;&gt;&gt; +virtio_gpu_rutabaga_debug_cb(uint64_t user_data,<=
br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct rutabag=
a_debug *debug) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (debug-&gt;debug_type =3D=3D RUT=
ABAGA_DEBUG_ERROR) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s=
&quot;, debug-&gt;message);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 } else if (debug-&gt;debug_type =3D=
=3D RUTABAGA_DEBUG_WARN) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report(&quot;%s&=
quot;, debug-&gt;message);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 } else if (debug-&gt;debug_type =3D=
=3D RUTABAGA_DEBUG_INFO) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 info_report(&quot;%s&=
quot;, debug-&gt;message);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static bool virtio_gpu_rutabaga_init(VirtIOGPU *g=
, Error **errp)<br>
&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int result;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 uint64_t capset_mask;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct rutabaga_builder builder =3D=
 { 0 };<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 char wayland_socket_path[UNIX_PATH_=
MAX];<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct rutabaga_channel channel =3D=
 { 0 };<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 struct rutabaga_channels channels =
=3D { 0 };<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GP=
U_RUTABAGA(g);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 vr-&gt;rutabaga =3D NULL;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (!vr-&gt;capset_names) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quo=
t;a capset name from the virtio-gpu spec is<br>
&gt;&gt;&gt;&gt;&gt; required&quot;);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 builder.wsi =3D RUTABAGA_WSI_SURFAC=
ELESS;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 /*<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* Currently, if WSI is specif=
ied, the only valid strings are<br>
&gt;&gt;&gt;&gt;&gt; &quot;surfaceless&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* or &quot;headless&quot;.=C2=
=A0 Surfaceless doesn&#39;t create a native window<br>
&gt;&gt;&gt;&gt;&gt; surface, but<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* does copy from the render t=
arget to the Pixman buffer if a<br>
&gt;&gt;&gt;&gt;&gt; virtio-gpu<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* 2D hypercall is issued.=C2=
=A0 Surfacless is the default.<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* Headless is like surfaceles=
s, but doesn&#39;t copy to the Pixman<br>
&gt;&gt;&gt;&gt;&gt; buffer. The<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* use case is automated testi=
ng environments where there is no<br>
&gt;&gt;&gt; need<br>
&gt;&gt;&gt;&gt;&gt; to view<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* results.<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* In the future, more perform=
ant virtio-gpu 2D UI integration may<br>
&gt;&gt;&gt;&gt;&gt; be added.<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (vr-&gt;wsi) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_str_equal(vr-&g=
t;wsi, &quot;surfaceless&quot;)) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vr-&gt;=
headless =3D false;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (g_str_equa=
l(vr-&gt;wsi, &quot;headless&quot;)) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vr-&gt;=
headless =3D true;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_s=
etg(errp, &quot;invalid wsi option selected&quot;);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
false;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 result =3D rutabaga_calculate_capse=
t_mask(vr-&gt;capset_names,<br>
&gt;&gt;&gt;&gt;&gt; &amp;capset_mask);<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; First, sorry for responding after such a long time. I&=
#39;ve been busy with<br>
&gt;&gt;&gt;&gt;&gt; work and I&#39;m doing QEMU in my free time.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; In iteration 1 I&#39;ve raised the topic on capset_nam=
es [1] and I haven&#39;t<br>
&gt;&gt;&gt;&gt;&gt; seen it answered properly. Perhaps I need to rephrase =
a bit so here we<br>
&gt;&gt;&gt; go:<br>
&gt;&gt;&gt;&gt;&gt; capset_names seems to be colon-separated list of bit o=
ptions managed by<br>
&gt;&gt;&gt;&gt;&gt; rutabaga. This introduces yet another way of options h=
andling. There<br>
&gt;&gt;&gt; have<br>
&gt;&gt;&gt;&gt;&gt; been talks about harmonizing options handling in QEMU =
since apparently<br>
&gt;&gt;&gt; it<br>
&gt;&gt;&gt;&gt;&gt; is considered too complex [2,3].<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Why not pass the &quot;capset&quot; as a bitfield like=
 capset_mask and have QEMU<br>
&gt;&gt;&gt;&gt;&gt; create &quot;capset&quot; from QOM properties?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; IIUC these flags could come from virtio_gpu.h which is alr=
eady present in<br>
&gt;&gt;&gt;&gt;&gt; the QEMU tree. This would not inly shortcut the depend=
ency on rutabaga<br>
&gt;&gt;&gt; here<br>
&gt;&gt;&gt;&gt;&gt; but would also be more idiomatic QEMU (since it makes =
the options more<br>
&gt;&gt;&gt;&gt;&gt; introspectable by internal machinery).<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Of course the bitfield approach would require modifica=
tions in QEMU<br>
&gt;&gt;&gt;&gt;&gt; whenever rutabaga gains new features. However, I figur=
e that in the long<br>
&gt;&gt;&gt;&gt;&gt; term rutabaga will be quite feature complete such that=
 the benefits of<br>
&gt;&gt;&gt;&gt;&gt; idiomatic QEMU handling will outweigh the decoupling o=
f the projects.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; What do you think?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I think what you&#39;re suggesting is something like -devi=
ce<br>
&gt;&gt;&gt;&gt; virtio-gpu-rutabaga,capset_mask=3D0x10100 [40, which would=
 be<br>
&gt;&gt;&gt;&gt; gfxstream_vulkan + cross_domain]?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I was thinking more along the lines of<br>
&gt;&gt;&gt; `virtio-gpu-rutabaga,gfxstream_vulkan=3Don,cross_domain=3Don` =
where<br>
&gt;&gt;&gt; gfxstream_vulkan and cross_domain are boolean QOM properties. =
This would<br>
&gt;&gt;&gt; make for a human-readable format which follows QEMU style.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; We actually did consider something like that when adding t=
he<br>
&gt;&gt;&gt;&gt; --context-types flag [with crosvm], but there was a desire=
 for a<br>
&gt;&gt;&gt;&gt; human-readable format rather than numbers [even if they ar=
e in the<br>
&gt;&gt;&gt;&gt; virtio-gpu spec].<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Additionally, there are quite a few context types that peo=
ple are playing<br>
&gt;&gt;&gt;&gt; around with [gfxstream-gles, gfxstream-composer] that are =
launchable and<br>
&gt;&gt;&gt;&gt; aren&#39;t in the spec just yet.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Right, QEMU had to be modified for this kind of experimentatio=
n. I<br>
&gt;&gt;&gt; considered this in my last paragraph and figured that in the l=
ong run QEMU<br>
&gt;&gt;&gt; *may* prefer more idiomatic option handling since it tries har=
d to not<br>
&gt;&gt;&gt; break its command line interface. I&#39;m just pointing this o=
ut -- the<br>
&gt;&gt;&gt; decision is ultimately up to the community.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Why not have dedicated QEMU development branches for experimen=
tation?<br>
&gt;&gt;&gt; Wouldn&#39;t upstreaming new features into QEMU be a good moti=
vation to get the<br>
&gt;&gt;&gt; missing pieces into the spec, once they are mature?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Also, a key feature we want to explicitly **not** turn on =
all available<br>
&gt;&gt;&gt;&gt; context-types and let the user decide.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; How would you prevent that with the current colon-separated ap=
proach?<br>
&gt;&gt;&gt; Splitting capset_mask in multiple parameters is just a differe=
nt<br>
&gt;&gt;&gt; syntactical representation of the same thing.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; That&#39;ll allow guest Mesa in<br>
&gt;&gt;&gt;&gt; particular to do its magic in its loader.=C2=A0 So one may=
 run Zink + ANV with<br>
&gt;&gt;&gt;&gt; ioctl forwarding, or Iris + ioctl forwarding and compare p=
erformance with<br>
&gt;&gt;&gt;&gt; the same guest image.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; And another thing is one needs some knowledge of the host =
system to choose<br>
&gt;&gt;&gt;&gt; the right context type.=C2=A0 You wouldn&#39;t do Zink + A=
NV ioctl forwarding on<br>
&gt;&gt;&gt;&gt; MacOS.=C2=A0 So I think the task of choosing the right con=
text type will fall<br>
&gt;&gt;&gt; to<br>
&gt;&gt;&gt;&gt; projects that depend on QEMU (such as Android Emulator) wh=
ich have some<br>
&gt;&gt;&gt;&gt; knowledge of the host environment.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; We actually have a graphics detector somewhere that calls =
VK/OpenGL before<br>
&gt;&gt;&gt;&gt; launching the VM and sets the right options.=C2=A0 Plan is=
 to port into<br>
&gt;&gt;&gt;&gt; gfxstream, maybe we could use that.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; You could bail out in QEMU if rutabaga_calculate_capset_mask()=
 detects<br>
&gt;&gt;&gt; conflicting combinations, no?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; So given the desire for human readable formats, being port=
able across VMMs<br>
&gt;&gt;&gt;&gt; (crosvm, qemu, rust-vmm??) and experimentation, the string=
 -&gt; capset mask<br>
&gt;&gt;&gt;&gt; conversion was put in the rutabaga API.=C2=A0 So I wouldn&=
#39;t change it for those<br>
&gt;&gt;&gt;&gt; reasons.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; What do you mean by being portable across VMMs?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Having the API inside rutabaga is (mildly) useful when multiple VM=
Ms have<br>
&gt;&gt; the need to translate from a human-readable format to flags digest=
ible by<br>
&gt;&gt; rutabaga.<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://android.googlesource.com/device/google/cuttlefi=
sh/+/refs/heads/main/host/libs/vm_manager/qemu_manager.cpp#452" rel=3D"nore=
ferrer" target=3D"_blank">https://android.googlesource.com/device/google/cu=
ttlefish/+/refs/heads/main/host/libs/vm_manager/qemu_manager.cpp#452</a><br=
>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://android.googlesource.com/device/google/cuttlefi=
sh/+/refs/heads/main/host/libs/vm_manager/crosvm_manager.cpp#353" rel=3D"no=
referrer" target=3D"_blank">https://android.googlesource.com/device/google/=
cuttlefish/+/refs/heads/main/host/libs/vm_manager/crosvm_manager.cpp#353</a=
><br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://chromium.googlesource.com/chromiumos/platform2/=
+/refs/heads/main/vm_tools/concierge/vm_builder.cc#505" rel=3D"noreferrer" =
target=3D"_blank">https://chromium.googlesource.com/chromiumos/platform2/+/=
refs/heads/main/vm_tools/concierge/vm_builder.cc#505</a><br>
&gt;&gt;<br>
&gt;&gt; For these crosvm/qemu launchers, I imagine capset names will be pl=
umbed all<br>
&gt;&gt; the way through eventually (launch_cvd<br>
&gt;&gt; --gpu_context=3Dgfxstream-vulkan:cross-domain if you&#39;ve played=
 around with<br>
&gt;&gt; Cuttlefish, or vmc start --gpu_contexts=3Dgfxstream-vulkan if you =
played<br>
&gt;&gt; around with Termina VMs).<br>
&gt;&gt;<br>
&gt;&gt; I think rust-vmm could also use the same API (&quot;--capset_names=
&quot;) too.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt; Sure, QEMU had to be taught new flags before being able to use=
 new<br>
&gt;&gt;&gt; rutabaga features. I agree that this comes with a certain inco=
nvenience.<br>
&gt;&gt;&gt; But it may also be inconvenient for QEMU to deal with addition=
al ad-hoc<br>
&gt;&gt;&gt; options parsing when there are efforts for harmonization.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Did my comments shed new light into the discussion?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Yes, they do.=C2=A0 I agree with you that both crosvm/qemu have to=
o many flags,<br>
&gt;&gt; and having a stable command line interface is important.=C2=A0 We =
are aiming for<br>
&gt;&gt; stability with the `--capset_names=3D{colon string}` command line,=
 and at<br>
&gt;&gt; least for crosvm looking to deprecate older options [since we&#39;=
ve never had<br>
&gt;&gt; an official release of crosvm yet].<br>
&gt;&gt;<br>
&gt;&gt; I do think:<br>
&gt;&gt;<br>
&gt;&gt; 1) &quot;capset_names=3Dgfxstream-vulkan:cross-domain&quot;<br>
&gt;&gt; 2) &quot;cross-domain=3Don,gfxstream-vulkan=3Don&quot;<br>
&gt;&gt;<br>
&gt;&gt; are similar enough.=C2=A0 I would choose (1) for since I think not=
 duplicating<br>
&gt;&gt; the [name] -&gt; flag logic and having a similar interface across =
VMMs + VMM<br>
&gt;&gt; launchers is ever-so slightly useful.<br>
&gt; <br>
&gt; I think we&#39;ve now reached a good understanding of the issue. It&#3=
9;s now up to the QEMU community to make a choice. So I&#39;m cc&#39;ing Ma=
rkus and Thomas as the experts of the topic.<br>
<br>
As a virtio-gpu user, I&#39;m slightly inclined to (2) since it would be <b=
r>
easier to implement the same option for virtio-gpu-virgl when a need arises=
.<br></blockquote><div><br></div><div>The rutabaga/virgl implementations wi=
ll likely be done via DEFINE_PROP_BIT, no?=C2=A0 For virgl, it&#39;ll set t=
he virgl flags, and for rutabaga, it&#39;ll set the capset mask.=C2=A0 So i=
t would be different.</div><div><br></div><div>That said, the change isn&#3=
9;t too bad to make.=C2=A0 Here&#39;s the key part:=C2=A0=C2=A0</div><div><=
br></div><div>+++ b/hw/display/virtio-gpu-rutabaga.c<br>@@ -1084,6 +1084,14=
 @@ static Property virtio_gpu_rutabaga_properties[] =3D {<br>=C2=A0 =C2=A0=
 =C2=A0DEFINE_PROP_STRING(&quot;wayland_socket_path&quot;, VirtIOGPURutabag=
a,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 wayland_socket_path),<br>=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_STR=
ING(&quot;wsi&quot;, VirtIOGPURutabaga, wsi),<br>+ =C2=A0 =C2=A0DEFINE_PROP=
_BIT(&quot;gfxstream-vulkan-experimental&quot;, VirtIOGPURutabaga,<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capset_ma=
sk, RUTABAGA_CAPSET_GFXSTREAM_VULKAN, false),<br>+ =C2=A0 =C2=A0DEFINE_PROP=
_BIT(&quot;cross-domain-experimental&quot;, VirtIOGPURutabaga,<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capset_mask, =
RUTABAGA_CAPSET_CROSS_DOMAIN, false),<br>+ =C2=A0 =C2=A0DEFINE_PROP_BIT(&qu=
ot;gfxstream-gles-experimental&quot;, VirtIOGPURutabaga,<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capset_mask, RUTABA=
GA_CAPSET_GFXSTREAM_GLES, false),<br>+ =C2=A0 =C2=A0DEFINE_PROP_BIT(&quot;g=
fxstream-composer-experimental&quot;, VirtIOGPURutabaga,<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capset_mask, RUTABA=
GA_CAPSET_GFXSTREAM_COMPOSER, false),<br>=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_EN=
D_OF_LIST(),<br>=C2=A0};<br></div><div><br></div><div>One thing though: I b=
orrowed a page of the Mesa-3d playbook (since they land non-working/experim=
ental drivers to speed development) and named all gfxstream/rutabaga_gfx co=
ntext types as &quot;experimental&quot;.=C2=A0 That&#39;ll allow us to expe=
riment in-tree.=C2=A0=C2=A0</div><div><br></div><div>If you closely follow:=
=C2=A0</div><div><br></div><div><a href=3D"https://lists.gnu.org/archive/ht=
ml/qemu-devel/2023-09/msg03319.html">https://lists.gnu.org/archive/html/qem=
u-devel/2023-09/msg03319.html</a><br></div><div><br></div><div>you may noti=
ce packaging/distributing rutabaga/gfxstream is low-priority, since I do ha=
ve the Android emulator use case in mind and I&#39;m not sure anybody else =
will find production targets for it in QEMU.=C2=A0 I think this is somewhat=
 closely related to crosvm/qemu has &quot;too many flags&quot;=C2=A0situati=
on.=C2=A0 Many times a flag/config is landed, and production target changes=
,=C2=A0and the history is lost.=C2=A0 By prefixing=C2=A0everything as &quot=
;experimental&quot;, we explicitly make it clear that QEMU makes no guarant=
ees at this time regarding rutabaga.=C2=A0 That&#39;ll allow hobbyists who =
build QEMU from sources anyways (the main non-Android users of rutabaga/gfx=
stream) to play around with it upstream, and also allow downstream to follo=
w upstream but not make any guarantees=C2=A0until everything is ready.</div=
><div><br></div><div>I&#39;m curious what everyone thinks of the plan.</div=
></div></div>

--0000000000004cfd7f0605e71496--

