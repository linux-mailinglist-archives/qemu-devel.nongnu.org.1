Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FAB78A86B
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 11:00:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaY6I-0008Dt-5R; Mon, 28 Aug 2023 04:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qaY6D-0008DP-6q; Mon, 28 Aug 2023 04:59:53 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qaY6A-0002Jf-Gn; Mon, 28 Aug 2023 04:59:52 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-52a49a42353so4197507a12.2; 
 Mon, 28 Aug 2023 01:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1693213188; x=1693817988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oau4/Wvow41fh6Hp+opA4uWiXLt9RSF4Zfxu8A3g7L0=;
 b=Yj6FpJK0oSdCJmo9w+gZOUzyMT0oLlZOOAuffaGaS8Ro/cxmpINwj107iYqjcdWfyD
 jki7nnweqSZg2hVoIeWEWC0pGEZ+naj+2SMV6+XYTk08EL3VFSuRh1wOdrKxYn4qW2eE
 kSkMzoH4VVWa+eNhaGeyvov2PpXerwTz34XO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693213188; x=1693817988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oau4/Wvow41fh6Hp+opA4uWiXLt9RSF4Zfxu8A3g7L0=;
 b=Q7gfZiYJoo0ceb0ptacaR1q8IvGEd4QOLLt0u0brrrjPRP5l022EK2UU3UCqT+X90m
 WerIX+e9/eQ/UjjELYGyEeJDj7UfN4mTk5xYM3Siy8Qa2Gey7G6z3CxfpSaZa1BuZc4Q
 /gZrj+7/dNvjOSL980JKrN6zrmQs0WJ02sbCuVQXavVgvySsY2pryAMsiUBCQHC1KFp3
 hH20JkKRDRVvCSra5A8quBVI1j3+qC/gD9kSZHrixUjLLtcCl/hI5PgTi1hHGoC+yDoe
 P5JIegtIrPgKMDNOQFo/dTmA/ytvE/B0SwmRxWp0qfJKJZQX64KY3BnRANKoZuIg6NZs
 7DKQ==
X-Gm-Message-State: AOJu0YwY4MY6DMpcys+ZML1C74KmHqZGuGEUykImV5mqCwW9CYkVSHGt
 u0nATZJRAect/J2lFjJoUHpvAVGxJqQVGPxZCkM=
X-Google-Smtp-Source: AGHT+IEy5mPur8UG2N++6luMnEsqu0i8sNy5lnObidbplEIAy7uknc12L6IWfAQcCKeCHT/TaUkpXPU1u1Bu+kDz/80=
X-Received: by 2002:a17:906:32c2:b0:9a1:c495:66bb with SMTP id
 k2-20020a17090632c200b009a1c49566bbmr11839899ejk.60.1693213188094; Mon, 28
 Aug 2023 01:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230825203046.3692467-1-ninad@linux.ibm.com>
 <20230825203046.3692467-6-ninad@linux.ibm.com>
In-Reply-To: <20230825203046.3692467-6-ninad@linux.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 28 Aug 2023 08:59:36 +0000
Message-ID: <CACPK8Xe325YKww5MHcxGHNHCsL8Y1ST+8OBvc5RLGRQ5_fdbPA@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] hw/fsi: IBM's On-chip Peripheral Bus
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org, 
 andrew@aj.id.au, pbonzini@redhat.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, thuth@redhat.com, philmd@linaro.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=joel.stan@gmail.com; helo=mail-ed1-x533.google.com
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

