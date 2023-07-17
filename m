Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 016A2756994
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 18:51:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLRRI-0006YQ-4W; Mon, 17 Jul 2023 12:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qLRR7-0006Nn-CT
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:51:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qLRR1-0006Ff-Ev
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:51:00 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbc1218262so48483945e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689612651; x=1692204651;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vJSrTwDXOocSkWHn+rewXMnFkisD39w10KWefSQNC2U=;
 b=wz8LMJUCWzicw2DAPxcMWiRgbzcBDEfA3TXJZqvR+QsytfxcZ8jDJog7ykA4e1ysKU
 81VdyiHGFBIyWbAGxqLW1BTdYjwdMhpJfgZEvx884ohtMWqvtChhuKGZf3x8pjUvVWun
 B5fL1Cwj+WDPRvszcKmp+hhbHGNYOSLCkYLK52tOiwVvWNzSdkeUTTU5hZtzwm2rdmGA
 vKjWyYRmjFp0SH5III6ok4i6u1z+83sg30jjnDQrdkgvF7vRuHJEhvAf36fe4QMf+3uU
 DaGg9WT8yJvXS8RMPciahuABKIvAaczDltTavc1h6h6l8v4u2oERA3JQ/Eic1O16CyHB
 OOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689612651; x=1692204651;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vJSrTwDXOocSkWHn+rewXMnFkisD39w10KWefSQNC2U=;
 b=iZEA311wH7Chbw3caws1LVNNtWCqE/Q0k7mm1TphXr0fELYY7F+RWbVGMcrYt3w7sl
 wb+YrduUloZN/ZWGgq2oxZm4rtYWDWbwmR6cEND1Dznz91RKSJeod/m9Z/6uRXhocibC
 EKF4jZR3+7BlhBoDgEpiOgMsXQ13j+UVPt5Unr0cUJkiLK9QNyORuGaGW9BxlSRhXju7
 10HEBgq7TsVc8d7ZaQQFJw9JJW3nx5vPNxkeNVirgj/ZmI53UPYIt8+tDvlTGM2HvJOr
 Ssu9ygjrOs5+Jbfd7VcOY1Xog//hlpax4SbtDjqnL9bTdK6dn3tP641Isw0n4YSBecfh
 hE8w==
X-Gm-Message-State: ABy/qLYgevm8QjgfXV8WY/Y6ObgFFVpbyRwqlzEGKxcWOCvVCymf34cZ
 m3UALr8HVpTj4sjJTlK5cscxn6S0pF8UbveQ6DY=
X-Google-Smtp-Source: APBJJlH2ySx/dkXDYIkpUqZQWQsXfs7XGyxu5Q3Mw2aJ3RECYq1uOKfY0SsM+wT9uMjXbTtei4JlfQ==
X-Received: by 2002:a5d:458c:0:b0:313:fcea:db06 with SMTP id
 p12-20020a5d458c000000b00313fceadb06mr10568838wrq.12.1689612651262; 
 Mon, 17 Jul 2023 09:50:51 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 j2-20020a5d4482000000b003143867d2ebsm19683513wrq.63.2023.07.17.09.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 09:50:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2201A1FFBB;
 Mon, 17 Jul 2023 17:50:50 +0100 (BST)
References: <cover.1686238728.git.manos.pitsidianakis@linaro.org>
 <db527bc9a1fdb2199a264ffd0d2526ce709a745c.1686238728.git.manos.pitsidianakis@linaro.org>
User-agent: mu4e 1.11.9; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>, Anton Yakovlev
 <Anton.Yakovlev@opensynergy.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/3] Add virtio-sound-pci device
Date: Mon, 17 Jul 2023 17:47:35 +0100
In-reply-to: <db527bc9a1fdb2199a264ffd0d2526ce709a745c.1686238728.git.manos.pitsidianakis@linaro.org>
Message-ID: <87h6q2wkgl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> This patch adds a PCI wrapper device for the virtio-sound device.
>
> To test this, you'll need a >=3D5.13 kernel compiled with
> CONFIG_SND_VIRTIO=3Dy, which at the time of writing most distros have off
> by default.
>
> Use with following flags in the invocation:
>
>   -device virtio-sound-pci,disable-legacy=3Don
>
> And an audio backend listed with `-audio driver=3Dhelp` that works on
> your host machine, e.g.:
>
> Pulseaudio:
>   -audio driver=3Dpa,model=3Dvirtio-sound
> sdl:
>   -audio driver=3Dsdl,model=3Dvirtio-sound
> coreaudio (macos/darwin):
>   -audio driver=3Dcoreaudio,model=3Dvirtio-sound
> etc.
>
> You can use speaker-test from alsa-tools to play noise, sines, or
> WAV files.
>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> ---
>  hw/virtio/meson.build      |   1 +
>  hw/virtio/virtio-snd-pci.c | 102 +++++++++++++++++++++++++++++++++++++
>  include/hw/pci/pci.h       |   1 +
>  softmmu/qdev-monitor.c     |   1 +
>  4 files changed, 105 insertions(+)
>  create mode 100644 hw/virtio/virtio-snd-pci.c
>
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index 8cf49af618..55d9426415 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -58,6 +58,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SERIAL', if_true=
: files('virtio-serial-pc
>  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pme=
m-pci.c'))
>  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-io=
mmu-pci.c'))
>  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem-=
pci.c'))
> +virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SND', if_true: files('virtio-snd-=
pci.c'))
>  virtio_pci_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-de=
v-pci.c'))
>=20=20
>  specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pc=
i_ss)
> diff --git a/hw/virtio/virtio-snd-pci.c b/hw/virtio/virtio-snd-pci.c
> new file mode 100644
> index 0000000000..1a41b53e07
> --- /dev/null
> +++ b/hw/virtio/virtio-snd-pci.c
> @@ -0,0 +1,102 @@
> +/*
> + * VIRTIO Sound Device PCI Bindings
> + *
> + * Copyright (c) 2023 Emmanouil Pitsidianakis <manos.pitsidianakis@linar=
o.org>
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
> +
> +typedef struct VirtIOSoundPCI VirtIOSoundPCI;
> +
> +/*
> + * virtio-snd-pci: This extends VirtioPCIProxy.
> + */
> +#define TYPE_VIRTIO_SND_PCI "virtio-sound-pci-base"
> +DECLARE_INSTANCE_CHECKER(VirtIOSoundPCI, VIRTIO_SOUND_PCI,
> +                         TYPE_VIRTIO_SND_PCI)
> +
> +struct VirtIOSoundPCI {
> +    VirtIOPCIProxy parent;
> +    VirtIOSound vdev;
> +};
> +
> +static Property virtio_snd_pci_properties[] =3D {
> +    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),

