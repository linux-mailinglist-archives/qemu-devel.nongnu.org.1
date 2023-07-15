Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9A5754BE4
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 22:00:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKlPe-0002E5-M7; Sat, 15 Jul 2023 15:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qKlPc-0002Dn-2W
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 15:58:41 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qKlPY-0000vS-0b
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 15:58:39 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52164adea19so2288059a12.1
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 12:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689451114; x=1692043114;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QlbihZFv5ymy7RKr/hG6juVxXYRM1+TcfMHb2OutXTQ=;
 b=LUwTpau6v0xjXbCGOrJ4Sx/02WWEEoasbqHLX/QJFNmIK4T9OFA5BcneDeExemjVTo
 pakladkT7QZ5dkG3CX0MKwLGtEYOIhfq1olm/IrfF3Br1avS9PB0GgeHBu/UfXNiXxZF
 FgblV54c+Rw8xzBpEmhsCDKDKh7KsK4oB4ulaknGgxCggN0XI6Yg7UDCppNNv2TnBYSl
 EZT15+8fk0f571Be11aTv59OimxdvbQkPaVtePhlP5xuwDpOo47yWvJNJ0+cW3/uDP/j
 6oy6uBRuISiDoeENf5IsucACFV03W3To6ur6ZYPbXH+cEj/cEo++xCcr82rn4dU/0VKL
 4m5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689451114; x=1692043114;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QlbihZFv5ymy7RKr/hG6juVxXYRM1+TcfMHb2OutXTQ=;
 b=Qad+dMuCB4uo2WbDmpkT+A+ShKgR1awX0XY9owNMfF45K3LMsyE0P1GsdewRMKZwYu
 4VNK/Ki6i/jqeinv091+JyJnPEe26N/K8Euq9h2QQDnBrCFWW1zrYbcVvOUMpAYDvwFK
 CUIjmtMrdWmENsRMqdRD7GU2PGAcxu0LVq6qkY732JMbW0T+RSoUVtulkSa9/e1Tu6/L
 JnV+XiB6xBwVhP3ynp6W/kFPtAOr/hoisbw/hhS1ehSqkALeRCjlSoBqMyUbg54KmfBX
 zQZsM3v0bj8uxBwR0YglIHbAXPIfaAGVhqVC0MppJ1qoRCFVKIb84pb0noBk0UejpJDa
 FvLg==
X-Gm-Message-State: ABy/qLaRDF/t+H6NYkAS/qTzckQmbKGm5xUIWh7vXFozU6cSkCDGpNiU
 jzchA32sg2+9Ypj71ymIMPw=
X-Google-Smtp-Source: APBJJlHhfS4wMOgO+GvwZ+RPs9DbdWBylkGVy/ctBHSdX0FpdnkUkabtsQiOEeXMJOaWplr8/nrbWw==
X-Received: by 2002:aa7:d5ca:0:b0:51d:a181:d78e with SMTP id
 d10-20020aa7d5ca000000b0051da181d78emr6865240eds.27.1689451113341; 
 Sat, 15 Jul 2023 12:58:33 -0700 (PDT)
Received: from ?IPv6:::1?
 (p200300faaf258000fd56d6ca1aee2dc7.dip0.t-ipconnect.de.
 [2003:fa:af25:8000:fd56:d6ca:1aee:2dc7])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a50ef06000000b0051d890b2407sm7351838eds.81.2023.07.15.12.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Jul 2023 12:58:32 -0700 (PDT)
Date: Sat, 15 Jul 2023 19:58:28 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
CC: --cc=kraxel@redhat.com, marcandre.lureau@redhat.com,
 akihiko.odaki@gmail.com, 
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_6/9=5D_gfxstream_+_rutaba?=
 =?US-ASCII?Q?ga=3A_add_initial_support_for_gfxstream?=
In-Reply-To: <20230711025649.708-7-gurchetansingh@chromium.org>
References: <20230711025649.708-1-gurchetansingh@chromium.org>
 <20230711025649.708-7-gurchetansingh@chromium.org>
Message-ID: <D15471EC-D1D1-4DAA-A6E7-19827C36AEC8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
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



Am 11=2E Juli 2023 02:56:46 UTC schrieb Gurchetan Singh <gurchetansingh@ch=
romium=2Eorg>:
>This adds initial support for gfxstream and cross-domain=2E  Both
>features rely on virtio-gpu blob resources and context types, which
>are also implemented in this patch=2E
>
>gfxstream has a long and illustrious history in Android graphics
>paravirtualization=2E  It has been powering graphics in the Android
>Studio Emulator for more than a decade, which is the main developer
>platform=2E
>
>Originally conceived by Jesse Hall, it was first known as "EmuGL" [a]=2E
>The key design characteristic was a 1:1 threading model and
>auto-generation, which fit nicely with the OpenGLES spec=2E  It also
>allowed easy layering with ANGLE on the host, which provides the GLES
>implementations on Windows or MacOS enviroments=2E
>
>gfxstream has traditionally been maintained by a single engineer, and
>between 2015 to 2021, the goldfish throne passed to Frank Yang=2E
>Historians often remark this glorious reign ("pax gfxstreama" is the
>academic term) was comparable to that of Augustus and the both Queen
>Elizabeths=2E  Just to name a few accomplishments in a resplendent
>panoply: higher versions of GLES, address space graphics, snapshot
>support and CTS compliant Vulkan [b]=2E
>
>One major drawback was the use of out-of-tree goldfish drivers=2E
>Android engineers didn't know much about DRM/KMS and especially TTM so
>a simple guest to host pipe was conceived=2E
>
>Luckily, virtio-gpu 3D started to emerge in 2016 due to the work of
>the Mesa/virglrenderer communities=2E  In 2018, the initial virtio-gpu
>port of gfxstream was done by Cuttlefish enthusiast Alistair Delva=2E
>It was a symbol compatible replacement of virglrenderer [c] and named
>"AVDVirglrenderer"=2E  This implementation forms the basis of the
>current gfxstream host implementation still in use today=2E
>
>cross-domain support follows a similar arc=2E  Originally conceived by
>Wayland aficionado David Reveman and crosvm enjoyer Zach Reizner in
>2018, it initially relied on the downstream "virtio-wl" device=2E
>
>In 2020 and 2021, virtio-gpu was extended to include blob resources
>and multiple timelines by yours truly, features gfxstream/cross-domain
>both require to function correctly=2E
>
>Right now, we stand at the precipice of a truly fantastic possibility:
>the Android Emulator powered by upstream QEMU and upstream Linux
>kernel=2E  gfxstream will then be packaged properfully, and app
>developers can even fix gfxstream bugs on their own if they encounter
>them=2E
>
>It's been quite the ride, my friends=2E  Where will gfxstream head next,
>nobody really knows=2E  I wouldn't be surprised if it's around for
>another decade, maintained by a new generation of Android graphics
>enthusiasts=2E

AFAIU gfxstream is a substitute for virglrenderer and relies on an auto-ge=
nerated interface based on OpenGL/Vulkan between host and guest=2E I would =
like to use it in QEMU (Windows host, Linux guest)=2E

So I tried to test your series under Linux (for now)=2E For now, I couldn'=
t get past the point of aborts with generic error messages or no error mess=
ages with blank screens=2E Though my Linux host might not provide a recent =
enough environment=2E

Read on for some technical reviews below=2E

