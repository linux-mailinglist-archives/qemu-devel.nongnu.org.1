Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7744C7515D0
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 03:29:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJl83-0003iS-Lz; Wed, 12 Jul 2023 21:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qJl82-0003iJ-1X
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 21:28:22 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qJl7t-0006Qn-0D
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 21:28:21 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-99313a34b2dso29028466b.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 18:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1689211690; x=1691803690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PySm1/cI87LnFIruhTDQxEg83oPdVdJwIO+XxVTvQKI=;
 b=e+t3jT7ofn2g0UQ6m36TgNBB2/Vc9fO6pH3Y5qWVo2R6Ishh9xsDFhDkvBe80aMraV
 frgzS6wUr2IrUQlwr2AHh0shU79MzZkXA7FqSHXpY0om8B8OAjIzP6A/QM/XqsxwfWN1
 TAGOlE9NTv+1XdIBCjWJyHjLET4GRKioKLu4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689211690; x=1691803690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PySm1/cI87LnFIruhTDQxEg83oPdVdJwIO+XxVTvQKI=;
 b=hECK1DrOVd7vMQ10eia8ztmWnh3DKYrLxAq+VWc3Pr0OQgQ8AW/uqfsB+5OyfA3GzU
 PvKAWEghZlVsGaBYLjFboS8RaTQDUA+noVYoM682t6XyBMgxVdWtJCKGSB2LYXhECAeo
 un0VwRax7L03u1q5iKagAG/GNT1lW1BbZCl7T3vYdNQlcYT+2FluJm5tT7zqdrFRSYYJ
 +BqdHGE+FTPxIcekKZebFOmu0zGZgIGp7IT56xlVBM8sjKCqzNZBrsbx6DYa/uriSXah
 eueszz9MvFuFrXZoIS1WsOBvBMiDQ8ns5AU64t7Pf4J22S5xGLV0yrQD7cX1dJW2JvNy
 iaKg==
X-Gm-Message-State: ABy/qLbn2M0mTVPiRN2J/dttnybXQv8Y0hr9sLYvNFIU/zlbu0wy0UT5
 jVT3O+85yLL9wnUJxR/Lw/a6lj3QYIzV8cxFdppZxw==
X-Google-Smtp-Source: APBJJlGTsv5uenrxSa7p22F8uoyxoHfEHqdAORwXgQ6H6SKgAx8wFE1uiRPQj8Dc3yE1P1XfFdMvtA==
X-Received: by 2002:a17:906:5302:b0:992:3b89:f980 with SMTP id
 h2-20020a170906530200b009923b89f980mr29889ejo.31.1689211689528; 
 Wed, 12 Jul 2023 18:28:09 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com.
 [209.85.208.47]) by smtp.gmail.com with ESMTPSA id
 f19-20020a170906561300b00984822540c9sm3252772ejq.96.2023.07.12.18.28.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 18:28:08 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-51e24210395so6939a12.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 18:28:08 -0700 (PDT)
X-Received: by 2002:a50:c44c:0:b0:51d:e2d4:3d43 with SMTP id
 w12-20020a50c44c000000b0051de2d43d43mr160203edf.7.1689211687943; Wed, 12 Jul
 2023 18:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230711025649.708-1-gurchetansingh@chromium.org>
 <20230711025649.708-7-gurchetansingh@chromium.org>
 <CAJ+F1CJJcBbqEDnwzfO9d9qhQh7APNJ8Syyj+M_JFNv3g05pZA@mail.gmail.com>
In-Reply-To: <CAJ+F1CJJcBbqEDnwzfO9d9qhQh7APNJ8Syyj+M_JFNv3g05pZA@mail.gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed, 12 Jul 2023 18:27:55 -0700
X-Gmail-Original-Message-ID: <CAAfnVBkEj8E+WFNLoW2DRMVNJozUZ7f_C3DYQjc=QLA4r2+Yvg@mail.gmail.com>
Message-ID: <CAAfnVBkEj8E+WFNLoW2DRMVNJozUZ7f_C3DYQjc=QLA4r2+Yvg@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] gfxstream + rutabaga: add initial support for
 gfxstream
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, akihiko.odaki@gmail.com, 
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org, 
 shentey@gmail.com, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Jul 12, 2023 at 12:15=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Tue, Jul 11, 2023 at 6:57=E2=80=AFAM Gurchetan Singh <gurchetansingh@c=
hromium.org> wrote:
>>
>> This adds initial support for gfxstream and cross-domain.  Both
>> features rely on virtio-gpu blob resources and context types, which
>> are also implemented in this patch.
>>
>> gfxstream has a long and illustrious history in Android graphics
>> paravirtualization.  It has been powering graphics in the Android
>> Studio Emulator for more than a decade, which is the main developer
>> platform.
>>
>> Originally conceived by Jesse Hall, it was first known as "EmuGL" [a].
>> The key design characteristic was a 1:1 threading model and
>> auto-generation, which fit nicely with the OpenGLES spec.  It also
>> allowed easy layering with ANGLE on the host, which provides the GLES
>> implementations on Windows or MacOS enviroments.
>>
>> gfxstream has traditionally been maintained by a single engineer, and
>> between 2015 to 2021, the goldfish throne passed to Frank Yang.
>> Historians often remark this glorious reign ("pax gfxstreama" is the
>> academic term) was comparable to that of Augustus and the both Queen
>> Elizabeths.  Just to name a few accomplishments in a resplendent
>> panoply: higher versions of GLES, address space graphics, snapshot
>> support and CTS compliant Vulkan [b].
>>
>> One major drawback was the use of out-of-tree goldfish drivers.
>> Android engineers didn't know much about DRM/KMS and especially TTM so
>> a simple guest to host pipe was conceived.
>>
>> Luckily, virtio-gpu 3D started to emerge in 2016 due to the work of
>> the Mesa/virglrenderer communities.  In 2018, the initial virtio-gpu
>> port of gfxstream was done by Cuttlefish enthusiast Alistair Delva.
>> It was a symbol compatible replacement of virglrenderer [c] and named
>> "AVDVirglrenderer".  This implementation forms the basis of the
>> current gfxstream host implementation still in use today.
>>
>> cross-domain support follows a similar arc.  Originally conceived by
>> Wayland aficionado David Reveman and crosvm enjoyer Zach Reizner in
>> 2018, it initially relied on the downstream "virtio-wl" device.
>>
>> In 2020 and 2021, virtio-gpu was extended to include blob resources
>> and multiple timelines by yours truly, features gfxstream/cross-domain
>> both require to function correctly.
>>
>> Right now, we stand at the precipice of a truly fantastic possibility:
>> the Android Emulator powered by upstream QEMU and upstream Linux
>> kernel.  gfxstream will then be packaged properfully, and app
>> developers can even fix gfxstream bugs on their own if they encounter
>> them.
>>
>> It's been quite the ride, my friends.  Where will gfxstream head next,
>> nobody really knows.  I wouldn't be surprised if it's around for
>> another decade, maintained by a new generation of Android graphics
>> enthusiasts.
>>
>> Technical details:
>>   - Very simple initial display integration: just used Pixman
>>   - Largely, 1:1 mapping of virtio-gpu hypercalls to rutabaga function
>>     calls
>>
>
> Wow, this is not for the faint reader.. there is a lot to grasp in this g=
fx space...
>
> Could you perhaps extend on what this current code can do for an average =
Linux VM? or for some Android VM (which one?!), and then what are the next =
steps and status?

