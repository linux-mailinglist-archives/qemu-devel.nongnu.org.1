Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B6C7D85F6
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 17:25:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw2Er-0000rm-C7; Thu, 26 Oct 2023 11:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qw2Eb-0000oy-Sc; Thu, 26 Oct 2023 11:25:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qw2EZ-0000zv-Ld; Thu, 26 Oct 2023 11:25:21 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QFORh2013594; Thu, 26 Oct 2023 15:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bgYmqJoFleQS4H1PbfPvZE79DpdZ7LIeAIRGaddso24=;
 b=CGzkXq+y8bK6GAAf3i1TjtGRx7XSiFmzwDPcAi4PdxwUwWEK4CltP5mgitNHu1D0j8xk
 onfJUuMMWOjhwd2i5BBnnm6fEpOBc5n1eteSaj791/iuObFlgFIO370pWD5aN6OKyPRW
 iH5HTb3xHYaOq4wB8kGcBnVKNVIKPxGs+rmKXNfmLeW/1Z1t1rrJD9ekG84mNLaW4Z6a
 rT/4iMophjpqNUu/oH7/dvPaCuiv1UGfmWxB3HLLShibko6XU72YlzlauK4x2lNlGU/8
 w2d6bgsmIx9ZhYNeqgl7/NiyW7u6rIw9oRrGOC2Sh0YgH3inw0zJ8GxNz7arV5kyMyRJ 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tyth3rdp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 15:24:58 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39QFOXFJ014265;
 Thu, 26 Oct 2023 15:24:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tyth3rdnq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 15:24:57 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QE4Rah010218; Thu, 26 Oct 2023 15:24:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsbyy6hg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 15:24:57 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39QFOu2h37618116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 15:24:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A90658053;
 Thu, 26 Oct 2023 15:24:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3232D58043;
 Thu, 26 Oct 2023 15:24:55 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Oct 2023 15:24:55 +0000 (GMT)
Message-ID: <14bca721-8cc0-428a-9898-038b07323571@linux.ibm.com>
Date: Thu, 26 Oct 2023 10:24:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/10] hw/fsi: Introduce IBM's scratchpad
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231021211720.3571082-1-ninad@linux.ibm.com>
 <20231021211720.3571082-3-ninad@linux.ibm.com>
 <957bc5db-53aa-6946-edf3-3b728a52b660@linaro.org>
 <f2a50afd-3fa1-47d2-960e-0aaaf57c7cd2@linux.ibm.com>
 <4b2e68dd-db49-4041-ee5a-ae2b836bd255@linaro.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <4b2e68dd-db49-4041-ee5a-ae2b836bd255@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VRDoNUX0ltXdaisX8JliAu-aYsBzZNHw
X-Proofpoint-ORIG-GUID: qaOyQk5-T34quNQQXWy0oLndDtnBm4r-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_13,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=740 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260133
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


On 10/24/23 02:08, Philippe Mathieu-Daudé wrote:
> On 23/10/23 19:08, Ninad Palsule wrote:
>> Hello Philippe,
>>
>> On 10/23/23 10:00, Philippe Mathieu-Daudé wrote:
>>> On 21/10/23 23:17, Ninad Palsule wrote:
>>>> This is a part of patchset where scratchpad is introduced.
>>>>
>>>> The scratchpad provides a set of non-functional registers. The 
>>>> firmware
>>>> is free to use them, hardware does not support any special management
>>>> support. The scratchpad registers can be read or written from LBUS
>>>> slave.
>>>>
>>>> In this model, The LBUS device is parent for the scratchpad.
>>>>
>>>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>>>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>>>> ---
>>>> v2:
>>>> - Incorporated Joel's review comments.
>>>> v5:
>>>> - Incorporated review comments by Cedric.
>>>> v6:
>>>> - Incorporated review comments by Daniel.
>>>> ---
>>>>   meson.build                        |  1 +
>>>>   hw/fsi/trace.h                     |  1 +
>>>>   include/hw/fsi/engine-scratchpad.h | 32 ++++++++++
>>>>   include/hw/fsi/fsi.h               | 16 +++++
>>>>   hw/fsi/engine-scratchpad.c         | 93 
>>>> ++++++++++++++++++++++++++++++
>>>>   hw/fsi/Kconfig                     |  4 ++
>>>>   hw/fsi/meson.build                 |  1 +
>>>>   hw/fsi/trace-events                |  2 +
>>>>   8 files changed, 150 insertions(+)
>>>>   create mode 100644 hw/fsi/trace.h
>>>>   create mode 100644 include/hw/fsi/engine-scratchpad.h
>>>>   create mode 100644 include/hw/fsi/fsi.h
>>>>   create mode 100644 hw/fsi/engine-scratchpad.c
>>>>   create mode 100644 hw/fsi/trace-events
>>>
>>>
>>>> diff --git a/include/hw/fsi/fsi.h b/include/hw/fsi/fsi.h
>>>> new file mode 100644
>>>> index 0000000000..e65f26f17b
>>>> --- /dev/null
>>>> +++ b/include/hw/fsi/fsi.h
>>>> @@ -0,0 +1,16 @@
>>>> +/*
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + * Copyright (C) 2023 IBM Corp.
>>>> + *
>>>> + * IBM Flexible Service Interface
>>>> + */
>>>> +#ifndef FSI_FSI_H
>>>> +#define FSI_FSI_H
>>>> +
>>>> +/* Bitwise operations at the word level. */
>>>> +#define BE_BIT(x)                          BIT(31 - (x))
>>>> +#define GENMASK(t, b) \
>>>> +    (((1ULL << ((t) + 1)) - 1) & ~((1ULL << (b)) - 1))
>>>
>>> Please use MAKE_64BIT_MASK() from "qemu/bitops.h".
>>
>> The GENMASK and MAKE_64BIT_MASK macros are invoke differently.
>>
>> GENMASK is invoked with bit t and bit b (t:b) and it provides the 
>> mask and
>>
>> MAKE_64BIT_MASK uses shift and length.
>
> Don't we have:
>
> #define GENMASK(t, b) MAKE_64BIT_MASK(t, b - t + 1)
>
> ?

You are right. I am able to use this macro. I have removed some unused 
macros.

Thanks for the review.

Regards,

Ninad

>
>> Thanks for the review.
>>
>> Regards,
>>
>> Ninad
>>
>>
>>>> +#define BE_GENMASK(t, b)                   GENMASK(BE_BIT(t), 
>>>> BE_BIT(b))
>>>> +
>>>> +#endif
>>>
>

