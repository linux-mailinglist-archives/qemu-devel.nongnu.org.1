Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB69280EF43
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 15:48:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD42W-00072K-1J; Tue, 12 Dec 2023 09:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=DDG+=HX=kaod.org=clg@ozlabs.org>)
 id 1rD42T-00071n-Mp; Tue, 12 Dec 2023 09:47:13 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=DDG+=HX=kaod.org=clg@ozlabs.org>)
 id 1rD42R-0002Ws-07; Tue, 12 Dec 2023 09:47:12 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SqLzl4q03z4xRn;
 Wed, 13 Dec 2023 01:46:59 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SqLzc5jfKz4xNH;
 Wed, 13 Dec 2023 01:46:52 +1100 (AEDT)
Message-ID: <2645397c-eacd-48d4-b452-c9d6cce83d96@kaod.org>
Date: Tue, 12 Dec 2023 15:46:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [PATCH v8 01/10] hw/fsi: Introduce IBM's Local bus
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231128235700.599584-1-ninad@linux.ibm.com>
 <20231128235700.599584-2-ninad@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20231128235700.599584-2-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=DDG+=HX=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/29/23 00:56, Ninad Palsule wrote:
> This is a part of patchset where IBM's Flexible Service Interface is
> introduced.
> 
> The LBUS is modelled to maintain mapped memory for the devices. The
> memory is mapped after CFAM config, peek table and FSI slave registers.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> [ clg: - removed lbus_add_device() bc unused
>         - removed lbus_create_device() bc used only once
>         - removed "address" property
>         - updated meson.build to build fsi dir
>         - included an empty hw/fsi/trace-events ]
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   meson.build           |  1 +
>   hw/fsi/trace.h        |  1 +
>   include/hw/fsi/lbus.h | 40 +++++++++++++++++++++++++++++++++
>   hw/fsi/lbus.c         | 51 +++++++++++++++++++++++++++++++++++++++++++
>   hw/Kconfig            |  1 +
>   hw/fsi/Kconfig        |  2 ++
>   hw/fsi/meson.build    |  1 +
>   hw/fsi/trace-events   |  1 +
>   hw/meson.build        |  1 +
>   9 files changed, 99 insertions(+)
>   create mode 100644 hw/fsi/trace.h
>   create mode 100644 include/hw/fsi/lbus.h
>   create mode 100644 hw/fsi/lbus.c
>   create mode 100644 hw/fsi/Kconfig
>   create mode 100644 hw/fsi/meson.build
>   create mode 100644 hw/fsi/trace-events
> 
> diff --git a/meson.build b/meson.build
> index ec01f8b138..b6556efd51 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3298,6 +3298,7 @@ if have_system
>       'hw/char',
>       'hw/display',
>       'hw/dma',
> +    'hw/fsi',
>       'hw/hyperv',
>       'hw/i2c',
>       'hw/i386',
> diff --git a/hw/fsi/trace.h b/hw/fsi/trace.h
> new file mode 100644
> index 0000000000..ee67c7fb04
> --- /dev/null
> +++ b/hw/fsi/trace.h
> @@ -0,0 +1 @@
> +#include "trace/trace-hw_fsi.h"
> diff --git a/include/hw/fsi/lbus.h b/include/hw/fsi/lbus.h
> new file mode 100644
> index 0000000000..a58e33d061
> --- /dev/null
> +++ b/include/hw/fsi/lbus.h
> @@ -0,0 +1,40 @@
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
> +#define TYPE_FSI_LBUS_DEVICE "fsi.lbus.device"
> +OBJECT_DECLARE_TYPE(FSILBusDevice, FSILBusDeviceClass, FSI_LBUS_DEVICE)
> +
> +#define FSI_LBUS_MEM_REGION_SIZE  (2 * 1024 * 1024)
> +#define FSI_LBUSDEV_IOMEM_START   0xc00 /* 3K used by CFAM config etc */

I don't think sizing the local bus MMIO region exactly to the size of
the CFAM MMIO region is necessary. The upper LBUS/CFAM addresses might
not even be backed by device registers.

