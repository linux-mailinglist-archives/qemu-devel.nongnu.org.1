Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADD47B3662
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 17:08:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmF4w-0007db-Bq; Fri, 29 Sep 2023 11:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qmF4s-0007dM-BJ
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 11:06:51 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qmF4k-000873-R4
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 11:06:50 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso1929591166b.2
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 08:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695999999; x=1696604799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmgTCV7PXy8D76VyP4q9mi+OKgzzd0EoMFdG5Ufx0Ew=;
 b=hYgCArB0kCSNYlb3lPUZ6How0yP9Hint3M7sMt1Vp6M+vH8tvkQb2pJ6+EhD61umo6
 luzaM/yVQ4tAvXNqNOe4HcdLvbnfeYRlso0DpqfgPsqM8rO/jieFDPHiCKoB+KsoHyXa
 ZhPffEwAEf7//5GH8IGg0LkHI4DYvKJvbQr3EGL3Nf/lmyciGShXwPAKxZm4bUXj/kSU
 HQOtQvtAC2hEhj6meQDcvaW0pkuK7JVqbvAvhfB2OPoqcrUaQRhYUpOXaR3lZ+ss4wlA
 wVmsVruHpcIbRe7YqeReFV1V67CRtiiBK8iTAZFz42sUvtLiInrq1qxVTrXKvMpj417f
 emrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695999999; x=1696604799;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HmgTCV7PXy8D76VyP4q9mi+OKgzzd0EoMFdG5Ufx0Ew=;
 b=RnYL8aiOGKQFPWcxo1qSFUahp+sAFH1SYLcK6hSDiPtaH8U8U+EoISU1m0+VHZsmD6
 bwqvf944Aq0QbJY3ro7v6M2syn71hR+yz0ETBeRzWYfcDLUuqzAmimikPuf5nZ3abQXz
 8AMD41FfZPHY4Dkd8oyP6MuFAlqQ4WHDVChpm7PmVwcJ/YyAGXH6sX8h+6ozRLpGRxpR
 qkgoRaRlbxjcl9s7Oy8lsLsUUE9D1W0Od2qnqMeRIzw6x6tEPbeYy1moB17vxfcMqSrq
 WiX1TYO6/LW68/ieL/Nj3Dl4mAdYLB71BNs8KB/wNSJvVK44Pm1b/+kPkYANHQ8zP3Y7
 awLQ==
X-Gm-Message-State: AOJu0YzXNm3k6em/38WP7NpOPZLMnJne0J37GgftPNHNnYwSMvhpKiY/
 wc6tG1GJwDnnTdfw8/Qbmlc=
X-Google-Smtp-Source: AGHT+IFk1rFaPD8t4PX9jHF0mkpKWCM7PUtdU5rFFqFiQKhyAnOhuU8GcurMAIwXYkRa+cKZNuq6ZA==
X-Received: by 2002:a17:906:191:b0:9ae:57b8:ad1b with SMTP id
 17-20020a170906019100b009ae57b8ad1bmr4201783ejb.21.1695999997539; 
 Fri, 29 Sep 2023 08:06:37 -0700 (PDT)
Received: from ?IPv6:::1?
 (p200300faaf2af200ec2f1af55bbb116f.dip0.t-ipconnect.de.
 [2003:fa:af2a:f200:ec2f:1af5:5bbb:116f])
 by smtp.gmail.com with ESMTPSA id
 tk7-20020a170907c28700b009b29553b648sm6406465ejc.206.2023.09.29.08.06.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 08:06:37 -0700 (PDT)
Date: Fri, 29 Sep 2023 15:06:30 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gurchetan Singh <gurchetansingh@chromium.org>,
 Akihiko Odaki <akihiko.odaki@gmail.com>
CC: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, ray.huang@amd.com,
 alex.bennee@linaro.org, hi@alyssa.is, ernunes@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v11_6/9=5D_gfxstream_+_rutab?=
 =?US-ASCII?Q?aga=3A_add_initial_support_for_gfxstream?=
In-Reply-To: <CAAfnVBmAJL4TsRFcfwNyXKG7FESNDV_k1m1HW8_oaOio0WdWKA@mail.gmail.com>
References: <20230823012541.485-1-gurchetansingh@chromium.org>
 <20230823012541.485-7-gurchetansingh@chromium.org>
 <B1A4DF8C-3078-48AD-BC8B-F2FD7BA413CF@gmail.com>
 <CAAfnVBk6C7-Vn3buLOh453fz-dRB2vv-4BdkZWjuJDJoWLPAqA@mail.gmail.com>
 <D3C6E21B-E37E-41DA-8131-0C3D9EAF01FD@gmail.com>
 <CAAfnVBngeT8Ezt3osJW2NipFB3r9mJsLXzo1DEo4FtBaZpAO0w@mail.gmail.com>
 <ED6A24A1-42EC-47B2-A5D1-D57135A2D7D6@gmail.com>
 <83364d82-1a1e-4483-aad4-249ce30206a0@gmail.com>
 <CAAfnVBmAJL4TsRFcfwNyXKG7FESNDV_k1m1HW8_oaOio0WdWKA@mail.gmail.com>
Message-ID: <EF2A76D3-EC1E-4065-8B1A-229E5E9E804F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 21=2E September 2023 23:44:42 UTC schrieb Gurchetan Singh <gurchetansin=
gh@chromium=2Eorg>:
>On Tue, Sep 19, 2023 at 3:07=E2=80=AFPM Akihiko Odaki <akihiko=2Eodaki@gm=
ail=2Ecom>
>wrote:
>
>> On 2023/09/20 3:36, Bernhard Beschow wrote:
>> >
>> >
>> > Am 15=2E September 2023 02:38:02 UTC schrieb Gurchetan Singh <
>> gurchetansingh@chromium=2Eorg>:
>> >> On Thu, Sep 14, 2023 at 12:23=E2=80=AFAM Bernhard Beschow <shentey@g=
mail=2Ecom>
>> wrote:
>> >>
>> >>>
>> >>>
>> >>> Am 14=2E September 2023 04:38:51 UTC schrieb Gurchetan Singh <
>> >>> gurchetansingh@chromium=2Eorg>:
>> >>>> On Wed, Sep 13, 2023 at 4:58=E2=80=AFAM Bernhard Beschow <shentey@=
gmail=2Ecom>
>> >>> wrote:
>> >>>>
>> >>>>>
>> >>>>>
>> >>>>> Am 23=2E August 2023 01:25:38 UTC schrieb Gurchetan Singh <
>> >>>>> gurchetansingh@chromium=2Eorg>:
>> >>>>>> This adds initial support for gfxstream and cross-domain=2E  Bot=
h
>> >>>>>> features rely on virtio-gpu blob resources and context types, wh=
ich
>> >>>>>> are also implemented in this patch=2E
>> >>>>>>
>> >>>>>> gfxstream has a long and illustrious history in Android graphics
>> >>>>>> paravirtualization=2E  It has been powering graphics in the Andr=
oid
>> >>>>>> Studio Emulator for more than a decade, which is the main develo=
per
>> >>>>>> platform=2E
>> >>>>>>
>> >>>>>> Originally conceived by Jesse Hall, it was first known as "EmuGL=
"
>> [a]=2E
>> >>>>>> The key design characteristic was a 1:1 threading model and
>> >>>>>> auto-generation, which fit nicely with the OpenGLES spec=2E  It =
also
>> >>>>>> allowed easy layering with ANGLE on the host, which provides the
>> GLES
>> >>>>>> implementations on Windows or MacOS enviroments=2E
>> >>>>>>
>> >>>>>> gfxstream has traditionally been maintained by a single engineer=
,
>> and
>> >>>>>> between 2015 to 2021, the goldfish throne passed to Frank Yang=
=2E
>> >>>>>> Historians often remark this glorious reign ("pax gfxstreama" is=
 the
>> >>>>>> academic term) was comparable to that of Augustus and both Queen
>> >>>>>> Elizabeths=2E  Just to name a few accomplishments in a resplende=
nt
>> >>>>>> panoply: higher versions of GLES, address space graphics, snapsh=
ot
>> >>>>>> support and CTS compliant Vulkan [b]=2E
>> >>>>>>
>> >>>>>> One major drawback was the use of out-of-tree goldfish drivers=
=2E
>> >>>>>> Android engineers didn't know much about DRM/KMS and especially =
TTM
>> so
>> >>>>>> a simple guest to host pipe was conceived=2E
>> >>>>>>
>> >>>>>> Luckily, virtio-gpu 3D started to emerge in 2016 due to the work=
 of
>> >>>>>> the Mesa/virglrenderer communities=2E  In 2018, the initial virt=
io-gpu
>> >>>>>> port of gfxstream was done by Cuttlefish enthusiast Alistair Del=
va=2E
>> >>>>>> It was a symbol compatible replacement of virglrenderer [c] and
>> named
>> >>>>>> "AVDVirglrenderer"=2E  This implementation forms the basis of th=
e
>> >>>>>> current gfxstream host implementation still in use today=2E
>> >>>>>>
>> >>>>>> cross-domain support follows a similar arc=2E  Originally concei=
ved by
>> >>>>>> Wayland aficionado David Reveman and crosvm enjoyer Zach Reizner=
 in
