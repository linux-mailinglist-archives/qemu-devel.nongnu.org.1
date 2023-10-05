Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB65F7B9CB8
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 13:22:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoMPt-0001Uj-Lr; Thu, 05 Oct 2023 07:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qoMPr-0001UW-53
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 07:21:15 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qoMPo-0006pp-2W
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 07:21:14 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E288975715B;
 Thu,  5 Oct 2023 13:20:23 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 53772756BF9; Thu,  5 Oct 2023 13:20:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5079F748FF4;
 Thu,  5 Oct 2023 13:20:23 +0200 (CEST)
Date: Thu, 5 Oct 2023 13:20:23 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Huacai Chen <chenhuacai@kernel.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] hw/isa/vt82c686: Respect SCI interrupt assignment
In-Reply-To: <741F3E86-BFD2-440F-93C5-010A81CD90FC@gmail.com>
Message-ID: <82994ed4-90e0-f3ee-d3da-b0471a42e146@eik.bme.hu>
References: <20231003214437.29302-1-shentey@gmail.com>
 <f5b9d133-864a-fd13-9bc5-523e1ad77efe@eik.bme.hu>
 <B7E8646E-A72B-419D-A427-D132F66289F7@gmail.com>
 <93e48abe-b6d4-af1a-f40f-728c8d215bbb@eik.bme.hu>
 <741F3E86-BFD2-440F-93C5-010A81CD90FC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