- For Linux VMs + Linux hosts, this provides more modern display
virtualization via Wayland passthrough.   It also is a performance
benefit since you can avoid a guest compositor pass.  For widespread
distribution, someone needs to package Sommelier or the
wayland-proxy-virtwl [a] Linux distro style.   In addition newer
versions [b] of the Linux kernel come with DRM_VIRTIO_GPU_KMS, which
allow disabling KMS hypercalls.  I suppose someone can come up with a
Linux VM variant that automatically starts the Sommelier or
wayland-proxy-virtwl and some terminal app.

- For Android VMs, you can boot with gfxstream GLES/Vulkan now with
upstream QEMU with a simple UI.  The next step would be improving
display integration and UI interfaces with the goal of the QEMU
upstream graphics being in an emulator release [c].

Will add these details to the commit message in v2.

[a] https://github.com/talex5/wayland-proxy-virtwl
[b] https://lore.kernel.org/lkml/20230302233506.3146290-1-robdclark@gmail.c=
om/
[c] https://developer.android.com/studio/releases/emulator

>
> My limited understanding (from this series and from https://gitlab.com/qe=
mu-project/qemu/-/issues/1611) is that it allows passing-through some vulka=
n APIs for off-screen usage. Is that accurate?

For Linux VMs, it's currently offscreen accelerated rendering only.
For Android VMs, on-screen does work, but for simplicity a memcpy does
occur when flushing to the scanout.

>
> How far are we from getting upstream QEMU to be used by Android Emulator?=
 (in the gfx domain at least) What would it take to get the average Linux V=
M to use virtio-vga-rutabaga instead of virtio-vga-gl to get accelerated re=
ndering?

We have both offscreen (running automated CTS tests in headless
environments) and on-screen Android emulator use cases.  For
offscreen, this patch series can be used out-of-the-box.  For onscreen
it works but there's that memcpy.  Fixing that will be the next step
after this patch series.

For Linux VMs, we do plan to add Wayland WSI to gfxstream Vulkan for
testing/debug/performance purposes.  And we can always compile
rutabaga_gfx's virglrenderer bindings (the current patchset doesn't do
this for simplicity + lack of testing cycles) in there's sufficient
interest in Linux VMs + accelerated rendering + virtio-vga-rutabaga.




>
>> [a] https://android-review.googlesource.com/c/platform/development/+/344=
70
>> [b] https://android-review.googlesource.com/q/topic:%22vulkan-hostconnec=
tion-start%22
>> [c] https://android-review.googlesource.com/c/device/generic/goldfish-op=
engl/+/761927
>>
>> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
>> ---
>> v2: Incorported various suggestions by Akihiko Odaki and Bernard Berscho=
w
>>     - Removed GET_VIRTIO_GPU_GL / GET_RUTABAGA macros
>>     - Used error_report(..)
>>     - Used g_autofree to fix leaks on error paths
>>     - Removed unnecessary casts
>>     - added virtio-gpu-pci-rutabaga.c + virtio-vga-rutabaga.c files
>>
>>  hw/display/virtio-gpu-pci-rutabaga.c |   48 ++
>>  hw/display/virtio-gpu-rutabaga.c     | 1088 ++++++++++++++++++++++++++
>>  hw/display/virtio-vga-rutabaga.c     |   52 ++
>>  3 files changed, 1188 insertions(+)
>>  create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
>>  create mode 100644 hw/display/virtio-gpu-rutabaga.c
>>  create mode 100644 hw/display/virtio-vga-rutabaga.c
>>
>> diff --git a/hw/display/virtio-gpu-pci-rutabaga.c b/hw/display/virtio-gp=
u-pci-rutabaga.c
>> new file mode 100644
>> index 0000000000..5765bef266
>> --- /dev/null
>> +++ b/hw/display/virtio-gpu-pci-rutabaga.c
>> @@ -0,0 +1,48 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "qemu/module.h"
>> +#include "hw/pci/pci.h"
>> +#include "hw/qdev-properties.h"
>> +#include "hw/virtio/virtio.h"
>> +#include "hw/virtio/virtio-bus.h"
>> +#include "hw/virtio/virtio-gpu-pci.h"
>> +#include "qom/object.h"
>> +
>> +#define TYPE_VIRTIO_GPU_RUTABAGA_PCI "virtio-gpu-rutabaga-pci"
>> +typedef struct VirtIOGPURUTABAGAPCI VirtIOGPURUTABAGAPCI;
>> +DECLARE_INSTANCE_CHECKER(VirtIOGPURUTABAGAPCI, VIRTIO_GPU_RUTABAGA_PCI,
>> +                         TYPE_VIRTIO_GPU_RUTABAGA_PCI)
>> +
>> +struct VirtIOGPURUTABAGAPCI {
>> +    VirtIOGPUPCIBase parent_obj;
>> +    VirtioGpuRutabaga   vdev;
>> +};
>> +
>> +static void virtio_gpu_rutabaga_initfn(Object *obj)
>> +{
>> +    VirtIOGPURUTABAGAPCI *dev =3D VIRTIO_GPU_RUTABAGA_PCI(obj);
>> +
>> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
>> +                                TYPE_VIRTIO_GPU_RUTABAGA);
>> +    VIRTIO_GPU_PCI_BASE(obj)->vgpu =3D VIRTIO_GPU_BASE(&dev->vdev);
>> +}
>> +
>> +static const VirtioPCIDeviceTypeInfo virtio_gpu_rutabaga_pci_info =3D {
>> +    .generic_name =3D TYPE_VIRTIO_GPU_RUTABAGA_PCI,
>> +    .parent =3D TYPE_VIRTIO_GPU_PCI_BASE,
>> +    .instance_size =3D sizeof(VirtIOGPURUTABAGAPCI),
>> +    .instance_init =3D virtio_gpu_rutabaga_initfn,
>> +};
>> +module_obj(TYPE_VIRTIO_GPU_RUTABAGA_PCI);
>> +module_kconfig(VIRTIO_PCI);
>> +
>> +static void virtio_gpu_rutabaga_pci_register_types(void)
>> +{
>> +    virtio_pci_types_register(&virtio_gpu_rutabaga_pci_info);
>> +}
>> +
>> +type_init(virtio_gpu_rutabaga_pci_register_types)
>> +
>> +module_dep("hw-display-virtio-gpu-pci");
>> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-ru=
tabaga.c
>> new file mode 100644
>> index 0000000000..b60a30a093
>> --- /dev/null
>> +++ b/hw/display/virtio-gpu-rutabaga.c
>> @@ -0,0 +1,1088 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/iov.h"
>> +#include "trace.h"
>> +#include "hw/virtio/virtio.h"
>> +#include "hw/virtio/virtio-gpu.h"
>> +#include "hw/virtio/virtio-gpu-pixman.h"
>> +#include "hw/virtio/virtio-iommu.h"
>> +
>> +#include <glib/gmem.h>
>> +#include <rutabaga_gfx/rutabaga_gfx_ffi.h>
>> +
>> +#define CHECK(condition, cmd)                                          =
       \
