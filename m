Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC147FC99B
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 23:37:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r86gW-0007Ur-EN; Tue, 28 Nov 2023 17:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1r86gO-0007UC-DT; Tue, 28 Nov 2023 17:35:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1r86gI-000614-Ne; Tue, 28 Nov 2023 17:35:56 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ASMLMJS002957; Tue, 28 Nov 2023 22:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Vvy4hH4XDigywuL/shzgDAKAuGcH3LakOEQhMLiePm4=;
 b=cT+9dTje0rnJPC/4Z8wCQg7GNB7WwsznshaZn6u5G46jxxWEHkXhHDboXhFNfjpXDz9I
 xRwqa+z/XDwVkvp5KUYp8++lFtvLgCl+ldG3uXlU4wCIa4uFgEXbgb3pMEE44JjUwWqw
 dI5UiVlgm0rg0KjKsDdi/qRZgheED2WUo16cqXveRm8cnmILwncED16Ks3FcE7P5SaUD
 JRy1szMInCdIWxYKJHpLiojgDvm1wpGZSgF19EIpE2Vy51C83jdhRajJW3nPGO0uuCil
 Ukv4WrVVNrpVXpwjn8GofuDCaoYKLQUVARaZfUQmr8yc9AZofQ/tvjhf8Y5hCeDRtKBr Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unrgf8xk3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Nov 2023 22:35:32 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASMMaL5006177;
 Tue, 28 Nov 2023 22:35:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unrgf8xjj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Nov 2023 22:35:31 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ASK54NI012231; Tue, 28 Nov 2023 22:35:30 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrkk5nk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Nov 2023 22:35:30 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ASMZTMO19268116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Nov 2023 22:35:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C7DE58055;
 Tue, 28 Nov 2023 22:35:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD92258063;
 Tue, 28 Nov 2023 22:35:25 +0000 (GMT)
Received: from [9.67.87.213] (unknown [9.67.87.213])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Nov 2023 22:35:25 +0000 (GMT)
Message-ID: <2ca57b61-2a62-45d5-a03e-9eff9036fb22@linux.ibm.com>
Date: Tue, 28 Nov 2023 16:35:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/10] hw/fsi: Introduce IBM's cfam,fsi-slave
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231026164741.1184058-1-ninad@linux.ibm.com>
 <20231026164741.1184058-4-ninad@linux.ibm.com>
 <136a5432-281a-4501-93b8-cfac3c62f736@kaod.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <136a5432-281a-4501-93b8-cfac3c62f736@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 32TVTywkf5a94lc-Ssq8sq6nmv4i0gVA
