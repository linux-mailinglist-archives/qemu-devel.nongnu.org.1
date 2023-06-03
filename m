Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C3A7212A7
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 22:24:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Xlt-0002RO-Hw; Sat, 03 Jun 2023 16:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5Xlq-0002R9-J1
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 16:22:42 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5Xlp-0000eW-1B
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 16:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AhuZOCrr4TC6Jp1ReJSRbpFQJuLjZHLvY4bi1ZvARM8=; b=P8QXtNjy5o/wz/ZzYmhTmuqxSY
 +eiWAgT2L2vi/9v63PAX4WwtgLRhCB31cWvYRPMEWjMLtmDbAGfON1IcAOpJGwSWKLj1VSAw4QOek
 yna4dU/PVWd7XGH7E0hOY+8DwnWtFxAizvHUOgwyDmAPHivgOvWGBh1cxzAyVB0woront97ob6Bdt
 NxcQ90b40O/r0TInWND0pXsU8lG8FDIIfE0IFEgexBja3GJnk9HkFAASnSxnK9hr9SURv52pH3VoD
 tEU80jlIUAd/B0w4UjyK8T4WLurARtx6si3UpajCeTXX/z4T/3Sx24P2XVmZdCoIhf/ajKE9YLMrt
 mLL9bnHM7QWm61xB7n/2/SH68djNuahjqLqSV3BiGthFqWiGTrs8uA4HeeDjk8JG2i/r58idJ7jIT
 vqzDA6XbfH43QuF+FlG+N5hmtWwteF/b/aOw87Exp4pC2lS36cMrn5UuN1vKaJ0QncF81TGfNSLjn
 KEHdy5VST6bKGKvxTtBzG0fzOAWFPctLa291D6zPtw0PRAeNhrOcdknqTkfi9iClaVuTIzHwaSNRs
 ujvh2daYbDxtujSnn/I+vho5Qr9WcZyDkivbUT5252xa8sF6uLa9rrCEHNEZrw485HbNHFQndWblz
 WnBEE7jYcCiz/kG85eUxzplyzoSPjtMn6D2K7IqLA=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5Xlb-0000zJ-L8; Sat, 03 Jun 2023 21:22:31 +0100
Message-ID: <30204c63-03aa-2a41-a9b6-2cdbec4ce970@ilande.co.uk>
Date: Sat, 3 Jun 2023 21:22:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 laurent@vivier.eu, qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-20-mark.cave-ayland@ilande.co.uk>
 <694a19ea-226e-7e69-3dad-9cb9f16cd387@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <694a19ea-226e-7e69-3dad-9cb9f16cd387@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 19/23] q800: move mac-nubus-bridge device to
 Q800MachineState
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 31/05/2023 14:52, Philippe Mathieu-Daudé wrote:

> On 31/5/23 14:53, Mark Cave-Ayland wrote:
>> Also change the instantiation of the mac-nubus-bridge device to use
>> object_initialize_child().
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/m68k/q800.c         | 5 ++++-
>>   include/hw/m68k/q800.h | 2 ++
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
>> index f85ccf83af..d02a1a7a1f 100644
>> --- a/hw/m68k/q800.c
>> +++ b/hw/m68k/q800.c
>> @@ -416,7 +416,10 @@ static void q800_machine_init(MachineState *machine)
>>       /* NuBus */
>> -    dev = qdev_new(TYPE_MAC_NUBUS_BRIDGE);
>> +    object_initialize_child(OBJECT(machine), "mac-nubus-bridge",
>> +                            &m->mac_nubus_bridge,
>> +                            TYPE_MAC_NUBUS_BRIDGE);
>> +    dev = DEVICE(&m->mac_nubus_bridge);
>>       qdev_prop_set_uint32(dev, "slot-available-mask",
>>                            Q800_NUBUS_SLOTS_AVAILABLE);
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> 
> No need to unref(), right?

Ooops yes indeed, I forgot to remove the and_unref().

>> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
>> index ce8dbcd68f..3f3e87b3dc 100644
>> --- a/include/hw/m68k/q800.h
>> +++ b/include/hw/m68k/q800.h
>> @@ -30,6 +30,7 @@
>>   #include "hw/or-irq.h"
>>   #include "hw/scsi/esp.h"
>>   #include "hw/block/swim.h"
>> +#include "hw/nubus/mac-nubus-bridge.h"
>>   /*
>>    * The main Q800 machine
>> @@ -48,6 +49,7 @@ struct Q800MachineState {
>>       OrIRQState escc_orgate;
>>       SysBusESPState esp;
>>       Swim swim;
>> +    MacNubusBridge mac_nubus_bridge;
>>       MemoryRegion macio;
>>       MemoryRegion macio_alias;
>>   };


ATB,

Mark.


