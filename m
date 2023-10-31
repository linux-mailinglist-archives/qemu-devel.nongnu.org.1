Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0B67DD856
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 23:31:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxxFY-00087P-Od; Tue, 31 Oct 2023 18:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qxxFW-00087G-NQ
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:30:14 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qxxFQ-0001UF-Ph
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:30:14 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 241C3756078;
 Tue, 31 Oct 2023 23:30:12 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5E138756066; Tue, 31 Oct 2023 23:30:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5A96D756062;
 Tue, 31 Oct 2023 23:30:11 +0100 (CET)
Date: Tue, 31 Oct 2023 23:30:11 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Bernhard Beschow <shentey@gmail.com>, vr_qemu@t-online.de, mst@redhat.com, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/4] Fix IRQ routing in via south bridge
In-Reply-To: <65d860b3-a445-b039-13e1-c5f602c0f683@eik.bme.hu>
Message-ID: <6327cf8b-0c8b-c080-dfbf-747d7e12ec72@eik.bme.hu>
References: <cover.1698536342.git.balaton@eik.bme.hu>
 <03f52ea1-7436-4129-bd53-e14104a9e74e@ilande.co.uk>
 <0f4b0c4b-9229-dcc5-d12a-3f423c316f80@eik.bme.hu>
 <e8a8425a-d824-44da-a2b1-3187f01d59cd@ilande.co.uk>
 <942b8c93-f6d1-60a8-3dca-3506523de394@eik.bme.hu>
 <74bad1b1-3291-41b3-85ee-998d6ba8bfff@ilande.co.uk>
 <65d860b3-a445-b039-13e1-c5f602c0f683@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Tue, 31 Oct 2023, BALATON Zoltan wrote:
