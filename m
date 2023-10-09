Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2327BDA7B
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 13:57:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qposk-0000z5-Qo; Mon, 09 Oct 2023 07:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qposi-0000yV-80; Mon, 09 Oct 2023 07:57:04 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qposd-0005VW-Pp; Mon, 09 Oct 2023 07:57:03 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 8EE6674632B;
 Mon,  9 Oct 2023 13:56:05 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 38A827456AC; Mon,  9 Oct 2023 13:56:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 36DF8745681;
 Mon,  9 Oct 2023 13:56:05 +0200 (CEST)
Date: Mon, 9 Oct 2023 13:56:05 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org, 
 Bernhard Beschow <shentey@gmail.com>, Rene Engel <ReneEngel80@emailn.de>, 
 vr_qemu@t-online.de
Subject: Re: [PATCH 3/3] hw/ppc: Add emulation of AmigaOne XE board
In-Reply-To: <12262a4d-c806-1de6-b814-5c18560ed06d@linaro.org>
Message-ID: <5bb6f1ed-066d-8e60-15fc-3b1ec47c5e4a@eik.bme.hu>
References: <cover.1696542537.git.balaton@eik.bme.hu>
 <624a60acb0b81e6837b249890c59f3010ab12bbc.1696542537.git.balaton@eik.bme.hu>
 <12262a4d-c806-1de6-b814-5c18560ed06d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-861907120-1696852565=:71180"
X-Spam-Probability: 11%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-861907120-1696852565=:71180
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 9 Oct 2023, Philippe Mathieu-Daudé wrote:
> Hi Zoltan,
>
> On 6/10/23 00:13, BALATON Zoltan wrote:
>> The AmigaOne is a rebranded MAI Teron board that uses U-Boot firmware
>> with patches to support AmigaOS and is very similar to pegasos2 so can
>> be easily emulated sharing most code with pegasos2. The reason to
>> emulate it is that AmigaOS comes in different versions for AmigaOne
>> and PegasosII which only have drivers for one machine and firmware so
>> these only run on the specific machine. Adding this board allows
>> another AmigaOS version to be used reusing already existing peagasos2
>> emulation. (The AmigaOne was the first of these boards so likely most
>> widespread which then inspired Pegasos that was later replaced with
>> PegasosII due to problems with Articia S, so these have a lot of
>> similarity. Pegasos mainly ran MorphOS while the PegasosII version of
>> AmigaOS was added later and therefore less common than the AmigaOne
>> version.)
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   MAINTAINERS                             |   8 ++
>>   configs/devices/ppc-softmmu/default.mak |   1 +
>>   hw/ppc/Kconfig                          |   7 +
>>   hw/ppc/amigaone.c                       | 164 ++++++++++++++++++++++++
>>   hw/ppc/meson.build                      |   2 +
>>   5 files changed, 182 insertions(+)
>>   create mode 100644 hw/ppc/amigaone.c
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7f0e20fde6..03f908c153 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1490,6 +1490,14 @@ F: hw/pci-host/mv64361.c
>>   F: hw/pci-host/mv643xx.h
>>   F: include/hw/pci-host/mv64361.h
>>   +amigaone
>
> 'AmigaOne' like in subject and description?

The machine option is called amigaone and for pegasos2 and sam460ex I've 
also used the machine name so for consistency it's the same here.

