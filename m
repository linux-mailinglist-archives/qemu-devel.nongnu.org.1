Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F01781D0C
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 11:09:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXeQA-0007Wg-A4; Sun, 20 Aug 2023 05:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qXeQ7-0007WK-0f
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 05:08:27 -0400
Received: from mailout10.t-online.de ([194.25.134.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qXeQ3-0002Vk-J9
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 05:08:26 -0400
Received: from fwd86.aul.t-online.de (fwd86.aul.t-online.de [10.223.144.112])
 by mailout10.t-online.de (Postfix) with SMTP id E462C177FD;
 Sun, 20 Aug 2023 11:08:19 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.21.165]) by fwd86.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qXePv-2Ekp4D0; Sun, 20 Aug 2023 11:08:15 +0200
Message-ID: <68e2c982-c1d2-42b6-f380-380cf23ddc18@t-online.de>
Date: Sun, 20 Aug 2023 11:08:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH v6 02/12] Add virtio-sound-pci device
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
 <8f996f9aedcace74622ceb8963039627d7fd1120.1692089917.git.manos.pitsidianakis@linaro.org>
Content-Language: en-US
In-Reply-To: <8f996f9aedcace74622ceb8963039627d7fd1120.1692089917.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1692522495-EBFE5EBC-07A0EBEF/0/0 CLEAN NORMAL
X-TOI-MSGID: d6415372-2d22-4c99-8ec0-9030305b1d4a
Received-SPF: none client-ip=194.25.134.21; envelope-from=vr_qemu@t-online.de;
 helo=mailout10.t-online.de
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.862, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
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

Hi Manos,

I see a core dump with this code on my host. I don't use the -audio 
command line argument and the audiodev_id variable is NULL. You can't 
use a global audiodev_id variable because each guest can have more than 
one virtio-sound-pci device and each virtio-sound-pci device may be 
connected to a different audio backend device.

(gdb) r
Starting program: 
/home/ruemelin/rpmbuild/BUILD/qemu-8.0.50-build/qemu-system-x86_64 
-machine q35 -device virtio-sound-pci,audiodev=audio0 -audiodev 
pipewire,out.frequency=48000,in.frequency=48000,id=audio0

Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x00007ffff1987dd1 in __strlen_avx2 () from /lib64/libc.so.6

(gdb) bt
#0  0x00007ffff1987dd1 in __strlen_avx2 () at /lib64/libc.so.6
#1  0x0000555555e19afd in qstring_from_str (str=0x0) at 
../qemu-master/qobject/qstring.c:50
#2  0x0000555555cb254c in object_property_set_str
     (obj=obj@entry=0x555557d3db30, name=name@entry=0x555555fea6b9 
"audiodev", value=<optimized out>, errp=0x5555567b4580 <error_abort>) at 
../qemu-master/qom/object.c:1427
#3  0x0000555555caa84c in qdev_prop_set_string
     (dev=dev@entry=0x555557d3db30, name=name@entry=0x555555fea6b9 
"audiodev", value=<optimized out>)
     at ../qemu-master/hw/core/qdev-properties.c:729
#4  0x0000555555c3e8d1 in virtio_snd_pci_realize 
(vpci_dev=0x555557d35760, errp=0x7fffffffd750)
     at ../qemu-master/hw/virtio/virtio-snd-pci.c:48
#5  0x00005555559d0549 in pci_qdev_realize (qdev=<optimized out>, 
errp=<optimized out>) at ../qemu-master/hw/pci/pci.c:2124
#6  0x0000555555cabad3 in device_set_realized (obj=<optimized out>, 
value=<optimized out>, errp=0x7fffffffd980)
     at ../qemu-master/hw/core/qdev.c:510
#7  0x0000555555caf4f6 in property_set_bool
     (obj=0x555557d35760, v=<optimized out>, name=<optimized out>, 
opaque=0x55555690f5f0, errp=0x7fffffffd980)
     at ../qemu-master/qom/object.c:2285
