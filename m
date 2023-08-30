Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 848F778D21B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 04:37:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbB47-00071Q-5r; Tue, 29 Aug 2023 22:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qbB44-00071B-Om; Tue, 29 Aug 2023 22:36:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qbB42-000426-AT; Tue, 29 Aug 2023 22:36:16 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37U1wbuU028657; Wed, 30 Aug 2023 02:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=L+gHQM/PuEScJklaepL9Uidzc5bZ/fNhFlEGXtE7WZM=;
 b=dqVRfKVoBMm2jkbo6GabhvzKYX3jHUfb9U/D2gwX/zzPMFqJA+LF0QAs/4yloopzuPpv
 8svzVlGsy5STl3ZZFzmyiqgwJdzu0mq4hW6SnhK+2x9bjP2BsNWJIHwd2QjXUfjg/WJ7
 0/9JFqHZa6oDnt2xbexJ4DxNZfuJmxBrmokZ+n+cqTVD5YqH7bPQs16t78Tltakad5at
 by+KZMA8q0WMnObdGhdO8nGsIccaT5OH0p75/TS4gitm/eEbNfuXOSCvYvpKCcQ8GI9q
 /aEMH0rTJUyiWhuI8jPu9KTOTi5mQyj3MzsWOxqiQDXoBkG8nYCb7cRI1jue2yyZC3PS Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssukaja2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Aug 2023 02:36:06 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37U2P4B7030432;
 Wed, 30 Aug 2023 02:36:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssukaja22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Aug 2023 02:36:05 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37U0O89n014331; Wed, 30 Aug 2023 02:31:04 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqvqn8f65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Aug 2023 02:31:04 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37U2V4V966453912
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Aug 2023 02:31:04 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13C3B5805A;
 Wed, 30 Aug 2023 02:31:04 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEAD158051;
 Wed, 30 Aug 2023 02:31:02 +0000 (GMT)
Received: from [9.61.171.165] (unknown [9.61.171.165])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Aug 2023 02:31:02 +0000 (GMT)
Message-ID: <698b2258-b179-4689-8000-7468b92a0823@linux.ibm.com>
Date: Tue, 29 Aug 2023 21:31:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/7] hw/fsi: Introduce IBM's cfam,fsi-slave
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@aj.id.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 philmd@linaro.org
Cc: qemu-arm@nongnu.org
References: <20230825203046.3692467-1-ninad@linux.ibm.com>
 <20230825203046.3692467-4-ninad@linux.ibm.com>
 <e2a8e6eb-b9fd-8011-32c0-e5c310bf1135@redhat.com>
 <11681172-0fe9-4e1d-9f8f-03f57b0b09a2@linux.ibm.com>
 <f6edea23-f11c-2119-ebaf-222d9f0813b6@kaod.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <f6edea23-f11c-2119-ebaf-222d9f0813b6@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gGTDsx8jJDqVBZzW7TbfMm-uFS9pQdDp
X-Proofpoint-ORIG-GUID: ksdMLa8E1eIuZi3RdpbstoRwTYsvCibc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300021
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hello Cedric,