>> +M: BALATON Zoltan <balaton@eik.bme.hu>
>> +L: qemu-ppc@nongnu.org
>> +S: Maintained
>> +F: hw/ppc/amigaone.c
>> +F: hw/pci-host/articia.c
>> +F: include/hw/pci-host/articia.h
>> +
>>   Virtual Open Firmware (VOF)
>>   M: Alexey Kardashevskiy <aik@ozlabs.ru>
>
>
>> +static void amigaone_init(MachineState *machine)
>> +{
>> +    PowerPCCPU *cpu;
>> +    CPUPPCState *env;
>> +    MemoryRegion *rom, *pci_mem, *mr;
>> +    const char *fwname = machine->firmware ?: PROM_FILENAME;
>> +    char *filename;
>> +    ssize_t sz;
>> +    PCIBus *pci_bus;
>> +    Object *via;
>> +    DeviceState *dev;
>> +    I2CBus *i2c_bus;
>> +    uint8_t *spd_data;
>> +    int i;
>> +
>> +    /* init CPU */
>> +    cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
>> +    env = &cpu->env;
>> +    if (PPC_INPUT(env) != PPC_FLAGS_INPUT_6xx) {
>> +        error_report("Incompatible CPU, only 6xx bus supported");
>> +        exit(1);
>> +    }
>> +    cpu_ppc_tb_init(env, BUS_FREQ_HZ / 4);
>> +    qemu_register_reset(amigaone_cpu_reset, cpu);
>> +
>> +    /* RAM */
>> +    if (machine->ram_size > 2 * GiB) {
>> +        error_report("RAM size more than 2 GiB is not supported");
>> +        exit(1);
>> +    }
>> +    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
>> +    if (machine->ram_size < 1 * GiB + 32 * KiB) {
>> +        /* Firmware uses this area for startup */
>
> This is odd. Does this machine really support 2GiB?
>
> Could it be 1GiB max, mapped twice?

Apparently AmigaOne XE does support 2GB:

https://forum.amiga.org/index.php?topic=54563.0
https://www.amigans.net/modules/newbb/viewtopic.php?viewmode=compact&order=DESC&topic_id=2262&forum=3

(As most other 32bit PPC machines it does not support more as memory above 
2GB is reserved for IO.)

The sam460ex does something similar where I think CPU cache can be mapped 
as RAM at 0x4_0000_0000 and is used for start up before the memory 
controller is initialised by firmware. Maybe something similar is done 
here but as we don't emulate the memory controller we just need to make 
sure there's some RAM here. Either the system memory is big enough or we 
map some RAM for the firmware at 1GB (the same is done in sam460ex as well 
but there these aren't overlapping with system RAM so ne need for check 
on RAM size there).

>> +        mr = g_new(MemoryRegion, 1);
>> +        memory_region_init_ram(mr, NULL, "init-cache", 32 * KiB, 
>> &error_fatal);
>> +        memory_region_add_subregion(get_system_memory(), 0x40000000, mr);
>> +    }
>> +
>> +    /* allocate and load firmware */
>> +    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, fwname);
>> +    if (!filename) {
>> +        error_report("Could not find firmware '%s'", fwname);
>> +        exit(1);
>> +    }
>> +    rom = g_new(MemoryRegion, 1);
>> +    memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal);
>> +    memory_region_add_subregion(get_system_memory(), PROM_ADDR, rom);
>> +    sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE);
>> +    if (sz <= 0 || sz > PROM_SIZE) {
>> +        error_report("Could not load firmware '%s'", filename);
>> +        exit(1);
>> +    }
>> +    g_free(filename);
>> +
>> +    /* Articia S */
>> +    dev = sysbus_create_simple(TYPE_ARTICIA, 0xfe000000, NULL);
>> +
>> +    i2c_bus = I2C_BUS(qdev_get_child_bus(dev, "smbus"));
>> +    if (machine->ram_size > 512 * MiB) {
>> +        spd_data = spd_data_generate(SDR, machine->ram_size / 2);
>> +    } else {
>> +        spd_data = spd_data_generate(SDR, machine->ram_size);
>> +    }
>> +    fix_spd_data(spd_data);
>> +    smbus_eeprom_init_one(i2c_bus, 0x51, spd_data);
>> +    if (machine->ram_size > 512 * MiB) {
>> +        smbus_eeprom_init_one(i2c_bus, 0x52, spd_data);
>> +    }
>
> This seems to confirm my doubts, you use at most 2 SPD of 512MiB DIMMs,
> so max for this machine is 1 GiB.

The firmware has some limitation on DIMM bank size and cannot support 1 GB 
bank size, hence we need to fix it up above 512k but it works up to 2g:

$ qemu-system-ppc -M amigaone -m 2g -serial stdio -bios u-boot-amigaone.bin

U-Boot 1.1.1 (Mar  3 2005 - 16:42:53), Build: 03/03/05

