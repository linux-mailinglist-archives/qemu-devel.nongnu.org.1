Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8696D7A6E5F
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 00:09:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiisq-0003lX-Hr; Tue, 19 Sep 2023 18:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qiiso-0003lP-ID
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 18:07:50 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qiisk-0001NH-9D
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 18:07:50 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c09673b006so46580195ad.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 15:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695161264; x=1695766064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uAZvJDHPKqPVs/utRdbzeBje3BE3eDOY5sCyiIRz6ug=;
 b=EK3UqWcU2MVF1wmJh2qPGYwFp4iKPsUvEqWCuBHF9R84grNgHAF62+VIlO+UK5KOtl
 pgdPun4ZD3F+z9SzL0/YpPfmMyEjfSu0fyrcLAApjlBjTaMkpHt232WNXoEUMA6p1zMf
 gYCCjKYfsm7LM/LFtZreleiZ645/9Fvj892GtBCMjvGnG30AbRk6HegFhosy+YCHa3Qm
 TRtstzxDf9SWYxjUOp6ZGK7EB8tySxu9TrZjuzVEE53FkLIB8YB6czC1LMnKn9zbvZFh
 V+x/eTvsnaKPjkCMBfU3Z6WKHLXuQUB09/R8VUpgTu1B8Uo23kNkN7QAhWZ7+1oufQaL
 Z/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695161264; x=1695766064;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uAZvJDHPKqPVs/utRdbzeBje3BE3eDOY5sCyiIRz6ug=;
 b=TyRAcqjPq/1HN1cU47bWKe/4pG3VAk04O9pS0iNKcdTvdtVVfJE/ebCKRWrB7TSM9k
 6zxTiHXCIM9uiFmbLt4wBJq1XiifkGMpbewFlFnbaelZKH6iF2rQDgxI76KZ1ni4hr2o
 x/UuRedmpU5NppeVYgAZygoCPU7Y1+5wCgdPkjIOy94UTi/VqUidIpRebConfKdh77TS
 Bn2//px0XPUYCd0KCBcOSCVIMotLkRxy3ZYoa3d52n5EJZCypMIT7FCFS5SoWCIZdNZy
 jfWxnjr/Jv0u34db39rjt6KLldm7eKU/OoyKPGqP/aIUBurckUZ3hUgpc0cdiwxcYKAf
 0Iww==
X-Gm-Message-State: AOJu0YzlxyBmWx2aKRXFhcUgygVqVIWAmJDUvrBxX8Dtkuw6rCf+okpP
 OadRntBi2HPvs8HibFByatA=
X-Google-Smtp-Source: AGHT+IHwbdcfLXxoIaf7p4bovyfpW3tLurxqZwUQX7NqSQFr+Nx7AZX5KZjzPY7EDyhIj7vBjwC+ww==
X-Received: by 2002:a17:902:ced2:b0:1bc:5e50:9345 with SMTP id
 d18-20020a170902ced200b001bc5e509345mr789317plg.50.1695161264236; 
 Tue, 19 Sep 2023 15:07:44 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 13-20020a170902ee4d00b001c55db80b14sm4686676plo.221.2023.09.19.15.07.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 15:07:43 -0700 (PDT)
Message-ID: <83364d82-1a1e-4483-aad4-249ce30206a0@gmail.com>
Date: Wed, 20 Sep 2023 07:07:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 6/9] gfxstream + rutabaga: add initial support for
 gfxstream
To: Bernhard Beschow <shentey@gmail.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, ray.huang@amd.com,
 alex.bennee@linaro.org, hi@alyssa.is, ernunes@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20230823012541.485-1-gurchetansingh@chromium.org>
 <20230823012541.485-7-gurchetansingh@chromium.org>
 <B1A4DF8C-3078-48AD-BC8B-F2FD7BA413CF@gmail.com>
 <CAAfnVBk6C7-Vn3buLOh453fz-dRB2vv-4BdkZWjuJDJoWLPAqA@mail.gmail.com>
 <D3C6E21B-E37E-41DA-8131-0C3D9EAF01FD@gmail.com>
 <CAAfnVBngeT8Ezt3osJW2NipFB3r9mJsLXzo1DEo4FtBaZpAO0w@mail.gmail.com>
 <ED6A24A1-42EC-47B2-A5D1-D57135A2D7D6@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <ED6A24A1-42EC-47B2-A5D1-D57135A2D7D6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pl1-x632.google.com
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

