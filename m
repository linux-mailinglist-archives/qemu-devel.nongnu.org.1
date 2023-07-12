Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8931175110C
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 21:17:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJfIy-0004t1-9B; Wed, 12 Jul 2023 15:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qJfIt-0004sp-7b
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:15:11 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qJfIm-0001gj-RD
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:15:10 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-403b36a4226so109001cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 12:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689189303; x=1691781303;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DSIVNcOc+62SdIjEhVmQWPuRGyL0NB1R6P8iQ0j3Yvw=;
 b=htZP1U3LjZYwpDF/k0CKc7WzQCYP8HKnbrWI3pYoHtIeFWFtiX9sqvxqnNqCOj0wfi
 x5r5sMZ7+BONBxYS8qVIjs7WJkPHkTyGpcvYxgxfwbVi4MEv6VJ9f6PVOlncey4jM5dM
 r2uHdgqYx/vD53Q9L+7S60cmOYL7mzpUMeOHwrCR9e0FujA7eUCnuw5FjhGHr5t49s8O
 SbOtl4+gpIpTl13ahqI26+W38/AiWqnEyWYTEpfmeOx8PYOWZ6dsxwofFCMTeenSkM82
 Hz3zl7IJeNBA301iDZfnt5mvgZeOQr3Ti1VVwti1eiH1uMmuli4Ss51CqS+17Nlaeaf5
 RI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689189303; x=1691781303;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DSIVNcOc+62SdIjEhVmQWPuRGyL0NB1R6P8iQ0j3Yvw=;
 b=HtkYEq3PVRHyrwSlWwFbiG6NxpDE1asMNJlXrRiIIrKkweJzgey0dH38yO8IT4Xs1Y
 hGVJLf0+muRufjECtdcYvl1cyqN2XJBI5FY8bBO6OveTqj1t+87S7yJFo9RfBTKx6aOb
 jrYQbnJbIKrBPGDRn+WDG4+dAFz6xQpmTE8CDeRIMHXHrM8zXNqV6nvhc9lvD9dJQ/tP
 2PbU++c9qW0XezPd5ZXG8bo9F84F9ZbqJypNJygpOeVteeR1uhCQ7Ttkc4aXxD984yA1
 HTbdsmXiP0vdMTpxyM3FBQhOk4hWYpeQD4To6hUWYMD2ViJ+6zOfNMPzCWKvOqcJHy/c
 vfsg==
X-Gm-Message-State: ABy/qLajHfehECX75tw4MGMiwbdKqpPVt9TlGOmthep3vpuvSuRpz2e+
 w91pEh6yog9GkA9scCQTaQz5RSF9QB7Fv8/H0/k=
X-Google-Smtp-Source: APBJJlF3bxknjEBCAWzj4FQKW/NHgcQAIbMqIlaN62VrjzigZv8Pg8hsjLk+PhEdHRSl6XJp4EKx4JR8XGZBruHu518=
X-Received: by 2002:ac8:58c3:0:b0:3fd:def3:4c3c with SMTP id
 u3-20020ac858c3000000b003fddef34c3cmr24836990qta.44.1689189303259; Wed, 12
 Jul 2023 12:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230711025649.708-1-gurchetansingh@chromium.org>
 <20230711025649.708-7-gurchetansingh@chromium.org>
In-Reply-To: <20230711025649.708-7-gurchetansingh@chromium.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 12 Jul 2023 23:14:51 +0400
Message-ID: <CAJ+F1CJJcBbqEDnwzfO9d9qhQh7APNJ8Syyj+M_JFNv3g05pZA@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] gfxstream + rutabaga: add initial support for
 gfxstream
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org, akihiko.odaki@gmail.com, 
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org, 
 shentey@gmail.com, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000061163006004f08b8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000061163006004f08b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Jul 11, 2023 at 6:57=E2=80=AFAM Gurchetan Singh <gurchetansingh@chr=
omium.org>
wrote:

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
> academic term) was comparable to that of Augustus and the both Queen
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
>
Wow, this is not for the faint reader.. there is a lot to grasp in this gfx
space...

Could you perhaps extend on what this current code can do for an average
Linux VM? or for some Android VM (which one?!), and then what are the next
steps and status?