> On Tue, 31 Oct 2023, Mark Cave-Ayland wrote:
>> On 30/10/2023 21:57, BALATON Zoltan wrote:
>>> On Mon, 30 Oct 2023, Mark Cave-Ayland wrote:
>>>> On 29/10/2023 13:45, BALATON Zoltan wrote:
>>>>> On Sun, 29 Oct 2023, Mark Cave-Ayland wrote:
>>>>>> On 29/10/2023 00:56, BALATON Zoltan wrote:
>>>>>> 
>>>>>>> This is going back to my otiginal proposal in
>>>>>>> https://patchew.org/QEMU/cover.1677004414.git.balaton@eik.bme.hu/
>>>>>>> implementing routing of interrupts from device functions and PCI
>>>>>>> devices to ISA interrupts. On pegasos2 the firmware sets evertyhing to
>>>>>>> share IRQ 9 so the current simpified version worked for taht but with
>>>>>>> the amigaone machine its firmware makes use of this feature and
>>>>>>> assigns different interrupts to functions and PCI devices so we need
>>>>>>> to properly impelent this.
>>>>>> 
>>>>>> <quote>
>>>>>>> Since any ISA interrupt can be controlled
>>>>>>> by any interrupt source (different functions of the multifunction
>>>>>>> device plus the 4 input pins from PCI devices) there are more than 4
>>>>>>> possible sources so this can't be handled by just the 4 PCI interrupt
>>>>>>> lines. We need to keep track of the state of each interrupt source to
>>>>>>> be able to determine the level of the ISA interrupt and avoid one
>>>>>>> device clearing it while other still has an interrupt.
>>>>>> </quote>
>>>>>> 
>>>>>> This here is the important bit, since what you're describing here is 
>>>>>> exactly how PCI interrupts in QEMU work, and so is already handled by 
>>>>>> the existing PCI IRQ routing code. It seems to me that what you're 
>>>>>> doing here is creating an incomplete re-implementation of part of the 
>>>>>> PCI interrupt logic in isa_irq_state, which is a strong hint that this 
>>>>>> is the wrong approach and that you should be making use of PCI IRQ 
>>>>>> routing.
>>>>> 
>>>>> I don't see how this can be handled by the PCI interrupt routing which 
>>>>> only considers 4 lines while in VIA we have more sources than that which 
>>>>> are the chip functions (some even with more than one IRQ like IDE) and 
>>>>> the 4 PCI interrupt inputs and these can be routed to any of the ISA 
>>>>> IRQs independently (there's a register for each of them, the funcs use 
>>>>> thi interrupt line config reg and the PCI pins the regs in the ISA 
>>>>> func). So how would PCI handle this when it only sees the 4 PCI 
>>>>> interrupt lines but not the chip functions as separate sources? You've 
>>>>> assumed that those functions must be PCI devices too but their 
>>>>> interrupts are routable separately from the PCI interrupts so you can 
>>>>> have PCI INTA-D mapped to IRQ 7,8,9,10 and USB func mapped to IRQ 5 
>>>>> (like amigaone does) so you can't use PCI interrupt for the USB too but 
>>>>> have to consider all of these separately and route them in the ISA 
>>>>> bridge.
>>>> 
>>>> Ah so the restriction here is the number of PCI interrupt lines? That can 
>>>> be done by increasing the number of PCI bus IRQs to 4 + N, where 0-3 
>>>> represent INTA-D and the N others represent individual functions on the 
>>>> in-built devices. You can then determine the slot/function in the PCI map 
>>>> IRQ function to route to the appropriate N IRQ.
>>> 
>>> I can't because the PCI bus is in the north bridge. This VIA south bridge 
>>> is just a PCIDevice connected to a bus so it should not take over 
>>> interrupt handling of that bus which it does not own like the piix seems 
>>> to do. That seems much more hacky than my solution to model what the chip 
>>> does and map internal interrupt sources to ISA interrupts. The PCI 
>>> interrupts are just additional input pins on this chip it does not handle 
>>> the PCI bus itself, that's in the north bridge outside of this device.
>> 
>> The PCI bus is only in the north bridge in your particular machine because 
>> you felt in your opinion it should be there, no?
>
> No. It's there because in real hardware the PCI busses are provided by the 
> north bridge which is the PCI host so it should register and own the PCI 
> busses. The south bridge is a PCIDevice that's connected to one of these 
> buses. It's only involved in PCI interrupt handling in that it contains the 
> ISA PICs which already handles the internal functions and has 4 inputs for 
> PCI interrupts that it can also route to ISA interrupts. In pegasos2 the PCU 
> interrupts are connected to both these inputs on the VIA south bridge and to 
> CPIO intputs on the north bridge and both can be programmed to generate 
> interrupts to CPU with their own registers. Some guests may use one way while 
> others the other way. All of this is now modelled correctly.
>
>> Certainly PIIX and ICH9 both use the south bridge because it allows PCI IRQ 
>> routing with existing APIs. Maybe that is the main reason why it is done 
>> this way?
>
> I'm not sure what you mean but piix seems to call pci_bus_irqs() in its 
> realize method thus replacing IRQ handling of the bus it is connected to 
> which I think is wrong. If you plug this in a machine that has its interrupt 
> routing this will break that so I think PCI devices should not do that, only 
> the pci host or board code should wire this up.
>
>> I've added both the PCI and x86 maintainers to this email, since it clear 
>> we need input from developers with a deeper understanding of the PCI IRQ 
>> routing API and how it should work on x86. I'll attempt to summarise for

The machines discussed here (amigaone and pegasos2) aren't x86 and they 
may work differently than a PC using PIIX or ICH9 therefore I'm not sure 
what those do is relevant here. Here are some docs for reference about the 
north bridges these machines use where you can see that PCI is part of 
those and not the sourh bridge which may be the case on PCs where the 
south bridge may be more involved in PCI and north bridge is only memory 
controller there but that's not the case here so south bridge should not 
do PCI handling.

http://obligement.free.fr/files/articia_s.pdf
https://static6.arrow.com/aropdfconversion/2e73cb3a884e8a2fe165974fb7fefef556d12c18/disciipower.pdf

Regards,
BALATON Zoltan

