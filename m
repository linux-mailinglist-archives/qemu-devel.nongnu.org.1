Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A6D7DA846
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 19:43:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwnJr-0004LU-Js; Sat, 28 Oct 2023 13:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qwnJm-0004LF-Kf
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 13:41:50 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qwnJk-0001ov-4H
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 13:41:50 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 212A3756078;
 Sat, 28 Oct 2023 19:41:46 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 16D897456A7; Sat, 28 Oct 2023 19:41:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 13162745681;
 Sat, 28 Oct 2023 19:41:45 +0200 (CEST)
Date: Sat, 28 Oct 2023 19:41:45 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 5/5] hw/isa/vt82c686: Implement software-based SMI
 triggering
In-Reply-To: <02D892F2-0778-40EF-A583-A4728B119EF8@gmail.com>
Message-ID: <ac277c44-7910-1a6b-49ea-afb2b03274ff@eik.bme.hu>
References: <20231028091606.23700-1-shentey@gmail.com>
 <20231028091606.23700-6-shentey@gmail.com>
 <95144ce6-b340-11bf-354b-e73c2fbc795e@eik.bme.hu>
 <02D892F2-0778-40EF-A583-A4728B119EF8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

On Sat, 28 Oct 2023, Bernhard Beschow wrote:
> Am 28. Oktober 2023 13:03:41 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> On Sat, 28 Oct 2023, Bernhard Beschow wrote:
>>> If enabled, SMIs can be triggered via software by writing to an IO-mapped port.
>>> SMIs usually trigger execution of BIOS code. If appropriate values are written
>>> to the port, the BIOS transitions the system into or out of ACPI mode.
>>>
>>> Note that APMState implements Intel-specific behavior where there are two IO
>>> ports which are mapped at fixed addresses. In VIA, there is only one such port
>>> which is located inside a relocatable IO-mapped region. Hence, there is no point
>>> in reusing APMState.
>>>
>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>> ---
>>> hw/isa/vt82c686.c | 95 +++++++++++++++++++++++++++++++++++++++++++----
>>> 1 file changed, 87 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
>>> index e8ec63dea9..361b3bed0a 100644
>>> --- a/hw/isa/vt82c686.c
>>> +++ b/hw/isa/vt82c686.c
>>> @@ -27,7 +27,6 @@
>>> #include "hw/timer/i8254.h"
>>> #include "hw/rtc/mc146818rtc.h"
>>> #include "migration/vmstate.h"
>>> -#include "hw/isa/apm.h"
>>> #include "hw/acpi/acpi.h"
>>> #include "hw/i2c/pm_smbus.h"
>>> #include "qapi/error.h"
>>> @@ -42,6 +41,16 @@
>>> #define TYPE_VIA_PM "via-pm"
>>> OBJECT_DECLARE_SIMPLE_TYPE(ViaPMState, VIA_PM)
>>>
>>> +#define VIA_PM_IO_GBLEN 0x2a
>>> +#define VIA_PM_IO_GBLEN_SW_SMI_EN (1 << 6)
>>> +
>>> +#define VIA_PM_IO_GBLCTL 0x2c
>>> +#define VIA_PM_IO_GBLCTL_SMI_EN 1
>>> +#define VIA_PM_IO_GBLCTL_SMIIG (1 << 4)
>>> +#define VIA_PM_IO_GBLCTL_INSMI (1 << 8)
>>> +
>>> +#define VIA_PM_IO_SMI_CMD 0x2f
>>> +
>>> #define VIA_PM_GPE_LEN 4
>>>
>>> #define VIA_PM_SCI_SELECT_OFS 0x42
>>
>> If we'll make a copy of the data sheet in form of #defines could these be in the header to less clutter the source?
>
> Last time I did that I was asked to move the defines back into the 
> source file. I can't find the link right now, otherwise I'd have placed 
> it here.

Yeah, the public header is probably not a good place for these either. 
Maybe add a local vt82c686_regs,h or similar private header in hw/isa next 
to the .c file for these? I'd just say we could use the constant values 
directly as reviewing them will need to look up the data sheet anyway but 
Philippe was in favour of adding defines for constants. This isn't a big 
deal though.

Regards,
BALATON Zoltan