>
>Technical details:
>  - Very simple initial display integration: just used Pixman
>  - Largely, 1:1 mapping of virtio-gpu hypercalls to rutabaga function
>    calls
>
>[a] https://android-review=2Egooglesource=2Ecom/c/platform/development/+/=
34470
>[b] https://android-review=2Egooglesource=2Ecom/q/topic:%22vulkan-hostcon=
nection-start%22
>[c] https://android-review=2Egooglesource=2Ecom/c/device/generic/goldfish=
-opengl/+/761927
>
>Signed-off-by: Gurchetan Singh <gurchetansingh@chromium=2Eorg>
>---
>v2: Incorported various suggestions by Akihiko Odaki and Bernard Berschow
>    - Removed GET_VIRTIO_GPU_GL / GET_RUTABAGA macros
>    - Used error_report(=2E=2E)
>    - Used g_autofree to fix leaks on error paths
>    - Removed unnecessary casts
>    - added virtio-gpu-pci-rutabaga=2Ec + virtio-vga-rutabaga=2Ec files
>
> hw/display/virtio-gpu-pci-rutabaga=2Ec |   48 ++
> hw/display/virtio-gpu-rutabaga=2Ec     | 1088 ++++++++++++++++++++++++++
> hw/display/virtio-vga-rutabaga=2Ec     |   52 ++
> 3 files changed, 1188 insertions(+)
> create mode 100644 hw/display/virtio-gpu-pci-rutabaga=2Ec
> create mode 100644 hw/display/virtio-gpu-rutabaga=2Ec
> create mode 100644 hw/display/virtio-vga-rutabaga=2Ec
>
>diff --git a/hw/display/virtio-gpu-pci-rutabaga=2Ec b/hw/display/virtio-g=
pu-pci-rutabaga=2Ec
>new file mode 100644
>index 0000000000=2E=2E5765bef266
>--- /dev/null
>+++ b/hw/display/virtio-gpu-pci-rutabaga=2Ec
>@@ -0,0 +1,48 @@
>+// SPDX-License-Identifier: GPL-2=2E0
>+
>+#include "qemu/osdep=2Eh"
>+#include "qapi/error=2Eh"
>+#include "qemu/module=2Eh"
>+#include "hw/pci/pci=2Eh"
>+#include "hw/qdev-properties=2Eh"
>+#include "hw/virtio/virtio=2Eh"
>+#include "hw/virtio/virtio-bus=2Eh"
>+#include "hw/virtio/virtio-gpu-pci=2Eh"
>+#include "qom/object=2Eh"
>+
>+#define TYPE_VIRTIO_GPU_RUTABAGA_PCI "virtio-gpu-rutabaga-pci"
>+typedef struct VirtIOGPURUTABAGAPCI VirtIOGPURUTABAGAPCI;
>+DECLARE_INSTANCE_CHECKER(VirtIOGPURUTABAGAPCI, VIRTIO_GPU_RUTABAGA_PCI,
>+                         TYPE_VIRTIO_GPU_RUTABAGA_PCI)
>+
>+struct VirtIOGPURUTABAGAPCI {
>+    VirtIOGPUPCIBase parent_obj;
>+    VirtioGpuRutabaga   vdev;
>+};
>+
>+static void virtio_gpu_rutabaga_initfn(Object *obj)
>+{
>+    VirtIOGPURUTABAGAPCI *dev =3D VIRTIO_GPU_RUTABAGA_PCI(obj);
>+
>+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
>+                                TYPE_VIRTIO_GPU_RUTABAGA);
>+    VIRTIO_GPU_PCI_BASE(obj)->vgpu =3D VIRTIO_GPU_BASE(&dev->vdev);
>+}
>+
>+static const VirtioPCIDeviceTypeInfo virtio_gpu_rutabaga_pci_info =3D {
>+    =2Egeneric_name =3D TYPE_VIRTIO_GPU_RUTABAGA_PCI,
>+    =2Eparent =3D TYPE_VIRTIO_GPU_PCI_BASE,
>+    =2Einstance_size =3D sizeof(VirtIOGPURUTABAGAPCI),
>+    =2Einstance_init =3D virtio_gpu_rutabaga_initfn,
>+};
>+module_obj(TYPE_VIRTIO_GPU_RUTABAGA_PCI);
>+module_kconfig(VIRTIO_PCI);
>+
>+static void virtio_gpu_rutabaga_pci_register_types(void)
>+{
>+    virtio_pci_types_register(&virtio_gpu_rutabaga_pci_info);
>+}
>+
>+type_init(virtio_gpu_rutabaga_pci_register_types)
>+
>+module_dep("hw-display-virtio-gpu-pci");
>diff --git a/hw/display/virtio-gpu-rutabaga=2Ec b/hw/display/virtio-gpu-r=
utabaga=2Ec
>new file mode 100644
>index 0000000000=2E=2Eb60a30a093
>--- /dev/null
>+++ b/hw/display/virtio-gpu-rutabaga=2Ec
>@@ -0,0 +1,1088 @@
>+// SPDX-License-Identifier: GPL-2=2E0
>+
>+#include "qemu/osdep=2Eh"
>+#include "qemu/error-report=2Eh"
>+#include "qemu/iov=2Eh"
>+#include "trace=2Eh"
>+#include "hw/virtio/virtio=2Eh"
>+#include "hw/virtio/virtio-gpu=2Eh"
>+#include "hw/virtio/virtio-gpu-pixman=2Eh"
>+#include "hw/virtio/virtio-iommu=2Eh"
>+
>+#include <glib/gmem=2Eh>
>+#include <rutabaga_gfx/rutabaga_gfx_ffi=2Eh>
>+
>+#define CHECK(condition, cmd)                                           =
      \
