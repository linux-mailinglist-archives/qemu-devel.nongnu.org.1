Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56691748E47
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 21:50:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH8VR-0005Ox-4X; Wed, 05 Jul 2023 15:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qH8VP-0005Op-9l
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 15:49:39 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qH8VM-0005L2-QQ
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 15:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6tfGO87Shw+hBk9egln37pTUoeZiysPK2EmkJSqDuM4=; b=TEsCaeBrUh8/0+dRhx3X48+nC4
 vzfYZbu3x7I/e8FC4hC3+84qARfm2CDUTb9wVczxQh8LE5a/2QFbwH00AMA2S5Ei2lSKA4BsV8bb2
 vBQrPH61Zk5tpKI4jqD7D1QzRPmmUz0Gbj8WnW+2ZHJofg1bBGIe7hWGLOArTujC1mAvea7ak9S4q
 LkWtCOTq4vrkHw81KC9xHFS6+e5KcBlgMRTdMPrT+ZbVi8IZ5X+wD0V227ddQKxSIuSGBE24QIcvc
 gUrv+pEKFiJaBt1ZPvuTXrDtF4uuFVcyLjoImka6cDh7g4QncttKKES2iHthUCiZ4zM9d/M2Xr4uj
 JOGv1OqRwmxFqIV0cjEaq/b/2QXcvF2W4I4x3Et+5Y2nmj2nsPGiFFJUX+r6lSA+yH9vBBN87ma8p
 iZ7zWQtYWrq1bgl9Cdx0VhqUiz6xTnkZNi1ayAFXYbx3ZKGvjCzdqjZZvshQZPWPpfQRryt0dz+9l
 DKk1VJ8nxOgtkoMeo48lU/a3RhK3WvT2EC9MJ+NfV/1Kp8W+IsYweDVPcQB6++h//Ln/EEbkvTjLU
 +n3qUUkn9fdm2nrfSjb0Ch70tagMuASpBqQ+B3snMzsxqJAaFub7gXmYjpdlRjo/nB9oraZwDdn4b
 vzYpRnM4W2zZiISF2ERYzQEr2naHOstctfB8icw0A=;
Received: from [2a00:23c4:8bad:df00:f732:dd76:7417:d15b]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qH8V1-0008lW-RH; Wed, 05 Jul 2023 20:49:20 +0100
Message-ID: <a00ae69d-3e2f-73fd-3e4a-c6e6154a0328@ilande.co.uk>
Date: Wed, 5 Jul 2023 20:49:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 laurent@vivier.eu, qemu-devel@nongnu.org
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-15-mark.cave-ayland@ilande.co.uk>
 <13c93212-0dc4-b7f6-0e29-eb8753f30801@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <13c93212-0dc4-b7f6-0e29-eb8753f30801@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bad:df00:f732:dd76:7417:d15b
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

On 03/07/2023 09:30, Philippe Mathieu-Daudé wrote:

> On 2/7/23 17:48, Mark Cave-Ayland wrote:
>> The MacOS toolbox ROM calculates the number of branches that can be executed
>> per millisecond as part of its timer calibration. Since modern hosts are
>> considerably quicker than original hardware, the negative counter reaches zero
>> before the calibration completes leading to division by zero later in
>> CALCULATESLOD.
>>
>> Instead of trying to fudge the timing loop (which won't work for TimeDBRA/TimeSCCDB
>> anyhow), use the pattern of access to the VIA1 registers to detect when SETUPTIMEK
>> has finished executing and write some well-known good timer values to TimeDBRA
>> and TimeSCCDB taken from real hardware with a suitable scaling factor.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/misc/mac_via.c         | 115 ++++++++++++++++++++++++++++++++++++++
>>   hw/misc/trace-events      |   1 +
>>   include/hw/misc/mac_via.h |   3 +
>>   3 files changed, 119 insertions(+)
>>
>> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
>> index baeb73eeb3..766a32a95d 100644
>> --- a/hw/misc/mac_via.c
>> +++ b/hw/misc/mac_via.c
>> @@ -16,6 +16,7 @@
>>    */
>>   #include "qemu/osdep.h"
>> +#include "exec/address-spaces.h"
>>   #include "migration/vmstate.h"
>>   #include "hw/sysbus.h"
>>   #include "hw/irq.h"
> 
> 
>> +/*
>> + * Addresses and real values for TimeDBRA/TimeSCCB to allow timer calibration
>> + * to succeed (NOTE: both values have been multiplied by 3 to cope with the
>> + * speed of QEMU execution on a modern host
>> + */
>> +#define MACOS_TIMEDBRA        0xd00
>> +#define MACOS_TIMESCCB        0xd02
>> +
>> +#define MACOS_TIMEDBRA_VALUE  (0x2a00 * 3)
>> +#define MACOS_TIMESCCB_VALUE  (0x079d * 3)
>> +
>> +static bool via1_is_toolbox_timer_calibrated(void)
>> +{
>> +    /*
>> +     * Indicate whether the MacOS toolbox has been calibrated by checking
>> +     * for the value of our magic constants
>> +     */
>> +    uint16_t timedbra = lduw_be_phys(&address_space_memory, MACOS_TIMEDBRA);
>> +    uint16_t timesccdb = lduw_be_phys(&address_space_memory, MACOS_TIMESCCB);
> 
> Rather than using the global address_space_memory (which we secretly
> try to remove entirely), could we pass a MemoryRegion link property
> to the VIA1 device?

Hmmm good question. It seems to me that we're dispatching a write to the default 
address space (which includes all RAM and MMIO etc.) rather than a particular 
MemoryRegion so it feels as if AddressSpace is the right approach here. Unfortunately 
since AddressSpace is not a QOM type then it isn't possible to pass it as a link 
property.

There are existing examples in qtest that use first_cpu->as which seems a better 
option unless we want to move away from using first_cpu in the codebase?


ATB,

Mark.