My limited understanding (from this series and from
https://gitlab.com/qemu-project/qemu/-/issues/1611) is that it allows
passing-through some vulkan APIs for off-screen usage. Is that accurate?

How far are we from getting upstream QEMU to be used by Android Emulator?
(in the gfx domain at least) What would it take to get the average Linux VM
to use virtio-vga-rutabaga instead of virtio-vga-gl to get accelerated
rendering?

[a] https://android-review.googlesource.com/c/platform/development/+/34470
> [b]
> https://android-review.googlesource.com/q/topic:%22vulkan-hostconnection-=
start%22
> [c]
> https://android-review.googlesource.com/c/device/generic/goldfish-opengl/=
+/761927
>
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> ---
> v2: Incorported various suggestions by Akihiko Odaki and Bernard Berschow
>     - Removed GET_VIRTIO_GPU_GL / GET_RUTABAGA macros
>     - Used error_report(..)
>     - Used g_autofree to fix leaks on error paths
>     - Removed unnecessary casts
>     - added virtio-gpu-pci-rutabaga.c + virtio-vga-rutabaga.c files
>
>  hw/display/virtio-gpu-pci-rutabaga.c |   48 ++
>  hw/display/virtio-gpu-rutabaga.c     | 1088 ++++++++++++++++++++++++++
>  hw/display/virtio-vga-rutabaga.c     |   52 ++
>  3 files changed, 1188 insertions(+)
>  create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
>  create mode 100644 hw/display/virtio-gpu-rutabaga.c
>  create mode 100644 hw/display/virtio-vga-rutabaga.c
>
> diff --git a/hw/display/virtio-gpu-pci-rutabaga.c
> b/hw/display/virtio-gpu-pci-rutabaga.c
> new file mode 100644
> index 0000000000..5765bef266
> --- /dev/null
> +++ b/hw/display/virtio-gpu-pci-rutabaga.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
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
> +typedef struct VirtIOGPURUTABAGAPCI VirtIOGPURUTABAGAPCI;
> +DECLARE_INSTANCE_CHECKER(VirtIOGPURUTABAGAPCI, VIRTIO_GPU_RUTABAGA_PCI,
> +                         TYPE_VIRTIO_GPU_RUTABAGA_PCI)
> +
> +struct VirtIOGPURUTABAGAPCI {
> +    VirtIOGPUPCIBase parent_obj;
> +    VirtioGpuRutabaga   vdev;
> +};
> +
> +static void virtio_gpu_rutabaga_initfn(Object *obj)
> +{
> +    VirtIOGPURUTABAGAPCI *dev =3D VIRTIO_GPU_RUTABAGA_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_GPU_RUTABAGA);
> +    VIRTIO_GPU_PCI_BASE(obj)->vgpu =3D VIRTIO_GPU_BASE(&dev->vdev);
> +}
> +
> +static const VirtioPCIDeviceTypeInfo virtio_gpu_rutabaga_pci_info =3D {
> +    .generic_name =3D TYPE_VIRTIO_GPU_RUTABAGA_PCI,
> +    .parent =3D TYPE_VIRTIO_GPU_PCI_BASE,
> +    .instance_size =3D sizeof(VirtIOGPURUTABAGAPCI),
> +    .instance_init =3D virtio_gpu_rutabaga_initfn,
> +};
> +module_obj(TYPE_VIRTIO_GPU_RUTABAGA_PCI);
> +module_kconfig(VIRTIO_PCI);
> +
> +static void virtio_gpu_rutabaga_pci_register_types(void)
> +{
> +    virtio_pci_types_register(&virtio_gpu_rutabaga_pci_info);
> +}
> +
> +type_init(virtio_gpu_rutabaga_pci_register_types)
> +
> +module_dep("hw-display-virtio-gpu-pci");
> diff --git a/hw/display/virtio-gpu-rutabaga.c
> b/hw/display/virtio-gpu-rutabaga.c
> new file mode 100644
> index 0000000000..b60a30a093
> --- /dev/null
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -0,0 +1,1088 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "qemu/osdep.h"
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
> +#define CHECK(condition, cmd)
>      \
> +    do {
>     \
> +        if (!condition) {
>      \
> +            error_report("CHECK failed in %s() %s:" "%d", __func__,
>      \
> +                         __FILE__, __LINE__);
>      \
> +            cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>     \
> +            return;
>      \
> +       }
>     \
> +    } while (0)
> +
> +#define CHECK_RESULT(result, cmd) CHECK(result =3D=3D 0, cmd)
> +
> +#define MAX_SLOTS 4096
> +
> +struct MemoryRegionInfo {
> +    int used;
> +    MemoryRegion mr;
> +    uint32_t resource_id;
> +};
> +
> +static struct MemoryRegionInfo memory_regions[MAX_SLOTS];
> +
> +struct rutabaga_aio_data {
> +    struct VirtioGpuRutabaga *vr;
> +    struct rutabaga_fence fence;
> +};
> +
> +static void
> +virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, struct virtio_gpu_scanou=
t
> *s,
> +                                  uint32_t resource_id)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +    struct rutabaga_transfer transfer =3D { 0 };
> +    struct iovec transfer_iovec;
> +
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
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
> +    transfer_iovec.iov_base =3D (void *)s->current_cursor->data;
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
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
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
,
> &rc_3d);
> +    CHECK_RESULT(result, cmd);
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
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
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
,
> &rc_3d);
> +    CHECK_RESULT(result, cmd);
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
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(unref);
> +
> +    trace_virtio_gpu_cmd_res_unref(unref.resource_id);
> +
> +    res =3D virtio_gpu_find_resource(g, unref.resource_id);
> +    CHECK(res, cmd);
> +
> +    result =3D rutabaga_resource_unref(vr->rutabaga, unref.resource_id);
> +    CHECK_RESULT(result, cmd);
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
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(cc);
> +    trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,
> +                                    cc.debug_name);
> +
> +    result =3D rutabaga_context_create(vr->rutabaga, cc.hdr.ctx_id,
> +                                     cc.context_init, cc.debug_name,
> cc.nlen);
> +    CHECK_RESULT(result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_context_destroy(VirtIOGPU *g,
> +                             struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_ctx_destroy cd;
> +
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(cd);
> +    trace_virtio_gpu_cmd_ctx_destroy(cd.hdr.ctx_id);
> +
> +    result =3D rutabaga_context_destroy(vr->rutabaga, cd.hdr.ctx_id);
> +    CHECK_RESULT(result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_resource_flush(VirtIOGPU *g, struct virtio_gpu_ctrl_command
> *cmd)
> +{
> +    int32_t result, i;
> +    struct virtio_gpu_scanout *scanout =3D NULL;
> +    struct virtio_gpu_simple_resource *res;
> +    struct rutabaga_transfer transfer =3D { 0 };
> +    struct iovec transfer_iovec;
> +    struct virtio_gpu_resource_flush rf;
> +    bool found =3D false;
> +
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +    if (vr->headless) {
> +        return;
> +    }
> +
> +    VIRTIO_GPU_FILL_CMD(rf);
> +    trace_virtio_gpu_cmd_res_flush(rf.resource_id,
> +                                   rf.r.width, rf.r.height, rf.r.x,
> rf.r.y);
> +
> +    res =3D virtio_gpu_find_resource(g, rf.resource_id);
> +    CHECK(res, cmd);
> +
> +    for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
> +        scanout =3D &g->parent_obj.scanout[i];
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
> +    transfer_iovec.iov_base =3D (void *)pixman_image_get_data(res->image=
);
> +    transfer_iovec.iov_len =3D res->width * res->height * 4;
> +
> +    result =3D rutabaga_resource_transfer_read(vr->rutabaga, 0,
> +                                             rf.resource_id, &transfer,
> +                                             &transfer_iovec);
> +    CHECK_RESULT(result, cmd);
> +    dpy_gfx_update_full(scanout->con);
> +}
> +
> +static void
> +rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command
> *cmd)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_scanout *scanout =3D NULL;
> +    struct virtio_gpu_set_scanout ss;
> +
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +    if (vr->headless) {
> +        return;
> +    }
> +
> +    VIRTIO_GPU_FILL_CMD(ss);
> +    trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_id,
> +                                     ss.r.width, ss.r.height, ss.r.x,
> ss.r.y);
> +
> +    scanout =3D &g->parent_obj.scanout[ss.scanout_id];
> +    g->parent_obj.enable =3D 1;
> +
> +    if (ss.resource_id =3D=3D 0) {
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
> +    g_autofree uint8_t *buf =3D NULL;
> +    size_t s;
> +
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(cs);
> +    trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size);
> +
> +    buf =3D g_new0(uint8_t, cs.size);
> +    s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> +                   sizeof(cs), buf, cs.size);
> +    CHECK((s =3D=3D cs.size), cmd);
> +
> +    result =3D rutabaga_submit_command(vr->rutabaga, cs.hdr.ctx_id, buf,
> cs.size);
> +    CHECK_RESULT(result, cmd);
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
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
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
> +    result =3D rutabaga_resource_transfer_write(vr->rutabaga, 0,
> t2d.resource_id,
> +                                              &transfer);
> +    CHECK_RESULT(result, cmd);
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
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
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
> +    result =3D rutabaga_resource_transfer_write(vr->rutabaga,
> t3d.hdr.ctx_id,
> +                                              t3d.resource_id, &transfer=
);
> +    CHECK_RESULT(result, cmd);
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
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
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
> +                                             t3d.resource_id, &transfer,
> NULL);
> +    CHECK_RESULT(result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_attach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command
> *cmd)
> +{
> +    struct rutabaga_iovecs vecs =3D { 0 };
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_attach_backing att_rb;
> +    struct iovec *res_iovs;
> +    uint32_t res_niov;
> +    int ret;
> +
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(att_rb);
> +    trace_virtio_gpu_cmd_res_back_attach(att_rb.resource_id);
> +
> +    res =3D virtio_gpu_find_resource(g, att_rb.resource_id);
> +    CHECK(res, cmd);
> +    CHECK(!res->iov, cmd);
> +
> +    ret =3D virtio_gpu_create_mapping_iov(g, att_rb.nr_entries,
> sizeof(att_rb),
> +                                        cmd, NULL, &res_iovs, &res_niov)=
;
> +    CHECK_RESULT(ret, cmd);
> +
> +    vecs.iovecs =3D res_iovs;
> +    vecs.num_iovecs =3D res_niov;
> +
> +    ret =3D rutabaga_resource_attach_backing(vr->rutabaga,
> att_rb.resource_id,
> +                                           &vecs);
> +    if (ret !=3D 0) {
> +        virtio_gpu_cleanup_mapping_iov(g, res_iovs, res_niov);
> +    }
> +}
> +
> +static void
> +rutabaga_cmd_detach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command
> *cmd)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_detach_backing detach_rb;
> +
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
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
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(att_res);
> +    trace_virtio_gpu_cmd_ctx_res_attach(att_res.hdr.ctx_id,
> +                                        att_res.resource_id);
> +
> +    result =3D rutabaga_context_attach_resource(vr->rutabaga,
> att_res.hdr.ctx_id,
> +                                              att_res.resource_id);
> +    CHECK_RESULT(result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_ctx_detach_resource(VirtIOGPU *g,
> +                                 struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_ctx_resource det_res;
> +
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(det_res);
> +    trace_virtio_gpu_cmd_ctx_res_detach(det_res.hdr.ctx_id,
> +                                        det_res.resource_id);
> +
> +    result =3D rutabaga_context_detach_resource(vr->rutabaga,
> det_res.hdr.ctx_id,
> +                                              det_res.resource_id);
> +    CHECK_RESULT(result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct virtio_gpu_ctrl_comman=
d
> *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_get_capset_info info;
> +    struct virtio_gpu_resp_capset_info resp;
> +
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(info);
> +
> +    result =3D rutabaga_get_capset_info(vr->rutabaga, info.capset_index,
> +                                      &resp.capset_id,
> &resp.capset_max_version,
> +                                      &resp.capset_max_size);
> +    CHECK_RESULT(result, cmd);
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
> +    uint32_t capset_size;
> +    uint32_t current_id;
> +    bool found =3D false;
> +
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(gc);
> +    for (uint32_t i =3D 0; i < vr->num_capsets; i++) {
> +        result =3D rutabaga_get_capset_info(vr->rutabaga, i,
> +                                          &current_id, &capset_size,
> +                                          &capset_size);
> +        CHECK_RESULT(result, cmd);
> +
> +        if (current_id =3D=3D gc.capset_id) {
> +            found =3D true;
> +            break;
> +        }
> +    }
> +
> +    if (!found) {
> +        error_report("capset not found!");
> +        return;
> +    }
> +
> +    resp =3D g_malloc0(sizeof(*resp) + capset_size);
> +    resp->hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET;
> +    rutabaga_get_capset(vr->rutabaga, gc.capset_id, gc.capset_version,
> +                       (uint8_t *)resp->capset_data, capset_size);
> +
> +    virtio_gpu_ctrl_response(g, cmd, &resp->hdr, sizeof(*resp) +
> capset_size);
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
> +    struct virtio_gpu_simple_resource *resource;
> +    struct virtio_gpu_resource_create_blob cblob;
> +    struct rutabaga_create_blob rc_blob =3D { 0 };
> +
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
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
> +                                               sizeof(cblob), cmd,
> &res->addrs,
> +                                               &res->iov, &res->iov_cnt)=
;
> +        CHECK_RESULT(result, cmd);
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
> +                                           cblob.resource_id, &rc_blob,
> &vecs,
> +                                           NULL);
> +    CHECK_RESULT(result, cmd);
> +    resource =3D g_steal_pointer(&res);
> +    QTAILQ_INSERT_HEAD(&g->reslist, resource, next);
> +}
> +
> +static void
> +rutabaga_cmd_resource_map_blob(VirtIOGPU *g,
> +                               struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    uint32_t slot =3D 0;
> +    struct virtio_gpu_simple_resource *res;
> +    struct rutabaga_mapping mapping =3D { 0 };
> +    struct virtio_gpu_resource_map_blob mblob;
> +    struct virtio_gpu_resp_map_info resp;
> +
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(mblob);
> +
> +    CHECK(mblob.resource_id !=3D 0, cmd);
> +
> +    res =3D virtio_gpu_find_resource(g, mblob.resource_id);
> +    CHECK(res, cmd);
> +
> +    result =3D rutabaga_resource_map(vr->rutabaga, mblob.resource_id,
> &mapping);
> +    CHECK_RESULT(result, cmd);
> +
> +    for (slot =3D 0; slot < MAX_SLOTS; slot++) {
> +        if (memory_regions[slot].used) {
> +            continue;
> +        }
> +
> +        MemoryRegion *mr =3D &(memory_regions[slot].mr);
> +        memory_region_init_ram_ptr(mr, NULL, "blob", mapping.size,
> +                                   (void *)mapping.ptr);
> +        memory_region_add_subregion(&g->parent_obj.hostmem,
> +                                    mblob.offset, mr);
> +        memory_regions[slot].resource_id =3D mblob.resource_id;
> +        memory_regions[slot].used =3D 1;
> +        break;
> +    }
> +
> +    CHECK((slot < MAX_SLOTS), cmd);
> +
> +    memset(&resp, 0, sizeof(resp));
> +    resp.hdr.type =3D VIRTIO_GPU_RESP_OK_MAP_INFO;
> +    result =3D rutabaga_resource_map_info(vr->rutabaga, mblob.resource_i=
d,
> +                                        &resp.map_info);
> +
> +    CHECK_RESULT(result, cmd);
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
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(ublob);
> +
> +    CHECK(ublob.resource_id !=3D 0, cmd);
> +
> +    res =3D virtio_gpu_find_resource(g, ublob.resource_id);
> +    CHECK(res, cmd);
> +
> +    for (slot =3D 0; slot < MAX_SLOTS; slot++) {
> +        if (memory_regions[slot].resource_id !=3D ublob.resource_id) {
> +            continue;
> +        }
> +
> +        MemoryRegion *mr =3D &(memory_regions[slot].mr);
> +        memory_region_del_subregion(&g->parent_obj.hostmem, mr);
> +
> +        memory_regions[slot].resource_id =3D 0;
> +        memory_regions[slot].used =3D 0;
> +        break;
> +    }
> +
> +    CHECK((slot < MAX_SLOTS), cmd);
> +    result =3D rutabaga_resource_unmap(vr->rutabaga, res->resource_id);
> +    CHECK_RESULT(result, cmd);
> +}
> +
> +static void
> +virtio_gpu_rutabaga_process_cmd(VirtIOGPU *g,
> +                                struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct rutabaga_fence fence =3D { 0 };
> +    int32_t result;
> +
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
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
> +        virtio_gpu_ctrl_response_nodata(g, cmd,
> VIRTIO_GPU_RESP_OK_NODATA);
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
> +    CHECK_RESULT(result, cmd);
> +}
> +
> +static void
> +virtio_gpu_rutabaga_aio_cb(void *opaque)
> +{
> +    struct rutabaga_aio_data *data =3D  (struct rutabaga_aio_data *)opaq=
ue;
> +    VirtIOGPU *g =3D (VirtIOGPU *)data->vr;
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
> +        virtio_gpu_ctrl_response_nodata(g, cmd,
> VIRTIO_GPU_RESP_OK_NODATA);
> +        QTAILQ_REMOVE(&g->fenceq, cmd, next);
> +        g_free(cmd);
> +    }
> +
> +    g_free(data);
> +}
> +
> +static void
> +virtio_gpu_rutabaga_fence_cb(uint64_t user_data,
> +                             struct rutabaga_fence fence_data) {
> +    struct rutabaga_aio_data *data;
> +    VirtIOGPU *g =3D (VirtIOGPU *)user_data;
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    /*
> +     * gfxstream and both cross-domain (and even newer versions
> virglrenderer:
> +     * see VIRGL_RENDERER_ASYNC_FENCE_CB) like to signal fence completio=
n
> on
> +     * threads ("callback threads") that are different from the thread
> that
> +     * processes the command queue ("main thread").
> +     *
> +     * crosvm and other virtio-gpu 1.1implementations enable callback
> threads
> +     * via locking.  However, on QEMU a deadlock is observed if
> +     * virtio_gpu_ctrl_response_nodata(..) [used in the fence callback]
> is used
> +     * from a thread that is not the main thread.
> +     *
> +     * The reason is QEMU's internal locking is designed to work with QE=
MU
> +     * threads (see rcu_register_thread()) and not generic C/C++/Rust
> threads.
> +     * For now, we can workaround this by scheduling the return of the
> +     * fence descriptors on the main thread.
> +     */
> +
> +    data =3D g_new0(struct rutabaga_aio_data, 1);
> +    data->vr =3D vr;
> +    data->fence =3D fence_data;
> +    aio_bh_schedule_oneshot_full(vr->ctx, virtio_gpu_rutabaga_aio_cb,
> +                                 (void *)data, "aio");
> +}
> +
> +static int virtio_gpu_rutabaga_init(VirtIOGPU *g)
> +{
> +    int result;
> +    uint64_t capset_mask;
> +    struct rutabaga_channels channels =3D { 0 };
> +    struct rutabaga_builder builder =3D { 0 };
> +
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +    vr->rutabaga =3D NULL;
> +
> +    if (!vr->capset_names) {
> +        return -EINVAL;
> +    }
> +
> +    builder.wsi =3D RUTABAGA_WSI_SURFACELESS;
> +    /*
> +     * Currently, if WSI is specified, the only valid strings are
> "surfaceless"
> +     * or "headless".  Surfaceless doesn't create a native window
> surface, but
> +     * does copy from the render target to the Pixman buffer if a
> virtio-gpu
> +     * 2D hypercall is issued.  Surfacless is the default.
> +     *
> +     * Headless is like surfaceless, but doesn't copy to the Pixman
> buffer. The
> +     * use case is automated testing environments where there is no need
> to view
> +     * results.
> +     *
> +     * In the future, more performant virtio-gpu 2D UI integration may b=
e
> added.
> +     */
> +    if (vr->wsi) {
> +        if (!strcmp(vr->wsi, "surfaceless")) {
>

g_str_equal() is a bit more readable


> +            vr->headless =3D false;
> +        } else if (strcmp(vr->wsi, "headless")) {
> +            vr->headless =3D true;
> +        } else {
> +            return -EINVAL;
> +        }
> +    }
> +
> +    result =3D rutabaga_calculate_capset_mask(vr->capset_names,
> &capset_mask);
> +    if (result) {
> +        return result;
> +    }
> +
> +    /*
> +     * rutabaga-0.1.1 is only compiled/tested with gfxstream and
> cross-domain
> +     * support. Future versions may change this to have more context
> types if
> +     * there is any interest.
> +     */
> +    if (capset_mask & (BIT(RUTABAGA_CAPSET_VIRGL) |
> +                       BIT(RUTABAGA_CAPSET_VIRGL2) |
> +                       BIT(RUTABAGA_CAPSET_VENUS) |
> +                       BIT(RUTABAGA_CAPSET_DRM))) {
> +        return -EINVAL;
> +    }
> +
> +    builder.user_data =3D (uint64_t)(uintptr_t *)(void *)g;
>

GPOINTER_TO_UINT(g) ?


> +    builder.fence_cb =3D virtio_gpu_rutabaga_fence_cb;
> +    builder.capset_mask =3D capset_mask;
> +
> +    if (vr->wayland_socket_path) {
> +        if ((builder.capset_mask & (1 << RUTABAGA_CAPSET_CROSS_DOMAIN))
> =3D=3D 0) {
> +            return -EINVAL;
> +        }
> +
> +        channels.channels =3D
> +          (struct rutabaga_channel *)calloc(1, sizeof(struct
> rutabaga_channel));
>

g_new0(struct ruabaga_channel, 1)


> +        channels.num_channels =3D 1;
> +        channels.channels[0].channel_name =3D vr->wayland_socket_path;
> +        channels.channels[0].channel_type =3D RUTABAGA_CHANNEL_TYPE_WAYL=
AND;
> +        builder.channels =3D &channels;
> +    }
> +
> +    result =3D rutabaga_init(&builder, &vr->rutabaga);
> +    if (builder.capset_mask & (1 << RUTABAGA_CAPSET_CROSS_DOMAIN)) {
> +        free(channels.channels);
>

g_free() (after switching to g_new)


> +    }
> +
> +    memset(&memory_regions, 0, MAX_SLOTS * sizeof(struct
> MemoryRegionInfo));
> +    vr->ctx =3D qemu_get_aio_context();
> +    return result;
> +}
> +
> +static int virtio_gpu_rutabaga_get_num_capsets(VirtIOGPU *g)
> +{
> +    int result;
> +    uint32_t num_capsets;
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    if (!vr->rutabaga_active) {
> +        result =3D virtio_gpu_rutabaga_init(g);
> +        if (result) {
> +            error_report("Failed to init rutabaga");
> +            return 0;
> +        }
> +
> +        vr->rutabaga_active =3D true;
> +    }
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
e
> *vq)
> +{
> +    VirtIOGPU *g =3D VIRTIO_GPU(vdev);
> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +    struct virtio_gpu_ctrl_command *cmd;
> +
> +    if (!virtio_queue_ready(vq)) {
> +        return;
> +    }
> +
> +    if (!vr->rutabaga_active) {
> +        int result =3D virtio_gpu_rutabaga_init(g);
> +        if (!result) {
> +            vr->rutabaga_active =3D true;
> +        }
> +    }
> +
> +    if (!vr->rutabaga_active) {
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
>

It would be simpler to call virtio_gpu_rutabaga_init() here, with Error
argument etc, instead of indirectly from other places.

+    num_capsets =3D virtio_gpu_rutabaga_get_num_capsets(gpudev);
> +    if (!num_capsets) {
> +        return;
> +    }
> +
> +#if HOST_BIG_ENDIAN
> +    error_setg(errp, "rutabaga is not supported on bigendian platforms")=
;
> +    return;
> +#endif
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
> +    DEFINE_PROP_STRING("capset_names", VirtioGpuRutabaga, capset_names),
> +    DEFINE_PROP_STRING("wayland_socket_path", VirtioGpuRutabaga,
> +                       wayland_socket_path),
> +    DEFINE_PROP_STRING("wsi", VirtioGpuRutabaga, wsi),
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
> +static const TypeInfo virtio_gpu_rutabaga_info =3D {
> +    .name =3D TYPE_VIRTIO_GPU_RUTABAGA,
> +    .parent =3D TYPE_VIRTIO_GPU,
> +    .instance_size =3D sizeof(VirtioGpuRutabaga),
> +    .class_init =3D virtio_gpu_rutabaga_class_init,
> +};
> +module_obj(TYPE_VIRTIO_GPU_RUTABAGA);
> +module_kconfig(VIRTIO_GPU);
> +
> +static void virtio_register_types(void)
> +{
> +    type_register_static(&virtio_gpu_rutabaga_info);
> +}
> +
> +type_init(virtio_register_types)
> +
> +module_dep("hw-display-virtio-gpu");
> diff --git a/hw/display/virtio-vga-rutabaga.c
> b/hw/display/virtio-vga-rutabaga.c
> new file mode 100644
> index 0000000000..01831bd03f
> --- /dev/null
> +++ b/hw/display/virtio-vga-rutabaga.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
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
> +typedef struct VirtIOVGARUTABAGA VirtIOVGARUTABAGA;
> +DECLARE_INSTANCE_CHECKER(VirtIOVGARUTABAGA, VIRTIO_VGA_RUTABAGA,
> +                         TYPE_VIRTIO_VGA_RUTABAGA)
> +
> +struct VirtIOVGARUTABAGA {
> +    VirtIOVGABase parent_obj;
> +
> +    VirtioGpuRutabaga   vdev;
> +};
> +
> +static void virtio_vga_rutabaga_inst_initfn(Object *obj)
> +{
> +    VirtIOVGARUTABAGA *dev =3D VIRTIO_VGA_RUTABAGA(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_GPU_RUTABAGA);
> +    VIRTIO_VGA_BASE(dev)->vgpu =3D VIRTIO_GPU_BASE(&dev->vdev);
> +}
> +
> +static VirtioPCIDeviceTypeInfo virtio_vga_rutabaga_info =3D {
> +    .generic_name  =3D TYPE_VIRTIO_VGA_RUTABAGA,
> +    .parent        =3D TYPE_VIRTIO_VGA_BASE,
> +    .instance_size =3D sizeof(VirtIOVGARUTABAGA),
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
> 2.41.0.255.g8b1d071c50-goog
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000061163006004f08b8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 11, 2023 at 6:57=E2=80=
=AFAM Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@chromium.org">gu=
rchetansingh@chromium.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">This adds initial support for gfxstream and cross-=
domain.=C2=A0 Both<br>
features rely on virtio-gpu blob resources and context types, which<br>
are also implemented in this patch.<br>
<br>
gfxstream has a long and illustrious history in Android graphics<br>
paravirtualization.=C2=A0 It has been powering graphics in the Android<br>
Studio Emulator for more than a decade, which is the main developer<br>
platform.<br>
<br>
Originally conceived by Jesse Hall, it was first known as &quot;EmuGL&quot;=
 [a].<br>
The key design characteristic was a 1:1 threading model and<br>
auto-generation, which fit nicely with the OpenGLES spec.=C2=A0 It also<br>
allowed easy layering with ANGLE on the host, which provides the GLES<br>
implementations on Windows or MacOS enviroments.<br>
<br>
gfxstream has traditionally been maintained by a single engineer, and<br>
between 2015 to 2021, the goldfish throne passed to Frank Yang.<br>
Historians often remark this glorious reign (&quot;pax gfxstreama&quot; is =
the<br>
academic term) was comparable to that of Augustus and the both Queen<br>
Elizabeths.=C2=A0 Just to name a few accomplishments in a resplendent<br>
panoply: higher versions of GLES, address space graphics, snapshot<br>
support and CTS compliant Vulkan [b].<br>
<br>
One major drawback was the use of out-of-tree goldfish drivers.<br>
Android engineers didn&#39;t know much about DRM/KMS and especially TTM so<=
br>
a simple guest to host pipe was conceived.<br>
<br>
Luckily, virtio-gpu 3D started to emerge in 2016 due to the work of<br>
the Mesa/virglrenderer communities.=C2=A0 In 2018, the initial virtio-gpu<b=
r>
port of gfxstream was done by Cuttlefish enthusiast Alistair Delva.<br>
It was a symbol compatible replacement of virglrenderer [c] and named<br>
&quot;AVDVirglrenderer&quot;.=C2=A0 This implementation forms the basis of =
the<br>
current gfxstream host implementation still in use today.<br>
<br>
cross-domain support follows a similar arc.=C2=A0 Originally conceived by<b=
r>
Wayland aficionado David Reveman and crosvm enjoyer Zach Reizner in<br>
2018, it initially relied on the downstream &quot;virtio-wl&quot; device.<b=
r>
<br>
In 2020 and 2021, virtio-gpu was extended to include blob resources<br>
and multiple timelines by yours truly, features gfxstream/cross-domain<br>
both require to function correctly.<br>
<br>
Right now, we stand at the precipice of a truly fantastic possibility:<br>
the Android Emulator powered by upstream QEMU and upstream Linux<br>
kernel.=C2=A0 gfxstream will then be packaged properfully, and app<br>
developers can even fix gfxstream bugs on their own if they encounter<br>
them.<br>
<br>
It&#39;s been quite the ride, my friends.=C2=A0 Where will gfxstream head n=
ext,<br>
nobody really knows.=C2=A0 I wouldn&#39;t be surprised if it&#39;s around f=
or<br>
another decade, maintained by a new generation of Android graphics<br>
enthusiasts.<br>
<br>
Technical details:<br>
=C2=A0 - Very simple initial display integration: just used Pixman<br>
=C2=A0 - Largely, 1:1 mapping of virtio-gpu hypercalls to rutabaga function=
<br>
=C2=A0 =C2=A0 calls<br>
<br></blockquote><div><br></div><div>Wow, this is not for the faint reader.=
. there is a lot to grasp in this gfx space...</div><div><br></div><div>Cou=
ld you perhaps extend on what this current code can do for an average Linux=
 VM? or for some Android VM (which one?!), and then what are the next steps=
 and status?<br></div><div>=C2=A0</div><div>My limited understanding (from =
this series and from <a href=3D"https://gitlab.com/qemu-project/qemu/-/issu=
es/1611">https://gitlab.com/qemu-project/qemu/-/issues/1611</a>) is that it=
 allows passing-through some vulkan APIs for off-screen usage. Is that accu=
rate?</div><div><br></div><div>How far are we from getting upstream QEMU to=
 be used by Android Emulator? (in the gfx domain at least) What would it ta=
ke to get the average Linux VM to use virtio-vga-rutabaga instead of virtio=
-vga-gl to get accelerated rendering?<br></div><div><br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
[a] <a href=3D"https://android-review.googlesource.com/c/platform/developme=
nt/+/34470" rel=3D"noreferrer" target=3D"_blank">https://android-review.goo=
glesource.com/c/platform/development/+/34470</a><br>
[b] <a href=3D"https://android-review.googlesource.com/q/topic:%22vulkan-ho=
stconnection-start%22" rel=3D"noreferrer" target=3D"_blank">https://android=
-review.googlesource.com/q/topic:%22vulkan-hostconnection-start%22</a><br>
[c] <a href=3D"https://android-review.googlesource.com/c/device/generic/gol=
dfish-opengl/+/761927" rel=3D"noreferrer" target=3D"_blank">https://android=
-review.googlesource.com/c/device/generic/goldfish-opengl/+/761927</a><br>
<br>
Signed-off-by: Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@chromiu=
m.org" target=3D"_blank">gurchetansingh@chromium.org</a>&gt;<br>
---<br>
v2: Incorported various suggestions by Akihiko Odaki and Bernard Berschow<b=
r>
=C2=A0 =C2=A0 - Removed GET_VIRTIO_GPU_GL / GET_RUTABAGA macros<br>
=C2=A0 =C2=A0 - Used error_report(..)<br>
=C2=A0 =C2=A0 - Used g_autofree to fix leaks on error paths<br>
=C2=A0 =C2=A0 - Removed unnecessary casts<br>
=C2=A0 =C2=A0 - added virtio-gpu-pci-rutabaga.c + virtio-vga-rutabaga.c fil=
es<br>
<br>
=C2=A0hw/display/virtio-gpu-pci-rutabaga.c |=C2=A0 =C2=A048 ++<br>
=C2=A0hw/display/virtio-gpu-rutabaga.c=C2=A0 =C2=A0 =C2=A0| 1088 ++++++++++=
++++++++++++++++<br>
=C2=A0hw/display/virtio-vga-rutabaga.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A052 =
++<br>
=C2=A03 files changed, 1188 insertions(+)<br>
=C2=A0create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c<br>
=C2=A0create mode 100644 hw/display/virtio-gpu-rutabaga.c<br>
=C2=A0create mode 100644 hw/display/virtio-vga-rutabaga.c<br>
<br>
diff --git a/hw/display/virtio-gpu-pci-rutabaga.c b/hw/display/virtio-gpu-p=
ci-rutabaga.c<br>
new file mode 100644<br>
index 0000000000..5765bef266<br>
--- /dev/null<br>
+++ b/hw/display/virtio-gpu-pci-rutabaga.c<br>
@@ -0,0 +1,48 @@<br>
+// SPDX-License-Identifier: GPL-2.0<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;qemu/module.h&quot;<br>
+#include &quot;hw/pci/pci.h&quot;<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/virtio/virtio.h&quot;<br>
+#include &quot;hw/virtio/virtio-bus.h&quot;<br>
+#include &quot;hw/virtio/virtio-gpu-pci.h&quot;<br>
+#include &quot;qom/object.h&quot;<br>
+<br>
+#define TYPE_VIRTIO_GPU_RUTABAGA_PCI &quot;virtio-gpu-rutabaga-pci&quot;<b=
r>
+typedef struct VirtIOGPURUTABAGAPCI VirtIOGPURUTABAGAPCI;<br>
+DECLARE_INSTANCE_CHECKER(VirtIOGPURUTABAGAPCI, VIRTIO_GPU_RUTABAGA_PCI,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0TYPE_VIRTIO_GPU_RUTABAGA_PCI)<br>
+<br>
+struct VirtIOGPURUTABAGAPCI {<br>
+=C2=A0 =C2=A0 VirtIOGPUPCIBase parent_obj;<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga=C2=A0 =C2=A0vdev;<br>
+};<br>
+<br>
+static void virtio_gpu_rutabaga_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 VirtIOGPURUTABAGAPCI *dev =3D VIRTIO_GPU_RUTABAGA_PCI(obj);<=
br>
+<br>
+=C2=A0 =C2=A0 virtio_instance_init_common(obj, &amp;dev-&gt;vdev, sizeof(d=
ev-&gt;vdev),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_VIRTIO_GPU_RUTABAGA);<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_PCI_BASE(obj)-&gt;vgpu =3D VIRTIO_GPU_BASE(&amp;d=
ev-&gt;vdev);<br>
+}<br>
+<br>
+static const VirtioPCIDeviceTypeInfo virtio_gpu_rutabaga_pci_info =3D {<br=
>
+=C2=A0 =C2=A0 .generic_name =3D TYPE_VIRTIO_GPU_RUTABAGA_PCI,<br>
+=C2=A0 =C2=A0 .parent =3D TYPE_VIRTIO_GPU_PCI_BASE,<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(VirtIOGPURUTABAGAPCI),<br>
+=C2=A0 =C2=A0 .instance_init =3D virtio_gpu_rutabaga_initfn,<br>
+};<br>
+module_obj(TYPE_VIRTIO_GPU_RUTABAGA_PCI);<br>
+module_kconfig(VIRTIO_PCI);<br>
+<br>
+static void virtio_gpu_rutabaga_pci_register_types(void)<br>
+{<br>
+=C2=A0 =C2=A0 virtio_pci_types_register(&amp;virtio_gpu_rutabaga_pci_info)=
;<br>
+}<br>
+<br>
+type_init(virtio_gpu_rutabaga_pci_register_types)<br>
+<br>
+module_dep(&quot;hw-display-virtio-gpu-pci&quot;);<br>
diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutab=
aga.c<br>
new file mode 100644<br>
index 0000000000..b60a30a093<br>
--- /dev/null<br>
+++ b/hw/display/virtio-gpu-rutabaga.c<br>
@@ -0,0 +1,1088 @@<br>
+// SPDX-License-Identifier: GPL-2.0<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/error-report.h&quot;<br>
+#include &quot;qemu/iov.h&quot;<br>
+#include &quot;trace.h&quot;<br>
+#include &quot;hw/virtio/virtio.h&quot;<br>
+#include &quot;hw/virtio/virtio-gpu.h&quot;<br>
+#include &quot;hw/virtio/virtio-gpu-pixman.h&quot;<br>
+#include &quot;hw/virtio/virtio-iommu.h&quot;<br>
+<br>
+#include &lt;glib/gmem.h&gt;<br>
+#include &lt;rutabaga_gfx/rutabaga_gfx_ffi.h&gt;<br>
+<br>
+#define CHECK(condition, cmd)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 do {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!condition) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;CHECK failed =
in %s() %s:&quot; &quot;%d&quot;, __func__,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0__FILE__, __LINE__);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;error =3D VIRTIO_GPU_RES=
P_ERR_UNSPEC;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 } while (0)<br>
+<br>
+#define CHECK_RESULT(result, cmd) CHECK(result =3D=3D 0, cmd)<br>
+<br>
+#define MAX_SLOTS 4096<br>
+<br>
+struct MemoryRegionInfo {<br>
+=C2=A0 =C2=A0 int used;<br>
+=C2=A0 =C2=A0 MemoryRegion mr;<br>
+=C2=A0 =C2=A0 uint32_t resource_id;<br>
+};<br>
+<br>
+static struct MemoryRegionInfo memory_regions[MAX_SLOTS];<br>
+<br>
+struct rutabaga_aio_data {<br>
+=C2=A0 =C2=A0 struct VirtioGpuRutabaga *vr;<br>
+=C2=A0 =C2=A0 struct rutabaga_fence fence;<br>
+};<br>
+<br>
+static void<br>
+virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, struct virtio_gpu_scanout =
*s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t resource_id)<br>
+{<br>
+=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *res;<br>
+=C2=A0 =C2=A0 struct rutabaga_transfer transfer =3D { 0 };<br>
+=C2=A0 =C2=A0 struct iovec transfer_iovec;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g, resource_id);<br>
+=C2=A0 =C2=A0 if (!res) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (res-&gt;width !=3D s-&gt;current_cursor-&gt;width ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res-&gt;height !=3D s-&gt;current_cursor-&gt;h=
eight) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 transfer.x =3D 0;<br>
+=C2=A0 =C2=A0 transfer.y =3D 0;<br>
+=C2=A0 =C2=A0 transfer.z =3D 0;<br>
+=C2=A0 =C2=A0 transfer.w =3D res-&gt;width;<br>
+=C2=A0 =C2=A0 transfer.h =3D res-&gt;height;<br>
+=C2=A0 =C2=A0 transfer.d =3D 1;<br>
+<br>
+=C2=A0 =C2=A0 transfer_iovec.iov_base =3D (void *)s-&gt;current_cursor-&gt=
;data;<br>
+=C2=A0 =C2=A0 transfer_iovec.iov_len =3D res-&gt;width * res-&gt;height * =
4;<br>
+<br>
+=C2=A0 =C2=A0 rutabaga_resource_transfer_read(vr-&gt;rutabaga, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_id, &amp;tran=
sfer,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;transfer_iovec);<=
br>
+}<br>
+<br>
+static void<br>
+virtio_gpu_rutabaga_gl_flushed(VirtIOGPUBase *b)<br>
+{<br>
+=C2=A0 =C2=A0 VirtIOGPU *g =3D VIRTIO_GPU(b);<br>
+=C2=A0 =C2=A0 virtio_gpu_process_cmdq(g);<br>
+}<br>
+<br>
+static void<br>
+rutabaga_cmd_create_resource_2d(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_ctrl_command *cmd)=
<br>
+{<br>
+=C2=A0 =C2=A0 int32_t result;<br>
+=C2=A0 =C2=A0 struct rutabaga_create_3d rc_3d =3D { 0 };<br>
+=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *res;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_resource_create_2d c2d;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(c2d);<br>
+=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_create_2d(c2d.resource_id, c2d.form=
at,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c2d.width=
, c2d.height);<br>
+<br>
+=C2=A0 =C2=A0 rc_3d.target =3D 2;<br>
+=C2=A0 =C2=A0 rc_3d.format =3D c2d.format;<br>
+=C2=A0 =C2=A0 rc_3d.bind =3D (1 &lt;&lt; 1);<br>
+=C2=A0 =C2=A0 rc_3d.width =3D c2d.width;<br>
+=C2=A0 =C2=A0 rc_3d.height =3D c2d.height;<br>
+=C2=A0 =C2=A0 rc_3d.depth =3D 1;<br>
+=C2=A0 =C2=A0 rc_3d.array_size =3D 1;<br>
+=C2=A0 =C2=A0 rc_3d.last_level =3D 0;<br>
+=C2=A0 =C2=A0 rc_3d.nr_samples =3D 0;<br>
+=C2=A0 =C2=A0 rc_3d.flags =3D VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_resource_create_3d(vr-&gt;rutabaga, c2d.=
resource_id, &amp;rc_3d);<br>
+=C2=A0 =C2=A0 CHECK_RESULT(result, cmd);<br>
+<br>
+=C2=A0 =C2=A0 res =3D g_new0(struct virtio_gpu_simple_resource, 1);<br>
+=C2=A0 =C2=A0 res-&gt;width =3D c2d.width;<br>
+=C2=A0 =C2=A0 res-&gt;height =3D c2d.height;<br>
+=C2=A0 =C2=A0 res-&gt;format =3D c2d.format;<br>
+=C2=A0 =C2=A0 res-&gt;resource_id =3D c2d.resource_id;<br>
+<br>
+=C2=A0 =C2=A0 QTAILQ_INSERT_HEAD(&amp;g-&gt;reslist, res, next);<br>
+}<br>
+<br>
+static void<br>
+rutabaga_cmd_create_resource_3d(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_ctrl_command *cmd)=
<br>
+{<br>
+=C2=A0 =C2=A0 int32_t result;<br>
+=C2=A0 =C2=A0 struct rutabaga_create_3d rc_3d =3D { 0 };<br>
+=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *res;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_resource_create_3d c3d;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(c3d);<br>
+<br>
+=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_create_3d(c3d.resource_id, c3d.form=
at,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c3d.width=
, c3d.height, c3d.depth);<br>
+<br>
+=C2=A0 =C2=A0 rc_3d.target =3D c3d.target;<br>
+=C2=A0 =C2=A0 rc_3d.format =3D c3d.format;<br>
+=C2=A0 =C2=A0 rc_3d.bind =3D c3d.bind;<br>
+=C2=A0 =C2=A0 rc_3d.width =3D c3d.width;<br>
+=C2=A0 =C2=A0 rc_3d.height =3D c3d.height;<br>
+=C2=A0 =C2=A0 rc_3d.depth =3D c3d.depth;<br>
+=C2=A0 =C2=A0 rc_3d.array_size =3D c3d.array_size;<br>
+=C2=A0 =C2=A0 rc_3d.last_level =3D c3d.last_level;<br>
+=C2=A0 =C2=A0 rc_3d.nr_samples =3D c3d.nr_samples;<br>
+=C2=A0 =C2=A0 rc_3d.flags =3D c3d.flags;<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_resource_create_3d(vr-&gt;rutabaga, c3d.=
resource_id, &amp;rc_3d);<br>
+=C2=A0 =C2=A0 CHECK_RESULT(result, cmd);<br>
+<br>
+=C2=A0 =C2=A0 res =3D g_new0(struct virtio_gpu_simple_resource, 1);<br>
+=C2=A0 =C2=A0 res-&gt;width =3D c3d.width;<br>
+=C2=A0 =C2=A0 res-&gt;height =3D c3d.height;<br>
+=C2=A0 =C2=A0 res-&gt;format =3D c3d.format;<br>
+=C2=A0 =C2=A0 res-&gt;resource_id =3D c3d.resource_id;<br>
+<br>
+=C2=A0 =C2=A0 QTAILQ_INSERT_HEAD(&amp;g-&gt;reslist, res, next);<br>
+}<br>
+<br>
+static void<br>
+rutabaga_cmd_resource_unref(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_ctrl_command *cmd)<br>
+{<br>
+=C2=A0 =C2=A0 int32_t result;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *res;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_resource_unref unref;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(unref);<br>
+<br>
+=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_unref(unref.resource_id);<br>
+<br>
+=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g, unref.resource_id);<br>
+=C2=A0 =C2=A0 CHECK(res, cmd);<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_resource_unref(vr-&gt;rutabaga, unref.re=
source_id);<br>
+=C2=A0 =C2=A0 CHECK_RESULT(result, cmd);<br>
+<br>
+=C2=A0 =C2=A0 if (res-&gt;image) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pixman_image_unref(res-&gt;image);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 QTAILQ_REMOVE(&amp;g-&gt;reslist, res, next);<br>
+=C2=A0 =C2=A0 g_free(res);<br>
+}<br>
+<br>
+static void<br>
+rutabaga_cmd_context_create(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_ctrl_command *cmd)<br>
+{<br>
+=C2=A0 =C2=A0 int32_t result;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_ctx_create cc;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(cc);<br>
+=C2=A0 =C2=A0 trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cc.debug_name);<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_context_create(vr-&gt;rutabaga, cc.hdr.c=
tx_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc.context_init,=
 cc.debug_name, cc.nlen);<br>
