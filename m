Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FD277CF9E
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 17:53:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVwJv-0007GV-4Z; Tue, 15 Aug 2023 11:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qVwJs-0007G0-O8
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 11:50:56 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qVwJl-0002Sc-B8
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 11:50:56 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52164adea19so7243525a12.1
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692114647; x=1692719447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KXtS0APqY0WoCr6C2oQqn3R8pMkfKk6pspF+z12tSXs=;
 b=FyYyu//OBPcBScOwJzAKW9pZNIP6/V26NGbDDzdyVEj2BJfg834iwstc5Ibkl4YsF4
 N/xWm8Rn8vG0ZO10/La5mhQEK771hV9LIsHi2QlWXbPw8k+e7Kzj0UBcOAtHxvRFn+5n
 0DGCW16wbr1RiClD/BpzWyJWCwk6FZ9qTL4Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692114647; x=1692719447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KXtS0APqY0WoCr6C2oQqn3R8pMkfKk6pspF+z12tSXs=;
 b=l8V3HNk1z7kMuBWJO4v2Y6Mem56Ctdry3dwmXb3C2RIJrSTw8uRjBIj2hjJ/jSrLeL
 metDsM68hB8SkiGyk/HrrfpOay/XX8nx/KXwaSe1kFbFJCxUMmj92IbdwHDpBtltBYzL
 4GO4kxZKiVgpcuFPqyBhd0wAgXL+/XREpr5jgAMOsglfPQaTkSEebm+VlMzlucsQ/NOl
 C24ujQOivQoY1NblHAa3+3jbiU+ehzF1IlsrlTfypTvy2E229Be/p0bzpEQfmxKXPnCf
 ZrP/m/+3QPj07EuwInX1mQ4snimpTgzK3mhBjnyZ9on0VIul0Uuq60/snHVAwZ+RcmPu
 siAA==
X-Gm-Message-State: AOJu0Yw5ZaKXSWTkwZJxyoVrxW7IgMjUxmQvJ9KurSmMCWEjNVPkZQ6O
 N+h3mlrrmUojVazOZ8IoxrZxV52Tsl2ncQqzrpQimg==
X-Google-Smtp-Source: AGHT+IHELkz2SCxbxfDkl/Hcm33EmSnUVbUcrL8El/UZ4T+UDW3XFvUn7WYVsYh69ElNl9AuBt/CZA==
X-Received: by 2002:a05:6402:643:b0:525:6d9b:15c6 with SMTP id
 u3-20020a056402064300b005256d9b15c6mr3132964edx.39.1692114647254; 
 Tue, 15 Aug 2023 08:50:47 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com.
 [209.85.208.42]) by smtp.gmail.com with ESMTPSA id
 q9-20020a056402040900b0051dd19d6d6esm7080107edv.73.2023.08.15.08.50.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Aug 2023 08:50:46 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-5257d67368bso4648a12.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 08:50:46 -0700 (PDT)
X-Received: by 2002:a50:d486:0:b0:522:4741:d992 with SMTP id
 s6-20020a50d486000000b005224741d992mr365570edi.4.1692114646447; Tue, 15 Aug
 2023 08:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230815003526.631-1-gurchetansingh@chromium.org>
 <20230815003526.631-7-gurchetansingh@chromium.org>
 <95992e52-a898-42fe-93ac-75295bcfd77f@gmail.com>
In-Reply-To: <95992e52-a898-42fe-93ac-75295bcfd77f@gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Tue, 15 Aug 2023 08:50:32 -0700
X-Gmail-Original-Message-ID: <CAAfnVBkitLqN0owkMYhncV-e5ajL0vZTHda=2BMRJ0=b1O5hHw@mail.gmail.com>
Message-ID: <CAAfnVBkitLqN0owkMYhncV-e5ajL0vZTHda=2BMRJ0=b1O5hHw@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] gfxstream + rutabaga: add initial support for
 gfxstream
To: Akihiko Odaki <akihiko.odaki@gmail.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org, 
 ernunes@redhat.com, hi@alyssa.is, shentey@gmail.com
Content-Type: multipart/alternative; boundary="0000000000006c50750602f82400"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
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

--0000000000006c50750602f82400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 8:07=E2=80=AFAM Akihiko Odaki <akihiko.odaki@gmail.=
com>
wrote:

