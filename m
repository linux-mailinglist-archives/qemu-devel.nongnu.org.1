Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7662578A7C6
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 10:36:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaXhx-0002CG-5u; Mon, 28 Aug 2023 04:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qaXhu-0002Bz-6L; Mon, 28 Aug 2023 04:34:46 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qaXhq-0006G7-Jh; Mon, 28 Aug 2023 04:34:45 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so8073212a12.1; 
 Mon, 28 Aug 2023 01:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1693211680; x=1693816480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aJdAQWXzhI1EhpoPb86q3droVX5XH0MBXFICVk6ltqM=;
 b=S19m/hSwUCGbFQSM+Gc7LX3ZbZeUGcaw0yxPewLuJme6K57D5jwX7pzz2jvjUqapZJ
 aM6zmIrRPfayT7DGd18If0U85haaxi4ea84dRE80AImcR+s55FX6qTIhS8H0ilSaIOVG
 vUSd/71jzoQtTVIJ5sVene4tf6exaGg3vLTbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693211680; x=1693816480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJdAQWXzhI1EhpoPb86q3droVX5XH0MBXFICVk6ltqM=;
 b=l/F0l3ijK+S5yEl+azPxXpx/jr5Rnr2pxs16i9NPlhyi2FXmKfJtZuvvxWpMCGGbsU
 mC/eeAW8+LTvhsS1/2K1aNH04hARhZM3j0kOYMQq1upsCHldCGFthjly3JGgsnoo3U+L
 +PVHqAbNFATtB7ijhPiw3inTOvEqm1nKCnXl8U511gvyf9/7E/qZeQVigmh+SxAFGQp+
 MNdGypvt5/5Mnu102QinIBJFFEt2cSk9vz9bBrG8tIK84mIV33qZfW4FuzBd4MfkYqz7
 /KsV1ZnTEZWgZ3n1EkcgOxdrKiIErgdrxaPmF4Zelqmr2kqjEkGIWDAbp21oBkSpiOSX
 pThg==
X-Gm-Message-State: AOJu0YzPkwV8eAczNJSAmV1CSSKNJ86oMGAC+XkUnTDNP6+pV9ao+6Wc
 SDMNjCEbufHZLU4LG1U64OntwoTJb2j7oxyX2lk=
X-Google-Smtp-Source: AGHT+IHoxII4S1GLg4Ohh6Vap9ehRxl0zz6LwAa2ipers7d2h3vGbfT1WQAfLHWOjvZlp5FfaaotYJej0eE3nraQKXE=
X-Received: by 2002:a17:906:9f10:b0:9a5:b2d8:e925 with SMTP id
 fy16-20020a1709069f1000b009a5b2d8e925mr1821447ejc.33.1693211680264; Mon, 28
 Aug 2023 01:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230825203046.3692467-1-ninad@linux.ibm.com>
 <20230825203046.3692467-2-ninad@linux.ibm.com>
In-Reply-To: <20230825203046.3692467-2-ninad@linux.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 28 Aug 2023 08:34:28 +0000
Message-ID: <CACPK8Xfd=FLCA2=1cvcyD=wcX56v7O88wH_zRf-D8oA4L8ORfw@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] hw/fsi: Introduce IBM's Local bus
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org, 
 andrew@aj.id.au, pbonzini@redhat.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, thuth@redhat.com, philmd@linaro.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=joel.stan@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 25 Aug 2023 at 20:31, Ninad Palsule <ninad@linux.ibm.com> wrote:
