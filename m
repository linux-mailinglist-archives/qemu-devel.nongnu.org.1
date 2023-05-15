Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3018703E1E
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 22:07:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeRu-000727-A4; Mon, 15 May 2023 16:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1pyeRo-00071G-Ks; Mon, 15 May 2023 16:05:32 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1pyeRl-0007V2-C2; Mon, 15 May 2023 16:05:32 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-ba6e90e9199so6306197276.0; 
 Mon, 15 May 2023 13:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684181128; x=1686773128;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8M+3oWSs/3H3TR+BKjYWbe3RKqmDAvFi2t4Wr8AOUA4=;
 b=hXcx47SmeiX+FpqTJQPb2AHJk4y+cs099XOt/G0Q0GPU/W3i6s2ruGuOPLzCw+mdef
 Gff57wPhm85m2P1nnuyEty8fnhtNkF+ywd0pkVi8lXG/ZvJY1YrdgIZmzz0LXyNYwnyX
 wqKX2wrdrYNRs1F0YqTmPp3M5IaWDenpgDbGgrjdid3W2CVuAcwiA/vMCFMbAkUN86P0
 gG86tx7SrAga+c/kQX099EugoBma6S/T4RRiKt9QDziVk+1+WmiXAOTIWoT+xCPWGNJs
 0O7aFOpT+KGQ2zHVim4fjF/XZKh1UCnu5KsuUg3eQmJ1A7S0k9d6pV20pvLTODifmADM
 wdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684181128; x=1686773128;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8M+3oWSs/3H3TR+BKjYWbe3RKqmDAvFi2t4Wr8AOUA4=;
 b=gR8TYV/qG30AJ99u2PYRdvKmVeTL4/753DlvqD9quZx5k54htuk448wW94WZrEvyTo
 dkzw2yk4CUuVPU3mUtciVpf37Bb2u3i/fZVDsZmEdBs++RPSCYv1xG5zd0DxFjmosBFx
 SpyOfKOAlc7n7afPg7AfpYgdOVqDv4rVDSFce2aQzr301JL4D2RS9iyqQvR3LOnfnCEJ
 ROq3M9+/UUB0Wnw96TzkYwj4yAzdz9Ud5DV/grdIKLkVdFlDN3Sfru3A95T44bo5cvrO
 y7vJtuI/l1xEHMOKrD09ufTDK4sI6UE9domsZTs9i8hdGUNKGPIuK8JSDRMHaT7y66wj
 JJKA==
X-Gm-Message-State: AC+VfDx1TbpfiIFFLbvLs0aWlXVunZIfh7/GpmiSCbiNX/OMf6S/quIE
 mFViRshpk70pt3RIxVcMhlySkpskgOLBiuzrLC0=
X-Google-Smtp-Source: ACHHUZ5eT5UbSNROP1HRQHS8M+bvfJ/STz050eJG+QHGT9RYgglHVZaV0vVB7ZaDVWBxxEaFKDS93t1ukg3dAJHs6x8=
X-Received: by 2002:a05:6902:154f:b0:ba1:7cb6:7212 with SMTP id
 r15-20020a056902154f00b00ba17cb67212mr38423143ybu.47.1684181126303; Mon, 15
 May 2023 13:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230510103004.30015-1-qianfanguijin@163.com>
 <20230510103004.30015-10-qianfanguijin@163.com>
In-Reply-To: <20230510103004.30015-10-qianfanguijin@163.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 15 May 2023 22:05:15 +0200
Message-ID: <CAPan3WrL72uH+2rA8eBE50V31ZfYSEDH22yABfC3+LGY0UnL_Q@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] hw: arm: allwinner-sramc: Add SRAM Controller
 support for R40
To: qianfanguijin@163.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c554c805fbc0f972"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-yb1-xb33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000c554c805fbc0f972
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 12:30=E2=80=AFPM <qianfanguijin@163.com> wrote:

> From: qianfan Zhao <qianfanguijin@163.com>
>
> Only a few important registers are added, especially the SRAM_VER
> register.
>
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>


