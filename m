Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DA47D1F90
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 22:34:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quIfJ-0007Kc-J6; Sat, 21 Oct 2023 16:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quIfB-0007JI-Ra; Sat, 21 Oct 2023 16:33:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quIf9-00044W-1H; Sat, 21 Oct 2023 16:33:37 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39LK9RUC021090; Sat, 21 Oct 2023 20:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=A8nGFtb9tefhtc+pmY9or/25LqRIfDjkJV2jSfq3oUk=;
 b=IVzRic+thYyAd8c9/WLi7o/iB4pm8F8qeI7UuZlfqocTc3fX4kk5RIASZJXCsl9gg9JX
 1LM4q9h70fA/Sdb0LyYTXnjQ0YFSc1NrjXi3aWfbmHeRMy4rChOHvxlLLC7wpzSoVkzW
 o13qyUKhR2UyuaxiEgc5DLXh0HiiFOwr/gA03dxk18q6iSl+DrPapjqe8gfEpD39W4yP
 sjXXbiVtpJqhNkCLFT/rLh0Hjrf3iBLn+bHaLe0yZUm7dtUNgw5TNTWId3GNknAhS986
 Gnhz8W8B5d4RH2SWiv3Uwl7mtOrA5zYW1DRhzL2Dh3N1ZZ9hPJ5A+iiWH6QAdzX1KPUb qA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvn4urk8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 20:33:20 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39LKS3aL028457;
 Sat, 21 Oct 2023 20:33:19 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvn4urk8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 20:33:19 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39LH9pqY029775; Sat, 21 Oct 2023 20:33:18 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tuc47w6s3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 20:33:18 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39LKXHhG15860422
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 21 Oct 2023 20:33:18 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDB9658055;
 Sat, 21 Oct 2023 20:33:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A33158043;
 Sat, 21 Oct 2023 20:33:16 +0000 (GMT)
Received: from [9.67.95.215] (unknown [9.67.95.215])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 21 Oct 2023 20:33:16 +0000 (GMT)
Message-ID: <fb69da2d-0ab3-4140-ba5a-14faa3f9d26d@linux.ibm.com>
Date: Sat, 21 Oct 2023 15:33:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] hw/fsi: Introduce IBM's cfam,fsi-slave
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@aj.id.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20231011151339.2782132-1-ninad@linux.ibm.com>
 <20231011151339.2782132-4-ninad@linux.ibm.com>
 <dba44bbc-cc5a-4fc7-a7a9-fb9b720bd9f0@kaod.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <dba44bbc-cc5a-4fc7-a7a9-fb9b720bd9f0@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k6qLFHwLMK0DYXSm6EQfugLyhNSh56t2
X-Proofpoint-ORIG-GUID: a8nslujOdROqiw-yHZn0UWZDgKKjU2wB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-21_12,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 clxscore=1015 mlxscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310210188
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

