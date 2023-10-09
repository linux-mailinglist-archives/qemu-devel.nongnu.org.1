Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5BD7BD417
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 09:12:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpkQT-00068z-IG; Mon, 09 Oct 2023 03:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qpkQQ-00068P-1J
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qpkQL-0002FQ-Jo
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696835487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7DXho+kBZQiXDQpmCdDDSfSfDZ6YHHl4n4wZBhez4Ns=;
 b=L6/I09nHXdTgrEZnTKGXG1wLbd3aRa286c6IjCzNYq6QDqHTkQF4qN9bCtpKNhrfkkNQZM
 scelCd+Jdta3Z/45GVDkBZ9AtS/Et/WGwpluFajeThAJIQLtFX2N8MhLs9UDDJJyicNPLr
 nigZlEtE8WQ/ZCjvTtJtBEcPSniIdQM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-Gml0ZXsYOROA7xv1FA1tDw-1; Mon, 09 Oct 2023 03:11:24 -0400
X-MC-Unique: Gml0ZXsYOROA7xv1FA1tDw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-538c5748a50so3218605a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 00:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696835483; x=1697440283;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7DXho+kBZQiXDQpmCdDDSfSfDZ6YHHl4n4wZBhez4Ns=;
 b=c5xWRvy/Pq22bl7XE5qGccZaseR8dkW/2wPahkRmB3p0ZOl6lHzKy1s0+Z6H3SraWS
 qREtsQ2cFuNDSb6boGe2S/UC8mwSoQ+FVeDSnb7neOL1f9ODaE4SzCpEe15ZtCMfIQ4l
 pEQmiZEoEAgp0tlTh66KId4kw1XuS0SGa+xFaiynDsxDzxsm8jt1nSG0wvQw84j0i3h1
 mx8MtQH76cS55TgkAXntLoKfDVmt3O0gOYjCSW9ANEGkqsw2OkCAp2KFhIxfU/k5j6qg
 2sRNvpq3/GZx3XpFnhsmj4lzDMMiykYL08sbr7YJEhOtR9/ehPqaEP8xjj6b2DdUJlEX
 qkAA==
X-Gm-Message-State: AOJu0YyPWNro3lzZpv4ChDUDk6VqTCv4nNC3GHyL96u+fvVTvyAf1wR+
 j8l643TIxMBm4KwOtRIsruArkffAreaAqIJcCcznjHvuSgHPzGkovRYPY8npljWTd4L0vaE79Pw
 8plVXF4axGwIzM4xI2y7gal5SRIr/das=
X-Received: by 2002:aa7:c541:0:b0:534:2fd8:a9e1 with SMTP id
 s1-20020aa7c541000000b005342fd8a9e1mr12479493edr.22.1696835483367; 
 Mon, 09 Oct 2023 00:11:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcoOzNOrrHyB3WLyER4krGSob/ZsETYx10oIKIxwanYmIFasLFSp/mMnbl39FZJ3p99gqJiIJn/zkMgOBBRBY=
X-Received: by 2002:aa7:c541:0:b0:534:2fd8:a9e1 with SMTP id
 s1-20020aa7c541000000b005342fd8a9e1mr12479466edr.22.1696835482793; Mon, 09
 Oct 2023 00:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231006010835.444-1-gurchetansingh@chromium.org>
 <20231006010835.444-7-gurchetansingh@chromium.org>
In-Reply-To: <20231006010835.444-7-gurchetansingh@chromium.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 9 Oct 2023 11:11:10 +0400
Message-ID: <CAMxuvax+Sh_3+qXJd0AVQhzYLiFKLyDfKa=9ExCggMtS7_SEBw@mail.gmail.com>
Subject: Re: [PATCH v17 6/9] gfxstream + rutabaga: add initial support for
 gfxstream
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org, akihiko.odaki@gmail.com, ray.huang@amd.com, 
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is, ernunes@redhat.com, 
 manos.pitsidianakis@linaro.org, mark.cave-ayland@ilande.co.uk, 
 thuth@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 6, 2023 at 5:09=E2=80=AFAM Gurchetan Singh