> ---
>  hw/arm/Kconfig                    |   1 +
>  hw/arm/allwinner-r40.c            |   7 +-
>  hw/misc/Kconfig                   |   3 +
>  hw/misc/allwinner-sramc.c         | 184 ++++++++++++++++++++++++++++++
>  hw/misc/meson.build               |   1 +
>  hw/misc/trace-events              |   4 +
>  include/hw/arm/allwinner-r40.h    |   3 +
>  include/hw/misc/allwinner-sramc.h |  69 +++++++++++
>  8 files changed, 271 insertions(+), 1 deletion(-)
>  create mode 100644 hw/misc/allwinner-sramc.c
>  create mode 100644 include/hw/misc/allwinner-sramc.h
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index bad4ea158c..ae6f3911c5 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -377,6 +377,7 @@ config ALLWINNER_H3
>  config ALLWINNER_R40
>      bool
>      default y if TCG && ARM
> +    select ALLWINNER_SRAMC
>      select ALLWINNER_A10_PIT
>      select AXP2XX_PMU
>      select SERIAL
> diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
> index c018ad231a..7d29eb224f 100644
> --- a/hw/arm/allwinner-r40.c
> +++ b/hw/arm/allwinner-r40.c
> @@ -39,6 +39,7 @@ const hwaddr allwinner_r40_memmap[] =3D {
>      [AW_R40_DEV_SRAM_A2]    =3D 0x00004000,
>      [AW_R40_DEV_SRAM_A3]    =3D 0x00008000,
>      [AW_R40_DEV_SRAM_A4]    =3D 0x0000b400,
> +    [AW_R40_DEV_SRAMC]      =3D 0x01c00000,
>      [AW_R40_DEV_EMAC]       =3D 0x01c0b000,
>      [AW_R40_DEV_MMC0]       =3D 0x01c0f000,
>      [AW_R40_DEV_MMC1]       =3D 0x01c10000,
> @@ -76,7 +77,6 @@ struct AwR40Unimplemented {
>  static struct AwR40Unimplemented r40_unimplemented[] =3D {
>      { "d-engine",   0x01000000, 4 * MiB },
>      { "d-inter",    0x01400000, 128 * KiB },
> -    { "sram-c",     0x01c00000, 4 * KiB },
>      { "dma",        0x01c02000, 4 * KiB },
>      { "nfdc",       0x01c03000, 4 * KiB },
>      { "ts",         0x01c04000, 4 * KiB },
> @@ -288,6 +288,8 @@ static void allwinner_r40_init(Object *obj)
>                               "ram-addr");
>      object_property_add_alias(obj, "ram-size", OBJECT(&s->dramc),
>                                "ram-size");
> +
> +    object_initialize_child(obj, "sramc", &s->sramc,
> TYPE_AW_SRAMC_SUN8I_R40);
>  }
>
>  static void allwinner_r40_realize(DeviceState *dev, Error **errp)
> @@ -382,6 +384,9 @@ static void allwinner_r40_realize(DeviceState *dev,
> Error **errp)
>                         AW_R40_GIC_SPI_TIMER1));
>
>      /* SRAM */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->sramc), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sramc), 0,
> s->memmap[AW_R40_DEV_SRAMC]);
> +
>      memory_region_init_ram(&s->sram_a1, OBJECT(dev), "sram A1",
>                              16 * KiB, &error_abort);
>      memory_region_init_ram(&s->sram_a2, OBJECT(dev), "sram A2",
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index efeb430a6c..e4c2149175 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -170,6 +170,9 @@ config VIRT_CTRL
>  config LASI
>      bool
>
> +config ALLWINNER_SRAMC
> +    bool
> +
>  config ALLWINNER_A10_CCM
>      bool
>
> diff --git a/hw/misc/allwinner-sramc.c b/hw/misc/allwinner-sramc.c
> new file mode 100644
> index 0000000000..a8b731f8f2
> --- /dev/null
> +++ b/hw/misc/allwinner-sramc.c
> @@ -0,0 +1,184 @@
> +/*
> + * Allwinner R40 SRAM controller emulation
> + *
> + * Copyright (C) 2023 qianfan Zhao <qianfanguijin@163.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "hw/sysbus.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
> +#include "hw/misc/allwinner-sramc.h"
> +#include "trace.h"
> +
> +/*
> + * register offsets
> + * https://linux-sunxi.org/SRAM_Controller_Register_Guide
> + */
> +enum {
> +    REG_SRAM_CTL1_CFG               =3D 0x04, /* SRAM Control register 1=
 */
> +    REG_SRAM_VER                    =3D 0x24, /* SRAM Version register *=
/
> +    REG_SRAM_R40_SOFT_ENTRY_REG0    =3D 0xbc,
> +};
> +
> +/* REG_SRAMC_VERSION bit defines */
> +#define SRAM_VER_READ_ENABLE            (1 << 15)
> +#define SRAM_VER_VERSION_SHIFT          16
> +#define SRAM_VERSION_SUN8I_R40          0x1701
> +
> +static uint64_t allwinner_sramc_read(void *opaque, hwaddr offset,
> +                                     unsigned size)
> +{
> +    AwSRAMCState *s =3D AW_SRAMC(opaque);
> +    AwSRAMCClass *sc =3D AW_SRAMC_GET_CLASS(s);
> +    uint64_t val =3D 0;
> +
> +    switch (offset) {
> +    case REG_SRAM_CTL1_CFG:
> +        val =3D s->sram_ctl1;
> +        break;
> +    case REG_SRAM_VER:
> +        /* bit15: lock bit, set this bit before reading this register */
> +        if (s->sram_ver & SRAM_VER_READ_ENABLE) {
> +            val =3D SRAM_VER_READ_ENABLE |
> +                    (sc->sram_version_code << SRAM_VER_VERSION_SHIFT);
> +        }
> +        break;
> +    case REG_SRAM_R40_SOFT_ENTRY_REG0:
> +        val =3D s->sram_soft_entry_reg0;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset
> 0x%04x\n",
> +                      __func__, (uint32_t)offset);
> +        return 0;
> +    }
> +
> +    trace_allwinner_sramc_read(offset, val);
> +
> +    return val;
> +}
> +
> +static void allwinner_sramc_write(void *opaque, hwaddr offset,
> +                                  uint64_t val, unsigned size)
> +{
> +    AwSRAMCState *s =3D AW_SRAMC(opaque);
> +
> +    trace_allwinner_sramc_write(offset, val);
> +
> +    switch (offset) {
> +    case REG_SRAM_CTL1_CFG:
> +        s->sram_ctl1 =3D val;
> +        break;
> +    case REG_SRAM_VER:
> +        /* Only the READ_ENABLE bit is writeable */
> +        s->sram_ver =3D val & SRAM_VER_READ_ENABLE;
> +        break;
> +    case REG_SRAM_R40_SOFT_ENTRY_REG0:
> +        s->sram_soft_entry_reg0 =3D val;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset
> 0x%04x\n",
> +                      __func__, (uint32_t)offset);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps allwinner_sramc_ops =3D {
> +    .read =3D allwinner_sramc_read,
> +    .write =3D allwinner_sramc_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +    .impl.min_access_size =3D 4,
> +};
> +
> +static const VMStateDescription allwinner_sramc_vmstate =3D {
> +    .name =3D "allwinner-sramc",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(sram_ver, AwSRAMCState),
> +        VMSTATE_UINT32(sram_soft_entry_reg0, AwSRAMCState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void allwinner_sramc_reset(DeviceState *dev)
> +{
> +    AwSRAMCState *s =3D AW_SRAMC(dev);
> +    AwSRAMCClass *sc =3D AW_SRAMC_GET_CLASS(s);
> +
> +    switch (sc->sram_version_code) {
> +    case SRAM_VERSION_SUN8I_R40:
> +        s->sram_ctl1 =3D 0x1300;
> +        break;
> +    }
> +}
> +
> +static void allwinner_sramc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->reset =3D allwinner_sramc_reset;
> +    dc->vmsd =3D &allwinner_sramc_vmstate;
> +}
> +
> +static void allwinner_sramc_init(Object *obj)
> +{
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    AwSRAMCState *s =3D AW_SRAMC(obj);
> +
> +    /* Memory mapping */
> +    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_sramc_ops, s,
> +                           TYPE_AW_SRAMC, 1 * KiB);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static const TypeInfo allwinner_sramc_info =3D {
> +    .name          =3D TYPE_AW_SRAMC,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_init =3D allwinner_sramc_init,
> +    .instance_size =3D sizeof(AwSRAMCState),
> +    .class_init    =3D allwinner_sramc_class_init,
> +};
> +
> +static void allwinner_r40_sramc_class_init(ObjectClass *klass, void *dat=
a)
> +{
> +    AwSRAMCClass *sc =3D AW_SRAMC_CLASS(klass);
> +
> +    sc->sram_version_code =3D SRAM_VERSION_SUN8I_R40;
> +}
> +
> +static const TypeInfo allwinner_r40_sramc_info =3D {
> +    .name          =3D TYPE_AW_SRAMC_SUN8I_R40,
> +    .parent        =3D TYPE_AW_SRAMC,
> +    .class_init    =3D allwinner_r40_sramc_class_init,
> +};
> +
> +static void allwinner_sramc_register(void)
> +{
> +    type_register_static(&allwinner_sramc_info);
> +    type_register_static(&allwinner_r40_sramc_info);
> +}
> +
> +type_init(allwinner_sramc_register)
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index b04d43e05a..78ca857c9d 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -37,6 +37,7 @@ subdir('macio')
>
>  softmmu_ss.add(when: 'CONFIG_IVSHMEM_DEVICE', if_true: files('ivshmem.c'=
))
>
> +softmmu_ss.add(when: 'CONFIG_ALLWINNER_SRAMC', if_true:
> files('allwinner-sramc.c'))
>  softmmu_ss.add(when: 'CONFIG_ALLWINNER_A10_CCM', if_true:
> files('allwinner-a10-ccm.c'))
>  softmmu_ss.add(when: 'CONFIG_ALLWINNER_A10_DRAMC', if_true:
> files('allwinner-a10-dramc.c'))
>  softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true:
> files('allwinner-h3-ccu.c'))
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 8b68f07765..4d1a0e17af 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -33,6 +33,10 @@ allwinner_r40_dramphy_write(uint64_t offset, uint64_t
> data, unsigned size) "writ
>  allwinner_sid_read(uint64_t offset, uint64_t data, unsigned size) "offse=
t
> 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
>  allwinner_sid_write(uint64_t offset, uint64_t data, unsigned size)
> "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
>
> +# allwinner-sramc.c
> +allwinner_sramc_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64
> " data 0x%" PRIx64
> +allwinner_sramc_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx6=
4
> " data 0x%" PRIx64
> +
>  # avr_power.c
>  avr_power_read(uint8_t value) "power_reduc read value:%u"
>  avr_power_write(uint8_t value) "power_reduc write value:%u"
> diff --git a/include/hw/arm/allwinner-r40.h
> b/include/hw/arm/allwinner-r40.h
> index 5f2d08489e..72710d3edc 100644
> --- a/include/hw/arm/allwinner-r40.h
> +++ b/include/hw/arm/allwinner-r40.h
> @@ -27,6 +27,7 @@
>  #include "hw/sd/allwinner-sdhost.h"
>  #include "hw/misc/allwinner-r40-ccu.h"
>  #include "hw/misc/allwinner-r40-dramc.h"
> +#include "hw/misc/allwinner-sramc.h"
>  #include "hw/i2c/allwinner-i2c.h"
>  #include "hw/net/allwinner_emac.h"
>  #include "hw/net/allwinner-sun8i-emac.h"
> @@ -38,6 +39,7 @@ enum {
>      AW_R40_DEV_SRAM_A2,
>      AW_R40_DEV_SRAM_A3,
>      AW_R40_DEV_SRAM_A4,
> +    AW_R40_DEV_SRAMC,
>      AW_R40_DEV_EMAC,
>      AW_R40_DEV_MMC0,
>      AW_R40_DEV_MMC1,
> @@ -102,6 +104,7 @@ struct AwR40State {
>
>      ARMCPU cpus[AW_R40_NUM_CPUS];
>      const hwaddr *memmap;
> +    AwSRAMCState sramc;
>      AwA10PITState timer;
>      AwSdHostState mmc[AW_R40_NUM_MMCS];
>      AwR40ClockCtlState ccu;
> diff --git a/include/hw/misc/allwinner-sramc.h
> b/include/hw/misc/allwinner-sramc.h
> new file mode 100644
> index 0000000000..66b01b8d04
> --- /dev/null
> +++ b/include/hw/misc/allwinner-sramc.h
> @@ -0,0 +1,69 @@
> +/*
> + * Allwinner SRAM controller emulation
> + *
> + * Copyright (C) 2023 qianfan Zhao <qianfanguijin@163.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_MISC_ALLWINNER_SRAMC_H
> +#define HW_MISC_ALLWINNER_SRAMC_H
> +
> +#include "qom/object.h"
> +#include "hw/sysbus.h"
> +#include "qemu/uuid.h"
> +
> +/**
> + * Object model
> + * @{
> + */
> +#define TYPE_AW_SRAMC               "allwinner-sramc"
> +#define TYPE_AW_SRAMC_SUN8I_R40     TYPE_AW_SRAMC "-sun8i-r40"
> +OBJECT_DECLARE_TYPE(AwSRAMCState, AwSRAMCClass, AW_SRAMC)
> +
> +/** @} */
> +
> +/**
> + * Allwinner SRAMC object instance state
> + */
> +struct AwSRAMCState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    /** Maps I/O registers in physical memory */
> +    MemoryRegion iomem;
> +
> +    /* registers */
> +    uint32_t sram_ctl1;
> +    uint32_t sram_ver;
> +    uint32_t sram_soft_entry_reg0;
> +};
> +
> +/**
> + * Allwinner SRAM Controller class-level struct.
> + *
> + * This struct is filled by each sunxi device specific code
> + * such that the generic code can use this struct to support
> + * all devices.
> + */
> +struct AwSRAMCClass {
> +    /*< private >*/
> +    SysBusDeviceClass parent_class;
> +    /*< public >*/
> +
> +    uint32_t sram_version_code;
> +};
> +
> +#endif /* HW_MISC_ALLWINNER_SRAMC_H */
> --
> 2.25.1
>
>

--=20
Niek Linnenbank

--000000000000c554c805fbc0f972
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 10, 2023 at 12:30=E2=80=
=AFPM &lt;<a href=3D"mailto:qianfanguijin@163.com">qianfanguijin@163.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fro=
m: qianfan Zhao &lt;<a href=3D"mailto:qianfanguijin@163.com" target=3D"_bla=
nk">qianfanguijin@163.com</a>&gt;<br>
<br>
Only a few important registers are added, especially the SRAM_VER<br>
register.<br>
<br>
Signed-off-by: qianfan Zhao &lt;<a href=3D"mailto:qianfanguijin@163.com" ta=
rget=3D"_blank">qianfanguijin@163.com</a>&gt;<br></blockquote><div>Reviewed=
-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">niekli=
nnenbank@gmail.com</a>&gt;<br></div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
---<br>
=C2=A0hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0hw/arm/allwinner-r40.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A07 +-<br>
=C2=A0hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
=C2=A0hw/misc/allwinner-sramc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 184 ++++=
++++++++++++++++++++++++++<br>
=C2=A0hw/misc/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0hw/misc/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 =C2=A04 +<br>
=C2=A0include/hw/arm/allwinner-r40.h=C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
=C2=A0include/hw/misc/allwinner-sramc.h |=C2=A0 69 +++++++++++<br>
=C2=A08 files changed, 271 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 hw/misc/allwinner-sramc.c<br>
=C2=A0create mode 100644 include/hw/misc/allwinner-sramc.h<br>
<br>
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig<br>
index bad4ea158c..ae6f3911c5 100644<br>
--- a/hw/arm/Kconfig<br>
+++ b/hw/arm/Kconfig<br>
@@ -377,6 +377,7 @@ config ALLWINNER_H3<br>
=C2=A0config ALLWINNER_R40<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
=C2=A0 =C2=A0 =C2=A0default y if TCG &amp;&amp; ARM<br>
+=C2=A0 =C2=A0 select ALLWINNER_SRAMC<br>
=C2=A0 =C2=A0 =C2=A0select ALLWINNER_A10_PIT<br>
=C2=A0 =C2=A0 =C2=A0select AXP2XX_PMU<br>
=C2=A0 =C2=A0 =C2=A0select SERIAL<br>
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c<br>
index c018ad231a..7d29eb224f 100644<br>
--- a/hw/arm/allwinner-r40.c<br>
+++ b/hw/arm/allwinner-r40.c<br>
@@ -39,6 +39,7 @@ const hwaddr allwinner_r40_memmap[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_SRAM_A2]=C2=A0 =C2=A0 =3D 0x00004000,<br>
=C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_SRAM_A3]=C2=A0 =C2=A0 =3D 0x00008000,<br>
=C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_SRAM_A4]=C2=A0 =C2=A0 =3D 0x0000b400,<br>
+=C2=A0 =C2=A0 [AW_R40_DEV_SRAMC]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c00000,<br>
=C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_EMAC]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x01c0b=
000,<br>
=C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_MMC0]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x01c0f=
000,<br>
=C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_MMC1]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x01c10=
000,<br>
@@ -76,7 +77,6 @@ struct AwR40Unimplemented {<br>
=C2=A0static struct AwR40Unimplemented r40_unimplemented[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;d-engine&quot;,=C2=A0 =C2=A00x01000000, 4 * MiB=
 },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;d-inter&quot;,=C2=A0 =C2=A0 0x01400000, 128 * K=
iB },<br>
-=C2=A0 =C2=A0 { &quot;sram-c&quot;,=C2=A0 =C2=A0 =C2=A00x01c00000, 4 * KiB=
 },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;dma&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01c0200=
