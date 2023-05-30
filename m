Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A0B715806
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 10:09:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3uOH-0003vY-F0; Tue, 30 May 2023 04:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q3uO5-0003ub-Vx
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:07:28 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q3uO4-0007S8-3X
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nwl3yf4GalRI1Z+hDJZ256IAA0Nu2v8VFsWMvLycREc=; b=bK9iCTPUHlrGsK4LGmiXIzQjCI
 VD+++kPiDzPcL8JXyHI4vxh4zVpIUr4Z0BtgZFd9SCEUu4jr+B4AgahrtwVPAKuTE5D8j8L7YLTLJ
 7SgNOo8UsYjNHi+SWhzGbPo3hCKBA1qJ9B2b2lQt9d01VEkARNuseYQTf2ASzhQpFD0GvjkxlRej0
 15fbJ3NAiNF8n5VuCjKZawhOHY3p3uVP8r8MA5bguUG39pEECtnam8piIeslJhEkaDrAcF8DjN/Zi
 1irqjXoTwzJuu/x2gqNErxWvkyMJu+UN6yq/rIJe0ytuuoJ3th76+Ety63/liKyrE2TkPcc5uDerU
 yeEhx332gli3ofjrxmcnOHemQuHmm26qpAHqsGWkP1yDgUDrNhKQVItqTwv4DIu9CASYLD9AS/bkl
 WVwqz6oJjJLUVZIb89z/42QZGJfQnG4P/aIpa1DnYgBOnzI9Fb55pcp8PcZd9sEq3SSHqiuj5UJD+
 NjVKJ4QnDK0vWWlrL1c7USJOwIA9c4m7Opr5noOQEMO/YkZD0wRdbNRZRDwonbnsncokHSTllegfe
 RkCi1gBLZkaYNJ82n/mjLhRhDYGJ6WbVWhZAlUFdQ2laVQBZXw4+GeopHVMhoZCBeyl5QfGV0jXAC
 jtX6rdrHqlSzIl+/UzhIc9hhOiWuA5un1SctpSFaA=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q3uNq-0009uT-Uh; Tue, 30 May 2023 09:07:15 +0100
Message-ID: <6d465d13-7c37-19c7-1b7d-194a8c209518@ilande.co.uk>
Date: Tue, 30 May 2023 09:07:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 laurent@vivier.eu, qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-10-mark.cave-ayland@ilande.co.uk>
 <0fd19b1f-1cf5-3252-4ad3-71e58f2a141a@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <0fd19b1f-1cf5-3252-4ad3-71e58f2a141a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 09/30] q800: add djMEMC memory controller
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 25/05/2023 09:12, Philippe Mathieu-Daudé wrote:

> On 24/5/23 23:10, Mark Cave-Ayland wrote:
>> The djMEMC controller is used to store information related to the physical memory
>> configuration.
>>
>> Co-developed-by: Laurent Vivier <laurent@vivier.eu>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   MAINTAINERS              |   2 +
>>   hw/m68k/Kconfig          |   1 +
>>   hw/m68k/q800.c           |   9 +++
>>   hw/misc/Kconfig          |   3 +
>>   hw/misc/djmemc.c         | 154 +++++++++++++++++++++++++++++++++++++++
>>   hw/misc/meson.build      |   1 +
>>   hw/misc/trace-events     |   4 +
>>   include/hw/m68k/q800.h   |   2 +
>>   include/hw/misc/djmemc.h |  46 ++++++++++++
>>   9 files changed, 222 insertions(+)
>>   create mode 100644 hw/misc/djmemc.c
>>   create mode 100644 include/hw/misc/djmemc.h
> 
> 
>> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
>> index f15f1eaff9..456407898e 100644
>> --- a/hw/m68k/q800.c
>> +++ b/hw/m68k/q800.c
>> @@ -40,6 +40,7 @@
>>   #include "bootinfo.h"
>>   #include "hw/m68k/q800.h"
>>   #include "hw/misc/mac_via.h"
>> +#include "hw/misc/djmemc.h"
>>   #include "hw/input/adb.h"
>>   #include "hw/nubus/mac-nubus-bridge.h"
>>   #include "hw/display/macfb.h"
>> @@ -66,6 +67,7 @@
>>   #define SONIC_PROM_BASE       (IO_BASE + 0x08000)
>>   #define SONIC_BASE            (IO_BASE + 0x0a000)
>>   #define SCC_BASE              (IO_BASE + 0x0c020)
>> +#define DJMEMC_BASE           (IO_BASE + 0x0e000)
>>   #define ESP_BASE              (IO_BASE + 0x10000)
>>   #define ESP_PDMA              (IO_BASE + 0x10100)
>>   #define ASC_BASE              (IO_BASE + 0x14000)
>> @@ -492,6 +494,13 @@ static void q800_machine_init(MachineState *machine)
>>                                &error_abort);
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(m->glue), &error_fatal);
>> +    /* djMEMC memory controller */
>> +    m->djmemc = qdev_new(TYPE_DJMEMC);
>> +    sysbus = SYS_BUS_DEVICE(m->djmemc);
>> +    sysbus_realize_and_unref(sysbus, &error_fatal);
>> +    memory_region_add_subregion(&m->macio, DJMEMC_BASE - IO_BASE,
>> +                                sysbus_mmio_get_region(sysbus, 0));
> 
> 
>> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
>> index 8d788a7072..d0e37cc665 100644
>> --- a/include/hw/m68k/q800.h
>> +++ b/include/hw/m68k/q800.h
>> @@ -33,6 +33,8 @@ struct Q800MachineState {
>>       M68kCPU *cpu;
>>       MemoryRegion rom;
>>       DeviceState *glue;
>> +    DeviceState *djmemc;
> 
> While I like the simplicity of using pointer to common QOM parent
> type, isn't the consensus to have QOM objects embed their children
> state? Maybe we never agreed on that explicitly :) So here I'd rather:
> 
>          DJMEMCState djmemc;

That's a fair comment. In fact it seems that even outside of this series q800.c could 
do with some better QOM parenting.

It's reasonably trivial to fix up the QOM tree within this series, although of course 
it will make it a bit larger. Let me see if I can fix this for v2.

>>       MemoryRegion macio;
>>       MemoryRegion macio_alias;
>>   };


ATB,

Mark.


