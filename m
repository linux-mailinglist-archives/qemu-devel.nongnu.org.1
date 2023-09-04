Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B5279116C
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 08:34:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd38u-0008QT-Sx; Mon, 04 Sep 2023 02:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qd38s-0008Ph-0l
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 02:32:58 -0400
Received: from mailout02.t-online.de ([194.25.134.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qd38o-000264-Uf
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 02:32:57 -0400
Received: from fwd84.aul.t-online.de (fwd84.aul.t-online.de [10.223.144.110])
 by mailout02.t-online.de (Postfix) with SMTP id 60BF99548;
 Mon,  4 Sep 2023 08:32:50 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.25.148]) by fwd84.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qd38j-2JEpVp0; Mon, 4 Sep 2023 08:32:49 +0200
Message-ID: <99c231b8-8447-93a7-6a94-3a68921190ae@t-online.de>
Date: Mon, 4 Sep 2023 08:32:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v8 02/12] Add virtio-sound-pci device
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <8de966a86bc21358528eeee66ffe74f8a82bb687.1693252037.git.manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
In-Reply-To: <8de966a86bc21358528eeee66ffe74f8a82bb687.1693252037.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1693809169-0BFFC649-3C02F2D4/0/0 CLEAN NORMAL
X-TOI-MSGID: 74900b1d-610b-435e-8d3c-bf77945e6fa6
Received-SPF: none client-ip=194.25.134.17; envelope-from=vr_qemu@t-online.de;
 helo=mailout02.t-online.de
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

> This patch adds a PCI wrapper device for the virtio-sound device.
> It is necessary to instantiate a virtio-snd device in a guest.
> All sound logic will be added to the virtio-snd device in the following
> commits.
>
> To add this device with a guest, you'll need a >=5.13 kernel compiled
> with CONFIG_SND_VIRTIO=y, which at the time of writing most distros have
> off by default.
>
> Use with following flags in the invocation:
>
> Pulseaudio:
>    -audio driver=pa,model=virtio
>    or
>    -audio driver=pa,model=virtio,server=/run/user/1000/pulse/native
> sdl:
>    -audio driver=sdl,model=virtio
> coreaudio (macos/darwin):
>    -audio driver=coreaudio,model=virtio
> etc.
>
> Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/virtio/meson.build      |  1 +
>   hw/virtio/virtio-snd-pci.c | 97 ++++++++++++++++++++++++++++++++++++++
>   softmmu/qdev-monitor.c     |  1 +
>   3 files changed, 99 insertions(+)
>   create mode 100644 hw/virtio/virtio-snd-pci.c

> diff --git a/hw/virtio/virtio-snd-pci.c b/hw/virtio/virtio-snd-pci.c
> new file mode 100644
> index 0000000000..a6a530d161
> --- /dev/null
> +++ b/hw/virtio/virtio-snd-pci.c
> @@ -0,0 +1,97 @@
> +/*
> + * VIRTIO Sound Device PCI Bindings
> + *
> + * Copyright (c) 2023 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"

Hi Manos,

the macro definition of DECLARE_INSTANCE_CHECKER is in the qom/object.h 
header file. It's better to include it directly than to rely on another 
header file to include it.

> +#include "hw/audio/soundhw.h"
> +#include "hw/virtio/virtio-pci.h"
> +#include "hw/virtio/virtio-snd.h"
> +
> +typedef struct VirtIOSoundPCI VirtIOSoundPCI;
> +
> +/*
> + * virtio-snd-pci: This extends VirtioPCIProxy.
> + */
> +#define TYPE_VIRTIO_SND_PCI "virtio-sound-pci"
> +DECLARE_INSTANCE_CHECKER(VirtIOSoundPCI, VIRTIO_SND_PCI,
> +                         TYPE_VIRTIO_SND_PCI)
> +
> +struct VirtIOSoundPCI {
> +    VirtIOPCIProxy parent;
> +    VirtIOSound vdev;
> +};
> +
> +static Property virtio_snd_pci_properties[] = {
> +    DEFINE_AUDIO_PROPERTIES(VirtIOSoundPCI, vdev.card),

I think DEFINE_AUDIO_PROPERTIES should be moved back to virtio-snd.c. 
The audiodev property is a virtio-sound property and not a 
virtio-sound-pci property.

> +    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
> +                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
> +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
> +                       DEV_NVECTORS_UNSPECIFIED),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void virtio_snd_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> +{
> +    VirtIOSoundPCI *dev = VIRTIO_SND_PCI(vpci_dev);
> +    DeviceState *vdev = DEVICE(&dev->vdev);
> +
> +    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> +        vpci_dev->nvectors = 2;
> +    }