On Thu, 5 Oct 2023, Bernhard Beschow wrote:
> Am 4. Oktober 2023 14:52:14 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> On Wed, 4 Oct 2023, Bernhard Beschow wrote:
>>> Am 4. Oktober 2023 12:08:02 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>>>> On Tue, 3 Oct 2023, Bernhard Beschow wrote:
>>>>> According to the datasheet, SCI interrupts of the power management function
>>>>> aren't triggered through the PCI pins but rather directly to the integrated PIC.
>>>>> The routing is configurable through the ACPI interrupt select register at offset
>>>>> 42 in the PCI configuration space of the ISA function.
>>>>
>>>> This should be config reg 42 of the PM function 4 not ISA function 0 but the code seems to do it right just this description is wrong.
>>>
>>> Notice via_isa_set_pm_irq() using ViaISAState for routing the SCI to the PIC. Hence, the description seems correct to me.
>>
>> It uses s->pm.dev.config + 0x42 so that's the PM device not s->dev.config which is a different register so I think the description should also talk about offset 0x42 of PCI configuration of the PM function, shouldn't it?
>
> Oh right, I'll fix the commit message.
>
>>
>>>>>
>>>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>>>
>>>> You could cc me on vt82c686 too as now I have two machines using these (one is not yet upstream).
>>>
>>> Usually I let git-publish handle the cc which derives it from the MAINTAINERS file. You could add yourself there to get cc'ed automatically.
>>
>> I thought about sending a patch splitting off vt82c686 from fuloong2e so I can add myself as reviewer there. I may do that later.
>>
>>> I'm curious what the other machine not yet upstreamed is?
>>
>> Tou can read about it here:
>>
>> https://www.amigans.net/modules/newbb/viewtopic.php?topic_id=9282
>>
>> I'll plan to send it when it's better tested but it needs a firmware image that I could not yet solve.
>>
>>>>> ---
>>>>> hw/isa/vt82c686.c | 43 +++++++++++++++++++++++++++++++------------
>>>>> 1 file changed, 31 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
>>>>> index 57bdfb4e78..2988ad1eda 100644
>>>>> --- a/hw/isa/vt82c686.c
>>>>> +++ b/hw/isa/vt82c686.c
>>>>> @@ -46,6 +46,8 @@ struct ViaPMState {
>>>>>     ACPIREGS ar;
>>>>>     APMState apm;
>>>>>     PMSMBus smb;
>>>>> +
>>>>
>>>> No empty line needed here.
>>>
>>> Here I took inspiration from struct PIIX4PMState which separates the qemu_irqs, too. The long term plan is to also add an smi_irq attribute in order to bring both device models to feature parity. So I'd rather leave it as is.
>>
>> Maybe better name it sci_irq then to avoid confusion.
>
> Will do. And I'll turn it into a named GPIO.
>
>> If you add smi later as well then maybe it's time to think now how to best model this. Does sci needs to be exposed as named qemu_gpio on function 0 or should that be smi and sci routed to smi optionally whcch seems to be what the real chip does? I don't know how these work just looked at the data sheet briefly so I have more questions than answers but looks like exposing sci is not needed and this patch could just add an irq to PM func only that could set ISA IRQ and then later when smi_irq is added that might need a qemu_gpio in func 0 modelling the SMI pin of the chip.
>
> Right, I think the SCI doesn't need to be exposed since it is handled internally in the chip. This is what this patch implements.

So then no need to add a named gpio for it and this patch does noe need to 
touch the isa part and can handle it within PM part. See reply to next 
message why I think so.

Regards,
BALATON Zoltan

> The SMI will need to be exposed since it puts an x86 CPU in system management mode via a dedicated pin.
>
> Best regards,
> Bernhard
>
>>
>>>> It you want to, you could add an empty line after the first member and rename that to parent_obj as per new convention while you're changing this object state.
>>>
>>> I didn't want to add this style fix in this single commit series. I think this would deserve its own commit where all device models in this file are fixed.
>>
>> That works for me too, no need to do it here, just mentioned that's where I think a new line may be acceptable but not really needed elsewhere.
>>
>>>>
>>>>> +    qemu_irq irq;
>>>>> };
>>>>>
>>>>> static void pm_io_space_update(ViaPMState *s)
>>>>> @@ -148,18 +150,7 @@ static void pm_update_sci(ViaPMState *s)
>>>>>                    ACPI_BITMASK_POWER_BUTTON_ENABLE |
>>>>>                    ACPI_BITMASK_GLOBAL_LOCK_ENABLE |
>>>>>                    ACPI_BITMASK_TIMER_ENABLE)) != 0);
>>>>> -    if (pci_get_byte(s->dev.config + PCI_INTERRUPT_PIN)) {
>>>>> -        /*
>>>>> -         * FIXME:
>>>>> -         * Fix device model that realizes this PM device and remove
>>>>> -         * this work around.
>>>>> -         * The device model should wire SCI and setup
>>>>> -         * PCI_INTERRUPT_PIN properly.
>>>>> -         * If PIN# = 0(interrupt pin isn't used), don't raise SCI as
>>>>> -         * work around.
>>>>> -         */
>>>>> -        pci_set_irq(&s->dev, sci_level);
>>>>> -    }
>>>>> +    qemu_set_irq(s->irq, sci_level);
>>>>>     /* schedule a timer interruption if needed */
>>>>>     acpi_pm_tmr_update(&s->ar, (s->ar.pm1.evt.en & ACPI_BITMASK_TIMER_ENABLE) &&
>>>>>                        !(pmsts & ACPI_BITMASK_TIMER_STATUS));
>>>>> @@ -213,6 +204,13 @@ static void via_pm_realize(PCIDevice *dev, Error **errp)
>>>>>     acpi_pm1_cnt_init(&s->ar, &s->io, false, false, 2, false);
>>>>> }
>>>>>
>>>>> +static void via_pm_init(Object *obj)
>>>>> +{
>>>>> +    ViaPMState *s = VIA_PM(obj);
>>>>> +
>>>>> +    qdev_init_gpio_out(DEVICE(obj), &s->irq, 1);
>>>>> +}
>>>>> +
>>>>> typedef struct via_pm_init_info {
>>>>>     uint16_t device_id;
>>>>> } ViaPMInitInfo;
>>>>> @@ -238,6 +236,7 @@ static void via_pm_class_init(ObjectClass *klass, void *data)
>>>>> static const TypeInfo via_pm_info = {
>>>>>     .name          = TYPE_VIA_PM,
>>>>>     .parent        = TYPE_PCI_DEVICE,
>>>>> +    .instance_init = via_pm_init,
>>>>>     .instance_size = sizeof(ViaPMState),
>>>>>     .abstract      = true,
>>>>>     .interfaces = (InterfaceInfo[]) {
>>>>> @@ -568,9 +567,25 @@ static const VMStateDescription vmstate_via = {
>>>>>     }
>>>>> };
>>>>>
>>>>> +static void via_isa_set_pm_irq(void *opaque, int n, int level)
>>>>> +{
>>>>> +    ViaISAState *s = opaque;
>>>>> +    uint8_t irq = pci_get_byte(s->pm.dev.config + 0x42) & 0xf;
>>>>> +
>>>>> +    if (irq == 2) {
>>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "IRQ 2 for PM controller is reserved");
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    if (irq != 0) {
>>>>> +        qemu_set_irq(s->isa_irqs_in[irq], level);
>>>>> +    }
>>>>> +}
>>>>> +
>>>>> static void via_isa_init(Object *obj)
>>>>> {
>>>>>     ViaISAState *s = VIA_ISA(obj);
>>>>> +    DeviceState *dev = DEVICE(s);
>>>>
>>>> No need to add local variable for single use unless you expect to have more of these later but for single use you caould just use DEVICE(obj or s) in the call below.
>>>
>>> I have one more user on my pc-via branch for wiring the ISA interrupts.
>>
>> OK as said if you expect more usages then a local variable can be useful just seems unnecessary for a single use but if you'll follow up with something that will use it it can be added now.
>>
>> Regards,
>> BALATON Zoltan
>>
>>> Best regards,
>>> Bernhard
>>>
>>>>
>>>> Other than these small nits:
>>>>
>>>> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>
>>>>>
>>>>>     object_initialize_child(obj, "rtc", &s->rtc, TYPE_MC146818_RTC);
>>>>>     object_initialize_child(obj, "ide", &s->ide, TYPE_VIA_IDE);
>>>>> @@ -578,6 +593,8 @@ static void via_isa_init(Object *obj)
>>>>>     object_initialize_child(obj, "uhci2", &s->uhci[1], TYPE_VT82C686B_USB_UHCI);
>>>>>     object_initialize_child(obj, "ac97", &s->ac97, TYPE_VIA_AC97);
>>>>>     object_initialize_child(obj, "mc97", &s->mc97, TYPE_VIA_MC97);
>>>>> +
>>>>> +    qdev_init_gpio_in_named(dev, via_isa_set_pm_irq, "sci", 1);
>>>>> }
>>>>>
>>>>> static const TypeInfo via_isa_info = {
>>>>> @@ -704,6 +721,8 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
>>>>>     if (!qdev_realize(DEVICE(&s->pm), BUS(pci_bus), errp)) {
>>>>>         return;
>>>>>     }
>>>>> +    qdev_connect_gpio_out(DEVICE(&s->pm), 0,
>>>>> +                          qdev_get_gpio_in_named(DEVICE(d), "sci", 0));
>>>>>
>>>>>     /* Function 5: AC97 Audio */
>>>>>     qdev_prop_set_int32(DEVICE(&s->ac97), "addr", d->devfn + 5);
>>>>>
>>>
>>>
>
>

