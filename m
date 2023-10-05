Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CF97B9AE5
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 07:25:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGqs-0004ot-Sk; Thu, 05 Oct 2023 01:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qoGqq-0004oN-4r
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 01:24:44 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qoGqj-0001EK-9E
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 01:24:43 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-27761d85b31so378862a91.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 22:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696483475; x=1697088275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tXr4snlikAEPuNoAX/RwZj8271BXRUdi5dRldG8OeWs=;
 b=jlpRVjNlWa37flgWUyQC4/nmSXyeIwojtO5FBP47W3FH+KpPbkGofaLIC4DKxXk5lK
 VAkQ6x7voaNfOAsAzwHXDLKFv8PpvSfLZmx2MRtcjA23ihKcmfEEr6JNl0yspExEhyPb
 +J33v9OnEzsmOxWkKuFROL42UdhP4BtKjVGPmxD61witovUg6ymcMqBTnTPayIcZ1iVe
 4jMxNXgHn9DCirJW9CEW+/Iba0nRbsOPMy2h7YB4PgvX1iUQJQpI+eb3rKVkuZVSN9mJ
 0gAmk8ATGqN3Yj6g1WbnJTYuOrF1toD3JSmAgp4HEK1Ead2oE6x+rAJY9vKqbfSN6QT/
 /nxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696483475; x=1697088275;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tXr4snlikAEPuNoAX/RwZj8271BXRUdi5dRldG8OeWs=;
 b=lgsG1pw2jvSnoRsObTfkfwDpYLDcHnrig6g670rxqUftmtaAI6ha89MSL+YfTGtlpF
 al9JE3NhtojMkNbqYcyaWLGQNqYudGEKovfMPVKbM3IVYcddIJfHy7Cp9Hg3KZjIvd7K
 kb5uD3vIh8u7kfad0zPYUp8s1RJ7P4VDywj7ZFM8T5Bbh99RdQUtJhs7zWKYx3PWStoc
 e7EvPzqAjvf1UF7NHOFsIL38eZhLN95wAZVvQcvUFh42TSDT++Mpmf896yIU4qWjm+F6
 Zg4etYS3qFgFNJhVGCa65uU+QBM93vvBbRxcN+6SrjjLT6RI7yYj6tZqjFt52OC2J0ML
 l8fQ==
X-Gm-Message-State: AOJu0YwyJ+edxx3Smc9/1VAJGYbdS9RE/sAPlEVTFscQIJyX0ZRgMASZ
 /Bf/qSWWi70gw3PO/f+15Z8=
X-Google-Smtp-Source: AGHT+IFIR/xTEXEOXb1rK1uqS+lPxwyU30nXGTPHHoUkdtCYkz1OhZg6ai4FAh28ElXbWO0z4JJgBw==
X-Received: by 2002:a17:90a:fb83:b0:262:ded7:63d with SMTP id
 cp3-20020a17090afb8300b00262ded7063dmr4300067pjb.17.1696483474889; 
 Wed, 04 Oct 2023 22:24:34 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 fa9-20020a17090af0c900b0027360359b70sm2536091pjb.48.2023.10.04.22.24.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 22:24:34 -0700 (PDT)
Message-ID: <389686fe-72f3-4e92-80ce-375681a87bc7@gmail.com>
Date: Thu, 5 Oct 2023 14:24:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 6/9] gfxstream + rutabaga: add initial support for
 gfxstream
Content-Language: en-US
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, hi@alyssa.is, ernunes@redhat.com,
 manos.pitsidianakis@linaro.org, mark.cave-ayland@ilande.co.uk,
 thuth@redhat.com