Why do you need that intermediate step with DEV_NVECTORS_UNSPECIFIED? 
Unlike e.g. virtio-scsi-pci and virtio-net-pci devices, the default 
value of nvectors is already known at compile time and can be specified 
in the property definition.

With best regards,
Volker

> +
> +    virtio_pci_force_virtio_1(vpci_dev);
> +    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> +}
> +
> +static void virtio_snd_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioPCIClass *vpciklass = VIRTIO_PCI_CLASS(klass);
> +
> +    device_class_set_props(dc, virtio_snd_pci_properties);
> +    dc->desc = "Virtio Sound";
> +    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
> +
> +    vpciklass->realize = virtio_snd_pci_realize;
> +}
> +
> +static void virtio_snd_pci_instance_init(Object *obj)
> +{
> +    VirtIOSoundPCI *dev = VIRTIO_SND_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_SND);
> +}
> +
> +static const VirtioPCIDeviceTypeInfo virtio_snd_pci_info = {
> +    .generic_name  = TYPE_VIRTIO_SND_PCI,
> +    .instance_size = sizeof(VirtIOSoundPCI),
> +    .instance_init = virtio_snd_pci_instance_init,
> +    .class_init    = virtio_snd_pci_class_init,
> +};
> +
> +/* Create a Virtio Sound PCI device, so '-audio driver,model=virtio' works. */
> +static int virtio_snd_pci_init(PCIBus *bus, const char *audiodev)
> +{
> +    DeviceState *dev;
> +
> +    dev = qdev_new(TYPE_VIRTIO_SND_PCI);
> +    qdev_prop_set_string(dev, "audiodev", audiodev);
> +    qdev_realize_and_unref(dev, BUS(bus), &error_fatal);
> +    return 0;
> +}
> +
> +static void virtio_snd_pci_register(void)
> +{
> +    virtio_pci_types_register(&virtio_snd_pci_info);
> +    pci_register_soundhw("virtio", "Virtio Sound", virtio_snd_pci_init);
> +}
> +
> +type_init(virtio_snd_pci_register);
> diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
> index 74f4e41338..2e9835ad88 100644
> --- a/softmmu/qdev-monitor.c
> +++ b/softmmu/qdev-monitor.c
> @@ -108,6 +108,7 @@ static const QDevAlias qdev_alias_table[] = {
>       { "virtio-serial-device", "virtio-serial", QEMU_ARCH_VIRTIO_MMIO },
>       { "virtio-serial-ccw", "virtio-serial", QEMU_ARCH_VIRTIO_CCW },
>       { "virtio-serial-pci", "virtio-serial", QEMU_ARCH_VIRTIO_PCI},
> +    { "virtio-sound-pci", "virtio-sound", QEMU_ARCH_VIRTIO_PCI},
>       { "virtio-tablet-device", "virtio-tablet", QEMU_ARCH_VIRTIO_MMIO },
>       { "virtio-tablet-ccw", "virtio-tablet", QEMU_ARCH_VIRTIO_CCW },
>       { "virtio-tablet-pci", "virtio-tablet", QEMU_ARCH_VIRTIO_PCI },