>+    do {                                                                =
      \
>+        if (!condition) {                                               =
      \
>+            error_report("CHECK failed in %s() %s:" "%d", __func__,     =
      \
>+                         __FILE__, __LINE__);                           =
      \
>+            cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;                  =
        \
>+            return;                                                     =
      \
>+       }                                                                =
      \
>+    } while (0)
>+
>+#define CHECK_RESULT(result, cmd) CHECK(result =3D=3D 0, cmd)
>+
>+#define MAX_SLOTS 4096
>+
>+struct MemoryRegionInfo {
>+    int used;
>+    MemoryRegion mr;
>+    uint32_t resource_id;
>+};
>+
>+static struct MemoryRegionInfo memory_regions[MAX_SLOTS];
>+
>+struct rutabaga_aio_data {
>+    struct VirtioGpuRutabaga *vr;
>+    struct rutabaga_fence fence;
>+};
>+
>+static void
>+virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, struct virtio_gpu_scanou=
t *s,
>+                                  uint32_t resource_id)
>+{
>+    struct virtio_gpu_simple_resource *res;
>+    struct rutabaga_transfer transfer =3D { 0 };
>+    struct iovec transfer_iovec;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    res =3D virtio_gpu_find_resource(g, resource_id);
>+    if (!res) {
>+        return;
>+    }
>+
>+    if (res->width !=3D s->current_cursor->width ||
>+        res->height !=3D s->current_cursor->height) {
>+        return;
>+    }
>+
>+    transfer=2Ex =3D 0;
>+    transfer=2Ey =3D 0;
>+    transfer=2Ez =3D 0;
>+    transfer=2Ew =3D res->width;
>+    transfer=2Eh =3D res->height;
>+    transfer=2Ed =3D 1;
>+
>+    transfer_iovec=2Eiov_base =3D (void *)s->current_cursor->data;
>+    transfer_iovec=2Eiov_len =3D res->width * res->height * 4;
>+
>+    rutabaga_resource_transfer_read(vr->rutabaga, 0,
>+                                    resource_id, &transfer,
>+                                    &transfer_iovec);
>+}
>+
>+static void
>+virtio_gpu_rutabaga_gl_flushed(VirtIOGPUBase *b)
>+{
>+    VirtIOGPU *g =3D VIRTIO_GPU(b);
>+    virtio_gpu_process_cmdq(g);
>+}
>+
>+static void
>+rutabaga_cmd_create_resource_2d(VirtIOGPU *g,
>+                                struct virtio_gpu_ctrl_command *cmd)
>+{
>+    int32_t result;
>+    struct rutabaga_create_3d rc_3d =3D { 0 };
>+    struct virtio_gpu_simple_resource *res;
>+    struct virtio_gpu_resource_create_2d c2d;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    VIRTIO_GPU_FILL_CMD(c2d);
>+    trace_virtio_gpu_cmd_res_create_2d(c2d=2Eresource_id, c2d=2Eformat,
>+                                       c2d=2Ewidth, c2d=2Eheight);
>+
>+    rc_3d=2Etarget =3D 2;
>+    rc_3d=2Eformat =3D c2d=2Eformat;
>+    rc_3d=2Ebind =3D (1 << 1);
>+    rc_3d=2Ewidth =3D c2d=2Ewidth;
>+    rc_3d=2Eheight =3D c2d=2Eheight;
>+    rc_3d=2Edepth =3D 1;
>+    rc_3d=2Earray_size =3D 1;
>+    rc_3d=2Elast_level =3D 0;
>+    rc_3d=2Enr_samples =3D 0;
>+    rc_3d=2Eflags =3D VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
>+
>+    result =3D rutabaga_resource_create_3d(vr->rutabaga, c2d=2Eresource_=
id, &rc_3d);
>+    CHECK_RESULT(result, cmd);
>+
>+    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
>+    res->width =3D c2d=2Ewidth;
>+    res->height =3D c2d=2Eheight;
>+    res->format =3D c2d=2Eformat;
>+    res->resource_id =3D c2d=2Eresource_id;
>+
>+    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>+}
>+
>+static void
>+rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
>+                                struct virtio_gpu_ctrl_command *cmd)
>+{
>+    int32_t result;
>+    struct rutabaga_create_3d rc_3d =3D { 0 };
>+    struct virtio_gpu_simple_resource *res;
>+    struct virtio_gpu_resource_create_3d c3d;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    VIRTIO_GPU_FILL_CMD(c3d);
>+
>+    trace_virtio_gpu_cmd_res_create_3d(c3d=2Eresource_id, c3d=2Eformat,
>+                                       c3d=2Ewidth, c3d=2Eheight, c3d=2E=
depth);
>+
>+    rc_3d=2Etarget =3D c3d=2Etarget;
>+    rc_3d=2Eformat =3D c3d=2Eformat;
>+    rc_3d=2Ebind =3D c3d=2Ebind;
>+    rc_3d=2Ewidth =3D c3d=2Ewidth;
>+    rc_3d=2Eheight =3D c3d=2Eheight;
>+    rc_3d=2Edepth =3D c3d=2Edepth;
>+    rc_3d=2Earray_size =3D c3d=2Earray_size;
>+    rc_3d=2Elast_level =3D c3d=2Elast_level;
>+    rc_3d=2Enr_samples =3D c3d=2Enr_samples;
>+    rc_3d=2Eflags =3D c3d=2Eflags;
>+
>+    result =3D rutabaga_resource_create_3d(vr->rutabaga, c3d=2Eresource_=
id, &rc_3d);
>+    CHECK_RESULT(result, cmd);
>+
>+    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
>+    res->width =3D c3d=2Ewidth;
>+    res->height =3D c3d=2Eheight;
>+    res->format =3D c3d=2Eformat;
>+    res->resource_id =3D c3d=2Eresource_id;
>+
>+    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>+}
>+
>+static void
>+rutabaga_cmd_resource_unref(VirtIOGPU *g,
>+                            struct virtio_gpu_ctrl_command *cmd)
>+{
>+    int32_t result;
>+    struct virtio_gpu_simple_resource *res;
>+    struct virtio_gpu_resource_unref unref;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    VIRTIO_GPU_FILL_CMD(unref);
>+
>+    trace_virtio_gpu_cmd_res_unref(unref=2Eresource_id);
>+
>+    res =3D virtio_gpu_find_resource(g, unref=2Eresource_id);
>+    CHECK(res, cmd);
>+
>+    result =3D rutabaga_resource_unref(vr->rutabaga, unref=2Eresource_id=
);
>+    CHECK_RESULT(result, cmd);
>+
>+    if (res->image) {
>+        pixman_image_unref(res->image);
>+    }
>+
>+    QTAILQ_REMOVE(&g->reslist, res, next);
>+    g_free(res);
>+}
>+
>+static void
>+rutabaga_cmd_context_create(VirtIOGPU *g,
>+                            struct virtio_gpu_ctrl_command *cmd)
>+{
>+    int32_t result;
>+    struct virtio_gpu_ctx_create cc;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    VIRTIO_GPU_FILL_CMD(cc);
>+    trace_virtio_gpu_cmd_ctx_create(cc=2Ehdr=2Ectx_id,
>+                                    cc=2Edebug_name);
>+
>+    result =3D rutabaga_context_create(vr->rutabaga, cc=2Ehdr=2Ectx_id,
>+                                     cc=2Econtext_init, cc=2Edebug_name,=
 cc=2Enlen);
>+    CHECK_RESULT(result, cmd);
>+}
>+
>+static void
>+rutabaga_cmd_context_destroy(VirtIOGPU *g,
>+                             struct virtio_gpu_ctrl_command *cmd)
>+{
>+    int32_t result;
>+    struct virtio_gpu_ctx_destroy cd;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    VIRTIO_GPU_FILL_CMD(cd);
>+    trace_virtio_gpu_cmd_ctx_destroy(cd=2Ehdr=2Ectx_id);
>+
>+    result =3D rutabaga_context_destroy(vr->rutabaga, cd=2Ehdr=2Ectx_id)=
;
>+    CHECK_RESULT(result, cmd);
>+}
>+
>+static void
>+rutabaga_cmd_resource_flush(VirtIOGPU *g, struct virtio_gpu_ctrl_command=
 *cmd)
