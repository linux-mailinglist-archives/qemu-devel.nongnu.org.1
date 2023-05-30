Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B14715D16
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:24:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xSY-0000bp-CJ; Tue, 30 May 2023 07:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xSN-0000Mg-PH
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:24:04 -0400
Received: from mout.kundenserver.de ([217.72.192.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xSL-00064r-Sg
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:24:03 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MYvPq-1pZ6mF3v2e-00UuBC; Tue, 30 May 2023 13:24:00 +0200
Message-ID: <43fe3b34-40cd-4890-a001-1f0e78c183e6@vivier.eu>
Date: Tue, 30 May 2023 13:23:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 08/30] q800: reimplement mac-io region aliasing using IO
 memory region
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-9-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230524211104.686087-9-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GvbuMrYmr3Az+jGIzRd/m138uFSIKPXidJTu0aYZ8oRO0hKkGlX
 nSoKX29woAI6sxbXOT6qWR3C1hwYFexU/Lkv5cyF6tB5yIM9CnYWwzTPCsoYhTeHbqTDuMh
 dWJAnXSWQKZryg5n1hiuZlNWjfVfbP9zw4h3cFpQQlCA/42MtkPHlZq7FJawmVKUAeiUUkr
 dQ0F5h9KUOIe/fFo9Iweg==
UI-OutboundReport: notjunk:1;M01:P0:GlSYE0SQBro=;61/4jzY6v51sY+RzTpA0pfsPLfS
 DIBLPlu3VEPfexWGNU5FjZcYPORI3Vm/e4vWq3Uu0Fk7UmTt7LtUOAU5vSbkoZI5ArpSUrGtW
 H+h52ykrOLcwIpnkKn/O6XHDOBVwdC9r8lloYCTN2IHFjwPA2n/46BTX7ApqyDSpHpU6jqD8Z
 oxexwLDeq0Jogx+QHoXbYzPeYOesAKGKjYrWhZlzOAuB31Cg/khT7JDieFd98Eqi/e70Xiii5
 qZLetKgTrPOUKk6lZ2LLxHTw4Wdl4eDgMwFKEzgDe4J2YEVtRRr0Z7L5tZP+KsGJeJymnKTKZ
 DKB5g8XIM9LV4/CoB0bx+gnbPfYtKtmaW4XuyDnjTBkX7RdoYyqmYNKhH1Nghfzru8OAFj4XI
 aPFH9eypxW61PYaIviBnv1ghKpzZJR9t7sMeg+UpilytFKKgYGxHenKBvDsvdKsRF+B+LEnW+
 aN/c8tEEd1JUuL048L5y58SAPN8lEuym6cPSKEwwzJSaIc7CN/ueFwP1eE+ml6OskNKyPwH3g
 ndhy5uOOt+i9EPJhWUZqwgP10iVmFX9OlT97mEJmc5y2quY5ZNfXJrulc6wjtNP+q+fThm8OO
 AkYKW0li8AapxEJNhgX2F4w4EoQIt1xCxJP6vRicZ0xr3ZRzGZ+AVK3KEpUqcYMV1aY8AnNm2
 9BoiO5D0ZjRnxx++x2OCWQ+rSjaagMnc8sDDmUqZWQ==
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Le 24/05/2023 à 23:10, Mark Cave-Ayland a écrit :
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
> index 6399631ed0..f15f1eaff9 100644
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
> @@ -361,6 +362,68 @@ static uint8_t fake_mac_rom[] = {
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
> @@ -371,10 +434,8 @@ static void q800_machine_init(MachineState *machine)
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
> @@ -420,16 +481,10 @@ static void q800_machine_init(MachineState *machine)
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
> +    memory_region_init_io(&m->macio_alias, NULL, &macio_alias_ops, &m->macio,
> +                          "mac-io.alias", IO_SIZE - IO_SLICE);
> +    memory_region_add_subregion(get_system_memory(), IO_BASE + IO_SLICE,
> +                                &m->macio_alias);
>   
>       /* IRQ Glue */
>       m->glue = qdev_new(TYPE_GLUE);
> @@ -445,7 +500,8 @@ static void q800_machine_init(MachineState *machine)
>       }
>       sysbus = SYS_BUS_DEVICE(via1_dev);
>       sysbus_realize_and_unref(sysbus, &error_fatal);
> -    sysbus_mmio_map(sysbus, 1, VIA_BASE);
> +    memory_region_add_subregion(&m->macio, VIA_BASE - IO_BASE,
> +                                sysbus_mmio_get_region(sysbus, 1));
>       sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(m->glue, GLUE_IRQ_IN_VIA1));
>       /* A/UX mode */
>       qdev_connect_gpio_out(via1_dev, 0,
> @@ -461,7 +517,8 @@ static void q800_machine_init(MachineState *machine)
>       via2_dev = qdev_new(TYPE_MOS6522_Q800_VIA2);
>       sysbus = SYS_BUS_DEVICE(via2_dev);
>       sysbus_realize_and_unref(sysbus, &error_fatal);
> -    sysbus_mmio_map(sysbus, 1, VIA_BASE + VIA_SIZE);
> +    memory_region_add_subregion(&m->macio, VIA_BASE - IO_BASE + VIA_SIZE,
> +                                sysbus_mmio_get_region(sysbus, 1));
>       sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(m->glue, GLUE_IRQ_IN_VIA2));
>   
>       /* MACSONIC */
> @@ -494,7 +551,8 @@ static void q800_machine_init(MachineState *machine)
>                                OBJECT(get_system_memory()), &error_abort);
>       sysbus = SYS_BUS_DEVICE(dev);
>       sysbus_realize_and_unref(sysbus, &error_fatal);
> -    sysbus_mmio_map(sysbus, 0, SONIC_BASE);
> +    memory_region_add_subregion(&m->macio, SONIC_BASE - IO_BASE,
> +                                sysbus_mmio_get_region(sysbus, 0));
>       sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(m->glue, GLUE_IRQ_IN_SONIC));
>   
>       memory_region_init_rom(dp8393x_prom, NULL, "dp8393x-q800.prom",
> @@ -533,7 +591,8 @@ static void q800_machine_init(MachineState *machine)
>       sysbus_connect_irq(sysbus, 1, qdev_get_gpio_in(escc_orgate, 1));
>       qdev_connect_gpio_out(DEVICE(escc_orgate), 0,
>                             qdev_get_gpio_in(m->glue, GLUE_IRQ_IN_ESCC));
> -    sysbus_mmio_map(sysbus, 0, SCC_BASE);
> +    memory_region_add_subregion(&m->macio, SCC_BASE - IO_BASE,
> +                                sysbus_mmio_get_region(sysbus, 0));
>   
>       /* SCSI */
>   
> @@ -553,8 +612,10 @@ static void q800_machine_init(MachineState *machine)
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
> @@ -562,7 +623,8 @@ static void q800_machine_init(MachineState *machine)
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
> index 156872a124..8d788a7072 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -34,6 +34,7 @@ struct Q800MachineState {
>       MemoryRegion rom;
>       DeviceState *glue;
>       MemoryRegion macio;
> +    MemoryRegion macio_alias;
>   };
>   
>   #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