>> >>>>>> 2018, it initially relied on the downstream "virtio-wl" device=
=2E
>> >>>>>>
>> >>>>>> In 2020 and 2021, virtio-gpu was extended to include blob resour=
ces
>> >>>>>> and multiple timelines by yours truly, features
>> gfxstream/cross-domain
>> >>>>>> both require to function correctly=2E
>> >>>>>>
>> >>>>>> Right now, we stand at the precipice of a truly fantastic
>> possibility:
>> >>>>>> the Android Emulator powered by upstream QEMU and upstream Linux
>> >>>>>> kernel=2E  gfxstream will then be packaged properfully, and app
>> >>>>>> developers can even fix gfxstream bugs on their own if they
>> encounter
>> >>>>>> them=2E
>> >>>>>>
>> >>>>>> It's been quite the ride, my friends=2E  Where will gfxstream he=
ad
>> next,
>> >>>>>> nobody really knows=2E  I wouldn't be surprised if it's around f=
or
>> >>>>>> another decade, maintained by a new generation of Android graphi=
cs
>> >>>>>> enthusiasts=2E
>> >>>>>>
>> >>>>>> Technical details:
>> >>>>>>   - Very simple initial display integration: just used Pixman
>> >>>>>>   - Largely, 1:1 mapping of virtio-gpu hypercalls to rutabaga
>> function
>> >>>>>>     calls
>> >>>>>>
>> >>>>>> Next steps for Android VMs:
>> >>>>>>   - The next step would be improving display integration and UI
>> >>> interfaces
>> >>>>>>     with the goal of the QEMU upstream graphics being in an emul=
ator
>> >>>>>>     release [d]=2E
>> >>>>>>
>> >>>>>> Next steps for Linux VMs for display virtualization:
>> >>>>>>   - For widespread distribution, someone needs to package Sommel=
ier
>> or
>> >>> the
>> >>>>>>     wayland-proxy-virtwl [e] ideally into Debian main=2E In addi=
tion,
>> >>> newer
>> >>>>>>     versions of the Linux kernel come with DRM_VIRTIO_GPU_KMS
>> option,
>> >>>>>>     which allows disabling KMS hypercalls=2E  If anyone cares en=
ough,
>> >>> it'll
>> >>>>>>     probably be possible to build a custom VM variant that uses =
this
>> >>>>> display
>> >>>>>>     virtualization strategy=2E
>> >>>>>>
>> >>>>>> [a]
>> >>>>>
>> https://android-review=2Egooglesource=2Ecom/c/platform/development/+/34=
470
>> >>>>>> [b]
>> >>>>>
>> >>>
>> https://android-review=2Egooglesource=2Ecom/q/topic:%22vulkan-hostconne=
ction-start%22
>> >>>>>> [c]
>> >>>>>
>> >>>
>> https://android-review=2Egooglesource=2Ecom/c/device/generic/goldfish-o=
pengl/+/761927
>> >>>>>> [d] https://developer=2Eandroid=2Ecom/studio/releases/emulator
>> >>>>>> [e] https://github=2Ecom/talex5/wayland-proxy-virtwl
>> >>>>>>
>> >>>>>> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium=2Eorg>
>> >>>>>> Tested-by: Alyssa Ross <hi@alyssa=2Eis>
>> >>>>>> Tested-by: Emmanouil Pitsidianakis <manos=2Epitsidianakis@linaro=
=2Eorg>
>> >>>>>> Reviewed-by: Emmanouil Pitsidianakis <
>> manos=2Epitsidianakis@linaro=2Eorg>
>> >>>>>> ---
>> >>>>>> v1: Incorported various suggestions by Akihiko Odaki and Bernard
>> >>> Berschow
>> >>>>>>     - Removed GET_VIRTIO_GPU_GL / GET_RUTABAGA macros
>> >>>>>>     - Used error_report(=2E=2E)
>> >>>>>>     - Used g_autofree to fix leaks on error paths
>> >>>>>>     - Removed unnecessary casts
>> >>>>>>     - added virtio-gpu-pci-rutabaga=2Ec + virtio-vga-rutabaga=2E=
c files
>> >>>>>>
>> >>>>>> v2: Incorported various suggestions by Akihiko Odaki, Marc-Andr=
=C3=A9
>> Lureau
>> >>>>> and
>> >>>>>>     Bernard Berschow:
>> >>>>>>     - Parenthesis in CHECK macro
>> >>>>>>     - CHECK_RESULT(result, =2E=2E) --> CHECK(!result, =2E=2E)
>> >>>>>>     - delay until g->parent_obj=2Eenable =3D 1
>> >>>>>>     - Additional cast fixes
>> >>>>>>     - initialize directly in virtio_gpu_rutabaga_realize(=2E=2E)
>> >>>>>>     - add debug callback to hook into QEMU error's APIs
>> >>>>>>
>> >>>>>> v3: Incorporated feedback from Akihiko Odaki and Alyssa Ross:
>> >>>>>>     - Autodetect Wayland socket when not explicitly specified
>> >>>>>>     - Fix map_blob error paths
>> >>>>>>     - Add comment why we need both `res` and `resource` in creat=
e
>> blob
>> >>>>>>     - Cast and whitespace fixes
>> >>>>>>     - Big endian check comes before virtio_gpu_rutabaga_init()=
=2E
>> >>>>>>     - VirtIOVGARUTABAGA --> VirtIOVGARutabaga
>> >>>>>>
>> >>>>>> v4: Incorporated feedback from Akihiko Odaki and Alyssa Ross:
>> >>>>>>     - Double checked all casts
>> >>>>>>     - Remove unnecessary parenthesis
>> >>>>>>     - Removed `resource` in create_blob
>> >>>>>>     - Added comment about failure case
>> >>>>>>     - Pass user-provided socket as-is
>> >>>>>>     - Use stack variable rather than heap allocation
>> >>>>>>     - Future-proofed map info API to give access flags as well
>> >>>>>>
>> >>>>>> v5: Incorporated feedback from Akihiko Odaki:
>> >>>>>>     - Check (ss=2Escanout_id < VIRTIO_GPU_MAX_SCANOUTS)
>> >>>>>>     - Simplify num_capsets check
>> >>>>>>     - Call cleanup mapping on error paths
>> >>>>>>     - uint64_t --> void* for rutabaga_map(=2E=2E)
>> >>>>>>     - Removed unnecessary parenthesis
>> >>>>>>     - Removed unnecessary cast
>> >>>>>>     - #define UNIX_PATH_MAX sizeof((struct sockaddr_un) {}=2Esun=
_path)
>> >>>>>>     - Reuse result variable
>> >>>>>>
>> >>>>>> v6: Incorporated feedback from Akihiko Odaki:
>> >>>>>>     - Remove unnecessary #ifndef
>> >>>>>>     - Disable scanout when appropriate
>> >>>>>>     - CHECK capset index within range outside loop
>> >>>>>>     - Add capset_version
>> >>>>>>
>> >>>>>> v7: Incorporated feedback from Akihiko Odaki:
>> >>>>>>     - aio_bh_schedule_oneshot_full --> aio_bh_schedule_oneshot
>> >>>>>>
>> >>>>>> v9: Incorportated feedback from Akihiko Odaki:
>> >>>>>>     - Remove extra error_setg(=2E=2E) after virtio_gpu_rutabaga_=
init(=2E=2E)
>> >>>>>>     - Add error_setg(=2E=2E) after rutabaga_init(=2E=2E)
>> >>>>>>
>> >>>>>> v10: Incorportated feedback from Akihiko Odaki:
>> >>>>>>     - error_setg(=2E=2E) --> error_setg_errno(=2E=2E) when appro=
priate
>> >>>>>>     - virtio_gpu_rutabaga_init returns a bool instead of an int
>> >>>>>>
>> >>>>>> v11: Incorportated feedback from Philippe Mathieu-Daud=C3=A9:
>> >>>>>>     - C-style /* */ comments and avoid // comments=2E
>> >>>>>>     - GPL-2=2E0 --> GPL-2=2E0-or-later
>> >>>>>>
>> >>>>>> hw/display/virtio-gpu-pci-rutabaga=2Ec |   50 ++
>> >>>>>> hw/display/virtio-gpu-rutabaga=2Ec     | 1121
>> ++++++++++++++++++++++++++
>> >>>>>> hw/display/virtio-vga-rutabaga=2Ec     |   53 ++
>> >>>>>> 3 files changed, 1224 insertions(+)
>> >>>>>> create mode 100644 hw/display/virtio-gpu-pci-rutabaga=2Ec
>> >>>>>> create mode 100644 hw/display/virtio-gpu-rutabaga=2Ec
>> >>>>>> create mode 100644 hw/display/virtio-vga-rutabaga=2Ec
>> >>>>>>
>> >>>>>> diff --git a/hw/display/virtio-gpu-pci-rutabaga=2Ec
>> >>>>> b/hw/display/virtio-gpu-pci-rutabaga=2Ec
>> >>>>>> new file mode 100644
>> >>>>>> index 0000000000=2E=2E311eff308a
>> >>>>>> --- /dev/null
>> >>>>>> +++ b/hw/display/virtio-gpu-pci-rutabaga=2Ec
>> >>>>>> @@ -0,0 +1,50 @@
>> >>>>>> +/*
>> >>>>>> + * SPDX-License-Identifier: GPL-2=2E0-or-later
>> >>>>>> + */
>> >>>>>> +
>> >>>>>> +#include "qemu/osdep=2Eh"
>> >>>>>> +#include "qapi/error=2Eh"
>> >>>>>> +#include "qemu/module=2Eh"
>> >>>>>> +#include "hw/pci/pci=2Eh"
>> >>>>>> +#include "hw/qdev-properties=2Eh"
>> >>>>>> +#include "hw/virtio/virtio=2Eh"
>> >>>>>> +#include "hw/virtio/virtio-bus=2Eh"
>> >>>>>> +#include "hw/virtio/virtio-gpu-pci=2Eh"
>> >>>>>> +#include "qom/object=2Eh"
>> >>>>>> +
>> >>>>>> +#define TYPE_VIRTIO_GPU_RUTABAGA_PCI "virtio-gpu-rutabaga-pci"
>> >>>>>> +typedef struct VirtIOGPURutabagaPCI VirtIOGPURutabagaPCI;
>> >>>>>> +DECLARE_INSTANCE_CHECKER(VirtIOGPURutabagaPCI,
>> >>> VIRTIO_GPU_RUTABAGA_PCI,
>> >>>>>> +                         TYPE_VIRTIO_GPU_RUTABAGA_PCI)
>> >>>>>> +
>> >>>>>> +struct VirtIOGPURutabagaPCI {
>> >>>>>> +    VirtIOGPUPCIBase parent_obj;
>> >>>>>> +    VirtIOGPURutabaga vdev;
>> >>>>>> +};
>> >>>>>> +
>> >>>>>> +static void virtio_gpu_rutabaga_initfn(Object *obj)
>> >>>>>> +{
>> >>>>>> +    VirtIOGPURutabagaPCI *dev =3D VIRTIO_GPU_RUTABAGA_PCI(obj);
>> >>>>>> +
>> >>>>>> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vd=
ev),
>> >>>>>> +                                TYPE_VIRTIO_GPU_RUTABAGA);
>> >>>>>> +    VIRTIO_GPU_PCI_BASE(obj)->vgpu =3D VIRTIO_GPU_BASE(&dev->vd=
ev);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static const VirtioPCIDeviceTypeInfo virtio_gpu_rutabaga_pci_in=
fo
>> =3D {
>> >>>>>> +    =2Egeneric_name =3D TYPE_VIRTIO_GPU_RUTABAGA_PCI,
>> >>>>>> +    =2Eparent =3D TYPE_VIRTIO_GPU_PCI_BASE,
>> >>>>>> +    =2Einstance_size =3D sizeof(VirtIOGPURutabagaPCI),
>> >>>>>> +    =2Einstance_init =3D virtio_gpu_rutabaga_initfn,
>> >>>>>> +};
>> >>>>>> +module_obj(TYPE_VIRTIO_GPU_RUTABAGA_PCI);
>> >>>>>> +module_kconfig(VIRTIO_PCI);
>> >>>>>> +
>> >>>>>> +static void virtio_gpu_rutabaga_pci_register_types(void)
>> >>>>>> +{
>> >>>>>> +    virtio_pci_types_register(&virtio_gpu_rutabaga_pci_info);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +type_init(virtio_gpu_rutabaga_pci_register_types)
>> >>>>>> +
>> >>>>>> +module_dep("hw-display-virtio-gpu-pci");
>> >>>>>> diff --git a/hw/display/virtio-gpu-rutabaga=2Ec
>> >>>>> b/hw/display/virtio-gpu-rutabaga=2Ec
>> >>>>>> new file mode 100644
>> >>>>>> index 0000000000=2E=2E9018e5a702
>> >>>>>> --- /dev/null
>> >>>>>> +++ b/hw/display/virtio-gpu-rutabaga=2Ec
>> >>>>>> @@ -0,0 +1,1121 @@
>> >>>>>> +/*
>> >>>>>> + * SPDX-License-Identifier: GPL-2=2E0-or-later
>> >>>>>> + */
>> >>>>>> +
>> >>>>>> +#include "qemu/osdep=2Eh"
>> >>>>>> +#include "qapi/error=2Eh"
>> >>>>>> +#include "qemu/error-report=2Eh"
>> >>>>>> +#include "qemu/iov=2Eh"
>> >>>>>> +#include "trace=2Eh"
>> >>>>>> +#include "hw/virtio/virtio=2Eh"
>> >>>>>> +#include "hw/virtio/virtio-gpu=2Eh"
>> >>>>>> +#include "hw/virtio/virtio-gpu-pixman=2Eh"
>> >>>>>> +#include "hw/virtio/virtio-iommu=2Eh"
>> >>>>>> +
>> >>>>>> +#include <glib/gmem=2Eh>
>> >>>>>> +#include <rutabaga_gfx/rutabaga_gfx_ffi=2Eh>
>> >>>>>> +
>> >>>>>> +#define CHECK(condition, cmd)
>> >>>>>       \
>> >>>>>> +    do {
>> >>>>>        \
>> >>>>>> +        if (!(condition)) {
>> >>>>>       \
>> >>>>>> +            error_report("CHECK failed in %s() %s:" "%d", __fun=
c__,
>> >>>>>       \
>> >>>>>> +                         __FILE__, __LINE__);
>> >>>>>       \
>> >>>>>> +            (cmd)->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>> >>>>>        \
>> >>>>>> +            return;
>> >>>>>       \
>> >>>>>> +       }
>> >>>>>        \
>> >>>>>> +    } while (0)
>> >>>>>> +
>> >>>>>> +/*
>> >>>>>> + * This is the size of the char array in struct sock_addr_un=2E=
 No
>> >>> Wayland
>> >>>>> socket
>> >>>>>> + * can be created with a path longer than this, including the n=
ull
>> >>>>> terminator=2E
>> >>>>>> + */
>> >>>>>> +#define UNIX_PATH_MAX sizeof((struct sockaddr_un) {} =2Esun_pat=
h)
>> >>>>>> +
>> >>>>>> +struct rutabaga_aio_data {
>> >>>>>> +    struct VirtIOGPURutabaga *vr;
>> >>>>>> +    struct rutabaga_fence fence;
>> >>>>>> +};
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, struct
>> >>>>> virtio_gpu_scanout *s,
>> >>>>>> +                                  uint32_t resource_id)
>> >>>>>> +{
>> >>>>>> +    struct virtio_gpu_simple_resource *res;
>> >>>>>> +    struct rutabaga_transfer transfer =3D { 0 };
>> >>>>>> +    struct iovec transfer_iovec;
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    res =3D virtio_gpu_find_resource(g, resource_id);
>> >>>>>> +    if (!res) {
>> >>>>>> +        return;
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    if (res->width !=3D s->current_cursor->width ||
>> >>>>>> +        res->height !=3D s->current_cursor->height) {
>> >>>>>> +        return;
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    transfer=2Ex =3D 0;
>> >>>>>> +    transfer=2Ey =3D 0;
>> >>>>>> +    transfer=2Ez =3D 0;
>> >>>>>> +    transfer=2Ew =3D res->width;
>> >>>>>> +    transfer=2Eh =3D res->height;
>> >>>>>> +    transfer=2Ed =3D 1;
>> >>>>>> +
>> >>>>>> +    transfer_iovec=2Eiov_base =3D s->current_cursor->data;
>> >>>>>> +    transfer_iovec=2Eiov_len =3D res->width * res->height * 4;
>> >>>>>> +
>> >>>>>> +    rutabaga_resource_transfer_read(vr->rutabaga, 0,
>> >>>>>> +                                    resource_id, &transfer,
>> >>>>>> +                                    &transfer_iovec);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +virtio_gpu_rutabaga_gl_flushed(VirtIOGPUBase *b)
>> >>>>>> +{
>> >>>>>> +    VirtIOGPU *g =3D VIRTIO_GPU(b);
>> >>>>>> +    virtio_gpu_process_cmdq(g);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +rutabaga_cmd_create_resource_2d(VirtIOGPU *g,
>> >>>>>> +                                struct virtio_gpu_ctrl_command
>> *cmd)
>> >>>>>> +{
>> >>>>>> +    int32_t result;
>> >>>>>> +    struct rutabaga_create_3d rc_3d =3D { 0 };
>> >>>>>> +    struct virtio_gpu_simple_resource *res;
>> >>>>>> +    struct virtio_gpu_resource_create_2d c2d;
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(c2d);
>> >>>>>> +    trace_virtio_gpu_cmd_res_create_2d(c2d=2Eresource_id, c2d=
=2Eformat,
>> >>>>>> +                                       c2d=2Ewidth, c2d=2Eheigh=
t);
>> >>>>>> +
>> >>>>>> +    rc_3d=2Etarget =3D 2;
>> >>>>>> +    rc_3d=2Eformat =3D c2d=2Eformat;
>> >>>>>> +    rc_3d=2Ebind =3D (1 << 1);
>> >>>>>> +    rc_3d=2Ewidth =3D c2d=2Ewidth;
>> >>>>>> +    rc_3d=2Eheight =3D c2d=2Eheight;
>> >>>>>> +    rc_3d=2Edepth =3D 1;
>> >>>>>> +    rc_3d=2Earray_size =3D 1;
>> >>>>>> +    rc_3d=2Elast_level =3D 0;
>> >>>>>> +    rc_3d=2Enr_samples =3D 0;
>> >>>>>> +    rc_3d=2Eflags =3D VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
>> >>>>>> +
>> >>>>>> +    result =3D rutabaga_resource_create_3d(vr->rutabaga,
>> >>> c2d=2Eresource_id,
>> >>>>> &rc_3d);
>> >>>>>> +    CHECK(!result, cmd);
>> >>>>>> +
>> >>>>>> +    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
>> >>>>>> +    res->width =3D c2d=2Ewidth;
>> >>>>>> +    res->height =3D c2d=2Eheight;
>> >>>>>> +    res->format =3D c2d=2Eformat;
>> >>>>>> +    res->resource_id =3D c2d=2Eresource_id;
>> >>>>>> +
>> >>>>>> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
>> >>>>>> +                                struct virtio_gpu_ctrl_command
>> *cmd)
>> >>>>>> +{
>> >>>>>> +    int32_t result;
>> >>>>>> +    struct rutabaga_create_3d rc_3d =3D { 0 };
>> >>>>>> +    struct virtio_gpu_simple_resource *res;
>> >>>>>> +    struct virtio_gpu_resource_create_3d c3d;
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(c3d);
>> >>>>>> +
>> >>>>>> +    trace_virtio_gpu_cmd_res_create_3d(c3d=2Eresource_id, c3d=
=2Eformat,
>> >>>>>> +                                       c3d=2Ewidth, c3d=2Eheigh=
t,
>> >>> c3d=2Edepth);
>> >>>>>> +
>> >>>>>> +    rc_3d=2Etarget =3D c3d=2Etarget;
>> >>>>>> +    rc_3d=2Eformat =3D c3d=2Eformat;
>> >>>>>> +    rc_3d=2Ebind =3D c3d=2Ebind;
>> >>>>>> +    rc_3d=2Ewidth =3D c3d=2Ewidth;
>> >>>>>> +    rc_3d=2Eheight =3D c3d=2Eheight;
>> >>>>>> +    rc_3d=2Edepth =3D c3d=2Edepth;
>> >>>>>> +    rc_3d=2Earray_size =3D c3d=2Earray_size;
>> >>>>>> +    rc_3d=2Elast_level =3D c3d=2Elast_level;
>> >>>>>> +    rc_3d=2Enr_samples =3D c3d=2Enr_samples;
>> >>>>>> +    rc_3d=2Eflags =3D c3d=2Eflags;
>> >>>>>> +
>> >>>>>> +    result =3D rutabaga_resource_create_3d(vr->rutabaga,
>> >>> c3d=2Eresource_id,
>> >>>>> &rc_3d);
>> >>>>>> +    CHECK(!result, cmd);
>> >>>>>> +
>> >>>>>> +    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
>> >>>>>> +    res->width =3D c3d=2Ewidth;
>> >>>>>> +    res->height =3D c3d=2Eheight;
>> >>>>>> +    res->format =3D c3d=2Eformat;
>> >>>>>> +    res->resource_id =3D c3d=2Eresource_id;
>> >>>>>> +
>> >>>>>> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +rutabaga_cmd_resource_unref(VirtIOGPU *g,
>> >>>>>> +                            struct virtio_gpu_ctrl_command *cmd=
)
>> >>>>>> +{
>> >>>>>> +    int32_t result;
>> >>>>>> +    struct virtio_gpu_simple_resource *res;
>> >>>>>> +    struct virtio_gpu_resource_unref unref;
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(unref);
>> >>>>>> +
>> >>>>>> +    trace_virtio_gpu_cmd_res_unref(unref=2Eresource_id);
>> >>>>>> +
>> >>>>>> +    res =3D virtio_gpu_find_resource(g, unref=2Eresource_id);
>> >>>>>> +    CHECK(res, cmd);
>> >>>>>> +
>> >>>>>> +    result =3D rutabaga_resource_unref(vr->rutabaga,
>> unref=2Eresource_id);
>> >>>>>> +    CHECK(!result, cmd);
>> >>>>>> +
>> >>>>>> +    if (res->image) {
>> >>>>>> +        pixman_image_unref(res->image);
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    QTAILQ_REMOVE(&g->reslist, res, next);
>> >>>>>> +    g_free(res);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +rutabaga_cmd_context_create(VirtIOGPU *g,
>> >>>>>> +                            struct virtio_gpu_ctrl_command *cmd=
)
>> >>>>>> +{
>> >>>>>> +    int32_t result;
>> >>>>>> +    struct virtio_gpu_ctx_create cc;
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(cc);
>> >>>>>> +    trace_virtio_gpu_cmd_ctx_create(cc=2Ehdr=2Ectx_id,
>> >>>>>> +                                    cc=2Edebug_name);
>> >>>>>> +
>> >>>>>> +    result =3D rutabaga_context_create(vr->rutabaga, cc=2Ehdr=
=2Ectx_id,
>> >>>>>> +                                     cc=2Econtext_init,
>> cc=2Edebug_name,
>> >>>>> cc=2Enlen);
>> >>>>>> +    CHECK(!result, cmd);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +rutabaga_cmd_context_destroy(VirtIOGPU *g,
>> >>>>>> +                             struct virtio_gpu_ctrl_command *cm=
d)
>> >>>>>> +{
>> >>>>>> +    int32_t result;
>> >>>>>> +    struct virtio_gpu_ctx_destroy cd;
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(cd);
>> >>>>>> +    trace_virtio_gpu_cmd_ctx_destroy(cd=2Ehdr=2Ectx_id);
>> >>>>>> +
>> >>>>>> +    result =3D rutabaga_context_destroy(vr->rutabaga, cd=2Ehdr=
=2Ectx_id);
>> >>>>>> +    CHECK(!result, cmd);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +rutabaga_cmd_resource_flush(VirtIOGPU *g, struct
>> >>> virtio_gpu_ctrl_command
>> >>>>> *cmd)
>> >>>>>> +{
>> >>>>>> +    int32_t result, i;
>> >>>>>> +    struct virtio_gpu_scanout *scanout =3D NULL;
>> >>>>>> +    struct virtio_gpu_simple_resource *res;
>> >>>>>> +    struct rutabaga_transfer transfer =3D { 0 };
>> >>>>>> +    struct iovec transfer_iovec;
>> >>>>>> +    struct virtio_gpu_resource_flush rf;
>> >>>>>> +    bool found =3D false;
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +    if (vr->headless) {
>> >>>>>> +        return;
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(rf);
>> >>>>>> +    trace_virtio_gpu_cmd_res_flush(rf=2Eresource_id,
>> >>>>>> +                                   rf=2Er=2Ewidth, rf=2Er=2Ehei=
ght, rf=2Er=2Ex,
>> >>>>> rf=2Er=2Ey);
>> >>>>>> +
>> >>>>>> +    res =3D virtio_gpu_find_resource(g, rf=2Eresource_id);
>> >>>>>> +    CHECK(res, cmd);
>> >>>>>> +
>> >>>>>> +    for (i =3D 0; i < g->parent_obj=2Econf=2Emax_outputs; i++) =
{
>> >>>>>> +        scanout =3D &g->parent_obj=2Escanout[i];
>> >>>>>> +        if (i =3D=3D res->scanout_bitmask) {
>> >>>>>> +            found =3D true;
>> >>>>>> +            break;
>> >>>>>> +        }
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    if (!found) {
>> >>>>>> +        return;
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    transfer=2Ex =3D 0;
>> >>>>>> +    transfer=2Ey =3D 0;
>> >>>>>> +    transfer=2Ez =3D 0;
>> >>>>>> +    transfer=2Ew =3D res->width;
>> >>>>>> +    transfer=2Eh =3D res->height;
>> >>>>>> +    transfer=2Ed =3D 1;
>> >>>>>> +
>> >>>>>> +    transfer_iovec=2Eiov_base =3D pixman_image_get_data(res->im=
age);
>> >>>>>> +    transfer_iovec=2Eiov_len =3D res->width * res->height * 4;
>> >>>>>> +
>> >>>>>> +    result =3D rutabaga_resource_transfer_read(vr->rutabaga, 0,
>> >>>>>> +                                             rf=2Eresource_id,
>> >>> &transfer,
>> >>>>>> +                                             &transfer_iovec);
>> >>>>>> +    CHECK(!result, cmd);
>> >>>>>> +    dpy_gfx_update_full(scanout->con);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +rutabaga_cmd_set_scanout(VirtIOGPU *g, struct
>> virtio_gpu_ctrl_command
>> >>>>> *cmd)
>> >>>>>> +{
>> >>>>>> +    struct virtio_gpu_simple_resource *res;
>> >>>>>> +    struct virtio_gpu_scanout *scanout =3D NULL;
>> >>>>>> +    struct virtio_gpu_set_scanout ss;
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +    if (vr->headless) {
>> >>>>>> +        return;
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(ss);
>> >>>>>> +    trace_virtio_gpu_cmd_set_scanout(ss=2Escanout_id, ss=2Ereso=
urce_id,
>> >>>>>> +                                     ss=2Er=2Ewidth, ss=2Er=2Eh=
eight,
>> ss=2Er=2Ex,
>> >>>>> ss=2Er=2Ey);
>> >>>>>> +
>> >>>>>> +    CHECK(ss=2Escanout_id < VIRTIO_GPU_MAX_SCANOUTS, cmd);
>> >>>>>> +    scanout =3D &g->parent_obj=2Escanout[ss=2Escanout_id];
>> >>>>>> +
>> >>>>>> +    if (ss=2Eresource_id =3D=3D 0) {
>> >>>>>> +        dpy_gfx_replace_surface(scanout->con, NULL);
>> >>>>>> +        dpy_gl_scanout_disable(scanout->con);
>> >>>>>> +        return;
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    res =3D virtio_gpu_find_resource(g, ss=2Eresource_id);
>> >>>>>> +    CHECK(res, cmd);
>> >>>>>> +
>> >>>>>> +    if (!res->image) {
>> >>>>>> +        pixman_format_code_t pformat;
>> >>>>>> +        pformat =3D virtio_gpu_get_pixman_format(res->format);
>> >>>>>> +        CHECK(pformat, cmd);
>> >>>>>> +
>> >>>>>> +        res->image =3D pixman_image_create_bits(pformat,
>> >>>>>> +                                              res->width,
>> >>>>>> +                                              res->height,
>> >>>>>> +                                              NULL, 0);
>> >>>>>> +        CHECK(res->image, cmd);
>> >>>>>> +        pixman_image_ref(res->image);
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    g->parent_obj=2Eenable =3D 1;
>> >>>>>> +
>> >>>>>> +    /* realloc the surface ptr */
>> >>>>>> +    scanout->ds =3D qemu_create_displaysurface_pixman(res->imag=
e);
>> >>>>>> +    dpy_gfx_replace_surface(scanout->con, NULL);
>> >>>>>> +    dpy_gfx_replace_surface(scanout->con, scanout->ds);
>> >>>>>> +    res->scanout_bitmask =3D ss=2Escanout_id;
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +rutabaga_cmd_submit_3d(VirtIOGPU *g,
>> >>>>>> +                       struct virtio_gpu_ctrl_command *cmd)
>> >>>>>> +{
>> >>>>>> +    int32_t result;
>> >>>>>> +    struct virtio_gpu_cmd_submit cs;
>> >>>>>> +    struct rutabaga_command rutabaga_cmd =3D { 0 };
>> >>>>>> +    g_autofree uint8_t *buf =3D NULL;
>> >>>>>> +    size_t s;
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(cs);
>> >>>>>> +    trace_virtio_gpu_cmd_ctx_submit(cs=2Ehdr=2Ectx_id, cs=2Esiz=
e);
>> >>>>>> +
>> >>>>>> +    buf =3D g_new0(uint8_t, cs=2Esize);
>> >>>>>> +    s =3D iov_to_buf(cmd->elem=2Eout_sg, cmd->elem=2Eout_num,
>> >>>>>> +                   sizeof(cs), buf, cs=2Esize);
>> >>>>>> +    CHECK(s =3D=3D cs=2Esize, cmd);
>> >>>>>> +
>> >>>>>> +    rutabaga_cmd=2Ectx_id =3D cs=2Ehdr=2Ectx_id;
>> >>>>>> +    rutabaga_cmd=2Ecmd =3D buf;
>> >>>>>> +    rutabaga_cmd=2Ecmd_size =3D cs=2Esize;
>> >>>>>> +
>> >>>>>> +    result =3D rutabaga_submit_command(vr->rutabaga, &rutabaga_=
cmd);
>> >>>>>> +    CHECK(!result, cmd);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +rutabaga_cmd_transfer_to_host_2d(VirtIOGPU *g,
>> >>>>>> +                                 struct virtio_gpu_ctrl_command
>> *cmd)
>> >>>>>> +{
>> >>>>>> +    int32_t result;
>> >>>>>> +    struct rutabaga_transfer transfer =3D { 0 };
>> >>>>>> +    struct virtio_gpu_transfer_to_host_2d t2d;
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(t2d);
>> >>>>>> +    trace_virtio_gpu_cmd_res_xfer_toh_2d(t2d=2Eresource_id);
>> >>>>>> +
>> >>>>>> +    transfer=2Ex =3D t2d=2Er=2Ex;
>> >>>>>> +    transfer=2Ey =3D t2d=2Er=2Ey;
>> >>>>>> +    transfer=2Ez =3D 0;
>> >>>>>> +    transfer=2Ew =3D t2d=2Er=2Ewidth;
>> >>>>>> +    transfer=2Eh =3D t2d=2Er=2Eheight;
>> >>>>>> +    transfer=2Ed =3D 1;
>> >>>>>> +
>> >>>>>> +    result =3D rutabaga_resource_transfer_write(vr->rutabaga, 0=
,
>> >>>>> t2d=2Eresource_id,
>> >>>>>> +                                              &transfer);
>> >>>>>> +    CHECK(!result, cmd);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +rutabaga_cmd_transfer_to_host_3d(VirtIOGPU *g,
>> >>>>>> +                                 struct virtio_gpu_ctrl_command
>> *cmd)
>> >>>>>> +{
>> >>>>>> +    int32_t result;
>> >>>>>> +    struct rutabaga_transfer transfer =3D { 0 };
>> >>>>>> +    struct virtio_gpu_transfer_host_3d t3d;
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(t3d);
>> >>>>>> +    trace_virtio_gpu_cmd_res_xfer_toh_3d(t3d=2Eresource_id);
>> >>>>>> +
>> >>>>>> +    transfer=2Ex =3D t3d=2Ebox=2Ex;
>> >>>>>> +    transfer=2Ey =3D t3d=2Ebox=2Ey;
>> >>>>>> +    transfer=2Ez =3D t3d=2Ebox=2Ez;
>> >>>>>> +    transfer=2Ew =3D t3d=2Ebox=2Ew;
>> >>>>>> +    transfer=2Eh =3D t3d=2Ebox=2Eh;
>> >>>>>> +    transfer=2Ed =3D t3d=2Ebox=2Ed;
>> >>>>>> +    transfer=2Elevel =3D t3d=2Elevel;
>> >>>>>> +    transfer=2Estride =3D t3d=2Estride;
>> >>>>>> +    transfer=2Elayer_stride =3D t3d=2Elayer_stride;
>> >>>>>> +    transfer=2Eoffset =3D t3d=2Eoffset;
>> >>>>>> +
>> >>>>>> +    result =3D rutabaga_resource_transfer_write(vr->rutabaga,
>> >>>>> t3d=2Ehdr=2Ectx_id,
>> >>>>>> +                                              t3d=2Eresource_id=
,
>> >>>>> &transfer);
>> >>>>>> +    CHECK(!result, cmd);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +rutabaga_cmd_transfer_from_host_3d(VirtIOGPU *g,
>> >>>>>> +                                   struct virtio_gpu_ctrl_comma=
nd
>> >>> *cmd)
>> >>>>>> +{
>> >>>>>> +    int32_t result;
>> >>>>>> +    struct rutabaga_transfer transfer =3D { 0 };
>> >>>>>> +    struct virtio_gpu_transfer_host_3d t3d;
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(t3d);
>> >>>>>> +    trace_virtio_gpu_cmd_res_xfer_fromh_3d(t3d=2Eresource_id);
>> >>>>>> +
>> >>>>>> +    transfer=2Ex =3D t3d=2Ebox=2Ex;
>> >>>>>> +    transfer=2Ey =3D t3d=2Ebox=2Ey;
>> >>>>>> +    transfer=2Ez =3D t3d=2Ebox=2Ez;
>> >>>>>> +    transfer=2Ew =3D t3d=2Ebox=2Ew;
>> >>>>>> +    transfer=2Eh =3D t3d=2Ebox=2Eh;
>> >>>>>> +    transfer=2Ed =3D t3d=2Ebox=2Ed;
>> >>>>>> +    transfer=2Elevel =3D t3d=2Elevel;
>> >>>>>> +    transfer=2Estride =3D t3d=2Estride;
>> >>>>>> +    transfer=2Elayer_stride =3D t3d=2Elayer_stride;
>> >>>>>> +    transfer=2Eoffset =3D t3d=2Eoffset;
>> >>>>>> +
>> >>>>>> +    result =3D rutabaga_resource_transfer_read(vr->rutabaga,
>> >>>>> t3d=2Ehdr=2Ectx_id,
>> >>>>>> +                                             t3d=2Eresource_id,
>> >>> &transfer,
>> >>>>> NULL);
>> >>>>>> +    CHECK(!result, cmd);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +rutabaga_cmd_attach_backing(VirtIOGPU *g, struct
>> >>> virtio_gpu_ctrl_command
>> >>>>> *cmd)
>> >>>>>> +{
>> >>>>>> +    struct rutabaga_iovecs vecs =3D { 0 };
>> >>>>>> +    struct virtio_gpu_simple_resource *res;
>> >>>>>> +    struct virtio_gpu_resource_attach_backing att_rb;
>> >>>>>> +    int ret;
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(att_rb);
>> >>>>>> +    trace_virtio_gpu_cmd_res_back_attach(att_rb=2Eresource_id);
>> >>>>>> +
>> >>>>>> +    res =3D virtio_gpu_find_resource(g, att_rb=2Eresource_id);
>> >>>>>> +    CHECK(res, cmd);
>> >>>>>> +    CHECK(!res->iov, cmd);
>> >>>>>> +
>> >>>>>> +    ret =3D virtio_gpu_create_mapping_iov(g, att_rb=2Enr_entrie=
s,
>> >>>>> sizeof(att_rb),
>> >>>>>> +                                        cmd, NULL, &res->iov,
>> >>>>> &res->iov_cnt);
>> >>>>>> +    CHECK(!ret, cmd);
>> >>>>>> +
>> >>>>>> +    vecs=2Eiovecs =3D res->iov;
>> >>>>>> +    vecs=2Enum_iovecs =3D res->iov_cnt;
>> >>>>>> +
>> >>>>>> +    ret =3D rutabaga_resource_attach_backing(vr->rutabaga,
>> >>>>> att_rb=2Eresource_id,
>> >>>>>> +                                           &vecs);
>> >>>>>> +    if (ret !=3D 0) {
>> >>>>>> +        virtio_gpu_cleanup_mapping(g, res);
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    CHECK(!ret, cmd);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +rutabaga_cmd_detach_backing(VirtIOGPU *g, struct
>> >>> virtio_gpu_ctrl_command
>> >>>>> *cmd)
>> >>>>>> +{
>> >>>>>> +    struct virtio_gpu_simple_resource *res;
>> >>>>>> +    struct virtio_gpu_resource_detach_backing detach_rb;
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(detach_rb);
>> >>>>>> +    trace_virtio_gpu_cmd_res_back_detach(detach_rb=2Eresource_i=
d);
>> >>>>>> +
>> >>>>>> +    res =3D virtio_gpu_find_resource(g, detach_rb=2Eresource_id=
);
>> >>>>>> +    CHECK(res, cmd);
>> >>>>>> +
>> >>>>>> +    rutabaga_resource_detach_backing(vr->rutabaga,
>> >>>>>> +                                     detach_rb=2Eresource_id);
>> >>>>>> +
>> >>>>>> +    virtio_gpu_cleanup_mapping(g, res);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +rutabaga_cmd_ctx_attach_resource(VirtIOGPU *g,
>> >>>>>> +                                 struct virtio_gpu_ctrl_command
>> *cmd)
>> >>>>>> +{
>> >>>>>> +    int32_t result;
>> >>>>>> +    struct virtio_gpu_ctx_resource att_res;
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(att_res);
>> >>>>>> +    trace_virtio_gpu_cmd_ctx_res_attach(att_res=2Ehdr=2Ectx_id,
>> >>>>>> +                                        att_res=2Eresource_id);
>> >>>>>> +
>> >>>>>> +    result =3D rutabaga_context_attach_resource(vr->rutabaga,
>> >>>>> att_res=2Ehdr=2Ectx_id,
>> >>>>>> +                                              att_res=2Eresourc=
e_id);
>> >>>>>> +    CHECK(!result, cmd);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +rutabaga_cmd_ctx_detach_resource(VirtIOGPU *g,
>> >>>>>> +                                 struct virtio_gpu_ctrl_command
>> *cmd)
>> >>>>>> +{
>> >>>>>> +    int32_t result;
>> >>>>>> +    struct virtio_gpu_ctx_resource det_res;
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(det_res);
>> >>>>>> +    trace_virtio_gpu_cmd_ctx_res_detach(det_res=2Ehdr=2Ectx_id,
>> >>>>>> +                                        det_res=2Eresource_id);
>> >>>>>> +
>> >>>>>> +    result =3D rutabaga_context_detach_resource(vr->rutabaga,
>> >>>>> det_res=2Ehdr=2Ectx_id,
>> >>>>>> +                                              det_res=2Eresourc=
e_id);
>> >>>>>> +    CHECK(!result, cmd);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct
>> >>>>> virtio_gpu_ctrl_command *cmd)
>> >>>>>> +{
>> >>>>>> +    int32_t result;
>> >>>>>> +    struct virtio_gpu_get_capset_info info;
>> >>>>>> +    struct virtio_gpu_resp_capset_info resp;
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(info);
>> >>>>>> +
>> >>>>>> +    result =3D rutabaga_get_capset_info(vr->rutabaga,
>> info=2Ecapset_index,
>> >>>>>> +                                      &resp=2Ecapset_id,
>> >>>>> &resp=2Ecapset_max_version,
>> >>>>>> +                                      &resp=2Ecapset_max_size);
>> >>>>>> +    CHECK(!result, cmd);
>> >>>>>> +
>> >>>>>> +    resp=2Ehdr=2Etype =3D VIRTIO_GPU_RESP_OK_CAPSET_INFO;
>> >>>>>> +    virtio_gpu_ctrl_response(g, cmd, &resp=2Ehdr, sizeof(resp))=
;
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +rutabaga_cmd_get_capset(VirtIOGPU *g, struct
>> virtio_gpu_ctrl_command
>> >>>>> *cmd)
>> >>>>>> +{
>> >>>>>> +    int32_t result;
>> >>>>>> +    struct virtio_gpu_get_capset gc;
>> >>>>>> +    struct virtio_gpu_resp_capset *resp;
>> >>>>>> +    uint32_t capset_size, capset_version;
>> >>>>>> +    uint32_t current_id, i;
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(gc);
>> >>>>>> +    for (i =3D 0; i < vr->num_capsets; i++) {
>> >>>>>> +        result =3D rutabaga_get_capset_info(vr->rutabaga, i,
>> >>>>>> +                                          &current_id,
>> >>> &capset_version,
>> >>>>>> +                                          &capset_size);
>> >>>>>> +        CHECK(!result, cmd);
>> >>>>>> +
>> >>>>>> +        if (current_id =3D=3D gc=2Ecapset_id) {
>> >>>>>> +            break;
>> >>>>>> +        }
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    CHECK(i < vr->num_capsets, cmd);
>> >>>>>> +
>> >>>>>> +    resp =3D g_malloc0(sizeof(*resp) + capset_size);
>> >>>>>> +    resp->hdr=2Etype =3D VIRTIO_GPU_RESP_OK_CAPSET;
>> >>>>>> +    rutabaga_get_capset(vr->rutabaga, gc=2Ecapset_id,
>> gc=2Ecapset_version,
>> >>>>>> +                        resp->capset_data, capset_size);
>> >>>>>> +
>> >>>>>> +    virtio_gpu_ctrl_response(g, cmd, &resp->hdr, sizeof(*resp) =
+
>> >>>>> capset_size);
>> >>>>>> +    g_free(resp);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
>> >>>>>> +                                  struct virtio_gpu_ctrl_comman=
d
>> *cmd)
>> >>>>>> +{
>> >>>>>> +    int result;
>> >>>>>> +    struct rutabaga_iovecs vecs =3D { 0 };
>> >>>>>> +    g_autofree struct virtio_gpu_simple_resource *res =3D NULL;
>> >>>>>> +    struct virtio_gpu_resource_create_blob cblob;
>> >>>>>> +    struct rutabaga_create_blob rc_blob =3D { 0 };
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(cblob);
>> >>>>>> +    trace_virtio_gpu_cmd_res_create_blob(cblob=2Eresource_id,
>> >>> cblob=2Esize);
>> >>>>>> +
>> >>>>>> +    CHECK(cblob=2Eresource_id !=3D 0, cmd);
>> >>>>>> +
>> >>>>>> +    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
>> >>>>>> +
>> >>>>>> +    res->resource_id =3D cblob=2Eresource_id;
>> >>>>>> +    res->blob_size =3D cblob=2Esize;
>> >>>>>> +
>> >>>>>> +    if (cblob=2Eblob_mem !=3D VIRTIO_GPU_BLOB_MEM_HOST3D) {
>> >>>>>> +        result =3D virtio_gpu_create_mapping_iov(g, cblob=2Enr_=
entries,
>> >>>>>> +                                               sizeof(cblob), c=
md,
>> >>>>> &res->addrs,
>> >>>>>> +                                               &res->iov,
>> >>> &res->iov_cnt);
>> >>>>>> +        CHECK(!result, cmd);
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    rc_blob=2Eblob_id =3D cblob=2Eblob_id;
>> >>>>>> +    rc_blob=2Eblob_mem =3D cblob=2Eblob_mem;
>> >>>>>> +    rc_blob=2Eblob_flags =3D cblob=2Eblob_flags;
>> >>>>>> +    rc_blob=2Esize =3D cblob=2Esize;
>> >>>>>> +
>> >>>>>> +    vecs=2Eiovecs =3D res->iov;
>> >>>>>> +    vecs=2Enum_iovecs =3D res->iov_cnt;
>> >>>>>> +
>> >>>>>> +    result =3D rutabaga_resource_create_blob(vr->rutabaga,
>> >>>>> cblob=2Ehdr=2Ectx_id,
>> >>>>>> +                                           cblob=2Eresource_id,
>> >>> &rc_blob,
>> >>>>> &vecs,
>> >>>>>> +                                           NULL);
>> >>>>>> +
>> >>>>>> +    if (result && cblob=2Eblob_mem !=3D VIRTIO_GPU_BLOB_MEM_HOS=
T3D) {
>> >>>>>> +        virtio_gpu_cleanup_mapping(g, res);
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    CHECK(!result, cmd);
>> >>>>>> +
>> >>>>>> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>> >>>>>> +    res =3D NULL;
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +rutabaga_cmd_resource_map_blob(VirtIOGPU *g,
>> >>>>>> +                               struct virtio_gpu_ctrl_command *=
cmd)
>> >>>>>> +{
>> >>>>>> +    int32_t result;
>> >>>>>> +    uint32_t map_info =3D 0;
>> >>>>>> +    uint32_t slot =3D 0;
>> >>>>>> +    struct virtio_gpu_simple_resource *res;
>> >>>>>> +    struct rutabaga_mapping mapping =3D { 0 };
>> >>>>>> +    struct virtio_gpu_resource_map_blob mblob;
>> >>>>>> +    struct virtio_gpu_resp_map_info resp =3D { 0 };
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(mblob);
>> >>>>>> +
>> >>>>>> +    CHECK(mblob=2Eresource_id !=3D 0, cmd);
>> >>>>>> +
>> >>>>>> +    res =3D virtio_gpu_find_resource(g, mblob=2Eresource_id);
>> >>>>>> +    CHECK(res, cmd);
>> >>>>>> +
>> >>>>>> +    result =3D rutabaga_resource_map_info(vr->rutabaga,
>> >>> mblob=2Eresource_id,
>> >>>>>> +                                        &map_info);
>> >>>>>> +    CHECK(!result, cmd);
>> >>>>>> +
>> >>>>>> +    /*
>> >>>>>> +     * RUTABAGA_MAP_ACCESS_* flags are not part of the virtio-g=
pu
>> >>> spec,
>> >>>>> but do
>> >>>>>> +     * exist to potentially allow the hypervisor to restrict wr=
ite
>> >>>>> access to
>> >>>>>> +     * memory=2E QEMU does not need to use this functionality a=
t the
>> >>>>> moment=2E
>> >>>>>> +     */
>> >>>>>> +    resp=2Emap_info =3D map_info & RUTABAGA_MAP_CACHE_MASK;
>> >>>>>> +
>> >>>>>> +    result =3D rutabaga_resource_map(vr->rutabaga, mblob=2Ereso=
urce_id,
>> >>>>> &mapping);
>> >>>>>> +    CHECK(!result, cmd);
>> >>>>>> +
>> >>>>>> +    for (slot =3D 0; slot < MAX_SLOTS; slot++) {
>> >>>>>> +        if (vr->memory_regions[slot]=2Eused) {
>> >>>>>> +            continue;
>> >>>>>> +        }
>> >>>>>> +
>> >>>>>> +        MemoryRegion *mr =3D &(vr->memory_regions[slot]=2Emr);
>> >>>>>> +        memory_region_init_ram_ptr(mr, NULL, "blob", mapping=2E=
size,
>> >>>>>> +                                   mapping=2Eptr);
>> >>>>>> +        memory_region_add_subregion(&g->parent_obj=2Ehostmem,
>> >>>>>> +                                    mblob=2Eoffset, mr);
>> >>>>>> +        vr->memory_regions[slot]=2Eresource_id =3D mblob=2Ereso=
urce_id;
>> >>>>>> +        vr->memory_regions[slot]=2Eused =3D 1;
>> >>>>>> +        break;
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    if (slot >=3D MAX_SLOTS) {
>> >>>>>> +        result =3D rutabaga_resource_unmap(vr->rutabaga,
>> >>>>> mblob=2Eresource_id);
>> >>>>>> +        CHECK(!result, cmd);
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    CHECK(slot < MAX_SLOTS, cmd);
>> >>>>>> +
>> >>>>>> +    resp=2Ehdr=2Etype =3D VIRTIO_GPU_RESP_OK_MAP_INFO;
>> >>>>>> +    virtio_gpu_ctrl_response(g, cmd, &resp=2Ehdr, sizeof(resp))=
;
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +rutabaga_cmd_resource_unmap_blob(VirtIOGPU *g,
>> >>>>>> +                                 struct virtio_gpu_ctrl_command
>> *cmd)
>> >>>>>> +{
>> >>>>>> +    int32_t result;
>> >>>>>> +    uint32_t slot =3D 0;
>> >>>>>> +    struct virtio_gpu_simple_resource *res;
>> >>>>>> +    struct virtio_gpu_resource_unmap_blob ublob;
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(ublob);
>> >>>>>> +
>> >>>>>> +    CHECK(ublob=2Eresource_id !=3D 0, cmd);
>> >>>>>> +
>> >>>>>> +    res =3D virtio_gpu_find_resource(g, ublob=2Eresource_id);
>> >>>>>> +    CHECK(res, cmd);
>> >>>>>> +
>> >>>>>> +    for (slot =3D 0; slot < MAX_SLOTS; slot++) {
>> >>>>>> +        if (vr->memory_regions[slot]=2Eresource_id !=3D
>> >>> ublob=2Eresource_id) {
>> >>>>>> +            continue;
>> >>>>>> +        }
>> >>>>>> +
>> >>>>>> +        MemoryRegion *mr =3D &(vr->memory_regions[slot]=2Emr);
>> >>>>>> +        memory_region_del_subregion(&g->parent_obj=2Ehostmem, m=
r);
>> >>>>>> +
>> >>>>>> +        vr->memory_regions[slot]=2Eresource_id =3D 0;
>> >>>>>> +        vr->memory_regions[slot]=2Eused =3D 0;
>> >>>>>> +        break;
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    CHECK(slot < MAX_SLOTS, cmd);
>> >>>>>> +    result =3D rutabaga_resource_unmap(vr->rutabaga,
>> res->resource_id);
>> >>>>>> +    CHECK(!result, cmd);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +virtio_gpu_rutabaga_process_cmd(VirtIOGPU *g,
>> >>>>>> +                                struct virtio_gpu_ctrl_command
>> *cmd)
>> >>>>>> +{
>> >>>>>> +    struct rutabaga_fence fence =3D { 0 };
>> >>>>>> +    int32_t result;
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
>> >>>>>> +
>> >>>>>> +    switch (cmd->cmd_hdr=2Etype) {
>> >>>>>> +    case VIRTIO_GPU_CMD_CTX_CREATE:
>> >>>>>> +        rutabaga_cmd_context_create(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_CTX_DESTROY:
>> >>>>>> +        rutabaga_cmd_context_destroy(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_2D:
>> >>>>>> +        rutabaga_cmd_create_resource_2d(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_3D:
>> >>>>>> +        rutabaga_cmd_create_resource_3d(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_SUBMIT_3D:
>> >>>>>> +        rutabaga_cmd_submit_3d(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D:
>> >>>>>> +        rutabaga_cmd_transfer_to_host_2d(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D:
>> >>>>>> +        rutabaga_cmd_transfer_to_host_3d(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D:
>> >>>>>> +        rutabaga_cmd_transfer_from_host_3d(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING:
>> >>>>>> +        rutabaga_cmd_attach_backing(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:
>> >>>>>> +        rutabaga_cmd_detach_backing(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_SET_SCANOUT:
>> >>>>>> +        rutabaga_cmd_set_scanout(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_FLUSH:
>> >>>>>> +        rutabaga_cmd_resource_flush(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_UNREF:
>> >>>>>> +        rutabaga_cmd_resource_unref(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:
>> >>>>>> +        rutabaga_cmd_ctx_attach_resource(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE:
>> >>>>>> +        rutabaga_cmd_ctx_detach_resource(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_GET_CAPSET_INFO:
>> >>>>>> +        rutabaga_cmd_get_capset_info(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_GET_CAPSET:
>> >>>>>> +        rutabaga_cmd_get_capset(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:
>> >>>>>> +        virtio_gpu_get_display_info(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_GET_EDID:
>> >>>>>> +        virtio_gpu_get_edid(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB:
>> >>>>>> +        rutabaga_cmd_resource_create_blob(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB:
>> >>>>>> +        rutabaga_cmd_resource_map_blob(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:
>> >>>>>> +        rutabaga_cmd_resource_unmap_blob(g, cmd);
>> >>>>>> +        break;
>> >>>>>> +    default:
>> >>>>>> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>> >>>>>> +        break;
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    if (cmd->finished) {
>> >>>>>> +        return;
>> >>>>>> +    }
>> >>>>>> +    if (cmd->error) {
>> >>>>>> +        error_report("%s: ctrl 0x%x, error 0x%x", __func__,
>> >>>>>> +                     cmd->cmd_hdr=2Etype, cmd->error);
>> >>>>>> +        virtio_gpu_ctrl_response_nodata(g, cmd, cmd->error);
>> >>>>>> +        return;
>> >>>>>> +    }
>> >>>>>> +    if (!(cmd->cmd_hdr=2Eflags & VIRTIO_GPU_FLAG_FENCE)) {
>> >>>>>> +        virtio_gpu_ctrl_response_nodata(g, cmd,
>> >>>>> VIRTIO_GPU_RESP_OK_NODATA);
>> >>>>>> +        return;
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    fence=2Eflags =3D cmd->cmd_hdr=2Eflags;
>> >>>>>> +    fence=2Ectx_id =3D cmd->cmd_hdr=2Ectx_id;
>> >>>>>> +    fence=2Efence_id =3D cmd->cmd_hdr=2Efence_id;
>> >>>>>> +    fence=2Ering_idx =3D cmd->cmd_hdr=2Ering_idx;
>> >>>>>> +
>> >>>>>> +    trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr=2Efence_id,
>> >>>>> cmd->cmd_hdr=2Etype);
>> >>>>>> +
>> >>>>>> +    result =3D rutabaga_create_fence(vr->rutabaga, &fence);
>> >>>>>> +    CHECK(!result, cmd);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +virtio_gpu_rutabaga_aio_cb(void *opaque)
>> >>>>>> +{
>> >>>>>> +    struct rutabaga_aio_data *data =3D opaque;
>> >>>>>> +    VirtIOGPU *g =3D VIRTIO_GPU(data->vr);
>> >>>>>> +    struct rutabaga_fence fence_data =3D data->fence;
>> >>>>>> +    struct virtio_gpu_ctrl_command *cmd, *tmp;
>> >>>>>> +
>> >>>>>> +    uint32_t signaled_ctx_specific =3D fence_data=2Eflags &
>> >>>>>> +                                     RUTABAGA_FLAG_INFO_RING_ID=
X;
>> >>>>>> +
>> >>>>>> +    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
>> >>>>>> +        /*
>> >>>>>> +         * Due to context specific timelines=2E
>> >>>>>> +         */
>> >>>>>> +        uint32_t target_ctx_specific =3D cmd->cmd_hdr=2Eflags &
>> >>>>>> +                                       RUTABAGA_FLAG_INFO_RING_=
IDX;
>> >>>>>> +
>> >>>>>> +        if (signaled_ctx_specific !=3D target_ctx_specific) {
>> >>>>>> +            continue;
>> >>>>>> +        }
>> >>>>>> +
>> >>>>>> +        if (signaled_ctx_specific &&
>> >>>>>> +           (cmd->cmd_hdr=2Ering_idx !=3D fence_data=2Ering_idx)=
) {
>> >>>>>> +            continue;
>> >>>>>> +        }
>> >>>>>> +
>> >>>>>> +        if (cmd->cmd_hdr=2Efence_id > fence_data=2Efence_id) {
>> >>>>>> +            continue;
>> >>>>>> +        }
>> >>>>>> +
>> >>>>>> +        trace_virtio_gpu_fence_resp(cmd->cmd_hdr=2Efence_id);
>> >>>>>> +        virtio_gpu_ctrl_response_nodata(g, cmd,
>> >>>>> VIRTIO_GPU_RESP_OK_NODATA);
>> >>>>>> +        QTAILQ_REMOVE(&g->fenceq, cmd, next);
>> >>>>>> +        g_free(cmd);
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    g_free(data);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +virtio_gpu_rutabaga_fence_cb(uint64_t user_data,
>> >>>>>> +                             const struct rutabaga_fence *fence=
) {
>> >>>>>> +    struct rutabaga_aio_data *data;
>> >>>>>> +    VirtIOGPU *g =3D (VirtIOGPU *)user_data;
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +
>> >>>>>> +    /*
>> >>>>>> +     * gfxstream and both cross-domain (and even newer versions
>> >>>>> virglrenderer:
>> >>>>>> +     * see VIRGL_RENDERER_ASYNC_FENCE_CB) like to signal fence
>> >>>>> completion on
>> >>>>>> +     * threads ("callback threads") that are different from the
>> thread
>> >>>>> that
>> >>>>>> +     * processes the command queue ("main thread")=2E
>> >>>>>> +     *
>> >>>>>> +     * crosvm and other virtio-gpu 1=2E1 implementations enable
>> callback
>> >>>>> threads
>> >>>>>> +     * via locking=2E  However, on QEMU a deadlock is observed =
if
>> >>>>>> +     * virtio_gpu_ctrl_response_nodata(=2E=2E) [used in the fen=
ce
>> >>> callback]
>> >>>>> is used
>> >>>>>> +     * from a thread that is not the main thread=2E
>> >>>>>> +     *
>> >>>>>> +     * The reason is QEMU's internal locking is designed to wor=
k
>> with
>> >>>>> QEMU
>> >>>>>> +     * threads (see rcu_register_thread()) and not generic
>> C/C++/Rust
>> >>>>> threads=2E
>> >>>>>> +     * For now, we can workaround this by scheduling the return=
 of
>> the
>> >>>>>> +     * fence descriptors on the main thread=2E
>> >>>>>> +     */
>> >>>>>> +
>> >>>>>> +    data =3D g_new0(struct rutabaga_aio_data, 1);
>> >>>>>> +    data->vr =3D vr;
>> >>>>>> +    data->fence =3D *fence;
>> >>>>>> +    aio_bh_schedule_oneshot(qemu_get_aio_context(),
>> >>>>>> +                            virtio_gpu_rutabaga_aio_cb,
>> >>>>>> +                            data);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static void
>> >>>>>> +virtio_gpu_rutabaga_debug_cb(uint64_t user_data,
>> >>>>>> +                             const struct rutabaga_debug *debug=
) {
>> >>>>>> +
>> >>>>>> +    if (debug->debug_type =3D=3D RUTABAGA_DEBUG_ERROR) {
>> >>>>>> +        error_report("%s", debug->message);
>> >>>>>> +    } else if (debug->debug_type =3D=3D RUTABAGA_DEBUG_WARN) {
>> >>>>>> +        warn_report("%s", debug->message);
>> >>>>>> +    } else if (debug->debug_type =3D=3D RUTABAGA_DEBUG_INFO) {
>> >>>>>> +        info_report("%s", debug->message);
>> >>>>>> +    }
>> >>>>>> +}
>> >>>>>> +
>> >>>>>> +static bool virtio_gpu_rutabaga_init(VirtIOGPU *g, Error **errp=
)
>> >>>>>> +{
>> >>>>>> +    int result;
>> >>>>>> +    uint64_t capset_mask;
>> >>>>>> +    struct rutabaga_builder builder =3D { 0 };
>> >>>>>> +    char wayland_socket_path[UNIX_PATH_MAX];
>> >>>>>> +    struct rutabaga_channel channel =3D { 0 };
>> >>>>>> +    struct rutabaga_channels channels =3D { 0 };
>> >>>>>> +
>> >>>>>> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
>> >>>>>> +    vr->rutabaga =3D NULL;
>> >>>>>> +
>> >>>>>> +    if (!vr->capset_names) {
>> >>>>>> +        error_setg(errp, "a capset name from the virtio-gpu spe=
c is
>> >>>>> required");
>> >>>>>> +        return false;
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    builder=2Ewsi =3D RUTABAGA_WSI_SURFACELESS;
>> >>>>>> +    /*
>> >>>>>> +     * Currently, if WSI is specified, the only valid strings a=
re
>> >>>>> "surfaceless"
>> >>>>>> +     * or "headless"=2E  Surfaceless doesn't create a native wi=
ndow
>> >>>>> surface, but
>> >>>>>> +     * does copy from the render target to the Pixman buffer if=
 a
>> >>>>> virtio-gpu
>> >>>>>> +     * 2D hypercall is issued=2E  Surfacless is the default=2E
>> >>>>>> +     *
>> >>>>>> +     * Headless is like surfaceless, but doesn't copy to the Pi=
xman
>> >>>>> buffer=2E The
>> >>>>>> +     * use case is automated testing environments where there i=
s no
>> >>> need
>> >>>>> to view
>> >>>>>> +     * results=2E
>> >>>>>> +     *
>> >>>>>> +     * In the future, more performant virtio-gpu 2D UI integrat=
ion
>> may
>> >>>>> be added=2E
>> >>>>>> +     */
>> >>>>>> +    if (vr->wsi) {
>> >>>>>> +        if (g_str_equal(vr->wsi, "surfaceless")) {
>> >>>>>> +            vr->headless =3D false;
>> >>>>>> +        } else if (g_str_equal(vr->wsi, "headless")) {
>> >>>>>> +            vr->headless =3D true;
>> >>>>>> +        } else {
>> >>>>>> +            error_setg(errp, "invalid wsi option selected");
>> >>>>>> +            return false;
>> >>>>>> +        }
>> >>>>>> +    }
>> >>>>>> +
>> >>>>>> +    result =3D rutabaga_calculate_capset_mask(vr->capset_names,
>> >>>>> &capset_mask);
>> >>>>>
>> >>>>> First, sorry for responding after such a long time=2E I've been b=
usy
>> with
>> >>>>> work and I'm doing QEMU in my free time=2E
>> >>>>>
>> >>>>> In iteration 1 I've raised the topic on capset_names [1] and I
>> haven't
>> >>>>> seen it answered properly=2E Perhaps I need to rephrase a bit so =
here
>> we
>> >>> go:
>> >>>>> capset_names seems to be colon-separated list of bit options mana=
ged
>> by
>> >>>>> rutabaga=2E This introduces yet another way of options handling=
=2E There
>> >>> have
>> >>>>> been talks about harmonizing options handling in QEMU since
>> apparently
>> >>> it
>> >>>>> is considered too complex [2,3]=2E
>> >>>>
>> >>>>
>> >>>>> Why not pass the "capset" as a bitfield like capset_mask and have
>> QEMU
>> >>>>> create "capset" from QOM properties?
>> >>>>
>> >>>> IIUC these flags could come from virtio_gpu=2Eh which is already
>> present in
>> >>>>> the QEMU tree=2E This would not inly shortcut the dependency on
>> rutabaga
>> >>> here
>> >>>>> but would also be more idiomatic QEMU (since it makes the options
>> more
>> >>>>> introspectable by internal machinery)=2E
>> >>>>
>> >>>>
>> >>>>> Of course the bitfield approach would require modifications in QE=
MU
>> >>>>> whenever rutabaga gains new features=2E However, I figure that in=
 the
>> long
>> >>>>> term rutabaga will be quite feature complete such that the benefi=
ts
>> of
>> >>>>> idiomatic QEMU handling will outweigh the decoupling of the proje=
cts=2E
>> >>>>>
>> >>>>> What do you think?
>> >>>>>
>> >>>>
>> >>>> I think what you're suggesting is something like -device
>> >>>> virtio-gpu-rutabaga,capset_mask=3D0x10100 [40, which would be
>> >>>> gfxstream_vulkan + cross_domain]?
>> >>>
>> >>> I was thinking more along the lines of
>> >>> `virtio-gpu-rutabaga,gfxstream_vulkan=3Don,cross_domain=3Don` where
>> >>> gfxstream_vulkan and cross_domain are boolean QOM properties=2E Thi=
s
>> would
>> >>> make for a human-readable format which follows QEMU style=2E
>> >>>
>> >>>>
>> >>>> We actually did consider something like that when adding the
>> >>>> --context-types flag [with crosvm], but there was a desire for a
>> >>>> human-readable format rather than numbers [even if they are in the
>> >>>> virtio-gpu spec]=2E
>> >>>>
>> >>>> Additionally, there are quite a few context types that people are
>> playing
>> >>>> around with [gfxstream-gles, gfxstream-composer] that are launchab=
le
>> and
>> >>>> aren't in the spec just yet=2E
>> >>>
>> >>> Right, QEMU had to be modified for this kind of experimentation=2E =
I
>> >>> considered this in my last paragraph and figured that in the long r=
un
>> QEMU
>> >>> *may* prefer more idiomatic option handling since it tries hard to =
not
>> >>> break its command line interface=2E I'm just pointing this out -- t=
he
>> >>> decision is ultimately up to the community=2E
>> >>>
>> >>> Why not have dedicated QEMU development branches for experimentatio=
n?
>> >>> Wouldn't upstreaming new features into QEMU be a good motivation to
>> get the
>> >>> missing pieces into the spec, once they are mature?
>> >>
>> >>
>> >>>>
>> >>>> Also, a key feature we want to explicitly **not** turn on all
>> available
>> >>>> context-types and let the user decide=2E
>> >>>
>> >>> How would you prevent that with the current colon-separated approac=
h?
>> >>> Splitting capset_mask in multiple parameters is just a different
>> >>> syntactical representation of the same thing=2E
>> >>>
>> >>>> That'll allow guest Mesa in
>> >>>> particular to do its magic in its loader=2E  So one may run Zink +=
 ANV
>> with
>> >>>> ioctl forwarding, or Iris + ioctl forwarding and compare performan=
ce
>> with
>> >>>> the same guest image=2E
>> >>>>
>> >>>> And another thing is one needs some knowledge of the host system t=
o
>> choose
>> >>>> the right context type=2E  You wouldn't do Zink + ANV ioctl forwar=
ding
>> on
>> >>>> MacOS=2E  So I think the task of choosing the right context type w=
ill
>> fall
>> >>> to
>> >>>> projects that depend on QEMU (such as Android Emulator) which have
>> some
>> >>>> knowledge of the host environment=2E
>> >>>>
>> >>>> We actually have a graphics detector somewhere that calls VK/OpenG=
L
>> before
>> >>>> launching the VM and sets the right options=2E  Plan is to port in=
to
>> >>>> gfxstream, maybe we could use that=2E
>> >>>
>> >>> You could bail out in QEMU if rutabaga_calculate_capset_mask() dete=
cts
>> >>> conflicting combinations, no?
>> >>>
>> >>>>
>> >>>> So given the desire for human readable formats, being portable acr=
oss
>> VMMs
>> >>>> (crosvm, qemu, rust-vmm??) and experimentation, the string -> caps=
et
>> mask
>> >>>> conversion was put in the rutabaga API=2E  So I wouldn't change it=
 for
>> those
>> >>>> reasons=2E
>> >>>
>> >>> What do you mean by being portable across VMMs?
>> >>
>> >>
>> >> Having the API inside rutabaga is (mildly) useful when multiple VMMs
>> have
>> >> the need to translate from a human-readable format to flags digestib=
le
>> by
>> >> rutabaga=2E
>> >>
>> >>
>> https://android=2Egooglesource=2Ecom/device/google/cuttlefish/+/refs/he=
ads/main/host/libs/vm_manager/qemu_manager=2Ecpp#452
>> >>
>> >>
>> https://android=2Egooglesource=2Ecom/device/google/cuttlefish/+/refs/he=
ads/main/host/libs/vm_manager/crosvm_manager=2Ecpp#353
>> >>
>> >>
>> https://chromium=2Egooglesource=2Ecom/chromiumos/platform2/+/refs/heads=
/main/vm_tools/concierge/vm_builder=2Ecc#505
>> >>
>> >> For these crosvm/qemu launchers, I imagine capset names will be plum=
bed
>> all
>> >> the way through eventually (launch_cvd
>> >> --gpu_context=3Dgfxstream-vulkan:cross-domain if you've played aroun=
d with
>> >> Cuttlefish, or vmc start --gpu_contexts=3Dgfxstream-vulkan if you pl=
ayed
>> >> around with Termina VMs)=2E
>> >>
>> >> I think rust-vmm could also use the same API ("--capset_names") too=
=2E
>> >>
>> >>
>> >>> Sure, QEMU had to be taught new flags before being able to use new
>> >>> rutabaga features=2E I agree that this comes with a certain
>> inconvenience=2E
>> >>> But it may also be inconvenient for QEMU to deal with additional ad=
-hoc
>> >>> options parsing when there are efforts for harmonization=2E
>> >>>
>> >>> Did my comments shed new light into the discussion?
>> >>
>> >>
>> >> Yes, they do=2E  I agree with you that both crosvm/qemu have too man=
y
>> flags,
>> >> and having a stable command line interface is important=2E  We are a=
iming
>> for
>> >> stability with the `--capset_names=3D{colon string}` command line, a=
nd at
>> >> least for crosvm looking to deprecate older options [since we've nev=
er
>> had
>> >> an official release of crosvm yet]=2E
>> >>
>> >> I do think:
>> >>
>> >> 1) "capset_names=3Dgfxstream-vulkan:cross-domain"
>> >> 2) "cross-domain=3Don,gfxstream-vulkan=3Don"
>> >>
>> >> are similar enough=2E  I would choose (1) for since I think not
>> duplicating
>> >> the [name] -> flag logic and having a similar interface across VMMs =
+
>> VMM
>> >> launchers is ever-so slightly useful=2E
>> >
>> > I think we've now reached a good understanding of the issue=2E It's n=
ow up
>> to the QEMU community to make a choice=2E So I'm cc'ing Markus and Thom=
as as
>> the experts of the topic=2E
>>
>> As a virtio-gpu user, I'm slightly inclined to (2) since it would be
>> easier to implement the same option for virtio-gpu-virgl when a need
>> arises=2E
>>
>
>The rutabaga/virgl implementations will likely be done via DEFINE_PROP_BI=
T,
>no?  For virgl, it'll set the virgl flags, and for rutabaga, it'll set th=
e
>capset mask=2E  So it would be different=2E
>
>That said, the change isn't too bad to make=2E  Here's the key part:
>
>+++ b/hw/display/virtio-gpu-rutabaga=2Ec
>@@ -1084,6 +1084,14 @@ static Property virtio_gpu_rutabaga_properties[] =
=3D {
>     DEFINE_PROP_STRING("wayland_socket_path", VirtIOGPURutabaga,
>                        wayland_socket_path),
>     DEFINE_PROP_STRING("wsi", VirtIOGPURutabaga, wsi),
>+    DEFINE_PROP_BIT("gfxstream-vulkan-experimental", VirtIOGPURutabaga,
>+                    capset_mask, RUTABAGA_CAPSET_GFXSTREAM_VULKAN, false=
),
>+    DEFINE_PROP_BIT("cross-domain-experimental", VirtIOGPURutabaga,
>+                    capset_mask, RUTABAGA_CAPSET_CROSS_DOMAIN, false),
>+    DEFINE_PROP_BIT("gfxstream-gles-experimental", VirtIOGPURutabaga,
>+                    capset_mask, RUTABAGA_CAPSET_GFXSTREAM_GLES, false),
>+    DEFINE_PROP_BIT("gfxstream-composer-experimental", VirtIOGPURutabaga=
,
>+                    capset_mask, RUTABAGA_CAPSET_GFXSTREAM_COMPOSER,
>false),
>     DEFINE_PROP_END_OF_LIST(),
> };

Nice!

I think the current approach for experimental and deprecated properties is=
 to not pre- or postfix them but issue a warning at runtime when used, see =
e=2Eg=2E here: https://lore=2Ekernel=2Eorg/qemu-devel/20230710121543=2E1972=
50-18-thuth@redhat=2Ecom/ That way, the command line interface won't change=
 once the properties become stable=2E So if you omit the "-experimental" po=
stfixes Android Studio wouldn't need to adapt=2E

Best regards,
Bernhard

>
>One thing though: I borrowed a page of the Mesa-3d playbook (since they
>land non-working/experimental drivers to speed development) and named all
>gfxstream/rutabaga_gfx context types as "experimental"=2E  That'll allow =
us
>to experiment in-tree=2E
>
>If you closely follow:
>
>https://lists=2Egnu=2Eorg/archive/html/qemu-devel/2023-09/msg03319=2Ehtml
>
>you may notice packaging/distributing rutabaga/gfxstream is low-priority,
>since I do have the Android emulator use case in mind and I'm not sure
>anybody else will find production targets for it in QEMU=2E  I think this=
 is
>somewhat closely related to crosvm/qemu has "too many flags" situation=2E
>Many times a flag/config is landed, and production target changes, and th=
e
>history is lost=2E  By prefixing everything as "experimental", we explici=
tly
>make it clear that QEMU makes no guarantees at this time regarding
>rutabaga=2E  That'll allow hobbyists who build QEMU from sources anyways =
(the
>main non-Android users of rutabaga/gfxstream) to play around with it
>upstream, and also allow downstream to follow upstream but not make any
>guarantees until everything is ready=2E
>
>I'm curious what everyone thinks of the plan=2E