<gurchetansingh@chromium.org> wrote:
>
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
>   - Very simple initial display integration: just used Pixman
>   - Largely, 1:1 mapping of virtio-gpu hypercalls to rutabaga function
>     calls
>
> Next steps for Android VMs:
>   - The next step would be improving display integration and UI interface=
s
>     with the goal of the QEMU upstream graphics being in an emulator
>     release [d].
>
> Next steps for Linux VMs for display virtualization:
>   - For widespread distribution, someone needs to package Sommelier or th=
e
>     wayland-proxy-virtwl [e] ideally into Debian main. In addition, newer
>     versions of the Linux kernel come with DRM_VIRTIO_GPU_KMS option,
>     which allows disabling KMS hypercalls.  If anyone cares enough, it'll
>     probably be possible to build a custom VM variant that uses this disp=
lay
>     virtualization strategy.
>
> [a] https://android-review.googlesource.com/c/platform/development/+/3447=
0
> [b] https://android-review.googlesource.com/q/topic:%22vulkan-hostconnect=
ion-start%22
> [c] https://android-review.googlesource.com/c/device/generic/goldfish-ope=
ngl/+/761927
> [d] https://developer.android.com/studio/releases/emulator
> [e] https://github.com/talex5/wayland-proxy-virtwl
>
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Tested-by: Alyssa Ross <hi@alyssa.is>
> Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/display/virtio-gpu-pci-rutabaga.c |   47 ++
>  hw/display/virtio-gpu-rutabaga.c     | 1113 ++++++++++++++++++++++++++
>  hw/display/virtio-vga-rutabaga.c     |   50 ++
>  3 files changed, 1210 insertions(+)
>  create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
>  create mode 100644 hw/display/virtio-gpu-rutabaga.c
>  create mode 100644 hw/display/virtio-vga-rutabaga.c
>
> diff --git a/hw/display/virtio-gpu-pci-rutabaga.c b/hw/display/virtio-gpu=
-pci-rutabaga.c
> new file mode 100644
> index 0000000000..c96729e198
> --- /dev/null
> +++ b/hw/display/virtio-gpu-pci-rutabaga.c
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "hw/pci/pci.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/virtio-bus.h"
> +#include "hw/virtio/virtio-gpu-pci.h"
> +#include "qom/object.h"
> +
> +#define TYPE_VIRTIO_GPU_RUTABAGA_PCI "virtio-gpu-rutabaga-pci"
> +OBJECT_DECLARE_SIMPLE_TYPE(VirtIOGPURutabagaPCI, VIRTIO_GPU_RUTABAGA_PCI=
)
> +
> +struct VirtIOGPURutabagaPCI {
> +    VirtIOGPUPCIBase parent_obj;
> +
> +    VirtIOGPURutabaga vdev;
> +};
> +
> +static void virtio_gpu_rutabaga_initfn(Object *obj)
> +{
> +    VirtIOGPURutabagaPCI *dev =3D VIRTIO_GPU_RUTABAGA_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_GPU_RUTABAGA);
> +    VIRTIO_GPU_PCI_BASE(obj)->vgpu =3D VIRTIO_GPU_BASE(&dev->vdev);
> +}
> +
> +static const TypeInfo virtio_gpu_rutabaga_pci_info[] =3D {
> +    {
> +        .name =3D TYPE_VIRTIO_GPU_RUTABAGA_PCI,
> +        .parent =3D TYPE_VIRTIO_GPU_PCI_BASE,
> +        .instance_size =3D sizeof(VirtIOGPURutabagaPCI),
> +        .instance_init =3D virtio_gpu_rutabaga_initfn,
> +        .interfaces =3D (InterfaceInfo[]) {
> +            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        }
> +    },
> +};
> +
> +DEFINE_TYPES(virtio_gpu_rutabaga_pci_info)
> +
> +module_obj(TYPE_VIRTIO_GPU_RUTABAGA_PCI);
> +module_kconfig(VIRTIO_PCI);
> +module_dep("hw-display-virtio-gpu-pci");
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rut=
abaga.c
> new file mode 100644
> index 0000000000..e6f799a14c
> --- /dev/null
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -0,0 +1,1113 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/iov.h"
> +#include "trace.h"
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/virtio-gpu.h"
> +#include "hw/virtio/virtio-gpu-pixman.h"
> +#include "hw/virtio/virtio-iommu.h"
> +
> +#include <glib/gmem.h>
> +#include <rutabaga_gfx/rutabaga_gfx_ffi.h>
> +
> +#define CHECK(condition, cmd)                                           =
      \
