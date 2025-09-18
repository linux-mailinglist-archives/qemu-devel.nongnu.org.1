Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 997D4B871B0
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Sep 2025 23:23:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzM4w-0007wu-MT; Thu, 18 Sep 2025 17:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uzM4u-0007vh-LC; Thu, 18 Sep 2025 17:22:08 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uzM4s-0004lj-CL; Thu, 18 Sep 2025 17:22:08 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6C36E56F30C;
 Thu, 18 Sep 2025 23:22:03 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 7k3rOvvr5TVI; Thu, 18 Sep 2025 23:22:01 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6773956F324; Thu, 18 Sep 2025 23:22:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 61D1C56F321;
 Thu, 18 Sep 2025 23:22:01 +0200 (CEST)
Date: Thu, 18 Sep 2025 23:22:01 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 13/14] hw/pci-host/raven: Do not map regions in init
 method
In-Reply-To: <c3a2ec46-9ae1-439f-b6dd-3f869163dcec@ilande.co.uk>
Message-ID: <58df9859-aaed-d8df-2ca0-72683c09d278@eik.bme.hu>
References: <cover.1758219840.git.balaton@eik.bme.hu>
 <faf045e1d4d9554af46706939e868af06ce256f3.1758219840.git.balaton@eik.bme.hu>
 <c3a2ec46-9ae1-439f-b6dd-3f869163dcec@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 18 Sep 2025, Mark Cave-Ayland wrote:
> On 18/09/2025 19:50, BALATON Zoltan wrote:
>> Export memory regions as sysbus mmio regions and let the board code
>> map them similar to how it is done in grackle.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/pci-host/raven.c | 37 ++++++++++++-------------------------
>>   hw/ppc/prep.c       | 11 +++++++++--
>>   2 files changed, 21 insertions(+), 27 deletions(-)
>> 
>> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
>> index ebf0c511dc..0c4eca04bb 100644
>> --- a/hw/pci-host/raven.c
>> +++ b/hw/pci-host/raven.c
>> @@ -49,8 +49,6 @@ struct PREPPCIState {
>>       AddressSpace bm_as;
>>   };
>>   -#define PCI_IO_BASE_ADDR    0x80000000  /* Physical address on main bus 
>> */
>> -
>>   static inline uint32_t raven_idsel_to_addr(hwaddr addr)
>>   {
>>       return (ctz16(addr >> 11) << 11) | (addr & 0x7ff);
>> @@ -170,7 +168,7 @@ static void raven_change_gpio(void *opaque, int n, int 
>> level)
>>       memory_region_set_enabled(&s->pci_discontiguous_io, !!level);
>>   }
>>   -static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>> +static void raven_pcihost_realize(DeviceState *d, Error **errp)
>
> There is a function rename here not mentioned in the commit message.

I thought this is trivial enough but can mention it in the commit message.

>>   {
>>       SysBusDevice *dev = SYS_BUS_DEVICE(d);
>>       PCIHostState *h = PCI_HOST_BRIDGE(dev);
>> @@ -180,7 +178,17 @@ static void raven_pcihost_realizefn(DeviceState *d, 
>> Error **errp)
>>         qdev_init_gpio_in(d, raven_change_gpio, 1);
>>   +    memory_region_init(&s->pci_io, o, "pci-io", 0x3f800000);
>> +    memory_region_init_io(&s->pci_discontiguous_io, o,
>> +                          &raven_io_ops, &s->pci_io,
>> +                          "pci-discontiguous-io", 8 * MiB);
>> +    memory_region_init(&s->pci_memory, o, "pci-memory", 0x3f000000);
>> +
>> +    sysbus_init_mmio(dev, &s->pci_io);
>> +    sysbus_init_mmio(dev, &s->pci_discontiguous_io);
>> +    sysbus_init_mmio(dev, &s->pci_memory);
>>       sysbus_init_irq(dev, &s->irq);
>> +
>>       h->bus = pci_register_root_bus(d, NULL, raven_set_irq, raven_map_irq,
>>                                      &s->irq, &s->pci_memory, &s->pci_io, 
>> 0, 1,
>>                                      TYPE_PCI_BUS);
>> @@ -219,32 +227,12 @@ static void raven_pcihost_realizefn(DeviceState *d, 
>> Error **errp)
>>       pci_setup_iommu(h->bus, &raven_iommu_ops, s);
>>   }
>>   -static void raven_pcihost_initfn(Object *obj)
>> -{
>> -    PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(obj);
>> -    MemoryRegion *address_space_mem = get_system_memory();
>> -
>> -    memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
>> -    memory_region_init_io(&s->pci_discontiguous_io, obj,
>> -                          &raven_io_ops, &s->pci_io,
>> -                          "pci-discontiguous-io", 8 * MiB);
>> -    memory_region_init(&s->pci_memory, obj, "pci-memory", 0x3f000000);
>> -
>> -    /* CPU address space */
>> -    memory_region_add_subregion(address_space_mem, PCI_IO_BASE_ADDR,
>> -                                &s->pci_io);
>> -    memory_region_add_subregion_overlap(address_space_mem, 
>> PCI_IO_BASE_ADDR,
>> -                                        &s->pci_discontiguous_io, 1);
>> -    memory_region_set_enabled(&s->pci_discontiguous_io, false);
>> -    memory_region_add_subregion(address_space_mem, 0xc0000000, 
>> &s->pci_memory);
>> -}
>
> Normally if the MemoryRegion does not depend upon a property, it can be 
> initialised in an init() function, so these can stay where they are.