>+{
>+    int32_t result, i;
>+    struct virtio_gpu_scanout *scanout =3D NULL;
>+    struct virtio_gpu_simple_resource *res;
>+    struct rutabaga_transfer transfer =3D { 0 };
>+    struct iovec transfer_iovec;
>+    struct virtio_gpu_resource_flush rf;
>+    bool found =3D false;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+    if (vr->headless) {
>+        return;
>+    }
>+
>+    VIRTIO_GPU_FILL_CMD(rf);
>+    trace_virtio_gpu_cmd_res_flush(rf=2Eresource_id,
>+                                   rf=2Er=2Ewidth, rf=2Er=2Eheight, rf=
=2Er=2Ex, rf=2Er=2Ey);
>+
>+    res =3D virtio_gpu_find_resource(g, rf=2Eresource_id);
>+    CHECK(res, cmd);
>+
>+    for (i =3D 0; i < g->parent_obj=2Econf=2Emax_outputs; i++) {
>+        scanout =3D &g->parent_obj=2Escanout[i];
>+        if (i =3D=3D res->scanout_bitmask) {
>+            found =3D true;
>+            break;
>+        }
>+    }
>+
>+    if (!found) {
>+        return;
>+    }
>+
>+    transfer=2Ex =3D 0;
>+    transfer=2Ey =3D 0;
>+    transfer=2Ez =3D 0;
>+    transfer=2Ew =3D res->width;
>+    transfer=2Eh =3D res->height;
>+    transfer=2Ed =3D 1;
>+
>+    transfer_iovec=2Eiov_base =3D (void *)pixman_image_get_data(res->ima=
ge);
>+    transfer_iovec=2Eiov_len =3D res->width * res->height * 4;
>+
>+    result =3D rutabaga_resource_transfer_read(vr->rutabaga, 0,
>+                                             rf=2Eresource_id, &transfer=
,
>+                                             &transfer_iovec);
>+    CHECK_RESULT(result, cmd);
>+    dpy_gfx_update_full(scanout->con);
>+}
>+
>+static void
>+rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *c=
md)
>+{
>+    struct virtio_gpu_simple_resource *res;
>+    struct virtio_gpu_scanout *scanout =3D NULL;
>+    struct virtio_gpu_set_scanout ss;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+    if (vr->headless) {
>+        return;
>+    }
>+
>+    VIRTIO_GPU_FILL_CMD(ss);
>+    trace_virtio_gpu_cmd_set_scanout(ss=2Escanout_id, ss=2Eresource_id,
>+                                     ss=2Er=2Ewidth, ss=2Er=2Eheight, ss=
=2Er=2Ex, ss=2Er=2Ey);
>+
>+    scanout =3D &g->parent_obj=2Escanout[ss=2Escanout_id];
>+    g->parent_obj=2Eenable =3D 1;
>+
>+    if (ss=2Eresource_id =3D=3D 0) {
>+        return;
>+    }
>+
>+    res =3D virtio_gpu_find_resource(g, ss=2Eresource_id);
>+    CHECK(res, cmd);
>+
>+    if (!res->image) {
>+        pixman_format_code_t pformat;
>+        pformat =3D virtio_gpu_get_pixman_format(res->format);
>+        CHECK(pformat, cmd);
>+
>+        res->image =3D pixman_image_create_bits(pformat,
>+                                              res->width,
>+                                              res->height,
>+                                              NULL, 0);
>+        CHECK(res->image, cmd);
>+        pixman_image_ref(res->image);
>+    }
>+
>+    /* realloc the surface ptr */
>+    scanout->ds =3D qemu_create_displaysurface_pixman(res->image);
>+    dpy_gfx_replace_surface(scanout->con, NULL);
>+    dpy_gfx_replace_surface(scanout->con, scanout->ds);
>+    res->scanout_bitmask =3D ss=2Escanout_id;
>+}
>+
>+static void
>+rutabaga_cmd_submit_3d(VirtIOGPU *g,
>+                       struct virtio_gpu_ctrl_command *cmd)
>+{
>+    int32_t result;
>+    struct virtio_gpu_cmd_submit cs;
>+    g_autofree uint8_t *buf =3D NULL;
>+    size_t s;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    VIRTIO_GPU_FILL_CMD(cs);
>+    trace_virtio_gpu_cmd_ctx_submit(cs=2Ehdr=2Ectx_id, cs=2Esize);
>+
>+    buf =3D g_new0(uint8_t, cs=2Esize);
>+    s =3D iov_to_buf(cmd->elem=2Eout_sg, cmd->elem=2Eout_num,
>+                   sizeof(cs), buf, cs=2Esize);
>+    CHECK((s =3D=3D cs=2Esize), cmd);
>+
>+    result =3D rutabaga_submit_command(vr->rutabaga, cs=2Ehdr=2Ectx_id, =
buf, cs=2Esize);
>+    CHECK_RESULT(result, cmd);
>+}
>+
>+static void
>+rutabaga_cmd_transfer_to_host_2d(VirtIOGPU *g,
>+                                 struct virtio_gpu_ctrl_command *cmd)
>+{
>+    int32_t result;
>+    struct rutabaga_transfer transfer =3D { 0 };
>+    struct virtio_gpu_transfer_to_host_2d t2d;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    VIRTIO_GPU_FILL_CMD(t2d);
>+    trace_virtio_gpu_cmd_res_xfer_toh_2d(t2d=2Eresource_id);
>+
>+    transfer=2Ex =3D t2d=2Er=2Ex;
>+    transfer=2Ey =3D t2d=2Er=2Ey;
>+    transfer=2Ez =3D 0;
>+    transfer=2Ew =3D t2d=2Er=2Ewidth;
>+    transfer=2Eh =3D t2d=2Er=2Eheight;
>+    transfer=2Ed =3D 1;
>+
>+    result =3D rutabaga_resource_transfer_write(vr->rutabaga, 0, t2d=2Er=
esource_id,
>+                                              &transfer);
>+    CHECK_RESULT(result, cmd);
>+}
>+
>+static void
>+rutabaga_cmd_transfer_to_host_3d(VirtIOGPU *g,
>+                                 struct virtio_gpu_ctrl_command *cmd)
>+{
>+    int32_t result;
>+    struct rutabaga_transfer transfer =3D { 0 };
>+    struct virtio_gpu_transfer_host_3d t3d;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    VIRTIO_GPU_FILL_CMD(t3d);
>+    trace_virtio_gpu_cmd_res_xfer_toh_3d(t3d=2Eresource_id);
>+
>+    transfer=2Ex =3D t3d=2Ebox=2Ex;
>+    transfer=2Ey =3D t3d=2Ebox=2Ey;
>+    transfer=2Ez =3D t3d=2Ebox=2Ez;
>+    transfer=2Ew =3D t3d=2Ebox=2Ew;
>+    transfer=2Eh =3D t3d=2Ebox=2Eh;
>+    transfer=2Ed =3D t3d=2Ebox=2Ed;
>+    transfer=2Elevel =3D t3d=2Elevel;
>+    transfer=2Estride =3D t3d=2Estride;
>+    transfer=2Elayer_stride =3D t3d=2Elayer_stride;
>+    transfer=2Eoffset =3D t3d=2Eoffset;
>+
>+    result =3D rutabaga_resource_transfer_write(vr->rutabaga, t3d=2Ehdr=
=2Ectx_id,
>+                                              t3d=2Eresource_id, &transf=
er);
>+    CHECK_RESULT(result, cmd);
>+}
>+
>+static void
>+rutabaga_cmd_transfer_from_host_3d(VirtIOGPU *g,
>+                                   struct virtio_gpu_ctrl_command *cmd)
>+{
>+    int32_t result;
>+    struct rutabaga_transfer transfer =3D { 0 };
>+    struct virtio_gpu_transfer_host_3d t3d;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    VIRTIO_GPU_FILL_CMD(t3d);
>+    trace_virtio_gpu_cmd_res_xfer_fromh_3d(t3d=2Eresource_id);
>+
>+    transfer=2Ex =3D t3d=2Ebox=2Ex;
>+    transfer=2Ey =3D t3d=2Ebox=2Ey;
>+    transfer=2Ez =3D t3d=2Ebox=2Ez;
>+    transfer=2Ew =3D t3d=2Ebox=2Ew;
>+    transfer=2Eh =3D t3d=2Ebox=2Eh;
>+    transfer=2Ed =3D t3d=2Ebox=2Ed;
>+    transfer=2Elevel =3D t3d=2Elevel;
>+    transfer=2Estride =3D t3d=2Estride;
>+    transfer=2Elayer_stride =3D t3d=2Elayer_stride;
>+    transfer=2Eoffset =3D t3d=2Eoffset;
>+
>+    result =3D rutabaga_resource_transfer_read(vr->rutabaga, t3d=2Ehdr=
=2Ectx_id,
>+                                             t3d=2Eresource_id, &transfe=
r, NULL);
>+    CHECK_RESULT(result, cmd);
>+}
>+
>+static void
>+rutabaga_cmd_attach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command=
 *cmd)
>+{
>+    struct rutabaga_iovecs vecs =3D { 0 };
>+    struct virtio_gpu_simple_resource *res;
>+    struct virtio_gpu_resource_attach_backing att_rb;
>+    struct iovec *res_iovs;
>+    uint32_t res_niov;
>+    int ret;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    VIRTIO_GPU_FILL_CMD(att_rb);
>+    trace_virtio_gpu_cmd_res_back_attach(att_rb=2Eresource_id);
>+
>+    res =3D virtio_gpu_find_resource(g, att_rb=2Eresource_id);
>+    CHECK(res, cmd);
>+    CHECK(!res->iov, cmd);
>+
>+    ret =3D virtio_gpu_create_mapping_iov(g, att_rb=2Enr_entries, sizeof=
(att_rb),
>+                                        cmd, NULL, &res_iovs, &res_niov)=
;
>+    CHECK_RESULT(ret, cmd);
>+
>+    vecs=2Eiovecs =3D res_iovs;
>+    vecs=2Enum_iovecs =3D res_niov;
>+
>+    ret =3D rutabaga_resource_attach_backing(vr->rutabaga, att_rb=2Ereso=
urce_id,
>+                                           &vecs);
>+    if (ret !=3D 0) {
>+        virtio_gpu_cleanup_mapping_iov(g, res_iovs, res_niov);
>+    }
>+}
>+
>+static void
>+rutabaga_cmd_detach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command=
 *cmd)
