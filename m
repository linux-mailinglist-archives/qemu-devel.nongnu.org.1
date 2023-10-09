Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D91BF7BEE58
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 00:32:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpymX-0008SW-B1; Mon, 09 Oct 2023 18:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpymN-0008S8-PH; Mon, 09 Oct 2023 18:31:11 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpymI-0005P3-6R; Mon, 09 Oct 2023 18:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jJe6t9e9kXZ5sQNdRgZeJpMEI838ziXSog8BeLufT1o=; b=WnpGeZemvoWe4xlabICzQV3jgT
 y+QPjf9cvAT0bBXbmtngRVWXFzGoUQzYOvaWrR1F39SZO9VszJxJ3VnGnX/6LiVlSwpuv2rN7CvMU
 +1Jb0QtIZqwCvZXvUhVvwUoaRe4MQM7htgeXdCA28izMFlySVb72iCO3RB3HejByZqzRYP+J5kkhf
 qe/6RPVbUo6NO0GkoUm1IwCmr4/enETCG5hGkjYxO1s/qygJupOS0p2vi0gXB/+ER7dHk8jl/zi/+
 eKBBEiOinIn3tCFCHuSvReVS5hbSwCHWSiaA6sedqHUfcQ4U4WV9uoifc9iVr8cfVeWl+W21qMTq6
 K2tAL2JCse5gi/fARloIfIf2Lq0aMaaxliXMs/dWd2OxImgAbnyrLKEmUZi6nwOxgp3x6eRrb0+LC
 28sNMzX22gdz9yFoSsTdPhzUtY+EpLp6+pZoE+Q+QsG33/9MOMtKzDw89LJO9sL4+e5mbOiPJl5JC
 A8n4tqBdY/LUoN8ps2mfi+zjJQshBxI7aVjEsU50BKUrvLZQc2hsCuix9eXge22VwSFa+rs2nHM8+
 onYA8bjbNcwXpTd8R6ooyPbsLdMGW9pFeiZ404Brswitn7AKupIxsh11cTE+RXLkNM3zL/aYFKUsY
 mwZ/QVvOyhmMqGnuFBagIo4GxztqUCrFS4FQkdaD4=;
Received: from [2a00:23c4:8baf:fd00:bd92:8220:89aa:44b7]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpym6-0006Ei-PP; Mon, 09 Oct 2023 23:30:59 +0100
Message-ID: <c4223720-129a-42ee-a8c7-7bccc30002bd@ilande.co.uk>
Date: Mon, 9 Oct 2023 23:30:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
References: <cover.1696542537.git.balaton@eik.bme.hu>
 <90adfa92df7bf760059924a92deebcd6b32e7f37.1696542537.git.balaton@eik.bme.hu>
 <29142019-2a88-4621-8767-58668113d8c7@ilande.co.uk>
 <819b5705-96d7-0c64-11ea-924198f936c3@eik.bme.hu>
 <2636ec4a-749c-4fcf-81fa-99a2faf48ec3@ilande.co.uk>
 <9a16138a-ae25-8eb2-0cae-c5782803f636@eik.bme.hu>
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
In-Reply-To: <9a16138a-ae25-8eb2-0cae-c5782803f636@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:fd00:bd92:8220:89aa:44b7
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/3] hw/pci-host: Add emulation of Mai Logic Articia S
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 09/10/2023 22:57, BALATON Zoltan wrote:

> On Mon, 9 Oct 2023, Mark Cave-Ayland wrote:
>> On 08/10/2023 19:08, BALATON Zoltan wrote:
>>> On Sun, 8 Oct 2023, Mark Cave-Ayland wrote:
>>>> On 05/10/2023 23:13, BALATON Zoltan wrote:
>>>>
>>>>> The Articia S is a generic chipset supporting several different CPUs
>>>>> that were used on some PPC boards. This is a minimal emulation of the
>>>>> parts needed for emulating the AmigaOne board.
>>>>>
>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>> ---
>>>>>   hw/pci-host/Kconfig           |   5 +
>>>>>   hw/pci-host/articia.c         | 266 ++++++++++++++++++++++++++++++++++
>>>>>   hw/pci-host/meson.build       |   2 +
>>>>>   include/hw/pci-host/articia.h |  17 +++
>>>>>   4 files changed, 290 insertions(+)
>>>>>   create mode 100644 hw/pci-host/articia.c
>>>>>   create mode 100644 include/hw/pci-host/articia.h
>>>>>
>>>>> diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
>>>>> index a07070eddf..33014c80a4 100644
>>>>> --- a/hw/pci-host/Kconfig
>>>>> +++ b/hw/pci-host/Kconfig
>>>>> @@ -73,6 +73,11 @@ config SH_PCI
>>>>>       bool
>>>>>       select PCI
>>>>>   +config ARTICIA
>>>>> +    bool
>>>>> +    select PCI
>>>>> +    select I8259
>>>>> +
>>>>>   config MV64361
>>>>>       bool
>>>>>       select PCI
>>>>> diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
>>>>> new file mode 100644
>>>>> index 0000000000..80558e1c47
>>>>> --- /dev/null
>>>>> +++ b/hw/pci-host/articia.c
>>>>> @@ -0,0 +1,266 @@
>>>>> +/*
>>>>> + * Mai Logic Articia S emulation
>>>>> + *
>>>>> + * Copyright (c) 2023 BALATON Zoltan
>>>>> + *
>>>>> + * This work is licensed under the GNU GPL license version 2 or later.
>>>>> + *
>>>>> + */
>>>>> +
>>>>> +#include "qemu/osdep.h"
>>>>> +#include "qemu/log.h"
>>>>> +#include "qapi/error.h"
>>>>> +#include "hw/pci/pci_device.h"
>>>>> +#include "hw/pci/pci_host.h"
>>>>> +#include "hw/irq.h"
>>>>> +#include "hw/i2c/bitbang_i2c.h"
>>>>> +#include "hw/intc/i8259.h"
>>>>> +#include "hw/pci-host/articia.h"
>>>>> +
>>>>> +OBJECT_DECLARE_SIMPLE_TYPE(ArticiaState, ARTICIA)
>>>>> +
>>>>> +OBJECT_DECLARE_SIMPLE_TYPE(ArticiaHostState, ARTICIA_PCI_HOST)
>>>>> +struct ArticiaHostState {
>>>>> +    PCIDevice parent_obj;
>>>>> +
>>>>> +    ArticiaState *as;
>>>>> +};
>>>>> +
>>>>> +/* TYPE_ARTICIA */
>>>>> +
>>>>> +struct ArticiaState {
>>>>> +    PCIHostState parent_obj;
>>>>> +
>>>>> +    qemu_irq irq[PCI_NUM_PINS];
>>>>> +    MemoryRegion io;
>>>>> +    MemoryRegion mem;
>>>>> +    MemoryRegion reg;
>>>>> +
>>>>> +    bitbang_i2c_interface smbus;
>>>>> +    uint32_t gpio; /* bits 0-7 in, 8-15 out, 16-23 direction (0 in, 1 out) */
>>>>> +    hwaddr gpio_base;
>>>>> +    MemoryRegion gpio_reg;
>>>>> +};
>>>>
>>>> These types above should be in the header file and not in the C file, as per our 
>>>> current QOM guidelines.
>>>
>>> I don't think there's such a guideline, at least I did not find any mention of it 
>>> in style and qom docs. It was necessary to move some type declarations to headers 
>>> for types that are embedded in other objects because C needs the struct size for 
>>> that, but I don't think that should be a general thing when it's not needed.
>>>
>>> The reason for that is that moving these to the header exposes internal object 
>>> structure to users that should not need to know that so it breaks object 
>>> encapsulation and also needs moving a bunch of includes to the header which then 
>>> makes the users of this type also include those headers when they don't really 
>>> need them but only need the type defines to instantiate the object and that's all 
>>> they should have access to. So I think declaring types in the header should only 
>>> be done for types that aren't full devices and are meant to be embedded as part of 
>>> another device or a SoC but otherwise it's better to keep implementation closed 
>>> and local to the object and not expose it unless really needed, that's why these 
>>> are here.
>>>
>>> If you insist I can move these but I don't think there's really such 
>>> recommendation and I don't think that's a good idea because of the above.
>>
>> Maybe it was something that was missed out of the recent documentation updates, but 
>> you can clearly see this has been the standard pattern for some time, including for 
>> recent devices such as the xlnx-versal. If there are any devices that don't follow 
>> this pattern then it is likely because they are based on older code.
>>
>> If you disagree with this, then start a new thread on qemu-devel with a new 
>> proposal and if everyone is agreement then that will be become the new standard.
> 
> I think you should start a thread with a patch to style or qom docs about this to 
> document this standard and if that's accepted then I also accept it as a real 
> recommendation as my understanding of it was as above that it was needed for some 
> deviecs to allow embedding them but not a general recommendation for all devices and 
> I don't think it should be beacuse of braeaking encapsulation and introduces a lot of 
> unneded includes so I'd keep it to those devices where it'e really needed which is 
> what the docs currently say.

Oh is there already a mention of this somewhere in the docs? Can you provide a link 
so we can check the wording? Certainly that's the way my own patches (and other 
people's patches) have been reviewed historically over the years.

> But I also said I can change this if you insist as for just this devices only used 
> once it does not matter much so I take that as you still want this chnage so I can 
> send another version but wait for the opinion of the maintainers if they want 
> anything else changed so I cah do all remaining changes in next version.

Having a separate header would certainly be part of my review criteria as I've been 
asked to make such changes in the past. But yeah, maybe wait for a bit and see what 
other review comments arrive.


ATB,

Mark.