+=C2=A0 =C2=A0 CHECK_RESULT(result, cmd);<br>
+}<br>
+<br>
+static void<br>
+rutabaga_cmd_context_destroy(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_command *cmd)<br>
+{<br>
+=C2=A0 =C2=A0 int32_t result;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_ctx_destroy cd;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(cd);<br>
+=C2=A0 =C2=A0 trace_virtio_gpu_cmd_ctx_destroy(cd.hdr.ctx_id);<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_context_destroy(vr-&gt;rutabaga, cd.hdr.=
ctx_id);<br>
+=C2=A0 =C2=A0 CHECK_RESULT(result, cmd);<br>
+}<br>
+<br>
+static void<br>
+rutabaga_cmd_resource_flush(VirtIOGPU *g, struct virtio_gpu_ctrl_command *=
cmd)<br>
+{<br>
+=C2=A0 =C2=A0 int32_t result, i;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_scanout *scanout =3D NULL;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *res;<br>
+=C2=A0 =C2=A0 struct rutabaga_transfer transfer =3D { 0 };<br>
+=C2=A0 =C2=A0 struct iovec transfer_iovec;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_resource_flush rf;<br>
+=C2=A0 =C2=A0 bool found =3D false;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+=C2=A0 =C2=A0 if (vr-&gt;headless) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(rf);<br>
+=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_flush(rf.resource_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rf.r.width, rf.r.height=
, rf.r.x, rf.r.y);<br>
+<br>
+=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g, rf.resource_id);<br>
+=C2=A0 =C2=A0 CHECK(res, cmd);<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; g-&gt;parent_obj.conf.max_outputs; i++)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scanout =3D &amp;g-&gt;parent_obj.scanout[i];<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D res-&gt;scanout_bitmask) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 found =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!found) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 transfer.x =3D 0;<br>
+=C2=A0 =C2=A0 transfer.y =3D 0;<br>
+=C2=A0 =C2=A0 transfer.z =3D 0;<br>
+=C2=A0 =C2=A0 transfer.w =3D res-&gt;width;<br>
+=C2=A0 =C2=A0 transfer.h =3D res-&gt;height;<br>
+=C2=A0 =C2=A0 transfer.d =3D 1;<br>
+<br>
+=C2=A0 =C2=A0 transfer_iovec.iov_base =3D (void *)pixman_image_get_data(re=
s-&gt;image);<br>
+=C2=A0 =C2=A0 transfer_iovec.iov_len =3D res-&gt;width * res-&gt;height * =
4;<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_resource_transfer_read(vr-&gt;rutabaga, =
0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0rf.resource_id, &amp;transfer,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&amp;transfer_iovec);<br>
+=C2=A0 =C2=A0 CHECK_RESULT(result, cmd);<br>
+=C2=A0 =C2=A0 dpy_gfx_update_full(scanout-&gt;con);<br>
+}<br>
+<br>
+static void<br>
+rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd=
)<br>
+{<br>
+=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *res;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_scanout *scanout =3D NULL;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_set_scanout ss;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+=C2=A0 =C2=A0 if (vr-&gt;headless) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(ss);<br>
+=C2=A0 =C2=A0 trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_=
id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ss.r.width, ss.r=
.height, ss.r.x, ss.r.y);<br>
+<br>
+=C2=A0 =C2=A0 scanout =3D &amp;g-&gt;parent_obj.scanout[ss.scanout_id];<br=
>
+=C2=A0 =C2=A0 g-&gt;parent_obj.enable =3D 1;<br>
+<br>
+=C2=A0 =C2=A0 if (ss.resource_id =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g, ss.resource_id);<br>
+=C2=A0 =C2=A0 CHECK(res, cmd);<br>
+<br>
+=C2=A0 =C2=A0 if (!res-&gt;image) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pixman_format_code_t pformat;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pformat =3D virtio_gpu_get_pixman_format(res-&=
gt;format);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHECK(pformat, cmd);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res-&gt;image =3D pixman_image_create_bits(pfo=
rmat,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 res-&gt;width,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 res-&gt;height,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 NULL, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHECK(res-&gt;image, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pixman_image_ref(res-&gt;image);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* realloc the surface ptr */<br>
+=C2=A0 =C2=A0 scanout-&gt;ds =3D qemu_create_displaysurface_pixman(res-&gt=
;image);<br>
+=C2=A0 =C2=A0 dpy_gfx_replace_surface(scanout-&gt;con, NULL);<br>
+=C2=A0 =C2=A0 dpy_gfx_replace_surface(scanout-&gt;con, scanout-&gt;ds);<br=
>
+=C2=A0 =C2=A0 res-&gt;scanout_bitmask =3D ss.scanout_id;<br>
+}<br>
+<br>
+static void<br>
+rutabaga_cmd_submit_3d(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct virtio_gpu_ctrl_command *cmd)<br>
+{<br>
+=C2=A0 =C2=A0 int32_t result;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_cmd_submit cs;<br>
+=C2=A0 =C2=A0 g_autofree uint8_t *buf =3D NULL;<br>
+=C2=A0 =C2=A0 size_t s;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(cs);<br>
+=C2=A0 =C2=A0 trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size);<br>
+<br>
+=C2=A0 =C2=A0 buf =3D g_new0(uint8_t, cs.size);<br>
+=C2=A0 =C2=A0 s =3D iov_to_buf(cmd-&gt;elem.out_sg, cmd-&gt;elem.out_num,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeo=
f(cs), buf, cs.size);<br>
+=C2=A0 =C2=A0 CHECK((s =3D=3D cs.size), cmd);<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_submit_command(vr-&gt;rutabaga, cs.hdr.c=
tx_id, buf, cs.size);<br>
+=C2=A0 =C2=A0 CHECK_RESULT(result, cmd);<br>
+}<br>
+<br>
+static void<br>
+rutabaga_cmd_transfer_to_host_2d(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_command=
 *cmd)<br>
