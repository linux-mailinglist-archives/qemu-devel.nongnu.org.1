Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7B178A85B
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 10:57:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaY3p-0007DN-R9; Mon, 28 Aug 2023 04:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qaY3o-0007Cv-DU; Mon, 28 Aug 2023 04:57:24 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qaY3l-00026I-BY; Mon, 28 Aug 2023 04:57:24 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9a21b6d105cso373899466b.3; 
 Mon, 28 Aug 2023 01:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1693213039; x=1693817839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GQ0I6uIGHC7Qnb8kIAwMrscdXGuxZVuKdlhkTleK9WQ=;
 b=CV7YwVPXsOvVRrmSsdL8PWQKwIEalNhxfjBdCXRZBPQ2UehIRHnAcbW577i8yPM0nG
 LFeRxkDqzp7SRyYXvSC8gSIZ6WHpeyT0n33IR8gA5YmAJFi9o5eKRzYNEeR0kF4GrwzF
 FUZqzFF2T+skuDCTfXEGkRo/4ij1xTXpb3uf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693213039; x=1693817839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GQ0I6uIGHC7Qnb8kIAwMrscdXGuxZVuKdlhkTleK9WQ=;
 b=lQ4VOeoQAPSbA50+mxbGM3M84XJ8riNf0Y70NzfyuVpQjb1A0253pAeKVfHUdG1xAP
 vDU87bH7xcKemItSKlHzyijlHfvawC8CcprZD9raLcIajMbDHqgj9kKAKWTAc36cxW5S
 huVb4hdCKU9jhbhzHpquO7U2uJFuU8geQPmr60pKw6Aw3qlh4PDoUOB+gU0ozqjZFC84
 CUfmOH7nhwqOlMpPnUzjPCMCPDL2SfNpX6r8ZJfqKU7R0Q84i57qTpk9DSiuW9OhGSaz
 PIQ20FeyISOsCozamqXEf0BdK437Rl67xaiyWo3WXeq1QjWequHHmget14qqHhXrLHZs
 +Xwg==
X-Gm-Message-State: AOJu0YzZaHBitJHoEeGqSE/uMINXvaxGzrybPVGFwDuXrwSh+TbYAi4o
 gaE6KNUyoJzwQQQZsJTWlv7+VmD3ydfvKSwZyuM=
X-Google-Smtp-Source: AGHT+IE6aZe/kzhJGX/L72j4X4mRsEiTvJZz8QzmCJJpV8qFHXT69D/qwFn8x/sZHhuJBGMDbLSGmU3cYiw0ZO2TeXU=
X-Received: by 2002:a17:906:32d2:b0:9a1:edb0:2a7f with SMTP id
 k18-20020a17090632d200b009a1edb02a7fmr10264567ejk.6.1693213038713; Mon, 28
 Aug 2023 01:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230825203046.3692467-1-ninad@linux.ibm.com>
 <20230825203046.3692467-5-ninad@linux.ibm.com>
In-Reply-To: <20230825203046.3692467-5-ninad@linux.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 28 Aug 2023 08:57:07 +0000
Message-ID: <CACPK8XeuAssMVRAtmU+7ssnzspmhxpjjUYuKynahRRgux8YueQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/7] hw/fsi: Introduce IBM's FSI
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org, 
 andrew@aj.id.au, pbonzini@redhat.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, thuth@redhat.com, philmd@linaro.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x62a.google.com
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

