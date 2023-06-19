Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB617356DC
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 14:29:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBDz6-0003iv-UZ; Mon, 19 Jun 2023 08:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBDyw-0003ib-89
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:27:43 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBDyP-00061G-Hi
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N/o21fn9c5ozsRFqIxOt51/Osm9o3U35QBTDRNrLa1w=; b=QxABxpMDK58ZBYby80g6o5Bwy3
 QumFq8GaGM/VqJVBaZBxM2KdCZjrLLLFvQ51Xuvr1Jz2LWUyncNLwlrD3JI6Rwjnl6RDVtwSi/87N
 kUra0nhpXzGz9PvByH+gGUsq4pPZr1FnmAMgsWiYdyfcXCAnpiCtXHFhCoj8BgFddYYb7IWeIXwTK
 r9N52cc0clZpiPudr7myPYMqUCzSh0PzdP98PXKOH8rAXNEPvdwMDCueGfv2F36Di3V+aEEvH3Ooy
 xuyIRm4+7MbA56GzYkKCOOcGPnlpg38pavy/fjXkohMRTyvWueuHTQhv9gwLUrIzJn5HP7YPIZgZH
 R7nrBNgKvvHJ6xlSuFqtpYsWcrlmtjAykBxURD6wmQ3szT8kKug4P2Pi31jSpenhdfgMAcOywmNF3
 ytjqjw9pi9YfFTix6j//3Efir9MQPB65V2yxZDuLHgBxHNgCK3i/lEBUU/npGxJJhGmpyMZkjPSj7
 +aLpgm1NSPU5fEizv8B1rrg5WEwbOfpfxmfHINWa1pha+qXNPPs891v6MsVqhrYBgytoKxkPDiaou
 lWiQzWLrfFvEDz+Hh2iJadSeLK4vKoLKim0VQ8n1h8+UupcFkWfHE0XwrLCrnpbQrckrmWrlt6/wi
 gk8eRwGm+AEtAGnI+X+mRDkIalZdHSMKaJodJfvqw=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBDyA-0007hA-TE; Mon, 19 Jun 2023 13:26:59 +0100
Message-ID: <341ff172-03b4-e8b5-40c7-1517a6ed3c57@ilande.co.uk>
Date: Mon, 19 Jun 2023 13:26:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 laurent@vivier.eu, qemu-devel@nongnu.org
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
 <20230604131450.428797-8-mark.cave-ayland@ilande.co.uk>
 <d6b7f5ff-d51d-f821-5c2a-20ae7c2d0cc4@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <d6b7f5ff-d51d-f821-5c2a-20ae7c2d0cc4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 07/23] q800: move GLUE device into separate q800-glue.c
 file
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 05/06/2023 13:41, Philippe Mathieu-Daudé wrote:

> On 4/6/23 15:14, Mark Cave-Ayland wrote:
>> This will allow the q800-glue.h header to be included separately so that the
>> GLUE device can be referenced externally.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>   MAINTAINERS                 |   2 +
>>   hw/m68k/meson.build         |   2 +-
>>   hw/m68k/q800-glue.c         | 252 ++++++++++++++++++++++++++++++++++++
>>   hw/m68k/q800.c              | 238 +---------------------------------
>>   include/hw/m68k/q800-glue.h |  50 +++++++
>>   5 files changed, 306 insertions(+), 238 deletions(-)
>>   create mode 100644 hw/m68k/q800-glue.c
>>   create mode 100644 include/hw/m68k/q800-glue.h
> 
> 
>> diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
>> new file mode 100644
>> index 0000000000..793bdb110c
>> --- /dev/null
>> +++ b/hw/m68k/q800-glue.c
>> @@ -0,0 +1,252 @@
>> +/*
>> + * QEMU q800 logic glue
> 
> Although mentioned later, could we describe as "GLUE (General
> Logic Unit)" here?

Sure, I can fix this in v4.

>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a copy
>> + * of this software and associated documentation files (the "Software"), to deal
>> + * in the Software without restriction, including without limitation the rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>> + * copies of the Software, and to permit persons to whom the Software is
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>> + * THE SOFTWARE.
> 
> Or simpler:
> 
>    * SPDX-License-Identifier: MIT

Thanks, I didn't realise that we could do this. In this particular case the header is 
simply a copy of the one from q800.c where the code originated from, so my thinking 
is that it makes sense to leave this for now and consider a wider update for the m68k 
machines as a follow-up.

>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "cpu.h"
>> +#include "hw/m68k/q800-glue.h"
>> +#include "hw/boards.h"
>> +#include "hw/irq.h"
>> +#include "hw/nmi.h"
>> +#include "hw/qdev-properties.h"
>> +#include "migration/vmstate.h"
>> +
>> +/*
>> + * The GLUE (General Logic Unit) is an Apple custom integrated circuit chip
>> + * that performs a variety of functions (RAM management, clock generation, ...).
>> + * The GLUE chip receives interrupt requests from various devices,
>> + * assign priority to each, and asserts one or more interrupt line to the
>> + * CPU.
>> + */
> 
> 
>> +static const TypeInfo glue_info = {
>> +    .name = TYPE_GLUE,
>> +    .parent = TYPE_SYS_BUS_DEVICE,
>> +    .instance_size = sizeof(GLUEState),
>> +    .instance_init = glue_init,
>> +    .instance_finalize = glue_finalize,
>> +    .class_init = glue_class_init,
>> +    .interfaces = (InterfaceInfo[]) {
>> +         { TYPE_NMI },
>> +         { }
>> +    },
>> +};
>> +
>> +static void glue_register_types(void)
>> +{
>> +    type_register_static(&glue_info);
>> +}
>  > +
>  > +type_init(glue_register_types)
> 
> Soon DEFINE_TYPES() will be recommended over type_init().

I see, I'll add this as a separate patch in v4.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!


ATB,

Mark.


