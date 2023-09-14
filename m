Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB9F79FD2D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 09:25:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgghG-0003Bo-2o; Thu, 14 Sep 2023 03:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qgghA-00035V-8N
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:23:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qggh1-0001ae-Ts
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:23:23 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-403004a96eeso6167145e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 00:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694676193; x=1695280993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ukdaMqn7vnKU8ivFQKKfQi1nJ1RVtN8JNtCkP3foiMo=;
 b=QqAUvX6Qjf/uecj/AQ7pQceRZer5DH6T+Sqsd3OZIYpUd6sTYeP1gw+qKMj74KN3Xj
 wjIes2hCUxHKPsc0+bb6VJQsIO4bGsGsgFyG/puITuywfMKObV0Vrt+YdS/OvvDrVSb3
 Gudaz8IvFHtor4NlG1na2FSzzEY0j3hcTq9o8EV/eG1G/O14oKPsp/N7KRiu9Mv2ni4x
 nuGbzZ8wakt/Xu57HA6yczfvS2OKd18vSVDuYKKXPhsUVcZlsTV/DGF6C2vmjUqvfSWO
 fzvKki4k7mi7aT9oYzj+HpAVC8cwlQ6JibCp/8JfyuVH+Or2+MDf/ESLE2dPKiz0zY4z
 dB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694676193; x=1695280993;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ukdaMqn7vnKU8ivFQKKfQi1nJ1RVtN8JNtCkP3foiMo=;
 b=tgeBAAYpVY23Kp8cgowrZAe2beTry3Wkm7FQhAW5QiS21HmPQ9t3PdeVWdXU6CgFyW
 NBZo0NGkojrhccW7/fY7DIwYmJCuz3WWbP9AP7G6ZOneiMgPiq0wq1ySEKUd7hDJvUcf
 Eh8v0zfdlli0QNmsU/mavB+q24JluhyeNmnx8D6PYJ3O2uZA9MeuePpBzRkLsZRPkX5y
 IGzA8/LxDjEfIrshwqnhnboK1u+j3F+n7+ycALPB5TpyXYKeAdgli4PheQXpr2iWZ6mG
 EVFIAQwmoHAcyMrFJjR1yDK01MDEb6dTUgaGnh/HEmm31v+dJSC3+uugBPrZNFRn9V20
 zoGA==
X-Gm-Message-State: AOJu0YxKdzuFTdf9dToDeVquByGmfP1a/KwQgMLm/hfI+IU6117/yB29
 WxcstbyL9o7nPZca8LgHs/I=
X-Google-Smtp-Source: AGHT+IGjWHzIcQdfnOIEFI9FCB/sht6EOwmUNfU/xxKJssvgULkuD3z62wyQJmlclPWRy+vVjWG7cg==
X-Received: by 2002:a05:600c:3644:b0:402:f517:9c07 with SMTP id
 y4-20020a05600c364400b00402f5179c07mr3966339wmq.0.1694676193055; 
 Thu, 14 Sep 2023 00:23:13 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-013-143-054.77.13.pool.telefonica.de.
 [77.13.143.54]) by smtp.gmail.com with ESMTPSA id
 m13-20020a7bca4d000000b003fe4548188bsm4016827wml.48.2023.09.14.00.23.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 00:23:12 -0700 (PDT)
Date: Thu, 14 Sep 2023 07:23:06 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gurchetan Singh <gurchetansingh@chromium.org>
CC: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 ray.huang@amd.com, alex.bennee@linaro.org, hi@alyssa.is, ernunes@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v11_6/9=5D_gfxstream_+_rutab?=
 =?US-ASCII?Q?aga=3A_add_initial_support_for_gfxstream?=
In-Reply-To: <CAAfnVBk6C7-Vn3buLOh453fz-dRB2vv-4BdkZWjuJDJoWLPAqA@mail.gmail.com>
References: <20230823012541.485-1-gurchetansingh@chromium.org>
 <20230823012541.485-7-gurchetansingh@chromium.org>
 <B1A4DF8C-3078-48AD-BC8B-F2FD7BA413CF@gmail.com>
 <CAAfnVBk6C7-Vn3buLOh453fz-dRB2vv-4BdkZWjuJDJoWLPAqA@mail.gmail.com>
Message-ID: <D3C6E21B-E37E-41DA-8131-0C3D9EAF01FD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



Am 14=2E September 2023 04:38:51 UTC schrieb Gurchetan Singh <gurchetansin=
gh@chromium=2Eorg>:
>On Wed, Sep 13, 2023 at 4:58=E2=80=AFAM Bernhard Beschow <shentey@gmail=
=2Ecom> wrote:
>
>>
>>
>> Am 23=2E August 2023 01:25:38 UTC schrieb Gurchetan Singh <
>> gurchetansingh@chromium=2Eorg>:
>> >This adds initial support for gfxstream and cross-domain=2E  Both
>> >features rely on virtio-gpu blob resources and context types, which
>> >are also implemented in this patch=2E
>> >
>> >gfxstream has a long and illustrious history in Android graphics
>> >paravirtualization=2E  It has been powering graphics in the Android
>> >Studio Emulator for more than a decade, which is the main developer
>> >platform=2E
>> >
>> >Originally conceived by Jesse Hall, it was first known as "EmuGL" [a]=
=2E
>> >The key design characteristic was a 1:1 threading model and
>> >auto-generation, which fit nicely with the OpenGLES spec=2E  It also
>> >allowed easy layering with ANGLE on the host, which provides the GLES
>> >implementations on Windows or MacOS enviroments=2E
>> >
>> >gfxstream has traditionally been maintained by a single engineer, and
>> >between 2015 to 2021, the goldfish throne passed to Frank Yang=2E
>> >Historians often remark this glorious reign ("pax gfxstreama" is the
>> >academic term) was comparable to that of Augustus and both Queen
>> >Elizabeths=2E  Just to name a few accomplishments in a resplendent
>> >panoply: higher versions of GLES, address space graphics, snapshot
>> >support and CTS compliant Vulkan [b]=2E
>> >
>> >One major drawback was the use of out-of-tree goldfish drivers=2E
>> >Android engineers didn't know much about DRM/KMS and especially TTM so
>> >a simple guest to host pipe was conceived=2E
>> >
>> >Luckily, virtio-gpu 3D started to emerge in 2016 due to the work of
>> >the Mesa/virglrenderer communities=2E  In 2018, the initial virtio-gpu
>> >port of gfxstream was done by Cuttlefish enthusiast Alistair Delva=2E
>> >It was a symbol compatible replacement of virglrenderer [c] and named
>> >"AVDVirglrenderer"=2E  This implementation forms the basis of the
>> >current gfxstream host implementation still in use today=2E
>> >
>> >cross-domain support follows a similar arc=2E  Originally conceived by
>> >Wayland aficionado David Reveman and crosvm enjoyer Zach Reizner in
>> >2018, it initially relied on the downstream "virtio-wl" device=2E
>> >
>> >In 2020 and 2021, virtio-gpu was extended to include blob resources
>> >and multiple timelines by yours truly, features gfxstream/cross-domain
>> >both require to function correctly=2E
>> >
>> >Right now, we stand at the precipice of a truly fantastic possibility:
>> >the Android Emulator powered by upstream QEMU and upstream Linux
>> >kernel=2E  gfxstream will then be packaged properfully, and app
>> >developers can even fix gfxstream bugs on their own if they encounter
>> >them=2E
>> >
>> >It's been quite the ride, my friends=2E  Where will gfxstream head nex=
t,
>> >nobody really knows=2E  I wouldn't be surprised if it's around for
>> >another decade, maintained by a new generation of Android graphics
>> >enthusiasts=2E
>> >
>> >Technical details:
>> >  - Very simple initial display integration: just used Pixman
>> >  - Largely, 1:1 mapping of virtio-gpu hypercalls to rutabaga function
>> >    calls
>> >
>> >Next steps for Android VMs:
>> >  - The next step would be improving display integration and UI interf=
aces
>> >    with the goal of the QEMU upstream graphics being in an emulator
>> >    release [d]=2E
>> >
>> >Next steps for Linux VMs for display virtualization:
>> >  - For widespread distribution, someone needs to package Sommelier or=
 the