> +    do {                                                                =
      \
> +        if (!(condition)) {                                             =
      \
> +            error_report("CHECK failed in %s() %s:" "%d", __func__,     =
      \
> +                         __FILE__, __LINE__);                           =
      \
> +            (cmd)->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;                =
        \
> +            return;                                                     =
      \
> +       }                                                                =
      \
> +    } while (0)
> +
> +struct rutabaga_aio_data {
> +    struct VirtIOGPURutabaga *vr;
> +    struct rutabaga_fence fence;
> +};
> +
> +static void
> +virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, struct virtio_gpu_scanou=
t *s,
> +                                  uint32_t resource_id)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +    struct rutabaga_transfer transfer =3D { 0 };
> +    struct iovec transfer_iovec;
> +
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    res =3D virtio_gpu_find_resource(g, resource_id);
> +    if (!res) {
> +        return;
> +    }
> +
> +    if (res->width !=3D s->current_cursor->width ||
> +        res->height !=3D s->current_cursor->height) {
> +        return;
> +    }
> +
> +    transfer.x =3D 0;
> +    transfer.y =3D 0;
> +    transfer.z =3D 0;
> +    transfer.w =3D res->width;
> +    transfer.h =3D res->height;
> +    transfer.d =3D 1;
> +
> +    transfer_iovec.iov_base =3D s->current_cursor->data;
> +    transfer_iovec.iov_len =3D res->width * res->height * 4;
> +
> +    rutabaga_resource_transfer_read(vr->rutabaga, 0,
> +                                    resource_id, &transfer,
> +                                    &transfer_iovec);
> +}
> +
> +static void
> +virtio_gpu_rutabaga_gl_flushed(VirtIOGPUBase *b)
> +{
> +    VirtIOGPU *g =3D VIRTIO_GPU(b);
> +    virtio_gpu_process_cmdq(g);
> +}
> +
> +static void
> +rutabaga_cmd_create_resource_2d(VirtIOGPU *g,
> +                                struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct rutabaga_create_3d rc_3d =3D { 0 };
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_create_2d c2d;
> +
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(c2d);
> +    trace_virtio_gpu_cmd_res_create_2d(c2d.resource_id, c2d.format,
> +                                       c2d.width, c2d.height);
> +
> +    rc_3d.target =3D 2;
> +    rc_3d.format =3D c2d.format;
> +    rc_3d.bind =3D (1 << 1);
> +    rc_3d.width =3D c2d.width;
> +    rc_3d.height =3D c2d.height;
> +    rc_3d.depth =3D 1;
> +    rc_3d.array_size =3D 1;
> +    rc_3d.last_level =3D 0;
> +    rc_3d.nr_samples =3D 0;
> +    rc_3d.flags =3D VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
> +
> +    result =3D rutabaga_resource_create_3d(vr->rutabaga, c2d.resource_id=
, &rc_3d);
> +    CHECK(!result, cmd);
> +
> +    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
> +    res->width =3D c2d.width;
> +    res->height =3D c2d.height;
> +    res->format =3D c2d.format;
> +    res->resource_id =3D c2d.resource_id;
> +
> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
> +}
> +
> +static void
> +rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
> +                                struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct rutabaga_create_3d rc_3d =3D { 0 };
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_create_3d c3d;
> +
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(c3d);
> +
> +    trace_virtio_gpu_cmd_res_create_3d(c3d.resource_id, c3d.format,
> +                                       c3d.width, c3d.height, c3d.depth)=
;
> +
> +    rc_3d.target =3D c3d.target;
> +    rc_3d.format =3D c3d.format;
> +    rc_3d.bind =3D c3d.bind;
> +    rc_3d.width =3D c3d.width;
> +    rc_3d.height =3D c3d.height;
> +    rc_3d.depth =3D c3d.depth;
> +    rc_3d.array_size =3D c3d.array_size;
> +    rc_3d.last_level =3D c3d.last_level;
> +    rc_3d.nr_samples =3D c3d.nr_samples;
> +    rc_3d.flags =3D c3d.flags;
> +
> +    result =3D rutabaga_resource_create_3d(vr->rutabaga, c3d.resource_id=
, &rc_3d);
> +    CHECK(!result, cmd);
> +
> +    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
> +    res->width =3D c3d.width;
> +    res->height =3D c3d.height;
> +    res->format =3D c3d.format;
> +    res->resource_id =3D c3d.resource_id;
> +
> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
> +}
> +
> +static void
> +rutabaga_cmd_resource_unref(VirtIOGPU *g,
> +                            struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_unref unref;
> +
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(unref);
> +
> +    trace_virtio_gpu_cmd_res_unref(unref.resource_id);
> +
> +    res =3D virtio_gpu_find_resource(g, unref.resource_id);
> +    CHECK(res, cmd);
> +
> +    result =3D rutabaga_resource_unref(vr->rutabaga, unref.resource_id);
> +    CHECK(!result, cmd);
> +
> +    if (res->image) {
> +        pixman_image_unref(res->image);
> +    }
> +
> +    QTAILQ_REMOVE(&g->reslist, res, next);
> +    g_free(res);
> +}
> +
> +static void
> +rutabaga_cmd_context_create(VirtIOGPU *g,
> +                            struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_ctx_create cc;
> +
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(cc);
> +    trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,
> +                                    cc.debug_name);
> +
> +    result =3D rutabaga_context_create(vr->rutabaga, cc.hdr.ctx_id,
> +                                     cc.context_init, cc.debug_name, cc.=
nlen);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_context_destroy(VirtIOGPU *g,
> +                             struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_ctx_destroy cd;
> +
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(cd);
> +    trace_virtio_gpu_cmd_ctx_destroy(cd.hdr.ctx_id);
> +
> +    result =3D rutabaga_context_destroy(vr->rutabaga, cd.hdr.ctx_id);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_resource_flush(VirtIOGPU *g, struct virtio_gpu_ctrl_command=
 *cmd)
> +{
> +    int32_t result, i;
> +    struct virtio_gpu_scanout *scanout =3D NULL;
> +    struct virtio_gpu_simple_resource *res;
> +    struct rutabaga_transfer transfer =3D { 0 };
> +    struct iovec transfer_iovec;
> +    struct virtio_gpu_resource_flush rf;
> +    bool found =3D false;
> +
> +    VirtIOGPUBase *vb =3D VIRTIO_GPU_BASE(g);
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +    if (vr->headless) {
> +        return;
> +    }
> +
> +    VIRTIO_GPU_FILL_CMD(rf);
> +    trace_virtio_gpu_cmd_res_flush(rf.resource_id,
> +                                   rf.r.width, rf.r.height, rf.r.x, rf.r=
.y);
> +
> +    res =3D virtio_gpu_find_resource(g, rf.resource_id);
> +    CHECK(res, cmd);
> +
> +    for (i =3D 0; i < vb->conf.max_outputs; i++) {
> +        scanout =3D &vb->scanout[i];
> +        if (i =3D=3D res->scanout_bitmask) {
> +            found =3D true;
> +            break;
> +        }
> +    }
> +
> +    if (!found) {
> +        return;
> +    }
> +
> +    transfer.x =3D 0;
> +    transfer.y =3D 0;
> +    transfer.z =3D 0;
> +    transfer.w =3D res->width;
> +    transfer.h =3D res->height;
> +    transfer.d =3D 1;
> +
> +    transfer_iovec.iov_base =3D pixman_image_get_data(res->image);
> +    transfer_iovec.iov_len =3D res->width * res->height * 4;
> +
> +    result =3D rutabaga_resource_transfer_read(vr->rutabaga, 0,
> +                                             rf.resource_id, &transfer,
> +                                             &transfer_iovec);
> +    CHECK(!result, cmd);
> +    dpy_gfx_update_full(scanout->con);
> +}
> +
> +static void
> +rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *c=
md)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_scanout *scanout =3D NULL;
> +    struct virtio_gpu_set_scanout ss;
> +
> +    VirtIOGPUBase *vb =3D VIRTIO_GPU_BASE(g);
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +    if (vr->headless) {
> +        return;
> +    }
> +
> +    VIRTIO_GPU_FILL_CMD(ss);
> +    trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_id,
> +                                     ss.r.width, ss.r.height, ss.r.x, ss=
.r.y);
> +
> +    CHECK(ss.scanout_id < VIRTIO_GPU_MAX_SCANOUTS, cmd);
> +    scanout =3D &vb->scanout[ss.scanout_id];
> +
> +    if (ss.resource_id =3D=3D 0) {
> +        dpy_gfx_replace_surface(scanout->con, NULL);
> +        dpy_gl_scanout_disable(scanout->con);
> +        return;
> +    }
> +
> +    res =3D virtio_gpu_find_resource(g, ss.resource_id);
> +    CHECK(res, cmd);
> +
> +    if (!res->image) {
> +        pixman_format_code_t pformat;
> +        pformat =3D virtio_gpu_get_pixman_format(res->format);
> +        CHECK(pformat, cmd);
> +
> +        res->image =3D pixman_image_create_bits(pformat,
> +                                              res->width,
> +                                              res->height,
> +                                              NULL, 0);
> +        CHECK(res->image, cmd);
> +        pixman_image_ref(res->image);
> +    }
> +
> +    vb->enable =3D 1;
> +
> +    /* realloc the surface ptr */
> +    scanout->ds =3D qemu_create_displaysurface_pixman(res->image);
> +    dpy_gfx_replace_surface(scanout->con, NULL);
> +    dpy_gfx_replace_surface(scanout->con, scanout->ds);
> +    res->scanout_bitmask =3D ss.scanout_id;
> +}
> +
> +static void
> +rutabaga_cmd_submit_3d(VirtIOGPU *g,
> +                       struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_cmd_submit cs;
> +    struct rutabaga_command rutabaga_cmd =3D { 0 };
> +    g_autofree uint8_t *buf =3D NULL;
> +    size_t s;
> +
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(cs);
> +    trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size);
> +
> +    buf =3D g_new0(uint8_t, cs.size);
> +    s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> +                   sizeof(cs), buf, cs.size);
> +    CHECK(s =3D=3D cs.size, cmd);
> +
> +    rutabaga_cmd.ctx_id =3D cs.hdr.ctx_id;
> +    rutabaga_cmd.cmd =3D buf;
> +    rutabaga_cmd.cmd_size =3D cs.size;
> +
> +    result =3D rutabaga_submit_command(vr->rutabaga, &rutabaga_cmd);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_transfer_to_host_2d(VirtIOGPU *g,
> +                                 struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct rutabaga_transfer transfer =3D { 0 };
> +    struct virtio_gpu_transfer_to_host_2d t2d;
> +
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(t2d);
> +    trace_virtio_gpu_cmd_res_xfer_toh_2d(t2d.resource_id);
> +
> +    transfer.x =3D t2d.r.x;
> +    transfer.y =3D t2d.r.y;
> +    transfer.z =3D 0;
> +    transfer.w =3D t2d.r.width;
> +    transfer.h =3D t2d.r.height;
> +    transfer.d =3D 1;
> +
> +    result =3D rutabaga_resource_transfer_write(vr->rutabaga, 0, t2d.res=
ource_id,
> +                                              &transfer);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_transfer_to_host_3d(VirtIOGPU *g,
> +                                 struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct rutabaga_transfer transfer =3D { 0 };
> +    struct virtio_gpu_transfer_host_3d t3d;
> +
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(t3d);
> +    trace_virtio_gpu_cmd_res_xfer_toh_3d(t3d.resource_id);
> +
> +    transfer.x =3D t3d.box.x;
> +    transfer.y =3D t3d.box.y;
> +    transfer.z =3D t3d.box.z;
> +    transfer.w =3D t3d.box.w;
> +    transfer.h =3D t3d.box.h;
> +    transfer.d =3D t3d.box.d;
> +    transfer.level =3D t3d.level;
> +    transfer.stride =3D t3d.stride;
> +    transfer.layer_stride =3D t3d.layer_stride;
> +    transfer.offset =3D t3d.offset;
> +
> +    result =3D rutabaga_resource_transfer_write(vr->rutabaga, t3d.hdr.ct=
x_id,
> +                                              t3d.resource_id, &transfer=
);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_transfer_from_host_3d(VirtIOGPU *g,
> +                                   struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct rutabaga_transfer transfer =3D { 0 };
> +    struct virtio_gpu_transfer_host_3d t3d;
> +
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(t3d);
> +    trace_virtio_gpu_cmd_res_xfer_fromh_3d(t3d.resource_id);
> +
> +    transfer.x =3D t3d.box.x;
> +    transfer.y =3D t3d.box.y;
> +    transfer.z =3D t3d.box.z;
> +    transfer.w =3D t3d.box.w;
> +    transfer.h =3D t3d.box.h;
> +    transfer.d =3D t3d.box.d;
> +    transfer.level =3D t3d.level;
> +    transfer.stride =3D t3d.stride;
> +    transfer.layer_stride =3D t3d.layer_stride;
> +    transfer.offset =3D t3d.offset;
> +
> +    result =3D rutabaga_resource_transfer_read(vr->rutabaga, t3d.hdr.ctx=
_id,
> +                                             t3d.resource_id, &transfer,=
 NULL);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_attach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command=
 *cmd)
> +{
> +    struct rutabaga_iovecs vecs =3D { 0 };
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_attach_backing att_rb;
> +    int ret;
> +
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(att_rb);
> +    trace_virtio_gpu_cmd_res_back_attach(att_rb.resource_id);
> +
> +    res =3D virtio_gpu_find_resource(g, att_rb.resource_id);
> +    CHECK(res, cmd);
> +    CHECK(!res->iov, cmd);
> +
> +    ret =3D virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(a=
tt_rb),
> +                                        cmd, NULL, &res->iov, &res->iov_=
cnt);
> +    CHECK(!ret, cmd);
> +
> +    vecs.iovecs =3D res->iov;
> +    vecs.num_iovecs =3D res->iov_cnt;
> +
> +    ret =3D rutabaga_resource_attach_backing(vr->rutabaga, att_rb.resour=
ce_id,
> +                                           &vecs);
> +    if (ret !=3D 0) {
> +        virtio_gpu_cleanup_mapping(g, res);
> +    }
> +
> +    CHECK(!ret, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_detach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command=
 *cmd)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_detach_backing detach_rb;
> +
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(detach_rb);
> +    trace_virtio_gpu_cmd_res_back_detach(detach_rb.resource_id);
> +
> +    res =3D virtio_gpu_find_resource(g, detach_rb.resource_id);
> +    CHECK(res, cmd);
> +
> +    rutabaga_resource_detach_backing(vr->rutabaga,
> +                                     detach_rb.resource_id);
> +
> +    virtio_gpu_cleanup_mapping(g, res);
> +}
> +
> +static void
> +rutabaga_cmd_ctx_attach_resource(VirtIOGPU *g,
> +                                 struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_ctx_resource att_res;
> +
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(att_res);
> +    trace_virtio_gpu_cmd_ctx_res_attach(att_res.hdr.ctx_id,
> +                                        att_res.resource_id);
> +
> +    result =3D rutabaga_context_attach_resource(vr->rutabaga, att_res.hd=
r.ctx_id,
> +                                              att_res.resource_id);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_ctx_detach_resource(VirtIOGPU *g,
> +                                 struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_ctx_resource det_res;
> +
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(det_res);
> +    trace_virtio_gpu_cmd_ctx_res_detach(det_res.hdr.ctx_id,
> +                                        det_res.resource_id);
> +
> +    result =3D rutabaga_context_detach_resource(vr->rutabaga, det_res.hd=
r.ctx_id,
> +                                              det_res.resource_id);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct virtio_gpu_ctrl_comman=
d *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_get_capset_info info;
> +    struct virtio_gpu_resp_capset_info resp;
> +
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(info);
> +
> +    result =3D rutabaga_get_capset_info(vr->rutabaga, info.capset_index,
> +                                      &resp.capset_id, &resp.capset_max_=
version,
> +                                      &resp.capset_max_size);
> +    CHECK(!result, cmd);
> +
> +    resp.hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET_INFO;
> +    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
> +}
> +
> +static void
> +rutabaga_cmd_get_capset(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cm=
d)
> +{
> +    int32_t result;
> +    struct virtio_gpu_get_capset gc;
> +    struct virtio_gpu_resp_capset *resp;
> +    uint32_t capset_size, capset_version;
> +    uint32_t current_id, i;
> +
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(gc);
> +    for (i =3D 0; i < vr->num_capsets; i++) {
> +        result =3D rutabaga_get_capset_info(vr->rutabaga, i,
> +                                          &current_id, &capset_version,
> +                                          &capset_size);
> +        CHECK(!result, cmd);
> +
> +        if (current_id =3D=3D gc.capset_id) {
> +            break;
> +        }
> +    }
> +
> +    CHECK(i < vr->num_capsets, cmd);
> +
> +    resp =3D g_malloc0(sizeof(*resp) + capset_size);
> +    resp->hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET;
> +    rutabaga_get_capset(vr->rutabaga, gc.capset_id, gc.capset_version,
> +                        resp->capset_data, capset_size);
> +
> +    virtio_gpu_ctrl_response(g, cmd, &resp->hdr, sizeof(*resp) + capset_=
size);
> +    g_free(resp);
> +}
> +
> +static void
> +rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
> +                                  struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int result;
> +    struct rutabaga_iovecs vecs =3D { 0 };
> +    g_autofree struct virtio_gpu_simple_resource *res =3D NULL;
> +    struct virtio_gpu_resource_create_blob cblob;
> +    struct rutabaga_create_blob rc_blob =3D { 0 };
> +
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(cblob);
> +    trace_virtio_gpu_cmd_res_create_blob(cblob.resource_id, cblob.size);
> +
> +    CHECK(cblob.resource_id !=3D 0, cmd);
> +
> +    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
> +
> +    res->resource_id =3D cblob.resource_id;
> +    res->blob_size =3D cblob.size;
> +
> +    if (cblob.blob_mem !=3D VIRTIO_GPU_BLOB_MEM_HOST3D) {
> +        result =3D virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
> +                                               sizeof(cblob), cmd, &res-=
>addrs,
> +                                               &res->iov, &res->iov_cnt)=
;
> +        CHECK(!result, cmd);
> +    }
> +
> +    rc_blob.blob_id =3D cblob.blob_id;
> +    rc_blob.blob_mem =3D cblob.blob_mem;
> +    rc_blob.blob_flags =3D cblob.blob_flags;
> +    rc_blob.size =3D cblob.size;
> +
> +    vecs.iovecs =3D res->iov;
> +    vecs.num_iovecs =3D res->iov_cnt;
> +
> +    result =3D rutabaga_resource_create_blob(vr->rutabaga, cblob.hdr.ctx=
_id,
> +                                           cblob.resource_id, &rc_blob, =
&vecs,
> +                                           NULL);
> +
> +    if (result && cblob.blob_mem !=3D VIRTIO_GPU_BLOB_MEM_HOST3D) {
> +        virtio_gpu_cleanup_mapping(g, res);
> +    }
> +
> +    CHECK(!result, cmd);
> +
> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
> +    res =3D NULL;
> +}
> +
> +static void
> +rutabaga_cmd_resource_map_blob(VirtIOGPU *g,
> +                               struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    uint32_t map_info =3D 0;
> +    uint32_t slot =3D 0;
> +    struct virtio_gpu_simple_resource *res;
> +    struct rutabaga_mapping mapping =3D { 0 };
> +    struct virtio_gpu_resource_map_blob mblob;
> +    struct virtio_gpu_resp_map_info resp =3D { 0 };
> +
> +    VirtIOGPUBase *vb =3D VIRTIO_GPU_BASE(g);
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(mblob);
> +
> +    CHECK(mblob.resource_id !=3D 0, cmd);
> +
> +    res =3D virtio_gpu_find_resource(g, mblob.resource_id);
> +    CHECK(res, cmd);
> +
> +    result =3D rutabaga_resource_map_info(vr->rutabaga, mblob.resource_i=
d,
> +                                        &map_info);
> +    CHECK(!result, cmd);
> +
> +    /*
> +     * RUTABAGA_MAP_ACCESS_* flags are not part of the virtio-gpu spec, =
but do
> +     * exist to potentially allow the hypervisor to restrict write acces=
s to
> +     * memory. QEMU does not need to use this functionality at the momen=
t.
> +     */
> +    resp.map_info =3D map_info & RUTABAGA_MAP_CACHE_MASK;
> +
> +    result =3D rutabaga_resource_map(vr->rutabaga, mblob.resource_id, &m=
apping);
> +    CHECK(!result, cmd);
> +
> +    /*
> +     * There is small risk of the MemoryRegion dereferencing the pointer=
 after
> +     * rutabaga unmaps it. Please see discussion here:
> +     *
> +     * https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg05141.ht=
ml
> +     *
> +     * It is highly unlikely to happen in practice and doesn't affect kn=
own
> +     * use cases. However, it should be fixed and is noted here for post=
erity.
> +     */
> +    for (slot =3D 0; slot < MAX_SLOTS; slot++) {
> +        if (vr->memory_regions[slot].used) {
> +            continue;
> +        }
> +
> +        MemoryRegion *mr =3D &(vr->memory_regions[slot].mr);
> +        memory_region_init_ram_ptr(mr, OBJECT(vr), "blob", mapping.size,
> +                                   mapping.ptr);
> +        memory_region_add_subregion(&vb->hostmem, mblob.offset, mr);
> +        vr->memory_regions[slot].resource_id =3D mblob.resource_id;
> +        vr->memory_regions[slot].used =3D 1;
> +        break;
> +    }
> +
> +    if (slot >=3D MAX_SLOTS) {
> +        result =3D rutabaga_resource_unmap(vr->rutabaga, mblob.resource_=
id);
> +        CHECK(!result, cmd);
> +    }
> +
> +    CHECK(slot < MAX_SLOTS, cmd);
> +
> +    resp.hdr.type =3D VIRTIO_GPU_RESP_OK_MAP_INFO;
> +    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
> +}
> +
> +static void
> +rutabaga_cmd_resource_unmap_blob(VirtIOGPU *g,
> +                                 struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    uint32_t slot =3D 0;
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_unmap_blob ublob;
> +
> +    VirtIOGPUBase *vb =3D VIRTIO_GPU_BASE(g);
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(ublob);
> +
> +    CHECK(ublob.resource_id !=3D 0, cmd);
> +
> +    res =3D virtio_gpu_find_resource(g, ublob.resource_id);
> +    CHECK(res, cmd);
> +
> +    for (slot =3D 0; slot < MAX_SLOTS; slot++) {
> +        if (vr->memory_regions[slot].resource_id !=3D ublob.resource_id)=
 {
> +            continue;
> +        }
> +
> +        MemoryRegion *mr =3D &(vr->memory_regions[slot].mr);
> +        memory_region_del_subregion(&vb->hostmem, mr);
> +
> +        vr->memory_regions[slot].resource_id =3D 0;
> +        vr->memory_regions[slot].used =3D 0;
> +        break;
> +    }
> +
> +    CHECK(slot < MAX_SLOTS, cmd);
> +    result =3D rutabaga_resource_unmap(vr->rutabaga, res->resource_id);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +virtio_gpu_rutabaga_process_cmd(VirtIOGPU *g,
> +                                struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct rutabaga_fence fence =3D { 0 };
> +    int32_t result;
> +
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
> +
> +    switch (cmd->cmd_hdr.type) {
> +    case VIRTIO_GPU_CMD_CTX_CREATE:
> +        rutabaga_cmd_context_create(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_CTX_DESTROY:
> +        rutabaga_cmd_context_destroy(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_2D:
> +        rutabaga_cmd_create_resource_2d(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_3D:
> +        rutabaga_cmd_create_resource_3d(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_SUBMIT_3D:
> +        rutabaga_cmd_submit_3d(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D:
> +        rutabaga_cmd_transfer_to_host_2d(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D:
> +        rutabaga_cmd_transfer_to_host_3d(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D:
> +        rutabaga_cmd_transfer_from_host_3d(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING:
> +        rutabaga_cmd_attach_backing(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:
> +        rutabaga_cmd_detach_backing(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_SET_SCANOUT:
> +        rutabaga_cmd_set_scanout(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_FLUSH:
> +        rutabaga_cmd_resource_flush(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_UNREF:
> +        rutabaga_cmd_resource_unref(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:
> +        rutabaga_cmd_ctx_attach_resource(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE:
> +        rutabaga_cmd_ctx_detach_resource(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_GET_CAPSET_INFO:
> +        rutabaga_cmd_get_capset_info(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_GET_CAPSET:
> +        rutabaga_cmd_get_capset(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:
> +        virtio_gpu_get_display_info(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_GET_EDID:
> +        virtio_gpu_get_edid(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB:
> +        rutabaga_cmd_resource_create_blob(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB:
> +        rutabaga_cmd_resource_map_blob(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:
> +        rutabaga_cmd_resource_unmap_blob(g, cmd);
> +        break;
> +    default:
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
> +        break;
> +    }
> +
> +    if (cmd->finished) {
> +        return;
> +    }
> +    if (cmd->error) {
> +        error_report("%s: ctrl 0x%x, error 0x%x", __func__,
> +                     cmd->cmd_hdr.type, cmd->error);
> +        virtio_gpu_ctrl_response_nodata(g, cmd, cmd->error);
> +        return;
> +    }
> +    if (!(cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE)) {
> +        virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODAT=
A);
> +        return;
> +    }
> +
> +    fence.flags =3D cmd->cmd_hdr.flags;
> +    fence.ctx_id =3D cmd->cmd_hdr.ctx_id;
> +    fence.fence_id =3D cmd->cmd_hdr.fence_id;
> +    fence.ring_idx =3D cmd->cmd_hdr.ring_idx;
> +
> +    trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type=
);
> +
> +    result =3D rutabaga_create_fence(vr->rutabaga, &fence);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +virtio_gpu_rutabaga_aio_cb(void *opaque)
> +{
> +    struct rutabaga_aio_data *data =3D opaque;
> +    VirtIOGPU *g =3D VIRTIO_GPU(data->vr);
> +    struct rutabaga_fence fence_data =3D data->fence;
> +    struct virtio_gpu_ctrl_command *cmd, *tmp;
> +
> +    uint32_t signaled_ctx_specific =3D fence_data.flags &
> +                                     RUTABAGA_FLAG_INFO_RING_IDX;
> +
> +    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
> +        /*
> +         * Due to context specific timelines.
> +         */
> +        uint32_t target_ctx_specific =3D cmd->cmd_hdr.flags &
> +                                       RUTABAGA_FLAG_INFO_RING_IDX;
> +
> +        if (signaled_ctx_specific !=3D target_ctx_specific) {
> +            continue;
> +        }
> +
> +        if (signaled_ctx_specific &&
> +           (cmd->cmd_hdr.ring_idx !=3D fence_data.ring_idx)) {
> +            continue;
> +        }
> +
> +        if (cmd->cmd_hdr.fence_id > fence_data.fence_id) {
> +            continue;
> +        }
> +
> +        trace_virtio_gpu_fence_resp(cmd->cmd_hdr.fence_id);
> +        virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODAT=
A);
> +        QTAILQ_REMOVE(&g->fenceq, cmd, next);
> +        g_free(cmd);
> +    }
> +
> +    g_free(data);
> +}
> +
> +static void
> +virtio_gpu_rutabaga_fence_cb(uint64_t user_data,
> +                             const struct rutabaga_fence *fence) {

There are a few style issues that are easy to miss, like here (opening
brace for functions on empty line)

I am not sure it's worth a resend

> +    struct rutabaga_aio_data *data;
> +    VirtIOGPU *g =3D (VirtIOGPU *)user_data;
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    /*
> +     * gfxstream and both cross-domain (and even newer versions virglren=
derer:
> +     * see VIRGL_RENDERER_ASYNC_FENCE_CB) like to signal fence completio=
n on
> +     * threads ("callback threads") that are different from the thread t=
hat
> +     * processes the command queue ("main thread").
> +     *
> +     * crosvm and other virtio-gpu 1.1 implementations enable callback t=
hreads
> +     * via locking.  However, on QEMU a deadlock is observed if
> +     * virtio_gpu_ctrl_response_nodata(..) [used in the fence callback] =
is used
> +     * from a thread that is not the main thread.
> +     *
> +     * The reason is QEMU's internal locking is designed to work with QE=
MU
> +     * threads (see rcu_register_thread()) and not generic C/C++/Rust th=
reads.
> +     * For now, we can workaround this by scheduling the return of the
> +     * fence descriptors on the main thread.
> +     */
> +
> +    data =3D g_new0(struct rutabaga_aio_data, 1);
> +    data->vr =3D vr;
> +    data->fence =3D *fence;
> +    aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                            virtio_gpu_rutabaga_aio_cb,
> +                            data);
> +}
> +
> +static void
> +virtio_gpu_rutabaga_debug_cb(uint64_t user_data,
> +                             const struct rutabaga_debug *debug) {

and here

> +
> +    if (debug->debug_type =3D=3D RUTABAGA_DEBUG_ERROR) {

maybe a switch is more appropriate?

> +        error_report("%s", debug->message);
> +    } else if (debug->debug_type =3D=3D RUTABAGA_DEBUG_WARN) {
> +        warn_report("%s", debug->message);
> +    } else if (debug->debug_type =3D=3D RUTABAGA_DEBUG_INFO) {
> +        info_report("%s", debug->message);
> +    }
> +}
> +
> +static bool virtio_gpu_rutabaga_init(VirtIOGPU *g, Error **errp)
> +{
> +    int result;
> +    struct rutabaga_builder builder =3D { 0 };
> +    struct rutabaga_channel channel =3D { 0 };
> +    struct rutabaga_channels channels =3D { 0 };
> +
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +    vr->rutabaga =3D NULL;
> +
> +    builder.wsi =3D RUTABAGA_WSI_SURFACELESS;
> +    /*
> +     * Currently, if WSI is specified, the only valid strings are "surfa=
celess"
> +     * or "headless".  Surfaceless doesn't create a native window surfac=
e, but
> +     * does copy from the render target to the Pixman buffer if a virtio=
-gpu
> +     * 2D hypercall is issued.  Surfacless is the default.
> +     *
> +     * Headless is like surfaceless, but doesn't copy to the Pixman buff=
er. The
> +     * use case is automated testing environments where there is no need=
 to view
> +     * results.
> +     *
> +     * In the future, more performant virtio-gpu 2D UI integration may b=
e added.
> +     */
> +    if (vr->wsi) {
> +        if (g_str_equal(vr->wsi, "surfaceless")) {
> +            vr->headless =3D false;
> +        } else if (g_str_equal(vr->wsi, "headless")) {
> +            vr->headless =3D true;
> +        } else {
> +            error_setg(errp, "invalid wsi option selected");
> +            return false;
> +        }
> +    }
> +
> +    builder.fence_cb =3D virtio_gpu_rutabaga_fence_cb;
> +    builder.debug_cb =3D virtio_gpu_rutabaga_debug_cb;
> +    builder.capset_mask =3D vr->capset_mask;
> +    builder.user_data =3D (uint64_t)g;
> +
> +    /*
> +     * If the user doesn't specify the wayland socket path, we try to in=
fer
> +     * the socket via a process similar to the one used by libwayland.
> +     * libwayland does the following:
> +     *
> +     * 1) If $WAYLAND_DISPLAY is set, attempt to connect to
> +     *    $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY
> +     * 2) Otherwise, attempt to connect to $XDG_RUNTIME_DIR/wayland-0
> +     * 3) Otherwise, don't pass a wayland socket to rutabaga. If a guest
> +     *    wayland proxy is launched, it will fail to work.
> +     */
> +    channel.channel_type =3D RUTABAGA_CHANNEL_TYPE_WAYLAND;
> +    g_autofree gchar *path =3D NULL;
> +    if (!vr->wayland_socket_path) {
> +        const gchar *runtime_dir =3D g_get_user_runtime_dir();
> +        const gchar *display =3D g_getenv("WAYLAND_DISPLAY");
> +        if (!display) {
> +            display =3D "wayland-0";
> +        }
> +
> +        if (runtime_dir) {
> +            path =3D g_build_filename(runtime_dir, display, NULL);
> +            channel.channel_name =3D path;
> +        }
> +    } else {
> +        channel.channel_name =3D vr->wayland_socket_path;
> +    }
> +
> +    if ((builder.capset_mask & (1 << RUTABAGA_CAPSET_CROSS_DOMAIN))) {
> +        if (channel.channel_name) {
> +            channels.channels =3D &channel;
> +            channels.num_channels =3D 1;
> +            builder.channels =3D &channels;
> +        }
> +    }
> +
> +    result =3D rutabaga_init(&builder, &vr->rutabaga);
> +    if (result) {
> +        error_setg_errno(errp, -result, "Failed to init rutabaga");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static int virtio_gpu_rutabaga_get_num_capsets(VirtIOGPU *g)
> +{
> +    int result;
> +    uint32_t num_capsets;
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    result =3D rutabaga_get_num_capsets(vr->rutabaga, &num_capsets);
> +    if (result) {
> +        error_report("Failed to get capsets");
> +        return 0;
> +    }
> +    vr->num_capsets =3D num_capsets;
> +    return num_capsets;
> +}
> +
> +static void virtio_gpu_rutabaga_handle_ctrl(VirtIODevice *vdev, VirtQueu=
e *vq)
> +{
> +    VirtIOGPU *g =3D VIRTIO_GPU(vdev);
> +    struct virtio_gpu_ctrl_command *cmd;
> +
> +    if (!virtio_queue_ready(vq)) {
> +        return;
> +    }
> +
> +    cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command));
> +    while (cmd) {
> +        cmd->vq =3D vq;
> +        cmd->error =3D 0;
> +        cmd->finished =3D false;
> +        QTAILQ_INSERT_TAIL(&g->cmdq, cmd, next);
> +        cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command)=
);
> +    }
> +
> +    virtio_gpu_process_cmdq(g);
> +}
> +
> +static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp)
> +{
> +    int num_capsets;
> +    VirtIOGPUBase *bdev =3D VIRTIO_GPU_BASE(qdev);
> +    VirtIOGPU *gpudev =3D VIRTIO_GPU(qdev);
> +
> +#if HOST_BIG_ENDIAN
> +    error_setg(errp, "rutabaga is not supported on bigendian platforms")=
;
> +    return;
> +#endif
> +
> +    if (!virtio_gpu_rutabaga_init(gpudev, errp)) {
> +        return;
> +    }
> +
> +    num_capsets =3D virtio_gpu_rutabaga_get_num_capsets(gpudev);
> +    if (!num_capsets) {
> +        return;
> +    }
> +
> +    bdev->conf.flags |=3D (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED);
> +    bdev->conf.flags |=3D (1 << VIRTIO_GPU_FLAG_BLOB_ENABLED);
> +    bdev->conf.flags |=3D (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED);
> +
> +    bdev->virtio_config.num_capsets =3D num_capsets;
> +    virtio_gpu_device_realize(qdev, errp);
> +}
> +
> +static Property virtio_gpu_rutabaga_properties[] =3D {
> +    DEFINE_PROP_BIT64("gfxstream-vulkan", VirtIOGPURutabaga, capset_mask=
,
> +                      RUTABAGA_CAPSET_GFXSTREAM_VULKAN, false),
> +    DEFINE_PROP_BIT64("cross-domain", VirtIOGPURutabaga, capset_mask,
> +                      RUTABAGA_CAPSET_CROSS_DOMAIN, false),
> +    DEFINE_PROP_BIT64("x-gfxstream-gles", VirtIOGPURutabaga, capset_mask=
,
> +                      RUTABAGA_CAPSET_GFXSTREAM_GLES, false),
> +    DEFINE_PROP_BIT64("x-gfxstream-composer", VirtIOGPURutabaga, capset_=
mask,
> +                      RUTABAGA_CAPSET_GFXSTREAM_COMPOSER, false),
> +    DEFINE_PROP_STRING("wayland-socket-path", VirtIOGPURutabaga,
> +                       wayland_socket_path),
> +    DEFINE_PROP_STRING("wsi", VirtIOGPURutabaga, wsi),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void virtio_gpu_rutabaga_class_init(ObjectClass *klass, void *dat=
a)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
> +    VirtIOGPUBaseClass *vbc =3D VIRTIO_GPU_BASE_CLASS(klass);
> +    VirtIOGPUClass *vgc =3D VIRTIO_GPU_CLASS(klass);
> +
> +    vbc->gl_flushed =3D virtio_gpu_rutabaga_gl_flushed;
> +    vgc->handle_ctrl =3D virtio_gpu_rutabaga_handle_ctrl;
> +    vgc->process_cmd =3D virtio_gpu_rutabaga_process_cmd;
> +    vgc->update_cursor_data =3D virtio_gpu_rutabaga_update_cursor;
> +
> +    vdc->realize =3D virtio_gpu_rutabaga_realize;
> +    device_class_set_props(dc, virtio_gpu_rutabaga_properties);
> +}
> +
> +static const TypeInfo virtio_gpu_rutabaga_info[] =3D {
> +    {
> +        .name =3D TYPE_VIRTIO_GPU_RUTABAGA,
> +        .parent =3D TYPE_VIRTIO_GPU,
> +        .instance_size =3D sizeof(VirtIOGPURutabaga),
> +        .class_init =3D virtio_gpu_rutabaga_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(virtio_gpu_rutabaga_info)
> +
> +module_obj(TYPE_VIRTIO_GPU_RUTABAGA);
> +module_kconfig(VIRTIO_GPU);
> +module_dep("hw-display-virtio-gpu");
> diff --git a/hw/display/virtio-vga-rutabaga.c b/hw/display/virtio-vga-rut=
abaga.c
> new file mode 100644
> index 0000000000..a7bef6da24
> --- /dev/null
> +++ b/hw/display/virtio-vga-rutabaga.c
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +#include "hw/pci/pci.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/virtio/virtio-gpu.h"
> +#include "hw/display/vga.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "virtio-vga.h"
> +#include "qom/object.h"
> +
> +#define TYPE_VIRTIO_VGA_RUTABAGA "virtio-vga-rutabaga"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(VirtIOVGARutabaga, VIRTIO_VGA_RUTABAGA)
> +
> +struct VirtIOVGARutabaga {
> +    VirtIOVGABase parent_obj;
> +
> +    VirtIOGPURutabaga vdev;
> +};
> +
> +static void virtio_vga_rutabaga_inst_initfn(Object *obj)
> +{
> +    VirtIOVGARutabaga *dev =3D VIRTIO_VGA_RUTABAGA(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_GPU_RUTABAGA);
> +    VIRTIO_VGA_BASE(dev)->vgpu =3D VIRTIO_GPU_BASE(&dev->vdev);
> +}
> +
> +static VirtioPCIDeviceTypeInfo virtio_vga_rutabaga_info =3D {
> +    .generic_name  =3D TYPE_VIRTIO_VGA_RUTABAGA,
> +    .parent        =3D TYPE_VIRTIO_VGA_BASE,
> +    .instance_size =3D sizeof(VirtIOVGARutabaga),
> +    .instance_init =3D virtio_vga_rutabaga_inst_initfn,
> +};
> +module_obj(TYPE_VIRTIO_VGA_RUTABAGA);
> +module_kconfig(VIRTIO_VGA);
> +
> +static void virtio_vga_register_types(void)
> +{
> +    if (have_vga) {
> +        virtio_pci_types_register(&virtio_vga_rutabaga_info);
> +    }
> +}
> +
> +type_init(virtio_vga_register_types)
> +
> +module_dep("hw-display-virtio-vga");
> --
> 2.42.0.609.gbb76f46606-goog
>