CPU:   MPC7457 v1.2 @ 1150 MHz
Board: AmigaOne
DRAM:
Information for SIMM bank 0:
Number of banks: 2
Number of row addresses: 14
Number of coumns addresses: 10
SIMM is not registered
Supported burst lenghts: 8 4
Supported CAS latencies: CAS 3
RAS to CAS latency: 2
Precharge latency: 2
SDRAM highest CAS latency: 250
SDRAM 2nd highest CAS latency: 120
SDRAM data width: 8
Auto Refresh supported
Refresh time: 782 clocks
Bank 0 size: 512 MB
Bank 1 size: 512 MB


Information for SIMM bank 1:
Number of banks: 2
Number of row addresses: 14
Number of coumns addresses: 10
SIMM is not registered
Supported burst lenghts: 8 4
Supported CAS latencies: CAS 3
RAS to CAS latency: 2
Precharge latency: 2
SDRAM highest CAS latency: 250
SDRAM 2nd highest CAS latency: 120
SDRAM data width: 8
Auto Refresh supported
Refresh time: 782 clocks
Bank 0 size: 512 MB
Bank 1 size: 512 MB

DIMM0_B0_SCR0 = 0x00000000
DIMM0_B1_SCR0 = 0x00000000
DIMM0_B2_SCR0 = 0x00000000
DIMM0_B3_SCR0 = 0x00000000
Using CAS 4 (slow)
Using CAS 4 (slow)
DRAM_GCR0 = 0x00000000
Refresh set to 1561 clocks, auto refresh on
DRAM_REFRESH0 = 0x00019619
Mode bank 0: 0x00008042
Mode bank 1: 0x00008042
Mode bank 2: 0x00008042
Mode bank 3: 0x00008042
2048 MB
FLASH:  0 kB
*** Warning - bad CRC, using default environment

I plan to rework spd_data_generate again at some point to get rid of these 
fix up and to allow machines to better control it (e.g. currently you 
can't have 768k RAM which would be a valid config) but for now this works 
without touching smbus_eeprom generation so I can look at that later. 
(Actually I had that working before in my original spd_eeprom_generate 
patches which returned error to the board but later it was "simplified" 
and that functionality was lost. As more boards use it now I plan to 
restore that but maybe only in next devel cycle as the current one works 
for the common cases.)

Regards,
BALATON Zoltan

>> +    pci_mem = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
>> +    mr = g_new(MemoryRegion, 1);
>> +    memory_region_init_alias(mr, OBJECT(dev), "pci-mem-low", pci_mem,
>> +                             0, 0x1000000);
>> +    memory_region_add_subregion(get_system_memory(), 0xfd000000, mr);
>> +    mr = g_new(MemoryRegion, 1);
>> +    memory_region_init_alias(mr, OBJECT(dev), "pci-mem-high", pci_mem,
>> +                             0x80000000, 0x7d000000);
>> +    memory_region_add_subregion(get_system_memory(), 0x80000000, mr);
>> +    pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
>> +
>> +    /* VIA VT82c686B South Bridge (multifunction PCI device) */
>> +    via = OBJECT(pci_create_simple_multifunction(pci_bus, PCI_DEVFN(7, 0),
>> +                                                 TYPE_VT82C686B_ISA));
>> +    object_property_add_alias(OBJECT(machine), "rtc-time",
>> +                              object_resolve_path_component(via, "rtc"),
>> +                              "date");
>> +    qdev_connect_gpio_out(DEVICE(via), 0,
>> +                          qdev_get_gpio_in(DEVICE(cpu), 
>> PPC6xx_INPUT_INT));
>> +    for (i = 0; i < PCI_NUM_PINS; i++) {
>> +        qdev_connect_gpio_out(dev, i, qdev_get_gpio_in_named(DEVICE(via),
>> +                                                             "pirq", i));
>> +    }
>> +    pci_ide_create_devs(PCI_DEVICE(object_resolve_path_component(via, 
>> "ide")));
>> +    pci_vga_init(pci_bus);
>> +}
>
>
>
--3866299591-861907120-1696852565=:71180--