0, 4 * KiB },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;nfdc&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c0300=
0, 4 * KiB },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;ts&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x01=
c04000, 4 * KiB },<br>
@@ -288,6 +288,8 @@ static void allwinner_r40_init(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ram-addr&quot;);<br>
=C2=A0 =C2=A0 =C2=A0object_property_add_alias(obj, &quot;ram-size&quot;, OB=
JECT(&amp;s-&gt;dramc),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;ram-size&quot;);<br>
+<br>
+=C2=A0 =C2=A0 object_initialize_child(obj, &quot;sramc&quot;, &amp;s-&gt;s=
ramc, TYPE_AW_SRAMC_SUN8I_R40);<br>
=C2=A0}<br>
<br>
=C2=A0static void allwinner_r40_realize(DeviceState *dev, Error **errp)<br>
@@ -382,6 +384,9 @@ static void allwinner_r40_realize(DeviceState *dev, Err=
or **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 AW_R40_GIC_SPI_TIMER1));<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* SRAM */<br>
+=C2=A0 =C2=A0 sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;sramc), &amp;error_=
fatal);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;sramc), 0, s-&gt;m=
emmap[AW_R40_DEV_SRAMC]);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0memory_region_init_ram(&amp;s-&gt;sram_a1, OBJECT(dev),=
 &quot;sram A1&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A016 * KiB, &amp;error_abort);<br>
