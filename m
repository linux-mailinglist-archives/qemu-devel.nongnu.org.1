Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7590685A2BD
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Feb 2024 13:01:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc2Kc-0004Ov-Iv; Mon, 19 Feb 2024 07:01:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rc2KZ-0004OD-In; Mon, 19 Feb 2024 07:01:07 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rc2KW-0005oz-FR; Mon, 19 Feb 2024 07:01:07 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C43534E6003;
 Mon, 19 Feb 2024 13:01:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id HmYGrJ2q1YiC; Mon, 19 Feb 2024 13:00:58 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C9CA84E6026; Mon, 19 Feb 2024 13:00:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C7EBC7456B4;
 Mon, 19 Feb 2024 13:00:58 +0100 (CET)
Date: Mon, 19 Feb 2024 13:00:58 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org, 
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>, 
 Igor Mitsyanko <i.mitsyanko@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 1/6] hw/arm: Inline sysbus_create_simple(PL110 / PL111)
In-Reply-To: <2b9ea923-c4f9-4ee4-8ed2-ba9f62c15579@linaro.org>
Message-ID: <6b5758d6-f464-2461-f9dd-71d2e15b610a@eik.bme.hu>
References: <20240216153517.49422-1-philmd@linaro.org>
 <20240216153517.49422-2-philmd@linaro.org>
 <bcfd3f9d-04e3-79c9-c15f-c3c8d7669bdb@eik.bme.hu>
 <2f8ec2e2-c4c7-48c3-9c3d-3e20bc3d6b9b@linaro.org>
 <b40fd79f-4d41-4e04-90c1-6f4b2fde811d@linaro.org>
 <00e2b898-3c5f-d19c-fddc-e657306e071f@eik.bme.hu>
 <2b9ea923-c4f9-4ee4-8ed2-ba9f62c15579@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1407859581-1708344058=:44613"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1407859581-1708344058=:44613
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 19 Feb 2024, Philippe Mathieu-Daudé wrote:
> On 19/2/24 12:27, BALATON Zoltan wrote:
>> On Mon, 19 Feb 2024, Philippe Mathieu-Daudé wrote:
>>> On 16/2/24 20:54, Philippe Mathieu-Daudé wrote:
>>>> On 16/2/24 18:14, BALATON Zoltan wrote:
>>>>> On Fri, 16 Feb 2024, Philippe Mathieu-Daudé wrote:
>>>>>> We want to set another qdev property (a link) for the pl110
>>>>>> and pl111 devices, we can not use sysbus_create_simple() which
>>>>>> only passes sysbus base address and IRQs as arguments. Inline
>>>>>> it so we can set the link property in the next commit.
>>>>>> 
>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> ---
>>>>>> hw/arm/realview.c    |  5 ++++-
>>>>>> hw/arm/versatilepb.c |  6 +++++-
>>>>>> hw/arm/vexpress.c    | 10 ++++++++--
>>>>>> 3 files changed, 17 insertions(+), 4 deletions(-)
>>>>>> 
>>>>>> diff --git a/hw/arm/realview.c b/hw/arm/realview.c
>>>>>> index 9058f5b414..77300e92e5 100644
>>>>>> --- a/hw/arm/realview.c
>>>>>> +++ b/hw/arm/realview.c
>>>>>> @@ -238,7 +238,10 @@ static void realview_init(MachineState *machine,
>>>>>>     sysbus_create_simple("pl061", 0x10014000, pic[7]);
>>>>>>     gpio2 = sysbus_create_simple("pl061", 0x10015000, pic[8]);
>>>>>> 
>>>>>> -    sysbus_create_simple("pl111", 0x10020000, pic[23]);
>>>>>> +    dev = qdev_new("pl111");
>>>>>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>>>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x10020000);
>>>>>> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[23]);
>>>>> 
>>>>> Not directly related to this patch but this blows up 1 line into 4 just 
>>>>> to allow setting a property. Maybe just to keep some simplicity we'd 
>>>>> rather need either a sysbus_realize_simple function that takes a sysbus 
>>>>> device instead of the name and does not create the device itself or some 
>>>>> way to pass properties to sysbus create simple (but the latter may not 
>>>>> be easy to do in a generic way so not sure about that). What do you 
>>>>> think?
>>>> 
>>>> Unfortunately sysbus doesn't scale in heterogeneous setup.
>>> 
>>> Regarding the HW modelling API complexity you are pointing at, we'd
>>> like to move from the current imperative programming paradigm to a
>>> declarative one, likely DSL driven. Meanwhile it is being investigated
>>> (as part of "Dynamic Machine"), I'm trying to get the HW APIs right
>> 
>> I'm aware of that activity but we're currently still using board code to 
>> construct machines and probably will continue to do so for a while. Also 
>> because likely not all current machines will be converted to new 
>> declarative way so having a convenient API for that is still useful.
>> 
>> (As for the language to describe the devices of a machine and their 
>> connections declaratively the device tree does just that but dts is not a 
>> very user friendly descrtiption language so I haven't brought that up as a 
>> possibility. But you may still could get some clues by looking at the 
>> problems it had to solve to at least get a requirements for the machine 
>> description language.)
>> 
>>> for heterogeneous emulation. Current price to pay is a verbose
>>> imperative QDev API, hoping we'll get later a trivial declarative one
>>> (like this single sysbus_create_simple call), where we shouldn't worry
>>> about the order of low level calls, whether to use link or not, etc.
>> 
>> Having a detailed low level API does not prevent a more convenient for 
>> current use higher level API on top so keeping that around for current 
>> machines would allow you to chnage the low level API without having to 
>> change all the board codes because you's only need to update the simple 
>> high level API.
>
> So what is your suggestion here, add a new complex helper to keep
> a one-line style?
>
> DeviceState *sysbus_create_simple_dma_link(const char *typename,
>                                           hwaddr baseaddr,
>                                           const char *linkname,
>                                           Object *linkobj,
>                                           qemu_irq irq);

I think just having sysbus_realize_simple that does the same as 
sysbus_create_simple minus creating the device would be enough because 
then the cases where you need to set properties could still use it after 
qdev_new or init and property_set but hide the realize and connecting the 
device behind this single call.

> I wonder why this is that important since you never modified
> any of the files changed by this series:

For new people trying to contribute to QEMU QDev is overwhelming so having 
some way to need less of it to do simple things would help them to get 
started.

Regards,
BALATON Zoltan
--3866299591-1407859581-1708344058=:44613--

