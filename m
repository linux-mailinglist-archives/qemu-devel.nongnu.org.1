Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 500F886AFDE
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Feb 2024 14:06:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfJce-0002VH-TT; Wed, 28 Feb 2024 08:05:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rfJaa-0001WJ-5K
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 08:03:23 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rfJaU-0002rB-Ma
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 08:03:11 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C98534E6006;
 Wed, 28 Feb 2024 14:02:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id f9nAGhP6hhsf; Wed, 28 Feb 2024 14:02:55 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C1BB04E6012; Wed, 28 Feb 2024 14:02:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C04207456B4;
 Wed, 28 Feb 2024 14:02:55 +0100 (CET)
Date: Wed, 28 Feb 2024 14:02:55 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>
Subject: Re: [PATCH 3/5] hw/isa: Embed TYPE_PORT92 in south bridges used in
 PC machines
In-Reply-To: <e2299f9a-47bb-48a1-84fb-85f171c4e480@eik.bme.hu>
Message-ID: <cff0513f-80ca-7f24-9af3-55acb059464c@eik.bme.hu>
References: <20240218131701.91132-1-shentey@gmail.com>
 <20240218131701.91132-4-shentey@gmail.com>
 <6a2333d7-9dea-4a0e-9d91-0889e6205128@ilande.co.uk>
 <F3980E89-7FE5-443A-9287-DB0350B159D9@gmail.com>
 <f25bdf58-2fc0-9f04-ef6c-c8d1cff02405@eik.bme.hu>
 <241AE060-27EF-4A36-92C8-7563256273A9@gmail.com>
 <e2299f9a-47bb-48a1-84fb-85f171c4e480@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Wed, 28 Feb 2024, BALATON Zoltan wrote:
