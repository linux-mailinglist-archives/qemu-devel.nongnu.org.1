Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A2C7DD6C0
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:47:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxugM-0005Bu-KX; Tue, 31 Oct 2023 15:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qxugK-0005BK-HB
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:45:44 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qxugI-0006LH-4N
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BsBW3HMFUIklZfgZJDoNndSqt0XrmCb+56HMUQr9aVM=; b=fU64T2uTxXEUV18PaoBkUNsuwu
 ZnE/8eBqvCr9AngEbWwoZmLtCWmIBvp77gkyZiagsgOd6m2v09Vj761OIOzqpsjVtiQ8lo9oD8YiO
 NOFLK5742ShoYLDPKLV9JTxxJMr390Ew48yqICs5EBXO6tEW6HVqIkffFFGuc/sExtbx+ZRB8/Qh6
 +l3IVqIgpTje0DR+HW9i1nlSZAJhTNy8Um9a/vVLfVytn6DqZ3QPhLitgqEU9Nhsn4RkXF27ikRHI
 Ue+kd8QjaAy1CyIiSR5V6BJvaOg7MGf+Tc4DvyycyrUxU2ThSJ0Syh25rNm1N7MRxrIA+CrNuEJ4N
 9PJGbhfWGdzzwb6zs8ZMaXP8CIrX3nJfJNXtl1PVo8z4P9/+O+yKx11shXONvqWXZ001dpWPl/Grt
 pZPoPf7rjOv7JCEiahWTsnem6N6UG0O8ifCgdXk1ZGSTrJ6TWOST56eQB9L/eoaT/Y6Rs/OlE9Elx
 +GkCZ9laStx0QAd3bSO83TRF1b1m/DcBCEyglX9KTlfSqrvQq5FRXgGvrPwNjkIjaf3VhU0Ww8LY5
 bgDD1uqQoYDEMA91fsZnbVoq+c7g5e6qxCGWDoHhuggidQgwAPB1+nJ1xiVhInvCKwLz1xBsHSvRG
 xQBGr84Ljy3yfJH14O7onO+BQ+NIdMc0CZZb6N+rE=;
Received: from [2a00:23c4:8bb0:5400:cc59:10c5:2c74:638b]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qxug2-0009Bw-OV; Tue, 31 Oct 2023 19:45:30 +0000
Message-ID: <74bad1b1-3291-41b3-85ee-998d6ba8bfff@ilande.co.uk>
Date: Tue, 31 Oct 2023 19:45:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Bernhard Beschow <shentey@gmail.com>,
 vr_qemu@t-online.de, mst@redhat.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1698536342.git.balaton@eik.bme.hu>
 <03f52ea1-7436-4129-bd53-e14104a9e74e@ilande.co.uk>
 <0f4b0c4b-9229-dcc5-d12a-3f423c316f80@eik.bme.hu>
 <e8a8425a-d824-44da-a2b1-3187f01d59cd@ilande.co.uk>
 <942b8c93-f6d1-60a8-3dca-3506523de394@eik.bme.hu>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <942b8c93-f6d1-60a8-3dca-3506523de394@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:5400:cc59:10c5:2c74:638b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/4] Fix IRQ routing in via south bridge
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 30/10/2023 21:57, BALATON Zoltan wrote:

> On Mon, 30 Oct 2023, Mark Cave-Ayland wrote:
>> On 29/10/2023 13:45, BALATON Zoltan wrote:
>>> On Sun, 29 Oct 2023, Mark Cave-Ayland wrote:
>>>> On 29/10/2023 00:56, BALATON Zoltan wrote:
>>>>
>>>>> This is going back to my otiginal proposal in
>>>>> https://patchew.org/QEMU/cover.1677004414.git.balaton@eik.bme.hu/
>>>>> implementing routing of interrupts from device functions and PCI
>>>>> devices to ISA interrupts. On pegasos2 the firmware sets evertyhing to
>>>>> share IRQ 9 so the current simpified version worked for taht but with
>>>>> the amigaone machine its firmware makes use of this feature and
>>>>> assigns different interrupts to functions and PCI devices so we need
>>>>> to properly impelent this.
>>>>
>>>> <quote>
>>>>> Since any ISA interrupt can be controlled
>>>>> by any interrupt source (different functions of the multifunction
>>>>> device plus the 4 input pins from PCI devices) there are more than 4
>>>>> possible sources so this can't be handled by just the 4 PCI interrupt
>>>>> lines. We need to keep track of the state of each interrupt source to
>>>>> be able to determine the level of the ISA interrupt and avoid one
>>>>> device clearing it while other still has an interrupt.
>>>> </quote>
>>>>
>>>> This here is the important bit, since what you're describing here is exactly how 
>>>> PCI interrupts in QEMU work, and so is already handled by the existing PCI IRQ 
>>>> routing code. It seems to me that what you're doing here is creating an 
>>>> incomplete re-implementation of part of the PCI interrupt logic in isa_irq_state, 
>>>> which is a strong hint that this is the wrong approach and that you should be 
>>>> making use of PCI IRQ routing.
>>>
>>> I don't see how this can be handled by the PCI interrupt routing which only 
>>> considers 4 lines while in VIA we have more sources than that which are the chip 
>>> functions (some even with more than one IRQ like IDE) and the 4 PCI interrupt 
>>> inputs and these can be routed to any of the ISA IRQs independently (there's a 
>>> register for each of them, the funcs use thi interrupt line config reg and the PCI 
>>> pins the regs in the ISA func). So how would PCI handle this when it only sees the 
>>> 4 PCI interrupt lines but not the chip functions as separate sources? You've 
>>> assumed that those functions must be PCI devices too but their interrupts are 
>>> routable separately from the PCI interrupts so you can have PCI INTA-D mapped to 
>>> IRQ 7,8,9,10 and USB func mapped to IRQ 5 (like amigaone does) so you can't use 
>>> PCI interrupt for the USB too but have to consider all of these separately and 
>>> route them in the ISA bridge.
>>
>> Ah so the restriction here is the number of PCI interrupt lines? That can be done 
>> by increasing the number of PCI bus IRQs to 4 + N, where 0-3 represent INTA-D and 
>> the N others represent individual functions on the in-built devices. You can then 
>> determine the slot/function in the PCI map IRQ function to route to the appropriate 
>> N IRQ.
> 
> I can't because the PCI bus is in the north bridge. This VIA south bridge is just a 
> PCIDevice connected to a bus so it should not take over interrupt handling of that 
> bus which it does not own like the piix seems to do. That seems much more hacky than 
> my solution to model what the chip does and map internal interrupt sources to ISA 
> interrupts. The PCI interrupts are just additional input pins on this chip it does 
> not handle the PCI bus itself, that's in the north bridge outside of this device.

The PCI bus is only in the north bridge in your particular machine because you felt 
in your opinion it should be there, no? Certainly PIIX and ICH9 both use the south 
bridge because it allows PCI IRQ routing with existing APIs. Maybe that is the main 
reason why it is done this way?

I've added both the PCI and x86 maintainers to this email, since it clear we need 
input from developers with a deeper understanding of the PCI IRQ routing API and how 
it should work on x86. I'll attempt to summarise for them below:

   - Normally a PCIDevice uses pci_set_irq() to set its IRQ, and the routing is
     handled by a pci_map_irq_fn() with the ISA interrupt controller being driven
     through pci_route_irq_fn() e.g. piix_route_intx_pin_to_irq(). That is to say
     that the PCIDevice is simply responsible for asserting its own IRQ, and does
     not involve itself with IRQ routing.

   - The VIA PCI-ISA bridge needs a way to implement routing of PCI pins to ISA IRQs
     based upon the PCI devfn of the integrated device that raises its PCI IRQ. It
     doesn't appear there is currently an obvious way to do this.

   - Zoltan has a series that attempts to implement this, but it bypasses the
     existing PCI IRQ routing mechanism and uses a custom routing function that
     needs to added to each integrated VIA device. This instinctively feels
     wrong to me because it bypasses the existing PCI routing infrastructure, requires
     the VIA PCIDevices to be aware of their own routing, and prevents e.g.
     instantiating via-ide as a separate -device on the command line for testing, as
     already works with piix3-ide.

Questions for PCI and x86 maintainers:

    1) Is there a way to implement routing of PCI pins to ISA IRQs based upon the PCI
       devfn of the PCIDevice that asserts its IRQ?

    2) If not, how can it be implemented in a way that best complements/integrates
       with the existing PCI IRQ routing infrastructure? PIIX and ICH9 implementations
       show how it is possible to get very close to what is needed by VIA, but there
       may be maintainers with better ideas for implementing this in modern QEMU.