On 2023/09/20 3:36, Bernhard Beschow wrote:
> 
> 
> Am 15. September 2023 02:38:02 UTC schrieb Gurchetan Singh <gurchetansingh@chromium.org>:
>> On Thu, Sep 14, 2023 at 12:23 AM Bernhard Beschow <shentey@gmail.com> wrote:
>>
>>>
>>>
>>> Am 14. September 2023 04:38:51 UTC schrieb Gurchetan Singh <
>>> gurchetansingh@chromium.org>:
>>>> On Wed, Sep 13, 2023 at 4:58 AM Bernhard Beschow <shentey@gmail.com>
>>> wrote:
>>>>
>>>>>
>>>>>
>>>>> Am 23. August 2023 01:25:38 UTC schrieb Gurchetan Singh <
>>>>> gurchetansingh@chromium.org>:
>>>>>> This adds initial support for gfxstream and cross-domain.  Both
>>>>>> features rely on virtio-gpu blob resources and context types, which
>>>>>> are also implemented in this patch.
>>>>>>
>>>>>> gfxstream has a long and illustrious history in Android graphics
>>>>>> paravirtualization.  It has been powering graphics in the Android
>>>>>> Studio Emulator for more than a decade, which is the main developer
>>>>>> platform.
>>>>>>
>>>>>> Originally conceived by Jesse Hall, it was first known as "EmuGL" [a].
>>>>>> The key design characteristic was a 1:1 threading model and
>>>>>> auto-generation, which fit nicely with the OpenGLES spec.  It also
>>>>>> allowed easy layering with ANGLE on the host, which provides the GLES
>>>>>> implementations on Windows or MacOS enviroments.
>>>>>>
>>>>>> gfxstream has traditionally been maintained by a single engineer, and
>>>>>> between 2015 to 2021, the goldfish throne passed to Frank Yang.
>>>>>> Historians often remark this glorious reign ("pax gfxstreama" is the
>>>>>> academic term) was comparable to that of Augustus and both Queen
>>>>>> Elizabeths.  Just to name a few accomplishments in a resplendent
>>>>>> panoply: higher versions of GLES, address space graphics, snapshot
>>>>>> support and CTS compliant Vulkan [b].
>>>>>>
>>>>>> One major drawback was the use of out-of-tree goldfish drivers.
>>>>>> Android engineers didn't know much about DRM/KMS and especially TTM so
>>>>>> a simple guest to host pipe was conceived.
>>>>>>
>>>>>> Luckily, virtio-gpu 3D started to emerge in 2016 due to the work of
>>>>>> the Mesa/virglrenderer communities.  In 2018, the initial virtio-gpu
>>>>>> port of gfxstream was done by Cuttlefish enthusiast Alistair Delva.
>>>>>> It was a symbol compatible replacement of virglrenderer [c] and named
>>>>>> "AVDVirglrenderer".  This implementation forms the basis of the
>>>>>> current gfxstream host implementation still in use today.
>>>>>>
>>>>>> cross-domain support follows a similar arc.  Originally conceived by
>>>>>> Wayland aficionado David Reveman and crosvm enjoyer Zach Reizner in
>>>>>> 2018, it initially relied on the downstream "virtio-wl" device.
>>>>>>
>>>>>> In 2020 and 2021, virtio-gpu was extended to include blob resources
>>>>>> and multiple timelines by yours truly, features gfxstream/cross-domain
>>>>>> both require to function correctly.
>>>>>>
>>>>>> Right now, we stand at the precipice of a truly fantastic possibility:
>>>>>> the Android Emulator powered by upstream QEMU and upstream Linux
>>>>>> kernel.  gfxstream will then be packaged properfully, and app
>>>>>> developers can even fix gfxstream bugs on their own if they encounter
>>>>>> them.
>>>>>>
>>>>>> It's been quite the ride, my friends.  Where will gfxstream head next,
>>>>>> nobody really knows.  I wouldn't be surprised if it's around for
>>>>>> another decade, maintained by a new generation of Android graphics
>>>>>> enthusiasts.
>>>>>>
>>>>>> Technical details:
>>>>>>   - Very simple initial display integration: just used Pixman
>>>>>>   - Largely, 1:1 mapping of virtio-gpu hypercalls to rutabaga function
>>>>>>     calls
>>>>>>
>>>>>> Next steps for Android VMs:
>>>>>>   - The next step would be improving display integration and UI
>>> interfaces
>>>>>>     with the goal of the QEMU upstream graphics being in an emulator
>>>>>>     release [d].
>>>>>>
>>>>>> Next steps for Linux VMs for display virtualization:
>>>>>>   - For widespread distribution, someone needs to package Sommelier or
>>> the
>>>>>>     wayland-proxy-virtwl [e] ideally into Debian main. In addition,
>>> newer
>>>>>>     versions of the Linux kernel come with DRM_VIRTIO_GPU_KMS option,
>>>>>>     which allows disabling KMS hypercalls.  If anyone cares enough,
>>> it'll
>>>>>>     probably be possible to build a custom VM variant that uses this
>>>>> display
>>>>>>     virtualization strategy.
>>>>>>
>>>>>> [a]
>>>>> https://android-review.googlesource.com/c/platform/development/+/34470
>>>>>> [b]
>>>>>
>>> https://android-review.googlesource.com/q/topic:%22vulkan-hostconnection-start%22
>>>>>> [c]
>>>>>
>>> https://android-review.googlesource.com/c/device/generic/goldfish-opengl/+/761927
>>>>>> [d] https://developer.android.com/studio/releases/emulator
>>>>>> [e] https://github.com/talex5/wayland-proxy-virtwl
>>>>>>
>>>>>> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
>>>>>> Tested-by: Alyssa Ross <hi@alyssa.is>
>>>>>> Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>>>> Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>>>> ---
>>>>>> v1: Incorported various suggestions by Akihiko Odaki and Bernard
>>> Berschow
>>>>>>     - Removed GET_VIRTIO_GPU_GL / GET_RUTABAGA macros
>>>>>>     - Used error_report(..)
>>>>>>     - Used g_autofree to fix leaks on error paths
>>>>>>     - Removed unnecessary casts
>>>>>>     - added virtio-gpu-pci-rutabaga.c + virtio-vga-rutabaga.c files
>>>>>>
>>>>>> v2: Incorported various suggestions by Akihiko Odaki, Marc-André Lureau
>>>>> and
>>>>>>     Bernard Berschow:
>>>>>>     - Parenthesis in CHECK macro
>>>>>>     - CHECK_RESULT(result, ..) --> CHECK(!result, ..)
>>>>>>     - delay until g->parent_obj.enable = 1
>>>>>>     - Additional cast fixes
>>>>>>     - initialize directly in virtio_gpu_rutabaga_realize(..)
>>>>>>     - add debug callback to hook into QEMU error's APIs
>>>>>>
>>>>>> v3: Incorporated feedback from Akihiko Odaki and Alyssa Ross:
>>>>>>     - Autodetect Wayland socket when not explicitly specified
>>>>>>     - Fix map_blob error paths
>>>>>>     - Add comment why we need both `res` and `resource` in create blob
>>>>>>     - Cast and whitespace fixes
>>>>>>     - Big endian check comes before virtio_gpu_rutabaga_init().
>>>>>>     - VirtIOVGARUTABAGA --> VirtIOVGARutabaga
>>>>>>
>>>>>> v4: Incorporated feedback from Akihiko Odaki and Alyssa Ross:
>>>>>>     - Double checked all casts
>>>>>>     - Remove unnecessary parenthesis
>>>>>>     - Removed `resource` in create_blob
>>>>>>     - Added comment about failure case
>>>>>>     - Pass user-provided socket as-is
>>>>>>     - Use stack variable rather than heap allocation
>>>>>>     - Future-proofed map info API to give access flags as well
>>>>>>
>>>>>> v5: Incorporated feedback from Akihiko Odaki:
>>>>>>     - Check (ss.scanout_id < VIRTIO_GPU_MAX_SCANOUTS)
>>>>>>     - Simplify num_capsets check
>>>>>>     - Call cleanup mapping on error paths
>>>>>>     - uint64_t --> void* for rutabaga_map(..)
>>>>>>     - Removed unnecessary parenthesis
>>>>>>     - Removed unnecessary cast
>>>>>>     - #define UNIX_PATH_MAX sizeof((struct sockaddr_un) {}.sun_path)
>>>>>>     - Reuse result variable
>>>>>>
>>>>>> v6: Incorporated feedback from Akihiko Odaki:
>>>>>>     - Remove unnecessary #ifndef
>>>>>>     - Disable scanout when appropriate
>>>>>>     - CHECK capset index within range outside loop
>>>>>>     - Add capset_version
>>>>>>
>>>>>> v7: Incorporated feedback from Akihiko Odaki:
>>>>>>     - aio_bh_schedule_oneshot_full --> aio_bh_schedule_oneshot
>>>>>>
>>>>>> v9: Incorportated feedback from Akihiko Odaki:
>>>>>>     - Remove extra error_setg(..) after virtio_gpu_rutabaga_init(..)
>>>>>>     - Add error_setg(..) after rutabaga_init(..)
>>>>>>
>>>>>> v10: Incorportated feedback from Akihiko Odaki:
>>>>>>     - error_setg(..) --> error_setg_errno(..) when appropriate
>>>>>>     - virtio_gpu_rutabaga_init returns a bool instead of an int
>>>>>>
>>>>>> v11: Incorportated feedback from Philippe Mathieu-Daudé:
>>>>>>     - C-style /* */ comments and avoid // comments.
>>>>>>     - GPL-2.0 --> GPL-2.0-or-later
>>>>>>
>>>>>> hw/display/virtio-gpu-pci-rutabaga.c |   50 ++
>>>>>> hw/display/virtio-gpu-rutabaga.c     | 1121 ++++++++++++++++++++++++++
>>>>>> hw/display/virtio-vga-rutabaga.c     |   53 ++
>>>>>> 3 files changed, 1224 insertions(+)
>>>>>> create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
>>>>>> create mode 100644 hw/display/virtio-gpu-rutabaga.c
>>>>>> create mode 100644 hw/display/virtio-vga-rutabaga.c
>>>>>>
>>>>>> diff --git a/hw/display/virtio-gpu-pci-rutabaga.c
>>>>> b/hw/display/virtio-gpu-pci-rutabaga.c
>>>>>> new file mode 100644
>>>>>> index 0000000000..311eff308a
>>>>>> --- /dev/null
>>>>>> +++ b/hw/display/virtio-gpu-pci-rutabaga.c
>>>>>> @@ -0,0 +1,50 @@
>>>>>> +/*
>>>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>>>> + */
>>>>>> +
>>>>>> +#include "qemu/osdep.h"
>>>>>> +#include "qapi/error.h"
>>>>>> +#include "qemu/module.h"
>>>>>> +#include "hw/pci/pci.h"
>>>>>> +#include "hw/qdev-properties.h"
>>>>>> +#include "hw/virtio/virtio.h"
>>>>>> +#include "hw/virtio/virtio-bus.h"
>>>>>> +#include "hw/virtio/virtio-gpu-pci.h"
>>>>>> +#include "qom/object.h"
>>>>>> +
>>>>>> +#define TYPE_VIRTIO_GPU_RUTABAGA_PCI "virtio-gpu-rutabaga-pci"
>>>>>> +typedef struct VirtIOGPURutabagaPCI VirtIOGPURutabagaPCI;
>>>>>> +DECLARE_INSTANCE_CHECKER(VirtIOGPURutabagaPCI,
>>> VIRTIO_GPU_RUTABAGA_PCI,
>>>>>> +                         TYPE_VIRTIO_GPU_RUTABAGA_PCI)
>>>>>> +
>>>>>> +struct VirtIOGPURutabagaPCI {
>>>>>> +    VirtIOGPUPCIBase parent_obj;
>>>>>> +    VirtIOGPURutabaga vdev;
>>>>>> +};
>>>>>> +
>>>>>> +static void virtio_gpu_rutabaga_initfn(Object *obj)
>>>>>> +{
>>>>>> +    VirtIOGPURutabagaPCI *dev = VIRTIO_GPU_RUTABAGA_PCI(obj);
>>>>>> +
>>>>>> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
>>>>>> +                                TYPE_VIRTIO_GPU_RUTABAGA);
>>>>>> +    VIRTIO_GPU_PCI_BASE(obj)->vgpu = VIRTIO_GPU_BASE(&dev->vdev);
>>>>>> +}
>>>>>> +
>>>>>> +static const VirtioPCIDeviceTypeInfo virtio_gpu_rutabaga_pci_info = {
>>>>>> +    .generic_name = TYPE_VIRTIO_GPU_RUTABAGA_PCI,
>>>>>> +    .parent = TYPE_VIRTIO_GPU_PCI_BASE,
>>>>>> +    .instance_size = sizeof(VirtIOGPURutabagaPCI),
>>>>>> +    .instance_init = virtio_gpu_rutabaga_initfn,
>>>>>> +};
>>>>>> +module_obj(TYPE_VIRTIO_GPU_RUTABAGA_PCI);
>>>>>> +module_kconfig(VIRTIO_PCI);
>>>>>> +
>>>>>> +static void virtio_gpu_rutabaga_pci_register_types(void)
>>>>>> +{
>>>>>> +    virtio_pci_types_register(&virtio_gpu_rutabaga_pci_info);
>>>>>> +}
>>>>>> +
>>>>>> +type_init(virtio_gpu_rutabaga_pci_register_types)
>>>>>> +
>>>>>> +module_dep("hw-display-virtio-gpu-pci");
>>>>>> diff --git a/hw/display/virtio-gpu-rutabaga.c
>>>>> b/hw/display/virtio-gpu-rutabaga.c
>>>>>> new file mode 100644
>>>>>> index 0000000000..9018e5a702
>>>>>> --- /dev/null
>>>>>> +++ b/hw/display/virtio-gpu-rutabaga.c
>>>>>> @@ -0,0 +1,1121 @@
>>>>>> +/*
>>>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>>>> + */
>>>>>> +
>>>>>> +#include "qemu/osdep.h"
>>>>>> +#include "qapi/error.h"
>>>>>> +#include "qemu/error-report.h"
>>>>>> +#include "qemu/iov.h"
>>>>>> +#include "trace.h"
>>>>>> +#include "hw/virtio/virtio.h"
>>>>>> +#include "hw/virtio/virtio-gpu.h"
>>>>>> +#include "hw/virtio/virtio-gpu-pixman.h"
>>>>>> +#include "hw/virtio/virtio-iommu.h"
>>>>>> +
>>>>>> +#include <glib/gmem.h>
>>>>>> +#include <rutabaga_gfx/rutabaga_gfx_ffi.h>
>>>>>> +
>>>>>> +#define CHECK(condition, cmd)
>>>>>       \
>>>>>> +    do {
>>>>>        \
>>>>>> +        if (!(condition)) {
>>>>>       \
>>>>>> +            error_report("CHECK failed in %s() %s:" "%d", __func__,
>>>>>       \
>>>>>> +                         __FILE__, __LINE__);
>>>>>       \
>>>>>> +            (cmd)->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>>>>        \
>>>>>> +            return;
>>>>>       \
>>>>>> +       }
>>>>>        \
>>>>>> +    } while (0)
>>>>>> +
>>>>>> +/*
>>>>>> + * This is the size of the char array in struct sock_addr_un. No
>>> Wayland
>>>>> socket
>>>>>> + * can be created with a path longer than this, including the null
>>>>> terminator.
>>>>>> + */
>>>>>> +#define UNIX_PATH_MAX sizeof((struct sockaddr_un) {} .sun_path)
>>>>>> +
>>>>>> +struct rutabaga_aio_data {
>>>>>> +    struct VirtIOGPURutabaga *vr;
>>>>>> +    struct rutabaga_fence fence;
>>>>>> +};
>>>>>> +
>>>>>> +static void
>>>>>> +virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, struct
>>>>> virtio_gpu_scanout *s,
>>>>>> +                                  uint32_t resource_id)
>>>>>> +{
>>>>>> +    struct virtio_gpu_simple_resource *res;
>>>>>> +    struct rutabaga_transfer transfer = { 0 };
>>>>>> +    struct iovec transfer_iovec;
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    res = virtio_gpu_find_resource(g, resource_id);
>>>>>> +    if (!res) {
>>>>>> +        return;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (res->width != s->current_cursor->width ||
>>>>>> +        res->height != s->current_cursor->height) {
>>>>>> +        return;
>>>>>> +    }
>>>>>> +
>>>>>> +    transfer.x = 0;
>>>>>> +    transfer.y = 0;
>>>>>> +    transfer.z = 0;
>>>>>> +    transfer.w = res->width;
>>>>>> +    transfer.h = res->height;
>>>>>> +    transfer.d = 1;
>>>>>> +
>>>>>> +    transfer_iovec.iov_base = s->current_cursor->data;
>>>>>> +    transfer_iovec.iov_len = res->width * res->height * 4;
>>>>>> +
>>>>>> +    rutabaga_resource_transfer_read(vr->rutabaga, 0,
>>>>>> +                                    resource_id, &transfer,
>>>>>> +                                    &transfer_iovec);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +virtio_gpu_rutabaga_gl_flushed(VirtIOGPUBase *b)
>>>>>> +{
>>>>>> +    VirtIOGPU *g = VIRTIO_GPU(b);
>>>>>> +    virtio_gpu_process_cmdq(g);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +rutabaga_cmd_create_resource_2d(VirtIOGPU *g,
>>>>>> +                                struct virtio_gpu_ctrl_command *cmd)
>>>>>> +{
>>>>>> +    int32_t result;
>>>>>> +    struct rutabaga_create_3d rc_3d = { 0 };
>>>>>> +    struct virtio_gpu_simple_resource *res;
>>>>>> +    struct virtio_gpu_resource_create_2d c2d;
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(c2d);
>>>>>> +    trace_virtio_gpu_cmd_res_create_2d(c2d.resource_id, c2d.format,
>>>>>> +                                       c2d.width, c2d.height);
>>>>>> +
>>>>>> +    rc_3d.target = 2;
>>>>>> +    rc_3d.format = c2d.format;
>>>>>> +    rc_3d.bind = (1 << 1);
>>>>>> +    rc_3d.width = c2d.width;
>>>>>> +    rc_3d.height = c2d.height;
>>>>>> +    rc_3d.depth = 1;
>>>>>> +    rc_3d.array_size = 1;
>>>>>> +    rc_3d.last_level = 0;
>>>>>> +    rc_3d.nr_samples = 0;
>>>>>> +    rc_3d.flags = VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
>>>>>> +
>>>>>> +    result = rutabaga_resource_create_3d(vr->rutabaga,
>>> c2d.resource_id,
>>>>> &rc_3d);
>>>>>> +    CHECK(!result, cmd);
>>>>>> +
>>>>>> +    res = g_new0(struct virtio_gpu_simple_resource, 1);
>>>>>> +    res->width = c2d.width;
>>>>>> +    res->height = c2d.height;
>>>>>> +    res->format = c2d.format;
>>>>>> +    res->resource_id = c2d.resource_id;
>>>>>> +
>>>>>> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
>>>>>> +                                struct virtio_gpu_ctrl_command *cmd)
>>>>>> +{
>>>>>> +    int32_t result;
>>>>>> +    struct rutabaga_create_3d rc_3d = { 0 };
>>>>>> +    struct virtio_gpu_simple_resource *res;
>>>>>> +    struct virtio_gpu_resource_create_3d c3d;
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(c3d);
>>>>>> +
>>>>>> +    trace_virtio_gpu_cmd_res_create_3d(c3d.resource_id, c3d.format,
>>>>>> +                                       c3d.width, c3d.height,
>>> c3d.depth);
>>>>>> +
>>>>>> +    rc_3d.target = c3d.target;
>>>>>> +    rc_3d.format = c3d.format;
>>>>>> +    rc_3d.bind = c3d.bind;
>>>>>> +    rc_3d.width = c3d.width;
>>>>>> +    rc_3d.height = c3d.height;
>>>>>> +    rc_3d.depth = c3d.depth;
>>>>>> +    rc_3d.array_size = c3d.array_size;
>>>>>> +    rc_3d.last_level = c3d.last_level;
>>>>>> +    rc_3d.nr_samples = c3d.nr_samples;
>>>>>> +    rc_3d.flags = c3d.flags;
>>>>>> +
>>>>>> +    result = rutabaga_resource_create_3d(vr->rutabaga,
>>> c3d.resource_id,
>>>>> &rc_3d);
>>>>>> +    CHECK(!result, cmd);
>>>>>> +
>>>>>> +    res = g_new0(struct virtio_gpu_simple_resource, 1);
>>>>>> +    res->width = c3d.width;
>>>>>> +    res->height = c3d.height;
>>>>>> +    res->format = c3d.format;
>>>>>> +    res->resource_id = c3d.resource_id;
>>>>>> +
>>>>>> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +rutabaga_cmd_resource_unref(VirtIOGPU *g,
>>>>>> +                            struct virtio_gpu_ctrl_command *cmd)
>>>>>> +{
>>>>>> +    int32_t result;
>>>>>> +    struct virtio_gpu_simple_resource *res;
>>>>>> +    struct virtio_gpu_resource_unref unref;
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(unref);
>>>>>> +
>>>>>> +    trace_virtio_gpu_cmd_res_unref(unref.resource_id);
>>>>>> +
>>>>>> +    res = virtio_gpu_find_resource(g, unref.resource_id);
>>>>>> +    CHECK(res, cmd);
>>>>>> +
>>>>>> +    result = rutabaga_resource_unref(vr->rutabaga, unref.resource_id);
>>>>>> +    CHECK(!result, cmd);
>>>>>> +
>>>>>> +    if (res->image) {
>>>>>> +        pixman_image_unref(res->image);
>>>>>> +    }
>>>>>> +
>>>>>> +    QTAILQ_REMOVE(&g->reslist, res, next);
>>>>>> +    g_free(res);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +rutabaga_cmd_context_create(VirtIOGPU *g,
>>>>>> +                            struct virtio_gpu_ctrl_command *cmd)
>>>>>> +{
>>>>>> +    int32_t result;
>>>>>> +    struct virtio_gpu_ctx_create cc;
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(cc);
>>>>>> +    trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,
>>>>>> +                                    cc.debug_name);
>>>>>> +
>>>>>> +    result = rutabaga_context_create(vr->rutabaga, cc.hdr.ctx_id,
>>>>>> +                                     cc.context_init, cc.debug_name,
>>>>> cc.nlen);
>>>>>> +    CHECK(!result, cmd);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +rutabaga_cmd_context_destroy(VirtIOGPU *g,
>>>>>> +                             struct virtio_gpu_ctrl_command *cmd)
>>>>>> +{
>>>>>> +    int32_t result;
>>>>>> +    struct virtio_gpu_ctx_destroy cd;
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(cd);
>>>>>> +    trace_virtio_gpu_cmd_ctx_destroy(cd.hdr.ctx_id);
>>>>>> +
>>>>>> +    result = rutabaga_context_destroy(vr->rutabaga, cd.hdr.ctx_id);
>>>>>> +    CHECK(!result, cmd);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +rutabaga_cmd_resource_flush(VirtIOGPU *g, struct
>>> virtio_gpu_ctrl_command
>>>>> *cmd)
>>>>>> +{
>>>>>> +    int32_t result, i;
>>>>>> +    struct virtio_gpu_scanout *scanout = NULL;
>>>>>> +    struct virtio_gpu_simple_resource *res;
>>>>>> +    struct rutabaga_transfer transfer = { 0 };
>>>>>> +    struct iovec transfer_iovec;
>>>>>> +    struct virtio_gpu_resource_flush rf;
>>>>>> +    bool found = false;
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +    if (vr->headless) {
>>>>>> +        return;
>>>>>> +    }
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(rf);
>>>>>> +    trace_virtio_gpu_cmd_res_flush(rf.resource_id,
>>>>>> +                                   rf.r.width, rf.r.height, rf.r.x,
>>>>> rf.r.y);
>>>>>> +
>>>>>> +    res = virtio_gpu_find_resource(g, rf.resource_id);
>>>>>> +    CHECK(res, cmd);
>>>>>> +
>>>>>> +    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
>>>>>> +        scanout = &g->parent_obj.scanout[i];
>>>>>> +        if (i == res->scanout_bitmask) {
>>>>>> +            found = true;
>>>>>> +            break;
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +    if (!found) {
>>>>>> +        return;
>>>>>> +    }
>>>>>> +
>>>>>> +    transfer.x = 0;
>>>>>> +    transfer.y = 0;
>>>>>> +    transfer.z = 0;
>>>>>> +    transfer.w = res->width;
>>>>>> +    transfer.h = res->height;
>>>>>> +    transfer.d = 1;
>>>>>> +
>>>>>> +    transfer_iovec.iov_base = pixman_image_get_data(res->image);
>>>>>> +    transfer_iovec.iov_len = res->width * res->height * 4;
>>>>>> +
>>>>>> +    result = rutabaga_resource_transfer_read(vr->rutabaga, 0,
>>>>>> +                                             rf.resource_id,
>>> &transfer,
>>>>>> +                                             &transfer_iovec);
>>>>>> +    CHECK(!result, cmd);
>>>>>> +    dpy_gfx_update_full(scanout->con);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command
>>>>> *cmd)
>>>>>> +{
>>>>>> +    struct virtio_gpu_simple_resource *res;
>>>>>> +    struct virtio_gpu_scanout *scanout = NULL;
>>>>>> +    struct virtio_gpu_set_scanout ss;
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +    if (vr->headless) {
>>>>>> +        return;
>>>>>> +    }
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(ss);
>>>>>> +    trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_id,
>>>>>> +                                     ss.r.width, ss.r.height, ss.r.x,
>>>>> ss.r.y);
>>>>>> +
>>>>>> +    CHECK(ss.scanout_id < VIRTIO_GPU_MAX_SCANOUTS, cmd);
>>>>>> +    scanout = &g->parent_obj.scanout[ss.scanout_id];
>>>>>> +
>>>>>> +    if (ss.resource_id == 0) {
>>>>>> +        dpy_gfx_replace_surface(scanout->con, NULL);
>>>>>> +        dpy_gl_scanout_disable(scanout->con);
>>>>>> +        return;
>>>>>> +    }
>>>>>> +
>>>>>> +    res = virtio_gpu_find_resource(g, ss.resource_id);
>>>>>> +    CHECK(res, cmd);
>>>>>> +
>>>>>> +    if (!res->image) {
>>>>>> +        pixman_format_code_t pformat;
>>>>>> +        pformat = virtio_gpu_get_pixman_format(res->format);
>>>>>> +        CHECK(pformat, cmd);
>>>>>> +
>>>>>> +        res->image = pixman_image_create_bits(pformat,
>>>>>> +                                              res->width,
>>>>>> +                                              res->height,
>>>>>> +                                              NULL, 0);
>>>>>> +        CHECK(res->image, cmd);
>>>>>> +        pixman_image_ref(res->image);
>>>>>> +    }
>>>>>> +
>>>>>> +    g->parent_obj.enable = 1;
>>>>>> +
>>>>>> +    /* realloc the surface ptr */
>>>>>> +    scanout->ds = qemu_create_displaysurface_pixman(res->image);
>>>>>> +    dpy_gfx_replace_surface(scanout->con, NULL);
>>>>>> +    dpy_gfx_replace_surface(scanout->con, scanout->ds);
>>>>>> +    res->scanout_bitmask = ss.scanout_id;
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +rutabaga_cmd_submit_3d(VirtIOGPU *g,
>>>>>> +                       struct virtio_gpu_ctrl_command *cmd)
>>>>>> +{
>>>>>> +    int32_t result;
>>>>>> +    struct virtio_gpu_cmd_submit cs;
>>>>>> +    struct rutabaga_command rutabaga_cmd = { 0 };
>>>>>> +    g_autofree uint8_t *buf = NULL;
>>>>>> +    size_t s;
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(cs);
>>>>>> +    trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size);
>>>>>> +
>>>>>> +    buf = g_new0(uint8_t, cs.size);
>>>>>> +    s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>>>>>> +                   sizeof(cs), buf, cs.size);
>>>>>> +    CHECK(s == cs.size, cmd);
>>>>>> +
>>>>>> +    rutabaga_cmd.ctx_id = cs.hdr.ctx_id;
>>>>>> +    rutabaga_cmd.cmd = buf;
>>>>>> +    rutabaga_cmd.cmd_size = cs.size;
>>>>>> +
>>>>>> +    result = rutabaga_submit_command(vr->rutabaga, &rutabaga_cmd);
>>>>>> +    CHECK(!result, cmd);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +rutabaga_cmd_transfer_to_host_2d(VirtIOGPU *g,
>>>>>> +                                 struct virtio_gpu_ctrl_command *cmd)
>>>>>> +{
>>>>>> +    int32_t result;
>>>>>> +    struct rutabaga_transfer transfer = { 0 };
>>>>>> +    struct virtio_gpu_transfer_to_host_2d t2d;
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(t2d);
>>>>>> +    trace_virtio_gpu_cmd_res_xfer_toh_2d(t2d.resource_id);
>>>>>> +
>>>>>> +    transfer.x = t2d.r.x;
>>>>>> +    transfer.y = t2d.r.y;
>>>>>> +    transfer.z = 0;
>>>>>> +    transfer.w = t2d.r.width;
>>>>>> +    transfer.h = t2d.r.height;
>>>>>> +    transfer.d = 1;
>>>>>> +
>>>>>> +    result = rutabaga_resource_transfer_write(vr->rutabaga, 0,
>>>>> t2d.resource_id,
>>>>>> +                                              &transfer);
>>>>>> +    CHECK(!result, cmd);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +rutabaga_cmd_transfer_to_host_3d(VirtIOGPU *g,
>>>>>> +                                 struct virtio_gpu_ctrl_command *cmd)
>>>>>> +{
>>>>>> +    int32_t result;
>>>>>> +    struct rutabaga_transfer transfer = { 0 };
>>>>>> +    struct virtio_gpu_transfer_host_3d t3d;
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(t3d);
>>>>>> +    trace_virtio_gpu_cmd_res_xfer_toh_3d(t3d.resource_id);
>>>>>> +
>>>>>> +    transfer.x = t3d.box.x;
>>>>>> +    transfer.y = t3d.box.y;
>>>>>> +    transfer.z = t3d.box.z;
>>>>>> +    transfer.w = t3d.box.w;
>>>>>> +    transfer.h = t3d.box.h;
>>>>>> +    transfer.d = t3d.box.d;
>>>>>> +    transfer.level = t3d.level;
>>>>>> +    transfer.stride = t3d.stride;
>>>>>> +    transfer.layer_stride = t3d.layer_stride;
>>>>>> +    transfer.offset = t3d.offset;
>>>>>> +
>>>>>> +    result = rutabaga_resource_transfer_write(vr->rutabaga,
>>>>> t3d.hdr.ctx_id,
>>>>>> +                                              t3d.resource_id,
>>>>> &transfer);
>>>>>> +    CHECK(!result, cmd);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +rutabaga_cmd_transfer_from_host_3d(VirtIOGPU *g,
>>>>>> +                                   struct virtio_gpu_ctrl_command
>>> *cmd)
>>>>>> +{
>>>>>> +    int32_t result;
>>>>>> +    struct rutabaga_transfer transfer = { 0 };
>>>>>> +    struct virtio_gpu_transfer_host_3d t3d;
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(t3d);
>>>>>> +    trace_virtio_gpu_cmd_res_xfer_fromh_3d(t3d.resource_id);
>>>>>> +
>>>>>> +    transfer.x = t3d.box.x;
>>>>>> +    transfer.y = t3d.box.y;
>>>>>> +    transfer.z = t3d.box.z;
>>>>>> +    transfer.w = t3d.box.w;
>>>>>> +    transfer.h = t3d.box.h;
>>>>>> +    transfer.d = t3d.box.d;
>>>>>> +    transfer.level = t3d.level;
>>>>>> +    transfer.stride = t3d.stride;
>>>>>> +    transfer.layer_stride = t3d.layer_stride;
>>>>>> +    transfer.offset = t3d.offset;
>>>>>> +
>>>>>> +    result = rutabaga_resource_transfer_read(vr->rutabaga,
>>>>> t3d.hdr.ctx_id,
>>>>>> +                                             t3d.resource_id,
>>> &transfer,
>>>>> NULL);
>>>>>> +    CHECK(!result, cmd);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +rutabaga_cmd_attach_backing(VirtIOGPU *g, struct
>>> virtio_gpu_ctrl_command
>>>>> *cmd)
>>>>>> +{
>>>>>> +    struct rutabaga_iovecs vecs = { 0 };
>>>>>> +    struct virtio_gpu_simple_resource *res;
>>>>>> +    struct virtio_gpu_resource_attach_backing att_rb;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(att_rb);
>>>>>> +    trace_virtio_gpu_cmd_res_back_attach(att_rb.resource_id);
>>>>>> +
>>>>>> +    res = virtio_gpu_find_resource(g, att_rb.resource_id);
>>>>>> +    CHECK(res, cmd);
>>>>>> +    CHECK(!res->iov, cmd);
>>>>>> +
>>>>>> +    ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries,
>>>>> sizeof(att_rb),
>>>>>> +                                        cmd, NULL, &res->iov,
>>>>> &res->iov_cnt);
>>>>>> +    CHECK(!ret, cmd);
>>>>>> +
>>>>>> +    vecs.iovecs = res->iov;
>>>>>> +    vecs.num_iovecs = res->iov_cnt;
>>>>>> +
>>>>>> +    ret = rutabaga_resource_attach_backing(vr->rutabaga,
>>>>> att_rb.resource_id,
>>>>>> +                                           &vecs);
>>>>>> +    if (ret != 0) {
>>>>>> +        virtio_gpu_cleanup_mapping(g, res);
>>>>>> +    }
>>>>>> +
>>>>>> +    CHECK(!ret, cmd);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +rutabaga_cmd_detach_backing(VirtIOGPU *g, struct
>>> virtio_gpu_ctrl_command
>>>>> *cmd)
>>>>>> +{
>>>>>> +    struct virtio_gpu_simple_resource *res;
>>>>>> +    struct virtio_gpu_resource_detach_backing detach_rb;
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(detach_rb);
>>>>>> +    trace_virtio_gpu_cmd_res_back_detach(detach_rb.resource_id);
>>>>>> +
>>>>>> +    res = virtio_gpu_find_resource(g, detach_rb.resource_id);
>>>>>> +    CHECK(res, cmd);
>>>>>> +
>>>>>> +    rutabaga_resource_detach_backing(vr->rutabaga,
>>>>>> +                                     detach_rb.resource_id);
>>>>>> +
>>>>>> +    virtio_gpu_cleanup_mapping(g, res);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +rutabaga_cmd_ctx_attach_resource(VirtIOGPU *g,
>>>>>> +                                 struct virtio_gpu_ctrl_command *cmd)
>>>>>> +{
>>>>>> +    int32_t result;
>>>>>> +    struct virtio_gpu_ctx_resource att_res;
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(att_res);
>>>>>> +    trace_virtio_gpu_cmd_ctx_res_attach(att_res.hdr.ctx_id,
>>>>>> +                                        att_res.resource_id);
>>>>>> +
>>>>>> +    result = rutabaga_context_attach_resource(vr->rutabaga,
>>>>> att_res.hdr.ctx_id,
>>>>>> +                                              att_res.resource_id);
>>>>>> +    CHECK(!result, cmd);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +rutabaga_cmd_ctx_detach_resource(VirtIOGPU *g,
>>>>>> +                                 struct virtio_gpu_ctrl_command *cmd)
>>>>>> +{
>>>>>> +    int32_t result;
>>>>>> +    struct virtio_gpu_ctx_resource det_res;
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(det_res);
>>>>>> +    trace_virtio_gpu_cmd_ctx_res_detach(det_res.hdr.ctx_id,
>>>>>> +                                        det_res.resource_id);
>>>>>> +
>>>>>> +    result = rutabaga_context_detach_resource(vr->rutabaga,
>>>>> det_res.hdr.ctx_id,
>>>>>> +                                              det_res.resource_id);
>>>>>> +    CHECK(!result, cmd);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct
>>>>> virtio_gpu_ctrl_command *cmd)
>>>>>> +{
>>>>>> +    int32_t result;
>>>>>> +    struct virtio_gpu_get_capset_info info;
>>>>>> +    struct virtio_gpu_resp_capset_info resp;
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(info);
>>>>>> +
>>>>>> +    result = rutabaga_get_capset_info(vr->rutabaga, info.capset_index,
>>>>>> +                                      &resp.capset_id,
>>>>> &resp.capset_max_version,
>>>>>> +                                      &resp.capset_max_size);
>>>>>> +    CHECK(!result, cmd);
>>>>>> +
>>>>>> +    resp.hdr.type = VIRTIO_GPU_RESP_OK_CAPSET_INFO;
>>>>>> +    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +rutabaga_cmd_get_capset(VirtIOGPU *g, struct virtio_gpu_ctrl_command
>>>>> *cmd)
>>>>>> +{
>>>>>> +    int32_t result;
>>>>>> +    struct virtio_gpu_get_capset gc;
>>>>>> +    struct virtio_gpu_resp_capset *resp;
>>>>>> +    uint32_t capset_size, capset_version;
>>>>>> +    uint32_t current_id, i;
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(gc);
>>>>>> +    for (i = 0; i < vr->num_capsets; i++) {
>>>>>> +        result = rutabaga_get_capset_info(vr->rutabaga, i,
>>>>>> +                                          &current_id,
>>> &capset_version,
>>>>>> +                                          &capset_size);
>>>>>> +        CHECK(!result, cmd);
>>>>>> +
>>>>>> +        if (current_id == gc.capset_id) {
>>>>>> +            break;
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +    CHECK(i < vr->num_capsets, cmd);
>>>>>> +
>>>>>> +    resp = g_malloc0(sizeof(*resp) + capset_size);
>>>>>> +    resp->hdr.type = VIRTIO_GPU_RESP_OK_CAPSET;
>>>>>> +    rutabaga_get_capset(vr->rutabaga, gc.capset_id, gc.capset_version,
>>>>>> +                        resp->capset_data, capset_size);
>>>>>> +
>>>>>> +    virtio_gpu_ctrl_response(g, cmd, &resp->hdr, sizeof(*resp) +
>>>>> capset_size);
>>>>>> +    g_free(resp);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
>>>>>> +                                  struct virtio_gpu_ctrl_command *cmd)
>>>>>> +{
>>>>>> +    int result;
>>>>>> +    struct rutabaga_iovecs vecs = { 0 };
>>>>>> +    g_autofree struct virtio_gpu_simple_resource *res = NULL;
>>>>>> +    struct virtio_gpu_resource_create_blob cblob;
>>>>>> +    struct rutabaga_create_blob rc_blob = { 0 };
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(cblob);
>>>>>> +    trace_virtio_gpu_cmd_res_create_blob(cblob.resource_id,
>>> cblob.size);
>>>>>> +
>>>>>> +    CHECK(cblob.resource_id != 0, cmd);
>>>>>> +
>>>>>> +    res = g_new0(struct virtio_gpu_simple_resource, 1);
>>>>>> +
>>>>>> +    res->resource_id = cblob.resource_id;
>>>>>> +    res->blob_size = cblob.size;
>>>>>> +
>>>>>> +    if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
>>>>>> +        result = virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
>>>>>> +                                               sizeof(cblob), cmd,
>>>>> &res->addrs,
>>>>>> +                                               &res->iov,
>>> &res->iov_cnt);
>>>>>> +        CHECK(!result, cmd);
>>>>>> +    }
>>>>>> +
>>>>>> +    rc_blob.blob_id = cblob.blob_id;
>>>>>> +    rc_blob.blob_mem = cblob.blob_mem;
>>>>>> +    rc_blob.blob_flags = cblob.blob_flags;
>>>>>> +    rc_blob.size = cblob.size;
>>>>>> +
>>>>>> +    vecs.iovecs = res->iov;
>>>>>> +    vecs.num_iovecs = res->iov_cnt;
>>>>>> +
>>>>>> +    result = rutabaga_resource_create_blob(vr->rutabaga,
>>>>> cblob.hdr.ctx_id,
>>>>>> +                                           cblob.resource_id,
>>> &rc_blob,
>>>>> &vecs,
>>>>>> +                                           NULL);
>>>>>> +
>>>>>> +    if (result && cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
>>>>>> +        virtio_gpu_cleanup_mapping(g, res);
>>>>>> +    }
>>>>>> +
>>>>>> +    CHECK(!result, cmd);
>>>>>> +
>>>>>> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>>>>>> +    res = NULL;
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +rutabaga_cmd_resource_map_blob(VirtIOGPU *g,
>>>>>> +                               struct virtio_gpu_ctrl_command *cmd)
>>>>>> +{
>>>>>> +    int32_t result;
>>>>>> +    uint32_t map_info = 0;
>>>>>> +    uint32_t slot = 0;
>>>>>> +    struct virtio_gpu_simple_resource *res;
>>>>>> +    struct rutabaga_mapping mapping = { 0 };
>>>>>> +    struct virtio_gpu_resource_map_blob mblob;
>>>>>> +    struct virtio_gpu_resp_map_info resp = { 0 };
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(mblob);
>>>>>> +
>>>>>> +    CHECK(mblob.resource_id != 0, cmd);
>>>>>> +
>>>>>> +    res = virtio_gpu_find_resource(g, mblob.resource_id);
>>>>>> +    CHECK(res, cmd);
>>>>>> +
>>>>>> +    result = rutabaga_resource_map_info(vr->rutabaga,
>>> mblob.resource_id,
>>>>>> +                                        &map_info);
>>>>>> +    CHECK(!result, cmd);
>>>>>> +
>>>>>> +    /*
>>>>>> +     * RUTABAGA_MAP_ACCESS_* flags are not part of the virtio-gpu
>>> spec,
>>>>> but do
>>>>>> +     * exist to potentially allow the hypervisor to restrict write
>>>>> access to
>>>>>> +     * memory. QEMU does not need to use this functionality at the
>>>>> moment.
>>>>>> +     */
>>>>>> +    resp.map_info = map_info & RUTABAGA_MAP_CACHE_MASK;
>>>>>> +
>>>>>> +    result = rutabaga_resource_map(vr->rutabaga, mblob.resource_id,
>>>>> &mapping);
>>>>>> +    CHECK(!result, cmd);
>>>>>> +
>>>>>> +    for (slot = 0; slot < MAX_SLOTS; slot++) {
>>>>>> +        if (vr->memory_regions[slot].used) {
>>>>>> +            continue;
>>>>>> +        }
>>>>>> +
>>>>>> +        MemoryRegion *mr = &(vr->memory_regions[slot].mr);
>>>>>> +        memory_region_init_ram_ptr(mr, NULL, "blob", mapping.size,
>>>>>> +                                   mapping.ptr);
>>>>>> +        memory_region_add_subregion(&g->parent_obj.hostmem,
>>>>>> +                                    mblob.offset, mr);
>>>>>> +        vr->memory_regions[slot].resource_id = mblob.resource_id;
>>>>>> +        vr->memory_regions[slot].used = 1;
>>>>>> +        break;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (slot >= MAX_SLOTS) {
>>>>>> +        result = rutabaga_resource_unmap(vr->rutabaga,
>>>>> mblob.resource_id);
>>>>>> +        CHECK(!result, cmd);
>>>>>> +    }
>>>>>> +
>>>>>> +    CHECK(slot < MAX_SLOTS, cmd);
>>>>>> +
>>>>>> +    resp.hdr.type = VIRTIO_GPU_RESP_OK_MAP_INFO;
>>>>>> +    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +rutabaga_cmd_resource_unmap_blob(VirtIOGPU *g,
>>>>>> +                                 struct virtio_gpu_ctrl_command *cmd)
>>>>>> +{
>>>>>> +    int32_t result;
>>>>>> +    uint32_t slot = 0;
>>>>>> +    struct virtio_gpu_simple_resource *res;
>>>>>> +    struct virtio_gpu_resource_unmap_blob ublob;
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(ublob);
>>>>>> +
>>>>>> +    CHECK(ublob.resource_id != 0, cmd);
>>>>>> +
>>>>>> +    res = virtio_gpu_find_resource(g, ublob.resource_id);
>>>>>> +    CHECK(res, cmd);
>>>>>> +
>>>>>> +    for (slot = 0; slot < MAX_SLOTS; slot++) {
>>>>>> +        if (vr->memory_regions[slot].resource_id !=
>>> ublob.resource_id) {
>>>>>> +            continue;
>>>>>> +        }
>>>>>> +
>>>>>> +        MemoryRegion *mr = &(vr->memory_regions[slot].mr);
>>>>>> +        memory_region_del_subregion(&g->parent_obj.hostmem, mr);
>>>>>> +
>>>>>> +        vr->memory_regions[slot].resource_id = 0;
>>>>>> +        vr->memory_regions[slot].used = 0;
>>>>>> +        break;
>>>>>> +    }
>>>>>> +
>>>>>> +    CHECK(slot < MAX_SLOTS, cmd);
>>>>>> +    result = rutabaga_resource_unmap(vr->rutabaga, res->resource_id);
>>>>>> +    CHECK(!result, cmd);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +virtio_gpu_rutabaga_process_cmd(VirtIOGPU *g,
>>>>>> +                                struct virtio_gpu_ctrl_command *cmd)
>>>>>> +{
>>>>>> +    struct rutabaga_fence fence = { 0 };
>>>>>> +    int32_t result;
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
>>>>>> +
>>>>>> +    switch (cmd->cmd_hdr.type) {
>>>>>> +    case VIRTIO_GPU_CMD_CTX_CREATE:
>>>>>> +        rutabaga_cmd_context_create(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_CTX_DESTROY:
>>>>>> +        rutabaga_cmd_context_destroy(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_2D:
>>>>>> +        rutabaga_cmd_create_resource_2d(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_3D:
>>>>>> +        rutabaga_cmd_create_resource_3d(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_SUBMIT_3D:
>>>>>> +        rutabaga_cmd_submit_3d(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D:
>>>>>> +        rutabaga_cmd_transfer_to_host_2d(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D:
>>>>>> +        rutabaga_cmd_transfer_to_host_3d(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D:
>>>>>> +        rutabaga_cmd_transfer_from_host_3d(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING:
>>>>>> +        rutabaga_cmd_attach_backing(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:
>>>>>> +        rutabaga_cmd_detach_backing(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_SET_SCANOUT:
>>>>>> +        rutabaga_cmd_set_scanout(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_FLUSH:
>>>>>> +        rutabaga_cmd_resource_flush(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_UNREF:
>>>>>> +        rutabaga_cmd_resource_unref(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:
>>>>>> +        rutabaga_cmd_ctx_attach_resource(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE:
>>>>>> +        rutabaga_cmd_ctx_detach_resource(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_GET_CAPSET_INFO:
>>>>>> +        rutabaga_cmd_get_capset_info(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_GET_CAPSET:
>>>>>> +        rutabaga_cmd_get_capset(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:
>>>>>> +        virtio_gpu_get_display_info(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_GET_EDID:
>>>>>> +        virtio_gpu_get_edid(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB:
>>>>>> +        rutabaga_cmd_resource_create_blob(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB:
>>>>>> +        rutabaga_cmd_resource_map_blob(g, cmd);
>>>>>> +        break;
>>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:
>>>>>> +        rutabaga_cmd_resource_unmap_blob(g, cmd);
>>>>>> +        break;
>>>>>> +    default:
>>>>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>>>>> +        break;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (cmd->finished) {
>>>>>> +        return;
>>>>>> +    }
>>>>>> +    if (cmd->error) {
>>>>>> +        error_report("%s: ctrl 0x%x, error 0x%x", __func__,
>>>>>> +                     cmd->cmd_hdr.type, cmd->error);
>>>>>> +        virtio_gpu_ctrl_response_nodata(g, cmd, cmd->error);
>>>>>> +        return;
>>>>>> +    }
>>>>>> +    if (!(cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE)) {
>>>>>> +        virtio_gpu_ctrl_response_nodata(g, cmd,
>>>>> VIRTIO_GPU_RESP_OK_NODATA);
>>>>>> +        return;
>>>>>> +    }
>>>>>> +
>>>>>> +    fence.flags = cmd->cmd_hdr.flags;
>>>>>> +    fence.ctx_id = cmd->cmd_hdr.ctx_id;
>>>>>> +    fence.fence_id = cmd->cmd_hdr.fence_id;
>>>>>> +    fence.ring_idx = cmd->cmd_hdr.ring_idx;
>>>>>> +
>>>>>> +    trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id,
>>>>> cmd->cmd_hdr.type);
>>>>>> +
>>>>>> +    result = rutabaga_create_fence(vr->rutabaga, &fence);
>>>>>> +    CHECK(!result, cmd);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +virtio_gpu_rutabaga_aio_cb(void *opaque)
>>>>>> +{
>>>>>> +    struct rutabaga_aio_data *data = opaque;
>>>>>> +    VirtIOGPU *g = VIRTIO_GPU(data->vr);
>>>>>> +    struct rutabaga_fence fence_data = data->fence;
>>>>>> +    struct virtio_gpu_ctrl_command *cmd, *tmp;
>>>>>> +
>>>>>> +    uint32_t signaled_ctx_specific = fence_data.flags &
>>>>>> +                                     RUTABAGA_FLAG_INFO_RING_IDX;
>>>>>> +
>>>>>> +    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
>>>>>> +        /*
>>>>>> +         * Due to context specific timelines.
>>>>>> +         */
>>>>>> +        uint32_t target_ctx_specific = cmd->cmd_hdr.flags &
>>>>>> +                                       RUTABAGA_FLAG_INFO_RING_IDX;
>>>>>> +
>>>>>> +        if (signaled_ctx_specific != target_ctx_specific) {
>>>>>> +            continue;
>>>>>> +        }
>>>>>> +
>>>>>> +        if (signaled_ctx_specific &&
>>>>>> +           (cmd->cmd_hdr.ring_idx != fence_data.ring_idx)) {
>>>>>> +            continue;
>>>>>> +        }
>>>>>> +
>>>>>> +        if (cmd->cmd_hdr.fence_id > fence_data.fence_id) {
>>>>>> +            continue;
>>>>>> +        }
>>>>>> +
>>>>>> +        trace_virtio_gpu_fence_resp(cmd->cmd_hdr.fence_id);
>>>>>> +        virtio_gpu_ctrl_response_nodata(g, cmd,
>>>>> VIRTIO_GPU_RESP_OK_NODATA);
>>>>>> +        QTAILQ_REMOVE(&g->fenceq, cmd, next);
>>>>>> +        g_free(cmd);
>>>>>> +    }
>>>>>> +
>>>>>> +    g_free(data);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +virtio_gpu_rutabaga_fence_cb(uint64_t user_data,
>>>>>> +                             const struct rutabaga_fence *fence) {
>>>>>> +    struct rutabaga_aio_data *data;
>>>>>> +    VirtIOGPU *g = (VirtIOGPU *)user_data;
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +
>>>>>> +    /*
>>>>>> +     * gfxstream and both cross-domain (and even newer versions
>>>>> virglrenderer:
>>>>>> +     * see VIRGL_RENDERER_ASYNC_FENCE_CB) like to signal fence
>>>>> completion on
>>>>>> +     * threads ("callback threads") that are different from the thread
>>>>> that
>>>>>> +     * processes the command queue ("main thread").
>>>>>> +     *
>>>>>> +     * crosvm and other virtio-gpu 1.1 implementations enable callback
>>>>> threads
>>>>>> +     * via locking.  However, on QEMU a deadlock is observed if
>>>>>> +     * virtio_gpu_ctrl_response_nodata(..) [used in the fence
>>> callback]
>>>>> is used
>>>>>> +     * from a thread that is not the main thread.
>>>>>> +     *
>>>>>> +     * The reason is QEMU's internal locking is designed to work with
>>>>> QEMU
>>>>>> +     * threads (see rcu_register_thread()) and not generic C/C++/Rust
>>>>> threads.
>>>>>> +     * For now, we can workaround this by scheduling the return of the
>>>>>> +     * fence descriptors on the main thread.
>>>>>> +     */
>>>>>> +
>>>>>> +    data = g_new0(struct rutabaga_aio_data, 1);
>>>>>> +    data->vr = vr;
>>>>>> +    data->fence = *fence;
>>>>>> +    aio_bh_schedule_oneshot(qemu_get_aio_context(),
>>>>>> +                            virtio_gpu_rutabaga_aio_cb,
>>>>>> +                            data);
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +virtio_gpu_rutabaga_debug_cb(uint64_t user_data,
>>>>>> +                             const struct rutabaga_debug *debug) {
>>>>>> +
>>>>>> +    if (debug->debug_type == RUTABAGA_DEBUG_ERROR) {
>>>>>> +        error_report("%s", debug->message);
>>>>>> +    } else if (debug->debug_type == RUTABAGA_DEBUG_WARN) {
>>>>>> +        warn_report("%s", debug->message);
>>>>>> +    } else if (debug->debug_type == RUTABAGA_DEBUG_INFO) {
>>>>>> +        info_report("%s", debug->message);
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>> +static bool virtio_gpu_rutabaga_init(VirtIOGPU *g, Error **errp)
>>>>>> +{
>>>>>> +    int result;
>>>>>> +    uint64_t capset_mask;
>>>>>> +    struct rutabaga_builder builder = { 0 };
>>>>>> +    char wayland_socket_path[UNIX_PATH_MAX];
>>>>>> +    struct rutabaga_channel channel = { 0 };
>>>>>> +    struct rutabaga_channels channels = { 0 };
>>>>>> +
>>>>>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>>>>>> +    vr->rutabaga = NULL;
>>>>>> +
>>>>>> +    if (!vr->capset_names) {
>>>>>> +        error_setg(errp, "a capset name from the virtio-gpu spec is
>>>>> required");
>>>>>> +        return false;
>>>>>> +    }
>>>>>> +
>>>>>> +    builder.wsi = RUTABAGA_WSI_SURFACELESS;
>>>>>> +    /*
>>>>>> +     * Currently, if WSI is specified, the only valid strings are
>>>>> "surfaceless"
>>>>>> +     * or "headless".  Surfaceless doesn't create a native window
>>>>> surface, but
>>>>>> +     * does copy from the render target to the Pixman buffer if a
>>>>> virtio-gpu
>>>>>> +     * 2D hypercall is issued.  Surfacless is the default.
>>>>>> +     *
>>>>>> +     * Headless is like surfaceless, but doesn't copy to the Pixman
>>>>> buffer. The
>>>>>> +     * use case is automated testing environments where there is no
>>> need
>>>>> to view
>>>>>> +     * results.
>>>>>> +     *
>>>>>> +     * In the future, more performant virtio-gpu 2D UI integration may
>>>>> be added.
>>>>>> +     */
>>>>>> +    if (vr->wsi) {
>>>>>> +        if (g_str_equal(vr->wsi, "surfaceless")) {
>>>>>> +            vr->headless = false;
>>>>>> +        } else if (g_str_equal(vr->wsi, "headless")) {
>>>>>> +            vr->headless = true;
>>>>>> +        } else {
>>>>>> +            error_setg(errp, "invalid wsi option selected");
>>>>>> +            return false;
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +    result = rutabaga_calculate_capset_mask(vr->capset_names,
>>>>> &capset_mask);
>>>>>
>>>>> First, sorry for responding after such a long time. I've been busy with
>>>>> work and I'm doing QEMU in my free time.
>>>>>
>>>>> In iteration 1 I've raised the topic on capset_names [1] and I haven't
>>>>> seen it answered properly. Perhaps I need to rephrase a bit so here we
>>> go:
>>>>> capset_names seems to be colon-separated list of bit options managed by
>>>>> rutabaga. This introduces yet another way of options handling. There
>>> have
>>>>> been talks about harmonizing options handling in QEMU since apparently
>>> it
>>>>> is considered too complex [2,3].
>>>>
>>>>
>>>>> Why not pass the "capset" as a bitfield like capset_mask and have QEMU
>>>>> create "capset" from QOM properties?
>>>>
>>>> IIUC these flags could come from virtio_gpu.h which is already present in
>>>>> the QEMU tree. This would not inly shortcut the dependency on rutabaga
>>> here
>>>>> but would also be more idiomatic QEMU (since it makes the options more
>>>>> introspectable by internal machinery).
>>>>
>>>>
>>>>> Of course the bitfield approach would require modifications in QEMU
>>>>> whenever rutabaga gains new features. However, I figure that in the long
>>>>> term rutabaga will be quite feature complete such that the benefits of
>>>>> idiomatic QEMU handling will outweigh the decoupling of the projects.
>>>>>
>>>>> What do you think?
>>>>>
>>>>
>>>> I think what you're suggesting is something like -device
>>>> virtio-gpu-rutabaga,capset_mask=0x10100 [40, which would be
>>>> gfxstream_vulkan + cross_domain]?
>>>
>>> I was thinking more along the lines of
>>> `virtio-gpu-rutabaga,gfxstream_vulkan=on,cross_domain=on` where
>>> gfxstream_vulkan and cross_domain are boolean QOM properties. This would
>>> make for a human-readable format which follows QEMU style.
>>>
>>>>
>>>> We actually did consider something like that when adding the
>>>> --context-types flag [with crosvm], but there was a desire for a
>>>> human-readable format rather than numbers [even if they are in the
>>>> virtio-gpu spec].
>>>>
>>>> Additionally, there are quite a few context types that people are playing
>>>> around with [gfxstream-gles, gfxstream-composer] that are launchable and
>>>> aren't in the spec just yet.
>>>
>>> Right, QEMU had to be modified for this kind of experimentation. I
>>> considered this in my last paragraph and figured that in the long run QEMU
>>> *may* prefer more idiomatic option handling since it tries hard to not
>>> break its command line interface. I'm just pointing this out -- the
>>> decision is ultimately up to the community.
>>>
>>> Why not have dedicated QEMU development branches for experimentation?
>>> Wouldn't upstreaming new features into QEMU be a good motivation to get the
>>> missing pieces into the spec, once they are mature?
>>
>>
>>>>
>>>> Also, a key feature we want to explicitly **not** turn on all available
>>>> context-types and let the user decide.
>>>
>>> How would you prevent that with the current colon-separated approach?
>>> Splitting capset_mask in multiple parameters is just a different
>>> syntactical representation of the same thing.
>>>
>>>> That'll allow guest Mesa in
>>>> particular to do its magic in its loader.  So one may run Zink + ANV with
>>>> ioctl forwarding, or Iris + ioctl forwarding and compare performance with
>>>> the same guest image.
>>>>
>>>> And another thing is one needs some knowledge of the host system to choose
>>>> the right context type.  You wouldn't do Zink + ANV ioctl forwarding on
>>>> MacOS.  So I think the task of choosing the right context type will fall
>>> to
>>>> projects that depend on QEMU (such as Android Emulator) which have some
>>>> knowledge of the host environment.
>>>>
>>>> We actually have a graphics detector somewhere that calls VK/OpenGL before
>>>> launching the VM and sets the right options.  Plan is to port into
>>>> gfxstream, maybe we could use that.
>>>
>>> You could bail out in QEMU if rutabaga_calculate_capset_mask() detects
>>> conflicting combinations, no?
>>>
>>>>
>>>> So given the desire for human readable formats, being portable across VMMs
>>>> (crosvm, qemu, rust-vmm??) and experimentation, the string -> capset mask
>>>> conversion was put in the rutabaga API.  So I wouldn't change it for those
>>>> reasons.
>>>
>>> What do you mean by being portable across VMMs?
>>
>>
>> Having the API inside rutabaga is (mildly) useful when multiple VMMs have
>> the need to translate from a human-readable format to flags digestible by
>> rutabaga.
>>
>> https://android.googlesource.com/device/google/cuttlefish/+/refs/heads/main/host/libs/vm_manager/qemu_manager.cpp#452
>>
>> https://android.googlesource.com/device/google/cuttlefish/+/refs/heads/main/host/libs/vm_manager/crosvm_manager.cpp#353
>>
>> https://chromium.googlesource.com/chromiumos/platform2/+/refs/heads/main/vm_tools/concierge/vm_builder.cc#505
>>
>> For these crosvm/qemu launchers, I imagine capset names will be plumbed all
>> the way through eventually (launch_cvd
>> --gpu_context=gfxstream-vulkan:cross-domain if you've played around with
>> Cuttlefish, or vmc start --gpu_contexts=gfxstream-vulkan if you played
>> around with Termina VMs).
>>
>> I think rust-vmm could also use the same API ("--capset_names") too.
>>
>>
>>> Sure, QEMU had to be taught new flags before being able to use new
>>> rutabaga features. I agree that this comes with a certain inconvenience.
>>> But it may also be inconvenient for QEMU to deal with additional ad-hoc
>>> options parsing when there are efforts for harmonization.
>>>
>>> Did my comments shed new light into the discussion?
>>
>>
>> Yes, they do.  I agree with you that both crosvm/qemu have too many flags,
>> and having a stable command line interface is important.  We are aiming for
>> stability with the `--capset_names={colon string}` command line, and at
>> least for crosvm looking to deprecate older options [since we've never had
>> an official release of crosvm yet].
>>
>> I do think:
>>
>> 1) "capset_names=gfxstream-vulkan:cross-domain"
>> 2) "cross-domain=on,gfxstream-vulkan=on"
>>
>> are similar enough.  I would choose (1) for since I think not duplicating
>> the [name] -> flag logic and having a similar interface across VMMs + VMM
>> launchers is ever-so slightly useful.
> 
> I think we've now reached a good understanding of the issue. It's now up to the QEMU community to make a choice. So I'm cc'ing Markus and Thomas as the experts of the topic.

As a virtio-gpu user, I'm slightly inclined to (2) since it would be 
easier to implement the same option for virtio-gpu-virgl when a need arises.

