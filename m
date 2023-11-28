Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF357FC9DE
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 23:48:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r86rd-0002ec-Gk; Tue, 28 Nov 2023 17:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1r86rV-0002dr-Fp; Tue, 28 Nov 2023 17:47:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1r86rL-0008CU-UG; Tue, 28 Nov 2023 17:47:25 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ASMh3hc017714; Tue, 28 Nov 2023 22:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xyxIlmZCueWaEERHulgwNJ/HBbf5Uhlz0Y4MpXPzTGA=;
 b=c1giCotbMyRdqjv8pavXLQ11MnrREdxdcAce/2A5VCC7uMJEiJg+wNx/l6+P7XbZMnyX
 yK3PgbRtNjJclT3NwPxPwd3PZQ5Gz7fpR2ad4iVHUWVLYqKvg1CALwN2AHwzmSqly7mI
 1DklHBH/UR3S2KExfBCQZdGW1QR6H0AAPElzmxVpJH4RLHTLMCrYLJ2vM3+seCyL5ZLq
 h1VAaXWI4RQk3guS0PIWJPjCp5a7t3I8OoPzEOHZitNe11HNA1rQ8GFOtN/72+cUmi52
 RflwRKz/Mc+oxFpVgPIa30UZ9OvVrNfostiAswvkhWCpYJy+CFbwxQoqvJyS9/56etLR 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uns8b86s1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Nov 2023 22:46:57 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASMhCEa017960;
 Tue, 28 Nov 2023 22:46:57 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uns8b86rg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Nov 2023 22:46:57 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ASJrwsG012197; Tue, 28 Nov 2023 22:46:56 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrkk7fb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Nov 2023 22:46:56 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ASMktOH10682952
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Nov 2023 22:46:55 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AC4B58059;
 Tue, 28 Nov 2023 22:46:55 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09D085804B;
 Tue, 28 Nov 2023 22:46:53 +0000 (GMT)
Received: from [9.67.87.213] (unknown [9.67.87.213])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Nov 2023 22:46:52 +0000 (GMT)
Message-ID: <2461d221-c69e-4271-a8a9-46f5a813b211@linux.ibm.com>
Date: Tue, 28 Nov 2023 16:46:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/10] hw/fsi: IBM's On-chip Peripheral Bus
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231026164741.1184058-1-ninad@linux.ibm.com>
 <20231026164741.1184058-6-ninad@linux.ibm.com>
 <6f8aede9-26ac-4921-8803-8eb1a74a48c0@kaod.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <6f8aede9-26ac-4921-8803-8eb1a74a48c0@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rvoQozty0WYAK1fiJf-aOV7RKzDCDV4Q
X-Proofpoint-GUID: YeHAGG050NEhrr7lGaV5Ajh22RG3pMTx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_24,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 clxscore=1015 suspectscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280179
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