Zoltan: I suggest that you discuss this with the PCI/x86 maintainers in order to 
determine a suitable way forward.

>>>>> This fixes USB on amigaone and maybe other bugs not discovered yet.
>>>>
>>>> Given that the AmigaOne machine is new, can you explain in a bit more detail what 
>>>> the difference is between the Pegasos2 and AmigaOne machines, particularly with 
>>>> respect to where the existing IRQ routing logic is getting this wrong?
>>>
>>> The pegasos2 firmware sets all chip functions and PCI devices (except IDE which is 
>>> hard coded to legacy interrupts) to IRQ 9 so it worked with mixing PCI interrupts 
>>> with chip functions but the amigaone does not do that and sets different ISA 
>>> interrupts to chip functions and PCI interrupts so the current simplified version 
>>> cannot work with that any more and we need to allow separate routing of all the 
>>> interrupt sources. (Additionally we need to keep interrupt state for each source 
>>> to allow multiple sources to control the same ISA interrupt.) I could not think of 
>>> any simpler way than my patch to correctly implement this.
>>
>> The key point of interest is that we have PIIX that basically already works using 
>> the existing PCI IRQ routing APIs: the aim is to do something similar with VIA, or 
>> to tweak the existing APIs if needed to make it possible. Otherwise you end up with 
>> the situation in this series in which you're effectively inventing a parallel form 
>> of PCI IRQ routing just for the VIA ISA bridge and hardcoding it into the in-built 
>> VIA devices.
> 
> I've looked at piix now but that seems to have less functions and those are probably 
> PCI devices that only use PCI interrutps so you can just use PCI intrrupts there. It 
> srill needs to keep track of interrupt state separately so piix also has code for 
> that and piix replaces the interrupt callbacks of the bus the chip is connected to so 
> it takes over that from the north bridge or whatever the pci bus is part of. That 
> does not seem right to me and this may break the bus piix is connected to. A 
> PCIDevice should not call pci_bus_irqs() IMO, only the part that owns the PCI bus or 
> board code should set this but not a device. The pegasos2 already uses it to connect 
> to PCI interrupts so VIA can't do that and should not do that. What I have is self 
> contained and models the chip correctly. Why not change piix to do similarly or why 
> do you insist these have to be the same when they are different chips with different 
> quirks of their own?
> 
>> The benefit of using the PCI IRQ routing APIs is that it is also possible to plug 
>> in the individual PCI device/functions using -device into any PCI bus for testing, 
>> which is something that is already done with PIIX-IDE.
> 
> That does not seem like a useful goal to me. These VIA ide, usb and ac97 parts are 
> functions of the same chip so their models are part of the chip model. They may be 
> different QOM objects to separate them but they aren't user creatable and should not 
> be as these are part of the chip so it does not make sense to instantiate them 
> separately. Then it's also not a problem to use VIA specific irq routing in these as 
> they are part of the same model.
> 
> I think trying to force using the PCI irq mapping and setting code from PCIBus would 
> not make the via model any better just make it more complex for no gain so I don't 
> think that's a goal that should be followed. Besides not being possible to cleanly do 
> that it would also make it more difficult to understand and debug interrupt routing 
> later so I don't see what advantage would that have over having a self contained 
> model of the chip even if piix manages to do it with PCIBus. But piix has only 4 
> interrupt lines and I don't think what it does taking over PCI interrupts is a good 
> idea so I don't want to go that direction. Having via and piix models work slightly 
> differently is not a problem IMO as long as both are working and correct in 
> themselves. There are other device models which implement similar devices yet do it 
> differently and in this case piix and via are different in that via has more 
> functions and their interrupts are routed separately so it does not fit well with 
> what we have in PCIBus. Forcing it in that would just make it more complicated. These 
> chips are also from different vendors so while it may make sense to model piix3 and 
> piix4 similarly and sharing code (like vt82c686b and vt8231 are sharing code) it may 
> not make that much sense to try to make piix and via similar when they may not be in 
> reality other than both are collecting similar functions but their inner working may 
> be different. The via chips seem more like an ISA superio chip that has some PCI 
> support added while piix may more like a collection of separate PCI functions so 
> their models may also be different in that.


ATB,

Mark.