>
> This is a part of patchset where IBM's Flexible Service Interface is
> introduced.
>
> The LBUS is modelled to maintain the qdev bus hierarchy and to take
> advantage of the object model to automatically generate the CFAM
> configuration block. The configuration block presents engines in the
> order they are attached to the CFAM's LBUS. Engine implementations
> should subclass the LBusDevice and set the 'config' member of
> LBusDeviceClass to match the engine's type.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  hw/Kconfig            |  1 +
>  hw/fsi/Kconfig        |  2 +
>  hw/fsi/lbus.c         | 94 +++++++++++++++++++++++++++++++++++++++++++
>  hw/fsi/meson.build    |  1 +
>  hw/meson.build        |  1 +
>  include/hw/fsi/bits.h | 15 +++++++
>  include/hw/fsi/lbus.h | 57 ++++++++++++++++++++++++++
>  7 files changed, 171 insertions(+)
>  create mode 100644 hw/fsi/Kconfig
>  create mode 100644 hw/fsi/lbus.c
>  create mode 100644 hw/fsi/meson.build
>  create mode 100644 include/hw/fsi/bits.h
>  create mode 100644 include/hw/fsi/lbus.h
>
> diff --git a/hw/Kconfig b/hw/Kconfig
> index ba62ff6417..2ccb73add5 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -9,6 +9,7 @@ source core/Kconfig
>  source cxl/Kconfig
>  source display/Kconfig
>  source dma/Kconfig
> +source fsi/Kconfig
>  source gpio/Kconfig
>  source hyperv/Kconfig
>  source i2c/Kconfig
> diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
> new file mode 100644
> index 0000000000..687449e14e
> --- /dev/null
> +++ b/hw/fsi/Kconfig
> @@ -0,0 +1,2 @@
> +config LBUS
> +    bool
> diff --git a/hw/fsi/lbus.c b/hw/fsi/lbus.c
> new file mode 100644
> index 0000000000..afb26ef7ea
> --- /dev/null
> +++ b/hw/fsi/lbus.c
> @@ -0,0 +1,94 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM Local bus where FSI slaves are connected
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +
> +#include "hw/fsi/lbus.h"
> +
> +#include "hw/qdev-properties.h"
> +
> +static void lbus_realize(BusState *bus, Error **errp)
> +{
> +    LBusNode *node;
> +    LBus *lbus =3D LBUS(bus);
> +
> +    memory_region_init(&lbus->mr, OBJECT(lbus), TYPE_LBUS,
> +                       (2 * 1024 * 1024) - 0x400);
> +
> +    QLIST_FOREACH(node, &lbus->devices, next) {
> +        memory_region_add_subregion(&lbus->mr, node->ldev->address,
> +                                    &node->ldev->iomem);
> +    }
> +}
> +
> +static void lbus_init(Object *o)
> +{
> +}
> +
> +static void lbus_class_init(ObjectClass *klass, void *data)
> +{
> +    BusClass *k =3D BUS_CLASS(klass);
> +    k->realize =3D lbus_realize;
> +}
> +
> +static const TypeInfo lbus_info =3D {
> +    .name =3D TYPE_LBUS,
> +    .parent =3D TYPE_BUS,
> +    .instance_init =3D lbus_init,
> +    .instance_size =3D sizeof(LBus),
> +    .class_init =3D lbus_class_init,
> +};
> +
> +static Property lbus_device_props[] =3D {
> +    DEFINE_PROP_UINT32("address", LBusDevice, address, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +DeviceState *lbus_create_device(LBus *bus, const char *type, uint32_t ad=
dr)
> +{
> +    DeviceState *dev;
> +    LBusNode *node;
> +
> +    dev =3D qdev_new(type);
> +    qdev_prop_set_uint8(dev, "address", addr);
> +    qdev_realize_and_unref(dev, &bus->bus, &error_fatal);
> +
> +    /* Move to post_load */
> +    node =3D g_malloc(sizeof(struct LBusNode));
> +    node->ldev =3D LBUS_DEVICE(dev);
> +    QLIST_INSERT_HEAD(&bus->devices, node, next);
> +
> +    return dev;
> +}
> +
> +static void lbus_device_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->bus_type =3D TYPE_LBUS;
> +    device_class_set_props(dc, lbus_device_props);
> +}
> +
> +static const TypeInfo lbus_device_type_info =3D {
> +    .name =3D TYPE_LBUS_DEVICE,
> +    .parent =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(LBusDevice),
> +    .abstract =3D true,
> +    .class_init =3D lbus_device_class_init,
> +    .class_size =3D sizeof(LBusDeviceClass),
> +};
> +
> +static void lbus_register_types(void)
> +{
> +    type_register_static(&lbus_info);
> +    type_register_static(&lbus_device_type_info);
> +}
> +
> +type_init(lbus_register_types);
> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
> new file mode 100644
> index 0000000000..e1007d5fea
> --- /dev/null
> +++ b/hw/fsi/meson.build
> @@ -0,0 +1 @@
> +system_ss.add(when: 'CONFIG_LBUS', if_true: files('lbus.c'))
> diff --git a/hw/meson.build b/hw/meson.build
> index c7ac7d3d75..6c71ee9cfa 100644
> --- a/hw/meson.build
> +++ b/hw/meson.build
> @@ -43,6 +43,7 @@ subdir('virtio')
>  subdir('watchdog')
>  subdir('xen')
>  subdir('xenpv')
> +subdir('fsi')
>
>  subdir('alpha')
>  subdir('arm')
> diff --git a/include/hw/fsi/bits.h b/include/hw/fsi/bits.h
> new file mode 100644
> index 0000000000..338ae483cf
> --- /dev/null
> +++ b/include/hw/fsi/bits.h
> @@ -0,0 +1,15 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * Bit operation macros
> + */
> +#ifndef FSI_BITS_H
> +#define FSI_BITS_H
> +
> +#define BE_BIT(x)                          BIT(31 - (x))
> +#define GENMASK(t, b) \
> +    (((1ULL << ((t) + 1)) - 1) & ~((1ULL << (b)) - 1))
> +#define BE_GENMASK(t, b)                   GENMASK(BE_BIT(t), BE_BIT(b))

These are similar to the PPC_BIT definitions. We have a copy of them
in taget/ppc/cpu.h, perhaps they could be moved into a common header.

> +
> +#endif /* FSI_BITS_H */
> diff --git a/include/hw/fsi/lbus.h b/include/hw/fsi/lbus.h
> new file mode 100644
> index 0000000000..00ed7e5250
> --- /dev/null
> +++ b/include/hw/fsi/lbus.h
> @@ -0,0 +1,57 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM Local bus and connected device structures.
> + */
> +#ifndef FSI_LBUS_H
> +#define FSI_LBUS_H
> +
> +#include "exec/memory.h"
> +#include "hw/qdev-core.h"
> +
> +#define TYPE_LBUS_DEVICE "lbus.device"
> +#define LBUS_DEVICE(obj) \
> +    OBJECT_CHECK(LBusDevice, (obj), TYPE_LBUS_DEVICE)
> +#define LBUS_DEVICE_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(LBusDeviceClass, (klass), TYPE_LBUS_DEVICE)
> +#define LBUS_DEVICE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(LBusDeviceClass, (obj), TYPE_LBUS_DEVICE)

I think we can use OBJECT_DECLARE_SIMPLE_TYPE here to create the macros for=
 us.

> +
> +typedef struct LBusDevice {
> +    DeviceState parent;
> +
> +    MemoryRegion iomem;
> +    uint32_t address;
> +} LBusDevice;
> +
> +typedef struct LBusDeviceClass {
> +    DeviceClass parent;
> +
> +    uint32_t config;
> +} LBusDeviceClass;
> +
> +typedef struct LBusNode {
> +    LBusDevice *ldev;
> +
> +    QLIST_ENTRY(LBusNode) next;
> +} LBusNode;
> +
> +#define TYPE_LBUS "lbus"
> +#define LBUS(obj) OBJECT_CHECK(LBus, (obj), TYPE_LBUS)
> +#define LBUS_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(LBusClass, (klass), TYPE_LBUS)
> +#define LBUS_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(LBusClass, (obj), TYPE_LBUS)

Same here.

> +
> +typedef struct LBus {
> +    BusState bus;
> +
> +    MemoryRegion mr;
> +
> +    QLIST_HEAD(, LBusNode) devices;
> +} LBus;
> +
> +DeviceState *lbus_create_device(LBus *bus, const char *type, uint32_t ad=
dr);
> +int lbus_add_device(LBus *bus, LBusDevice *dev);
> +#endif /* FSI_LBUS_H */
> --
> 2.39.2
>