>> them below:
>>
>>  - Normally a PCIDevice uses pci_set_irq() to set its IRQ, and the routing 
>> is
>>    handled by a pci_map_irq_fn() with the ISA interrupt controller being 
>> driven
>>    through pci_route_irq_fn() e.g. piix_route_intx_pin_to_irq(). That is to 
>> say
>>    that the PCIDevice is simply responsible for asserting its own IRQ, and 
>> does
>>    not involve itself with IRQ routing.
>>
>>  - The VIA PCI-ISA bridge needs a way to implement routing of PCI pins to 
>> ISA IRQs
>>    based upon the PCI devfn of the integrated device that raises its PCI 
>> IRQ. It
>>    doesn't appear there is currently an obvious way to do this.
>>
>>  - Zoltan has a series that attempts to implement this, but it bypasses the
>>    existing PCI IRQ routing mechanism and uses a custom routing function 
>> that
>>    needs to added to each integrated VIA device. This instinctively feels
>>    wrong to me because it bypasses the existing PCI routing infrastructure, 
>> requires
>>    the VIA PCIDevices to be aware of their own routing, and prevents e.g.
>>    instantiating via-ide as a separate -device on the command line for 
>> testing, as
>>    already works with piix3-ide.
>> 
>> Questions for PCI and x86 maintainers:
>>
>>   1) Is there a way to implement routing of PCI pins to ISA IRQs based upon 
>> the PCI
>>      devfn of the PCIDevice that asserts its IRQ?
>>
>>   2) If not, how can it be implemented in a way that best 
>> complements/integrates
>>      with the existing PCI IRQ routing infrastructure? PIIX and ICH9 
>> implementations
>>      show how it is possible to get very close to what is needed by VIA, 
>> but there
>>      may be maintainers with better ideas for implementing this in modern 
>> QEMU.
>> 
>> Zoltan: I suggest that you discuss this with the PCI/x86 maintainers in 
>> order to determine a suitable way forward.
>
> We could discuss this but I think what you propose is not only unnecessary 
> but also wrong:
>
> - PCIDevice should not replace IRQ handling of the bus it's plugged in.
>
> - There are more IRQ sources to route here than the 4 PCI lines (we have each 
> chip function (IDE, 2xUSB, PM, AC97 + the 4 PCI IRQ inputs and maybe some 
> more we don't model yet) so this does not fit in the PCIBus interrupt 
> handling that only concerns the 4 PCU interrupt lines. Your proposal to 
> increase number of PCI interrupts to overcome this deviates from real 
> hardware and tries to shoehorn ISA interrupt routing into PCIBus where it 
> does not belong. Your rationale is code reuse but you're trying to reuse here 
> something that's not doing what is needed.
>
> - Modelling it in the ISA bridge is straightforward and easier to understand 
> and matches the hardware, no tricks is needed to model something with PCI 
> that isn't a PCI device.
>
> - The internal functions aren't independent PCI devices, they are part of the 
> chip and only modelled as PCIDevice because they appear as functions of the 
> south bridge chip but they are connected internally and clearly use registers 
> in a non-standard way, e.g. using PCI_INTERRUPT_LINE to decide which ISA 
> interrupt they should raise. These devices aren't user creatable as they are 
> part of the south bdidge chip model (only split off to break up the device 
> model into objects) so then using via_isa_set_irq instead of pci_set_irq is 
> also not a problem as these functions only work as part of the VIA south 
> bridge so no point in trying to make them standalone PCI devices when they 
> are not. That just unnecessarily complicates code without any useful 
> advantage. These devices don't exist standalone so there's no point in 
> allowing them to be instantiated without the south bridge they are part of.
>
> Lastly, accepting my solution now does not make it impossible to change it 
> later when this discussion is finished. If we find another way to make it 
> simpler we could do that but so far I don't think what you're pushing here 
> would make it simpler or better so I'm yet to be convinced about that.
>
> Regerds,
> BALATON Zoltan
>
>>>>>>> This fixes USB on amigaone and maybe other bugs not discovered yet.
>>>>>> 
>>>>>> Given that the AmigaOne machine is new, can you explain in a bit more 
>>>>>> detail what the difference is between the Pegasos2 and AmigaOne 
>>>>>> machines, particularly with respect to where the existing IRQ routing 
>>>>>> logic is getting this wrong?
>>>>> 
>>>>> The pegasos2 firmware sets all chip functions and PCI devices (except 
>>>>> IDE which is hard coded to legacy interrupts) to IRQ 9 so it worked with 
>>>>> mixing PCI interrupts with chip functions but the amigaone does not do 
>>>>> that and sets different ISA interrupts to chip functions and PCI 
>>>>> interrupts so the current simplified version cannot work with that any 
>>>>> more and we need to allow separate routing of all the interrupt sources. 
>>>>> (Additionally we need to keep interrupt state for each source to allow 
>>>>> multiple sources to control the same ISA interrupt.) I could not think 
>>>>> of any simpler way than my patch to correctly implement this.
>>>> 
>>>> The key point of interest is that we have PIIX that basically already 
>>>> works using the existing PCI IRQ routing APIs: the aim is to do something 
>>>> similar with VIA, or to tweak the existing APIs if needed to make it 
>>>> possible. Otherwise you end up with the situation in this series in which 
>>>> you're effectively inventing a parallel form of PCI IRQ routing just for 
>>>> the VIA ISA bridge and hardcoding it into the in-built VIA devices.
>>> 
>>> I've looked at piix now but that seems to have less functions and those 
>>> are probably PCI devices that only use PCI interrutps so you can just use 
>>> PCI intrrupts there. It srill needs to keep track of interrupt state 
>>> separately so piix also has code for that and piix replaces the interrupt 
>>> callbacks of the bus the chip is connected to so it takes over that from 
>>> the north bridge or whatever the pci bus is part of. That does not seem 
>>> right to me and this may break the bus piix is connected to. A PCIDevice 
>>> should not call pci_bus_irqs() IMO, only the part that owns the PCI bus or 
>>> board code should set this but not a device. The pegasos2 already uses it 
>>> to connect to PCI interrupts so VIA can't do that and should not do that. 
>>> What I have is self contained and models the chip correctly. Why not 
>>> change piix to do similarly or why do you insist these have to be the same 
>>> when they are different chips with different quirks of their own?
>>> 
>>>> The benefit of using the PCI IRQ routing APIs is that it is also possible 
>>>> to plug in the individual PCI device/functions using -device into any PCI 
>>>> bus for testing, which is something that is already done with PIIX-IDE.
>>> 
>>> That does not seem like a useful goal to me. These VIA ide, usb and ac97 
>>> parts are functions of the same chip so their models are part of the chip 
>>> model. They may be different QOM objects to separate them but they aren't 
>>> user creatable and should not be as these are part of the chip so it does 
>>> not make sense to instantiate them separately. Then it's also not a 
>>> problem to use VIA specific irq routing in these as they are part of the 
>>> same model.
>>> 
>>> I think trying to force using the PCI irq mapping and setting code from 
>>> PCIBus would not make the via model any better just make it more complex 
>>> for no gain so I don't think that's a goal that should be followed. 
>>> Besides not being possible to cleanly do that it would also make it more 
>>> difficult to understand and debug interrupt routing later so I don't see 
>>> what advantage would that have over having a self contained model of the 
>>> chip even if piix manages to do it with PCIBus. But piix has only 4 
>>> interrupt lines and I don't think what it does taking over PCI interrupts 
>>> is a good idea so I don't want to go that direction. Having via and piix 
>>> models work slightly differently is not a problem IMO as long as both are 
>>> working and correct in themselves. There are other device models which 
>>> implement similar devices yet do it differently and in this case piix and 
>>> via are different in that via has more functions and their interrupts are 
>>> routed separately so it does not fit well with what we have in PCIBus. 
>>> Forcing it in that would just make it more complicated. These chips are 
>>> also from different vendors so while it may make sense to model piix3 and 
>>> piix4 similarly and sharing code (like vt82c686b and vt8231 are sharing 
>>> code) it may not make that much sense to try to make piix and via similar 
>>> when they may not be in reality other than both are collecting similar 
>>> functions but their inner working may be different. The via chips seem 
>>> more like an ISA superio chip that has some PCI support added while piix 
>>> may more like a collection of separate PCI functions so their models may 
>>> also be different in that.
>> 
>> 
>> ATB,
>> 
>> Mark.
>> 
>> 
>
>

