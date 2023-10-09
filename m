Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9BE7BEE94
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 00:55:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpz8m-0003zN-90; Mon, 09 Oct 2023 18:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qpz8j-0003yb-Lk; Mon, 09 Oct 2023 18:54:17 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qpz8g-0002dm-Ir; Mon, 09 Oct 2023 18:54:17 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 781E774632B;
 Tue, 10 Oct 2023 00:53:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 199637456AC; Tue, 10 Oct 2023 00:53:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 154D57456A7;
 Tue, 10 Oct 2023 00:53:18 +0200 (CEST)
Date: Tue, 10 Oct 2023 00:53:18 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org, 
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>, 
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Subject: Re: [PATCH 2/3] hw/pci-host: Add emulation of Mai Logic Articia S
In-Reply-To: <c4223720-129a-42ee-a8c7-7bccc30002bd@ilande.co.uk>
Message-ID: <e9d17d6c-125b-0c1f-47e6-a23f193d7958@eik.bme.hu>
References: <cover.1696542537.git.balaton@eik.bme.hu>
 <90adfa92df7bf760059924a92deebcd6b32e7f37.1696542537.git.balaton@eik.bme.hu>
 <29142019-2a88-4621-8767-58668113d8c7@ilande.co.uk>
 <819b5705-96d7-0c64-11ea-924198f936c3@eik.bme.hu>
 <2636ec4a-749c-4fcf-81fa-99a2faf48ec3@ilande.co.uk>
 <9a16138a-ae25-8eb2-0cae-c5782803f636@eik.bme.hu>
 <c4223720-129a-42ee-a8c7-7bccc30002bd@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1648692419-1696891998=:30885"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1648692419-1696891998=:30885
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 9 Oct 2023, Mark Cave-Ayland wrote:
> On 09/10/2023 22:57, BALATON Zoltan wrote:
>> On Mon, 9 Oct 2023, Mark Cave-Ayland wrote:
>>> On 08/10/2023 19:08, BALATON Zoltan wrote:
>>>> On Sun, 8 Oct 2023, Mark Cave-Ayland wrote:
>>>>> On 05/10/2023 23:13, BALATON Zoltan wrote:
>>>>> 
>>>>>> The Articia S is a generic chipset supporting several different CPUs
>>>>>> that were used on some PPC boards. This is a minimal emulation of the
>>>>>> parts needed for emulating the AmigaOne board.
>>>>>> 
>>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>>> ---
>>>>>>   hw/pci-host/Kconfig           |   5 +
>>>>>>   hw/pci-host/articia.c         | 266 
>>>>>> ++++++++++++++++++++++++++++++++++
>>>>>>   hw/pci-host/meson.build       |   2 +
>>>>>>   include/hw/pci-host/articia.h |  17 +++
>>>>>>   4 files changed, 290 insertions(+)
>>>>>>   create mode 100644 hw/pci-host/articia.c
>>>>>>   create mode 100644 include/hw/pci-host/articia.h
>>>>>> 
>>>>>> diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
>>>>>> index a07070eddf..33014c80a4 100644
>>>>>> --- a/hw/pci-host/Kconfig
>>>>>> +++ b/hw/pci-host/Kconfig
>>>>>> @@ -73,6 +73,11 @@ config SH_PCI
>>>>>>       bool
>>>>>>       select PCI
>>>>>>   +config ARTICIA
>>>>>> +    bool
>>>>>> +    select PCI
>>>>>> +    select I8259
>>>>>> +
>>>>>>   config MV64361
>>>>>>       bool
>>>>>>       select PCI
>>>>>> diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
>>>>>> new file mode 100644
>>>>>> index 0000000000..80558e1c47
>>>>>> --- /dev/null
>>>>>> +++ b/hw/pci-host/articia.c
>>>>>> @@ -0,0 +1,266 @@
>>>>>> +/*
>>>>>> + * Mai Logic Articia S emulation
>>>>>> + *
>>>>>> + * Copyright (c) 2023 BALATON Zoltan
>>>>>> + *
>>>>>> + * This work is licensed under the GNU GPL license version 2 or later.
>>>>>> + *
>>>>>> + */
>>>>>> +
>>>>>> +#include "qemu/osdep.h"
>>>>>> +#include "qemu/log.h"
>>>>>> +#include "qapi/error.h"
>>>>>> +#include "hw/pci/pci_device.h"
>>>>>> +#include "hw/pci/pci_host.h"
>>>>>> +#include "hw/irq.h"
>>>>>> +#include "hw/i2c/bitbang_i2c.h"
>>>>>> +#include "hw/intc/i8259.h"
>>>>>> +#include "hw/pci-host/articia.h"
>>>>>> +
>>>>>> +OBJECT_DECLARE_SIMPLE_TYPE(ArticiaState, ARTICIA)
>>>>>> +
>>>>>> +OBJECT_DECLARE_SIMPLE_TYPE(ArticiaHostState, ARTICIA_PCI_HOST)
>>>>>> +struct ArticiaHostState {
>>>>>> +    PCIDevice parent_obj;
>>>>>> +
>>>>>> +    ArticiaState *as;
>>>>>> +};
>>>>>> +
>>>>>> +/* TYPE_ARTICIA */
>>>>>> +
>>>>>> +struct ArticiaState {
>>>>>> +    PCIHostState parent_obj;
>>>>>> +
>>>>>> +    qemu_irq irq[PCI_NUM_PINS];
>>>>>> +    MemoryRegion io;
>>>>>> +    MemoryRegion mem;
>>>>>> +    MemoryRegion reg;
>>>>>> +
>>>>>> +    bitbang_i2c_interface smbus;
>>>>>> +    uint32_t gpio; /* bits 0-7 in, 8-15 out, 16-23 direction (0 in, 1 
>>>>>> out) */
>>>>>> +    hwaddr gpio_base;
>>>>>> +    MemoryRegion gpio_reg;
>>>>>> +};
>>>>> 
>>>>> These types above should be in the header file and not in the C file, as 
>>>>> per our current QOM guidelines.
>>>> 
>>>> I don't think there's such a guideline, at least I did not find any 
>>>> mention of it in style and qom docs. It was necessary to move some type 
>>>> declarations to headers for types that are embedded in other objects 
>>>> because C needs the struct size for that, but I don't think that should 
>>>> be a general thing when it's not needed.
>>>> 
>>>> The reason for that is that moving these to the header exposes internal 
>>>> object structure to users that should not need to know that so it breaks 
>>>> object encapsulation and also needs moving a bunch of includes to the 
>>>> header which then makes the users of this type also include those headers 
>>>> when they don't really need them but only need the type defines to 
>>>> instantiate the object and that's all they should have access to. So I 
>>>> think declaring types in the header should only be done for types that 
>>>> aren't full devices and are meant to be embedded as part of another 
>>>> device or a SoC but otherwise it's better to keep implementation closed 
>>>> and local to the object and not expose it unless really needed, that's 
>>>> why these are here.
>>>> 
>>>> If you insist I can move these but I don't think there's really such 
>>>> recommendation and I don't think that's a good idea because of the above.
>>> 
>>> Maybe it was something that was missed out of the recent documentation 
>>> updates, but you can clearly see this has been the standard pattern for 
>>> some time, including for recent devices such as the xlnx-versal. If there 
>>> are any devices that don't follow this pattern then it is likely because 
>>> they are based on older code.
>>> 
>>> If you disagree with this, then start a new thread on qemu-devel with a 
>>> new proposal and if everyone is agreement then that will be become the new 
>>> standard.
>> 
>> I think you should start a thread with a patch to style or qom docs about 
>> this to document this standard and if that's accepted then I also accept it 
>> as a real recommendation as my understanding of it was as above that it was 
>> needed for some deviecs to allow embedding them but not a general 
>> recommendation for all devices and I don't think it should be beacuse of 
>> braeaking encapsulation and introduces a lot of unneded includes so I'd 
>> keep it to those devices where it'e really needed which is what the docs 
>> currently say.
>
> Oh is there already a mention of this somewhere in the docs? Can you provide 
> a link so we can check the wording? Certainly that's the way my own patches 
> (and other people's patches) have been reviewed historically over the years.

The only mention I could find is in docs/devel/qom.rst, section "Standard 
type declaration and definition macros" which says: "In types which do not 
require any virtual functions in the class, the OBJECT_DECLARE_SIMPLE_TYPE 
macro is suitable, and is commonly placed in the header file" and then 
continues as "The 'struct MyDevice' needs to be declared separately." so 
it does not say the type should be in the header file, only the 
declaration macro and even that is not a requirement just a common 
pattern.

As I said above I think the convention of putting typedefs in the header 
came as a result of Peter's invention of embedding devices into their 
parents that is to avoid tools warning about not freing them which is 
reall working around a defficiency in the memory management of QEMU but 
this requires the parents to know the size of the objects to embed them as 
members so their declaration had to be moved to their public header for 
this. But this then breaks object encapsulation, locality and goes against 
another effort to reduce the number of unneded includes so I think this 
practice should be limited only to cases where it's needed. I've used that 
in PPC440 cleanup series before where the SoC object embeds the devices it 
contains so these were moved to a public header but here we model a 
complete device that isn't meant to be embedded anywhere so the board code 
should not need its internal structure. Therefore that's best declared in 
the implementation. Moving the OBJECT_DECLARE macros to the header could 
be done but also not necessary as per current docs so I wote for keeping 
scope of these to only where they are really needed and not expose them 
unnecessarily.

Regards,
BALATON Zoltan

>> But I also said I can change this if you insist as for just this devices 
>> only used once it does not matter much so I take that as you still want 
>> this chnage so I can send another version but wait for the opinion of the 
>> maintainers if they want anything else changed so I cah do all remaining 
>> changes in next version.
>
> Having a separate header would certainly be part of my review criteria as 
> I've been asked to make such changes in the past. But yeah, maybe wait for a 
> bit and see what other review comments arrive.
>
>
> ATB,
>
> Mark.
>
>
>
--3866299591-1648692419-1696891998=:30885--