> On Tue, 27 Feb 2024, Bernhard Beschow wrote:
>> Am 27. Februar 2024 21:54:19 UTC schrieb BALATON Zoltan 
>> <balaton@eik.bme.hu>:
>>> On Tue, 27 Feb 2024, Bernhard Beschow wrote:
>>>> Am 21. Februar 2024 11:53:21 UTC schrieb Mark Cave-Ayland 
>>>> <mark.cave-ayland@ilande.co.uk>:
>>>>> On 18/02/2024 13:16, Bernhard Beschow wrote:
>>>>>> Port 92 is an integral part of the PIIX and ICH south bridges, so 
>>>>>> instantiate it
>>>>>> there. The isapc machine now needs to instantiate it explicitly, 
>>>>>> analoguous to
>>>>>> the RTC.
>>>>>> 
>>>>>> Note that due to migration compatibility, port92 is optional in the 
>>>>>> south
>>>>>> bridges. It is always instantiated the isapc machine for simplicity.
>>>>>> 
>>>>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>>>>> ---
>>>>>>   include/hw/i386/pc.h          |  2 +-
>>>>>>   include/hw/southbridge/ich9.h |  4 ++++
>>>>>>   include/hw/southbridge/piix.h |  3 +++
>>>>>>   hw/i386/pc.c                  | 18 ++++++++++++------
>>>>>>   hw/i386/pc_piix.c             |  9 +++++++--
>>>>>>   hw/i386/pc_q35.c              |  8 +++++---
>>>>>>   hw/isa/lpc_ich9.c             |  9 +++++++++
>>>>>>   hw/isa/piix.c                 |  9 +++++++++
>>>>>>   hw/isa/Kconfig                |  2 ++
>>>>>>   9 files changed, 52 insertions(+), 12 deletions(-)
>>>>> 
>>>>> I had a look at this (and did a bit of revision around 8042 and A20), 
>>>>> and I am starting to wonder if the PORT92 device isn't something that 
>>>>> belongs to the southbridge, but more specifically to the superio chip?
>>>> 
>>>> If there is agreement to model real hardware in QEMU, then I think that
>>> 
>>> I think there's no such agreement and QEMU is more lax about it both for 
>>> historical reasons and to simplify machine models. Indeed, QEMU sometimes 
>>> models non-existing machines (e.g. the mac99 or virt boards) that don't 
>>> correspond to real hardware but allow guest OSes to boot. Even when 
>>> modelllng real hardware it's ofren modelled just enough for guests to work 
>>> and unused details are omitted for simplicity. It is recommended to follow 
>>> what real hardware does when modelling real hardware but not always 
>>> required. Although it might help both with verifying a device model and to 
>>> compose machines with these models to try to follow the real hardware.
>> 
>> Composing real machines and verifying device models is exactly what I'm 
>> after. I'm aware that QEMU provides virt machines such as the microvm, and 
>> from the context I didn't refer to these.
>
> Even without pure virt machines currently a lot of QEMU machines don't 
> exactly model real hardware. They may roughly follow real hardware but not 
> exactly such as mac99 is a non-existent Mac and the pc machines also use some 
> parts that don't exist in real life such as PIIX4-PIIX3 hybrid you've been 
> working on resolving. Some of these however are restricted by backward 
> compatibilty requirements. But you probably aware of all of that but this 
> means the argument that real hardware should be followed is not enough. At 
> least it should not break backward compatibility too much and that's more 
> important than exactly modelling real machine. Also having a simple model may 
> be more important than modeling every detail even when not used just to 
> follow real hardware.
>
>>>> port 92 belongs into any device model where the hardware has one. All our 
>>>> PC-like southbridges (PIIX, ICH, VIA) have port 92. Many FDC37xxxx 
>>>> including the FDC37M81x as used in the Malta board have one, too -- where 
>>>> it must first be enabled.
>>> 
>>> So port92 is not a real hardware but a QEMU abstraction or model of some 
>>> functionality found in some machines. Real chips probably implement this 
>>> in different ways so we could either model this in these chips 
>>> independently the same way as real hardware does or use the abstracted 
>>> model anywhere in our machine model. Since this does not exist in real 
>>> hardware as this abstract model it also does not belong anywhere so we are 
>>> free to put it where it's most convenient or simple to do.
>> 
>> As mentioned already, port 92 is an integral part of PIIX, ICH, and VIA 
>> southbridges.
>
> Mark argued that more specifically it's part of the superio within those 
> couthbridges. That makes sense, considering this port92 is related to 
> functionality that was in the keyboard contorller before which is part of the 
> superio. I don't know PC hardware too well but reading about this fast gate 
> A20 feature looks like original PC and XT had only a 1 MB address space but 
> addresses above 1 MB wrapped to 0 and some software depended on that. Then AT 
> added more memory but then it needed a way to control if addresses above 1 MB 
> would wrap or access high memory. This was done with some free part of the 
> keyboard controller but that was too slow so an alternative fast way was 
> added with this port92 device. But then the old keyboard controller and this 
> port92 stuff are interacting so may need to consider both. Apart from that 
> all of this is not relevant to other machines that don't use this 
> functionality.
>
> QEMU decided to model it as a separate QOM object that is now instantiated by 
> the machines that use it. This is not real hardware but a QEMU implementation 
> detail. What's wrong with that? It seems you just want to simplify the pc 
> machine creation and push this object that does not correspond to some real 
> hardware somewhere else. But this belongs nowhere as it does not model a real 
> hardware.
>
>> That's why I want to move it there. My goal is to create different PC 
>> machines in a data-driven manner which model real boards. I want to see how 
>> low-level guests interact with the hardware, including e.g. how they set up 
>> the memory map.
>
> Then I think the port92 as a QOM object should be gone completely and 
> implemented separately in south bridges beacause in real machine there's no 
> such port 92 thing, only a south briege so if you need to create port92 in a 
> data driver machine description then that's not modeling real hardware but 
> reflects QEMU implementation of it. However the QOM object could be retained

So in real VIA vt8231 chip there's a pin that should be connected to the 
CPU. The docs say for this pin: "A20M# A20 Mask. Connect to A20 mask input 
of the CPU to control address bit-20 generation. Logical combination of 
the A20GATE input (from internal or external keyboard controller) and Port 
92 bit-1 (Fast A20). See Device 0 Function 0 Rx59[1]."

There's another pin: "KBCK / A20GATE
MultiFunction Pin (Internal keyboard controller enabled by F0 Rx51[0])
Rx51[0]=1 Keyboard Clock. From internal keyboard controller
Rx51[0]=0 Gate A20. Input from external keyboard controller."

To model this in QEMU following what hardware does these should be named 
gpios that the machine code connects. The functionality seems to be a 
qemu_irq that is either ORed to the similar output from the KBC or not 
depending on register settings. So it seems the KBC model that's embedded 
in the superio should also expose such pin then what uses it should 
connect it somewhere (either forward to other components or combine it 
with its own A20 output).

If you want to follow real hardware then this should be implemented and 
the port92 QOM object should be removed. Also need to check what other 
southbridges do as those may be different at least in how they control the 
qemu_irq so I'm not sure one implementation can be shared between all 
these south bridges that way. It moay be simpler for now to leave it as it 
is.

Regards,
BALATON Zoltan