>> >    wayland-proxy-virtwl [e] ideally into Debian main=2E In addition, =
newer
>> >    versions of the Linux kernel come with DRM_VIRTIO_GPU_KMS option,
>> >    which allows disabling KMS hypercalls=2E  If anyone cares enough, =
it'll
>> >    probably be possible to build a custom VM variant that uses this
>> display
>> >    virtualization strategy=2E
>> >
>> >[a]
>> https://android-review=2Egooglesource=2Ecom/c/platform/development/+/34=
470
>> >[b]
>> https://android-review=2Egooglesource=2Ecom/q/topic:%22vulkan-hostconne=
ction-start%22
>> >[c]
>> https://android-review=2Egooglesource=2Ecom/c/device/generic/goldfish-o=
pengl/+/761927
>> >[d] https://developer=2Eandroid=2Ecom/studio/releases/emulator
>> >[e] https://github=2Ecom/talex5/wayland-proxy-virtwl
>> >
>> >Signed-off-by: Gurchetan Singh <gurchetansingh@chromium=2Eorg>
>> >Tested-by: Alyssa Ross <hi@alyssa=2Eis>
>> >Tested-by: Emmanouil Pitsidianakis <manos=2Epitsidianakis@linaro=2Eorg=
>
>> >Reviewed-by: Emmanouil Pitsidianakis <manos=2Epitsidianakis@linaro=2Eo=
rg>
>> >---
>> >v1: Incorported various suggestions by Akihiko Odaki and Bernard Bersc=
how
>> >    - Removed GET_VIRTIO_GPU_GL / GET_RUTABAGA macros
>> >    - Used error_report(=2E=2E)
>> >    - Used g_autofree to fix leaks on error paths
>> >    - Removed unnecessary casts
>> >    - added virtio-gpu-pci-rutabaga=2Ec + virtio-vga-rutabaga=2Ec file=
s
>> >
>> >v2: Incorported various suggestions by Akihiko Odaki, Marc-Andr=C3=A9 =
Lureau
>> and
>> >    Bernard Berschow:
>> >    - Parenthesis in CHECK macro
>> >    - CHECK_RESULT(result, =2E=2E) --> CHECK(!result, =2E=2E)
>> >    - delay until g->parent_obj=2Eenable =3D 1
>> >    - Additional cast fixes
>> >    - initialize directly in virtio_gpu_rutabaga_realize(=2E=2E)
>> >    - add debug callback to hook into QEMU error's APIs
>> >
>> >v3: Incorporated feedback from Akihiko Odaki and Alyssa Ross:
>> >    - Autodetect Wayland socket when not explicitly specified
>> >    - Fix map_blob error paths
>> >    - Add comment why we need both `res` and `resource` in create blob
>> >    - Cast and whitespace fixes
>> >    - Big endian check comes before virtio_gpu_rutabaga_init()=2E
>> >    - VirtIOVGARUTABAGA --> VirtIOVGARutabaga
>> >
>> >v4: Incorporated feedback from Akihiko Odaki and Alyssa Ross:
>> >    - Double checked all casts
>> >    - Remove unnecessary parenthesis
>> >    - Removed `resource` in create_blob
>> >    - Added comment about failure case
>> >    - Pass user-provided socket as-is
>> >    - Use stack variable rather than heap allocation
>> >    - Future-proofed map info API to give access flags as well
>> >
>> >v5: Incorporated feedback from Akihiko Odaki:
>> >    - Check (ss=2Escanout_id < VIRTIO_GPU_MAX_SCANOUTS)
>> >    - Simplify num_capsets check
>> >    - Call cleanup mapping on error paths
>> >    - uint64_t --> void* for rutabaga_map(=2E=2E)
>> >    - Removed unnecessary parenthesis
>> >    - Removed unnecessary cast
>> >    - #define UNIX_PATH_MAX sizeof((struct sockaddr_un) {}=2Esun_path)
>> >    - Reuse result variable
>> >
>> >v6: Incorporated feedback from Akihiko Odaki:
>> >    - Remove unnecessary #ifndef
>> >    - Disable scanout when appropriate
>> >    - CHECK capset index within range outside loop
>> >    - Add capset_version
>> >
>> >v7: Incorporated feedback from Akihiko Odaki:
>> >    - aio_bh_schedule_oneshot_full --> aio_bh_schedule_oneshot
>> >
>> >v9: Incorportated feedback from Akihiko Odaki:
>> >    - Remove extra error_setg(=2E=2E) after virtio_gpu_rutabaga_init(=
=2E=2E)
>> >    - Add error_setg(=2E=2E) after rutabaga_init(=2E=2E)
>> >
>> >v10: Incorportated feedback from Akihiko Odaki:
>> >    - error_setg(=2E=2E) --> error_setg_errno(=2E=2E) when appropriate
>> >    - virtio_gpu_rutabaga_init returns a bool instead of an int
>> >
>> >v11: Incorportated feedback from Philippe Mathieu-Daud=C3=A9:
>> >    - C-style /* */ comments and avoid // comments=2E
>> >    - GPL-2=2E0 --> GPL-2=2E0-or-later
>> >
>> > hw/display/virtio-gpu-pci-rutabaga=2Ec |   50 ++
>> > hw/display/virtio-gpu-rutabaga=2Ec     | 1121 +++++++++++++++++++++++=
+++
>> > hw/display/virtio-vga-rutabaga=2Ec     |   53 ++
>> > 3 files changed, 1224 insertions(+)
>> > create mode 100644 hw/display/virtio-gpu-pci-rutabaga=2Ec
>> > create mode 100644 hw/display/virtio-gpu-rutabaga=2Ec
>> > create mode 100644 hw/display/virtio-vga-rutabaga=2Ec
>> >
>> >diff --git a/hw/display/virtio-gpu-pci-rutabaga=2Ec
>> b/hw/display/virtio-gpu-pci-rutabaga=2Ec
>> >new file mode 100644
>> >index 0000000000=2E=2E311eff308a
>> >--- /dev/null
>> >+++ b/hw/display/virtio-gpu-pci-rutabaga=2Ec
>> >@@ -0,0 +1,50 @@
>> >+/*
>> >+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>> >+ */
>> >+
>> >+#include "qemu/osdep=2Eh"
>> >+#include "qapi/error=2Eh"
>> >+#include "qemu/module=2Eh"
>> >+#include "hw/pci/pci=2Eh"
>> >+#include "hw/qdev-properties=2Eh"
>> >+#include "hw/virtio/virtio=2Eh"
>> >+#include "hw/virtio/virtio-bus=2Eh"
>> >+#include "hw/virtio/virtio-gpu-pci=2Eh"
>> >+#include "qom/object=2Eh"
>> >+
>> >+#define TYPE_VIRTIO_GPU_RUTABAGA_PCI "virtio-gpu-rutabaga-pci"
>> >+typedef struct VirtIOGPURutabagaPCI VirtIOGPURutabagaPCI;
>> >+DECLARE_INSTANCE_CHECKER(VirtIOGPURutabagaPCI, VIRTIO_GPU_RUTABAGA_PC=
I,
>> >+                         TYPE_VIRTIO_GPU_RUTABAGA_PCI)
>> >+
>> >+struct VirtIOGPURutabagaPCI {
>> >+    VirtIOGPUPCIBase parent_obj;
>> >+    VirtIOGPURutabaga vdev;
>> >+};
>> >+
>> >+static void virtio_gpu_rutabaga_initfn(Object *obj)
>> >+{
>> >+    VirtIOGPURutabagaPCI *dev =3D VIRTIO_GPU_RUTABAGA_PCI(obj);
>> >+
>> >+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
>> >+                                TYPE_VIRTIO_GPU_RUTABAGA);
>> >+    VIRTIO_GPU_PCI_BASE(obj)->vgpu =3D VIRTIO_GPU_BASE(&dev->vdev);
>> >+}
>> >+
>> >+static const VirtioPCIDeviceTypeInfo virtio_gpu_rutabaga_pci_info =3D=
 {
>> >+    =2Egeneric_name =3D TYPE_VIRTIO_GPU_RUTABAGA_PCI,
>> >+    =2Eparent =3D TYPE_VIRTIO_GPU_PCI_BASE,
>> >+    =2Einstance_size =3D sizeof(VirtIOGPURutabagaPCI),
>> >+    =2Einstance_init =3D virtio_gpu_rutabaga_initfn,
>> >+};
>> >+module_obj(TYPE_VIRTIO_GPU_RUTABAGA_PCI);
>> >+module_kconfig(VIRTIO_PCI);
>> >+
>> >+static void virtio_gpu_rutabaga_pci_register_types(void)
>> >+{
>> >+    virtio_pci_types_register(&virtio_gpu_rutabaga_pci_info);
>> >+}
>> >+
>> >+type_init(virtio_gpu_rutabaga_pci_register_types)
>> >+
>> >+module_dep("hw-display-virtio-gpu-pci");
>> >diff --git a/hw/display/virtio-gpu-rutabaga=2Ec
>> b/hw/display/virtio-gpu-rutabaga=2Ec
>> >new file mode 100644
>> >index 0000000000=2E=2E9018e5a702
>> >--- /dev/null
>> >+++ b/hw/display/virtio-gpu-rutabaga=2Ec
>> >@@ -0,0 +1,1121 @@
>> >+/*
>> >+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>> >+ */
>> >+
>> >+#include "qemu/osdep=2Eh"
>> >+#include "qapi/error=2Eh"
>> >+#include "qemu/error-report=2Eh"
>> >+#include "qemu/iov=2Eh"
>> >+#include "trace=2Eh"
>> >+#include "hw/virtio/virtio=2Eh"
>> >+#include "hw/virtio/virtio-gpu=2Eh"
>> >+#include "hw/virtio/virtio-gpu-pixman=2Eh"
>> >+#include "hw/virtio/virtio-iommu=2Eh"
>> >+
>> >+#include <glib/gmem=2Eh>
>> >+#include <rutabaga_gfx/rutabaga_gfx_ffi=2Eh>
>> >+
>> >+#define CHECK(condition, cmd)
>>      \
>> >+    do {
>>       \
>> >+        if (!(condition)) {
>>      \
>> >+            error_report("CHECK failed in %s() %s:" "%d", __func__,
>>      \
>> >+                         __FILE__, __LINE__);
>>      \
>> >+            (cmd)->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>>       \
>> >+            return;
>>      \
>> >+       }
>>       \
>> >+    } while (0)
>> >+
>> >+/*
>> >+ * This is the size of the char array in struct sock_addr_un=2E No Wa=
yland
>> socket
>> >+ * can be created with a path longer than this, including the null
>> terminator=2E
>> >+ */
>> >+#define UNIX_PATH_MAX sizeof((struct sockaddr_un) {} =2Esun_path)
>> >+
>> >+struct rutabaga_aio_data {
>> >+    struct VirtIOGPURutabaga *vr;
>> >+    struct rutabaga_fence fence;
>> >+};
>> >+
>> >+static void
>> >+virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, struct
>> virtio_gpu_scanout *s,
>> >+                                  uint32_t resource_id)
>> >+{
>> >+    struct virtio_gpu_simple_resource *res;
>> >+    struct rutabaga_transfer transfer =3D { 0 };
>> >+    struct iovec transfer_iovec;
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    res =3D virtio_gpu_find_resource(g, resource_id);
>> >+    if (!res) {
>> >+        return;
>> >+    }
>> >+
>> >+    if (res->width !=3D s->current_cursor->width ||
>> >+        res->height !=3D s->current_cursor->height) {
>> >+        return;
>> >+    }
>> >+
>> >+    transfer=2Ex =3D 0;
>> >+    transfer=2Ey =3D 0;
>> >+    transfer=2Ez =3D 0;
>> >+    transfer=2Ew =3D res->width;
>> >+    transfer=2Eh =3D res->height;
>> >+    transfer=2Ed =3D 1;
>> >+
>> >+    transfer_iovec=2Eiov_base =3D s->current_cursor->data;
>> >+    transfer_iovec=2Eiov_len =3D res->width * res->height * 4;
>> >+
>> >+    rutabaga_resource_transfer_read(vr->rutabaga, 0,
>> >+                                    resource_id, &transfer,
>> >+                                    &transfer_iovec);
>> >+}
>> >+
>> >+static void
>> >+virtio_gpu_rutabaga_gl_flushed(VirtIOGPUBase *b)
>> >+{
>> >+    VirtIOGPU *g =3D VIRTIO_GPU(b);
>> >+    virtio_gpu_process_cmdq(g);
>> >+}
>> >+
>> >+static void
>> >+rutabaga_cmd_create_resource_2d(VirtIOGPU *g,
>> >+                                struct virtio_gpu_ctrl_command *cmd)
>> >+{
>> >+    int32_t result;
>> >+    struct rutabaga_create_3d rc_3d =3D { 0 };
>> >+    struct virtio_gpu_simple_resource *res;
>> >+    struct virtio_gpu_resource_create_2d c2d;
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(c2d);
>> >+    trace_virtio_gpu_cmd_res_create_2d(c2d=2Eresource_id, c2d=2Eforma=
t,
>> >+                                       c2d=2Ewidth, c2d=2Eheight);
>> >+
>> >+    rc_3d=2Etarget =3D 2;
>> >+    rc_3d=2Eformat =3D c2d=2Eformat;
>> >+    rc_3d=2Ebind =3D (1 << 1);
>> >+    rc_3d=2Ewidth =3D c2d=2Ewidth;
>> >+    rc_3d=2Eheight =3D c2d=2Eheight;
>> >+    rc_3d=2Edepth =3D 1;
>> >+    rc_3d=2Earray_size =3D 1;
>> >+    rc_3d=2Elast_level =3D 0;
>> >+    rc_3d=2Enr_samples =3D 0;
>> >+    rc_3d=2Eflags =3D VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
>> >+
>> >+    result =3D rutabaga_resource_create_3d(vr->rutabaga, c2d=2Eresour=
ce_id,
>> &rc_3d);
>> >+    CHECK(!result, cmd);
>> >+
>> >+    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
>> >+    res->width =3D c2d=2Ewidth;
>> >+    res->height =3D c2d=2Eheight;
>> >+    res->format =3D c2d=2Eformat;
>> >+    res->resource_id =3D c2d=2Eresource_id;
>> >+
>> >+    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>> >+}
>> >+
>> >+static void
>> >+rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
>> >+                                struct virtio_gpu_ctrl_command *cmd)
>> >+{
>> >+    int32_t result;
>> >+    struct rutabaga_create_3d rc_3d =3D { 0 };
>> >+    struct virtio_gpu_simple_resource *res;
>> >+    struct virtio_gpu_resource_create_3d c3d;
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(c3d);
>> >+
>> >+    trace_virtio_gpu_cmd_res_create_3d(c3d=2Eresource_id, c3d=2Eforma=
t,
>> >+                                       c3d=2Ewidth, c3d=2Eheight, c3d=
=2Edepth);
>> >+
>> >+    rc_3d=2Etarget =3D c3d=2Etarget;
>> >+    rc_3d=2Eformat =3D c3d=2Eformat;
>> >+    rc_3d=2Ebind =3D c3d=2Ebind;
>> >+    rc_3d=2Ewidth =3D c3d=2Ewidth;
>> >+    rc_3d=2Eheight =3D c3d=2Eheight;
>> >+    rc_3d=2Edepth =3D c3d=2Edepth;
>> >+    rc_3d=2Earray_size =3D c3d=2Earray_size;
>> >+    rc_3d=2Elast_level =3D c3d=2Elast_level;
>> >+    rc_3d=2Enr_samples =3D c3d=2Enr_samples;
>> >+    rc_3d=2Eflags =3D c3d=2Eflags;
>> >+
>> >+    result =3D rutabaga_resource_create_3d(vr->rutabaga, c3d=2Eresour=
ce_id,
>> &rc_3d);
>> >+    CHECK(!result, cmd);
>> >+
>> >+    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
>> >+    res->width =3D c3d=2Ewidth;
>> >+    res->height =3D c3d=2Eheight;
>> >+    res->format =3D c3d=2Eformat;
>> >+    res->resource_id =3D c3d=2Eresource_id;
>> >+
>> >+    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>> >+}
>> >+
>> >+static void
>> >+rutabaga_cmd_resource_unref(VirtIOGPU *g,
>> >+                            struct virtio_gpu_ctrl_command *cmd)
>> >+{
>> >+    int32_t result;
>> >+    struct virtio_gpu_simple_resource *res;
>> >+    struct virtio_gpu_resource_unref unref;
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(unref);
>> >+
>> >+    trace_virtio_gpu_cmd_res_unref(unref=2Eresource_id);
>> >+
>> >+    res =3D virtio_gpu_find_resource(g, unref=2Eresource_id);
>> >+    CHECK(res, cmd);
>> >+
>> >+    result =3D rutabaga_resource_unref(vr->rutabaga, unref=2Eresource=
_id);
>> >+    CHECK(!result, cmd);
>> >+
>> >+    if (res->image) {
>> >+        pixman_image_unref(res->image);
>> >+    }
>> >+
>> >+    QTAILQ_REMOVE(&g->reslist, res, next);
>> >+    g_free(res);
>> >+}
>> >+
>> >+static void
>> >+rutabaga_cmd_context_create(VirtIOGPU *g,
>> >+                            struct virtio_gpu_ctrl_command *cmd)
>> >+{
>> >+    int32_t result;
>> >+    struct virtio_gpu_ctx_create cc;
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(cc);
>> >+    trace_virtio_gpu_cmd_ctx_create(cc=2Ehdr=2Ectx_id,
>> >+                                    cc=2Edebug_name);
>> >+
>> >+    result =3D rutabaga_context_create(vr->rutabaga, cc=2Ehdr=2Ectx_i=
d,
>> >+                                     cc=2Econtext_init, cc=2Edebug_na=
me,
>> cc=2Enlen);
>> >+    CHECK(!result, cmd);
>> >+}
>> >+
>> >+static void
>> >+rutabaga_cmd_context_destroy(VirtIOGPU *g,
>> >+                             struct virtio_gpu_ctrl_command *cmd)
>> >+{
>> >+    int32_t result;
>> >+    struct virtio_gpu_ctx_destroy cd;
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(cd);
>> >+    trace_virtio_gpu_cmd_ctx_destroy(cd=2Ehdr=2Ectx_id);
>> >+
>> >+    result =3D rutabaga_context_destroy(vr->rutabaga, cd=2Ehdr=2Ectx_=
id);
>> >+    CHECK(!result, cmd);
>> >+}
>> >+
>> >+static void
>> >+rutabaga_cmd_resource_flush(VirtIOGPU *g, struct virtio_gpu_ctrl_comm=
and
>> *cmd)
>> >+{
>> >+    int32_t result, i;
>> >+    struct virtio_gpu_scanout *scanout =3D NULL;
>> >+    struct virtio_gpu_simple_resource *res;
>> >+    struct rutabaga_transfer transfer =3D { 0 };
>> >+    struct iovec transfer_iovec;
>> >+    struct virtio_gpu_resource_flush rf;
>> >+    bool found =3D false;
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+    if (vr->headless) {
>> >+        return;
>> >+    }
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(rf);
>> >+    trace_virtio_gpu_cmd_res_flush(rf=2Eresource_id,
>> >+                                   rf=2Er=2Ewidth, rf=2Er=2Eheight, r=
f=2Er=2Ex,
>> rf=2Er=2Ey);
>> >+
>> >+    res =3D virtio_gpu_find_resource(g, rf=2Eresource_id);
>> >+    CHECK(res, cmd);
>> >+
>> >+    for (i =3D 0; i < g->parent_obj=2Econf=2Emax_outputs; i++) {
>> >+        scanout =3D &g->parent_obj=2Escanout[i];
>> >+        if (i =3D=3D res->scanout_bitmask) {
>> >+            found =3D true;
>> >+            break;
>> >+        }
>> >+    }
>> >+
>> >+    if (!found) {
>> >+        return;
>> >+    }
>> >+
>> >+    transfer=2Ex =3D 0;
>> >+    transfer=2Ey =3D 0;
>> >+    transfer=2Ez =3D 0;
>> >+    transfer=2Ew =3D res->width;
>> >+    transfer=2Eh =3D res->height;
>> >+    transfer=2Ed =3D 1;
>> >+
>> >+    transfer_iovec=2Eiov_base =3D pixman_image_get_data(res->image);
>> >+    transfer_iovec=2Eiov_len =3D res->width * res->height * 4;
>> >+
>> >+    result =3D rutabaga_resource_transfer_read(vr->rutabaga, 0,
>> >+                                             rf=2Eresource_id, &trans=
fer,
>> >+                                             &transfer_iovec);
>> >+    CHECK(!result, cmd);
>> >+    dpy_gfx_update_full(scanout->con);
>> >+}
>> >+
>> >+static void
>> >+rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command
>> *cmd)
>> >+{
>> >+    struct virtio_gpu_simple_resource *res;
>> >+    struct virtio_gpu_scanout *scanout =3D NULL;
>> >+    struct virtio_gpu_set_scanout ss;
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+    if (vr->headless) {
>> >+        return;
>> >+    }
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(ss);
>> >+    trace_virtio_gpu_cmd_set_scanout(ss=2Escanout_id, ss=2Eresource_i=
d,
>> >+                                     ss=2Er=2Ewidth, ss=2Er=2Eheight,=
 ss=2Er=2Ex,
>> ss=2Er=2Ey);
>> >+
>> >+    CHECK(ss=2Escanout_id < VIRTIO_GPU_MAX_SCANOUTS, cmd);
>> >+    scanout =3D &g->parent_obj=2Escanout[ss=2Escanout_id];
>> >+
>> >+    if (ss=2Eresource_id =3D=3D 0) {
>> >+        dpy_gfx_replace_surface(scanout->con, NULL);
>> >+        dpy_gl_scanout_disable(scanout->con);
>> >+        return;
>> >+    }
>> >+
>> >+    res =3D virtio_gpu_find_resource(g, ss=2Eresource_id);
>> >+    CHECK(res, cmd);
>> >+
>> >+    if (!res->image) {
>> >+        pixman_format_code_t pformat;
>> >+        pformat =3D virtio_gpu_get_pixman_format(res->format);
>> >+        CHECK(pformat, cmd);
>> >+
>> >+        res->image =3D pixman_image_create_bits(pformat,
>> >+                                              res->width,
>> >+                                              res->height,
>> >+                                              NULL, 0);
>> >+        CHECK(res->image, cmd);
>> >+        pixman_image_ref(res->image);
>> >+    }
>> >+
>> >+    g->parent_obj=2Eenable =3D 1;
>> >+
>> >+    /* realloc the surface ptr */
>> >+    scanout->ds =3D qemu_create_displaysurface_pixman(res->image);
>> >+    dpy_gfx_replace_surface(scanout->con, NULL);
>> >+    dpy_gfx_replace_surface(scanout->con, scanout->ds);
>> >+    res->scanout_bitmask =3D ss=2Escanout_id;
>> >+}
>> >+
>> >+static void
>> >+rutabaga_cmd_submit_3d(VirtIOGPU *g,
>> >+                       struct virtio_gpu_ctrl_command *cmd)
>> >+{
>> >+    int32_t result;
>> >+    struct virtio_gpu_cmd_submit cs;
>> >+    struct rutabaga_command rutabaga_cmd =3D { 0 };
>> >+    g_autofree uint8_t *buf =3D NULL;
>> >+    size_t s;
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(cs);
>> >+    trace_virtio_gpu_cmd_ctx_submit(cs=2Ehdr=2Ectx_id, cs=2Esize);
>> >+
>> >+    buf =3D g_new0(uint8_t, cs=2Esize);
>> >+    s =3D iov_to_buf(cmd->elem=2Eout_sg, cmd->elem=2Eout_num,
>> >+                   sizeof(cs), buf, cs=2Esize);
>> >+    CHECK(s =3D=3D cs=2Esize, cmd);
>> >+
>> >+    rutabaga_cmd=2Ectx_id =3D cs=2Ehdr=2Ectx_id;
>> >+    rutabaga_cmd=2Ecmd =3D buf;
>> >+    rutabaga_cmd=2Ecmd_size =3D cs=2Esize;
>> >+
>> >+    result =3D rutabaga_submit_command(vr->rutabaga, &rutabaga_cmd);
>> >+    CHECK(!result, cmd);
>> >+}
>> >+
>> >+static void
>> >+rutabaga_cmd_transfer_to_host_2d(VirtIOGPU *g,
>> >+                                 struct virtio_gpu_ctrl_command *cmd)
>> >+{
>> >+    int32_t result;
>> >+    struct rutabaga_transfer transfer =3D { 0 };
>> >+    struct virtio_gpu_transfer_to_host_2d t2d;
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(t2d);
>> >+    trace_virtio_gpu_cmd_res_xfer_toh_2d(t2d=2Eresource_id);
>> >+
>> >+    transfer=2Ex =3D t2d=2Er=2Ex;
>> >+    transfer=2Ey =3D t2d=2Er=2Ey;
>> >+    transfer=2Ez =3D 0;
>> >+    transfer=2Ew =3D t2d=2Er=2Ewidth;
>> >+    transfer=2Eh =3D t2d=2Er=2Eheight;
>> >+    transfer=2Ed =3D 1;
>> >+
>> >+    result =3D rutabaga_resource_transfer_write(vr->rutabaga, 0,
>> t2d=2Eresource_id,
>> >+                                              &transfer);
>> >+    CHECK(!result, cmd);
>> >+}
>> >+
>> >+static void
>> >+rutabaga_cmd_transfer_to_host_3d(VirtIOGPU *g,
>> >+                                 struct virtio_gpu_ctrl_command *cmd)
>> >+{
>> >+    int32_t result;
>> >+    struct rutabaga_transfer transfer =3D { 0 };
>> >+    struct virtio_gpu_transfer_host_3d t3d;
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(t3d);
>> >+    trace_virtio_gpu_cmd_res_xfer_toh_3d(t3d=2Eresource_id);
>> >+
>> >+    transfer=2Ex =3D t3d=2Ebox=2Ex;
>> >+    transfer=2Ey =3D t3d=2Ebox=2Ey;
>> >+    transfer=2Ez =3D t3d=2Ebox=2Ez;
>> >+    transfer=2Ew =3D t3d=2Ebox=2Ew;
>> >+    transfer=2Eh =3D t3d=2Ebox=2Eh;
>> >+    transfer=2Ed =3D t3d=2Ebox=2Ed;
>> >+    transfer=2Elevel =3D t3d=2Elevel;
>> >+    transfer=2Estride =3D t3d=2Estride;
>> >+    transfer=2Elayer_stride =3D t3d=2Elayer_stride;
>> >+    transfer=2Eoffset =3D t3d=2Eoffset;
>> >+
>> >+    result =3D rutabaga_resource_transfer_write(vr->rutabaga,
>> t3d=2Ehdr=2Ectx_id,
>> >+                                              t3d=2Eresource_id,
>> &transfer);
>> >+    CHECK(!result, cmd);
>> >+}
>> >+
>> >+static void
>> >+rutabaga_cmd_transfer_from_host_3d(VirtIOGPU *g,
>> >+                                   struct virtio_gpu_ctrl_command *cm=
d)
>> >+{
>> >+    int32_t result;
>> >+    struct rutabaga_transfer transfer =3D { 0 };
>> >+    struct virtio_gpu_transfer_host_3d t3d;
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(t3d);
>> >+    trace_virtio_gpu_cmd_res_xfer_fromh_3d(t3d=2Eresource_id);
>> >+
>> >+    transfer=2Ex =3D t3d=2Ebox=2Ex;
>> >+    transfer=2Ey =3D t3d=2Ebox=2Ey;
>> >+    transfer=2Ez =3D t3d=2Ebox=2Ez;
>> >+    transfer=2Ew =3D t3d=2Ebox=2Ew;
>> >+    transfer=2Eh =3D t3d=2Ebox=2Eh;
>> >+    transfer=2Ed =3D t3d=2Ebox=2Ed;
>> >+    transfer=2Elevel =3D t3d=2Elevel;
>> >+    transfer=2Estride =3D t3d=2Estride;
>> >+    transfer=2Elayer_stride =3D t3d=2Elayer_stride;
>> >+    transfer=2Eoffset =3D t3d=2Eoffset;
>> >+
>> >+    result =3D rutabaga_resource_transfer_read(vr->rutabaga,
>> t3d=2Ehdr=2Ectx_id,
>> >+                                             t3d=2Eresource_id, &tran=
sfer,
>> NULL);
>> >+    CHECK(!result, cmd);
>> >+}
>> >+
>> >+static void
>> >+rutabaga_cmd_attach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_comm=
and
>> *cmd)
>> >+{
>> >+    struct rutabaga_iovecs vecs =3D { 0 };
>> >+    struct virtio_gpu_simple_resource *res;
>> >+    struct virtio_gpu_resource_attach_backing att_rb;
>> >+    int ret;
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(att_rb);
>> >+    trace_virtio_gpu_cmd_res_back_attach(att_rb=2Eresource_id);
>> >+
>> >+    res =3D virtio_gpu_find_resource(g, att_rb=2Eresource_id);
>> >+    CHECK(res, cmd);
>> >+    CHECK(!res->iov, cmd);
>> >+
>> >+    ret =3D virtio_gpu_create_mapping_iov(g, att_rb=2Enr_entries,
>> sizeof(att_rb),
>> >+                                        cmd, NULL, &res->iov,
>> &res->iov_cnt);
>> >+    CHECK(!ret, cmd);
>> >+
>> >+    vecs=2Eiovecs =3D res->iov;
>> >+    vecs=2Enum_iovecs =3D res->iov_cnt;
>> >+
>> >+    ret =3D rutabaga_resource_attach_backing(vr->rutabaga,
>> att_rb=2Eresource_id,
>> >+                                           &vecs);
>> >+    if (ret !=3D 0) {
>> >+        virtio_gpu_cleanup_mapping(g, res);
>> >+    }
>> >+
>> >+    CHECK(!ret, cmd);
>> >+}
>> >+
>> >+static void
>> >+rutabaga_cmd_detach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_comm=
and
>> *cmd)
>> >+{
>> >+    struct virtio_gpu_simple_resource *res;
>> >+    struct virtio_gpu_resource_detach_backing detach_rb;
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(detach_rb);
>> >+    trace_virtio_gpu_cmd_res_back_detach(detach_rb=2Eresource_id);
>> >+
>> >+    res =3D virtio_gpu_find_resource(g, detach_rb=2Eresource_id);
>> >+    CHECK(res, cmd);
>> >+
>> >+    rutabaga_resource_detach_backing(vr->rutabaga,
>> >+                                     detach_rb=2Eresource_id);
>> >+
>> >+    virtio_gpu_cleanup_mapping(g, res);
>> >+}
>> >+
>> >+static void
>> >+rutabaga_cmd_ctx_attach_resource(VirtIOGPU *g,
>> >+                                 struct virtio_gpu_ctrl_command *cmd)
>> >+{
>> >+    int32_t result;
>> >+    struct virtio_gpu_ctx_resource att_res;
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(att_res);
>> >+    trace_virtio_gpu_cmd_ctx_res_attach(att_res=2Ehdr=2Ectx_id,
>> >+                                        att_res=2Eresource_id);
>> >+
>> >+    result =3D rutabaga_context_attach_resource(vr->rutabaga,
>> att_res=2Ehdr=2Ectx_id,
>> >+                                              att_res=2Eresource_id);
>> >+    CHECK(!result, cmd);
>> >+}
>> >+
>> >+static void
>> >+rutabaga_cmd_ctx_detach_resource(VirtIOGPU *g,
>> >+                                 struct virtio_gpu_ctrl_command *cmd)
>> >+{
>> >+    int32_t result;
>> >+    struct virtio_gpu_ctx_resource det_res;
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(det_res);
>> >+    trace_virtio_gpu_cmd_ctx_res_detach(det_res=2Ehdr=2Ectx_id,
>> >+                                        det_res=2Eresource_id);
>> >+
>> >+    result =3D rutabaga_context_detach_resource(vr->rutabaga,
>> det_res=2Ehdr=2Ectx_id,
>> >+                                              det_res=2Eresource_id);
>> >+    CHECK(!result, cmd);
>> >+}
>> >+
>> >+static void
>> >+rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct
>> virtio_gpu_ctrl_command *cmd)
>> >+{
>> >+    int32_t result;
>> >+    struct virtio_gpu_get_capset_info info;
>> >+    struct virtio_gpu_resp_capset_info resp;
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(info);
>> >+
>> >+    result =3D rutabaga_get_capset_info(vr->rutabaga, info=2Ecapset_i=
ndex,
>> >+                                      &resp=2Ecapset_id,
>> &resp=2Ecapset_max_version,
>> >+                                      &resp=2Ecapset_max_size);
>> >+    CHECK(!result, cmd);
>> >+
>> >+    resp=2Ehdr=2Etype =3D VIRTIO_GPU_RESP_OK_CAPSET_INFO;
>> >+    virtio_gpu_ctrl_response(g, cmd, &resp=2Ehdr, sizeof(resp));
>> >+}
>> >+
>> >+static void
>> >+rutabaga_cmd_get_capset(VirtIOGPU *g, struct virtio_gpu_ctrl_command
>> *cmd)
>> >+{
>> >+    int32_t result;
>> >+    struct virtio_gpu_get_capset gc;
>> >+    struct virtio_gpu_resp_capset *resp;
>> >+    uint32_t capset_size, capset_version;
>> >+    uint32_t current_id, i;
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(gc);
>> >+    for (i =3D 0; i < vr->num_capsets; i++) {
>> >+        result =3D rutabaga_get_capset_info(vr->rutabaga, i,
>> >+                                          &current_id, &capset_versio=
n,
>> >+                                          &capset_size);
>> >+        CHECK(!result, cmd);
>> >+
>> >+        if (current_id =3D=3D gc=2Ecapset_id) {
>> >+            break;
>> >+        }
>> >+    }
>> >+
>> >+    CHECK(i < vr->num_capsets, cmd);
>> >+
>> >+    resp =3D g_malloc0(sizeof(*resp) + capset_size);
>> >+    resp->hdr=2Etype =3D VIRTIO_GPU_RESP_OK_CAPSET;
>> >+    rutabaga_get_capset(vr->rutabaga, gc=2Ecapset_id, gc=2Ecapset_ver=
sion,
>> >+                        resp->capset_data, capset_size);
>> >+
>> >+    virtio_gpu_ctrl_response(g, cmd, &resp->hdr, sizeof(*resp) +
>> capset_size);
>> >+    g_free(resp);
>> >+}
>> >+
>> >+static void
>> >+rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
>> >+                                  struct virtio_gpu_ctrl_command *cmd=
)
>> >+{
>> >+    int result;
>> >+    struct rutabaga_iovecs vecs =3D { 0 };
>> >+    g_autofree struct virtio_gpu_simple_resource *res =3D NULL;
>> >+    struct virtio_gpu_resource_create_blob cblob;
>> >+    struct rutabaga_create_blob rc_blob =3D { 0 };
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(cblob);
>> >+    trace_virtio_gpu_cmd_res_create_blob(cblob=2Eresource_id, cblob=
=2Esize);
>> >+
>> >+    CHECK(cblob=2Eresource_id !=3D 0, cmd);
>> >+
>> >+    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
>> >+
>> >+    res->resource_id =3D cblob=2Eresource_id;
>> >+    res->blob_size =3D cblob=2Esize;
>> >+
>> >+    if (cblob=2Eblob_mem !=3D VIRTIO_GPU_BLOB_MEM_HOST3D) {
>> >+        result =3D virtio_gpu_create_mapping_iov(g, cblob=2Enr_entrie=
s,
>> >+                                               sizeof(cblob), cmd,
>> &res->addrs,
>> >+                                               &res->iov, &res->iov_c=
nt);
>> >+        CHECK(!result, cmd);
>> >+    }
>> >+
>> >+    rc_blob=2Eblob_id =3D cblob=2Eblob_id;
>> >+    rc_blob=2Eblob_mem =3D cblob=2Eblob_mem;
>> >+    rc_blob=2Eblob_flags =3D cblob=2Eblob_flags;
>> >+    rc_blob=2Esize =3D cblob=2Esize;
>> >+
>> >+    vecs=2Eiovecs =3D res->iov;
>> >+    vecs=2Enum_iovecs =3D res->iov_cnt;
>> >+
>> >+    result =3D rutabaga_resource_create_blob(vr->rutabaga,
>> cblob=2Ehdr=2Ectx_id,
>> >+                                           cblob=2Eresource_id, &rc_b=
lob,
>> &vecs,
>> >+                                           NULL);
>> >+
>> >+    if (result && cblob=2Eblob_mem !=3D VIRTIO_GPU_BLOB_MEM_HOST3D) {
>> >+        virtio_gpu_cleanup_mapping(g, res);
>> >+    }
>> >+
>> >+    CHECK(!result, cmd);
>> >+
>> >+    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>> >+    res =3D NULL;
>> >+}
>> >+
>> >+static void
>> >+rutabaga_cmd_resource_map_blob(VirtIOGPU *g,
>> >+                               struct virtio_gpu_ctrl_command *cmd)
>> >+{
>> >+    int32_t result;
>> >+    uint32_t map_info =3D 0;
>> >+    uint32_t slot =3D 0;
>> >+    struct virtio_gpu_simple_resource *res;
>> >+    struct rutabaga_mapping mapping =3D { 0 };
>> >+    struct virtio_gpu_resource_map_blob mblob;
>> >+    struct virtio_gpu_resp_map_info resp =3D { 0 };
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(mblob);
>> >+
>> >+    CHECK(mblob=2Eresource_id !=3D 0, cmd);
>> >+
>> >+    res =3D virtio_gpu_find_resource(g, mblob=2Eresource_id);
>> >+    CHECK(res, cmd);
>> >+
>> >+    result =3D rutabaga_resource_map_info(vr->rutabaga, mblob=2Eresou=
rce_id,
>> >+                                        &map_info);
>> >+    CHECK(!result, cmd);
>> >+
>> >+    /*
>> >+     * RUTABAGA_MAP_ACCESS_* flags are not part of the virtio-gpu spe=
c,
>> but do
>> >+     * exist to potentially allow the hypervisor to restrict write
>> access to
>> >+     * memory=2E QEMU does not need to use this functionality at the
>> moment=2E
>> >+     */
>> >+    resp=2Emap_info =3D map_info & RUTABAGA_MAP_CACHE_MASK;
>> >+
>> >+    result =3D rutabaga_resource_map(vr->rutabaga, mblob=2Eresource_i=
d,
>> &mapping);
>> >+    CHECK(!result, cmd);
>> >+
>> >+    for (slot =3D 0; slot < MAX_SLOTS; slot++) {
>> >+        if (vr->memory_regions[slot]=2Eused) {
>> >+            continue;
>> >+        }
>> >+
>> >+        MemoryRegion *mr =3D &(vr->memory_regions[slot]=2Emr);
>> >+        memory_region_init_ram_ptr(mr, NULL, "blob", mapping=2Esize,
>> >+                                   mapping=2Eptr);
>> >+        memory_region_add_subregion(&g->parent_obj=2Ehostmem,
>> >+                                    mblob=2Eoffset, mr);
>> >+        vr->memory_regions[slot]=2Eresource_id =3D mblob=2Eresource_i=
d;
>> >+        vr->memory_regions[slot]=2Eused =3D 1;
>> >+        break;
>> >+    }
>> >+
>> >+    if (slot >=3D MAX_SLOTS) {
>> >+        result =3D rutabaga_resource_unmap(vr->rutabaga,
>> mblob=2Eresource_id);
>> >+        CHECK(!result, cmd);
>> >+    }
>> >+
>> >+    CHECK(slot < MAX_SLOTS, cmd);
>> >+
>> >+    resp=2Ehdr=2Etype =3D VIRTIO_GPU_RESP_OK_MAP_INFO;
>> >+    virtio_gpu_ctrl_response(g, cmd, &resp=2Ehdr, sizeof(resp));
>> >+}
>> >+
>> >+static void
>> >+rutabaga_cmd_resource_unmap_blob(VirtIOGPU *g,
>> >+                                 struct virtio_gpu_ctrl_command *cmd)
>> >+{
>> >+    int32_t result;
>> >+    uint32_t slot =3D 0;
>> >+    struct virtio_gpu_simple_resource *res;
>> >+    struct virtio_gpu_resource_unmap_blob ublob;
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(ublob);
>> >+
>> >+    CHECK(ublob=2Eresource_id !=3D 0, cmd);
>> >+
>> >+    res =3D virtio_gpu_find_resource(g, ublob=2Eresource_id);
>> >+    CHECK(res, cmd);
>> >+
>> >+    for (slot =3D 0; slot < MAX_SLOTS; slot++) {
>> >+        if (vr->memory_regions[slot]=2Eresource_id !=3D ublob=2Eresou=
rce_id) {
>> >+            continue;
>> >+        }
>> >+
>> >+        MemoryRegion *mr =3D &(vr->memory_regions[slot]=2Emr);
>> >+        memory_region_del_subregion(&g->parent_obj=2Ehostmem, mr);
>> >+
>> >+        vr->memory_regions[slot]=2Eresource_id =3D 0;
>> >+        vr->memory_regions[slot]=2Eused =3D 0;
>> >+        break;
>> >+    }
>> >+
>> >+    CHECK(slot < MAX_SLOTS, cmd);
>> >+    result =3D rutabaga_resource_unmap(vr->rutabaga, res->resource_id=
);
>> >+    CHECK(!result, cmd);
>> >+}
>> >+
>> >+static void
>> >+virtio_gpu_rutabaga_process_cmd(VirtIOGPU *g,
>> >+                                struct virtio_gpu_ctrl_command *cmd)
>> >+{
>> >+    struct rutabaga_fence fence =3D { 0 };
>> >+    int32_t result;
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
>> >+
>> >+    switch (cmd->cmd_hdr=2Etype) {
>> >+    case VIRTIO_GPU_CMD_CTX_CREATE:
>> >+        rutabaga_cmd_context_create(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_CTX_DESTROY:
>> >+        rutabaga_cmd_context_destroy(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_RESOURCE_CREATE_2D:
>> >+        rutabaga_cmd_create_resource_2d(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_RESOURCE_CREATE_3D:
>> >+        rutabaga_cmd_create_resource_3d(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_SUBMIT_3D:
>> >+        rutabaga_cmd_submit_3d(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D:
>> >+        rutabaga_cmd_transfer_to_host_2d(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D:
>> >+        rutabaga_cmd_transfer_to_host_3d(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D:
>> >+        rutabaga_cmd_transfer_from_host_3d(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING:
>> >+        rutabaga_cmd_attach_backing(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:
>> >+        rutabaga_cmd_detach_backing(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_SET_SCANOUT:
>> >+        rutabaga_cmd_set_scanout(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_RESOURCE_FLUSH:
>> >+        rutabaga_cmd_resource_flush(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_RESOURCE_UNREF:
>> >+        rutabaga_cmd_resource_unref(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:
>> >+        rutabaga_cmd_ctx_attach_resource(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE:
>> >+        rutabaga_cmd_ctx_detach_resource(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_GET_CAPSET_INFO:
>> >+        rutabaga_cmd_get_capset_info(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_GET_CAPSET:
>> >+        rutabaga_cmd_get_capset(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:
>> >+        virtio_gpu_get_display_info(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_GET_EDID:
>> >+        virtio_gpu_get_edid(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB:
>> >+        rutabaga_cmd_resource_create_blob(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB:
>> >+        rutabaga_cmd_resource_map_blob(g, cmd);
>> >+        break;
>> >+    case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:
>> >+        rutabaga_cmd_resource_unmap_blob(g, cmd);
>> >+        break;
>> >+    default:
>> >+        cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>> >+        break;
>> >+    }
>> >+
>> >+    if (cmd->finished) {
>> >+        return;
>> >+    }
>> >+    if (cmd->error) {
>> >+        error_report("%s: ctrl 0x%x, error 0x%x", __func__,
>> >+                     cmd->cmd_hdr=2Etype, cmd->error);
>> >+        virtio_gpu_ctrl_response_nodata(g, cmd, cmd->error);
>> >+        return;
>> >+    }
>> >+    if (!(cmd->cmd_hdr=2Eflags & VIRTIO_GPU_FLAG_FENCE)) {
>> >+        virtio_gpu_ctrl_response_nodata(g, cmd,
>> VIRTIO_GPU_RESP_OK_NODATA);
>> >+        return;
>> >+    }
>> >+
>> >+    fence=2Eflags =3D cmd->cmd_hdr=2Eflags;
>> >+    fence=2Ectx_id =3D cmd->cmd_hdr=2Ectx_id;
>> >+    fence=2Efence_id =3D cmd->cmd_hdr=2Efence_id;
>> >+    fence=2Ering_idx =3D cmd->cmd_hdr=2Ering_idx;
>> >+
>> >+    trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr=2Efence_id,
>> cmd->cmd_hdr=2Etype);
>> >+
>> >+    result =3D rutabaga_create_fence(vr->rutabaga, &fence);
>> >+    CHECK(!result, cmd);
>> >+}
>> >+
>> >+static void
>> >+virtio_gpu_rutabaga_aio_cb(void *opaque)
>> >+{
>> >+    struct rutabaga_aio_data *data =3D opaque;
>> >+    VirtIOGPU *g =3D VIRTIO_GPU(data->vr);
>> >+    struct rutabaga_fence fence_data =3D data->fence;
>> >+    struct virtio_gpu_ctrl_command *cmd, *tmp;
>> >+
>> >+    uint32_t signaled_ctx_specific =3D fence_data=2Eflags &
>> >+                                     RUTABAGA_FLAG_INFO_RING_IDX;
>> >+
>> >+    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
>> >+        /*
>> >+         * Due to context specific timelines=2E
>> >+         */
>> >+        uint32_t target_ctx_specific =3D cmd->cmd_hdr=2Eflags &
>> >+                                       RUTABAGA_FLAG_INFO_RING_IDX;
>> >+
>> >+        if (signaled_ctx_specific !=3D target_ctx_specific) {
>> >+            continue;
>> >+        }
>> >+
>> >+        if (signaled_ctx_specific &&
>> >+           (cmd->cmd_hdr=2Ering_idx !=3D fence_data=2Ering_idx)) {
>> >+            continue;
>> >+        }
>> >+
>> >+        if (cmd->cmd_hdr=2Efence_id > fence_data=2Efence_id) {
>> >+            continue;
>> >+        }
>> >+
>> >+        trace_virtio_gpu_fence_resp(cmd->cmd_hdr=2Efence_id);
>> >+        virtio_gpu_ctrl_response_nodata(g, cmd,
>> VIRTIO_GPU_RESP_OK_NODATA);
>> >+        QTAILQ_REMOVE(&g->fenceq, cmd, next);
>> >+        g_free(cmd);
>> >+    }
>> >+
>> >+    g_free(data);
>> >+}
>> >+
>> >+static void
>> >+virtio_gpu_rutabaga_fence_cb(uint64_t user_data,
>> >+                             const struct rutabaga_fence *fence) {
>> >+    struct rutabaga_aio_data *data;
>> >+    VirtIOGPU *g =3D (VirtIOGPU *)user_data;
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    /*
>> >+     * gfxstream and both cross-domain (and even newer versions
>> virglrenderer:
>> >+     * see VIRGL_RENDERER_ASYNC_FENCE_CB) like to signal fence
>> completion on
>> >+     * threads ("callback threads") that are different from the threa=
d
>> that
>> >+     * processes the command queue ("main thread")=2E
>> >+     *
>> >+     * crosvm and other virtio-gpu 1=2E1 implementations enable callb=
ack
>> threads
>> >+     * via locking=2E  However, on QEMU a deadlock is observed if
>> >+     * virtio_gpu_ctrl_response_nodata(=2E=2E) [used in the fence cal=
lback]
>> is used
>> >+     * from a thread that is not the main thread=2E
>> >+     *
>> >+     * The reason is QEMU's internal locking is designed to work with
>> QEMU
>> >+     * threads (see rcu_register_thread()) and not generic C/C++/Rust
>> threads=2E
>> >+     * For now, we can workaround this by scheduling the return of th=
e
>> >+     * fence descriptors on the main thread=2E
>> >+     */
>> >+
>> >+    data =3D g_new0(struct rutabaga_aio_data, 1);
>> >+    data->vr =3D vr;
>> >+    data->fence =3D *fence;
>> >+    aio_bh_schedule_oneshot(qemu_get_aio_context(),
>> >+                            virtio_gpu_rutabaga_aio_cb,
>> >+                            data);
>> >+}
>> >+
>> >+static void
>> >+virtio_gpu_rutabaga_debug_cb(uint64_t user_data,
>> >+                             const struct rutabaga_debug *debug) {
>> >+
>> >+    if (debug->debug_type =3D=3D RUTABAGA_DEBUG_ERROR) {
>> >+        error_report("%s", debug->message);
>> >+    } else if (debug->debug_type =3D=3D RUTABAGA_DEBUG_WARN) {
>> >+        warn_report("%s", debug->message);
>> >+    } else if (debug->debug_type =3D=3D RUTABAGA_DEBUG_INFO) {
>> >+        info_report("%s", debug->message);
>> >+    }
>> >+}
>> >+
>> >+static bool virtio_gpu_rutabaga_init(VirtIOGPU *g, Error **errp)
>> >+{
>> >+    int result;
>> >+    uint64_t capset_mask;
>> >+    struct rutabaga_builder builder =3D { 0 };
>> >+    char wayland_socket_path[UNIX_PATH_MAX];
>> >+    struct rutabaga_channel channel =3D { 0 };
>> >+    struct rutabaga_channels channels =3D { 0 };
>> >+
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+    vr->rutabaga =3D NULL;
>> >+
>> >+    if (!vr->capset_names) {
>> >+        error_setg(errp, "a capset name from the virtio-gpu spec is
>> required");
>> >+        return false;
>> >+    }
>> >+
>> >+    builder=2Ewsi =3D RUTABAGA_WSI_SURFACELESS;
>> >+    /*
>> >+     * Currently, if WSI is specified, the only valid strings are
>> "surfaceless"
>> >+     * or "headless"=2E  Surfaceless doesn't create a native window
>> surface, but
>> >+     * does copy from the render target to the Pixman buffer if a
>> virtio-gpu
>> >+     * 2D hypercall is issued=2E  Surfacless is the default=2E
>> >+     *
>> >+     * Headless is like surfaceless, but doesn't copy to the Pixman
>> buffer=2E The
>> >+     * use case is automated testing environments where there is no n=
eed
>> to view
>> >+     * results=2E
>> >+     *
>> >+     * In the future, more performant virtio-gpu 2D UI integration ma=
y
>> be added=2E
>> >+     */
>> >+    if (vr->wsi) {
>> >+        if (g_str_equal(vr->wsi, "surfaceless")) {
>> >+            vr->headless =3D false;
>> >+        } else if (g_str_equal(vr->wsi, "headless")) {
>> >+            vr->headless =3D true;
>> >+        } else {
>> >+            error_setg(errp, "invalid wsi option selected");
>> >+            return false;
>> >+        }
>> >+    }
>> >+
>> >+    result =3D rutabaga_calculate_capset_mask(vr->capset_names,
>> &capset_mask);
>>
>> First, sorry for responding after such a long time=2E I've been busy wi=
th
>> work and I'm doing QEMU in my free time=2E
>>
>> In iteration 1 I've raised the topic on capset_names [1] and I haven't
>> seen it answered properly=2E Perhaps I need to rephrase a bit so here w=
e go:
>> capset_names seems to be colon-separated list of bit options managed by
>> rutabaga=2E This introduces yet another way of options handling=2E Ther=
e have
>> been talks about harmonizing options handling in QEMU since apparently =
it
>> is considered too complex [2,3]=2E
>
>
>> Why not pass the "capset" as a bitfield like capset_mask and have QEMU
>> create "capset" from QOM properties?
>
>IIUC these flags could come from virtio_gpu=2Eh which is already present =
in
>> the QEMU tree=2E This would not inly shortcut the dependency on rutabag=
a here
>> but would also be more idiomatic QEMU (since it makes the options more
>> introspectable by internal machinery)=2E
>
>
>> Of course the bitfield approach would require modifications in QEMU
>> whenever rutabaga gains new features=2E However, I figure that in the l=
ong
>> term rutabaga will be quite feature complete such that the benefits of
>> idiomatic QEMU handling will outweigh the decoupling of the projects=2E
>>
>> What do you think?
>>
>
>I think what you're suggesting is something like -device
>virtio-gpu-rutabaga,capset_mask=3D0x10100 [40, which would be
>gfxstream_vulkan + cross_domain]?

I was thinking more along the lines of `virtio-gpu-rutabaga,gfxstream_vulk=
an=3Don,cross_domain=3Don` where gfxstream_vulkan and cross_domain are bool=
ean QOM properties=2E This would make for a human-readable format which fol=
lows QEMU style=2E

>
>We actually did consider something like that when adding the
>--context-types flag [with crosvm], but there was a desire for a
>human-readable format rather than numbers [even if they are in the
>virtio-gpu spec]=2E
>
>Additionally, there are quite a few context types that people are playing
>around with [gfxstream-gles, gfxstream-composer] that are launchable and
>aren't in the spec just yet=2E

Right, QEMU had to be modified for this kind of experimentation=2E I consi=
dered this in my last paragraph and figured that in the long run QEMU *may*=
 prefer more idiomatic option handling since it tries hard to not break its=
 command line interface=2E I'm just pointing this out -- the decision is ul=
timately up to the community=2E

Why not have dedicated QEMU development branches for experimentation? Woul=
dn't upstreaming new features into QEMU be a good motivation to get the mis=
sing pieces into the spec, once they are mature?

>
>Also, a key feature we want to explicitly **not** turn on all available
>context-types and let the user decide=2E

How would you prevent that with the current colon-separated approach? Spli=
tting capset_mask in multiple parameters is just a different syntactical re=
presentation of the same thing=2E

> That'll allow guest Mesa in
>particular to do its magic in its loader=2E  So one may run Zink + ANV wi=
th
>ioctl forwarding, or Iris + ioctl forwarding and compare performance with
>the same guest image=2E
>
>And another thing is one needs some knowledge of the host system to choos=
e
>the right context type=2E  You wouldn't do Zink + ANV ioctl forwarding on
>MacOS=2E  So I think the task of choosing the right context type will fal=
l to
>projects that depend on QEMU (such as Android Emulator) which have some
>knowledge of the host environment=2E
>
>We actually have a graphics detector somewhere that calls VK/OpenGL befor=
e
>launching the VM and sets the right options=2E  Plan is to port into
>gfxstream, maybe we could use that=2E

You could bail out in QEMU if rutabaga_calculate_capset_mask() detects con=
flicting combinations, no?

>
>So given the desire for human readable formats, being portable across VMM=
s
>(crosvm, qemu, rust-vmm??) and experimentation, the string -> capset mask
>conversion was put in the rutabaga API=2E  So I wouldn't change it for th=
ose
>reasons=2E

What do you mean by being portable across VMMs? Sure, QEMU had to be taugh=
t new flags before being able to use new rutabaga features=2E I agree that =
this comes with a certain inconvenience=2E But it may also be inconvenient =
for QEMU to deal with additional ad-hoc options parsing when there are effo=
rts for harmonization=2E

Did my comments shed new light into the discussion?

Thanks,
Bernhard

>
>
>>
>> Best regards,
>> Bernhard
>>
>> [1]
>> https://lore=2Ekernel=2Eorg/qemu-devel/D15471EC-D1D1-4DAA-A6E7-19827C36=
AEC8@gmail=2Ecom/
>> [2] https://m=2Eyoutube=2Ecom/watch?v=3DgtpOLQgnwug
>> [3] https://m=2Eyoutube=2Ecom/watch?v=3DFMQtog6KUlo
>>
>> >+    if (result) {
>> >+        error_setg_errno(errp, -result, "invalid capset names: %s",
>> >+                         vr->capset_names);
>> >+        return false;
>> >+    }
>> >+
>> >+    builder=2Efence_cb =3D virtio_gpu_rutabaga_fence_cb;
>> >+    builder=2Edebug_cb =3D virtio_gpu_rutabaga_debug_cb;
>> >+    builder=2Ecapset_mask =3D capset_mask;
>> >+    builder=2Euser_data =3D (uint64_t)g;
>> >+
>> >+    /*
>> >+     * If the user doesn't specify the wayland socket path, we try to
>> infer
>> >+     * the socket via a process similar to the one used by libwayland=
=2E
>> >+     * libwayland does the following:
>> >+     *
>> >+     * 1) If $WAYLAND_DISPLAY is set, attempt to connect to
>> >+     *    $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY
>> >+     * 2) Otherwise, attempt to connect to $XDG_RUNTIME_DIR/wayland-0
>> >+     * 3) Otherwise, don't pass a wayland socket to rutabaga=2E If a =
guest
>> >+     *    wayland proxy is launched, it will fail to work=2E
>> >+     */
>> >+    channel=2Echannel_type =3D RUTABAGA_CHANNEL_TYPE_WAYLAND;
>> >+    if (!vr->wayland_socket_path) {
>> >+        const char *runtime_dir =3D getenv("XDG_RUNTIME_DIR");
>> >+        const char *display =3D getenv("WAYLAND_DISPLAY");
>> >+        if (!display) {
>> >+            display =3D "wayland-0";
>> >+        }
>> >+
>> >+        if (runtime_dir) {
>> >+            result =3D snprintf(wayland_socket_path, UNIX_PATH_MAX,
>> >+                              "%s/%s", runtime_dir, display);
>> >+            if (result > 0 && result < UNIX_PATH_MAX) {
>> >+                channel=2Echannel_name =3D wayland_socket_path;
>> >+            }
>> >+        }
>> >+    } else {
>> >+        channel=2Echannel_name =3D vr->wayland_socket_path;
>> >+    }
>> >+
>> >+    if ((builder=2Ecapset_mask & (1 << RUTABAGA_CAPSET_CROSS_DOMAIN))=
) {
>> >+        if (channel=2Echannel_name) {
>> >+            channels=2Echannels =3D &channel;
>> >+            channels=2Enum_channels =3D 1;
>> >+            builder=2Echannels =3D &channels;
>> >+        }
>> >+    }
>> >+
>> >+    result =3D rutabaga_init(&builder, &vr->rutabaga);
>> >+    if (result) {
>> >+        error_setg_errno(errp, -result, "Failed to init rutabaga");
>> >+        return result;
>> >+    }
>> >+
>> >+    return true;
>> >+}
>> >+
>> >+static int virtio_gpu_rutabaga_get_num_capsets(VirtIOGPU *g)
>> >+{
>> >+    int result;
>> >+    uint32_t num_capsets;
>> >+    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >+
>> >+    result =3D rutabaga_get_num_capsets(vr->rutabaga, &num_capsets);
>> >+    if (result) {
>> >+        error_report("Failed to get capsets");
>> >+        return 0;
>> >+    }
>> >+    vr->num_capsets =3D num_capsets;
>> >+    return num_capsets;
>> >+}
>> >+
>> >+static void virtio_gpu_rutabaga_handle_ctrl(VirtIODevice *vdev,
>> VirtQueue *vq)
>> >+{
>> >+    VirtIOGPU *g =3D VIRTIO_GPU(vdev);
>> >+    struct virtio_gpu_ctrl_command *cmd;
>> >+
>> >+    if (!virtio_queue_ready(vq)) {
>> >+        return;
>> >+    }
>> >+
>> >+    cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command))=
;
>> >+    while (cmd) {
>> >+        cmd->vq =3D vq;
>> >+        cmd->error =3D 0;
>> >+        cmd->finished =3D false;
>> >+        QTAILQ_INSERT_TAIL(&g->cmdq, cmd, next);
>> >+        cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_comma=
nd));
>> >+    }
>> >+
>> >+    virtio_gpu_process_cmdq(g);
>> >+}
>> >+
>> >+static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **er=
rp)
>> >+{
>> >+    int num_capsets;
>> >+    VirtIOGPUBase *bdev =3D VIRTIO_GPU_BASE(qdev);
>> >+    VirtIOGPU *gpudev =3D VIRTIO_GPU(qdev);
>> >+
>> >+#if HOST_BIG_ENDIAN
>> >+    error_setg(errp, "rutabaga is not supported on bigendian platform=
s");
>> >+    return;
>> >+#endif
>> >+
>> >+    if (!virtio_gpu_rutabaga_init(gpudev, errp)) {
>> >+        return;
>> >+    }
>> >+
>> >+    num_capsets =3D virtio_gpu_rutabaga_get_num_capsets(gpudev);
>> >+    if (!num_capsets) {
>> >+        return;
>> >+    }
>> >+
>> >+    bdev->conf=2Eflags |=3D (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED);
>> >+    bdev->conf=2Eflags |=3D (1 << VIRTIO_GPU_FLAG_BLOB_ENABLED);
>> >+    bdev->conf=2Eflags |=3D (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLE=
D);
>> >+
>> >+    bdev->virtio_config=2Enum_capsets =3D num_capsets;
>> >+    virtio_gpu_device_realize(qdev, errp);
>> >+}
>> >+
>> >+static Property virtio_gpu_rutabaga_properties[] =3D {
>> >+    DEFINE_PROP_STRING("capset_names", VirtIOGPURutabaga, capset_name=
s),
>> >+    DEFINE_PROP_STRING("wayland_socket_path", VirtIOGPURutabaga,
>> >+                       wayland_socket_path),
>> >+    DEFINE_PROP_STRING("wsi", VirtIOGPURutabaga, wsi),
>> >+    DEFINE_PROP_END_OF_LIST(),
>> >+};
>> >+
>> >+static void virtio_gpu_rutabaga_class_init(ObjectClass *klass, void
>> *data)
>> >+{
>> >+    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> >+    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
>> >+    VirtIOGPUBaseClass *vbc =3D VIRTIO_GPU_BASE_CLASS(klass);
>> >+    VirtIOGPUClass *vgc =3D VIRTIO_GPU_CLASS(klass);
>> >+
>> >+    vbc->gl_flushed =3D virtio_gpu_rutabaga_gl_flushed;
>> >+    vgc->handle_ctrl =3D virtio_gpu_rutabaga_handle_ctrl;
>> >+    vgc->process_cmd =3D virtio_gpu_rutabaga_process_cmd;
>> >+    vgc->update_cursor_data =3D virtio_gpu_rutabaga_update_cursor;
>> >+
>> >+    vdc->realize =3D virtio_gpu_rutabaga_realize;
>> >+    device_class_set_props(dc, virtio_gpu_rutabaga_properties);
>> >+}
>> >+
>> >+static const TypeInfo virtio_gpu_rutabaga_info =3D {
>> >+    =2Ename =3D TYPE_VIRTIO_GPU_RUTABAGA,
>> >+    =2Eparent =3D TYPE_VIRTIO_GPU,
>> >+    =2Einstance_size =3D sizeof(VirtIOGPURutabaga),
>> >+    =2Eclass_init =3D virtio_gpu_rutabaga_class_init,
>> >+};
>> >+module_obj(TYPE_VIRTIO_GPU_RUTABAGA);
>> >+module_kconfig(VIRTIO_GPU);
>> >+
>> >+static void virtio_register_types(void)
>> >+{
>> >+    type_register_static(&virtio_gpu_rutabaga_info);
>> >+}
>> >+
>> >+type_init(virtio_register_types)
>> >+
>> >+module_dep("hw-display-virtio-gpu");
>> >diff --git a/hw/display/virtio-vga-rutabaga=2Ec
>> b/hw/display/virtio-vga-rutabaga=2Ec
>> >new file mode 100644
>> >index 0000000000=2E=2Eb5b43e3b90
>> >--- /dev/null
>> >+++ b/hw/display/virtio-vga-rutabaga=2Ec
>> >@@ -0,0 +1,53 @@
>> >+/*
>> >+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>> >+ */
>> >+
>> >+#include "qemu/osdep=2Eh"
>> >+#include "hw/pci/pci=2Eh"
>> >+#include "hw/qdev-properties=2Eh"
>> >+#include "hw/virtio/virtio-gpu=2Eh"
>> >+#include "hw/display/vga=2Eh"
>> >+#include "qapi/error=2Eh"
>> >+#include "qemu/module=2Eh"
>> >+#include "virtio-vga=2Eh"
>> >+#include "qom/object=2Eh"
>> >+
>> >+#define TYPE_VIRTIO_VGA_RUTABAGA "virtio-vga-rutabaga"
>> >+
>> >+typedef struct VirtIOVGARutabaga VirtIOVGARutabaga;
>> >+DECLARE_INSTANCE_CHECKER(VirtIOVGARutabaga, VIRTIO_VGA_RUTABAGA,
>> >+                         TYPE_VIRTIO_VGA_RUTABAGA)
>> >+
>> >+struct VirtIOVGARutabaga {
>> >+    VirtIOVGABase parent_obj;
>> >+    VirtIOGPURutabaga vdev;
>> >+};
>> >+
>> >+static void virtio_vga_rutabaga_inst_initfn(Object *obj)
>> >+{
>> >+    VirtIOVGARutabaga *dev =3D VIRTIO_VGA_RUTABAGA(obj);
>> >+
>> >+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
>> >+                                TYPE_VIRTIO_GPU_RUTABAGA);
>> >+    VIRTIO_VGA_BASE(dev)->vgpu =3D VIRTIO_GPU_BASE(&dev->vdev);
>> >+}
>> >+
>> >+static VirtioPCIDeviceTypeInfo virtio_vga_rutabaga_info =3D {
>> >+    =2Egeneric_name  =3D TYPE_VIRTIO_VGA_RUTABAGA,
>> >+    =2Eparent        =3D TYPE_VIRTIO_VGA_BASE,
>> >+    =2Einstance_size =3D sizeof(VirtIOVGARutabaga),
>> >+    =2Einstance_init =3D virtio_vga_rutabaga_inst_initfn,
>> >+};
>> >+module_obj(TYPE_VIRTIO_VGA_RUTABAGA);
>> >+module_kconfig(VIRTIO_VGA);
>> >+
>> >+static void virtio_vga_register_types(void)
>> >+{
>> >+    if (have_vga) {
>> >+        virtio_pci_types_register(&virtio_vga_rutabaga_info);
>> >+    }
>> >+}
>> >+
>> >+type_init(virtio_vga_register_types)
>> >+
>> >+module_dep("hw-display-virtio-vga");
>>

