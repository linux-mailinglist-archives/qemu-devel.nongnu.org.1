Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB4578C65E
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:44:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaz0x-0005l6-PJ; Tue, 29 Aug 2023 09:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=bkLz=EO=kaod.org=clg@ozlabs.org>)
 id 1qaz0k-0005g1-Vg; Tue, 29 Aug 2023 09:44:04 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=bkLz=EO=kaod.org=clg@ozlabs.org>)
 id 1qaz0e-00045y-V1; Tue, 29 Aug 2023 09:44:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RZpYL6ZQsz4wxn;
 Tue, 29 Aug 2023 23:43:50 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RZpYH3DfVz4wb2;
 Tue, 29 Aug 2023 23:43:47 +1000 (AEST)
Message-ID: <f6edea23-f11c-2119-ebaf-222d9f0813b6@kaod.org>
Date: Tue, 29 Aug 2023 15:43:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 3/7] hw/fsi: Introduce IBM's cfam,fsi-slave
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, andrew@aj.id.au,
 joel@jms.id.au, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, philmd@linaro.org
Cc: qemu-arm@nongnu.org
References: <20230825203046.3692467-1-ninad@linux.ibm.com>
 <20230825203046.3692467-4-ninad@linux.ibm.com>
 <e2a8e6eb-b9fd-8011-32c0-e5c310bf1135@redhat.com>
 <11681172-0fe9-4e1d-9f8f-03f57b0b09a2@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <11681172-0fe9-4e1d-9f8f-03f57b0b09a2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=bkLz=EO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.242, SPF_HELO_PASS=-0.001,
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

On 8/29/23 15:39, Ninad Palsule wrote:
> Hello Thomas,
> 
> On 8/28/23 21:03, Thomas Huth wrote:
>> On 25/08/2023 22.30, Ninad Palsule wrote:
>>> This is a part of patchset where IBM's Flexible Service Interface is
>>> introduced.
>>>
>>> The Common FRU Access Macro (CFAM), an address space containing
>>> various "engines" that drive accesses on busses internal and external
>>> to the POWER chip. Examples include the SBEFIFO and I2C masters. The
>>> engines hang off of an internal Local Bus (LBUS) which is described
>>> by the CFAM configuration block.
>>>
>>> The FSI slave: The slave is the terminal point of the FSI bus for
>>> FSI symbols addressed to it. Slaves can be cascaded off of one
>>> another. The slave's configuration registers appear in address space
>>> of the CFAM to which it is attached.
>>>
>>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>>> ---
>> ...
>>> diff --git a/hw/fsi/cfam.c b/hw/fsi/cfam.c
>>> new file mode 100644
>>> index 0000000000..19256050bd
>>> --- /dev/null
>>> +++ b/hw/fsi/cfam.c
>>> @@ -0,0 +1,235 @@
>>> +/*
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + * Copyright (C) 2023 IBM Corp.
>>> + *
>>> + * IBM Common FRU Access Macro
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +
>>> +#include "qapi/error.h"
>>> +#include "qemu/log.h"
>>> +
>>> +#include "hw/fsi/bits.h"
>>> +#include "hw/fsi/cfam.h"
>>> +#include "hw/fsi/engine-scratchpad.h"
>>> +
>>> +#include "hw/qdev-properties.h"
>>> +
>>> +#define TO_REG(x)                          ((x) >> 2)
>>> +
>>> +#define CFAM_ENGINE_CONFIG                  TO_REG(0x04)
>>> +
>>> +#define CFAM_CONFIG_CHIP_ID                TO_REG(0x00)
>>> +#define CFAM_CONFIG_CHIP_ID_P9             0xc0022d15
>>> +#define   CFAM_CONFIG_CHIP_ID_BREAK        0xc0de0000
>>> +
>>> +static uint64_t cfam_config_read(void *opaque, hwaddr addr, unsigned size)
>>> +{
>>> +    CFAMConfig *config;
>>> +    CFAMState *cfam;
>>> +    LBusNode *node;
>>> +    int i;
>>> +
>>> +    config = CFAM_CONFIG(opaque);
>>> +    cfam = container_of(config, CFAMState, config);
>>> +
>>> +    qemu_log_mask(LOG_UNIMP, "%s: read @0x%" HWADDR_PRIx " size=%d\n",
>>> +                  __func__, addr, size);
>>> +
>>> +    assert(size == 4);
>>> +    assert(!(addr & 3));
>>> +
>>> +    switch (addr) {
>>> +    case 0x00:
>>> +        return CFAM_CONFIG_CHIP_ID_P9;
>>> +    case 0x04:
>>> +        return ENGINE_CONFIG_NEXT
>>> +            | 0x00010000                    /* slots */
>>> +            | 0x00001000                    /* version */
>>> +            | ENGINE_CONFIG_TYPE_PEEK   /* type */
>>> +            | 0x0000000c;                   /* crc */
>>> +    case 0x08:
>>> +        return ENGINE_CONFIG_NEXT
>>> +            | 0x00010000                    /* slots */
>>> +            | 0x00005000                    /* version */
>>> +            | ENGINE_CONFIG_TYPE_FSI    /* type */
>>> +            | 0x0000000a;                   /* crc */
>>> +        break;
>>> +    default:
>>> +        /* FIXME: Improve this */
>>> +        i = 0xc;
>>> +        QLIST_FOREACH(node, &cfam->lbus.devices, next) {
>>> +            if (i == addr) {
>>> +                return LBUS_DEVICE_GET_CLASS(node->ldev)->config;
>>> +            }
>>> +            i += size;
>>> +        }
>>> +
>>> +        if (i == addr) {
>>> +            return 0;
>>> +        }
>>> +
>>> +        return 0xc0de0000;
>>
>> Can you explain the magic number at least with a comment?
> Added comment for the magic number 0xc0de0000
>>
>> Maybe it would also make sense to add a qemu_log_mask(LOG_GUEST_ERROR, ...) or qemu_log_mask(LOG_UNIMP, ...) statement here?
> There is LOG_UNIMP most of the function. I added it in the reset function.

I took a quick look at the series and I think that all the
qemu_log_mask(LOG_UNIMP, ..) as the one above should be replaced
by trace events instead.

Thanks,

C.


>>
>>  Thomas
>>
> 
> Thank you for the review.
> 
> Ninad
> 


