Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F70274990B
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:11:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHLwF-0002eA-Su; Thu, 06 Jul 2023 06:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHLwB-0002ds-Gs
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:10:11 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHLw9-00031V-8Z
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:10:11 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-992ca792065so64013166b.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 03:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688638207; x=1691230207;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rlzA/To1rz4pnkRGLEr7guh7j0qWaB/VXOD3ON7FZHo=;
 b=xmY3qnvpB641+2KTbaCYH5x7/4XSWHGYpI3rS7L0x2toKCgoofaCCVLdrHze7Q9eOt
 Xb5buqQt9LFARLvW9s2cbkS6QVPE/GfA62g5UQY5ol3oOOftvEmmzyH8AE0DSOib3W1w
 IbKjo2yCCliG8QZtaDdq6DRCJTgje/hPGtdQ16xsksen+SpElcLnT1MOgFLjL+V85O9n
 d1Bn1NFfIstNWkTF84tZZ8+DoyTc6B4ORsq3Z4GPaUo3WbaIAMKtpNjIF58pB+ZLHM0e
 lOhkS3AIDh2A6hl45GXGfV+uz4086UiOXs4NjldLp1qqkCLOW99nSrG2von27J0gSMRb
 9E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688638207; x=1691230207;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rlzA/To1rz4pnkRGLEr7guh7j0qWaB/VXOD3ON7FZHo=;
 b=eivGoYb15n0k2GnqToH5BM9154dXyWogJukVB7QpT8Hay3uKJY5yxoillZNbH/wRRX
 /wuhMzphTnPTN9xxiKqesQmpw3qYBPSFCiZVRuBP5JFlso0sBbjWeUh7vKdIcIzUn6zN
 l0wic1H7ompmKSDFx+2T/A2oBJ8yiOpu11HXa/4eIrl4eZiYqYwIujlq7CJSH846g9c+
 L0UAwIpJFFP7hEevYxzGdQLUPKDZcT9LlNuZ9aZ9UrJFitUiPzyxjJVqpXFwv6+EJbmC
 PKZdfOi8FxVO4xFnjx3fNp3BFWtZOCxm68rqHH/yRjccH04svkzWcV1bVYzha1QCoCbS
 Kbcw==
X-Gm-Message-State: ABy/qLYUvKbtu8AA73UNbCyke1fXfc+inlA05EgjUj8tuj5N5q+R0haS
 9+Dqop3aJfuVwZpFvm9CFDeuMQDrTPbMGIE7P5Y=
X-Google-Smtp-Source: APBJJlGINy3V+2nQwYlNgoHbtysVnvn00Q3AXGyThEyb3IrP3z8P9SWyO00OfjXomBr1Go8u9tiNOw==
X-Received: by 2002:a17:906:1392:b0:97e:aace:b6bc with SMTP id
 f18-20020a170906139200b0097eaaceb6bcmr1049088ejc.53.1688638207562; 
 Thu, 06 Jul 2023 03:10:07 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.225])
 by smtp.gmail.com with ESMTPSA id
 j13-20020a170906094d00b00991bba473e2sm604712ejd.85.2023.07.06.03.10.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 03:10:07 -0700 (PDT)
Message-ID: <83711380-73dd-e7a4-d888-3010fe4fb906@linaro.org>
Date: Thu, 6 Jul 2023 12:10:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 14/21] mac_via: work around underflow in TimeDBRA timing
 loop in SETUPTIMEK
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-15-mark.cave-ayland@ilande.co.uk>
 <13c93212-0dc4-b7f6-0e29-eb8753f30801@linaro.org>
 <a00ae69d-3e2f-73fd-3e4a-c6e6154a0328@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <a00ae69d-3e2f-73fd-3e4a-c6e6154a0328@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/7/23 21:49, Mark Cave-Ayland wrote:
> On 03/07/2023 09:30, Philippe Mathieu-Daudé wrote:
> 
>> On 2/7/23 17:48, Mark Cave-Ayland wrote:
>>> The MacOS toolbox ROM calculates the number of branches that can be 
>>> executed
>>> per millisecond as part of its timer calibration. Since modern hosts are
>>> considerably quicker than original hardware, the negative counter 
>>> reaches zero
>>> before the calibration completes leading to division by zero later in
>>> CALCULATESLOD.
>>>
>>> Instead of trying to fudge the timing loop (which won't work for 
>>> TimeDBRA/TimeSCCDB
>>> anyhow), use the pattern of access to the VIA1 registers to detect 
>>> when SETUPTIMEK
>>> has finished executing and write some well-known good timer values to 
>>> TimeDBRA
>>> and TimeSCCDB taken from real hardware with a suitable scaling factor.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>   hw/misc/mac_via.c         | 115 ++++++++++++++++++++++++++++++++++++++
>>>   hw/misc/trace-events      |   1 +
>>>   include/hw/misc/mac_via.h |   3 +
>>>   3 files changed, 119 insertions(+)
>>>
>>> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
>>> index baeb73eeb3..766a32a95d 100644
>>> --- a/hw/misc/mac_via.c
>>> +++ b/hw/misc/mac_via.c
>>> @@ -16,6 +16,7 @@
>>>    */
>>>   #include "qemu/osdep.h"
>>> +#include "exec/address-spaces.h"
>>>   #include "migration/vmstate.h"
>>>   #include "hw/sysbus.h"
>>>   #include "hw/irq.h"
>>
>>
>>> +/*
>>> + * Addresses and real values for TimeDBRA/TimeSCCB to allow timer 
>>> calibration
>>> + * to succeed (NOTE: both values have been multiplied by 3 to cope 
>>> with the
>>> + * speed of QEMU execution on a modern host
>>> + */
>>> +#define MACOS_TIMEDBRA        0xd00
>>> +#define MACOS_TIMESCCB        0xd02
>>> +
>>> +#define MACOS_TIMEDBRA_VALUE  (0x2a00 * 3)
>>> +#define MACOS_TIMESCCB_VALUE  (0x079d * 3)
>>> +
>>> +static bool via1_is_toolbox_timer_calibrated(void)
>>> +{
>>> +    /*
>>> +     * Indicate whether the MacOS toolbox has been calibrated by 
>>> checking
>>> +     * for the value of our magic constants
>>> +     */
>>> +    uint16_t timedbra = lduw_be_phys(&address_space_memory, 
>>> MACOS_TIMEDBRA);
>>> +    uint16_t timesccdb = lduw_be_phys(&address_space_memory, 
>>> MACOS_TIMESCCB);
>>
>> Rather than using the global address_space_memory (which we secretly
>> try to remove entirely), could we pass a MemoryRegion link property
>> to the VIA1 device?
> 
> Hmmm good question. It seems to me that we're dispatching a write to the 
> default address space (which includes all RAM and MMIO etc.) rather than 
> a particular MemoryRegion so it feels as if AddressSpace is the right 
> approach here. Unfortunately since AddressSpace is not a QOM type then 
> it isn't possible to pass it as a link property.

We pass a MR link.

> There are existing examples in qtest that use first_cpu->as which seems 
> a better option unless we want to move away from using first_cpu in the 
> codebase?

See:

   $ git grep -E "(PROP.*LINK.*MEMORY_REGION|dma-mr)"

Anyway I don't object to your patch, we can rework this
&address_space_memory use later when we'll have discussed the whole
design.