On Fri, 25 Aug 2023 at 20:35, Ninad Palsule <ninad@linux.ibm.com> wrote:
>
> This is a part of patchset where IBM's Flexible Service Interface is
> introduced.
>
> The On-Chip Peripheral Bus (OPB): A low-speed bus typically found in
> POWER processors. This now makes an appearance in the ASPEED SoC due
> to tight integration of the FSI master IP with the OPB, mainly the
> existence of an MMIO-mapping of the CFAM address straight onto a
> sub-region of the OPB address space.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  hw/fsi/Kconfig       |   4 +
>  hw/fsi/fsi-master.c  |   3 +-
>  hw/fsi/meson.build   |   1 +
>  hw/fsi/opb.c         | 194 +++++++++++++++++++++++++++++++++++++++++++
>  include/hw/fsi/opb.h |  45 ++++++++++
>  5 files changed, 245 insertions(+), 2 deletions(-)
>  create mode 100644 hw/fsi/opb.c
>  create mode 100644 include/hw/fsi/opb.h
>
> diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
> index 087980be22..560ce536db 100644
> --- a/hw/fsi/Kconfig
> +++ b/hw/fsi/Kconfig
> @@ -1,3 +1,7 @@
> +config OPB
> +    bool
> +    select CFAM
> +
>  config CFAM
>      bool
>      select FSI
> diff --git a/hw/fsi/fsi-master.c b/hw/fsi/fsi-master.c
> index fe1693539a..ba00e2bb7d 100644
> --- a/hw/fsi/fsi-master.c
> +++ b/hw/fsi/fsi-master.c
> @@ -13,8 +13,7 @@
>
>  #include "hw/fsi/bits.h"
>  #include "hw/fsi/fsi-master.h"
> -
> -#define TYPE_OP_BUS "opb"
> +#include "hw/fsi/opb.h"
>
>  #define TO_REG(x)                               ((x) >> 2)
>
> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
> index ca80d11cb9..cab645f4ea 100644
> --- a/hw/fsi/meson.build
> +++ b/hw/fsi/meson.build
> @@ -2,3 +2,4 @@ system_ss.add(when: 'CONFIG_LBUS', if_true: files('lbus.c=
'))
>  system_ss.add(when: 'CONFIG_SCRATCHPAD', if_true: files('engine-scratchp=
ad.c'))
>  system_ss.add(when: 'CONFIG_CFAM', if_true: files('cfam.c'))
>  system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi.c','fsi-master.c',=
'fsi-slave.c'))
> +system_ss.add(when: 'CONFIG_OPB', if_true: files('opb.c'))
> diff --git a/hw/fsi/opb.c b/hw/fsi/opb.c
> new file mode 100644
> index 0000000000..ac7693c001
> --- /dev/null
> +++ b/hw/fsi/opb.c
> @@ -0,0 +1,194 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM On-chip Peripheral Bus
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +
> +#include "hw/fsi/opb.h"
> +
> +static MemTxResult opb_read(OPBus *opb, hwaddr addr, void *data, size_t =
len)
> +{
> +    return address_space_read(&opb->as, addr, MEMTXATTRS_UNSPECIFIED, da=
ta,
> +                              len);
> +}
> +
> +uint8_t opb_read8(OPBus *opb, hwaddr addr)
> +{
> +    MemTxResult tx;
> +    uint8_t data;
> +
> +    tx =3D opb_read(opb, addr, &data, sizeof(data));
> +    /* FIXME: improve error handling */
> +    assert(!tx);
> +
> +    return data;
> +}
> +
> +uint16_t opb_read16(OPBus *opb, hwaddr addr)
> +{
> +    MemTxResult tx;
> +    uint16_t data;
> +
> +    tx =3D opb_read(opb, addr, &data, sizeof(data));
> +    /* FIXME: improve error handling */
> +    assert(!tx);
> +
> +    return data;
> +}
> +
> +uint32_t opb_read32(OPBus *opb, hwaddr addr)
> +{
> +    MemTxResult tx;
> +    uint32_t data;
> +
> +    tx =3D opb_read(opb, addr, &data, sizeof(data));
> +    /* FIXME: improve error handling */
> +    assert(!tx);
> +
> +    return data;
> +}
> +
> +static MemTxResult opb_write(OPBus *opb, hwaddr addr, void *data, size_t=
 len)
> +{
> +    return address_space_write(&opb->as, addr, MEMTXATTRS_UNSPECIFIED, d=
ata,
> +                               len);
> +}
> +
> +void opb_write8(OPBus *opb, hwaddr addr, uint8_t data)
> +{
> +    MemTxResult tx;
> +
> +    tx =3D opb_write(opb, addr, &data, sizeof(data));
> +    /* FIXME: improve error handling */
> +    assert(!tx);
> +}
> +
> +void opb_write16(OPBus *opb, hwaddr addr, uint16_t data)
> +{
> +    MemTxResult tx;
> +
> +    tx =3D opb_write(opb, addr, &data, sizeof(data));
> +    /* FIXME: improve error handling */
> +    assert(!tx);
> +}
> +
> +void opb_write32(OPBus *opb, hwaddr addr, uint32_t data)
> +{
> +    MemTxResult tx;
> +
> +    tx =3D opb_write(opb, addr, &data, sizeof(data));
> +    /* FIXME: improve error handling */
> +    assert(!tx);
> +}
> +
> +void opb_fsi_master_address(OPBus *opb, hwaddr addr)
> +{
> +    memory_region_transaction_begin();
> +    memory_region_set_address(&opb->fsi.iomem, addr);
> +    memory_region_transaction_commit();
> +}
> +
> +void opb_opb2fsi_address(OPBus *opb, hwaddr addr)
> +{
> +    memory_region_transaction_begin();
> +    memory_region_set_address(&opb->fsi.opb2fsi, addr);
> +    memory_region_transaction_commit();
> +}
> +
> +static uint64_t opb_unimplemented_read(void *opaque, hwaddr addr, unsign=
ed size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s: read @0x%" HWADDR_PRIx " size=3D%d\n",
> +                  __func__, addr, size);
> +
> +    return 0;
> +}
> +
> +static void opb_unimplemented_write(void *opaque, hwaddr addr, uint64_t =
data,
> +                                 unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s: write @0x%" HWADDR_PRIx " size=3D%d "
> +                  "value=3D%"PRIx64"\n", __func__, addr, size, data);
> +}
> +
> +static const struct MemoryRegionOps opb_unimplemented_ops =3D {
> +    .read =3D opb_unimplemented_read,
> +    .write =3D opb_unimplemented_write,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +};
> +
> +static void opb_realize(BusState *bus, Error **errp)
> +{
> +    OPBus *opb =3D OP_BUS(bus);
> +    Error *err =3D NULL;
> +
> +    memory_region_init_io(&opb->mr, OBJECT(opb), &opb_unimplemented_ops,=
 opb,
> +                          NULL, UINT32_MAX);
> +    address_space_init(&opb->as, &opb->mr, "opb");
> +
> +    object_property_set_bool(OBJECT(&opb->fsi), "realized", true, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    memory_region_add_subregion(&opb->mr, 0x80000000, &opb->fsi.iomem);
> +
> +    /* OPB2FSI region */
> +    /*
> +     * Avoid endianness issues by mapping each slave's memory region dir=
ectly.
> +     * Manually bridging multiple address-spaces causes endian swapping
> +     * headaches as memory_region_dispatch_read() and
> +     * memory_region_dispatch_write() correct the endianness based on th=
e
> +     * target machine endianness and not relative to the device endianne=
ss on
> +     * either side of the bridge.
> +     */
> +    /*
> +     * XXX: This is a bit hairy and will need to be fixed when I sort ou=
t the
> +     * bus/slave relationship and any changes to the CFAM modelling (mul=
tiple
> +     * slaves, LBUS)
> +     */
> +    memory_region_add_subregion(&opb->mr, 0xa0000000, &opb->fsi.opb2fsi)=
;
> +}
> +
> +static void opb_init(Object *o)
> +{
> +    OPBus *opb =3D OP_BUS(o);
> +
> +    object_initialize_child(o, "fsi-master", &opb->fsi, TYPE_FSI_MASTER)=
;
> +    qdev_set_parent_bus(DEVICE(&opb->fsi), BUS(o), &error_abort);
> +}
> +
> +static void opb_finalize(Object *o)
> +{
> +    OPBus *opb =3D OP_BUS(o);
> +
> +    address_space_destroy(&opb->as);
> +}
> +
> +static void opb_class_init(ObjectClass *klass, void *data)
> +{
> +    BusClass *bc =3D BUS_CLASS(klass);
> +    bc->realize =3D opb_realize;
> +}
> +
> +static const TypeInfo opb_info =3D {
> +    .name =3D TYPE_OP_BUS,
> +    .parent =3D TYPE_BUS,
> +    .instance_init =3D opb_init,
> +    .instance_finalize =3D opb_finalize,
> +    .instance_size =3D sizeof(OPBus),
> +    .class_init =3D opb_class_init,
> +    .class_size =3D sizeof(OPBusClass),
> +};
> +
> +static void opb_register_types(void)
> +{
> +    type_register_static(&opb_info);
> +}
> +
> +type_init(opb_register_types);
> diff --git a/include/hw/fsi/opb.h b/include/hw/fsi/opb.h
> new file mode 100644
> index 0000000000..fad40eed79
> --- /dev/null
> +++ b/include/hw/fsi/opb.h
> @@ -0,0 +1,45 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM On-Chip Peripheral Bus
> + */
> +#ifndef FSI_OPB_H
> +#define FSI_OPB_H
> +
> +#include "exec/memory.h"
> +#include "hw/fsi/fsi-master.h"
> +
> +#define TYPE_OP_BUS "opb"
> +#define OP_BUS(obj) OBJECT_CHECK(OPBus, (obj), TYPE_OP_BUS)
> +#define OP_BUS_CLASS(klass) OBJECT_CLASS_CHECK(OPBusClass, (klass), TYPE=
_OP_BUS)
> +#define OP_BUS_GET_CLASS(obj) OBJECT_GET_CLASS(OPBusClass, (obj), TYPE_O=
P_BUS)
> +
> +typedef struct OPBus {
> +        /*< private >*/
> +        BusState bus;
> +
> +        /*< public >*/
> +        MemoryRegion mr;
> +        AddressSpace as;
> +
> +        /* Model OPB as dumb enough just to provide an address-space */
> +        /* TODO: Maybe don't store device state in the bus? */
> +        FSIMasterState fsi;
> +} OPBus;
> +
> +typedef struct OPBusClass {
> +        BusClass parent_class;
> +} OPBusClass;
> +
> +uint8_t opb_read8(OPBus *opb, hwaddr addr);
> +uint16_t opb_read16(OPBus *opb, hwaddr addr);
> +uint32_t opb_read32(OPBus *opb, hwaddr addr);
> +void opb_write8(OPBus *opb, hwaddr addr, uint8_t data);
> +void opb_write16(OPBus *opb, hwaddr addr, uint16_t data);
> +void opb_write32(OPBus *opb, hwaddr addr, uint32_t data);
> +
> +void opb_fsi_master_address(OPBus *opb, hwaddr addr);
> +void opb_opb2fsi_address(OPBus *opb, hwaddr addr);
> +
> +#endif /* FSI_OPB_H */
> --
> 2.39.2
>

