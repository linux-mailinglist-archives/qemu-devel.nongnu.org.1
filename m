Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF8AB87264
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Sep 2025 23:34:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzMFk-0002yV-QR; Thu, 18 Sep 2025 17:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uzMFc-0002x2-UB; Thu, 18 Sep 2025 17:33:12 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uzMFa-0007ao-2V; Thu, 18 Sep 2025 17:33:12 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 39B2A56F321;
 Thu, 18 Sep 2025 23:33:03 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id jXRuf9ugvXKQ; Thu, 18 Sep 2025 23:33:01 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3248156F2AE; Thu, 18 Sep 2025 23:33:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3025F56F295;
 Thu, 18 Sep 2025 23:33:01 +0200 (CEST)
Date: Thu, 18 Sep 2025 23:33:01 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 14/14] hw/ppc/prep: Fix non-contiguous IO control
 bit
In-Reply-To: <f61fbc4b-596c-4325-88ac-8c800794f92b@ilande.co.uk>
Message-ID: <ff7a20d1-f2fc-0180-1a40-aa426f935f30@eik.bme.hu>
References: <cover.1758219840.git.balaton@eik.bme.hu>
 <9a9564915bf57a6c7e5dae2cfcf147081525e900.1758219840.git.balaton@eik.bme.hu>
 <f61fbc4b-596c-4325-88ac-8c800794f92b@ilande.co.uk>
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
>> The bit that is supposed to control if ISA IO ports are accessed with
>> discontiguous addresses was not connected so it did nothing. We can
>> now directly enable or disable the discontiguous region so allow the
>> bit to function. This did not cause a problem so far as nothing seems
>> to use this bit or discontiguous IO addresses.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/pci-host/raven.c    |  9 ---------
>>   hw/ppc/prep.c          |  3 +++
>>   hw/ppc/prep_systemio.c | 17 +++++++++++------
>>   3 files changed, 14 insertions(+), 15 deletions(-)
>> 
>> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
>> index 0c4eca04bb..fd45acb7eb 100644
>> --- a/hw/pci-host/raven.c
>> +++ b/hw/pci-host/raven.c
>> @@ -161,13 +161,6 @@ static const PCIIOMMUOps raven_iommu_ops = {
>>       .get_address_space = raven_pcihost_set_iommu,
>>   };
>>   -static void raven_change_gpio(void *opaque, int n, int level)
>> -{
>> -    PREPPCIState *s = opaque;
>> -
>> -    memory_region_set_enabled(&s->pci_discontiguous_io, !!level);
>> -}
>> -
>>   static void raven_pcihost_realize(DeviceState *d, Error **errp)
>>   {
>>       SysBusDevice *dev = SYS_BUS_DEVICE(d);
>> @@ -176,8 +169,6 @@ static void raven_pcihost_realize(DeviceState *d, Error 
>> **errp)
>>       Object *o = OBJECT(d);
>>       MemoryRegion *mr, *bm, *address_space_mem = get_system_memory();
>>   -    qdev_init_gpio_in(d, raven_change_gpio, 1);
>> -
>>       memory_region_init(&s->pci_io, o, "pci-io", 0x3f800000);
>>       memory_region_init_io(&s->pci_discontiguous_io, o,
>>                             &raven_io_ops, &s->pci_io,
>> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
>> index 23d0e1eeaa..678682fdd2 100644
>> --- a/hw/ppc/prep.c
>> +++ b/hw/ppc/prep.c
>> @@ -358,6 +358,9 @@ static void ibm_40p_init(MachineState *machine)
>>           dev = DEVICE(isa_dev);
>>           qdev_prop_set_uint32(dev, "ibm-planar-id", 0xfc);
>>           qdev_prop_set_uint32(dev, "equipment", 0xc0);
>> +        object_property_set_link(OBJECT(dev), "discontiguous-io",
>> +                                 OBJECT(sysbus_mmio_get_region(pcihost, 
>> 1)),
>> +                                 &error_fatal);
>>           isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
>>             dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(1, 0),
>> diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
>> index 41cd923b94..6ef9b91317 100644
>> --- a/hw/ppc/prep_systemio.c
>> +++ b/hw/ppc/prep_systemio.c
>> @@ -44,9 +44,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(PrepSystemIoState, 
>> PREP_SYSTEMIO)
>>     struct PrepSystemIoState {
>>       ISADevice parent_obj;
>> +
>>       MemoryRegion ppc_parity_mem;
>> +    MemoryRegion *discontiguous_io;
>>   -    qemu_irq non_contiguous_io_map_irq;
>>       uint8_t sreset; /* 0x0092 */
>>       uint8_t equipment; /* 0x080c */
>>       uint8_t system_control; /* 0x081c */
>> @@ -206,8 +207,8 @@ static void prep_port0850_write(void *opaque, uint32_t 
>> addr, uint32_t val)
>>       PrepSystemIoState *s = opaque;
>>         trace_prep_systemio_write(addr, val);
>> -    qemu_set_irq(s->non_contiguous_io_map_irq,
>> -                 val & PORT0850_IOMAP_NONCONTIGUOUS);
>> +    memory_region_set_enabled(s->discontiguous_io,
>> +                              !(val & PORT0850_IOMAP_NONCONTIGUOUS));
>>       s->iomap_type = val & PORT0850_IOMAP_NONCONTIGUOUS;
>>   }
>>   @@ -257,10 +258,10 @@ static void prep_systemio_realize(DeviceState *dev, 
>> Error **errp)
>>       PrepSystemIoState *s = PREP_SYSTEMIO(dev);
>>       PowerPCCPU *cpu;
>>   -    qdev_init_gpio_out(dev, &s->non_contiguous_io_map_irq, 1);
>> +    assert(s->discontiguous_io);
>>       s->iomap_type = PORT0850_IOMAP_NONCONTIGUOUS;
>> -    qemu_set_irq(s->non_contiguous_io_map_irq,
>> -                 s->iomap_type & PORT0850_IOMAP_NONCONTIGUOUS);
>> +    memory_region_set_enabled(s->discontiguous_io,
>> +                              !(s->iomap_type & 
>> PORT0850_IOMAP_NONCONTIGUOUS));
>>       cpu = POWERPC_CPU(first_cpu);
>>       s->softreset_irq = qdev_get_gpio_in(DEVICE(cpu), 
>> PPC6xx_INPUT_HRESET);
>>   @@ -288,6 +289,8 @@ static const VMStateDescription vmstate_prep_systemio 
>> = {
>>   static const Property prep_systemio_properties[] = {
>>       DEFINE_PROP_UINT8("ibm-planar-id", PrepSystemIoState, ibm_planar_id, 
>> 0),
>>       DEFINE_PROP_UINT8("equipment", PrepSystemIoState, equipment, 0),
>> +    DEFINE_PROP_LINK("discontiguous-io", PrepSystemIoState, 
>> discontiguous_io,
>> +                     TYPE_MEMORY_REGION, MemoryRegion *),
>>   };
>>     static void prep_systemio_class_initfn(ObjectClass *klass, const void 
>> *data)
>> @@ -296,6 +299,8 @@ static void prep_systemio_class_initfn(ObjectClass 
>> *klass, const void *data)
>>         dc->realize = prep_systemio_realize;
>>       dc->vmsd = &vmstate_prep_systemio;
>> +    /* Reason: PReP specific device, needs to be wired via properties */
>> +    dc->user_creatable = false;
>>       device_class_set_props(dc, prep_systemio_properties);
>>   }
>
> Making a device non-user-creatable seems to be a step backwards: why not keep 
> the gpio for signalling the non-contiguous IO configuration?

This device implements a bunch of isa ports that control internal 
behaviour of the PReP machine. It does not make sense to add it to any 
other machine and as it needs to access some PReP specific internals it 
needs to be connected. Even a gpio would need to be connected so that does 
not change the reason for making it non-user-creatable. The previous way 
to change a memory region via a gpio was messier and needed access the 
memory region which is now self contained in the device where it belongs 
and passed via a link property which I think is clearer than the previous 
way.

Thanks again for the review. I've noted your Rb tags and made changes to 
the commit messages you asked and answered other questions. I'll wait for 
another round of answers before sending a v4 unless you want to see that 
before you answer.

Regards,
BALATON Zoltan

