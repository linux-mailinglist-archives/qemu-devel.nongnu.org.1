Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F0B7937AE
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:05:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdoTZ-0004X3-RL; Wed, 06 Sep 2023 05:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qdoTY-0004W1-17
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:05:28 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qdoTV-0003Bs-5e
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1W2HlbO0LStYmWEs+r+HN1/v/nxuxkDws3VwtTVhUsA=; b=Fl+3QjhoZFIFs7xUm8Cx4HieGo
 UflBR3y4jY2nac6N0BCywBIaiH0kRiY9ghPKZfRZ3Dpp+rqG0F4stZHeIWi7ZJLT3X47nN3GAa87e
 /sV+lAzjCQ6m/vGoYp9cczdHKKi7gZKRTQx0Kg34MreN0AWxgejsIpNeEoIbew9Yox++rRI5tY7p8
 we7HWsT/VdSG3gXfZnbFDFRnOYcnpo5DLRPSgZKa7rNNUIIVkkTiT41XYVLRJWu8Nk1TnAPo0zZ7u
 gqUemecpr5fKQCmxJJe0FXhr5rROgkUQ2fdws/5n2WRYNq3EgIbiTF6bO0zfi+LtM0Dlx2gTYqnQW
 9ulLPrtc/3Cs2aE73KHCzo2lx2GGOG2AtBVAxp+2aWfzKjDjlDY685YT2QtSWfsHShIiMtuJwKZRx
 KVQBUCT5cMhSW+FUt15CLmeNvBjRkU6IAgeAd/2sQW4G8n0QEF+FQYjev1bTjT8RfGgTbCIJRVeuX
 EOr/blVEDTyEC6v1XJdeFUAID5ilBGexNXm2aXt67w65Wk/Bpp6YwsBjCTUN0z/BZv7k/Sx1ctRUX
 eM7sVOIg9xtilKfWmhHNC+m+h0KiEpN+aXnVx+Sp2hc+JqnsepA21fchRkJ3iQZf7ltkx6Haw/hRG
 CjKfeUxq6usxe4Q03IxRs7XnWPzRoaq5Wqq5+9SWk=;
Received: from host81-158-188-207.range81-158.btcentralplus.com
 ([81.158.188.207] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qdoSp-0004kC-MU; Wed, 06 Sep 2023 10:04:47 +0100
Message-ID: <ad47feac-e843-82d0-919f-e0ab44bfb33c@ilande.co.uk>
Date: Wed, 6 Sep 2023 10:05:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
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
 =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <8de966a86bc21358528eeee66ffe74f8a82bb687.1693252037.git.manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <8de966a86bc21358528eeee66ffe74f8a82bb687.1693252037.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 81.158.188.207
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v8 02/12] Add virtio-sound-pci device
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 28/08/2023 20:54, Emmanouil Pitsidianakis wrote:

Hi Emmanouil,

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
> 
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index 120d4bfa0a..5e5a83a4ee 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -63,6 +63,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SERIAL', if_true: files('virtio-serial-pc
>   virtio_pci_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem-pci.c'))
>   virtio_pci_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu-pci.c'))
>   virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem-pci.c'))
> +virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SND', if_true: files('virtio-snd-pci.c'))
>   virtio_pci_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev-pci.c'))
>   virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MD', if_true: files('virtio-md-pci.c'))
>   
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
> +#include "hw/audio/soundhw.h"
> +#include "hw/virtio/virtio-pci.h"
> +#include "hw/virtio/virtio-snd.h"
> +
> +typedef struct VirtIOSoundPCI VirtIOSoundPCI;

You can drop the typedef here.

> +/*
> + * virtio-snd-pci: This extends VirtioPCIProxy.
> + */
> +#define TYPE_VIRTIO_SND_PCI "virtio-sound-pci"
> +DECLARE_INSTANCE_CHECKER(VirtIOSoundPCI, VIRTIO_SND_PCI,
> +                         TYPE_VIRTIO_SND_PCI)

and you should be able to use OBJECT_DECLARE_SIMPLE_TYPE() here instead.

> +struct VirtIOSoundPCI {
> +    VirtIOPCIProxy parent;

This should be parent_obj, followed by an empty line (see 
https://qemu.readthedocs.io/en/master/devel/style.html#qemu-object-model-declarations).

> +    VirtIOSound vdev;
> +};
> +
> +static Property virtio_snd_pci_properties[] = {
> +    DEFINE_AUDIO_PROPERTIES(VirtIOSoundPCI, vdev.card),
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


ATB,

Mark.


