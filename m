Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 378477B9D08
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 14:39:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNdL-0008Dv-5Z; Thu, 05 Oct 2023 08:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qoNd2-0008DB-QS
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:38:58 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qoNd0-0008Qk-5X
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:38:56 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 8B419748FF4;
 Thu,  5 Oct 2023 14:38:05 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4D01A74632B; Thu,  5 Oct 2023 14:38:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4B34E745681;
 Thu,  5 Oct 2023 14:38:05 +0200 (CEST)
Date: Thu, 5 Oct 2023 14:38:05 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Huacai Chen <chenhuacai@kernel.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] hw/isa/vt82c686: Respect SCI interrupt assignment
In-Reply-To: <425EE8A1-749B-445E-95B0-45614D95BF3C@gmail.com>
Message-ID: <52fb5898-6cc2-5256-fc54-0bab7fdd1efd@eik.bme.hu>
References: <20231004105709.16994-1-shentey@gmail.com>
 <c786c82e-88bb-5333-1b74-a1bf0fd2cad5@eik.bme.hu>
 <4D35354B-1289-4B67-B913-7EC5F4D6D07F@gmail.com>
 <9bedc976-9d10-90e0-f1d6-dff9618854e5@eik.bme.hu>
 <425EE8A1-749B-445E-95B0-45614D95BF3C@gmail.com>
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
> Am 5. Oktober 2023 11:26:56 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> On Thu, 5 Oct 2023, Bernhard Beschow wrote:
>>> Am 4. Oktober 2023 12:28:58 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>>>> On Wed, 4 Oct 2023, Bernhard Beschow wrote:
>>>>> According to the datasheet, SCI interrupts of the power management function
>>>>> aren't routed through the PCI pins but rather directly to the integrated PIC.
>>>>> The routing is configurable through the ACPI interrupt select register at offset
>>>>> 0x42 in the PCI configuration space of the ISA function.
>>>>>
>>>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>>>>
>>>>> ---
>>>>>
>>>>> v2:
>>>>> * Introduce named constants for the ACPI interrupt select register at offset
>>>>>  0x42 (Phil)
>>>>> ---
>>>>> hw/isa/vt82c686.c | 47 +++++++++++++++++++++++++++++++++++------------
>>>>> 1 file changed, 35 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
>>>>> index 57bdfb4e78..93ffaaf706 100644
>>>>> --- a/hw/isa/vt82c686.c
>>>>> +++ b/hw/isa/vt82c686.c
>>>>> @@ -46,6 +46,8 @@ struct ViaPMState {
>>>>>     ACPIREGS ar;
>>>>>     APMState apm;
>>>>>     PMSMBus smb;
>>>>> +
>>>>> +    qemu_irq irq;
>>>>
>>>> Is it better to name this sci_irq because there seems to be an smi_irq too? Also there seems to be no SCI pin but there's an SMI pin so does this sci_irq need to be forwaeded to the ISA bridge and exposed as a qemu_gpio or could it just set the ISA IRQ within its own handler in the via_pm object?
>>>
>>> Triggering the PIC in the PM function seems more complicated since ISA function embeds PM function and also PM function is implemented before ISA function, so this would create nesting problems in the code. Either
>>
>> Where PM function is implemented is just because it was there before or that's how I went through the functions when cleaning it up and ended up there but it could be moved, it's not bolted down...
>>
>> However even if it comes before, we had the pattern before for via-ide and usb that they can look up function 0 of their own devfn to find the ISA bridge and sinve we're in vt82b686.c here you can consider these to be friend classes so pm func could access the ISA irq's directly (or bring back the via_isa_set_irq func I had before for this). That way it's simpler and does not need QOM wizardry in ISA function that does not even model what real chip does so I think this should be implemented in an irq handler func within the PM object that matches what happens in the real chip.
>
> This would require container_of() to be used which violates QOM best 
> practices where a device should only know about its (transitive) 
> children. Given the current nesting of devices I prefer to keep the PIC 
> triggering in the ISA function where the PIC resides.

No it doesn't. You can get the isa function with 
pci_get_function_0(&s->dev) in the PM object where s is pointing to the 
ViaPMState. Then if you don't want to poke the ISA object from the PM 
object revert the patch that removed via_isa_set_irq that I've added for 
such cases but I think you can just access the ISA func from the PM func 
in the same file as these are part of the same chip model, only modelled 
as QOM objects to separate them in some logical way.

Regards,
BALATON Zoltan