> On 2023/08/15 9:35, Gurchetan Singh wrote:
> > This adds initial support for gfxstream and cross-domain.  Both
> > features rely on virtio-gpu blob resources and context types, which
> > are also implemented in this patch.
> >
> > gfxstream has a long and illustrious history in Android graphics
> > paravirtualization.  It has been powering graphics in the Android
> > Studio Emulator for more than a decade, which is the main developer
> > platform.
> >
> > Originally conceived by Jesse Hall, it was first known as "EmuGL" [a].
> > The key design characteristic was a 1:1 threading model and
> > auto-generation, which fit nicely with the OpenGLES spec.  It also
> > allowed easy layering with ANGLE on the host, which provides the GLES
> > implementations on Windows or MacOS enviroments.
> >
> > gfxstream has traditionally been maintained by a single engineer, and
> > between 2015 to 2021, the goldfish throne passed to Frank Yang.
> > Historians often remark this glorious reign ("pax gfxstreama" is the
> > academic term) was comparable to that of Augustus and both Queen
> > Elizabeths.  Just to name a few accomplishments in a resplendent
> > panoply: higher versions of GLES, address space graphics, snapshot
> > support and CTS compliant Vulkan [b].
> >
> > One major drawback was the use of out-of-tree goldfish drivers.
> > Android engineers didn't know much about DRM/KMS and especially TTM so
> > a simple guest to host pipe was conceived.
> >
> > Luckily, virtio-gpu 3D started to emerge in 2016 due to the work of
> > the Mesa/virglrenderer communities.  In 2018, the initial virtio-gpu
> > port of gfxstream was done by Cuttlefish enthusiast Alistair Delva.
> > It was a symbol compatible replacement of virglrenderer [c] and named
> > "AVDVirglrenderer".  This implementation forms the basis of the
> > current gfxstream host implementation still in use today.
> >
> > cross-domain support follows a similar arc.  Originally conceived by
> > Wayland aficionado David Reveman and crosvm enjoyer Zach Reizner in
> > 2018, it initially relied on the downstream "virtio-wl" device.
> >
> > In 2020 and 2021, virtio-gpu was extended to include blob resources
> > and multiple timelines by yours truly, features gfxstream/cross-domain
> > both require to function correctly.
> >
> > Right now, we stand at the precipice of a truly fantastic possibility:
> > the Android Emulator powered by upstream QEMU and upstream Linux
> > kernel.  gfxstream will then be packaged properfully, and app
> > developers can even fix gfxstream bugs on their own if they encounter
> > them.
> >
> > It's been quite the ride, my friends.  Where will gfxstream head next,
> > nobody really knows.  I wouldn't be surprised if it's around for
> > another decade, maintained by a new generation of Android graphics
> > enthusiasts.
> >
> > Technical details:
> >    - Very simple initial display integration: just used Pixman
> >    - Largely, 1:1 mapping of virtio-gpu hypercalls to rutabaga function
> >      calls
> >
> > Next steps for Android VMs:
> >    - The next step would be improving display integration and UI
> interfaces
> >      with the goal of the QEMU upstream graphics being in an emulator
> >      release [d].
> >
> > Next steps for Linux VMs for display virtualization:
> >    - For widespread distribution, someone needs to package Sommelier or
> the
> >      wayland-proxy-virtwl [e] ideally into Debian main. In addition,
> newer
> >      versions of the Linux kernel come with DRM_VIRTIO_GPU_KMS option,
> >      which allows disabling KMS hypercalls.  If anyone cares enough,
> it'll
> >      probably be possible to build a custom VM variant that uses this
> display
> >      virtualization strategy.
> >
> > [a]
> https://android-review.googlesource.com/c/platform/development/+/34470
> > [b]
> https://android-review.googlesource.com/q/topic:%22vulkan-hostconnection-=
start%22
> > [c]
> https://android-review.googlesource.com/c/device/generic/goldfish-opengl/=
+/761927
> > [d] https://developer.android.com/studio/releases/emulator
> > [e] https://github.com/talex5/wayland-proxy-virtwl
> >
> > Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> > Tested-by: Alyssa Ross <hi@alyssa.is>
> > ---
> > v1: Incorported various suggestions by Akihiko Odaki and Bernard Bersch=
ow
> >      - Removed GET_VIRTIO_GPU_GL / GET_RUTABAGA macros
> >      - Used error_report(..)
> >      - Used g_autofree to fix leaks on error paths
> >      - Removed unnecessary casts
> >      - added virtio-gpu-pci-rutabaga.c + virtio-vga-rutabaga.c files
> >
> > v2: Incorported various suggestions by Akihiko Odaki, Marc-Andr=C3=A9 L=
ureau
> and
> >      Bernard Berschow:
> >      - Parenthesis in CHECK macro
> >      - CHECK_RESULT(result, ..) --> CHECK(!result, ..)
> >      - delay until g->parent_obj.enable =3D 1
> >      - Additional cast fixes
> >      - initialize directly in virtio_gpu_rutabaga_realize(..)
> >      - add debug callback to hook into QEMU error's APIs
> >
> > v3: Incorporated feedback from Akihiko Odaki and Alyssa Ross:
> >      - Autodetect Wayland socket when not explicitly specified
> >      - Fix map_blob error paths
> >      - Add comment why we need both `res` and `resource` in create blob
> >      - Cast and whitespace fixes
> >      - Big endian check comes before virtio_gpu_rutabaga_init().
> >      - VirtIOVGARUTABAGA --> VirtIOVGARutabaga
> >
> > v4: Incorporated feedback from Akihiko Odaki and Alyssa Ross:
> >      - Double checked all casts
> >      - Remove unnecessary parenthesis
> >      - Removed `resource` in create_blob
> >      - Added comment about failure case
> >      - Pass user-provided socket as-is
> >      - Use stack variable rather than heap allocation
> >      - Future-proofed map info API to give access flags as well
> >
> > v5: Incorporated feedback from Akihiko Odaki:
> >      - Check (ss.scanout_id < VIRTIO_GPU_MAX_SCANOUTS)
> >      - Simplify num_capsets check
> >      - Call cleanup mapping on error paths
> >      - uint64_t --> void* for rutabaga_map(..)
> >      - Removed unnecessary parenthesis
> >      - Removed unnecessary cast
> >      - #define UNIX_PATH_MAX sizeof((struct sockaddr_un) {}.sun_path)
> >      - Reuse result variable
> >      - Report error when default socket doesn't fit in Wayland socket
> path
> >
> >   hw/display/virtio-gpu-pci-rutabaga.c |   48 ++
> >   hw/display/virtio-gpu-rutabaga.c     | 1114 +++++++++++++++++++++++++=
+
> >   hw/display/virtio-vga-rutabaga.c     |   51 ++
> >   3 files changed, 1213 insertions(+)
> >   create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
> >   create mode 100644 hw/display/virtio-gpu-rutabaga.c
> >   create mode 100644 hw/display/virtio-vga-rutabaga.c
> >
> > diff --git a/hw/display/virtio-gpu-pci-rutabaga.c
> b/hw/display/virtio-gpu-pci-rutabaga.c
> > new file mode 100644
> > index 0000000000..c71173d8ca
> > --- /dev/null
> > +++ b/hw/display/virtio-gpu-pci-rutabaga.c
> > @@ -0,0 +1,48 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qemu/module.h"
> > +#include "hw/pci/pci.h"
> > +#include "hw/qdev-properties.h"
> > +#include "hw/virtio/virtio.h"
> > +#include "hw/virtio/virtio-bus.h"
> > +#include "hw/virtio/virtio-gpu-pci.h"
> > +#include "qom/object.h"
> > +
> > +#define TYPE_VIRTIO_GPU_RUTABAGA_PCI "virtio-gpu-rutabaga-pci"
> > +typedef struct VirtIOGPURutabagaPCI VirtIOGPURutabagaPCI;
> > +DECLARE_INSTANCE_CHECKER(VirtIOGPURutabagaPCI, VIRTIO_GPU_RUTABAGA_PCI=
,
> > +                         TYPE_VIRTIO_GPU_RUTABAGA_PCI)
> > +
> > +struct VirtIOGPURutabagaPCI {
> > +    VirtIOGPUPCIBase parent_obj;
> > +    VirtIOGPURutabaga vdev;
> > +};
> > +
> > +static void virtio_gpu_rutabaga_initfn(Object *obj)
> > +{
> > +    VirtIOGPURutabagaPCI *dev =3D VIRTIO_GPU_RUTABAGA_PCI(obj);
> > +
> > +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> > +                                TYPE_VIRTIO_GPU_RUTABAGA);
> > +    VIRTIO_GPU_PCI_BASE(obj)->vgpu =3D VIRTIO_GPU_BASE(&dev->vdev);
> > +}
> > +
> > +static const VirtioPCIDeviceTypeInfo virtio_gpu_rutabaga_pci_info =3D =
{
> > +    .generic_name =3D TYPE_VIRTIO_GPU_RUTABAGA_PCI,
> > +    .parent =3D TYPE_VIRTIO_GPU_PCI_BASE,
> > +    .instance_size =3D sizeof(VirtIOGPURutabagaPCI),
> > +    .instance_init =3D virtio_gpu_rutabaga_initfn,
> > +};
> > +module_obj(TYPE_VIRTIO_GPU_RUTABAGA_PCI);
> > +module_kconfig(VIRTIO_PCI);
> > +
> > +static void virtio_gpu_rutabaga_pci_register_types(void)
> > +{
> > +    virtio_pci_types_register(&virtio_gpu_rutabaga_pci_info);
> > +}
> > +
> > +type_init(virtio_gpu_rutabaga_pci_register_types)
> > +
> > +module_dep("hw-display-virtio-gpu-pci");
> > diff --git a/hw/display/virtio-gpu-rutabaga.c
> b/hw/display/virtio-gpu-rutabaga.c
> > new file mode 100644
> > index 0000000000..3f9f106abc
> > --- /dev/null
> > +++ b/hw/display/virtio-gpu-rutabaga.c
> > @@ -0,0 +1,1114 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qemu/error-report.h"
> > +#include "qemu/iov.h"
> > +#include "trace.h"
> > +#include "hw/virtio/virtio.h"
> > +#include "hw/virtio/virtio-gpu.h"
> > +#include "hw/virtio/virtio-gpu-pixman.h"
> > +#include "hw/virtio/virtio-iommu.h"
> > +
> > +#include <glib/gmem.h>
> > +#include <rutabaga_gfx/rutabaga_gfx_ffi.h>
> > +
> > +#define CHECK(condition, cmd)
>        \
> > +    do {
>       \
> > +        if (!(condition)) {
>        \
> > +            error_report("CHECK failed in %s() %s:" "%d", __func__,
>        \
> > +                         __FILE__, __LINE__);
>        \
> > +            (cmd)->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>       \
> > +            return;
>        \
> > +       }
>       \
> > +    } while (0)
> > +
> > +/*
> > + * This is the size of the char array in struct sock_addr_un. No
> Wayland socket
> > + * can be created with a path longer than this, including the null
> terminator.
> > + */
> > +#ifndef UNIX_PATH_MAX
>
> You shouldn't need this ifndef.
>
> > +#define UNIX_PATH_MAX sizeof((struct sockaddr_un) {} .sun_path)
> > +#endif
> > +
> > +struct rutabaga_aio_data {
> > +    struct VirtIOGPURutabaga *vr;
> > +    struct rutabaga_fence fence;
> > +};
> > +
> > +static void
> > +virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, struct
> virtio_gpu_scanout *s,
> > +                                  uint32_t resource_id)
> > +{
> > +    struct virtio_gpu_simple_resource *res;
> > +    struct rutabaga_transfer transfer =3D { 0 };
> > +    struct iovec transfer_iovec;
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    res =3D virtio_gpu_find_resource(g, resource_id);
> > +    if (!res) {
> > +        return;
> > +    }
> > +
> > +    if (res->width !=3D s->current_cursor->width ||
> > +        res->height !=3D s->current_cursor->height) {
> > +        return;
> > +    }
> > +
> > +    transfer.x =3D 0;
> > +    transfer.y =3D 0;
> > +    transfer.z =3D 0;
> > +    transfer.w =3D res->width;
> > +    transfer.h =3D res->height;
> > +    transfer.d =3D 1;
> > +
> > +    transfer_iovec.iov_base =3D s->current_cursor->data;
> > +    transfer_iovec.iov_len =3D res->width * res->height * 4;
> > +
> > +    rutabaga_resource_transfer_read(vr->rutabaga, 0,
> > +                                    resource_id, &transfer,
> > +                                    &transfer_iovec);
> > +}
> > +
> > +static void
> > +virtio_gpu_rutabaga_gl_flushed(VirtIOGPUBase *b)
> > +{
> > +    VirtIOGPU *g =3D VIRTIO_GPU(b);
> > +    virtio_gpu_process_cmdq(g);
> > +}
> > +
> > +static void
> > +rutabaga_cmd_create_resource_2d(VirtIOGPU *g,
> > +                                struct virtio_gpu_ctrl_command *cmd)
> > +{
> > +    int32_t result;
> > +    struct rutabaga_create_3d rc_3d =3D { 0 };
> > +    struct virtio_gpu_simple_resource *res;
> > +    struct virtio_gpu_resource_create_2d c2d;
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    VIRTIO_GPU_FILL_CMD(c2d);
> > +    trace_virtio_gpu_cmd_res_create_2d(c2d.resource_id, c2d.format,
> > +                                       c2d.width, c2d.height);
> > +
> > +    rc_3d.target =3D 2;
> > +    rc_3d.format =3D c2d.format;
> > +    rc_3d.bind =3D (1 << 1);
> > +    rc_3d.width =3D c2d.width;
> > +    rc_3d.height =3D c2d.height;
> > +    rc_3d.depth =3D 1;
> > +    rc_3d.array_size =3D 1;
> > +    rc_3d.last_level =3D 0;
> > +    rc_3d.nr_samples =3D 0;
> > +    rc_3d.flags =3D VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
> > +
> > +    result =3D rutabaga_resource_create_3d(vr->rutabaga, c2d.resource_=
id,
> &rc_3d);
> > +    CHECK(!result, cmd);
> > +
> > +    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
> > +    res->width =3D c2d.width;
> > +    res->height =3D c2d.height;
> > +    res->format =3D c2d.format;
> > +    res->resource_id =3D c2d.resource_id;
> > +
> > +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
> > +}
> > +
> > +static void
> > +rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
> > +                                struct virtio_gpu_ctrl_command *cmd)
> > +{
> > +    int32_t result;
> > +    struct rutabaga_create_3d rc_3d =3D { 0 };
> > +    struct virtio_gpu_simple_resource *res;
> > +    struct virtio_gpu_resource_create_3d c3d;
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    VIRTIO_GPU_FILL_CMD(c3d);
> > +
> > +    trace_virtio_gpu_cmd_res_create_3d(c3d.resource_id, c3d.format,
> > +                                       c3d.width, c3d.height,
> c3d.depth);
> > +
> > +    rc_3d.target =3D c3d.target;
> > +    rc_3d.format =3D c3d.format;
> > +    rc_3d.bind =3D c3d.bind;
> > +    rc_3d.width =3D c3d.width;
> > +    rc_3d.height =3D c3d.height;
> > +    rc_3d.depth =3D c3d.depth;
> > +    rc_3d.array_size =3D c3d.array_size;
> > +    rc_3d.last_level =3D c3d.last_level;
> > +    rc_3d.nr_samples =3D c3d.nr_samples;
> > +    rc_3d.flags =3D c3d.flags;
> > +
> > +    result =3D rutabaga_resource_create_3d(vr->rutabaga, c3d.resource_=
id,
> &rc_3d);
> > +    CHECK(!result, cmd);
> > +
> > +    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
> > +    res->width =3D c3d.width;
> > +    res->height =3D c3d.height;
> > +    res->format =3D c3d.format;
> > +    res->resource_id =3D c3d.resource_id;
> > +
> > +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
> > +}
> > +
> > +static void
> > +rutabaga_cmd_resource_unref(VirtIOGPU *g,
> > +                            struct virtio_gpu_ctrl_command *cmd)
> > +{
> > +    int32_t result;
> > +    struct virtio_gpu_simple_resource *res;
> > +    struct virtio_gpu_resource_unref unref;
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    VIRTIO_GPU_FILL_CMD(unref);
> > +
> > +    trace_virtio_gpu_cmd_res_unref(unref.resource_id);
> > +
> > +    res =3D virtio_gpu_find_resource(g, unref.resource_id);
> > +    CHECK(res, cmd);
> > +
> > +    result =3D rutabaga_resource_unref(vr->rutabaga, unref.resource_id=
);
> > +    CHECK(!result, cmd);
> > +
> > +    if (res->image) {
> > +        pixman_image_unref(res->image);
> > +    }
> > +
> > +    QTAILQ_REMOVE(&g->reslist, res, next);
> > +    g_free(res);
> > +}
> > +
> > +static void
> > +rutabaga_cmd_context_create(VirtIOGPU *g,
> > +                            struct virtio_gpu_ctrl_command *cmd)
> > +{
> > +    int32_t result;
> > +    struct virtio_gpu_ctx_create cc;
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    VIRTIO_GPU_FILL_CMD(cc);
> > +    trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,
> > +                                    cc.debug_name);
> > +
> > +    result =3D rutabaga_context_create(vr->rutabaga, cc.hdr.ctx_id,
> > +                                     cc.context_init, cc.debug_name,
> cc.nlen);
> > +    CHECK(!result, cmd);
> > +}
> > +
> > +static void
> > +rutabaga_cmd_context_destroy(VirtIOGPU *g,
> > +                             struct virtio_gpu_ctrl_command *cmd)
> > +{
> > +    int32_t result;
> > +    struct virtio_gpu_ctx_destroy cd;
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    VIRTIO_GPU_FILL_CMD(cd);
> > +    trace_virtio_gpu_cmd_ctx_destroy(cd.hdr.ctx_id);
> > +
> > +    result =3D rutabaga_context_destroy(vr->rutabaga, cd.hdr.ctx_id);
> > +    CHECK(!result, cmd);
> > +}
> > +
> > +static void
> > +rutabaga_cmd_resource_flush(VirtIOGPU *g, struct
> virtio_gpu_ctrl_command *cmd)
> > +{
> > +    int32_t result, i;
> > +    struct virtio_gpu_scanout *scanout =3D NULL;
> > +    struct virtio_gpu_simple_resource *res;
> > +    struct rutabaga_transfer transfer =3D { 0 };
> > +    struct iovec transfer_iovec;
> > +    struct virtio_gpu_resource_flush rf;
> > +    bool found =3D false;
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +    if (vr->headless) {
> > +        return;
> > +    }
> > +
> > +    VIRTIO_GPU_FILL_CMD(rf);
> > +    trace_virtio_gpu_cmd_res_flush(rf.resource_id,
> > +                                   rf.r.width, rf.r.height, rf.r.x,
> rf.r.y);
> > +
> > +    res =3D virtio_gpu_find_resource(g, rf.resource_id);
> > +    CHECK(res, cmd);
> > +
> > +    for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
> > +        scanout =3D &g->parent_obj.scanout[i];
> > +        if (i =3D=3D res->scanout_bitmask) {
> > +            found =3D true;
> > +            break;
> > +        }
> > +    }
> > +
> > +    if (!found) {
> > +        return;
> > +    }
> > +
> > +    transfer.x =3D 0;
> > +    transfer.y =3D 0;
> > +    transfer.z =3D 0;
> > +    transfer.w =3D res->width;
> > +    transfer.h =3D res->height;
> > +    transfer.d =3D 1;
> > +
> > +    transfer_iovec.iov_base =3D pixman_image_get_data(res->image);
> > +    transfer_iovec.iov_len =3D res->width * res->height * 4;
> > +
> > +    result =3D rutabaga_resource_transfer_read(vr->rutabaga, 0,
> > +                                             rf.resource_id, &transfer=
,
> > +                                             &transfer_iovec);
> > +    CHECK(!result, cmd);
> > +    dpy_gfx_update_full(scanout->con);
> > +}
> > +
> > +static void
> > +rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command
> *cmd)
> > +{
> > +    struct virtio_gpu_simple_resource *res;
> > +    struct virtio_gpu_scanout *scanout =3D NULL;
> > +    struct virtio_gpu_set_scanout ss;
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +    if (vr->headless) {
> > +        return;
> > +    }
> > +
> > +    VIRTIO_GPU_FILL_CMD(ss);
> > +    trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_id,
> > +                                     ss.r.width, ss.r.height, ss.r.x,
> ss.r.y);
> > +
> > +    CHECK(ss.scanout_id < VIRTIO_GPU_MAX_SCANOUTS, cmd);
> > +    scanout =3D &g->parent_obj.scanout[ss.scanout_id];
> > +
> > +    if (ss.resource_id =3D=3D 0) {
>
> You should disable scanout as virtio-gpu-virgl does.
>
> > +        return;
> > +    }
> > +
> > +    res =3D virtio_gpu_find_resource(g, ss.resource_id);
> > +    CHECK(res, cmd);
> > +
> > +    if (!res->image) {
> > +        pixman_format_code_t pformat;
> > +        pformat =3D virtio_gpu_get_pixman_format(res->format);
> > +        CHECK(pformat, cmd);
> > +
> > +        res->image =3D pixman_image_create_bits(pformat,
> > +                                              res->width,
> > +                                              res->height,
> > +                                              NULL, 0);
> > +        CHECK(res->image, cmd);
> > +        pixman_image_ref(res->image);
> > +    }
> > +
> > +    g->parent_obj.enable =3D 1;
> > +
> > +    /* realloc the surface ptr */
> > +    scanout->ds =3D qemu_create_displaysurface_pixman(res->image);
> > +    dpy_gfx_replace_surface(scanout->con, NULL);
> > +    dpy_gfx_replace_surface(scanout->con, scanout->ds);
> > +    res->scanout_bitmask =3D ss.scanout_id;
> > +}
> > +
> > +static void
> > +rutabaga_cmd_submit_3d(VirtIOGPU *g,
> > +                       struct virtio_gpu_ctrl_command *cmd)
> > +{
> > +    int32_t result;
> > +    struct virtio_gpu_cmd_submit cs;
> > +    struct rutabaga_command rutabaga_cmd =3D { 0 };
> > +    g_autofree uint8_t *buf =3D NULL;
> > +    size_t s;
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    VIRTIO_GPU_FILL_CMD(cs);
> > +    trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size);
> > +
> > +    buf =3D g_new0(uint8_t, cs.size);
> > +    s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> > +                   sizeof(cs), buf, cs.size);
> > +    CHECK(s =3D=3D cs.size, cmd);
> > +
> > +    rutabaga_cmd.ctx_id =3D cs.hdr.ctx_id;
> > +    rutabaga_cmd.cmd =3D buf;
> > +    rutabaga_cmd.cmd_size =3D cs.size;
> > +
> > +    result =3D rutabaga_submit_command(vr->rutabaga, &rutabaga_cmd);
> > +    CHECK(!result, cmd);
> > +}
> > +
> > +static void
> > +rutabaga_cmd_transfer_to_host_2d(VirtIOGPU *g,
> > +                                 struct virtio_gpu_ctrl_command *cmd)
> > +{
> > +    int32_t result;
> > +    struct rutabaga_transfer transfer =3D { 0 };
> > +    struct virtio_gpu_transfer_to_host_2d t2d;
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    VIRTIO_GPU_FILL_CMD(t2d);
> > +    trace_virtio_gpu_cmd_res_xfer_toh_2d(t2d.resource_id);
> > +
> > +    transfer.x =3D t2d.r.x;
> > +    transfer.y =3D t2d.r.y;
> > +    transfer.z =3D 0;
> > +    transfer.w =3D t2d.r.width;
> > +    transfer.h =3D t2d.r.height;
> > +    transfer.d =3D 1;
> > +
> > +    result =3D rutabaga_resource_transfer_write(vr->rutabaga, 0,
> t2d.resource_id,
> > +                                              &transfer);
> > +    CHECK(!result, cmd);
> > +}
> > +
> > +static void
> > +rutabaga_cmd_transfer_to_host_3d(VirtIOGPU *g,
> > +                                 struct virtio_gpu_ctrl_command *cmd)
> > +{
> > +    int32_t result;
> > +    struct rutabaga_transfer transfer =3D { 0 };
> > +    struct virtio_gpu_transfer_host_3d t3d;
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    VIRTIO_GPU_FILL_CMD(t3d);
> > +    trace_virtio_gpu_cmd_res_xfer_toh_3d(t3d.resource_id);
> > +
> > +    transfer.x =3D t3d.box.x;
> > +    transfer.y =3D t3d.box.y;
> > +    transfer.z =3D t3d.box.z;
> > +    transfer.w =3D t3d.box.w;
> > +    transfer.h =3D t3d.box.h;
> > +    transfer.d =3D t3d.box.d;
> > +    transfer.level =3D t3d.level;
> > +    transfer.stride =3D t3d.stride;
> > +    transfer.layer_stride =3D t3d.layer_stride;
> > +    transfer.offset =3D t3d.offset;
> > +
> > +    result =3D rutabaga_resource_transfer_write(vr->rutabaga,
> t3d.hdr.ctx_id,
> > +                                              t3d.resource_id,
> &transfer);
> > +    CHECK(!result, cmd);
> > +}
> > +
> > +static void
> > +rutabaga_cmd_transfer_from_host_3d(VirtIOGPU *g,
> > +                                   struct virtio_gpu_ctrl_command *cmd=
)
> > +{
> > +    int32_t result;
> > +    struct rutabaga_transfer transfer =3D { 0 };
> > +    struct virtio_gpu_transfer_host_3d t3d;
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    VIRTIO_GPU_FILL_CMD(t3d);
> > +    trace_virtio_gpu_cmd_res_xfer_fromh_3d(t3d.resource_id);
> > +
> > +    transfer.x =3D t3d.box.x;
> > +    transfer.y =3D t3d.box.y;
> > +    transfer.z =3D t3d.box.z;
> > +    transfer.w =3D t3d.box.w;
> > +    transfer.h =3D t3d.box.h;
> > +    transfer.d =3D t3d.box.d;
> > +    transfer.level =3D t3d.level;
> > +    transfer.stride =3D t3d.stride;
> > +    transfer.layer_stride =3D t3d.layer_stride;
> > +    transfer.offset =3D t3d.offset;
> > +
> > +    result =3D rutabaga_resource_transfer_read(vr->rutabaga,
> t3d.hdr.ctx_id,
> > +                                             t3d.resource_id,
> &transfer, NULL);
> > +    CHECK(!result, cmd);
> > +}
> > +
> > +static void
> > +rutabaga_cmd_attach_backing(VirtIOGPU *g, struct
> virtio_gpu_ctrl_command *cmd)
> > +{
> > +    struct rutabaga_iovecs vecs =3D { 0 };
> > +    struct virtio_gpu_simple_resource *res;
> > +    struct virtio_gpu_resource_attach_backing att_rb;
> > +    int ret;
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    VIRTIO_GPU_FILL_CMD(att_rb);
> > +    trace_virtio_gpu_cmd_res_back_attach(att_rb.resource_id);
> > +
> > +    res =3D virtio_gpu_find_resource(g, att_rb.resource_id);
> > +    CHECK(res, cmd);
> > +    CHECK(!res->iov, cmd);
> > +
> > +    ret =3D virtio_gpu_create_mapping_iov(g, att_rb.nr_entries,
> sizeof(att_rb),
> > +                                        cmd, NULL, &res->iov,
> &res->iov_cnt);
> > +    CHECK(!ret, cmd);
> > +
> > +    vecs.iovecs =3D res->iov;
> > +    vecs.num_iovecs =3D res->iov_cnt;
> > +
> > +    ret =3D rutabaga_resource_attach_backing(vr->rutabaga,
> att_rb.resource_id,
> > +                                           &vecs);
> > +    if (ret !=3D 0) {
> > +        virtio_gpu_cleanup_mapping(g, res);
> > +    }
> > +
> > +    CHECK(!ret, cmd);
> > +}
> > +
> > +static void
> > +rutabaga_cmd_detach_backing(VirtIOGPU *g, struct
> virtio_gpu_ctrl_command *cmd)
> > +{
> > +    struct virtio_gpu_simple_resource *res;
> > +    struct virtio_gpu_resource_detach_backing detach_rb;
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    VIRTIO_GPU_FILL_CMD(detach_rb);
> > +    trace_virtio_gpu_cmd_res_back_detach(detach_rb.resource_id);
> > +
> > +    res =3D virtio_gpu_find_resource(g, detach_rb.resource_id);
> > +    CHECK(res, cmd);
> > +
> > +    rutabaga_resource_detach_backing(vr->rutabaga,
> > +                                     detach_rb.resource_id);
> > +
> > +    virtio_gpu_cleanup_mapping(g, res);
> > +}
> > +
> > +static void
> > +rutabaga_cmd_ctx_attach_resource(VirtIOGPU *g,
> > +                                 struct virtio_gpu_ctrl_command *cmd)
> > +{
> > +    int32_t result;
> > +    struct virtio_gpu_ctx_resource att_res;
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    VIRTIO_GPU_FILL_CMD(att_res);
> > +    trace_virtio_gpu_cmd_ctx_res_attach(att_res.hdr.ctx_id,
> > +                                        att_res.resource_id);
> > +
> > +    result =3D rutabaga_context_attach_resource(vr->rutabaga,
> att_res.hdr.ctx_id,
> > +                                              att_res.resource_id);
> > +    CHECK(!result, cmd);
> > +}
> > +
> > +static void
> > +rutabaga_cmd_ctx_detach_resource(VirtIOGPU *g,
> > +                                 struct virtio_gpu_ctrl_command *cmd)
> > +{
> > +    int32_t result;
> > +    struct virtio_gpu_ctx_resource det_res;
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    VIRTIO_GPU_FILL_CMD(det_res);
> > +    trace_virtio_gpu_cmd_ctx_res_detach(det_res.hdr.ctx_id,
> > +                                        det_res.resource_id);
> > +
> > +    result =3D rutabaga_context_detach_resource(vr->rutabaga,
> det_res.hdr.ctx_id,
> > +                                              det_res.resource_id);
> > +    CHECK(!result, cmd);
> > +}
> > +
> > +static void
> > +rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct
> virtio_gpu_ctrl_command *cmd)
> > +{
> > +    int32_t result;
> > +    struct virtio_gpu_get_capset_info info;
> > +    struct virtio_gpu_resp_capset_info resp;
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    VIRTIO_GPU_FILL_CMD(info);
> > +
> > +    result =3D rutabaga_get_capset_info(vr->rutabaga, info.capset_inde=
x,
> > +                                      &resp.capset_id,
> &resp.capset_max_version,
> > +                                      &resp.capset_max_size);
> > +    CHECK(!result, cmd);
> > +
> > +    resp.hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET_INFO;
> > +    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
> > +}
> > +
> > +static void
> > +rutabaga_cmd_get_capset(VirtIOGPU *g, struct virtio_gpu_ctrl_command
> *cmd)
> > +{
> > +    int32_t result;
> > +    struct virtio_gpu_get_capset gc;
> > +    struct virtio_gpu_resp_capset *resp;
> > +    uint32_t capset_size;
> > +    uint32_t current_id;
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    VIRTIO_GPU_FILL_CMD(gc);
> > +    for (uint32_t i =3D 0; i < vr->num_capsets; i++) {
> > +        CHECK(i < vr->num_capsets, cmd);
>
> This CHECK will not work since you have i < vr->num_capsets as the loop
> condition.
>
> > +        result =3D rutabaga_get_capset_info(vr->rutabaga, i,
> > +                                          &current_id, &capset_size,
> > +                                          &capset_size);
> > +        CHECK(!result, cmd);
> > +
> > +        if (current_id =3D=3D gc.capset_id) {
> > +            break;
> > +        }
> > +    }
> > +
> > +    resp =3D g_malloc0(sizeof(*resp) + capset_size);
> > +    resp->hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET;
> > +    rutabaga_get_capset(vr->rutabaga, gc.capset_id, gc.capset_version,
> > +                        resp->capset_data, capset_size);
> > +
> > +    virtio_gpu_ctrl_response(g, cmd, &resp->hdr, sizeof(*resp) +
> capset_size);
> > +    g_free(resp);
> > +}
> > +
> > +static void
> > +rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
> > +                                  struct virtio_gpu_ctrl_command *cmd)
> > +{
> > +    int result;
> > +    struct rutabaga_iovecs vecs =3D { 0 };
> > +    g_autofree struct virtio_gpu_simple_resource *res =3D NULL;
> > +    struct virtio_gpu_resource_create_blob cblob;
> > +    struct rutabaga_create_blob rc_blob =3D { 0 };
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    VIRTIO_GPU_FILL_CMD(cblob);
> > +    trace_virtio_gpu_cmd_res_create_blob(cblob.resource_id, cblob.size=
);
> > +
> > +    CHECK(cblob.resource_id !=3D 0, cmd);
> > +
> > +    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
> > +
> > +    res->resource_id =3D cblob.resource_id;
> > +    res->blob_size =3D cblob.size;
> > +
> > +    if (cblob.blob_mem !=3D VIRTIO_GPU_BLOB_MEM_HOST3D) {
> > +        result =3D virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
> > +                                               sizeof(cblob), cmd,
> &res->addrs,
> > +                                               &res->iov,
> &res->iov_cnt);
> > +        CHECK(!result, cmd);
> > +    }
> > +
> > +    rc_blob.blob_id =3D cblob.blob_id;
> > +    rc_blob.blob_mem =3D cblob.blob_mem;
> > +    rc_blob.blob_flags =3D cblob.blob_flags;
> > +    rc_blob.size =3D cblob.size;
> > +
> > +    vecs.iovecs =3D res->iov;
> > +    vecs.num_iovecs =3D res->iov_cnt;
> > +
> > +    result =3D rutabaga_resource_create_blob(vr->rutabaga,
> cblob.hdr.ctx_id,
> > +                                           cblob.resource_id, &rc_blob=
,
> &vecs,
> > +                                           NULL);
> > +
> > +    if (result && cblob.blob_mem !=3D VIRTIO_GPU_BLOB_MEM_HOST3D) {
> > +        virtio_gpu_cleanup_mapping(g, res);
> > +    }
> > +
> > +    CHECK(!result, cmd);
> > +
> > +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
> > +    res =3D NULL;
> > +}
> > +
> > +static void
> > +rutabaga_cmd_resource_map_blob(VirtIOGPU *g,
> > +                               struct virtio_gpu_ctrl_command *cmd)
> > +{
> > +    int32_t result;
> > +    uint32_t map_info =3D 0;
> > +    uint32_t slot =3D 0;
> > +    struct virtio_gpu_simple_resource *res;
> > +    struct rutabaga_mapping mapping =3D { 0 };
> > +    struct virtio_gpu_resource_map_blob mblob;
> > +    struct virtio_gpu_resp_map_info resp =3D { 0 };
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    VIRTIO_GPU_FILL_CMD(mblob);
> > +
> > +    CHECK(mblob.resource_id !=3D 0, cmd);
> > +
> > +    res =3D virtio_gpu_find_resource(g, mblob.resource_id);
> > +    CHECK(res, cmd);
> > +
> > +    result =3D rutabaga_resource_map_info(vr->rutabaga, mblob.resource=
_id,
> > +                                        &map_info);
> > +    CHECK(!result, cmd);
> > +
> > +    /*
> > +     * RUTABAGA_MAP_ACCESS_* flags are not part of the virtio-gpu spec=
,
> but do
> > +     * exist to potentially allow the hypervisor to restrict write
> access to
> > +     * memory. QEMU does not need to use this functionality at the
> moment.
> > +     */
> > +    resp.map_info =3D map_info & RUTABAGA_MAP_CACHE_MASK;
> > +
> > +    result =3D rutabaga_resource_map(vr->rutabaga, mblob.resource_id,
> &mapping);
> > +    CHECK(!result, cmd);
> > +
> > +    for (slot =3D 0; slot < MAX_SLOTS; slot++) {
> > +        if (vr->memory_regions[slot].used) {
> > +            continue;
> > +        }
> > +
> > +        MemoryRegion *mr =3D &(vr->memory_regions[slot].mr);
> > +        memory_region_init_ram_ptr(mr, NULL, "blob", mapping.size,
> > +                                   mapping.ptr);
> > +        memory_region_add_subregion(&g->parent_obj.hostmem,
> > +                                    mblob.offset, mr);
> > +        vr->memory_regions[slot].resource_id =3D mblob.resource_id;
> > +        vr->memory_regions[slot].used =3D 1;
> > +        break;
> > +    }
> > +
> > +    if (slot >=3D MAX_SLOTS) {
> > +        result =3D rutabaga_resource_unmap(vr->rutabaga,
> mblob.resource_id);
> > +        CHECK(!result, cmd);
> > +    }
> > +
> > +    CHECK(slot < MAX_SLOTS, cmd);
> > +
> > +    resp.hdr.type =3D VIRTIO_GPU_RESP_OK_MAP_INFO;
> > +    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
> > +}
> > +
> > +static void
> > +rutabaga_cmd_resource_unmap_blob(VirtIOGPU *g,
> > +                                 struct virtio_gpu_ctrl_command *cmd)
> > +{
> > +    int32_t result;
> > +    uint32_t slot =3D 0;
> > +    struct virtio_gpu_simple_resource *res;
> > +    struct virtio_gpu_resource_unmap_blob ublob;
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    VIRTIO_GPU_FILL_CMD(ublob);
> > +
> > +    CHECK(ublob.resource_id !=3D 0, cmd);
> > +
> > +    res =3D virtio_gpu_find_resource(g, ublob.resource_id);
> > +    CHECK(res, cmd);
> > +
> > +    for (slot =3D 0; slot < MAX_SLOTS; slot++) {
> > +        if (vr->memory_regions[slot].resource_id !=3D ublob.resource_i=
d) {
> > +            continue;
> > +        }
> > +
> > +        MemoryRegion *mr =3D &(vr->memory_regions[slot].mr);
> > +        memory_region_del_subregion(&g->parent_obj.hostmem, mr);
> > +
> > +        vr->memory_regions[slot].resource_id =3D 0;
> > +        vr->memory_regions[slot].used =3D 0;
> > +        break;
> > +    }
> > +
> > +    CHECK(slot < MAX_SLOTS, cmd);
> > +    result =3D rutabaga_resource_unmap(vr->rutabaga, res->resource_id)=
;
> > +    CHECK(!result, cmd);
> > +}
> > +
> > +static void
> > +virtio_gpu_rutabaga_process_cmd(VirtIOGPU *g,
> > +                                struct virtio_gpu_ctrl_command *cmd)
> > +{
> > +    struct rutabaga_fence fence =3D { 0 };
> > +    int32_t result;
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
> > +
> > +    switch (cmd->cmd_hdr.type) {
> > +    case VIRTIO_GPU_CMD_CTX_CREATE:
> > +        rutabaga_cmd_context_create(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_CTX_DESTROY:
> > +        rutabaga_cmd_context_destroy(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_2D:
> > +        rutabaga_cmd_create_resource_2d(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_3D:
> > +        rutabaga_cmd_create_resource_3d(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_SUBMIT_3D:
> > +        rutabaga_cmd_submit_3d(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D:
> > +        rutabaga_cmd_transfer_to_host_2d(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D:
> > +        rutabaga_cmd_transfer_to_host_3d(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D:
> > +        rutabaga_cmd_transfer_from_host_3d(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING:
> > +        rutabaga_cmd_attach_backing(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:
> > +        rutabaga_cmd_detach_backing(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_SET_SCANOUT:
> > +        rutabaga_cmd_set_scanout(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_RESOURCE_FLUSH:
> > +        rutabaga_cmd_resource_flush(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_RESOURCE_UNREF:
> > +        rutabaga_cmd_resource_unref(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:
> > +        rutabaga_cmd_ctx_attach_resource(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE:
> > +        rutabaga_cmd_ctx_detach_resource(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_GET_CAPSET_INFO:
> > +        rutabaga_cmd_get_capset_info(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_GET_CAPSET:
> > +        rutabaga_cmd_get_capset(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:
> > +        virtio_gpu_get_display_info(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_GET_EDID:
> > +        virtio_gpu_get_edid(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB:
> > +        rutabaga_cmd_resource_create_blob(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB:
> > +        rutabaga_cmd_resource_map_blob(g, cmd);
> > +        break;
> > +    case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:
> > +        rutabaga_cmd_resource_unmap_blob(g, cmd);
> > +        break;
> > +    default:
> > +        cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
> > +        break;
> > +    }
> > +
> > +    if (cmd->finished) {
> > +        return;
> > +    }
> > +    if (cmd->error) {
> > +        error_report("%s: ctrl 0x%x, error 0x%x", __func__,
> > +                     cmd->cmd_hdr.type, cmd->error);
> > +        virtio_gpu_ctrl_response_nodata(g, cmd, cmd->error);
> > +        return;
> > +    }
> > +    if (!(cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE)) {
> > +        virtio_gpu_ctrl_response_nodata(g, cmd,
> VIRTIO_GPU_RESP_OK_NODATA);
> > +        return;
> > +    }
> > +
> > +    fence.flags =3D cmd->cmd_hdr.flags;
> > +    fence.ctx_id =3D cmd->cmd_hdr.ctx_id;
> > +    fence.fence_id =3D cmd->cmd_hdr.fence_id;
> > +    fence.ring_idx =3D cmd->cmd_hdr.ring_idx;
> > +
> > +    trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id,
> cmd->cmd_hdr.type);
> > +
> > +    result =3D rutabaga_create_fence(vr->rutabaga, &fence);
> > +    CHECK(!result, cmd);
> > +}
> > +
> > +static void
> > +virtio_gpu_rutabaga_aio_cb(void *opaque)
> > +{
> > +    struct rutabaga_aio_data *data =3D opaque;
> > +    VirtIOGPU *g =3D VIRTIO_GPU(data->vr);
> > +    struct rutabaga_fence fence_data =3D data->fence;
> > +    struct virtio_gpu_ctrl_command *cmd, *tmp;
> > +
> > +    uint32_t signaled_ctx_specific =3D fence_data.flags &
> > +                                     RUTABAGA_FLAG_INFO_RING_IDX;
> > +
> > +    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
> > +        /*
> > +         * Due to context specific timelines.
> > +         */
> > +        uint32_t target_ctx_specific =3D cmd->cmd_hdr.flags &
> > +                                       RUTABAGA_FLAG_INFO_RING_IDX;
> > +
> > +        if (signaled_ctx_specific !=3D target_ctx_specific) {
> > +            continue;
> > +        }
> > +
> > +        if (signaled_ctx_specific &&
> > +           (cmd->cmd_hdr.ring_idx !=3D fence_data.ring_idx)) {
> > +            continue;
> > +        }
> > +
> > +        if (cmd->cmd_hdr.fence_id > fence_data.fence_id) {
> > +            continue;
> > +        }
> > +
> > +        trace_virtio_gpu_fence_resp(cmd->cmd_hdr.fence_id);
> > +        virtio_gpu_ctrl_response_nodata(g, cmd,
> VIRTIO_GPU_RESP_OK_NODATA);
> > +        QTAILQ_REMOVE(&g->fenceq, cmd, next);
> > +        g_free(cmd);
> > +    }
> > +
> > +    g_free(data);
> > +}
> > +
> > +static void
> > +virtio_gpu_rutabaga_fence_cb(uint64_t user_data,
> > +                             const struct rutabaga_fence *fence) {
> > +    struct rutabaga_aio_data *data;
> > +    VirtIOGPU *g =3D (VirtIOGPU *)user_data;
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    /*
> > +     * gfxstream and both cross-domain (and even newer versions
> virglrenderer:
> > +     * see VIRGL_RENDERER_ASYNC_FENCE_CB) like to signal fence
> completion on
> > +     * threads ("callback threads") that are different from the thread
> that
> > +     * processes the command queue ("main thread").
> > +     *
> > +     * crosvm and other virtio-gpu 1.1 implementations enable callback
> threads
> > +     * via locking.  However, on QEMU a deadlock is observed if
> > +     * virtio_gpu_ctrl_response_nodata(..) [used in the fence callback=
]
> is used
> > +     * from a thread that is not the main thread.
> > +     *
> > +     * The reason is QEMU's internal locking is designed to work with
> QEMU
> > +     * threads (see rcu_register_thread()) and not generic C/C++/Rust
> threads.
> > +     * For now, we can workaround this by scheduling the return of the
> > +     * fence descriptors on the main thread.
> > +     */
> > +
> > +    data =3D g_new0(struct rutabaga_aio_data, 1);
> > +    data->vr =3D vr;
> > +    data->fence =3D *fence;
> > +    aio_bh_schedule_oneshot_full(qemu_get_aio_context(),
> > +                                 virtio_gpu_rutabaga_aio_cb,
> > +                                 data, "aio");
> > +}
> > +
> > +static void
> > +virtio_gpu_rutabaga_debug_cb(uint64_t user_data,
> > +                             const struct rutabaga_debug *debug) {
> > +
> > +    if (debug->debug_type =3D=3D RUTABAGA_DEBUG_ERROR) {
> > +        error_report("%s", debug->message);
> > +    } else if (debug->debug_type =3D=3D RUTABAGA_DEBUG_WARN) {
> > +        warn_report("%s", debug->message);
> > +    } else if (debug->debug_type =3D=3D RUTABAGA_DEBUG_INFO) {
> > +        info_report("%s", debug->message);
> > +    }
> > +}
> > +
> > +static int virtio_gpu_rutabaga_init(VirtIOGPU *g, Error **errp)
> > +{
> > +    int result;
> > +    uint64_t capset_mask;
> > +    struct rutabaga_builder builder =3D { 0 };
> > +    char wayland_socket_path[UNIX_PATH_MAX];
> > +    struct rutabaga_channel channel =3D { 0 };
> > +    struct rutabaga_channels channels =3D { 0 };
> > +
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +    vr->rutabaga =3D NULL;
> > +
> > +    if (!vr->capset_names) {
> > +        error_setg(errp, "a capset name from the virtio-gpu spec is
> required");
> > +        return -EINVAL;
> > +    }
> > +
> > +    builder.wsi =3D RUTABAGA_WSI_SURFACELESS;
> > +    /*
> > +     * Currently, if WSI is specified, the only valid strings are
> "surfaceless"
> > +     * or "headless".  Surfaceless doesn't create a native window
> surface, but
> > +     * does copy from the render target to the Pixman buffer if a
> virtio-gpu
> > +     * 2D hypercall is issued.  Surfacless is the default.
> > +     *
> > +     * Headless is like surfaceless, but doesn't copy to the Pixman
> buffer. The
> > +     * use case is automated testing environments where there is no
> need to view
> > +     * results.
> > +     *
> > +     * In the future, more performant virtio-gpu 2D UI integration may
> be added.
> > +     */
> > +    if (vr->wsi) {
> > +        if (g_str_equal(vr->wsi, "surfaceless")) {
> > +            vr->headless =3D false;
> > +        } else if (g_str_equal(vr->wsi, "headless")) {
> > +            vr->headless =3D true;
> > +        } else {
> > +            error_setg(errp, "invalid wsi option selected");
> > +            return -EINVAL;
> > +        }
> > +    }
> > +
> > +    result =3D rutabaga_calculate_capset_mask(vr->capset_names,
> &capset_mask);
> > +    if (result) {
> > +        error_setg(errp, "invalid capset names: %s", vr->capset_names)=
;
> > +        return result;
> > +    }
> > +
> > +    builder.fence_cb =3D virtio_gpu_rutabaga_fence_cb;
> > +    builder.debug_cb =3D virtio_gpu_rutabaga_debug_cb;
> > +    builder.capset_mask =3D capset_mask;
> > +    builder.user_data =3D (uint64_t)g;
> > +
> > +    /*
> > +     * If the user doesn't specify the wayland socket path, we try to
> infer
> > +     * the socket via a process similar to the one used by libwayland.
> > +     * libwayland does the following:
> > +     *
> > +     * 1) If $WAYLAND_DISPLAY is set, attempt to connect to
> > +     *    $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY
> > +     * 2) Otherwise, attempt to connect to $XDG_RUNTIME_DIR/wayland-0
> > +     * 3) Otherwise, don't pass a wayland socket to rutabaga. If a gue=
st
> > +     *    wayland proxy is launched, it will fail to work.
> > +     */
> > +    channel.channel_type =3D RUTABAGA_CHANNEL_TYPE_WAYLAND;
> > +    if (!vr->wayland_socket_path) {
> > +        const char *runtime_dir =3D getenv("XDG_RUNTIME_DIR");
> > +        const char *display =3D getenv("WAYLAND_DISPLAY");
> > +        if (!display) {
> > +            display =3D "wayland-0";
> > +        }
> > +
> > +        if (runtime_dir) {
> > +            result =3D snprintf(wayland_socket_path, UNIX_PATH_MAX,
> > +                              "%s/%s", runtime_dir, display);
> > +            if (result > 0 && result < UNIX_PATH_MAX) {
> > +                channel.channel_name =3D wayland_socket_path;
> > +            }
>
> As I said in the last email, I think it's better to make a hard error if
> the user requested RUTABAGA_CAPSET_CROSS_DOMAIN but the default socket
> path does not fit in wayland_socket_path.
>

I mentioned this in the cover-letter to v5, but messed up the commit
message of patch 6.  But we do want to be possible to use cross_domain
without wayland for following reason:

"It is possible to use cross-domain without enabling Wayland, for guest
swapchain allocation [a] which often needs special handling.  We might
We want to use this capability on MacOS/Windows in the future without
Wayland, hence we shouldn't have hard errors if the default wayland socket
isn't found.

[a]
https://android.googlesource.com/platform/external/minigbm/+/refs/heads/mai=
n/virtgpu_cross_domain.c
"

I'll incorporate your other suggestions in v6 though.




>
> > +        }
> > +    } else {
> > +        channel.channel_name =3D vr->wayland_socket_path;
> > +    }
> > +
> > +    if ((builder.capset_mask & (1 << RUTABAGA_CAPSET_CROSS_DOMAIN))) {
> > +        if (channel.channel_name) {
> > +            channels.channels =3D &channel;
> > +            channels.num_channels =3D 1;
> > +            builder.channels =3D &channels;
> > +        }
> > +    }
> > +
> > +    result =3D rutabaga_init(&builder, &vr->rutabaga);
> > +    return result;
> > +}
> > +
> > +static int virtio_gpu_rutabaga_get_num_capsets(VirtIOGPU *g)
> > +{
> > +    int result;
> > +    uint32_t num_capsets;
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    result =3D rutabaga_get_num_capsets(vr->rutabaga, &num_capsets);
> > +    if (result) {
> > +        error_report("Failed to get capsets");
> > +        return 0;
> > +    }
> > +    vr->num_capsets =3D num_capsets;
> > +    return num_capsets;
> > +}
> > +
> > +static void virtio_gpu_rutabaga_handle_ctrl(VirtIODevice *vdev,
> VirtQueue *vq)
> > +{
> > +    VirtIOGPU *g =3D VIRTIO_GPU(vdev);
> > +    struct virtio_gpu_ctrl_command *cmd;
> > +
> > +    if (!virtio_queue_ready(vq)) {
> > +        return;
> > +    }
> > +
> > +    cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command));
> > +    while (cmd) {
> > +        cmd->vq =3D vq;
> > +        cmd->error =3D 0;
> > +        cmd->finished =3D false;
> > +        QTAILQ_INSERT_TAIL(&g->cmdq, cmd, next);
> > +        cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_comman=
d));
> > +    }
> > +
> > +    virtio_gpu_process_cmdq(g);
> > +}
> > +
> > +static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **err=
p)
> > +{
> > +    int num_capsets;
> > +    VirtIOGPUBase *bdev =3D VIRTIO_GPU_BASE(qdev);
> > +    VirtIOGPU *gpudev =3D VIRTIO_GPU(qdev);
> > +
> > +#if HOST_BIG_ENDIAN
> > +    error_setg(errp, "rutabaga is not supported on bigendian
> platforms");
> > +    return;
> > +#endif
> > +
> > +    int result =3D virtio_gpu_rutabaga_init(gpudev, errp);
> > +    if (result) {
> > +        error_setg(errp, "virtio_gpu_rutabaga_init failed");
> > +        return;
> > +    }
> > +
> > +    num_capsets =3D virtio_gpu_rutabaga_get_num_capsets(gpudev);
> > +    if (!num_capsets) {
> > +        return;
> > +    }
> > +
> > +    bdev->conf.flags |=3D (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED);
> > +    bdev->conf.flags |=3D (1 << VIRTIO_GPU_FLAG_BLOB_ENABLED);
> > +    bdev->conf.flags |=3D (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED);
> > +
> > +    bdev->virtio_config.num_capsets =3D num_capsets;
> > +    virtio_gpu_device_realize(qdev, errp);
> > +}
> > +
> > +static Property virtio_gpu_rutabaga_properties[] =3D {
> > +    DEFINE_PROP_STRING("capset_names", VirtIOGPURutabaga, capset_names=
),
> > +    DEFINE_PROP_STRING("wayland_socket_path", VirtIOGPURutabaga,
> > +                       wayland_socket_path),
> > +    DEFINE_PROP_STRING("wsi", VirtIOGPURutabaga, wsi),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void virtio_gpu_rutabaga_class_init(ObjectClass *klass, void
> *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
> > +    VirtIOGPUBaseClass *vbc =3D VIRTIO_GPU_BASE_CLASS(klass);
> > +    VirtIOGPUClass *vgc =3D VIRTIO_GPU_CLASS(klass);
> > +
> > +    vbc->gl_flushed =3D virtio_gpu_rutabaga_gl_flushed;
> > +    vgc->handle_ctrl =3D virtio_gpu_rutabaga_handle_ctrl;
> > +    vgc->process_cmd =3D virtio_gpu_rutabaga_process_cmd;
> > +    vgc->update_cursor_data =3D virtio_gpu_rutabaga_update_cursor;
> > +
> > +    vdc->realize =3D virtio_gpu_rutabaga_realize;
> > +    device_class_set_props(dc, virtio_gpu_rutabaga_properties);
> > +}
> > +
> > +static const TypeInfo virtio_gpu_rutabaga_info =3D {
> > +    .name =3D TYPE_VIRTIO_GPU_RUTABAGA,
> > +    .parent =3D TYPE_VIRTIO_GPU,
> > +    .instance_size =3D sizeof(VirtIOGPURutabaga),
> > +    .class_init =3D virtio_gpu_rutabaga_class_init,
> > +};
> > +module_obj(TYPE_VIRTIO_GPU_RUTABAGA);
> > +module_kconfig(VIRTIO_GPU);
> > +
> > +static void virtio_register_types(void)
> > +{
> > +    type_register_static(&virtio_gpu_rutabaga_info);
> > +}
> > +
> > +type_init(virtio_register_types)
> > +
> > +module_dep("hw-display-virtio-gpu");
> > diff --git a/hw/display/virtio-vga-rutabaga.c
> b/hw/display/virtio-vga-rutabaga.c
> > new file mode 100644
> > index 0000000000..2b2ffed8a6
> > --- /dev/null
> > +++ b/hw/display/virtio-vga-rutabaga.c
> > @@ -0,0 +1,51 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/pci/pci.h"
> > +#include "hw/qdev-properties.h"
> > +#include "hw/virtio/virtio-gpu.h"
> > +#include "hw/display/vga.h"
> > +#include "qapi/error.h"
> > +#include "qemu/module.h"
> > +#include "virtio-vga.h"
> > +#include "qom/object.h"
> > +
> > +#define TYPE_VIRTIO_VGA_RUTABAGA "virtio-vga-rutabaga"
> > +
> > +typedef struct VirtIOVGARutabaga VirtIOVGARutabaga;
> > +DECLARE_INSTANCE_CHECKER(VirtIOVGARutabaga, VIRTIO_VGA_RUTABAGA,
> > +                         TYPE_VIRTIO_VGA_RUTABAGA)
> > +
> > +struct VirtIOVGARutabaga {
> > +    VirtIOVGABase parent_obj;
> > +    VirtIOGPURutabaga vdev;
> > +};
> > +
> > +static void virtio_vga_rutabaga_inst_initfn(Object *obj)
> > +{
> > +    VirtIOVGARutabaga *dev =3D VIRTIO_VGA_RUTABAGA(obj);
> > +
> > +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> > +                                TYPE_VIRTIO_GPU_RUTABAGA);
> > +    VIRTIO_VGA_BASE(dev)->vgpu =3D VIRTIO_GPU_BASE(&dev->vdev);
> > +}
> > +
> > +static VirtioPCIDeviceTypeInfo virtio_vga_rutabaga_info =3D {
> > +    .generic_name  =3D TYPE_VIRTIO_VGA_RUTABAGA,
> > +    .parent        =3D TYPE_VIRTIO_VGA_BASE,
> > +    .instance_size =3D sizeof(VirtIOVGARutabaga),
> > +    .instance_init =3D virtio_vga_rutabaga_inst_initfn,
> > +};
> > +module_obj(TYPE_VIRTIO_VGA_RUTABAGA);
> > +module_kconfig(VIRTIO_VGA);
> > +
> > +static void virtio_vga_register_types(void)
> > +{
> > +    if (have_vga) {
> > +        virtio_pci_types_register(&virtio_vga_rutabaga_info);
> > +    }
> > +}
> > +
> > +type_init(virtio_vga_register_types)
> > +
> > +module_dep("hw-display-virtio-vga");
>

--0000000000006c50750602f82400
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 15, 2023 at 8:07=E2=80=AF=
AM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@gmail.com" target=3D"_=
blank">akihiko.odaki@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On 2023/08/15 9:35, Gurchetan Singh wrote:<br=
>
&gt; This adds initial support for gfxstream and cross-domain.=C2=A0 Both<b=
r>
&gt; features rely on virtio-gpu blob resources and context types, which<br=
>
&gt; are also implemented in this patch.<br>
&gt; <br>
&gt; gfxstream has a long and illustrious history in Android graphics<br>
&gt; paravirtualization.=C2=A0 It has been powering graphics in the Android=
<br>
&gt; Studio Emulator for more than a decade, which is the main developer<br=
>
&gt; platform.<br>
&gt; <br>
&gt; Originally conceived by Jesse Hall, it was first known as &quot;EmuGL&=
quot; [a].<br>
&gt; The key design characteristic was a 1:1 threading model and<br>
&gt; auto-generation, which fit nicely with the OpenGLES spec.=C2=A0 It als=
o<br>
&gt; allowed easy layering with ANGLE on the host, which provides the GLES<=
br>
&gt; implementations on Windows or MacOS enviroments.<br>
&gt; <br>
&gt; gfxstream has traditionally been maintained by a single engineer, and<=
br>
&gt; between 2015 to 2021, the goldfish throne passed to Frank Yang.<br>
&gt; Historians often remark this glorious reign (&quot;pax gfxstreama&quot=
; is the<br>
&gt; academic term) was comparable to that of Augustus and both Queen<br>
&gt; Elizabeths.=C2=A0 Just to name a few accomplishments in a resplendent<=
br>
&gt; panoply: higher versions of GLES, address space graphics, snapshot<br>
&gt; support and CTS compliant Vulkan [b].<br>
&gt; <br>
&gt; One major drawback was the use of out-of-tree goldfish drivers.<br>
&gt; Android engineers didn&#39;t know much about DRM/KMS and especially TT=
M so<br>
&gt; a simple guest to host pipe was conceived.<br>
&gt; <br>
&gt; Luckily, virtio-gpu 3D started to emerge in 2016 due to the work of<br=
>
&gt; the Mesa/virglrenderer communities.=C2=A0 In 2018, the initial virtio-=
gpu<br>
&gt; port of gfxstream was done by Cuttlefish enthusiast Alistair Delva.<br=
>
&gt; It was a symbol compatible replacement of virglrenderer [c] and named<=
br>
&gt; &quot;AVDVirglrenderer&quot;.=C2=A0 This implementation forms the basi=
s of the<br>
&gt; current gfxstream host implementation still in use today.<br>
&gt; <br>
&gt; cross-domain support follows a similar arc.=C2=A0 Originally conceived=
 by<br>
&gt; Wayland aficionado David Reveman and crosvm enjoyer Zach Reizner in<br=
>
&gt; 2018, it initially relied on the downstream &quot;virtio-wl&quot; devi=
ce.<br>
&gt; <br>
&gt; In 2020 and 2021, virtio-gpu was extended to include blob resources<br=
>
&gt; and multiple timelines by yours truly, features gfxstream/cross-domain=
<br>
&gt; both require to function correctly.<br>
&gt; <br>
&gt; Right now, we stand at the precipice of a truly fantastic possibility:=
<br>
&gt; the Android Emulator powered by upstream QEMU and upstream Linux<br>
&gt; kernel.=C2=A0 gfxstream will then be packaged properfully, and app<br>
&gt; developers can even fix gfxstream bugs on their own if they encounter<=
br>
&gt; them.<br>
&gt; <br>
&gt; It&#39;s been quite the ride, my friends.=C2=A0 Where will gfxstream h=
ead next,<br>
&gt; nobody really knows.=C2=A0 I wouldn&#39;t be surprised if it&#39;s aro=
und for<br>
&gt; another decade, maintained by a new generation of Android graphics<br>
&gt; enthusiasts.<br>
&gt; <br>
&gt; Technical details:<br>
&gt;=C2=A0 =C2=A0 - Very simple initial display integration: just used Pixm=
an<br>
&gt;=C2=A0 =C2=A0 - Largely, 1:1 mapping of virtio-gpu hypercalls to rutaba=
ga function<br>
&gt;=C2=A0 =C2=A0 =C2=A0 calls<br>
&gt; <br>
&gt; Next steps for Android VMs:<br>
&gt;=C2=A0 =C2=A0 - The next step would be improving display integration an=
d UI interfaces<br>
&gt;=C2=A0 =C2=A0 =C2=A0 with the goal of the QEMU upstream graphics being =
in an emulator<br>
&gt;=C2=A0 =C2=A0 =C2=A0 release [d].<br>
&gt; <br>
&gt; Next steps for Linux VMs for display virtualization:<br>
&gt;=C2=A0 =C2=A0 - For widespread distribution, someone needs to package S=
ommelier or the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 wayland-proxy-virtwl [e] ideally into Debian main.=
 In addition, newer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 versions of the Linux kernel come with DRM_VIRTIO_=
GPU_KMS option,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 which allows disabling KMS hypercalls.=C2=A0 If an=
yone cares enough, it&#39;ll<br>
&gt;=C2=A0 =C2=A0 =C2=A0 probably be possible to build a custom VM variant =
that uses this display<br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtualization strategy.<br>
&gt; <br>
&gt; [a] <a href=3D"https://android-review.googlesource.com/c/platform/deve=
lopment/+/34470" rel=3D"noreferrer" target=3D"_blank">https://android-revie=
w.googlesource.com/c/platform/development/+/34470</a><br>
&gt; [b] <a href=3D"https://android-review.googlesource.com/q/topic:%22vulk=
an-hostconnection-start%22" rel=3D"noreferrer" target=3D"_blank">https://an=
droid-review.googlesource.com/q/topic:%22vulkan-hostconnection-start%22</a>=
<br>
&gt; [c] <a href=3D"https://android-review.googlesource.com/c/device/generi=
c/goldfish-opengl/+/761927" rel=3D"noreferrer" target=3D"_blank">https://an=
droid-review.googlesource.com/c/device/generic/goldfish-opengl/+/761927</a>=
<br>
&gt; [d] <a href=3D"https://developer.android.com/studio/releases/emulator"=
 rel=3D"noreferrer" target=3D"_blank">https://developer.android.com/studio/=
releases/emulator</a><br>
&gt; [e] <a href=3D"https://github.com/talex5/wayland-proxy-virtwl" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/talex5/wayland-proxy-virtw=
l</a><br>
&gt; <br>
&gt; Signed-off-by: Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@ch=
romium.org" target=3D"_blank">gurchetansingh@chromium.org</a>&gt;<br>
&gt; Tested-by: Alyssa Ross &lt;<a href=3D"mailto:hi@alyssa.is" target=3D"_=
blank">hi@alyssa.is</a>&gt;<br>
&gt; ---<br>
&gt; v1: Incorported various suggestions by Akihiko Odaki and Bernard Bersc=
how<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Removed GET_VIRTIO_GPU_GL / GET_RUTABAGA macros<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Used error_report(..)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Used g_autofree to fix leaks on error paths<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Removed unnecessary casts<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - added virtio-gpu-pci-rutabaga.c + virtio-vga-rut=
abaga.c files<br>
&gt; <br>
&gt; v2: Incorported various suggestions by Akihiko Odaki, Marc-Andr=C3=A9 =
Lureau and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Bernard Berschow:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Parenthesis in CHECK macro<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - CHECK_RESULT(result, ..) --&gt; CHECK(!result, .=
.)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - delay until g-&gt;parent_obj.enable =3D 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Additional cast fixes<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - initialize directly in virtio_gpu_rutabaga_reali=
ze(..)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - add debug callback to hook into QEMU error&#39;s=
 APIs<br>
&gt; <br>
&gt; v3: Incorporated feedback from Akihiko Odaki and Alyssa Ross:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Autodetect Wayland socket when not explicitly sp=
ecified<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Fix map_blob error paths<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Add comment why we need both `res` and `resource=
` in create blob<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Cast and whitespace fixes<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Big endian check comes before virtio_gpu_rutabag=
a_init().<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - VirtIOVGARUTABAGA --&gt; VirtIOVGARutabaga<br>
&gt; <br>
&gt; v4: Incorporated feedback from Akihiko Odaki and Alyssa Ross:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Double checked all casts<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Remove unnecessary parenthesis<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Removed `resource` in create_blob<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Added comment about failure case<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Pass user-provided socket as-is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Use stack variable rather than heap allocation<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 - Future-proofed map info API to give access flags=
 as well<br>
&gt; <br>
&gt; v5: Incorporated feedback from Akihiko Odaki:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Check (ss.scanout_id &lt; VIRTIO_GPU_MAX_SCANOUT=
S)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Simplify num_capsets check<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Call cleanup mapping on error paths<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - uint64_t --&gt; void* for rutabaga_map(..)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Removed unnecessary parenthesis<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Removed unnecessary cast<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - #define UNIX_PATH_MAX sizeof((struct sockaddr_un=
) {}.sun_path)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Reuse result variable<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Report error when default socket doesn&#39;t fit=
 in Wayland socket path<br>
&gt; <br>
&gt;=C2=A0 =C2=A0hw/display/virtio-gpu-pci-rutabaga.c |=C2=A0 =C2=A048 ++<b=
r>
&gt;=C2=A0 =C2=A0hw/display/virtio-gpu-rutabaga.c=C2=A0 =C2=A0 =C2=A0| 1114=
 ++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/display/virtio-vga-rutabaga.c=C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A051 ++<br>
&gt;=C2=A0 =C2=A03 files changed, 1213 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c<br=
>
&gt;=C2=A0 =C2=A0create mode 100644 hw/display/virtio-gpu-rutabaga.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/display/virtio-vga-rutabaga.c<br>
&gt; <br>
&gt; diff --git a/hw/display/virtio-gpu-pci-rutabaga.c b/hw/display/virtio-=
gpu-pci-rutabaga.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..c71173d8ca<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/display/virtio-gpu-pci-rutabaga.c<br>
&gt; @@ -0,0 +1,48 @@<br>
&gt; +// SPDX-License-Identifier: GPL-2.0<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;hw/pci/pci.h&quot;<br>
&gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt; +#include &quot;hw/virtio/virtio.h&quot;<br>
&gt; +#include &quot;hw/virtio/virtio-bus.h&quot;<br>
&gt; +#include &quot;hw/virtio/virtio-gpu-pci.h&quot;<br>
&gt; +#include &quot;qom/object.h&quot;<br>
&gt; +<br>
&gt; +#define TYPE_VIRTIO_GPU_RUTABAGA_PCI &quot;virtio-gpu-rutabaga-pci&qu=
ot;<br>
&gt; +typedef struct VirtIOGPURutabagaPCI VirtIOGPURutabagaPCI;<br>
&gt; +DECLARE_INSTANCE_CHECKER(VirtIOGPURutabagaPCI, VIRTIO_GPU_RUTABAGA_PC=
I,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0TYPE_VIRTIO_GPU_RUTABAGA_PCI)<br>
&gt; +<br>
&gt; +struct VirtIOGPURutabagaPCI {<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPUPCIBase parent_obj;<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga vdev;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void virtio_gpu_rutabaga_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabagaPCI *dev =3D VIRTIO_GPU_RUTABAGA_PCI(o=
bj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 virtio_instance_init_common(obj, &amp;dev-&gt;vdev, siz=
eof(dev-&gt;vdev),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_VIRTIO_GPU_RUTABAGA);<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_PCI_BASE(obj)-&gt;vgpu =3D VIRTIO_GPU_BASE(&=
amp;dev-&gt;vdev);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const VirtioPCIDeviceTypeInfo virtio_gpu_rutabaga_pci_info =3D=
 {<br>
&gt; +=C2=A0 =C2=A0 .generic_name =3D TYPE_VIRTIO_GPU_RUTABAGA_PCI,<br>
&gt; +=C2=A0 =C2=A0 .parent =3D TYPE_VIRTIO_GPU_PCI_BASE,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(VirtIOGPURutabagaPCI),<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D virtio_gpu_rutabaga_initfn,<br>
&gt; +};<br>
&gt; +module_obj(TYPE_VIRTIO_GPU_RUTABAGA_PCI);<br>
&gt; +module_kconfig(VIRTIO_PCI);<br>
&gt; +<br>
&gt; +static void virtio_gpu_rutabaga_pci_register_types(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 virtio_pci_types_register(&amp;virtio_gpu_rutabaga_pci_=
info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(virtio_gpu_rutabaga_pci_register_types)<br>
&gt; +<br>
&gt; +module_dep(&quot;hw-display-virtio-gpu-pci&quot;);<br>
&gt; diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-=
rutabaga.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..3f9f106abc<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/display/virtio-gpu-rutabaga.c<br>
&gt; @@ -0,0 +1,1114 @@<br>
&gt; +// SPDX-License-Identifier: GPL-2.0<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;qemu/error-report.h&quot;<br>
&gt; +#include &quot;qemu/iov.h&quot;<br>
&gt; +#include &quot;trace.h&quot;<br>
&gt; +#include &quot;hw/virtio/virtio.h&quot;<br>
&gt; +#include &quot;hw/virtio/virtio-gpu.h&quot;<br>
&gt; +#include &quot;hw/virtio/virtio-gpu-pixman.h&quot;<br>
&gt; +#include &quot;hw/virtio/virtio-iommu.h&quot;<br>
&gt; +<br>
&gt; +#include &lt;glib/gmem.h&gt;<br>
&gt; +#include &lt;rutabaga_gfx/rutabaga_gfx_ffi.h&gt;<br>
&gt; +<br>
&gt; +#define CHECK(condition, cmd)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 do {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(condition)) {=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;CHECK fa=
iled in %s() %s:&quot; &quot;%d&quot;, __func__,=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0__FILE__, __LINE__);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (cmd)-&gt;error =3D VIRTIO_=
GPU_RESP_ERR_UNSPEC;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 } while (0)<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * This is the size of the char array in struct sock_addr_un. No Wayl=
and socket<br>
&gt; + * can be created with a path longer than this, including the null te=
rminator.<br>
&gt; + */<br>
&gt; +#ifndef UNIX_PATH_MAX<br>
<br>
You shouldn&#39;t need this ifndef.<br>
<br>
&gt; +#define UNIX_PATH_MAX sizeof((struct sockaddr_un) {} .sun_path)<br>
&gt; +#endif<br>
&gt; +<br>
&gt; +struct rutabaga_aio_data {<br>
&gt; +=C2=A0 =C2=A0 struct VirtIOGPURutabaga *vr;<br>
&gt; +=C2=A0 =C2=A0 struct rutabaga_fence fence;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void<br>
&gt; +virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, struct virtio_gpu_sca=
nout *s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t resource_id)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *res;<br>
&gt; +=C2=A0 =C2=A0 struct rutabaga_transfer transfer =3D { 0 };<br>
&gt; +=C2=A0 =C2=A0 struct iovec transfer_iovec;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g, resource_id);<br>
&gt; +=C2=A0 =C2=A0 if (!res) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (res-&gt;width !=3D s-&gt;current_cursor-&gt;width |=
|<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res-&gt;height !=3D s-&gt;current_cursor-=
&gt;height) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 transfer.x =3D 0;<br>
&gt; +=C2=A0 =C2=A0 transfer.y =3D 0;<br>
&gt; +=C2=A0 =C2=A0 transfer.z =3D 0;<br>
&gt; +=C2=A0 =C2=A0 transfer.w =3D res-&gt;width;<br>
&gt; +=C2=A0 =C2=A0 transfer.h =3D res-&gt;height;<br>
&gt; +=C2=A0 =C2=A0 transfer.d =3D 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 transfer_iovec.iov_base =3D s-&gt;current_cursor-&gt;da=
ta;<br>
&gt; +=C2=A0 =C2=A0 transfer_iovec.iov_len =3D res-&gt;width * res-&gt;heig=
ht * 4;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 rutabaga_resource_transfer_read(vr-&gt;rutabaga, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_id, &amp;=
transfer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;transfer_iove=
c);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +virtio_gpu_rutabaga_gl_flushed(VirtIOGPUBase *b)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPU *g =3D VIRTIO_GPU(b);<br>
&gt; +=C2=A0 =C2=A0 virtio_gpu_process_cmdq(g);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +rutabaga_cmd_create_resource_2d(VirtIOGPU *g,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_ctrl_command *=
cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt; +=C2=A0 =C2=A0 struct rutabaga_create_3d rc_3d =3D { 0 };<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *res;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resource_create_2d c2d;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(c2d);<br>
&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_create_2d(c2d.resource_id, c2d=
.format,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c2d.w=
idth, c2d.height);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 rc_3d.target =3D 2;<br>
&gt; +=C2=A0 =C2=A0 rc_3d.format =3D c2d.format;<br>
&gt; +=C2=A0 =C2=A0 rc_3d.bind =3D (1 &lt;&lt; 1);<br>
&gt; +=C2=A0 =C2=A0 rc_3d.width =3D c2d.width;<br>
&gt; +=C2=A0 =C2=A0 rc_3d.height =3D c2d.height;<br>
&gt; +=C2=A0 =C2=A0 rc_3d.depth =3D 1;<br>
&gt; +=C2=A0 =C2=A0 rc_3d.array_size =3D 1;<br>
&gt; +=C2=A0 =C2=A0 rc_3d.last_level =3D 0;<br>
&gt; +=C2=A0 =C2=A0 rc_3d.nr_samples =3D 0;<br>
&gt; +=C2=A0 =C2=A0 rc_3d.flags =3D VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_create_3d(vr-&gt;rutabaga,=
 c2d.resource_id, &amp;rc_3d);<br>
&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 res =3D g_new0(struct virtio_gpu_simple_resource, 1);<b=
r>
&gt; +=C2=A0 =C2=A0 res-&gt;width =3D c2d.width;<br>
&gt; +=C2=A0 =C2=A0 res-&gt;height =3D c2d.height;<br>
&gt; +=C2=A0 =C2=A0 res-&gt;format =3D c2d.format;<br>
&gt; +=C2=A0 =C2=A0 res-&gt;resource_id =3D c2d.resource_id;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_INSERT_HEAD(&amp;g-&gt;reslist, res, next);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +rutabaga_cmd_create_resource_3d(VirtIOGPU *g,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_ctrl_command *=
cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt; +=C2=A0 =C2=A0 struct rutabaga_create_3d rc_3d =3D { 0 };<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *res;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resource_create_3d c3d;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(c3d);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_create_3d(c3d.resource_id, c3d=
.format,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c3d.w=
idth, c3d.height, c3d.depth);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 rc_3d.target =3D c3d.target;<br>
&gt; +=C2=A0 =C2=A0 rc_3d.format =3D c3d.format;<br>
&gt; +=C2=A0 =C2=A0 rc_3d.bind =3D c3d.bind;<br>
&gt; +=C2=A0 =C2=A0 rc_3d.width =3D c3d.width;<br>
&gt; +=C2=A0 =C2=A0 rc_3d.height =3D c3d.height;<br>
&gt; +=C2=A0 =C2=A0 rc_3d.depth =3D c3d.depth;<br>
&gt; +=C2=A0 =C2=A0 rc_3d.array_size =3D c3d.array_size;<br>
&gt; +=C2=A0 =C2=A0 rc_3d.last_level =3D c3d.last_level;<br>
&gt; +=C2=A0 =C2=A0 rc_3d.nr_samples =3D c3d.nr_samples;<br>
&gt; +=C2=A0 =C2=A0 rc_3d.flags =3D c3d.flags;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_create_3d(vr-&gt;rutabaga,=
 c3d.resource_id, &amp;rc_3d);<br>
&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 res =3D g_new0(struct virtio_gpu_simple_resource, 1);<b=
r>
&gt; +=C2=A0 =C2=A0 res-&gt;width =3D c3d.width;<br>
&gt; +=C2=A0 =C2=A0 res-&gt;height =3D c3d.height;<br>
&gt; +=C2=A0 =C2=A0 res-&gt;format =3D c3d.format;<br>
&gt; +=C2=A0 =C2=A0 res-&gt;resource_id =3D c3d.resource_id;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_INSERT_HEAD(&amp;g-&gt;reslist, res, next);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +rutabaga_cmd_resource_unref(VirtIOGPU *g,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_ctrl_command *cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *res;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resource_unref unref;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(unref);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_unref(unref.resource_id);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g, unref.resource_id);=
<br>
&gt; +=C2=A0 =C2=A0 CHECK(res, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_unref(vr-&gt;rutabaga, unr=
ef.resource_id);<br>
&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (res-&gt;image) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pixman_image_unref(res-&gt;image);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_REMOVE(&amp;g-&gt;reslist, res, next);<br>
&gt; +=C2=A0 =C2=A0 g_free(res);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +rutabaga_cmd_context_create(VirtIOGPU *g,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_ctrl_command *cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_ctx_create cc;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(cc);<br>
&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cc.debug_name);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_context_create(vr-&gt;rutabaga, cc.=
hdr.ctx_id,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc.context_i=
nit, cc.debug_name, cc.nlen);<br>
&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +rutabaga_cmd_context_destroy(VirtIOGPU *g,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_command *cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_ctx_destroy cd;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(cd);<br>
&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_ctx_destroy(cd.hdr.ctx_id);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_context_destroy(vr-&gt;rutabaga, cd=
.hdr.ctx_id);<br>
&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +rutabaga_cmd_resource_flush(VirtIOGPU *g, struct virtio_gpu_ctrl_comm=
and *cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int32_t result, i;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_scanout *scanout =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *res;<br>
&gt; +=C2=A0 =C2=A0 struct rutabaga_transfer transfer =3D { 0 };<br>
&gt; +=C2=A0 =C2=A0 struct iovec transfer_iovec;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resource_flush rf;<br>
&gt; +=C2=A0 =C2=A0 bool found =3D false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +=C2=A0 =C2=A0 if (vr-&gt;headless) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(rf);<br>
&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_flush(rf.resource_id,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rf.r.width, rf.r.he=
ight, rf.r.x, rf.r.y);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g, rf.resource_id);<br=
>
&gt; +=C2=A0 =C2=A0 CHECK(res, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; g-&gt;parent_obj.conf.max_outputs;=
 i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 scanout =3D &amp;g-&gt;parent_obj.scanout=
[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D res-&gt;scanout_bitmask) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 found =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!found) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 transfer.x =3D 0;<br>
&gt; +=C2=A0 =C2=A0 transfer.y =3D 0;<br>
&gt; +=C2=A0 =C2=A0 transfer.z =3D 0;<br>
&gt; +=C2=A0 =C2=A0 transfer.w =3D res-&gt;width;<br>
&gt; +=C2=A0 =C2=A0 transfer.h =3D res-&gt;height;<br>
&gt; +=C2=A0 =C2=A0 transfer.d =3D 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 transfer_iovec.iov_base =3D pixman_image_get_data(res-&=
gt;image);<br>
&gt; +=C2=A0 =C2=A0 transfer_iovec.iov_len =3D res-&gt;width * res-&gt;heig=
ht * 4;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_transfer_read(vr-&gt;rutab=
aga, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0rf.resource_id, &amp;transfer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&amp;transfer_iovec);<br>
&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +=C2=A0 =C2=A0 dpy_gfx_update_full(scanout-&gt;con);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command=
 *cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *res;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_scanout *scanout =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_set_scanout ss;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +=C2=A0 =C2=A0 if (vr-&gt;headless) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(ss);<br>
&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.reso=
urce_id,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ss.r.width, =
ss.r.height, ss.r.x, ss.r.y);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 CHECK(ss.scanout_id &lt; VIRTIO_GPU_MAX_SCANOUTS, cmd);=
<br>
&gt; +=C2=A0 =C2=A0 scanout =3D &amp;g-&gt;parent_obj.scanout[ss.scanout_id=
];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (ss.resource_id =3D=3D 0) {<br>
<br>
You should disable scanout as virtio-gpu-virgl does.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g, ss.resource_id);<br=
>
&gt; +=C2=A0 =C2=A0 CHECK(res, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!res-&gt;image) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pixman_format_code_t pformat;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pformat =3D virtio_gpu_get_pixman_format(=
res-&gt;format);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHECK(pformat, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res-&gt;image =3D pixman_image_create_bit=
s(pformat,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 res-&gt;width,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 res-&gt;height,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 NULL, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHECK(res-&gt;image, cmd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pixman_image_ref(res-&gt;image);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g-&gt;parent_obj.enable =3D 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* realloc the surface ptr */<br>
&gt; +=C2=A0 =C2=A0 scanout-&gt;ds =3D qemu_create_displaysurface_pixman(re=
s-&gt;image);<br>
&gt; +=C2=A0 =C2=A0 dpy_gfx_replace_surface(scanout-&gt;con, NULL);<br>
&gt; +=C2=A0 =C2=A0 dpy_gfx_replace_surface(scanout-&gt;con, scanout-&gt;ds=
);<br>
&gt; +=C2=A0 =C2=A0 res-&gt;scanout_bitmask =3D ss.scanout_id;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +rutabaga_cmd_submit_3d(VirtIOGPU *g,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0struct virtio_gpu_ctrl_command *cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_cmd_submit cs;<br>
&gt; +=C2=A0 =C2=A0 struct rutabaga_command rutabaga_cmd =3D { 0 };<br>
&gt; +=C2=A0 =C2=A0 g_autofree uint8_t *buf =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 size_t s;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(cs);<br>
&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size)=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 buf =3D g_new0(uint8_t, cs.size);<br>
&gt; +=C2=A0 =C2=A0 s =3D iov_to_buf(cmd-&gt;elem.out_sg, cmd-&gt;elem.out_=
num,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
sizeof(cs), buf, cs.size);<br>
&gt; +=C2=A0 =C2=A0 CHECK(s =3D=3D cs.size, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 rutabaga_cmd.ctx_id =3D cs.hdr.ctx_id;<br>
&gt; +=C2=A0 =C2=A0 rutabaga_cmd.cmd =3D buf;<br>
&gt; +=C2=A0 =C2=A0 rutabaga_cmd.cmd_size =3D cs.size;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_submit_command(vr-&gt;rutabaga, &am=
p;rutabaga_cmd);<br>
&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +rutabaga_cmd_transfer_to_host_2d(VirtIOGPU *g,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_com=
mand *cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt; +=C2=A0 =C2=A0 struct rutabaga_transfer transfer =3D { 0 };<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_transfer_to_host_2d t2d;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(t2d);<br>
&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_xfer_toh_2d(t2d.resource_id);<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 transfer.x =3D t2d.r.x;<br>
&gt; +=C2=A0 =C2=A0 transfer.y =3D t2d.r.y;<br>
&gt; +=C2=A0 =C2=A0 transfer.z =3D 0;<br>
&gt; +=C2=A0 =C2=A0 transfer.w =3D t2d.r.width;<br>
&gt; +=C2=A0 =C2=A0 transfer.h =3D t2d.r.height;<br>
&gt; +=C2=A0 =C2=A0 transfer.d =3D 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_transfer_write(vr-&gt;ruta=
baga, 0, t2d.resource_id,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &amp;transfer);<br>
&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +rutabaga_cmd_transfer_to_host_3d(VirtIOGPU *g,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_com=
mand *cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt; +=C2=A0 =C2=A0 struct rutabaga_transfer transfer =3D { 0 };<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_transfer_host_3d t3d;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(t3d);<br>
&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_xfer_toh_3d(t3d.resource_id);<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 transfer.x =3D t3d.box.x;<br>
&gt; +=C2=A0 =C2=A0 transfer.y =3D t3d.box.y;<br>
&gt; +=C2=A0 =C2=A0 transfer.z =3D t3d.box.z;<br>
&gt; +=C2=A0 =C2=A0 transfer.w =3D t3d.box.w;<br>
&gt; +=C2=A0 =C2=A0 transfer.h =3D t3d.box.h;<br>
&gt; +=C2=A0 =C2=A0 transfer.d =3D t3d.box.d;<br>
&gt; +=C2=A0 =C2=A0 transfer.level =3D t3d.level;<br>
&gt; +=C2=A0 =C2=A0 transfer.stride =3D t3d.stride;<br>
&gt; +=C2=A0 =C2=A0 transfer.layer_stride =3D t3d.layer_stride;<br>
&gt; +=C2=A0 =C2=A0 transfer.offset =3D t3d.offset;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_transfer_write(vr-&gt;ruta=
baga, t3d.hdr.ctx_id,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 t3d.resource_id, &amp;transfer);<br>
&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +rutabaga_cmd_transfer_from_host_3d(VirtIOGPU *g,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_c=
trl_command *cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt; +=C2=A0 =C2=A0 struct rutabaga_transfer transfer =3D { 0 };<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_transfer_host_3d t3d;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(t3d);<br>
&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_xfer_fromh_3d(t3d.resource_id)=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 transfer.x =3D t3d.box.x;<br>
&gt; +=C2=A0 =C2=A0 transfer.y =3D t3d.box.y;<br>
&gt; +=C2=A0 =C2=A0 transfer.z =3D t3d.box.z;<br>
&gt; +=C2=A0 =C2=A0 transfer.w =3D t3d.box.w;<br>
&gt; +=C2=A0 =C2=A0 transfer.h =3D t3d.box.h;<br>
&gt; +=C2=A0 =C2=A0 transfer.d =3D t3d.box.d;<br>
&gt; +=C2=A0 =C2=A0 transfer.level =3D t3d.level;<br>
&gt; +=C2=A0 =C2=A0 transfer.stride =3D t3d.stride;<br>
&gt; +=C2=A0 =C2=A0 transfer.layer_stride =3D t3d.layer_stride;<br>
&gt; +=C2=A0 =C2=A0 transfer.offset =3D t3d.offset;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_transfer_read(vr-&gt;rutab=
aga, t3d.hdr.ctx_id,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0t3d.resource_id, &amp;transfer, NULL);<br>
&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +rutabaga_cmd_attach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_comm=
and *cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct rutabaga_iovecs vecs =3D { 0 };<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *res;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resource_attach_backing att_rb;<br>
&gt; +=C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(att_rb);<br>
&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_back_attach(att_rb.resource_id=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g, att_rb.resource_id)=
;<br>
&gt; +=C2=A0 =C2=A0 CHECK(res, cmd);<br>
&gt; +=C2=A0 =C2=A0 CHECK(!res-&gt;iov, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D virtio_gpu_create_mapping_iov(g, att_rb.nr_entr=
ies, sizeof(att_rb),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd,=
 NULL, &amp;res-&gt;iov, &amp;res-&gt;iov_cnt);<br>
&gt; +=C2=A0 =C2=A0 CHECK(!ret, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vecs.iovecs =3D res-&gt;iov;<br>
&gt; +=C2=A0 =C2=A0 vecs.num_iovecs =3D res-&gt;iov_cnt;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D rutabaga_resource_attach_backing(vr-&gt;rutabag=
a, att_rb.resource_id,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&amp;vecs);<br>
&gt; +=C2=A0 =C2=A0 if (ret !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_cleanup_mapping(g, res);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 CHECK(!ret, cmd);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +rutabaga_cmd_detach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_comm=
and *cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *res;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resource_detach_backing detach_rb;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(detach_rb);<br>
&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_back_detach(detach_rb.resource=
_id);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g, detach_rb.resource_=
id);<br>
&gt; +=C2=A0 =C2=A0 CHECK(res, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 rutabaga_resource_detach_backing(vr-&gt;rutabaga,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0detach_rb.re=
source_id);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 virtio_gpu_cleanup_mapping(g, res);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +rutabaga_cmd_ctx_attach_resource(VirtIOGPU *g,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_com=
mand *cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_ctx_resource att_res;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(att_res);<br>
&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_ctx_res_attach(att_res.hdr.ctx_id,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 att_=
res.resource_id);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_context_attach_resource(vr-&gt;ruta=
baga, att_res.hdr.ctx_id,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 att_res.resource_id);<br>
&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +rutabaga_cmd_ctx_detach_resource(VirtIOGPU *g,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_com=
mand *cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_ctx_resource det_res;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(det_res);<br>
&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_ctx_res_detach(det_res.hdr.ctx_id,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 det_=
res.resource_id);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_context_detach_resource(vr-&gt;ruta=
baga, det_res.hdr.ctx_id,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 det_res.resource_id);<br>
&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct virtio_gpu_ctrl_com=
mand *cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_get_capset_info info;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resp_capset_info resp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(info);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_get_capset_info(vr-&gt;rutabaga, in=
fo.capset_index,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;resp.c=
apset_id, &amp;resp.capset_max_version,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;resp.c=
apset_max_size);<br>
&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 resp.hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET_INFO;<br>
&gt; +=C2=A0 =C2=A0 virtio_gpu_ctrl_response(g, cmd, &amp;resp.hdr, sizeof(=
resp));<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +rutabaga_cmd_get_capset(VirtIOGPU *g, struct virtio_gpu_ctrl_command =
*cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_get_capset gc;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resp_capset *resp;<br>
&gt; +=C2=A0 =C2=A0 uint32_t capset_size;<br>
&gt; +=C2=A0 =C2=A0 uint32_t current_id;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(gc);<br>
&gt; +=C2=A0 =C2=A0 for (uint32_t i =3D 0; i &lt; vr-&gt;num_capsets; i++) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHECK(i &lt; vr-&gt;num_capsets, cmd);<br=
>
<br>
This CHECK will not work since you have i &lt; vr-&gt;num_capsets as the lo=
op <br>
condition.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D rutabaga_get_capset_info(vr-&g=
t;rutabaga, i,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;current_id, &amp;capset_size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;capset_size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (current_id =3D=3D gc.capset_id) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 resp =3D g_malloc0(sizeof(*resp) + capset_size);<br>
&gt; +=C2=A0 =C2=A0 resp-&gt;hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET;<br>
&gt; +=C2=A0 =C2=A0 rutabaga_get_capset(vr-&gt;rutabaga, gc.capset_id, gc.c=
apset_version,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 resp-&gt;capset_data, capset_size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 virtio_gpu_ctrl_response(g, cmd, &amp;resp-&gt;hdr, siz=
eof(*resp) + capset_size);<br>
&gt; +=C2=A0 =C2=A0 g_free(resp);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +rutabaga_cmd_resource_create_blob(VirtIOGPU *g,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_ctrl_co=
mmand *cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int result;<br>
&gt; +=C2=A0 =C2=A0 struct rutabaga_iovecs vecs =3D { 0 };<br>
&gt; +=C2=A0 =C2=A0 g_autofree struct virtio_gpu_simple_resource *res =3D N=
ULL;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resource_create_blob cblob;<br>
&gt; +=C2=A0 =C2=A0 struct rutabaga_create_blob rc_blob =3D { 0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(cblob);<br>
&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_create_blob(cblob.resource_id,=
 cblob.size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 CHECK(cblob.resource_id !=3D 0, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 res =3D g_new0(struct virtio_gpu_simple_resource, 1);<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 res-&gt;resource_id =3D cblob.resource_id;<br>
&gt; +=C2=A0 =C2=A0 res-&gt;blob_size =3D cblob.size;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (cblob.blob_mem !=3D VIRTIO_GPU_BLOB_MEM_HOST3D) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D virtio_gpu_create_mapping_iov(=
g, cblob.nr_entries,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0sizeof(cblob), cmd, &amp;res-&gt;addrs,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;res-&gt;iov, &amp;res-&gt;iov_cnt);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 rc_blob.blob_id =3D cblob.blob_id;<br>
&gt; +=C2=A0 =C2=A0 rc_blob.blob_mem =3D cblob.blob_mem;<br>
&gt; +=C2=A0 =C2=A0 rc_blob.blob_flags =3D cblob.blob_flags;<br>
&gt; +=C2=A0 =C2=A0 rc_blob.size =3D cblob.size;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vecs.iovecs =3D res-&gt;iov;<br>
&gt; +=C2=A0 =C2=A0 vecs.num_iovecs =3D res-&gt;iov_cnt;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_create_blob(vr-&gt;rutabag=
a, cblob.hdr.ctx_id,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cblob.resource_id, &amp;rc_blob, &amp;vecs,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0NULL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (result &amp;&amp; cblob.blob_mem !=3D VIRTIO_GPU_BL=
OB_MEM_HOST3D) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_cleanup_mapping(g, res);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_INSERT_HEAD(&amp;g-&gt;reslist, res, next);<br>
&gt; +=C2=A0 =C2=A0 res =3D NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +rutabaga_cmd_resource_map_blob(VirtIOGPU *g,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_command *c=
md)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt; +=C2=A0 =C2=A0 uint32_t map_info =3D 0;<br>
&gt; +=C2=A0 =C2=A0 uint32_t slot =3D 0;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *res;<br>
&gt; +=C2=A0 =C2=A0 struct rutabaga_mapping mapping =3D { 0 };<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resource_map_blob mblob;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resp_map_info resp =3D { 0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(mblob);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 CHECK(mblob.resource_id !=3D 0, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g, mblob.resource_id);=
<br>
&gt; +=C2=A0 =C2=A0 CHECK(res, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_map_info(vr-&gt;rutabaga, =
mblob.resource_id,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp=
;map_info);<br>
&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* RUTABAGA_MAP_ACCESS_* flags are not part of the=
 virtio-gpu spec, but do<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* exist to potentially allow the hypervisor to re=
strict write access to<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* memory. QEMU does not need to use this function=
ality at the moment.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 resp.map_info =3D map_info &amp; RUTABAGA_MAP_CACHE_MAS=
K;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_map(vr-&gt;rutabaga, mblob=
.resource_id, &amp;mapping);<br>
&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (slot =3D 0; slot &lt; MAX_SLOTS; slot++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vr-&gt;memory_regions[slot].used) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MemoryRegion *mr =3D &amp;(vr-&gt;memory_=
regions[slot].mr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_init_ram_ptr(mr, NULL, &quo=
t;blob&quot;, mapping.size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mapping.ptr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(&amp;g-&gt;pa=
rent_obj.hostmem,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mblob.offset, mr);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vr-&gt;memory_regions[slot].resource_id =
=3D mblob.resource_id;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vr-&gt;memory_regions[slot].used =3D 1;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (slot &gt;=3D MAX_SLOTS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D rutabaga_resource_unmap(vr-&gt=
;rutabaga, mblob.resource_id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 CHECK(slot &lt; MAX_SLOTS, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 resp.hdr.type =3D VIRTIO_GPU_RESP_OK_MAP_INFO;<br>
&gt; +=C2=A0 =C2=A0 virtio_gpu_ctrl_response(g, cmd, &amp;resp.hdr, sizeof(=
resp));<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +rutabaga_cmd_resource_unmap_blob(VirtIOGPU *g,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_com=
mand *cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt; +=C2=A0 =C2=A0 uint32_t slot =3D 0;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *res;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_resource_unmap_blob ublob;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(ublob);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 CHECK(ublob.resource_id !=3D 0, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g, ublob.resource_id);=
<br>
&gt; +=C2=A0 =C2=A0 CHECK(res, cmd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (slot =3D 0; slot &lt; MAX_SLOTS; slot++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vr-&gt;memory_regions[slot].resource_=
id !=3D ublob.resource_id) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MemoryRegion *mr =3D &amp;(vr-&gt;memory_=
regions[slot].mr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_del_subregion(&amp;g-&gt;pa=
rent_obj.hostmem, mr);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vr-&gt;memory_regions[slot].resource_id =
=3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vr-&gt;memory_regions[slot].used =3D 0;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 CHECK(slot &lt; MAX_SLOTS, cmd);<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_resource_unmap(vr-&gt;rutabaga, res=
-&gt;resource_id);<br>
&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +virtio_gpu_rutabaga_process_cmd(VirtIOGPU *g,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_ctrl_command *=
cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct rutabaga_fence fence =3D { 0 };<br>
&gt; +=C2=A0 =C2=A0 int32_t result;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(cmd-&gt;cmd_hdr);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (cmd-&gt;cmd_hdr.type) {<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_CTX_CREATE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_context_create(g, cmd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_CTX_DESTROY:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_context_destroy(g, cmd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_CREATE_2D:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_create_resource_2d(g, cmd);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_CREATE_3D:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_create_resource_3d(g, cmd);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_SUBMIT_3D:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_submit_3d(g, cmd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_transfer_to_host_2d(g, cmd);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_transfer_to_host_3d(g, cmd);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_transfer_from_host_3d(g, cmd=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_attach_backing(g, cmd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_detach_backing(g, cmd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_SET_SCANOUT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_set_scanout(g, cmd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_FLUSH:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_resource_flush(g, cmd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_UNREF:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_resource_unref(g, cmd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_ctx_attach_resource(g, cmd);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_ctx_detach_resource(g, cmd);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_GET_CAPSET_INFO:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_get_capset_info(g, cmd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_GET_CAPSET:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_get_capset(g, cmd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_get_display_info(g, cmd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_GET_EDID:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_get_edid(g, cmd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_resource_create_blob(g, cmd)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_resource_map_blob(g, cmd);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_resource_unmap_blob(g, cmd);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;error =3D VIRTIO_GPU_RESP_ERR_UNS=
PEC;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (cmd-&gt;finished) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (cmd-&gt;error) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: ctrl 0x%x, error 0=
x%x&quot;, __func__,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cmd-&gt;cmd_hdr.type, cmd-&gt;error);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_ctrl_response_nodata(g, cmd, c=
md-&gt;error);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (!(cmd-&gt;cmd_hdr.flags &amp; VIRTIO_GPU_FLAG_FENCE=
)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_ctrl_response_nodata(g, cmd, V=
IRTIO_GPU_RESP_OK_NODATA);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 fence.flags =3D cmd-&gt;cmd_hdr.flags;<br>
&gt; +=C2=A0 =C2=A0 fence.ctx_id =3D cmd-&gt;cmd_hdr.ctx_id;<br>
&gt; +=C2=A0 =C2=A0 fence.fence_id =3D cmd-&gt;cmd_hdr.fence_id;<br>
&gt; +=C2=A0 =C2=A0 fence.ring_idx =3D cmd-&gt;cmd_hdr.ring_idx;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_virtio_gpu_fence_ctrl(cmd-&gt;cmd_hdr.fence_id, c=
md-&gt;cmd_hdr.type);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_create_fence(vr-&gt;rutabaga, &amp;=
fence);<br>
&gt; +=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +virtio_gpu_rutabaga_aio_cb(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct rutabaga_aio_data *data =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPU *g =3D VIRTIO_GPU(data-&gt;vr);<br>
&gt; +=C2=A0 =C2=A0 struct rutabaga_fence fence_data =3D data-&gt;fence;<br=
>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_ctrl_command *cmd, *tmp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t signaled_ctx_specific =3D fence_data.flags &am=
p;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RUTABAGA_FLA=
G_INFO_RING_IDX;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_FOREACH_SAFE(cmd, &amp;g-&gt;fenceq, next, tmp) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Due to context specific timelines=
.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t target_ctx_specific =3D cmd-&gt;=
cmd_hdr.flags &amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RUTAB=
AGA_FLAG_INFO_RING_IDX;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (signaled_ctx_specific !=3D target_ctx=
_specific) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (signaled_ctx_specific &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(cmd-&gt;cmd_hdr.ring_idx !=
=3D fence_data.ring_idx)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cmd-&gt;cmd_hdr.fence_id &gt; fence_d=
ata.fence_id) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_virtio_gpu_fence_resp(cmd-&gt;cmd_h=
dr.fence_id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_ctrl_response_nodata(g, cmd, V=
IRTIO_GPU_RESP_OK_NODATA);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 QTAILQ_REMOVE(&amp;g-&gt;fenceq, cmd, nex=
t);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(cmd);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_free(data);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +virtio_gpu_rutabaga_fence_cb(uint64_t user_data,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct rutabaga_fence *fence) {<br=
>
&gt; +=C2=A0 =C2=A0 struct rutabaga_aio_data *data;<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPU *g =3D (VirtIOGPU *)user_data;<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* gfxstream and both cross-domain (and even newer=
 versions virglrenderer:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* see VIRGL_RENDERER_ASYNC_FENCE_CB) like to sign=
al fence completion on<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* threads (&quot;callback threads&quot;) that are=
 different from the thread that<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* processes the command queue (&quot;main thread&=
quot;).<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* crosvm and other virtio-gpu 1.1 implementations=
 enable callback threads<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* via locking.=C2=A0 However, on QEMU a deadlock =
is observed if<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* virtio_gpu_ctrl_response_nodata(..) [used in th=
e fence callback] is used<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* from a thread that is not the main thread.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* The reason is QEMU&#39;s internal locking is de=
signed to work with QEMU<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* threads (see rcu_register_thread()) and not gen=
eric C/C++/Rust threads.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* For now, we can workaround this by scheduling t=
he return of the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* fence descriptors on the main thread.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 data =3D g_new0(struct rutabaga_aio_data, 1);<br>
&gt; +=C2=A0 =C2=A0 data-&gt;vr =3D vr;<br>
&gt; +=C2=A0 =C2=A0 data-&gt;fence =3D *fence;<br>
&gt; +=C2=A0 =C2=A0 aio_bh_schedule_oneshot_full(qemu_get_aio_context(),<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpu_rutabaga_aio_cb=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data, &quot;aio&quot;);<br=
>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +virtio_gpu_rutabaga_debug_cb(uint64_t user_data,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct rutabaga_debug *debug) {<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (debug-&gt;debug_type =3D=3D RUTABAGA_DEBUG_ERROR) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s&quot;, debug-&gt;me=
ssage);<br>
&gt; +=C2=A0 =C2=A0 } else if (debug-&gt;debug_type =3D=3D RUTABAGA_DEBUG_W=
ARN) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report(&quot;%s&quot;, debug-&gt;mes=
sage);<br>
&gt; +=C2=A0 =C2=A0 } else if (debug-&gt;debug_type =3D=3D RUTABAGA_DEBUG_I=
NFO) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 info_report(&quot;%s&quot;, debug-&gt;mes=
sage);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int virtio_gpu_rutabaga_init(VirtIOGPU *g, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int result;<br>
&gt; +=C2=A0 =C2=A0 uint64_t capset_mask;<br>
&gt; +=C2=A0 =C2=A0 struct rutabaga_builder builder =3D { 0 };<br>
&gt; +=C2=A0 =C2=A0 char wayland_socket_path[UNIX_PATH_MAX];<br>
&gt; +=C2=A0 =C2=A0 struct rutabaga_channel channel =3D { 0 };<br>
&gt; +=C2=A0 =C2=A0 struct rutabaga_channels channels =3D { 0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +=C2=A0 =C2=A0 vr-&gt;rutabaga =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!vr-&gt;capset_names) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;a capset name from=
 the virtio-gpu spec is required&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 builder.wsi =3D RUTABAGA_WSI_SURFACELESS;<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Currently, if WSI is specified, the only valid =
strings are &quot;surfaceless&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* or &quot;headless&quot;.=C2=A0 Surfaceless does=
n&#39;t create a native window surface, but<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* does copy from the render target to the Pixman =
buffer if a virtio-gpu<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* 2D hypercall is issued.=C2=A0 Surfacless is the=
 default.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Headless is like surfaceless, but doesn&#39;t c=
opy to the Pixman buffer. The<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* use case is automated testing environments wher=
e there is no need to view<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* results.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* In the future, more performant virtio-gpu 2D UI=
 integration may be added.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (vr-&gt;wsi) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_str_equal(vr-&gt;wsi, &quot;surface=
less&quot;)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vr-&gt;headless =3D false;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (g_str_equal(vr-&gt;wsi, &quot;=
headless&quot;)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vr-&gt;headless =3D true;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;inva=
lid wsi option selected&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_calculate_capset_mask(vr-&gt;capset=
_names, &amp;capset_mask);<br>
&gt; +=C2=A0 =C2=A0 if (result) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;invalid capset nam=
es: %s&quot;, vr-&gt;capset_names);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return result;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 builder.fence_cb =3D virtio_gpu_rutabaga_fence_cb;<br>
&gt; +=C2=A0 =C2=A0 builder.debug_cb =3D virtio_gpu_rutabaga_debug_cb;<br>
&gt; +=C2=A0 =C2=A0 builder.capset_mask =3D capset_mask;<br>
&gt; +=C2=A0 =C2=A0 builder.user_data =3D (uint64_t)g;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* If the user doesn&#39;t specify the wayland soc=
ket path, we try to infer<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* the socket via a process similar to the one use=
d by libwayland.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* libwayland does the following:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* 1) If $WAYLAND_DISPLAY is set, attempt to conne=
ct to<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0 $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0* 2) Otherwise, attempt to connect to $XDG_RUNTIM=
E_DIR/wayland-0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* 3) Otherwise, don&#39;t pass a wayland socket t=
o rutabaga. If a guest<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0 wayland proxy is launched, it will=
 fail to work.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 channel.channel_type =3D RUTABAGA_CHANNEL_TYPE_WAYLAND;=
<br>
&gt; +=C2=A0 =C2=A0 if (!vr-&gt;wayland_socket_path) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *runtime_dir =3D getenv(&quot;=
XDG_RUNTIME_DIR&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *display =3D getenv(&quot;WAYL=
AND_DISPLAY&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!display) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 display =3D &quot;wayland-0=
&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (runtime_dir) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D snprintf(wayland=
_socket_path, UNIX_PATH_MAX,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%s/%s&quot;, runtime_dir, display=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (result &gt; 0 &amp;&amp=
; result &lt; UNIX_PATH_MAX) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 channel.chann=
el_name =3D wayland_socket_path;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
As I said in the last email, I think it&#39;s better to make a hard error i=
f <br>
the user requested RUTABAGA_CAPSET_CROSS_DOMAIN but the default socket <br>
path does not fit in wayland_socket_path.<br></blockquote><div><br></div><d=
iv>I mentioned this in the cover-letter to v5, but messed up the commit mes=
sage of patch 6.=C2=A0 But we do want to be possible to use cross_domain wi=
thout wayland for following reason:</div><div><br></div><div>&quot;It is po=
ssible to use cross-domain without enabling Wayland, for guest<br>swapchain=
 allocation [a] which often needs special handling.=C2=A0 We might<br>We wa=
nt to use this capability on MacOS/Windows in the future without<br>Wayland=
, hence we shouldn&#39;t have hard errors if the default wayland socket<br>=
isn&#39;t found.<br></div><div><br></div><div>[a]=C2=A0<a href=3D"https://a=
ndroid.googlesource.com/platform/external/minigbm/+/refs/heads/main/virtgpu=
_cross_domain.c" rel=3D"noreferrer" target=3D"_blank">https://android.googl=
esource.com/platform/external/minigbm/+/refs/heads/main/virtgpu_cross_domai=
n.c</a>&quot;<br></div><div><br></div><div>I&#39;ll incorporate your other =
suggestions in v6 though.</div><div><br></div><div><br></div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 channel.channel_name =3D vr-&gt;wayland_s=
ocket_path;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if ((builder.capset_mask &amp; (1 &lt;&lt; RUTABAGA_CAP=
SET_CROSS_DOMAIN))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (channel.channel_name) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 channels.channels =3D &amp;=
channel;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 channels.num_channels =3D 1=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 builder.channels =3D &amp;c=
hannels;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_init(&amp;builder, &amp;vr-&gt;ruta=
baga);<br>
&gt; +=C2=A0 =C2=A0 return result;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int virtio_gpu_rutabaga_get_num_capsets(VirtIOGPU *g)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int result;<br>
&gt; +=C2=A0 =C2=A0 uint32_t num_capsets;<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D rutabaga_get_num_capsets(vr-&gt;rutabaga, &a=
mp;num_capsets);<br>
&gt; +=C2=A0 =C2=A0 if (result) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to get capsets&=
quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 vr-&gt;num_capsets =3D num_capsets;<br>
&gt; +=C2=A0 =C2=A0 return num_capsets;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void virtio_gpu_rutabaga_handle_ctrl(VirtIODevice *vdev, VirtQ=
ueue *vq)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPU *g =3D VIRTIO_GPU(vdev);<br>
&gt; +=C2=A0 =C2=A0 struct virtio_gpu_ctrl_command *cmd;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!virtio_queue_ready(vq)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl=
_command));<br>
&gt; +=C2=A0 =C2=A0 while (cmd) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;vq =3D vq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;error =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;finished =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 QTAILQ_INSERT_TAIL(&amp;g-&gt;cmdq, cmd, =
next);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D virtqueue_pop(vq, sizeof(struct v=
irtio_gpu_ctrl_command));<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 virtio_gpu_process_cmdq(g);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **er=
rp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int num_capsets;<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPUBase *bdev =3D VIRTIO_GPU_BASE(qdev);<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPU *gpudev =3D VIRTIO_GPU(qdev);<br>
&gt; +<br>
&gt; +#if HOST_BIG_ENDIAN<br>
&gt; +=C2=A0 =C2=A0 error_setg(errp, &quot;rutabaga is not supported on big=
endian platforms&quot;);<br>
&gt; +=C2=A0 =C2=A0 return;<br>
&gt; +#endif<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 int result =3D virtio_gpu_rutabaga_init(gpudev, errp);<=
br>
&gt; +=C2=A0 =C2=A0 if (result) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;virtio_gpu_rutabag=
a_init failed&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 num_capsets =3D virtio_gpu_rutabaga_get_num_capsets(gpu=
dev);<br>
&gt; +=C2=A0 =C2=A0 if (!num_capsets) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 bdev-&gt;conf.flags |=3D (1 &lt;&lt; VIRTIO_GPU_FLAG_RU=
TABAGA_ENABLED);<br>
&gt; +=C2=A0 =C2=A0 bdev-&gt;conf.flags |=3D (1 &lt;&lt; VIRTIO_GPU_FLAG_BL=
OB_ENABLED);<br>
&gt; +=C2=A0 =C2=A0 bdev-&gt;conf.flags |=3D (1 &lt;&lt; VIRTIO_GPU_FLAG_CO=
NTEXT_INIT_ENABLED);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 bdev-&gt;virtio_config.num_capsets =3D num_capsets;<br>
&gt; +=C2=A0 =C2=A0 virtio_gpu_device_realize(qdev, errp);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static Property virtio_gpu_rutabaga_properties[] =3D {<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;capset_names&quot;, VirtIOGPUR=
utabaga, capset_names),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;wayland_socket_path&quot;, Vir=
tIOGPURutabaga,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0wayland_socket_path),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;wsi&quot;, VirtIOGPURutabaga, =
wsi),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void virtio_gpu_rutabaga_class_init(ObjectClass *klass, void *=
data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +=C2=A0 =C2=A0 VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);<=
br>
&gt; +=C2=A0 =C2=A0 VirtIOGPUBaseClass *vbc =3D VIRTIO_GPU_BASE_CLASS(klass=
);<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPUClass *vgc =3D VIRTIO_GPU_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vbc-&gt;gl_flushed =3D virtio_gpu_rutabaga_gl_flushed;<=
br>
&gt; +=C2=A0 =C2=A0 vgc-&gt;handle_ctrl =3D virtio_gpu_rutabaga_handle_ctrl=
;<br>
&gt; +=C2=A0 =C2=A0 vgc-&gt;process_cmd =3D virtio_gpu_rutabaga_process_cmd=
;<br>
&gt; +=C2=A0 =C2=A0 vgc-&gt;update_cursor_data =3D virtio_gpu_rutabaga_upda=
te_cursor;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vdc-&gt;realize =3D virtio_gpu_rutabaga_realize;<br>
&gt; +=C2=A0 =C2=A0 device_class_set_props(dc, virtio_gpu_rutabaga_properti=
es);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo virtio_gpu_rutabaga_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D TYPE_VIRTIO_GPU_RUTABAGA,<br>
&gt; +=C2=A0 =C2=A0 .parent =3D TYPE_VIRTIO_GPU,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(VirtIOGPURutabaga),<br>
&gt; +=C2=A0 =C2=A0 .class_init =3D virtio_gpu_rutabaga_class_init,<br>
&gt; +};<br>
&gt; +module_obj(TYPE_VIRTIO_GPU_RUTABAGA);<br>
&gt; +module_kconfig(VIRTIO_GPU);<br>
&gt; +<br>
&gt; +static void virtio_register_types(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;virtio_gpu_rutabaga_info);<br=
>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(virtio_register_types)<br>
&gt; +<br>
&gt; +module_dep(&quot;hw-display-virtio-gpu&quot;);<br>
&gt; diff --git a/hw/display/virtio-vga-rutabaga.c b/hw/display/virtio-vga-=
rutabaga.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..2b2ffed8a6<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/display/virtio-vga-rutabaga.c<br>
&gt; @@ -0,0 +1,51 @@<br>
&gt; +// SPDX-License-Identifier: GPL-2.0<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;hw/pci/pci.h&quot;<br>
&gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt; +#include &quot;hw/virtio/virtio-gpu.h&quot;<br>
&gt; +#include &quot;hw/display/vga.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;virtio-vga.h&quot;<br>
&gt; +#include &quot;qom/object.h&quot;<br>
&gt; +<br>
&gt; +#define TYPE_VIRTIO_VGA_RUTABAGA &quot;virtio-vga-rutabaga&quot;<br>
&gt; +<br>
&gt; +typedef struct VirtIOVGARutabaga VirtIOVGARutabaga;<br>
&gt; +DECLARE_INSTANCE_CHECKER(VirtIOVGARutabaga, VIRTIO_VGA_RUTABAGA,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0TYPE_VIRTIO_VGA_RUTABAGA)<br>
&gt; +<br>
&gt; +struct VirtIOVGARutabaga {<br>
&gt; +=C2=A0 =C2=A0 VirtIOVGABase parent_obj;<br>
&gt; +=C2=A0 =C2=A0 VirtIOGPURutabaga vdev;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void virtio_vga_rutabaga_inst_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VirtIOVGARutabaga *dev =3D VIRTIO_VGA_RUTABAGA(obj);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 virtio_instance_init_common(obj, &amp;dev-&gt;vdev, siz=
eof(dev-&gt;vdev),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_VIRTIO_GPU_RUTABAGA);<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_VGA_BASE(dev)-&gt;vgpu =3D VIRTIO_GPU_BASE(&amp;=
dev-&gt;vdev);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static VirtioPCIDeviceTypeInfo virtio_vga_rutabaga_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .generic_name=C2=A0 =3D TYPE_VIRTIO_VGA_RUTABAGA,<br>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_VIRTIO_VGA_=
BASE,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(VirtIOVGARutabaga),<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D virtio_vga_rutabaga_inst_initfn,<br>
&gt; +};<br>
&gt; +module_obj(TYPE_VIRTIO_VGA_RUTABAGA);<br>
&gt; +module_kconfig(VIRTIO_VGA);<br>
&gt; +<br>
&gt; +static void virtio_vga_register_types(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (have_vga) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_pci_types_register(&amp;virtio_vga=
_rutabaga_info);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(virtio_vga_register_types)<br>
&gt; +<br>
&gt; +module_dep(&quot;hw-display-virtio-vga&quot;);<br>
</blockquote></div></div>

--0000000000006c50750602f82400--

