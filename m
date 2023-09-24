Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A107AC7EF
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Sep 2023 14:16:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkO0X-00086J-B1; Sun, 24 Sep 2023 08:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qkO0V-00086B-DQ
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 08:14:39 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qkO0S-0003op-TF
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 08:14:39 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 68A39756BF9;
 Sun, 24 Sep 2023 14:14:12 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 233CA748FF1; Sun, 24 Sep 2023 14:14:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 205F7745681;
 Sun, 24 Sep 2023 14:14:12 +0200 (CEST)
Date: Sun, 24 Sep 2023 14:14:12 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel <qemu-devel@nongnu.org>, 
 Martin Kletzander <mkletzan@redhat.com>, 
 =?ISO-8859-15?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH 11/13] vt82c686: Support machine-default audiodev with
 fallback
In-Reply-To: <CABgObfZeRzae78jKvDzyhWv9oVS_OS8Zo4Mfn7rtnFqG0UqK8A@mail.gmail.com>
Message-ID: <8a271e94-9762-81ca-70ad-9a0d4fbfaefa@eik.bme.hu>
References: <20230923085507.399260-1-pbonzini@redhat.com>
 <20230923085507.399260-12-pbonzini@redhat.com>
 <8395a8cf-c902-7da6-cb4e-0d4488a2a5dd@eik.bme.hu>
 <CABgObfZeRzae78jKvDzyhWv9oVS_OS8Zo4Mfn7rtnFqG0UqK8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
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