On 11/27/23 10:23, Cédric Le Goater wrote:
> On 10/26/23 18:47, Ninad Palsule wrote:
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
>> ---
>> v2:
>> - Incorporated review comment by Joel.
>> v5:
>> - Incorporated review comments by Cedric.
>> v6:
>> - Incorporated review comments by Cedric & Daniel
>> v7:
>> - Incorporated review comments by Cedric.
>> ---
>>   include/hw/fsi/opb.h | 33 ++++++++++++++++++++
>>   hw/fsi/fsi-master.c  |  3 +-
>>   hw/fsi/opb.c         | 74 ++++++++++++++++++++++++++++++++++++++++++++
>>   hw/fsi/Kconfig       |  4 +++
>>   hw/fsi/meson.build   |  1 +
>>   5 files changed, 113 insertions(+), 2 deletions(-)
>>   create mode 100644 include/hw/fsi/opb.h
>>   create mode 100644 hw/fsi/opb.c
>>
>> diff --git a/include/hw/fsi/opb.h b/include/hw/fsi/opb.h
>> new file mode 100644
>> index 0000000000..8b71bb55c2
>> --- /dev/null
>> +++ b/include/hw/fsi/opb.h
>> @@ -0,0 +1,33 @@
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
>> +
>> +        /* Model OPB as dumb enough just to provide an address-space */
>> +        /* TODO: Maybe don't store device state in the bus? */
>> +        FSIMasterState fsi;
>
> Please remove. FSIMasterState should be introduced later.
ok, Thanks for the change. Looks like you moved it from OPBus to 
AspeedAPB2OPBState. I am fine with the change if it is making model cleaner.
>
>> +} OPBus;
>> +
>> +typedef struct OPBusClass {
>> +        BusClass parent_class;
>> +} OPBusClass;
>> +
>> +#endif /* FSI_OPB_H */
>> diff --git a/hw/fsi/fsi-master.c b/hw/fsi/fsi-master.c
>> index bb7a893003..ec092b42ea 100644
>> --- a/hw/fsi/fsi-master.c
>> +++ b/hw/fsi/fsi-master.c
>> @@ -11,8 +11,7 @@
>>   #include "trace.h"
>>     #include "hw/fsi/fsi-master.h"
>> -
>> -#define TYPE_OP_BUS "opb"
>> +#include "hw/fsi/opb.h"
>
> ouch.
>
> This is an ugly hack because the modeling is broken. OPB should be 
> introduced
> before tFSIMasterState.
OK, Thanks for the change.
>
>
>>   #define TO_REG(x)                               ((x) >> 2)
>>   diff --git a/hw/fsi/opb.c b/hw/fsi/opb.c
>> new file mode 100644
>> index 0000000000..04771b4b27
>> --- /dev/null
>> +++ b/hw/fsi/opb.c
>> @@ -0,0 +1,74 @@
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
>> +static void fsi_opb_realize(BusState *bus, Error **errp)
>> +{
>> +    OPBus *opb = OP_BUS(bus);
>> +
>> +    memory_region_init_io(&opb->mr, OBJECT(opb), NULL, opb,
>> +                          NULL, UINT32_MAX);
>> +    address_space_init(&opb->as, &opb->mr, "opb");
>
> Please keep the above and put it in a instance_init handler and remove
> the rest. It should go under AspeedAPB2OPBState.
OK, Thanks for the change.
>
>> +
>> +    if (!object_property_set_bool(OBJECT(&opb->fsi), "realized", 
>> true, errp)) {
>> +        return;
>> +    }
>> +
>> +    memory_region_add_subregion(&opb->mr, 0x80000000, &opb->fsi.iomem);
>> +
>> +    /* OPB2FSI region */
>> +    /*
>> +     * Avoid endianness issues by mapping each slave's memory region 
>> directly.
>> +     * Manually bridging multiple address-spaces causes endian swapping
>> +     * headaches as memory_region_dispatch_read() and
>> +     * memory_region_dispatch_write() correct the endianness based 
>> on the
>> +     * target machine endianness and not relative to the device 
>> endianness on
>> +     * either side of the bridge.
>> +     */
>> +    /*
>> +     * XXX: This is a bit hairy and will need to be fixed when I 
>> sort out the
>> +     * bus/slave relationship and any changes to the CFAM modelling 
>> (multiple
>> +     * slaves, LBUS)
>> +     */
>> +    memory_region_add_subregion(&opb->mr, 0xa0000000, 
>> &opb->fsi.opb2fsi);
>> +}
>> +
>> +static void fsi_opb_init(Object *o)
>> +{
>> +    OPBus *opb = OP_BUS(o);
>> +
>> +    object_initialize_child(o, "fsi-master", &opb->fsi, 
>> TYPE_FSI_MASTER);
>> +    qdev_set_parent_bus(DEVICE(&opb->fsi), BUS(o), &error_abort);
>> +}
>
> Drop all of the above.

OK, Thanks for the review and change.

Regards,

Ninad

>
>
> Thanks,
>
> C.
>
>
>
>> +
>> +static void fsi_opb_class_init(ObjectClass *klass, void *data)
>> +{
>> +    BusClass *bc = BUS_CLASS(klass);
>> +    bc->realize = fsi_opb_realize;
>> +}
>> +
>> +static const TypeInfo opb_info = {
>> +    .name = TYPE_OP_BUS,
>> +    .parent = TYPE_BUS,
>> +    .instance_init = fsi_opb_init,
>> +    .instance_size = sizeof(OPBus),
>> +    .class_init = fsi_opb_class_init,
>> +    .class_size = sizeof(OPBusClass),
>> +};
>> +
>> +static void fsi_opb_register_types(void)
>> +{
>> +    type_register_static(&opb_info);
>> +}
>> +
>> +type_init(fsi_opb_register_types);
>> diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
>> index 8d712e77ed..0f6e6d331a 100644
>> --- a/hw/fsi/Kconfig
>> +++ b/hw/fsi/Kconfig
>> @@ -1,3 +1,7 @@
>> +config FSI_OPB
>> +    bool
>> +    select FSI_CFAM
>> +
>>   config FSI_CFAM
>>       bool
>>       select FSI
>> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
>> index f617943b4a..407b8c2775 100644
>> --- a/hw/fsi/meson.build
>> +++ b/hw/fsi/meson.build
>> @@ -2,3 +2,4 @@ system_ss.add(when: 'CONFIG_FSI_LBUS', if_true: 
>> files('lbus.c'))
>>   system_ss.add(when: 'CONFIG_FSI_SCRATCHPAD', if_true: 
>> files('engine-scratchpad.c'))
>>   system_ss.add(when: 'CONFIG_FSI_CFAM', if_true: files('cfam.c'))
>>   system_ss.add(when: 'CONFIG_FSI', if_true: 
>> files('fsi.c','fsi-master.c','fsi-slave.c'))
>> +system_ss.add(when: 'CONFIG_FSI_OPB', if_true: files('opb.c'))
>

