Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2163974998D
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:34:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHMJY-0006Kq-LB; Thu, 06 Jul 2023 06:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qHMJW-0006KZ-EB
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:34:18 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qHMJU-0004Bv-PC
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I39WZU9RjLA9uoBrhzRJFG+ErWReVVd0Guu7zSwLVqk=; b=vNoLTW9/cKuCrD5YYazmrvu37l
 9zskWaVH1pit6Kboc/0NMIfyH1TJb2fnxLlzEgWNGobJqWEUvVOSsKBw4gkoDlYj/lbZb8yzW5oKt
 8kP9BtGnuEnT33HGO+817VDKrlnvaIYJXxo0MJjPL+2FcXQu5lHql+qwU3TI4y8nIioYxEtzkbHrJ
 dDU6EkOup9CjnDUJj12W1W6zkAhJletshvnwWABtFh/KWecD8AAagxLZN1fEVO+a+2u9JVCFOPr19
 21HJHyNnQXHJ8N+zqc2rUO3b5iM+dPRuTzXz6dHzChN/v1p9rR8tFu3WGon3LIc0m/snlmMeLFqh3
 iYXxX99uUWUc5+3pv9AjU7VAUx260fa1HyNKa+/TZ/m+WwCGzUC9DjKmJeBjcO8s2JHPae+ekc3cO
 JfHmSwTViqsZgdJohVfqhDXlwpvg8Dpg/n4anf22rPmLToZKrr8eUVBjPo4H25PE2nIhbh252Mrkf
 4Xdzt/dL92byuBobOL4K/cgV9z+mHLcNp5bC2fFiRpRj1WjAIL7krZZ/sYfWYq3BhjHBV7kQj57zV
 uKbZLV4LUOiW/KZsccrvHmrenkCdIHPqELhDnjYNZU3u2vdepfJniPo+PKdzSVfbjcMGVywn0wPxB
 Vv2fozsd4xuR7WM5VRgTaqlOWejr9Cqvp9PO3ugS8=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qHMJC-0001Mc-Ll; Thu, 06 Jul 2023 11:34:02 +0100
Message-ID: <637ef83e-193d-ba3c-74b5-184f677d4556@ilande.co.uk>
Date: Thu, 6 Jul 2023 11:34:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 laurent@vivier.eu, qemu-devel@nongnu.org
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-15-mark.cave-ayland@ilande.co.uk>
 <13c93212-0dc4-b7f6-0e29-eb8753f30801@linaro.org>
 <a00ae69d-3e2f-73fd-3e4a-c6e6154a0328@ilande.co.uk>
 <83711380-73dd-e7a4-d888-3010fe4fb906@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <83711380-73dd-e7a4-d888-3010fe4fb906@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 14/21] mac_via: work around underflow in TimeDBRA timing
 loop in SETUPTIMEK
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 06/07/2023 11:10, Philippe Mathieu-Daudé wrote:

> On 5/7/23 21:49, Mark Cave-Ayland wrote:
>> On 03/07/2023 09:30, Philippe Mathieu-Daudé wrote:
>>
>>> On 2/7/23 17:48, Mark Cave-Ayland wrote:
>>>> The MacOS toolbox ROM calculates the number of branches that can be executed
>>>> per millisecond as part of its timer calibration. Since modern hosts are
>>>> considerably quicker than original hardware, the negative counter reaches zero
>>>> before the calibration completes leading to division by zero later in
>>>> CALCULATESLOD.
>>>>
>>>> Instead of trying to fudge the timing loop (which won't work for TimeDBRA/TimeSCCDB
>>>> anyhow), use the pattern of access to the VIA1 registers to detect when SETUPTIMEK
>>>> has finished executing and write some well-known good timer values to TimeDBRA
>>>> and TimeSCCDB taken from real hardware with a suitable scaling factor.
>>>>
>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> ---
>>>>   hw/misc/mac_via.c         | 115 ++++++++++++++++++++++++++++++++++++++
>>>>   hw/misc/trace-events      |   1 +
>>>>   include/hw/misc/mac_via.h |   3 +
>>>>   3 files changed, 119 insertions(+)
>>>>
>>>> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
>>>> index baeb73eeb3..766a32a95d 100644
>>>> --- a/hw/misc/mac_via.c
>>>> +++ b/hw/misc/mac_via.c
>>>> @@ -16,6 +16,7 @@
>>>>    */
>>>>   #include "qemu/osdep.h"
>>>> +#include "exec/address-spaces.h"
>>>>   #include "migration/vmstate.h"
>>>>   #include "hw/sysbus.h"
>>>>   #include "hw/irq.h"
>>>
>>>
>>>> +/*
>>>> + * Addresses and real values for TimeDBRA/TimeSCCB to allow timer calibration
>>>> + * to succeed (NOTE: both values have been multiplied by 3 to cope with the
>>>> + * speed of QEMU execution on a modern host
>>>> + */
>>>> +#define MACOS_TIMEDBRA        0xd00
>>>> +#define MACOS_TIMESCCB        0xd02
>>>> +
>>>> +#define MACOS_TIMEDBRA_VALUE  (0x2a00 * 3)
>>>> +#define MACOS_TIMESCCB_VALUE  (0x079d * 3)
>>>> +
>>>> +static bool via1_is_toolbox_timer_calibrated(void)
>>>> +{
>>>> +    /*
>>>> +     * Indicate whether the MacOS toolbox has been calibrated by checking
>>>> +     * for the value of our magic constants
>>>> +     */
>>>> +    uint16_t timedbra = lduw_be_phys(&address_space_memory, MACOS_TIMEDBRA);
>>>> +    uint16_t timesccdb = lduw_be_phys(&address_space_memory, MACOS_TIMESCCB);
>>>
>>> Rather than using the global address_space_memory (which we secretly
>>> try to remove entirely), could we pass a MemoryRegion link property
>>> to the VIA1 device?
>>
>> Hmmm good question. It seems to me that we're dispatching a write to the default 
>> address space (which includes all RAM and MMIO etc.) rather than a particular 
>> MemoryRegion so it feels as if AddressSpace is the right approach here. 
>> Unfortunately since AddressSpace is not a QOM type then it isn't possible to pass 
>> it as a link property.
> 
> We pass a MR link.

That could work, but then we'd have to grab the host pointer via 
memory_region_get_ram_ptr() first and switch to using lduw_be_p(). And if we did have 
an MR property then what should it be set to? The obvious candidate would be 
get_system_memory() but should we also be avoiding that for similar reasons? If we 
did use it, then we might as well use get_system_memory() directly rather than having 
to pass in a separate link property.

>> There are existing examples in qtest that use first_cpu->as which seems a better 
>> option unless we want to move away from using first_cpu in the codebase?
> 
> See:
> 
>    $ git grep -E "(PROP.*LINK.*MEMORY_REGION|dma-mr)"
> 
> Anyway I don't object to your patch, we can rework this
> &address_space_memory use later when we'll have discussed the whole
> design.

Agreed. It feels like there are still some discussions needed to understand exactly 
what needs to be done in order to move forward with this (maybe start a separate 
thread?).


ATB,

Mark.


