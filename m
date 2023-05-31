Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0C0718B29
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:28:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SQp-0004xx-7z; Wed, 31 May 2023 16:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SQn-0004va-3C
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:28:29 -0400
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SQk-0001gh-U2
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:28:28 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N6LIF-1qAgZU0btJ-016gTz; Wed, 31 May 2023 22:28:25 +0200
Message-ID: <77792955-cc9d-9f2a-43ad-e3c16208810e@vivier.eu>
Date: Wed, 31 May 2023 22:28:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 10/23] q800: reimplement mac-io region aliasing using
 IO memory region
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-11-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230531125400.288917-11-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GrbwOwuD3oBXmT7FT8EU0aUWgaDqBzLBS7pP3U3IujImNE/cVKL
 0uB/L6f1LZQ6jt2pIZCrqFMrk/6WLHwdbVDM+BC4hUqCSXe9Ymdch64hfp9Lw2eDCciErHI
 X07UGQ97fo7mUtuGELBGcoNCXk/adwcwl3jAHZPM5Cd+QhV3p1FvwS2I0z71rY0uhwo1fEH
 8fT/B4KZO7G67zFa5Kyrg==
UI-OutboundReport: notjunk:1;M01:P0:TQOWeAkZfNs=;fqre9eaV+uVdmuCkPqjtum9UOKN
 nPqMYiTr56oE4GaXfOW2oGFjzC7Ts2WQU66ou4xOtcAmIT2B9KsvUjdaoXYA9oSp21vtSMEDe
 vnt7GrkRbaM+PcjIRPX6Ex2MvQjCYVUJlh0+4+P/x4AI4gxMEh1lW1rCCtWdpZzePfCFkzfFN
 6d5a3uEsLbzs9vsDkgV2Ze7kKSWY5uWRj56bkaqP2EKT0YsuOEy4dOA8vD4v8L/8ZDff6Db9u
 TGdZ2c1L5ZNV2gb3nSTSgk0T2o4Sa6dCaEIOgoQr3l2h37skTsnGU0XC7XuGIzHDkxLvHAHqz
 u+p7Cc3JTqy5zVX+GkLsHLlNn7FJrNzLO8zpKraB3FPWpdl28zKIZTgRs+AbDfMlFAaf4zPvE
 oTzOFRPsQblrxI7JXkv9NiW1aPSLsNHAYVD1zvOZ6HZhVS3SydGg0vQOHntqRi2zlFzkDJpiM
 uUCraLh4RHhRngPaz4Qtn7LWtNOLonx5fWo9U1SKuVEDLnkt44MFjQjKOftc+iNbTiZPciyRZ
 QdA+hSVj6kknGfDTVFmoPQTVKxGwj4WA4RyV8mqUjTAKSeEiGwpaUtp56FHn+jQFzr8Eu/Fu1
 LJHhaO2sJt5I9V8vWS27c8KIIkKus9qLxIwgYljPN64l5WDIXYuuAG05k5lo9/zcmNSVDAxsM
 Hd6zuL+GSXOpwNCaUg0Snc1d8A1CCsMZtAsDGr2rNA==
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Le 31/05/2023 à 14:53, Mark Cave-Ayland a écrit :
> The current use of aliased memory regions causes us 2 problems: firstly the
> output of "info qom-tree" is absolutely huge and difficult to read, and
> secondly we have already reached the internal limit for memory regions as
> adding any new memory region into the mac-io region causes QEMU to assert
> with "phys_section_add: Assertion `map->sections_nb < TARGET_PAGE_SIZE'
> failed".
> 
> Implement the mac-io region aliasing using a single IO memory region that
> applies IO_SLICE_MASK representing the maximum size of the aliased region and
> then forwarding the access to the existing mac-io memory region using the
> address space API.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 100 +++++++++++++++++++++++++++++++++--------
>   include/hw/m68k/q800.h |   1 +
>   2 files changed, 82 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 2394d14c97..785a67b0a9 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -59,6 +59,7 @@
>   
>   #define IO_BASE               0x50000000
>   #define IO_SLICE              0x00040000
> +#define IO_SLICE_MASK         (IO_SLICE - 1)
>   #define IO_SIZE               0x04000000
>   
>   #define VIA_BASE              (IO_BASE + 0x00000)
> @@ -127,6 +128,68 @@ static uint8_t fake_mac_rom[] = {
>       0x60, 0xFE                          /* bras [self] */
>   };
>   
> +static MemTxResult macio_alias_read(void *opaque, hwaddr addr, uint64_t *data,
> +                                    unsigned size, MemTxAttrs attrs)
> +{
> +    MemTxResult r;
> +    uint32_t val;
> +
> +    addr &= IO_SLICE_MASK;
> +    addr |= IO_BASE;
> +
> +    switch (size) {
> +    case 4:
> +        val = address_space_ldl_be(&address_space_memory, addr, attrs, &r);
> +        break;
> +    case 2:
> +        val = address_space_lduw_be(&address_space_memory, addr, attrs, &r);
> +        break;
> +    case 1:
> +        val = address_space_ldub(&address_space_memory, addr, attrs, &r);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    *data = val;
> +    return r;
> +}
> +
> +static MemTxResult macio_alias_write(void *opaque, hwaddr addr, uint64_t value,
> +                                     unsigned size, MemTxAttrs attrs)
> +{
> +    MemTxResult r;
> +
> +    addr &= IO_SLICE_MASK;
> +    addr |= IO_BASE;
> +
> +    switch (size) {
> +    case 4:
> +        address_space_stl_be(&address_space_memory, addr, value, attrs, &r);
> +        break;
> +    case 2:
> +        address_space_stw_be(&address_space_memory, addr, value, attrs, &r);
> +        break;
> +    case 1:
> +        address_space_stb(&address_space_memory, addr, value, attrs, &r);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    return r;
> +}
> +
> +static const MemoryRegionOps macio_alias_ops = {
> +    .read_with_attrs = macio_alias_read,
> +    .write_with_attrs = macio_alias_write,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +};
> +
>   static void q800_machine_init(MachineState *machine)
>   {
>       Q800MachineState *m = Q800_MACHINE(machine);
> @@ -137,10 +200,8 @@ static void q800_machine_init(MachineState *machine)
>       int bios_size;
>       ram_addr_t initrd_base;
>       int32_t initrd_size;
> -    MemoryRegion *io;
>       MemoryRegion *dp8393x_prom = g_new(MemoryRegion, 1);
>       uint8_t *prom;
> -    const int io_slice_nb = (IO_SIZE / IO_SLICE) - 1;
>       int i, checksum;
>       MacFbMode *macfb_mode;
>       ram_addr_t ram_size = machine->ram_size;
> @@ -188,16 +249,10 @@ static void q800_machine_init(MachineState *machine)
>        * Memory from IO_BASE to IO_BASE + IO_SLICE is repeated
>        * from IO_BASE + IO_SLICE to IO_BASE + IO_SIZE
>        */
> -    io = g_new(MemoryRegion, io_slice_nb);
> -    for (i = 0; i < io_slice_nb; i++) {
> -        char *name = g_strdup_printf("mac_m68k.io[%d]", i + 1);
> -
> -        memory_region_init_alias(&io[i], NULL, name, get_system_memory(),
> -                                 IO_BASE, IO_SLICE);
> -        memory_region_add_subregion(get_system_memory(),
> -                                    IO_BASE + (i + 1) * IO_SLICE, &io[i]);
> -        g_free(name);
> -    }
> +    memory_region_init_io(&m->macio_alias, OBJECT(machine), &macio_alias_ops,
> +                          &m->macio, "mac-io.alias", IO_SIZE - IO_SLICE);
> +    memory_region_add_subregion(get_system_memory(), IO_BASE + IO_SLICE,
> +                                &m->macio_alias);
>   
>       /* IRQ Glue */
>       object_initialize_child(OBJECT(machine), "glue", &m->glue, TYPE_GLUE);
> @@ -213,7 +268,8 @@ static void q800_machine_init(MachineState *machine)
>       }
>       sysbus = SYS_BUS_DEVICE(via1_dev);
>       sysbus_realize_and_unref(sysbus, &error_fatal);
> -    sysbus_mmio_map(sysbus, 1, VIA_BASE);
> +    memory_region_add_subregion(&m->macio, VIA_BASE - IO_BASE,
> +                                sysbus_mmio_get_region(sysbus, 1));
>       sysbus_connect_irq(sysbus, 0,
>                          qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_VIA1));
>       /* A/UX mode */
> @@ -231,7 +287,8 @@ static void q800_machine_init(MachineState *machine)
>       via2_dev = qdev_new(TYPE_MOS6522_Q800_VIA2);
>       sysbus = SYS_BUS_DEVICE(via2_dev);
>       sysbus_realize_and_unref(sysbus, &error_fatal);
> -    sysbus_mmio_map(sysbus, 1, VIA_BASE + VIA_SIZE);
> +    memory_region_add_subregion(&m->macio, VIA_BASE - IO_BASE + VIA_SIZE,
> +                                sysbus_mmio_get_region(sysbus, 1));
>       sysbus_connect_irq(sysbus, 0,
>                          qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_VIA2));
>   
> @@ -265,7 +322,8 @@ static void q800_machine_init(MachineState *machine)
>                                OBJECT(get_system_memory()), &error_abort);
>       sysbus = SYS_BUS_DEVICE(dev);
>       sysbus_realize_and_unref(sysbus, &error_fatal);
> -    sysbus_mmio_map(sysbus, 0, SONIC_BASE);
> +    memory_region_add_subregion(&m->macio, SONIC_BASE - IO_BASE,
> +                                sysbus_mmio_get_region(sysbus, 0));
>       sysbus_connect_irq(sysbus, 0,
>                          qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_SONIC));
>   
> @@ -306,7 +364,8 @@ static void q800_machine_init(MachineState *machine)
>       qdev_connect_gpio_out(DEVICE(escc_orgate), 0,
>                             qdev_get_gpio_in(DEVICE(&m->glue),
>                                              GLUE_IRQ_IN_ESCC));
> -    sysbus_mmio_map(sysbus, 0, SCC_BASE);
> +    memory_region_add_subregion(&m->macio, SCC_BASE - IO_BASE,
> +                                sysbus_mmio_get_region(sysbus, 0));
>   
>       /* SCSI */
>   
> @@ -326,8 +385,10 @@ static void q800_machine_init(MachineState *machine)
>                                                     VIA2_IRQ_SCSI_BIT)));
>       sysbus_connect_irq(sysbus, 1, qemu_irq_invert(qdev_get_gpio_in(via2_dev,
>                                                     VIA2_IRQ_SCSI_DATA_BIT)));
> -    sysbus_mmio_map(sysbus, 0, ESP_BASE);
> -    sysbus_mmio_map(sysbus, 1, ESP_PDMA);
> +    memory_region_add_subregion(&m->macio, ESP_BASE - IO_BASE,
> +                                sysbus_mmio_get_region(sysbus, 0));
> +    memory_region_add_subregion(&m->macio, ESP_PDMA - IO_BASE,
> +                                sysbus_mmio_get_region(sysbus, 1));
>   
>       scsi_bus_legacy_handle_cmdline(&esp->bus);
>   
> @@ -335,7 +396,8 @@ static void q800_machine_init(MachineState *machine)
>   
>       dev = qdev_new(TYPE_SWIM);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, SWIM_BASE);
> +    memory_region_add_subregion(&m->macio, SWIM_BASE - IO_BASE,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
>   
>       /* NuBus */
>   
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index b9de8e36cd..81598af627 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -36,6 +36,7 @@ struct Q800MachineState {
>       MemoryRegion rom;
>       GLUEState glue;
>       MemoryRegion macio;
> +    MemoryRegion macio_alias;
>   };
>   
>   #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