References: <20231005024330.836-1-gurchetansingh@chromium.org>
 <20231005024330.836-7-gurchetansingh@chromium.org>
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20231005024330.836-7-gurchetansingh@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2023/10/05 11:43, Gurchetan Singh wrote:
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
> Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/display/virtio-gpu-pci-rutabaga.c |   47 ++
>   hw/display/virtio-gpu-rutabaga.c     | 1113 ++++++++++++++++++++++++++
>   hw/display/virtio-vga-rutabaga.c     |   50 ++
>   3 files changed, 1210 insertions(+)
>   create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
>   create mode 100644 hw/display/virtio-gpu-rutabaga.c
>   create mode 100644 hw/display/virtio-vga-rutabaga.c
> 
> diff --git a/hw/display/virtio-gpu-pci-rutabaga.c b/hw/display/virtio-gpu-pci-rutabaga.c
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
> +OBJECT_DECLARE_SIMPLE_TYPE(VirtIOGPURutabagaPCI, VIRTIO_GPU_RUTABAGA_PCI)
> +
> +struct VirtIOGPURutabagaPCI {
> +    VirtIOGPUPCIBase parent_obj;
> +
> +    VirtIOGPURutabaga vdev;
> +};
> +
> +static void virtio_gpu_rutabaga_initfn(Object *obj)
> +{
> +    VirtIOGPURutabagaPCI *dev = VIRTIO_GPU_RUTABAGA_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_GPU_RUTABAGA);
> +    VIRTIO_GPU_PCI_BASE(obj)->vgpu = VIRTIO_GPU_BASE(&dev->vdev);
> +}
> +
> +static const TypeInfo virtio_gpu_rutabaga_pci_info[] = {
> +    {
> +        .name = TYPE_VIRTIO_GPU_RUTABAGA_PCI,
> +        .parent = TYPE_VIRTIO_GPU_PCI_BASE,
> +        .instance_size = sizeof(VirtIOGPURutabagaPCI),
> +        .instance_init = virtio_gpu_rutabaga_initfn,
> +        .interfaces = (InterfaceInfo[]) {
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
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
> new file mode 100644
> index 0000000000..84be29c6ec
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
> +#define CHECK(condition, cmd)                                                 \
> +    do {                                                                      \
> +        if (!(condition)) {                                                   \
> +            error_report("CHECK failed in %s() %s:" "%d", __func__,           \
> +                         __FILE__, __LINE__);                                 \
> +            (cmd)->error = VIRTIO_GPU_RESP_ERR_UNSPEC;                        \
> +            return;                                                           \
> +       }                                                                      \
> +    } while (0)
> +
> +struct rutabaga_aio_data {
> +    struct VirtIOGPURutabaga *vr;
> +    struct rutabaga_fence fence;
> +};
> +
> +static void
> +virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, struct virtio_gpu_scanout *s,
> +                                  uint32_t resource_id)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +    struct rutabaga_transfer transfer = { 0 };
> +    struct iovec transfer_iovec;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    res = virtio_gpu_find_resource(g, resource_id);
> +    if (!res) {
> +        return;
> +    }
> +
> +    if (res->width != s->current_cursor->width ||
> +        res->height != s->current_cursor->height) {
> +        return;
> +    }
> +
> +    transfer.x = 0;
> +    transfer.y = 0;
> +    transfer.z = 0;
> +    transfer.w = res->width;
> +    transfer.h = res->height;
> +    transfer.d = 1;
> +
> +    transfer_iovec.iov_base = s->current_cursor->data;
> +    transfer_iovec.iov_len = res->width * res->height * 4;
> +
> +    rutabaga_resource_transfer_read(vr->rutabaga, 0,
> +                                    resource_id, &transfer,
> +                                    &transfer_iovec);
> +}
> +
> +static void
> +virtio_gpu_rutabaga_gl_flushed(VirtIOGPUBase *b)
> +{
> +    VirtIOGPU *g = VIRTIO_GPU(b);
> +    virtio_gpu_process_cmdq(g);
> +}
> +
> +static void
> +rutabaga_cmd_create_resource_2d(VirtIOGPU *g,
> +                                struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct rutabaga_create_3d rc_3d = { 0 };
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_create_2d c2d;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(c2d);
> +    trace_virtio_gpu_cmd_res_create_2d(c2d.resource_id, c2d.format,
> +                                       c2d.width, c2d.height);
> +
> +    rc_3d.target = 2;
> +    rc_3d.format = c2d.format;
> +    rc_3d.bind = (1 << 1);
> +    rc_3d.width = c2d.width;
> +    rc_3d.height = c2d.height;
> +    rc_3d.depth = 1;
> +    rc_3d.array_size = 1;
> +    rc_3d.last_level = 0;
> +    rc_3d.nr_samples = 0;
> +    rc_3d.flags = VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
> +
> +    result = rutabaga_resource_create_3d(vr->rutabaga, c2d.resource_id, &rc_3d);
> +    CHECK(!result, cmd);
> +
> +    res = g_new0(struct virtio_gpu_simple_resource, 1);
> +    res->width = c2d.width;
> +    res->height = c2d.height;
> +    res->format = c2d.format;
> +    res->resource_id = c2d.resource_id;
> +
> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
> +}
> +
> +static void
> +rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
> +                                struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct rutabaga_create_3d rc_3d = { 0 };
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_create_3d c3d;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(c3d);
> +
> +    trace_virtio_gpu_cmd_res_create_3d(c3d.resource_id, c3d.format,
> +                                       c3d.width, c3d.height, c3d.depth);
> +
> +    rc_3d.target = c3d.target;
> +    rc_3d.format = c3d.format;
> +    rc_3d.bind = c3d.bind;
> +    rc_3d.width = c3d.width;
> +    rc_3d.height = c3d.height;
> +    rc_3d.depth = c3d.depth;
> +    rc_3d.array_size = c3d.array_size;
> +    rc_3d.last_level = c3d.last_level;
> +    rc_3d.nr_samples = c3d.nr_samples;
> +    rc_3d.flags = c3d.flags;
> +
> +    result = rutabaga_resource_create_3d(vr->rutabaga, c3d.resource_id, &rc_3d);
> +    CHECK(!result, cmd);
> +
> +    res = g_new0(struct virtio_gpu_simple_resource, 1);
> +    res->width = c3d.width;
> +    res->height = c3d.height;
> +    res->format = c3d.format;
> +    res->resource_id = c3d.resource_id;
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
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(unref);
> +
> +    trace_virtio_gpu_cmd_res_unref(unref.resource_id);
> +
> +    res = virtio_gpu_find_resource(g, unref.resource_id);
> +    CHECK(res, cmd);
> +
> +    result = rutabaga_resource_unref(vr->rutabaga, unref.resource_id);
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
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(cc);
> +    trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,
> +                                    cc.debug_name);
> +
> +    result = rutabaga_context_create(vr->rutabaga, cc.hdr.ctx_id,
> +                                     cc.context_init, cc.debug_name, cc.nlen);
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
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(cd);
> +    trace_virtio_gpu_cmd_ctx_destroy(cd.hdr.ctx_id);
> +
> +    result = rutabaga_context_destroy(vr->rutabaga, cd.hdr.ctx_id);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_resource_flush(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result, i;
> +    struct virtio_gpu_scanout *scanout = NULL;
> +    struct virtio_gpu_simple_resource *res;
> +    struct rutabaga_transfer transfer = { 0 };
> +    struct iovec transfer_iovec;
> +    struct virtio_gpu_resource_flush rf;
> +    bool found = false;
> +
> +    VirtIOGPUBase *vb = VIRTIO_GPU_BASE(g);
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +    if (vr->headless) {
> +        return;
> +    }
> +
> +    VIRTIO_GPU_FILL_CMD(rf);
> +    trace_virtio_gpu_cmd_res_flush(rf.resource_id,
> +                                   rf.r.width, rf.r.height, rf.r.x, rf.r.y);
> +
> +    res = virtio_gpu_find_resource(g, rf.resource_id);
> +    CHECK(res, cmd);
> +
> +    for (i = 0; i < vb->conf.max_outputs; i++) {
> +        scanout = &vb->scanout[i];
> +        if (i == res->scanout_bitmask) {
> +            found = true;
> +            break;
> +        }
> +    }
> +
> +    if (!found) {
> +        return;
> +    }
> +
> +    transfer.x = 0;
> +    transfer.y = 0;
> +    transfer.z = 0;
> +    transfer.w = res->width;
> +    transfer.h = res->height;
> +    transfer.d = 1;
> +
> +    transfer_iovec.iov_base = pixman_image_get_data(res->image);
> +    transfer_iovec.iov_len = res->width * res->height * 4;
> +
> +    result = rutabaga_resource_transfer_read(vr->rutabaga, 0,
> +                                             rf.resource_id, &transfer,
> +                                             &transfer_iovec);
> +    CHECK(!result, cmd);
> +    dpy_gfx_update_full(scanout->con);
> +}
> +
> +static void
> +rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_scanout *scanout = NULL;
> +    struct virtio_gpu_set_scanout ss;
> +
> +    VirtIOGPUBase *vb = VIRTIO_GPU_BASE(g);
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +    if (vr->headless) {
> +        return;
> +    }
> +
> +    VIRTIO_GPU_FILL_CMD(ss);
> +    trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_id,
> +                                     ss.r.width, ss.r.height, ss.r.x, ss.r.y);
> +
> +    CHECK(ss.scanout_id < VIRTIO_GPU_MAX_SCANOUTS, cmd);
> +    scanout = &vb->scanout[ss.scanout_id];
> +
> +    if (ss.resource_id == 0) {
> +        dpy_gfx_replace_surface(scanout->con, NULL);
> +        dpy_gl_scanout_disable(scanout->con);
> +        return;
> +    }
> +
> +    res = virtio_gpu_find_resource(g, ss.resource_id);
> +    CHECK(res, cmd);
> +
> +    if (!res->image) {
> +        pixman_format_code_t pformat;
> +        pformat = virtio_gpu_get_pixman_format(res->format);
> +        CHECK(pformat, cmd);
> +
> +        res->image = pixman_image_create_bits(pformat,
> +                                              res->width,
> +                                              res->height,
> +                                              NULL, 0);
> +        CHECK(res->image, cmd);
> +        pixman_image_ref(res->image);
> +    }
> +
> +    vb->enable = 1;
> +
> +    /* realloc the surface ptr */
> +    scanout->ds = qemu_create_displaysurface_pixman(res->image);
> +    dpy_gfx_replace_surface(scanout->con, NULL);
> +    dpy_gfx_replace_surface(scanout->con, scanout->ds);
> +    res->scanout_bitmask = ss.scanout_id;
> +}
> +
> +static void
> +rutabaga_cmd_submit_3d(VirtIOGPU *g,
> +                       struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_cmd_submit cs;
> +    struct rutabaga_command rutabaga_cmd = { 0 };
> +    g_autofree uint8_t *buf = NULL;
> +    size_t s;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(cs);
> +    trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size);
> +
> +    buf = g_new0(uint8_t, cs.size);
> +    s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> +                   sizeof(cs), buf, cs.size);
> +    CHECK(s == cs.size, cmd);
> +
> +    rutabaga_cmd.ctx_id = cs.hdr.ctx_id;
> +    rutabaga_cmd.cmd = buf;
> +    rutabaga_cmd.cmd_size = cs.size;
> +
> +    result = rutabaga_submit_command(vr->rutabaga, &rutabaga_cmd);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_transfer_to_host_2d(VirtIOGPU *g,
> +                                 struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct rutabaga_transfer transfer = { 0 };
> +    struct virtio_gpu_transfer_to_host_2d t2d;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(t2d);
> +    trace_virtio_gpu_cmd_res_xfer_toh_2d(t2d.resource_id);
> +
> +    transfer.x = t2d.r.x;
> +    transfer.y = t2d.r.y;
> +    transfer.z = 0;
> +    transfer.w = t2d.r.width;
> +    transfer.h = t2d.r.height;
> +    transfer.d = 1;
> +
> +    result = rutabaga_resource_transfer_write(vr->rutabaga, 0, t2d.resource_id,
> +                                              &transfer);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_transfer_to_host_3d(VirtIOGPU *g,
> +                                 struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct rutabaga_transfer transfer = { 0 };
> +    struct virtio_gpu_transfer_host_3d t3d;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(t3d);
> +    trace_virtio_gpu_cmd_res_xfer_toh_3d(t3d.resource_id);
> +
> +    transfer.x = t3d.box.x;
> +    transfer.y = t3d.box.y;
> +    transfer.z = t3d.box.z;
> +    transfer.w = t3d.box.w;
> +    transfer.h = t3d.box.h;
> +    transfer.d = t3d.box.d;
> +    transfer.level = t3d.level;
> +    transfer.stride = t3d.stride;
> +    transfer.layer_stride = t3d.layer_stride;
> +    transfer.offset = t3d.offset;
> +
> +    result = rutabaga_resource_transfer_write(vr->rutabaga, t3d.hdr.ctx_id,
> +                                              t3d.resource_id, &transfer);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_transfer_from_host_3d(VirtIOGPU *g,
> +                                   struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct rutabaga_transfer transfer = { 0 };
> +    struct virtio_gpu_transfer_host_3d t3d;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(t3d);
> +    trace_virtio_gpu_cmd_res_xfer_fromh_3d(t3d.resource_id);
> +
> +    transfer.x = t3d.box.x;
> +    transfer.y = t3d.box.y;
> +    transfer.z = t3d.box.z;
> +    transfer.w = t3d.box.w;
> +    transfer.h = t3d.box.h;
> +    transfer.d = t3d.box.d;
> +    transfer.level = t3d.level;
> +    transfer.stride = t3d.stride;
> +    transfer.layer_stride = t3d.layer_stride;
> +    transfer.offset = t3d.offset;
> +
> +    result = rutabaga_resource_transfer_read(vr->rutabaga, t3d.hdr.ctx_id,
> +                                             t3d.resource_id, &transfer, NULL);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_attach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct rutabaga_iovecs vecs = { 0 };
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_attach_backing att_rb;
> +    int ret;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(att_rb);
> +    trace_virtio_gpu_cmd_res_back_attach(att_rb.resource_id);
> +
> +    res = virtio_gpu_find_resource(g, att_rb.resource_id);
> +    CHECK(res, cmd);
> +    CHECK(!res->iov, cmd);
> +
> +    ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
> +                                        cmd, NULL, &res->iov, &res->iov_cnt);
> +    CHECK(!ret, cmd);
> +
> +    vecs.iovecs = res->iov;
> +    vecs.num_iovecs = res->iov_cnt;
> +
> +    ret = rutabaga_resource_attach_backing(vr->rutabaga, att_rb.resource_id,
> +                                           &vecs);
> +    if (ret != 0) {
> +        virtio_gpu_cleanup_mapping(g, res);
> +    }
> +
> +    CHECK(!ret, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_detach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_detach_backing detach_rb;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(detach_rb);
> +    trace_virtio_gpu_cmd_res_back_detach(detach_rb.resource_id);
> +
> +    res = virtio_gpu_find_resource(g, detach_rb.resource_id);
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
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(att_res);
> +    trace_virtio_gpu_cmd_ctx_res_attach(att_res.hdr.ctx_id,
> +                                        att_res.resource_id);
> +
> +    result = rutabaga_context_attach_resource(vr->rutabaga, att_res.hdr.ctx_id,
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
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(det_res);
> +    trace_virtio_gpu_cmd_ctx_res_detach(det_res.hdr.ctx_id,
> +                                        det_res.resource_id);
> +
> +    result = rutabaga_context_detach_resource(vr->rutabaga, det_res.hdr.ctx_id,
> +                                              det_res.resource_id);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_get_capset_info info;
> +    struct virtio_gpu_resp_capset_info resp;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(info);
> +
> +    result = rutabaga_get_capset_info(vr->rutabaga, info.capset_index,
> +                                      &resp.capset_id, &resp.capset_max_version,
> +                                      &resp.capset_max_size);
> +    CHECK(!result, cmd);
> +
> +    resp.hdr.type = VIRTIO_GPU_RESP_OK_CAPSET_INFO;
> +    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
> +}
> +
> +static void
> +rutabaga_cmd_get_capset(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_get_capset gc;
> +    struct virtio_gpu_resp_capset *resp;
> +    uint32_t capset_size, capset_version;
> +    uint32_t current_id, i;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(gc);
> +    for (i = 0; i < vr->num_capsets; i++) {
> +        result = rutabaga_get_capset_info(vr->rutabaga, i,
> +                                          &current_id, &capset_version,
> +                                          &capset_size);
> +        CHECK(!result, cmd);
> +
> +        if (current_id == gc.capset_id) {
> +            break;
> +        }
> +    }
> +
> +    CHECK(i < vr->num_capsets, cmd);
> +
> +    resp = g_malloc0(sizeof(*resp) + capset_size);
> +    resp->hdr.type = VIRTIO_GPU_RESP_OK_CAPSET;
> +    rutabaga_get_capset(vr->rutabaga, gc.capset_id, gc.capset_version,
> +                        resp->capset_data, capset_size);
> +
> +    virtio_gpu_ctrl_response(g, cmd, &resp->hdr, sizeof(*resp) + capset_size);
> +    g_free(resp);
> +}
> +
> +static void
> +rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
> +                                  struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int result;
> +    struct rutabaga_iovecs vecs = { 0 };
> +    g_autofree struct virtio_gpu_simple_resource *res = NULL;
> +    struct virtio_gpu_resource_create_blob cblob;
> +    struct rutabaga_create_blob rc_blob = { 0 };
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(cblob);
> +    trace_virtio_gpu_cmd_res_create_blob(cblob.resource_id, cblob.size);
> +
> +    CHECK(cblob.resource_id != 0, cmd);
> +
> +    res = g_new0(struct virtio_gpu_simple_resource, 1);
> +
> +    res->resource_id = cblob.resource_id;
> +    res->blob_size = cblob.size;
> +
> +    if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
> +        result = virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
> +                                               sizeof(cblob), cmd, &res->addrs,
> +                                               &res->iov, &res->iov_cnt);
> +        CHECK(!result, cmd);
> +    }
> +
> +    rc_blob.blob_id = cblob.blob_id;
> +    rc_blob.blob_mem = cblob.blob_mem;
> +    rc_blob.blob_flags = cblob.blob_flags;
> +    rc_blob.size = cblob.size;
> +
> +    vecs.iovecs = res->iov;
> +    vecs.num_iovecs = res->iov_cnt;
> +
> +    result = rutabaga_resource_create_blob(vr->rutabaga, cblob.hdr.ctx_id,
> +                                           cblob.resource_id, &rc_blob, &vecs,
> +                                           NULL);
> +
> +    if (result && cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
> +        virtio_gpu_cleanup_mapping(g, res);
> +    }
> +
> +    CHECK(!result, cmd);
> +
> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
> +    res = NULL;
> +}
> +
> +static void
> +rutabaga_cmd_resource_map_blob(VirtIOGPU *g,
> +                               struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    uint32_t map_info = 0;
> +    uint32_t slot = 0;
> +    struct virtio_gpu_simple_resource *res;
> +    struct rutabaga_mapping mapping = { 0 };
> +    struct virtio_gpu_resource_map_blob mblob;
> +    struct virtio_gpu_resp_map_info resp = { 0 };
> +
> +    VirtIOGPUBase *vb = VIRTIO_GPU_BASE(g);
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(mblob);
> +
> +    CHECK(mblob.resource_id != 0, cmd);
> +
> +    res = virtio_gpu_find_resource(g, mblob.resource_id);
> +    CHECK(res, cmd);
> +
> +    result = rutabaga_resource_map_info(vr->rutabaga, mblob.resource_id,
> +                                        &map_info);
> +    CHECK(!result, cmd);
> +
> +    /*
> +     * RUTABAGA_MAP_ACCESS_* flags are not part of the virtio-gpu spec, but do
> +     * exist to potentially allow the hypervisor to restrict write access to
> +     * memory. QEMU does not need to use this functionality at the moment.
> +     */
> +    resp.map_info = map_info & RUTABAGA_MAP_CACHE_MASK;
> +
> +    result = rutabaga_resource_map(vr->rutabaga, mblob.resource_id, &mapping);
> +    CHECK(!result, cmd);
> +
> +    /*
> +     * There is small risk of the MemoryRegion still deferencing the pointer

s/deferencing/dereferencing/