I would simplify with :

#define FSI_LBUS_MEM_REGION_SIZE  (1 * MiB)

and forget about the offset.


Thanks,

C.


   
> +
> +typedef struct FSILBusDevice {
> +    DeviceState parent;
> +
> +    MemoryRegion iomem;
> +} FSILBusDevice;
> +
> +typedef struct FSILBusDeviceClass {
> +    DeviceClass parent;
> +
> +    uint32_t config;
> +} FSILBusDeviceClass;
> +
> +#define TYPE_FSI_LBUS "fsi.lbus"
> +OBJECT_DECLARE_SIMPLE_TYPE(FSILBus, FSI_LBUS)
> +
> +typedef struct FSILBus {
> +    BusState bus;
> +
> +    MemoryRegion mr;
> +} FSILBus;
> +
> +#endif /* FSI_LBUS_H */
> diff --git a/hw/fsi/lbus.c b/hw/fsi/lbus.c
> new file mode 100644
> index 0000000000..84c46a00d7
> --- /dev/null
> +++ b/hw/fsi/lbus.c
> @@ -0,0 +1,51 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM Local bus where FSI slaves are connected
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/fsi/lbus.h"
> +
> +#include "hw/qdev-properties.h"
> +
> +static void lbus_init(Object *o)
> +{
> +    FSILBus *lbus = FSI_LBUS(o);
> +
> +    memory_region_init(&lbus->mr, OBJECT(lbus), TYPE_FSI_LBUS,
> +                       FSI_LBUS_MEM_REGION_SIZE - FSI_LBUSDEV_IOMEM_START);
> +}
> +
> +static const TypeInfo lbus_info = {
> +    .name = TYPE_FSI_LBUS,
> +    .parent = TYPE_BUS,
> +    .instance_init = lbus_init,
> +    .instance_size = sizeof(FSILBus),
> +};
> +
> +static void lbus_device_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->bus_type = TYPE_FSI_LBUS;
> +}
> +
> +static const TypeInfo lbus_device_type_info = {
> +    .name = TYPE_FSI_LBUS_DEVICE,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(FSILBusDevice),
> +    .abstract = true,
> +    .class_init = lbus_device_class_init,
> +    .class_size = sizeof(FSILBusDeviceClass),
> +};
> +
> +static void lbus_register_types(void)
> +{
> +    type_register_static(&lbus_info);
> +    type_register_static(&lbus_device_type_info);
> +}
> +
> +type_init(lbus_register_types);
> diff --git a/hw/Kconfig b/hw/Kconfig
> index 9ca7b38c31..2c00936c28 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -9,6 +9,7 @@ source core/Kconfig
>   source cxl/Kconfig
>   source display/Kconfig
>   source dma/Kconfig
> +source fsi/Kconfig
>   source gpio/Kconfig
>   source hyperv/Kconfig
>   source i2c/Kconfig
> diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
> new file mode 100644
> index 0000000000..e650c660f0
> --- /dev/null
> +++ b/hw/fsi/Kconfig
> @@ -0,0 +1,2 @@
> +config FSI_LBUS
> +    bool
> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
> new file mode 100644
> index 0000000000..4074d3a7d2
> --- /dev/null
> +++ b/hw/fsi/meson.build
> @@ -0,0 +1 @@
> +system_ss.add(when: 'CONFIG_FSI_LBUS', if_true: files('lbus.c'))
> diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
> new file mode 100644
> index 0000000000..8b13789179
> --- /dev/null
> +++ b/hw/fsi/trace-events
> @@ -0,0 +1 @@
> +
> diff --git a/hw/meson.build b/hw/meson.build
> index f01fac4617..463d702683 100644
> --- a/hw/meson.build
> +++ b/hw/meson.build
> @@ -44,6 +44,7 @@ subdir('virtio')
>   subdir('watchdog')
>   subdir('xen')
>   subdir('xenpv')
> +subdir('fsi')
>   
>   subdir('alpha')
>   subdir('arm')