On Sun, 24 Sep 2023, Paolo Bonzini wrote:
> Il sab 23 set 2023, 14:23 BALATON Zoltan <balaton@eik.bme.hu> ha scritto:
>
>> On Sat, 23 Sep 2023, Paolo Bonzini wrote:
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>> hw/isa/vt82c686.c   |  2 ++
>>> hw/mips/fuloong2e.c | 13 ++++++++++---
>>> hw/ppc/pegasos2.c   | 10 ++++++++--
>>> 3 files changed, 20 insertions(+), 5 deletions(-)
>>
>> This looks better but I still wonder if this machine audiodev propery is
>> needed at all. If there's one -audiodev option specified it's already
>> picked up by default devices and if there are more one could use -global
>> to set it. Why isn't that enough?
>>
>
> Mostly because it's less predictable. Ideally all the state of the emulator
> would be visible and settable via explicit links.
>
> You were absolutely right that we still need to keep some level of magic in
> softmmu/vl.c to make QEMU easier to use for the command line. However, a
> while ago there was an idea of making an alternative binary that is
> entirely configurable via QMP, and past work in that direction resulted in
> *lots* of cleanups that actually made softmmu/vl.c understandable. While I
> am not sure this QMP binary is ever going to happen, I would like to make
> it possible to avoid the magic.
>
> If you still want a machine audiodev propery then could the device handle
>> it without needing changes to the machine? Like in via_isa_realize() add
>>
>> if (current_machine->audiodev) {
>>      qdev_prop_set_string(DEVICE(pci_dev), "audiodev", machine->audiodev);
>> }
>>
>> before qdev_realize(DEVICE(&s->ac97) then no need to change the device
>> creation in board code.
>>
>
> No, current_machine should not be used at all outside board code.

OK, can you start from pci_bus and walk up the QOM tree then to find the 
machine in vt92686.c so the board code does not have to care about this?

Regards,
BALATON Zoltan

>>> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
>>> index 57bdfb4e78c..3ec8e43708a 100644
>>> --- a/hw/isa/vt82c686.c
>>> +++ b/hw/isa/vt82c686.c
>>> @@ -578,6 +578,8 @@ static void via_isa_init(Object *obj)
>>>     object_initialize_child(obj, "uhci2", &s->uhci[1],
>> TYPE_VT82C686B_USB_UHCI);
>>>     object_initialize_child(obj, "ac97", &s->ac97, TYPE_VIA_AC97);
>>>     object_initialize_child(obj, "mc97", &s->mc97, TYPE_VIA_MC97);
>>> +
>>> +    object_property_add_alias(obj, "audiodev", OBJECT(&s->ac97),
>> "audiodev");
>>> }
>>>
>>> static const TypeInfo via_isa_info = {
>>> diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
>>> index c827f615f3b..df2be188257 100644
>>> --- a/hw/mips/fuloong2e.c
>>> +++ b/hw/mips/fuloong2e.c
>>> @@ -41,6 +41,7 @@
>>> #include "sysemu/reset.h"
>>> #include "sysemu/sysemu.h"
>>> #include "qemu/error-report.h"
>>> +#include "audio/audio.h"
>>>
>>> #define ENVP_PADDR              0x2000
>>> #define ENVP_VADDR              cpu_mips_phys_to_kseg0(NULL, ENVP_PADDR)
>>> @@ -295,9 +296,13 @@ static void mips_fuloong2e_init(MachineState
>> *machine)
>>>     pci_bus = bonito_init((qemu_irq *)&(env->irq[2]));
>>>
>>>     /* South bridge -> IP5 */
>>> -    pci_dev = pci_create_simple_multifunction(pci_bus,
>>> -
>> PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
>>> -                                              TYPE_VT82C686B_ISA);
>>> +    pci_dev = pci_new_multifunction(PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
>>> +                                    TYPE_VT82C686B_ISA);
>>> +    if (machine->audiodev) {
>>> +        qdev_prop_set_string(DEVICE(pci_dev), "audiodev",
>> machine->audiodev);
>>> +    }
>>> +    pci_realize_and_unref(pci_dev, pci_bus, &error_abort);
>>> +
>>>     object_property_add_alias(OBJECT(machine), "rtc-time",
>>>
>>  object_resolve_path_component(OBJECT(pci_dev),
>>>                                                             "rtc"),
>>> @@ -337,6 +342,8 @@ static void mips_fuloong2e_machine_init(MachineClass
>> *mc)
>>>     mc->default_ram_size = 256 * MiB;
>>>     mc->default_ram_id = "fuloong2e.ram";
>>>     mc->minimum_page_bits = 14;
>>> +
>>> +    machine_add_audiodev_property(mc);
>>> }
>>>
>>> DEFINE_MACHINE("fuloong2e", mips_fuloong2e_machine_init)
>>> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
>>> index bd397cf2b5c..61c302895c9 100644
>>> --- a/hw/ppc/pegasos2.c
>>> +++ b/hw/ppc/pegasos2.c
>>> @@ -37,6 +37,7 @@
>>> #include "qemu/datadir.h"
>>> #include "sysemu/device_tree.h"
>>> #include "hw/ppc/vof.h"
>>> +#include "audio/audio.h"
>>>
>>> #include <libfdt.h>
>>>
>>> @@ -180,8 +181,11 @@ static void pegasos2_init(MachineState *machine)
>>>     pci_bus_irqs(pci_bus, pegasos2_pci_irq, pm, PCI_NUM_PINS);
>>>
>>>     /* VIA VT8231 South Bridge (multifunction PCI device) */
>>> -    via = OBJECT(pci_create_simple_multifunction(pci_bus, PCI_DEVFN(12,
>> 0),
>>> -                                                 TYPE_VT8231_ISA));
>>> +    via = OBJECT(pci_new_multifunction(PCI_DEVFN(12, 0),
>> TYPE_VT8231_ISA));
>>> +    if (machine->audiodev) {
>>> +        qdev_prop_set_string(DEVICE(via), "audiodev",
>> machine->audiodev);
>>> +    }
>>> +    pci_realize_and_unref(PCI_DEVICE(via), pci_bus, &error_abort);
>>>     for (i = 0; i < PCI_NUM_PINS; i++) {
>>>         pm->via_pirq[i] = qdev_get_gpio_in_named(DEVICE(via), "pirq", i);
>>>     }
>>> @@ -564,6 +568,8 @@ static void pegasos2_machine_class_init(ObjectClass
>> *oc, void *data)
>>>     vhc->encode_hpt_for_kvm_pr = vhyp_encode_hpt_for_kvm_pr;
>>>
>>>     vmc->setprop = pegasos2_setprop;
>>> +
>>> +    machine_add_audiodev_property(mc);
>>> }
>>>
>>> static const TypeInfo pegasos2_machine_info = {
>>>
>>
>>
>