On 8/29/23 08:43, Cédric Le Goater wrote:
> On 8/29/23 15:39, Ninad Palsule wrote:
>> Hello Thomas,
>>
>> On 8/28/23 21:03, Thomas Huth wrote:
>>> On 25/08/2023 22.30, Ninad Palsule wrote:
>>>> This is a part of patchset where IBM's Flexible Service Interface is
>>>> introduced.
>>>>
>>>> The Common FRU Access Macro (CFAM), an address space containing
>>>> various "engines" that drive accesses on busses internal and external
>>>> to the POWER chip. Examples include the SBEFIFO and I2C masters. The
>>>> engines hang off of an internal Local Bus (LBUS) which is described
>>>> by the CFAM configuration block.
>>>>
>>>> The FSI slave: The slave is the terminal point of the FSI bus for
>>>> FSI symbols addressed to it. Slaves can be cascaded off of one
>>>> another. The slave's configuration registers appear in address space
>>>> of the CFAM to which it is attached.
>>>>
>>>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>>>> ---
>>> ...
>>>> diff --git a/hw/fsi/cfam.c b/hw/fsi/cfam.c
>>>> new file mode 100644
>>>> index 0000000000..19256050bd
>>>> --- /dev/null
>>>> +++ b/hw/fsi/cfam.c
>>>> @@ -0,0 +1,235 @@
>>>> +/*
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + * Copyright (C) 2023 IBM Corp.
>>>> + *
>>>> + * IBM Common FRU Access Macro
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +
>>>> +#include "qapi/error.h"
>>>> +#include "qemu/log.h"
>>>> +
>>>> +#include "hw/fsi/bits.h"
>>>> +#include "hw/fsi/cfam.h"
>>>> +#include "hw/fsi/engine-scratchpad.h"
>>>> +
>>>> +#include "hw/qdev-properties.h"
>>>> +
>>>> +#define TO_REG(x)                          ((x) >> 2)
>>>> +
>>>> +#define CFAM_ENGINE_CONFIG                  TO_REG(0x04)
>>>> +
>>>> +#define CFAM_CONFIG_CHIP_ID                TO_REG(0x00)
>>>> +#define CFAM_CONFIG_CHIP_ID_P9             0xc0022d15
>>>> +#define   CFAM_CONFIG_CHIP_ID_BREAK        0xc0de0000
>>>> +
>>>> +static uint64_t cfam_config_read(void *opaque, hwaddr addr, 
>>>> unsigned size)
>>>> +{
>>>> +    CFAMConfig *config;
>>>> +    CFAMState *cfam;
>>>> +    LBusNode *node;
>>>> +    int i;
>>>> +
>>>> +    config = CFAM_CONFIG(opaque);
>>>> +    cfam = container_of(config, CFAMState, config);
>>>> +
>>>> +    qemu_log_mask(LOG_UNIMP, "%s: read @0x%" HWADDR_PRIx " 
>>>> size=%d\n",
>>>> +                  __func__, addr, size);
>>>> +
>>>> +    assert(size == 4);
>>>> +    assert(!(addr & 3));
>>>> +
>>>> +    switch (addr) {
>>>> +    case 0x00:
>>>> +        return CFAM_CONFIG_CHIP_ID_P9;
>>>> +    case 0x04:
>>>> +        return ENGINE_CONFIG_NEXT
>>>> +            | 0x00010000                    /* slots */
>>>> +            | 0x00001000                    /* version */
>>>> +            | ENGINE_CONFIG_TYPE_PEEK   /* type */
>>>> +            | 0x0000000c;                   /* crc */
>>>> +    case 0x08:
>>>> +        return ENGINE_CONFIG_NEXT
>>>> +            | 0x00010000                    /* slots */
>>>> +            | 0x00005000                    /* version */
>>>> +            | ENGINE_CONFIG_TYPE_FSI    /* type */
>>>> +            | 0x0000000a;                   /* crc */
>>>> +        break;
>>>> +    default:
>>>> +        /* FIXME: Improve this */
>>>> +        i = 0xc;
>>>> +        QLIST_FOREACH(node, &cfam->lbus.devices, next) {
>>>> +            if (i == addr) {
>>>> +                return LBUS_DEVICE_GET_CLASS(node->ldev)->config;
>>>> +            }
>>>> +            i += size;
>>>> +        }
>>>> +
>>>> +        if (i == addr) {
>>>> +            return 0;
>>>> +        }
>>>> +
>>>> +        return 0xc0de0000;
>>>
>>> Can you explain the magic number at least with a comment?
>> Added comment for the magic number 0xc0de0000
>>>
>>> Maybe it would also make sense to add a 
>>> qemu_log_mask(LOG_GUEST_ERROR, ...) or qemu_log_mask(LOG_UNIMP, ...) 
>>> statement here?
>> There is LOG_UNIMP most of the function. I added it in the reset 
>> function.
>
> I took a quick look at the series and I think that all the
> qemu_log_mask(LOG_UNIMP, ..) as the one above should be replaced
> by trace events instead.

I have converted 4 logs into trace.

Thank you for the review.

~Ninad

>
> Thanks,
>
> C.
>
>
>>>
>>>  Thomas
>>>
>>
>> Thank you for the review.
>>
>> Ninad
>>
>