X-Proofpoint-ORIG-GUID: 3dEklxw2Rm-WRngXcbUt4FFPPdJybDOg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_24,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280177
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ninad@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 11/27/23 10:16, Cédric Le Goater wrote:
> On 10/26/23 18:47, Ninad Palsule wrote:
>> This is a part of patchset where IBM's Flexible Service Interface is
>> introduced.
>>
>> The Common FRU Access Macro (CFAM), an address space containing
>> various "engines" that drive accesses on busses internal and external
>> to the POWER chip. Examples include the SBEFIFO and I2C masters. The
>> engines hang off of an internal Local Bus (LBUS) which is described
>> by the CFAM configuration block.
>>
>> The FSI slave: The slave is the terminal point of the FSI bus for
>> FSI symbols addressed to it. Slaves can be cascaded off of one
>> another. The slave's configuration registers appear in address space
>> of the CFAM to which it is attached.
>>
>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>> v2:
>> - Incorporated Joel's review comments.
>> v3:
>> - Incorporated Thomas Huth's review comments.
>> v5:
>> - Incorporated review comments by Cedric.
>> v6:
>> - Incorporated review comments by Cedric & Daniel
>> ---
>>   include/hw/fsi/cfam.h      |  34 ++++++++
>>   include/hw/fsi/fsi-slave.h |  29 +++++++
>>   include/hw/fsi/fsi.h       |  20 +++++
>>   hw/fsi/cfam.c              | 173 +++++++++++++++++++++++++++++++++++++
>>   hw/fsi/fsi-slave.c         |  78 +++++++++++++++++
>>   hw/fsi/Kconfig             |   9 ++
>>   hw/fsi/meson.build         |   2 +
>>   hw/fsi/trace-events        |   7 ++
>>   8 files changed, 352 insertions(+)
>>   create mode 100644 include/hw/fsi/cfam.h
>>   create mode 100644 include/hw/fsi/fsi-slave.h
>>   create mode 100644 hw/fsi/cfam.c
>>   create mode 100644 hw/fsi/fsi-slave.c
>>
>> diff --git a/include/hw/fsi/cfam.h b/include/hw/fsi/cfam.h
>> new file mode 100644
>> index 0000000000..842a3bad0c
>> --- /dev/null
>> +++ b/include/hw/fsi/cfam.h
>> @@ -0,0 +1,34 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (C) 2023 IBM Corp.
>> + *
>> + * IBM Common FRU Access Macro
>> + */
>> +#ifndef FSI_CFAM_H
>> +#define FSI_CFAM_H
>> +
>> +#include "exec/memory.h"
>> +
>> +#include "hw/fsi/fsi-slave.h"
>> +#include "hw/fsi/lbus.h"
>
>
> Please include here the FSIScratchPad definitions. There is no need
> for an extra file since the object is only used under FSICFAMState.
Make sense. Thanks for the change.
>
>
>> +
>> +#define TYPE_FSI_CFAM "cfam"
>> +#define FSI_CFAM(obj) OBJECT_CHECK(FSICFAMState, (obj), TYPE_FSI_CFAM)
>> +
>> +/* P9-ism */
>> +#define CFAM_CONFIG_NR_REGS 0x28
>> +
>> +typedef struct FSICFAMState {
>> +    /* < private > */
>> +    FSISlaveState parent;
>> +
>> +    /* CFAM config address space */
>> +    MemoryRegion config_iomem;
>> +
>> +    MemoryRegion mr;
>> +    AddressSpace as;
>> +
>> +    FSILBus lbus;
>
> Please add :
>
>     FSIScratchPad scratchpad;
Scratch pad is device and It is attached to the LBUS but I am fine with 
the change. Thanks.
>
>> +} FSICFAMState;
>> +
>> +#endif /* FSI_CFAM_H */
>> diff --git a/include/hw/fsi/fsi-slave.h b/include/hw/fsi/fsi-slave.h
>> new file mode 100644
>> index 0000000000..f5f23f4457
>> --- /dev/null
>> +++ b/include/hw/fsi/fsi-slave.h
>> @@ -0,0 +1,29 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (C) 2023 IBM Corp.
>> + *
>> + * IBM Flexible Service Interface slave
>> + */
>> +#ifndef FSI_FSI_SLAVE_H
>> +#define FSI_FSI_SLAVE_H
>> +
>> +#include "exec/memory.h"
>> +#include "hw/qdev-core.h"
>> +
>> +#include "hw/fsi/lbus.h"
>> +
>> +#include <stdint.h>
>> +
>> +#define TYPE_FSI_SLAVE "fsi.slave"
>> +OBJECT_DECLARE_SIMPLE_TYPE(FSISlaveState, FSI_SLAVE)
>> +
>> +#define FSI_SLAVE_CONTROL_NR_REGS ((0x40 >> 2) + 1)
>> +
>> +typedef struct FSISlaveState {
>> +    DeviceState parent;
>> +
>> +    MemoryRegion iomem;
>> +    uint32_t regs[FSI_SLAVE_CONTROL_NR_REGS];
>> +} FSISlaveState;
>> +
>> +#endif /* FSI_FSI_H */
>> diff --git a/include/hw/fsi/fsi.h b/include/hw/fsi/fsi.h
>> index b08b97f62b..3cbc685226 100644
>> --- a/include/hw/fsi/fsi.h
>> +++ b/include/hw/fsi/fsi.h
>> @@ -8,9 +8,29 @@
>>   #define FSI_FSI_H
>>     #include "qemu/bitops.h"
>> +#include "hw/qdev-core.h"
>> +
>> +/*
>> + * TODO: Maybe unwind this dependency with const links? Store a
>> + * pointer in FSIBus?
>> + */
>> +#include "hw/fsi/cfam.h"
>>     /* Bitwise operations at the word level. */
>>   #define BE_BIT(x)           BIT(31 - (x))
>>   #define BE_GENMASK(hb, lb)  MAKE_64BIT_MASK((lb), ((hb) - (lb) + 1))
>>   +#define TYPE_FSI_BUS "fsi.bus"
>> +OBJECT_DECLARE_SIMPLE_TYPE(FSIBus, FSI_BUS)
>> +
>> +/* TODO: Figure out what's best with a point-to-point bus */
>> +typedef struct FSISlaveState FSISlaveState;
>> +
>> +typedef struct FSIBus {
>> +    BusState bus;
>> +
>> +    /* XXX: It's point-to-point, just instantiate the slave directly 
>> for now */
>> +    FSICFAMState slave;
>
> Drop the FSICFAMState from FSIBus and introduce FSIBus in the previous
> patch.
Thanks for the change.
>
>> +} FSIBus;
>> +
>>   #endif
>> diff --git a/hw/fsi/cfam.c b/hw/fsi/cfam.c
>> new file mode 100644
>> index 0000000000..a1c037925f
>> --- /dev/null
>> +++ b/hw/fsi/cfam.c
>> @@ -0,0 +1,173 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (C) 2023 IBM Corp.
>> + *
>> + * IBM Common FRU Access Macro
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +
>> +#include "qapi/error.h"
>> +#include "trace.h"
>> +
>> +#include "hw/fsi/cfam.h"
>> +#include "hw/fsi/fsi.h"
>> +#include "hw/fsi/engine-scratchpad.h"
>> +
>> +#include "hw/qdev-properties.h"
>> +
>> +#define TO_REG(x)                          ((x) >> 2)
>> +
>> +#define CFAM_ENGINE_CONFIG                  TO_REG(0x04)
>> +
>> +#define CFAM_CONFIG_CHIP_ID                TO_REG(0x00)
>> +#define CFAM_CONFIG_CHIP_ID_P9             0xc0022d15
>> +#define CFAM_CONFIG_CHIP_ID_BREAK          0xc0de0000
>> +
>> +static uint64_t fsi_cfam_config_read(void *opaque, hwaddr addr, 
>> unsigned size)
>> +{
>> +    FSICFAMState *cfam = FSI_CFAM(opaque);
>> +    BusChild *kid;
>> +    int i;
>> +
>> +    trace_fsi_cfam_config_read(addr, size);
>> +
>> +    switch (addr) {
>> +    case 0x00:
>> +        return CFAM_CONFIG_CHIP_ID_P9;
>> +    case 0x04:
>> +        return ENGINE_CONFIG_NEXT       |   /* valid */
>> +               0x00010000               |   /* slots */
>> +               0x00001000               |   /* version */
>> +               ENGINE_CONFIG_TYPE_PEEK  |   /* type */
>> +               0x0000000c;                  /* crc */
>> +    case 0x08:
>> +        return ENGINE_CONFIG_NEXT       |   /* valid */
>> +               0x00010000               |   /* slots */
>> +               0x00005000               |   /* version */
>> +               ENGINE_CONFIG_TYPE_FSI   |   /* type */
>> +               0x0000000a;                  /* crc */
>> +        break;
>> +    default:
>> +        /* The config table contains different engines from 0xc 
>> onwards. */
>> +        i = 0xc;
>> +        QTAILQ_FOREACH(kid, &cfam->lbus.bus.children, sibling) {
>> +            if (i == addr) {
>> +                DeviceState *ds = kid->child;
>> +                FSILBusDevice *dev = FSI_LBUS_DEVICE(ds);
>> +                return FSI_LBUS_DEVICE_GET_CLASS(dev)->config;
>> +            }
>> +            i += size;
>> +        }
>> +
>> +        if (i == addr) {
>> +            return 0;
>> +        }
>> +
>> +        /*
>> +         * As per FSI specification, This is a magic value at 
>> address 0 of
>> +         * given FSI port. This causes FSI master to send BREAK 
>> command for
>> +         * initialization and recovery.
>> +         */
>> +        return CFAM_CONFIG_CHIP_ID_BREAK;
>> +    }
>> +}
>> +
>> +static void fsi_cfam_config_write(void *opaque, hwaddr addr, 
>> uint64_t data,
>> +                                  unsigned size)
>> +{
>> +    FSICFAMState *cfam = FSI_CFAM(opaque);
>> +
>> +    trace_fsi_cfam_config_write(addr, size, data);
>> +
>> +    switch (TO_REG(addr)) {
>> +    case CFAM_CONFIG_CHIP_ID:
>> +    case CFAM_CONFIG_CHIP_ID + 4:
>> +        if (data == CFAM_CONFIG_CHIP_ID_BREAK) {
>> +            bus_cold_reset(BUS(&cfam->lbus));
>> +        }
>> +    break;
>> +    default:
>> +        trace_fsi_cfam_config_write_noaddr(addr, size, data);
>> +    }
>> +}
>> +
>> +static const struct MemoryRegionOps cfam_config_ops = {
>> +    .read = fsi_cfam_config_read,
>> +    .write = fsi_cfam_config_write,
>> +    .valid.max_access_size = 4,
>> +    .valid.min_access_size = 4,
>> +    .impl.max_access_size = 4,
>> +    .impl.min_access_size = 4,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +};
>> +
>> +static uint64_t fsi_cfam_unimplemented_read(void *opaque, hwaddr addr,
>> +                                            unsigned size)
>> +{
>> +    trace_fsi_cfam_unimplemented_read(addr, size);
>> +
>> +    return 0;
>> +}
>> +
>> +static void fsi_cfam_unimplemented_write(void *opaque, hwaddr addr,
>> +                                         uint64_t data, unsigned size)
>> +{
>> +    trace_fsi_cfam_unimplemented_write(addr, size, data);
>> +}
>> +
>> +static const struct MemoryRegionOps fsi_cfam_unimplemented_ops = {
>> +    .read = fsi_cfam_unimplemented_read,
>> +    .write = fsi_cfam_unimplemented_write,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +};
>
> Please introduce a instance_init() handler please to initialize
> the scratchpad object.
ok, Thanks for the change.
>
>
>> +static void fsi_cfam_realize(DeviceState *dev, Error **errp)
>> +{
>> +    FSICFAMState *cfam = FSI_CFAM(dev);
>> +    FSISlaveState *slave = FSI_SLAVE(dev);
>> +
>> +    /* Each slave has a 2MiB address space */
>> +    memory_region_init_io(&cfam->mr, OBJECT(cfam), 
>> &fsi_cfam_unimplemented_ops,
>> +                          cfam, TYPE_FSI_CFAM, 2 * 1024 * 1024);
>> +    address_space_init(&cfam->as, &cfam->mr, TYPE_FSI_CFAM);
>> +
>> +    qbus_init(&cfam->lbus, sizeof(cfam->lbus), TYPE_FSI_LBUS,
>> +                        DEVICE(cfam), NULL);
>> +
>> +    memory_region_init_io(&cfam->config_iomem, OBJECT(cfam), 
>> &cfam_config_ops,
>> +                          cfam, TYPE_FSI_CFAM, 0x400);
>> +
>> +    if (!object_property_set_bool(OBJECT(&cfam->lbus), "realized", 
>> true,
>> +                                  errp)) {
>> +        return;
>> +    }
>> +
>> +    memory_region_add_subregion(&cfam->mr, 0, &cfam->config_iomem);
>> +    memory_region_add_subregion(&cfam->mr, 0x800, &slave->iomem);
>> +    memory_region_add_subregion(&cfam->mr, 0xc00, &cfam->lbus.mr);
>> +
>> +    /* Add scratchpad engine */
>> +    lbus_create_device(&cfam->lbus, TYPE_FSI_SCRATCHPAD, 0);
>
> the scratchpad object should be realized here with 
> qdev_realize_and_unref()
> and its FSILBusDevice region mapped under lbus.mr at 0x0
ok, Thanks for the change.
>
>> +}
>> +
>> +static void fsi_cfam_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    dc->bus_type = TYPE_FSI_BUS;
>> +    dc->realize = fsi_cfam_realize;
>> +}
>> +
>> +static const TypeInfo fsi_cfam_info = {
>> +    .name = TYPE_FSI_CFAM,
>> +    .parent = TYPE_FSI_SLAVE,
>> +    .instance_size = sizeof(FSICFAMState),
>> +    .class_init = fsi_cfam_class_init,
>> +};
>
> Please add the scratchpad implementation here.