>> +    do {                                                               =
       \
>> +        if (!condition) {                                              =
       \
>> +            error_report("CHECK failed in %s() %s:" "%d", __func__,    =
       \
>> +                         __FILE__, __LINE__);                          =
       \
>> +            cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;                 =
         \
>> +            return;                                                    =
       \
>> +       }                                                               =
       \
>> +    } while (0)
>> +
>> +#define CHECK_RESULT(result, cmd) CHECK(result =3D=3D 0, cmd)
>> +
>> +#define MAX_SLOTS 4096
>> +
>> +struct MemoryRegionInfo {
>> +    int used;
>> +    MemoryRegion mr;
>> +    uint32_t resource_id;
>> +};
>> +
>> +static struct MemoryRegionInfo memory_regions[MAX_SLOTS];
>> +
>> +struct rutabaga_aio_data {
>> +    struct VirtioGpuRutabaga *vr;
>> +    struct rutabaga_fence fence;
>> +};
>> +
>> +static void
>> +virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, struct virtio_gpu_scano=
ut *s,
>> +                                  uint32_t resource_id)
>> +{
>> +    struct virtio_gpu_simple_resource *res;
>> +    struct rutabaga_transfer transfer =3D { 0 };
>> +    struct iovec transfer_iovec;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    res =3D virtio_gpu_find_resource(g, resource_id);
>> +    if (!res) {
>> +        return;
>> +    }
>> +
>> +    if (res->width !=3D s->current_cursor->width ||
>> +        res->height !=3D s->current_cursor->height) {
>> +        return;
>> +    }
>> +
>> +    transfer.x =3D 0;
>> +    transfer.y =3D 0;
>> +    transfer.z =3D 0;
>> +    transfer.w =3D res->width;
>> +    transfer.h =3D res->height;
>> +    transfer.d =3D 1;
>> +
>> +    transfer_iovec.iov_base =3D (void *)s->current_cursor->data;
>> +    transfer_iovec.iov_len =3D res->width * res->height * 4;
>> +
>> +    rutabaga_resource_transfer_read(vr->rutabaga, 0,
>> +                                    resource_id, &transfer,
>> +                                    &transfer_iovec);
>> +}
>> +
>> +static void
>> +virtio_gpu_rutabaga_gl_flushed(VirtIOGPUBase *b)
>> +{
>> +    VirtIOGPU *g =3D VIRTIO_GPU(b);
>> +    virtio_gpu_process_cmdq(g);
>> +}
>> +
>> +static void
>> +rutabaga_cmd_create_resource_2d(VirtIOGPU *g,
>> +                                struct virtio_gpu_ctrl_command *cmd)
>> +{
>> +    int32_t result;
>> +    struct rutabaga_create_3d rc_3d =3D { 0 };
>> +    struct virtio_gpu_simple_resource *res;
>> +    struct virtio_gpu_resource_create_2d c2d;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    VIRTIO_GPU_FILL_CMD(c2d);
>> +    trace_virtio_gpu_cmd_res_create_2d(c2d.resource_id, c2d.format,
>> +                                       c2d.width, c2d.height);
>> +
>> +    rc_3d.target =3D 2;
>> +    rc_3d.format =3D c2d.format;
>> +    rc_3d.bind =3D (1 << 1);
>> +    rc_3d.width =3D c2d.width;
>> +    rc_3d.height =3D c2d.height;
>> +    rc_3d.depth =3D 1;
>> +    rc_3d.array_size =3D 1;
>> +    rc_3d.last_level =3D 0;
>> +    rc_3d.nr_samples =3D 0;
>> +    rc_3d.flags =3D VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
>> +
>> +    result =3D rutabaga_resource_create_3d(vr->rutabaga, c2d.resource_i=
d, &rc_3d);
>> +    CHECK_RESULT(result, cmd);
>> +
>> +    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
>> +    res->width =3D c2d.width;
>> +    res->height =3D c2d.height;
>> +    res->format =3D c2d.format;
>> +    res->resource_id =3D c2d.resource_id;
>> +
>> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>> +}
>> +
>> +static void
>> +rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
>> +                                struct virtio_gpu_ctrl_command *cmd)
>> +{
>> +    int32_t result;
>> +    struct rutabaga_create_3d rc_3d =3D { 0 };
>> +    struct virtio_gpu_simple_resource *res;
>> +    struct virtio_gpu_resource_create_3d c3d;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    VIRTIO_GPU_FILL_CMD(c3d);
>> +
>> +    trace_virtio_gpu_cmd_res_create_3d(c3d.resource_id, c3d.format,
>> +                                       c3d.width, c3d.height, c3d.depth=
);
>> +
>> +    rc_3d.target =3D c3d.target;
>> +    rc_3d.format =3D c3d.format;
>> +    rc_3d.bind =3D c3d.bind;
>> +    rc_3d.width =3D c3d.width;
>> +    rc_3d.height =3D c3d.height;
>> +    rc_3d.depth =3D c3d.depth;
>> +    rc_3d.array_size =3D c3d.array_size;
>> +    rc_3d.last_level =3D c3d.last_level;
>> +    rc_3d.nr_samples =3D c3d.nr_samples;
>> +    rc_3d.flags =3D c3d.flags;
>> +
>> +    result =3D rutabaga_resource_create_3d(vr->rutabaga, c3d.resource_i=
d, &rc_3d);
>> +    CHECK_RESULT(result, cmd);
>> +
>> +    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
>> +    res->width =3D c3d.width;
>> +    res->height =3D c3d.height;
>> +    res->format =3D c3d.format;
>> +    res->resource_id =3D c3d.resource_id;
>> +
>> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>> +}
>> +
>> +static void
>> +rutabaga_cmd_resource_unref(VirtIOGPU *g,
>> +                            struct virtio_gpu_ctrl_command *cmd)
>> +{
>> +    int32_t result;
>> +    struct virtio_gpu_simple_resource *res;
>> +    struct virtio_gpu_resource_unref unref;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    VIRTIO_GPU_FILL_CMD(unref);
>> +
>> +    trace_virtio_gpu_cmd_res_unref(unref.resource_id);
>> +
>> +    res =3D virtio_gpu_find_resource(g, unref.resource_id);
>> +    CHECK(res, cmd);
>> +
>> +    result =3D rutabaga_resource_unref(vr->rutabaga, unref.resource_id)=
;
>> +    CHECK_RESULT(result, cmd);
>> +
>> +    if (res->image) {
>> +        pixman_image_unref(res->image);
>> +    }
>> +
>> +    QTAILQ_REMOVE(&g->reslist, res, next);
>> +    g_free(res);
>> +}
>> +
>> +static void
>> +rutabaga_cmd_context_create(VirtIOGPU *g,
>> +                            struct virtio_gpu_ctrl_command *cmd)
>> +{
>> +    int32_t result;
>> +    struct virtio_gpu_ctx_create cc;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    VIRTIO_GPU_FILL_CMD(cc);
>> +    trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,
>> +                                    cc.debug_name);
>> +
>> +    result =3D rutabaga_context_create(vr->rutabaga, cc.hdr.ctx_id,
>> +                                     cc.context_init, cc.debug_name, cc=
.nlen);
>> +    CHECK_RESULT(result, cmd);
>> +}
>> +
>> +static void
>> +rutabaga_cmd_context_destroy(VirtIOGPU *g,
>> +                             struct virtio_gpu_ctrl_command *cmd)
>> +{
>> +    int32_t result;
>> +    struct virtio_gpu_ctx_destroy cd;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    VIRTIO_GPU_FILL_CMD(cd);
>> +    trace_virtio_gpu_cmd_ctx_destroy(cd.hdr.ctx_id);
>> +
>> +    result =3D rutabaga_context_destroy(vr->rutabaga, cd.hdr.ctx_id);
>> +    CHECK_RESULT(result, cmd);
>> +}
>> +
>> +static void
>> +rutabaga_cmd_resource_flush(VirtIOGPU *g, struct virtio_gpu_ctrl_comman=
d *cmd)
>> +{
>> +    int32_t result, i;
>> +    struct virtio_gpu_scanout *scanout =3D NULL;
>> +    struct virtio_gpu_simple_resource *res;
>> +    struct rutabaga_transfer transfer =3D { 0 };
>> +    struct iovec transfer_iovec;
>> +    struct virtio_gpu_resource_flush rf;
>> +    bool found =3D false;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +    if (vr->headless) {
>> +        return;
>> +    }
>> +
>> +    VIRTIO_GPU_FILL_CMD(rf);
>> +    trace_virtio_gpu_cmd_res_flush(rf.resource_id,
>> +                                   rf.r.width, rf.r.height, rf.r.x, rf.=
r.y);
>> +
>> +    res =3D virtio_gpu_find_resource(g, rf.resource_id);
>> +    CHECK(res, cmd);
>> +
>> +    for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
>> +        scanout =3D &g->parent_obj.scanout[i];
>> +        if (i =3D=3D res->scanout_bitmask) {
>> +            found =3D true;
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (!found) {
>> +        return;
>> +    }
>> +
>> +    transfer.x =3D 0;
>> +    transfer.y =3D 0;
>> +    transfer.z =3D 0;
>> +    transfer.w =3D res->width;
>> +    transfer.h =3D res->height;
>> +    transfer.d =3D 1;
>> +
>> +    transfer_iovec.iov_base =3D (void *)pixman_image_get_data(res->imag=
e);
>> +    transfer_iovec.iov_len =3D res->width * res->height * 4;
>> +
>> +    result =3D rutabaga_resource_transfer_read(vr->rutabaga, 0,
>> +                                             rf.resource_id, &transfer,
>> +                                             &transfer_iovec);
>> +    CHECK_RESULT(result, cmd);
>> +    dpy_gfx_update_full(scanout->con);
>> +}
>> +
>> +static void
>> +rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *=
cmd)
>> +{
>> +    struct virtio_gpu_simple_resource *res;
>> +    struct virtio_gpu_scanout *scanout =3D NULL;
>> +    struct virtio_gpu_set_scanout ss;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +    if (vr->headless) {
>> +        return;
>> +    }
>> +
>> +    VIRTIO_GPU_FILL_CMD(ss);
>> +    trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_id,
>> +                                     ss.r.width, ss.r.height, ss.r.x, s=
s.r.y);
>> +
>> +    scanout =3D &g->parent_obj.scanout[ss.scanout_id];
>> +    g->parent_obj.enable =3D 1;
>> +
>> +    if (ss.resource_id =3D=3D 0) {
>> +        return;
>> +    }
>> +
>> +    res =3D virtio_gpu_find_resource(g, ss.resource_id);
>> +    CHECK(res, cmd);
>> +
>> +    if (!res->image) {
>> +        pixman_format_code_t pformat;
>> +        pformat =3D virtio_gpu_get_pixman_format(res->format);
>> +        CHECK(pformat, cmd);
>> +
>> +        res->image =3D pixman_image_create_bits(pformat,
>> +                                              res->width,
>> +                                              res->height,
>> +                                              NULL, 0);
>> +        CHECK(res->image, cmd);
>> +        pixman_image_ref(res->image);
>> +    }
>> +
>> +    /* realloc the surface ptr */
>> +    scanout->ds =3D qemu_create_displaysurface_pixman(res->image);
>> +    dpy_gfx_replace_surface(scanout->con, NULL);
>> +    dpy_gfx_replace_surface(scanout->con, scanout->ds);
>> +    res->scanout_bitmask =3D ss.scanout_id;
>> +}
>> +
>> +static void
>> +rutabaga_cmd_submit_3d(VirtIOGPU *g,
>> +                       struct virtio_gpu_ctrl_command *cmd)
>> +{
>> +    int32_t result;
>> +    struct virtio_gpu_cmd_submit cs;
>> +    g_autofree uint8_t *buf =3D NULL;
>> +    size_t s;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    VIRTIO_GPU_FILL_CMD(cs);
>> +    trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size);
>> +
>> +    buf =3D g_new0(uint8_t, cs.size);
>> +    s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>> +                   sizeof(cs), buf, cs.size);
>> +    CHECK((s =3D=3D cs.size), cmd);
>> +
>> +    result =3D rutabaga_submit_command(vr->rutabaga, cs.hdr.ctx_id, buf=
, cs.size);
>> +    CHECK_RESULT(result, cmd);
>> +}
>> +
>> +static void
>> +rutabaga_cmd_transfer_to_host_2d(VirtIOGPU *g,
>> +                                 struct virtio_gpu_ctrl_command *cmd)
>> +{
>> +    int32_t result;
>> +    struct rutabaga_transfer transfer =3D { 0 };
>> +    struct virtio_gpu_transfer_to_host_2d t2d;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    VIRTIO_GPU_FILL_CMD(t2d);
>> +    trace_virtio_gpu_cmd_res_xfer_toh_2d(t2d.resource_id);
>> +
>> +    transfer.x =3D t2d.r.x;
>> +    transfer.y =3D t2d.r.y;
>> +    transfer.z =3D 0;
>> +    transfer.w =3D t2d.r.width;
>> +    transfer.h =3D t2d.r.height;
>> +    transfer.d =3D 1;
>> +
>> +    result =3D rutabaga_resource_transfer_write(vr->rutabaga, 0, t2d.re=
source_id,
>> +                                              &transfer);
>> +    CHECK_RESULT(result, cmd);
>> +}
>> +
>> +static void
>> +rutabaga_cmd_transfer_to_host_3d(VirtIOGPU *g,
>> +                                 struct virtio_gpu_ctrl_command *cmd)
>> +{
>> +    int32_t result;
>> +    struct rutabaga_transfer transfer =3D { 0 };
>> +    struct virtio_gpu_transfer_host_3d t3d;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    VIRTIO_GPU_FILL_CMD(t3d);
>> +    trace_virtio_gpu_cmd_res_xfer_toh_3d(t3d.resource_id);
>> +
>> +    transfer.x =3D t3d.box.x;
>> +    transfer.y =3D t3d.box.y;
>> +    transfer.z =3D t3d.box.z;
>> +    transfer.w =3D t3d.box.w;
>> +    transfer.h =3D t3d.box.h;
>> +    transfer.d =3D t3d.box.d;
>> +    transfer.level =3D t3d.level;
>> +    transfer.stride =3D t3d.stride;
>> +    transfer.layer_stride =3D t3d.layer_stride;
>> +    transfer.offset =3D t3d.offset;
>> +
>> +    result =3D rutabaga_resource_transfer_write(vr->rutabaga, t3d.hdr.c=
tx_id,
>> +                                              t3d.resource_id, &transfe=
r);
>> +    CHECK_RESULT(result, cmd);
>> +}
>> +
>> +static void
>> +rutabaga_cmd_transfer_from_host_3d(VirtIOGPU *g,
>> +                                   struct virtio_gpu_ctrl_command *cmd)
>> +{
>> +    int32_t result;
>> +    struct rutabaga_transfer transfer =3D { 0 };
>> +    struct virtio_gpu_transfer_host_3d t3d;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    VIRTIO_GPU_FILL_CMD(t3d);
>> +    trace_virtio_gpu_cmd_res_xfer_fromh_3d(t3d.resource_id);
>> +
>> +    transfer.x =3D t3d.box.x;
>> +    transfer.y =3D t3d.box.y;
>> +    transfer.z =3D t3d.box.z;
>> +    transfer.w =3D t3d.box.w;
>> +    transfer.h =3D t3d.box.h;
>> +    transfer.d =3D t3d.box.d;
>> +    transfer.level =3D t3d.level;
>> +    transfer.stride =3D t3d.stride;
>> +    transfer.layer_stride =3D t3d.layer_stride;
>> +    transfer.offset =3D t3d.offset;
>> +
>> +    result =3D rutabaga_resource_transfer_read(vr->rutabaga, t3d.hdr.ct=
x_id,
>> +                                             t3d.resource_id, &transfer=
, NULL);
>> +    CHECK_RESULT(result, cmd);
>> +}
>> +
>> +static void
>> +rutabaga_cmd_attach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_comman=
d *cmd)
>> +{
>> +    struct rutabaga_iovecs vecs =3D { 0 };
>> +    struct virtio_gpu_simple_resource *res;
>> +    struct virtio_gpu_resource_attach_backing att_rb;
>> +    struct iovec *res_iovs;
>> +    uint32_t res_niov;
>> +    int ret;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    VIRTIO_GPU_FILL_CMD(att_rb);
>> +    trace_virtio_gpu_cmd_res_back_attach(att_rb.resource_id);
>> +
>> +    res =3D virtio_gpu_find_resource(g, att_rb.resource_id);
>> +    CHECK(res, cmd);
>> +    CHECK(!res->iov, cmd);
>> +
>> +    ret =3D virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(=
att_rb),
>> +                                        cmd, NULL, &res_iovs, &res_niov=
);
>> +    CHECK_RESULT(ret, cmd);
>> +
>> +    vecs.iovecs =3D res_iovs;
>> +    vecs.num_iovecs =3D res_niov;
>> +
>> +    ret =3D rutabaga_resource_attach_backing(vr->rutabaga, att_rb.resou=
rce_id,
>> +                                           &vecs);
>> +    if (ret !=3D 0) {
>> +        virtio_gpu_cleanup_mapping_iov(g, res_iovs, res_niov);
>> +    }
>> +}
>> +
>> +static void
>> +rutabaga_cmd_detach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_comman=
d *cmd)
>> +{
>> +    struct virtio_gpu_simple_resource *res;
>> +    struct virtio_gpu_resource_detach_backing detach_rb;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    VIRTIO_GPU_FILL_CMD(detach_rb);
>> +    trace_virtio_gpu_cmd_res_back_detach(detach_rb.resource_id);
>> +
>> +    res =3D virtio_gpu_find_resource(g, detach_rb.resource_id);
>> +    CHECK(res, cmd);
>> +
>> +    rutabaga_resource_detach_backing(vr->rutabaga,
>> +                                     detach_rb.resource_id);
>> +
>> +    virtio_gpu_cleanup_mapping(g, res);
>> +}
>> +
>> +static void
>> +rutabaga_cmd_ctx_attach_resource(VirtIOGPU *g,
>> +                                 struct virtio_gpu_ctrl_command *cmd)
>> +{
>> +    int32_t result;
>> +    struct virtio_gpu_ctx_resource att_res;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    VIRTIO_GPU_FILL_CMD(att_res);
>> +    trace_virtio_gpu_cmd_ctx_res_attach(att_res.hdr.ctx_id,
>> +                                        att_res.resource_id);
>> +
>> +    result =3D rutabaga_context_attach_resource(vr->rutabaga, att_res.h=
dr.ctx_id,
>> +                                              att_res.resource_id);
>> +    CHECK_RESULT(result, cmd);
>> +}
>> +
>> +static void
>> +rutabaga_cmd_ctx_detach_resource(VirtIOGPU *g,
>> +                                 struct virtio_gpu_ctrl_command *cmd)
>> +{
>> +    int32_t result;
>> +    struct virtio_gpu_ctx_resource det_res;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    VIRTIO_GPU_FILL_CMD(det_res);
>> +    trace_virtio_gpu_cmd_ctx_res_detach(det_res.hdr.ctx_id,
>> +                                        det_res.resource_id);
>> +
>> +    result =3D rutabaga_context_detach_resource(vr->rutabaga, det_res.h=
dr.ctx_id,
>> +                                              det_res.resource_id);
>> +    CHECK_RESULT(result, cmd);
>> +}
>> +
>> +static void
>> +rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct virtio_gpu_ctrl_comma=
nd *cmd)
>> +{
>> +    int32_t result;
>> +    struct virtio_gpu_get_capset_info info;
>> +    struct virtio_gpu_resp_capset_info resp;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    VIRTIO_GPU_FILL_CMD(info);
>> +
>> +    result =3D rutabaga_get_capset_info(vr->rutabaga, info.capset_index=
,
>> +                                      &resp.capset_id, &resp.capset_max=
_version,
>> +                                      &resp.capset_max_size);
>> +    CHECK_RESULT(result, cmd);
>> +
>> +    resp.hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET_INFO;
>> +    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
>> +}
>> +
>> +static void
>> +rutabaga_cmd_get_capset(VirtIOGPU *g, struct virtio_gpu_ctrl_command *c=
md)
>> +{
>> +    int32_t result;
>> +    struct virtio_gpu_get_capset gc;
>> +    struct virtio_gpu_resp_capset *resp;
>> +    uint32_t capset_size;
>> +    uint32_t current_id;
>> +    bool found =3D false;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    VIRTIO_GPU_FILL_CMD(gc);
>> +    for (uint32_t i =3D 0; i < vr->num_capsets; i++) {
>> +        result =3D rutabaga_get_capset_info(vr->rutabaga, i,
>> +                                          &current_id, &capset_size,
>> +                                          &capset_size);
>> +        CHECK_RESULT(result, cmd);
>> +
>> +        if (current_id =3D=3D gc.capset_id) {
>> +            found =3D true;
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (!found) {
>> +        error_report("capset not found!");
>> +        return;
>> +    }
>> +
>> +    resp =3D g_malloc0(sizeof(*resp) + capset_size);
>> +    resp->hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET;
>> +    rutabaga_get_capset(vr->rutabaga, gc.capset_id, gc.capset_version,
>> +                       (uint8_t *)resp->capset_data, capset_size);
>> +
>> +    virtio_gpu_ctrl_response(g, cmd, &resp->hdr, sizeof(*resp) + capset=
_size);
>> +    g_free(resp);
>> +}
>> +
>> +static void
>> +rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
>> +                                  struct virtio_gpu_ctrl_command *cmd)
>> +{
>> +    int result;
>> +    struct rutabaga_iovecs vecs =3D { 0 };
>> +    g_autofree struct virtio_gpu_simple_resource *res =3D NULL;
>> +    struct virtio_gpu_simple_resource *resource;
>> +    struct virtio_gpu_resource_create_blob cblob;
>> +    struct rutabaga_create_blob rc_blob =3D { 0 };
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    VIRTIO_GPU_FILL_CMD(cblob);
>> +    trace_virtio_gpu_cmd_res_create_blob(cblob.resource_id, cblob.size)=
;
>> +
>> +    CHECK(cblob.resource_id !=3D 0, cmd);
>> +
>> +    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
>> +
>> +    res->resource_id =3D cblob.resource_id;
>> +    res->blob_size =3D cblob.size;
>> +
>> +    if (cblob.blob_mem !=3D VIRTIO_GPU_BLOB_MEM_HOST3D) {
>> +        result =3D virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
>> +                                               sizeof(cblob), cmd, &res=
->addrs,
>> +                                               &res->iov, &res->iov_cnt=
);
>> +        CHECK_RESULT(result, cmd);
>> +    }
>> +
>> +    rc_blob.blob_id =3D cblob.blob_id;
>> +    rc_blob.blob_mem =3D cblob.blob_mem;
>> +    rc_blob.blob_flags =3D cblob.blob_flags;
>> +    rc_blob.size =3D cblob.size;
>> +
>> +    vecs.iovecs =3D res->iov;
>> +    vecs.num_iovecs =3D res->iov_cnt;
>> +
>> +    result =3D rutabaga_resource_create_blob(vr->rutabaga, cblob.hdr.ct=
x_id,
>> +                                           cblob.resource_id, &rc_blob,=
 &vecs,
>> +                                           NULL);
>> +    CHECK_RESULT(result, cmd);
>> +    resource =3D g_steal_pointer(&res);
>> +    QTAILQ_INSERT_HEAD(&g->reslist, resource, next);
>> +}
>> +
>> +static void
>> +rutabaga_cmd_resource_map_blob(VirtIOGPU *g,
>> +                               struct virtio_gpu_ctrl_command *cmd)
>> +{
>> +    int32_t result;
>> +    uint32_t slot =3D 0;
>> +    struct virtio_gpu_simple_resource *res;
>> +    struct rutabaga_mapping mapping =3D { 0 };
>> +    struct virtio_gpu_resource_map_blob mblob;
>> +    struct virtio_gpu_resp_map_info resp;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    VIRTIO_GPU_FILL_CMD(mblob);
>> +
>> +    CHECK(mblob.resource_id !=3D 0, cmd);
>> +
>> +    res =3D virtio_gpu_find_resource(g, mblob.resource_id);
>> +    CHECK(res, cmd);
>> +
>> +    result =3D rutabaga_resource_map(vr->rutabaga, mblob.resource_id, &=
mapping);
>> +    CHECK_RESULT(result, cmd);
>> +
>> +    for (slot =3D 0; slot < MAX_SLOTS; slot++) {
>> +        if (memory_regions[slot].used) {
>> +            continue;
>> +        }
>> +
>> +        MemoryRegion *mr =3D &(memory_regions[slot].mr);
>> +        memory_region_init_ram_ptr(mr, NULL, "blob", mapping.size,
>> +                                   (void *)mapping.ptr);
>> +        memory_region_add_subregion(&g->parent_obj.hostmem,
>> +                                    mblob.offset, mr);
>> +        memory_regions[slot].resource_id =3D mblob.resource_id;
>> +        memory_regions[slot].used =3D 1;
>> +        break;
>> +    }
>> +
>> +    CHECK((slot < MAX_SLOTS), cmd);
>> +
>> +    memset(&resp, 0, sizeof(resp));
>> +    resp.hdr.type =3D VIRTIO_GPU_RESP_OK_MAP_INFO;
>> +    result =3D rutabaga_resource_map_info(vr->rutabaga, mblob.resource_=
id,
>> +                                        &resp.map_info);
>> +
>> +    CHECK_RESULT(result, cmd);
>> +    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
>> +}
>> +
>> +static void
>> +rutabaga_cmd_resource_unmap_blob(VirtIOGPU *g,
>> +                                 struct virtio_gpu_ctrl_command *cmd)
>> +{
>> +    int32_t result;
>> +    uint32_t slot =3D 0;
>> +    struct virtio_gpu_simple_resource *res;
>> +    struct virtio_gpu_resource_unmap_blob ublob;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    VIRTIO_GPU_FILL_CMD(ublob);
>> +
>> +    CHECK(ublob.resource_id !=3D 0, cmd);
>> +
>> +    res =3D virtio_gpu_find_resource(g, ublob.resource_id);
>> +    CHECK(res, cmd);
>> +
>> +    for (slot =3D 0; slot < MAX_SLOTS; slot++) {
>> +        if (memory_regions[slot].resource_id !=3D ublob.resource_id) {
>> +            continue;
>> +        }
>> +
>> +        MemoryRegion *mr =3D &(memory_regions[slot].mr);
>> +        memory_region_del_subregion(&g->parent_obj.hostmem, mr);
>> +
>> +        memory_regions[slot].resource_id =3D 0;
>> +        memory_regions[slot].used =3D 0;
>> +        break;
>> +    }
>> +
>> +    CHECK((slot < MAX_SLOTS), cmd);
>> +    result =3D rutabaga_resource_unmap(vr->rutabaga, res->resource_id);
>> +    CHECK_RESULT(result, cmd);
>> +}
>> +
>> +static void
>> +virtio_gpu_rutabaga_process_cmd(VirtIOGPU *g,
>> +                                struct virtio_gpu_ctrl_command *cmd)
>> +{
>> +    struct rutabaga_fence fence =3D { 0 };
>> +    int32_t result;
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
>> +
>> +    switch (cmd->cmd_hdr.type) {
>> +    case VIRTIO_GPU_CMD_CTX_CREATE:
>> +        rutabaga_cmd_context_create(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_CTX_DESTROY:
>> +        rutabaga_cmd_context_destroy(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_2D:
>> +        rutabaga_cmd_create_resource_2d(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_3D:
>> +        rutabaga_cmd_create_resource_3d(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_SUBMIT_3D:
>> +        rutabaga_cmd_submit_3d(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D:
>> +        rutabaga_cmd_transfer_to_host_2d(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D:
>> +        rutabaga_cmd_transfer_to_host_3d(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D:
>> +        rutabaga_cmd_transfer_from_host_3d(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING:
>> +        rutabaga_cmd_attach_backing(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:
>> +        rutabaga_cmd_detach_backing(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_SET_SCANOUT:
>> +        rutabaga_cmd_set_scanout(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_RESOURCE_FLUSH:
>> +        rutabaga_cmd_resource_flush(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_RESOURCE_UNREF:
>> +        rutabaga_cmd_resource_unref(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:
>> +        rutabaga_cmd_ctx_attach_resource(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE:
>> +        rutabaga_cmd_ctx_detach_resource(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_GET_CAPSET_INFO:
>> +        rutabaga_cmd_get_capset_info(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_GET_CAPSET:
>> +        rutabaga_cmd_get_capset(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:
>> +        virtio_gpu_get_display_info(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_GET_EDID:
>> +        virtio_gpu_get_edid(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB:
>> +        rutabaga_cmd_resource_create_blob(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB:
>> +        rutabaga_cmd_resource_map_blob(g, cmd);
>> +        break;
>> +    case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:
>> +        rutabaga_cmd_resource_unmap_blob(g, cmd);
>> +        break;
>> +    default:
>> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>> +        break;
>> +    }
>> +
>> +    if (cmd->finished) {
>> +        return;
>> +    }
>> +    if (cmd->error) {
>> +        error_report("%s: ctrl 0x%x, error 0x%x", __func__,
>> +                     cmd->cmd_hdr.type, cmd->error);
>> +        virtio_gpu_ctrl_response_nodata(g, cmd, cmd->error);
>> +        return;
>> +    }
>> +    if (!(cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE)) {
>> +        virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODA=
TA);
>> +        return;
>> +    }
>> +
>> +    fence.flags =3D cmd->cmd_hdr.flags;
>> +    fence.ctx_id =3D cmd->cmd_hdr.ctx_id;
>> +    fence.fence_id =3D cmd->cmd_hdr.fence_id;
>> +    fence.ring_idx =3D cmd->cmd_hdr.ring_idx;
>> +
>> +    trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.typ=
e);
>> +
>> +    result =3D rutabaga_create_fence(vr->rutabaga, &fence);
>> +    CHECK_RESULT(result, cmd);
>> +}
>> +
>> +static void
>> +virtio_gpu_rutabaga_aio_cb(void *opaque)
>> +{
>> +    struct rutabaga_aio_data *data =3D  (struct rutabaga_aio_data *)opa=
que;
>> +    VirtIOGPU *g =3D (VirtIOGPU *)data->vr;
>> +    struct rutabaga_fence fence_data =3D data->fence;
>> +    struct virtio_gpu_ctrl_command *cmd, *tmp;
>> +
>> +    uint32_t signaled_ctx_specific =3D fence_data.flags &
>> +                                     RUTABAGA_FLAG_INFO_RING_IDX;
>> +
>> +    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
>> +        /*
>> +         * Due to context specific timelines.
>> +         */
>> +        uint32_t target_ctx_specific =3D cmd->cmd_hdr.flags &
>> +                                       RUTABAGA_FLAG_INFO_RING_IDX;
>> +
>> +        if (signaled_ctx_specific !=3D target_ctx_specific) {
>> +            continue;
>> +        }
>> +
>> +        if (signaled_ctx_specific &&
>> +           (cmd->cmd_hdr.ring_idx !=3D fence_data.ring_idx)) {
>> +            continue;
>> +        }
>> +
>> +        if (cmd->cmd_hdr.fence_id > fence_data.fence_id) {
>> +            continue;
>> +        }
>> +
>> +        trace_virtio_gpu_fence_resp(cmd->cmd_hdr.fence_id);
>> +        virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODA=
TA);
>> +        QTAILQ_REMOVE(&g->fenceq, cmd, next);
>> +        g_free(cmd);
>> +    }
>> +
>> +    g_free(data);
>> +}
>> +
>> +static void
>> +virtio_gpu_rutabaga_fence_cb(uint64_t user_data,
>> +                             struct rutabaga_fence fence_data) {
>> +    struct rutabaga_aio_data *data;
>> +    VirtIOGPU *g =3D (VirtIOGPU *)user_data;
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    /*
>> +     * gfxstream and both cross-domain (and even newer versions virglre=
nderer:
>> +     * see VIRGL_RENDERER_ASYNC_FENCE_CB) like to signal fence completi=
on on
>> +     * threads ("callback threads") that are different from the thread =
that
>> +     * processes the command queue ("main thread").
>> +     *
>> +     * crosvm and other virtio-gpu 1.1implementations enable callback t=
hreads
>> +     * via locking.  However, on QEMU a deadlock is observed if
>> +     * virtio_gpu_ctrl_response_nodata(..) [used in the fence callback]=
 is used
>> +     * from a thread that is not the main thread.
>> +     *
>> +     * The reason is QEMU's internal locking is designed to work with Q=
EMU
>> +     * threads (see rcu_register_thread()) and not generic C/C++/Rust t=
hreads.
>> +     * For now, we can workaround this by scheduling the return of the
>> +     * fence descriptors on the main thread.
>> +     */
>> +
>> +    data =3D g_new0(struct rutabaga_aio_data, 1);
>> +    data->vr =3D vr;
>> +    data->fence =3D fence_data;
>> +    aio_bh_schedule_oneshot_full(vr->ctx, virtio_gpu_rutabaga_aio_cb,
>> +                                 (void *)data, "aio");
>> +}
>> +
>> +static int virtio_gpu_rutabaga_init(VirtIOGPU *g)
>> +{
>> +    int result;
>> +    uint64_t capset_mask;
>> +    struct rutabaga_channels channels =3D { 0 };
>> +    struct rutabaga_builder builder =3D { 0 };
>> +
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +    vr->rutabaga =3D NULL;
>> +
>> +    if (!vr->capset_names) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    builder.wsi =3D RUTABAGA_WSI_SURFACELESS;
>> +    /*
>> +     * Currently, if WSI is specified, the only valid strings are "surf=
aceless"
>> +     * or "headless".  Surfaceless doesn't create a native window surfa=
ce, but
>> +     * does copy from the render target to the Pixman buffer if a virti=
o-gpu
>> +     * 2D hypercall is issued.  Surfacless is the default.
>> +     *
>> +     * Headless is like surfaceless, but doesn't copy to the Pixman buf=
fer. The
>> +     * use case is automated testing environments where there is no nee=
d to view
>> +     * results.
>> +     *
>> +     * In the future, more performant virtio-gpu 2D UI integration may =
be added.
>> +     */
>> +    if (vr->wsi) {
>> +        if (!strcmp(vr->wsi, "surfaceless")) {
>
>
> g_str_equal() is a bit more readable
>
>>
>> +            vr->headless =3D false;
>> +        } else if (strcmp(vr->wsi, "headless")) {
>> +            vr->headless =3D true;
>> +        } else {
>> +            return -EINVAL;
>> +        }
>> +    }
>> +
>> +    result =3D rutabaga_calculate_capset_mask(vr->capset_names, &capset=
_mask);
>> +    if (result) {
>> +        return result;
>> +    }
>> +
>> +    /*
>> +     * rutabaga-0.1.1 is only compiled/tested with gfxstream and cross-=
domain
>> +     * support. Future versions may change this to have more context ty=
pes if
>> +     * there is any interest.
>> +     */
>> +    if (capset_mask & (BIT(RUTABAGA_CAPSET_VIRGL) |
>> +                       BIT(RUTABAGA_CAPSET_VIRGL2) |
>> +                       BIT(RUTABAGA_CAPSET_VENUS) |
>> +                       BIT(RUTABAGA_CAPSET_DRM))) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    builder.user_data =3D (uint64_t)(uintptr_t *)(void *)g;
>
>
> GPOINTER_TO_UINT(g) ?
>
>>
>> +    builder.fence_cb =3D virtio_gpu_rutabaga_fence_cb;
>> +    builder.capset_mask =3D capset_mask;
>> +
>> +    if (vr->wayland_socket_path) {
>> +        if ((builder.capset_mask & (1 << RUTABAGA_CAPSET_CROSS_DOMAIN))=
 =3D=3D 0) {
>> +            return -EINVAL;
>> +        }
>> +
>> +        channels.channels =3D
>> +          (struct rutabaga_channel *)calloc(1, sizeof(struct rutabaga_c=
hannel));
>
>
> g_new0(struct ruabaga_channel, 1)
>
>>
>> +        channels.num_channels =3D 1;
>> +        channels.channels[0].channel_name =3D vr->wayland_socket_path;
>> +        channels.channels[0].channel_type =3D RUTABAGA_CHANNEL_TYPE_WAY=
LAND;
>> +        builder.channels =3D &channels;
>> +    }
>> +
>> +    result =3D rutabaga_init(&builder, &vr->rutabaga);
>> +    if (builder.capset_mask & (1 << RUTABAGA_CAPSET_CROSS_DOMAIN)) {
>> +        free(channels.channels);
>
>
> g_free() (after switching to g_new)
>
>>
>> +    }
>> +
>> +    memset(&memory_regions, 0, MAX_SLOTS * sizeof(struct MemoryRegionIn=
fo));
>> +    vr->ctx =3D qemu_get_aio_context();
>> +    return result;
>> +}
>> +
>> +static int virtio_gpu_rutabaga_get_num_capsets(VirtIOGPU *g)
>> +{
>> +    int result;
>> +    uint32_t num_capsets;
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    if (!vr->rutabaga_active) {
>> +        result =3D virtio_gpu_rutabaga_init(g);
>> +        if (result) {
>> +            error_report("Failed to init rutabaga");
>> +            return 0;
>> +        }
>> +
>> +        vr->rutabaga_active =3D true;
>> +    }
>> +
>> +    result =3D rutabaga_get_num_capsets(vr->rutabaga, &num_capsets);
>> +    if (result) {
>> +        error_report("Failed to get capsets");
>> +        return 0;
>> +    }
>> +    vr->num_capsets =3D num_capsets;
>> +    return num_capsets;
>> +}
>> +
>> +static void virtio_gpu_rutabaga_handle_ctrl(VirtIODevice *vdev, VirtQue=
ue *vq)
>> +{
>> +    VirtIOGPU *g =3D VIRTIO_GPU(vdev);
>> +    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> +    struct virtio_gpu_ctrl_command *cmd;
>> +
>> +    if (!virtio_queue_ready(vq)) {
>> +        return;
>> +    }
>> +
>> +    if (!vr->rutabaga_active) {
>> +        int result =3D virtio_gpu_rutabaga_init(g);
>> +        if (!result) {
>> +            vr->rutabaga_active =3D true;
>> +        }
>> +    }
>> +
>> +    if (!vr->rutabaga_active) {
>> +        return;
>> +    }
>> +
>> +    cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command));
>> +    while (cmd) {
>> +        cmd->vq =3D vq;
>> +        cmd->error =3D 0;
>> +        cmd->finished =3D false;
>> +        QTAILQ_INSERT_TAIL(&g->cmdq, cmd, next);
>> +        cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command=
));
>> +    }
>> +
>> +    virtio_gpu_process_cmdq(g);
>> +}
>> +
>> +static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp=
)
>> +{
>> +    int num_capsets;
>> +    VirtIOGPUBase *bdev =3D VIRTIO_GPU_BASE(qdev);
>> +    VirtIOGPU *gpudev =3D VIRTIO_GPU(qdev);
>> +
>
>
> It would be simpler to call virtio_gpu_rutabaga_init() here, with Error a=
rgument etc, instead of indirectly from other places.
>
>> +    num_capsets =3D virtio_gpu_rutabaga_get_num_capsets(gpudev);
>> +    if (!num_capsets) {
>> +        return;
>> +    }
>> +
>> +#if HOST_BIG_ENDIAN
>> +    error_setg(errp, "rutabaga is not supported on bigendian platforms"=
);
>> +    return;
>> +#endif
>> +
>> +    bdev->conf.flags |=3D (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED);
>> +    bdev->conf.flags |=3D (1 << VIRTIO_GPU_FLAG_BLOB_ENABLED);
>> +    bdev->conf.flags |=3D (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED);
>> +
>> +    bdev->virtio_config.num_capsets =3D num_capsets;
>> +    virtio_gpu_device_realize(qdev, errp);
>> +}
>> +
>> +static Property virtio_gpu_rutabaga_properties[] =3D {
>> +    DEFINE_PROP_STRING("capset_names", VirtioGpuRutabaga, capset_names)=
,
>> +    DEFINE_PROP_STRING("wayland_socket_path", VirtioGpuRutabaga,
>> +                       wayland_socket_path),
>> +    DEFINE_PROP_STRING("wsi", VirtioGpuRutabaga, wsi),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void virtio_gpu_rutabaga_class_init(ObjectClass *klass, void *da=
ta)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
>> +    VirtIOGPUBaseClass *vbc =3D VIRTIO_GPU_BASE_CLASS(klass);
>> +    VirtIOGPUClass *vgc =3D VIRTIO_GPU_CLASS(klass);
>> +
>> +    vbc->gl_flushed =3D virtio_gpu_rutabaga_gl_flushed;
>> +    vgc->handle_ctrl =3D virtio_gpu_rutabaga_handle_ctrl;
>> +    vgc->process_cmd =3D virtio_gpu_rutabaga_process_cmd;
>> +    vgc->update_cursor_data =3D virtio_gpu_rutabaga_update_cursor;
>> +
>> +    vdc->realize =3D virtio_gpu_rutabaga_realize;
>> +    device_class_set_props(dc, virtio_gpu_rutabaga_properties);
>> +}
>> +
>> +static const TypeInfo virtio_gpu_rutabaga_info =3D {
>> +    .name =3D TYPE_VIRTIO_GPU_RUTABAGA,
>> +    .parent =3D TYPE_VIRTIO_GPU,
>> +    .instance_size =3D sizeof(VirtioGpuRutabaga),
>> +    .class_init =3D virtio_gpu_rutabaga_class_init,
>> +};
>> +module_obj(TYPE_VIRTIO_GPU_RUTABAGA);
>> +module_kconfig(VIRTIO_GPU);
>> +
>> +static void virtio_register_types(void)
>> +{
>> +    type_register_static(&virtio_gpu_rutabaga_info);
>> +}
>> +
>> +type_init(virtio_register_types)
>> +
>> +module_dep("hw-display-virtio-gpu");
>> diff --git a/hw/display/virtio-vga-rutabaga.c b/hw/display/virtio-vga-ru=
tabaga.c
>> new file mode 100644
>> index 0000000000..01831bd03f
>> --- /dev/null
>> +++ b/hw/display/virtio-vga-rutabaga.c
>> @@ -0,0 +1,52 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/pci/pci.h"
>> +#include "hw/qdev-properties.h"
>> +#include "hw/virtio/virtio-gpu.h"
>> +#include "hw/display/vga.h"
>> +#include "qapi/error.h"
>> +#include "qemu/module.h"
>> +#include "virtio-vga.h"
>> +#include "qom/object.h"
>> +
>> +#define TYPE_VIRTIO_VGA_RUTABAGA "virtio-vga-rutabaga"
>> +
>> +typedef struct VirtIOVGARUTABAGA VirtIOVGARUTABAGA;
>> +DECLARE_INSTANCE_CHECKER(VirtIOVGARUTABAGA, VIRTIO_VGA_RUTABAGA,
>> +                         TYPE_VIRTIO_VGA_RUTABAGA)
>> +
>> +struct VirtIOVGARUTABAGA {
>> +    VirtIOVGABase parent_obj;
>> +
>> +    VirtioGpuRutabaga   vdev;
>> +};
>> +
>> +static void virtio_vga_rutabaga_inst_initfn(Object *obj)
>> +{
>> +    VirtIOVGARUTABAGA *dev =3D VIRTIO_VGA_RUTABAGA(obj);
>> +
>> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
>> +                                TYPE_VIRTIO_GPU_RUTABAGA);
>> +    VIRTIO_VGA_BASE(dev)->vgpu =3D VIRTIO_GPU_BASE(&dev->vdev);
>> +}
>> +
>> +static VirtioPCIDeviceTypeInfo virtio_vga_rutabaga_info =3D {
>> +    .generic_name  =3D TYPE_VIRTIO_VGA_RUTABAGA,
>> +    .parent        =3D TYPE_VIRTIO_VGA_BASE,
>> +    .instance_size =3D sizeof(VirtIOVGARUTABAGA),
>> +    .instance_init =3D virtio_vga_rutabaga_inst_initfn,
>> +};
>> +module_obj(TYPE_VIRTIO_VGA_RUTABAGA);
>> +module_kconfig(VIRTIO_VGA);
>> +
>> +static void virtio_vga_register_types(void)
>> +{
>> +    if (have_vga) {
>> +        virtio_pci_types_register(&virtio_vga_rutabaga_info);
>> +    }
>> +}
>> +
>> +type_init(virtio_vga_register_types)
>> +
>> +module_dep("hw-display-virtio-vga");
>> --
>> 2.41.0.255.g8b1d071c50-goog
>>
>>
>
>
> --
> Marc-Andr=C3=A9 Lureau