+{<br>
+=C2=A0 =C2=A0 int32_t result;<br>
+=C2=A0 =C2=A0 struct rutabaga_transfer transfer =3D { 0 };<br>
+=C2=A0 =C2=A0 struct virtio_gpu_transfer_to_host_2d t2d;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(t2d);<br>
+=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_xfer_toh_2d(t2d.resource_id);<br>
+<br>
+=C2=A0 =C2=A0 transfer.x =3D t2d.r.x;<br>
+=C2=A0 =C2=A0 transfer.y =3D t2d.r.y;<br>
+=C2=A0 =C2=A0 transfer.z =3D 0;<br>
+=C2=A0 =C2=A0 transfer.w =3D t2d.r.width;<br>
+=C2=A0 =C2=A0 transfer.h =3D t2d.r.height;<br>
+=C2=A0 =C2=A0 transfer.d =3D 1;<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_resource_transfer_write(vr-&gt;rutabaga,=
 0, t2d.resource_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &amp;transfer);<br>
+=C2=A0 =C2=A0 CHECK_RESULT(result, cmd);<br>
+}<br>
+<br>
+static void<br>
+rutabaga_cmd_transfer_to_host_3d(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_command=
 *cmd)<br>
+{<br>
+=C2=A0 =C2=A0 int32_t result;<br>
+=C2=A0 =C2=A0 struct rutabaga_transfer transfer =3D { 0 };<br>
+=C2=A0 =C2=A0 struct virtio_gpu_transfer_host_3d t3d;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(t3d);<br>
+=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_xfer_toh_3d(t3d.resource_id);<br>
+<br>
+=C2=A0 =C2=A0 transfer.x =3D t3d.box.x;<br>
+=C2=A0 =C2=A0 transfer.y =3D t3d.box.y;<br>
+=C2=A0 =C2=A0 transfer.z =3D t3d.box.z;<br>
+=C2=A0 =C2=A0 transfer.w =3D t3d.box.w;<br>
+=C2=A0 =C2=A0 transfer.h =3D t3d.box.h;<br>
+=C2=A0 =C2=A0 transfer.d =3D t3d.box.d;<br>
+=C2=A0 =C2=A0 transfer.level =3D t3d.level;<br>
+=C2=A0 =C2=A0 transfer.stride =3D t3d.stride;<br>
+=C2=A0 =C2=A0 transfer.layer_stride =3D t3d.layer_stride;<br>
+=C2=A0 =C2=A0 transfer.offset =3D t3d.offset;<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_resource_transfer_write(vr-&gt;rutabaga,=
 t3d.hdr.ctx_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 t3d.resource_id, &amp;transfer);<br>
+=C2=A0 =C2=A0 CHECK_RESULT(result, cmd);<br>
+}<br>
+<br>
+static void<br>
+rutabaga_cmd_transfer_from_host_3d(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_=
command *cmd)<br>
+{<br>
+=C2=A0 =C2=A0 int32_t result;<br>
+=C2=A0 =C2=A0 struct rutabaga_transfer transfer =3D { 0 };<br>
+=C2=A0 =C2=A0 struct virtio_gpu_transfer_host_3d t3d;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(t3d);<br>
+=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_xfer_fromh_3d(t3d.resource_id);<br>
+<br>
+=C2=A0 =C2=A0 transfer.x =3D t3d.box.x;<br>
+=C2=A0 =C2=A0 transfer.y =3D t3d.box.y;<br>
+=C2=A0 =C2=A0 transfer.z =3D t3d.box.z;<br>
+=C2=A0 =C2=A0 transfer.w =3D t3d.box.w;<br>
+=C2=A0 =C2=A0 transfer.h =3D t3d.box.h;<br>
+=C2=A0 =C2=A0 transfer.d =3D t3d.box.d;<br>
+=C2=A0 =C2=A0 transfer.level =3D t3d.level;<br>
+=C2=A0 =C2=A0 transfer.stride =3D t3d.stride;<br>
+=C2=A0 =C2=A0 transfer.layer_stride =3D t3d.layer_stride;<br>
+=C2=A0 =C2=A0 transfer.offset =3D t3d.offset;<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_resource_transfer_read(vr-&gt;rutabaga, =
t3d.hdr.ctx_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0t3d.resource_id, &amp;transfer, NULL);<br>
+=C2=A0 =C2=A0 CHECK_RESULT(result, cmd);<br>
+}<br>
+<br>
+static void<br>
+rutabaga_cmd_attach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command *=
cmd)<br>
+{<br>
+=C2=A0 =C2=A0 struct rutabaga_iovecs vecs =3D { 0 };<br>
+=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *res;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_resource_attach_backing att_rb;<br>
+=C2=A0 =C2=A0 struct iovec *res_iovs;<br>
+=C2=A0 =C2=A0 uint32_t res_niov;<br>
+=C2=A0 =C2=A0 int ret;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(att_rb);<br>
+=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_back_attach(att_rb.resource_id);<br=
>
+<br>
+=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g, att_rb.resource_id);<br>
+=C2=A0 =C2=A0 CHECK(res, cmd);<br>
+=C2=A0 =C2=A0 CHECK(!res-&gt;iov, cmd);<br>
+<br>
+=C2=A0 =C2=A0 ret =3D virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, =
sizeof(att_rb),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd, NUL=
L, &amp;res_iovs, &amp;res_niov);<br>
+=C2=A0 =C2=A0 CHECK_RESULT(ret, cmd);<br>
+<br>
+=C2=A0 =C2=A0 vecs.iovecs =3D res_iovs;<br>
+=C2=A0 =C2=A0 vecs.num_iovecs =3D res_niov;<br>
+<br>
+=C2=A0 =C2=A0 ret =3D rutabaga_resource_attach_backing(vr-&gt;rutabaga, at=
t_rb.resource_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&amp;vecs);<br>
+=C2=A0 =C2=A0 if (ret !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_cleanup_mapping_iov(g, res_iovs, re=
s_niov);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void<br>
+rutabaga_cmd_detach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command *=
cmd)<br>
+{<br>
+=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *res;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_resource_detach_backing detach_rb;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(detach_rb);<br>
+=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_back_detach(detach_rb.resource_id);=
<br>
+<br>
+=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g, detach_rb.resource_id);<=
br>
+=C2=A0 =C2=A0 CHECK(res, cmd);<br>
+<br>
+=C2=A0 =C2=A0 rutabaga_resource_detach_backing(vr-&gt;rutabaga,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0detach_rb.resour=
ce_id);<br>
+<br>
+=C2=A0 =C2=A0 virtio_gpu_cleanup_mapping(g, res);<br>
+}<br>
+<br>
+static void<br>
+rutabaga_cmd_ctx_attach_resource(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_command=
 *cmd)<br>