#8  0x0000555555cb2124 in object_property_set
      (obj=obj@entry=0x555557d35760, name=name@entry=0x555555f9d929 
"realized", v=v@entry=0x555557d3fdc0, errp=errp@entry=0x7fffffffd980) at 
../qemu-master/qom/object.c:1420
#9  0x0000555555cb5370 in object_property_set_qobject
     (obj=obj@entry=0x555557d35760, name=name@entry=0x555555f9d929 
"realized", value=value@entry=0x555557d3ec50, 
errp=errp@entry=0x7fffffffd980) at ../qemu-master/qom/qom-qobject.c:28
#10 0x0000555555cb2705 in object_property_set_bool
     (obj=obj@entry=0x555557d35760, name=name@entry=0x555555f9d929 
"realized", value=value@entry=true, errp=errp@entry=0x7fffffffd980--) at 
../qemu-master/qom/object.c:1489
#11 0x0000555555cac42e in qdev_realize (dev=dev@entry=0x555557d35760, 
bus=bus@entry=0x555556d96610, errp=errp@entry=0x7fffffffd980) at 
../qemu-master/hw/core/qdev.c:292
#12 0x0000555555a89917 in qdev_device_add_from_qdict 
(opts=opts@entry=0x555557d34740, from_json=from_json@entry=false, 
errp=0x7fffffffd980, errp@entry=0x5555567b4578 <error_fatal>) at 
../qemu-master/softmmu/qdev-monitor.c:715
#13 0x0000555555a89a42 in qdev_device_add (opts=0x55555690bb80, 
errp=errp@entry=0x5555567b4578 <error_fatal>) at 
../qemu-master/softmmu/qdev-monitor.c:734
#14 0x0000555555a8e0ef in device_init_func (opaque=<optimized out>, 
opts=<optimized out>, errp=0x5555567b4578 <error_fatal>) at 
../qemu-master/softmmu/vl.c:1153
#15 0x0000555555e2d6f2 in qemu_opts_foreach (list=<optimized out>, 
func=func@entry=0x555555a8e0e0 <device_init_func>, 
opaque=opaque@entry=0x0, errp=errp@entry=0x5555567b4578 <error_fatal>) 
at ../qemu-master/util/qemu-option.c:1135
#16 0x0000555555a9087a in qemu_create_cli_devices () at 
../qemu-master/softmmu/vl.c:2577
#17 qmp_x_exit_preconfig (errp=<optimized out>) at 
../qemu-master/softmmu/vl.c:2645
#18 0x0000555555a9433b in qmp_x_exit_preconfig (errp=<optimized out>) at 
../qemu-master/softmmu/vl.c:2639
#19 qemu_init (argc=<optimized out>, argv=<optimized out>) at 
../qemu-master/softmmu/vl.c:3663
#20 0x0000555555888959 in main (argc=<optimized out>, argv=<optimized 
out>) at ../qemu-master/softmmu/main.c:47

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
>    -device virtio-sound-pci,disable-legacy=on

virtio-legacy should be disabled in the virtio-snd-pci.c code.

> And an audio backend listed with `-audio driver=help` that works on
> your host machine, e.g.:
>
> Pulseaudio:
>    -audio driver=pa,model=virtio-sound
>    or
>    -audio driver=pa,model=virtio-sound,server=/run/user/1000/pulse/native
> sdl:
>    -audio driver=sdl,model=virtio-sound
> coreaudio (macos/darwin):
>    -audio driver=coreaudio,model=virtio-sound
> etc.
>
> Signed-off-by: Emmanouil Pitsidianakis<manos.pitsidianakis@linaro.org>
> ---
>   hw/virtio/meson.build      |  1 +
>   hw/virtio/virtio-snd-pci.c | 91 ++++++++++++++++++++++++++++++++++++++
>   include/hw/pci/pci.h       |  1 +
>   softmmu/qdev-monitor.c     |  1 +
>   4 files changed, 94 insertions(+)
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
> index 0000000000..53070b85f6
> --- /dev/null
> +++ b/hw/virtio/virtio-snd-pci.c
> @@ -0,0 +1,91 @@
> +/*
> + * VIRTIO Sound Device PCI Bindings
> + *
> + * Copyright (c) 2023 Emmanouil Pitsidianakis<manos.pitsidianakis@linaro.org>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/audio/soundhw.h"
> +#include "hw/virtio/virtio-pci.h"
> +#include "hw/virtio/virtio-snd.h"

+#include "qapi/error.h"
+#include "qom/object.h"

> +
> +typedef struct VirtIOSoundPCI VirtIOSoundPCI;
> +
> +/*
> + * virtio-snd-pci: This extends VirtioPCIProxy.

- * virtio-snd-pci: This extends VirtioPCIProxy.
+ * virtio-sound-pci: This extends VirtioPCIProxy.

> + */
> +#define TYPE_VIRTIO_SND_PCI "virtio-sound-pci-base"
> +DECLARE_INSTANCE_CHECKER(VirtIOSoundPCI, VIRTIO_SOUND_PCI,
> +                         TYPE_VIRTIO_SND_PCI)

-#define TYPE_VIRTIO_SND_PCI "virtio-sound-pci-base"
-DECLARE_INSTANCE_CHECKER(VirtIOSoundPCI, VIRTIO_SOUND_PCI,
-                         TYPE_VIRTIO_SND_PCI)
+#define TYPE_VIRTIO_SND_PCI "virtio-sound-pci"
+DECLARE_INSTANCE_CHECKER(VirtIOSoundPCI, VIRTIO_SND_PCI, TYPE_VIRTIO_SND_PCI)

The virtio-pci code creates a base type automatically.

> +
> +struct VirtIOSoundPCI {
> +    VirtIOPCIProxy parent;
> +    VirtIOSound vdev;
> +};
> +
> +static Property virtio_snd_pci_properties[] = {

+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),

You should advertize MSI vectors. I think MSI is the recommended way for 
PCI to raise interrupts. The Linux virtio sound device code uses 2 MSIs.

> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static const char *audiodev_id;
> +
> +static int virtio_snd_init_pci(PCIBus *init_bus, const char *audiodev)
> +{
> +    audiodev_id = audiodev;
> +    return 0;
> +}
> +

-static const char *audiodev_id;
-
-static int virtio_snd_init_pci(PCIBus *init_bus, const char *audiodev)
-{
-    audiodev_id = audiodev;
-    return 0;
-}
-

> +static void virtio_snd_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> +{
> +    VirtIOSoundPCI *dev = VIRTIO_SOUND_PCI(vpci_dev);

-    VirtIOSoundPCI *dev = VIRTIO_SOUND_PCI(vpci_dev);
+    VirtIOSoundPCI *dev = VIRTIO_SND_PCI(vpci_dev);

> +    DeviceState *vdev = DEVICE(&dev->vdev);
> +
> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus), errp);
> +    qdev_prop_set_string(vdev, "audiodev", audiodev_id);
> +    object_property_set_bool(OBJECT(vdev), "realized", true, errp);

-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus), errp);
-    qdev_prop_set_string(vdev, "audiodev", audiodev_id);
-    object_property_set_bool(OBJECT(vdev), "realized", true, errp);
+    virtio_pci_force_virtio_1(vpci_dev);
+    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);

The virtio-sound-pci device is a modern virtio-pci device.

> +}
> +
> +static void virtio_snd_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioPCIClass *vpciklass = VIRTIO_PCI_CLASS(klass);

-    VirtioPCIClass *vpciklass = VIRTIO_PCI_CLASS(klass);
+    VirtioPCIClass *vpci_k = VIRTIO_PCI_CLASS(klass);

> +    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
> +
> +    vpciklass->realize = virtio_snd_pci_realize;

-    vpciklass->realize = virtio_snd_pci_realize;
+    device_class_set_props(dc, virtio_snd_pci_properties);
+    dc->desc = "Virtio Sound";

> +    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
> +
> +    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_SND;
> +    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;

-
-    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
-    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_SND;
-    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    vpci_k->realize = virtio_snd_pci_realize;

The removed code is unnecessary virtio-legacy code.

> +    pcidev_k->class_id = PCI_CLASS_MULTIMEDIA_AUDIO;
> +    device_class_set_props(dc, virtio_snd_pci_properties);

-    device_class_set_props(dc, virtio_snd_pci_properties);

> +}
> +
> +static void virtio_snd_pci_instance_init(Object *obj)
> +{
> +    VirtIOSoundPCI *dev = VIRTIO_SOUND_PCI(obj);

-    VirtIOSoundPCI *dev = VIRTIO_SOUND_PCI(obj);
+    VirtIOSoundPCI *dev = VIRTIO_SND_PCI(obj);

> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_SND);
> +}
> +
> +static const VirtioPCIDeviceTypeInfo virtio_snd_pci_info = {
> +    .base_name     = TYPE_VIRTIO_SND_PCI,
> +    .generic_name  = "virtio-sound-pci",

-    .base_name     = TYPE_VIRTIO_SND_PCI,
-    .generic_name  = "virtio-sound-pci",
+    .generic_name  = TYPE_VIRTIO_SND_PCI,

> +    .instance_size = sizeof(VirtIOSoundPCI),
> +    .instance_init = virtio_snd_pci_instance_init,
> +    .class_init    = virtio_snd_pci_class_init,
> +};
> +

+/* Create a Virtio Sound PCI device, so '-audio driver,model=virtio' works. */
+static int virtio_snd_pci_init(PCIBus *bus, const char *audiodev)
+{
+    DeviceState *dev;
+
+    dev = qdev_new(TYPE_VIRTIO_SND_PCI);
+    qdev_prop_set_string(dev, "audiodev", audiodev);
+    qdev_realize_and_unref(dev, BUS(bus), &error_fatal);
+    return 0;
+}
+

> +static void virtio_snd_pci_register(void)
> +{
> +    virtio_pci_types_register(&virtio_snd_pci_info);
> +    pci_register_soundhw("virtio-sound", "Virtio Sound Device",
> +                         virtio_snd_init_pci);

-    pci_register_soundhw("virtio-sound", "Virtio Sound Device",
-                         virtio_snd_init_pci);
+    pci_register_soundhw("virtio", "Virtio Sound", virtio_snd_pci_init);

The change above is not strictly necessary. But I think the -audio 
parameter implies an audio device and the -sound suffix in virtio-sound 
is redundant.

> +}
> +
> +type_init(virtio_snd_pci_register);
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index abdc1ef103..3cd5712035 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -85,6 +85,7 @@ extern bool pci_available;
>   #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
>   #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
>   #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
> +#define PCI_DEVICE_ID_VIRTIO_SND         0x1019

The virtio-sound-pci device is a modern virtio device. Adding the 
PCI_DEVICE_ID_VIRTIO_SND definition is not necessary. See the complete 
comment below in include/hw/pci/pci.h.

>   /*
>    * modern virtio-pci devices get their id assigned automatically,
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