On Fri, 25 Aug 2023 at 20:44, Ninad Palsule <ninad@linux.ibm.com> wrote:
>
> This is a part of patchset where IBM's Flexible Service Interface is
> introduced.
>
> This commit models the FSI bus. CFAM is hanging out of FSI bus. The bus
> is model such a way that it is embeded inside the FSI master which is a
> bus controller.
>
> The FSI master: A controller in the platform service processor (e.g.
> BMC) driving CFAM engine accesses into the POWER chip. At the
> hardware level FSI is a bit-based protocol supporting synchronous and
> DMA-driven accesses of engines in a CFAM.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  hw/fsi/cfam.c               |   1 +
>  hw/fsi/fsi-master.c         | 203 ++++++++++++++++++++++++++++++++++++
>  hw/fsi/fsi.c                |  54 ++++++++++
>  hw/fsi/meson.build          |   2 +-
>  include/hw/fsi/cfam.h       |   2 -
>  include/hw/fsi/fsi-master.h |  30 ++++++
>  include/hw/fsi/fsi.h        |  35 +++++++
>  7 files changed, 324 insertions(+), 3 deletions(-)
>  create mode 100644 hw/fsi/fsi-master.c
>  create mode 100644 hw/fsi/fsi.c
>  create mode 100644 include/hw/fsi/fsi-master.h
>  create mode 100644 include/hw/fsi/fsi.h
>
> diff --git a/hw/fsi/cfam.c b/hw/fsi/cfam.c
> index 19256050bd..12ce31cac4 100644
> --- a/hw/fsi/cfam.c
> +++ b/hw/fsi/cfam.c
> @@ -12,6 +12,7 @@
>
>  #include "hw/fsi/bits.h"
>  #include "hw/fsi/cfam.h"
> +#include "hw/fsi/fsi.h"
>  #include "hw/fsi/engine-scratchpad.h"
>
>  #include "hw/qdev-properties.h"
> diff --git a/hw/fsi/fsi-master.c b/hw/fsi/fsi-master.c
> new file mode 100644
> index 0000000000..fe1693539a
> --- /dev/null
> +++ b/hw/fsi/fsi-master.c
> @@ -0,0 +1,203 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM Flexible Service Interface master
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qapi/error.h"
> +
> +#include "qemu/log.h"
> +
> +#include "hw/fsi/bits.h"
> +#include "hw/fsi/fsi-master.h"
> +
> +#define TYPE_OP_BUS "opb"
> +
> +#define TO_REG(x)                               ((x) >> 2)
> +
> +#define FSI_MMODE                               TO_REG(0x000)
> +#define   FSI_MMODE_IPOLL_DMA_EN                BE_BIT(0)
> +#define   FSI_MMODE_HW_ERROR_RECOVERY_EN        BE_BIT(1)
> +#define   FSI_MMODE_RELATIVE_ADDRESS_EN         BE_BIT(2)
> +#define   FSI_MMODE_PARITY_CHECK_EN             BE_BIT(3)
> +#define   FSI_MMODE_CLOCK_DIVIDER_0             BE_GENMASK(4, 13)
> +#define   FSI_MMODE_CLOCK_DIVIDER_1             BE_GENMASK(14, 23)
> +#define   FSI_MMODE_DEBUG_EN                    BE_BIT(24)
> +
> +#define FSI_MDELAY                              TO_REG(0x004)
> +#define   FSI_MDELAY_ECHO_0                     BE_GENMASK(0, 3)
> +#define   FSI_MDELAY_SEND_0                     BE_GENMASK(4, 7)
> +#define   FSI_MDELAY_ECHO_1                     BE_GENMASK(8, 11)
> +#define   FSI_MDELAY_SEND_1                     BE_GENMASK(12, 15)
> +
> +#define FSI_MENP0                               TO_REG(0x010)
> +#define FSI_MENP32                              TO_REG(0x014)
> +#define FSI_MSENP0                              TO_REG(0x018)
> +#define FSI_MLEVP0                              TO_REG(0x018)
> +#define FSI_MSENP32                             TO_REG(0x01c)
> +#define FSI_MLEVP32                             TO_REG(0x01c)
> +#define FSI_MCENP0                              TO_REG(0x020)
> +#define FSI_MREFP0                              TO_REG(0x020)
> +#define FSI_MCENP32                             TO_REG(0x024)
> +#define FSI_MREFP32                             TO_REG(0x024)
> +
> +#define FSI_MAEB                                TO_REG(0x070)
> +#define   FSI_MAEB_ANY_CPU_ERROR                BE_BIT(0)
> +#define   FSI_MAEB_ANY_DMA_ERROR                BE_GENMASK(1, 16)
> +#define   FSI_MAEB_ANY_PARITY_ERROR             BE_BIT(17)
> +
> +#define FSI_MVER                                TO_REG(0x074)
> +#define   FSI_MVER_VERSION                      BE_GENMASK(0, 7)
> +#define   FSI_MVER_BRIDGES                      BE_GENMASK(8, 15)
> +#define   FSI_MVER_PORTS                        BE_GENMASK(16, 23)
> +
> +#define FSI_MRESP0                              TO_REG(0x0d0)
> +#define   FSI_MRESP0_RESET_PORT_GENERAL         BE_BIT(0)
> +#define   FSI_MRESP0_RESET_PORT_ERROR           BE_BIT(1)
> +#define   FSI_MRESP0_RESET_ALL_BRIDGES_GENERAL  BE_BIT(2)
> +#define   FSI_MRESP0_RESET_ALL_PORTS_GENERAL    BE_BIT(3)
> +#define   FSI_MRESP0_RESET_MASTER               BE_BIT(4)
> +#define   FSI_MRESP0_RESET_PARITY_ERROR_LATCH   BE_BIT(5)
> +
> +#define FSI_MRESB0                              TO_REG(0x1d0)
> +#define   FSI_MRESB0_RESET_GENERAL              BE_BIT(0)
> +#define   FSI_MRESB0_RESET_ERROR                BE_BIT(1)
> +#define   FSI_MRESB0_SET_DMA_SUSPEND            BE_BIT(5)
> +#define   FSI_MRESB0_CLEAR_DMA_SUSPEND          BE_BIT(6)
> +#define   FSI_MRESB0_SET_DELAY_MEASURE          BE_BIT(7)
> +
> +#define FSI_MECTRL                              TO_REG(0x2e0)
> +#define   FSI_MECTRL_TEST_PULSE                 BE_GENMASK(0, 7)
> +#define   FSI_MECTRL_INHIBIT_PARITY_ERROR       BE_GENMASK(8, 15)
> +#define   FSI_MECTRL_ENABLE_OPB_ERR_ACK         BE_BIT(16)
> +#define   FSI_MECTRL_AUTO_TERMINATE             BE_BIT(17)
> +#define   FSI_MECTRL_PORT_ERROR_FREEZE          BE_BIT(18)
> +
> +static uint64_t fsi_master_read(void *opaque, hwaddr addr, unsigned size=
)
> +{
> +    FSIMasterState *s =3D FSI_MASTER(opaque);
> +
> +    qemu_log_mask(LOG_UNIMP, "%s: read @0x%" HWADDR_PRIx " size=3D%d\n",
> +                  __func__, addr, size);
> +
> +    if (addr + size > sizeof(s->regs)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out of bounds read: 0x%"HWADDR_PRIx" for %u\n=
",
> +                      __func__, addr, size);
> +        return 0;
> +    }
> +
> +    return s->regs[TO_REG(addr)];
> +}
> +
> +static void fsi_master_write(void *opaque, hwaddr addr, uint64_t data,
> +                             unsigned size)
> +{
> +    FSIMasterState *s =3D FSI_MASTER(opaque);
> +
> +    qemu_log_mask(LOG_UNIMP, "%s: write @0x%" HWADDR_PRIx " size=3D%d "
> +                  "value=3D%"PRIx64"\n", __func__, addr, size, data);
> +
> +    if (addr + size > sizeof(s->regs)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out of bounds write: %"HWADDR_PRIx" for %u\n"=
,
> +                      __func__, addr, size);
> +        return;
> +    }
> +
> +    switch (TO_REG(addr)) {
> +    case FSI_MENP0:
> +        s->regs[FSI_MENP0] =3D data;
> +        break;
> +    case FSI_MENP32:
> +        s->regs[FSI_MENP32] =3D data;
> +        break;
> +    case FSI_MSENP0:
> +        s->regs[FSI_MENP0] |=3D data;
> +        break;
> +    case FSI_MSENP32:
> +        s->regs[FSI_MENP32] |=3D data;
> +        break;
> +    case FSI_MCENP0:
> +        s->regs[FSI_MENP0] &=3D ~data;
> +        break;
> +    case FSI_MCENP32:
> +        s->regs[FSI_MENP32] &=3D ~data;
> +        break;
> +    case FSI_MRESP0:
> +        /* Perform necessary resets leave register 0 to indicate no erro=
rs */
> +        break;
> +    case FSI_MRESB0:
> +        if (data & FSI_MRESB0_RESET_GENERAL) {
> +            device_cold_reset(DEVICE(opaque));
> +        }
> +        if (data & FSI_MRESB0_RESET_ERROR) {
> +            /* FIXME: this seems dubious */
> +            device_cold_reset(DEVICE(opaque));
> +        }
> +        break;
> +    default:
> +        s->regs[TO_REG(addr)] =3D data;
> +    }
> +}
> +
> +static const struct MemoryRegionOps fsi_master_ops =3D {
> +    .read =3D fsi_master_read,
> +    .write =3D fsi_master_write,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +};
> +
> +static void fsi_master_realize(DeviceState *dev, Error **errp)
> +{
> +    FSIMasterState *s =3D FSI_MASTER(dev);
> +    Error *err =3D NULL;
> +
> +    qbus_init(&s->bus, sizeof(s->bus), TYPE_FSI_BUS, DEVICE(s), NULL);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &fsi_master_ops, s,
> +                          TYPE_FSI_MASTER, 0x10000000);
> +    memory_region_init(&s->opb2fsi, OBJECT(s), "fsi.opb2fsi", 0x10000000=
);
> +
> +    object_property_set_bool(OBJECT(&s->bus), "realized", true, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    memory_region_add_subregion(&s->opb2fsi, 0, &s->bus.slave.mr);
> +}
> +
> +static void fsi_master_reset(DeviceState *dev)
> +{
> +    FSIMasterState *s =3D FSI_MASTER(dev);
> +
> +    /* ASPEED default */
> +    s->regs[FSI_MVER] =3D 0xe0050101;
> +}
> +
> +static void fsi_master_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->bus_type =3D TYPE_OP_BUS;
> +    dc->desc =3D "FSI Master";
> +    dc->realize =3D fsi_master_realize;
> +    dc->reset =3D fsi_master_reset;
> +}
> +
> +static const TypeInfo fsi_master_info =3D {
> +    .name =3D TYPE_FSI_MASTER,
> +    .parent =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(FSIMasterState),
> +    .class_init =3D fsi_master_class_init,
> +};
> +
> +static void fsi_register_types(void)
> +{
> +    type_register_static(&fsi_master_info);
> +}
> +
> +type_init(fsi_register_types);
> diff --git a/hw/fsi/fsi.c b/hw/fsi/fsi.c
> new file mode 100644
> index 0000000000..43f889fee9
> --- /dev/null
> +++ b/hw/fsi/fsi.c
> @@ -0,0 +1,54 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM Flexible Service Interface
> + */
> +#include "qemu/osdep.h"
> +
> +#include "qapi/error.h"
> +
> +#include "hw/fsi/fsi.h"
> +#include "hw/fsi/cfam.h"
> +
> +static void fsi_bus_realize(BusState *bus, Error **errp)
> +{
> +    FSIBus *s =3D FSI_BUS(bus);
> +    Error *err =3D NULL;
> +
> +    /* FIXME: Should be realised elsewhere and added to the bus */
> +    object_property_set_bool(OBJECT(&s->slave), "realized", true, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +    }
> +}
> +
> +static void fsi_bus_init(Object *o)
> +{
> +    FSIBus *s =3D FSI_BUS(o);
> +
> +    /* FIXME: Move this elsewhere */
> +    object_initialize_child(o, TYPE_CFAM, &s->slave, TYPE_CFAM);
> +    qdev_set_parent_bus(DEVICE(&s->slave), BUS(o), &error_abort);
> +}
> +
> +static void fsi_bus_class_init(ObjectClass *klass, void *data)
> +{
> +    BusClass *bc =3D BUS_CLASS(klass);
> +    bc->realize =3D fsi_bus_realize;
> +}
> +
> +static const TypeInfo fsi_bus_info =3D {
> +    .name =3D TYPE_FSI_BUS,
> +    .parent =3D TYPE_BUS,
> +    .instance_init =3D fsi_bus_init,
> +    .instance_size =3D sizeof(FSIBus),
> +    .class_init =3D fsi_bus_class_init,
> +};
> +
> +static void fsi_bus_register_types(void)
> +{
> +    type_register_static(&fsi_bus_info);
> +}
> +
> +type_init(fsi_bus_register_types);
> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
> index 5600502b33..ca80d11cb9 100644
> --- a/hw/fsi/meson.build
> +++ b/hw/fsi/meson.build
> @@ -1,4 +1,4 @@
>  system_ss.add(when: 'CONFIG_LBUS', if_true: files('lbus.c'))
>  system_ss.add(when: 'CONFIG_SCRATCHPAD', if_true: files('engine-scratchp=
ad.c'))
>  system_ss.add(when: 'CONFIG_CFAM', if_true: files('cfam.c'))
> -system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi-slave.c'))
> +system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi.c','fsi-master.c',=
'fsi-slave.c'))
> diff --git a/include/hw/fsi/cfam.h b/include/hw/fsi/cfam.h
> index af9f88cb22..83bd29b0c3 100644
> --- a/include/hw/fsi/cfam.h
> +++ b/include/hw/fsi/cfam.h
> @@ -12,8 +12,6 @@
>  #include "hw/fsi/fsi-slave.h"
>  #include "hw/fsi/lbus.h"
>
> -#define TYPE_FSI_BUS "fsi.bus"
> -
>  #define TYPE_CFAM "cfam"
>  #define CFAM(obj) OBJECT_CHECK(CFAMState, (obj), TYPE_CFAM)
>
> diff --git a/include/hw/fsi/fsi-master.h b/include/hw/fsi/fsi-master.h
> new file mode 100644
> index 0000000000..5341d4c873
> --- /dev/null
> +++ b/include/hw/fsi/fsi-master.h
> @@ -0,0 +1,30 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2019 IBM Corp.
> + *
> + * IBM Flexible Service Interface Master
> + */
> +#ifndef FSI_FSI_MASTER_H
> +#define FSI_FSI_MASTER_H
> +
> +#include "exec/memory.h"
> +#include "hw/qdev-core.h"
> +#include "hw/fsi/fsi.h"
> +
> +#define TYPE_FSI_MASTER "fsi.master"
> +#define FSI_MASTER(obj) OBJECT_CHECK(FSIMasterState, (obj), TYPE_FSI_MAS=
TER)
> +
> +#define FSI_MASTER_NR_REGS ((0x2e0 >> 2) + 1)
> +
> +typedef struct FSIMasterState {
> +    DeviceState parent;
> +    MemoryRegion iomem;
> +    MemoryRegion opb2fsi;
> +
> +    FSIBus bus;
> +
> +    uint32_t regs[FSI_MASTER_NR_REGS];
> +} FSIMasterState;
> +
> +
> +#endif /* FSI_FSI_H */
> diff --git a/include/hw/fsi/fsi.h b/include/hw/fsi/fsi.h
> new file mode 100644
> index 0000000000..e88c5432ad
> --- /dev/null
> +++ b/include/hw/fsi/fsi.h
> @@ -0,0 +1,35 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM Flexible Service Interface
> + */
> +#ifndef FSI_FSI_H
> +#define FSI_FSI_H
> +
> +#include "hw/qdev-core.h"
> +
> +/*
> + * TODO: Maybe unwind this dependency with const links? Store a
> + * pointer in FSIBus?
> + */
> +#include "hw/fsi/cfam.h"
> +
> +#define TYPE_FSI_BUS "fsi.bus"
> +#define FSI_BUS(obj) OBJECT_CHECK(FSIBus, (obj), TYPE_FSI_BUS)
> +#define FSI_BUS_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(FSIBusClass, (klass), TYPE_FSI_BUS)
> +#define FSI_BUS_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(FSIBusClass, (obj), TYPE_FSI_BUS)
> +
> +/* TODO: Figure out what's best with a point-to-point bus */
> +typedef struct FSISlaveState FSISlaveState;
> +
> +typedef struct FSIBus {
> +    BusState bus;
> +
> +    /* XXX: It's point-to-point, just instantiate the slave directly for=
 now */
> +    CFAMState slave;
> +} FSIBus;
> +
> +#endif
> --
> 2.39.2
>