There's no need to have an init method in the first place as these 
also don't provide a property so they can be created in realize instead.

> But certainly the device should not be mapping itself, so the sysbus-related 
> changes look correct.
>
>> -
>>   static void raven_pcihost_class_init(ObjectClass *klass, const void 
>> *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>>         set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>> -    dc->realize = raven_pcihost_realizefn;
>> +    dc->realize = raven_pcihost_realize;
>>       dc->fw_name = "pci";
>>   }
>>   @@ -278,7 +266,6 @@ static const TypeInfo raven_types[] = {
>>           .name = TYPE_RAVEN_PCI_HOST_BRIDGE,
>>           .parent = TYPE_PCI_HOST_BRIDGE,
>>           .instance_size = sizeof(PREPPCIState),
>> -        .instance_init = raven_pcihost_initfn,
>>           .class_init = raven_pcihost_class_init,
>>       },
>>       {
>> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
>> index d3365414d2..23d0e1eeaa 100644
>> --- a/hw/ppc/prep.c
>> +++ b/hw/ppc/prep.c
>> @@ -53,8 +53,11 @@
>>     #define CFG_ADDR 0xf0000510
>>   -#define KERNEL_LOAD_ADDR 0x01000000
>> -#define INITRD_LOAD_ADDR 0x01800000
>> +#define KERNEL_LOAD_ADDR  0x01000000
>> +#define INITRD_LOAD_ADDR  0x01800000
>> +
>> +#define PCI_IO_BASE_ADDR  0x80000000
>> +#define PCI_MEM_BASE_ADDR 0xc0000000
>>     #define BIOS_ADDR         0xfff00000
>>   #define BIOS_SIZE         (1 * MiB)
>> @@ -293,6 +296,10 @@ static void ibm_40p_init(MachineState *machine)
>>       pcihost = SYS_BUS_DEVICE(dev);
>>       object_property_add_child(qdev_get_machine(), "raven", OBJECT(dev));
>>       sysbus_realize_and_unref(pcihost, &error_fatal);
>> +    sysbus_mmio_map(pcihost, 0, PCI_IO_BASE_ADDR);
>> +    sysbus_mmio_map_overlap(pcihost, 1, PCI_IO_BASE_ADDR, 1);
>> +    memory_region_set_enabled(sysbus_mmio_get_region(pcihost, 1), false);
>
> Why not leave this within the device itself? It seems odd that something 
> external to the device is trying to set its initial state.

I don't remember but maybe this is to keep existing behaviour and can be 
removed after next patch where it sets initial state based on property? 
I'd have to check this again.

Regards,
BALATON Zoltan

>> +    sysbus_mmio_map(pcihost, 2, PCI_MEM_BASE_ADDR);
>>       pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
>>       if (!pci_bus) {
>>           error_report("could not create PCI host controller");
>
>
> ATB,
>
> Mark.
>
>

