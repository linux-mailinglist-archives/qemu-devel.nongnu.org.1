Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8125B86E54
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Sep 2025 22:22:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzL8Z-0007O7-A1; Thu, 18 Sep 2025 16:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uzL8T-0007Kt-CK; Thu, 18 Sep 2025 16:21:45 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uzL89-00039O-CF; Thu, 18 Sep 2025 16:21:44 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4025656F321;
 Thu, 18 Sep 2025 22:21:21 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id qEwDcIkVSeRl; Thu, 18 Sep 2025 22:21:19 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2ECA756F30D; Thu, 18 Sep 2025 22:21:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2CF1356F30C;
 Thu, 18 Sep 2025 22:21:19 +0200 (CEST)
Date: Thu, 18 Sep 2025 22:21:19 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 01/14] hw/pci-host/raven: Simplify PCI facing part
In-Reply-To: <b5db600a-3278-427d-9f67-b222cb0c1bd1@ilande.co.uk>
Message-ID: <db65a6dd-cfdf-18b8-1764-8a1d7d3fcc24@eik.bme.hu>
References: <cover.1758219840.git.balaton@eik.bme.hu>
 <ebfd5b64421e8a876c5a6e2ce3dc871de500b69d.1758219840.git.balaton@eik.bme.hu>
 <b5db600a-3278-427d-9f67-b222cb0c1bd1@ilande.co.uk>
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
>> The raven PCI device does not need a state struct as it has no data to
>> store there any more, so we can remove that to simplify code.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/pci-host/raven.c | 30 +-----------------------------
>>   1 file changed, 1 insertion(+), 29 deletions(-)
>> 
>> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
>> index f8c0be5d21..172f01694c 100644
>> --- a/hw/pci-host/raven.c
>> +++ b/hw/pci-host/raven.c
>> @@ -31,7 +31,6 @@
>>   #include "hw/pci/pci_bus.h"
>>   #include "hw/pci/pci_host.h"
>>   #include "hw/qdev-properties.h"
>> -#include "migration/vmstate.h"
>>   #include "hw/intc/i8259.h"
>>   #include "hw/irq.h"
>>   #include "hw/or-irq.h"
>> @@ -40,12 +39,6 @@
>>   #define TYPE_RAVEN_PCI_DEVICE "raven"
>>   #define TYPE_RAVEN_PCI_HOST_BRIDGE "raven-pcihost"
>>   -OBJECT_DECLARE_SIMPLE_TYPE(RavenPCIState, RAVEN_PCI_DEVICE)
>> -
>> -struct RavenPCIState {
>> -    PCIDevice dev;
>> -};
>> -
>>   typedef struct PRePPCIState PREPPCIState;
>>   DECLARE_INSTANCE_CHECKER(PREPPCIState, RAVEN_PCI_HOST_BRIDGE,
>>                            TYPE_RAVEN_PCI_HOST_BRIDGE)
>> @@ -65,7 +58,6 @@ struct PRePPCIState {
>>       MemoryRegion bm_ram_alias;
>>       MemoryRegion bm_pci_memory_alias;
>>       AddressSpace bm_as;
>> -    RavenPCIState pci_dev;
>>         int contiguous_map;
>>   };
>> @@ -268,8 +260,7 @@ static void raven_pcihost_realizefn(DeviceState *d, 
>> Error **errp)
>>                             "pci-intack", 1);
>>       memory_region_add_subregion(address_space_mem, 0xbffffff0, 
>> &s->pci_intack);
>>   -    /* TODO Remove once realize propagates to child devices. */
>> -    qdev_realize(DEVICE(&s->pci_dev), BUS(&s->pci_bus), errp);
>> +    pci_create_simple(&s->pci_bus, PCI_DEVFN(0, 0), 
>> TYPE_RAVEN_PCI_DEVICE);
>>   }
>>     static void raven_pcihost_initfn(Object *obj)
>> @@ -277,7 +268,6 @@ static void raven_pcihost_initfn(Object *obj)
>>       PCIHostState *h = PCI_HOST_BRIDGE(obj);
>>       PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(obj);
>>       MemoryRegion *address_space_mem = get_system_memory();
>> -    DeviceState *pci_dev;
>>         memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
>>       memory_region_init_io(&s->pci_io_non_contiguous, obj, &raven_io_ops, 
>> s,
>> @@ -314,12 +304,6 @@ static void raven_pcihost_initfn(Object *obj)
>>       pci_setup_iommu(&s->pci_bus, &raven_iommu_ops, s);
>>         h->bus = &s->pci_bus;
>> -
>> -    object_initialize(&s->pci_dev, sizeof(s->pci_dev), 
>> TYPE_RAVEN_PCI_DEVICE);
>> -    pci_dev = DEVICE(&s->pci_dev);
>> -    object_property_set_int(OBJECT(&s->pci_dev), "addr", PCI_DEVFN(0, 0),
>> -                            NULL);
>> -    qdev_prop_set_bit(pci_dev, "multifunction", false);
>>   }
>>     static void raven_realize(PCIDevice *d, Error **errp)
>> @@ -329,16 +313,6 @@ static void raven_realize(PCIDevice *d, Error **errp)
>>       d->config[PCI_CAPABILITY_LIST] = 0x00;
>>   }
>>   -static const VMStateDescription vmstate_raven = {
>> -    .name = "raven",
>> -    .version_id = 0,
>> -    .minimum_version_id = 0,
>> -    .fields = (const VMStateField[]) {
>> -        VMSTATE_PCI_DEVICE(dev, RavenPCIState),
>> -        VMSTATE_END_OF_LIST()
>> -    },
>> -};
>> -
>>   static void raven_class_init(ObjectClass *klass, const void *data)
>>   {
>>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>> @@ -350,7 +324,6 @@ static void raven_class_init(ObjectClass *klass, const 
>> void *data)
>>       k->revision = 0x00;
>>       k->class_id = PCI_CLASS_BRIDGE_HOST;
>>       dc->desc = "PReP Host Bridge - Motorola Raven";
>> -    dc->vmsd = &vmstate_raven;
>>       /*
>>        * Reason: PCI-facing part of the host bridge, not usable without
>>        * the host-facing part, which can't be device_add'ed, yet.
>> @@ -361,7 +334,6 @@ static void raven_class_init(ObjectClass *klass, const 
>> void *data)
>>   static const TypeInfo raven_info = {
>>       .name = TYPE_RAVEN_PCI_DEVICE,
>>       .parent = TYPE_PCI_DEVICE,
>> -    .instance_size = sizeof(RavenPCIState),
>>       .class_init = raven_class_init,
>>       .interfaces = (const InterfaceInfo[]) {
>>           { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>
> I agree with removing RavenPCIState, but pci_create_simple() isn't the right 
> solution here because it both init()s and realize()s the inner object. The 
> right way to do this is for the parent to init() its inner object(s) within 
> its init() function, and similarly for it to realize() its inner object(s) 
> within its realize() function.
>
> FWIW it looks as if the same mistake is present in several other hw/pci-host 
> devices.

So maybe that's not a mistake then. There's no need to init and realize it 
separately as this is an internal object which is enough to be created in 
realize method and init and realize there at one go for which 
pci_create_simple is appropriate. I think this inner object would only 
need to be init separately if it exposed something (like a property) that 
could be inspected or set before realize but that's not the case here so 
it does not have to be created in init only in realize. (A lot of simple 
devices don't even have init method only realize so init is only needed 
for things that have to be set before realize.)

Regards,
BALATON Zoltan