What does this control? In VirtIOPCIProxy class_code seems to be for
transitional devices. It's used inconsistently  across the code base
AFAICT.

> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static const char *audiodev_id;
> +
> +static int virtio_snd_init_pci(PCIBus *init_bus, const char *audiodev)
> +{
> +    audiodev_id =3D audiodev;
> +    return 0;
> +}
> +
> +static void virtio_snd_pci_realize(VirtIOPCIProxy *vpci_dev, Error **err=
p)
> +{
> +    VirtIOSoundPCI *dev =3D VIRTIO_SOUND_PCI(vpci_dev);
> +    DeviceState *vdev =3D DEVICE(&dev->vdev);
> +    VirtIOSound *vsnd =3D VIRTIO_SND(&dev->vdev);
> +
> +    /*
> +     * According to spec, non-legacy virtio PCI devices are always little
> +     * endian
> +     */
> +    vsnd->virtio_access_is_big_endian =3D false;
> +
> +
> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus), errp);
> +
> +    qdev_prop_set_string(vdev, "audiodev", audiodev_id);
> +
> +    object_property_set_bool(OBJECT(vdev), "realized", true, errp);
> +}
> +
> +static void virtio_snd_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    VirtioPCIClass *vpciklass =3D VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
> +
> +    vpciklass->realize =3D virtio_snd_pci_realize;
> +    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
> +
> +    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_SND;
> +    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
> +    pcidev_k->class_id =3D PCI_CLASS_MULTIMEDIA_AUDIO;
> +    device_class_set_props(dc, virtio_snd_pci_properties);
> +}
> +
> +static void virtio_snd_pci_instance_init(Object *obj)
> +{
> +    VirtIOSoundPCI *dev =3D VIRTIO_SOUND_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_SND);
> +}
> +
> +static const VirtioPCIDeviceTypeInfo virtio_snd_pci_info =3D {
> +    .base_name     =3D TYPE_VIRTIO_SND_PCI,
> +    .generic_name  =3D "virtio-sound-pci",
> +    .instance_size =3D sizeof(VirtIOSoundPCI),
> +    .instance_init =3D virtio_snd_pci_instance_init,
> +    .class_init    =3D virtio_snd_pci_class_init,
> +};
> +
> +static void virtio_snd_pci_register(void)
> +{
> +    virtio_pci_types_register(&virtio_snd_pci_info);
> +    pci_register_soundhw("virtio-sound", "Virtio Sound Device",
> +                         virtio_snd_init_pci);
> +}
> +
> +type_init(virtio_snd_pci_register);
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index e6d0574a29..cf4216df81 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -85,6 +85,7 @@ extern bool pci_available;
>  #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
>  #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
>  #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
> +#define PCI_DEVICE_ID_VIRTIO_SND         0x1019
>=20=20
>  /*
>   * modern virtio-pci devices get their id assigned automatically,
> diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
> index b8d2c4dadd..49d68495a3 100644
> --- a/softmmu/qdev-monitor.c
> +++ b/softmmu/qdev-monitor.c
> @@ -108,6 +108,7 @@ static const QDevAlias qdev_alias_table[] =3D {
>      { "virtio-serial-device", "virtio-serial", QEMU_ARCH_VIRTIO_MMIO },
>      { "virtio-serial-ccw", "virtio-serial", QEMU_ARCH_VIRTIO_CCW },
>      { "virtio-serial-pci", "virtio-serial", QEMU_ARCH_VIRTIO_PCI},
> +    { "virtio-sound-pci", "virtio-sound", QEMU_ARCH_VIRTIO_PCI},
>      { "virtio-tablet-device", "virtio-tablet", QEMU_ARCH_VIRTIO_MMIO },
>      { "virtio-tablet-ccw", "virtio-tablet", QEMU_ARCH_VIRTIO_CCW },
>      { "virtio-tablet-pci", "virtio-tablet", QEMU_ARCH_VIRTIO_PCI },


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

