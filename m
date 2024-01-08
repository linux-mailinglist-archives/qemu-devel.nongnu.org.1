Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76985827AE2
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 23:50:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMyRd-0000Wp-Cy; Mon, 08 Jan 2024 17:50:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rMyRa-0000W6-OI; Mon, 08 Jan 2024 17:50:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rMyRY-0000op-E6; Mon, 08 Jan 2024 17:50:06 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 408LZhFq028108; Mon, 8 Jan 2024 22:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=k7aE0cnTaUgabLuuTRS2mAtwa3Fe+rVt5Fwr/aWzuLg=;
 b=FKr+6FRVvkYCQcLvGNJioSvpE8NxZEBZm9LGPwZpfGjspCJHDAqFn7bxzKocSY0TUfzz
 x34MePnd8KrAcYTQYKCVYQgh+yJ0u6zuTrsjy/dhWtMqx9Ka2IipqBhWJDvEdnbx0dWO
 shnU2bVdAs4uXjSN/M4gnJPYEL5/CUw1QSg9CdmlwZr4fCNidjgY8pkcbSkDJqDQg4gO
 FFkmHv4pCXcMI2jduPy1oRwdDsA73qG+CZ4NczPISmwxDJml1WeRhYUQfHDkw4ruB13G
 uD45Iiez4WzBkz7TlUks//VcvkzDmDr9XkbvVKSfku/umG6Ce8D/KSBv3wcEJmhPULiw Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vgnfj711a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jan 2024 22:49:45 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 408MNDFL009063;
 Mon, 8 Jan 2024 22:49:45 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vgnfj7111-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jan 2024 22:49:45 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 408M7bZs027254; Mon, 8 Jan 2024 22:49:44 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkw1tma8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jan 2024 22:49:44 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 408MnhU329033036
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jan 2024 22:49:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CD5058055;
 Mon,  8 Jan 2024 22:49:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF8845804B;
 Mon,  8 Jan 2024 22:49:42 +0000 (GMT)
Received: from [9.61.145.235] (unknown [9.61.145.235])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jan 2024 22:49:42 +0000 (GMT)
Message-ID: <3d9b40fa-c5d2-4243-9895-be892e992848@linux.ibm.com>
Date: Mon, 8 Jan 2024 16:49:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/10] hw/fsi: IBM's On-chip Peripheral Bus
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231128235700.599584-1-ninad@linux.ibm.com>
 <20231128235700.599584-5-ninad@linux.ibm.com>
 <d8b3b1c4-42df-4390-9b81-0a426fa43b77@kaod.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <d8b3b1c4-42df-4390-9b81-0a426fa43b77@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bMjxJcuA9BwPi6RmbJG8M4_W6b0xcSXX
X-Proofpoint-GUID: nG7pKeYYYqTBt3atMBy1PmvXi7so0ryw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_10,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=760 priorityscore=1501 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401080185
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hello Cedric,


On 12/12/23 08:48, Cédric Le Goater wrote:
> On 11/29/23 00:56, Ninad Palsule wrote:
>> This is a part of patchset where IBM's Flexible Service Interface is
>> introduced.
>>
>> The On-Chip Peripheral Bus (OPB): A low-speed bus typically found in
>> POWER processors. This now makes an appearance in the ASPEED SoC due
>> to tight integration of the FSI master IP with the OPB, mainly the
>> existence of an MMIO-mapping of the CFAM address straight onto a
>> sub-region of the OPB address space.
>>
>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> [ clg: - removed FSIMasterState object and fsi_opb_realize()
>>         - simplified OPBus ]
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   include/hw/fsi/opb.h | 25 +++++++++++++++++++++++++
>>   hw/fsi/opb.c         | 36 ++++++++++++++++++++++++++++++++++++
>>   hw/fsi/Kconfig       |  4 ++++
>>   hw/fsi/meson.build   |  1 +
>>   4 files changed, 66 insertions(+)
>>   create mode 100644 include/hw/fsi/opb.h
>>   create mode 100644 hw/fsi/opb.c
>>
>> diff --git a/include/hw/fsi/opb.h b/include/hw/fsi/opb.h
>> new file mode 100644
>> index 0000000000..c112206f9e
>> --- /dev/null
>> +++ b/include/hw/fsi/opb.h
>> @@ -0,0 +1,25 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (C) 2023 IBM Corp.
>> + *
>> + * IBM On-Chip Peripheral Bus
>> + */
>> +#ifndef FSI_OPB_H
>> +#define FSI_OPB_H
>> +
>> +#include "exec/memory.h"
>> +#include "hw/fsi/fsi-master.h"
>> +
>> +#define TYPE_OP_BUS "opb"
>> +OBJECT_DECLARE_SIMPLE_TYPE(OPBus, OP_BUS)
>> +
>> +typedef struct OPBus {
>> +        /*< private >*/
>> +        BusState bus;
>> +
>> +        /*< public >*/
>> +        MemoryRegion mr;
>> +        AddressSpace as;
>> +} OPBus;
>> +
>> +#endif /* FSI_OPB_H */
>> diff --git a/hw/fsi/opb.c b/hw/fsi/opb.c
>> new file mode 100644
>> index 0000000000..6474754890
>> --- /dev/null
>> +++ b/hw/fsi/opb.c
>> @@ -0,0 +1,36 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (C) 2023 IBM Corp.
>> + *
>> + * IBM On-chip Peripheral Bus
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +
>> +#include "qapi/error.h"
>> +#include "qemu/log.h"
>> +
>> +#include "hw/fsi/opb.h"
>> +
>> +static void fsi_opb_init(Object *o)
>> +{
>> +    OPBus *opb = OP_BUS(o);
>> +
>> +    memory_region_init_io(&opb->mr, OBJECT(opb), NULL, opb,
>> +                          NULL, UINT32_MAX);
>
> Let's give the region some name.
Added "fsi.opb" name.


Thanks for the review.

Regards,

Ninad