>+{
>+    struct virtio_gpu_simple_resource *res;
>+    struct virtio_gpu_resource_detach_backing detach_rb;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    VIRTIO_GPU_FILL_CMD(detach_rb);
>+    trace_virtio_gpu_cmd_res_back_detach(detach_rb=2Eresource_id);
>+
>+    res =3D virtio_gpu_find_resource(g, detach_rb=2Eresource_id);
>+    CHECK(res, cmd);
>+
>+    rutabaga_resource_detach_backing(vr->rutabaga,
>+                                     detach_rb=2Eresource_id);
>+
>+    virtio_gpu_cleanup_mapping(g, res);
>+}
>+
>+static void
>+rutabaga_cmd_ctx_attach_resource(VirtIOGPU *g,
>+                                 struct virtio_gpu_ctrl_command *cmd)
>+{
>+    int32_t result;
>+    struct virtio_gpu_ctx_resource att_res;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    VIRTIO_GPU_FILL_CMD(att_res);
>+    trace_virtio_gpu_cmd_ctx_res_attach(att_res=2Ehdr=2Ectx_id,
>+                                        att_res=2Eresource_id);
>+
>+    result =3D rutabaga_context_attach_resource(vr->rutabaga, att_res=2E=
hdr=2Ectx_id,
>+                                              att_res=2Eresource_id);
>+    CHECK_RESULT(result, cmd);
>+}
>+
>+static void
>+rutabaga_cmd_ctx_detach_resource(VirtIOGPU *g,
>+                                 struct virtio_gpu_ctrl_command *cmd)
>+{
>+    int32_t result;
>+    struct virtio_gpu_ctx_resource det_res;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    VIRTIO_GPU_FILL_CMD(det_res);
>+    trace_virtio_gpu_cmd_ctx_res_detach(det_res=2Ehdr=2Ectx_id,
>+                                        det_res=2Eresource_id);
>+
>+    result =3D rutabaga_context_detach_resource(vr->rutabaga, det_res=2E=
hdr=2Ectx_id,
>+                                              det_res=2Eresource_id);
>+    CHECK_RESULT(result, cmd);
>+}
>+
>+static void
>+rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct virtio_gpu_ctrl_comman=
d *cmd)
>+{
>+    int32_t result;
>+    struct virtio_gpu_get_capset_info info;
>+    struct virtio_gpu_resp_capset_info resp;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    VIRTIO_GPU_FILL_CMD(info);
>+
>+    result =3D rutabaga_get_capset_info(vr->rutabaga, info=2Ecapset_inde=
x,
>+                                      &resp=2Ecapset_id, &resp=2Ecapset_=
max_version,
>+                                      &resp=2Ecapset_max_size);
>+    CHECK_RESULT(result, cmd);
>+
>+    resp=2Ehdr=2Etype =3D VIRTIO_GPU_RESP_OK_CAPSET_INFO;
>+    virtio_gpu_ctrl_response(g, cmd, &resp=2Ehdr, sizeof(resp));
>+}
>+
>+static void
>+rutabaga_cmd_get_capset(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cm=
d)
>+{
>+    int32_t result;
>+    struct virtio_gpu_get_capset gc;
>+    struct virtio_gpu_resp_capset *resp;
>+    uint32_t capset_size;
>+    uint32_t current_id;
>+    bool found =3D false;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    VIRTIO_GPU_FILL_CMD(gc);
>+    for (uint32_t i =3D 0; i < vr->num_capsets; i++) {
>+        result =3D rutabaga_get_capset_info(vr->rutabaga, i,
>+                                          &current_id, &capset_size,
>+                                          &capset_size);
>+        CHECK_RESULT(result, cmd);
>+
>+        if (current_id =3D=3D gc=2Ecapset_id) {
>+            found =3D true;
>+            break;
>+        }
>+    }
>+
>+    if (!found) {
>+        error_report("capset not found!");
>+        return;
>+    }
>+
>+    resp =3D g_malloc0(sizeof(*resp) + capset_size);
>+    resp->hdr=2Etype =3D VIRTIO_GPU_RESP_OK_CAPSET;
>+    rutabaga_get_capset(vr->rutabaga, gc=2Ecapset_id, gc=2Ecapset_versio=
n,
>+                       (uint8_t *)resp->capset_data, capset_size);
>+
>+    virtio_gpu_ctrl_response(g, cmd, &resp->hdr, sizeof(*resp) + capset_=
size);
>+    g_free(resp);
>+}
>+
>+static void
>+rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
>+                                  struct virtio_gpu_ctrl_command *cmd)
>+{
>+    int result;
>+    struct rutabaga_iovecs vecs =3D { 0 };
>+    g_autofree struct virtio_gpu_simple_resource *res =3D NULL;
>+    struct virtio_gpu_simple_resource *resource;
>+    struct virtio_gpu_resource_create_blob cblob;
>+    struct rutabaga_create_blob rc_blob =3D { 0 };
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    VIRTIO_GPU_FILL_CMD(cblob);
>+    trace_virtio_gpu_cmd_res_create_blob(cblob=2Eresource_id, cblob=2Esi=
ze);
>+
>+    CHECK(cblob=2Eresource_id !=3D 0, cmd);
>+
>+    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
>+
>+    res->resource_id =3D cblob=2Eresource_id;
>+    res->blob_size =3D cblob=2Esize;
>+
>+    if (cblob=2Eblob_mem !=3D VIRTIO_GPU_BLOB_MEM_HOST3D) {
>+        result =3D virtio_gpu_create_mapping_iov(g, cblob=2Enr_entries,
>+                                               sizeof(cblob), cmd, &res-=
>addrs,
>+                                               &res->iov, &res->iov_cnt)=
;
>+        CHECK_RESULT(result, cmd);
>+    }
>+
>+    rc_blob=2Eblob_id =3D cblob=2Eblob_id;
>+    rc_blob=2Eblob_mem =3D cblob=2Eblob_mem;
>+    rc_blob=2Eblob_flags =3D cblob=2Eblob_flags;
>+    rc_blob=2Esize =3D cblob=2Esize;
>+
>+    vecs=2Eiovecs =3D res->iov;
>+    vecs=2Enum_iovecs =3D res->iov_cnt;
>+
>+    result =3D rutabaga_resource_create_blob(vr->rutabaga, cblob=2Ehdr=
=2Ectx_id,
>+                                           cblob=2Eresource_id, &rc_blob=
, &vecs,
>+                                           NULL);
>+    CHECK_RESULT(result, cmd);
>+    resource =3D g_steal_pointer(&res);
>+    QTAILQ_INSERT_HEAD(&g->reslist, resource, next);
>+}
>+
>+static void
>+rutabaga_cmd_resource_map_blob(VirtIOGPU *g,
>+                               struct virtio_gpu_ctrl_command *cmd)
>+{
>+    int32_t result;
>+    uint32_t slot =3D 0;
>+    struct virtio_gpu_simple_resource *res;
>+    struct rutabaga_mapping mapping =3D { 0 };
>+    struct virtio_gpu_resource_map_blob mblob;
>+    struct virtio_gpu_resp_map_info resp;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    VIRTIO_GPU_FILL_CMD(mblob);
>+
>+    CHECK(mblob=2Eresource_id !=3D 0, cmd);
>+
>+    res =3D virtio_gpu_find_resource(g, mblob=2Eresource_id);
>+    CHECK(res, cmd);
>+
>+    result =3D rutabaga_resource_map(vr->rutabaga, mblob=2Eresource_id, =
&mapping);
>+    CHECK_RESULT(result, cmd);
>+
>+    for (slot =3D 0; slot < MAX_SLOTS; slot++) {
>+        if (memory_regions[slot]=2Eused) {
>+            continue;
>+        }
>+
>+        MemoryRegion *mr =3D &(memory_regions[slot]=2Emr);
>+        memory_region_init_ram_ptr(mr, NULL, "blob", mapping=2Esize,
>+                                   (void *)mapping=2Eptr);
>+        memory_region_add_subregion(&g->parent_obj=2Ehostmem,
>+                                    mblob=2Eoffset, mr);
>+        memory_regions[slot]=2Eresource_id =3D mblob=2Eresource_id;
>+        memory_regions[slot]=2Eused =3D 1;
>+        break;
>+    }
>+
>+    CHECK((slot < MAX_SLOTS), cmd);
>+
>+    memset(&resp, 0, sizeof(resp));
>+    resp=2Ehdr=2Etype =3D VIRTIO_GPU_RESP_OK_MAP_INFO;
>+    result =3D rutabaga_resource_map_info(vr->rutabaga, mblob=2Eresource=
_id,
>+                                        &resp=2Emap_info);
>+
>+    CHECK_RESULT(result, cmd);
>+    virtio_gpu_ctrl_response(g, cmd, &resp=2Ehdr, sizeof(resp));
>+}
>+
>+static void
>+rutabaga_cmd_resource_unmap_blob(VirtIOGPU *g,
>+                                 struct virtio_gpu_ctrl_command *cmd)
>+{
>+    int32_t result;
>+    uint32_t slot =3D 0;
>+    struct virtio_gpu_simple_resource *res;
>+    struct virtio_gpu_resource_unmap_blob ublob;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    VIRTIO_GPU_FILL_CMD(ublob);
>+
>+    CHECK(ublob=2Eresource_id !=3D 0, cmd);
>+
>+    res =3D virtio_gpu_find_resource(g, ublob=2Eresource_id);
>+    CHECK(res, cmd);
>+
>+    for (slot =3D 0; slot < MAX_SLOTS; slot++) {
>+        if (memory_regions[slot]=2Eresource_id !=3D ublob=2Eresource_id)=
 {
>+            continue;
>+        }
>+
>+        MemoryRegion *mr =3D &(memory_regions[slot]=2Emr);
>+        memory_region_del_subregion(&g->parent_obj=2Ehostmem, mr);
>+
>+        memory_regions[slot]=2Eresource_id =3D 0;
>+        memory_regions[slot]=2Eused =3D 0;
>+        break;
>+    }
>+
>+    CHECK((slot < MAX_SLOTS), cmd);
>+    result =3D rutabaga_resource_unmap(vr->rutabaga, res->resource_id);
>+    CHECK_RESULT(result, cmd);
>+}
>+
>+static void
>+virtio_gpu_rutabaga_process_cmd(VirtIOGPU *g,
>+                                struct virtio_gpu_ctrl_command *cmd)
>+{
>+    struct rutabaga_fence fence =3D { 0 };
>+    int32_t result;
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
>+
>+    switch (cmd->cmd_hdr=2Etype) {
>+    case VIRTIO_GPU_CMD_CTX_CREATE:
>+        rutabaga_cmd_context_create(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_CTX_DESTROY:
>+        rutabaga_cmd_context_destroy(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_RESOURCE_CREATE_2D:
>+        rutabaga_cmd_create_resource_2d(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_RESOURCE_CREATE_3D:
>+        rutabaga_cmd_create_resource_3d(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_SUBMIT_3D:
>+        rutabaga_cmd_submit_3d(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D:
>+        rutabaga_cmd_transfer_to_host_2d(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D:
>+        rutabaga_cmd_transfer_to_host_3d(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D:
>+        rutabaga_cmd_transfer_from_host_3d(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING:
>+        rutabaga_cmd_attach_backing(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:
>+        rutabaga_cmd_detach_backing(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_SET_SCANOUT:
>+        rutabaga_cmd_set_scanout(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_RESOURCE_FLUSH:
>+        rutabaga_cmd_resource_flush(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_RESOURCE_UNREF:
>+        rutabaga_cmd_resource_unref(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:
>+        rutabaga_cmd_ctx_attach_resource(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE:
>+        rutabaga_cmd_ctx_detach_resource(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_GET_CAPSET_INFO:
>+        rutabaga_cmd_get_capset_info(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_GET_CAPSET:
>+        rutabaga_cmd_get_capset(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:
>+        virtio_gpu_get_display_info(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_GET_EDID:
>+        virtio_gpu_get_edid(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB:
>+        rutabaga_cmd_resource_create_blob(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB:
>+        rutabaga_cmd_resource_map_blob(g, cmd);
>+        break;
>+    case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:
>+        rutabaga_cmd_resource_unmap_blob(g, cmd);
>+        break;
>+    default:
>+        cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>+        break;
>+    }
>+
>+    if (cmd->finished) {
>+        return;
>+    }
>+    if (cmd->error) {
>+        error_report("%s: ctrl 0x%x, error 0x%x", __func__,
>+                     cmd->cmd_hdr=2Etype, cmd->error);
>+        virtio_gpu_ctrl_response_nodata(g, cmd, cmd->error);
>+        return;
>+    }
>+    if (!(cmd->cmd_hdr=2Eflags & VIRTIO_GPU_FLAG_FENCE)) {
>+        virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODAT=
A);
>+        return;
>+    }
>+
>+    fence=2Eflags =3D cmd->cmd_hdr=2Eflags;
>+    fence=2Ectx_id =3D cmd->cmd_hdr=2Ectx_id;
>+    fence=2Efence_id =3D cmd->cmd_hdr=2Efence_id;
>+    fence=2Ering_idx =3D cmd->cmd_hdr=2Ering_idx;
>+
>+    trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr=2Efence_id, cmd->cmd_hdr=2E=
type);
>+
>+    result =3D rutabaga_create_fence(vr->rutabaga, &fence);
>+    CHECK_RESULT(result, cmd);
>+}
>+
>+static void
>+virtio_gpu_rutabaga_aio_cb(void *opaque)
>+{
>+    struct rutabaga_aio_data *data =3D  (struct rutabaga_aio_data *)opaq=
ue;
>+    VirtIOGPU *g =3D (VirtIOGPU *)data->vr;
>+    struct rutabaga_fence fence_data =3D data->fence;
>+    struct virtio_gpu_ctrl_command *cmd, *tmp;
>+
>+    uint32_t signaled_ctx_specific =3D fence_data=2Eflags &
>+                                     RUTABAGA_FLAG_INFO_RING_IDX;
>+
>+    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
>+        /*
>+         * Due to context specific timelines=2E
>+         */
>+        uint32_t target_ctx_specific =3D cmd->cmd_hdr=2Eflags &
>+                                       RUTABAGA_FLAG_INFO_RING_IDX;
>+
>+        if (signaled_ctx_specific !=3D target_ctx_specific) {
>+            continue;
>+        }
>+
>+        if (signaled_ctx_specific &&
>+           (cmd->cmd_hdr=2Ering_idx !=3D fence_data=2Ering_idx)) {
>+            continue;
>+        }
>+
>+        if (cmd->cmd_hdr=2Efence_id > fence_data=2Efence_id) {
>+            continue;
>+        }
>+
>+        trace_virtio_gpu_fence_resp(cmd->cmd_hdr=2Efence_id);
>+        virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODAT=
A);
>+        QTAILQ_REMOVE(&g->fenceq, cmd, next);
>+        g_free(cmd);
>+    }
>+
>+    g_free(data);
>+}
>+
>+static void
>+virtio_gpu_rutabaga_fence_cb(uint64_t user_data,
>+                             struct rutabaga_fence fence_data) {
>+    struct rutabaga_aio_data *data;
>+    VirtIOGPU *g =3D (VirtIOGPU *)user_data;
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    /*
>+     * gfxstream and both cross-domain (and even newer versions virglren=
derer:
>+     * see VIRGL_RENDERER_ASYNC_FENCE_CB) like to signal fence completio=
n on
>+     * threads ("callback threads") that are different from the thread t=
hat
>+     * processes the command queue ("main thread")=2E
>+     *
>+     * crosvm and other virtio-gpu 1=2E1implementations enable callback =
threads
>+     * via locking=2E  However, on QEMU a deadlock is observed if
>+     * virtio_gpu_ctrl_response_nodata(=2E=2E) [used in the fence callba=
ck] is used
>+     * from a thread that is not the main thread=2E
>+     *
>+     * The reason is QEMU's internal locking is designed to work with QE=
MU
>+     * threads (see rcu_register_thread()) and not generic C/C++/Rust th=
reads=2E
>+     * For now, we can workaround this by scheduling the return of the
>+     * fence descriptors on the main thread=2E
>+     */
>+
>+    data =3D g_new0(struct rutabaga_aio_data, 1);
>+    data->vr =3D vr;
>+    data->fence =3D fence_data;
>+    aio_bh_schedule_oneshot_full(vr->ctx, virtio_gpu_rutabaga_aio_cb,
>+                                 (void *)data, "aio");
>+}
>+
>+static int virtio_gpu_rutabaga_init(VirtIOGPU *g)

Rather than returning an errno here which loses interesting error details =
the idiomatic way of error handling in QEMU would be appending an `Error **=
errp` argument and return bool=2E In case of an error this allows for setti=
ng `errp` to a comprehensible error message and `return false`, instead of =
just returning `-EINVAL`=2E

>+{
>+    int result;
>+    uint64_t capset_mask;
>+    struct rutabaga_channels channels =3D { 0 };
>+    struct rutabaga_builder builder =3D { 0 };
>+
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+    vr->rutabaga =3D NULL;
>+
>+    if (!vr->capset_names) {

Here it could be mentioned that the "capset_names" option is missing=2E Cu=
rrently, if one neglects to add this option, the error message is "Failed t=
o init rutabaga" -- which is kind of sparse to guide to a solution=2E

>+        return -EINVAL;
>+    }
>+
>+    builder=2Ewsi =3D RUTABAGA_WSI_SURFACELESS;
>+    /*
>+     * Currently, if WSI is specified, the only valid strings are "surfa=
celess"
>+     * or "headless"=2E  Surfaceless doesn't create a native window surf=
ace, but
>+     * does copy from the render target to the Pixman buffer if a virtio=
-gpu
>+     * 2D hypercall is issued=2E  Surfacless is the default=2E
>+     *
>+     * Headless is like surfaceless, but doesn't copy to the Pixman buff=
er=2E The
>+     * use case is automated testing environments where there is no need=
 to view
>+     * results=2E
>+     *
>+     * In the future, more performant virtio-gpu 2D UI integration may b=
e added=2E
>+     */
>+    if (vr->wsi) {
>+        if (!strcmp(vr->wsi, "surfaceless")) {
>+            vr->headless =3D false;
>+        } else if (strcmp(vr->wsi, "headless")) {
>+            vr->headless =3D true;
>+        } else {

Here we could mention the option and its unknown value in an error message=
=2E I think the idiomatic way to achieve this in QEMU is to turn this into =
an enum option=2E I suppose one would then be able to query for accepted va=
lues by setting the option value to '?', making the option self-documenting=
=2E

>+            return -EINVAL;
>+        }
>+    }
>+
>+    result =3D rutabaga_calculate_capset_mask(vr->capset_names, &capset_=
mask);

How do we know which are the allowed values for the "capset_names" option?=
 It seems that all the magic happens inside rutabaga which makes the option=
 quite intransparent to QEMU and thus to its users=2E Could we not teach QE=
MU the allowed values and have it populate capset_mask itself? I think this=
 would make for much better error messages=2E

Does it then make sense to split this option into multiple ones to prevent=
 contradicting bits to be set?

>+    if (result) {
>+        return result;
>+    }
>+
>+    /*
>+     * rutabaga-0=2E1=2E1 is only compiled/tested with gfxstream and cro=
ss-domain
>+     * support=2E Future versions may change this to have more context t=
ypes if
>+     * there is any interest=2E
>+     */
>+    if (capset_mask & (BIT(RUTABAGA_CAPSET_VIRGL) |
>+                       BIT(RUTABAGA_CAPSET_VIRGL2) |
>+                       BIT(RUTABAGA_CAPSET_VENUS) |
>+                       BIT(RUTABAGA_CAPSET_DRM))) {

Is this a limitation of QEMU or rutabaga? The above comment suggests it's =
in the latter, so it should be dealt with there rather than in QEMU=2E

>+        return -EINVAL;
>+    }
>+
>+    builder=2Euser_data =3D (uint64_t)(uintptr_t *)(void *)g;
>+    builder=2Efence_cb =3D virtio_gpu_rutabaga_fence_cb;
>+    builder=2Ecapset_mask =3D capset_mask;
>+
>+    if (vr->wayland_socket_path) {
>+        if ((builder=2Ecapset_mask & (1 << RUTABAGA_CAPSET_CROSS_DOMAIN)=
) =3D=3D 0) {
>+            return -EINVAL;
>+        }
>+
>+        channels=2Echannels =3D
>+          (struct rutabaga_channel *)calloc(1, sizeof(struct rutabaga_ch=
annel));
>+        channels=2Enum_channels =3D 1;
>+        channels=2Echannels[0]=2Echannel_name =3D vr->wayland_socket_pat=
h;
>+        channels=2Echannels[0]=2Echannel_type =3D RUTABAGA_CHANNEL_TYPE_=
WAYLAND;
>+        builder=2Echannels =3D &channels;
>+    }
>+
>+    result =3D rutabaga_init(&builder, &vr->rutabaga);

So this is plain rutabaga FFI API, just returning some uint32_t in case of=
 an error=2E How can we communicate the precise error to a QEMU user? I hav=
en't looked, but rutabaga might use Rust's Result type internally which wou=
ld probably contain a highly descriptive error message=2E Furthermore, duri=
ng compilation of rutabaga, I could see the usual suspects of Rust error cr=
ates to be compiled=2E Can we somehow propagate these errors through the FF=
I layer and eventually convert them to QEMU's Error type?

The above function seems to be just one of many with an error-hiding API=
=2E IOW the error handling seems to be rather weak in general=2E Rutabaga s=
eems to be an abstraction layer over various graphics backends, each of whi=
ch has its own, special error cases=2E In order to cater to users -- both Q=
EMU and Android Emulator, I think the error handling could be improved=2E F=
ixing it might also cause less support mainteneance in the future=2E

Best regards,
Bernhard

>+    if (builder=2Ecapset_mask & (1 << RUTABAGA_CAPSET_CROSS_DOMAIN)) {
>+        free(channels=2Echannels);
>+    }
>+
>+    memset(&memory_regions, 0, MAX_SLOTS * sizeof(struct MemoryRegionInf=
o));
>+    vr->ctx =3D qemu_get_aio_context();
>+    return result;
>+}
>+
>+static int virtio_gpu_rutabaga_get_num_capsets(VirtIOGPU *g)
>+{
>+    int result;
>+    uint32_t num_capsets;
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+
>+    if (!vr->rutabaga_active) {
>+        result =3D virtio_gpu_rutabaga_init(g);
>+        if (result) {
>+            error_report("Failed to init rutabaga");
>+            return 0;
>+        }
>+
>+        vr->rutabaga_active =3D true;
>+    }
>+
>+    result =3D rutabaga_get_num_capsets(vr->rutabaga, &num_capsets);
>+    if (result) {
>+        error_report("Failed to get capsets");
>+        return 0;
>+    }
>+    vr->num_capsets =3D num_capsets;
>+    return num_capsets;
>+}
>+
>+static void virtio_gpu_rutabaga_handle_ctrl(VirtIODevice *vdev, VirtQueu=
e *vq)
>+{
>+    VirtIOGPU *g =3D VIRTIO_GPU(vdev);
>+    VirtioGpuRutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>+    struct virtio_gpu_ctrl_command *cmd;
>+
>+    if (!virtio_queue_ready(vq)) {
>+        return;
>+    }
>+
>+    if (!vr->rutabaga_active) {
>+        int result =3D virtio_gpu_rutabaga_init(g);
>+        if (!result) {
>+            vr->rutabaga_active =3D true;
>+        }
>+    }
>+
>+    if (!vr->rutabaga_active) {
>+        return;
>+    }
>+
>+    cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command));
>+    while (cmd) {
>+        cmd->vq =3D vq;
>+        cmd->error =3D 0;
>+        cmd->finished =3D false;
>+        QTAILQ_INSERT_TAIL(&g->cmdq, cmd, next);
>+        cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command)=
);
>+    }
>+
>+    virtio_gpu_process_cmdq(g);
>+}
>+
>+static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp)
>+{
>+    int num_capsets;
>+    VirtIOGPUBase *bdev =3D VIRTIO_GPU_BASE(qdev);
>+    VirtIOGPU *gpudev =3D VIRTIO_GPU(qdev);
>+
>+    num_capsets =3D virtio_gpu_rutabaga_get_num_capsets(gpudev);
>+    if (!num_capsets) {
>+        return;
>+    }
>+
>+#if HOST_BIG_ENDIAN
>+    error_setg(errp, "rutabaga is not supported on bigendian platforms")=
;
>+    return;
>+#endif
>+
>+    bdev->conf=2Eflags |=3D (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED);
>+    bdev->conf=2Eflags |=3D (1 << VIRTIO_GPU_FLAG_BLOB_ENABLED);
>+    bdev->conf=2Eflags |=3D (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED);
>+
>+    bdev->virtio_config=2Enum_capsets =3D num_capsets;
>+    virtio_gpu_device_realize(qdev, errp);
>+}
>+
>+static Property virtio_gpu_rutabaga_properties[] =3D {
>+    DEFINE_PROP_STRING("capset_names", VirtioGpuRutabaga, capset_names),
>+    DEFINE_PROP_STRING("wayland_socket_path", VirtioGpuRutabaga,
>+                       wayland_socket_path),
>+    DEFINE_PROP_STRING("wsi", VirtioGpuRutabaga, wsi),
>+    DEFINE_PROP_END_OF_LIST(),
>+};
>+
>+static void virtio_gpu_rutabaga_class_init(ObjectClass *klass, void *dat=
a)
>+{
>+    DeviceClass *dc =3D DEVICE_CLASS(klass);
>+    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
>+    VirtIOGPUBaseClass *vbc =3D VIRTIO_GPU_BASE_CLASS(klass);
>+    VirtIOGPUClass *vgc =3D VIRTIO_GPU_CLASS(klass);
>+
>+    vbc->gl_flushed =3D virtio_gpu_rutabaga_gl_flushed;
>+    vgc->handle_ctrl =3D virtio_gpu_rutabaga_handle_ctrl;
>+    vgc->process_cmd =3D virtio_gpu_rutabaga_process_cmd;
>+    vgc->update_cursor_data =3D virtio_gpu_rutabaga_update_cursor;
>+
>+    vdc->realize =3D virtio_gpu_rutabaga_realize;
>+    device_class_set_props(dc, virtio_gpu_rutabaga_properties);
>+}
>+
>+static const TypeInfo virtio_gpu_rutabaga_info =3D {
>+    =2Ename =3D TYPE_VIRTIO_GPU_RUTABAGA,
>+    =2Eparent =3D TYPE_VIRTIO_GPU,
>+    =2Einstance_size =3D sizeof(VirtioGpuRutabaga),
>+    =2Eclass_init =3D virtio_gpu_rutabaga_class_init,
>+};
>+module_obj(TYPE_VIRTIO_GPU_RUTABAGA);
>+module_kconfig(VIRTIO_GPU);
>+
>+static void virtio_register_types(void)
>+{
>+    type_register_static(&virtio_gpu_rutabaga_info);
>+}
>+
>+type_init(virtio_register_types)
>+
>+module_dep("hw-display-virtio-gpu");
>diff --git a/hw/display/virtio-vga-rutabaga=2Ec b/hw/display/virtio-vga-r=
utabaga=2Ec
>new file mode 100644
>index 0000000000=2E=2E01831bd03f
>--- /dev/null
>+++ b/hw/display/virtio-vga-rutabaga=2Ec
>@@ -0,0 +1,52 @@
>+// SPDX-License-Identifier: GPL-2=2E0
>+
>+#include "qemu/osdep=2Eh"
>+#include "hw/pci/pci=2Eh"
>+#include "hw/qdev-properties=2Eh"
>+#include "hw/virtio/virtio-gpu=2Eh"
>+#include "hw/display/vga=2Eh"
>+#include "qapi/error=2Eh"
>+#include "qemu/module=2Eh"
>+#include "virtio-vga=2Eh"
>+#include "qom/object=2Eh"
>+
>+#define TYPE_VIRTIO_VGA_RUTABAGA "virtio-vga-rutabaga"
>+
>+typedef struct VirtIOVGARUTABAGA VirtIOVGARUTABAGA;
>+DECLARE_INSTANCE_CHECKER(VirtIOVGARUTABAGA, VIRTIO_VGA_RUTABAGA,
>+                         TYPE_VIRTIO_VGA_RUTABAGA)
>+
>+struct VirtIOVGARUTABAGA {
>+    VirtIOVGABase parent_obj;
>+
>+    VirtioGpuRutabaga   vdev;
>+};
>+
>+static void virtio_vga_rutabaga_inst_initfn(Object *obj)
>+{
>+    VirtIOVGARUTABAGA *dev =3D VIRTIO_VGA_RUTABAGA(obj);
>+
>+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
>+                                TYPE_VIRTIO_GPU_RUTABAGA);
>+    VIRTIO_VGA_BASE(dev)->vgpu =3D VIRTIO_GPU_BASE(&dev->vdev);
>+}
>+
>+static VirtioPCIDeviceTypeInfo virtio_vga_rutabaga_info =3D {
>+    =2Egeneric_name  =3D TYPE_VIRTIO_VGA_RUTABAGA,
>+    =2Eparent        =3D TYPE_VIRTIO_VGA_BASE,
>+    =2Einstance_size =3D sizeof(VirtIOVGARUTABAGA),
>+    =2Einstance_init =3D virtio_vga_rutabaga_inst_initfn,
>+};
>+module_obj(TYPE_VIRTIO_VGA_RUTABAGA);
>+module_kconfig(VIRTIO_VGA);
>+
>+static void virtio_vga_register_types(void)
>+{
>+    if (have_vga) {
>+        virtio_pci_types_register(&virtio_vga_rutabaga_info);
>+    }
>+}
>+
>+type_init(virtio_vga_register_types)
>+
>+module_dep("hw-display-virtio-vga");