Thanks for the change.

Thanks for the review. I will update the commit message.

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
>
>> +static void fsi_cfam_register_types(void)
>> +{
>> +    type_register_static(&fsi_cfam_info);
>> +}
>> +
>> +type_init(fsi_cfam_register_types);
>> diff --git a/hw/fsi/fsi-slave.c b/hw/fsi/fsi-slave.c
>> new file mode 100644
>> index 0000000000..70386c0bb8
>> --- /dev/null
>> +++ b/hw/fsi/fsi-slave.c
>> @@ -0,0 +1,78 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (C) 2023 IBM Corp.
>> + *
>> + * IBM Flexible Service Interface slave
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +
>> +#include "qapi/error.h"
>> +#include "qemu/log.h"
>> +#include "trace.h"
>> +
>> +#include "hw/fsi/fsi-slave.h"
>> +#include "hw/fsi/fsi.h"
>> +
>> +#define TO_REG(x)                               ((x) >> 2)
>> +
>> +static uint64_t fsi_slave_read(void *opaque, hwaddr addr, unsigned 
>> size)
>> +{
>> +    FSISlaveState *s = FSI_SLAVE(opaque);
>> +
>> +    trace_fsi_slave_read(addr, size);
>> +
>> +    if (addr + size > sizeof(s->regs)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: Out of bounds read: 0x%"HWADDR_PRIx" for 
>> %u\n",
>> +                      __func__, addr, size);
>> +        return 0;
>> +    }
>> +
>> +    return s->regs[TO_REG(addr)];
>> +}
>> +
>> +static void fsi_slave_write(void *opaque, hwaddr addr, uint64_t data,
>> +                                 unsigned size)
>> +{
>> +    FSISlaveState *s = FSI_SLAVE(opaque);
>> +
>> +    trace_fsi_slave_write(addr, size, data);
>> +
>> +    if (addr + size > sizeof(s->regs)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: Out of bounds write: 0x%"HWADDR_PRIx" for 
>> %u\n",
>> +                      __func__, addr, size);
>> +        return;
>> +    }
>> +
>> +    s->regs[TO_REG(addr)] = data;
>> +}
>> +
>> +static const struct MemoryRegionOps fsi_slave_ops = {
>> +    .read = fsi_slave_read,
>> +    .write = fsi_slave_write,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +};
>> +
>> +static void fsi_slave_init(Object *o)
>> +{
>> +    FSISlaveState *s = FSI_SLAVE(o);
>> +
>> +    memory_region_init_io(&s->iomem, OBJECT(s), &fsi_slave_ops,
>> +                          s, TYPE_FSI_SLAVE, 0x400);
>> +}
>> +
>> +static const TypeInfo fsi_slave_info = {
>> +    .name = TYPE_FSI_SLAVE,
>> +    .parent = TYPE_DEVICE,
>> +    .instance_init = fsi_slave_init,
>> +    .instance_size = sizeof(FSISlaveState),
>> +};
>> +
>> +static void fsi_slave_register_types(void)
>> +{
>> +    type_register_static(&fsi_slave_info);
>> +}
>> +
>> +type_init(fsi_slave_register_types);
>> diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
>> index f7c7fd1b28..8d712e77ed 100644
>> --- a/hw/fsi/Kconfig
>> +++ b/hw/fsi/Kconfig
>> @@ -1,3 +1,12 @@
>> +config FSI_CFAM
>> +    bool
>> +    select FSI
>> +    select FSI_SCRATCHPAD
>> +    select FSI_LBUS
>> +
>> +config FSI
>> +    bool
>> +
>>   config FSI_SCRATCHPAD
>>       bool
>>       select FSI_LBUS
>> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
>> index d45a98c223..a9e7cd4099 100644
>> --- a/hw/fsi/meson.build
>> +++ b/hw/fsi/meson.build
>> @@ -1,2 +1,4 @@
>>   system_ss.add(when: 'CONFIG_FSI_LBUS', if_true: files('lbus.c'))
>>   system_ss.add(when: 'CONFIG_FSI_SCRATCHPAD', if_true: 
>> files('engine-scratchpad.c'))
>> +system_ss.add(when: 'CONFIG_FSI_CFAM', if_true: files('cfam.c'))
>> +system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi-slave.c'))
>> diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
>> index c5753e2791..b57b2dcc86 100644
>> --- a/hw/fsi/trace-events
>> +++ b/hw/fsi/trace-events
>> @@ -1,2 +1,9 @@
>>   fsi_scratchpad_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " 
>> size=%d"
>>   fsi_scratchpad_write(uint64_t addr, uint32_t size, uint64_t data) 
>> "@0x%" PRIx64 " size=%d value=0x%"PRIx64
>> +fsi_cfam_config_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " 
>> size=%d"
>> +fsi_cfam_config_write(uint64_t addr, uint32_t size, uint64_t data) 
>> "@0x%" PRIx64 " size=%d value=0x%"PRIx64
>> +fsi_cfam_unimplemented_read(uint64_t addr, uint32_t size) "@0x%" 
>> PRIx64 " size=%d"
>> +fsi_cfam_unimplemented_write(uint64_t addr, uint32_t size, uint64_t 
>> data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
>> +fsi_cfam_config_write_noaddr(uint64_t addr, uint32_t size, uint64_t 
>> data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
>> +fsi_slave_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
>> +fsi_slave_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" 
>> PRIx64 " size=%d value=0x%"PRIx64
>