+{<br>
+=C2=A0 =C2=A0 int32_t result;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_ctx_resource att_res;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(att_res);<br>
+=C2=A0 =C2=A0 trace_virtio_gpu_cmd_ctx_res_attach(att_res.hdr.ctx_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 att_res.=
resource_id);<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_context_attach_resource(vr-&gt;rutabaga,=
 att_res.hdr.ctx_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 att_res.resource_id);<br>
+=C2=A0 =C2=A0 CHECK_RESULT(result, cmd);<br>
+}<br>
+<br>
+static void<br>
+rutabaga_cmd_ctx_detach_resource(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_command=
 *cmd)<br>
+{<br>
+=C2=A0 =C2=A0 int32_t result;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_ctx_resource det_res;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(det_res);<br>
+=C2=A0 =C2=A0 trace_virtio_gpu_cmd_ctx_res_detach(det_res.hdr.ctx_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 det_res.=
resource_id);<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_context_detach_resource(vr-&gt;rutabaga,=
 det_res.hdr.ctx_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 det_res.resource_id);<br>
+=C2=A0 =C2=A0 CHECK_RESULT(result, cmd);<br>
+}<br>
+<br>
+static void<br>
+rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct virtio_gpu_ctrl_command =
*cmd)<br>
+{<br>
+=C2=A0 =C2=A0 int32_t result;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_get_capset_info info;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_resp_capset_info resp;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(info);<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_get_capset_info(vr-&gt;rutabaga, info.ca=
pset_index,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;resp.capse=
t_id, &amp;resp.capset_max_version,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;resp.capse=
t_max_size);<br>
+=C2=A0 =C2=A0 CHECK_RESULT(result, cmd);<br>
+<br>
+=C2=A0 =C2=A0 resp.hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET_INFO;<br>
+=C2=A0 =C2=A0 virtio_gpu_ctrl_response(g, cmd, &amp;resp.hdr, sizeof(resp)=
);<br>
+}<br>
+<br>
+static void<br>
+rutabaga_cmd_get_capset(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)=
<br>
+{<br>
+=C2=A0 =C2=A0 int32_t result;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_get_capset gc;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_resp_capset *resp;<br>
+=C2=A0 =C2=A0 uint32_t capset_size;<br>
+=C2=A0 =C2=A0 uint32_t current_id;<br>
+=C2=A0 =C2=A0 bool found =3D false;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(gc);<br>
+=C2=A0 =C2=A0 for (uint32_t i =3D 0; i &lt; vr-&gt;num_capsets; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D rutabaga_get_capset_info(vr-&gt;rut=
abaga, i,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
amp;current_id, &amp;capset_size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
amp;capset_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHECK_RESULT(result, cmd);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (current_id =3D=3D gc.capset_id) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 found =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!found) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;capset not found!&quot;);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 resp =3D g_malloc0(sizeof(*resp) + capset_size);<br>
+=C2=A0 =C2=A0 resp-&gt;hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET;<br>
+=C2=A0 =C2=A0 rutabaga_get_capset(vr-&gt;rutabaga, gc.capset_id, gc.capset=
_version,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(uint8_t *)resp-&gt;capset_data, capset_size);<br>
+<br>
+=C2=A0 =C2=A0 virtio_gpu_ctrl_response(g, cmd, &amp;resp-&gt;hdr, sizeof(*=
resp) + capset_size);<br>
+=C2=A0 =C2=A0 g_free(resp);<br>
+}<br>
+<br>
+static void<br>
+rutabaga_cmd_resource_create_blob(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_ctrl_comman=
d *cmd)<br>
+{<br>
+=C2=A0 =C2=A0 int result;<br>
+=C2=A0 =C2=A0 struct rutabaga_iovecs vecs =3D { 0 };<br>
+=C2=A0 =C2=A0 g_autofree struct virtio_gpu_simple_resource *res =3D NULL;<=
br>
+=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *resource;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_resource_create_blob cblob;<br>
+=C2=A0 =C2=A0 struct rutabaga_create_blob rc_blob =3D { 0 };<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(cblob);<br>
+=C2=A0 =C2=A0 trace_virtio_gpu_cmd_res_create_blob(cblob.resource_id, cblo=
b.size);<br>
+<br>
+=C2=A0 =C2=A0 CHECK(cblob.resource_id !=3D 0, cmd);<br>
+<br>
+=C2=A0 =C2=A0 res =3D g_new0(struct virtio_gpu_simple_resource, 1);<br>
+<br>
+=C2=A0 =C2=A0 res-&gt;resource_id =3D cblob.resource_id;<br>
+=C2=A0 =C2=A0 res-&gt;blob_size =3D cblob.size;<br>
+<br>
+=C2=A0 =C2=A0 if (cblob.blob_mem !=3D VIRTIO_GPU_BLOB_MEM_HOST3D) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D virtio_gpu_create_mapping_iov(g, cb=
lob.nr_entries,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sizeof(cblob), cmd, &amp;res-&gt;addrs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&amp;res-&gt;iov, &amp;res-&gt;iov_cnt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHECK_RESULT(result, cmd);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 rc_blob.blob_id =3D cblob.blob_id;<br>
+=C2=A0 =C2=A0 rc_blob.blob_mem =3D cblob.blob_mem;<br>
+=C2=A0 =C2=A0 rc_blob.blob_flags =3D cblob.blob_flags;<br>
+=C2=A0 =C2=A0 rc_blob.size =3D cblob.size;<br>
+<br>
+=C2=A0 =C2=A0 vecs.iovecs =3D res-&gt;iov;<br>
+=C2=A0 =C2=A0 vecs.num_iovecs =3D res-&gt;iov_cnt;<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_resource_create_blob(vr-&gt;rutabaga, cb=
lob.hdr.ctx_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0cblob.resource_id, &amp;rc_blob, &amp;vecs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0NULL);<br>
+=C2=A0 =C2=A0 CHECK_RESULT(result, cmd);<br>
+=C2=A0 =C2=A0 resource =3D g_steal_pointer(&amp;res);<br>
+=C2=A0 =C2=A0 QTAILQ_INSERT_HEAD(&amp;g-&gt;reslist, resource, next);<br>
+}<br>
+<br>
+static void<br>
+rutabaga_cmd_resource_map_blob(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_command *cmd)<=
br>
+{<br>
+=C2=A0 =C2=A0 int32_t result;<br>
+=C2=A0 =C2=A0 uint32_t slot =3D 0;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *res;<br>
+=C2=A0 =C2=A0 struct rutabaga_mapping mapping =3D { 0 };<br>
+=C2=A0 =C2=A0 struct virtio_gpu_resource_map_blob mblob;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_resp_map_info resp;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(mblob);<br>
+<br>
+=C2=A0 =C2=A0 CHECK(mblob.resource_id !=3D 0, cmd);<br>
+<br>
+=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g, mblob.resource_id);<br>
+=C2=A0 =C2=A0 CHECK(res, cmd);<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_resource_map(vr-&gt;rutabaga, mblob.reso=
urce_id, &amp;mapping);<br>
+=C2=A0 =C2=A0 CHECK_RESULT(result, cmd);<br>
+<br>
+=C2=A0 =C2=A0 for (slot =3D 0; slot &lt; MAX_SLOTS; slot++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (memory_regions[slot].used) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 MemoryRegion *mr =3D &amp;(memory_regions[slot=
].mr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_init_ram_ptr(mr, NULL, &quot;blo=
b&quot;, mapping.size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)mapping.ptr);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(&amp;g-&gt;parent_=
obj.hostmem,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mblob.offset, mr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_regions[slot].resource_id =3D mblob.res=
ource_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_regions[slot].used =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 CHECK((slot &lt; MAX_SLOTS), cmd);<br>
+<br>
+=C2=A0 =C2=A0 memset(&amp;resp, 0, sizeof(resp));<br>
+=C2=A0 =C2=A0 resp.hdr.type =3D VIRTIO_GPU_RESP_OK_MAP_INFO;<br>
+=C2=A0 =C2=A0 result =3D rutabaga_resource_map_info(vr-&gt;rutabaga, mblob=
.resource_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;res=
p.map_info);<br>
+<br>
+=C2=A0 =C2=A0 CHECK_RESULT(result, cmd);<br>
+=C2=A0 =C2=A0 virtio_gpu_ctrl_response(g, cmd, &amp;resp.hdr, sizeof(resp)=
);<br>
+}<br>
+<br>
+static void<br>
+rutabaga_cmd_resource_unmap_blob(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_command=
 *cmd)<br>
+{<br>
+=C2=A0 =C2=A0 int32_t result;<br>
+=C2=A0 =C2=A0 uint32_t slot =3D 0;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_simple_resource *res;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_resource_unmap_blob ublob;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(ublob);<br>
+<br>
+=C2=A0 =C2=A0 CHECK(ublob.resource_id !=3D 0, cmd);<br>
+<br>
+=C2=A0 =C2=A0 res =3D virtio_gpu_find_resource(g, ublob.resource_id);<br>
+=C2=A0 =C2=A0 CHECK(res, cmd);<br>
+<br>
+=C2=A0 =C2=A0 for (slot =3D 0; slot &lt; MAX_SLOTS; slot++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (memory_regions[slot].resource_id !=3D ublo=
b.resource_id) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 MemoryRegion *mr =3D &amp;(memory_regions[slot=
].mr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_del_subregion(&amp;g-&gt;parent_=
obj.hostmem, mr);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_regions[slot].resource_id =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_regions[slot].used =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 CHECK((slot &lt; MAX_SLOTS), cmd);<br>
+=C2=A0 =C2=A0 result =3D rutabaga_resource_unmap(vr-&gt;rutabaga, res-&gt;=
resource_id);<br>
+=C2=A0 =C2=A0 CHECK_RESULT(result, cmd);<br>
+}<br>
+<br>
+static void<br>
+virtio_gpu_rutabaga_process_cmd(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_ctrl_command *cmd)=
<br>
+{<br>
+=C2=A0 =C2=A0 struct rutabaga_fence fence =3D { 0 };<br>
+=C2=A0 =C2=A0 int32_t result;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(cmd-&gt;cmd_hdr);<br>
+<br>
+=C2=A0 =C2=A0 switch (cmd-&gt;cmd_hdr.type) {<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_CTX_CREATE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_context_create(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_CTX_DESTROY:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_context_destroy(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_CREATE_2D:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_create_resource_2d(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_CREATE_3D:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_create_resource_3d(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_SUBMIT_3D:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_submit_3d(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_transfer_to_host_2d(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_transfer_to_host_3d(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_transfer_from_host_3d(g, cmd);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_attach_backing(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_detach_backing(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_SET_SCANOUT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_set_scanout(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_FLUSH:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_resource_flush(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_UNREF:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_resource_unref(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_ctx_attach_resource(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_ctx_detach_resource(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_GET_CAPSET_INFO:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_get_capset_info(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_GET_CAPSET:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_get_capset(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_get_display_info(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_GET_EDID:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_get_edid(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_resource_create_blob(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_resource_map_blob(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_cmd_resource_unmap_blob(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (cmd-&gt;finished) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (cmd-&gt;error) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: ctrl 0x%x, error 0x%x&q=
uot;, __func__,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0cmd-&gt;cmd_hdr.type, cmd-&gt;error);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_ctrl_response_nodata(g, cmd, cmd-&g=
t;error);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (!(cmd-&gt;cmd_hdr.flags &amp; VIRTIO_GPU_FLAG_FENCE)) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO=
_GPU_RESP_OK_NODATA);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 fence.flags =3D cmd-&gt;cmd_hdr.flags;<br>
+=C2=A0 =C2=A0 fence.ctx_id =3D cmd-&gt;cmd_hdr.ctx_id;<br>
+=C2=A0 =C2=A0 fence.fence_id =3D cmd-&gt;cmd_hdr.fence_id;<br>
+=C2=A0 =C2=A0 fence.ring_idx =3D cmd-&gt;cmd_hdr.ring_idx;<br>
+<br>
+=C2=A0 =C2=A0 trace_virtio_gpu_fence_ctrl(cmd-&gt;cmd_hdr.fence_id, cmd-&g=
t;cmd_hdr.type);<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_create_fence(vr-&gt;rutabaga, &amp;fence=
);<br>
+=C2=A0 =C2=A0 CHECK_RESULT(result, cmd);<br>
+}<br>
+<br>
+static void<br>
+virtio_gpu_rutabaga_aio_cb(void *opaque)<br>
+{<br>
+=C2=A0 =C2=A0 struct rutabaga_aio_data *data =3D=C2=A0 (struct rutabaga_ai=
o_data *)opaque;<br>
+=C2=A0 =C2=A0 VirtIOGPU *g =3D (VirtIOGPU *)data-&gt;vr;<br>
+=C2=A0 =C2=A0 struct rutabaga_fence fence_data =3D data-&gt;fence;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_ctrl_command *cmd, *tmp;<br>
+<br>
+=C2=A0 =C2=A0 uint32_t signaled_ctx_specific =3D fence_data.flags &amp;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RUTABAGA_FLAG_IN=
FO_RING_IDX;<br>
+<br>
+=C2=A0 =C2=A0 QTAILQ_FOREACH_SAFE(cmd, &amp;g-&gt;fenceq, next, tmp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Due to context specific timelines.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t target_ctx_specific =3D cmd-&gt;cmd_h=
dr.flags &amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RUTABAGA_=
FLAG_INFO_RING_IDX;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (signaled_ctx_specific !=3D target_ctx_spec=
ific) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (signaled_ctx_specific &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(cmd-&gt;cmd_hdr.ring_idx !=3D fe=
nce_data.ring_idx)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cmd-&gt;cmd_hdr.fence_id &gt; fence_data.f=
ence_id) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_virtio_gpu_fence_resp(cmd-&gt;cmd_hdr.fe=
nce_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO=
_GPU_RESP_OK_NODATA);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QTAILQ_REMOVE(&amp;g-&gt;fenceq, cmd, next);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(cmd);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 g_free(data);<br>
+}<br>
+<br>
+static void<br>
+virtio_gpu_rutabaga_fence_cb(uint64_t user_data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rutabaga_fence fence_data) {<br>
+=C2=A0 =C2=A0 struct rutabaga_aio_data *data;<br>
+=C2=A0 =C2=A0 VirtIOGPU *g =3D (VirtIOGPU *)user_data;<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* gfxstream and both cross-domain (and even newer vers=
ions virglrenderer:<br>
+=C2=A0 =C2=A0 =C2=A0* see VIRGL_RENDERER_ASYNC_FENCE_CB) like to signal fe=
nce completion on<br>
+=C2=A0 =C2=A0 =C2=A0* threads (&quot;callback threads&quot;) that are diff=
erent from the thread that<br>
+=C2=A0 =C2=A0 =C2=A0* processes the command queue (&quot;main thread&quot;=
).<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* crosvm and other virtio-gpu 1.1implementations enabl=
e callback threads<br>
+=C2=A0 =C2=A0 =C2=A0* via locking.=C2=A0 However, on QEMU a deadlock is ob=
served if<br>
+=C2=A0 =C2=A0 =C2=A0* virtio_gpu_ctrl_response_nodata(..) [used in the fen=
ce callback] is used<br>
+=C2=A0 =C2=A0 =C2=A0* from a thread that is not the main thread.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* The reason is QEMU&#39;s internal locking is designe=
d to work with QEMU<br>
+=C2=A0 =C2=A0 =C2=A0* threads (see rcu_register_thread()) and not generic =
C/C++/Rust threads.<br>
+=C2=A0 =C2=A0 =C2=A0* For now, we can workaround this by scheduling the re=
turn of the<br>
+=C2=A0 =C2=A0 =C2=A0* fence descriptors on the main thread.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+<br>
+=C2=A0 =C2=A0 data =3D g_new0(struct rutabaga_aio_data, 1);<br>
+=C2=A0 =C2=A0 data-&gt;vr =3D vr;<br>
+=C2=A0 =C2=A0 data-&gt;fence =3D fence_data;<br>
+=C2=A0 =C2=A0 aio_bh_schedule_oneshot_full(vr-&gt;ctx, virtio_gpu_rutabaga=
_aio_cb,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)data, &quot;aio&quot;)=
;<br>
+}<br>
+<br>
+static int virtio_gpu_rutabaga_init(VirtIOGPU *g)<br>
+{<br>
+=C2=A0 =C2=A0 int result;<br>
+=C2=A0 =C2=A0 uint64_t capset_mask;<br>
+=C2=A0 =C2=A0 struct rutabaga_channels channels =3D { 0 };<br>
+=C2=A0 =C2=A0 struct rutabaga_builder builder =3D { 0 };<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+=C2=A0 =C2=A0 vr-&gt;rutabaga =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 if (!vr-&gt;capset_names) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 builder.wsi =3D RUTABAGA_WSI_SURFACELESS;<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Currently, if WSI is specified, the only valid strin=
gs are &quot;surfaceless&quot;<br>
+=C2=A0 =C2=A0 =C2=A0* or &quot;headless&quot;.=C2=A0 Surfaceless doesn&#39=
;t create a native window surface, but<br>
+=C2=A0 =C2=A0 =C2=A0* does copy from the render target to the Pixman buffe=
r if a virtio-gpu<br>
+=C2=A0 =C2=A0 =C2=A0* 2D hypercall is issued.=C2=A0 Surfacless is the defa=
ult.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* Headless is like surfaceless, but doesn&#39;t copy t=
o the Pixman buffer. The<br>
+=C2=A0 =C2=A0 =C2=A0* use case is automated testing environments where the=
re is no need to view<br>
+=C2=A0 =C2=A0 =C2=A0* results.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* In the future, more performant virtio-gpu 2D UI inte=
gration may be added.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (vr-&gt;wsi) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strcmp(vr-&gt;wsi, &quot;surfaceless&quot=
;)) {<br></blockquote><div><br></div><div>g_str_equal() is a bit more reada=
ble<br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vr-&gt;headless =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (strcmp(vr-&gt;wsi, &quot;headless&q=
uot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vr-&gt;headless =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_calculate_capset_mask(vr-&gt;capset_name=
s, &amp;capset_mask);<br>
+=C2=A0 =C2=A0 if (result) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return result;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* rutabaga-0.1.1 is only compiled/tested with gfxstrea=
m and cross-domain<br>
+=C2=A0 =C2=A0 =C2=A0* support. Future versions may change this to have mor=
e context types if<br>
+=C2=A0 =C2=A0 =C2=A0* there is any interest.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (capset_mask &amp; (BIT(RUTABAGA_CAPSET_VIRGL) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0BIT(RUTABAGA_CAPSET_VIRGL2) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0BIT(RUTABAGA_CAPSET_VENUS) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0BIT(RUTABAGA_CAPSET_DRM))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 builder.user_data =3D (uint64_t)(uintptr_t *)(void *)g;<br><=
/blockquote><div><br></div><div>GPOINTER_TO_UINT(g) ?</div><div>=C2=A0<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 builder.fence_cb =3D virtio_gpu_rutabaga_fence_cb;<br>
+=C2=A0 =C2=A0 builder.capset_mask =3D capset_mask;<br>
+<br>
+=C2=A0 =C2=A0 if (vr-&gt;wayland_socket_path) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((builder.capset_mask &amp; (1 &lt;&lt; RUT=
ABAGA_CAPSET_CROSS_DOMAIN)) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 channels.channels =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (struct rutabaga_channel *)calloc(1, si=
zeof(struct rutabaga_channel));<br></blockquote><div><br></div><div>g_new0(=
struct ruabaga_channel, 1)</div><div>=C2=A0<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 channels.num_channels =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 channels.channels[0].channel_name =3D vr-&gt;w=
ayland_socket_path;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 channels.channels[0].channel_type =3D RUTABAGA=
_CHANNEL_TYPE_WAYLAND;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 builder.channels =3D &amp;channels;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_init(&amp;builder, &amp;vr-&gt;rutabaga)=
;<br>
+=C2=A0 =C2=A0 if (builder.capset_mask &amp; (1 &lt;&lt; RUTABAGA_CAPSET_CR=
OSS_DOMAIN)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(channels.channels);<br></blockquote><div>=
<br></div><div>g_free() (after switching to g_new)</div><div>=C2=A0<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 memset(&amp;memory_regions, 0, MAX_SLOTS * sizeof(struct Mem=
oryRegionInfo));<br>
+=C2=A0 =C2=A0 vr-&gt;ctx =3D qemu_get_aio_context();<br>
+=C2=A0 =C2=A0 return result;<br>
+}<br>
+<br>
+static int virtio_gpu_rutabaga_get_num_capsets(VirtIOGPU *g)<br>
+{<br>
+=C2=A0 =C2=A0 int result;<br>
+=C2=A0 =C2=A0 uint32_t num_capsets;<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 if (!vr-&gt;rutabaga_active) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D virtio_gpu_rutabaga_init(g);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (result) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to ini=
t rutabaga&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vr-&gt;rutabaga_active =3D true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_get_num_capsets(vr-&gt;rutabaga, &amp;nu=
m_capsets);<br>
+=C2=A0 =C2=A0 if (result) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to get capsets&quot;=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 vr-&gt;num_capsets =3D num_capsets;<br>
+=C2=A0 =C2=A0 return num_capsets;<br>
+}<br>
+<br>
+static void virtio_gpu_rutabaga_handle_ctrl(VirtIODevice *vdev, VirtQueue =
*vq)<br>
+{<br>
+=C2=A0 =C2=A0 VirtIOGPU *g =3D VIRTIO_GPU(vdev);<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+=C2=A0 =C2=A0 struct virtio_gpu_ctrl_command *cmd;<br>
+<br>
+=C2=A0 =C2=A0 if (!virtio_queue_ready(vq)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!vr-&gt;rutabaga_active) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int result =3D virtio_gpu_rutabaga_init(g);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!result) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vr-&gt;rutabaga_active =3D true;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!vr-&gt;rutabaga_active) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_comm=
and));<br>
+=C2=A0 =C2=A0 while (cmd) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;vq =3D vq;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;error =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;finished =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QTAILQ_INSERT_TAIL(&amp;g-&gt;cmdq, cmd, next)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D virtqueue_pop(vq, sizeof(struct virtio=
_gpu_ctrl_command));<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 virtio_gpu_process_cmdq(g);<br>
+}<br>
+<br>
+static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp)<b=
r>
+{<br>
+=C2=A0 =C2=A0 int num_capsets;<br>
+=C2=A0 =C2=A0 VirtIOGPUBase *bdev =3D VIRTIO_GPU_BASE(qdev);<br>
+=C2=A0 =C2=A0 VirtIOGPU *gpudev =3D VIRTIO_GPU(qdev);<br>
+<br></blockquote><div><br></div><div>It would be simpler to call virtio_gp=
u_rutabaga_init() here, with Error argument etc, instead of indirectly from=
 other places.</div><div><br> </div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 num_capsets =3D virtio_gpu_rutabaga_get_num_capsets(gpudev);=
<br>
+=C2=A0 =C2=A0 if (!num_capsets) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+#if HOST_BIG_ENDIAN<br>
+=C2=A0 =C2=A0 error_setg(errp, &quot;rutabaga is not supported on bigendia=
n platforms&quot;);<br>
+=C2=A0 =C2=A0 return;<br>
+#endif<br>
+<br>
+=C2=A0 =C2=A0 bdev-&gt;conf.flags |=3D (1 &lt;&lt; VIRTIO_GPU_FLAG_RUTABAG=
A_ENABLED);<br>
+=C2=A0 =C2=A0 bdev-&gt;conf.flags |=3D (1 &lt;&lt; VIRTIO_GPU_FLAG_BLOB_EN=
ABLED);<br>
+=C2=A0 =C2=A0 bdev-&gt;conf.flags |=3D (1 &lt;&lt; VIRTIO_GPU_FLAG_CONTEXT=
_INIT_ENABLED);<br>
+<br>
+=C2=A0 =C2=A0 bdev-&gt;virtio_config.num_capsets =3D num_capsets;<br>
+=C2=A0 =C2=A0 virtio_gpu_device_realize(qdev, errp);<br>
+}<br>
+<br>
+static Property virtio_gpu_rutabaga_properties[] =3D {<br>
+=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;capset_names&quot;, VirtioGpuRutaba=
ga, capset_names),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;wayland_socket_path&quot;, VirtioGp=
uRutabaga,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0wayland_socket_path),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;wsi&quot;, VirtioGpuRutabaga, wsi),=
<br>
+=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
+};<br>
+<br>
+static void virtio_gpu_rutabaga_class_init(ObjectClass *klass, void *data)=
<br>
+{<br>
+=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
+=C2=A0 =C2=A0 VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);<br>
+=C2=A0 =C2=A0 VirtIOGPUBaseClass *vbc =3D VIRTIO_GPU_BASE_CLASS(klass);<br=
>
+=C2=A0 =C2=A0 VirtIOGPUClass *vgc =3D VIRTIO_GPU_CLASS(klass);<br>
+<br>
+=C2=A0 =C2=A0 vbc-&gt;gl_flushed =3D virtio_gpu_rutabaga_gl_flushed;<br>
+=C2=A0 =C2=A0 vgc-&gt;handle_ctrl =3D virtio_gpu_rutabaga_handle_ctrl;<br>
+=C2=A0 =C2=A0 vgc-&gt;process_cmd =3D virtio_gpu_rutabaga_process_cmd;<br>
+=C2=A0 =C2=A0 vgc-&gt;update_cursor_data =3D virtio_gpu_rutabaga_update_cu=
rsor;<br>
+<br>
+=C2=A0 =C2=A0 vdc-&gt;realize =3D virtio_gpu_rutabaga_realize;<br>
+=C2=A0 =C2=A0 device_class_set_props(dc, virtio_gpu_rutabaga_properties);<=
br>
+}<br>
+<br>
+static const TypeInfo virtio_gpu_rutabaga_info =3D {<br>
+=C2=A0 =C2=A0 .name =3D TYPE_VIRTIO_GPU_RUTABAGA,<br>
+=C2=A0 =C2=A0 .parent =3D TYPE_VIRTIO_GPU,<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(VirtioGpuRutabaga),<br>
+=C2=A0 =C2=A0 .class_init =3D virtio_gpu_rutabaga_class_init,<br>
+};<br>
+module_obj(TYPE_VIRTIO_GPU_RUTABAGA);<br>
+module_kconfig(VIRTIO_GPU);<br>
+<br>
+static void virtio_register_types(void)<br>
+{<br>
+=C2=A0 =C2=A0 type_register_static(&amp;virtio_gpu_rutabaga_info);<br>
+}<br>
+<br>
+type_init(virtio_register_types)<br>
+<br>
+module_dep(&quot;hw-display-virtio-gpu&quot;);<br>
diff --git a/hw/display/virtio-vga-rutabaga.c b/hw/display/virtio-vga-rutab=
aga.c<br>
new file mode 100644<br>
index 0000000000..01831bd03f<br>
--- /dev/null<br>
+++ b/hw/display/virtio-vga-rutabaga.c<br>
@@ -0,0 +1,52 @@<br>
+// SPDX-License-Identifier: GPL-2.0<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;hw/pci/pci.h&quot;<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/virtio/virtio-gpu.h&quot;<br>
+#include &quot;hw/display/vga.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;qemu/module.h&quot;<br>
+#include &quot;virtio-vga.h&quot;<br>
+#include &quot;qom/object.h&quot;<br>
+<br>
+#define TYPE_VIRTIO_VGA_RUTABAGA &quot;virtio-vga-rutabaga&quot;<br>
+<br>
+typedef struct VirtIOVGARUTABAGA VirtIOVGARUTABAGA;<br>
+DECLARE_INSTANCE_CHECKER(VirtIOVGARUTABAGA, VIRTIO_VGA_RUTABAGA,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0TYPE_VIRTIO_VGA_RUTABAGA)<br>
+<br>
+struct VirtIOVGARUTABAGA {<br>
+=C2=A0 =C2=A0 VirtIOVGABase parent_obj;<br>
+<br>
+=C2=A0 =C2=A0 VirtioGpuRutabaga=C2=A0 =C2=A0vdev;<br>
+};<br>
+<br>
+static void virtio_vga_rutabaga_inst_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 VirtIOVGARUTABAGA *dev =3D VIRTIO_VGA_RUTABAGA(obj);<br>
+<br>
+=C2=A0 =C2=A0 virtio_instance_init_common(obj, &amp;dev-&gt;vdev, sizeof(d=
ev-&gt;vdev),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_VIRTIO_GPU_RUTABAGA);<br>
+=C2=A0 =C2=A0 VIRTIO_VGA_BASE(dev)-&gt;vgpu =3D VIRTIO_GPU_BASE(&amp;dev-&=
gt;vdev);<br>
+}<br>
+<br>
+static VirtioPCIDeviceTypeInfo virtio_vga_rutabaga_info =3D {<br>
+=C2=A0 =C2=A0 .generic_name=C2=A0 =3D TYPE_VIRTIO_VGA_RUTABAGA,<br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_VIRTIO_VGA_BASE,=
<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(VirtIOVGARUTABAGA),<br>
+=C2=A0 =C2=A0 .instance_init =3D virtio_vga_rutabaga_inst_initfn,<br>
+};<br>
+module_obj(TYPE_VIRTIO_VGA_RUTABAGA);<br>
+module_kconfig(VIRTIO_VGA);<br>
+<br>
+static void virtio_vga_register_types(void)<br>
+{<br>
+=C2=A0 =C2=A0 if (have_vga) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_pci_types_register(&amp;virtio_vga_ruta=
baga_info);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+type_init(virtio_vga_register_types)<br>
+<br>
+module_dep(&quot;hw-display-virtio-vga&quot;);<br>
-- <br>
2.41.0.255.g8b1d071c50-goog<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--00000000000061163006004f08b8--