On 10/19/23 03:00, Cédric Le Goater wrote:
> On 10/11/23 17:13, Ninad Palsule wrote:
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
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>> v2:
>> - Incorporated Joel's review comments.
>> v3:
>> - Incorporated Thomas Huth's review comments.
>> v5:
>> - Incorporated review comments by Cedric.
>> ---
>>   include/hw/fsi/cfam.h      |  58 ++++++++++
>>   include/hw/fsi/fsi-slave.h |  29 +++++
>>   hw/fsi/cfam.c              | 220 +++++++++++++++++++++++++++++++++++++
>>   hw/fsi/fsi-slave.c         |  96 ++++++++++++++++
>>   hw/fsi/Kconfig             |   9 ++
>>   hw/fsi/meson.build         |   2 +
>>   hw/fsi/trace-events        |   7 ++
>>   7 files changed, 421 insertions(+)
>>   create mode 100644 include/hw/fsi/cfam.h
>>   create mode 100644 include/hw/fsi/fsi-slave.h
>>   create mode 100644 hw/fsi/cfam.c
>>   create mode 100644 hw/fsi/fsi-slave.c
>>
>> diff --git a/include/hw/fsi/cfam.h b/include/hw/fsi/cfam.h
>> new file mode 100644
>> index 0000000000..a828fd931e
>> --- /dev/null
>> +++ b/include/hw/fsi/cfam.h
>> @@ -0,0 +1,58 @@
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
>> +
>> +#define TYPE_CFAM "cfam"
>> +#define CFAM(obj) OBJECT_CHECK(CFAMState, (obj), TYPE_CFAM)
>> +
>> +#define CFAM_NR_REGS ((0x2e0 >> 2) + 1)
>> +
>> +#define TYPE_CFAM_CONFIG "cfam.config"
>> +OBJECT_DECLARE_SIMPLE_TYPE(CFAMConfig, CFAM_CONFIG)
>> +
>> +/* P9-ism */
>> +#define CFAM_CONFIG_NR_REGS 0x28
>> +
>> +typedef struct CFAMState CFAMState;
>> +
>> +/* TODO: Generalise this accommodate different CFAM configurations */
>> +typedef struct CFAMConfig {
>> +    DeviceState parent;
>> +
>> +    MemoryRegion iomem;
>> +} CFAMConfig;
>> +
>> +#define TYPE_CFAM_PEEK "cfam.peek"
>> +OBJECT_DECLARE_SIMPLE_TYPE(CFAMPeek, CFAM_PEEK)
>> +#define CFAM_PEEK_NR_REGS ((0x130 >> 2) + 1)
>> +
>> +typedef struct CFAMPeek {
>> +    DeviceState parent;
>> +
>> +    MemoryRegion iomem;
>> +} CFAMPeek;
>> +
>> +struct CFAMState {
>> +    /* < private > */
>> +    FSISlaveState parent;
>> +
>> +    MemoryRegion mr;
>> +    AddressSpace as;
>> +
>> +    CFAMConfig config;
>> +    CFAMPeek peek;
>> +
>> +    FSILBus lbus;
>> +};
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
>> diff --git a/hw/fsi/cfam.c b/hw/fsi/cfam.c
>> new file mode 100644
>> index 0000000000..9044cc741b
>> --- /dev/null
>> +++ b/hw/fsi/cfam.c
>> @@ -0,0 +1,220 @@
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
>> +#include "hw/fsi/bits.h"
>> +#include "hw/fsi/cfam.h"
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
>> +static uint64_t cfam_config_read(void *opaque, hwaddr addr, unsigned 
>> size)
>> +{
>> +    CFAMConfig *config;
>> +    CFAMState *cfam;
>> +    FSILBusNode *node;
>> +    int i;
>> +
>> +    config = CFAM_CONFIG(opaque);
>> +    cfam = container_of(config, CFAMState, config);
>> +
>> +    trace_cfam_config_read(addr, size);
>> +
>> +    switch (addr) {
>> +    case 0x00:
>> +        return CFAM_CONFIG_CHIP_ID_P9;
>> +    case 0x04:
>> +        return ENGINE_CONFIG_NEXT
>> +            | 0x00010000                    /* slots */
>> +            | 0x00001000                    /* version */
>> +            | ENGINE_CONFIG_TYPE_PEEK   /* type */
>> +            | 0x0000000c;                   /* crc */
>> +    case 0x08:
>> +        return ENGINE_CONFIG_NEXT
>> +            | 0x00010000                    /* slots */
>> +            | 0x00005000                    /* version */
>> +            | ENGINE_CONFIG_TYPE_FSI    /* type */
>> +            | 0x0000000a;                   /* crc */
>> +        break;
>> +    default:
>> +        /* FIXME: Improve this */
>> +        i = 0xc;
>> +        QLIST_FOREACH(node, &cfam->lbus.devices, next) {
>> +            if (i == addr) {
>> +                return FSI_LBUS_DEVICE_GET_CLASS(node->ldev)->config;
>> +            }
>> +            i += size;
>> +        }
>
> Please use qbus_walk_children() and drop the devices list.
Yes, removed the list and using children list of the BusState.
>
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
>> +static void cfam_config_write(void *opaque, hwaddr addr, uint64_t data,
>> +                                 unsigned size)
>> +{
>> +    CFAMConfig *s = CFAM_CONFIG(opaque);
>> +
>> +    trace_cfam_config_write(addr, size, data);
>> +
>> +    switch (TO_REG(addr)) {
>> +    case CFAM_CONFIG_CHIP_ID:
>> +    case CFAM_CONFIG_CHIP_ID + 4:
>> +        if (data == CFAM_CONFIG_CHIP_ID_BREAK) {
>> +            bus_cold_reset(qdev_get_parent_bus(DEVICE(s)));
>> +        }
>> +    break;
>> +    default:
>> +        trace_cfam_config_write_noaddr(addr, size, data);
>> +    }
>> +}
>> +
>> +static const struct MemoryRegionOps cfam_config_ops = {
>> +    .read = cfam_config_read,
>> +    .write = cfam_config_write,
>> +    .valid.max_access_size = 4,
>> +    .valid.min_access_size = 4,
>> +    .impl.max_access_size = 4,
>> +    .impl.min_access_size = 4,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +};
>> +
>> +static void cfam_config_realize(DeviceState *dev, Error **errp)
>> +{
>> +    CFAMConfig *s = CFAM_CONFIG(dev);
>> +
>> +    memory_region_init_io(&s->iomem, OBJECT(s), &cfam_config_ops, s,
>> +                          TYPE_CFAM_CONFIG, 0x400);
>> +}
>> +
>> +static void cfam_config_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    dc->bus_type = TYPE_FSI_LBUS;
>> +    dc->realize = cfam_config_realize;
>> +}
>> +
>> +static const TypeInfo cfam_config_info = {
>> +    .name = TYPE_CFAM_CONFIG,
>> +    .parent = TYPE_DEVICE,
>> +    .instance_size = sizeof(CFAMConfig),
>> +    .class_init = cfam_config_class_init,
>> +};
>
> Please drop the TYPE_CFAM_CONFIG object and move the config MMIO
> under the CFAM object. It will simplify the model.
Good suggestion. Fixed as per your suggestion.
>
>> +
>> +static uint64_t cfam_unimplemented_read(void *opaque, hwaddr addr,
>> +                                        unsigned size)
>> +{
>> +    trace_cfam_unimplemented_read(addr, size);
>> +
>> +    return 0;
>> +}
>> +
>> +static void cfam_unimplemented_write(void *opaque, hwaddr addr, 
>> uint64_t data,
>> +                                     unsigned size)
>> +{
>> +    trace_cfam_unimplemented_write(addr, size, data);
>> +}
>> +
>> +static const struct MemoryRegionOps cfam_unimplemented_ops = {
>> +    .read = cfam_unimplemented_read,
>> +    .write = cfam_unimplemented_write,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +};
>
> Is it possible to use create_unimplemented_device() ?
I don't think as this is used for the mmio.
>
>> +static void cfam_realize(DeviceState *dev, Error **errp)
>> +{
>> +    CFAMState *cfam = CFAM(dev);
>> +    FSISlaveState *slave = FSI_SLAVE(dev);
>> +    Error *err = NULL;
>> +
>> +    /* Each slave has a 2MiB address space */
>> +    memory_region_init_io(&cfam->mr, OBJECT(cfam), 
>> &cfam_unimplemented_ops,
>> +                          cfam, TYPE_CFAM, 2 * 1024 * 1024);
>> +    address_space_init(&cfam->as, &cfam->mr, TYPE_CFAM);
>> +
>> +    qbus_init(&cfam->lbus, sizeof(cfam->lbus), TYPE_FSI_LBUS,
>> +                        DEVICE(cfam), NULL);
>> +
>> +    lbus_create_device(&cfam->lbus, TYPE_SCRATCHPAD, 0);
>> +
>> +    object_property_set_bool(OBJECT(&cfam->config), "realized", 
>> true, &err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>> +    qdev_set_parent_bus(DEVICE(&cfam->config), BUS(&cfam->lbus), 
>> &error_abort);
>> +
>> +    object_property_set_bool(OBJECT(&cfam->lbus), "realized", true, 
>> &err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>> +
>> +    memory_region_add_subregion(&cfam->mr, 0, &cfam->config.iomem);
>> +    /* memory_region_add_subregion(&cfam->mr, 0x800, 
>> &cfam->lbus.peek.iomem); */
>> +    memory_region_add_subregion(&cfam->mr, 0x800, &slave->iomem);
>> +    memory_region_add_subregion(&cfam->mr, 0xc00, &cfam->lbus.mr);
>> +}
>> +
>> +static void cfam_init(Object *o)
>> +{
>> +    CFAMState *s = CFAM(o);
>> +
>> +    object_initialize_child(o, TYPE_CFAM_CONFIG, &s->config, 
>> TYPE_CFAM_CONFIG);
>> +}
>> +
>> +static void cfam_finalize(Object *o)
>> +{
>> +    CFAMState *s = CFAM(o);
>> +
>> +    address_space_destroy(&s->as);
>> +}
>
> finalize only really needed for hotpluggable devices.

Removed.

Thanks for the review.

Regards,

Ninad

>
>> +
>> +static void cfam_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    dc->bus_type = TYPE_FSI_BUS;
>> +    dc->realize = cfam_realize;
>> +}
>> +
>> +static const TypeInfo cfam_info = {
>> +    .name = TYPE_CFAM,
>> +    .parent = TYPE_FSI_SLAVE,
>> +    .instance_init = cfam_init,
>> +    .instance_finalize = cfam_finalize,
>> +    .instance_size = sizeof(CFAMState),
>> +    .class_init = cfam_class_init,
>> +};
>> +
>> +static void cfam_register_types(void)
>> +{
>> +    type_register_static(&cfam_config_info);
>> +    type_register_static(&cfam_info);
>> +}
>> +
>> +type_init(cfam_register_types);
>> diff --git a/hw/fsi/fsi-slave.c b/hw/fsi/fsi-slave.c
>> new file mode 100644
>> index 0000000000..127fdd8a4f
>> --- /dev/null
>> +++ b/hw/fsi/fsi-slave.c
>> @@ -0,0 +1,96 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (C) 2023 IBM Corp.
>> + *
>> + * IBM Flexible Service Interface slave
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +
>> +#include "qemu/bitops.h"
>> +#include "qapi/error.h"
>> +#include "qemu/log.h"
>> +#include "trace.h"
>> +
>> +#include "hw/fsi/fsi-slave.h"
>> +
>> +#define TO_REG(x)                               ((x) >> 2)
>> +
>> +#define FSI_SMODE               TO_REG(0x00)
>> +#define   FSI_SMODE_WSTART      BE_BIT(0)
>> +#define   FSI_SMODE_AUX_EN      BE_BIT(1)
>> +#define   FSI_SMODE_SLAVE_ID    BE_GENMASK(6, 7)
>> +#define   FSI_SMODE_ECHO_DELAY  BE_GENMASK(8, 11)
>> +#define   FSI_SMODE_SEND_DELAY  BE_GENMASK(12, 15)
>> +#define   FSI_SMODE_LBUS_DIV    BE_GENMASK(20, 23)
>> +#define   FSI_SMODE_BRIEF_LEFT  BE_GENMASK(24, 27)
>> +#define   FSI_SMODE_BRIEF_RIGHT BE_GENMASK(28, 31)
>> +
>> +#define FSI_SDMA                TO_REG(0x04)
>> +#define FSI_SISC                TO_REG(0x08)
>> +#define FSI_SCISC               TO_REG(0x08)
>> +#define FSI_SISM                TO_REG(0x0c)
>> +#define FSI_SISS                TO_REG(0x10)
>> +#define FSI_SSISM               TO_REG(0x10)
>> +#define FSI_SCISM               TO_REG(0x14)
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
>> index 97fd070354..752a5683a0 100644
>> --- a/hw/fsi/trace-events
>> +++ b/hw/fsi/trace-events
>> @@ -1,2 +1,9 @@
>>   scratchpad_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
>>   scratchpad_write(uint64_t addr, uint32_t size, uint64_t data) 
>> "@0x%" PRIx64 " size=%d value=0x%"PRIx64
>> +cfam_config_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
>> +cfam_config_write(uint64_t addr, uint32_t size, uint64_t data) 
>> "@0x%" PRIx64 " size=%d value=0x%"PRIx64
>> +cfam_unimplemented_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 
>> " size=%d"
>> +cfam_unimplemented_write(uint64_t addr, uint32_t size, uint64_t 
>> data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
>> +cfam_config_write_noaddr(uint64_t addr, uint32_t size, uint64_t 
>> data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
>> +fsi_slave_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
>> +fsi_slave_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" 
>> PRIx64 " size=%d value=0x%"PRIx64
>