=C2=A0 =C2=A0 =C2=A0memory_region_init_ram(&amp;s-&gt;sram_a2, OBJECT(dev),=
 &quot;sram A2&quot;,<br>
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig<br>
index efeb430a6c..e4c2149175 100644<br>
--- a/hw/misc/Kconfig<br>
+++ b/hw/misc/Kconfig<br>
@@ -170,6 +170,9 @@ config VIRT_CTRL<br>
=C2=A0config LASI<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
<br>
+config ALLWINNER_SRAMC<br>
+=C2=A0 =C2=A0 bool<br>
+<br>
=C2=A0config ALLWINNER_A10_CCM<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
<br>
diff --git a/hw/misc/allwinner-sramc.c b/hw/misc/allwinner-sramc.c<br>
new file mode 100644<br>
index 0000000000..a8b731f8f2<br>
--- /dev/null<br>
+++ b/hw/misc/allwinner-sramc.c<br>
@@ -0,0 +1,184 @@<br>
+/*<br>
+ * Allwinner R40 SRAM controller emulation<br>
+ *<br>
+ * Copyright (C) 2023 qianfan Zhao &lt;<a href=3D"mailto:qianfanguijin@163=
.com" target=3D"_blank">qianfanguijin@163.com</a>&gt;<br>
+ *<br>
+ * This program is free software: you can redistribute it and/or modify<br=
>
+ * it under the terms of the GNU General Public License as published by<br=
>
+ * the Free Software Foundation, either version 2 of the License, or<br>
+ * (at your option) any later version.<br>
+ *<br>
+ * This program is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the<br>
+ * GNU General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License<br>
+ * along with this program.=C2=A0 If not, see &lt;<a href=3D"http://www.gn=
u.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/li=
censes/</a>&gt;.<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/units.h&quot;<br>
+#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;migration/vmstate.h&quot;<br>
+#include &quot;qemu/log.h&quot;<br>
+#include &quot;qemu/module.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/qdev-properties-system.h&quot;<br>
+#include &quot;hw/misc/allwinner-sramc.h&quot;<br>
+#include &quot;trace.h&quot;<br>
+<br>
+/*<br>
+ * register offsets<br>
+ * <a href=3D"https://linux-sunxi.org/SRAM_Controller_Register_Guide" rel=
=3D"noreferrer" target=3D"_blank">https://linux-sunxi.org/SRAM_Controller_R=
egister_Guide</a><br>
+ */<br>
+enum {<br>
+=C2=A0 =C2=A0 REG_SRAM_CTL1_CFG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D 0x04, /* SRAM Control register 1 */<br>
+=C2=A0 =C2=A0 REG_SRAM_VER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D 0x24, /* SRAM Version register */<br>
+=C2=A0 =C2=A0 REG_SRAM_R40_SOFT_ENTRY_REG0=C2=A0 =C2=A0 =3D 0xbc,<br>
+};<br>
+<br>
+/* REG_SRAMC_VERSION bit defines */<br>
+#define SRAM_VER_READ_ENABLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &=
lt;&lt; 15)<br>
+#define SRAM_VER_VERSION_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 16<br>
+#define SRAM_VERSION_SUN8I_R40=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1701<br=
>
+<br>
+static uint64_t allwinner_sramc_read(void *opaque, hwaddr offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned size)<b=
r>
+{<br>
+=C2=A0 =C2=A0 AwSRAMCState *s =3D AW_SRAMC(opaque);<br>
+=C2=A0 =C2=A0 AwSRAMCClass *sc =3D AW_SRAMC_GET_CLASS(s);<br>
+=C2=A0 =C2=A0 uint64_t val =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 switch (offset) {<br>
+=C2=A0 =C2=A0 case REG_SRAM_CTL1_CFG:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt;sram_ctl1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SRAM_VER:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* bit15: lock bit, set this bit before readin=
g this register */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;sram_ver &amp; SRAM_VER_READ_ENABLE)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D SRAM_VER_READ_ENABLE |<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (sc-=
&gt;sram_version_code &lt;&lt; SRAM_VER_VERSION_SHIFT);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SRAM_R40_SOFT_ENTRY_REG0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt;sram_soft_entry_reg0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: out-o=
f-bounds offset 0x%04x\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__, (uint32_t)offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 trace_allwinner_sramc_read(offset, val);<br>
+<br>
+=C2=A0 =C2=A0 return val;<br>
+}<br>
+<br>
+static void allwinner_sramc_write(void *opaque, hwaddr offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t val, unsigned size)<=
br>
+{<br>
+=C2=A0 =C2=A0 AwSRAMCState *s =3D AW_SRAMC(opaque);<br>
+<br>
+=C2=A0 =C2=A0 trace_allwinner_sramc_write(offset, val);<br>
+<br>
+=C2=A0 =C2=A0 switch (offset) {<br>
+=C2=A0 =C2=A0 case REG_SRAM_CTL1_CFG:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;sram_ctl1 =3D val;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SRAM_VER:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Only the READ_ENABLE bit is writeable */<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;sram_ver =3D val &amp; SRAM_VER_READ_ENA=
BLE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SRAM_R40_SOFT_ENTRY_REG0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;sram_soft_entry_reg0 =3D val;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: out-o=
f-bounds offset 0x%04x\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__, (uint32_t)offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static const MemoryRegionOps allwinner_sramc_ops =3D {<br>
+=C2=A0 =C2=A0 .read =3D allwinner_sramc_read,<br>
+=C2=A0 =C2=A0 .write =3D allwinner_sramc_write,<br>
+=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
+=C2=A0 =C2=A0 .valid =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 .impl.min_access_size =3D 4,<br>
+};<br>
+<br>
+static const VMStateDescription allwinner_sramc_vmstate =3D {<br>
+=C2=A0 =C2=A0 .name =3D &quot;allwinner-sramc&quot;,<br>
+=C2=A0 =C2=A0 .version_id =3D 1,<br>
+=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
+=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(sram_ver, AwSRAMCState),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(sram_soft_entry_reg0, AwSRAMCSt=
ate),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
+=C2=A0 =C2=A0 }<br>
+};<br>
+<br>
+static void allwinner_sramc_reset(DeviceState *dev)<br>
+{<br>
+=C2=A0 =C2=A0 AwSRAMCState *s =3D AW_SRAMC(dev);<br>
+=C2=A0 =C2=A0 AwSRAMCClass *sc =3D AW_SRAMC_GET_CLASS(s);<br>
+<br>
+=C2=A0 =C2=A0 switch (sc-&gt;sram_version_code) {<br>
+=C2=A0 =C2=A0 case SRAM_VERSION_SUN8I_R40:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;sram_ctl1 =3D 0x1300;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void allwinner_sramc_class_init(ObjectClass *klass, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
+<br>
+=C2=A0 =C2=A0 dc-&gt;reset =3D allwinner_sramc_reset;<br>
+=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;allwinner_sramc_vmstate;<br>
+}<br>
+<br>
+static void allwinner_sramc_init(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);<br>
+=C2=A0 =C2=A0 AwSRAMCState *s =3D AW_SRAMC(obj);<br>
+<br>
+=C2=A0 =C2=A0 /* Memory mapping */<br>
+=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem, OBJECT(s), &amp;allw=
inner_sramc_ops, s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0TYPE_AW_SRAMC, 1 * KiB);<br>
+=C2=A0 =C2=A0 sysbus_init_mmio(sbd, &amp;s-&gt;iomem);<br>
+}<br>
+<br>
+static const TypeInfo allwinner_sramc_info =3D {<br>
+=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_SRAMC,<b=
r>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEVICE,<=
br>
+=C2=A0 =C2=A0 .instance_init =3D allwinner_sramc_init,<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(AwSRAMCState),<br>
+=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D allwinner_sramc_class_init,<br>
+};<br>
+<br>
+static void allwinner_r40_sramc_class_init(ObjectClass *klass, void *data)=
<br>
+{<br>
+=C2=A0 =C2=A0 AwSRAMCClass *sc =3D AW_SRAMC_CLASS(klass);<br>
+<br>
+=C2=A0 =C2=A0 sc-&gt;sram_version_code =3D SRAM_VERSION_SUN8I_R40;<br>
+}<br>
+<br>
+static const TypeInfo allwinner_r40_sramc_info =3D {<br>
+=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_SRAMC_SU=
N8I_R40,<br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_SRAMC,<br>
+=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D allwinner_r40_sramc_class_init,=
<br>
+};<br>
+<br>
+static void allwinner_sramc_register(void)<br>
+{<br>
+=C2=A0 =C2=A0 type_register_static(&amp;allwinner_sramc_info);<br>
+=C2=A0 =C2=A0 type_register_static(&amp;allwinner_r40_sramc_info);<br>
+}<br>
+<br>
+type_init(allwinner_sramc_register)<br>
diff --git a/hw/misc/meson.build b/hw/misc/meson.build<br>
index b04d43e05a..78ca857c9d 100644<br>
--- a/hw/misc/meson.build<br>
+++ b/hw/misc/meson.build<br>
@@ -37,6 +37,7 @@ subdir(&#39;macio&#39;)<br>
<br>
=C2=A0softmmu_ss.add(when: &#39;CONFIG_IVSHMEM_DEVICE&#39;, if_true: files(=
&#39;ivshmem.c&#39;))<br>
<br>
+softmmu_ss.add(when: &#39;CONFIG_ALLWINNER_SRAMC&#39;, if_true: files(&#39=
;allwinner-sramc.c&#39;))<br>
=C2=A0softmmu_ss.add(when: &#39;CONFIG_ALLWINNER_A10_CCM&#39;, if_true: fil=
es(&#39;allwinner-a10-ccm.c&#39;))<br>
=C2=A0softmmu_ss.add(when: &#39;CONFIG_ALLWINNER_A10_DRAMC&#39;, if_true: f=
iles(&#39;allwinner-a10-dramc.c&#39;))<br>
=C2=A0softmmu_ss.add(when: &#39;CONFIG_ALLWINNER_H3&#39;, if_true: files(&#=
39;allwinner-h3-ccu.c&#39;))<br>
diff --git a/hw/misc/trace-events b/hw/misc/trace-events<br>
index 8b68f07765..4d1a0e17af 100644<br>
--- a/hw/misc/trace-events<br>
+++ b/hw/misc/trace-events<br>
@@ -33,6 +33,10 @@ allwinner_r40_dramphy_write(uint64_t offset, uint64_t da=
ta, unsigned size) &quot;writ<br>
=C2=A0allwinner_sid_read(uint64_t offset, uint64_t data, unsigned size) &qu=
ot;offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64 &quot; size %&quot;=
 PRIu32<br>
=C2=A0allwinner_sid_write(uint64_t offset, uint64_t data, unsigned size) &q=
uot;offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64 &quot; size %&quot=
; PRIu32<br>
<br>
+# allwinner-sramc.c<br>
+allwinner_sramc_read(uint64_t offset, uint64_t data) &quot;offset 0x%&quot=
; PRIx64 &quot; data 0x%&quot; PRIx64<br>
+allwinner_sramc_write(uint64_t offset, uint64_t data) &quot;offset 0x%&quo=
t; PRIx64 &quot; data 0x%&quot; PRIx64<br>
+<br>
=C2=A0# avr_power.c<br>
=C2=A0avr_power_read(uint8_t value) &quot;power_reduc read value:%u&quot;<b=
r>
=C2=A0avr_power_write(uint8_t value) &quot;power_reduc write value:%u&quot;=
<br>
diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.=
h<br>
index 5f2d08489e..72710d3edc 100644<br>
--- a/include/hw/arm/allwinner-r40.h<br>
+++ b/include/hw/arm/allwinner-r40.h<br>
@@ -27,6 +27,7 @@<br>
=C2=A0#include &quot;hw/sd/allwinner-sdhost.h&quot;<br>
=C2=A0#include &quot;hw/misc/allwinner-r40-ccu.h&quot;<br>
=C2=A0#include &quot;hw/misc/allwinner-r40-dramc.h&quot;<br>
+#include &quot;hw/misc/allwinner-sramc.h&quot;<br>
=C2=A0#include &quot;hw/i2c/allwinner-i2c.h&quot;<br>
=C2=A0#include &quot;hw/net/allwinner_emac.h&quot;<br>
=C2=A0#include &quot;hw/net/allwinner-sun8i-emac.h&quot;<br>
@@ -38,6 +39,7 @@ enum {<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_DEV_SRAM_A2,<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_DEV_SRAM_A3,<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_DEV_SRAM_A4,<br>
+=C2=A0 =C2=A0 AW_R40_DEV_SRAMC,<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_DEV_EMAC,<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_DEV_MMC0,<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_DEV_MMC1,<br>
@@ -102,6 +104,7 @@ struct AwR40State {<br>
<br>
=C2=A0 =C2=A0 =C2=A0ARMCPU cpus[AW_R40_NUM_CPUS];<br>
=C2=A0 =C2=A0 =C2=A0const hwaddr *memmap;<br>
+=C2=A0 =C2=A0 AwSRAMCState sramc;<br>
=C2=A0 =C2=A0 =C2=A0AwA10PITState timer;<br>
=C2=A0 =C2=A0 =C2=A0AwSdHostState mmc[AW_R40_NUM_MMCS];<br>
=C2=A0 =C2=A0 =C2=A0AwR40ClockCtlState ccu;<br>
diff --git a/include/hw/misc/allwinner-sramc.h b/include/hw/misc/allwinner-=
sramc.h<br>
new file mode 100644<br>
index 0000000000..66b01b8d04<br>
--- /dev/null<br>
+++ b/include/hw/misc/allwinner-sramc.h<br>
@@ -0,0 +1,69 @@<br>
+/*<br>
+ * Allwinner SRAM controller emulation<br>
+ *<br>
+ * Copyright (C) 2023 qianfan Zhao &lt;<a href=3D"mailto:qianfanguijin@163=
.com" target=3D"_blank">qianfanguijin@163.com</a>&gt;<br>
+ *<br>
+ * This program is free software: you can redistribute it and/or modify<br=
>
+ * it under the terms of the GNU General Public License as published by<br=
>
+ * the Free Software Foundation, either version 2 of the License, or<br>
+ * (at your option) any later version.<br>
+ *<br>
+ * This program is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the<br>
+ * GNU General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License<br>
+ * along with this program.=C2=A0 If not, see &lt;<a href=3D"http://www.gn=
u.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/li=
censes/</a>&gt;.<br>
+ */<br>
+<br>
+#ifndef HW_MISC_ALLWINNER_SRAMC_H<br>
+#define HW_MISC_ALLWINNER_SRAMC_H<br>
+<br>
+#include &quot;qom/object.h&quot;<br>
+#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;qemu/uuid.h&quot;<br>
+<br>
+/**<br>
+ * Object model<br>
+ * @{<br>
+ */<br>
+#define TYPE_AW_SRAMC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;allwinner-sramc&quot;<br>
+#define TYPE_AW_SRAMC_SUN8I_R40=C2=A0 =C2=A0 =C2=A0TYPE_AW_SRAMC &quot;-su=
n8i-r40&quot;<br>
+OBJECT_DECLARE_TYPE(AwSRAMCState, AwSRAMCClass, AW_SRAMC)<br>
+<br>
+/** @} */<br>
+<br>
+/**<br>
+ * Allwinner SRAMC object instance state<br>
+ */<br>
+struct AwSRAMCState {<br>
+=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
+=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
+=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
+<br>
+=C2=A0 =C2=A0 /** Maps I/O registers in physical memory */<br>
+=C2=A0 =C2=A0 MemoryRegion iomem;<br>
+<br>
+=C2=A0 =C2=A0 /* registers */<br>
+=C2=A0 =C2=A0 uint32_t sram_ctl1;<br>
+=C2=A0 =C2=A0 uint32_t sram_ver;<br>
+=C2=A0 =C2=A0 uint32_t sram_soft_entry_reg0;<br>
+};<br>
+<br>
+/**<br>
+ * Allwinner SRAM Controller class-level struct.<br>
+ *<br>
+ * This struct is filled by each sunxi device specific code<br>
+ * such that the generic code can use this struct to support<br>
+ * all devices.<br>
+ */<br>
+struct AwSRAMCClass {<br>
+=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
+=C2=A0 =C2=A0 SysBusDeviceClass parent_class;<br>
+=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
+<br>
+=C2=A0 =C2=A0 uint32_t sram_version_code;<br>
+};<br>
+<br>
+#endif /* HW_MISC_ALLWINNER_SRAMC_H */<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"l=
tr"><div>Niek Linnenbank<br><br></div></div></div></div>

--000000000000c554c805fbc0f972--

