Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D97C738657
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:10:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByWs-0001r8-Ku; Wed, 21 Jun 2023 10:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qByWq-0001qb-KU
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:09:48 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qByWp-0000kE-64
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pAB7pL3eTId2EnNBib5vhqnGaa9L3geGXhdQuDJSd4s=; b=Q7T6+VZ3cH6Pk8w+ptGBfYfEA/
 actgTLe/Ae3ofiPNk+ZXX4sRIiSm3CAWLFBUe0+Lnr2/6cELlwg56kmsoVMVE1GWpycKmflWjYMSe
 bxF/VBx/C050YTNPaZmRYecvXsPJoYitBKU1nj+2LZgK3tZUrPTdD19IJP7fXHvWqYzGNB0qbrr0m
 pgdlil9RdSOl14BFkgJ7jStxnNtaj8JNhR+iivSa6E68F1qSySSU1ktDzsYGQM6PD5XtB3WLda4Lb
 TyvqOluRjCmjv5wNnNGj0bb1NjY60k/BO/1zrJc6bvD6Up11fx1C7SPE2pODr6WIak8IZK9b6DOOT
 w/XbJi5tZMIhLJ/qfo0wp9E3z4fARmmb7XZ/2MeBnnaRe70nih6IHiw1B5ROTWfkoc6RLDb4c4aqJ
 E/pqDe34eWGpjAP0g7CFMCmv84gOQ4ZiJH/EIytsXjeYBN4wk1eDPYnwKol88jXSvEYpZqQx4gh25
 VvUVUn7dVq/RslPMttzTwh3rh5d/J7YdRui9KTQpNbjWaC7js532yhOu4OCLe3Yj9iUhRKL/x2X+/
 N8f6BC4yFWc/scTGEvgwPevA/NR5sQdHxLeRioDPtEWQFpLLGSSZcW1uNkTm8UpJgbfcYKyBfxijW
 kvsSTf4xaObuUfL7vSelyXbErmzYBevHQx6Qln8/I=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qByWd-0003Gr-0t; Wed, 21 Jun 2023 15:09:39 +0100
Message-ID: <b1a9d38e-d238-6249-ae9e-9d917e2a091f@ilande.co.uk>
Date: Wed, 21 Jun 2023 15:09:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 laurent@vivier.eu, qemu-devel@nongnu.org
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
 <20230621085353.113233-8-mark.cave-ayland@ilande.co.uk>
 <b15a4923-dfab-f8f8-c6f7-45ffda82d9d0@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <b15a4923-dfab-f8f8-c6f7-45ffda82d9d0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v4 07/24] q800: move GLUE device into separate q800-glue.c
 file
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 21/06/2023 10:46, Philippe Mathieu-Daudé wrote:

> On 21/6/23 10:53, Mark Cave-Ayland wrote:
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
>> index 0000000000..e81f9438f1
>> --- /dev/null
>> +++ b/hw/m68k/q800-glue.c
>> @@ -0,0 +1,252 @@
>> +/*
>> + * QEMU q800 logic GLUE (General Logic Unit)
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
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "cpu.h"
>> +#include "hw/m68k/q800-glue.h"
>> +#include "hw/boards.h"
> 
> "hw/boards.h" shouldn't be necessary here.

Okay.

>> +#include "hw/irq.h"
>> +#include "hw/nmi.h"
>> +#include "hw/qdev-properties.h"
>> +#include "migration/vmstate.h"
> 
> 
>> diff --git a/include/hw/m68k/q800-glue.h b/include/hw/m68k/q800-glue.h
>> new file mode 100644
>> index 0000000000..c1817b01a5
>> --- /dev/null
>> +++ b/include/hw/m68k/q800-glue.h
>> @@ -0,0 +1,50 @@
>> +/*
>> + * QEMU q800 logic glue
> 
> "QEMU q800 logic GLUE (General Logic Unit)" similar to .c?
> (could be changed when applying, no need to respin)

Ah so I updated it in the .c file but forgot to do the same for the .h file.

Laurent, are you able to squash this or would you like me to send a v5?

> Otherwise,
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!


ATB,

Mark.


